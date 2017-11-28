using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Reflection;
using System.Diagnostics;
using DataLayer;

namespace DataMngt
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            //RouteConfig.RegisterRoutes(RouteTable.Routes);
            //BundleConfig.RegisterBundles(BundleTable.Bundles);
            string Vers = System.Configuration.ConfigurationManager.AppSettings["AppVersion"];
            string VersDate = System.Configuration.ConfigurationManager.AppSettings["AppVersionDate"];
            Application["AppVersion"] = Vers;
            Application["AppVersDate"] = VersDate;
        }

        void Application_End(object sender, EventArgs e)
        {
            //  Code that runs on application shutdown
          HttpRuntime runtime = (HttpRuntime)typeof(System.Web.HttpRuntime).InvokeMember("_theRuntime", BindingFlags.NonPublic | BindingFlags.Static | BindingFlags.GetField, null, null, null);
          if (runtime == null)
            return;

          string shutDownMessage = (string)runtime.GetType().InvokeMember("_shutDownMessage", BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.GetField, null, runtime, null);
          string shutDownStack = (string)runtime.GetType().InvokeMember("_shutDownStack", BindingFlags.NonPublic | BindingFlags.Instance | BindingFlags.GetField, null, runtime, null);
          if (!EventLog.SourceExists(".NET Runtime"))
          {
            EventLog.CreateEventSource(".NET Runtime", "Application");
          }
          EventLog log = new EventLog();
          log.Source = ".NET Runtime";
          log.WriteEntry(String.Format("\r\n\r\n_shutDownMessage={0}\r\n\r\n_shutDownStack={1}", shutDownMessage, shutDownStack), EventLogEntryType.Error);
        }

        void Application_Error(object sender, EventArgs e)
        {
          // Code that runs when an unhandled error occurs
          // Get the error details
          HttpException lastErrorWrapper = Server.GetLastError() as HttpException;

          Exception lastError = lastErrorWrapper;
          if (lastErrorWrapper.InnerException != null)
          {
            lastError = lastErrorWrapper.InnerException;
          }

          string lastErrorTypeName = lastError.GetType().ToString();
          string lastErrorMessage = lastError.Message;
          string lastErrorStackTrace = lastError.StackTrace;

          //Server.Transfer("~/NoAcc/ErrorPage.aspx");
        }

        void Session_Start(object sender, EventArgs e)
        {
          DBConnect.SetDataConnectString(System.Configuration.ConfigurationManager.ConnectionStrings["MConnectString"].ConnectionString);
					DBConnect.SetDataConnectStringOL(System.Configuration.ConfigurationManager.ConnectionStrings["MConnectStringOL"].ConnectionString);
					DBConnect.SetDataConnectStringDW(System.Configuration.ConfigurationManager.ConnectionStrings["MConnectStringDW"].ConnectionString);
					DBConnect.SetDataConnectStringAR(System.Configuration.ConfigurationManager.ConnectionStrings["MConnectStringAR"].ConnectionString);
					DBConnect.SetDataConnectStringAD(System.Configuration.ConfigurationManager.ConnectionStrings["MConnectStringAD"].ConnectionString);
					DBConnect.SetDataConnectStringHC(System.Configuration.ConfigurationManager.ConnectionStrings["MConnectStringHC"].ConnectionString);
					DBConnect.SetDataConnectStringHD(System.Configuration.ConfigurationManager.ConnectionStrings["MConnectStringHD"].ConnectionString);
					DBConnect.SetDataConnectStringNWDW(System.Configuration.ConfigurationManager.ConnectionStrings["MConnectStringNWDW"].ConnectionString);
					DBConnect.SetDataConnectStringNWB(System.Configuration.ConfigurationManager.ConnectionStrings["MConnectStringNWB"].ConnectionString);
					DBConnect.SetDataConnectStringNWM(System.Configuration.ConfigurationManager.ConnectionStrings["MConnectStringNWM"].ConnectionString);
					MainIntApp.Administrator = System.Configuration.ConfigurationManager.AppSettings["Administrator"];
					MainIntApp.WebMaster = System.Configuration.ConfigurationManager.AppSettings["Webmaster"];
					MainIntApp.WebMasterEmail = System.Configuration.ConfigurationManager.AppSettings["WebmasterEmail"];
					MainIntApp.AdministratorEmail = System.Configuration.ConfigurationManager.AppSettings["AdminEmail"];
					MainIntApp.Version = System.Configuration.ConfigurationManager.AppSettings["AppVersion"];
					MainIntApp.VersionDate = System.Configuration.ConfigurationManager.AppSettings["AppVersionDate"];
					MainIntApp.DBConnect = System.Configuration.ConfigurationManager.ConnectionStrings["MConnectString"].ConnectionString;
          string SitePrefix = System.Configuration.ConfigurationManager.AppSettings["SitePrefix"];
          string ips = System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
          string ReqQ = System.Web.HttpContext.Current.Request.QueryString["r"];
          string QString = System.Web.HttpContext.Current.Request.ServerVariables["QUERY_STRING"];
          // get browser characteristics
          string CurrSessionID = System.Web.HttpContext.Current.Session.SessionID;
          CurrBrowser bw = new CurrBrowser(System.Web.HttpContext.Current.Request);
          Session["bw"] = bw;
          string apppath = HttpRuntime.AppDomainAppPath;
          Session["SitePrefix"] = SitePrefix;
          Session["NoAccessMsg"] = "";
          Session["QString"] = QString;
          // establish default access mode: noaccess, view, approve
          Session["PgViewMode"] = "noaccess";
          Session["IsAdmin"] = "false";
					Session["SessionID"] = CurrSessionID;
					DBInterface dbi = new DBInterface();
					dbi.SetCmdTimeout(Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings["SqlCommandTimeOut"]));
				}

				void Session_End(object sender, EventArgs e)
        {
            // Code that runs when a session ends. 
            // Note: The Session_End event is raised only when the sessionstate mode
            // is set to InProc in the Web.config file. If session mode is set to StateServer 
            // or SQLServer, the event is not raised.

        }
    }
}