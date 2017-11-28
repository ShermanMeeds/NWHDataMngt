using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.io;
using iTextSharp.text.html.simpleparser;
using DataLayer;
using DataMngt.MyCode;

namespace DataMngt.page
{
    public partial class SalesPlan : System.Web.UI.Page
    {

        #region Startup_Stuff

        private CurrentUser _user = null;
        private CurrBrowser _Browser = null;
        private string _CBuildNbr = string.Empty;
        private string _BuildNbr = "";
        private int _UserID = 0;
        private int _PgNbr = 0;

        private string holdSelValue = string.Empty;

        // setup my datables here
        protected DataTable tblCurrInven = new DataTable();
        protected DataTable tblProduction = new DataTable();
        protected DataTable tblOpenOrders = new DataTable();
        protected DataTable tblHoldOrders = new DataTable();
        protected DataTable tblOrderHist = new DataTable();
        protected DataTable tblProdHist = new DataTable();

        protected DataTable tblReport = new DataTable();
        protected DataTable tblLocations = new DataTable();
        protected DataTable tblProducts = new DataTable();
        protected DataTable tblRegions = new DataTable();
        protected DataTable tblLocRegions = new DataTable();
        protected DataTable tblSpecies = new DataTable();
        protected DataTable tblThickness = new DataTable();
        protected DataTable tblNoPrint = new DataTable();
        protected DataTable tblGrade = new DataTable();
        protected DataTable tblSort = new DataTable();
        protected DataTable tblColor = new DataTable();

        protected DataRow[] rsltRows;
        protected DataRow[] locRows;
        protected DataRow[] locRegionRows;
        protected DataRow[] regionRows;
        protected DataRow[] specieRows;
        protected DataRow[] thickRows;
        protected DataRow[] gradeRows;
        protected DataRow[] sortRows;
        protected DataRow[] colorRows;
        protected DataRow[] noPrintRows;

        protected DataRow[] custRows;
        protected DataRow[] typeRows;
        protected DataRow[] mgrRows;
        protected DataRow[] prodRows;

        private string strCurrInven = string.Empty;
        private string strProduction = string.Empty;
        private string strOpenOrders = string.Empty;
        private string strHoldOrders = string.Empty;
        private string strOrderHist = string.Empty;
        private string strProdHist = string.Empty;
        private string strReport = string.Empty;
        private string strGrid = string.Empty;
        private string strType = string.Empty;
        private string strMgr = string.Empty;
        private string strCust = string.Empty;
        private string strProd = string.Empty;
        private string strSort = string.Empty;
        private string strNoPrint = string.Empty;
        private string strColor = string.Empty;
        private string strGridCols = string.Empty;
        private string strGridWide = string.Empty;
        private string strColWidths = string.Empty;

        private string strLocations = string.Empty;
        private string strProducts = string.Empty;
        private string strSpecies = string.Empty;
        private string strThickness = string.Empty;
        private string strGrade = string.Empty;
        private string strRegions = string.Empty;

        private string strLocRegions = string.Empty;
        private string strFiltered = string.Empty;

        private string runTimeToken = string.Empty;

        private string strMathCols = string.Empty;

        private Dictionary<string, string> mathCols = new Dictionary<string, string>();
        private Dictionary<string, int> wideCols = new Dictionary<string, int>();
        private Dictionary<int, KeyValuePair<string, int>> mergedWidth = new Dictionary<int, KeyValuePair<string, int>>();
        private Dictionary<string, int> grdColumns = new Dictionary<string, int>();

        private List<SalesPlanData> grdRowData = new List<SalesPlanData>();

        private SalesPlanLevels[] groupLevels = new SalesPlanLevels[0];
        private SalesPlanCounts[] lineTotals = new SalesPlanCounts[0];

        public DataMngtTool DataObj = new DataMngtTool();

        private Settings SetObj = new Settings();

        public string BuildNbr
        {
            get { return _BuildNbr; }
        }

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
					_BuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
            errMsg.Text = string.Empty;

            drpMGD.Enabled = false;
            drpProTypes.Enabled = false;

            string usrname = string.Empty;
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
                Session["NoAccessMsg"] = "You do not have access to the Sales Plan application";
                Response.Redirect("../NoAcc/NoAccess.aspx", true);
            }

            // check for specific rights to sales plan tool
            if (_user.AccessRights < 2 && _user.CatToolRights == 0)
            {
                Session["NoAccessMsg"] = "You do not have access to the Sales Plan Tool.";
                Response.Redirect("../NoAcc/NoAccess.aspx", true);
            }

            _CBuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
            _UserID = Convert.ToInt32(_user.UserID);

            SetObj.UserId = _UserID;

            strCurrInven = string.Concat(_UserID.ToString(), SalesPlanResources.tblCurrInven);
            strProduction = string.Concat(_UserID.ToString(), SalesPlanResources.tblProduction);
            strOpenOrders = string.Concat(_UserID.ToString(), SalesPlanResources.tblOpenOrders);
            strHoldOrders = string.Concat(_UserID.ToString(), SalesPlanResources.tblHoldOrders);
            strOrderHist = string.Concat(_UserID.ToString(), SalesPlanResources.tblOrderHist);
            strProdHist = string.Concat(_UserID.ToString(), SalesPlanResources.tblProdHist);

            strLocations = string.Concat(_UserID.ToString(), SalesPlanResources.tblLocations);
            strProducts = string.Concat(_UserID.ToString(), SalesPlanResources.lstProducts);
            strLocRegions = string.Concat(_UserID.ToString(), SalesPlanResources.tblLocRegions);
            strRegions = string.Concat(_UserID.ToString(), SalesPlanResources.lstRegions);

            strSpecies = string.Concat(_UserID.ToString(), SalesPlanResources.tblSpecies);
            strThickness = string.Concat(_UserID.ToString(), SalesPlanResources.tblThickness);
            strNoPrint = string.Concat(_UserID.ToString(), SalesPlanResources.tblNoPrint);
            strGrade = string.Concat(_UserID.ToString(), SalesPlanResources.tblGrade);
            strColor = string.Concat(_UserID.ToString(), SalesPlanResources.tblColor);
            strSort = string.Concat(_UserID.ToString(), SalesPlanResources.tblSort);

            strType = string.Concat(_UserID.ToString(), SalesPlanResources.strType);
            strCust = string.Concat(_UserID.ToString(), SalesPlanResources.strCust);
            strMgr = string.Concat(_UserID.ToString(), SalesPlanResources.strMgr);
            strProd = string.Concat(_UserID.ToString(), SalesPlanResources.strProd);

            strReport = string.Concat(_UserID.ToString(), SalesPlanResources.tblReport);
            strGrid = string.Concat(_UserID.ToString(), SalesPlanResources.strGrid);
            strFiltered = string.Concat(_UserID.ToString(), SalesPlanResources.tblFiltered);

            strMathCols = string.Concat(_UserID.ToString(), SalesPlanResources.lstMathCols);
            strGridWide = string.Concat(_UserID.ToString(), SalesPlanResources.lstGridWide);
            strColWidths = string.Concat(_UserID.ToString(), SalesPlanResources.lstColWidths);
            strGridCols = string.Concat(_UserID.ToString(), SalesPlanResources.lstGridCols);

            runTimeToken = string.Concat(_UserID.ToString(), SalesPlanResources.TimeStamp);

            if (Session[strGridCols] != null)
            {
                grdColumns = (Dictionary<string, int>)Session[strGridCols];
            }
            else
            {
                CreateGridColumns();
                Session[strGridCols] = grdColumns;
            }

            if (Session[strGridWide] != null)
            {
                wideCols = (Dictionary<string, int>)Session[strGridWide];
            }
            else
            {
                CreateGridColWidths();
                Session[strGridWide] = wideCols;
            }


            if (!this.IsPostBack)
            {
                btnEmailPDF.Enabled = false;
                btnExcelCopy.Enabled = false;
                btnRefreshData.Enabled = false;

                BuildProductTypes();
                chkShowCust.Checked = true;

                Check_For_Settings();

            }
            else
            {
                reset_all_Header_Buttons();
            }

            if (Session[strMathCols] != null)
            {
                mathCols = (Dictionary<string, string>)Session[strMathCols];
            }
            else
            {
                CreateMathColumns(strMathCols);
            }

            if (Session[strGrid] != null)
            {
                grdRowData = (List<SalesPlanData>)Session[strGrid];
                grdData.DataSource = grdRowData;
                grdData.DataBind();
                btnRefreshData.Enabled = true;
                btnExcelCopy.Enabled = true;
                btnEmailPDF.Enabled = true;
            }

            btnAddCol.Enabled = lstColsAvail_HasContents();
            btnDelCol.Enabled = lstColsSort_HasContents();
            btnDownCol.Enabled = lstColsSort_HasContents();
            btnUpCol.Enabled = lstColsSort_HasContents();

            drpProTypes.Enabled = true;
            drpMGD.Enabled = true;
        }

        #endregion


        #region SummarizeData_Functions

        private void SummarizeData()
        {
            Dictionary<string, int> SkipTypes = CreateSkipList();

            SalesPlanCounts availTotals = new SalesPlanCounts();
            SalesPlanLevels[] sparseLevels;

            int resetStart = 0;
            int typeCol = -1;

            bool hasInven = false;

            bool lastWasDetail = false;

            grdRowData = new List<SalesPlanData>();

            // no data from database query so exit
            tblReport = (DataTable)Session[strReport];
            if (tblReport.Rows.Count == 0)
            {
                return;
            }

            tblReport = SortReportTable(lstColsSort);
            Session[strReport] = tblReport;

            reFilterResultsArray();

            rsltRows = (DataRow[])Session[strFiltered];
            // no data after filtering so exit
            if (rsltRows.Length == 0)
            {
                return;
            }

            // builds the report break levels based on the grouping levels set by the user
            CreateGroupingLevels();

            // sheck to see if the type column is a group level
            for (int Idx = 0; Idx < groupLevels.Length; Idx++)
            {
                if (string.Compare(groupLevels[Idx].colName, SalesPlanResources.colTYPE) == 0)
                {
                    typeCol = Idx;
                    break;
                }
            }

            DataRow holdRow = rsltRows[0];
            bool needsRowOut = false;

            // loop thru data rows here 

            // this has some extremely complex logic on the break levels
            // 1) dont break unless the user has selected that column as a break level
            // 2) dont subtotal unless there are more than 1 line in that group
            // 3) no availability row unless there is an inventory line
            // 4) availability lines dont count in the line count for a group
            // 5) if there is a group break do the detail line then determine if there needs to be a higher group break
            // 6) try to remember, avoid hardcoding as much as possible, folks will use this fairly free form so hardcoding will screw you
            // 7) when doing the group break start at the lowest and roll upwards 
            // 8) no subtotals immediately after an availability line

            //*** right now all subtotal lines are turned off **********************************************
            foreach (DataRow rowData in rsltRows)
            {
                needsRowOut = false;
                resetStart = groupLevels.Length;
                
                for (int Idx = 0; Idx < groupLevels.Length; Idx++)
                {
                    if (IsAGroupBreak(Idx, rowData))
                    {
                        needsRowOut = true;
                        resetStart = Idx < resetStart ? Idx : resetStart;
                    }
                }

                if (needsRowOut)
                {
                    createDetailLines(groupLevels.Length - 1, holdRow[SalesPlanResources.colTYPE].ToString());
                    lastWasDetail = true;

                    if (string.Compare(holdRow[SalesPlanResources.colTYPE].ToString(), SalesPlanResources.rowTypeInven) == 0)
                    {
                        hasInven = true;
                    }

                    needsRowOut = false;

                    for (int idx = resetStart; idx < groupLevels.Length; idx++)
                    {
                        groupLevels[idx].linesContained++;
                    }

                    for (int idx = groupLevels.Length - 1; idx >= 0; idx--)
                    {
                        if (IsAGroupBreak(idx, rowData))
                        {
                            if (lstColsSort.Items[idx].Selected == true)
                            {
                                sparseLevels = CopyArrayData(groupLevels);

                                for (int spIdx = idx; spIdx < sparseLevels.Length; spIdx++)
                                {
                                    sparseLevels[spIdx].colDataValue = string.Empty;
                                }

                                string holdValue = groupLevels[idx].colDataValue.ToString();
                                string dataValue = GetColumnObject(rowData, groupLevels[idx].colName).ToString();

                                if (groupLevels[idx].linesContained > 1 ||
                                        string.Compare(holdValue, dataValue) > 0 ||
                                        SkipTypes.ContainsKey(holdValue) ||
                                        SkipTypes.ContainsKey(dataValue))
                                {
                                    if (SkipTypes.ContainsKey(holdValue))
                                    {
                                        if (groupLevels[idx].linesContained > 1)
                                        {
                                            string storeValue = sparseLevels[idx].colDataValue.ToString();
                                            sparseLevels[idx].colDataValue = SalesPlanResources.wordSubTotal;

                                            if (lastWasDetail)
                                            {
                                                createSubTotalLines(idx, string.Empty, sparseLevels);
                                                ResetLineContains(idx, groupLevels);
                                                lastWasDetail = false;
                                            }

                                            sparseLevels[idx].colDataValue = storeValue;
                                        }
                                    }
                                    else
                                    {
                                        if (groupLevels[idx].linesContained > 1)
                                        {
                                            string storeValue = sparseLevels[idx].colDataValue.ToString();
                                            sparseLevels[idx].colDataValue = SalesPlanResources.wordSubTotal;

                                            if (lastWasDetail)
                                            {
                                                createSubTotalLines(idx, string.Empty, sparseLevels);
                                                ResetLineContains(idx, groupLevels);
                                                lastWasDetail = false;
                                            }

                                            sparseLevels[idx].colDataValue = storeValue;
                                        }
                                        
                                        if (RollOverAvailability(availTotals, lineTotals[idx], true, hasInven))
                                        {
                                            CreateAvailGridRow(SalesPlanResources.wordTotal, string.Empty, availTotals, idx, sparseLevels);

                                            ResetLineContains(idx, groupLevels);
                                            lastWasDetail = false;
                                            hasInven = false;
                                            availTotals = new SalesPlanCounts();
                                        }
                                    }
                                }
                            }
                        }

                        object newValue = GetColumnObject(rowData, groupLevels[idx].colName);
                        groupLevels[idx].colDataValue = newValue;

                        if (idx >= resetStart)
                        {
                            ResetLevelCounters(idx);
                        }
                    }
                }

                AccumCounters(rowData, lineTotals, availTotals);
                holdRow = rowData;
            }

            createDetailLines(groupLevels.Length - 1, holdRow[SalesPlanResources.colTYPE].ToString());
            if (groupLevels.Length > 1)
            {
                groupLevels[groupLevels.Length - 2].linesContained++;
            }

            int lvIdx = groupLevels.Length > 0 ? groupLevels.Length - 1 : groupLevels.Length;
            sparseLevels = CopyArrayData(groupLevels);

            for (int spIdx = lvIdx; spIdx < sparseLevels.Length; spIdx++)
            {
                sparseLevels[spIdx].colDataValue = string.Empty;
            }

            if (RollOverAvailability(availTotals, lineTotals[groupLevels.Length - 1], true, hasInven))
            {
                CreateAvailGridRow(SalesPlanResources.wordTotal, string.Empty, availTotals, groupLevels.Length - 1, sparseLevels);
                
                availTotals = new SalesPlanCounts();

                lastWasDetail = false;
                hasInven = false;
            }

            for (int idx = groupLevels.Length - 1; idx >= 0; idx--)
            {
                if (IsAGroupBreak(idx, holdRow))
                {
                    if (idx == 0)
                    {
                        groupLevels[0].linesContained++;
                    }
                    else if (idx < groupLevels.Length - 1)
                    {
                        groupLevels[idx - 1].linesContained++;
                    }

                    if (lstColsSort.Items[idx].Selected == true)
                    {
                        sparseLevels = CopyArrayData(groupLevels);

                        for (int spIdx = idx; spIdx < sparseLevels.Length; spIdx++)
                        {
                            sparseLevels[spIdx].colDataValue = string.Empty;
                        }

                        if (groupLevels[idx].linesContained > 1)
                        {
                            if (RollOverAvailability(availTotals, lineTotals[idx], true, hasInven))
                            {
                                CreateAvailGridRow(SalesPlanResources.wordTotal, string.Empty, availTotals, idx, sparseLevels);

                                ResetLineContains(idx, groupLevels);
                                lastWasDetail = false;
                                hasInven = false;
                                availTotals = new SalesPlanCounts();
                            }
                        }

                        groupLevels[idx].linesContained = 0;
                    }
                }
            }
               
            for (int idx = 0; idx < groupLevels.Length; idx++)
            {
                groupLevels[idx].colDataValue = string.Empty;
            }

            groupLevels[0].colDataValue = SalesPlanResources.wordReport;

            SalesPlanCounts GrandTotals = BuildCurrentTotals();

            CreateGridRow(SalesPlanResources.wordTotal, SalesPlanResources.wordReport, GrandTotals, 0, groupLevels, string.Empty);
        }

        private SalesPlanCounts BuildCurrentTotals()
        {
            SalesPlanCounts TotalCounts = new SalesPlanCounts();

            foreach (SalesPlanData grdRow in grdRowData)
            {
                if (grdRow.rowTotalLvl != groupLevels.Length -1)
                {
                    continue;
                }

                TotalCounts.colINV = TotalCounts.colINV + grdRow.colINV;
                TotalCounts.colPAST = TotalCounts.colPAST + grdRow.colPAST;
                TotalCounts.colTotals = TotalCounts.colTotals + grdRow.colTotals;

                TotalCounts.colP13 = TotalCounts.colP13 + grdRow.colP13;
                TotalCounts.colP8 = TotalCounts.colP8 + grdRow.colP8;
                TotalCounts.colP4 = TotalCounts.colP4 + grdRow.colP4;
                
                TotalCounts.colW00 = TotalCounts.colW00 + grdRow.colW00;
                TotalCounts.colW01 = TotalCounts.colW01 + grdRow.colW01;
                TotalCounts.colW02 = TotalCounts.colW02 + grdRow.colW02;
                TotalCounts.colW03 = TotalCounts.colW03 + grdRow.colW03;
                TotalCounts.colW04 = TotalCounts.colW04 + grdRow.colW04;
                TotalCounts.colW05 = TotalCounts.colW05 + grdRow.colW05;
                TotalCounts.colW06 = TotalCounts.colW06 + grdRow.colW06;
                TotalCounts.colW07 = TotalCounts.colW07 + grdRow.colW07;
                TotalCounts.colW08 = TotalCounts.colW08 + grdRow.colW08;
                TotalCounts.colW09 = TotalCounts.colW09 + grdRow.colW09;
                TotalCounts.colW10 = TotalCounts.colW10 + grdRow.colW10;
                TotalCounts.colW11 = TotalCounts.colW11 + grdRow.colW11;
                TotalCounts.colW12 = TotalCounts.colW12 + grdRow.colW12;
                TotalCounts.colW13 = TotalCounts.colW13 + grdRow.colW13;
            }

            return TotalCounts;
        }

        private void AccumCounters(DataRow rowIn, SalesPlanCounts[] levelTotals, SalesPlanCounts availTotals)
        {
            SalesPlanCounts totRow = ExtractCurrentRowCounts(rowIn);

            if (string.Compare(rowIn[SalesPlanResources.colTYPE].ToString(), SalesPlanResources.typeProdHist) != 0 &&
                string.Compare(rowIn[SalesPlanResources.colTYPE].ToString(), SalesPlanResources.typeSalesHIst) != 0 &&
                string.Compare(rowIn[SalesPlanResources.colTYPE].ToString(), SalesPlanResources.typeHolds) != 0)
            {
                availTotals.colP13 = availTotals.colP13 + totRow.colP13;
                availTotals.colP8 = availTotals.colP8 + totRow.colP8;
                availTotals.colP4 = availTotals.colP4 + totRow.colP4;
                availTotals.colPAST = availTotals.colPAST + totRow.colPAST;
                availTotals.colINV = availTotals.colINV + totRow.colINV;

                availTotals.colTotals = availTotals.colTotals + totRow.colTotals;

                availTotals.colW00 = availTotals.colW00 + totRow.colW00;
                availTotals.colW01 = availTotals.colW01 + totRow.colW01;
                availTotals.colW02 = availTotals.colW02 + totRow.colW02;
                availTotals.colW03 = availTotals.colW03 + totRow.colW03;
                availTotals.colW04 = availTotals.colW04 + totRow.colW04;
                availTotals.colW05 = availTotals.colW05 + totRow.colW05;
                availTotals.colW06 = availTotals.colW06 + totRow.colW06;
                availTotals.colW07 = availTotals.colW07 + totRow.colW07;
                availTotals.colW08 = availTotals.colW08 + totRow.colW08;
                availTotals.colW09 = availTotals.colW09 + totRow.colW09;
                availTotals.colW10 = availTotals.colW10 + totRow.colW10;
                availTotals.colW11 = availTotals.colW11 + totRow.colW11;
                availTotals.colW12 = availTotals.colW12 + totRow.colW12;
                availTotals.colW13 = availTotals.colW13 + totRow.colW13;

            }

            for (int j = 0; j < levelTotals.Length; j++)
            {
                levelTotals[j].colP13 = levelTotals[j].colP13 + totRow.colP13;
                levelTotals[j].colP8 = levelTotals[j].colP8 + totRow.colP8;
                levelTotals[j].colP4 = levelTotals[j].colP4 + totRow.colP4;
                levelTotals[j].colPAST = levelTotals[j].colPAST + totRow.colPAST;
                levelTotals[j].colINV = levelTotals[j].colINV + totRow.colINV;

                levelTotals[j].colTotals = levelTotals[j].colTotals + totRow.colTotals;

                levelTotals[j].colW00 = levelTotals[j].colW00 + totRow.colW00;
                levelTotals[j].colW01 = levelTotals[j].colW01 + totRow.colW01;
                levelTotals[j].colW02 = levelTotals[j].colW02 + totRow.colW02;
                levelTotals[j].colW03 = levelTotals[j].colW03 + totRow.colW03;
                levelTotals[j].colW04 = levelTotals[j].colW04 + totRow.colW04;
                levelTotals[j].colW05 = levelTotals[j].colW05 + totRow.colW05;
                levelTotals[j].colW06 = levelTotals[j].colW06 + totRow.colW06;
                levelTotals[j].colW07 = levelTotals[j].colW07 + totRow.colW07;
                levelTotals[j].colW08 = levelTotals[j].colW08 + totRow.colW08;
                levelTotals[j].colW09 = levelTotals[j].colW09 + totRow.colW09;
                levelTotals[j].colW10 = levelTotals[j].colW10 + totRow.colW10;
                levelTotals[j].colW11 = levelTotals[j].colW11 + totRow.colW11;
                levelTotals[j].colW12 = levelTotals[j].colW12 + totRow.colW12;
                levelTotals[j].colW13 = levelTotals[j].colW13 + totRow.colW13;
                    
                if (!string.IsNullOrWhiteSpace(totRow.DETAIL) || (!string.IsNullOrWhiteSpace(totRow.ORDNUM) && string.Compare(totRow.ORDNUM, SalesPlanResources.Zero) != 0))
                {
                    if (!string.IsNullOrWhiteSpace(totRow.ORDNUM) && string.Compare(totRow.ORDNUM, SalesPlanResources.Zero) != 0)
                    {
                        if (!string.IsNullOrWhiteSpace(levelTotals[j].ORDNUM))
                        {
                            levelTotals[j].ORDNUM = string.Concat(levelTotals[j].ORDNUM, SalesPlanResources.arraySep);
                        }
                        levelTotals[j].ORDNUM = string.Concat(levelTotals[j].ORDNUM, totRow.ORDNUM);
                    }

                    string rowOrdDtl = string.Concat(totRow.ORDNUM, SalesPlanResources.colon, totRow.DETAIL, Environment.NewLine);

                    levelTotals[j].DETAIL = string.Concat(levelTotals[j].DETAIL, rowOrdDtl);
                }
            }
        }

        private SalesPlanLevels[] CopyArrayData(SalesPlanLevels[] inArray)
        {
            int arraySize = inArray.Length;
            List<SalesPlanLevels> outData = new List<SalesPlanLevels>();

            for (int idx = 0; idx < arraySize; idx++)
            {
                SalesPlanLevels levelEntry = new SalesPlanLevels()
                {
                    colName = inArray[idx].colName,
                    colDataType = inArray[idx].colDataType,
                    colDataValue = inArray[idx].colDataValue
                };

                outData.Add(levelEntry);
            }

            return outData.ToArray();
        }

        private SalesPlanCounts ExtractCurrentRowCounts(DataRow CurrentData)
        {
            SalesPlanCounts currentCounts = new SalesPlanCounts();

            currentCounts.ORDNUM = GetColumnObject(CurrentData, SalesPlanResources.colORDNUM).ToString();
            currentCounts.DETAIL = GetColumnObject(CurrentData, SalesPlanResources.colDETAIL).ToString();

            foreach (KeyValuePair<string, string> mathOp in mathCols) 
            {
                string mathCol = mathOp.Key;

                double currNum = GetColumnNumber(CurrentData, mathCol);

                // cant use switch statement with resource strings...wtf??
                if (string.Compare(mathCol, SalesPlanResources.colP13) == 0)
                {
                    currentCounts.colP13 = currNum;
                }

                if (string.Compare(mathCol, SalesPlanResources.colP8) == 0)
                {
                    currentCounts.colP8 = currNum;
                }

                if (string.Compare(mathCol, SalesPlanResources.colP4) == 0)
                {
                    currentCounts.colP4 = currNum;
                }

                if (string.Compare(mathCol, SalesPlanResources.colINV) == 0)
                {
                    currentCounts.colINV = currNum;
                }

                if (string.Compare(mathCol, SalesPlanResources.colPAST) == 0)
                {
                    currentCounts.colPAST = currNum;
                }

                if (string.Compare(mathCol, SalesPlanResources.colTotal) == 0)
                {
                    currentCounts.colTotals = currNum;
                }

                if (string.Compare(mathCol, SalesPlanResources.colW00) == 0)
                {
                    currentCounts.colW00 = currNum;
                }

                if (string.Compare(mathCol, SalesPlanResources.colW01) == 0)
                {
                    currentCounts.colW01 = currNum;
                }

                if (string.Compare(mathCol, SalesPlanResources.colW02) == 0)
                {
                    currentCounts.colW02 = currNum;
                }

                if (string.Compare(mathCol, SalesPlanResources.colW03) == 0)
                {
                    currentCounts.colW03 = currNum;
                }

                if (string.Compare(mathCol, SalesPlanResources.colW04) == 0)
                {
                    currentCounts.colW04 = currNum;
                }

                if (string.Compare(mathCol, SalesPlanResources.colW05) == 0)
                {
                    currentCounts.colW05 = currNum;
                }

                if (string.Compare(mathCol, SalesPlanResources.colW06) == 0)
                {
                    currentCounts.colW06 = currNum;
                }

                if (string.Compare(mathCol, SalesPlanResources.colW07) == 0)
                {
                    currentCounts.colW07 = currNum;
                }

                if (string.Compare(mathCol, SalesPlanResources.colW08) == 0)
                {
                    currentCounts.colW08 = currNum;
                }

                if (string.Compare(mathCol, SalesPlanResources.colW09) == 0)
                {
                    currentCounts.colW09 = currNum;
                }

                if (string.Compare(mathCol, SalesPlanResources.colW10) == 0)
                {
                    currentCounts.colW10 = currNum;
                }

                if (string.Compare(mathCol, SalesPlanResources.colW11) == 0)
                {
                    currentCounts.colW11 = currNum;
                }

                if (string.Compare(mathCol, SalesPlanResources.colW12) == 0)
                {
                    currentCounts.colW12 = currNum;
                }

                if (string.Compare(mathCol, SalesPlanResources.colW13) == 0)
                {
                    currentCounts.colW13 = currNum;
                }
            }

            if (string.Compare(CurrentData[SalesPlanResources.colTYPE].ToString(), SalesPlanResources.rowTypeInven) == 0)
            {
                double carryVal = currentCounts.colW00;

                currentCounts.colW01 = carryVal;
                currentCounts.colW02 = carryVal;
                currentCounts.colW03 = carryVal;
                currentCounts.colW04 = carryVal;
                currentCounts.colW05 = carryVal;
                currentCounts.colW06 = carryVal;
                currentCounts.colW07 = carryVal;
                currentCounts.colW08 = carryVal;
                currentCounts.colW09 = carryVal;
                currentCounts.colW10 = carryVal;
                currentCounts.colW11 = carryVal;
                currentCounts.colW12 = carryVal;
                currentCounts.colW13 = carryVal;
            }

            return currentCounts;
        }

        private void createSubTotalLines(int totalLvl, string totalType, SalesPlanLevels[] TotalLevels)
        {
            CreateGridRow(totalType,
                           groupLevels[totalLvl].colDataValue.ToString(),
                           lineTotals[totalLvl],
                           0,
                           TotalLevels,
                           string.Empty);
        }

        private void createDetailLines(int currLvl, string recGroupingType)
        { 
           CreateGridRow(string.Empty,
                          groupLevels[currLvl].colDataValue.ToString(), 
                          lineTotals[currLvl],
                          groupLevels.Length -1,
                          groupLevels,
                          recGroupingType);
        }

        private void ResetLevelCounters(int currLevel)
        {
            // reset the counters here 
            lineTotals[currLevel].colP13 = 0;
            lineTotals[currLevel].colP8 = 0;
            lineTotals[currLevel].colP4 = 0;
            lineTotals[currLevel].colPAST = 0;
            lineTotals[currLevel].colINV = 0;
            lineTotals[currLevel].colTotals = 0;
            lineTotals[currLevel].colW00 = 0;
            lineTotals[currLevel].colW01 = 0;
            lineTotals[currLevel].colW02 = 0;
            lineTotals[currLevel].colW03 = 0;
            lineTotals[currLevel].colW04 = 0;
            lineTotals[currLevel].colW05 = 0;
            lineTotals[currLevel].colW06 = 0;
            lineTotals[currLevel].colW07 = 0;
            lineTotals[currLevel].colW08 = 0;
            lineTotals[currLevel].colW09 = 0;
            lineTotals[currLevel].colW10 = 0;
            lineTotals[currLevel].colW11 = 0;
            lineTotals[currLevel].colW12 = 0;
            lineTotals[currLevel].colW13 = 0;
            lineTotals[currLevel].ORDNUM = string.Empty;
            lineTotals[currLevel].DETAIL = string.Empty;
            groupLevels[currLevel].linesContained = 0;
        }

        private void CreateGridRow(string RowLabelType, string RowLabel, SalesPlanCounts RowSums, int CurrentLevel, SalesPlanLevels[] GroupLevels, string groupType)
        {
            RowSums.colTotals = RowSums.colW00 + RowSums.colW01 + RowSums.colW02 + RowSums.colW03 + RowSums.colW04 + RowSums.colW05 + RowSums.colW06
                              + RowSums.colW07 + RowSums.colW08 + RowSums.colW09 + RowSums.colW10 + RowSums.colW11 + RowSums.colW12 + RowSums.colW13;
            
            SalesPlanData sumRow = new SalesPlanData();

            int colNum = 0;
            int colTot = -1;
            int colP13 = -1;
            int colP8 = -1;
            int colP4 = -1;

            string rowType = groupType;
            
            foreach (KeyValuePair<string, int> grdCol in grdColumns)
            {
                colNum = grdCol.Value;
                
                // this allows the grouping columns portiomn of the grid to grow as big as necessary without any changes needed
                if (colNum < GroupLevels.Length)
                {
                    sumRow.idx = colNum;
                    sumRow.colTextValues = string.Concat(GroupLevels[colNum].colDataValue.ToString(), CurrentLevel == colNum ? RowLabelType : string.Empty);
                }
                else
                {
                    string mathVals = string.Empty;
                    double mathNum = 0;
                    sumRow.idx = colNum;
                    mathVals = ReturnSummedColumn(RowSums, grdCol.Key);

                    if (double.TryParse(mathVals, out mathNum))
                    {
                        sumRow.colTextValues = Math.Round(mathNum, 0).ToString();
                    }
                    else
                    {
                        sumRow.colTextValues = SalesPlanResources.Zero;
                    }
                }
                
                if (string.Compare(grdCol.Key, SalesPlanResources.colTotal) == 0)
                {
                    colTot = grdCol.Value;
                }
                if (string.Compare(grdCol.Key, SalesPlanResources.colP13) == 0)
                {
                    colP13 = grdCol.Value;
                }
                if (string.Compare(grdCol.Key, SalesPlanResources.colP8) == 0)
                {
                    colP8 = grdCol.Value;
                }
                if (string.Compare(grdCol.Key, SalesPlanResources.colP4) == 0)
                {
                    colP4 = grdCol.Value;
                }

            }
            
            sumRow.rowTotalLvl = CurrentLevel; 

            sumRow.DETAIL = RowSums.DETAIL;
            sumRow.ORDNUM = RowSums.ORDNUM;

            sumRow.colPAST = RowSums.colPAST;
            sumRow.colINV = RowSums.colINV;

            // inventory lines dont have Total or past columns
            if (string.Compare(rowType, SalesPlanResources.rowTypeInven) != 0)
            {
                sumRow.colTotals = RowSums.colTotals;
                sumRow.colP13 = RowSums.colP13;
                sumRow.colP8 = RowSums.colP8;
                sumRow.colP4 = RowSums.colP4;
            }
            else
            {
                sumRow.idx = colTot;
                sumRow.colTextValues = string.Empty;

                sumRow.idx = colP13;
                sumRow.colTextValues = string.Empty;

                sumRow.idx = colP8;
                sumRow.colTextValues = string.Empty;

                sumRow.idx = colP4;
                sumRow.colTextValues = string.Empty;
            }

            sumRow.colW00 = RowSums.colW00;
            sumRow.colW01 = RowSums.colW01;
            sumRow.colW02 = RowSums.colW02;
            sumRow.colW03 = RowSums.colW03;
            sumRow.colW04 = RowSums.colW04;
            sumRow.colW05 = RowSums.colW05;
            sumRow.colW06 = RowSums.colW06;
            sumRow.colW07 = RowSums.colW07;
            sumRow.colW08 = RowSums.colW08;
            sumRow.colW09 = RowSums.colW09;
            sumRow.colW10 = RowSums.colW10;
            sumRow.colW11 = RowSums.colW11;
            sumRow.colW12 = RowSums.colW12;
            sumRow.colW13 = RowSums.colW13;

            grdRowData.Add(sumRow);
        }

        private void CreateAvailGridRow(string RowLabelType, string RowLabel, SalesPlanCounts RowSums, int CurrentLevel, SalesPlanLevels[] GroupLevels)
        {

            SalesPlanData sumRow = new SalesPlanData();

            int colNum = 0;

            RowSums.colTotals = 0;

            // this allows the grouping columns portiomn of the grid to grow as big as necessary without any changes needed
            foreach (KeyValuePair<string, int> grdCol in grdColumns)
            {
                colNum = grdCol.Value;

                if (colNum < GroupLevels.Length)
                {
                    sumRow.idx = colNum;
                    sumRow.colTextValues = string.Concat(GroupLevels[colNum].colDataValue.ToString(), CurrentLevel == colNum ? RowLabelType : string.Empty);
                }
                else
                {
                    sumRow.idx = colNum;
                    if (string.Compare(grdCol.Key, SalesPlanResources.colTotal) == 0)
                    {
                        continue;
                    }

                    string mathVals = string.Empty;
                    double mathNum = 0;
                    sumRow.idx = colNum;
                    mathVals = ReturnSummedColumn(RowSums, grdCol.Key);

                    if (double.TryParse(mathVals, out mathNum))
                    {
                        sumRow.colTextValues = Math.Round(mathNum, 0).ToString();
                    }
                    else
                    {
                        sumRow.colTextValues = SalesPlanResources.Zero;
                    }
                }

            }

            sumRow.rowTotalLvl = 0;

            sumRow.DETAIL = RowSums.DETAIL;
            sumRow.ORDNUM = RowSums.ORDNUM;

            sumRow.colP13 = RowSums.colP13;
            sumRow.colP8 = RowSums.colP8;
            sumRow.colP4 = RowSums.colP4;
            sumRow.colPAST = RowSums.colPAST;
            sumRow.colINV = RowSums.colINV;
            sumRow.colW00 = RowSums.colW00;
            sumRow.colW01 = RowSums.colW01;
            sumRow.colW02 = RowSums.colW02;
            sumRow.colW03 = RowSums.colW03;
            sumRow.colW04 = RowSums.colW04;
            sumRow.colW05 = RowSums.colW05;
            sumRow.colW06 = RowSums.colW06;
            sumRow.colW07 = RowSums.colW07;
            sumRow.colW08 = RowSums.colW08;
            sumRow.colW09 = RowSums.colW09;
            sumRow.colW10 = RowSums.colW10;
            sumRow.colW11 = RowSums.colW11;
            sumRow.colW12 = RowSums.colW12;
            sumRow.colW13 = RowSums.colW13;

            grdRowData.Add(sumRow);
        }

        #endregion


        #region SummarizeData_AccessoryFunctions

        private void ResetLineContains(int currLevel, SalesPlanLevels[] BreakLevels)
        {
            int startAt = currLevel;

            for (int idx = startAt; idx < BreakLevels.Length; idx++)
            {
                BreakLevels[idx].linesContained = 0;
            }
        }

        private Dictionary<string, int> CreateSkipList()
        {
            Dictionary<string, int> SkipTypes = new Dictionary<string, int>();
            SkipTypes.Add(SalesPlanResources.rowTypeOrdHist, 1);
            SkipTypes.Add(SalesPlanResources.rowTypeOrdHolds, 1);
            SkipTypes.Add(SalesPlanResources.rowTypeProdHist, 1);

            return SkipTypes;
        }

        private bool RollOverAvailability(SalesPlanCounts availCounts, SalesPlanCounts groupingCounts, bool isLocal, bool hasInventoryLine)
        {
            int TypeCol = -1;

            for (int colIdx = 0; colIdx < lstColsSort.Items.Count; colIdx++)
            {
                if (string.Compare(lstColsSort.Items[colIdx].Text, SalesPlanResources.colTYPE) == 0 )
                {
                    TypeCol = colIdx;
                    break;
                }
            }

            if (TypeCol < 0)
            {
                // could not find the record type column
                return false;
            }

            if (isLocal && !hasInventoryLine)
            {
                return false;
            }

            int rolIdx = FindRollUpRow(TypeCol, SalesPlanResources.rowTypeInven, isLocal, isLocal == true ? grdRowData.Count : 0);
            
            // no records to roll up so quit 
            if (rolIdx < 0)
            {
                return false;
            }

            // current found row is inventory row so no available line
            if (rolIdx == grdRowData.Count - 1)
            {
                return false;
            }

            // get a list of the weekly columns and their locations within the screen array
            mergedWidth = (Dictionary<int, KeyValuePair<string, int>>)Session[strColWidths];
            SortedDictionary<string, int> colPlace = new SortedDictionary<string, int>();
            int TotaColLoc = 0;

            SalesPlanData invenRow = grdRowData[rolIdx];

            for (int colIdx = 0; colIdx < mergedWidth.Count; colIdx++)
            {
                KeyValuePair<string, int> colDef = new KeyValuePair<string, int>();

                if (!mergedWidth.TryGetValue(colIdx, out colDef))
                {
                    continue;
                }

                string colname = colDef.Key;

                if (string.Compare(colname, SalesPlanResources.colTotal) == 0)
                {
                    TotaColLoc = colIdx;
                    continue;
                }
                    if (string.Compare(colname.Substring(0,1), SalesPlanResources.letterW) != 0)
                {
                    continue;
                }

                colPlace.Add(colname, colIdx);
            }

            double currInvNumber = 0;
            double prevWeekNumber = 0;
            double currAvailNumber = 0;

            foreach (KeyValuePair<string, int> calcCol in colPlace)
            {
                string colName = calcCol.Key;

                if (string.Compare(colName, SalesPlanResources.colW00) == 0)
                {
                    prevWeekNumber = SumNewTotals(rolIdx - 1, colName);
                    availCounts.ptr = colName;
                    availCounts.coldoubleValues = prevWeekNumber;
                    continue;
                }

                int colIdx = calcCol.Value;
                availCounts.ptr = colName;
                invenRow.ptr = colName;

                // gets current weeks numbers
                if (isLocal)
                {
                    invenRow.idx = colIdx;
                    
                    // carries last weeks availability into current weeks inventory
                    invenRow.coldoubleValues = prevWeekNumber;
                    invenRow.colTextValues = ((int)Math.Round(prevWeekNumber, 0)).ToString();
                }

                // adjusts current weeks availability
                currInvNumber = invenRow.coldoubleValues;
                currAvailNumber = SumNewTotals(rolIdx, colName);
                availCounts.coldoubleValues = currAvailNumber + currInvNumber;
                prevWeekNumber = availCounts.coldoubleValues;
            }

            if (isLocal)
            {
                grdRowData.RemoveAt(rolIdx);
                grdRowData.Insert(rolIdx, invenRow);
            }

            return true;
        }

        private double SumNewTotals(int StartRow, string colName)
        {
            double accumVals = 0;
            int typeCol = -1;
            mergedWidth = (Dictionary<int, KeyValuePair<string, int>>)Session[strColWidths];

            Dictionary<string, int> SkipTypes = CreateSkipList();

            for (int idx = 0; idx < mergedWidth.Count; idx++)
            {
                KeyValuePair<string, int> gridCol = new KeyValuePair<string, int>();

                if (!mergedWidth.TryGetValue(idx, out gridCol))
                {
                    continue;
                }
                if (string.Compare(gridCol.Key, SalesPlanResources.colTYPE) == 0)
                {
                    typeCol = idx;
                    break;
                }
            }

            for (int rowIdx = (StartRow + 1); rowIdx < grdRowData.Count; rowIdx++)
            {
                SalesPlanData Counts = grdRowData[rowIdx];

                if (Counts.rowTotalLvl != groupLevels.Length -1 )
                {
                    continue;
                }

                if (typeCol >=0)
                {
                    Counts.idx = typeCol;

                    if (!SkipTypes.ContainsKey(Counts.colTextValues))
                    {
                        Counts.ptr = colName;
                        accumVals = accumVals + Counts.coldoubleValues;
                    }
                }
            }

            return accumVals;
        }
        
        private int FindRollUpRow(int colNum, string ColWord, bool reverseSearch, int StartRow)
        {
            int loc = -1;

            if (reverseSearch)
            {
                for (int idx = StartRow - 1; idx >= 0; idx--)
                {
                    SalesPlanData grdRow = grdRowData[idx];

                    grdRow.idx = colNum;
                    string rowType = grdRow.colTextValues.Trim();

                    if (string.Compare(rowType, ColWord) == 0)
                    {
                        loc = idx;
                        break;
                    }
                }
            }
            else
            {
                for (int idx = StartRow; idx < grdRowData.Count; idx++)
                {
                    SalesPlanData grdRow = grdRowData[idx];

                    grdRow.idx = colNum;
                    string rowType = grdRow.colTextValues.Trim();

                    if (string.Compare(rowType, ColWord) == 0)
                    {
                        loc = idx;
                        break;
                    }
                }
            }

            return loc;
        }

        private string ReturnSummedColumn(SalesPlanCounts Sums, string colName)
        {
            if (string.Compare(colName, SalesPlanResources.colP13) == 0)
            {
                return Sums.colP13.ToString();
            }

            if (string.Compare(colName, SalesPlanResources.colP8) == 0)
            {
                return Sums.colP8.ToString();
            }

            if (string.Compare(colName, SalesPlanResources.colP4) == 0)
            {
                return Sums.colP4.ToString();
            }

            if (string.Compare(colName, SalesPlanResources.colPAST) == 0)
            {
                return Sums.colPAST.ToString();
            }

            if (string.Compare(colName, SalesPlanResources.colINV) == 0)
            {
                return Sums.colINV.ToString();
            }
            
            if (string.Compare(colName, SalesPlanResources.colTotal) == 0)
            {
                return Sums.colTotals.ToString();
            }

            if (string.Compare(colName, SalesPlanResources.colW00) == 0)
            {
                return Sums.colW00.ToString();
            }

            if (string.Compare(colName, SalesPlanResources.colW01) == 0)
            {
                return Sums.colW01.ToString();
            }

            if (string.Compare(colName, SalesPlanResources.colW02) == 0)
            {
                return Sums.colW02.ToString();
            }

            if (string.Compare(colName, SalesPlanResources.colW03) == 0)
            {
                return Sums.colW03.ToString();
            }

            if (string.Compare(colName, SalesPlanResources.colW04) == 0)
            {
                return Sums.colW04.ToString();
            }

            if (string.Compare(colName, SalesPlanResources.colW05) == 0)
            {
                return Sums.colW05.ToString();
            }

            if (string.Compare(colName, SalesPlanResources.colW06) == 0)
            {
                return Sums.colW06.ToString();
            }

            if (string.Compare(colName, SalesPlanResources.colW07) == 0)
            {
                return Sums.colW07.ToString();
            }

            if (string.Compare(colName, SalesPlanResources.colW08) == 0)
            {
                return Sums.colW08.ToString();
            }

            if (string.Compare(colName, SalesPlanResources.colW09) == 0)
            {
                return Sums.colW09.ToString();
            }

            if (string.Compare(colName, SalesPlanResources.colW10) == 0)
            {
                return Sums.colW10.ToString();
            }

            if (string.Compare(colName, SalesPlanResources.colW11) == 0)
            {
                return Sums.colW11.ToString();
            }

            if (string.Compare(colName, SalesPlanResources.colW12) == 0)
            {
                return Sums.colW12.ToString();
            }

            if (string.Compare(colName, SalesPlanResources.colW13) == 0)
            {
                return Sums.colW13.ToString();
            }

            if (string.Compare(colName, SalesPlanResources.colDETAIL) == 0)
            {
                return Sums.DETAIL.ToString();
            }

            if (string.Compare(colName, SalesPlanResources.colORDNUM) == 0)
            {
                return Sums.ORDNUM.ToString();
            }

            return string.Empty;
        }
        
        private bool IsAGroupBreak(int salesIndexLevel, DataRow currentData)
        {
            string strColName = groupLevels[salesIndexLevel].colName;

            object objColValue = groupLevels[salesIndexLevel].colDataValue.ToString().Trim();
            object grdObjVal = GetColumnObject(currentData, strColName).ToString().Trim();
            
            // if the grouping column is a string
            if (groupLevels[salesIndexLevel].colDataType == typeof(string))
            {
                // not equal so flag as not matched
                if (string.Compare(objColValue.ToString(), grdObjVal.ToString()) != 0)
                {
                    return true;
                }
                // matched
                return false;
            }

            // the group column is a double so parse the values
            double holdVal = 0;
            double grdVal = 0;

            double.TryParse(objColValue.ToString(), out holdVal);
            double.TryParse(grdObjVal.ToString(), out grdVal);

            // not equal so flag as not matched
            if (holdVal != grdVal)
            {
                return true;
            }
            // flag as equal 
            return false;
        }

        private object GetColumnObject(DataRow rowData, string columnName)
        {
            try
            {
                return (object)rowData[columnName];
            }
            catch
            {
                return null;
            }
        }

        private double GetColumnNumber(DataRow rowData, string columnName)
        {
            double num = 0;

            try
            {
                if (!double.TryParse(rowData[columnName].ToString(), out num))
                {
                    return 0;
                }

                return num;
            }
            catch (Exception e)
            {
                return 0;
            }
        }

        private void CreateGroupingLevels()
        {
            int Levels = 0;

            // if no sort columns then exit
            if (lstColsSort.Items.Count == 0)
            {
                return;
            }

            Levels = lstColsSort.Items.Count;
            
            groupLevels = new SalesPlanLevels[Levels];
            lineTotals = new SalesPlanCounts[Levels];

            if (rsltRows.Length == 0)
            {
                return;
            }

            DataRow firstRow = rsltRows[0];
            int Out = 0;

            // builds the subtotal levels 
            for (int idx = 0; idx < lstColsSort.Items.Count; idx++)
            {
                System.Web.UI.WebControls.ListItem sortItem = lstColsSort.Items[idx];

                string colId = sortItem.Value.ToString();

                SalesPlanLevels grpLevel = new SalesPlanLevels();

                grpLevel.colName = colId;
                Type datType = tblReport.Columns[colId].DataType;

                grpLevel.colDataType = datType;

                object datVal = firstRow[colId];

                grpLevel.colDataValue = datVal;

                SalesPlanCounts subTotals = new SalesPlanCounts();

                subTotals.colP13 = 0;
                subTotals.colP8 = 0;
                subTotals.colP4 = 0;
                subTotals.colPAST = 0;
                subTotals.colINV = 0;
                subTotals.colTotals = 0;
                subTotals.colW00 = 0;
                subTotals.colW01 = 0;
                subTotals.colW02 = 0;
                subTotals.colW03 = 0;
                subTotals.colW04 = 0;
                subTotals.colW05 = 0;
                subTotals.colW06 = 0;
                subTotals.colW07 = 0;
                subTotals.colW08 = 0;
                subTotals.colW09 = 0;
                subTotals.colW10 = 0;
                subTotals.colW11 = 0;
                subTotals.colW12 = 0;
                subTotals.colW13 = 0;

                subTotals.DETAIL = string.Empty;
                subTotals.ORDNUM = string.Empty;

                groupLevels[Out] = grpLevel;
                lineTotals[Out] = subTotals;

                Out++;
            }
        }

        #endregion


        #region User_Settings_Maintenance
        // there are list boxes that i dont include in this for a reason, 
        // they are dependant upon the data pull so they cant be set until AFTER
        // the data has been loaded from database. easier to just skip for now.

        private void Check_For_Settings()
        {
            if (!SetObj.CheckForSettings(_UserID))
            {
                return;
            }

            btnRefreshData.Enabled = false;

            SetObj.SetTheControl((RadioButton)optSales, "optSales");
            SetObj.SetTheControl((RadioButton)optProduction, "optProduction");
            SetObj.SetTheControl((RadioButton)optEither, "optEither");

            SetObj.SetTheControl((CheckBox)chkShowCust, "chkShowCust");
            SetObj.SetTheControl((CheckBox)chkHolds, "chkHolds");
            SetObj.SetTheControl((CheckBox)chkHist, "chkHist");

            SetObj.SetTheControl((DropDownList)ddlPageSize, "ddlPageSize", false);
            SetObj.SetTheControl((DropDownList)drpMGD, "drpMGD", false);

            SetObj.SetTheControl((DropDownList)drpProTypes, "drpProTypes", false);
            drpProTypes_SelectedIndexChanged(new object(), new EventArgs());

            SetObj.SetTheControl((CheckBoxList)lstRegionChk, "lstRegionChk", false);
            lstRegionChk_SelectedIndexChanged(new object(), new EventArgs());

            SetObj.SetTheControl((CheckBoxList)lstLocChk, "lstLocChk", false);
            lstLocChk_SelectedIndexChanged(new object(), new EventArgs());
            
            SetObj.SetTheControl((CheckBoxList)lstSpeciesChk, "lstSpeciesChk", false);
            lstSpeciesChk_SelectedIndexChanged(new object(), new EventArgs());

            SetObj.SetTheControl((CheckBoxList)lstThickChk, "lstThickChk", false);
            SetObj.SetTheControl((CheckBoxList)lstGradeChk, "lstGradeChk", false);
            SetObj.SetTheControl((CheckBoxList)lstSortChk, "lstSortChk", false);
            SetObj.SetTheControl((CheckBoxList)lstNoPrintChk, "lstNoPrintChk", false);
            
            SetObj.SetTheControl((ListBox)lstColsAvail, "lstColsAvail", true);
            SetObj.SetTheControl((CheckBoxList)lstColsSort, "lstColsSort", true);

            ReloadGridColumns();
            ReloadGridColumnWidths();

            btnRefreshData.Enabled = true;
        }

        private void Save_All_User_Controls()
        {
            SetObj.SaveTheControl((RadioButton)optSales, "optSales");
            SetObj.SaveTheControl((RadioButton)optProduction, "optProduction");
            SetObj.SaveTheControl((RadioButton)optEither, "optEither");

            SetObj.SaveTheControl((CheckBox)chkShowCust, "chkShowCust");
            SetObj.SaveTheControl((CheckBox)chkHolds, "chkHolds");
            SetObj.SaveTheControl((CheckBox)chkHist, "chkHist");

            SetObj.SaveTheControl((DropDownList)ddlPageSize, "ddlPageSize");
            SetObj.SaveTheControl((DropDownList)drpMGD, "drpMGD");
            SetObj.SaveTheControl((DropDownList)drpProTypes, "drpProTypes");

            SetObj.SaveTheControl((CheckBoxList)lstRegionChk, "lstRegionChk");
            SetObj.SaveTheControl((CheckBoxList)lstLocChk, "lstLocChk");

            SetObj.SaveTheControl((CheckBoxList)lstSpeciesChk, "lstSpeciesChk");
            SetObj.SaveTheControl((CheckBoxList)lstThickChk, "lstThickChk");
            SetObj.SaveTheControl((CheckBoxList)lstGradeChk, "lstGradeChk");
            SetObj.SaveTheControl((CheckBoxList)lstSortChk, "lstSortChk");
            SetObj.SaveTheControl((CheckBoxList)lstNoPrintChk, "lstNoPrintChk");

            SetObj.SaveTheControl((ListBox)lstColsAvail, "lstColsAvail");
            SetObj.SaveTheControl((CheckBoxList)lstColsSort, "lstColsSort");

            SetObj.SaveAllSettings();
        }

        #endregion


        #region Button_Screen_Events

        protected void btnSaveSettings_Click(object sender, EventArgs e)
        {
            Save_All_User_Controls();
        }

        protected void btnEmailPDF_Click(object sender, EventArgs e)
        {
            this.errMsg.Text = string.Empty;
            if (!ExportToPdf())
            {
                this.errMsg.Text = SalesPlanResources.pdfError;
            }
        }

        protected void btnExcelCopy_Click(object sender, EventArgs e)
        {
            this.errMsg.Text = string.Empty;

            if (!ExportToExcel())
            {
                this.errMsg.Text = SalesPlanResources.excelError;
            }
        }

        protected void btnLoc_Click(object sender, EventArgs e)
        {
            CheckListReset(lstLocChk, btnLoc);
            if (string.Compare(btnLoc.ToolTip.ToString(), SalesPlanResources.btnTextSelectAll) == 0)
            {
                lstLocChk.Items.Clear();
                
                FilterLocationList();
                BindTableBasedPickList(lstLocChk, locRows, SalesPlanResources.colCode, SalesPlanResources.colDesc, false);

                CleanUpAfterFilterReset();
            }
        }
        
        protected void btnSpecie_Click(object sender, EventArgs e)
        {
            CheckListReset(lstSpeciesChk, btnSpecie);
            if (string.Compare(btnSpecie.ToolTip.ToString(), SalesPlanResources.btnTextSelectAll) == 0)
            {
                lstSpeciesChk.Items.Clear();

                FilterSpecieList();
                BindTableBasedPickList(lstSpeciesChk, specieRows, SalesPlanResources.colspecie, false);

                CleanUpAfterFilterReset();
            }
        }

        protected void btnThickness_Click(object sender, EventArgs e)
        {
            CheckListReset(lstThickChk, btnThick);
            if (string.Compare(btnThick.ToolTip.ToString(), SalesPlanResources.btnTextSelectAll) == 0)
            {
                lstThickChk.Items.Clear();

                FilterThickList();
                BindTableBasedPickList(lstThickChk, thickRows, SalesPlanResources.colthick, false);

                CleanUpAfterFilterReset();
            }
        }

        protected void btnGrade_Click(object sender, EventArgs e)
        {
            CheckListReset(lstGradeChk, btnGrade);
            if (string.Compare(btnGrade.ToolTip.ToString(), SalesPlanResources.btnTextSelectAll) == 0)
            {
                lstGradeChk.Items.Clear();

                FilterGradeList();
                BindTableBasedPickList(lstGradeChk, gradeRows, SalesPlanResources.colgrade, false);

                CleanUpAfterFilterReset();
            }
        }

        protected void btnNoPrint_Click(object sender, EventArgs e)
        {
            CheckListReset(lstNoPrintChk, btnNoPrint);
            if (string.Compare(btnNoPrint.ToolTip.ToString(), SalesPlanResources.btnTextSelectAll) == 0)
            {
                lstNoPrintChk.Items.Clear();

                FilterNoPrintList();
                BindTableBasedPickList(lstNoPrintChk, noPrintRows, SalesPlanResources.colNoPrint, true);

                CleanUpAfterFilterReset();
            }
        }

        protected void btnType_Click(object sender, EventArgs e)
        {
            CheckListReset(lstTypeChk, btnType);
            if (string.Compare(btnType.ToolTip.ToString(), SalesPlanResources.btnTextSelectAll) == 0)
            {
                lstTypeChk.Items.Clear();

                reFilterResultsArray();
                if (rsltRows != null && rsltRows.Length > 0)
                {
                    FilterTypeList();
                    BindTableBasedPickList(lstTypeChk, typeRows, SalesPlanResources.colTYPE, false);
                }
            }

            reset_all_Header_Buttons();
        }

        protected void btnProd_Click(object sender, EventArgs e)
        {
            CheckListReset(lstProdChk, btnProd);
            if (string.Compare(btnProd.ToolTip.ToString(), SalesPlanResources.btnTextSelectAll) == 0)
            {
                lstProdChk.Items.Clear();

                reFilterResultsArray();
                if (rsltRows != null && rsltRows.Length > 0)
                {
                    FilterProductList();
                    BindTableBasedPickList(lstProdChk, prodRows, SalesPlanResources.colCode, SalesPlanResources.colDesc, false);
                }
            }

            reset_all_Header_Buttons();
        }

        protected void btnCust_Click(object sender, EventArgs e)
        {
            if (chkShowCust.Checked == false)
            {
                lstCustChk.Enabled = false;
                btnCust.Enabled = false;
                return;
            }

            CheckListReset(lstCustChk, btnCust);
            if (string.Compare(btnCust.ToolTip.ToString(), SalesPlanResources.btnTextSelectAll) == 0)
            {
                lstCustChk.Items.Clear();

                reFilterResultsArray();
                if (rsltRows != null && rsltRows.Length > 0)
                {
                    FilterCustList();
                    BindTableBasedPickList(lstCustChk, custRows, SalesPlanResources.colCUSTOMER, false);
                }

                reset_all_Header_Buttons();
            }
        }
        
        protected void btnMgr_Click(object sender, EventArgs e)
        {
            if (chkShowCust.Checked == false)
            {
                lstMgrChk.Enabled = false;
                btnMgr.Enabled = false;
                return;
            }

            CheckListReset(lstMgrChk, btnMgr);
            if (string.Compare(btnMgr.ToolTip.ToString(), SalesPlanResources.btnTextSelectAll) == 0)
            {
                lstMgrChk.Items.Clear();
                reFilterResultsArray();
                if (rsltRows != null && rsltRows.Length > 0)
                {
                    FilterMgrList();
                    BindTableBasedPickList(lstMgrChk, mgrRows, SalesPlanResources.colMGR, false);

                    FilterCustList();
                    BindTableBasedPickList(lstCustChk, custRows, SalesPlanResources.colCUSTOMER, false);
                }

                reset_all_Header_Buttons();
            }
        }

        protected void btnSort_Click(object sender, EventArgs e)
        {
            CheckListReset(lstSortChk, btnSort);
            if (string.Compare(btnSort.ToolTip.ToString(), SalesPlanResources.btnTextSelectAll) == 0)
            {
                lstSortChk.Items.Clear();

                FilterSortList();
                BindTableBasedPickList(lstSortChk, sortRows, SalesPlanResources.colSort, true);

                CleanUpAfterFilterReset();
            }
        }

        protected void btnColor_Click(object sender, EventArgs e)
        {
            CheckListReset(lstColorChk, btnColor);
            if (string.Compare(btnColor.ToolTip.ToString(), SalesPlanResources.btnTextSelectAll) == 0)
            {
                lstColorChk.Items.Clear();

                FilterColorList();
                BindTableBasedPickList(lstColorChk, colorRows, SalesPlanResources.colColor, true);

                CleanUpAfterFilterReset();
            }
        }

        protected void btnAddCol_Click(object sender, EventArgs e)
        {
            errMsg.Text = string.Empty;

            if (!lstColsAvail_Selected())
            {
                errMsg.Text = SalesPlanResources.errSelectColAvail;
                return;
            }

            lstColsSort_AddItem(lstColsAvail_SubstractItem());
        }

        protected void btnDelCol_Click(object sender, EventArgs e)
        {
            errMsg.Text = string.Empty;

            if (!lstColsSort_Selected())
            {
                errMsg.Text = SalesPlanResources.errSelectColSort;
                return;
            }

            lstColsAvail_AddItem(lstColsSort_SubstractItem());
        }

        protected void btnUpCol_Click(object sender, EventArgs e)
        {
            errMsg.Text = string.Empty;

            if (!lstColsSort_Selected())
            {
                errMsg.Text = SalesPlanResources.errSelectColToReorder;
                return;
            }

            if (!lstColsSort_HasContents())
            {
                errMsg.Text = SalesPlanResources.errNothingToMove;
                return;
            }

            if (!MoveItem(-1))
            {
                errMsg.Text = SalesPlanResources.errCantMoveUp;
            }
        }

        protected void btnDownCol_Click(object sender, EventArgs e)
        {
            errMsg.Text = string.Empty;

            if (!lstColsSort_Selected())
            {
                errMsg.Text = SalesPlanResources.errSelectColToReorder;
                return;
            }

            if (!lstColsSort_HasContents())
            {
                errMsg.Text = SalesPlanResources.errNothingToMove;
                return;
            }

            if (!MoveItem(1))
            {
                errMsg.Text = SalesPlanResources.errCantMoveDown;
            }
        }

        protected void btnRefreshData_Click(object sender, EventArgs e)
        {
            btnRefreshData.Enabled = false;
            int TimeSpanInMinutes = 0;

            int.TryParse(SalesPlanResources.TimeSpan, out TimeSpanInMinutes);

            bool runSwitch = false;

            // if the runtime token doesnt exist then assume the screen hasnt been filled yet
            // or the user changed a switch setting that will affect the query so MUST go back to the database
            if (Session[runTimeToken] == null)
            {
                runSwitch = true;
            }
            else
            {
                // get last time the screen was filled and parse it
                // if there is an error go ahead and refresh 
                string lastRunAt = Session[runTimeToken].ToString();
                DateTime LastRun;
                if (!DateTime.TryParse(lastRunAt, out LastRun))
                {
                    runSwitch = true;
                }
                else
                {
                    // if the difference in minutes between now and the last refresh time is > or = 15 minutes
                    // then refresh the grid
                    TimeSpan SinceLastRun = DateTime.Now.Subtract(LastRun);
                    if (SinceLastRun.TotalMinutes >= TimeSpanInMinutes)
                    {
                        runSwitch = true;
                    }
                }
            }

            // the switch is set then refresh from the database otherwise pull from the cached rows 
            if (runSwitch)
            {
                loadtables();

                string newRunTime = DateTime.Now.ToString(SalesPlanResources.DateFormat);
                Session[runTimeToken] = newRunTime;

                Session[strReport] = tblReport;
            }
            else
            {
                tblReport = (DataTable)Session[strReport];
            }

            // refresh the screen grid columns and widths
            ReloadGridColumns();
            ReloadGridColumnWidths();

            // summarize the data 
            SummarizeData();
                    
            // now setup the screen filters that are db pull dependant
            FilterTypeList();
            BindTableBasedPickList(lstTypeChk, typeRows, SalesPlanResources.colTYPE, false);

            FilterMgrList();
            BindTableBasedPickList(lstMgrChk, mgrRows, SalesPlanResources.colMGR, false);

            FilterCustList();
            BindTableBasedPickList(lstCustChk, custRows, SalesPlanResources.colCUSTOMER, false);

            FilterProductList();
            BindTableBasedPickList(lstProdChk, prodRows, SalesPlanResources.colCode, SalesPlanResources.colDesc, false);

            reset_all_Header_Buttons();

            grdData.DataSource = null;

            mergedWidth = (Dictionary<int, KeyValuePair<string, int>>)Session[strColWidths];

            Session[strGrid] = grdRowData;
            grdData.DataSource = grdRowData;
            grdData.DataBind();

            foreach (GridViewRow viewRow in grdData.Rows)
            {
                for (int i = 0; i < grdData.Columns.Count; i++)
                {
                    KeyValuePair<string, int> colDef = new KeyValuePair<string, int>();

                    if (!mergedWidth.TryGetValue(i, out colDef))
                    {
                        continue;
                    }

                    FixColumnWidths(viewRow, i, colDef.Value);
                }
            }

            _PgNbr = 0;
            grdData.PageIndex = _PgNbr;
            grdData.Visible = true;

            btnRefreshData.Text = SalesPlanResources.btnRefreshDataLabel;
            btnRefreshData.Enabled = true;
            btnExcelCopy.Enabled = true;
            btnEmailPDF.Enabled = true;
        }

        #endregion


        #region Export_ScreenGrid

        private bool ExportToExcel()
        {
            try
            {
                // first need to create the filtered results array
                reFilterResultsArray();

                // builds the report break levels based on the grouping levels set by the user
                CreateGroupingLevels();

                // builds the report columns based on the settings teh user selected 
                mergedWidth = (Dictionary<int, KeyValuePair<string, int>>)Session[strColWidths];
                mathCols = (Dictionary<string, string>)Session[strMathCols];
                
                ReloadGridColumns();
                ReloadGridColumnWidths();

                int maxColumns = mergedWidth.Count;
                int LastVisibleCol = maxColumns;

                for (int i = 0; i <= maxColumns; i++)
                {
                    KeyValuePair<string, int> ColDef = new KeyValuePair<string, int>();

                    if (!mergedWidth.TryGetValue(i, out ColDef))
                    {
                        continue;
                    }

                    if (string.Compare(ColDef.Key, SalesPlanResources.colW13) == 0)
                    {
                        LastVisibleCol = i + 1;
                        break;
                    }
                }
                
                string FileName = SalesPlanResources.exportFileName;
                DateTime now = DateTime.Now;
                FileName = string.Concat(FileName, now.ToString(SalesPlanResources.dateMask));

                // Get grid data
                string tab = string.Empty;
                Response.Clear();
                Response.Buffer = true;
                Response.AddHeader(SalesPlanResources.content, string.Concat(SalesPlanResources.attachment, FileName, SalesPlanResources.excelExtension));
                Response.Charset = string.Empty;
                Response.ContentType = SalesPlanResources.applicationtypeExcel;

                // protype header
                processHeaderLabel(SalesPlanResources.colPROTYPE, (DropDownList)drpProTypes, LastVisibleCol);

                // managed product header
                processHeaderLabel(SalesPlanResources.colMGD, (DropDownList)drpMGD, LastVisibleCol);

                // region header
                processHeaderLabel(SalesPlanResources.colRegion, (CheckBoxList)lstRegionChk, LastVisibleCol);

                // locations header
                processHeaderLabel(SalesPlanResources.colLOC, (CheckBoxList)lstLocChk, LastVisibleCol);

                // species header
                processHeaderLabel(SalesPlanResources.colspecie, (CheckBoxList)lstSpeciesChk, LastVisibleCol, btnSpecie);

                // thickness header
                processHeaderLabel(SalesPlanResources.colthick, (CheckBoxList)lstThickChk, LastVisibleCol, btnThick);

                // grade header
                processHeaderLabel(SalesPlanResources.colgrade, (CheckBoxList)lstGradeChk, LastVisibleCol, btnGrade);

                // color header
                processHeaderLabel(SalesPlanResources.colColor, (CheckBoxList)lstColorChk, LastVisibleCol, btnColor);

                // sort header
                processHeaderLabel(SalesPlanResources.colSort, (CheckBoxList)lstSortChk, LastVisibleCol, btnSort);

                // no print header
                processHeaderLabel(SalesPlanResources.colNoPrint, (CheckBoxList)lstNoPrintChk, LastVisibleCol, btnNoPrint);

                // type header
                processHeaderLabel(SalesPlanResources.colTYPE, (CheckBoxList)lstTypeChk, LastVisibleCol, btnType);

                // manager header
                processHeaderLabel(SalesPlanResources.colMGR, (CheckBoxList)lstMgrChk, LastVisibleCol, btnMgr);

                // customer header
                processHeaderLabel(SalesPlanResources.colCUSTOMER, (CheckBoxList)lstCustChk, LastVisibleCol, btnCust);

                // product
                processHeaderLabel(SalesPlanResources.colPRODUCT, (CheckBoxList)lstProdChk, LastVisibleCol, btnProd);

                // blank line
                Response.Write(Environment.NewLine);
                
                string [] hdrLine = new string[(LastVisibleCol)];
                // build and write the column headers
                for (int idx = 0; idx < LastVisibleCol; idx++)
                {
                    KeyValuePair<string, int> gridColDef = new KeyValuePair<string, int>();

                    if (!mergedWidth.TryGetValue(idx, out gridColDef))
                    {
                        continue;
                    }

                    hdrLine[idx] = ProperCaseName(gridColDef.Key);
                }

                WriteArrayToScreen(hdrLine);
                 
                // now to output the actual data lines.
                foreach (SalesPlanData dataRow in grdRowData)
                {
                    hdrLine = null;
                    hdrLine = new string[(LastVisibleCol)];
                    // skips the total lines
                    if (dataRow.rowTotalLvl != groupLevels.Length - 1)
                    {
                        Response.Write(Environment.NewLine);
                        continue;
                    }
                    
                    // populates the column array
                    for (int colIdx = 0; colIdx < LastVisibleCol; colIdx++)
                    {
                        KeyValuePair<string, int> gridCol = new KeyValuePair<string, int>();
                         
                        if (!mergedWidth.TryGetValue(colIdx, out gridCol))
                        {
                            continue;
                        }

                        string colName = gridCol.Key;

                        dataRow.idx = colIdx;
                        dataRow.ptr = colName;

                        if (mathCols.ContainsKey(colName))
                        {
                            hdrLine[colIdx] = FormatAsNumber(dataRow.colTextValues);
                            continue;
                        }

                        hdrLine[colIdx] = FormatAsString(dataRow.colTextValues);
                    }

                    WriteArrayToScreen(hdrLine);
                }

                Response.Flush();
                Response.End();
            }
            catch (Exception ex)
            {
                return false;
            }
            return true;
        }

        private bool ExportToPdf()
        {
            try
            {
                // File name
                string FileName = SalesPlanResources.exportFileName;
                DateTime now = DateTime.Now;
                FileName = string.Concat(FileName, now.ToString(SalesPlanResources.dateMask));

                // first need to create the filtered results array
                reFilterResultsArray();

                // builds the report break levels based on the grouping levels set by the user
                CreateGroupingLevels();

                // builds the report columns based on the settings the user selected 
                mergedWidth = (Dictionary<int, KeyValuePair<string, int>>)Session[strColWidths];
                mathCols = (Dictionary<string, string>)Session[strMathCols];

                ReloadGridColumns();
                ReloadGridColumnWidths();

                Document pdfDoc = new Document(PageSize.LEGAL.Rotate(), 10, 10, 25, 25);
                MemoryStream mStream = new MemoryStream();
                PdfWriter writer = PdfWriter.GetInstance(pdfDoc, mStream);
                HeaderFooter headers = new HeaderFooter();
                writer.PageEvent = headers;

                int maxColumns = mergedWidth.Count;
                int LastVisibleCol = maxColumns;
                int typeCol = -1;

                for (int i = 0; i < maxColumns; i++)
                {
                    KeyValuePair<string, int> ColDef = new KeyValuePair<string, int>();

                    if (!mergedWidth.TryGetValue(i, out ColDef))
                    {
                        continue;
                    }

                    if (string.Compare(ColDef.Key, SalesPlanResources.colW13) == 0)
                    {
                        LastVisibleCol = i + 1;
                        break;
                    }

                    if (string.Compare(ColDef.Key, SalesPlanResources.colTYPE) == 0)
                    {
                        typeCol = i;
                    }
                }
                
                List<string> keyWords = new List<string>();
                List<string> parmLines = new List<string>();

                // protype header
                processHeaders(SalesPlanResources.colPROTYPE, (DropDownList)drpProTypes, LastVisibleCol, false, keyWords, parmLines);

                // region header
                processHeaders(SalesPlanResources.colRegion, (CheckBoxList)lstRegionChk, LastVisibleCol, true, keyWords, parmLines);

                // managed product header
                processHeaders(SalesPlanResources.colMGD, (DropDownList)drpMGD, LastVisibleCol, true, keyWords, parmLines);

                // locations header
                processHeaders(SalesPlanResources.colLOC, (CheckBoxList)lstLocChk, LastVisibleCol, true, keyWords, parmLines);

                // species header
                processHeaders(SalesPlanResources.colspecie, (CheckBoxList)lstSpeciesChk, LastVisibleCol, true, keyWords, parmLines, btnSpecie);

                // thickness header
                processHeaders(SalesPlanResources.colthick, (CheckBoxList)lstThickChk, LastVisibleCol, true, keyWords, parmLines, btnThick);

                // grade header
                processHeaders(SalesPlanResources.colgrade, (CheckBoxList)lstGradeChk, LastVisibleCol, true, keyWords, parmLines, btnGrade);

                // color header
                processHeaders(SalesPlanResources.colColor, (CheckBoxList)lstColorChk, LastVisibleCol, true, keyWords, parmLines, btnColor);

                // sort header
                processHeaders(SalesPlanResources.colSort, (CheckBoxList)lstSortChk, LastVisibleCol, true, keyWords, parmLines, btnSort);

                // noprint header
                processHeaders(SalesPlanResources.colNoPrint, (CheckBoxList)lstNoPrintChk, LastVisibleCol, true, keyWords, parmLines, btnNoPrint);

                // type header
                processHeaders(SalesPlanResources.colTYPE, (CheckBoxList)lstTypeChk, LastVisibleCol, true, keyWords, parmLines, btnSpecie);

                // manager header
                processHeaders(SalesPlanResources.colMGR, (CheckBoxList)lstMgrChk, LastVisibleCol, true, keyWords, parmLines, btnMgr);

                // customer header
                processHeaders(SalesPlanResources.colCUSTOMER, (CheckBoxList)lstCustChk, LastVisibleCol, true, keyWords, parmLines, btnCust);

                // product header
                processHeaders(SalesPlanResources.colPRODUCT, (CheckBoxList)lstProdChk, LastVisibleCol, true, keyWords, parmLines, btnCust);

                pdfDoc.AddKeywords(string.Join(" ", keyWords.ToArray()));
                pdfDoc.AddSubject(string.Format(SalesPlanResources.pdfSubject, DateTime.Now.ToString(SalesPlanResources.asofMask)));
                
                parmLines.Insert(0, SalesPlanResources.pdfTitle);

                iTextSharp.text.Font fontTbl = FontFactory.GetFont(FontFactory.HELVETICA, 7, BaseColor.BLACK);
                iTextSharp.text.Font fontHdr = FontFactory.GetFont(FontFactory.HELVETICA, 8, BaseColor.BLACK);

                DefineFont passFont = new DefineFont();

                // always set this to the largest font used
                headers.fontPointSize = 8;

                // set up the highlight or bold font
                passFont.fontFamily = SalesPlanResources.fontHelvetica;
                passFont.fontSize = 8;
                passFont.isBold = true;
                passFont.isItalic = false;
                passFont.isUnderlined = false;
                passFont.foreColor = BaseColor.BLACK;

                headers.boldFont = passFont;

                // now setup the normal text font
                passFont.fontSize = 7;
                passFont.isBold = false;

                headers.normalFont = passFont;

                headers.leftMargin = 10;
                headers.bottomMargin = 25;
                headers.rightMargin = 10;
                headers.topMargin = 25;

                headers.PageNumberSettings = HeaderFooter.PageNumbers.FooterPlacement;

                headers.footerLine = SalesPlanResources.pagePara;
                headers.headerLines = parmLines.ToArray();

                pdfDoc.SetMargins(headers.leftMargin, headers.rightMargin, headers.topMargin + headers.headerheight, headers.bottomMargin + headers.footerHeight);
                pdfDoc.Open();

                // the new page is necessary due to a bug in in the current version of itextsharp
                pdfDoc.NewPage();

                float TotalWidths = 0;
                float[] widths = new float[LastVisibleCol];
                List<string> ColTitles = new List<string>();

                for (int i = 0; i < LastVisibleCol; i++)
                {
                    KeyValuePair<string, int> colDef = new KeyValuePair<string, int>();
                    if (!mergedWidth.TryGetValue(i, out colDef))
                    {
                        continue;
                    }
                    ColTitles.Add(ProperCaseName(colDef.Key));
                    TotalWidths = TotalWidths + colDef.Value;
                    widths[i] = colDef.Value;
                }

                for (int i = 0; i < LastVisibleCol; i++)
                {
                    float pxlWidth = widths[i];
                    float pcntWidth = (pxlWidth / TotalWidths) * 100;
                    widths[i] = pcntWidth;
                }           
                
                PdfPTable pdfTable = new PdfPTable(LastVisibleCol);
                pdfTable.DefaultCell.BorderWidth = 1;
                pdfTable.WidthPercentage = 100;
                pdfTable.DefaultCell.Padding = 1;

                pdfTable.SpacingBefore = 5;
                pdfTable.SpacingAfter = 5;
                pdfTable.SetWidths(widths);
                pdfTable.WidthPercentage = 100;
                
                // add in the column headers
                foreach (string colName in ColTitles)
                {
                    PdfPCell hcell = new PdfPCell(new Phrase(colName, fontHdr));
                    hcell.HorizontalAlignment = Element.ALIGN_CENTER;
                    hcell.BackgroundColor = new iTextSharp.text.BaseColor(216, 247, 175);
                    hcell.BorderWidth = 1;
                    hcell.BorderColor = new iTextSharp.text.BaseColor(197, 216, 249);

                    pdfTable.AddCell(hcell);
                }

                pdfTable.HeaderRows = 1;
                pdfTable.FooterRows = 0;
                bool firstRow = true;

                // now add in the data cells
                bool afterTotals = false; 
                foreach (SalesPlanData dataRow in grdRowData)
                {
                    string[] colOut = LoadDataArray(dataRow, LastVisibleCol);

                    if (!firstRow)
                    {
                        string[] sparsedCols = SparseDataColumns(colOut, groupLevels, dataRow.rowTotalLvl, afterTotals, typeCol);
                        colOut = null;
                        colOut = sparsedCols;
                        sparsedCols = null; 
                    }
                    
                    for (int i = 0; i < LastVisibleCol; i++)
                    {
                        KeyValuePair<string, int> colDef = new KeyValuePair<string, int>();
                        if (!mergedWidth.TryGetValue(i, out colDef))
                        {
                            continue;
                        }
                        
                        PdfPCell dCell = new PdfPCell(new Phrase(colOut[i], fontTbl));
                        
                        dCell.BorderWidth = 1;
                        dCell.BorderColor = iTextSharp.text.BaseColor.LIGHT_GRAY;
                                        
                        dCell.BackgroundColor = (dataRow.rowTotalLvl != groupLevels.Length - 1) ? new iTextSharp.text.BaseColor(249, 211, 197) : iTextSharp.text.BaseColor.WHITE;

                        dCell.HorizontalAlignment = (string.Compare(colDef.Key, SalesPlanResources.colTotal) == 0 || mathCols.ContainsKey(colDef.Key)) ? Element.ALIGN_RIGHT : Element.ALIGN_LEFT;

                        pdfTable.AddCell(dCell);  

                        if (dataRow.rowTotalLvl != groupLevels.Length - 1)
                        {
                            afterTotals = true;
                        }
                        else
                        {
                            afterTotals = false;
                        }
                    }

                    firstRow = false;
                }

                pdfDoc.Add(pdfTable);
                pdfDoc.Close();
                Response.ContentType = SalesPlanResources.applicationTypePDF;
                Response.AddHeader(SalesPlanResources.content, string.Concat(SalesPlanResources.attachment, FileName, SalesPlanResources.pdfFileExtension));
                Response.Clear();
                Response.BinaryWrite(mStream.ToArray());
                Response.End();

                return true;
            }
            catch (DocumentException ex)
            {
                return false;
            }
            catch (IOException ex)
            {
                return false;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        
        private void processHeaders(string ColumnName, CheckBoxList valueList, int numColumns, bool addKeyWords, List<string> keyWords, List<string> parmLines, Button associatedButton)
        {
            if (associatedButton.Enabled == true)
            {
                string[] hdrLine = makeHeaderLabel(ProperCaseName(ColumnName), (CheckBoxList)valueList, numColumns);
                if (hdrLine[0].Length > 0)
                {
                    parmLines.Add(ConvertToLine(hdrLine));
                }
                hdrLine = null;

                if (addKeyWords)
                {
                    keyWords.Add(ConvertToKeyWord((ProperCaseName(ColumnName)), (CheckBoxList)valueList));
                }
            }
        }

        private void processHeaders(string ColumnName, CheckBoxList valueList, int numColumns, bool addKeyWords, List<string> keyWords, List<string> parmLines)
        {
            if (valueList.Enabled == true)
            {
                string[] hdrLine = makeHeaderLabel(ProperCaseName(ColumnName), (CheckBoxList)valueList, numColumns);
                if (hdrLine[0].Length > 0)
                {
                    parmLines.Add(ConvertToLine(hdrLine));
                }
                hdrLine = null;

                if (addKeyWords)
                {
                    keyWords.Add(ConvertToKeyWord((ProperCaseName(ColumnName)), (CheckBoxList)valueList));
                }
            }
        }

        private void processHeaders(string ColumnName, DropDownList valueList, int numColumns, bool addKeyWords, List<string> keyWords, List<string> parmLines)
        {
            string[] hdrLine = makeHeaderLabel(ProperCaseName(ColumnName), (DropDownList)valueList, numColumns);
            if (hdrLine[0].Length > 0)
            {
                parmLines.Add(ConvertToLine(hdrLine));
            }
            hdrLine = null;

            if (addKeyWords)
            {
                keyWords.Add(ConvertToKeyWord((ProperCaseName(ColumnName)), (DropDownList)valueList));
            }
        }

        private string[] SparseDataColumns(string[] dataArray, SalesPlanLevels[] BreakLevel, int totLevel, bool priorNotDetail, int typeColumn)
        {
            string[] colOut = new string[(dataArray.Length)];

            for (int i = 0; i < dataArray.Length; i++)
            {
                string dataValue = dataArray[i];

                colOut[i] = dataValue;
            }

            if (totLevel < BreakLevel.Length -1)
            {
                return colOut;
            }

            if (priorNotDetail)
            {
                return colOut;
            }

            bool trickleUp = false;

            if (typeColumn > -1)
            {
                if (string.Compare(colOut[typeColumn], SalesPlanResources.rowTypeInven) == 0 || 
                    string.Compare(colOut[typeColumn], SalesPlanResources.rowTypeProd) == 0)
                {
                    trickleUp = true;
                }
            }

            for (int i = lstColsSort.Items.Count - 1; i >= 0; i--)
            {
                if (string.Compare(colOut[i], BreakLevel[i].colDataValue.ToString()) == 0)
                {
                    if (!trickleUp)
                    {
                        colOut[i] = string.Empty;
                        continue;
                    }

                    if (lstColsSort.Items[i].Selected != true)
                    {
                        colOut[i] = string.Empty;
                        continue;
                    }

                    if (lstColsSort.Items[i].Selected == true)
                    {
                        trickleUp = true;
                    }
                }

                BreakLevel[i].colDataValue = colOut[i];
            }

            return colOut;
        }

        private string[] LoadDataArray(SalesPlanData dataRow, int lastCol)
        {
            string[] colOut = new string[(lastCol)];

            for (int i = 0; i < lastCol; i++)
            {
                dataRow.idx = i;
                string dataValue = dataRow.colTextValues;

                colOut[i] = dataValue;
            }

            return colOut;
        }

        private string ConvertToKeyWord(string columnName, CheckBoxList selectedValues)
        {
            for (int i = 0; i < selectedValues.Items.Count; i++)
            {
                if (selectedValues.Items[i].Selected == true)
                {
                    return string.Concat(columnName, SalesPlanResources.equal, selectedValues.Items[i].Text);
                }
            }

            return string.Format(SalesPlanResources.Nothing, columnName);
        }

        private string ConvertToKeyWord(string columnName, DropDownList selectedValues)
        {
            return string.Concat(columnName, SalesPlanResources.equal, selectedValues.SelectedValue);
        }

        private string ConvertToLine(string[] LineSegs)
        {
            string ColName = LineSegs[0];
            LineSegs[0] = string.Empty;

            int Cntr = 0;

            foreach (string valIn in LineSegs)
            {
                if (!string.IsNullOrWhiteSpace(valIn))
                {
                    Cntr++;
                }
            }

            string SelValues = string.Join(SalesPlanResources.comma, LineSegs, 1, Cntr);

            return string.Concat(ColName, SalesPlanResources.valuesSelectedAS, SelValues);
        }

        private string ProperCaseName(string nameIn)
        {
            string parmName = nameIn.Trim();

            string outName = string.Concat(parmName[0].ToString().ToUpper(), parmName.Substring(1).ToLower());

            return outName;
        }

        private void WriteArrayToScreen(string[] stringIn)
        {
            bool needsBreak = false;

            foreach(string lineSeg in stringIn)
            {
                if (needsBreak)
                {
                    Response.Write(SalesPlanResources.comma);
                }
                
                if (string.IsNullOrWhiteSpace(lineSeg))
                {
                    Response.Write(string.Empty);
                    needsBreak = true;
                    continue;
                }

                Response.Write(FormatAsString(lineSeg.Trim()));
                needsBreak = true;
            }

            Response.Write(Environment.NewLine);
        }

        private void processHeaderLabel(string columnName, DropDownList valueList, int NumCols)
        {
            string [] hdrLine = makeHeaderLabel(ProperCaseName(columnName), (DropDownList)valueList, NumCols);
            if (hdrLine[0].Length > 0)
            {
                WriteArrayToScreen(hdrLine);
            }
            hdrLine = null;
        }

        private void processHeaderLabel(string columnName, CheckBoxList valueList, int NumCols)
        {
            if (valueList.Enabled == true)
            {
                string[] hdrLine = makeHeaderLabel(ProperCaseName(columnName), (CheckBoxList)valueList, NumCols);
                if (hdrLine[0].Length > 0)
                {
                    WriteArrayToScreen(hdrLine);
                }

                hdrLine = null;
            }
        }

        private void processHeaderLabel(string columnName, CheckBoxList valueList, int NumCols, Button associatedButton)
        {
            if (associatedButton.Enabled == true)
            {
                string[] hdrLine = makeHeaderLabel(ProperCaseName(columnName), (CheckBoxList)valueList, NumCols);
                if (hdrLine[0].Length > 0)
                {
                    WriteArrayToScreen(hdrLine);
                }

                hdrLine = null;
            }
        }

        private string[] makeHeaderLabel(string columnName, CheckBoxList selectedValues, int arrayLength)
        {
            bool selAll = true;
            bool selNone = true;

            string[] hdrOut = new string[(arrayLength)];
            for (int i = 0; i < arrayLength; i++)
            {
                hdrOut[i] = string.Empty;
            }

            for (int idx = 0; idx < selectedValues.Items.Count; idx++)
            {
                if (selectedValues.Items[idx].Selected != true)
                {
                    selAll = false;
                    continue;
                }

                if (selectedValues.Items[idx].Selected == true)
                {
                    selNone = false;
                }   
            }

            if (selNone)
            {
                return hdrOut;
            }
            
            hdrOut[0] = columnName;

            if (selAll)
            {
                hdrOut[1] = string.Format(SalesPlanResources.AllValuesSelected, columnName);
                return hdrOut;
            }

            int outIdx = 1;
            for (int ptr = 0; ptr < selectedValues.Items.Count; ptr ++)
            {
                if (selectedValues.Items[ptr].Selected == true)
                {
                    hdrOut[outIdx] = selectedValues.Items[ptr].Text;
                    outIdx++;
                    if (outIdx > arrayLength)
                    {
                        break;
                    } 
                }
            }

            return hdrOut;
        }

        private string[] makeHeaderLabel(string columnName, DropDownList selectedValues, int arrayLength)
        {
            string[] hdrOut = new string[(arrayLength)];
            for (int i = 0; i < arrayLength; i++)
            {
                hdrOut[i] = string.Empty;
            }

            hdrOut[0] = columnName;

            hdrOut[1] = selectedValues.SelectedValue.ToString();
            
            return hdrOut;
        }
        
        private string FormatAsString(string inData)
        {
            if (string.IsNullOrWhiteSpace(inData))
            {
                return string.Empty;
            }

            string outdata = inData.Replace("'", "''").Replace(SalesPlanResources.sngQuotes, SalesPlanResources.dblQuotes).Replace(SalesPlanResources.comma, string.Empty);
            return outdata;
        }

        private string FormatAsNumber(string inData)
        {
            if (string.IsNullOrWhiteSpace(inData))
            {
                return string.Empty;
            }

            return inData;
        }

        #endregion 


        #region Options_Screen_Events

        protected void chkShowCust_CheckedChanged(object sender, EventArgs e)
        {
            int custColNum = 0;
            int mgrColNum = 0;

            grdColumns.TryGetValue(SalesPlanResources.colCUSTOMER, out custColNum);
            grdColumns.TryGetValue(SalesPlanResources.colMGR, out mgrColNum);
                        
            if (chkShowCust.Checked == true)
            {
                WherePutCustomer(chkShowCust.Checked);
                                
                lstCustChk.Enabled = true;
                lstMgrChk.Enabled = true;
                btnCust.Enabled = true;
                btnMgr.Enabled = true;

                grdData.Columns[custColNum].Visible = true;
                grdData.Columns[mgrColNum].Visible = true;
            }
            else
            {
                WherePutCustomer(chkShowCust.Checked);
                                
                lstCustChk.Enabled = false;
                lstMgrChk.Enabled = false;
                btnCust.Enabled = false;
                btnMgr.Enabled = false;

                grdData.Columns[custColNum].Visible = false;
                grdData.Columns[mgrColNum].Visible = false;
            }

            Session[runTimeToken] = null;
        }

        protected void chkHolds_CheckedChanged(object sender, EventArgs e)
        {
            string runTimeToken = string.Concat(_UserID.ToString(), SalesPlanResources.TimeStamp);
            Session[runTimeToken] = null;
        }

        protected void chkHist_CheckedChanged(object sender, EventArgs e)
        {
            string runTimeToken = string.Concat(_UserID.ToString(), SalesPlanResources.TimeStamp);
            Session[runTimeToken] = null;
        }

        protected void optSales_CheckedChanged(object sender, EventArgs e)
        {
            string runTimeToken = string.Concat(_UserID.ToString(), SalesPlanResources.TimeStamp);
            Session[runTimeToken] = null;
        }

        protected void optProduction_CheckedChanged(object sender, EventArgs e)
        {
            string runTimeToken = string.Concat(_UserID.ToString(), SalesPlanResources.TimeStamp);
            Session[runTimeToken] = null;
        }

        protected void optEither_CheckedChanged(object sender, EventArgs e)
        {
            string runTimeToken = string.Concat(_UserID.ToString(), SalesPlanResources.TimeStamp);
            Session[runTimeToken] = null;
        }

        #endregion


        #region DropDownList_Screen_Events

        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            int pageLen = 0;

            grdData.DataSource = null;

            if (int.TryParse(ddlPageSize.SelectedValue.ToString(), out pageLen))
            {
                grdData.PageSize = pageLen;
            }
            else
            {
                pageLen = 10;
            }

            grdData.DataSource = grdRowData;
            grdData.PageSize = pageLen;
            grdData.DataBind();
            btnExcelCopy.Enabled = true;
            btnEmailPDF.Enabled = true;
        }

        protected void drpProTypes_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(drpProTypes.SelectedValue))
            {
                holdSelValue = drpProTypes.SelectedValue.ToString();
                
                lstGradeChk.Enabled = false;
                lstSpeciesChk.Enabled = false;
                lstThickChk.Enabled = false;
                lstColorChk.Enabled = false;
                lstSortChk.Enabled = false;
                lstMgrChk.Enabled = false;
                lstCustChk.Enabled = false;
                lstTypeChk.Enabled = false;
                lstRegionChk.Enabled = false;
                lstLocChk.Enabled = false;
                lstNoPrintChk.Enabled = false;

                lstGradeChk.Items.Clear();
                lstSpeciesChk.Items.Clear();
                lstThickChk.Items.Clear();
                lstColorChk.Items.Clear();
                lstSortChk.Items.Clear();
                lstMgrChk.Items.Clear();
                lstCustChk.Items.Clear();
                lstTypeChk.Items.Clear();
                lstRegionChk.Items.Clear();
                lstLocChk.Items.Clear();
                lstLocChk.Items.Clear();

                Session[strGrid] = null;
                Session[strType] = null;
                Session[strMgr] = null;
                Session[strCust] = null;
                Session[strProd] = null;
                Session[strSort] = null;
                Session[strColor] = null;
                Session[strProducts] = null;

                Session[strLocations] = null;
                Session[strSpecies] = null;
                Session[strThickness] = null;
                Session[strNoPrint] = null;
                Session[strGrade] = null;
                Session[strRegions] = null;
                Session[strLocRegions] = null;

                // necessary so that app will refill the memory tables from the database
                runTimeToken = null;
                
                tblLocations.Clear();
                tblLocations = DataObj.FillSalesTableSegments(SalesPlanResources.SpLoadLocations);
                Session[strLocations] = tblLocations;

                tblProducts = DataObj.FillSalesTableSegments(SalesPlanResources.SpLoadProducts, holdSelValue);
                Session[strProducts] = tblProducts;
                
                tblRegions.Clear();
                tblRegions = DataObj.FillSalesTableRegions(holdSelValue, false);
                Session[strRegions] = tblRegions;

                tblLocRegions.Clear();
                tblLocRegions = DataObj.FillSalesTableLocationRegions(holdSelValue);
                Session[strLocRegions] = tblLocRegions;

                tblSpecies.Clear();
                tblSpecies = DataObj.FillSalesTableSpecies(holdSelValue);
                Session[strSpecies] = tblSpecies;

                tblThickness.Clear();
                tblThickness = DataObj.FillSalesTableAttributes(SalesPlanResources.SpLoadThickness, holdSelValue);
                Session[strThickness] = tblThickness;

                tblGrade.Clear();
                tblGrade = DataObj.FillSalesTableAttributes(SalesPlanResources.SpLoadGrade, holdSelValue);
                Session[strGrade] = tblGrade;

                tblSort.Clear();
                tblSort = DataObj.FillSalesTableAttributes(SalesPlanResources.SpLoadSort, holdSelValue);
                Session[strSort] = tblSort;

                tblColor.Clear();
                tblColor = DataObj.FillSalesTableAttributes(SalesPlanResources.SpLoadColor, holdSelValue);
                Session[strColor] = tblColor;

                tblNoPrint.Clear();
                tblNoPrint = DataObj.FillSalesTableAttributes(SalesPlanResources.SpLoadNoPrint, holdSelValue);
                Session[strNoPrint] = tblNoPrint;
                grdData.Visible = false;

                regionRows = tblRegions.Select();
                BindTableBasedPickList(lstRegionChk, regionRows, SalesPlanResources.colRegion, false);

                FilterLocationList();
                BindTableBasedPickList(lstLocChk, locRows, SalesPlanResources.colCode, SalesPlanResources.colDesc, false);

                FilterSpecieList();
                BindTableBasedPickList(lstSpeciesChk, specieRows, SalesPlanResources.colspecie, false);

                FilterThickList();
                BindTableBasedPickList(lstThickChk, thickRows, SalesPlanResources.colthick, false);

                FilterGradeList();
                BindTableBasedPickList(lstGradeChk, gradeRows, SalesPlanResources.colgrade, false);

                FilterSortList();
                BindTableBasedPickList(lstSortChk, sortRows, SalesPlanResources.colSort, true);

                FilterColorList();
                BindTableBasedPickList(lstColorChk, colorRows, SalesPlanResources.colColor, true);

                FilterNoPrintList();
                BindTableBasedPickList(lstNoPrintChk, noPrintRows, SalesPlanResources.colNoPrint, true);

                reset_all_Header_Buttons();
            }
        }

        protected void drpMGD_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnRefreshData.Enabled = true;
            Session[runTimeToken] = null;
        }

        private void BuildProductTypes()
        {
            DataTable tblProTypes = GetProTypeCodeList();
            drpProTypes.Items.Clear();

            System.Web.UI.WebControls.ListItem proItem = new System.Web.UI.WebControls.ListItem();

            proItem.Text = string.Empty;
            proItem.Value = SalesPlanResources.noneSelected;

            drpProTypes.Items.Add(proItem);

            foreach (DataRow rowIn in tblProTypes.Rows)
            {
                proItem = new System.Web.UI.WebControls.ListItem();

                proItem.Text = rowIn[SalesPlanResources.colPROTYPE].ToString();
                proItem.Value = rowIn[SalesPlanResources.colPROTYPE].ToString();

                drpProTypes.Items.Add(proItem);
            }
        }

        #endregion


        #region Grid_Screen_Events

        protected void grdData_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            int maxColumns = grdData.Columns.Count;
            int LastVisibleCol = maxColumns;
            int afterLast = 0;

            ReloadGridColumns();
            ReloadGridColumnWidths();

            mergedWidth = (Dictionary<int, KeyValuePair<string, int>>)Session[strColWidths];

            if (e.Row.RowType == DataControlRowType.Header)
            {
                for (int i = 0; i < grdData.Columns.Count; i++)
                {
                    grdData.Columns[i].Visible = false;

                    KeyValuePair<string, int> visibleCol = new KeyValuePair<string, int>();

                    if (!mergedWidth.TryGetValue(i, out visibleCol))
                    {
                        continue;
                    }

                    if (afterLast < 2)
                    {
                        if (string.Compare(visibleCol.Key, SalesPlanResources.colW13) == 0)
                        {
                            LastVisibleCol = i;
                            afterLast = 1;
                        }

                        FixColumnWidths(e.Row, i, visibleCol.Value);
                        grdData.Columns[i].Visible = true;

                        if (afterLast == 1)
                        {
                            afterLast = 2;
                        }
                    }
                }

                for (int lstIdx = 0; lstIdx < grdData.Columns.Count; lstIdx++)
                {
                    KeyValuePair<string, int> colWidth = new KeyValuePair<string, int>();

                    if (!mergedWidth.TryGetValue(lstIdx, out colWidth))
                    {
                        continue;
                    }

                    FixColumnWidths(e.Row, lstIdx, colWidth.Value);

                    e.Row.Cells[lstIdx].Text = colWidth.Key;

                    if (lstIdx > LastVisibleCol)
                    {
                        grdData.Columns[lstIdx].Visible = false;
                    }
                    else
                    {
                        grdData.Columns[lstIdx].Visible = true;
                    }
                }

                return;
            }

            if (e.Row.RowType != DataControlRowType.DataRow)
            {
                return;
            }

            List<int> rowAddress = new List<int>();
            for (int i = 0; i < lstColsSort.Items.Count; i++)
            {
                rowAddress.Add(i);
            }

            afterLast = 0;
            for (int i = 0; i < grdData.Columns.Count; i++)
            {
                grdData.Columns[i].Visible = false;

                KeyValuePair<string, int> visibleCol = new KeyValuePair<string, int>();

                if (!mergedWidth.TryGetValue(i, out visibleCol))
                {
                    continue;
                }

                if (afterLast < 2)
                {
                    if (string.Compare(visibleCol.Key, SalesPlanResources.colW13) == 0)
                    {
                        LastVisibleCol = i;
                        afterLast = 1;
                    }

                    FixColumnWidths(e.Row, i, visibleCol.Value);
                    grdData.Columns[i].Visible = true;

                    if (afterLast == 1)
                    {
                        afterLast = 2;
                    }
                }
            }

            string RowToolTip = BuildToolTip(rowAddress.ToArray(), e.Row);

            for (int idx = 0; idx < LastVisibleCol; idx++)
            {
                string colName = string.Format(SalesPlanResources.vwColumnName, (idx + 1).ToString().Trim());
                string colValue = RetrieveGridCellValue(e.Row, colName, true);
                AppendToolTips(e.Row, idx, colValue, RowToolTip);

                KeyValuePair<string, int> ColDef = new KeyValuePair<string, int>();

                if (!mergedWidth.TryGetValue(idx, out ColDef))
                {
                    continue;
                }

                FixColumnWidths(e.Row, idx, ColDef.Value);
            }

            string dtlText = RetrieveGridCellValue(e.Row, SalesPlanResources.vwColDetail, false);

            int custAddress = FindGridColumn(SalesPlanResources.colCUSTOMER);
            if (custAddress > -1)
            {
                AppendToolTips(e.Row, custAddress, dtlText);
            }
        }
        
        private string BuildToolTip(int[] columnLocs, GridViewRow viewRow)
        {
            int[] SortedLocs = columnLocs;

            StringBuilder outString = new StringBuilder(2000);

            Array.Sort(SortedLocs);

            bool hasContents = false;

            for (int idx = 0; idx < SortedLocs.Length; idx++)
            {
                if (SortedLocs[idx] < 0)
                {
                    continue;
                }

                int colIdx = SortedLocs[idx];

                string celName = string.Format(SalesPlanResources.vwColumnName, (colIdx + 1).ToString().Trim());

                string celContents = RetrieveGridCellValue(viewRow, celName, false);

                if (!hasContents)
                {
                    outString.Append(SalesPlanResources.toolTipLocationRow);
                    hasContents = true;
                    outString.Append(celContents);
                    continue;
                }

                outString.Append(SalesPlanResources.valueSep);
                outString.Append(celContents);
            }

            return outString.ToString();
        }

        private int FindGridColumn(string columnName)
        {
            int colNum = -1;

            if (grdColumns.TryGetValue(columnName, out colNum))
            {
                return colNum;
            }

            return colNum;
        }

        private void AppendToolTips(GridViewRow screenRow, int colNumber, string colValue, string rowtext)
        {
            if (colNumber == -1)
            {
                return;
            }

            var matchedKeys = grdColumns.Where(p => p.Value == colNumber).Select(p => p.Key);

            string colName = matchedKeys.First().ToString();

            string finalToolTip = string.Concat(string.Format(SalesPlanResources.toolTipValueRow, colValue),
                                                 Environment.NewLine,
                                                 rowtext,
                                                 Environment.NewLine,
                                                 string.Format(SalesPlanResources.toolTipLocationColumn, colName));

            screenRow.Cells[colNumber].ToolTip = finalToolTip;
        }

        private void AppendToolTips(GridViewRow screenRow, int colNumber, string rowtext)
        {
            if (colNumber == -1)
            {
                return;
            }

            screenRow.Cells[colNumber].ToolTip = rowtext;
        }
                
        private void FixColumnWidths(GridViewRow viewRow, int colNum, int widthIn)
        {
            double colWide = widthIn;
            System.Web.UI.WebControls.Unit width = new System.Web.UI.WebControls.Unit(colWide, UnitType.Pixel);

            viewRow.Cells[colNum].Width = width;
        }

        private string RetrieveGridCellValue(GridViewRow screenRow, string colName, bool editValue)
        {
            Label lblText = screenRow.FindControl(colName) as Label;

            if (lblText != null)
            {
                if (!editValue)
                {
                    return lblText.Text.ToString();
                }

                return string.IsNullOrWhiteSpace(lblText.Text.ToString()) ? SalesPlanResources.textNoValue : lblText.Text.ToString();
            }

            return string.Empty;
        }

        protected void grdData_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            int newPage = e.NewPageIndex;

            grdData.DataSource = null;
            grdData.DataSource = grdRowData;
            grdData.DataBind();
            grdData.PageIndex = newPage;
            btnExcelCopy.Enabled = true;
            btnEmailPDF.Enabled = true;
        }

        #endregion


        #region CheckBoxList_Screen_Events

        protected void lstColsSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            int selIdx = lstColsSort.SelectedIndex;

            if (lstColsSort.SelectedIndex > -1)
            {
                reset_all_Header_Buttons();
            }
        }

        protected void lstRegionChk_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool goodSet = ValidateCheckLists(lstRegionChk, SalesPlanResources.errSelectRegion);          

            if (goodSet)
            {
                // if region changes then need to go back to the database to refetch a dataset
                Session[runTimeToken] = null;

                FilterLocationList();
                BindTableBasedPickList(lstLocChk, locRows, SalesPlanResources.colCode, SalesPlanResources.colDesc, false);

                FilterSpecieList();
                BindTableBasedPickList(lstSpeciesChk, specieRows, SalesPlanResources.colspecie, false);

                FilterGradeList();
                BindTableBasedPickList(lstGradeChk, gradeRows, SalesPlanResources.colgrade, false);

                FilterThickList();
                BindTableBasedPickList(lstThickChk, thickRows, SalesPlanResources.colthick, false);

                FilterColorList();
                BindTableBasedPickList(lstColorChk, colorRows, SalesPlanResources.colColor, true);

                FilterSortList();
                BindTableBasedPickList(lstSortChk, sortRows, SalesPlanResources.colSort, true);

                FilterNoPrintList();
                BindTableBasedPickList(lstNoPrintChk, noPrintRows, SalesPlanResources.colNoPrint, true);

                CleanUpAfterFilterReset();
            }
        }

        protected void lstLocChk_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool goodSet = ValidateCheckLists(lstLocChk, SalesPlanResources.errSelectRegion);

            if (goodSet)
            {
                // if location changes then need to go back to the database to refetch a dataset
                Session[runTimeToken] = null;

                FilterSpecieList();
                BindTableBasedPickList(lstSpeciesChk, specieRows, SalesPlanResources.colspecie, false);

                FilterThickList();
                BindTableBasedPickList(lstThickChk, thickRows, SalesPlanResources.colthick, false);

                FilterGradeList();
                BindTableBasedPickList(lstGradeChk, gradeRows, SalesPlanResources.colgrade, false);

                FilterColorList();
                BindTableBasedPickList(lstColorChk, colorRows, SalesPlanResources.colColor, true);

                FilterSortList();
                BindTableBasedPickList(lstSortChk, sortRows, SalesPlanResources.colSort, true);
                
                FilterNoPrintList();
                BindTableBasedPickList(lstNoPrintChk, noPrintRows, SalesPlanResources.colNoPrint, true);

                CleanUpAfterFilterReset();
            }
        }

        protected void lstSpeciesChk_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool goodSet = ValidateCheckLists(lstSpeciesChk, SalesPlanResources.errSelectSpecies);

            if (goodSet)
            {
                FilterThickList();
                BindTableBasedPickList(lstThickChk, thickRows, SalesPlanResources.colthick, false);

                FilterGradeList();
                BindTableBasedPickList(lstGradeChk, gradeRows, SalesPlanResources.colgrade, false);

                FilterColorList();
                BindTableBasedPickList(lstColorChk, colorRows, SalesPlanResources.colColor, true);

                FilterSortList();
                BindTableBasedPickList(lstSortChk, sortRows, SalesPlanResources.colSort, true);
                
                FilterNoPrintList();
                BindTableBasedPickList(lstNoPrintChk, noPrintRows, SalesPlanResources.colNoPrint, true);

                CleanUpAfterFilterReset();
            }
        }

        protected void lstThickChk_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool goodSet = ValidateCheckLists(lstThickChk, SalesPlanResources.errSelectThick);

            if (goodSet)
            {
                FilterGradeList();
                BindTableBasedPickList(lstGradeChk, gradeRows, SalesPlanResources.colgrade, false);

                FilterColorList();
                BindTableBasedPickList(lstColorChk, colorRows, SalesPlanResources.colColor, true);

                FilterSortList();
                BindTableBasedPickList(lstSortChk, sortRows, SalesPlanResources.colSort, true);
                
                FilterNoPrintList();
                BindTableBasedPickList(lstNoPrintChk, noPrintRows, SalesPlanResources.colNoPrint, true);

                CleanUpAfterFilterReset();
            }
        }

        protected void lstGradeChk_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool goodSet = ValidateCheckLists(lstGradeChk, SalesPlanResources.errSelectGrade);

            if (goodSet)
            {
                FilterColorList();
                BindTableBasedPickList(lstColorChk, colorRows, SalesPlanResources.colColor, true);

                FilterSortList();
                BindTableBasedPickList(lstSortChk, sortRows, SalesPlanResources.colSort, true);
                
                FilterNoPrintList();
                BindTableBasedPickList(lstNoPrintChk, noPrintRows, SalesPlanResources.colNoPrint, true);

                CleanUpAfterFilterReset();
            }
        }

        protected void lstColorChk_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool goodSet = ValidateCheckLists(lstColorChk, SalesPlanResources.errSelectColor);

            if (goodSet)
            {
                FilterSortList();
                BindTableBasedPickList(lstSortChk, sortRows, SalesPlanResources.colSort, true);

                FilterNoPrintList();
                BindTableBasedPickList(lstNoPrintChk, noPrintRows, SalesPlanResources.colNoPrint, true);

                CleanUpAfterFilterReset();
            }
        }

        protected void lstSortChk_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool goodSet = ValidateCheckLists(lstSortChk, SalesPlanResources.errSelectSort);

            if (goodSet)
            {
                FilterNoPrintList();
                BindTableBasedPickList(lstNoPrintChk, noPrintRows, SalesPlanResources.colNoPrint, true);

                CleanUpAfterFilterReset();
            }
        }

        protected void lstNoPrintChk_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool goodSet = ValidateCheckLists(lstNoPrintChk, SalesPlanResources.errSelectSort);

            if (goodSet)
            {
                CleanUpAfterFilterReset();
            }
        }

        protected void lstTypeChk_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool goodSet = ValidateCheckLists(lstTypeChk, SalesPlanResources.errSelectType);

            if (goodSet)
            {

                reFilterResultsArray();
                if (rsltRows != null && rsltRows.Length > 0)
                {
                    FilterMgrList();
                    BindTableBasedPickList(lstMgrChk, mgrRows, SalesPlanResources.colMGR, false);

                    FilterCustList();
                    BindTableBasedPickList(lstCustChk, custRows, SalesPlanResources.colCUSTOMER, false);

                    FilterProductList();
                    BindTableBasedPickList(lstProdChk, prodRows, SalesPlanResources.colCode, SalesPlanResources.colDesc, false);
                }

                reset_all_Header_Buttons();
            }
        }
        
        protected void lstMgrChk_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool goodSet = ValidateCheckLists(lstMgrChk, SalesPlanResources.errSelectMgr);

            if (goodSet)
            {
                reFilterResultsArray();
                if (rsltRows != null && rsltRows.Length > 0)
                {
                    FilterCustList();
                    BindTableBasedPickList(lstCustChk, custRows, SalesPlanResources.colCUSTOMER, false);

                    FilterProductList();
                    BindTableBasedPickList(lstProdChk, prodRows, SalesPlanResources.colCode, SalesPlanResources.colDesc, false);

                }

                reset_all_Header_Buttons();
            }
        }

        protected void lstCustChk_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool goodSet = ValidateCheckLists(lstCustChk, SalesPlanResources.errSelectCust);

            if (goodSet)
            {
                reFilterResultsArray();

                FilterProductList();
                BindTableBasedPickList(lstProdChk, prodRows, SalesPlanResources.colCode, SalesPlanResources.colDesc, false);

                reset_all_Header_Buttons();
            }
        }

        protected void lstProdChk_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool goodSet = ValidateCheckLists(lstProdChk, SalesPlanResources.errSelectType);

            if (goodSet)
            {
                reFilterResultsArray();

                reset_all_Header_Buttons();
            }
        }
        protected void lstColsAvail_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (lstColsAvail.SelectedIndex > -1)
            {
                reset_all_Header_Buttons();
            }
        }
        

        #endregion


        #region Database_Functions
        
        private DataTable SortReportTable(CheckBoxList sortKeys)
        {
            if (sortKeys.Items.Count == 0)
            {
                return tblReport;
            }

            List<string> ToSortBy = new List<string>();
            foreach(System.Web.UI.WebControls.ListItem sortKey in sortKeys.Items)
            {
                ToSortBy.Add(sortKey.Value.ToString());
            }

            string[] sortBy = ToSortBy.ToArray();
            string sortByList = string.Join(string.Concat(SalesPlanResources.sortDir, SalesPlanResources.comma), sortBy);

            var dataview = new DataView(tblReport);

            if (!sortByList.EndsWith(SalesPlanResources.sortDir))
            {
                sortByList = string.Concat(sortByList, SalesPlanResources.sortDir);
            }

            dataview.Sort = sortByList;

            return dataview.ToTable();
        }

        private DataTable GetMainDataTable(string sessionVarName, string sprocName)
        {
            DataTable tmp = new DataTable();

            tmp.Columns.Add(new DataColumn(SalesPlanResources.colRowType, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colMGD, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colTYPE, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colDESCRIPTION, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colPROTYPE, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colPRODUCT, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colLOC, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colCUSTOMER, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colORDNUM, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colMGR, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colDETAIL, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colUOM, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colspecie, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colgrade, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colthick, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colRegion, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colColor, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colSort, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colNoPrint, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colP13, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colP8, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colP4, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colINV, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colPAST, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW00, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW01, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW02, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW03, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW04, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW05, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW06, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW07, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW08, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW09, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW10, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW11, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW12, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW13, typeof(decimal)));

            StringBuilder regionParm = new StringBuilder(1000);
            bool hasContents = false;

            foreach(System.Web.UI.WebControls.ListItem RegionItem in lstRegionChk.Items)
            {
                if (RegionItem.Selected == true)
                {
                    if (hasContents)
                    {
                        regionParm.Append(SalesPlanResources.comma);
                    }

                    regionParm.Append(RegionItem.Value.ToString().ToUpper().Trim());
                    hasContents = true;
                }
            }

            if (!hasContents)
            {
                regionParm.Append(string.Empty);
            }
            
            StringBuilder locParm = new StringBuilder(4000);
            hasContents = false;

            foreach (System.Web.UI.WebControls.ListItem LocItem in lstLocChk.Items)
            {
                if (LocItem.Selected == true)
                {
                    if (hasContents)
                    {
                        locParm.Append(SalesPlanResources.comma);
                    }

                    locParm.Append(LocItem.Value.ToString().ToUpper().Trim());
                    hasContents = true;
                }
            }

            if (!hasContents)
            {
                locParm.Append(string.Empty);
            }

            try
            {
                tmp = DataObj.FillSalesTableSegments(sprocName, drpProTypes.Text.ToString(), regionParm.ToString(), locParm.ToString());
                Session[sessionVarName] = tmp;
            }
            catch (SqlException e)
            {
                errMsg.Text = string.Format(SalesPlanResources.errOnDataBase, sprocName, e.Number.ToString(), e.Message);
            }
            catch (Exception e)
            {
                errMsg.Text = string.Format(SalesPlanResources.errOnDataBase, sprocName, e.Source, e.Message);
            }

            regionParm.Clear();
            regionParm = null;
            locParm.Clear();
            locParm = null;

            return tmp;
        }

        private DataTable CreateReportDataTable()
        {
            DataTable tmp = new DataTable();

            tmp.Columns.Add(new DataColumn(SalesPlanResources.colPROTYPE, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colLOC, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colColor, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colSort, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colRegion, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colNoPrint, typeof(string)));

            tmp.Columns.Add(new DataColumn(SalesPlanResources.colspecie, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colthick, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colgrade, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colPRODUCT, typeof(string)));

            tmp.Columns.Add(new DataColumn(SalesPlanResources.colTYPE, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colCUSTOMER, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colMGR, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colP13, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colP8, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colP4, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colPAST, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colINV, typeof(decimal)));

            tmp.Columns.Add(new DataColumn(SalesPlanResources.colTotal, typeof(decimal)));

            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW00, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW01, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW02, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW03, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW04, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW05, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW06, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW07, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW08, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW09, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW10, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW11, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW12, typeof(decimal)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colW13, typeof(decimal)));

            tmp.Columns.Add(new DataColumn(SalesPlanResources.colDETAIL, typeof(string)));
            tmp.Columns.Add(new DataColumn(SalesPlanResources.colORDNUM, typeof(string)));
            
            return tmp;
        }

        protected DataTable FilterInputTable(DataTable indata, string datafilter)
        {
            DataTable tmp = indata.Clone();
            DataRow[] results = indata.Select(datafilter);

            if (results.Length > 0)
            {
                tmp = results.CopyToDataTable();
            }

            return tmp;
        }
        
        private void loadtables()
        {
            tblReport = null;
            tblReport = CreateReportDataTable();

            if (optSales.Checked == true || optEither.Checked == true)
            {
                if (chkHolds.Checked == true)
                {
                    // 4 orders on Hold Q status
                    tblHoldOrders = null;
                    tblHoldOrders = GetMainDataTable(strHoldOrders, SalesPlanResources.spLoadHoldOrds);
                    ImportDataRows(tblHoldOrders, SalesPlanResources.rowTypeOrdHolds);
                }

                if (chkHist.Checked == true)
                {
                    // 6 Current Orders R Status and Past Orders for 13 weeks
                    tblOrderHist = null;
                    tblOrderHist = GetMainDataTable(strOrderHist, SalesPlanResources.SpLoadOrdHistory);
                    ImportDataRows(tblOrderHist, SalesPlanResources.rowTypeSales);
                }
                else
                {
                    // 3 Current Orders R Status
                    tblOpenOrders = null;
                    tblOpenOrders = GetMainDataTable(strOpenOrders, SalesPlanResources.SpLoadOpenOrds);
                    ImportDataRows(tblOpenOrders, SalesPlanResources.rowTypeSales);
                }
            }

            if (optProduction.Checked == true || optEither.Checked == true)
            {
                if (chkHist.Checked == true)
                {
                    // 7 Forecats, Production and Past Production for 13 weeks
                    tblProdHist = null;
                    tblProdHist = GetMainDataTable(strProdHist, SalesPlanResources.SpLoadProdHIstory);
                    ImportDataRows(tblProdHist, SalesPlanResources.rowTypeProd);
                }
                else
                {
                    // 2 Forecast and Production
                    tblProduction = null;
                    tblProduction = GetMainDataTable(strProduction, SalesPlanResources.SpLoadProd);
                    ImportDataRows(tblProduction, SalesPlanResources.rowTypeProd);
                }

                // 0 current inventory 
                tblCurrInven = null;
                tblCurrInven = GetMainDataTable(strCurrInven, SalesPlanResources.SploadCurrInventory);
                ImportDataRows(tblCurrInven, SalesPlanResources.rowTypeInven);
                
                // 1 discontinued (was projected inventory which is now handled internally)
            }
        }

        private void ImportDataRows(DataTable inData, string RowType)
        {
            foreach (DataRow indataRow in inData.Rows)
            {
                DataRow insRow = tblReport.NewRow();

                insRow[SalesPlanResources.colPROTYPE] = EditStringColumn(indataRow, SalesPlanResources.colPROTYPE);
                insRow[SalesPlanResources.colLOC] = EditStringColumn(indataRow, SalesPlanResources.colLOC);

                insRow[SalesPlanResources.colColor] = EditStringColumn(indataRow, SalesPlanResources.colColor);
                insRow[SalesPlanResources.colSort] = EditStringColumn(indataRow, SalesPlanResources.colSort);
                insRow[SalesPlanResources.colRegion] = EditStringColumn(indataRow, SalesPlanResources.colRegion);

                insRow[SalesPlanResources.colspecie] = EditStringColumn(indataRow, SalesPlanResources.colspecie);

                insRow[SalesPlanResources.colthick] = EditStringColumn(indataRow, SalesPlanResources.colthick);
                insRow[SalesPlanResources.colgrade] = EditStringColumn(indataRow, SalesPlanResources.colgrade);
                insRow[SalesPlanResources.colTYPE] = RowType;
                insRow[SalesPlanResources.colDETAIL] = EditStringColumn(indataRow, SalesPlanResources.colDETAIL);
                insRow[SalesPlanResources.colORDNUM] = EditStringColumn(indataRow, SalesPlanResources.colORDNUM);
                insRow[SalesPlanResources.colNoPrint] = EditStringColumn(indataRow, SalesPlanResources.colNoPrint);
                insRow[SalesPlanResources.colPRODUCT] = EditStringColumn(indataRow, SalesPlanResources.colPRODUCT);

                double fldW00 = EditNumColumn(indataRow, SalesPlanResources.colW00);
                double fldW01 = EditNumColumn(indataRow, SalesPlanResources.colW01);
                double fldW02 = EditNumColumn(indataRow, SalesPlanResources.colW02);
                double fldW03 = EditNumColumn(indataRow, SalesPlanResources.colW03);
                double fldW04 = EditNumColumn(indataRow, SalesPlanResources.colW04);
                double fldW05 = EditNumColumn(indataRow, SalesPlanResources.colW05);
                double fldW06 = EditNumColumn(indataRow, SalesPlanResources.colW06);
                double fldW07 = EditNumColumn(indataRow, SalesPlanResources.colW07);
                double fldW08 = EditNumColumn(indataRow, SalesPlanResources.colW08);
                double fldW09 = EditNumColumn(indataRow, SalesPlanResources.colW09);
                double fldW10 = EditNumColumn(indataRow, SalesPlanResources.colW10);
                double fldW11 = EditNumColumn(indataRow, SalesPlanResources.colW11);
                double fldW12 = EditNumColumn(indataRow, SalesPlanResources.colW12);
                double fldW13 = EditNumColumn(indataRow, SalesPlanResources.colW13);

                double fldTotal = fldW00 + fldW01 + fldW02 + fldW03 + fldW04 + fldW05 + fldW06 + fldW07 + fldW08 + fldW09 + fldW10 + fldW11 + fldW12 + fldW13;
                
                insRow[SalesPlanResources.colW00] = fldW00;
                insRow[SalesPlanResources.colW01] = fldW01;
                insRow[SalesPlanResources.colW02] = fldW02;
                insRow[SalesPlanResources.colW03] = fldW03;
                insRow[SalesPlanResources.colW04] = fldW04;
                insRow[SalesPlanResources.colW05] = fldW05;
                insRow[SalesPlanResources.colW06] = fldW06;
                insRow[SalesPlanResources.colW07] = fldW07;
                insRow[SalesPlanResources.colW08] = fldW08;
                insRow[SalesPlanResources.colW09] = fldW09;
                insRow[SalesPlanResources.colW10] = fldW10;
                insRow[SalesPlanResources.colW11] = fldW11;
                insRow[SalesPlanResources.colW12] = fldW12;
                insRow[SalesPlanResources.colW13] = fldW13;


                insRow[SalesPlanResources.colTotal] = fldTotal;

                insRow[SalesPlanResources.colP13] = EditNumColumn(indataRow, SalesPlanResources.colP13);
                insRow[SalesPlanResources.colP8] = EditNumColumn(indataRow, SalesPlanResources.colP8);
                insRow[SalesPlanResources.colP4] = EditNumColumn(indataRow, SalesPlanResources.colP4);

                insRow[SalesPlanResources.colPAST] = EditNumColumn(indataRow, SalesPlanResources.colPAST);
                insRow[SalesPlanResources.colINV] = EditNumColumn(indataRow, SalesPlanResources.colINV);

                if (chkShowCust.Checked == true)
                {
                    if (string.Compare(RowType, SalesPlanResources.rowTypeSales) == 0 ||
                        chkHolds.Checked == true && string.Compare(RowType, SalesPlanResources.rowTypeOrdHolds) == 0 ||
                        chkHist.Checked == true && string.Compare(RowType, SalesPlanResources.rowTypeOrdHist) == 0)
                    {
                        string custName = EditStringColumn(indataRow, SalesPlanResources.colCUSTOMER);
											int Idx = 0;
						if (custName != "")
						{
							Idx = custName.IndexOf("|");
						}

						insRow[SalesPlanResources.colCUSTOMER] = Idx > 0 ? custName.Substring(0, Idx - 1) : custName;

                        insRow[SalesPlanResources.colMGR] = EditStringColumn(indataRow, SalesPlanResources.colMGR);
                    }
                    else
                    {
                        insRow[SalesPlanResources.colCUSTOMER] = string.Empty;
                        insRow[SalesPlanResources.colMGR] = string.Empty;
                    }
                }
                else
                {
                    insRow[SalesPlanResources.colCUSTOMER] = string.Empty;
                    insRow[SalesPlanResources.colMGR] = string.Empty;
                }

                tblReport.Rows.Add(insRow);
            }
        }

        private string EditStringColumn(DataRow readData, string colName)
        {
            if (readData.IsNull(colName))
            {
                return string.Empty;
            }

            return readData[colName].ToString();
        }

        private double EditNumColumn(DataRow readData, string colName)
        {
            if (readData.IsNull(colName))
            {
                return 0;
            }

            double retVal = 0;

            if (!double.TryParse(readData[colName].ToString(), out retVal))
            {
                return 0;
            }

            return retVal;
        }
        
        private DataTable GetProTypeCodeList()
        {
            DataTable tmp = new DataTable();

            tmp.Columns.Add(new DataColumn(SalesPlanResources.colPROTYPE, typeof(string)));

            tmp = DataObj.FillSalesTableSegments(SalesPlanResources.SpLoadProtypes);

            return tmp;
        }

        #endregion


        #region SortGroup_AccessoryFunctions

        private int SelectedItem(ListBox screenList)
        {
            return screenList.SelectedIndex;
        }

        private int SelectedItem(CheckBoxList screenList)
        {
            return screenList.SelectedIndex;
        }

        private bool lstColsAvail_Selected()
        {
            return SelectedItem(lstColsAvail) > -1 ? true : false;
        }

        private bool lstColsSort_Selected()
        {
            return SelectedItem(lstColsSort) > -1 ? true : false;
        }

        private bool lstColsSort_HasContents()
        {
            if (lstColsSort.Items.Count <= 0)
            {
                return false;
            }

            return true;
        }

        private bool lstColsAvail_HasContents()
        {
            if (lstColsAvail.Items.Count <= 0)
            {
                return false;
            }

            return true;
        }

        private string lstColsAvail_SubstractItem()
        {
            int selIdx = SelectedItem(lstColsAvail);

            if (selIdx == -1)
            {
                return string.Empty;
            }

            string retValue = lstColsAvail.Items[selIdx].Value.ToString();

            lstColsAvail.Items.RemoveAt(selIdx);
            
            return retValue;
        }

        private void lstColsAvail_AddItem(string newItem)
        {
            if (!string.IsNullOrWhiteSpace(newItem))
            {
                lstColsAvail.Items.Insert(0, newItem);
            }
        }

        private string lstColsSort_SubstractItem()
        {
            int selIdx = SelectedItem(lstColsSort);

            if (selIdx == -1)
            {
                return string.Empty;
            }

            System.Web.UI.WebControls.ListItem SortItem = new System.Web.UI.WebControls.ListItem();

            SortItem = lstColsSort.Items[selIdx];

            if (lstColsSort.Items.Count > 1)
            {
                lstColsSort.Items.RemoveAt(selIdx);

                return SortItem.Text.ToString();
            }
            else
            {
                errMsg.Text = SalesPlanResources.sortcolsError;
                return string.Empty;
            }
        }

        private void lstColsSort_AddItem(string newItem)
        {
            System.Web.UI.WebControls.ListItem SortItem = new System.Web.UI.WebControls.ListItem();
            SortItem.Text = newItem;
            SortItem.Value = newItem;
            SortItem.Selected = false;

            lstColsSort.Items.Add(SortItem);
        }

        private bool MoveItem(int direction)
        {
            int selRow = SelectedItem(lstColsSort);

            int newRow = selRow + direction;

            if (newRow < 0 || newRow >= lstColsSort.Items.Count)
            {
                return false;
            }

            System.Web.UI.WebControls.ListItem selItem = lstColsSort.Items[selRow];

            lstColsSort.Items.RemoveAt(selRow);

            lstColsSort.Items.Insert(newRow, selItem);

            lstColsSort.SelectedIndex = newRow;

            return true;
        }

        #endregion


        #region CheckBoxList_AccessoryFunctions
        
        private bool ValidateCheckLists(CheckBoxList listValues, string errMessage)
        {
            if (listValues.Items.Count == 0)
            {
                return false;
            }

            int selIdx = listValues.SelectedIndex;
            if (selIdx < 0)
            {
                btnRefreshData.Enabled = true;
                return true;
            }

            int counter = 0;
            
            for (int idx = 0; idx < listValues.Items.Count; idx++)
            {
                if (listValues.Items[idx].Selected == true)
                {
                    counter++;
                }
            }

            if (counter == 0)
            {
                errMsg.Text = errMessage;
                return false;
            }

            btnRefreshData.Enabled = true;
            return true;
        }

        private void CheckListReset(CheckBoxList listValues, Button screenButton)
        {
            string currText = string.Empty;
            currText = screenButton.ToolTip.ToString();

            if (string.IsNullOrWhiteSpace(currText))
            {
                currText = SalesPlanResources.btnTextSelectAll;
            }

            if (string.Compare(currText, SalesPlanResources.btnTextSelectAll) == 0)
            {
                selectAllThingsInList(listValues);
                screenButton.ToolTip = SalesPlanResources.btnTextUnselectAll;
                return;
            }
            
            if (string.Compare(currText, SalesPlanResources.btnTextUnselectAll) == 0)
            {
                unselectEverythingInList(listValues);
                screenButton.ToolTip = SalesPlanResources.btnTextSelectAll;
                return;
            }
      
        }

        #endregion


        #region Button_AccessoryFuntions

        private void CleanUpAfterFilterReset()
        {
            reFilterResultsArray();
            if (rsltRows != null && rsltRows.Length > 0)
            {
                FilterTypeList();
                BindTableBasedPickList(lstTypeChk, typeRows, SalesPlanResources.colTYPE, false);

                FilterMgrList();
                BindTableBasedPickList(lstMgrChk, mgrRows, SalesPlanResources.colMGR, false);

                FilterCustList();
                BindTableBasedPickList(lstCustChk, custRows, SalesPlanResources.colCUSTOMER, false);

                FilterProductList();
                BindTableBasedPickList(lstProdChk, prodRows, SalesPlanResources.colCode, SalesPlanResources.colDesc, false);
            }

            reset_all_Header_Buttons();
        }

        private void unselectEverythingInList(CheckBoxList inList)
        {
            for (int i = 0; i < inList.Items.Count; i++)
            {
                inList.Items[i].Selected = false;
            }
        }

        private void selectAllThingsInList(CheckBoxList inList)
        {
            for (int i = 0; i < inList.Items.Count; i++)
            {
                inList.Items[i].Selected = true;
            }
        }

        private void reset_all_Header_Buttons()
        {
            setButtonsEnableStatus(btnSpecie, lstSpeciesChk);
            setButtonsEnableStatus(btnThick, lstThickChk);
            setButtonsEnableStatus(btnGrade, lstGradeChk);
            setButtonsEnableStatus(btnColor, lstColorChk);
            setButtonsEnableStatus(btnSort, lstSortChk);
            setButtonsEnableStatus(btnType, lstTypeChk);
            setButtonsEnableStatus(btnMgr, lstMgrChk);
            setButtonsEnableStatus(btnCust, lstCustChk);
            setButtonsEnableStatus(btnNoPrint, lstNoPrintChk);
            setButtonsEnableStatus(btnProd, lstProdChk);
        }

        private void setButtonsEnableStatus(Button screenButton, CheckBoxList AssociatedList)
        {
            if (AssociatedList.Items.Count == 0)
            {
                screenButton.Enabled = false;
                return;
            }

            if (AssociatedList.Items.Count > 1)
            {
                screenButton.Enabled = true;
                return;
            }

            if(string.Compare(AssociatedList.Items[0].Text, SalesPlanResources.blankVal) == 0)
            {
                screenButton.Enabled = false;
                return;
            }

            screenButton.Enabled = true;
        }

        #endregion


        #region DataFiltering_Functions

        private void reFilterResultsArray()
        {
            // empty the output datarow array 
            rsltRows = null;

            // grab the copy of the report datatable from the session 
            // variable so dont need to go back to the server for a refilter operation
            tblReport = (DataTable)Session[strReport];
            
            // if the table is null then the data hasnt been loaded yet so skip the filter process
            if (tblReport == null)
            {
                return;
            }

            string filterBy = CreateFilterFromScreen();

            if (string.IsNullOrWhiteSpace(filterBy))
            {
                rsltRows = tblReport.Select();
                return;
            }

            DataView selView = new DataView(tblReport);
            selView.RowFilter = null;
            selView.RowFilter = filterBy;
            DataTable tmpOut = selView.ToTable();
            
            rsltRows = tmpOut.Select();

            Session[strFiltered] = rsltRows;
            selView = null;
        }
        
        private void FilterLocationList()
        {
            locRows = null;

            // first get list of selected regions
            string regionFilterPart = CreateFilterFromListBox(SalesPlanResources.colRegion, lstRegionChk);
            if (!string.IsNullOrWhiteSpace(regionFilterPart))
            {
                DataTable tmp1 = (DataTable)Session[strLocRegions];
                locRegionRows = tmp1.Select(regionFilterPart);
                tmp1 = null;
            }
            else
            {

                DataTable tmp1 = (DataTable)Session[strLocRegions];
                locRegionRows = tmp1.Select();
                tmp1 = null;
            }

            foreach(DataRow datRow in locRegionRows)
            {
                for (int idx = 0; idx < lstLocChk.Items.Count; idx ++)
                {
                    if (lstLocChk.Items[idx].Value == datRow[SalesPlanResources.colLOC].ToString())
                    {
                        lstLocChk.Items[idx].Selected = true;
                        break;
                    }
                }
            }
  
            string locFilterPart = CreateFilterFromListBox(SalesPlanResources.colCode, lstLocChk);
            DataTable tmp = (DataTable)Session[strLocations];
            if (tmp != null)
            {
                locRows = tmp.Select(locFilterPart);
            }
            tmp = null;
        }

        private void FilterSpecieList()
        {
            specieRows = null;

            StringBuilder filterWork = new StringBuilder(4000);
            bool hasContents = false;

            string regionFilterPart = CreateFilterFromListBox(SalesPlanResources.colRegion, lstRegionChk);
            if (!string.IsNullOrWhiteSpace(regionFilterPart))
            {
                filterWork.Append(regionFilterPart);
                hasContents = true;
            }

            string locFilterPart = CreateFilterFromListBox(SalesPlanResources.colLOC, lstLocChk);
            if (!string.IsNullOrWhiteSpace(locFilterPart))
            {
                filterWork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterWork.Append(locFilterPart);
                hasContents = true;
            }

            string specieFilterPart = CreateFilterFromListBox(SalesPlanResources.colspecie, lstSpeciesChk);
            if (!string.IsNullOrWhiteSpace(specieFilterPart))
            {
                filterWork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterWork.Append(specieFilterPart);
                hasContents = true;
            }

            DataTable tmp = (DataTable)Session[strSpecies];
            if (tmp != null)
            {
                specieRows = tmp.Select(filterWork.ToString());
            }
            tmp = null;
        }

        private void FilterThickList()
        {
            thickRows = null;

            StringBuilder filterWork = new StringBuilder(4000);
            bool hasContents = false;

            string regionFilterPart = CreateFilterFromListBox(SalesPlanResources.colRegion, lstRegionChk);
            if (!string.IsNullOrWhiteSpace(regionFilterPart))
            {
                filterWork.Append(regionFilterPart);
                hasContents = true;
            }

            string locFilterPart = CreateFilterFromListBox(SalesPlanResources.colLOC, lstLocChk);
            if (!string.IsNullOrWhiteSpace(locFilterPart))
            {
                filterWork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterWork.Append(locFilterPart);
                hasContents = true;
            }

            string specieFilterPart = CreateFilterFromListBox(SalesPlanResources.colspecie, lstSpeciesChk);
            if (!string.IsNullOrWhiteSpace(specieFilterPart))
            {
                filterWork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterWork.Append(specieFilterPart);
                hasContents = true;
            }

            string thickFilterPart = CreateFilterFromListBox(SalesPlanResources.colthick, lstThickChk);
            if (!string.IsNullOrWhiteSpace(thickFilterPart))
            {
                filterWork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterWork.Append(thickFilterPart);
                hasContents = true;
            }

            DataTable tmp = (DataTable)Session[strThickness];
            if (tmp != null)
            {
                thickRows = tmp.Select(filterWork.ToString());
            }
            tmp = null;
        }

        private void FilterGradeList()
        {
            gradeRows = null;

            StringBuilder filterWork = new StringBuilder(4000);
            bool hasContents = false;

            string regionFilterPart = CreateFilterFromListBox(SalesPlanResources.colRegion, lstRegionChk);
            if (!string.IsNullOrWhiteSpace(regionFilterPart))
            {
                filterWork.Append(regionFilterPart);
                hasContents = true;
            }

            string locFilterPart = CreateFilterFromListBox(SalesPlanResources.colLOC, lstLocChk);
            if (!string.IsNullOrWhiteSpace(locFilterPart))
            {
                filterWork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterWork.Append(locFilterPart);
                hasContents = true;
            }

            string specieFilterPart = CreateFilterFromListBox(SalesPlanResources.colspecie, lstSpeciesChk);
            if (!string.IsNullOrWhiteSpace(specieFilterPart))
            {
                filterWork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterWork.Append(specieFilterPart);
                hasContents = true;
            }

            DataTable tmp = (DataTable)Session[strGrade];
            if (tmp != null)
            {
                gradeRows = tmp.Select(filterWork.ToString());
            }
            tmp = null;
        }

        private void FilterSortList()
        {
            sortRows = null;

            StringBuilder filterWork = new StringBuilder(4000);
            bool hasContents = false;

            string regionFilterPart = CreateFilterFromListBox(SalesPlanResources.colRegion, lstRegionChk);
            if (!string.IsNullOrWhiteSpace(regionFilterPart))
            {
                filterWork.Append(regionFilterPart);
                hasContents = true;
            }

            string locFilterPart = CreateFilterFromListBox(SalesPlanResources.colLOC, lstLocChk);
            if (!string.IsNullOrWhiteSpace(locFilterPart))
            {
                filterWork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterWork.Append(locFilterPart);
                hasContents = true;
            }

            string specieFilterPart = CreateFilterFromListBox(SalesPlanResources.colspecie, lstSpeciesChk);
            if (!string.IsNullOrWhiteSpace(specieFilterPart))
            {
                filterWork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterWork.Append(specieFilterPart);
                hasContents = true;
            }

            string sortFilterPart = CreateFilterFromListBox(SalesPlanResources.colSort, lstSortChk);
            if (!string.IsNullOrWhiteSpace(sortFilterPart))
            {
                filterWork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterWork.Append(sortFilterPart);
                hasContents = true;
            }

            DataTable tmp = (DataTable)Session[strSort];
            if (tmp != null)
            {
                sortRows = tmp.Select(filterWork.ToString());
            }
            tmp = null;
        }

        private void FilterColorList()
        {
            colorRows = null;

            StringBuilder filterWork = new StringBuilder(4000);
            bool hasContents = false;

            string regionFilterPart = CreateFilterFromListBox(SalesPlanResources.colRegion, lstRegionChk);
            if (!string.IsNullOrWhiteSpace(regionFilterPart))
            {
                filterWork.Append(regionFilterPart);
                hasContents = true;
            }

            string locFilterPart = CreateFilterFromListBox(SalesPlanResources.colLOC, lstLocChk);
            if (!string.IsNullOrWhiteSpace(locFilterPart))
            {
                filterWork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterWork.Append(locFilterPart);
                hasContents = true;
            }

            string specieFilterPart = CreateFilterFromListBox(SalesPlanResources.colspecie, lstSpeciesChk);
            if (!string.IsNullOrWhiteSpace(specieFilterPart))
            {
                filterWork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterWork.Append(specieFilterPart);
                hasContents = true;
            }

            string colorFilterPart = CreateFilterFromListBox(SalesPlanResources.colColor, lstColorChk);
            if (!string.IsNullOrWhiteSpace(colorFilterPart))
            {
                filterWork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterWork.Append(colorFilterPart);
                hasContents = true;
            }

            DataTable tmp = (DataTable)Session[strColor];
            if (tmp != null)
            {
                colorRows = tmp.Select(filterWork.ToString());
            }
            tmp = null;
        }

        private void FilterNoPrintList()
        {
            noPrintRows = null;

            StringBuilder filterWork = new StringBuilder(4000);
            bool hasContents = false;

            string regionFilterPart = CreateFilterFromListBox(SalesPlanResources.colRegion, lstRegionChk);
            if (!string.IsNullOrWhiteSpace(regionFilterPart))
            {
                filterWork.Append(regionFilterPart);
                hasContents = true;
            }

            string locFilterPart = CreateFilterFromListBox(SalesPlanResources.colLOC, lstLocChk);
            if (!string.IsNullOrWhiteSpace(locFilterPart))
            {
                filterWork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterWork.Append(locFilterPart);
                hasContents = true;
            }

            string specieFilterPart = CreateFilterFromListBox(SalesPlanResources.colspecie, lstSpeciesChk);
            if (!string.IsNullOrWhiteSpace(specieFilterPart))
            {
                filterWork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterWork.Append(specieFilterPart);
                hasContents = true;
            }
                        
            string noPrintFilterPart = CreateFilterFromListBox(SalesPlanResources.colNoPrint, lstNoPrintChk);
            if (!string.IsNullOrWhiteSpace(noPrintFilterPart))
            {
                filterWork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterWork.Append(noPrintFilterPart);
                hasContents = true;
            }

            DataTable tmp = (DataTable)Session[strNoPrint];
            if (tmp != null)
            {
                noPrintRows = tmp.Select(filterWork.ToString());
            }
            tmp = null;
        }

        private string FilterToDetail()
        { 
            StringBuilder filterWork = new StringBuilder(8000);
            bool hasContents = false;

            string regionFilterPart = CreateFilterFromListBox(SalesPlanResources.colRegion, lstRegionChk);
            if (!string.IsNullOrWhiteSpace(regionFilterPart))
            {
                filterWork.Append(regionFilterPart);
                hasContents = true;
            }

            string locFilterPart = CreateFilterFromListBox(SalesPlanResources.colLOC, lstLocChk);
            if (!string.IsNullOrWhiteSpace(locFilterPart))
            {
                filterWork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterWork.Append(locFilterPart);
                hasContents = true;
            }

            string specieFilterPart = CreateFilterFromListBox(SalesPlanResources.colspecie, lstSpeciesChk);
            if (!string.IsNullOrWhiteSpace(specieFilterPart))
            {
                filterWork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterWork.Append(specieFilterPart);
                hasContents = true;
            }

            string colorFilterPart = CreateFilterFromListBox(SalesPlanResources.colColor, lstColorChk);
            if (!string.IsNullOrWhiteSpace(colorFilterPart))
            {
                filterWork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterWork.Append(colorFilterPart);
                hasContents = true;
            }

            string thickFilterPart = CreateFilterFromListBox(SalesPlanResources.colthick, lstThickChk);
            if (!string.IsNullOrWhiteSpace(thickFilterPart))
            {
                filterWork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterWork.Append(thickFilterPart);
                hasContents = true;
            }

            string gradeFilterPart = CreateFilterFromListBox(SalesPlanResources.colgrade, lstGradeChk);
            if (!string.IsNullOrWhiteSpace(gradeFilterPart))
            {
                filterWork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterWork.Append(gradeFilterPart);
                hasContents = true;
            }

            string sortFilterPart = CreateFilterFromListBox(SalesPlanResources.colSort, lstSortChk);
            if (!string.IsNullOrWhiteSpace(sortFilterPart))
            {
                filterWork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterWork.Append(sortFilterPart);
                hasContents = true;
            }
            
            string noPrintFilterPart = CreateFilterFromListBox(SalesPlanResources.colNoPrint, lstNoPrintChk);
            if (!string.IsNullOrWhiteSpace(noPrintFilterPart))
            {
                filterWork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterWork.Append(noPrintFilterPart);
                hasContents = true;
            }

            return filterWork.ToString();
        }

        private DataRow[] CommonBigFilterSet(string colName)
        {
            DataRow[] outRows = null;
           
            DataRow[] tmpRows = (DataRow[])Session[strFiltered];
            if (tmpRows == null || tmpRows.Length == 0)
            {
                return outRows;
            }

            try
            {
                DataTable tmpIn = tmpRows.CopyToDataTable();
                DataView selView = new DataView(tmpIn);
                selView.RowFilter = null;
              
                outRows = selView.ToTable(true, colName).Select();
                selView = null;
            }
            catch (Exception e)
            {
                return outRows;
            }

            return outRows;
        }

        private void FilterCustList()
        {
            custRows = null;

            custRows = CommonBigFilterSet(SalesPlanResources.colCUSTOMER);
        }

        private void FilterProductList()
        {
            prodRows = null;
            DataTable prods = (DataTable)Session[strProducts];
            if (prods == null)
            {
                return;
            }

            DataRow[] tmpRows = CommonBigFilterSet(SalesPlanResources.colPRODUCT);

            DataTable tmpAll = tmpRows.CopyToDataTable();

            var prodList = from prod in prods.AsEnumerable()
                           join tmp in tmpAll.AsEnumerable()
                                on prod.Field<string>(SalesPlanResources.colCode) equals
                                    tmp.Field<string>(SalesPlanResources.colPRODUCT)
                           select new
                           {
                               Code = tmp.Field<string>(SalesPlanResources.colPRODUCT),
                               Desc = prod.Field<string>(SalesPlanResources.colDesc)
                           };

            DataTable tmpRes = new DataTable();
            DataColumn colCode = new DataColumn(SalesPlanResources.colCode, typeof(string));
            DataColumn colDesc = new DataColumn(SalesPlanResources.colDesc, typeof(string));

            tmpRes.Columns.Add(colCode);
            tmpRes.Columns.Add(colDesc);

            foreach (var prodItm in prodList)
            {
                DataRow outRow = tmpRes.NewRow();

                outRow[SalesPlanResources.colCode] = prodItm.Code;
                outRow[SalesPlanResources.colDesc] = prodItm.Desc;

                tmpRes.Rows.Add(outRow);
            }
            
            prodRows = tmpRes.Select();
        }

        private void FilterMgrList()
        {
            mgrRows = null;

            mgrRows = CommonBigFilterSet(SalesPlanResources.colMGR);
        }

        private void FilterTypeList()
        {
            typeRows = null;
            
            typeRows = CommonBigFilterSet(SalesPlanResources.colTYPE);
        }
        
        private string CreateFilterFromScreen()
        {
            // this just basically steps thru all the filtering options
            // generates a filter string as necessary and keeps appending it
            /// until done when it returns the completed filter string
            StringBuilder filterwork = new StringBuilder(8000);
            bool hasContents = false;

            if (string.Compare(drpMGD.SelectedItem.Value.ToString(), SalesPlanResources.wordBoth) != 0)
            {
                filterwork.Append(string.Format(SalesPlanResources.filterString, SalesPlanResources.colMGD, drpMGD.SelectedItem.Value.ToString()));
                hasContents = true;
            }

            string locFilterPart = CreateFilterFromListBox(SalesPlanResources.colLOC, lstLocChk);
            if (!string.IsNullOrWhiteSpace(locFilterPart))
            {
                filterwork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterwork.Append(locFilterPart);
                hasContents = true;
            }

            string speciesFilterPart = CreateFilterFromListBox(SalesPlanResources.colspecie, lstSpeciesChk);
            if (!string.IsNullOrWhiteSpace(speciesFilterPart))
            {
                filterwork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterwork.Append(speciesFilterPart);
                hasContents = true;
            }

            string thickFilterPart = CreateFilterFromListBox(SalesPlanResources.colthick, lstThickChk);
            if (!string.IsNullOrWhiteSpace(thickFilterPart))
            {
                filterwork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterwork.Append(thickFilterPart);
                hasContents = true;
            }

            string gradeFilterPart = CreateFilterFromListBox(SalesPlanResources.colgrade, lstGradeChk);
            if (!string.IsNullOrWhiteSpace(gradeFilterPart))
            {
                filterwork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterwork.Append(gradeFilterPart);
                hasContents = true;
            }

            string typeFilterPart = CreateFilterFromListBox(SalesPlanResources.colTYPE, lstTypeChk);
            if (!string.IsNullOrWhiteSpace(typeFilterPart))
            {
                filterwork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterwork.Append(typeFilterPart);
                hasContents = true;
            }

            string custFilterPart = CreateFilterFromListBox(SalesPlanResources.colCUSTOMER, lstCustChk);
            if (!string.IsNullOrWhiteSpace(custFilterPart))
            {
                filterwork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterwork.Append(custFilterPart);
                hasContents = true;
            }

            string mgrFilterPart = CreateFilterFromListBox(SalesPlanResources.colMGR, lstMgrChk);
            if (!string.IsNullOrWhiteSpace(mgrFilterPart))
            {
                filterwork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterwork.Append(mgrFilterPart);
                hasContents = true;
            }

            string regionFilterPart = CreateFilterFromListBox(SalesPlanResources.colRegion, lstRegionChk);
            if (!string.IsNullOrWhiteSpace(regionFilterPart))
            {
                filterwork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterwork.Append(regionFilterPart);
                hasContents = true;
            }

            string colorFilterPart = CreateFilterFromListBox(SalesPlanResources.colColor, lstColorChk);
            if (!string.IsNullOrWhiteSpace(colorFilterPart))
            {
                filterwork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterwork.Append(colorFilterPart);
                hasContents = true;
            }

            string sortFilterPart = CreateFilterFromListBox(SalesPlanResources.colSort, lstSortChk);
            if (!string.IsNullOrWhiteSpace(sortFilterPart))
            {
                filterwork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterwork.Append(sortFilterPart);
                hasContents = true;
            }
            
            string noPrintFilterPart = CreateFilterFromListBox(SalesPlanResources.colNoPrint, lstNoPrintChk);
            if (!string.IsNullOrWhiteSpace(noPrintFilterPart))
            {
                filterwork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterwork.Append(noPrintFilterPart);
                hasContents = true;
            }

            string productFilterPart = CreateFilterFromListBox(SalesPlanResources.colPRODUCT, lstProdChk);
            if (!string.IsNullOrWhiteSpace(productFilterPart))
            {
                filterwork.Append((hasContents) ? SalesPlanResources.filterANDConnector : string.Empty);
                filterwork.Append(productFilterPart);
                hasContents = true;
            }

            return filterwork.ToString();
        }

        private string CreateFilterFromListBox(string columnName, CheckBoxList ListValues)
        {
            StringBuilder filterwork = new StringBuilder(2000);

            // if no items in the list of values to filter from the exit
            if (ListValues.Items.Count == 0)
            {
                return string.Empty;
            }

            bool hasContents = false;
            bool needsOr = false;

            // loop thru each item on the list looking for any that are tagged as selected
            for (int i = 0; i < ListValues.Items.Count; i++)
            {
                if (ListValues.Items[i].Selected == true)
                {
                    // if nothing has been added to the filter yet then start with an open paren
                    if (!hasContents)
                    {
                        hasContents = true;
                        filterwork.Append(SalesPlanResources.filterOpenParen);
                    }

                    // if there is a prior filter value for this list add an OR between this value and it
                    if (needsOr)
                    {
                        filterwork.Append(SalesPlanResources.filterORConnector);
                    }
                    
                    filterwork.Append(string.Format(SalesPlanResources.filterString, columnName, ListValues.Items[i].Value.ToString()));
                   
                    needsOr = true;
                }
            }

            // if there was anything to filter on then close the parens
            if (hasContents)
            {
                filterwork.Append(SalesPlanResources.filterCloseParen);
            }

            return filterwork.ToString();
        }

        private string CreateFilterForProType()
        {
            return string.Format(SalesPlanResources.filterString, SalesPlanResources.colPROTYPE, drpProTypes.SelectedValue.ToString());
        }
        
        #endregion


        #region CheckBoxList_PopulationFunctions

        private void BindTableBasedPickList(CheckBoxList screenList, DataRow[] valueList, string valName, bool blanksAllowed)
        {
            if (valueList == null)
            {
                return;
            }

            screenList.Items.Clear();
            if (valueList.Length == 0)
            {
                return;
            }

            string sortBy = string.Concat(valName, SalesPlanResources.sortDir);
            DataView distinctVals = new DataView(valueList.CopyToDataTable());
            distinctVals.Sort = sortBy;
            DataTable tmp = distinctVals.ToTable(true, valName);

            if (blanksAllowed)
            {
                System.Web.UI.WebControls.ListItem blankItem = new System.Web.UI.WebControls.ListItem();

                blankItem.Text = SalesPlanResources.blankVal;
                blankItem.Value = string.Empty;
                screenList.Items.Add(blankItem);
            }

            foreach (DataRow inRow in tmp.Rows)
            {
                string dataVal = inRow[valName].ToString();

                if (string.IsNullOrWhiteSpace(dataVal))
                {
                    continue;
                }

                System.Web.UI.WebControls.ListItem lstItem = new System.Web.UI.WebControls.ListItem();

                lstItem.Text = dataVal;
                lstItem.Value = dataVal;

                screenList.Items.Add(lstItem);
            }

            tmp = null;

            screenList.Enabled = true;
        }

        private void BindTableBasedPickList(CheckBoxList screenList, DataRow[] valueList, string valName, string txtName, bool blanksAllowed)
        {
            if (valueList == null)
            {
                return;
            }

            screenList.Items.Clear();
            if (valueList.Length == 0)
            {
                return;
            }
            
            string sortBy = string.Concat(valName, SalesPlanResources.sortDir, SalesPlanResources.comma, txtName, SalesPlanResources.sortDir);
            DataView distinctVals = new DataView(valueList.CopyToDataTable());
            distinctVals.Sort = sortBy;
            DataTable tmp = distinctVals.ToTable(true, new string[] { valName, txtName });
            
            if (blanksAllowed)
            {
                System.Web.UI.WebControls.ListItem blankItem = new System.Web.UI.WebControls.ListItem();

                blankItem.Text = SalesPlanResources.blankVal;
                blankItem.Value = string.Empty;
                screenList.Items.Add(blankItem);
            }

            foreach (DataRow inRow in tmp.Rows)
            {
                string dataVal = inRow[valName].ToString();

                if (string.IsNullOrWhiteSpace(dataVal))
                {
                    continue;
                }

                System.Web.UI.WebControls.ListItem lstItem = new System.Web.UI.WebControls.ListItem();

                lstItem.Text = inRow[txtName].ToString();
                lstItem.Value = dataVal;

                screenList.Items.Add(lstItem);
            }

            tmp = null;

            screenList.Enabled = true;
        }


        #endregion


        #region ColumnLists_PopulationFunctions

        private void WherePutCustomer(bool belongsInSort)
        {
            if (belongsInSort)
            {
                if (!ContainedInCheckList((CheckBoxList)lstColsSort, SalesPlanResources.colMGR))
                {
                    lstColsSort.Items.Add(new System.Web.UI.WebControls.ListItem { Text = SalesPlanResources.colMGR, Value = SalesPlanResources.colMGR });
                    if (ContainedInCheckList((ListBox)lstColsAvail, SalesPlanResources.colMGR))
                    {
                        lstColsAvail.Items.Remove(SalesPlanResources.colMGR);
                    }
                }

                if (!ContainedInCheckList((CheckBoxList)lstColsSort, SalesPlanResources.colCUSTOMER))
                {
                    lstColsSort.Items.Add(new System.Web.UI.WebControls.ListItem { Text = SalesPlanResources.colCUSTOMER, Value = SalesPlanResources.colCUSTOMER });
                    if (ContainedInCheckList((ListBox)lstColsAvail, SalesPlanResources.colCUSTOMER))
                    {
                        lstColsAvail.Items.Remove(SalesPlanResources.colCUSTOMER);
                    }
                }

                return;
            }
            else
            {
                if (ContainedInCheckList((CheckBoxList)lstColsSort, SalesPlanResources.colMGR))
                {
                    lstColsSort.Items.Remove(new System.Web.UI.WebControls.ListItem { Text = SalesPlanResources.colMGR, Value = SalesPlanResources.colMGR });
                    if (!ContainedInCheckList((ListBox)lstColsAvail, SalesPlanResources.colMGR))
                    {
                        lstColsAvail.Items.Add(new System.Web.UI.WebControls.ListItem { Text = SalesPlanResources.colMGR, Value = SalesPlanResources.colMGR });
                    }
                }
                
                if (ContainedInCheckList((CheckBoxList)lstColsSort, SalesPlanResources.colCUSTOMER))
                {
                    lstColsSort.Items.Remove(new System.Web.UI.WebControls.ListItem { Text = SalesPlanResources.colCUSTOMER, Value = SalesPlanResources.colCUSTOMER });
                    if (!ContainedInCheckList((ListBox)lstColsAvail, SalesPlanResources.colCUSTOMER))
                    {
                        lstColsAvail.Items.Add(new System.Web.UI.WebControls.ListItem { Text = SalesPlanResources.colCUSTOMER, Value = SalesPlanResources.colCUSTOMER });
                    }
                }
            }
        }

        private bool ContainedInCheckList(CheckBoxList listItems, string colName)
        {
            foreach(System.Web.UI.WebControls.ListItem chkItem in listItems.Items)
            {
                if (string.Compare(chkItem.Value.ToString(), colName) ==0)
                {
                    return true;
                }
            }
            
            return false;
        }

        private bool ContainedInCheckList(ListBox listItems, string colName)
        {
            foreach (System.Web.UI.WebControls.ListItem lstItem in listItems.Items)
            {
                if (string.Compare(lstItem.Value.ToString(), colName) == 0)
                {
                    return true;
                }
            }

            return false;
        }

        private void CreateMathColumns(string sessionVarName)
        {
           //list of columns that drive accumulator processes
            mathCols.Add(SalesPlanResources.colP13, string.Empty);
            mathCols.Add(SalesPlanResources.colP8, string.Empty);
            mathCols.Add(SalesPlanResources.colP4, string.Empty);
            mathCols.Add(SalesPlanResources.colPAST, string.Empty);
            mathCols.Add(SalesPlanResources.colINV, string.Empty);

            mathCols.Add(SalesPlanResources.colW00, SalesPlanResources.colTotal);
            mathCols.Add(SalesPlanResources.colW01, SalesPlanResources.colTotal);
            mathCols.Add(SalesPlanResources.colW02, SalesPlanResources.colTotal);
            mathCols.Add(SalesPlanResources.colW03, SalesPlanResources.colTotal);
            mathCols.Add(SalesPlanResources.colW04, SalesPlanResources.colTotal);
            mathCols.Add(SalesPlanResources.colW05, SalesPlanResources.colTotal);
            mathCols.Add(SalesPlanResources.colW06, SalesPlanResources.colTotal);
            mathCols.Add(SalesPlanResources.colW07, SalesPlanResources.colTotal);
            mathCols.Add(SalesPlanResources.colW08, SalesPlanResources.colTotal);
            mathCols.Add(SalesPlanResources.colW09, SalesPlanResources.colTotal);
            mathCols.Add(SalesPlanResources.colW10, SalesPlanResources.colTotal);
            mathCols.Add(SalesPlanResources.colW11, SalesPlanResources.colTotal);
            mathCols.Add(SalesPlanResources.colW12, SalesPlanResources.colTotal);
            mathCols.Add(SalesPlanResources.colW13, SalesPlanResources.colTotal);

            Session[sessionVarName] = mathCols;
        }

        private void CreateGridColumns()
        {
            // any name entered here that is to be sorted here needs to be entered into 
            // the sort list of the screen in exactly the same manner(ie .net is case sensitive)
            grdColumns.Clear();

            List<string> colNames = new List<string>();

            colNames.Add(SalesPlanResources.colspecie);
            colNames.Add(SalesPlanResources.colthick);
            colNames.Add(SalesPlanResources.colgrade);
            colNames.Add(SalesPlanResources.colColor);
            colNames.Add(SalesPlanResources.colSort);
            colNames.Add(SalesPlanResources.colNoPrint);
            colNames.Add(SalesPlanResources.colPRODUCT);
            colNames.Add(SalesPlanResources.colTYPE);
            colNames.Add(SalesPlanResources.colCUSTOMER);
            colNames.Add(SalesPlanResources.colMGR);
            colNames.Add(SalesPlanResources.colP13);
            colNames.Add(SalesPlanResources.colP8);
            colNames.Add(SalesPlanResources.colP4);
            colNames.Add(SalesPlanResources.colTotal);
            colNames.Add(SalesPlanResources.colW00);
            colNames.Add(SalesPlanResources.colW01);
            colNames.Add(SalesPlanResources.colW02);
            colNames.Add(SalesPlanResources.colW03);
            colNames.Add(SalesPlanResources.colW04);
            colNames.Add(SalesPlanResources.colW05);
            colNames.Add(SalesPlanResources.colW06);
            colNames.Add(SalesPlanResources.colW07);
            colNames.Add(SalesPlanResources.colW08);
            colNames.Add(SalesPlanResources.colW09);
            colNames.Add(SalesPlanResources.colW10);
            colNames.Add(SalesPlanResources.colW11);
            colNames.Add(SalesPlanResources.colW12);
            colNames.Add(SalesPlanResources.colW13);
            // <-- insert new visible columns before this line -->

            colNames.Add(SalesPlanResources.colDETAIL);
            colNames.Add(SalesPlanResources.colORDNUM);
            // < -- insert new invisible columns after this line -->

            int colPos = 0;            
            foreach(string colName in colNames)
            {
                grdColumns.Add(colName, colPos);
                colPos++;
            }
        }

        private void CreateGridColWidths()
        {
            // this is used as a general lookup list of column widths for the grid and the pdf
            wideCols.Clear();

            wideCols.Add(SalesPlanResources.colspecie, convertIntFromString(SalesPlanResources.colSpecieWidth));
            wideCols.Add(SalesPlanResources.colthick, convertIntFromString(SalesPlanResources.colThickWidth));
            wideCols.Add(SalesPlanResources.colgrade, convertIntFromString(SalesPlanResources.colGradeWith));
            wideCols.Add(SalesPlanResources.colColor, convertIntFromString(SalesPlanResources.colColorWidth));
            wideCols.Add(SalesPlanResources.colSort, convertIntFromString(SalesPlanResources.colSortWidth));
            wideCols.Add(SalesPlanResources.colNoPrint, convertIntFromString(SalesPlanResources.colNoPrintWidth));
            wideCols.Add(SalesPlanResources.colPRODUCT, convertIntFromString(SalesPlanResources.colPRODUCTWidth));
            wideCols.Add(SalesPlanResources.colTYPE, convertIntFromString(SalesPlanResources.colTypeWidth));
            wideCols.Add(SalesPlanResources.colCUSTOMER, convertIntFromString(SalesPlanResources.colCustWidth));
            wideCols.Add(SalesPlanResources.colMGR, convertIntFromString(SalesPlanResources.colMGRWidth));
            wideCols.Add(SalesPlanResources.colP13, convertIntFromString(SalesPlanResources.colMathWidth));
            wideCols.Add(SalesPlanResources.colP8, convertIntFromString(SalesPlanResources.colMathWidth));
            wideCols.Add(SalesPlanResources.colP4, convertIntFromString(SalesPlanResources.colMathWidth));
            wideCols.Add(SalesPlanResources.colTotal, convertIntFromString(SalesPlanResources.colTotalWidth));
            wideCols.Add(SalesPlanResources.colW00, convertIntFromString(SalesPlanResources.colMathWidth));
            wideCols.Add(SalesPlanResources.colW01, convertIntFromString(SalesPlanResources.colMathWidth));
            wideCols.Add(SalesPlanResources.colW02, convertIntFromString(SalesPlanResources.colMathWidth));
            wideCols.Add(SalesPlanResources.colW03, convertIntFromString(SalesPlanResources.colMathWidth));
            wideCols.Add(SalesPlanResources.colW04, convertIntFromString(SalesPlanResources.colMathWidth));
            wideCols.Add(SalesPlanResources.colW05, convertIntFromString(SalesPlanResources.colMathWidth));
            wideCols.Add(SalesPlanResources.colW06, convertIntFromString(SalesPlanResources.colMathWidth));
            wideCols.Add(SalesPlanResources.colW07, convertIntFromString(SalesPlanResources.colMathWidth));
            wideCols.Add(SalesPlanResources.colW08, convertIntFromString(SalesPlanResources.colMathWidth));
            wideCols.Add(SalesPlanResources.colW09, convertIntFromString(SalesPlanResources.colMathWidth));
            wideCols.Add(SalesPlanResources.colW10, convertIntFromString(SalesPlanResources.colMathWidth));
            wideCols.Add(SalesPlanResources.colW11, convertIntFromString(SalesPlanResources.colMathWidth));
            wideCols.Add(SalesPlanResources.colW12, convertIntFromString(SalesPlanResources.colMathWidth));
            wideCols.Add(SalesPlanResources.colW13, convertIntFromString(SalesPlanResources.colMathWidth));
        }

        private int convertIntFromString(string valueIn)
        {
            int retVal = 0;

            if (string.IsNullOrWhiteSpace(valueIn))
            {
                return 0;
            }

            if (!int.TryParse(valueIn, out retVal))
            {
                return 0;
            }

            return retVal;
        }

        private void ReloadGridColumns()
        {
            grdColumns.Clear();

            int maxCols = convertIntFromString(SalesPlanResources.maxGridColumns);

            int grdIdx = 0;
            
            foreach(System.Web.UI.WebControls.ListItem SortItem in lstColsSort.Items)
            {
                grdColumns.Add(SortItem.Value.ToString(), grdIdx);
                grdIdx++;
               
                if (grdIdx > maxCols)
                {
                    break;
                }
            }

            foreach(System.Web.UI.WebControls.ListItem availItem in lstColsAvail.Items)
            {
                if (grdIdx > maxCols)
                {
                    break;
                }

                grdColumns.Add(availItem.Value.ToString(), grdIdx);
                grdIdx++;

                if (grdIdx > maxCols)
                {
                    break;
                }
            }
            
            grdColumns.Add(SalesPlanResources.colDETAIL, grdIdx);
            grdIdx++;
            grdColumns.Add(SalesPlanResources.colORDNUM, grdIdx);
        }

        private void ReloadGridColumnWidths()
        {
            mergedWidth.Clear();

            wideCols = (Dictionary<string, int>)Session[strGridWide];

            // if you add a column to the grid and it doesnt show look here,
            // if this routine cant match the name against the name in the width list,
            // the column gets skipped so it wont show in the grid
            foreach(KeyValuePair<string, int> grdCol in grdColumns)
            {
                int colWidth = 0;
                if (!wideCols.TryGetValue(grdCol.Key, out colWidth))
                {
                    continue;
                }

                // merged width is keyed by the column ordinal and contains the column name and the width
                mergedWidth.Add(grdCol.Value, new KeyValuePair<string, int>(grdCol.Key, colWidth));
            }

            Session[strColWidths] = mergedWidth;
        }

        #endregion

    }
    
}

