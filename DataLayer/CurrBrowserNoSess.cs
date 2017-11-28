using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace DataLayer
{
	public class CurrBrowserNoSess
	{
		#region variable initiation

		private string _BrowserName = "";
		private string _BrowserType = "";
		private string _BrowserVers = "";
		private string _BrowserVersMj = "";
		private string _BrowserVersMn = "";
		private string _Platform = "";
		private string _JScriptVers = "";
		private string _JScriptSupport = "";
		private bool _VBScriptSupport = false;
		private bool _FrameSupport = false;
		private bool _CookieSupport = false;

		#endregion variable initiation

		#region public properties

		public string BrowserName { get { return _BrowserName; } }
		public string BrowserType { get { return _BrowserType; } }
		public string BrowserVers { get { return _BrowserVers; } }
		public string BrowserVersMj { get { return _BrowserVersMj; } }
		public string BrowserVersMn { get { return _BrowserVersMn; } }
		public bool CookieSupport { get { return _CookieSupport; } }
		public bool FrameSupport { get { return _FrameSupport; } }
		public string JScriptSupport { get { return _JScriptSupport; } }
		public string JScriptVers { get { return _JScriptVers; } }
		public string Platform { get { return _Platform; } }
		public bool VBScriptSupport { get { return _VBScriptSupport; } }

		#endregion public properties

		private CurrBrowserNoSess() { }

		public CurrBrowserNoSess(HttpRequest req)
		{
			_BrowserName = req.Browser.Browser.ToString();
			_BrowserType = req.Browser.Type.ToString();
			_BrowserVers = req.Browser.Version.ToString();
			_BrowserVersMj = req.Browser.MajorVersion.ToString();
			_BrowserVersMn = req.Browser.MinorVersion.ToString();
			_Platform = req.Browser.Browser.ToString();
			_JScriptVers = req.Browser["JavaScriptVersion"].ToString();
			_CookieSupport = Convert.ToBoolean(req.Browser.Cookies);
			_FrameSupport = Convert.ToBoolean(req.Browser.Frames);
			_VBScriptSupport = Convert.ToBoolean(req.Browser.VBScript);
		}
	}
}
