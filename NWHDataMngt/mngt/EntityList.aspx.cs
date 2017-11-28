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
  public partial class EntityList : System.Web.UI.Page
  {
    #region Attributes
    CurrentUser _user = null;
    private CurrBrowser _Browser = null;
    private string _CBuildNbr = "";
    private bool _CanEdit = false;
    private bool _IsAdmin = false;
    private int _NbrPages = 0;
    private int _NbrRows = 0;
    private int _PgNbr = 0;
    private int _PgSize = 20;
    private int _UserID = 0;
    private string _ErrMsg = string.Empty;

		private string XAddress = string.Empty;
		private string XCity = string.Empty;
		private string XCode = string.Empty;
		private string XCountry = string.Empty;
		private string XDesc = string.Empty;
		private string XEmail = string.Empty;
		private string XGeo = string.Empty;
    private string XLocID = string.Empty;
		private string XName = string.Empty;
    private string XProduct = string.Empty;
		private string XPhone = string.Empty;
		private string XSpecID = string.Empty;
		private string XStateID = string.Empty;
		private string XStatus = string.Empty;
		private string XTaxNbr = string.Empty;
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

    public int NbrPages
    {
      get { return _NbrPages; }
    }

    public int NbrRows
    {
      get { return _NbrRows; }
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
        Session["NoAccessMsg"] = "You do not have access to the entity edit page";
        Response.Redirect("../NoAcc/NoAccess.aspx", true);
      }

      // check for specific rights to cat tool
      if (_user.AccessRights < 2 && _user.CatToolRights == 0)
      {
        Session["NoAccessMsg"] = "You do not have access to entity edit page.";
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

			// set main object values
      _CBuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
      _UserID = Convert.ToInt32(_user.UserID);

      if (!this.IsPostBack)
      {
        try
        {
					// initialize
					XAddress = "";
					XCity = "";
					XCode = "";
					XCountry = "";
					XEmail = "";
					XGeo = "";
					XName = "";
					XPhone = "";
					XProduct = "";
					XStateID = "";
					XStatus = "";
					XTaxNbr = "";
					ViewState["AddressFilter"] = "";
					ViewState["CityFilter"] = "";
					ViewState["CodeFilter"] = "";
					ViewState["CountryFilter"] = "";
					ViewState["EmailFilter"] = "";
					ViewState["GeoFilter"] = "";
					ViewState["NameFilter"] = "";
					ViewState["PhoneFilter"] = "";
					ViewState["ProductFilter"] = "";
					ViewState["StateFilter"] = "";
					ViewState["StatusFilter"] = "";
					ViewState["TaxNbrFilter"] = "";
					LoadCountryListFilter();
					LoadCountryEditList();
					LoadVendorTypeList();
					LoadCurrencyTypeList();
					LoadMainDataGrid(0);
        }
        catch (Exception ex)
        {
					this.lblErrorMsg.Text = "Error doing initial load: " + ex.Message;
				}
			}
      else
      {
				// postback 
				XAddress = ViewState["AddressFilter"].ToString();
				XCity = ViewState["CityFilter"].ToString();
				XCode = ViewState["CodeFilter"].ToString();
				XCountry = ViewState["CountryFilter"].ToString();
				XEmail = ViewState["EmailFilter"].ToString();
				XGeo = ViewState["GeoFilter"].ToString();
				XName = ViewState["NameFilter"].ToString();
				XPhone = ViewState["PhoneFilter"].ToString();
				XProduct = ViewState["ProductFilter"].ToString();
				XStateID = ViewState["StateFilter"].ToString();
				XStatus = ViewState["StatusFilter"].ToString();
				XTaxNbr = ViewState["TaxNbrFilter"].ToString();
			}

			// Calendar popup script register
			string jsScript = "";
			jsScript = "<script type=\"text/javascript\">$(function() { $( \"#MainContent_txtBeginDateE\" ).datepicker({dateFormat: 'm/d/yy',showOtherMonths: true, showButtonPanel: true, showStatus: true}); });</script>" + Environment.NewLine;
			Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "DatePicker1", jsScript);

			jsScript = "<script type=\"text/javascript\">$(function() { $( \"#MainContent_txtEndDateE\" ).datepicker({dateFormat: 'm/d/yy',showOtherMonths: true, showButtonPanel: true, showStatus: true}); });</script>" + Environment.NewLine;
			Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "DatePicker2", jsScript);
		}

		protected void LoadMainDataGrid(int ResetPage)
    {
      try
      {
        int Type = Convert.ToInt32(ddlTypeF.SelectedValue);
        string Name = txtNameF.Text;
        string Cd = txtCodeF.Text;
        string Stat = ddlStatusF.SelectedValue;
        string addr = txtAddressF.Text;
        string City = txtCityF.Text;
        string stcode = ddlStateIDF.SelectedValue;
        string cntry = ddlCountryListF.SelectedValue;
        string pcode = txtPostalCodeF.Text;
        string email = txtEmailAddressF.Text;
        string GeoArea = txtGeoAreaF.Text;
        string phone = txtPhoneF.Text;
        string taxnbr = txtFEINTaxNbrF.Text;
				int PgSize = Convert.ToInt32(this.ddlPageSize.SelectedValue);
				gvMainData.PageSize = PgSize;
				this._PgSize = PgSize;

				if (Name != XName && Cd != XCode && Stat != XStatus && addr != XAddress && City != XCity && stcode != XStateID && cntry != XCountry && pcode != XProduct && email != XEmail && GeoArea != XGeo && phone != XPhone && taxnbr != XTaxNbr)
				{
					_PgNbr = 0;
					gvMainData.PageIndex = 0;
				}
				if (ResetPage == 1)
				{
					_PgNbr = 0;
					gvMainData.PageIndex = 0;
				}

				XName = Name;
				XCode = Cd;
				XCountry = cntry;
				XEmail = email;
				XGeo = GeoArea;
				XStatus = Stat;
				XAddress = addr;
				XCity = City;
				XProduct = pcode;
				XStateID = stcode;
				XTaxNbr = taxnbr;
				ViewState["AddressFilter"] = XAddress;
				ViewState["CityFilter"] = XCity;
				ViewState["CountryFilter"] = XCountry;
				ViewState["CodeFilter"] = Cd;
				ViewState["EmailFilter"] = XEmail;
				ViewState["GeoFilter"] = XGeo;
				ViewState["NameFilter"] = Name;
				ViewState["PhoneFilter"] = XPhone;
				ViewState["ProductFilter"] = XProduct;
				ViewState["StateFilter"] = XStateID;
				ViewState["StatusFilter"] = Stat;
				ViewState["TaxNbrFilter"] = XTaxNbr;

				EntityLib elib = new EntityLib();
        DataTable dt = elib.SelectEntityList(Name, Cd, Type, Stat, addr, City, stcode, cntry, pcode, email, GeoArea, taxnbr, "0", phone, 0, 20000, 0, 1, _UserID);
        gvMainData.DataSource = dt;
        gvMainData.DataBind();
        if (dt.Rows.Count < 1)
        {
          lblErrorMsg.Text = "No rows were returned that matched your criteria.";
        }
      }
      catch (Exception ex)
      {
        this.lblErrorMsg.Text = "Error when loading data grid: " + ex.Message;
      }
    }

    protected void LoadCountryListFilter()
    {
      try
      {
        Commands cmd = new Commands();
        DataTable dt = cmd.SelectCountryList(1, _UserID);
        this.ddlCountryListF.DataTextField = "CountryName";
        this.ddlCountryListF.DataValueField = "CountryCodeISO3";
        this.ddlCountryListF.DataSource = dt;
        this.ddlCountryListF.DataBind();
        if (dt.Rows.Count < 1)
        {
          this.lblErrorMsg.Text = "No countries were found to populate filter list.";
        }
      }
      catch (Exception ex)
      {
        this.lblErrorMsg.Text = "Error encountered when loading country filter list: " + ex.Message;
      }
    }

		protected void LoadCountryEditList()
		{
			try
			{
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectCountryList(1, _UserID);
				this.ddlCountryListE.DataTextField = "CountryName";
				this.ddlCountryListE.DataValueField = "CountryCodeISO3";
				this.ddlCountryListE.DataSource = dt;
				this.ddlCountryListE.DataBind();
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error encountered when loading country edit list: " + ex.Message;
			}
		}

		protected void LoadVendorTypeList()
		{
			try
			{
				EntityLib el = new EntityLib();
				DataTable dt = el.SelectVendorTypeList(0, 1, _UserID);
				ddlVendorTypeE.DataValueField = "VendorTypeID";
				ddlVendorTypeE.DataTextField = "VendorType";
				ddlVendorTypeE.DataSource = dt;
				ddlVendorTypeE.DataBind();
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error encountered when loading vendor types: " + ex.Message;
			}
		}

		protected void LoadDivisionList()
		{
			try
			{
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectDivisionList(0, 1, _UserID);
				ddlDivIDE.DataTextField = "DivisionTitle";
				ddlDivIDE.DataValueField = "DivisionID";
				ddlDivIDE.DataSource = dt;
				ddlDivIDE.DataBind();
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error encountered during division list loading: " + ex.Message;
			}
		}

		protected void LoadCurrencyTypeList()
		{
			try
			{
				EntityLib el = new EntityLib();
				DataTable dt = el.SelectCurrencyTypeList(0, 1, _UserID);
				ddlCurrencyE.DataValueField = "";
				ddlCurrencyE.DataTextField = "";
				ddlCurrencyE.DataSource = dt;
				ddlCurrencyE.DataBind();
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error encountered when loading currency types: " + ex.Message;
			}
		}

		protected void btnRefilterDataGrid_Click(object sender, EventArgs e)
		{
			LoadMainDataGrid(1);
		}

		protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
		{
			// nothing
		}

		//protected void chkYardE_CheckedChanged(object sender, EventArgs e)
		//{
		//}

		//protected void chkMillE_CheckedChanged(object sender, EventArgs e)
		//{
		//}

		protected void chkSupplierE_CheckedChanged(object sender, EventArgs e)
		{

		}

		protected void chkVendorE_CheckedChanged(object sender, EventArgs e)
		{
			if (this.chkVendorE.Checked == true) {
				divEditItemVendor.Style["display"] = "block";
			}
			else {
				divEditItemVendor.Style["display"] = "none";
			}

		}

		protected void chkCustomerE_CheckedChanged(object sender, EventArgs e)
		{
			if (this.chkCustomerE.Checked == true)
			{
				divEditItemCustomer.Style["display"] = "block";
			}
			else
			{
				divEditItemCustomer.Style["display"] = "none";
			}
		}

		protected void chkSourceE_CheckedChanged(object sender, EventArgs e)
		{
			// nothing
		}

		protected void gvMainData_RowCommand(object sender, GridViewCommandEventArgs e)
		{
			String s = String.Empty;
			string cname = e.CommandName.ToString();
			int RowID = Convert.ToInt32(e.CommandArgument);
			GridViewRow r = gvMainData.Rows[RowID];
			DataRowView rv = (DataRowView)r.DataItem;
			DateTime BDate = DateTime.Now;
			string sBDate = BDate.ToString("MM/dd/yyyy");
			int EntID = Convert.ToInt32(r.Cells[0].Text);
			EntityLib el = new EntityLib();
			DataTable dt = el.SelectEntityData(EntID, _UserID);
			

			try
			{
				switch (cname)
				{
					case "Edit1":
						DateTime d = DateTime.Now;
						lblEntityIDE.Text = dt.Rows[0]["EntityID"].ToString();
						txtEntityNameE.Text = dt.Rows[0]["EntityFullName"].ToString();
						s = dt.Rows[0]["EntityTypeCode"].ToString();
						ddlEntityTypeE.SelectedValue = s;
						txtEntityCodeE.Text = dt.Rows[0]["EntityCode"].ToString();
						txtLastNameE.Text = dt.Rows[0]["LastName"].ToString();
						txtFirstNameE.Text = dt.Rows[0]["FirstName"].ToString();
						txtMiddleNameE.Text = dt.Rows[0]["MiddleName"].ToString();
						txtSuffixE.Text = dt.Rows[0]["Suffix"].ToString();
						ddlEntityStatusE.SelectedValue = dt.Rows[0]["EntityStatus"].ToString();
						txtDescriptionE.Text = dt.Rows[0]["EntityDescription"].ToString();
						ddlGeoAreaE.SelectedValue = "0";
						s = dt.Rows[0]["GeoArea"].ToString();
						if (s.Length > 0) { ddlGeoAreaE.SelectedValue = s; }
						txtBeginDateE.Text = dt.Rows[0]["sBeginDate"].ToString();
						txtEndDateE.Text = dt.Rows[0]["sEndDate"].ToString();
						txtAddressE.Text = dt.Rows[0]["Address1"].ToString();
						txtAddrCityE.Text = dt.Rows[0]["City"].ToString();
						ddlStateProvE.SelectedValue = dt.Rows[0]["StateCode"].ToString();
						ddlCountryListE.SelectedValue = dt.Rows[0]["CountryCode"].ToString();
						txtFEINTaxNbrE.Text = dt.Rows[0]["FEINTaxNbr"].ToString();
						txtPostalCodeE.Text = dt.Rows[0]["PostalCode"].ToString();
						txtMainPhoneE.Text = dt.Rows[0]["MainPhone"].ToString();
						txtCellPhoneE.Text = dt.Rows[0]["CellPhone"].ToString();
						txtFaxE.Text = dt.Rows[0]["MainFax"].ToString();
						txtEmailAddrE.Text = dt.Rows[0]["EmailAddress"].ToString();
						ddlCurrencyE.SelectedValue = "0";
						txtVendorIDE.Text = dt.Rows[0]["VendorID"].ToString();
						txtVendorClassE.Text = dt.Rows[0]["VendorClass"].ToString();
						ddlVendorTypeE.SelectedValue = dt.Rows[0]["VendorTypeID"].ToString();
						txtCustomerIDE.Text = dt.Rows[0]["CustomerID"].ToString();
						txtSupplierIDE.Text = dt.Rows[0]["SupplierID"].ToString();
						chkCustomerE.Checked = false;
						chkVendorE.Checked = false;
						chkSupplierE.Checked = false;
						chkEmployeeE.Checked = false;
						if (dt.Rows[0]["sIsCustomer"].ToString() == "Yes") { chkCustomerE.Checked = true; }
						if (dt.Rows[0]["sIsVendor"].ToString() == "Yes") { chkCustomerE.Checked = true; }
						if (dt.Rows[0]["sIsSupplier"].ToString() == "Yes") { chkCustomerE.Checked = true; }
						if (dt.Rows[0]["sIsEmployee"].ToString() == "Yes") { chkEmployeeE.Checked = true; }
						chkSourceE.Checked = false;
						divGridFilters.Style["display"] = "none";
						divEditItem.Style["display"] = "block";
						if (ddlEntityTypeE.SelectedValue == "IND")
						{
							this.trIndividualNameE.Style["display"] = "table-row";
							lblEntNameE.Style["display"] = "none";
							txtEntityNameE.Style["display"] = "none";
						}
						else
						{
							this.trIndividualNameE.Style["display"] = "none";
							lblEntNameE.Style["display"] = "inline";
							txtEntityNameE.Style["display"] = "inline";
						}
						break;
					case "Inact1":
						break;
					default:
						break;
				}
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error generated: " + ex.Message;
			}
		}

		protected void btnAddNew_Click(object sender, EventArgs e)
		{
			try
			{
				divGridFilters.Style["display"] = "none";
				DateTime d = DateTime.Now;
				lblEntityIDE.Text = "0";
				txtEntityNameE.Text = String.Empty;
				txtEntityCodeE.Text = String.Empty;
				txtLastNameE.Text = String.Empty;
				txtFirstNameE.Text = String.Empty;
				txtMiddleNameE.Text = String.Empty;
				txtSuffixE.Text = String.Empty;
				txtDescriptionE.Text = String.Empty;
				txtBeginDateE.Text = d.ToString("MM/dd/yyyy");
				txtEndDateE.Text = String.Empty;
				txtAddressE.Text = String.Empty;
				txtAddrCityE.Text = String.Empty;
				txtFEINTaxNbrE.Text = String.Empty;
				txtPostalCodeE.Text = String.Empty;
				txtMainPhoneE.Text = String.Empty;
				txtCellPhoneE.Text = String.Empty;
				txtFaxE.Text = String.Empty;
				txtEmailAddrE.Text = String.Empty;
				ddlCurrencyE.SelectedValue = "0";
				txtVendorIDE.Text = String.Empty;
				txtVendorClassE.Text = String.Empty;
				txtCustomerIDE.Text = String.Empty;
				txtSupplierIDE.Text = String.Empty;
				ddlEntityTypeE.SelectedValue = "0";
				ddlEntityStatusE.SelectedValue = "A";
				ddlGeoAreaE.SelectedValue = "0";
				ddlVendorTypeE.SelectedValue = "0";
				ddlStateProvE.SelectedValue = "0";
				ddlCountryListE.SelectedValue = "0";
				chkCustomerE.Checked = false;
				chkVendorE.Checked = false;
				chkSupplierE.Checked = false;
				chkEmployeeE.Checked = false;
				chkSourceE.Checked = false;
				divEditItem.Style["display"] = "block";
				// chkMillE.Checked = false; 
				// chkYardE.Checked = false; 
				// chkDestinationE.Checked = false; 
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error generated: " + ex.Message;
			}
		}

		protected void chkEmployeeE_CheckedChanged(object sender, EventArgs e)
		{
			// nothing
		}

		protected void btnSaveEntityData_Click(object sender, EventArgs e)
		{
			try
			{
				DateTime d = DateTime.Now;
				int act = Convert.ToInt32(ddlActiveE.SelectedValue);
				int DivID = Convert.ToInt32(ddlDivIDE.SelectedValue);
				int id = Convert.ToInt32(lblEntityIDE.Text);
				string Addr = txtAddressE.Text;
				string attribs = "0000000000";
				string Contact = txtContactNameE.Text;
				string CPhone = txtContactPhoneE.Text;
				string Cell = txtCellPhoneE.Text;
				string CEmail = txtContactEmailE.Text;
				string City = txtAddrCityE.Text;
				string Country = ddlCountryListE.SelectedValue;
				string CurrCode = ddlCurrencyE.SelectedValue;
				string CustID = txtCustomerIDE.Text;
				string Desc = txtDescriptionE.Text;
				string Email = txtEmailAddrE.Text;
				string EntCode = txtEntityCodeE.Text;
				string EntStat = ddlEntityStatusE.SelectedValue;
				string EntType = ddlEntityTypeE.SelectedValue;
				string FEINTaxNr = txtFEINTaxNbrE.Text;
				string Fax = txtFaxE.Text;
				string FName = txtFirstNameE.Text;
				string FullName = txtEntityNameE.Text;
				string GeoArea = ddlGeoAreaE.SelectedValue;
				string LName = txtLastNameE.Text;
				string MName = txtMiddleNameE.Text;
				string PCode = txtPostalCodeE.Text;
				string Phone = txtMainPhoneE.Text;
				string Suff = txtSuffixE.Text;
				string sBDate = txtBeginDateE.Text;
				string sEDate = txtEndDateE.Text;
				string StProv = ddlStateProvE.SelectedValue;
				string SuppID = txtSupplierIDE.Text;
				string VendClass = txtVendorClassE.Text;
				string VendID = txtVendorIDE.Text;
				string VendTypeID = ddlVendorTypeE.Text;
				string YardType = "";
				int EmpID = 0;
				int IsCust = 0;
				int IsVend = 0;
				int IsSupp = 0;
				int IsEmp = 0;
				int IsSource = 0;
				int IsComp = 0;
				int IsDest = 0;
				int IsMill = 0;
				int IsYard = 0;
				int IsExp = 0;
				int IsExt = 0;
				int IsLT = 0;
				int IsLIMS = 0;
				int IsGP = 0;
				if (EntType == "CMP") { IsComp = 1; }
				if (chkCustomerE.Checked == true) { IsCust = 1; }
				if (chkVendorE.Checked == true) { IsVend = 1; }
				if (chkSupplierE.Checked == true) { IsSupp = 1; }
				if (chkEmployeeE.Checked == true) { IsEmp = 1; }
				if (chkSourceE.Checked == true) { IsSource = 1; };
				if (chkAccessGP.Checked == true) { IsGP = 1; }
				if (chkAccessLIMS.Checked == true) { IsLIMS = 1; }
				if (chkAccessLT.Checked == true) { IsLT = 1; }

				EntityLib el = new EntityLib();
				DataTable dt = el.UpdateEntityData(id, EntType, FullName, LName, FName, MName, Suff, "", EntStat, EntCode, Desc, IsEmp, IsCust, IsSupp, IsVend, IsComp, IsExt, IsExp, IsSource, IsDest, IsMill, IsYard, GeoArea, sBDate, sEDate, FEINTaxNr,
					Addr, City, StProv, Country, PCode, VendID, CustID, SuppID, EmpID, attribs, "", VendClass, VendTypeID, YardType, Phone, Cell, Fax, Email, CurrCode, IsLT, IsLIMS, IsGP, act, DivID, "C5073803VW00", Contact, CEmail, CPhone, "", _UserID);
				//the last two digits in the C5073803VW number are fillers - cannot be sure what is supposed to be there in two-five digits.

				divGridFilters.Style["display"] = "none";
			}
			catch (Exception ex)
			{
				this.lblErrorMsg.Text = "Error generated when trying to save Entity data: " + ex.Message;
			}
		}

		protected void ddlEntityTypeE_SelectedIndexChanged(object sender, EventArgs e)
		{
			if (ddlEntityTypeE.SelectedValue== "IND")
			{
				this.trIndividualNameE.Style["display"] = "table-row";
				lblEntNameE.Style["display"] = "none";
				txtEntityNameE.Style["display"] = "none";
			}
			else
			{
				this.trIndividualNameE.Style["display"] = "none";
				lblEntNameE.Style["display"] = "inline";
				txtEntityNameE.Style["display"] = "inline";
			}
		}

		protected void chkAccessLT_CheckedChanged(object sender, EventArgs e)
		{

		}

		protected void chkAccessLIMS_CheckedChanged(object sender, EventArgs e)
		{

		}

		protected void chkAccessGP_CheckedChanged(object sender, EventArgs e)
		{

		}
	}
}