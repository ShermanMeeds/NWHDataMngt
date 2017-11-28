using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace DataLayer
{
	public class GenManage
	{
		public DataTable CreateWeeklyReport(int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableAD("web.usp_CreateWeeklyReport", new SqlParameter[] { p1 });
		}

		public DataTable DeleteManagementItem(int ID, int iType, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@Type", iType);
			SqlParameter p3 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableAD("Maint.usp_DeleteManagementItem", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable GetUserDocRights(string DocType, int RequestID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@DocTypeCode", DocType);
			SqlParameter p2 = new SqlParameter("@RequestID", RequestID);
			SqlParameter p3 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_GetUserDocumentRights", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable SelectAdministrativeLogs(int LogTypeID, string AppName, string DBName, string Schema, string Subj, string Body, DateTime? TargetDtB, DateTime? TargetDtE, int TargetID, int ErrID, int ID, string sID, int Sort,
			int PgNbr, int PgSize, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@LogTypeID", LogTypeID);
			SqlParameter p2 = new SqlParameter("@AppName", AppName);
			SqlParameter p3 = new SqlParameter("@DBName", DBName);
			SqlParameter p4 = new SqlParameter("@Schema", Schema);
			SqlParameter p5 = new SqlParameter("@Subj", Subj);
			SqlParameter p6 = new SqlParameter("@Body", Body);
			SqlParameter p7 = new SqlParameter("@BDate", TargetDtB);
			SqlParameter p8 = new SqlParameter("@EDate", TargetDtE);
			SqlParameter p9 = new SqlParameter("@TargetID", TargetID);
			SqlParameter p10 = new SqlParameter("@ErrorID", ErrID);
			SqlParameter p11 = new SqlParameter("@ID", ID);
			SqlParameter p12 = new SqlParameter("@sID", sID);
			SqlParameter p13 = new SqlParameter("@Sort", Sort);
			SqlParameter p14 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p15 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p16 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWM("Maint.usp_SelectAdminLog", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16 });
		}

		public DataTable SelectAppAreaList(int ID, string AppCode, string AreaCode, int Sort, int Active, int ByID)
		{
			if (AppCode == "") { AppCode = "DataMngt"; }
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@AppCode", AppCode);
			SqlParameter p3 = new SqlParameter("@AreaCode", AreaCode);
			SqlParameter p4 = new SqlParameter("@Sort", Sort);
			SqlParameter p5 = new SqlParameter("@Active", Active);
			SqlParameter p6 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectAppAreaList", new SqlParameter[] { p1, p2, p3, p4, p5, p6 });
		}

		public DataTable SelectAppAreaRightsList(int ID, string AppCode, string AppArea, int Primary, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@AppCode", AppCode);
			SqlParameter p3 = new SqlParameter("@AppArea", AppArea);
			SqlParameter p4 = new SqlParameter("@Primary", Primary);
			SqlParameter p5 = new SqlParameter("@Sort", Sort);
			SqlParameter p6 = new SqlParameter("@Active", Active);
			SqlParameter p7 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectAppAreaRightsList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7 });
		}

		public DataTable SelectApplicationList(int ID, int Sort, int Current, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppID", ID);
			SqlParameter p2 = new SqlParameter("@Sort", Sort);
			SqlParameter p3 = new SqlParameter("@CurrentOnly", Current);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectApplicationList", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable SelectCodeValueList(int PageID, int ObjID, int CodeID, string CodeValue, string CdName, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@PageID", PageID);
			SqlParameter p2 = new SqlParameter("@ObjID", ObjID);
			SqlParameter p3 = new SqlParameter("@CodeID", CodeID);
			SqlParameter p4 = new SqlParameter("@CodeValue", CodeValue);
			SqlParameter p5 = new SqlParameter("@Name", CdName);
			SqlParameter p6 = new SqlParameter("@Sort", Sort);
			SqlParameter p7 = new SqlParameter("@Active", Active);
			SqlParameter p8 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectCodeValueList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8 });
		}

		public DataTable SelectDesignComponentList(int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Sort", Sort);
			SqlParameter p2 = new SqlParameter("@Active", Active);
			SqlParameter p3 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("dbo.usp_SelectDesignComponentList", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable SelectDocStatusFlow(string DocTypeCode, int RowID, string OldStat, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@DocTypeCode", DocTypeCode);
			SqlParameter p2 = new SqlParameter("@RowID", RowID);
			SqlParameter p3 = new SqlParameter("@OldStatusCode", OldStat);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectDocumentStatusFlow", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable SelectEmailAddressList(int NotifID, int Error, string AddrType, int Active, int Sort, int PgNbr, int PgSize, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@NotificationID", NotifID);
			SqlParameter p2 = new SqlParameter("@ErrorCondition", Error);
			SqlParameter p3 = new SqlParameter("@EmailAddrType", AddrType);
			SqlParameter p4 = new SqlParameter("@Active", Active);
			SqlParameter p5 = new SqlParameter("@Sort", Sort);
			SqlParameter p6 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p7 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p8 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWM("dbo.usp_SelectEmailAddressList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8 });
		}

		public DataTable SelectEmailAddresses(string AppCode, string GrpCode, int IncAdmin, int IncGlobal, int IncNbr, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppCode", AppCode);
			SqlParameter p2 = new SqlParameter("@GrpCode", GrpCode);
			SqlParameter p3 = new SqlParameter("@IncAdmins", IncAdmin);
			SqlParameter p4 = new SqlParameter("@IncGlobal", IncGlobal);
			SqlParameter p5 = new SqlParameter("@IncNbr", IncNbr);
			SqlParameter p6 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectEmailAddrList", new SqlParameter[] { p1, p2, p3, p4, p5, p6 });
		}

		public DataTable SelectEmailRecords(int DBID, string App, int SentOnly, int Sort, int PgNbr, int PgSize, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@DatabaseID", DBID);
			SqlParameter p2 = new SqlParameter("@AppName", App);
			SqlParameter p3 = new SqlParameter("@SentOnly", SentOnly);
			SqlParameter p4 = new SqlParameter("@Sort", Sort);
			SqlParameter p5 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p6 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p7 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWM("dbo.usp_SelectEmailRecords", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7 });
		}

		public DataTable SelectEmailTemplateList(int TemplateID, string Code, string Name, string Subj, string Body, int Sort, int Active, int PgNbr, int PgSize, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@TemplateID", TemplateID);
			SqlParameter p2 = new SqlParameter("@Code", Code);
			SqlParameter p3 = new SqlParameter("@Name", Name);
			SqlParameter p4 = new SqlParameter("@Subj", Subj); //	 --0 - invalid,  FORECAST: 1 - Products, 2 - Mixes, 3 - MixContents, 4 - Forecast
			SqlParameter p5 = new SqlParameter("@Body", Body);
			SqlParameter p6 = new SqlParameter("@Sort", Sort);
			SqlParameter p7 = new SqlParameter("@Active", Active);
			SqlParameter p8 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p9 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p10 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWM("Maint.usp_SelectEmailTemplateList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10 });
		}

		public DataTable SelectIssueClassList(int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Sort", Sort);
			SqlParameter p2 = new SqlParameter("@Active", Active);
			SqlParameter p3 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("dbo.usp_SelectIssueClassList", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable SelectIssuesList(int ID, int Class, int iType, int AppArea, int DesignComp, string bdt, string edt, string ByPers, int Sort, int Active, int PgNbr, int PgSize, int ByID)
		{
			DBInterface di = new DBInterface();
			DateTime? bdate = null;
			DateTime? edate = null;
			if (bdt != "") { bdate = Convert.ToDateTime(bdt); }
			if (edt != "") { edate = Convert.ToDateTime(edt); }
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@ClassID", Class);
			SqlParameter p3 = new SqlParameter("@TypeID", iType);
			SqlParameter p4 = new SqlParameter("@AppAreaID", AppArea);
			SqlParameter p5 = new SqlParameter("@DesignCompID", DesignComp);
			SqlParameter p6 = new SqlParameter("@BDate", bdate);
			SqlParameter p7 = new SqlParameter("@EDate", edate);
			SqlParameter p8 = new SqlParameter("@ByPers", ByPers);
			SqlParameter p9 = new SqlParameter("@Sort", Sort);
			SqlParameter p10 = new SqlParameter("@Active", Active);
			SqlParameter p11 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p12 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p13 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("dbo.usp_SelectIssueList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13 });
		}

		public DataTable SelectIssueTypeList(int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Sort", Sort);
			SqlParameter p2 = new SqlParameter("@Active", Active);
			SqlParameter p3 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("dbo.usp_SelectIssueTypeList", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable SelectNotificationsList(int Sort, int PgNbr, int PgSize, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Sort", Sort);
			SqlParameter p2 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p3 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWM("Maint.usp_SelectNotificationTypeList", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable SelectPageList(int PageID, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@PageID", PageID);
			SqlParameter p2 = new SqlParameter("@Sort", Sort);
			SqlParameter p3 = new SqlParameter("@Active", Active);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectPageList", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable SelectPageObjectList (int iType, int PageID, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Type", iType);
			SqlParameter p2 = new SqlParameter("@PageID", PageID);
			SqlParameter p3 = new SqlParameter("@Sort", Sort);
			SqlParameter p4 = new SqlParameter("@Active", Active);
			SqlParameter p5 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectPageObjectList", new SqlParameter[] { p1, p2, p3, p4, p5 });
		}

		public DataTable SelectPageRightsList(int PageID, int ObjID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@PageID", PageID);
			SqlParameter p2 = new SqlParameter("@ObjectID", ObjID);
			SqlParameter p3 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectPageRightsList", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable SelectProcessList(int ProcID, int Sort, int Active, int PgNbr, int PgSize, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ProcessID", ProcID);
			SqlParameter p2 = new SqlParameter("@Active", Active);
			SqlParameter p3 = new SqlParameter("@Sort", Sort);
			SqlParameter p4 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p5 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p6 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWM("Maint.usp_SelectProcessList", new SqlParameter[] { p1, p2, p3, p4, p5, p6 });
		}

		public DataTable SelectProcessOwnerList(int ProcID, int UserID, string sName, int Sort, int Active, int PgNbr, int PgSize, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ProcessProcID", ProcID);
			SqlParameter p2 = new SqlParameter("@UserID", UserID);
			SqlParameter p3 = new SqlParameter("@Name", sName);
			SqlParameter p4 = new SqlParameter("@Sort", Sort);
			SqlParameter p5 = new SqlParameter("@Active", Active);
			SqlParameter p6 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p7 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p8 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectProcessOwnerList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8 });
		}

		public DataTable SelectProcessSettings(int ProcID, int DbID, string SeqCode, int Sort, int Active, int PgNbr, int PgSize, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ProcID", ProcID);
			SqlParameter p2 = new SqlParameter("@DbID", DbID);
			SqlParameter p3 = new SqlParameter("@SeqCode", SeqCode);
			SqlParameter p4 = new SqlParameter("@Sort", Sort);
			SqlParameter p5 = new SqlParameter("@Active", Active);
			SqlParameter p6 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p7 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p8 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWM("Maint.usp_SelectProcessSettings", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8 });
		}

		public DataTable SelectProcessStatusList(int ProcID, int UserID, int SeqType, int Sort, int Active, int PgNbr, int PgSize, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@UserID", UserID);
			SqlParameter p2 = new SqlParameter("@ProcessID", ProcID);
			SqlParameter p3 = new SqlParameter("@SeqType", SeqType);
			SqlParameter p4 = new SqlParameter("@Sort", Sort);
			SqlParameter p5 = new SqlParameter("@Active", Active);
			SqlParameter p6 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p7 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p8 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWM("Maint.usp_SelectProcessStatus", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8 });
		}

		public DataTable SelectSettingList(string AppArea, int ID, int Sort, int Active, int PgNbr, int PgSize, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppArea", AppArea);
			SqlParameter p2 = new SqlParameter("@ID", ID);
			SqlParameter p3 = new SqlParameter("@Sort", Sort);
			SqlParameter p4 = new SqlParameter("@Active", Active);
			SqlParameter p5 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p6 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p7 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectSettingsList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7 });
		}

		public DataTable SendEmailFromApp(string AppCode, int EmailID, string TemplateCode, string EmailTo, string EmailCC, string EmailBCC, string Grp, string Subj, string Body, string Impt, string Sens, string Fmt,
			int LogEmail, string EmpIDs, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppCode", AppCode);
			SqlParameter p2 = new SqlParameter("@EmailID", EmailID);
			SqlParameter p3 = new SqlParameter("@TemplateCode", TemplateCode);
			SqlParameter p4 = new SqlParameter("@EmailTo", EmailTo);
			SqlParameter p5 = new SqlParameter("@EmailCC", EmailCC);
			SqlParameter p6 = new SqlParameter("@EmailBCC", EmailBCC);
			SqlParameter p7 = new SqlParameter("@EmailGroup", Grp);
			SqlParameter p8 = new SqlParameter("@Subj", Subj);
			SqlParameter p9 = new SqlParameter("@Body", Body);
			SqlParameter p10 = new SqlParameter("@ImportncLvl", Impt);
			SqlParameter p11 = new SqlParameter("@SensitivLvl", Sens);
			SqlParameter p12 = new SqlParameter("@Format", Fmt);
			SqlParameter p13 = new SqlParameter("@LogEmail", LogEmail);
			SqlParameter p14 = new SqlParameter("@EmpIDs", EmpIDs);
			SqlParameter p15 = new SqlParameter("@Active", Active);
			SqlParameter p16 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SendEmailFromApp", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16 });
		}

		public DataTable UpdateAppArea(int ID, string AppCode, string AreaCode, string AreaName, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@AppCode", AppCode);
			SqlParameter p3 = new SqlParameter("@AppAreaCode", AreaCode);
			SqlParameter p4 = new SqlParameter("@AppAreaName", AreaName);
			SqlParameter p5 = new SqlParameter("@Active", Active);
			SqlParameter p6 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_UpdateAppArea", new SqlParameter[] { p1, p2, p3, p4, p5, p6 });
		}

		public DataTable UpdateAppAreaRight(int ID, string AppCode, string AreaCode, string GroupCode, int RightLvl, int Primary, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@AppCode", AppCode);
			SqlParameter p3 = new SqlParameter("@AppAreaCode", AreaCode);
			SqlParameter p4 = new SqlParameter("@GroupName", GroupCode);
			SqlParameter p5 = new SqlParameter("@RightLvl", RightLvl);
			SqlParameter p6 = new SqlParameter("@Primary", Primary);
			SqlParameter p7 = new SqlParameter("@Active", Active);
			SqlParameter p8 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_UpdateAppAreaRight", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8 });
		}

		public DataTable UpdateAppAreaSetting(int ID, int iType, string Value, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@Type", iType);
			SqlParameter p3 = new SqlParameter("@Value", Value);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_UpdateAppAreaRight", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable UpdateEmailAddress(int EmailAddrID, string EmailAddr, int UserID, int NotifTypeID, int ErrorID, string EmailAddrType, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@EAID", EmailAddrID);
			SqlParameter p2 = new SqlParameter("@EmailAddr", EmailAddr);
			SqlParameter p3 = new SqlParameter("@UserID", UserID);
			SqlParameter p4 = new SqlParameter("@NotifTypeID", NotifTypeID); 
			SqlParameter p5 = new SqlParameter("@ErrorCondID", ErrorID);
			SqlParameter p6 = new SqlParameter("@EmailAddrType", EmailAddrType);
			SqlParameter p7 = new SqlParameter("@Active", Active);
			SqlParameter p8 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableAD("Maint.usp_UpdateEmailAddress", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8 });
		}

		public DataTable UpdateEmailTemplate(int TemplateID, string Code, string Name, string Subj, string Body, int TransType, int NotifType, string EmailToType, string Importance, string Sensitivity, int IncUser, int IncMgr,
			int IncLoc, int IncProd, int IncSKU, int IncEnt, int IncTrans, string Fmt, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@TemplateID", TemplateID);
			SqlParameter p2 = new SqlParameter("@Code", Code);
			SqlParameter p3 = new SqlParameter("@Name", Name);
			SqlParameter p4 = new SqlParameter("@Subj", Subj); //	 --0 - invalid,  FORECAST: 1 - Products, 2 - Mixes, 3 - MixContents, 4 - Forecast
			SqlParameter p5 = new SqlParameter("@Body", Body);
			SqlParameter p6 = new SqlParameter("@TransType", TransType);
			SqlParameter p7 = new SqlParameter("@NotifType", NotifType);
			SqlParameter p8 = new SqlParameter("@EmailToType", EmailToType);
			SqlParameter p9 = new SqlParameter("@ImportncLvl", Importance);
			SqlParameter p10 = new SqlParameter("@SensitivLvl", Sensitivity);
			SqlParameter p11 = new SqlParameter("@IncUserData", IncUser);
			SqlParameter p12 = new SqlParameter("@IncMgrData", IncMgr);
			SqlParameter p13 = new SqlParameter("@IncLocData", IncLoc);
			SqlParameter p14 = new SqlParameter("@IncProdData", IncProd);
			SqlParameter p15 = new SqlParameter("@IncProdSKUData", IncSKU);
			SqlParameter p16 = new SqlParameter("@IncEntityData", IncEnt);
			SqlParameter p17 = new SqlParameter("@IncTransData", IncTrans);
			SqlParameter p18 = new SqlParameter("@Format", Fmt);
			SqlParameter p19 = new SqlParameter("@Active", Active);
			SqlParameter p20 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableAD("Maint.usp_UpdateEmailTemplate", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20 });
		}

		public DataTable UpdateSortOrder(int ID, int SortOrder, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@SortOrder", SortOrder);
			SqlParameter p3 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateSortOrder", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable UpdateNotificationType(int ID, string Code, string sType, int SendIfNoData, string AfterActSQL, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@Code", Code);
			SqlParameter p3 = new SqlParameter("@Type", sType);
			SqlParameter p4 = new SqlParameter("@SendIfNoData", SendIfNoData);
			SqlParameter p5 = new SqlParameter("@AfterActSQL", AfterActSQL);
			SqlParameter p6 = new SqlParameter("@Active", Active);
			SqlParameter p7 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWM("Maint.usp_UpdateNotificationType", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7 });
		}

		public DataTable UpdateProcess(int ID, string Code, string sName, int PTypeID, string Sched, string JobName, string SPName, string RerunSP, int SrcType, int UpdType, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@Code", Code);
			SqlParameter p3 = new SqlParameter("@Name", sName);
			SqlParameter p4 = new SqlParameter("@ProcTypeID", PTypeID);
			SqlParameter p5 = new SqlParameter("@Schedule", Sched);
			SqlParameter p6 = new SqlParameter("@JobName", JobName);
			SqlParameter p7 = new SqlParameter("@SPName", SPName);
			SqlParameter p8 = new SqlParameter("@RerunSPName", RerunSP);
			SqlParameter p9 = new SqlParameter("@SrcType", SrcType);
			SqlParameter p10 = new SqlParameter("@UpdType", UpdType);
			SqlParameter p11 = new SqlParameter("@Active", Active);
			SqlParameter p12 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWM("Maint.usp_UpdateNotificationType", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12 });
		}

		public DataTable UpdateProcessOwner(int ID, int OwnerID, int ProcID, int iType, int Mand, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@OwnerID", OwnerID);
			SqlParameter p3 = new SqlParameter("@ProcID", ProcID);
			SqlParameter p4 = new SqlParameter("@Type", iType);
			SqlParameter p5 = new SqlParameter("@Mandatory", Mand);
			SqlParameter p6 = new SqlParameter("@Active", Active);
			SqlParameter p7 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_UpdateProcessOwnerData", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7 });
		}

		public DataTable UpdateUserGroup(int ID, string Code, string Name, string AppArea, int RightLvl, int Primary, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@GroupCode", Code);
			SqlParameter p3 = new SqlParameter("@GroupName", Name);
			SqlParameter p4 = new SqlParameter("@AppCode", "DataMngt");
			SqlParameter p5 = new SqlParameter("@AppArea", AppArea);
			SqlParameter p6 = new SqlParameter("@RightLvl", RightLvl);
			SqlParameter p7 = new SqlParameter("@Primary", Primary);
			SqlParameter p8 = new SqlParameter("@Active", Active);
			SqlParameter p9 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_UpdateUserGroup", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9 });
		}

	}
}
