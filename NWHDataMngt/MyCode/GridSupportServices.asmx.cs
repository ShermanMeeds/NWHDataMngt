using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
using System.Data;
using System.Data.SqlClient;
using DataLayer;

namespace DataMngt.shared
{
	/// <summary>
	/// Summary description for GridSupport
	/// </summary>
	[WebService(Namespace = "http://tempuri.org/")]
	[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
	[System.ComponentModel.ToolboxItem(false)]
	[System.Web.Script.Services.ScriptService]
	public class GridSupport : System.Web.Services.WebService
	{
		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string ChangeLocationContact(int PgID, int ObjID, int ID, int UserID, int iType, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				DataTable dt = cmd.UpdateLocationContact(ID, UserID, iType, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "ChangeLocationContact", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Chg Loc Contact", ID, ByID, ex.Message, 0, "ChangeLocationContact function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string DeleteRequestAttachment(int PgID, int ObjID, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				GenManage gm = new GenManage();
				DataTable dt = gm.CreateWeeklyReport(ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "CreateWeeklyReport", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Create Wk Rpt", 0, ByID, ex.Message, 0, "CreateWeeklyReport function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string DeleteDocAttachment(int PgID, int ObjID, int DocID, int AttachID, string Src, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				DataTable dt = cmd.DeleteDocAttachment(DocID, AttachID, Src, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "DeleteDocAttachment", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Del Attachment", 0, ByID, ex.Message, 0, "DeleteDoctAttachment function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectCodeListDistinct(int PgID, int ObjID, int iType, string Reg, string LocCode, string LocType, string PCode, string PType, string Thick, string Specie, string Grade, string Season, string Surf,
			string Wdth, string Len, string Color, string fSort, string Milling, string NoPrint, string FuzzyGrade, string FuzzySort, string FuzzyProd, string Lvl, int Active, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				DataTable dt = cmd.SelectCodeListDistinct(iType, PgID, ObjID, Reg, LocCode, LocType, PCode, PType, Thick, Specie, Grade, Season, Surf, Wdth, Len, Color, fSort, Milling, NoPrint, FuzzyGrade, FuzzySort, FuzzyProd,
					Lvl, Active, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectCodeListDistinct", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("CodeList Distinct", 0, ByID, ex.Message, 0, "SelectCodeListDistinct function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectCommentContactList(int PgID, int ObjID, int ID, string LocCode, int Sort, int Active, int PgNbr, int PgSize, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				DataTable dt = cmd.SelectCommentContactList(ID, LocCode, Sort, Active, PgNbr, PgSize, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectCommentContactList", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Cmt Contact List", ID, ByID, ex.Message, 0, "SelectCommentContactList function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectCommentList(int PgID, int ObjID, int ID, int CmtType, string Title, int UserID, string sDtB, string sDtE, string Loc, int Sort, int Active, int PgNbr, int PgSize, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				DataTable dt = cmd.SelectCommentList(ID, CmtType, Title, UserID, sDtB, sDtE, Loc, Sort, Active, PgNbr, PgSize, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectCommentList", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Comment List", ID, ByID, ex.Message, 0, "SelectCommentList function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectCurrentMngtWeekData(int PgID, int ObjID, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				DataTable dt = cmd.SelectCurrentMngtWeekData(PgID, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectCurrentMngtWeekData", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Curr Mngt Week Data", PgID, ByID, ex.Message, 0, "SelectCurrentMngtWeekData function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectDateRangeForMillCmt(int PgID, int ObjID, string TargetDt, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				ProductionFnc pf = new ProductionFnc();
				DataTable dt = pf.SelectDateRangeForMillCmt(TargetDt, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectDateRangeForMillCmt", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Mill Cmt Date Range", 0, ByID, ex.Message, 0, "SelectDateRangeForMillCmt function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectDateRangeForMillCmtList(int PgID, int ObjID, string TargetDt, int NbrInList, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				ProductionFnc pf = new ProductionFnc();
				DataTable dt = pf.SelectDateRangeForMillCmtList(TargetDt, NbrInList, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectDateRangeForMillCmt", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Mill Cmt Date Range", 0, ByID, ex.Message, 0, "SelectDateRangeForMillCmt function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectDocTypeAssociations(int PgID, int ObjID, string DocTypeCode, int iType, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				DocsForms df = new DocsForms();
				DataTable dt = df.SelectDocTypeAssociations(DocTypeCode, iType, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectDocTypeAssociations", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Doc Type Assocs", 0, ByID, ex.Message, 0, "SelectDocTypeAssociations function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectDocumentStatusChangeList(int PgID, int ObjID, int ReqID, int InvReqID, int Sort, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				DocsForms df = new DocsForms();
				DataTable dt = df.SelectDocumentStatusChangeList(ReqID, InvReqID, Sort, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectDocumentStatusChangeList", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Mill Cmt Date Range", 0, ByID, ex.Message, 0, "SelectDocumentStatusChangeList function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectInventoryDataDetailed(int PgID, int ObjID, string Reg, string LocCode, string LocType, string PCode, string PType, string Thick, string Specie, string Grade, string Season, string Surf,
			string Wdth, string Len, string Color, string fSort, string Milling, string NoPrint, string FuzzyGrade, string FuzzySort, string FuzzyProd, string Lvl, int Sort, int Active, int PgNbr, int PgSize, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				ProductionFnc pf = new ProductionFnc();
				DataTable dt = pf.SelectInventoryDataDetailed(Reg, LocCode, LocType, PCode, PType, Thick, Specie, Grade, Season, Surf, Wdth, Len, Color, fSort, Milling, NoPrint, FuzzyGrade, FuzzySort, FuzzyProd,
					Lvl, Sort, Active, PgNbr, PgSize, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectInventoryDataDetailed", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Inv Data Detailed", 0, ByID, ex.Message, 0, "SelectInventoryDataDetailed function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectInventoryItemData(int PgID, int ObjID, string ProdType, string ProdCode, string Loc, string A1, string A2, string A3, string A4, string A5, string A6, string A7, string A8, string A9, string A10, string A11, string A12, string A13, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				ProductionFnc pf = new ProductionFnc();
				DataTable dt = pf.SelectInventoryItemData(ProdType, ProdCode, Loc, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectInventoryItemData", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Inv Item Data", 0, ByID, ex.Message, 0, "SelectInventoryItemData function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}
 
		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectLTProdCodeList(int PgID, int ObjID, string Prefix, int Sort, int Active, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				ProductionFnc pf = new ProductionFnc();
				DataTable dt = pf.SelectLTProdCodeList(Prefix, Sort, Active, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectLTProdCodeList", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("LT Code List", 0, ByID, ex.Message, 0, "SelectLTProdCodeList function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectLTShippingList(int PgID, int ObjID, int ShipNbr, string Region, string Loc, string Thickness, string Species, string Grade, string Len, string Color, string fSort, string Milling,
			string NoPrint, int Vendor, string sBDt, string sEDt, int Sort, int PgNbr, int PgSize, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				SalesFunctions sf = new SalesFunctions();
				DataTable dt = sf.SelectLTShippingList(ShipNbr, Region, Loc, Thickness, Species, Grade, Len, Color, fSort, Milling, NoPrint, Vendor, sBDt, sEDt, Sort, PgNbr, PgSize, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectLTShippingList", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Ship List", ShipNbr, ByID, ex.Message, 0, "SelectLTShippingList function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}	

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectLocationTypeList(int PgID, int ObjID, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				DataTable dt = cmd.SelectLocationTypeList(ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectLocationTypeList", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Loc Type List", ByID, ByID, ex.Message, 0, "SelectLocationTypeList function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectProductDataForTargetWeek(int PgID, int ObjID, string ProdType, string ProdCode, int WeekNbr, int Rollup, int RollProd, int NoLoc, int NoCust, int NoForecast, int NoOrd, int NoProd, int Sort, int PgNbr, int PgSize, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				SalesFunctions sf = new SalesFunctions();
				DataTable dt = sf.SelectProductDataForTargetWeek(ProdType, ProdCode, WeekNbr, Rollup, RollProd, NoLoc, NoCust, NoForecast, NoOrd, NoProd, Sort, PgNbr, PgSize, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectProductDataForTargetWeek", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Sales Grp List", 0, ByID, ex.Message, 0, "SelectProductDataForTargetWeek function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectProductDataForTargetWeek2(int PgID, int ObjID, string ProdType, string ProdCode, string Color, string fSort, string Milling, string NoPrint, int WeekNbr, int Rollup, int RollProd, int NoLoc, int NoCust, 
			int NoForecast, int NoOrd, int NoProd, int NoInv, int Sort, int PgNbr, int PgSize, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				SalesFunctions sf = new SalesFunctions();
				DataTable dt = sf.SelectProductDataForTargetWeek2(ProdType, ProdCode, Color, fSort, Milling, NoPrint, WeekNbr, Rollup, RollProd, NoLoc, NoCust, NoForecast, NoOrd, NoProd, NoInv, Sort, PgNbr, PgSize, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectProductDataForTargetWeek", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Sales Grp List", 0, ByID, ex.Message, 0, "SelectProductDataForTargetWeek function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectSalesOrderDataDetailed(int PgID, int ObjID, string Reg, string LocCode, string LocType, string PCode, string PType, string Thick, string Specie, string Grade, string Season, string Surf,
			string Wdth, string Len, string Color, string fSort, string Milling, string NoPrint, string FuzzyGrade, string FuzzySort, string FuzzyProd, string sBDt, string sEDt, int OrdNbr, string CustCode, string Lvl, 
			int Sort, int Active, int ROnly, int APShipStat, int DateType, int PgNbr, int PgSize, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				SalesFunctions sf = new SalesFunctions();
				DataTable dt = sf.SelectSalesOrderDataDetailed(Reg, LocCode, LocType, PCode, PType, Thick, Specie, Grade, Season, Surf, Wdth, Len, Color, fSort, Milling, NoPrint, FuzzyGrade, FuzzySort, FuzzyProd,
					sBDt, sEDt, OrdNbr, CustCode,	Lvl, Sort, Active, ROnly, APShipStat, DateType, PgNbr, PgSize, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectSalesOrderDataDetailed", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Sales Ord Data Detailed", 0, ByID, ex.Message, 0, "SelectSalesOrderDataDetailed function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectProductItemData(int PgID, int ObjID, int PMID, int PLID, string ProdType, string ProdCode, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				SalesFunctions sf = new SalesFunctions();
				DataTable dt = sf.SelectProductItemData(PMID, PLID, ProdType, ProdCode, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectProductItemData", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Prod Item Data", PMID, ByID, ex.Message, 0, "SelectProductItemData function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectProdTypeCodeList(int PgID, int ObjID, string ProdType, int Desc, int Attrib, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				DataTable dt = cmd.GetProdTypeCodeList(ProdType, Desc, Attrib, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectProdTypeCodeList", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("PType Code List", 0, ByID, ex.Message, 0, "SelectProdTypeCodeList function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectSalesGroupList (int PgID, int ObjID, int Active, int iType, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				SalesFunctions sf = new SalesFunctions();
				DataTable dt = sf.SelectSalesGroupList(Active, iType, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectSalesGroupList", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Sales Grp List", 0, ByID, ex.Message, 0, "SelectSalesGroupList function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectSalesLeadList (int PgID, int ObjID, int Active, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				SalesFunctions sf = new SalesFunctions();
				DataTable dt = sf.SelectSalesLeadList(Active, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectSalesLeadList", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Sales Pers List", 0, ByID, ex.Message, 0, "SelectSalesLeadList function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectSalesPersonList(int PgID, int ObjID, int Active, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				SalesFunctions sf = new SalesFunctions();
				DataTable dt = sf.SelectSalesPersonList(Active, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectSalesPersonList", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Sales Pers List", 0, ByID, ex.Message, 0, "SelectSalesPersonList function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectSalesProductList(int PgID, int ObjID, string Region, string Species, string Grade, string Thick, string Len, string Color, string fSort, string Milling, string NoPrint, string Comment, int Mngd,
			int Active, int Sort, int Dir, int PgNbr, int PgSize, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				CatToolFunctions cf = new CatToolFunctions();
				DataTable dt = cf.SelectSalesProductFullList(Region, Species, Grade, Thick, Len, Color, fSort, Milling, NoPrint, Comment, Mngd, Active, Sort, Dir, PgNbr, PgSize, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectSalesProductList", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Sales Prod List", 0, ByID, ex.Message, 0, "SelectSalesProductList function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectUserRequestData(int PgID, int ObjID, int ReqID, int UserID, int ReqTypeID, int ListType, int Sort, int Hist, string BDate, string EDate, int PgNbr, int PgSize, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				RequestMngt rm = new RequestMngt();
				DataTable dt = rm.SelectUserRequestData(ReqID, UserID, ReqTypeID, ListType, Sort, Hist, BDate, EDate, PgNbr, PgSize, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectUserRequestData", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Req Dec Due List", 0, ByID, ex.Message, 0, "SelectUserRequestData function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string UpdateComment(int PgID, int ObjID, int ID, int iType, string CmtType, string Title, string Loc, string Comment, int InsGraph, int Wdth, int Ht, string TDt, int OrigID, int Active, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				DataTable dt = cmd.UpdateCommentData(ID, iType, CmtType, Title, Loc, Comment, InsGraph, Wdth, Ht, TDt, OrigID, Active, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "UpdateComment", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("UpdateComment", ID, ByID, ex.Message, 0, "UpdateComment function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string UpdateCommentRequestData(int PgID, int ObjID, int InvReqID, int CmtID, int ItemNbr, int iType, string CmtType, string Title, string Loc, string Comment, int InsGraph, int Wdth, int Ht, 
			string TDt, int OrigID, int Active, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				DataTable dt = cmd.UpdateCommentRequestData(InvReqID, CmtID, ItemNbr, iType, CmtType, Title, Loc, Comment, InsGraph, Wdth, Ht, TDt, OrigID, Active, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "UpdateCommentRequestData", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("UpdateComment Req Item", CmtID, ByID, ex.Message, 0, "UpdateCommentRequestData function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string UpdateScheduleDate(int PgID, int ObjID, int Yr, int Mo, string Dy, int Typ, int Checked, int Action, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				DataTable dt = cmd.UpdateScheduleDate(Yr, Mo, Dy, Typ, Checked, Action, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "UpdateScheduleDate", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("UpdateSched", Yr, ByID, ex.Message, 0, "UpdateScheduleDate function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string UpdateProductDataItem(int PgID, int ObjID, int ID, int Typ, string Val, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				CatToolFunctions ctf = new CatToolFunctions();
				DataTable dt = ctf.UpdateCatToolProductDataItem(ID, Typ, Val, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "UpdateProductDataItem", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Update ProdData Item", ID, ByID, ex.Message, 0, "UpdateProductDataItem function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string UpdateSalesProductData(int PgID, int ObjID, int ID, string Region, string Prod, string Desc, double Price, string Comments, string Specie, string Thickness,
			string Grade, string Len, string Color, string Sort, string Milling, string NoPrint, string ProdType, string ExpPrgID, int NbrAttach, int Mngd, int Track, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				int iType = 1;
				if (ID == 0) { iType = 0; }
				CatToolFunctions ctf = new CatToolFunctions();
				DataTable dt = ctf.UpdateSalesProductTrackItem(ID, iType, Region, Prod, Desc, Price, Specie, Thickness, Grade, Len, Color, Sort, Milling, NoPrint, ProdType, ExpPrgID, Track, Mngd, Comments, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "UpdateProductDataItem", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Update ProdData Item", ID, ByID, ex.Message, 0, "UpdateProductDataItem function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}
	}
}
