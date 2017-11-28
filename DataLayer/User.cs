using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace DataLayer
{
	public class CurrentUser
	{
		#region Variable Initiation
		private int _AccessRights = 0;
		private int _AccessInvAdj = 0;
		private string _AdminPages = string.Empty;
		private int _ARAgingRpt = 0;
		private int _CatToolRight = 0;
		private string _ClaimDocRights = "000000000000";
		private int _ClaimsRights = 0;
		private string CompanyCode = String.Empty;
		private int _EditCustomers = 0;
		private int _EditLocations = 0;
		private int _EditUsers = 0;
		private int _EditVendors = 0;
		private string _EmailAddress = string.Empty;
		private string _ErrMsg = string.Empty;
		private string _FirstName = string.Empty;
		private string _FullName = string.Empty;
		private string _FullName2 = string.Empty;
		private bool _IsAdmin = false;
		private int _IsContractor = 0;
		private bool _IsLoaded = false;
		private bool _IsValid = false;
		private bool _IsViewOnly = false;
		private string _LastName = string.Empty;
		private string _LocationCode = string.Empty;
		private string _LoginName = string.Empty;
		private string _MiddleName = string.Empty;
		private string _Position = string.Empty;
		private int _ProdAvailRight = 0;
		private int _ProcOwnerRight = 0;
		private string _Region = string.Empty;
		private string _RequestTypes = string.Empty;
		private string _Roles = string.Empty;
		private string _StartDate = string.Empty;
		private int _UserID = -1;
		#endregion Variable Initiation
																																		  
		#region public properties
		public int AccessARAgingRpt { get { return _ARAgingRpt; } }
		public int AccessInvAdj { get { return _AccessInvAdj; } }
		public int AccessRights { get { return _AccessRights; } }
		public int CatToolRights { get { return _CatToolRight; } }
		public string ClaimDocRights { get { return _ClaimDocRights; } }
		public int ClaimsRights { get { return _ClaimsRights; } }
		public int EditCustomers { get { return _EditCustomers; } }
		public int EditLocations { get { return _EditLocations; } }
		public int EditUsers { get { return _EditUsers; } }
		public int EditVendors { get { return _EditVendors; } }
		public string LoginName { get { return _LoginName; } }
		public string PageAdministrators { get { return _AdminPages; } }
		public string RequestRights { get { return _RequestTypes; } }
		public int ProdAvailRights { get { return _ProdAvailRight; } }
		public int ProcOwnerRight { get { return _ProcOwnerRight; } }
		public string EmailAddress
		{
			get { return _EmailAddress; }
			set { _EmailAddress = value; }
		}
		public int UserID
		{
			get { return _UserID; }
			set { _UserID = value; }
		}
		public string ErrMsg
		{
			get { return _ErrMsg; }
			set { _ErrMsg = value; }
		}
		public string FirstName
		{
			get { return _FirstName; }
			set { _FirstName = value; }
		}
		public string FullName
		{
			get { return _FullName; }
			set { _FullName = value; }
		}
		public string FullName2
		{
			get { return _FullName2; }
			set { _FullName2 = value; }
		}
		public bool IsAdmin
		{
			get { return _IsAdmin; }
		}
		public int IsContractor
		{
			get { return _IsContractor; }
		}
		public bool IsLoaded
		{
			get { return _IsLoaded; }
		}
		public bool IsValid
		{
			get { return _IsValid; }
		}
		public bool IsViewOnly
		{
			get { return _IsViewOnly; }
		}
		public string LastName
		{
			get { return _LastName; }
			set { _LastName = value; }
		}
		public string LocationCode
		{
			get { return _LocationCode; }
			set { _LocationCode = value; }
		}
		public string MiddleName
		{
			get { return _MiddleName; }
			set { _MiddleName = value; }
		}
		public string Position
		{
			get { return _Position; }
			set { _Position = value; }
		}
		public string RegionCode
		{
			get { return _Region; }
		}
		public string StartDate
		{
			get { return _StartDate; }
			set { _StartDate = value; }
		}

		#endregion public properties

		private CurrentUser() { }

		public CurrentUser(string Login, string logfile, string assumedIdent)
		{
		  this._LoginName = Login;
		  this.UserID = -1;
		  this.ErrMsg = String.Empty;
		  try
		  {
				_IsValid = false;
				SqlParameter p1;
				DBInterface di = new DBInterface();
				//if (assumedIdent == "")
				//{
					p1 = new SqlParameter("@UserLogin", Login);
				//p1 = new SqlParameter("@UserLogin", "S609215-AD01\\beckerk"); //S609215 - AD01\NagaiY
				//}
				//else
				//{
				//	p1 = new SqlParameter("@UserLogin", "S609215-AD01\\" + assumedIdent);
				//}
				DataTable dt = di.RunSPReturnDataTableNWDW("web.usp_GetUserData", new SqlParameter[] { p1 });
				if (dt.Rows.Count > 0)
				{
					this.UserID = (int)dt.Rows[0]["UserID"];
					this._IsContractor = 0;
					if (Convert.ToBoolean(dt.Rows[0]["IsContractor"]))
					{
						this._IsContractor = 1;
					}
					this.EmailAddress = dt.Rows[0]["EmailAddress"].ToString();
					this.FirstName = dt.Rows[0]["FirstName"].ToString();
					this.LastName = dt.Rows[0]["LastName"].ToString();
					this.MiddleName = dt.Rows[0]["MiddleName"].ToString();
					this.FullName = dt.Rows[0]["FullName"].ToString();
					this.FullName2 = dt.Rows[0]["FullName2"].ToString();
					this.Position = dt.Rows[0]["EmpPosition"].ToString();
					this._IsViewOnly = true;
          this._AccessRights = 0;
          this._IsAdmin = false;
					this._Roles = dt.Rows[0]["Roles"].ToString().ToLower();
					this._CatToolRight = 0;
					this._ProdAvailRight = 0;
					this._EditVendors = 0;
					this._EditCustomers = 0;
					this._EditUsers = 0;
					this._EditLocations = 0;
					this._ProcOwnerRight = 0;
					this._AccessInvAdj = 0;
					this._ClaimsRights = 0;
					this._LocationCode = dt.Rows[0]["LocationCode"].ToString();
					this._IsValid = true;
					this._Region = dt.Rows[0]["RegionCode"].ToString();
					this._RequestTypes = dt.Rows[0]["ReqTypes"].ToString();

					if (this.IsInRole("ceo"))
					{
						this._IsAdmin = true;
						this._AccessRights = 5;
						this._CatToolRight = 5;
						this._EditVendors = 5;
						this._EditCustomers = 5;
						this._EditUsers = 5;
						this._EditLocations = 5;
						this._IsViewOnly = false;
						this._ProdAvailRight = 5;
						this._ProcOwnerRight = 5;
						this._AccessInvAdj = 5;
						this._ARAgingRpt = 5;
					}
					if (this.IsInRole("cfo"))
					{
						this._CatToolRight = 3;
						this._AccessInvAdj = 3;
						this._AccessRights = 3;
					}
					if (this.IsInRole("datmngtAdmin"))
					{
						this._IsAdmin = true;
						this._AccessRights = 5;
						this._CatToolRight = 5;
						this._EditVendors = 5;
						this._EditCustomers = 5;
						this._EditUsers = 5;
						this._EditLocations = 5;
						this._IsViewOnly = false;
						this._ProdAvailRight = 5;
						this._ProcOwnerRight = 5;
						this._AccessInvAdj = 5;
						this._ARAgingRpt = 5;
					}
					else
					{
						if (this.IsInRole("useredit") || this.IsInRole("userview") || this.IsInRole("vendedit") || this.IsInRole("vendview") || this.IsInRole("techvp") || this.IsInRole("salesvp"))
						{
							this._AccessRights = 1;
						}
						if (this.IsInRole("prodavlvw")) {
							this._AccessRights = 3;
							this._ProdAvailRight = 3;
						}
						if (this.IsInRole("prodavled")) {
							this._AccessRights = 3;
							this._ProdAvailRight = 3;
						}
						if (this.IsInRole("prodavlad")) {
							this._AccessRights = 3;
							this._ProdAvailRight = 3;
						}
						// master data rights
						if (this.IsInRole("vendedit")) {
							this._AccessRights = 3;
							this._EditVendors = 3;
						}
						if (this.IsInRole("custedit")) {
							this._AccessRights = 3;
							this._EditCustomers = 3;
						}
						if (this.IsInRole("useredit")) {
							this._AccessRights = 3;
							this._EditUsers = 3;
						}
						if (this.IsInRole("locedit")) {
							this._AccessRights = 3;
							this._EditLocations = 3;
						}
						if (this.IsInRole("aragerpt")) {
							this._AccessRights = 1;
							this._ARAgingRpt = 1;
						}
						if (this.IsInRole("datmngtedit"))
						{
							this._AccessRights = 3;
							this._IsViewOnly = false;
							this._CatToolRight = 3;
							this._ProcOwnerRight = 3;
							this._AccessInvAdj = 3;
							this._ProdAvailRight = 3;
							this._EditVendors = 3;
							this._EditCustomers = 3;
							this._EditUsers = 3;
							this._EditLocations = 3;
							this._ARAgingRpt = 3;
						}
						else
						{
							if (this.IsInRole("datmngtview")) { this._AccessRights = 1; }
						}

						if (this.IsInRole("catAdmin"))
						{
							this._CatToolRight = 5;
							this._AccessRights = 3;
							this._AdminPages = string.Concat(this._AdminPages, "|27|");
						}
						else
						{
							if (this.IsInRole("catprcedit"))
							{
								this._AccessRights = 3;
								this._CatToolRight = 3;
							}
							else
							{
								if (this.IsInRole("catview") || this.IsInRole("prodavlvw") || this.IsInRole("prodavlad") || this.IsInRole("prodavled") || this.IsInRole("saleslead"))
								{
									this._AccessRights = 1;
									this._CatToolRight = 1;
								}
							}
						}
						if (this.IsInRole("aprocownv")) {
							this._ProcOwnerRight = 1;
							if (this._AccessRights < 1) { this._AccessRights = 1; }
						}
						if (this.IsInRole("aprocowne")) {
							this._ProcOwnerRight = 3;
							if (this._AccessRights < 1) { this._AccessRights = 1; }
						}
						if (this.IsInRole("aprocowna")) {
							this._ProcOwnerRight = 5;
							if (this._AccessRights < 1) { this._AccessRights = 1; }
						}
						if (this.IsInRole("invadjview")) {
							if (this._AccessRights < 1) { this._AccessRights = 1; }
							this._AccessInvAdj = 1;
						}
						if (this.IsInRole("invadjedit")) {
							if (this._AccessRights < 1) { this._AccessRights = 1; }
							this._AccessInvAdj = 3;
						}
						if (this.IsInRole("invadjadm")) {
							if (this._AccessRights < 1) { this._AccessRights = 1; }
							this._AccessInvAdj = 5;
							this._AdminPages = string.Concat(this._AdminPages, "|22|");
						}
						if (this.IsInRole("forecastedit"))
						{
							this._AccessRights = 1;
						}
						if (this.IsInRole("hitscompvw"))
						{
							this._AccessRights = 1;
						}
						if (this.IsInRole("forecastadm")) { this._AdminPages = string.Concat(this._AdminPages, "|50|"); }
						if (this.IsInRole("issuemngtadm")) { this._AdminPages = string.Concat(this._AdminPages, "|46|"); }
						if (this.IsInRole("procmngtadm")) { this._AdminPages = string.Concat(this._AdminPages, "|57|"); }
						if (this.IsInRole("procownadm")) { this._AdminPages = string.Concat(this._AdminPages, "|56|"); }
						if (this.IsInRole("salesplnAdm")) { this._AdminPages = string.Concat(this._AdminPages, "|58|"); }
						if (this.IsInRole("wurthcdadm")) { this._AdminPages = string.Concat(this._AdminPages, "|26|"); }
						if (this.IsInRole("sessmngtadm")) { this._AdminPages = string.Concat(this._AdminPages, "|24|"); }
						if (this.IsInRole("emailmngtadm")) { this._AdminPages = string.Concat(this._AdminPages, "|59|"); }
						if (this.IsInRole("compassadm")) { this._AdminPages = string.Concat(this._AdminPages, "|7|"); }
						if (this.IsInRole("cmtmngtadm")) { this._AdminPages = string.Concat(this._AdminPages, "|44|"); }
						if (this.IsInRole("custclmvw") || this.IsInRole("freightaccvw") || this.IsInRole("inventadjvw") || this.IsInRole("invmngtvw") || this.IsInRole("lossdmgvw") || this.IsInRole("macadjustvw") || this.IsInRole("manualcrdvw") || this.IsInRole("rtnmanfstvw") || this.IsInRole("vendorclmvw") || this.IsInRole(""))
						{
							this._ClaimsRights = 1;
						}
						if (this.IsInRole("custclmedt") || this.IsInRole("freightaccedt") || this.IsInRole("inventadjedt") || this.IsInRole("invmngtedt") || this.IsInRole("lossdmgedt") || this.IsInRole("macadjustedt") || this.IsInRole("manualcrdedt") || this.IsInRole("rtnmanfstedt") || this.IsInRole("vendorclmedt") || this.IsInRole(""))
						{
							this._ClaimsRights = 3;
						}
						if (this.IsInRole("custclmappr") || this.IsInRole("freightaccappr") || this.IsInRole("inventadjappr") || this.IsInRole("invmngtappr") || this.IsInRole("lossdmgappr") || this.IsInRole("macadjustappr") || this.IsInRole("manualcrdappr") || this.IsInRole("rtnmanfstappr") || this.IsInRole("vendorclmappr") || this.IsInRole(""))
						{
							this._ClaimsRights = 4;
						}
						if (this.IsInRole("custclmadm") || this.IsInRole("freightaccadm") || this.IsInRole("inventadjadm") || this.IsInRole("invmngtadm") || this.IsInRole("lossdmgadm") || this.IsInRole("macadjustadm") || this.IsInRole("manualcrdadm") || this.IsInRole("rtnmanfstadm") || this.IsInRole("vendorclmadm") || this.IsInRole(""))
						{
							this._ClaimsRights = 5;
						}
						//2 InvAdjustment Only, 3Return Manifest, 4Freight Accrual, 5Vendor Claim, 6Loss & Damage Claim, 7Inventory Adjustment, 8MAC Adjustment, 9Manual Credit, 10Cust Claim
						if (this.IsInRole("custclmvw") || this.IsInRole("custclmedt") || this.IsInRole("custclmappr") || this.IsInRole("custclmadm") || this._IsAdmin == true)
						{
							_ClaimDocRights = _ClaimDocRights.Substring(0, 10) + "X" + _ClaimDocRights.Substring(10);
						}
						if (this.IsInRole("freightaccvw") || this.IsInRole("freightaccedt") || this.IsInRole("freightaccappr") || this.IsInRole("freightaccadm") || this._IsAdmin == true)
						{
							_ClaimDocRights = _ClaimDocRights.Substring(0, 4) + "X" + _ClaimDocRights.Substring(4);
						}
						if (this.IsInRole("inventadjvw") || this.IsInRole("inventadjedt") || this.IsInRole("inventadjappr") || this.IsInRole("inventadjadm") || this._IsAdmin == true)
						{
							_ClaimDocRights = _ClaimDocRights.Substring(0, 7) + "X" + _ClaimDocRights.Substring(7);
						}
						if (this.IsInRole("lossdmgvw") || this.IsInRole("lossdmgedt") || this.IsInRole("lossdmgappr") || this.IsInRole("lossdmgadm") || this._IsAdmin == true)
						{
							_ClaimDocRights = _ClaimDocRights.Substring(0, 6) + "X" + _ClaimDocRights.Substring(6);
						}
						if (this.IsInRole("macadjustvw") || this.IsInRole("macadjustedt") || this.IsInRole("macadjustappr") || this.IsInRole("macadjustadm") || this._IsAdmin == true)
						{
							_ClaimDocRights = _ClaimDocRights.Substring(0, 8) + "X" + _ClaimDocRights.Substring(8);
						}
						if (this.IsInRole("manualcrdvw") || this.IsInRole("manualcrdedt") || this.IsInRole("manualcrdappr") || this.IsInRole("manualcrdadm") || this._IsAdmin == true)
						{
							_ClaimDocRights = _ClaimDocRights.Substring(0, 9) + "X" + _ClaimDocRights.Substring(9);
						}
						if (this.IsInRole("rtnmanfstvw") || this.IsInRole("rtnmanfstedt") || this.IsInRole("rtnmanfstappr") || this.IsInRole("rtnmanfstadm") || this._IsAdmin == true)
						{
							_ClaimDocRights = _ClaimDocRights.Substring(0, 3) + "X" + _ClaimDocRights.Substring(3);
						}
						if (this.IsInRole("vendorclmvw") || this.IsInRole("vendorclmedt") || this.IsInRole("vendorclmappr") || this.IsInRole("vendorclmadm") || this._IsAdmin == true)
						{
							_ClaimDocRights = _ClaimDocRights.Substring(0, 5) + "X" + _ClaimDocRights.Substring(5);
						}
					}
					if (this._Roles.Length > 0) { this._AccessRights = 1; }
					this._IsLoaded = true;
          this.ErrMsg = "";
				}
			}
			catch (Exception ex)
			{
				this._IsLoaded = false;
				this._IsValid = false;
				this.ErrMsg = ex.Message;
				Commands cmd = new Commands();
				string datm = DateTime.Now.ToString("MM/dd/yyyy HH:MM");
				string M = "DMWeb " + datm + " :" + ex.Message;
				cmd.WriteToLog(M, logfile);
				//int rtn = cmd.LogApplicationError("DMWeb DataMngt", 0, 0, ex.Message, 0, "Login for " + Login, 0);
			}
		}

		#region Functions
		public CurrentUser EmptyUser()
		{
			CurrentUser user = new CurrentUser();
			return user;
		}

		public bool IsInRole(string Role)
		{
			if (this._Roles.IndexOf("," + Role.ToLower() + ",") >= 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

		public bool IsInReqRole(string Role)
		{
			if (this._RequestTypes.IndexOf("," + Role.ToLower() + ",") >= 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

		#endregion Functions

	}
}
