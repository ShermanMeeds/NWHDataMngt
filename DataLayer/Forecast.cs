using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace DataLayer
{
	public class Forecast
	{
		public DataTable CloneLocationData(string SLoc, string TLoc, int IncProd, int IncMix, int IncMContents, int IncSetting, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@SrcLocCode", SLoc);
			SqlParameter p2 = new SqlParameter("@TgtLocCode", TLoc);
			SqlParameter p3 = new SqlParameter("@IncProducts", IncProd);
			SqlParameter p4 = new SqlParameter("@IncMixes", IncMix);
			SqlParameter p5 = new SqlParameter("@IncMixContents", IncMContents);
			SqlParameter p6 = new SqlParameter("@IncSettings", IncSetting);
			SqlParameter p7 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_CloneLocationData", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7 });
		}

		public DataTable CopyMixProduct(string LocCode, int SourceMixID, int TargetMixID, int ProdID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@LocCode", LocCode);
			SqlParameter p2 = new SqlParameter("@SourceMixID", SourceMixID);
			SqlParameter p3 = new SqlParameter("@TargetMixID", TargetMixID);
			SqlParameter p4 = new SqlParameter("@ProdID", ProdID);
			SqlParameter p5 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_CopyMixProductItem", new SqlParameter[] { p1, p2, p3, p4, p5 });
		}

		public DataTable CopyProductData(string Loc, int LinkID, int PmID, string Len, string Color, string Sort, string Milling, string NoPrint, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@LocCode", Loc);
			SqlParameter p2 = new SqlParameter("@LinkID", LinkID);
			SqlParameter p3 = new SqlParameter("@PMID", PmID);
			SqlParameter p4 = new SqlParameter("@Len", Len);
			SqlParameter p5 = new SqlParameter("@Color", Color);
			SqlParameter p6 = new SqlParameter("@Sort", Sort);
			SqlParameter p7 = new SqlParameter("@Milling", Milling);
			SqlParameter p8 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p9 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_CopyProductData", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9 });
		}

		public DataTable DeleteForecastCode(string LocCode, int ID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@LocCode", LocCode);
			SqlParameter p2 = new SqlParameter("@ID", ID);
			SqlParameter p3 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_DeleteForecastCode", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable DeleteForecastLocation(string LocCode, int UserID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@LocCode", LocCode);
			SqlParameter p2 = new SqlParameter("@UserID", UserID);
			SqlParameter p3 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_DeleteForecastLocation", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable DeleteForecastMix(string LocCode, int Mix, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@LocCode", LocCode);
			SqlParameter p2 = new SqlParameter("@MixID", Mix);
			SqlParameter p3 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_DeleteForecastMix", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable DeleteForecastMix2(int ID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_DeleteForecastMix2", new SqlParameter[] { p1, p2 });
		}

		public DataTable DeleteForecastProduct(string LocCode, int ID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@LocCode", LocCode);
			SqlParameter p2 = new SqlParameter("@ID", ID);
			SqlParameter p3 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_DeleteForecastProduct", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable DeleteForecastMixProduct(int ID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_DeleteForecastMixProduct", new SqlParameter[] { p1, p2 });
		}

		public DataTable SelectForecast(string LocCode, string MixIDs, string MixSpecies, string SpeciesF, string Thickness, string Grade, string Color, string Sort, string NoPrint, string Desc, int iType, int Shift, DateTime TDate, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@LocCode", LocCode);
			SqlParameter p2 = new SqlParameter("@MixIDs", MixIDs);
			SqlParameter p3 = new SqlParameter("@MixSpecies", MixSpecies);
			SqlParameter p4 = new SqlParameter("@Species", SpeciesF);
			SqlParameter p5 = new SqlParameter("@Thickness", Thickness);
			SqlParameter p6 = new SqlParameter("@Grade", Grade);
			SqlParameter p7 = new SqlParameter("@Color", Color);
			SqlParameter p8 = new SqlParameter("@fSort", Sort);
			SqlParameter p9 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p10 = new SqlParameter("@Desc", Desc);
			SqlParameter p11 = new SqlParameter("@TargetDate", TDate);
			SqlParameter p12 = new SqlParameter("@Type", iType);
			SqlParameter p13 = new SqlParameter("@Shift", Shift);
			SqlParameter p14 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectForecast", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14 });
		}

		public DataTable SelectForecastCalendar(string LocCode, string MixIDs, string ProdCode, string Desc, string Species, string Thick, string Grade, string Color, string FSort, string Milling, string NoPrint, string Len, int Shift, string sType,
			DateTime? TDate, DateTime? BDate, DateTime? EDate, int Sort, int Act, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@LocCode", LocCode);
			SqlParameter p2 = new SqlParameter("@MixIDs", MixIDs);
			SqlParameter p3 = new SqlParameter("@ProdCode", ProdCode);
			SqlParameter p4 = new SqlParameter("@Desc", Desc);
			SqlParameter p5 = new SqlParameter("@Species", Species);
			SqlParameter p6 = new SqlParameter("@Thick", Thick);
			SqlParameter p7 = new SqlParameter("@Grade", Grade);
			SqlParameter p8 = new SqlParameter("@Color", Color);
			SqlParameter p9 = new SqlParameter("@fSort", FSort);
			SqlParameter p10 = new SqlParameter("@Milling", Milling);
			SqlParameter p11 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p12 = new SqlParameter("@Len", Len);
			SqlParameter p13 = new SqlParameter("@Shift", Shift);
			SqlParameter p14 = new SqlParameter("@Type", sType);
			SqlParameter p15 = new SqlParameter("@TargetDate", TDate);
			SqlParameter p16 = new SqlParameter("@BeginDate", BDate);
			SqlParameter p17 = new SqlParameter("@EndDate", EDate);
			SqlParameter p18 = new SqlParameter("@Sort", Sort);
			SqlParameter p19 = new SqlParameter("@Active", Act);
			SqlParameter p20 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectForecastCalendar", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20 });
		}

		public DataTable SelectForecastCodeList(string Loc, string Region, string CodeType, int Sort, int Active, int NoBlank, int Shown, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@LocCode", Loc);
			SqlParameter p2 = new SqlParameter("@Region", Region);
			SqlParameter p3 = new SqlParameter("@CodeType", CodeType);
			SqlParameter p4 = new SqlParameter("@Sort", Sort);
			SqlParameter p5 = new SqlParameter("@Active", Active);
			SqlParameter p6 = new SqlParameter("@NoBlank", NoBlank);
			SqlParameter p7 = new SqlParameter("@Shown", Shown);
			SqlParameter p8 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectForecastCodeList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8 });
		}

		public DataTable SelectForecastMixProducts(string Loc, int MixID, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@LocCode", Loc);
			SqlParameter p2 = new SqlParameter("@MixID", MixID);
			SqlParameter p3 = new SqlParameter("@Sort", Sort);
			SqlParameter p4 = new SqlParameter("@Active", Active);
			SqlParameter p5 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectForecastMixProductList", new SqlParameter[] { p1, p2, p3, p4, p5 });
		}

		public DataTable SelectForecastMixList(string Loc, int MixID, string Species, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@LocCode", Loc);
			SqlParameter p2 = new SqlParameter("@MixID", MixID);
			SqlParameter p3 = new SqlParameter("@SpeciesCode", Species);
			SqlParameter p4 = new SqlParameter("@Sort", Sort);
			SqlParameter p5 = new SqlParameter("@Active", Active);
			SqlParameter p6 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectForecastMixList", new SqlParameter[] { p1, p2, p3, p4, p5, p6 });
		}

		public DataTable SelectForecastProductData(int ID, string ProdCode, string Len, string Color, string Sort, string Milling, string NoPrint, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@PMID", ID);
			SqlParameter p2 = new SqlParameter("@ProdCode", ProdCode);
			SqlParameter p3 = new SqlParameter("@Len", Len);
			SqlParameter p4 = new SqlParameter("@Color", Color);
			SqlParameter p5 = new SqlParameter("@Sort", Sort);
			SqlParameter p6 = new SqlParameter("@Milling", Milling);
			SqlParameter p7 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p8 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectForecastProductData", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8 });
		}

		public DataTable SelectForecastProductList(string Loc, string Region, string ProdCode, int MixID, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Region", Region);
			SqlParameter p2 = new SqlParameter("@LocCode", Loc);
			SqlParameter p3 = new SqlParameter("@ProdCode", ProdCode);
			SqlParameter p4 = new SqlParameter("@MixID", MixID);
			SqlParameter p5 = new SqlParameter("@Sort", Sort);
			SqlParameter p6 = new SqlParameter("@Active", Active);
			SqlParameter p7 = new SqlParameter("@Mini", 0);
			SqlParameter p8 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectForecastProductList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8 });
		}

		public DataTable SelectForecastProductListMini(string Loc, string Region, string ProdCode, int MixID, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Region", Region);
			SqlParameter p2 = new SqlParameter("@LocCode", Loc);
			SqlParameter p3 = new SqlParameter("@ProdCode", ProdCode);
			SqlParameter p4 = new SqlParameter("@MixID", MixID);
			SqlParameter p5 = new SqlParameter("@Sort", Sort);
			SqlParameter p6 = new SqlParameter("@Active", Active);
			SqlParameter p7 = new SqlParameter("@Mini", 1);
			SqlParameter p8 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectForecastProductList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8 });
		}

		public DataTable SelectForecastProductView(string LocCode, string MixIDs, string ProdCode, string Region, string Species, string Thickness, string Grade, string Len, string Color, string Sort, string Milling, string NoPrint,
			int Shift, int iType, DateTime TDate, int NoEmpties, int PgNbr, int PgSize, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@DataType", iType);
			SqlParameter p2 = new SqlParameter("@LocCode", LocCode);
			SqlParameter p3 = new SqlParameter("@MixIDs", MixIDs);
			SqlParameter p4 = new SqlParameter("@ProdCode", ProdCode);
			SqlParameter p5 = new SqlParameter("@Region", Region);
			SqlParameter p6 = new SqlParameter("@Species", Species);
			SqlParameter p7 = new SqlParameter("@Grade", Grade);
			SqlParameter p8 = new SqlParameter("@Thickness", Thickness);
			SqlParameter p9 = new SqlParameter("@Len", Len);
			SqlParameter p10 = new SqlParameter("@Color", Color);
			SqlParameter p11 = new SqlParameter("@Sort", Sort);
			SqlParameter p12 = new SqlParameter("@Milling", Milling);
			SqlParameter p13 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p14 = new SqlParameter("@Shift", Shift);
			SqlParameter p15 = new SqlParameter("@TargetDate", TDate);
			SqlParameter p16 = new SqlParameter("@NoEmptyProds", NoEmpties);
			SqlParameter p17 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p18 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p19 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectForecastProductView", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19 });
		}

		public DataTable SelectForecastProductViewHistory(string LocCode, string MixIDs, string ProdCode, string Region, string Species, string Thickness, string Grade, string Len, string Color, string Sort, string Milling, string NoPrint,
			int Shift, int iType, DateTime TDate, int NoEmpties, int PgNbr, int PgSize, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@DataType", iType);
			SqlParameter p2 = new SqlParameter("@LocCode", LocCode);
			SqlParameter p3 = new SqlParameter("@MixIDs", MixIDs);
			SqlParameter p4 = new SqlParameter("@ProdCode", ProdCode);
			SqlParameter p5 = new SqlParameter("@Region", Region);
			SqlParameter p6 = new SqlParameter("@Species", Species);
			SqlParameter p7 = new SqlParameter("@Grade", Grade);
			SqlParameter p8 = new SqlParameter("@Thickness", Thickness);
			SqlParameter p9 = new SqlParameter("@Len", Len);
			SqlParameter p10 = new SqlParameter("@Color", Color);
			SqlParameter p11 = new SqlParameter("@Sort", Sort);
			SqlParameter p12 = new SqlParameter("@Milling", Milling);
			SqlParameter p13 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p14 = new SqlParameter("@Shift", Shift);
			SqlParameter p15 = new SqlParameter("@TargetDate", TDate);
			SqlParameter p16 = new SqlParameter("@NoEmptyProds", NoEmpties);
			SqlParameter p17 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p18 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p19 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectForecastProductViewHist", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19 });
		}

		public DataTable SelectForecastRegionCodeList(string Loc, string Region, string CodeType, int Sort, int Active, int NoBlank, int Shown, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@LocCode", Loc);
			SqlParameter p2 = new SqlParameter("@Region", Region);
			SqlParameter p3 = new SqlParameter("@CodeType", CodeType);
			SqlParameter p4 = new SqlParameter("@Sort", Sort);
			SqlParameter p5 = new SqlParameter("@Active", Active);
			SqlParameter p6 = new SqlParameter("@NoBlank", NoBlank);
			SqlParameter p7 = new SqlParameter("@Shown", Shown);
			SqlParameter p8 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectForecastRegionCodeList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8 });
		}

		public DataTable SelectProductManagedData(string Loc, string ProdType, string ProdCode, string Len, string Color, string Sort, string Milling, string NoPrint, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@LocCode", Loc);
			SqlParameter p2 = new SqlParameter("@ProdType", ProdType);
			SqlParameter p3 = new SqlParameter("@ProdCode", ProdCode);
			SqlParameter p4 = new SqlParameter("@Len", Len);
			SqlParameter p5 = new SqlParameter("@Color", Color);
			SqlParameter p6 = new SqlParameter("@Sort", Sort);
			SqlParameter p7 = new SqlParameter("@Milling", Milling);
			SqlParameter p8 = new SqlParameter("@NoPrint", NoPrint);
			SqlParameter p9 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectProductManagedData", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9 });
		}

		public DataTable SelectUserForecastLocList(int iType, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@UserID", ByID);
			SqlParameter p2 = new SqlParameter("@UnselectedOnly", iType);
			SqlParameter p3 = new SqlParameter("@GrpCode", "forecastedit");
			return di.RunSPReturnDataTableNWDW("web.usp_SelectUserForecastLocationList", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable SelectUserForecastLocList2(int iType, string Grp, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@UserID", ByID);
			SqlParameter p2 = new SqlParameter("@UnselectedOnly", iType);
			SqlParameter p3 = new SqlParameter("@GrpCode", Grp);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectUserForecastLocationList", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable SelectUserForecastLocationList(string Region, string LocCode, string LocType, string Country, string City, int iClass, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@UserID", ByID);
			SqlParameter p2 = new SqlParameter("@Region", Region);
			SqlParameter p3 = new SqlParameter("@LocCode", LocCode);
			SqlParameter p4 = new SqlParameter("@LocType", LocType);
			SqlParameter p5 = new SqlParameter("@Country", Country);
			SqlParameter p6 = new SqlParameter("@City", City);
			SqlParameter p7 = new SqlParameter("@Class", iClass);
			SqlParameter p8 = new SqlParameter("@Sort", Sort);
			SqlParameter p9 = new SqlParameter("@Active", Active);
			SqlParameter p10 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_SelectForecastLocationList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10 });
		}

		public DataTable UpdateForecastAmount(int ID, string LocCode, int iType, int MixID, int Wk, int Dy, int Shift, double Qty, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@LocCode", LocCode);
			SqlParameter p3 = new SqlParameter("@Type", iType);
			SqlParameter p4 = new SqlParameter("@MixID", MixID);
			SqlParameter p5 = new SqlParameter("@WkNbr", Wk);
			SqlParameter p6 = new SqlParameter("@DayNbr", Dy);
			SqlParameter p7 = new SqlParameter("@Shift", Shift);
			SqlParameter p8 = new SqlParameter("@Qty", Qty);
			SqlParameter p9 = new SqlParameter("@Active", Active);
			SqlParameter p10 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateForecastAmount", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10 });
		}

		public DataTable UpdateForecastByMixItem(int ID, string Loc, string Nm, DateTime PDate, int Shift, Double Qty, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@LocCode", Loc);
			SqlParameter p3 = new SqlParameter("@Name", Nm);
			SqlParameter p4 = new SqlParameter("@ProdDate", PDate);
			SqlParameter p5 = new SqlParameter("@Shift", Shift);
			SqlParameter p6 = new SqlParameter("@Qty", Qty);
			SqlParameter p7 = new SqlParameter("@Active", Active);
			SqlParameter p8 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateForecastByMix", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8 });
		}

		public DataTable UpdateForecastCode(int ID, string Loc, string Code, string Desc, int CodeType, string Value, int ShowOrder, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@LocCode", Loc);
			SqlParameter p3 = new SqlParameter("@Code", Code);
			SqlParameter p4 = new SqlParameter("@Desc", Desc);
			SqlParameter p5 = new SqlParameter("@CodeType", CodeType);
			SqlParameter p6 = new SqlParameter("@Value", Value);
			SqlParameter p7 = new SqlParameter("@ShowOrder", ShowOrder);
			SqlParameter p8 = new SqlParameter("@Active", Active);
			SqlParameter p9 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateForecastCode", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9 });
		}

		public DataTable UpdateForecastCell(int ID, string Loc, int iType, int MixID, DateTime PDate, int Wk, int Dy, int Shift, double Qty, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@LocCode", Loc);
			SqlParameter p3 = new SqlParameter("@MixID", MixID);
			SqlParameter p4 = new SqlParameter("@Type", iType);
			SqlParameter p5 = new SqlParameter("@ProdDate", PDate);
			SqlParameter p6 = new SqlParameter("@WkNbr", Wk);
			SqlParameter p7 = new SqlParameter("@DayNbr", Dy);
			SqlParameter p8 = new SqlParameter("@Shift", Shift);
			SqlParameter p9 = new SqlParameter("@Qty", Qty);
			SqlParameter p10 = new SqlParameter("@Active", Active);
			SqlParameter p11 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateForecastAmount2", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11 });
		}

		public DataTable UpdateForecastLocation(string Loc, int UserID, string Grp, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@AppCode", "DataMngt");
			SqlParameter p2 = new SqlParameter("@UserID", UserID);
			SqlParameter p3 = new SqlParameter("@LocCode", Loc);
			SqlParameter p4 = new SqlParameter("@GrpCode", Grp);
			SqlParameter p5 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateUserForecastLocation", new SqlParameter[] { p1, p2, p3, p4, p5 });
		}

		public DataTable UpdateForecastMixItem(int ID, string Loc, string Name, string Species, string Thick, string Grade, string Len, string Content, string Comment, int act, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@LocCode", Loc);
			SqlParameter p3 = new SqlParameter("@MixName", Name);
			SqlParameter p4 = new SqlParameter("@SpeciesCode", Species);
			SqlParameter p5 = new SqlParameter("@ThickCode", Thick);
			SqlParameter p6 = new SqlParameter("@GradeCode", Grade);
			SqlParameter p7 = new SqlParameter("@Length", Len);
			SqlParameter p8 = new SqlParameter("@Content", Content);
			SqlParameter p9 = new SqlParameter("@Comment", Comment);
			SqlParameter p10 = new SqlParameter("@Active", act);
			SqlParameter p11 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateForecastMixItem", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11 });
		}

		public DataTable UpdateForecastMixList(int ID, string Loc, int MixID, string MixName, string Contents, string Comments, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@LocCode", Loc);
			SqlParameter p3 = new SqlParameter("@MixID", MixID);
			SqlParameter p4 = new SqlParameter("@MixName", MixName);
			SqlParameter p5 = new SqlParameter("@MixContents", Contents);
			SqlParameter p6 = new SqlParameter("@Comments", Comments);
			SqlParameter p7 = new SqlParameter("@Active", Active);
			SqlParameter p8 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateForecastMixList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8 });
		}

		public DataTable UpdateForecastMixListItem(int ID, int iType, string Value, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@iType", iType);
			SqlParameter p3 = new SqlParameter("@Value", Value);
			SqlParameter p4 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateForecastMixItemData", new SqlParameter[] { p1, p2, p3, p4 });
		}

		public DataTable UpdateForecastMixProduct(int ID, string LocCode, int MixID, int PMID, string Len, int iType, double Pct, int Active, int ByID)
		{ 
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ID", ID);
			SqlParameter p2 = new SqlParameter("@LocCode", LocCode);
			SqlParameter p3 = new SqlParameter("@MixID", MixID);
			SqlParameter p4 = new SqlParameter("@ProdMngdID", PMID);
			SqlParameter p5 = new SqlParameter("@Len", Len);
			SqlParameter p6 = new SqlParameter("@Action", iType);
			SqlParameter p7 = new SqlParameter("@YieldPct", Pct);
			SqlParameter p8 = new SqlParameter("@Active", Active);
			SqlParameter p9 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateForecastMixProduct", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9 });
		}

		public DataTable UpdateForecastProductItem(int ID, string LocCode, int iType, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@PMID", ID);
			SqlParameter p2 = new SqlParameter("@LocCode", LocCode);
			SqlParameter p3 = new SqlParameter("@Type", iType);
			SqlParameter p4 = new SqlParameter("@Active", Active);
			SqlParameter p5 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateForecastProductItem", new SqlParameter[] { p1, p2, p3, p4, p5 });
		}

		public DataTable UpdateForecastCodeShown(int ID, int Chk, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@CodeID", ID);
			SqlParameter p2 = new SqlParameter("@IsChecked", Chk);
			SqlParameter p3 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateForecastCodeShown", new SqlParameter[] { p1, p2, p3 });
		}

	}
}
