using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DataMngt
{
  public partial class About : Page
  {
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

			this.lblAppVersion.Text = System.Configuration.ConfigurationManager.AppSettings["AppVersion"].ToString();
			this.lblAppVersDate.Text = System.Configuration.ConfigurationManager.AppSettings["AppVersionDate"].ToString();
			this.lblWebmasterName.Text = System.Configuration.ConfigurationManager.AppSettings["Webmaster"].ToString();
			this.lblWebmasterPhone.Text = System.Configuration.ConfigurationManager.AppSettings["WebmasterPhone"].ToString();
			this.lblWebmasterEmail.Text = System.Configuration.ConfigurationManager.AppSettings["WebmasterEmail"].ToString();
			this.lblCurrentBuild.Text = System.Configuration.ConfigurationManager.AppSettings["BuildNbr"].ToString();
			this.lblEnvironment.Text = System.Configuration.ConfigurationManager.AppSettings["Environment"].ToString();

		}
	}
}