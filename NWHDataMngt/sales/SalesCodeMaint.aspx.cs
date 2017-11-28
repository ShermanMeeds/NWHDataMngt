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
	public partial class SalesCodeMaint : System.Web.UI.Page
	{
		#region Attributes
		CurrentUser _user = null;
		private CurrBrowser _Browser = null;
		private string _ErrMsg = string.Empty;
		private bool _IsAdmin = false;
		private int _NbrPages = 0;
		private int _PageID = 17;
		private int _PgNbr = 0;
		private int _PgSize = 20;
		private bool _CanEdit = false;
		private string _CBuildNbr = "";
		private int _UserID = 0;
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
			this.lblStatusMsg.Text = "";
			string usrname = "";
			//_PgNbr = 0;
			//_PgSize = 20;
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
				Session["NoAccessMsg"] = "You do not have access to the code maintenance page";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}

			// check for specific rights to cat tool
			if (_user.AccessRights < 2 && _user.CatToolRights == 0)
			{
				Session["NoAccessMsg"] = "You do not have access to the code maintenance page.";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}
			if (_user.CatToolRights > 1)
			{
				this._CanEdit = true;
			}
			if (_user.CatToolRights > 3)
			{
				this._IsAdmin = true;
			}

			Commands cmd = new Commands();
			DataTable dt = new DataTable();
			_CBuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
			_UserID = Convert.ToInt32(_user.UserID);

			if (!this.IsPostBack)
			{
				try
				{
					_PgNbr = 0;
					_PgSize = 20;

					// load user tracks
					dt = cmd.SelectUserTracks(_UserID, _PageID, 0);
					if (dt.Rows.Count > 0)
					{
						this.ddlPageSize.SelectedValue = dt.Rows[0]["PgSize"].ToString();
						_PgNbr = Convert.ToInt32(dt.Rows[0]["PgNbr"]);
						_PgSize = Convert.ToInt32(dt.Rows[0]["PgSize"]);
						this.gvCodeList.PageSize = _PgSize;
						this.gvCodeList.PageIndex = _PgNbr;
					}
				}
				catch (Exception ex)
				{
					this._ErrMsg = "Initial data Load encountered an error: " + ex.Message;
					this.lblStatusMsg.Text = this._ErrMsg;
				}

				BindDataGrid(1);

				ViewState.Add("PgNbr", _PgNbr.ToString());
				ViewState.Add("PgSize", _PgSize.ToString());
				ViewState.Add("NbrPages", _NbrPages.ToString());
			}
			else
			{
				//is postback - SET VIEWSTATE DATA
				_PgNbr = Convert.ToInt32(ViewState["PgNbr"]);
				_PgSize = Convert.ToInt32(ViewState["PgSize"]);
				_NbrPages = Convert.ToInt32(ViewState["NbrPages"]);
			}
			//string jsScript = "";
			//jsScript = "<script type=\"text/javascript\">var jigEmpID=" + _user.EmpID.ToString() + ";var jsgBrowserType='" + _Browser.BrowserType.ToString() + "';var jsgAr=" + _user.AccessRights.ToString() + ";</script>";
			//Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "MyTargetVariables", jsScript);
		}

		protected void BindDataGrid(int LoadType)
		{
			// LoadType = 1 for initial, 0 for subsequent
			try
			{
				string codetype = this.ddlCodeTypeF.SelectedValue;
				if(codetype == "0") { codetype = ""; }
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectCodeList("", codetype, 1, 1, 0, _UserID);
				this.gvCodeList.DataSource = dt;
				this.gvCodeList.DataBind();
				if (dt.Rows.Count == 0)
				{
					this.lblStatusMsg.Text = "No rows were found that match the criteria.";
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error while loading data: " + ex.Message;
				this.lblStatusMsg.Text = this._ErrMsg;
			}
		}

		protected void gvCodeList_PageIndexChanged(object sender, EventArgs e)
		{
			// do nothing
		}

		protected void gvCodeList_PageIndexChanging(object sender, GridViewPageEventArgs e)
		{
			gvCodeList.PageIndex = e.NewPageIndex;
			_PgNbr = e.NewPageIndex;
			BindDataGrid(0);
		}

		protected void btnSaveCodeData_Click(object sender, EventArgs e)
		{
			lblStatusMsg.Text = "";
			try
			{
				//int id = Convert.ToInt32(this.lblCatDataIDE.Text);
				int Type = 1;
				//if (id < 1) { Type = 0; }
				//string Reg = this.ddlRegionE.SelectedValue;
				//int Tracked = Convert.ToInt32(this.ddlIsTrackedE.SelectedValue);
				//int Mngd = Convert.ToInt32(this.ddlIsManagedE.SelectedValue);
				//string ProdID = this.txtProductE.Text;
				//string ProdDesc = this.txtProdDescE.Text.Trim();
				//string s = this.txtPriceE.Text.Replace(",", "");
				//s = s.Replace("$", "");
				//double Price = Convert.ToDouble(s);
				//string Specie = this.ddlItemSpeciesE.SelectedValue;
				//string Thickness = this.ddlItemThicknessE.SelectedValue;
				//string Grade = this.ddlItemGradeE.SelectedValue;
				//string Len = this.ddlItemLengthE.SelectedValue;
				//string Color = this.ddlItemColorE.SelectedValue;
				//string Sort = this.ddlItemSortE.SelectedValue;
				//string Milling = this.ddlItemMillingE.SelectedValue;
				//string NoPrint = this.ddlItemNoPrintE.SelectedValue;
				//string Comments = this.txtCommentPmE.Text;
				//UpdateItemData(id, Type, Reg, 0, ProdDesc, ProdID, ProdID + " " + ProdDesc, Price, Specie, Thickness, Grade, Len, Color, Sort, Milling, NoPrint, Tracked, Mngd, Comments);

				//this.spnAddNewRowBtn.Style["display"] = "inline";
				//this.spnSaveDataBtn.Style["display"] = "none";
				//this.spnCancelEditBtn.Style["display"] = "none";
				//this.divItemEdit.Style["display"] = "none";
			}
			catch (Exception ex)
			{
				lblStatusMsg.Text = "Error while saving item data: " + ex.Message;
			}
		}

		protected void gvCodeList_RowCommand(object sender, GridViewCommandEventArgs e)
		{
			string Issues = string.Empty;
			try
			{
				//Edit, Update, Delete, User
				string s = String.Empty;
				Label Lbl;
				TextBox txt;
				string cname = e.CommandName.ToString();
				int RowID = Convert.ToInt32(e.CommandArgument);
				GridViewRow r = gvCodeList.Rows[RowID];
				DataRowView rv = (DataRowView)r.DataItem;
				//DateTime BDate = DateTime.Now;
				//string sBDate = BDate.ToString("MM/dd/yyyy");
				//Lbl = (Label)r.FindControl("lblRegPTID");
				//int ID = Convert.ToInt32(Lbl.Text);
				//Lbl = (Label)r.FindControl("lblRegPTSpecie");
				//string Specie = Lbl.Text;
				//Lbl = (Label)r.FindControl("lblRegPTThick");
				//string Thickness = Lbl.Text;
				//Lbl = (Label)r.FindControl("lblRegPTGrade");
				//string Grade = Lbl.Text;
				//Lbl = (Label)r.FindControl("lblRegPTRegion");
				//string Reg = Lbl.Text;
				//Lbl = (Label)r.FindControl("lblRegPTProduct");
				//string Prod = Lbl.Text;
				//Lbl = (Label)r.FindControl("lblRegPTProdDesc");
				//string ProdDesc = Lbl.Text;
				//txt = (TextBox)r.FindControl("txtRegPTComment");
				//string CommentPM = txt.Text;
				//HiddenField hf = (HiddenField)r.FindControl("hfProdID");
				//string ProdID = hf.Value;

				////Lbl = (Label)r.FindControl("lblRegPTCommentReg");
				////string CommentReg = Lbl.Text;
				//txt = (TextBox)r.FindControl("txtRegPTPrice");
				//string sPrice = txt.Text;
				//s = txt.Text.Replace("$", "");
				//s = s.Replace(",", "");
				//if (s == "") { s = "0"; }
				//double Price = Convert.ToDouble(s);
				//int Tracked = 0;
				//Lbl = (Label)r.FindControl("lblRegPTTrack");
				//if (Lbl.Text == "Yes") { Tracked = 1; }
				//int Mngd = 0;
				//Lbl = (Label)r.FindControl("lblRegPTManaged");
				//if (Lbl.Text == "Yes") { Mngd = 1; }

				//Lbl = (Label)r.FindControl("lblRegPTProdLen");
				//string Len = Lbl.Text;
				//Lbl = (Label)r.FindControl("lblRegPTProdColor");
				//string Color = Lbl.Text;
				//Lbl = (Label)r.FindControl("lblRegPTProdSort");
				//string Sort = Lbl.Text;
				//Lbl = (Label)r.FindControl("lblRegPTProdMilling");
				//string Milling = Lbl.Text;
				//Lbl = (Label)r.FindControl("lblRegPTProdNoPrint");
				//string NoPrint = Lbl.Text;

				////Cells: 0-AppAreaU, 1-GroupUserID, 2-UserGroup, 3-FullUserName, 4-sRightLevel, 5-sBeginDate, 6-sEndDate, 7-btnEditRight/btnDelRight/btnEditUser, 8-UserLastName, 9-UserFirstName, 10-UserMiddleName
				////       11-EmailAddress, 12-EmpPosition, 13-RightLevel, 14-UserGroupCode, 15-UserGroupID, 16-UserLogin, 17-sActive, 18-sContractor, 19-UserID, 20-EmpID
				//switch (cname)
				//{
				//	//case "PriceEdit":
				//	//	break;
				//	//case "CommentEdit":
				//	//	break;
				//	case "Edit1":
				//		try
				//		{
				//			this.divItemEdit.Style["display"] = "block";
				//			this.lblCatDataIDE.Text = ID.ToString();
				//			this.txtProductE.Text = Prod;
				//			this.txtProdDescE.Text = ProdDesc;
				//			this.ddlIsManagedE.SelectedValue = Mngd.ToString();
				//			this.ddlIsTrackedE.SelectedValue = Tracked.ToString();
				//		}
				//		catch (HttpException hex)
				//		{
				//			this.lblErrorMsg.Text = hex.Message;
				//		}

				//		try
				//		{ this.ddlItemColorE.SelectedValue = Color; }
				//		catch (Exception e1)
				//		{
				//			if (Issues.Length > 0) { Issues += Environment.NewLine; }
				//			Issues += e1.Message;
				//		}
				//		try
				//		{ this.ddlItemGradeE.SelectedValue = Grade; }
				//		catch (Exception e2)
				//		{
				//			if (Issues.Length > 0) { Issues += Environment.NewLine; }
				//			Issues += e2.Message;
				//		}
				//		try
				//		{ this.ddlItemLengthE.SelectedValue = Len; }
				//		catch (Exception e3)
				//		{
				//			if (Issues.Length > 0) { Issues += Environment.NewLine; }
				//			Issues += e3.Message;
				//		}
				//		try
				//		{
				//			this.ddlItemMillingE.SelectedValue = Milling;
				//		}
				//		catch (Exception e4)
				//		{
				//			if (Issues.Length > 0) { Issues += Environment.NewLine; }
				//			Issues += e4.Message;
				//		}
				//		try
				//		{
				//			this.ddlItemNoPrintE.SelectedValue = NoPrint;
				//		}
				//		catch (Exception e5)
				//		{
				//			if (Issues.Length > 0) { Issues += Environment.NewLine; }
				//			Issues += e5.Message;
				//		}
				//		try
				//		{
				//			this.ddlItemSortE.SelectedValue = Sort;
				//		}
				//		catch (Exception e6)
				//		{
				//			if (Issues.Length > 0) { Issues += Environment.NewLine; }
				//			Issues += e6.Message;
				//		}
				//		try
				//		{
				//			this.ddlItemSpeciesE.SelectedValue = Specie;
				//		}
				//		catch (Exception e7)
				//		{
				//			if (Issues.Length > 0) { Issues += Environment.NewLine; }
				//			Issues += e7.Message;
				//		}
				//		try
				//		{
				//			this.ddlItemThicknessE.SelectedValue = Thickness;
				//		}
				//		catch (Exception e8)
				//		{
				//			if (Issues.Length > 0) { Issues += Environment.NewLine; }
				//			Issues += e8.Message;
				//		}
				//		try
				//		{
				//			this.txtPriceE.Text = GenUtilities.FormatToMoney(Price);
				//			this.txtCommentPmE.Text = CommentPM;
				//			this.ddlRegionE.SelectedValue = Reg;
				//		}
				//		catch (Exception e9)
				//		{
				//			if (Issues.Length > 0) { Issues += Environment.NewLine; }
				//			Issues += e9.Message;
				//		}
				//		this.txtProductE.Focus();
				//		if (Issues.Length > 0)
				//		{
				//			lblErrorMsg.Text = Issues;
				//		}
				//		this.spnAddNewRowBtn.Style["display"] = "none";
				//		this.spnSaveDataBtn.Style["display"] = "inline";
				//		this.spnCancelEditBtn.Style["display"] = "inline";
				//		break;
				//	case "Delete1":
				//		UpdateItemData(ID, 3, Reg, 0, Prod, ProdID, ProdDesc, Price, Specie, Thickness, Grade, Len, Color, Sort, Milling, NoPrint, Tracked, Mngd, CommentPM);
				//		break;
				//	case "New1":
				//		this.lblCatDataIDE.Text = "0";
				//		this.ddlRegionE.SelectedValue = Reg;
				//		if (Mngd == 1)
				//		{
				//			this.ddlIsManagedE.SelectedValue = "1";
				//		}
				//		else
				//		{
				//			this.ddlIsManagedE.SelectedValue = "0";
				//		}
				//		if (Tracked == 1)
				//		{
				//			this.ddlIsTrackedE.SelectedValue = "1";
				//		}
				//		else
				//		{
				//			this.ddlIsTrackedE.SelectedValue = "0";
				//		}
				//		this.txtProductE.Text = Prod;
				//		this.txtProdDescE.Text = ProdDesc;
				//		this.txtPriceE.Text = sPrice;
				//		this.ddlItemSpeciesE.SelectedValue = Specie;
				//		this.ddlItemThicknessE.SelectedValue = Thickness;
				//		this.ddlItemGradeE.SelectedValue = Grade;
				//		this.ddlItemLengthE.SelectedValue = Len;
				//		this.ddlItemColorE.SelectedValue = Color;
				//		this.ddlItemSortE.SelectedValue = Sort;
				//		this.ddlItemMillingE.SelectedValue = Milling;
				//		this.ddlItemNoPrintE.SelectedValue = NoPrint;
				//		this.txtCommentPmE.Text = CommentPM;
				//		this.spnAddNewRowBtn.Style["display"] = "none";
				//		this.spnSaveDataBtn.Style["display"] = "inline";
				//		this.spnCancelEditBtn.Style["display"] = "inline";
				//		this.divItemEdit.Style["display"] = "block";
				//		break;
				//	default:
				//		break;
				//}
				//// reload data
				//gvRegionPriceTrackLoad();

			}
			catch (Exception ex)
			{
				lblStatusMsg.Text = "Error accessing item data: " + ex.Message;
			}
		}

		protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
		{
			_PgSize = Convert.ToInt32(this.ddlPageSize.SelectedValue);
			_PgNbr = 0;
			gvCodeList.PageIndex = _PgNbr;
			gvCodeList.PageSize = _PgSize;
			//this.gvCatData.DataBind();
			BindDataGrid(0);
		}

		protected void ddlCodeTypeF_SelectedIndexChanged(object sender, EventArgs e)
		{
			BindDataGrid(0);
		}
	}
}