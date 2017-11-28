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
public class AdminServices : System.Web.Services.WebService
{

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string DeleteEmailAddress(int PgID, int ObjID, int EmailAddrID, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.DeleteManagementItem(EmailAddrID, 3, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "DeleteEmailAddress", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Del Email Addr", EmailAddrID, ByID, ex.Message, 0, "DeleteEmailAddress function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string DeleteProcessOwner(int PgID, int ObjID, int ID, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.UpdateProcessOwner(ID, 1, 3, 1, 0, 1, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "DeleteProcessOwner", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Del Email Addr", ID, ByID, ex.Message, 0, "DeleteProcessOwner function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string GetControlValue(int PgID, int ObjID, int iType, int ID1, int ID2, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.GetControlValue(iType, ID1, ID2, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "GetControlValue", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("ControlValue", iType, ByID, ex.Message, 0, "GetControlValue function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string GetUserDocRights(int PgID, int ObjID, string DocType, int RequestID, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.GetUserDocRights(DocType, RequestID, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "GetUserDocRights", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("User Doc Rights", ByID, ByID, ex.Message, 0, "GetUserDocRights function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectAdministrativeLogs(int PgID, int ObjID, int LogTypeID, string AppName, string DBName, string Schema, string Subj, string Body, string sTDateB, string sTDateE, int TargetID, int ErrID, int ID, string sID, int Sort,
		int PgNbr, int PgSize, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DateTime? tdateB = null;
			DateTime? tdateE = null;
			if (sTDateB != "") { tdateB = Convert.ToDateTime(sTDateB); }
			if (sTDateE != "") { tdateE = Convert.ToDateTime(sTDateE); }
			GenManage gm = new GenManage();
			DataTable dt = gm.SelectAdministrativeLogs(LogTypeID, AppName, DBName, Schema, Subj, Body, tdateB, tdateE, TargetID, ErrID, ID, sID, Sort, PgNbr, PgSize, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectAdministrativeLogs", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Admin Logs", LogTypeID, ByID, ex.Message, 0, "SelectAdministrativeLogs function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectAppAreaList(int PgID, int ObjID, int ID, string AppCode, string AreaCode, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.SelectAppAreaList(ID, AppCode, AreaCode, Sort, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectAppAreaList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Email Template List", ID, ByID, ex.Message, 0, "SelectAppAreaList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectApplicationList(int PgID, int ObjID, int ID, int Sort, int Current, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.SelectApplicationList(ID, Sort, Current, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectApplicationList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("App List", ID, ByID, ex.Message, 0, "SelectApplicationList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectBusinessCodeList(int PgID, int ObjID, string BCClass, string CodeGrp, int Active, int Shown, int Sort, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.SelectBusinessCodeList(BCClass, CodeGrp, Active, Shown, Sort, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectBusinessCodeList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Bus Code List", 0, ByID, ex.Message, 0, "SelectBusinessCodeList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectCalendarEvents(int PgID, int ObjID, int CalType, int Yr, int Mo, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.SelectCalendarEvents(CalType, Yr, Mo, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectCalendarEvents", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Calendar Events", Yr, ByID, ex.Message, 0, "SelectCalendarEvents function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}
 
	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectCodeValueList(int PgID, int ObjID, int PageID, int ObjectID, int CodeID, string CodeValue, string CdName, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.SelectCodeValueList(PageID, ObjectID, CodeID, CodeValue, CdName, Sort, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectCodeValueList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Code Value List", 0, ByID, ex.Message, 0, "SelectCodeValueList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectDesignComponentList(int PgID, int ObjID, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.SelectDesignComponentList(Sort, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectDesignComponentList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Design Comp List", 0, ByID, ex.Message, 0, "SelectDesignComponentList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectDocStatusFlow(int PgID, int ObjID, string DocTypeCode, int RowID, string OldStat, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.SelectDocStatusFlow(DocTypeCode, RowID, OldStat, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectDocStatusFlow", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Doc Status Flow", 0, ByID, ex.Message, 0, "SelectDocStatusFlow function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectEmailAddressList(int PgID, int ObjID, int NotifID, int Error, string AddrType, int Active, int Sort, int PgNbr, int PgSize, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.SelectEmailAddressList(NotifID, Error, AddrType, Active, Sort, PgNbr, PgSize, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectEmailAddressList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Email Template List", NotifID, ByID, ex.Message, 0, "SelectEmailAddressList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectEmailAddresses(int PgID, int ObjID, string AppCode, string GrpCode, int IncAdmin, int IncGlobal, int IncNbr, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.SelectEmailAddresses(AppCode, GrpCode, IncAdmin, IncGlobal, IncNbr, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectEmailAddresses", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Email Addresses", 0, ByID, ex.Message, 0, "SelectEmailAddresses function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectEmailTemplateList(int PgID, int ObjID, int TemplateID, string Code, string Name, string Subj, string Body, int Sort, int Active, int PgNbr, int PgSize, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.SelectEmailTemplateList(TemplateID, Code, Name, Subj, Body, Sort, Active, PgNbr, PgSize, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectConsolidationLocationList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Email Template List", TemplateID, ByID, ex.Message, 0, "SelectConsolidationLocationList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectEmailRecords(int PgID, int ObjID, int DBID, int SentOnly, int Sort, int PgNbr, int PgSize, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.SelectEmailRecords(DBID, "DataMngt", SentOnly, Sort, PgNbr, PgSize, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectEmailRecords", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Email Template List", 0, ByID, ex.Message, 0, "SelectEmailRecords function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectEventLogList(int PgID, int ObjID, string AppName, string Title, int Action, string TableNm, int RowID, string sDateB, string sDateE, int LogEmpID, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			//SalesFunctions sf = new SalesFunctions();
			DataTable dt = cmd.SelectEventLogList(AppName, Title, Action, TableNm, RowID, sDateB, sDateE, LogEmpID, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectEventLogList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Event Log List", 0, ByID, ex.Message, 0, "SelectEventLogList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectIssueClassList(int PgID, int ObjID, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.SelectIssueClassList(Sort, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectIssueClassList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Issue Class List", Sort, ByID, ex.Message, 0, "SelectIssueClassList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectIssuesList(int PgID, int ObjID, int ID, int Class, int iType, int AppArea, int DesignComp, string bdt, string edt, string ByPers, int Sort, int Active, int PgNbr, int PgSize, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.SelectIssuesList(ID, Class, iType, AppArea, DesignComp, bdt, edt, ByPers, Sort, Active, PgNbr, PgSize, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectIssuesList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Issues List", ID, ByID, ex.Message, 0, "SelectIssuesList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectIssueTypeList(int PgID, int ObjID, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.SelectIssueTypeList(Sort, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectIssueTypeList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Issue Type List", Sort, ByID, ex.Message, 0, "SelectIssueTypeList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectLocationList(int PgID, int ObjID, string Loc, string LocType, string Region, string Country, string City, int Class, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.SelectLocationList(Loc, LocType, Region, Country, City, Class, Sort, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectLocationList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Location List", 0, ByID, ex.Message, 0, "SelectLocationList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectLocationListDW(int PgID, int ObjID, string Loc, string LocType, string Region, string Country, string St, string City, int Class, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.SelectLocationListDW(Loc, LocType, Region, Country, St, City, Class, Sort, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectLocationListDW", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Location List DW", 0, ByID, ex.Message, 0, "SelectLocationListDW function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectLocationListL(int PgID, int ObjID, string Loc, string LocType, string Country, string City, int Class, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.SelectLocationListL(Loc, LocType, Country, City, Sort, Class, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectLocationListL", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Location List L", 0, ByID, ex.Message, 0, "SelectLocationListL function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectLocationListM(int PgID, int ObjID, string Region, string Loc, string LocType, string Country, string City, int Class, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.SelectLocationListM(Region, Loc, LocType, Country, City, Sort, Class, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectLocationListM", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Location List M", 0, ByID, ex.Message, 0, "SelectLocationListM function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectLocationListSpecial(int PgID, int ObjID, int UserID, string Reg, string AppArea, string Loc, string LocType, string Country, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.SelectLocationListSpecial(UserID, Reg, AppArea, Loc, LocType, Country, Sort, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectLocationListSpecial", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Loc List Special", 0, ByID, ex.Message, 0, "SelectLocationListSpecial function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}
 
	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectMenuItemList(int PgID, int ObjID, int Section, int Item, string Nm, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.SelectMenuItemList(Section, Item, Nm, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectMenuItemList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Menu Item List", 0, ByID, ex.Message, 0, "SelectMenuItemList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectNotificationsList(int PgID, int ObjID, int Sort, int PgNbr, int PgSize, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.SelectNotificationsList(Sort, PgNbr, PgSize, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectNotificationsList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Notifications List", Sort, ByID, ex.Message, 0, "SelectNotificationsList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectPageList(int PgID, int ObjID, int PageID, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.SelectPageList(PageID, Sort, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectPageList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Page List", PgID, ByID, ex.Message, 0, "SelectPageList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectPageObjectList (int PgID, int ObjID, int iType, int PageID, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.SelectPageObjectList(iType, PageID, Sort, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectPageList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Page List", PgID, ByID, ex.Message, 0, "SelectPageList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectPageRightsList(int PgID, int ObjID, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.SelectPageRightsList(PgID, ObjID, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectPageRightsList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Page Rights List", PgID, ByID, ex.Message, 0, "SelectPageRightsList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectProcessList(int PgID, int ObjID, int ProcID, int Sort, int Active, int PgNbr, int PgSize, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.SelectProcessList(ProcID, Sort, Active, PgNbr, PgSize, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectProcessList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Process List", Sort, ByID, ex.Message, 0, "SelectProcessList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectProcessOwnerList(int PgID, int ObjID, int ProcID, int UserID, string sName, int Sort, int Active, int PgNbr, int PgSize, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.SelectProcessOwnerList(ProcID, UserID, sName, Sort, Active, PgNbr, PgSize, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectProcessOwnerList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Process Owner List", Sort, ByID, ex.Message, 0, "SelectProcessOwnerList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectProcessSettings(int PgID, int ObjID, int ProcID, int DbID, string SeqCode, int Sort, int Active, int PgNbr, int PgSize, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.SelectProcessSettings(ProcID, DbID, SeqCode, Sort, Active, PgNbr, PgSize, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectProcessSettings", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Proc Settings", ByID, ByID, ex.Message, 0, "SelectProcessSettings function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectProcessStatusList(int PgID, int ObjID, int ProcID, int UserID, int SeqType, int Sort, int Active, int PgNbr, int PgSize, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.SelectProcessStatusList(ProcID, UserID, SeqType, Sort, Active, PgNbr, PgSize, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectProcessStatusList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Proc Status List", Sort, ByID, ex.Message, 0, "SelectProcessStatusList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectSettingList(int PgID, int ObjID, string AppArea, int ID, int Sort, int Active, int PgNbr, int PgSize, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.SelectSettingList(AppArea, ID, Sort, Active, PgNbr, PgSize, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectSettingList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Settings List", ID, ByID, ex.Message, 0, "SelectSettingList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectSortOrderList(int PgID, int ObjID, int UserID, string AppArea, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.SelectSortOrderList(UserID, AppArea, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectSortOrderList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Sort Order List", 0, ByID, ex.Message, 0, "SelectSortOrderList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectUserGroupList(int PgID, int ObjID, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.SelectUserGroupList(0, "", Sort, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectUserGroupList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("User Group List", ByID, ByID, ex.Message, 0, "SelectUserGroupList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectUserList(int PgID, int ObjID, int ID, string Name, string Ctry, string City, string Loc, string Pos, string Grp, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.SelectUserList(ID, Name, Ctry, City, Loc, Pos, Grp, Sort, Active, 0, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectUserList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("User List", ByID, ByID, ex.Message, 0, "SelectUserList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}  

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectUserLocationAccessList(int PgID, int ObjID, int UserID, string Grp, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.SelectUserLocationAccessList(UserID, Grp, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectUserLocationAccessList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("User Loc Access List", UserID, ByID, ex.Message, 0, "SelectUserLocationAccessList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectUserPageColSettings(int PgID, int ObjID, int UserID, string UIType, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.SelectUserPageColSettings(UserID, UIType, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectUserPageColSettings", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("User Group List", UserID, ByID, ex.Message, 0, "SelectUserPageColSettings function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectWebAppSetting(int PgID, int ObjID, string AppArea, int DBID, string Code, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.GetWebAppSetting(AppArea, DBID, Code, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectWebAppSetting", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("App Code Value", 0, ByID, ex.Message, 0, "SelectWebAppSetting function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}
	
	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SelectWebCodeList(int PgID, int ObjID, string CodeGrp, int Sort, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			DataTable dt = cmd.SelectWebCodeList(CodeGrp, Sort, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SelectWebCodeList", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Web Code List", 0, ByID, ex.Message, 0, "SelectWebCodeList function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string SendEmail(int PgID, int ObjID, string AppCode, int EmailID, string TemplateCode, string EmailTo, string EmailCC, string EmailBCC, string Grp, string Subj, string Body, string Impt, string Sens, string Fmt,
			int LogEmail, string EmpIDs, int Active, int ByID)
	{
		Commands cmd = new Commands();
		string s = string.Empty;
		int iResult = 0;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.SendEmailFromApp(AppCode, EmailID, TemplateCode, EmailTo, EmailCC, EmailBCC, Grp, Subj, Body, Impt, Sens, Fmt, LogEmail, EmpIDs, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "SendEmail", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Send Email", EmailID, ByID, ex.Message, 0, "SendEmail function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string UpdateAppAreaSetting(int PgID, int ObjID, int ID, int iType, string Value, int ByID)
	{
		Commands cmd = new Commands();
		int iResult = 0;
		string s = string.Empty;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.UpdateAppAreaSetting(ID, iType, Value, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "UpdateAppAreaSetting", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Update AppArea Setting", ID, ByID, ex.Message, 0, "UpdateAppAreaSetting function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string UpdateEmailAddress(int PgID, int ObjID, int EmailAddrID, string EmailAddr, int UserID, int NotifTypeID, int ErrorID, string EmailAddrType, int Active, int ByID)
	{
		Commands cmd = new Commands();
		int iResult = 0;
		string s = string.Empty;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.UpdateEmailAddress(EmailAddrID, EmailAddr, UserID, NotifTypeID, ErrorID, EmailAddrType, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "UpdateEmailAddress", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Update Email Addr", EmailAddrID, ByID, ex.Message, 0, "UpdateEmailAddress function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string UpdateEmailTemplate(int PgID, int ObjID, int TemplateID, string Code, string Name, string Subj, string Body, int TransType, int NotifType, string EmailToType, string Importance, string Sensitivity, int IncUser, int IncMgr,
		int IncLoc, int IncProd, int IncSKU, int IncEnt, int IncTrans, string Fmt, int Active, int ByID)
	{
		Commands cmd = new Commands();
		int iResult = 0;
		string s = string.Empty;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.UpdateEmailTemplate(TemplateID, Code, Name, Subj, Body, TransType, NotifType, EmailToType, Importance, Sensitivity, IncUser, IncMgr, IncLoc, IncProd, IncSKU, IncEnt, IncTrans, Fmt, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "UpdateEmailTemplate", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("upd Email Template", TemplateID, ByID, ex.Message, 0, "UpdateEmailTemplate function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string UpdateNotificationType(int PgID, int ObjID, int ID, string Code, string sType, int SendIfNoData, string AfterActSQL, int Active, int ByID)
	{
		Commands cmd = new Commands();
		int iResult = 0;
		string s = string.Empty;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.UpdateNotificationType(ID, Code, sType, SendIfNoData, AfterActSQL, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "UpdateNotificationType", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Update Notif Type", ID, ByID, ex.Message, 0, "UpdateNotificationType function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string UpdateProcess(int PgID, int ObjID, int ID, string Code, string sName, int PTypeID, string Sched, string JobName, string SPName, string RerunSP, int SrcType, int UpdType, int Active, int ByID)
	{
		Commands cmd = new Commands();
		int iResult = 0;
		string s = string.Empty;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.UpdateProcess(ID, Code, sName, PTypeID, Sched, JobName, SPName, RerunSP, SrcType, UpdType, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "UpdateProcess", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Update Process", ID, ByID, ex.Message, 0, "UpdateProcess function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string UpdateProcessOwner(int PgID, int ObjID, int ID, int OwnerID, int ProcID, int iType, int Mand, int Active, int ByID)
	{
		Commands cmd = new Commands();
		int iResult = 0;
		string s = string.Empty;
		try
		{
			GenManage gm = new GenManage();
			DataTable dt = gm.UpdateProcessOwner(ID, OwnerID, ProcID, iType, Mand, Active, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "UpdateProcessOwner", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Update Process Owner", ID, ByID, ex.Message, 0, "UpdateProcessOwner function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

	[WebMethod]
	[ScriptMethod(UseHttpGet = false, ResponseFormat = ResponseFormat.Json)]
	public string UpdateUserRightLevel(int PgID, int ObjID, int ID, int UserID, string GroupCode, int RightLevel, int PageID, int ByID)
	{
		Commands cmd = new Commands();
		int iResult = 0;
		string s = string.Empty;
		try
		{
			DataTable dt = cmd.UpdateUserRightLevel(ID, UserID, GroupCode, RightLevel, PageID, ByID);
			s = GenUtilities.JSON(dt);
			iResult = cmd.LogAjaxCall(PgID, ObjID, 1, "UpdateUserRightLevel", s.Length, ByID);
			return s;
		}
		catch (Exception ex)
		{
			iResult = cmd.LogApplicationError("Update Process", UserID, ByID, ex.Message, 0, "UpdateUserRightLevel function", ByID);
			JavaScriptSerializer js = new JavaScriptSerializer();
			var response = new { success = "false", message = ex.Message };
			return response.ToJSON();
		}
	}

}
