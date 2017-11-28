using System;
using System.Collections.Generic;
using System.Text;

namespace DataLayer.Framework
{
  /// <summary>
  /// Defines the common methods that must be implemented by all editable
  /// business objects.
  /// </summary>
  public interface IBusinessObject
  {
    /// <summary>
    /// Used by BusinessListBase as a child is created to tell the child
    /// about its parent.
    /// </summary>
    /// <param name="parent">A reference to the parent object collection.</param>
    void SetParent(IBusinessList parent);

    /// <summary>
    /// Marks the object for deletion.  The object will be deleted as part of the
    /// next save operation.
    /// </summary>
    void Delete();

    /// <summary>
    /// Clears the deletion flag for the object.
    /// </summary>
    void UnDelete();

    /// <summary>
    /// Starts editing this object.
    /// </summary>
    void BeginEdit();

    /// <summary>
    /// Cancels the current edit process.
    /// </summary>
    void CancelEdit();

    /// <summary>
    /// Commits the current edit process and saves the changes to
    /// the database.
    /// </summary>
    void ApplyEdit();

    /// <summary>
    /// Gets whether any business rules have been broken
    /// </summary>
    bool IsValid { get; }

    /// <summary>
    /// Gets whether or not this object contains changes that need to 
    /// be persisted.
    /// </summary>
    bool IsDirty { get; }

    /// <summary>
    /// Returns true if this object is marked for deletion.
    /// </summary>
    bool IsDeleted { get; }

    /// <summary>
    /// Returns true if this is a new object, false if it is a pre-existing object.
    /// </summary>
    bool IsNew { get; }

    /// <summary>
    /// Reloads the current item from the database.  Any pending changes will be lost.
    /// Command ignored for new records.
    /// </summary>
    void ReLoad();

    /// <summary>
    /// Gets an id value that uniquely identifies the object.
    /// </summary>
    /// <returns>An object that uniquely identifies the business object.</returns>
    object GetIdValue();

    /// <summary>
    /// Gets the type of items in the list.
    /// </summary>
    Type GetItemType { get; }

    /// <summary>
    /// Returns the current value of the specified field.
    /// </summary>
    /// <param name="field">The name of the field to get the value for.</param>
    /// <returns>The current value of the field, or null if the field is not found.</returns>
    /// <remarks>The current value of a field may not have been saved yet, and as a consequence
    /// may be invalid.  Use the GetOriginalValue method to get the last persisted value.</remarks>
    object GetValue(string field);

    /// <summary>
    /// Sets the specified field to the specified value.
    /// </summary>
    /// <param name="field">The field to set the value for.</param>
    /// <param name="value">The new value for the field.</param>
    /// <remarks>All normal business and validation rules apply.  If the field is not found
    /// then nothing will happen.  This will make the field, and the object, dirty.</remarks>
    void SetValue(string field, object value);

    /// <summary>
    /// Returns whether the specified field has unsaved changes.
    /// </summary>
    /// <param name="field">The field to check.</param>
    /// <returns>True if the field has unsaved changes; otherwise false.</returns>
    /// <remarks>The logic to determine whether a field is dirty changes slighly depending
    /// on whether the record is new or not.  For new records, a field is considered
    /// dirty if it assigned a non-null default value, or if the value has changed.  For
    /// non-new fields, they are only considered dirty if the value has changed.</remarks>
    bool IsFieldDirty(string field);

    /// <summary>
    /// Returns the original value of the specified field.  
    /// </summary>
    /// <param name="field">The name of the field to get the value for.</param>
    /// <returns>The original, last persisted value for the field.</returns>
    /// <remarks>The original value is defined as the last persisted value that was either
    /// loaded from or saved to the database.</remarks>
    object GetOriginalValue(string field);

    /// <summary>
    /// Reverts a business object back to the last saved state.
    /// </summary>
    void UndoChanges();

    /// <summary>
    /// Reverts the specified field back to the last saved state.  Does nothing if the
    /// field has not been changed.
    /// </summary>
    /// <param name="field">The name of the field to undo.</param>
    void UndoChanges(string field);

    /// <summary>
    /// Gets a table schema for the current type of business object.
    /// </summary>
    /// <returns>An ITableSchema for the current type of business object.</returns>
    ITableSchema GetSchema();

    /// <summary>
    /// Gets the list of broken business and validation rules for the business object.
    /// </summary>
    /// <value>A BrokenRules object containing the broken business and validation rules.</value>
    BrokenRules BrokenRulesCollection { get; }
  }
}
