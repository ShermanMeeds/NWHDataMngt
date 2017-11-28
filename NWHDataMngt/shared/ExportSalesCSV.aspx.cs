using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using DataLayer;
using DataMngt;

namespace DataMngt.shared
{
	public partial class ExportCSV : System.Web.UI.Page
	{
		#region LocalVars
		private bool _Adm = false;
		private string _CBuildNbr = string.Empty;
		private string _ErrMsg = string.Empty;
		private int _FirstQtyCol = 0;
		//private bool _IsViewOnly = false;
		private int _NbrCols = 0; // ColCount;
		private int _NbrShownIdentCols = 0;
		private int _ObjectID = 0;
		private int _PageID = 0;
		private int _ReqPageID = 0;
		private string _UserName = "UNK";
		//private string _Version = "UNK";
		CurrentUser _user = null;
		private Browser _Browser = null;

		#endregion LocalVars

		#region PublicVars
		public string CBuildNbr
		{
			get { return _CBuildNbr; }
		}
		#endregion PublicVars

		protected void Page_Load(object sender, EventArgs e)
		{
			string FileName = string.Empty;
			int FirstNCol = 0;
			int FirstQtyCol = 0;
			int LastNCol = 0;
			string MyCSV = string.Empty;
			int NbrCols = 0;
			int NbrColsVisible = 0;
			DateTime now = DateTime.Now;
			int NoZeros = 0;
			string UIType = string.Empty;

			Response.Cache.SetCacheability(HttpCacheability.NoCache);
			Response.Cache.SetValidUntilExpires(true);
			Response.Expires = -1441;
			Response.ExpiresAbsolute = DateTime.Now;
			Response.CacheControl = "no-cache";
			Response.AddHeader("Pragma", "no-cache");
			Response.AddHeader("Pragma", "no-store");
			Response.AddHeader("cache-control", "no-cache");
			Response.Cache.SetNoServerCaching();

			_PageID = Convert.ToInt32(Request["p"]);
			_ObjectID = Convert.ToInt32(Request["q"]);

			_CBuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
			string logFile = System.Configuration.ConfigurationManager.AppSettings["AppLogFilePath"];

			string ips = System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
			_Browser = new Browser(System.Web.HttpContext.Current.Request, ips, "");

			string usrname = Request.ServerVariables["LOGON_USER"];
			_UserName = usrname;
			_user = new CurrentUser(usrname, logFile, ""); // SessionHelper.GetCurrentUser(Request.ServerVariables["LOGON_USER"]);

			// check for access
			if (_user == null)
			{
				//HttpContext.Current.Session["NoAccessMsg"] = "You do not have access to the Sales Plan portion of this application";
				HttpContext.Current.Response.Redirect("NoAccess.aspx", true);
			}
			if (_user.IsLoaded == false || _user.IsValid == false)
			{
				//HttpContext.Current.Session["NoAccessMsg"] = "You do not have high enough access to export data.";
				HttpContext.Current.Response.Redirect("NoAccess.aspx", true);
			}

			_ReqPageID = Convert.ToInt32(Request["p"]); // 58-Sales Plan, 55-CT
			_ObjectID = Convert.ToInt32(Request["oj"]);

			// ****************************************************************************
			try
			{
				int[] colvis = new int[41];
				if (_ReqPageID == 55 && _ObjectID == 1) { UIType = "ConsolCol"; }
				if (_ReqPageID == 58 && _ObjectID == 1) { UIType = "SPlnCols"; }
				if (_ReqPageID == 58 && _ObjectID == 2) { UIType = "SalesPFltr"; }

				// get data
				Commands cmd = new Commands();
				// ************** Get global settings ***********************
				DataTable uidata = cmd.SelectUserExportDataHdr(_user.UserID, _ReqPageID, _ObjectID, _user.UserID);
				if (uidata.Rows.Count > 0)
				{
					FileName = uidata.Rows[0]["ExportFileName"].ToString(); // "CAT_Availability_";
					LastNCol = Convert.ToInt32(uidata.Rows[0]["NbrColumns"]);
					FirstQtyCol = Convert.ToInt32(uidata.Rows[0]["FirstQtyCol"]);
					NoZeros = Convert.ToInt32(uidata.Rows[0]["Setting3"]);
				}
				else
				{
					FileName = "Generic Export for ";
				}
				FileName = FileName.Replace(" ", "_") + " " + now.ToString("yyyy-dd-MM") + ".csv";

				// ************** GET COLUMN FORMAT data ***********************
				//DataTable CDat = cmd.SelectUIColumnData(_ReqPageID, _ObjectID, _user.UserID);
				DataTable CDat = cmd.SelectUserInterfaceItems(_user.UserID, UIType, _user.UserID);
				NbrCols = CDat.Rows.Count;
				for (int itm = 0; itm < NbrCols; itm++)
				{
					colvis[itm] = Convert.ToInt32(CDat.Rows[itm]["IsVisible"]);
					if (colvis[itm] == 1) { NbrColsVisible++; }
					if (itm == FirstQtyCol) { FirstNCol = NbrColsVisible - 1; }
				}

				int ColCount = 0;
				for (int itm = 0; itm < NbrCols; itm++)
				{
					if (colvis[itm] == 1) { ColCount++; }
				}

				//_NbrCols = NbrCols; // ColCount;
				_NbrShownIdentCols = FirstNCol;
				_FirstQtyCol = FirstQtyCol;

				// Get raw list of data for export
				SalesFunctions sf = new SalesFunctions();
				DataTable dt = sf.SelectUserExportData(_user.UserID, _ReqPageID, _ObjectID, _user.UserID);
				// change table to CSV format
				if (dt.Rows.Count > 0)
				{
					MyCSV = ToCSV(dt, CDat, NbrCols, FirstQtyCol);
					// save CSV file
					HttpContext.Current.Response.AddHeader("content-disposition", String.Format("attachment; filename={0}", FileName));
					HttpContext.Current.Response.ContentType = "application/CSV";
					Response.ContentEncoding = Encoding.UTF8;
				}
				Response.Write(MyCSV);
				Response.Flush();
				Response.End();
			}
			catch (System.Threading.ThreadAbortException ext)
			{
				// nothing
			}
			catch (Exception ex)
			{
				//this.lblStatusMsg.Text = "Error: " + ex.Message;
			}
		}

		public static String ToCSV(DataTable dt, DataTable CDat, int NbrCols, int FirstQtyCol)
		{
			int[] colvis = new int[50];
			double fig = 0;
			int FirstNCol = 0;
			string Color = string.Empty;
			string Grade = string.Empty;
			double[] GrandTotals = new double[30];
			double[] Ptotal = new double[30];
			double[] PAtotal = new double[30];
			double[] Stotal = new double[30];
			double[] Ttotal = new double[30];
			double[] Gtotal = new double[30];
			double[] Ctotal = new double[30];
			double[] Sttotal = new double[30];
			double[] NPtotal = new double[30];
			string NoPrint = string.Empty;
			string prod = string.Empty;
			string prodA = string.Empty;
			string FSort = string.Empty;
			string spec = string.Empty;
			string Thickness = string.Empty;
			bool STProd = true;
			bool STProdA = false;
			bool STSpec = false;
			bool STThick = false;
			bool STGrade = false;
			bool STColor = false;
			bool STSort = false;
			bool STNoP = false;
			var sb = new StringBuilder();
			string s = string.Empty;
			try
			{
				if (dt.Rows.Count > 0)
				{
					// grab formatting data
					string SubTotals = dt.Rows[0]["SubTotals"].ToString();
					if (SubTotals.Length > 7)
					{
						if (SubTotals.Substring(1, 0) == "0") { STProd = false; }
						if (SubTotals.Substring(2, 1) == "1") { STProdA = true; }
						if (SubTotals.Substring(3, 1) == "1") { STSpec = true; }
						if (SubTotals.Substring(4, 1) == "1") { STThick = true; }
						if (SubTotals.Substring(5, 1) == "1") { STGrade = true; }
						if (SubTotals.Substring(6, 1) == "1") { STColor = true; }
						if (SubTotals.Substring(7, 1) == "1") { STSort = true; }
						if (SubTotals.Substring(8, 1) == "1") { STNoP = true; }
					}

					// establish column visibility
					//Add Header
					for (var x = 0; x < NbrCols; x++)
					{
						if (Convert.ToInt32(CDat.Rows[x]["IsVisible"]) == 1)
						{
							if (x != 0) sb.Append(","); // (";");
							sb.Append(CDat.Rows[x]["ColumnTitle"].ToString());
							if (x < FirstQtyCol)
							{
								FirstNCol++;
							}
						}
					}
					sb.AppendLine();

					//Add Rows
					foreach (DataRow row in dt.Rows)
					{
						if (STProd && prod != row["ProductCode"].ToString())
						{
							sb.AppendLine(GetTotalsRow(Ptotal, "Product Totals", FirstNCol, 10, 1));
							Ptotal = EmptyItemArray(Ptotal);
						}
						if (STProdA && prodA != row["ProductCode"].ToString() + " " + row["ItemLength"].ToString() + " " + row["Color"].ToString() + " " + row["Sort"].ToString() + " " + row["Milling"].ToString() + " " + row["NoPrint"].ToString())
						{
							sb.AppendLine(GetTotalsRow(PAtotal, "Product/Attribute Totals", FirstNCol, 5, 1));
							PAtotal = EmptyItemArray(PAtotal);
						}
						if (STSpec && spec != row["Specie"].ToString())
						{
							sb.AppendLine(GetTotalsRow(Stotal, "Species Totals", FirstNCol, 0, 1));
							Stotal = EmptyItemArray(Stotal);
						}
						if (STThick && Thickness != row["Thickness"].ToString())
						{
							sb.AppendLine(GetTotalsRow(Ttotal, "Thickness Totals", FirstNCol, 1, 1));
							Ttotal = EmptyItemArray(Ttotal);
						}
						if (STGrade && Grade != row["Grade"].ToString())
						{
							sb.AppendLine(GetTotalsRow(Gtotal, "Grade Totals", FirstNCol, 2, 1));
							Gtotal = EmptyItemArray(Gtotal);
						}
						if (STColor && Color != row["Color"].ToString())
						{
							sb.AppendLine(GetTotalsRow(Ctotal, "Color Totals", FirstNCol, 6, 1));
							Ctotal = EmptyItemArray(Ctotal);
						}
						if (STSort && FSort != row["Sort"].ToString())
						{
							sb.AppendLine(GetTotalsRow(Sttotal, "Sort Totals", FirstNCol, 7, 1));
							Sttotal = EmptyItemArray(Sttotal);
						}
						if (STNoP && NoPrint != row["NoPrint"].ToString())
						{
							sb.AppendLine(GetTotalsRow(NPtotal, "Sort Totals", FirstNCol, 9, 1));
							NPtotal = EmptyItemArray(NPtotal);
						}

						for (var c = 0; c < NbrCols; c++)
						{
							if (Convert.ToInt32(CDat.Rows[c]["IsVisible"]) == 1)
							{
								if (c != 0) sb.Append(","); //(";");
								sb.Append(row[dt.Columns[c]]);
								if (c >= FirstQtyCol)
								{
									fig = Convert.ToDouble(row[dt.Columns[c]]);
									if (STProd) { Ptotal[c - FirstNCol] = fig; }
									if (STProdA) { PAtotal[c - FirstNCol] = fig; }
									if (STSpec) { Stotal[c - FirstNCol] = fig; }
									if (STThick) { Ttotal[c - FirstNCol] = fig; }
									if (STGrade) { Gtotal[c - FirstNCol] = fig; }
									if (STColor) { Ctotal[c - FirstNCol] = fig; }
									if (STSort) { Sttotal[c - FirstNCol] = fig; }
									if (STNoP) { NPtotal[c - FirstNCol] = fig; }
									GrandTotals[c - FirstNCol] = fig;
								}
							}
						}
						sb.AppendLine();
						prod = row["ProductCode"].ToString();
						prodA = row["ProductCode"].ToString() + " " + row["ItemLength"].ToString() + " " + row["Color"].ToString() + " " + row["Sort"].ToString() + " " + row["Milling"].ToString() + " " + row["NoPrint"].ToString();
						spec = row["Specie"].ToString();
						Grade = row["Grade"].ToString();
						FSort = row["Sort"].ToString();
						Color = row["Color"].ToString();
						NoPrint = row["NoPrint"].ToString();
						Thickness = row["Thickness"].ToString();
					}
					// append grand totals
					for (var c2 = 0; c2 < NbrCols; c2++)
					{
						if (c2 < FirstQtyCol)
						{
							if (colvis[c2] == 1)
							{
								if (c2 != 0) sb.Append(","); //(";");
								if (c2 == 0)
								{
									sb.Append("Grand Totals");
								}
								else
								{
									sb.Append("");
								}
							}
						}
						else
						{
							sb.Append(GenUtilities.FormatNbrSpecial(GrandTotals[c2 - FirstNCol], "", 1, ",", ".", 0));
						}
					}
					sb.AppendLine();
				}
				return sb.ToString();
			}
			catch (Exception ex)
			{
				return "Error encounterd: " + ex.Message;
			}
		}

		public static string GetTotalsRow(double[] totals, string lbl, int NbrPreCols, int LblCol, int prec)
		{
			var sb = new StringBuilder();
			if (LblCol > 0)
			{
				for (int c = 0; c < LblCol; c++)
				{
					sb.Append(",");
				}
			}
			sb.Append(lbl + ",");
			for (int c = LblCol+1; c < NbrPreCols; c++)
			{
				sb.Append(",");
			}
			for (int i = 0; i <= 17; i++)
			{
				sb.Append("," + GenUtilities.FormatNbrSpecial(totals[i], "", 1, ",", ".", prec));
			}
			return sb.ToString();
		}

		public static double[] EmptyItemArray(double[] a)
		{
			for (int i = 0; i < a.Length; i++)
			{
				a[i] = 0;
			}
			return a;
		}
	}
}