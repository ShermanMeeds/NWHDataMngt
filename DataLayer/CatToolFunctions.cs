using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace DataLayer
{
	public class CatToolFunctions
	{

		public DataTable GetCatCodeList(string CodeType, int Sort, int Active, int UserList, int NoBlank, int Shown, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@CodeType", CodeType);
			SqlParameter p2 = new SqlParameter("@Sort", Sort);
			SqlParameter p3 = new SqlParameter("@Active", Active);
			SqlParameter p4 = new SqlParameter("@UserList", UserList);
			SqlParameter p5 = new SqlParameter("@NoBLank", NoBlank);
			SqlParameter p6 = new SqlParameter("@Shown", Shown);
			SqlParameter p7 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectCatCodeList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7 });
		}

		public DataTable GetCatRegionList(int Act, int UserID) {
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Active", Act);
			SqlParameter p2 = new SqlParameter("@UserID", UserID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectCatRegions", new SqlParameter[] { p1, p2 });
		}

		public DataTable GetCatToolDetails(string Product, string SpecID, string Thickness, string GradeID, int Sort, int PgNbr, int PgSize, int ByID)
    {
      DBInterface di = new DBInterface();
      //SqlParameter p1 = new SqlParameter("@Product", Product);
      SqlParameter p1 = new SqlParameter("@Specie", SpecID);
      SqlParameter p2 = new SqlParameter("@Thickness", Thickness);
      SqlParameter p3 = new SqlParameter("@Grade", GradeID);
      SqlParameter p4 = new SqlParameter("@Sort", Sort);
      SqlParameter p5 = new SqlParameter("@PgNbr", PgNbr);
      SqlParameter p6 = new SqlParameter("@PgSize", PgSize);
      SqlParameter p7 = new SqlParameter("@UserID", ByID);
      return di.RunSPReturnDataTableNWB("web.usp_SelectCatToolDetails", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7 });
    }

    public DataTable GetCatToolDetails2(int ListID, string ProdType, string Product, string Len, string Color, string fSort, string Milling, string NoPrint, string TDate, int Sort, int PgNbr, int PgSize, int ByID)
    {
      DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ProdType", ProdType);
			SqlParameter p2 = new SqlParameter("@Product", Product);
			SqlParameter p3 = new SqlParameter("@Length", Len);
			SqlParameter p4 = new SqlParameter("@Color", Color);
			SqlParameter p5 = new SqlParameter("@FSort", fSort);
			SqlParameter p6 = new SqlParameter("@Milling", Milling);
			SqlParameter p7 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p8 = new SqlParameter("@TDate", TDate);
			SqlParameter p9 = new SqlParameter("@Sort", Sort);
			SqlParameter p10 = new SqlParameter("@ListID", ListID);
			SqlParameter p11 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p12 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p13 = new SqlParameter("@UserID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectCatToolDetails2", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13 });
		}

		public DataTable GetCatToolGridData(string Region, string LocID, string Product, string SpecID, string Thickness, string GradeID, string Len, string Color, string fSort, string Milling, string NoPrint, 
			string Desc, int Excl0, int Sort, int Active, int ShowLoc, string ColsOn, int PgNbr, int PgSize, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Region", Region);
			SqlParameter p2 = new SqlParameter("@LocID", LocID);
			SqlParameter p3 = new SqlParameter("@Product", Product);
			SqlParameter p4 = new SqlParameter("@SpeciesID", SpecID);
			SqlParameter p5 = new SqlParameter("@Thickness", Thickness);
			SqlParameter p6 = new SqlParameter("@GradeID", GradeID);
			SqlParameter p7 = new SqlParameter("@Length", Len);
			SqlParameter p8 = new SqlParameter("@Color", Color);
			SqlParameter p9 = new SqlParameter("@fSort", fSort);
			SqlParameter p10 = new SqlParameter("@Milling", Milling);
			SqlParameter p11 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p12 = new SqlParameter("@Desc", Desc);
			SqlParameter p13 = new SqlParameter("@Exclude0", Excl0);
			SqlParameter p14 = new SqlParameter("@Sort", Sort);
			SqlParameter p15 = new SqlParameter("@Active", Active);
      SqlParameter p16 = new SqlParameter("@ShowLoc", ShowLoc);
			SqlParameter p17 = new SqlParameter("@ColsOn", ColsOn);
			SqlParameter p18 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p19 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p20 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectCatToolGridData", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20 });
		}

		public DataTable GetCatToolGridDataSvc(string Region, string LocID, string Product, string SpecID, string Thickness, string GradeID, string Len, string Color, string fSort, string Milling, string NoPrint,
			string Desc, int Excl0, int Sort, int Active, int ShowLoc, string ColsOn, int PgNbr, int PgSize, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Region", Region);
			SqlParameter p2 = new SqlParameter("@LocID", LocID);
			SqlParameter p3 = new SqlParameter("@Product", Product);
			SqlParameter p4 = new SqlParameter("@SpeciesID", SpecID);
			SqlParameter p5 = new SqlParameter("@Thickness", Thickness);
			SqlParameter p6 = new SqlParameter("@GradeID", GradeID);
			SqlParameter p7 = new SqlParameter("@Length", Len);
			SqlParameter p8 = new SqlParameter("@Color", Color);
			SqlParameter p9 = new SqlParameter("@fSort", fSort);
			SqlParameter p10 = new SqlParameter("@Milling", Milling);
			SqlParameter p11 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p12 = new SqlParameter("@Desc", Desc);
			SqlParameter p13 = new SqlParameter("@Exclude0", Excl0);
			SqlParameter p14 = new SqlParameter("@Sort", Sort);
			SqlParameter p15 = new SqlParameter("@Active", Active);
			SqlParameter p16 = new SqlParameter("@ShowLoc", ShowLoc);
			SqlParameter p17 = new SqlParameter("@ColsOn", ColsOn);
			SqlParameter p18 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p19 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p20 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectCatToolGridDataSvc", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20 });
		}

		public DataTable GetCatToolGridDataExport(string Region, string LocID, string Product, string SpecID, string Thickness, string GradeID, string Len, string Color, string fSort, string Milling, string NoPrint, 
			string Desc, int Sort, int Excl0, int Active, int ByID)
    {
      DBInterface di = new DBInterface();
      SqlParameter p1 = new SqlParameter("@Region", Region);
      SqlParameter p2 = new SqlParameter("@LocID", LocID);
      SqlParameter p3 = new SqlParameter("@Product", Product);
      SqlParameter p4 = new SqlParameter("@SpeciesID", SpecID);
      SqlParameter p5 = new SqlParameter("@Thickness", Thickness);
      SqlParameter p6 = new SqlParameter("@GradeID", GradeID);
			SqlParameter p7 = new SqlParameter("@Length", Len);
			SqlParameter p8 = new SqlParameter("@Color", Color);
			SqlParameter p9 = new SqlParameter("@fSort", fSort);
			SqlParameter p10 = new SqlParameter("@Milling", Milling);
			SqlParameter p11 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p12 = new SqlParameter("@Desc", Desc);
      SqlParameter p13 = new SqlParameter("@Sort", Sort);
			SqlParameter p14 = new SqlParameter("@Exclude0", Excl0);
			SqlParameter p15 = new SqlParameter("@Active", Active);
      SqlParameter p16 = new SqlParameter("@ByID", ByID);
      return di.RunSPReturnDataTableNWB("web.usp_SelectCatToolGridDataExport", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16 });
    }

		public DataTable GetCatToolProductData(string ProdType, string Product, string TDate, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ProdType", ProdType);
			SqlParameter p2 = new SqlParameter("@Product", Product);
			SqlParameter p3 = new SqlParameter("@TDate", TDate);
			SqlParameter p4 = new SqlParameter("@Active", Active);
			SqlParameter p5 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectCatToolProductData", new SqlParameter[] { p1, p2, p3, p4, p5 });
		}

		public DataTable GetCatToolProductData2(string ProdType, string Product, string TDate, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ProdType", ProdType);
			SqlParameter p2 = new SqlParameter("@Product", Product);
			SqlParameter p3 = new SqlParameter("@TDate", TDate);
			SqlParameter p4 = new SqlParameter("@Active", Active);
			SqlParameter p5 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectCatToolProductData2", new SqlParameter[] { p1, p2, p3, p4, p5 });
		}

		public DataTable SelectSalesProductFullList (string Region, string Species, string Grade, string Thick, string Len, string Color, string fSort, string Milling, string NoPrint, string Comment, int Mngd,
			int Active, int Sort, int Dir, int PgNbr, int PgSize, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Region", Region);
			SqlParameter p2 = new SqlParameter("@Species", Species);
			SqlParameter p3 = new SqlParameter("@Grade", Grade);
			SqlParameter p4 = new SqlParameter("@Thick", Thick);
			SqlParameter p5 = new SqlParameter("@Len", Len);
			SqlParameter p6 = new SqlParameter("@Color", Color);
			SqlParameter p7 = new SqlParameter("@fSort", fSort);
			SqlParameter p8 = new SqlParameter("@Milling", Milling);
			SqlParameter p9 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p10 = new SqlParameter("@Managed", Mngd);
			SqlParameter p11 = new SqlParameter("@Comment", Comment);
			SqlParameter p12 = new SqlParameter("@Active", Active);
			SqlParameter p13 = new SqlParameter("@Sort", Sort);
			SqlParameter p14 = new SqlParameter("@Dir", Dir);
			SqlParameter p15 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p16 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p17 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectSalesProductMasterList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17 });
		}

		public DataTable UpdateCatToolProductDataItem(int ID, int iType, string sValue, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@iType", iType);
			SqlParameter p3 = new SqlParameter("@Value", sValue);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateCatProductDataItem", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable UpdateCatToolProductData(int ID, string Region, string Product, string ProdID, string Desc, double Price, string Comments, string Specie, string Thickness, string Grade, string Len,
			string Color, string Sort, string Milling, string NoPrint, int NbrAttach, int Mngd, int Track, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@CatDataID", ID);
			SqlParameter p2 = new SqlParameter("@Region", Region);
			//SqlParameter p3 = new SqlParameter("@RegionID", RegID);
			SqlParameter p3 = new SqlParameter("@Product", Product);
			SqlParameter p4 = new SqlParameter("@ProdID", ProdID);
			SqlParameter p5 = new SqlParameter("@ProdDesc", Desc);
			SqlParameter p6 = new SqlParameter("@Price", Price);
			SqlParameter p7 = new SqlParameter("@Comments", Comments);
			SqlParameter p8 = new SqlParameter("@Specie", Specie);
			SqlParameter p9 = new SqlParameter("@Thickness", Thickness);
			SqlParameter p10 = new SqlParameter("@Grade", Grade);
			SqlParameter p11 = new SqlParameter("@Length", Len);
			SqlParameter p12 = new SqlParameter("@Color", Color);
			SqlParameter p13 = new SqlParameter("@Sort", Sort);
			SqlParameter p14 = new SqlParameter("@Milling", Milling);
			SqlParameter p15 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p16 = new SqlParameter("@NbrAttach", NbrAttach);
			SqlParameter p17 = new SqlParameter("@Managed", Mngd);
			SqlParameter p18 = new SqlParameter("@Tracked", Track);
			SqlParameter p19 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateCatProduct", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19 });
		}

		public DataTable UpdateCatUserTracks(int PgID, int ObjID, string Reg, string Loc, string Species, string Thick, string Grade, string Len, string Color, string fSort, string Milling, string NoPrint, string Prod, string Desc, 
			int ShowWks, int HideComments, int Excl0s, int FontSize, string Status, string CustCode, string VendorCode, string SupCode, string ItemCode, string ItemName, int Sort, int PgNbr, int PgSize, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@UserID", ByID);
			SqlParameter p2 = new SqlParameter("@PgID", PgID);
			SqlParameter p3 = new SqlParameter("@ObjID", ObjID);
			SqlParameter p4 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p5 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p6 = new SqlParameter("@StatusCode", Status);
			SqlParameter p7 = new SqlParameter("@Product", Prod);
			SqlParameter p8 = new SqlParameter("@Reg", Reg);
			SqlParameter p9 = new SqlParameter("@Location", Loc);
			SqlParameter p10 = new SqlParameter("@Species", Species);
			SqlParameter p11 = new SqlParameter("@Thickness", Thick);
			SqlParameter p12 = new SqlParameter("@Grade", Grade);
			SqlParameter p13 = new SqlParameter("@Len", Len);
			SqlParameter p14 = new SqlParameter("@Color", Color);
			SqlParameter p15 = new SqlParameter("@fSort", fSort);
			SqlParameter p16 = new SqlParameter("@Milling", Milling);
			SqlParameter p17 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p18 = new SqlParameter("@CustCode", CustCode);
			SqlParameter p19 = new SqlParameter("@VendorCode", VendorCode);
			SqlParameter p20 = new SqlParameter("@SupplierCode", SupCode);
			SqlParameter p21 = new SqlParameter("@ShowWks", ShowWks);
			SqlParameter p22 = new SqlParameter("@HideComments", HideComments);
			SqlParameter p23 = new SqlParameter("@Excl0s", Excl0s);
			SqlParameter p24 = new SqlParameter("@Sort", Sort);
			SqlParameter p25 = new SqlParameter("@FontSz", FontSize);
			SqlParameter p26 = new SqlParameter("@ItemCode", ItemCode);
			SqlParameter p27 = new SqlParameter("@ItemName", ItemName);
			SqlParameter p28 = new SqlParameter("@ItemDesc", Desc);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateCatUserTracks", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28 });
		}

		// depreciated
		public DataTable UpdateSalesProductTrackItem(int id, int Type, string Region, string Prod, string ProdDesc, double Price, string Specie, string Thickness, string Grade, string Len, string Color, string Sort, 
			string Milling, string NoPrint, string ProdType, string ExpPrgID, int Tracked, int Mngd, string Comments, int ByID)
    {
      DBInterface di = new DBInterface();
      SqlParameter p1 = new SqlParameter("@ProdMngdID", id);
			SqlParameter p2 = new SqlParameter("@ProdType", ProdType);
			SqlParameter p3 = new SqlParameter("@ProdCode", Prod);
			SqlParameter p4 = new SqlParameter("@ProdDesc", ProdDesc);
      SqlParameter p5 = new SqlParameter("@Price", Price);
			SqlParameter p6 = new SqlParameter("@Region", Region);
			SqlParameter p7 = new SqlParameter("@Specie", Specie);
      SqlParameter p8 = new SqlParameter("@Thickness", Thickness);
      SqlParameter p9 = new SqlParameter("@Grade", Grade);
			SqlParameter p10 = new SqlParameter("@Len", Len);
			SqlParameter p11 = new SqlParameter("@Color", Color);
			SqlParameter p12 = new SqlParameter("@Sort", Sort);
			SqlParameter p13 = new SqlParameter("@Milling", Milling);
			SqlParameter p14 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p15 = new SqlParameter("@ExpPrgID", ExpPrgID);
			SqlParameter p16 = new SqlParameter("@Comments", Comments);
			SqlParameter p17 = new SqlParameter("@Track", Tracked);
			SqlParameter p18 = new SqlParameter("@Managed", Mngd);
			SqlParameter p19 = new SqlParameter("@Type", Type);
      SqlParameter p20 = new SqlParameter("@ByID", ByID);
      return di.RunSPReturnDataTableNWB("web.usp_UpdateSalesProductTrackingItem", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20 });
    }

		public DataTable UpdateUserCodeList(int LinkID, int UserID, string CodeType, int ID, int Show, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@LinkID", UserID);
			SqlParameter p2 = new SqlParameter("@UserID", UserID);
			SqlParameter p3 = new SqlParameter("@CodeType", CodeType);
			SqlParameter p4 = new SqlParameter("@ID", ID);
			SqlParameter p5 = new SqlParameter("@Show", Show);
			SqlParameter p6 = new SqlParameter("@Active", Active);
			SqlParameter p7 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateCatCodeDisplay", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7 });
		}

	}
}
