using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
using DataLayer;
using DataMngt;

/// <summary>
/// Summary description for Pagination
/// </summary>
[System.Web.Script.Services.ScriptService()]
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
public class Pagination : System.Web.Services.WebService {

    public Pagination () {
    }

		[WebMethod]
		public string HelloWorld()
		{
			return "Hello World";
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string getUIPageSettings(int PageID, int ObjID, int ByID)
		{
			try
			{
				PaginationFn pg = new PaginationFn();
				DataTable dt = pg.GetPageSettings(PageID, ObjID, ByID);
				return JsonHelper.toJSONfmTbl(dt);
			}
			catch (Exception ex)
			{
				Commands cmd = new Commands();
				int iResult = cmd.LogApplicationError("DataMngt", ObjID, ByID, "Err: " + ex.Message, 0, "getUIPageSettings function", ByID);
				System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
				return js.Serialize(new { Success = false, Message = ex.Message });
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string UpdateUIPageSetting(int PageID, int ObjID, int iType, int Nbr, DateTime? dte, string Value, int ByID)
		{
			try
			{
				PaginationFn pg = new PaginationFn();
				DataTable dt = pg.UpdateUIPageSetting(PageID, ObjID, iType, Nbr, dte, Value, ByID);
				return JsonHelper.toJSONfmTbl(dt);
			}
			catch (Exception ex)
			{
				Commands cmd = new Commands();
				int iResult = cmd.LogApplicationError("DataMngt", ObjID, ByID, "Err: " + ex.Message, 0, "UpdateUIPageSetting function", ByID);
				System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
				return js.Serialize(new { Success = false, Message = ex.Message });
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string UpdateUIPageSettings(int PageID, int ObjID, int PgNbr, int PgSize, int MainID, int EmpID, int OrderID, int VendorID, int CustID, int SuppID, int SpeciesID, int LocID, int ShipID, int ItemID, int MgrID, 
			int GroupID, int SortID, int LoadID, int OtherID, double Nbr, string StartDt, string EndDt, string TargetDt, string ItemCode, string ItemName, string TagNbr, string CustCode, string VendorCode, string LocCode, string SpeciesCode,
			string SuppCode, string ThickCode, string GradeCode, string StatusCode, int iType, int ByID)
		{
			try
			{
				DateTime? sdate = null;
				DateTime? edate = null;
				DateTime? tdate = null;
				if (!String.IsNullOrWhiteSpace(StartDt)) { sdate = Convert.ToDateTime(StartDt); }
				if (!String.IsNullOrWhiteSpace(EndDt)) { edate = Convert.ToDateTime(EndDt); }
				if (!String.IsNullOrWhiteSpace(TargetDt)) { tdate = Convert.ToDateTime(TargetDt); }
				PaginationFn pg = new PaginationFn();
				DataTable dt = pg.UpdateUIPageSettings(PageID, ObjID, PgNbr, PgSize, MainID, EmpID, OrderID, VendorID, CustID, SuppID, SpeciesID, LocID, ShipID, ItemID, MgrID, GroupID, SortID, LoadID, OtherID, Nbr, sdate, edate, tdate, 
					ItemCode, ItemName, TagNbr, CustCode, VendorCode, LocCode, SpeciesCode, SuppCode, ThickCode, GradeCode, StatusCode, iType, ByID);
				return JsonHelper.toJSONfmTbl(dt);
			}
			catch (Exception ex)
			{
				Commands cmd = new Commands();
				int iResult = cmd.LogApplicationError("DataMngt", ObjID, ByID, "Err: " + ex.Message, 0, "UpdateUIPageSettings function", ByID);
				System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
				return js.Serialize(new { Success = false, Message = ex.Message });
			}
		}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string UpdateGenUserTracks(int UserID, int PgID, int PgObjID, int PgNbr, int PgSize, string StatusCode, string ProdType, string Prod, string Reg, string Loc, string Species, string Thick, string Grade,
			string Seasoning, string Surface, string Width, string Len, string Color, string fSort, string Milling, string NoPrint, string Cust, string Vendor, string Supplier, int ShowWks, int HideComments, int Excl0s, int IncHist,
			int Sort, int FontSz, string ItemCode, string ItemName, string ItemDesc, int MainID, int MgrID, int CustID, int OrderID, int ShipID, int OtherID, int LoadID, int Setting1, int Setting2, int Setting3, int Setting4, int Setting5,
			string sBeginDt, string sEndDt, string sTargetDT, int ByID)
	{
		Commands cmd = new Commands();
		try
		{
			DateTime? sdate = null;
			DateTime? edate = null;
			DateTime? tdate = null;
			if (!String.IsNullOrWhiteSpace(sBeginDt)) { sdate = Convert.ToDateTime(sBeginDt); }
			if (!String.IsNullOrWhiteSpace(sEndDt)) { edate = Convert.ToDateTime(sEndDt); }
			if (!String.IsNullOrWhiteSpace(sTargetDT)) { tdate = Convert.ToDateTime(sTargetDT); }
			DataTable dt = cmd.UpdateUserTracks(UserID, PgID, PgObjID, PgNbr, PgSize, StatusCode, ProdType, Prod, Reg, Loc, Species, Thick, Grade, Seasoning, Surface, Width, Len, Color, fSort, Milling, NoPrint, Cust, Vendor, Supplier,
				ShowWks, HideComments, Excl0s, IncHist, Sort, FontSz, ItemCode, ItemName, ItemDesc, MainID, MgrID, CustID, OrderID, ShipID, OtherID, LoadID, Setting1, Setting2, Setting3, Setting4, Setting5, sdate, edate, tdate, ByID);
			return JsonHelper.toJSONfmTbl(dt);
		}
		catch (Exception ex)
		{
			int iResult = cmd.LogApplicationError("User Tracks", UserID, ByID, "Err: " + ex.Message, 0, "UpdateGenUserTracks function", ByID);
			System.Web.Script.Serialization.JavaScriptSerializer js = new System.Web.Script.Serialization.JavaScriptSerializer();
			return js.Serialize(new { Success = false, Message = ex.Message });
		}
	}

}
