using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;

namespace DataMngt
{
    public partial class SiteMaster : MasterPage
    {
		#region local-variables	
		private string _AppVers = string.Empty;
			private string _BuildNbr = "";
			private string _SiteURL = "";
			private CurrentUser _user = null;
		#endregion local-variables

		#region public-variables
		public string BuildNbr
			{
				get { return _BuildNbr; }
			}

			public string AppVersion
			{
				get { return _AppVers; }
			}

			public string SiteURL
			{
				get { return _SiteURL; }
			}

			public string UserName
			{
				get { return _user.FullName; }
			}
		#endregion public-variables

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

			string UserName = Request.ServerVariables["LOGON_USER"];

				_user = SessionHelper.GetCurrentUser(UserName);
				if (_user == null)
				{
					Logging.WriteToLog("Login failed for " + UserName + ".");
					HttpContext.Current.Session["NoAccessMsg"] = "No valid login record found. You do not have access to the purchase request application";
					HttpContext.Current.Response.Redirect("NoAcc/NoAccess.aspx", true);
				}

				_SiteURL = System.Configuration.ConfigurationManager.AppSettings["SitePrefix"];
				_BuildNbr = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"];
				_AppVers = System.Configuration.ConfigurationManager.AppSettings["AppVersion"].ToString() + " (" + System.Configuration.ConfigurationManager.AppSettings["AppVersionDate"].ToString() + ")";

				this.lblBuildNbr.Text = _BuildNbr.ToString();
				this.lblVersion.Text = System.Configuration.ConfigurationManager.AppSettings["AppVersion"].ToString();
				this.lblVersionDate.Text = System.Configuration.ConfigurationManager.AppSettings["AppVersionDate"].ToString();

		}
	}
}