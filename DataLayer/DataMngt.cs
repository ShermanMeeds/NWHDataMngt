using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace DataLayer
{
	public class DataMngtTool
  {
      public DataTable GetAccountCodes(int Sort, int PgNbr, int PgSize, int ByID)
      {
          DBInterface di = new DBInterface();
          SqlParameter p1 = new SqlParameter("@Sort", Sort);
          SqlParameter p2 = new SqlParameter("@PgNbr", PgNbr);
          SqlParameter p3 = new SqlParameter("@PgSize", PgSize);
          SqlParameter p4 = new SqlParameter("@ByID", ByID);
          return di.RunSPReturnDataTable("web.up_GetAccountCodes", new SqlParameter[] { p1, p2, p3, p4 });
      }

      public DataTable GetApproverList(string ItemType, Double TotalAmt, int ByID)
      {
          DBInterface di = new DBInterface();
          SqlParameter p1 = new SqlParameter("@amounttype", ItemType);
          SqlParameter p2 = new SqlParameter("@minamount", TotalAmt);
          return di.RunSPReturnDataTable("dbo.up_GetSignersList", new SqlParameter[] { p1, p2 });
      }

      public DataTable GetEmployeeList(int Sort, int PgNbr, int PgSize, int ByID)
      {
          DBInterface di = new DBInterface();
          SqlParameter p1 = new SqlParameter("@Sort", Sort);
          SqlParameter p2 = new SqlParameter("@PgNbr", PgNbr);
          SqlParameter p3 = new SqlParameter("@PgSize", PgSize);
          SqlParameter p4 = new SqlParameter("@ByID", ByID);
          return di.RunSPReturnDataTable("web.up_GetEmployeeList", new SqlParameter[] { p1, p2, p3, p4 });
      }

      public DataTable SendRequestForApproval(int ReqID, int VoucherNbr, string DocType, int EmpID, int ByID)
      {
          DBInterface di = new DBInterface();
          SqlParameter p1 = new SqlParameter("@RequestID", ReqID);
          SqlParameter p2 = new SqlParameter("@VoucherNbr", VoucherNbr);
          SqlParameter p3 = new SqlParameter("@DocType", DocType);
          SqlParameter p4 = new SqlParameter("@EmpID", EmpID);
          SqlParameter p5 = new SqlParameter("@ByID", ByID);
          return di.RunSPReturnDataTable("web.up_SendRequestForApproval", new SqlParameter[] { p1, p2, p3, p4, p5 });
      }

      public DataTable GetRequestCodeList(int whichCodeList, string productType)
      {
          // each code list returned here 
          // needs to have a blank row added to the beginning 
          // and to be sorted by the description
          DBInterface di = new DataLayer.DBInterface();
          SqlParameter whichCodeListParm = new SqlParameter(SearchProductsDataLayer.LoadPickListParm, whichCodeList);
          SqlParameter whichCodeSetParm = new SqlParameter(SearchProductsDataLayer.LoadPickListSet, productType);

          DataTable temp = di.RunSPReturnDataTable(SearchProductsDataLayer.LoadPickListSproc, new SqlParameter[] { whichCodeListParm, whichCodeSetParm });

          DataRow blankRow = temp.NewRow();
          blankRow.ItemArray[0] = (char)32;
          blankRow.ItemArray[1] = (char)32;
          temp.Rows.Add(blankRow);

          temp.DefaultView.Sort = string.Concat(SearchProductsDataLayer.SortDescCol, " ", SearchProductsDataLayer.SortOrder);
          temp = temp.DefaultView.ToTable();

          return temp;
      }

			public DataTable GetRequestCodeListRaw(int whichCodeList, string productType)
      {
          // each code list returned here 
          DBInterface di = new DataLayer.DBInterface();
          SqlParameter whichCodeListParm = new SqlParameter(SearchProductsDataLayer.LoadPickListParm, whichCodeList);
          SqlParameter whichCodeSetParm = new SqlParameter(SearchProductsDataLayer.LoadPickListSet, productType);

          DataTable temp = di.RunSPReturnDataTable(SearchProductsDataLayer.LoadPickListSproc, new SqlParameter[] { whichCodeListParm, whichCodeSetParm });

          return temp;
      }

      public DataTable GetProductTypeList()
      {
          // code list returned here 
          // needs to have a blank row added to the beginning 
          // and to be sorted by the code
          DBInterface di = new DataLayer.DBInterface();

          DataTable temp = di.RunSPReturnDataTable(SearchProductsDataLayer.LoadProductType, new SqlParameter[] { });

          DataRow blankRow = temp.NewRow();
          blankRow.ItemArray[0] = (char)32;
          temp.Rows.Add(blankRow);

          temp.DefaultView.Sort = string.Concat(SearchProductsDataLayer.SortCodeCol, " ", SearchProductsDataLayer.SortOrder);
          temp = temp.DefaultView.ToTable();

          return temp;
      }

      public DataTable GetProductCodeList(string CodeSetToLookFor)
      {
          // code list returned here needs to have a blank row added to the beginning 
          // and to be sorted by the code
          DBInterface di = new DataLayer.DBInterface();
          SqlParameter whichCodeListParm = new SqlParameter(SearchProductsDataLayer.LoadProductCodeParm, CodeSetToLookFor);

          DataTable temp = di.RunSPReturnDataTable(SearchProductsDataLayer.LoadProductCode, new SqlParameter[] { whichCodeListParm });

          DataRow blankRow = temp.NewRow();
          blankRow.ItemArray[0] = (char)32;
          temp.Rows.Add(blankRow);

          temp.DefaultView.Sort = string.Concat(SearchProductsDataLayer.SortCodeCol, " ", SearchProductsDataLayer.SortOrder);
          temp = temp.DefaultView.ToTable();

          return temp;
      }

      public DataTable GetMatchedProductsByDesc(string prodType, string prodCode, string prodDesc)
      {
          // searchs by production code type and production code and/or production description
          DBInterface di = new DataLayer.DBInterface();
          SqlParameter whichTypeParm = new SqlParameter(SearchProductsDataLayer.SearchProdTypeParm, (string.IsNullOrWhiteSpace(prodType) ? string.Empty : prodType));
          SqlParameter whichCodeParm = new SqlParameter(SearchProductsDataLayer.SearchProdCodeParm, (string.IsNullOrWhiteSpace(prodCode) ? string.Empty : prodCode));
          SqlParameter whichDescParm = new SqlParameter(SearchProductsDataLayer.SearchProdDescription, (string.IsNullOrWhiteSpace(prodDesc) ? string.Empty : prodDesc));

          DataTable temp = di.RunSPReturnDataTable(SearchProductsDataLayer.SearchProductsByDescriptionOrCode, new SqlParameter[] { whichTypeParm, whichCodeParm, whichDescParm });

          return temp;
      }

      public DataTable GetMatchedProductsByAttributes(string attribParm1, string attribParm2, string attribParm3, string attribParm4, string attribParm5,
          string attribParm6, string attribParm7, string attribParm8, string attribParm9, string attribParm10,
          string attribParm11, string attribParm12, string attribParm13, string attribParm14, string attribParm15)
      {
          //searchs by attributes, up to 15 can be supplied, any can be blank, the sproc will drop out blank ones
          DBInterface di = new DataLayer.DBInterface();
          SqlParameter AttributeParm1 = new SqlParameter(SearchProductsDataLayer.SearchProdAttributeParm1, (string.IsNullOrWhiteSpace(attribParm1) ? string.Empty : attribParm1));
          SqlParameter AttributeParm2 = new SqlParameter(SearchProductsDataLayer.SearchProdAttributeParm2, (string.IsNullOrWhiteSpace(attribParm2) ? string.Empty : attribParm2));
          SqlParameter AttributeParm3 = new SqlParameter(SearchProductsDataLayer.SearchProdAttributeParm3, (string.IsNullOrWhiteSpace(attribParm3) ? string.Empty : attribParm3));
          SqlParameter AttributeParm4 = new SqlParameter(SearchProductsDataLayer.SearchProdAttributeParm4, (string.IsNullOrWhiteSpace(attribParm4) ? string.Empty : attribParm4));
          SqlParameter AttributeParm5 = new SqlParameter(SearchProductsDataLayer.SearchProdAttributeParm5, (string.IsNullOrWhiteSpace(attribParm5) ? string.Empty : attribParm5));
          SqlParameter AttributeParm6 = new SqlParameter(SearchProductsDataLayer.SearchProdAttributeParm6, (string.IsNullOrWhiteSpace(attribParm6) ? string.Empty : attribParm6));
          SqlParameter AttributeParm7 = new SqlParameter(SearchProductsDataLayer.SearchProdAttributeParm7, (string.IsNullOrWhiteSpace(attribParm7) ? string.Empty : attribParm7));
          SqlParameter AttributeParm8 = new SqlParameter(SearchProductsDataLayer.SearchProdAttributeParm8, (string.IsNullOrWhiteSpace(attribParm8) ? string.Empty : attribParm8));
          SqlParameter AttributeParm9 = new SqlParameter(SearchProductsDataLayer.SearchProdAttributeParm9, (string.IsNullOrWhiteSpace(attribParm9) ? string.Empty : attribParm9));
          SqlParameter AttributeParm10 = new SqlParameter(SearchProductsDataLayer.SearchProdAttributeParm10, (string.IsNullOrWhiteSpace(attribParm10) ? string.Empty : attribParm10));
          SqlParameter AttributeParm11 = new SqlParameter(SearchProductsDataLayer.SearchProdAttributeParm11, (string.IsNullOrWhiteSpace(attribParm11) ? string.Empty : attribParm11));
          SqlParameter AttributeParm12 = new SqlParameter(SearchProductsDataLayer.SearchProdAttributeParm12, (string.IsNullOrWhiteSpace(attribParm12) ? string.Empty : attribParm12));
          SqlParameter AttributeParm13 = new SqlParameter(SearchProductsDataLayer.SearchProdAttributeParm13, (string.IsNullOrWhiteSpace(attribParm13) ? string.Empty : attribParm13));
          SqlParameter AttributeParm14 = new SqlParameter(SearchProductsDataLayer.SearchProdAttributeParm14, (string.IsNullOrWhiteSpace(attribParm14) ? string.Empty : attribParm14));
          SqlParameter AttributeParm15 = new SqlParameter(SearchProductsDataLayer.SearchProdAttributeParm15, (string.IsNullOrWhiteSpace(attribParm15) ? string.Empty : attribParm15));


          DataTable temp = di.RunSPReturnDataTable(SearchProductsDataLayer.SearchProductsByAttributes, new SqlParameter[] { AttributeParm1, AttributeParm2, AttributeParm3, AttributeParm4, AttributeParm5,
                                                                                                                            AttributeParm6, AttributeParm7, AttributeParm8, AttributeParm9,AttributeParm10,
                                                                                                                            AttributeParm11, AttributeParm12, AttributeParm13, AttributeParm14, AttributeParm15 });

          return temp;
      }

      public DataTable FillSalesTableSegments(string sprocName)
      {
          // fills a data table with the contents of a sales data view  
          DBInterface di = new DataLayer.DBInterface();
          DataTable temp = di.RunSPReturnDataTable(sprocName, new SqlParameter[] { });

          return temp;
      }

      public DataTable FillSalesTableSegments(string sprocName, string proTypeParm)
      {
          // fills a data table with the contents of a sales data view  
          DBInterface di = new DataLayer.DBInterface();
          SqlParameter whichTypeParm = new SqlParameter(SalesPlanResources.spLoadParmProType, (string.IsNullOrWhiteSpace(proTypeParm) ? string.Empty : proTypeParm));

          DataTable temp = di.RunSPReturnDataTable(sprocName, new SqlParameter[] { whichTypeParm });

          return temp;
      }

      public DataTable FillSalesTableSegments(string sprocName, string proTypeParm, string regionParm, string locParm)
      {
          // fills a data table with the contents of a sales data view  
          DBInterface di = new DataLayer.DBInterface(); 
          SqlParameter whichTypeParm = new SqlParameter(SalesPlanResources.spLoadParmProType, (string.IsNullOrWhiteSpace(proTypeParm) ? string.Empty : proTypeParm));
          SqlParameter whichRegionParm = new SqlParameter(SalesPlanResources.spLoadParmRegion, (string.IsNullOrWhiteSpace(regionParm) ? string.Empty : regionParm));
          SqlParameter whichLocParm = new SqlParameter(SalesPlanResources.spLoadParmLocation, (string.IsNullOrWhiteSpace(locParm) ? string.Empty : locParm));
          DataTable temp = di.RunSPReturnDataTable(sprocName, new SqlParameter[] { whichTypeParm, whichRegionParm, whichLocParm });

          return temp;
      }

      public DataTable FillSalesTableRegions(string proTypeParm, bool includeBlanks)
      {
          // fills a data table with the contents of a sales data view  
          DBInterface di = new DataLayer.DBInterface();
          SqlParameter whichTypeParm = new SqlParameter(SalesPlanResources.spLoadParmProType, (string.IsNullOrWhiteSpace(proTypeParm) ? string.Empty : proTypeParm));
          SqlParameter includeBlankParm = new SqlParameter(SalesPlanResources.spLoadParmIncludeBlank, includeBlanks);
          DataTable temp = di.RunSPReturnDataTable(SalesPlanResources.SpLoadRegions, new SqlParameter[] { whichTypeParm, includeBlankParm });

          return temp;
      }

      public DataTable FillSalesTableLocationRegions(string proTypeParm)
      {
          // fills a data table with the contents of a sales data view  
          DBInterface di = new DataLayer.DBInterface();
          SqlParameter whichTypeParm = new SqlParameter(SalesPlanResources.spLoadParmProType, (string.IsNullOrWhiteSpace(proTypeParm) ? string.Empty : proTypeParm));
          SqlParameter whichRegion = new SqlParameter(SalesPlanResources.spLoadParmRegion, SalesPlanResources.wordALL);
            
          DataTable temp = di.RunSPReturnDataTable(SalesPlanResources.SpLoadRegionsLocations, new SqlParameter[] { whichTypeParm, whichRegion });

          return temp;
      }

      public DataTable FillSalesTableSpecies(string proTypeParm)
      {
          // fills a data table with the contents of a sales data view  
          DBInterface di = new DataLayer.DBInterface();
          SqlParameter whichTypeParm = new SqlParameter(SalesPlanResources.spLoadParmProType, (string.IsNullOrWhiteSpace(proTypeParm) ? string.Empty : proTypeParm));
          SqlParameter whichRegion = new SqlParameter(SalesPlanResources.spLoadParmRegion, SalesPlanResources.wordALL);
          SqlParameter whichLocation = new SqlParameter(SalesPlanResources.spLoadParmLocation, SalesPlanResources.wordALL);

          DataTable temp = di.RunSPReturnDataTable(SalesPlanResources.SpLoadSpecies, new SqlParameter[] { whichTypeParm, whichRegion, whichLocation });

          return temp;
      }

      public DataTable FillSalesTableAttributes(string sprocName, string proTypeParm)
      {
          // fills a data table with the contents of a sales data view  
          DBInterface di = new DataLayer.DBInterface();

          SqlParameter whichTypeParm = new SqlParameter(SalesPlanResources.spLoadParmProType, (string.IsNullOrWhiteSpace(proTypeParm) ? string.Empty : proTypeParm));
          SqlParameter whichRegion = new SqlParameter(SalesPlanResources.spLoadParmRegion, SalesPlanResources.wordALL);
          SqlParameter whichLocation = new SqlParameter(SalesPlanResources.spLoadParmLocation, SalesPlanResources.wordALL);
          SqlParameter whichSpecie = new SqlParameter(SalesPlanResources.spLoadParmSpecie, SalesPlanResources.wordALL);

          SqlParameter[] parmList = new SqlParameter[] { whichTypeParm, whichRegion, whichLocation, whichSpecie };

          //parmList.Length 
          DataTable tmp = di.RunSPReturnDataTable(sprocName, parmList);
            
          return tmp;
      }

      public DataTable RetrieveSettings(int UserId)
      {
          // fills a data table with the contents of a sales data view  
          DBInterface di = new DataLayer.DBInterface();

          SqlParameter whichUser = new SqlParameter(SalesPlanResources.spSettingsParmUserId, UserId.ToString());
           
          SqlParameter[] parmList = new SqlParameter[] { whichUser };

          //parmList.Length 
          DataTable tmp = di.RunSPReturnDataTable(SalesPlanResources.spLoadSettings, parmList);

          return tmp;
      }

      public bool SaveSettings(DataTable settingsTable)
      {
          // fills a data table with the contents of a sales data view  
          DBInterface di = new DataLayer.DBInterface();

          foreach (DataRow settingsRow in settingsTable.Rows)
          {
              int UserId = Convert.ToInt32(settingsRow[SalesPlanResources.settingsColUserId].ToString());
              string ControlName = settingsRow[SalesPlanResources.settingsColControlName].ToString();
              string ControlValue = settingsRow[SalesPlanResources.settingsColControlValue].ToString();

              SqlParameter whichUser = new SqlParameter(SalesPlanResources.spSettingsParmUserId, UserId.ToString());
              SqlParameter whichControl = new SqlParameter(SalesPlanResources.spSettingsParmControlName, ControlName);
              SqlParameter whatValues = new SqlParameter(SalesPlanResources.spSettingsParmControlValue, ControlValue);

              SqlParameter[] parmList = new SqlParameter[] { whichUser, whichControl, whatValues };
                
              di.RunSPReturnScalar(SalesPlanResources.spSaveSettings, parmList);
          }

          return true;
      }

		public DataTable UpdateColumnSetting(int UserID, string UIType, string Item, string Val, string Comment, int Active, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@UserID", UserID);
			SqlParameter p2 = new SqlParameter("@UIType", UIType);
			SqlParameter p3 = new SqlParameter("@Item", Item);
			SqlParameter p4 = new SqlParameter("@Value", Val);
			SqlParameter p5 = new SqlParameter("@Comment", Comment);
			SqlParameter p6 = new SqlParameter("@Active", Active);
			SqlParameter p7 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTableNWB("web.usp_UpdateUISetting", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7 });

		}

	}
}