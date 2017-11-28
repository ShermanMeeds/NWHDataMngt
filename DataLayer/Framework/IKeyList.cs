using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;

namespace MorphoDataLayer.Framework
{
  /// <summary>
  /// Defines the interface that must be implemented for a KeyList object.
  /// </summary>
  public interface IKeyList : IList
  {
    /// <summary>
    /// Fills the list using the specified SQLFilter.
    /// </summary>
    /// <param name="filter">A SqlFilter that defines the filter, sort order and maximum number of rows.</param>
    void Fill(SqlFilter filter);

    /// <summary>
    /// Gets the size of the cache.  This is the maximum number of records that will be stored locally at any one time.
    /// </summary>
    int CacheSize { get; }

    /// <summary>
    /// Gets the cache hit percentage.
    /// </summary>
    float CacheHitPercent { get; }

    /// <summary>
    /// Returns the type of item contained in the list.
    /// </summary>
    Type GetItemType();

    /// <summary>
    /// Returns a new item of the type contained in the list.
    /// </summary>
    /// <returns></returns>
    IBusinessObject GetNewItem();

    /// <summary>
    /// Adds a new item to the list and caches it.
    /// </summary>
    /// <param name="item">The item to add.  The type must match the type of item
    /// contained in the list.</param>
    void AddItem(IBusinessObject item);
  }
}
