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
	public partial class WebCalendar1 : System.Web.UI.Page
	{
		#region Attributes
		CurrentUser _user = null;
		private CurrBrowser _Browser = null;
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
		private int _PgNbr2 = 0;
		private int _PgNbr3 = 0;
		private int _PgNbr4 = 0;
		private int _PgNbr5 = 0;
		private int _PgSize = 20;
		private DateTime _TargetDate = DateTime.Now;
		private int _TargetGrid = 0;
		private int _UserID = 0;
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
			//_PgNbr = 0;
			_PgSize = 20;
			string logFilePath = System.Configuration.ConfigurationManager.AppSettings["AppLogFilePath"].ToString();

			// grab browser data
			if (Session["CurrentUser"] == null)
			{
				string ips = System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
				string CurrSessionID = System.Web.HttpContext.Current.Session.SessionID;
				_Browser = new CurrBrowser(System.Web.HttpContext.Current.Request);
			}
			else
			{
				_Browser = (CurrBrowser)Session["bw"];
			}

			// check for user rights to this page
			if (Session["UserName"] == null)
			{
				usrname = Request.ServerVariables["LOGON_USER"];
				HttpContext.Current.Session["UserName"] = usrname;
			}
			else
			{
				usrname = HttpContext.Current.Session["UserName"].ToString();
			}

			// get user object and put it in the session
			if (_user == null)
			{
				if (HttpContext.Current.Session["CurrentUser"] != null)
				{
					_user = (CurrentUser)HttpContext.Current.Session["CurrentUser"];
				}
				else
				{
					_user = new CurrentUser(usrname, logFilePath, ""); // SessionHelper.GetCurrentUser(Request.ServerVariables["LOGON_USER"]);
					HttpContext.Current.Session["CurrentUser"] = _user;
				}
			}
			// Access rule
			if (_user == null || !_user.IsValid)
			{
				string AppLog = System.Configuration.ConfigurationManager.AppSettings["AppLogFilePath"].ToString();
				Log.WriteLogEntry("User Login failed " + usrname, AppLog);
				Session["NoAccessMsg"] = "You do not have access to forecasting";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}

			// check for specific rights to cat tool
			if (!_user.IsInRole("forecastvw") && !_user.IsInRole("forecastedit") && !_user.IsInRole("forecastAdm") && !_user.IsInRole("datmngtedit") && !_user.IsInRole("datmngtview") && !_user.IsAdmin == true)
			{
				Session["NoAccessMsg"] = "You do not have access to forecasting.";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}
			this._CanEdit = true;
			if (_user.IsInRole("forecastvw") || _user.IsInRole("datmngtview"))
			{
				this._CanEdit = false;
			}
			if (_user.IsInRole("forecastAdm") || _user.IsAdmin == true)
			{
				this._IsAdmin = 1;
			}

			_BuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
			_UserID = Convert.ToInt32(_user.UserID);
			_LocationCode = _user.LocationCode;
			_MixCode = "";

			if (!this.IsPostBack)
			{
				try
				{
					string Loc = _LocationCode;
					_CurrentWeek = 1;
					_ForecastView = 0;
					//System.Globalization.CultureInfo ci =
					//System.Threading.Thread.CurrentThread.CurrentCulture;
					//DayOfWeek fdow = ci.DateTimeFormat.FirstDayOfWeek;
					//DayOfWeek today = DateTime.Now.DayOfWeek;
					//DateTime sow = DateTime.Now.AddDays(-(today - fdow)).Date;
					var _TargetDate = DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek + (int)DayOfWeek.Monday);
					ViewState.Add("TargetDate", _TargetDate.ToString());
					ViewState.Add("LocationCode", _LocationCode);
					// calculate dates for 13 weeks for header
					//var monday1 = DateTime.Now.AddDays(-(int)DateTime.Now.DayOfWeek + 5); //1 8 15 22 29 36 43 50 57 64 71 78 85
				}
				catch (Exception ex)
				{
					this._ErrMsg = "Initial data Load encountered an error: " + ex.Message;
				}

			}
			else
			{
				// postback
				_CurrentWeek = Convert.ToInt32(ViewState["CurrentWeek"]);
				_TargetDate = Convert.ToDateTime(ViewState["TargetDate"]);
				_LocationCode = ViewState["LocationCode"].ToString();
			}

			this.lblBuildNbr.Text = _BuildNbr.ToString();
			this.lblVersion.Text = System.Configuration.ConfigurationManager.AppSettings["AppVersion"].ToString();
			this.lblVersionDate.Text = System.Configuration.ConfigurationManager.AppSettings["AppVersionDate"].ToString();

			string jsScript = "";
			jsScript = "<script type=\"text/javascript\">var jigEmpID=" + _user.UserID.ToString() + ";var jsgBrowserType='" + _Browser.BrowserType.ToString() + "';var jsgAr=" + _user.AccessRights.ToString() + ";var jgA=" + _IsAdmin.ToString() + ";var jsgLoc='" + _LocationCode + "';var jsgError='" + this._ErrMsg + "';</script>";
			Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "MyTargetVariables", jsScript);
		}
	}
}