using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Threading;
using System.Data;
using DataLayer;
using DataMngt;

public partial class WindowsLogin : System.Web.UI.Page
{
	CurrBrowser bwsr;
	CurrentUser _user = null;

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

		// initialize variables
		bool Okay = true;
		int Pg = 0;
		Guid g = Guid.Empty;
		string sGUID = String.Empty;
		string sPG = String.Empty;
		string redirectUrl = "NoAcc/NoAccess.aspx";
		string UserName = Request.ServerVariables["LOGON_USER"];
		HttpContext.Current.Session["AssumedEntityLogin"] = string.Empty;
		//lblStatusMsg.Text = UserName;
		System.IO.Directory.SetCurrentDirectory(AppDomain.CurrentDomain.BaseDirectory);

		if (!String.IsNullOrWhiteSpace(Request["p"]))
		{
			Pg = Convert.ToInt32(Request["p"].ToString());
		}
		else
		{
			Pg = 0;
		}
		if (!string.IsNullOrWhiteSpace(Request["g"]))
		{
			sGUID = new Guid(sGUID).ToString();
		}
		else
		{
			sGUID = Guid.Empty.ToString();
		}
		if (!string.IsNullOrWhiteSpace(sGUID)) { }

		string logFilePath = System.Configuration.ConfigurationManager.AppSettings["AppLogFilePath"].ToString();
		//string UserName2 = System.Web.HttpContext.Current.User.Identity.Name;
		//string jsScript = "<script type=\"text/javascript\">alert('" + UserName + "');</script>";
		//Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "MyTargetVariables", jsScript);
		//Label l = (Label)this.FindControl("Label1");
		//l.Text = UserName;
		//Response.Flush();
		//Response.End();
		//Label l2 = (Label)this.FindControl("Label2");

		//l2.Text = UserName2;
		//throw new Exception("No Way");

		HttpContext.Current.Session["UserName"] = UserName;
		// identify user
		_user = new CurrentUser(UserName, logFilePath, "");
		if (_user == null || !_user.IsValid)
		{
			// write to log
			Logging.WriteToLog("Login failed for " + UserName + ".");
			HttpContext.Current.Session["NoAccessMsg"] = "No valid login record found. You do not have access to the coding application";
			HttpContext.Current.Response.Redirect("NoAcc/NoAccess.aspx", true);
		}
		else
		{
			Session["CurrentUser"] = _user;
			Logging.WriteToLog("Login user object instantiated for " + UserName + ".");
		}

		// establish user authentication objects and identify next page
		try
		{
			FormsAuthenticationTicket authTicket = null;
			FormsAuthentication.Initialize();
			authTicket = new FormsAuthenticationTicket(1, UserName, DateTime.Now, DateTime.Now.AddMinutes(System.Web.HttpContext.Current.Session.Timeout), true, _user.UserID.ToString());
			string encTicket = FormsAuthentication.Encrypt(authTicket);
			System.Web.HttpContext.Current.Response.Cookies.Add(new HttpCookie(FormsAuthentication.FormsCookieName, encTicket));

			bwsr = (CurrBrowser)Session["bw"];
			string ips = System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
			Logging.WriteToLog("Login established for " + UserName + ".");
			GenUtilities.LoadUserSessionData(_user, UserName);
			// log session start
			Commands cmd = new Commands();
			string SessID = String.Empty;
			SessID = Session["SessionID"].ToString();
			int iRtn = cmd.LogSessionStart("DataMngt", _user.LoginName, _user.UserID, bwsr.BrowserType, bwsr.BrowserType, ips, "Windows", SessID);
			Session["DataLoaded"] = "0";

			redirectUrl = "~/page/MainMenu.aspx"; // ------------------------------------------------------
		}
		catch (Exception ex)
		{
			//write to log
			Logging.WriteToLog("Data Management Application could not establish authentication forms ticket: " + ex.Message);
			Okay = false;
		}

		// TEMPORARY *******************************************************************
		//Pg = 4;

		//lblStatusMsg.Text = "Initial 3";
		//Response.Flush();
		//Response.End();
		redirectUrl = "page/MainMenu.aspx"; 

		switch (Pg)
		{
			case 0: //menu
				redirectUrl = "page/MainMenu.aspx"; 
				break;
			case 1: // cat tool
				if (_user.IsInRole("catprcedit") || _user.IsInRole("datmngtAdmin") || _user.IsInRole("datmngtedit") || _user.IsInRole("datmngtview") || _user.IsInRole("datmngtCat") || _user.IsInRole("catview") || _user.IsInRole("catAdmin") || _user.IsInRole("prodavlvw") || _user.IsInRole("prodavlad") || _user.IsInRole("prodavled") || _user.IsInRole("saleslead") || _user.IsAdmin == true)
				{
					redirectUrl = "sales/CatTool.aspx"; 
				}
				break;
			case 2:
				if (_user.IsInRole("catprcedit") || _user.IsInRole("datmngtAdmin") || _user.IsInRole("datmngtedit") || _user.IsInRole("datmngtview") || _user.IsAdmin == true)
				{
					redirectUrl = "sales/SalesProducts.aspx"; 
				}
				break;
			case 3:
				redirectUrl = "page/QueryTool.aspx";
				break;
			case 4:
				if (_user.IsInRole("datmngtAdmin") || _user.IsInRole("datmngtedit") || _user.IsInRole("datmCustAdm") || _user.IsInRole("datmVendAdm") || _user.IsAdmin == true)
				{
					redirectUrl = "page/EntityList.aspx";
				}
				break;
			case 5:
				if (_user.IsInRole("datmngtAdmin") || _user.IsInRole("datmngtedit") || _user.IsInRole("forecastview") || _user.IsInRole("forecastadm") || _user.IsInRole("forecastedit") || _user.IsAdmin == true)
				{
					redirectUrl = "prod/ForecastTool.aspx"; 
				}
				break;
			case 6:
				if (_user.IsInRole("datmngtAdmin") || _user.IsInRole("datmngtedit") || _user.IsInRole("consoldvw") || _user.IsInRole("consoldv2") || _user.IsAdmin == true)
				{
					redirectUrl = "prod/ForecastConsolidation.aspx";
				}
				break;
			case 7:
				if (_user.IsInRole("datmngtAdmin") || _user.IsInRole("datmngtedit") || _user.IsInRole("salesplnvw") || _user.IsAdmin == true)
				{
					redirectUrl = "sales/SalesPlan.aspx";
				}
				break;
			case 8:
					redirectUrl = "page/WebCalendar.aspx";
				break;
			case 9:
				if (_user.IsInRole("datmngtAdmin") || _user.IsInRole("datmngtedit") || _user.IsInRole("wurthedt") || _user.IsInRole("wurthcdadm") || _user.IsInRole("wurthcdedt") || _user.IsInRole("wurthcdvw") || _user.IsAdmin == true)
				{
					redirectUrl = "prod/WurthStyleTag.aspx";
				}
				break;
			case 10:
				if (_user.IsInRole("datmngtAdmin") || _user.IsInRole("datmngtedit") || _user.IsInRole("wurthcdadm") || _user.IsInRole("wurthcdedt") || _user.IsInRole("wurthcdvw") || _user.IsAdmin == true)
				{
					redirectUrl = "prod/WurthConversion.aspx";
				}
				break;
			case 11:
				if (_user.IsAdmin == true || _user.ClaimsRights > 0)
				{
					redirectUrl = "finance/InvoiceAdj.aspx";
				}
				break;
			case 13:
				if (_user.IsInRole("datmngtAdmin") || _user.IsInRole("datmngtedit") || _user.IsInRole("sessmngtvw") || _user.IsInRole("sessmngtedt") || _user.IsInRole("sessmngtadm") || _user.IsInRole("procmngtvw") || _user.IsInRole("procmngtedt") || _user.IsInRole("procmngtadm") || _user.IsAdmin == true)
				{
					redirectUrl = "mngt/SessionMngt.aspx";
				}
				break;
			case 14:
				if (_user.IsInRole("datmngtAdmin") || _user.IsInRole("datmngtedit") || _user.IsInRole("issuemngtvw") || _user.IsInRole("issuemngtedt") || _user.IsInRole("issuemngtadm") || _user.IsAdmin == true)
				{
					redirectUrl = "mngt/IssueMngt.aspx";
				}
				break;
			case 15:
				if (_user.IsInRole("datmngtAdmin") || _user.IsInRole("datmngtedit") || _user.IsInRole("emailmngtvw") || _user.IsInRole("emailmngtedt") || _user.IsInRole("emailmngtadm") || _user.IsAdmin == true)
				{
					redirectUrl = "mngt/EmailMngt.aspx";
				}
				break;
			case 16:
				if (_user.IsInRole("datmngtAdmin") || _user.IsInRole("datmngtedit") || _user.IsInRole("procmngtvw") || _user.IsInRole("procmngtedt") || _user.IsInRole("procmngtadm") || _user.IsAdmin == true)
				{
					redirectUrl = "mngt/ProcessManagement.aspx";
				}
				break;
			case 17:
				if (_user.IsInRole("datmngtAdmin") || _user.IsInRole("datmngtedit") || _user.IsInRole("useredit") || _user.IsInRole("datmUserAdm") || _user.IsInRole("userview") || _user.IsAdmin == true)
				{
					redirectUrl = "mngt/EditUser.aspx";
				}
				break;
			case 18:
				if (_user.IsInRole("datmngtAdmin") || _user.IsInRole("datmngtedit") || _user.IsInRole("useredit") || _user.IsInRole("datmUserAdm") || _user.IsInRole("userview") || _user.IsAdmin == true)
				{
					redirectUrl = "mngt/EditUserRights.aspx";
				}
				break;
			case 19:
				if (_user.IsInRole("datmngtAdmin") || _user.IsInRole("datmngtedit") || _user.IsInRole("cmtmngtvw") || _user.IsInRole("cmtmngtedt") || _user.IsInRole("cmtmngtadm") || _user.IsInRole("cmtmngtcw") || _user.IsAdmin == true)
				{
					redirectUrl = "page/GenComment.aspx";
				}
				break;
			default:
				break;
		}

    redirectUrl = redirectUrl + "?p=" + Pg.ToString() + "&g=" + sGUID;
    //redirectUrl = "NoAcc/NoAccess.aspx";
    // redirect to next page
    //try
    //{
    //  if (Okay == true)
    //  {
    if (Response.IsClientConnected)
    {
      Response.Redirect(redirectUrl, false);
    }
    else
    {
      //string msg = "";
      Response.Write("You are not connected.");
    }
    
  }
}