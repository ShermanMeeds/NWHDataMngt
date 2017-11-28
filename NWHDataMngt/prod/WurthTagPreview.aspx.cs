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
	public partial class WurthTagPreview : System.Web.UI.Page
	{
		#region Attributes
		CurrentUser _user = null;
		private CurrBrowser _Browser = null;
		private string _CBuildNbr = "";
		private bool _CanEdit = false;
		private string _ErrMsg = string.Empty;
		private bool _IsAdmin = false;
		private string _LocationCode = String.Empty;
		private int _OrdNbr = 0;
		private int _Page = 0;
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
		private int _WurthOnly = 0;
		#endregion Attributes

		// ********************************************************************************
		#region Properties
		public string BuildNbr { get { return _CBuildNbr; } }

		public string ErrorMsg { get { return _ErrMsg; } }
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
			string s = string.Empty;
			string s2 = string.Empty;
			string s3 = string.Empty;
			string usrname = string.Empty;
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
			if (!_user.IsInRole("wurthedt") && !_user.IsInRole("datmngtedit") && !_user.IsInRole("datmngtview") && !_user.IsAdmin == true && !_user.IsInRole("forecastedit"))
			{
				Session["NoAccessMsg"] = "You do not have access to wurth generation.";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}
			this._CanEdit = true;
			this._IsAdmin = _user.IsAdmin;
			_UserID = _user.UserID;
			int NbrItems = 0;
			//string inbr = "var jogItemNbr=[[i1],[i2],[i3],[i4],[i5],[i6],[i7],[i8],[i9],[i10],[i11],[i12],[i13],[i14],[i15],[i16],[i17],[i18],[i19],[i20]];";
			//string pobr = "var jogPONbr=[[i1],[i2],[i3],[i4],[i5],[i6],[i7],[i8],[i9],[i10],[i11],[i12],[i13],[i14],[i15],[i16],[i17],[i18],[i19],[i20]];";
			//string ft = "var jogFootage=[[i1],[i2],[i3],[i4],[i5],[i6],[i7],[i8],[i9],[i10],[i11],[i12],[i13],[i14],[i15],[i16],[i17],[i18],[i19],[i20]];";
			//string len = "var jogLen=[[i1],[i2],[i3],[i4],[i5],[i6],[i7],[i8],[i9],[i10],[i11],[i12],[i13],[i14],[i15],[i16],[i17],[i18],[i19],[i20]];";

			if (!this.IsPostBack)
			{
				try
				{
					string CustAddr = string.Empty;
					string CustCity = string.Empty;
					string CustCountry = string.Empty;
					string CustName = string.Empty;
					string CustPO = string.Empty;
					string CustSt = string.Empty;
					string CustZip = string.Empty;
					string ItemNbr = string.Empty;
					double Fig = 0;
					_Page = Convert.ToInt32(Request["p"]);
					_OrdNbr = Convert.ToInt32(Request["o"]);
					_WurthOnly = Convert.ToInt32(Request["w"]);
					if (_OrdNbr > 0)
					{
						// Load Order and associated data
						//Commands cmd = new Commands();
						//DataTable dt0 = cmd.SelectOrderNbrData(_OrdNbr, _UserID);
						//if (dt0.Rows.Count > 0)
						//{
						//	CustName = dt0.Rows[0]["CustName"].ToString();
						//	CustAddr = dt0.Rows[0]["CustAddress"].ToString();
						//	CustCity = dt0.Rows[0]["CustCity"].ToString();
						//	CustCountry = dt0.Rows[0]["Country"].ToString();
						//	CustSt = dt0.Rows[0]["StProv"].ToString();
						//	CustZip = dt0.Rows[0]["Zip"].ToString();
						//	CustPO = dt0.Rows[0]["CustPO"].ToString();
						//}

						// populate page objects
						DataRow dr;
						//DataTable dt = cmd.SelectOrderItemData(_OrdNbr, 1, (_Page + 1), _UserID);
						SalesFunctions sf = new SalesFunctions();
						DataTable dt = sf.SelectLTWurthProductData(_OrdNbr, (_Page + 1), _WurthOnly, _UserID);
						NbrItems = dt.Rows.Count;
						if (NbrItems > 0)
						{
							for (int rowz = 0; rowz < 20; rowz++)
							{
								if (rowz < NbrItems)
								{
									dr = dt.Rows[rowz];
									ItemNbr = "0";
									Label lbl = new Label();
									// if more than one item, show print area (half page each)
									if (rowz == 1) { this.divOrderItem1.Style["display"] = "block"; }
									if (rowz == 2) { this.divOrderItem2.Style["display"] = "block"; }
									if (rowz == 3) { this.divOrderItem3.Style["display"] = "block"; }
									if (rowz == 4) { this.divOrderItem4.Style["display"] = "block"; }
									if (rowz == 5) { this.divOrderItem5.Style["display"] = "block"; }
									if (rowz == 6) { this.divOrderItem6.Style["display"] = "block"; }
									if (rowz == 7) { this.divOrderItem7.Style["display"] = "block"; }
									if (rowz == 8) { this.divOrderItem8.Style["display"] = "block"; }
									if (rowz == 9) { this.divOrderItem9.Style["display"] = "block"; }
									if (rowz == 10) { this.divOrderItem10.Style["display"] = "block"; }
									if (rowz == 11) { this.divOrderItem11.Style["display"] = "block"; }
									if (rowz == 12) { this.divOrderItem12.Style["display"] = "block"; }
									if (rowz == 13) { this.divOrderItem13.Style["display"] = "block"; }
									if (rowz == 14) { this.divOrderItem14.Style["display"] = "block"; }
									if (rowz == 15) { this.divOrderItem15.Style["display"] = "block"; }
									if (rowz == 16) { this.divOrderItem16.Style["display"] = "block"; }
									if (rowz == 17) { this.divOrderItem17.Style["display"] = "block"; }
									if (rowz == 18) { this.divOrderItem18.Style["display"] = "block"; }
									if (rowz == 19) { this.divOrderItem19.Style["display"] = "block"; }
									// fill in associated data for print area
									lbl = (Label)this.FindControl("lblMainTagHeader" + rowz.ToString());
									if (lbl != null) { lbl.Text = dr["CustName"].ToString(); }
									lbl = (Label)this.FindControl("lblTagHdrAddress" + rowz.ToString());
									if (lbl != null) { lbl.Text = dr["CustAddress"].ToString(); }
									lbl = (Label)this.FindControl("lblTagHdrCityStZip" + rowz.ToString());
									if (lbl != null) { lbl.Text = dr["CustCity"].ToString() + " " + dr["StProv"].ToString() + " " + dr["Zip"].ToString(); }
									lbl = (Label)this.FindControl("lblTagHdrCountry" + rowz.ToString());
									if (lbl != null) { lbl.Text = dr["Country"].ToString(); }
									lbl = (Label)this.FindControl("lblOrderNbr" + rowz.ToString());
									if (lbl != null) { lbl.Text = _OrdNbr.ToString(); }
									lbl = (Label)this.FindControl("lblShipDate" + rowz.ToString());
									if (lbl != null) { lbl.Text = dr["sShipDate"].ToString(); }

									lbl = (Label)this.FindControl("lblItemNbr" + rowz.ToString());
									ItemNbr = dr["WurthCode"].ToString().ToUpper();
									if (lbl != null) { lbl.Text = ItemNbr; }
									lbl = (Label)this.FindControl("lblItemNbrBarCode" + rowz.ToString());
									if (lbl != null) { lbl.Text = ItemNbr; }

									lbl = (Label)this.FindControl("lblPONbrBarCode" + rowz.ToString());
									if (lbl != null) { lbl.Text = dr["CustPO"].ToString(); }
									lbl = (Label)this.FindControl("lblFootageBarCode" + rowz.ToString());
									Fig = Convert.ToDouble(dr["WWGVol"]) * 1000;
									if (lbl != null) { lbl.Text = Fig.ToString(); }
									lbl = (Label)this.FindControl("lblLengthBarCode" + rowz.ToString());
									if (lbl != null) { lbl.Text = dr["iProdLen"].ToString(); }
									lbl = (Label)this.FindControl("lblPackage" + rowz.ToString());
									s = dt.Rows[0]["ProdWidth"].ToString();
									if (s == null) { s = ""; }
									s2 = dt.Rows[0]["iProdLen"].ToString();
									if (s2 == null) { s2 = ""; }
									s3 = dt.Rows[0]["PkgHeight"].ToString();
									if (s3 == "") { s3 = "0"; }
									if (lbl != null) { lbl.Text = s3 + "x" + s + "x" + s2; }
									lbl = (Label)this.FindControl("lblUnitNbrValue" + rowz.ToString());
									if (lbl != null) { lbl.Text = dr["WurthCode"].ToString(); }
									lbl = (Label)this.FindControl("lblUnitNbrValue" + rowz.ToString());
									if (lbl != null) { lbl.Text = dr["TagNbr"].ToString(); }
								}
								else
								{
									if (rowz == 1) { this.divOrderItem1.Style["display"] = "none"; }
									if (rowz == 2) { this.divOrderItem2.Style["display"] = "none"; }
									if (rowz == 3) { this.divOrderItem3.Style["display"] = "none"; }
									if (rowz == 4) { this.divOrderItem4.Style["display"] = "none"; }
									if (rowz == 5) { this.divOrderItem5.Style["display"] = "none"; }
									if (rowz == 6) { this.divOrderItem6.Style["display"] = "none"; }
									if (rowz == 7) { this.divOrderItem7.Style["display"] = "none"; }
									if (rowz == 8) { this.divOrderItem8.Style["display"] = "none"; }
									if (rowz == 9) { this.divOrderItem9.Style["display"] = "none"; }
									if (rowz == 10) { this.divOrderItem10.Style["display"] = "none"; }
									if (rowz == 11) { this.divOrderItem11.Style["display"] = "none"; }
									if (rowz == 12) { this.divOrderItem12.Style["display"] = "none"; }
									if (rowz == 13) { this.divOrderItem13.Style["display"] = "none"; }
									if (rowz == 14) { this.divOrderItem14.Style["display"] = "none"; }
									if (rowz == 15) { this.divOrderItem15.Style["display"] = "none"; }
									if (rowz == 16) { this.divOrderItem16.Style["display"] = "none"; }
									if (rowz == 17) { this.divOrderItem17.Style["display"] = "none"; }
									if (rowz == 18) { this.divOrderItem18.Style["display"] = "none"; }
									if (rowz == 19) { this.divOrderItem19.Style["display"] = "none"; }
								}
							} //or (int rowz = 0; rowz < 20; rowz++)
						} //NbrItems > 0
						else
						{
							divErrorMsg.Style["display"] = "block";
							lblErrorMsg.Text = "No items were found for that order number.";
						}
					}
					else
					{
						divErrorMsg.Style["display"] = "block";
						lblErrorMsg.Text = "Invalid order number.";
					}
				}
				catch (Exception ex)
				{
					this._ErrMsg = "Could not generate Wurth-Style tags. Initial data Load encountered an error: " + ex.Message;
					this.lblErrorMsg.Text = this._ErrMsg;
				}

			}
			string jsScript = "<script type=\"text/javascript\">var jgNItems=" + NbrItems.ToString() + ";</script>"; 
			//window.print(); window.onfocus = function() { window.close();
			Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "PrintThisForm", jsScript);
		}
	}
}