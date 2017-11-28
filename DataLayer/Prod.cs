using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace DataLayer
{
	public class ProductionFnc
	{
		public DataTable SelectInventoryItemData(string ProdType, string ProdCode, string Loc, string A1, string A2, string A3, string A4, string A5, string A6, string A7, string A8, string A9, string A10, string A11, string A12, string A13, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ProdType", ProdType);
			SqlParameter p2 = new SqlParameter("@ProdCode", ProdCode);
			SqlParameter p3 = new SqlParameter("@Loc", Loc);
			SqlParameter p4 = new SqlParameter("@Attrib1", A1);
			SqlParameter p5 = new SqlParameter("@Attrib2", A2);
			SqlParameter p6 = new SqlParameter("@Attrib3", A3);
			SqlParameter p7 = new SqlParameter("@Attrib4", A4);
			SqlParameter p8 = new SqlParameter("@Attrib5", A5);
			SqlParameter p9 = new SqlParameter("@Attrib6", A6);
			SqlParameter p10 = new SqlParameter("@Attrib7", A7);
			SqlParameter p11 = new SqlParameter("@Attrib8", A8);
			SqlParameter p12 = new SqlParameter("@Attrib9", A9);
			SqlParameter p13 = new SqlParameter("@Attrib10", A10);
			SqlParameter p14 = new SqlParameter("@Attrib11", A11);
			SqlParameter p15 = new SqlParameter("@Attrib12", A12);
			SqlParameter p16 = new SqlParameter("@Attrib13", A13);
			SqlParameter p17 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_GetInventoryData", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17 });
		}

		public DataTable SelectDateRangeForMillCmt(string sDt, int ByID)
		{
			DateTime? dte = null;
			if (sDt.Length > 0)
			{
				dte = Convert.ToDateTime(sDt);
			}
			else
			{
				dte = DateTime.Now;
			}
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Date", dte);
			SqlParameter p2 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectMillCommentsDateRange", new SqlParameter[] { p1, p2 });
		}

		public DataTable SelectDateRangeForMillCmtList(string sDt, int NbrInList, int ByID)
		{
			DateTime? dte = null;
			if (sDt.Length > 0)
			{
				dte = Convert.ToDateTime(sDt);
			}
			else
			{
				dte = DateTime.Now;
			}
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Date", dte);
			SqlParameter p2 = new SqlParameter("@NbrInList", NbrInList);
			SqlParameter p3 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectMillCommentsDateRangeList", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable SelectInventoryDataDetailed(string Reg, string LocCode, string LocType, string PCode, string PType, string Thick, string Specie, string Grade, string Season, string Surf, 
			string Wdth, string Len, string Color, string fSort, string Milling, string NoPrint, string FuzzyGrade, string FuzzySort, string FuzzyProd, string Lvl, int Sort, int Active, int PgNbr, int PgSize, int ByID)
		{
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
			SqlParameter p20 = new SqlParameter("@Level", Lvl);
			SqlParameter p21 = new SqlParameter("@Sort", Sort);
			SqlParameter p22 = new SqlParameter("@Active", Active);
			SqlParameter p23 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p24 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p25 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectInventoryDetailed", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25 });
		}

		public DataTable SelectLTProdCodeList (string Prefix, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Prefix", Prefix);
			SqlParameter p2 = new SqlParameter("@Sort", Sort);
			SqlParameter p3 = new SqlParameter("@Active", Active);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectLTPRODCodeData", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable SelectWurthProductCodeList(string PType, int Sort, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ProdType", PType);
			SqlParameter p2 = new SqlParameter("@Sort", Sort);
			SqlParameter p3 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectWurthDataProdCodeList", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable SelectWurthProdConversionData(int ID, string PType, string ProdCode, string Thick, string Specie, string Grade, string Width, string Color, string fSort, string Milling, int Sort, int Active, int PgNbr, int PgSize, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@ProdType", PType);
			SqlParameter p3 = new SqlParameter("@ProdCode", ProdCode);
			SqlParameter p4 = new SqlParameter("@Thick", Thick);
			SqlParameter p5 = new SqlParameter("@Specie", Specie);
			SqlParameter p6 = new SqlParameter("@Grade", Grade);
			SqlParameter p7 = new SqlParameter("@Width", Width);
			SqlParameter p8 = new SqlParameter("@Color", Color);
			SqlParameter p9 = new SqlParameter("@fSort", fSort);
			SqlParameter p10 = new SqlParameter("@Milling", Milling);
			SqlParameter p11 = new SqlParameter("@Sort", Sort);
			SqlParameter p12 = new SqlParameter("@Active", Active);
			SqlParameter p13 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p14 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p15 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectWurthData", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15 });
		}

		public DataTable UpdateWurthConversionData(int ID, string Xrefnbr, string Cust, string CustNbr, string CustDesc, string WurthCode, string PType, string ProdCode, string Desc, string Width, string Len, string Color, 
			string ExpPrgID, string Cert, string Sort, string Tolerance, string HPPcsPkg, string Milling, string NoPrint, string Resp, string Cmt, int iType, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@ProductXRefs", Xrefnbr);
			SqlParameter p3 = new SqlParameter("@Cust", Cust);
			SqlParameter p4 = new SqlParameter("@CustNbr", CustNbr);
			SqlParameter p5 = new SqlParameter("@CustDescription", CustDesc);
			SqlParameter p6 = new SqlParameter("@WurthCode", WurthCode);
			SqlParameter p7 = new SqlParameter("@ProdType", PType);
			SqlParameter p8 = new SqlParameter("@ProdCode", ProdCode);
			SqlParameter p9 = new SqlParameter("@Desc", Desc);
			SqlParameter p10 = new SqlParameter("@Wdth", Width);
			SqlParameter p11 = new SqlParameter("@Len", Len);
			SqlParameter p12 = new SqlParameter("@Color", Color);
			SqlParameter p13 = new SqlParameter("@ExpPrgID", ExpPrgID);
			SqlParameter p14 = new SqlParameter("@Cert", Cert);
			SqlParameter p15 = new SqlParameter("@Sort", Sort);
			SqlParameter p16 = new SqlParameter("@Tolerance", Tolerance);
			SqlParameter p17 = new SqlParameter("@HPPcsPkg", HPPcsPkg);
			SqlParameter p18 = new SqlParameter("@Milling", Milling);
			SqlParameter p19 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p20 = new SqlParameter("@Resp", Resp);
			SqlParameter p21 = new SqlParameter("@Comments", Cmt);
			SqlParameter p22 = new SqlParameter("@Type", iType);
			SqlParameter p23 = new SqlParameter("@Active", Active);
			SqlParameter p24 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateWurthData", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24 });
		}

	}
}
