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
  public partial class EntityEdit : System.Web.UI.Page
  {
    #region Attributes
    CurrentUser _user = null;
    private CurrBrowser _Browser = null;
    private string _CBuildNbr = "";
    private bool _CanEdit = false;
    private int _EntityID = 0;
    private bool _IsAdmin = false;
    private DataTable _dtRows;
    private int _NbrPages = 0;
    private int _NbrRows = 0;
    private int _PgNbr = 0;
    private int _PgSize = 20;
    private bool _ShowingCols = false;
    private bool _ShowingComments = false;
    private int _Type = 0;
    private int _UserID = 0;
    private string _ErrMsg = string.Empty;

    private string XReg = string.Empty;
    private string XLocID = string.Empty;
    private string XProduct = string.Empty;
    private string XSpecID = string.Empty;
    private string XThickness = string.Empty;
    private string XGradeID = string.Empty;
    private string XDesc = string.Empty;
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


			_CBuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
			_UserID = Convert.ToInt32(_user.UserID);


      if (!this.IsPostBack)
      {
        try
        {
            // initialize

          _EntityID = Convert.ToInt32(Request["e"]);
          _Type = Convert.ToInt32(Request["t"]);
          ViewState["EntityID"] = _EntityID;
          ViewState["EditType"] = _Type;

          if (_Type == 3)
          {
            DeleteThisID();
          }
          else
          {
            LoadMainDataGrid();
            LoadCountryList();
          }
        }
        catch (Exception ex)
        {
          // postback 
          _EntityID = Convert.ToInt32(ViewState["EntityID"]);
          _Type = Convert.ToInt32(ViewState["EditType"]);
        }
      }
      else
      {

      }
    }

    protected void LoadMainDataGrid()
    {
      try {
        EntityLib elib = new EntityLib();
        DataTable dt = elib.SelectEntityData(_EntityID, _UserID);

      }
      catch (Exception ex) {
        this.lblErrorMsg.Text = "Error when loading data grid: " + ex.Message;
      }
    }

    protected void LoadCountryList()
    {
      try
      {
        Commands cmd = new Commands();
        DataTable dt = cmd.SelectCountryList(1, _UserID);
        this.ddlCountryListF.DataTextField = "";
        this.ddlCountryListF.DataValueField = "";
        this.ddlCountryListF.DataSource = dt;
        this.ddlCountryListF.DataBind();
        if (dt.Rows.Count < 1)
        {
          this.lblErrorMsg.Text = "No countries were found for populate list.";
        }
      }
      catch (Exception ex)
      {
        this.lblErrorMsg.Text = "Error encountered when loading country list: " + ex.Message;
      }
    }

    protected void DeleteThisID()
    {
      try
      {
        EntityLib elib = new EntityLib();
        DataTable dt = elib.DeleteEntityByID(_EntityID, _UserID);


        Response.Redirect("EntityList.aspx", false);
      }
      catch (Exception ex)
      {
        lblErrorMsg.Text = "Error when attempting to delete ID " + _EntityID.ToString() + ": " + ex.Message;
      }
    }
  }
}