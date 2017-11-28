<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProcessManagement.aspx.cs" Inherits="DataMngt.page.ProcessManagement" %>
<%@ Register Src="~/tools/ctlButtonBarNoSess.ascx" TagName="BtnBar1" TagPrefix="bb1"  %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta http-equiv="X-UA-Compatible" content="IE=10; IE=9; IE=8; IE=7; IE=EDGE" />
	<meta http-equiv="Expires" content="0" />
	<meta http-equiv="Cache-Control" content="no-cache" />
	<meta http-equiv="Pragma" content="no-cache" />
	<meta name="description" content="NWH Data Management" />
	<meta name="author" content="s. meeds" />
  <title>Data Management Application</title>

	<script type="text/javascript" src="../Scripts/jquery-3.2.1.min.js"></script>
	<script type="text/javascript" src="../Scripts/jquery-ui.1.12.1.min.js"></script>
	<script type="text/javascript" src="../Scripts/jqueryAJAXTransport.js"></script>
	<script type="text/javascript" src="../Scripts/Modernizr-2.6.2.js"></script>
	<script type="text/javascript" src="../Scripts/AJAXSupport.js?v=<%=BuildNbr %>"></script>
	<script type="text/javascript" src="../Scripts/DateMngt.js?v=<%=BuildNbr %>"></script>
	<script type="text/javascript" src="../Scripts/TxtUtilities.js?v=<%=BuildNbr %>"></script>
	<script type="text/javascript" src="../Scripts/GenUtils.js?v=<%=BuildNbr %>"></script>
	<script type="text/javascript" src="../Scripts/Pagination.js?v=<%=BuildNbr %>"></script>
	<script type="text/javascript" src="../Scripts/Dialogs.js?v=<%=BuildNbr %>"></script>
	<script type="text/javascript" src="../Scripts/DataGrids.js?v=<%=BuildNbr %>"></script>
	<script type="text/javascript" src="../Scripts/WebControls.js?v=<%=BuildNbr %>"></script>
	<script type="text/javascript" src="../Scripts/NbrFunctions.js?v=<%=BuildNbr %>"></script>
  <script type="text/javascript" src="jquery-3.2.1-vsdoc2.js"></script>

	<link rel="stylesheet" type="text/css" href="../style/Site.css?v=1" />
  <link rel="stylesheet" type="text/css" href="../style/jquery-ui.1.12.1.min.css?v=1" />
  <link rel="stylesheet" type="text/css" href="../style/jquery-ui.structure.min.css?v=1" />
  <link rel="stylesheet" type="text/css" href="../style/jquery-ui.theme.min.css?v=1" />
  <link rel="stylesheet" type="text/css" href="../style/themes/base/jquery-ui.css?v=1" />
	<link rel="stylesheet" type="text/css" href="../style/Dialogs.css?v=1" /> 
	<link rel="stylesheet" type="text/css" href="../style/colors.css?v=1" /> 
	<link rel="stylesheet" type="text/css" href="../style/Controls.css?v=1" /> 

	<style type="text/css">
			.modal
			{
					position: fixed;
					top: 0;
					left: 0;
					background-color: black;
					z-index: 99;
					opacity: 0.8;
					filter: alpha(opacity=80);
					-moz-opacity: 0.8;
					min-height: 100%;
					width: 100%;
			}

			.loading
			{
					font-family: Arial;
					font-size: 10pt;
					border: 5px solid #67CFF5;
					width: 200px;
					height: 100px;
					display: none;
					position: fixed;
					background-color: White;
					z-index: 999;
			}

			.ui-dialog .ui-dialog-titlebar-close{
					display: none;
			}

			.StdFtrCellThisPage {
				color:black;
				background-color:aquamarine;
				text-align:right;
				font-size:10pt;
				font-family:Calibri;
				vertical-align: top;
				padding-top: 1px;
				padding-bottom: 1px;
				padding-left: 2px;
				padding-right: 2px;
				border-left: 1px solid gray;
				border-right: 1px solid gray;
				border-top: 3px groove gray;
				border-bottom: 1px solid gray;
			}

	</style>

	<script type="text/javascript">
		var jbA = false;
		var jbAllLocations = false;
		var jbNoEmptyProds = false;
		var jbPaginate = false;
		var jbViewOnly = true;
		var jdivAdminLogs;
		var jdivProcessItemEdit;
		var jdivProcessList;
		var jdivProcessSettingEdit;
		var jdivProcessSettings;
		var jdivProcessStatusList;
		var jdToday = new Date();
		var jiAR = 0;
		var jiActionStatusCode = '';
		var jiActionStatusID = 0;
		var jiActionStatusMsg = '';
		var jiAdminLogCol1 = 19;
		var jiAdminLogCol2 = 22;
		var jiAdminLogCol3 = 24;
		var jiAdminLogCol4 = 18;
		var jiAdminLogCol5 = 22;
		var jiAdminLogTypeID = 0;
		var jiByID = 0;
		var jiCurrentGrid = 0;
		var jiNbrPages = 0;
		var jiNbrRows = 0;
		var jiPageID = 57;
		var jiPageNbr = 0;
		var jiPageSize = 20;
		var jiTotalRows = 0;
		var jiUserID = 0;
		var jiViewType = 0;
		var jlPageStatus;
		var jlStatusMsg;
		var jlWeekNbr;
		var jsBrowserType = '';
		var jsCurrentTime = '';
		var jselAddressTypeF;
		var jselAdminLogDBF;
		var jselAdminLogSchemaF;
		var jselAdminLogTypeF;
		var jselDatabaseIDf;
		var jselErrorTypeF;
		var jselNotificationType2F;
		var jselPageSize;
		var jselProcessStatF;
		var jselSettingsActiveF;
		var jselSettingsDatabaseF;
		var jselSettingsProcessF;
		var jselSettingsSequenceF;
		var jselUserList;
		var jsErrorMsg = '';
		var jsLocationCode = '';
		var jsPageVersion = '';
		var jsPageVersDate = '';
		var jsRegionCode = '';
		var jsToday = '';
		var jtAdminLogDateBF;
		var jtAdminLogDateEF;
		var jtAdminLogIDF;
		var jtAdminErrorIDF;
		var jtAdminOtherIDF;
		var jtblAdminLogs;
		var jtblProcessList;
		var jtblProcessSettings;
		var jtblProcessStatList;
		var jtQueryTitle;
		var jtTemplateNameF;
		var jtTemplateSubjectF;

		var MyAdminLogList;
		var MyNotificationsList;
		var MyProcessList;
		var MyProcSettingsData;
		var MyProcStatusList;
		var MyReturn;

		// Objects: 0-EmailAddresses, 1-EmailTemplates, 2-EmailTraffic, 3-NotificationTypes
		var counter = 0;
		var DayNamesNV = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
		var jadminlog1x = [1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]; // show columns
		var jadminlog2x = [1, 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		var jadminlog3x = [1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		var jadminlog4x = [1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		var jadminlog5x = [1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		var jadminlog1sz = [80, 56, 50, 66, 56, 56, 10, 68, 68, 440, 66, 210, 66, 100, 100, 100, 100, 100, 100, 100, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0]; // show columns
		var jadminlog2sz = [80, 56, 70, 66, 56, 0, 70, 68, 0, 100, 96, 66, 160, 110, 10, 10, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		var jadminlog3sz = [100, 80, 70, 70, 80, 70, 70, 0, 80, 80, 0, 80, 80, 60, 80, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		var jadminlog4sz = [100, 80, 70, 90, 140, 0, 110, 70, 100, 80, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		var jadminlog5sz = [100, 80, 70, 90, 80, 240, 200, 120, 100, 0, 80, 80, 70, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
		var jadminlog1cn = ['DBName', 'Schema', 'ErrorLogID', 'AppName', 'RowID', 'ErrorID', 'ErrorDateTime', 'sErrorDate', 'sErrorTime', 'ErrorMsg', 'ErrorLine', 'OtherInfo', 'UserID', 'NbrRows', 'NbrPages', 'PgNbr', 'PgSize', 'LwRowID', 'HiRowID', '', '', '', ''];
		var jadminlog2cn = ['DBName', 'Schema', 'SessionID', 'AppName', 'UserID', 'LoginDateTime', 'sLoginDate', 'sLoginTime', 'BrowserType', 'ClientPlatform', 'IPAddress', 'AuthType', 'WinSessionID', 'NbrRows', 'NbrPages', 'PgNbr', 'PgSize', 'LwRowID', 'HiRowID', '', '', '', ''];
		var jadminlog3cn = ['DBName', 'Schema', 'ProcessLogID', 'ProcessID', 'AppName', 'DatabaseID', 'ErrorID', 'AuthType', 'UserID', 'BeginDateTime', 'sBeginDate', 'sBeginTime', 'EndDateTime', 'sEndDate', 'sEndTime', 'sActive', 'NbrRowsAffected', 'IsActive', 'NbrRows', 'NbrPages', 'PgNbr', 'PgSize', 'LwRowID', 'HiRowID', '', '', ''];
		var jadminlog4cn = ['DBName', 'Schema', 'EventID', 'AppName', 'EventTitle', 'ActionType', 'TableName', 'TableRowID', 'EventDatetime', 'LoggedByEmpID', 'NbrRows', 'NbrPages', 'PgNbr', 'PgSize', 'LwRowID', 'HiRowID', '', '', ''];
		var jadminlog5cn = ['DBName', 'Schema', 'EMailID', 'AppName', 'EmailTemplateID', 'TemplateActivityID', 'Subject', 'EmailTo', 'EmailCC', 'BCC', 'SentDateTime', 'sSentDate', 'sSentTime', 'WasSent', 'IsActive', 'sActive', 'NbrRows', 'NbrPages', 'PgNbr', 'PgSize', 'LwRowID', 'HiRowID', '', '', '', ''];
		var jadminlog1hdr = ['DB Name', 'Schema', 'ErrorLog ID', 'App Name', 'Row ID', 'Error ID', '', 'Error Date', 'Error Time', 'Error Msg', 'Error Line', 'Other Info', 'User ID', '', '', '', '', '', '', '', '', '', ''];
		var jadminlog2hdr = ['DB Name', 'Schema', 'Session ID', 'App Name', 'User ID', '', 'Login Date', 'Login Time', 'Browser Type', 'Client Platform', 'IP Address', 'Auth Type', 'Win SessionID', '', '', '', '', '', '', '', '', '', ''];
		var jadminlog3hdr = ['DB Name', 'Schema', 'ProcessLog ID', 'Process ID', 'Ap pName', 'Database ID', 'Error ID', 'Auth Type', 'User ID', '', 'Begin Date', 'Begin Time', '', 'End Date', 'End Time', 'Active', '# Rows Affected', '', '', '', '', '', '', '', '', '', ''];
		var jadminlog4hdr = ['DB Name', 'Schema', 'Event ID', 'App Name', 'Event Title', 'Action Type', 'TableName', 'Row ID', '', 'LoggedBy EmpID', '', '', '', '', '', '', '', '', ''];
		var jadminlog5hdr = ['DB Name', 'Schema', 'EMail ID', 'App Name', 'Template ID', '', 'Subject', 'Email To', 'Email CC', 'BCC', '', 'Sent Date', 'Sent Time', 'Sent', '', 'Active', '', '', '', '', '', '', '', '', '', ''];
		var jadminlog1o = ['left', 'center', 'right', 'center', 'left', 'left', '', 'center', 'center', 'left', 'center', 'left', 'right', 'left', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '']; // show columns
		var jadminlog2o = ['left', 'center', 'center', 'left', 'center', '', 'center', 'center', '', 'left', 'left', 'left', 'left', 'left', 'left', 'left', '', '', '', '', '', '', '', '', '', '', '', '', ''];
		var jadminlog3o = ['left', 'left', 'left', 'left', 'left', 'left', 'left', '', 'left', '', 'center', 'center', '', 'left', 'left', 'left', 'left', '', '', '', '', '', '', '', '', '', '', '', ''];
		var jadminlog4o = ['left', 'left', 'left', 'left', 'left', '', 'left', 'left', 'left', 'left', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
		var jadminlog5o = ['left', 'left', 'left', 'left', 'left', '', 'left', 'left', 'left', 'left', '', 'left', 'left', 'left', '', '', '', '', '', '', '', ''];

		// page initiation section --------------------------------------------------------------------------------
		$(document).ready(function () {
			jsToday = getMyDateTimeStringDm(jdToday, 18);
			jsCurrentTime = getMyDateTimeStringDm(jdToday, 7);
			//alert(jdToday + '/' + jsToday + '/' + jsCurrentTime);
			updateClockNV();
			KeepSessionAlive();

			// set global default values
			//alert('Ready starting');
			jiPageID = 57;
			jsPageVersion = '1.0.0';
			jsPageVersDate = '6/25/2017';
			jbViewOnly = true;
			//alert('loading seed values');
			// Load global page-loaded variables
			jiByID = jigEmpID;
			jsBrowserType = jsgBrowserType;
			//alert(jsBrowserType);
			if (jsgAr > 4 || jgA === 1) {
				jbA = true;
				//alert('Admin');
			}
			if (jsgAr > 1) {
				jbAllLocations = true;
			}

			$('#Form1').on("submit", function (evt) {
				evt.preventDefault();
			});

			jdivAdminLogs = document.getElementById('divAdminLogs');
			jdivProcessItemEdit = document.getElementById('divProcessItemEdit');
			jdivProcessList = document.getElementById('divProcessList');
			jdivProcessSettingEdit = document.getElementById('divProcessSettingEdit');
			jdivProcessSettings = document.getElementById('divProcessSettings');
			jdivProcessStatusList = document.getElementById('divProcessStatusList');
			jlStatusMsg = document.getElementById('lblStatusMsg');
			jselAdminLogDBF = document.getElementById('selAdminLogDBF');
			jselAdminLogSchemaF = document.getElementById('selAdminLogSchemaF');
			jselAdminLogTypeF = document.getElementById('selAdminLogTypeF');
			jselNotificationType2F = document.getElementById('selNotificationType2F');
			jselSettingsActiveF = document.getElementById('selSettingsActiveF');
			jselSettingsDatabaseF = document.getElementById('selSettingsDatabaseF');
			jselSettingsProcessF = document.getElementById('selSettingsProcessF');
			jselSettingsSequenceF = document.getElementById('selSettingsSequenceF');
			jselProcessStatF = document.getElementById('selProcessStatF');
			jtAdminErrorIDF = document.getElementById('txtAdminErrorIDF');
			jtAdminLogDateBF = document.getElementById('txtAdminLogDateBF');
			jtAdminLogDateEF = document.getElementById('txtAdminLogDateEF');
			jtAdminLogIDF = document.getElementById('txtAdminLogIDF');
			jtAdminOtherIDF = document.getElementById('txtAdminOtherIDF');
			jtblAdminLogs = document.getElementById('tblAdminLogs');
			jtblProcessList = document.getElementById('tblProcessList');
			jtblProcessSettings = document.getElementById('tblProcessSettings');
			jtblProcessStatList = document.getElementById('tblProcessStatList');

			PageInitiation();
		});

		function KeepSessionAlive() {
			counter++;
			if (counter > 10000) { counter = 0; }
			var img = document.getElementById("imgSessionKeepAlive");
			img.src = "../ka.html?c=" + counter;
			setTimeout(KeepSessionAlive, 300000);
		}

		function disableEnterKey(e) {
			var key;
			if (window.event) {
				key = window.event.keyCode;     //IE
			}
			else {
				key = e.which;     //firefox
			}
			if (key == 13) {
				return false;
			}
			else {
				return true;
			}
		}

		function stopRKey(evt) {
			var evt2 = (evt) ? evt : ((event) ? event : null);
			var node = (evt2.target) ? evt2.target : ((evt2.srcElement) ? evt2.srcElement : null);
			if ((evt2.keyCode == 13) && (node.type == "text")) { return false; }
		}

		document.onkeypress = stopRKey;

		function updateClockNV() {
			var currentTime = new Date();
			var sCurrDate = DayNamesNV[currentTime.getDay()] + ' ' + currentTime.toLocaleDateString(); // currentTime.toDateString();

			var currentHours = currentTime.getHours();
			var currentMinutes = currentTime.getMinutes();
			var currentSeconds = currentTime.getSeconds();

			// Pad the minutes and seconds with leading zeros, if required
			currentMinutes = (currentMinutes < 10 ? "0" : "") + currentMinutes;
			currentSeconds = (currentSeconds < 10 ? "0" : "") + currentSeconds;

			// Choose either "AM" or "PM" as appropriate
			var timeOfDay = (currentHours < 12) ? "AM" : "PM";

			// Convert the hours component to 12-hour format if needed
			currentHours = (currentHours > 12) ? currentHours - 12 : currentHours;

			// Convert an hours component of "0" to "12"
			currentHours = (currentHours == 0) ? 12 : currentHours;

			// Compose the string for display
			var currentTimeString = currentHours + ":" + currentMinutes + ":" + currentSeconds + " " + timeOfDay;

			// Update the time display
			document.getElementById("clockNV").firstChild.nodeValue = currentTimeString;

			document.getElementById("spnCurrDateNV").firstChild.nodeValue = sCurrDate;
		}

		// initial data loads for page initiation
		function PageInitiation() {
			//alert('beginning initiation');
			PopulateNotificationList();

			//alert('setting pagination');
			EstablishMainPgElementsPj(1, 0);
			EstablishMainPgElementsPj(2, 0);
			EstablishMainPgElementsPj(3, 0);
			EstablishMainPgElementsPj(4, 0);
			jiNbrPagesPj[0] = 0;
			jiNbrRowsPj[0] = 0;
			jiNbrPagesPj[1] = 0;
			jiNbrRowsPj[1] = 0;
			jiNbrPagesPj[2] = 0;
			jiNbrRowsPj[2] = 0;
			jiNbrPagesPj[3] = 0;
			jiNbrRowsPj[3] = 0;
			jiPageSize = 20;
			//alert('Initiation done');

			//createDatePickerOnTextWc('txtBeginDateF', null, null, 0, 3, 'show', 11);
			//createDatePickerOnTextWc('txtEndDateF', null, null, 0, 3, 'show', 12);

			document.getElementById('lblPageIDInFooter').innerHTML = 'Page ID: ' + jiPageID.toString();
			return false;
		}
		// END of page initiation section --------------------------------------------------------------------------------

		// **************************** AJAX FUNCTIONS *********************************

		function DataCall1() {
			jiPageNbr = jiPgNbrPj[0];
			//alert('Page ' + jiPageNbr);
			GetProcessList(0, 0);
			PopulateProcessList();
			return false;
		}

		function DataCall3() {
			GetProcessStatusList(0, 0, 0, 0);
			PopulateProcStatusGrid();
		}

		function DataCall4() {
			PopulateProcessSettingsList();
			return false;
		}

		function GetEmailAddressList(notifid, err, atype, act, sort) {
			var url = "../shared/AdminServices.asmx/SelectEmailAddressList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','NotifID':'" + notifid.toString() + "','Error':'" + err.toString() + "','AddrType':'" + atype + "','Active':'" + act.toString() + "',";
			MyData = MyData + "'Sort':'" + sort.toString() + "','PgNbr':'" + jiPgNbrPj[0].toString() + "','PgSize':'" + jiPageSize.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyEmailAddressList = response; });
			return false;
		}

		function GetLogEntries(typ, app, db, schema, subj, bdy, dtb, dte, tid, eid, id, sid, sort) {
			var url = "../shared/AdminServices.asmx/SelectAdministrativeLogs";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','LogTypeID':'" + typ.toString() + "','AppName':'" + app + "','DBName':'" + db + "','Schema':'" + schema + "','Subj':'" + subj + "','Body':'" + bdy + "',";
			MyData = MyData + "'sTDateB':'" + dtb + "','sTDateE':'" + dte + "','TargetID':'" + tid.toString() + "','ErrID':'" + eid.toString() + "','ID':'" + id.toString() + "','sID':'" + sid + "','Sort':'" + sort.toString() + "','PgNbr':'" + jiPgNbrPj[1].toString() + "',";
			MyData = MyData + "'PgSize':'" + jiPageSize.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyAdminLogList = response; });
			return false;
		}	

		function GetNotificationsList() {
			var url = "../shared/AdminServices.asmx/SelectNotificationsList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','Sort':'0','PgNbr':'0','PgSize':'999','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyNotificationsList = response; });
			return false;
		}

		function GetProcessList(id, sort) {
			var url = "../shared/AdminServices.asmx/SelectProcessList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ProcID':'" + id.toString() + "','Sort':'" + sort.toString() + "','Active':'2','PgNbr':'" + jiPgNbrPj[0].toString() + "',";
			MyData = MyData + "'PgSize':'" + jiPageSize.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProcessList = response; });
			return false;
		}

		function GetProcessSettings(procid, dbid, scode, sort, act) {
			var url = "../shared/AdminServices.asmx/SelectProcessSettings";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ProcID':'" + procid.toString() + "','DbID':'" + dbid.toString() + "','SeqCode':'" + scode + "','Sort':'" + sort.toString() + "',";
			MyData = MyData + "'Active':'" + act.toString() + "','PgNbr':'" + jiPgNbrPj[3].toString() + "','PgSize':'" + jiPageSize.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProcSettingsData = response; });
			return false;
		}

		function GetProcessStatusList(id, uid, seq, sort) {
			var url = "../shared/AdminServices.asmx/SelectProcessStatusList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ProcID':'" + id.toString() + "','UserID':'" + uid.toString() + "','SeqType':'" + seq.toString() + "','Sort':'" + sort.toString() + "','Active':'2',";
			MyData = MyData + "'PgNbr':'" + jiPgNbrPj[2].toString() + "','PgSize':'" + jiPageSize.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProcSettingsData = response; });
			return false;
		}

		function UpdateProcessData(id, cd, nm, ptyp, sched, jname, spname, rerunsp, src, tupdate, act) {
			var url = "../shared/AdminServices.asmx/UpdateProcess";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ID':'" + id.toString() + "','Code':'" + cd + "','sName':'" + nm + "','PTypeID':'" + ptyp.toString() + "','Sched':'" + sched + "',";
			MyData = MyData + "'JobName':'" + jname + "','SPName':'" + spname + "','RerunSP':'" + rerunsp + "','SrcType':'" + src.toString() + "','UpdType':'" + tupdate.toString() + "','Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProcessList = response; });
			return false;
		}

		function UpdateProcessData2(id, typ, val) {
			var url = "../shared/AdminServices.asmx/UpdateProcessData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ID':'" + id.toString() + "','iType':'" + typ.toString() + "','Value':'" + val + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			return false;
		}

		function DeleteOneProcess(id) {
			var url = "../shared/AdminServices.asmx/DeleteProcess";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ID':'" + id.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			return false;
		}

		function RestartProcess(id) {
			var url = "../shared/AdminServices.asmx/RestartProcess";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ID':'" + id.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			return false;
		}

		function UpdateUserRightLevel(id, val) {
			var url = "../shared/AjaxServices.asmx/UpdateColumnSetting";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'3','ID':'" + id.toString() + "','UserID':'0','GroupCode':'','RightLevel':'" + val + "','PageID':'" + jiPageID.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			return false;
		}

		// **************************** Populate *********************************

		function PopulateAdminLogs() {
			jlStatusMsg.innerHTML = '';
			var ncols = 0;
			var colhdr;
			var colorient;
			var colshow;
			var colvar;
			var colwdth;
			var content = '';
			var tcell;
			var trow;
			switch (jiAdminLogTypeID) {
				case 1:
					ncols = jiAdminLogCol1; 
					colshow = jadminlog1x;
					colhdr = jadminlog1hdr;
					colwdth = jadminlog1sz;
					colvar = jadminlog1cn;
					colorient = jadminlog1o;
					break;
				case 2:
					ncols = jiAdminLogCol2; 
					colshow = jadminlog2x;
					colhdr = jadminlog2hdr;
					colwdth = jadminlog2sz;
					colvar = jadminlog2cn;
					colorient = jadminlog2o;
					break;
				case 3:
					ncols = jiAdminLogCol3; 
					colshow = jadminlog3x;
					colhdr = jadminlog3hdr;
					colwdth = jadminlog3sz;
					colvar = jadminlog3cn;
					colorient = jadminlog3o;
					break;
				case 4:
					ncols = jiAdminLogCol4; 
					colshow = jadminlog4x;
					colhdr = jadminlog4hdr;
					colwdth = jadminlog4sz;
					colvar = jadminlog4cn;
					colorient = jadminlog4o;
					break;
				case 5:
					ncols = jiAdminLogCol5; 
					colshow = jadminlog5x;
					colhdr = jadminlog5hdr;
					colwdth = jadminlog5sz;
					colvar = jadminlog5cn;
					colorient = jadminlog5o;
					break;
				default:
					break;
			}

			//alert('set array pointers');
			var tbdy = document.createElement("tbody");
			if (MyAdminLogList !== undefined && MyAdminLogList !== null) {
				var thd = document.createElement("thead");
				var nrows = MyAdminLogList.length;
				if (nrows > 0) {
					jiNbrPagesPj[1] = parseInt(MyAdminLogList[0]['NbrPages'], 10);
					jiNbrRowsPj[1] = parseInt(MyAdminLogList[0]['NbrRows'], 10);
					//alert(jiNbrPagesPj[1] + '/' + jiNbrRowsPj[1]);

					// form the thead header block
					//try {
					//	var dset = JSON.parse(MyAdminLogList);
					//}
					//catch (ex) {
					//	alert('Error parsing data: ' + ex.message);
					//}
					trow = getNewRowDg('trAdminLogHdr', 0, '20px');
					//alert('beginning header row');
					for (var colh = 0; colh < ncols; colh++) {
						if (colshow[colh] === 1) {
							try {
								tcell = createHdrCellDg('thAdminLogHdr' + colh.toString(), colhdr[colh], '1', 'TableHdrCell', 'center', 'middle', colwdth[colh], '#A3ACD1', 'black', '1px solid gray', '4px', '4px', '2px', '2px', '0', '');
								thd.appendChild(tcell);
							}
							catch (ex) {
								alert('Error creating cell: ' + ex.message);
							}
						}
					}
					thd.appendChild(trow);
					//alert('header row formed');
					// insert new table head
					var oldhead = jtblAdminLogs.getElementsByTagName("thead")[0];
					jtblAdminLogs.replaceChild(thd, oldhead);

					// insert rows
					//alert('beginning data rows');
					for (var row = 0; row < nrows; row++) {
						trow = getNewRowDg('trAdminLog' + row.toString(), 0, '20px');
						//alert(ncols);
						for (var col = 0; col < ncols; col++) {
							if (colshow[col] === 1) {
								content = MyAdminLogList[row][colvar[col]].toString(); // dset[row][col].toString();
								tcell = document.createElement("td");
								tcell.id = 'tdAdminLogCell' + col.toString();
								tcell.style.border = '1px solid gray';
								tcell.style.width = colwdth[col].toString() + 'px';
								tcell.style.textAlign = colorient[col];
								tcell.style.fontFamily = 'Arial Narrow';
								tcell.style.verticalAlign = 'top';
								tcell.innerHTML = content;
								//tcell = createNewCellDg('tdAdminLogCell' + col.toString(), '20px', colwdth[col].toString() + 'px', content, 'white', 'black', '1px solid gray', colorient[col], 'top', '4px', '4px', '2px', '2px', '10pt', false, '', false, false, '', '1', disp, ''); // tx  nbr nbr   txt      txt      txt      txt    txt    txt    txt    txt     txt     txt   txt   txt   txt   txt     bool    bool      txt     bool    bool    txt	   txt     txt   displaytxt
								trow.appendChild(tcell);
							}
						}
						tbdy.appendChild(trow);
					}
				}
				else {
					jlStatusMsg.innerHTML = 'No rows were found matching that criteria.';
				}

			}
			else {
				jlStatusMsg.innerHTML = 'An unidentified error occurred. The database could not be queried.';
			}

			// insert changed table body
			var oldBody = jtblAdminLogs.getElementsByTagName("tbody")[0];
			jtblAdminLogs.replaceChild(tbdy, oldBody);

			if (nrows < jiNbrRowsPj[1]) {
				joPgNbrLblPj2.innerHTML = (jiPgNbrPj[1] + 1).toString();
				joMaxPgNbrLblPj2.innerHTML = jiNbrPagesPj[1].toString();
				joPaginationBarPj2.style.display = 'block';
			}
			return false;
		}

		function PopulateProcessList() {
			//alert('Filling Proc List');
			jlStatusMsg.innerHTML = '';
			var cellClass = 'StdTableCell';
			var nCol = 11;
			// Cols: 0-ID, 1-Code, 2-Name, 3-Type, 4-Schedule, 5-SPName, 6-RerunSPName, 7-UpdateType, 8-SourceType, 9-Active, 10-action
			//alert('arrays');
			var cWidth = [50, 100, 260, 70, 100, 120, 120, 60, 60, 52, 156, 0, 0, 0, 0];
			var corientH = ['center', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'center', 'center', 'left', '', '', ''];
			var corientV = ['top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', '', '', '', ''];
			var cbrdrL = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrR = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrT = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrB = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cnames = ['ProcessID', 'ProcessCode', 'ProcessName', 'ProcessTypeID', 'Schedule', 'SPName', 'RerunSPName', 'UpdateType', 'SourceType', 'IsActive', 'ACTION', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cType = [0, 0, 0, 6, 0, 0, 0, 6, 6, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var aggType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var shown = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
			//alert('DDL list data');
			EmptyDDLListsDg();
			//alert('1');
			jsDGColDDLOpts[3][0] = '0|None';
			jsDGColDDLOpts[3][1] = '1|Maintenance';
			jsDGColDDLOpts[3][2] = '2|Event';
			jsDGColDDLOpts[3][3] = '3|ErrorHandle';
			jsDGColDDLOpts[3][4] = '4|Transaction';
			jsDGColDDLOpts[3][5] = '5|Check';
			jsDGColDDLOpts[7][0] = '0|Anytime';
			jsDGColDDLOpts[7][1] = '1|Same Day';
			jsDGColDDLOpts[7][2] = '2|Same Week';
			jsDGColDDLOpts[7][3] = '3|Same Hour';
			jsDGColDDLOpts[7][4] = '9|None';
			jsDGColDDLOpts[8][0] = '0|Job';
			jsDGColDDLOpts[8][1] = '1|SP';
			jsDGColDDLOpts[8][2] = '3|SQL';
			jsDGColDDLOpts[8][3] = '4|Other';
			jsDGColDDLOpts[10][0] = '0|No';
			jsDGColDDLOpts[10][1] = '1|Yes';

			if (MyProcessList !== undefined && MyProcessList !== null) {
				//alert('Proc List Len: ' + MyProcessList.length);
				var bdy = FormDataGridBodyMinimumDg(1, nCol, 'tdProcList', cellClass, true, true, false, true, 'Restart', 'button blue-gradient glossy', false, 0, MyProcessList, 'ProcessID', cnames, cType, cWidth, corientH, corientV, cbrdrL, cbrdrR, cbrdrT, cbrdrB, aggType, shown, true, true);
				//alert('Grid done');
				jtblProcessList.style.display = 'block';
			}
			else {
				alert('Proc List bad data');
				ShowStatusMsg('An unidentified error occurred. No records could be extracted.');
			}
			//alert('Attaching body');
			try {
				var oldBody = jtblProcessList.getElementsByTagName("tbody")[0];
				jtblProcessList.replaceChild(bdy, oldBody);
			}
			catch (ex) {
				// nothing
			}
			joPgNbrLblPj.innerHTML = (jiPgNbrPj[0]+1).toString();
			joMaxPgNbrLblPj.innerHTML = jiNbrPagesPj[0].toString();
			return false;
		}

		function PopulateProcessSettingsList() {
			alert('populating list');
			var pid = parseInt(jselSettingsProcessF.value, 10);
			var dbid = parseInt(jselSettingsDatabaseF.value, 10);
			var seqcode = jselSettingsSequenceF.value;
			var act = parseInt(jselSettingsActiveF.value, 10);
			alert('getting data');
			GetProcessStatusList(pid, dbid, seqcode, 0, act); //id, uid, seq, sort
			alert('Filling Proc List');
			//COLS: 0-ID, 1-Name, 2-Process, 3-ProcType, 4-Database, 5-SeqCode, 6-Sched, 7-BaseDate, 8-BaseTime, 9-EndDate, 10-ExclBEgin1, 11-ExclEnd1, 12-ExclBegin2, 13-ExclEnd2, 14-Sun, 15-Mon, 16-Tues, 
			//      17-Wed, 18-Thu, 19-Fri, 20-Sat, 21-SPNameInit, 22-SPNameRerun, 23-Iterations, 24-Pri, 25-RunStatus, 26-RanOn, 27-Active, 28-ACTION
			jlStatusMsg.innerHTML = '';
			var cellClass = 'StdTableCell';
			var nCol = 29;
				//alert('arrays');
			var cWidth = [50, 140, 260, 100, 220, 60, 100, 70, 70, 70, 70, 70, 70, 70, 30, 30, 30, 30, 30, 30, 30, 120, 120, 60, 60, 50, 70, 52, 156, 0, 0, 0];
			var corientH = ['center', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', '', '', ''];
			var corientV = ['top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', '', '', '', ''];
			var cbrdrL = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', ''];
			var cbrdrR = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', ''];
			var cbrdrT = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', ''];
			var cbrdrB = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', ''];
			var cnames = ['ProcessBaseID', 'SchedTitle', 'sProcessIdent', 'ProcessTypeCode', 'sDatabaseIdent', 'SeqCode', 'Schedule', 'sBaseDate', 'TimeString', 'sEndDate', 'BeginExcludeTime', 'EndExcludeTime', 'BeginExcludeTime2', 'EndExcludeTime2', 'sESun', 'sEMon', 'sETue', 'sEWed', 'sEThu', 'sEFri', 'sESat', 'SPName', 'RerunSPName', 'NbrIterations', 'PriID', 'LastStatusCode', 'sLastRunDate', 'sActive', 'ACTION', '', '', '', '', '', ''];
			var cType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var aggType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var shown = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]

			if (!IsContentsNullUndefinedGu(MyProcSettingsData)) {
				alert('Proc Settings Len: ' + MyProcSettingsData.length);
				var bdy = FormDataGridBodyMinimumDg(4, nCol, 'tdProcSetList', cellClass, true, true, false, false, '', 'button blue-gradient glossy', false, 0, MyProcSettingsData, 'ProcessBaseID', cnames, cType, cWidth, corientH, corientV, cbrdrL, cbrdrR, cbrdrT, cbrdrB, aggType, shown, true, true);
				alert('Grid done');
				jtblProcessSettings.style.display = 'block';
			}
			else {
				alert('Proc Settings bad data');
				ShowStatusMsg('An unidentified error occurred. No records could be extracted.');
			}
			//alert('Attaching body');
			try {
				var oldBody = jtblProcessSettings.getElementsByTagName("tbody")[0];
				jtblProcessSettings.replaceChild(bdy, oldBody);
			}
			catch (ex) {
				// nothing
			}
			joPgNbrLblPj.innerHTML = (jiPgNbrPj[3]+1).toString();
			joMaxPgNbrLblPj.innerHTML = jiNbrPagesPj[3].toString();
			return false;
		}

		function PopulateProcListFilter() {
			if (MyProcessList !== undefined && MyProcessList !== null) {
				ClearDDLOptionsGu('selProcessStatF', 1);
				fillDropDownListGu(MyProcessList, jselProcessStatF, 0, 'ProcessName', 'ProcessID');
			}
			return false;
		}

		function PopulateProcStatusGrid() {
			//alert('Filling Proc Status List');
			var bdy;
			var cellClass = 'StdTableCell';
			var nCol = 13;
				// Cols: 0-ID, 1-Code, 2-Name, 3-Type, 4-Schedule, 5-Seq, 6-DBName, 7-LastRunDate, 8-EndRunDate, 9-#Rows, 10-UserID, 11-ErrorID
				//alert('arrays');
			var cWidth = [50, 100, 260, 80, 100, 110, 120, 120, 120, 90, 60, 60, 200, 0, 0, 0, 0];
			var corientH = ['center', 'left', 'left', 'left', 'left', 'left', 'left', 'center', 'center', 'left', 'right', 'center', 'left', '', '', ''];
			var corientV = ['top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', '', '', '', ''];
			var cbrdrL = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrR = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrT = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrB = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cnames = ['ProcessID', 'ProcessCode', 'ProcessName', 'ProcessType', 'Schedule', 'ScheduleSeq', 'DatabaseName', 'sBeginDateTime', 'sEndDateTime', 'NbrSeconds', 'NbrRowsAffected', 'UserID', 'ErrorMsg', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var aggType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var shown = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
			//alert('1');
			if (!IsContentsNullUndefinedTx(MyProcStatusList)) {
				//alert('forming grid');
				//alert('Proc List Len: ' + MyProcStatusList.length);
				bdy = FormDataGridBodyMinimumDg(3, nCol, 'tdProcStList', cellClass, false, false, false, false, '', 'button blue-gradient glossy', false, 0, MyProcStatusList, 'ProcessID', cnames, cType, cWidth, corientH, corientV, cbrdrL, cbrdrR, cbrdrT, cbrdrB, aggType, shown, true, true);
				//alert('Grid done');
				jtblProcessStatList.style.display = 'block';
			}
			else {
				ShowStatusMsg('An unidentified error occurred. No records could be extracted.');
			}
			//alert('Attaching body');
			try {
				var oldBody = jtblProcessStatList.getElementsByTagName("tbody")[0];
				jtblProcessStatList.replaceChild(bdy, oldBody);
			}
			catch (ex) {
				// nothing
			}
			//alert('pagination updates');
			joPgNbrLblPj3.innerHTML = (jiPgNbrPj[2] + 1).toString();
			joMaxPgNbrLblPj3.innerHTML = jiNbrPagesPj[2].toString();
			return false;
	}

		function PopulateNotificationList() {
			GetNotificationsList();
			if (!IsContentsNullUndefinedGu(MyNotificationsList)) {
				ClearDDLOptionsGu('selNotificationType2F', 1);
				fillDropDownListGu(MyNotificationsList, jselNotificationType2F, 0, 'NotificationType', 'NotificationTypeCode');
			}
			return false;
		}

		// **************************** Dialogs *********************************

		function ChangeCheckBox(id, objid, val, ischecked) {
			return false;
		}

		function ChangeColSetting(itm, chckd) {
			var ischecked = 0;
			if (chckd === true) { ischecked = 1; }
			SaveColSettingValue(itm, ischecked.toString());
		}

		function ChangeDropDownVal(id, objid, row, col, val) {
			switch (objid) {
				case 1:
					UpdateProcessData2(id, col, val);
					break;
				case 93:
					UpdateUserRightLevel(id, val);
					break;
				default:
					break;
			}
		}

		function ChangeInputVal(id, row, col, objid, val) {

		}

		function ChangeRadioBtn(id, objid, val, ischecked) {
			return false;
		}

		function DialogAction1(dChoice, Src) {
			switch (Src) {
				case 2: // nothing
					break;
				case 5:
					// nothing
					break;
				default:
					break;
			}
			return false;
		}

		function HandleImageClick(id, col, objid) {
			return false;
		}

		function ActivateHyperlink(id, objid, val1, val2, val3) {
			return false;
		}

		function ViewOneRec(id, row, objid) {
			return false;
		}

		function EditOneRec(id, row, objid) {
			switch (objid) {
				case 1: // process
					document.getElementById('lblProcIDE').innerHTML = MyProcessList[row]['ProcessID'].toString();
					document.getElementById('txtProcessCodeE').value = MyProcessList[row]['ProcessCode'].toString();
					document.getElementById('txtProcessNameE').value = MyProcessList[row]['ProcessName'].toString();
					document.getElementById('selProcTypeE').value = MyProcessList[row]['ProcessTypeID'].toString();
					document.getElementById('selProcSequenceE').value = MyProcessList[row]['SequenceType'].toString();
					document.getElementById('txtProScheduleE').value = MyProcessList[row]['Schedule'].toString();
					document.getElementById('txtProcJobNameE').value = MyProcessList[row]['JobName'].toString();
					document.getElementById('txtProSPNameE').value = MyProcessList[row]['SPName'].toString();
					document.getElementById('txtProcRSPNameE').value = MyProcessList[row]['RerunSPName'].toString();
					document.getElementById('selProcSrcTypeE').value = MyProcessList[row]['SourceType'].toString();
					document.getElementById('selProcUpdTypeE').value = MyProcessList[row]['UpdateType'].toString();
					document.getElementById('selProcActiveE').value = MyProcessList[row]['IsActive'].toString();
					document.getElementById('lblProcCreatedE').innerHTML = MyProcessList[row]['sCreatedDate'].toString();
					document.getElementById('lblProcUpdatedE').innerHTML = MyProcessList[row]['sUpdatedDate'].toString();
					jdivProcessItemEdit.style.display = 'block';
					break;
				default:
					break;
			}

			return false;
		}

		function DeleteOneRec(id, row, objid) {
			switch (objid) {
				case 1:
					DeleteOneProcess(id);
					break;
				default:
					break;
			}
			return false;
		}

		function SpecialGridAction(id,row,col,objid) {
			switch (objid) {
				case 1: // restart process
					RestartProcess(id);
					break;
				default:
					break;
			}
			return false;
		}

		// **************************** Background *********************************

		function ShowStatusMsg(msg) {
			jlStatusMsg.innerHTML = msg;
			return false;
		}

		// **************************** UI FUNCTIONS *********************************

		function ChangePageSize(val) {
			jiPageSize = parseInt(val, 10);
			refreshDataGrid();
			return false;
		}

		function ChangeViewType(val) {
			//alert('Fired!');
			var code = '';
			var nm = '';
			HideAllAreas();
			jiCurrentGrid = parseInt(val);
			switch (jiCurrentGrid) {
				case 0: // nothing
					break;
				case 1: // proc list
					jiPgNbrPj[0] = 0;
					jiPgSizePj[0] = jiPageSize;
					GetProcessList(0, 0);
					PopulateProcessList();
					jdivProcessList.style.display = 'block';
					break;
				case 2: // proc status
					//alert('proc status');
					jiPgNbrPj[2] = 0;
					jiPgSizePj[2] = jiPageSize;
					//alert('Getting proc data');
					GetProcessList(0, 0);
					//alert('Populate proc data');
					PopulateProcListFilter();
					//alert('Getting status data');
					GetProcessStatusList(0, 0, 0, 0);
					PopulateProcStatusGrid();
					jdivProcessStatusList.style.display = 'block';
					break;
				case 3: // settings
					//alert('Fired!');
					jiPgNbrPj[4] = 0;
					jiPgSizePj[4] = jiPageSize;
					//alert('populating');
					PopulateProcessSettingsList();
					jdivProcessSettings.style.display = 'block';
					break;
				case 4: // admin logs
					//GetLogEntries(typ, app, db, schema, subj, bdy, dtb, dte, tid, eid, id, sid, sort);
					jdivAdminLogs.style.display = 'block';
					break;
				default:
					break;
			}
			return false;
		}

		function CloseProcDataEdit() {
			jdivProcessItemEdit.style.display = 'none';
		}

		function HideAllAreas() {
			jdivAdminLogs.style.display = 'none';
			jdivProcessList.style.display = 'none';
			jdivProcessStatusList.style.display = 'none';
			return false;
		}

		function ProcessAddNew() {
			document.getElementById('lblProcIDE').innerHTML = '0';
			document.getElementById('txtProcessCodeE').value = '0';
			document.getElementById('txtProcessNameE').value = '0';
			document.getElementById('selProcTypeE').value = '0';
			document.getElementById('selProcSequenceE').value = '0';
			document.getElementById('txtProScheduleE').value = '';
			document.getElementById('txtProcJobNameE').value = '';
			document.getElementById('txtProSPNameE').value = '';
			document.getElementById('txtProcRSPNameE').value = '';
			document.getElementById('selProcSrcTypeE').value = '0';
			document.getElementById('selProcUpdTypeE').value = '0';
			document.getElementById('selProcActiveE').value = '0';
			document.getElementById('lblProcCreatedE').innerHTML = '';
			document.getElementById('lblProcUpdatedE').innerHTML = '';
			jdivProcessItemEdit.style.display = 'block';
			return false;
		}

		function RefreshAdminLogData() {
			jlStatusMsg.innerHTML = '';
			var typ = jselAdminLogTypeF.value;
			jiAdminLogTypeID = parseInt(typ, 10);
			if (jiAdminLogTypeID > 0) {
				var db = jselAdminLogDBF.value;
				if (db === '0') { db = '';}
				var schema = jselAdminLogSchemaF.value;
				if (schema === '0') { schema = '';}
				var logid = jtAdminLogIDF.value;
				if (logid === '') { logid = '0';}
				var errid = jtAdminErrorIDF.value;
				if (errid === '') { errid = '0';}
				var otherid = jtAdminOtherIDF.value;
				if (otherid === '') { otherid = '0';}
				var logdtb = jtAdminLogDateBF.value;
				var logdte = jtAdminLogDateEF.value;
				GetLogEntries(typ, 'DataMngt', db, schema, '', '', logdtb, logdte, logid, errid, otherid, '', 0);
				PopulateAdminLogs();
			}
			return false;
		}

		function UpdateProcData() {


			return false;
		}

		function RefreshCurrentDataGrid() {
			switch (jiCurrentGrid) {
				case 0: // nothing
					break;
				case 1: // proc list
					//jiPgNbrPj[0] = 0;
					GetProcessList(0, 0);
					PopulateProcessList();
					break;
				case 2: // proc status
					//alert('proc status');
					//jiPgNbrPj[2] = 0;
					GetProcessList(0, 0);
					PopulateProcListFilter();
					GetProcessStatusList(0, 0, 0, 0);
					PopulateProcStatusGrid();
					break;
				case 3: // settings
					PopulateProcessSettingsList();
					break;
				case 4: // admin logs
					RefreshAdminLogData();
					break;
				default:
					break;
			}
		}

		// **************************** External Links *********************************

	</script>
			

  <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />

</head>
<body>
	<img id="imgSessionKeepAlive" width="1" height="1" style="display:none;" src="../Images/clearpixel.gif" />
  <form id="form1" runat="server">
  <asp:ScriptManager runat="server"></asp:ScriptManager>
	<asp:HiddenField ID="hfPageID" runat="server" Value="57" />

	<div id="divMainPopup" style="display:none;"></div>

  <div class="container body-content">
      <div id="divMainIcon" style="width:99%;margin-left:10px;">
        <table style="padding:0px;border-spacing:0px;width:100%;">
        <tr>
          <td style="width:124px;padding-right:2px;vertical-align:middle;">
            <img src="../Images/nwhlogo.png" style="width:120px;height:36px;margin:4px;" />
          </td>
          <td style="vertical-align:middle;">
            <bb1:BtnBar1 ID="ctlButtonBar1" runat="server"></bb1:BtnBar1>
          </td>
        </tr>
        </table>
      </div>

			<div id="divPAGEHEADER" style="width:100%;margin-left:10px;margin-bottom:10px;">
				<div id="divPageHdrTitle" style="width:100%;">
					<label id="lblOricMngtHdrTitle" class="LabelGridHdrStd" style="font-size:12pt;margin-left:6px;">Process Management:</label>
					<label id="lblPageStatus" style="position:absolute;font-size:10pt;font-weight:bold;color:darkgray;right:70px;">Page Ready</label>
				</div>
				<div id="divMainHdrSelects" style="width:100%;text-align:center;">
					<label id="lblMainHdrSelectItem" style="color:blue;font-weight:bold;font-size:12pt;">Edit or View Data:</label>&nbsp;
					<select id="selEditViewType" style="font-size:12pt;" onchange="javascript:ChangeViewType(this.value);return false;">
						<option value="0" selected="selected">None Selected</option>
						<option value="1">Process List</option>
						<option value="2">Process Status</option>
						<option value="3">Process Settings</option>
						<option value="4">Admin Logs</option>
					</select>
					<span id="spnSpacerFOrItemsPerPage" style="margin-left:10px;">
						<label style="margin-left: 5px;">Items per Page:</label>
						<select id="selPageSize" style="margin-left: 10px;" onchange="javascript:ChangePageSize(this.value);return false;">
							<option value="10" >10</option>
							<option value="20" selected="selected" >20</option>
							<option value="25" >25</option>
							<option value="30" >30</option>
							<option value="35" >35</option>
							<option value="40" >40</option>
							<option value="50" >50</option>
							<option value="75" >75</option>
							<option value="100" >100</option>
							<option value="150" >150</option>
						</select>&nbsp;&nbsp;&bull;&nbsp;&nbsp;
						<button id="btnRefreshStatus" class="button blue-gradient glossy" onclick="javascript:RefreshCurrentDataGrid();return false;">Refresh Data</button>
					</span>
				</div>
			</div>

			<div id="divPAGEMAINSECTION" style="width:100%;margin-left:10px;">

				<div id="divProcessItemEdit" style="width:100%;display:none;background-color:antiquewhite;margin-top:6px;">
					<div id="divProcessEditHdr" style="width:100%;margin:4px;">
						&nbsp;<label id="lblProcEditHdr" style="font-weight:bold;color:blue;font-size:13pt;">Edit Process Data:</label>&nbsp;&nbsp;ID:&nbsp;<label id="lblProcIDE" style="font-weight:bold;color:blue;"></label>
					</div>
					<div id="divProcessEditTable" style="width:100%;text-align:center;margin-bottom:6px;">
						<table id="tblProcEdit" style="padding:1px;border-spacing:0px;margin: auto auto;">
						<tr>
							<td style="text-align:right;">
								Code:&nbsp;
							</td>
							<td style="text-align:left;">
								<input type="text" id="txtProcessCodeE" style="width:100px;" />
							</td>
							<td>&nbsp;&nbsp;</td>
							<td style="text-align:right;">
								Name:&nbsp;
							</td>
							<td style="text-align:left;">
								<input type="text" id="txtProcessNameE" style="width:200px;" />
							</td>
						</tr>
						<tr>
							<td style="text-align:right;">
								Type:&nbsp;
							</td>
							<td style="text-align:left;">
								<select id="selProcTypeE">
									<option value="0" selected="selected">None Selected</option>
									<option value="1">Maintenance</option>
									<option value="2">Event</option>
									<option value="3">ErrorHandle</option>
									<option value="4">Transaction</option>
									<option value="5">Check</option>
								</select>
							</td>
							<td>&nbsp;&nbsp;</td>
							<td style="text-align:right;">
								Sequence:&nbsp;
							</td>
							<td style="text-align:left;">
								<select id="selProcSequenceE">
									<option value="0">None Selected</option>
									<option value="1">Daily</option>
									<option value="2">Weekly</option>
									<option value="3">Monthly</option>
									<option value="4">Quarterly</option>
									<option value="5">SemiAnnually</option>
									<option value="6">Annually</option>
									<option value="7">Hourly</option>
									<option value="8">By Minutes</option>
									<option value="9">Other</option>
								</select>
							</td>
						</tr>
						<tr>
							<td style="text-align:right;">
								Schedule:&nbsp;
							</td>
							<td style="text-align:left;">
								<input type="text" id="txtProScheduleE" style="width:120px;" />
							</td>
							<td>&nbsp;&nbsp;</td>
							<td style="text-align:right;">
								Job&nbsp;Name:&nbsp;
							</td>
							<td style="text-align:left;">
								<input type="text" id="txtProcJobNameE" style="width:200px;" />
							</td>
						</tr>
						<tr>
							<td style="text-align:right;">
								SP&nbsp;Name:&nbsp;
							</td>
							<td style="text-align:left;">
								<input type="text" id="txtProSPNameE" style="width:200px;" />
							</td>
							<td>&nbsp;&nbsp;</td>
							<td style="text-align:right;">
								Rerun&nbsp;SP&nbsp;Name:&nbsp;
							</td>
							<td style="text-align:left;">
								<input type="text" id="txtProcRSPNameE" style="width:200px;" />
							</td>
						</tr>
						<tr>
							<td style="text-align:right;">
								Source&nbsp;Type:&nbsp;
							</td>
							<td style="text-align:left;">
								<select id="selProcSrcTypeE">
									<option value="0" selected="selected">Job</option>
									<option value="1">SP</option>
									<option value="2">SQL</option>
									<option value="3">Other</option>
								</select>
							</td>
							<td>&nbsp;&nbsp;</td>
							<td style="text-align:right;">
								Update&nbsp;Type:&nbsp;
							</td>
							<td style="text-align:left;">
								<select id="selProcUpdTypeE">
								 <option value="0" selected="selected">None Selected</option>
								 <option value="1">Same Day</option>
								 <option value="2">Same Week</option>
								 <option value="3">Same Hour</option>
								 <option value="4">Cannot be reran</option>
								</select>
							</td>
						</tr>
						<tr>
							<td style="text-align:right;">
								Active:&nbsp;
							</td>
							<td style="text-align:left;">
								<select id="selProcActiveE">
									<option value="1" selected="selected">Yes</option>
									<option value="0">No</option>
								</select>
							</td>
							<td>&nbsp;&nbsp;</td>
							<td style="text-align:right;" colspan="2">
								Created:<label id="lblProcCreatedE"></label>&nbsp;-&nbsp;Updated:<label id="lblProcUpdatedE"></label>&nbsp;
							</td>
						</tr>
						<tr>
							<td style="text-align:center;" colspan="5">
								<button id="btnSaveProcData" class="button blue-gradient glossy" onclick="javascript:UpdateProcData();return false;">Save</button>&nbsp;&nbsp;
								<button id="btnCloseProcDataEdit" class="button blue-gradient glossy" onclick="javascript:CloseProcDataEdit();return false;">Close Edit Area</button>
							</td>
						</tr>
						</table>
					</div>
				</div>

				<div id="divProcessSettingEdit" style="width:100%;display:none;">

				</div>

				<div id="divProcessList" style="width:100%;display:none;">
					<div id="divProcessListHdr" style="width:100%;">
						<table style="width:100%;padding:1px;border-spacing:0px;border:none;">
						<tr>
							<td style="width:50%;">
								<label id="lblProcessListHdr" style="font-weight:bold;color:blue;font-size:13pt;">Processes:</label>
							</td>
							<td style="width:50%;text-align:right;">
								<button id="btnAddNewProcess" class="button blue-gradient glossy" onclick="javascript:ProcessAddNew();return false;" style="right:60px;">Add New Process</button>&nbsp;&nbsp;&nbsp;
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align:center;">
								<label id="lblProcessFilters" style="color:blue;font-weight:bold;">Filters:</label>&nbsp;&nbsp;Name:&nbsp;
								<input type="text"id="txtTemplateNameF" style="width:120px;" />&nbsp;&nbsp;|&nbsp;Subject:&nbsp;<input type="text"id="txtTemplateSubjectF" style="width:120px;" />
								Notification:&nbsp;
								<select id="selNotificationType2F">
									<option value="0" selected="selected">ALL</option>
								</select>
							</td>
						</tr>
						</table>
					</div>
					<div id="divProcessListTbl" style="width:100%;text-align:center;">
						<table style="padding:0px;border-spacing:0px;margin: auto auto;"><tr><td>
							<table id="tblProcessList" style="padding:1px;border-spacing:0px;border-collapse:collapse;font-family:Arial narrow;margin:auto auto;">
							<thead id="tblProcessListHd">
							<tr>
								<th id="thProcessListCol100" class="TableHdrCell" style="width:50px;">ID</th>
								<th id="thProcessListCol101" class="TableHdrCell" style="width:100px;">Code</th>
								<th id="thProcessListCol102" class="TableHdrCell" style="width:260px;">Name</th>
								<th id="thProcessListCol103" class="TableHdrCell" style="width:70px;">Type</th>
								<th id="thProcessListCol104" class="TableHdrCell" style="width:100px;">Schedule</th>
								<th id="thProcessListCol105" class="TableHdrCell" style="width:120px;">SPName</th>
								<th id="thProcessListCol106" class="TableHdrCell" style="width:120px;">Rerun SPName</th>
								<th id="thProcessListCol107" class="TableHdrCell" style="width:60px;">Run Type</th>
								<th id="thProcessListCol108" class="TableHdrCell" style="width:60px;">Run Source</th>
								<th id="thProcessListCol109" class="TableHdrCell" style="width:52px;">Active</th>
								<th id="thProcessListCol110" class="TableHdrCell" style="width:156px;">Action</th>
							</tr>
							</thead>
							<tbody id="tblProcessListBd">
							</tbody>
							<tfoot id="tblProcessListFt">
							</tfoot>
							</table>
						</td></tr></table>
<!-- #include file="../inc/incPaginationDiv.inc" -->
					</div>
				</div>

				<div id="divProcessStatusList" style="width:100%;display:none;">
					<div id="divProcessStatListHdr" style="width:100%;">
						<table style="width:100%;padding:1px;border-spacing:0px;border:none;">
						<tr>
							<td style="width:50%;">
								<label id="lblProcessStatListHdr" style="font-weight:bold;color:blue;font-size:13pt;">Process Status:</label>
							</td>
							<td style="width:50%;text-align:right;">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align:center;">
								<label id="lblProcStatusFilters" style="color:blue;font-weight:bold;">Filters:</label>&nbsp;&nbsp;Process:&nbsp;
								<select id="selProcessStatF">
									<option value="0" selected="selected">ALL</option>
								</select>
							</td>
						</tr>
						</table>
					</div>
					<div id="divProcessStatusListTbl" style="width:100%;text-align:center;">
						<table style="padding:0px;border-spacing:0px;margin: auto auto;"><tr><td>
							<table id="tblProcessStatList" style="padding:1px;border-spacing:0px;border-collapse:collapse;font-family:Arial narrow;margin:auto auto;">
							<thead id="tblProcessStatListHd">
							<tr>
								<th id="thProcessStatCol100" class="TableHdrCell" style="width:50px;" rowspan="2">ID</th>
								<th id="thProcessStatCol101" class="TableHdrCell" style="width:100px;" rowspan="2">PCode</th>
								<th id="thProcessStatCol102" class="TableHdrCell" style="width:260px;" rowspan="2">Process Name</th>
								<th id="thProcessStatCol103" class="TableHdrCell" style="width:80px;" rowspan="2">Type</th>
								<th id="thProcessStatCol104" class="TableHdrCell" style="width:100px;" rowspan="2">Schedule</th>
								<th id="thProcessStatCol105" class="TableHdrCell" style="width:110px;" rowspan="2">Sequence</th>
								<th id="thProcessStatCol106" class="TableHdrCell" style="width:120px;" rowspan="2">DB Name</th>
								<th id="thProcessStatCol107" class="TableHdrCell" style="width:120px;" rowspan="2">Last Run Date</th>
								<th id="thProcessStatCol108" class="TableHdrCell" style="width:120px;" rowspan="2">End Run Date</th>
								<th id="thProcessStatCol109" class="TableHdrCell" style="width:80px;" rowspan="2">#Seconds</th>
								<th id="thProcessStatCol110" class="TableHdrCell" style="width:60px;" rowspan="2"># Rows</th>
								<th id="thProcessStatCol111" class="TableHdrCell" style="width:60px;" rowspan="2">UserID</th>
								<th id="thProcessStatCol112" class="TableHdrCell" style="width:200px;" rowspan="2">Error</th>
							</tr>
							</thead>
							<tbody id="tblProcessStatListBd">
							</tbody>
							<tfoot id="tblProcessStatListFt">
							</tfoot>
							</table>
						</td></tr></table>
<!-- #include file="../inc/incPaginationDiv3.inc" -->
					</div>
				</div>

				<div id="divAdminLogs" style="width:100%;display:none;">
					<div id="divAdminLogsHdr" style="width:100%;margin-bottom:4px;">
						<table style="width:100%;padding:1px;border-spacing:0px;border:none;">
						<tr>
							<td style="width:50%;">
								<label id="lblAdminLogsHdr" style="font-weight:bold;color:blue;font-size:13pt;">Administrative Logs:</label>
							</td>
							<td style="width:50%;text-align:right;">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align:center;">
								<label id="lblAdminLogsFilters" style="color:blue;font-weight:bold;">Filters:</label>&nbsp;Log&nbsp;Type:&nbsp;
								<select id="selAdminLogTypeF">
									<option value="0" selected="selected">None Selected</option>
									<option value="5">Email</option>
									<option value="1">Error</option>
									<option value="4">Event</option>
									<option value="3">Process</option>
									<option value="2">Web Session</option>
								</select>&nbsp;&nbsp;
								Database:&nbsp;
								<select id="selAdminLogDBF">
									<option value="0" selected="selected">ALL</option>
									<option value="NWHDW">DW</option>
									<option value="NWHBus">Business Support</option>
									<option value="DBAAdmin">Administration</option>
								</select>&nbsp;&nbsp;
								Schema:&nbsp;
								<select id="selAdminLogSchemaF">
									<option value="0" selected="selected">ALL</option>
									<option value="Dbo">Dbo</option>
									<option value="Maint">Maint</option>
									<option value="web">Web</option>
								</select>&nbsp;&nbsp;
								Begin Date:&nbsp;<input type="text" id="txtAdminLogDateBF" style="width:80px;" />-End Date:&nbsp;<input type="text" id="txtAdminLogDateEF" style="width:80px;" />&nbsp;&nbsp;
								LogID:&nbsp;<input type="text" id="txtAdminLogIDF" style="width:80px;" />	&nbsp;&nbsp;
								ErrorID:&nbsp;<input type="text" id="txtAdminErrorIDF" style="width:80px;" />&nbsp;&nbsp;
								OtherID:&nbsp;<input type="text" id="txtAdminOtherIDF" style="width:80px;" />
							</td>
						</tr>
						<tr>
							<td style="text-align:center;" colspan="2">
								<div id="btnFilterBtnBar" style="width:100%;text-align:center;margin-top:4px;margin-bottom:4px;">
									<button id="btnRefreshAdminLogData" class="button blue-gradient glossy" onclick="javascript:RefreshAdminLogData();return false;">Refresh Data</button>
								</div>
							</td>
						</tr>
						</table>
					</div>
					<div id="divAdminLogsTbl" style="width:100%;text-align:center;margin-bottom:4px;">
						<table id="tblAdminLogs" style="padding:1px;border-spacing:0px;border-collapse:collapse;font-family:Arial narrow; margin:auto auto;">
						<thead id="tblAdminLogsHd">
						</thead>
						<tbody id="tblAdminLogsBd">
						</tbody>
						<tfoot id="tblAdminLogsFt">
						</tfoot>
						</table>
<!-- #include file="../inc/incPaginationDiv2.inc" -->
					</div>
				</div>

				<div id="divProcessSettings" style="width:100%;display:none;">
					<div id="divProcessSettingsHdr" style="width:100%;">
						<table style="width:100%;padding:1px;border-spacing:0px;border:none;">
						<tr>
							<td style="width:50%;">
								<label id="lblProcessSettingsHdr" style="font-weight:bold;color:blue;font-size:13pt;">Processes:</label>
							</td>
							<td style="width:50%;text-align:right;">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align:center;">
								<label id="lblProcessSettingsFilters" style="color:blue;font-weight:bold;">Filters:</label>&nbsp;&nbsp;
								Process:&nbsp;
								<select id="selSettingsProcessF" >
									<option value="0" selected="selected">ALL</option>
								</select>
								&nbsp;&nbsp;|&nbsp;Database:&nbsp;
								<select id="selSettingsDatabaseF">
									<option value="0" selected="selected">ALL</option>
								</select>
								&nbsp;&nbsp;|&nbsp;Sequencing:&nbsp;
								<select id="selSettingsSequenceF">
									<option value="0" selected="selected">ALL</option>
								</select>
								&nbsp;&nbsp;|&nbsp;Active:&nbsp;
								<select id="selSettingsActiveF">
									<option value="2" selected="selected">ALL</option>
									<option value="1">Active</option>
									<option value="0">Inactive</option>
								</select>
							</td>
						</tr>
						</table>
					</div>
					<div id="divProcessSettingsTbl" style="width:100%;text-align:center;">
						<table style="padding:0px;border-spacing:0px;margin: auto auto;"><tr><td>
							<table id="tblProcessSettings" style="padding:1px;border-spacing:0px;border-collapse:collapse;font-family:Arial narrow;margin:auto auto;">
							<thead id="tblProcessSettingsHd">
							<tr>
								<th id="thProcessSettingsCol100" class="TableHdrCell" style="width:50px;" rowspan="2">ID</th>
								<th id="thProcessSettingsCol101" class="TableHdrCell" style="width:140px;" rowspan="2">Name</th>
								<th id="thProcessSettingsCol102" class="TableHdrCell" style="width:260px;" rowspan="2">Process</th>
								<th id="thProcessSettingsCol103" class="TableHdrCell" style="width:100px;" rowspan="2">ProcType</th>
								<th id="thProcessSettingsCol104" class="TableHdrCell" style="width:220px;" rowspan="2">Database</th>
								<th id="thProcessSettingsCol105" class="TableHdrCell" style="width:60px;" rowspan="2">SeqCode</th>
								<th id="thProcessSettingsCol106" class="TableHdrCell" style="width:100px;" rowspan="2">Schedule</th>
								<th id="thProcessSettingsCol107" class="TableHdrCell" style="width:148px;" colspan="3">Base Sched</th>
								<th id="thProcessSettingsCol108" class="TableHdrCell" style="width:260px;" colspan="11">Exclusions</th>
								<th id="thProcessSettingsCol109" class="TableHdrCell" style="width:248px;" colspan="2">SP Name</th>
								<th id="thProcessSettingsCol110" class="TableHdrCell" style="width:60px;" rowspan="2">Iterations</th>
								<th id="thProcessSettingsCol111" class="TableHdrCell" style="width:60px;" rowspan="2">Pri</th>
								<th id="thProcessSettingsCol112" class="TableHdrCell" style="width:272px;" colspan="2">Last Run Info</th>
								<th id="thProcessSettingsCol113" class="TableHdrCell" style="width:52px;" rowspan="2">Active</th>
								<th id="thProcessSettingsCol114" class="TableHdrCell" style="width:156px;" rowspan="2">Action</th>
							</tr>
							<tr>
								<th id="thProcessSettingsCol200" class="TableHdrCell" style="width:70px;">Base Date</th>
								<th id="thProcessSettingsCol201" class="TableHdrCell" style="width:70px;">Base Time</th>
								<th id="thProcessSettingsCol202" class="TableHdrCell" style="width:70px;">End On</th>
								<th id="thProcessSettingsCol203" class="TableHdrCell" style="width:70px;">Begin Time 1</th>
								<th id="thProcessSettingsCol204" class="TableHdrCell" style="width:70px;">End Time 1</th>
								<th id="thProcessSettingsCol205" class="TableHdrCell" style="width:70px;">Begin Time 2</th>
								<th id="thProcessSettingsCol206" class="TableHdrCell" style="width:70px;">End Time 2</th>
								<th id="thProcessSettingsCol207" class="TableHdrCell" style="width:30px;">Sun</th>
								<th id="thProcessSettingsCol208" class="TableHdrCell" style="width:30px;">Mon</th>
								<th id="thProcessSettingsCol209" class="TableHdrCell" style="width:30px;">Tue</th>
								<th id="thProcessSettingsCol210" class="TableHdrCell" style="width:30px;">Wed</th>
								<th id="thProcessSettingsCol211" class="TableHdrCell" style="width:30px;">Thu</th>
								<th id="thProcessSettingsCol212" class="TableHdrCell" style="width:30px;">Fri</th>
								<th id="thProcessSettingsCol213" class="TableHdrCell" style="width:30px;">Sat</th>
								<th id="thProcessSettingsCol214" class="TableHdrCell" style="width:120px;">Initial</th>
								<th id="thProcessSettingsCol215" class="TableHdrCell" style="width:120px;">Rerun</th>
								<th id="thProcessSettingsCol216" class="TableHdrCell" style="width:50px;">Status</th>
								<th id="thProcessSettingsCol217" class="TableHdrCell" style="width:70px;">Ran On</th>
							</tr>
							</thead>
							<tbody id="tblProcessSettingsBd">
							</tbody>
							<tfoot id="tblProcessSettingsFt">
							</tfoot>
							</table>
						</td></tr></table>
<!-- #include file="../inc/incPaginationDiv4.inc" -->
					</div>

				</div>

			</div>

			<div id="divPAGEFOOTER" style="width:99%;margin-left:10px;margin-bottom:10px;">
				<label id="lblStatusMsg" style="color:maroon;font-size:12pt;font-weight:bold;"></label>
			</div>

			<footer>
					<div id="divMasterFooter" runat="server" style="border-top:1px solid gray;line-height:16px;margin:0px;font-size:9pt;">
					<table style="width:100%;padding:1px;border-spacing:0px;">
					<tr>
						<td style="width:50%;">
							&nbsp;Version&nbsp;<asp:Label ID="lblVersion" runat="server"></asp:Label>&nbsp;
							dated&nbsp;<asp:Label ID="lblVersionDate" runat="server"></asp:Label>&nbsp;
							Build:&nbsp;<asp:Label id="lblBuildNbr" runat="server"></asp:Label>&nbsp;
							&copy; <%: DateTime.Now.Year %> Northwest Hardwoods, Inc.
						</td>
						<td style="width:50%;text-align:right;">
							&nbsp;<label id="lblPageIDInFooter"></label>
							&nbsp;&nbsp;<span id="spnCurrDateNV" style="color:#A0A0A0;">&nbsp;</span>&nbsp;&nbsp;Session Start:&nbsp;<span id="clockNV" style="color:#A0A0A0;">&nbsp;</span>&nbsp;
						</td>
					</tr>
					</table>
					</div>
			</footer>

		</div>
  </form>
</body>
</html>
