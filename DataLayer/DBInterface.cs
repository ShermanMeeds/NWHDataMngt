using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Configuration;
using System.Reflection;
using System.Xml;

namespace DataLayer
{
	public class DBInterface
	{
		private int _Timeout = 240;

		public void SetCmdTimeout(int timeoutVal)
		{
			_Timeout = timeoutVal;
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
		public object RunSPReturnScalar(string commandText)
		{
			//, params SqlParameter[] commandParameters)
			object retVal = null;
			using (SqlConnection cn = DBConnect.NewDataConnection())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.CommandType = CommandType.StoredProcedure;
					retVal = cmd.ExecuteScalar();
				}
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
		public object RunSPReturnScalar(string commandText, params SqlParameter[] commandParameters)
		{
			//)
			object retVal = null;
			using (SqlConnection cn = DBConnect.NewDataConnection())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.CommandType = CommandType.StoredProcedure;
					foreach (SqlParameter item in commandParameters)
					{
						SqlParameter param = cmd.Parameters.Add(item);
						param.Direction = ParameterDirection.Input;
					}
					retVal = cmd.ExecuteScalar();
				}
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
		public object RunSPReturnScalarOL(string commandText)
		{
			//, params SqlParameter[] commandParameters)
			object retVal = null;
			using (SqlConnection cn = DBConnect.NewDataConnectionOL())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandType = CommandType.StoredProcedure;
					cmd.CommandTimeout = _Timeout;
					retVal = cmd.ExecuteScalar();
				}
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
		public object RunSPReturnScalarOL(string commandText, params SqlParameter[] commandParameters)
		{
			//)
			object retVal = null;
			using (SqlConnection cn = DBConnect.NewDataConnectionOL())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.CommandType = CommandType.StoredProcedure;
					foreach (SqlParameter item in commandParameters)
					{
						SqlParameter param = cmd.Parameters.Add(item);
						param.Direction = ParameterDirection.Input;
					}
					retVal = cmd.ExecuteScalar();
				}
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
		public object RunSPReturnScalarDW(string commandText)
		{
			//, params SqlParameter[] commandParameters)
			object retVal = null;
			using (SqlConnection cn = DBConnect.NewDataConnectionDW())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.CommandType = CommandType.StoredProcedure;
					retVal = cmd.ExecuteScalar();
				}
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
		public object RunSPReturnScalarDW(string commandText, params SqlParameter[] commandParameters)
		{
			//)
			object retVal = null;
			using (SqlConnection cn = DBConnect.NewDataConnectionDW())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.CommandType = CommandType.StoredProcedure;
					foreach (SqlParameter item in commandParameters)
					{
						SqlParameter param = cmd.Parameters.Add(item);
						param.Direction = ParameterDirection.Input;
					}
					retVal = cmd.ExecuteScalar();
				}
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
		public object RunSPReturnScalarAR(string commandText)
		{
			//, params SqlParameter[] commandParameters)
			object retVal = null;
			using (SqlConnection cn = DBConnect.NewDataConnectionAR())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.CommandType = CommandType.StoredProcedure;
					retVal = cmd.ExecuteScalar();
				}
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
		public object RunSPReturnScalarAR(string commandText, params SqlParameter[] commandParameters)
		{
			//)
			object retVal = null;
			using (SqlConnection cn = DBConnect.NewDataConnectionAR())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.CommandType = CommandType.StoredProcedure;
					foreach (SqlParameter item in commandParameters)
					{
						SqlParameter param = cmd.Parameters.Add(item);
						param.Direction = ParameterDirection.Input;
					}
					retVal = cmd.ExecuteScalar();
				}
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
		public object RunSPReturnScalarAD(string commandText)
		{
			//, params SqlParameter[] commandParameters)
			object retVal = null;
			using (SqlConnection cn = DBConnect.NewDataConnectionAD())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.CommandType = CommandType.StoredProcedure;
					retVal = cmd.ExecuteScalar();
				}
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
		public object RunSPReturnScalarAD(string commandText, params SqlParameter[] commandParameters)
		{
			//)
			object retVal = null;
			using (SqlConnection cn = DBConnect.NewDataConnectionAD())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.CommandType = CommandType.StoredProcedure;
					foreach (SqlParameter item in commandParameters)
					{
						SqlParameter param = cmd.Parameters.Add(item);
						param.Direction = ParameterDirection.Input;
					}
					retVal = cmd.ExecuteScalar();
				}
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
		public object RunSPReturnScalarHC(string commandText)
		{
			//, params SqlParameter[] commandParameters)
			object retVal = null;
			using (SqlConnection cn = DBConnect.NewDataConnectionHC())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.CommandType = CommandType.StoredProcedure;
					retVal = cmd.ExecuteScalar();
				}
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
		public object RunSPReturnScalarHC(string commandText, params SqlParameter[] commandParameters)
		{
			//)
			object retVal = null;
			using (SqlConnection cn = DBConnect.NewDataConnectionHC())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.CommandType = CommandType.StoredProcedure;
					foreach (SqlParameter item in commandParameters)
					{
						SqlParameter param = cmd.Parameters.Add(item);
						param.Direction = ParameterDirection.Input;
					}
					retVal = cmd.ExecuteScalar();
				}
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
		public object RunSPReturnScalarHD(string commandText)
		{
			//, params SqlParameter[] commandParameters)
			object retVal = null;
			using (SqlConnection cn = DBConnect.NewDataConnectionHD())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.CommandType = CommandType.StoredProcedure;
					retVal = cmd.ExecuteScalar();
				}
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
		public object RunSPReturnScalarHD(string commandText, params SqlParameter[] commandParameters)
		{
			//)
			object retVal = null;
			using (SqlConnection cn = DBConnect.NewDataConnectionHD())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.CommandType = CommandType.StoredProcedure;
					foreach (SqlParameter item in commandParameters)
					{
						SqlParameter param = cmd.Parameters.Add(item);
						param.Direction = ParameterDirection.Input;
					}
					retVal = cmd.ExecuteScalar();
				}
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
		public object RunSPReturnScalarNWB(string commandText)
		{
			//, params SqlParameter[] commandParameters)
			object retVal = null;
			using (SqlConnection cn = DBConnect.NewDataConnectionNWB())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.CommandType = CommandType.StoredProcedure;
					retVal = cmd.ExecuteScalar();
				}
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
		public object RunSPReturnScalarNWB(string commandText, params SqlParameter[] commandParameters)
		{
			//)
			object retVal = null;
			using (SqlConnection cn = DBConnect.NewDataConnectionNWB())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.CommandType = CommandType.StoredProcedure;
					foreach (SqlParameter item in commandParameters)
					{
						SqlParameter param = cmd.Parameters.Add(item);
						param.Direction = ParameterDirection.Input;
					}
					retVal = cmd.ExecuteScalar();
				}
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
		public object RunSPReturnScalarNWDW(string commandText)
		{
			//, params SqlParameter[] commandParameters)
			object retVal = null;
			using (SqlConnection cn = DBConnect.NewDataConnectionNWDW())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.CommandType = CommandType.StoredProcedure;
					retVal = cmd.ExecuteScalar();
				}
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
		public object RunSPReturnScalarNWDW(string commandText, params SqlParameter[] commandParameters)
		{
			//)
			object retVal = null;
			using (SqlConnection cn = DBConnect.NewDataConnectionNWDW())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.CommandType = CommandType.StoredProcedure;
					foreach (SqlParameter item in commandParameters)
					{
						SqlParameter param = cmd.Parameters.Add(item);
						param.Direction = ParameterDirection.Input;
					}
					retVal = cmd.ExecuteScalar();
				}
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
		public object RunSPReturnScalarNWM(string commandText)
		{
			//, params SqlParameter[] commandParameters)
			object retVal = null;
			using (SqlConnection cn = DBConnect.NewDataConnectionNWM())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.CommandType = CommandType.StoredProcedure;
					retVal = cmd.ExecuteScalar();
				}
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
		public object RunSPReturnScalarNWM(string commandText, params SqlParameter[] commandParameters)
		{
			//)
			object retVal = null;
			using (SqlConnection cn = DBConnect.NewDataConnectionNWM())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.CommandType = CommandType.StoredProcedure;
					foreach (SqlParameter item in commandParameters)
					{
						SqlParameter param = cmd.Parameters.Add(item);
						param.Direction = ParameterDirection.Input;
					}
					retVal = cmd.ExecuteScalar();
				}
			}
			return retVal;
		}

		// ***************************************************************************************************

		/// <summary>
		/// Runs the specified stored procedure with the specified parameters and returns
		/// a scalar (single value) result.  The result set is expected to consist of one
		/// row and one column.
		/// </summary>
		/// <param name="commandText">The SQL command text.</param>
		/// <param name="commandParameters">An array of SQLParameter objects.</param>
		/// <returns>An object containing the stored procedure scalar result.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public object RunSPReturnScalar2(string commandText)
		{
			//)
			object retVal = null;
			using (SqlConnection cn = DBConnect.NewDataConnection())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.CommandType = CommandType.StoredProcedure;
					retVal = cmd.ExecuteScalar();
				}
			}
			return retVal;
		}

		private void FillData(PropertyInfo[] properties, DataTable dt, Object o)
		{
			DataRow dr = dt.NewRow();
			foreach (PropertyInfo pi in properties)
			{
				dr[pi.Name] = pi.GetValue(o, null);
			}
			dt.Rows.Add(dr);
		}

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
		public SqlDataReader RunSPReturnRS(SqlConnection cn, string commandText, params SqlParameter[] commandParameters)
		{
			SqlDataReader rdr = null;

			using (SqlCommand cmd = new SqlCommand(commandText, cn))
			{
				cmd.CommandTimeout = _Timeout;
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
		public SqlDataReader RunSPReturnRS(SqlConnection cn, string commandText)
		{
			SqlDataReader rdr = null;

			using (SqlCommand cmd = new SqlCommand(commandText, cn))
			{
				cmd.CommandTimeout = _Timeout;
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
		public SqlDataReader RunPassSQL(SqlConnection cn, string strSQL)
		{
			SqlDataReader rdr = null;

			using (SqlCommand cmd = new SqlCommand(strSQL, cn))
			{
				cmd.CommandTimeout = _Timeout;
				rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
			}
			return rdr;
		}

		// ***************************************************************************************************

		/// <summary>
		/// Runs the specified command as an "action query" that is not 
		/// expected to return any results.
		/// </summary>
		/// <param name="commandText">The SQL command to run.</param>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public void RunActionQuery(string commandText)
		{
			using (SqlConnection cn = DBConnect.NewDataConnection())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.ExecuteNonQuery();
				}
			}
		}

		/// <summary>
		/// Runs the specified command as an "action query" that is not 
		/// expected to return any results.
		/// </summary>
		/// <param name="commandText">The SQL command to run.</param>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public void RunActionQueryOL(string commandText)
		{
			using (SqlConnection cn = DBConnect.NewDataConnectionOL())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.ExecuteNonQuery();
				}
			}
		}

		/// <summary>
		/// Runs the specified command as an "action query" that is not 
		/// expected to return any results.
		/// </summary>
		/// <param name="commandText">The SQL command to run.</param>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public void RunActionQueryDW(string commandText)
		{
			using (SqlConnection cn = DBConnect.NewDataConnectionDW())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.ExecuteNonQuery();
				}
			}
		}

		/// <summary>
		/// Runs the specified command as an "action query" that is not 
		/// expected to return any results.
		/// </summary>
		/// <param name="commandText">The SQL command to run.</param>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public void RunActionQueryAR(string commandText)
		{
			using (SqlConnection cn = DBConnect.NewDataConnectionAR())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.ExecuteNonQuery();
				}
			}
		}

		/// <summary>
		/// Runs the specified command as an "action query" that is not 
		/// expected to return any results.
		/// </summary>
		/// <param name="commandText">The SQL command to run.</param>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public void RunActionQueryAD(string commandText)
		{
			using (SqlConnection cn = DBConnect.NewDataConnectionAD())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.ExecuteNonQuery();
				}
			}
		}

		/// <summary>
		/// Runs the specified command as an "action query" that is not 
		/// expected to return any results.
		/// </summary>
		/// <param name="commandText">The SQL command to run.</param>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public void RunActionQueryHC(string commandText)
		{
			using (SqlConnection cn = DBConnect.NewDataConnectionHC())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.ExecuteNonQuery();
				}
			}
		}

		/// <summary>
		/// Runs the specified command as an "action query" that is not 
		/// expected to return any results.
		/// </summary>
		/// <param name="commandText">The SQL command to run.</param>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public void RunActionQueryHD(string commandText)
		{
			using (SqlConnection cn = DBConnect.NewDataConnectionHD())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.ExecuteNonQuery();
				}
			}
		}

		/// <summary>
		/// Runs the specified command as an "action query" that is not 
		/// expected to return any results.
		/// </summary>
		/// <param name="commandText">The SQL command to run.</param>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public void RunActionQueryNWB(string commandText)
		{
			using (SqlConnection cn = DBConnect.NewDataConnectionNWB())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.ExecuteNonQuery();
				}
			}
		}

		/// <summary>
		/// Runs the specified command as an "action query" that is not 
		/// expected to return any results.
		/// </summary>
		/// <param name="commandText">The SQL command to run.</param>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public void RunActionQueryNWDW(string commandText)
		{
			using (SqlConnection cn = DBConnect.NewDataConnectionNWDW())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.ExecuteNonQuery();
				}
			}
		}

		/// <summary>
		/// Runs the specified command as an "action query" that is not 
		/// expected to return any results.
		/// </summary>
		/// <param name="commandText">The SQL command to run.</param>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public void RunActionQueryNWM(string commandText)
		{
			using (SqlConnection cn = DBConnect.NewDataConnectionNWM())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
					cmd.ExecuteNonQuery();
				}
			}
		}

		// ***************************************************************************************************

		/// <summary>
		/// Runs the specified stored procedure with the specified parameters and returns
		/// the return value.
		/// </summary>
		/// <param name="commandText">The SQL command text.</param>
		/// <param name="commandParameters">An array of SQLParameter objects.</param>
		/// <returns>An integer containing the stored procedure result.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public int RunSPReturnInteger(string commandText, params SqlParameter[] commandParameters)
		{
			int retVal = 0;

			using (SqlConnection cn = DBConnect.NewDataConnection())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
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
			}
			return retVal;
		}

		/// <summary>
		/// Runs the specified stored procedure with the specified parameters and returns
		/// the return value.
		/// </summary>
		/// <param name="commandText">The SQL command text.</param>
		/// <param name="commandParameters">An array of SQLParameter objects.</param>
		/// <returns>An integer containing the stored procedure result.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public int RunSPReturnIntegerOL(string commandText, params SqlParameter[] commandParameters)
		{
			int retVal = 0;

			using (SqlConnection cn = DBConnect.NewDataConnectionOL())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
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
			}
			return retVal;
		}

		/// <summary>
		/// Runs the specified stored procedure with the specified parameters and returns
		/// the return value.
		/// </summary>
		/// <param name="commandText">The SQL command text.</param>
		/// <param name="commandParameters">An array of SQLParameter objects.</param>
		/// <returns>An integer containing the stored procedure result.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public int RunSPReturnIntegerDW(string commandText, params SqlParameter[] commandParameters)
		{
			int retVal = 0;

			using (SqlConnection cn = DBConnect.NewDataConnectionDW())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
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
			}
			return retVal;
		}

		/// <summary>
		/// Runs the specified stored procedure with the specified parameters and returns
		/// the return value.
		/// </summary>
		/// <param name="commandText">The SQL command text.</param>
		/// <param name="commandParameters">An array of SQLParameter objects.</param>
		/// <returns>An integer containing the stored procedure result.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public int RunSPReturnIntegerAR(string commandText, params SqlParameter[] commandParameters)
		{
			int retVal = 0;

			using (SqlConnection cn = DBConnect.NewDataConnectionAR())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
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
			}
			return retVal;
		}

		/// <summary>
		/// Runs the specified stored procedure with the specified parameters and returns
		/// the return value.
		/// </summary>
		/// <param name="commandText">The SQL command text.</param>
		/// <param name="commandParameters">An array of SQLParameter objects.</param>
		/// <returns>An integer containing the stored procedure result.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public int RunSPReturnIntegerAD(string commandText, params SqlParameter[] commandParameters)
		{
			int retVal = 0;

			using (SqlConnection cn = DBConnect.NewDataConnectionAD())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
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
			}
			return retVal;
		}

		/// <summary>
		/// Runs the specified stored procedure with the specified parameters and returns
		/// the return value.
		/// </summary>
		/// <param name="commandText">The SQL command text.</param>
		/// <param name="commandParameters">An array of SQLParameter objects.</param>
		/// <returns>An integer containing the stored procedure result.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public int RunSPReturnIntegerHC(string commandText, params SqlParameter[] commandParameters)
		{
			int retVal = 0;

			using (SqlConnection cn = DBConnect.NewDataConnectionHC())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
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
			}
			return retVal;
		}

		/// <summary>
		/// Runs the specified stored procedure with the specified parameters and returns
		/// the return value.
		/// </summary>
		/// <param name="commandText">The SQL command text.</param>
		/// <param name="commandParameters">An array of SQLParameter objects.</param>
		/// <returns>An integer containing the stored procedure result.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public int RunSPReturnIntegerHD(string commandText, params SqlParameter[] commandParameters)
		{
			int retVal = 0;

			using (SqlConnection cn = DBConnect.NewDataConnectionHD())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
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
			}
			return retVal;
		}

		/// <summary>
		/// Runs the specified stored procedure with the specified parameters and returns
		/// the return value.
		/// </summary>
		/// <param name="commandText">The SQL command text.</param>
		/// <param name="commandParameters">An array of SQLParameter objects.</param>
		/// <returns>An integer containing the stored procedure result.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public int RunSPReturnIntegerNWB(string commandText, params SqlParameter[] commandParameters)
		{
			int retVal = 0;

			using (SqlConnection cn = DBConnect.NewDataConnectionNWB())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
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
			}
			return retVal;
		}

		/// <summary>
		/// Runs the specified stored procedure with the specified parameters and returns
		/// the return value.
		/// </summary>
		/// <param name="commandText">The SQL command text.</param>
		/// <param name="commandParameters">An array of SQLParameter objects.</param>
		/// <returns>An integer containing the stored procedure result.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public int RunSPReturnIntegerNWDW(string commandText, params SqlParameter[] commandParameters)
		{
			int retVal = 0;

			using (SqlConnection cn = DBConnect.NewDataConnectionNWDW())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
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
			}
			return retVal;
		}

		/// <summary>
		/// Runs the specified stored procedure with the specified parameters and returns
		/// the return value.
		/// </summary>
		/// <param name="commandText">The SQL command text.</param>
		/// <param name="commandParameters">An array of SQLParameter objects.</param>
		/// <returns>An integer containing the stored procedure result.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public int RunSPReturnIntegerNWM(string commandText, params SqlParameter[] commandParameters)
		{
			int retVal = 0;

			using (SqlConnection cn = DBConnect.NewDataConnectionNWM())
			{
				using (SqlCommand cmd = new SqlCommand(commandText, cn))
				{
					cmd.CommandTimeout = _Timeout;
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
			}
			return retVal;
		}

		// ***************************************************************************************************

		/// <summary>
		/// Runs the specified stored procedure and returns the results as a data set
		/// </summary>
		/// <param name="commandText">The command to run.</param>
		/// <param name="commandParameters">An array of SqlParameters objects.</param>
		/// <returns>A DataTable containing the results.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public DataTable RunSPReturnDataTable(string commandText, params SqlParameter[] commandParameters)
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
						da.SelectCommand.CommandTimeout = _Timeout;

						foreach (SqlParameter p in commandParameters)
						{
							da.SelectCommand.Parameters.Add(p);
							p.Direction = ParameterDirection.Input;
						}
						da.Fill(tmpdt);
					}
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
		/// Runs the specified stored procedure and returns the results as a data set
		/// </summary>
		/// <param name="commandText">The command to run.</param>
		/// <param name="commandParameters">An array of SqlParameters objects.</param>
		/// <returns>A DataTable containing the results.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public DataTable RunSPReturnDataTableOL(string commandText, params SqlParameter[] commandParameters)
		{
			DataTable dt = null;
			DataTable tmpdt = null;
			try
			{
				tmpdt = new DataTable();
				using (SqlConnection cn = DBConnect.NewDataConnectionOL())
				{
					using (SqlDataAdapter da = new SqlDataAdapter(commandText, cn))
					{
						da.SelectCommand.CommandType = CommandType.StoredProcedure;
						da.SelectCommand.CommandTimeout = _Timeout;

						foreach (SqlParameter p in commandParameters)
						{
							da.SelectCommand.Parameters.Add(p);
							p.Direction = ParameterDirection.Input;
						}
						da.Fill(tmpdt);
					}
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
		/// Runs the specified stored procedure and returns the results as a data set
		/// </summary>
		/// <param name="commandText">The command to run.</param>
		/// <param name="commandParameters">An array of SqlParameters objects.</param>
		/// <returns>A DataTable containing the results.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public DataTable RunSPReturnDataTableDW(string commandText, params SqlParameter[] commandParameters)
		{
			DataTable dt = null;
			DataTable tmpdt = null;
			try
			{
				tmpdt = new DataTable();
				using (SqlConnection cn = DBConnect.NewDataConnectionDW())
				{
					using (SqlDataAdapter da = new SqlDataAdapter(commandText, cn))
					{
						da.SelectCommand.CommandType = CommandType.StoredProcedure;
						da.SelectCommand.CommandTimeout = _Timeout;

						foreach (SqlParameter p in commandParameters)
						{
							da.SelectCommand.Parameters.Add(p);
							p.Direction = ParameterDirection.Input;
						}
						da.Fill(tmpdt);
					}
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
		/// Runs the specified stored procedure and returns the results as a data set
		/// </summary>
		/// <param name="commandText">The command to run.</param>
		/// <param name="commandParameters">An array of SqlParameters objects.</param>
		/// <returns>A DataTable containing the results.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public DataTable RunSPReturnDataTableAR(string commandText, params SqlParameter[] commandParameters)
		{
			DataTable dt = null;
			DataTable tmpdt = null;
			try
			{
				tmpdt = new DataTable();
				using (SqlConnection cn = DBConnect.NewDataConnectionAR())
				{
					using (SqlDataAdapter da = new SqlDataAdapter(commandText, cn))
					{
						da.SelectCommand.CommandType = CommandType.StoredProcedure;
						da.SelectCommand.CommandTimeout = _Timeout;

						foreach (SqlParameter p in commandParameters)
						{
							da.SelectCommand.Parameters.Add(p);
							p.Direction = ParameterDirection.Input;
						}
						da.Fill(tmpdt);
					}
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
		/// Runs the specified stored procedure and returns the results as a data set
		/// </summary>
		/// <param name="commandText">The command to run.</param>
		/// <param name="commandParameters">An array of SqlParameters objects.</param>
		/// <returns>A DataTable containing the results.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public DataTable RunSPReturnDataTableAD(string commandText, params SqlParameter[] commandParameters)
		{
			DataTable dt = null;
			DataTable tmpdt = null;
			try
			{
				tmpdt = new DataTable();
				using (SqlConnection cn = DBConnect.NewDataConnectionAD())
				{
					using (SqlDataAdapter da = new SqlDataAdapter(commandText, cn))
					{
						da.SelectCommand.CommandType = CommandType.StoredProcedure;
						da.SelectCommand.CommandTimeout = _Timeout;

						foreach (SqlParameter p in commandParameters)
						{
							da.SelectCommand.Parameters.Add(p);
							p.Direction = ParameterDirection.Input;
						}
						da.Fill(tmpdt);
					}
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
		/// Runs the specified stored procedure and returns the results as a data set
		/// </summary>
		/// <param name="commandText">The command to run.</param>
		/// <param name="commandParameters">An array of SqlParameters objects.</param>
		/// <returns>A DataTable containing the results.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public DataTable RunSPReturnDataTableHC(string commandText, params SqlParameter[] commandParameters)
		{
			DataTable dt = null;
			DataTable tmpdt = null;
			try
			{
				tmpdt = new DataTable();
				using (SqlConnection cn = DBConnect.NewDataConnectionHC())
				{
					using (SqlDataAdapter da = new SqlDataAdapter(commandText, cn))
					{
						da.SelectCommand.CommandType = CommandType.StoredProcedure;
						da.SelectCommand.CommandTimeout = _Timeout;

						foreach (SqlParameter p in commandParameters)
						{
							da.SelectCommand.Parameters.Add(p);
							p.Direction = ParameterDirection.Input;
						}
						da.Fill(tmpdt);
					}
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
		/// Runs the specified stored procedure and returns the results as a data set
		/// </summary>
		/// <param name="commandText">The command to run.</param>
		/// <param name="commandParameters">An array of SqlParameters objects.</param>
		/// <returns>A DataTable containing the results.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public DataTable RunSPReturnDataTableHD(string commandText, params SqlParameter[] commandParameters)
		{
			DataTable dt = null;
			DataTable tmpdt = null;
			try
			{
				tmpdt = new DataTable();
				using (SqlConnection cn = DBConnect.NewDataConnectionHD())
				{
					using (SqlDataAdapter da = new SqlDataAdapter(commandText, cn))
					{
						da.SelectCommand.CommandType = CommandType.StoredProcedure;
						da.SelectCommand.CommandTimeout = _Timeout;

						foreach (SqlParameter p in commandParameters)
						{
							da.SelectCommand.Parameters.Add(p);
							p.Direction = ParameterDirection.Input;
						}
						da.Fill(tmpdt);
					}
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
		/// Runs the specified stored procedure and returns the results as a data set
		/// </summary>
		/// <param name="commandText">The command to run.</param>
		/// <param name="commandParameters">An array of SqlParameters objects.</param>
		/// <returns>A DataTable containing the results.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public DataTable RunSPReturnDataTableNWB(string commandText, params SqlParameter[] commandParameters)
		{
			DataTable dt = null;
			DataTable tmpdt = null;
			try
			{
				tmpdt = new DataTable();
				using (SqlConnection cn = DBConnect.NewDataConnectionNWB())
				{
					using (SqlDataAdapter da = new SqlDataAdapter(commandText, cn))
					{
						da.SelectCommand.CommandType = CommandType.StoredProcedure;
						da.SelectCommand.CommandTimeout = _Timeout;

						foreach (SqlParameter p in commandParameters)
						{
							da.SelectCommand.Parameters.Add(p);
							p.Direction = ParameterDirection.Input;
						}
						da.Fill(tmpdt);
					}
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
		/// Runs the specified stored procedure and returns the results as a data set
		/// </summary>
		/// <param name="commandText">The command to run.</param>
		/// <param name="commandParameters">An array of SqlParameters objects.</param>
		/// <returns>A DataTable containing the results.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public DataTable RunSPReturnDataTableNWDW(string commandText, params SqlParameter[] commandParameters)
		{
			DataTable dt = null;
			DataTable tmpdt = null;
			try
			{
				tmpdt = new DataTable();
				using (SqlConnection cn = DBConnect.NewDataConnectionNWDW())
				{
					using (SqlDataAdapter da = new SqlDataAdapter(commandText, cn))
					{
						da.SelectCommand.CommandType = CommandType.StoredProcedure;
						da.SelectCommand.CommandTimeout = _Timeout;

						foreach (SqlParameter p in commandParameters)
						{
							da.SelectCommand.Parameters.Add(p);
							p.Direction = ParameterDirection.Input;
						}
						da.Fill(tmpdt);
					}
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
		/// Runs the specified stored procedure and returns the results as a data set
		/// </summary>
		/// <param name="commandText">The command to run.</param>
		/// <param name="commandParameters">An array of SqlParameters objects.</param>
		/// <returns>A DataTable containing the results.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public DataTable RunSPReturnDataTableNWM(string commandText, params SqlParameter[] commandParameters)
		{
			DataTable dt = null;
			DataTable tmpdt = null;
			try
			{
				tmpdt = new DataTable();
				using (SqlConnection cn = DBConnect.NewDataConnectionNWM())
				{
					using (SqlDataAdapter da = new SqlDataAdapter(commandText, cn))
					{
						da.SelectCommand.CommandType = CommandType.StoredProcedure;
						da.SelectCommand.CommandTimeout = _Timeout;

						foreach (SqlParameter p in commandParameters)
						{
							da.SelectCommand.Parameters.Add(p);
							p.Direction = ParameterDirection.Input;
						}
						da.Fill(tmpdt);
					}
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

		// ***************************************************************************************************

		/// <summary>
		/// Runs the specified command and returns the results as a data set
		/// </summary>
		/// <param name="commandText">The command to run.</param>
		/// <param name="commandParameters">An array of SqlParameters objects.</param>
		/// <returns>A DataTable containing the results.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public DataTable RunCmdReturnDataTable(string commandText, params SqlParameter[] commandParameters)
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
						da.SelectCommand.CommandType = CommandType.Text;
						da.SelectCommand.CommandTimeout = _Timeout;

						foreach (SqlParameter p in commandParameters)
						{
							da.SelectCommand.Parameters.Add(p);
							p.Direction = ParameterDirection.Input;
						}
						da.Fill(tmpdt);
					}
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

		/// <summary>
		/// Runs the specified command and returns the results as a data set
		/// </summary>
		/// <param name="commandText">The command to run.</param>
		/// <param name="commandParameters">An array of SqlParameters objects.</param>
		/// <returns>A DataTable containing the results.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public DataTable RunCmdReturnDataTableOL(string commandText, params SqlParameter[] commandParameters)
		{
			DataTable dt = null;
			DataTable tmpdt = null;
			try
			{
				tmpdt = new DataTable();
				using (SqlConnection cn = DBConnect.NewDataConnectionOL())
				{
					using (SqlDataAdapter da = new SqlDataAdapter(commandText, cn))
					{
						da.SelectCommand.CommandType = CommandType.Text;
						da.SelectCommand.CommandTimeout = _Timeout;

						foreach (SqlParameter p in commandParameters)
						{
							da.SelectCommand.Parameters.Add(p);
							p.Direction = ParameterDirection.Input;
						}
						da.Fill(tmpdt);
					}
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

		/// <summary>
		/// Runs the specified command and returns the results as a data set
		/// </summary>
		/// <param name="commandText">The command to run.</param>
		/// <param name="commandParameters">An array of SqlParameters objects.</param>
		/// <returns>A DataTable containing the results.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public DataTable RunCmdReturnDataTableDW(string commandText, params SqlParameter[] commandParameters)
		{
			DataTable dt = null;
			DataTable tmpdt = null;
			try
			{
				tmpdt = new DataTable();
				using (SqlConnection cn = DBConnect.NewDataConnectionDW())
				{
					using (SqlDataAdapter da = new SqlDataAdapter(commandText, cn))
					{
						da.SelectCommand.CommandType = CommandType.Text;
						da.SelectCommand.CommandTimeout = _Timeout;

						foreach (SqlParameter p in commandParameters)
						{
							da.SelectCommand.Parameters.Add(p);
							p.Direction = ParameterDirection.Input;
						}
						da.Fill(tmpdt);
					}
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

		/// <summary>
		/// Runs the specified command and returns the results as a data set
		/// </summary>
		/// <param name="commandText">The command to run.</param>
		/// <param name="commandParameters">An array of SqlParameters objects.</param>
		/// <returns>A DataTable containing the results.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public DataTable RunCmdReturnDataTableAR(string commandText, params SqlParameter[] commandParameters)
		{
			DataTable dt = null;
			DataTable tmpdt = null;
			try
			{
				tmpdt = new DataTable();
				using (SqlConnection cn = DBConnect.NewDataConnectionAR())
				{
					using (SqlDataAdapter da = new SqlDataAdapter(commandText, cn))
					{
						da.SelectCommand.CommandType = CommandType.Text;
						da.SelectCommand.CommandTimeout = _Timeout;

						foreach (SqlParameter p in commandParameters)
						{
							da.SelectCommand.Parameters.Add(p);
							p.Direction = ParameterDirection.Input;
						}
						da.Fill(tmpdt);
					}
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

		/// <summary>
		/// Runs the specified command and returns the results as a data set
		/// </summary>
		/// <param name="commandText">The command to run.</param>
		/// <param name="commandParameters">An array of SqlParameters objects.</param>
		/// <returns>A DataTable containing the results.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public DataTable RunCmdReturnDataTableAD(string commandText, params SqlParameter[] commandParameters)
		{
			DataTable dt = null;
			DataTable tmpdt = null;
			try
			{
				tmpdt = new DataTable();
				using (SqlConnection cn = DBConnect.NewDataConnectionAD())
				{
					using (SqlDataAdapter da = new SqlDataAdapter(commandText, cn))
					{
						da.SelectCommand.CommandType = CommandType.Text;
						da.SelectCommand.CommandTimeout = _Timeout;

						foreach (SqlParameter p in commandParameters)
						{
							da.SelectCommand.Parameters.Add(p);
							p.Direction = ParameterDirection.Input;
						}
						da.Fill(tmpdt);
					}
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

		/// <summary>
		/// Runs the specified command and returns the results as a data set
		/// </summary>
		/// <param name="commandText">The command to run.</param>
		/// <param name="commandParameters">An array of SqlParameters objects.</param>
		/// <returns>A DataTable containing the results.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public DataTable RunCmdReturnDataTableHC(string commandText, params SqlParameter[] commandParameters)
		{
			DataTable dt = null;
			DataTable tmpdt = null;
			try
			{
				tmpdt = new DataTable();
				using (SqlConnection cn = DBConnect.NewDataConnectionHC())
				{
					using (SqlDataAdapter da = new SqlDataAdapter(commandText, cn))
					{
						da.SelectCommand.CommandType = CommandType.Text;
						da.SelectCommand.CommandTimeout = _Timeout;

						foreach (SqlParameter p in commandParameters)
						{
							da.SelectCommand.Parameters.Add(p);
							p.Direction = ParameterDirection.Input;
						}
						da.Fill(tmpdt);
					}
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

		/// <summary>
		/// Runs the specified command and returns the results as a data set
		/// </summary>
		/// <param name="commandText">The command to run.</param>
		/// <param name="commandParameters">An array of SqlParameters objects.</param>
		/// <returns>A DataTable containing the results.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public DataTable RunCmdReturnDataTableHD(string commandText, params SqlParameter[] commandParameters)
		{
			DataTable dt = null;
			DataTable tmpdt = null;
			try
			{
				tmpdt = new DataTable();
				using (SqlConnection cn = DBConnect.NewDataConnectionHD())
				{
					using (SqlDataAdapter da = new SqlDataAdapter(commandText, cn))
					{
						da.SelectCommand.CommandType = CommandType.Text;
						da.SelectCommand.CommandTimeout = _Timeout;

						foreach (SqlParameter p in commandParameters)
						{
							da.SelectCommand.Parameters.Add(p);
							p.Direction = ParameterDirection.Input;
						}
						da.Fill(tmpdt);
					}
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

		/// <summary>
		/// Runs the specified command and returns the results as a data set
		/// </summary>
		/// <param name="commandText">The command to run.</param>
		/// <param name="commandParameters">An array of SqlParameters objects.</param>
		/// <returns>A DataTable containing the results.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public DataTable RunCmdReturnDataTableNWB(string commandText, params SqlParameter[] commandParameters)
		{
			DataTable dt = null;
			DataTable tmpdt = null;
			try
			{
				tmpdt = new DataTable();
				using (SqlConnection cn = DBConnect.NewDataConnectionNWB())
				{
					using (SqlDataAdapter da = new SqlDataAdapter(commandText, cn))
					{
						da.SelectCommand.CommandType = CommandType.Text;
						da.SelectCommand.CommandTimeout = _Timeout;

						foreach (SqlParameter p in commandParameters)
						{
							da.SelectCommand.Parameters.Add(p);
							p.Direction = ParameterDirection.Input;
						}
						da.Fill(tmpdt);
					}
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

		/// <summary>
		/// Runs the specified command and returns the results as a data set
		/// </summary>
		/// <param name="commandText">The command to run.</param>
		/// <param name="commandParameters">An array of SqlParameters objects.</param>
		/// <returns>A DataTable containing the results.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public DataTable RunCmdReturnDataTableNWDW(string commandText, params SqlParameter[] commandParameters)
		{
			DataTable dt = null;
			DataTable tmpdt = null;
			try
			{
				tmpdt = new DataTable();
				using (SqlConnection cn = DBConnect.NewDataConnectionNWDW())
				{
					using (SqlDataAdapter da = new SqlDataAdapter(commandText, cn))
					{
						da.SelectCommand.CommandType = CommandType.Text;
						da.SelectCommand.CommandTimeout = _Timeout;

						foreach (SqlParameter p in commandParameters)
						{
							da.SelectCommand.Parameters.Add(p);
							p.Direction = ParameterDirection.Input;
						}
						da.Fill(tmpdt);
					}
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

		/// <summary>
		/// Runs the specified command and returns the results as a data set
		/// </summary>
		/// <param name="commandText">The command to run.</param>
		/// <param name="commandParameters">An array of SqlParameters objects.</param>
		/// <returns>A DataTable containing the results.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public DataTable RunCmdReturnDataTableNWM(string commandText, params SqlParameter[] commandParameters)
		{
			DataTable dt = null;
			DataTable tmpdt = null;
			try
			{
				tmpdt = new DataTable();
				using (SqlConnection cn = DBConnect.NewDataConnectionNWM())
				{
					using (SqlDataAdapter da = new SqlDataAdapter(commandText, cn))
					{
						da.SelectCommand.CommandType = CommandType.Text;
						da.SelectCommand.CommandTimeout = _Timeout;

						foreach (SqlParameter p in commandParameters)
						{
							da.SelectCommand.Parameters.Add(p);
							p.Direction = ParameterDirection.Input;
						}
						da.Fill(tmpdt);
					}
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

		// ***************************************************************************************************

		/// <summary>
		/// Runs the specified stored procedure and returns the results as a data set
		/// </summary>
		/// <param name="commandText">The command to run.</param>
		/// <param name="commandParameters">An array of SqlParameters objects.</param>
		/// <returns>A DataTable containing the results.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public DataTable RunSPReturnDataTableS(string commandText)
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
						da.SelectCommand.CommandType = CommandType.Text;
						da.SelectCommand.CommandTimeout = _Timeout;
						da.Fill(tmpdt);
					}
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
		/// Runs the specified stored procedure and returns the results as a data set
		/// </summary>
		/// <param name="commandText">The command to run.</param>
		/// <param name="commandParameters">An array of SqlParameters objects.</param>
		/// <returns>A DataTable containing the results.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public DataTable RunSPReturnDataTableSNWHB(string commandText)
		{
			DataTable dt = null;
			DataTable tmpdt = null;
			try
			{
				tmpdt = new DataTable();

				using (SqlConnection cn = DBConnect.NewDataConnectionNWB())
				{
					using (SqlDataAdapter da = new SqlDataAdapter(commandText, cn))
					{
						da.SelectCommand.CommandType = CommandType.Text;
						da.SelectCommand.CommandTimeout = _Timeout;
						da.Fill(tmpdt);
					}
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
	/// Runs the specified stored procedure and returns the results as a data set
	/// </summary>
	/// <param name="commandText">The command to run.</param>
	/// <param name="commandParameters">An array of SqlParameters objects.</param>
	/// <returns>A DataTable containing the results.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public DataTable RunSPReturnDataTableSNWHDW(string commandText)
		{
			DataTable dt = null;
			DataTable tmpdt = null;
			try
			{
				tmpdt = new DataTable();

				using (SqlConnection cn = DBConnect.NewDataConnectionNWDW())
				{
					using (SqlDataAdapter da = new SqlDataAdapter(commandText, cn))
					{
						da.SelectCommand.CommandType = CommandType.Text;
						da.SelectCommand.CommandTimeout = _Timeout;
						da.Fill(tmpdt);
					}
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
		/// Runs the specified stored procedure and returns the results as a data set
		/// </summary>
		/// <param name="commandText">The command to run.</param>
		/// <param name="commandParameters">An array of SqlParameters objects.</param>
		/// <returns>A DataTable containing the results.</returns>
		[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Security", "CA2100:Review SQL queries for security vulnerabilities")]
		public DataTable RunSPReturnDataTableSNWHM(string commandText)
		{
			DataTable dt = null;
			DataTable tmpdt = null;
			try
			{
				tmpdt = new DataTable();

				using (SqlConnection cn = DBConnect.NewDataConnectionNWM())
				{
					using (SqlDataAdapter da = new SqlDataAdapter(commandText, cn))
					{
						da.SelectCommand.CommandType = CommandType.Text;
						da.SelectCommand.CommandTimeout = _Timeout;
						da.Fill(tmpdt);
					}
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

	}
}