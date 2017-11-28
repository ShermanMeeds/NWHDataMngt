using System;
using System.Data.OleDb;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.DirectoryServices;
using System.DirectoryServices.ActiveDirectory;
using System.Security.Permissions;
using System.IO;
using System.Text;
using System.Configuration;
using DataLayer;

namespace DataMngt.page
{
	public partial class UserADInterface : System.Web.UI.Page
	{
		#region Private Variables
		private static string _ADsPath = string.Empty;
		private DirectoryEntry entry = new DirectoryEntry();
		private string _Callback = string.Empty;
		private string _Phone = string.Empty;
		private string _Mobile = string.Empty;
		private int _UserID = 0;
		private bool _HasCNbr = false;
		private bool _HasTNbr = false;
		private bool _HasMNbr = false;
		private string _OldCNbr = string.Empty;
		private string _OldTNbr = string.Empty;
		private string _OldMNbr = string.Empty;
		private string _UserName = string.Empty;
		#endregion

		#region Public Properties
		public string CallbackNbr
		{
			get { return _Callback; }
			set { _Callback = value; }
		}

		public string PhoneNbr
		{
			get { return _Phone; }
			set { _Phone = value; }
		}

		public string MobileNbr
		{
			get { return _Mobile; }
			set { _Mobile = value; }
		}

		public string ADsPath
		{
			get { return _ADsPath; }
			set { _ADsPath = value; }
		}

		public string sUserID
		{
			get { return _UserID.ToString(); }
		}

		public bool HasCNbr
		{
			get { return _HasCNbr; }
			set { _HasCNbr = value; }
		}

		public bool HasTNbr
		{
			get { return _HasTNbr; }
			set { _HasTNbr = value; }
		}

		public bool HasMNbr
		{
			get { return _HasMNbr; }
			set { _HasMNbr = value; }
		}

		public string OldCNbr
		{
			get { return _OldCNbr; }
			set { _OldCNbr = value; }
		}

		public string OldTNbr
		{
			get { return _OldTNbr; }
			set { _OldTNbr = value; }
		}

		public string OldMNbr
		{
			get { return _OldMNbr; }
			set { _OldMNbr = value; }
		}
		#endregion

		protected void Page_Load(object sender, EventArgs e)
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

			if (!Page.IsPostBack)
			{
				ADsPath = ConfigurationManager.AppSettings["LDAPPath"];
				//string sUserID = "";
				string AllData = "";
				string UserName = Request.ServerVariables["LOGON_USER"];

				System.Security.Principal.IPrincipal user = System.Web.HttpContext.Current.User;
				string sUserName = user.Identity.Name;
				if (user.Identity.IsAuthenticated)
				{
					sUserName = System.Web.HttpContext.Current.User.Identity.Name;
					//dvDirections.InnerHtml = "Please make any necessary corrections below and click on the `Update` button below to update your Active Directory contact information.";
					//Response.Write(user.Identity.Name); 
					//lblUserID.Text = sUserID;

					// Get AD data
					//string[] effectiveAttributes = new string[3];
					//effectiveAttributes[0] = "Telephone-Number";
					//effectiveAttributes[1] = "Phone-Mobile-Primary";
					//effectiveAttributes[2] = "User-Principal-Name";
					SearchResult sr = FindCurrentUser(new string[] { "allowedAttributesEffective" });
					//SearchResult sr = FindCurrentUser(effectiveAttributes);
					if (sr == null)
					{
						//dvDirections.InnerHtml = "\t\tUser data could not be extract at the current time.";
					}
					else
					{
						int count = sr.Properties["allowedAttributesEffective"].Count;
						if (count > 0)
						{
							int i = 0;
							string[] effectiveAttributes = new string[count + 1];
							//effectiveAttributes[0] = "Telephone-Number";
							//effectiveAttributes[1] = "Phone-Mobile-Primary";
							foreach (string attrib in sr.Properties["allowedAttributesEffective"])
							{
								effectiveAttributes[i++] = attrib;
							}
							effectiveAttributes[i++] = "displayName";

							sr = FindCurrentUser(effectiveAttributes);
							foreach (string key in effectiveAttributes)
							{
								string val = String.Empty;
								if (sr.Properties.Contains(key))
								{
									val = sr.Properties[key][0].ToString();
								}

								AllData = AllData + " | " + key + "=" + val;

								//Load controls
								//if (key == "telephoneNumber")
								//{
								//	txtPhone.Text = val;
								//}
								//if (key == "mobile")
								//{
								//	txtMobile.Text = val;
								//}
								//if (key == "otherTelephone")
								//{
								//	txtCallbackNbr.Text = val;
								//}
								//if (key == "displayName")
								//{
								//	//txtMobile.Text = val;
								//	lblGreeting.Text = "\t\tHello, " + val;
								//}

							}
						}
					}
					//this.pnlMainData.Style["display"] = "block";
				}
				else
				{
					//lblGreeting.Text = "You do not have access to this site.";
					//pnlMainData.Style["display"] = "none"; //dvLoggedView.Visible = false;
				}

				//dvDirections.InnerHtml = AllData;
			}
		}

		protected string StandardizeNbr(string Nbr)
		{
			int iLen = 0;
			if (Nbr != "")
			{
				Nbr = Nbr.Replace(" ", "");
				if (Nbr == null) Nbr = "";
				if (Nbr.Length > 0)
				{
					iLen = Nbr.Length;
					if (Nbr.IndexOf("X", StringComparison.CurrentCultureIgnoreCase) > -1) iLen = Nbr.IndexOf("X", StringComparison.CurrentCultureIgnoreCase) - 1;
					if (Nbr.Length == 12) Nbr = "+1-" + Nbr; // add default USA number
				}
			}
			return Nbr;
		}

		protected bool checkPhoneFormat(string Nbr)
		{
			bool bOkay = true;
			//int iLen = 0;
			int iCount = 0;
			int iLevel = 0;
			Int32 a = 0;
			if (Nbr == null) return bOkay;
			if (Nbr.Length == 0) return bOkay;
			char[] sep = new char[] { '-' };

			Nbr = Nbr.Replace("X", "x");
			if (Nbr.IndexOf("x") < 12 && Nbr.IndexOf("x") >= 0) bOkay = false;
			if (Nbr.Substring(0, 1) == "+") Nbr = Nbr.Substring(1, Nbr.Length - 1);
			string[] phones2 = Nbr.Split(sep);
			if (phones2[phones2.Length - 1].IndexOf("x") > -1 || phones2[phones2.Length - 1].IndexOf("X") > -1)
			{
				Nbr = Nbr.Replace("x", "-");
			}
			string[] phonesegs = Nbr.Split(sep);
			// check for proper amount of segments
			iCount = phonesegs.Length;
			if (iCount < 2) bOkay = false;

			int i = phonesegs.Count();
			if (i < 3) bOkay = false;
			foreach (string seg in phonesegs)
			{
				//for (int i = 0; i < seg.Length; i++)
				//{
				//    if (!Char.IsDigit(seg[i]))
				//    {
				//        bOkay = false;
				//    }
				//}
				if (!Int32.TryParse(seg, out a))
				{
					bOkay = false;
				}
				if (iLevel > 0 && seg.Length < 3) bOkay = false;
				if (iLevel == 3 && !(seg.Length == 4)) bOkay = false;
				if (iLevel == iCount && seg.Length < 1) bOkay = false;
				iLevel++;
			}

			return bOkay;
		}

		private SearchResult FindCurrentUser(string[] attribsToLoad)
		{
			//parse the current user's logon name as search key
			string sFilter = String.Format("(&(objectClass=user)(objectCategory=person)(sAMAccountName={0}))",
				User.Identity.Name.Split(new char[] { '\\' })[1]);

			DirectoryEntry searchRoot = new DirectoryEntry(ADsPath, null, null, AuthenticationTypes.Secure);
			using (searchRoot)
			{
				DirectorySearcher ds = new DirectorySearcher(searchRoot, sFilter, attribsToLoad, SearchScope.Subtree);
				ds.SizeLimit = 1;
				return ds.FindOne();
			}
		}

		private string getUserName()
		{

			System.Security.Principal.WindowsIdentity wi = System.Security.Principal.WindowsIdentity.GetCurrent();
			string[] a = Context.User.Identity.Name.Split('\\');

			System.DirectoryServices.DirectoryEntry ADEntry = new System.DirectoryServices.DirectoryEntry("WinNT://" + a[0] + "/" + a[1]);
			string Name = ADEntry.Properties["FullName"].Value.ToString();
			return Name;
		}

		protected void LoadUserList()
		{
			this.lblStatusMsg.Text = "";
			try
			{
				Commands cmd = new Commands();
				DataTable dt = cmd.SelectUserList(0, "", "", "", "", "", "", 0, 2, 0, _UserID);
				GenUtilities.ClearDDLValues(this.ddlUserList, 1);
				this.ddlUserList.DataValueField = "UserID";
				this.ddlUserList.DataTextField = "UserFullName3";
				this.ddlUserList.DataSource = dt;
				this.ddlUserList.DataBind();
				if (dt.Rows.Count == 0)
				{
					this.lblStatusMsg.Text = "No Users were found";
				}
			}
			catch (Exception ex)
			{
				this.lblStatusMsg.Text = "Error encountered when loading user list: " + ex.Message;
			}
		}

		protected void btnSearchForUser_Click(object sender, EventArgs e)
		{
			this.lblStatusMsg.Text = "";
			try
			{
				Commands cmd = new Commands();



				DataTable dt = cmd.SelectUserList(0, "", "", "", "", "", "", 0, 2, 1, _UserID);
			}
			catch (Exception ex)
			{
				this.lblStatusMsg.Text = "Error encountered: " + ex.Message;
			}
		}

		protected void ddlUserList_SelectedIndexChanged(object sender, EventArgs e)
		{
			this.lblStatusMsg.Text = "";
			try
			{
				Commands cmd = new Commands();
				int userid = Convert.ToInt32(this.ddlUserList.SelectedValue);
				DataTable dt = cmd.SelectUserList(userid, "", "", "", "", "", "", 0, 2, 1, _UserID);





				this.divUserData.Style["display"] = "block";
			}
			catch (Exception ex)
			{
				this.lblStatusMsg.Text = "Error encountered loading user data: " + ex.Message;
			}
		}

		protected void btnGenerateExcelList_Click(object sender, EventArgs e)
		{

		}

		protected void btnAddNewUser_Click(object sender, EventArgs e)
		{

		}

		protected void btnCloseArea2_Click(object sender, EventArgs e)
		{

		}

		protected void btnClearArea2_Click(object sender, EventArgs e)
		{

		}
	}
}