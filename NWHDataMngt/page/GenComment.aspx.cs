using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using DataLayer;

namespace DataMngt.page
{
	public partial class GenComment : System.Web.UI.Page
	{
		#region local-variables	
		private string _GrpAccess = string.Empty;
		private string _AppVers = string.Empty;
		private string _BuildNbr = "";
		private string _SiteURL = "";
		private CurrentUser _user = null;
		private CurrBrowserNoSess _Browser = null;
		private string _CBuildNbr = "";
		private bool _CanEdit = false;
		private int _CurrentWeek = 0;
		private int _CW = 0;
		private string _ErrMsg = string.Empty;
		private int _ForecastView = 0;
		private int _IsAdmin = 0;
		private string _LocationCode = String.Empty;
		private int _MatrixView = 0;
		private string _MixCode = string.Empty;
		private int _PgNbr1 = 0;
		private int _PgNbr2 = 0;
		private int _PgNbr3 = 0;
		private int _PgNbr4 = 0;
		private int _PgNbr5 = 0;
		private int _PgRights = 0;
		private int _PgSize = 20;
		private DateTime _TargetDate = DateTime.Now;
		private int _TargetGrid = 0;
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
			_PgSize = 20;
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

			this.lblBuildNbr.Text = _BuildNbr.ToString();
			this.lblVersion.Text = System.Configuration.ConfigurationManager.AppSettings["AppVersion"].ToString();
			this.lblVersionDate.Text = System.Configuration.ConfigurationManager.AppSettings["AppVersionDate"].ToString();

			// check for specific rights to forecast consolidation tool
			if (!_user.IsInRole("cmtmngtvw") && !_user.IsInRole("cmtmngtcw") && !_user.IsInRole("datmngtview") && !_user.IsInRole("cmtmngtedt") && !_user.IsInRole("cmtmngtadm") && !_user.IsAdmin == true)
			{
				//Session["NoAccessMsg"] = "You do not have access to forecasting.";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}
			this._CanEdit = true;
			_UserID = Convert.ToInt32(_user.UserID);
			_LocationCode = _user.LocationCode;
			_MixCode = "";
			if (_user.IsInRole("cmtmngtAdm") || _user.IsAdmin == true)
			{
				this._IsAdmin = 1;
				this._PgRights = 5;
			}
			else
			{
				if (_user.IsInRole("cmtmngtvw") || _user.IsInRole("datmngtview") || _user.IsInRole("cmtmngtcw"))
				{
					this._CanEdit = false;
					_PgRights = 1;
				}
			}

			_CW = 0;
			if (_user.IsInRole("cmtmngtcw") || _user.IsInRole("cmtmngtAdm") || _user.IsAdmin == true)
			{
				_CW = 1;
			}
			if (_user.IsInRole("cmtmngtvw")) { _GrpAccess = "cmtmngtvw"; }
			if (_user.IsInRole("cmtmngtedt")) { _GrpAccess = "cmtmngtedt"; }
			if (this._IsAdmin == 1) { _GrpAccess = "cmtmngtAdm"; }

			if (!this.IsPostBack)
			{
				try
				{
					var _TargetDate = DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek + (int)DayOfWeek.Monday);
					ViewState.Add("TargetDate", _TargetDate.ToString());
					ViewState.Add("LocationCode", _LocationCode);
					ViewState.Add("PgRights", _PgRights.ToString());
				}
				catch (Exception ex)
				{
					this._ErrMsg = "Initial data Load encountered an error: " + ex.Message;
				}

			}
			else
			{
				// postback
				_TargetDate = Convert.ToDateTime(ViewState["TargetDate"]);
				_LocationCode = ViewState["LocationCode"].ToString();
				_PgRights = Convert.ToInt32(ViewState["PgRights"]);
			}

			string jsScript = "";
			jsScript = "<script type=\"text/javascript\">var jigEmpID=" + _user.UserID.ToString() + ";var jsgBrowserType='" + _Browser.BrowserType.ToString() + "';var jsgAr=" + _PgRights.ToString() + ";var jgA=" + _IsAdmin.ToString() + ";var jsgLoc='" + _LocationCode + "';var jsgError ='" + this._ErrMsg + "';var jigCW=' + _CW.toString() + ';var jsgGrp='" + _GrpAccess + "';</script>";
			Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "MyTargetVariables", jsScript);
		}
	}
}