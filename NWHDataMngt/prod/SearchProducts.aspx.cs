using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using DataLayer;

namespace DataMngt.page
{
    public partial class SearchProducts : System.Web.UI.Page
    {
        CurrentUser _user = null;
        private CurrBrowser _Browser = null;
        private string _CBuildNbr = "";
        private int _UserID = 0;
        private int _PgSize = 10;
        private int _PgNbr = 0;
        private string strSessionVariableName = string.Empty;

        // setup my datables here(mnost are used just to populate the dropdowns)
        protected DataTable tblType = new DataTable();
        protected DataTable tblCode = new DataTable();
        protected DataTable tblSpecie = new DataTable();
        protected DataTable tblColor = new DataTable();
        protected DataTable tblGrade = new DataTable();
        protected DataTable tblSeasoning = new DataTable();
        protected DataTable tblSurface = new DataTable();
        protected DataTable tblRework = new DataTable();
        protected DataTable tblSort = new DataTable();
        protected DataTable tblCertification = new DataTable();
        protected DataTable tblOthers = new DataTable();
        protected DataTable tblOwner = new DataTable();
        protected DataTable tblWidth = new DataTable();
        protected DataTable tblLength = new DataTable();
        protected DataTable tblThickness = new DataTable();
        protected DataTable tblAdd1 = new DataTable();
        protected DataTable tblAdd2 = new DataTable();

        protected DataTable tblMain = new DataTable();

        // variables to hold the pick values from the drop downs
        protected string prodTypeParm;
        protected string prodFilterParm;
        protected string prodCodeParm;
        protected string prodDescParm;
        protected string specieParm;
        protected string reworkParm;
        protected string widthParm;
        protected string colorParm;
        protected string sortParm;
        protected string lengthParm;
        protected string gradeParm;
        protected string certParm;
        protected string thicknessParm;
        protected string drynessParm;
        protected string othersParm;
        protected string add1Parm;
        protected string surfaceParm;
        protected string ownerParm;
        protected string add2Parm;

        protected bool prodTypeFlag;
        protected bool prodFilterFlag;
        protected bool prodCodeFlag;
        protected bool prodDescFlag;
        protected bool specieFlag;
        protected bool reworkFlag;
        protected bool widthFlag;
        protected bool colorFlag;
        protected bool sortFlag;
        protected bool lengthFlag;
        protected bool gradeFlag;
        protected bool certFlag;
        protected bool thicknessFlag;
        protected bool drynessFlag;
        protected bool othersFlag;
        protected bool add1Flag;
        protected bool surfaceFlag;
        protected bool ownerFlag;
        protected bool add2Flag;

        public DataMngtTool DataObj = new DataMngtTool();

        protected enum WhichCodeList
        {
            NoneSelected,
            Colors,
            Dryness,
            Grades,
            Lengths,
            Others,
            Reworks,
            Sorts,
            Species,
            Surface,
            Thickness,
            Widths,
            Certifications
        }

    #region "Main Code Block"
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
					this.lblErrorMsg.Text = "";
            string usrname = "";
            //_PgNbr = 0;
            //_PgSize = 20;
            //this.ddlPageSize.SelectedValue = "20";
            string logFilePath = System.Configuration.ConfigurationManager.AppSettings["AppLogFilePath"].ToString();

            // grab browser data
            //if (Session["CurrentUser"] == null)
            //{
                string ips = System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
                string CurrSessionID = System.Web.HttpContext.Current.Session.SessionID;
                _Browser = new CurrBrowser(System.Web.HttpContext.Current.Request);
            //}
            //else
            //{
            //    _Browser = (CurrBrowser)Session["bw"];
            //}

					string AssumedLogin = string.Empty;
					if (HttpContext.Current.Session["AssumedEntityLogin"] != null)
					{
						if (HttpContext.Current.Session["AssumedEntityLogin"].ToString() != "") { AssumedLogin = HttpContext.Current.Session["AssumedEntityLogin"].ToString(); }
					}
					
					
					// check for user rights to this page
					//if (Session["UserName"] == null)
     //       {
     //           usrname = Request.ServerVariables["LOGON_USER"];
     //           HttpContext.Current.Session["UserName"] = usrname;
     //       }
     //       else
     //       {
     //       }
			usrname = HttpContext.Current.Session["UserName"].ToString();
			_user = new CurrentUser(usrname, logFilePath, AssumedLogin); // SessionHelper.GetCurrentUser(Request.ServerVariables["LOGON_USER"]);

			//_user = (CurrentUser)HttpContext.Current.Session["CurrentUser"];

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
                Session["NoAccessMsg"] = "You do not have access to the products search application";
                Response.Redirect("../NoAcc/NoAccess.aspx", true);
            }

            // check for specific rights to cat tool
            if (_user.AccessRights < 2 && _user.CatToolRights == 0)
            {
                Session["NoAccessMsg"] = "You do not have access to the Products Search Tool.";
                Response.Redirect("../NoAcc/NoAccess.aspx", true);
            }

            _CBuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
            _UserID = Convert.ToInt32(_user.UserID);

            strSessionVariableName = string.Concat(_user.UserID.ToString(), SearchProductsDataLayer.TableName);
            
            if (!this.IsPostBack)
            {
                tblType.Columns.Add(new DataColumn(SearchProductsDataLayer.CodeCol, typeof(string)));

                tblCode.Columns.Add(new DataColumn(SearchProductsDataLayer.CodeCol, typeof(string)));

                tblSpecie.Columns.Add(new DataColumn(SearchProductsDataLayer.CodeCol, typeof(string)));
                tblSpecie.Columns.Add(new DataColumn(SearchProductsDataLayer.DescriptionCol, typeof(string)));

                tblColor.Columns.Add(new DataColumn(SearchProductsDataLayer.CodeCol, typeof(string)));
                tblColor.Columns.Add(new DataColumn(SearchProductsDataLayer.DescriptionCol, typeof(string)));

                tblGrade.Columns.Add(new DataColumn(SearchProductsDataLayer.CodeCol, typeof(string)));
                tblGrade.Columns.Add(new DataColumn(SearchProductsDataLayer.DescriptionCol, typeof(string)));

                tblSeasoning.Columns.Add(new DataColumn(SearchProductsDataLayer.CodeCol, typeof(string)));
                tblSeasoning.Columns.Add(new DataColumn(SearchProductsDataLayer.DescriptionCol, typeof(string)));

                tblSurface.Columns.Add(new DataColumn(SearchProductsDataLayer.CodeCol, typeof(string)));
                tblSurface.Columns.Add(new DataColumn(SearchProductsDataLayer.DescriptionCol, typeof(string)));

                tblRework.Columns.Add(new DataColumn(SearchProductsDataLayer.CodeCol, typeof(string)));
                tblRework.Columns.Add(new DataColumn(SearchProductsDataLayer.DescriptionCol, typeof(string)));

                tblSort.Columns.Add(new DataColumn(SearchProductsDataLayer.CodeCol, typeof(string)));
                tblSort.Columns.Add(new DataColumn(SearchProductsDataLayer.DescriptionCol, typeof(string)));

                tblCertification.Columns.Add(new DataColumn(SearchProductsDataLayer.CodeCol, typeof(string)));
                tblCertification.Columns.Add(new DataColumn(SearchProductsDataLayer.DescriptionCol, typeof(string)));

                tblOthers.Columns.Add(new DataColumn(SearchProductsDataLayer.CodeCol, typeof(string)));
                tblOthers.Columns.Add(new DataColumn(SearchProductsDataLayer.DescriptionCol, typeof(string)));

                tblOwner.Columns.Add(new DataColumn(SearchProductsDataLayer.CodeCol, typeof(string)));
                tblOwner.Columns.Add(new DataColumn(SearchProductsDataLayer.DescriptionCol, typeof(string)));

                tblWidth.Columns.Add(new DataColumn(SearchProductsDataLayer.CodeCol, typeof(string)));
                tblWidth.Columns.Add(new DataColumn(SearchProductsDataLayer.DescriptionCol, typeof(string)));

                tblLength.Columns.Add(new DataColumn(SearchProductsDataLayer.CodeCol, typeof(string)));
                tblLength.Columns.Add(new DataColumn(SearchProductsDataLayer.DescriptionCol, typeof(string)));

                tblThickness.Columns.Add(new DataColumn(SearchProductsDataLayer.CodeCol, typeof(string)));
                tblThickness.Columns.Add(new DataColumn(SearchProductsDataLayer.DescriptionCol, typeof(string)));

                tblAdd1.Columns.Add(new DataColumn(SearchProductsDataLayer.CodeCol, typeof(string)));
                tblAdd1.Columns.Add(new DataColumn(SearchProductsDataLayer.DescriptionCol, typeof(string)));

                tblAdd2.Columns.Add(new DataColumn(SearchProductsDataLayer.CodeCol, typeof(string)));
                tblAdd2.Columns.Add(new DataColumn(SearchProductsDataLayer.DescriptionCol, typeof(string)));

                // main data table, lot of columns in this puppy
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.OldTypeCol, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.OldCodeCol, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.OldDescriptionCol, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.NewTypeCol, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.NewCodeCol, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.NewDescriptionCol, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.OldDesc1Col, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.OldDesc2Col, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.OldDesc3Col, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.OldDesc4Col, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.OldDesc5Col, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.OldDesc6Col, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.OldDesc7Col, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.NewDesc1Col, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.NewDesc2Col, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.NewDesc3Col, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.NewDesc4Col, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.NewDesc5Col, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.NewDesc6Col, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.NewDesc7Col, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.NewDesc8Col, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.NewDesc9Col, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.NewDesc10Col, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.NewDesc11Col, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.NewDesc12Col, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.NewDesc13Col, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.NewDesc14Col, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.NewDesc15Col, typeof(string)));
                tblMain.Columns.Add(new DataColumn(SearchProductsDataLayer.ProductLinkIdCol, typeof(long)));
              
                tblType = DataObj.GetProductTypeList();
                drpProdTypes.DataSource = tblType;
                drpProdTypes.DataBind();
                drpProdTypes.SelectedIndex = 0;
                drpCodeList.Enabled = false;
                
                drpProFilter.DataSource = tblType;
                drpProFilter.DataBind();
                drpProFilter.SelectedIndex = 0;
                
                divDataGrid.Visible = false;
                drpAdd1.Enabled = false;
                drpOwner.Enabled = false;
                drpAdd2.Enabled = false;
            }
        }

    #endregion

    #region "Page Event Methods"

        protected void drpPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            Reset_Grid_Page();
        }
        protected void drpProdTypes_SelectedIndexChanged(object sender, EventArgs e)
        {
            KeyValuePair<bool, string> retData = Check_For_Value(drpProdTypes, prodTypeParm, prodTypeFlag);
            prodTypeFlag = retData.Key;
            prodTypeParm = retData.Value;

            if (prodTypeFlag)
            {
                tblCode = DataObj.GetProductCodeList(prodTypeParm);

                drpCodeList.DataSource = tblCode;
                drpCodeList.DataBind();
                drpCodeList.SelectedIndex = 0;
                drpCodeList.Enabled = true;
                txtCode.Enabled = true;
                drpProFilter.Text = string.Empty;

                Reset_Attrbute_Selections();
            }
            else
            {
                drpCodeList.Text = string.Empty;
                drpCodeList.Enabled = false;
                txtCode.Text = string.Empty;
                txtCode.Enabled = false;
            }
        }
        protected void drpProFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            KeyValuePair<bool, string> retData = Check_For_Value(drpProFilter, prodFilterParm, prodFilterFlag);
            prodFilterFlag = retData.Key;
            prodFilterParm = retData.Value;

            if (prodFilterFlag)
            {
                drpProdTypes.Text = string.Empty;
                drpCodeList.Text = string.Empty;
                txtCode.Text = string.Empty;
                drpCodeList.Enabled = false;
                txtCode.Enabled = false;

                tblSpecie = DataObj.GetRequestCodeList(Convert.ToInt32(WhichCodeList.Species), prodFilterParm);
                drpSpecie.DataSource = tblSpecie;
                drpSpecie.DataBind();
                drpSpecie.SelectedIndex = 0;
                drpSpecie.Enabled = true;

                tblColor = DataObj.GetRequestCodeList(Convert.ToInt32(WhichCodeList.Colors), prodFilterParm);
                drpColor.DataSource = tblColor;
                drpColor.DataBind();
                drpColor.SelectedIndex = 0;
                drpColor.Enabled = true;

                tblGrade = DataObj.GetRequestCodeList(Convert.ToInt32(WhichCodeList.Grades), prodFilterParm);
                drpGrade.DataSource = tblGrade;
                drpGrade.DataBind();
                drpGrade.SelectedIndex = 0;
                drpGrade.Enabled = true;

                tblSeasoning = DataObj.GetRequestCodeList(Convert.ToInt32(WhichCodeList.Dryness), prodFilterParm);
                drpDryness.DataSource = tblSeasoning;
                drpDryness.DataBind();
                drpDryness.SelectedIndex = 0;
                drpDryness.Enabled = true;

                tblSurface = DataObj.GetRequestCodeList(Convert.ToInt32(WhichCodeList.Surface), prodFilterParm);
                drpSurface.DataSource = tblSurface;
                drpSurface.DataBind();
                drpSurface.SelectedIndex = 0;
                drpSurface.Enabled = true;

                tblRework = DataObj.GetRequestCodeList(Convert.ToInt32(WhichCodeList.Reworks), prodFilterParm);
                drpRework.DataSource = tblRework;
                drpRework.DataBind();
                drpRework.SelectedIndex = 0;
                drpRework.Enabled = true;

                tblSort = DataObj.GetRequestCodeList(Convert.ToInt32(WhichCodeList.Sorts), prodFilterParm);
                drpSort.DataSource = tblSort;
                drpSort.DataBind();
                drpSort.SelectedIndex = 0;
                drpSort.Enabled = true;

                tblCertification = DataObj.GetRequestCodeList(Convert.ToInt32(WhichCodeList.Certifications), prodFilterParm);
                drpCert.DataSource = tblCertification;
                drpCert.DataBind();
                drpCert.SelectedIndex = 0;
                drpCert.Enabled = true;

                tblOthers = DataObj.GetRequestCodeList(Convert.ToInt32(WhichCodeList.Others), prodFilterParm);
                drpOthers.DataSource = tblOthers;
                drpOthers.DataBind();
                drpOthers.SelectedIndex = 0;
                drpOthers.Enabled = true;

                tblWidth = DataObj.GetRequestCodeList(Convert.ToInt32(WhichCodeList.Widths), prodFilterParm);
                drpWidth.DataSource = tblWidth;
                drpWidth.DataBind();
                drpWidth.SelectedIndex = 0;
                drpWidth.Enabled = true;

                tblLength = DataObj.GetRequestCodeList(Convert.ToInt32(WhichCodeList.Lengths), prodFilterParm);
                drpLength.DataSource = tblLength;
                drpLength.DataBind();
                drpLength.SelectedIndex = 0;
                drpLength.Enabled = true;

                tblThickness = DataObj.GetRequestCodeList(Convert.ToInt32(WhichCodeList.Thickness), prodFilterParm);
                drpThickness.DataSource = tblThickness;
                drpThickness.DataBind();
                drpThickness.SelectedIndex = 0;
                drpThickness.Enabled = true;

                Reset_Attrbute_Selections();
            }
            else
            {
                Reset_Attrbute_Selections();
                drpSpecie.Enabled = false;
                drpRework.Enabled = false;
                drpWidth.Enabled = false;
                drpColor.Enabled = false;
                drpSort.Enabled = false;
                drpLength.Enabled = false;
                drpGrade.Enabled = false;
                drpCert.Enabled = false;
                drpThickness.Enabled = false;
                drpDryness.Enabled = false;
                drpOthers.Enabled = false;
                //drpAdd1.SelectedIndex = 0;
                drpSurface.Enabled = false;
                //drpOwner.SelectedIndex = 0;
                //drpAdd2.SelectedIndex = 0;
            }
        }
        protected void txtCode_TextChanged(object sender, EventArgs e)
        {
            drpCodeList.Text = string.Empty;
        }
        protected void drpCodeList_SelectedIndexChanged(object sender, EventArgs e)
        {
            KeyValuePair<bool, string> retData = Check_For_Value(drpCodeList, prodCodeParm, prodCodeFlag);
            prodCodeFlag = retData.Key;
            prodCodeParm = retData.Value;

            if (prodCodeFlag)
            {
                txtCode.Text = string.Empty;
            }
        }
        protected void txtProdDesc_TextChanged(object sender, EventArgs e)
        {
            if ((string.Compare(txtProdDesc.Text.ToString(), prodDescParm, true)) == 0)
            {
                prodDescFlag = true;
                prodDescParm = txtProdDesc.Text.ToString().Trim();
            }
            else
            {
                prodDescFlag = false;
            }
        }
        protected void drpSpecie_SelectedIndexChanged(object sender, EventArgs e)
        {
            Check_Species();
        }
        protected void drpRework_SelectedIndexChanged(object sender, EventArgs e)
        {
            Check_Rework();
        }
        protected void drpWidth_SelectedIndexChanged(object sender, EventArgs e)
        {
            Check_Width();
        }
        protected void drpColor_SelectedIndexChanged(object sender, EventArgs e)
        {
            Check_Color();
        }
        protected void drpSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            Check_Sort();
        }
        protected void drpLength_SelectedIndexChanged(object sender, EventArgs e)
        {
            Check_Length();
        }
        protected void drpGrade_SelectedIndexChanged(object sender, EventArgs e)
        {
            Check_Grade();
        }
        protected void drpCert_SelectedIndexChanged(object sender, EventArgs e)
        {
            Check_Cert();
        }
        protected void drpThickness_SelectedIndexChanged(object sender, EventArgs e)
        {
            Check_Thickness();
        }
        protected void drpDryness_SelectedIndexChanged(object sender, EventArgs e)
        {
            Check_Dryness();
        }
        protected void drpOthers_SelectedIndexChanged(object sender, EventArgs e)
        {
            Check_Others();
        }
        protected void drpAdd1_SelectedIndexChanged(object sender, EventArgs e)
        {
            Check_Add1();
        }
        protected void drpSurface_SelectedIndexChanged(object sender, EventArgs e)
        {
            Check_Surface();
        }
        protected void drpOwner_SelectedIndexChanged(object sender, EventArgs e)
        {
            Check_Owner();
        }
        protected void drpAdd2_SelectedIndexChanged(object sender, EventArgs e)
        {
            Check_Add2();
        }
        protected void gvMainData_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            _PgNbr = e.NewPageIndex;
            Reset_Grid_Page();
        }
        protected void gvMainData_PageIndexChanged(object sender, EventArgs e)
        {
        }
        protected void btnRefilterDataGrid_Click(object sender, EventArgs e)
        {
            string typeVal = string.Empty;
            string codeVal = string.Empty;
            string descVal = string.Empty;

            lblErrorMsg.Text = string.Empty;

            typeVal = drpProdTypes.Text.ToString();
            codeVal = drpCodeList.Text.ToString();
            descVal = txtProdDesc.Text.ToString();

            Check_Species();
            Check_Rework();
            Check_Width();
            Check_Color();
            Check_Sort();
            Check_Length();
            Check_Grade();
            Check_Cert();
            Check_Thickness();
            Check_Dryness();
            Check_Others();
            Check_Add1();
            Check_Surface();
            Check_Owner();
            Check_Add2();

            string searchCode = (string.IsNullOrWhiteSpace(codeVal) ? txtCode.Text.ToString().Trim() : codeVal);

            // nothing selected at all so generate eerror message and jump out
            if (string.IsNullOrWhiteSpace(typeVal) && (string.IsNullOrWhiteSpace(searchCode)) && (string.IsNullOrWhiteSpace(descVal)))
            {
                if ((!prodTypeFlag) &&
                   (!prodCodeFlag) &&
                   (!prodDescFlag) &&
                   (!specieFlag) &&
                   (!reworkFlag) &&
                   (!widthFlag) &&
                   (!colorFlag) &&
                   (!sortFlag) &&
                   (!lengthFlag) &&
                   (!gradeFlag) &&
                   (!certFlag) &&
                   (!thicknessFlag) &&
                   (!drynessFlag) &&
                   (!othersFlag) &&
                   (!add1Flag) &&
                   (!surfaceFlag) &&
                   (!ownerFlag))
                {
                    lblErrorMsg.Text = SearchProductsDataLayer.ErrorNothingToSearchBy;
                    return;
                }
            }

            if ((!string.IsNullOrWhiteSpace(typeVal) && string.IsNullOrWhiteSpace(searchCode)) ||
               (string.IsNullOrWhiteSpace(typeVal) && !string.IsNullOrWhiteSpace(searchCode)))
            {
                lblErrorMsg.Text = SearchProductsDataLayer.ErrorSearchProdTypeCodeIncomplete;
                return;
            }

            gvMainData.Enabled = true;
            gvMainData.Visible = true;
            tblMain.Clear();
            _PgNbr = 0;

            // searchs by code + type + description
            if (!string.IsNullOrWhiteSpace(typeVal) || !string.IsNullOrWhiteSpace(searchCode) || !string.IsNullOrWhiteSpace(descVal))
            {
                tblMain.Clear();
                _PgNbr = 0;
                tblMain = DataObj.GetMatchedProductsByDesc(typeVal, searchCode, descVal);

                gvMainData.AutoGenerateColumns = false;
                gvMainData.DataBind();
                Reset_Grid_Page();
                Session[strSessionVariableName] = tblMain;
                divDataGrid.Visible = true;
                return;
            }

            // searchs by attributes (1 or many)
            tblMain = DataObj.GetMatchedProductsByAttributes(specieParm, reworkParm, widthParm, colorParm, sortParm,
                                                             lengthParm, gradeParm, certParm, thicknessParm, drynessParm,
                                                             othersParm, add1Parm, surfaceParm, ownerParm, add2Parm);

            gvMainData.AutoGenerateColumns = false;
            gvMainData.DataBind();
            Session[strSessionVariableName] = tblMain;
            Reset_Grid_Page();
            divDataGrid.Visible = true;
        }

   #endregion

   #region "Associated Methods"

        private void Check_Species()
        {
            KeyValuePair<bool, string> retData = Check_For_Value(drpSpecie, specieParm, specieFlag);
            specieFlag = retData.Key;
            specieParm = retData.Value;
        }
        private void Check_Rework()
        {
            KeyValuePair<bool, string> retData = Check_For_Value(drpRework, reworkParm, reworkFlag);
            reworkFlag = retData.Key;
            reworkParm = retData.Value;
        }
        private void Check_Width()
        {
            KeyValuePair<bool, string> retData = Check_For_Value(drpWidth, widthParm, widthFlag);
            widthFlag = retData.Key;
            widthParm = retData.Value;
        }
        private void Check_Color()
        {
            KeyValuePair<bool, string> retData = Check_For_Value(drpProdTypes, prodTypeParm, prodTypeFlag);
            prodTypeFlag = retData.Key;
            prodTypeParm = retData.Value;
        }
        private void Check_Sort()
        {
            KeyValuePair<bool, string> retData = Check_For_Value(drpSort, sortParm, sortFlag);
            sortFlag = retData.Key;
            sortParm = retData.Value;
        }
        private void Check_Length()
        {
            KeyValuePair<bool, string> retData = Check_For_Value(drpLength, lengthParm, lengthFlag);
            lengthFlag = retData.Key;
            lengthParm = retData.Value;
        }
        private void Check_Grade()
        {
            KeyValuePair<bool, string> retData = Check_For_Value(drpGrade, gradeParm, gradeFlag);
            gradeFlag = retData.Key;
            gradeParm = retData.Value;
        }
        private void Check_Cert()
        {
            KeyValuePair<bool, string> retData = Check_For_Value(drpCert, certParm, certFlag);
            certFlag = retData.Key;
            certParm = retData.Value;
        }
        private void Check_Thickness()
        {
            KeyValuePair<bool, string> retData = Check_For_Value(drpThickness, thicknessParm, thicknessFlag);
            thicknessFlag = retData.Key;
            thicknessParm = retData.Value;
        }
        private void Check_Dryness()
        {
            KeyValuePair<bool, string> retData = Check_For_Value(drpDryness, drynessParm, drynessFlag);
            drynessFlag = retData.Key;
            drynessParm = retData.Value;
        }
        private void Check_Others()
        {
            KeyValuePair<bool, string> retData = Check_For_Value(drpOthers, othersParm, othersFlag);
            othersFlag = retData.Key;
            othersParm = retData.Value;
        }
        private void Check_Add1()
        {
            KeyValuePair<bool, string> retData = Check_For_Value(drpAdd1, add1Parm, add1Flag);
            add1Flag = retData.Key;
            add1Parm = retData.Value;
        }
        private void Check_Surface()
        {
            KeyValuePair<bool, string> retData = Check_For_Value(drpSurface, surfaceParm, surfaceFlag);
            surfaceFlag = retData.Key;
            surfaceParm = retData.Value;
        }
        private void Check_Owner()
        {
            KeyValuePair<bool, string> retData = Check_For_Value(drpOwner, ownerParm, ownerFlag);
            ownerFlag = retData.Key;
            ownerParm = retData.Value;
        }
        private void Check_Add2()
        {
            KeyValuePair<bool, string> retData = Check_For_Value(drpAdd2, add2Parm, add2Flag);
            add2Flag = retData.Key;
            add2Parm = retData.Value;
        }
        private KeyValuePair<bool, string> Check_For_Value(DropDownList drpList, string propValue, bool changeswitch)
        {
            bool newSwitch;
            string newValue;

            if (drpList.SelectedIndex < 1)
            {
                newSwitch = false;
                newValue = string.Empty;
            }
            else
            {
                if (!string.IsNullOrWhiteSpace(propValue))
                {
                    newSwitch = false;
                    newValue = string.Empty;
                }
                else
                {
                    newSwitch = true;
                    newValue = drpList.SelectedValue;
                }
            }

            return new KeyValuePair<bool, string>(newSwitch, newValue);
        }
        private void Reset_Grid_Page()
        {
            _PgSize = Convert.ToInt32(this.drpPageSize.SelectedValue);

            if (tblMain.Rows.Count == 0)
            {
                if (Session[strSessionVariableName] == null)
                {
                    
                }
                else
                {
                    tblMain = (DataTable)Session[strSessionVariableName];
                }
            }

            this.gvMainData.DataSource = tblMain;
            this.gvMainData.PageIndex = _PgNbr;
            this.gvMainData.PageSize = _PgSize;
            this.gvMainData.AllowPaging = true;
            this.gvMainData.EnableViewState = true;
            this.gvMainData.PagerSettings.FirstPageText = "<<1";
            this.gvMainData.PagerSettings.PreviousPageText = "<";
            this.gvMainData.PagerSettings.LastPageText = ">>";
            this.gvMainData.PagerSettings.NextPageText = ">";
            this.gvMainData.PagerSettings.Mode = PagerButtons.Numeric;
            this.gvMainData.PagerSettings.Position = PagerPosition.TopAndBottom;
            this.gvMainData.PagerSettings.Visible = true;

            ViewState["PgNbr"] = _PgNbr.ToString();
            ViewState["PgSize"] = _PgSize.ToString();

            this.gvMainData.DataBind();
        }
        private void Reset_Attrbute_Selections()
        {
            //drpSpecie.SelectedIndex = 0;
            //drpRework.SelectedIndex = 0;
            //drpWidth.SelectedIndex = 0;
            //drpColor.SelectedIndex = 0;
            //drpSort.SelectedIndex = 0;
            //drpLength.SelectedIndex = 0;
            //drpGrade.SelectedIndex = 0;
            //drpCert.SelectedIndex = 0;
            //drpThickness.SelectedIndex = 0;
            //drpDryness.SelectedIndex = 0;
            //drpOthers.SelectedIndex = 0;
            //drpAdd1.SelectedIndex = 0;
            //drpSurface.SelectedIndex = 0;
            //drpOwner.SelectedIndex = 0;
            //drpAdd2.SelectedIndex = 0;

            drpSpecie.Text = string.Empty;
            drpRework.Text = string.Empty;
            drpWidth.Text = string.Empty;
            drpColor.Text = string.Empty;
            drpSort.Text = string.Empty;
            drpLength.Text = string.Empty;
            drpGrade.Text = string.Empty;
            drpCert.Text = string.Empty;
            drpThickness.Text = string.Empty;
            drpDryness.Text = string.Empty;
            drpOthers.Text = string.Empty;
            //drpAdd1.Text = string.Empty;
            drpSurface.Text = string.Empty;
            //drpOwner.Text = string.Empty;
            //drpAdd2.Text = string.Empty;
        }

        #endregion
    }
}