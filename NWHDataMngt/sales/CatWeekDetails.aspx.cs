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
	public partial class CatWeekDetails : System.Web.UI.Page
	{
		#region Variables
		CurrentUser _user = null;
		private CurrBrowser _Browser = null;
		private string _BuildNbr = "";
		private string _Color = string.Empty;
		private string _Desc1 = string.Empty;
		private string _Desc2 = string.Empty;
		private string _Desc3 = string.Empty;
		private string _Desc4 = string.Empty;
		private string _Desc5 = string.Empty;
		private string _Desc6 = string.Empty;
		private string _Desc7 = string.Empty;
		private string _Desc8 = string.Empty;
		private string _Desc9 = string.Empty;
		private string _Desc10 = string.Empty;
		private string _Grade = string.Empty;
		private string _Length = string.Empty;
		private int _MasterID = 0;
		private string _Milling = string.Empty;
		private string _NoPrint = string.Empty;
		private string _ProductID = String.Empty;
		private string _ProdType = String.Empty;
		private string _Sort = string.Empty;
		private string _Species = string.Empty;
		private string _TargetDate = String.Empty;
		private string _Thickness = string.Empty;
		private string _Val1 = string.Empty;
		private string _Val2 = string.Empty;
		private string _Val3 = string.Empty;
		private string _Val4 = string.Empty;
		private string _Val5 = string.Empty;
		private string _Val6 = string.Empty;
		private string _Val7 = string.Empty;
		private string _Val8 = string.Empty;
		private string _Val9 = string.Empty;
		private string _Val10 = string.Empty;

		private int _IWeek = 0;
		private int _NbrPages = 0;
		private int _NbrRows = 0;
		private int _PgNbr = 0;
		private int _PgSize = 20;
		private int _UserID = 0;
		private string _ErrMsg = string.Empty;
		#endregion Variables

		#region Attributes
		public string BuildNbr { get { return _BuildNbr; } }
		public string Desc1Label { get { return _Desc1; } }
		public string Desc2Label { get { return _Desc2; } }
		public string Desc3Label { get { return _Desc3; } }
		public string Desc4Label { get { return _Desc4; } }
		public string Desc5Label { get { return _Desc5; } }
		public string Desc6Label { get { return _Desc6; } }
		public string Desc7Label { get { return _Desc7; } }
		public string Desc8Label { get { return _Desc8; } }
		public string Desc9Label { get { return _Desc9; } }
		public string Desc10Label { get { return _Desc10; } }
		#endregion Attributes

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
			//this.divLoadingGif.Style["display"] = "block";
			string usrname = "";
			DateTime today = DateTime.Now;
			_PgNbr = 0;
			_PgSize = 20;
			//this.ddlPageSize.SelectedValue = "20";
			string logFilePath = System.Configuration.ConfigurationManager.AppSettings["AppLogFilePath"].ToString();

			string ips = System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
			string CurrSessionID = System.Web.HttpContext.Current.Session.SessionID;
			_Browser = new CurrBrowser(System.Web.HttpContext.Current.Request);

			usrname = Request.ServerVariables["LOGON_USER"];
			_user = new CurrentUser(usrname, logFilePath, ""); // SessionHelper.GetCurrentUser(Request.ServerVariables["LOGON_USER"]);
																												 // check for user rights to this page
			// Access rule
			if (_user == null || !_user.IsValid)
			{
				string AppLog = System.Configuration.ConfigurationManager.AppSettings["AppLogFilePath"].ToString();
				Log.WriteLogEntry("User Login failed " + usrname, AppLog);
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}

			_BuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
			_UserID = Convert.ToInt32(_user.UserID);
			int IsAdmin = 0;
			if (_user.IsAdmin == true) { IsAdmin = 1; }

			this.lblBuildNbr.InnerText = _BuildNbr.ToString();
			this.lblVersion.InnerText = System.Configuration.ConfigurationManager.AppSettings["AppVersion"].ToString();
			this.lblVersionDate.InnerText = System.Configuration.ConfigurationManager.AppSettings["AppVersionDate"].ToString();
			this.lblCurrentYearFtr.InnerText = today.Year.ToString();
			try
			{
				_ProductID = Request["p"].ToString();
				_TargetDate = Request["d"].ToString();
				_ProdType = Request["pt"].ToString();
				_TargetDate = Request["d"].ToString();
				_IWeek = Convert.ToInt32(Request["w"]);
				//_Thickness = Request["t"].ToString();
				//_Species = Request["s"].ToString();
				//_Grade = Request["g"].ToString();
				_Length = Request["ln"].ToString();
				_Color = Request["c"].ToString();
				_Sort = Request["st"].ToString();
				_Milling = Request["m"].ToString();
				_NoPrint = Request["np"].ToString();
				_MasterID = Convert.ToInt32(Request["mid"]);
				this.lblProductHdr.InnerHtml = _ProductID;
				this.lblProdTypeHdr.InnerHtml = _ProdType;
				this.lblTWeek.InnerHtml = _IWeek.ToString();
				this.lblTDateHdr.InnerHtml = _TargetDate;
				this.lblLengthP.InnerHtml = _Length;
				this.lblColorP.InnerHtml = _Color;
				this.lblSortP.InnerHtml = _Sort;
				this.lblMillingP.InnerHtml = _Milling;
				this.lblNoPrintP.InnerHtml = _NoPrint;
				this.lblMasterID.InnerHtml = _MasterID.ToString();
				if (_Length.Length == 0) { this.lblLengthP.InnerHtml = "&nbsp;&nbsp;&nbsp;&nbsp;"; }
				if (_Color.Length == 0) { this.lblColorP.InnerHtml = "&nbsp;&nbsp;&nbsp;&nbsp;"; }
				if (_Sort.Length == 0) { this.lblSortP.InnerHtml = "&nbsp;&nbsp;&nbsp;&nbsp;"; }
				if (_Milling.Length == 0) { this.lblMillingP.InnerHtml = "&nbsp;&nbsp;&nbsp;&nbsp;"; }
				if (_NoPrint.Length == 0) { this.lblNoPrintP.InnerHtml = "&nbsp;&nbsp;&nbsp;&nbsp;"; }
			}
			catch (Exception ex)
			{
				Response.Flush();
				Response.End();
			}

			string jsScript = "";
			jsScript = "<script type=\"text/javascript\">var jigEmpID=" + _user.UserID.ToString() + ";var jsgBrowserType='" + _Browser.BrowserType.ToString() + "';var jsgPMID=" + _MasterID.ToString() + ";var jsgPT='" + _ProdType + "';var jsgPC='" + _ProductID + "';var jsgLN='" + _Length + "';var jsgCL='" + _Color + "';var jsgSR='" + _Sort + "';var jsgML='" + _Milling + "';var jsgNP='" + _NoPrint + "';var jsgTDt='" + _TargetDate + "';var jigWN=" + _IWeek.ToString() + ";var jsgNm ='" + _user.FullName + "';var jbgIA=" + IsAdmin.ToString() + ";var jsgError='" + this._ErrMsg + "';</script>";
			Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "MyTargetVariables", jsScript);
		}
	}
}