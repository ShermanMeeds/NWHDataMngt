using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using DataLayer;



namespace DataMngt.page
{
  public partial class APAging : System.Web.UI.Page
  {
    #region Attributes
    CurrentUser _user = null;
    private CurrBrowser _Browser = null;
    private string _ARTypeF = string.Empty;
    private string _BranchYardF = string.Empty;
    private string _CBuildNbr = string.Empty;
    private string _CompanyF = string.Empty;
    private string _ControllerF = string.Empty;
    private string _CountryF = string.Empty;
    private string _CreditGroupF = string.Empty;
    private string _CurrencyF = string.Empty;
    private string _CustomerF = string.Empty;
    private string _ErrMsg = string.Empty;
    private bool _IsAdmin = false;
    private int _NbrPages = 0;
    private int _NbrRows = 0;
		private int _PageID = 28;
		private string _PayTermsF = string.Empty;
    private int _PgNbr = 0;
    private int _PgSize = 20;
    private string _SalesGroupF = string.Empty;
    private string _SalesPersonF = string.Empty;
		private string _SrcF = string.Empty;
		private int _UserID = 0;
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

    public int PgNbr
    {
      get { return _PgNbr; }
    }

    public int PgSize
    {
      get { return _PgSize; }
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
			//this.divLoadingGif.Style["display"] = "block";
			this.lblErrorMsg.Text = "";
      string usrname = "";
			//_PgNbr = 0;
			//_PgSize = 20;
			//this.ddlPageSize.SelectedValue = "20";
			string AppLog = System.Configuration.ConfigurationManager.AppSettings["AppLogFilePath"].ToString();

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

			//int IsAssumed = 0;
			string AssumedLogin = string.Empty;
			if (HttpContext.Current.Session["AssumedEntityLogin"] != null)
			{
				if (HttpContext.Current.Session["AssumedEntityLogin"].ToString() != "") { AssumedLogin = HttpContext.Current.Session["AssumedEntityLogin"].ToString(); }
			}
			//if (AssumedLogin != "") { IsAssumed = 1; }
			// get user object and put it in the session
			//if (_user == null)
			//{
			//	if (HttpContext.Current.Session["CurrentUser"] != null)
			//	{
			//		_user = (CurrentUser)HttpContext.Current.Session["CurrentUser"];
			//	}
			//	else
			//	{
			_user = new CurrentUser(usrname, AppLog, AssumedLogin); // SessionHelper.GetCurrentUser(Request.ServerVariables["LOGON_USER"]);
					HttpContext.Current.Session["CurrentUser"] = _user;
			//	}
			//}
			// Access rule
			if (_user == null || !_user.IsValid)
			{
				Log.WriteLogEntry("User Login failed " + usrname, AppLog);
				Session["NoAccessMsg"] = "You do not have access to the check approval application";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}
			
			// check for specific rights to cat tool
			if (_user.AccessRights < 2 && _user.CatToolRights == 0)
			{
				Session["NoAccessMsg"] = "You do not have access to the Cat Tool.";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}

			_CBuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
			_UserID = Convert.ToInt32(_user.UserID);

      // Handle postback and initial load
      if (!this.IsPostBack)
      {
        try
        {
          //LoadCustomerList();
          LoadSalesPersList();
          LoadARTypeList();
          LoadBranchList();
          LoadCountryList();
          LoadPayTermList();
          LoadControllerList();
          LoadCreditGroupList();
					LoadSalesGroupList();
					LoadAgingList(0);

					ResetFiltersToDefault();
				}
        catch (Exception ex)
        {
					this.lblErrorMsg.Text = "Error encountered in initial loads: " + ex.Message;
				}
      }
      else
      {
				//this.ddlSalesGroupF.SelectedValue = ViewState["SalesGroup"].ToString();
				_ARTypeF = ViewState["ARTypeF"].ToString();
				_BranchYardF = ViewState["BranchYardF"].ToString();
				_CompanyF = "01";
				_ControllerF = ViewState["ControllerF"].ToString();
				_CountryF = ViewState["CountryF"].ToString();
				_CreditGroupF = ViewState["CreditGroupF"].ToString();
				_CurrencyF = ViewState["CurrencyF"].ToString();
				_CustomerF = ViewState["CustomerF"].ToString();
				_NbrPages = Convert.ToInt32(ViewState["NbrPages"]);
				_NbrRows = Convert.ToInt32(ViewState["NbrRows"]);
				_PayTermsF = ViewState["PayTermsF"].ToString();
				_PgNbr = Convert.ToInt32(ViewState["PgNbr"]);
				_PgSize = Convert.ToInt32(ViewState["PgSize"]);
				_SalesGroupF = ViewState["SalesGroupF"].ToString();
				_SalesPersonF = ViewState["SalesPersonF"].ToString();
				_SrcF = ViewState["SourceTypeF"].ToString();

			}

		}

    // ******************************************************************************

    protected void LoadAgingList(int LType)
    {
			string Msg = "Error loading data grid data: ";
			try
			{
				// handle filter parameters
				string artype = this.lbxARTypeF.SelectedValue;
				string branch = this.lbxBranchYardF.SelectedValue;
				string country = this.lbxCountryF.SelectedValue;
				string contr = this.lbxControllerF.SelectedValue;
				string creditgrp = this.lbxCreditGroupF.SelectedValue;
				string curr = this.ddlCurrencyF.SelectedValue;
				string cust = this.txtCustomerF.Text;
				string custnbr = this.txtCustNbrF.Text;
				string payterm = this.lbxPaymentTermsF.SelectedValue;
				string salesgrp = this.lbxSalesGroupF.SelectedValue;
				string salespers = this.lbxSalesPersonF.SelectedValue;
				string Src = this.ddlSourceTypeF.SelectedValue;
				int Threshold = Convert.ToInt32(this.ddlThresholdF.SelectedValue);
				string sBegin = this.txtBeginInvDateF.Text;
				DateTime? asofdate = null;
				DateTime? bdate = null;
				if (sBegin.Length > 0)
				{
					bdate = Convert.ToDateTime(sBegin);
				}

        ViewState["ARTypeF"] = artype;
        ViewState["BranchYardF"] = branch;
				ViewState["CountryF"] = country;
				ViewState["ControllerF"] = contr;
        ViewState["CreditGroupF"] = creditgrp;
        ViewState["CurrencyF"] = curr;
        ViewState["CustomerF"] = cust;
        ViewState["PayTermsF"] = payterm;
        ViewState["SalesGroupF"] = salesgrp;
        ViewState["SalesPersonF"] = salespers;
				ViewState["SourceTypeF"] = Src;
				ViewState["ThresholdF"] = Threshold.ToString();

        // reset to first page if necessary
        if (LType == 1)
        {
          _PgNbr = 0;
          ViewState["PgNbr"] = 0;
          gvInvoiceList.PageIndex = 0;
        }

				// load aging data
				InvoiceLib inv = new InvoiceLib();
				DataTable dt = new DataTable();
				dt = inv.SelectARAgingData("01", creditgrp, salespers, cust, custnbr, artype, salesgrp, contr, payterm, country, branch, curr, asofdate, Threshold, bdate, Src, 0, _UserID);
				//string Company, string CreditGrp, string SalesPers, string Cust, string ARType, string SalesGrp, string Controller, string PayTerms, string Country, string Branch, string Currency, DateTime? AsOfDate, string Src, int Sort, int ByI
				Msg = "Error binding data grid: ";
				this.gvInvoiceList.DataSource = dt;
				this.gvInvoiceList.DataBind();
				if (dt.Rows.Count < 1)
				{
					this.lblErrorMsg.Text = "No AR Aging data was returned that match all of the filters you have set.";
				}
			}
			catch (Exception ex)
      {
        this.lblErrorMsg.Text = Msg + ex.Message;
      }
		}

    protected void LoadSalesPersList()
    {
      try {
        InvoiceLib inv = new InvoiceLib();
        DataTable dt = inv.GetInvoiceSalesPersList(0, _UserID);
        this.lbxSalesPersonF.DataTextField = "FullName";
        this.lbxSalesPersonF.DataValueField = "SalesUID";
        this.lbxSalesPersonF.DataSource = dt;
        this.lbxSalesPersonF.DataBind();
        if (dt.Rows.Count < 1)
        {
          this.lblErrorMsg.Text = "No sales people were found when populating list.";
        }
      }
      catch (Exception ex) {
        this.lblErrorMsg.Text = "Error while loading sales person list: " + ex.Message;
      }
    }

    protected void LoadARTypeList() {
      try {
        InvoiceLib inv = new InvoiceLib();
        DataTable dt = inv.GetInvoiceTypesList(0, 1, _UserID);
        this.lbxARTypeF.DataTextField = "codedesc";
        this.lbxARTypeF.DataValueField = "code";
        this.lbxARTypeF.DataSource = dt;
        this.lbxARTypeF.DataBind();
        if (dt.Rows.Count < 1)
        {
          this.lblErrorMsg.Text = "No AR Types were loaded.";
        }
      }
      catch (Exception ex) {
        this.lblErrorMsg.Text = "Error when loading AR Type List: " + ex.Message;
      }
    }

    protected void LoadBranchList() {
			try
			{
				//ddlBranchYardF
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectBranchList(0, _UserID);
				lbxBranchYardF.DataTextField = "BranchName";
				lbxBranchYardF.DataValueField = "BranchCode";
				lbxBranchYardF.DataSource = dt;
				lbxBranchYardF.DataBind();
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error generated while loading Branch List: " + ex.Message;
			}
    }

    protected void LoadCountryList() {
      try {
        Commands cmd = new Commands();
        DataTable dt = cmd.SelectCountryList(1, _UserID);
        this.lbxCountryF.DataTextField = "CountryName";
        this.lbxCountryF.DataValueField = "CountryCodeISO3";
        this.lbxCountryF.DataSource = dt;
        this.lbxCountryF.DataBind();
        if (dt.Rows.Count < 1) {
          this.lblErrorMsg.Text = "No countries were returned for list.";
        }
      }
      catch (Exception ex) {
        this.lblErrorMsg.Text = "Error retrieving country list: " + ex.Message;
      }
    }

    protected void LoadPayTermList() {
      try {
        Commands cmd = new Commands();
        DataTable dt = cmd.SelectFinancialTermsList(0, 1, _UserID);
        this.lbxPaymentTermsF.DataTextField = "Term";
        this.lbxPaymentTermsF.DataValueField = "TermID";
        this.lbxPaymentTermsF.DataSource = dt;
        this.lbxPaymentTermsF.DataBind();
        if (dt.Rows.Count < 1) {
          this.lblErrorMsg.Text = "No payment terms were returned for list.";
        }
      }
      catch (Exception ex) {
        this.lblErrorMsg.Text = "Error when loading payment terms list: " + ex.Message;
      }
    }

		protected void LoadSalesGroupList()
		{
			try
			{
				InvoiceLib il = new InvoiceLib();
				DataTable dt = il.SelectSalesGroupList(1, _UserID);
				lbxSalesGroupF.DataTextField = "slsgrp";
				lbxSalesGroupF.DataValueField = "slsgrp";
				lbxSalesGroupF.DataSource = dt;
				lbxSalesGroupF.DataBind();
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error when loading sales group list: " + ex.Message;
			}
		}

    protected void LoadControllerList() {
     try
			{
				//ddlControllerF
				InvoiceLib IL = new InvoiceLib();
				DataTable dt = IL.SelectControllerList(0, _UserID);
				lbxControllerF.DataTextField = "username";
				lbxControllerF.DataValueField = "username";
				lbxControllerF.DataSource = dt;
				lbxControllerF.DataBind();
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error while loading controller list: " + ex.Message;
			}
    }

    protected void LoadCreditGroupList() {
			try
			{
				//ddlCreditGroupF
				InvoiceLib il = new InvoiceLib();
				DataTable dt = il.SelectCreditGroupList(0, _UserID);
				lbxCreditGroupF.DataTextField = "grp";
				lbxCreditGroupF.DataValueField = "grp";
				lbxCreditGroupF.DataSource = dt;
				lbxCreditGroupF.DataBind();
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error generated while loading credit group list: " + ex.Message;
			}
		}

    // ******************************************************************************
    
    protected void gvInvoiceList_PageIndexChanged(object sender, EventArgs e)
    {
			try
			{
				this.lblErrorMsg.Text = "";
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error encountered when Page Index changed: " + ex.Message;
			}
		}

		protected void gvInvoiceList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
			try
			{
				_PgNbr = e.NewPageIndex;
				gvInvoiceList.PageIndex = _PgNbr;
				LoadAgingList(0);
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error while paginating: " + ex.Message;
			}
		}

		protected void gvInvoiceList_RowCommand(object sender, GridViewCommandEventArgs e)
    {
			try
			{
				// nothing yet
				this.lblErrorMsg.Text = "";
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error encountered on grid view row command: " + ex.Message;
			}
		}

		protected void gvInvoiceList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
			try
			{
				// nothing yet
				this.lblErrorMsg.Text = "";
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error encountered in row binding: " + ex.Message;
			}
		}

		protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
    {
			try
			{
				_PgNbr = 0;
				_PgSize = Convert.ToInt32(this.ddlPageSize.SelectedValue);
				gvInvoiceList.PageIndex = _PgNbr;
				gvInvoiceList.PageSize = _PgSize;
				LoadAgingList(0);
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error while paginating: " + ex.Message;
			}
		}

    protected void btnRefreshData_Click(object sender, EventArgs e)
    {
      LoadAgingList(1);
    }

		protected void btnExportToExcel_Click(object sender, EventArgs e)
		{
			try
			{
				string FileName = "AR_Aging_";
				DateTime now = DateTime.Now;
				FileName = FileName + now.ToString("MM_dd_yyyy");

				// handle filter parameters
				string artype = this.lbxARTypeF.SelectedValue;
				string branch = this.lbxBranchYardF.SelectedValue;
				string country = this.lbxCountryF.SelectedValue;
				string contr = this.lbxControllerF.SelectedValue;
				string creditgrp = this.lbxCreditGroupF.SelectedValue;
				string curr = this.ddlCurrencyF.SelectedValue;
				string cust = this.txtCustomerF.Text;
				string custnbr = this.txtCustNbrF.Text;
				string payterm = this.lbxPaymentTermsF.SelectedValue;
				string salesgrp = this.lbxSalesGroupF.SelectedValue;
				string salespers = this.lbxSalesPersonF.SelectedValue;
				string Src = this.ddlSourceTypeF.SelectedValue;
				int Threshold = Convert.ToInt32(this.ddlThresholdF.SelectedValue);
				string sBegin = this.txtBeginInvDateF.Text;
				DateTime? asofdate = null;
				DateTime? bdate = null;
				if (sBegin.Length > 0)
				{
					bdate = Convert.ToDateTime(sBegin);
				}

				// load aging data
				InvoiceLib inv = new InvoiceLib();
				DataTable dt = inv.SelectARAgingData("01", creditgrp, salespers, cust, custnbr, artype, salesgrp, contr, payterm, country, branch, curr, asofdate, Threshold, bdate, Src, 0, _UserID);
				if (dt.Rows.Count > 0 )
				{
					string tab = "";
					Response.Clear();
					Response.Buffer = true;
					Response.AddHeader("content-disposition", "attachment;filename=" + FileName + ".xls");
					Response.Charset = "";
					Response.ContentType = "application/vnd.ms-excel";
					foreach (DataColumn dc in dt.Columns)
					{
						Response.Write(tab + dc.ColumnName);
						tab = "\t";
					}
					Response.Write("\n");
					int i;
					foreach (DataRow dr in dt.Rows)
					{
						tab = "";
						for (i = 0; i < dt.Columns.Count; i++)
						{
							Response.Write(tab + dr[i].ToString());
							tab = "\t";
						}
						Response.Write("\n");
					}
					Response.Flush();
					Response.End();
				}
				else
				{
					this.lblErrorMsg.Text = "No rows could be extracted that matched your filtering criteria.";
				}
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error when exporting to Excel: " + ex.Message;
			}
		}

		protected void btnExportToPDF_Click(object sender, EventArgs e)
		{
			this.lblErrorMsg.Text = "";
			try
			{
				// handle filter parameters
				string artype = this.lbxARTypeF.SelectedValue;
				string branch = this.lbxBranchYardF.SelectedValue;
				string country = this.lbxCountryF.SelectedValue;
				string contr = this.lbxControllerF.SelectedValue;
				string creditgrp = this.lbxCreditGroupF.SelectedValue;
				string curr = this.ddlCurrencyF.SelectedValue;
				string cust = this.txtCustomerF.Text;
				string custnbr = this.txtCustNbrF.Text;
				string payterm = this.lbxPaymentTermsF.SelectedValue;
				string salesgrp = this.lbxSalesGroupF.SelectedValue;
				string salespers = this.lbxSalesPersonF.SelectedValue;
				string Src = this.ddlSourceTypeF.SelectedValue;
				int Threshold = Convert.ToInt32(this.ddlThresholdF.SelectedValue);
				string sBegin = this.txtBeginInvDateF.Text;
				DateTime? asofdate = null;
				DateTime? bdate = null;
				if (sBegin.Length > 0)
				{
					bdate = Convert.ToDateTime(sBegin);
				}

				// load aging data
				InvoiceLib inv = new InvoiceLib();
				DataTable dt = inv.SelectARAgingData("01", creditgrp, salespers, cust, custnbr, artype, salesgrp, contr, payterm, country, branch, curr, asofdate, Threshold, bdate, Src, 0, _UserID);
				if (dt.Rows.Count > 0)
				{
					string FileName = "AR_Aging_";
					DateTime now = DateTime.Now;
					FileName = FileName + now.ToString("MM_dd_yyyy");

					Document pdfDoc = new Document(PageSize.A4.Rotate(), 30, 30, 40, 25);
					System.IO.MemoryStream mStream = new System.IO.MemoryStream();
					PdfWriter writer = PdfWriter.GetInstance(pdfDoc, mStream);
					int cols = dt.Columns.Count;
					int rows = dt.Rows.Count;
					iTextSharp.text.Font font5 = iTextSharp.text.FontFactory.GetFont(FontFactory.HELVETICA, 5);
					pdfDoc.Open();

					PdfPTable pdfTable = new PdfPTable(cols);
					pdfTable.DefaultCell.BorderWidth = 1;
					pdfTable.WidthPercentage = 100;
					pdfTable.DefaultCell.Padding = 1;
					PdfPRow row = null;
					float[] widths = new float[] { 4f, 4f, 4f, 4f, 4f, 4f, 4f, 4f, 4f, 4f, 4f, 4f, 4f, 4f, 4f, 4f, 4f, 4f, 4f, 4f, 4f, 4f, 4f, 4f, 4f, 4f, 4f, 4f };
					pdfTable.SetWidths(widths);
					pdfTable.WidthPercentage = 100;

					string colname = "";
					string parag = "CAT Availability dated " + now.ToString("MM/dd/yyyy");
					PdfPCell Tcell = new PdfPCell(new Phrase(parag));
					Tcell.Colspan = dt.Columns.Count;
					Tcell.HorizontalAlignment = Element.ALIGN_CENTER;

					// Add header title
					pdfTable.AddCell(Tcell);
					PdfPCell cell;

					// Add column titles
					foreach (DataColumn c in dt.Columns)
					{
						pdfTable.AddCell(new Phrase(c.ColumnName, font5));
					}

					// Add all rows to table
					if (dt.Rows.Count > 0)
					{
						foreach (DataRow r in dt.Rows)
						{
							// Add Column by column for each row
							for (int i = 0; i < dt.Columns.Count; i++)
							{
								pdfTable.AddCell(new Phrase(r[i].ToString(), font5));
							}
						}
					}

					pdfDoc.Add(pdfTable);
					pdfDoc.Close();
					Response.ContentType = "application/octet-stream";
					Response.AddHeader("Content-Disposition", "attachment; filename=" + FileName + ".pdf");
					Response.Clear();
					Response.BinaryWrite(mStream.ToArray());
					Response.End();
				}
				else
				{
					this.lblErrorMsg.Text = "No rows could be extracted that matched your filtering criteria.";
				}
			}
			catch (DocumentException de)
			{
				this.lblErrorMsg.Text = "Error while generating PDF: " + de.Message;
			}
			catch (IOException ioEx)
			{
				this.lblErrorMsg.Text = "Error while generating PDF: " + ioEx.Message;
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error when exporting to PDF: " + ex.Message;
			}
		}

		protected void btnResetDefaultF_Click(object sender, EventArgs e)
		{
			ResetFiltersToDefault();
		}

		protected void ResetFiltersToDefault()
		{
			this.txtCustNbrF.Text = "";
			this.txtCustomerF.Text = "";
			this.lbxSalesPersonF.SelectedIndex = -1;
			this.lbxSalesPersonF.SelectedValue = "0";
			this.lbxSalesGroupF.SelectedIndex = -1;
			this.lbxSalesGroupF.SelectedValue = "0";
			this.lbxARTypeF.SelectedIndex = -1;
			this.lbxARTypeF.SelectedValue = "0";
			this.lbxControllerF.SelectedIndex = -1;
			this.lbxControllerF.SelectedValue = "0";
			this.lbxCreditGroupF.SelectedIndex = -1;
			this.lbxCreditGroupF.SelectedValue = "0";
			this.lbxPaymentTermsF.SelectedIndex = -1;
			this.lbxPaymentTermsF.SelectedValue = "0";
			this.lbxBranchYardF.SelectedIndex = -1;
			this.lbxBranchYardF.SelectedValue = "0";
			this.lbxCountryF.SelectedIndex = -1;
			this.lbxCountryF.SelectedValue = "0";
			this.ddlCurrencyF.SelectedValue = "0";
			this.ddlThresholdF.SelectedValue = "0";
			this.ddlPageSize.SelectedValue = "20";

			_ARTypeF = "0";
			_BranchYardF = "0";
			_CompanyF = "01";
			_ControllerF = "0";
			_CountryF = "0";
			_CreditGroupF = "0";
			_CurrencyF = "0";
			_CustomerF = "0";
			_NbrPages = 0;
			_NbrRows = 0;
			_PayTermsF = "0";
			_PgNbr = 0;
			_PgSize = 20;
			_SalesGroupF = "0";
			_SalesPersonF = "0";
			_SrcF = "0";

			ViewState["ARTypeF"] = "0";
			ViewState["BranchYardF"] = "0";
			ViewState["CompanyF"] = "01";
			ViewState["ControllerF"] = "0";
			ViewState["CountryF"] = "0";
			ViewState["CreditGroupF"] = "0";
			ViewState["CurrencyF"] = "0";
			ViewState["CustomerF"] = "";
			ViewState["NbrPages"] = 0;
			ViewState["NbrRows"] = 0;
			ViewState["PayTermsF"] = "0";
			ViewState["PgNbr"] = 0;
			ViewState["PgSize"] = 20;
			ViewState["SalesGroupF"] = "0";
			ViewState["SalesPersonF"] = "0";
			ViewState["SourceTypeF"] = _SrcF;
			// reload data grid
			LoadAgingList(1);
		}



	}
}