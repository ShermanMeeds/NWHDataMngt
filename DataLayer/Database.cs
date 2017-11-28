using System;
using System.Configuration;
using System.Diagnostics;
using System.Data.SqlClient;
using System.Text;

namespace MorphoDataLayer
{
  /// <summary>
  /// Provides access to the business database exposed from the DAL.
  /// </summary>
  public static class Database
  {
    //private const string _defaultconnection = "Data Source=(local);Initial Catalog=Agile;Integrated Security=True";
    private static string _dataconnection = null;
    private static string _securityconnection = null;

    /// <summary>
    /// Explicitly sets the connection string.
    /// </summary>
    /// <param name="connectionstring">The new connection string.</param>
    public static void SetDataConnectString(string connectionstring) { _dataconnection = connectionstring; }

    /// <summary>
    /// Explicity sets the data connection string using the encrypted credentials.
    /// </summary>
    /// <param name="connectstring">The connection string.</param>
    /// <param name="encryptedcredentials">The encrypted credentials.</param>
    public static void SetDataConnectString(string connectstring, string encryptedcredentials)
    {
		CoFormsCrypto crypt = new CoFormsCrypto();
      StringBuilder sb = new StringBuilder(100);
      sb.Append(connectstring);
      sb.Append(";");
      sb.Append(crypt.DecryptFromBase64(encryptedcredentials).Replace("\0", ""));
      _dataconnection = sb.ToString();
      //Debug.WriteLine(_dataconnectstring)
      sb = null;
    }

    /// <summary>
    /// Explicitly sets the security connection string.
    /// </summary>
    /// <param name="connectionstring">The new connection string.</param>
    public static void SetSecurityConnectString(string connectionstring) { _securityconnection = connectionstring; }

    /// <summary>
    /// Gets a new, open database connection using the pre-defined connection string.
    /// </summary>
    /// <returns>A new, open SqlConnection.</returns>
    /// <remarks>The method receiving the new connection is responsible for closing it.</remarks>
    public static SqlConnection NewDataConnection()
    {
      if (string.IsNullOrEmpty(_dataconnection)) { throw new InvalidOperationException("The data connection string has not been specified"); }
      SqlConnection cn = null;
      SqlConnection tmpcn = null;
      try
      {
        tmpcn = new SqlConnection(_dataconnection);
        tmpcn.Open();
        cn = tmpcn;
        tmpcn = null;
      }
      finally
      {
        if (tmpcn != null) { tmpcn.Dispose(); tmpcn = null; }
      }
      return cn;
    }

    /// <summary>
    /// Gets a new, open database connection using the pre-defined security connection string.
    /// </summary>
    /// <returns>A new, open SqlConnection.</returns>
    /// <remarks>The method receiving the new connection is responsible for closing it.</remarks>
    public static SqlConnection NewSecurityConnection()
    {
      if (string.IsNullOrEmpty(_securityconnection)) { throw new InvalidOperationException("The security connection string has not been specified"); }
      SqlConnection cn = null;
      SqlConnection tmpcn = null;
      try
      {

        tmpcn = new SqlConnection(_securityconnection);
        tmpcn.Open();
        cn = tmpcn;
        tmpcn = null;
      }
      finally
      {
        if (tmpcn != null) { tmpcn.Dispose(); tmpcn = null; }
      }
      return cn;
    }

  }
}
