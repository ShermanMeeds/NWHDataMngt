using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;

namespace DataLayer.Framework
{
  /// <summary>
  /// Provides helper methods for interacting with Sql Server / Ado.Net
  /// </summary>
  public static class SqlHelper
  {
    /// <summary>
    /// Returns a formatted select string containing the where, order by and top n
    /// clauses for the designated command.  The command must be formatted as follows:
    /// <code>SELECT{0} [Comma-separated field list] FROM [Table]{1}{2}</code>
    /// <example><code>SELECT{0} Box_Type,Box_Type_Des FROM BOX_TYPES{1}{2}</code></example>
    /// </summary>
    /// <param name="command">The select command, formatted as described in the summary.</param>
    /// <param name="filter">A SqlFilter object that describes the where, order by and top n values.</param>
    /// <returns>A formatted string suitable for use as a select command.</returns>
    public static string GetFormattedSelectCommand(string command, SqlFilter filter)
    {
      return String.Format(command,
        filter.TopN > 0 ? " TOP " + filter.TopN : "",
        filter.Where.Length > 0 ? " WHERE " + filter.Where : "",
        filter.OrderBy.Length > 0 ? " ORDER BY " + filter.OrderBy : "");
    }

    /// <summary>
    /// Convert DBNull to Null
    /// </summary>
    /// <param name="value">Value to test</param>
    /// <returns>If value is DBNull then Null, otherwise value.</returns>
    public static object DBNullNull(object value)
    {
      if (value == DBNull.Value) { return null; }
      return value;
    }

    #region EmptyDBNull

    /// <summary>
    /// Returns the input value, or <see langword="DBNull.Value"/> if the the input value
    /// was an empty (zero-length) string.
    /// </summary>
    /// <overloads>Prepares values for use by database parameters that require <see langword="DBNull.Value"/>
    /// in place of empty values.</overloads>
    /// <param name="value">The <see cref="System.String"/> value to prepare.</param>
    /// <returns>The input value, or <see langword="DBNull.Value"/> if the the input value
    /// was an empty (zero-length) string.</returns>
    /// <remarks>The input string is NOT trimmed and will only be replaced with
    /// a <see langword="DBNull.Value"/> if it is a zero-length string.</remarks>
    public static object EmptyDBNull(string value)
    {
      if (string.IsNullOrEmpty(value)) { return DBNull.Value; }
      return value;
    }

    /// <summary>
    /// Returns the input value, or <see langword="DBNull.Value"/> if the the input value
    /// was zero.
    /// </summary>
    /// <param name="value">The <see cref="System.Int32"/> value to prepare.</param>
    /// <returns>The input value, or <see langword="DBNull.Value"/> if the the input value
    /// was 0.</returns>
    public static object EmptyDBNull(Int32 value)
    {
      if (value == 0) { return DBNull.Value; }
      return value;
    }

    /// <summary>
    /// Returns the input value, or <see langword="DBNull.Value"/> if the the input value
    /// was zero.
    /// </summary>
    /// <param name="value">The value to prepare.</param>
    /// <returns>The input value, or <see langword="DBNull.Value"/> if the the input value
    /// was null or 0.</returns>
    public static object EmptyDBNull(int? value)
    {
      if (value == null || value == 0) { return DBNull.Value; }
      return value;
    }

    /// <summary>
    /// Returns the input value, or <see langword="DBNull.Value"/> if the the input value
    /// was zero.
    /// </summary>
    /// <param name="value">The <see cref="System.Int16"/> value to prepare.</param>
    /// <returns>The input value, or <see langword="DBNull.Value"/> if the the input value
    /// was 0.</returns>
    public static object EmptyDBNull(Int16 value)
    {
      if (value == 0) { return DBNull.Value; }
      return value;
    }

    /// <summary>
    /// Returns the input value, or <see langword="DBNull.Value"/> if the the input value
    /// was zero.
    /// </summary>
    /// <param name="value">The <see cref="System.Byte"/> value to prepare.</param>
    /// <returns>The input value, or <see langword="DBNull.Value"/> if the the input value
    /// was 0.</returns>
    public static object EmptyDBNull(byte value)
    {
      if (value == 0) { return DBNull.Value; }
      return value;
    }

    /// <summary>
    /// Returns the input value, or <see langword="DBNull.Value"/> if the the input value
    /// was <see langword="DateTime.MinValue"/>.
    /// </summary>
    /// <param name="value">The <see cref="System.DateTime"/> value to prepare.</param>
    /// <returns>The input value, or <see langword="DBNull.Value"/> if the the input value
    /// was <see langword="DateTime.MinValue"/>.</returns>
    /// <remarks>DateTime values can never be null, so the 'empty' version of a DateTime
    /// is generally considered to be the smallest possible DateTime, or
    /// <see langword="DateTime.MinValue"/>.</remarks>
    public static object EmptyDBNull(DateTime value)
    {
      if (value == DateTime.MinValue) { return DBNull.Value; }
      return value;
    }

    /// <summary>
    /// Returns the input value, or <see langword="DBNull.Value"/> if the the input value
    /// was zero.
    /// </summary>
    /// <param name="value">The <see cref="System.Decimal"/> value to prepare.</param>
    /// <returns>The input value, or <see langword="DBNull.Value"/> if the the input value
    /// was 0.</returns>
    public static object EmptyDBNull(Decimal value)
    {
      if (value == 0) { return DBNull.Value; }
      return value;
    }

    /// <summary>
    /// Returns the input value, or <see langword="DBNull.Value"/> if the the input value
    /// was zero.
    /// </summary>
    /// <param name="value">The <see cref="System.Single"/> value to prepare.</param>
    /// <returns>The input value, or <see langword="DBNull.Value"/> if the the input value
    /// was 0.</returns>
    public static object EmptyDBNull(Single value)
    {
      if (value == 0) { return DBNull.Value; }
      return value;
    }

    #endregion

    #region IsNull Functions

    /// <summary>
    /// Null-Safe object-to-integer conversion.
    /// </summary>
    /// <param name="arg">The object to convert.</param>
    /// <param name="returnIfEmpty">Value to return if the object is null
    /// or cannot be converted to an integer.</param>
    /// <returns>The object as an integer, or the returnIfEmpty value if the
    /// object is null or could not be converted.</returns>
    /// <remarks>Object values DBNull.Value, null and string.Empty are all
    /// considered to be null.</remarks>
    public static int IsNull(object arg, int returnIfEmpty)
    {
      int returnValue = 0;
      if ((arg == DBNull.Value) || (arg == null) || (string.IsNullOrEmpty(arg.ToString()))) { returnValue = returnIfEmpty; }
      else
      {
        try { returnValue = System.Convert.ToInt32(arg); }
        catch { returnValue = returnIfEmpty; }
      }
      return returnValue;
    }

    /// <summary>
    /// Null-Safe object-to-double conversion.
    /// </summary>
    /// <param name="arg">The object to convert.</param>
    /// <param name="returnIfEmpty">Value to return if the object is null
    /// or cannot be converted to an double.</param>
    /// <returns>The object as a double, or the returnIfEmpty value if the
    /// object is null or could not be converted.</returns>
    /// <remarks>Object values DBNull.Value, null and string.Empty are all
    /// considered to be null.</remarks>
    public static double IsNull(object arg, double returnIfEmpty)
    {
      double returnValue = 0;
      if ((arg == DBNull.Value) || (arg == null) || (string.IsNullOrEmpty(arg.ToString()))) { returnValue = returnIfEmpty; }
      else
      {
        try { returnValue = System.Convert.ToDouble(arg); }
        catch { returnValue = returnIfEmpty; }
      }
      return returnValue;
    }

    /// <summary>
    /// Null-Safe object-to-boolean conversion.
    /// </summary>
    /// <param name="arg">The object to convert.</param>
    /// <param name="returnIfEmpty">Value to return if the object is null
    /// or cannot be converted to a boolean.</param>
    /// <returns>The object as a boolean, or the returnIfEmpty value if the
    /// object is null or could not be converted.</returns>
    /// <remarks>Object values DBNull.Value, null and string.Empty are all
    /// considered to be null.</remarks>
    public static bool IsNull(object arg, bool returnIfEmpty)
    {
      bool returnValue = false;
      if ((arg == DBNull.Value) || (arg == null) || (string.IsNullOrEmpty(arg.ToString()))) { returnValue = returnIfEmpty; }
      else
      {
        try { returnValue = System.Convert.ToBoolean(arg); }
        catch { returnValue = returnIfEmpty; }
      }
      return returnValue;
    }

    /// <summary>
    /// Null-Safe object-to-string conversion.
    /// </summary>
    /// <param name="arg">The object to convert.</param>
    /// <param name="returnIfEmpty">Value to return if the object is null
    /// or cannot be converted to a string.</param>
    /// <returns>The object as a trimmed string, or the returnIfEmpty value if the
    /// object is null or could not be converted.</returns>
    /// <remarks>Object values DBNull.Value, null and string.Empty are all
    /// considered to be null.</remarks>
    public static string IsNull(object arg, string returnIfEmpty)
    {
      string returnValue = null;
      if ((arg == DBNull.Value) || (arg == null) || (string.IsNullOrEmpty(arg.ToString()))) { returnValue = returnIfEmpty; }
      else
      {
        try { returnValue = System.Convert.ToString(arg).Trim(); }
        catch { returnValue = returnIfEmpty; }
      }
      return returnValue;
    }

    /// <summary>
    /// Null-Safe object-to-date conversion.
    /// </summary>
    /// <param name="arg">The object to convert.</param>
    /// <param name="returnIfEmpty">Value to return if the object is null
    /// or cannot be converted to a date.</param>
    /// <returns>The object as a date, or the returnIfEmpty value if the
    /// object is null or could not be converted.</returns>
    /// <remarks>Object values DBNull.Value, null and string.Empty are all
    /// considered to be null.</remarks>
    public static System.DateTime IsNull(object arg, System.DateTime returnIfEmpty)
    {
      System.DateTime returnValue = DateTime.MinValue;
      if ((arg == DBNull.Value) || (arg == null) || (string.IsNullOrEmpty(arg.ToString()))) { returnValue = returnIfEmpty; }
      else
      {
        try { returnValue = System.Convert.ToDateTime(arg); }
        catch { returnValue = returnIfEmpty; }
      }
      return returnValue;
    }

    /// <summary>
    /// Determines if two strings are equal, where null values are NOT considered to
    /// distinct.  In other words, null is equal to null.
    /// </summary>
    /// <param name="s1">The first string to compare.</param>
    /// <param name="s2">The second string to compare.</param>
    /// <returns>True if the two strings are equal or if both are null, otherwise false.</returns>
    public static bool IsEqualNull(string s1, string s2)
    {
      if (s1 == null && s2 == null) { return true; };
      if (s1 == null || s2 == null) { return false; };
      return s1.Equals(s2, StringComparison.OrdinalIgnoreCase);
    }

    /// <summary>
    /// Determines if two objects are equal, where null values are NOT considered to
    /// distinct.  In other words, null is equal to null.
    /// </summary>
    /// <param name="o1">The first object to compare.</param>
    /// <param name="o2">The second object to compare.</param>
    /// <returns>True if the two objects are equal or if both are null, otherwise false.</returns>
    public static bool IsEqualNull(object o1, object o2)
    {
      if (o1 == null && o2 == null) { return true; };
      if (o1 == null || o2 == null) { return false; };
      return o1.Equals(o2);
    }

    /// <summary>
    /// Returns the specified string, converting empty strings to null.
    /// </summary>
    /// <param name="s1">The string to check.</param>
    /// <returns>The specified string, or null if the string was empty or was
    /// already null.</returns>
    public static string EmptyNull(string s1)
    {
      if (string.IsNullOrEmpty(s1)) { return null; }
      return s1;
    }

    #endregion

    /// <summary>
    /// Transforms a comma-separated list of terms into a corresponding list where each term
    /// is quotation delimited.  The output of this method is suitable for use in
    /// an SQL IN clause for a string field.
    /// </summary>
    /// <param name="list">A list of comma-separated terms to quote-delimit.</param>
    /// <returns>A <see cref="System.String"/> containing a comma-separated list
    /// of terms where each term is quotation-delimited.</returns>
    /// <remarks>This method uses a compiled <see cref="Regex"/> to perform advanced
    /// pattern matching on the input list.  It will detect and preserve any list
    /// items that are already quotation-delimited, including terms containing commas.</remarks>
    public static string QuoteDelimitList(string list)
    {
      if (list.Length == 0) { return ""; }
      string pattern = @"[,]+(?=(?:[^""]*""[^""]*"")*(?![^""]*""))";
      Regex r = new Regex(pattern, RegexOptions.Compiled);
      string[] result = r.Split(list);

      StringBuilder sb = new StringBuilder();
      int nx = 0;
      foreach (string value in result)
      {
        string sx = value.Trim(new char[] { ' ', '\'' });
        if (sx.Length > 0)
        {
          if (nx++ > 0) { sb.Append(","); }
          sb.Append(string.Format("{0}{1}{2}", "'", sx.Replace("'", "''"), "'"));
        }
      }

      return sb.ToString();
    }
    
    /// <summary>
    /// Determines whether the specified datatype represents a number.
    /// </summary>
    /// <param name="datatype">The type to check.</param>
    /// <returns>True if the datatype is a recognized numberic type, otherwise false.</returns>
    public static bool IsNumeric(Type datatype)
    {
      const string numerictypes = "byte,sbyte,short,ushort,int,int16,int32,int64,uint,uint16,uint32,utin64,long,ulong,float,double,decimal";
      return numerictypes.Contains(datatype.Name.ToLower() + ",");
    }
  
  }
}
