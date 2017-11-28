using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.ComponentModel;

namespace DataLayer.Framework
{
  /// <summary>
  /// This is the base class for all lists of editable business objects.
  /// </summary>
  /// <typeparam name="T">The type of object that this list is.</typeparam>
  /// <typeparam name="C">The type of business object that this list will contain.  This type
  /// must implement IBusinessObject.</typeparam>
  public abstract class BusinessListBase<T, C> :
    BindingList<C>, IBusinessList
    where T : BusinessListBase<T, C>
    where C : IBusinessObject
  {
    #region IBusinessList Members

    /// <summary>
    /// Method invoked from a BusinessBase object instructing
    /// the list to remove the child object (itself).
    /// </summary>
    /// <param name="child">The child object to remove.</param>
    void IBusinessList.RemoveChild(IBusinessObject child) { Remove((C)child); }

    /// <summary>
    /// Method invoked from a BusinessBase object instructing
    /// the list to remove the child object (itself).
    /// </summary>
    /// <param name="child">The child object to remove.</param>
    protected void RemoveChild(IBusinessObject child)
    {
      Remove((C)child);
    }

    #endregion

    private bool _deleteOnRemove = true;

    /// <summary>
    /// Gets whether items that are removed from the list are immediately deleted
    /// in the database as well.
    /// </summary>
    /// <value>True to indicate that items removed from the list should be deleted
    /// in the database.</value>
    public bool DeleteOnRemove { get { return _deleteOnRemove; } set { _deleteOnRemove = value; } }

    /// <summary>
    /// Removes and item from the list and deletes it from the database.
    /// </summary>
    /// <param name="index">The index of the item to remove</param>
    /// <remarks>Item is flagged as deleted and then ApplyEdit is invoked.</remarks>
    protected override void RemoveItem(int index)
    {
      if (_deleteOnRemove)
      {
        C item = this[index];
        item.Delete();  // Mark for deletion
        item.ApplyEdit();  // Persist
      }
      base.RemoveItem(index);
    }

    #region IsDirty, IsValid, IsSavable

    /// <summary>
    /// Gets whether this object's data has been changed.
    /// </summary>
    /// <value>True if the object has been changed; otherwise false.</value>
    public bool IsDirty
    {
      get
      {
        // run through all child objects and if any are dirty then the collection
        // is dirty.
        foreach (C child in this) { if (child.IsDirty) { return true; } }
        return false;
      }
    }

    /// <summary>
    /// Gets whether all items in the collection are valid (no broken validation
    /// rules).
    /// </summary>
    /// <value>True if all child objects are valie; otherwise false.</value>
    public virtual bool IsValid
    {
      get
      {
        // run through all child objects and if any are invalid
        // then the collection is invalid.
        foreach (C child in this) { if (!child.IsValid) { return false; } }
        return true;
      }
    }

    /// <summary>
    /// Returns <see langword="true" /> if this object is both dirty and valid.
    /// </summary>
    /// <returns>A value indicating if this object is both dirty and valid.</returns>
    [Browsable(false)]
    public virtual bool IsSavable
    {
      get { return (IsDirty && IsValid); }
    }

    #endregion


    /// <summary>
    /// Gets a list of the primary keys a defined by the Column attributes of the business object.
    /// </summary>
    /// <returns>A Dictionary containing the primary key columns.</returns>
    public IDictionary<string, ColumnAttribute> GetPrimaryKeys()
    {
      return GetSchema().Keys;
    }

    /// <summary>
    /// Gets the table schema for the object type contained in the list.
    /// </summary>
    /// <returns>An ITableSchema that describes the columns and layout for the type of object
    /// contained in list.</returns>
    protected ITableSchema GetSchema() { return TableSchema<C>.GetSchema(); }

    /// <summary>
    /// Gets the type of object that the list contains.
    /// </summary>
    /// <value>The Type of object that the list contains.</value>
    public Type ItemType { get { return typeof(C); } }
  
  }
}
