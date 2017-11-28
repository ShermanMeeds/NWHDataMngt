using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace DataLayer
{
  public class EntityLib
  {
    public DataTable DeleteEntityByID(int EntID, int ByID)
    {
      DBInterface di = new DBInterface();
      SqlParameter p1 = new SqlParameter("@EntityID", EntID);
      SqlParameter p2 = new SqlParameter("@ByID", ByID);
      return di.RunSPReturnDataTableNWDW("web.usp_DeleteEntityByID", new SqlParameter[] { p1, p2 });
    }

		public DataTable EntityListSearch(string Name, string Cd, int Type, string status, string Addr, string City, string StCode, string Cntry, string PostalCd, string Email, string GeoArea,
			string FEINTaxNbr, string ID, string Phone, int PgNbr, int PgSize, int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Name", Name);
			SqlParameter p2 = new SqlParameter("@Code", Cd);
			SqlParameter p3 = new SqlParameter("@Type", Type);
			SqlParameter p4 = new SqlParameter("@Status", status);
			SqlParameter p5 = new SqlParameter("@Address", Addr);
			SqlParameter p6 = new SqlParameter("@City", City);
			SqlParameter p7 = new SqlParameter("@StateCode", StCode);
			SqlParameter p8 = new SqlParameter("@Country", Cntry);
			SqlParameter p9 = new SqlParameter("@PostalCode", PostalCd);
			SqlParameter p10 = new SqlParameter("@Email", Email);
			SqlParameter p11 = new SqlParameter("@GeoArea", GeoArea);
			SqlParameter p12 = new SqlParameter("@FEINTaxNbr", FEINTaxNbr);
			SqlParameter p13 = new SqlParameter("@ID", ID);
			SqlParameter p14 = new SqlParameter("@Phone", Phone);
			SqlParameter p15 = new SqlParameter("@PgNbr", PgNbr);
			SqlParameter p16 = new SqlParameter("@PgSize", PgSize);
			SqlParameter p17 = new SqlParameter("@Sort", Sort);
			SqlParameter p18 = new SqlParameter("@Soundex", 1);
			SqlParameter p19 = new SqlParameter("@Active", Active);
			SqlParameter p20 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectEntityListFull", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20 });
		}

		public DataTable SelectCurrencyTypeList(int Sort, int Active, int ByID)
		{
        DBInterface di = new DBInterface();
				SqlParameter p1 = new SqlParameter("@Sort", Sort);
				SqlParameter p2 = new SqlParameter("@Active", Active);
				SqlParameter p3 = new SqlParameter("@ByID", ByID);
        return di.RunSPReturnDataTableNWDW("web.usp_SelectCurrencyTypeList", new SqlParameter[] { p1, p2, p3 });
		}


		public DataTable SelectEntityData(int EntID, int ByID)
    {
        DBInterface di = new DBInterface();
        SqlParameter p1 = new SqlParameter("@EntityID", EntID);
        SqlParameter p2 = new SqlParameter("@ByID", ByID);
        return di.RunSPReturnDataTableNWDW("web.usp_SelectEntityData", new SqlParameter[] { p1, p2 });
    }

    public DataTable SelectEntityList(string Name, string Cd, int Type, string status, string Addr, string City, string StCode, string Cntry, string PostalCd, string Email, string GeoArea,
      string FEINTaxNbr, string ID, string Phone, int PgNbr, int PgSize, int Sort, int Active, int ByID)
    {
      DBInterface di = new DBInterface();
      SqlParameter p1 = new SqlParameter("@Name", Name);
      SqlParameter p2 = new SqlParameter("@Code", Cd);
      SqlParameter p3 = new SqlParameter("@Type", Type);
      SqlParameter p4 = new SqlParameter("@Status", status);
      SqlParameter p5 = new SqlParameter("@Address", Addr);
      SqlParameter p6 = new SqlParameter("@City", City);
      SqlParameter p7 = new SqlParameter("@StateCode", StCode);
      SqlParameter p8 = new SqlParameter("@Country", Cntry);
      SqlParameter p9 = new SqlParameter("@PostalCode", PostalCd);
      SqlParameter p10 = new SqlParameter("@Email", Email);
      SqlParameter p11 = new SqlParameter("@GeoArea", GeoArea);
      SqlParameter p12 = new SqlParameter("@FEINTaxNbr", FEINTaxNbr);
      SqlParameter p13 = new SqlParameter("@ID", ID);
      SqlParameter p14 = new SqlParameter("@Phone", Phone);
      SqlParameter p15 = new SqlParameter("@PgNbr", PgNbr);
      SqlParameter p16 = new SqlParameter("@PgSize", PgSize);
      SqlParameter p17 = new SqlParameter("@Sort", Sort);
      SqlParameter p18 = new SqlParameter("@Soundex", 0);
      SqlParameter p19 = new SqlParameter("@Active", Active);
      SqlParameter p20 = new SqlParameter("@ByID", ByID);
      return di.RunSPReturnDataTableNWDW("web.usp_SelectEntityListFull", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20 });
    }

		public DataTable SelectVendorTypeList(int Sort, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Sort", Sort);
			SqlParameter p2 = new SqlParameter("@Active", Active);
			SqlParameter p3 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWDW("web.usp_SelectVendorTypeList", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable UpdateEntityData(int EntID, string TypeCode, string FullName, string LName, string FName, string MName, string Suff, string Pref, string stat, string cd, string desc,
			int IsEmp, int IsCust, int IsSupp, int IsVend, int IsComp, int IsExt, int IsExp, int IsSource, int IsDest, int IsMill, int IsYard, string GeoArea, string sBDate, string sEDate, string FEINNbr,
			string Addr1, string City, string StateCd, string CountryCd, string PCode, string VendID, string CustID, string SuppID, int EmpID, string LTVendAttribs, string VendGroup, string VendClass, string VendTypeID, string YardType, string Phone1,
			string Cell, string Fax, string Email, string CurrencyCd, int IsLT, int IsLIMS, int IsGP, int Active, int DivID, string ModNbr, string Contact, string CEmail, string CPhone, string ADUserID, int ByID)
		{
			DateTime BDate;
			DateTime? EDate = null;
			int Type = 0;
			if (EntID> 0) { Type = 1; }
			if (sBDate.Length > 0)
			{
				BDate = Convert.ToDateTime(sBDate);
			}
			else
			{
				BDate = DateTime.Now;
			}
			if (sEDate.Length > 0) { EDate = Convert.ToDateTime(sEDate); }
			if (LName.Length > 0 && FullName.Length == 0)
			{
				FullName = LName + ", " + FName;
				if (MName.Length > 0) { FullName = FullName + " " + MName; }
				if (Suff.Length > 0) { FullName = FullName + " " + Suff; }
			}

			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@EntityID", EntID);
			SqlParameter p2 = new SqlParameter("@Type", Type);
			SqlParameter p3 = new SqlParameter("@EntityTypeCode", TypeCode);
			SqlParameter p4 = new SqlParameter("@EntityFullName", FullName);
			SqlParameter p5 = new SqlParameter("@LastName", LName);
			SqlParameter p6 = new SqlParameter("@FirstName", FName);
			SqlParameter p7 = new SqlParameter("@MiddleName", MName);
			SqlParameter p8 = new SqlParameter("@Prefix", Pref);
			SqlParameter p9 = new SqlParameter("@Suffix", Suff);
			SqlParameter p10 = new SqlParameter("@EntityStatus", stat);
			SqlParameter p11 = new SqlParameter("@EntityCode", cd);
			SqlParameter p12 = new SqlParameter("@EntityDescription", desc);
			SqlParameter p13 = new SqlParameter("@IsEmployee", IsEmp);
			SqlParameter p14 = new SqlParameter("@IsCustomer", IsCust);
			SqlParameter p15 = new SqlParameter("@IsSupplier", IsSupp);
			SqlParameter p16 = new SqlParameter("@IsVendor", IsVend);
			SqlParameter p17 = new SqlParameter("@IsCompany", IsComp);
			SqlParameter p18 = new SqlParameter("@IsExternal", IsExt);
			SqlParameter p19 = new SqlParameter("@IsExport", IsExp);
			SqlParameter p20 = new SqlParameter("@IsSource", IsSource);
			SqlParameter p21 = new SqlParameter("@IsDest", IsDest);
			SqlParameter p22 = new SqlParameter("@IsMill", IsMill);
			SqlParameter p23 = new SqlParameter("@IsYard", IsYard);
			SqlParameter p24 = new SqlParameter("@GeoArea", GeoArea);
			SqlParameter p25 = new SqlParameter("@BeginDate", BDate);
			SqlParameter p26 = new SqlParameter("@EndDate", EDate);
			SqlParameter p27 = new SqlParameter("@FEINTaxNbr", FEINNbr);
			SqlParameter p28 = new SqlParameter("@HQPhysicalAddress", Addr1);
			SqlParameter p29 = new SqlParameter("@HQCity", City);
			SqlParameter p30 = new SqlParameter("@HQStateID", StateCd);
			SqlParameter p31 = new SqlParameter("@HQCountryCode", CountryCd);
			SqlParameter p32 = new SqlParameter("@HQPostalCode", PCode);
			SqlParameter p33 = new SqlParameter("@VendorID", VendID);
			SqlParameter p34 = new SqlParameter("@CustomerID", CustID);
			SqlParameter p35 = new SqlParameter("@SupplierID", SuppID);
			SqlParameter p36 = new SqlParameter("@EmployeeID", EmpID);
			SqlParameter p37 = new SqlParameter("@LTVendorAttribs", LTVendAttribs);
			SqlParameter p38 = new SqlParameter("@VendorGroup", VendGroup);
			SqlParameter p39 = new SqlParameter("@VendorClass", VendClass);
			SqlParameter p40 = new SqlParameter("@VendorTypeID", VendTypeID);
			SqlParameter p41 = new SqlParameter("@YardType", YardType);
			SqlParameter p42 = new SqlParameter("@MainPhone", Phone1);
			SqlParameter p43 = new SqlParameter("@CellPhone", Cell);
			SqlParameter p44 = new SqlParameter("@MainFax", Fax);
			SqlParameter p45 = new SqlParameter("@MainEmailAddress", Email);
			SqlParameter p46 = new SqlParameter("@CurrencyCode", CurrencyCd);
			SqlParameter p47 = new SqlParameter("@IsLT", IsLT);
			SqlParameter p48 = new SqlParameter("@IsLIMS", IsLIMS);
			SqlParameter p49 = new SqlParameter("@IsGP", IsGP);
			SqlParameter p50 = new SqlParameter("@Active", Active);
			SqlParameter p51 = new SqlParameter("@DivID", DivID);
			SqlParameter p52 = new SqlParameter("@ModNbr", ModNbr);
			SqlParameter p53 = new SqlParameter("@Contact", Contact);
			SqlParameter p54 = new SqlParameter("@ContactEmail", CEmail);
			SqlParameter p55 = new SqlParameter("@ContactPhone", CPhone);
			SqlParameter p56 = new SqlParameter("@ADUserID", ADUserID);
			SqlParameter p57 = new SqlParameter("@ByID", ByID);

			return di.RunSPReturnDataTableNWDW("web.usp_UpdateEntityData", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13, p14, p15, p16, p17, p18, p19, p20, p21, p22, p23, p24, p25, p26, p27, p28, p29, p30, p31, p32, p33, p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45, p46, p47, p48, p49, p50, p51, p52, p53, p54, p55, p56, p57 });
		}

	}
}
