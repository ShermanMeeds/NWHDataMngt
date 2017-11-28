using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using DataLayer;

namespace DataMngt.tools
{
	public partial class ctlButtonBarNoSess : System.Web.UI.UserControl
	{
		#region Attributes
		CurrentUser _user = null;
		private CurrBrowserNoSess _Browser = null;
		private string _CBuildNbr = "";
		//private bool _CanEdit = false;
		private string _ErrMsg = string.Empty;
		private int _UserID = 0;
		#endregion Attributes

		protected void Page_Load(object sender, EventArgs e)
		{
			string usrname = "";
			int HideUsers = 0;
			//_PgNbr = 0;
			//_PgSize = 20;
			//this.ddlPageSize.SelectedValue = "20";
			string logFilePath = System.Configuration.ConfigurationManager.AppSettings["AppLogFilePath"].ToString();
			string CEnvironment = System.Configuration.ConfigurationManager.AppSettings["Environment"].ToString();
			this.lblEnvironmentName.Text = CEnvironment;
			int IsAssumed = 0;
			string AssumedLogin = string.Empty;
			//if (HttpContext.Current.Session["AssumedEntityLogin"] != null)
			//{
			//	if (HttpContext.Current.Session["AssumedEntityLogin"].ToString() != "") { AssumedLogin = HttpContext.Current.Session["AssumedEntityLogin"].ToString(); }
			//}
			if (AssumedLogin != "") { IsAssumed = 1; }
			// grab browser data
			string ips = System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
			_Browser = new CurrBrowserNoSess(System.Web.HttpContext.Current.Request);
			usrname = Request.ServerVariables["LOGON_USER"];
			_user = new CurrentUser(usrname, logFilePath, AssumedLogin); // SessionHelper.GetCurrentUser(Request.ServerVariables["LOGON_USER"]);

			// Access rule
			if (_user == null || !_user.IsValid)
			{
				string AppLog = System.Configuration.ConfigurationManager.AppSettings["AppLogFilePath"].ToString();
				Log.WriteLogEntry("User Login failed " + usrname, AppLog);
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}

			_CBuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
			_UserID = Convert.ToInt32(_user.UserID);
			this.lblPersonLoggedInName.Text = _user.LastName + ", " + _user.FirstName;

			if (_user.AccessRights > 4 || _user.EditUsers > 4 || _user.IsAdmin == true)
			{
				this.divShowAdminStuff.Style["display"] = "inline-table";
			}
			
			string jsScript = "";
			jsScript = "<script type=\"text/javascript\">var jCBigEmpID=" + _user.UserID.ToString() + ";var jsgCBBrowserType='" + _Browser.BrowserType.ToString() + "';var jgCBA=" + _user.IsAdmin.ToString().ToLower() + ";var jsgCBPageA='" + _user.PageAdministrators.ToString() + "';var jsgCBAssumd=" + IsAssumed.ToString() + ";var jCBsgError ='" + this._ErrMsg + "';</script>";
			Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "MyTargetVariablesCB", jsScript);
		}
	}
}