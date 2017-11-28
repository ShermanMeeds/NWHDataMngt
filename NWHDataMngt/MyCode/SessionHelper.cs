using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.SessionState;
using System.Web.Configuration;
using DataLayer;

namespace DataMngt
{
	public class SessionHelper
	{
		public static CurrentUser GetCurrentUser(string logonName)
		{
			// if _userProps is null or logon does not match then get new identity props from the DB
     	System.Web.SessionState.HttpSessionState session = HttpContext.Current.Session;
			CurrentUser user = session["CurrentUser"] as CurrentUser;
			string logFilePath = System.Configuration.ConfigurationManager.AppSettings["AppLogFilePath"].ToString();

			if (user == null || !string.Equals(user.LoginName, logonName, StringComparison.OrdinalIgnoreCase))
			{
				user = new CurrentUser(logonName, logFilePath, "");
				session["CurrentUser"] = user;
			}
			return user;
		}
	}
}