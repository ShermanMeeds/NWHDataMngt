using Microsoft.CSharp;
using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace DataLayer
{
	public static class MainIntApp
	{
		private static int _AccountID = 1;
		private static string _Administrator = "";
		private static string _AdministratorEmail = "";
		private static string _AppName = "";
		private static string _BaseURL = "";
		private static string _DBConnect = "";
		private static string _Environment = "";
		private static bool _IsLoaded = false;
		private static string _SitePrefix = "";
		private static bool _ValidateTimeOff = false;
		private static string _Version = "";
		private static string _VersionDate = "";
		private static string _DBVersion = "";
		private static string _DBVersionDate = "";
		private static string _WebMaster = "";
		private static string _WebMasterEmail = "";

		public static int AccountID
		{
			get { return _AccountID; }
			set { _AccountID = value; }
		}

		public static string AppName
		{
			get { return _AppName; }
			set { _AppName = value; }
		}

		public static string Administrator
		{
			get { return _Administrator; }
			set { _Administrator = value; }
		}

		public static string AdministratorEmail
		{
			get { return _AdministratorEmail; }
			set { _AdministratorEmail = value; }
		}

		public static string BaseURL
		{
			get { return _BaseURL; }
			set { _BaseURL = value; }
		}

		public static string DBConnect
		{
			get { return _DBConnect; }
			set { _DBConnect = value; }
		}

		public static string DBVersion
		{
			get { return _DBVersion; }
			set { _DBVersion = value; }
		}

		public static string DBVersionDate
		{
			get { return _DBVersionDate; }
			set { _DBVersionDate = value; }
		}

		public static string Environment
		{
			get { return _Environment; }
			set { _Environment = value; }
		}

		public static bool IsLoaded
		{
			get { return _IsLoaded; }
			set { _IsLoaded = value; }
		}

		public static string SitePrefix
		{
			get { return _SitePrefix; }
			set { _SitePrefix = value; }
		}

		public static bool ValidateTimeOff
		{
			get { return _ValidateTimeOff; }
			set { _ValidateTimeOff = value; }
		}

		public static string Version
		{
			get { return _Version; }
			set { _Version = value; }
		}

		public static string VersionDate
		{
			get { return _VersionDate; }
			set { _VersionDate = value; }
		}

		public static string WebMaster
		{
			get { return _WebMaster; }
			set { _WebMaster = value; }
		}

		public static string WebMasterEmail
		{
			get { return _WebMasterEmail; }
			set { _WebMasterEmail = value; }
		}

		public static string GetAppSetting(string SettingKey, string Type)
		{
			DBInterface di = new DBInterface();
			if (String.IsNullOrWhiteSpace(SettingKey))
			{
				return "{EMPTY}";
			}
			else
			{
				SqlParameter p1 = new SqlParameter("@Setting", SettingKey);
				SqlParameter p2 = new SqlParameter("@Type", Type);
				return di.RunSPReturnScalar("web.usp_GetAppSetting", new SqlParameter[] { p1, p2 }).ToString();
			}
		}
	}
}
