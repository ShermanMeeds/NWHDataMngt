using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Reflection;

namespace DataLayer.Framework
{
  /// <summary>
  /// Handles creation of standardized CRUD (Create, Update and Delete) and Select
  /// statements for business objects with a defined schema.
  /// </summary>
  /// <remarks>The static methods of this class all return SqlCommand objects containing
  /// command text and parameters based on the current state of the business object
  /// instance that needs to be persisted.  It is the responsibility of the calling method
  /// to clean up the SqlCommand object.
  /// <para>All schema data is extracted from the business object based on the defined
  /// TableAttribute and ColumnAttribute attributes.  All methods support both surrogate
  /// primary keys and natural primary keys, including multi-part keys.</para></remarks>
  public static class CrudFactory
  {

    #region Select Command

    /// <summary>
    /// Generates a standard select command based on the defined attributes in the 
    /// referenced business object type.  The select command supports dynamic where, order by,
    /// and top clauses.
    /// </summary>
    /// <typeparam name="T">The type of object to genearate the command for.  This type must
    /// implement a BusinessBase object."/></typeparam>
    /// <param name="filter">A SqlFilter that describes the where, order by and topN values.</param>
    /// <returns>A ready-to-execute SqlCommand.</returns>
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
    public static SqlCommand GetSelectCommand<T>(SqlFilter filter)
      where T : BusinessBase<T>
    {
      ITableSchema schema = BusinessBase<T>.Schema;
      string commandtext = String.Format(MakeSelectTemplate(schema),
        filter.TopN > 0 ? " TOP " + filter.TopN : "",
        filter.Where.Length > 0 ? " WHERE " + filter.Where : "",
        filter.OrderBy.Length > 0 ? " ORDER BY " + filter.OrderBy : "");
      SqlCommand cmd = null;
      SqlCommand tmpCmd = null;
      try
      {
        tmpCmd = new SqlCommand();
        tmpCmd.CommandText = commandtext;
        tmpCmd.CommandType = CommandType.Text;
        cmd = tmpCmd;
        tmpCmd = null;
      }
      finally
      {
        if (tmpCmd != null) { tmpCmd.Dispose(); tmpCmd = null; }
      }
      return cmd;
    }

    /// <summary>
    /// Generates a standard select command based on the provided template and filter.
    /// The template must be of the form "SELECT{0} [Columns] FROM [Table]{1}{2}"
    /// </summary>
    /// <param name="template">A select template of the form "SELECT{0} [Columns] FROM [Table]{1}{2}."</param>
    /// <param name="filter">A SqlFilter that describes the filter to apply.</param>
    /// <returns>A SqlCommand.</returns>
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
    public static SqlCommand GetSelectCommand(string template, SqlFilter filter)
    {
      string commandtext = String.Format(template,
        filter.TopN > 0 ? " TOP " + filter.TopN : "",
        filter.Where.Length > 0 ? " WHERE " + filter.Where : "",
        filter.OrderBy.Length > 0 ? " ORDER BY " + filter.OrderBy : "");
      SqlCommand tmpCmd = null;
      SqlCommand cmd = null;
      try
      {
        tmpCmd = new SqlCommand();
        tmpCmd.CommandText = commandtext;
        tmpCmd.CommandType = CommandType.Text;
        cmd = tmpCmd;
        tmpCmd = null;
      }
      finally
      {
        if (tmpCmd != null) { tmpCmd.Dispose(); tmpCmd = null; }
      }
      return cmd;
    }

    /// <summary>
    /// Creates a select command string based on the provided template and filter.
    /// The template must be of the form "SELECT{0} [Columns] FROM [Table]{1}{2}"
    /// </summary>
    /// <param name="template">A select template of the form "SELECT{0} [Columns] FROM [Table]{1}{2}."</param>
    /// <param name="filter">A SqlFilter that describes the filter to apply.</param>
    /// <returns>A select command string.</returns>
    public static string GetSelectString(string template, SqlFilter filter)
    {
      string commandtext = String.Format(template,
        filter.TopN > 0 ? " TOP " + filter.TopN : "",
        filter.Where.Length > 0 ? " WHERE " + filter.Where : "",
        filter.OrderBy.Length > 0 ? " ORDER BY " + filter.OrderBy : "");
      return commandtext;
    }

    /// <summary>
    /// Generates a select command to return a single row based on the defined attributes
    /// in the referenced business object type.  The select command includes parameters
    /// for each primary key named based on the database name of the key column.  The 
    /// parameter values must be added by the calling routine.
    /// </summary>
    /// <typeparam name="T">The type of object to generate the command for.  This type must
    /// implement a BusinessBase object.</typeparam>
    /// <returns>A SqlCommand.</returns>
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
    public static SqlCommand GetSelectItemCommand<T>()
      where T : BusinessBase<T>
    {
      ITableSchema schema = BusinessBase<T>.Schema;
      string commandtext = String.Format(MakeSelectItemTemplate(schema));
      SqlCommand cmd = null;
      SqlCommand tmpCmd = null;
      try
      {
        tmpCmd = new SqlCommand();
        tmpCmd.CommandText = commandtext;
        tmpCmd.CommandType = CommandType.Text;
        cmd = tmpCmd;
        tmpCmd = null;
      }
      finally
      {
        if (tmpCmd != null) { tmpCmd.Dispose(); tmpCmd = null; }
      }
      return cmd;
    }

    /// <summary>
    /// Generates a select command to return a single row based on the defined attributes
    /// in the referenced business object type.  The select command includes parameters
    /// for each primary key named based on the database name of the key column.
    /// </summary>
    /// <typeparam name="T">The type of object to generate the command for.  This type must
    /// implement a BusinessBase object.</typeparam>
    /// <param name="instance">An instance of type T to use when creating the select parameters.</param>
    /// <returns>A SqlCommand.</returns>
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
    public static SqlCommand GetSelectItemCommand<T>(T instance)
      where T : BusinessBase<T>
    {
      ITableSchema schema = BusinessBase<T>.Schema;
      string commandtext = String.Format(MakeSelectItemTemplate(schema));
      SqlCommand cmd = null;
      SqlCommand tmpCmd = null;
      try
      {
        tmpCmd = new SqlCommand();
        tmpCmd.CommandText = commandtext;
        tmpCmd.CommandType = CommandType.Text;

        // Fill in parameter values
        foreach (ColumnAttribute key in schema.Keys.Values)
        {
          System.Reflection.FieldInfo field = typeof(T).GetField(key.Storage, BindingFlags.NonPublic | BindingFlags.Instance);
          tmpCmd.Parameters.AddWithValue("@" + key.Name, field.GetValue(instance));
        }

        cmd = tmpCmd;
        tmpCmd = null;
      }
      finally
      {
        if (tmpCmd != null) { tmpCmd.Dispose(); tmpCmd = null; }
      }
      return cmd;
    }

    /// <summary>
    /// Generates a select command to return a single row based on the specified command template
    /// and using the keys defined by the schema of the type T.  The specified instance will
    /// be used to generate the parameter values.
    /// </summary>
    /// <typeparam name="T">The type of object to generate the command for.  This type must
    /// implement a BusinessBase object.</typeparam>
    /// <param name="template">A select template of the form "SELECT{0} [Columns] FROM [Table]{1}{2}."</param>
    /// <param name="instance">An instance of type T to use when creating the select parameters.</param>
    /// <returns>A SqlCommand.</returns>
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
    public static SqlCommand GetSelectItemCommand<T>(string template, T instance)
      where T:BusinessBase<T>
    {
      ITableSchema schema = BusinessBase<T>.Schema;
      SqlCommand cmd = null;
      SqlCommand tmpCmd = null;
      try
      {
        tmpCmd = new SqlCommand();
        tmpCmd.CommandType = CommandType.Text;

        StringBuilder sb = new StringBuilder();
        int nx = 0;
        foreach (ColumnAttribute key in schema.Keys.Values)
        {
          System.Reflection.FieldInfo field = typeof(T).GetField(key.Storage, BindingFlags.NonPublic | BindingFlags.Instance);
          tmpCmd.Parameters.AddWithValue("@" + key.Name, field.GetValue(instance));
          sb.Append(string.Format("{0}{1}=@{1}", nx == 0 ? "" : " and ", key.Name));
          nx++;
        }
        tmpCmd.CommandText = String.Format(template, " TOP 1", (sb.Length == 0 ? "" : " WHERE " + sb.ToString()), "");
        cmd = tmpCmd;
        tmpCmd = null;
      }
      finally
      {
        if (tmpCmd != null) { tmpCmd.Dispose(); tmpCmd = null; }
      }
      return cmd;
    }

    #endregion

    #region CRUD Commands

    /// <summary>
    /// Generates a standard delete command based on the defined primary keys in the
    /// referenced business object type.
    /// </summary>
    /// <typeparam name="T">The type of object to generate the command for.  This type must
    /// implement a BusinessBase object."/></typeparam>
    /// <param name="instance">The business object to delete.</param>
    /// <returns>A ready-to-execute SqlCommand.</returns>
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
    public static SqlCommand GetDeleteCommand<T>(T instance)
      where T : BusinessBase<T>
    {
      ITableSchema schema = BusinessBase<T>.Schema;
      StringBuilder sb = new StringBuilder(100);
      SqlCommand cmd = null;
      SqlCommand tmpCmd = null;
      try
      {
        tmpCmd = new SqlCommand();
        int nx = 1;
        foreach (KeyValuePair<string, ColumnAttribute> pk in schema.Keys)
        {
          // use reflection to get the current value of the key column
          System.Reflection.FieldInfo field = typeof(T).GetField(pk.Value.Storage, BindingFlags.NonPublic | BindingFlags.Instance);
          object curvalue = field.GetValue(instance);
          // Get original value
          object origvalue = instance.EditStore.GetOriginalValue(pk.Key, curvalue);
          string paramname = "@pk" + (nx++).ToString();
          tmpCmd.Parameters.AddWithValue(paramname, origvalue);
          // Append key to command text
          if (nx > 2) { sb.Append(" AND "); }
          sb.AppendFormat("{0}={1}", pk.Value.Name, paramname);
        }
        tmpCmd.CommandText = string.Format("DELETE TOP (1) FROM {0} WHERE {1}", schema.TableName, sb.ToString());
        cmd = tmpCmd;
        tmpCmd = null;
      }
      finally
      {
        if (tmpCmd != null) { tmpCmd.Dispose(); tmpCmd = null; }
      }
      return cmd;
    }

    /// <summary>
    /// Generates a standard update command based on the defined schema attributes in the
    /// referenced business object type.
    /// </summary>
    /// <typeparam name="T">The type of object to generate the command for.  This type must
    /// implement a BusinessBase object."/></typeparam>
    /// <param name="instance">The business object to update.</param>
    /// <returns>A ready-to-execute SqlCommand.</returns>
    /// <remarks>The resulting command will only include SET directives for columns
    /// that have actually changed.  Any columns marked as IsDBGenerated will be 
    /// returned with new values.</remarks>
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
    public static SqlCommand GetUpdateCommand<T>(T instance)
      where T: BusinessBase<T>
    {
      ITableSchema schema = BusinessBase<T>.Schema;
      StringBuilder sb1 = new StringBuilder(200);  // For set list
      StringBuilder sb2 = new StringBuilder(50);   // For primary key filter
      StringBuilder sb3 = new StringBuilder(50);   // For db generated values
      StringBuilder sb4 = new StringBuilder(50);   // For non-identity PK Where
      ColumnAttribute _identcol = schema.IdentityColumn;
      SqlCommand cmd = null;
      SqlCommand tmpCmd = null;
      try
      {
        tmpCmd = new SqlCommand();
        int nw = 1;
        int nx = 1;
        int ny = 1;
        int nz = 1;
        // Get lists/parameters
        foreach (KeyValuePair<string, ColumnAttribute> pk in schema.Cols)
        {
          if (pk.Value.IsVirtual) { continue; }
          // Get value only if necessary
          bool isfielddirty = instance.EditStore.IsFieldDirty(pk.Key);
          if (pk.Value.IsPrimaryKey || (!pk.Value.IsDBGenerated && isfielddirty))
          {
            // use reflection to get the current value of the column
            System.Reflection.FieldInfo field = typeof(T).GetField(pk.Value.Storage,
              BindingFlags.NonPublic | BindingFlags.Instance);
            object curvalue = field.GetValue(instance);
            if (pk.Value.CanBeNull && IsObjectDBNull(curvalue)) { curvalue = DBNull.Value; }

            // process primary keys for update filter (sb2)
            if (pk.Value.IsPrimaryKey)
            {
              string pkparamname = "@pk" + (nw).ToString();
              if (nw > 1) { sb2.Append(" AND "); }
              sb2.AppendFormat("{0}={1}", pk.Value.Name, pkparamname);
              object origvalue = instance.EditStore.GetOriginalValue(pk.Key, curvalue);
              tmpCmd.Parameters.AddWithValue(pkparamname, origvalue);
              nw++;

              // get pk where clause for return values if no identity
              if (schema.IsAnyDBGenerated && _identcol == null)
              {
                string rvparamname = "@rv" + (nz).ToString();
                if (nz > 1) { sb4.Append(" AND "); }
                sb4.AppendFormat("{0}={1}", pk.Value.Name, pkparamname);
                tmpCmd.Parameters.AddWithValue(rvparamname, curvalue);
                nz++;
              }
            }

            // process dirty, not db items into the set list (sb1)
            if (!pk.Value.IsDBGenerated && isfielddirty)
            {
              string paramname = "@v" + (nx).ToString();
              tmpCmd.Parameters.AddWithValue(paramname, curvalue);
              // Append key to command text
              if (nx > 1) { sb1.Append(","); }
              sb1.AppendFormat("{0}={1}", pk.Value.Name, paramname);
              nx++;
            }
          }

          // Create return value column list - non primary key only!
          if (pk.Value.IsDBGenerated && !pk.Value.IsPrimaryKey)
          {
            if (ny > 1) { sb3.Append(","); }
            sb3.Append(pk.Value.Name);
            ny++;
          }
        }

        // Construct command
        StringBuilder sb5 = new StringBuilder(200);  // For final output
        sb5.Append(string.Format("UPDATE TOP (1) {0}\r\nSET {1}\r\nWHERE {2};\r\n", schema.TableName,
          sb1.ToString(), sb2.ToString()));
        // If any DB generated values then add select
        // For Update, include only NON-Primary Key values!
        if (schema.IsAnyDBGenerated && ny > 1)
        {
          sb5.AppendFormat("SELECT {0} FROM {1} WHERE ", sb3.ToString(), schema.TableName);
          if (_identcol != null)  // surrogate key
          {
            sb5.AppendLine(string.Format("{0}=SCOPE_IDENTITY();", _identcol.Name));
          }
          else  // natural key
          {
            sb5.Append(sb4.ToString());
            sb5.AppendLine(";");
          }
        }
        tmpCmd.CommandText = sb5.ToString();
        tmpCmd.CommandType = CommandType.Text;
        cmd = tmpCmd;
        tmpCmd = null;
      }
      finally
      {
        if (tmpCmd != null) { tmpCmd.Dispose(); tmpCmd = null; }
      }
      return cmd;
    }

    /// <summary>
    /// Generates a standard insert command based on the defined schema attributes in the
    /// referenced business object type.
    /// </summary>
    /// <typeparam name="T">The type of object to generate the command for.  This type must
    /// implement a BusinessBase object."/></typeparam>
    /// <param name="instance">The business object to update.</param>
    /// <returns>A ready-to-execute SqlCommand.</returns>
    /// <remarks>The resulting command will only include all defined columns.  Any columns
    /// marked as IsDBGenerated will be returned with new values.</remarks>
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
    public static SqlCommand GetInsertCommand<T>(T instance)
      where T : BusinessBase<T>
    {
      ITableSchema schema = BusinessBase<T>.Schema;
      StringBuilder sb1 = new StringBuilder(150);  // For columns list
      StringBuilder sb2 = new StringBuilder(100);  // For value list
      StringBuilder sb3 = new StringBuilder(50);   // For db generated values
      StringBuilder sb4 = new StringBuilder(50);   // For non-identity PK Where
      ColumnAttribute _identcol = schema.IdentityColumn;
      SqlCommand tmpCmd = null;
      SqlCommand cmd = null;      
      try
      {
        tmpCmd = new SqlCommand();
        int nx = 1;
        int ny = 1;
        int nz = 1;
        // Add editable keys
        foreach (KeyValuePair<string, ColumnAttribute> pk in schema.Cols)
        {
          if (pk.Value.IsVirtual) { continue; }
          if (!pk.Value.IsDBGenerated)  // can't insert db generated values
          {
            // use reflection to get the current value of the column
            System.Reflection.FieldInfo field = typeof(T).GetField(pk.Value.Storage,
              BindingFlags.NonPublic | BindingFlags.Instance);
            object curvalue = field.GetValue(instance);
            if (pk.Value.CanBeNull && IsObjectDBNull(curvalue)) { curvalue = DBNull.Value; }
            // Skip DBNull Parameters for insert!
            if (curvalue != DBNull.Value)
            {
              string paramname = "@v" + (nx).ToString();
              tmpCmd.Parameters.AddWithValue(paramname, curvalue);
              // Append key to command text
              if (nx > 1) { sb1.Append(","); sb2.Append(","); }
              sb1.Append(pk.Value.Name);
              sb2.Append(paramname);
              nx++;
            }

            if (schema.IsAnyDBGenerated && _identcol == null && pk.Value.IsPrimaryKey)
            {
              string pkparamname = "@rv" + (nz).ToString();
              if (nz > 1) { sb4.Append(" AND "); }
              sb4.AppendFormat("{0}={1}", pk.Value.Name, pkparamname);
              tmpCmd.Parameters.AddWithValue(pkparamname, curvalue);
              nz++;
            }
          }
          else
          {
            if (ny > 1) { sb3.Append(","); }
            sb3.Append(pk.Value.Name);
            ny++;
          }
        }
        // Construct command
        StringBuilder sb5 = new StringBuilder(200);  // For final output
        // Add Insert with table name, column list and value list
        sb5.Append(string.Format("INSERT {0} ({1}) VALUES ({2})\r\n", schema.TableName, sb1.ToString(), sb2.ToString()));
        // If any DB generated values then add select
        if (schema.IsAnyDBGenerated)
        {
          sb5.AppendFormat("SELECT {0} FROM {1} WHERE ", sb3.ToString(), schema.TableName);
          if (_identcol != null)  // surrogate key
          {
            sb5.Append(string.Format("{0}=SCOPE_IDENTITY()\r\n", _identcol.Name));
          }
          else  // natural key
          {
            sb5.Append(sb4.ToString());
          }
        }
        tmpCmd.CommandText = sb5.ToString();
        tmpCmd.CommandType = CommandType.Text;
        cmd = tmpCmd;
        tmpCmd = null;
      }
      finally
      {
        if (tmpCmd != null) { tmpCmd.Dispose(); tmpCmd = null; }
      }
      return cmd;
    }

    #endregion

    #region Utility methods

    internal static string MakeSelectTemplate(ITableSchema schema)
    {
      StringBuilder sb = new StringBuilder(100);
      sb.Append("SELECT{0} ");
      int nx = 0;
      foreach (ColumnAttribute col in schema.Cols.Values)
      {
        if (nx++ > 0) { sb.Append(","); }
        sb.Append(col.Name);
      }
      sb.AppendFormat(" FROM {0}", schema.TableName);
      sb.Append(" WITH (NOLOCK){1}{2}");
      return sb.ToString();
    }

    internal static string MakeSelectKeyTemplate(ITableSchema schema)
    {
      StringBuilder sb = new StringBuilder(100);
      sb.Append("SELECT{0} ");
      int nx = 0;
      foreach (ColumnAttribute col in schema.Keys.Values)
      {
        if (nx++ > 0) { sb.Append(","); }
        sb.Append(col.Name);
      }
      sb.AppendFormat(" FROM {0}", schema.TableName);
      sb.Append(" WITH (NOLOCK){1}{2}");
      return sb.ToString();
    }

    internal static string MakeSelectKeyTemplate(ITableSchema schema, string selectTemplate)
    {
      if (!selectTemplate.StartsWith("SELECT{0}")) { throw new Exception("Invalid select template for key query"); }
      int np = selectTemplate.IndexOf(" FROM ");
      if (np < 0) { throw new Exception("Invalid select template for key query"); }

      StringBuilder sb = new StringBuilder(100);
      sb.Append("SELECT{0} ");
      int nx = 0;
      foreach (ColumnAttribute col in schema.Keys.Values)
      {
        if (nx++ > 0) { sb.Append(","); }
        sb.Append(col.Name);
      }
      // Now append everything from the select template starting from the " FROM " marker...
      sb.Append(selectTemplate.Substring(np));
      return sb.ToString();
    }

    internal static string MakeSelectItemTemplate(ITableSchema schema)
    {
      StringBuilder sb = new StringBuilder(100);
      sb.Append("SELECT TOP 1 ");
      int nx = 0;
      foreach (ColumnAttribute col in schema.Cols.Values)
      {
        if (nx++ > 0) { sb.Append(","); }
        sb.Append(col.Name);
      }
      sb.AppendFormat(" FROM {0}", schema.TableName);
      sb.Append(" WITH (NOLOCK) WHERE ");
      nx = 0;
      foreach (ColumnAttribute key in schema.Keys.Values)
      {
        if (nx++ > 0) { sb.Append(" AND "); }
        sb.Append(string.Format("{0}=@{0}", key.Name));
      }
      sb.Append(";");
      return sb.ToString();
    }

    /// <summary>
    /// Detemines whether an object is database null.  Null is 
    /// extended to mean DBNull, null or string.Empty.
    /// </summary>
    /// <param name="arg">The object to test</param>
    /// <returns>True if the object is database null; otherwise false.</returns>
    private static bool IsObjectDBNull(object arg)
    {
      if ((arg == DBNull.Value) || (arg == null) || (string.IsNullOrEmpty(arg.ToString())))
      { return true; }
      return false;
    }

    #endregion
  }
}
