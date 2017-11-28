<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InventoryAnalysis.aspx.cs" Inherits="DataMngt.prod.InventoryAnalysis" %>
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
		var jbShowCurrentWeek = true;
		var jbShow0s = false;
		var jbShowWeekends = false;
		var jbtnQuickAccessPage;
		var jbViewOnly = true;
		var jchkIncludeCountsD;
		var jchkNoEmptyProds;
		var jchkShowZeros;
		var jchkShowCurrentWeek;
		var jchkShowWeekends;
		var jdivDataGrid;
		var jdToday = new Date();
		var jfPageTotal = 0;
		var jiAR = 0;
		var jiActionStatusCode = '';
		var jiActionStatusID = 0;
		var jiActionStatusMsg = '';
		var jiApprovalID = 0;
		var jiByID = 0;
		var jiNbrCols = 0;
		var jiNbrPages = 0;
		var jiNbrRows = 0;
		var jiPageID = 30;
		var jiPageNbr = 0;
		var jiPageSize = 20;
		var jiTotalRows = 0;
		var jiUserID = 0;
		var jlColSettingStatus;
		var jlGridSortS;
		var jlPageStatus;
		var jlStatusMsg;
		var jlTotal1;
		var jlTotalNbrPagesS;
		var jlTotalRowsS;
		var jsBrowserType = '';
		var jsCurrentTime = '';
		var jselColorMF;
		var jselGradeMF;
		var jselLengthMF;
		var jselLocationMF;
		var jselLocTypeMF;
		var jselMillingMF;
		var jselNoPrintMF;
		var jselPageSize;
		var jselProdTypeMF;
		var jselProductMF;
		var jselQueryList;
		var jselRegionMF;
		var jselSeasoningMF;
		var jselSortMF;
		var jselSpeciesMF;
		var jselThickMF;
		var jselViewType;
		var jselWidthMF;
		var jsErrorMsg = '';
		var jsLocationCode = '';
		var jsPageVersion = '';
		var jsPageVersDate = '';
		var jspnTargetDateH;
		var jsRegionCode = '';
		var jsStartDate = '';
		var jsToday = '';
		var jtblInventoryData;
		var jtQueryTitle;
		var jtTargetDateH;

		var jaColTotals = createArrayInitGu(35, 1);
		var jaColVisible = createArrayInitGu(40, 1);

		var MyCodeListData;
		var MyCodeListDistinct;
		var MyColumnSettings;
		var MyInventoryData;
		var MyLocations;
		var MyLocationTypes;
		var MyProductList;
		var MyProductListMini;
		var MyProductTypeList;
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
			jiPageID = 30;
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
			//alert(jiForecastUser + '/' + jigFV);
			//alert('loaded seed values');

			jchkIncludeCountsD = document.getElementById('chkIncludeCountsD');
			jchkNoEmptyProds = document.getElementById('chkNoEmptyProds');
			jchkShowCurrentWeek = document.getElementById('chkShowCurrentWeek');
			jchkShowWeekends = document.getElementById('chkShowWeekends');
			jchkShowZeros = document.getElementById('chkShowZeros');
			jdivDataGrid = document.getElementById('divDataGrid');
			jlColSettingStatus = document.getElementById('lblColSettingStatus');
			jlGridSortS = document.getElementById('lblGridSortS');
			jlPageStatus = document.getElementById('lblPageStatus');
			jlStatusMsg = document.getElementById('lblStatusMsg');
			jlTotal1 = document.getElementById('lblTotal1');
			jlTotalNbrPagesS = document.getElementById('lblTotalNbrPagesS');
			jlTotalRowsS = document.getElementById('lblTotalRowsS');
			//jlWeekNbr = document.getElementById('lblWeekNbr');
			jselColorMF = document.getElementById('selColorMF');
			jselGradeMF = document.getElementById('selGradeMF');
			jselLengthMF = document.getElementById('selLengthMF');
			jselLocationMF = document.getElementById('selLocationMF');
			jselLocTypeMF = document.getElementById('selLocTypeMF');
			jselMillingMF = document.getElementById('selMillingMF');
			jselNoPrintMF = document.getElementById('selNoPrintMF');
			jselPageSize = document.getElementById('selPageSize');
			jselProdTypeMF = document.getElementById('selProdTypeMF');
			jselProductMF = document.getElementById('selProductMF');
			jselQueryList = document.getElementById('selQueryList');
			jselRegionMF = document.getElementById('selRegionMF');
			jselSeasoningMF = document.getElementById('selSeasoningMF');
			jselSortMF = document.getElementById('selSortMF');
			jselSpeciesMF = document.getElementById('selSpeciesMF');
			jselThickMF = document.getElementById('selThickMF');
			jselViewType = document.getElementById('selViewType');
			jselWidthMF = document.getElementById('selWidthMF');
			jspnTargetDateH = document.getElementById('spnTargetDateH');
			jtblInventoryData = document.getElementById('tblInventoryData');
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
				//alert('visible');
			}
			var d = new Date();
			jiNbrRows = 0;
			jbShowCurrentWeek = true;
			jbNoEmptyProds = false;
			//alert('initiation 0');
			GetColumnSettings();
			ShowHideColumns();
			//alert('initiation 1');
			PopulateThicknessList();
			//alert('initiation 1a');
			PopulateSpeciesList();
			//alert('initiation 1b');
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
			PopulateProdTypeList();
			PopulateSeasoningList();
			PopulateLocationTypeList();
			PopulateWidthList();
			jiPageSize = 20;
			jiPgSizePj[0] = 20;
			jiPgNbrPj[0] = 0;
			jiNbrPagesPj[0] = 0;
			jiNbrPages = 0;
			jsRegionCode = '0';
			jsLocationCode = '0';
			//alert('Initiated');
			EstablishMainPgElementsPj(1, 0);
			//alert('getting queries');
			PopulateQueryList();
			// load default query
			jselQueryList.value = '0';
			if (LoadSavedQueryData('DEFAULT')) {
				//alert('setting query to default');
				setDDLSelectedByTextGu('selQueryList', jselQueryList, 'DEFAULT');
			}
			DataCall1();
			//alert('Done!');
			document.getElementById('lblNbrSeconds').innerHTML = GetNbrSeconds(d).toString() + ' seconds';
			jlPageStatus.innerHTML = 'Page Ready';
			document.getElementById('lblPageIDInFooter').innerHTML = 'Page ID: ' + jiPageID.toString();
			return false;
		}

		// **************************** AJAX FUNCTIONS *********************************

		function DataCall1() {
			jiPageNbr = jiPgNbrPj[0];
			//alert('Page ' + jiPageNbr);
			GetInventoryData();
			PopulateInventoryGrid();
			return false;
		}

		function GetDistinctCodeValues(typ) {
			MyCodeListDistinct = null;
			var reg = jselRegionMF.value;
			var loc = jselLocationMF.value;
			var loctype = jselLocTypeMF.value;
			var prod = jselProductMF.value;
			var ptype = jselProdTypeMF.value;
			var thick = jselThickMF.value;
			var spec = jselSpeciesMF.value;
			var grade = jselGradeMF.value;
			var seasoning = jselSeasoningMF.value;
			var surf = '0'; //jsel
			var wdth = '';
			var len = jselLengthMF.value;
			var len = jselLengthMF.value;
			var color = jselColorMF.value;
			var sort = jselSortMF.value;
			var milling = jselMillingMF.value;
			var noprint = jselNoPrintMF.value;
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

			var url = "../shared/GridSupportServices.asmx/SelectCodeListDistinct";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','iType':'" + typ.toString() + "','Reg':'" + reg + "','LocCode':'" + loc + "','LocType':'" + loctype + "','PCode':'" + prod + "',";
			MyData = MyData + "'PType':'" + ptype + "','Thick':'" + thick + "','Specie':'" + spec + "','Grade':'" + grade + "','Season':'" + seasoning + "','Surf':'" + surf + "','Wdth':'" + wdth + "',";
			MyData = MyData + "'Len':'" + len + "','Color':'" + color + "','fSort':'" + sort + "','Milling':'" + milling + "','NoPrint':'" + noprint + "','FuzzyGrade':'','FuzzySort':'','FuzzyProd':'',";
			MyData = MyData + "'Lvl':'" + lvl + "','Active':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCodeListDistinct = response; });
			return false;
		}

		function GetInventoryData() {
			//alert('getting inventory data');
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

			var wdth = jselWidthMF.value;
			var ptype = jselProdTypeMF.value;
			var loctype = jselLocTypeMF.value;
			var dsort = 0;

			var url = "../shared/GridSupportServices.asmx/SelectInventoryDataDetailed";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','Reg':'" + reg + "','LocCode':'" + loc + "','LocType':'" + loctype + "','PCode':'" + prod + "','PType':'" + ptype + "','Thick':'" + thick + "',";
			MyData = MyData + "'Specie':'" + spec + "','Grade':'" + grade + "','Season':'" + seasoning + "','Surf':'" + surf + "','Wdth':'" + wdth + "','Len':'" + len + "','Color':'" + color + "','fSort':'" + sort + "',";
			MyData = MyData + "'Milling':'" + milling + "','NoPrint':'" + noprint + "','FuzzyGrade':'','FuzzySort':'','FuzzyProd':'','Lvl':'" + lvl + "','Sort':'" + dsort.toString() + "','Active':'1',";
			MyData = MyData + "'PgNbr':'" + jiPgNbrPj[0].toString() + "','PgSize':'" + jiPageSize.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyInventoryData = response; });
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
			var url = "../shared/AjaxServices.asmx/SelectConsolidationLocationList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','UserID':'" + jiByID.toString() + "','LocCode':'','Region':'" + jsRegionCode + "','LocType':'MILL','Country':'US','City':'','Class':'0','Sort':'0',";
			MyData = MyData + "'Active':'2','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyLocations = response; });
			return false;
		}

		function GetLocationTypeList() {
			var url = "../shared/GridSupportServices.asmx/SelectLocationTypeList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyLocationTypes = response; });
			return false;
		}

		function GetProdTypeList(pt) {
			var region = jselRegionMF.value;
			var loc = jselLocationMF.value;
			var url = "../shared/AjaxServices.asmx/SelectProductTypesList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ProdType':'" + pt + "','Sort':'0','Active':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProductTypeList = response; });
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
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','UIType':'InvAnalys','ByID':'" + jiByID.toString() + "'}";
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
			//if (jchkShowCurrentWeek.checked === true) { showwk = 1; }
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
			//if (jchkShowWeekends.checked === true) { set1 = 1; }
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
			//alert('updating query');
			var id = 0;
			if (jselQueryList.value === '0') {
				id = 0;
			}
			else {
				id = parseInt(jselQueryList.value, 10);
			}
			var nm = jtQueryTitle.value;
			var ptype = jselProdTypeMF.value;
			//alert('A');
			var pcode = jselProductMF.value;
			var loc = jselLocationMF.value;
			var reg = jselRegionMF.value;
			var thick = jselThickMF.value;
			//alert('B');
			var spec = jselSpeciesMF.value;
			var grade = jselGradeMF.value;
			var seas = jselSeasoningMF.value;
			var surf = '';
			var stat = '';
			var wdth = '';
			//alert('C');
			var len = jselLengthMF.value;
			var color = jselColorMF.value;
			var fsort = jselSortMF.value;
			var mill = jselMillingMF.value;
			//alert('D');
			var nop = jselNoPrintMF.value;
			var itype = '0'; // jselViewType.value;
			var currwk = 0;
			//if (jchkShowCurrentWeek.checked === true) { currwk = 1; }
			var weeknd = 0;
			//if (jchkShowWeekends.checked === true) { weeknd = 1; }
			var zeros = 0;
			if (jchkShowZeros.checked === true) { zeros = 1; }
			var set0 = 0;
			var set4 = 0;
			//alert('E');
			if (jchkNoEmptyProds.checked === true) { set4 = 1; }
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
			//alert('F');

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


				var set0 = 0;
				//if (jchkShowCurrentWeek.checked === true) { set0 = 1; }
				var set1 = 0;
				//if (jchkShowWeekends.checked === true) { set1 = 1; }
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
				fillDropDownListGu(MyCodeListData, jselColorMF, 0, 'CodeDescAbbreviated', 'CatCode');
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

		function PopulateInventoryGrid() {
			//alert('Filling inventory grid');
			var bkColor = '#FFFFFF';
			var bld = false;
			var cellClass = 'StdTableCell';
			var dsabld = false;
			var frColor = '#000000';
			var fSz = '11pt';
			var nCol = 17;
			var ovrflw = 'hidden';
			var RdOnly = false;
			var NbrRows = 0;
			jiTotalRows = 0;
			jlStatusMsg.innerHTML = '';
			EmptyGridColumnTotals();
			//alert('setting column formatting');
			//ShowHideColumns();
			// Cols: 0-ProdType, 1-Product, 2-Region, 3-Loc, 4-Thickness, 5-Species, 6-Grade, 7-Seasoning, 8-Surface, 9-Width, 10-Length, 11-Color, 12-Sort, 13-Milling, 14-NoPrint, 15-UOM, 16-Quantity
			var cWidth = [50, 60, 70, 60, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 60, 90, 0, 0, 0, 0, 0];
			var corientH = ['center', 'center', 'center', 'center', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'center', 'right', '', '', '', '', '', '', ''];
			var corientV = ['top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', '', '', '', '', '', ''];
			var cbrdrL = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', ''];
			var cbrdrR = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', ''];
			var cbrdrT = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', ''];
			var cbrdrB = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', ''];
			var cnames = ['ProdType', 'ProductCode', 'Region', 'LocationCode', 'Thickness', 'Specie', 'Grade', 'Seasoning', 'Surface', 'Width', 'Length', 'Color', 'Sort', 'Milling', 'NoPrint', 'QTYUNIT', 'OHQTY', '', '', '', '', '', '', '', '', '', '', ''];
			var cType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var aggType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0]; //1-Count, 2-Sum, 3-Avg, 4-Max, 5-Min

			if (!IsContentsNullUndefinedGu(MyInventoryData)) {
				NbrRows = MyInventoryData.length;
				//alert('grid time - #: ' + MyInventoryData.length.toString());
				var bdy = FormDataGridBodyMinimumDg(1, nCol, 'tdInvAnalysisList', cellClass, false, false, false, false, '', 'button blue-gradient glossy', false, 0, MyInventoryData, 'PROGRESS_RECID', cnames, cType, cWidth, corientH, corientV, cbrdrL, cbrdrR, cbrdrT, cbrdrB, aggType, jaColVisible, true, true);
				//alert('Grid done');
				jtblInventoryData.style.display = 'block';
			}
			else {
				//alert('Comment Contact List bad data');
				ShowStatusMsg('An unidentified error occurred. No inventory records could be extracted.');
			}
			//alert('Attaching body');
			try {
				var oldBody = jtblInventoryData.getElementsByTagName("tbody")[0];
				jtblInventoryData.replaceChild(bdy, oldBody);
			}
			catch (ex) {
				alert('Data grid could not be completed because of syntax errors.');
			}

			//alert('checking nbr rows - ' + NbrRows);
			if (NbrRows === 0) {
				jlStatusMsg.innerHTML = 'No data matches that criteria.';
			}
			CalculatePageTotals();
			FillGridColumnTotals();

			//alert(jiNbrRowsPj[0] + '/' + NbrRows);
			if (jiNbrRowsPj[0] > NbrRows) {
				joPgNbrLblPj.innerHTML = (jiPgNbrPj[0] + 1).toString();
				joMaxPgNbrLblPj.innerHTML = jiNbrPagesPj[0].toString();
				joPaginationBarPj.style.display = 'block';
			}
			jlGridSortS.innerHTML = 'PT-Product-Length-Color-Sort-Milling-NoPrint';
			jlTotalNbrPagesS.innerHTML = jiNbrPagesPj[0].toString();
			jlTotalRowsS.innerHTML = jiNbrRowsPj[0].toString();
			return false;
		}

		function PopulateGradeList() {
			GetProdCodeList('Grade');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selGradeMF', 1);
				fillDropDownListGu(MyCodeListData, jselGradeMF, 0, 'CodeDescCompAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateGradeListByRegion() {
			GetProdCodeListForRegion('Grade');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selGradeMF', 1);
				fillDropDownListGu(MyCodeListData, jselGradeMF, 0, 'CodeDescCompAbbreviated', 'CatCode');
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

		function PopulateLocationTypeList() {
			GetLocationTypeList();
			if (!IsContentsNullUndefinedGu(MyLocationTypes)) {
				//alert(MyLocations.length);
				ClearDDLOptionsGu('selLocTypeMF', 1);
				fillDropDownListGu(MyLocationTypes, jselLocTypeMF, 0, 'LocationType', 'LocationType');
			}
			return false;
		}

		function PopulateMillingList() {
			GetProdCodeList('Milling');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selMillingMF', 1);
				fillDropDownListGu(MyCodeListData, jselMillingMF, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateNoPrintList() {
			GetProdCodeList('NoPrint');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selNoPrintMF', 1);
				fillDropDownListGu(MyCodeListData, jselNoPrintMF, 0, 'CodeDescCompAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateProdTypeList() {
			GetProdTypeList('');
			//alert(MyProductListMini.length);
			if (!IsContentsNullUndefinedGu(MyProductTypeList)) {
				ClearDDLOptionsGu('selProdTypeMF', 1);
				//alert('filling');
				fillDropDownListGu(MyProductTypeList, jselProdTypeMF, 0, 'ProdTypeDescAbbr', 'ProductTypeCode');
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
				fillDropDownListGu(MyCodeListData, jselNoPrintMF, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateQueryList() {
			GetUserQueryList();
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
				fillDropDownListGu(MyCodeListData, jselSeasoningMF, 0, 'CodeDescCompAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateSpeciesList() {
			GetProdCodeList('Species');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selSpeciesMF', 1);
				fillDropDownListGu(MyCodeListData, jselSpeciesMF, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateSpeciesListByRegion() {
			GetProdCodeListForRegion('Species');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selSpeciesMF', 1);
				fillDropDownListGu(MyCodeListData, jselSpeciesMF, 0, 'CodeDescCompAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateSortList() {
			GetProdCodeList('Sort');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selSortMF', 1);
				fillDropDownListGu(MyCodeListData, jselSortMF, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateThicknessList() {
			//alert('getting thickness data');
			GetProdCodeList('Thickness');
			//alert('loading data');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selThickMF', 1);
				fillDropDownListGu(MyCodeListData, jselThickMF, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateThicknessListByRegion() {
			GetProdCodeListForRegion('Thickness')
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selThickMF', 1);
				fillDropDownListGu(MyCodeListData, jselThickMF, 0, 'CodeDescCompAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateWidthList() {
			//alert('getting thickness data');
			GetProdCodeList('Width');
			//alert('loading data');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selWidthMF', 1);
				fillDropDownListGu(MyCodeListData, jselWidthMF, 0, 'CodeDescAbbreviated', 'CatCode');
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

		function ShowListDistinct(typ) {
			//alert('Building content - ' + typ.toString());
			var content = '<table style="padding:1px;border-spacing:0px;text-align:left;width:884px;"><tr><td>';
			var fig = 0;
			var ht = 320;
			var ttl = 'List of Distinct Values: ';
			var wdth = 900;
			switch (typ) {
				case 0: // Thickness
					ttl = ttl + 'Thickness';
					break;
				case 1: // Species
					ttl = ttl + 'Species';
					break;
				case 2: // Grade
					ttl = ttl + 'Grade';
					break;
				case 3: // Seasoning
					ttl = ttl + 'Seasoning';
					break;
				case 4: // surface
					ttl = ttl + 'Surface';
					break;
				case 5: // width
					ttl = ttl + 'Width';
					break;
				case 6: // Length
					ttl = ttl + 'Length';
					break;
				case 7: // Color
					ttl = ttl + 'Color';
					break;
				case 8: // Sort
					ttl = ttl + 'Sort';
					break;
				case 9: // Milling
					ttl = ttl + 'Milling';
					break;
				case 10: // NoPrint
					ttl = ttl + 'NoPrint';
					break;
				case 11: // UOM
					ttl = ttl + 'UoM';
					break;
				default:
					break;
			}
			//alert('loading data');
			GetDistinctCodeValues(typ);	// fills MyCodeListDistinct
			//alert('forming list');
			if (!IsContentsNullUndefEmptyGu(MyCodeListDistinct)) {
				var nrows = MyCodeListDistinct.length;
				//alert(nrows);
				for (var itm = 0; itm < nrows; itm++) {
					if (itm > 0) {content = content + ', ';}
					content = content + MyCodeListDistinct[itm]['DistinctValues'].toString();
					fig = parseFloat(MyCodeListDistinct[itm]['NbrItems']);
					if (jchkIncludeCountsD.checked) {
						content = content + '-' + jsfNumberFormatNf(fig, 0, '.', '');
					}
				}
			}
			else {
				content = content + 'No items were found';
			}

			content = content + '</td></tr></table>';
			//alert('displaying popup');
			ShowSpecialDialogBox1Dx('divMainPopup', ttl, true, true, ht, wdth, '', '', window, content, 'Done', '11pt', '1px', 'fadeIn', 'fadeOut', 11)
			return false;
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

		function CalculatePageTotals() {
			jfPageTotal = 0;
			if (!IsContentsNullUndefEmptyGu(MyInventoryData)) {
				for (var row = 0; row < MyInventoryData.length; row++) {
					jfPageTotal = parseFloat(MyInventoryData[row]['OHQTY']);
				}
			}
			return false;
		}

		function EmptyGridColumnTotals() {
			var okay = true;
			jfPageTotal = 0;
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
			document.getElementById('lblTotal1').innerHTML = jsfNumberFormatNf(jfPageTotal, 1, '.', ',');
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
					SelectMultipleItemsInList(MyQueryData[0]['ProType'].toString(), jselProdTypeMF);
					SelectMultipleItemsInList(MyQueryData[0]['ProductCode'].toString(), jselProductMF);
					//var itype = parseInt(MyQueryData[0]['TypeID'], 10);
					//jselViewType.value = itype;
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
					//var cwk = MyQueryData[0]['Setting1'].toString();
					//var wkend = MyQueryData[0]['Setting2'].toString();
					var zeros = MyQueryData[0]['Setting3'].toString();
					var neprods = MyQueryData[0]['Setting4'].toString();
					//alert('setting checkboxes');
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
					DataCall1();
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

		function RefreshInventoryData() {
			DataCall1();
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

	</script>

  <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />

</head>
<body>
	<img id="imgSessionKeepAlive" width="1" height="1" style="display:none;" src="../Images/clearpixel.gif" />
  <form id="Form1" runat="server">
  <asp:ScriptManager runat="server"></asp:ScriptManager>
	<asp:HiddenField ID="hfPageID" runat="server" Value="30" />

		<div id="divMainPopup" style="display:none;text-align:left;"></div>

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
					<label id="lblWebCalHdrTitle" class="LabelGridHdrStd" style="font-size:11pt;">Filters:</label>
					<label id="lblPageStatus" style="position:absolute;font-size:10pt;font-weight:bold;color:darkgray;right:70px;">Page Loading...</label>&nbsp;
				</div>
				<div id="divMainFilters" style="width:100%;text-align:center;">
					<table id="divCalFilters" style="padding:2px;border-spacing:0px;width:100%;">
					<tr>
						<th id="thMainFilter00" class="TableHdrCell">
							Region
						</th>
						<th id="thMainFilter01" class="TableHdrCell">
							Loc Type
						</th>
						<th id="thMainFilter02" class="TableHdrCell">
							Location
						</th>
						<th id="thMainFilter03" class="TableHdrCell">
							Species
						</th>
						<th id="thMainFilter04" class="TableHdrCell">
							Thickness
						</th>
						<th id="thMainFilter05" class="TableHdrCell">
							Grade
						</th>
						<th id="thMainFilter06" class="TableHdrCell">
							Seasoning
						</th>
						<th id="thMainFilter07" class="TableHdrCell">
							Width
						</th>
						<th id="thMainFilter08" class="TableHdrCell">
							Length
						</th>
						<th id="thMainFilter09" class="TableHdrCell">
							Color
						</th>
						<th id="thMainFilter10" class="TableHdrCell">
							Sort
						</th>
						<th id="thMainFilter11" class="TableHdrCell">
							Milling
						</th>
						<th id="thMainFilter12" class="TableHdrCell">
							NoPrint
						</th>
						<th id="thMainFilter13" class="TableHdrCell">
							Prod Type
						</th>
						<th id="thMainFilter14" class="TableHdrCell">
							Product
						</th>
					</tr>
					<tr style="font-family:'Arial Narrow', 'Franklin Gothic Medium', Arial, sans-serif;font-size:10pt;">
						<td id="thMainFiltr200" class="StdTableCell">
							<select id="selRegionMF" multiple onchange="javascript:ChangeRegionCode(this.value);return false;">
								<option Value="0" Selected="selected">ALL</option>
								<option Value="APP">App</option>
								<option Value="GLA">Glacial</option>
								<option Value="NORTH">North</option>
								<option Value="WEST">West</option>
							</select>
						</td>
						<td id="thMainFiltr201" class="StdTableCell">
							<select id="selLocTypeMF" multiple class="FontNarrowish" onchange="javascript:ChangeFilterCode(10, this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr202" class="StdTableCell">
							<select id="selLocationMF" multiple class="FontNarrowish" onchange="javascript:ChangeLocationCode(this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr203" class="StdTableCell">
							<select id="selSpeciesMF" multiple class="FontNarrowish" onchange="javascript:ChangeFilterCode(0, this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr204" class="StdTableCell">
							<select id="selThickMF" multiple class="FontNarrowish" onchange="javascript:ChangeFilterCode(1, this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr205" class="StdTableCell">
							<select id="selGradeMF" multiple class="FontNarrowish" onchange="javascript:ChangeFilterCode(2, this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr206" class="StdTableCell">
							<select id="selSeasoningMF" multiple class="FontNarrowish" onchange="javascript:ChangeFilterCode(3, this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr207" class="StdTableCell">
							<select id="selWidthMF" multiple class="FontNarrowish" onchange="javascript:ChangeFilterCode(4, this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr208" class="StdTableCell">
							<select id="selLengthMF" multiple class="FontNarrowish" onchange="javascript:ChangeFilterCode(4, this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr209" class="StdTableCell">
							<select id="selColorMF" multiple class="FontNarrowish" onchange="javascript:ChangeFilterCode(5, this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr210" class="StdTableCell">
							<select id="selSortMF" multiple class="FontNarrowish" onchange="javascript:ChangeFilterCode(6, this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr211" class="StdTableCell">
							<select id="selMillingMF" multiple class="FontNarrowish" onchange="javascript:ChangeFilterCode(7, this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr212" class="StdTableCell">
							<select id="selNoPrintMF" multiple class="FontNarrowish" onchange="javascript:ChangeFilterCode(8, this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr213" class="StdTableCell">
							<select id="selProdTypeMF" multiple class="FontNarrowish" onchange="javascript:ChangeFilterCode(11, this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr214" class="StdTableCell">
							<select id="selProductMF" multiple class="FontNarrowish" onchange="javascript:ChangeFilterCode(9, this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="14" style="text-align:center;">
							<div id="divFilterElementsTop" style="margin-bottom:6px;">
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
									<option value="150" >150</option>
								</select>&nbsp;&nbsp;&nbsp;&bull;&nbsp;&nbsp;
								Saved Queries:&nbsp;
								<select id="selQueryList" onchange="javascript:LoadSavedQueryData(this.value);return false;" >
									<option value="0" selected="selected">None Selected</option>
								</select>&nbsp;&nbsp;
								Query Title:&nbsp;<input type="text" id="txtQueryTitle" style="width:140px;" />&nbsp;<button id="btnSaveQueryFormat" onclick="javascript:SaveQueryFormat();return false;" class="button blue-gradient glossy">Save</button>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="14" style="text-align:center;">
							<div id="divFilterElementsBottom">
								<button id="btnRefreshCTData" class="button blue-gradient glossy" onclick="javascript:RefreshInventoryData();return false;" style="width:200px;">Refresh Data</button>
								<button id="btnTailorVisColumns" class="button blue-gradient glossy" onclick="javascript:TailorVisibleColumns();return false;" style="width:166px;margin-left:20px;">Tailor Visible Columns</button>
								<button id="btnExportToPDF" class="button green-gradient glossy" onclick="javascript:ExportToPDF();return false;" style="width:116px;margin-left:26px;">Export to PDF</button>
								<button id="btnExportToExcel" class="button green-gradient glossy" onclick="javascript:ExportToExcel();return false;" style="width:116px;margin-left:2px;">Export to Excel</button>
								<button id="btnShowHelpDialog" class="button blue-gradient glossy" onclick="javascript:ShowHelpDialog();return false;" style="width:66px;margin-left:22px;">Help</button>
							</div>
						</td>
					</tr>
					</table>
				</div>

			</div>

			<div id="divPAGEMAINCONTENT" style="width:99%;margin-left:10px;text-align:center;">
				<div id="divDataGridHolder" style="text-align:center;">
					<div id="divFCTitleHdr" style="width:100%;">
						<table style="width:100%;border:none;padding:0px;border-spacing:0px;">
						<tr>
							<td style="width:60%;text-align:center;">
								<label id="lblFCGridHdr" style="font-weight:bold;color:blue;font-size:13pt;">Detailed Inventory Data:</label>
							</td>
							<td style="width:40%;text-align:right;">
								<label id="lblNbrSeconds"></label>&nbsp;&nbsp;
							</td>
						</tr>
						</table>
					</div>
					<div id="divDataGrid" style="width:100%;text-align:center;">
						<table style="margin: auto auto;"><tr><td>
							<table id="tblInventoryData" style="padding:1px;border-spacing:0px;border-collapse:collapse;margin: auto auto;">
							<thead id="hdMainDataGrid">
							<tr>
								<th id="thHdrCol00" class="TableHdrCell" style="width:50px;">P/Type</th>
								<th id="thHdrCol03" class="TableHdrCell" style="width:60px;">Product</th>
								<th id="thHdrCol01" class="TableHdrCell" style="width:70px;">Region</th>
								<th id="thHdrCol02" class="TableHdrCell" style="width:60px;">Location</th>
								<th id="thHdrCol04" class="TableHdrCell" style="width:90px;">Thickness</th>
								<th id="thHdrCol05" class="TableHdrCell" style="width:90px;">Species</th>
								<th id="thHdrCol06" class="TableHdrCell" style="width:90px;">Grade</th>
								<th id="thHdrCol07" class="TableHdrCell" style="width:90px;">Seasoning</th>
								<th id="thHdrCol08" class="TableHdrCell" style="width:90px;">Surface</th>
								<th id="thHdrCol09" class="TableHdrCell" style="width:90px;">Width</th>
								<th id="thHdrCol10" class="TableHdrCell" style="width:90px;">Length</th>
								<th id="thHdrCol11" class="TableHdrCell" style="width:90px;">Color</th>
								<th id="thHdrCol12" class="TableHdrCell" style="width:90px;">Sort</th>
								<th id="thHdrCol13" class="TableHdrCell" style="width:90px;">Milling</th>
								<th id="thHdrCol14" class="TableHdrCell" style="width:90px;">NoPrint</th>
								<th id="thHdrCol15" class="TableHdrCell" style="width:60px;background-color:#CCCCCC;"><label id="lblHdrWk1Dy1">UOM</label></th>
								<th id="thHdrCol16" class="TableHdrCell" style="width:90px;background-color:#CCCCCC;"><label id="lblHdrWk1Dy2">Quantity</label></th>
							</tr>
							</thead>
							<tfoot id="tftFCDataGrid">
							<tr>
								<td class="StdFtrCellThisPage" id="tfcell00" colspan="16" style="font-weight:bold;color:blue;background-color:#FFFFCC;">(Page) Totals</td>
								<td class="StdFtrCellThisPage" id="tfcell16"><label id="lblTotal1">0</label></td>
							</tr>
							<tr>
								<td id="thFtrCol200" style="width:50px;border:none;" colspan="4">&nbsp;</td>
								<td id="thFtrCol204" style="width:90px;border:none;"><a href="#" onclick="ShowListDistinct(0);return false;">Distinct</a></td>
								<td id="thFtrCol205" style="width:90px;border:none;"><a href="#" onclick="ShowListDistinct(1);return false;">Distinct</a></td>
								<td id="thFtrCol206" style="width:90px;border:none;"><a href="#" onclick="ShowListDistinct(2);return false;">Distinct</a></td>
								<td id="thFtrCol207" style="width:90px;border:none;"><a href="#" onclick="ShowListDistinct(3);return false;">Distinct</a></td>
								<td id="thFtrCol208" style="width:90px;border:none;"><a href="#" onclick="ShowListDistinct(4);return false;">Distinct</a></td>
								<td id="thFtrCol209" style="width:90px;border:none;"><a href="#" onclick="ShowListDistinct(5);return false;">Distinct</a></td>
								<td id="thFtrCol210" style="width:90px;border:none;"><a href="#" onclick="ShowListDistinct(6);return false;">Distinct</a></td>
								<td id="thFtrCol211" style="width:90px;border:none;"><a href="#" onclick="ShowListDistinct(7);return false;">Distinct</a></td>
								<td id="thFtrCol212" style="width:90px;border:none;"><a href="#" onclick="ShowListDistinct(8);return false;">Distinct</a></td>
								<td id="thFtrCol213" style="width:90px;border:none;"><a href="#" onclick="ShowListDistinct(9);return false;">Distinct</a></td>
								<td id="thFtrCol214" style="width:90px;border:none;"><a href="#" onclick="ShowListDistinct(10);return false;">Distinct</a></td>
								<td id="thFtrCol215" style="width:60px;border:none;"><a href="#" onclick="ShowListDistinct(11);return false;">Distinct</a></td>
								<td id="thFtrCol216" style="width:90px;border:none;vertical-align:middle;text-align:right;">Inc.Counts<input type="checkbox" id="chkIncludeCountsD" /></td>
							</tr>
							</tfoot>
							<tbody id="bdyFCDataGrid">

							</tbody>
							</table>
						</td></tr></table>
	<!-- #include file="../inc/incPaginationDiv.inc" -->
					</div>

					<div id="divDataGridSummary" style="width:100%;text-align:center;margin-top:10px;">
						Total&nbsp;number&nbsp;of&nbsp;rows&nbsp;in&nbsp;query:&nbsp;<label id="lblTotalRowsS" style="color:blue;font-weight:bold;"></label>&nbsp;&nbsp;&nbsp;
						Total&nbsp;number&nbsp;of&nbsp;pages:&nbsp;<label id="lblTotalNbrPagesS" style="color:blue;font-weight:bold;"></label>&nbsp;&nbsp;&nbsp;
						Sort:&nbsp;<label id="lblGridSortS" style="color:blue;font-weight:bold;"></label>&nbsp;&nbsp;&nbsp;
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
