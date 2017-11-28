using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using DataLayer;

namespace DataMngt.finance
{
	public partial class InvoiceAdj : System.Web.UI.Page
	{
		#region local-variables	
		private CurrentUser _user = null;
		private CurrBrowserNoSess _Browser = null;
		private string _AppVers = string.Empty;
		private string _BuildNbr = "";
		private string _SiteURL = "";
		private string _ErrMsg = string.Empty;
		private int _InvAdjID = 0;
		private int _IsAdmin = 0;
		private string _LocationCode = string.Empty;
		private string _MixCode = string.Empty;
		private int _PageID = 22;
		private int _PgRights = 0;
		private string _RequestTypes = string.Empty;
		private int _UserID = 0;
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

			// establish initial and default values
			//_PgNbr = 0;
			_PgRights = 0;
			string logFilePath = System.Configuration.ConfigurationManager.AppSettings["AppLogFilePath"].ToString();
			_SiteURL = System.Configuration.ConfigurationManager.AppSettings["SitePrefix"];
			_BuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
			_AppVers = System.Configuration.ConfigurationManager.AppSettings["AppVersion"].ToString() + " (" + System.Configuration.ConfigurationManager.AppSettings["AppVersionDate"].ToString() + ")";
			string UserName = Request.ServerVariables["LOGON_USER"];
			_user = new CurrentUser(UserName, logFilePath, ""); // SessionHelper.GetCurrentUser(Request.ServerVariables["LOGON_USER"]);
			if (_user == null || !_user.IsValid)
			{
				Logging.WriteToLog("Login failed for " + UserName + ".");
				HttpContext.Current.Response.Redirect("NoAcc/NoAccess.aspx", true);
			}
			_Browser = new CurrBrowserNoSess(System.Web.HttpContext.Current.Request);

			_UserID = Convert.ToInt32(_user.UserID);
			_LocationCode = _user.LocationCode;
			DateTime today = DateTime.Now;
			if (_user.IsAdmin == true) { _IsAdmin = 1; }

			this.lblBuildNbr.InnerText = _BuildNbr.ToString();
			this.lblVersion.InnerText = System.Configuration.ConfigurationManager.AppSettings["AppVersion"].ToString();
			this.lblVersionDate.InnerText = System.Configuration.ConfigurationManager.AppSettings["AppVersionDate"].ToString();
			this.lblCurrentYearFtr.InnerText = today.Year.ToString();

			// check for specific rights to cat tool
			if (!_user.IsInRole("invmngtappr") && !_user.IsInRole("invmngtadm") && !_user.IsInRole("invmngtedt") && !_user.IsInRole("invmngtvw") && _IsAdmin == 0)
			{
				Session["NoAccessMsg"] = "You do not have access to the Inventory Adjustment portion of this application";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}

			_UserID = Convert.ToInt32(_user.UserID);
			_InvAdjID = 0;
			if (!string.IsNullOrWhiteSpace(Request["i"]))
			{
				_InvAdjID = Convert.ToInt32(Request["i"]);
			}

			if (_user.IsInRole("invmngtadm") || _user.IsAdmin == true)
			{
				this._IsAdmin = 1;
				this._PgRights = 5;
			}
			else
			{
				if (_user.IsInRole("invmngtvw") || _user.IsInRole("datmngtview"))
				{
					_PgRights = 1;
				}
			}
			_RequestTypes = _user.RequestRights;
			
			string jsScript = "";
			jsScript = "<script type=\"text/javascript\">var jigEmpID=" + _user.UserID.ToString() + ";var jsgBrowserType='" + _Browser.BrowserType.ToString() + "';var jsgAr=" + _PgRights.ToString() + ";var jgA=" + _IsAdmin.ToString() + ";var jsgLoc='" + _LocationCode + "';var jigInvAdj=" + _InvAdjID.ToString() + ";var jsgNm='" + _user.FullName + "';var jsgGrps='" + _RequestTypes + "';var jsgAR=" + _user.AccessRights.ToString() + ";var jsgError='" + this._ErrMsg + "';</script>";
			Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "MyTargetVariables", jsScript);
		}
	}
}