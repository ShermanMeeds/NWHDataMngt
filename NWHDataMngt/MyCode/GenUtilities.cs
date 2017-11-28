using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Globalization;
using System.Threading;
using System.Xml;
using System.Xml.Serialization;
using System.Runtime.CompilerServices;
using System.Web.Script.Serialization;
using Microsoft.VisualBasic;
using DataLayer;
using System.Web.UI.WebControls;

namespace DataMngt
{
	public static class GenUtilities
	{

		public static DataTable getStatusDataTable(int StatusID, string msg, int NewID)
		{
			DataTable dt = new DataTable();
			dt.Columns.Add("StatusID", typeof(Int32));
			dt.Columns.Add("StatusMsg", typeof(String));
			dt.Columns.Add("NewID", typeof(String));
			dt.Rows.Add(StatusID, msg, NewID.ToString());
			return dt;
		}

		public static String JSON(DataTable dt)
		{
			// initialize javascript serializer
			System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
			// turn table into dictionary list
			List<Dictionary<string, object>> MyRows = new List<Dictionary<string, object>>();
			Dictionary<string, object> MyRow = null;
			foreach (DataRow dr in dt.Rows)
			{
				MyRow = new Dictionary<string, object>();
				foreach (DataColumn col in dt.Columns)
				{
					MyRow.Add(col.ColumnName.Trim(), dr[col]);
				}
				MyRows.Add(MyRow);
			}

			return js.Serialize(MyRows);
		}

		public static void LoadUserSessionData(CurrentUser usr, string UserLogin)
		{
			System.Web.HttpContext.Current.Session["UserLogin"] = UserLogin;
			System.Web.HttpContext.Current.Session["MTEmailAddress"] = usr.EmailAddress;
			System.Web.HttpContext.Current.Session["MTUserID"] = usr.UserID;
			System.Web.HttpContext.Current.Session["MTEmpName"] = usr.FullName;
			System.Web.HttpContext.Current.Session["MTIsAdmin"] = usr.IsAdmin;
			System.Web.HttpContext.Current.Session["MTIsViewOnly"] = usr.IsViewOnly;
			System.Web.HttpContext.Current.Session["MTIsContractor"] = usr.IsContractor;
			System.Web.HttpContext.Current.Session["MTStartDate"] = usr.StartDate;
		}

    public static string base64Decode(string data)
    {
      byte[] toDecodeByte = Convert.FromBase64String(data);

      System.Text.UTF8Encoding encoder = new System.Text.UTF8Encoding();
      System.Text.Decoder utf8Decode = encoder.GetDecoder();

      int charCount = utf8Decode.GetCharCount(toDecodeByte, 0, toDecodeByte.Length);

      char[] decodedChar = new char[charCount];
      utf8Decode.GetChars(toDecodeByte, 0, toDecodeByte.Length, decodedChar, 0);
      string result = new String(decodedChar);
      return result;
    }

    public static byte[] GetBytes(string str)
    {
      byte[] bytes = new byte[str.Length * sizeof(char)];
      System.Buffer.BlockCopy(str.ToCharArray(), 0, bytes, 0, bytes.Length);
      return bytes;
    }

    public static string GetString(byte[] bytes)
    {
      char[] chars = new char[bytes.Length / sizeof(char)];
      System.Buffer.BlockCopy(bytes, 0, chars, 0, bytes.Length);
      return new string(chars);
    }

		public static string FormatToMoney(double fig)
		{
			return fig.ToString("C", new CultureInfo("en-us"));
		}

		public static bool ValidateStringData(string s, int Depth)
		{
			bool Okay = true;
			if (s != "")
			{
				if (s.IndexOf("\\") > -1) { Okay = false; }
				if (s.IndexOf("'") > -1) { Okay = false; }
				if (s.IndexOf("^") > -1) { Okay = false; }
				if (Depth > 0)
				{
					if (s.IndexOf("&") > -1) { Okay = false; }
					if (s.IndexOf("=") > -1) { Okay = false; }
					if (s.IndexOf(".") > -1) { Okay = false; }
					if (s.IndexOf("/") > -1) { Okay = false; }
				}
				if (Depth > 1)
				{
					if (s.IndexOf("%") > -1) { Okay = false; }
					if (s.IndexOf("!") > -1) { Okay = false; }
					if (s.IndexOf("#") > -1) { Okay = false; }
					if (s.IndexOf("$") > -1) { Okay = false; }
				}
				if (Depth > 2)
				{
					if (s.IndexOf("\"") > -1) { Okay = false; }
					if (s.IndexOf("@") > -1) { Okay = false; }
				}
			}
			return Okay;
		}

		public static string FormatDateTimeStringGU(DateTime dte, string fmt)
		{
			// fmt: yyyy-4digityear, yy-2digityear, M-1/2digitmonth, MM-2digitmonth, MMM-MonthAbrev, MMMM-MonthFullName, d-1/2digitday, dd-2digitday, ddd-weekdaynameabbr, dddd-weekdayname
			//      h-1/2digithr, hh-2digithr, H-1/2digithr24hr, HH-2digithr24hr, m-1/2digitminute, mm-2digitminute, s-1/2digitsecond, ss-2digitsecond, tt-AMPM
			//      /-date separator, :-time separator 
			string newdate = string.Empty;
			newdate = dte.ToString(fmt);
			return newdate;
		}

		public static string SanatizeStringData(string s)
		{
			string s2 = string.Empty;
			s2 = s.Replace("/", "~0");
			s2 = s2.Replace("\\", "~1");
			s2 = s2.Replace("\"", "~Q");
			s2 = s2.Replace(".", "~3");
			s2 = s2.Replace("&", "~4");
			s2 = s2.Replace("'", "`");
			s2 = s2.Replace("^", "~5");
			s2 = s2.Replace("%", "~6");
			s2 = s2.Replace("$", "~7");
			s2 = s2.Replace("#", "~8");
			s2 = s2.Replace("@", "~9");
			s2 = s2.Replace("!", "~2");
			s2 = s2.Replace("=", "~A");
			return s2;
		}

		public static string SanatizeStringDataMin(string s)
		{
			string s2 = string.Empty;
			s2 = s2.Replace("'", "`");
			s2 = s.Replace("/", "~0");
			s2 = s2.Replace("\\", "~1");
			s2 = s2.Replace("\"", "~Q");
			s2 = s2.Replace("^", "~5");
			return s2;
		}

		public static string TranslateSanatizedData(string s)
		{
			string s2 = s.Replace("~0", "/");
			s2 = s2.Replace("~1", "\\");
			s2 = s2.Replace("~Q", "\"");
			s2 = s2.Replace("~3", ".");
			s2 = s2.Replace("~4", "&");
			s2 = s2.Replace("`", "'");
			s2 = s2.Replace("~5", "^");
			s2 = s2.Replace("~6", "%");
			s2 = s2.Replace("~7", "$");
			s2 = s2.Replace("~8", "#");
			s2 = s2.Replace("~9", "@");
			s2 = s2.Replace("~2", "!");
			s2 = s2.Replace("~A", "=");
			return s2;
		}

		public static string FormatNbrSpecial(double nbr, string prefix, int UseComma, string CComma, string CPrd, int Prec)
		{
			try
			{
				string snbr = string.Empty;
				if (Prec <= 0)
				{
					snbr = string.Format("{0:n0}", nbr);
				}
				else
				{
					double nbr2 = Math.Round(nbr, Prec);
					snbr = string.Format("{0:n" + Prec.ToString() + "}", nbr2);
				}
				if (UseComma != 1)
				{
					snbr = snbr.Replace(",", "");
				}
				else
				{
					if (CComma != ",") { snbr = snbr.Replace(",", CComma); }
				}
				if (CPrd != ".") { snbr = snbr.Replace(".", CPrd); }
				return prefix + snbr;
			}
			catch (Exception ex)
			{
				return nbr.ToString();
			}
		}

		public static bool IsNumeric(string s)
		{
			if (Information.IsNumeric(s.Trim()))
			{
				return true;
			}
			else
			{
				return false;
			}
		}

		public static bool IsInteger32(string snbr)
		{
			if (Int32.Parse(snbr.Trim()) > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

		public static void ClearDDLValues(DropDownList ddl, int KeepFirst)
		{
			ListItem firstItem = ddl.Items[0];
			ddl.AppendDataBoundItems = false;
			ddl.Items.Clear();
			if (KeepFirst == 1) { ddl.Items.Add(firstItem); }
			ddl.AppendDataBoundItems = true;
		}

		//// str - the source string
		//// index- the start location to replace at (0-based)
		//// length - the number of characters to be removed before inserting
		//// replace - the string that is replacing characters
		public static string ReplaceAt (this string str, int index, int length, string replace)
		{
			return str.Remove(index, Math.Min(length, str.Length - index))
							.Insert(index, replace);
		}

		//public static System.Boolean IsNumeric(System.Object Expression)
		//{
		//	if (Expression == null || Expression is DateTime)
		//		return false;

		//	if (Expression is Int16 || Expression is Int32 || Expression is Int64 || Expression is Decimal || Expression is Single || Expression is Double || Expression is Boolean)
		//		return true;

		//	try
		//	{
		//		if (Expression is string)
		//			Double.Parse(Expression as string);
		//		else
		//			Double.Parse(Expression.ToString());
		//		return true;
		//	}
		//	catch { } // just dismiss errors but return false
		//	return false;
		//}

	}
}
