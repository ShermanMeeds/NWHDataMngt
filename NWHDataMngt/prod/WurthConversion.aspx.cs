using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using DataLayer;

namespace DataMngt.prod
{
	public partial class WurthConversion : System.Web.UI.Page
	{
		#region local-variables	
		private string _AppVers = string.Empty;
		private string _BuildNbr = "";
		private string _SiteURL = "";
		private CurrentUser _user = null;
		private CurrBrowserNoSess _Browser = null;
		private string _CBuildNbr = "";
		private bool _CanEdit = false;
		private int _CurrentWeek = 0;
		private string _ErrMsg = string.Empty;
		private int _ForecastView = 0;
		private int _IsAdmin = 0;
		private string _LocationCode = String.Empty;
		private int _MatrixView = 0;
		private string _MixCode = string.Empty;
		private int _PageID = 26;
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

			_UserID = Convert.ToInt32(_user.UserID);
			_LocationCode = _user.LocationCode;
			_MixCode = "";
			int CanForecast = 0;

			this.lblBuildNbr.Text = _BuildNbr.ToString();
			this.lblVersion.Text = System.Configuration.ConfigurationManager.AppSettings["AppVersion"].ToString();
			this.lblVersionDate.Text = System.Configuration.ConfigurationManager.AppSettings["AppVersionDate"].ToString();

			// check for specific rights to forecast consolidation tool
			if (!_user.IsInRole("wurthcdvw") && !_user.IsInRole("datmngtview") && !_user.IsInRole("wurthcdedt") && !_user.IsInRole("wurthcdadm") && !_user.IsAdmin == true)
			{
				//Session["NoAccessMsg"] = "You do not have access to forecasting.";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}
			this._CanEdit = true;
			if (_user.IsInRole("wurthcdadm") || _user.IsAdmin == true)
			{
				this._IsAdmin = 1;
				this._PgRights = 5;
			}
			else
			{
				if (_user.IsInRole("wurthcdvw") || _user.IsInRole("datmngtview"))
				{
					this._CanEdit = false;
					_PgRights = 1;
				}
			}

			if (!this.IsPostBack)
			{
				try
				{
					string Loc = _LocationCode;
					//System.Globalization.CultureInfo ci =
					//System.Threading.Thread.CurrentThread.CurrentCulture;
					//DayOfWeek fdow = ci.DateTimeFormat.FirstDayOfWeek;
					//DayOfWeek today = DateTime.Now.DayOfWeek;
					//DateTime sow = DateTime.Now.AddDays(-(today - fdow)).Date;
					ViewState.Add("LocationCode", _LocationCode);
					ViewState.Add("PgRights", _PgRights.ToString());
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
				_LocationCode = ViewState["LocationCode"].ToString();
				_PgRights = Convert.ToInt32(ViewState["PgRights"]);
			}

			string jsScript = "";
			jsScript = "<script type=\"text/javascript\">var jigEmpID=" + _user.UserID.ToString() + ";var jsgBrowserType='" + _Browser.BrowserType.ToString() + "';var jsgAr=" + _PgRights.ToString() + ";var jgA=" + _IsAdmin.ToString() + ";var jsgLoc='" + _LocationCode + "';var jigFV=" + CanForecast.ToString() + ";var jsgError ='" + this._ErrMsg + "';</script>";
			Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "MyTargetVariables", jsScript);
		}
	}
}