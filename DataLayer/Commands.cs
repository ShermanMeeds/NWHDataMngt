using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace DataLayer
{
	public class Commands
	{

		public DataTable CheckInOutEditArea(int UserID, string LocCode, int AreaNbr, int Action, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppName", "DataMngt");
			SqlParameter p2 = new SqlParameter("@UserID", UserID);
			SqlParameter p3 = new SqlParameter("@LocCode", LocCode);
			SqlParameter p4 = new SqlParameter("@AreaNbr", AreaNbr); //	 --0 - invalid,  FORECAST: 1 - Products, 2 - Mixes, 3 - MixContents, 4 - Forecast
			SqlParameter p5 = new SqlParameter("@Action", Action);
			SqlParameter p6 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_CheckInOutTableRow", new SqlParameter[] { p1, p2, p3, p4, p5, p6 });
		}

		public DataTable DeleteDocAttachment(int DocID, int AttachID, string Src, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@DocID", DocID);
			SqlParameter p2 = new SqlParameter("@AttachID", AttachID);
			SqlParameter p3 = new SqlParameter("@Src", Src);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_DeleteDocAttachment", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable DeleteExistingRightsLocation(int UserID, string GrpCode, string LocCode, int ByID)
		{
			DBInterface di = new DBInterface();
			//SqlParameter p1 = new SqlParameter("@AppName", "APCoding");
			SqlParameter p1 = new SqlParameter("@UserID", UserID);
			SqlParameter p2 = new SqlParameter("@GrpCode", GrpCode);
			SqlParameter p3 = new SqlParameter("@LocCode", LocCode);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_DeleteUserRightsLocation", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable DeleteExistingRight(int UserID, string GrpCode, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppName", "APCoding");
			SqlParameter p2 = new SqlParameter("@UserID", UserID);
			SqlParameter p3 = new SqlParameter("@GrpCode", GrpCode);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_DeleteUserRight", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable DeleteUser(int UserID, int Permanent, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppName", "APCoding");
			SqlParameter p2 = new SqlParameter("@UserID", UserID);
			SqlParameter p3 = new SqlParameter("@Perm", Permanent);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_DeleteUser", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable Get13WeekDates(int iType)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Type", iType);
			return di.RunSPReturnDataTableNWB("web.usp_Select13WeekData", new SqlParameter[] { p1 });
		}

		public DataTable GetAttachmentFile(int FileID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@FileID", FileID);
			SqlParameter p2 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTable("web.usp_GetAttachmentFile", new SqlParameter[] { p1, p2 });
		}

		public DataTable GetCalendarDataForMonth(int Yr, int Mo, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Year", Yr);
			SqlParameter p2 = new SqlParameter("@Month", Mo);
			//SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectCalendarDatesForMonth", new SqlParameter[] { p1, p2 });
		}

		public DataTable GetCalDatesForMonth(int Yr, int Mo, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Year", Yr);
			SqlParameter p2 = new SqlParameter("@Month", Mo);
			return di.RunSPReturnDataTableNWB("web.usp_SelectCalendarDatesForMonth", new SqlParameter[] { p1, p2 });
		}

		public DataTable GetComputerList(string Loc, string Status, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@LocCode", Loc);
			SqlParameter p2 = new SqlParameter("@Status", Status);
			SqlParameter p3 = new SqlParameter("@Active", Active);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectHITSComputerList", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable GetControlValue(int iType, int ID1, int ID2, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Type", iType);
			SqlParameter p2 = new SqlParameter("@ID1", ID1);
			SqlParameter p3 = new SqlParameter("@ID2", ID2);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("dbo.usp_GetControlValue", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable GetCurrencyCodeList(int Sort, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Sort", Sort);
			SqlParameter p2 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTable("web.usp_GetCurrencyCodeList", new SqlParameter[] { p1, p2 });
		}

		public DataTable GetGradeList(int Type, int Filtered, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Type", Type);
			SqlParameter p2 = new SqlParameter("@Sort", Sort);
			SqlParameter p3 = new SqlParameter("@Filtered", Filtered);
			SqlParameter p4 = new SqlParameter("@Active", Active);
			SqlParameter p5 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectGradeList", new SqlParameter[] { p1, p2, p3, p4, p5 });
		}

		public string GetGlobalAppSetting(string SettingKey, string Type)
		{
			DBInterface di = new DBInterface();
			if (String.IsNullOrWhiteSpace(SettingKey))
			{
				return "{EMPTY}";
			}
			else
			{
				SqlParameter p1 = new SqlParameter("@Setting", SettingKey);
				SqlParameter p2 = new SqlParameter("@Type", Type);
				return (string)di.RunSPReturnScalarNWDW("web.usp_GetAppSetting", new SqlParameter[] { p1, p2 });
			}
		}

		public DataTable GetLocationList(string Loc, string LocType, string Country, string City, int Sort, int Class, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@LocCode", Loc);
			SqlParameter p2 = new SqlParameter("@LocType", LocType);
			SqlParameter p3 = new SqlParameter("@Country", Country);
			SqlParameter p4 = new SqlParameter("@City", City);
			SqlParameter p5 = new SqlParameter("@Sort", Sort);
			SqlParameter p6 = new SqlParameter("@Class", Class);
			SqlParameter p7 = new SqlParameter("@Active", Active);
			SqlParameter p8 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectLocationList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8 });
		}

		public DataTable GetLocationList2(string LocCode, string Region, string LocType, string Country, string City, int Class, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@LocCode", LocCode);
			SqlParameter p2 = new SqlParameter("@Region", Region);
			SqlParameter p3 = new SqlParameter("@LocType", LocType);
			SqlParameter p4 = new SqlParameter("@Country", Country);
			SqlParameter p5 = new SqlParameter("@City", City);
			SqlParameter p6 = new SqlParameter("@Class", Class);
			SqlParameter p7 = new SqlParameter("@Sort", Sort);
			SqlParameter p8 = new SqlParameter("@Active", Active);
			SqlParameter p9 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectLocationList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9 });
		}

		public DataTable GetLocationListSvc(string Loc, string LocType, string Country, string City, int Sort, int Class, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@LocCode", Loc);
			SqlParameter p2 = new SqlParameter("@LocType", LocType);
			SqlParameter p3 = new SqlParameter("@Country", Country);
			SqlParameter p4 = new SqlParameter("@City", City);
			SqlParameter p5 = new SqlParameter("@Sort", Sort);
			SqlParameter p6 = new SqlParameter("@Class", Class);
			SqlParameter p7 = new SqlParameter("@Active", Active);
			SqlParameter p8 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectLocationList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8 });
		}

		public DataTable GetLTProdCodeList(string Prefix, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Prefix", Prefix);
			SqlParameter p2 = new SqlParameter("@Sort", Sort);
			SqlParameter p3 = new SqlParameter("@Active", Active);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectLTPRODCodeData", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable GetProdTypeCodeList(string ProdType, int Desc, int Attrib, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ProdType", ProdType);
			SqlParameter p2 = new SqlParameter("@Desc", Desc);
			SqlParameter p3 = new SqlParameter("@Attrib", Attrib);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectCodeListForProdType", new SqlParameter[] { p1, p2, p3,p4 });
		}

		public DataTable GetRegionForLocation(string LocCode, int ByID) {
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@LocCode", LocCode);
			SqlParameter p2 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectRegionForLocation", new SqlParameter[] { p1, p2 });
		}

		public DataTable GetSpeciesList(int Type, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Type", Type);
			SqlParameter p2 = new SqlParameter("@Sort", Sort);
			SqlParameter p3 = new SqlParameter("@Active", Active);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectSpeciesList", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable GetThicknessList(int Type, int Filtered, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Type", Type);
			SqlParameter p2 = new SqlParameter("@Sort", Sort);
			SqlParameter p3 = new SqlParameter("@Filtered", Filtered);
			SqlParameter p4 = new SqlParameter("@Active", Active);
			SqlParameter p5 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectThicknessList", new SqlParameter[] { p1, p2, p3, p4, p5 });
		}

		public DataTable GetUserData(string Login)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@UserName", Login);
			return di.RunSPReturnDataTableNWDW("web.usp_GetUserData", new SqlParameter[] { p1 });
		}

		public DataTable GetWebAppSetting(string AppArea, int DBID, string Code, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppArea", AppArea);
			SqlParameter p2 = new SqlParameter("@DBID", DBID);
			SqlParameter p3 = new SqlParameter("@Code", Code);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_GetAppSetting", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable InsertAttachment(string DocTypeCode, int SrcID, string FileNm, int FileSz, string FileType, string ContentType, string Title, string Blob, int IsSys, int NewID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@DocTypeCode", DocTypeCode);
			SqlParameter p2 = new SqlParameter("@SourceID", SrcID);
			SqlParameter p3 = new SqlParameter("@Filename", FileNm);
			SqlParameter p4 = new SqlParameter("@FileSize", FileSz);
			SqlParameter p5 = new SqlParameter("@FileType", FileType);
			SqlParameter p6 = new SqlParameter("@ContentType", ContentType);
			SqlParameter p7 = new SqlParameter("@DocTitle", Title);
			SqlParameter p8 = new SqlParameter("@DocBlob", Blob);
			SqlParameter p9 = new SqlParameter("@IsSystem", IsSys);
			SqlParameter p10 = new SqlParameter("@NewID", NewID);
			SqlParameter p11 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.up_InsertDocument", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11 });
		}

		public int LogAjaxCall(int PageID, int ObjID, int FuncLibID, string FunctionName, int RtnSize, int? ByID)
		{
			DBInterface di = new DBInterface();
			if (ByID == null) { ByID = 99999; }
			SqlParameter p1 = new SqlParameter("@AppName", "APCoding");
			SqlParameter p2 = new SqlParameter("@PageID", PageID);
			SqlParameter p3 = new SqlParameter("@ObjID", ObjID);
			SqlParameter p4 = new SqlParameter("@FuncLibID", FuncLibID);
			SqlParameter p5 = new SqlParameter("@FunctionName", FunctionName);
			SqlParameter p6 = new SqlParameter("@ReturnSize", RtnSize);
			SqlParameter p7 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnIntegerNWDW("web.usp_logAJAXCall", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7 });
		}

		public int LogApplicationError(string ProcType, int ErrorID, int RowID, string ErrorMsg, int ErrorLine, string ErrorLoc, int UserID)
		{
			DateTime nw = DateTime.Now;
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppName", "DataMngt");
			SqlParameter p2 = new SqlParameter("@ErrorID", ErrorID);
			SqlParameter p3 = new SqlParameter("@RowID", RowID);
			SqlParameter p4 = new SqlParameter("@ErrorMsg", ErrorMsg);
			SqlParameter p5 = new SqlParameter("@ErrorDT", nw);
			SqlParameter p6 = new SqlParameter("@ErrorLine", ErrorLine);
			SqlParameter p7 = new SqlParameter("@ErrorLoc", ErrorLoc);
			SqlParameter p8 = new SqlParameter("@UserID", UserID);
			return di.RunSPReturnIntegerNWDW("web.usp_LogAppError", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8 });
		}

		public int LogSessionEnd(string ProcType, string UserName, int UserID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppName", "DataMngt");
			SqlParameter p2 = new SqlParameter("@EmpID", UserID);
			SqlParameter p3 = new SqlParameter("@UserName", UserName);
			SqlParameter p4 = new SqlParameter("@ProcType", ProcType);
			return di.RunSPReturnIntegerNWDW("web.up_LogSessionEnd", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public int LogSessionStart(string ProcType, string UserName, int UserID, string BrowserType, string Platform, string IPAddress, string AuthType, string SessionID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppName", "DataMngt");
			SqlParameter p2 = new SqlParameter("@UserID", UserID);
			SqlParameter p3 = new SqlParameter("@UserName", UserName);
			SqlParameter p4 = new SqlParameter("@BrowserType", BrowserType);
			SqlParameter p5 = new SqlParameter("@Platform", Platform);
			SqlParameter p6 = new SqlParameter("@IPAddress", IPAddress);
			SqlParameter p7 = new SqlParameter("@AuthType", AuthType);
			SqlParameter p8 = new SqlParameter("@WinSessionID", SessionID);
			return di.RunSPReturnIntegerNWDW("web.usp_LogSessionStart", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8 });
		}

		public DataTable SelectAppVersionHistory(int AppID, int Asc, int CurrentOnly)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppID", AppID);
			SqlParameter p2 = new SqlParameter("@Asc", Asc);
			SqlParameter p3 = new SqlParameter("@CurrentOnly", CurrentOnly);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectApplicationVersionHistory", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable SelectAttachmentList(string DocType, int ID, string Ext, int Sort, int PgNbr, int PgSize, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@DocType", DocType);
			SqlParameter p2 = new SqlParameter("@TargetID", ID);
			SqlParameter p3 = new SqlParameter("@Ext", Ext);
			SqlParameter p4 = new SqlParameter("@Sort", Sort);
			SqlParameter p5 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p6 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p7 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectAttachmentList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7 });
		}

		public DataTable SelectAttachmentList2(string DocType, string DocType2, string DocType3, int ID, int ID2, string Ext, int PgNbr, int PgSize, int Sort, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@DocType", DocType);
			SqlParameter p2 = new SqlParameter("@DocType2", DocType2);
			SqlParameter p3 = new SqlParameter("@DocType3", DocType3);
			SqlParameter p4 = new SqlParameter("@Ext", Ext);
			SqlParameter p5 = new SqlParameter("@TargetID", ID);
			SqlParameter p6 = new SqlParameter("@TargetID2", ID2);
			SqlParameter p7 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p8 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p9 = new SqlParameter("@Sort", Sort);
			SqlParameter p10 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectAttachmentList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10 });
		}

		public DataTable SelectBranchList(int Sort, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Sort", Sort);
			SqlParameter p2 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectBranchList", new SqlParameter[] { p1, p2 });
		}

		public DataTable SelectBusinessCodeList(string BCClass, string CodeGrp, int Active, int Shown, int Sort, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppCode", "DataMngt");
			SqlParameter p2 = new SqlParameter("@Class", BCClass);
			SqlParameter p3 = new SqlParameter("@CodeGroup", CodeGrp);
			SqlParameter p4 = new SqlParameter("@Active", Active);
			SqlParameter p5 = new SqlParameter("@Shown", Shown);
			SqlParameter p6 = new SqlParameter("@Sort", Sort);
			SqlParameter p7 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectBusinessCodes", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7 });
		}

		public DataTable SelectCalendarData(int Yr, int Mo, int CalType, string ProdCode, string Region, string LocCode, string Species, string Grade, string Thick, string Len, string Color, string Sort, string Milling, string NoPrint,
			string Cust, int Shift, int ShowLoc, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@CalDataType", CalType);
			SqlParameter p2 = new SqlParameter("@Year", Yr);
			SqlParameter p3 = new SqlParameter("@Month", Mo);
			SqlParameter p4 = new SqlParameter("@ProdCode", ProdCode);
			SqlParameter p5 = new SqlParameter("@Region", Region);
			SqlParameter p6 = new SqlParameter("@LocCode", LocCode);
			SqlParameter p7 = new SqlParameter("@Species", Species);
			SqlParameter p8 = new SqlParameter("@Grade", Grade);
			SqlParameter p9 = new SqlParameter("@Thickness", Thick);
			SqlParameter p10 = new SqlParameter("@Len", Len);
			SqlParameter p11 = new SqlParameter("@Color", Color);
			SqlParameter p12 = new SqlParameter("@Sort", Sort);
			SqlParameter p13 = new SqlParameter("@Milling", Milling);
			SqlParameter p14 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p15 = new SqlParameter("@Cust", Cust);
			SqlParameter p16 = new SqlParameter("@Shift", Shift);
			SqlParameter p17 = new SqlParameter("@ShowLoc", ShowLoc);
			SqlParameter p18 = new SqlParameter("@Active", Active);
			SqlParameter p19 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectCalendarItems", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19 });
		}

		public DataTable SelectCalendarEvents(int CalType, int Yr, int Mo, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@CalType", CalType);
			SqlParameter p2 = new SqlParameter("@Year", Yr);
			SqlParameter p3 = new SqlParameter("@Month", Mo);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectCalendarEvents", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable SelectCarrierList(string VendName, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@VendName", VendName);
			SqlParameter p2 = new SqlParameter("@Sort", Sort);
			SqlParameter p3 = new SqlParameter("@Active", Active);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectCarrierList", new SqlParameter[] { p1, p2, p3, p4 });
		}

		// codes from lst_BusinessCode table
		public DataTable SelectCodeList(string Class, string CodeGroup, int Active, int Shown, int Sort, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppCode", "DataMngt");
			SqlParameter p2 = new SqlParameter("@Class", Class);
			SqlParameter p3 = new SqlParameter("@CodeGroup", CodeGroup);
			SqlParameter p4 = new SqlParameter("@Active", Active);
			SqlParameter p5 = new SqlParameter("@Shown", Shown);
			SqlParameter p6 = new SqlParameter("@Sort", Sort);
			SqlParameter p7 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectBusinessCodes", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7 });
		}

		public DataTable SelectCodeListDistinct(int iType, int PgID, int ObjID, string Reg, string LocCode, string LocType, string PCode, string PType, string Thick, string Specie, string Grade, string Season, 
			string Surf, string Wdth, string Len, string Color, string fSort, string Milling, string NoPrint, string FuzzyGrade, string FuzzySort, string FuzzyProd, string Lvl, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Type", iType);
			SqlParameter p2 = new SqlParameter("@PageID", PgID);
			SqlParameter p3 = new SqlParameter("@ObjID", ObjID);
			SqlParameter p4 = new SqlParameter("@Reg", Reg);
			SqlParameter p5 = new SqlParameter("@LocCode", LocCode);
			SqlParameter p6 = new SqlParameter("@LocType", LocType);
			SqlParameter p7 = new SqlParameter("@ProdCode", PCode);
			SqlParameter p8 = new SqlParameter("@ProdType", PType);
			SqlParameter p9 = new SqlParameter("@Thick", Thick);
			SqlParameter p10 = new SqlParameter("@Specie", Specie);
			SqlParameter p11 = new SqlParameter("@Grade", Grade);
			SqlParameter p12 = new SqlParameter("@Seasoning", Season);
			SqlParameter p13 = new SqlParameter("@Surface", Surf);
			SqlParameter p14 = new SqlParameter("@Width", Wdth);
			SqlParameter p15 = new SqlParameter("@Len", Len);
			SqlParameter p16 = new SqlParameter("@Color", Color);
			SqlParameter p17 = new SqlParameter("@fSort", fSort);
			SqlParameter p18 = new SqlParameter("@Milling", Milling);
			SqlParameter p19 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p20 = new SqlParameter("@FuzzyGrade", FuzzyGrade);
			SqlParameter p21 = new SqlParameter("@FuzzySort", FuzzySort);
			SqlParameter p22 = new SqlParameter("@FuzzyProd", FuzzyProd);
			SqlParameter p23 = new SqlParameter("@Level", Lvl);
			SqlParameter p24 = new SqlParameter("@Active", Active);
			SqlParameter p25 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectCodeListDistinct", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25 });
		}

		public DataTable SelectCommentContactList(int ID, string LocCode, int Sort, int Active, int PgNbr, int PgSize, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@LocCode", LocCode);
			SqlParameter p3 = new SqlParameter("@Sort", Sort);
			SqlParameter p4 = new SqlParameter("@Active", Active);
			SqlParameter p5 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p6 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p7 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectCommentContactsList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7 });
		}

		public DataTable SelectCommentList(int ID, int CmtType, string Title, int UserID, string sDtB, string sDtE, string Loc, int Sort, int Active, int PgNbr, int PgSize, int ByID)
		{
			DateTime? bdate = null;
			DateTime? edate = null;
			if (sDtB != "") { bdate = Convert.ToDateTime(sDtB); }
			if (sDtE != "") { edate = Convert.ToDateTime(sDtE); }
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@CmtType", CmtType);
			SqlParameter p3 = new SqlParameter("@Title", Title);
			SqlParameter p4 = new SqlParameter("@UserID", UserID);
			SqlParameter p5 = new SqlParameter("@BDate", bdate);
			SqlParameter p6 = new SqlParameter("@EDate", edate);
			SqlParameter p7 = new SqlParameter("@LocCode", Loc);
			SqlParameter p8 = new SqlParameter("@Sort", Sort);
			SqlParameter p9 = new SqlParameter("@Active", Active);
			SqlParameter p10 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p11 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p12 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectCommentList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12 });
		}

		public DataTable SelectCountryList(int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Active", Active);
			SqlParameter p2 = new SqlParameter("@UserID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectCountryList", new SqlParameter[] { p1, p2 });
		}
		
		public DataTable SelectCurrentMngtWeekData(int PageID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@PageID", PageID);
			SqlParameter p2 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectCurrentMngtWeekData", new SqlParameter[] { p1, p2 });
		}

		public DataTable SelectDivisionList(int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Sort", Sort);
			SqlParameter p2 = new SqlParameter("@Active", Active);
			SqlParameter p3 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTable("web.usp_SelectDivisionList", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable SelectDocTypeRights(string DocTypeCode, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@DocTypeCode", DocTypeCode);
			SqlParameter p2 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTable("web.usp_SelectDocTypeCodeRightst", new SqlParameter[] { p1, p2 });
		}

		public DataTable SelectEventLogList(string AppName, string Title, int Action, string TableNm, int RowID, string sDateB, string sDateE, int LogEmpID, int ByID)
		{
			DateTime? dateB = null;
			DateTime? dateE = null;
			if (!String.IsNullOrWhiteSpace(sDateB)) { dateB = Convert.ToDateTime(sDateB); }
			if (!String.IsNullOrWhiteSpace(sDateE)) { dateE = Convert.ToDateTime(sDateE); }

			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppName", AppName);
			SqlParameter p2 = new SqlParameter("@Title", Title);
			SqlParameter p3 = new SqlParameter("@Action", Action);
			SqlParameter p4 = new SqlParameter("@TableName", TableNm);
			SqlParameter p5 = new SqlParameter("@RowID", RowID);
			SqlParameter p6 = new SqlParameter("@BeginDate", dateB);
			SqlParameter p7 = new SqlParameter("@EndDate", dateE);
			SqlParameter p8 = new SqlParameter("@LoggedEmpID", LogEmpID);
			SqlParameter p9 = new SqlParameter("@UserID", ByID);
			return di.RunSPReturnDataTableNWDW("Maint.usp_SelectProcessEventList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9 });
		}

		public DataTable SelectFinancialTermsList(int Sort, int Active, int ByID)
    {
      DBInterface di = new DBInterface();
      SqlParameter p1 = new SqlParameter("@Sort", Sort);
      SqlParameter p2 = new SqlParameter("@Active", Active);
      SqlParameter p3 = new SqlParameter("@ByID", ByID);
      return di.RunSPReturnDataTableNWDW("web.usp_SelectFinancialTermsList", new SqlParameter[] { p1, p2, p3 });
    }

		public DataTable SelectOrderItemData(int OrdNbr, int Wurth, int Page, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@OrdNbr", OrdNbr);
			SqlParameter p2 = new SqlParameter("@Wurth", Wurth);
			SqlParameter p3 = new SqlParameter("@Page", Page);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectLTProdOrderItemData", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable SelectLocationList(string Loc, string LocType, string Region, string Country, string City, int Class, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@LocCode", Loc);
			SqlParameter p2 = new SqlParameter("@LocType", LocType);
			SqlParameter p3 = new SqlParameter("@Region", Region);
			SqlParameter p4 = new SqlParameter("@Country", Country);
			SqlParameter p5 = new SqlParameter("@City", City);
			SqlParameter p6 = new SqlParameter("@Class", Class);
			SqlParameter p7 = new SqlParameter("@Sort", Sort);
			SqlParameter p8 = new SqlParameter("@Active", Active);
			SqlParameter p9 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectLocationList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9 });
		}

		public DataTable SelectLocationListDW(string Loc, string LocType, string Region, string Country, string St, string City, int Class, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@LocCode", Loc);
			SqlParameter p2 = new SqlParameter("@LocType", LocType);
			SqlParameter p3 = new SqlParameter("@Region", Region);
			SqlParameter p4 = new SqlParameter("@Country", Country);
			SqlParameter p5 = new SqlParameter("@State", St);
			SqlParameter p6 = new SqlParameter("@City", City);
			SqlParameter p7 = new SqlParameter("@Class", Class);
			SqlParameter p8 = new SqlParameter("@Sort", Sort);
			SqlParameter p9 = new SqlParameter("@Active", Active);
			SqlParameter p10 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectLocationList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10 });
		}

		public DataTable SelectLocationListGlobal(string Loc, string LocType, string Country, string City, int Sort, int Class, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@LocCode", Loc);
			SqlParameter p2 = new SqlParameter("@LocType", LocType);
			SqlParameter p3 = new SqlParameter("@Country", Country);
			SqlParameter p4 = new SqlParameter("@City", City);
			SqlParameter p5 = new SqlParameter("@Sort", Sort);
			SqlParameter p6 = new SqlParameter("@Class", Class);
			SqlParameter p7 = new SqlParameter("@Active", Active);
			SqlParameter p8 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectLTProdOrderItemData", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8 });
		}

		public DataTable SelectLocationListL(string Loc, string LocType, string Country, string City, int Sort, int Class, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Region", "");
			SqlParameter p2 = new SqlParameter("@LocCode", Loc);
			SqlParameter p3 = new SqlParameter("@LocType", LocType);
			SqlParameter p4 = new SqlParameter("@Country", Country);
			SqlParameter p5 = new SqlParameter("@City", City);
			SqlParameter p6 = new SqlParameter("@Sort", Sort);
			SqlParameter p7 = new SqlParameter("@Class", Class);
			SqlParameter p8 = new SqlParameter("@Active", Active);
			SqlParameter p9 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectLocationListL", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9 });
		}

		public DataTable SelectLocationListM(string Region, string Loc, string LocType, string Country, string City, int Sort, int Class, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Region", Region);
			SqlParameter p2 = new SqlParameter("@LocCode", Loc);
			SqlParameter p3 = new SqlParameter("@LocType", LocType);
			SqlParameter p4 = new SqlParameter("@Country", Country);
			SqlParameter p5 = new SqlParameter("@City", City);
			SqlParameter p6 = new SqlParameter("@Sort", Sort);
			SqlParameter p7 = new SqlParameter("@Class", Class);
			SqlParameter p8 = new SqlParameter("@Active", Active);
			SqlParameter p9 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectLocationListL", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9 });
		}

		public DataTable SelectLocationListSpecial(int UserID, string Reg, string AppArea, string Loc, string LocType, string Country, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@UserID", UserID);
			SqlParameter p2 = new SqlParameter("@Region", Reg);
			SqlParameter p3 = new SqlParameter("@AppArea", AppArea);
			SqlParameter p4 = new SqlParameter("@LocCode", Loc);
			SqlParameter p5 = new SqlParameter("@LocType", LocType);
			SqlParameter p6 = new SqlParameter("@Country", Country);
			SqlParameter p7 = new SqlParameter("@Sort", Sort);
			SqlParameter p8 = new SqlParameter("@Active", Active);
			SqlParameter p9 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectLocationListSpecial", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9 });
		}

		public DataTable SelectLocationTypeList(int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectLocationTypeList", new SqlParameter[] { p1 });
		}

		public DataTable SelectMenuItemList(int Section, int Item, string Nm, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Section", Section);
			SqlParameter p2 = new SqlParameter("@Item", Item);
			SqlParameter p3 = new SqlParameter("@Name", Nm);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectMenuItems", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable SelectOrderNbrData(int OrdNbr, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@OrdNbr", OrdNbr);
			SqlParameter p2 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectLTProdOrderData", new SqlParameter[] { p1, p2 });
		}

		public DataTable SelectProductCodeList(string CodeType, int Sort, int Active, int Grp1, int Grp2, int Grp3, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@CodeType", CodeType);
			SqlParameter p2 = new SqlParameter("@Sort", Sort);
			SqlParameter p3 = new SqlParameter("@Active", Active);
			SqlParameter p4 = new SqlParameter("@SpecGrp1", Grp1);
			SqlParameter p5 = new SqlParameter("@SpecGrp2", Grp2);
			SqlParameter p6 = new SqlParameter("@SpecGrp3", Grp3);
			SqlParameter p7 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectProductCodeList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7 });
		}

		public DataTable SelectProductCodeListForRegion(string Region, string CodeType, int Sort, int Active, int Grp1, int Grp2, int Grp3, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Region", Region);
			SqlParameter p2 = new SqlParameter("@CodeType", CodeType);
			SqlParameter p3 = new SqlParameter("@Sort", Sort);
			SqlParameter p4 = new SqlParameter("@Active", Active);
			SqlParameter p5 = new SqlParameter("@SpecGrp1", Grp1);
			SqlParameter p6 = new SqlParameter("@SpecGrp2", Grp2);
			SqlParameter p7 = new SqlParameter("@SpecGrp3", Grp3);
			SqlParameter p8 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectProductCodeListByRegion", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8 });
		}

		public DataTable SelectProductListMaster(string ProdType, string Region, int ShowAll, int Sort, int Active, int List, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ProdType", ProdType);
			SqlParameter p2 = new SqlParameter("@Region", Region);
			SqlParameter p3 = new SqlParameter("@ShowAll", ShowAll);
			SqlParameter p4 = new SqlParameter("@Sort", Sort);
			SqlParameter p5 = new SqlParameter("@Active", Active);
			SqlParameter p6 = new SqlParameter("@List", List);
			SqlParameter p7 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectProductListMaster", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7 });
		}

		public DataTable SelectProductTypesList(string ProdType, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ProdType", ProdType);
			SqlParameter p2 = new SqlParameter("@Sort", Sort);
			SqlParameter p3 = new SqlParameter("@Active", Active);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectProductTypeList", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable SelectSortOrderList(int UserID, string AppArea, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@UserID", UserID);
			SqlParameter p2 = new SqlParameter("@AppCode", "DataMngt");
			SqlParameter p3 = new SqlParameter("@AppArea", AppArea);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectSortOrderList", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable SelectSpeciesList(int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Sort", Sort);
			SqlParameter p2 = new SqlParameter("@Active", Active);
			SqlParameter p3 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectSpeciesList2", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable SelectUIColumnData(int PgID, int ObjID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppName", "DataMngt");
			SqlParameter p2 = new SqlParameter("@PageID", PgID);
			SqlParameter p3 = new SqlParameter("@ObjID", ObjID);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectUIColumnData", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable SelectUserExportDataHdr(int UserID, int PageID, int ObjectID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppName", "DataMngt");
			SqlParameter p3 = new SqlParameter("@UserID", UserID);
			SqlParameter p4 = new SqlParameter("@PageID", PageID);
			SqlParameter p2 = new SqlParameter("@ObjectID", ObjectID);
			SqlParameter p5 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectUserExportDataHeader", new SqlParameter[] { p1, p2, p3, p4, p5 });
		}

		public DataTable SelectUserGroupData(string AppArea, int UserID, int Sort, int Active)
    {
      DBInterface di = new DBInterface();
      SqlParameter p1 = new SqlParameter("@AppCode", "DataMngt");
      SqlParameter p2 = new SqlParameter("@AppArea", AppArea);
      SqlParameter p3 = new SqlParameter("@UserID", UserID);
      SqlParameter p4 = new SqlParameter("@Sort", Sort);
      SqlParameter p5 = new SqlParameter("@Active", Active);
      return di.RunSPReturnDataTableNWDW("web.usp_SelectUserGroupData", new SqlParameter[] { p1, p2, p3, p4, p5 });
    }

		public DataTable SelectUserGroupList(int ID, string Grp, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppCode", "DataMngt");
			SqlParameter p2 = new SqlParameter("@ID", ID);
			SqlParameter p3 = new SqlParameter("@GrpCode", Grp);
			SqlParameter p4 = new SqlParameter("@Sort", Sort);
			SqlParameter p5 = new SqlParameter("@Active", Active);
			SqlParameter p6 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectUserGroupList", new SqlParameter[] { p1, p2, p3, p4, p5, p6 });
		}

		public DataTable SelectUserGroupMembers(string GrpCode, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@GrpCode", GrpCode);
			SqlParameter p2 = new SqlParameter("@Sort", Sort);
			SqlParameter p3 = new SqlParameter("@Active", Active);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectUserGroupMembers", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable SelectUserGroupNonMembers(string GrpCode, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@GrpCode", GrpCode);
			SqlParameter p2 = new SqlParameter("@Sort", Sort);
			SqlParameter p3 = new SqlParameter("@Active", Active);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectUserGroupNonMembers", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable SelectUserInterfaceItems(int UserID, string UIType, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@UserID", UserID);
			SqlParameter p2 = new SqlParameter("@UIType", UIType);
			return di.RunSPReturnDataTableNWB("web.usp_SelectUserInterfaceItems", new SqlParameter[] { p1, p2 });
		}

		public DataTable SelectUserList(int UserID, string Name, string Ctry, string City, string Loc, string pos, string grp, int Sort, int Active, int IncRights, int ByID)
    {
      DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@UserID", UserID);
			SqlParameter p2 = new SqlParameter("@name", Name);
			SqlParameter p3 = new SqlParameter("@LocCode", Loc);
			SqlParameter p4 = new SqlParameter("@Country", Ctry);
			SqlParameter p5 = new SqlParameter("@City", City);
			SqlParameter p6 = new SqlParameter("@Pos", pos);
			SqlParameter p7 = new SqlParameter("@Grp", grp);
			SqlParameter p8 = new SqlParameter("@Sort", Sort);
      SqlParameter p9 = new SqlParameter("@Active", Active);
      SqlParameter p10 = new SqlParameter("@IncRights", IncRights);
			SqlParameter p11 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectUserList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11 });
    }

		public DataTable SelectUserListForPosition(string Pos, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Pos", Pos);
			SqlParameter p2 = new SqlParameter("@Sort", Sort);
			SqlParameter p3 = new SqlParameter("@Active", Active);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectUserListForPosition", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable SelectUserListMin(string Name, string Pos, int HasEmail, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@name", Name);
			SqlParameter p2 = new SqlParameter("@Pos", Pos);
			SqlParameter p3 = new SqlParameter("@HasEmail", HasEmail);
			SqlParameter p4 = new SqlParameter("@Sort", Sort);
			SqlParameter p5 = new SqlParameter("@Active", Active);
			SqlParameter p6 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectUserListMin", new SqlParameter[] { p1, p2, p3, p4, p5, p6 });
		}

		public DataTable SelectUserListLT(string Name, string Type, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@name", Name);
			SqlParameter p2 = new SqlParameter("@Type", Type);
			SqlParameter p3 = new SqlParameter("@Sort", Sort);
			SqlParameter p4 = new SqlParameter("@Active", Active);
			SqlParameter p5 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectUserList", new SqlParameter[] { p1, p2, p3, p4, p5 });
		}

		public DataTable SelectUserLocationAccessList(int UserID, string Grp, int ByID)
		{
			// data comes from NWHDW Maint.lnk_UserGroup_User_Location and Maint.lnk_Location_Use
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppCode", "DataMngt");
			SqlParameter p2 = new SqlParameter("@UserID", UserID);
			SqlParameter p3 = new SqlParameter("@GrpCode", Grp);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectUserLocationAccessList", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable SelectUserPageColSettings(int UserID, string UIType, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@UserID", UserID);
			SqlParameter p2 = new SqlParameter("@UIType", UIType);
			return di.RunSPReturnDataTableNWB("web.usp_SelectUserPageColumnSettings", new SqlParameter[] { p1, p2 });
		}

		public DataTable SelectUserPositionList(string Name, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@name", Name);
			SqlParameter p2 = new SqlParameter("@Sort", Sort);
			SqlParameter p3 = new SqlParameter("@Active", Active);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectUserPositionList", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable SelectUserQueryData(int UserID,int QueryID, string QueryName, int PgID, int ObjID, int Sort, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@UserID", UserID);
			SqlParameter p2 = new SqlParameter("@QueryID", QueryID);
			SqlParameter p3 = new SqlParameter("@QueryName", QueryName);
			SqlParameter p4 = new SqlParameter("@PgID", PgID);
			SqlParameter p5 = new SqlParameter("@ObjID", ObjID);
			SqlParameter p6 = new SqlParameter("@Sort", Sort);
			SqlParameter p7 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectUserQueryList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7 });
		}

		public DataTable SelectUserTracks(int UserID, int PgID, int ObjID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppName", "DataMngt");
			SqlParameter p2 = new SqlParameter("@UserID", UserID);
			SqlParameter p3 = new SqlParameter("@PgID", PgID);
			SqlParameter p4 = new SqlParameter("@ObjID", ObjID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectUserTracks", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable SelectWebCodeList(string CodeGrp, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppCode", "DataMngt");
			SqlParameter p2 = new SqlParameter("@CodeGroup", CodeGrp);
			SqlParameter p3 = new SqlParameter("@Sort", Sort);
			SqlParameter p4 = new SqlParameter("@Active", Active);
			SqlParameter p5 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectWebCodeList", new SqlParameter[] { p1, p2, p3, p4, p5 });
		}

		public DataTable UpdateAttachment(int SourceID, int DocID, string Src, string FileNm, double FSize, string FType, string ContentType, string DocTitle, byte[] DBlob, int EmailProcID, int ByID)
    {
      DBInterface di = new DBInterface();
      SqlParameter p1 = new SqlParameter("@sourceid", SourceID);
      SqlParameter p2 = new SqlParameter("@DocID", DocID);
      SqlParameter p3 = new SqlParameter("@source", Src);
      SqlParameter p4 = new SqlParameter("@filename", FileNm);
      SqlParameter p5 = new SqlParameter("@filesize", FSize);
      SqlParameter p6 = new SqlParameter("@filetype", FType);
      SqlParameter p7 = new SqlParameter("@contenttype", ContentType);
      SqlParameter p8 = new SqlParameter("@doctitle", DocTitle);
      SqlParameter p9 = new SqlParameter("@docblob", DBlob);
      SqlParameter p10 = new SqlParameter("@emailprocid", EmailProcID);
      SqlParameter p11 = new SqlParameter("@issystem", 0);
      SqlParameter p12 = new SqlParameter("@AppName", "APCoding");
      SqlParameter p13 = new SqlParameter("@ByID", ByID);
      return di.RunSPReturnDataTable("web.usp_UpdateDocument", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13 });
    }

    public DataTable UpdateAttachmentAttributes(int DocID, string Title, string CType, int SrcID, int ByID)
    {
      DBInterface di = new DBInterface();
      SqlParameter p1 = new SqlParameter("@DocID", DocID);
      SqlParameter p2 = new SqlParameter("@Title", Title);
      SqlParameter p3 = new SqlParameter("@CType", CType);
      SqlParameter p4 = new SqlParameter("@SourceID", SrcID);
      SqlParameter p5 = new SqlParameter("@Source", "PR");
      SqlParameter p6 = new SqlParameter("@AppName", "APCoding");
      SqlParameter p7 = new SqlParameter("@ByID", ByID);
      return di.RunSPReturnDataTable("web.usp_UpdateDocumentAttributes", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7 });
    }

		public DataTable UpdateCodeListItem(int ID, int iType, int Val, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppCode", "DataMngt");
			SqlParameter p2 = new SqlParameter("@CodeID", ID);
			SqlParameter p3 = new SqlParameter("@Type", iType);
			SqlParameter p4 = new SqlParameter("@Value", Val);
			SqlParameter p5 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateBusinessCode", new SqlParameter[] { p1, p2, p3, p4, p5 });
	}

		public DataTable UpdateCommentData(int ID, int iType, string CmtType, string Title, string Loc, string Comment, int InsGraph, int Wdth, int Ht, string TDt, int OrigID, int Active, int ByID)
		{
			DateTime? dte = null;
			if (TDt.Length > 0) { dte = Convert.ToDateTime(TDt); }
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@Type", iType);
			SqlParameter p3 = new SqlParameter("@CmtType", CmtType);
			SqlParameter p4 = new SqlParameter("@Title", Title);
			SqlParameter p5 = new SqlParameter("@LocCode", Loc);
			SqlParameter p6 = new SqlParameter("@Comment", Comment);
			SqlParameter p7 = new SqlParameter("@InsertGraphic", InsGraph);
			SqlParameter p8 = new SqlParameter("@GrphWdth", Wdth);
			SqlParameter p9 = new SqlParameter("@GrphHt", Ht);
			SqlParameter p10 = new SqlParameter("@Date", dte);
			SqlParameter p11 = new SqlParameter("@OrigID", OrigID);
			SqlParameter p12 = new SqlParameter("@Active", Active);
			SqlParameter p13 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateCommentData", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13 });
		}

		public DataTable UpdateCommentRequestData (int InvReqID, int CmtID, int ItemNbr, int iType, string CmtType, string Title, string Loc, string Comment, int InsGraph, int Wdth, int Ht, string TDt, 
			int OrigID, int Active, int ByID)
		{
			DateTime? dte = null;
			if (TDt.Length > 0) { dte = Convert.ToDateTime(TDt); }
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@InvoiceReqID", InvReqID);
			SqlParameter p2 = new SqlParameter("@CommentID", CmtID);
			SqlParameter p3 = new SqlParameter("@ItemNbr", ItemNbr);
			SqlParameter p4 = new SqlParameter("@Type", iType);
			SqlParameter p5 = new SqlParameter("@CmtType", CmtType);
			SqlParameter p6 = new SqlParameter("@Title", Title);
			SqlParameter p7 = new SqlParameter("@LocCode", Loc);
			SqlParameter p8 = new SqlParameter("@Comment", Comment);
			SqlParameter p9 = new SqlParameter("@InsertGraphic", InsGraph);
			SqlParameter p10 = new SqlParameter("@GrphWdth", Wdth);
			SqlParameter p11 = new SqlParameter("@GrphHt", Ht);
			SqlParameter p12 = new SqlParameter("@Date", dte);
			SqlParameter p13 = new SqlParameter("@OrigID", OrigID);
			SqlParameter p14 = new SqlParameter("@Active", Active);
			SqlParameter p15 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateCommentData", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15 });
		}

		public DataTable UpdateDataExport(int UserID, int PgID, int ObjID, string ExpFileNm, string ProdType, string ProdCode, string LocCode, string Reg, string Thick, string Spec, string Grade, string Season, string Surf,
			string Stat, int iType, string Wdth, string Len, string Color, string FSort, string Milling, string NoPrint, int OrderID, int ShipID, int LoadID, string Cust, string Vendor, string Supplier, string Mgr, int MgrID,
			int Set0, int Set1, int Set2, int Set3, int Set4, int Set5, int Set6, string RollupItems, string FuzzyGrade, string FuzzySort, string FuzzyProd, string FuzzyMgr, string FuzzyCust, string Fuzzy6,
			string IName, string ICode, string IDesc, double Nbr, string Code1, string Code2, int id1, int id2, DateTime? TDate, DateTime? BDate, DateTime? EDate, string CustCode, string SubTotal, string Cmt, int Sort, int Active)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@UserID", UserID);
			SqlParameter p2 = new SqlParameter("@AppName", "DataMngt");
			SqlParameter p3 = new SqlParameter("@PageID", PgID);
			SqlParameter p4 = new SqlParameter("@ObjectID", ObjID);
			SqlParameter p5 = new SqlParameter("@ExpFileName", ExpFileNm);
			SqlParameter p6 = new SqlParameter("@ProdType", ProdType);
			SqlParameter p7 = new SqlParameter("@ProductCode", ProdCode);
			SqlParameter p8 = new SqlParameter("@LocationCode", LocCode);
			SqlParameter p9 = new SqlParameter("@RegionCode", Reg);
			SqlParameter p10 = new SqlParameter("@ThicknessCode", Thick);
			SqlParameter p11 = new SqlParameter("@SpeciesCode", Spec);
			SqlParameter p12 = new SqlParameter("@GradeCode", Grade);
			SqlParameter p13 = new SqlParameter("@SeasoningCode", Season);
			SqlParameter p14 = new SqlParameter("@SurfaceCode", Surf);
			SqlParameter p15 = new SqlParameter("@StatusCode", Stat);
			SqlParameter p16 = new SqlParameter("@WidthCode", Wdth);
			SqlParameter p17 = new SqlParameter("@LengthCode", Len);
			SqlParameter p18 = new SqlParameter("@ColorCode", Color);
			SqlParameter p19 = new SqlParameter("@SortCode", FSort);
			SqlParameter p20 = new SqlParameter("@MillingCode", Milling);
			SqlParameter p21 = new SqlParameter("@NoPrintCode", NoPrint);
			SqlParameter p22 = new SqlParameter("@TypeID", iType);
			SqlParameter p23 = new SqlParameter("@Setting0", Set0);
			SqlParameter p24 = new SqlParameter("@Setting1", Set1);
			SqlParameter p25 = new SqlParameter("@Setting2", Set2);
			SqlParameter p26 = new SqlParameter("@Setting3", Set3);
			SqlParameter p27 = new SqlParameter("@Setting4", Set4);
			SqlParameter p28 = new SqlParameter("@Setting5", Set5);
			SqlParameter p29 = new SqlParameter("@Setting6", Set6);
			SqlParameter p30 = new SqlParameter("@Setting7", 0);
			SqlParameter p31 = new SqlParameter("@OrderID", OrderID);
			SqlParameter p32 = new SqlParameter("@ShipmentID", ShipID);
			SqlParameter p33 = new SqlParameter("@LoadID", LoadID);
			SqlParameter p34 = new SqlParameter("@CustCodes", Cust);
			SqlParameter p35 = new SqlParameter("@VendorCode", Vendor);
			SqlParameter p36 = new SqlParameter("@SupplierCode", Supplier);
			SqlParameter p37 = new SqlParameter("@MgrName", Mgr);
			SqlParameter p38 = new SqlParameter("@MgrID", MgrID);
			SqlParameter p39 = new SqlParameter("@ItemName", IName);
			SqlParameter p40 = new SqlParameter("@ItemCode", ICode);
			SqlParameter p41 = new SqlParameter("@ItemDescription", IDesc);
			SqlParameter p42 = new SqlParameter("@Nbr", Nbr);
			SqlParameter p43 = new SqlParameter("@Code1", Code1);
			SqlParameter p44 = new SqlParameter("@Code2", Code2);
			SqlParameter p45 = new SqlParameter("@ID1", id1);
			SqlParameter p46 = new SqlParameter("@ID2", id2);
			SqlParameter p47 = new SqlParameter("@Comments", Cmt);
			SqlParameter p48 = new SqlParameter("@Fuzzy1", FuzzyGrade);
			SqlParameter p49 = new SqlParameter("@Fuzzy2", FuzzySort);
			SqlParameter p50 = new SqlParameter("@Fuzzy3", FuzzyProd);
			SqlParameter p51 = new SqlParameter("@Fuzzy4", FuzzyMgr);
			SqlParameter p52 = new SqlParameter("@Fuzzy5", FuzzyCust);
			SqlParameter p53 = new SqlParameter("@Fuzzy6", Fuzzy6);
			SqlParameter p54 = new SqlParameter("@CustCode", CustCode);
			SqlParameter p55 = new SqlParameter("@TargetDateTime", TDate);
			SqlParameter p56 = new SqlParameter("@BeginDate", BDate);
			SqlParameter p57 = new SqlParameter("@EndDate", EDate);
			SqlParameter p58 = new SqlParameter("@RollupItems", RollupItems);
			SqlParameter p59 = new SqlParameter("@SubTotals", SubTotal);
			SqlParameter p60 = new SqlParameter("@SortID", Sort);
			SqlParameter p61 = new SqlParameter("@Active", Active);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateUserExportData", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57, p58, p59, p60, p61 });
		}

		public DataTable UpdateLocationContact(int ID, int UserID, int iType, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@UserID", UserID);
			SqlParameter p3 = new SqlParameter("@Type", iType);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateLocationContacts", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable UpdateProductManagedDataItem(int PMID, string ProdType, string ProdCode, string Len, string Color, string Sort, string Milling, string NoPrint, int iType, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@PMID", PMID);
			SqlParameter p2 = new SqlParameter("@ProdType", ProdType);
			SqlParameter p3 = new SqlParameter("@ProdCode", ProdCode);
			SqlParameter p4 = new SqlParameter("@Len", Len);
			SqlParameter p5 = new SqlParameter("@Color", Color);
			SqlParameter p6 = new SqlParameter("@Sort", Sort);
			SqlParameter p7 = new SqlParameter("@Milling", Milling);
			SqlParameter p8 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p9 = new SqlParameter("@Type", iType);
			SqlParameter p10 = new SqlParameter("@Active", Active);
			SqlParameter p11 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateProductManagedData", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11 });
		}

		public DataTable UpdateQueryAction(int UserID, int QueryID, int iType, string Other, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppName", "DataMngt");
			SqlParameter p2 = new SqlParameter("@UserID", UserID);
			SqlParameter p3 = new SqlParameter("@QueryID", QueryID);
			SqlParameter p4 = new SqlParameter("@Type", iType);
			SqlParameter p5 = new SqlParameter("@Value", Other);
			SqlParameter p6 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateUserQueryAction", new SqlParameter[] { p1, p2, p3, p4, p5, p6 });
		}
		
		public DataTable UpdateScheduleDate(int Yr, int Mo, string Dy, int Typ, int Checked, int Action, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Year", Yr);
			SqlParameter p2 = new SqlParameter("@Month", Mo);
			SqlParameter p3 = new SqlParameter("@Day", Dy);
			SqlParameter p4 = new SqlParameter("@Type", Typ);
			SqlParameter p5 = new SqlParameter("@Checked", Checked);
			SqlParameter p6 = new SqlParameter("@Action", Action);
			SqlParameter p7 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateScheduleDate", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7 });
		}

		public DataTable UpdateUserData(int UserID, string Login, string FName, string LName, string MName, int EmpID, string EmailAddr, string EmpPosition, string Loc, int IsContractor, DateTime BDate, DateTime? EDate, int Active, int ByID)
    {
			DBInterface di = new DBInterface();
      SqlParameter p1 = new SqlParameter("@UserID", UserID);
      SqlParameter p2 = new SqlParameter("@Login", Login);
      SqlParameter p3 = new SqlParameter("@FirstName", FName);
      SqlParameter p4 = new SqlParameter("@LastName", LName);
      SqlParameter p5 = new SqlParameter("@MiddleName", MName);
      SqlParameter p6 = new SqlParameter("@EmpID", EmpID);
      SqlParameter p7 = new SqlParameter("@EmailAddress", EmailAddr);
      SqlParameter p8 = new SqlParameter("@EmpPosition", EmpPosition);
      SqlParameter p9 = new SqlParameter("@LocCode", Loc);
			SqlParameter p10 = new SqlParameter("@IsContractor", IsContractor);
			SqlParameter p11 = new SqlParameter("@BeginDate", BDate);
      SqlParameter p12 = new SqlParameter("@EndDate", EDate);
      SqlParameter p13 = new SqlParameter("@Active", Active);
      SqlParameter p14 = new SqlParameter("@ByID", ByID);
      return di.RunSPReturnDataTableNWDW("web.usp_UpdateUserData", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14 });
		}

		public DataTable UpdateUserQuery(int UserID, int QueryID, string QueryName, int PgID, int PgObjID, int PgNbr, int PgSize, DateTime? TargetDT, DateTime? BeginDt, DateTime? EndDt, string UserName, string ProdType, string ProdCode,
			string LocCode, string Reg, string Thick, string Species, string Grade, string Seasoning, string Surface, string StatusCode, string Width, string Len, string Color, string fSort, string Milling, string NoPrint, int iType,
			int Set0, int Set1, int Set2, int Set3, int Set4, int Set5, int Set6, int Set7, int OrderID, int ShipID, int LoadID, string Cust, string Vendor, string Supplier, string Mgr, int MgrID, int Sort, string ItemCode,
			string ItemName, string ItemDesc, double Nbr, string Code1, string Code2, int ID1, int ID2, string Comments, int Active, int ByID) 
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@UserID", UserID);
			SqlParameter p2 = new SqlParameter("@QueryID", QueryID);
			SqlParameter p3 = new SqlParameter("@QueryName", QueryName);
			SqlParameter p4 = new SqlParameter("@AppName", "DataMngt");
			SqlParameter p5 = new SqlParameter("@PageID", PgID);
			SqlParameter p6 = new SqlParameter("@ObjectID", PgObjID);
			SqlParameter p7 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p8 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p9 = new SqlParameter("@TargetDateTime", TargetDT);
			SqlParameter p10 = new SqlParameter("@BeginDate", BeginDt);
			SqlParameter p11 = new SqlParameter("@EndDate", EndDt);
			SqlParameter p12 = new SqlParameter("@UserName", UserName);
			SqlParameter p13 = new SqlParameter("@ProType", ProdType);
			SqlParameter p14 = new SqlParameter("@ProductCode", ProdCode);
			SqlParameter p15 = new SqlParameter("@LocationCode", LocCode);
			SqlParameter p16 = new SqlParameter("@RegionCode", Reg);
			SqlParameter p17 = new SqlParameter("@ThicknessCode", Thick);
			SqlParameter p18 = new SqlParameter("@SpeciesCode", Species);
			SqlParameter p19 = new SqlParameter("@GradeCode", Grade);
			SqlParameter p20 = new SqlParameter("@SeasoningCode", Seasoning);
			SqlParameter p21 = new SqlParameter("@SurfaceCode", Surface);
			SqlParameter p22 = new SqlParameter("@StatusCode", StatusCode);
			SqlParameter p23 = new SqlParameter("@WidthCode", Width);
			SqlParameter p24 = new SqlParameter("@LengthCode", Len);
			SqlParameter p25 = new SqlParameter("@ColorCode", Color);
			SqlParameter p26 = new SqlParameter("@SortCode", fSort);
			SqlParameter p27 = new SqlParameter("@MillingCode", Milling);
			SqlParameter p28 = new SqlParameter("@NoPrintCode", NoPrint);
			SqlParameter p29 = new SqlParameter("@TypeID", iType);
			SqlParameter p30 = new SqlParameter("@Setting0", Set0);
			SqlParameter p31 = new SqlParameter("@Setting1", Set1);
			SqlParameter p32 = new SqlParameter("@Setting2", Set2);
			SqlParameter p33 = new SqlParameter("@Setting3", Set3);
			SqlParameter p34 = new SqlParameter("@Setting4", Set4);
			SqlParameter p35 = new SqlParameter("@Setting5", Set5);
			SqlParameter p36 = new SqlParameter("@Setting6", Set6);
			SqlParameter p37 = new SqlParameter("@Setting7", Set7);
			SqlParameter p38 = new SqlParameter("@OrderID", OrderID);
			SqlParameter p39 = new SqlParameter("@ShipmentID", ShipID);
			SqlParameter p40 = new SqlParameter("@LoadID", LoadID);
			SqlParameter p41 = new SqlParameter("@CustCode", Cust);
			SqlParameter p42 = new SqlParameter("@VendorCode", Vendor);
			SqlParameter p43 = new SqlParameter("@SupplierCode", Supplier);
			SqlParameter p44 = new SqlParameter("@MgrName", Mgr);
			SqlParameter p45 = new SqlParameter("@MgrID", MgrID);
			SqlParameter p46 = new SqlParameter("@SortID", Sort);
			SqlParameter p47 = new SqlParameter("@ItemName", ItemName);
			SqlParameter p48 = new SqlParameter("@ItemCode", ItemCode);
			SqlParameter p49 = new SqlParameter("@ItemDescription", ItemDesc);
			SqlParameter p50 = new SqlParameter("@Nbr", Nbr);
			SqlParameter p51 = new SqlParameter("@Code1", Code1);
			SqlParameter p52 = new SqlParameter("@Code2", Code2);
			SqlParameter p53 = new SqlParameter("@ID1", ID1);
			SqlParameter p54 = new SqlParameter("@ID2", ID2);
			SqlParameter p55 = new SqlParameter("@Comments", Comments);
			SqlParameter p56 = new SqlParameter("@Active", Active);
			SqlParameter p57 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateUserQuery", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57 });
		}

		public DataTable UpdateUserRight(int GroupUserID, int UserID, string GroupCode, int Type, string AppArea, int RightLevel, DateTime? BDate, DateTime? EDate, int Active, int ByID)
    {
      DBInterface di = new DBInterface();
      SqlParameter p1 = new SqlParameter("@AppCode", "DataMngt");
      SqlParameter p2 = new SqlParameter("@GroupUserID", GroupUserID);
      SqlParameter p3 = new SqlParameter("@UserID", UserID);
      SqlParameter p4 = new SqlParameter("@GroupCode", GroupCode);
      SqlParameter p5 = new SqlParameter("@Type", Type);
      SqlParameter p6 = new SqlParameter("@AppArea", AppArea);
      SqlParameter p7 = new SqlParameter("@RightLevel", RightLevel);
      SqlParameter p8 = new SqlParameter("@BeginDate", BDate);
      SqlParameter p9 = new SqlParameter("@EndDate", EDate);
      SqlParameter p10 = new SqlParameter("@Active", Active);
      SqlParameter p11 = new SqlParameter("@ByID", ByID);
      return di.RunSPReturnDataTableNWDW("web.usp_UpdateUserRight", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11 });
    }

		public DataTable UpdateUserRightLevel(int ID, int UserID, string GroupCode, int RightLevel, int PageID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@AppCode", "DataMngt");
			SqlParameter p3 = new SqlParameter("@UserID", UserID);
			SqlParameter p4 = new SqlParameter("@GrpCode", GroupCode);
			SqlParameter p5 = new SqlParameter("@RLevel", RightLevel);
			SqlParameter p6 = new SqlParameter("@PageID", PageID);
			SqlParameter p7 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_UpdateUserRightLevel", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7 });
		}

		public DataTable UpdateUserTracks(int UserID, int PgID, int PgObjID, int PgNbr, int PgSize, string StatusCode, string ProdType, string Prod, string Reg, string Loc, string Species, string Thick, string Grade,
			string Seasoning, string Surface, string Width, string Len, string Color, string fSort, string Milling, string NoPrint, string Cust, string Vendor, string Supplier, int ShowWks, int HideComments, int Excl0s, int IncHist,
			int Sort, int FontSz, string ItemCode, string ItemName, string ItemDesc, int MainID, int MgrID, int CustID, int OrderID, int ShipID, int OtherID, int LoadID, int Setting1, int Setting2, int Setting3, int Setting4, int Setting5, 
			DateTime? BeginDt, DateTime? EndDt, DateTime? TargetDT, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppCode", "DataMngt");
			SqlParameter p2 = new SqlParameter("@UserID", UserID);
			SqlParameter p3 = new SqlParameter("@PgID", PgID);
			SqlParameter p4 = new SqlParameter("@PgObjID", PgObjID);
			SqlParameter p5 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p6 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p7 = new SqlParameter("@StatusCode", StatusCode);
			SqlParameter p8 = new SqlParameter("@ProdType", ProdType);
			SqlParameter p9 = new SqlParameter("@Product", Prod);
			SqlParameter p10 = new SqlParameter("@Reg", Reg);
			SqlParameter p11 = new SqlParameter("@Location", Loc);
			SqlParameter p12 = new SqlParameter("@Species", Species);
			SqlParameter p13 = new SqlParameter("@Thickness", Thick);
			SqlParameter p14 = new SqlParameter("@Grade", Grade);
			SqlParameter p15 = new SqlParameter("@Seasoning", Seasoning);
			SqlParameter p16 = new SqlParameter("@Surface", Surface);
			SqlParameter p17 = new SqlParameter("@Width", Width);
			SqlParameter p18 = new SqlParameter("@Len", Len);
			SqlParameter p19 = new SqlParameter("@Color", Color);
			SqlParameter p20 = new SqlParameter("@fSort", fSort);
			SqlParameter p21 = new SqlParameter("@Milling", Milling);
			SqlParameter p22 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p23 = new SqlParameter("@CustCode", Cust);
			SqlParameter p24 = new SqlParameter("@VendorCode", Vendor);
			SqlParameter p25 = new SqlParameter("@SupplierCode", Supplier);
			SqlParameter p26 = new SqlParameter("@ShowWks", ShowWks);
			SqlParameter p27 = new SqlParameter("@HideComments", HideComments);
			SqlParameter p28 = new SqlParameter("@Excl0s", Excl0s);
			SqlParameter p29 = new SqlParameter("@IncHist", IncHist);
			SqlParameter p30 = new SqlParameter("@Sort", Sort);
			SqlParameter p31 = new SqlParameter("@FontSz", FontSz);
			SqlParameter p32 = new SqlParameter("@ItemCode", ItemCode);
			SqlParameter p33 = new SqlParameter("@ItemName", ItemName);
			SqlParameter p34 = new SqlParameter("@ItemDesc", ItemDesc);
			SqlParameter p35 = new SqlParameter("@MainID", MainID);
			SqlParameter p36 = new SqlParameter("@MgrID", MgrID);
			SqlParameter p37 = new SqlParameter("@CustomerID", CustID);
			SqlParameter p38 = new SqlParameter("@OrderID", OrderID);
			SqlParameter p39 = new SqlParameter("@ShipmentID", ShipID);
			SqlParameter p40 = new SqlParameter("@OtherID", OtherID);
			SqlParameter p41 = new SqlParameter("@LoadID", LoadID);
			SqlParameter p42 = new SqlParameter("@Setting1", Setting1);
			SqlParameter p43 = new SqlParameter("@Setting2", Setting2);
			SqlParameter p44 = new SqlParameter("@Setting3", Setting3);
			SqlParameter p45 = new SqlParameter("@Setting4", Setting4);
			SqlParameter p46 = new SqlParameter("@Setting5", Setting5);
			SqlParameter p47 = new SqlParameter("@BeginDt", BeginDt);
			SqlParameter p48 = new SqlParameter("@EndDt", EndDt);
			SqlParameter p49 = new SqlParameter("@TargetDateTime", TargetDT);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateUserTracks", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49 });
		}

		public void WriteToLog(string Msg, string LogFile)
		{
			string logFile = string.Empty;
			int iResult = 0;
			DateTime dt = DateTime.Now;
			string sDate = dt.ToString("MM/dd/yyyyH:mm:ss");
			Commands cmd = new Commands();
			try
			{
				//string LogFile = System.Configuration.ConfigurationManager.AppSettings["AppLogFilePath"].ToString();
				string rtn = AppendStringToLog(LogFile, Msg);
			}
			catch (Exception ex)
			{
				iResult = cmd.LogApplicationError("SageApproval", 0, 0, ex.Message, 0, "WriteToEventLog error", 0);
			}
		}

		public void WriteToEventLog(string Msg, string EventLog)
		{
			string logFile = string.Empty;
			int iResult = 0;
			DateTime dt = DateTime.Now;
			string sDate = dt.ToString("MM/dd/yyyyH:mm:ss");
			Msg = sDate + " " + Msg;
			try
			{
				//string EventLog = System.Configuration.ConfigurationManager.AppSettings["EventLogFilePath"].ToString();
				string rtn = AppendStringToLog(EventLog, Msg);
			}
			catch (Exception ex)
			{
				Commands cmd = new Commands();
				iResult = cmd.LogApplicationError("SageApproval", 0, 0, ex.Message, 0, "WriteToEventLog error", 0);
			}
		}

		public string AppendStringToLog(string FileName, string Msg)
		{
			string logFile = string.Empty;
			DateTime dt = DateTime.Now;
			string sDate = dt.ToString("MM/dd/yyyy H:mm:ss");
			Msg = sDate + " " + Msg;
			Commands cmd = new Commands();
			try
			{
				StreamWriter objWriter = new StreamWriter(FileName, true);
				objWriter.WriteLine(Msg);
				objWriter.Close();
				return "";
			}
			catch (Exception ex)
			{
				return ex.Message;
			}
		}

	}
}
