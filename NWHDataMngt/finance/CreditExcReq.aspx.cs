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
	public partial class CreditExcReq : System.Web.UI.Page
	{
		#region Variables
		private string _BuildNbr = string.Empty;
		private bool _IsAdmin = false;
		private string _BrowserType = string.Empty;
		private int _EmpID = 0;
		private int _NbrLines = 0;
		private int _NbrTickets = 0;
		private int _PageID = 23;
		private string _SitePrefix = string.Empty;
		private DateTime _Today = DateTime.Now;
		private int _UserID = 0;
		CurrentUser _user;
		private CurrBrowser _Browser = null;
		#endregion Variables

		#region Properties
		public string BrowserType { get { return _BrowserType; } }
		public string BuildNbr { get { return _BuildNbr; } }
		public int EmpID { get { return _EmpID; } }
		#endregion Properties

		protected void Page_Load(object sender, EventArgs e)
		{
			// Don't let the page be cached
			Response.Cache.SetCacheability(HttpCacheability.NoCache);
			Response.Cache.SetValidUntilExpires(true);
			Response.Expires = -1441;
			Response.ExpiresAbsolute = DateTime.Now;
			Response.CacheControl = "no-cache";
			Response.AddHeader("Pragma", "no-cache");
			Response.AddHeader("Pragma", "no-store");
			Response.AddHeader("cache-control", "no-cache");
			Response.Cache.SetNoServerCaching();
			Response.DisableKernelCache();

			string jsScript = string.Empty;

			this.lblStatusMsg.Text = "";
			string usrname = "";
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
				_user = (CurrentUser)HttpContext.Current.Session["CurrentUser"];
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
				Session["NoAccessMsg"] = "You do not have access to the Inventory Adjustment portion of this application";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}

			if (_user.IsAdmin)
			{
				this._IsAdmin = true;
			}

			// check for specific rights
			if (!_user.IsInRole("credapprover") && !_user.IsInRole("credexcvw") && !_user.IsInRole("cersubmit") && !_user.IsInRole("creditmgr") && _IsAdmin == false)
			{
				Session["NoAccessMsg"] = "You do not have access to the Inventory Adjustment portion of this application";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}

			Commands cmd = new Commands();
			DataTable dt = new DataTable();
			_BuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
			_UserID = Convert.ToInt32(_user.UserID);
			_SitePrefix = Session["SitePrefix"].ToString();

			if (!this.IsPostBack)
			{

				// load user tracks
				//dt = cmd.SelectUserTracks(_UserID, _PageID, 0);
				//if (dt.Rows.Count > 0)
				//{
				//}

			}
			else
			{
				// Postback


			}
		}

		protected void btnSubmitReq_Click(object sender, EventArgs e)
		{

		}

		protected void btnSendToComp_Click(object sender, EventArgs e)
		{

		}

		protected void btnCompleteReq_Click(object sender, EventArgs e)
		{

		}

		protected void btnSendToPDF_Click(object sender, EventArgs e)
		{

		}

		protected void btnNewCERAdj_Click(object sender, EventArgs e)
		{

		}

		protected void btnFindCERAdj_Click(object sender, EventArgs e)
		{

		}

		protected void btnFindCER_Click(object sender, EventArgs e)
		{

		}
	}
}