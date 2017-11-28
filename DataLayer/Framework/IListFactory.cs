using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;

namespace MorphoDataLayer.Framework
{
  /// <summary>
  /// Defines the interface implemented by the generic ListFactory.
  /// </summary>
  public interface IListFactory
  {
    /// <summary>
    /// Gets the type of the list.
    /// </summary>
    Type GetListType { get; }

    /// <summary>
    /// Gets the type of items in the list.
    /// </summary>
    Type GetItemType { get; }

    /// <summary>
    /// Retrieves the list from the database.
    /// </summary>
    /// <param name="filter">A SqlFilter that defines the filter, order and limits on the query.</param>
    /// <returns>An IList containing the retrieved rows.</returns>
    IList GetList(SqlFilter filter);

    /// <summary>
    /// Gets the layout derived from the list item type.  The layout is created by using the
    /// LayoutAttributes defined for the properties of the type.
    /// </summary>
    /// <returns>A GridLayout that describes the layout of the columns.</returns>
    GridLayout GetLayout();

    /// <summary>
    /// Gets the table schema for the list item type.  The table schema is created by using the
    /// ColumnAttributes and TableAttributes defined in the item type.
    /// </summary>
    /// <returns>A TableSchema that describes the items in the list.</returns>
    ITableSchema GetSchema();
  }
}
