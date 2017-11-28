﻿using System;
using System.Collections.Generic;
using System.Text;

namespace DataLayer.Framework
{
  /// <summary>
  /// Defines the interface that a TableSchema implementation must support.
  /// </summary>
  public interface ITableSchema
  {
    /// <summary>
    /// Gets whether the values for any columns in this object are generated by the database.
    /// </summary>
    bool IsAnyDBGenerated { get; }

    /// <summary>
    /// Gets a dictionary of column attributes containing all defined columns.
    /// </summary>
    /// <value>A dictionary of all defined columns.</value>
    Dictionary<string, ColumnAttribute> Cols { get; }

    /// <summary>
    /// Gets a dictionary of column attributes containing just the primary key
    /// columns.
    /// </summary>
    /// <value>A dictionary of primary key columns.</value>
    Dictionary<string, ColumnAttribute> Keys { get; }

    /// <summary>
    /// Gets the column attributes for the identity column.
    /// </summary>
    /// <value>The column attributes for the version column, or null if no
    /// version column is defined.</value>
    ColumnAttribute VersionColumn { get; }

    /// <summary>
    /// Gets the column attributes for the identity column.
    /// </summary>
    /// <value>The column attributes for the identity column, or null if no
    /// identity column is defined.</value>
    ColumnAttribute IdentityColumn { get; }

    /// <summary>
    /// Gets the name of the table that this schema is mapped to.
    /// </summary>
    /// <value>The name of the table that this schema is mapped to.</value>
    string TableName { get; }
  }
}