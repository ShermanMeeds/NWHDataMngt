using System;
using System.Collections.Generic;
using System.Text;

namespace MorphoDataLayer.Framework
{
  /// <summary>
  /// Defines an interface that allows the key value to be retrieved from an object.
  /// </summary>
  /// <typeparam name="T">A keyed object.</typeparam>
  public interface IKeyedObject<T>
  {
    /// <summary>
    /// Gets the unique key that identifies the object.
    /// </summary>
    /// <returns>A key value that uniquely identifies the object.</returns>
    T GetKeyFromItem();
  }
}
