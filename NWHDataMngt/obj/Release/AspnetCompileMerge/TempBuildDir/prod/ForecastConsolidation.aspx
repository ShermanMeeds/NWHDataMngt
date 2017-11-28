<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForecastConsolidation.aspx.cs" Inherits="DataMngt.prod.ForecastConsolidation1" EnableSessionState="false" %>
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
		var jbShow0s = false;
		var jbShowWeekends = false;
		var jbtnQuickAccessPage;
		var jbViewOnly = true;
		var jchkNoEmptyProds;
		var jchkShowZeros;
		var jchkShowWeekends;
		var jdivDataGrid;
		var jdToday = new Date();
		var jiAR = 0;
		var jiActionStatusCode = '';
		var jiActionStatusID = 0;
		var jiActionStatusMsg = '';
		var jiApprovalID = 0;
		var jiByID = 0;
		var jiDateScope = 0;
		var jiForecastUser = 0;
		var jiNbrCols = 0;
		var jiNbrPages = 0;
		var jiNbrRows = 0;
		var jiPageID = 55;
		var jiPageNbr = 0;
		var jiPageSize = 20;
		var jiTotalRows = 0;
		var jiUserID = 0;
		var jiViewType = 0;
		var jlColSettingStatus;
		var jlPageStatus;
		var jlStatusMsg;
		var jlWeekNbr;
		var jsBrowserType = '';
		var jsCurrentTime = '';
		var jselColorMF;
		var jselGradeMF;
		var jselLengthMF;
		var jselLocationMF;
		var jselMillingMF;
		var jselNoPrintMF;
		var jselPageSize;
		var jselProductMF;
		var jselQueryList;
		var jselRegionMF;
		var jselSeasoningMF;
		var jselShowScopeF;
		var jselSortMF;
		var jselSpeciesMF;
		var jselThickMF;
		var jselViewType;
		var jsErrorMsg = '';
		var jsLastAJAXCall = '';
		var jsLocationCode = '';
		var jsPageVersion = '';
		var jsPageVersDate = '';
		var jspnTargetDateH;
		var jsRegionCode = '';
		var jsStartDate = '';
		var jsToday = '';
		var jtblForecastConsolidation;
		var jtQueryTitle;
		var jtTargetDateH;

		var jaColTotals = createArrayInitGu(35, 1);
		var jaColVisible = createArrayInitGu(40, 1);

		var MyCodeListData;
		var MyColumnSettings;
		var MyConsolidationData;
		var MyLocations;
		var MyProductList;
		var MyProductListMini;
		var MyQueryData;
		var MyQueryList;
		var MyReturn;
		var MyWeeksData;

		var counter = 0;
		var DayNamesNV = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

		$(document).ready(function () {
			jsToday = getMyDateTimeStringDm(jdToday, 18);
			jsCurrentTime = getMyDateTimeStringDm(jdToday, 7);
			//alert(jdToday + '/' + jsToday + '/' + jsCurrentTime);
			updateClockNV();
			KeepSessionAlive();

			// set global default values
			//alert('Ready starting');
			jiPageID = 55;
			jsPageVersion = '1.0.0';
			jsPageVersDate = '5/15/2017';
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
			jsLocationCode = jsgLoc;
			jiForecastUser = jigFV;
			//alert(jiForecastUser + '/' + jigFV);
			//alert('loaded seed values');

			jchkNoEmptyProds = document.getElementById('chkNoEmptyProds');
			jchkShowWeekends = document.getElementById('chkShowWeekends');
			jchkShowZeros = document.getElementById('chkShowZeros');
			jdivDataGrid = document.getElementById('divDataGrid');
			jlColSettingStatus = document.getElementById('lblColSettingStatus');
			jlPageStatus = document.getElementById('lblPageStatus');
			jlStatusMsg = document.getElementById('lblStatusMsg');
			jlWeekNbr = document.getElementById('lblWeekNbr');
			jselColorMF = document.getElementById('selColorMF');
			jselGradeMF = document.getElementById('selGradeMF');
			jselLengthMF = document.getElementById('selLengthMF');
			jselLocationMF = document.getElementById('selLocationMF');
			jselMillingMF = document.getElementById('selMillingMF');
			jselNoPrintMF = document.getElementById('selNoPrintMF');
			jselPageSize = document.getElementById('selPageSize');
			jselProductMF = document.getElementById('selProductMF');
			jselQueryList = document.getElementById('selQueryList');
			jselRegionMF = document.getElementById('selRegionMF');
			jselSeasoningMF = document.getElementById('selSeasoningMF');
			jselShowScopeF = document.getElementById('selShowScopeF');
			jselSortMF = document.getElementById('selSortMF');
			jselSpeciesMF = document.getElementById('selSpeciesMF');
			jselThickMF = document.getElementById('selThickMF');
			jselViewType = document.getElementById('selViewType');
			jspnTargetDateH = document.getElementById('spnTargetDateH');
			jtblForecastConsolidation = document.getElementById('tblForecastConsolidation');
			jtQueryTitle = document.getElementById('txtQueryTitle');
			jtTargetDateH = document.getElementById('txtTargetDateH');

			jsErrorMsg = jsgError;

			createDatePickerOnTextWc('txtTargetDateH', null, null, 0, 3, 'show', 11);

			//alert('About to initiate');
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
			if (jbA === true || jiForecastUser === 1) {
				document.getElementById('btnGotoForecast').style.display = 'inline';
				//alert('visible');
			}
			var d = new Date();
			jiNbrRows = 0;
			jbShowCurrentWeek = true;
			jbNoEmptyProds = false;
			FillGridCalDates();
			//alert('initiation 0');
			GetColumnSettings();
			ShowHideColumns();
			//alert('initiation 1');
			PopulateThicknessList();
			PopulateSpeciesList();
			PopulateGradeList();
			//alert('initiation 2');
			PopulateColorList();
			PopulateLengthList();
			PopulateSortList();
			//alert('initiation 3');
			PopulateMillingList();
			PopulateNoPrintList();
			PopulateLocationList();
			//alert('initiation 4');
			PopulateProductList();
			PopulateSeasoningList();
			jiPageSize = 20;
			jiPgSizePj[0] = 20;
			jiPgNbrPj[0] = 0;
			jiNbrPagesPj[0] = 0;
			jiNbrPages = 0;
			jsRegionCode = '0';
			jsLocationCode = '0';
			jtTargetDateH.value = '';
			//alert('Initiated');
			EstablishMainPgElementsPj(1, 0);
			PopulateQueryList();
			// load default query
			jselQueryList.value = '0';
			if (LoadSavedQueryData('DEFAULT')) {
				setDDLSelectedByTextGu('selQueryList', jselQueryList, 'DEFAULT');
			}
			//alert('Done!');
			document.getElementById('lblNbrSeconds').innerHTML = GetNbrSeconds(d).toString() + ' seconds';
			jlPageStatus.innerHTML = 'Page Ready';
			return false;
		}

		// **************************** AJAX FUNCTIONS *********************************

		function DataCall1() {
			jiPageNbr = jiPgNbrPj[0];
			alert('Page ' + jiPageNbr);
			GetConsolidationData();
			PopulateConsolidation();
			return false;
		}

		function GetConsolidationData() {
			var okay = true;
			var reg = jselRegionMF.value;
			var loc = jselLocationMF.value;
			var spec = jselSpeciesMF.value;
			var thick = jselThickMF.value;
			var len = jselLengthMF.value;
			var grade = jselGradeMF.value;
			var len = jselLengthMF.value;
			var color = jselColorMF.value;
			var sort = jselSortMF.value;
			var milling = jselMillingMF.value;
			var noprint = jselNoPrintMF.value;
			var prod = jselProductMF.value;
			var surf = '0'; //jsel
			var seasoning = jselSeasoningMF.value;
			var dt = new Date();
			if (jbShowCurrentWeek === false) {
				dt = dt.addDays(7);
			}

			var tdate = getMyDateStringDm(dt, 0, 0);
			if (jiDateScope === 2) {
				tdate = jtTargetDateH.value;
			}
			var noempties = 0;
			if (jbNoEmptyProds === true) { noempties = 1; }

			var lvl = '';
			for (var i = 0; i < MyColumnSettings.length; i++) {
				if (jaColVisible[i] === 1) {
					//MyColumnSettings[i]['ItemValue'].toString() === '1') {
					lvl = lvl + 'X';
				}
				else {
					lvl = lvl + '0';
				}
			}

			//alert('building MyData');
			if (jiDateScope < 2) {
				var url = "../shared/AjaxServices.asmx/SelectFCConsolidationData";
				var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','DType':'0','Region':'" + reg + "','Loc':'" + loc + "','Prod':'" + prod + "','Species':'" + spec + "','Grade':'" + grade + "','Thickness':'" + thick + "',";
				MyData = MyData + "'Surface':'" + surf + "','Seasoning':'" + seasoning + "','Len':'" + len + "','Color':'" + color + "','Sort':'" + sort + "','Milling':'" + milling + "','NoPrint':'" + noprint + "','Level':'" + lvl + "',";
				MyData = MyData + "'TDate':'" + tdate + "','FuzzyGrade':'','FuzzySort':'','FuzzyProd':'','PgNbr':'" + jiPgNbrPj[0].toString() + "','PgSize':'" + jiPageSize.toString() + "','NoEmpties':'" + noempties.toString() + "',";
				MyData = MyData + "'DataSort':'0','ByID':'" + jiByID.toString() + "'}";
			}
			else {
				var url = "../shared/AjaxServices.asmx/SelectFCConsolidationDataHist";
				var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','DType':'0','Region':'" + reg + "','Loc':'" + loc + "','Prod':'" + prod + "','Species':'" + spec + "','Grade':'" + grade + "','Thickness':'" + thick + "',";
				MyData = MyData + "'Surface':'" + surf + "','Seasoning':'" + seasoning + "','Len':'" + len + "','Color':'" + color + "','Sort':'" + sort + "','Milling':'" + milling + "','NoPrint':'" + noprint + "','Level':'" + lvl + "',";
				MyData = MyData + "'TDate':'" + tdate + "','FuzzyGrade':'','FuzzySort':'','FuzzyProd':'','PgNbr':'" + jiPgNbrPj[0].toString() + "','PgSize':'" + jiPageSize.toString() + "','NoEmpties':'" + noempties.toString() + "',";
				MyData = MyData + "'DataSort':'0','ByID':'" + jiByID.toString() + "'}";
			}

			//alert(MyData);
			jsLastAJAXCall = MyData;
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyConsolidationData = response; });
			// save user tracks every refresh
			UpdateUserTracks();
			return okay;
		}

		function GetProdCodeList(ctype) {
			var url = "../shared/AjaxServices.asmx/SelectProductCodeList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','CodeType':'" + ctype + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCodeListData = response; });
			return false;
		}

		function GetProdCodeListForRegion(ctype) {
			//var region = jselRegionMF.value;
			var url = "../shared/AjaxServices.asmx/SelectProductCodeListForRegion";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','Region':'" + jsRegionCode + "','CodeType':'" + ctype + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCodeListData = response; });
			return false;
		}

		function GetLocationList() {
			//var url = "../shared/AjaxServices.asmx/GetLocationList";
			//var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','LocCode':'','LocType':'MILL','Country':'US','City':'','Class':'0','Sort':'0','Active':'2','ByID':'" + jiByID.toString() + "'}";
			//getJSONReturnDataAs(url, MyData, function (response)
			//{ MyLocations = response; });
			//return false;
			var url = "../shared/AjaxServices.asmx/SelectConsolidationLocationList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','UserID':'" + jiByID.toString() + "','LocCode':'','Region':'" + jsRegionCode + "','LocType':'MILL','Country':'US','City':'','Class':'0','Sort':'0',";
			MyData = MyData + "'Active':'2','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyLocations = response; });
			return false;
		}

		function GetProductList() {
			var region = jselRegionMF.value;
			var loc = jselLocationMF.value;
			var url = "../shared/AjaxServices.asmx/GetForecastProductList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','Loc':'" + loc + "','Region':'" + region + "','ProdCode':'','MixID':'0','Sort':'0','Active':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProductList = response; });
			return false;
		}

		function GetProductListMini() {
			var region = jselRegionMF.value;
			var loc = jselLocationMF.value;
			var url = "../shared/AjaxServices.asmx/GetForecastProductListMini";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','Loc':'" + loc + "','Region':'" + region + "','ProdCode':'','MixID':'0','Sort':'0','Active':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProductListMini = response; });
			return false;
		}

		function GetRegionForLoc(loc) {
			var url = "../shared/AjaxServices.asmx/GetRegionForLocation";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','Loc':'" + loc + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			if (!IsContentsNullUndefEmptyTx(MyReturn, 1)) {
				jsRegionCode = MyReturn[0]['RegionCode'].toString();
			}
			return false;
		}

		function GetUserLocationList() {
			var grp = 'consoldvw';
			if (jbAllLocations === true) { grp = 'consoldv2'; }
			var url = "../shared/AjaxServices.asmx/SelectUserConsolidationLocs";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','Grp':'" + grp + "','iType':'0','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyLocations = response; });
			return false;
		}

		function GetUserQueryList() {
			var url = "../shared/AjaxServices.asmx/SelectUserQueryData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','UserID':'" + jiByID.toString() + "','QueryID':'0','QueryName':'','Sort':'0','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyQueryList = response; });
			return false;
		}

		function GetUserQueryData(nm) {
			var id = jselQueryList.value;
			//var nm = jtQueryTitle.value;
			var url = "../shared/AjaxServices.asmx/SelectUserQueryData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','UserID':'" + jiByID.toString() + "','QueryID':'" + id + "','QueryName':'" + nm + "','Sort':'0','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyQueryData = response; });
			return false;
		}

		function GetWeekDates13() {
			// typ: 0-not current week, 1-current week included
			var typ = 0;
			if (jbShowCurrentWeek === true) { typ = 1; }
			if (jiDateScope === 2) { typ = 3;}
			var url = "../shared/AjaxServices.asmx/Get13WeekDates";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','iType':'" + typ.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyWeeksData = response; });
			if (MyWeeksData !== undefined && MyWeeksData !== null) {
				if (MyWeeksData.length > 0) {
					jsStartDate = MyWeeksData[0]['sStartDate'].toString();
				}
			}
			return false;
		}

		function GetColumnSettings() {
			var url = "../shared/AjaxServices.asmx/SelectUserInterfaceItems";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','UIType':'ConsolCol','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyColumnSettings = response; });
			//alert('column data loaded');
			if (MyColumnSettings !== undefined && MyColumnSettings !== null) {
				if (MyColumnSettings.length > 0) {
					for (var row = 0; row < MyColumnSettings.length; row++) {
						jaColVisible[row] = (MyColumnSettings[row]['ItemValue'].toString() == '1' ? 1 : 0);
					}
				}
			}
			//alert('inital settings set');
			if (jbShowWeekends === false) {
				jaColVisible[19] = 0;
				jaColVisible[20] = 0;
				jaColVisible[26] = 0;
				jaColVisible[27] = 0;
			}
			//alert('weekends set');
			if (jiViewType > 0) {
				switch (jiViewType) {
					case 1:
						for (var r1 = 28; r1 <= 38; r1++) {
							jaColVisible[r1] = 0;
						}
						break;
					case 2:
						for (var r1 = 14; r1 <= 27; r1++) {
							jaColVisible[r1] = 0;
						}
						break;
					default:
						break;
				}
			}
			jiNbrCols = MyColumnSettings.length;
			//alert('columns done');
			return false;
		}

		function SaveColSettingValue(itm, val) {
			var url = "../shared/AjaxServices.asmx/UpdateColumnSetting";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'3', 'UserID':'" + jiByID.toString() + "','UIType':'ConsolCol','Item':'" + itm + "','Val':'" + val + "','Comment':'','Active':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyColumnSettings = response; });
			EvaluateStdDatabaseReturnAs(MyColumnSettings, jlColSettingStatus, 'Database access failed.', 'Change was not made but no error returned.', 'Invalid status returned. Change probably failed.');
			return false;
		}

		function UpdateUserTracks() {
			var stat = '';
			var pt = '';
			var prod = jselProductMF.value;
			var reg = jselRegionMF.value;
			var loc = jselLocationMF.value;
			var spec = jselSpeciesMF.value;
			var thick = jselThickMF.value;
			var grade = jselGradeMF.value;
			var seas = jselSeasoningMF.value;
			var surf = '';
			var wdth = '';
			var len = jselLengthMF.value;
			var color = jselColorMF.value;
			var fsort = jselSortMF.value;
			var milling = jselMillingMF.value;
			var noprint = jselNoPrintMF.value;
			var cust = '';
			var vend = '';
			var suppl = '';
			var showwk = 0;
			var hidecmt = 0;
			var excl0s = 0;
			var inchist = 0;
			var srt = 0;
			var fontsz = '0';
			var icode = '';
			var iname = '';
			var idesc = '';
			var mainid = 0;
			var mgrid = 0;
			var custid = '0';
			var ordid = '0';
			var shipid = '0';
			var otherid = '0';
			var loadid = '0';
			var set1 = 0
			if (jchkShowWeekends.checked === true) { set1 = 1; }
			var set2 = 0;
			var set3 = 0;
			var set4 = 0;
			var set5 = 0;
			var bdt = '';
			var edt = '';
			var tgtdt = '';

			var url = "../shared/Pagination.asmx/UpdateGenUserTracks";
			var MyData = "{'UserID':'" + jiByID.toString() + "','PgID':'" + jiPageID.toString() + "','PgObjID':'0', 'PgNbr':'" + jiPageNbr.toString() + "','PgSize':'" + jiPageSize.toString() + "','StatusCode':'" + stat + "',";
			MyData = MyData + "'ProdType':'" + pt + "','Prod':'" + prod + "','Reg':'" + reg + "','Loc':'" + loc + "','Species':'" + spec + "','Thick':'" + thick + "','Grade':'" + grade + "','Seasoning':'" + seas + "','Surface':'" + surf + "',";
			MyData = MyData + "'Width':'" + wdth + "','Len':'" + len + "','Color':'" + color + "','fSort':'" + fsort + "','Milling':'" + milling + "','NoPrint':'" + noprint + "','Cust':'" + cust + "','Vendor':'" + vend + "',";
			MyData = MyData + "'Supplier':'" + suppl + "','ShowWks':'" + showwk + "','HideComments':'" + hidecmt + "','Excl0s':'" + excl0s + "','IncHist':'" + inchist + "','Sort':'" + srt + "','FontSz':'" + fontsz + "','ItemCode':'" + icode + "',";
			MyData = MyData + "'ItemName':'" + iname + "','ItemDesc':'" + idesc + "','MainID':'" + mainid + "','MgrID':'" + mgrid + "','CustID':'" + custid + "','OrderID':'" + ordid + "','ShipID':'" + shipid + "','OtherID':'" + otherid + "',";
			MyData = MyData + "'LoadID':'" + loadid + "','Setting1':'" + set1.toString() + "','Setting2':'" + set2.toString() + "','Setting3':'" + set3.toString() + "','Setting4':'" + set4.toString() + "','Setting5':'" + set5.toString() + "',";
			MyData = MyData + "'sBeginDt':'','sEndDt':'','sTargetDT':'','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			return false;
		}

		function UpdateUserQuery() {
			var id = 0;
			if (jselQueryList.value === '0') {
				id = 0;
			}
			else {
				id = parseInt(jselQueryList.value, 10);
			}
			var nm = jtQueryTitle.value;
			var ptype = 'HD';
			var pcode = jselProductMF.value;
			var loc = jselLocationMF.value;
			var reg = jselRegionMF.value;
			var thick = jselThickMF.value;
			var spec = jselSpeciesMF.value;
			var grade = jselGradeMF.value;
			var seas = jselSeasoningMF.value;
			var surf = '';
			var stat = '';
			var wdth = '';
			var len = jselLengthMF.value;
			var color = jselColorMF.value;
			var fsort = jselSortMF.value;
			var mill = jselMillingMF.value;
			var nop = jselNoPrintMF.value;
			var itype = jselViewType.value;
			var currwk = jselShowScopeF.value;
			var weeknd = 0;
			if (jchkShowWeekends.checked === true) { weeknd = 1; }
			var zeros = 0;
			if (jchkShowZeros.checked === true) { zeros = 1; }
			var set0 = 0;
			var set4 = 0;
			if (jchkNoEmptyProds.checked === true) { set4 = 1;}
			var set5 = 0;
			var set6 = 0;
			var set7 = 0;
			var ordid = 0;
			var shipid = 0;
			var loadid = 0;
			var cust = '';
			var vend = '';
			var supp = '';
			var mgrid = 0;
			var sort = 0;
			var itemsppg = jselPageSize.value;
			var icd = '';
			var inm = '';
			var idesc = '';
			var nbr = 0;
			var c1 = '';
			var c2 = '';
			var id1 = 0;
			var id2 = 0;
			var cmt = '';
			var act = 2;

			var url = "../shared/AjaxServices.asmx/UpdateUserQuery";
			var MyData = "{'UserID':'" + jiByID.toString() + "','QueryID':'" + id.toString() + "','QueryName':'" + nm + "','PgID':'" + jiPageID.toString() + "','PgObjID':'1','PgNbr':'" + jiPageNbr.toString() + "','PgSize':'" + itemsppg + "',";
			MyData = MyData + "'TDt':'','BDt':'','EDt':'','UserName':'','ProdType':'" + ptype + "','ProdCode':'" + pcode + "','LocCode':'" + loc + "','Reg':'" + reg + "','Thick':'" + thick + "','Species':'" + spec + "','Grade':'" + grade + "',";
			MyData = MyData + "'Seasoning':'" + seas + "','Surface':'" + surf + "','StatusCode':'" + stat + "','Width':'" + wdth + "','Len':'" + len + "','Color':'" + color + "','fSort':'" + fsort + "','Milling':'" + mill + "','NoPrint':'" + nop + "',";
			MyData = MyData + "'iType':'" + itype + "','Set0':'" + set0.toString() + "','Set1':'" + currwk.toString() + "','Set2':'" + weeknd.toString() + "','Set3':'" + zeros.toString() + "','Set4':'" + set4.toString() + "',";
			MyData = MyData + "'Set5':'" + set5.toString() + "','Set6':'" + set6.toString() + "','Set7':'" + set7.toString() + "','OrdID':'" + ordid.toString() + "','ShipID':'" + shipid.toString() + "','LoadID':'" + loadid.toString() + "','Cust':'" + cust + "','Vend':'" + vend + "','Supplr':'" + supp + "','Mgr':'','MgrID':'" + mgrid.toString() + "','Sort':'" + sort + "','ItemCode':'" + icd + "',";
			MyData = MyData + "'ItemName':'" + inm + "','ItemDesc':'" + idesc + "','Nbr':'" + nbr.toString() + "','Code1':'" + c1 + "','Code2':'" + c2 + "','ID1':'" + id1.toString() + "','ID2':'" + id2.toString() + "','Comments':'" + cmt + "',";
			MyData = MyData + "'Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
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

		function SaveExportData() {
			var fname = prompt('Please enter a file name (no extension)(No ,$?!)?', 'Sales Data Export');
			fname = CleanTextMinimalTx(fname, 1);
			//alert(fname);
			if (fname.length > 0) {
				var act = 2;
				var a1 = '0';
				var a2 = '0';
				var a3 = '0';
				var a4 = '0';
				var a5 = '0';
				var a6 = '0';
				var a7 = '0';
				var a8 = '0';
				var c1 = '';
				var c2 = '';
				var cmt = '';
				var fuzzygrade = '';
				var fuzzysort = '';
				var fuzzyprod = '';
				var fuzzymgr = '';
				var fuzzycust = '';
				var custcode = '';
				var id = 0;
				var id1 = 0;
				var id2 = 0;
				var idesc = '';
				var inm = '';
				var loadid = 0;
				var mgr = '';
				var mgrid = 0;
				var nbr = 0;
				var ordid = 0;
				var shipid = 0;
				var sort = 0;
				var stat = '';
				var supp = '';
				var surf = '';
				var vend = '';
				var wdth = '';

				//if (jselQueryList.value === '0') {
				//	id = 0;
				//}
				//else {
				var queryid = parseInt(jselQueryList.value, 10);
				//}
				//alert('1');
				var cmt = '';
				var nm = jtQueryTitle.value;
				var reg = jselRegionMF.value;
				var loc = jselLocationMF.value;
				var spec = jselSpeciesMF.value;
				var thick = jselThickMF.value;
				var grade = jselGradeMF.value;
				//if (jtFilterColGrade.value !== '') { grade = jtFilterColGrade.value; }
				var seas = jselSeasoningMF.value;
				var len = jselLengthMF.value;
				//alert('2');
				var color = jselColorMF.value;
				var fsort = jselSortMF.value;
				var mill = jselMillingMF.value;
				var nop = jselNoPrintMF.value;
				var pcode = jselProductMF.value;
				//if (jtFilterColProd.value !== '') { pcode = jtFilterColProd.value; }
				//alert('3');
				var mgr = '';
				var cust = '';
				//alert('4');
				var ptype = 'HD'; //jselTypeMain.value; // jsel 'HD';
				var itype = '0'; //jselViewType.value;
				var inccust = 0;
				var incinv = 0;
				var incsales = 0;
				var incholds = 0;
				var incprod = 1;
				var inchist = 0;
				var incphist = 0;
				//alert('5');


				var set0 = parseInt(jselShowScopeF.value, 10);

				var set1 = 0;
				if (jchkShowWeekends.checked === true) { set1 = 1; }
				var set2 = parseInt(jselViewType.value, 10);;
				var set3 = 0;
				if (jchkShowZeros.checked === true) { set3 = 1; }
				//alert('5a');
				var set4 = 0;
				if (jchkNoEmptyProds.checked === true) { set4 = 1; }
				var set5 = parseInt(jselPageSize.value, 10);
				//alert('5b');
				var set6 = 0;
				var set7 = 0;
				//alert('6');
				//if (jchkSubtotalProducts.checked === true) { a1 = '1'; }
				//if (jchkSubtotalProdAttribs.checked === true) { a2 = '1'; }
				//alert('7');
				//if (jchkSubtotalSpecies.checked === true) { a3 = '1'; }
				//if (jchkSubtotalThickness.checked === true) { a4 = '1'; }
				//if (jchkSubtotalGrade.checked === true) { a5 = '1'; }
				//if (jchkSubtotalColor.checked === true) { a6 = '1'; }
				//if (jchkSubtotalSort.checked === true) { a7 = '1'; }
				//if (jchkSubtotalNoPrint.checked === true) { a8 = '1'; }
				var icd = a1 + a2 + a3 + a4 + a5 + a6 + a7 + a8;
				var vend = '';
				var suppl = '';
				var ritems = '';
				if (MyColumnSettings !== undefined && MyColumnSettings !== null) {
					if (MyColumnSettings.length > 0) {
						for (var c = 0; c < jiNbrCols; c++) {
							if (MyColumnSettings[c]['ItemValue'].toString() === '1') {
								ritems = ritems + 'X';
							}
							else {
								ritems = ritems + '0';
							}
						}
					}
				}

				//alert('8');
				var fuzzygrade = ''; //jtFilterColGrade.value.replace('%', '').replace('*', '');
				var fuzzysort = ''; //jtFilterColSort.value.replace('%', '').replace('*', '');
				var fuzzyprod = ''; //jtFilterColProd.value.replace('%', '').replace('*', '');
				var fuzzymgr = ''; //jtFilterColMgr.value.replace('%', '').replace('*', '');
				var fuzzycust = ''; //jtFilterColCust.value.replace('%', '').replace('*', '');
				var custcode = ''; //jhfCustCode.value;
				//if (custcode === '0') { custcode = ''; }
				//alert('9 - ' + icd);

				//if (incsales === 1 || inccust === 1 || incprod === 1 || inchold === 1 || incProdHist === 1) {
					if (ritems.length < jiNbrCols) { ritems = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'; }
					//alert('saving');
					var url = "../shared/AjaxServices.asmx/UpdateDataExport";
					var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','UserID':'" + jiByID.toString() + "','ExpFileNm':'" + fname + "','ProdType':'" + ptype + "','ProdCode':'" + pcode + "',";
					MyData = MyData + "'LocCode':'" + loc + "','Reg':'" + reg + "','Thick':'" + thick + "','Spec':'" + spec + "','Grade':'" + grade + "','Season':'" + seas + "','Surf':'" + surf + "','Stat':'" + stat + "',";
					MyData = MyData + "'iType':'" + itype + "','Wdth':'','Len':'" + len + "','Color':'" + color + "','FSort':'" + fsort + "','Milling':'" + mill + "','NoPrint':'" + nop + "','OrderID':'0','ShipID':'0','LoadID':'0',";
					MyData = MyData + "'Cust':'" + cust + "','Vendor':'" + vend + "','Supplier':'" + suppl + "','Mgr':'" + mgr + "','MgrID':'" + mgrid.toString() + "','Set0':'" + set0.toString() + "','Set1':'" + set1.toString() + "',";
					MyData = MyData + "'Set2':'" + set2.toString() + "','Set3':'" + set3.toString() + "','Set4':'" + set4.toString() + "','Set5':'" + set5.toString() + "','Set6':'" + set6.toString() + "',";
					MyData = MyData + "'RollupItems':'" + ritems + "','FuzzyGrade':'" + fuzzygrade + "','FuzzySort':'" + fuzzysort + "','FuzzyProd':'" + fuzzyprod + "','FuzzyMgr':'" + fuzzymgr + "','FuzzyCust':'" + fuzzycust + "',";
					MyData = MyData + "'Fuzzy6':'','IName':'','ICode':'','IDesc':'','Nbr':'0','Code1':'','Code2':'','id1':'0','id2':'0','TDt':'" + jsStartDate + "','BDt':'','EDt':'','CustCode':'" + custcode + "','SubTotal':'" + icd + "',";
					MyData = MyData + "'Cmt':'" + cmt + "','Sort':'" + sort + "','Active':'1'}";
					//alert(MyData);
					getJSONReturnDataAs(url, MyData, function (response)
					{ MyReturn = response; });
				//}
			}
			else {
				alert('That is not a valid file name. The data cannot be exported.');
			}
		}

		// **************************** POPULATE OBJECTS **********************************

		function PopulateColorList() {
			GetProdCodeList('Color');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selColorMF', 1);
				fillDropDownListGu(MyCodeListData, jselColorMF, 0, 'CodeDescription', 'CatCode');
			}
			return false;
		}

		function PopulateColumnSettings() {
			var chk;
			var ncol = 39;
			//alert('fired populate');
			if (MyColumnSettings !== undefined && MyColumnSettings !== null) {
				//alert('data returned');
				var nbrrows = MyColumnSettings.length;
				if (nbrrows > 14) { nbrrows = 14; }
				if (nbrrows > 0) {
					//alert('setting column checkbox');
					for (var itm = 0; itm < nbrrows; itm++) {
						chk = document.getElementById('chkColSetting' + itm.toString());
						if (MyColumnSettings[itm]['ItemValue'].toString() === '1') {
							chk.checked = true;
						}
						else {
							chk.checked = false;
						}
					}
				}
				else {
					alert('No column settings have been loaded.');
				}
			}
			else {
				alert('No column settings have been loaded.');
			}
			return false;
		}

		function PopulateConsolidation() {
			//alert('populating...');
			var okay = true;
			var bkColor = '#FFFFFF';
			var bld = false;
			var brdrL = '';
			var brdrR = '';
			var brdrT = '';
			var brdrB = '';
			var cellClass = 'StdTableCell';
			var colspn = '';
			var content = '';
			var contentNext = '';
			var disp = '';
			var dsabld = false;
			var fig = 0;
			var frColor = '#000000';
			var fSz = '11pt';
			var hAlign = '';
			var ht = '20px';
			var ital = false;
			var lineTotal = 0;
			var NbrCols = 40;
			var NbrRows = 0;
			var oldcontent = '';
			var ovrflw = 'hidden';
			var pL = '2px';
			var pR = '2px';
			var pT = '1px';
			var pB = '1px';
			var RdOnly = false;
			var rowtotal = 0;
			var ShowStrat = 1;
			var ShowTac = 1;
			var vAlign = '';
			var Visbl = true;
			var wdth = 100
			var sResults = '';
			jiTotalRows = 0;
			EmptyGridColumnTotals();
			ShowHideColumns();
			//if (jbShowWeekends === false) {
			//	ToggleColumnsVisible(0, 19, 20); //Tactical
			//	ToggleColumnsVisible(0, 26, 27); //Tactical
			//}
			//else {
			//	ToggleColumnsVisible(1, 19, 20); //Tactical
			//	ToggleColumnsVisible(1, 26, 27); //Tactical
			//}
			//ShowHideColumns();
			if (jiViewType === 1) { ShowStrat = 0; }
			if (jiViewType === 2) { ShowTac = 0; }

			var lvl = 1;
			jiNbrRows = 0;
			var bdy = document.createElement('tbody');
			if (MyConsolidationData !== undefined && MyConsolidationData !== null) {
				//alert('got data!');
				if (MyConsolidationData.length > 0) {
					//             0   1    2    3    4    5    6    7    8    9    10   11   12   13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28   29   30   31   32   33   34   35   36   37   38   39   40
					var cWidth = [50, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 100];
					var corient = ['L', 'L', 'L', 'L', 'L', 'L', 'L', 'L', 'L', 'L', 'L', 'L', 'L', 'L', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', ];
					NbrRows = MyConsolidationData.length;
					var LastVals = createArrayInitGu(15, 0);
					var NoDups = createArrayInitGu(NbrCols, 1);
					//alert('setting initial page - ' + NbrRows);
					jiNbrPagesPj[0] = parseInt(MyConsolidationData[0]['NbrPages'], 10);
					jiTotalRows = parseInt(MyConsolidationData[0]['NbrRows'], 10);
					//alert('2');
					jiPageNbr = 0;
					//alert('beginning rows - ' + NbrRows);
					for (var row = 0; row < NbrRows; row++) {
						//alert('Row ' + row.toString());
						rowtotal = 0;
						trow = document.createElement('tr');
						trow.id = 'trConsolidRow' + row.toString();
						lineTotal = 0;
						jiNbrRows++;
						for (var col = 0; col < NbrCols; col++) {
							content = '';
							//alert('Row ' + row.toString() + ', Col ' + col.toString());
							//alert('B');
							contentNext = '';
							bkColor = 'white';
							frColor = 'black';
							hAlign = 'left';
							vAlign = 'top';
							fSz = '11pt';
							pL = '2px';
							pR = '2px';
							pT = '1px';
							pB = '1px';
							//alert('C');
							bld = false;
							ital = false;
							ovrflw = 'hidden';
							RdOnly = false;
							dsabld = false;
							Visbl = '';
							colspn = '';
							//alert('D');
							if (col < MyColumnSettings.length && col < NbrCols) {
								//alert('show col ' + col.toString());
								if (LastVals[col] === undefined || LastVals[col] === null) { LastVals[col] = ''; }
								// show cell only if set visible
								//alert('checking visibility');
								if ((jaColVisible[col] === 1 && (col < 14 || col === 39)) || (col > 13 && col < 28 && ShowTac === 1) || (col > 27 && col < 39 && ShowStrat === 1)) {
									//alert('visible');
									//alert(MyConsolidationData[row]['ProdType'].toString())
									//alert(MyConsolidationData[row][0].toString())
									switch (col) {
										case 0:
											content = MyConsolidationData[row]['RecType'].toString();
											if (row !== (NbrRows - 1)) { contentNext = MyConsolidationData[row + 1]['RecType'].toString(); }
											break;
										case 1:
											content = MyConsolidationData[row]['Region'].toString();
											if (row !== (NbrRows - 1)) { contentNext = MyConsolidationData[row + 1]['Region'].toString(); }
											break;
										case 2:
											content = MyConsolidationData[row]['LocCode'].toString();
											if (row !== (NbrRows - 1)) { contentNext = MyConsolidationData[row + 1]['LocCode'].toString(); }
											break;
										case 3:
											content = MyConsolidationData[row]['ProdCode'].toString();
											if (row !== (NbrRows - 1)) { contentNext = MyConsolidationData[row + 1]['ProdCode'].toString(); }
											break;
										case 4:
											content = MyConsolidationData[row]['Thickness'].toString();
											if (row !== (NbrRows - 1)) { contentNext = MyConsolidationData[row + 1]['Thickness'].toString(); }
											break;
										case 5:
											content = MyConsolidationData[row]['Species'].toString();
											if (row !== (NbrRows - 1)) { contentNext = MyConsolidationData[row + 1]['Species'].toString(); }
											break;
										case 6:
											content = MyConsolidationData[row]['Grade'].toString();
											if (row !== (NbrRows - 1)) { contentNext = MyConsolidationData[row + 1]['Grade'].toString(); }
											break;
										case 7:
											content = MyConsolidationData[row]['Seasoning'].toString();
											if (row !== (NbrRows - 1)) { contentNext = MyConsolidationData[row + 1]['Seasoning'].toString(); }
											break;
										case 8:
											content = MyConsolidationData[row]['Surface'].toString();
											if (row !== (NbrRows - 1)) { contentNext = MyConsolidationData[row + 1]['Surface'].toString(); }
											break;
										case 9:
											content = MyConsolidationData[row]['ItemLength'].toString();
											break;
										case 10:
											content = MyConsolidationData[row]['Color'].toString();
											break;
										case 11:
											content = MyConsolidationData[row]['Sort'].toString();
											break;
										case 12:
											content = MyConsolidationData[row]['Milling'].toString();
											break;
										case 13:
											content = MyConsolidationData[row]['NoPrint'].toString();
											break;
										default:
											if (col < 39) {
												if (col > 13 && col < 21) {
													fig = MyConsolidationData[row]['Wk1_' + (col - 13).toString()].toString();
												}
												if (col > 20 && col < 28) {
													fig = MyConsolidationData[row]['Wk2_' + (col - 20).toString()].toString();
												}
												if (col > 27 && col < 39) {
													fig = MyConsolidationData[row]['Wk' + (col - 25).toString()].toString();
												}
												content = jsfNumberFormatNf(fig, 1, '.', ',');
											}
											else {
												content = '0.0';
											}
											break;
									}
									//alert('Content: ' + content);
									oldcontent = content;
									switch (corient[col]) {
										case 'L':
											hAlign = 'left';
											break;
										case 'R':
											hAlign = 'right';
											break;
										case 'C':
											hAlign = 'center';
											break;
										default:
											break;
									}

									// set borders to show continuing values
									brdrL = '1px solid gray';
									brdrR = '1px solid gray';
									brdrT = '1px solid gray';
									brdrB = '1px solid gray';
									if (col < 9) {
										if (content === LastVals[col]) {
											brdrT = 'none';
											content = '';
										}
										if (oldcontent === contentNext) {
											brdrB = 'none';
										}
									}
									//if (col === 13) {
									//	brdrR = '4px double gray';
									//}
									if (col === 14 || col === 21 || col === 28 || col === 39) {
										brdrL = '4px double gray';
									}
									// set weekend background color
									if (col === 19 || col === 20 || col === 26 || col === 27) {
										bkColor = 'aqua';
									}
									disp = '';
									if (jaColVisible[col] === 0) { disp = 'none'; }
									if (col > 13 && col < 39) {
										if (content === '0.0' || content === '0') {
											frColor = 'gray';
										}
										fig = parseFloat(content);
										lineTotal += fig;
										jaColTotals[col - 14] += fig;
									}
									else {
										if (col < 14) {
											bkColor = '#FFFFCC';
										}
										if (col === 39) {
											jaColTotals[25] += lineTotal;
										}
									}
									// set line total value
									if (col == 39) { content = jsfNumberFormatNf(lineTotal, 1, '.', ','); }
									//alert('Precheck content: ' + content);
									if (col > 13 && col < 39) {
										if (jbShow0s === false && parseFloat(content) === 0) { content = ''; }
									}
									//alert('creating cell - ' + 'tdConsolid' + row.toString() + '_' + col.toString() + '/' + ht + '/' + cWidth[col] + '/' + content + '/' + bkColor + '/' + frColor + '/' + bld + '/' + ital);
									//alert('creating cell2 - ' + brdrL + '/' + brdrR + '/' + brdrT + '/' + brdrB + '/' + hAlign + '/' + vAlign + '/' + pL + '/' + pR + '/' + pT + '/' + pB + '/' + fSz);
									//alert('creating cell3 - ' + ovrflw + '/' + RdOnly + '/' + dsabld + '/' + Visbl + '/' + colspn + '/' + cellClass);
									tcell = createNewCellDg('tdConsolid' + row.toString() + '_' + col.toString(), ht, cWidth[col].toString() + 'px', content, bkColor, frColor, brdrL, brdrR, brdrT, brdrB, hAlign, vAlign, pL, pR, pT, pB, fSz, bld, ital, ovrflw, RdOnly, dsabld, Visbl, colspn, cellClass, disp);
									//alert('appending cell');
									trow.appendChild(tcell);
									//alert('setting last val');
									LastVals[col] = oldcontent;
								}
							}
						}	// for (var col = 0; col < NbrCols; col++)
						bdy.appendChild(trow);
					} //for (var row = 0; row < NbrRows; row++)
				} //MyConsolidationData.length > 0
			}
			else {
				alert('Consolidation data could not be extracted because of an unidentified error.');
			}

			//alert('Attaching body');
			try {
				var oldBody = jtblForecastConsolidation.getElementsByTagName("tbody")[0];
				jtblForecastConsolidation.replaceChild(bdy, oldBody);
			}
			catch (ex) {

			}
			//alert('checking nbr rows - ' + NbrRows);
			if (NbrRows === 0) {
				jlStatusMsg.innerHTML = 'No data matches that criteria.';
			}
			FillGridColumnTotals();

			//alert(jiTotalRows + '/' + NbrRows);
			if (jiTotalRows > NbrRows) {
				joPgNbrLblPj.innerHTML = (jiPgNbrPj[0] + 1).toString();
				joMaxPgNbrLblPj.innerHTML = jiNbrPagesPj[0].toString();
				joPaginationBarPj.style.display = 'block';
			}
			return okay;
		}

		function PopulateGradeList() {
			GetProdCodeList('Grade');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selGradeMF', 1);
				fillDropDownListGu(MyCodeListData, jselGradeMF, 0, 'CodeDescription', 'CatCode');
			}
			return false;
		}

		function PopulateGradeListByRegion() {
			GetProdCodeListForRegion('Grade');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selGradeMF', 1);
				fillDropDownListGu(MyCodeListData, jselGradeMF, 0, 'CodeDescription', 'CatCode');
			}
			return false;
		}

		function PopulateLengthList() {
			GetProdCodeList('Length');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selLengthT', 1);
				fillDropDownListGu(MyCodeListData, jselLengthMF, 0, 'CodeDescription', 'CatCode');
			}
			return false;
		}

		function PopulateLocationList() {
			if (jbA === true) {
				GetLocationList();
				//alert('Admin');
			}
			else {
				GetUserLocationList();
				//alert('User');
			}
			//alert(MyLocations[0]['Name']);
			if (MyLocations !== undefined && MyLocations !== null) {
				//alert(MyLocations.length);
				ClearDDLOptionsGu('selLocationMF', 1);
				fillDropDownListGu(MyLocations, jselLocationMF, 0, 'Name', 'loc');
			}
			return false;
		}

		function PopulateLocationListByRegion() {
			if (jbA === true || jbAllLocations === true) {
				GetLocationList();
				//alert('Admin');
			}
			else {
				GetUserLocationList();
				//alert('User');
			}
			ClearDDLOptionsGu('selLocationMF', 1);
			//alert(MyLocations[0]['Name']);
			if (MyLocations !== undefined && MyLocations !== null) {
				fillDropDownListGu(MyLocations, jselLocationMF, 0, 'Name', 'loc');
			}
			if (MyLocations === undefined || MyLocations === null || MyLocations.length === 0) {
				appendDDLOptionGu(jselLocationMF, jsLocationCode, jsLocationCode);
			}
			return false;
		}

		function PopulateMillingList() {
			GetProdCodeList('Milling');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selMillingMF', 1);
				fillDropDownListGu(MyCodeListData, jselMillingMF, 0, 'CodeDescription', 'CatCode');
			}
			return false;
		}

		function PopulateNoPrintList() {
			GetProdCodeList('NoPrint');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selNoPrintMF', 1);
				fillDropDownListGu(MyCodeListData, jselNoPrintMF, 0, 'CodeDescription', 'CatCode');
			}
			return false;
		}

		function PopulateProductList() {
			GetProductListMini();
			//alert(MyProductListMini.length);
			if (MyProductListMini !== undefined && MyProductListMini !== null) {
				ClearDDLOptionsGu('selProductMF', 1);
				//alert('filling');
				fillDropDownListGu(MyProductListMini, jselProductMF, 0, 'sManagedItemIdent', 'ProductManagedID');
			}
			return false;
		}

		function PopulateNoPrintList() {
			GetProdCodeList('NoPrint');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selNoPrintMF', 1);
				fillDropDownListGu(MyCodeListData, jselNoPrintMF, 0, 'CodeDescription', 'CatCode');
			}
			return false;
		}

		function PopulateQueryList() {
			GetUserQueryList()
			if (MyQueryList !== undefined && MyQueryList !== null) {
				ClearDDLOptionsGu('selQueryList', 1);
				fillDropDownListGu(MyQueryList, jselQueryList, 0, 'QueryName', 'UserQueryID');
			}
			return false;
		}

		function PopulateSeasoningList() {
			GetProdCodeList('Seasoning');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selSeasoningMF', 1);
				fillDropDownListGu(MyCodeListData, jselSeasoningMF, 0, 'CodeDescription', 'CatCode');
			}
			return false;
		}

		function PopulateSpeciesList() {
			GetProdCodeList('Species');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selSpeciesMF', 1);
				fillDropDownListGu(MyCodeListData, jselSpeciesMF, 0, 'CodeDescription', 'CatCode');
			}
			return false;
		}

		function PopulateSpeciesListByRegion() {
			GetProdCodeListForRegion('Species');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selSpeciesMF', 1);
				fillDropDownListGu(MyCodeListData, jselSpeciesMF, 0, 'CodeDescription', 'CatCode');
			}
			return false;
		}

		function PopulateSortList() {
			GetProdCodeList('Sort');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selSortMF', 1);
				fillDropDownListGu(MyCodeListData, jselSortMF, 0, 'CodeDescription', 'CatCode');
			}
			return false;
		}

		function PopulateThicknessList() {
			GetProdCodeList('Thickness');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selThickMF', 1);
				fillDropDownListGu(MyCodeListData, jselThickMF, 0, 'CodeDescription', 'CatCode');
			}
			return false;
		}

		function PopulateThicknessListByRegion() {
			GetProdCodeListForRegion('Thickness')
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selThickMF', 1);
				fillDropDownListGu(MyCodeListData, jselThickMF, 0, 'CodeDescription', 'CatCode');
			}
			return false;
		}

		// **************************** DIALOGs *********************************

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
				case 93:
					//alert('Fired!');
					UpdateUserRightLevel(id, val);
					break;
				default:
					break;
			}
			return false;
		}

		function ChangeRadioBtn(id, objid, val, ischecked) {
			return false;
		}

		function DialogAction1(dChoice, Src) {
			switch (Src) {
				case 2: // nothing
					break;
				case 3:
					GetColumnSettings();
					ShowHideColumns();
					ChangeViewType(jiViewType.toString());
					PopulateConsolidation();
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
			return false;
		}

		function DeleteOneRec(id, row, objid) {
			return false;
		}

		function ShowDebugInfo() {
			var sdata = 'Show Current Week: ' + jbShowCurrentWeek.toString() + '\n';
			sdata = sdata + 'Show Weekends: ' + jbShowWeekends.toString() + '\n';
			sdata = sdata + 'Today: ' + jsToday + '\n';
			sdata = sdata + 'AR: ' + jiAR.toString() + '\n';
			sdata = sdata + 'Page Nbr: ' + jiPageNbr.toString() + '\n';
			sdata = sdata + 'Page Size: ' + jiPageSize.toString() + '\n';
			sdata = sdata + 'Nbr Rows: ' + jiTotalRows.toString() + '\n';
			sdata = sdata + 'Nbr Pages: ' + (jiNbrPages+1).toString() + '\n';
			sdata = sdata + '' + '\n';
			sdata = sdata + 'User: ' + jiByID.toString() + '\n';
			sdata = sdata + 'Page ID: ' + jiPageID.toString() + '\n';
			sdata = sdata + 'Last AJAX: ' + jsLastAJAXCall;
			alert(sdata);
		}
		
		function ShowHelpDialog() {
			var ht = 400;
			var wdth = 560;
			showPopupEditBoxDx('divPageHelp', 'Help Information', true, true, ht, wdth, '', '', window, '', 3, '11pt', '2px', 'fadeIn', 'fadeOut', 'MyDialogButtonStd', 'MyDialogStd', 2);
			return false;
		}

		function TailorVisibleColumns() {
			jlColSettingStatus.innerHTML = '';
			//alert('Fired!');
			GetColumnSettings();
			//alert('populating');
			PopulateColumnSettings();
			//alert('showing');
			var ht = 400;
			var wdth = 460;
			showPopupEditBoxDx('divColEditPopup', 'Edit Column Visibility', true, true, ht, wdth, '', '', window, '', 3, '11pt', '2px', 'fadeIn', 'fadeOut', 'MyDialogButtonStd', 'MyDialogStd', 3);
			//alert('Done!');
			return false;
		}

		// **************************** BACKGROUND FUNCTIONS *********************************

		function EmptyGridColumnTotals() {
			var okay = true;
			for (var itm = 0; itm < 35; itm++) {
				jaColTotals[itm] = 0;
			}
			return okay;
		}

		function FillGridCalDates() {
			GetWeekDates13();
			var mydate;
			var dt = '';
			var dy = 0;
			var mo = 0;
			var s = '';
			var yr = 0;
			var Wk1 = new Date();
			var Wk2 = new Date();
			if (MyWeeksData !== undefined && MyWeeksData !== null) {
				s = MyWeeksData[0]["sStartDate"].toString();
				Wk1 = new Date(s); //ConvertJSONDate(
				s = MyWeeksData[2]["sFriday"].toString();
				yr = parseInt(s.substr(0, 4), 10);
				mo = parseInt(s.substr(5, 2), 10);
				dy = parseInt(s.substr(8, 2), 10);
				//alert(s); //**********************
				Wk2 = new Date(yr, mo - 1, dy, 1, 0, 0, 0);
				//alert(Wk2);
				for (var itm = 1; itm <= 25; itm++) {
					Wk1.addDays(1);
					if (itm <= 7) {
						dt = getMyDateStringDm(Wk1, 0, 0);
						document.getElementById('lblHdrWk1Dy' + itm.toString()).innerHTML = dt;
					}
					if (itm > 7 && itm <= 14) {
						dt = getMyDateStringDm(Wk1, 0, 0);
						document.getElementById('lblHdrWk2Dy' + (itm - 7).toString()).innerHTML = dt;
					}
					if (itm > 14) {
						//alert(Wk2 + '/' + getMyDateString(Wk2, 0, 0));
						dt = getMyDateStringDm(Wk2, 0, 0);
						document.getElementById('lblHdrWk' + (itm - 12).toString() + 'Dy1').innerHTML = dt;
						Wk2.addDays(7);
					}
				}
			}
			return false;
		}

		function FillGridColumnTotals() {
			for (var itm = 0; itm <= 25; itm++) {
				document.getElementById('lblTotal' + itm.toString()).innerHTML = jsfNumberFormatNf(jaColTotals[itm], 1, '.', ',');
			}
			//alert('Done setting totals');
			return false;
		}

		function GetNbrSeconds(bdt) {
			var eDate = new Date();
			return (eDate.getTime() - bdt.getTime()) / 1000;
		}

		// **************************** UI FUNCTIONS *********************************

		function ChangeCurrentWeekView(chkd) {
			jlPageStatus.innerHTML = 'Please wait...';
			//alert(chkd);
			jbShowCurrentWeek = chkd;
			if (chkd === true) {
				jlWeekNbr.innerHTML = '00';
			}
			else {
				jlWeekNbr.innerHTML = '01';
			}
			FillGridCalDates();
			GetConsolidationData();
			PopulateConsolidation();
			jlPageStatus.innerHTML = 'Page Ready';
			return false;
		}

		function ChangeFilterCode(typ, val) {
			jiPgNbrPj[0] = 0;
			return false;
		}

		function ChangeLocationCode(val) {
			jlPageStatus.innerHTML = 'Please wait...';
			jiPgNbrPj[0] = 0;
			//alert(val);
			jsLocationCode = val;
			GetRegionForLoc(val);
			PopulateLocationListByRegion();
			jselRegionMF.value = jsRegionCode;
			jselLocationMF.value = jsLocationCode;
			//alert(jsRegionCode);
			PopulateProductList();
			//alert('products done');
			PopulateThicknessListByRegion();
			//alert('thickness done');
			PopulateGradeListByRegion();
			//alert('grade done');
			PopulateSpeciesListByRegion();
			//alert('species done');
			//GetConsolidationData();
			//PopulateConsolidation();
			jlPageStatus.innerHTML = 'Page Ready';
			return false;
		}

		function ChangeNoEmptyProds(chkd) {
			jiPgNbrPj[0] = 0;
			if (chkd === true) {
				jbNoEmptyProds = true;
			}
			else {
				jbNoEmptyProds = false;
			}
			GetConsolidationData();
			PopulateConsolidation();
			return false;
		}

		function ChangePageSize(val) {
			jlPageStatus.innerHTML = 'Please wait...';
			jiPageSize = parseInt(val, 10);
			jiPgNbrPj[0] = 0;
			jiPgSizePj[1] = jiPageSize;
			jiPgSizePj[0] = jiPageSize;
			GetConsolidationData();
			PopulateConsolidation();
			jlPageStatus.innerHTML = 'Page Ready';
			return false;
		}

		function ChangeRegionCode(val) {
			jsRegionCode = val;
			jiPgNbrPj[0] = 0;
			if (val === '0') { jsRegionCode = ''; }
			jlPageStatus.innerHTML = 'Please wait...';
			PopulateProductList();
			PopulateThicknessListByRegion();
			PopulateGradeListByRegion();
			PopulateSpeciesListByRegion();
			PopulateLocationListByRegion();
			jlPageStatus.innerHTML = 'Page Ready';
			return false;
		}

		function ChangeShowScope(val) {
			jiDateScope = parseInt(val, 10);
			switch (jiDateScope) {
				case 0:
					jtTargetDateH.value = '';
					jspnTargetDateH.style.display = 'none';
					ChangeCurrentWeekView(false);
					break;
				case 1:
					jtTargetDateH.value = '';
					jspnTargetDateH.style.display = 'none';
					ChangeCurrentWeekView(true);
					break;
				default:
					jbShowCurrentWeek = false;
					jspnTargetDateH.style.display = 'inline';
					jlWeekNbr.innerHTML = 'N/A';
					break;
			}
			return false;
		}

		function ChangeViewType(val) {
			//alert('Changing view: ' + val);
			jiPgNbrPj[0] = 0;
			jlPageStatus.innerHTML = 'Please wait...';
			jiViewType = parseInt(val, 10);
			switch (jiViewType) {
				case 0: // all
					ToggleColumnsVisible(1, 14, 27); //Tactical
					ToggleColumnsVisible(1, 28, 38); //Strategic
					break;
				case 1:	// tactical
					//alert('Changing');
					ToggleColumnsVisible(1, 14, 27); //Tactical
					ToggleColumnsVisible(0, 28, 38); //Strategic
					break;
				case 2:	// strategic
					ToggleColumnsVisible(1, 28, 38); //Strategic
					ToggleColumnsVisible(0, 14, 27); //Tactical
					break;
				default:
					break;
			}
			//PopulateConsolidation();
			jlPageStatus.innerHTML = 'Page Ready';
			return false;
		}

		function ChangeWeekendView(chkd) {
			//alert(jiNbrRows);
			if (chkd === true) {
				jbShowWeekends = true;
				ToggleColumnsVisible(1, 19, 20);
				ToggleColumnsVisible(1, 26, 27);
			}
			else {
				jbShowWeekends = false;
				ToggleColumnsVisible(0, 19, 20);
				ToggleColumnsVisible(0, 26, 27);
			}
			//PopulateConsolidation();
			return false;
		}

		function ChangeZeroValSetting(chkd) {
			if (chkd === true) {
				jbShow0s = true;
			}
			else {
				jbShow0s = false;
			}
			PopulateConsolidation();
		}

		function LoadSavedQueryData(val) {
			//alert('Loading Saved Query - ' + val);
			jlPageStatus.innerHTML = 'Please wait...';
			jiPgNbrPj[0] = 0;
			var n = 0;
			var str = '';
			//var nm = jselQueryList.value;
			GetUserQueryData(val);
			if (MyQueryData !== undefined && MyQueryData !== null) {
				if (MyQueryData.length > 0) {
					//alert('setting items');
					jtQueryTitle.value = MyQueryData[0]['QueryName'].toString();
					//alert(MyQueryData[0]['QueryName'].toString());
					jiPageNbr = TryParseIntNf(MyQueryData[0]['PgNbr'].toString(), 0);
					var np = parseInt(jselPageSize.value, 10);
					jiPageSize = TryParseIntNf(MyQueryData[0]['PgSize'].toString(), np);
					SelectMultipleItemsInList(MyQueryData[0]['ProductCode'].toString(), jselProductMF);
					var itype = parseInt(MyQueryData[0]['TypeID'], 10);
					jselViewType.value = itype;
					//alert('setting multiple items');
					SelectMultipleItemsInList(MyQueryData[0]['RegionCode'].toString(), jselRegionMF);
					SelectMultipleItemsInList(MyQueryData[0]['LocationCode'].toString(), jselLocationMF);
					SelectMultipleItemsInList(MyQueryData[0]['ThicknessCode'].toString(), jselThickMF);
					SelectMultipleItemsInList(MyQueryData[0]['SpeciesCode'].toString(), jselSpeciesMF);
					SelectMultipleItemsInList(MyQueryData[0]['GradeCode'].toString(), jselGradeMF);
					SelectMultipleItemsInList(MyQueryData[0]['SeasoningCode'].toString(), jselSeasoningMF);
					SelectMultipleItemsInList(MyQueryData[0]['LengthCode'].toString(), jselLengthMF);
					SelectMultipleItemsInList(MyQueryData[0]['ColorCode'].toString(), jselColorMF);
					SelectMultipleItemsInList(MyQueryData[0]['SortCode'].toString(), jselSortMF);
					SelectMultipleItemsInList(MyQueryData[0]['MillingCode'].toString(), jselMillingMF);
					SelectMultipleItemsInList(MyQueryData[0]['NoPrintCode'].toString(), jselNoPrintMF);
					//alert('setting settings');
					var cwk = MyQueryData[0]['Setting1'].toString();
					var wkend = MyQueryData[0]['Setting2'].toString();
					var zeros = MyQueryData[0]['Setting3'].toString();
					var neprods = MyQueryData[0]['Setting4'].toString();
					//alert('setting checkboxes');
					//alert('setting checkboxes 2');
					if (wkend === '1') {
						jchkShowWeekends.checked = true;
					}
					else {
						jchkShowWeekends.checked = false;
					}
					//alert('setting checkboxes 3');
					if (zeros === '1') {
						jchkShowZeros.checked = true;
					}
					else {
						jchkShowZeros.checked = false;
					}
					if (neprods === '1') {
						jchkNoEmptyProds.checked = true;
					}
					else {
						jchkNoEmptyProds.checked = false;
					}
					//alert('Getting new data');
					GetConsolidationData();
					PopulateConsolidation();
					jlPageStatus.innerHTML = 'Page Ready';
					return true;
				}
				else {
					return false;
				}
			}
			else {
				return false;
			}
		}

		function SelectMultipleItemsInList(cd, lst) {
			if (!IsContentsNullUndefEmptyGu(cd)) {
				if (cd.indexOf(',') > 0) {
					var codes = cd.split(',');
					for (var i = 0; i < codes.length; i++) {
						for (var j = 0; j < lst.length; j++) {
							if (lst[j] === codes[i]) { lst[j].checked = true; }
						}
					}
				}
				else {
					lst.value = cd;
				}
			}
			return false;
		}

		function RefreshConsolidationData() {
			$('lblNbrSeconds').text('');
			var d = new Date();
			$('lblPageStatus').text('Data loading...');
			//jlPageStatus.innerHTML = 'Data loading...';
			jlStatusMsg.innerHTML = '';
			//alert('emptying totals');
			if (EmptyGridColumnTotals() && GetConsolidationData()) {
				//alert('populating grid');
				if (PopulateConsolidation()) {
					document.getElementById('lblNbrSeconds').innerHTML = GetNbrSeconds(d).toString() + ' seconds';
					$.when(lblNbrSeconds.innerHTML !== '').then(function() {
						jlPageStatus.innerHTML = 'Page Ready';
					});
					FillGridCalDates();
				}
				else {
					jlPageStatus.innerHTML = 'Data grid could not be refreshed';
				}
			}
			else {
				jlPageStatus.innerHTML = 'Refresh failed';
			}
			//alert('done');
			return false;
		}

		function SaveQueryFormat() {
			//var ttl = jtQueryTitle.value;
			UpdateUserQuery();
			PopulateQueryList();
			return false;
		}

		function ShowHideColumns() {
			//alert('fired show-hide');
			var ds = 0;
			var nr = '';
			ncols = 0;
			var nactivecols = 0;
			var tcol;
			var tcol2;
			if (MyColumnSettings !== undefined && MyColumnSettings !== null) {
				//alert('header change');
				var ncols = MyColumnSettings.length;
				if (ncols > 0) {
					for (var col = 0; col < 14; col++) {
						if (col <= ncols) {
							nr = col.toString();
							if (nr.length === 1) { nr = '0' + nr; }
							// header
							if (jaColVisible[col] === 1) {
								document.getElementById('thHdrCol' + nr).style.display = 'table-cell';
								nactivecols++;
							}
							else {
								document.getElementById('thHdrCol' + nr).style.display = 'none';
							}
						}
					}
				}
			}

			// footer
			//alert('footer change - ' + nactivecols);
			if (nactivecols !== 14) {
				document.getElementById('tfcell00').colSpan = nactivecols.toString();
			}

			//alert('starting view settings');
			switch (jiViewType) {
				case 1: //tactical only
					ToggleColumnsVisible(1, 14, 27); //Tactical
					ToggleColumnsVisible(0, 28, 38); //Strategic
					if (jbShowWeekends === false) {
						ToggleColumnsVisible(0, 19, 20); //Tactical
						ToggleColumnsVisible(0, 26, 27); //Tactical
					}
					else {
						ToggleColumnsVisible(1, 19, 20); //Tactical
						ToggleColumnsVisible(1, 26, 27); //Tactical
					}
				case 2: //strategic only
					ToggleColumnsVisible(0, 14, 27); //Tactical
					ToggleColumnsVisible(1, 28, 38); //Strategic
				default:
					ToggleColumnsVisible(1, 28, 38); //Strategic
					ToggleColumnsVisible(1, 14, 27); //Tactical
					if (jbShowWeekends === false) {
						ToggleColumnsVisible(0, 19, 20); //Tactical
						ToggleColumnsVisible(0, 26, 27); //Tactical
					}
					else {
						ToggleColumnsVisible(1, 19, 20); //Tactical
						ToggleColumnsVisible(1, 26, 27); //Tactical
					}
					break;
			}
			//alert('finished vis');
			return false;
		}

		function ToggleColumnsVisible(typ, colstart, colend) {
			var displ = 'none';
			var idispl = 0;
			var val = '';
			if (typ === 1) {
				displ = 'table-cell';
				idispl = 1;
			}
			//alert('Starting column for');
			for (var itm = colstart; itm <= colend; itm++) {
				val = itm.toString();
				if (val.length === 1) { val = '0' + val; }
				document.getElementById('thHdrCol' + val).style.display = displ;
				document.getElementById('tfcell' + val).style.display = displ;
				jaColVisible[itm] = idispl;
				if (jiNbrRows > 0) {
					for (var row = 0; row < jiNbrRows; row++) {
						document.getElementById('tdConsolid' + row.toString() + '_' + itm.toString()).style.display = displ;
					}
				}
			}
			//alert('done');
			return false;
		}

		// **************************** Off-Page *********************************

		function ExportToExcel() {
			SaveExportData();	// saves selection criteria for extracting data
			var url = '../shared/ExportSalesCSV.aspx?p=' + jiPageID.toString() + '&oj=1';
			window.open(url, '_popup', '', false);
			return false;
		}

		function ExportToPDF() {
			SaveExportData();	// saves selection criteria for extracting data
			var url = '../shared/ExportSalesPDF.aspx?p=' + jiPageID.toString() + '&oj=1';
			//alert('opening ' + url);
			window.open(url, '_popup', '', false);
			return false;
		}

		function GotoForecastPage() {
			document.location.href = '../prod/ForecastTool.aspx';
			return false;
		}

	</script>

  <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />

</head>
<body>
	<img id="imgSessionKeepAlive" width="1" height="1" style="display:none;" src="../Images/clearpixel.gif" />
  <form id="Form1" runat="server">
  <asp:ScriptManager runat="server"></asp:ScriptManager>
	<asp:HiddenField ID="hfPageID" runat="server" Value="55" />

    <div class="container body-content">
      <div id="divMainIcon" style="width:99%;">
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

			<div id="divColEditPopup" style="display:none;position:relative;height:400px;width:460px;">
				<label id="lblColEditHdr" style="font-weight:bold;color:blue;font-size:11pt;">Column Visibility</label><br />
				<table id="tblColumnSettings" style="font-family:Arial;border-collapse:collapse;">		
				<tr>
					<th class="TableHdrCell" style="font-size:9pt;">Column Nbr</th>
					<th class="TableHdrCell" style="width:90px;font-size:9pt;">Content</th>
					<th class="TableHdrCell" style="font-size:9pt;">Shown</th>
					<th>&nbsp;&nbsp;&nbsp;</th>
					<th class="TableHdrCell" style="font-size:9pt;">Column Nbr</th>
					<th class="TableHdrCell" style="font-size:9pt;">Content</th>
					<th class="TableHdrCell" style="font-size:9pt;">Shown</th>
				</tr>
				<tr>
					<td class="StdTableCell" style="text-align:center;">0</td>
					<td class="StdTableCell">Rec Type</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting0" checked="checked" onchange="javascript:ChangeColSetting('Col 00', this.checked); return false;" /></td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td class="StdTableCell" style="text-align:center;">9</td>
					<td class="StdTableCell">Length</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting9" checked="checked" onchange="javascript:ChangeColSetting('Col 09', this.checked); return false;" /></td>
				</tr>
				<tr>
					<td class="StdTableCell" style="text-align:center;">1</td>
					<td class="StdTableCell">Region</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting1" checked="checked" onchange="javascript:ChangeColSetting('Col 01', this.checked); return false;" /></td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td class="StdTableCell" style="text-align:center;">10</td>
					<td class="StdTableCell">Color</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting10" checked="checked" onchange="javascript:ChangeColSetting('Col 10', this.checked); return false;" /></td>
				</tr>
				<tr>
					<td class="StdTableCell" style="text-align:center;">2</td>
					<td class="StdTableCell">Location/Mill</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting2" checked="checked" onchange="javascript:ChangeColSetting('Col 02', this.checked); return false;" /></td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td class="StdTableCell" style="text-align:center;">11</td>
					<td class="StdTableCell">Sort</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting11" checked="checked" onchange="javascript:ChangeColSetting('Col 11', this.checked); return false;" /></td>
				</tr>
				<tr>
					<td class="StdTableCell" style="text-align:center;">3</td>
					<td class="StdTableCell">Product</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting3" checked="checked" onchange="javascript:ChangeColSetting('Col 03', this.checked); return false;" /></td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td class="StdTableCell" style="text-align:center;">12</td>
					<td class="StdTableCell">Milling</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting12" checked="checked" onchange="javascript:ChangeColSetting('Col 12', this.checked); return false;" /></td>
				</tr>
				<tr>
					<td class="StdTableCell" style="text-align:center;">4</td>
					<td class="StdTableCell">Thickness</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting4" checked="checked" onchange="javascript:ChangeColSetting('Col 04', this.checked); return false;" /></td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td class="StdTableCell" style="text-align:center;">13</td>
					<td class="StdTableCell">NoPrint</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting13" checked="checked" onchange="javascript:ChangeColSetting('Col 13', this.checked); return false;" /></td>
				</tr>
				<tr>
					<td class="StdTableCell" style="text-align:center;">5</td>
					<td class="StdTableCell">Species</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting5" checked="checked" onchange="javascript:ChangeColSetting('Col 05', this.checked); return false;" /></td>
					<td colspan="4">&nbsp;</td>
				</tr>
				<tr>
					<td class="StdTableCell" style="text-align:center;">6</td>
					<td class="StdTableCell">Grade</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting6" checked="checked" onchange="javascript:ChangeColSetting('Col 06', this.checked); return false;" /></td>
					<td colspan="4">&nbsp;</td>
				</tr>
				<tr>
					<td class="StdTableCell" style="text-align:center;">7</td>
					<td class="StdTableCell">Seasoning</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting7" checked="checked" onchange="javascript:ChangeColSetting('Col 07', this.checked); return false;" /></td>
					<td colspan="4">&nbsp;</td>
				</tr>
				<tr>
					<td class="StdTableCell" style="text-align:center;">8</td>
					<td class="StdTableCell">Surface</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting8" checked="checked" onchange="javascript:ChangeColSetting('Col 08', this.checked); return false;" /></td>
					<td colspan="4">&nbsp;</td>
				</tr>
				</table>
				<div id="divColSettingStatus" style="width:100%;text-align:center;">
					<label id="lblColSettingStatus" style="color:maroon;font-size:12pt;font-weight:bold;"></label>
				</div>
			</div>

			<div id="divPageHelp" style="display:none;position:relative;height:400px;width:560px;">
				<table style="width:100%;padding:1px;border-spacing:0px;">
				<tr>
					<td style="width:4%;vertical-align:top;">
						1.&nbsp;
					</td>
					<td style="width:96%;">
						Filter lists may take a few seconds when the page initially loads. Please wait until the page status message at the supper right reads "Page Ready" to display data. 
					</td>
				</tr>
				<tr>
					<td style="width:4%;vertical-align:top;">
						2.&nbsp;
					</td>
					<td style="width:96%;">
						Weeks normally begin on the first Monday of the current week. Tactical data is shown by day. Strategic data is shown by week as of Friday in the week.
					</td>
				</tr>
				<tr>
					<td style="width:4%;vertical-align:top;">
						3.&nbsp;
					</td>
					<td style="width:96%;">
						Some filters when set will cause other filter lists to be reloaded. During reloading the page status message (upper right) will show "Please wait...". Once the message says "Page Ready", you can continue editing.
					</td>
				</tr>
				<tr>
					<td style="width:4%;vertical-align:top;">
						4.&nbsp;
					</td>
					<td style="width:96%;">
						Filters are set when you click on the "Display Consolidation" button. However, the checkboxes and drop down settings just below the filters bar take effect immediately.
					</td>
				</tr>
				<tr>
					<td style="width:4%;vertical-align:top;">
						5.&nbsp;
					</td>
					<td style="width:96%;">
						To save a query, enter a Query Title and click on the "Save" button to the right of the title field. All of your current filters will be saved as-is under that title, and the new query will immediately appear
						in the "Saved Queries" drop down list. Selecting the query on the list will immediately load the query data and refresh the data grid to reflect it.
					</td>
				</tr>
				<tr>
					<td style="width:4%;vertical-align:top;">
						6.&nbsp;
					</td>
					<td style="width:96%;">
						To go to a specific page number, enter the page number in the page management bar at the bottom in the "Goto Page" field, then press the TAB key to exit the field. You will immediately be taken to the page you entered.
					</td>
				</tr>
				</table>
			</div>

			<div id="divPAGEHEADER" style="width:99%;margin-left:10px;">
				<div id="divCalendarTitle" style="width:100%;">
					<label id="lblWebCalHdrTitle" class="LabelGridHdrStd" style="font-size:11pt;">Consolidation Filters:</label>
					<label id="lblPageStatus" style="position:absolute;font-size:10pt;font-weight:bold;color:darkgray;right:70px;">Page Loading...</label>&nbsp;
				</div>
				<div id="divMainFilters" style="width:100%;text-align:center;">
					<table id="divCalFilters" style="padding:2px;border-spacing:0px;width:100%;">
					<tr>
						<th id="thMainFilter00" class="TableHdrCell">
							Region
						</th>
						<th id="thMainFilter01" class="TableHdrCell">
							Location
						</th>
						<th id="thMainFilter02" class="TableHdrCell">
							Species
						</th>
						<th id="thMainFilter03" class="TableHdrCell">
							Thickness
						</th>
						<th id="thMainFilter04" class="TableHdrCell">
							Grade
						</th>
						<th id="thMainFilter05" class="TableHdrCell">
							Seasoning
						</th>
						<th id="thMainFilter06" class="TableHdrCell">
							Length
						</th>
						<th id="thMainFilter07" class="TableHdrCell">
							Color
						</th>
						<th id="thMainFilter08" class="TableHdrCell">
							Sort
						</th>
						<th id="thMainFilter09" class="TableHdrCell">
							Milling
						</th>
						<th id="thMainFilter10" class="TableHdrCell">
							NoPrint
						</th>
						<th id="thMainFilter11" class="TableHdrCell">
							Product
						</th>
					</tr>
					<tr>
						<td id="thMainFiltr200" class="StdTableCell">
							<select id="selRegionMF" multiple onchange="javascript:ChangeRegionCode(this.value);return false;">
								<option Value="0" Selected="selected">ALL</option>
								<option Value="APP">Appalachian</option>
								<option Value="GLA">Glacial</option>
								<option Value="NORTH">North</option>
								<option Value="WEST">West</option>
							</select>
						</td>
						<td id="thMainFiltr201" class="StdTableCell">
							<select id="selLocationMF" multiple class="FontNarrowish" onchange="javascript:ChangeLocationCode(this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr202" class="StdTableCell">
							<select id="selSpeciesMF" multiple class="FontNarrowish" onchange="javascript:ChangeFilterCode(0, this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr203" class="StdTableCell">
							<select id="selThickMF" multiple class="FontNarrowish" onchange="javascript:ChangeFilterCode(1, this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr204" class="StdTableCell">
							<select id="selGradeMF" multiple class="FontNarrowish" onchange="javascript:ChangeFilterCode(2, this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr205" class="StdTableCell">
							<select id="selSeasoningMF" multiple class="FontNarrowish" onchange="javascript:ChangeFilterCode(3, this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr206" class="StdTableCell">
							<select id="selLengthMF" multiple class="FontNarrowish" onchange="javascript:ChangeFilterCode(4, this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr207" class="StdTableCell">
							<select id="selColorMF" multiple class="FontNarrowish" onchange="javascript:ChangeFilterCode(5, this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr208" class="StdTableCell">
							<select id="selSortMF" multiple class="FontNarrowish" onchange="javascript:ChangeFilterCode(6, this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr209" class="StdTableCell">
							<select id="selMillingMF" multiple class="FontNarrowish" onchange="javascript:ChangeFilterCode(7, this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr210" class="StdTableCell">
							<select id="selNoPrintMF" multiple class="FontNarrowish" onchange="javascript:ChangeFilterCode(8, this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr211" class="StdTableCell">
							<select id="selProductMF" multiple class="FontNarrowish" onchange="javascript:ChangeFilterCode(9, this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="13">
							Dates:&nbsp;
							<select id="selShowScopeF" onchange="javascript:ChangeShowScope(this.value);return false;">
								<option value="1" selected="selected">Show Current Week</option>
								<option value="0">No Current Week</option>
								<option value="2">History</option>
							</select>&nbsp;&nbsp;
							<span id="spnTargetDateH" style="display:none;">
								Target&nbsp;Date:&nbsp;<input type="text" id="txtTargetDateH" style="width:86px;" />&nbsp;&nbsp;
							</span>
							
							<a href="#" onclick="javascript:ShowDebugInfo();return false;" style="color:darkgray;text-decoration:none;">&bull;</a>&nbsp;&nbsp;
							Show&nbsp;Weekends:&nbsp;<input type="checkbox" id="chkShowWeekends" onchange="javascript:ChangeWeekendView(this.checked);return false;" />&nbsp;&nbsp;&bull;&nbsp;&nbsp;View&nbsp;Type:&nbsp;
							<select id="selViewType" onchange="javascript:ChangeViewType(this.value);return false;" >
								<option value="0" selected="selected">All</option>
								<option value="1">Tactical</option>
								<option value="2">Strategic</option>
							</select>&nbsp;&nbsp;&bull;&nbsp;
							<label style="margin-left: 5px;">Show 0's:</label>&nbsp;<input type="checkbox" id="chkShowZeros" onchange="javascript:ChangeZeroValSetting(this.checked);return false;" />&nbsp;&nbsp;&bull;&nbsp;				
							<label style="margin-left: 5px;">No Empty Products:</label>&nbsp;<input type="checkbox" id="chkNoEmptyProds" onchange="javascript:ChangeNoEmptyProds(this.checked);return false;" />&nbsp;&nbsp;&bull;&nbsp;				
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
							</select>&nbsp;&nbsp;&bull;&nbsp;&nbsp;
							Saved Queries:&nbsp;
							<select id="selQueryList" onchange="javascript:LoadSavedQueryData(this.value);return false;" >
								<option value="0" selected="selected">None Selected</option>
							</select>
							Query Title:&nbsp;<input type="text" id="txtQueryTitle" style="width:140px;" />&nbsp;<button id="btnSaveQueryFormat" onclick="javascript:SaveQueryFormat();return false;" class="button blue-gradient glossy">Save</button>
						</td>
					</tr>
					<tr>
						<td colspan="13">
							<button id="btnRefreshCTData" class="button blue-gradient glossy" onclick="javascript:RefreshConsolidationData();return false;" style="width:220px;">Display Consolidation</button>
							<button id="btnTailorVisColumns" class="button blue-gradient glossy" onclick="javascript:TailorVisibleColumns();return false;" style="width:166px;margin-left:20px;">Tailor Visible Columns</button>
							<button id="btnExportToPDF" class="button green-gradient glossy" onclick="javascript:ExportToPDF();return false;" style="width:116px;margin-left:26px;">Export to PDF</button>
							<button id="btnExportToExcel" class="button green-gradient glossy" onclick="javascript:ExportToExcel();return false;" style="width:116px;margin-left:2px;">Export to Excel</button>
							<button id="btnGotoForecast" class="button blue-gradient glossy" onclick="javascript:GotoForecastPage();return false;" style="width:110px;margin-left:30px;display:none;">Goto Forecast</button>
							<button id="btnShowHelpDialog" class="button blue-gradient glossy" onclick="javascript:ShowHelpDialog();return false;" style="width:66px;margin-left:22px;">Help</button>
						</td>
					</tr>
					</table>
				</div>

			</div>

			<div id="divPAGEMAINCONTENT" style="width:99%;margin-left:10px;">
				<div id="divFCTitleHdr" style="width:100%;">
					<table style="width:100%;border:none;padding:0px;border-spacing:0px;">
					<tr>
						<td style="width:60%;">
							<label id="lblFCGridHdr" style="font-weight:bold;color:blue;font-size:13pt;">Consolidated Production Forecast</label>
							&nbsp;&nbsp;&nbsp;<span id="spnWeekNbrFV" style="color:cadetblue;font-weight:bold;font-size:12pt;">First&nbsp;Week:&nbsp;<label id="lblWeekNbr" >00</label></span>
						</td>
						<td style="width:40%;text-align:right;">
							<label id="lblNbrSeconds"></label>&nbsp;&nbsp;
						</td>
					</tr>
					</table>
				</div>
				<div id="divDataGrid" style="width:100%;">
					<table id="tblForecastConsolidation" style="padding:1px;border-spacing:0px;border-collapse:collapse;">
					<thead id="hdFCDataGrid">
					<tr>
						<th id="thHdrCol00" class="TableHdrCell" style="width:60px;">RecType</th>
						<th id="thHdrCol01" class="TableHdrCell" style="width:70px;">Region</th>
						<th id="thHdrCol02" class="TableHdrCell" style="width:70px;">Mill</th>
						<th id="thHdrCol03" class="TableHdrCell" style="width:100px;">Product</th>
						<th id="thHdrCol04" class="TableHdrCell" style="width:100px;">Thickness</th>
						<th id="thHdrCol05" class="TableHdrCell" style="width:100px;">Species</th>
						<th id="thHdrCol06" class="TableHdrCell" style="width:100px;">Grade</th>
						<th id="thHdrCol07" class="TableHdrCell" style="width:100px;">Seasoning</th>
						<th id="thHdrCol08" class="TableHdrCell" style="width:100px;">Surface</th>
						<th id="thHdrCol09" class="TableHdrCell" style="width:100px;">Length</th>
						<th id="thHdrCol10" class="TableHdrCell" style="width:100px;">Color</th>
						<th id="thHdrCol11" class="TableHdrCell" style="width:100px;">Sort</th>
						<th id="thHdrCol12" class="TableHdrCell" style="width:100px;">Milling</th>
						<th id="thHdrCol13" class="TableHdrCell" style="width:100px;">NoPrint</th>
						<th id="thHdrCol14" class="TableHdrCell" style="width:90px;background-color:#CCCCCC;border-left:double;"><label id="lblHdrWk1Dy1">Wk1Dy1</label></th>
						<th id="thHdrCol15" class="TableHdrCell" style="width:90px;background-color:#CCCCCC;"><label id="lblHdrWk1Dy2">Wk1Dy2</label></th>
						<th id="thHdrCol16" class="TableHdrCell" style="width:90px;background-color:#CCCCCC;"><label id="lblHdrWk1Dy3">Wk1Dy3</label></th>
						<th id="thHdrCol17" class="TableHdrCell" style="width:90px;background-color:#CCCCCC;"><label id="lblHdrWk1Dy4">Wk1Dy4</label></th>
						<th id="thHdrCol18" class="TableHdrCell" style="width:90px;background-color:#CCCCCC;"><label id="lblHdrWk1Dy5">Wk1Dy5</label></th>
						<th id="thHdrCol19" class="TableHdrCell" style="width:90px;background-color:aqua;"><label id="lblHdrWk1Dy6">Wk1Dy6</label></th>
						<th id="thHdrCol20" class="TableHdrCell" style="width:90px;background-color:aqua;"><label id="lblHdrWk1Dy7">Wk1Dy7</label></th>
						<th id="thHdrCol21" class="TableHdrCell" style="width:90px;background-color:#CCCCCC;border-left:double;"><label id="lblHdrWk2Dy1">Wk2Dy1</label></th>
						<th id="thHdrCol22" class="TableHdrCell" style="width:90px;background-color:#CCCCCC;"><label id="lblHdrWk2Dy2">Wk2Dy2</label></th>
						<th id="thHdrCol23" class="TableHdrCell" style="width:90px;background-color:#CCCCCC;"><label id="lblHdrWk2Dy3">Wk2Dy3</label></th>
						<th id="thHdrCol24" class="TableHdrCell" style="width:90px;background-color:#CCCCCC;"><label id="lblHdrWk2Dy4">Wk2Dy4</label></th>
						<th id="thHdrCol25" class="TableHdrCell" style="width:90px;background-color:#CCCCCC;"><label id="lblHdrWk2Dy5">Wk2Dy5</label></th>
						<th id="thHdrCol26" class="TableHdrCell" style="width:90px;background-color:aqua;"><label id="lblHdrWk2Dy6">Wk2Dy6</label></th>
						<th id="thHdrCol27" class="TableHdrCell" style="width:90px;background-color:aqua;"><label id="lblHdrWk2Dy7">Wk2Dy7</label></th>
						<th id="thHdrCol28" class="TableHdrCell" style="width:90px;border-left:double;"><label id="lblHdrWk3Dy1">Wk3</label></th>
						<th id="thHdrCol29" class="TableHdrCell" style="width:90px;"><label id="lblHdrWk4Dy1">Wk4</label></th>
						<th id="thHdrCol30" class="TableHdrCell" style="width:90px;"><label id="lblHdrWk5Dy1">Wk5</label></th>
						<th id="thHdrCol31" class="TableHdrCell" style="width:90px;"><label id="lblHdrWk6Dy1">Wk6</label></th>
						<th id="thHdrCol32" class="TableHdrCell" style="width:90px;"><label id="lblHdrWk7Dy1">Wk7</label></th>
						<th id="thHdrCol33" class="TableHdrCell" style="width:90px;"><label id="lblHdrWk8Dy1">Wk8</label></th>
						<th id="thHdrCol34" class="TableHdrCell" style="width:90px;"><label id="lblHdrWk9Dy1">Wk9</label></th>
						<th id="thHdrCol35" class="TableHdrCell" style="width:90px;"><label id="lblHdrWk10Dy1">Wk10</label></th>
						<th id="thHdrCol36" class="TableHdrCell" style="width:90px;"><label id="lblHdrWk11Dy1">Wk11</label></th>
						<th id="thHdrCol37" class="TableHdrCell" style="width:90px;"><label id="lblHdrWk12Dy1">Wk12</label></th>
						<th id="thHdrCol38" class="TableHdrCell" style="width:90px;"><label id="lblHdrWk13Dy1">Wk13</label></th>
						<th id="thHdrCol39" class="TableHdrCell" style="width:100px;border-left:double;">Total</th>
					</tr>
					</thead>
					<tfoot id="tftFCDataGrid">
					<tr>
						<td class="StdFtrCellThisPage" id="tfcell00" colspan="14" style="font-weight:bold;color:blue;background-color:#FFFFCC;">(Page) Totals</td>
						<td class="StdFtrCellThisPage" id="tfcell14" style="border-left:double;"><label id="lblTotal0">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell15"><label id="lblTotal1">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell16"><label id="lblTotal2">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell17"><label id="lblTotal3">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell18"><label id="lblTotal4">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell19" style="background-color:aqua;"><label id="lblTotal5">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell20" style="background-color:aqua;"><label id="lblTotal6">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell21" style="border-left:double;"><label id="lblTotal7">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell22"><label id="lblTotal8">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell23"><label id="lblTotal9">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell24"><label id="lblTotal10">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell25"><label id="lblTotal11">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell26" style="background-color:aqua;"><label id="lblTotal12">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell27" style="background-color:aqua;"><label id="lblTotal13">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell28" style="border-left:double;"><label id="lblTotal14">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell29"><label id="lblTotal15">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell30"><label id="lblTotal16">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell31"><label id="lblTotal17">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell32"><label id="lblTotal18">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell33"><label id="lblTotal19">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell34"><label id="lblTotal20">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell35"><label id="lblTotal21">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell36"><label id="lblTotal22">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell37"><label id="lblTotal23">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell38"><label id="lblTotal24">0</label></td>
						<td class="StdFtrCellThisPage" id="tfcell39" style="border-left:double;color:blue;font-weight:bold;border-color:gray;"><label id="lblTotal25">0</label></td>
					</tr>
					</tfoot>
					<tbody id="bdyFCDataGrid">

					</tbody>
					</table>

		<!-- #include file="../inc/incPaginationDiv.inc" -->
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
							&nbsp;<span id="spnCurrDateNV" style="color:#A0A0A0;">&nbsp;</span>&nbsp;&nbsp;Session Start:&nbsp;<span id="clockNV" style="color:#A0A0A0;">&nbsp;</span>&nbsp;
						</td>
					</tr>
					</table>
          </div>
      </footer>
    </div>

  </form>
</body>
</html>
