<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WeeklyReport.aspx.cs" Inherits="DataMngt.page.WeeklyReport" %>
<%@ Register Src="~/tools/ctlButtonBarNoSess.ascx" TagName="BtnBar1" TagPrefix="bb1"  %>

<!DOCTYPE html>
<html lang="en">
<head>
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

			.GridHdrCells {
				background-color:lightgray;
				text-align: center;
				font-size:12pt;
				font-weight:bold;
				width:460px;
				height:30px;
				border:3px solid gray;
				overflow: hidden;
			}

			.CommentCells {
				text-align: left;
				font-size: 11pt;
				font-weight: normal;
				color: black;
				background-color: white;
				vertical-align: top;
				overflow: hidden;
				height:250px;
				width:460px;
				border:3px solid gray;
				padding:2px;
			}

			.ButtonBlock {
				text-align: center;
				padding-left: 2px;
				padding-right: 2px;
				padding-top: 1px;
				padding-bottom: 1px;
				font-weight: bold;
			}

			.MainDisplayDIVs {
				position:relative;
				width:99%;
				margin-left:30px;
				margin-right:30px;
				text-align:center;
			}

			.GraphSectionHdr {
				text-align:center;
				font-size:13pt;
				font-family:Tahoma;
				font-weight:bold;
				background-color:#EAEAEA;
			}

	</style>

	<script type="text/javascript">
		var jbA = false;
		var jbAllLocations = false;
		var jbCanEdit = false;
		var jbPaginate = false;
		var jbViewOnly = true;
		var jdivGlacialOpsContent;
		var jdivGraphPanelsContent;
		var jdivGraphPanelsContent2;
		var jdivGraphPanelsContent3;
		var jdivInventoryDashbdContent;
		var jdivNAppalachianOpsContent;
		var	jdivOtherContent;
		var jdivOtherOpsContent;
		var jdivSAppalachianOpsContent;
		var jdivSpreadDashbdContent;
		var jdivWeeklyCommentBlock;
		var jdivWeeklyCommentsContent;
		var jdivWesternOpsContent;
		var jdLastBeginDate = new Date();
		var jdLastEndDate = new Date();
		var jdMonday;
		var jdTarget = new Date();
		var jdToday = new Date();
		var jiAR = 0;
		var jiByID = 0;
		var jiDayNbr = 0;
		var jiMonth = 0;
		var jiNbrPages = 0;
		var jiNbrRows = 0;
		var jiPageID = 45;
		var jiPageNbr = 0;
		var jiPageSize = 20;
		var jiUserID = 0;
		var jiYear = 0;
		//var jlPageStatus;
		var jlStatusMsg;
		var jlWeeklyCommentsByName;
		var jsBrowserType = '';
		var jsCurrentTime = '';
		var jsDayName = '';
		var jselPageSize;
		var jselTimePeriod;
		var jsErrorMsg = '';
		var jsGraphPath = '';
		var jsLastBeginDate = '';
		var jsLastBeginDate112 = '';
		var jsLastEndDate = '';
		var jsLastEndDate112 = '';
		var jsLocationCode = '';
		var jsMonthName = '';
		var jsPageVersion = '';
		var jsPageVersDate = '';
		var jsToday = '';
		var jtBeginDateF;
		var jtEndDateF;

		var MyCalendarEvents;
		var MyCommentList;
		var MyCurrentWeekData;
		var MyDateRangeData;
		var MyDateRangeList;
		var MyLocationList;
		var MyMainComments;
		var MyReturn;
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
			jiPageID = 45;
			jsPageVersion = '1.0.0';
			jsPageVersDate = '8/21/2017';
			jbViewOnly = true;
			jbCanEdit = false;
			// Load global page-loaded variables
			jiByID = jigEmpID;
			jsBrowserType = jsgBrowserType;
			//alert(jsBrowserType);
			jsLocationCode = jsgLoc;
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

			jdivGlacialOpsContent = document.getElementById('divGlacialOperations');
			jdivGraphPanelsContent = document.getElementById('divGraphPanels');
			jdivGraphPanelsContent2 = document.getElementById('divGraphPanels2');
			jdivGraphPanelsContent3 = document.getElementById('divGraphPanels3');
			jdivInventoryDashbdContent = document.getElementById('divInventoryDashboard');
			jdivNAppalachianOpsContent = document.getElementById('divNAppalachianOperations');
			jdivOtherContent = document.getElementById('divOtherContent');
			jdivOtherOpsContent = document.getElementById('divOtherOperations');
			jdivSAppalachianOpsContent = document.getElementById('divSAppalachianOperations');
			jdivSpreadDashbdContent = document.getElementById('divSpreadDashboard');
			jdivWeeklyCommentBlock = document.getElementById('divWeeklyComments');
			jdivWeeklyCommentsContent = document.getElementById('divWeeklyCommentsContent');
			jdivWesternOpsContent = document.getElementById('divWesternOperations');

			//jlPageStatus = document.getElementById('lblPageStatus');
			jlStatusMsg = document.getElementById('lblStatusMsg');
			jlWeeklyCommentsByName = document.getElementById('lblWeeklyCommentsByName');

			jselTimePeriod = document.getElementById('selTimePeriod');

			//jtBeginDateF = document.getElementById('txtBeginDateF');
			//jtEndDateF = document.getElementById('txtEndDateF');

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
			if ((evt2.keyCode == 9) && (jbEditingComment === true)) { jtaCommentE.innerHTML = jtaCommentE.innerHTML + '     '; return false; }
			if (evt2.ctrlKey && (jbEditingComment === true)) {
				var val = String.fromCharCode(event.which).toLowerCase();
				GetMacroTextEM(0, 1, val, jtaCommentE);
				event.preventDefault();
			}
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
			//alert('beginning initiation');
			if (jbA !== true) {
				//alert('stuff');
			}
			if (jbA === true || jigCW === true) {
				//appendDDLOptionGu(jselLocationCodeE, 'HQ', 'Company Comment');
				//alert('stuff');
			}
			else {
				//jbtnMillOrder.style.display = 'none';
			}

			jiPgNbrPj[0] = 0;
			jiNbrPagesPj[0] = 0;
			jiNbrRowsPj[0] = 0;
			jiNbrPagesPj[1] = 0;
			jiNbrRowsPj[1] = 0;
			jiPageSize = 20;
			//alert(jiCommentType);
			
			//alert('set 1');
			//EstablishMainPgElementsPj(1, 0);
			//EstablishMainPgElementsPj(2, 0);
			var typ = '1';
			//alert('locations list');
			PopulateLocationList();
			try {
				//alert(jsLocationCode)
				jselLocationCodeE.value = jsLocationCode;
				jselLocationCodeF.value = jsLocationCode;
			}
			catch (ex) {
				// nothing
			}

			GetCurrentMngtWeek();
			jdMonday = getLastMondayDm(jdToday);
			if (!IsContentsNullUndefEmptyGu(MyCurrentWeekData)) {
				jiYear = parseInt(MyCurrentWeekData[0]['CalendarYear'], 10);
				jiMonth =	parseInt(MyCurrentWeekData[0]['CalendarMonth'], 10);
				jiDayNbr = parseInt(MyCurrentWeekData[0]['DayInMonth'], 10);
				jsMonthName = MyCurrentWeekData[0]['MonthStrName'].toString();
				jsDayName = MyCurrentWeekData[0]['DayInWeekName'].toString();
				jdLastEndDate = new Date(jiYear, jiMonth, jiDayNbr, 1, 1, 1, 0);
				jsLastEndDate = MyCurrentWeekData[0]['sRptEndDate'].toString();
			}
			else {
				jdLastEndDate = jdMonday.addDays(-1);
				jsLastEndDate = getMyDateTimeStringDm(jdLastEndDate, 8);
			}
			//alert(jsLastEndDate)
			ChangeDateRange(jsLastEndDate);
			//alert('loading time period list');
			PopulateTimePeriodList();
			//alert(jsLastEndDate + '/' + jselTimePeriod.value);
			jselTimePeriod.value = jsLastEndDate;

			//alert('Initiation done');
			//jlPageStatus.innerHTML = 'Page Ready';
			document.getElementById('lblPageIDInFooter').innerHTML = 'Page ID:&nbsp;' + jiPageID.toString();
			return false;
		}
		// END of page initiation section --------------------------------------------------------------------------------

		// **************************** AJAX FUNCTIONS *********************************

		function DataCall1() {
			jiPageNbr = jiPgNbrPj[0];
			//alert('Page ' + jiPageNbr + '/' + typ);
			//GetCommentList(0, typ, '', 0, 0, 1);
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
			//var typ = 1;
			//var yr = jselCalYear.value;
			//var url = "../shared/AdminServices.asmx/SelectCalendarEvents";
			//var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','CalType':'" + typ + "','Yr':'" + yr + "','Mo':'0','ByID':'" + jiByID.toString() + "'}";
			////alert(MyData);																																																																	  
			//getJSONReturnDataAs(url, MyData, function (response)
			//{ MyCalendarEvents = response; });
			return false;
		}

		function GetCommentGroup() {
			var url = "../shared/GridSupportServices.asmx/SelectCommentList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ID':'0','CmtType':'1','Title':'','UserID':'0','sDtB':'" + jsLastBeginDate + "','sDtE':'" + jsLastEndDate + "','Loc':'','Sort':'9','Active':'1',";
			MyData = MyData + "'PgNbr':'0','PgSize':'999','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCommentList = response; });
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

		function GetDateRangeList() {
			var url = "../shared/GridSupportServices.asmx/SelectDateRangeForMillCmtList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','TargetDt':'" + jsLastEndDate + "','NbrInList':'150','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyDateRangeList = response; });
			return false;
		}

		function GetDateRangeForMillCmt(tdt) {
			var url = "../shared/GridSupportServices.asmx/SelectDateRangeForMillCmt";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','TargetDt':'" + tdt + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyDateRangeData = response; });
			return false;
		}

		function GetMainComments() {
			var url = "../shared/GridSupportServices.asmx/SelectCommentList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ID':'0','CmtType':'1','Title':'','UserID':'0','sDtB':'" + jsLastBeginDate + "','sDtE':'" + jsLastEndDate + "','Loc':'HQ','Sort':'0',";
			MyData = MyData + "'Active':'1','PgNbr':'0','PgSize':'999','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyMainComments = response; });
			return false;
		}

		function GetLocationList() {
			var url = "../shared/AdminServices.asmx/SelectLocationListSpecial";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','UserID':'" + jiByID.toString() + "','Reg':'','AppArea':'CommentMngt','Loc':'','LocType':'','Country':'','Sort':'0',";
			MyData = MyData + "'Active':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyLocationList = response; });
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

		function GetUserList(id, nm, ctry, city, loc, pos, grp, sort, act) {
			var url = "../shared/AdminServices.asmx/SelectUserList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ID':'" + id.toString() + "','Name':'" + nm + "','Ctry':'" + ctry + "','City':'" + city + "','Loc':'" + loc + "','Pos':'" + pos + "','Grp':'" + grp + "',";
			MyData = MyData + "'Sort':'" + sort.toString() + "','Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyUserList = response; });
			return false;
		}

		// **************************** Populate *********************************

		function PopulateMainComments() {
			var hasgraph = 0;
			var ht = 0;
			var val = '';
			var wdth = 0;
			GetMainComments();
			if (!IsContentsNullUndefEmptyTx(MyMainComments)) {
				val = PrepareHTMLForViewTx(PrepareJSStringForHTMLDisplayTx(MyMainComments[0]['Comment'].toString()), 2);
				if (val.indexOf('&otime;') > -1) {
					hasgraph = 1;
					ht = parseInt(MyMainComments[0]['GraphicHeightInPixels'], 10);
					wdth = parseInt(MyMainComments[0]['GraphicWidthInPixels'], 10);
					val.replace('&otime', '<img src="../Images/graphs/' + jsGraphPath + '/InsertGraphic.png" style="height:' + ht.toString() + 'px;width:' + wdth.toString() + 'px;" />');
				}
				if (!IsContentsNullUndefEmptyGu(val)) {
					while (val.indexOf('<br /><br /><br />') > 0) {
						val = val.replace('<br /><br /><br />', '<br /><br />');
					}
				}
				//alert(val);
				jdivWeeklyCommentsContent.innerHTML = val; //PrepareJSStringForHTMLDisplayTx(
				jlWeeklyCommentsByName.innerHTML = MyMainComments[0]['sOrigFullName2'].toString();
			}
			else {
				jdivWeeklyCommentsContent.innerHTML = '';
				jlWeeklyCommentsByName.innerHTML = '';
			}
			return false;
		}

		function PopulateWeeklyComments() {
			var loc = '';
			var val = '';
			EmptyCommentsGroup();
			GetCommentGroup();
			//alert(MyCommentList.length);
			if (!IsContentsNullUndefEmptyTx(MyCommentList)) {
				var nrows = MyCommentList.length;
				for (var row = 0; row < nrows; row++) {
					loc = MyCommentList[row]['LocCode'].toString();
					//if (row == nrows - 1) { alert(loc);}
					val = PrepareJSStringForHTMLDisplayTx(MyCommentList[row]['Comment'].toString());
					//alert(loc);
					if (val !== '') {
						switch (loc) {
							case 'MEUG':
								document.getElementById('tdComments010101').innerHTML = val;
								break;
							case 'MLON':
								document.getElementById('tdComments010102').innerHTML = val;
								break;
							case 'MCEN':
								document.getElementById('tdComments010103').innerHTML = val;
								break;
							case 'MGAR':
								document.getElementById('tdComments010201').innerHTML = val;
								break;
							case 'MMTV':
								document.getElementById('tdComments010202').innerHTML = val;
								break;
							case 'MLEW':
								document.getElementById('tdComments020101').innerHTML = val;
								break;
							case 'MGRR':
								document.getElementById('tdComments020102').innerHTML = val;
								break;
							case 'MONA':
								document.getElementById('tdComments020103').innerHTML = val;
								break;
							case 'MDOR':
								document.getElementById('tdComments020201').innerHTML = val;
								break;
							case 'MDRY':
								document.getElementById('tdComments020201').innerHTML = val;
								break;
							case 'MPAS':
								document.getElementById('tdComments030101').innerHTML = val;
								break;
							case 'MPAY':
								document.getElementById('tdComments030101').innerHTML = val;
								break;
							case 'MHOP':
								document.getElementById('tdComments030102').innerHTML = val;
								break;
							case 'MHDY':
								document.getElementById('tdComments030102').innerHTML = val;
								break;
							case 'RLOU':
								document.getElementById('tdComments030103').innerHTML = val;
								break;
							case 'MMLS':
								document.getElementById('tdComments030201').innerHTML = val;
								break;
							case 'MTVL':
								document.getElementById('tdComments030202').innerHTML = val;
								break;
							case 'MRWY':
								document.getElementById('tdComments030203').innerHTML = val;
								break;
							case 'MOHY':
								document.getElementById('tdComments030301').innerHTML = val;
								break;
							case 'MBVS':
								document.getElementById('tdComments040101').innerHTML = val;
								break;
							case 'MBVY':
								document.getElementById('tdComments040101').innerHTML = val;
								break;
							case 'MDLY':
								//alert(val);
								document.getElementById('tdComments040202').innerHTML = val;
								//alert(val);
								break;
							case 'MMRS':
								document.getElementById('tdComments040102').innerHTML = val;
								break;
							case 'MMRY':
								document.getElementById('tdComments040102').innerHTML = val;
								break;
							case 'MNCY':
								document.getElementById('tdComments040103').innerHTML = val;
								break;
							case 'MHAC':
								document.getElementById('tdComments040201').innerHTML = val;
								break;
							case 'MWVY': // Marlinton Yard
								document.getElementById('tdComments040203').innerHTML = val;
								break;
							case 'MMCK': // Mill Creek
								document.getElementById('tdComments040301').innerHTML = val;
								break;
							case 'RSTA': // Tuscumbia
								document.getElementById('tdComments050101').innerHTML = val;
								break;
							case 'DELK': // Elkhart
								document.getElementById('tdComments050102').innerHTML = val;
								break;
							case 'MCUR': // Exotics/Currie
								document.getElementById('tdComments050103').innerHTML = val;
								break;
							case 'RPO9': // Potomac
								document.getElementById('tdComments050201').innerHTML = val;
								break;
							default:
								break;
						}
					}
				}
			}
			return false;
		}

		function PopulateGraphMatrix() {
			//alert(jsGraphPath);
			//alert('../images/' + jsGraphPath + '/GraphPanel010101.gif');
			document.getElementById('imgGraphPanel010101').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel010101.gif';
			document.getElementById('imgGraphPanel010102').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel010102.gif';
			document.getElementById('imgGraphPanel010103').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel010103.gif';
			document.getElementById('imgGraphPanel010201').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel010201.gif';
			document.getElementById('imgGraphPanel010202').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel010202.gif';
			document.getElementById('imgGraphPanel010301').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel010301.gif';
			document.getElementById('imgGraphPanel010302').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel010302.gif';
			document.getElementById('imgGraphPanel010303').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel010303.gif';
			document.getElementById('imgGraphPanel020101').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel020101.gif';
			document.getElementById('imgGraphPanel020102').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel020102.gif';
			document.getElementById('imgGraphPanel020103').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel020103.gif';
			document.getElementById('imgGraphPanel020201').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel020201.gif';
			document.getElementById('imgGraphPanel020202').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel020202.gif';
			document.getElementById('imgGraphPanel020203').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel020202.gif';
			document.getElementById('imgGraphPanel020301').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel020301.gif';
			document.getElementById('imgGraphPanel020302').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel020302.gif';
			document.getElementById('imgGraphPanel020303').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel020303.gif';
			document.getElementById('imgGraphPanel030101').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel030101.gif';
			document.getElementById('imgGraphPanel030102').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel030102.gif';
			document.getElementById('imgGraphPanel030103').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel030103.gif';
			document.getElementById('imgGraphPanel030201').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel030201.gif';
			document.getElementById('imgGraphPanel030202').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel030202.gif';
			document.getElementById('imgGraphPanel030203').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel030202.gif';
			document.getElementById('imgGraphPanel030301').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel030301.gif';
			document.getElementById('imgGraphPanel030302').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel030302.gif';
			document.getElementById('imgGraphPanel030303').src = '../Images/graphs/' + jsGraphPath + '/GraphPanel030303.gif';
			return false;
		}

		function PopulateInventoryDashboard() {
			return false;
		}

		function PopulateLocationList() {



		}

		function PopulateSpreadDashboard() {
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

		// **************************** Dialogs *********************************

		function ActivateHyperlink(id, objid, val1, val2, val3) {
			return false;
		}

		function ChangeCheckBox(id, objid, val, ischecked) {
			return false;
		}

		function ChangeDropDownVal(id, objid, row, col, val) {
			switch (objid) {
				case 1:
					break;
				default:
					break;
			}
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

		function ChangeRadioBtn(id, objid, val, ischecked) {
			return false;
		}

		function DeleteOneRec(id, row, objid) {
			switch (objid) {
				case 1:
					break;
				case 94:
					alert('Fired Delete');
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
				case 13: // 
					break;
				default:
					break;
			}
			return false;
		}

		function HandleImageClick(id, col, objid) {
			return false;
		}

		function ViewOneRec(id, row, objid) {
			return false;
		}

		function EditOneRec(id, row, objid) {
			switch (objid) {
				case 1: // 
					break;
				default:
					break;
			}

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

		// **************************** Background *********************************

		function EmptyCommentsGroup() {
			document.getElementById('tdComments010101').innerHTML = '';
			document.getElementById('tdComments010102').innerHTML = '';
			document.getElementById('tdComments010103').innerHTML = '';
			document.getElementById('tdComments010201').innerHTML = '';
			document.getElementById('tdComments010202').innerHTML = '';
			document.getElementById('tdComments020101').innerHTML = '';
			document.getElementById('tdComments020102').innerHTML = '';
			document.getElementById('tdComments020103').innerHTML = '';
			document.getElementById('tdComments020201').innerHTML = '';
			document.getElementById('tdComments030101').innerHTML = '';
			document.getElementById('tdComments030102').innerHTML = '';
			document.getElementById('tdComments030103').innerHTML = '';
			document.getElementById('tdComments030201').innerHTML = '';
			document.getElementById('tdComments030202').innerHTML = '';
			document.getElementById('tdComments030203').innerHTML = '';
			document.getElementById('tdComments030301').innerHTML = '';
			document.getElementById('tdComments040101').innerHTML = '';
			document.getElementById('tdComments040102').innerHTML = '';
			document.getElementById('tdComments040103').innerHTML = '';
			document.getElementById('tdComments040201').innerHTML = '';
			document.getElementById('tdComments040202').innerHTML = '';
			document.getElementById('tdComments040203').innerHTML = '';
			document.getElementById('tdComments040301').innerHTML = '';
			document.getElementById('tdComments050101').innerHTML = '';
			document.getElementById('tdComments050102').innerHTML = '';
			document.getElementById('tdComments050103').innerHTML = '';
			document.getElementById('tdComments050201').innerHTML = '';
			return false;
		}

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

		function ChangeDateRange(sdt) {
			jsLastEndDate = sdt;
			GetDateRangeForMillCmt(jsLastEndDate);
			if (!IsContentsNullUndefEmptyTx(MyDateRangeData)) {
				jdLastBeginDate = convertStringToLocalDateDm(MyDateRangeData[0]['sStartDate'].toString());
				jdLastEndDate = convertStringToLocalDateDm(MyDateRangeData[0]['sEndDate'].toString());
				jsLastBeginDate = getMyDateTimeStringDm(jdLastBeginDate, 8);
				jsLastBeginDate112 = MyDateRangeData[0]['sStartDate112'].toString();
				jsLastEndDate112 = MyDateRangeData[0]['sEndDate112'].toString();
			}
			else {
				jdLastBeginDate = convertStringToLocalDateDm(jdMonday.addDays(-7).toString());
				jsLastBeginDate = getMyDateTimeStringDm(jdLastBeginDate, 8);
				jsLastBeginDate112 = convertStringDatetoFormatDm(jsLastBeginDate, 112);
				jsLastEndDate112 = convertStringDatetoFormatDm(jsLastEndDate, 112);
			}
			jsGraphPath = jsLastEndDate112;
			// load data onto form
			//alert(jdLastEndDate);
			document.getElementById('lblWeeklyReportMonthName').innerHTML = jaDMmonthNames2[jdLastBeginDate.getMonth()];
			document.getElementById('lblWeeklyReportDay').innerHTML = jdLastBeginDate.getDate().toString();
			document.getElementById('lblWeeklyReportYear4digit').innerHTML = jdLastBeginDate.getFullYear().toString();
			document.getElementById('lblWeeklyReportMonthName2').innerHTML = jaDMmonthNames2[jdLastEndDate.getMonth()];
			document.getElementById('lblWeeklyReportDay2').innerHTML = jdLastEndDate.getDate().toString();
			document.getElementById('lblWeeklyReportYear4digit2').innerHTML = jdLastEndDate.getFullYear().toString();

			PopulateMainComments();
			PopulateGraphMatrix();
			PopulateWeeklyComments();
			PopulateInventoryDashboard();
			PopulateSpreadDashboard();
			return false;
		}

		function ChangePageSize(val) {
			jiPageSize = parseInt(val, 10);
			refreshDataGrid();
			return false;
		}

		function HideAllAreas() {
			jdivGlacialOpsContent.style.display = 'none';
			jdivGraphPanelsContent.style.display = 'none';
			jdivGraphPanelsContent2.style.display = 'none';
			jdivGraphPanelsContent3.style.display = 'none';
			jdivInventoryDashbdContent.style.display = 'none';
			jdivNAppalachianOpsContent.style.display = 'none';
			jdivOtherContent.style.display = 'none';
			jdivOtherOpsContent.style.display = 'none';
			jdivSAppalachianOpsContent.style.display = 'none';
			jdivSpreadDashbdContent.style.display = 'none';
			jdivWeeklyCommentBlock.style.display = 'none';
			jdivWesternOpsContent.style.display = 'none';
			return false;
		}

		function ShowReportContents(typ) {
			HideAllAreas();
			switch (typ) {
				case 0: // show global comments
					//PopulateMainComments();
					jdivWeeklyCommentBlock.style.display = 'block';
					break;
				case 1:	// ___
					break;
				case 2: // Gen graphs
					jdivGraphPanelsContent.style.display = 'block';
					break;
				case 3: // prod graphs
					jdivGraphPanelsContent2.style.display = 'block';
					break;
				case 4: // inv dashboard
					jdivInventoryDashbdContent.style.display = 'block';
					break;
				case 5: // 
					jdivSpreadDashbdContent.style.display = 'block';
					break;
				case 6:
					jdivWesternOpsContent.style.display = 'block';
					break;
				case 7:
					//alert(document.getElementById('tdComments020201').innerHTML);
					jdivGlacialOpsContent.style.display = 'block';
					break;
				case 8:
					jdivNAppalachianOpsContent.style.display = 'block';
					break;
				case 9:
					jdivSAppalachianOpsContent.style.display = 'block';
					break;
				case 10:
					jdivOtherOpsContent.style.display = 'block';
					break;
				case 11:
					jdivGraphPanelsContent3.style.display = 'block';
					break;
				default:
					break;
			}
			return false;
		}

		// **************************** External Links *********************************

		function ExportRptToPDF() {




			return false;
		}

	</script>
			
  <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />

</head>
<body>
	<img id="imgSessionKeepAlive" width="1" height="1" style="display:none;" src="../Images/clearpixel.gif" />
  <form id="form1" runat="server">
  <asp:ScriptManager runat="server"></asp:ScriptManager>
	<asp:HiddenField ID="hfPageID" runat="server" Value="45" />

	<div id="divMainPopup" style="display:none;"></div>

	<div id="divCommentsGroup" style="display:none;"></div>

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

			<div id="divPAGEHEADER" style="width:100%;margin-left:10px;margin-bottom:10px;display:block;">
				<div id="divPageHdrTitle" style="width:100%;">
					<span id="dspnHdrConfMsg" style="width:100%;text-align:center;font-weight:bold;color:darkred;font-family:Tahoma;font-size:13pt;margin-top:6px;">
						CONFIDENTIAL ‐Internal Audience Only <br />
					</span>
					<!--label id="lblPageStatus" style="font-size:10pt;font-weight:bold;color:darkgray;">Page Loading...</!label-->
					<button id="btnExportToPDF" style="position:absolute;right:70px;" onclick="javascript:ExportRptToPDF();return false;" class="button blue-gradient glossy">Export to PDF</button>
				</div>
				<div id="divMainHdrSelects" style="width:100%;text-align:center;font-size:15pt;font-family:Tahoma;font-weight:bold;">
					<span id="spnLeftMainHdr" style="width:50%;color:black;">
						WEEKLY REPORT - Week of: <span style="color:darkgreen;"><label id="lblWeeklyReportDayName">Monday</label>, 
						<label id="lblWeeklyReportMonthName"></label>&nbsp;<label id="lblWeeklyReportDay"></label>, <label id="lblWeeklyReportYear4digit"></label>&nbsp;<label style="color:blue;">to</label>
						<label id="lblWeeklyReportDayName2">Sunday</label>, 
						<label id="lblWeeklyReportMonthName2"></label>&nbsp;<label id="lblWeeklyReportDay2"></label>, <label id="lblWeeklyReportYear4digit2"></label></span>&nbsp;
					</span>
					<span id="spnLeftMainHdr" style="width:50%;left:50%;text-align:right;">
						<img id="imgMainLogo" src="../Images/NWH_GreenLogo.gif" style="width:200px;height:24px;" />
					</span>
				</div>
			</div>

			<div id="divPAGEMAINSECTION" style="width:100%;margin-left:10px;display:block;">
				<div id="divMainFilters" style="width:100%;text-align:center;margin-bottom:6px;">
					<span style="font-weight:bold;font-size:14pt;color:darkgreen;">Target&nbsp;Time&nbsp;Period:</span>&nbsp;
					<select id="selTimePeriod" onchange="javascript:ChangeDateRange(this.value);return false;" style="font-size:14pt;color:darkgreen;">
						<option value="0" selected="selected">None Selected</option>
					</select>
				</div>

				<div id="divTableOfContents" style="width:100%;text-align:center;margin-bottom:6px;">
					<table style="border:6px outset lightgoldenrodyellow;padding:0px;background-color:aquamarine;border-spacing:0px;margin: auto auto;"><tr><td>
						<table style="text-align:center;border:none;border-collapse:collapse;margin: auto auto;">
						<tr style="font-weight:bold;">
							<td style="background-color:cornflowerblue;color:black;">
								Comments
							</td>
							<td colspan="4" style="background-color:coral;color:black;">
								Dashboards
							</td>
							<td colspan="5" style="background-color:burlywood;color:black;">
								Operational Comments
							</td>
						</tr>
						<tr style="background-color:darkseagreen;">
							<td class="ButtonBlock">
							 <button id="btnShowGlobalComments" class="button blue-gradient glossy" onclick="javascript:ShowReportContents(0);return false;" style="width:100pt;height:26px;">Global Comments</button>
							</td>
							<td class="ButtonBlock">
							 <button id="btnShowGraphPanel1" class="button blue-gradient glossy" onclick="javascript:ShowReportContents(2);return false;" style="width:102pt;height:26px;">General Graphs</button>
							</td>
							<td class="ButtonBlock">
							 <button id="btnShowGraphPanel2" class="button blue-gradient glossy" onclick="javascript:ShowReportContents(3);return false;" style="width:102pt;height:26px;">Production Graphs</button>
							</td>
							<td class="ButtonBlock">
							 <button id="btnShowGraphPanel3" class="button blue-gradient glossy" onclick="javascript:ShowReportContents(11);return false;" style="width:102pt;height:26px;">KD ASP/Spread</button>
							</td>
							<td class="ButtonBlock">
							 <button id="btnShowInvDashboard" class="button blue-gradient glossy" onclick="javascript:ShowReportContents(4);return false;" style="width:100pt;height:26px;">Inventory</button>
							</td>
							<td class="ButtonBlock">
							 <button id="btnShowWestComments" class="button blue-gradient glossy" onclick="javascript:ShowReportContents(6);return false;" style="width:100pt;height:26px;">Western</button>
							</td>
							<td class="ButtonBlock">
							 <button id="btnShowGlacialComments" class="button blue-gradient glossy" onclick="javascript:ShowReportContents(7);return false;" style="width:100pt;height:26px;">Glacial</button>
							</td>
							<td class="ButtonBlock">
							 <button id="btnShowNAppComments" class="button blue-gradient glossy" onclick="javascript:ShowReportContents(8);return false;" style="width:100pt;height:26px;">N. Appalachian</button>
							</td>
							<td class="ButtonBlock">
							 <button id="btnShowSAppComments" class="button blue-gradient glossy" onclick="javascript:ShowReportContents(9);return false;" style="width:100pt;height:26px;">S. Appalachian</button>
							</td>
							<td class="ButtonBlock">
							 <button id="btnShowOtherComments" class="button blue-gradient glossy" onclick="javascript:ShowReportContents(10);return false;" style="width:100pt;height:26px;">Other</button>
							</td>
						</tr>
						</table>
					</td></tr></table>
				</div>
			
				<div id="divWeeklyComments" class="MainDisplayDIVs" style="display:block;text-align:left;margin-right:70px;">
					<div id="divWeeklyCommentsHdr" style="width:100%;font-weight:bold;font-size:16pt;margin-bottom:8px;">
						Weekly Comments - <label id="lblWeeklyCommentsByName"></label>
					</div>
					<div id="divWeeklyCommentsContent" style="position:relative;width:97%;font-size:14pt;font-family:Arial;text-align:left;vertical-align:top;left:10px;">
					</div>
				</div>
			
				<div id="divGraphPanels" class="MainDisplayDIVs" style="display:none;">
					<table style="padding:0px;border-spacing:0px;border:1px solid gray;margin: auto auto;"><tr><td>
						<table id="tblGraphPanels1" style="padding:1px;border-spacing:0px;border:none;margin: auto auto;"">
						<tr>
							 <td style="text-align:left;width:33%;" colspan="2">
								<img id="imgGraphPanel010101" src="../Images/NWH_GreenLogo.gif" style="width:460px;height:230px;" />
							 </td>
							 <td style="text-align:center;width:34%;" colspan="2">
								<img id="imgGraphPanel010102" src="../Images/NWH_GreenLogo.gif" style="width:460px;height:230px;" />
							 </td>
							 <td style="text-align:right;width:33%;" colspan="2">
								<img id="imgGraphPanel010103" src="../Images/NWH_GreenLogo.gif" style="width:460px;height:230px;" />
							 </td>
						</tr>
						<tr>
							 <td style="text-align:left;width:33%;" colspan="3">
								<img id="imgGraphPanel010201" src="../Images/NWH_GreenLogo.gif" style="width:690px;height:230px;" />
							 </td>
							 <td style="text-align:right;width:33%;" colspan="3">
								<img id="imgGraphPanel010202" src="../Images/NWH_GreenLogo.gif" style="width:690px;height:230px;" />
							 </td>
						</tr>
						<tr>
							 <td style="text-align:left;width:33%;" colspan="2">
								<img id="imgGraphPanel010301" src="../Images/NWH_GreenLogo.gif" style="width:460px;height:230px;" />
							 </td>
							 <td style="text-align:center;width:34%;" colspan="2">
								<img id="imgGraphPanel010302" src="../Images/NWH_GreenLogo.gif" style="width:460px;height:230px;" />
							 </td>
							 <td style="text-align:right;width:33%;" colspan="2">
								<img id="imgGraphPanel010303" src="../Images/NWH_GreenLogo.gif" style="width:460px;height:230px;" />
							 </td>
						</tr>
						</table>
					</td></tr></table>	
				</div>

				<div id="divGraphPanels3" class="MainDisplayDIVs" style="display:none;">
					<table style="padding:0px;border-spacing:0px;border:1px solid gray;margin: auto auto;"><tr><td>
						<table id="tblGraphPanels3" style="padding:1px;border-spacing:0px;border:none;margin: auto auto;">
						<tr>
							 <td style="text-align:left;width:33%;">
								<img id="imgGraphPanel030101" src="../Images/NWH_GreenLogo.gif" style="width:460px;height:210px;" />
							 </td>
							 <td style="text-align:center;width:34%;">
								<img id="imgGraphPanel030102" src="../Images/NWH_GreenLogo.gif" style="width:460px;height:210px;" />
							 </td>
							 <td style="text-align:right;width:33%;">
								<img id="imgGraphPanel030103" src="../Images/NWH_GreenLogo.gif" style="width:460px;height:210px;" />
							 </td>
						</tr>
						<tr>
							 <td style="text-align:left;width:33%;">
								<img id="imgGraphPanel030201" src="../Images/NWH_GreenLogo.gif" style="width:460px;height:210px;" />
							 </td>
							 <td style="text-align:center;width:34%;">
								<img id="imgGraphPanel030202" src="../Images/NWH_GreenLogo.gif" style="width:460px;height:210px;" />
							 </td>
							 <td style="text-align:right;width:33%;">
								<img id="imgGraphPanel030203" src="../Images/NWH_GreenLogo.gif" style="width:460px;height:210px;" />
							 </td>
						</tr>
						<tr>
							 <td style="text-align:left;width:33%;">
								<img id="imgGraphPanel030301" src="../Images/NWH_GreenLogo.gif" style="width:460px;height:210px;" />
							 </td>
							 <td style="text-align:center;width:34%;">
								<img id="imgGraphPanel030302" src="../Images/NWH_GreenLogo.gif" style="width:460px;height:210px;" />
							 </td>
							 <td style="text-align:right;width:33%;">
								<img id="imgGraphPanel030303" src="../Images/NWH_GreenLogo.gif" style="width:460px;height:210px;" />
							 </td>
						</tr>
						</table>	
					</td></tr></table>	
				</div>

								<div id="divGraphPanels2" class="MainDisplayDIVs" style="display:none;">
					<table style="padding:0px;border-spacing:0px;border:1px solid gray;margin: auto auto;"><tr><td>
						<table id="tblGraphPanels2" style="padding:1px;border-spacing:0px;border:none;margin: auto auto;">
						<tr>
							<td colspan="3" class="GraphSectionHdr">
								Sawmill Production
							</td>
						</tr>
						<tr>
							 <td style="text-align:left;width:33%;">
								<img id="imgGraphPanel020101" src="../Images/NWH_GreenLogo.gif" style="width:460px;height:210px;" />
							 </td>
							 <td style="text-align:center;width:34%;">
								<img id="imgGraphPanel020102" src="../Images/NWH_GreenLogo.gif" style="width:460px;height:210px;" />
							 </td>
							 <td style="text-align:right;width:33%;">
								<img id="imgGraphPanel020103" src="../Images/NWH_GreenLogo.gif" style="width:460px;height:210px;" />
							 </td>
						</tr>
						<tr>
							<td colspan="3" class="GraphSectionHdr">
								Drying Production
							</td>
						</tr>
						<tr>
							 <td style="text-align:left;width:33%;">
								<img id="imgGraphPanel020201" src="../Images/NWH_GreenLogo.gif" style="width:460px;height:210px;" />
							 </td>
							 <td style="text-align:center;width:34%;">
								<img id="imgGraphPanel020202" src="../Images/NWH_GreenLogo.gif" style="width:460px;height:210px;" />
							 </td>
							 <td style="text-align:right;width:33%;">
								<img id="imgGraphPanel020203" src="../Images/NWH_GreenLogo.gif" style="width:460px;height:210px;" />
							 </td>
						</tr>
						<tr>
							<td colspan="3" class="GraphSectionHdr">
								Finishing Production
							</td>
						</tr>
						<tr>
							 <td style="text-align:left;width:33%;">
								<img id="imgGraphPanel020301" src="../Images/NWH_GreenLogo.gif" style="width:460px;height:210px;" />
							 </td>
							 <td style="text-align:center;width:34%;">
								<img id="imgGraphPanel020302" src="../Images/NWH_GreenLogo.gif" style="width:460px;height:210px;" />
							 </td>
							 <td style="text-align:right;width:33%;">
								<img id="imgGraphPanel020303" src="../Images/NWH_GreenLogo.gif" style="width:460px;height:210px;" />
							 </td>
						</tr>
						</table>	
					</td></tr></table>	
				</div>

				<div id="divInventoryDashboard" class="MainDisplayDIVs" style="display:none;">
					<div id="divInvDBContent" style="width:100%;height:700px;text-align:center;vertical-align:middle;">
						<br /><br /><br />Future Inventory Dashboard Content
					</div>
				</div>

				<div id="divSpreadDashboard" class="MainDisplayDIVs" style="display:none;">
					<div id="divSpreadDBContent" style="width:100%;height:700px;text-align:center;vertical-align:middle;">
						<br /><br /><br />Future KD ASP, Green Purchase Costs & Spread Dashboard Content
					</div>
				</div>

				<div id="divWesternOperations" class="MainDisplayDIVs" style="display:none;">
					<div id="divWesternOpsHdr" style="font-size:14pt;font-weight:bold;color:blue;width:100%;">
						Western Operations
					</div>
					<table id="tblWesternOperations" style="padding:2px;border-spacing:0px;border-collapse:collapse;margin: auto auto;">
					<tr>
						<td class="GridHdrCells">
							Eugene
						</td>
						<td class="GridHdrCells">
							Longview
						</td>
						<td class="GridHdrCells">
							Centralia
						</td>
					</tr>
					<tr>
						<td id="tdComments010101" class="CommentCells">
							&nbsp;
						</td>
						<td id="tdComments010102" class="CommentCells">
							&nbsp;
						</td>
						<td id="tdComments010103" class="CommentCells">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td class="GridHdrCells">
							Garibaldi
						</td>
						<td class="GridHdrCells">
							Mt. Vernon
						</td>
						<td style="border:none;">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td id="tdComments010201" class="CommentCells">
							&nbsp;
						</td>
						<td id="tdComments010202" class="CommentCells">
							&nbsp;
						</td>
						<td id="tdComments010203" style="border:none;">
							&nbsp;
						</td>
					</tr>
					</table>
				</div>

				<div id="divGlacialOperations" class="MainDisplayDIVs" style="display:none;"">
					<div id="divGlacialOpsHdr" style="font-size:14pt;font-weight:bold;color:blue;width:100%;">
						Glacial Operations
					</div>
					<table id="tblGlacialOperations" style="padding:2px;border-spacing:0px;border-collapse:collapse;margin: auto auto;">
					<tr>
						<td class="GridHdrCells">
							Lewiston
						</td>
						<td class="GridHdrCells">
							Grand Rapids
						</td>
						<td class="GridHdrCells">
							Onalaska
						</td>
					</tr>
					<tr>
						<td id="tdComments020101" class="CommentCells">
							&nbsp;
						</td>
						<td id="tdComments020102" class="CommentCells">
							&nbsp;
						</td>
						<td id="tdComments020103" class="CommentCells">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td class="GridHdrCells">
							Dorchester
						</td>
						<td style="border:none;">
							&nbsp;
						</td>
						<td style="border:none;">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td id="tdComments020201" class="CommentCells">
							&nbsp;
						</td>
						<td id="tdComments020202" class="CommentCells" style="border:none;" >
							&nbsp;
						</td>
						<td id="tdComments020203" class="CommentCells" style="border:none;">
							&nbsp;
						</td>
					</tr>
					</table>
				</div>

				<div id="divNAppalachianOperations" class="MainDisplayDIVs" style="display:none;">
					<div id="divNAppOpsHdr" style="font-size:14pt;font-weight:bold;color:blue;width:100%;">
						North Appalachian Operations
					</div>
					<table id="tblNAppalachianOperations" style="padding:2px;border-spacing:0px;border-collapse:collapse;margin: auto auto;">
					<tr>
						<td class="GridHdrCells">
							Endeavor
						</td>
						<td class="GridHdrCells">
							Hopwood
						</td>
						<td class="GridHdrCells">
							Loudonville
						</td>
					</tr>
					<tr>
						<td id="tdComments030101" class="CommentCells">
							&nbsp;
						</td>
						<td id="tdComments030102" class="CommentCells">
							&nbsp;
						</td>
						<td id="tdComments030103" class="CommentCells">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td class="GridHdrCells">
							Marienville
						</td>
						<td class="GridHdrCells">
							Titusville
						</td>
						<td class="GridHdrCells">
							Ridgeway
						</td>
					</tr>
					<tr>
						<td id="tdComments030201" class="CommentCells">
							&nbsp;
						</td>
						<td id="tdComments030202" class="CommentCells">
							&nbsp;
						</td>
						<td id="tdComments030203" class="CommentCells">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td class="GridHdrCells">
							Hamden
						</td>
						<td style="border:none;">
							&nbsp;
						</td>
						<td style="border:none;">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td id="tdComments030301" class="CommentCells">
							&nbsp;
						</td>
						<td style="border:none;">
							&nbsp;
						</td>
						<td style="border:none;">
							&nbsp;
						</td>
					</tr>
					</table>
				</div>

				<div id="divSAppalachianOperations" class="MainDisplayDIVs" style="display:none;">
					<div id="divSAppOpsHdr" style="font-size:14pt;font-weight:bold;color:blue;width:100%;">
						South Appalachian Operations
					</div>
					<table id="tblSAppalachianOperations" style="padding:2px;border-spacing:0px;border-collapse:collapse;margin: auto auto;">
					<tr>
						<td class="GridHdrCells">
							Buena Vista
						</td>
						<td class="GridHdrCells">
							Maury River
						</td>
						<td class="GridHdrCells">
							Marion
						</td>
					</tr>
					<tr>
						<td id="tdComments040101" class="CommentCells">
							<textarea id="txaComments040101" style="border:none;width:360px;height:200px;overflow:scroll;"></textarea>
						</td>
						<td id="tdComments040102" class="CommentCells">
							<textarea id="txaComments040102" style="border:none;width:360px;height:200px;overflow:scroll;"></textarea>
						</td>
						<td id="tdComments040103" class="CommentCells">
							<textarea id="txaComments040103" style="border:none;width:360px;height:200px;overflow:scroll;"></textarea>
						</td>
					</tr>
					<tr>
						<td class="GridHdrCells">
							Hacker Valley
						</td>
						<td class="GridHdrCells">
							Dailey
						</td>
						<td class="GridHdrCells">
							Marlinton
						</td>
					</tr>
					<tr>
						<td id="tdComments040201" class="CommentCells">
							&nbsp;
						</td>
						<td id="tdComments040202" class="CommentCells">
							&nbsp;
						</td>
						<td id="tdComments040203" class="CommentCells">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td class="GridHdrCells">
							Mill Creek
						</td>
						<td style="border:none;">
							&nbsp;
						</td>
						<td style="border:none;">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td id="tdComments040301" class="CommentCells">
							&nbsp;
						</td>
						<td style="border:none;">
							&nbsp;
						</td>
						<td style="border:none;">
							&nbsp;
						</td>
					</tr>
					</table>
				</div>

				<div id="divOtherOperations" class="MainDisplayDIVs" style="display:none;">
					<div id="divOtherOpsHdr" style="font-size:14pt;font-weight:bold;color:blue;width:100%;">
						Other Operations
					</div>
					<table id="tblOtherOperations" style="padding:2px;border-spacing:0px;border-collapse:collapse;margin: auto auto;">
					<tr>
						<td class="GridHdrCells">
							Tuscumbia
						</td>
						<td class="GridHdrCells">
							Elkhart
						</td>
						<td class="GridHdrCells">
							Exotics / Currie
						</td>
					</tr>
					<tr>
						<td id="tdComments050101" class="CommentCells">
							&nbsp;
						</td>
						<td id="tdComments050102" class="CommentCells">
							&nbsp;
						</td>
						<td id="tdComments050103" class="CommentCells">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td class="GridHdrCells">
							Potomac
						</td>
						<td style="border:none;">
							&nbsp;
						</td>
						<td style="border:none;">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td id="tdComments050201" class="CommentCells">
							&nbsp;
						</td>
						<td style="border:none;">
							&nbsp;
						</td>
						<td style="border:none;">
							&nbsp;
						</td>
					</tr>
					</table>
				</div>

				<div id="divOtherContent" class="MainDisplayDIVs" style="display:none;">
					&nbsp;
				</div>

			</div>

			<div id="divPAGEFOOTER" style="width:99%;margin-left:10px;margin-bottom:10px;display:block;">
				<div id="divFooterConfMsg" style="width:100%;text-align:right;font-weight:bold;color:darkred;font-family:Tahoma;font-size:13pt;margin-top:6px;margin-right:20px;">
					CONFIDENTIAL ‐Internal Audience Only <br />
				</div>
				</div>
				<div id="divFooterStatusMsg" style="width:100%;">
					<label id="lblStatusMsg" style="color:maroon;font-size:12pt;font-weight:bold;"></label>
				</div>
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
