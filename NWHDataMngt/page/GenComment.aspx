<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GenComment.aspx.cs" Inherits="DataMngt.page.GenComment" %>
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
	<script type="text/javascript" src="../Scripts/EditMacros.js?v=<%=BuildNbr %>"></script>
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

			.MillCommentsHdr {
				background-color:lightgray;
				border:1px solid gray;
				height:20px;
				text-align:center;
				font-weight:bold;
				vertical-align: middle;
			}

			.MillCommentText {
				padding:4px;
				height:120px;
				border:1px solid gray;
				vertical-align: top;
			}

		  .standalone-container {
		    margin: auto auto;
				max-width: 800px;
			}
			#bubble-container {
				height: 500px;
				font-size:11pt;
			}

	</style>

	<script type="text/javascript">
		var jbA = false;
		var jbAllLocations = false;
		var jbCanEdit = false;
		var jbCompanyWide = false;
		var jbEditingComment = false;
		var jbHadError = false;
		var jbNoEmptyProds = false;
		var jbPaginate = false;
		var jbtnAddNewGComment;
		var jbtnCommentContacts;
		var jbtnCommentSettings;
		var jbtnCreateWkRpt;
		var jbtnDecrementDateRange;
		var jbtnShowGlobalCmt;
		var jbtnIncrementDateRange;
		var jbtnShowWeeklyGrp;
		var jbtnShowYearlySchedule;
		var jbViewOnly = true;
		var jchkInsertGraphicOn;
		var jdivAdminLogs;
		var jdivCalendarSched;
		var jdivCommentContainer;
		var jdivCommentItemEdit;
		var jdivCommentList;
		var jdivCommentSettings;
		var jdivContactEditUser;
		var jdivContactsEdit;
		var jdivMainHdrSelects;
		var jdivProcessListHdr;
		var jdLastEndDate = new Date();
		var jdTarget = new Date();
		var jdToday = new Date();
		var jiActionStatusID = 0;	 // required for MyReturn analysis
		var jiAR = 0;
		var jiByID = 0;
		var jiCommentType = 0;
		var jiCurrentGrid = 0;
		var jiCurrentPos = 0;
		var jiCurrentVal = 0;
		var jiCommentLenWarn = 2000;
		var jiCommentLenMax = 2500;
		var jiCmtLenGlobalWarn = 2500;
		var jiCmtLenGlobalMax = 3000;
		var jiNbrPages = 0;
		var jiNbrRows = 0;
		var jiPageID = 44;
		var jiPageNbr = 0;
		var jiPageSize = 20;
		var jiActionStatusCode = '';	 // required for MyReturn analysis
		var jiActionStatusMsg = '';		 // required for MyReturn analysis
		var jiTotalRows = 0;
		var jiWeekNbr = 0;
		var jiUserID = 0;
		var jlCommentCreatedE;
		var jlCommentIDE;
		var jlCommentUpdatedE;
		var jlMillCmtDateBegin;
		var jlMillCmtDateEnd;
		var jlPageStatus;
		var jlSpecialNotationC;
		var jlStatusMsg;
		var jlWeekStatus;
		var jsBrowserType = '';
		var jsCurrentTime = '';
		var jselCalYear;
		var jselCommentActiveE;
		var jselCommentType;
		var jselCommentTypeE;
		var jselLocationCodeE;
		var jselLocationCodeF;
		var jselLocationContactE;
		var jselOriginatorID;
		var jselOrginatorListID;
		var jselPageSize;
		var jselTimePeriod;
		var jsErrorMsg = '';
		var jsGroupCode = '';
		var jsLastValue = '';
		var jsLocationCode = '';
		var jsPageVersion = '';
		var jsPageVersDate = '';
		var jspnGraphicsData;
		var jspnMillCmtDateRange;
		var jsRegionCode = '';
		var jsToday = '';
		var jsWeekStatus = 'O';
		var jtaCommentText;
		var jtblCommentEditHelp;
		var jtblCommentsCal;
		var jtblCommentsGroup;
		var jtblCommentList;
		var jtblCommentSettings;
		var jtblContactsEdit;
		var jtblMillSortOrder;
		var jtBeginDateF;
		var jtCommentDateE;
		var jtCommentTitleE;
		var jtEndDateF;
		var jtGraphicHeight;
		var jtGraphicWidth;

		var MyCalendarEvents;
		var MyCommentContacts;
		var MyCommentData;
		var MyCommentDataHQ;
		var MyCommentDataPrev;
		var MyCommentGroup;
		var MyCommentGrpList;
		var MyCommentList;
		var MyCommentTemplate;
		var MyCurrentWeekData;
		var MyDateRangeData;
		var MyDateRangeList;
		var MyLocationList;
		var MyReturn;
		var MySettingList;
		var MySortOrderList;
		var MyUserList;

		// Objects: 0-EmailAddresses, 1-EmailTemplates, 2-EmailTraffic, 3-NotificationTypes
		var counter = 0;
		var DayNamesNV = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

		// page initiation section --------------------------------------------------------------------------------
		$(document).ready(function () {
			jsToday = getMyDateTimeStringDm(jdToday, 18);
			jsCurrentTime = getMyDateTimeStringDm(jdToday, 7);
			//alert(jdToday + '/' + jsToday + '/' + jsCurrentTime);
			updateClockNV();
			KeepSessionAlive();

			// set global default values
			//alert('Ready starting');
			jiPageID = 44;
			jsPageVersion = '1.0.0';
			jsPageVersDate = '8/8/2017';
			jbViewOnly = true;
			jbCanEdit = false;
			//alert('loading seed values');
			// Load global page-loaded variables
			jiByID = jigEmpID;
			jsBrowserType = jsgBrowserType;
			//alert(jsBrowserType);
			jsLocationCode = jsgLoc;
			jsGroupCode = jsgGrp;
			//alert(jsGroupCode);
			if (jsgAr > 4 || jgA === 1) {
				jbA = true;
				jigCW = 1;
				//alert('Admin');
			}
			if (jsgAr > 2) { jbCanEdit = true; }
			if (jsgAr > 3) {
				jbAllLocations = true;
			}
			if (jigCW === 1) { jbA = true;}

			$('#Form1').on("submit", function (evt) {
				evt.preventDefault();
			});

			jbtnAddNewGComment = document.getElementById('btnAddNewGComment');
			jbtnCommentContacts = document.getElementById('btnCommentContacts');
			jbtnCommentSettings = document.getElementById('btnCommentSettings');
			jbtnCreateWkRpt = document.getElementById('btnCreateWkRpt');
			jbtnDecrementDateRange = document.getElementById('btnDecrementDateRange');
			jbtnShowGlobalCmt = document.getElementById('btnShowGlobalCmt');
			jbtnIncrementDateRange = document.getElementById('btnIncrementDateRange');
			jbtnShowWeeklyGrp = document.getElementById('btnShowWeeklyGrp');
			jbtnShowYearlySchedule = document.getElementById('btnShowYearlySchedule');
			jchkInsertGraphicOn = document.getElementById('chkInsertGraphicOn');
			jdivCalendarSched = document.getElementById('divCalendarSched');
			jdivCommentContainer = document.getElementById('bubble-container');
			jdivCommentItemEdit = document.getElementById('divCommentItemEdit');
			jdivCommentList = document.getElementById('divCommentList');
			jdivCommentSettings = document.getElementById('divCommentSettings');
			jdivContactEditUser = document.getElementById('divContactEditUser');
			jdivContactsEdit = document.getElementById('divContactsEdit');
			jdivMainHdrSelects = document.getElementById('divMainHdrSelects');
			jdivProcessListHdr = document.getElementById('divProcessListHdr');
			jlCommentCreatedE = document.getElementById('lblCommentCreatedE');
			jlCommentIDE = document.getElementById('lblCommentIDE');
			jlCommentUpdatedE = document.getElementById('lblCommentUpdatedE');
			jlMillCmtDateBegin = document.getElementById('lblMillCmtDateBegin');
			jlMillCmtDateEnd = document.getElementById('lblMillCmtDateEnd');
			jlPageStatus = document.getElementById('lblPageStatus');
			jlSpecialNotationC = document.getElementById('lblSpecialNotationC');
			jlStatusMsg = document.getElementById('lblStatusMsg');
			jlWeekStatus = document.getElementById('lblWeekStatus');
			jselCalYear = document.getElementById('selCalYear');
			jselCommentActiveE = document.getElementById('selCommentActiveE');
			jselCommentType = document.getElementById('selCommentType');
			jselCommentTypeE = document.getElementById('selCommentTypeE');
			jselLocationCodeE = document.getElementById('selLocationCodeE');
			jselLocationCodeF = document.getElementById('selLocationCodeF');
			jselLocationContactE = document.getElementById('selLocationContactE');
			jselOriginatorID = document.getElementById('selOriginatorID');
			jselOrginatorListID = document.getElementById('selOrginatorListID');
			jselTimePeriod = document.getElementById('selTimePeriod');
			jspnGraphicsData = document.getElementById('spnGraphicsData');
			jspnMillCmtDateRange = document.getElementById('spnMillCmtDateRange');
			jtaCommentText = document.getElementById('txaCommentE');
			jtblCommentEditHelp = document.getElementById('tblCommentEditHelp');
			jtblCommentsCal = document.getElementById('tblCommentsCalendar');
			jtblCommentsGroup = document.getElementById('tblCommentsGroup');
			jtblCommentList = document.getElementById('tblCommentList');
			jtblCommentSettings = document.getElementById('tblCommentSettings');
			jtblContactsEdit = document.getElementById('tblContactsEdit');
			jtblMillSortOrder = document.getElementById('tblMillSortOrder');
			jtBeginDateF = document.getElementById('txtBeginDateF');
			jtCommentDateE = document.getElementById('txtCommentDateE');
			jtCommentTitleE = document.getElementById('txtCommentTitleE');
			jtEndDateF = document.getElementById('txtEndDateF');
			jtGraphicHeight = document.getElementById('txtGraphicHeight');
			jtGraphicWidth = document.getElementById('txtGraphicWidth');

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
			switch (key) {
				case 13:
					return false;
					break;
				case 9: //tab
					return false;
					break;
				default:
					return true;
					break;
			}
		}

		function stopRKey(evt) {
			//alert('Fired!');
			var evt2 = (evt) ? evt : ((event) ? event : null);
			var node = (evt2.target) ? evt2.target : ((evt2.srcElement) ? evt2.srcElement : null);
			if ((evt2.keyCode == 13) && (node.type == "text")) { return false; }
		}

		function HandleTabKey(evt) {
			var evt2 = (evt) ? evt : ((event) ? event : null);
			var node = (evt2.target) ? evt2.target : ((evt2.srcElement) ? evt2.srcElement : null);
			if ((evt2.keyCode == 13) && (node.type == "text")) { return false; }
			if ((evt2.keyCode == 9) && (jbEditingComment === true)) {
				var strPos = jtaCommentText.selectionStart;
				var start = jtaCommentText.selectionStart;
				var end = jtaCommentText.selectionEnd;
				var sfirst = jtaCommentText.value.substring(0, start);
				var slast = jtaCommentText.value.substring(end);
				//alert(sfirst + '/' + slast);
				jtaCommentText.innerHTML = sfirst + '    ' + slast;
				jtaCommentText.selectionStart = strPos+4;
				jtaCommentText.selectionEnd = strPos+4;
				jtaCommentText.focus();
				event.preventDefault();
			}
			if (evt2.ctrlKey && (jbEditingComment === true)) {
				jsLastValue = jtaCommentText.value;
				var val = String.fromCharCode(event.which).toLowerCase();
				var iloc = jtaCommentText.selectionStart;
				//var strPos = jtaCommentText.selectionStart;
				GetMacroTextEM(0, 1, val, jtaCommentText, iloc);
				event.preventDefault();
			}
			if (evt2.altKey && (jbEditingComment === true)) {
				jsLastValue = jtaCommentText.value;
				var val = String.fromCharCode(event.which).toLowerCase();
				var iloc = jtaCommentText.selectionStart;
				GetMacroTextEM(1, 0, val, jtaCommentText, iloc);
				event.preventDefault();
			}
			//evt.stopPropagation();
		}

		document.onkeypress = stopRKey;
		document.onkeydown = HandleTabKey;

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
			var val = '';
			//alert('beginning initiation');
			if (jbA !== true) {
				jbtnShowWeeklyGrp.style.display = 'none';
				jbtnCommentSettings.style.display = 'none';
				jbtnAddNewGComment.style.display = 'none';
				jbtnCreateWkRpt.style.display = 'none';
				jbtnShowGlobalCmt.style.display = 'none';
				jbtnCommentContacts.style.display = 'none';
			}
			if (jbA === true || jigCW === true) {
				jselLocationCodeE.options[0].innerHTML = 'Company Comment';
				jselLocationCodeE.options[0].value = 'HQ';
				jbtnCommentSettings.style.display = 'inline';
				//jbtnShowWeeklyGrp.style.display = 'inline';
				jbtnAddNewGComment.style.display = 'inline';
				//jbtnShowGlobalCmt.style.display = 'inline';
				jbtnCommentContacts.style.display = 'inline';
			}

			jiPgNbrPj[0] = 0;
			jiNbrPagesPj[0] = 0;
			jiNbrRowsPj[0] = 0;
			jiNbrPagesPj[1] = 0;
			jiNbrRowsPj[1] = 0;
			jiPageSize = 20;
			jiCommentType = parseInt(jselCommentType.value, 10);
			//alert(jiCommentType);
			var yr = jdToday.getFullYear();
			jselCalYear.value = yr.toString();

			//alert('set 1');
			EstablishMainPgElementsPj(1, 0);
			EstablishMainPgElementsPj(2, 0);
			var typ = jselCommentType.value;
			try {
				//alert('locations list');
				PopulateLocationList();
				//alert(jsLocationCode)
				jselLocationCodeE.value = jsLocationCode;
				jselLocationCodeF.value = jsLocationCode;
			}
			catch (ex) {
				alert(ex); // nothing
			}
			//alert('user list');
			PopulateUserList();

			//alert('loc list');
			//alert('comment list');
			var dMonday = getLastMondayDm(jdToday);
			var dWednesday = dMonday.addDays(3);
			//alert(dWednesday);
			dMonday.addDays(-2);
			//alert(dMonday);
			GetCurrentMngtWeek();
			if (!IsContentsNullUndefEmptyGu(MyCurrentWeekData)) {
				jiYear = parseInt(MyCurrentWeekData[0]['CalendarYear'], 10);
				jiMonth = parseInt(MyCurrentWeekData[0]['CalendarMonth'], 10);
				jiDayNbr = parseInt(MyCurrentWeekData[0]['DayInMonth'], 10);
				jsMonthName = MyCurrentWeekData[0]['MonthStrName'].toString();
				jsDayName = MyCurrentWeekData[0]['DayInWeekName'].toString();
				jdLastEndDate = new Date(jiYear, jiMonth, jiDayNbr, 1, 1, 1, 0);
				jsLastEndDate = MyCurrentWeekData[0]['sRptEndDate'].toString();
				val = MyCurrentWeekData[0]['RptStatusCode'].toString();
				switch (val) {
					case 'O':
						jlWeekStatus.innerHTML = 'Open';
						break;
					case 'C':
						jlWeekStatus.innerHTML = 'Closed';
						break;
					default:
						jlWeekStatus.innerHTML = 'UNKNOWN';
						break;
				}

				jsWeekStatus = MyCurrentWeekData[0]['RptStatusCode'].toString();
			}
			else {
				jdLastEndDate = dMonday.addDays(-1);
				jsLastEndDate = getMyDateTimeStringDm(jdLastEndDate, 8);
				jlWeekStatus.innerHTML = 'Open';
				jsWeekStatus = 'O';
			}
			val = '';
			GetDateRangeForMillCmt(getMyDateTimeStringDm(jdLastEndDate, 8));
			ChangeTargetDateRange(jsLastEndDate);
			//alert(jsLastEndDate);
			document.getElementById('lblCurrentWeekDue').innerHTML = jsLastEndDate;
			PopulateTimePeriodList();
			jselTimePeriod.value = jsLastEndDate;
			//alert(jdLastEndDate);
			if (dWednesday > jdToday) {
				jbtnCreateWkRpt.style.display = 'none';
			}

			createDatePickerOnTextWc('txtBeginDateF', null, null, 0, 3, 'show', 11);
			createDatePickerOnTextWc('txtEndDateF', null, null, 0, 3, 'show', 12);
			createDatePickerOnTextWc('txtCommentDateE', null, null, 0, 1, 'show', 16);

			DataCall1();
			GetSettingsList(0);
			if (!IsContentsNullUndefEmptyGu(MySettingList)) {
				for (var i = 0; i < MySettingList.length; i++) {
					if (MySettingList[i]['SettingCode'].toString() === 'GenCmtWarnLen') { jiCommentLenWarn = parseInt(MySettingList[0]['SettingValue'], 10); }
					if (MySettingList[i]['SettingCode'].toString() === 'GenCmtMaxLen') { jiCommentLenMax = parseInt(MySettingList[0]['SettingValue'], 10); }
					if (MySettingList[i]['SettingCode'].toString() === 'GblCmtWarnLen') { jiCmtLenGlobalWarn = parseInt(MySettingList[0]['SettingValue'], 10); }
					if (MySettingList[i]['SettingCode'].toString() === 'GblCmtMaxLen') { jiCmtLenGlobalMax = parseInt(MySettingList[0]['SettingValue'], 10); }
				}
				//jiCmtLenGlobalMax =
				//jiCmtLenGlobalWarn = 
				//jiCommentLenMax = 
				
			}
			jdivCommentList.style.display = 'block';

			//alert('Initiation done');
			jlPageStatus.innerHTML = 'Page Ready';
			document.getElementById('lblPageIDInFooter').innerHTML = 'Page ID: ' + jiPageID.toString();
			return false;
		}
		// END of page initiation section --------------------------------------------------------------------------------

		// **************************** AJAX FUNCTIONS *********************************

		function DataCall1() {
			jiPageNbr = jiPgNbrPj[0];
			var typ = jselCommentType.value;
			//alert('Page ' + jiPageNbr + '/' + typ);
			GetCommentList(0, typ, '', 0, 0, 1);
			PopulateCommentList();
			return false;
		}

		function DataCall2() {
			jiPageNbr = jiPgNbrPj[1];
			GetSettingsList(0);
			PopulateSettingsList();
			return false;
		}

		function GetCalendarEvents() {
			var typ = jselCommentType.value;
			var yr = jselCalYear.value;
			var url = "../shared/AdminServices.asmx/SelectCalendarEvents";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','CalType':'" + typ + "','Yr':'" + yr + "','Mo':'0','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCalendarEvents = response; });
			return false;
		}

		function GetCommentGroup() {
			var sdtB = jtBeginDateF.value;
			var sdtE = jtEndDateF.value;
			var loc = '';
			var url = "../shared/GridSupportServices.asmx/SelectCommentList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ID':'0','CmtType':'1','Title':'','UserID':'0','sDtB':'" + sdtB + "','sDtE':'" + sdtE + "','Loc':'" + loc + "','Sort':'9','Active':'1',";
			MyData = MyData + "'PgNbr':'0','PgSize':'999','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCommentGrpList = response; });
			return false;
		}

		function GetCommentList(id, typ, ttl, usrid, sort, act) {
			//alert('pulling comments');
			var sdtB = jtBeginDateF.value;
			//alert('1');
			var sdtE = jtEndDateF.value;
			//alert('url');
			var loc = jselLocationCodeF.value;
			if (sdtB === '' && sdtE === '') {
				sdtE = jsLastEndDate;
				sdtB = jsLastBeginDate;
			}
			var url = "../shared/GridSupportServices.asmx/SelectCommentList";
			//alert('forming mydata');
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ID':'" + id.toString() + "','CmtType':'" + typ.toString() + "','Title':'" + ttl + "','UserID':'" + usrid.toString() + "','sDtB':'" + sdtB + "',";
			MyData = MyData + "'sDtE':'" + sdtE + "','Loc':'" + loc + "','Sort':'" + sort.toString() + "','Active':'" + act.toString() + "','PgNbr':'" + jiPgNbrPj[0].toString() + "','PgSize':'" + jiPageSize.toString() + "',";
			MyData = MyData + "'ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCommentList = response; });
			return false;
		} 

		function GetComment(id, typ, ttl, usrid, loc, sort, act) {
			//alert('pulling comments');
			//var sdtB = jlM jlMillCmtDateBegin.innerHTML;
			//var sdtE = jlMillCmtDateEnd.innerHTML;
			var sdtB = jtBeginDateF.value;
			var sdtE = jtEndDateF.value;
			if (sdtB === '' && sdtE === '') {
				sdtE = jsLastEndDate;
				sdtB = jsLastBeginDate;
			}
			//alert('url');
			var url = "../shared/GridSupportServices.asmx/SelectCommentList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ID':'" + id.toString() + "','CmtType':'" + typ.toString() + "','Title':'" + ttl + "','UserID':'" + usrid.toString() + "','sDtB':'" + sdtB + "',";
			MyData = MyData + "'sDtE':'" + sdtE + "','Loc':'" + loc + "','Sort':'" + sort.toString() + "','Active':'" + act.toString() + "','PgNbr':'0','PgSize':'999','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCommentData = response; });
			return false;
		} 

		function GetCommentContacts(id, loc) {
			var url = "../shared/GridSupportServices.asmx/SelectCommentContactList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ID':'" + id.toString() + "','LocCode':'" + loc + "','Sort':'0','Active':'1','PgNbr':'0',";
			MyData = MyData + "'PgSize':'999','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCommentContacts = response; });
			return false;
		}

		function GetCommentHQ(id, typ, dte) {
			var url = "../shared/GridSupportServices.asmx/SelectCommentList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ID':'" + id.toString() + "','CmtType':'" + typ.toString() + "','Title':'','UserID':'0','sDtB':'',";
			MyData = MyData + "'sDtE':'" + dte + "','Loc':'HQ','Sort':'92','Active':'1','PgNbr':'0','PgSize':'999','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCommentDataHQ = response; });
			return false;
		}

		function GetCommentPrev(typ, usrid, loc) {
			//alert('pulling comments');
			var url = "../shared/GridSupportServices.asmx/SelectCommentList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ID':'0','CmtType':'" + typ.toString() + "','Title':'','UserID':'" + usrid.toString() + "','sDtB':'',";
			MyData = MyData + "'sDtE':'','Loc':'" + loc + "','Sort':'91','Active':'1','PgNbr':'0','PgSize':'999','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCommentDataPrev = response; });
			return false;
		}

		function GetCommentTemplate() {
			var url = "../shared/AdminServices.asmx/SelectWebAppSetting";
			//alert('forming mydata');
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','AppArea':'CommentMngt','DBID':'999','Code':'GenCmtTemplate','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCommentTemplate = response; });
			return false;
		}

		function GetDateRangeForMillCmt(tdt) {
			var url = "../shared/GridSupportServices.asmx/SelectDateRangeForMillCmt";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','TargetDt':'" + tdt + "','NbrInList':'150','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyDateRangeData = response; });
			return false;
		}
                    
		function GetDateRangeList() {
			var url = "../shared/GridSupportServices.asmx/SelectDateRangeForMillCmtList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','TargetDt':'" + jsLastEndDate + "','NbrInList':'150','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyDateRangeList = response; });
			return false;
		}

		function GetCurrentMngtWeek() {
			var url = "../shared/GridSupportServices.asmx/SelectCurrentMngtWeekData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCurrentWeekData = response; });
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

		function GetLocationList(loc, reg, ctry, city) {
			var url = "../shared/AdminServices.asmx/SelectLocationListL";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','Loc':'" + loc + "','LocType':'','Country':'" + ctry + "','City':'" + city + "','Class':'4','Sort':'0',";
			MyData = MyData + "'Active':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyLocationList = response; });
			return false;
		}	

		function GetSortOrderList() {
			var url = "../shared/AdminServices.asmx/SelectSortOrderList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','UserID':'" + jiByID.toString() + "','AppArea':'CommentMngt','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MySortOrderList = response; });
			return false;
		}
		
		function GetUserLocationList(grp) {
			var url = "../shared/AdminServices.asmx/SelectUserLocationAccessList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','UserID':'" + jiByID.toString() + "','Grp':'" + grp + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyLocationList = response; });
			return false;
		}

		function GetSettingsList(sort) {
			var url = "../shared/AdminServices.asmx/SelectSettingList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','AppArea':'CommentMngt','ID':'0','Sort':'" + sort.toString() + "','Active':'2','PgNbr':'" + jiPgNbrPj[1].toString() + "',";
			MyData = MyData + "'PgSize':'" + jiPageSize.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MySettingList = response; });
			return false;
		}

		function GetUserList(id, nm, ctry, city, loc, pos, grp, sort, act) {
			var url = "../shared/AdminServices.asmx/SelectUserList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ID':'" + id.toString() + "','Name':'" + nm + "','Ctry':'" + ctry + "','City':'" + city + "','Loc':'" + loc + "','Pos':'" + pos + "','Grp':'" + grp + "',";
			MyData = MyData + "'Sort':'" + sort.toString() + "','Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyUserList = response; });
			return false;
		}

		function CreateWeeklyReport(id, sorder) {
			var url = "../shared/GridSupportServices.asmx/CreateWeeklyReport";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			return false;
		}

		function ChangeContactForLocation(id, userid, typ) {
			var url = "../shared/AJAXServices.asmx/ChangeLocationContact";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ID':'" + id.toString() + "','UserID':'" + userid.toString() + "','iType':'" + typ.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			return false;
		}

		function UpdateComment(id, act, cmt, ttl, loc, typ, sDt, origid, igrph, gwdth, ght) {
			//alert(loc);
			if (loc === 'HQ') {
				//cmt = cmt.replace(/(?:\r\n|\r|\n)/g, '<br />');
				cmt = ChangeCmtForSaveHQ(cmt);
			}
			//alert(cmt);
			cmt = PrepareJSONForHTMLTx(cmt, 2);
			ttl = PrepareJSONForHTMLTx(ttl, 2);
			var url = "../shared/GridSupportServices.asmx/UpdateComment";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ID':'" + id.toString() + "','iType':'0','CmtType':'" + typ.toString() + "','Title':'" + ttl + "','Loc':'" + loc + "','Comment':'" + cmt + "',";
			MyData = MyData + "'InsGraph':'" + igrph.toString() + "','Wdth':'" + gwdth.toString() + "','Ht':'" + ght.toString() + "','TDt':'" + sDt + "','OrigID':'" + origid.toString() + "','Active':'" + act.toString() + "',";
			MyData = MyData + "'ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			EvaluateStdDatabaseReturnAs(MyReturn, jlStatusMsg, 'An error stopped database update', 'Unexpected return from update attempt. The data was probably not updated.', 'Update failed. Please check status for more information.');
			return false;
		}

		function UpdateMillSortOrder(id, sorder) {
			var url = "../shared/AJAXServices.asmx/UpdateSortOrder";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ID':'" + id.toString() + "','SortOrder':'" + sorder.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			return false;
		}

		function UpdateScheduleDate(yr, mo, dy, chkd) {
			//alert('fired update');
			var isChecked = 0;
			if (chkd === true) { isChecked = 1;}
			var url = "../shared/GridSupportServices.asmx/UpdateScheduleDate";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','Yr':'" + yr.toString() + "','Mo':'" + mo.toString() + "','Dy':'" + dy.toString() + "','Typ':'1','Checked':'" + isChecked.toString() + "','Action':'0','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			return false;
		}

		function UpdateSetting(id, val) {
			var isChecked = 0;
			if (chkd === true) { isChecked = 1; }
			var url = "../shared/AdminServices.asmx/UpdateSetting";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ID':'" + id.toString() + "','Value':'" + val + "','ByID':'" + jiByID.toString() + "'}";
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

		function PopulateCommentList() {
			//alert('Filling Proc List');
			var CanEdit = jbCanEdit;
			var cellClass = 'StdTableCell';
			var nCol = 11;
			var nbritems = 0;
			// Cols: 0-ID, 1-Type, 2-Loc, 3-Title, 4-Comment, 5-CmtDate, 6-OriginatedDate, 7-OrigByName, 8-LastUpdated, 9-Active, 10-Action
			//alert('arrays');
			var cWidth = [50, 86, 46, 200, 600, 72, 72, 130, 72, 44, 41, 0, 0, 0, 0, 0, 0];
			var corientH = ['center', 'center', 'center', 'left', 'left', 'center', 'center', 'left', 'center', 'center', 'center', 'center', 'center', 'center', '', ''];
			var corientV = ['top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', '', ''];
			var cbrdrL = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrR = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrT = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrB = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', ''];
			var cnames = ['CommentID', 'sCommentType', 'LocCode', 'CommentTitle', 'Comment', 'sCommentDate','sOriginatedDate', 'sOrigFullName', 'sUpdatedDate', 'sActive', 'ACTION', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cType = [0, 0, 0, 0, 99, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var aggType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var shown = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
			//alert('DDL list data');

			if (MyCommentList !== undefined && MyCommentList !== null) {
				nbritems = MyCommentList.length;
				//alert('List Len: ' + MyCommentList.length);
				var bdy = FormDataGridBodyMinimumDg(1, nCol, 'tdCommentList', cellClass, CanEdit, CanEdit, false, false, '', 'button blue-gradient glossy', false, 0, MyCommentList, 'CommentID', cnames, cType, cWidth, corientH, corientV, cbrdrL, cbrdrR, cbrdrT, cbrdrB, aggType, shown, true, false);
				//alert('Grid done');
				jtblCommentList.style.display = 'block';
			}
			else {
				alert('Comment List bad data');
				ShowStatusMsg('An unidentified error occurred. No records could be extracted.');
			}
			//alert('Attaching body');
			try {
				var oldBody = jtblCommentList.getElementsByTagName("tbody")[0];
				jtblCommentList.replaceChild(bdy, oldBody);
			}
			catch (ex) {
				// nothing
			}
			joPgNbrLblPj.innerHTML = (jiPgNbrPj[0]+1).toString();
			joMaxPgNbrLblPj.innerHTML = jiNbrPagesPj[0].toString();

			// inactivate buttons if the week is not open
			//alert(jsWeekStatus + '/' + nbritems);
			if (jsWeekStatus !== 'O' && nbritems > 0) {
				var btn;
				var btn2;
				//alert('changing');
				for (var i = 0; i < nbritems; i++) {
					btn = document.getElementById('btnDeleteRow' + i.toString() + '_1');
					btn2 = document.getElementById('btnEditRow' + i.toString() + '_1');
					btn.style.display = 'none';
					btn2.style.display = 'none';
				}
			}

			return false;
		}

		function PopulateCommentsGrp() {
			var cmt = '';
			var nbritems = 0;
			var sRow = '';
			var ttl = '';
			//alert('populating...');
			if (!IsContentsNullUndefEmptyTx(MyCommentGrpList)) {
				EmptyCommentsGroup();
				//alert('filling blocks');
				for (var row = 0; row < MyCommentGrpList.length; row++) {
					//alert(MyCommentGrpList[row]['CommentID'].toString());
					if (parseInt(MyCommentGrpList[row]['CommentID'], 10) !== 0) {
						//alert('Fired!');
						nbritems++;
						sRow = nbritems.toString();
						if (sRow.length === 1) { sRow = '0' + sRow; }
						//alert(sRow);
						ttl = MyCommentGrpList[row]['LocationDesc'].toString();
						ttl = ttl.replace('Sawmill', '').replace('Mill', '');
						ttl = RTrimTx(ttl.replace('Yard', ''));
						cmt = MyCommentGrpList[row]['Comment'].toString().replace(/(\n)+/g, '<br />');
						document.getElementById('lblMillComment' + sRow).innerHTML = ttl;
						document.getElementById('tdMillComment' + sRow).innerHTML = cmt;
						if (nbritems > 3) {
							document.getElementById('tdMillCommentHdr' + sRow).style.display = 'table-column';
							document.getElementById('tdMillComment' + sRow).style.display = 'table-column';
						}
					}
				}
			}
			return false;
		}

		function PopulateCommentContacts() {
				//alert('Filling Proc List');
			var cellClass = 'StdTableCell';
			var nCol = 8;
			// Cols: 0-ID, 1-Loc, 2-City, 3-St, 4-Person, 5-Position, 6-Email, 7-Action
			//alert('arrays');
			var cWidth = [60, 230, 90, 40, 200, 240, 170, 80, 0, 0, 0, 0, 0, 0, 0, 0];
			var corientH = ['center', 'left', 'left', 'left', 'left', 'left', 'left', 'center', 'center', 'center', 'center', 'center', 'center', '', ''];
			var corientV = ['top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', '', '', ''];
			var cbrdrL = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrR = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrT = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrB = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cnames = ['RowID', 'LocationDesc', 'City', 'StateProv', 'sCFullName', 'EmpPosition', 'EmailAddress', 'ACTION', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var aggType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var shown = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]

			if (MyCommentContacts !== undefined && MyCommentContacts !== null) {
				//alert('grid time - #: ' + MyCommentContacts.length.toString());
				var bdy = FormDataGridBodyMinimumDg(6, nCol, 'tdCommentCList', cellClass, true, true, false, false, '', 'button blue-gradient glossy', false, 0, MyCommentContacts, 'SortOrderID', cnames, cType, cWidth, corientH, corientV, cbrdrL, cbrdrR, cbrdrT, cbrdrB, aggType, shown, false, true);
				//alert('Grid done');
				jtblContactsEdit.style.display = 'block';
			}
			else {
				//alert('Comment Contact List bad data');
				ShowStatusMsg('An unidentified error occurred. No records could be extracted.');
			}
			//alert('Attaching body');
			try {
				var oldBody = jtblContactsEdit.getElementsByTagName("tbody")[0];
				jtblContactsEdit.replaceChild(bdy, oldBody);
			}
			catch (ex) {
				// nothing
			}
			return false;
		}

		function EmptyCommentsGroup() {
			var sRow = '';
			for (var row = 1; row <= 24; row++) {
				sRow = row.toString();
				if (sRow.length === 1) { sRow = '0' + sRow;}
				//alert(sRow);
				document.getElementById('lblMillComment' + sRow).innerHTML = '';
				document.getElementById('tdMillComment' + sRow).innerHTML = '';
				if (row > 3) {
					//alert('tdMillCommentHdr' + sRow);
					document.getElementById('tdMillCommentHdr' + sRow).style.display = 'none';
					//alert('2');
					document.getElementById('tdMillComment' + sRow).style.display = 'none';
				}
			}
			return false;
		}

		function PopulateLocationList() {
			if (jbA === true || jigCW === true) {
				GetLocationList('', '', '', '');
			}
			else {
				GetUserLocationList('cmtmngtedt');
			}
			//alert('locations lists');
			if (MyLocationList !== undefined && MyLocationList !== null) {
				// edit list
				ClearDDLOptionsGu('selLocationCodeE', 1);
				fillDropDownListGu(MyLocationList, jselLocationCodeE, 0, 'GenericName', 'LocationCode');
				// filter
				ClearDDLOptionsGu('selLocationCodeF', 1);
				fillDropDownListGu(MyLocationList, jselLocationCodeF, 0, 'GenericName', 'LocationCode');
				if (jbA === true || jigCW === true) {
					appendDDLOptionGu(jselLocationCodeF, 'HQ', 'Headquarters');
				}
			}
			return false;
		}

		function PopulateSettingsList() {
			//alert('Filling settings List');
			var cellClass = 'StdTableCell';
			var nCol = 5;
			// Cols: 0-ID, 1-Setting, 2-Value, 3-Type, 4-Active
			//alert('arrays');
			var cWidth = [56, 260, 260, 80, 56, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var corientH = ['center', 'left', 'left', 'center', 'center', 'left', 'left', 'left', 'left', 'center', 'center', 'left', '', '', ''];
			var corientV = ['top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', '', '', '', ''];
			var cbrdrL = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrR = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrT = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrB = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cnames = ['SettingID', 'SettingName', 'SettingValue', 'DataType', 'sActive', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cType = [0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var aggType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var shown = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
			//alert('DDL list data');

			if (MySettingList !== undefined && MySettingList !== null) {
				//alert('List Len: ' + MySettingList.length);
				var bdy = FormDataGridBodyMinimumDg(2, nCol, 'tdSettingList', cellClass, false, false, true, false, '', 'button blue-gradient glossy', false, 0, MySettingList, 'SettingID', cnames, cType, cWidth, corientH, corientV, cbrdrL, cbrdrR, cbrdrT, cbrdrB, aggType, shown, true, true);
				//alert('Grid done');
				jtblCommentSettings.style.display = 'block';
			}
			else {
				alert('Comment List bad data');
				ShowStatusMsg('An unidentified error occurred. No records could be extracted.');
			}
			//alert('Attaching body');
			try {
				var oldBody = jtblCommentSettings.getElementsByTagName("tbody")[0];
				jtblCommentSettings.replaceChild(bdy, oldBody);
			}
			catch (ex) {
				// nothing
			}
			joPgNbrLblPj.innerHTML = (jiPgNbrPj[1]+1).toString();
			joMaxPgNbrLblPj.innerHTML = jiNbrPagesPj[1].toString();
			return false;
		}

		function PopulateSortOrderList() {
			var bkColor = '#FFFFFF';
			var brdr = '1px solid gray';
			var cell;
			var collen = 0;
			var colspn = '';
			var disp = '';
			var dsabld = false;
			var fontSz = '12pt';
			var frColor = '#000000';
			var hAlign = 'left';
			var ht = 16;
			var id = 0;
			var IsBold = false;
			var IsVisible = true;
			var loc = '';
			var noWrap = '';
			var ovrflw = '';
			var padb = '1px';
			var padl = '2px';
			var padr = '2px';
			var padt = '1px';
			var RdOnly = false;
			var rowlen = 0;
			var sRow = '';
			var sRow2 = '';
			var tr;
			var val = '';
			var vAlign = 'top';
			var wdth = 0;
			//alert('getting sort data');
			GetSortOrderList();
			//alert('got sort data');
			var bdy = document.createElement("tbody");
			//alert(MySortOrderList.length);
			if (!IsContentsNullUndefinedTx(MySortOrderList)) {
				rowlen = MySortOrderList.length;
				collen = parseInt((rowlen + 1) / 2, 10) + 1;
				//alert(rowlen + '/' + collen);
				if (rowlen > 0) {
					for (var row = 0; row < collen; row++) {
						sRow = row.toString();
						sRow2 = (row+collen).toString();
						//alert(sRow);
						if (sRow.length < 2) { sRow = '0' + sRow; }
						if (sRow2.length < 2) { sRow2 = '0' + sRow2; }
						tr = document.createElement("tr");
						loc = '';
						loc = MySortOrderList[row]['RowCode'].toString();
						//alert('creating cell - ' + MySortOrderList[row]['RowCode'].toString());
						cell = createNewCellDg('trSortOrderR' + sRow + '00', '16px', '70px', loc, bkColor, frColor, brdr, brdr, brdr, brdr, 'center', vAlign, padl, padr, padt, padb, fontSz, IsBold, false, ovrflw, RdOnly, dsabld, '', colspn, 'StdTableCell', disp, noWrap);
						tr.appendChild(cell);
						val = '';
						val = '<input type="text" id="rxtMillO' + sRow + '" value="' + MySortOrderList[row]['RowOrder'].toString() + '" onfocus="javascript:jiCurrentVal=parseInt(this.value, 10);return false;" onchange="javascript:ChangeMillOrder(' + StringifyTx(loc) + ',' + StringifyTx(sRow) + ',this.value);return false;" style="width:40px;" />';
						cell = createNewCellDg('trSortOrderR' + sRow + '01', '16px', '46px', val, bkColor, frColor, brdr, brdr, brdr, brdr, hAlign, vAlign, padl, padr, padt, padb, fontSz, IsBold, false, ovrflw, RdOnly, dsabld, '', colspn, 'StdTableCell', disp, noWrap);
						tr.appendChild(cell);
						cell = createNewCellDg('trSortOrderR' + sRow + '02', '16px', '10px', '', '#000000', 'white', brdr, brdr, brdr, brdr, 'center', vAlign, padl, padr, padt, padb, fontSz, IsBold, false, ovrflw, RdOnly, dsabld, '', colspn, 'StdTableCell', disp, noWrap);
						tr.appendChild(cell);
						loc = '';
						if (row + collen < rowlen) {
							loc = MySortOrderList[row + collen]['RowCode'].toString();
						}
						//alert('creating cell - ' + MySortOrderList[row]['RowCode'].toString());
						cell = createNewCellDg('trSortOrderR' + sRow + '03', '16px', '70px', loc, bkColor, frColor, brdr, brdr, brdr, brdr, 'center', vAlign, padl, padr, padt, padb, fontSz, IsBold, false, ovrflw, RdOnly, dsabld, '', colspn, 'StdTableCell', disp, noWrap);
						tr.appendChild(cell);
						val = '';
						if (row + collen < rowlen) {
							val = '<input type="text" id="rxtMillO' + sRow2 + '" value="' + MySortOrderList[row + collen]['RowOrder'].toString() + '" onfocus="javascript:jiCurrentVal=parseInt(this.value, 10);return false;" onchange="javascript:ChangeMillOrder(' + StringifyTx(loc) + ',' + StringifyTx(sRow2) + ',this.value);return false;" style="width:40px;" />';
						}
						cell = createNewCellDg('trSortOrderR' + sRow + '04', '16px', '46px', val, bkColor, frColor, brdr, brdr, brdr, brdr, 'center', vAlign, padl, padr, padt, padb, fontSz, IsBold, false, ovrflw, RdOnly, dsabld, '', colspn, 'StdTableCell', disp, noWrap);
						tr.appendChild(cell);
						bdy.appendChild(tr);
					}
				}
			}
			var oldBody = jtblMillSortOrder.getElementsByTagName("tbody")[0];
			jtblMillSortOrder.replaceChild(bdy, oldBody);
			return false;
		}

		function PopulateTimePeriodList() {
			GetDateRangeList();
			if (MyDateRangeList !== undefined && MyDateRangeList !== null) {
				// edit list
				ClearDDLOptionsGu('selTimePeriod', 1);
				fillDropDownListGu(MyDateRangeList, jselTimePeriod, 0, 'sEndDate', 'sEndDate');
			}
			return false;
		}

		function PopulateUserList() {
			GetUserList(0, '', '', '', '', '', '', 0, 1);
			if (MyUserList !== undefined && MyUserList !== null) {
				ClearDDLOptionsGu('selOrginatorListID', 1);
				fillDropDownListGu(MyUserList, jselOrginatorListID, 0, 'UserFullName', 'UserID');
				// location contact user list
				ClearDDLOptionsGu('selLocationContactE', 1);
				fillDropDownListGu(MyUserList, jselLocationContactE, 0, 'UserFullName', 'UserID');
				// Orig edit select
				ClearDDLOptionsGu('selOriginatorID', 1);
				fillDropDownListGu(MyUserList, jselOriginatorID, 0, 'UserFullName', 'UserID');
			}
			return false;
		}

		// **************************** Dialogs *********************************

		function ActivateHyperlink(id, objid, val1, val2, val3) {
			return false;
		}

		function ChangeCheckBox(id, objid, val, ischecked) {
			return false;
		}

		function ChangeDropDownVal(id, objid, row, col, val) {
			switch (objid) {
				case 93:
					//alert('Fired!');
					UpdateUserRightLevel(id, val);
					break;
				default:
					break;
			}
			return false;
		}

		function ChangeInputVal(id, row, col, objid, val) {
			switch (objid) {
				case 1:
					break;
				case 2:
					UpdateSetting(id, val);
					break;
				default:
					break;
			}
			return false;
		}

		function ChangeMillOrder(loc, sRow, val) {
			//alert('Fired!');
			var f = 0;
			var found = 0;
			var sRowx = '';
			if (TryParseIntNf(val, 0) !== 0) {
				var newVal = parseInt(val, 10);
				var row = parseInt(sRow, 10);
				for (var trow = 0; trow < MySortOrderList.length; trow++) {
					if (trow !== row) {
						sRowx = trow.toString();
						if (sRowx.length < 2) { sRowx = '0' + sRowx; }
						f = parseInt(document.getElementById('rxtMillO' + sRowx).value, 10);
						if (f === newVal) {
							document.getElementById('rxtMillO' + sRowx).value = jiCurrentVal.toString();
							jiCurrentVal = 0;
							found = 1;
							break;
						}
					}
				}
			}
			return false;
		}

		function ChangeRadioBtn(id, objid, val, ischecked) {
			return false;
		}

		function DeleteOneRec(id, row, objid) {
			switch (objid) {
				case 1:
					break;
				case 6:
					ChangeContactForLocation(id, 0, 3);
					break;
				default:
					break;
			}
			return false;
		}

		function DialogAction1(dChoice, Src) {
			switch (Src) {
				case 2: // nothing
					break;
				case 5:
					// nothing
					break;
				case 13: // mill order
					SaveMillOrderChanges();
					break;
				default:
					break;
			}
			return false;
		}

		function HandleImageClick(id, col, objid) {
			return false;
		}

		function EditOneRec(id, row, objid) {
			var rowid = 0;
			var userid = 0;
			var val = '';
			switch (objid) {
				case 1: // comment
					//if (MyCommentData[row]['WkStatusCode'].toString() === 'O') {
						jlCommentIDE.innerHTML = MyCommentList[row]['CommentID'].toString();
						jselCommentActiveE.value = MyCommentList[row]['IsActive'].toString();
						val = MyCommentList[row]['Comment'].toString();
						val = val.replace('<br />', '\n');
						val = ChangeCmtForView(val); //	val = val.replace(/<br \/>/g, '\n');
						jtaCommentText.value = val; //PrepareJSStringForHTMLDisplayTx(MyCommentList[row]['Comment'].toString());
						jsLastValue = val;
						jtCommentTitleE.value = MyCommentList[row]['CommentTitle'].toString();
						jselLocationCodeE.value = MyCommentList[row]['LocCode'].toString();
						jselCommentTypeE.value = MyCommentList[row]['CommentType'].toString();
						jtCommentDateE.value = MyCommentList[row]['sCommentDate'].toString();
						jselOriginatorID.value = MyCommentList[row]['OriginatorID'].toString();
						jdivMainHdrSelects.style.display = 'none';
						jdivProcessListHdr.style.display = 'none';
						jdivCommentItemEdit.style.display = 'block';
						jbEditingComment = true;
					//}
					//else {
					//	alert('This week is not open and comments cannot be changed.');
					//}
					break;
				case 6:
					rowid = parseInt(MyCommentContacts[row]['SortOrderID'], 10);
					userid = parseInt(MyCommentContacts[row]['UserID'], 10);
					if (rowid > 0) { jselLocationContactE.value = userid.toString(); }
					document.getElementById('hfSortOrderIDE').value = rowid.toString();
					jdivContactEditUser.style.display = 'inline';
					break;
				default:
					break;
			}

			return false;
		}

		function SaveMillOrderChanges() {
			//alert('Saving changes');
			var id = 0;
			var sorder = 0;
			var sRow = '';
			var val = '';
			if (!IsContentsNullUndefEmptyTx(MySortOrderList)) {
				//alert('still have main data');
				for (var row = 0; row < MySortOrderList.length; row++) {
					sRow = row.toString();
					if (sRow.length < 2) { sRow = '0' + sRow; }
					//alert(sRow);
					id = parseInt(MySortOrderList[row]['SortOrderID'], 10);
					//alert(id);
					val = document.getElementById('rxtMillO' + sRow).value;
					//alert(val);
					sorder = parseInt(val, 10);
					//alert('new Order val ' + sorder);
					if (sorder !== parseInt(MySortOrderList[row]['RowOrder'], 10)) {
						//alert(sorder + ' saving');
						UpdateMillSortOrder(id, sorder);
					}
				}
				PopulateSortOrderList();
			}
			return false;
		}

		function ShowCommentGroupDialog() {
			//alert('opening dialog now');
			var edate = '';
			var ht = 800;
			var sdate = '';
			var ttl = '';
			var val = '';
			var wdth = 1040;
			var dMonday = getLastMondayDm(jdToday);
			GetDateRangeForMillCmt(getMyDateTimeStringDm(dMonday.addDays(-1), 18));
			sdate = MyDateRangeData[0]['sStartDate'].toString();
			edate = MyDateRangeData[0]['sEndDate'].toString();
			jtBeginDateF.value = sdate;
			jtEndDateF.value = edate;
			var ttl = 'Comments for: ' + sdate + ' to ' + edate;
			//alert('dates set');
			//alert('Monday: ' + val);
			GetCommentGroup();
			//alert('Populating matrix');
			PopulateCommentsGrp();
			//alert('opening dialog');
			ShowSpecialDialogBox1Dx('divCommentsGroup', ttl, true, true, ht, wdth, '', '', window, '', 'Done', '11pt', '1px', 'fadeIn', 'fadeOut', 15)
			//alert('Done!');
			return false;
		}
		
		function ShowCommentSettings() {
			//alert('opening settings now');
			var ht = 400;
			var wdth = 777;
			FillSettings();
			//alert('opening dialog');
			ShowSpecialDialogBox1Dx('divCommentSettings', 'Settings', true, true, ht, wdth, '', '', window, '', 'Done', '11pt', '1px', 'fadeIn', 'fadeOut', 12)
			//alert('Done!');
			return false;
		}

		function ShowContactEditDialog() {
			var ht = 700;
			var sdate = '';
			var ttl = 'Comment Contacts for all Locations';
			var val = '';
			var wdth = 1300;
			ShowSpecialDialogBox1Dx('divContactsEdit', ttl, true, true, ht, wdth, '', '', window, '', 'Done', '11pt', '1px', 'fadeIn', 'fadeOut', 16)
			return false;
		}

		function ShowGlobalCommentDialog() {
			var ht = 560;
			var sdate = '';
			var ttl = 'Global Comment for ' + jsLastEndDate;
			var val = '';
			var wdth = 1040;
			ShowSpecialDialogBox1Dx('divGlobalComment', ttl, true, true, ht, wdth, '', '', window, '', 'Done', '11pt', '1px', 'fadeIn', 'fadeOut', 15)
			return false;
		}

		function ShowMillOrderDialog() {
			var ht = 700;
			var wdth = 320;
			ShowSpecialDialogBox1Dx('divMillSortOrder', 'Set Mill Order in display', true, true, ht, wdth, '', '', window, '', 'Done', '11pt', '1px', 'fadeIn', 'fadeOut', 13)
			//alert('Done!');
			return false;
		}

		function ShowScheduleGrid() {
			var Yr = jselCalYear.value;
			var ht = 432;
			var wdth = 830;
			jlSpecialNotationC.innerHTML = '';
			FillCalendarVals();
			if (jiCommentType === 1) {
				jlSpecialNotationC.innerHTML = '(Period end dates)';
			}
			ShowSpecialDialogBox1Dx('divCalendarSched', 'Yearly Schedule', true, true, ht, wdth, '', '', window, '', 'Done', '11pt', '1px', 'fadeIn', 'fadeOut', 14)
			//alert('Done!');
			return false;
		}

		function SpecialGridAction(id, row, col, objid) {
			switch (objid) {
				case 1: // restart process
					break;
				default:
					break;
			}
			return false;
		}

		function ViewOneRec(id, row, objid) {
			return false;
		}

		// **************************** Background *********************************

		function insertAtCursor(myField, myValue) {
			//IE support
			var fld = document.getElementById(myField);
			var startPos = 0;
			var endPos = 0;
			fld.focus();
			if (document.selection) {
				//fld.focus();
				sel = document.selection.createRange();
				fld.focus();
				sel.text = myValue;
			}
				//MOZILLA and others
			else if (fld.selectionStart || fld.selectionStart == '0') {
				startPos = fld.selectionStart;
				endPos = fld.selectionEnd;
				//fld.focus();
				fld.value = fld.value.substring(0, startPos) + myValue + fld.value.substring(endPos, fld.value.length);
			} else {
				//fld.focus();
				fld.value += myValue;
			}
			fld.selectionStart = startPos + 3;
			fld.selectionEnd = startPos + 3;
			return false;
		}

		function ShowStatusMsg(msg) {
			jlStatusMsg.innerHTML = msg;
			return false;
		}

		// **************************** UI FUNCTIONS *********************************

		function ChangeCommentType(val) {
			jiCommentType = parseInt(jselCommentType.value, 10);
			return false;
		}

		function ChangeDateRange(dir) {
			var val = '';
			switch (dir) {
				case 0: // down one week
					jiWeekNbr--;
					jdTarget.setDate(jdTarget.getDate() - 7);
					if (jiWeekNbr < -1) { jiWeekNbr = -1; }
					jbtnIncrementDateRange.style.display = 'inline';
					if (jiWeekNbr < 0) {
						jbtnDecrementDateRange.style.display = 'none';
					}
					else {
						jbtnDecrementDateRange.style.display = 'inline';
					}
					break;
				case 1: // up one week
					jdTarget.setDate(jdTarget.getDate() + 7);
					jiWeekNbr++;
					if (jiWeekNbr > 1) { jiWeekNbr = 1; }
					jbtnDecrementDateRange.style.display = 'inline';
					if (jiWeekNbr > 0) {
						jbtnIncrementDateRange.style.display = 'none';
					}
					else {
						jbtnIncrementDateRange.style.display = 'inline';
					}
					break;
				default:
					break;
			}
			GetDateRangeForMillCmt(getMyDateTimeStringDm(jdTarget, 18));
			jlMillCmtDateBegin.innerHTML = MyDateRangeData[0]['sStartDate'].toString();
			jlMillCmtDateEnd.innerHTML = MyDateRangeData[0]['sEndDate'].toString();
			jtCommentDateE.value = MyDateRangeData[0]['sEndDate'].toString();
			val = MyDateRangeData[0]['StatusCode'].toString();
			switch (val) {
				case 'O':
					jlWeekStatus.innerHTML = 'Open';
					break;
				case 'C':
					jlWeekStatus.innerHTML = 'Closed';
					break;
				default:
					jlWeekStatus.innerHTML = 'UNKNOWN';
					break;
			}
			jsWeekStatus = MyDateRangeData[0]['StatusCode'].toString();
			//alert('getting');
			GetComment(0, jiCommentType, '', 0, '', 0, 1);
			//alert('checking');
			if (!IsContentsNullUndefEmptyTx(MyCommentData)) {
				jlCommentIDE.innerHTML = MyCommentData[0]['CommentID'].toString();
				jtCommentTitleE.value = MyCommentData[0]['CommentTitle'].toString();
				jselLocationCodeE.value = MyCommentData[0]['LocCode'].toString();
				jselCommentTypeE.value = MyCommentData[0]['CommentType'].toString();
				jlCommentUpdatedE.innerHTML = MyCommentData[0]['sUpdatedDate'].toString();
				jlCommentCreatedE.innerHTML = MyCommentData[0]['sOriginatedDate'].toString();
				val = PrepareJSStringForHTMLDisplayTx(MyCommentData[0]['Comment'].toString());
				jtaCommentText.value = MyCommentData[0]['Comment'].toString();
				if (MyCommentData[0]['sActive'].toString() === 'Yes') {
					jselCommentActiveE.value = '1';
				}
				else {
					jselCommentActiveE.value = '0';
				}
			}
			return false;
		}

		function ChangeInsertGraphicSetting(chkd) {
			if (chkd === true) {
				jspnGraphicsData.style.display = 'inline';
			}
			else {
				jspnGraphicsData.style.display = 'none';
			}
			return false;
		}

		function ChangeLocationContact() {
			var id = parseInt(document.getElementById('hfSortOrderIDE'), 10);
			var userid = parseInt(jselLocationContactE.value, 10);
			ChangeContactForLocation(id, userid, 0);
			jdivContactsEdit.style.display = 'none';
			DataCall1();
			return false;
		}

		function ChangeTargetDateRange(sdt) {
			jtBeginDateF.value = '';
			jtEndDateF.value = '';
			GetDateRangeForMillCmt(sdt);
			jsLastEndDate = sdt;
			jdLastEndDate = convertStringToLocalDateDm(sdt);
			if (!IsContentsNullUndefEmptyTx(MyDateRangeData)) {
				jdLastBeginDate = convertStringToLocalDateDm(MyDateRangeData[0]['sStartDate'].toString());
				jsLastBeginDate = getMyDateTimeStringDm(jdLastBeginDate, 8);
				val = MyDateRangeData[0]['StatusCode'].toString();
				switch (val) {
					case 'O':
						jlWeekStatus.innerHTML = 'Open';
						break;
					case 'C':
						jlWeekStatus.innerHTML = 'Closed';
						break;
					default:
						jlWeekStatus.innerHTML = 'UNKNOWN';
						break;
				}
				jsWeekStatus = MyDateRangeData[0]['StatusCode'].toString();
			}
			else {
				jdLastBeginDate = convertStringToLocalDateDm(dMonday.addDays(-7).toString());
				jsLastBeginDate = getMyDateTimeStringDm(jdLastBeginDate, 8);
				jsWeekStatus = 'O';
				jlWeekStatus.innerHTML = 'Open';
			}
			return false;
		}

		function ChangePageSize(val) {
			jiPageSize = parseInt(val, 10);
			refreshDataGrid();
			return false;
		}

		function CloseCommentDataEdit() {
			//alert('fired');
			jdivCommentItemEdit.style.display = 'none';
			jdivProcessListHdr.style.display = 'block';
			jdivMainHdrSelects.style.display = 'block';
			//alert('Done!');
			return false;
		}

		function CloseLocationContactEdit() {
			jdivContactEditUser.style.display = 'none';
			return false;
		}

		function CommentAddNew(typ) {
			var dte = '';
			var ttl = '';
			var val = '';
			if (typ === 1) {
				jselLocationCodeE.value = 'HQ';
				jselLocationCodeF.value = '0';
			}
			var Loc = jselLocationCodeF.value;
			//alert(Loc);
			if (Loc !== '0' && typ === 0) {
				jselLocationCodeE.value = jselLocationCodeF.value;
			}
			else {
				if (jbA === true) {
					jselLocationCodeE.value = 'HQ';
					jselLocationCodeF.value = '0';
				}
			}
			val = '';
			var CmtLoc = jselLocationCodeE.value;
			//alert(CmtLoc);
			jiWeekNbr = 0;
			ttl = '';
			jdTarget.setDate(jdLastEndDate.getDate());
			jtCommentDateE.value = getMyDateTimeStringDm(jdLastEndDate, 18);
			if (jiCommentType === 1) { ttl = 'Weekly Mill Comments - ' + getMyDateTimeStringDm(jdLastEndDate, 18); }
			if (typ === 0) {
				GetComment(0, jselCommentType.value, '', 0, CmtLoc, 0, 1);
				if (!IsContentsNullUndefEmptyTx(MyCommentData)) {
					ttl = MyCommentData[0]['CommentTitle'].toString();
					val = PrepareHTMLForViewTx(MyCommentData[0]['Comment'].toString(), 2);
					jlCommentIDE.innerHTML = MyCommentData[0]['CommentID'].toString();
				}
				else {
					GetCommentTemplate();
					if (!IsContentsNullUndefEmptyTx(MyCommentTemplate)) { val = MyCommentTemplate[0]['SettingValue'].toString(); }
					jlCommentIDE.innerHTML = '0';
					jselCommentActiveE.value = '1';
				}
			}
			else {
				//alert('looking for it! -' + jsLastEndDate);
				GetCommentHQ(0, '1', jsLastEndDate);
				if (!IsContentsNullUndefEmptyTx(MyCommentDataHQ)) {
					//alert('Found it!');
					ttl = MyCommentDataHQ[0]['CommentTitle'].toString();
					val = PrepareHTMLForViewTx(MyCommentDataHQ[0]['Comment'].toString(), 2);
					jlCommentIDE.innerHTML = MyCommentDataHQ[0]['CommentID'].toString();
					jselCommentActiveE.value = '1';
				}
				else {
					GetCommentTemplate();
					if (!IsContentsNullUndefEmptyTx(MyCommentTemplate)) { val = MyCommentTemplate[0]['SettingValue'].toString(); }
					jlCommentIDE.innerHTML = '0';
					jselCommentActiveE.value = '1';
				}
			}
			jchkInsertGraphicOn.checked = false;
			jtGraphicHeight.value = '0';
			jtGraphicWidth.value = '0';
			jspnGraphicsData.style.display = 'none';
			jspnMillCmtDateRange.style.display = 'none';
			//alert(val);
			val = ChangeCmtForView(val); //	val = val.replace(/<br \/>/g, '\n');
			jtaCommentText.value = val;
			jsLastValue = val;
			val = '';
			jtCommentTitleE.value = ttl;
			jselOriginatorID.value = jiByID.toString();
			jselCommentTypeE.value = '1';
			jlCommentUpdatedE.innerHTML = 'N/A';
			jlCommentCreatedE.innerHTML = 'N/A';
			// if mill weekly comments, show date range
			if (jiCommentType === 1) {
				jspnMillCmtDateRange.style.display = 'inline';
				//alert('getting date range');
				GetDateRangeForMillCmt(getMyDateTimeStringDm(jdLastEndDate, 18));
				//alert('setting date range');
				jlMillCmtDateBegin.innerHTML = MyDateRangeData[0]['sStartDate'].toString();
				jlMillCmtDateEnd.innerHTML = MyDateRangeData[0]['sEndDate'].toString();
			}
			//alert('1');
			jbEditingComment = true;
			jbtnDecrementDateRange.style.display = 'inline';
			jbtnIncrementDateRange.style.display = 'inline';
			jdivProcessListHdr.style.display = 'none';
			jdivMainHdrSelects.style.display = 'none';
			jdivCommentItemEdit.style.display = 'block';
			return false;
		}

		//function CopyDivToClipboard(id) {
		//	alert('Fired fucntion');
		//	CopyToClipboardGu(id);
		//	return false;
		//}

		function ChangeCmtForView(cmt) {
			cmt = cmt.replace(/<br \/>/g, '\n');

			return cmt;
		}

		function ChangeCmtForSave(txt) {
			txt = txt.replace(/\'/g, '`');
			//alert(txt);
			//while (txt.indexOf('&beta;') > -1) {
			//	txt = txt.replace('&beta;', '<b>');
			//	txt = txt.replace('&beta;', '</b>');
			//	alert(txt);
			//}
			return txt;
		}

		function ChangeCmtForSaveHQ(cmt) {
			cmt = cmt.replace(/(?:\r\n|\r|\n)/g, '<br />');
			//while (cmt.indexOf('&beta;') > -1) {
			//	cmt = cmt.replace('&beta;', '<b>');
			//	cmt = cmt.replace('&beta;', '</b>');
			//}
			return cmt;
		}

		function CopyPreviousComment() {
			GetCommentPrev(jiCommentType, jiByID, jselLocationCodeE.value);
			if (!IsContentsNullUndefEmptyTx(MyCommentDataPrev)) {
			  jtaCommentText.value = MyCommentDataPrev[0]['Comment'].toString();
				jtCommentTitleE.value = MyCommentDataPrev[0]['CommentTitle'].toString();
			}
			else {
				alert('No previous comment could be identified.');
			}
			return false;
		}

		function EditContactList() {
			//alert('getting contacts');
			GetCommentContacts(0, '');
			//alert('populating');
			PopulateCommentContacts();
			//alert('showing');
			ShowContactEditDialog();
			return false;
		}

		function FillCalendarVals() {
			//alert('Filling calendar');
			var bColor = 'white';
			var bdy = document.createElement('tbody');
			var cell;
			var content = '';
			var diw = 0;
			var fColor = 'black';
			var isOn = 0;
			var isHol = 0;
			var isLeapYr = false;
			var lastday = 0;
			var lastmo = 0;
			var mo = 0;
			var sDay = '';
			var sHol = '';
			var sMo = '';
			var wkend = 0;
			//alert('getting events');
			GetCalendarEvents();
			if (MyCalendarEvents !== undefined && MyCalendarEvents !== null) {
				var nrows = MyCalendarEvents.length;
				//alert('handling rows -' + nrows.toString());
				if (nrows > 0) {
					var tr = document.createElement('tr');
					//alert('getting global vals');
					//alert(MyCalendarEvents[0]['sLeapYear'].toString());
					if (MyCalendarEvents[0]['sLeapYear'].toString() === 'Yes') { isLeapYr = true; }
					//alert('2');
					sMo = MyCalendarEvents[0]['CalendarMonth'].toString();
					if (sMo.length < 2) { sMo = '0' + sMo;}
					//alert('cycling days');
					// cycle through all days in year
					for (var dts = 0; dts < nrows; dts++) {
						//alert(dts);
						sDay = MyCalendarEvents[dts]['DayInMonth'].toString();
						if (sDay.length < 2) {sDay = '0' + sDay;}
						mo = parseInt(MyCalendarEvents[dts]['CalendarMonth'], 10);
						diw = parseInt(MyCalendarEvents[dts]['DayInWeek'], 10);
						sHol = MyCalendarEvents[dts]['HolidayName'].toString();
						wkend = 0;
						isHol = 0;
						isOn = 0;
						bColor = 'white';
						fColor = 'black';
						if (MyCalendarEvents[dts]['sWeekend'].toString() === 'Yes') { wkend = 1; }
						if (MyCalendarEvents[dts]['sCoHoliday'].toString() === 'Yes') { isHol = 1; }
						if (MyCalendarEvents[dts]['sChosen'].toString() === 'Yes') { isOn = 1; }
						//alert('checking last val - ' + dts.toString())
						if (lastmo !== mo) {
							if (dts > 0) {
								if (lastday < 31) {
									for (var dy=lastday+1;dy<=31;dy++) {
										sDay = dy.toString();
										if (sDay.length < 2) {sDay = '0' + sDay;}
										cell = createNewCellDg('tdCal' + sMo + sDay, '16px', '0', '', 'white', 'white', 'none', 'none', 'none', 'none', 'center', 'top', '1px', '1px', '1px', '1px', '11pt', true, false, 'hidden', true, false, true, 1, '', '', 1);
										tr.appendChild(cell);
									}
								}
								bdy.appendChild(tr);
								tr = document.createElement('tr');
							}
							sMo = MyCalendarEvents[dts]['CalendarMonth'].toString();
							if (sMo.length < 2) { sMo = '0' + sMo; }
							cell = createNewCellDg('tdCal' + sMo + '00', '16px', '80px', MyCalendarEvents[dts]['MonthStrName'].toString(), 'darkblue', 'white', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', 'center', 'top', '1px', '1px', '1px', '1px', '11pt', true, false, 'hidden', true, false, true, 1, '', '', 1);
							tr.appendChild(cell);
							lastmo = mo;
						}
						//alert('setting content');
						content = '<input type="checkbox" id="chkCal' + sMo + sDay + '" onchange="javascript:UpdateOneDate(' + MyCalendarEvents[dts]['CalendarMonth'].toString() + ',' + MyCalendarEvents[dts]['DayInMonth'].toString() + ', this.checked);return false;"';
						if (isOn === 1) {content = content + ' checked="checked"';}
						content = content + '/>';
						if (wkend === 1) {
							bColor = '#B9FFE0';
						}
						if (isHol === 1) { bColor='FFEEDD';}
						//alert('creating cell');
						cell = createNewCellDg('tdCal' + sMo + sDay, '16px', '0', content, bColor, fColor, '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', 'center', 'top', '1px', '1px', '1px', '1px', '11pt', true, false, 'hidden', true, false, true, 1, '', '', 1);
						//alert('attaching cell');
						tr.appendChild(cell);
						lastday = parseInt(MyCalendarEvents[dts]['DayInMonth'], 10);
					}

					// attach last month
					bdy.appendChild(tr);
				}
			}

			//alert('inserting body');
			var oldBody = jtblCommentsCal.getElementsByTagName("tbody")[0];
			jtblCommentsCal.replaceChild(bdy, oldBody);
			return false;
		}

		function FillSettings() {
			//alert('getting settings');
			GetSettingsList(0);
			//alert('inserting settings data');
			PopulateSettingsList();
			return false;
		}
		
		function OpenCommentSettings() {
			ShowCommentSettings();
			return false;
		}

		function RefreshCurrentDataGrid() {
			DataCall1();
			return false;
		}

		function SetMillOrder() {
			ShowMillOrderDialog();
			return false;
		}

		function ShowCommentGroup() {
			//alert('CmtGrp Show fired');
			jiCommentType = parseInt(jselCommentType.value, 10);
			switch (jiCommentType) {
				case 1:
					//alert('showing dialog function');
					ShowCommentGroupDialog();
					break;
				default:
					break;
			}

			return false;
		}

		function ShowGlobalComment() {
			GetCommentHQ(0, 1, jsLastEndDate); //MyCommentDataHQ
			if (!IsContentsNullUndefEmptyTx(MyCommentDataHQ)) {
				document.getElementById('tdGlobalComment').innerHTML = MyCommentDataHQ[0]['Comment'].toString();
				document.getElementById('tdGlobalCommentTitle').innerHTML = MyCommentDataHQ[0]['CommentTitle'].toString();
				jselOriginatorID.value = MyCommentDataHQ[0]['OriginatorID'].toString();
				if (MyCommentDataHQ[0]['sInsertGraphic'].toString() === 'Yes') {
					jchkInsertGraphicOn.checked = true;
					jspnGraphicsData.style.display = 'inline';
					jtGraphicHeight.value = MyCommentDataHQ[0]['GraphicHeightInPixels'].toString();
					jtGraphicWidth.value = MyCommentDataHQ[0]['GraphicWidthInPixels'].toString();
				}
				else {
					jchkInsertGraphicOn.checked = false;
					jspnGraphicsData.style.display = 'none';
					jtGraphicHeight.value = '0';
					jtGraphicWidth.value = '0';
				}
				ShowGlobalCommentDialog();
			}
			else {
				alert('No Global Comment was found.');
			}
			return false;
		}

		function UpdateCommentData() {
			if (jselLocationCodeE.value === '0' && jbA === false) {
				alert('You must select a location in order to save your comment.');
			}
			var iCmtMax = jiCommentLenMax;
			var iCmtWarn = jiCommentLenWarn;
			var sdt = jtCommentDateE.value;
			var id = parseInt(jlCommentIDE.innerHTML, 10);
			var act = parseInt(jselCommentActiveE.value, 10);
			var cmt = jtaCommentText.value; //.replace(/\'/g, '`');
			//alert(cmt);
			cmt = ChangeCmtForSave(cmt);
			//alert(cmt);
			var ttl = jtCommentTitleE.value.replace(/\'/g, '`');
			var loc = jselLocationCodeE.value;
			var origid = jselOriginatorID.value;
			//alert(loc);
			if (loc === 'HQ') {
				iCmtMax = jiCmtLenGlobalMax;
				iCmtWarn = jiCmtLenGlobalWarn;
			}
			var typ = jselCommentTypeE.value;
			var clen = cmt.length;
			if (clen > iCmtMax) {
				alert('You cannot save your comment because it is longer than the maximum length allowed.');
			}
			else {
				if (clen > iCmtWarn) {
					alert('Your comment is longer than recommended but it is shorter than the maximum length allowed. Please consider shortening the text.');
				}
				var igrph = 0;
				var gwdth = parseInt(jtGraphicWidth.value, 10);
				var ght = parseInt(jtGraphicHeight.value, 10);
				if (jchkInsertGraphicOn.checked === true) { igrph = 1; }

				//alert(loc);
				UpdateComment(id, act, cmt, ttl, loc, typ, sdt, origid, igrph, gwdth, ght);
				if (!CheckMyReturnAs()) {
					jdivCommentItemEdit.style.display = 'none';
					jdivProcessListHdr.style.display = 'block';
				}
				else {
					if (jiActionStatusID > 0) {
						alert(jiActionStatusMsg);
					}
				}
				DataCall1();
				jbEditingComment = false;
				jdivCommentItemEdit.style.display = 'none';
				jdivProcessListHdr.style.display = 'block';
				jdivMainHdrSelects.style.display = 'block';
			}
			return false;
		}

		function UndoLastCommentEdit() {
			//if (jsLastValue !== '') {
				jtaCommentText.value = jsLastValue;
			//}
			return false;
		}

		function UpdateOneDate(mo, dy, chkd) {
			if (jbA === true) {
				var yr = jselCalYear.value;
				//alert('updating');
				UpdateScheduleDate(yr, mo, dy, chkd);
			}
			else {
				alert('You do not have the rights to change the schedule. Your changes will be ignored.');
			}
			return false;
		}

		// **************************** External Links *********************************

	</script>
			

  <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />

</head>
<body>
	<img id="imgSessionKeepAlive" width="1" height="1" style="display:none;" src="../Images/clearpixel.gif" />
  <form id="form1" runat="server">
  <asp:ScriptManager runat="server"></asp:ScriptManager>
	<asp:HiddenField ID="hfPageID" runat="server" Value="44" />

	<div id="divMainPopup" style="display:none;"></div>

	<div id="divGlobalComment" style="display:none;">
		<table id="tblGlobalComment" style="padding:1px;border-spacing:0px;border-collapse:collapse;border:1px solid gray;width:1000px;">
		<tr>
			<td id="tdGlobalCommentTitle" class="StdTableCell" style="width:100%;height:20px;vertical-align:top;">
				&nbsp;				
			</td>
		</tr>
		<tr>
			<td id="tdGlobalComment"  class="StdTableCell" style="width:100%;height:400px;vertical-align:top;">
				&nbsp;				
			</td>
		</tr>
		</table>
	</div>

	<div id="divContactsEdit" style="display:none;">
		<div id="divContactEditUser" style="width:100%;background-color:aqua;padding:2px;text-align:center;display:none;">
			Contact for Location:&nbsp;<select id="selLocationContactE">
				<option value="0" selected="selected">None Selected</option>
			</select>
			<button id="btnUpdateLocationContact" class="button blue-gradient glossy" onclick="javascript:ChangeLocationContact();return false;">Save</button>
			<button id="btnCloseLocationContact" class="button blue-gradient glossy" onclick="javascript:CloseLocationContactEdit();return false;">Close</button>
		</div>

		<table id="tblContactsEdit" style="padding:2px;border-spacing:0px;">
		<thead>
		<tr>
			<th class="ColHeaderStd" style="width:60px;">ID</th>
			<th class="ColHeaderStd" style="width:230px;">Location</th>
			<th class="ColHeaderStd" style="width:90px;">City</th>
			<th class="ColHeaderStd" style="width:40px;">St</th>
			<th class="ColHeaderStd" style="width:200px;">Person</th>
			<th class="ColHeaderStd" style="width:240px;">Position</th>
			<th class="ColHeaderStd" style="width:170px;">Email</th>
			<th class="ColHeaderStd" style="width:80px;">Action</th>
		</tr>
		</thead>
		<tbody>

		</tbody>
		</table>
		<input type="hidden" id="hfSortOrderIDE" />
	</div>

	<textarea id="txaCopyText" style="display:none;"></textarea>

	<div id="divCommentsGroup" style="display:none;">
		<div id="divCommentsGroupMatrix" style="border:none;border-spacing:0px;margin:1px;">
			<table id="tblCommentsGroup" style="padding:1px;border-spacing:0px;border-collapse:collapse;border:1px solid gray;width:1000px;">
			<tr>
				<td id="tdMillCommentHdr01" class="MillCommentsHdr" style="width:33%;"><label id="lblMillComment01"></label></td>
				<td id="tdMillCommentHdr02" class="MillCommentsHdr" style="width:34%;"><label id="lblMillComment02"></label></td>
				<td id="tdMillCommentHdr03" class="MillCommentsHdr" style="width:33%;"><label id="lblMillComment03"></label></td>
			</tr>
			<tr>
				<td id="tdMillComment01" class="MillCommentText"></td>
				<td id="tdMillComment02" class="MillCommentText"></td>
				<td id="tdMillComment03" class="MillCommentText"></td>
			</tr>
			<tr>
				<td id="tdMillCommentHdr04" class="MillCommentsHdr"><label id="lblMillComment04"></label></td>
				<td id="tdMillCommentHdr05" class="MillCommentsHdr"><label id="lblMillComment05"></label></td>
				<td id="tdMillCommentHdr06" class="MillCommentsHdr"><label id="lblMillComment06"></label></td>
			</tr>
			<tr>
				<td id="tdMillComment04" class="MillCommentText"></td>
				<td id="tdMillComment05" class="MillCommentText"></td>
				<td id="tdMillComment06" class="MillCommentText"></td>
			</tr>
			<tr>
				<td id="tdMillCommentHdr07" class="MillCommentsHdr"><label id="lblMillComment07"></label></td>
				<td id="tdMillCommentHdr08" class="MillCommentsHdr"><label id="lblMillComment08"></label></td>
				<td id="tdMillCommentHdr09" class="MillCommentsHdr"><label id="lblMillComment09"></label></td>
			</tr>
			<tr>
				<td id="tdMillComment07" class="MillCommentText"></td>
				<td id="tdMillComment08" class="MillCommentText"></td>
				<td id="tdMillComment09" class="MillCommentText"></td>
			</tr>
			<tr>
				<td id="tdMillCommentHdr10" class="MillCommentsHdr"><label id="lblMillComment10"></label></td>
				<td id="tdMillCommentHdr11" class="MillCommentsHdr"><label id="lblMillComment11"></label></td>
				<td id="tdMillCommentHdr12" class="MillCommentsHdr"><label id="lblMillComment12"></label></td>
			</tr>
			<tr>
				<td id="tdMillComment10" class="MillCommentText"></td>
				<td id="tdMillComment11" class="MillCommentText"></td>
				<td id="tdMillComment12" class="MillCommentText"></td>
			</tr>
			<tr>
				<td id="tdMillCommentHdr13" class="MillCommentsHdr"><label id="lblMillComment13"></label></td>
				<td id="tdMillCommentHdr14" class="MillCommentsHdr"><label id="lblMillComment14"></label></td>
				<td id="tdMillCommentHdr15" class="MillCommentsHdr"><label id="lblMillComment15"></label></td>
			</tr>
			<tr>
				<td id="tdMillComment13" class="MillCommentText"></td>
				<td id="tdMillComment14" class="MillCommentText"></td>
				<td id="tdMillComment15" class="MillCommentText"></td>
			</tr>
			<tr>
				<td id="tdMillCommentHdr16" class="MillCommentsHdr"><label id="lblMillComment16"></label></td>
				<td id="tdMillCommentHdr17" class="MillCommentsHdr"><label id="lblMillComment17"></label></td>
				<td id="tdMillCommentHdr18" class="MillCommentsHdr"><label id="lblMillComment18"></label></td>
			</tr>
			<tr>
				<td id="tdMillComment16" class="MillCommentText"></td>
				<td id="tdMillComment17" class="MillCommentText"></td>
				<td id="tdMillComment18" class="MillCommentText"></td>
			</tr>
			<tr>
				<td id="tdMillCommentHdr19" class="MillCommentsHdr"><label id="lblMillComment19"></label></td>
				<td id="tdMillCommentHdr20" class="MillCommentsHdr"><label id="lblMillComment20"></label></td>
				<td id="tdMillCommentHdr21" class="MillCommentsHdr"><label id="lblMillComment21"></label></td>
			</tr>
			<tr>
				<td id="tdMillComment19" class="MillCommentText"></td>
				<td id="tdMillComment20" class="MillCommentText"></td>
				<td id="tdMillComment21" class="MillCommentText"></td>
			</tr>
			<tr>
				<td id="tdMillCommentHdr22" class="MillCommentsHdr"><label id="lblMillComment22"></label></td>
				<td id="tdMillCommentHdr23" class="MillCommentsHdr"><label id="lblMillComment23"></label></td>
				<td id="tdMillCommentHdr24" class="MillCommentsHdr"><label id="lblMillComment24"></label></td>
			</tr>
			<tr>
				<td id="tdMillComment22" class="MillCommentText"></td>
				<td id="tdMillComment23" class="MillCommentText"></td>
				<td id="tdMillComment24" class="MillCommentText"></td>
			</tr>
			</table>
		</div>
		<div id="divCommentsGroupBtns" style="border:none;border-spacing:0px;margin:1px;width:100%;text-align:center;">
			<button id="btnCopyToClipboard" class="button blue-gradient glossy" >Copy to Clipboard</button>
		</div>
	</div>

	<div id="divMillSortOrder" style="display:none;text-align:center;">
		<table id="tblMillSortOrder" style="pading:1px;border-spacing:0px;border:none;margin: auto auto;">
		<thead>
		<tr>
			<th class="TableHdrCell" style="width:70px;">Mill</th>
			<th class="TableHdrCell" style="width:48px;">Order</th>
			<th style="background-color:black;">&nbsp;</th>
			<th class="TableHdrCell" style="width:70px;">Mill</th>
			<th class="TableHdrCell" style="width:48px;">Order</th>
		</tr>
		</thead>
		<tbody>

		</tbody>
		</table>
	</div>

	<div id="divCommentSettings" style="display:none;">
		<table id="tblCommentSettings" style="padding:1px;border-spacing:0px;border-collapse:collapse;border:1px solid gray;">
		<thead>
		<tr>
			<th class="TableHdrCell" style="width:56px;">ID</th>
			<th class="TableHdrCell" style="width:260px;">Setting</th>
			<th class="TableHdrCell" style="width:260px;">Value</th>
			<th class="TableHdrCell" style="width:80px;">Type</th>
			<th class="TableHdrCell" style="width:56px;">Active</th>
		</tr>
		</thead>
		<tbody>

		</tbody>
		</table>
<!-- #include file="../inc/incPaginationDiv2.inc" -->
	</div>

	<div id="divCalendarSched" style="display:none;">
		<table id="tblCommentsCalendar" style="padding:1px;border-spacing:0px;border-collapse:collapse;border:1px solid gray;">
		<thead>
		<tr>
			<th colspan="32" >
				<div id="divCalYearInTable" style="width:100%;margin-bottom:6px;text-align:center;vertical-align:top;">
					&nbsp;Year:&nbsp;<select id="selCalYear" >
						<option value="0" selected="selected">Not Selected</option>
						<option value="2016">2016</option>
						<option value="2017">2017</option>
						<option value="2018">2018</option>
						<option value="2019">2019</option>
						<option value="2020">2020</option>
						<option value="2021">2021</option>
						<option value="2022">2022</option>
					</select>&nbsp;<label id="lblSpecialNotationC" ></label>
				</div>
			</th>
		</tr>
		<tr style="text-align:center;background-color:#6892B0;border:1px solid gray;">
			<th>Month</th><th>1</th><th>2</th><th>3</th><th>4</th><th>5</th><th>6</th><th>7</th><th>8</th><th>9</th><th>10</th>
			<th>11</th><th>12</th><th>13</th><th>14</th><th>15</th><th>16</th><th>17</th><th>18</th><th>19</th><th>20</th>
			<th>21</th><th>22</th><th>23</th><th>24</th><th>25</th><th>26</th><th>27</th><th>28</th><th>29</th><th>30</th><th>31</th>
		</tr>
		</thead>
		<tbody>
		</tbody>
		</table>
	</div>

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
				<div id="divPageHdrTitle" style="width:100%;font-size:12pt;">
					<label id="lblOricMngtHdrTitle" class="LabelGridHdrStd" style="margin-left:6px;">Comment Management:</label>&nbsp;
					<span id="spnShowCurrentWeekDateDue" style="position:absolute;width:34%;left:340px;text-align:center;font-size:9pt;">Current&nbsp;Week&nbsp;Due:&nbsp;<label id="lblCurrentWeekDue" style="font-weight:bold;color:darkblue;"></label></span>
					<label id="lblPageStatus" style="position:absolute;font-size:10pt;font-weight:bold;color:darkgray;right:70px;">Page Loading...</label>
				</div>
				<div id="divMainHdrSelects" style="width:100%;text-align:center;">
					<span id="spnMainHdrCommentType" style="display:none;">
						<label id="lblMainHdrSelectItem" style="color:blue;font-weight:bold;font-size:12pt;">Comment Type:</label>&nbsp;
						<select id="selCommentType" style="font-size:12pt;" onchange="javascript:ChangeCommentType(this.value);return false;">
							<option value="0">None Selected</option>
							<option value="1" selected="selected">Mill Weekly</option>
						</select>&nbsp;&nbsp;&bull;
					</span>
					Target&nbsp;Time&nbsp;Period:&nbsp;
					<select id="selTimePeriod" onchange="javascript:ChangeTargetDateRange(this.value);return false;">
						<option value="0" selected="selected">None Selected</option>
					</select>&nbsp;&nbsp;Status:&nbsp;<label id="lblWeekStatus" style="color:blue;font-weight:bold;">O</label>&nbsp;&nbsp;&bull;
					<span id="spnSpacerFOrItemsPerPage" style="margin-left:6px;">
						<label style="margin-left: 2px;margin-right:4px;">Items per Page:</label><select id="selPageSize" style="margin-left: 10px;" onchange="javascript:ChangePageSize(this.value);return false;">
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
						</select>&nbsp;&nbsp;
						<button id="btnAddNewComment" class="button blue-gradient glossy" onclick="javascript:CommentAddNew(0);return false;" style="margin-left:12px;">New Comment</button>
						<button id="btnAddNewGComment" class="button blue-gradient glossy" onclick="javascript:CommentAddNew(1);return false;" style="margin-left:12px;display:none;">Global Comment</button>
						<button id="btnShowWeeklyGrp" class="button blue-gradient glossy" onclick="javascript:ShowCommentGroup();return false;" style="margin-left:12px;display:none;">Weekly Comments</button>
						<button id="btnShowGlobalCmt" class="button blue-gradient glossy" onclick="javascript:ShowGlobalComment();return false;" style="margin-left:12px;display:none;">Global Comment</button>
						<button id="btnShowYearlySchedule" class="button blue-gradient glossy" onclick="javascript:ShowScheduleGrid();return false;" style="margin-left:12px;">Schedule</button>
						<button id="btnCommentSettings" class="button blue-gradient glossy" onclick="javascript:OpenCommentSettings();return false;" style="margin-left:4px;display:none;">Settings</button>
						<button id="btnCommentContacts" class="button blue-gradient glossy" onclick="javascript:EditContactList();return false;" style="margin-left:4px;display:none;">Contacts</button>
						<button id="btnCreateWkRpt" class="button blue-gradient glossy" onclick="javascript:CreateWeeklyReportEntry();return false;" style="margin-left:4px;display:none;">Create W/R</button>
					</span>
				</div>
			</div>

			<div id="divPAGEMAINSECTION" style="width:100%;margin-left:10px;">

				<div id="divCommentItemEdit" style="width:100%;display:none;background-color:antiquewhite;margin-top:6px;margin-bottom:10px;">
					<div id="divCommentEditHdr" style="width:100%;margin:4px;">
						&nbsp;<label id="lblCommentEditHdr" style="font-weight:bold;color:blue;font-size:13pt;">Edit Comment:</label>&nbsp;&nbsp;
					</div>
					<div id="divCommentEditTable" style="width:100%;text-align:center;margin-bottom:6px;">
						<table id="tblCommentEdit" style="padding:1px;border-spacing:0px;margin: auto auto;">
						<tr>
							<td style="text-align:right;vertical-align:top;">
								ID:&nbsp;
							</td>
							<td style="text-align:left;vertical-align:top;">
								<label id="lblCommentIDE" style="font-weight:bold;color:blue;">0</label>
							</td>
							<td style="text-align:right;vertical-align:top;">
								Type:&nbsp;
							</td>
							<td style="text-align:left;vertical-align:top;">
								<select id="selCommentTypeE" style="font-size:11pt;" onchange="javascript:ChangeViewType(this.value);return false;">
									<option value="0">None Selected</option>
									<option value="1" selected="selected">Mill Weekly</option>
								</select>
							</td>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td style="text-align:right;vertical-align:top;">
								Location:&nbsp;
							</td>
							<td style="text-align:left;vertical-align:top;">
								<select id="selLocationCodeE"	>
									<option value="0" selected="selected">None Selected</option>
								</select>
							</td>
							<td style="text-align:right;vertical-align:top;">
								Title:&nbsp;
							</td>
							<td style="text-align:left;vertical-align:top;">
								<input type="text" id="txtCommentTitleE" style="width:240px;" value="" />&nbsp;(Not Required)
							</td>
							<td style="vertical-align:top;text-align:left;" rowspan="5">
								<table id="tblCommentEditHelp" style="border:none;border-spacing:0px;padding:0px;text-align:left;margin-left:8px;">
								<tr>
									<td colspan="8" style="font-weight:bold;color:maroon;">
										Editing&nbsp;Comments&nbsp;Available:&nbsp;
									</td>
								</tr>
								<tr>
									<td style="font-weight:bold;color:darkblue;" colspan="5"><u>CTL&nbsp;-&nbsp;Char</u>&nbsp;</td>
									<td style="border-left:1px solid gray;">&nbsp;</td>
									<td style="font-weight:bold;color:darkblue;" colspan="2"><u>ALT&nbsp;-&nbsp;Char</u></td>
								</tr>
								<tr>
									<td style="font-weight:bold;">0&nbsp;</td>
									<td>&mdash;</td>
									<td>&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">b</td>
									<td>&bull;</td>
									<td style="border-left:1px solid gray;">&nbsp;&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">0&nbsp;</td>
									<td>this week</td>
								</tr>
								<tr>
									<td style="font-weight:bold;">1</td>
									<td>&ring;</td>
									<td>&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">c</td>
									<td>&check;</td>
									<td style="border-left:1px solid gray;">&nbsp;&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">1&nbsp;</td>
									<td>this month</td>
								</tr>
								<tr>
									<td style="font-weight:bold;">2</td>
									<td>&frac12;</td>
									<td>&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">d</td>
									<td>&diams;</td>
									<td style="border-left:1px solid gray;">&nbsp;&nbsp;&nbsp;</td>
									<td>2&nbsp;</td>
									<td>this year</td>
								</tr>
								<tr>
									<td style="font-weight:bold;">3</td>
									<td>&frac34;</td>
									<td>&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">e</td>
									<td>&loz;</td>
									<td style="border-left:1px solid gray;">&nbsp;&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">3&nbsp;</td>
									<td>rest of this month</td>
								</tr>
								<tr>
									<td style="font-weight:bold;">4</td>
									<td>&frac14;</td>
									<td>&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">f</td>
									<td>&infin;&nbsp;</td>
									<td style="border-left:1px solid gray;">&nbsp;&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">4&nbsp;</td>
									<td>rest of this year</td>
								</tr>
								<tr>
									<td style="font-weight:bold;">5</td>
									<td>&raquo;</td>
									<td>&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">g</td>
									<td>&deg;</td>
									<td style="border-left:1px solid gray;">&nbsp;&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">5&nbsp;</td>
									<td>production was up</td>
								</tr>
								<tr>
									<td style="font-weight:bold;">6</td>
									<td>&larr;</td>
									<td>&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">h</td>
									<td>&#9786;</td>
									<td style="border-left:1px solid gray;">&nbsp;&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">6&nbsp;</td>
									<td>production was down</td>
								</tr>
								<tr>
									<td style="font-weight:bold;">7</td>
									<td>&uarr;</td>
									<td>&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">i</td>
									<td>&sim;</td>
									<td style="border-left:1px solid gray;">&nbsp;&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">7&nbsp;</td>
									<td>inventory went down</td>
								</tr>
								<tr>
									<td style="font-weight:bold;">8</td>
									<td>&rarr;</td>
									<td>&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">j</td>
									<td>&hearts;</td>
									<td style="border-left:1px solid gray;">&nbsp;&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">8&nbsp;</td>
									<td>inventory went up</td>
								</tr>
								<tr>
									<td style="font-weight:bold;">9</td>
									<td>&darr;</td>
									<td>&nbsp;&nbsp;</td>
									<td>k</td>
									<td>&#9785;</td>
									<td style="border-left:1px solid gray;">&nbsp;&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">9&nbsp;</td>
									<td>overtime was necessary</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">p</td>
									<td>&pound;</td>
									<td style="border-left:1px solid gray;">&nbsp;&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">b&nbsp;</td>
									<td>{Bold Selection}</td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;&nbsp;</td>
									<td>q</td>
									<td>&squ;</td>
									<td style="border-left:1px solid gray;">&nbsp;&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">c&nbsp;</td>
									<td>&#9925;</td>
								</tr>
								<tr>
									<td style="font-weight:bold;">&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">q</td>
									<td>&squ;</td>
									<td style="border-left:1px solid gray;">&nbsp;&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">g&nbsp;</td>
									<td>&otimes;&nbsp;{Graphic Placeholder}</td>
								</tr>
								<tr>
									<td style="font-weight:bold;">&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">r</td>
									<td>&star;</td>
									<td style="border-left:1px solid gray;">&nbsp;&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">i&nbsp;</td>
									<td>{Italics Selection}</td>
								</tr>
								<tr>
									<td style="font-weight:bold;">&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">t</td>
									<td>&trade;</td>
									<td style="border-left:1px solid gray;">&nbsp;&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">l&nbsp;</td>
									<td>{End of Line}</td>
								</tr>
								<tr>
									<td style="font-weight:bold;">&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">u</td>
									<td>&ne;</td>
									<td style="border-left:1px solid gray;">&nbsp;&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">r&nbsp;</td>
									<td>&#9928;</td>
								</tr>
								<tr>
									<td style="font-weight:bold;">&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">v</td>
									<td>&rtri;</td>
									<td style="border-left:1px solid gray;">&nbsp;&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">s&nbsp;</td>
									<td>&#9733;</td>
								</tr>
								<tr>
									<td style="font-weight:bold;">&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">w&nbsp;</td>
									<td>&ang;</td>
									<td style="border-left:1px solid gray;">&nbsp;&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">t&nbsp;</td>
									<td>&#9951;</td>
								</tr>
								<tr>
									<td style="font-weight:bold;">&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">y</td>
									<td>&yen;</td>
									<td style="border-left:1px solid gray;">&nbsp;&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">u&nbsp;</td>
									<td>{Underline Selection}</td>
								</tr>
								<tr>
									<td style="font-weight:bold;">&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">z</td>
									<td>&copy;</td>
									<td style="border-left:1px solid gray;">&nbsp;&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">w&nbsp;</td>
									<td>&#9888;</td>
								</tr>
								<tr>
									<td style="font-weight:bold;">&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">&nbsp;</td>
									<td>&nbsp;</td>
									<td style="border-left:1px solid gray;">&nbsp;&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">!&nbsp;</td>
									<td>{Bold & italics Selection}</td>
								</tr>
								<tr>
									<td style="font-weight:bold;">&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">&nbsp;</td>
									<td>&nbsp;</td>
									<td style="border-left:1px solid gray;">&nbsp;&nbsp;&nbsp;</td>
									<td style="font-weight:bold;">^&nbsp;</td>
									<td>{Bold & Underline Selection}</td>
								</tr>
								</table>
								<b>&lt;b&gt;</b> to bold, <b>&lt;/b&gt;</b> to stop bolding<br />
								<b>&lt;u&gt;</b> to underline, <b>&lt;/u&gt;</b> to stop underlining
							</td>
						</tr>
						<tr>
							<td style="text-align:right;vertical-align:top;">
								Comment&nbsp;Date:&nbsp;
							</td>
							<td style="text-align:left;vertical-align:top;">
								<input type="text" id="txtCommentDateE" style="width:90px;" />
							</td>
							<td style="text-align:center;vertical-align:top;" colspan="2">
								<span id="spnMillCmtDateRange" style="display:none;">
									<button id="btnDecrementDateRange" class="button blue-gradient glossy" onclick="javascript:ChangeDateRange(0);return false;"><</button>
									Date Range:&nbsp;
									<label id="lblMillCmtDateBegin">Undef</label>&nbsp;to&nbsp;<label id="lblMillCmtDateEnd">Undef</label>
									<button id="btnIncrementDateRange" class="button blue-gradient glossy" onclick="javascript:ChangeDateRange(1);return false;">></button>
								</span>
								<span style="margin-left:30px;" colspan="2">
									&nbsp;
									<button id="btnInsertBulletPoint" class="button blue-gradient glossy" style="margin-left:30px;" onclick="insertAtCursor('txaCommentE', '\n&bull;&nbsp;\n'); return false;">Insert Bullet</button>
									<button id="btnUndoCommentEdit" class="button blue-gradient glossy" style="margin-left:2px;" onclick="UndoLastCommentEdit(); return false;">UnDo</button>
									<button id="btnCopyPrevComment" class="button blue-gradient glossy" style="margin-left:30px;display:none;" onclick="CopyPreviousComment(); return false;">Copy Previous Cmt</button>
								</span>
							</td>
						</tr>
						<tr>
							<td style="text-align:right;vertical-align:top;">
								<label id="lblCommentFieldLabel" style="font-weight:bold;">Comment:</label>&nbsp;<br />
								(HTML format)
							</td>
							<td style="text-align:left;vertical-align:top;" colspan="3">
								<textarea id="txaCommentE" style="width:860px;height:420px;font-family:Arial;font-size:11pt;overflow: auto;" placeholder="Enter comments..."></textarea>
							</td>
						</tr>
						<tr>
							<td style="text-align:right;vertical-align:top;">
								Active:&nbsp;
							</td>
							<td style="text-align:left;">
								<select id="selCommentActiveE">
									<option value="1" selected="selected">Yes</option>
									<option value="0">No</option>
								</select>
								<span id="spnOriginatorIDE" style="margin-left:20px;">
									Originator:&nbsp;<select id="selOriginatorID">
										<option value="0" selected="selected">None Selected</option>
									</select>&nbsp;
								</span>&nbsp;&nbsp;
								Insert Graphic&nbsp;<input type="checkbox" id="chkInsertGraphicOn" onchange="javascript:ChangeInsertGraphicSetting(this.checked);return false;" title="File in graphics folder-InsertGraphic.png" />&nbsp;
								<span id="spnGraphicsData" style="display:none;">
									&nbsp;Width:<input type="text" id="txtGraphicWidth" style="width:50px;" />&nbsp;Height:<input type="text" id="txtGraphicHeight" style="width:50px;" />
								</span>
							</td>
							<td style="text-align:right;vertical-align:top;" colspan="2">
								<span style="margin-right:20px;display:none;">Created:<label id="lblCommentCreatedE"></label>&nbsp;-&nbsp;Updated:<label id="lblCommentUpdatedE"></label></span>&nbsp;&nbsp;&nbsp;
							</td>
						</tr>
						<tr>
							<td style="text-align:center;vertical-align:top;" colspan="4">
								<button id="btnSaveCommentData" class="button blue-gradient glossy" onclick="javascript:UpdateCommentData();return false;">Save</button>&nbsp;&nbsp;
								<button id="btnCloseCommentDataEdit" class="button blue-gradient glossy" onclick="javascript:CloseCommentDataEdit();return false;">Close Edit Area</button>
							</td>
						</tr>
						</table>
					</div>
				</div>

				<div id="divCommentList" style="width:100%;display:none;">
					<div id="divProcessListHdr" style="width:100%;background-color:beige;padding-top:4px;padding-bottom:4px;margin-bottom:8px;">
						<table style="width:100%;padding:1px;border-spacing:0px;border:none;">
						<tr>
							<td style="text-align:center;">
								<table style="padding:0px;margin:0px;border-spacing:0px;margin: auto auto;"><tr><td>
									<table style="padding:1px;border-spacing:0px;border-collapse:collapse;background-color:azure;border:1px solid gray;margin: auto auto;">
									<tr style="vertical-align:middle;">
										<td style="background-color:cadetblue;color:white;">
											&nbsp;&nbsp;<label id="lblProcessFilters" style="font-weight:bold;">Comments&nbsp;Grid&nbsp;Filters:</label>&nbsp;&nbsp;
										</td>
										<td style="text-align:right;">
											&nbsp;<label id="lblLocFilter" style="color:teal;font-weight:bold;color:darkgreen;">Location:</label>&nbsp;
										</td>
										<td style="text-align:left;border-right:1px solid gray;">
											<select id="selLocationCodeF"	>
												<option value="0" selected="selected">ALL</option>
											</select>&nbsp;
										</td>
										<td>
											&nbsp;<label id="lblOrigDateFilter" style="color:teal;font-weight:bold;color:darkgreen;">Originated&nbsp;Dates:</label>&nbsp;<input type="text" id="txtBeginDateF" style="width:80px;" value="" />&nbsp;&nbsp;
											<label id="lblOrigDateToFilter" style="color:teal;font-weight:bold;color:darkgreen;">to:</label>&nbsp;<input type="text" id="txtEndDateF" style="width:80px;" value="" />&nbsp;
										</td>
										<td style="border-left:1px solid gray;">
											&nbsp;<label id="lblTitleFilter" style="color:teal;font-weight:bold;color:darkgreen;">Title:</label>&nbsp;<input type="text"id="txtCommentTitleF" style="width:140px;" />&nbsp;
										</td>
										<td style="border-left:1px solid gray;">
											&nbsp;<label id="lblOriginatorIDFilter" style="color:teal;font-weight:bold;color:darkgreen;">Originator:</label>&nbsp;
											<select id="selOrginatorListID" >
												<option value="0" selected="selected">All Originators</option>
											</select>&nbsp;
										</td>
										<td style="border-left:1px solid gray;">
											<button id="btnRefreshStatus" class="button blue-gradient glossy" onclick="javascript:RefreshCurrentDataGrid();return false;">Refresh Data</button>
										</td>
									</tr>
									</table>
								</td></tr></table>
							</td>
						</tr>
						</table>
					</div>

					<div id="divCommentListTbl" style="width:100%;text-align:center;">
						<table style="padding:0px;border-spacing:0px;margin: auto auto;"><tr><td>
							<table id="tblCommentList" style="padding:1px;border-spacing:0px;border-collapse:collapse;font-family:Arial narrow;margin:auto auto;">
							<thead id="tblCommentListHd">
							<tr>
								<th id="thProcessListCol100" class="TableHdrCell" style="width:50px;" rowspan="2">ID</th>
								<th id="thProcessListCol101" class="TableHdrCell" style="width:86x;" rowspan="2">Type</th>
								<th id="thProcessListCol102" class="TableHdrCell" style="width:46px;" rowspan="2">Loc</th>
								<th id="thProcessListCol103" class="TableHdrCell" style="width:200px;" rowspan="2">Title</th>
								<th id="thProcessListCol104" class="TableHdrCell" style="width:600px;" rowspan="2">Comment</th>
								<th id="thProcessListCol105" class="TableHdrCell" style="width:72px;" rowspan="2">Dated</th>
								<th id="thProcessListCol106" class="TableHdrCell" style="width:72px;" colspan="2">Originated</th>
								<th id="thProcessListCol107" class="TableHdrCell" style="width:76px;" rowspan="2">Last Updatd</th>
								<th id="thProcessListCol108" class="TableHdrCell" style="width:44px;" rowspan="2">Active</th>
								<th id="thProcessListCol109" class="TableHdrCell" style="width:41px;" rowspan="2">Action</th>
							</tr>
							<tr>
								<th id="thProcessListCol200" class="TableHdrCell" style="width:72px;" rowspan="2">Dated</th>
								<th id="thProcessListCol201" class="TableHdrCell" style="width:76px;" rowspan="2">By</th>
							</tr>
							</thead>
							<tbody id="tblCommentListBd">
							</tbody>
							<tfoot id="tblCommentListFt">
							</tfoot>
							</table>
						</td></tr></table>
<!-- #include file="../inc/incPaginationDiv.inc" -->
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
