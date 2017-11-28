using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;

namespace DataMngt.page
{
	public partial class MainMenu : System.Web.UI.Page
	{
		#region Attributes
		CurrentUser _user = null;
		private CurrBrowser _Browser = null;
		private string _CBuildNbr = "";
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
				Session["NoAccessMsg"] = "You do not have access to this application";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}
			if (_user.AccessRights < 1)
			{
				Session["NoAccessMsg"] = "You do not have access to this application.";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}

			_CBuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
			_UserID = Convert.ToInt32(_user.UserID);

			if (_user.IsInRole("hitscompvw") && _user.IsAdmin == false)
			{
				this.rowComputerAsset.Style["display"] = "none";
			}

			if (!_user.IsInRole("catAdmin") && !_user.IsInRole("catprcedit") && !_user.IsInRole("catAdmin") && !_user.IsInRole("datamngtcat") && _user.IsAdmin == false)
			{
				this.rowCatItems.Style["display"] = "none";
			}

			if (_user.IsInRole("datmngtAdmin") || _user.IsInRole("datmngtedit"))
			{
				this.rowEntities.Style["display"] = "block";
				this.rowLocations.Style["display"] = "block";
				this.rowEntities.Style["display"] = "block";
				this.rowCatTool.Style["display"] = "block";
				this.rowProcOwner.Style["display"] = "block";
				this.rowInvAdj.Style["display"] = "block";
				this.rowARAging.Style["display"] = "block";
				this.rowProdForecast.Style["display"] = "block";
				this.rowForecastConsolidaton.Style["display"] = "block";
				this.rowWurthTags.Style["display"] = "block";
				this.rowSalesPlan.Style["display"] = "block";
				this.rowSalesPlan2.Style["display"] = "block";
				this.rowSalesPlanspacer.Style["display"] = "block";
				this.rowWurthSpacer.Style["display"] = "block";
				this.rowEmailManagement.Style["display"] = "block";
				this.rowProcManagement.Style["display"] = "block";
				this.rowUserADInterface.Style["display"] = "block";
				this.rowWurthConvert.Style["display"] = "block";
				this.rowRequestMngt.Style["display"] = "block";
				this.rowIssueMngt.Style["display"] = "block";
				this.rowComments.Style["display"] = "block";
				this.rowWeeklyRpt.Style["display"] = "block";
				this.rowInvAnalysis.Style["display"] = "block";
			}
			else {
				// hide all rows by default if not administrator or full edit
				this.rowEntities.Style["display"] = "none";
				this.rowCatTool.Style["display"] = "none";
				this.rowLocations.Style["display"] = "none";
				//this.rowUsers.Style["display"] = "none";
				this.rowProcOwner.Style["display"] = "none";
				this.rowInvAdj.Style["display"] = "none";
				this.rowARAging.Style["display"] = "none";
				this.rowForecastConsolidaton.Style["display"] = "none";
				this.rowSalesPlan.Style["display"] = "none";
				this.rowSalesPlan2.Style["display"] = "none";
				this.rowSalesPlanspacer.Style["display"] = "none";
				//this.rowWurthTags.Style["display"] = "none";
				//this.rowWurthSpacer.Style["display"] = "none";
				this.rowComputerAssetSpacer.Style["display"] = "none";
				this.rowComputerAsset.Style["display"] = "none";
				this.rowEmailManagement.Style["display"] = "none";
				this.rowProcManagement.Style["display"] = "none";
				this.rowUserADInterface.Style["display"] = "none";
				this.rowWurthConvert.Style["display"] = "none";
				this.rowRequestMngt.Style["display"] = "block";
				this.rowIssueMngt.Style["display"] = "none";
				this.rowComments.Style["display"] = "none";
				this.rowInvAnalysis.Style["display"] = "none";
				this.rowProdForecast.Style["display"] = "none";

				// selectively show lines based on individual rights set
				if (_user.IsInRole("forecastadm") || _user.IsInRole("forecastedit") || _user.IsInRole("forecastview"))
				{
					this.rowProdForecast.Style["display"] = "block";
				}
				if (_user.IsInRole("datmngtVend"))
				{
					this.rowEntities.Style["display"] = "block";
				}
				if (_user.IsInRole("datmngtLoc"))
				{
					this.rowLocations.Style["display"] = "block";
				}
				if (_user.IsInRole("cowkrptvw") || _user.IsInRole("cowkrptedt") || _user.IsInRole("cowkrptadm"))
				{
					this.rowWeeklyRpt.Style["display"] = "block";
				}
				//if (_user.IsInRole("datmngtUser"))
				//{
				//	this.rowUsers.Style["display"] = "block";
				//}
				if (_user.IsInRole("datmngtCust"))
				{
					this.rowEntities.Style["display"] = "block";
				}
				if (_user.IsInRole("datmngtCat") || _user.IsInRole("catview") || _user.IsInRole("catAdmin") || _user.IsInRole("catprcedit") || _user.IsInRole("prodavlvw") || _user.IsInRole("prodavlad") || _user.IsInRole("prodavled") || _user.IsInRole("saleslead"))
				{
					this.rowCatTool.Style["display"] = "block";
				}
				if (_user.IsInRole("catprcedit"))
				{
					rowCatItems.Style["display"] = "block";
				}
				if (_user.IsInRole("consoldvw") || _user.IsInRole("consoldv2"))
				{
					this.rowForecastConsolidaton.Style["display"] = "block";
				}
				if (_user.IsInRole("wurthedt")) {
					rowWurthTags.Style["display"] = "block";
					rowWurthSpacer.Style["display"] = "block";
				}
				if (_user.ProcOwnerRight > 0)
				{
					this.rowProcOwner.Style["display"] = "block";
				}
				if (_user.IsInRole("invadjadm") || _user.IsInRole("invadjedit") || _user.IsInRole("invadjview") || _user.IsInRole("invadjapprv"))
				{
					this.rowInvAdj.Style["display"] = "block";
				}
				if (_user.IsInRole("creditmgr") || _user.IsInRole("cersubmit") || _user.IsInRole("credexcvw") || _user.IsInRole("credapprover"))
				{
					this.rowCreditExcReq.Style["display"] = "block";
				}
				if (_user.AccessARAgingRpt > 0)
				{
					this.rowARAging.Style["display"] = "block";
				}
				if (_user.IsInRole("salesplnvw") || _user.IsInRole("salesplnAdm"))
				{
					this.rowSalesPlanspacer.Style["display"] = "block";
					this.rowSalesPlan.Style["display"] = "block";
					//this.rowSalesPlan2.Style["display"] = "block";
				}
				if (_user.IsInRole("salesplnAdm"))
				{
					this.rowSalesPlan2.Style["display"] = "block";
				}

				if (_user.IsInRole("hitscompvw") || _user.IsInRole("hitscompedt") || _user.IsInRole("compassedt") || _user.IsInRole("compasset") || _user.IsInRole("compassadm"))
				{
					this.rowComputerAssetSpacer.Style["display"] = "block";
					this.rowComputerAsset.Style["display"] = "block";
				}

				if (_user.IsInRole("wurthcdedt") || _user.IsInRole("wurthcdvw") || _user.IsInRole("wurthcdadm"))
				{
					this.rowWurthConvert.Style["display"] = "block";
				}

				//if (_user.IsInRole("reqapprvw") || _user.IsInRole("reqappredt") || _user.IsInRole("reqappradm"))
				//{
				//	this.rowRequestMngt.Style["display"] = "block";
				//}

				if (_user.IsInRole("cmtmngtvw") || _user.IsInRole("cmtmngtedt") || _user.IsInRole("cmtmngtadm"))
				{
					this.rowComments.Style["display"] = "block";
				}

				if (_user.IsInRole("invmngtview") || _user.IsInRole("invmngtadm") || _user.IsInRole("invmngtedt"))
				{
					this.rowInvAnalysis.Style["display"] = "block";
				}
			}
		}
	}
}