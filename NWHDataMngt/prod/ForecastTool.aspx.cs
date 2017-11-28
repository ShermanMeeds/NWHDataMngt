using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using DataLayer;

namespace DataMngt.prod
{
	public partial class ForecastTool : System.Web.UI.Page
	{
		#region local-variables	
		private string _AppVers = string.Empty;
		private string _BuildNbr = "";
		private string _SiteURL = "";
		private CurrentUser _user = null;
		private CurrBrowserNoSess _Browser = null;
		private DateTime _BaseDate;
		private DateTime _BaseDatePV;
		private string _CBuildNbr = "";
		private bool _CanEdit = false;
		private double[] Totals = new double[30];
		private int _CheckoutGridID = 0;
		private int _CopyMixID = 0;
		private int _CurrentWeek = 0;
		private string _ErrMsg = string.Empty;
		private int _FinishView = 0;
		private int _ForecastView = 0;
		private DataTable _GradeList;
		private bool _HasMultiLocs = false;
		private bool _IsAdmin = false;
		private string _LastLabel = string.Empty;
		private DataTable _LengthList;
		private string _LocationCode = string.Empty;
		private string _LocationName = string.Empty;
		private int _MatrixView = 0;
		private int _MaxShift = 3;
		private int _MixID = 0;
		private int _NbrItems = 0;
		private Single _OutTurnPercent = 0;
		private int _PgNbr1 = 0;
		private int _PgNbr2 = 0;
		private int _PgNbr3 = 0;
		private int _PgNbr4 = 0;
		private int _PgNbr5 = 0;
		private int _PgNbr6 = 0;
		private int _PgNbr7 = 0; // finish view
		private int _PgNbr8 = 0;
		private int _PgSize = 20;
		private int[] _ProdItems = new int[201];
		private string _RegionCode = string.Empty;
		private bool _ShowHistGrid = false;
		private string _SpeciesCode = string.Empty;
		private double _StrategicTotal = 0;
		private double _StrategicTotalF = 0;
		private DataTable _SpeciesList;
		private DateTime _TargetDate = DateTime.Now;
		private int _TargetGrid = 0;
		private DataTable _ThickList;
		private double _TotalAmt = 0;
		private double _TotalAmtf = 0;
		private int _TotalItems = 0;
		private Single _TotalPercentage = 0;
		private int _UseCurrentWeek = 0;
		private int _UseCurrentWeekFV = 0;
		private int _UserID = 0;
		private bool _UseShift1 = true;
		private bool _UseShift2 = true;
		private bool _UseShift3 = true;
		private double _WeekTotal1 = 0;
		private double _WeekTotal2 = 0;
		private double _WeekTotal1f = 0;
		private double _WeekTotal2f = 0;
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

			// establish initial and default values
			string UserName = Request.ServerVariables["LOGON_USER"];
			string logFilePath = System.Configuration.ConfigurationManager.AppSettings["AppLogFilePath"].ToString();
			//_PgNbr = 0;
			_PgSize = 20;
			_SiteURL = System.Configuration.ConfigurationManager.AppSettings["SitePrefix"];
			_BuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
			_AppVers = System.Configuration.ConfigurationManager.AppSettings["AppVersion"].ToString() + " (" + System.Configuration.ConfigurationManager.AppSettings["AppVersionDate"].ToString() + ")";
			string ips = System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
			_Browser = new CurrBrowserNoSess(System.Web.HttpContext.Current.Request);


			this.lblBuildNbr.Text = _BuildNbr.ToString();
			this.lblVersion.Text = System.Configuration.ConfigurationManager.AppSettings["AppVersion"].ToString();
			this.lblVersionDate.Text = System.Configuration.ConfigurationManager.AppSettings["AppVersionDate"].ToString();

			string AssumedLogin = string.Empty;
			try
			{
				if (HttpContext.Current.Session["AssumedEntityLogin"] != null)
				{
					if (HttpContext.Current.Session["AssumedEntityLogin"].ToString() != "") { AssumedLogin = HttpContext.Current.Session["AssumedEntityLogin"].ToString(); }
				}
			}
			catch (Exception ex)
			{
				// nothing
			}
			_user = new CurrentUser(UserName, logFilePath, ""); // SessionHelper.GetCurrentUser(Request.ServerVariables["LOGON_USER"]);
			if (_user == null || !_user.IsValid)
			{
				Logging.WriteToLog("Login failed for " + UserName + ".");
				HttpContext.Current.Response.Redirect("NoAcc/NoAccess.aspx", true);
			}

			// check for specific rights to cat tool
			if (!_user.IsInRole("forecastvw") && !_user.IsInRole("forecastedit") && !_user.IsInRole("forecastAdm") && !_user.IsInRole("datmngtedit") && !_user.IsInRole("datmngtview") && !_user.IsAdmin == true)
			{
				Session["NoAccessMsg"] = "You do not have access to forecasting.";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}
			this._CanEdit = true;
			if (_user.IsInRole("forecastvw") || _user.IsInRole("datmngtview"))
			{
				this._CanEdit = false;
			}
			if (_user.IsInRole("forecastAdm") || !_user.IsAdmin == true)
			{
				this._IsAdmin = true;
			}

			_CBuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
			_UserID = Convert.ToInt32(_user.UserID);
			_MixID = 0;

			if (!this.IsPostBack)
			{
				try
				{
					_UseShift1 = true;
					_UseShift2 = true;
					_UseShift3 = true;
					_LocationCode = _user.LocationCode;
					_RegionCode = _user.RegionCode;
					ViewState.Add("LocationCode", _LocationCode);
					ViewState.Add("RegionCode", _RegionCode);
					this.btnGotoConsolidation.Style["display"] = "none";

					string Loc = _LocationCode;
					if (_user.IsInRole("forecastAdm") == true || _user.IsAdmin == true)
					{
						_LocationName = "";
						Loc = string.Empty;
						this.spnLocationListAdm.Style["display"] = "inline";
						this.spnLocationIdent.Style["display"] = "none";
						this.btnGotoConsolidation.Style["display"] = "inline";
						Commands cmd = new Commands();
						//DataTable dt = cmd.SelectProductCodeList("Location", 0, 1, 0, 0, 0, _UserID); //GetLocationList2(Loc, "", 0, 1, 0, 1, _UserID);
						Forecast fc = new Forecast();
						DataTable dt = fc.SelectUserForecastLocationList("", "", "", "", "", 0, 0, 1, _UserID);
						this.ddlLocationListF.DataTextField = "LocationName"; // "CodeDescription";
						this.ddlLocationListF.DataValueField = "LocationCode"; // "CatCode";
						this.ddlLocationListF.DataSource = dt;
						this.ddlLocationListF.DataBind();
						this.ddlLocationListF.ClearSelection();
						this.ddlLocationListF.SelectedValue = "0";
						_HasMultiLocs = true;
						this.btnCloneLocation.Style["display"] = "inline";

						this.ddlSrcLocationCode.DataTextField = "LocationName"; // "CodeDescription";
						this.ddlSrcLocationCode.DataValueField = "LocationCode"; // "CatCode";
						this.ddlSrcLocationCode.DataSource = dt;
						this.ddlSrcLocationCode.DataBind();
						this.ddlSrcLocationCode.ClearSelection();
						this.ddlSrcLocationCode.SelectedValue = "0";

						this.ddlTgtLocationCode.DataTextField = "LocationName"; // "CodeDescription";
						this.ddlTgtLocationCode.DataValueField = "LocationCode"; // "CatCode";
						this.ddlTgtLocationCode.DataSource = dt;
						this.ddlTgtLocationCode.DataBind();
						this.ddlTgtLocationCode.ClearSelection();
						this.ddlTgtLocationCode.SelectedValue = "0";
					}
					else
					{
						if (_user.IsInRole("consoldvw") || _user.IsInRole("consoldv2"))
						{
							this.btnGotoConsolidation.Style["display"] = "inline";
						}
						_LocationName = "";
						//this.ddlLocationListF.Style["display"] = "none";
						this.spnLocationListAdm.Style["display"] = "none";
						this.lblLocationCode.Style["display"] = "inline";
						this.spnLocationIdent.Style["display"] = "inline";
						this.btnCloneLocation.Style["display"] = "none";
						_HasMultiLocs = false;
						LoadUserLocations();
						this.lblLocationIdent.Text = _LocationCode + '-' + _LocationName;
					}

					_CanEdit = true;
					LoadLocationSettings();
					//LoadMainSpeciesList();
					_MatrixView = 0;
					this.chkEditCurrentWeek.Checked = true;
					_CurrentWeek = 1;
					_ForecastView = 0;
					_FinishView = 0;
					_TotalItems = 0;
					_TotalPercentage = 0;
					_OutTurnPercent = 0;
					_UseCurrentWeek = 1;
					_UseCurrentWeekFV = 1;
					_MaxShift = 3;
					_CopyMixID = 0;
					_NbrItems = 0;
					_PgNbr1 = 0;
					_PgNbr2 = 0;
					_PgNbr3 = 0;
					_PgNbr4 = 0;
					_PgNbr5 = 0;
					_PgNbr6 = 0;
					_PgNbr7 = 0;
					_PgNbr8 = 0;
					_PgSize = 20;
					_TotalAmt = 0;
					_TotalAmtf = 0;
					_WeekTotal1 = 0;
					_WeekTotal1f = 0;
					_WeekTotal2 = 0;
					_WeekTotal2f = 0;
					_StrategicTotal = 0;
					_StrategicTotalF = 0;
					_CheckoutGridID = 0;
					_ShowHistGrid = false;
					_LastLabel = string.Empty;
					_BaseDate = DateTime.Now.AddDays(-(int)DateTime.Now.DayOfWeek + 1);
					_BaseDatePV = DateTime.Now.AddDays(-(int)DateTime.Now.DayOfWeek + 1);
					this.txtTargetDateH.Text = "";

					//System.Globalization.CultureInfo ci =
					//System.Threading.Thread.CurrentThread.CurrentCulture;
					//DayOfWeek fdow = ci.DateTimeFormat.FirstDayOfWeek;
					//DayOfWeek today = DateTime.Now.DayOfWeek;
					//DateTime sow = DateTime.Now.AddDays(-(today - fdow)).Date;
					var _TargetDate = DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek + (int)DayOfWeek.Monday);

					ViewState.Add("MatrixView", _MatrixView.ToString());
					ViewState.Add("TargetDate", _TargetDate.ToString());
					ViewState.Add("CurrentWeek", _CurrentWeek.ToString());
					ViewState.Add("ForecastView", _ForecastView.ToString());
					ViewState.Add("FinishView", _FinishView.ToString());
					ViewState.Add("TargetGrid", _TargetGrid.ToString());
					ViewState.Add("SpeciesList", "");
					ViewState.Add("ThicknessList", "");
					ViewState.Add("GradeList", "");
					ViewState.Add("LengthList", "");
					ViewState.Add("UseCurrentWeek", "1");
					ViewState.Add("UseCurrentWeekFV", "1");
					ViewState.Add("TotalItems", _TotalItems.ToString());
					ViewState.Add("TotalPercent", _TotalPercentage.ToString());
					ViewState.Add("OutturnPercent", _OutTurnPercent.ToString());
					ViewState.Add("UseShift1", _UseShift1.ToString());
					ViewState.Add("UseShift2", _UseShift2.ToString());
					ViewState.Add("UseShift3", _UseShift3.ToString());
					ViewState.Add("CopyMixID", _CopyMixID.ToString());
					ViewState.Add("NbrItems", _NbrItems.ToString());
					ViewState.Add("ProdItems", _ProdItems);
					ViewState.Add("WeekTotal1", _WeekTotal1.ToString());
					ViewState.Add("WeekTotal2", _WeekTotal2.ToString());
					ViewState.Add("TotalAmt", _TotalAmt.ToString());
					ViewState.Add("WeekTotal1f", _WeekTotal1f.ToString());
					ViewState.Add("WeekTotal2f", _WeekTotal2f.ToString());
					ViewState.Add("TotalAmtf", _TotalAmtf.ToString());
					ViewState.Add("StrategicAmt", _StrategicTotal.ToString());
					ViewState.Add("StrategicAmtF", _StrategicTotalF.ToString());
					ViewState.Add("BaseDate", _BaseDate.ToString());
					ViewState.Add("BaseDatePV", _BaseDatePV.ToString());
					ViewState.Add("PageSize", _PgSize.ToString());
					ViewState.Add("PageNbr1", _PgNbr1.ToString());
					ViewState.Add("PageNbr2", _PgNbr2.ToString());
					ViewState.Add("PageNbr3", _PgNbr3.ToString());
					ViewState.Add("PageNbr4", _PgNbr4.ToString());
					ViewState.Add("PageNbr5", _PgNbr5.ToString());
					ViewState.Add("PageNbr6", _PgNbr6.ToString());
					ViewState.Add("PageNbr7", _PgNbr7.ToString());
					ViewState.Add("PageNbr8", _PgNbr8.ToString());
					ViewState.Add("MaxShift", _MaxShift.ToString());
					ViewState.Add("LastLabel", _LastLabel.ToString());
					ViewState.Add("CheckoutGridID", _CheckoutGridID.ToString());
					ViewState.Add("CanEdit", "1");
					ViewState.Add("FVFMix", "");
					ViewState.Add("FVFProd", "");
					ViewState.Add("FVFReg", "");
					ViewState.Add("FVFSpec", "");
					ViewState.Add("FVFThick", "");
					ViewState.Add("FVFGrade", "");
					ViewState.Add("FVFLen", "");
					ViewState.Add("FVFColor", "");
					ViewState.Add("FVFSort", "");
					ViewState.Add("FVFMilling", "");
					ViewState.Add("FVFNoPrint", "");
					ViewState.Add("FVFShift", "");
					ViewState.Add("FVFType", "");
					ViewState.Add("FVFNoEmpties", "");
					ViewState.Add("ShowHistGrid", "0");

					// calculate dates for 13 weeks for header
					LoadColorList();
					LoadSortList();
					LoadLengthList();
					LoadMillingList();
					LoadNoPrintList();
					LoadSpeciesDDL();
					LoadThicklistList();
					LoadGradeList();
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
				_CurrentWeek = Convert.ToInt32(ViewState["CurrentWeek"]);
				_MatrixView = Convert.ToInt32(ViewState["MatrixView"]);
				_TargetDate = Convert.ToDateTime(ViewState["TargetDate"]);
				_ForecastView = Convert.ToInt32(ViewState["ForecastView"]);
				_TargetGrid = Convert.ToInt32(ViewState["TargetGrid"]);
				_SpeciesList = (DataTable)ViewState["SpeciesList"];
				_ThickList = (DataTable)ViewState["ThicknessList"];
				_GradeList = (DataTable)ViewState["GradeList"];
				_LengthList = (DataTable)ViewState["LengthList"];
				_LocationCode = ViewState["LocationCode"].ToString();
				_RegionCode = ViewState["RegionCode"].ToString();
				_LastLabel = ViewState["LastLabel"].ToString();
				_TotalItems = Convert.ToInt32(ViewState["TotalItems"]);
				_TotalPercentage = Convert.ToSingle(ViewState["TotalPercent"]);
				_OutTurnPercent = Convert.ToSingle(ViewState["OutturnPercent"]);
				_UseCurrentWeek = Convert.ToInt32(ViewState["UseCurrentWeek"]);
				_UseCurrentWeekFV = Convert.ToInt32(ViewState["UseCurrentWeekFV"]);
				_FinishView = Convert.ToInt32(ViewState["FinishView"]);
				_UseShift1 = Convert.ToBoolean(ViewState["UseShift1"]);
				_UseShift2 = Convert.ToBoolean(ViewState["UseShift2"]);
				_UseShift3 = Convert.ToBoolean(ViewState["UseShift3"]);
				_CopyMixID = Convert.ToInt32(ViewState["CopyMixID"]);
				_NbrItems = Convert.ToInt32(ViewState["NbrItems"]);
				_ProdItems = (int[])ViewState["ProdItems"];
				_WeekTotal1 = Convert.ToDouble(ViewState["WeekTotal1"]);
				_WeekTotal2 = Convert.ToDouble(ViewState["WeekTotal2"]);
				_TotalAmt = Convert.ToDouble(ViewState["TotalAmt"]);
				_WeekTotal1f = Convert.ToDouble(ViewState["WeekTotal1f"]);
				_WeekTotal2f = Convert.ToDouble(ViewState["WeekTotal2f"]);
				_TotalAmtf = Convert.ToDouble(ViewState["TotalAmtf"]);
				_StrategicTotal = Convert.ToDouble(ViewState["StrategicAmt"]);
				_StrategicTotalF = Convert.ToDouble(ViewState["StrategicAmtF"]);
				_BaseDate = Convert.ToDateTime(ViewState["BaseDate"]);
				_BaseDatePV = Convert.ToDateTime(ViewState["BaseDatePV"]);
				_PgSize = Convert.ToInt32(ViewState["PageSize"]);
				_PgNbr1 = Convert.ToInt32(ViewState["PageNbr1"]);
				_PgNbr2 = Convert.ToInt32(ViewState["PageNbr2"]);
				_PgNbr3 = Convert.ToInt32(ViewState["PageNbr3"]);
				_PgNbr4 = Convert.ToInt32(ViewState["PageNbr4"]);
				_PgNbr5 = Convert.ToInt32(ViewState["PageNbr5"]);
				_PgNbr6 = Convert.ToInt32(ViewState["PageNbr6"]);
				_PgNbr7 = Convert.ToInt32(ViewState["PageNbr7"]);
				_PgNbr8 = Convert.ToInt32(ViewState["PageNbr8"]);
				_MaxShift = Convert.ToInt32(ViewState["MaxShift"]);
				_CheckoutGridID = Convert.ToInt32(ViewState["CheckoutGridID"]);
				if (ViewState["CanEdit"].ToString() == "1")
				{
					_CanEdit = true;
				}
				else
				{
					_CanEdit = false;
				}
				if (ViewState["ShowHistGrid"].ToString() == "1")
				{
					_ShowHistGrid = true;
				}
				else
				{
					_ShowHistGrid = false;
				}
			}
		}

		protected void ChangeShiftDisplay()
		{
			try
			{
				HtmlTableRow tr;
				for (int rowid = 0; rowid < gvForecastData.Rows.Count; rowid++)
				{
					GridViewRow row = gvForecastData.Rows[rowid];
					if (_ForecastView == 0 || _ForecastView == 1 || _ForecastView == 3 || _ForecastView == 4)
					{
						for (int ic = 2; ic <= 15; ic++)
						{
							if (_ForecastView < 3 || ((_ForecastView == 3 && ic < 9) || (_ForecastView == 4 && ic > 8)))
							{
								for (int s = 2; s <= 3; s++)
								{
									if (s == 2)
									{
										if (_UseShift2 == false)
										{
											tr = (HtmlTableRow)row.FindControl("trForecastc" + ic.ToString() + "s2");
											tr.Style["display"] = "none";
										}
										else
										{
											tr = (HtmlTableRow)row.FindControl("trForecastc" + ic.ToString() + "s2");
											tr.Style["display"] = "table-row";
										}
									}
									if (s == 3)
									{
										if (_UseShift3 == false)
										{
											tr = (HtmlTableRow)row.FindControl("trForecastc" + ic.ToString() + "s3");
											tr.Style["display"] = "none";
										}
										else
										{
											tr = (HtmlTableRow)row.FindControl("trForecastc" + ic.ToString() + "s3");
											tr.Style["display"] = "table-row";
										}
									}
								}
							}
						}
						// remove 0 values
						if (_ForecastView == 0 || _ForecastView == 2)
						{
							for (int ic2 = 16; ic2 <= 26; ic2++)
							{
								for (int s2 = 1; s2 <= 3; s2++)
								{
									if (s2 == 2)
									{
										if (_UseShift2 == false)
										{
											tr = (HtmlTableRow)row.FindControl("trForecastc" + ic2.ToString() + "s2");
											tr.Style["display"] = "none";
										}
										else
										{
											tr = (HtmlTableRow)row.FindControl("trForecastc" + ic2.ToString() + "s2");
											tr.Style["display"] = "table-row";
										}
									}
									if (s2 == 3)
									{
										if (_UseShift3 == false)
										{
											tr = (HtmlTableRow)row.FindControl("trForecastc" + ic2.ToString() + "s3");
											tr.Style["display"] = "none";
										}
										else
										{
											tr = (HtmlTableRow)row.FindControl("trForecastc" + ic2.ToString() + "s3");
											tr.Style["display"] = "table-row";
										}
									}
								}
							}
						}
					}
					// update visibility for totals
					for (int s2 = 1; s2 <= 3; s2++)
					{
						if (s2 == 2)
						{
							if (_UseShift2 == false)
							{
								tr = (HtmlTableRow)row.FindControl("trForecastc27s2");
								tr.Style["display"] = "none";
							}
							else
							{
								tr = (HtmlTableRow)row.FindControl("trForecastc27s2");
								tr.Style["display"] = "table-row";
							}
						}
						if (s2 == 3)
						{
							if (_UseShift3 == false)
							{
								tr = (HtmlTableRow)row.FindControl("trForecastc27s3");
								tr.Style["display"] = "none";
							}
							else
							{
								tr = (HtmlTableRow)row.FindControl("trForecastc27s3");
								tr.Style["display"] = "table-row";
							}
						}
					}

				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error while establishing shift display: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
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

		protected void EmptyProductEditData()
		{
			//this.ddlProdProductListE.SelectedValue = "0";
			this.txtProdDescriptionE.Text = "";
			this.txtPDescVal1.Text = "";
			this.txtPDescVal2.Text = "";
			this.txtPDescVal3.Text = "";
			this.txtPDescVal4.Text = "";
			this.txtPDescVal5.Text = "";
			this.txtPDescVal6.Text = "";
			this.txtPDescVal7.Text = "";
			this.txtPDescVal8.Text = "";
			this.txtPDescVal9.Text = "";
			this.txtPDescVal10.Text = "";
			this.ddlLengthT.SelectedValue = "0";
			this.ddlColorT.SelectedValue = "0";
			this.ddlSortT.SelectedValue = "0";
			this.ddlMillingT.SelectedValue = "0";
			this.ddlNoPrintT.SelectedValue = "0";
			this.chkProdActiveE.Checked = true;
			this.hfProdManagedIDE.Value = "0";
		}

		protected void EmptyProdList()
		{
			for (int i = 0; i <= 100; i++)
			{
				_ProdItems[i] = 0;
			}
		}

		protected void EmptyMixProdEditData()
		{
			this.ddlProdItemE.SelectedValue = "0";
			this.txtProdItemPercent.Text = "0";
		}

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

		protected void ForecastFieldValueChanged(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			try
			{
				TextBox t = (TextBox)sender;
				string sid = t.ID;
				string sqty = t.Text;
				GridViewRow gvRow = (GridViewRow)t.Parent.Parent.Parent.Parent.Parent;
				int idx = gvRow.RowIndex;
				UpdateRowTotal(idx);
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error trying to save value: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected DateTime GetProdDate(int wk, int dy)
		{
			// _BaseDate must be properly set for this to work
			DateTime dt = _BaseDate;
			DateTime dt2 = DateTime.Today;
			if (wk > 1)
			{
				dt = _BaseDate.AddDays((wk - 1) * 7);
			}
			if (wk <= 2)
			{
				if (dy > 1)
				{
					dt2 = dt.AddDays(dy - 1);
				}
				else
				{
					dt2 = dt;
				}
			}
			else
			{
				dt2 = dt.AddDays(4);
			}
			return dt2;
		}

		protected string GrabListBoxSelections(ListBox lbx)
		{
			string slist = string.Empty;
			foreach (System.Web.UI.WebControls.ListItem itm in lbx.Items)
			{
				if (itm.Selected)
				{
					if (slist.Length > 0) { slist = slist + ','; }
					slist = slist + GenUtilities.SanatizeStringData(itm.Value);
				}
			}
			return slist;
		}

		protected void HideAllGridAreas()
		{
			try
			{
				this.divMixList.Style["display"] = "none";
				this.divMixContents.Style["display"] = "none";
				this.divProductList.Style["display"] = "none";
				this.divForecastMatrix.Style["display"] = "none";
				this.divForecastCodes.Style["display"] = "none";
				this.divProductItemEdit.Style["display"] = "none";
				this.divMixItemEdit.Style["display"] = "none";
				this.divMixProductEdit.Style["display"] = "none";
				this.divFinishView.Style["display"] = "none";
				this.divProductBulkCopy.Style["display"] = "none";
				this.divProductListCheckout.Style["display"] = "none";
				this.divMixContentsCheckout.Style["display"] = "none";
				this.divMixListCheckout.Style["display"] = "none";
				this.divForecastCheckout.Style["display"] = "none";
				this.divFinishGridH.Style["display"] = "none";
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Grid areas could not be hidden: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void HideShiftsIngvFinishView()
		{
			try
			{
				GridViewRow row;
				HtmlTableRow tr;
				for (int rowid = 0; rowid < gvFinishView.Rows.Count; rowid++)
				{
					row = gvFinishView.Rows[rowid];
					if (row.RowType == DataControlRowType.DataRow)
					{
						for (int icol = 4; icol <= 28; icol++)
						{
							if ((icol <= 10 && (_FinishView == 0 || _FinishView == 1 || _FinishView == 3)) || (icol > 10 && icol <= 17 && (_FinishView == 0 || _FinishView == 1 || _FinishView == 4)) || (icol > 17 && (_FinishView == 0 || _FinishView == 2)))
							{
								if (_UseShift2 == false)
								{
									tr = (HtmlTableRow)row.FindControl("trFinishc" + icol.ToString() + "s2");
									tr.Style["display"] = "none";
								}
								else
								{
									tr = (HtmlTableRow)row.FindControl("trFinishc" + icol.ToString() + "s2");
									tr.Style["display"] = "table-row";
								}
								if (_UseShift3 == false)
								{
									tr = (HtmlTableRow)row.FindControl("trFinishc" + icol.ToString() + "s3");
									tr.Style["display"] = "none";
								}
								else
								{
									tr = (HtmlTableRow)row.FindControl("trFinishc" + icol.ToString() + "s3");
									tr.Style["display"] = "table-row";
								}
							}
						}
					}

					// hide or show shift totals
					if (_UseShift2 == false)
					{
						tr = (HtmlTableRow)row.FindControl("trFinishc30s2");
						tr.Style["display"] = "none";
					}
					else
					{
						tr = (HtmlTableRow)row.FindControl("trFinishc30s2");
						tr.Style["display"] = "table-row";
					}
					if (_UseShift3 == false)
					{
						tr = (HtmlTableRow)row.FindControl("trFinishc30s3");
						tr.Style["display"] = "none";
					}
					else
					{
						tr = (HtmlTableRow)row.FindControl("trFinishc30s3");
						tr.Style["display"] = "table-row";
					}
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error while hiding unused shifts: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void HideStrategicForecast()
		{
			for (int row = 16; row <= 26; row++)
			{
				gvForecastData.Columns[row].Visible = false;
			}
		}

		protected void HideStrategicPresentationPV()
		{
			for (int row = 18; row <= 28; row++)
			{
				gvFinishView.Columns[row].Visible = false;
			}
		}

		protected void HideTacticalForecast()
		{
			for (int row = 2; row <= 15; row++)
			{
				gvForecastData.Columns[row].Visible = false;
			}
		}

		protected void HideTacticalForecastWeek1()
		{
			for (int row = 2; row <= 8; row++)
			{
				gvForecastData.Columns[row].Visible = false;
			}
		}

		protected void HideTacticalForecastWeek2()
		{
			for (int row = 9; row <= 15; row++)
			{
				gvForecastData.Columns[row].Visible = false;
			}
		}

		protected void HideTacticalPresentationPV()
		{
			for (int row = 4; row <= 17; row++)
			{
				gvFinishView.Columns[row].Visible = false;
			}
		}

		protected void IdentifyPMID()
		{
			try
			{
				string ptype = ddlProdProdTypeListE.SelectedValue;
				string pcode = ddlProdProductListE.SelectedValue;
				string len = ddlLengthT.SelectedValue;
				string color = ddlColorT.SelectedValue;
				string sort = ddlSortT.SelectedValue;
				string milling = ddlMillingT.SelectedValue;
				string noprint = ddlNoPrintT.SelectedValue;
				Forecast fc = new Forecast();
				DataTable dt = fc.SelectProductManagedData(_LocationCode, ptype, pcode, len, color, sort, milling, noprint, _UserID);
				if (dt.Rows.Count > 0)
				{
					this.hfProdManagedIDE.Value = dt.Rows[0]["ProductManagedID"].ToString();
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error when identifying managed product: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void LoadLocationSettings()
		{
			try
			{
				int maxshift = 3;
				Forecast fc = new Forecast();
				DataTable dt = fc.SelectForecastCodeList(_LocationCode, _RegionCode, "Setting", 0, 1, 1, 1, _UserID);
				if (dt.Rows.Count > 0)
				{
					for (int row = 0; row < dt.Rows.Count; row++)
					{
						switch (dt.Rows[row]["Code"].ToString().ToUpper())
						{
							case "USESHIFT1":
								if (dt.Rows[row]["CodeValue"].ToString().ToUpper() == "YES")
								{
									_UseShift1 = true;
								}
								else
								{
									_UseShift1 = false;
								}
								ViewState["UseShift1"] = _UseShift1.ToString();
								break;
							case "USESHIFT2":
								if (dt.Rows[row]["CodeValue"].ToString().ToUpper() == "YES")
								{
									_UseShift2 = true;
								}
								else
								{
									_UseShift2 = false;
								}
								ViewState["UseShift2"] = _UseShift2.ToString();
								break;
							case "USESHIFT3":
								if (dt.Rows[row]["CodeValue"].ToString().ToUpper() == "YES")
								{
									_UseShift3 = true;
								}
								else
								{
									_UseShift3 = false;
								}
								ViewState["UseShift3"] = _UseShift3.ToString();
								break;
							default:
								break;
						}
					}
					if (_UseShift3 == false)
					{
						maxshift = 2;
						if (_UseShift2 == false) { maxshift = 1; }
					}
				}
				this.hfMaxShiftID.Value = maxshift.ToString();
				_MaxShift = maxshift;
				ViewState["MaxShift"] = maxshift.ToString();
				string jsScript = "";
				jsScript = "<script type=\"text/javascript\">SetMaxShift(" + maxshift.ToString() + ");</script>";
				Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "MyLocationSettings", jsScript);
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error loading location settings: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected bool LoadUserLocations()
		{
			bool okay = true;
			try
			{
				Forecast fc = new Forecast();
				DataTable dt = fc.SelectUserForecastLocationList(_RegionCode, "", "", "", "", 0, 0, 1, _UserID);
				int NbrRows = dt.Rows.Count;
				switch (NbrRows)
				{
					case 0:
						okay = false;
						_RegionCode = string.Empty;
						this._ErrMsg = "No locations were found that you have access to.";
						this.lblErrorMsg.Text = this._ErrMsg;
						break;
					case 1:
						// do nothing
						_RegionCode = dt.Rows[0]["RegionCode"].ToString();
						_LocationName = dt.Rows[0]["LocationName"].ToString();
						break;
					default:
						_HasMultiLocs = true;
						this.spnLocationListAdm.Style["display"] = "inline";
						this.spnLocationIdent.Style["display"] = "none";
						this.ddlLocationListF.DataTextField = "LocationName";
						this.ddlLocationListF.DataValueField = "LocationCode";
						this.ddlLocationListF.DataSource = dt;
						this.ddlLocationListF.DataBind();
						this.ddlLocationListF.ClearSelection();
						this.ddlLocationListF.SelectedValue = _LocationCode;
						_RegionCode = dt.Rows[0]["RegionCode"].ToString();
						//for (int row=0;row<dt.Rows.Count;row++)
						//{
						//	if (dt.Rows[row]["LocationCode"].ToString() == _LocationCode) 
						//	{
						//		_LocationName = dt.Rows[row]["LocationName"].ToString();
						//		break;
						//	}
						//}
						break;
				}
				UpdateRegionCode();
			}
			catch (Exception ex)
			{
				okay = false;
				this._ErrMsg = "No locations were found that you have access to: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
			return okay;
		}

		protected void LoadColorList()
		{
			try
			{
				this.lblErrorMsg.Text = "";
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectProductCodeList("Color", 0, 1, 0, 0, 0, _UserID);
				if (ddlColorT.Items.Count > 1)
				{
					ClearDropDownList(ddlColorT, 1);
				}
				this.ddlColorT.DataTextField = "CodeDescription";
				this.ddlColorT.DataValueField = "CatCode";
				this.ddlColorT.DataSource = dt;
				this.ddlColorT.DataBind();
				this.ddlColorT.ClearSelection();
				this.ddlColorT.SelectedIndex = 0;

				// load color list
				if (lbxColorF.Items.Count > 1)
				{
					ClearListBox(lbxColorF, 1);
				}
				this.lbxColorF.DataTextField = "CodeDescription";
				this.lbxColorF.DataValueField = "CatCode";
				this.lbxColorF.DataSource = dt;
				this.lbxColorF.DataBind();
				this.lbxColorF.ClearSelection();
				this.lbxColorF.SelectedIndex = 0;

				// load color list 
				if (lbxColorFv.Items.Count > 1)
				{
					ClearListBox(lbxColorFv, 1);
				}
				this.lbxColorFv.DataTextField = "CodeDescription";
				this.lbxColorFv.DataValueField = "CatCode";
				this.lbxColorFv.DataSource = dt;
				this.lbxColorFv.DataBind();
				this.lbxColorFv.ClearSelection();
				this.lbxColorFv.SelectedIndex = 0;

				// load Color list for bulk copy
				if (ddlColorBC.Items.Count > 1)
				{
					ClearDropDownList(ddlColorBC, 1);
				}
				this.ddlColorBC.DataTextField = "CodeDescription";
				this.ddlColorBC.DataValueField = "CatCode";
				this.ddlColorBC.DataSource = dt;
				this.ddlColorBC.DataBind();
				this.ddlColorBC.ClearSelection();
				this.ddlColorBC.SelectedIndex = 0;
			}
			catch (Exception ex)
			{
				_ErrMsg = "Color: " + ex.Message;
				this.lblErrorMsg.Text = this.ErrorMsg;
			}
		}

		protected void LoadCurrentGrid()
		{
			this.lblErrorMsg.Text = "";
			switch (_TargetGrid)
			{
				case 1:
					LoadMixList();
					break;
				case 2:
					LoadMixContentsData();
					break;
				case 3:
					LoadProductList();
					break;
				case 4:
					LoadForecastData();
					break;
				case 5:
					_PgNbr5 = 0;
					break;
				case 6:
					LoadForecastCodes();
					break;
				case 7:
					LoadForecastFinishData();
					SetGridDateColumnHeaders(1);
					break;
				case 8:
					LoadEditLengthCodes();
					break;
				default:
					break;
			}
		}

		protected void LoadEditLengthCodes()
		{
			try
			{
				this.lblErrorMsg.Text = "";
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectProductCodeList("Length", 0, 2, 0, 0, 0, _UserID);
				this.gvLengthCodes.DataSource = dt;
				this.gvLengthCodes.DataBind();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in loading length codes list: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void LoadForecastCodes()
		{
			this.lblErrorMsg.Text = "";
			try
			{
				Forecast fc = new Forecast();
				DataTable dt = fc.SelectForecastCodeList(_LocationCode, "", "", 4, 1, 1, 1, _UserID);
				gvForecastCodes.DataSource = dt;
				gvForecastCodes.DataBind();
				if (gvForecastCodes.Rows.Count == 0)
				{
					this.lblErrorMsg.Text = "No codes were found.";
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error during code data load: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void LoadForecastData()
		{
			this.lblErrorMsg.Text = "";
			try
			{
				string species = GrabListBoxSelections(lbxSpeciesF);
				string mixIDs = GrabListBoxSelections(lbxCMixListF);
				string thick = GrabListBoxSelections(lbxThicknessF);
				string grade = GrabListBoxSelections(lbxGradeF);
				string color = GrabListBoxSelections(lbxColorF);
				string sort = GrabListBoxSelections(lbxSortF);
				string noprint = GrabListBoxSelections(lbxNoPrintF);
				string desc = txtProdDescF.Text;
				int Shift = 0;
				thick = thick.Replace("~0", "/");
				if (species == "0") { species = ""; }
				DateTime dte = DateTime.Now;
				string spec = ddlSpeciesOverall.SelectedValue;
				if (_UseCurrentWeek == 0)
				{
					dte = dte.AddDays(7);
				}
				gvForecastData.DataSource = null;
				Forecast fc = new Forecast();
				DataTable dt = fc.SelectForecast(_LocationCode, mixIDs, spec, species, thick, grade, color, sort, noprint, desc, _MatrixView, Shift, dte, _UserID);
				gvForecastData.DataSource = dt;
				gvForecastData.DataBind();
				if (dt.Rows.Count == 0)
				{
					this.lblErrorMsg.Text = "No forecast data was found matching that criteria.";
				}
				this.hfgvForecastDataNbrRows.Value = dt.Rows.Count.ToString();
				UpdateForecastColumnTotals();
				SetCheckoutData(4, 0);
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error loading forecast data: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void LoadForecastFinishData()
		{
			try
			{
				DateTime today = DateTime.Now;
				int iType = Convert.ToInt32(ddlForecastProdView.SelectedValue);
				string MixIDs = "";
				string region = GrabListBoxSelections(lbxRegionFv);
				string species = GrabListBoxSelections(lbxSpeciesFv);
				string prod = string.Empty;
				string len = GrabListBoxSelections(lbxLengthFv);
				string thick = GrabListBoxSelections(lbxThicknessFv);
				string grade = GrabListBoxSelections(lbxGradeFv);
				string color = GrabListBoxSelections(lbxColorFv);
				string sort = GrabListBoxSelections(lbxSortFv);
				string milling = GrabListBoxSelections(lbxMillingFv);
				string noprint = GrabListBoxSelections(lbxNoPrintFv);
				int Shift = 0; // Convert.ToInt32(ddlShiftProdViewF.SelectedValue);
				if (region == "0") { region = ""; }
				if (species == "0") { species = ""; }
				if (prod == "0") { prod = ""; }
				if (len == "0") { len = ""; }
				if (thick == "0") { thick = ""; }
				if (grade == "0") { grade = ""; }
				if (color == "0") { color = ""; }
				if (sort == "0") { sort = ""; }
				if (milling == "0") { milling = ""; }
				if (noprint == "0") { noprint = ""; }
				string spec = ddlSpeciesOverall.SelectedValue;
				if (_UseCurrentWeekFV != 1)
				{
					today = today.AddDays(7);
				}
				int NoEmpties = 0;
				if (this.chkNoEmptyProducts.Checked == true) { NoEmpties = 1; }
				if (milling != ViewState["FVFMilling"].ToString()) {
					_PgNbr7 = 0;
				}
				if (noprint != ViewState["FVFNoPrint"].ToString()) {
					_PgNbr7 = 0;
				}
				if (Shift.ToString() != ViewState["FVFShift"].ToString()) {
					_PgNbr7 = 0;
				}
				if (iType.ToString() != ViewState["FVFType"].ToString()) {
					_PgNbr7 = 0;
				}

				if (region != ViewState["FVFReg"].ToString() || species != ViewState["FVFSpec"].ToString() || prod != ViewState["FVFProd"].ToString() || len != ViewState["FVFLen"].ToString() || thick != ViewState["FVFThick"].ToString() || grade != ViewState["FVFGrade"].ToString() || color != ViewState["FVFColor"].ToString() || sort != ViewState["FVFSort"].ToString() || milling != ViewState["FVFMilling"].ToString() || noprint != ViewState["FVFNoPrint"].ToString() || Shift.ToString() != ViewState["FVFShift"].ToString() || iType.ToString() != ViewState["FVFType"].ToString())
				{
					_PgNbr7 = 0;
					gvFinishView.PageIndex = 0;
					ViewState["PageNbr7"] = _PgNbr7.ToString();
				}

				SetFiltersInState(MixIDs, prod, region, species, thick, grade, len, color, sort, milling, noprint, Shift, iType, NoEmpties);
				SetGridDateColumnHeaders(1);
				Forecast fc = new Forecast();
				DataTable dt;
				if (_ShowHistGrid == false || this.txtTargetDateH.Text == "")
				{
					dt = fc.SelectForecastProductView(_LocationCode, MixIDs, prod, region, species, thick, grade, len, color, sort, milling, noprint, Shift, iType, today, NoEmpties, 0, 9999, _UserID);
				}
				else
				{
					today = Convert.ToDateTime(this.txtTargetDateH.Text);
					_TargetDate = today;
					ViewState["TargetDate"] = this.txtTargetDateH.Text;
					dt = fc.SelectForecastProductViewHistory(_LocationCode, MixIDs, prod, region, species, thick, grade, len, color, sort, milling, noprint, Shift, iType, today, NoEmpties, 0, 9999, _UserID);
				}
				gvFinishView.DataSource = dt;
				gvFinishView.DataBind();
				if (dt.Rows.Count == 0)
				{
					this._ErrMsg = "No product data matching your criteria could be found.";
					this.lblErrorMsg.Text = this._ErrMsg;
				}
				this.hfgvFinishNbrRows.Value = dt.Rows.Count.ToString();
				HideShiftsIngvFinishView();
				SetGridDateColumnHeaders(1);
				UpdateFinishColumnTotals();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in loading finish presentation data: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void LoadGradeList()
		{
			try
			{
				this.lblErrorMsg.Text = "";
				Forecast fc = new Forecast();
				DataTable dt = fc.SelectForecastRegionCodeList(_LocationCode, _RegionCode, "Grade", 0, 1, 0, 1, _UserID);
				_GradeList = dt;
				ViewState["GradeList"] = _GradeList;
				// load filter drop down
				if (lbxGradeF.Items.Count > 1)
				{
					ClearListBox(lbxGradeF, 1);
				}
				this.lbxGradeF.DataTextField = "CodeDescription";
				this.lbxGradeF.DataValueField = "Code";
				this.lbxGradeF.DataSource = dt;
				this.lbxGradeF.DataBind();
				this.lbxGradeF.ClearSelection();
				this.lbxGradeF.SelectedValue = "0";
				// load mix edit item drop down
				if (lbxGradeF.Items.Count > 1)
				{
					ClearDropDownList(ddlGradeForMixItem, 1);
				}
				this.ddlGradeForMixItem.DataTextField = "CodeDescription";
				this.ddlGradeForMixItem.DataValueField = "Code";
				this.ddlGradeForMixItem.DataSource = dt;
				this.ddlGradeForMixItem.DataBind();
				this.ddlGradeForMixItem.ClearSelection();
				this.ddlGradeForMixItem.SelectedValue = "0";
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Grade: " + ex.Message;
				this.lblErrorMsg.Text = this.ErrorMsg;
			}
		}

		protected void LoadLengthList()
		{
			try
			{
				this.lblErrorMsg.Text = "";
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectProductCodeList("Length", 0, 1, 0, 0, 0, _UserID);
				_LengthList = dt;
				ViewState["LengthList"] = _LengthList;
				if (ddlLengthT.Items.Count > 1)
				{
					ClearDropDownList(ddlLengthT, 1);
				}
				this.ddlLengthT.DataTextField = "CodeDescription";
				this.ddlLengthT.DataValueField = "CatCode";
				this.ddlLengthT.DataSource = dt;
				this.ddlLengthT.DataBind();
				this.ddlLengthT.ClearSelection();
				this.ddlLengthT.SelectedIndex = 0;
				// load mix list ddl
				if (ddlLengthForMixItem.Items.Count > 1)
				{
					ClearDropDownList(ddlLengthForMixItem, 1);
				}
				this.ddlLengthForMixItem.DataTextField = "CodeDescription";
				this.ddlLengthForMixItem.DataValueField = "CatCode";
				this.ddlLengthForMixItem.DataSource = dt;
				this.ddlLengthForMixItem.DataBind();
				this.ddlLengthForMixItem.ClearSelection();
				this.ddlLengthForMixItem.SelectedIndex = 0;

				// bulk copy
				if (ddlLengthBC.Items.Count > 1)
				{
					ClearDropDownList(ddlLengthBC, 1);
				}
				this.ddlLengthBC.DataTextField = "CodeDescription";
				this.ddlLengthBC.DataValueField = "CatCode";
				this.ddlLengthBC.DataSource = dt;
				this.ddlLengthBC.DataBind();
				this.ddlLengthBC.ClearSelection();
				this.ddlLengthBC.SelectedIndex = 0;

				if (ddlMixProdLength.Items.Count > 1)
				{
					ClearDropDownList(ddlMixProdLength, 1);
				}
				this.ddlMixProdLength.DataTextField = "CodeDescription";
				this.ddlMixProdLength.DataValueField = "CatCode";
				this.ddlMixProdLength.DataSource = dt;
				this.ddlMixProdLength.DataBind();
				this.ddlMixProdLength.ClearSelection();
				this.ddlMixProdLength.SelectedIndex = 0;
			}
			catch (Exception ex)
			{
				_ErrMsg = "Color: " + ex.Message;
				this.lblErrorMsg.Text = this.ErrorMsg;
			}
		}

		protected void LoadMainSpeciesList()
		{
			this.lblErrorMsg.Text = "";
			try
			{
				//string Loc = string.Empty;
				//if (_IsAdmin) { Loc = ddlLocationListF.SelectedValue; }
				//if (Loc == "0") { Loc = ""; }
				Forecast fc = new Forecast();
				DataTable dt = fc.SelectForecastCodeList(_LocationCode, "", "SPECIES", 0, 1, 0, 1, _UserID);
				ClearDropDownList(ddlSpeciesOverall, 1);
				this.ddlSpeciesOverall.DataTextField = "CodeDescription";
				this.ddlSpeciesOverall.DataValueField = "Code";
				this.ddlSpeciesOverall.DataSource = dt;
				this.ddlSpeciesOverall.DataBind();
				this.ddlSpeciesOverall.SelectedValue = "0";
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Species List could not be displayed: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void LoadMillingList()
		{
			try
			{
				this.lblErrorMsg.Text = "";
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectProductCodeList("Milling", 0, 1, 0, 0, 0, _UserID);
				// forecast
				if (ddlMillingT.Items.Count > 1)
				{
					ClearDropDownList(ddlMillingT, 1);
				}
				this.ddlMillingT.DataTextField = "CodeDescription";
				this.ddlMillingT.DataValueField = "CatCode";
				this.ddlMillingT.DataSource = dt;
				this.ddlMillingT.DataBind();
				this.ddlMillingT.ClearSelection();
				this.ddlMillingT.SelectedIndex = 0;
				// presentation 
				if (lbxMillingFv.Items.Count > 1)
				{
					ClearListBox(lbxMillingFv, 1);
				}
				this.lbxMillingFv.DataTextField = "CodeDescription";
				this.lbxMillingFv.DataValueField = "CatCode";
				this.lbxMillingFv.DataSource = dt;
				this.lbxMillingFv.DataBind();
				this.lbxMillingFv.ClearSelection();
				this.lbxMillingFv.SelectedIndex = 0;

				// bulk copy
				if (ddlMillingBC.Items.Count > 1)
				{
					ClearDropDownList(ddlMillingBC, 1);
				}
				this.ddlMillingBC.DataTextField = "CodeDescription";
				this.ddlMillingBC.DataValueField = "CatCode";
				this.ddlMillingBC.DataSource = dt;
				this.ddlMillingBC.DataBind();
				this.ddlMillingBC.ClearSelection();
				this.ddlMillingBC.SelectedIndex = 0;
			}
			catch (Exception ex)
			{
				_ErrMsg = "Color: " + ex.Message;
				this.lblErrorMsg.Text = this.ErrorMsg;
			}
		}

		protected void LoadMixList()
		{
			this.lblErrorMsg.Text = "";
			try
			{
				string spec = ddlSpeciesOverall.SelectedValue;
				//gvMixList.DataSource = null;
				Forecast fc = new Forecast();
				DataTable dt = fc.SelectForecastMixList(_LocationCode, 0, spec, 0, 2, _UserID);
				this.gvMixList.DataSource = dt;
				this.gvMixList.DataBind();
				if (dt.Rows.Count == 0)
				{
					this._ErrMsg = "Mix list contains no rows of data.";
					this.lblErrorMsg.Text = this._ErrMsg;
				}
				this.divMixList.Style["display"] = "block";
				SetCheckoutData(2, 0);
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Mix list load produced an error: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void LoadMixListOnMixProdList(DataTable dt)
		{
			ddlMixListProdContents.DataTextField = "MixFullName";
			ddlMixListProdContents.DataValueField = "ForecastMixID";
			ddlMixListProdContents.DataSource = dt;
			ddlMixListProdContents.DataBind();
		}

		protected void LoadMixListOnForecast(DataTable dt)
		{
			this.lbxCMixListF.DataTextField = "MixFullName";
			this.lbxCMixListF.DataValueField = "ForecastMixID";
			this.lbxCMixListF.DataSource = dt;
			this.lbxCMixListF.DataBind();
		}

		protected void LoadMixContentsMixList()
		{
			this.lblErrorMsg.Text = "";
			try
			{
				string spec = ddlSpeciesOverall.SelectedValue;
				Forecast fc = new Forecast();
				DataTable dt = fc.SelectForecastMixList(_LocationCode, 0, spec, 0, 1, _UserID);
				ddlMixListProdContents.DataTextField = "MixFullName";
				ddlMixListProdContents.DataValueField = "ForecastMixID";
				ddlMixListProdContents.DataSource = dt;
				ddlMixListProdContents.DataBind();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Mix Contents mix list could not be displayed: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}

		}

		protected void LoadMixContentsData()
		{
			this.lblErrorMsg.Text = "";
			_TotalItems = 0;
			_TotalPercentage = 0;
			ViewState["TotalItems"] = _TotalItems.ToString();
			ViewState["TotalPercentage"] = _TotalPercentage.ToString();
			try
			{
				int MixID = Convert.ToInt32(ddlMixListProdContents.SelectedValue);
				if (MixID == 0)
				{
					this._ErrMsg = "No mix was selected.";
					this.lblErrorMsg.Text = this._ErrMsg;
				}
				else
				{
					Forecast fc = new Forecast();
					DataTable dt = fc.SelectForecastMixProducts(_LocationCode, MixID, 0, 1, _UserID);
					gvMixContents.DataSource = dt;
					gvMixContents.DataBind();
					if (dt.Rows.Count == 0)
					{
						this._ErrMsg = "No product content was found for that mix.";
						this.lblErrorMsg.Text = this._ErrMsg;
						divMixSummary.Style["display"] = "none";
					}
					else
					{
						divMixSummary.Style["display"] = "block";
					}
				}
				SetCheckoutData(3, 0);
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Mix Contents could not be extracted: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void LoadNoPrintList()
		{
			try
			{
				this.lblErrorMsg.Text = "";
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectProductCodeList("NoPrint", 0, 1, 0, 0, 0, _UserID);
				this.ddlNoPrintT.DataTextField = "CodeDescription";
				this.ddlNoPrintT.DataValueField = "CatCode";
				this.ddlNoPrintT.DataSource = dt;
				this.ddlNoPrintT.DataBind();
				this.ddlNoPrintT.ClearSelection();
				this.ddlNoPrintT.SelectedIndex = 0;
				// forecast
				this.lbxNoPrintF.DataTextField = "CodeDescription";
				this.lbxNoPrintF.DataValueField = "CatCode";
				this.lbxNoPrintF.DataSource = dt;
				this.lbxNoPrintF.DataBind();
				this.lbxNoPrintF.ClearSelection();
				this.lbxNoPrintF.SelectedIndex = 0;
				// final presentation
				this.lbxNoPrintFv.DataTextField = "CodeDescription";
				this.lbxNoPrintFv.DataValueField = "CatCode";
				this.lbxNoPrintFv.DataSource = dt;
				this.lbxNoPrintFv.DataBind();
				this.lbxNoPrintFv.ClearSelection();
				this.lbxNoPrintFv.SelectedIndex = 0;

				// bulk copy
				this.ddlNoPrintBC.DataTextField = "CodeDescription";
				this.ddlNoPrintBC.DataValueField = "CatCode";
				this.ddlNoPrintBC.DataSource = dt;
				this.ddlNoPrintBC.DataBind();
				this.ddlNoPrintBC.ClearSelection();
				this.ddlNoPrintBC.SelectedIndex = 0;
			}
			catch (Exception ex)
			{
				_ErrMsg = "Color: " + ex.Message;
				this.lblErrorMsg.Text = this.ErrorMsg;
			}
		}

		protected void LoadProductDDL(int Mix)
		{
			this.lblErrorMsg.Text = "";
			string loc = string.Empty;
			try
			{
				Forecast fc = new Forecast();
				DataTable dt = fc.SelectForecastProductList(_LocationCode, _RegionCode, "", Mix, 0, 1, _UserID); // all products for location
				if (ddlProdItemE.Items.Count > 1)
				{
					ClearDropDownList(ddlProdItemE, 1);
				}
				// update product drop down list
				ddlProdItemE.DataValueField = "ProductManagedID";
				ddlProdItemE.DataTextField = "sManagedItemIdent"; // "ProdDesc";
				ddlProdItemE.DataSource = dt;
				ddlProdItemE.DataBind();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Loading product list produced an error: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void LoadProductList()
		{
			this.lblErrorMsg.Text = "";
			string loc = _LocationCode;
			try
			{
				if (loc == "0") { loc = ""; }
				Forecast fc = new Forecast();
				DataTable dt = fc.SelectForecastProductList(loc, _RegionCode, "", 0, 0, 1, _UserID);
				this.gvProducts.DataSource = dt;
				this.gvProducts.DataBind();
				if (dt.Rows.Count == 0)
				{
					this._ErrMsg = "Product list contains no rows of data.";
					this.lblErrorMsg.Text = this._ErrMsg;
				}
				SetCheckoutData(1, 0);
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Product list load produced an error: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void LoadProductMasterListDDL()
		{
			// product list on Product Edit Item form
			this.lblErrorMsg.Text = "";
			string loc = string.Empty;
			try
			{
				Commands cmd = new Commands();
				int showall = 0;
				if (chkShowAllProducts.Checked == true) { showall = 1; }
				string pt = ddlProdProdTypeListE.SelectedValue;
				DataTable dt = cmd.SelectProductListMaster(pt, _RegionCode, showall, 0, 1, 0, _UserID);
				// update Mix-Product select list
				ClearDropDownList(ddlProdProductListE, 1);
				ddlProdProductListE.DataValueField = "product";
				ddlProdProductListE.DataTextField = "description";
				ddlProdProductListE.DataSource = dt;
				ddlProdProductListE.DataBind();
				ddlProdProductListE.ClearSelection();
				ddlProdProductListE.SelectedValue = "0";
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Loading product master list produced an error: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}

		}

		protected void LoadSpeciesDDL()
		{
			this.lblErrorMsg.Text = "";
			try
			{
				//string Loc = string.Empty;
				//if (_IsAdmin) { Loc = ddlLocationListF.SelectedValue; }
				//if (Loc == "0") { Loc = ""; }
				//Forecast fc = new Forecast();
				//DataTable dt = fc.SelectForecastCodeList(_LocationCode, "", "SPECIES", 0, 1, 0, 1, _UserID);
				Forecast fc = new Forecast();
				DataTable dt = fc.SelectForecastRegionCodeList(_LocationCode, _RegionCode, "Species", 0, 1, 0, 1, _UserID);
				_SpeciesList = dt;
				ViewState["SpeciesList"] = _SpeciesList;
				ClearListBox(lbxSpeciesF, 1);
				// load filter drop down
				this.lbxSpeciesF.DataTextField = "CodeDescription";
				this.lbxSpeciesF.DataValueField = "Code";
				this.lbxSpeciesF.DataSource = dt;
				this.lbxSpeciesF.DataBind();
				this.lbxSpeciesF.ClearSelection();
				this.lbxSpeciesF.SelectedValue = "0";
				// load mix edit item 
				if (ddlSpeciesForMixItem.Items.Count > 1)
				{
					ClearDropDownList(ddlSpeciesForMixItem, 1);
				}
				this.ddlSpeciesForMixItem.DataTextField = "CodeDescription";
				this.ddlSpeciesForMixItem.DataValueField = "Code";
				this.ddlSpeciesForMixItem.DataSource = dt;
				this.ddlSpeciesForMixItem.DataBind();
				this.ddlSpeciesForMixItem.ClearSelection();
				this.ddlSpeciesForMixItem.SelectedValue = "0";
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Species List could not be displayed: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void LoadSortList()
		{
			try
			{
				this.lblErrorMsg.Text = "";
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectProductCodeList("Sort", 0, 1, 0, 0, 0, _UserID);
				if (ddlSortT.Items.Count > 1)
				{
					ClearDropDownList(ddlSortT, 1);
				}
				this.ddlSortT.DataTextField = "CodeDescription";
				this.ddlSortT.DataValueField = "CatCode";
				this.ddlSortT.DataSource = dt;
				this.ddlSortT.DataBind();
				this.ddlSortT.ClearSelection();
				this.ddlSortT.SelectedIndex = 0;
				// forecast
				if (lbxSortF.Items.Count > 1)
				{
					ClearListBox(lbxSortF, 1);
				}
				this.lbxSortF.DataTextField = "CodeDescription";
				this.lbxSortF.DataValueField = "CatCode";
				this.lbxSortF.DataSource = dt;
				this.lbxSortF.DataBind();
				this.lbxSortF.ClearSelection();
				this.lbxSortF.SelectedIndex = 0;
				// final presentation
				if (lbxSortFv.Items.Count > 1)
				{
					ClearListBox(lbxSortFv, 1);
				}
				this.lbxSortFv.DataTextField = "CodeDescription";
				this.lbxSortFv.DataValueField = "CatCode";
				this.lbxSortFv.DataSource = dt;
				this.lbxSortFv.DataBind();
				this.lbxSortFv.ClearSelection();
				this.lbxSortFv.SelectedIndex = 0;

				// bulk copy
				if (ddlSortBC.Items.Count > 1)
				{
					ClearDropDownList(ddlSortBC, 1);
				}
				this.ddlSortBC.DataTextField = "CodeDescription";
				this.ddlSortBC.DataValueField = "CatCode";
				this.ddlSortBC.DataSource = dt;
				this.ddlSortBC.DataBind();
				this.ddlSortBC.ClearSelection();
				this.ddlSortBC.SelectedIndex = 0;
			}
			catch (Exception ex)
			{
				_ErrMsg = "Sort: " + ex.Message;
				this.lblErrorMsg.Text = this.ErrorMsg;
			}
		}

		protected void LoadThicklistList()
		{
			try
			{
				this.lblErrorMsg.Text = "";
				//Commands cmd = new Commands();
				//DataTable dt = cmd.SelectProductCodeList("Thickness", 0, 1, 0, 0, 0, _UserID);
				Forecast fc = new Forecast();
				DataTable dt = fc.SelectForecastRegionCodeList(_LocationCode, _RegionCode, "Thickness", 0, 1, 0, 1, _UserID);
				_ThickList = dt;
				ViewState["ThicknessList"] = _ThickList;
				// load filter dropdown
				if (lbxThicknessF.Items.Count > 1)
				{
					ClearListBox(lbxThicknessF, 1);
				}
				this.lbxThicknessF.DataTextField = "CodeDescription";
				this.lbxThicknessF.DataValueField = "Code";
				this.lbxThicknessF.DataSource = dt;
				this.lbxThicknessF.DataBind();
				this.lbxThicknessF.ClearSelection();
				this.lbxThicknessF.SelectedValue = "0";
				// load mix edit drop down
				if (ddlThicknessForMixItem.Items.Count > 1)
				{
					ClearDropDownList(ddlThicknessForMixItem, 1);
				}
				this.ddlThicknessForMixItem.DataTextField = "CodeDescription";
				this.ddlThicknessForMixItem.DataValueField = "Code";
				this.ddlThicknessForMixItem.DataSource = dt;
				this.ddlThicknessForMixItem.DataBind();
				this.ddlThicknessForMixItem.ClearSelection();
				this.ddlThicknessForMixItem.SelectedValue = "0";
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Thickness: " + ex.Message;
				this.lblErrorMsg.Text = this.ErrorMsg;
			}
		}

		protected bool SaveForecastItemData(int MixID, int Shift, int Wk, int Dy, double Qty, int iType)
		{
			bool Okay = true;
			try
			{
				if (Wk > 2 && iType == 0)
				{
					iType = 1;
				}
				DateTime pdt = GetProdDate(Wk, Dy); //Convert.ToDateTime(ProdDate);
				Forecast fc = new Forecast();
				DataTable dt = fc.UpdateForecastCell(0, _LocationCode, iType, MixID, pdt, Wk, Dy, Shift, Qty, 1, _UserID);
			}
			catch (Exception ex)
			{
				Okay = false;
			}
			return Okay;
		}

		protected void SetCheckoutData(int iArea, int Action)
		{
			// Action: 0-checkout, 1-checkin
			try
			{
				_CanEdit = true;
				ViewState["CanEdit"] = "1";
				int iRows = 0;
				Commands cmd = new Commands();
				// check old grid back in if there was one
				if (_CheckoutGridID > 0 && _CheckoutGridID != iArea)
				{
					DataTable dt2 = cmd.CheckInOutEditArea(_UserID, _LocationCode, _CheckoutGridID, 1, _UserID);
				}
				DataTable dt = cmd.CheckInOutEditArea(_UserID, _LocationCode, iArea, Action, _UserID);
				// if checkout
				iRows = dt.Rows.Count;
				if (Action == 0 && iRows > 0)
				{
					int StatusID = Convert.ToInt32(dt.Rows[0]["StatusID"]);
					switch (StatusID)
					{
						case 0: // okay checkout succeeded
							_CheckoutGridID = iArea;
							ViewState["CheckoutGridID"] = _CheckoutGridID.ToString();
							break;
						case 1:
							_CanEdit = false;
							ViewState["CanEdit"] = "0";
							string CheckOutBy = dt.Rows[0]["CheckedOutByName"].ToString();
							string CheckOutTime = dt.Rows[0]["CheckedOutTime"].ToString();
							switch (iArea)
							{
								case 1: // Products
									lblProdListCheckoutPerson.Text = CheckOutBy;
									lblProdListCheckoutTime.Text = CheckOutTime;
									divProductListCheckout.Style["display"] = "block";
									break;
								case 2: // Mix List
									lblMixListCheckoutPerson.Text = CheckOutBy;
									lblMixListCHeckoutTime.Text = CheckOutTime;
									divMixListCheckout.Style["display"] = "block";
									break;
								case 3: // Mix Contents
									lblMixContentsCheckoutPerson.Text = CheckOutBy;
									lblMixContentsCheckoutTime.Text = CheckOutTime;
									divMixContentsCheckout.Style["display"] = "block";
									break;
								case 4: // Forecast
									lblForecastCheckoutPerson.Text = CheckOutBy;
									lblForecastCheckoutTime.Text = CheckOutTime;
									divForecastCheckout.Style["display"] = "block";
									break;
								default:
									break;
							}
							break;
						default:
							break;
					}
				}
				else
				{
					if (iRows == 0)
					{
						this._ErrMsg = "Unexpected result when checking out.";
						this.lblErrorMsg.Text = this._ErrMsg;
					}
					else
					{
						if (Action > 1)
						{
							HideAllGridAreas();
						}
					}
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Checkout attempt failed: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void SetFiltersInState(string mix, string prod, string reg, string spec, string thk, string grad, string len, string col, string sort, string mill, string nop, int shft, int itype, int noe)
		{
			ViewState["FVFMix"] = mix;
			ViewState["FVFProd"] = prod;
			ViewState["FVFReg"] = reg;
			ViewState["FVFSpec"] = spec;
			ViewState["FVFThick"] = thk;
			ViewState["FVFGrade"] = grad;
			ViewState["FVFLen"] = len;
			ViewState["FVFColor"] = col;
			ViewState["FVFSort"] = sort;
			ViewState["FVFMilling"] = mill;
			ViewState["FVFNoPrint"] = nop;
			ViewState["FVFShift"] = shft.ToString();
			ViewState["FVFType"] = itype.ToString();
			ViewState["FVFNoEmpties"] = noe.ToString();
		}

		protected void SetForecastView(int iView)
		{
			try
			{
				if (_ForecastView != iView)
				{
					_ForecastView = iView;
					ViewState["ForecastView"] = _ForecastView.ToString();
					switch (_ForecastView)
					{
						case 0: //both
							ShowTacticalForecast();
							ShowStrategicForecast();
							break;
						case 1: //tactical
							ShowTacticalForecast();
							HideStrategicForecast();
							break;
						case 2: //strategic
							HideTacticalForecast();
							ShowStrategicForecast();
							break;
						case 3: //week 1 onlyi
							ShowJustForecastWeek1();
							break;
						case 4: //week 2 only
							ShowJustForecastWeek2();
							break;
						default:
							break;
					}
					LoadForecastData();
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error establishing forecast view: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void SetGridDateColumnHeaders(int iGrid)
		{
			try
			{
				DateTime BaseDate = new DateTime();
				DateTime monday1 = DateTime.Now.AddDays(-(int)DateTime.Now.DayOfWeek + 1); //1 8 15 22 29 36 43 50 57 64 71 78 85
				if (_ShowHistGrid == true && this.txtTargetDateH.Text != "")
				{
					_TargetDate = Convert.ToDateTime(this.txtTargetDateH.Text);
					ViewState["TargetDate"] = this.txtTargetDateH.Text;
					BaseDate = _TargetDate.AddDays(-(int)_TargetDate.DayOfWeek + 1);
					monday1 = BaseDate;
				}

				// set base date for current grid
				switch (iGrid)
				{
					case 0:
						if (_UseCurrentWeek == 1 || _ShowHistGrid == true)
						{
							_BaseDate = monday1;
						}
						else
						{
							_BaseDate = monday1.AddDays(7);
						}
						ViewState["BaseDate"] = _BaseDate.ToString();
						BaseDate = _BaseDate;
						break;
					case 1:
						if (_UseCurrentWeekFV == 1 || _ShowHistGrid == true)
						{
							_BaseDatePV = monday1;
						}
						else
						{
							_BaseDatePV = monday1.AddDays(7);
						}
						ViewState["BaseDatePV"] = _BaseDate.ToString();
						BaseDate = _BaseDatePV;
						break;
					default:
						break;
				}

				// calculate dates for column headers
				var format1 = BaseDate.ToString("yyyy-MM-dd");
				DateTime monday2 = BaseDate.AddDays(7);
				var format2 = monday2.ToString("yyyy-MM-dd");
				DateTime monday3 = BaseDate.AddDays(18);
				var format3 = monday3.ToString("yyyy-MM-dd");
				DateTime monday4 = BaseDate.AddDays(25);
				var format4 = monday4.ToString("yyyy-MM-dd");
				DateTime monday5 = BaseDate.AddDays(33);
				var format5 = monday5.ToString("yyyy-MM-dd");
				DateTime monday6 = BaseDate.AddDays(39);
				var format6 = monday6.ToString("yyyy-MM-dd");
				DateTime monday7 = BaseDate.AddDays(46);
				var format7 = monday7.ToString("yyyy-MM-dd");
				DateTime monday8 = BaseDate.AddDays(53);
				var format8 = monday8.ToString("yyyy-MM-dd");
				DateTime monday9 = BaseDate.AddDays(60);
				var format9 = monday9.ToString("yyyy-MM-dd");
				DateTime monday10 = BaseDate.AddDays(67);
				var format10 = monday10.ToString("yyyy-MM-dd");
				DateTime monday11 = BaseDate.AddDays(74);
				var format11 = monday11.ToString("yyyy-MM-dd");
				DateTime monday12 = BaseDate.AddDays(81);
				var format12 = monday12.ToString("yyyy-MM-dd");
				DateTime monday13 = BaseDate.AddDays(88);
				var format13 = monday13.ToString("yyyy-MM-dd");
				DateTime Tue1 = BaseDate.AddDays(1);
				DateTime Wed1 = BaseDate.AddDays(2);
				DateTime Thu1 = BaseDate.AddDays(3);
				DateTime Fri1 = BaseDate.AddDays(4);
				DateTime Sat1 = BaseDate.AddDays(5);
				DateTime Sun1 = BaseDate.AddDays(6);
				DateTime Tue2 = monday2.AddDays(1);
				DateTime Wed2 = monday2.AddDays(2);
				DateTime Thu2 = monday2.AddDays(3);
				DateTime Fri2 = monday2.AddDays(4);
				DateTime Sat2 = monday2.AddDays(5);
				DateTime Sun2 = monday2.AddDays(6);

				// load values into grid header columns
				switch (iGrid)
				{
					case 0:
						this.gvForecastData.Columns[2].HeaderText = format1;
						this.gvForecastData.Columns[3].HeaderText = Tue1.ToString("yyyy-MM-dd");
						this.gvForecastData.Columns[4].HeaderText = Wed1.ToString("yyyy-MM-dd");
						this.gvForecastData.Columns[5].HeaderText = Thu1.ToString("yyyy-MM-dd");
						this.gvForecastData.Columns[6].HeaderText = Fri1.ToString("yyyy-MM-dd");
						this.gvForecastData.Columns[7].HeaderText = Sat1.ToString("yyyy-MM-dd");
						this.gvForecastData.Columns[8].HeaderText = Sun1.ToString("yyyy-MM-dd");
						this.gvForecastData.Columns[9].HeaderText = format2;
						this.gvForecastData.Columns[10].HeaderText = Tue2.ToString("yyyy-MM-dd");
						this.gvForecastData.Columns[11].HeaderText = Wed2.ToString("yyyy-MM-dd");
						this.gvForecastData.Columns[12].HeaderText = Thu2.ToString("yyyy-MM-dd");
						this.gvForecastData.Columns[13].HeaderText = Fri2.ToString("yyyy-MM-dd");
						this.gvForecastData.Columns[14].HeaderText = Sat2.ToString("yyyy-MM-dd");
						this.gvForecastData.Columns[15].HeaderText = Sun2.ToString("yyyy-MM-dd");
						this.gvForecastData.Columns[16].HeaderText = format3;
						this.gvForecastData.Columns[17].HeaderText = format4;
						this.gvForecastData.Columns[18].HeaderText = format5;
						this.gvForecastData.Columns[19].HeaderText = format6;
						this.gvForecastData.Columns[20].HeaderText = format7;
						this.gvForecastData.Columns[21].HeaderText = format8;
						this.gvForecastData.Columns[22].HeaderText = format9;
						this.gvForecastData.Columns[23].HeaderText = format10;
						this.gvForecastData.Columns[24].HeaderText = format11;
						this.gvForecastData.Columns[25].HeaderText = format12;
						this.gvForecastData.Columns[26].HeaderText = format13;
						break;
					case 1:
						this.gvFinishView.Columns[4].HeaderText = format1;
						this.gvFinishView.Columns[5].HeaderText = Tue1.ToString("yyyy-MM-dd");
						this.gvFinishView.Columns[6].HeaderText = Wed1.ToString("yyyy-MM-dd");
						this.gvFinishView.Columns[7].HeaderText = Thu1.ToString("yyyy-MM-dd");
						this.gvFinishView.Columns[8].HeaderText = Fri1.ToString("yyyy-MM-dd");
						this.gvFinishView.Columns[9].HeaderText = Sat1.ToString("yyyy-MM-dd");
						this.gvFinishView.Columns[10].HeaderText = Sun1.ToString("yyyy-MM-dd");
						this.gvFinishView.Columns[11].HeaderText = format2;
						this.gvFinishView.Columns[12].HeaderText = Tue2.ToString("yyyy-MM-dd");
						this.gvFinishView.Columns[13].HeaderText = Wed2.ToString("yyyy-MM-dd");
						this.gvFinishView.Columns[14].HeaderText = Thu2.ToString("yyyy-MM-dd");
						this.gvFinishView.Columns[15].HeaderText = Fri2.ToString("yyyy-MM-dd");
						this.gvFinishView.Columns[16].HeaderText = Sat2.ToString("yyyy-MM-dd");
						this.gvFinishView.Columns[17].HeaderText = Sun2.ToString("yyyy-MM-dd");
						this.gvFinishView.Columns[18].HeaderText = format3;
						this.gvFinishView.Columns[19].HeaderText = format4;
						this.gvFinishView.Columns[20].HeaderText = format5;
						this.gvFinishView.Columns[21].HeaderText = format6;
						this.gvFinishView.Columns[22].HeaderText = format7;
						this.gvFinishView.Columns[23].HeaderText = format8;
						this.gvFinishView.Columns[24].HeaderText = format9;
						this.gvFinishView.Columns[25].HeaderText = format10;
						this.gvFinishView.Columns[26].HeaderText = format11;
						this.gvFinishView.Columns[27].HeaderText = format12;
						this.gvFinishView.Columns[28].HeaderText = format13;
						break;
					default:
						break;
				}
				//string j = string.Empty;
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error while establishing column header dates: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void ShowFinishView()
		{
			switch (_FinishView)
			{
				case 0: //both
					ShowTacticalPresentationPV();
					ShowStrategicPresentationPV();
					break;
				case 1: //tactical
					ShowTacticalPresentationPV();
					HideStrategicPresentationPV();
					break;
				case 2: //strategic
					ShowStrategicPresentationPV();
					HideTacticalPresentationPV();
					break;
				case 3: // week 1 only
					ShowFinishWeek1Only();
					break;
				case 4: // week2 only
					ShowFinishWeek2Only();
					break;
				default:
					break;
			}
			LoadForecastFinishData();
		}

		protected void ShowFinishWeek1Only()
		{
			HideStrategicPresentationPV();
			for (int row = 4; row <= 17; row++)
			{
				if (row < 11)
				{
					gvFinishView.Columns[row].Visible = true;
				}
				else
				{
					gvFinishView.Columns[row].Visible = false;
				}
			}
		}

		protected void ShowFinishWeek2Only()
		{
			HideStrategicPresentationPV();
			for (int row = 4; row <= 17; row++)
			{
				if (row > 10)
				{
					gvFinishView.Columns[row].Visible = true;
				}
				else
				{
					gvFinishView.Columns[row].Visible = false;
				}
			}
		}

		protected void ShowJustForecastWeek1()
		{
			for (int row = 2; row <= 26; row++)
			{
				if (row < 9)
				{
					gvForecastData.Columns[row].Visible = true;
				}
				else
				{
					gvForecastData.Columns[row].Visible = false;
				}
			}
		}

		protected void ShowJustForecastWeek2()
		{
			for (int row = 2; row <= 26; row++)
			{
				if (row > 8 & row < 16)
				{
					gvForecastData.Columns[row].Visible = true;
				}
				else
				{
					gvForecastData.Columns[row].Visible = false;
				}
			}
		}

		protected void ShowStrategicForecast()
		{
			for (int col = 16; col <= 26; col++)
			{
				gvForecastData.Columns[col].Visible = true;
			}
		}

		protected void ShowTacticalPresentationPV()
		{
			for (int row = 4; row <= 17; row++)
			{
				gvFinishView.Columns[row].Visible = true;
			}
		}

		protected void ShowStrategicPresentationPV()
		{
			for (int row = 18; row <= 28; row++)
			{
				gvFinishView.Columns[row].Visible = true;
			}
		}

		protected void ShowTacticalForecast()
		{
			for (int col = 2; col <= 15; col++)
			{
				gvForecastData.Columns[col].Visible = true;
			}
		}

		protected void ShowTacticalForecastWeek1()
		{
			for (int col = 2; col <= 8; col++)
			{
				gvForecastData.Columns[col].Visible = true;
			}
		}

		protected void ShowTacticalForecastWeek2()
		{
			for (int row = 9; row <= 15; row++)
			{
				gvForecastData.Columns[row].Visible = true;
			}
		}

		protected void UpdateFinishColumnTotals()
		{
			try
			{
				int Dy = 0;
				Label lbl;
				double Fig = 0;
				double StrategicAmt = 0;
				double Shift1 = 0;
				double Shift2 = 0;
				double Shift3 = 0;
				double[] Totals = new double[40];
				double TotalAmt = 0;
				double WkTotal1 = 0;
				double WkTotal2 = 0;
				int Wk = 0;
				// empty totals array
				for (int col = 0; col <= 25; col++)
				{
					Totals[col] = 0;
				}
				int nrows = gvFinishView.Rows.Count;
				for (int rowid = 0; rowid < nrows; rowid++)
				{
					Shift1 = 0;
					Shift2 = 0;
					Shift3 = 0;
					GridViewRow row = gvFinishView.Rows[rowid];
					for (int col = 4; col <= 28; col++)
					{
						Wk = 1;
						Dy = col - 3;
						if (col > 10)
						{
							Wk = 2;
							Dy = Dy - 7;
						}
						for (int shft = 1; shft <= 3; shft++)
						{
							Fig = 0;
							if (_FinishView == 0 || _FinishView == 1 || _FinishView == 3 || _FinishView == 4)
							{
								if (col < 18)
								{
									lbl = (Label)row.FindControl("lblWk" + Wk.ToString() + "_" + Dy.ToString() + "Amt" + shft.ToString() + "v");
									if (lbl.Text != "")
									{
										Fig = Convert.ToDouble(lbl.Text);
									}
								}
							}
							if (_FinishView == 0 || _FinishView == 2)
							{
								if (col > 17)
								{
									lbl = (Label)row.FindControl("lblWk" + (col - 15).ToString() + "Amt" + shft.ToString() + "v");
									if (lbl.Text != "")
									{
										Fig = Convert.ToDouble(lbl.Text);
										StrategicAmt += Fig;
									}
								}
							}

							if (Fig != 0)
							{
								Totals[col - 4] += Fig;
								TotalAmt += Fig;
								if (Wk == 1 && col < 18)
								{
									WkTotal1 += Fig;
								}
								if (Wk == 2 && col < 18)
								{
									WkTotal2 += Fig;
								}
								switch (shft)
								{
									case 1:
										Shift1 += Fig;
										break;
									case 2:
										Shift2 += Fig;
										break;
									case 3:
										Shift3 += Fig;
										break;
									default:
										break;
								}
							}
						}
					}
					if (_UseShift1 == true)
					{
						lbl = (Label)row.FindControl("lblWkTotalAmt1v");
						lbl.Text = GenUtilities.FormatNbrSpecial(Shift1, "", 1, ",", ".", 0);
					}
					if (_UseShift2 == true)
					{
						lbl = (Label)row.FindControl("lblWkTotalAmt2v");
						lbl.Text = GenUtilities.FormatNbrSpecial(Shift2, "", 1, ",", ".", 0);
					}
					if (_UseShift3 == true)
					{
						lbl = (Label)row.FindControl("lblWkTotalAmt3v");
						lbl.Text = GenUtilities.FormatNbrSpecial(Shift3, "", 1, ",", ".", 0);
					}
				}

				if (_FinishView == 2 || _FinishView == 4) { WkTotal1 = 0; }
				if (_FinishView == 2 || _FinishView == 3) { WkTotal2 = 0; }
				if (_FinishView == 1) { StrategicAmt = 0; }
				_WeekTotal1f = WkTotal1;
				_WeekTotal2f = WkTotal2;
				_StrategicTotalF = StrategicAmt;
				_TotalAmtf = TotalAmt;

				// show totals at top
				gvFinishViewAddTotalsHeaderRow(Totals);
				this.lblWeek1Totalf.Text = GenUtilities.FormatNbrSpecial(Math.Round(_WeekTotal1f, 1), "", 1, ",", ".", 1);
				this.lblWeek2Totalf.Text = GenUtilities.FormatNbrSpecial(Math.Round(_WeekTotal2f, 1), "", 1, ",", ".", 1);
				this.lblStrategicTotalf.Text = GenUtilities.FormatNbrSpecial(Math.Round(_StrategicTotalF, 1), "", 1, ",", ".", 1);
				this.lblTotalAmtf.Text = GenUtilities.FormatNbrSpecial(Math.Round(_TotalAmtf, 1), "", 1, ",", ".", 1);
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in finish column totaling: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void UpdateForecastRowTotals()
		{
			this.lblErrorMsg.Text = "";
			try
			{
				double tot1 = 0;
				double tot2 = 0;
				double tot3 = 0;
				string s = string.Empty;
				TextBox tb;
				foreach (GridViewRow r in gvForecastData.Rows)
				{
					tot1 = 0;
					tot2 = 0;
					tot3 = 0;
					// Add in tactical values
					if (_ForecastView == 0 || _ForecastView == 1 || _ForecastView == 3 || _ForecastView == 4)
					{
						for (int r1 = 2; r1 <= 8; r1++)
						{
							if (_ForecastView == 0 || _ForecastView == 1 || _ForecastView == 3)
							{
								tb = (TextBox)r.FindControl("txtWk1_" + (r1 - 1).ToString() + "Amt1");
								s = tb.Text;
								if (s != "" && GenUtilities.IsNumeric(s)) { tot1 += Convert.ToDouble(s); }
								tb = (TextBox)r.FindControl("txtWk1_" + (r1 - 1).ToString() + "Amt2");
								s = tb.Text;
								if (s != "" && GenUtilities.IsNumeric(s)) { tot2 += Convert.ToDouble(s); }
								tb = (TextBox)r.FindControl("txtWk1_" + (r1 - 1).ToString() + "Amt3");
								s = tb.Text;
								if (s != "" && GenUtilities.IsNumeric(s)) { tot3 += Convert.ToDouble(s); }
							}
							if (_ForecastView == 0 || _ForecastView == 1 || _ForecastView == 4)
							{
								tb = (TextBox)r.FindControl("txtWk2_" + (r1 - 1).ToString() + "Amt1");
								s = tb.Text;
								if (s != "" && GenUtilities.IsNumeric(s)) { tot1 += Convert.ToDouble(s); }
								tb = (TextBox)r.FindControl("txtWk2_" + (r1 - 1).ToString() + "Amt2");
								s = tb.Text;
								if (s != "" && GenUtilities.IsNumeric(s)) { tot2 += Convert.ToDouble(s); }
								tb = (TextBox)r.FindControl("txtWk2_" + (r1 - 1).ToString() + "Amt3");
								s = tb.Text;
								if (s != "" && GenUtilities.IsNumeric(s)) { tot3 += Convert.ToDouble(s); }
							}
						}
					}

					// add in Strategic values
					if (_ForecastView == 0 || _ForecastView == 2)
					{
						for (int r2 = 16; r2 <= 26; r2++)
						{
							tb = (TextBox)r.FindControl("txtWk" + (r2 - 13).ToString() + "Amt1");
							s = tb.Text;
							if (s != "" && GenUtilities.IsNumeric(s)) { tot1 += Convert.ToDouble(s); }
							tb = (TextBox)r.FindControl("txtWk" + (r2 - 13).ToString() + "Amt2");
							s = tb.Text;
							if (s != "" && GenUtilities.IsNumeric(s)) { tot2 += Convert.ToDouble(s); }
							tb = (TextBox)r.FindControl("txtWk" + (r2 - 13).ToString() + "Amt3");
							s = tb.Text;
							if (s != "" && GenUtilities.IsNumeric(s)) { tot3 += Convert.ToDouble(s); }
						}
					}

					// Update total fields
					tb = (TextBox)r.FindControl("txtWkTotalAmt1");
					tb.Text = GenUtilities.FormatNbrSpecial(tot1, "", 1, ",", ".", 2);
					tb = (TextBox)r.FindControl("txtWkTotalAmt2");
					tb.Text = GenUtilities.FormatNbrSpecial(tot2, "", 1, ",", ".", 2);
					tb = (TextBox)r.FindControl("txtWkTotalAmt3");
					tb.Text = GenUtilities.FormatNbrSpecial(tot3, "", 1, ",", ".", 2);
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error setting row totals: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void UpdateForecastColumnTotals()
		{
			try
			{
				int Dy = 0;
				TextBox txt;
				int Wk = 0;
				double[] Totals = new double[35];
				double Fig = 0;
				double StrategicAmt = 0;
				double TotalAmt = 0;
				double Wk1Total = 0;
				double Wk2Total = 0;
				// empty totals array
				for (int col = 0; col <= 25; col++)
				{
					Totals[col] = 0;
				}
				// total grid volumes
				int nrows = gvForecastData.Rows.Count;
				if (nrows > 0)
				{
					for (int rowid = 0; rowid < nrows; rowid++)
					{
						GridViewRow row = gvForecastData.Rows[rowid];
						for (int col = 2; col <= 26; col++)
						{
							Wk = 1;
							Dy = col - 1;
							if (col > 8)
							{
								Wk = 2;
								Dy = Dy - 7;
							}
							for (int shft = 1; shft <= 3; shft++)
							{
								if (shft < 2 || (shft == 2 && _UseShift2 == true) || (shft == 3 && _UseShift3 == true))
								{
									if (col < 16)
									{
										txt = (TextBox)row.FindControl("txtWk" + Wk.ToString() + "_" + Dy.ToString() + "Amt" + shft.ToString());
									}
									else
									{
										txt = (TextBox)row.FindControl("txtWk" + (col - 13).ToString() + "Amt" + shft.ToString());
									}
									if (txt.Text != "")
									{
										Fig = Convert.ToDouble(txt.Text);
										Totals[col - 2] += Fig;
										if ((_ForecastView == 0 || _ForecastView == 2) && col > 15) { StrategicAmt += Fig; }
										if (_ForecastView == 0 || (_ForecastView == 1 && col < 16) || (_ForecastView == 2 && col > 15) || ((_ForecastView == 3 && col < 9) | (_ForecastView == 4 && col > 8 && col < 16)))
										{
											TotalAmt += Fig;
										}
										if (Wk == 1 && col < 16)
										{
											Wk1Total += Fig;
										}
										if (Wk == 2 && col < 16)
										{
											Wk2Total += Fig;
										}
									}
								}
							}
						}
					}
				}
				if (_ForecastView == 2 || _ForecastView == 4) { Wk1Total = 0; }
				if (_ForecastView == 2 || _ForecastView == 3) { Wk2Total = 0; }
				if (_ForecastView == 1) { StrategicAmt = 0; }
				_TotalAmt = TotalAmt;
				_StrategicTotal = StrategicAmt;
				_WeekTotal1 = Wk1Total;
				_WeekTotal2 = Wk2Total;
				ViewState["TotalAmt"] = _TotalAmt.ToString();
				ViewState["StrategicAmt"] = _StrategicTotal.ToString();
				ViewState["WeekTotal1"] = _WeekTotal1.ToString();
				ViewState["WeekTotal2"] = _WeekTotal2.ToString();

				// show totals at top
				gvForecastDataAddTotalsRow(Totals);
				this.lblWk1Totalp.Text = GenUtilities.FormatNbrSpecial(Math.Round(_WeekTotal1, 1), "", 1, ",", ".", 1);
				this.lblWk2Totalp.Text = GenUtilities.FormatNbrSpecial(Math.Round(_WeekTotal2, 1), "", 1, ",", ".", 1);
				this.lblStrategicTotalp.Text = GenUtilities.FormatNbrSpecial(Math.Round(_StrategicTotal, 1), "", 1, ",", ".", 1);
				this.lblTotalMBFp.Text = GenUtilities.FormatNbrSpecial(Math.Round(_TotalAmt, 1), "", 1, ",", ".", 1);
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in forecast column totaling: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void UpdatePMIDData(object sender, EventArgs e)
		{
			IdentifyPMID();
		}

		protected void UpdatePresentationRowTotals()
		{
			this.lblErrorMsg.Text = "";
			try
			{
				double tot1 = 0;
				double tot2 = 0;
				double tot3 = 0;
				string s = string.Empty;
				Label lbl;
				foreach (GridViewRow r in gvFinishView.Rows)
				{
					tot1 = 0;
					tot2 = 0;
					tot3 = 0;
					// Add in tactical values
					if (_FinishView == 0 || _FinishView == 1)
					{
						for (int r1 = 4; r1 <= 10; r1++)
						{
							lbl = (Label)r.FindControl("lblWk1_" + (r1 - 1).ToString() + "Amt1v");
							s = lbl.Text;
							if (s != "" && GenUtilities.IsNumeric(s)) { tot1 += Convert.ToDouble(s); }
							lbl = (Label)r.FindControl("lblWk1_" + (r1 + 7).ToString() + "Amt1v");
							s = lbl.Text;
							if (s != "" && GenUtilities.IsNumeric(s)) { tot1 += Convert.ToDouble(s); }
							lbl = (Label)r.FindControl("lblWk1_" + (r1 - 1).ToString() + "Amt2v");
							s = lbl.Text;
							if (s != "" && GenUtilities.IsNumeric(s)) { tot2 += Convert.ToDouble(s); }
							lbl = (Label)r.FindControl("lblWk1_" + (r1 + 7).ToString() + "Amt2v");
							s = lbl.Text;
							if (s != "" && GenUtilities.IsNumeric(s)) { tot2 += Convert.ToDouble(s); }
							lbl = (Label)r.FindControl("lblWk1_" + (r1 - 1).ToString() + "Amt3v");
							s = lbl.Text;
							if (s != "" && GenUtilities.IsNumeric(s)) { tot3 += Convert.ToDouble(s); }
							lbl = (Label)r.FindControl("lblWk1_" + (r1 + 7).ToString() + "Amt3v");
							s = lbl.Text;
							if (s != "" && GenUtilities.IsNumeric(s)) { tot3 += Convert.ToDouble(s); }
						}
					}

					// add in Strategic values
					if (_FinishView == 0 || _FinishView == 2)
					{
						for (int r2 = 18; r2 <= 28; r2++)
						{
							lbl = (Label)r.FindControl("lblWk" + (r2 - 13).ToString() + "Amt1v");
							s = lbl.Text;
							if (s != "" && GenUtilities.IsNumeric(s)) { tot1 += Convert.ToDouble(s); }
							lbl = (Label)r.FindControl("lblWk" + (r2 - 13).ToString() + "Amt2v");
							s = lbl.Text;
							if (s != "" && GenUtilities.IsNumeric(s)) { tot2 += Convert.ToDouble(s); }
							lbl = (Label)r.FindControl("lblWk" + (r2 - 13).ToString() + "Amt3v");
							s = lbl.Text;
							if (s != "" && GenUtilities.IsNumeric(s)) { tot3 += Convert.ToDouble(s); }
						}
					}

					// Update total fields
					lbl = (Label)r.FindControl("lblWkTotalAmt1v");
					lbl.Text = GenUtilities.FormatNbrSpecial(tot1, "", 1, ",", ".", 2);
					lbl = (Label)r.FindControl("lblWkTotalAmt2v");
					lbl.Text = GenUtilities.FormatNbrSpecial(tot2, "", 1, ",", ".", 2);
					lbl = (Label)r.FindControl("lblWkTotalAmt3v");
					lbl.Text = GenUtilities.FormatNbrSpecial(tot3, "", 1, ",", ".", 2);
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error setting presentation row totals: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void UpdateRegionCode()
		{
			Commands cmd = new Commands();
			DataTable dt = cmd.GetRegionForLocation(_LocationCode, _UserID);
			if (dt.Rows.Count > 0)
			{
				_RegionCode = dt.Rows[0]["RegionCode"].ToString();
				lblCurrentRegion.Text = _RegionCode;
			}
			else
			{
				_RegionCode = "";
				lblCurrentRegion.Text = "NO REGION";
			}
			ViewState["RegionCode"] = _RegionCode;
			LoadSpeciesDDL();
			LoadGradeList();
			LoadThicklistList();
			LoadProductMasterListDDL();
		}

		protected void UpdateRowTotal(int rowid)
		{
			TextBox txt;
			string value = string.Empty;
			int Dy = 0;
			double[] shft = new double[5];
			int Wk = 0;
			Double qty = 0;
			for (int i = 0; i < 5; i++)
			{
				shft[i] = 0;
			}
			GridViewRow row = gvForecastData.Rows[rowid];
			// Remove 0 values
			if (_ForecastView == 0 || _ForecastView == 1 || _ForecastView == 3 || _ForecastView == 4)
			{
				Wk = 1;
				for (int ic = 2; ic <= 15; ic++)
				{
					Dy = ic - 1;
					if (_ForecastView < 3 || ((_ForecastView == 3 && ic < 9) || (_ForecastView == 4 && ic > 8)))
					{
						if (ic > 8)
						{
							Wk = 2;
							Dy = Dy - 7;
						}
						for (int s = 1; s <= 3; s++)
						{
							txt = (TextBox)row.FindControl("txtWk" + Wk.ToString() + "_" + Dy.ToString() + "Amt" + s.ToString());
							value = txt.Text;
							if (value != "")
							{
								if (GenUtilities.IsNumeric(value))
								{
									qty = Convert.ToDouble(value);
									if (qty == 0) { txt.Text = ""; }
									shft[s] += qty;
								}
							}
						}
					}
				}
			}
			// remove 0 values
			if (_ForecastView == 0 || _ForecastView == 2)
			{
				Wk = 3;
				for (int ic2 = 16; ic2 <= 26; ic2++)
				{
					for (int s2 = 1; s2 <= 3; s2++)
					{
						txt = (TextBox)row.FindControl("txtWk" + (ic2 - 13).ToString() + "Amt" + s2.ToString());
						value = txt.Text;
						if (value != "")
						{
							if (GenUtilities.IsNumeric(value))
							{
								qty = Convert.ToDouble(value);
								if (qty == 0) { txt.Text = ""; }
								shft[s2] += qty;
							}
						}
					}
					Wk = Wk + 1;
				}
			}
			for (int s3 = 1; s3 <= 3; s3++)
			{
				txt = (TextBox)row.FindControl("txtWkTotalAmt" + s3.ToString());
				txt.Text = Math.Round(shft[s3], 1).ToString();
			}
		}

		// ***************************** General UI ************************************

		protected void btnEditMixContents_Click(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			this.lblEditStatusMsg.Text = "";
			_TotalItems = 0;
			_TotalPercentage = 0;
			ViewState["TotalItems"] = _TotalItems.ToString();
			ViewState["TotalPercent"] = _TotalPercentage.ToString();
			try
			{
				_TargetGrid = 2;
				ViewState["TargetGrid"] = _TargetGrid.ToString();
				HideAllGridAreas();
				// refresh mix list
				string spec = ddlSpeciesOverall.SelectedValue;
				ClearDropDownList(ddlMixListProdContents, 1);
				Forecast fc = new Forecast();
				DataTable dt = fc.SelectForecastMixList(_LocationCode, 0, spec, 0, 2, _UserID);
				LoadMixListOnMixProdList(dt);

				// Load ProdType list

				// Load Prod List
				LoadProductMasterListDDL();
				LoadMixContentsData();
				LoadMixContentsMixList();
				this.divMixContents.Style["display"] = "block";
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Mix Contents could not be displayed: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void btnEditMixList_Click(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			this.lblEditStatusMsg.Text = "";
			try
			{
				_TargetGrid = 1;
				ViewState["TargetGrid"] = _TargetGrid.ToString();
				HideAllGridAreas();
				LoadMixList();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Mix List could not be displayed: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void btnEditForecast_Click(object sender, EventArgs e)
		{
			try
			{
				this.lblEditStatusMsg.Text = "";
				this.lblErrorMsg.Text = "";
				_TargetGrid = 4;
				ViewState["TargetGrid"] = _TargetGrid.ToString();
				HideAllGridAreas();
				lblStatusForecastMatrix.Text = "";
				ClearListBox(lbxCMixListF, 1);
				this.ddlForecastMatrixView.ClearSelection();
				this.ddlForecastMatrixView.SelectedValue = "0";
				string spec = ddlSpeciesOverall.SelectedValue;
				Forecast fc = new Forecast();
				DataTable dt = fc.SelectForecastMixList(_LocationCode, 0, spec, 0, 2, _UserID);
				this.chkEditCurrentWeek.Checked = true;
				if (_UseCurrentWeek == 1)
				{
					this.chkEditCurrentWeek.Checked = true;
				}
				else
				{
					this.chkEditCurrentWeek.Checked = false;
				}
				//ViewState["UseCurrentWeek"] = _UseCurrentWeek.ToString();
				//_ForecastView = 0;
				SetForecastView(_ForecastView);
				LoadMixListOnForecast(dt);
				LoadSpeciesDDL();
				SetGridDateColumnHeaders(0);
				LoadForecastData();
				this.divForecastMatrix.Style["display"] = "block";

				// lock first/second cols for scrolling
				//gvForecastData.HeaderRow.Cells[0].CssClass = "locked";
				//foreach (GridViewRow row in gvForecastData.Rows)
				//{ //stylesheet to firstcol 
				//	row.Cells[0].CssClass = "locked";
				//}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Forecast could not be displayed: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void btnEditProductList_Click(object sender, EventArgs e)
		{
			this.lblEditStatusMsg.Text = "";
			this.lblErrorMsg.Text = "";
			try
			{
				_TargetGrid = 3;
				lblProdIDE.Text = "";
				ViewState["TargetGrid"] = _TargetGrid.ToString();
				HideAllGridAreas();
				divProductList.Style["display"] = "block";
				this.hfProdManagedIDE.Value = "0";
				LoadProductList();
				LoadProductMasterListDDL();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Product List could not be displayed: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void gvMixList_DataBinding(object sender, EventArgs e)
		{
			// nothing
		}

		protected void gvMixList_DataBound(object sender, EventArgs e)
		{
			// nothing
		}

		protected void gvMixList_PageIndexChanged(object sender, EventArgs e)
		{
			//_PgNbr1 = 0;
			//gvMixList.PageIndex = _PgNbr1;
			//LoadMixList();
		}

		protected void gvMixList_PageIndexChanging(object sender, GridViewPageEventArgs e)
		{
			//nothing
			_PgNbr1 = e.NewPageIndex;
			ViewState["PageNbr1"] = _PgNbr1.ToString();
			gvMixList.PageIndex = _PgNbr1;
			//this.gvMixList.DataBind();
			LoadMixList();
		}

		protected void gvMixList_RowDataBound(object sender, GridViewRowEventArgs e)
		{
			this.lblErrorMsg.Text = "";
			try
			{
				CheckBox cb;

				if (e.Row.RowType == DataControlRowType.DataRow)
				{
					GridViewRow r = e.Row;
					DataRowView dv = (DataRowView)r.DataItem;
					DropDownList ddl;
					// set active checkbox
					cb = (CheckBox)e.Row.FindControl("chkMixActive");
					if (dv["sActive"].ToString() == "Yes")
					{
						cb.Checked = true;
					}
					else
					{
						cb.Checked = false;
					}
					// load and select species list
					ddl = (DropDownList)r.FindControl("ddlGVMixSpecies");
					ddl.DataSource = _SpeciesList;
					ddl.DataTextField = "CodeDescription";
					ddl.DataValueField = "Code";
					ddl.DataBind();
					if (dv["SpeciesCode"].ToString() == "" || dv["SpeciesCode"].ToString() == "0")
					{
						ddl.SelectedValue = "0";
					}
					else
					{
						ddl.SelectedValue = dv["SpeciesCode"].ToString();
					}

					// load and select thickness list
					ddl = (DropDownList)r.FindControl("ddlGVMixThickness");
					ddl.DataSource = _ThickList;
					ddl.DataTextField = "CodeDescription";
					ddl.DataValueField = "Code";
					ddl.DataBind();
					if (dv["ThicknessCode"].ToString() == "" || dv["ThicknessCode"].ToString() == "0")
					{
						ddl.SelectedValue = "0";
					}
					else
					{
						ddl.SelectedValue = dv["ThicknessCode"].ToString();
					}

					// load and select grade list
					ddl = (DropDownList)r.FindControl("ddlGVMixGrade");
					ddl.DataSource = _GradeList;
					ddl.DataTextField = "CodeDescription";
					ddl.DataValueField = "Code";
					ddl.DataBind();
					if (dv["GradeCode"].ToString() == "" || dv["GradeCode"].ToString() == "0")
					{
						ddl.SelectedValue = "0";
					}
					else
					{
						ddl.SelectedValue = dv["GradeCode"].ToString();
					}

					// load and select thickness list
					ddl = (DropDownList)r.FindControl("ddlGVMixLength");
					ddl.DataSource = _LengthList;
					ddl.DataTextField = "CodeDescription";
					ddl.DataValueField = "CatCode";
					ddl.DataBind();
					if (dv["ItemLength"].ToString() == "" || dv["ItemLength"].ToString() == "0")
					{
						ddl.SelectedValue = "0";
					}
					else
					{
						ddl.SelectedValue = dv["ItemLength"].ToString();
					}
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Mix list row binding produced an error: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void gvMixList_Sorted(object sender, EventArgs e)
		{
			//nothing
		}

		protected void gvMixList_Sorting(object sender, GridViewSortEventArgs e)
		{
			//nothing
		}

		protected void gvMixList_RowCommand(object sender, GridViewCommandEventArgs e)
		{
			this.lblErrorMsg.Text = "";
			string str = string.Empty;
			TextBox txt;
			CheckBox chk;
			HiddenField hf;
			int iType = 0;

			try
			{
				//Edit, Update, Delete, User
				string s = string.Empty;
				string cname = e.CommandName.ToString();
				int RowID = Convert.ToInt32(e.CommandArgument);
				if (_PgNbr1 > 0) { RowID = RowID - (_PgNbr1 * _PgSize); }
				GridViewRow r = gvMixList.Rows[RowID];
				DataRowView rv = (DataRowView)r.DataItem;
				DateTime BDate = DateTime.Now;

				switch (cname)
				{
					case "Delete":
						hf = (HiddenField)gvMixList.Rows[RowID].FindControl("hfMixItemID");
						int id = Convert.ToInt32(hf.Value);
						Forecast fc = new Forecast();
						DataTable dt = fc.DeleteForecastMix2(id, _UserID);
						LoadMixList();
						break;
					default:
						break;
				}

				// save field change data
				if (iType > 0)
				{
					hf = (HiddenField)r.FindControl("hfMixItemID");
					int id = Convert.ToInt32(hf.Value);
					Forecast fc = new Forecast();
					DataTable dt = fc.UpdateForecastMixListItem(id, iType, str, _UserID);
				}

			}
			catch (Exception ex)
			{
				lblErrorMsg.Text = "Error accessing item data: " + ex.Message;
			}
		}

		protected void gvMixContents_RowCommand(object sender, GridViewCommandEventArgs e)
		{
			this.lblErrorMsg.Text = "";
			try
			{
				Forecast fc = new Forecast();
				string cmd = e.CommandName;
				string arg = e.CommandArgument.ToString();
				int rowID = Convert.ToInt32(arg);
				if (_PgNbr2 > 0) { rowID = rowID - (_PgNbr2 * _PgSize); }
				HiddenField hf = (HiddenField)this.gvMixContents.Rows[rowID].FindControl("hfMixProdLinkID");
				int id = Convert.ToInt32(hf.Value);
				hf = (HiddenField)this.gvMixContents.Rows[rowID].FindControl("hfProdManagedID");
				int pmid = Convert.ToInt32(hf.Value);
				switch (cmd)
				{
					case "Edit1":
						LoadProductDDL(0);
						Single pct = Convert.ToSingle(gvMixContents.Rows[rowID].Cells[10].Text);
						this.ddlProdItemE.SelectedValue = pmid.ToString();
						hf = (HiddenField)this.gvMixContents.Rows[rowID].FindControl("hfProdLength");
						string ilen = "";
						if (hf != null) { ilen = hf.Value; }
						txtProdItemPercent.Text = pct.ToString();
						if (ilen != "")
						{
							ddlMixProdLength.SelectedValue = ilen;
						}
						divMixProductEdit.Style["display"] = "block";
						break;
					case "Del1":
						DataTable dt2 = fc.DeleteForecastMixProduct(id, _UserID);
						LoadMixContentsData();
						break;
					default:
						break;
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in mix contents row command: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void gvMixContents_RowDataBound(object sender, GridViewRowEventArgs e)
		{
			this.lblErrorMsg.Text = "";
			Single pct = 0;
			try
			{
				if (e.Row.RowType == DataControlRowType.DataRow)
				{
					GridViewRow r = e.Row;
					DataRowView dv = (DataRowView)r.DataItem;
					pct = Convert.ToSingle(dv["YieldPercent"]);
					_TotalItems++;
					_TotalPercentage += pct;
					ViewState["TotalItems"] = _TotalItems.ToString();
					ViewState["TotalPercent"] = _TotalPercentage.ToString();
					if (_OutTurnPercent == 0) { _OutTurnPercent = Convert.ToSingle(dv["OutTurnPercent"]); }
				}

			}
			catch (Exception ex)
			{

			}
		}

		protected void gvMixContents_Sorted(object sender, EventArgs e)
		{
			//nothing
		}

		protected void gvMixContents_Sorting(object sender, GridViewSortEventArgs e)
		{
			//nothing
		}

		protected void gvMixContents_PageIndexChanged(object sender, EventArgs e)
		{
			//_PgNbr2 = 0;
			//gvMixList.PageIndex = _PgNbr2;
			//LoadMixContentsData();
		}

		protected void gvMixContents_PageIndexChanging(object sender, GridViewPageEventArgs e)
		{
			_PgNbr2 = e.NewPageIndex;
			gvMixContents.PageIndex = _PgNbr2;
			ViewState["PageNbr2"] = _PgNbr2.ToString();
			LoadMixContentsData();
			// nothing
		}

		protected void gvMixContents_DataBinding(object sender, EventArgs e)
		{
			// nothing
		}

		protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
		{
			this.lblEditStatusMsg.Text = "";
			this.lblErrorMsg.Text = "";
			_PgSize = Convert.ToInt32(this.ddlPageSize.SelectedValue);
			ViewState["PageSize"] = _PgSize.ToString();
			_PgNbr1 = 0;
			ViewState["PageNbr1"] = _PgNbr1.ToString();
			gvMixList.PageIndex = _PgNbr1;
			gvMixList.PageSize = _PgSize;
			_PgNbr2 = 0;
			ViewState["PageNbr2"] = _PgNbr2.ToString();
			gvMixContents.PageIndex = _PgNbr2;
			gvMixContents.PageSize = _PgSize;
			_PgNbr3 = 0;
			ViewState["PageNbr3"] = _PgNbr3.ToString();
			gvProducts.PageIndex = _PgNbr3;
			gvProducts.PageSize = _PgSize;
			_PgNbr4 = 0;
			ViewState["PageNbr4"] = _PgNbr4.ToString();
			gvForecastData.PageIndex = _PgNbr4;
			gvForecastData.PageSize = _PgSize;
			_PgNbr5 = 0;
			ViewState["PageNbr5"] = _PgNbr5.ToString();
			gvForecastCodes.PageIndex = _PgNbr5;
			gvForecastCodes.PageSize = _PgSize;
			_PgNbr6 = 0;
			ViewState["PageNbr6"] = _PgNbr6.ToString();
			_PgNbr7 = 0;
			ViewState["PageNbr7"] = _PgNbr7.ToString();
			gvFinishView.PageIndex = _PgNbr7;
			gvFinishView.PageSize = _PgSize;
			_PgNbr8 = 0;
			ViewState["PageNbr8"] = _PgNbr8.ToString();
			gvLengthCodes.PageIndex = _PgNbr8;
			gvLengthCodes.PageSize = _PgSize;
			LoadCurrentGrid();
		}

		protected void btnAddNewProduct_Click(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			this.lblEditStatusMsg.Text = "";
			try
			{
				EmptyProductEditData();
				this.ddlProdProductListE.SelectedValue = "0";
				LoadProductMasterListDDL();
				this.divProductItemEdit.Style["display"] = "block";
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in add new product: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void gvProducts_PageIndexChanged(object sender, EventArgs e)
		{
			_PgNbr3 = 0;
			gvMixList.PageIndex = _PgNbr3;
			LoadProductList();
		}

		protected void gvProducts_PageIndexChanging(object sender, GridViewPageEventArgs e)
		{
			// nothing
			_PgNbr3 = e.NewPageIndex;
			gvProducts.PageIndex = _PgNbr3;
			ViewState["PageNbr3"] = _PgNbr3.ToString();
			LoadProductList();
		}

		protected void gvProducts_RowCommand(object sender, GridViewCommandEventArgs e)
		{
			this.lblErrorMsg.Text = "";
			try
			{
				Forecast fc = new Forecast();
				string cmd = e.CommandName;
				string arg = e.CommandArgument.ToString();
				int rowID = Convert.ToInt32(arg);
				if (_PgNbr3 > 0) { rowID = rowID - (_PgNbr3 * _PgSize); }
				int id = Convert.ToInt32(this.gvProducts.Rows[rowID].Cells[1].Text);
				switch (cmd)
				{
					case "Edit":
						EmptyProductEditData();
						this.ddlProdProductListE.SelectedValue = "0";
						DataTable dt = fc.SelectForecastProductData(id, "", "", "", "", "", "", _UserID);
						if (dt.Rows.Count > 0)
						{
							this.ddlProdProductListE.SelectedValue = "0";
							this.txtProdDescriptionE.Text = dt.Rows[0]["ProdDesc"].ToString();
							this.txtPDescVal1.Text = dt.Rows[0]["desc1"].ToString();
							this.txtPDescVal2.Text = dt.Rows[0]["desc2"].ToString();
							this.txtPDescVal3.Text = dt.Rows[0]["desc3"].ToString();
							this.txtPDescVal4.Text = dt.Rows[0]["desc4"].ToString();
							this.txtPDescVal5.Text = dt.Rows[0]["desc5"].ToString();
							this.txtPDescVal6.Text = dt.Rows[0]["desc6"].ToString();
							this.txtPDescVal7.Text = dt.Rows[0]["desc7"].ToString();
							this.txtPDescVal8.Text = dt.Rows[0]["desc8"].ToString();
							this.txtPDescVal9.Text = dt.Rows[0]["desc9"].ToString();
							this.txtPDescVal10.Text = dt.Rows[0]["desc10"].ToString();
							this.ddlLengthT.SelectedValue = dt.Rows[0]["Length"].ToString();
							this.ddlColorT.SelectedValue = dt.Rows[0]["Color"].ToString();
							this.ddlSortT.SelectedValue = dt.Rows[0]["Sort"].ToString();
							this.ddlMillingT.SelectedValue = dt.Rows[0]["Milling"].ToString();
							this.ddlNoPrintT.SelectedValue = dt.Rows[0]["NoPrint"].ToString();
							this.hfProdManagedIDE.Value = dt.Rows[0]["ProductManagedID"].ToString();
							if (this.gvProducts.Rows[rowID].Cells[15].Text == "Yes")
							{
								this.chkProdActiveE.Checked = false;
							}
							else
							{
								this.chkProdActiveE.Checked = false;
							}
						}
						else
						{
							this.hfProdManagedIDE.Value = "0";
							this.txtProdDescriptionE.Text = "** Product not found **";
						}
						break;
					case "Del":
						DataTable dt2 = fc.DeleteForecastProduct(_LocationCode, id, _UserID);
						if (dt2 == null)
						{
							this.lblErrorMsg.Text = "Database connection failed. The item was probably not removed.";
						}
						else
						{
							if (dt2.Rows.Count == 0)
							{
								this.lblErrorMsg.Text = "Unexpected database return. The item was probably not removed.";
							}
							else
							{
								if (Convert.ToInt32(dt2.Rows[0]["StatusID"]) > 0)
								{
									this.lblErrorMsg.Text = "Error: " + dt2.Rows[0]["StatusMsg"].ToString();
								}
							}
						}
						break;
					default:
						break;
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in product grid row command: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void ddlLocationListF_SelectedIndexChanged(object sender, EventArgs e)
		{
			Commands cmd = new Commands();
			Forecast fc = new Forecast();
			DataTable dt;
			_LocationCode = ddlLocationListF.SelectedValue;
			if (_LocationCode == "0")
			{
				_LocationCode = "";
				_UseShift1 = true;
				ViewState["UseShift1"] = _UseShift1.ToString();
				_UseShift2 = true;
				ViewState["UseShift2"] = _UseShift2.ToString();
				_UseShift3 = true;
				ViewState["UseShift3"] = _UseShift3.ToString();
				lblCurrentRegion.Text = "";
			}
			else
			{
				UpdateRegionCode();
				LoadLocationSettings();
			}
			ViewState["LocationCode"] = _LocationCode.ToString();
			LoadCurrentGrid();
			// load secondary elements
			switch (_TargetGrid)
			{
				case 1: // Mix list
					break;
				case 2: //Mix-Product List
					if (_LocationCode != "")
					{
						dt = fc.SelectForecastMixList(_LocationCode, 0, "", 0, 2, _UserID);
						LoadMixListOnMixProdList(dt);
						LoadProductDDL(0);
					}
					else
					{
						ClearDropDownList(ddlMixListProdContents, 1);
					}
					break;
				case 3: // Product List
					break;
				case 4: // Forecast Data - Reload Mix code list
					string spec = ddlSpeciesOverall.SelectedValue;
					dt = fc.SelectForecastMixList(_LocationCode, 0, spec, 0, 2, _UserID);
					ClearListBox(lbxCMixListF, 1);
					if (_LocationCode != "")
					{
						LoadMixListOnForecast(dt);
						// Reload Species list
						LoadSpeciesDDL();
						dt = fc.SelectForecastRegionCodeList(_LocationCode, _RegionCode, "Species", 0, 1, 0, 1, _UserID);
						if (this.lbxSpeciesFv.Items.Count > 0)
						{
							ClearListBox(lbxSpeciesFv, 1);
						}
						this.lbxSpeciesFv.DataSource = dt;
						this.lbxSpeciesFv.DataTextField = "CodeDescription";
						this.lbxSpeciesFv.DataValueField = "Code";
						this.lbxSpeciesFv.DataBind();
						this.lbxSpeciesFv.SelectedValue = "0";

						dt = fc.SelectForecastRegionCodeList(_LocationCode, _RegionCode, "Grade", 0, 1, 0, 1, _UserID);
						if (lbxGradeFv.Items.Count > 0)
						{
							ClearListBox(lbxGradeFv, 1);
						}
						this.lbxGradeFv.DataSource = dt;
						this.lbxGradeFv.DataTextField = "CodeDescription";
						this.lbxGradeFv.DataValueField = "Code";
						this.lbxGradeFv.DataBind();
						this.lbxGradeFv.SelectedValue = "0";
					}
					else
					{
						ClearListBox(lbxSpeciesFv, 1);
						ClearListBox(lbxGradeFv, 1);
					}
					break;
				case 5:
					break;
				case 6: // Codes
					break;
				case 7: // finish view
					if (_LocationCode == "")
					{
						ClearListBox(lbxSpeciesFv, 1);
						ClearListBox(lbxGradeFv, 1);
					}
					else
					{
						dt = fc.SelectForecastRegionCodeList(_LocationCode, _RegionCode, "Species", 0, 1, 0, 1, _UserID);
						if (this.lbxSpeciesFv.Items.Count > 0)
						{
							ClearListBox(lbxSpeciesFv, 1);
						}
						this.lbxSpeciesFv.DataSource = dt;
						this.lbxSpeciesFv.DataTextField = "CodeDescription";
						this.lbxSpeciesFv.DataValueField = "Code";
						this.lbxSpeciesFv.DataBind();
						this.lbxSpeciesFv.SelectedValue = "0";

						dt = fc.SelectForecastRegionCodeList(_LocationCode, _RegionCode, "Grade", 0, 1, 0, 1, _UserID);
						if (lbxGradeFv.Items.Count > 0)
						{
							ClearListBox(lbxGradeFv, 1);
						}
						this.lbxGradeFv.DataSource = dt;
						this.lbxGradeFv.DataTextField = "CodeDescription";
						this.lbxGradeFv.DataValueField = "Code";
						this.lbxGradeFv.DataBind();
						this.lbxGradeFv.SelectedValue = "0";

						dt = cmd.SelectProductCodeList("Length", 0, 1, 0, 0, 0, _UserID);
						this.lbxLengthFv.DataTextField = "CodeDescription";
						this.lbxLengthFv.DataValueField = "CatCode";
						this.lbxLengthFv.DataSource = dt;
						this.lbxLengthFv.DataBind();
						this.lbxLengthFv.SelectedValue = "0";
					}
					break;
				default:
					break;
			}
		}

		protected void ddlMixListProdContents_SelectedIndexChanged(object sender, EventArgs e)
		{
			_MixID = Convert.ToInt32(this.ddlMixListProdContents.SelectedValue);
			//int iMix = Convert.ToInt32(this.ddlMixListProdContents.SelectedValue);
			LoadProductDDL(_MixID);
			LoadMixContentsData();
		}

		protected void btnAddNewMixProduct_Click(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			this.lblEditStatusMsg.Text = "";
			// load mix product edit screen
			try
			{
				int iMix = Convert.ToInt32(this.ddlMixListProdContents.SelectedValue);
				LoadProductDDL(iMix);
				this.ddlProdItemE.SelectedValue = "0";
				this.txtProdItemPercent.Text = "0";
				this.divMixProductEdit.Style["display"] = "block";
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error loading mix contents edit block: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void btnRefreshMatrixData_Click(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			this.lblEditStatusMsg.Text = "";
			LoadForecastData();
		}

		protected void btnSaveMixItemData_Click(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			string loc = string.Empty;
			try
			{
				if (_LocationCode == "0" || _LocationCode == "ALL")
				{
					this._ErrMsg = "Cannot save a mix without a location.";
					this.lblErrorMsg.Text = this._ErrMsg;
				}
				else
				{
					bool Continue = true;
					int id = Convert.ToInt32(this.lblMixItemIDE.Text);
					int act = Convert.ToInt32(this.ddlMixItemActiveE.SelectedValue);
					//string spec = this.ddlSpeciesOverall.SelectedValue;
					string name = this.txtMixItemNameE.Text;
					string content = this.txtMixItemContentE.Text;
					string comment = this.txtMixItemCommentsE.Text;
					string thick = this.ddlThicknessForMixItem.SelectedValue;
					string spec = this.ddlSpeciesForMixItem.SelectedValue;
					string grade = this.ddlGradeForMixItem.SelectedValue;
					string Len = this.ddlLengthForMixItem.SelectedValue;
					if (!GenUtilities.ValidateStringData(name, 0))
					{
						divEditStatusMsg.Style["display"] = "block";
						this._ErrMsg = "Name field contains invalid characters ('\\^).";
						this.lblEditStatusMsg.Text = this._ErrMsg;
						Continue = false;
					}
					if (!GenUtilities.ValidateStringData(content, 0))
					{
						divEditStatusMsg.Style["display"] = "block";
						this._ErrMsg = "Content field contains invalid characters ('\\^).";
						this.lblEditStatusMsg.Text = this._ErrMsg;
						Continue = false;
					}
					if (!GenUtilities.ValidateStringData(comment, 0))
					{
						divEditStatusMsg.Style["display"] = "block";
						this._ErrMsg = "Content field contains invalid characters ('\\^).";
						this.lblEditStatusMsg.Text = this._ErrMsg;
						Continue = false;
					}
					if (Len == "0") { Len = ""; }
					if (Continue == true)
					{
						Forecast fc = new Forecast();
						DataTable dt = fc.UpdateForecastMixItem(id, _LocationCode, name, spec, thick, grade, Len, content, comment, act, _UserID);
						LoadMixList();
					}
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error while saving Mix item data: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void btnCloseMixItemEdit_Click(object sender, EventArgs e)
		{
			this.lblEditStatusMsg.Text = "";
			this.divMixItemEdit.Style["display"] = "none";
		}

		protected void btnSaveProductData_Click(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			this.lblEditStatusMsg.Text = "";
			try
			{
				int ID = 0;
				string len = ddlLengthT.SelectedValue;
				string Color = ddlColorT.SelectedValue;
				string Sort = ddlSortT.SelectedValue;
				string Milling = ddlMillingT.SelectedValue;
				string NoPrint = ddlNoPrintT.SelectedValue;
				string pt = ddlProdProdTypeListE.SelectedValue;
				string pcode = ddlProdProductListE.SelectedValue;
				Forecast fc = new Forecast();
				if (len == "0") { len = ""; }
				if (Color == "0") { Color = ""; }
				if (Sort == "0") { Sort = ""; }
				if (Milling == "0") { Milling = ""; }
				if (NoPrint == "0") { NoPrint = ""; }

				DataTable dt = fc.SelectForecastProductData(0, pcode, len, Color, Sort, Milling, NoPrint, _UserID);
				if (dt.Rows.Count > 0)
				{
					ID = Convert.ToInt32(dt.Rows[0]["ProductManagedID"]);
				}

				if (ID == 0)
				{
					//this.lblErrorMsg.Text = "No product management item has been defined for this product code-attributes match. To create one, click on the `Define new managed product` button above.";
					Commands cmd = new Commands();
					dt = cmd.UpdateProductManagedDataItem(0, pt, pcode, len, Color, Sort, Milling, NoPrint, 0, 1, _UserID);
					if (dt.Rows.Count > 0)
					{
						ID = Convert.ToInt32(dt.Rows[0]["PMID"]);
					}
				}

				if (ID != 0)
				{
					dt = fc.UpdateForecastProductItem(ID, _LocationCode, 0, 1, _UserID);
					LoadProductList();
					LoadProductDDL(0);
				}
				else
				{
					this._ErrMsg = "No product management item is defined for this product code-attributes match and none could be created. The data cannot be saved as it is.";
					this.lblErrorMsg.Text = this._ErrMsg;
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error durung attempt to save product data: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void ddlProdProductListE_SelectedIndexChanged(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			try
			{
				string ProdID = ddlProdProductListE.SelectedValue;
				string Len = ddlLengthT.SelectedValue;
				string Color = ddlColorT.SelectedValue;
				string Sort = ddlSortT.SelectedValue;
				string Milling = ddlMillingT.SelectedValue;
				string NoPrint = ddlNoPrintT.SelectedValue;
				string s = string.Empty;
				if (ProdID != "0")
				{
					Forecast fc = new Forecast();
					DataTable dt = fc.SelectForecastProductData(0, ProdID, Len, Color, Sort, Milling, NoPrint, _UserID);
					if (dt.Rows.Count > 0)
					{
						EmptyProductEditData();
						//this.ddlProdProductListE.SelectedValue = "0";
						this.txtProdDescriptionE.Text = dt.Rows[0]["ProdDesc"].ToString();
						this.txtPDescVal1.Text = dt.Rows[0]["desc1"].ToString();
						this.txtPDescVal2.Text = dt.Rows[0]["desc2"].ToString();
						this.txtPDescVal3.Text = dt.Rows[0]["desc3"].ToString();
						this.txtPDescVal4.Text = dt.Rows[0]["desc4"].ToString();
						this.txtPDescVal5.Text = dt.Rows[0]["desc5"].ToString();
						this.txtPDescVal6.Text = dt.Rows[0]["desc6"].ToString();
						this.txtPDescVal7.Text = dt.Rows[0]["desc7"].ToString();
						this.txtPDescVal8.Text = dt.Rows[0]["desc8"].ToString();
						this.txtPDescVal9.Text = dt.Rows[0]["desc9"].ToString();
						this.txtPDescVal10.Text = dt.Rows[0]["desc10"].ToString();
						this.lblProdIDE.Text = dt.Rows[0]["ProductCode"].ToString();
						s = dt.Rows[0]["Length"].ToString();
						if (s != "")
						{
							this.ddlLengthT.SelectedValue = s;
						}
						else
						{
							this.ddlLengthT.SelectedValue = "0";
						}
						s = dt.Rows[0]["Color"].ToString();
						if (s != "")
						{
							this.ddlColorT.SelectedValue = s;
						}
						else
						{
							this.ddlColorT.SelectedValue = "0";
						}
						s = dt.Rows[0]["Sort"].ToString();
						if (s != "")
						{
							this.ddlSortT.SelectedValue = s;
						}
						else
						{
							this.ddlSortT.SelectedValue = "0";
						}
						s = dt.Rows[0]["Milling"].ToString();
						if (s != "")
						{
							this.ddlMillingT.SelectedValue = s;
						}
						else
						{
							this.ddlMillingT.SelectedValue = "0";
						}
						s = dt.Rows[0]["NoPrint"].ToString();
						if (s != "")
						{
							this.ddlNoPrintT.SelectedValue = s;
						}
						else
						{
							this.ddlNoPrintT.SelectedValue = "0";
						}
						this.hfProdManagedIDE.Value = dt.Rows[0]["ProductManagedID"].ToString();
						IdentifyPMID();
					}
					else
					{
						this.hfProdManagedIDE.Value = "0";
						this.txtProdDescriptionE.Text = "** No product found **";
					}
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error encountered after drop down list value changed: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void btnCloseProdDataEdit_Click(object sender, EventArgs e)
		{
			this.lblEditStatusMsg.Text = "";
			this.lblErrorMsg.Text = "";
			this.divProductItemEdit.Style["display"] = "none";
		}

		protected void ddlForecastMatrixView_SelectedIndexChanged(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			int iView = Convert.ToInt32(ddlForecastMatrixView.SelectedValue);
			SetForecastView(iView);
		}

		protected void ddlForecastSpeciesF_SelectedIndexChanged(object sender, EventArgs e)
		{
			LoadForecastData();
		}

		protected void btnSaveMixProdData_Click(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			this.lblEditStatusMsg.Text = "";
			try
			{
				int MixID = Convert.ToInt32(this.ddlMixListProdContents.SelectedValue);
				string ProdCode = this.ddlProdItemE.SelectedValue;
				double pct = Convert.ToDouble(this.txtProdItemPercent.Text);
				int pmid = Convert.ToInt32(ddlProdItemE.SelectedValue);
				string ilen = this.ddlMixProdLength.SelectedValue;
				Forecast fc = new Forecast();
				DataTable dt = fc.UpdateForecastMixProduct(0, _LocationCode, MixID, pmid, ilen, 0, pct, 1, _UserID);
				this.divMixProductEdit.Style["display"] = "none";
				LoadMixContentsData();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error save mix contents data: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void gvForecastData_SelectedIndexChanged(object sender, EventArgs e)
		{
			// nothing
		}

		protected void gvForecastData_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
		{
			// nothing
		}

		protected void gvForecastData_RowCommand(object sender, GridViewCommandEventArgs e)
		{
			this.lblErrorMsg.Text = "";
			try
			{
				HiddenField hf;
				Forecast fc = new Forecast();
				string cmd = e.CommandName;
				string arg = e.CommandArgument.ToString();
				int rowID = Convert.ToInt32(arg);
				hf = (HiddenField)this.gvForecastData.Rows[rowID].FindControl("hfMixID");
				int mix = Convert.ToInt32(hf.Value);
				switch (cmd)
				{
					case "Del":
						DataTable dt2 = fc.DeleteForecastMix(_LocationCode, mix, _UserID);
						LoadForecastData();
						break;
					default:
						break;
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in forecast row command: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void gvForecastData_RowDataBound(object sender, GridViewRowEventArgs e)
		{
			GridViewRow row = e.Row;
			HiddenField hf;
			HtmlTableRow tr;
			int Dy = 0;
			int idx = row.RowIndex;
			string mixname = string.Empty;
			string pdate = string.Empty;
			double qty = 0;
			TextBox txt;
			string value = string.Empty;
			int Wk = 0;

			if (e.Row.RowType == DataControlRowType.DataRow)
			{
				hf = (HiddenField)row.FindControl("hfMixFullName");
				mixname = hf.Value;

				// Remove 0 values
				try
				{
					//e.Row.Cells[0].CssClass = "locked";
					//e.Row.Cells[1].CssClass = "locked";

					// tactical portion
					if (_ForecastView == 0 || _ForecastView == 1 || _ForecastView == 3 || _ForecastView == 4)
					{
						Wk = 1;
						for (int ic = 2; ic <= 15; ic++)
						{
							Dy = ic - 1;
							if (_ForecastView == 0 || _ForecastView == 1 || _ForecastView == 4)
							{
								if (ic > 8)
								{
									Wk = 2;
									Dy = Dy - 7;
								}
							}
							pdate = GetProdDate(Wk, Dy).ToString("yyyy-MM-dd");
							for (int s = 1; s <= 3; s++)
							{
								if (s == 1 || (s == 2 && _UseShift2 == true) || (s == 3 && _UseShift3 == true))
								{
									if (_ForecastView < 3 || (_ForecastView == 3 && ic < 9) || (_ForecastView == 4 && ic > 8))
									{
										txt = (TextBox)row.FindControl("txtWk" + Wk.ToString() + "_" + Dy.ToString() + "Amt" + s.ToString());
										value = txt.Text;
										if (value != "")
										{
											if (GenUtilities.IsNumeric(value))
											{
												qty = Convert.ToDouble(value);
												if (qty == 0) { txt.Text = ""; }
											}
										}
										tr = (HtmlTableRow)row.FindControl("trForecastc" + ic.ToString() + "s1");
										tr.Attributes["title"] = mixname + "/" + pdate;
									}
								}
								if (s == 2 && (_ForecastView < 3 || (_ForecastView == 3 && ic < 9) || (_ForecastView == 4 && ic > 8)))
								{
									if (_UseShift2 == false)
									{
										tr = (HtmlTableRow)row.FindControl("trForecastc" + ic.ToString() + "s2");
										tr.Style["display"] = "none";
									}
									else
									{
										tr = (HtmlTableRow)row.FindControl("trForecastc" + ic.ToString() + "s2");
										tr.Style["display"] = "table-row";
										tr.Attributes["title"] = mixname + "/" + pdate;
									}
								}
								if (s == 3 && (_ForecastView < 3 || (_ForecastView == 3 && ic < 9) || (_ForecastView == 4 && ic > 8)))
								{
									if (_UseShift3 == false)
									{
										tr = (HtmlTableRow)row.FindControl("trForecastc" + ic.ToString() + "s3");
										tr.Style["display"] = "none";
									}
									else
									{
										tr = (HtmlTableRow)row.FindControl("trForecastc" + ic.ToString() + "s3");
										tr.Style["display"] = "table-row";
										tr.Attributes["title"] = mixname + "/" + pdate;
									}
								}
							}
						}
					}
				}
				catch (Exception ex1)
				{
					this._ErrMsg = "Tactical row data load error: " + ex1.Message;
					this.lblErrorMsg.Text = this._ErrMsg;
				}

				try
				{
					if (_ForecastView == 0 || _ForecastView == 2)
					{
						for (int ic2 = 16; ic2 <= 26; ic2++)
						{
							pdate = GetProdDate(ic2 - 13, 0).ToString("yyyy-MM-dd");
							for (int s2 = 1; s2 <= 3; s2++)
							{
								if (s2 == 1 || (s2 == 2 && _UseShift2 == true) || (s2 == 3 && _UseShift3 == true))
								{
									txt = (TextBox)row.FindControl("txtWk" + (ic2 - 13).ToString() + "Amt" + s2.ToString());
									value = txt.Text;
									if (value != "")
									{
										if (GenUtilities.IsNumeric(value))
										{
											qty = Convert.ToDouble(value);
											if (qty == 0) { txt.Text = ""; }
										}
									}
									tr = (HtmlTableRow)row.FindControl("trForecastc" + ic2.ToString() + "s1");
									tr.Attributes["title"] = mixname + "/" + pdate;
								}
								if (s2 == 2)
								{
									if (_UseShift2 == false)
									{
										tr = (HtmlTableRow)row.FindControl("trForecastc" + ic2.ToString() + "s2");
										tr.Style["display"] = "none";
									}
									else
									{
										tr = (HtmlTableRow)row.FindControl("trForecastc" + ic2.ToString() + "s2");
										tr.Style["display"] = "table-row";
										tr.Attributes["title"] = mixname + "/" + pdate;
									}
								}
								if (s2 == 3)
								{
									if (_UseShift3 == false)
									{
										tr = (HtmlTableRow)row.FindControl("trForecastc" + ic2.ToString() + "s3");
										tr.Style["display"] = "none";
									}
									else
									{
										tr = (HtmlTableRow)row.FindControl("trForecastc" + ic2.ToString() + "s3");
										tr.Style["display"] = "table-row";
										tr.Attributes["title"] = mixname + "/" + pdate;
									}
								}
							}
						}
					}
				}
				catch (Exception ex2)
				{
					this._ErrMsg = "Strategic row data load error: " + ex2.Message;
					this.lblErrorMsg.Text = this._ErrMsg;
				}

				//e.Row.Cells[0].CssClass = "locked";
				//e.Row.Cells[1].CssClass = "locked";
				// color code overall yeilds below 100%
				try
				{
					hf = (HiddenField)row.FindControl("hfTotalYieldPct");
					if (hf != null)
					{
						if (hf.Value != "1")
						{
							TableCell cell = row.Cells[1];
							cell.Style["color"] = "maroon";
						}
					}


				}
				catch (Exception ex3)
				{
					this._ErrMsg = "Error while checking yield percentage: " + ex3.Message;
					this.lblErrorMsg.Text = this._ErrMsg;
				}
			}


			if (e.Row.RowType == DataControlRowType.Header)
			{

				try
				{
					//DateTime BaseDate;
					DateTime monday1 = DateTime.Now.AddDays(-(int)DateTime.Now.DayOfWeek + 1); //1 8 15 22 29 36 43 50 57 64 71 78 85
					if (this.chkEditCurrentWeek.Checked == true)
					{
						_BaseDate = monday1;
					}
					else
					{
						_BaseDate = monday1.AddDays(7);
					}
					//if ((iGrid == 0 &&_UseCurrentWeek == 1) || (iGrid == 1 && _UseCurrentWeekFV == 1))
					//{
					//	_BaseDate = monday1;
					//}
					//else
					//{
					//	_BaseDate = monday1.AddDays(7);
					//}
					ViewState["BaseDate"] = _BaseDate.ToString();
					//this.lblErrorMsg.Text = this.lblErrorMsg.Text + "/" + _BaseDate.ToString(); //**************************************

					// calculate dates for column headers
					var format1 = _BaseDate.ToString("yyyy-MM-dd");
					DateTime monday2 = _BaseDate.AddDays(7);
					var format2 = monday2.ToString("yyyy-MM-dd");
					DateTime monday3 = _BaseDate.AddDays(18);
					var format3 = monday3.ToString("yyyy-MM-dd");
					DateTime monday4 = _BaseDate.AddDays(25);
					var format4 = monday4.ToString("yyyy-MM-dd");
					DateTime monday5 = _BaseDate.AddDays(33);
					var format5 = monday5.ToString("yyyy-MM-dd");
					DateTime monday6 = _BaseDate.AddDays(39);
					var format6 = monday6.ToString("yyyy-MM-dd");
					DateTime monday7 = _BaseDate.AddDays(46);
					var format7 = monday7.ToString("yyyy-MM-dd");
					DateTime monday8 = _BaseDate.AddDays(53);
					var format8 = monday8.ToString("yyyy-MM-dd");
					DateTime monday9 = _BaseDate.AddDays(60);
					var format9 = monday9.ToString("yyyy-MM-dd");
					DateTime monday10 = _BaseDate.AddDays(67);
					var format10 = monday10.ToString("yyyy-MM-dd");
					DateTime monday11 = _BaseDate.AddDays(74);
					var format11 = monday11.ToString("yyyy-MM-dd");
					DateTime monday12 = _BaseDate.AddDays(81);
					var format12 = monday12.ToString("yyyy-MM-dd");
					DateTime monday13 = _BaseDate.AddDays(88);
					var format13 = monday13.ToString("yyyy-MM-dd");
					DateTime Tue1 = _BaseDate.AddDays(1);
					DateTime Wed1 = _BaseDate.AddDays(2);
					DateTime Thu1 = _BaseDate.AddDays(3);
					DateTime Fri1 = _BaseDate.AddDays(4);
					DateTime Sat1 = _BaseDate.AddDays(5);
					DateTime Sun1 = _BaseDate.AddDays(6);
					DateTime Tue2 = monday2.AddDays(1);
					DateTime Wed2 = monday2.AddDays(2);
					DateTime Thu2 = monday2.AddDays(3);
					DateTime Fri2 = monday2.AddDays(4);
					DateTime Sat2 = monday2.AddDays(5);
					DateTime Sun2 = monday2.AddDays(6);

					// load values into grid header columns
					row.Cells[2].Text = format1;
					//this.gvForecastData.Columns[2].HeaderText = format1;
					row.Cells[3].Text = Tue1.ToString("yyyy-MM-dd");
					row.Cells[4].Text = Wed1.ToString("yyyy-MM-dd");
					row.Cells[5].Text = Thu1.ToString("yyyy-MM-dd");
					row.Cells[6].Text = Fri1.ToString("yyyy-MM-dd");
					row.Cells[7].Text = Sat1.ToString("yyyy-MM-dd");
					row.Cells[8].Text = Sun1.ToString("yyyy-MM-dd");
					row.Cells[9].Text = format2;
					row.Cells[10].Text = Tue2.ToString("yyyy-MM-dd");
					row.Cells[11].Text = Wed2.ToString("yyyy-MM-dd");
					row.Cells[12].Text = Thu2.ToString("yyyy-MM-dd");
					row.Cells[13].Text = Fri2.ToString("yyyy-MM-dd");
					row.Cells[14].Text = Sat2.ToString("yyyy-MM-dd");
					row.Cells[15].Text = Sun2.ToString("yyyy-MM-dd");
					row.Cells[16].Text = format3;
					row.Cells[17].Text = format4;
					row.Cells[18].Text = format5;
					row.Cells[19].Text = format6;
					row.Cells[20].Text = format7;
					row.Cells[21].Text = format8;
					row.Cells[22].Text = format9;
					row.Cells[23].Text = format10;
					row.Cells[24].Text = format11;
					row.Cells[25].Text = format12;
					row.Cells[26].Text = format13;
				}
				catch (Exception ex)
				{
					this._ErrMsg = "Error while establishing column header dates: " + ex.Message;
					this.lblErrorMsg.Text = this._ErrMsg;
				}
			}

		}

		protected void gvForecastData_PageIndexChanged(object sender, EventArgs e)
		{
			//nothing
		}

		protected void gvForecastData_PageIndexChanging(object sender, GridViewPageEventArgs e)
		{
			this.lblErrorMsg.Text = "";
			_PgNbr4 = e.NewPageIndex;
			gvForecastData.PageIndex = _PgNbr4;
			ViewState["PageNbr4"] = _PgNbr4.ToString();
			LoadForecastData();
		}

		protected void gvForecastData_DataBound(object sender, EventArgs e)
		{
			try
			{
				for (int row = 0; row < gvForecastData.Rows.Count; row++)
				{
					UpdateRowTotal(row);
				}
				ChangeShiftDisplay();
			}
			catch (Exception ex2)
			{
				this._ErrMsg = "Error while updating row totals: " + ex2.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void btnAddNewMixProd_Click(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			try
			{
				int mixID = Convert.ToInt32(ddlMixListProdContents.SelectedValue);
				int id = Convert.ToInt32(ddlMixListProdContents.SelectedValue);
				string ilen = this.ddlMixProdLength.SelectedValue;
				if (mixID > 0 && id > 0)
				{
					Forecast fc = new Forecast();
					DataTable dt = fc.UpdateForecastMixProduct(0, _LocationCode, mixID, id, ilen, 0, 0, 1, _UserID);
					LoadMixContentsData();
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in adding new product: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void btnAddNewMix_Click2(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			this.lblEditStatusMsg.Text = "";
			try
			{
				this.lblMixItemIDE.Text = "0";
				this.ddlGradeForMixItem.DataTextField = "CodeDescription";
				this.ddlGradeForMixItem.DataValueField = "Code";
				this.ddlGradeForMixItem.DataSource = _GradeList;
				this.ddlGradeForMixItem.DataBind();
				this.ddlGradeForMixItem.SelectedValue = "0";
				this.ddlSpeciesForMixItem.DataTextField = "CodeDescription";
				this.ddlSpeciesForMixItem.DataValueField = "Code";
				this.ddlSpeciesForMixItem.DataSource = _SpeciesList;
				this.ddlSpeciesForMixItem.DataBind();
				this.ddlSpeciesForMixItem.SelectedValue = "0";
				this.ddlThicknessForMixItem.DataTextField = "CodeDescription";
				this.ddlThicknessForMixItem.DataValueField = "Code";
				this.ddlThicknessForMixItem.DataSource = _ThickList;
				this.ddlThicknessForMixItem.DataBind();
				this.ddlThicknessForMixItem.SelectedValue = "0";
				this.divMixItemEdit.Style["display"] = "block";
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error while preparing Mix item editing: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void ddlProdProdTypeListE_SelectedIndexChanged(object sender, EventArgs e)
		{
			LoadProductMasterListDDL();
			// reload ddlProdProductListE
		}

		protected void gvMixList_RowEditing(object sender, GridViewEditEventArgs e)
		{
			try
			{
				int idx = e.NewEditIndex;
				gvMixList.EditIndex = idx;
				LoadMixList();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error saving changes: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void gvMixList_RowUpdated(object sender, GridViewUpdatedEventArgs e)
		{
			// nothing
		}

		protected void gvMixList_RowUpdating(object sender, GridViewUpdateEventArgs e)
		{
			DropDownList ddl;
			int ridx = e.RowIndex;
			string loc = _LocationCode;
			GridViewRow row = gvMixList.Rows[ridx];
			int id = Convert.ToInt32(gvMixList.DataKeys[ridx].Values["ForecastMixID"]);
			int act = 0;
			TextBox t2 = (TextBox)row.FindControl("txtMixName");
			string nm = t2.Text;
			ddl = (DropDownList)row.FindControl("ddlGVMixSpecies");
			string spec = ddl.SelectedValue;
			ddl = (DropDownList)row.FindControl("ddlGVMixThickness");
			string thick = ddl.SelectedValue;
			ddl = (DropDownList)row.FindControl("ddlGVMixGrade");
			string grade = ddl.SelectedValue;
			ddl = (DropDownList)row.FindControl("ddlGVMixLength");
			string Len = ddl.SelectedValue;
			TextBox t3 = (TextBox)row.FindControl("txtMixContents");
			string content = t3.Text;
			TextBox t4 = (TextBox)row.FindControl("txtMixComments");
			string comment = t4.Text;
			CheckBox chk = (CheckBox)row.FindControl("chkMixActive");
			if (chk.Checked == true) { act = 1; }
			if (_LocationCode == "0")
			{
				HiddenField hf = (HiddenField)row.FindControl("hfMixItemLoc");
				loc = hf.Value;
			}

			Forecast fc = new Forecast();
			DataTable dt = fc.UpdateForecastMixItem(id, loc, nm, spec, thick, grade, Len, content, comment, act, _UserID);
			gvMixList.EditIndex = -1;
			LoadMixList();
		}

		protected void gvMixList_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
		{
			gvMixList.EditIndex = -1;
			LoadMixList();
		}

		protected void btnUpdateForecastGridData_Click(object sender, EventArgs e)
		{
			try
			{
				//lblStatusForecastMatrix.Text = "Saving...";
				this.lblErrorMsg.Text = "";
				this.lblEditStatusMsg.Text = "";
				HiddenField hf;
				string v1 = string.Empty;
				string v2 = string.Empty;
				if (_LocationCode == "0")
				{
					this._ErrMsg = "Forecast data can not be saved unless a Location is selected.";
					this.lblErrorMsg.Text = this._ErrMsg;
				}
				else
				{
					string ErrorList = string.Empty;
					GridViewRow row;
					// read all grid changes and save each to database
					int Dy = 0;
					int mix = 0;
					int NbrRows = gvForecastData.Rows.Count;
					string pdate = string.Empty;
					double qty = 0;
					string spec = ddlSpeciesOverall.SelectedValue;
					TextBox txt;
					string value = string.Empty;
					int Wk = 0;
					for (int rowid = 0; rowid < NbrRows; rowid++)
					{
						row = gvForecastData.Rows[rowid];
						hf = (HiddenField)row.FindControl("hfMixID");
						mix = Convert.ToInt32(hf.Value);
						if (_ForecastView == 0 || _ForecastView == 1 || _ForecastView == 3 || _ForecastView == 4)
						{
							Wk = 1;
							for (int ic = 2; ic <= 15; ic++)
							{
								Dy = ic - 1;
								if (ic > 8)
								{
									Wk = 2;
									Dy = Dy - 7;
								}
								if (_ForecastView < 3 || ((_ForecastView == 3 && ic < 9) || (_ForecastView == 4 && ic > 8)))
								{
									pdate = GetProdDate(Wk, Dy).ToString("yyyy-MM-dd"); // gvForecastData.Columns[ic].HeaderText;
									for (int s = 1; s <= 3; s++)
									{
										if (s < 2 || (s == 2 && _UseShift2 == true) || (s == 3 && _UseShift3 == true))
										{
											txt = (TextBox)row.FindControl("txtWk" + Wk.ToString() + "_" + Dy.ToString() + "Amt" + s.ToString());
											hf = (HiddenField)row.FindControl("hfWk" + Wk.ToString() + "_" + Dy.ToString() + "Amt" + s.ToString());
											v1 = txt.Text;
											v1 = v1.Replace("$", "").Replace(",", "");
											v2 = hf.Value;
											v2 = v2.Replace("$", "").Replace(",", "");
											if (v1 == "") { v1 = "0"; }
											if (v2 == "") { v2 = "0"; }
											if (v1 != v2)
											{
												if (GenUtilities.IsNumeric(v1))
												{
													qty = Convert.ToDouble(v1);
													if (!SaveForecastItemData(mix, s, Wk, Dy, qty, 0))
													{
														throw new System.ArgumentException("Wk " + Wk.ToString() + "-Day " + Dy.ToString() + "-Shift " + s.ToString() + " could not be saved", "original");
													};
												}
												else
												{
													//if (v2 != "")
													//{
													if (ErrorList.Length > 0) { ErrorList += Environment.NewLine; }
													ErrorList += pdate + " Shift " + s.ToString() + " Mix " + mix + " contains a non-numeric value.";
													//}
												}
											}
										}
									}
								}
							}
						}
						if (_ForecastView == 0 || _ForecastView == 2)
						{
							Wk = 3;
							for (int ic2 = 16; ic2 <= 26; ic2++)
							{
								pdate = GetProdDate(ic2 - 13, 0).ToString("yyyy-MM-dd"); // gvForecastData.Columns[ic].HeaderText;
								for (int s2 = 1; s2 <= 3; s2++)
								{
									txt = (TextBox)row.FindControl("txtWk" + (ic2 - 13).ToString() + "Amt" + s2.ToString());
									hf = (HiddenField)row.FindControl("hfWk" + (ic2 - 13).ToString() + "Amt" + s2.ToString());
									v1 = txt.Text;
									v1 = v1.Replace("$", "").Replace(",", "");
									v2 = hf.Value;
									v2 = v2.Replace("$", "").Replace(",", "");
									if (v1 == "") { v1 = "0"; }
									if (v2 == "") { v2 = "0"; }
									if (v1 != v2)
									{
										if (GenUtilities.IsNumeric(v1))
										{
											qty = Convert.ToDouble(v1);
											if (!SaveForecastItemData(mix, s2, Wk, 0, qty, 1))
											{
												throw new System.ArgumentException("Wk " + Wk.ToString() + "-Shift " + s2.ToString() + " could not be saved", "original");
											};
										}
										else
										{
											if (ErrorList.Length > 0) { ErrorList += Environment.NewLine; }
											ErrorList += pdate + " Shift " + s2.ToString() + " Mix " + mix + " contains a non-numeric value.";
										}
									}
								}
								Wk++;
							}
						}
					}

					if (ErrorList.Length > 0)
					{
						this._ErrMsg = ErrorList;
						this.lblErrorMsg.Text = this._ErrMsg;
					}
					else
					{
						lblStatusForecastMatrix.Text = "Save complete.";
					}

					LoadForecastData();
					UpdateForecastRowTotals();
					//UpdateForecastColumnTotals();
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Forecast data could not be completely saved: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void ddlSpeciesOverall_SelectedIndexChanged(object sender, EventArgs e)
		{
			_SpeciesCode = ddlSpeciesOverall.SelectedValue;
			LoadCurrentGrid();
		}

		protected void gvProducts_RowDeleting(object sender, GridViewDeleteEventArgs e)
		{
			try
			{
				int rowid = e.RowIndex;
				GridViewRow row = gvProducts.Rows[rowid];
				HiddenField hf = (HiddenField)row.FindControl("hfProductLinkID");
				int id = Convert.ToInt32(hf.Value);
				Forecast fc = new Forecast();
				DataTable dt = fc.DeleteForecastProduct(_LocationCode, id, _UserID);
				LoadProductList();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error encountered when attempting to delete: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void gvProducts_RowDeleted(object sender, GridViewDeletedEventArgs e)
		{
			//do nothing
		}

		protected void btnFinishPresent_Click(object sender, EventArgs e)
		{
			try
			{
				this.lblEditStatusMsg.Text = "";
				this.lblErrorMsg.Text = "";
				// Display finish grid
				_TargetGrid = 7;
				ViewState["TargetGrid"] = _TargetGrid.ToString();
				HideAllGridAreas();
				// HERE

				//if (this.chkShowHistory.Checked == true)
				//{
				//	_ShowHistGrid = true;
				//	ViewState["ShowHistGrid"] = "1";
				//}
				//else
				//{
				//	_ShowHistGrid = false;
				//	ViewState["ShowHistGrid"] = "0";
				//}

				this.ddlForecastProdView.ClearSelection();
				this.ddlForecastProdView.SelectedValue = "0";
				string spec = ddlSpeciesOverall.SelectedValue;
				this.lbxThicknessFv.DataTextField = "CodeDescription";
				this.lbxThicknessFv.DataValueField = "Code";
				this.lbxThicknessFv.DataSource = _ThickList;
				this.lbxThicknessFv.DataBind();
				this.lbxThicknessFv.SelectedValue = "0";
				Forecast fc = new Forecast();
				DataTable dt = fc.SelectForecastRegionCodeList(_LocationCode, _RegionCode, "Species", 0, 1, 0, 1, _UserID);
				if (this.lbxSpeciesFv.Items.Count > 0)
				{
					ClearListBox(lbxSpeciesFv, 1);
				}
				this.lbxSpeciesFv.DataSource = dt;
				this.lbxSpeciesFv.DataTextField = "CodeDescription";
				this.lbxSpeciesFv.DataValueField = "Code";
				this.lbxSpeciesFv.DataBind();
				this.lbxSpeciesFv.SelectedValue = "0";

				dt = fc.SelectForecastRegionCodeList(_LocationCode, _RegionCode, "Grade", 0, 1, 0, 1, _UserID);
				if (lbxGradeFv.Items.Count > 0)
				{
					ClearListBox(lbxGradeFv, 1);
				}
				this.lbxGradeFv.DataSource = dt;
				this.lbxGradeFv.DataTextField = "CodeDescription";
				this.lbxGradeFv.DataValueField = "Code";
				this.lbxGradeFv.DataBind();
				this.lbxGradeFv.SelectedValue = "0";

				Commands cmd = new Commands();
				dt = cmd.SelectProductCodeList("Length", 0, 1, 0, 0, 0, _UserID);
				this.lbxLengthFv.DataTextField = "CodeDescription";
				this.lbxLengthFv.DataValueField = "CatCode";
				this.lbxLengthFv.DataSource = dt;
				this.lbxLengthFv.DataBind();
				this.lbxLengthFv.SelectedValue = "0";
				if (_UseCurrentWeekFV == 1)
				{
					this.chkShowCurrentWeekPV.Checked = true;
				}
				else
				{
					this.chkShowCurrentWeekPV.Checked = false;
				}
				this.ddlForecastProdView.SelectedValue = _FinishView.ToString();
				ShowFinishView();
				//this.lbxColorFv loaded in LoadColorList()	//this.lbxSortFv is loaded in LoadSortList()//this.lbxMillingFv is loadede in LoadMillingList()	//this.lbxNoPrintFv is loaded in LoadNoPrintList()
				SetGridDateColumnHeaders(1);
				this.divFinishView.Style["display"] = "block";
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Displaying finish presentation encountered an error: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void btnRefreshProdView_Click(object sender, EventArgs e)
		{
			try
			{
				this.lblEditStatusMsg.Text = "";
				this.lblErrorMsg.Text = "";
				SetGridDateColumnHeaders(1);
				LoadForecastFinishData();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Refreshing finish presentation encountered an error: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void ddlForecastProdView_SelectedIndexChanged(object sender, EventArgs e)
		{
			try
			{
				int iView = Convert.ToInt32(ddlForecastProdView.SelectedValue);
				if (_FinishView != iView)
				{
					_FinishView = iView;
					ViewState["FinishView"] = _FinishView.ToString();
					ShowFinishView();
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error establishing finish view: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void chkEditCurrentWeek_CheckedChanged1(object sender, EventArgs e)
		{
			try
			{
				this.lblEditStatusMsg.Text = "";
				this.lblErrorMsg.Text = "";
				if (chkEditCurrentWeek.Checked == true)
				{
					_UseCurrentWeek = 1;
					this.lblWeekNbr.Text = "00";
				}
				else
				{
					_UseCurrentWeek = 0;
					this.lblWeekNbr.Text = "01";
				}
				ViewState["UseCurrentWeek"] = _UseCurrentWeek.ToString();
				LoadForecastData();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error changing forecast base week: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void chkShowCurrentWeekPV_CheckedChanged(object sender, EventArgs e)
		{
			try
			{
				this.lblEditStatusMsg.Text = "";
				this.lblErrorMsg.Text = "";
				if (this.chkShowCurrentWeekPV.Checked == true)
				{
					_UseCurrentWeekFV = 1;
					this.lblWeekNbrFV.Text = "00";
				}
				else
				{
					_UseCurrentWeekFV = 0;
					this.lblWeekNbrFV.Text = "01";
				}
				ViewState["UseCurrentWeekFV"] = _UseCurrentWeekFV.ToString();
				LoadForecastFinishData();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error changing finish presentation base week: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void btnGotoCalendar_Click(object sender, EventArgs e)
		{
			Response.Redirect("../page/WebCalendar.aspx", true);
		}

		protected void gvMixContents_DataBound(object sender, EventArgs e)
		{
			//lblTotalPct
			lblNbrItems.Text = _TotalItems.ToString();
			lblTotalPct.Text = GenUtilities.FormatNbrSpecial(Math.Round((_TotalPercentage * 100), 1), "", 0, "", ".", 1);
		}

		protected void gvMixList_RowDeleting(object sender, GridViewDeleteEventArgs e)
		{
			// do nothing
		}

		protected void gvMixList_RowDeleted(object sender, GridViewDeletedEventArgs e)
		{
			// do nothing
		}

		protected void btnCheckAllThisPage_Click(object sender, EventArgs e)
		{
			try
			{
				this.lblEditStatusMsg.Text = "";
				this.lblErrorMsg.Text = "";
				CheckBox chk;
				int nrows = gvProducts.Rows.Count;
				for (int row = 0; row < nrows; row++)
				{
					chk = (CheckBox)gvProducts.Rows[row].FindControl("chkProductSelected");
					chk.Checked = true;
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error checking all: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void btnCopyChecked_Click(object sender, EventArgs e)
		{
			try
			{
				this.lblEditStatusMsg.Text = "";
				this.lblErrorMsg.Text = "";
				ddlLengthBC.SelectedValue = "0";
				ddlColorBC.SelectedValue = "0";
				ddlSortBC.SelectedValue = "0";
				ddlMillingBC.SelectedValue = "0";
				ddlNoPrintBC.SelectedValue = "0";
				this.divProductBulkCopy.Style["display"] = "block";
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error during copy initiation: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void btnDeleteChecked_Click(object sender, EventArgs e)
		{
			try
			{
				this.lblEditStatusMsg.Text = "";
				this.lblErrorMsg.Text = "";
				CheckBox chk;
				HiddenField hf;
				int NbrItems = 0;
				GridViewRow rw;
				Forecast fc = new Forecast();
				int nrows = gvProducts.Rows.Count;
				for (int row = 0; row < nrows; row++)
				{
					rw = (GridViewRow)gvProducts.Rows[row];
					chk = (CheckBox)rw.FindControl("chkProductSelected");
					if (chk.Checked == true)
					{
						hf = (HiddenField)gvProducts.Rows[row].FindControl("hfProductLinkID");
						int id = Convert.ToInt32(hf.Value);
						DataTable dt2 = fc.DeleteForecastMixProduct(id, _UserID);
						NbrItems++;
					}
				}
				if (NbrItems > 0)
				{
					LoadProductList();
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error deleting rows: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void btnUncheckAllThisPage_Click(object sender, EventArgs e)
		{
			try
			{
				this.lblEditStatusMsg.Text = "";
				this.lblErrorMsg.Text = "";
				CheckBox chk;
				int nrows = gvProducts.Rows.Count;
				for (int row = 0; row < nrows; row++)
				{
					chk = (CheckBox)gvProducts.Rows[row].FindControl("chkProductSelected");
					chk.Checked = false;
				}
				this.divProductBulkCopy.Style["display"] = "none";
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error unchecking: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void btnUpdateCheckedItems_Click(object sender, EventArgs e)
		{
			try
			{
				this.lblEditStatusMsg.Text = "";
				this.lblErrorMsg.Text = "";
				string len = ddlLengthBC.SelectedValue;
				string color = ddlColorBC.SelectedValue;
				string sort = ddlSortBC.SelectedValue;
				string milling = ddlMillingBC.SelectedValue;
				string noprint = ddlNoPrintBC.SelectedValue;
				if (len == "0") { len = ""; }
				if (color == "0") { color = ""; }
				if (sort == "0") { sort = ""; }
				if (milling == "0") { milling = ""; }
				if (noprint == "0") { noprint = ""; }

				CheckBox chk;
				HiddenField hf;
				Forecast fc = new Forecast();
				int nrows = gvProducts.Rows.Count;
				for (int row = 0; row < nrows; row++)
				{
					chk = (CheckBox)gvProducts.Rows[row].FindControl("chkProductSelected");
					if (chk.Checked == true)
					{
						hf = (HiddenField)gvProducts.Rows[row].FindControl("hfProductLinkID");
						int linkid = Convert.ToInt32(hf.Value);
						hf = (HiddenField)gvProducts.Rows[row].FindControl("hfProductMngdID");
						int pmid = Convert.ToInt32(hf.Value);

						// send copy command to db
						DataTable dt = fc.CopyProductData(_LocationCode, linkid, pmid, len, color, sort, milling, noprint, _UserID);
					}
				}
				LoadProductList();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error copying checked items: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void gvForecastDataAddTotalsRow(double[] Totals)
		{
			try
			{
				if (gvForecastData.Rows.Count > 0)
				{
					double CTotalAmt = 0;
					TableCell HCell;
					GridViewRow HRow = new GridViewRow(1, 0, DataControlRowType.Header, DataControlRowState.Insert);
					// ADD leftmost label and blank cell
					HCell = new TableCell();
					HCell.CssClass = "BlandAndUnblocked";
					HCell.Text = "Totals";
					HCell.ForeColor = Color.White;
					HRow.Cells.Add(HCell);
					HCell = new TableCell();
					HCell.CssClass = "BlandAndUnblocked";
					HCell.ForeColor = Color.White;
					HRow.Cells.Add(HCell);
					// add totals for all columns
					for (int col2 = 2; col2 <= 26; col2++)
					{
						if ((_ForecastView == 0 || _ForecastView == 1 || _ForecastView == 3 || _ForecastView == 4) && col2 < 16)
						{
							if (_ForecastView < 3 || ((_ForecastView == 3 && col2 < 9) || (_ForecastView == 4 && col2 > 8)))
							{
								HCell = new TableCell();
								HCell.CssClass = "BlandAndUnblocked";
								HCell.Text = GenUtilities.FormatNbrSpecial(Math.Round(Totals[col2 - 2], 0), "", 1, ",", ".", 0);
								HCell.ForeColor = Color.White;
								HRow.Cells.Add(HCell);
								CTotalAmt += Totals[col2 - 2];
							}
						}
						if ((_ForecastView == 0 || _ForecastView == 2) && col2 > 15)
						{
							HCell = new TableCell();
							HCell.CssClass = "BlandAndUnblocked";
							HCell.Text = GenUtilities.FormatNbrSpecial(Math.Round(Totals[col2 - 2], 0), "", 1, ",", ".", 0);
							HCell.ForeColor = Color.White;
							HRow.Cells.Add(HCell);
							CTotalAmt += Totals[col2 - 2];
						}
					}
					HCell = new TableCell();
					HCell.CssClass = "BlandAndUnblocked";
					HCell.Text = "";
					HCell.ForeColor = Color.Snow;
					HRow.Cells.Add(HCell);
					HCell = new TableCell();
					HCell.CssClass = "BlandAndUnblocked";
					HCell.Text = GenUtilities.FormatNbrSpecial(Math.Round(CTotalAmt, 0), "", 1, ",", ".", 0);
					HCell.ForeColor = Color.Snow;
					HRow.Cells.Add(HCell);
					HCell = new TableCell();
					HCell.CssClass = "BlandAndUnblocked";
					HRow.Cells.Add(HCell);
					//gvForecastData.Controls[0].Controls.AddAt(0, HRow);
					Table InnerTable = (Table)gvForecastData.Controls[0];
					InnerTable.Rows.AddAt(0, HRow);
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error displaying column totals: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void gvFinishViewAddTotalsHeaderRow(double[] Totals)
		{
			try
			{
				if (gvFinishView.Rows.Count > 0)
				{
					TableCell HCell;
					GridViewRow HRow = new GridViewRow(1, 0, DataControlRowType.Header, DataControlRowState.Insert);
					HCell = new TableCell();
					HCell.CssClass = "BlandAndUnblocked";
					HCell.Text = "Totals";
					HRow.Cells.Add(HCell);
					HCell = new TableCell();
					HCell.CssClass = "BlandAndUnblocked";
					HRow.Cells.Add(HCell);
					HCell = new TableCell();
					HCell.CssClass = "BlandAndUnblocked";
					HRow.Cells.Add(HCell);
					HCell = new TableCell();
					HCell.CssClass = "BlandAndUnblocked";
					HRow.Cells.Add(HCell);
					for (int col2 = 4; col2 <= 28; col2++)
					{
						if ((_FinishView == 0 || _FinishView == 1 || _FinishView == 3 || _FinishView == 4) && col2 < 18)
						{
							if (_FinishView < 3 || ((_FinishView == 3 && col2 < 11) || (_FinishView == 4 && col2 > 10)))
							{
								HCell = new TableCell();
								HCell.CssClass = "BlandAndUnblocked";
								HCell.Text = GenUtilities.FormatNbrSpecial(Math.Round(Totals[col2 - 4], 1), "", 1, ",", ".", 1);
								HRow.Cells.Add(HCell);
							}
						}
						if ((_FinishView == 0 || _FinishView == 2) && col2 > 17)
						{
							HCell = new TableCell();
							HCell.CssClass = "BlandAndUnblocked";
							HCell.Text = GenUtilities.FormatNbrSpecial(Math.Round(Totals[col2 - 4], 1), "", 1, ",", ".", 1);
							HRow.Cells.Add(HCell);
						}
					}
					HCell = new TableCell();
					HCell.CssClass = "BlandAndUnblocked";
					HCell.Text = "";
					HRow.Cells.Add(HCell);
					HCell = new TableCell();
					HCell.CssClass = "BlandAndUnblocked";
					HCell.Text = GenUtilities.FormatNbrSpecial(Math.Round(_TotalAmtf, 1), "", 1, ",", ".", 1);
					HRow.Cells.Add(HCell);
					gvFinishView.Controls[0].Controls.AddAt(0, HRow);
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error displaying column totals: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void gvForecastCodes_PageIndexChanged(object sender, EventArgs e)
		{
			//nothing
		}

		protected void gvForecastCodes_PageIndexChanging(object sender, GridViewPageEventArgs e)
		{
			_PgNbr5 = e.NewPageIndex;
			gvForecastCodes.PageIndex = _PgNbr5;
			ViewState["PageNbr5"] = _PgNbr5.ToString();
			LoadForecastCodes();
		}

		protected void gvForecastCodes_RowCommand(object sender, GridViewCommandEventArgs e)
		{
			this.lblErrorMsg.Text = "";
			try
			{
				Forecast fc = new Forecast();
				string cmd = e.CommandName;
				string arg = e.CommandArgument.ToString();
				int rowID = Convert.ToInt32(arg);
				GridViewRow row = this.gvForecastCodes.Rows[rowID];
				int id = Convert.ToInt32(this.gvForecastCodes.Rows[rowID].Cells[0].Text);
				string CodeType = this.gvForecastCodes.Rows[rowID].Cells[1].Text;
				switch (cmd)
				{
					case "Edit":
						break;
					case "Del":
						if (CodeType != "Setting")
						{
							DataTable dt2 = fc.DeleteForecastCode(_LocationCode, id, _UserID);
						}
						else
						{
							this.lblErrorMsg.Text = "Settings cannot be removed.";
						}
						break;
					default:
						break;
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in product grid row command: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void gvForecastCodes_RowDataBound(object sender, GridViewRowEventArgs e)
		{
			try
			{
				GridViewRow row = e.Row;
				int idx = row.RowIndex;
				if (row.RowType == DataControlRowType.DataRow)
				{
					CheckBox chk;
					string value = string.Empty;
					DataRowView datrow = e.Row.DataItem as DataRowView;
					chk = (CheckBox)row.FindControl("chkUseShift");
					string s = datrow["CodeValue"].ToString().ToUpper();
					if (s == "YES")
					{
						chk.Checked = true;
					}
					else
					{
						chk.Checked = false;
					}
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in row instantiation: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void gvForecastCodes_SelectedIndexChanged(object sender, EventArgs e)
		{
			// nothing
		}

		protected void gvForecastCodes_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
		{
			// nothing
		}

		protected void gvForecastCodes_DataBound(object sender, EventArgs e)
		{
			//nothing
		}

		protected void gvForecastCodes_RowEditing(object sender, GridViewEditEventArgs e)
		{
			//nothing
		}

		protected void btnForecastCodes_Click(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			this.lblEditStatusMsg.Text = "";
			try
			{
				_TargetGrid = 6;
				ViewState["TargetGrid"] = _TargetGrid.ToString();
				this.lblForecastCodeType.Text = "Settings";
				HideAllGridAreas();
				LoadForecastCodes();
				divForecastCodes.Style["display"] = "block";
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Forecast Code area could not be displayed: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void ddlCodeType_SelectedIndexChanged(object sender, EventArgs e)
		{
			LoadForecastCodes();
		}

		protected void btnCopyMixContents_Click(object sender, EventArgs e)
		{
			try
			{
				this.lblEditStatusMsg.Text = "";
				this.lblErrorMsg.Text = "";
				CheckBox chk;
				HiddenField hf;
				int nitems = 0;
				GridViewRow rw;
				_CopyMixID = Convert.ToInt32(ddlMixListProdContents.SelectedValue);
				ViewState["CopyMixID"] = _CopyMixID.ToString();
				EmptyProdList();
				for (int row = 0; row < gvMixContents.Rows.Count; row++)
				{
					rw = gvMixContents.Rows[row];
					chk = (CheckBox)rw.FindControl("chkProductSelected2");
					if (chk.Checked == true)
					{
						hf = (HiddenField)rw.FindControl("hfProdManagedID");
						_ProdItems[nitems] = Convert.ToInt32(hf.Value);
						nitems++;
					}
				}
				_NbrItems = nitems;
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error when trying to copy items: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void btnPasteMixContents_Click(object sender, EventArgs e)
		{
			this.lblEditStatusMsg.Text = "";
			this.lblErrorMsg.Text = "";
			int TargetMixID = Convert.ToInt32(ddlMixListProdContents.SelectedValue);
			string s = string.Empty;
			try
			{
				Forecast fc = new Forecast();
				for (int itm = 0; itm <= 200; itm++)
				{
					if (_ProdItems[itm] > 0)
					{
						DataTable dt = fc.CopyMixProduct(_LocationCode, _CopyMixID, TargetMixID, _ProdItems[itm], _UserID);
						if (dt.Rows.Count == 0)
						{
							this._ErrMsg = "Unknown error encountered when attempting to paste items.";
							this.lblErrorMsg.Text = this._ErrMsg;
						}
						else
						{
							s = dt.Rows[0]["StatusMsg"].ToString();
							if (s != "")
							{
								this._ErrMsg = _ProdItems[itm] + ": " + s;
								this.lblErrorMsg.Text = _ProdItems[itm] + ": " + s;
							}
						}

					}
				}
				LoadMixContentsData();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error when attempting to paste items: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void btnCheckAllMixProds_Click(object sender, EventArgs e)
		{
			try
			{
				//if (_CanEdit == true)
				//{
				this.lblEditStatusMsg.Text = "";
				this.lblErrorMsg.Text = "";
				CheckBox chk;
				int nrows = gvMixContents.Rows.Count;
				for (int row = 0; row < nrows; row++)
				{
					chk = (CheckBox)gvMixContents.Rows[row].FindControl("chkProductSelected2");
					chk.Checked = true;
				}
				//}
				//else
				//{
				//	this._ErrMsg = "Cannot edit at this time.";
				//	this.lblErrorMsg.Text = this._ErrMsg;
				//}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error checking all: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void btnUncheckAllMixProds_Click(object sender, EventArgs e)
		{
			try
			{
				this.lblEditStatusMsg.Text = "";
				this.lblErrorMsg.Text = "";
				//if (_CanEdit == true)
				//{
				CheckBox chk;
				int nrows = gvMixContents.Rows.Count;
				for (int row = 0; row < nrows; row++)
				{
					chk = (CheckBox)gvMixContents.Rows[row].FindControl("chkProductSelected2");
					chk.Checked = false;
				}
				//}
				//else
				//{
				//	this._ErrMsg = "Cannot edit at this time.";
				//	this.lblErrorMsg.Text = this._ErrMsg;
				//}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error unchecking: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void gvFinishView_DataBound(object sender, EventArgs e)
		{
			try
			{
				//HideShiftsIngvFinishView();
				//UpdateFinishColumnTotals();
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in Finish view data binding: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void gvProducts_RowDataBound(object sender, GridViewRowEventArgs e)
		{
			// nothing
			try
			{
				GridViewRow row = e.Row;
				if (row.RowType == DataControlRowType.DataRow)
				{
					_NbrItems++;
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in products data row binding: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void gvProducts_DataBound(object sender, EventArgs e)
		{
			// nothing
		}

		protected void gvFinishView_RowDataBound1(object sender, GridViewRowEventArgs e)
		{
			HiddenField hf;
			HtmlTableRow tr;
			string prodname = string.Empty;
			string pdate = string.Empty;
			int Dy = 0;
			Label lbl;
			string nm = string.Empty;
			double qty = 0;
			string val = string.Empty;
			int Wk = 1;
			GridViewRow row = e.Row;
			if (row.RowType == DataControlRowType.Header)
			{
				try
				{
					//DateTime BaseDate;
					DateTime monday1 = DateTime.Now.AddDays(-(int)DateTime.Now.DayOfWeek + 1); //1 8 15 22 29 36 43 50 57 64 71 78 85
					if (_UseCurrentWeekFV == 1)
					{
						_BaseDatePV = monday1;
					}
					else
					{
						_BaseDatePV = monday1.AddDays(7);
					}
					ViewState["BaseDatePV"] = _BaseDatePV.ToString();

					// calculate dates for column headers
					var format1 = _BaseDatePV.ToString("yyyy-MM-dd");
					DateTime monday2 = _BaseDatePV.AddDays(7);
					var format2 = monday2.ToString("yyyy-MM-dd");
					DateTime monday3 = _BaseDatePV.AddDays(18);
					var format3 = monday3.ToString("yyyy-MM-dd");
					DateTime monday4 = _BaseDatePV.AddDays(25);
					var format4 = monday4.ToString("yyyy-MM-dd");
					DateTime monday5 = _BaseDatePV.AddDays(33);
					var format5 = monday5.ToString("yyyy-MM-dd");
					DateTime monday6 = _BaseDatePV.AddDays(39);
					var format6 = monday6.ToString("yyyy-MM-dd");
					DateTime monday7 = _BaseDatePV.AddDays(46);
					var format7 = monday7.ToString("yyyy-MM-dd");
					DateTime monday8 = _BaseDatePV.AddDays(53);
					var format8 = monday8.ToString("yyyy-MM-dd");
					DateTime monday9 = _BaseDatePV.AddDays(60);
					var format9 = monday9.ToString("yyyy-MM-dd");
					DateTime monday10 = _BaseDatePV.AddDays(67);
					var format10 = monday10.ToString("yyyy-MM-dd");
					DateTime monday11 = _BaseDatePV.AddDays(74);
					var format11 = monday11.ToString("yyyy-MM-dd");
					DateTime monday12 = _BaseDatePV.AddDays(81);
					var format12 = monday12.ToString("yyyy-MM-dd");
					DateTime monday13 = _BaseDatePV.AddDays(88);
					var format13 = monday13.ToString("yyyy-MM-dd");
					DateTime Tue1 = _BaseDatePV.AddDays(1);
					DateTime Wed1 = _BaseDatePV.AddDays(2);
					DateTime Thu1 = _BaseDatePV.AddDays(3);
					DateTime Fri1 = _BaseDatePV.AddDays(4);
					DateTime Sat1 = _BaseDatePV.AddDays(5);
					DateTime Sun1 = _BaseDatePV.AddDays(6);
					DateTime Tue2 = monday2.AddDays(1);
					DateTime Wed2 = monday2.AddDays(2);
					DateTime Thu2 = monday2.AddDays(3);
					DateTime Fri2 = monday2.AddDays(4);
					DateTime Sat2 = monday2.AddDays(5);
					DateTime Sun2 = monday2.AddDays(6);

					// load values into grid header columns
					this.gvFinishView.Columns[4].HeaderText = format1;
					this.gvFinishView.Columns[5].HeaderText = Tue1.ToString("yyyy-MM-dd");
					this.gvFinishView.Columns[6].HeaderText = Wed1.ToString("yyyy-MM-dd");
					this.gvFinishView.Columns[7].HeaderText = Thu1.ToString("yyyy-MM-dd");
					this.gvFinishView.Columns[8].HeaderText = Fri1.ToString("yyyy-MM-dd");
					this.gvFinishView.Columns[9].HeaderText = Sat1.ToString("yyyy-MM-dd");
					this.gvFinishView.Columns[10].HeaderText = Sun1.ToString("yyyy-MM-dd");
					this.gvFinishView.Columns[11].HeaderText = format2;
					this.gvFinishView.Columns[12].HeaderText = Tue2.ToString("yyyy-MM-dd");
					this.gvFinishView.Columns[13].HeaderText = Wed2.ToString("yyyy-MM-dd");
					this.gvFinishView.Columns[14].HeaderText = Thu2.ToString("yyyy-MM-dd");
					this.gvFinishView.Columns[15].HeaderText = Fri2.ToString("yyyy-MM-dd");
					this.gvFinishView.Columns[16].HeaderText = Sat2.ToString("yyyy-MM-dd");
					this.gvFinishView.Columns[17].HeaderText = Sun2.ToString("yyyy-MM-dd");
					this.gvFinishView.Columns[18].HeaderText = format3;
					this.gvFinishView.Columns[19].HeaderText = format4;
					this.gvFinishView.Columns[20].HeaderText = format5;
					this.gvFinishView.Columns[21].HeaderText = format6;
					this.gvFinishView.Columns[22].HeaderText = format7;
					this.gvFinishView.Columns[23].HeaderText = format8;
					this.gvFinishView.Columns[24].HeaderText = format9;
					this.gvFinishView.Columns[25].HeaderText = format10;
					this.gvFinishView.Columns[26].HeaderText = format11;
					this.gvFinishView.Columns[27].HeaderText = format12;
					this.gvFinishView.Columns[28].HeaderText = format13;
				}
				catch (Exception ex)
				{
					this._ErrMsg = "Error setting header dates: " + ex.Message;
					this.lblErrorMsg.Text = this._ErrMsg;
				}
			}

			if (row.RowType == DataControlRowType.DataRow)
			{
				try
				{
					hf = (HiddenField)row.FindControl("hfFPProdFullName");
					prodname = hf.Value;
					for (int tcol = 4; tcol <= 28; tcol++)
					{
						if (tcol <= 10 && (_FinishView == 0 || _FinishView == 1 || _FinishView == 3))
						{
							Wk = 1;
							Dy = tcol - 3;
							for (int shftA = 1; shftA <= 3; shftA++)
							{
								if (shftA == 1 || (shftA == 2 && _UseShift2 == true) || (shftA == 3 && _UseShift3 == true))
								{
									nm = "lblWk1_" + Dy.ToString() + "Amt" + shftA.ToString() + "v";
									lbl = (Label)row.FindControl(nm);
									val = lbl.Text;
									if (val != "")
									{
										qty = Convert.ToDouble(val);
										if (qty == 0) { lbl.Text = ""; }
									}
								}
							}
						}
						if (tcol > 10 && tcol <= 17 && (_FinishView == 0 || _FinishView == 1 || _FinishView == 4))
						{
							Wk = 2;
							Dy = tcol - 10;
							for (int shftB = 1; shftB <= 3; shftB++)
							{
								if (shftB == 1 || (shftB == 2 && _UseShift2 == true) || (shftB == 3 && _UseShift3 == true))
								{
									nm = "lblWk2_" + Dy.ToString() + "Amt" + shftB.ToString() + "v";
									lbl = (Label)row.FindControl(nm);
									val = lbl.Text;
									if (val != "")
									{
										qty = Convert.ToDouble(val);
										if (qty == 0) { lbl.Text = ""; }
									}
								}
							}
						}
						if (tcol > 17 && (_FinishView == 0 || _FinishView == 2))
						{
							Wk = tcol - 15;
							Dy = 0;
							for (int shftC = 1; shftC <= 3; shftC++)
							{
								if (shftC == 1 || (shftC == 2 && _UseShift2 == true) || (shftC == 3 && _UseShift3 == true))
								{
									nm = "lblWk" + Wk.ToString() + "Amt" + shftC.ToString() + "v";  //lblWk7Amt1v
									lbl = (Label)row.FindControl(nm);
									val = lbl.Text;
									if (val != "")
									{
										qty = Convert.ToDouble(val);
										if (qty == 0) { lbl.Text = ""; }
									}
								}
							}
						}
						// show tooltip
						pdate = GetProdDate(Wk, Dy).ToString("yyyy-MM-dd");
						tr = (HtmlTableRow)row.FindControl("trFinishc" + tcol.ToString() + "s1");
						tr.Attributes["title"] = prodname + "/" + pdate;
						if (_UseShift2 == true)
						{
							tr = (HtmlTableRow)row.FindControl("trFinishc" + tcol.ToString() + "s2");
							tr.Attributes["title"] = prodname + "/" + pdate;
						}
						if (_UseShift3 == true)
						{
							tr = (HtmlTableRow)row.FindControl("trFinishc" + tcol.ToString() + "s3");
							tr.Attributes["title"] = prodname + "/" + pdate;
						}
					}
				}
				catch (Exception ex)
				{
					this._ErrMsg = "Error removing finish 0 values: " + ex.Message;
					this.lblErrorMsg.Text = this._ErrMsg;
				}

				// set tooltips for total column
				try
				{
					tr = (HtmlTableRow)row.FindControl("trFinishc30s1");
					tr.Attributes["title"] = prodname + "/Total Shift1";
					if (_UseShift2 == true)
					{
						tr = (HtmlTableRow)row.FindControl("trFinishc30s2");
						tr.Attributes["title"] = prodname + "/Total Shift2";
					}
					if (_UseShift3 == true)
					{
						tr = (HtmlTableRow)row.FindControl("trFinishc30s3");
						tr.Attributes["title"] = prodname + "/Total Shift3";
					}
				}
				catch (Exception ex3)
				{
					this._ErrMsg = "Error establishing tooltip: " + ex3.Message;
					this.lblErrorMsg.Text = this._ErrMsg;
				}
			}
		}

		protected void chkUseShift_CheckedChanged(object sender, EventArgs e)
		{
			try
			{
				CheckBox chk = (CheckBox)sender;
				string useit = "No";
				if (chk.Checked == true) { useit = "Yes"; }
				string sid = chk.ID;
				GridViewRow gvRow = (GridViewRow)chk.Parent.Parent; //.Parent.Parent;
				HiddenField hf = (HiddenField)gvRow.FindControl("hfCodeID");
				int codeid = Convert.ToInt32(hf.Value);
				hf = (HiddenField)gvRow.FindControl("hfCodeValue");
				string code = hf.Value;
				Forecast fc = new Forecast();
				DataTable dt = fc.UpdateForecastCode(codeid, _LocationCode, code, "", 1, useit, 0, 1, _UserID);
				if (dt != null)
				{
					if (dt.Rows.Count > 0)
					{
						if (Convert.ToInt32(dt.Rows[0]["StatusID"]) != 0)
						{
							this._ErrMsg = "The attempt to update the shift data failed. Please inform your web administrator.";
							this.lblErrorMsg.Text = this._ErrMsg;
						}
					}
					else
					{
						this._ErrMsg = "The database did not respond. The attempt to update the shift data failed.";
						this.lblErrorMsg.Text = this._ErrMsg;
					}
				}
				else
				{
					this._ErrMsg = "The attempt to update the shift data failed and returned an unknown error.";
					this.lblErrorMsg.Text = this._ErrMsg;
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in changing code value: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void chkCodeIsShown_CheckedChanged(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			this.lblEditStatusMsg.Text = "";
			try
			{
				CheckBox chk = (CheckBox)sender;
				int chkd = 0;
				if (chk.Checked == true) { chkd = 1; }
				GridViewRow gvRow = (GridViewRow)chk.Parent.Parent; //.Parent.Parent.Parent;
				int idx = gvRow.RowIndex;
				HiddenField hf = (HiddenField)gvRow.FindControl("hfUserCodeID");
				int id = Convert.ToInt32(hf.Value);
				Forecast fc = new Forecast();
				DataTable dt = fc.UpdateForecastCodeShown(id, chkd, _UserID);
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in changing code value: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void gvLengthCodes_RowDataBound(object sender, GridViewRowEventArgs e)
		{
			int idx = e.Row.RowIndex;
			try
			{
				GridViewRow row = e.Row;
				DataRowView datrow = e.Row.DataItem as DataRowView;
				if (row.RowType == DataControlRowType.DataRow)
				{
					CheckBox chk = (CheckBox)row.FindControl("chkCodeIsShown");
					if (datrow["sShown"].ToString() == "Yes")
					{
						chk.Checked = true;
					}
					else
					{
						chk.Checked = false;
					}
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in binding data row #" + idx.ToString() + ": " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void gvLengthCodes_RowCommand(object sender, GridViewCommandEventArgs e)
		{
			string rc = e.CommandSource.ToString();
		}

		protected void gvLengthCodes_RowEditing(object sender, GridViewEditEventArgs e)
		{
			// do nothing
		}

		protected void gvLengthCodes_PageIndexChanged(object sender, EventArgs e)
		{
			// do nothing
		}

		protected void gvLengthCodes_PageIndexChanging(object sender, GridViewPageEventArgs e)
		{
			_PgNbr8 = e.NewPageIndex;
			gvLengthCodes.PageIndex = _PgNbr8;
			ViewState["PageNbr8"] = _PgNbr8.ToString();
			LoadEditLengthCodes();
		}

		protected void gvFinishView_PageIndexChanged(object sender, EventArgs e)
		{
			//nothing
		}

		protected void gvFinishView_PageIndexChanging(object sender, GridViewPageEventArgs e)
		{
			_PgNbr7 = e.NewPageIndex;
			gvFinishView.PageIndex = _PgNbr7;
			ViewState["PageNbr7"] = _PgNbr7.ToString();
			LoadForecastFinishData();
			SetGridDateColumnHeaders(1);
		}

		protected void ddlEditForecastCodeType_SelectedIndexChanged(object sender, EventArgs e)
		{
			try
			{
				int itm = Convert.ToInt32(this.ddlEditForecastCodeType.SelectedValue);
				switch (itm)
				{
					case 0: // settings
						this.lblForecastCodeType.Text = "Settings";
						LoadForecastCodes();
						this.divForecastLengthCodesGrid.Style["display"] = "none";
						this.divForecastCodesGrid.Style["display"] = "block";
						break;
					case 1: // lengths
						this.lblForecastCodeType.Text = "Length Values";
						LoadEditLengthCodes();
						this.divForecastLengthCodesGrid.Style["display"] = "block";
						this.divForecastCodesGrid.Style["display"] = "none";
						break;
					default:
						break;
				}
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in viewing settings list: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}

		}

		protected void btnCloseMixProdArea_Click(object sender, EventArgs e)
		{
			this.lblEditStatusMsg.Text = "";
			this.lblErrorMsg.Text = "";
			this.divMixProductEdit.Style["display"] = "none";
		}

		protected void btnCloneLocation_Click(object sender, EventArgs e)
		{
			try
			{
				this.lblEditStatusMsg.Text = "";
				this.lblErrorMsg.Text = "";
				_LastLabel = lblForecastCodeType.Text;
				ViewState["LastLabel"] = _LastLabel.ToString();
				lblForecastCodeType.Text = "Clone Location";
				this.divForecastCloneLoc.Style["display"] = "block";
				this.divForecastCodesGrid.Style["display"] = "none";
				this.ddlSrcLocationCode.SelectedValue = this.ddlLocationListF.SelectedValue;
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in opening cloning area: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void btnCloneLocationsNow_Click(object sender, EventArgs e)
		{
			try
			{
				this.lblEditStatusMsg.Text = "";
				this.lblErrorMsg.Text = "";
				string sloc = this.ddlSrcLocationCode.SelectedValue;
				string tloc = this.ddlTgtLocationCode.SelectedValue;
				int incprod = 0;
				int incmix = 0;
				int incmixcontent = 0;
				int incsettings = 0;
				if (this.chkCloneProducts.Checked == true) { incprod = 1; }
				if (this.chkCloneMixes.Checked == true) { incmix = 1; }
				if (this.chkCloneMixContents.Checked == true) { incmixcontent = 1; }
				if (this.chkCloneSettings.Checked == true) { incsettings = 1; }

				Forecast fc = new Forecast();
				DataTable dt = fc.CloneLocationData(sloc, tloc, incprod, incmix, incmixcontent, incsettings, _UserID);
				this.divForecastCloneLoc.Style["display"] = "none";
				this.divForecastCodesGrid.Style["display"] = "block";
				lblForecastCodeType.Text = _LastLabel;
				this.lblErrorMsg.Text = "Location was successfully cloned.";
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in cloning a location: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void btnCloseCloneEditArea_Click(object sender, EventArgs e)
		{
			this.lblEditStatusMsg.Text = "";
			this.lblErrorMsg.Text = "";
			this.divForecastCloneLoc.Style["display"] = "none";
			this.divForecastCodesGrid.Style["display"] = "block";
			lblForecastCodeType.Text = _LastLabel;
		}

		protected void btnCheckInLocation_Click(object sender, EventArgs e)
		{
			try
			{
				SetCheckoutData(0, 2);
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in checking in your checkouts: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void btnCheckInEntireLoc_Click(object sender, EventArgs e)
		{
			try
			{
				SetCheckoutData(0, 3);
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error in checking in all checkouts for this location: " + ex.Message;
				this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void chkNoEmptyProducts_CheckedChanged(object sender, EventArgs e)
		{
			_PgNbr7 = 0;
			LoadForecastFinishData();
			SetGridDateColumnHeaders(1);
		}

		protected void btnGotoConsolidation_Click(object sender, EventArgs e)
		{
			Response.Redirect("ForecastConsolidation.aspx", false);
		}

		protected void gvFinishViewH_DataBinding(object sender, EventArgs e)
		{

		}

		protected void gvFinishViewH_RowDataBound(object sender, GridViewRowEventArgs e)
		{

		}

		protected void gvFinishViewH_PageIndexChanged(object sender, EventArgs e)
		{

		}

		protected void gvFinishViewH_PageIndexChanging(object sender, GridViewPageEventArgs e)
		{

		}

		protected void chkShowHistory_CheckedChanged(object sender, EventArgs e)
		{
			if (chkShowHistory.Checked == true)
			{
				this.spnTargetDateH.Style["display"] = "inline";
				_ShowHistGrid = true;
				ViewState["ShowHistGrid"] = "1";
			}
			else
			{
				this.spnTargetDateH.Style["display"] = "none";
				this.txtTargetDateH.Text = "";
				_ShowHistGrid = false;
				ViewState["ShowHistGrid"] = "0";
			}
		}
	}
}