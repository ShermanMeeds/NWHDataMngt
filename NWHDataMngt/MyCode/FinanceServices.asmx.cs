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
	/// Summary description for FinanceServices
	/// </summary>
	[WebService(Namespace = "http://tempuri.org/")]
	[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
	[System.ComponentModel.ToolboxItem(false)]
	// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
	[System.Web.Script.Services.ScriptService]
	public class FinanceServices : System.Web.Services.WebService
	{
		
		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string DeleteInvRequestLine (int PgID, int ObjID, int InvRequestID, int ItemNbr, int LineID, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				DocsForms df = new DocsForms();
				DataTable dt = df.DeleteInvRequestLine(InvRequestID, ItemNbr, LineID, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "DeleteInvRequestLine", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Del InvReq Line", LineID, ByID, ex.Message, 0, "DeleteInvRequestLine function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectCarrierList(int PgID, int ObjID, string VendName, int Sort, int Active, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				DataTable dt = cmd.SelectCarrierList(VendName, Sort, Active, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectCarrierList", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Carrier List", 0, ByID, ex.Message, 0, "SelectCarrierList function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectInvoiceData(int PgID, int ObjID, int InvoiceID, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				InvoiceLib i = new InvoiceLib();
				DataTable dt = i.SelectInvoiceData(InvoiceID, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectInvoiceData", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Invoice Data", InvoiceID, ByID, ex.Message, 0, "SelectInvoiceData function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectInvoiceItems(int PgID, int ObjID, int ReqID, int InvoiceID, string SubDocType, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				InvoiceLib i = new InvoiceLib();
				DataTable dt = i.SelectInvoiceItems(ReqID, InvoiceID, SubDocType, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectInvoiceItems", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Invoice Items", InvoiceID, ByID, ex.Message, 0, "SelectInvoiceItems function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectInvoiceItems2(int PgID, int ObjID, int InvoiceID, int Thin, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				InvoiceLib i = new InvoiceLib();
				DataTable dt = i.SelectInvoiceItems2(InvoiceID, Thin, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectInvoiceItems", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Invoice Items", InvoiceID, ByID, ex.Message, 0, "SelectInvoiceItems function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		// brings back one document type in a request ID
		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectInvoiceRequestData(int PgID, int ObjID, int InvReqID, int ByID)
		{
			// Pulls list of doc types for one request ID
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				InvoiceLib i = new InvoiceLib();
				DataTable dt = i.SelectInvoiceRequestData(InvReqID, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectInvoiceRequestData", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("InvAdj Data", InvReqID, ByID, ex.Message, 0, "SelectInvoiceRequestData function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectLocationList(int PgID, int ObjID, string Loc, string LocType, string Country, string City, int Sort, int Class, int Active, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				DataTable dt = cmd.GetLocationList(Loc, LocType, Country, City, Sort, Class, Active, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectLocationList", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Loc List", 0, ByID, ex.Message, 0, "SelectLocationList function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}
		Commands cmd = new Commands();

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectProductTypeList(int PgID, int ObjID, string ProdType, int Sort, int Active, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				DataTable dt = cmd.SelectProductTypesList(ProdType, Sort, Active, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectProductTypeList", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("ProdType List", 0, ByID, ex.Message, 0, "SelectProductTypeList function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectPersListForPosition(int PgID, int ObjID, string Pos, int Sort, int Active, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				DataTable dt = cmd.SelectUserListForPosition(Pos, Sort, Active, ByID);  //"SALES"
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectLocationList", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Loc List", 0, ByID, ex.Message, 0, "SelectLocationList function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		// brings back main request item data
		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectRequestData(int PgID, int ObjID, int RequestID, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				InvoiceLib il = new InvoiceLib();
				DataTable dt = il.SelectRequestData(RequestID, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectRequestData", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Req Data", RequestID, ByID, ex.Message, 0, "SelectRequestData function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectRequestDocsData (int PgID, int ObjID, int ReqID, int InvReqID, int ByID)
		{
			// Pulls list of doc types for one request ID
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				InvoiceLib i = new InvoiceLib();
				DataTable dt = i.SelectRequestDocsData(ReqID, InvReqID, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectInvoiceRequestData", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("InvAdj Data", InvReqID, ByID, ex.Message, 0, "SelectInvoiceRequestData function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string SelectVendorList(int PgID, int ObjID, string Seed, int Sort, int Min, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				InvoiceLib il = new InvoiceLib();
				DataTable dt = il.SelectVendorList(Seed, Sort, Min, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectVendorList", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Vendor List", 0, ByID, ex.Message, 0, "SelectVendorList function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string UpdateInvRequestData(int PgID, int ObjID, int RequestID, int InvReqID, string DtReq, int ReqByID, string DocType, int DispID, string StatusCode, string CustCode, string CustCtlNbr, int CarrierID, 
			string VendorCode, int InvNbr, string InvDt, int OrdNbr, int ShipNbr, int OtherNbr1, int OtherNbr2, int OtherNbr3, int CreditRepID, int SalesPID, string SalesLead, string ShipFmLoc, string LocCode2, 
			string LocCode3, string ReasonCode, string ReasonDetail, int CustReqCopy, int Setting1, int Setting2, int Setting3, int Setting4, int Setting5, int Setting6, double OrigAmt, double AdjInvoiceAmt, 
			double AdjAmt, double FrtRate, double OtherAmt, string OtherVal1, string OtherVal2, string ProdVal1, string ProdVal2, string ProdVal3, string RequiredDt, string TgtDT, string ActDate1, string ActDate2, 
			string TransDT1, string TransDT2, int NbrProd, int Active, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				InvoiceLib inv = new InvoiceLib();
				DataTable dt = inv.UpdateInvRequestData(RequestID, InvReqID, DtReq, ReqByID, DocType, DispID, StatusCode, CustCode, CustCtlNbr, CarrierID, VendorCode, InvNbr, InvDt, OrdNbr, ShipNbr, OtherNbr1, OtherNbr2, OtherNbr3, 
					CreditRepID, SalesPID, SalesLead, ShipFmLoc, LocCode2, LocCode3, ReasonCode, ReasonDetail, CustReqCopy, Setting1, Setting2, Setting3, Setting4, Setting5, Setting6, OrigAmt, AdjInvoiceAmt, AdjAmt, FrtRate, 
					OtherAmt, OtherVal1, OtherVal2, ProdVal1, ProdVal2, ProdVal3, RequiredDt, TgtDT, ActDate1, ActDate2, TransDT1, TransDT2, NbrProd, Active, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "UpdateInvRequestData", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Upd InvRequest", InvReqID, ByID, ex.Message, 0, "UpdateInvRequestData function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string UpdateInvRequestLine(int PgID, int ObjID, int IRLineID, int InvReqID, int ItemNbr, int iDocType, string ProdType, string ProdCode, string Desc, string A1, string A2, string A3, string A4, string A5, string A6, string A7, string A8,
			string A9, string A10, string A11, string A12, string A13, double OrigQty, double OrigQty2, double RevQty, double RevQty2, double OrigPrice, double RevPrice, double TotalCRDBAmt, int InvAdj, int RedTag, double RtnQty, double RtnPkg,
			double RtnQtyCheckedIn, string Tickets, string Explanation, string LocCode, int IsRtn, int Active, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				InvoiceLib inv = new InvoiceLib();
				DataTable dt = inv.UpdateInvRequestLine(IRLineID, InvReqID, ItemNbr, iDocType, ProdType, ProdCode, Desc, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, OrigQty, OrigQty, RevQty, RevQty2, OrigPrice, RevPrice, TotalCRDBAmt,
					InvAdj, RedTag, RtnQty, RtnPkg, RtnQtyCheckedIn, Tickets, Explanation, LocCode, IsRtn, Active, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "UpdateInvRequestLine", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Upd InvRequest Line", IRLineID, ByID, ex.Message, 0, "UpdateInvRequestLine function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

		[WebMethod]
		[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
		public string UpdateRequest(int PgID, int ObjID, int ReqID, string sDate, int ReqByID, int DispID, string Stat, int NbrComp, int Critical, int InvNbr, int OrdNbr, string Cmt, string EmailTo, string DocTypes, 
			string DocTypeIDs, string RequiredOn, int Active, int ByID)
		{
			Commands cmd = new Commands();
			string s = string.Empty;
			int iResult = 0;
			try
			{
				InvoiceLib inv = new InvoiceLib();
				DataTable dt = inv.UpdateRequest(ReqID, sDate, ReqByID, DispID, Stat, NbrComp, Critical, InvNbr, OrdNbr, Cmt, EmailTo, DocTypes, DocTypeIDs, RequiredOn, Active, ByID);
				s = GenUtilities.JSON(dt);
				iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "UpdateRequest", s.Length, ByID);
				return s;
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("Upd Request", ReqID, ByID, ex.Message, 0, "UpdateRequest function", ByID);
				JavaScriptSerializer js = new JavaScriptSerializer();
				var response = new { success = "false", message = ex.Message };
				return response.ToJSON();
			}
		}

	}
}
