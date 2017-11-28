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
  public partial class ctlButtonBar : System.Web.UI.UserControl
  {
    #region Attributes
    CurrentUser _user = null;
    private CurrBrowser _Browser = null;
    private string _CBuildNbr = ""; 
    private bool _CanEdit = false;
    private bool _IsAdmin = false;
    private int _UserID = 0;
		#endregion Attributes

    protected void Page_Load(object sender, EventArgs e)
    {
			string usrname = "";
			//_PgNbr = 0;
			//_PgSize = 20;
			//this.ddlPageSize.SelectedValue = "20";
			string logFilePath = System.Configuration.ConfigurationManager.AppSettings["AppLogFilePath"].ToString();
			string CEnvironment = System.Configuration.ConfigurationManager.AppSettings["Environment"].ToString();
			this.lblEnvironmentName.Text = CEnvironment;

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

			int IsAssumed = 0;
			string AssumedLogin = string.Empty;
			if (HttpContext.Current.Session["AssumedEntityLogin"] != null)
			{
				if (HttpContext.Current.Session["AssumedEntityLogin"].ToString() != "") { AssumedLogin = HttpContext.Current.Session["AssumedEntityLogin"].ToString(); }
			}
			if (AssumedLogin != "") { IsAssumed = 1; }
			// get user object and put it in the session
			if (_user == null)
			{
				if (HttpContext.Current.Session["CurrentUser"] != null)
				{
					_user = (CurrentUser)HttpContext.Current.Session["CurrentUser"];
				}
				else
				{
					_user = new CurrentUser(usrname, logFilePath, AssumedLogin); // SessionHelper.GetCurrentUser(Request.ServerVariables["LOGON_USER"]);
					HttpContext.Current.Session["CurrentUser"] = _user;
				}
			}
			// Access rule
			if (_user == null || !_user.IsValid)
			{
				string AppLog = System.Configuration.ConfigurationManager.AppSettings["AppLogFilePath"].ToString();
				Log.WriteLogEntry("User Login failed " + usrname, AppLog);
				Session["NoAccessMsg"] = "You do not have access to the check approval application";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}
			
			_CBuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
			_UserID = Convert.ToInt32(_user.UserID);
			this.lblPersonLoggedInName.Text = _user.LastName + ", " + _user.FirstName;

			if (_user.AccessRights > 4 || _user.CatToolRights > 4 || _user.EditCustomers > 4 || _user.EditLocations > 4 || _user.EditUsers > 4 || _user.EditVendors > 4) {
        this.divShowAdminStuff.Style["display"] = "inline-table";
      }

			//Page.ClientScript.RegisterOnSubmitStatement(typeof(Page), "closePage", "window.onunload = QuitApplication();");
			string jsScript = "";
			jsScript = "<script type=\"text/javascript\">var jigEmpID=" + _user.UserID.ToString() + ";var jsgCBBrowserType='" + _Browser.BrowserType.ToString() + "';var jsgCBAssumd=" + IsAssumed.ToString() + ";var jgCBA=" + _user.IsAdmin.ToString().ToLower() + ";</script>";
			Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "MyTargetVariablesCB", jsScript);
		}
	}
}