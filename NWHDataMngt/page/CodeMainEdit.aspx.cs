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
	public partial class CodeMainEdit : System.Web.UI.Page
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
				Session["NoAccessMsg"] = "You do not have access to the code edit page";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}

			// check for specific rights to cat tool
			if (_user.AccessRights < 2 && _user.ProdAvailRights == 0)
			{
				Session["NoAccessMsg"] = "You do not have access to the code edit page.";
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
					LoadCodeListGrid();
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

		protected void gvCodeList_PageIndexChanged(object sender, EventArgs e)
		{
			// do nothing
		}

		protected void gvCodeList_PageIndexChanging(object sender, GridViewPageEventArgs e)
		{
			_PgNbr = e.NewPageIndex;
			LoadCodeListGrid();
		}

		protected void LoadCodeListGrid()
		{
			try
			{
				string cls = this.ddlAppAreaF.SelectedValue;
				string cgroup = this.ddlCodeGroupF.SelectedValue;
				int act = Convert.ToInt32(this.ddlActiveStatusF.SelectedValue);
				int psize = Convert.ToInt32(this.ddlPageSize.SelectedValue);
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectCodeList(cls, cgroup, act, 2, 0, _UserID);
				gvCodeList.PageIndex = _PgNbr;
				gvCodeList.PageSize = _PgSize;
				gvCodeList.DataSource = dt;
				gvCodeList.DataBind();
				if (dt.Rows.Count < 1)
				{
					this.lblStatusMsg.Text = "No rows matching that criteria were extracted.";
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "The attempt to load the data grid encountered an error: " + ex.Message;
				this.lblStatusMsg.Text = this._ErrMsg;
			}

		}

		protected void gvCodeList_DataBound(object sender, EventArgs e)
		{

		}

		protected void gvCodeList_RowCommand(object sender, GridViewCommandEventArgs e)
		{
			try
			{
				int Ridx = Convert.ToInt32(e.CommandArgument);
				switch (e.CommandName)
				{
					case "Change":
						HiddenField hf = (HiddenField)gvCodeList.Rows[Ridx].FindControl("hfSelectedVal");
						string sshown = hf.Value;
						hf = (HiddenField)gvCodeList.Rows[Ridx].FindControl("hfCodeID");
						int ID = Convert.ToInt32(hf.Value);
						int shown = 0;
						if (sshown == "0") { shown = 1; }
						Commands cmd = new Commands();
						DataTable dt = cmd.UpdateCodeListItem(ID, 0, shown, _UserID);
						Button btn = (Button)gvCodeList.Rows[Ridx].FindControl("btnChangeShownVal");
						if (shown == 1)
						{
							btn.Text = "Hide";
						}
						else
						{
							btn.Text = "Show";
						}
						break;
					default:
						break;
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Your change attempt encountered an error: " + ex.Message;
				this.lblStatusMsg.Text = this._ErrMsg;
			}
}

		protected void gvCodeList_Sorting(object sender, GridViewSortEventArgs e)
		{

		}

		protected void gvCodeList_Sorted(object sender, EventArgs e)
		{

		}

		protected void btnRequeryData_Click(object sender, EventArgs e)
		{
			LoadCodeListGrid();
		}

		protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
		{
			_PgSize = Convert.ToInt32(this.ddlPageSize.SelectedValue);
			_PgNbr = 0;
			LoadCodeListGrid();
		}

		protected void gvCodeList_RowDataBound(object sender, GridViewRowEventArgs e)
		{
			GridViewRow row = e.Row;
			DataRowView dView = (DataRowView)e.Row.DataItem;

			if (row.RowType == DataControlRowType.DataRow)
			{
				Button btn = (Button)row.FindControl("btnChangeShownVal");
				if (dView["sShown"].ToString() == "Yes")
				{
					btn.Text = "Hide";
				}
				else
				{
					btn.Text = "Show";
				}
			}
		}

		protected void btnChangeShownVal_Click(object sender, EventArgs e)
		{
			//int Ridx = 
			//string sshown = gv		hfSelectedVal
		}
	}
}