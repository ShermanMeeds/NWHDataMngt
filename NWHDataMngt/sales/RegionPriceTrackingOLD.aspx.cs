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
	public partial class RegionPriceTracking : System.Web.UI.Page
	{
		#region Attributes
		CurrentUser _user = null;
		private CurrBrowser _Browser = null;
		private string _CBuildNbr = "";
		private bool _CanEdit = false;
		private bool _IsAdmin = false;
		private int _SortDir = 0;
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

			// establish initial and default values
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
				Session["NoAccessMsg"] = "You do not have access to CAT item pricing";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}

			// check for specific rights to cat tool
			if (!_user.IsInRole("catAdmin") && !_user.IsInRole("catprcedit") && !_user.IsInRole("catAdmin") && !_user.IsInRole("datamngtcat") && _user.IsAdmin == false)
			{
				Session["NoAccessMsg"] = "You do not have access to the Cat item pricing.";
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
					LoadSpeciesListE();
					LoadGradeListE();
					LoadThicknessListE();
					LoadColorListE();
					LoadLengthListE();
					LoadMillingListE();
					LoadNoPrintListE();
					LoadSortListE();
					gvRegionPriceTrackLoad();

					this.imgSortDir.ImageUrl = "~/Images/arrow2_n.gif";
					_SortDir = 0;
					ViewState.Add("SortDir", "0");
				}
				catch (Exception ex)
				{
					this._ErrMsg = "Initial data Load encountered an error: " + ex.Message;
					this.lblErrorMsg.Text = this._ErrMsg;
				}

				//string jsScript = "";
				//jsScript = "<script type=\"text/javascript\">var jigEmpID=" + _user.EmpID.ToString() + ";var jsgBrowserType='" + _Browser.BrowserType.ToString() + "';var jsgAr=" + _user.AccessRights.ToString() + ";</script>";
				//Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "MyTargetVariables", jsScript);
			}
			else
			{
				// postback
				_SortDir = Convert.ToInt32(ViewState["SortDir"]);
			}
		}

    /// <summary>
    /// Load Region List in Edit form
    /// </summary>
  	public void LoadLengthListE()
		{
			this.lblErrorMsg.Text = "";
			try
			{
				this.lblErrorMsg.Text = "";
				CatToolFunctions ctf = new CatToolFunctions();
				DataTable dt = ctf.GetCatCodeList("Length", 0, 1, 0, 0, 1, _UserID);
				this.ddlItemLengthE.DataTextField = "CodeDescription";
				this.ddlItemLengthE.DataValueField = "CatCode";
				this.ddlItemLengthE.DataSource = dt;
				this.ddlItemLengthE.DataBind();
				this.ddlItemLengthE.SelectedIndex = 0;

				this.ddlLengthF.DataTextField = "CodeDescription";
				this.ddlLengthF.DataValueField = "CatCode";
				this.ddlLengthF.DataSource = dt;
				this.ddlLengthF.DataBind();
				this.ddlLengthF.SelectedIndex = 0;
			}
			catch (Exception ex)
			{
				_ErrMsg = "Lengths: " + ex.Message;
				this.lblErrorMsg.Style["display"] = "block";
				this.lblErrorMsg.Text = this.ErrorMsg;
			}
		}

		public void LoadColorListE()
		{
			this.lblErrorMsg.Text = "";
			try
			{
				this.lblErrorMsg.Text = "";
				//CatToolFunctions ctf = new CatToolFunctions();
				//DataTable dt = ctf.GetCatCodeList("Color", 0, 1, 0, 0, 1, _UserID);
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectProductCodeList("Color", 0, 1, 0, 0, 0, _UserID);
				this.ddlItemColorE.DataTextField = "CodeDescription";
				this.ddlItemColorE.DataValueField = "CatCode";
				this.ddlItemColorE.DataSource = dt;
				this.ddlItemColorE.DataBind();
				this.ddlItemColorE.SelectedIndex = 0;

				this.ddlColorF.DataTextField = "CodeDescription";
				this.ddlColorF.DataValueField = "CatCode";
				this.ddlColorF.DataSource = dt;
				this.ddlColorF.DataBind();
				this.ddlColorF.SelectedIndex = 0;
			}
			catch (Exception ex)
			{
				_ErrMsg = "Color: " + ex.Message;
				this.lblErrorMsg.Style["display"] = "block";
				this.lblErrorMsg.Text = this.ErrorMsg;
			}
		}

		public void LoadSortListE()
		{
			this.lblErrorMsg.Text = "";
			try
			{
				this.lblErrorMsg.Text = "";
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectProductCodeList("Sort", 0, 1, 0, 0, 0, _UserID);
				this.ddlItemSortE.DataTextField = "CodeDescription";
				this.ddlItemSortE.DataValueField = "CatCode";
				this.ddlItemSortE.DataSource = dt;
				this.ddlItemSortE.DataBind();
				this.ddlItemSortE.SelectedIndex = 0;

				this.ddlSortF.DataTextField = "CodeDescription";
				this.ddlSortF.DataValueField = "CatCode";
				this.ddlSortF.DataSource = dt;
				this.ddlSortF.DataBind();
				this.ddlSortF.SelectedIndex = 0;
			}
			catch (Exception ex)
			{
				_ErrMsg = "Sort: " + ex.Message;
				this.lblErrorMsg.Style["display"] = "block";
				this.lblErrorMsg.Text = this.ErrorMsg;
			}
		}

		public void LoadMillingListE()
		{
			this.lblErrorMsg.Text = "";
			try
			{
				this.lblErrorMsg.Text = "";
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectProductCodeList("Milling", 0, 1, 0, 0, 0, _UserID);
				this.ddlItemMillingE.DataTextField = "CodeDescription";
				this.ddlItemMillingE.DataValueField = "CatCode";
				this.ddlItemMillingE.DataSource = dt;
				this.ddlItemMillingE.DataBind();
				this.ddlItemMillingE.SelectedIndex = 0;

				this.ddlMillingF.DataTextField = "CodeDescription";
				this.ddlMillingF.DataValueField = "CatCode";
				this.ddlMillingF.DataSource = dt;
				this.ddlMillingF.DataBind();
				this.ddlMillingF.SelectedIndex = 0;
			}
			catch (Exception ex)
			{
				_ErrMsg = "Regions: " + ex.Message;
				this.lblErrorMsg.Style["display"] = "block";
				this.lblErrorMsg.Text = this.ErrorMsg;
			}
		}

		public void LoadNoPrintListE()
		{
			this.lblErrorMsg.Text = "";
			try
			{
				this.lblErrorMsg.Text = "";
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectProductCodeList("NoPrint", 0, 1, 0, 0, 0, _UserID);
				this.ddlItemNoPrintE.DataTextField = "CodeDescription";
				this.ddlItemNoPrintE.DataValueField = "CatCode";
				this.ddlItemNoPrintE.DataSource = dt;
				this.ddlItemNoPrintE.DataBind();
				this.ddlItemNoPrintE.SelectedIndex = 0;

				this.ddlNoPrintF.DataTextField = "CodeDescription";
				this.ddlNoPrintF.DataValueField = "CatCode";
				this.ddlNoPrintF.DataSource = dt;
				this.ddlNoPrintF.DataBind();
				this.ddlNoPrintF.SelectedIndex = 0;
			}
			catch (Exception ex)
			{
				_ErrMsg = "NoPrint: " + ex.Message;
				this.lblErrorMsg.Style["display"] = "block";
				this.lblErrorMsg.Text = this.ErrorMsg;
			}
		}

		public void LoadSpeciesListE()
		{
			this.lblErrorMsg.Text = "";
			try
			{
				this.lblErrorMsg.Text = "";
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectProductCodeList("Species", 0, 1, 0, 0, 0, _UserID);
				this.ddlItemSpeciesE.DataTextField = "CodeDescription";
				this.ddlItemSpeciesE.DataValueField = "CatCode";
				this.ddlItemSpeciesE.DataSource = dt;
				this.ddlItemSpeciesE.DataBind();
				this.ddlItemSpeciesE.SelectedIndex = 0;

				this.ddlSpeciesF.DataTextField = "CodeDescription";
				this.ddlSpeciesF.DataValueField = "CatCode";
				this.ddlSpeciesF.DataSource = dt;
				this.ddlSpeciesF.DataBind();
				this.ddlSpeciesF.SelectedIndex = 0;
			}
			catch (Exception ex)
			{
				_ErrMsg = "Species: " + ex.Message;
				this.lblErrorMsg.Style["display"] = "block";
				this.lblErrorMsg.Text = this.ErrorMsg;
			}
		}

		public void LoadGradeListE()
		{
			this.lblErrorMsg.Text = "";
			try
			{
				this.lblErrorMsg.Text = "";
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectProductCodeList("Grade", 0, 1, 0, 0, 0, _UserID);
				this.ddlItemGradeE.DataTextField = "CodeDescription";
				this.ddlItemGradeE.DataValueField = "CatCode";
				this.ddlItemGradeE.DataSource = dt;
				this.ddlItemGradeE.DataBind();
				this.ddlItemGradeE.SelectedIndex = 0;

				ddlGradeF.DataTextField = "CodeDescription";
				this.ddlGradeF.DataValueField = "CatCode";
				this.ddlGradeF.DataSource = dt;
				this.ddlGradeF.DataBind();
				this.ddlGradeF.SelectedIndex = 0;
			}
			catch (Exception ex)
			{
				_ErrMsg = "Grade: " + ex.Message;
				this.lblErrorMsg.Style["display"] = "block";
				this.lblErrorMsg.Text = this.ErrorMsg;
			}
		}

		public void LoadThicknessListE()
		{
			this.lblErrorMsg.Text = "";
			try
			{
				this.lblErrorMsg.Text = "";
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectProductCodeList("Thickness", 0, 1, 0, 0, 0, _UserID);
				this.ddlItemThicknessE.DataTextField = "CodeDescription";
				this.ddlItemThicknessE.DataValueField = "CatCode";
				this.ddlItemThicknessE.DataSource = dt;
				this.ddlItemThicknessE.DataBind();
				this.ddlItemThicknessE.SelectedIndex = 0;

				this.ddlThicknessF.DataTextField = "CodeDescription";
				this.ddlThicknessF.DataValueField = "CatCode";
				this.ddlThicknessF.DataSource = dt;
				this.ddlThicknessF.DataBind();
				this.ddlThicknessF.SelectedIndex = 0;
			}
			catch (Exception ex)
			{
				_ErrMsg = "Thickness: " + ex.Message;
				this.lblErrorMsg.Style["display"] = "block";
				this.lblErrorMsg.Text = this.ErrorMsg;
			}
		}

		/// <summary>
		/// Load main data grid
		/// </summary>
		protected void gvRegionPriceTrackLoad()
		{
			this.lblErrorMsg.Text = "";
			try
			{
				string Specie = this.ddlSpeciesF.SelectedValue;
				string Thickness = this.ddlThicknessF.SelectedValue;
				string Grade = this.ddlGradeF.SelectedValue;
				string Len = this.ddlLengthF.SelectedValue;
				string Color = this.ddlColorF.SelectedValue;
				string fSort = this.ddlSortF.SelectedValue;
				string Milling = this.ddlMillingF.SelectedValue;
				string NoPrint = this.ddlNoPrintF.SelectedValue;
				string Cmt = this.txtCommentsF.Text;
				int Sort = Convert.ToInt32(this.ddlDataSort.SelectedValue);
				int Mngd = 0;
				int Dir = _SortDir;
				if (this.chkManagedOnly.Checked == true) { Mngd = 1; }

				CatToolFunctions ct = new CatToolFunctions();
				string Reg = this.ddlRegionF.SelectedValue;
				DataTable dt = ct.SelectSalesProductFullList(Reg, Specie, Grade, Thickness,Len, Color, fSort, Milling, NoPrint, Cmt, Mngd, 1, Sort, Dir, 0, 10000, _UserID);
				this.gvRegionPriceTrack.DataSource = dt;
				this.gvRegionPriceTrack.DataBind();
        if (dt.Rows.Count == 0)
        {
          this.lblErrorMsg.Text = "No data rows were found";
        }
      }
			catch (Exception ex)
			{
				this._ErrMsg = "Initial grid data Load encountered an error: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void gvRegionPriceTrack_DataBinding(object sender, EventArgs e)
		{
      // nothing
		}

		protected void gvRegionPriceTrack_DataBound(object sender, EventArgs e)
		{
			// nothing
		}

    protected void gvRegionPriceTrack_PageIndexChanged(object sender, EventArgs e)
    {
      // nothing
    }

    protected void gvRegionPriceTrack_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
      gvRegionPriceTrack.PageIndex = e.NewPageIndex;
      _PgNbr = e.NewPageIndex;
      gvRegionPriceTrackLoad();
    }

    /// <summary>
    /// Saves changes or new Item data
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSaveEdit_Click(object sender, EventArgs e)
    {
      lblErrorMsg.Text = "";
      try
      {
        int id = Convert.ToInt32(this.lblCatDataIDE.Text);
        int Type = 1;
        if (id < 1) {Type = 0;}
        string Reg = this.ddlRegionE.SelectedValue;
        int Tracked = Convert.ToInt32(this.ddlIsTrackedE.SelectedValue);
				int Mngd = Convert.ToInt32(this.ddlIsManagedE.SelectedValue);
				string ProdID = this.txtProductE.Text;
        string ProdDesc = this.txtProdDescE.Text.Trim();
				string s = this.txtPriceE.Text.Replace(",", "");
				s = s.Replace("$", "");
				double Price = Convert.ToDouble(s);
        string Specie = this.ddlItemSpeciesE.SelectedValue;
        string Thickness = this.ddlItemThicknessE.SelectedValue;
        string Grade = this.ddlItemGradeE.SelectedValue;
				string Len = this.ddlItemLengthE.SelectedValue;
				string Color = this.ddlItemColorE.SelectedValue;
				string Sort = this.ddlItemSortE.SelectedValue;
				string Milling = this.ddlItemMillingE.SelectedValue;
				string NoPrint = this.ddlItemNoPrintE.SelectedValue;
				string Comments = this.txtCommentPmE.Text;
				UpdateItemData(id, Type, Reg, ProdDesc, ProdID, ProdID + " " + ProdDesc, Price, Specie, Thickness, Grade, Len, Color, Sort, Milling, NoPrint, Tracked, Mngd, Comments);

				this.spnAddNewRowBtn.Style["display"] = "inline";
				this.spnSaveDataBtn.Style["display"] = "none";
				this.spnCancelEditBtn.Style["display"] = "none";
				this.divItemEdit.Style["display"] = "none";
			}
			catch (Exception ex)
      {
        lblErrorMsg.Text = "Error while saving item data: " + ex.Message;
      }
    }

    /// <summary>
    /// Row Command capture for gvRegionPriceTrack GridView
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvRegionPriceTrack_RowCommand(object sender, GridViewCommandEventArgs e)
    {
			string Issues = string.Empty;
			try
      {
        //Edit, Update, Delete, User
        string s = String.Empty;
				CheckBox chk;
				Label Lbl;
				TextBox txt;
        string cname = e.CommandName.ToString();
        int RowID = Convert.ToInt32(e.CommandArgument);
        GridViewRow r = gvRegionPriceTrack.Rows[RowID];
        DataRowView rv = (DataRowView)r.DataItem;
        DateTime BDate = DateTime.Now;
        string sBDate = BDate.ToString("MM/dd/yyyy");
        Lbl = (Label)r.FindControl("lblRegPTID");
        int ID = Convert.ToInt32(Lbl.Text);
        Lbl = (Label)r.FindControl("lblRegPTSpecie");
        string Specie = Lbl.Text;
        Lbl = (Label)r.FindControl("lblRegPTThick");
        string Thickness = Lbl.Text;
        Lbl = (Label)r.FindControl("lblRegPTGrade");
        string Grade = Lbl.Text;
        Lbl = (Label)r.FindControl("lblRegPTRegion");
        string Reg = Lbl.Text;
        Lbl = (Label)r.FindControl("lblRegPTProduct");
        string Prod = Lbl.Text;
        Lbl = (Label)r.FindControl("lblRegPTProdDesc");
        string ProdDesc = Lbl.Text;
        txt = (TextBox)r.FindControl("txtRegPTComment");
        string CommentPM = txt.Text;
				HiddenField hf = (HiddenField)r.FindControl("hfProdID");
				string ProdID = hf.Value;
				
				//Lbl = (Label)r.FindControl("lblRegPTCommentReg");
        //string CommentReg = Lbl.Text;
        txt = (TextBox)r.FindControl("txtRegPTPrice");
				string sPrice = txt.Text;
        s = txt.Text.Replace("$", "");
        s = s.Replace(",", "");
        if (s == "") { s = "0"; }
        double Price = Convert.ToDouble(s);
				int Mngd = 0;
				int Tracked = 0;
				chk = (CheckBox)r.FindControl("chkRegPTManaged");
        if (chk.Checked == true) {
					Tracked = 1;
					Mngd = 1;
				}
				
				Lbl = (Label)r.FindControl("lblRegPTProdLen");
				string Len = Lbl.Text;
				Lbl = (Label)r.FindControl("lblRegPTProdColor");
				string Color = Lbl.Text;
				Lbl = (Label)r.FindControl("lblRegPTProdSort");
				string Sort = Lbl.Text;
				Lbl = (Label)r.FindControl("lblRegPTProdMilling");
				string Milling = Lbl.Text;
				Lbl = (Label)r.FindControl("lblRegPTProdNoPrint");
				string NoPrint = Lbl.Text;

				//Cells: 0-AppAreaU, 1-GroupUserID, 2-UserGroup, 3-FullUserName, 4-sRightLevel, 5-sBeginDate, 6-sEndDate, 7-btnEditRight/btnDelRight/btnEditUser, 8-UserLastName, 9-UserFirstName, 10-UserMiddleName
				//       11-EmailAddress, 12-EmpPosition, 13-RightLevel, 14-UserGroupCode, 15-UserGroupID, 16-UserLogin, 17-sActive, 18-sContractor, 19-UserID, 20-EmpID
				switch (cname)
        {
					//case "PriceEdit":
					//	break;
					//case "CommentEdit":
					//	break;
					case "Edit1":
						try
						{
							this.divItemEdit.Style["display"] = "block";
							this.lblCatDataIDE.Text = ID.ToString();
							this.txtProductE.Text = Prod;
							this.txtProdDescE.Text = ProdDesc;
							this.ddlIsManagedE.SelectedValue = Mngd.ToString();
							this.ddlIsTrackedE.SelectedValue = Tracked.ToString();
						}
						catch (HttpException hex)
						{
							this.lblErrorMsg.Text = hex.Message;
						}

						try
						{ this.ddlItemColorE.SelectedValue = Color; }
						catch(Exception e1)
						{
							if (Issues.Length > 0) { Issues += Environment.NewLine; }
							Issues += e1.Message;
						}
						try
						{ this.ddlItemGradeE.SelectedValue = Grade; }
						catch (Exception e2)
						{
							if (Issues.Length > 0) { Issues += Environment.NewLine; }
							Issues += e2.Message;
						}
						try
						{ this.ddlItemLengthE.SelectedValue = Len; }
						catch (Exception e3)
						{
							if (Issues.Length > 0) { Issues += Environment.NewLine; }
							Issues += e3.Message;
						}
						try
						{
							this.ddlItemMillingE.SelectedValue = Milling;
						}
						catch (Exception e4)
						{
							if (Issues.Length > 0) { Issues += Environment.NewLine; }
							Issues += e4.Message;
						}
						try
						{
							this.ddlItemNoPrintE.SelectedValue = NoPrint;
						}
						catch (Exception e5)
						{
							if (Issues.Length > 0) { Issues += Environment.NewLine; }
							Issues += e5.Message;
						}
						try
						{
							this.ddlItemSortE.SelectedValue = Sort;
						}
						catch (Exception e6)
						{
							if (Issues.Length > 0) { Issues += Environment.NewLine; }
							Issues += e6.Message;
						}
						try
						{
							this.ddlItemSpeciesE.SelectedValue = Specie;
						}
						catch (Exception e7)
						{
							if (Issues.Length > 0) { Issues += Environment.NewLine; }
							Issues += e7.Message;
						}
						try
						{
							this.ddlItemThicknessE.SelectedValue = Thickness;
						}
						catch (Exception e8)
						{
							if (Issues.Length > 0) { Issues += Environment.NewLine; }
							Issues += e8.Message;
						}
						try
						{
							this.txtPriceE.Text = GenUtilities.FormatToMoney(Price);
							this.txtCommentPmE.Text = CommentPM;
							this.ddlRegionE.SelectedValue = Reg;
						}
						catch (Exception e9)
						{
							if (Issues.Length > 0) { Issues += Environment.NewLine; }
							Issues += e9.Message;
						}
						this.txtProductE.Focus();
						if (Issues.Length > 0)
						{
							lblErrorMsg.Text = Issues;
						}
						this.spnAddNewRowBtn.Style["display"] = "none";
						this.spnSaveDataBtn.Style["display"] = "inline";
						this.spnCancelEditBtn.Style["display"] = "inline";
						break;
          case "Delete1":
           UpdateItemData(ID, 3, Reg, Prod, ProdID, ProdDesc, Price, Specie, Thickness, Grade, Len, Color, Sort, Milling, NoPrint, Tracked, Mngd, CommentPM);
            break;
					case "New1":
						this.lblCatDataIDE.Text = "0";
						this.ddlRegionE.SelectedValue = Reg;
						if (Mngd == 1)
						{
							this.ddlIsManagedE.SelectedValue = "1";
						}
						else
						{
							this.ddlIsManagedE.SelectedValue = "0";
						}
						if (Tracked == 1)
						{
							this.ddlIsTrackedE.SelectedValue = "1";
						}
						else
						{
							this.ddlIsTrackedE.SelectedValue = "0";
						}
						this.txtProductE.Text = Prod;
						this.txtProdDescE.Text = ProdDesc;
						this.txtPriceE.Text = sPrice;
						if (Specie == "") { Specie = "0"; }
						if (Thickness == "") { Thickness = "0"; }
						if (Grade == "") { Grade = "0"; }
						if (Len == "") { Len = "0"; }
						if (Color == "") { Color = "0"; }
						if (Sort == "") { Sort = "0"; }
						if (Milling == "") { Milling = "0"; }
						if (NoPrint == "") { NoPrint = "0"; }
						this.ddlItemSpeciesE.SelectedValue = Specie;
						this.ddlItemThicknessE.SelectedValue = Thickness;
						this.ddlItemGradeE.SelectedValue = Grade;
						this.ddlItemLengthE.SelectedValue = Len;
						this.ddlItemColorE.SelectedValue = Color;
						this.ddlItemSortE.SelectedValue = Sort;
						this.ddlItemMillingE.SelectedValue = Milling;
						this.ddlItemNoPrintE.SelectedValue = NoPrint;
						this.txtCommentPmE.Text = CommentPM;
						this.spnAddNewRowBtn.Style["display"] = "none";
						this.spnSaveDataBtn.Style["display"] = "inline";
						this.btnSaveEdit.Text = "Save";
						this.spnCancelEditBtn.Style["display"] = "inline";
						this.divItemEdit.Style["display"] = "block";
						break;
					default:
            break;
        }
        // reload data
				gvRegionPriceTrackLoad();

      }
      catch (Exception ex)
      {
        lblErrorMsg.Text = "Error accessing item data: " + ex.Message;
      }
    }

    /// <summary>
    /// Update Cat Item Data
    /// </summary>
    /// <param name="ID"></param>
    /// <param name="Type"></param>
    /// <param name="Region"></param>
    /// <param name="Prod"></param>
    /// <param name="ProdDesc"></param>
    /// <param name="Price"></param>
    /// <param name="Specie"></param>
    /// <param name="Thickness"></param>
    /// <param name="Grade"></param>
    /// <param name="Tracked"></param>
    /// <param name="CommentPM"></param>
    /// <param name="CommentReg"></param>
    protected void UpdateItemData(int ID, int Type, string Region, string Prod, string ProdID, string ProdDesc, double Price, string Specie, string Thickness, string Grade, string Len, string Color, string Sort, string Milling, string NoPrint, int Tracked, int Mngd, string Comments) 
    {
        lblErrorMsg.Text = "";
      try 
      {
        CatToolFunctions ctf = new CatToolFunctions();
				//DataTable dt = ctf.UpdateRegPriceTrackItem(ID, 3, Region, Prod, ProdDesc, Price, Specie, Thickness, Grade, Len, Color, Sort, Milling, NoPrint, Tracked, Mngd, Comments, _UserID);
				DataTable dt = ctf.UpdateCatToolProductData(ID, Region, Prod, ProdID, ProdDesc, Price, Comments, Specie, Thickness, Grade, Len, Color, Sort, Milling, NoPrint, 0, Mngd, Tracked, _UserID);
				gvRegionPriceTrackLoad();
      }
      catch (Exception ex) {
        lblErrorMsg.Text = "Error updating item data: " + ex.Message;
      }
    }

    protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
      try
      {
        _PgSize = Convert.ToInt32(this.ddlPageSize.SelectedValue);
        gvRegionPriceTrack.PageSize = _PgSize;
        gvRegionPriceTrack.PageIndex = 0;
        gvRegionPriceTrack.DataBind();
      }
      catch (Exception ex)
      {
        lblErrorMsg.Text = "Error repaginating item data: " + ex.Message;
      }
    }

    protected void btnEditCatAvail_Click(object sender, EventArgs e)
    {
      Response.Redirect("CatTool.aspx", false);
    }

		protected void txtProductE_TextChanged(object sender, EventArgs e)
		{
			try
			{
				this.lblErrorMsg.Text = "";
				CatToolFunctions ctf = new CatToolFunctions();
				// load product data from LTProd
				DataTable dt = ctf.GetCatToolProductData("HD", txtProductE.Text, "", 0, 2, _UserID);
				if (dt.Rows.Count > 0)
				{
					this.ddlItemSpeciesE.SelectedValue = dt.Rows[0]["Specie"].ToString();
					this.ddlItemThicknessE.SelectedValue = dt.Rows[0]["Thickness"].ToString();
					this.ddlItemGradeE.SelectedValue = dt.Rows[0]["Grade"].ToString();
					this.txtProdDescE.Text = dt.Rows[0]["Product"].ToString();
				}
				else
				{
					lblErrorMsg.Text = "Product does not exist.";
				}
			}
			catch (Exception ex)
			{
				lblErrorMsg.Text = "Error getting product data: " + ex.Message;
			}
		}

		protected void btnCancelEdit_Click(object sender, EventArgs e)
		{
			this.divItemEdit.Style["display"] = "none";
			this.spnAddNewRowBtn.Style["display"] = "inline";
			this.spnSaveDataBtn.Style["display"] = "none";
			this.spnCancelEditBtn.Style["display"] = "none";
		}

		protected void txtRegPTComment_TextChanged(object sender, EventArgs e)
		{
			try
			{
				GridViewRow currentRow = (GridViewRow)((TextBox)sender).Parent.Parent; //.Parent.Parent;
				TextBox txt = (TextBox)currentRow.FindControl("txtRegPTComment");
				//double count = Convert.ToDouble(txt.Text);
				Label lbl = (Label)currentRow.FindControl("lblRegPTID");
				int id = Convert.ToInt32(lbl.Text);
				CatToolFunctions ctf = new CatToolFunctions();
				DataTable dt = ctf.UpdateCatToolProductDataItem(id, 1, txt.Text, _UserID);
			}
			catch (Exception ex)
			{
				lblErrorMsg.Text = "Error updating comment: " + ex.Message;
			}
		}

		protected void txtRegPTPrice_TextChanged(object sender, EventArgs e)
		{
			try
			{
				GridViewRow currentRow = (GridViewRow)((TextBox)sender).Parent.Parent; //.Parent.Parent;
				TextBox txt = (TextBox)currentRow.FindControl("txtRegPTPrice");
				//double count = Convert.ToDouble(txt.Text);
				Label lbl = (Label)currentRow.FindControl("lblRegPTID");
				int id = Convert.ToInt32(lbl.Text);
				CatToolFunctions ctf = new CatToolFunctions();
				string price = txt.Text;
				price = price.Replace("$", "").Replace(",", "");
				DataTable dt = ctf.UpdateCatToolProductDataItem(id, 0, price, _UserID);
			}
			catch (Exception ex)
			{
				lblErrorMsg.Text = "Error updating price: " + ex.Message;
			}
		}

		protected void btnAddNewRow_Click(object sender, EventArgs e)
		{
			try
			{
				this.lblCatDataIDE.Text = "0";
				this.ddlRegionE.SelectedValue = "0";
				this.ddlIsTrackedE.SelectedValue = "1";
				this.ddlIsManagedE.SelectedValue = "1";
				this.txtProductE.Text = "";
				this.txtProdDescE.Text = "";
				this.txtPriceE.Text = "0";
				this.ddlItemSpeciesE.SelectedValue = "0";
				this.ddlItemThicknessE.SelectedValue = "0";
				this.ddlItemGradeE.SelectedValue = "0";
				this.ddlItemLengthE.SelectedValue = "0";
				this.ddlItemColorE.SelectedValue = "0";
				this.ddlItemSortE.SelectedValue = "0";
				this.ddlItemMillingE.SelectedValue = "0";
				this.ddlItemNoPrintE.SelectedValue = "0";
				this.txtCommentPmE.Text = "";
				this.spnAddNewRowBtn.Style["display"] = "none";
				this.spnSaveDataBtn.Style["display"] = "inline";
				this.spnCancelEditBtn.Style["display"] = "inline";
				this.divItemEdit.Style["display"] = "block";
			}
			catch (Exception ex)
			{
				lblErrorMsg.Text = "Error attempting to add a new row: " + ex.Message;
			}
		}

		protected void gvRegionPriceTrack_RowDataBound2(object sender, GridViewRowEventArgs e)
		{
			//this.lblErrorMsg.Text = "";
			TextBox txt;
			CheckBox chk;
			string IsMngd = string.Empty;
			try
			{
				if (e.Row.RowType == DataControlRowType.DataRow)
				{
					// set pointers to row and data row
					GridViewRow r = e.Row;
					DataRowView dv = (DataRowView)r.DataItem;
					double p1 = Convert.ToDouble(dv["PiecePrice"]);
					double p2 = Convert.ToDouble(dv["MBFPrice"]);
					string s1 = dv["PcsPriceBook"].ToString();
					string s2 = dv["MBFPriceBook"].ToString();
					txt = (TextBox)r.FindControl("txtRegPTPrice");
					txt.ToolTip = "PCS Price: " + p1.ToString() + "-PCS Price Book " + s1 + "-MBF Price: " + p2.ToString() + "-MBF PriceBook: " + s2;
					chk = (CheckBox)r.FindControl("chkRegPTManaged");
					IsMngd = dv["sIsManaged"].ToString();
					if (IsMngd == "Yes" && chk.Checked != true)
					{
						chk.Checked = true;
					}
					//else
					//{
					//	chk.Checked = false;
					//}
				}
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error wile row data binding: " + ex.Message;
			}
		}

		protected void ddlRegionF_SelectedIndexChanged(object sender, EventArgs e)
		{
			_PgNbr = 0;
			gvRegionPriceTrack.PageIndex = _PgNbr;
			gvRegionPriceTrackLoad();
		}

		protected void chkRegPTManaged_CheckedChanged(object sender, EventArgs e)
		{
			try
			{
				string chkd = "0";
				GridViewRow row = ((GridViewRow)((CheckBox)sender).NamingContainer);
				int index = row.RowIndex;
				CheckBox chk = (CheckBox)gvRegionPriceTrack.Rows[index].FindControl("chkRegPTManaged");
				Label lbl = (Label)gvRegionPriceTrack.Rows[index].FindControl("lblRegPTID");
				int id = Convert.ToInt32(lbl.Text);
				if (id > 0)
				{
					if (chk.Checked == true) { chkd = "1"; }
					CatToolFunctions ctf = new CatToolFunctions();
					DataTable dt = ctf.UpdateCatToolProductDataItem(id, 2, chkd, _UserID);
				}
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error wile updating managed status: " + ex.Message;
			}
		}

		protected void txtCommentsF_TextChanged(object sender, EventArgs e)
		{
			_PgNbr = 0;
			gvRegionPriceTrack.PageIndex = _PgNbr;
			gvRegionPriceTrackLoad();
		}

		protected void ddlDataSort_SelectedIndexChanged(object sender, EventArgs e)
		{
			_PgNbr = 0;
			gvRegionPriceTrack.PageIndex = _PgNbr;
			gvRegionPriceTrackLoad();
		}

		protected void imgSortDir_Click(object sender, ImageClickEventArgs e)
		{
			if (_SortDir == 0)
			{
				_SortDir = 1;
				this.imgSortDir.ImageUrl = "~/Images/arrow2_s.gif";
			}
			else
			{
				_SortDir = 0;
				this.imgSortDir.ImageUrl = "~/Images/arrow2_n.gif";
			}
			ViewState["SortDir"] = _SortDir.ToString();
			_PgNbr = 0;
			gvRegionPriceTrack.PageIndex = _PgNbr;
			gvRegionPriceTrackLoad();
		}

		protected void chkPrinterFriendly_CheckedChanged(object sender, EventArgs e)
		{
			try
			{
				if (this.chkPrinterFriendly.Checked == true)
				{
					//gvRegionPriceTrack.Columns[6].Visible = false;

				}
				else
				{
					//gvRegionPriceTrack.Columns[6].Visible = true;

				}

			}
			catch (Exception ex)
			{

			}
		}

		protected void btnRefreshDataGrid_Click(object sender, EventArgs e)
		{
			_PgNbr = 0;
			gvRegionPriceTrack.PageIndex = _PgNbr;
			gvRegionPriceTrackLoad();
		}
	}
}