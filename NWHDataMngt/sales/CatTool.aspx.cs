using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Configuration;
using System.Text.RegularExpressions;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using DataLayer;

namespace DataMngt.sales
{
	public partial class CatTool : System.Web.UI.Page
	{
		#region local-variables	
		private string _AppVers = string.Empty;
		private string _BuildNbr = "";
		private string _SiteURL = "";
		private CurrentUser _user = null;
		private CurrBrowserNoSess _Browser = null;
		private bool _CanEdit = false;
		private string _CBuildNbr = "";
		private DataTable _dtRows;
		private int _Excl0s = 0;
		private int _FontSz = 10;
		private bool _IsAdmin = false;
		private int _Narrow = 0;
		private int _NbrPages = 0;
		private int _PageID = 27;
		private int _PgNbr = 0;
		private int _PgSize = 20;
		private int _PrinterFriendly = 0;
		private int _ShowColorCol = 1;
		private int _ShowMgdCol = 1;
		private int _ShowSortCol = 1;
		private int _ShowNoPrintCol = 1;
		private int _SourceType = 0;
		private bool _ShowingCols = false;
		private bool _ShowingComments = false;
		private int _Sort = 0;
		private int _UserID = 0;
		private int _ViewMode = 0;
		private string _ErrMsg = string.Empty;

		//private string XReg = string.Empty;
		private string XLocID = string.Empty;
		private string XProduct = string.Empty;
		private string XSpecID = string.Empty;
		private string XThickness = string.Empty;
		private string XGradeID = string.Empty;
		private string XDesc = string.Empty;
		private string XColor = string.Empty;
		private string XSort = string.Empty;
		private string XRegion = string.Empty;
		private string XNoPrint = string.Empty;
		#endregion local-variables

		#region public-variables
		public string BuildNbr
		{
			get { return _BuildNbr; }
		}

		public string AppVersion
		{
			get { return _AppVers; }
		}

		public string SiteURL
		{
			get { return _SiteURL; }
		}

		public string UserName
		{
			get { return _user.FullName; }
		}
		public string ErrorMsg
		{
			get { return _ErrMsg; }
		}

		public int PgNbr
		{
			get { return _PgNbr; }
		}

		public int PgSize
		{
			get { return _PgSize; }
		}
		#endregion public-variables

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

			string UserName = Request.ServerVariables["LOGON_USER"];
			_SiteURL = System.Configuration.ConfigurationManager.AppSettings["SitePrefix"];
			_BuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
			_AppVers = System.Configuration.ConfigurationManager.AppSettings["AppVersion"].ToString() + " (" + System.Configuration.ConfigurationManager.AppSettings["AppVersionDate"].ToString() + ")";
			this.lblErrorMsg.Text = "";
			string usrname = "";
			string logFilePath = System.Configuration.ConfigurationManager.AppSettings["AppLogFilePath"].ToString();
			this.lblBuildNbr.Text = _BuildNbr.ToString();
			this.lblVersion.Text = System.Configuration.ConfigurationManager.AppSettings["AppVersion"].ToString();
			this.lblVersionDate.Text = System.Configuration.ConfigurationManager.AppSettings["AppVersionDate"].ToString();
			_Browser = new CurrBrowserNoSess(System.Web.HttpContext.Current.Request);
			_user = new CurrentUser(UserName, logFilePath, ""); // SessionHelper.GetCurrentUser(Request.ServerVariables["LOGON_USER"]);
			string ips = System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];

			if (_user == null || !_user.IsValid)
			{
				Logging.WriteToLog("Login failed for " + UserName + ".");
				HttpContext.Current.Response.Redirect("NoAcc/NoAccess.aspx", true);
			}

			// check for specific rights to cat tool
			if (_user.AccessRights < 2 && _user.CatToolRights == 0)
			{
				Session["NoAccessMsg"] = "You do not have access to the Cat Tool.";
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

			_UserID = Convert.ToInt32(_user.UserID);

			Commands cmd = new Commands();
			DataTable dt = new DataTable();

			if (!this.IsPostBack)
			{
				try
				{
					_ShowingCols = false;
					_ShowingComments = true;
					_PgNbr = 0;
					_PgSize = 20;
					_Sort = 0;
					_FontSz = 10;
					_Excl0s = 0;
					_Narrow = 0;
					_SourceType = 0;

					ResetFilterGroup();

					string tVal = "";
					DataTable uii = cmd.SelectUserInterfaceItems(_UserID, "CatGrid", _UserID);
					//SelectUserPageColSettings(int PgID, int ObjID, int UserID, string UIType, int ByID)
					for (int row = 0; row < uii.Rows.Count; row++)
					{
						tVal = uii.Rows[row]["sVisible"].ToString();
						switch (uii.Rows[row]["ItemName"].ToString())
						{
							case "Color":
								if (tVal != "Yes") {
									_ShowColorCol = 0;
									this.chkShowColorCol.Checked = false;
								}
								break;
							case "MGD":
								if (tVal != "Yes") {
									_ShowMgdCol = 0;
									this.chkShowManagedCol.Checked = false;
								}
								break;
							case "NoPrint":
								if (tVal != "Yes") {
									_ShowNoPrintCol = 0;
									this.chkShowNoPrintCol.Checked = false;
								}
								break;
							case "Sort":
								if (tVal != "Yes") {
									_ShowSortCol = 0;
									this.chkShowSortCol.Checked = false;
								}
								break;
							default:
								break;
						}
					}
					ViewState.Add("ShowMgdCol", _ShowMgdCol.ToString());
					ViewState.Add("ShowColorCol", _ShowColorCol.ToString());
					ViewState.Add("ShowSortCol", _ShowSortCol.ToString());
					ViewState.Add("ShowNoPrintCol", _ShowNoPrintCol.ToString());

					// load user tracks
					dt = cmd.SelectUserTracks(_UserID, _PageID, 0);
					if (dt.Rows.Count > 0)
					{
						this.txtProductS.Text = dt.Rows[0]["ProductCode"].ToString();
						this.txtDescriptionS.Text = dt.Rows[0]["ItemDescription"].ToString();
						this.ddlPageSize.SelectedValue = dt.Rows[0]["PgSize"].ToString();
						this.ddlSortF.SelectedValue = dt.Rows[0]["SortID"].ToString();
						_PgNbr = Convert.ToInt32(dt.Rows[0]["PgNbr"]);
						_PgSize = Convert.ToInt32(dt.Rows[0]["PgSize"]);
						_Sort = Convert.ToInt32(dt.Rows[0]["SortID"]);
						if (dt.Rows[0]["sShowWks"].ToString() == "Yes") { _ShowingCols = true; }
						if (dt.Rows[0]["sHideComments"].ToString() == "Yes") { _ShowingComments = true; }
						if (dt.Rows[0]["sExclude0s"].ToString() == "Yes") { _Excl0s = 1; }
						this.gvCatData.PageSize = _PgSize;
						this.gvCatData.PageIndex = _PgNbr;
						_FontSz = Convert.ToInt32(dt.Rows[0]["FontSize"]);
						XLocID = dt.Rows[0]["LocationCode"].ToString();
						XProduct = dt.Rows[0]["ProductCode"].ToString();
					}
					this.ddlSortF.SelectedValue = _Sort.ToString();

					// Adds the date header to the QTY columns, have to do the calculations and than convert to string
					//--------------
					var monday1 = DateTime.Now.AddDays(-(int)DateTime.Now.DayOfWeek + 5); //1 8 15 22 29 36 43 50 57 64 71 78 85
					var format1 = monday1.ToString("yyyy-MM-dd");
					var monday2 = DateTime.Now.AddDays(-(int)DateTime.Now.DayOfWeek + 12);
					var format2 = monday2.ToString("yyyy-MM-dd");
					var monday3 = DateTime.Now.AddDays(-(int)DateTime.Now.DayOfWeek + 19);
					var format3 = monday3.ToString("yyyy-MM-dd");
					var monday4 = DateTime.Now.AddDays(-(int)DateTime.Now.DayOfWeek + 26);
					var format4 = monday4.ToString("yyyy-MM-dd");
					var monday5 = DateTime.Now.AddDays(-(int)DateTime.Now.DayOfWeek + 33);
					var format5 = monday5.ToString("yyyy-MM-dd");
					var monday6 = DateTime.Now.AddDays(-(int)DateTime.Now.DayOfWeek + 40);
					var format6 = monday6.ToString("yyyy-MM-dd");
					var monday7 = DateTime.Now.AddDays(-(int)DateTime.Now.DayOfWeek + 47);
					var format7 = monday7.ToString("yyyy-MM-dd");
					var monday8 = DateTime.Now.AddDays(-(int)DateTime.Now.DayOfWeek + 54);
					var format8 = monday8.ToString("yyyy-MM-dd");
					var monday9 = DateTime.Now.AddDays(-(int)DateTime.Now.DayOfWeek + 61);
					var format9 = monday9.ToString("yyyy-MM-dd");
					var monday10 = DateTime.Now.AddDays(-(int)DateTime.Now.DayOfWeek + 68);
					var format10 = monday10.ToString("yyyy-MM-dd");
					var monday11 = DateTime.Now.AddDays(-(int)DateTime.Now.DayOfWeek + 75);
					var format11 = monday11.ToString("yyyy-MM-dd");
					var monday12 = DateTime.Now.AddDays(-(int)DateTime.Now.DayOfWeek + 82);
					var format12 = monday12.ToString("yyyy-MM-dd");
					var monday13 = DateTime.Now.AddDays(-(int)DateTime.Now.DayOfWeek + 89);
					var format13 = monday13.ToString("yyyy-MM-dd");
					//var monday14 = DateTime.Now.AddDays(-(int)DateTime.Now.DayOfWeek + 96);
					//var format14 = monday13.ToString("yyyy-MM-dd");

					gvCatData.Columns[9].HeaderText = format1;
					gvCatData.Columns[10].HeaderText = format2;
					gvCatData.Columns[11].HeaderText = format3;
					gvCatData.Columns[12].HeaderText = format4;
					gvCatData.Columns[13].HeaderText = format5;
					gvCatData.Columns[14].HeaderText = format6;
					gvCatData.Columns[15].HeaderText = format7;
					gvCatData.Columns[16].HeaderText = format8;
					gvCatData.Columns[17].HeaderText = format9;
					gvCatData.Columns[18].HeaderText = format10;
					gvCatData.Columns[19].HeaderText = format11;
					gvCatData.Columns[20].HeaderText = format12;
					gvCatData.Columns[21].HeaderText = format13;
					//gvCatData.Columns[22].HeaderText = format14;

					this.BindDataGrid(1);

					if (_ShowingCols == true)
					{
						ViewState.Add("ShowingCols", "1");
					}
					else
					{
						ViewState.Add("ShowingCols", "0");
					}
					if (_ShowingComments == true)
					{
						ViewState.Add("ShowingComments", "1");
					}
					else
					{
						ViewState.Add("ShowingComments", "0");
					}
					ViewState.Add("PgNbr", _PgNbr.ToString());
					ViewState.Add("PgSize", _PgSize.ToString());
					ViewState.Add("NbrPages", _NbrPages.ToString());
					ViewState.Add("XSpecID", "");
					//ViewState.Add("XReg", XReg);
					ViewState.Add("XLocID", XLocID);
					ViewState.Add("XProduct", XProduct);
					ViewState.Add("XThickness", XThickness);
					ViewState.Add("XGradeID", XGradeID);
					ViewState.Add("XDesc", XDesc);
					ViewState.Add("GridSort", _Sort.ToString());
					ViewState.Add("FontSize", _FontSz.ToString());
					ViewState.Add("Excl0s", _Excl0s.ToString());
					ViewState.Add("XRegion", XRegion.ToString());
					ViewState.Add("XNoPrint", XNoPrint.ToString());
					ViewState.Add("NarrowView", _Narrow.ToString());
					ViewState.Add("PrinterFriendly", _PrinterFriendly.ToString());
					ViewState.Add("ViewMode", "0");
					ViewState.Add("SourceType", "0");
				}
				catch (Exception ex)
				{
					this._ErrMsg = "Initial data Load encountered an error: " + ex.Message;
					this.lblErrorMsg.Text = this._ErrMsg;
				}
			}
			else
			{
				//is postback - SET VIEWSTATE DATA
				int sc = Convert.ToInt32(ViewState["ShowingCols"]);
				if (sc == 1)
				{
					_ShowingCols = true;
				}
				else
				{
					_ShowingCols = false;
				}
				sc = Convert.ToInt32(ViewState["ShowingComments"]);
				if (sc == 1)
				{
					_ShowingComments = true;
				}
				else
				{
					_ShowingComments = false;
				}
				_PgNbr = Convert.ToInt32(ViewState["PgNbr"]);
				_PgSize = Convert.ToInt32(ViewState["PgSize"]);
				_Sort = Convert.ToInt32(ViewState["GridSort"]);
				XSpecID = ViewState["XSpecID"].ToString();
				//XReg = ViewState["XReg"].ToString();
				XLocID = ViewState["XLocID"].ToString();
				XProduct = ViewState["XProduct"].ToString();
				XThickness = ViewState["XThickness"].ToString();
				XGradeID = ViewState["XGradeID"].ToString();
				XDesc = ViewState["XDesc"].ToString();
				XProduct = ViewState["XProduct"].ToString();
				XRegion = ViewState["XRegion"].ToString();
				XNoPrint = ViewState["XNoPrint"].ToString();
				_FontSz = Convert.ToInt32(ViewState["FontSize"]);
				_Excl0s = Convert.ToInt32(ViewState["Excl0s"]);
				_NbrPages = Convert.ToInt32(ViewState["NbrPages"]);
				_Narrow = Convert.ToInt32(ViewState["NarrowView"]);
				_PrinterFriendly = Convert.ToInt32(ViewState["PrinterFriendly"]);
				_ViewMode = Convert.ToInt32(ViewState["ViewMode"]);
				_SourceType = Convert.ToInt32(ViewState["SourceType"]);
				_ShowMgdCol = Convert.ToInt32(ViewState["ShowMgdCol"]);
				_ShowColorCol = Convert.ToInt32(ViewState["ShowColorCol"]);
				_ShowSortCol = Convert.ToInt32(ViewState["ShowSortCol"]);
				_ShowNoPrintCol = Convert.ToInt32(ViewState["ShowNoPrintCol"]);
			}
			//string jsScript = "";
			//jsScript = "<script type=\"text/javascript\">var jigEmpID=" + _user.EmpID.ToString() + ";var jsgBrowserType='" + _Browser.BrowserType.ToString() + "';var jsgAr=" + _user.AccessRights.ToString() + ";</script>";
			//Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "MyTargetVariables", jsScript);

			//this.divLoadingGif.Style["display"] = "none";
		}

		private void BindDataGrid(int IsInitial)
		{
			this.lblErrorMsg.Text = "";
			bool StopAction = false;
			string Reg = String.Empty;
			string LocID = String.Empty;
			string Product = String.Empty;
			string SpecID = String.Empty;
			string Thickness = String.Empty;
			string GradeID = String.Empty;
			string Desc = String.Empty;
			string Color = String.Empty;
			string fSort = String.Empty;
			string Region = String.Empty;
			string NoPrint = String.Empty;
			int Excl0 = 0;
			int Sort = 0;
			try
			{
				LocID = "";
				foreach (System.Web.UI.WebControls.ListItem itm in this.lbxLocationF.Items)
				{
					if (itm.Selected)
					{
						if (LocID.Length > 0) { LocID = LocID + ','; }
						LocID = LocID + GenUtilities.SanatizeStringData(itm.Value);
					}
				}
				SpecID = "";
				foreach (System.Web.UI.WebControls.ListItem itm in this.lbxSpeciesF.Items)
				{
					if (itm.Selected)
					{
						if (SpecID.Length > 0) { SpecID = SpecID + ','; }
						SpecID = SpecID + GenUtilities.SanatizeStringData(itm.Value);
					}
				}
				Thickness = "";
				foreach (System.Web.UI.WebControls.ListItem itm in this.lbxThicknessF.Items)
				{
					if (itm.Selected)
					{
						if (Thickness.Length > 0) { Thickness = Thickness + ','; }
						Thickness = Thickness + GenUtilities.SanatizeStringData(itm.Value);
					}
				}
				GradeID = "";
				foreach (System.Web.UI.WebControls.ListItem itm in this.lbxGradeF.Items)
				{
					if (itm.Selected)
					{
						if (GradeID.Length > 0) { GradeID = GradeID + ','; }
						GradeID = GradeID + GenUtilities.SanatizeStringData(itm.Value);
					}
				}
				Color = "";
				foreach (System.Web.UI.WebControls.ListItem itm in this.lbxColorF.Items)
				{
					if (itm.Selected)
					{
						if (Color.Length > 0) { Color = Color + ','; }
						Color = Color + GenUtilities.SanatizeStringData(itm.Value);
					}
				}
				fSort = "";
				foreach (System.Web.UI.WebControls.ListItem itm in this.lbxSortF.Items)
				{
					if (itm.Selected)
					{
						if (fSort.Length > 0) { fSort = fSort + ','; }
						fSort = fSort + GenUtilities.SanatizeStringData(itm.Value);
					}
				}
				Region = "";
				foreach (System.Web.UI.WebControls.ListItem itm in this.lbxRegionF.Items)
				{
					if (itm.Selected)
					{
						if (Region.Length > 0) { Region = Region + ','; }
						Region = Region + GenUtilities.SanatizeStringData(itm.Value);
					}
				}
				NoPrint = "";
				foreach (System.Web.UI.WebControls.ListItem itm in this.lbxNoPrintF.Items)
				{
					if (itm.Selected)
					{
						if (NoPrint.Length > 0) { NoPrint = NoPrint + ','; }
						NoPrint = NoPrint + GenUtilities.SanatizeStringData(itm.Value);
					}
				}
				Product = this.txtProductS.Text;
				Desc = this.txtDescriptionS.Text;
				Sort = Convert.ToInt32(ddlSortF.SelectedValue);
				if (chkExclude0.Checked == true) { Excl0 = 1; }

				// replace dangerous characters in strings
				Product = GenUtilities.SanatizeStringData(Product);
				Desc = GenUtilities.SanatizeStringData(Desc);

				// Check to see if any changed, if so, set page = 0
				if (LocID != XLocID)
				{
					_PgNbr = 0;
					gvCatData.PageIndex = 0;
					XLocID = LocID;
					ViewState["XLocID"] = XLocID;
				}

				if (Product != XProduct)
				{
					_PgNbr = 0;
					gvCatData.PageIndex = 0;
					XProduct = Product;
					ViewState["XProduct"] = XProduct;
				}
				if (SpecID != XSpecID)
				{
					_PgNbr = 0;
					gvCatData.PageIndex = 0;
					XSpecID = SpecID;
					ViewState["XSpecID"] = XSpecID;
				}
				if (Thickness != XThickness)
				{
					_PgNbr = 0;
					gvCatData.PageIndex = 0;
					XThickness = Thickness;
					ViewState["XThickness"] = XThickness;
				}
				if (GradeID != XGradeID)
				{
					_PgNbr = 0;
					gvCatData.PageIndex = 0;
					XGradeID = GradeID;
					ViewState["XGradeID"] = XGradeID;
				}
				if (Desc != XDesc)
				{
					_PgNbr = 0;
					gvCatData.PageIndex = 0;
					XDesc = Desc;
					ViewState["XDesc"] = XDesc;
				}
				if (NoPrint == "0") { NoPrint = ""; }
				if (XNoPrint == "0") { XNoPrint = ""; }
				if (NoPrint != XNoPrint)
				{
					_PgNbr = 0;
					gvCatData.PageIndex = 0;
					XGradeID = GradeID;
					ViewState["XNoPrint"] = XNoPrint;
				}
				if (Region == "0") { Region = ""; }
				if (XRegion == "0") { XRegion = ""; }
				if (Region != XRegion)
				{
					_PgNbr = 0;
					gvCatData.PageIndex = 0;
					XRegion = Region;
					ViewState["XRegion"] = XRegion;
				}
				ViewState["PgNbr"] = _PgNbr.ToString();
				ViewState["PgSize"] = _PgSize.ToString();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Extracting filter data error: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
				StopAction = true;
			}
			if (StopAction == false)
			{
				try
				{
					if (Region.Length > 2 && Region.Substring(0, 2) == "0,")
					{
						Region = Region.Substring(2);
					}
					if (LocID.Length > 2 && LocID.Substring(0, 2) == "0,")
					{
						LocID = LocID.Substring(2);
					}
					if (SpecID.Length > 2 && SpecID.Substring(0, 2) == "0,")
					{
						SpecID = SpecID.Substring(2);
					}
					if (Thickness.Length > 2 && Thickness.Substring(0, 2) == "0,")
					{
						Thickness = Thickness.Substring(2);
					}
					if (GradeID.Length > 2 && GradeID.Substring(0, 2) == "0,")
					{
						GradeID = GradeID.Substring(2);
					}

					_Excl0s = Excl0;

					if (_Narrow == 1)
					{
						gvCatData.Columns[8].Visible = false;
						gvCatData.Columns[7].Visible = true;
					}
					else
					{
						gvCatData.Columns[8].Visible = true;
						gvCatData.Columns[7].Visible = false;
					}

					//string ColsOn = "XXXXXXXXXX";
					StringBuilder sb = new StringBuilder();
					sb.Append("XXX");
					if (_ShowMgdCol != 1)
					{
						sb.Append("0");
						gvCatData.Columns[3].Visible = false;
					}
					else
					{
						gvCatData.Columns[3].Visible = true;
						sb.Append("X");
					}
					if (_ShowColorCol != 1)
					{
						sb.Append("0");
						gvCatData.Columns[4].Visible = false;
					}
					else
					{
						sb.Append("X");
						gvCatData.Columns[4].Visible = true;
					}
					if (_ShowSortCol != 1)
					{
						sb.Append("0");
						gvCatData.Columns[5].Visible = false;
					}
					else
					{
						sb.Append("X");
						gvCatData.Columns[5].Visible = true;
					}
					if (_ShowNoPrintCol != 1)
					{
						sb.Append("0");
						gvCatData.Columns[6].Visible = false;
					}
					else
					{
						sb.Append("X");
						gvCatData.Columns[6].Visible = true;
					}
					sb.Append("XXX");

					CatToolFunctions ct = new CatToolFunctions();
					DataTable dt2 = new DataTable();
					// Get grid data
					if (_SourceType == 0)
					{
						dt2 = ct.GetCatToolGridData(Region, LocID, Product, SpecID, Thickness, GradeID, "", Color, fSort, "", NoPrint, Desc, Excl0, Sort, 1, 0, sb.ToString(), 0, 20000, _UserID);
					}
					else
					{
						dt2 = ct.GetCatToolGridDataSvc(Region, LocID, Product, SpecID, Thickness, GradeID, "", Color, fSort, "", NoPrint, Desc, Excl0, Sort, 1, 0, sb.ToString(), 0, 20000, _UserID);
					}

					gvCatData.DataSource = dt2;
					gvCatData.DataBind();
					_NbrPages = gvCatData.PageCount;
					ViewState["NbrPages"] = _NbrPages;

					if (_PrinterFriendly == 0)
					{
						gvCatData.BottomPagerRow.Visible = true;
					}
					else
					{
						gvCatData.BottomPagerRow.Visible = false;
					}

					if (dt2.Rows.Count > 0 && _PrinterFriendly == 0)
					{
						this.divBottomBtn.Style["display"] = "block";
					}
				}
				catch (Exception ex)
				{
					this._ErrMsg = "Loading Data Grid error: " + ex.Message;
					this.lblErrorMsg.Text = this._ErrMsg;
				}

				try
				{
					// save user tracks
					if (IsInitial == 0)
					{
						int ShowWks = 0;
						int HideComments = 0;
						CatToolFunctions ct2 = new CatToolFunctions();
						if (_ShowingCols == true) { ShowWks = 1; }
						if (_ShowingComments == false) { HideComments = 1; }
						DataTable dt3 = new DataTable();
						dt3 = ct2.UpdateCatUserTracks(_PageID, 0, Region, LocID, SpecID, Thickness, GradeID, "", Color, fSort, "", "", Product, Desc, ShowWks, HideComments, Excl0, _FontSz, "", "", "", "", "", "", _Sort, _PgNbr, _PgSize, _UserID);
					}
				}
				catch (Exception ex)
				{
					this._ErrMsg = "Saving user tracks error: " + ex.Message;
					this.lblErrorMsg.Text = this._ErrMsg;
				}
			}
		}

		public void LoadSpeciesList()
		{
			try
			{
				this.lblErrorMsg.Text = "";
				//CatToolFunctions ctf = new CatToolFunctions();
				//DataTable dt = ctf.GetCatCodeList("Species", 0, 1, 1, 1, 1, _UserID);
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectProductCodeList("Species", 0, 1, 0, 0, 0, _UserID);
				this.lbxSpeciesF.DataTextField = "CodeDescription";
				this.lbxSpeciesF.DataValueField = "CatCode";
				this.lbxSpeciesF.DataSource = dt;
				this.lbxSpeciesF.DataBind();
				this.lbxSpeciesF.SelectedValue = "0";
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Species: " + ex.Message;
				this.lblErrorMsg.Text = this.ErrorMsg;
			}
		}

		public void LoadLocationsList()
		{
			try
			{
				DataTable dt;
				this.lblErrorMsg.Text = "";
				Commands cmd = new Commands();
				if (_SourceType == 0)
				{
					dt = cmd.SelectProductCodeList("Location", 0, 1, 0, 0, _ViewMode, _UserID);
					this.lbxLocationF.DataTextField = "CodeDescription";
					this.lbxLocationF.DataValueField = "CatCode";
				}
				else
				{
					dt = cmd.SelectLocationListGlobal("", "", "", "", 0, 3, 1, _UserID);
					this.lbxLocationF.DataTextField = "Name";
					this.lbxLocationF.DataValueField = "loc";
				}
				this.lbxLocationF.DataSource = dt;
				this.lbxLocationF.DataBind();
				this.lbxLocationF.SelectedIndex = 0;
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Locations: " + ex.Message;
				this.lblErrorMsg.Text = this.ErrorMsg;
			}
		}

		public void LoadThicklistList()
		{
			try
			{
				this.lblErrorMsg.Text = "";
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectProductCodeList("Thickness", 0, 1, 0, 0, 0, _UserID);
				//CatToolFunctions ctf = new CatToolFunctions();
				//DataTable dt = ctf.GetCatCodeList("Thickness", 0, 1, 1, 1, 1, _UserID);
				this.lbxThicknessF.DataTextField = "CodeDescription";
				this.lbxThicknessF.DataValueField = "CatCode";
				this.lbxThicknessF.DataSource = dt;
				this.lbxThicknessF.DataBind();
				this.lbxThicknessF.SelectedIndex = 0;
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Thickness: " + ex.Message;
				this.lblErrorMsg.Text = this.ErrorMsg;
			}
		}

		public void LoadGradeList()
		{
			try
			{
				this.lblErrorMsg.Text = "";
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectProductCodeList("Grade", 0, 1, 0, 0, 0, _UserID);
				this.lbxGradeF.DataTextField = "CodeDescComposite";
				this.lbxGradeF.DataValueField = "CatCode";
				this.lbxGradeF.DataSource = dt;
				this.lbxGradeF.DataBind();
				this.lbxGradeF.SelectedIndex = 0;
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Grade: " + ex.Message;
				this.lblErrorMsg.Text = this.ErrorMsg;
			}
		}

		public void LoadColorList()
		{
			try
			{
				this.lblErrorMsg.Text = "";
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectProductCodeList("Color", 0, 1, 0, 0, 0, _UserID);
				//CatToolFunctions ctf = new CatToolFunctions();
				//DataTable dt = ctf.GetCatCodeList("Color", 0, 1, 1, 1, 1, _UserID);
				this.lbxColorF.DataTextField = "CodeDescription";
				this.lbxColorF.DataValueField = "CatCode";
				this.lbxColorF.DataSource = dt;
				this.lbxColorF.DataBind();
				this.lbxColorF.SelectedIndex = 0;
			}
			catch (Exception ex)
			{
				_ErrMsg = "Color: " + ex.Message;
				this.lblErrorMsg.Text = this.ErrorMsg;
			}
		}

		public void LoadSortList()
		{
			try
			{
				this.lblErrorMsg.Text = "";
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectProductCodeList("Sort", 0, 1, 0, 0, 0, _UserID);
				this.lbxSortF.DataTextField = "CodeDescription";
				this.lbxSortF.DataValueField = "CatCode";
				this.lbxSortF.DataSource = dt;
				this.lbxSortF.DataBind();
				this.lbxSortF.SelectedIndex = 0;
			}
			catch (Exception ex)
			{
				_ErrMsg = "Sort: " + ex.Message;
				this.lblErrorMsg.Text = this.ErrorMsg;
			}
		}

		protected string DecodeHTMLInString(string val)
		{
			string newval = val.Replace("&amp;", "&");


			return newval;
		}

		/// <summary>
		/// Handles special casting on data row after bound
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void gvCatData_RowDataBound(object sender, GridViewRowEventArgs e)
		{
			this.lblErrorMsg.Text = "";
			double Qty1 = 0;
			double Qty2 = 0;
			string s = string.Empty;
			string Tracked = string.Empty;
			GridViewRow currRow;
			DataRowView datrow = e.Row.DataItem as DataRowView;

			if (e.Row.RowType == DataControlRowType.DataRow)
			{
				try
				{
					Tracked = datrow["sIsTracked"].ToString();
					currRow = e.Row;
					currRow.Cells[23].Text = DecodeHTMLInString(currRow.Cells[23].Text);
					// Set narrow view
					//if (_Narrow == 1)
					//{
					//	currRow.Cells[7].Text = datrow["Product"].ToString();
					//}
					for (int rwz = 9; rwz <= 21; rwz++)
					{
						Qty1 = Convert.ToDouble(datrow["Week" + (rwz - 8).ToString() + "Qty"]);
						if (rwz == 21)
						{
							Qty2 = 9999;
						}
						else
						{
							Qty2 = Convert.ToDouble(datrow["Week" + (rwz - 7).ToString() + "Qty"]);
						}
						if (Qty1 > Qty2)
						{
							currRow.Cells[rwz].BackColor = Color.MistyRose;
						}
						else
						{
							if (Tracked == "Yes")
							{
								currRow.Cells[rwz].BackColor = Color.PaleTurquoise;
							}
							else
							{
								currRow.Cells[rwz].BackColor = Color.White;
							}
						}
						if (_Narrow == 1)
						{
							//Product, Wk1Date, ProdType, Length, Color, Sort, Milling, NoPrint, PListID
							s = "<a href='pProductDetails.aspx?p=" + datrow["Product"].ToString() + "&d=" + datrow["Wk" + (rwz - 8).ToString() + "Date"].ToString() + "&pt=" + datrow["ProdType"].ToString() + "&ln=" + datrow["Length"].ToString();
							s = s + "&c=" + datrow["Color"].ToString() + "&st=" + datrow["Sort"].ToString() + "&m=" + datrow["Milling"].ToString() + "&np=" + datrow["NoPrint"].ToString() + "&w = 1&mid" + datrow["PListID"].ToString() + "'>";
							s = s + GenUtilities.FormatNbrSpecial(Qty1, "", 0, "", ".", 1) + "</a>";
							currRow.Cells[rwz].Text = s;
						}
					}

				}
				catch (Exception ex4)
				{
					_ErrMsg = "Row Data Bound-CellColor: " + ex4.Message;
					this.lblErrorMsg.Text = _ErrMsg;
				}
			}
		}

		public void gvCatData_PageIndexChanging(object sender, GridViewPageEventArgs e)
		{
			gvCatData.PageIndex = e.NewPageIndex;
			_PgNbr = e.NewPageIndex;
			//this.gvCatData.DataBind();
			BindDataGrid(0);
		}

		protected void btnEmailPDF_Click(object sender, EventArgs e)
		{
			ExportGridToPDF();
		}

		protected void btnExcelCopy_Click(object sender, EventArgs e)
		{
			ExportToExcel(sender, e);
		}

		protected void btnRefreshData_Click(object sender, EventArgs e)
		{
			_PgNbr = 0;
			gvCatData.PageIndex = 0;
			BindDataGrid(0);
		}

		/// <summary>
		/// Hide or show more than 3 week totals
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			try
			{
				// update toggle value
				if (this.CheckBox1.Checked == true)
				{
					_ShowingCols = true;
					ViewState["ShowingCols"] = "1";
				}
				else
				{
					_ShowingCols = false;
					ViewState["ShowingCols"] = "0";
				}

				//Show or hide Forecasted Weeks
				for (int i2 = 7; i2 <= 19; i2++)
				{
					if (_ShowingCols == false)
					{
						gvCatData.Columns[i2].Visible = false;
					}
					else
					{
						gvCatData.Columns[i2].Visible = true;
					}
				}
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error in toggling column visibility: " + ex.Message;
			}
		}

		/// <summary>
		/// Hide or show comments columns
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void CheckBox2_CheckedChanged(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			if (this.CheckBox2.Checked == true)
			{
				_ShowingComments = false;
				ViewState["ShowingComments"] = "0";
				gvCatData.Columns[22].Visible = false;
			}
			else
			{
				_ShowingComments = true;
				ViewState["ShowingComments"] = "1";
				gvCatData.Columns[22].Visible = true;
			}
		}

		/// <summary>
		/// Sets font size 1 pt lower
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void Button1_Click(object sender, EventArgs e)
		{
			int currentSize = Convert.ToInt32(gvCatData.Font.Size.ToString().Replace("pt", ""));
			_FontSz = currentSize - 1;
			gvCatData.Font.Size = _FontSz;
			this.BindDataGrid(0);
			ViewState["FontSize"] = _FontSz.ToString();
		}

		/// <summary>
		/// Sets font size 1 pt higher
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void Button2_Click(object sender, EventArgs e)
		{
			int currentSize = Convert.ToInt32(gvCatData.Font.Size.ToString().Replace("pt", ""));
			_FontSz = currentSize + 1;
			gvCatData.Font.Size = _FontSz;
			this.BindDataGrid(0);
			ViewState["FontSize"] = _FontSz.ToString();
		}

		/// <summary>
		/// Reset gridview attributes to default
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void Button3_Click(object sender, EventArgs e)
		{
			// reset
			gvCatData.Font.Size = 10;
			//Hide Comments:
			for (int i = 0; i < gvCatData.Rows.Count - 1; i++)
			{
				gvCatData.Rows[i].Cells[23].Style["display"] = "table-cell";
				for (int i2 = 9; i2 <= 21; i2++)
				{
					gvCatData.Rows[i].Cells[i2].Style["display"] = "table-cell";
				}
			}
		}

		protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
		{
			_PgSize = Convert.ToInt32(this.ddlPageSize.SelectedValue);
			_PgNbr = 0;
			gvCatData.PageIndex = _PgNbr;
			gvCatData.PageSize = _PgSize;
			//this.gvCatData.DataBind();
			BindDataGrid(0);
		}

		/// <summary>
		/// Encode dangerous text for transfer in URL
		/// </summary>
		/// <param name="val"></param>
		/// <returns></returns>
		private string FixRequestValues(string val)
		{
			string nval = val;
			nval = val.Replace("#", "_2");
			nval = val.Replace("/", "|");
			nval = val.Replace("-", "_1");
			nval = val.Replace("\"", "_3");
			nval = val.Replace("\\", "_4");
			nval = val.Replace("'", ""); //remove single spaces entirely
			return nval;
		}

		protected void ExportToExcel(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			try
			{
				string FileName = "CAT_Availability_";
				DateTime now = DateTime.Now;
				FileName = FileName + now.ToString("MM_dd_yyyy");

				CatToolFunctions ct = new CatToolFunctions();
				string Reg = string.Empty; // this.lbxRegionF.SelectedValue;
				string LocID = String.Empty;
				string Product = String.Empty;
				string SpecID = String.Empty;
				string Thickness = String.Empty;
				string GradeID = String.Empty;
				string Color = String.Empty;
				string fSort = String.Empty;
				string Region = String.Empty;
				string Desc = this.txtDescriptionS.Text;
				try
				{
					LocID = "";
					foreach (System.Web.UI.WebControls.ListItem itm in this.lbxLocationF.Items)
					{
						if (itm.Selected)
						{
							if (LocID.Length > 0) { LocID = LocID + ','; }
							LocID = LocID + GenUtilities.SanatizeStringData(itm.Value);
						}
					}
					SpecID = "";
					foreach (System.Web.UI.WebControls.ListItem itm in this.lbxSpeciesF.Items)
					{
						if (itm.Selected)
						{
							if (SpecID.Length > 0) { SpecID = SpecID + ','; }
							SpecID = SpecID + GenUtilities.SanatizeStringData(itm.Value);
						}
					}
					Thickness = "";
					foreach (System.Web.UI.WebControls.ListItem itm in this.lbxThicknessF.Items)
					{
						if (itm.Selected)
						{
							if (Thickness.Length > 0) { Thickness = Thickness + ','; }
							Thickness = Thickness + GenUtilities.SanatizeStringData(itm.Value);
						}
					}
					GradeID = "";
					foreach (System.Web.UI.WebControls.ListItem itm in this.lbxGradeF.Items)
					{
						if (itm.Selected)
						{
							if (GradeID.Length > 0) { GradeID = GradeID + ','; }
							GradeID = GradeID + GenUtilities.SanatizeStringData(itm.Value);
						}
					}
					Color = "";
					foreach (System.Web.UI.WebControls.ListItem itm in this.lbxColorF.Items)
					{
						if (itm.Selected)
						{
							if (Color.Length > 0) { Color = Color + ','; }
							Color = Color + GenUtilities.SanatizeStringData(itm.Value);
						}
					}
					fSort = "";
					foreach (System.Web.UI.WebControls.ListItem itm in this.lbxSortF.Items)
					{
						if (itm.Selected)
						{
							if (fSort.Length > 0) { fSort = fSort + ','; }
							fSort = fSort + GenUtilities.SanatizeStringData(itm.Value);
						}
					}
					Region = "";
					foreach (System.Web.UI.WebControls.ListItem itm in this.lbxRegionF.Items)
					{
						if (itm.Selected)
						{
							if (Region.Length > 0) { Region = Region + ','; }
							Region = Region + GenUtilities.SanatizeStringData(itm.Value);
						}
					}
				}
				catch (Exception ex)
				{
					this._ErrMsg = "Loading Data Grid error: " + ex.Message;
					this.lblErrorMsg.Text = this._ErrMsg;
				}

				int NbrCols = 24;
				if (_ShowColorCol == 0) { NbrCols--; }
				if (_ShowSortCol == 0) { NbrCols--; }
				if (_ShowNoPrintCol == 0) { NbrCols--; }
				if (_ShowMgdCol == 0) { NbrCols--; }
				float[] widths = new float[NbrCols];
				// specie, thickness grade, mgd, color, sort, noprint, PRODUCT, wk1, wk2, wk3, wk4, wk5, wk6, wk7, wk8, wk9, wk10, wk11, wk12, wk13, listprice, comments
				int c = 0;
				Commands cmd = new Commands();
				DataTable dt2 = cmd.SelectUIColumnData(27, 1, _UserID);
				if (dt2.Rows.Count > 0)
				{
					for (int row = 0; row < dt2.Rows.Count; row++)
					{
						if (row < NbrCols)
						{
							if (row < 3 || (row == 3 && _ShowMgdCol == 0) || (row == 4 && _ShowColorCol == 1) || (row == 5 && _ShowSortCol == 1) || (row == 6 && _ShowNoPrintCol == 1) || row > 6)
							{
								widths[c] = Convert.ToInt32(dt2.Rows[row]["ColumnWidth"]);
								c++;
							}
						}
					}
				}
				else
				{
					widths = new float[] { 76, 76, 80, 74, 40, 72, 72, 76, 60, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 72, 136 };
				}

				// Get grid data
				DataTable dt = ct.GetCatToolGridDataExport(Region, LocID, Product, SpecID, Thickness, GradeID, "", Color, fSort, "", "", Desc, 0, 1, 1, _user.UserID);
				string tab = "";
				Response.Clear();
				Response.Buffer = true;
				Response.AddHeader("content-disposition", "attachment;filename=" + FileName + ".xls");
				Response.Charset = "";
				Response.ContentType = "application/vnd.ms-excel";
				c = 0;
				foreach (DataColumn dc in dt.Columns)
				{
					if (c < 3 || (c == 3 && _ShowMgdCol == 1) || (c == 4 && _ShowColorCol == 1) || (c == 5 && _ShowSortCol == 1) || (c == 6 && _ShowNoPrintCol == 1) || c > 6)
					{
						Response.Write(tab + dc.ColumnName);
						tab = "\t";
					}
					c++;
				}
				Response.Write("\n");
				foreach (DataRow dr in dt.Rows)
				{
					tab = "";
					for (int col = 0; col < dt.Columns.Count; col++)
					{
						// write line if column is shown
						if (col < 3 || (col==3 && _ShowMgdCol==1) || (col==4 && _ShowColorCol == 1) || (col == 5 && _ShowSortCol == 1) || (col == 6 && _ShowNoPrintCol == 1) || col > 6) {
							Response.Write(tab + dr[col].ToString());
							tab = "\t";
						}
					}
					Response.Write("\n");
				}
				Response.Flush();
				Response.End();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error while exporting to Excel: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		private void ExportGridToPDF()
		{
			this.lblErrorMsg.Text = "";
			try
			{
				CatToolFunctions ct = new CatToolFunctions();
				string Reg = string.Empty; // this.lbxRegionF.SelectedValue;
				string LocID = string.Empty;
				string Product = string.Empty;
				string SpecID = string.Empty;
				string Thickness = string.Empty;
				string GradeID = string.Empty;
				string Color = string.Empty;
				string fSort = string.Empty;
				string NoPrint = string.Empty;
				string Region = string.Empty;
				string Desc = this.txtDescriptionS.Text;
				int RowCount = 0;
				try
				{
					LocID = "";
					foreach (System.Web.UI.WebControls.ListItem itm in this.lbxLocationF.Items)
					{
						if (itm.Selected)
						{
							if (LocID.Length > 0) { LocID = LocID + ','; }
							LocID = LocID + GenUtilities.SanatizeStringData(itm.Value);
						}
					}
					SpecID = "";
					foreach (System.Web.UI.WebControls.ListItem itm in this.lbxSpeciesF.Items)
					{
						if (itm.Selected)
						{
							if (SpecID.Length > 0) { SpecID = SpecID + ','; }
							SpecID = SpecID + GenUtilities.SanatizeStringData(itm.Value);
						}
					}
					Thickness = "";
					foreach (System.Web.UI.WebControls.ListItem itm in this.lbxThicknessF.Items)
					{
						if (itm.Selected)
						{
							if (Thickness.Length > 0) { Thickness = Thickness + ','; }
							Thickness = Thickness + GenUtilities.SanatizeStringData(itm.Value);
						}
					}
					GradeID = "";
					foreach (System.Web.UI.WebControls.ListItem itm in this.lbxGradeF.Items)
					{
						if (itm.Selected)
						{
							if (GradeID.Length > 0) { GradeID = GradeID + ','; }
							GradeID = GradeID + GenUtilities.SanatizeStringData(itm.Value);
						}
					}
					Color = "";
					foreach (System.Web.UI.WebControls.ListItem itm in this.lbxColorF.Items)
					{
						if (itm.Selected)
						{
							if (Color.Length > 0) { Color = Color + ','; }
							Color = Color + GenUtilities.SanatizeStringData(itm.Value);
						}
					}
					fSort = "";
					foreach (System.Web.UI.WebControls.ListItem itm in this.lbxSortF.Items)
					{
						if (itm.Selected)
						{
							if (fSort.Length > 0) { fSort = fSort + ','; }
							fSort = fSort + GenUtilities.SanatizeStringData(itm.Value);
						}
					}
					NoPrint = "";
					foreach (System.Web.UI.WebControls.ListItem itm in this.lbxNoPrintF.Items)
					{
						if (itm.Selected)
						{
							if (NoPrint.Length > 0) { NoPrint = NoPrint + ','; }
							NoPrint = NoPrint + GenUtilities.SanatizeStringData(itm.Value);
						}
					}
					Region = "";
					foreach (System.Web.UI.WebControls.ListItem itm in this.lbxRegionF.Items)
					{
						if (itm.Selected)
						{
							if (Region.Length > 0) { Region = Region + ','; }
							Region = Region + GenUtilities.SanatizeStringData(itm.Value);
						}
					}
				}
				catch (Exception ex)
				{
					this._ErrMsg = "Loading Data Grid error: " + ex.Message;
					this.lblErrorMsg.Text = this._ErrMsg;
				}

				int Excl0 = 0;
				int NbrCols = 24; // added column for Region Col#8
				bool IsManaged = false;
				if (_ShowColorCol == 0) {
					NbrCols--;
					//Color = "";
				}
				if (_ShowSortCol == 0) {
					NbrCols--;
					//fSort = "";
				}
				if (_ShowNoPrintCol == 0) {
					NbrCols--;
					//NoPrint = "";
				}
				if (_ShowMgdCol == 0) { NbrCols--; }
				float[] widths = new float[NbrCols];
				if (this.chkExclude0.Checked == true) { Excl0 = 1; }
				// Get grid data
				DataTable dt = ct.GetCatToolGridDataExport(Region, LocID, Product, SpecID, Thickness, GradeID, "", Color, fSort, "", NoPrint, Desc, 0, Excl0, 1, _user.UserID);
				// File name
				string FileName = "CAT_Availability_";
				DateTime now = DateTime.Now;
				FileName = FileName + now.ToString("MM_dd_yyyy");

				Document pdfDoc = new Document(PageSize.A4.Rotate(), 30, 30, 40, 25);
				System.IO.MemoryStream mStream = new System.IO.MemoryStream();
				PdfWriter writer = PdfWriter.GetInstance(pdfDoc, mStream);
				int cols = dt.Columns.Count;
				int rows = dt.Rows.Count;
				iTextSharp.text.Font font5 = iTextSharp.text.FontFactory.GetFont(FontFactory.HELVETICA, 5);
				pdfDoc.Open();

				// specie, thickness grade, mgd, color, sort, noprint, PRODUCT, wk1, wk2, wk3, wk4, wk5, wk6, wk7, wk8, wk9, wk10, wk11, wk12, wk13, listprice, comments
				int c = 0;
				Commands cmd = new Commands();
				DataTable dt2 = cmd.SelectUIColumnData(27, 1, _UserID);
				RowCount = dt2.Rows.Count;
				if (RowCount > 0)
				{
					for (int row=0;row<dt2.Rows.Count;row++)
					{
						if (row < NbrCols)
						{
							if (row < 3 || (row == 3 && _ShowMgdCol == 0) || (row == 4 && _ShowColorCol == 1) || (row == 5 && _ShowSortCol == 1) || (row == 6 && _ShowNoPrintCol == 1) || row > 6)
							{
								widths[c] = Convert.ToInt32(dt2.Rows[row]["ColumnWidth"]);
								c++;
							}
							// add region
							if (row == 7)
							{
								widths[c] = 60;
								c++;
							}
						}
					}
				}
				else
				{
					widths = new float[] { 76, 80, 74, 40, 72, 72, 76, 60, 60, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 72, 136 };
				}

				PdfPTable pdfTable = new PdfPTable(NbrCols);
				pdfTable.DefaultCell.BorderWidth = 1;
				pdfTable.WidthPercentage = 100;
				pdfTable.DefaultCell.Padding = 1;
				//PdfPRow row = null;

				//	d.Specie, d.Thickness, d.Grade, d.desc5, d.desc6, d.Color, d.Sort, d.NoPrint, d.Region, d.sIsTracked 'Mngd', d.Product, d.sPrice, ISNULL(d.Comments, '') 'Comment',
				//  S1 as 'Wk1', S2 as 'Wk2', S3 as 'Wk3', S4 as 'Wk4', S5 as 'Wk5', S6 as 'Wk6', S7 as 'Wk7', S8 as 'Wk8', S9 as 'Wk9', S10 as 'Wk10', S11 as 'Wk11', S12 as 'Wk12', S13 as 'Wk13'
				//float[] widths = new float[] { 76, 76, 80, 74, 79, 72, 72, 76, 58, 40, 60, 72, 136, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66 };

				pdfTable.SetWidths(widths);
				pdfTable.WidthPercentage = 100;

				//string colname = "";
				string parag = "CAT Availability dated " + now.ToString("MM/dd/yyyy");
				PdfPCell Tcell = new PdfPCell(new Phrase(parag));
				Tcell.Colspan = NbrCols; // dt.Columns.Count;
				Tcell.HorizontalAlignment = Element.ALIGN_CENTER;
				// Add header title
				pdfTable.AddCell(Tcell);
				PdfPCell cell;

				// Add column titles
				c = 0;
				foreach (DataColumn cl in dt.Columns)
				{
					if (c < 3 || (c == 3 && _ShowMgdCol == 1) || (c == 4 && _ShowColorCol == 1) || (c == 5 && _ShowSortCol == 1) || (c == 6 && _ShowNoPrintCol == 1) || c > 6)
					{
						cell = new PdfPCell(new Phrase(cl.ColumnName, font5));
						cell.BackgroundColor = BaseColor.LIGHT_GRAY;
						cell.HorizontalAlignment = 1;
						pdfTable.AddCell(cell);
					}
					c++;
				}

				// Add all rows to table
				if (RowCount > 0)
				{
					foreach (DataRow row in dt.Rows)
					{
						IsManaged = false;
						if (row[3].ToString() == "Yes") { IsManaged = true; }

						// Add Column by column for each row
						for (int col = 0; col < RowCount+1; col++)
						{
							if (col < 3 || (col == 3 && _ShowMgdCol == 1) || (col == 4 && _ShowColorCol == 1) || (col == 5 && _ShowSortCol == 1) || (col == 6 && _ShowNoPrintCol == 1) || col > 6)
							{
								var pcol = new PdfPCell(new Phrase(row[col].ToString(), font5));
								// handle columns after ident group
								if (col > 8)
								{
									// if managed
									if (col < 22)
									{
										if (IsManaged)
										{
											pcol.BackgroundColor = new BaseColor(204, 233, 251);
										}
										if (Convert.ToDouble(row[col]) > Convert.ToDouble(row[col + 1]))
										{
											pcol.BackgroundColor = new BaseColor(248, 204, 251);
										}
									}
								}
								if (col == 3 || col == 7 || col == 8) { pcol.HorizontalAlignment = 1; }
								pdfTable.AddCell(pcol);
							}
						}
					}
				}

				// add list of filters used
				StringBuilder sb = new StringBuilder();
				sb.Append("Filters Used:");
				if (Region.Length > 1) { sb.Append(" Region: " + Region); }
				if (LocID.Length > 1) { sb.Append(" Loc: " + LocID); }
				if (SpecID.Length > 1) { sb.Append(" Species: " + SpecID); }
				if (Thickness.Length > 1) { sb.Append(" Thickness: " + Thickness); }
				if (GradeID.Length > 1) { sb.Append(" Grade: " + GradeID); }
				if (Color.Length > 1) { sb.Append(" Color: " + Color); }
				if (fSort.Length > 1) { sb.Append(" Sort: " + fSort); }
				if (NoPrint.Length > 1) { sb.Append(" NoPrint: " + NoPrint); }
				Tcell = new PdfPCell(new Phrase(sb.ToString(), font5));
				Tcell.Colspan = NbrCols; // dt.Columns.Count;
				Tcell.HorizontalAlignment = Element.ALIGN_LEFT;
				pdfTable.AddCell(Tcell);

				pdfDoc.Add(pdfTable);
				pdfDoc.Close();
				Response.ContentType = "application/octet-stream";
				Response.AddHeader("Content-Disposition", "attachment; filename=" + FileName + ".pdf");
				Response.Clear();
				Response.BinaryWrite(mStream.ToArray());
				Response.End();

			}
			catch (DocumentException de)
			{
				this._ErrMsg = "Error while generating PDF: " + de.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
			catch (IOException ioEx)
			{
				this._ErrMsg = "Error while generating PDF: " + ioEx.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error while generating PDF: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		private Phrase FormatPhrase(string value)
		{
			return new Phrase(value, FontFactory.GetFont(FontFactory.TIMES, 8));
		}

		private static Phrase FormatHeaderPhrase(string value)
		{
			return new Phrase(value, FontFactory.GetFont(FontFactory.TIMES, 8, iTextSharp.text.Font.UNDERLINE, new iTextSharp.text.BaseColor(0, 0, 255)));
		}

		public override void VerifyRenderingInServerForm(Control control)
		{
			/* Verifies that the control is rendered */
		}

		protected void btnEditCatItems_Click(object sender, EventArgs e)
		{
			Response.Redirect("RegionPriceTracking.aspx", false);
		}

		protected void ddlSortF_SelectedIndexChanged(object sender, EventArgs e)
		{
			try
			{
				BindDataGrid(0);
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error changing sort: " + ex.Message;
			}
		}

		protected void chkExclude0_CheckedChanged(object sender, EventArgs e)
		{
			try
			{
				BindDataGrid(0);
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error excluding 0s: " + ex.Message;
			}
		}

		protected void btnPrevPage_Click(object sender, EventArgs e)
		{
			_PgNbr--;
			if (_PgNbr >= 0)
			{
				gvCatData.PageIndex = _PgNbr;
			}
			else
			{
				_PgNbr = 0;
			}
			BindDataGrid(0);
			//this.gvCatData.DataBind();
		}

		protected void btnNextPage_Click(object sender, EventArgs e)
		{
			_PgNbr++;
			if (_PgNbr <= _NbrPages)
			{
				gvCatData.PageIndex = _PgNbr;
			}
			else
			{
				_PgNbr = _NbrPages;
			}
			BindDataGrid(0);
			//this.gvCatData.DataBind();
		}

		protected void gvCatData_DataBound(object sender, EventArgs e)
		{
			int Row = 0;
			GridViewRow currRow;
			GridViewRow prevRow;
			DataRowView datrow;
			//DataRowView rowView; // = e.Row.DataItem as DataRowView;

			try
			{
				// Groups species names together
				int SpeciesSpan = 2;
				int ThicknessSpan = 2;
				for (int i = gvCatData.Rows.Count - 2; i >= 0; i--)
				{
					Row = i;
					currRow = gvCatData.Rows[i];
					prevRow = gvCatData.Rows[i + 1];
					datrow = (DataRowView)currRow.DataItem;

					// species
					if (currRow.Cells[0].Text == prevRow.Cells[0].Text)
					{
						currRow.Cells[0].RowSpan = SpeciesSpan;
						prevRow.Cells[0].Visible = false;
						SpeciesSpan += 1;
					}
					else
					{
						SpeciesSpan = 2;
					}
				}

				// thickness
				for (int i = gvCatData.Rows.Count - 2; i >= 0; i--)
				{
					Row = i;
					currRow = gvCatData.Rows[i];
					prevRow = gvCatData.Rows[i + 1];
					datrow = (DataRowView)currRow.DataItem;
					// thickness
					if (currRow.Cells[1].Text == prevRow.Cells[1].Text)
					{
						currRow.Cells[1].RowSpan = ThicknessSpan;
						prevRow.Cells[1].Visible = false;
						ThicknessSpan += 1;
					}
					else
					{
						ThicknessSpan = 2;
					}
				}

			}
			catch (Exception ex)
			{
				_ErrMsg = "Row Data Bound " + Row.ToString() + ": " + ex.Message;
				this.lblErrorMsg.Text = _ErrMsg;
			}

			try
			{
				// Groups like grades together
				int ThicknessSpan = 2;
				for (int i2 = gvCatData.Rows.Count - 2; i2 >= 0; i2--)
				{
					currRow = gvCatData.Rows[i2];
					prevRow = gvCatData.Rows[i2 + 1];

					if (currRow.Cells[2].Text == prevRow.Cells[2].Text)
					{
						currRow.Cells[2].RowSpan = ThicknessSpan;
						prevRow.Cells[2].Visible = false;
						ThicknessSpan += 1;
					}
					else
					{
						ThicknessSpan = 2;
					}
				}
			}
			catch (Exception ex2)
			{
				_ErrMsg = "Row Data Bound-Thickness: " + ex2.Message;
				this.lblErrorMsg.Text = _ErrMsg;
			}

			//try
			//{
			//	// Groups like managed together
			//	int GradeSpan = 2;
			//	for (int i3 = gvCatData.Rows.Count - 2; i3 >= 0; i3--)
			//	{
			//		currRow = gvCatData.Rows[i3];
			//		prevRow = gvCatData.Rows[i3 + 1];

			//		if (currRow.Cells[3].Text == prevRow.Cells[3].Text)
			//		{
			//			currRow.Cells[3].RowSpan = GradeSpan;
			//			prevRow.Cells[3].Visible = false;
			//			GradeSpan += 1;
			//		}
			//		else
			//		{
			//			GradeSpan = 2;
			//		}
			//	}
			//}
			//catch (Exception ex3)
			//{
			//	_ErrMsg = "Row Data Bound-Grades: " + ex3.Message;
			//	this.lblErrorMsg.Text = _ErrMsg;
			//}
		}

		protected void chkPrinterFriendly_CheckedChanged(object sender, EventArgs e)
		{
			try
			{
				if (this.chkPrinterFriendly.Checked == true)
				{
					_PrinterFriendly = 1;
					//gvCatData.Columns[6].Visible = false;
					this.trFilterLine1.Style["display"] = "none";
					this.trFilterLine2.Style["display"] = "none";
					this.trFilterLine3.Style["display"] = "none";
					FillFiltersSetLabel();
					this.divShowCurrentFiltersSet.Style["display"] = "block";
					this.divSpecialBtnGroup.Style["display"] = "none";
					this.divFilterBar.Style["margin-bottom"] = "0px";
					this.divBottomBtn.Style["display"] = "none";
					//this.divBottomNotes.Style["display"] = "none";
					//div d = Master.FindControl("ctlButtonBar1").Style["display"] = "none";
					ScriptManager.RegisterStartupScript(this, typeof(Page), "ChangeHdrBtnBarVis", "$(document).ready(function(){document.getElementById('ctlButtonBar1_divButtonBarMAIN').style.display='none';})", true);
					gvCatData.BottomPagerRow.Visible = false;
				}
				else
				{
					_PrinterFriendly = 0;
					//gvCatData.Columns[6].Visible = true;
					this.trFilterLine1.Style["display"] = "block";
					this.trFilterLine2.Style["display"] = "block";
					this.trFilterLine3.Style["display"] = "block";
					divShowCurrentFiltersSet.Style["display"] = "none";
					this.divSpecialBtnGroup.Style["display"] = "inline";
					this.divFilterBar.Style["margin-bottom"] = "10px";
					this.divBottomBtn.Style["display"] = "block";
					//this.divBottomNotes.Style["display"] = "inline";
					//Master.FindControl("ctlButtonBar1").Style["display"] = "block";
					ScriptManager.RegisterStartupScript(this, typeof(Page), "ChangeHdrBtnBarVis", "$(document).ready(function(){document.getElementById('ctlButtonBar1_divButtonBarMAIN').style.display='inline-table';})", true);
					//gvCatData.PagerSettings.Visible = true;
					gvCatData.BottomPagerRow.Visible = true;
				}
				ViewState["PrinterFriendly"] = _PrinterFriendly.ToString();
				BindDataGrid(0);
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Printer Friendly error: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void FillFiltersSetLabel()
		{
			string txt = string.Empty;
			string itmx = string.Empty;
			try
			{
				txt = "Page: " + (_PgNbr + 1).ToString() + ", ";
				itmx = "";
				foreach (System.Web.UI.WebControls.ListItem itm in this.lbxLocationF.Items)
				{
					if (itm.Selected)
					{
						if (itmx.Length > 0) { itmx = itmx + ','; }
						itmx = itmx + GenUtilities.SanatizeStringData(itm.Value);
					}
				}
				txt = txt + "Loc: " + itmx;
				itmx = "";
				foreach (System.Web.UI.WebControls.ListItem itm in this.lbxSpeciesF.Items)
				{
					if (itm.Selected)
					{
						if (itmx.Length > 0) { itmx = itmx + ','; }
						itmx = itmx + GenUtilities.SanatizeStringData(itm.Value);
					}
				}
				txt = txt + ", Species: " + itmx;
				itmx = "";
				foreach (System.Web.UI.WebControls.ListItem itm in this.lbxThicknessF.Items)
				{
					if (itm.Selected)
					{
						if (itmx.Length > 0) { itmx = itmx + ','; }
						itmx = itmx + GenUtilities.SanatizeStringData(itm.Value);
					}
				}
				txt = txt + ", Thick: " + itmx;
				itmx = "";
				foreach (System.Web.UI.WebControls.ListItem itm in this.lbxGradeF.Items)
				{
					if (itm.Selected)
					{
						if (itmx.Length > 0) { itmx = itmx + ','; }
						itmx = itmx + GenUtilities.SanatizeStringData(itm.Value);
					}
				}
				txt = txt + ", Grade: " + itmx;
				itmx = "";
				foreach (System.Web.UI.WebControls.ListItem itm in this.lbxColorF.Items)
				{
					if (itm.Selected)
					{
						if (itmx.Length > 0) { itmx = itmx + ','; }
						itmx = itmx + GenUtilities.SanatizeStringData(itm.Value);
					}
				}
				txt = txt + ", Color: " + itmx;
				itmx = "";
				foreach (System.Web.UI.WebControls.ListItem itm in this.lbxSortF.Items)
				{
					if (itm.Selected)
					{
						if (itmx.Length > 0) { itmx = itmx + ','; }
						itmx = itmx + GenUtilities.SanatizeStringData(itm.Value);
					}
				}
				txt = txt + ", Sort: " + itmx;
				itmx = "";
				foreach (System.Web.UI.WebControls.ListItem itm in this.lbxRegionF.Items)
				{
					if (itm.Selected)
					{
						if (itmx.Length > 0) { itmx = itmx + ','; }
						itmx = itmx + GenUtilities.SanatizeStringData(itm.Value);
					}
				}
				txt = txt + ", Region: " + itmx;
				string Product = this.txtProductS.Text;
				string Desc = this.txtDescriptionS.Text;
				int Sort = Convert.ToInt32(ddlSortF.SelectedValue);
				int Excl0 = 0;
				if (chkExclude0.Checked == true) { Excl0 = 1; }

				// replace dangerous characters in strings
				Product = GenUtilities.SanatizeStringData(Product);
				Desc = GenUtilities.SanatizeStringData(Desc);
				this.lblShowCurrentFiltersSet.Text = txt + ", Prod: " + Product + ", Desc: " + Desc + ", Sort: " + Sort.ToString() + ", Excl0: " + Excl0.ToString();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Loading Filters List: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void chkNarrowView_CheckedChanged(object sender, EventArgs e)
		{
			try
			{
				if (chkNarrowView.Checked == true && _Narrow == 0)
				{
					_Narrow = 1;
					ViewState["NarrowView"] = "1";
				}
				else
				{
					if (chkNarrowView.Checked == false && _Narrow == 1)
					{
						_Narrow = 0;
						ViewState["NarrowView"] = "0";
					}
				}
				BindDataGrid(0);
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error setting narrow view: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void ddlDataViewScope_SelectedIndexChanged(object sender, EventArgs e)
		{
			try
			{
				_ViewMode = Convert.ToInt32(ddlDataViewScope.SelectedValue);
				ViewState["ViewMode"] = _ViewMode;

				ResetFilterGroup();

				switch (_ViewMode)
				{
					case 0: // normal view
						break;
					case 1: // Server CTR
						break;
					default:
						break;
				}
			}
			catch (Exception ex)
			{

			}
		}

		protected void ResetFilterGroup()
		{
			LoadSpeciesList();
			LoadLocationsList();
			LoadThicklistList();
			LoadGradeList();
			LoadColorList();
			LoadSortList();

			// set initial value of search criteria to ALL
			this.lbxGradeF.SelectedValue = "0";
			this.lbxLocationF.SelectedValue = "0";
			this.lbxSpeciesF.SelectedValue = "0";
			this.lbxThicknessF.SelectedValue = "0";
			this.lbxColorF.SelectedValue = "0";
			this.lbxSortF.SelectedValue = "0";
			this.lbxRegionF.SelectedValue = "0";
			this.lbxNoPrintF.SelectedValue = "0";
		}

		protected void ddlSourceType_TextChanged(object sender, EventArgs e)
		{
			_SourceType = Convert.ToInt32(ddlSourceType.SelectedValue);
			LoadLocationsList();
			lbxRegionF.SelectedValue = "0";
			this.lbxLocationF.SelectedValue = "0";
			_PgNbr = 0;
			gvCatData.PageIndex = 0;
			ViewState["PgNbr"] = _PgNbr.ToString();
			BindDataGrid(0);
		}

		protected void btnRefreshData2_Click(object sender, EventArgs e)
		{
			DataTable dt;
			DataLayer.DataMngtTool p = new DataLayer.DataMngtTool();
			bool DoUpdate = false;
			int ShowVal = 0;
			if (this.chkShowManagedCol.Checked == true)
			{
				ShowVal = 1;
			}
			else
			{
				ShowVal = 0;
			}
			if (ShowVal != _ShowMgdCol)
			{
				_ShowMgdCol = ShowVal;
				ViewState["ShowMgdCol"] = _ShowMgdCol.ToString();
				dt = p.UpdateColumnSetting(_UserID, "CatGrid", "MGD", ShowVal.ToString(), "", 1, _UserID);
				DoUpdate = true;
			}
			if (this.chkShowColorCol.Checked == true)
			{
				ShowVal = 1;
			}
			else
			{
				ShowVal = 0;
			}
			if (ShowVal != _ShowColorCol)
			{
				_ShowColorCol = ShowVal;
				ViewState["ShowColorCol"] = _ShowColorCol.ToString();
				dt = p.UpdateColumnSetting(_UserID, "CatGrid", "Color", ShowVal.ToString(), "", 1, _UserID);
				DoUpdate = true;
			}
			if (this.chkShowSortCol.Checked == true)
			{
				ShowVal = 1;
			}
			else
			{
				ShowVal = 0;
			}
			if (ShowVal != _ShowSortCol)
			{
				_ShowSortCol = ShowVal;
				ViewState["ShowSortCol"] = _ShowSortCol.ToString();
				dt = p.UpdateColumnSetting(_UserID, "CatGrid", "Sort", ShowVal.ToString(), "", 1, _UserID);
				DoUpdate = true;
			}
			if (this.chkShowNoPrintCol.Checked == true)
			{
				ShowVal = 1;
			}
			else
			{
				ShowVal = 0;
			}
			if (ShowVal != _ShowNoPrintCol)
			{
				_ShowNoPrintCol = ShowVal;
				ViewState["ShowNoPrintCol"] = _ShowNoPrintCol.ToString();
				dt = p.UpdateColumnSetting(_UserID, "CatGrid", "NoPrint", ShowVal.ToString(), "", 1, _UserID);
				DoUpdate = true;
			}
			if (DoUpdate == true)
			{
				_PgNbr = 0;
				gvCatData.PageIndex = 0;
				BindDataGrid(0);
			}
			divColumnShownEdit.Style["display"] = "none";
		}

		protected void btnShowColEdit_Click(object sender, EventArgs e)
		{
			divColumnShownEdit.Style["display"] = "block";
		}

		protected void btnCloseThisDiv_Click(object sender, EventArgs e)
		{
			divColumnShownEdit.Style["display"] = "none";
		}
	}
}