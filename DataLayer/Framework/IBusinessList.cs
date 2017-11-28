using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;

namespace DataLayer.Framework
{
  /// <summary>
  /// Defines the interface that must be implemented by any business objects
  /// that contain child objects.
  /// </summary>
  public interface IBusinessList : IList
  {
    /// <summary>
    /// This method is called by the child object when it wants to be removed
    /// from the collection.
    /// </summary>
    /// <param name="child">The child object to remove.</param>
    void RemoveChild(IBusinessObject child);

    /// <summary>
    /// This method returns a Dictionary containing the primary keys based on the
    /// ColumnAttribute attributes of the business object.
    /// </summary>
    /// <returns>An IDictionary containing the primary keys.</returns>
    IDictionary<string, ColumnAttribute> GetPrimaryKeys();

    /// <summary>
    /// Gets whether the list has unsaved changes.
    /// </summary>
    /// <value>True if the list has unsaved changes; otherwise false.</value>
    bool IsDirty { get; }

    /// <summary>
    /// Gets whether the list is valid.
    /// </summary>
    /// <value>True if the list is valid; otherwise false.</value>
    bool IsValid { get; }

    /// <summary>
    /// Gets whether the list is savable = dirty and valid.
    /// </summary>
    /// <value>True if the list is both dirty and valid; otherwise false.</value>
    bool IsSavable { get; }

    /// <summary>
    /// Gets the type of item contained in the list.
    /// </summary>
    /// <value>The type of item contained in the list.</value>
    Type ItemType { get; }

  }
}
