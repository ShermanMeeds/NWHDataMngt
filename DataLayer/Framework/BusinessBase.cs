using System;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;
using System.Diagnostics;
using System.Reflection;

namespace DataLayer.Framework
{
  /// <summary>
  /// This is the base class for all editable business objects.  It supports all common object binding
  /// interfaces necessary to support usage in a BindingList context.
  /// </summary>
  /// <typeparam name="T">The type of object that this is.  Must be a descendant of BusinessBase.</typeparam>
  [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Portability", "CA1903:UseOnlyApiFromTargetedFramework", MessageId = "System.ComponentModel.INotifyPropertyChanging")]
  public abstract class BusinessBase<T> :
    INotifyPropertyChanging, INotifyPropertyChanged, IDataErrorInfo, IEditableObject, IBusinessObject
    where T : BusinessBase<T>
  {
    #region Property Management

    private static ITableSchema _schema = null;

    /// <summary>
    /// Gets the TableSchema for this type of object.  This is an instance method to satisfy
    /// the IBusinessObject interface.
    /// </summary>
    /// <returns>A TableSchema for the current type of business object.</returns>
    public ITableSchema GetSchema() { return Schema; }

    /// <summary>
    /// Gets the TableSchema for this type of object.  The schema will be
    /// created the first time that it is required.
    /// </summary>
    /// <remarks>The table schema is generated from the implemented BusinessBase
    /// type using reflection to extract the TableAttribute and ColumnAttribute
    /// attributes.</remarks>
    /// <value>A TableSchema for current type of business object.</value>
    [Browsable(false)]
    public static ITableSchema Schema
    {
      get
      {
        if (_schema == null) { _schema = Framework.TableSchema<T>.GetSchema(); }
        return _schema;
      }
    }

    /// <summary>
    /// Helper method that handles the necessary logic when changing the value of an editable
    /// property.
    /// </summary>
    /// <typeparam name="P">The data type of the property.</typeparam>
    /// <param name="propertyName">The name of the property.</param>
    /// <param name="currentValue">A reference to the current value of the property.  This
    /// value will be updated to the new value.</param>
    /// <param name="newValue">The new value of the property.</param>
    /// <returns>True if the value of the field changed, otherwise false.</returns>
    protected bool SetProperty<P>(string propertyName, ref P currentValue, P newValue)
    {
      // null == null for this function!
      // if (!currentValue.Equals(newValue))
      if (!object.Equals(currentValue, newValue))
      {
        OnPropertyChanging(propertyName, currentValue);
        currentValue = newValue;
        OnPropertyChanged(propertyName, newValue);
        return true;
      }
      return false;
    }

    /// <summary>
    /// Gets the type of items in the list.
    /// </summary>
    [Browsable(false)]
    public Type GetItemType { get { return typeof(T); } }

    #endregion

    #region State Management

    private bool _isDirty = false;
    private bool _isDeleted = false;
    private bool _isEditing = false;
    private bool _isNew = true;
    private bool _isChild = false;
    private bool _canAbandon = true;
    private bool _enableChangeTracking = true;

    /// <summary>
    /// Marks this object as a child object.
    /// </summary>
    protected void MarkAsChild() { _isChild = true; }

    /// <summary>
    /// Gets whether this object is a child object.
    /// </summary>
    /// <value>True if this is a child object.</value>
    protected internal bool IsChild { get { return _isChild; } }

    /// <summary>
    /// Returns true if this object is marked for deletion.
    /// </summary>
    /// <remarks>
    /// Items marked for deletion will be removed from the database
    /// as part of the next save operation.
    /// </remarks>
    /// <value>A value indicating if this object is marked for deletion.</value>
    [Browsable(false)]
    public bool IsDeleted { get { return _isDeleted; } }

    /// <summary>
    /// Gets whether any business rules have been broken
    /// </summary>
    [Browsable(false)]
    public virtual bool IsValid
    {
      get { return (_brokenrules == null ? true : _brokenrules.Count == 0); }
    }

    /// <summary>
    /// Returns true if edit mode is active (BeginEdit called)
    /// </summary>
    [Browsable(false)]
    public bool IsEditing { get { return _isEditing; } }

    /// <summary>
    /// Returns true if this is a new object, false if it is a pre-existing object.
    /// </summary>
    /// <remarks>
    /// An object is considered to be new if its primary identifying (key) value 
    /// doesn't correspond to data in the database. In other words, 
    /// if the data values in this particular object have not yet been saved to
    /// the database the object is considered to be new. Likewise, if the object's
    /// data has been deleted from the database then the object is considered
    /// to be new.
    /// </remarks>
    /// <value>A value indicating whether this object is new.</value>
    [Browsable(false)]
    public bool IsNew { get { return _isNew; } }

    /// <summary>
    /// Gets whether or not this object contains changes that need to 
    /// be persisted.
    /// </summary>
    /// <remarks>Can be overridden to provide more advanced logic, such
    /// as including the state of any child collections.</remarks>
    [Browsable(false)]
    public virtual bool IsDirty { get { return _isNew || _isDeleted || _isDirty; } }

    /// <summary>
    /// Forces the object's IsDirty flag to false.
    /// </summary>
    protected void MarkClean()
    {
      _isDirty = false;
      if (_editstore != null) { _editstore.Clear(); }
      //OnUnknownPropertyChanged();
    }

    /// <summary>
    /// Called when loading is complete on this object.  Clears the IsNew
    /// and IsDirty flags and empties the EditStore.
    /// </summary>
    protected void LoadComplete()
    {
      _isNew = false;
      _isDirty = false;
      if (_editstore != null) { _editstore.Clear(); }
    }

    /// <summary>
    /// Marks an object as being dirty, or changed.
    /// </summary>
    /// <remarks>This method should be called any time the 
    /// object's internal data changes.</remarks>
    protected void MarkDirty()
    {
      MarkDirty(false);
    }

    /// <summary>
    /// Marks an object as being dirty, or changed.
    /// </summary>
    /// <param name="supressEvent">True to suppress the PropertyChanged event.</param>
    protected void MarkDirty(bool supressEvent)
    {
      _isDirty = true;
      if (!supressEvent) { OnUnknownPropertyChanged(); }
    }

    /// <summary>
    /// Marks the object as being a new object.  This also marks the object as
    /// being dirty and ensures that it is not marked for deletion.
    /// </summary>
    /// <remarks>Newly created objects are marked new by default.</remarks>
    protected virtual void MarkNew()
    {
      _isNew = true;
      _isDeleted = false;
      MarkDirty(true);
    }

    /// <summary>
    /// Marks the object as being an old (not new) object.  This also marks
    /// the object as being unchanged (not dirty).
    /// </summary>
    /// <remarks>This method is should be called after after an item
    /// is successfully loaded from or saved to the database.</remarks>
    protected virtual void MarkOld()
    {
      _isNew = false;
      MarkClean();
    }

    /// <summary>
    /// Marks an object for deletion.  This also marks the object as being
    /// dirty.
    /// </summary>
    /// <remarks>You should call this method in your business logic in the
    /// case that you want to have the object deleted when it is saved to
    /// the database.</remarks>
    protected void MarkDeleted()
    {
      _isDeleted = true;
      MarkDirty(true);
    }

    /// <summary>
    /// Gets whether the object is both dirty and valid.  In other words, if is both needs
    /// to be saved and can be saved.
    /// </summary>
    /// <value>Whether the object is both valid and dirty.</value>
    [Browsable(false)]
    public virtual bool IsSavable { get { return (IsDirty && IsValid); } }

    #endregion

    #region Validation / Broken Rules

    private BrokenRules _brokenrules = null;

    /// <summary>
    /// Asserts a business condition.  This method updates the BrokenRules collection.
    /// </summary>
    /// <param name="columnName">The name of the column for this rule.</param>
    /// <param name="message">The message to display if this rule is broken.</param>
    /// <param name="isValid">Whether this rule is valid.</param>
    /// <remarks>Only one condition can be active at any one time
    /// for a single column.  Additional calls for the same column name
    /// will replace prior assertions.</remarks>
    public void AssertRule(string columnName, string message, bool isValid)
    {
      if (_brokenrules == null) { _brokenrules = new BrokenRules(); }
      if (!isValid) { _brokenrules.RuleBroken(columnName, message); }
      else { _brokenrules.RuleBroken(columnName, null); }
    }

    /// <summary>
    /// Assets a business condition, optionally raising the property changed event.
    /// </summary>
    /// <param name="columnName">The name of the column for this rule.</param>
    /// <param name="message">The message to display if this rule is broken.</param>
    /// <param name="isValid">Whether this rule is valid.</param>
    /// <param name="raisePropertyChanged">True to raise the property changed event.</param>
    public void AssertRule(string columnName, string message, bool isValid, bool raisePropertyChanged)
    {
      if (_brokenrules == null) { _brokenrules = new BrokenRules(); }
      if (!isValid) { _brokenrules.RuleBroken(columnName, message); }
      else { _brokenrules.RuleBroken(columnName, null); }
      if (raisePropertyChanged) { OnPropertyChanged(columnName); }
    }

    /// <summary>
    /// Clears the BrokenRules collection, making this object valid.
    /// </summary>
    protected void ClearBrokenRules()
    {
      if (_brokenrules == null) { return; }
      _brokenrules.Clear();
    }

    /// <summary>
    /// Provides access to the collection of broken business rules
    /// for this object.
    /// </summary>
    [Browsable(false)]
    public virtual BrokenRules BrokenRulesCollection
    {
      get { return _brokenrules; }
    }

    #endregion

    #region Edit Control

    private bool _autoSave = true;
    private FieldCache _editstore = null;

    /// <summary>
    /// Gets or sets whether to automatically apply edits in the database whenever
    /// an EndEdit is receiving from the binding source.
    /// </summary>
    /// <value>True to automatically save changes in the database whenever the binding
    /// source sends an EndEdit.</value>
    [EditorBrowsable(EditorBrowsableState.Advanced)]
    [Browsable(false)]
    public bool AutoSave
    {
      get { return _autoSave; }
      set { _autoSave = value; }
    }

    /// <summary>
    /// Enables change tracking for this object.
    /// </summary>
    [EditorBrowsable(EditorBrowsableState.Advanced)]
    protected internal void EnableChangeTracking() { _enableChangeTracking = true; }

    /// <summary>
    /// Disables change tracking for this object.  
    /// </summary>
    /// <remarks>WARNING: With change tracking disabled
    /// the object will not remember the original values when changes are made to
    /// properties!</remarks>
    [EditorBrowsable(EditorBrowsableState.Advanced)]
    protected internal void DisableChangeTracking() { _enableChangeTracking = false; }

    /// <summary>
    /// Provides access to the internal edited values cache.
    /// </summary>
    [EditorBrowsable(EditorBrowsableState.Advanced)]
    protected internal FieldCache EditStore { get { return _editstore; } }

    /// <summary>
    /// Called when the object needs to be deleted from the database.  The implementing
    /// class should override this to provide persistance.
    /// </summary>
    protected virtual void OnDataDelete() { }

    /// <summary>
    /// Called when the object needs to be inserted into the database.  The implementing
    /// class should override this to provide persistance.
    /// </summary>
    protected virtual void OnDataInsert() { }

    /// <summary>
    /// Called when the object needs to be updated in the database.  The implementing
    /// class should override this to provide persistance.
    /// </summary>
    protected virtual void OnDataUpdate() { }

    /// <summary>
    /// Called when editing begins on this object, either from data binding or by
    /// directly calling BeginEdit.
    /// </summary>
    /// <param name="store">The collection of changed field values.</param>
    /// <remarks>This method is not intended for persistance.  Only use this method to
    /// make any necessary changes to the current state of the object.</remarks>
    protected virtual void OnBeginEdit(FieldCache store) { }

    /// <summary>
    /// Called when editing is cancelled on this object, either from data binding or
    /// by directly calling CancelEdit.
    /// </summary>
    /// <param name="store">The collection of changed field values.</param>
    /// <remarks>This method is not intended for persistance.  Only use this method to
    /// make any necessary changes to the current state of the object.</remarks>
    protected virtual void OnCancelEdit(FieldCache store) { }

    /// <summary>
    /// Reverses any changes made to the specified field.
    /// </summary>
    /// <param name="field">The name of the field to undo.</param>
    public void UndoChanges(string field)
    {
      // If no fields have changed, return;
      if (_editstore == null) { return; }

      // If the specified field has not changed, return;
      if (!_editstore.IsFieldDirty(field)) { return; }
      FieldInfo item = _editstore[field];

      // Restore the original field value
      DisableChangeTracking();

      // Lookup schema object associated with changed data
      ColumnAttribute col;
      if (!Schema.Cols.TryGetValue(field, out col))
      {
        throw new Exception(string.Format("Unable to restore object state - missing column attribute for field {0}", field));
      }

      // use reflection to access field
      System.Reflection.FieldInfo finfo = typeof(T).GetField(col.Storage, BindingFlags.NonPublic | BindingFlags.Instance);
      if (finfo == null)
      {
        throw new Exception(string.Format("Unable to restore object state - storage field not found for field {0}", field));
      }

      // Restore value
      finfo.SetValue(this, item.OriginalValue);

      // Restore original brokenrules for this property.
      string pbr = _preBrokenRules[field];
      AssertRule(field, pbr, pbr.Length == 0);

      // Re-enable change tracking.
      EnableChangeTracking();
      OnPropertyChanged(field);
    }

    /// <summary>
    /// Reverses any changes made since the last BeginEdit call.
    /// </summary>
    /// <remarks>This method uses reflection to restore the original values from
    /// the edit store.  After cancelling the object is marked clean and the brokenrules
    /// collection is cleared.</remarks>
    public void UndoChanges()
    {
      if (_editstore == null) { _editstore = new FieldCache(); }

      // Restore changed values from edit store.  Use reflection to write directly
      // to local fields in implementing class.
      DisableChangeTracking();

      foreach (KeyValuePair<string, FieldInfo> item in _editstore)
      {
        // Lookup schema object associated with changed data
        ColumnAttribute col;
        if (!Schema.Cols.TryGetValue(item.Key, out col))
        {
          throw new Exception(string.Format("Unable to restore object state - missing column attribute for field {0}", item.Key));
        }

        // use reflection to access field
        System.Reflection.FieldInfo field = typeof(T).GetField(col.Storage, BindingFlags.NonPublic | BindingFlags.Instance);
        if (field == null)
        {
          throw new Exception(string.Format("Unable to restore object state - storage field not found for field {0}", item.Key));
        }

        // Restore value
        field.SetValue(this, item.Value.OriginalValue);
      }

      // Restore some key state vars.
      _brokenrules = _preBrokenRules;
      _isDeleted = _wasDeleted;

      EnableChangeTracking();
      OnUnknownPropertyChanged();
    }

    /// <summary>
    /// Called when editing is applied on this object, either from data binding or
    /// by directly calling ApplyEdit.
    /// </summary>
    /// <param name="store">The collection of changed field values.</param>
    /// <remarks>This method is not intended for persistance.  Only use this method to
    /// make any necessary changes to the current state of the object.</remarks>
    protected virtual void OnApplyEdit(FieldCache store) { }

    /// <summary>
    /// Called when the business object needs to be reloaded from the database.
    /// </summary>
    protected virtual void OnDataFetch() { }

    /// <summary>
    /// Reloads the object from the database.  Any changes will be lost and the object
    /// will be marked clean.  Does nothing for new items.
    /// </summary>
    public void ReLoad()
    {
      if (_isNew) { return; }
      OnDataFetch();
      MarkClean();
      OnUnknownPropertyChanged();
    }

    private bool _wasDeleted = false;
    private BrokenRules _preBrokenRules = null;

    /// <summary>
    /// Starts editing this object.
    /// </summary>
    public void BeginEdit()
    {
      // Save some key state variables
      if (!_isEditing)
      {
        _wasDeleted = _isDeleted;
        _preBrokenRules = BrokenRules.Clone(_brokenrules);
      }
      _isEditing = true;
      if (_editstore == null) { _editstore = new FieldCache(); }
      OnBeginEdit(_editstore);
    }

    /// <summary>
    /// Cancels the current edit process.
    /// </summary>
    /// <remarks>Calls OnCancelEdit to allow the implementing class a way 
    /// to restore its original values using the FieldCache.  This
    /// is probably possible using reflection - need to look into it.
    /// </remarks>
    public void CancelEdit()
    {
      if (_editstore == null) { _editstore = new FieldCache(); }
      OnCancelEdit(_editstore);
      UndoChanges();

      // Potential problem here - cancelling might not leave a clean item if item was new!
      MarkClean();
      _isEditing = false;
    }

    /// <summary>
    /// Commits the current edit process and saves the changes to
    /// the database.
    /// </summary>
    /// <remarks>Same as ApplyEdit.  This method is provided to support
    /// the required interface for inheriting classes.</remarks>
    protected void EndEdit()
    {
      //Debug.Print("BindingEndEdit");
      ApplyEdit();
      //_bindingEdit = false;
    }

    /// <summary>
    /// Commits the current edit process and saves the changes to
    /// the database.
    /// </summary>
    public void ApplyEdit()
    {
      if (_editstore == null) { _editstore = new FieldCache(); }
      OnApplyEdit(_editstore);
      
      // Note: Also invokes OnDataXXX methods to persist...
      AcceptChanges();

      _canAbandon = false;
      _isEditing = false;
    }

    private void AcceptChanges()
    {
      Save();
    }

    /// <summary>
    /// Saves changes to the database.
    /// </summary>
    public void Save()
    {
      if (_isNew)
      {
        if (!_isDeleted)
        {
          // Check validation rules
          if (!this.IsValid)
          {
            throw new ValidationException("Object is in an invalid state.  One or more business rules are broken.");
          }
          // New and not deleted, need to persist object
          OnDataInsert();
          MarkOld();
        }
      }
      else
      {
        if (_isDeleted)
        {
          // Delete of existing, need to persist object
          OnDataDelete();
          MarkNew();
          if (_editstore != null) { _editstore.Clear(); }
        }
        else
        {
          if (_isDirty)
          {
            // Check validation rules
            if (!this.IsValid)
            {
              throw new ValidationException("Object is in an invalid state.  One or more business rules are broken.");
            }
            // Update existing, row is dirty, need to persist object
            OnDataUpdate();
            MarkOld();
          }
        }
      }
    }

    /// <summary>
    /// Marks the current record for deletion.
    /// </summary>
    public void Delete()
    {
      MarkDeleted(); 
    }

    /// <summary>
    /// Clears the deletion flag for the current record
    /// </summary>
    public void UnDelete()
    {
      _isDeleted = false;
      // Also mark clean if no fields are dirty
      if (!_isNew && _editstore.Count == 0) { MarkClean(); }
    }

    #endregion

    #region Parent/Child Link

    private IBusinessList _parent;

    /// <summary>
    /// Used by BusinessListBase as a child is created to tell the child
    /// about its parent.
    /// </summary>
    /// <param name="parent">A reference to the parent object collection.</param>
    protected internal void SetParent(IBusinessList parent)
    {
      _parent = parent;
    }

    /// <summary>
    /// Provides access to the parent object for use in child object code.
    /// </summary>
    [EditorBrowsable(EditorBrowsableState.Advanced)]
    protected internal IBusinessList Parent { get { return _parent; } }

    #endregion

    #region INotifyPropertyChanging Members

    /// <summary>
    /// Occurs when a property value is changing.
    /// </summary>
    [event:System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Portability", "CA1903:UseOnlyApiFromTargetedFramework", MessageId = "System.ComponentModel.PropertyChangingEventHandler")]
    public event PropertyChangingEventHandler PropertyChanging;

    /// <summary>
    /// Call this method to raise the property changing event for a specific property
    /// and to update the EditStore with the original value of the property.
    /// </summary>
    /// <param name="propertyName">The name of the property that is changing.</param>
    /// <param name="currentValue">The current value.</param>
    /// <remarks>This version of the OnPropertyChanging method should be used for
    /// any field that might need to be undone if an edit is cancelled.</remarks>
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Portability", "CA1903:UseOnlyApiFromTargetedFramework", MessageId = "System.ComponentModel.PropertyChangingEventHandler"), System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Portability", "CA1903:UseOnlyApiFromTargetedFramework", MessageId = "System.ComponentModel.PropertyChangingEventArgs"), EditorBrowsable(EditorBrowsableState.Advanced)]
    protected void OnPropertyChanging(string propertyName, object currentValue)
    {
      //Debug.Print(string.Format("OnPropertyChanging, property={0}, currentvalue={1}", propertyName, currentValue));
      if (PropertyChanging != null) { PropertyChanging(this, new PropertyChangingEventArgs(propertyName)); }
      if (!_enableChangeTracking) { return; }
      if (_editstore == null) { _editstore = new FieldCache(); }
      _editstore.FieldChanging(propertyName, currentValue);
    }

    /// <summary>
    /// Call this method to raise the property changing event for a specific property.
    /// </summary>
    /// <param name="propertyName">The name of the property that is changing.</param>
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Portability", "CA1903:UseOnlyApiFromTargetedFramework", MessageId = "System.ComponentModel.PropertyChangingEventHandler"), System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Portability", "CA1903:UseOnlyApiFromTargetedFramework", MessageId = "System.ComponentModel.PropertyChangingEventArgs"), EditorBrowsable(EditorBrowsableState.Advanced)]
    protected void OnPropertyChanging(string propertyName)
    {
      //Debug.Print(string.Format("OnPropertyChanging, property={0}", propertyName));
      if (PropertyChanging != null) { PropertyChanging(this, new PropertyChangingEventArgs(propertyName)); }
    }

    /// <summary>
    /// Raises the property changing event for all object properties.
    /// </summary>
    [EditorBrowsable(EditorBrowsableState.Advanced)]
    protected virtual void OnUnknownPropertyChanging() { OnPropertyChanging(string.Empty); }

    #endregion

    #region INotifyPropertyChanged Members

    /// <summary>
    /// Occurs when a property value changes.
    /// </summary>
    public event PropertyChangedEventHandler PropertyChanged;

    /// <summary>
    /// Call this method to raise the property changed event for a specific property
    /// and to update the EditStore with the new value of the property.
    /// </summary>
    /// <param name="propertyName">The name of the property that changed.</param>
    /// <param name="newValue">The new value.</param>
    /// <remarks>This version of the OnPropertyChanged method should be used for
    /// any field that might need to be undone if an edit is cancelled.</remarks>
    [EditorBrowsable(EditorBrowsableState.Advanced)]
    private void OnPropertyChanged(string propertyName, object newValue)
    {
      _isDirty = true;
      if (_enableChangeTracking)
      {
        if (_editstore == null) { _editstore = new FieldCache(); }
        _editstore.FieldChanged(propertyName, newValue);
      }
      //Debug.Print(string.Format("OnPropertyChanged, property={0}, newvalue={1}", propertyName, newValue));
      if (PropertyChanged != null) { PropertyChanged(this, new PropertyChangedEventArgs(propertyName)); }
      //OnPropertyChanged(propertyName);
    }

    /// <summary>
    /// Call this method to raise the property changed event for a specific property.
    /// </summary>
    /// <param name="propertyName">The name of the property that changed.</param>
    [EditorBrowsable(EditorBrowsableState.Advanced)]
    protected void OnPropertyChanged(string propertyName)
    {
      //Debug.Print(string.Format("OnPropertyChanged, property={0}", propertyName));
      if (PropertyChanged != null) { PropertyChanged(this, new PropertyChangedEventArgs(propertyName)); }
    }

    /// <summary>
    /// Raises the property changed event for all object properties.
    /// </summary>
    /// <remarks>This method is automatically called by MarkDirty()</remarks>
    [EditorBrowsable(EditorBrowsableState.Advanced)]
    protected virtual void OnUnknownPropertyChanged() { OnPropertyChanged(string.Empty); }

    #endregion

    #region IDataErrorInfo Members

    /// <summary>
    /// Returns the text of all broken rules for the object.  Used for the row-level
    /// DataError icon.
    /// </summary>
    [Browsable(false)]
    protected string Error
    {
      get
      {
        //Debug.Print("Error");
        if (_brokenrules == null) { return string.Empty; }
        return _brokenrules.ToString();
      }
    }

    /// <summary>
    /// Gets the text of any broken rules associated with the specified
    /// column.
    /// </summary>
    /// <param name="columnName">The column to check.</param>
    /// <returns>The text of any broken rules for the specified column.</returns>
    protected string this[string columnName]
    {
      get
      {
        //Debug.Print(string.Format("this, columnName={0}", columnName));
        if (_brokenrules == null) { return string.Empty; }
        return _brokenrules[columnName];
      }
    }

    /// <summary>
    /// Returns the text of all broken rules for the object.  Used for the row-level
    /// DataError icon.
    /// </summary>
    [Browsable(false)]
    string IDataErrorInfo.Error { get { return this.Error; } }

    /// <summary>
    /// Gets the text of any broken rules associated with the specified
    /// column.
    /// </summary>
    /// <param name="columnName">The column to check.</param>
    /// <returns>The text of any broken rules for the specified column.</returns>
    string IDataErrorInfo.this[string columnName] { get { return this[columnName]; } }

    #endregion

    #region IEditableObject Members

    /// <summary>
    /// Allow data binding to start a cancelable edit on the object.
    /// </summary>
    /// <remarks>Data binding may call this method many times.  Only the first
    /// call should be honored.</remarks>
    void System.ComponentModel.IEditableObject.BeginEdit()
    {
      if (!_isEditing) { BeginEdit(); }
    }

    /// <summary>
    /// Allow data binding to cancel the current edit.
    /// </summary>
    /// <remarks>Data binding may call this method many times.  Only the first
    /// call to CancelEdit or EndEdit should be honored.</remarks>
    void System.ComponentModel.IEditableObject.CancelEdit()
    {
      if (_isEditing)
      {
        CancelEdit();
        if (_isNew && _canAbandon)
        {
          // New object and no EndEdit or ApplyEdit has ever been
          // called.  Ask to be removed from the parent collection.
          if (_parent != null) { _parent.RemoveChild(this); }
        }
        //_bindingEdit = false;
      }
    }

    /// <summary>
    /// Allow data binding to apply the current edit
    /// </summary>
    /// <remarks>Data binding may call this method many times.  Only the first
    /// call to CancelEdit or EndEdit should be honored.</remarks>
    void System.ComponentModel.IEditableObject.EndEdit()
    {
      if (_autoSave && _isEditing)
      {
        this.EndEdit();
      }
    }

    #endregion

    #region IBusinessObject Members

    void IBusinessObject.SetParent(IBusinessList parent) { this.SetParent(parent); }
    void IBusinessObject.Delete() { this.Delete(); }
    void IBusinessObject.UnDelete() { this.UnDelete(); }
    void IBusinessObject.ApplyEdit() { this.ApplyEdit(); }
    void IBusinessObject.ReLoad() { this.ReLoad(); }
    object IBusinessObject.GetIdValue() { return GetIdValue(); }

    #endregion

    #region Overrides

    /// <summary>
    /// Gets an id that uniquely identifies the business object.
    /// </summary>
    /// <returns>An object the uniquely identifies the business object.</returns>
    public abstract object GetIdValue();

    /// <summary>
    /// Returns a value indicating whether this instance is equal to a specified object.
    /// </summary>
    /// <param name="obj">An object to compare with this instance, or null.</param>
    /// <returns>True if obj is a business object of type T and the id values match; otherwise, false.</returns>
    public override bool Equals(object obj)
    {
      if (obj is T)
      {
        object id = GetIdValue();
        if (id == null)
        {
          Debug.Assert(true, "Id Value cannot be null");
          return false;
        }
        return ((T)obj).GetIdValue().Equals(id);
      }
      else
        return false;
    }

    /// <summary>
    /// Returns the hash code for this instance.
    /// </summary>
    /// <returns>The 32-bit signed integer hash code of the id value for this instance.</returns>
    public override int GetHashCode()
    {
      object id = GetIdValue();
      if (id == null)
      {
        Debug.Assert(true, "Id Value cannot be null");
        return 0;
      }
      return id.GetHashCode();
    }

    /// <summary>
    /// Returns a string representation of the id value for this instance.
    /// </summary>
    /// <returns>A string representatoin of the id value of this instance.</returns>
    public override string ToString()
    {
      object id = GetIdValue();
      if (id == null)
      {
        Debug.Assert(true, "Id Value cannot be null");
        return null;
      }
      return id.ToString();
    }

    #endregion

    #region Reflection / Special Methods

    /// <summary>
    /// Returns the current value of the specified field.
    /// </summary>
    /// <param name="field">The field to get the value for.</param>
    /// <returns>The current value of the field.</returns>
    public object GetValue(string field)
    {
      PropertyInfo pi = typeof(T).GetProperty(field);
      if (pi != null) { return pi.GetValue(this, null); }
      return null;
    }

    /// <summary>
    /// Sets the specified field to the specified value.  All normal business 
    /// and validation rules will be applied.
    /// </summary>
    /// <param name="field">The field to set.</param>
    /// <param name="value">The value to set the field to.</param>
    public void SetValue(string field, object value)
    {
      PropertyInfo pi = typeof(T).GetProperty(field);
      if (pi != null) { pi.SetValue(this, value, null); }
    }

    /// <summary>
    /// Gets the original value of the specified field.  This is the value that was
    /// last loaded from or saved to the database.
    /// </summary>
    /// <param name="field">The field to get the original value for.</param>
    /// <returns>The original loaded/saved value of the specified field.</returns>
    public object GetOriginalValue(string field)
    {
      object currentvalue = GetValue(field);
      if (_editstore == null) { return currentvalue; }
      return _editstore.GetOriginalValue(field, currentvalue);
    }

    /// <summary>
    /// Gets whether the specified field has unsaved changes.
    /// </summary>
    /// <param name="field">The field to check.</param>
    /// <returns>True if the specified field has unsaved changes; otherwise false.</returns>
    public bool IsFieldDirty(string field)
    {
      if (_isNew)
      {
        // If new record, any non-null field is dirty.
        object currentvalue = GetValue(field);
        if (currentvalue!=null) { return true;}
      }

      // For non-new records, or a new record with a non-null field value,
      // field is dirty only if it is in the edit store.
      if (_editstore == null) { return false; }
      return _editstore.ContainsKey(field);
    }

    #endregion
  }
}
