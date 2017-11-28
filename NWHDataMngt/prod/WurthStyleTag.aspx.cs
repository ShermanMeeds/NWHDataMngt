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
	public partial class WurthStyleTag : System.Web.UI.Page
	{
		#region Attributes
		CurrentUser _user = null;
		private CurrBrowser _Browser = null;
		private string _CBuildNbr = "";
		private bool _CanEdit = false;
		private string _ErrMsg = string.Empty;
		private bool _IsAdmin = false;
		private string _LocationCode = String.Empty;
		private int _PageID = 25;
		private int _PgNbr1 = 0;
		private int _PgNbr2 = 0;
		private int _PgNbr3 = 0;
		private int _PgNbr4 = 0;
		private int _PgNbr5 = 0;
		private int _PgSize = 20;
		private string _SpeciesCode = string.Empty;
		private DateTime _TargetDate = DateTime.Now;
		private int _TargetGrid = 0;
		private int _UserID = 0;
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

			// check for specific rights
			if (!_user.IsInRole("wurthedt") && !_user.IsInRole("datmngtedit") && !_user.IsInRole("datmngtview") && !_user.IsAdmin == true)
			{
				Session["NoAccessMsg"] = "You do not have access to wurth generation.";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}
			this._CanEdit = true;
			this._IsAdmin = _user.IsAdmin;
			_CBuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
			_UserID = Convert.ToInt32(_user.UserID);
			_LocationCode = _user.LocationCode;

			if (!this.IsPostBack)
			{
				try
				{
					var _TargetDate = DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek + (int)DayOfWeek.Monday);

					ViewState.Add("TargetDate", _TargetDate.ToString());
					ViewState.Add("LocationCode", _LocationCode);
					ViewState.Add("TargetGrid", _TargetGrid.ToString());
				}
				catch (Exception ex)
				{
					this._ErrMsg = "Initial data Load encountered an error: " + ex.Message;
					this.lblErrorMsg.Text = this._ErrMsg;
				}
			}
			else
			{
				// postback
				_TargetDate = Convert.ToDateTime(ViewState["TargetDate"]);
				_LocationCode = ViewState["LocationCode"].ToString();
				_TargetGrid = Convert.ToInt32(ViewState["TargetGrid"]);
			}
			//string jsScript = "";
			//jsScript = "<script type=\"text/javascript\">var jigEmpID=" + _user.EmpID.ToString() + ";var jsgBrowserType='" + _Browser.BrowserType.ToString() + "';var jsgAr=" + _user.AccessRights.ToString() + ";</script>";
			//Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "MyTargetVariables", jsScript);
		}

		protected void LoadOrderItemsGrid()
		{
			try
			{
				int NbrItems = 0;
				int OrdNbr = Convert.ToInt32(this.txtOrderNbr.Text);
				int AllWurth = 0;
				if (chkWurthOnly.Checked == true) { AllWurth = 1; }
				//Commands cmd = new Commands();
				//DataTable dt = cmd.SelectOrderItemData(OrdNbr, 1, 0, _UserID);
				SalesFunctions sf = new SalesFunctions();
				DataTable dt = sf.SelectLTWurthProductData(OrdNbr, 0, AllWurth, _UserID);
				gvOrderItems.DataSource = dt;
				gvOrderItems.DataBind();
				NbrItems = dt.Rows.Count;
				txtNbrItems.Text = NbrItems.ToString();
				if (NbrItems > 0)
				{
					if (NbrItems > 0) { spnPrintBtn1.Style["display"] = "inline"; }
					if (NbrItems > 20) { spnPrintBtn2.Style["display"] = "inline"; }
					if (NbrItems > 40) { spnPrintBtn3.Style["display"] = "inline"; }
					if (NbrItems > 60) { spnPrintBtn4.Style["display"] = "inline"; }
					if (NbrItems > 80) { spnPrintBtn5.Style["display"] = "inline"; }
					if (NbrItems > 100) { spnPrintBtn6.Style["display"] = "inline"; }
				}
				else
				{
					this._ErrMsg = "No order items were found.";
					this.lblErrorMsg.Text = this._ErrMsg;
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error while loading order items: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void txtOrderNbr_TextChanged(object sender, EventArgs e)
		{
			this._ErrMsg = "";
			this.lblErrorMsg.Text = "";
			int NbrItems = 0;
			try
			{
				lblPageStatus.Text = "Please wait...";
				int OrdNbr = Convert.ToInt32(this.txtOrderNbr.Text);
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectOrderNbrData(OrdNbr, _UserID);
				if (dt.Rows.Count > 0)
				{
					txtCustomerName.Text = dt.Rows[0]["CustName"].ToString();
					txtLocType.Text = dt.Rows[0]["CustName"].ToString();
					txtLocationName.Text = dt.Rows[0]["LocDesc"].ToString();
					NbrItems = Convert.ToInt32(dt.Rows[0]["NbrItems"]);
					txtNbrItems.Text = NbrItems.ToString();
					//if (NbrItems > 0) { spnPrintBtn1.Style["display"] = "inline"; }
					//if (NbrItems > 20) { spnPrintBtn2.Style["display"] = "inline"; }
					//if (NbrItems > 40) { spnPrintBtn3.Style["display"] = "inline"; }
					//if (NbrItems > 60) { spnPrintBtn4.Style["display"] = "inline"; }
					//if (NbrItems > 80) { spnPrintBtn5.Style["display"] = "inline"; }
					//if (NbrItems > 100) { spnPrintBtn6.Style["display"] = "inline"; }
					LoadOrderItemsGrid();
					lblPageStatus.Text = "Order data has been loaded";
				}
				else
				{
					this._ErrMsg = "That order number was not found.";
					this.lblErrorMsg.Text = this._ErrMsg;
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Initial data Load encountered an error: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void btnPrintWurthTag_Click(object sender, EventArgs e)
		{
			lblPageStatus.Text = "Printing...";
			int OrdNbr = Convert.ToInt32(this.txtOrderNbr.Text);
			string AllWurth = "0";
			if (chkWurthOnly.Checked == true) { AllWurth = "1"; }
			Response.Redirect("WurthTagPreview.aspx?p=0&o=" + OrdNbr.ToString() + "&w=" + AllWurth, false);

		}

		protected void btnPrintWurthTag2_Click(object sender, EventArgs e)
		{
			lblPageStatus.Text = "Printing...";
			int OrdNbr = Convert.ToInt32(this.txtOrderNbr.Text);
			string AllWurth = "0";
			if (chkWurthOnly.Checked == true) { AllWurth = "1"; }
			Response.Redirect("WurthTagPreview.aspx?p=1&o=" + OrdNbr.ToString() + "&w=" + AllWurth, false);
		}

		protected void btnPrintWurthTag3_Click(object sender, EventArgs e)
		{
			lblPageStatus.Text = "Printing...";
			int OrdNbr = Convert.ToInt32(this.txtOrderNbr.Text);
			string AllWurth = "0";
			if (chkWurthOnly.Checked == true) { AllWurth = "1"; }
			Response.Redirect("WurthTagPreview.aspx?p=2&o=" + OrdNbr.ToString() + "&w=" + AllWurth, false);
		}

		protected void btnPrintWurthTag4_Click(object sender, EventArgs e)
		{
			lblPageStatus.Text = "Printing...";
			int OrdNbr = Convert.ToInt32(this.txtOrderNbr.Text);
			string AllWurth = "0";
			if (chkWurthOnly.Checked == true) { AllWurth = "1"; }
			Response.Redirect("WurthTagPreview.aspx?p=3&o=" + OrdNbr.ToString() + "&w=" + AllWurth, false);
		}

		protected void btnPrintWurthTag5_Click(object sender, EventArgs e)
		{
			lblPageStatus.Text = "Printing...";
			int OrdNbr = Convert.ToInt32(this.txtOrderNbr.Text);
			string AllWurth = "0";
			if (chkWurthOnly.Checked == true) { AllWurth = "1"; }
			Response.Redirect("WurthTagPreview.aspx?p=4&o=" + OrdNbr.ToString() + "&w=" + AllWurth, false);
		}

		protected void btnPrintWurthTag6_Click(object sender, EventArgs e)
		{
			lblPageStatus.Text = "Printing...";
			string AllWurth = "0";
			if (chkWurthOnly.Checked == true) { AllWurth = "1"; }
			int OrdNbr = Convert.ToInt32(this.txtOrderNbr.Text);
			Response.Redirect("WurthTagPreview.aspx?p=5&o=" + OrdNbr.ToString() + "&w=" + AllWurth, false);
		}
	}
}