using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace DataLayer
{
	public class DocsForms
	{

		public DataTable DeleteInvRequestLine(int InvRequestID, int ItemNbr, int LineID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@InvRequestID", InvRequestID);
			SqlParameter p2 = new SqlParameter("@ItemNbr", ItemNbr);
			SqlParameter p3 = new SqlParameter("@LineID", LineID);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_DeleteInvRequestLine", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable SelectDocTypeAssociations(string DocTypeCode, int iType, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@DocTypeCode", DocTypeCode);
			SqlParameter p2 = new SqlParameter("@Type", iType);
			SqlParameter p3 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectDocTypeAssociations", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable SelectDocumentData(int DocID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@DocumentID", DocID);
			SqlParameter p2 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectDocumentData", new SqlParameter[] { p1, p2 });
		}

		public DataTable SelectDocumentStatusChangeList(int ReqID, int InvReqID, int Sort, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ReqID", ReqID);
			SqlParameter p2 = new SqlParameter("@InvoiceReqID", InvReqID);
			SqlParameter p3 = new SqlParameter("@Sort", Sort); 
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectDocumentStatusChanges", new SqlParameter[] { p1, p2, p3,p4 });
		}

		public DataTable SelectRequestListALL(string DocTypeCode, int CreditRpID, int SalesRpID, string Cust, int OrdNbr, string Reason, string Status, string Loc, string sBDt, string sEDt, int Sort, int PgNbr, int PgSize, int ByID)
		{
			DateTime? sdate = null;
			DateTime? edate = null;
			if (sBDt.Length > 0) { sdate = Convert.ToDateTime(sBDt); }
			if (sEDt.Length > 0) { edate = Convert.ToDateTime(sEDt); }
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@DocTypeCode", DocTypeCode);
			SqlParameter p2 = new SqlParameter("@CreditRepID", CreditRpID);
			SqlParameter p3 = new SqlParameter("@SalesRepID", SalesRpID);
			SqlParameter p4 = new SqlParameter("@Cust", Cust);
			SqlParameter p5 = new SqlParameter("@OrdNbr", Sort);
			SqlParameter p6 = new SqlParameter("@Reason", Reason);
			SqlParameter p7 = new SqlParameter("@Status", Status);
			SqlParameter p8 = new SqlParameter("@Loc", Loc);
			SqlParameter p9 = new SqlParameter("@BDate", sdate);
			SqlParameter p10 = new SqlParameter("@EDate", edate);
			SqlParameter p11 = new SqlParameter("@Sort", Sort);
			SqlParameter p12 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p13 = new SqlParameter("@PgSzie", PgSize);
			SqlParameter p14 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectRequestListALL", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14 });
		}

	}
}
