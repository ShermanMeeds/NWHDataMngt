using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Text;
using DataLayer;

/// <summary>
/// Summary description for Logging
/// </summary>
public static class Logging
{
	public static bool WriteExceptionToLog(string Msg, Exception ex)
	{
		bool Okay = false;
		string logFile = string.Empty;
		string sResult = "";
		DateTime dt = DateTime.Now;
		string sDate = dt.ToString("MM/dd/yyyyH:mm:ss");
		try
		{
			string LogFile = System.Configuration.ConfigurationManager.AppSettings["AppLogFilePath"].ToString();
			sResult = AppendStringToLog(logFile, sDate + " " + Msg + "/" + ex.Message);
			if (sResult == "") { Okay = true; }
		}
		catch (Exception ex2)
		{
			Commands cmd = new Commands();

			Okay = false;
		}
		return Okay;
	}

	//public static void WriteExceptionNoRaiseToLog(string Msg, Exception ex)
	//{
	//	bool Okay = false;
	//	string logFile = string.Empty;
	//	int iResult = 0;
	//	DateTime dt = DateTime.Now;
	//	string sDate = dt.ToString("MM/dd/yyyyH:mm:ss");
	//	Commands cmd = new Commands();

	//}

	public static void WriteToLog(string Msg)
	{
		string logFile = string.Empty;
		int iResult = 0;
		DateTime dt = DateTime.Now;
		string sDate = dt.ToString("MM/dd/yyyyH:mm:ss");
		Commands cmd = new Commands();
		try
		{
			string LogFile = System.Configuration.ConfigurationManager.AppSettings["AppLogFilePath"].ToString();
			string rtn = AppendStringToLog(LogFile, Msg);
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("SageApproval", 0, 0, ex.Message, 0, "WriteToEventLog error", 0);
		}
	}

	public static void WriteToEventLog(string Msg)
	{
		string logFile = string.Empty;
		int iResult = 0;
		DateTime dt = DateTime.Now;
		string sDate = dt.ToString("MM/dd/yyyyH:mm:ss");
		Msg = sDate + " " + Msg;
		try
		{
			string EventLog = System.Configuration.ConfigurationManager.AppSettings["EventLogFilePath"].ToString();
			string rtn = AppendStringToLog(EventLog, Msg);
		}
		catch (Exception ex)
		{
			Commands cmd = new Commands();
			iResult = cmd.LogApplicationError("SageApproval", 0, 0, ex.Message, 0, "WriteToEventLog error", 0);
		}
	}

	public static string AppendStringToLog(string FileName, string Msg)
	{
		string logFile = string.Empty;
		DateTime dt = DateTime.Now;
		string sDate = dt.ToString("MM/dd/yyyy H:mm:ss");
		Msg = sDate + " " + Msg;
		Commands cmd = new Commands();
		try
		{
			StreamWriter objWriter = new StreamWriter(FileName, true);
			objWriter.WriteLine(Msg);
			objWriter.Close();
			return "";
		}
		catch (Exception ex)
		{
			return ex.Message;
		}
	}

	public static string ClearThatLog(string LogName, string sPath, string sName)
	{
		try
		{
			if (!String.IsNullOrWhiteSpace(sPath) && !String.IsNullOrWhiteSpace(sName))
			{
				System.IO.File.Copy(LogName, sPath + sName);
			}
			System.IO.File.WriteAllText(LogName, "");
			return "";
		}
		catch (Exception ex)
		{
			return ex.Message;
		}
	}
}