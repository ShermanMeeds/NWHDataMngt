<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebCalendar.aspx.cs" Inherits="DataMngt.page.WebCalendar1" %>
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

	<script type="text/javascript" src="../Scripts/jquery-2.1.0.min.js"></script>
	<script type="text/javascript" src="../Scripts/jqueryAJAXTransport.js"></script>
	<script type="text/javascript" src="../Scripts/Modernizr-2.6.2.js"></script>
	<script type="text/javascript" src="../Scripts/jquery-ui.1.12.1.min.js"></script>
	<script type="text/javascript" src="../Scripts/AJAXSupport.js?v=<%=BuildNbr %>"></script>
	<script type="text/javascript" src="../Scripts/DateMngt.js?v=<%=BuildNbr %>"></script>
	<script type="text/javascript" src="../Scripts/TxtUtilities.js?v=<%=BuildNbr %>"></script>
	<script type="text/javascript" src="../Scripts/GenUtils.js?v=<%=BuildNbr %>"></script>
	<script type="text/javascript" src="../Scripts/Pagination.js?v=<%=BuildNbr %>"></script>
	<script type="text/javascript" src="../Scripts/Dialogs.js?v=<%=BuildNbr %>"></script>
	<script type="text/javascript" src="../Scripts/DataGrids.js?v=<%=BuildNbr %>"></script>
	<script type="text/javascript" src="../Scripts/WebControls.js?v=<%=BuildNbr %>"></script>
	<script type="text/javascript" src="../Scripts/NbrFunctions.js?v=<%=BuildNbr %>"></script>
  <script type="text/javascript" src="jquery-2.1.0-vsdoc.js"></script>

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
		var jbtnQuickAccessPage;
		var jbViewOnly = true;
		var jdivCalGrid;
		var jiByID = 0;
		var jiPageID = 54;
		var jlblWebCalHdrtop;
		var jlblWebCalHdrtop2;
		var jlStatusMsg;
		var joCalGridHead;
		var joCalGridBody;
		var jsBrowserType = '';
		var jsErrorMsg = '';
		var jsLocationCode = '';
		var jselCalendarType;
		var jselColorT;
		var jselGradeT;
		var jselLengthT;
		var jselLocationT;
		var jselMillingT;
		var jselMonthF;
		var jselNoPrintT;
		var jselRegionT;
		var jselShiftF;
		var jselSortT;
		var jselSpeciesT;
		var jselThickT;
		var jselYearF;
		var jsPageVersion = '';
		var jsPageVersDate = '';
		var jspnQuickAccessBtn;
		var jtblCalGrid;
		var jtCustCode;
		var jtProductCodeF;

		var counter = 0;
		var MyCalendarData;
		var MyCalMonthData;
		var MyCodeListData;
		var MyLocations;

		var counter = 0;
		var DayNamesNV = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

		$(window).load(function () {
			// set global default values
			//alert('Ready starting');
			jiPageID = 54;
			jsPageVersion = '1.0.0';
			jsPageVersDate = '9/8/2017';
			jbViewOnly = true;
			// Load global page-loaded variables
			jiByID = jigEmpID;
			jsBrowserType = jsgBrowserType;
			//alert(jsBrowserType);
			if (jsgAr > 4 || jgA === 1) {
				jbA = true;
				//alert('Admin');
			}
			jsLocationCode = jsgLoc;
			jsErrorMsg = jsgError;

			//alert('setting alive');
			updateClockNV();
			KeepSessionAlive();

			//alert('setting pointers');
			jbtnQuickAccessPage = document.getElementById('btnQuickAccessPage');
			jdivCalGrid = document.getElementById('divCalGrid');
			jlblWebCalHdrtop = document.getElementById('lblWebCalHdrtop');
			jlblWebCalHdrtop2 = document.getElementById('lblWebCalHdrtop2');
			jlStatusMsg = document.getElementById('lblStatusMsg');
			joCalGridBody = document.getElementById('tblCalGridBody');
			joCalGridHead = document.getElementById('tblCalGridHead');
			jtblCalGrid = document.getElementById('tblCalGrid');

			jselCalendarType = document.getElementById('selCalendarType');
			jselColorT = document.getElementById('selColorT');
			jselGradeT = document.getElementById('selGradeT');
			jselLengthT = document.getElementById('selLengthT');
			jselLocationT = document.getElementById('selLocationT');
			jselMillingT = document.getElementById('selMillingT');
			jselMonthF = document.getElementById('selMonthF');
			jselNoPrintT = document.getElementById('selNoPrintT');
			jselRegionT = document.getElementById('selRegionT');
			jselShiftF = document.getElementById('selShiftF');
			jselSortT = document.getElementById('selSortT');
			jselSpeciesT = document.getElementById('selSpeciesT');
			jselThickT = document.getElementById('selThickT');
			jselYearF = document.getElementById('selYearF');
			jspnQuickAccessBtn = document.getElementById('spnQuickAccessBtn');
			jtCustCode = document.getElementById('txtCustCode');
			jtProductCodeF = document.getElementById('txtProductCodeF');

			//$('#form1').on("submit", function (evt) {
			//	evt.preventDefault();
			//});

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
			//alert('initiation - Thickness');
			PopulateThicknessList();
			//alert('Species');
			PopulateSpeciesList();
			//alert('Grade');
			PopulateGradeList();
			//alert('Locations');
			PopulateUserLocations();
			//alert('Color');
			PopulateColorList();
			//alert('Len');
			PopulateLengthList();
			//alert('Sort');
			PopulateSortList();
			//alert('Milling');
			PopulateMillingList();
			//alert('NoPrint');
			PopulateNoPrintList();
			//alert('Populate Locs');
			PopulateLocationList();
			var today = new Date();
			var mo = today.getMonth();
			var yr = today.getFullYear();
			//alert(mo + '/' + yr);
			//jselMonthF.value = (mo+1).toString();
			//jselYearF.value = yr.toString();
			//var mo = parseInt(jselMonthF.value, 10);
			//var yr = parseInt(jselYearF.value, 10);
			//alert('N1');
			GetMoDateDate(yr, mo);
			jselMonthF.value = (mo + 1).toString();
			//GetMonthDateData(yr, mo);
			//alert('N2');
			LoadDayNames(yr, mo);
			document.getElementById('lblPageIDInFooter').innerHTML = 'Page ID: ' + jiPageID.toString();
			return false;
		}

		// **************************** AJAX FUNCTIONS *********************************

		function GetCalendarData() {
			var ctype = parseInt(jselCalendarType.value, 10);
			if (ctype > 0) {
				var yr = parseInt(jselYearF.value, 10);
				var mo = parseInt(jselMonthF.value, 10);
				var ctype = jselCalendarType.value;
				var pcode = jtProductCodeF.value;
				var reg = jselRegionT.value;
				var shift = jselShiftF.value;
				var loc = jselLocationT.value;
				var spec = jselSpeciesT.value;
				var grade = jselGradeT.value;
				var thick = jselThickT.value;
				var len = jselLengthT.value;
				var color = jselColorT.value;
				var sort = jselSortT.value;
				var milling = jselMillingT.value;
				var noprint = jselNoPrintT.value;
				var cust = jtCustCode.value;
				var showloc = 0;
				if (jbA === true) { showloc = 1; }
				var url = "../shared/AjaxServices.asmx/GetCalendarData";
				var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','Yr':'" + yr.toString() + "','Mo':'" + mo.toString() + "','CalType':'" + ctype + "','ProdCode':'" + pcode + "','Region':'" + reg + "',";
				MyData = MyData + "'LocCode':'" + loc + "','Species':'" + spec + "','Grade':'" + grade + "','Thick':'" + thick + "','Len':'" + len + "','Color':'" + color + "','Sort':'" + sort + "','Milling':'" + milling + "',";
				MyData = MyData + "'NoPrint':'" + noprint + "','Cust':'" + cust + "','Shift':'" + shift + "','ShowLoc':'" + showloc.toString() + "','Active':'1','ByID':'" + jiByID.toString() + "'}";
				//alert(MyData);
				getJSONReturnDataAs(url, MyData, function (response)
				{ MyCalendarData = response; });
			}
			else {
				alert('No calendar type has been selected');
			}
			return false;
		}				 

		function GetProdCodeList(ctype) {
			var url = "../shared/AJAXServices.asmx/SelectProductCodeList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','CodeType':'" + ctype + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCodeListData = response; });
			return false;
		}

		function GetLocationList() {
			var url = "../shared/AJAXServices.asmx/GetLocationList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','LocCode':'','LocType':'MILL','Country':'US','City':'','Class':'0','Sort':'0','Active':'2','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyLocations = response; });
			return false;
		}	

		function GetShipmentData(snbr, loc, vndr, sort) {
			//alert('getting shipment data');
			var reg = jselRegionT.value;
			var thick = jselThickT.value;
			var spec = jselSpeciesT.value;
			var grade = jselGradeT.value;
			var len = jselLengthT.value;
			//alert('1');
			var color = jselColorT.value;
			var sort = jselSortT.value;
			var milling = jselMillingT.value;
			var noprint = jselNoPrintT.value;
			//alert('2');
			var yr = parseInt(jselYearF.value, 10);
			var mo = parseInt(jselMonthF.value, 10);
			var smo = mo.toString();
			if (smo.length < 2) {smo = '0' + smo;}
			var bdt = yr.toString() + '-' + smo + '-01';
			var sday = DaysOfMonthDm(yr, mo-1).toString();
			if (sday.length < 2) { sday = '0' + mo; }
			var edt = yr.toString() + '-' + smo + '-' + sday;
			//alert('mydata');
			var url = "../shared/GridSupportServices.asmx/SelectLTShippingList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ShipNbr':'" + snbr.toString() + "','Region':'" + reg + "','Loc':'" + loc + "','Thickness':'" + thick + "','Species':'" + spec + "',";
			MyData = MyData + "'Grade':'" + grade + "','Len':'" + len + "','Color':'" + color + "','fSort':'" + sort + "','Milling':'" + milling + "','NoPrint':'" + noprint + "','Vendor':'" + vndr.toString() + "',";
			MyData = MyData + "'sBDt':'" + bdt + "','sEDt':'" + edt + "','Sort':'" + sort.toString() + "','PgNbr':'0','PgSize':'999','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCalendarData = response; });
			return false;
		} 

		function GetUserLocations() {
			var url = "../shared/AJAXServices.asmx/GetUserLocations";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyLocations = response; });
			return false;
		}

		function GetMonthDateData(yr, mo) {
			var url = "../shared/AjaxServices.asmx/GetCalendarDatesForMonth";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','Yr':'" + yr.toString() + "','Mo':'" + mo.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCalMonthData = response; });
			return false;
		}

		function GetMoDateDate(yr, mo) {
			try {
				var url = "../shared/AjaxServices.asmx/GetCalDatesForMonth";
				var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','Yr':'" + yr.toString() + "','Mo':'" + mo.toString() + "','ByID':'" + jiByID.toString() + "'}";
				//alert(MyData);
				getJSONReturnDataAs(url, MyData, function (response)
				{ MyCalMonthData = response; });
			}
			catch (ex) {
				// do nothing
			}
			return false;
		}

		// **************************** POPULATE OBJECTS **********************************

		function PopulateCalendar() {
			jlStatusMsg.innerHTML = '';
			var mo = parseInt(jselMonthF.value, 10);
			var yr = parseInt(jselYearF.value, 10);
			var daysinMo = DaysOfMonthDm(yr, mo-1);
			var tdate = new Date(yr, (mo - 1), 1);
			jdivCalGrid.innerHTML = '';
			// Fields: EventDate yyyy-mm-dd string format (in date order), EventTitle, EventToolTip
			if (MyCalendarData !== undefined && MyCalendarData !== null) {
				//alert(tdate);
				jgHighlightColor = '#FFFFAA';
				var tbl = createCalendarGridDg('divCalGrid', tdate, false, '2px solid #CCCCCC', '0px', '1px', 'TableMain', 'tdCalCol', '2px solid #CCCCCC', 'StdTableCell', '#FFFFFF', '#000000', MyCalendarData, '2px solid #CCCCCC', '#A3AFD0', 'white', 'yellow', 'darkblue', '1px', '100%', '120px', true, true, true, true, false, '#BFBFBF', 'Arial Narrow', '9pt');
				//createCalendarCellDg(row, tcell, prefx, suffx, colspn, showOutDates, brdrL, brdrR, brdrT, brdrB, bColor, fColor, isBold, noOverflw, ht, wdth, content, ttip)
				jdivCalGrid.appendChild(tbl);
				if (MyCalendarData.length === 0) {
					jlStatusMsg.innerHTML = 'No Calendar items meet your criteria.';
				}
			}
			else {
				jlStatusMsg.innerHTML = 'No Calendar items were returned because of an error.';
			}
			return false;
		}

		function PopulateColorList() {
			GetProdCodeList('Color');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selColorT', 1);
				fillDropDownListGu(MyCodeListData, jselColorT, 0, 'CodeDescription', 'CatCode');
			}
			return false;
		}

		function PopulateGradeList() {
			GetProdCodeList('Grade');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selGradeT', 1);
				fillDropDownListGu(MyCodeListData, jselGradeT, 0, 'CodeDescription', 'CatCode');
			}
			return false;
		}

		function PopulateLengthList() {
			GetProdCodeList('Length');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selLengthT', 1);
				fillDropDownListGu(MyCodeListData, jselLengthT, 0, 'CodeDescription', 'CatCode');
			}
			return false;
		}

		function PopulateLocationList() {
			if (jbA === true) {
				GetLocationList();
				//alert('All Locations');
			}
			else {
				GetUserLocations();
			}
			if (MyLocations !== undefined && MyLocations !== null) {
				//alert('Locations: ' + MyLocations.length);
				ClearDDLOptionsGu('selLocationT', 1);
				fillDropDownListGu(MyLocations, jselLocationT, 0, 'Name', 'loc');
			}
			return false;
		}

		function PopulateMillingList() {
			GetProdCodeList('Milling');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selMillingT', 1);
				fillDropDownListGu(MyCodeListData, jselMillingT, 0, 'CodeDescription', 'CatCode');
			}
			return false;
		}

		function PopulateNoPrintList() {
			GetProdCodeList('NoPrint');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selNoPrintT', 1);
				fillDropDownListGu(MyCodeListData, jselNoPrintT, 0, 'CodeDescription', 'CatCode');
			}
			return false;
		}

		function PopulateSpeciesList() {
			GetProdCodeList('Species');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selSpeciesT', 1);
				fillDropDownListGu(MyCodeListData, jselSpeciesT, 0, 'CodeDescription', 'CatCode');
			}
			return false;
		}

		function PopulateSortList() {
			GetProdCodeList('Sort');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selSortT', 1);
				fillDropDownListGu(MyCodeListData, jselSortT, 0, 'CodeDescription', 'CatCode');
			}
			return false;
		}

		function PopulateThicknessList() {
			GetProdCodeList('Thickness');
			//alert('got codes!');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				//alert('here');
				ClearDDLOptionsGu('selThickT', 1);
				fillDropDownListGu(MyCodeListData, jselThickT, 0, 'CodeDescription', 'CatCode');
			}
			return false;
		}

		function PopulateUserLocations() {
			if (jgA === true) {
				GetLocationList();
			}
			else {
				GetUserLocations();
			}
			if (MyLocations !== undefined && MyLocations !== null) {
				ClearDDLOptionsGu('selLocationT', 1);
				fillDropDownListGu(MyLocations, jselLocationT, 0, 'CodeDescription', 'CatCode');
			}
			return false;
		}

		// **************************** BACKGROUND FUNCTIONS *********************************

		// loads holiday names into dayname array for current month
		function LoadDayNames(yr, mo) {
			if (MyCalMonthData !== undefined && MyCalMonthData !== null) {
				for (var i = 0; i < MyCalMonthData.length; i++) {
					if (parseInt(MyCalMonthData[i]['HolidayFlag'], 10) === 1) {
						jsDGDayNames[i] = MyCalMonthData[i]['HolidayName'].toString();
					}
					else {
						jsDGDayNames[i] = '';
					}
				}
			}
			else {
				for (var i = 0; i < 31; i++) {
					jsDGDayNames[i] = '';
				}
			}
			return false;
		}

		// **************************** DIALOG BOXs *********************************

		// ************************** Security *******************************

		// ************************** UI *******************************

		function ChangeCalendarType(val) {
			switch (val) {
				case '0':
					jspnQuickAccessBtn.style.display = 'none';
					break;
				case '1':
					jspnQuickAccessBtn.style.display = 'inline';
					jbtnQuickAccessPage.innerHTML = 'Forecast';
					break;
				case '2':
					break;
				default:
					break;
			}
		}

		function SetYearMonthData(val, typ) {
			try {
				var yr = parseInt(jselYearF.value, 10);
				var mo = parseInt(jselMonthF.value, 10);
				GetMoDateDate(yr, mo);
				LoadDayNames(yr, mo);
			}
			catch (ex) {
				alert(ex.message);
			}
			return false;
		}

		function RefreshCalendarData() {
			var ctype = parseInt(jselCalendarType.value, 10);
			switch (ctype) {
				case 0:
					break;
				case 1:
					GetCalendarData();
					break;
				case 2:
					//alert('getting shipments');
					GetShipmentData(0, '', 0, 0);
					break;
				default:
					break;
			}
			if (ctype > 0) {
				//alert('populating calendar');
				PopulateCalendar();
			}
			else {
				alert('No calendar type has been selected');
			}
			return false;
		}

		function EncodeItemData(dat) {
			if (dat !== undefined && dat !== null) {
				dat = dat.replace(/\'/g, '');
				dat = dat.replace(/\"/g, '&#34;');
				dat = dat.replace(/\=/g, '&#61;');
				dat = dat.replace(/\+/g, '&#43;');
				dat = dat.replace(/\%/g, '&#37;');
				dat = dat.replace(/\[/g, '&#91;');
				dat = dat.replace(/\]/g, '&#93;');
				dat = dat.replace(/\:/g, '&#58;');
				dat = dat.replace(/\</g, '&#60;');
				dat = dat.replace(/\>/g, '&#62;');
				dat = dat.replace(/\//g, '&#47;');
				dat = dat.replace(/\\/g, '&#92;');
				return dat;
			}
			else {
				return '';
			}
		}

		function DecodeItemData(dat) {
			if (dat !== undefined && dat !== null) {
				dat = dat.replace(/\'/g, '');
				dat = dat.replace('&#34;', '"');
				dat = dat.replace('&#61;', '=');
				dat = dat.replace('&#43;', '+');
				dat = dat.replace('&#37;', '%');
				dat = dat.replace('&#91;', '[');
				dat = dat.replace('&#93;', ']');
				dat = dat.replace('&#58;', ':');
				dat = dat.replace('&#60;', '<');
				dat = dat.replace('&#62;', '>');
				dat = dat.replace('&#47;', '\/');
				dat = dat.replace('&#92;', '\\');
				dat = dat.replace('&amp;', '&');
				return dat;
			}
			else {
				return '';
			}
		}

		function GotoQuickAccessPage() {
			document.location.href = '../prod/ForecastTool.aspx';
			return false;
		}

	</script>

  <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />

</head>
<body>
	<img id="imgSessionKeepAlive" width="1" height="1" style="display:none;" src="../Images/clearpixel.gif" />
  <form id="form1" runat="server">
		<asp:ScriptManager runat="server"></asp:ScriptManager>
		<asp:HiddenField ID="hfPageID" runat="server" Value="54" />

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

			<div id="divPAGEHEADER" style="width:99%;margin-bottom:10px;margin-left:10px;">
				<div id="divCalendarTitle" style="width:100%;">
					<label id="lblWebCalHdrTitle" class="LabelGridHdrLarger">NWH Web Calendar</label>
				</div>
				<div id="divCalFilters" style="width:100%;text-align:center;">
					<table style="padding:1px;border-spacing:0px;margin:auto auto;"	>
					<tr>
						<td>&nbsp;</td>
						<td style="text-align:right;">
							<span style="font-weight:bold;color:maroon;">Calendar&nbsp;Type:</span>&nbsp;
						</td>
						<td style="text-align:left;">
							<select id="selCalendarType" onchange="javascript:ChangeCalendarType(this.value);return false;" >
								<option value="0" Selected="selected">None Selected</option>
								<option value="1">Forecast</option>
								<option value="2">Shipments</option>
							</select>&nbsp;&nbsp;
							<span id="spnQuickAccessBtn" style="display:none;">
								<button id="btnQuickAccessPage" onclick="javascript:GotoQuickAccessPage(); return false;" class="button blue-gradient glossy" style="width:140px;">Quick Access</button>
							</span>
						</td>
						<td>&nbsp;</td>
						<td style="text-align:right;">
							<span style="font-weight:bold;color:blue;">Month:</span>&nbsp;
						</td>
						<td style="text-align:left;">
							<select id="selYearF" onchange="javascript:SetYearMonthData(this.value, 0);return false;">
								<option value="2017" selected="selected">2017</option>
								<option value="2018">2018</option>
								<option value="2019">2019</option>
								<option value="2020">2020</option>
								<option value="2021">2021</option>
								<option value="2022">2022</option>
								<option value="2023">2023</option>
								<option value="2024">2024</option>
								<option value="2025">2025</option>
							</select>&nbsp;
							<select id="selMonthF" onchange="javascript:SetYearMonthData(this.value, 1);return false;">
								<option value="1" selected="selected">Jan</option>
								<option value="2">Feb</option>
								<option value="3">Mar</option>
								<option value="4">Apr</option>
								<option value="5">May</option>
								<option value="6">Jun</option>
								<option value="7">Jul</option>
								<option value="8">Aug</option>
								<option value="9">Sep</option>
								<option value="10">Oct</option>
								<option value="11">Nov</option>
								<option value="12">Dec</option>
							</select>
						</td>
						<td>&nbsp;</td>
						<td style="text-align:right;">
							<span style="font-weight:bold;color:blue;">Product&nbsp;Code:</span>&nbsp;
						</td>
						<td style="text-align:left;">
							<input type="text" id="txtProductCodeF" style="width:110px;" />
						</td>
						<td>&nbsp;</td>
						<td style="text-align:right;">
							<span style="font-weight:bold;color:blue;">Shift:</span>&nbsp;
						</td>
						<td style="text-align:left;">
							<select id="selShiftF">
								<option value="0" selected="selected">ALL</option>
								<option value="1">Day</option>
								<option value="2">Night</option>
								<option value="3">Swing</option>
							</select>
						</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td colspan="13">
								<table style="padding:0;border-spacing:0px;">
								<tr>
									<th class="TableHdrCell">
										Region
									</th>
									<th class="TableHdrCell">
										Location
									</th>
									<th class="TableHdrCell">
										Thickness
									</th>
									<th class="TableHdrCell">
										Species
									</th>
									<th class="TableHdrCell">
										Grade
									</th>
									<th class="TableHdrCell">
										Length
									</th>
									<th class="TableHdrCell">
										Color
									</th>
									<th class="TableHdrCell">
										Sort
									</th>
									<th class="TableHdrCell">
										Milling
									</th>
									<th class="TableHdrCell">
										NoPrint
									</th>
								</tr>
								<tr>
									<td class="StdTableCell">
										<select id="selRegionT" multiple>
											<option value="0" Selected="Selected">ALL</option>
											<option value="APP">Appalachian</option>
											<option value="GLA">Glacial</option>
											<option value="WEST">West</option>
										</select>
									</td>
									<td class="StdTableCell">
										<select id="selLocationT" multiple>
											<option value="0" Selected="Selected">ALL</option>
										</select>
									</td>
									<td class="StdTableCell">
										<select id="selThickT" multiple>
											<option value="0" Selected="Selected">ALL</option>
										</select>
									</td>
									<td class="StdTableCell">
										<select id="selSpeciesT" multiple>
											<option value="0" Selected="Selected">ALL</option>
										</select>
									</td>
									<td class="StdTableCell">
										<select id="selGradeT" multiple>
											<option value="0" Selected="Selected">ALL</option>
										</select>
									</td>
									<td class="StdTableCell">
										<select id="selLengthT" multiple>
											<option value="0" Selected="Selected">ALL</option>
										</select>
									</td>
									<td class="StdTableCell">
										<select id="selColorT" multiple>
											<option value="0" Selected="Selected">ALL</option>
										</select>
									</td>
									<td class="StdTableCell">
										<select id="selSortT" multiple>
											<option value="0" Selected="Selected">ALL</option>
										</select>
									</td>
									<td class="StdTableCell">
										<select id="selMillingT" multiple>
											<option value="0" Selected="Selected">ALL</option>
										</select>
									</td>
									<td class="StdTableCell">
										<select id="selNoPrintT" multiple>
											<option value="0" Selected="Selected">ALL</option>
										</select>
									</td>
								</tr>
								</table>
						</td>
					</tr>
					<tr id="trExtraLine" style="display:none;">
						<td colspan="13">
							Customer:&nbsp;<input type="text" id="txtCustCode" style="width:120px;" />
						</td>
					</tr>
					<tr>
						<td colspan="13">
							<button id="btnRefreshCalData" class="button blue-gradient glossy" onclick="javascript:RefreshCalendarData();return false;" style="width:300px;">Display Calendar Data</button>
						</td>
					</tr>
					</table>
				</div>
		
			</div>

			<div id="divPAGEMAIN" style="width:99%;margin-bottom:10px;margin-left:10px;">

				<div id="divCalendarGrid" style="width:100%;">
					<div id="divCalGridHdr" style="width:100%;text-align:center;">
						<label id="lblWebCalHdrtop" class="LabelGridHdrStd"></label><br />
						<label id="lblWebCalHdrtop2" class="SmallTextBlock"></label>
					</div>
					<div id="divCalGrid" style="width:100%;">
						&nbsp;
					</div>
				</div>

				<div id="divCalendarSummary" style="width:100%;display:none;">
					<table id="tblCalendarSummary" style="padding:1px;border-spacing:0px;">
					<tbody id="tblCalendarSumBody">

					</tbody>
					</table>
				</div>

			</div>

			<div id="divPAGEFOOTER" style="width:99%;margin-left:10px;">
				<div id="divStatusMsg" style="width:100%;">
					<label id="lblStatusMsg" style="color:maroon;font-weight:bold;"></label>
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
