using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace DataLayer
{
	public class SalesFunctions
	{
		public DataTable SelectConsolidationLocationList(int UserID, string LocCode, string Region, string LocType, string Country, string City, int Class, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@UserID", UserID);
			SqlParameter p2 = new SqlParameter("@LocCode", LocCode);
			SqlParameter p3 = new SqlParameter("@Region", Region);
			SqlParameter p4 = new SqlParameter("@LocType", LocType);
			SqlParameter p5 = new SqlParameter("@Country", Country);
			SqlParameter p6 = new SqlParameter("@City", City);
			SqlParameter p7 = new SqlParameter("@Class", Class);
			SqlParameter p8 = new SqlParameter("@Sort", Sort);
			SqlParameter p9 = new SqlParameter("@Active", Active);
			SqlParameter p10 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectConsolidationLocationList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10 });
		}

		public DataTable SelectFCConsolidationData(int DType, string Region, string Loc, string Prod, string Species, string Grade, string Thickness, string Surface, string Seasoning, string Len, string Color, string Sort,
			string Milling, string NoPrint, string Level, DateTime TDate, string FuzzyGrade, string FuzzySort, string FuzzyProd, int PgNbr, int PgSize, int NoEmpties, int DataSort, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@DataType", DType);
			SqlParameter p2 = new SqlParameter("@Region", Region);
			SqlParameter p3 = new SqlParameter("@LocCode", Loc);
			SqlParameter p4 = new SqlParameter("@ProdCode", Prod);
			SqlParameter p5 = new SqlParameter("@Species", Species);
			SqlParameter p6 = new SqlParameter("@Grade", Grade);
			SqlParameter p7 = new SqlParameter("@Thickness", Thickness);
			SqlParameter p8 = new SqlParameter("@Surface", Surface);
			SqlParameter p9 = new SqlParameter("@Seasoning", Seasoning);
			SqlParameter p10 = new SqlParameter("@Len", Len);
			SqlParameter p11 = new SqlParameter("@Color", Color);
			SqlParameter p12 = new SqlParameter("@Sort", Sort);
			SqlParameter p13 = new SqlParameter("@Milling", Milling);
			SqlParameter p14 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p15 = new SqlParameter("@Level", Level);
			SqlParameter p16 = new SqlParameter("@TargetDate", TDate);
			SqlParameter p17 = new SqlParameter("@FuzzyGrade", FuzzyGrade);
			SqlParameter p18 = new SqlParameter("@FuzzySort", FuzzySort);
			SqlParameter p19 = new SqlParameter("@FuzzyProd", FuzzyProd);
			SqlParameter p20 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p21 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p22 = new SqlParameter("@DataSort", DataSort);
			SqlParameter p23 = new SqlParameter("@NoEmptyProds", NoEmpties);
			SqlParameter p24 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectFCProductConsolidationView", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24 });
		}

		public DataTable SelectFCConsolidationDataHist(int DType, string Region, string Loc, string Prod, string Species, string Grade, string Thickness, string Surface, string Seasoning, string Len, string Color, string Sort,
			string Milling, string NoPrint, string Level, DateTime TDate, string FuzzyGrade, string FuzzySort, string FuzzyProd, int PgNbr, int PgSize, int NoEmpties, int DataSort, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@DataType", DType);
			SqlParameter p2 = new SqlParameter("@Region", Region);
			SqlParameter p3 = new SqlParameter("@LocCode", Loc);
			SqlParameter p4 = new SqlParameter("@ProdCode", Prod);
			SqlParameter p5 = new SqlParameter("@Species", Species);
			SqlParameter p6 = new SqlParameter("@Grade", Grade);
			SqlParameter p7 = new SqlParameter("@Thickness", Thickness);
			SqlParameter p8 = new SqlParameter("@Surface", Surface);
			SqlParameter p9 = new SqlParameter("@Seasoning", Seasoning);
			SqlParameter p10 = new SqlParameter("@Len", Len);
			SqlParameter p11 = new SqlParameter("@Color", Color);
			SqlParameter p12 = new SqlParameter("@Sort", Sort);
			SqlParameter p13 = new SqlParameter("@Milling", Milling);
			SqlParameter p14 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p15 = new SqlParameter("@Level", Level);
			SqlParameter p16 = new SqlParameter("@TargetDate", TDate);
			SqlParameter p17 = new SqlParameter("@FuzzyGrade", FuzzyGrade);
			SqlParameter p18 = new SqlParameter("@FuzzySort", FuzzySort);
			SqlParameter p19 = new SqlParameter("@FuzzyProd", FuzzyProd);
			SqlParameter p20 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p21 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p22 = new SqlParameter("@DataSort", DataSort);
			SqlParameter p23 = new SqlParameter("@NoEmptyProds", NoEmpties);
			SqlParameter p24 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectFCProductConsolidationViewHistory", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24 });
		}

		public DataTable SelectLTProdCustomerList(string Seed, int Sort, int Min, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Seed", Seed);
			SqlParameter p2 = new SqlParameter("@Sort", Sort);
			SqlParameter p3 = new SqlParameter("@Min", Min);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectLTCustomerList", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable SelectLTShippingList(int ShipNbr, string Region, string Loc, string Thickness, string Species, string Grade, string Len, string Color, string fSort, string Milling,
			string NoPrint, int Vendor, string sBDt, string sEDt, int Sort, int PgNbr, int PgSize, int ByID)
		{
			DateTime? bdate = null;
			DateTime? edate = null;
			if (sBDt != "") { bdate = Convert.ToDateTime(sBDt); }
			if (sEDt != "") { edate = Convert.ToDateTime(sEDt); }
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ShipNbr", ShipNbr);
			SqlParameter p2 = new SqlParameter("@LocCode", Loc);
			SqlParameter p3 = new SqlParameter("@Vendor", Vendor);
			SqlParameter p4 = new SqlParameter("@BeginDate", bdate);
			SqlParameter p5 = new SqlParameter("@EndDate", edate);
			SqlParameter p6 = new SqlParameter("@Sort", Sort);
			SqlParameter p7 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p8 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p9 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectLTShipmentList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9 });
		}

		public DataTable SelectLTWurthProductData(int OrdNbr, int DPage, int WurthOnly, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@OrdNbr", OrdNbr);
			SqlParameter p2 = new SqlParameter("@Page", DPage);
			SqlParameter p3 = new SqlParameter("@WurthOnly", WurthOnly);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectLTProdWurthData", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable SelectProductCodesManaged(string ProdType, string ProdCode, string Reg, string Thickness, string Specie, string Grade, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ProdType", ProdType);
			SqlParameter p2 = new SqlParameter("@ProdCode", ProdCode);
			SqlParameter p3 = new SqlParameter("@Region", Reg);
			SqlParameter p4 = new SqlParameter("@Thickness", Thickness);
			SqlParameter p5 = new SqlParameter("@Specie", Specie);
			SqlParameter p6 = new SqlParameter("@Grade", Grade);
			SqlParameter p7 = new SqlParameter("@Sort", Sort);
			SqlParameter p8 = new SqlParameter("@Active", Active);
			SqlParameter p9 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectProductCodesManaged", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9 });
		}

		public DataTable SelectProductDataForTargetWeek(string ProdType, string ProdCode, int WeekNbr, int Rollup, int RollProd, int NoLoc, int NoCust, int NoForecast, int NoOrd, int NoProd, int Sort, int PgNbr, int PgSize, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ProdType", ProdType);
			SqlParameter p2 = new SqlParameter("@ProdCode", ProdCode);
			SqlParameter p3 = new SqlParameter("@WeekNbr", WeekNbr);
			SqlParameter p4 = new SqlParameter("@Rollup", Rollup);
			SqlParameter p5 = new SqlParameter("@RollProd", RollProd);
			SqlParameter p6 = new SqlParameter("@NoLoc", NoLoc);
			SqlParameter p7 = new SqlParameter("@NoCust", NoCust);
			SqlParameter p8 = new SqlParameter("@NoForecast", NoForecast);
			SqlParameter p9 = new SqlParameter("@NoOrders", NoOrd);
			SqlParameter p10 = new SqlParameter("@NoProd", NoProd);
			SqlParameter p11 = new SqlParameter("@Sort", Sort);
			SqlParameter p12 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p13 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p14 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("dbo.usp_SelectProductDataForTargetWeek", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14 });
		}

		public DataTable SelectProductDataForTargetWeek2(string ProdType, string ProdCode, string Color, string fSort, string Milling, string NoPrint, int WeekNbr, int Rollup, int RollProd, int NoLoc, int NoCust, int NoForecast, 
			int NoOrd, int NoProd, int NoInv, int Sort, int PgNbr, int PgSize, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ProdType", ProdType);
			SqlParameter p2 = new SqlParameter("@ProdCode", ProdCode);
			SqlParameter p3 = new SqlParameter("@Color", Color);
			SqlParameter p4 = new SqlParameter("@fSort", fSort);
			SqlParameter p5 = new SqlParameter("@Milling", Milling);
			SqlParameter p6 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p7 = new SqlParameter("@WeekNbr", WeekNbr);
			SqlParameter p8 = new SqlParameter("@Rollup", Rollup);
			SqlParameter p9 = new SqlParameter("@RollProd", RollProd);
			SqlParameter p10 = new SqlParameter("@NoLoc", NoLoc);
			SqlParameter p11 = new SqlParameter("@NoCust", NoCust);
			SqlParameter p12 = new SqlParameter("@NoForecast", NoForecast);
			SqlParameter p13 = new SqlParameter("@NoOrders", NoOrd);
			SqlParameter p14 = new SqlParameter("@NoProd", NoProd);
			SqlParameter p15 = new SqlParameter("@NoInventory", NoInv);
			SqlParameter p16 = new SqlParameter("@Sort", Sort);
			SqlParameter p17 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p18 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p19 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("dbo.usp_SelectProductDataForTargetWeek2", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19 });
		}

		public DataTable SelectProductItemData(int PMID, int PLID, string ProdType, string ProdCode, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@PMID", PMID);
			SqlParameter p2 = new SqlParameter("@PLID", PLID);
			SqlParameter p3 = new SqlParameter("@ProdType", ProdType);
			SqlParameter p4 = new SqlParameter("@ProdCode", ProdCode);
			SqlParameter p5 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectProductItemData", new SqlParameter[] { p1, p2, p3, p4, p5 });
		}

		public DataTable SelectProductItemDataWide(int PMID, string ProdType, string ProdCode, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@PMID", PMID);
			SqlParameter p2 = new SqlParameter("@ProdType", ProdType);
			SqlParameter p3 = new SqlParameter("@ProdCode", ProdCode);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectProductItemDataWIDE", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable SelectProductListManaged(int PMID, string ProdType, string ProdCode, string Reg, string Thickness, string Specie, string Grade, int Sort, int Active, int Short, int PgNbr, int PgSize, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@PMID", PMID);
			SqlParameter p2 = new SqlParameter("@ProdType", ProdType);
			SqlParameter p3 = new SqlParameter("@ProdCode", ProdCode);
			SqlParameter p4 = new SqlParameter("@Region", Reg);
			SqlParameter p5 = new SqlParameter("@Thickness", Thickness);
			SqlParameter p6 = new SqlParameter("@Specie", Specie);
			SqlParameter p7 = new SqlParameter("@Grade", Grade);
			SqlParameter p8 = new SqlParameter("@Sort", Sort);
			SqlParameter p9 = new SqlParameter("@Active", Active);
			SqlParameter p10 = new SqlParameter("@Short", Short);
			SqlParameter p11 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p12 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p13 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectProductListManaged", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13 });
		}

		public DataTable SelectSalesGroupList(int Active, int iType, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Active", Active);
			SqlParameter p2 = new SqlParameter("@Type", iType);
			SqlParameter p3 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectSalesGroupList", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable SelectSalesLeadList(int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@GrpCode", "saleslead");
			SqlParameter p2 = new SqlParameter("@Sort", 0);
			SqlParameter p3 = new SqlParameter("@Active", Active);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectUserGroupMembers", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable SelectSalesManagerList(int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Active", Active);
			SqlParameter p2 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectSalesManagerList", new SqlParameter[] { p1, p2 });
		}

		public DataTable SelectSalesOrderDataDetailed(string Reg, string LocCode, string LocType, string PCode, string PType, string Thick, string Specie, string Grade, string Season, string Surf,
			string Wdth, string Len, string Color, string fSort, string Milling, string NoPrint, string FuzzyGrade, string FuzzySort, string FuzzyProd, string sBDt, string sEDt, int OrdNbr, string CustCode, 
			string Lvl, int Sort, int Active, int ROnly, int APShipStat, int DateType, int PgNbr, int PgSize, int ByID)
		{
			DateTime? bdate = null;
			DateTime? edate = null;
			if (sBDt.Length > 0) { bdate = Convert.ToDateTime(sBDt); }
			if (sEDt.Length > 0) { bdate = Convert.ToDateTime(sEDt); }
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Reg", Reg);
			SqlParameter p2 = new SqlParameter("@LocCode", LocCode);
			SqlParameter p3 = new SqlParameter("@LocType", LocType);
			SqlParameter p4 = new SqlParameter("@ProdCode", PCode);
			SqlParameter p5 = new SqlParameter("@ProdType", PType);
			SqlParameter p6 = new SqlParameter("@Thick", Thick);
			SqlParameter p7 = new SqlParameter("@Specie", Specie);
			SqlParameter p8 = new SqlParameter("@Grade", Grade);
			SqlParameter p9 = new SqlParameter("@Seasoning", Season);
			SqlParameter p10 = new SqlParameter("@Surface", Surf);
			SqlParameter p11 = new SqlParameter("@Width", Wdth);
			SqlParameter p12 = new SqlParameter("@Len", Len);
			SqlParameter p13 = new SqlParameter("@Color", Color);
			SqlParameter p14 = new SqlParameter("@fSort", fSort);
			SqlParameter p15 = new SqlParameter("@Milling", Milling);
			SqlParameter p16 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p17 = new SqlParameter("@FuzzyGrade", FuzzyGrade);
			SqlParameter p18 = new SqlParameter("@FuzzySort", FuzzySort);
			SqlParameter p19 = new SqlParameter("@FuzzyProd", FuzzyProd);
			SqlParameter p20 = new SqlParameter("@BDate", bdate);
			SqlParameter p21 = new SqlParameter("@EDate", edate);
			SqlParameter p22 = new SqlParameter("@OrdNbr", OrdNbr);
			SqlParameter p23 = new SqlParameter("@CustCode", CustCode);
			SqlParameter p24 = new SqlParameter("@Level", Lvl);
			SqlParameter p25 = new SqlParameter("@Sort", Sort);
			SqlParameter p26 = new SqlParameter("@Active", Active);
			SqlParameter p27 = new SqlParameter("@ROnly", ROnly);
			SqlParameter p28 = new SqlParameter("@DateType", DateType);
			SqlParameter p29 = new SqlParameter("@APShipStat", APShipStat);
			SqlParameter p30 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p31 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p32 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectSalesOrdersDetailed", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32 });
		}

		public DataTable SelectSalesPersonList(int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@GrpCode", "salespers");
			SqlParameter p2 = new SqlParameter("@Sort", 0);
			SqlParameter p3 = new SqlParameter("@Active", Active);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectUserGroupMembers", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable SelectSalesPlanGridData(string Reg, string Loc, string PType, string Prod, string Thick, string Spec, string Grade, string Season, string Surf, string Len, string Color, string FSort, 
			string Milling, string NoPrint, string Cust, string Mgr, int IncInven, int IncSales, int IncForecast, int IncHolds, int IncProd, int IncCust, int IncHist, int IncPHist, string RollupItems, int Sort,
			string FuzzyGrade, string FuzzySort, string FuzzyProd, string FuzzyMgr, string FuzzyCust, string CustCode, int PgNbr, int PgSize, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Region", Reg);
			SqlParameter p2 = new SqlParameter("@LocCode", Loc);
			SqlParameter p3 = new SqlParameter("@ProdType", PType);
			SqlParameter p4 = new SqlParameter("@ProdCode", Prod);
			SqlParameter p5 = new SqlParameter("@Thickness", Thick);
			SqlParameter p6 = new SqlParameter("@Species", Spec);
			SqlParameter p7 = new SqlParameter("@Grade", Grade);
			SqlParameter p8 = new SqlParameter("@Seasoning", Season);
			SqlParameter p9 = new SqlParameter("@Surface", Surf);
			SqlParameter p10 = new SqlParameter("@Len", Len);
			SqlParameter p11 = new SqlParameter("@Color", Color);
			SqlParameter p12 = new SqlParameter("@fSort", FSort);
			SqlParameter p13 = new SqlParameter("@Milling", Milling);
			SqlParameter p14 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p15 = new SqlParameter("@CustCodes", Cust);
			SqlParameter p16 = new SqlParameter("@Mgr", Mgr);
			SqlParameter p17 = new SqlParameter("@IncInven", IncInven);
			SqlParameter p18 = new SqlParameter("@IncSales", IncSales);
			SqlParameter p19 = new SqlParameter("@IncForecast", IncForecast);
			SqlParameter p20 = new SqlParameter("@IncHolds", IncHolds);
			SqlParameter p21 = new SqlParameter("@IncProd", IncProd);
			SqlParameter p22 = new SqlParameter("@IncCustomers", IncCust);
			SqlParameter p23 = new SqlParameter("@IncHistory", IncHist);
			SqlParameter p24 = new SqlParameter("@IncProdHist", IncPHist);
			SqlParameter p25 = new SqlParameter("@RollupItems", RollupItems);
			SqlParameter p26 = new SqlParameter("@Sort", Sort);
			SqlParameter p27 = new SqlParameter("@FuzzyGrade", FuzzyGrade);
			SqlParameter p28 = new SqlParameter("@FuzzySort", FuzzySort);
			SqlParameter p29 = new SqlParameter("@FuzzyProd", FuzzyProd);
			SqlParameter p30 = new SqlParameter("@FuzzyMgr", FuzzyMgr);
			SqlParameter p31 = new SqlParameter("@FuzzyCust", FuzzyCust);
			SqlParameter p32 = new SqlParameter("@CustCd", CustCode);
			SqlParameter p33 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p34 = new SqlParameter("@PgSIze", PgSize);
			SqlParameter p35 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectSalesPlanGridData", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35 });
		}

		public DataTable SelectSalesPlanGridDataExport(int UserID, int PgID, int ObjID, string ExpFileNm, string ProdType, string ProdCode, string LocCode, string Reg, string Thick, string Spec, string Grade, string Season, string Surf, 
			string Stat, int iType, string Wdth, string Len, string Color, string FSort, string Milling, string NoPrint, int OrderID, int ShipID, int LoadID, string Cust, string Vendor, string Supplier, string Mgr, int MgrID, 
			int IncInven, int IncSales, int IncHolds, int IncProd, int IncCust, int IncHist, int IncPHist, string RollupItems, string FuzzyGrade, string FuzzySort, string FuzzyProd, string FuzzyMgr, string FuzzyCust, string Fuzzy6,
			string IName, string IDesc, double Nbr, string Code1, string Code2, int id1, int id2,	DateTime? TDate, DateTime? BDate, DateTime? EDate,	string CustCode, string SubTotal, string Cmt, int Sort, int Active)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@UserID", UserID);
			SqlParameter p2 = new SqlParameter("@AppName", "DataMngt");
			SqlParameter p3 = new SqlParameter("@ExpFileName", ExpFileNm);
			SqlParameter p4 = new SqlParameter("@ProdType", ProdType);
			SqlParameter p5 = new SqlParameter("@ProductCode", ProdCode);
			SqlParameter p6 = new SqlParameter("@LocationCode", LocCode);
			SqlParameter p7 = new SqlParameter("@RegionCode", Reg);
			SqlParameter p8 = new SqlParameter("@ThicknessCode", Thick);
			SqlParameter p9 = new SqlParameter("@SpeciesCode", Spec);
			SqlParameter p10 = new SqlParameter("@GradeCode", Grade);
			SqlParameter p11 = new SqlParameter("@SeasoningCode", Season);
			SqlParameter p12 = new SqlParameter("@SurfaceCode", Surf);
			SqlParameter p13 = new SqlParameter("@StatusCode", Stat);
			SqlParameter p14 = new SqlParameter("@WidthCode", Wdth);
			SqlParameter p15 = new SqlParameter("@LengthCode", Len);
			SqlParameter p16 = new SqlParameter("@ColorCode", Color);
			SqlParameter p17 = new SqlParameter("@SortCode", FSort);
			SqlParameter p18 = new SqlParameter("@MillingCode", Milling);
			SqlParameter p19 = new SqlParameter("@NoPrintCode", NoPrint);
			SqlParameter p20 = new SqlParameter("@TypeID", iType);
			SqlParameter p21 = new SqlParameter("@Setting0", IncInven);
			SqlParameter p22 = new SqlParameter("@Setting1", IncSales);
			SqlParameter p23 = new SqlParameter("@Setting2", IncHolds);
			SqlParameter p24 = new SqlParameter("@Setting3", IncProd);
			SqlParameter p25 = new SqlParameter("@Setting4", IncCust);
			SqlParameter p26 = new SqlParameter("@Setting5", IncHist);
			SqlParameter p27 = new SqlParameter("@Setting6", IncPHist);
			SqlParameter p28 = new SqlParameter("@Setting7", 0);
			SqlParameter p29 = new SqlParameter("@OrderID", OrderID);
			SqlParameter p30 = new SqlParameter("@ShipmentID", ShipID);
			SqlParameter p31 = new SqlParameter("@LoadID", LoadID);
			SqlParameter p32 = new SqlParameter("@CustCodes", Cust);
			SqlParameter p33 = new SqlParameter("@VendorCode", Vendor);
			SqlParameter p34 = new SqlParameter("@SupplierCode", Supplier);
			SqlParameter p35 = new SqlParameter("@MgrName", Mgr);
			SqlParameter p36 = new SqlParameter("@MgrID", MgrID);
			SqlParameter p37 = new SqlParameter("@ItemName", IName);
			SqlParameter p38 = new SqlParameter("@ItemDescription", IDesc);
			SqlParameter p39 = new SqlParameter("@Nbr", Nbr);
			SqlParameter p40 = new SqlParameter("@Code1", Code1);
			SqlParameter p41 = new SqlParameter("@Code2", Code2);
			SqlParameter p42 = new SqlParameter("@ID1", id1);
			SqlParameter p43 = new SqlParameter("@ID2", id2);
			SqlParameter p44 = new SqlParameter("@Comments", Cmt);
			SqlParameter p45 = new SqlParameter("@Fuzzy1", FuzzyGrade);
			SqlParameter p46 = new SqlParameter("@Fuzzy2", FuzzySort);
			SqlParameter p47 = new SqlParameter("@Fuzzy3", FuzzyProd);
			SqlParameter p48 = new SqlParameter("@Fuzzy4", FuzzyMgr);
			SqlParameter p49 = new SqlParameter("@Fuzzy5", FuzzyCust);
			SqlParameter p50 = new SqlParameter("@Fuzzy6", Fuzzy6);
			SqlParameter p51 = new SqlParameter("@CustCode", CustCode);
			SqlParameter p52 = new SqlParameter("@TargetDateTime", TDate);
			SqlParameter p53 = new SqlParameter("@BeginDate", BDate);
			SqlParameter p54 = new SqlParameter("@EndDate", EDate);
			SqlParameter p55 = new SqlParameter("@RollupItems", RollupItems);
			SqlParameter p56 = new SqlParameter("@SubTotal", SubTotal);
			SqlParameter p57 = new SqlParameter("@SortID", Sort);
			SqlParameter p58 = new SqlParameter("@Active", Active);
			return di.RunSPReturnDataTableNWB("web.usp_SelectSalesPlanGridDataExport", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57, p58 });
		}

		public DataTable SelectUserConsolidationLocationsList(string Grp, int iType, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@UserID", ByID);
			SqlParameter p2 = new SqlParameter("@UnselectedOnly", iType);
			SqlParameter p3 = new SqlParameter("@GrpCode", Grp);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectUserForecastLocationList", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable SelectUserExportData(int UserID, int PgID, int ObjID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@UserID", UserID);
			SqlParameter p2 = new SqlParameter("@AppName", "DataMngt");
			SqlParameter p3 = new SqlParameter("@PgID", PgID);
			SqlParameter p4 = new SqlParameter("@ObjID", ObjID);
			SqlParameter p5 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectUserExportData", new SqlParameter[] { p1, p2, p3, p4, p5 });
		}

		public DataTable UpdateSalesPlanDataExport(int UserID, int PgID, int ObjID, string ExpFileNm, string ProdType, string ProdCode, string LocCode, string Reg, string Thick, string Spec, string Grade, string Season, string Surf,
			string Stat, int iType, string Wdth, string Len, string Color, string FSort, string Milling, string NoPrint, int OrderID, int ShipID, int LoadID, string Cust, string Vendor, string Supplier, string Mgr, int MgrID,
			int IncInven, int IncSales, int IncHolds, int IncProd, int IncCust, int IncHist, int IncPHist, string RollupItems, string FuzzyGrade, string FuzzySort, string FuzzyProd, string FuzzyMgr, string FuzzyCust, string Fuzzy6,
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
			SqlParameter p23 = new SqlParameter("@Setting0", IncInven);
			SqlParameter p24 = new SqlParameter("@Setting1", IncSales);
			SqlParameter p25 = new SqlParameter("@Setting2", IncHolds);
			SqlParameter p26 = new SqlParameter("@Setting3", IncProd);
			SqlParameter p27 = new SqlParameter("@Setting4", IncCust);
			SqlParameter p28 = new SqlParameter("@Setting5", IncHist);
			SqlParameter p29 = new SqlParameter("@Setting6", IncPHist);
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

	}
}
