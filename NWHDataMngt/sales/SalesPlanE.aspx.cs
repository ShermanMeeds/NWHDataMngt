using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;

namespace DataMngt.sales
{
	public partial class SalesPlanE : System.Web.UI.Page
	{
		#region local-variables	
		private string _AppVers = string.Empty;
		private string _BuildNbr = "";
		private bool _CanEdit = false;
		private int _CurrentWeek = 0;
		private string _ErrMsg = string.Empty;
		private int _ForecastView = 0;
		private int _IsAdmin = 0;
		private string _LocationCode = String.Empty;
		private int _MatrixView = 0;
		private string _MixCode = string.Empty;
		private int _PgNbr1 = 0;
		private int _PgSize = 20;
		private string _SiteURL = "";
		private DateTime _TargetDate = DateTime.Now;
		private int _TargetGrid = 0;
		private int _UserID = 0;

		private CurrBrowserNoSess _Browser = null;
		private CurrentUser _user = null;
		#endregion local-variables

		#region public-variables
		public string BuildNbr
		{
			get { return _BuildNbr; }
		}

		public string AppVersion
		{
			get { return _AppVers; }
		}

		public string SiteURL
		{
			get { return _SiteURL; }
		}

		public string UserName
		{
			get { return _user.FullName; }
		}
		#endregion public-variables

		protected void Page_Load(object sender, EventArgs e)
		{
			Response.Cache.SetCacheability(HttpCacheability.NoCache);
			Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
			Response.Cache.SetNoStore();
			Response.ExpiresAbsolute = DateTime.Now;
			Page.Response.Cache.SetCacheability(HttpCacheability.NoCache);
			Response.Cache.SetNoServerCaching();
			Response.Cache.SetValidUntilExpires(true);
			Response.Cache.SetNoStore();
			Response.Cache.SetExpires(DateTime.Parse(DateTime.Now.ToString()));
			Response.Expires = -1441;
			Response.CacheControl = "no-cache";
			Response.DisableKernelCache();

			_BuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
			_ErrMsg = string.Empty;

			string usrname = string.Empty;
			string logFilePath = System.Configuration.ConfigurationManager.AppSettings["AppLogFilePath"].ToString();

			// grab browser data
			string ips = System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
			_Browser = new CurrBrowserNoSess(System.Web.HttpContext.Current.Request);
			usrname = Request.ServerVariables["LOGON_USER"];
			_user = new CurrentUser(usrname, logFilePath, ""); // SessionHelper.GetCurrentUser(Request.ServerVariables["LOGON_USER"]);

			// Access rule
			if (_user == null || !_user.IsValid)
			{
				string AppLog = System.Configuration.ConfigurationManager.AppSettings["AppLogFilePath"].ToString();
				Log.WriteLogEntry("User Login failed " + usrname, AppLog);
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}

			// check for specific rights to sales plan tool
			if (!_user.IsInRole("salesplnvw") && !_user.IsAdmin == true)
			{
				Session["NoAccessMsg"] = "You do not have access to the Sales Plan Management Tool.";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}

			_UserID = Convert.ToInt32(_user.UserID);
			_IsAdmin = 0;
			if (_user.IsAdmin == true) { _IsAdmin = 1; }

			string jsScript = "";
			jsScript = "<script type=\"text/javascript\">var jigEmpID=" + _user.UserID.ToString() + ";var jsgBrowserType='" + _Browser.BrowserType.ToString() + "';var jsgAr=1;var jgA=" + _IsAdmin.ToString() + ";var jsgLoc='" + _LocationCode + "';var jsgError='" + this._ErrMsg + "';</script>";
			Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "MyTargetVariables", jsScript);
		}
	}
}