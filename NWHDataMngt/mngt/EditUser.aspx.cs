using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using DataLayer;

namespace DataMngt.page
{
	public partial class EditUser : System.Web.UI.Page
	{
		#region Attributes
		CurrentUser _user = null;
		private CurrBrowser _Browser = null;
		private string _CBuildNbr = "";
		private bool _CanEdit = false;
		private bool _IsAdmin = false;
		private DataTable _dtRows;
		private int _NbrPages = 0;
		private int _NbrRows = 0;
		private int _PgNbr = 0;
		private int _PgSize = 20;
		private int _UserID = 0;
		private string _ErrMsg = string.Empty;
		#endregion

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
			this.lblErrorMsg.Text = "";
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
				Session["NoAccessMsg"] = "You do not have access to the check approval application";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}

			// check for specific rights to administer user rights
			if (_user.AccessRights < 5 && _user.CatToolRights < 5 && _user.EditCustomers < 5 && _user.EditLocations < 5 && _user.EditUsers < 5 && _user.EditVendors < 5)
			{
				Session["NoAccessMsg"] = "You do not have access to administrative areas.";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}

			_CBuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
			_UserID = Convert.ToInt32(_user.UserID);
			Page.MaintainScrollPositionOnPostBack = true;

			// Handle PostBack & Non-Postback actions
			if (!this.IsPostBack)
			{
				try
				{
					LoadLocationList();
					LoadUserListFilter();
					LoadUserPositionList();
					LoadUserGrid();
				}
				catch (Exception ex)
				{
					this.lblErrorMsg.Text = "Instantiation error: " + ex.Message;
				}
			}
			else
			{
				// do nothing now
			}
		}

		protected void LoadUserListFilter()
		{
			this.lblErrorMsg.Text = "";
			try
			{
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectUserList(0, "", "", "", "", "", "", 0, 1, 0, _UserID);
				this.ddlUserListF.DataTextField = "UserFullName";
				this.ddlUserListF.DataValueField = "UserID";
				this.ddlUserListF.DataSource = dt;
				this.ddlUserListF.DataBind();
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error in Loading User List for Filtering: " + ex.Message;
			}
		}

		protected void LoadLocationList()
		{
			try
			{
				Commands cmd = new Commands();
				DataTable dt = cmd.GetLocationList("", "", "", "", 0, 0, 1, _UserID);
				this.ddlLocationCodeE.DataTextField = "Name";
				this.ddlLocationCodeE.DataValueField = "loc";
				this.ddlLocationCodeE.DataSource = dt;
				this.ddlLocationCodeE.DataBind();

				this.ddlLocationCodeF.DataTextField = "Name";
				this.ddlLocationCodeF.DataValueField = "loc";
				this.ddlLocationCodeF.DataSource = dt;
				this.ddlLocationCodeF.DataBind();
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error in Loading locations: " + ex.Message;
			}
		}

		protected void LoadUserGrid()
		{
			this.lblErrorMsg.Text = "";
			try
			{
				string loc = this.ddlLocationCodeF.SelectedValue;
				string uname = this.txtUserNameF.Text;
				string pos = this.ddlPositionF.SelectedValue;
				int act = 2;
				if (this.chkActiveOnlyF.Checked == true) { act = 1; }
				string ctry = this.txtCountryCodeF.Text;
				string city = this.txtCityF.Text;

				Commands cmd = new Commands();
				DataTable dt = cmd.SelectUserList(0, uname, ctry, city, loc, pos, "", 0, act, 0, _UserID);
				this.gvUserList.DataSource = dt;
				this.gvUserList.DataBind();
				if (dt.Rows.Count == 0)
				{
					this.lblErrorMsg.Text = "No rows were found matching your criteria.";
				}
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error encountered during User List load: " + ex.Message;
			}
		}

		protected void LoadUserPositionList()
		{
			try
			{
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectUserPositionList("", 0, 1, _UserID);
				this.ddlPositionF.DataTextField = "";
				this.ddlPositionF.DataValueField = "";
				this.ddlPositionF.DataSource = dt;
				this.ddlPositionF.DataBind();
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error encountered when extracting position list: " + ex.Message;
			}
		}

		protected void gvUserList_RowDataBound(object sender, GridViewRowEventArgs e)
		{
			this.lblErrorMsg.Text = "";
			CheckBox chk;
			if (e.Row.RowType == DataControlRowType.DataRow)
			{
				try
				{
					GridViewRow r = e.Row;
					DataRowView drv = (DataRowView)r.DataItem;
					if (r.RowType == DataControlRowType.DataRow)
					{
						chk = (CheckBox)r.FindControl("chkUserActive");
						if (drv["sActive"].ToString() == "Yes")
						{
							chk.Checked = true;
						}
						else
						{
							chk.Checked = false;
						}
						chk = (CheckBox)r.FindControl("chkUserContractor");
						if (drv["sContractor"].ToString() == "Yes")
						{
							chk.Checked = true;
						}
						else
						{
							chk.Checked = false;
						}

					}
					//TextBox tb = (TextBox)r.FindControl("txtsBeginDate");
					//tb.Text = drv["sBeginDate"].ToString();
					//TextBox tb2 = (TextBox)r.FindControl("txtsEndDate");
					//tb2.Text = drv["sEndDate"].ToString();
				}
				catch (Exception ex)
				{
					this.lblErrorMsg.Text = "Error in binding row: " + ex.Message;
				}
			}
		}

		protected void gvUserList_RowEditing(object sender, GridViewEditEventArgs e)
		{
			// do nothing
		}

		protected void gvUserList_Sorting(object sender, GridViewSortEventArgs e)
		{
			try
			{
				DataTable dt = (DataTable)ViewState["DataSource"];
				if (dt != null)
				{
					DataView dataView = new DataView(dt);
					if ((string)ViewState["SortDir"] == "ASC" || String.IsNullOrEmpty((string)ViewState["SortDir"]))
					{
						dataView.Sort = e.SortExpression + " ASC";
						ViewState["SortDir"] = "DESC";
					}
					else if ((string)ViewState["SortDir"] == "DESC")
					{
						dataView.Sort = e.SortExpression + " DESC";
						ViewState["SortDir"] = "ASC";
					}

					gvUserList.DataSource = dataView;
					gvUserList.DataBind();
				}
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error encountered during sorting: " + ex.Message;
			}

		}

		protected void gvUserList_Sorted(object sender, EventArgs e)
		{
			// nothing?
		}

		protected void gvUserList_RowUpdated(object sender, GridViewUpdatedEventArgs e)
		{
			this.lblErrorMsg.Text = "";
			try
			{
				//e.AffectedRows

			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error in updating row: " + ex.Message;
			}
		}

		protected void gvUserList_RowCommand(object sender, GridViewCommandEventArgs e)
		{
			this.lblErrorMsg.Text = "";
			try
			{
				//Edit, Update, Delete
				string s = String.Empty;
				string cname = e.CommandName.ToString();
				int RowID = Convert.ToInt32(e.CommandArgument);
				GridViewRow r = gvUserList.Rows[RowID];
				DataRowView rv = (DataRowView)r.DataItem;
				DateTime BDate = DateTime.Now;
				string sBDate = BDate.ToString("MM/dd/yyyy");
				Commands cmd = new Commands();
				int TUserID = Convert.ToInt32(r.Cells[0].Text.ToString());
				DataTable dt = null;

				//Cells: 0-AppAreaU, 1-GroupUserID, 2-UserGroup, 3-FullUserName, 4-sRightLevel, 5-sBeginDate, 6-sEndDate, 7-btnEditRight/btnDelRight/btnEditUser, 8-UserLastName, 9-UserFirstName, 10-UserMiddleName
				//       11-EmailAddress, 12-EmpPosition, 13-RightLevel, 14-UserGroupCode, 15-UserGroupID, 16-UserLogin, 17-sActive, 18-sContractor, 19-UserID, 20-EmpID
				switch (cname)
				{
					case "Edit1":
						EmptyUserEditBlock();
						try
						{
							this.txtUserLoginE.Text = r.Cells[1].Text.ToString();
							this.lblUserIDE.Text = r.Cells[0].Text.ToString();
							this.txtNameLastE.Text = r.Cells[2].Text.ToString();
							this.txtNameFirstE.Text = r.Cells[3].Text.ToString();
							s = r.Cells[4].Text.ToString();
							s = s.Replace("&nbsp;", "");
							this.txtNameMiddleE.Text = s;
							this.txtEmailAddrE.Text = r.Cells[5].Text.ToString();
							this.txtPositionE.Text = r.Cells[6].Text.ToString();
							s = r.Cells[7].Text.ToString();
							this.txtEmpIDE.Text = "0";
							this.txtBeginDateN.Text = r.Cells[8].Text.ToString();
							s = r.Cells[9].Text.ToString();
							s = s.Replace("&nbsp;", "");
							this.txtEndDateN.Text = s;
							if (r.Cells[10].Text.ToString() == "Yes")
							{
								this.ddlIsActiveE.SelectedValue = "Yes";
							}
							else
							{
								this.ddlIsActiveE.SelectedValue = "No";
							}
							if (r.Cells[11].Text.ToString() == "Yes")
							{
								this.ddlIsContractorE.SelectedValue = "Yes";
							}
							else
							{
								this.ddlIsContractorE.SelectedValue = "No";
							}
							this.btnAddNewUser.Text = "Update";
							this.lblUserChngType.Text = "Update User Data below";
							this.divEditUserData.Style["display"] = "block";
							this.txtUserLoginE.Focus();
						}
						catch (HttpException hex)
						{
							this.lblErrorMsg.Text = hex.Message;
						}
						try
						{
							if (s != "" && s != "0")
							{
								this.ddlLocationCodeE.SelectedValue = r.Cells[7].Text.ToString();
							}
							else
							{
								this.ddlLocationCodeE.SelectedValue = "0";
							}
						}
						catch (Exception ex)
						{
							this.ddlLocationCodeE.SelectedValue = "0";
						}
						break;
					case "Del1":
						



						//dt = cmd.DeleteUser(TUserID, 1, _UserID);
						//if (dt == null)
						//{
						//	this.lblErrorMsg.Text = "Unknown error while attempting to delete user. The user was probably not removed.";
						//}
						//else
						//{
						//	if (dt.Rows.Count == 0)
						//	{
						//		this.lblErrorMsg.Text = "Unexpected result while attempting to delete user. The user was probably not removed.";
						//	}
						//	else
						//	{
						//		if (Convert.ToInt32(dt.Rows[0]["StatusID"]) != 0)
						//		{
						//			this.lblErrorMsg.Text = "Error encountered while attempting to delete user: " + dt.Rows[0]["StatusMsg"].ToString();
						//		}
						//	}
						//}
						break;
					case "Inact1":
						dt = cmd.DeleteUser(TUserID, 0, _UserID);
						if (dt == null)
						{
							this.lblErrorMsg.Text = "Unknown error while attempting to delete user. The user was probably not removed.";
						}
						else
						{
							if (dt.Rows.Count == 0)
							{
								this.lblErrorMsg.Text = "Unexpected result while attempting to delete user. The user was probably not removed.";
							}
							else
							{
								if (Convert.ToInt32(dt.Rows[0]["StatusID"]) != 0)
								{
									this.lblErrorMsg.Text = "Error encountered while attempting to delete user: " + dt.Rows[0]["StatusMsg"].ToString();
								}
							}
						}
						break;
					default:
						break;
				}
				// reload data
				LoadUserListFilter();
				LoadUserGrid();
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error opening user edit block: " + ex.Message;
			}
		}

		protected void EmptyUserEditBlock()
		{
			try
			{
				this.txtUserLoginE.Text = "";
				this.lblUserIDE.Text = "";
				this.txtNameLastE.Text = "";
				this.txtNameFirstE.Text = "";
				this.txtNameMiddleE.Text = "";
				this.txtEmailAddrE.Text = "";
				this.txtPositionE.Text = "";
				this.txtEmpIDE.Text = "";
				this.txtBeginDateN.Text = "";
				this.txtEndDateN.Text = "";
				this.ddlIsActiveE.SelectedValue = "Yes";
				this.ddlLocationCodeE.SelectedValue = "0";
				this.ddlIsContractorE.SelectedValue = "No";
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error emptying user edit block: " + ex.Message;
			}
		}

		protected void gvUserList_PageIndexChanged(object sender, EventArgs e)
		{
			// nothing
		}

		protected void gvUserList_PageIndexChanging(object sender, GridViewPageEventArgs e)
		{
			//GridView gv = (GridView)sender;
			//DataView dv = gv.DataSource as DataView;
			//DataTable dataTable = dv.Table;
			//gv.DataSource = myDataTable;
			//gv.PageIndex = e.NewPageIndex;
			//gv.DataBind();
			_PgNbr = e.NewPageIndex;
			gvUserList.PageIndex = e.NewPageIndex;
			LoadUserGrid();
		}

		protected void btnAddNewUser_Click(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			string s = String.Empty;
			try
			{
				DataTable dt;
				Commands cmd = new Commands();
				int UserID = Convert.ToInt32(this.lblUserIDE.Text);
				string Login = this.txtUserLoginE.Text;
				s = Login;
				string FName = this.txtNameFirstE.Text;
				s = FName;
				string LName = this.txtNameLastE.Text;
				s = LName;
				string MName = this.txtNameMiddleE.Text;
				s = MName;
				string EMail = this.txtEmailAddrE.Text;
				s = EMail;
				string Position = this.txtPositionE.Text;
				s = Position;
				int Contractor = Convert.ToInt32(this.ddlIsContractorE.SelectedValue);
				s = "C: " + Contractor.ToString();
				int Active = Convert.ToInt32(this.ddlIsActiveE.SelectedValue);
				s = "A: " + Contractor.ToString();
				int EmpID = 0;
				if (this.txtEmpIDE.Text != "") { EmpID = Convert.ToInt32(this.txtEmpIDE.Text); }
				string sBDate = this.txtBeginDateN.Text;
				string sEDate = this.txtEndDateN.Text;
				DateTime BDate = DateTime.Now;
				DateTime? EDate = null;
				DateTime TDate = DateTime.Now;
				s = sBDate;
				if (sBDate.Length > 0) { BDate = Convert.ToDateTime(sBDate); }
				s = sEDate;
				if (sEDate.Length > 0) { EDate = Convert.ToDateTime(sEDate); }
				string loc = this.ddlLocationCodeE.SelectedValue;
				dt = cmd.UpdateUserData(UserID, Login, FName, LName, MName, EmpID, EMail, Position, loc, Contractor, BDate, EDate, Active, _UserID);
				int NewUserID = Convert.ToInt32(dt.Rows[0][0]);
				if (NewUserID > 0)
				{
					LoadUserListFilter();
				}
				divEditUserData.Style["display"] = "none";
				LoadUserGrid();
			}
			catch (Exception ex)
			{
				string er = "Error adding/updating user data: ";
				if (!String.IsNullOrWhiteSpace(s)) { er = er + "(" + s + ")"; }
				er = er + ex.Message;
				this.lblErrorMsg.Text = er;
			}
		}

		protected void btnCloseArea2_Click(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			this.divEditUserData.Style["display"] = "none";
		}

		protected void btnClearArea2_Click(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			try
			{
				this.txtUserLoginE.Text = String.Empty;
				this.txtNameFirstE.Text = String.Empty;
				this.txtNameLastE.Text = String.Empty;
				this.txtNameMiddleE.Text = String.Empty;
				this.txtEmailAddrE.Text = String.Empty;
				this.txtPositionE.Text = String.Empty;
				this.lblUserIDE.Text = "0";
				this.ddlIsContractorE.SelectedValue = "0";
				this.ddlIsActiveE.SelectedValue = "1";
				this.txtEmpIDE.Text = "0";
				this.txtBeginDateN.Text = String.Empty;
				this.txtEndDateN.Text = String.Empty;
				this.txtBeginDateN.Text = String.Empty;
				this.txtEndDateN.Text = String.Empty;
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error Adding right: " + ex.Message;
			}
		}

		protected void btnOpenNewUser_Click(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			EmptyUserEditBlock();
			this.btnAddNewUser.Text = "Add User";
			this.lblUserChngType.Text = "Enter New User Data below";
			this.divEditUserData.Style["display"] = "block";
		}

		protected void btnRefreshDataGrid_Click(object sender, EventArgs e)
		{
			LoadUserGrid();
		}
	}
}