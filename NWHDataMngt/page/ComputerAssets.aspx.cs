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
	public partial class ComputerAssets : System.Web.UI.Page
	{
		#region Attributes
		CurrentUser _user = null;
		private CurrBrowser _Browser = null;
		private string _CBuildNbr = "";
		private bool _CanEdit = false;
		private bool _IsAdmin = false;
		private int _PgNbr = 0;
		private int _PgSize = 20;
		private int _UserID = 0;
		private string _ErrMsg = string.Empty;
		#endregion Attributes

		// ********************************************************************************
		#region Properties
		public string CBuildNbr
		{
			get { return _CBuildNbr; }
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
				Session["NoAccessMsg"] = "You do not have access to the computer list page";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}
			
			// check for specific rights to HITS list
			if (!_user.IsInRole("hitscompvw") && _user.IsAdmin == false)
			{
				Session["NoAccessMsg"] = "You do not have access to the computer list page.";
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

			_CBuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
			_UserID = Convert.ToInt32(_user.UserID);

			if (!this.IsPostBack)
			{
				try
				{
					LoadAssetGrid();
					ShowHitsVersionHistory();
				}
				catch (Exception ex)
				{
					this._ErrMsg = "Initial data Load encountered an error: " + ex.Message;
					this.lblStatusMsg.Text = this._ErrMsg;
				}

				//string jsScript = "";
				//jsScript = "<script type=\"text/javascript\">var jigEmpID=" + _user.EmpID.ToString() + ";var jsgBrowserType='" + _Browser.BrowserType.ToString() + "';var jsgAr=" + _user.AccessRights.ToString() + ";</script>";
				//Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "MyTargetVariables", jsScript);
			}

		}

		protected void LoadAssetGrid()
		{
			 try
			{
				string Loc = "";
				string Status = "";
				int Active = 2;

				Commands cmd = new Commands();
				DataTable dt = cmd.GetComputerList(Loc, Status, Active, _UserID);
				this.gvAssetList.DataSource = dt;
				this.gvAssetList.DataBind();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Loading data error: " + ex.Message;
				this.lblStatusMsg.Text = this._ErrMsg;
			}
		}

		protected void ShowHitsVersionHistory()
		{
			try
			{
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectAppVersionHistory(1, 0, 0);
				this.gvAppVersHistory.DataSource = dt;
				this.gvAppVersHistory.DataBind();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Loading app history error: " + ex.Message;
				this.lblStatusMsg.Text = this._ErrMsg;
			}
		}

	}
}