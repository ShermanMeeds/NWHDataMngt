using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace DataLayer
{
	public static class DBConnect
	{
		private static string _dbConnect = "";
		private static string _dbConnectOL = "";
		private static string _dbConnectDW = "";
		private static string _dbConnectAR = "";
		private static string _dbConnectAD = "";
		private static string _dbConnectHC = "";
		private static string _dbConnectHD = "";
		private static string _dbConnectNWB = "";
		private static string _dbConnectNWDW = "";
		private static string _dbConnectNWM = "";
		private static string _Environment = "";
		private static string _dbConnectDefault = "";

		public static string DbConnect
		{
			get { return _dbConnect; }
			set { _dbConnect = value; }
		}

		public static string DbConnectOL
		{
			get { return _dbConnectOL; }
			set { _dbConnectOL = value; }
		}

		public static string DbConnectDW
		{
			get { return _dbConnectDW; }
			set { _dbConnectDW = value; }
		}

		public static string DbConnectAR
		{
			get { return _dbConnectAR; }
			set { _dbConnectAR = value; }
		}

		public static string DbConnectAD
		{
			get { return _dbConnectAD; }
			set { _dbConnectAD = value; }
		}

		public static string DbConnectHC
		{
			get { return _dbConnectHC; }
			set { _dbConnectAD = value; }
		}

		public static string DbConnectHD
		{
			get { return _dbConnectHD; }
			set { _dbConnectAD = value; }
		}

		public static string DbConnectNWB
		{
			get { return _dbConnectNWB; }
			set { _dbConnectNWB = value; }
		}

		public static string DbConnectNWDW
		{
			get { return _dbConnectNWDW; }
			set { _dbConnectNWDW = value; }
		}

		public static string DbConnectNWM
		{
			get { return _dbConnectNWM; }
			set { _dbConnectNWM = value; }
		}

		public static string Environment
		{
			get { return _Environment; }
			set { _Environment = value; }
		}

		public static void SetDataConnectString(string connectionstring) { _dbConnect = connectionstring; }
		public static void SetDataConnectStringOL(string connectionstring) { _dbConnectOL = connectionstring; }
		public static void SetDataConnectStringDW(string connectionstring) { _dbConnectDW = connectionstring; }
		public static void SetDataConnectStringAR(string connectionstring) { _dbConnectAR = connectionstring; }
		public static void SetDataConnectStringAD(string connectionstring) { _dbConnectAD = connectionstring; }
		public static void SetDataConnectStringHC(string connectionstring) { _dbConnectHC = connectionstring; }
		public static void SetDataConnectStringHD(string connectionstring) { _dbConnectHD = connectionstring; }
		public static void SetDataConnectStringNWB(string connectionstring) { _dbConnectNWB = connectionstring; }
		public static void SetDataConnectStringNWDW(string connectionstring) { _dbConnectNWDW = connectionstring; }
		public static void SetDataConnectStringNWM(string connectionstring) { _dbConnectNWM = connectionstring; }

		public static SqlConnection NewDataConnection()
		{
			SqlConnection cn = new SqlConnection(_dbConnect);
			cn.Open();
			return cn;
		}

		public static SqlConnection NewDataConnectionOL()
		{
			SqlConnection cn = new SqlConnection(_dbConnectOL);
			cn.Open();
			return cn;
		}

		public static SqlConnection NewDataConnectionDW()
		{
			SqlConnection cn = new SqlConnection(_dbConnectDW);
			cn.Open();
			return cn;
		}

		public static SqlConnection NewDataConnectionAR()
		{
			SqlConnection cn = new SqlConnection(_dbConnectAR);
			cn.Open();
			return cn;
		}

		public static SqlConnection NewDataConnectionAD()
		{
			SqlConnection cn = new SqlConnection(_dbConnectAD);
			cn.Open();
			return cn;
		}

		public static SqlConnection NewDataConnectionHC()
		{
			SqlConnection cn = new SqlConnection(_dbConnectHC);
			cn.Open();
			return cn;
		}

		public static SqlConnection NewDataConnectionHD()
		{
			SqlConnection cn = new SqlConnection(_dbConnectHD);
			cn.Open();
			return cn;
		}

		public static SqlConnection NewDataConnectionNWB()
		{
			SqlConnection cn = new SqlConnection(_dbConnectNWB);
			cn.Open();
			return cn;
		}

		public static SqlConnection NewDataConnectionNWDW()
		{
			SqlConnection cn = new SqlConnection(_dbConnectNWDW);
			cn.Open();
			return cn;
		}

		public static SqlConnection NewDataConnectionNWM()
		{
			SqlConnection cn = new SqlConnection(_dbConnectNWM);
			cn.Open();
			return cn;
		}

		public static SqlConnection NewSpecDataConnection(string dConnect)
		{
			if (string.IsNullOrEmpty(dConnect))
			{
				_dbConnect = _dbConnectDefault;
			}
			SqlConnection cn = new SqlConnection(dConnect);
			cn.Open();
			return cn;
		}

	}
}
