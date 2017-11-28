using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using DataLayer;

namespace DataMngt.page
{
	public partial class pProductDetails : System.Web.UI.Page
	{
		#region Variables
		CurrentUser _user = null;
		private CurrBrowser _Browser = null;
		private string _CBuildNbr = "";
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
			_PgNbr = 0;
			_PgSize = 20;
			//this.ddlPageSize.SelectedValue = "20";
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
				Session["NoAccessMsg"] = "You do not have access to the check approval application";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}

			// check for specific rights to cat tool
			if (_user.AccessRights < 2 && _user.CatToolRights == 0)
			{
				Session["NoAccessMsg"] = "You do not have access to the Cat Tool.";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}

			_CBuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
			_UserID = Convert.ToInt32(_user.UserID);

			// *****************************************************************
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
				this.lblProductHdr.Text = _ProductID;
				this.lblProdTypeHdr.Text = _ProdType;
				this.lblTWeek.Text = _IWeek.ToString();
				this.lblTDateHdr.Text = _TargetDate;
				this.lblLengthP.Text = _Length;
				this.lblColorP.Text = _Color;
				this.lblSortP.Text = _Sort;
				this.lblMillingP.Text = _Milling;
				this.lblNoPrintP.Text = _NoPrint;
				this.lblMasterID.Text = _MasterID.ToString();
				if (_Length.Length == 0) { this.lblLengthP.Text = "&nbsp;&nbsp;&nbsp;&nbsp;"; }
				if (_Color.Length == 0) { this.lblColorP.Text = "&nbsp;&nbsp;&nbsp;&nbsp;"; }
				if (_Sort.Length == 0) { this.lblSortP.Text = "&nbsp;&nbsp;&nbsp;&nbsp;"; }
				if (_Milling.Length == 0) { this.lblMillingP.Text = "&nbsp;&nbsp;&nbsp;&nbsp;"; }
				if (_NoPrint.Length == 0) { this.lblNoPrintP.Text = "&nbsp;&nbsp;&nbsp;&nbsp;"; }

				LoadDetailsGrid();
			}
			catch (Exception ex)
			{
				Response.Flush();
				Response.End();
			}
		}

		protected void LoadDetailsGrid()
		{
			CatToolFunctions ctf = new CatToolFunctions();
			try
			{
				this.divProductDetailsGrid.Style["display"] = "block";
				this.divShowProdDetailNoRows.Style["display"] = "none";
				DataTable dt = ctf.GetCatToolDetails2(_MasterID, _ProdType, _ProductID, _Length, _Color, _Sort, _Milling, _NoPrint, _TargetDate, 0, 0, _PgSize, _UserID);
				this.gvProductDetails.DataSource = dt;
				this.gvProductDetails.DataBind();
				if (dt.Rows.Count == 0)
				{
					//	// fill in header row
					//	this.lblDesc1Hdr.Text = dt.Rows[0]["desc1label"].ToString();
					//	this.lblDesc2Hdr.Text = dt.Rows[0]["desc2label"].ToString();
					//	this.lblDesc3Hdr.Text = dt.Rows[0]["desc3label"].ToString();
					//	this.lblDesc4Hdr.Text = dt.Rows[0]["desc4label"].ToString();
					//	this.lblDesc5Hdr.Text = dt.Rows[0]["desc5label"].ToString();
					//	this.lblDesc6Hdr.Text = dt.Rows[0]["desc6label"].ToString();
					//	this.lblDesc7Hdr.Text = dt.Rows[0]["desc7label"].ToString();
					//	this.lblDesc8Hdr.Text = dt.Rows[0]["desc8label"].ToString();
					//	this.lblDesc9Hdr.Text = dt.Rows[0]["desc9label"].ToString();
					//	this.lblDesc10Hdr.Text = dt.Rows[0]["desc10label"].ToString();
					//	// fill in actual values for attributes
					//	this.lblDescVal1.Text = dt.Rows[0]["desc1"].ToString();
					//	this.lblDescVal2.Text = dt.Rows[0]["desc2"].ToString();
					//	this.lblDescVal3.Text = dt.Rows[0]["desc3"].ToString();
					//	this.lblDescVal4.Text = dt.Rows[0]["desc4"].ToString();
					//	this.lblDescVal5.Text = dt.Rows[0]["desc5"].ToString();
					//	this.lblDescVal6.Text = dt.Rows[0]["desc6"].ToString();
					//	this.lblDescVal7.Text = dt.Rows[0]["desc7"].ToString();
					//	this.lblDescVal8.Text = dt.Rows[0]["desc8"].ToString();
					//	this.lblDescVal9.Text = dt.Rows[0]["desc9"].ToString();
					//	this.lblDescVal10.Text = dt.Rows[0]["desc10"].ToString();
					this.divProductDetailsGrid.Style["display"] = "none";
					this.divShowProdDetailNoRows.Style["display"] = "block";
				}
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error when loading main data grid: " + ex.Message;
			}

			try
			{
				DataTable dt2 = ctf.GetCatToolProductData2(_ProdType, _ProductID, _TargetDate, 0, 2, _UserID);
				if (dt2.Rows.Count > 0)
				{
					// fill in header row
					this.lblDesc1Hdr.Text = dt2.Rows[0]["desc1label"].ToString();
					this.lblDesc2Hdr.Text = dt2.Rows[0]["desc2label"].ToString();
					this.lblDesc3Hdr.Text = dt2.Rows[0]["desc3label"].ToString();
					this.lblDesc4Hdr.Text = dt2.Rows[0]["desc4label"].ToString();
					this.lblDesc5Hdr.Text = dt2.Rows[0]["desc5label"].ToString();
					this.lblDesc6Hdr.Text = dt2.Rows[0]["desc6label"].ToString();
					this.lblDesc7Hdr.Text = dt2.Rows[0]["desc7label"].ToString();
					this.lblDesc8Hdr.Text = dt2.Rows[0]["desc8label"].ToString();
					this.lblDesc9Hdr.Text = dt2.Rows[0]["desc9label"].ToString();
					this.lblDesc10Hdr.Text = dt2.Rows[0]["desc10label"].ToString();
					// fill in actual values for descriptors
					this.lblDescVal1.Text = dt2.Rows[0]["desc1"].ToString();
					this.lblDescVal2.Text = dt2.Rows[0]["desc2"].ToString();
					this.lblDescVal3.Text = dt2.Rows[0]["desc3"].ToString();
					this.lblDescVal4.Text = dt2.Rows[0]["desc4"].ToString();
					this.lblDescVal5.Text = dt2.Rows[0]["desc5"].ToString();
					this.lblDescVal6.Text = dt2.Rows[0]["desc6"].ToString();
					this.lblDescVal7.Text = dt2.Rows[0]["desc7"].ToString();
					this.lblDescVal8.Text = dt2.Rows[0]["desc8"].ToString();
					this.lblDescVal9.Text = dt2.Rows[0]["desc9"].ToString();
					this.lblDescVal10.Text = dt2.Rows[0]["desc10"].ToString();
				}
			}
			catch (Exception ex2)
			{
				this.lblErrorMsg.Text = "Error when loading product data: " + ex2.Message;
			}
		}

		private string UnfixRequestValues(string val)
		{
			string nval = val;
			nval = val.Replace("_2", "#");
			nval = val.Replace("|", "/");
			nval = val.Replace("_1", "-");
			nval = val.Replace("_3", "\"");
			nval = val.Replace("_4", "\\");
			//nval = val.Replace("'", "");
			return nval;
		}

		protected void gvProductDetails_PageIndexChanged(object sender, EventArgs e)
		{
			//do nothing
		}

		protected void gvProductDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
		{
			try
			{
				_PgNbr = e.NewPageIndex;
				gvProductDetails.PageIndex = _PgNbr;
				LoadDetailsGrid();
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error when attempting to change page: " + ex.Message;
			}
		}

		protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
		{
			try
			{
				_PgSize = Convert.ToInt32(this.ddlPageSize.SelectedValue);
				_PgNbr = 0;
				gvProductDetails.PageIndex = _PgNbr;
				gvProductDetails.PageSize = _PgSize;
				LoadDetailsGrid();
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error when attempting to change page size: " + ex.Message;
			}
		}
	}
}