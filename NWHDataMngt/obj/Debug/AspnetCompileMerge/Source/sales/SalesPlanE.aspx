<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SalesPlanE.aspx.cs" Inherits="DataMngt.sales.SalesPlanE"  EnableSessionState="false" %>

<%@ Register Src="~/tools/ctlButtonBarNoSess.ascx" TagName="BtnBar1" TagPrefix="bb1"  %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta http-equiv="X-UA-Compatible" content="IE=10; IE=9; IE=8; IE=7; IE=EDGE" />
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

			.TableHdrCellPgTop
			{
				background-color: #8FD8D8;
				text-align:center;
				vertical-align: middle;
				color:#565051;
				border-left: 1px solid Gray;
				border-right: 1px solid Gray;
				border-top: 1px solid Gray;
				padding-left:2px;
				padding-right:2px;
			}

			.TableHdrCellPgBottom
			{
				background-color: #8FD8D8;
				text-align:center;
				vertical-align: middle;
				color:#565051;
				border-left: 1px solid Gray;
				border-right: 1px solid Gray;
				border-bottom: 1px solid Gray;
				padding-left:2px;
				padding-right:2px;
			}

	</style>

	<script type="text/javascript">
		var jbA = false;
		var jbAllLocations = false;
		var jbDoProdTotals = true;
		var jbIncCustomers = false;
		var jbIncForecast = true;
		var jbIncHolds = false;
		var jbIncHistory = true;
		var jbPaginate = false;
		var jbPriceAnalysisBasic = false;
		var jbShow0s = false;
		var jbSubtotalColor = false;
		var jbSubtotalGrade = false;
		var jbSubtotalNoPrint = false;
		var jbSubtotalProd = true;
		var jbSubtotalProdAs = false;
		var jbSubtotalSort = false;
		var jbSubtotalSpecies = false;
		var jbSubtotalThick = false;
		var jbViewOnly = true;
		var jchkIncCustomers;
		var jchkIncForecast;
		var jchkIncHistory;
		var jchkIncHolds;
		var jchkShowZeros;
		var jchkSubtotalColor;
		var jchkSubtotalGrade;
		var jchkSubtotalNoPrint;
		var jchkSubtotalProducts;
		var jchkSubtotalProdAttribs;
		var jchkSubtotalSort;
		var jchkSubtotalSpecies;
		var jchkSubtotalThickness;
		var jdivMainSalesGrid;
		var jdivPriceAnalysisGrid;
		var jdivPriceAnalysisShipped;
		var jdivPriceAnalysisSummary;
		var jdToday = new Date();
		var jhfCustCode;
		var jiAR = 0;
		var jiActionStatusCode = '';
		var jiActionStatusID = 0;
		var jiActionStatusMsg = '';
		var jiApprovalID = 0;
		var jiByID = 0;
		var jiDataType = 0;
		var jiNbrCols = 25;
		var jiNbrColsSection1 = 14;
		var jiNbrColsFilter1 = 14;
		var jiNbrCustomers = 0;
		var jiNbrRows = 0;
		var jiNbrTypes = 0;
		var jiPageID = 58;
		var jiPageNbr = 0;
		var jiPageSize = 0;
		var jiPriceAnalysisView = 0;
		var jiProdOrSales = 0;
		var jiQueryID = 0;
		var jiTotalRows = 0;
		var jiUserID = 0;
		var jiViewType = 0;
		var jlPageStatus;
		var jlStatusMsg;
		var jsBrowserType = '';
		var jsCurrentTime = '';
		var jselColorMF;
		var jselCustomerPAF;
		var jselDataTypes;
		var jselGradeMF;
		var jselGroupSortBy;
		var jselItemsPerPage;
		var jselLengthMF;
		var jselLocationMF;
		var jselManagedMain;
		var jselManagerMF;
		var jselManagerPAF;
		var jselMillingMF;
		var jselNoPrintMF;
		var jselPageSize;
		var jselPriceAnalDisplayFormat;
		var jselPriceAnalSumBy;
		var jselPriceAnalysisShipped;
		var jselPriceAnalysisSpecies;
		var jselProductMF;
		var jselQueryList;
		var jselRegionMF;
		var jselSeasoningMF;
		var jselSellerPAF;
		var jselSortMF;
		var jselSourcePAF;
		var jselSpeciesMF;
		var jselSubtotalType;
		var jselTargetMonth;
		var jselTargetYear;
		var jselThickMF;
		var jselTypeMain;
		var jselViewType;
		var jsErrorMsg = '';
		var jsLocationCode = '';
		var jsManagedType = '0';
		var jsPageVersDate = '';
		var jsPageVersion = '';
		var jspnCustomerF;
		var jspnManagerF;
		var jspnSellerF;
		var jspnSourceF;
		var jspnSubTotBlockGrade;
		var jspnSubTotBlockProd;
		var jspnSubTotBlockProdA;
		var jspnSubTotBlockSpecie;
		var jspnSubTotBlockThick;
		var jsProdType = 'HD';
		var jsToday = '';
		var jtblMainDataGrid;
		var jtblPriceAnalShipped;
		var jtblPriceAnalysis;
		var jtblPriceAnalysisSummary;
		var jtFilterColGrade;
		var jtFilterColSort;
		var jtFilterColProd;
		var jtFilterColMgr;
		var jtFilterColCust;
		var jtFilterCustDD;
		var jtQueryTitle;
		var julCustomerMF;

		var jaColTotals = createArrayInitGu(35, 1);
		var jfColColorTotals = createArrayInitGu(30, 1);
		var jfColGradeTotals = createArrayInitGu(30, 1);
		var jfColNoPrintTotals = createArrayInitGu(30, 1);
		var jfColProdTotals = createArrayInitGu(30, 1);
		var jfColSKUTotals = createArrayInitGu(30, 1);
		var jfColSortTotals = createArrayInitGu(30, 1);
		var jfColSpeciesTotals = createArrayInitGu(30, 1);
		var jfColThickTotals = createArrayInitGu(30, 1);
		var jaColVisible = createArrayInitGu(40, 1);
		var jaColVisiblePA1 = createArrayInitGu(40, 1);
		var jaColVisiblePA2 = createArrayInitGu(40, 1);
		var jaFilterVisible = createArrayInitGu(20, 1);

		var MyCodeList;
		var MyCodeListData;
		var MyColumnSettings;
		var MyCustomerData;
		var MyFilterSettings;
		var MyLocations;
		var MyMainGridData;
		var MyProductList;
		var MyProductListMini;
		var MyQueryData;
		var MyQueryList;
		var MyReturn;
		var MySalesManagers;
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
			jiPageID = 58;
			jsPageVersion = '1.0.0';
			jsPageVersDate = '8/8/2016';
			jbViewOnly = true;
			// Load global page-loaded variables
			jiByID = jigEmpID;
			jsBrowserType = jsgBrowserType;
			//alert(jsBrowserType);
			if (jsgAr > 4 || jgA === 1) {
				jbA = true;
				//alert('Admin');
			}
			jsErrorMsg = jsgError;

			$('#Form1').on("submit", function (evt) {
				evt.preventDefault();
			});

			jchkIncCustomers = document.getElementById('chkIncludeCustomers');
			jchkIncForecast = document.getElementById('chkIncludeForescast');
			jchkIncHistory = document.getElementById('chkIncludeHistory');
			jchkIncHolds = document.getElementById('chkIncludeHolds');
			jchkShowZeros = document.getElementById('chkShowZeros');
			jchkSubtotalColor = document.getElementById('chkSubtotalColor');
			jchkSubtotalGrade = document.getElementById('chkSubtotalGrade');
			jchkSubtotalNoPrint = document.getElementById('chkSubtotalNoPrint');
			jchkSubtotalProducts = document.getElementById('chkSubtotalProducts');
			jchkSubtotalProdAttribs = document.getElementById('chkSubtotalProdAttribs');
			jchkSubtotalSort = document.getElementById('chkSubtotalSort');
			jchkSubtotalSpecies = document.getElementById('chkSubtotalSpecies');
			jchkSubtotalThickness = document.getElementById('chkSubtotalThickness');
			jdivMainSalesGrid = document.getElementById('divMainSalesGrid');
			jdivPriceAnalysisGrid = document.getElementById('divPriceAnalysisGrid');
			jdivPriceAnalysisShipped = document.getElementById('divPriceAnalysisShipped');
			jdivPriceAnalysisSummary = document.getElementById('divPriceAnalysisSummary');
			jhfCustCode = document.getElementById('hfCustomerCode');
			jlPageStatus = document.getElementById('lblPageStatus');
			jlStatusMsg = document.getElementById('lblStatusMsg');
			jselColorMF = document.getElementById('selColorMF');
			jselDataTypes = document.getElementById('selDataTypes');
			jselGradeMF = document.getElementById('selGradeMF');
			jselGroupSortBy = document.getElementById('selGroupSortBy');
			jselItemsPerPage = document.getElementById('selItemsPerPage');
			jselLengthMF = document.getElementById('selLengthMF');
			jselLocationMF = document.getElementById('selLocationMF');
			jselManagedMain = document.getElementById('selManagedMain');
			jselManagerMF = document.getElementById('selManagerMF');
			jselManagerPAF = document.getElementById('selManagerPAF');
			jselMillingMF = document.getElementById('selMillingMF');
			jselNoPrintMF = document.getElementById('selNoPrintMF');
			jselPageSize = document.getElementById('selPageSize');
			jselPriceAnalDisplayFormat = document.getElementById('selPriceAnalDisplayFormat');
			jselPriceAnalSumBy = document.getElementById('selPriceAnalSumBy');
			jselPriceAnalysisSpecies = document.getElementById('selPriceAnalysisSpecies');
			jselProductMF = document.getElementById('selProductMF');
			jselQueryList = document.getElementById('selQueryList');
			jselRegionMF = document.getElementById('selRegionMF');
			jselSeasoningMF = document.getElementById('selSeasoningMF');
			jselSellerPAF = document.getElementById('selSellerPAF');
			jselSortMF = document.getElementById('selSortMF');
			jselSpeciesMF = document.getElementById('selSpeciesMF');
			jselSubtotalType = document.getElementById('selSubtotalType');
			jselTargetMonth = document.getElementById('selTargetMonth1');
			jselTargetYear = document.getElementById('selTargetYear1');
			jselThickMF = document.getElementById('selThickMF');
			jselTypeMain = document.getElementById('selTypeMain');
			//jselViewType = document.getElementById('selViewType');
			jspnCustomerF = document.getElementById('spnCustomerF');
			jspnManagerF = document.getElementById('spnManagerF');
			jspnSellerF = document.getElementById('spnSellerF');
			jspnSourceF = document.getElementById('spnSourceF');
			jspnSubTotBlockGrade = document.getElementById('spnSubtotalBlockGrade');
			jspnSubTotBlockProd = document.getElementById('spnSubtotalBlockProd');
			jspnSubTotBlockProdA = document.getElementById('spnSubtotalBlockProdA');
			jspnSubTotBlockSpecie = document.getElementById('spnSubtotalBlockSpecies');
			jspnSubTotBlockThick = document.getElementById('spnSubtotalBlockThick');
			jtblMainDataGrid = document.getElementById('tblMainDataGrid');
			jtblPriceAnalShipped = document.getElementById('tblPriceAnalShipped');
			jtblPriceAnalysis = document.getElementById('tblPriceAnalysis');
			jtblPriceAnalysisSummary = document.getElementById('tblPriceAnalysisSummary');
			jtFilterColGrade = document.getElementById('txtFilterColGrade');
			jtFilterColSort = document.getElementById('txtFilterColSort');
			jtFilterColProd = document.getElementById('txtFilterColProd');
			jtFilterColMgr = document.getElementById('txtFilterColMgr');
			jtFilterColCust = document.getElementById('txtFilterColCust');
			jtFilterCustDD = document.getElementById('txtFilterCustDD');
			jtQueryTitle = document.getElementById('txtQueryTitle');
			julCustomerMF = document.getElementById('ulCustomerMF');

			PageInitiation();
			return false;
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

		function PageInitiation() {
			//alert('Starting page initiation');
			GetColumnViewSettings();
			ShowHideColumns();
			GetFilterViewSettings();
			//alert('hidding filters');
			ShowHideFilters();
			//ChangeProdType('HD');
			jiDataType = 0;
			jiPageNbr = 0;
			jiPagSize = 20;
			//alert('beginning initiation');
			jiNbrRows = 0;
			FillGridCalDates();
			//alert('initiation 0');
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
			//alert('initiation 5');
			PopulateSeasoningList();
			//alert('initiation 6');
			PopulateSalesMgrList();
			//alert('initiation 7');
			GetCustomerList('');
			//PopulateCustomerList();
			//LoadCustDynamicList();
			//SetTextBoxAutoCompleteWc('txtFilterCustDD', 3, jhfCustCode);
			SetTextBoxAutoComplete2Wc('txtFilterCustDD', 3, jhfCustCode, MyCustomerData, 'cust', 'CustName');
			//alert('initiation 8');

			jiPageSize = 20;
			jiPgSizePj[0] = 20;
			jiPgNbrPj[0] = 0;
			jiNbrPagesPj[0] = 0;
			jiNbrPages = 0;
			jsRegionCode = '0';
			jsLocationCode = '0';
			//alert('Initiated');
			EstablishMainPgElementsPj(1, 0);
			PopulateQueryList();

			alert('Calendar data');
			var Yr = jdToday.getFullYear();
			var Mo = jdToday.getMonth() + 1;
			document.getElementById('selTargetYear1').value = Yr.toString();
			//document.getElementById('selTargetYear2').value = Yr.toString();
			document.getElementById('selTargetMonth1').value = Mo.toString();
			//document.getElementById('selTargetMonth2').value = Mo.toString();
			document.getElementById('lblPriceAnalysisMo1').innerHTML = jaDMmonthNames[Mo - 1].toString();
			if (Mo < 12) {
				document.getElementById('lblPriceAnalysisMo2').innerHTML = jaDMmonthNames[Mo].toString();
			}
			else {
				document.getElementById('lblPriceAnalysisMo2').innerHTML = jaDMmonthNames[0].toString();
			}
			if (Mo+1 < 12) {
				document.getElementById('lblPriceAnalysisMo3').innerHTML = jaDMmonthNames[Mo + 1].toString();
			}
			else {
				document.getElementById('lblPriceAnalysisMo3').innerHTML = jaDMmonthNames[1].toString();
			}
			alert('part 2');
			if (Mo + 2 < 12) {
				document.getElementById('lblPriceAnalysisMo4').innerHTML = jaDMmonthNames[Mo + 2].toString();
			}
			else {
				document.getElementById('lblPriceAnalysisMo4').innerHTML = jaDMmonthNames[2].toString();
			}
			if (Mo + 3 < 12) {
				document.getElementById('lblPriceAnalysisMo5').innerHTML = jaDMmonthNames[Mo + 3].toString();
			}
			else {
				document.getElementById('lblPriceAnalysisMo5').innerHTML = jaDMmonthNames[3].toString();
			}

			alert('loading default query');
			// load default query
			jselQueryList.value = '0';
			if (LoadSavedQueryData('DEFAULT')) {
				setDDLSelectedByTextGu('selQueryList', jselQueryList, 'DEFAULT');
			}

			jlPageStatus.innerHTML = 'Page Ready';
			return false;
		}

		// ****************************** AJAX *************************************

		function DataCall1() {
			jiPageNbr = jiPgNbrPj[0];
			//alert('Page ' + jiPageNbr);
			EmptyGridColumnTotals();
			GetProductsGridData();
			PopulateSalesGrid();
			return false;
		}

		function GetProductsGridData() {
			jlStatusMsg.innerHTML = '';
			jiNbrTypes = 0;
			//if (jc)
			var ptype = jselTypeMain.value;
			//var prod = jselProductMF.value;
			var salesorprod = findRadioSelectionGu('radSalesOrProd');
			var inccust = 0;
			var incforecast = 0;
			var inchold = 0;
			var inchist = 0;
			var incsales = 0;
			var incprod = 0;
			var incProdHist = 0;
			if (salesorprod !== 2) { incsales = 1; }
			if (salesorprod !== 1) { incprod = 1; }
			if (jchkIncCustomers.checked === true) { inccust = 1; }
			if (jchkIncForecast.checked === true) { incforecast = 1; }
			if (jchkIncHistory.checked === true) { inchist = 1; }
			if (jchkIncHolds.checked === true) { inchold = 1; }
			var color = jselColorMF.value;
			var cust = GetCustomerCodeList();
			var grade = jselGradeMF.value
			var sortby = jselGroupSortBy.value;
			var loc = jselLocationMF.value;
			var mg = jselManagedMain.value;
			var mgr = jselManagerMF.value;
			var nop = jselNoPrintMF.value;
			var prod = jselProductMF.value;
			var reg = jselRegionMF.value;
			var fsort = jselSortMF.value;
			var spec = jselSpeciesMF.value;
			var thick = jselThickMF.value;
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

			var fuzzygrade = jtFilterColGrade.value.replace('%', '').replace('*', '');
			var fuzzysort = jtFilterColSort.value.replace('%', '').replace('*', '');
			var fuzzyprod = jtFilterColProd.value.replace('%', '').replace('*', '');
			var fuzzymgr = jtFilterColMgr.value.replace('%', '').replace('*', '');
			var fuzzycust = jtFilterColCust.value.replace('%', '').replace('*', '');
			var custcode = jhfCustCode.value;
			if (custcode === '0') { custcode = ''; }
			if (incsales === 1 || inccust === 1 || incprod === 1 || inchold === 1 || incProdHist === 1) {
				if (ritems.length < jiNbrCols) { ritems = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'; }
				var url = "../shared/AjaxServices.asmx/SelectSalesPlanGridData";
				var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','Reg':'" + reg + "','Loc':'" + loc + "','PType':'" + ptype + "','Prod':'" + prod + "','Thick':'" + thick + "','Spec':'" + spec + "',";
				MyData = MyData + "'Grade':'" + grade + "','Season':'','Surf':'','Len':'','Color':'" + color + "','FSort':'" + fsort + "','Milling':'','NoPrint':'" + nop + "','Cust':'" + cust + "','Mgr':'" + mgr + "',";
				MyData = MyData + "'IncInven':'" + incprod.toString() + "','IncSales':'" + incsales.toString() + "','IncForecast':'" + incforecast.toString() + "','IncHolds':'" + inchold.toString() + "',";
				MyData = MyData + "'IncProd':'" + incprod.toString() + "','IncCust':'" + inccust.toString() + "','IncHist':'" + inchist.toString() + "','IncPHist':'" + incProdHist.toString() + "','RollupItems':'" + ritems + "',";
				MyData = MyData + "'Sort':'0','FuzzyGrade':'" + fuzzygrade + "','FuzzySort':'" + fuzzysort + "','FuzzyProd':'" + fuzzyprod + "','FuzzyMgr':'" + fuzzymgr + "','FuzzyCust':'" + fuzzycust + "',";
				MyData = MyData + "'CustCode':'" + custcode + "','PgNbr':'" + jiPgNbrPj[0].toString() + " ','PgSize':'" + jiPageSize.toString() + "','ByID':'" + jiByID.toString() + "'}";
				//alert(MyData);
				getJSONReturnDataAs(url, MyData, function (response)
				{ MyMainGridData = response; });
				return true;
			}
			else {
				alert('No data can be returned because no data is selected for inclusion.');
				return false;
			}

		}

		function ExportProductsGridData() {
			jiNbrTypes = 0;
			//if (jc)
			var ptype = jselTypeMain.value;
			//var prod = jselProductMF.value;
			var salesorprod = findRadioSelectionUt('radSalesOrProd');
			var inccust = 0;
			var inchold = 0;
			var inchist = 0;
			var incsales = 0;
			var incprod = 0;
			var incProdHist = 0;
			if (salesorprod !== 2) { incsales = 1; }
			if (salesorprod !== 1) { incprod = 1; }
			if (jchkIncCustomers.checked === true) { inccust = 1; }
			if (jchkIncHistory.checked === true) { inchist = 1; }
			if (jchkIncHolds.checked === true) { inchold = 1; }
			var color = jselColorMF.value;
			var cust = GetCustomerCodeList();
			var grade = jselGradeMF.value
			var sortby = jselGroupSortBy.value;
			var loc = jselLocationMF.value;
			var mg = jselManagedMain.value;
			var mgr = jselManagerMF.value;
			var nop = jselNoPrintMF.value;
			var prod = jselProductMF.value;
			var reg = jselRegionMF.value;
			var fsort = jselSortMF.value;
			var spec = jselSpeciesMF.value;
			var thick = jselThickMF.value;
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

			var fuzzygrade = jtFilterColGrade.value.replace('%', '').replace('*', '');
			var fuzzysort = jtFilterColSort.value.replace('%', '').replace('*', '');
			var fuzzyprod = jtFilterColProd.value.replace('%', '').replace('*', '');
			var fuzzymgr = jtFilterColMgr.value.replace('%', '').replace('*', '');
			var fuzzycust = jtFilterColCust.value.replace('%', '').replace('*', '');
			var custcode = jhfCustCode.value;
			if (custcode === '0') { custcode = ''; }
			if (incsales === 1 || inccust === 1 || incprod === 1 || inchold === 1 || incProdHist === 1) {
				if (ritems.length < jiNbrCols) { ritems = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'; }
				var url = "../shared/AjaxServices.asmx/SelectSalesPlanGridDataExport";
				var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','Reg':'" + reg + "','Loc':'" + loc + "','PType':'" + ptype + "','Prod':'" + prod + "','Thick':'" + thick + "','Spec':'" + spec + "',";
				MyData = MyData + "'Grade':'" + grade + "','Season':'','Surf':'','Len':'','Color':'" + color + "','FSort':'" + fsort + "','Milling':'','NoPrint':'" + nop + "','Cust':'" + cust + "','Mgr':'" + mgr + "',";
				MyData = MyData + "'IncInven':'" + incprod.toString() + "','IncSales':'" + incsales.toString() + "','IncHolds':'" + inchold.toString() + "','IncProd':'" + incprod.toString() + "','IncCust':'" + inccust.toString() + "',";
				MyData = MyData + "'IncHist':'" + inchist.toString() + "','IncPHist':'" + incProdHist.toString() + "','RollupItems':'" + ritems + "','Sort':'0','FuzzyGrade':'" + fuzzygrade + "','FuzzySort':'" + fuzzysort + "',";
				MyData = MyData + "'FuzzyProd':'" + fuzzyprod + "','FuzzyMgr':'" + fuzzymgr + "','FuzzyCust':'" + fuzzycust + "','CustCode':'" + custcode + "','PgNbr':'" + jiPgNbrPj[0].toString() + " ','PgSize':'" + jiPageSize.toString() + "',";
				MyData = MyData + "'ByID':'" + jiByID.toString() + "'}";
				alert(MyData);
				getJSONReturnDataAs(url, MyData, function (response)
				{ MyMainGridData = response; });
				return true;
			}
			else {
				alert('No data can be returned because no data is selected for inclusion.');
				return false;
			}

		}

		function GetCodeList(typ) {
			var url = "../shared/AjaxServices.asmx/GetCatCodeList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'2','CodeType':'" + typ.toString() + "','Sort':'0','Active':'1','UserList':'0', 'NoBlank':'1','Shown':'0','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCodeList = response; });
			return false;
		}

		function GetColumnViewSettings() {
			//alert('start 1');
			var typ = 'SPlnCols';
			if (jiDataType === 1 || jiDataType === 2) { typ = 'PriceAnGd1'; }
			if (jiDataType === 3) { typ = 'PriceAnGd2'; }
			var url = "../shared/AjaxServices.asmx/SelectUserInterfaceItems";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'2','UIType':'" + typ + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyColumnSettings = response; });
			if (MyColumnSettings !== undefined && MyColumnSettings !== null) {
				if (MyColumnSettings.length > 0) {
					for (var row = 0; row < MyColumnSettings.length; row++) {
						switch (jiDataType) {
							case 0:
								jaColVisible[row] = (MyColumnSettings[row]['ItemValue'].toString() == '1' ? 1 : 0);
								break;
							case 1:
								jaColVisiblePA1[row] = (MyColumnSettings[row]['ItemValue'].toString() == '1' ? 1 : 0);
								break;
							case 2:
								jaColVisiblePA1[row] = (MyColumnSettings[row]['ItemValue'].toString() == '1' ? 1 : 0);
								break;
							case 3:
								jaColVisiblePA2[row] = (MyColumnSettings[row]['ItemValue'].toString() == '1' ? 1 : 0);
								break;
							default:
								break;
						}
					}
				}
			}
			//alert('end 1');
			return false;
		}

		function GetFilterViewSettings() {
			//alert('start 1');
			var url = "../shared/AjaxServices.asmx/SelectUserInterfaceItems";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'2','UIType':'SalesPFltr','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyFilterSettings = response; });
			if (MyFilterSettings !== undefined && MyFilterSettings !== null) {
				if (MyFilterSettings.length > 0) {
					for (var row = 0; row < MyFilterSettings.length; row++) {
						jaFilterVisible[row] = (MyFilterSettings[row]['ItemValue'].toString() == '1' ? 1 : 0);
					}
				}
			}
			//alert('end 2');
			return false;
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
			var region = jselRegionMF.value;
			var url = "../shared/AjaxServices.asmx/SelectProductCodeListForRegion";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','Region':'" + region + "','CodeType':'" + ctype + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCodeListData = response; });
			return false;
		}

		function GetLocationList() {
			//alert('locs');
			var url = "../shared/AjaxServices.asmx/GetLocationList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','LocCode':'','LocType':'MILL','Country':'US','City':'','Class':'0','Sort':'0','Active':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyLocations = response; });
			return false;
		}

		function GetLocationList2() {
			var reg = jselRegionMF.value;
			var url = "../shared/AjaxServices.asmx/GetLocationList2";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','LocCode':'','Region':'" + reg + "','LocType':'MILL','Country':'US','City':'','Class':'0','Sort':'0','Active':'2','ByID':'" + jiByID.toString() + "'}";
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
			//alert('user locs');
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

		function GetUserQueryData() {
			var id = jselQueryList.value;
			jiQueryID = parseInt(id, 10);
			var nm = jtQueryTitle.value;
			var url = "../shared/AjaxServices.asmx/SelectUserQueryData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','UserID':'" + jiByID.toString() + "','QueryID':'" + id + "','QueryName':'" + nm + "','Sort':'0','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyQueryData = response; });
			return false;
		}

		function GetWeekDatesData() {
			// typ: 0-not current week, 1-current week included
			var typ = 0;
			var url = "../shared/AjaxServices.asmx/Get13WeekDates";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','iType':'2','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyWeeksData = response; });
			//alert(MyWeeksData[0]['sStartDate'].toString());
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
			//alert('columns done');
			return false;
		}

		function GetCustomerList(seed) {
			var url = "../shared/AjaxServices.asmx/SelectLTProdCustomerList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','Seed':'" + seed + "','Sort':'0','Min':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCustomerData = response; });
			return false;
		}

		function GetSalesMgrList() {
			var url = "../shared/AjaxServices.asmx/SelectSalesManagerList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','Active':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MySalesManagers = response; });
			return false;
		}

		function SaveColSettingValue(itm, typ, val) {
			var url = "../shared/AjaxServices.asmx/UpdateColumnSetting";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'3', 'UserID':'" + jiByID.toString() + "','UIType':'" + typ + "','Item':'" + itm + "','Val':'" + val + "','Comment':'','Active':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyColumnSettings = response; });
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
			if (jchkShowCurrentWeek.checked === true) { showwk = 1; }
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
			var id = 0;
			var id1 = 0;
			var id2 = 0;
			var idesc = '';
			var inm = '';
			var loadid = 0;
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

			if (jselQueryList.value === '0') {
				id = 0;
			}
			else {
				id = parseInt(jselQueryList.value, 10);
			}
			//alert('1');
			var nm = jtQueryTitle.value;
			var reg = jselRegionMF.value;
			var loc = jselLocationMF.value;
			var spec = jselSpeciesMF.value;
			var thick = jselThickMF.value;
			var grade = jselGradeMF.value;
			if (jtFilterColGrade.value !== '') { grade = jtFilterColGrade.value; }
			var seas = jselSeasoningMF.value;
			var len = jselLengthMF.value;
			//alert('2');
			var color = jselColorMF.value;
			var fsort = jselSortMF.value;
			var mill = jselMillingMF.value;
			var nop = jselNoPrintMF.value;
			var pcode = jselProductMF.value;
			if (jtFilterColProd.value !== '') { pcode = jtFilterColProd.value; }
			//alert('3');
			var mgr = jselManagerMF.value;
			if (jtFilterColMgr.value !== '') { mgr = jtFilterColMgr.value; }
			var cust = '';
			if (jhfCustCode.value !== '') {
				cust = 'DL|' + jhfCustCode.value;
			}
			else {
				if (jtFilterColCust !== '') {
					cust = 'FF|' + jtFilterColCust.value;
				}
				else {
					cust = 'SL|' + GetCustomerCodeList();
				}
			}
			//alert('4');
			var ptype = jselTypeMain.value; // jsel 'HD';
			var itype = '0'; //jselViewType.value;
			//alert('5');
			var set0 = 0;
			if (jchkIncCustomers.checked === true) { set0 = 1; }
			var set1 = parseInt(jselManagedMain.value, 10);
			var set2 = 0;	// unset 
			var zeros = 0;
			if (jchkShowZeros.checked === true) { zeros = 1; }
			//alert('5a');
			var set4 = parseInt(jselDataTypes.value, 10);
			var set5 = parseInt(jselGroupSortBy.value, 10);
			//alert('5b');
			var set6 = 0;
			if (jchkIncHolds.checked === true) { set6 = 1; }
			var set7 = 0;
			if (jchkIncHistory.checked === true) { set7 = 1; }
			var itemsppg = jselPageSize.value;
			//alert('6');
			if (jchkSubtotalProducts.checked === true) { a1 = '1'; }
			if (jchkSubtotalProdAttribs.checked === true) { a2 = '1'; }
			//alert('7');
			if (jchkSubtotalSpecies.checked === true) { a3 = '1'; }
			if (jchkSubtotalThickness.checked === true) { a4 = '1'; }
			if (jchkSubtotalGrade.checked === true) { a5 = '1'; }
			if (jchkSubtotalColor.checked === true) { a6 = '1'; }
			if (jchkSubtotalSort.checked === true) { a7 = '1'; }
			if (jchkSubtotalNoPrint.checked === true) { a8 = '1'; }
			var icd = a1 + a2 + a3 + a4 + a5 + a6 + a7 + a8;
			var ojbid = jiDataType.toString();
			var url = "../shared/AjaxServices.asmx/UpdateUserQuery";
			var MyData = "{'UserID':'" + jiByID.toString() + "','QueryID':'" + id.toString() + "','QueryName':'" + nm + "','PgID':'" + jiPageID.toString() + "','PgObjID':'" + objid + "','PgNbr':'" + jiPageNbr.toString() + "','PgSize':'" + itemsppg + "',";
			MyData = MyData + "'TDt':'','BDt':'','EDt':'','UserName':'','ProdType':'" + ptype + "','ProdCode':'" + pcode + "','LocCode':'" + loc + "','Reg':'" + reg + "','Thick':'" + thick + "','Species':'" + spec + "','Grade':'" + grade + "',";
			MyData = MyData + "'Seasoning':'" + seas + "','Surface':'" + surf + "','StatusCode':'" + stat + "','Width':'" + wdth + "','Len':'" + len + "','Color':'" + color + "','fSort':'" + fsort + "','Milling':'" + mill + "','NoPrint':'" + nop + "',";
			MyData = MyData + "'iType':'" + itype + "','Set0':'" + set0.toString() + "','Set1':'" + set1.toString() + "','Set2':'" + set2.toString() + "','Set3':'" + zeros.toString() + "','Set4':'" + set4.toString() + "',";
			MyData = MyData + "'Set5':'" + set5.toString() + "','Set6':'" + set6.toString() + "','Set7':'" + set7.toString() + "','OrdID':'" + ordid.toString() + "','ShipID':'" + shipid.toString() + "','LoadID':'" + loadid.toString() + "',";
			MyData = MyData + "'Cust':'" + cust + "','Vend':'" + vend + "','Supplr':'" + supp + "','Mgr':'" + mgr + "','MgrID':'" + mgrid.toString() + "','Sort':'" + sort + "','ItemCode':'" + icd + "','ItemName':'" + inm + "','ItemDesc':'" + idesc + "',";
			MyData = MyData + "'Nbr':'" + nbr.toString() + "','Code1':'" + c1 + "','Code2':'" + c2 + "','ID1':'" + id1.toString() + "','ID2':'" + id2.toString() + "','Comments':'" + cmt + "','Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			if (MyReturn !== undefined && MyReturn !== null) {
				if (MyReturn.length > 0) {
					jiQueryID = parseInt(MyReturn[0]['QueryID'], 10);
				}
				else {
					alert('Attempt to save query failed and returned an unknown error.');
				}
			}
			else {
				alert('Attempt to save query failed.');
			}
			return false;
		}

		function UpdateQueryAction(typ, id, other) {
			var url = "../shared/AjaxServices.asmx/UpdateQueryAction";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'3', 'UserID':'" + jiByID.toString() + "','QueryID':'" + id.toString() + "','iType':'" + typ.toString() + "','Other':'" + other + "','ByID':'" + jiByID.toString() + "'}";
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
				var custcode = '';
				var fuzzygrade = '';
				var fuzzysort = '';
				var fuzzyprod = '';
				var fuzzymgr = '';
				var fuzzycust = '';
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

				if (jselQueryList.value === '0') {
					id = 0;
				}
				else {
					id = parseInt(jselQueryList.value, 10);
				}
				//alert('1');
				var cmt = '';
				var nm = jtQueryTitle.value;
				var reg = jselRegionMF.value;
				var loc = jselLocationMF.value;
				var spec = jselSpeciesMF.value;
				var thick = jselThickMF.value;
				var grade = jselGradeMF.value;
				if (jtFilterColGrade.value !== '') { grade = jtFilterColGrade.value; }
				var seas = jselSeasoningMF.value;
				var len = jselLengthMF.value;
				//alert('2');
				var color = jselColorMF.value;
				var fsort = jselSortMF.value;
				var mill = jselMillingMF.value;
				var nop = jselNoPrintMF.value;
				var pcode = jselProductMF.value;
				if (jtFilterColProd.value !== '') { pcode = jtFilterColProd.value; }
				//alert('3');
				var mgr = jselManagerMF.value;
				if (jtFilterColMgr.value !== '') { mgr = jtFilterColMgr.value; }
				var cust = GetCustomerCodeList();
				//alert('4');
				var ptype = jselTypeMain.value; // jsel 'HD';
				var itype = '0'; //jselViewType.value;
				var inccust = 0;
				if (jchkIncCustomers.checked === true) { inccust = 1; }
				var incinv = 0;
				var incsales = 0;
				var incholds = 0;
				if (jchkIncHolds.checked === true) { incholds = 1; }
				var incprod = 0;
				var inchist = 0;
				if (jchkIncHistory.checked === true) { inchist = 1; }
				var incphist = 0;
				//alert('5');

				var set0 = 0;
				var set1 = parseInt(jselManagedMain.value, 10);
				var set2 = 0;	// unset 
				var zeros = 0;
				if (jchkShowZeros.checked === true) { zeros = 1; }
				//alert('5a');
				var set4 = parseInt(jselDataTypes.value, 10);
				if (set4 === 0 || set4 === 1) { incprod = 1; }
				if (set4 === 0 || set4 === 2) { incsales = 1; }
				var set5 = parseInt(jselGroupSortBy.value, 10);
				//alert('5b');
				var set6 = 0;
				var set7 = 0;
				var itemsppg = jselPageSize.value;
				//alert('6');
				if (jchkSubtotalProducts.checked === true) { a1 = '1'; }
				if (jchkSubtotalProdAttribs.checked === true) { a2 = '1'; }
				//alert('7');
				if (jchkSubtotalSpecies.checked === true) { a3 = '1'; }
				if (jchkSubtotalThickness.checked === true) { a4 = '1'; }
				if (jchkSubtotalGrade.checked === true) { a5 = '1'; }
				if (jchkSubtotalColor.checked === true) { a6 = '1'; }
				if (jchkSubtotalSort.checked === true) { a7 = '1'; }
				if (jchkSubtotalNoPrint.checked === true) { a8 = '1'; }
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
				fuzzygrade = jtFilterColGrade.value.replace('%', '').replace('*', '');
				fuzzysort = jtFilterColSort.value.replace('%', '').replace('*', '');
				fuzzyprod = jtFilterColProd.value.replace('%', '').replace('*', '');
				fuzzymgr = jtFilterColMgr.value.replace('%', '').replace('*', '');
				fuzzycust = jtFilterColCust.value.replace('%', '').replace('*', '');
				custcode = jhfCustCode.value;
				if (custcode === '0') { custcode = ''; }
				//alert('9 - ' + icd);

				if (incsales === 1 || inccust === 1 || incprod === 1 || inchold === 1 || incProdHist === 1) {
					if (ritems.length < jiNbrCols) { ritems = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'; }
					//alert('saving');
					var url = "../shared/AjaxServices.asmx/UpdateUserExportData";
					var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','UserID':'" + jiByID.toString() + "','ExpFileNm':'" + fname + "','ProdType':'" + ptype + "','ProdCode':'" + pcode + "',";
					MyData = MyData + "'LocCode':'" + loc + "','Reg':'" + reg + "','Thick':'" + thick + "','Spec':'" + spec + "','Grade':'" + grade + "','Season':'" + seas + "','Surf':'" + surf + "','Stat':'" + stat + "',";
					MyData = MyData + "'iType':'" + itype + "','Wdth':'','Len':'" + len + "','Color':'" + color + "','FSort':'" + fsort + "','Milling':'" + mill + "','NoPrint':'" + nop + "','OrderID':'0','ShipID':'0','LoadID':'0',";
					MyData = MyData + "'Cust':'" + cust + "','Vendor':'" + vend + "','Supplier':'" + suppl + "','Mgr':'" + mgr + "','MgrID':'" + mgrid.toString() + "','IncInven':'" + incinv.toString() + "','IncSales':'" + incsales.toString() + "',";
					MyData = MyData + "'IncHolds':'" + incholds.toString() + "','IncProd':'" + incprod.toString() + "','IncCust':'" + inccust.toString() + "','IncHist':'" + inchist.toString() + "','IncPHist':'" + incphist.toString() + "',";
					MyData = MyData + "'RollupItems':'" + ritems + "','FuzzyGrade':'" + fuzzygrade + "','FuzzySort':'" + fuzzysort + "','FuzzyProd':'" + fuzzyprod + "','FuzzyMgr':'" + fuzzymgr + "','FuzzyCust':'" + fuzzycust + "',";
					MyData = MyData + "'Fuzzy6':'','IName':'','ICode':'','IDesc':'','Nbr':'0','Code1':'','Code2':'','id1':'0','id2':'0','TDt':'','BDt':'','EDt':'','CustCode':'" + custcode + "','SubTotal':'" + icd + "',";
					MyData = MyData + "'Cmt':'" + cmt + "','Sort':'" + sort + "','Active':'1'}";
					//alert(MyData);
					getJSONReturnDataAs(url, MyData, function (response)
					{ MyReturn = response; });
				}
			}
			else {
				alert('That is not a valid file name. The data cannot be exported.');
			}
		}

		function UpdateUserRightLevel(id, val) {
			var url = "../shared/AjaxServices.asmx/UpdateColumnSetting";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'3','ID':'" + id.toString() + "','UserID':'0','GroupCode':'','RightLevel':'" + val + "','PageID':'" + jiPageID.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			return false;
		}

		// ****************************** Populate Objects *************************************

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
			for (var itm = 0; itm <= 14; itm++) {
				chk = document.getElementById('chkColSetting' + itm.toString());
				//alert(itm + ' ' + jaColVisible[itm]);
				if (jaColVisible[itm] === 1) {
					chk.checked = true;
				}
				else {
					chk.checked = false;
				}
			}
			return false;
		}

		function PopulateColFilterSettings() {
			var chk;
			for (var itm = 0; itm <= 13; itm++) {
				chk = document.getElementById('chkColFSetting' + itm.toString());
				if (jaFilterVisible[itm] === 1) {
					chk.checked = true;
				}
				else {
					chk.checked = false;
				}
			}
			return false;
		}

		function PopulateGradeList() {
			GetProdCodeList('Grade');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				//alert('Grade - ' + MyCodeListData.length);
				ClearDDLOptionsGu('selGradeMF', 1);
				fillDropDownListGu(MyCodeListData, jselGradeMF, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			//alert('Done with grades');
			return false;
		}

		function PopulateGradeListByRegion() {
			GetProdCodeListForRegion('Grade');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selGradeMF', 1);
				fillDropDownListGu(MyCodeListData, jselGradeMF, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateLengthList() {
			GetProdCodeList('Length');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selLengthT', 1);
				fillDropDownListGu(MyCodeListData, jselLengthMF, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateLocationList() {
			//alert('filling locs');
			if (jbA === true) {
				GetLocationList();
				//alert('All Locations');
			}
			else {
				GetUserLocationList();
			}
			if (MyLocations !== undefined && MyLocations !== null) {
				//alert(MyLocations.length);
				ClearDDLOptionsGu('selLocationMF', 1);
				if (MyLocations.length > 0) {
					fillDropDownListGu(MyLocations, jselLocationMF, 0, 'NameAbbrev', 'loc');
				}
			}
			//alert('done');
			return false;
		}

		function PopulateLocationListByRegion() {
			//alert('populate loc list by region');
			if (jbA === true || jbAllLocations === true) {
				GetLocationList2();
			}
			else {
				GetUserLocationList();
			}
			ClearDDLOptionsGu('selLocationMF', 1);
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
				fillDropDownListGu(MyCodeListData, jselMillingMF, 0, 'CodeDescAbbreviated', 'CatCode');
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

		function PopulatePriceAnalysisGrid() {


			return false;
		}

		function PopulatePriceAnalysisSummary() {


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

		// MAIN SALES GRID
		function PopulateSalesGrid() {
			//alert('populating...');
			var bkColor = '#FFFFFF';
			var bld = false;
			var brdrL = '';
			var brdrR = '';
			var brdrT = '';
			var brdrB = '';
			var cellClass = 'StdTableCell';
			var color = '';
			var colspn = '';
			var content = '';
			var contentNext = '';
			var disp = '';
			var dsabld = false;
			var fig = 0;
			var frColor = '#000000';
			var fSz = '11pt';
			var grade = '';
			var hAlign = '';
			var ht = '20px';
			var ital = false;
			var lineTotal = 0;
			var lastcolor = '';
			var lastgrade = '';
			var lastnoprint = '';
			var lastprod = '';
			//var lastprodmID = 0;
			var lastsort = '';
			var lastspecie = '';
			var lastthick = '';
			var NbrCols = 32;
			var NbrRows = 0;
			var nextColor = '';
			var nextGrade = '';
			var nextNoPrint = '';
			var nextProd = '';
			var nextProdAs = '';
			var nextSort = '';
			var nextSpecies = '';
			var nextThick = '';
			var noprint = '';
			var noWrap = 0;
			var oldSKU = '';
			var oldcontent = '';
			var ovrflw = 'hidden';
			var pL = '2px';
			var pR = '2px';
			var pT = '1px';
			var pB = '1px';
			var prod = '';
			var RdOnly = false;
			var rowtotal = 0;
			var sCol = '';
			var ShowStrat = 1;
			var ShowTac = 1;
			var SKU = '';
			var sort = '';
			var specie = '';
			var thick = '';
			var vAlign = '';
			var Visbl = true;
			var wdth = 100
			var sResults = '';
			jiTotalRows = 0;
			EmptyGridColumnTotals();
			//ShowHideColumns();
			if (jiViewType === 1) { ShowStrat = 0; }
			if (jiViewType === 2) { ShowTac = 0; }
			jfColSKUtotals = createArrayInitGu(30, 1);

			var lvl = 1;
			jiNbrRows = 0;
			var bdy = document.createElement('tbody');
			if (MyMainGridData !== undefined && MyMainGridData !== null) {
				//alert('got data rows!');
				if (MyMainGridData.length > 0) {
					//            0   1   2   3   4   5   6   7   8   9   10  11  12  13  14  15   16  17  18  19  20  21  22  23  24  25  26  27  28  29  30  31  32  33  34  35  36  37  38  39  40
					var cWidth = [80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 100, 90, 90, 90, 100, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 90, 100];
					var corient = ['L', 'L', 'L', 'L', 'L', 'L', 'L', 'L', 'L', 'L', 'L', 'L', 'L', 'L', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', 'R', ];
					NbrRows = MyMainGridData.length;
					var LastVals = createArrayInitGu(15, 0);
					var NoDups = createArrayInitGu(NbrCols + 1, 1);
					//alert('setting initial page - ' + NbrRows);
					jiNbrPagesPj[0] = parseInt(MyMainGridData[0]['NbrPages'], 10);
					jiTotalRows = parseInt(MyMainGridData[0]['NbrRows'], 10);
					//alert('2');
					jiPageNbr = 0;
					jiPgNbrPj[1] = 0;
					//lastprodmID = 0;
					//alert('beginning rows - ' + NbrRows);
					for (var row = 0; row < NbrRows; row++) {
						//alert('Row ' + row.toString());
						SKU = MyMainGridData[row]['QSKU'].toString();
						prod = MyMainGridData[row]['ProductCode'].toString();
						grade = MyMainGridData[row]['Grade'].toString();
						specie = MyMainGridData[row]['Specie'].toString();
						thick = MyMainGridData[row]['Thickness'].toString();
						color = MyMainGridData[row]['Color'].toString();
						sort = MyMainGridData[row]['Sort'].toString();
						noprint = MyMainGridData[row]['NoPrint'].toString();
						rowtotal = 0;
						trow = document.createElement('tr');
						trow.id = 'trSalesGridRow' + row.toString();
						lineTotal = 0;
						jiNbrRows++;
						//if (row === 8) { alert('starting 8 sutotal check'); }
						if (row < (NbrRows - 1)) {
							nextColor = MyMainGridData[row + 1]['Color'].toString();
							nextGrade = MyMainGridData[row + 1]['Grade'].toString();
							nextNoPrint = MyMainGridData[row + 1]['NoPrint'].toString();
							nextProd = MyMainGridData[row + 1]['ProductCode'].toString();
							nextProdAs = MyMainGridData[row + 1]['QSKU'].toString();
							nextSort = MyMainGridData[row + 1]['Sort'].toString();
							nextSpecies = MyMainGridData[row + 1]['Specie'].toString();
							nextThick = MyMainGridData[row + 1]['Thickness'].toString();
						}

						// product-attribute change totals
						if (row > 0) {
							if (jbSubtotalProdAs && SKU !== oldSKU) {
								//alert('ProdAttrib subtotal');
								bdy.appendChild(ShowProdGridProductTotals(1, 'spcell' + row.toString() + '_', 3, 'Prod/Attributes Total')); //typ, pref, clspn, labelx
								EmptyGridProdTotals(0);
							}
							if (jbSubtotalProd && prod !== lastprod) {
								//alert('Prod subtotal');
								bdy.appendChild(ShowProdGridProductTotals(1, 'spcell' + row.toString() + '_', 9, 'Product Total'));
								EmptyGridProdTotals(1);
							}
							if (jbSubtotalGrade && grade !== lastgrade) {
								//alert('Grade subtotal');
								bdy.appendChild(ShowProdGridProductTotals(4, 'spcell' + row.toString() + '_', 12, 'Grade Total'));
								EmptyGridProdTotals(4);
							}
							if (jbSubtotalSpecies && specie !== lastspecie) {
								//alert('Specie subtotal');
								bdy.appendChild(ShowProdGridProductTotals(2, 'spcell' + row.toString() + '_', 14, 'Specie Total'));
								EmptyGridProdTotals(2);
							}
							if (jbSubtotalThick && thick !== lastthick) {
								//alert('Thickness subtotal');
								bdy.appendChild(ShowProdGridProductTotals(3, 'spcell' + row.toString() + '_', 13, 'Thickness Total'));
								EmptyGridProdTotals(3);
							}
							if (jbSubtotalColor && color !== lastcolor) {
								alert('Color subtotal');
								bdy.appendChild(ShowProdGridProductTotals(5, 'spcell' + row.toString() + '_', 8, 'Color Total'));
								EmptyGridProdTotals(5);
							}
							if (jbSubtotalSort && sort !== lastsort) {
								//alert('Sort subtotal');
								bdy.appendChild(ShowProdGridProductTotals(6, 'spcell' + row.toString() + '_', 7, 'Sort Total'));
								EmptyGridProdTotals(7);
							}
							if (jbSubtotalNoPrint && noprint !== lastnoprint) {
								//alert('NoPrint subtotal');
								bdy.appendChild(ShowProdGridProductTotals(7, 'spcell' + row.toString() + '_', 5, 'NoPrint Total'));
								EmptyGridProdTotals(6);
							}
						}
						else {
							if (jbSubtotalProdAs) {
								EmptyGridProdTotals(0);
							}
							if (jbSubtotalProd) {
								EmptyGridProdTotals(1);
							}
							if (jbSubtotalGrade) {
								EmptyGridProdTotals(4);
							}
							if (jbSubtotalSpecies) {
								EmptyGridProdTotals(2);
							}
							if (jbSubtotalThick) {
								EmptyGridProdTotals(3);
							}
							if (jbSubtotalColor) {
								EmptyGridProdTotals(5);
							}
							if (jbSubtotalSort) {
								EmptyGridProdTotals(7);
							}
							if (jbSubtotalNoPrint) {
								EmptyGridProdTotals(6);
							}
						}
						//if (row === 8) { alert('8 sutotal check done'); }

						for (var col = 0; col < NbrCols; col++) {
							//if (row === 8) {
							//	alert('Row ' + row.toString() + ', Col ' + col.toString());
							//}
							//alert('B');
							content = '';
							contentNext = '';
							bkColor = 'white';
							bld = false;
							dsabld = false;
							frColor = 'black';
							fSz = '11pt';
							hAlign = 'left';
							ital = false;
							//alert('C');
							noWrap = 0;
							ovrflw = 'hidden';
							pL = '2px';
							pR = '2px';
							pT = '1px';
							pB = '1px';
							RdOnly = false;
							vAlign = 'top';
							Visbl = '';
							colspn = '';
							//alert('D');
							if (LastVals[col] === undefined || LastVals[col] === null) { LastVals[col] = ''; }
							if (col === 12 || col === 13) { noWrap = 1; }
							// show cell only if set visible
							//alert('checking visibility');
							if (jaColVisible[col] === 1) {
								//alert('Row ' + row + '-Col ' + col.toString() + ' visible');
								//alert(MyMainGridData[row]['ProdType'].toString())
								//alert(MyMainGridData[row][0].toString())
								switch (col) {
									case 0:
										content = MyMainGridData[row]['Specie'].toString();
										if (row < (NbrRows - 1)) { contentNext = MyMainGridData[row + 1]['Specie'].toString(); }
										break;
									case 1:
										content = MyMainGridData[row]['Thickness'].toString();
										if (row < (NbrRows - 1)) { contentNext = MyMainGridData[row + 1]['Thickness'].toString(); }
										break;
									case 2:
										content = MyMainGridData[row]['Grade'].toString();
										if (row < (NbrRows - 1)) { contentNext = MyMainGridData[row + 1]['Grade'].toString(); }
										break;
									case 3:
										content = MyMainGridData[row]['Seasoning'].toString();
										if (row < (NbrRows - 1)) { contentNext = MyMainGridData[row + 1]['Seasoning'].toString(); }
										break;
									case 4:
										content = MyMainGridData[row]['Surface'].toString();
										if (row < (NbrRows - 1)) { contentNext = MyMainGridData[row + 1]['Surface'].toString(); }
										break;
									case 5:
										content = MyMainGridData[row]['ItemLength'].toString();
										break;
									case 6:
										content = MyMainGridData[row]['Color'].toString();
										break;
									case 7:
										content = MyMainGridData[row]['Sort'].toString();
										break;
									case 8:
										content = MyMainGridData[row]['Milling'].toString();
										break;
									case 9:
										content = MyMainGridData[row]['NoPrint'].toString();
										break;
									case 10:
										content = MyMainGridData[row]['ProductCode'].toString();
										break;
									case 11:
										content = MyMainGridData[row]['RecType'].toString();
										break;
									case 12:
										content = MyMainGridData[row]['MGR'].toString();
										break;
									case 13:
										content = MyMainGridData[row]['CustomerS'].toString();
										break;
									case 14:
										content = MyMainGridData[row]['P13'].toString();
										break;
									case 15:
										content = MyMainGridData[row]['P08'].toString();
										break;
									case 16:
										content = MyMainGridData[row]['P04'].toString();
										break;
									case 17:
										content = MyMainGridData[row]['TotalAmt'].toString();
										break;
									default:
										if (col > 17 && col <= 31) {
											sCol = (col - 18).toString();
											if (sCol.length === 1) { sCol = '0' + sCol; }
											fig = MyMainGridData[row]['W' + sCol].toString();
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
								if (col < 5) {
									if (content === LastVals[col]) {
										brdrT = 'none';
										content = '';
									}
									if (oldcontent === contentNext) {
										brdrB = 'none';
									}
								}
								if (col === 14) {
									brdrL = '4px double gray';
								}
								disp = '';
								if (jaColVisible[col] === 0) { disp = 'none'; }
								if (col > 13) {
									if (content === '0.0' || content === '0') {
										frColor = 'gray';
									}
									fig = parseFloat(content);
									lineTotal += fig;
									jaColTotals[col - 14] += fig;
									if (jbSubtotalProdAs) { jfColSKUTotals[col - 14] += fig; }
									if (jbSubtotalProd) { jfColProdTotals[col - 14] += fig; }
									if (jbSubtotalGrade) { jfColGradeTotals[col - 14] += fig; }
									if (jbSubtotalSpecies) { jfColSpeciesTotals[col - 14] += fig; }
									if (jbSubtotalThick) { jfColThickTotals[col - 14] += fig; }
									if (jbSubtotalColor) { jfColColorTotals[col - 14] += fig; }
									if (jbSubtotalSort) { jfColSortTotals[col - 14] += fig; }
									if (jbSubtotalNoPrint) { jfColNoPrintTotals[col - 14] += fig; }
								}
								else {
									//if (col < 14) {
									bkColor = '#FFFFCC';
									if (col < 10 && row < (NbrRows - 1)) {
										// turn off bottom border if next line is a subtotal
										if (jbSubtotalProdAs && SKU !== nextProdAs) { brdrB = 'none'; }
										if (jbSubtotalProd && prod !== nextProd) { brdrB = 'none'; }
										if (jbSubtotalGrade && grade !== nextGrade) { brdrB = 'none'; }
										if (jbSubtotalSpecies && specie !== nextSpecies) { brdrB = 'none'; }
										if (jbSubtotalThick && thick !== nextThick) { brdrB = 'none'; }
										if (jbSubtotalColor && color !== nextColor) { brdrB = 'none'; }
										if (jbSubtotalSort && sort !== nextSort) { brdrB = 'none'; }
										if (jbSubtotalNoPrint && noprint !== nextNoPrint) { brdrB = 'none'; }
									}
								}
								//if (col === 39) {
								//		jaColTotals[25] += lineTotal;
								//}
								//}
								// set line total value
								//if (col == 39) { content = jsfNumberFormatNf(lineTotal, 1, '.', ','); }
								if (col > 13 && col < 39) {
									if (jbShow0s === false && parseFloat(content) === 0) { content = ''; }
								}
								if (row === NbrRows - 1 && (jbSubtotalProdAs || jbSubtotalProd || jbSubtotalGrade || jbSubtotalSpecies || jbSubtotalThick || jbSubtotalColor || jbSubtotalSort || jbSubtotalNoPrint)) { brdrB = 'none'; }
								//alert('creating cell - ' + 'tdConsolid' + row.toString() + '_' + col.toString() + '/' + ht + '/' + cWidth[col] + '/' + content + '/' + bkColor + '/' + frColor + '/' + bld + '/' + ital);
								//alert('creating cell2 - ' + brdrL + '/' + brdrR + '/' + brdrT + '/' + brdrB + '/' + hAlign + '/' + vAlign + '/' + pL + '/' + pR + '/' + pT + '/' + pB + '/' + fSz);
								//alert('creating cell3 - ' + ovrflw + '/' + RdOnly + '/' + dsabld + '/' + Visbl + '/' + colspn + '/' + cellClass);
								tcell = createNewCellDg('tdSalesGrid' + row.toString() + '_' + col.toString(), ht, cWidth[col].toString() + 'px', content, bkColor, frColor, brdrL, brdrR, brdrT, brdrB, hAlign, vAlign, pL, pR, pT, pB, fSz, bld, ital, ovrflw, RdOnly, dsabld, Visbl, colspn, cellClass, disp, noWrap);
								//alert('appending cell');
								trow.appendChild(tcell);
								//alert('setting last val');
								LastVals[col] = oldcontent;
							}
						}	// for (var col = 0; col < NbrCols; col++)
						bdy.appendChild(trow);

						//lastprodmID = parseInt(MyMainGridData[row]['Wk1_' + (col - 13).toString()], 10);
						oldSKU = MyMainGridData[row]['QSKU'].toString();
						lastprod = prod;
						lastgrade = grade;
						lastspecie = specie;
						lastthick = thick;
						lastcolor = color;
						lastsort = sort;
						lastnoprint = noprint;

					} //for (var row = 0; row < NbrRows; row++)

					// show last page subtotals
					if (jbSubtotalProdAs) { bdy.appendChild(ShowProdGridProductTotals(1, 'spcell' + row.toString() + '_', 3, 'Prod/Attributes Total (this page)')); }
					if (jbSubtotalProd) { brdrB = bdy.appendChild(ShowProdGridProductTotals(1, 'spcell' + row.toString() + '_', 9, 'Product Total (this page)')); }
					if (jbSubtotalGrade) { brdrB = bdy.appendChild(ShowProdGridProductTotals(4, 'spcell' + row.toString() + '_', 12, 'Grade Total (this page)')); }
					if (jbSubtotalSpecies) { bdy.appendChild(ShowProdGridProductTotals(2, 'spcell' + row.toString() + '_', 14, 'Specie Total (this page)')); }
					if (jbSubtotalThick) { bdy.appendChild(ShowProdGridProductTotals(3, 'spcell' + row.toString() + '_', 13, 'Thickness Total (this page)')); }
					if (jbSubtotalColor) { bdy.appendChild(ShowProdGridProductTotals(5, 'spcell' + row.toString() + '_', 8, 'Color Total (this page)')); }
					if (jbSubtotalSort) { bdy.appendChild(ShowProdGridProductTotals(6, 'spcell' + row.toString() + '_', 7, 'Sort Total (this page)')); }
					if (jbSubtotalNoPrint) { bdy.appendChild(ShowProdGridProductTotals(7, 'spcell' + row.toString() + '_', 5, 'NoPrint Total (this page)')); }
				} //MyMainGridData.length > 0
			}
			else {
				alert('Sales data could not be extracted because of an unidentified error.');
			}

			//alert('Attaching body');
			try {
				var oldBody = jtblMainDataGrid.getElementsByTagName("tbody")[0];
				jtblMainDataGrid.replaceChild(bdy, oldBody);
			}
			catch (ex) {

			}

			// insert grid totals
			InsertGridTotals();

			//alert('checking nbr rows - ' + NbrRows);
			if (NbrRows === 0) {
				jlStatusMsg.innerHTML = 'No data matches that criteria.';
			}

			//alert(jiTotalRows + '/' + NbrRows);
			if (jiTotalRows > NbrRows || jiNbrPagesPj[0] > 1) {
				joPgNbrLblPj.innerHTML = (jiPgNbrPj[0] + 1).toString();
				joMaxPgNbrLblPj.innerHTML = jiNbrPagesPj[0].toString();
				joPaginationBarPj.style.display = 'block';
			}
			//alert('Done populating');
			return false;
		}

		function PopulateSalesMgrList() {
			GetSalesMgrList();
			if (MySalesManagers !== undefined && MySalesManagers !== null) {
				ClearDDLOptionsGu('selManagerMF', 1);
				fillDropDownListGu(MySalesManagers, jselManagerMF, 0, 'SalesManager', 'SalesManager');
			}
			return false;
		}

		function PopulateSeasoningList() {
			GetProdCodeList('Seasoning');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selSeasoningMF', 1);
				//alert('Seasoning - ' + MyCodeListData.length);
				if (MyCodeListData.length > 0) {
					fillDropDownListGu(MyCodeListData, jselSeasoningMF, 0, 'CodeDescAbbreviated', 'CatCode');
				}
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

		function PopulateSpeciesListPA() {
			//GetCodeList('Species');
			GetProdCodeList('Species');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selPriceAnalysisSpecies', 1);
				fillDropDownListGu(MyCodeListData, jselPriceAnalysisSpecies, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateSpeciesListByRegion() {
			GetProdCodeListForRegion('Species');
			//alert('Species: ' + MyCodeListData.length);
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selSpeciesMF', 1);
				fillDropDownListGu(MyCodeListData, jselSpeciesMF, 0, 'CodeDescAbbreviated', 'CatCode');
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
			GetProdCodeList('Thickness');
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
				fillDropDownListGu(MyCodeListData, jselThickMF, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}

		// ****************************** Dialogs *************************************

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

		function ChangeQueryAction(typ, id, other) {
			UpdateQueryAction(typ, id, other);
			// update display table
			var div = document.getElementById('divCommonPopup');
			div.innerHTML = FillQueryActionList();
			return false;
		}

		function ChangeRadioBtn(id, objid, val, ischecked) {
			return false;
		}

		function DeleteOneRec(id, row, objid) {
			return false;
		}

		function DialogAction1(dChoice, Src) {
			switch (Src) {
				case 3:
					//alert('Tailoring done');
					GetColumnViewSettings();
					ShowHideColumns();
					//alert('Columns done');
					GetFilterViewSettings();
					ShowHideFilters();
					//alert('Filters done');
					ChangeViewType(jiViewType.toString());
					PopulateConsolidation();
					//alert('action complete');
					break;
				default:
					break;
			}
			return false;
		}

		function EditOneRec(id, row, objid) {
			return false;
		}

		function FillGridCalDates() {
			GetWeekDatesData();
			var mydate;
			var dt = '';
			var dy = 0;
			var dy2 = 0;
			var mo = 0;
			var mo2 = 0;
			var s = '';
			var vdate = '';
			var nbrweeks = 0;
			var wknbr = 0;
			var yr = 0;
			if (MyWeeksData !== undefined && MyWeeksData !== null) {
				nbrweeks = MyWeeksData.length;
				s = MyWeeksData[0]["sStartDate"].toString();
				yr = parseInt(s.substr(0, 4), 10);
				mo = parseInt(s.substr(5, 2), 10);
				dy = parseInt(s.substr(8, 2), 10);
				var Wk1 = new Date(s); //ConvertJSONDate(
				var Wk2 = new Date();
				for (var wk = 0; wk < nbrweeks; wk++) {
					wknbr = parseInt(MyWeeksData[wk]["WeekNbr"], 10);
					s = MyWeeksData[wk]["sFriday"].toString();
					Wk1 = new Date(s);
					yr = Wk1.getFullYear();
					mo = Wk1.getMonth() + 1;
					dy = Wk1.getDate();
					Wk2 = Wk1.addDays(6);
					mo2 = Wk2.getMonth() + 1;
					dy2 = Wk2.getDate();
					//if (wknbr == 1) { alert(yr + '/' + mo + '/' + dy + '/' + Wk2 + '/' + mo2 + '/' + dy2); }
					vdate = mo + '/' + dy + '-' + mo2 + '/' + dy2;
					if (wknbr < 0) {
						switch (wknbr) {
							case -13:
								document.getElementById('lblHdrCol14').innerHTML = vdate;
								break;
							case -8:
								document.getElementById('lblHdrCol15').innerHTML = vdate;
								break;
							case -4:
								document.getElementById('lblHdrCol16').innerHTML = vdate;
								break;
							default:
								break;
						}
					}
					else {
						if (wknbr > 0 && wknbr < 15) {
							document.getElementById('lblHdrCol' + (wknbr + 17).toString()).innerHTML = vdate; //starting with lblHdrCol18
						}
					}
				}
			}
			return false;
		}

		function FillGridColumnTotals() {
			for (var itm = 14; itm <= 31; itm++) {
				document.getElementById('lblCol' + itm.toString()).innerHTML = jsfNumberFormatNf(jaColTotals[itm - 14], 1, '.', ',');
			}
			//alert('Done setting totals');
			return false;
		}

		function FillQueryActionList() {
			var content = '<table id="tblQueryActionList" style="padding:1px;border-spacing:0px;margin: auto auto;">';
			content = content + '<tr><th class="ColHeaderStd" style="width:60px;">ID</th><th class="ColHeaderStd" style="width:200px;">Query Name</th><th class="ColHeaderStd" style="width:100px;">Action</th>';
			if (MyQueryList !== undefined && MyQueryList !== null) {
				var nrows = MyQueryList.length;
				if (nrows > 0) {
					for (var row = 0; row < nrows; row++) {
						content = content + '<tr><td class="StdTableCell" style="width:60px;">' + MyQueryList[row]['UserQueryID'].toString() + '</td>';
						content = content + '<td class="StdTableCell" style="width:200px;">' + MyQueryList[row]['QueryName'].toString() + '</td>';
						content = content + '<td class="StdTableCell" style="width:100px;text-align:center;">';
						content = content + '<button class="button blue-gradient glossy" id="btnQueryActionD' + row.toString() + '" onclick="javascript:ChangeQueryAction(3,' + MyQueryList[row]['UserQueryID'].toString();
						content = content + ',' + StringifyTx('') + ');return false;">Del</button></td></tr>';
					}
				}
				else {
					content = content + '<tr><td class="StdTableCell" colspan="3">No Queries were found</td></tr>';
				}
			}
			content = content + '</table>';
			return content;
		}

		function HandleImageClick(id, col, objid) {
			return false;
		}

		function ManageQueryList() {
			GetUserQueryList();	 // fills MyQueryList
			var ht = 600;
			var wdth = 400;
			var content = FillQueryActionList();
			//showPopupEditBoxDb('divCommonPopup', 'Edit Queries', true, true, ht, wdth, '', '', window, content, 3, '11pt', '2px', 'fadeIn', 'fadeOut', 'MyDialogButtonStd', 'MyDialogStd', 3)
			ShowSpecialMsgDialogBoxDx('divCommonPopup', 'Edit Queries', true, true, ht, wdth, '', '', window, content, 11, 'fadeIn', 'fadeOut', 'Continue', 3);  // anchorname may be oAnchor
			return false;
		}

		function TailorVisibleColumns() {
			//alert('Fired!');
			GetColumnViewSettings();
			//alert('populating');
			PopulateColumnSettings();
			//alert('Fired 2!');
			GetFilterViewSettings();
			//alert('populating 2');
			PopulateColFilterSettings();
			//alert('showing');
			var ht = 600;
			var wdth = 560;
			showPopupEditBoxDx('divColEditPopup', 'Edit Column Visibility', true, true, ht, wdth, '', '', window, '', 3, '11pt', '2px', 'fadeIn', 'fadeOut', 'MyDialogButtonStd', 'MyDialogStd', 3)
			//alert('Done!');
			return false;
		}

		function ViewOneRec(id, row, objid) {
			return false;
		}

		// ****************************** Background *************************************

		function EmptyGridColumnTotals() {
			for (var itm = 0; itm < 35; itm++) {
				jaColTotals[itm] = 0;
			}
			return false;
		}

		function EmptyGridProdTotals(typ) {
			for (var itm = 0; itm < 30; itm++) {
				switch (typ) {
					case 0:
						jfColSKUTotals[itm] = 0;
						break;
					case 1:
						jfColProdTotals[itm] = 0;
						break;
					case 2:
						jfColSpeciesTotals[itm] = 0;
						break;
					case 3:
						jfColThickTotals[itm] = 0;
						break;
					case 4:
						jfColGradeTotals[itm] = 0;
						break;
					case 5:
						jfColColorTotals[itm] = 0;
					case 6:
						jfColNoPrintTotals[itm] = 0;
						break;
					case 7:
						jfColSortTotals[itm] = 0;
						break;
					default:
						break;
				}
			}
			return false;
		}

		function InsertGridTotals() {
			for (var itm = 0; itm <= 17; itm++) {
				document.getElementById('lblCol' + (itm + 14).toString()).innerHTML = jsfNumberFormatNf(jaColTotals[itm], 1, '.', ','); // 14 is 0
			}
			return false;
		}

		function ShowProdGridProductTotals(typ, pref, clspn, labelx, c0, c1, c2, c3, c4) {
			try {
				var cell;
				var clspn2 = jiNbrColsSection1 - clspn;
				//alert(typ + '/' + pref + '/' + labelx + '/' + clspn2 + '/' + jiNbrColsSection1 + '/' + clspn);
				var fig = 0;
				var row = document.createElement("tr");
				// attach leftmost label cells
				for (var pcol = 0; pcol < clspn2; pcol++) {
					cell = document.createElement("td");
					cell.id = pref + '00' + pcol.toString();
					cell.style.height = '18px';
					cell.style.backgroundColor = '#FFFFCC';
					cell.style.padding = '1px';
					cell.innerHTML = '&nbsp;';
					cell.style.borderTop = 'none';
					cell.style.borderBottom = 'none';
					cell.style.borderLeft = '1px solid gray';
					cell.style.borderRight = '1px solid gray';
					row.appendChild(cell);
				}

				cell = document.createElement("td");
				cell.id = pref + '00ac';
				cell.style.borderTop = '1px solid gray';
				cell.style.borderLeft = '1px solid gray';
				cell.style.borderRight = '4px double gray';
				cell.style.borderBottom = '1px solid gray';
				cell.style.height = '18px';
				cell.colSpan = clspn.toString();
				cell.style.fontWeight = 'bold';
				cell.style.padding = '1px';
				cell.style.whiteSpace = 'nowrap';
				cell.style.backgroundColor = '#FFFFCC';
				cell.style.textAlign = 'right';
				cell.innerHTML = '&nbsp;' + labelx + '&nbsp;';
				row.appendChild(cell);

				// attach subtotals
				for (var itm = 0; itm <= 17; itm++) {
					cell = document.createElement("td");
					cell.id = pref + 'Col' + itm.toString();
					cell.style.border = '1px solid gray';
					cell.style.paddingTop = '1px;';
					cell.style.paddingBottom = '1px';
					cell.style.paddingTop = '1px';
					cell.style.paddingRight = '2px';
					cell.style.paddingLeft = '2px;';
					cell.style.color = '#0099CC';
					cell.style.textAlign = 'right';
					cell.style.height = '18px';
					cell.style.fontWeight = 'bold';
					switch (typ) {
						case 0: // SKUs
							cell.innerHTML = jsfNumberFormatNf(jfColSKUTotals[itm], 1, '.', ',');
							fig += jfColSKUtotals[itm];
							break;
						case 1: // products
							//alert(jfColProdTotals[itm] + '/' + jsfNumberFormatNf(jfColProdTotals[itm], 1, '.', ','));
							cell.innerHTML = jsfNumberFormatNf(jfColSKUtotals[itm], 1, '.', ',');
							fig += jfColSKUtotals[itm];
							break;
						case 2: // species
							cell.innerHTML = jsfNumberFormatNf(jfColSpeciesTotals[itm], 1, '.', ',');
							fig += jfColSpeciesTotals[itm];
							break;
						case 3: // thickness
							cell.innerHTML = jsfNumberFormatNf(jfColThickTotals[itm], 1, '.', ',');
							fig += jfColThickTotals[itm]
							break;
						case 4: // grade
							cell.innerHTML = jsfNumberFormatNf(jfColGradeTotals[itm], 1, '.', ',');
							fig += jfColGradeTotals[itm];
							break;
						case 5: // color
							cell.innerHTML = jsfNumberFormatNf(jfColColorTotals[itm], 1, '.', ',');
							fig += jfColColorTotals[itm];
							break;
						case 6: // sort
							cell.innerHTML = jsfNumberFormatNf(jfColSortTotals[itm], 1, '.', ',');
							fig += jfColSortTotals[itm];
							break;
						case 7: // noprint
							cell.innerHTML = jsfNumberFormatNf(jfColNoPrintTotals[itm], 1, '.', ',');
							fig += jfColNoPrintTotals[itm];
							break;
						default:
							cell.innerHTML = 'N/A';
							break;
					}
					row.appendChild(cell);
					// no row totals so fig not currently used
				}
				return row;
			}
			catch (ex) {
				alert('Error attaching sub-totals for ' + labelx + ex.message);
				return '';
			}
		}

		// ****************************** UI *************************************

		function ChangeColSetting(itm, chckd) {
			var ischecked = 0;
			if (chckd === true) { ischecked = 1; }
			SaveColSettingValue(itm, 'SPlnCols', ischecked.toString());
		}

		function ChangeCustFilter(val) {
			if (val !== '' && val !== '0') {
				var li;
				jhfCustCode.value = '';
				jtFilterCustDD.value = '';
				// memove ch
				for (var i=0;i<jiNbrCustomers;i++) {
					li = document.getElementById('custnbr' + i.toString());
					julCustomerMF.removeChild(li);
				}
			}
			return false;
		}

		function ChangeCustomerSelect(val) {
			if (val !== '' && val !== '0') {
				jhfCustCode.value = '';
				jtFilterCustDD.value = '';
				jtFilterColCust.value = '';
			}
			return false;
		}

		// Called when Date Type select is changed
		function ChangeDataType(val) {
			//alert('fired!');
			var fig = parseInt(val, 10);
			if (fig !== jiDataType) {
				jiDataType = fig;
				ResetVisibleData();
			}
			return false;
		}

		function ChangeFilterSetting(itm, chckd) {
			var ischecked = 0;
			if (chckd === true) { ischecked = 1; }
			SaveColSettingValue(itm, 'SalesPFltr', ischecked.toString());
		}

		function ChangeGradeFFilter(val) {
			if (val !== '') {
				jselGradeMF.value = '';
			}
		}

		function ChangeGradeFilter(val) {
			if (val !== '' && val !== '0') {
				jtFilterColGrade.value = '';
			}
			return false;
		}

		function ChangeLocationCode(val) {
			jlPageStatus.innerHTML = "Please wait...";
			jsLocationCode = val;
			GetRegionForLoc(val);
			jselRegionMF.value = jsRegionCode;
			PopulateProductList();
			PopulateThicknessListByRegion();
			PopulateGradeListByRegion();
			PopulateSpeciesListByRegion();
			PopulateLocationListByRegion();
			jselLocationMF.value = jsLocationCode;
			jlPageStatus.innerHTML = "Page Ready";
			return false;
		}

		function ChangeManagedType(val) {
			jlPageStatus.innerHTML = 'Please wait...';
			//jselTypeMain.value = val;
			jsManagedType = val;
			RefreshSalesData();
			jlPageStatus.innerHTML = 'Page Ready';
			return false;
		}

		function ChangeManagerFFilter(val) {
			if (val !== '') {
				jselManagerMF.value = '';
			}
		}

		function ChangeManagerFilter(val) {
			if (val !== '' && val !== '0') {
				jtFilterColMgr.value = '';
			}
			return false;
		}

		function ChangePageSize(val) {
			//alert('1');
			jiPageSize = parseInt(val, 10);
			//alert('2');
			jiPgSizePj[0] = jiPageSize;
			//alert('3');
			RefreshSalesData();
			return false;
		}

		function ChangePriceAnalysisView(val) {
			jiPriceAnalysisView = parseInt(val, 10);
			switch (jiPriceAnalysisView) {
				case 0: // do nothing
					break;
				case 1:	// Specie Shipped
					break;
				case 2:	// Specie Shipped In-Transit
					break;
				case 3: // Specie Shipped by GradeGroup
					break;
				case 4: // Specie/GradeGroup/Thick/Grade
					break;
				case 5: // Specie Summary
					break;
				case 6:	// Detailed 30 Day View
					break;
				default:
					break;
			}
			
			return false;
		}

		function ChangeProdType(val) {
			jlPageStatus.innerHTML = 'Please wait...';
			jsProdType = val;
			RefreshSalesData();
			jlPageStatus.innerHTML = 'Page Ready';
			return false;
		}

		function ChangeProductFFilter(val) {
			if (val !== '') {
				jselProductMF.value = '';
			}
		}

		function ChangeProductFilter(val) {
			if (val !== '' && val !== '0') {
				jtFilterColProd.value = '';
			}
			return false;
		}

		function ChangeRegionCode(val) {
			jlPageStatus.innerHTML = "Updating filters, Please wait...";
			jsRegionCode = val;
			//alert('updating location');
			PopulateLocationListByRegion();
			//alert('updating prods');
			PopulateProductList();
			//alert('updating thickness');
			PopulateThicknessListByRegion();
			//alert('updating grades');
			PopulateGradeListByRegion();
			//alert('updating species');
			PopulateSpeciesListByRegion();
			jlPageStatus.innerHTML = "Page Ready";
			return false;
		}

		function ChangeSalesOrProd(val) {
			jlPageStatus.innerHTML = 'Please wait...';
			jiProdOrSales = parseInt(val, 10);
			RefreshSalesData();
			jlPageStatus.innerHTML = 'Page Ready';
			return false;
		}

		function ChangeSortBy(val) {
			var srt = parseInt(val, 10);
			switch (val) {
				case 0: // species
					jspnSubTotBlockSpecie.style.display = 'inline';
					jspnSubTotBlockThick.style.display = 'none';
					jspnSubTotBlockGrade.style.display = 'none';
					break;
				case 1: // thickness
					jspnSubTotBlockSpecie.style.display = 'none';
					jspnSubTotBlockThick.style.display = 'inline';
					jspnSubTotBlockGrade.style.display = 'none';
					break;
				case 2: // grade
					jspnSubTotBlockSpecie.style.display = 'none';
					jspnSubTotBlockThick.style.display = 'none';
					jspnSubTotBlockGrade.style.display = 'inline';
					break;
				case 3:	// color
					break;
				case 4: // sort
					break;
				case 5: // noprint
					break;
				case 6: // product
					break;
				default:
					break;
			}
			return false;
		}

		function ChangeSortFFilter(val) {
			if (val !== '') {
				jselSortMF.value = '';
			}
		}

		function ChangeSortFilter(val) {
			if (val !== '' && val !== '0') {
				jtFilterColSort.value = '';
			}
			return false;
		}

		function ChangeSubtotalType(typ, chk) {
			switch (typ) {
				case 0:
					jbSubtotalProd = chk;
					break;
				case 1:
					jbSubtotalSpecies = chk;
					break;
				case 2:
					jbSubtotalThick = chk;
					break;
				case 3:
					jbSubtotalGrade = chk;
					break;
				case 4:
					jbSubtotalProdAs = chk;
					break;
				case 5:
					jbSubtotalColor = chk;
					break;
				case 6:
					jbSubtotalSort = chk;
					break;
				case 7:
					jbSubtotalNoPrint = chk;
					break;
				default:
					break;
			}
			return false;
		}

		function ChangeViewType(val) {
			//alert('Changing view: ' + val);
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
			return false;
		}

		function ChangeZeroValSetting(chkd) {
			if (chkd === true) {
				jbShow0s = true;
			}
			else {
				jbShow0s = false;
			}
			//PopulateSalesGrid();
			RefreshSalesData();
			jlPageStatus.innerHTML = "Page Ready";
		}

		function EmptyCustomerCodeList() {
			//var items = julCustomerMF.getElementsByTagName("li");
			//if (items.length > 0) {
			//	for (var i = 0; i < items.length; ++i) {
			//		julCustomerMF.removeChild(items[i]);
			//	}
			//}
			$('#ulCustomerMF').empty();
			return false;
		}

		function GetCustomerCodeList() {
			var id = '';
			var s = '';
			var items = julCustomerMF.getElementsByTagName("li");
			for (var i = 0; i < items.length; ++i) {
				id = items[i].id;
				if (s.length > 0) { s = s + ','; }
				s = s + id.replace('cn-', '');
			}
			return s;
		}

		function HideAllMainAreas() {
			jdivMainSalesGrid.style.display = 'none';
			jdivPriceAnalysisGrid.style.display = 'none';
			jdivPriceAnalysisSummary.style.display = 'none';
			return false;
		}

		function IncludeCustomersInGrid(chkd) {
			jlPageStatus.innerHTML = 'Please wait...';
			jbIncCustomers = chkd;
			RefreshSalesData();
			jlPageStatus.innerHTML = 'Page Ready';
			return false;
		}

		function IncludeForecastInGrid(chkd) {
			jlPageStatus.innerHTML = 'Please wait...';
			jbIncForecast = chkd;
			RefreshSalesData();
			jlPageStatus.innerHTML = 'Page Ready';
			return false;
		}

		function IncludeHoldsInGrid(chkd) {
			jlPageStatus.innerHTML = 'Please wait...';
			jbIncHolds = chkd;
			RefreshSalesData();
			jlPageStatus.innerHTML = 'Page Ready';
			return false;
		}

		function IncludeHistoryInGrid(chkd) {
			jlPageStatus.innerHTML = 'Please wait...';
			jbIncHistory = chkd;
			RefreshSalesData();
			jlPageStatus.innerHTML = 'Page Ready';
			return false;
		}

		function LoadCustomerCodeList(cust) {
			var li;
			var val;
			if (cust !== undefined || cust !== null) {
				EmptyCustomerCodeList();
				jiNbrCustomers = 0;
				var items = cust.split(',');
				if (MyCustomerList !== undefined && MyCustomerList !== null && items.length > 0) {
					for (var i = 0; i < items.length; i++) {
						val = items[i];
						for (var c = 0; c < MyCustomerList.length; c++) {
							if (MyCustomerData[itm]['cust'].toString() == val) {
								li = document.createElement("li");
								val2 = ' <input type="checkbox" id="cn-' + val + '" checked="checked" onchange="javascript:RemoveCustomerItem(' + StringifyTx(val) + ',' + StringifyTx('cn-' + val) + ');return false;">';
								li.appendChild(document.createTextNode(MyCustomerData[itm]['CustName'].toString() + val2));
								julCustomerMF.appendChild(li);
								jiNbrCustomers++;
								break;
							}
						}
					}
				}
				else {
					li = document.createElement("li");
					li.appendChild(document.createTextNode('No Items Listed'));
					li.id = 'liDefaultItem';
					julCustomerMF.appendChild(li);
				}
			}
			return false;
		}

		function LoadSavedQueryData(val) {
			jlPageStatus.innerHTML = 'Refreshing data...';
			var n = 0;
			var str = '';
			GetUserQueryData();
			if (MyQueryData !== undefined && MyQueryData !== null) {
				if (MyQueryData.length > 0) {
					//alert('setting items');
					jtQueryTitle.value = MyQueryData[0]['QueryName'].toString();
					jiPageNbr = TryParseIntNf(MyQueryData[0]['PgNbr'].toString(), 0);
					var np = parseInt(jselPageSize.value, 10);
					jiPageSize = TryParseIntNf(MyQueryData[0]['PgSize'].toString(), np);
					//var itype = parseInt(MyQueryData[0]['TypeID'], 10);
					//jselViewType.value = itype;
					//alert('setting multiple items');
					SelectMultipleItemsInList(MyQueryData[0]['ProductCode'].toString(), jselProductMF);
					SelectMultipleItemsInList(MyQueryData[0]['RegionCode'].toString(), jselRegionMF);
					SelectMultipleItemsInList(MyQueryData[0]['LocationCode'].toString(), jselLocationMF);
					SelectMultipleItemsInList(MyQueryData[0]['SpeciesCode'].toString(), jselSpeciesMF);
					SelectMultipleItemsInList(MyQueryData[0]['ThicknessCode'].toString(), jselThickMF);
					SelectMultipleItemsInList(MyQueryData[0]['GradeCode'].toString(), jselGradeMF);
					SelectMultipleItemsInList(MyQueryData[0]['SeasoningCode'].toString(), jselSeasoningMF);
					SelectMultipleItemsInList(MyQueryData[0]['LengthCode'].toString(), jselLengthMF);
					SelectMultipleItemsInList(MyQueryData[0]['ColorCode'].toString(), jselColorMF);
					SelectMultipleItemsInList(MyQueryData[0]['SortCode'].toString(), jselSortMF);
					SelectMultipleItemsInList(MyQueryData[0]['MillingCode'].toString(), jselMillingMF);
					SelectMultipleItemsInList(MyQueryData[0]['NoPrintCode'].toString(), jselNoPrintMF);
					SelectMultipleItemsInList(MyQueryData[0]['ProductCode'].toString(), jselProductMF);
					SelectMultipleItemsInList(MyQueryData[0]['ManagerName'].toString(), jselManagerMF);
					var cust = MyQueryData[0]['CustCode'].toString();
					if (cust.substr(0, 3) === 'DL|') {
						jhfCustCode.value = cust.replace('DL|', '');
					}
					else {
						if(cust.substr(0,3) === 'FF|') {
							jtFilterColCust.value = cust.replace('FF|', '');
						}
						else {
							LoadCustomerCodeList(cust.replace('SL|', ''));
						}
					}
					//alert('setting checkbox grouping');
					var itemsettings = MyQueryData[0]['ItemCode'].toString();
					if (itemsettings.substr(0, 1) === '1') {
						jchkSubtotalProducts.checked = true;
					}
					else {
						jchkSubtotalProducts.checked = false;
					}
					if (itemsettings.substr(1, 1) === '1') {
						jchkSubtotalProdAttribs.checked = true;
					}
					else {
						jchkSubtotalProdAttribs.checked = false;
					}
					if (itemsettings.substr(2, 1) === '1') {
						jchkSubtotalSpecies.checked = true;
					}
					else {
						jchkSubtotalSpecies.checked = false;
					}
					if (itemsettings.substr(3, 1) === '1') {
						jchkSubtotalThickness.checked = true;
					}
					else {
						jchkSubtotalThickness.checked = false;
					}
					if (itemsettings.substr(4, 1) === '1') {
						jchkSubtotalGrade.checked = true;
					}
					else {
						jchkSubtotalGrade.checked = false;
					}
					if (itemsettings.substr(5, 1) === '1') {
						jchkSubtotalColor.checked = true;
					}
					else {
						jchkSubtotalColor.checked = false;
					}
					if (itemsettings.substr(6, 1) === '1') {
						jchkSubtotalSort.checked = true;
					}
					else {
						jchkSubtotalSort.checked = false;
					}
					if (itemsettings.substr(7, 1) === '1') {
						jchkSubtotalNoPrint.checked = true;
					}
					else {
						jchkSubtotalNoPrint.checked = false;
					}

					//alert('setting settings');
					var s0 = MyQueryData[0]['Setting0'].toString();
					if (s0 === '1') {
						jchkIncCustomers.checked = true;
					}
					else {
						jchkIncCustomers.checked = false;
					}
					jselManagedMain.value = MyQueryData[0]['Setting1'].toString();
					var s2 = MyQueryData[0]['Setting2'].toString();
					var zeros = MyQueryData[0]['Setting3'].toString();
					if (zeros === '1') {
						jchkShowZeros.checked = true;
					}
					else {
						jchkShowZeros.checked = false;
					}
					jselDataTypes.value = MyQueryData[0]['Setting4'].toString();
					jselGroupSortBy.value = MyQueryData[0]['Setting5'].toString();
					var set6 = 0;
					var s6 = MyQueryData[0]['Setting6'].toString();
					if (s6 === '1') {
						jchkIncHolds.checked = true;
					}
					else {
						jchkIncHolds.checked = false;
					}
					var s7 = MyQueryData[0]['Setting7'].toString();
					if (s7 === '1') {
						jchkIncHistory.checked = true;
					}
					else {
						jchkIncHistory.checked = false;
					}

					//alert('setting checkboxes');
					//alert('Getting new data');
					jiDataType = parseInt(MyQueryData[0]['ObjectID'], 10);
					ResetVisibleData();
					jlPageStatus.innerHTML = 'Page Ready';
					return true;
				}	//MyQueryData.length > 0
				else {
					jlPageStatus.innerHTML = 'Page Ready';
					return false;
				}
			}	//MyQueryData !== undefined && MyQueryData !== null
			else {
				jlPageStatus.innerHTML = 'Page Ready';
				return false;
			}
		}

		function RefilterMainGrid() {
			jlPageStatus.innerHTML = 'Please wait...';
			switch (jiDataType) {
				case 0:
					RefreshSalesData();
					break;
				case 1:
					RefreshPriceAnalysisData();
					break;
				case 2:
					RefreshPriceAnalysisData();
					break;
				case 3:
					RefreshPriceAnalysisSum();
					break;
				default:
					break;
			}
			jlPageStatus.innerHTML = 'Page Ready';
			return false;
		}

		function RefreshPriceAnalysisData() {


			return false;
		}

		function RefreshPriceAnalysisSum() {



			return false;
		}

		function RefreshSalesData() {
			//alert('emptying totals');
			jlPageStatus.innerHTML = 'Refreshing data...';
			//alert('getting data');
			DataCall1();
			//alert('calc totals');
			FillGridColumnTotals();
			//alert('done');
			jlPageStatus.innerHTML = 'Page Ready';
			return false;
		}

		function RemoveCustomerItem(itmname, idx) {
			//alert('FIRED REMOVAL - ' + itmname);
			$('#' + itmname).remove();
			jiNbrCustomers--;
			//alert(jiNbrCustomers);
			if (jiNbrCustomers < 0) { julCustomerMF = 0; }
			// add no cust notation
			if (jiNbrCustomers === 0) {
				li = document.createElement("li");
				li.appendChild(document.createTextNode('No Items Listed'));
				li.id = 'liDefaultItem';
				julCustomerMF.appendChild(li);
			}
			return false;
		}

		function ResetVisibleData() {
			//alert('1');
			HideAllMainAreas();
			//alert('2');
			RefilterMainGrid();
			jbPriceAnalysisBasic = false;
			switch (jiDataType) {
				case 0: // sales plan
					jiPgNbrPj[0] = 0;
					jiNbrPagesPj[0] = 0;
					jdivMainSalesGrid.style.display = 'block';
					break;
				case 1:	// price management = General
					//PopulateSpeciesListPA();
					jiPgNbrPj[1] = 0;
					jiNbrPagesPj[1] = 0;
					jdivPriceAnalysisGrid.style.display = 'block';
					ShowHidePriceColumns();
					break;
				case 2: // price management = Basic
					//PopulateSpeciesListPA();
					jiPgNbrPj[1] = 0;
					jiNbrPagesPj[1] = 0;
					jdivPriceAnalysisGrid.style.display = 'block';
					jbPriceAnalysisBasic = true;
					ShowHidePriceColumns();
					break;
					break;
				case 3: // price management - Summary
					//PopulateSpeciesListPA();
					jiPgNbrPj[2] = 0;
					jiNbrPagesPj[2] = 0;
					jdivPriceAnalysisSummary.style.display = 'block';
					break;
				default:
					break;
			}
			return false;
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

		function SetNewCustItem() {
			//alert('Fired');
			jtFilterColCust.value = '';
			var foundit = false;
			var cid = 0;
			var li;
			var nm = '';
			var txt = jtFilterCustDD.value;
			//alert(txt + '/' + jiNbrCustomers);
			// remove no items notation
			if (jiNbrCustomers === 0) {
				li = document.getElementById('liDefaultItem');
				julCustomerMF.removeChild(li);
			}
			//alert('beginning ident process');
			if (MyCustomerData !== undefined && MyCustomerData !== null) {
				var itmcount = MyCustomerData.length;
				//alert('Count ' + itmcount);
				if (itmcount > 2) {
					//alert('loop begins');
					for (var rw = 0; rw < itmcount; rw++) {
						nm = MyCustomerData[rw]['CustName'].toString();
						//alert(nm + '/' + txt);
						if (nm === txt) {
							//alert('Found it!');
							//foundit = true;
							cid = MyCustomerData[rw]['cust'].toString();
							//alert(id);
							li = document.createElement("li");
							li.id = 'cn-' + cid;
							li.innerHTML = nm + ' <input type="checkbox" id="cnc-' + cid + '" checked="checked" onchange="javascript:RemoveCustomerItem(' + StringifyTx('cn-' + cid) + ',' + jiNbrCustomers.toString() + ');return false;">';
							julCustomerMF.appendChild(li);
							jiNbrCustomers++;
							break;
						}
					}
				}
			}
			//alert(id);
			jhfCustCode.value = cid.toString();
			jtFilterCustDD.value = '';
			return false;
		}

		function SaveQueryFormat() {
			//var ttl = jtQueryTitle.value;
			jlPageStatus.innerHTML = 'Saving query...';
			UpdateUserQuery();
			PopulateQueryList();
			jselQueryList.value = jiQueryID.toString();
			jlPageStatus.innerHTML = 'Page Ready';
			return false;
		}

		function ShowHideColumns() {
			//alert('fired show-hide');
			var ds = 0;
			var nr = '';
			ncols = 0;
			var nactiveCols = 0;
			var st = 0;
			var tcol;
			var tcol2;
			if (MyColumnSettings !== undefined && MyColumnSettings !== null) {
				//alert('header change');
				var ncols = MyColumnSettings.length;
				if (ncols > 0) {
					for (var col = 0; col < 14; col++) {
						if (col <= ncols) {
							nr = MyColumnSettings[col]['ItemName'].toString().replace('Col ', '');
							// header
							if (jaColVisible[col] === 1) {
								document.getElementById('thHdrCol' + nr).style.display = 'table-cell';
								nactiveCols++;
							}
							else {
								document.getElementById('thHdrCol' + nr).style.display = 'none';
							}
						}
						if (jiNbrRows > 0) {
							for (var row = 0; row < jiNbrRows; row++) {
								if (st === 1) {
									document.getElementById('tdSalesGrid' + row.toString() + '_' + col.toString()).style.display = 'table-cell';
								}
								else {
									document.getElementById('tdSalesGrid' + row.toString() + '_' + col.toString()).style.display = 'none';
								}
							}
						}
					}	// var col = 0; col < 14; col++

					// handle totals column
					if (jaColVisible[14] === 1) {
						document.getElementById('thHdrCol17').style.display = 'table-cell';
					}
					else {
						document.getElementById('thHdrCol17').style.display = 'none';
					}

				}
			}
			jiNbrColsSection1 = nactiveCols;
			// footer
			if (nactiveCols !== 14) {
				document.getElementById('tfcell00').colSpan = nactiveCols.toString();
			}

			return false;
		}

		function ShowHidePriceColumns() {


			return false;
		}

		function ShowHideFilters() {
			var nactiveCols = 0;
			if (MyFilterSettings !== undefined && MyFilterSettings !== null) {
				//alert('header change-' + MyFilterSettings.length);
				var ncols = MyFilterSettings.length;
				if (ncols > 0) {
					for (var col = 0; col < 14; col++) {
						if (col <= ncols) {
							nr = MyFilterSettings[col]['ItemName'].toString().replace('Col ', '');
							// header
							//alert('thMainFilter' + nr);
							if (jaFilterVisible[col] === 1) {
								document.getElementById('thMainFilter' + nr).style.display = 'table-cell';
								document.getElementById('thMainFiltr2' + nr).style.display = 'table-cell';
								if (col === 4 || col === 8 || col === 11 || col === 12) {
									//alert('Col ' + col);
									document.getElementById('thMainFilter' + nr + 'a').style.display = 'table-cell';
								}
								nactiveCols++;
							}
							else {
								//alert('Hidding col ' + col.toString());
								document.getElementById('thMainFilter' + nr).style.display = 'none';
								document.getElementById('thMainFiltr2' + nr).style.display = 'none';
								if (col === 4 || col === 8 || col === 11 || col === 12) {
									document.getElementById('thMainFilter' + nr + 'a').style.display = 'none';
								}
							}
						}
					}
				}
			}
			jiNbrColsFilter1 = nactiveCols;
			// footer
			if (nactiveCols !== 14) {
				document.getElementById('tdFilterSettingsBar').colSpan = nactiveCols.toString();
			}

			return false;
		}

		function ToggleColumnsVisible(typ, colstart, colend) {
			var displ = 'none';
			var val = '';
			if (typ === 1) { displ = 'table-cell'; }
			//alert('Starting column for');
			for (var itm = colstart; itm <= colend; itm++) {
				val = itm.toString();
				if (val.length === 1) { val = '0' + val; }
				document.getElementById('thHdrCol' + val).style.display = displ;
				document.getElementById('tfcell' + val).style.display = displ;
				if (jiNbrRows > 0) {
					for (var row = 0; row < jiNbrRows; row++) {
						document.getElementById('tdConsolid' + row.toString() + '_' + itm.toString()).style.display = displ;
					}
				}
			}
			//alert('done');
			return false;
		}

		function EditColumnView() {


			return false;
		}

		function SaveUserSettings() {



			return false;
		}

		// ****************************** Other Pages *************************************

		function ExportToExcel() {
			SaveExportData();	// saves selection criteria for extracting data
			var url = '../shared/ExportSalesCSV.aspx?p=' + jiPageID.toString() + '&oj=1';
			window.open(url, '_popup', '', false);
			return false;
		}

		function ExportToPDF() {
			SaveExportData();	// saves selection criteria for extracting data
			var url = '../shared/ExportSalesPDF.aspx?p=' + jiPageID.toString() + '&oj=1';
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
	<asp:HiddenField ID="hfPageID" runat="server" Value="58" />

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

		<div id="divColEditPopup" style="display:none;">
			<div id="divColumnViewHdr" style="width:100%;">
				<label id="lblColumnView" style="color:blue;font-weight:bold;font-size:11pt;">Sales PLan Data Grid Column Visibility</label>
			</div>
			<div id="divColumnViewEdit" style="width:100%;">
				<table style="border-collapse:collapse;">		
				<tr>
					<th class="TableHdrCell">Col Nbr</th>
					<th class="TableHdrCell">Content</th>
					<th class="TableHdrCell">Setting</th>
					<th style="border: none;">&nbsp;&nbsp;&nbsp;</th>
					<th class="TableHdrCell">Col Nbr</th>
					<th class="TableHdrCell">Content</th>
					<th class="TableHdrCell">Setting</th>
					<th style="border: none;">&nbsp;&nbsp;&nbsp;</th>
					<th class="TableHdrCell">Col Nbr</th>
					<th class="TableHdrCell">Content</th>
					<th class="TableHdrCell">Setting</th>
				</tr>
				<tr>
					<td class="StdTableCell" style="text-align:center;">0</td>
					<td class="StdTableCell">Specie</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting0" checked="checked" onchange="javascript:ChangeColSetting('Col 00', this.checked); return false;" /></td>
					<td class="StdTableCell" style="border: none;">&nbsp;&nbsp;&nbsp;</td>
					<td class="StdTableCell" style="text-align:center;">5</td>
					<td class="StdTableCell">Length</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting5" checked="checked" onchange="javascript:ChangeColSetting('Col 05', this.checked); return false;" /></td>
					<td class="StdTableCell" style="border: none;">&nbsp;&nbsp;&nbsp;</td>
					<td class="StdTableCell" style="text-align:center;">10</td>
					<td class="StdTableCell">Product</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting10" checked="checked" onchange="javascript:ChangeColSetting('Col 10', this.checked); return false;" /></td>
				</tr>
				<tr>
					<td class="StdTableCell" style="text-align:center;">1</td>
					<td class="StdTableCell">Thickness</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting1" checked="checked" onchange="javascript:ChangeColSetting('Col 01', this.checked); return false;" /></td>
					<td class="StdTableCell" style="border: none;">&nbsp;&nbsp;&nbsp;</td>
					<td class="StdTableCell" style="text-align:center;">6</td>
					<td class="StdTableCell">Color</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting6" checked="checked" onchange="javascript:ChangeColSetting('Col 06', this.checked); return false;" /></td>
					<td class="StdTableCell" style="border: none;">&nbsp;&nbsp;&nbsp;</td>
					<td class="StdTableCell" style="text-align:center;">11</td>
					<td class="StdTableCell">Type</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting11" checked="checked" onchange="javascript:ChangeColSetting('Col 11', this.checked); return false;" /></td>
				</tr>
				<tr>
					<td class="StdTableCell" style="text-align:center;">2</td>
					<td class="StdTableCell">Grade</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting2" checked="checked" onchange="javascript:ChangeColSetting('Col 02', this.checked); return false;" /></td>
					<td class="StdTableCell" style="border: none;">&nbsp;&nbsp;&nbsp;</td>
					<td class="StdTableCell" style="text-align:center;">7</td>
					<td class="StdTableCell">Sort</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting7" checked="checked" onchange="javascript:ChangeColSetting('Col 07', this.checked); return false;" /></td>
					<td class="StdTableCell" style="border: none;">&nbsp;&nbsp;&nbsp;</td>
					<td class="StdTableCell" style="text-align:center;">12</td>
					<td class="StdTableCell">Manager</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting12" checked="checked" onchange="javascript:ChangeColSetting('Col 12', this.checked); return false;" /></td>
				</tr>
				<tr>
					<td class="StdTableCell" style="text-align:center;">3</td>
					<td class="StdTableCell">Seasoning</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting3" checked="checked" onchange="javascript:ChangeColSetting('Col 03', this.checked); return false;" /></td>
					<td class="StdTableCell" style="border: none;">&nbsp;&nbsp;&nbsp;</td>
					<td class="StdTableCell" style="text-align:center;">8</td>
					<td class="StdTableCell">Milling</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting8" checked="checked" onchange="javascript:ChangeColSetting('Col 08', this.checked); return false;" /></td>
					<td class="StdTableCell" style="border: none;">&nbsp;&nbsp;&nbsp;</td>
					<td class="StdTableCell" style="text-align:center;">13</td>
					<td class="StdTableCell">NoPrint</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting13" checked="checked" onchange="javascript:ChangeColSetting('Col 13', this.checked); return false;" /></td>
				</tr>
				<tr>
					<td class="StdTableCell" style="text-align:center;">4</td>
					<td class="StdTableCell">Surface</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting4" checked="checked" onchange="javascript:ChangeColSetting('Col 04', this.checked); return false;" /></td>
					<td class="StdTableCell" style="border: none;">&nbsp;&nbsp;&nbsp;</td>
					<td class="StdTableCell" style="text-align:center;">9</td>
					<td class="StdTableCell">NoPrint</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting9" checked="checked" onchange="javascript:ChangeColSetting('Col 09', this.checked); return false;" /></td>
					<td class="StdTableCell" style="border: none;">&nbsp;&nbsp;&nbsp;</td>
					<td class="StdTableCell" style="text-align:center;">14</td>
					<td class="StdTableCell">Totals</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColSetting14" checked="checked" onchange="javascript:ChangeColSetting('Col 14', this.checked); return false;" /></td>
				</tr>
				<tr>
					<td colspan="11" style="border:none;">
						<div id="divFilterColVisSection" style="margin-top:6px;">
							<label style="color:blue;font-weight:bold;font-size:11pt;">Filtering Column Visibility</label>
						</div>
					</td>
				</tr>
				<tr>
					<td class="TableHdrCell">Col Nbr</td>
					<td class="TableHdrCell">Content</td>
					<td class="TableHdrCell">Setting</td>
					<td style="border:none;">&nbsp;&nbsp;&nbsp;</td>
					<td class="TableHdrCell">Col Nbr</td>
					<td class="TableHdrCell">Content</td>
					<td class="TableHdrCell">Setting</td>
				</tr>
				<tr>
					<td class="StdTableCell" style="text-align:center;">0</td>
					<td class="StdTableCell">Region</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColFSetting0" checked="checked" onchange="javascript:ChangeFilterSetting('Col 00', this.checked); return false;" /></td>
					<td style="border:none;">&nbsp;&nbsp;&nbsp;</td>
					<td class="StdTableCell" style="text-align:center;">7</td>
					<td class="StdTableCell">Color</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColFSetting7" checked="checked" onchange="javascript:ChangeFilterSetting('Col 07', this.checked); return false;" /></td>
				</tr>
				<tr>
					<td class="StdTableCell" style="text-align:center;">1</td>
					<td class="StdTableCell">Location</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColFSetting1" checked="checked" onchange="javascript:ChangeFilterSetting('Col 01', this.checked); return false;" /></td>
					<td style="border:none;">&nbsp;&nbsp;&nbsp;</td>
					<td class="StdTableCell" style="text-align:center;">8</td>
					<td class="StdTableCell">Sort</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColFSetting8" checked="checked" onchange="javascript:ChangeFilterSetting('Col 08', this.checked); return false;" /></td>
				</tr>
				<tr>
					<td class="StdTableCell" style="text-align:center;">2</td>
					<td class="StdTableCell">Species</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColFSetting2" checked="checked" onchange="javascript:ChangeFilterSetting('Col 02', this.checked); return false;" /></td>
					<td style="border:none;">&nbsp;&nbsp;&nbsp;</td>
					<td class="StdTableCell" style="text-align:center;">9</td>
					<td class="StdTableCell">Milling</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColFSetting9" checked="checked" onchange="javascript:ChangeFilterSetting('Col 09', this.checked); return false;" /></td>
				</tr>
				<tr>
					<td class="StdTableCell" style="text-align:center;">3</td>
					<td class="StdTableCell">Thickness</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColFSetting3" checked="checked" onchange="javascript:ChangeFilterSetting('Col 03', this.checked); return false;" /></td>
					<td style="border:none;">&nbsp;&nbsp;&nbsp;</td>
					<td class="StdTableCell" style="text-align:center;">10</td>
					<td class="StdTableCell">NoPrint</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColFSetting10" checked="checked" onchange="javascript:ChangeFilterSetting('Col 10', this.checked); return false;" /></td>
				</tr>
				<tr>
					<td class="StdTableCell" style="text-align:center;">4</td>
					<td class="StdTableCell">Grade</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColFSetting4" checked="checked" onchange="javascript:ChangeFilterSetting('Col 04', this.checked); return false;" /></td>
					<td style="border:none;">&nbsp;&nbsp;&nbsp;</td>
					<td class="StdTableCell" style="text-align:center;">11</td>
					<td class="StdTableCell">Product</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColFSetting11" checked="checked" onchange="javascript:ChangeFilterSetting('Col 11', this.checked); return false;" /></td>
				</tr>
				<tr>
					<td class="StdTableCell" style="text-align:center;">5</td>
					<td class="StdTableCell">Seasoning</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColFSetting5" checked="checked" onchange="javascript:ChangeFilterSetting('Col 05', this.checked); return false;" /></td>
					<td style="border:none;">&nbsp;&nbsp;&nbsp;</td>
					<td class="StdTableCell" style="text-align:center;">12</td>
					<td class="StdTableCell">Manager</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColFSetting12" checked="checked" onchange="javascript:ChangeFilterSetting('Col 12', this.checked); return false;" /></td>
				</tr>
				<tr>
					<td class="StdTableCell" style="text-align:center;">6</td>
					<td class="StdTableCell">Length</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColFSetting6" checked="checked" onchange="javascript:ChangeFilterSetting('Col 06', this.checked); return false;" /></td>
					<td style="border:none;">&nbsp;&nbsp;&nbsp;</td>
					<td class="StdTableCell" style="text-align:center;">13</td>
					<td class="StdTableCell">Customer</td>
					<td class="StdTableCell" style="text-align:center;"><input type="checkbox" id="chkColFSetting13" checked="checked" onchange="javascript:ChangeFilterSetting('Col 13', this.checked); return false;" /></td>
				</tr>
				</table>
			</div>
		</div>

		<div id="divCommonPopup" style="display:none;text-align:center;"></div>

		<div id="divPAGEHEADER" style="width:99%;margin-left:10px;">
			<div id="divPgHdrTopLabel" style="width:100%;text-align:center;">
				<label id="lblPageHdrMain" style="font-weight:bold;color:blue;font-size:14pt;">Northwest Hardwoods Sales Planning</label>
			</div>

			<div id="divPgHdrFilters" style="width:100%;">
	
				<div id="divMainTitle" style="width:100%;">
					<label id="lblMainHdrTitle" style="color:darkgray;font-size:11pt;font-weight:bold;margin-left:6px;">Filters:</label>
					<label id="lblPageStatus" style="position:absolute;font-size:10pt;font-weight:bold;color:darkgray;right:70px;">Page Loading...</label>
				</div>
				<div id="divMainFilters" style="width:100%;text-align:center;">
					<table id="divCalFilters" style="padding:2px;border-spacing:0px;width:100%;">
					<tr>
						<th id="thMainFilter00" class="TableHdrCellPgTop" style="width:4%;" rowspan="2">
							Region
						</th>
						<th id="thMainFilter01" class="TableHdrCellPgTop" style="width:8%;" rowspan="2">
							Location
						</th>
						<th id="thMainFilter02" class="TableHdrCellPgTop" style="width:6%;" rowspan="2">
							Species
						</th>
						<th id="thMainFilter03" class="TableHdrCellPgTop" style="width:4%;" rowspan="2">
							Thickness
						</th>
						<th id="thMainFilter04" class="TableHdrCellPgTop" style="width:6%;">
							Grade
						</th>
						<th id="thMainFilter05" class="TableHdrCellPgTop" style="width:6%;" rowspan="2">
							Seasoning
						</th>
						<th id="thMainFilter06" class="TableHdrCellPgTop" style="width:4%;" rowspan="2">
							Length
						</th>
						<th id="thMainFilter07" class="TableHdrCellPgTop" style="width:6%;" rowspan="2">
							Color
						</th>
						<th id="thMainFilter08" class="TableHdrCellPgTop" style="width:6%;">
							Sort
						</th>
						<th id="thMainFilter09" class="TableHdrCellPgTop" style="width:6%;" rowspan="2">
							Milling
						</th>
						<th id="thMainFilter10" class="TableHdrCellPgTop" style="width:6%;" rowspan="2">
							NoPrint
						</th>
						<th id="thMainFilter11" class="TableHdrCellPgTop" style="width:6%;">
							Product
						</th>
						<th id="thMainFilter12" class="TableHdrCellPgTop" style="width:6%;">
							Manager
						</th>
						<th id="thMainFilter13" class="TableHdrCellPgTop" style="width:260px;white-space:nowrap;">
							Customer
						</th>
					</tr>
					<tr>
						<th id="thMainFilter04a" class="TableHdrCellPgBottom" style="width:6%;">
							<input type="text" id="txtFilterColGrade" style="width:70px;" onchange="javascript:ChangeGradeFFilter(this.value);return false;" />%
						</th>
						<th id="thMainFilter08a" class="TableHdrCellPgBottom" style="width:6%;">
							<input type="text" id="txtFilterColSort" style="width:60px;" onchange="javascript:ChangeSortFFilter(this.value);return false;" />%
						</th>
						<th id="thMainFilter11a" class="TableHdrCellPgBottom" style="width:6%;">
							%<input type="text" id="txtFilterColProd" style="width:100px;" onchange="javascript:ChangeProductFFilter(this.value);return false;" />%
						</th>
						<th id="thMainFilter12a" class="TableHdrCellPgBottom" style="width:6%;">
							<input type="text" id="txtFilterColMgr" style="width:70px;" onchange="javascript:ChangeManagerFFilter(this.value);return false;" />%
						</th>
						<th id="thMainFilter13a" class="TableHdrCellPgBottom" style="width:220px;white-space:nowrap;">
							<label style="color:white;">DList:</label><input type="text" id="txtFilterCustDD" style="width:120px;" onblur="javascript:SetNewCustItem();return false;" />&nbsp;&nbsp;
							%<input type="text" id="txtFilterColCust" style="width:70px;" onchange="javascript:ChangeCustFilter(this.value);return false;" />%
							<input type="hidden" id="hfCustomerCode" value="0" />
						</th>
					</tr>
					<tr>
						<td id="thMainFiltr200" class="StdTableCell">
							<select id="selRegionMF" multiple onchange="javascript:ChangeRegionCode(this.value);return false;" class="FontNarrowish" style="height:90px;">
								<option Value="0" Selected="selected">ALL</option>
								<option Value="APP">APP</option>
								<option Value="GLA">Glacial</option>
								<option Value="NORTH">North</option>
								<option Value="WEST">West</option>
							</select>
						</td>
						<td id="thMainFiltr201" class="StdTableCell">
							<select id="selLocationMF" multiple class="FontNarrowish" style="height:90px;" onchange="javascript:ChangeLocationCode(this.value);return false;" >
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr202" class="StdTableCell">
							<select id="selSpeciesMF" multiple class="FontNarrowish" style="height:90px;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr203" class="StdTableCell">
							<select id="selThickMF" multiple class="FontNarrowish" style="height:90px;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr204" class="StdTableCell">
							<select id="selGradeMF" multiple class="FontNarrowish" style="height:90px;" onchange="javascript:ChangeGradeFilter(this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr205" class="StdTableCell">
							<select id="selSeasoningMF" multiple class="FontNarrowish" style="height:90px;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr206" class="StdTableCell">
							<select id="selLengthMF" multiple class="FontNarrowish" style="height:90px;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr207" class="StdTableCell">
							<select id="selColorMF" multiple class="FontNarrowish" style="height:90px;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr208" class="StdTableCell">
							<select id="selSortMF" multiple class="FontNarrowish" style="height:90px;" onchange="javascript:ChangeSortFilter(this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr209" class="StdTableCell">
							<select id="selMillingMF" multiple class="FontNarrowish" style="height:90px;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr210" class="StdTableCell">
							<select id="selNoPrintMF" multiple class="FontNarrowish" style="height:90px;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr211" class="StdTableCell">
							<select id="selProductMF" multiple class="FontNarrowish" style="height:90px;" onchange="javascript:ChangeProductFilter(this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr212" class="StdTableCell">
							<select id="selManagerMF" multiple style="height:90px;" class="FontNarrowish" onchange="javascript:ChangeManagerFilter(this.value);return false;">
								<option value="0" Selected="Selected">ALL</option>
							</select>
						</td>
						<td id="thMainFiltr213" class="StdTableCell" style="text-align:left;width:200px;height:60px;overflow:scroll;">
							<ul id="ulCustomerMF"	style="height:70px;list-style:none;margin:0px;padding:0px;line-height:14px;" class="FontNarrowish">
								<li id="liDefaultItem">No Items Listed</li>
							</ul>
						</td>
					</tr>
					<tr>
						<td id="tdFilterSettingsBar" colspan="14" style="text-align:center;">
							<div id="divfilterSettingsBar" style="width:100%;margin-bottom:8px;margin-top:4px;">
								Data Type:&nbsp;
								<select id="selDataType" onchange="javascript:ChangeDataType(this.value);return false;">
									<option value="0" selected="selected">Sales Plan</option>
									<option value="1">Price Management General</option>
									<option value="2">Price Management Basic</option>
									<option value="3">Price Management Summary</option>
								</select>&nbsp;&nbsp;
								MGD:&nbsp;
								<select id="selManagedMain" onchange="javascript:ChangeManagedType(this.value);return false;">
									<option value="2" selected="selected">Both</option>
									<option value="1">Yes</option>
									<option value="0">No</option>
								</select>&nbsp;&nbsp;
								P/Type:&nbsp;
								<select id="selTypeMain" onchange="javascript:ChangeProdType(this.value);return false;">
									<option value="0">None</option>
									<option value="HD" selected="selected">HD</option>
								</select>&nbsp;&nbsp;
								<label style="margin-left: 5px;">Show 0's:</label>&nbsp;<input type="checkbox" id="chkShowZeros" onchange="javascript:ChangeZeroValSetting(this.checked);return false;" />&nbsp;&nbsp;&bull;&nbsp;				
								<label style="margin-left: 5px;">Items per Page:</label>
								<select id="selPageSize" style="margin-left: 10px;" onchange="javascript:ChangePageSize(this.value);return false;">
									<option value="10" >10</option>
									<option value="20" selected="selected" >20</option>
									<option value="25" >25</option>
									<option value="35" >35</option>
									<option value="50" >50</option>
									<option value="100" >100</option>
								</select>&nbsp;&nbsp;&nbsp;&bull;&nbsp;&nbsp;
								<label style="margin-left: 5px;">Data Types:</label>
								<select id="selDataTypes" style="margin-left: 10px;" onchange="javascript:ChangeSalesOrProd(this.value);return false;">
									<option value="0" selected="selected" >ALL Data</option>
									<option value="1">Sales Only</option>
									<option value="2" >Production Only</option>
								</select>&nbsp;&nbsp;&nbsp;
								<label id="lblGroupSortHdr" style="font-weight:bold;color:blue;font-size:11pt;">Group/Sort By:</label>&nbsp;
								<select id="selGroupSortBy" onchange="javascript:ChangeSortBy(this.value);return false;">
									<option value="0" selected="selected">Species</option>
									<option value="1">Thickness</option>
									<option value="2">Grade</option>
									<option value="3">Color</option>
									<option value="4">Sort</option>
									<option value="5">NoPrint</option>
									<option value="6">Product</option>
								</select>&nbsp;&nbsp;&nbsp;&nbsp;&bull;&nbsp;&nbsp;&nbsp;&nbsp;
								Saved Queries:&nbsp;
								<select id="selQueryList" onchange="javascript:LoadSavedQueryData(this.value);return false;" >
									<option value="0" selected="selected">None Selected</option>
								</select>
								Query Title:&nbsp;<input type="text" id="txtQueryTitle" style="width:160px;" />&nbsp;
								<button id="btnSaveQueryFormat" onclick="javascript:SaveQueryFormat();return false;" class="button blue-gradient glossy">Save</button>&nbsp;
								<button id="btnManageQueryList" onclick="javascript:ManageQueryList();return false;" class="button blue-gradient glossy">Manage</button>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="14" style="text-align:center;">
							<div id="divFilterIncludes" style="width:100%;margin-bottom:8px;">
								<label id="lblIncludeDatatHdr" style="font-weight:bold;color:blue;font-size:11pt;">Include:</label>&nbsp;
								Forecast<input type="checkbox" id="chkIncludeForecast" onchange="javascript:IncludeForecastInGrid(this.checked);return false;" checked="checked" />&nbsp;&nbsp;&nbsp;
								Customers<input type="checkbox" id="chkIncludeCustomers" onchange="javascript:IncludeCustomersInGrid(this.checked);return false;" />&nbsp;&nbsp;&nbsp;
								Holds<input type="checkbox" id="chkIncludeHolds" onchange="javascript:IncludeHoldsInGrid(this.checked);return false;" />&nbsp;&nbsp;&nbsp;
								History<input type="checkbox" id="chkIncludeHistory" onchange="javascript:IncludeHistoryInGrid(this.checked);return false;" checked="checked" />&nbsp;&nbsp;&nbsp;&nbsp;&bull;
								<span id="spnSubtotalblock" style="margin-left:30px;">
									<label id="lblSubtotalFilters" style="font-weight:bold;color:darkblue;">Subtotals For:</label>&nbsp;
									<span id="spnSubtotalBlockProd"><input type="checkbox" id="chkSubtotalProducts" checked="checked" onchange="javascript:ChangeSubtotalType(0, this.checked);return false;" />Products&nbsp;</span>
									<span id="spnSubtotalBlockProdA"><input type="checkbox" id="chkSubtotalProdAttribs" onchange="javascript:ChangeSubtotalType(4, this.checked);return false;" />Prod-Attributes&nbsp;</span>
									<span id="spnSubtotalBlockSpecies" style="display:inline;"><input type="checkbox" id="chkSubtotalSpecies" onchange="javascript:ChangeSubtotalType(1, this.checked);return false;" />Species&nbsp;</span>
									<span id="spnSubtotalBlockThick" style="display:none;"><input type="checkbox" id="chkSubtotalThickness" onchange="javascript:ChangeSubtotalType(2, this.checked);return false;" />Thickness&nbsp;</span>
									<span id="spnSubtotalBlockGrade" style="display:none;"><input type="checkbox" id="chkSubtotalGrade" onchange="javascript:ChangeSubtotalType(3, this.checked);return false;" />Grade</span>
									<span id="spnSubtotalBlockColor" style="display:none;"><input type="checkbox" id="chkSubtotalColor" onchange="javascript:ChangeSubtotalType(5, this.checked);return false;" />Color</span>
									<span id="spnSubtotalBlockSort" style="display:none;"><input type="checkbox" id="chkSubtotalSort" onchange="javascript:ChangeSubtotalType(6, this.checked);return false;" />Sort</span>
									<span id="spnSubtotalBlockNoPrint" style="display:none;"><input type="checkbox" id="chkSubtotalNoPrint" onchange="javascript:ChangeSubtotalType(7, this.checked);return false;" />NoPrint</span>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="14"">
							<div id="divActionBtnBar" style="width:100%;margin-bottom:8px;text-align:center;">
								<button id="btnRefreshCTData" class="button blue-gradient glossy" onclick="javascript:RefreshSalesData();return false;" style="margin-left:10px;margin-right:10px;width:210px;">Update Sales Planning Data</button>&nbsp;&nbsp;&nbsp;
								<button id="btnTailorVisColumns" class="button blue-gradient glossy" onclick="javascript:TailorVisibleColumns();return false;" style="margin-left:10px;margin-right:20px;width:180px;">Tailor Visible Columns</button>
								<span id="spnExportButtons" style="margin-left:70px;">
									<button id="btnExportToPDF" class="button green-gradient glossy" onclick="javascript:ExportToPDF(); return false;" style="margin-right:6px;width:124px;" >Export to PDF</button>
									<button id="btnExportToExcel" class="button green-gradient glossy" onclick="javascript:ExportToExcel(); return false;" style="margin-left:2px;margin-right:20px;width:124px;" >Export to Excel</button>
								</span>
							</div>
						</td>
					</tr>
					</table>
				</div>
			</div>

		</div>

		<div id="divPAGEMAINCONTENT" style="width:99%;margin-left:10px;">
			<div id="divMainSalesGrid" style="width:100%;">
				<div id="divMainSalesGridHdr" style="width:100%;text-align:center;">
					<label id="lblMainSalesPlanHdr" style="color:blue;font-size:12pt;font-weight:bold;">Sales Plan</label>
				</div>
				<table id="tblMainDataGrid" style="border-spacing:0px;border-collapse:collapse;" >
				<thead>
				<tr>
						<th id="thHdrCol00" class="TableHdrCell" style="width:60px;" rowspan="2">Specie</th>
						<th id="thHdrCol01" class="TableHdrCell" style="width:70px;" rowspan="2">Thick</th>
						<th id="thHdrCol02" class="TableHdrCell" style="width:70px;" rowspan="2">Grade</th>
						<th id="thHdrCol03" class="TableHdrCell" style="width:90px;" rowspan="2">Seasoning</th>
						<th id="thHdrCol04" class="TableHdrCell" style="width:90px;" rowspan="2">Surface</th>
						<th id="thHdrCol05" class="TableHdrCell" style="width:90px;" rowspan="2">Length</th>
						<th id="thHdrCol06" class="TableHdrCell" style="width:90px;" rowspan="2">Color</th>
						<th id="thHdrCol07" class="TableHdrCell" style="width:90px;" rowspan="2">Sort</th>
						<th id="thHdrCol08" class="TableHdrCell" style="width:90px;" rowspan="2">Milling</th>
						<th id="thHdrCol09" class="TableHdrCell" style="width:90px;" rowspan="2">NoPrint</th>
						<th id="thHdrCol10" class="TableHdrCell" style="width:90px;" rowspan="2">Product</th>
						<th id="thHdrCol11" class="TableHdrCell" style="width:90px;" rowspan="2">Type</th>
						<th id="thHdrCol12" class="TableHdrCell" style="width:100px;" rowspan="2">Mgr</th>
						<th id="thHdrCol13" class="TableHdrCell" style="width:100px;" rowspan="2">Customer</th>
						<th id="thHdrCol14" class="TableHdrCell" style="width:90px;color:blue;">P13</th>
						<th id="thHdrCol15" class="TableHdrCell" style="width:90px;color:blue;">P8</th>
						<th id="thHdrCol16" class="TableHdrCell" style="width:90px;color:blue;">P4</th>
						<th id="thHdrCol17" class="TableHdrCell" style="width:100px;color:darkgreen" rowspan="2">Totals</th>
						<th id="thHdrCol18" class="TableHdrCell" style="width:90px;color:blue;">WOO</th>
						<th id="thHdrCol19" class="TableHdrCell" style="width:90px;color:blue;">W01</th>
						<th id="thHdrCol20" class="TableHdrCell" style="width:90px;color:blue;">W02</th>
						<th id="thHdrCol21" class="TableHdrCell" style="width:90px;color:blue;">W03</th>
						<th id="thHdrCol22" class="TableHdrCell" style="width:90px;color:blue;">W04</th>
						<th id="thHdrCol23" class="TableHdrCell" style="width:90px;color:blue;">W05</th>
						<th id="thHdrCol24" class="TableHdrCell" style="width:90px;color:blue;">W06</th>
						<th id="thHdrCol25" class="TableHdrCell" style="width:90px;color:blue;">W07</th>
						<th id="thHdrCol26" class="TableHdrCell" style="width:90px;color:blue;">W08</th>
						<th id="thHdrCol27" class="TableHdrCell" style="width:90px;color:blue;">W09</th>
						<th id="thHdrCol28" class="TableHdrCell" style="width:90px;color:blue;">W10</th>
						<th id="thHdrCol29" class="TableHdrCell" style="width:90px;color:blue;">W11</th>
						<th id="thHdrCol30" class="TableHdrCell" style="width:90px;color:blue;">W12</th>
						<th id="thHdrCol31" class="TableHdrCell" style="width:90px;color:blue;">W13</th>
				</tr>
				<tr>
						<th id="thHdrCol14b" class="TableHdrCell" style="width:100px;"><label id="lblHdrCol14" style="font-family:'Arial Narrow';font-size:9pt;"></label></th>
						<th id="thHdrCol15b" class="TableHdrCell" style="width:100px;"><label id="lblHdrCol15" style="font-family:'Arial Narrow';font-size:9pt;"></label></th>
						<th id="thHdrCol16b" class="TableHdrCell" style="width:100px;"><label id="lblHdrCol16" style="font-family:'Arial Narrow';font-size:9pt;"></label></th>
						<th id="thHdrCol18b" class="TableHdrCell" style="width:90px;"><label id="lblHdrCol18" style="font-family:'Arial Narrow';font-size:9pt;"></label></th>
						<th id="thHdrCol19b" class="TableHdrCell" style="width:90px;"><label id="lblHdrCol19" style="font-family:'Arial Narrow';font-size:9pt;"></label></th>
						<th id="thHdrCol20b" class="TableHdrCell" style="width:90px;"><label id="lblHdrCol20" style="font-family:'Arial Narrow';font-size:9pt;"></label></th>
						<th id="thHdrCol21b" class="TableHdrCell" style="width:90px;"><label id="lblHdrCol21" style="font-family:'Arial Narrow';font-size:9pt;"></label></th>
						<th id="thHdrCol22b" class="TableHdrCell" style="width:90px;"><label id="lblHdrCol22" style="font-family:'Arial Narrow';font-size:9pt;"></label></th>
						<th id="thHdrCol23b" class="TableHdrCell" style="width:90px;"><label id="lblHdrCol23" style="font-family:'Arial Narrow';font-size:9pt;"></label></th>
						<th id="thHdrCol24b" class="TableHdrCell" style="width:90px;"><label id="lblHdrCol24" style="font-family:'Arial Narrow';font-size:9pt;"></label></th>
						<th id="thHdrCol25b" class="TableHdrCell" style="width:90px;"><label id="lblHdrCol25" style="font-family:'Arial Narrow';font-size:9pt;"></label></th>
						<th id="thHdrCol26b" class="TableHdrCell" style="width:90px;"><label id="lblHdrCol26" style="font-family:'Arial Narrow';font-size:9pt;"></label></th>
						<th id="thHdrCol27b" class="TableHdrCell" style="width:90px;"><label id="lblHdrCol27" style="font-family:'Arial Narrow';font-size:9pt;"></label></th>
						<th id="thHdrCol28b" class="TableHdrCell" style="width:90px;"><label id="lblHdrCol28" style="font-family:'Arial Narrow';font-size:9pt;"></label></th>
						<th id="thHdrCol29b" class="TableHdrCell" style="width:90px;"><label id="lblHdrCol29" style="font-family:'Arial Narrow';font-size:9pt;"></label></th>
						<th id="thHdrCol30b" class="TableHdrCell" style="width:90px;"><label id="lblHdrCol30" style="font-family:'Arial Narrow';font-size:9pt;"></label></th>
						<th id="thHdrCol31b" class="TableHdrCell" style="width:90px;"><label id="lblHdrCol31" style="font-family:'Arial Narrow';font-size:9pt;"></label></th>
				</tr>
				</thead>
				<tbody>
				</tbody>
				<tfoot>
						<td class="StdTableFtrCell" id="tfcell00" colspan="14" style="text-align:right;">Page Totals</td>
						<td class="StdTableFtrCell" id="tfcell14"><label id="lblCol14">0</label></td>
						<td class="StdTableFtrCell" id="tfcell15"><label id="lblCol15">0</label></td>
						<td class="StdTableFtrCell" id="tfcell16"><label id="lblCol16">0</label></td>
						<td class="StdTableFtrCell" id="tfcell17"><label id="lblCol17">0</label></td>
						<td class="StdTableFtrCell" id="tfcell18"><label id="lblCol18">0</label></td>
						<td class="StdTableFtrCell" id="tfcell19"><label id="lblCol19">0</label></td>
						<td class="StdTableFtrCell" id="tfcell20"><label id="lblCol20">0</label></td>
						<td class="StdTableFtrCell" id="tfcell21"><label id="lblCol21">0</label></td>
						<td class="StdTableFtrCell" id="tfcell22"><label id="lblCol22">0</label></td>
						<td class="StdTableFtrCell" id="tfcell23"><label id="lblCol23">0</label></td>
						<td class="StdTableFtrCell" id="tfcell24"><label id="lblCol24">0</label></td>
						<td class="StdTableFtrCell" id="tfcell25"><label id="lblCol25">0</label></td>
						<td class="StdTableFtrCell" id="tfcell26"><label id="lblCol26">0</label></td>
						<td class="StdTableFtrCell" id="tfcell27"><label id="lblCol27">0</label></td>
						<td class="StdTableFtrCell" id="tfcell28"><label id="lblCol28">0</label></td>
						<td class="StdTableFtrCell" id="tfcell29"><label id="lblCol29">0</label></td>
						<td class="StdTableFtrCell" id="tfcell30"><label id="lblCol30">0</label></td>
						<td class="StdTableFtrCell" id="tfcell31"><label id="lblCol31">0</label></td>
				</tfoot>
				</table>

<!-- #include file="../inc/incPaginationDiv.inc" -->
			</div>

			<div id="divPriceAnalysisGrid" style="width:100%;display:none;">
				<div id="divPriceAnalysisHdr" style="width:100%;text-align:center;">
					<table style="padding:1px;border-spacing:0px;border-collapse:collapse;margin:auto auto;">
					<tr>
						<td>
							<label id="lblPriceAnalysisGridHdr" style="color:blue;font-size:14pt;font-weight:bold;">Price Analysis:</label>
							Report Format:&nbsp;
							<select id="selPriceAnalDisplayFormat" onchange="javascript:ChangePriceAnalysisView(this.value);return false;">
								<option value="0">None Selected</option>
								<option value="1">Specie Shipped</option>
								<option value="2">Specie Shipped In-Transit</option>
								<option value="3">Specie Shipped by GradeGroup</option>
								<option value="4">Specie/GradeGroup/Thick/Grade</option>
								<option value="5">Specie Summary</option>
								<option value="6">Detailed 30 Day View</option>
							</select>&nbsp;&nbsp;&nbsp;
						</td>
						<td>
							&nbsp;&nbsp;&nbsp;Year:&nbsp;
							<select id="selTargetYear1">
								<option value="0">ALL</option>
								<option value="2011">2011</option>
								<option value="2012">2012</option>
								<option value="2013">2013</option>
								<option value="2014">2014</option>
								<option value="2015">2015</option>
								<option value="2016">2016</option>
								<option value="2017">2017</option>
								<option value="2018">2018</option>
								<option value="2019">2019</option>
								<option value="2020">2020</option>
								<option value="2021">2021</option>
								<option value="2022">2022</option>
								<option value="2023">2023</option>
								<option value="2024">2024</option>
								<option value="2025">2025</option>
							</select>&nbsp;-&nbsp;
							Month:&nbsp;
							<select id="selTargetMonth1">
								<option value="0">ALL</option>
								<option value="1">January</option>
								<option value="2">February</option>
								<option value="3">March</option>
								<option value="4">April</option>
								<option value="5">May</option>
								<option value="6">June</option>
								<option value="7">July</option>
								<option value="8">August</option>
								<option value="9">September</option>
								<option value="10">October</option>
								<option value="11">November</option>
								<option value="12">December</option>
							</select>
							<span id="spnManagerF" style="display:none;">
								&nbsp;&nbsp;&bull;&nbsp;Manager:&nbsp;
								<select id="selManagerPAF">

								</select>
							</span>
							<span id="spnSellerF" style="display:none;">
								&nbsp;&nbsp;&bull;&nbsp;Seller:&nbsp;
								<select id="selSellerPAF">

								</select>
							</span>
							<span id="spnCustomerF" style="display:none;">
								&nbsp;&nbsp;&bull;&nbsp;Customer:&nbsp;
								<select id="selCustomerPAF">

								</select>
							</span>
							<span id="spnSourceF" style="display:none;">
								&nbsp;&nbsp;&bull;&nbsp;Source:&nbsp;
								<select id="selSourcePAF">

								</select>
							</span>
						</td>
					</tr>
					</table>
				</div>

				<div id="divPriceAnalysisBySpecie" style="width:100%;text-align:center;display:none;">
					<div id="divPriceAnalysisTableHdr" style="width:100%;">
						<label id="lblPriceAnalysisSpecHdr" style="color:blue;font-size:14pt;font-weight:bold;">Prices for a Species:</label>&nbsp;&nbsp;Species:&nbsp;
					</div>
					<div id="divPriceAnalysisTableT" style="width:100%;">
						<table id="tblPriceAnalysis" style="padding:1px;border-spacing:0px;border-collapse:collapse;margin:auto auto;">
						<tr>
							<th class="TableHdrCell" rowspan="2" style="width:70px;">Specie</th>
							<th class="TableHdrCell" rowspan="2" style="width:70px;">Grade Group</th>
							<th class="TableHdrCell" rowspan="2" style="width:70px;">Thickness</th>
							<th class="TableHdrCell" rowspan="2" style="border-right:4px double gray;width:70px;">Grade</th>
							<th class="TableHdrCell" colspan="3" style="color:white;"><label id="lblPriceAnalysisMo1"></label></th>
							<th class="TableHdrCell" colspan="3" style="border-right:4px double gray;color:white;"><label id="lblPriceAnalysisMo2"></label></th>
							<th class="TableHdrCell" colspan="3" style="border-right:4px double gray;color:white;"><label id="lblPriceAnalysisMo2">MillDirect</label></th>
							<th class="TableHdrCell" colspan="3" style="border-right:4px double gray;color:white;"><label id="lblPriceAnalysisMo3">Export</label></th>
							<th class="TableHdrCell" colspan="3" style="border-right:4px double gray;color:white;"><label id="lblPriceAnalysisMo4">Warehouse</label></th>
							<th class="TableHdrCell" colspan="3" style="color:white;"><label id="lblPriceAnalysisMo5"></label></th>
						</tr>
						<tr>
							<th class="TableHdrCell" style="width:80px;">% MBF</th>
							<th class="TableHdrCell" style="width:80px;">MBF</th>
							<th class="TableHdrCell" style="border-right:4px double gray;width:80px;">$/MBF</th>
							<th class="TableHdrCell" style="width:80px;">% MBF</th>
							<th class="TableHdrCell" style="width:80px;">MBF</th>
							<th class="TableHdrCell" style="border-right:4px double gray;width:80px;">$/MBF</th>
							<th class="TableHdrCell" style="width:80px;">% MBF</th>
							<th class="TableHdrCell" style="width:80px;">MBF</th>
							<th class="TableHdrCell" style="border-right:4px double gray;width:80px;">$/MBF</th>
							<th class="TableHdrCell" style="width:80px;">% MBF</th>
							<th class="TableHdrCell" style="width:80px;">MBF</th>
							<th class="TableHdrCell" style="border-right:4px double gray;width:80px;">$/MBF</th>
							<th class="TableHdrCell" style="width:80px;">% MBF</th>
							<th class="TableHdrCell" style="width:80px;">MBF</th>
							<th class="TableHdrCell" style="border-right:4px double gray;width:80px;">$/MBF</th>
							<th class="TableHdrCell" style="width:80px;">% MBF</th>
							<th class="TableHdrCell" style="width:80px;">MBF</th>
							<th class="TableHdrCell" style="border-right:4px double gray;width:80px;">$/MBF</th>
							<th class="TableHdrCell" style="width:80px;">% MBF</th>
							<th class="TableHdrCell" style="width:80px;">MBF</th>
							<th class="TableHdrCell" style="border-right:4px double gray;width:80px;">$/MBF</th>
							<th class="TableHdrCell" style="width:80px;">% MBF</th>
							<th class="TableHdrCell" style="width:80px;">MBF</th>
							<th class="TableHdrCell" style="border-right:4px double gray;width:80px;">$/MBF</th>
							<th class="TableHdrCell" style="width:80px;">% MBF</th>
							<th class="TableHdrCell" style="width:80px;">MBF</th>
							<th class="TableHdrCell" style="border-right:4px double gray;width:80px;">$/MBF</th>
							<th class="TableHdrCell" style="width:80px;">% MBF</th>
							<th class="TableHdrCell" style="width:80px;">MBF</th>
							<th class="TableHdrCell" style="width:80px;">$/MBF</th>
						</tr>
						</table>
					</div>
				</div>

 				<div id="divPriceAnalysisSummary" style="width:100%;display:none;">
					<div id="divPriceAnalysisSumHdr" style="width:100%;text-align:center;">

					</div>
					<div id="divPriceAnalysisSumTable" style="width:100%;text-align:center;">
						<table id="tblPriceAnalysisSummary" style="padding:1px;border-spacing:0px;border-collapse:collapse;margin:auto auto;">
						<thead id="tblPriceAnalysisSummarH">
						<tr>
							<th id="thSummaryByType" rowspan="2" class="TableHdrCell" style="width:100px;">Specie</th>
							<th colspan="4" class="TableHdrCell" style="border-right:4px double gray;color:white;">Mill Direct</th>
							<th colspan="4" class="TableHdrCell" style="border-right:4px double gray;color:white;">Export</th>
							<th colspan="4" class="TableHdrCell" style="border-right:4px double gray;color:white;">Warehouse</th>
							<th rowspan="2" class="TableHdrCell" style="width:90px;">Grand Total</th>
						</tr>
						<tr>
							<th class="TableHdrCell" style="width:90px;">Specie</th>
							<th class="TableHdrCell" style="width:90px;">-30 Days</th>
							<th class="TableHdrCell" style="width:90px;">30-60 Days</th>
							<th class="TableHdrCell" style="width:90px;">61+ Days</th>
							<th class="TableHdrCell" style="border-right:4px double gray;width:90px;">Total</th>
							<th class="TableHdrCell" style="width:90px;">-30 Days</th>
							<th class="TableHdrCell" style="width:90px;">30-60 Days</th>
							<th class="TableHdrCell" style="width:90px;">61+ Days</th>
							<th class="TableHdrCell" style="border-right:4px double gray;width:90px;">Total</th>
							<th class="TableHdrCell" style="width:90px;">-30 Days</th>
							<th class="TableHdrCell" style="width:90px;">30-60 Days</th>
							<th class="TableHdrCell" style="width:90px;">61+ Days</th>
							<th class="TableHdrCell" style="border-right:4px double gray;width:90px;">Total</th>
						</tr>
						</thead>
						<tbody id="tblPriceAnalysisSummarB">

						</tbody>
						<tfoot id="tblPriceAnalysisSummarF">

						</tfoot>
						</table>
					</div>
				</div>

				<div id="divPriceDetailedCustSell" style="width:100%;display:none;">

				</div>

				<div id="divPriceGradeGroupDetails" style="width:100%;display:none;">

				</div>

				<div id="divPriceAnalyShipInTransitGG" style="width:100%;display:none;">

				</div>

				<div id="divPriceAnalyShipInTransit" style="width:100%;display:none;">

				</div>

				<div id="divPriceAnalysisShipped" style="width:100%;display:none;">
					<div id="divPriceAnalShippedHdr" style="width:100%;">
						<label id="lblPriceAnalShippedHdr" style="color:blue;font-size:14pt;font-weight:bold;">Shipped In-Transit Sales:</label>
						Seller, Manager, Customer, Source
					</div>
					<div id="divPriceAnalShippedTable" style="width:100%;">
						<table id="tblPriceAnalShipped" style="padding:1px;border-spacing:0px;border-collapse:collapse;margin: auto auto;">
						<thead>
						<tr>
							<th class="TableHdrCell" rowspan="2" style="width:70px;">Specie</th>
							<th class="TableHdrCell" colspan="2" style="width:160px;">Month Shipped</th>
							<th class="TableHdrCell" colspan="2" style="width:160px;">-30 Days MBF</th>
							<th class="TableHdrCell" colspan="2" style="width:160px;">30-60 Days</th>
							<th class="TableHdrCell" colspan="2" style="width:160px;">61+ Days</th>
						</tr>
						<tr>
							<th class="TableHdrCell" style="width:80px;">MBF</th>
							<th class="TableHdrCell" style="width:80px;">$/MBF</th>
							<th class="TableHdrCell" style="width:80px;">MBF</th>
							<th class="TableHdrCell" style="width:80px;">$/MBF</th>
							<th class="TableHdrCell" style="width:80px;">MBF</th>
							<th class="TableHdrCell" style="width:80px;">$/MBF</th>
							<th class="TableHdrCell" style="width:80px;">MBF</th>
							<th class="TableHdrCell" style="width:80px;">$/MBF</th>
						</tr>
						</thead>
						<tbody>

						</tbody>
						</table>
					</div>
				</div>

			</div>

		</div>

		<div id="divPAGEFOOTER" style="width:99%;margin-left:10px;">
			<label id="lblStatusMsg" style="color:maroon;font-size:12pt;font-weight:bold;"></label>
		</div>
        
    <br />
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
