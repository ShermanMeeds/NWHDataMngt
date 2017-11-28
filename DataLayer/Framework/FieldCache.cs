using System;
using System.Collections.Generic;
using System.Text;

namespace DataLayer.Framework
{
  /// <summary>
  /// Implements a dictionary of FieldInfo objects to keep track of original values.
  /// </summary>
  /// <remarks>The calling class should invoke FieldChanging with the original value and
  /// invoke FieldChanged with the new value.  The field cache is normally cleared after
  /// changes are successfully saved to the database.
  /// <para>In the FieldChanging method a new entry will be created if one does not exist,
  /// otherwise nothing will happen - this latches in the "original" value.</para>
  /// <para>In the FieldChanged method the new value is compared to the original and if
  /// they match the item is removed from the list.</para>
  /// </remarks>
  public sealed class FieldCache : Dictionary<string, FieldInfo>
  {
    /// <summary>
    /// Gets the original value of the specified field from the field cache.  If the
    /// field does not exist in the cache then the specified current value is
    /// returned.
    /// </summary>
    /// <param name="fieldName">The name of the field.</param>
    /// <param name="currentValue">The current value of the field.</param>
    /// <returns>The original value from the field cache, or the current value
    /// if the cache does not contain an entry for the field.</returns>
    public object GetOriginalValue(string fieldName, object currentValue)
    {
      FieldInfo item = null;
      if (!this.TryGetValue(fieldName, out item))
      {
        return currentValue;
      }
      return item.OriginalValue;
    }

    /// <summary>
    /// Call this method when the value of a field changing (before the change).
    /// </summary>
    /// <param name="fieldName">The name of the field.</param>
    /// <param name="currentValue">The current value of the field.</param>
    /// <remarks>This method can be called multiple times.  The original value
    /// will only be cached if the field does not exist in the cache.</remarks>
    public void FieldChanging(string fieldName, object currentValue)
    {
      FieldInfo item = null;
      if (!this.TryGetValue(fieldName, out item))
      {
        // item not in store, this is the first change - set original value
        item = FieldInfo.GetNew(currentValue);
        this.Add(fieldName, item);
      }
      // otherwise, do nothing, original value is already set.
    }

    /// <summary>
    /// Call this method after the value of a field has changed.
    /// </summary>
    /// <param name="fieldName">The name of the field.</param>
    /// <param name="newValue">The new value of the field.</param>
    /// <remarks>If the field exists in the cache and the new value is
    /// equal to the original value then the cached entry for the 
    /// field is removed.</remarks>
    public void FieldChanged(string fieldName, object newValue)
    {
      FieldInfo item = null;
      if (!this.TryGetValue(fieldName, out item))
      {
        // item not in store (odd) - skip...  Calculated fields will do this...
      }
      else
      {
        // Item exists, remove if value has returned to original
        if (SqlHelper.IsEqualNull(item.OriginalValue, newValue)) { this.Remove(fieldName); }
      }
    }

    /// <summary>
    /// Check if the specified field has been changed.  
    /// </summary>
    /// <param name="columnName">The name of the column.</param>
    /// <returns>True if the field is in this list.</returns>
    /// <remarks>If the field exists in this list then it is dirty.</remarks>
    public bool IsFieldDirty(string columnName) { return this.ContainsKey(columnName); }
  }

  #region FieldInfo

  /// <summary>
  /// Contains cached field data for the FieldCache object
  /// </summary>
  public class FieldInfo
  {
    /// <summary>
    /// Gets or sets the cached original value.
    /// </summary>
    /// <value>The cached original value.</value>
    public object OriginalValue=null;

    /// <summary>
    /// Gets a new instance of a FieldInfo object with the 
    /// original value set.
    /// </summary>
    /// <param name="originalValue">The original value.</param>
    /// <returns>A new FieldInfo object with the original value set.</returns>
    public static FieldInfo GetNew(object originalValue)
    {
      FieldInfo info = new FieldInfo();
      info.OriginalValue = originalValue;
      return info;
    }
  }

  #endregion
}

