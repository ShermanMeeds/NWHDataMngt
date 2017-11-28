using System;
using System.Data;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
using DataLayer;
using DataMngt;

[System.Web.Script.Services.ScriptService()]
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.ComponentModel.ToolboxItem(false)]
public class AjaxServicesController : System.Web.Services.WebService
{

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string DeleteManagementItem(int PgID, int ObjID, int ID, int iType, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.DeleteManagementItem(ID, iType, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "DeleteManagementItem", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Del Mngt Item", ID, ByID, ex.Message, 0, "DeleteManagementItem function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string Get13WeekDates(int PgID, int ObjID, int iType, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.Get13WeekDates(iType);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "Get13WeekDates", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("13 weeks dates", 0, ByID, ex.Message, 0, "Get13WeekDates function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
  [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
  public string GetAttachmentList(int PgID, int ObjID, string DocType, int ID, string Ext, int Sort, int PgNbr, int PgSize, int ByID)
  {
    Commands cmd = new Commands();
    string s = string.Empty;
    int iResult = 0;
    try
    {
			DataTable dt = cmd.SelectAttachmentList(DocType, ID, Ext, Sort, PgNbr, PgSize, ByID);
      s = GenUtilities.JSON(dt);
      iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "GetAttachmentList", s.Length, ByID);
      return s;
    }
    catch (Exception ex)
    {
      iResult = cmd.LogApplicationError("Req Attachments", ID, ByID, ex.Message, 0, "GetAttachmentList function", ByID);
      JavaScriptSerializer js = new JavaScriptSerializer();
      var response = new { success = "false", message = ex.Message };
      return response.ToJSON();
    }
	} 

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string GetAttachmentList2(int PgID, int ObjID, string DocType, string DocType2, string DocType3, int ID, int ID2, string Ext, int PgNbr, int PgSize, int Sort, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.SelectAttachmentList2(DocType, DocType2, DocType3, ID, ID2, Ext, PgNbr, PgSize, Sort, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "GetAttachmentList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Req Attachments", ID, ByID, ex.Message, 0, "GetAttachmentList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}  

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string GetCalendarData(int PgID, int ObjID, int Yr, int Mo, int CalType, string ProdCode, string Region, string LocCode, string Species, string Grade, string Thick, string Len, string Color, string Sort, string Milling, string NoPrint,
			string Cust, int Shift, int ShowLoc, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.SelectCalendarData(Yr, Mo, CalType, ProdCode, Region, LocCode, Species, Grade, Thick, Len, Color, Sort, Milling, NoPrint, Cust, Shift, ShowLoc, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "GetCalendarData", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Calendar Data", 0, ByID, ex.Message, 0, "GetCalendarData function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string GetCalendarDatesForMonth(int PgID, int ObjID, int Yr, int Mo, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.GetCalendarDataForMonth(Yr, Mo, ByID);
			int MyStuff = 0;
			string whatfun = string.Empty;
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "GetCalendarDatesForMonth", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Calendar Mo Data", 0, ByID, ex.Message, 0, "GetCalendarDatesForMonth function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string GetCalDatesForMonth(int PgID, int ObjID, int Yr, int Mo, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.GetCalDatesForMonth(Yr, Mo, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "GetCalDatesForMonth", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("CalDates Data", 0, ByID, ex.Message, 0, "GetCalDatesForMonth function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string GetCatCodeList(int PgID, int ObjID, string CodeType, int Sort, int Active, int UserList, int NoBlank, int Shown, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			CatToolFunctions ctf = new CatToolFunctions();
			DataTable dt = ctf.GetCatCodeList(CodeType, Sort, Active, UserList, NoBlank, Shown, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "GetCatCodeList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Cat Code List", 0, ByID, ex.Message, 0, "GetCatCodeList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string GetCurrencyCodeList(int PgID, int ObjID, int Sort, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataLayer.DataMngtTool p = new DataLayer.DataMngtTool();
			DataTable dt = p.GetAccountCodes(0, 0, 0, ByID);
			//DataTable dt = c.GetCurrencyCodeList(Sort, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "GetCurrencyCodeList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("GetContentTypeList", 0, ByID, ex.Message, 0, "GetCurrencyCodeList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string GetEmployeeList(int PgID, int ObjID, int Sort, int PgNbr, int PgSize, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataLayer.DataMngtTool p = new DataLayer.DataMngtTool();
			DataTable dt = p.GetEmployeeList(Sort, PgNbr, PgSize, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "GetEmployeeList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Employee List", 0, ByID, ex.Message, 0, "GetEmployeeList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string GetForecastProductList(int PgID, int ObjID, string Loc, string Region, string ProdCode, int MixID, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			Forecast fc = new Forecast();
			DataTable dt = fc.SelectForecastProductList(Loc, Region, ProdCode, MixID, Sort, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "GetForecastProductList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Product List", 0, ByID, ex.Message, 0, "GetForecastProductList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string GetForecastProductListMini(int PgID, int ObjID, string Loc, string Region, string ProdCode, int MixID, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			Forecast fc = new Forecast();
			DataTable dt = fc.SelectForecastProductListMini(Loc, Region, ProdCode, MixID, Sort, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "GetForecastProductListMini", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Product List Mini", 0, ByID, ex.Message, 0, "GetForecastProductListMini function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string GetLocationList(int PgID, int ObjID, string LocCode, string LocType, string Country, string City, int Class, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.GetLocationList(LocCode, LocType, Country, City, Sort, Class, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "GetLocationList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Locations", Sort, ByID, ex.Message, 0, "GetLocationList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string GetLocationList2(int PgID, int ObjID, string LocCode, string Region, string LocType, string Country, string City, int Class, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.GetLocationList2(LocCode, Region, LocType, Country, City, Class, Sort, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "GetLocationList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Locations", Sort, ByID, ex.Message, 0, "GetLocationList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string MakeProductManaged(int PgID, int ObjID, string PT, string Prod, string Desc, string Specie, string Thickness, string Grade, string Len, string Color, string Sort, string Milling, string NoPrint, int ByID)
	{
		Commands cmd = new Commands();
		CatToolFunctions ctf = new CatToolFunctions();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = ctf.UpdateCatToolProductData(0, "", Prod, Prod, Desc, 0, "", Specie, Thickness, Grade, Len, Color, Sort, Milling, NoPrint, 0, 1, 1, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "MakeProductManaged", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("MakeProductManaged", 0, 0, ex.Message, 0, "MakeProductManaged function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string GetRegionForLocation(int PgID, int ObjID, string Loc, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.GetRegionForLocation(Loc, ByID);
			s = GenUtilities.JSON(dt);
			//iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "GetRegionForLocation", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Region for Loc", 0, ByID, ex.Message, 0, "GetRegionForLocation function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
  [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
  public string GetRequestAttachments(int PgID, int ObjID, string DocType, int VoucherNbr, int Sort, int PgNbr, int PgSize, int ByID)
  {
    Commands cmd = new Commands();
    string s = string.Empty;
    int iResult = 0;
    try
    {
			DataLayer.DataMngtTool p = new DataLayer.DataMngtTool();
			DataTable dt = p.GetAccountCodes(Sort, PgNbr, PgSize, ByID);
			//DataTable dt = p.GetCodingAttachmentList(VoucherNbr, DocType, Sort, PgNbr, PgSize, ByID);
      s = GenUtilities.JSON(dt);
      iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "GetRequestAttachments", s.Length, ByID);
      return s;
    }
    catch (Exception ex)
    {
      iResult = cmd.LogApplicationError("Req Attachments", VoucherNbr, ByID, ex.Message, 0, "GetRequestAttachments function", ByID);
      JavaScriptSerializer js = new JavaScriptSerializer();
      var response = new { success = "false", message = ex.Message };
      return response.ToJSON();
    }
  }

  [WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string GetUserLocations(int PgID, int ObjID, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			Forecast fc = new Forecast();
			DataTable dt = fc.SelectUserForecastLocList(0, ByID);
			//DataTable dt = p.GetCodingAttachmentList(VoucherNbr, DocType, Sort, PgNbr, PgSize, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "GetRequestAttachments", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("UserLocs", 0, ByID, ex.Message, 0, "GetUserLocations function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

 	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectCatProductDetailsForWeek(int PgID, int ObjID, int ListID, string ProdType, string Product, string Len, string Color, string fSort, string Milling, string NoPrint, string TDate, int Sort, int PgNbr, int PgSize, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			CatToolFunctions ctf = new CatToolFunctions();
			DataTable dt = ctf.GetCatToolDetails2(ListID, ProdType, Product, Len, Color, fSort, Milling, NoPrint, TDate, Sort, PgNbr, PgSize, ByID);   // PgNbr, PgSize, 
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectCatProductDetailsForWeek", s.Length, ByID);
			return s;
		}           
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Cat Prod Week Details", 0, ByID, ex.Message, 0, "SelectCatProductDetailsForWeek function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}
	

[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectConsolidationLocationList(int PgID, int ObjID, int UserID, string LocCode, string Region, string LocType, string Country, string City, int Class, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			SalesFunctions sf = new SalesFunctions();
			DataTable dt = sf.SelectConsolidationLocationList(UserID, LocCode, Region, LocType, Country, City, Class, Sort, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectConsolidationLocationList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Consol Loc List", 0, ByID, ex.Message, 0, "SelectConsolidationLocationList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectFCConsolidationData(int PgID, int ObjID, int DType, string Region, string Loc, string Prod, string Species, string Grade, string Thickness, string Surface, string Seasoning, string Len, string Color, string Sort,
			string Milling, string NoPrint, string Level, DateTime TDate, string FuzzyGrade, string FuzzySort, string FuzzyProd, int PgNbr, int PgSize, int NoEmpties, int DataSort, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			SalesFunctions sf = new SalesFunctions();
			DataTable dt = sf.SelectFCConsolidationData(DType, Region, Loc, Prod, Species, Grade, Thickness, Surface, Seasoning, Len, Color, Sort, Milling, NoPrint, Level, TDate, FuzzyGrade, FuzzySort, FuzzyProd, PgNbr, PgSize, NoEmpties, DataSort, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectFCConsolidationData", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Consolidation List", 0, ByID, ex.Message, 0, "SelectFCConsolidationData function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectFCConsolidationDataHist(int PgID, int ObjID, int DType, string Region, string Loc, string Prod, string Species, string Grade, string Thickness, string Surface, string Seasoning, string Len, string Color, string Sort,
			string Milling, string NoPrint, string Level, DateTime TDate, string FuzzyGrade, string FuzzySort, string FuzzyProd, int PgNbr, int PgSize, int NoEmpties, int DataSort, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			SalesFunctions sf = new SalesFunctions();
			DataTable dt = sf.SelectFCConsolidationDataHist(DType, Region, Loc, Prod, Species, Grade, Thickness, Surface, Seasoning, Len, Color, Sort, Milling, NoPrint, Level, TDate, FuzzyGrade, FuzzySort, FuzzyProd, PgNbr, PgSize, NoEmpties, 
				DataSort, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectFCConsolidationData", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Consolidation List", 0, ByID, ex.Message, 0, "SelectFCConsolidationData function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectLTProdCodeList(int PgID, int ObjID, string Prefix, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.GetLTProdCodeList(Prefix, Sort, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectLTProdCodeList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("LTProd Code List", 0, ByID, ex.Message, 0, "SelectLTProdCodeList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectLTProdCustomerList(int PgID, int ObjID, string Seed, int Sort, int Min, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			SalesFunctions sf = new SalesFunctions();
			DataTable dt = sf.SelectLTProdCustomerList(Seed, Sort, Min, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectLTProdCustomerList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Cust List", 0, ByID, ex.Message, 0, "SelectLTProdCustomerList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectProductCodeList(int PgID, int ObjID, string CodeType, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.SelectProductCodeList(CodeType, 0, 1, 0, 0, 0, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectProductCodeList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Prod Code List", 0, 0, ex.Message, 0, "SelectProductCodeList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectProductCodeListSpecial(int PgID, int ObjID, string CodeType, int Grp1, int Grp2, int Grp3, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.SelectProductCodeList(CodeType, Sort, Active, Grp1, Grp2, Grp3, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectProductCodeListSpecial", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Prod Code List Spec", 0, 0, ex.Message, 0, "SelectProductCodeListSpecial function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectProductCodeListForRegion(int PgID, int ObjID, string Region, string CodeType, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.SelectProductCodeListForRegion(Region, CodeType, 0, 1, 0, 0, 0, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectProductCodeListForRegion", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("ProdCodeListForRegion", 0, 0, ex.Message, 0, "SelectProductCodeListForRegion function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}
	
	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectProductCodesManaged (int PgID, int ObjID, string ProdType, string ProdCode, string Reg, string Thickness, string Specie, string Grade, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			SalesFunctions sf = new SalesFunctions();
			DataTable dt = sf.SelectProductCodesManaged(ProdType, ProdCode, Reg, Thickness, Specie, Grade, Sort, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectProductCodesManaged", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("ProdCodeListForRegion", 0, 0, ex.Message, 0, "SelectProductCodesManaged function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectProductItemData(int PgID, int ObjID, int PMID, int PLID, string ProdType, string ProdCode, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			InvoiceLib il = new InvoiceLib();
			DataTable dt = il.SelectProductData(PMID, PLID, ProdType, ProdCode, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectProductItemData", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Get Product Item", PMID, 0, ex.Message, 0, "SelectProductItemData function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectProductItemDataWide(int PgID, int ObjID, string ProdType, string ProdCode, int PMID, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			SalesFunctions sf = new SalesFunctions();
			DataTable dt = sf.SelectProductItemDataWide(PMID, ProdType, ProdCode, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectProductCodeListForRegion", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("ProdCodeListForRegion", 0, 0, ex.Message, 0, "SelectProductCodeListForRegion function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectProductListManaged(int PgID, int ObjID, int PMID, string ProdType, string ProdCode, string Reg, string Thickness, string Specie, string Grade, int Sort, int Active, int Short, int PgNbr, int PgSize, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			SalesFunctions sf = new SalesFunctions();
			DataTable dt = sf.SelectProductListManaged(PMID, ProdType, ProdCode, Reg, Thickness, Specie, Grade, Sort, Active, Short, PgNbr, PgSize, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectProductListManaged", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Prod Mngd List", 0, 0, ex.Message, 0, "SelectProductListManaged function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectProductListMaster(int PgID, int ObjID, string ProdType, string Region, int ShowAll, int Sort, int Active, int List, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.SelectProductListMaster(ProdType, Region, ShowAll, Sort, Active, List, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectProductListMaster", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Prod Master List", 0, 0, ex.Message, 0, "SelectProductListMaster function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectProductTypesList(int PgID, int ObjID, string ProdType, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.SelectProductTypesList(ProdType, Sort, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectProductTypesList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Prod Types List", 0, 0, ex.Message, 0, "SelectProductTypesList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectSalesManagerList(int PgID, int ObjID, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			SalesFunctions sf = new SalesFunctions();
			DataTable dt = sf.SelectSalesManagerList(Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectSalesManagerList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Sales Mgr List", 0, ByID, ex.Message, 0, "SelectSalesManagerList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectSalesPlanGridData(int PgID, int ObjID, string Reg, string Loc, string PType, string Prod, string Thick, string Spec, string Grade, string Season, string Surf, string Len, string Color,
			string FSort, string Milling, string NoPrint, string Cust, string Mgr, int IncInven, int IncSales, int IncForecast, int IncHolds, int IncProd, int IncCust, int IncHist, int IncPHist, string RollupItems,
			int Sort, string FuzzyGrade, string FuzzySort, string FuzzyProd, string FuzzyMgr, string FuzzyCust, string CustCode, int PgNbr, int PgSize, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			// handle customer values
			SalesFunctions sf = new SalesFunctions();
			DataTable dt = sf.SelectSalesPlanGridData(Reg, Loc, PType, Prod, Thick, Spec, Grade, Season, Surf, Len, Color, FSort, Milling, NoPrint, Cust, Mgr, IncInven, IncSales, IncForecast, IncHolds, IncProd, IncCust,
				IncHist, IncPHist, RollupItems, Sort, FuzzyGrade, FuzzySort, FuzzyProd, FuzzyMgr, FuzzyCust, CustCode, PgNbr, PgSize, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectSalesPlanGridData", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Grid Data", 0, ByID, ex.Message, 0, "SelectSalesPlanGridData function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectUserInterfaceItems(int PgID, int ObjID, string UIType, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.SelectUserInterfaceItems(ByID, UIType, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectUserInterfaceItems", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("UI Items", ByID, ByID, ex.Message, 0, "SelectUserInterfaceItems function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectUserConsolidationLocs(int PgID, int ObjID, string Grp, int iType, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			SalesFunctions sf = new SalesFunctions();
			DataTable dt = sf.SelectUserConsolidationLocationsList(Grp, iType, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectUserConsolidationLocs", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Consol Locs", iType, ByID, ex.Message, 0, "SelectUserConsolidationLocs function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectUserListMin(int PgID, int ObjID, string Name, string Pos, int HasEmail, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.SelectUserListMin(Name, Pos, HasEmail, Sort, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectUserListMin", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("User List", 0, ByID, ex.Message, 0, "SelectUserListMin function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectUserQueryData(int PgID, int ObjID, int UserID, int QueryID, string QueryName, int Sort, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.SelectUserQueryData(UserID, QueryID, QueryName, PgID, ObjID, Sort, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectUserQueryData", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("UI Items", UserID, ByID, ex.Message, 0, "SelectUserQueryData function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectWurthProdConversionData(int PgID, int ObjID, int ID, string PType, string ProdCode, string Thick, string Specie, string Grade, string Width, string Color, string fSort, string Milling, 
		int Sort, int Active, int PgNbr, int PgSize, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			ProductionFnc pf = new ProductionFnc();
			DataTable dt = pf.SelectWurthProdConversionData(ID, PType, ProdCode, Thick, Specie, Grade, Width, Color, fSort, Milling, Sort, Active, PgNbr, PgSize, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectWurthProdConversionData", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Wurth Data List", ID, ByID, ex.Message, 0, "SelectWurthProdConversionData function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectWurthProductCodeList(int PgID, int ObjID, string PType, int Sort, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			ProductionFnc pf = new ProductionFnc();
			DataTable dt = pf.SelectWurthProductCodeList(PType, Sort, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectWurthProductCodeList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Wurth Data List", 0, ByID, ex.Message, 0, "SelectWurthProductCodeList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
  [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
  public string SendRequestForApproval(int PgID, int ObjID, int ReqID, string DocType, int VoucherNbr, int EmpID, int ByID)
  {
    Commands cmd = new Commands();
    string s = string.Empty;
    int iResult = 0;
    try
    {
			DataLayer.DataMngtTool p = new DataLayer.DataMngtTool();
			DataTable dt = p.GetAccountCodes(0, 0, 0, ByID);
			//DataTable dt = p.SendRequestForApproval(ReqID, VoucherNbr, DocType, EmpID, ByID);
      s = GenUtilities.JSON(dt);
      iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "GetRequestAttachments", s.Length, ByID);
      return s;
    }
    catch (Exception ex)
    {
      iResult = cmd.LogApplicationError("Req Attachments", VoucherNbr, ByID, ex.Message, 0, "GetRequestAttachments function", ByID);
      JavaScriptSerializer js = new JavaScriptSerializer();
      var response = new { success = "false", message = ex.Message };
      return response.ToJSON();
    }
  }

  [WebMethod(EnableSession = true)]
  [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
  public string SetSessionValueFromAJAX(int PgID, int ObjID, string SessionValName, string val)
  {
    JavaScriptSerializer js = new JavaScriptSerializer();
    //int iResult = 0;
    try
    {
      System.Web.HttpContext.Current.Session[SessionValName] = val;
      return GenUtilities.JSON(GenUtilities.getStatusDataTable(0, "", 0));
    }
    catch (Exception ex)
    {
      return GenUtilities.JSON(GenUtilities.getStatusDataTable(1, ex.Message, 0));
    }
  }

  [WebMethod]
  [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
  public string UpdateCodingDistLine(int PgID, int ObjID, int ReqID, int DistID, string CompCd, string Acct, string ProjCd, string CC, string EmpCd, Double Amt, string Notes, int InsertRow, int ByID)
  {
    Commands cmd = new Commands();
    int iResult = 0;
    string s = string.Empty;
    try
    {
			DataLayer.DataMngtTool p = new DataLayer.DataMngtTool();
			DataTable dt = p.GetAccountCodes(0, 0, 0, ByID);
			//DataTable dt = p.UpdateDistLineData(ReqID, DistID, CompCd, Acct, ProjCd, CC, EmpCd, Amt, Notes, InsertRow, ByID);
      s = GenUtilities.JSON(dt);
      iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "UpdateCodingDistLine", s.Length, ByID);
      return s;
    }
    catch (Exception ex)
    {
      iResult = cmd.LogApplicationError("Update CodingDistLine", DistID, ByID, ex.Message, 0, "UpdateCodingDistLine function", ByID);
      JavaScriptSerializer js = new JavaScriptSerializer();
      var response = new { success = "false", message = ex.Message };
      return response.ToJSON();
    }
  }

  [WebMethod]
  [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
  public string ValidateCodingItems(int PgID, int ObjID, int ReqID, int ByID)
  {
    Commands cmd = new Commands();
    int iResult = 0;
    string s = string.Empty;
    try
    {
			DataLayer.DataMngtTool p = new DataLayer.DataMngtTool();
			//DataTable dt = p.ValidateFinCodingItems(ReqID, ByID);
			DataTable dt = p.GetAccountCodes(0, 0, 0, ByID);
			s = GenUtilities.JSON(dt);
      iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "ValidateCodingItems", s.Length, ByID);
      return s;
    }
    catch (Exception ex)
    {
      iResult = cmd.LogApplicationError("Validate Cd Items", ReqID, ByID, ex.Message, 0, "ValidateCodingItems function", ByID);
      JavaScriptSerializer js = new JavaScriptSerializer();
      var response = new { success = "false", message = ex.Message };
      return response.ToJSON();
    }
  }
	
	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string UpdateColumnSetting(int PgID, int ObjID, int UserID, string UIType, string Item, string Val, string Comment, int Active, int ByID)
	{
		Commands cmd = new Commands();
		int iResult = 0;
		string s = string.Empty;
		try
		{
			DataLayer.DataMngtTool p = new DataLayer.DataMngtTool();
			//DataTable dt = p.ValidateFinCodingItems(ReqID, ByID);
			DataTable dt = p.UpdateColumnSetting(UserID, UIType, Item, Val, Comment, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "ValidateCodingItems", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Validate Cd Items", UserID, ByID, ex.Message, 0, "ValidateCodingItems function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string UpdateDataExport(int PgID, int ObjID, int UserID, string ExpFileNm, string ProdType, string ProdCode, string LocCode, string Reg, string Thick, string Spec, string Grade, string Season, string Surf,
			string Stat, int iType, string Wdth, string Len, string Color, string FSort, string Milling, string NoPrint, int OrderID, int ShipID, int LoadID, string Cust, string Vendor, string Supplier, string Mgr, int MgrID,
			int Set0, int Set1, int Set2, int Set3, int Set4, int Set5, int Set6, string RollupItems, string FuzzyGrade, string FuzzySort, string FuzzyProd, string FuzzyMgr, string FuzzyCust, string Fuzzy6,
			string IName, string ICode, string IDesc, double Nbr, string Code1, string Code2, int id1, int id2, string TDt, string BDt, string EDt, string CustCode, string SubTotal, string Cmt, int Sort, int Active)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DateTime? dTDate = null;
			DateTime? dBDate = null;
			DateTime? dEDate = null;
			if (!String.IsNullOrWhiteSpace(TDt)) { dTDate = Convert.ToDateTime(TDt); }
			if (!String.IsNullOrWhiteSpace(BDt)) { dBDate = Convert.ToDateTime(BDt); }
			if (!String.IsNullOrWhiteSpace(EDt)) { dEDate = Convert.ToDateTime(EDt); }
			DataTable dt = cmd.UpdateDataExport(UserID, PgID, ObjID, ExpFileNm, ProdType, ProdCode, LocCode, Reg, Thick, Spec, Grade, Season, Surf, Stat, iType, Wdth, Len, Color, FSort, Milling, NoPrint, OrderID, ShipID, LoadID,
				Cust, Vendor, Supplier, Mgr, MgrID, Set0, Set1, Set2, Set3, Set4, Set5, Set6, RollupItems, FuzzyGrade, FuzzySort, FuzzyProd, FuzzyMgr, FuzzyCust, Fuzzy6, IName, ICode, IDesc, Nbr, Code1, Code2,
				id1, id2, dTDate, dBDate, dEDate, CustCode, SubTotal, Cmt, Sort, Active);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, UserID, 1, "UpdateUserExportData", s.Length, UserID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Update User Exp", UserID, UserID, ex.Message, 0, "UpdateUserExportData function", UserID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
  [ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
  public string UpdateDocumentBlob()
  {
    Commands cmd = new Commands();
    //string Dta
    DataTable dt = null;
    int ByID = 0;
    int DocID = 0;
    int iResult = 0;
    int MyLen = 0;
    string s = string.Empty;
    try
    {
      iResult = cmd.LogAjaxCall(9, 9, 1, "UpdateDocumentBlob", 0, 1);
      string FileNm = System.Web.HttpContext.Current.Request["XFileName"].ToString();
      string MDate = System.Web.HttpContext.Current.Request["MDate"].ToString();
      string Src = System.Web.HttpContext.Current.Request["DType"].ToString();
      string FType = System.Web.HttpContext.Current.Request["FType"].ToString();
      string MType = System.Web.HttpContext.Current.Request["MType"].ToString();
      string ContentType = System.Web.HttpContext.Current.Request["CType"].ToString();
      string DocTitle = System.Web.HttpContext.Current.Request["DTitle"].ToString();
      double FSize = Convert.ToDouble(System.Web.HttpContext.Current.Request["FSize"]);
      ByID = Convert.ToInt32(System.Web.HttpContext.Current.Request["ByID"].ToString());
      int SourceID = Convert.ToInt32(System.Web.HttpContext.Current.Request["SrcID"].ToString());
      byte[] DBlob;

      string fContents = HttpUtility.UrlDecode(System.Web.HttpContext.Current.Request["fcontents"]); // comes in as base64 .Unvalidated
      //string fContents2 = System.Convert.FromBase64String(fContents); // convert string to unbase64encoded byte array 
      iResult = cmd.LogAjaxCall(9, 9, 1, "UpdateDocumentBlob", MyLen, ByID);
      if (MType.Substring(0, 5) != "text/")
      {
        MyLen = fContents.Length;
        fContents = fContents.Replace(" ", "+");
        DBlob = System.Convert.FromBase64String(fContents); // convert string to unbase64encoded byte array Encoding.ASCII.GetBytes(fContents2); // GenUtilities.base64Decode(fContents); // 
        MyLen = DBlob.Length;
      }
      else
      {
        DBlob = GenUtilities.GetBytes(fContents);
      }
      DocID = 0;
      dt = cmd.UpdateAttachment(SourceID, DocID, Src, FileNm, FSize, FType, ContentType, DocTitle, DBlob, 0, ByID);
      if (fContents == null)
      {
        dt = GenUtilities.getStatusDataTable(1, "File is empty", 0);
      }
      s = GenUtilities.JSON(dt);
      return s; // 
    }
    catch (Exception ex)
    {
      iResult = cmd.LogApplicationError("Doc Blob Load", DocID, ByID, ex.Message, 0, "UpdateDocumentBlob function", ByID);
      dt = GenUtilities.getStatusDataTable(1, ex.Message, 0);
      s = GenUtilities.JSON(dt);
      return s;
    }
  }

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string UpdateSortOrder(int PgID, int ObjID, int ID, int SortOrder, int ByID)
	{
		Commands cmd = new Commands();
		int iResult = 0;
		string s = string.Empty;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.UpdateSortOrder(ID, SortOrder, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "UpdateMillSortOrder", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Upd Mill Sort Order", ID, ByID, ex.Message, 0, "UpdateMillSortOrder function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string UpdateUserExportData(int PgID, int ObjID, int UserID, string ExpFileNm, string ProdType, string ProdCode, string LocCode, string Reg, string Thick, string Spec, string Grade, string Season, string Surf,
			string Stat, int iType, string Wdth, string Len, string Color, string FSort, string Milling, string NoPrint, int OrderID, int ShipID, int LoadID, string Cust, string Vendor, string Supplier, string Mgr, int MgrID,
			int IncInven, int IncSales, int IncHolds, int IncProd, int IncCust, int IncHist, int IncPHist, string RollupItems, string FuzzyGrade, string FuzzySort, string FuzzyProd, string FuzzyMgr, string FuzzyCust, string Fuzzy6,
			string IName, string ICode, string IDesc, double Nbr, string Code1, string Code2, int id1, int id2, string TDt, string BDt, string EDt, string CustCode, string SubTotal, string Cmt, int Sort, int Active)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DateTime? dTDate = null;
			DateTime? dBDate = null;
			DateTime? dEDate = null;
			if (!String.IsNullOrWhiteSpace(TDt)) { dTDate = Convert.ToDateTime(TDt); }
			if (!String.IsNullOrWhiteSpace(BDt)) { dBDate = Convert.ToDateTime(BDt); }
			if (!String.IsNullOrWhiteSpace(EDt)) { dEDate = Convert.ToDateTime(EDt); }
			SalesFunctions sf = new SalesFunctions();
			DataTable dt = sf.UpdateSalesPlanDataExport(UserID, PgID, ObjID, ExpFileNm, ProdType, ProdCode, LocCode, Reg, Thick, Spec, Grade, Season, Surf, Stat, iType, Wdth, Len, Color, FSort, Milling, NoPrint, OrderID, ShipID, LoadID,
				Cust, Vendor, Supplier, Mgr, MgrID, IncInven, IncSales, IncHolds, IncProd, IncCust, IncHist, IncPHist, RollupItems, FuzzyGrade, FuzzySort, FuzzyProd, FuzzyMgr, FuzzyCust, Fuzzy6, IName, ICode, IDesc, Nbr, Code1, Code2,
				id1, id2, dTDate, dBDate, dEDate, CustCode, SubTotal, Cmt, Sort, Active);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, UserID, 1, "UpdateUserExportData", s.Length, UserID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Update User Exp", UserID, UserID, ex.Message, 0, "UpdateUserExportData function", UserID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string UpdateQueryAction(int PgID, int ObjID, int UserID,int QueryID, int iType, string Other, int ByID)
	{
		Commands cmd = new Commands();
		int iResult = 0;
		string s = string.Empty;
		try
		{
			DataTable dt = cmd.UpdateQueryAction(UserID, QueryID, iType, Other, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "UpdateQueryAction", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Upd Query Action", QueryID, ByID, ex.Message, 0, "UpdateQueryAction function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string UpdateUserQuery(int UserID, int QueryID, string QueryName, int PgID, int PgObjID, int PgNbr, int PgSize, string TDt, string BDt, string EDt, string UserName, string ProdType, string ProdCode,
		string LocCode, string Reg, string Thick, string Species, string Grade, string Seasoning, string Surface, string StatusCode, string Width, string Len, string Color, string fSort, string Milling, string NoPrint, int iType,
		int Set0, int Set1, int Set2, int Set3, int Set4, int Set5, int Set6, int Set7, int OrdID, int ShipID, int LoadID, string Cust, string Vend, string Supplr, string Mgr, int MgrID, int Sort, string ItemCode, string ItemName, string ItemDesc,
		double Nbr, string Code1, string Code2, int ID1, int ID2, string Comments, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DateTime? dTDate = null;
			DateTime? dBDate = null;
			DateTime? dEDate = null;
			if (!String.IsNullOrWhiteSpace(TDt)) { dTDate = Convert.ToDateTime(TDt); }
			if (!String.IsNullOrWhiteSpace(BDt)) { dBDate = Convert.ToDateTime(BDt); }
			if (!String.IsNullOrWhiteSpace(EDt)) { dEDate = Convert.ToDateTime(EDt); }
			DataTable dt = cmd.UpdateUserQuery(UserID, QueryID, QueryName, PgID, PgObjID, PgNbr, PgSize,dTDate, dBDate, dEDate, UserName, ProdType, ProdCode, LocCode, Reg, Thick, Species, Grade, Seasoning, Surface, StatusCode, 
				Width, Len, Color, fSort, Milling, NoPrint, iType, Set0, Set1, Set2, Set3, Set4, Set5, Set6, Set7, OrdID, ShipID, LoadID, Cust, Vend, Supplr, Mgr, MgrID, Sort, ItemCode, ItemName, ItemDesc, Nbr, Code1, Code2, ID1, ID2, Comments, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, QueryID, 1, "UpdateUserQuery", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Update Query", QueryID, ByID, ex.Message, 0, "UpdateUserQuery function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string UpdateWurthConversionData(int PgID, int ObjID, int ID, string Xrefnbr, string Cust, string CustNbr, string CustDesc, string WurthCode,  string PType, string ProdCode, string Desc, string Width, 
		string Len, string Color, string ExpPrgID, string Cert, string Sort, string Tolerance, string HPPcsPkg, string Milling, string NoPrint, string Resp, string Cmt, int iType, int Active, int ByID)
	{
		Commands cmd = new Commands();
		int iResult = 0;
		string s = string.Empty;
		try
		{
			ProductionFnc pf = new ProductionFnc();
			DataTable dt = pf.UpdateWurthConversionData(ID, Xrefnbr, Cust, CustNbr, CustDesc, WurthCode, PType, ProdCode, Desc, Width, Len, Color, ExpPrgID, Cert, Sort, Tolerance, HPPcsPkg, Milling, NoPrint, Resp, Cmt, iType, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "UpdateWurthConversionData", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Upd Wurth Data", ID, ByID, ex.Message, 0, "UpdateWurthConversionData function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

}
 