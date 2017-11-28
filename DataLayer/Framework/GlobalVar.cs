using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace MorphoDataLayer
{
  /// <summary>
  /// Provides static methods to manage and retrieve global variables within the
  /// business framework.
  /// </summary>
  public static class GlobalVar
  {
    /// <summary>
    /// Returns the value of the specified global variable.
    /// </summary>
    /// <param name="varName">The name of the variable to retrieve.</param>
    /// <returns>An object containing the global variable value.</returns>
    public static object GetGlobalVar(string varName)
    {
      object gvar = null;
	  using (SqlConnection cn = DBConnect.NewDataConnection())
      {
        using (SqlCommand cmd = cn.CreateCommand())
        {
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.CommandText = "dbo.up_GetGlobalVar";
          cmd.Parameters.AddWithValue("@varName1", varName ?? (object)DBNull.Value);
          using (SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow))
          {
            if (dr.Read())
            {
              gvar = dr[varName];
            }
          }
        }
        //cn.Close();
      }
      return gvar;
    }

    /// <summary>
    /// Gets the values of up to four global variables in a single database
    /// operation.
    /// </summary>
    /// <param name="varName1">The name of the first global variable.</param>
    /// <param name="varName2">The name of the second global variable.</param>
    /// <param name="varName3">The name of the third global variable.</param>
    /// <param name="varName4">The name of the fourth global variable.</param>
    /// <returns>A dictionary of objects that were retrieved.</returns>
    public static Dictionary<string, object> GetGlobalVars(string varName1, string varName2, string varName3, string varName4)
    {
      var gvars = new Dictionary<string, object>();
	  using (SqlConnection cn = DBConnect.NewDataConnection())
      {
        using (SqlCommand cmd = cn.CreateCommand())
        {
          cmd.CommandType = CommandType.StoredProcedure;
          cmd.CommandText = "dbo.up_GetGlobalVar";
          cmd.Parameters.AddWithValue("@varName1", varName1 ?? "");
          cmd.Parameters.AddWithValue("@varName2", varName2 ?? "");
          cmd.Parameters.AddWithValue("@varName3", varName3 ?? "");
          cmd.Parameters.AddWithValue("@varName4", varName4 ?? "");
          using (SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow))
          {
            if (dr.Read())
            {
              if ((varName1 ?? "").Length > 0) { gvars.Add(varName1, dr[varName1]); }
              if ((varName2 ?? "").Length > 0) { gvars.Add(varName2, dr[varName2]); }
              if ((varName3 ?? "").Length > 0) { gvars.Add(varName3, dr[varName3]); }
              if ((varName4 ?? "").Length > 0) { gvars.Add(varName4, dr[varName4]); }
            }
          }
        }
        //cn.Close();
      }
      return gvars;
    }
  }
}
