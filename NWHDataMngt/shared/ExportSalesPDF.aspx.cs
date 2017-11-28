using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Drawing;
using System.Configuration;
using System.Text.RegularExpressions;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using System.IO;
using DataLayer;
using DataMngt;
using DataMngt.MyCode;

namespace DataMngt.shared
{
	public partial class ExportPDF : System.Web.UI.Page
	{
		#region LocalVars
		private string _CBuildNbr = string.Empty;
		private double[] _Ctotal = new double[41];
		private string _ErrMsg = string.Empty;
		private static int _FirstQtyCol = 0;
		private string[] _ForeValues = new string[14];
		private double[] _GrandTotals = new double[41];
		private double[] _Gtotal = new double[41];
		private string[] _LastValues = new string[14];
		private static int _NbrCols = 0;
		private static int _NbrShownIdentCols = 0;
		private double[] _NPtotal = new double[41];
		private int _PageID = 0;
		private double[] _PAtotal = new double[41];
		private static double[] _PgTotals = new double[41];
		private double[] _Ptotal = new double[41];
		private int _ObjectID = 0;
		private double[] _Stotal = new double[41];
		private double[] _Sttotal = new double[41];
		string[] SValues = new string[50];
		private double[] _Ttotal = new double[41];
		private int _ReqPageID = 0;
		private string _UserName = "UNK";
		private static float[] _widths;
		CurrentUser _user = null;
		private Browser _Browser = null;
		#endregion LocalVars

		#region PublicVars
		public string CBuildNbr
		{
			get { return _CBuildNbr; }
		}
		public double[] ProdTotals
		{
			get { return _Ptotal; }
			set { _Ptotal = value; }
		}

		public static int NbrShownIdentCols
		{
			get { return _NbrShownIdentCols; }
		}

		public static int NbrPgCols
		{
			get { return _NbrCols; }
		}
		
		public static int FirstQtyColNbr
		{
			get { return _FirstQtyCol;  }
		}
		
		public static float[] ColumnWidths
		{
			get { return _widths; }
		}
		#endregion PublicVars

		protected void Page_Load(object sender, EventArgs e)
		{
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
			// establish user data
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

			ExportGridToPDF();
		}

		private void ExportGridToPDF()
		{
			//this.lblErrorMsg.Text = "";
			try
			{
				string CellVal = string.Empty;
				string Color = string.Empty;
				int CurrentRow = 0;
				int FirstNCol = 14;
				int FirstQtyCol = 14;
				int LastNCol = 39;
				int Excl0 = 0;
				int ExclDups = 1;
				double fig = 0;
				string FileName = string.Empty;
				string ForeVal = string.Empty;
				string FSort = string.Empty;
				string Grade = string.Empty;
				string GradeID = string.Empty;
				string LocID = string.Empty;
				int NbrColsVisible = 0;
				string NextVal = string.Empty;
				string NoPrint = string.Empty;
				int NoZeros = 0;
				DateTime now = DateTime.Now;
				string prod = string.Empty;
				string prodA = string.Empty;
				string Product = string.Empty;
				string Reg = string.Empty; // this.lbxRegionF.SelectedValue;
				string Region = string.Empty;
				string RollupItems = string.Empty;
				string s = string.Empty;
				string spec = string.Empty;
				string SpecID = string.Empty;
				bool STProd = true;
				bool STProdA = false;
				bool STSpec = false;
				bool STThick = false;
				bool STGrade = false;
				bool STColor = false;
				bool STSort = false;
				bool STNoP = false;
				string SubTotals = string.Empty;
				string Thickness = string.Empty;
				int TotalsLast = 0;
				string UIType = string.Empty;

				PdfPCell cell;
				int[] colvis = new int[41];
				if (_ReqPageID == 55 && _ObjectID == 1) { UIType = "ConsolCol"; }
				if (_ReqPageID == 58 && _ObjectID == 1) { UIType = "SPlnCols"; }
				if (_ReqPageID == 58 && _ObjectID == 2) { UIType = "SalesPFltr"; }
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
				FileName = FileName + " " + now.ToString("yyyy-dd-MM");

				// ************** GET COLUMN FORMAT data ***********************
				//DataTable CDat = cmd.SelectUIColumnData(_ReqPageID, _ObjectID, _user.UserID);
				DataTable CDat = cmd.SelectUserInterfaceItems(_user.UserID, UIType, _user.UserID);
				int NbrCols = CDat.Rows.Count;
				for (int itm = 0; itm < NbrCols; itm++)
				{
					colvis[itm] = Convert.ToInt32(CDat.Rows[itm]["IsVisible"]);
					if (colvis[itm] == 1) { NbrColsVisible++; }
					if (itm == FirstQtyCol) { FirstNCol = NbrColsVisible - 1; }
				}
				_widths = new float[NbrColsVisible]; // { 76, 76, 80, 74, 79, 72, 72, 76, 58, 40, 60, 72, 136, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66 };

				int ColCount = 0;
				for (int itm = 0;itm < NbrCols;itm++)
				{
					if (colvis[itm] == 1) {
						_widths[ColCount] = Convert.ToInt32(CDat.Rows[itm]["ColumnWidth"]);
						ColCount++;
					}
				}

				_NbrCols = LastNCol; // ColCount;
				_NbrShownIdentCols = FirstNCol;
				_FirstQtyCol = FirstQtyCol;

				// Get raw list of data for export
				SalesFunctions sf = new SalesFunctions();
				DataTable dt = sf.SelectUserExportData(_user.UserID, _ReqPageID, _ObjectID, _user.UserID);
				if (dt.Rows.Count > 0)
				{
					int cols = dt.Columns.Count;
					int rows = dt.Rows.Count;
					RollupItems = dt.Rows[0]["RollupCols"].ToString();
					if (_ReqPageID == 58 && _ObjectID == 1)
					{
						SubTotals = dt.Rows[0]["SubTotals"].ToString();
						if (SubTotals.Substring(1, 0) == "0") { STProd = false; }
						if (SubTotals.Substring(2, 1) == "1") { STProdA = true; }
						if (SubTotals.Substring(3, 1) == "1") { STSpec = true; }
						if (SubTotals.Substring(4, 1) == "1") { STThick = true; }
						if (SubTotals.Substring(5, 1) == "1") { STGrade = true; }
						if (SubTotals.Substring(6, 1) == "1") { STColor = true; }
						if (SubTotals.Substring(7, 1) == "1") { STSort = true; }
						if (SubTotals.Substring(8, 1) == "1") { STNoP = true; }
					}
					string parag = FileName; // + " " + now.ToString("yyyy-dd-MM");

					// ***************************************************************************************
					// create PDF document object
					Document pdfDoc = new Document(PageSize.LETTER.Rotate(), 30, 30, 46, 30);
					System.IO.MemoryStream mStream = new System.IO.MemoryStream();
					PdfWriter writer = PdfWriter.GetInstance(pdfDoc, mStream);
					iTextSharp.text.Font font5 = iTextSharp.text.FontFactory.GetFont(FontFactory.HELVETICA, 5);
					// Our custom Header and Footer is done using Event Handler
					TwoColumnHeaderFooter PageEventHandler = new TwoColumnHeaderFooter();
					writer.PageEvent = PageEventHandler;
					// Define the page header
					PageEventHandler.Title = parag;
					PageEventHandler.HeaderFont = FontFactory.GetFont(BaseFont.COURIER_BOLD, 10, iTextSharp.text.Font.BOLD);
					//PageEventHandler.HeaderLeft = "Group";
					//PageEventHandler.HeaderRight = "1";
					pdfDoc.Open();
					
					// create PDF table object
					PdfPTable pdfTable = new PdfPTable(NbrColsVisible);
					pdfTable.DefaultCell.BorderWidth = 1;
					pdfTable.DefaultCell.Padding = 1;
					//PdfPRow row = null;
					//float[] widths = new float[] { 76, 76, 80, 74, 79, 72, 72, 76, 58, 40, 60, 72, 136, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66, 66 };
					pdfTable.SetWidths(_widths);
					pdfTable.WidthPercentage = 100;
					pdfTable.HeaderRows = 1;
					//pdfTable.SkipLastFooter = true;

					// ****************************** Write to PDF *******************************************
					//PdfPCell Tcell = new PdfPCell(new Phrase(parag));
					//Tcell.Colspan = dt.Columns.Count;
					//Tcell.HorizontalAlignment = Element.ALIGN_CENTER;

					// Add header title
					//pdfTable.AddCell(Tcell);
					//PdfPCell cell;

					// Add column titles
					for (int cz=0; cz<CDat.Rows.Count; cz++)
					{
						if (colvis[cz] == 1)
						{
							cell = new PdfPCell(new Phrase(CDat.Rows[cz]["ColumnTitle"].ToString(), font5));
							cell.BackgroundColor = BaseColor.LIGHT_GRAY;
							cell.HorizontalAlignment = 1;
							pdfTable.AddCell(cell);
						}
					}

					// ***************************************************************************************
					// add data rows
					CurrentRow = 0;
					foreach (DataRow r in dt.Rows)
					{
						TotalsLast = 0;
						if (STProd && prod != r["ProductCode"].ToString() && CurrentRow > 0)
						{
							AddTotalsRow(_Ptotal, pdfTable, "Product Totals", 3, _NbrShownIdentCols, (NbrCols - _FirstQtyCol), colvis, 1);
							for (int pt = 0; pt < 36; pt++) { _Ptotal[pt] = 0; }
							TotalsLast = 1;
						}
						if (STProdA && CurrentRow > 0 && prodA != r["ProductCode"].ToString() + " " + r["ItemLength"].ToString() + " " + r["Color"].ToString() + " " + r["Sort"].ToString() + " " + r["Milling"].ToString() + " " + r["NoPrint"].ToString())
						{
							AddTotalsRow(_PAtotal, pdfTable, "PProduct/Attribute Totals", 6, _NbrShownIdentCols, (NbrCols - _FirstQtyCol), colvis, 1);
							for (int pat = 0; pat < 36; pat++) { _PAtotal[pat] = 0; }
							TotalsLast = 1;
						}
						if (STSpec && spec != r["Specie"].ToString() && CurrentRow > 0)
						{
							AddTotalsRow(_Stotal, pdfTable, "Species Totals", 0, _NbrShownIdentCols, (NbrCols - _FirstQtyCol), colvis, 1);
							for (int st = 0; st < 36; st++) { _Stotal[st] = 0; }
							TotalsLast = 1;
						}
						if (STThick && CurrentRow > 0 && Thickness != r["Thickness"].ToString())
						{
							AddTotalsRow(_Ttotal, pdfTable, "Thickness Totals", 1, _NbrShownIdentCols, (NbrCols - _FirstQtyCol), colvis, 1);
							for (int tt = 0; tt < 36; tt++) { _Ttotal[tt] = 0; }
							TotalsLast = 1;
						}
						if (STGrade && CurrentRow > 0 && Grade != r["Grade"].ToString())
						{
							AddTotalsRow(_Gtotal, pdfTable, "Grade Totals", 2, _NbrShownIdentCols, (NbrCols - _FirstQtyCol), colvis, 1);
							for (int tg=0;tg<36;tg++) { _Gtotal[tg] = 0; }
							TotalsLast = 1;
						}
						if (STColor && CurrentRow > 0 && Color != r["Color"].ToString())
						{
							AddTotalsRow(_Ctotal, pdfTable, "Color Totals", 6, _NbrShownIdentCols, (NbrCols - _FirstQtyCol), colvis, 1);
							for (int ct = 0; ct < 36; ct++) { _Ctotal[ct] = 0; }
							TotalsLast = 1;
						}
						if (STSort && CurrentRow > 0 && FSort != r["Sort"].ToString())
						{
							AddTotalsRow(_Sttotal, pdfTable, "Sort Totals", 7, _NbrShownIdentCols, (NbrCols - _FirstQtyCol), colvis, 1);
							for (int stt = 0; stt < 36; stt++) { _Sttotal[stt] = 0; }
							TotalsLast = 1;
						}
						if (STNoP && CurrentRow > 0 && NoPrint != r["NoPrint"].ToString())
						{
							AddTotalsRow(_NPtotal, pdfTable, "NoPrint Totals", 9, _NbrShownIdentCols, (NbrCols - _FirstQtyCol), colvis, 1);
							for (int npt = 0; npt < 36; npt++) { _NPtotal[npt] = 0; }
							TotalsLast = 1;
						}

						// Add Column by column for each row
						for (int c = 0; c < NbrCols; c++)
						{
							ForeVal = "";
							NextVal = "";
							CellVal = r[c].ToString();
							if (c < FirstQtyCol)
							{
								if (CurrentRow > 0) { ForeVal = dt.Rows[CurrentRow-1][c].ToString(); }
								if (CurrentRow < (dt.Rows.Count - 1)) { NextVal = dt.Rows[CurrentRow + 1][c].ToString(); }
								if (TotalsLast == 1) { ForeVal = ""; }
							}

							if (colvis[c] == 1)
							{
								cell = new PdfPCell();
								if (c < FirstQtyCol)
								{
									if (ExclDups == 1)
									{
										if (ForeVal != CellVal && NextVal != CellVal)
										{
											cell.Phrase = new Phrase(CellVal, font5);
										}
										if (ForeVal == CellVal && NextVal == CellVal)
										{
											if (c == (NbrCols-1))
											{
												cell.Border = PdfPCell.LEFT_BORDER | PdfPCell.RIGHT_BORDER | PdfPCell.BOTTOM_BORDER;
											}
											else
											{
												cell.Border = PdfPCell.LEFT_BORDER | PdfPCell.RIGHT_BORDER;
											}
											cell.Phrase = new Phrase("", font5);
											//col = new PdfPCell(new Phrase("", font5));
										}
										if (ForeVal == CellVal && NextVal != CellVal)
										{
											cell.Border = PdfPCell.LEFT_BORDER | PdfPCell.RIGHT_BORDER | PdfPCell.BOTTOM_BORDER;
											cell.Phrase = new Phrase("", font5);
										}
										if (ForeVal != CellVal && NextVal == CellVal)
										{
											cell.Border = PdfPCell.LEFT_BORDER | PdfPCell.RIGHT_BORDER | PdfPCell.TOP_BORDER;
											cell.Phrase = new Phrase(CellVal, font5);
										}
									}
									else
									{
										cell.Phrase = new Phrase(CellVal, font5);
									}
								}
								else
								{
									if (c >= FirstQtyCol && Convert.ToDouble(CellVal) == 0 && NoZeros == 0)
									{
										cell.Phrase = new Phrase("", font5);
									}
									else
									{
										cell.Phrase = new Phrase(CellVal, font5);
									}
								}
								cell.SetLeading(6, 0);
								if (c < FirstQtyCol)
								{
									cell.BackgroundColor = new BaseColor(System.Drawing.Color.Cornsilk);
								}
									//cell.MinimumHeight = 10.0F;
									//cell.PaddingTop = 1;
									pdfTable.AddCell(cell);
							}
							if (c >= FirstQtyCol)
							{
								fig = Convert.ToDouble(CellVal);
								if (STProd) { _Ptotal[c - FirstQtyCol] += fig; }
								if (STProdA) { _PAtotal[c - FirstQtyCol] += fig; }
								if (STSpec) { _Stotal[c - FirstQtyCol] += fig; }
								if (STThick) { _Ttotal[c - FirstQtyCol] += fig; }
								if (STGrade) { _Gtotal[c - FirstQtyCol] += fig; }
								if (STColor) { _Ctotal[c - FirstQtyCol] += fig; }
								if (STSort) { _Sttotal[c - FirstQtyCol] += fig; }
								if (STNoP) { _NPtotal[c - FirstQtyCol] += fig; }
								_GrandTotals[c - FirstQtyCol] += fig;
								_PgTotals[c - FirstQtyCol] += fig;
							}
							SValues[c] = CellVal;	// capture last value
						}
						prod = r["ProductCode"].ToString();
						prodA = r["ProductCode"].ToString() + " " + r["ItemLength"].ToString() + " " + r["Color"].ToString() + " " + r["Sort"].ToString() + " " + r["Milling"].ToString() + " " + r["NoPrint"].ToString();
						spec = r["Specie"].ToString();
						FSort = r["Sort"].ToString();
						Color = r["Color"].ToString();
						NoPrint = r["NoPrint"].ToString();
						Grade = r["Grade"].ToString();
						Thickness = r["Thickness"].ToString();
						CurrentRow++;
					}

					// Add final totals
					AddTotalsRow(_GrandTotals, pdfTable, "Grand Total Quantities", 0, _NbrShownIdentCols, (NbrCols - _FirstQtyCol), colvis, 0);

					pdfDoc.Add(pdfTable);
					pdfDoc.Close();
					Response.ContentType = "application/octet-stream";
					Response.AddHeader("Content-Disposition", "attachment; filename=" + FileName.Replace(" ", "_") + ".pdf");
					Response.Clear();
					Response.BinaryWrite(mStream.ToArray());
					Response.End();
				}
			}
			catch (DocumentException de)
			{
				this._ErrMsg = "Error while generating PDF: " + de.Message;
				//this.lblErrorMsg.Text = this._ErrMsg;
			}
			catch (IOException ioEx)
			{
				this._ErrMsg = "Error while generating PDF: " + ioEx.Message;
				//this.lblErrorMsg.Text = this._ErrMsg;
			}
			catch (System.Threading.ThreadAbortException ext)
			{
				// nothing
			}
			catch (Exception ex)
			{
				this._ErrMsg = "Error while generating PDF: " + ex.Message;
				//this.lblErrorMsg.Text = this._ErrMsg;
			}
		}

		protected void AddTotalsRow(double[] ttlsarray, PdfPTable pdfobj, string lbl, int nrpreccol, int nbridentcols, int NbrQtyCols, int[] colvis, int prec)
		{
			float fig = 0;
			PdfPCell cell;
			BaseColor bc = BaseColor.LIGHT_GRAY;
			switch (nrpreccol)
			{
				case 0:
					bc = new BaseColor(Color.Yellow);
					break;
				case 3:
					bc = new BaseColor(Color.LightSteelBlue);
					break;
				default:
					break;
			}
			int cspan = nbridentcols - nrpreccol + 1;
			iTextSharp.text.Font font5 = iTextSharp.text.FontFactory.GetFont(FontFactory.HELVETICA, 5);
			// add preceding cells

			if (nrpreccol > 0)
			{
				cell = new PdfPCell(new Phrase("", font5));
				cell.BackgroundColor = bc;
				if (nrpreccol > 1) { cell.Colspan = (nrpreccol-1); }
				pdfobj.AddCell(cell);
			}
			else
			{
				cspan--;
			}
			// add label cell
			cell = new PdfPCell(new Phrase(lbl, font5));
			cell.Colspan = cspan;
			cell.BackgroundColor = bc;
			pdfobj.AddCell(cell);
			// add column totals
			for (int p2= 0; p2< NbrQtyCols; p2++)
			{
				cell = new PdfPCell(new Phrase(GenUtilities.FormatNbrSpecial(ttlsarray[p2], "", 1, ",", ".", prec), font5));
				cell.BackgroundColor = bc;
				pdfobj.AddCell(cell);
			}
		}
	}
}