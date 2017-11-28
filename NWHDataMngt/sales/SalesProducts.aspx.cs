using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using DataLayer;

namespace DataMngt.sales
{
	public partial class SalesProducts : System.Web.UI.Page
	{
		#region Attributes
		CurrentUser _user = null;
		private CurrBrowser _Browser = null;
		private string _BuildNbr = "";
		private bool _CanEdit = false;
		private bool _IsAdmin = false;
		private string _LocationCode = string.Empty;
		private int _SortDir = 0;
		private int _PgNbr = 0;
		private int _PgSize = 20;
		private int _UserID = 0;
		private string _ErrMsg = string.Empty;
		#endregion Attributes

		// ********************************************************************************
		#region Properties
		public string BuildNbr
		{
			get { return _BuildNbr; }
		}

		public string ErrorMsg
		{
			get { return _ErrMsg; }
		}
		#endregion Properties

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
			string usrname = "";
			_PgNbr = 0;
			_PgSize = 20;
			string logFilePath = System.Configuration.ConfigurationManager.AppSettings["AppLogFilePath"].ToString();
			string ips = System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
			string CurrSessionID = System.Web.HttpContext.Current.Session.SessionID;
			_Browser = new CurrBrowser(System.Web.HttpContext.Current.Request);
			usrname = Request.ServerVariables["LOGON_USER"];
			_user = new CurrentUser(usrname, logFilePath, ""); // SessionHelper.GetCurrentUser(Request.ServerVariables["LOGON_USER"]);

			// Access rule
			if (_user == null || !_user.IsValid)
			{
				string AppLog = System.Configuration.ConfigurationManager.AppSettings["AppLogFilePath"].ToString();
				Log.WriteLogEntry("User Login failed " + usrname, AppLog);
				Session["NoAccessMsg"] = "You do not have access to CAT product pricing";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}

			// check for specific rights to cat tool
			if (!_user.IsInRole("catAdmin") && !_user.IsInRole("catprcedit") && !_user.IsInRole("catAdmin") && !_user.IsInRole("datamngtcat") && _user.IsAdmin == false)
			{
				Session["NoAccessMsg"] = "You do not have access to the Cat item pricing.";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}
			if (_user.ProdAvailRights > 1)
			{
				this._CanEdit = true;
			}
			if (_user.ProdAvailRights > 3)
			{
				this._IsAdmin = true;
			}

			_BuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
			_UserID = Convert.ToInt32(_user.UserID);
			_LocationCode = _user.LocationCode;
			this.lblBuildNbr.Text = _BuildNbr.ToString();
			this.lblVersion.Text = System.Configuration.ConfigurationManager.AppSettings["AppVersion"].ToString();
			this.lblVersionDate.Text = System.Configuration.ConfigurationManager.AppSettings["AppVersionDate"].ToString();
			//if (!this.IsPostBack)
			//{
			//	try
			//	{
			//		LoadSpeciesListE();
			//		LoadGradeListE();
			//		LoadThicknessListE();
			//		LoadColorListE();
			//		LoadLengthListE();
			//		LoadMillingListE();
			//		LoadNoPrintListE();
			//		LoadSortListE();
			//		gvRegionPriceTrackLoad();

			//		this.imgSortDir.ImageUrl = "~/Images/arrow2_n.gif";
			//		_SortDir = 0;
			//		ViewState.Add("SortDir", "0");
			//	}
			//	catch (Exception ex)
			//	{
			//		this._ErrMsg = "Initial data Load encountered an error: " + ex.Message;
			//		this.lblErrorMsg.Text = this._ErrMsg;
			//	}

			//	//string jsScript = "";
			//	//jsScript = "<script type=\"text/javascript\">var jigEmpID=" + _user.EmpID.ToString() + ";var jsgBrowserType='" + _Browser.BrowserType.ToString() + "';var jsgAr=" + _user.AccessRights.ToString() + ";</script>";
			//	//Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "MyTargetVariables", jsScript);
			//}
			//else
			//{
			//	// postback
			//	_SortDir = Convert.ToInt32(ViewState["SortDir"]);
			//}
			string jsScript = "";
			jsScript = "<script type=\"text/javascript\">var jigEmpID=" + _user.UserID.ToString() + ";var jsgBrowserType='" + _Browser.BrowserType.ToString() + "';var jsgAr=" + _user.AccessRights.ToString() + ";var jgA=" + _IsAdmin.ToString().ToLower() + ";var jsgError ='" + this._ErrMsg + "';var jsgLoc='" + _LocationCode + "';</script>";
			Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "MyTargetVariables", jsScript);
		}
	}
}