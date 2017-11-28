using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace DataLayer
{
  public class InvoiceLib
  {
    public DataTable GetInvoiceSalesPersList(int Sort, int ByID)
    {
      DBInterface di = new DBInterface();
      SqlParameter p1 = new SqlParameter("@Sort", Sort);
      SqlParameter p2 = new SqlParameter("@ByID", ByID);
      return di.RunSPReturnDataTableNWDW("web.usp_SelectInvoiceSalesPersList", new SqlParameter[] { p1, p2 });
    }

    public DataTable GetInvoiceTypesList(int Sort, int Active, int ByID)
    {
      DBInterface di = new DBInterface();
      SqlParameter p1 = new SqlParameter("@Type", "Inv-Type");
      SqlParameter p2 = new SqlParameter("@Sort", Sort);
      SqlParameter p3 = new SqlParameter("@Active", Active);
      SqlParameter p4 = new SqlParameter("@ByID", ByID);
      return di.RunSPReturnDataTable("web.usp_SelectCodeGroup", new SqlParameter[] { p1, p2, p3, p4 });
    }

    public DataTable SelectARAgingData(string Company, string CreditGrp, string SalesPers, string Cust, string CustNbr, string ARType, string SalesGrp, string Controller, string PayTerms, string Country, string Branch, 
      string Currency, DateTime? AsOfDate, int Threshold, DateTime? BeginDt, string Src, int Sort, int ByID)
    {
      DBInterface di = new DBInterface();
      SqlParameter p1 = new SqlParameter("@Company", Company);
      SqlParameter p2 = new SqlParameter("@CreditGroup", CreditGrp);
      SqlParameter p3 = new SqlParameter("@Salesperson", SalesPers);
      SqlParameter p4 = new SqlParameter("@Customer", Cust);
			SqlParameter p5 = new SqlParameter("@CustNbr", CustNbr);
			SqlParameter p6 = new SqlParameter("@ARType", ARType);
      SqlParameter p7 = new SqlParameter("@SalesGroup", SalesGrp);
      SqlParameter p8 = new SqlParameter("@Controller", Controller);
      SqlParameter p9 = new SqlParameter("@PaymentTerms", PayTerms);
      SqlParameter p10 = new SqlParameter("@Country", Country);
      SqlParameter p11 = new SqlParameter("@Branch", Branch);
      SqlParameter p12 = new SqlParameter("@Currency", Currency);
      SqlParameter p13 = new SqlParameter("@AsOfDate", AsOfDate);
			SqlParameter p14 = new SqlParameter("@Threshold", Threshold);
			SqlParameter p15 = new SqlParameter("@BeginDate", BeginDt);
			SqlParameter p16 = new SqlParameter("@Type", Src);
			SqlParameter p17 = new SqlParameter("@Sort", Sort);
			SqlParameter p18 = new SqlParameter("@ByID", ByID);
      return di.RunSPReturnDataTableNWDW("web.usp_SelectARAgingData", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18 });
    }

		public DataTable SelectControllerList(int Sort, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Sort", Sort);
			SqlParameter p2 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectControllerList", new SqlParameter[] { p1, p2 });
		}

		public DataTable SelectCreditGroupList(int Sort, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Sort", Sort);
			SqlParameter p2 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectCreditGroupList", new SqlParameter[] { p1, p2 });
		}

		public DataTable SelectInvoiceData(int InvID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@InvID", InvID);
			SqlParameter p2 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectInvoiceData", new SqlParameter[] { p1, p2 });
		}

		// main invoice request item data if ReqID > 0 else gets items for LTPROD invoice
		public DataTable SelectInvoiceItems(int ReqID, int InvID, string SubDocType, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ReqID", ReqID);
			SqlParameter p2 = new SqlParameter("@InvoiceID", InvID);
			SqlParameter p3 = new SqlParameter("@SubDocType", SubDocType);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectInvoiceItems", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable SelectInvoiceItems2(int InvID, int Thin, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@InvoiceID", InvID);
			SqlParameter p2 = new SqlParameter("@Thin", Thin);
			SqlParameter p3 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectLTInvoiceItems", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable SelectInvoiceRequestData(int InvReqID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@InvReqID", InvReqID);
			SqlParameter p2 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectInvoiceRequestData", new SqlParameter[] { p1, p2 });
		}

		public DataTable SelectProductData (int PMID, int PLID, string ProdType, string ProdCode, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@PMID", PMID);
			SqlParameter p2 = new SqlParameter("@PLID", PLID);
			SqlParameter p3 = new SqlParameter("@ProdType", ProdType);
			SqlParameter p4 = new SqlParameter("@ProdCode", ProdCode);
			SqlParameter p5 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectProductItemData", new SqlParameter[] { p1, p2, p3, p4, p5 });
		}

		public DataTable SelectRequestData(int ReqID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@RequestID", ReqID);
			SqlParameter p2 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectRequestData", new SqlParameter[] { p1, p2 });
		}

		// main invoice request retrieval
		public DataTable SelectRequestDocsData(int ReqID, int InvReqID, int ByID)
		{
			// pulls list of doc types for one request ID
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@RequestID", ReqID);
			SqlParameter p2 = new SqlParameter("@InvRequestID", InvReqID);
			SqlParameter p3 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectRequestDocumentData", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable SelectSalesGroupList(int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Active", Active);
			SqlParameter p2 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectSalesGroupList", new SqlParameter[] { p1, p2 });
		}

		public DataTable SelectVendorList(string Seed, int Sort, int Min, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Seed", Seed);
			SqlParameter p2 = new SqlParameter("@Sort", Sort);
			SqlParameter p3 = new SqlParameter("@Min", Min);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectLTVendorList", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable UpdateInvRequestStatus(int InvReqID, string StatusCode, string Cmt, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@InvReqID", InvReqID);
			SqlParameter p2 = new SqlParameter("@StatusCode", StatusCode);
			SqlParameter p3 = new SqlParameter("@Comments", Cmt);
			SqlParameter p4 = new SqlParameter("@Quiet", 0);
			SqlParameter p5 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateInvRequestStatus", new SqlParameter[] { p1, p2, p3, p4, p5 });
		}

		public DataTable UpdateInvRequestData(int RequestID, int InvReqID, string DtReq, int ReqByID, string DocType, int DispID, string StatusCode, string CustCode, string CustCtlNbr, int CarrierID, string VendorCode, 
			int InvNbr, string InvDt, int OrdNbr, int ShipNbr, int OtherNbr1, int OtherNbr2, int OtherNbr3, int CreditRepID, int SalesPID, string SalesLead, string ShipFmLoc, string LocCode2, string LocCode3, 
			string ReasonCode, string ReasonDetail, int CustReqCopy, int Setting1, int Setting2, int Setting3, int Setting4, int Setting5, int Setting6, double OrigAmt, double AdjInvoiceAmt, double AdjAmt, 
			double FrtRate, double OtherAmt, string OtherVal1, string OtherVal2, string ProdVal1, string ProdVal2, string ProdVal3, string RequiredDt, string TgtDT, string ActDate1, string ActDate2, string TransDT1, 
			string TransDT2, int NbrProd, int Active, int ByID)
		{
			DateTime? datereq = null;
			DateTime? reqdate = null;
			DateTime? invdate = null;
			DateTime? tgtdate = null;
			DateTime? adate1 = null;
			DateTime? adate2 = null;
			DateTime? tdate1 = null;
			DateTime? tdate2 = null;
			if (DtReq.Length > 0) { datereq = Convert.ToDateTime(DtReq); }
			if (InvDt.Length > 0) { invdate = Convert.ToDateTime(InvDt); }
			if (RequiredDt.Length > 0) { reqdate = Convert.ToDateTime(RequiredDt); }
			if (TgtDT.Length > 0) { tgtdate = Convert.ToDateTime(TgtDT); }
			if (ActDate1.Length > 0) { adate1 = Convert.ToDateTime(ActDate1); }
			if (ActDate2.Length > 0) { adate2 = Convert.ToDateTime(ActDate2); }
			if (TransDT1.Length > 0) { tdate1 = Convert.ToDateTime(TransDT1); }
			if (TransDT2.Length > 0) { tdate2 = Convert.ToDateTime(TransDT2); }
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@RequestID", RequestID);
			SqlParameter p2 = new SqlParameter("@InvReqID", InvReqID);
			SqlParameter p3 = new SqlParameter("@DataReq", datereq);
			SqlParameter p4 = new SqlParameter("@ReqByID", ReqByID);
			SqlParameter p5 = new SqlParameter("@DocTypeCode", DocType);
			SqlParameter p6 = new SqlParameter("@DisplayID", DispID);
			SqlParameter p7 = new SqlParameter("@Status", StatusCode);
			SqlParameter p8 = new SqlParameter("@CustCode", CustCode);
			SqlParameter p9 = new SqlParameter("@CustCntlNbr", CustCtlNbr);
			SqlParameter p10 = new SqlParameter("@CarrierID", CarrierID);
			SqlParameter p11 = new SqlParameter("@VendorCode", VendorCode);
			SqlParameter p12 = new SqlParameter("@InvoiceNbr", InvNbr);
			SqlParameter p13 = new SqlParameter("@InvoiceDate", invdate);
			SqlParameter p14 = new SqlParameter("@OrdNbr", OrdNbr);
			SqlParameter p15 = new SqlParameter("@ShipNbr", ShipNbr);
			SqlParameter p16 = new SqlParameter("@OtherNbr1", OtherNbr1);
			SqlParameter p17 = new SqlParameter("@OtherNbr2", OtherNbr2);
			SqlParameter p18 = new SqlParameter("@OtherNbr3", OtherNbr3);
			SqlParameter p19 = new SqlParameter("@CreditRepID", CreditRepID);
			SqlParameter p20 = new SqlParameter("@SalespID", SalesPID);
			SqlParameter p21 = new SqlParameter("@SalesLeadCode", SalesLead);
			SqlParameter p22 = new SqlParameter("@ShipFmLocCode", ShipFmLoc);
			SqlParameter p23 = new SqlParameter("@LocCode2", LocCode2);
			SqlParameter p24 = new SqlParameter("@LocCode3", LocCode3);
			SqlParameter p25 = new SqlParameter("@ReasonCode", ReasonCode);
			SqlParameter p26 = new SqlParameter("@ReasonForAdj", ReasonDetail);
			SqlParameter p27 = new SqlParameter("@CustReqCopy", CustReqCopy);
			SqlParameter p28 = new SqlParameter("@Setting1", Setting1);
			SqlParameter p29 = new SqlParameter("@Setting2", Setting2);
			SqlParameter p30 = new SqlParameter("@Setting3", Setting3);
			SqlParameter p31 = new SqlParameter("@Setting4", Setting4);
			SqlParameter p32 = new SqlParameter("@Setting5", Setting5);
			SqlParameter p33 = new SqlParameter("@Setting6", Setting6);
			SqlParameter p34 = new SqlParameter("@OrigInvAmt", OrigAmt);
			SqlParameter p35 = new SqlParameter("@AdjInvoiceAmt", AdjInvoiceAmt);
			SqlParameter p36 = new SqlParameter("@AdjustmentAmt", AdjAmt);
			SqlParameter p37 = new SqlParameter("@FreightRate", FrtRate);
			SqlParameter p38 = new SqlParameter("@OtherAmt", OtherAmt);
			SqlParameter p39 = new SqlParameter("@OtherVal1", OtherVal1);
			SqlParameter p40 = new SqlParameter("@OtherVal2", OtherVal2);
			SqlParameter p41 = new SqlParameter("@ProdValue1", ProdVal1);
			SqlParameter p42 = new SqlParameter("@ProdValue2", ProdVal2);
			SqlParameter p43 = new SqlParameter("@ProdValue3", ProdVal3);
			SqlParameter p44 = new SqlParameter("@RequiredDate", reqdate);
			SqlParameter p45 = new SqlParameter("@TargetDate", tgtdate);
			SqlParameter p46 = new SqlParameter("@ActionDate1", adate1);
			SqlParameter p47 = new SqlParameter("@ActionDate2", adate2);
			SqlParameter p48 = new SqlParameter("@TransDT1", tdate1);
			SqlParameter p49 = new SqlParameter("@TransDT2", tdate2);
			SqlParameter p50 = new SqlParameter("@NbrProdItems", NbrProd);
			SqlParameter p51 = new SqlParameter("@Active", Active);
			SqlParameter p52 = new SqlParameter("@Quiet", 0);
			SqlParameter p53 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateInvoiceRequestData", new SqlParameter[] { p1, p2, p3, p4,p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53 });
		}

		public DataTable UpdateInvRequestLine(int IRLineID, int InvReqID, int ItemNbr, int iDocType, string ProdType, string ProdCode, string Desc, string A1, string A2, string A3, string A4, string A5, string A6, string A7, string A8,
			string A9, string A10, string A11, string A12, string A13, double OrigQty, double OrigQty2, double RevQty, double RevQty2, double OrigPrice, double RevPrice, double TotalCRDBAmt, int InvAdj, int RedTag, double RtnQty, double RtnPkg,
			double RtnQtyCheckedIn, string Tickets, string Explanation, string LocCode, int IsRtn, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@InvReqItemID", IRLineID);
			SqlParameter p2 = new SqlParameter("@InvReqID", InvReqID);
			SqlParameter p3 = new SqlParameter("@ItemNbr", ItemNbr);
			SqlParameter p4 = new SqlParameter("@SubDocType", iDocType);
			SqlParameter p5 = new SqlParameter("@LocCode", LocCode);
			SqlParameter p6 = new SqlParameter("@ProdType", ProdType);
			SqlParameter p7 = new SqlParameter("@ProdCode", ProdCode);
			SqlParameter p8 = new SqlParameter("@Desc", Desc);
			SqlParameter p9 = new SqlParameter("@Attrib01", A1);
			SqlParameter p10 = new SqlParameter("@Attrib02", A2);
			SqlParameter p11 = new SqlParameter("@Attrib03", A3);
			SqlParameter p12 = new SqlParameter("@Attrib04", A4);
			SqlParameter p13 = new SqlParameter("@Attrib05", A5);
			SqlParameter p14 = new SqlParameter("@Attrib06", A6);
			SqlParameter p15 = new SqlParameter("@Attrib07", A7);
			SqlParameter p16 = new SqlParameter("@Attrib08", A8);
			SqlParameter p17 = new SqlParameter("@Attrib09", A9);
			SqlParameter p18 = new SqlParameter("@Attrib10", A10);
			SqlParameter p19 = new SqlParameter("@Attrib11", A11);
			SqlParameter p20 = new SqlParameter("@Attrib12", A12);
			SqlParameter p21 = new SqlParameter("@Attrib13", A13);
			SqlParameter p22 = new SqlParameter("@OrigQty", OrigQty);
			SqlParameter p23 = new SqlParameter("@OrigQty2", OrigQty2);
			SqlParameter p24 = new SqlParameter("@RevisedQty", RevQty);
			SqlParameter p25 = new SqlParameter("@RevisedQty2", RevQty2);
			SqlParameter p26 = new SqlParameter("@OrigPrice", OrigPrice);
			SqlParameter p27 = new SqlParameter("@RevisedPrice", RevPrice);
			SqlParameter p28 = new SqlParameter("@TotalCRDBAmt", TotalCRDBAmt);
			SqlParameter p29 = new SqlParameter("@InvAdj", InvAdj);
			SqlParameter p30 = new SqlParameter("@RedTag", RedTag);
			SqlParameter p31 = new SqlParameter("@RtnQty", RtnQty);
			SqlParameter p32 = new SqlParameter("@RtnPkgCount", RtnPkg);
			SqlParameter p33 = new SqlParameter("@RtnQtyCheckIn", RtnQtyCheckedIn);
			SqlParameter p34 = new SqlParameter("@TicketNbrs", Tickets);
			SqlParameter p35 = new SqlParameter("@Explanation", Explanation);
			SqlParameter p36 = new SqlParameter("@IsReturn", IsRtn);
			SqlParameter p37 = new SqlParameter("@Active", Active);
			SqlParameter p38 = new SqlParameter("@Quiet", 0);
			SqlParameter p39 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateInvoiceRequestLine", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39 });
		}

		public DataTable UpdateInvAdjustmentStatus(int InvAdjID, string StatusCode, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@InvAdjID", InvAdjID);
			SqlParameter p2 = new SqlParameter("@StatusCode", StatusCode);
			SqlParameter p3 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateInvAdjustmentStatus", new SqlParameter[] { p1, p2 });
		}

		public DataTable UpdateRequest(int ReqID, string sDate, int ReqByID, int DispID, string Stat, int NbrComp, int Critical, int InvNbr, int OrdNbr, string Cmt, string EmailTo, string DocTypes, string DocTypeIDs,
			string RequiredOn, int Active, int ByID)
		{
			DateTime? rdate = null;
			DateTime? requireddate = null;
			if (sDate.Length > 0) { rdate = Convert.ToDateTime(sDate); }
			if (RequiredOn.Length > 0) { requireddate = Convert.ToDateTime(RequiredOn); }
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@RequestID", ReqID);
			SqlParameter p2 = new SqlParameter("@ReqDate", rdate);
			SqlParameter p3 = new SqlParameter("@ReqByID", ReqByID);
			SqlParameter p4 = new SqlParameter("@DisplayID", DispID);
			SqlParameter p5 = new SqlParameter("@Status", Stat);
			SqlParameter p6 = new SqlParameter("@NbrComp", NbrComp);
			SqlParameter p7 = new SqlParameter("@Critical", Critical);
			SqlParameter p8 = new SqlParameter("@InvoiceNbr", InvNbr);
			SqlParameter p9 = new SqlParameter("@OrdNbr", OrdNbr);
			SqlParameter p10 = new SqlParameter("@RequiredDate", RequiredOn);
			SqlParameter p11 = new SqlParameter("@Cmt", Cmt);
			SqlParameter p12 = new SqlParameter("@ExtraEmailTo", EmailTo);
			SqlParameter p13 = new SqlParameter("@DocTypes", DocTypes);
			SqlParameter p14 = new SqlParameter("@DocTypeIDs", DocTypeIDs);
			SqlParameter p15 = new SqlParameter("@Active", Active);
			SqlParameter p16 = new SqlParameter("@Quiet", 0);
			SqlParameter p17 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateRequest", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17 });
		}

	}
}
