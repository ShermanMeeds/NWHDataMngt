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
  public partial class EditUserRights : System.Web.UI.Page
  {
    #region Attributes
    CurrentUser _user = null;
    private CurrBrowser _Browser = null;
    private string _CBuildNbr = "";
		private bool _CanEdit = false;
		private string _GrpCode1 = string.Empty;
		private string _GrpCode2 = string.Empty;
		private string _GrpCode3 = string.Empty;
		private string _GrpCode4 = string.Empty;
		private string _GrpCode5 = string.Empty;
		private string _GrpName1 = string.Empty;
		private string _GrpName2 = string.Empty;
		private string _GrpName3 = string.Empty;
		private string _GrpName4 = string.Empty;
		private string _GrpName5 = string.Empty;
		private bool _IsAdmin = false;
    private DataTable _dtRows;
		private int _MainView = 0;
    private int _NbrPages = 0;
    private int _NbrRows = 0;
    private int _PgNbr = 0;
		private int _PgNbr2 = 0;
    private int _PgSize = 20;
		private int _TargetUserID = 0;
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
					lblShowNoResults.Style["display"] = "none";
					lblRightsLevelNoRows.Style["display"] = "none"; 
					LoadUserListFilter();
          LoadUserGrid();
					LoadUserGroupList();
					LoadUserPositionList();
					LoadAppAreaLists();

					_PgNbr = 0;
					_PgNbr2 = 0;
					_PgSize = 20;
					_MainView = 0;
					_TargetUserID = 0;
					ViewState.Add("PgNbr", _PgNbr.ToString());
					ViewState.Add("PgNbr2", _PgNbr2.ToString());
					ViewState.Add("PgSize", _PgSize.ToString());
					ViewState.Add("MainView", _MainView.ToString());
					ViewState.Add("TargetUserID", _TargetUserID.ToString());
					ViewState.Add("GrpCode1", string.Empty);
					ViewState.Add("GrpCode2", string.Empty);
					ViewState.Add("GrpCode3", string.Empty);
					ViewState.Add("GrpCode4", string.Empty);
					ViewState.Add("GrpCode5", string.Empty);
					ViewState.Add("GrpName1", string.Empty);
					ViewState.Add("GrpName2", string.Empty);
					ViewState.Add("GrpName3", string.Empty);
					ViewState.Add("GrpName4", string.Empty);
					ViewState.Add("GrpName5", string.Empty);
				}
				catch (Exception ex)
        {
          this.lblErrorMsg.Text = "Instantiation error: " + ex.Message;
        }
      }
      else
      {
				_PgNbr = Convert.ToInt32(ViewState["PgNbr"]);
				_PgNbr2 = Convert.ToInt32(ViewState["PgNbr2"]);
				_PgSize = Convert.ToInt32(ViewState["PgSize"]);
				_MainView = Convert.ToInt32(ViewState["MainView"]);
				_TargetUserID = Convert.ToInt32(ViewState["TargetUserID"]);
				_GrpCode1 = ViewState["GrpCode1"].ToString();
				_GrpCode2 = ViewState["GrpCode2"].ToString();
				_GrpCode3 = ViewState["GrpCode3"].ToString();
				_GrpCode4 = ViewState["GrpCode4"].ToString();
				_GrpCode5 = ViewState["GrpCode5"].ToString();
				_GrpName1 = ViewState["GrpName1"].ToString();
				_GrpName2 = ViewState["GrpName2"].ToString();
				_GrpName3 = ViewState["GrpName3"].ToString();
				_GrpName4 = ViewState["GrpName4"].ToString();
				_GrpName5 = ViewState["GrpName5"].ToString();
			}
		}

		protected void ClearDropDownList(DropDownList ddl, int KeepFirst)
		{
			ListItem first = new ListItem();
			bool HasFirst = false;
			if (ddl.Items.Count > 0)
			{
				first = ddl.Items[0];
				HasFirst = true;
			}
			ddl.Items.Clear();
			if (HasFirst == true) { ddl.Items.Add(first); }
		}

		protected void ClearListBox(ListBox lb, int KeepFirst)
		{
			ListItem first = new ListItem();
			bool HasFirst = false;
			if (lb.Items.Count > 0)
			{
				first = lb.Items[0];
				HasFirst = true;
			}
			lb.Items.Clear();
			if (HasFirst == true) { lb.Items.Add(first); }
		}

		protected void LoadAppAreaLists()
		{
			try
			{
				GenManage gm = new GenManage();
				DataTable dt = gm.SelectAppAreaList(0, "DataMngt", "", 0, 1, _UserID);
				this.ddlAppAreaMasterList.DataTextField = "AppAreaName";
				this.ddlAppAreaMasterList.DataValueField = "AppAreaCode";
				this.ddlAppAreaMasterList.DataSource = dt;
				this.ddlAppAreaMasterList.DataBind();

				this.ddlAppAreaNU.DataTextField = "AppAreaName";
				this.ddlAppAreaNU.DataValueField = "AppAreaCode";
				this.ddlAppAreaNU.DataSource = dt;
				this.ddlAppAreaNU.DataBind();

				this.ddlAppAreaGE.DataTextField = "AppAreaName";
				this.ddlAppAreaGE.DataValueField = "AppAreaCode";
				this.ddlAppAreaGE.DataSource = dt;
				this.ddlAppAreaGE.DataBind();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error filling app area list: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void LoadUserList() 
    {
      this.lblErrorMsg.Text = "";
      try 
      {
        Commands cmd = new Commands();
        DataTable dt = cmd.SelectUserList(0, "", "", "", "", "", "", 0, 1, 0, _UserID);
        this.ddlUserList.DataTextField = "UserFullName";
        this.ddlUserList.DataValueField = "UserID";
        this.ddlUserList.DataSource = dt;
        this.ddlUserList.DataBind();
      }
      catch (Exception ex) {
          this.lblErrorMsg.Text = "Error in Loading User List: " + ex.Message;
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

    protected void LoadUserGrid()
    {
      this.lblErrorMsg.Text = "";
      try
      {
				string nm = string.Empty;
				string pos = ddlUserPositionF.SelectedValue;
				if (pos == "0") { pos = ""; }
				string grp = ddlRightsGroupF.SelectedValue;
				if (grp == "0") { grp = ""; }
				if (ddlUserListF.SelectedValue != "0")
				{
					nm = ddlUserListF.SelectedItem.Text;
					if (nm != "")
					{
						if (nm.IndexOf(",") > 0) { nm = nm.Substring(0, nm.IndexOf(",")); }
					}
				}
				else
				{
					nm = txtLastNameF.Text;
				}
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectUserList(0, nm, "", "", "", pos, grp, 0, 2, 1, _UserID);
        this.gvUserList.DataSource = dt;
        this.gvUserList.DataBind();
				this.gvUserList.PageIndex = _PgNbr;

				this.ddlUserList.DataTextField = "UserFullName";
				this.ddlUserList.DataValueField = "UserID";
				this.ddlUserList.DataSource = dt;
				this.ddlUserList.DataBind();

			}
      catch (Exception ex)
      {
        this.lblErrorMsg.Text = "Error loading user list: " + ex.Message;
      }
    }

		protected void LoadUserGroupList()
		{
			try
			{
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectUserGroupList(0, "", 0, 1, _UserID);
				// load master list
				ddlEditUserGroupMaster.DataTextField = "UserGroup";
				ddlEditUserGroupMaster.DataValueField = "UserGroupCode";
				ddlEditUserGroupMaster.DataSource = dt;
				ddlEditUserGroupMaster.DataBind();
				// load edit rights group list
				ddlRightsGroupF.DataTextField = "UserGroup";
				ddlRightsGroupF.DataValueField = "UserGroupCode";
				ddlRightsGroupF.DataSource = dt;
				ddlRightsGroupF.DataBind();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in loading group filter: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void LoadUserGroupMembers()
		{
			try
			{
				string grp = this.ddlRightsGroupF.SelectedValue;

				Commands cmd = new Commands();
				DataTable dt = cmd.SelectUserGroupMembers(grp, 0, 2, _UserID);
				gvUserGroupMembers.DataSource = dt;
				gvUserGroupMembers.DataBind();
				if (dt.Rows.Count == 0)
				{
					this._ErrMsg = "No members were found.";
					this.lblErrorMsg.Text = this._ErrMsg;
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in loading group members: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void LoadUserGroupNonMembers()
		{
			try
			{
				string grp = this.ddlRightsGroupF.SelectedValue;
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectUserGroupNonMembers(grp, 0, 1, _UserID);
				this.ddlGrpNonMembers.DataTextField = "sFullName";
				this.ddlGrpNonMembers.DataValueField = "UserID";
				this.ddlGrpNonMembers.DataSource = dt;
				this.ddlGrpNonMembers.DataBind();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in loading group non-members: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void LoadUserPositionList()
		{
			try
			{
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectUserPositionList("", 0, 1, _UserID);
				ddlUserPositionF.DataTextField = "EmpPosition";
				ddlUserPositionF.DataValueField = "EmpPosition";
				ddlUserPositionF.DataSource = dt;
				ddlUserPositionF.DataBind();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in loading position filter: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void LoadForecastLocations()
		{
			try
			{
				int uid = Convert.ToInt32(ddlUserList.SelectedValue);
				Forecast fc = new Forecast();
				string grp = this.ddlForecastLocGroup.SelectedValue;
				// Load data grid with existing locations
				DataTable dt = fc.SelectUserForecastLocList2(0, grp, uid);
				gvForecastLocations.DataSource = dt;
				gvForecastLocations.DataBind();
				if (dt.Rows.Count == 0)
				{
					lblShowNoResults.Style["display"] = "inline";
					gvForecastLocations.Style["display"] = "none";
				}
				else
				{
					gvForecastLocations.Style["display"] = "inline";
					lblShowNoResults.Style["display"] = "none";
				}
				this.ddlFCLocation.SelectedValue = "0";
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error loading forecast locations: " + ex.Message;
			}
		}

		protected void LoadFCLocationList()
		{
			try
			{
				string grp = this.ddlForecastLocGroup.SelectedValue;
				Forecast fc = new Forecast();
				DataTable dt = fc.SelectUserForecastLocList2(1, grp, _UserID);
				ClearDropDownList(ddlFCLocation, 0);
				ddlFCLocation.DataTextField = "GenericName";
				ddlFCLocation.DataValueField = "LocationCode";
				ddlFCLocation.DataSource = dt;
				ddlFCLocation.DataBind();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error filling Forecast Location list: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void LoadUserRightsList()
		{
			try
			{
				int uid = Convert.ToInt32(ddlUserList.SelectedValue);
				// Load existing person rights
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectUserGroupData("", uid, 0, 1);
				gvExistingRights.DataSource = dt;
				gvExistingRights.DataBind();
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error loading user rights: " + ex.Message;
			}
		}

		protected void DeleteUserRight()
    {
      this.lblErrorMsg.Text = "";
      try
      {
        DataTable dt;  
        Commands cmd = new Commands();
        DateTime BDate = DateTime.Now;
        int GroupUserID = Convert.ToInt32(this.lblUserIDRE.Text);
        if (GroupUserID > 0) {
           dt = cmd.UpdateUserRight(GroupUserID, 0, "", 3, "", 0, BDate, null, 1, _UserID);
        }
        LoadUserGrid();
      }
      catch (Exception ex) {
        this.lblErrorMsg.Text = "Error deleting user right: " + ex.Message;
      }
    }

    protected void btnAddNewUserRight_Click(object sender, EventArgs e)
    {
      this.lblErrorMsg.Text = "";
      try
      {
        LoadUserList();

        DataTable dt;  
        Commands cmd = new Commands();
        // Get set values
        int Type = 0;
				int GroupUserID = 0; // Convert.ToInt32(this.lblUserIDRE.Text);
				int UserID = Convert.ToInt32(this.lblUserIDRE.Text); // Convert.ToInt32(this.ddlUserList.SelectedValue);
        string AppArea = this.ddlAppAreaNU.SelectedValue;
        int RightsLevel = Convert.ToInt32(this.ddlRightsLevelNU.SelectedValue);
        if (GroupUserID == 0) {
          Type = 0;
        }
        else {
          Type = 1;
        }
        DateTime BDate = DateTime.Now;
        DateTime? EDate = null;
        DateTime TDate = DateTime.Now;
        //^(0?[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d$
        //DateTime.TryParseExact(this.txtBeginDateRE.Text, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out BDate);
        //f (DateTime.TryParse(this.txtEndDateRE.Text, out TDate)) {
        //  EDate = Convert.ToDateTime(this.txtEndDateRE.Text);
        //}
        
        // update right        
        dt = cmd.UpdateUserRight(GroupUserID, UserID, "", Type, AppArea, RightsLevel, BDate, EDate, 1, _UserID);
				LoadUserGroupList();
				LoadUserRightsList();
				LoadUserGrid();
				this.ddlFCLocation.SelectedValue = "0";
			}
			catch (Exception ex) {
        this.lblErrorMsg.Text = "Error adding/updating user right: " + ex.Message;
      }
    }

    protected void btnOpenNewUserRight_Click(object sender, EventArgs e)
    {
      this.lblErrorMsg.Text = "";
     // this.txtBeginDateRE.Text = DateTime.Now.ToString("mm/dd/yyyy");
     // this.txtEndDateRE.Text = "";
      this.ddlUserList.SelectedValue = "0";
      //this.ddlIsActiveE.SelectedValue = "1";
      //this.ddlIsContractorE.SelectedValue = "0";
      this.ddlAppAreaNU.SelectedValue = "0";
      this.ddlRightsLevelNU.SelectedValue = "0";
      this.divEditUserRightData.Style["display"] = "block";
      this.ddlUserList.Focus();
    }

    protected void btnCloseArea1_Click(object sender, EventArgs e)
    {
      this.lblErrorMsg.Text = "";
      this.divEditUserRightData.Style["display"] = "none";
			this.ddlFCLocation.SelectedValue = "0";
    }

    protected void gvUserList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
      this.lblErrorMsg.Text = "";
      if (e.Row.RowType == DataControlRowType.DataRow)
      {
        try
        {
          GridViewRow r = e.Row;
          DataRowView drv = (DataRowView)r.DataItem;
          if (r.RowType == DataControlRowType.DataRow)
          {
            DropDownList ddl = (DropDownList)r.FindControl("ddlRightsLevel");
            ddl.SelectedValue = drv["RightLevel"].ToString();
          }
          TextBox tb = (TextBox)r.FindControl("txtsBeginDate");
          tb.Text = drv["sBeginDate"].ToString();
          TextBox tb2 = (TextBox)r.FindControl("txtsEndDate");
          tb2.Text = drv["sEndDate"].ToString();
        }
        catch (Exception ex)
        {
          this.lblErrorMsg.Text = "Error in binding row: " + ex.Message;
        }
      }
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

    protected void ddlRightsLevel_SelectedIndexChanged(object sender, EventArgs e)
    {
      string a = "";
      //try
      //{
      //  GridViewRow rw = gvUserList.SelectedRow;
      //  DropDownList ddl = rw.FindControl("ddlRightsLevel");



      //}
      //catch (Exception ex)
      //{
      //  this.lblErrorMsg.Text = "Error in changing right: " + ex.Message;
      //}
    }

    protected void gvUserList_RowCommand(object sender, GridViewCommandEventArgs e)
    {
      this.lblErrorMsg.Text = "";
      try
      {
        //Edit, Update, Delete, User
        string s = String.Empty;
        HiddenField hf;
        string cname = e.CommandName.ToString();
        int RowID = Convert.ToInt32(e.CommandArgument);
				RowID = RowID - (_PgNbr * _PgSize);
        GridViewRow r = gvUserList.Rows[RowID];
        DataRowView rv = (DataRowView)r.DataItem;
        DateTime BDate = DateTime.Now;
        string sBDate = BDate.ToString("MM/dd/yyyy");
				hf = (HiddenField)r.FindControl("hfUserID");
				_TargetUserID = Convert.ToInt32(hf.Value); ;
				ViewState["TargetUserID"] = _TargetUserID.ToString();

				//Cells: 0-AppAreaU, 1-GroupUserID, 2-UserGroup, 3-FullUserName, 4-sRightLevel, 5-sBeginDate, 6-sEndDate, 7-btnEditRight/btnDelRight/btnEditUser, 8-UserLastName, 9-UserFirstName, 10-UserMiddleName
				//       11-EmailAddress, 12-EmpPosition, 13-RightLevel, 14-UserGroupCode, 15-UserGroupID, 16-UserLogin, 17-sActive, 18-sContractor, 19-UserID, 20-EmpID
				switch (cname)
        {
          case "Edit1":
            try
            {
              //this.txtBeginDateRE.Text = r.Cells[6].Text; // sBeginDate
              this.divEditUserRightData.Style["display"] = "block";
              //this.txtEndDateRE.Text = "";
              s = r.Cells[7].Text;
              if (s.Trim() == "&nbsp;") { s = ""; }
              //this.txtEndDateRE.Text = s;
              this.ddlUserList.SelectedValue = hf.Value;
							this.lblUserIDRE.Text = hf.Value;
							//this.ddlAppAreaNU.SelectedValue = r.Cells[0].Text;
							this.ddlUserList.Focus();

							// Load existing person rights
							Commands cmd = new Commands();
							DataTable dt = cmd.SelectUserGroupData("", _TargetUserID, 0, 1);
							gvExistingRights.DataSource = dt;
							gvExistingRights.DataBind();
							if (dt.Rows.Count == 0)
							{
								lblRightsLevelNoRows.Style["display"] = "inline";
								gvExistingRights.Style["display"] = "none";
							}
							else
							{
								lblRightsLevelNoRows.Style["display"] = "none";
								gvExistingRights.Style["display"] = "inline";
							}

							LoadUserGroupList();
							LoadForecastLocations();
							LoadFCLocationList();
						}
            catch (HttpException hex)
            {
              this.lblErrorMsg.Text = hex.Message;
            }
            break;
          //case "Delete1":
            //UpdateUserRight(3, UserID, 0, "", "", 0, sBDate, "", 1);
            //break;
          default:
            break;
        }
        // reload data
        LoadUserListFilter();
        LoadUserGrid();
      }
      catch (Exception ex)
      {
				this._ErrMsg = "Error Adding right: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
      }
    }

    protected void UpdateUserRight(int Type, int GroupUserID, int UserID, string GroupCode, string AppArea, int RightLevel, string sBDate, string sEDate, int Active)
    {
      this.lblErrorMsg.Text = "";
      try {
        DataTable dt;  
        Commands cmd = new Commands();
        DateTime BDate = DateTime.Now;
        DateTime TDate = DateTime.Now;
        DateTime? EDate = null;
        DateTime.TryParseExact(sBDate, "MM/dd/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out BDate);
        if (DateTime.TryParse(sEDate, out TDate)) {
          EDate = Convert.ToDateTime(sEDate);
        }

        dt = cmd.UpdateUserRight(GroupUserID, UserID, GroupCode, Type, AppArea, RightLevel, BDate, EDate, Active, _UserID);
      }
      catch (Exception ex) {
        this.lblErrorMsg.Text = "Error Adding right: " + ex.Message;
      }
    }

    protected void gvUserList_RowEditing(object sender, GridViewEditEventArgs e)
    {
      // do nothing
    }

		protected void gvUserList_PageIndexChanged(object sender, EventArgs e)
		{
			// nothing
		}

		protected void gvUserList_PageIndexChanging(object sender, GridViewPageEventArgs e)
		{
			_PgNbr = e.NewPageIndex;
			ViewState["PgNbr"] = _PgNbr.ToString();
			gvUserList.PageIndex = e.NewPageIndex;
			LoadUserGrid();
		}

		protected void gvUserList_Sorting(object sender, GridViewSortEventArgs e)
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

		protected void gvUserList_Sorted(object sender, EventArgs e)
		{
			// nothing
		}

		protected void btnDeleteLoc_Click(object sender, EventArgs e)
		{
			try {
				Commands cmd = new Commands();
				Button btn = (Button)sender;
				GridViewRow gvRow = (GridViewRow)btn.Parent.Parent.Parent.Parent;
				int idx = gvRow.RowIndex;
				HiddenField hf = (HiddenField)gvRow.FindControl("hfLocCode");
				string loc = hf.Value;
				int userid = Convert.ToInt32(ddlUserList.SelectedValue);
				hf = (HiddenField)gvRow.FindControl("hfGrpCode");
				string gcode = hf.Value;				
				DataTable dt = cmd.DeleteExistingRightsLocation(userid, gcode, loc, _UserID);
				LoadForecastLocations();
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error removing forecast location: " + ex.Message;
			}
		}

		protected void gvForecastLocations_RowCommand(object sender, GridViewCommandEventArgs e)
		{
			this.lblErrorMsg.Text = "";
			try
			{
				string loc = String.Empty;
				HiddenField hf;
				string cname = e.CommandName.ToString();
				int RowID = Convert.ToInt32(e.CommandArgument);
				GridViewRow r = gvForecastLocations.Rows[RowID];
				DataRowView rv = (DataRowView)r.DataItem;
				int uid = Convert.ToInt32(ddlUserList.SelectedValue);
				switch (cname)
				{
					case "del":
						hf = (HiddenField)r.FindControl("hfLocCode");
						loc = hf.Value;
						int userid = Convert.ToInt32(ddlUserList.SelectedValue);
						hf = (HiddenField)r.FindControl("hfGrpCode");
						string gcode = hf.Value;
						Commands cmd = new Commands();
						DataTable dt = cmd.DeleteExistingRightsLocation(userid, gcode, loc, _UserID);
						LoadForecastLocations();
						break;
					default:
						break;
				}
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error handling forecast locations command: " + ex.Message;
			}
		}

		protected void ddlFCLocation_TextChanged(object sender, EventArgs e)
		{
			try
			{
				string loc = ddlFCLocation.SelectedValue;
				if (loc != "0")
				{
					int uid = Convert.ToInt32(ddlUserList.SelectedValue);
					string grp = this.ddlForecastLocGroup.SelectedValue;
					Forecast fc = new Forecast();
					DataTable dt = fc.UpdateForecastLocation(loc, uid, grp, _UserID);
					LoadForecastLocations();
					LoadFCLocationList();
					LoadUserGrid();
				}
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error adding forecast location: " + ex.Message;
			}
		}

		protected void ddlUserList_TextChanged(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			try
			{
				this.lblUserIDRE.Text = ddlUserList.SelectedValue;

				_TargetUserID = Convert.ToInt32(this.lblUserIDRE.Text); ;
				ViewState["TargetUserID"] = _TargetUserID.ToString();
				LoadUserGroupList();
				LoadForecastLocations();
				LoadFCLocationList();
				LoadUserRightsList();
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error getting user rights: " + ex.Message;
			}
		}

		protected void gvExistingRights_RowDataBound(object sender, GridViewRowEventArgs e)
		{
			this.lblErrorMsg.Text = "";
			try
			{
				DropDownList ddl;
				GridViewRow r = e.Row;
				if (r.RowType == DataControlRowType.DataRow)
				{
					DataRowView drv = (DataRowView)r.DataItem;
					ddl = (DropDownList)e.Row.FindControl("ddlRightsLevel");
					ddl.SelectedValue = drv["RightLevel"].ToString();
				}
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error binding row: " + ex.Message;
			}
		}

		protected void gvExistingRights_RowCommand(object sender, GridViewCommandEventArgs e)
		{
			this.lblErrorMsg.Text = "";
			try
			{
				//Edit, Update, Delete, User
				string s = String.Empty;
				HiddenField hf;
				string cname = e.CommandName.ToString();
				int RowID = Convert.ToInt32(e.CommandArgument);
				GridViewRow r = gvExistingRights.Rows[RowID];
				DataRowView rv = (DataRowView)r.DataItem;
				DateTime BDate = DateTime.Now;
				string sBDate = BDate.ToString("MM/dd/yyyy");
				hf = (HiddenField)r.FindControl("hfUserGroupCode");
				string ugrpCode = hf.Value;
				int UserID = Convert.ToInt32(this.ddlUserList.SelectedValue);

				switch (cname)
				{
					case "Remove":
						Commands cmd = new Commands();
						DataTable dt = cmd.DeleteExistingRight(UserID, ugrpCode, _UserID);
						LoadUserRightsList();
						break;
					default:
						break;
				}
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error removing rights row: " + ex.Message;
			}
		}

		protected void ddlRightsLevel_TextChanged(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			try
			{
				int uid = Convert.ToInt32(ddlUserList.SelectedValue);
				DropDownList ddl = (DropDownList)sender;
				string sid = ddl.ID;
				int rlevel = Convert.ToInt32(ddl.SelectedValue);
				GridViewRow gvRow = (GridViewRow)ddl.Parent.Parent.Parent.Parent;
				int idx = gvRow.RowIndex;
				HiddenField hf = (HiddenField)gvRow.FindControl("hfUserGroupCode");
				string gcode = hf.Value;
				Commands cmd = new Commands();
				DataTable dt = cmd.UpdateUserRightLevel(0, uid, gcode, rlevel, 0, _UserID);
				if (dt.Rows.Count == 0)
				{
					this._ErrMsg = "Unknown error changing user rights.";
					this.lblErrorMsg.Text = this._ErrMsg;
				}
				else
				{
					if (dt.Rows[0]["StatusMsg"].ToString() != "")
					{
						this._ErrMsg = dt.Rows[0]["StatusMsg"].ToString();
						this.lblErrorMsg.Text = this._ErrMsg;
					}
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error loading user rights: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void ddlRightsGroupF_TextChanged(object sender, EventArgs e)
		{
			if (_MainView == 0)
			{
				LoadUserGrid();
			}
			else
			{
				LoadUserGroupMembers();
			}
		}

		protected void ddlUserPositionF_TextChanged(object sender, EventArgs e)
		{
			LoadUserGrid();
		}

		protected void txtLastNameF_TextChanged(object sender, EventArgs e)
		{
			LoadUserGrid();
		}

		protected void ddlUserListF_TextChanged(object sender, EventArgs e)
		{
			LoadUserGrid();
		}

		protected void ddlMainView_SelectedIndexChanged(object sender, EventArgs e)
		{
		}

		protected void gvUserGroupMembers_PageIndexChanging(object sender, GridViewPageEventArgs e)
		{
			_PgNbr2 = e.NewPageIndex;
			ViewState["PgNbr2"] = _PgNbr2.ToString();
			gvUserGroupMembers.PageIndex = e.NewPageIndex;
			LoadUserGroupMembers();
		}

		protected void gvUserGroupMembers_PageIndexChanged(object sender, EventArgs e)
		{
			// nothing
		}

		protected void gvUserGroupMembers_RowCommand(object sender, GridViewCommandEventArgs e)
		{
			try
			{
				string grp = this.ddlRightsGroupF.SelectedValue;
				//Edit, Update, Delete, User
				string s = String.Empty;
				HiddenField hf;
				string cname = e.CommandName.ToString();
				int RowID = Convert.ToInt32(e.CommandArgument);
				GridViewRow r = gvUserGroupMembers.Rows[RowID];
				DataRowView rv = (DataRowView)r.DataItem;
				hf = (HiddenField)r.FindControl("hfUserID");
				int UserID = Convert.ToInt32(hf.Value);

				switch (cname)
				{
					case "Del":
						Commands cmd = new Commands();
						DataTable dt = cmd.DeleteExistingRight(UserID, grp, _UserID);
						LoadUserGroupMembers();
						LoadUserGroupNonMembers();
						break;
					default:
						break;
				}
			}
			catch (Exception ex)
			{
				_ErrMsg = "Error while handling row action: " + ex.Message;
				this.lblErrorMsg.Text = _ErrMsg;
			}
		}

		protected void gvUserGroupMembers_Sorting(object sender, GridViewSortEventArgs e)
		{
			// nothing
		}

		protected void gvUserGroupMembers_Sorted(object sender, EventArgs e)
		{
			// nothing
		}

		protected void ddlMainView_SelectedIndexChanged1(object sender, EventArgs e)
		{
			try
			{
				int itm = Convert.ToInt32(ddlMainView.SelectedValue);
				_MainView = itm;
				ViewState["MainView"] = _MainView.ToString();
				switch (itm)
				{
					case 0:
						this.divUserListGrid.Style["display"] = "block";
						this.divUserGroupMembers.Style["display"] = "none";
						LoadUserGrid();
						break;
					case 1:
						this.divUserListGrid.Style["display"] = "none";
						this.divUserGroupMembers.Style["display"] = "block";
						LoadUserGroupMembers();
						LoadUserGroupNonMembers();
						break;
					default:
						break;
				}
			}
			catch (Exception ex)
			{
				_ErrMsg = "Error changing view: " + ex.Message;
				this.lblErrorMsg.Text = _ErrMsg;
			}
		}

		protected void btnAddNewPerson_Click(object sender, EventArgs e)
		{
			try
			{
				int userid = Convert.ToInt32(this.ddlGrpNonMembers.SelectedValue);
				string grp = this.ddlRightsGroupF.SelectedValue;
				Commands cmd = new Commands();
				DataTable dt = cmd.UpdateUserRight(0, userid, grp, 0, "", 0, null, null, 1, _UserID);
				LoadUserGroupMembers();
				LoadUserGroupNonMembers();
			}
			catch (Exception ex)
			{
				_ErrMsg = "Error when attempting to add new person to group membership: " + ex.Message;
				this.lblErrorMsg.Text = _ErrMsg;
			}
		}

		protected void ddlForecastLocGroup_TextChanged(object sender, EventArgs e)
		{
			this.ddlFCLocation.SelectedValue = "0";
			LoadFCLocationList();
			LoadForecastLocations();
		}

		protected void btnMakeNewUserGroup_Click(object sender, EventArgs e)
		{
			try
			{
				this.ddlAppAreaGE.SelectedValue = "0";
				this.ddlRightsLevelGE.SelectedValue = "0";
				this.txtGrpCodeE.Text = "";
				this.txtGrpNameE.Text = "";
				this.lblUserGrpIDE.Text = "0";
				this.hfAppAreaID.Value = "0";
				this.chkGroupCodeActive.Checked = true;
				this.lblNbrUsersInGroup.Text = "0";
				this.divEditUserGroup.Style["display"] = "block";
			}
			catch (Exception ex)
			{
				_ErrMsg = "Error when opening group edit block: " + ex.Message;
				this.lblErrorMsg.Text = _ErrMsg;
			}
		}

		protected void btnSaveUserGrp_Click(object sender, EventArgs e)
		{
			try
			{
				string code = this.txtGrpCodeE.Text;
				string AppArea = this.ddlAppAreaGE.SelectedValue;
				int rights = Convert.ToInt32(this.ddlRightsLevelGE.SelectedValue);
				string grpname = this.txtGrpNameE.Text;
				int id = Convert.ToInt32(this.lblUserGrpIDE.Text);
				int id2 = Convert.ToInt32(this.hfAppAreaID.Value);
				int act = 1;
				if (chkGroupCodeActive.Checked == false) { act = 0; }
				// Save user Group and get ID if necessary
				GenManage gm = new GenManage();
				DataTable dt = gm.UpdateUserGroup(id, code, AppArea, "", 0, 0, act, _UserID);
				// Update App Area involved																																											
				dt = gm.UpdateAppAreaRight(id2, "DataMngt", AppArea, code, rights, 1, 1, _UserID);
				this.divEditUserGroup.Style["display"] = "none";
			}
			catch (Exception ex)
			{
				_ErrMsg = "Error when trying to save group data: " + ex.Message;
				this.lblErrorMsg.Text = _ErrMsg;
			}
		}

		protected void btnMakeNewAppArea_Click(object sender, EventArgs e)
		{
			try
			{
				_GrpCode1 = "";
				ViewState["GrpCode1"] = string.Empty;
				_GrpCode2 = "";
				ViewState["GrpCode2"] = string.Empty;
				_GrpCode3 = "";
				ViewState["GrpCode3"] = string.Empty;
				_GrpCode4 = "";
				ViewState["GrpCode4"] = string.Empty;
				_GrpCode5 = "";
				ViewState["GrpCode5"] = string.Empty;
				_GrpName1 = "";
				ViewState["GrpName1"] = string.Empty;
				_GrpName2 = "";
				ViewState["GrpName2"] = string.Empty;
				_GrpName3 = "";
				ViewState["GrpName3"] = string.Empty;
				_GrpName4 = "";
				ViewState["GrpName4"] = string.Empty;
				_GrpName5 = "";
				ViewState["GrpName5"] = string.Empty;
				this.txtAppAreaCodeE.Text = "";
				this.txtAppAreaRights1.Text = "";
				this.txtAppAreaRights2.Text = "";
				this.txtAppAreaRights3.Text = "";
				this.txtAppAreaRights4.Text = "";
				this.txtAppAreaRights5.Text = "";
				this.txtAppAreaRName1.Text = "";
				this.txtAppAreaRName2.Text = "";
				this.txtAppAreaRName3.Text = "";
				this.txtAppAreaRName4.Text = "";
				this.txtAppAreaRName5.Text = "";
				this.hfAppAreaRightsID1.Value = "0";
				this.hfAppAreaRightsID2.Value = "0";
				this.hfAppAreaRightsID3.Value = "0";
				this.hfAppAreaRightsID4.Value = "0";
				this.hfAppAreaRightsID5.Value = "0";
				this.txtAppAreaNameE.Text = "";
				this.lblAppAreaIDE.Text = "0";
				this.chkAppAreaActiveE.Checked = true;
				this.divEditAppArea.Style["display"] = "block";
			}
			catch (Exception ex)
			{
				_ErrMsg = "Error when trying to open app area edit: " + ex.Message;
				this.lblErrorMsg.Text = _ErrMsg;
			}
		}

		protected void btnSaveAppAreaData_Click(object sender, EventArgs e)
		{
			try
			{
				string aar1 =	this.txtAppAreaRights1.Text;
				string aar2 = this.txtAppAreaRights2.Text;
				string aar3 = this.txtAppAreaRights3.Text;
				string aar4 = this.txtAppAreaRights4.Text;
				string aar5 = this.txtAppAreaRights5.Text;
				int id1 = Convert.ToInt32(this.hfAppAreaRightsID1.Value);
				int id2 = Convert.ToInt32(this.hfAppAreaRightsID2.Value);
				int id3 = Convert.ToInt32(this.hfAppAreaRightsID3.Value);
				int id4 = Convert.ToInt32(this.hfAppAreaRightsID4.Value);
				int id5 = Convert.ToInt32(this.hfAppAreaRightsID5.Value);
				string aname1 = this.txtAppAreaRName1.Text;
				string aname2 = this.txtAppAreaRName2.Text;
				string aname3 = this.txtAppAreaRName3.Text;
				string aname4 = this.txtAppAreaRName4.Text;
				string aname5 = this.txtAppAreaRName5.Text;
				string apparea = this.txtAppAreaNameE.Text;
				string areacode = this.txtAppAreaCodeE.Text;
				int id= Convert.ToInt32(this.lblAppAreaIDE.Text);
				int act = 0;
				if (chkAppAreaActiveE.Checked == true) { act = 1; }
				// save app area data
				GenManage gm = new GenManage();
				DataTable dt;
				dt = gm.UpdateAppArea(id, "DataMngt", areacode, apparea, act, _UserID);
				// save app area security levels
				if ((_GrpCode1 != aar1 || _GrpName1 != aname1) && aar1 != "") {
					dt = gm.UpdateUserGroup(id1, aar1, aname1, areacode, 1, 1, act, _UserID);
				}
				if ((_GrpCode2 != aar2 || _GrpName2 != aname2) && aar2 != "") {
					dt = gm.UpdateUserGroup(id2, aar2, aname2, areacode, 2, 1, act, _UserID);
				}
				if ((_GrpCode3 != aar3 || _GrpName3 != aname3) && aar3 != "") {
					dt = gm.UpdateUserGroup(id3, aar3, aname3, areacode, 3, 1, act, _UserID);
				}
				if ((_GrpCode4 != aar4 || _GrpName4 != aname4) && aar4 != "") {
					dt = gm.UpdateUserGroup(id4, aar4, aname4, areacode, 4, 1, act, _UserID);
				}
				if ((_GrpCode5 != aar5 || _GrpName5 != aname5) && aar5 != "") {
					dt = gm.UpdateUserGroup(id5, aar5, aname5, areacode, 5, 1, act, _UserID);
				}
				this.lblAppAreaEditStatus.Text = "All data has been properly saved.";
			}
			catch (Exception ex)
			{
				_ErrMsg = "Error when trying to save group data: " + ex.Message;
				this.lblErrorMsg.Text = _ErrMsg;
			}
		}

		protected void btnCloseThisArea3_Click(object sender, EventArgs e)
		{
			this.divEditAppArea.Style["display"] = "none";
		}

		protected void btnCloseThisArea2_Click(object sender, EventArgs e)
		{
			this.divEditUserGroup.Style["display"] = "none";
		}

		protected void ddlAppAreaMasterList_SelectedIndexChanged(object sender, EventArgs e)
		{
			try
			{
				string code = this.ddlAppAreaMasterList.SelectedValue;
				GenManage gm = new GenManage();
				DataTable dt = gm.SelectAppAreaList(0, "DataMngt", code, 0, 1, _UserID);
				if (dt.Rows.Count > 0)
				{
					this.txtAppAreaCodeE.Text = dt.Rows[0]["AppAreaCode"].ToString();
					this.txtAppAreaNameE.Text = dt.Rows[0]["AppAreaName"].ToString();
					this.lblAppAreaIDE.Text = dt.Rows[0]["AppAreaID"].ToString();
					if (dt.Rows[0]["sActive"].ToString() == "Yes")
					{
						this.chkAppAreaActiveE.Checked = true;
					}
					else
					{
						this.chkAppAreaActiveE.Checked = true;
					}

					DataTable dt2 = gm.SelectAppAreaRightsList(0, "DataMngt", code, 1, 0, 1, _UserID);
					if (dt2.Rows.Count > 0)
					{
						foreach (DataRow row in dt2.Rows)
						{
							if (row["UserGroupCode"].ToString() != "")
							{
								switch (Convert.ToInt32(row["RightLevel"]))
								{
									case 1:
										_GrpCode1 = row["UserGroupCode"].ToString();
										_GrpName1 = row["UserGroupName"].ToString();
										break;																						
									case 2:
										_GrpCode2 = row["UserGroupCode"].ToString();
										_GrpName2 = row["UserGroupName"].ToString();
										break;
									case 3:
										_GrpCode3 = row["UserGroupCode"].ToString();
										_GrpName3 = row["UserGroupName"].ToString();
										break;
									case 4:
										_GrpCode4 = row["UserGroupCode"].ToString();
										_GrpName4 = row["UserGroupName"].ToString();
										break;
									case 5:
										_GrpCode5 = row["UserGroupCode"].ToString();
										_GrpName5 = row["UserGroupName"].ToString();
										break;
									default:
										break;
								}
							}
						}
					}

					this.txtAppAreaRights1.Text = _GrpCode1;
					this.txtAppAreaRName1.Text = _GrpName1;
					this.txtAppAreaRights2.Text = _GrpCode2;
					this.txtAppAreaRName2.Text = _GrpName2;
					this.txtAppAreaRights3.Text = _GrpCode3;
					this.txtAppAreaRName3.Text = _GrpName3;
					this.txtAppAreaRights4.Text = _GrpCode4;
					this.txtAppAreaRName4.Text = _GrpName4;
					this.txtAppAreaRights5.Text = _GrpCode5;
					this.txtAppAreaRName5.Text = _GrpName5;
					ViewState["GrpCode1"] = _GrpCode1;
					ViewState["GrpCode2"] = _GrpCode2;
					ViewState["GrpCode3"] = _GrpCode3;
					ViewState["GrpCode4"] = _GrpCode4;
					ViewState["GrpCode5"] = _GrpCode5;
					ViewState["GrpName1"] = _GrpName1;
					ViewState["GrpName2"] = _GrpName2;
					ViewState["GrpName3"] = _GrpName3;
					ViewState["GrpName4"] = _GrpName4;
					ViewState["GrpName5"] = _GrpName5;
					this.divEditAppArea.Style["display"] = "block";
				}
				else
				{
					_ErrMsg = "No areas were found that matched.";
					this.lblErrorMsg.Text = _ErrMsg;
				}

			}
			catch (Exception ex)
			{
				_ErrMsg = "Error when trying to open app area editing: " + ex.Message;
				this.lblErrorMsg.Text = _ErrMsg;
			}
		}

		protected void ddlEditUserGroupMaster_TextChanged(object sender, EventArgs e)
		{
			try
			{
				string grp = ddlEditUserGroupMaster.SelectedValue;
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectUserGroupList(0, grp, 0, 1, _UserID);
				int NbrRows = dt.Rows.Count;
				if (NbrRows > 0)
				{
					DataRow row = dt.Rows[0];
					this.txtGrpCodeE.Text = row["UserGroupCode"].ToString();
					this.txtGrpNameE.Text = row["UserGroup"].ToString();
					this.lblUserGrpIDE.Text = row["UserGroupID"].ToString();
					this.ddlAppAreaGE.SelectedValue = row["AppAreaCode"].ToString();
					this.ddlRightsLevelGE.SelectedValue = row["RightLevel"].ToString();
					this.lblNbrUsersInGroup.Text = row["NbrMembers"].ToString();
					if (row["sActive"].ToString() == "Yes")
					{
						this.chkGroupCodeActive.Checked = true;
					}
					else
					{
						this.chkGroupCodeActive.Checked = false;
					}
				}
				else
				{
					_ErrMsg = "No data was returned for that selection.";
					this.lblErrorMsg.Text = _ErrMsg;
				}

				// load group members list
				this.ddlRightsGroupF.SelectedValue = grp;
				if (_MainView == 0)
				{
					LoadUserGrid();
				}
				else
				{
					LoadUserGroupMembers();
				}
				this.divEditUserGroup.Style["display"] = "block";
			}
			catch (Exception ex)
			{
				_ErrMsg = "Error when trying to group editing: " + ex.Message;
				this.lblErrorMsg.Text = _ErrMsg;
			}
		}

		protected void btnAddPersonToGrp_Click(object sender, EventArgs e)
		{
			try
			{
				int id = Convert.ToInt32(this.ddlPeopleNotInGrp.SelectedValue);
				string grp = ddlEditUserGroupMaster.SelectedValue;
				DateTime bdate = DateTime.Now;
				Commands cmd = new Commands();
				DataTable dt = cmd.UpdateUserRight(0, id, grp, 0, "", 0, bdate, null, 1, _UserID);
				if (_MainView == 0)
				{
					LoadUserGrid();
				}
				else
				{
					LoadUserGroupMembers();
				}
				this.divAddNewPersonToGrp.Style["display"] = "none";
			}
			catch (Exception ex)
			{
				_ErrMsg = "Could not add person because of an error: " + ex.Message;
				this.lblErrorMsg.Text = _ErrMsg;
			}
		}

		protected void btnAddAnotherPerson_Click(object sender, EventArgs e)
		{
			try
			{
				string grp = ddlEditUserGroupMaster.SelectedValue;
				// update ddl
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectUserGroupNonMembers(grp, 0, 1, _UserID);
				this.ddlPeopleNotInGrp.DataTextField = "sFullName";
				this.ddlPeopleNotInGrp.DataValueField = "UserID";
				this.ddlPeopleNotInGrp.DataSource = dt;
				this.ddlPeopleNotInGrp.DataBind();
				// show area
				this.divAddNewPersonToGrp.Style["display"] = "block";
			}
			catch (Exception ex)
			{
				_ErrMsg = "Could not open add-person area because of an error: " + ex.Message;
				this.lblErrorMsg.Text = _ErrMsg;
			}
		}
	}
}