using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using DataLayer;
using System.Runtime.Serialization.Formatters.Binary;

namespace DataMngt.page
{
	public partial class ViewAttachment : System.Web.UI.Page
	{
		#region MainAttributes
		private int _FileID = 0;
		CurrentUser _user = null;
		private string _BuildNbr = "";
		#endregion MainAttributes

		#region PublicAttributes
		public string BuildNbr
		{
			get { return _BuildNbr; }
		}
		#endregion PublicAttributes

		protected void Page_Load (object sender, EventArgs e)
		{
			Response.Cache.SetCacheability(HttpCacheability.NoCache);
			Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
			Response.Cache.SetNoStore();
			Response.ExpiresAbsolute = DateTime.Now;
			Page.Response.Cache.SetCacheability(HttpCacheability.NoCache);
			Response.Cache.SetNoServerCaching();
			Response.Cache.SetValidUntilExpires(true);
			Response.Cache.SetNoStore();
			Response.Cache.SetExpires(DateTime.Parse(DateTime.Now.ToString()));
			Response.Expires = -1441;
			Response.CacheControl = "no-cache";
			Response.DisableKernelCache();

			string UserName = Request.ServerVariables["LOGON_USER"];
			string logFilePath = System.Configuration.ConfigurationManager.AppSettings["AppLogFilePath"].ToString();
			_BuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];

			// get user data
			_user = new CurrentUser(UserName, logFilePath, ""); // SessionHelper.GetCurrentUser(Request.ServerVariables["LOGON_USER"]);
			if (_user == null)
			{
				Log.WriteLogEntry("User Login failed " + _user.FullName, Session["LogFilePath"].ToString());
				Response.Redirect("NoAccess.aspx", true);
				Session["NoAccessMsg"] = "You do not have access to the check approval application";
				Response.Redirect("../NoAcc/NoAccess.aspx", true);
			}

			if (!(IsPostBack))
			{
				_FileID = 0;
				if (Request.QueryString["d"] != null)
				{
					_FileID = Convert.ToInt32(Request.QueryString["d"]);
				}

				ShowThisFile(_FileID);
			}
		}
		public void ShowThisFile (int DocID)
		{
			try
			{
				string path = System.Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);

				// Get back file header data from database
				Commands cmd = new Commands();
				DataTable dt = cmd.GetAttachmentFile(DocID, _user.UserID);
				string FileNm = dt.Rows[0]["FileName"].ToString();
				string CType = dt.Rows[0]["FileType"].ToString();

				// Get Mime type from file extention/type
				string DContentType = GetMimeType(CType) + "          ";

				// Handle file content
				//if (DContentType.Substring(0, 6) == "audio/")
				//{
				//  // 
				//  string TargetDoc = dt.Rows[0]["DocBlob"].ToString(); //Convert.FromBase64String(dt.Rows[0]["DocBlob"].ToString()); // 
				//  var naudio = new System.Web.UI.HtmlControls.HtmlAudio();
				//  naudio.Attributes.Add("autoplay", "autoplay");
				//  naudio.Attributes.Add("controls", "controls");
				//  naudio.Src = TargetDoc;
				//}
				//if (DContentType.Substring(0, 6) == "video/")
				//{
				//  string TargetDoc = dt.Rows[0]["DocBlob"].ToString(); //Convert.FromBase64String(dt.Rows[0]["DocBlob"].ToString()); // 
				//  var nvideo = new System.Web.UI.HtmlControls.HtmlVideo();
				//  nvideo.Attributes.Add("autoplay", "autoplay");
				//  nvideo.Attributes.Add("controls", "controls");
				//  nvideo.Src = TargetDoc;
				//}

				if (DContentType.Substring(0, 6) != "audio/" && DContentType.Substring(0, 6) != "video/")
				{
					byte[] TargetDoc = (byte[])dt.Rows[0]["DocBlob"]; //Convert.FromBase64String(dt.Rows[0]["DocBlob"].ToString()); // 
																														// Send file to WINDOWS
					Response.Clear();
					Response.ClearHeaders();
					Response.Buffer = true;
					Response.AddHeader("Content-Type", DContentType);
					Response.AddHeader("Content-Disposition", "attachment;filename=" + FileNm);
					Response.Charset = "";
					this.EnableViewState = false;
					if (DContentType.Substring(0, 6) == "image/" || DContentType.Substring(0, 12) == "application/")
					{
						//string FilePath = MapPath(FileNm);
						//Response.OutputStream.Write(TargetDoc, 0, TargetDoc.Length);
						Response.BinaryWrite(TargetDoc);
						//Response.WriteFile(FilePath);
						Response.Flush();
						Response.Close();
						HttpContext.Current.ApplicationInstance.CompleteRequest();
					}
					else
					{
						System.Text.ASCIIEncoding enc = new System.Text.ASCIIEncoding();
						string str = enc.GetString(TargetDoc);
						Response.Write(str);
						Response.End();
					}
				}
			}
			catch (Exception ex)
			{
				string jsScript = "";
				string e = ex.Message.Replace("'", "`");
				jsScript = Environment.NewLine + "<script type='text/javascript'>var tact=0;var jsDCT='0';var jsgMsg='Could not view attachment because of an error: " + ex.Message.Replace("'", "`").Replace(Environment.NewLine, " ") + "';</script>";
				Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "MyTargetVariables", jsScript);
			}
		}

		public static char deCode (string s, int startpos)
		{
			char ret = (char)0;
			int twopow = 1;

			for (int i = startpos; i > startpos - 8; i--)
			{
				if (s[i] == '1')
					ret += (char)twopow;

				twopow *= 2;
			}

			return ret;
		}

		private static byte[] HexString2Bytes (string hexString)
		{
			int bytesCount = (hexString.Length) / 2;
			byte[] bytes = new byte[bytesCount];
			for (int x = 0; x < bytesCount; ++x)
			{
				bytes[x] = Convert.ToByte(hexString.Substring(x * 2, 2), 16);
			}

			return bytes;
		}

		private static string Bytes2HexString (byte[] buffer)
		{
			var hex = new StringBuilder(buffer.Length * 2);
			foreach (byte b in buffer)
			{
				hex.AppendFormat("{0:x2}", b);
			}
			return hex.ToString();
		}

		protected string GetMimeType (string filetype)
		{
			filetype = filetype.Replace(".", "");
			switch (filetype)
			{
				case "csv":
					return "text/plain";
				case "xls":
					return "application/vnd.ms-excel";
				case "xlsx":
					return "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
				case "xlsm":
					return "application/vnd.ms-excel";
				case "doc":
					return "application/msword";
				//application/octet-stream";
				case "docx":
					return "application/vnd.openxmlformats-officedocument.wordprocessingml.document";
				//application/octet-stream";
				case "msg":
					return "application/octet-scream"; // "application/vnd.ms-outlook";
																						 //octet-stream";
				case "pdf":
					return "application/pdf";
				case "txt":
					return "text/plain";
				case "htm":
					return "text/html";
				case "html":
					return "text/html";
				case "xml":
					return "Application/xml";
				case "rtf":
					return "text/richtext";
				case "png":
					return "image/x-png";
				case "jpg":
					return "image/jpeg";
				case "jpeg":
					return "image/jpeg";
				case "gif":
					return "image/gif";
				case "tiff":
					return "image/tiff";
				case "tif":
					return "image/tiff";
				case "bmp":
					return "image/bmp";
				case "mpg":
					return "video/mpeg";
				case "mpeg":
					return "video/mpeg";
				case "avi":
					return "video/avi";
				case "emf":
					return "image/x-emf";
				case "wmf":
					return "image/x-wmf";
				case "ppt":
					return "application/vnd.ms-powerpoint";
				case "pps":
					return "application/vnd.ms-powerpoint";
				case "pptx":
					return "application/vnd.openxmlformats-officedocument.presentationml.presentation";
				case "ppsx":
					return "application/vnd.openxmlformats-officedocument.presentationml.slideshow";
				case "exe":
					return "application/x-msdownload";
				case "tar":
					return "application/x-compressed";
				case "zip":
					return "application/x-zip-compressed";
				case "wav":
					return "audio/wav";
				case "mp3":
					return "audio/wav";
			}
			return "application/octet-stream";
		}

		//protected byte[] ObjectToByteArray(object obj)
		//{
		//	if (obj == null) { return null; }
		//	BinaryFormatter bf = new BinaryFormatter();
		//	MemoryStream ms = new MemoryStream();
		//	bf.Serialize(ms, obj);
		//	return ms.ToArray();
		//}

	}
}
