using System;
using System.Collections.Generic;
using System.Text;

namespace DataLayer.Framework
{
  /// <summary>
  /// Describes the filter to use when retrieving information from an Sql table or view.
  /// </summary>
  /// <remarks>The filter defines the WHERE, ORDER BY, and TOP N clauses.</remarks>
  public class SqlFilter : ICloneable 
  {
    private static SqlFilter _empty = new SqlFilter("", "", 0);
    private string _where = string.Empty;
    private string _orderby = string.Empty;
    private int _topN = 1000;

    /// <summary>
    /// Gets or sets the WHERE clause to use.  This value must be a valid SQL WHERE expression, but
    /// should not include the prefix WHERE.  Use an empty string to return all records.
    /// </summary>
    /// <remarks>This procedure does NOT do type checks or SQL injection checks.</remarks>
    public string Where { get { return _where; } set { _where = value; } }

    /// <summary>
    /// Gets or sets the ORDER BY clause to use.  This value must be a valid SQL ORDER BY
    /// expression, but should not include the prefix ORDER BY.  Use an empty string to represent
    /// no order.
    /// </summary>
    public string OrderBy { get { return _orderby; } set { _orderby = value; } }

    /// <summary>
    /// Gets or sets the TOP N clause used to limit the number of rows returned.  Use
    /// a value of 0 to return unlimited results.
    /// </summary>
    public int TopN { get { return _topN; } set { _topN = value; } }

    /// <summary>
    /// Creates a new, default instance of a SqlFilter.
    /// </summary>
    public SqlFilter() { }

    /// <summary>
    /// Creates a new instance of a SqlFilter, specifying the where clause.
    /// </summary>
    /// <param name="where">The where clause, not including the prefix WHERE.</param>
    public SqlFilter(string where)
    {
      _where = where;
    }

    /// <summary>
    /// Creates a new instance of a SqlFilter, specifying the where and order by clauses.
    /// </summary>
    /// <param name="where">The where clause, not including the prefix WHERE.</param>
    /// <param name="orderBy">The order by clause, not including the prefix ORDER BY.</param>
    public SqlFilter(string where, string orderBy)
    {
      _where = where;
      _orderby = orderBy;
    }

    /// <summary>
    /// Creates a new instance of a SqlFilter, specifying the where and top N clauses.
    /// </summary>
    /// <param name="where">The where clause, not including the prefix WHERE.</param>
    /// <param name="topN">The maximum number of rows to return, or zero to return all rows.</param>
    public SqlFilter(string where, int topN)
    {
      _where = where;
      _topN = topN;
    }

    /// <summary>
    /// Creates a new instance of a SqlFilter, specifying all parameters.
    /// </summary>
    /// <param name="where">The where clause, not including the prefix WHERE.</param>
    /// <param name="orderBy">The order by clause, not including the prefix ORDER BY.</param>
    /// <param name="topN">The maximum number of rows to return, or zero to return all rows.</param>
    public SqlFilter(string where, string orderBy, int topN)
    {
      _where = where;
      _topN = topN;
      _orderby = orderBy;
    }

    /// <summary>
    /// Gets an empty SQL Filter.
    /// </summary>
    public static SqlFilter Empty { get { return _empty; } }

    #region ICloneable Members

    /// <summary>
    /// Returns a deep-copy clone of the object.
    /// </summary>
    /// <returns>A deep-copy clone of the object.</returns>
    public SqlFilter Clone()
    {
      return new SqlFilter(this.Where, this.OrderBy, this.TopN);
    }

    object ICloneable.Clone() { return this.Clone(); }

    #endregion
  }
}
