using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace MorphoDataLayer.Framework
{
  /// <summary>
  /// Provides a number of quick, generic methods for invoking pass-through queries
  /// in SQL-Server.
  /// </summary>
  public static class DAOObject
  {
    /// <summary>
    /// Runs the specified stored procedure with the specified parameters and
    /// returns the results in a SQLDataReader.  The caller is responsible for
    /// closing the connection.
    /// </summary>
    /// <param name="cn">The SQL Connection to use.</param>
    /// <param name="commandText">The SQL command to run.</param>
    /// <param name="commandParameters">An array of SqlParameters.</param>
    /// <returns>The results in a SqlDataReader.</returns>
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
    public static SqlDataReader RunSPReturnRS(SqlConnection cn, string commandText, params SqlParameter[] commandParameters)
    {
      SqlDataReader rdr = null;

      using (SqlCommand cmd = new SqlCommand(commandText, cn))
      {
        cmd.CommandType = CommandType.StoredProcedure;

        foreach (SqlParameter p in commandParameters)
        {
          SqlParameter param = cmd.Parameters.Add(p);
          param.Direction = ParameterDirection.Input;
        }

        rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
      }

      return rdr;
    }

    /// <summary>
    /// Runs the specified stored procedure and returns the results in
    /// a SqlDataReader.
    /// </summary>
    /// <param name="cn">The SQL Connection to use.</param>
    /// <param name="commandText">The SQL Command to run.</param>
    /// <returns>A SqlDataReader containing the results.</returns>
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
    public static SqlDataReader RunSPReturnRS(SqlConnection cn, string commandText)
    {
      SqlDataReader rdr = null;

      using (SqlCommand cmd = new SqlCommand(commandText, cn))
      {
        cmd.CommandType = CommandType.StoredProcedure;
        rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
      }

      return rdr;
    }

    /// <summary>
    /// Runs the specified "pass-through" command returns the results as a
    /// recordset.
    /// </summary>
    /// <param name="cn">The SQL connection to use.</param>
    /// <param name="strSQL">The SQL command to run.</param>
    /// <returns>The results in a SqlDataReader.</returns>
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
    public static SqlDataReader RunPassSQL(SqlConnection cn, string strSQL)
    {
      SqlDataReader rdr = null;

      using (SqlCommand cmd = new SqlCommand(strSQL, cn))
      {
        rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
      }
      return rdr;
    }

    /// <summary>
    /// Runs the specified command as an "action query" that is not 
    /// expected to return any results.
    /// </summary>
    /// <param name="commandText">The SQL command to run.</param>
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
    public static void RunActionQuery(string commandText)
    {
		using (SqlConnection cn = DBConnect.NewDataConnection())
      {
        using (SqlCommand cmd = new SqlCommand(commandText, cn))
        {
          cmd.ExecuteNonQuery();
        }
        //cn.Close();
      }
    }

    /// <summary>
    /// Runs the specified stored procedure with the specified parameters and returns
    /// the return value.
    /// </summary>
    /// <param name="commandText">The SQL command text.</param>
    /// <param name="commandParameters">An array of SQLParameter objects.</param>
    /// <returns>An integer containing the stored procedure result.</returns>
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
    public static int RunSPReturnInteger(string commandText, params SqlParameter[] commandParameters)
    {
      int retVal = 0;

	  using (SqlConnection cn = DBConnect.NewDataConnection())
      {
        using (SqlCommand cmd = new SqlCommand(commandText, cn))
        {
          cmd.CommandType = CommandType.StoredProcedure;

          SqlParameter p = cmd.Parameters.Add(new SqlParameter("RetVal", SqlDbType.Int));
          p.Direction = ParameterDirection.ReturnValue;

          foreach (SqlParameter item in commandParameters)
          {
            SqlParameter param = cmd.Parameters.Add(item);
            param.Direction = ParameterDirection.Input;
          }

          cmd.ExecuteNonQuery();
          retVal = System.Convert.ToInt32(cmd.Parameters["RetVal"].Value);
        }
        //cn.Close();
      }
      return retVal;
    }

    /// <summary>
    /// Runs the specified stored procedure with the specified parameters and returns
    /// a scalar (single value) result.  The result set is expected to consist of one
    /// row and one column.
    /// </summary>
    /// <param name="commandText">The SQL command text.</param>
    /// <param name="commandParameters">An array of SQLParameter objects.</param>
    /// <returns>An object containing the stored procedure scalar result.</returns>
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
    public static object RunSPReturnScalar(string commandText, params SqlParameter[] commandParameters)
    {
      object retVal = null;
	  using (SqlConnection cn = DBConnect.NewDataConnection())
      {
        using (SqlCommand cmd = new SqlCommand(commandText, cn))
        {
          cmd.CommandType = CommandType.StoredProcedure;
          foreach (SqlParameter item in commandParameters)
          {
            SqlParameter param = cmd.Parameters.Add(item);
            param.Direction = ParameterDirection.Input;
          }
          retVal = cmd.ExecuteScalar();
        }
        //cn.Close();
      }
      return retVal;
    }

    /// <summary>
    /// Gets whether the specified key exists for the specified table in the
    /// specified column.
    /// </summary>
    /// <param name="tableName">The table to search.</param>
    /// <param name="fieldName">The field to search.</param>
    /// <param name="keyValue">The value to find.</param>
    /// <returns>True if the value exists in the specified field in the specified
    /// table.</returns>
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
    public static bool Exists(string tableName, string fieldName, object keyValue)
    {
      bool exists = false;
	  using (SqlConnection cn = DBConnect.NewDataConnection())
      {
        using (SqlCommand cmd = cn.CreateCommand())
        {
          cmd.CommandType = CommandType.Text;
          cmd.CommandText = string.Format("SELECT TOP 1 {0} FROM {1} WITH (NOLOCK) WHERE {0}=@key", fieldName, tableName);
          cmd.Parameters.AddWithValue("@key", keyValue);
          object result = cmd.ExecuteScalar();
          if (result != null) { exists = true; }
        }
        //cn.Close();
      }
      return exists;
    }

    /// <summary>
    /// Runs the specified stored procedure and returns the results as a data set
    /// </summary>
    /// <param name="commandText">The command to run.</param>
    /// <param name="commandParameters">An array of SqlParameters objects.</param>
    /// <returns>A DataTable containing the results.</returns>
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
    public static DataTable RunSPReturnDataTable(string commandText, params SqlParameter[] commandParameters)
    {
      DataTable dt = null;
      DataTable tmpdt = null;
      try
      {
        tmpdt = new DataTable();
		using (SqlConnection cn = DBConnect.NewDataConnection())
        {
          using (SqlDataAdapter da = new SqlDataAdapter(commandText, cn))
          {
            da.SelectCommand.CommandType = CommandType.StoredProcedure;

            foreach (SqlParameter p in commandParameters)
            {
              da.SelectCommand.Parameters.Add(p);
              p.Direction = ParameterDirection.Input;
            }
            da.Fill(tmpdt);
          }
          //cn.Close();
        }
        dt = tmpdt;
        tmpdt = null;
		return dt;
	  }
      finally
      {
        if (tmpdt != null) { tmpdt.Dispose(); tmpdt = null; }
      }
    }

    /// <summary>
    /// Runs the specified command and returns the results as a data set
    /// </summary>
    /// <param name="commandText">The command to run.</param>
    /// <param name="commandParameters">An array of SqlParameters objects.</param>
    /// <returns>A DataTable containing the results.</returns>
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
    public static DataTable RunCmdReturnDataTable(string commandText, params SqlParameter[] commandParameters)
    {
      DataTable tmpdt = null;
      DataTable dt = null;
      try
      {
        tmpdt = new DataTable();
		using (SqlConnection cn = DBConnect.NewDataConnection())
        {
          using (SqlDataAdapter da = new SqlDataAdapter(commandText, cn))
          {
            da.SelectCommand.CommandType = CommandType.Text;

            foreach (SqlParameter p in commandParameters)
            {
              da.SelectCommand.Parameters.Add(p);
              p.Direction = ParameterDirection.Input;
            }
            da.Fill(dt);
          }
          //cn.Close();
        }
        dt = tmpdt;
        tmpdt = null;
      }
      finally
      {
        if (tmpdt != null) { tmpdt.Dispose(); tmpdt = null; }
      }
      return dt;
    }
  }
}
