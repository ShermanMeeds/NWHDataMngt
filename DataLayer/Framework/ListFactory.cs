using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Reflection;

namespace MorphoDataLayer.Framework
{
  /// <summary>
  /// Provides generic methods to help generate lists, layouts and schemas for any list
  /// classes that implement a typed IList structure.
  /// </summary>
  /// <typeparam name="T">The list type.  The list type must implement an IList of objects of type C.</typeparam>
  /// <typeparam name="C">The item type.</typeparam>
  public class ListFactory<T,C> : IListFactory
    where T : IList<C>
  {
    private SqlFilter _defaultFilter = SqlFilter.Empty;

    #region ctor

    /// <summary>
    /// Creates a new instance of a ListFactory with an empty default filter.
    /// </summary>
    public ListFactory() { }

    /// <summary>
    /// Creates a new instance of a ListFactory with the specified default filter.
    /// </summary>
    /// <param name="defaultFilter">A SqlFilter that describes the default filter.</param>
    public ListFactory(SqlFilter defaultFilter) { _defaultFilter = defaultFilter; }

    #endregion

    #region Object Model

    /// <summary>
    /// Gets the type of the list.
    /// </summary>
    public Type GetListType { get { return typeof(T); } }

    /// <summary>
    /// Gets the type of items in the list.
    /// </summary>
    public Type GetItemType { get { return typeof(C); } }

    /// <summary>
    /// Returns a new list of items using the specified filter.  The list is created
    /// by invoking the GetList static method on the list type.  An exception will 
    /// be generated if the list type does not implement this method.
    /// </summary>
    /// <param name="filter">A SqlFilter that describes what data to return.  If this is null then
    /// the default filter will be used.</param>
    /// <returns>A new list of type T containing items of type C that match the provided
    /// filter.</returns>
    public T GetList(SqlFilter filter)
    {
      if (filter == null) { filter = _defaultFilter; }
      Type t = typeof(T);
      object[] par = new object[] { filter };
      T list = (T)t.InvokeMember("GetList", BindingFlags.Default | BindingFlags.InvokeMethod, null, null, par);
      return list;
    }

    /// <summary>
    /// Gets the layout derived from the item type C.  The layout is created by using the
    /// LayoutAttributes defined for the properties of the type.
    /// </summary>
    /// <returns>A GridLayout that describes the layout of the columns.</returns>
    public GridLayout GetLayout() { return GridLayout.FromType(typeof(C)); }

    /// <summary>
    /// Gets the table schema for item type C.  The table schema is created by using the
    /// ColumnAttributes and TableAttributes defined in the item type.
    /// </summary>
    /// <returns>A TableSchema that describes the items in the list.</returns>
    public TableSchema<C> GetSchema() { return TableSchema<C>.GetSchema(); }

    #endregion

    #region IListFactory

    ITableSchema IListFactory.GetSchema() { return GetSchema(); }
    IList IListFactory.GetList(SqlFilter filter) { return (IList)GetList(filter); }

    #endregion
  }
}
