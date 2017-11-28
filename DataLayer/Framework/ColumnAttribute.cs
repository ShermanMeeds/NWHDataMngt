using System;

namespace DataLayer.Framework
{
  /// <summary>
  /// Attribute to be used on all properties exposed as database columns
  /// </summary>
  [AttributeUsage(AttributeTargets.Property, Inherited = true, AllowMultiple = false)]
  public class ColumnAttribute : Attribute
  {
    /// <summary>
    /// Construct a database column attribute
    /// </summary>
    public ColumnAttribute() { }  // Parameterless constructor means always use named params.

    /// <summary>
    /// Gets or sets a private storage field to hold the value from a column.
    /// </summary>
    public string Storage = string.Empty;

    /// <summary>
    /// Gets or sets the type of the database column.
    /// </summary>
    public string DBType = string.Empty;

    /// <summary>
    /// Gets or sets the name of the column in the database.
    /// </summary>
    public string Name = string.Empty;

    /// <summary>
    /// Gets or sets whether a column can contain null values.
    /// </summary>
    public bool CanBeNull = false;

    /// <summary>
    /// Get/Set whether this column is part of the primary key.
    /// </summary>
    public bool IsPrimaryKey = false;

    /// <summary>
    /// Gets or sets whether this column contains a database-generated value.
    /// </summary>
    public bool IsDBGenerated = false;

    /// <summary>
    /// Gets or sets whether this column is the database timestamp
    /// </summary>
    public bool IsVersion = false;

    /// <summary>
    /// Gets or sets the storage size of the column in the database
    /// </summary>
    public int Size = 0;

    /// <summary>
    /// Gets or sets whether this column is virtual.  Virtual columns are NOT saved.
    /// </summary>
    public bool IsVirtual = false;
  }

}
