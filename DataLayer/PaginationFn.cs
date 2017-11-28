using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace DataLayer
{
	public class PaginationFn
	{
		public DataTable GetPageSettings(int PageID, int ObjID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@EmpID", ByID);
			SqlParameter p2 = new SqlParameter("@AppName", "SageApproval");
			SqlParameter p3 = new SqlParameter("@PageID", PageID);
			SqlParameter p4 = new SqlParameter("@PgObjID", ObjID);
			SqlParameter p5 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTable("web.up_GetPageSettings", new SqlParameter[] { p1, p2, p3, p4, p5 });
		}

		public DataTable UpdateUIPageSetting(int PageID, int ObjID, int iType, int Nbr, DateTime? dte, string Value, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@EmpID", ByID);
			SqlParameter p2 = new SqlParameter("@AppName", "SageApproval");
			SqlParameter p3 = new SqlParameter("@PageID", PageID);
			SqlParameter p4 = new SqlParameter("@PgObjectID", ObjID);
			SqlParameter p5 = new SqlParameter("@Type", iType);
			SqlParameter p6 = new SqlParameter("@Nbr", Nbr);
			SqlParameter p7 = new SqlParameter("@Date", dte);
			SqlParameter p8 = new SqlParameter("@Value", Value);
			SqlParameter p9 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTable("web.up_UpdatePageUISetting", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9 });
		}

		public DataTable UpdateUIPageSettings(int PageID, int PgObjID, int PageNbr, int PgSize, int MainID, int EmpID, int OrderID, int VendorID, int CustID, int SuppID, int SpeciesID, int LocID, int ShipID, int ItemID, 
            int MgrID, int GroupID, int SortID, int LoadID, int OtherID, double Nbr, DateTime? BeginDt, DateTime? EndDt, DateTime? TargetDt, string ItemCode, string ItemName, string TagNbr, string CustCode, string VendorCode,
            string LocCode, string SpeciesCode, string SuppCode, string ThickCode, string GradeCode, string StatusCode, int iType, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppName", "DataMngt");
			SqlParameter p2 = new SqlParameter("@UserID", ByID);
      SqlParameter p3 = new SqlParameter("@PageID", PageID);
			SqlParameter p4 = new SqlParameter("@PgObjID", PgObjID);
			SqlParameter p5 = new SqlParameter("@PgNbr", PageNbr);
			SqlParameter p6 = new SqlParameter("@PgSize", PgSize);
      SqlParameter p7 = new SqlParameter("@MainID", MainID);
      SqlParameter p8 = new SqlParameter("@EmpID", EmpID);
      SqlParameter p9 = new SqlParameter("@OrderID", OrderID);
      SqlParameter p10 = new SqlParameter("@VendorID", VendorID);
      SqlParameter p11 = new SqlParameter("@CustomerID", CustID);
      SqlParameter p12 = new SqlParameter("@SupplierID", SuppID);
      SqlParameter p13 = new SqlParameter("@SpeciesID", SpeciesID);
      SqlParameter p14 = new SqlParameter("@LocationID", LocID);
      SqlParameter p15 = new SqlParameter("@ShipmentID", ShipID);
      SqlParameter p16 = new SqlParameter("@ItemID", ItemID);
      SqlParameter p17 = new SqlParameter("@MgrID", MgrID);
      SqlParameter p18 = new SqlParameter("@GroupID", GroupID);
      SqlParameter p19 = new SqlParameter("@SortID", SortID);
      SqlParameter p20 = new SqlParameter("@LoadID", LoadID);
      SqlParameter p21 = new SqlParameter("@OtherID", OtherID);
      SqlParameter p22 = new SqlParameter("@Nbr", Nbr);
      SqlParameter p23 = new SqlParameter("@BeginDate", BeginDt);
      SqlParameter p24 = new SqlParameter("@EndDate", EndDt);
      SqlParameter p25 = new SqlParameter("@TargetDate", TargetDt);
      SqlParameter p26 = new SqlParameter("@ItemCode", ItemCode);
      SqlParameter p27 = new SqlParameter("@ItemName", ItemName);
      SqlParameter p28 = new SqlParameter("@TagNbr", TagNbr);
      SqlParameter p29 = new SqlParameter("@CustCode", CustCode);
      SqlParameter p30 = new SqlParameter("@VendorCode", VendorCode);
      SqlParameter p31 = new SqlParameter("@LocationCode", LocCode);
      SqlParameter p32 = new SqlParameter("@SpeciesCode", SpeciesCode);
      SqlParameter p33 = new SqlParameter("@SupplierCode", SuppCode);
      SqlParameter p34 = new SqlParameter("@StatusCode", StatusCode);
      SqlParameter p35 = new SqlParameter("@ThicknessCode", ThickCode);
      SqlParameter p36 = new SqlParameter("@GradeCode", GradeCode);
      SqlParameter p37 = new SqlParameter("@Type", iType); //0-all, 1-not pagenbrs and sizes
			SqlParameter p38 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_UpdatePageUISettings", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38 });
		}

	}
}
