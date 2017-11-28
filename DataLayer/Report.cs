using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DataLayer
{
	public class ReportData
	{

		public int ExportReportGridAsExcel(int RptID, int ByID, DataTable MyParams)
		{
			DBInterface di = new DBInterface();
			SqlParameter p;
			int iCount = 0;
			string MyValue = "";
			SqlParameter[] cParams = new SqlParameter[24];
			using (DataTable dt = MyParams)
			{
				if (dt.Rows.Count > 0)
				{
						foreach (DataRow rw in dt.Rows)
					{
						MyValue = GetParamItem(MyParams, rw["ParamName"].ToString());
						p = new SqlParameter(rw["ParamName"].ToString(), MyValue);
						cParams[iCount] = p;
						iCount++;
					}
				}
			}
			return di.RunSPReturnInteger("dbo.up_ReportGeneration", cParams);
		}

		public DataTable GetReportForExcelExport(int RptID, int ByID, DataTable MyParams)
		{
			DBInterface di = new DBInterface();
			SqlParameter p;
			int iCount = 0;
			string MyValue = "";
			SqlParameter[] cParams = new SqlParameter[26];
			using (DataTable dt = MyParams)
			{
				if (dt.Rows.Count > 0)
				{
					foreach (DataRow rw in dt.Rows)
					{
						MyValue = GetParamItem(MyParams, rw["ParamName"].ToString());
						p = new SqlParameter(rw["ParamName"].ToString(), MyValue);
						cParams[iCount] = p;
						iCount++;
					}
				}
			}
			return di.RunSPReturnDataTable("dbo.up_ReportGeneration", cParams);
		}

		public DataTable GetDeptList(int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Sort", 0);
			SqlParameter p2 = new SqlParameter("@AccountID", 1);
			SqlParameter p3 = new SqlParameter("@ShowAll", 0);
			return di.RunSPReturnDataTable("dbo.up_GetDepartmentList", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable GetGroupList(int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@GroupID", 0);
			SqlParameter p2 = new SqlParameter("@Active", 2);
			SqlParameter p3 = new SqlParameter("@Sort", 0);
			SqlParameter p4 = new SqlParameter("@ShowNone", 0);
			SqlParameter p5 = new SqlParameter("@ShowAll", 0);
			SqlParameter p6 = new SqlParameter("@ShowNonPublic", 0);
			return di.RunSPReturnDataTable("dbo.up_GetGroupsList", new SqlParameter[] { p1, p2, p3, p4, p5, p6 });
		}

		public DataTable GetLocationList(int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Sort", 0);
			SqlParameter p2 = new SqlParameter("@AccountID", 1);
			SqlParameter p3 = new SqlParameter("@ShowAll", 1);
			SqlParameter p4 = new SqlParameter("@ShowNone", 0);
			SqlParameter p5 = new SqlParameter("@UsedOnly", 1);
			SqlParameter p6 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTable("dbo.up_GetLocationsList", new SqlParameter[] { p1, p2, p3, p4, p5, p6 });
		}

		public string GetParamItem(DataTable MyParams, string ParamName)
		{
			string Item = "";
			string PName = "";
			int iLoop = 0;
			bool IsFound = false;
			for (iLoop = 0; iLoop < MyParams.Rows.Count; iLoop++)
			{
				PName = MyParams.Rows[iLoop]["ParamName"].ToString();
				if (PName == ParamName && IsFound == false)
				{
					Item = MyParams.Rows[iLoop]["ParamValue"].ToString();
					IsFound = true;
				}
			}
			return Item;
		}

		public DataTable GetProjectList(int Mine, int AllowSurrogates, int ByID)
		{
			if (Mine > 1) { Mine = 1; }
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Sort", 0);
			SqlParameter p2 = new SqlParameter("@ProjID", 0);
			SqlParameter p3 = new SqlParameter("@ProjCode", "");
			SqlParameter p4 = new SqlParameter("@ProjName", "");
			SqlParameter p5 = new SqlParameter("@MgrFirstName", "");
			SqlParameter p6 = new SqlParameter("@MgrLastName", "");
			SqlParameter p7 = new SqlParameter("@MineOnly", Mine);
			SqlParameter p8 = new SqlParameter("@AllowSurrogates", AllowSurrogates);
			SqlParameter p9 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTable("dbo.up_GetProjectList4", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7, p8, p9 });
		}

		public DataTable GetProjectTaskList(int ProjID, int Sort, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ProjID", ProjID);
			SqlParameter p2 = new SqlParameter("@Active", 1);
			SqlParameter p3 = new SqlParameter("@SelfAssign", 0);
			SqlParameter p4 = new SqlParameter("@Sort", Sort);
			SqlParameter p5 = new SqlParameter("@AcctID", 1);
			SqlParameter p6 = new SqlParameter("@ExcludeTaskID", 0);
			SqlParameter p7 = new SqlParameter("@By", ByID.ToString());
			return di.RunSPReturnDataTable("dbo.up_GetProjectTaskList", new SqlParameter[] { p1, p2, p3, p4, p5, p6, p7 });
		}

		public DataTable GetReportAttributes(int RptID, int ByID) 
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ReportID", RptID);
			SqlParameter p2 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTable("dbo.up_GetReportAttributes", new SqlParameter[] { p1, p2 });
		}

		public DataTable GetReportColumnData(int RptID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ReportID", RptID);
			SqlParameter p2 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTable("dbo.up_GetReportColumns", new SqlParameter[] { p1, p2 });
		}

		public DataTable GetReportList(int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTable("dbo.up_GetReportList", new SqlParameter[] { p1 });
		}

		public DataTable GetReportLogEntry(int RptID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ReportID", RptID);
			SqlParameter p2 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTable("dbo.up_GetReportLogEntry", new SqlParameter[] { p1, p2 });
		}

		public DataTable GetReportParameters(int RptID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ReportID", RptID);
			SqlParameter p2 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTable("dbo.up_GetReportParameters", new SqlParameter[] { p1, p2 });
		}

		public DataTable GetReportRowData(int RptID, int ByID, DataTable MyParams)
		{
			SqlParameter p;
			int iCount = 0;
			string MyValue = "";
			DBInterface di = new DBInterface();
			SqlParameter[] cParams = new SqlParameter[35];
			using (DataTable dt = MyParams)
			{
				if (dt.Rows.Count > 0)
				{
						foreach (DataRow rw in dt.Rows)
					{
						MyValue = GetParamItem(MyParams, rw["ParamName"].ToString());
						p = new SqlParameter(rw["ParamName"].ToString(), MyValue);
						cParams[iCount] = p;
						iCount++;
					}
				}
			}
			return di.RunSPReturnDataTable("dbo.up_ReportGeneration", cParams);
		}

		public DataTable GetReportDataFromSQL(string Sql)
		{
			DBInterface di = new DBInterface();
			return di.RunSPReturnDataTableS(Sql);
		}

		public DataTable GetReportDataFromSQLDW(string Sql)
		{
			DBInterface di = new DBInterface();
			return di.RunSPReturnDataTableSNWHDW(Sql);
		}

		public DataTable GetReportSortList(int RptID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ReportID", RptID);
			SqlParameter p2 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTable("dbo.up_GetReportSortList", new SqlParameter[] { p1, p2 });
		}

		public DataTable GetReportSubGroupingList(int RptID, int ParamID, int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ReportID", RptID);
			SqlParameter p2 = new SqlParameter("@ParameterID", ParamID);
			SqlParameter p3 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTable("dbo.up_GetReportParameterSubGroupList", new SqlParameter[] { p1, p2, p3 });
		}

		public DataTable GetRoleList(int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p2 = new SqlParameter("@AccountID", 1);
			SqlParameter p1 = new SqlParameter("@Sort", 0);
			SqlParameter p3 = new SqlParameter("@Active", 2);
			SqlParameter p4 = new SqlParameter("@ForProj", 1);
			SqlParameter p5 = new SqlParameter("@IncludeSituational", 0);
			SqlParameter p6 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTable("dbo.up_GetRoleList", new SqlParameter[] { p1, p2, p3, p4, p5, p6 });
		}

		public DataTable GetStatusList(int iType, int ByID) 
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@Type", iType);
			SqlParameter p2 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTable("dbo.up_GetStatusCodeList", new SqlParameter[] { p1, p2 });
		}

		public DataTable GetSupervisorList(int ByID)
		{
			DBInterface di = new DBInterface();
			SqlParameter p1 = new SqlParameter("@ByID", ByID);
			return di.RunSPReturnDataTable("dbo.up_GetSupervisorsList", new SqlParameter[] { p1 });
		}

	}
}
