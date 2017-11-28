using System;

namespace DataLayer.Framework
{
  /// <summary>
  /// Attribute to be used on a class to define which database table is used
  /// </summary>
  [AttributeUsage(AttributeTargets.Class, Inherited = false, AllowMultiple = false)]
  public class TableAttribute : Attribute
  {
    /// <summary>
    /// Construct the attribute
    /// </summary>
    public TableAttribute() { }  // Parameterless constructor means always use named params.

    /// <summary>
    /// Gets or sets the name of the table or view
    /// </summary>
    public string Name = string.Empty;
  }
}
