using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace DataLayer
{
	public class RequestMngt
	{

		public DataTable CancelRequest(int ReqID, int RequestorID, string Cmt, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@RequestID", ReqID);
			SqlParameter p2 = new SqlParameter("@RequestorID", RequestorID);
			SqlParameter p3 = new SqlParameter("@Comments", Cmt);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_CancelRequest", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable InsertRequest(string DocTypeCode, int ReqTypeID, int RequestorID, string Title, string Desc, string sReqDT, string BDt, string EDt, int PriID, int SrcID, int SrcTypeID, string ApproverBlock, string Cmt,
			int AfterActID, string DocLink, int ByID)
		{
			// ApproverBLock -- |step:UserType:UserID:UserIdent:ApproverType:ApprovalType|
			DateTime? bdate = null;
			DateTime? edate = null;
			DateTime? rdate = null;
			if (BDt != "") { bdate = Convert.ToDateTime(BDt); }
			if (EDt != "") { edate = Convert.ToDateTime(EDt); }
			if (sReqDT != "") { rdate = Convert.ToDateTime(sReqDT); }
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@DocTypeCode", DocTypeCode);
			SqlParameter p2 = new SqlParameter("@ReqTypeID", ReqTypeID);
			SqlParameter p3 = new SqlParameter("@RequestorID", RequestorID);
			SqlParameter p4 = new SqlParameter("@RequestTitle", Title);
			SqlParameter p5 = new SqlParameter("@ReqDesc", Desc);
			SqlParameter p6 = new SqlParameter("@ReqDateTime", rdate);
			SqlParameter p7 = new SqlParameter("@ReqBeginDate", bdate);
			SqlParameter p8 = new SqlParameter("@ReqEndDate", edate);
			SqlParameter p9 = new SqlParameter("@PriID", PriID);
			SqlParameter p10 = new SqlParameter("@SourceID", SrcID);
			SqlParameter p11 = new SqlParameter("@SrcTypeID", SrcTypeID);
			SqlParameter p12 = new SqlParameter("@ApproverIDs", ApproverBlock);
			SqlParameter p13 = new SqlParameter("@Comments", Cmt);
			SqlParameter p14 = new SqlParameter("@AfterActID", AfterActID);
			SqlParameter p15 = new SqlParameter("@DocLink", DocLink);
			SqlParameter p16 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_InsertRequest", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16 });
		}

		public DataTable SelectUserRequestData(int ReqID, int UserID, int ReqTypeID, int ListType, int Sort, int Hist, string BDt, string EDt, int PgNbr, int PgSize, int ByID)
		{
			DateTime? bdate = null;
			DateTime? edate = null;
			if (BDt != "") { bdate = Convert.ToDateTime(BDt); }
			if (EDt != "") { edate = Convert.ToDateTime(EDt); }
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ReqID", ReqID);
			SqlParameter p2 = new SqlParameter("@UserID", UserID);
			SqlParameter p3 = new SqlParameter("@ReqTypeID", ByID);
			SqlParameter p4 = new SqlParameter("@ListType", ListType);
			SqlParameter p5 = new SqlParameter("@Sort", Sort);
			SqlParameter p6 = new SqlParameter("@Hist", Hist);
			SqlParameter p7 = new SqlParameter("@BDate", bdate);
			SqlParameter p8 = new SqlParameter("@EDate", edate);
			SqlParameter p9 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p10 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p11 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectUserRequestData", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11 });
		}

		public DataTable UpdateRequest(int ReqID, int ReqTypeID, int UserID, string Title, string Desc, int PriID, int CurrStepNbr, string BDt, string EDt, string DDt, string DocLink, string Decision,
			int SrcID, int SrcTypeID, int AfterActID, string Comments, int Final, string Steps, int Active, int ByID)
		{
			DateTime? bdate = null;
			DateTime? edate = null;
			DateTime? ddate = null;
			if (BDt != "") { bdate = Convert.ToDateTime(BDt); }
			if (EDt != "") { edate = Convert.ToDateTime(EDt); }
			if (DDt != "") { ddate = Convert.ToDateTime(DDt); }
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ReqID", ReqID);
			SqlParameter p2 = new SqlParameter("@ReqTypeID", ReqTypeID);
			SqlParameter p3 = new SqlParameter("@ReqUserID", UserID);
			SqlParameter p4 = new SqlParameter("@Title", Title);
			SqlParameter p5 = new SqlParameter("@Desc", Desc);
			SqlParameter p6 = new SqlParameter("@PriID", PriID);
			SqlParameter p7 = new SqlParameter("@CurrStepNbr", CurrStepNbr);
			SqlParameter p8 = new SqlParameter("@BDate", bdate);
			SqlParameter p9 = new SqlParameter("@EDate", edate);
			SqlParameter p10 = new SqlParameter("@DueDateTime", ddate);
			SqlParameter p11 = new SqlParameter("@DocLink", DocLink);
			SqlParameter p12 = new SqlParameter("@ByID", Decision);
			SqlParameter p13 = new SqlParameter("@ByID", SrcID);
			SqlParameter p14 = new SqlParameter("@ByID", SrcTypeID);
			SqlParameter p15 = new SqlParameter("@ByID", AfterActID);
			SqlParameter p16 = new SqlParameter("@ByID", Comments);
			SqlParameter p17 = new SqlParameter("@ByID", Final);
			SqlParameter p18 = new SqlParameter("@ByID", Steps);
			SqlParameter p19 = new SqlParameter("@Active", Active);
			SqlParameter p20 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateRequestDecision", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11,p12, p13, p14, p15, p16, p17, p18, p19, p20 });
		}

		public DataTable UpdateRequestDecision(int ReqID, string sGuid, int StepNbr, string Decision, string Comments, int ByID)
		{
			Guid g = new Guid();
			if (sGuid == "") { sGuid = g.ToString(); }
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ReqID", ReqID);
			SqlParameter p2 = new SqlParameter("@Guid", sGuid);
			SqlParameter p3 = new SqlParameter("@StepNbr", StepNbr);
			SqlParameter p4 = new SqlParameter("@Decision", Decision);
			SqlParameter p5 = new SqlParameter("@Comments", Comments);
			SqlParameter p6 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateRequestDecision", new SqlParameter[] { p1, p2, p3, p4, p5, p6 });
		}

	}
}
