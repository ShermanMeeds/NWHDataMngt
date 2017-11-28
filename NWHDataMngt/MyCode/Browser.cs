using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DataMngt
{
	public class Browser
	{
		private string _SessionID = "";
		private string _IPAddress = "";
		private string _Type = "";
		private string _Name = "";
		private string _Platform = "";
		private string _Vers = "";
		private string _JSVers = "";
		private double _BMjVers = 0;
		private double _BMnVers = 0;
		private bool _CookieSupp = false;
		private bool _FrameSupp = false;
		private bool _VBScriptSupp = false;

		public string SessionID { get { return _SessionID; } }
		public string IPAddress { get { return _IPAddress; } }
		public string BrowserType { get { return _Type; } }
		public string BrowserName { get { return _Name; } }
		public string BrowserPlatform { get { return _Platform; } }
		public string BrowserVers { get { return _Vers; } }
		public string BrowserJSVers { get { return _JSVers; } }
		public double BrowserMajVers { get { return _BMjVers; } }
		public double BrowserMinVers { get { return _BMnVers; } }
		public bool HasCookieSupport { get { return _CookieSupp; } }
		public bool HasFrameSupport { get { return _FrameSupp; } }
		public bool HasVBScriptSupport { get { return _VBScriptSupp; } }

		//private Browser() { }

		public Browser(HttpRequest req, string IP, string SessID)
		{
			_SessionID = "";
			_IPAddress = IP;
			_Type = req.Browser.Type;
			_Name = req.Browser.Browser;
			_Platform = req.Browser.Platform;
			_Vers = req.Browser.Version;
			_JSVers = req.Browser["JavascriptVersion"];
			_BMjVers = req.Browser.MajorVersion;
			_BMnVers = req.Browser.MinorVersion;
			_CookieSupp = req.Browser.Cookies;
			_FrameSupp = req.Browser.Frames;
			_VBScriptSupp = req.Browser.VBScript;
			_SessionID = SessID;
		}
	}
}