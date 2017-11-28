<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CatWeekDetails.aspx.cs" Inherits="DataMngt.sales.CatWeekDetails" %>

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
		.modal {
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

		.loading {
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

		.ui-dialog .ui-dialog-titlebar-close {
			display: none;
		}

		.StdFtrCellThisPage {
			color: black;
			background-color: aquamarine;
			text-align: right;
			font-size: 10pt;
			font-family: Calibri;
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
		var jbPaginate = false;
		var jbtnSeeDeepDetails;
		var jbViewOnly = true;
		var jdivInventoryChangeItem;
		var jdToday;
		var jiAR = 0;
		var jiByID = 0;
		var jiDocRightLevel = 0;
		var jiDocumentType = 0;
		var jiNbrRows = 0;
		var jiPageID = 29;
		var jiPageNbr = 0;
		var jiPageSize = 20;
		var jiProdManagedID = 0;
		var jiUserID = 0;
		var jiWeekNbr = 0;
		var jlBuildNbr;
		var jlCurrentYearFtr;
		var jlPageIDInhFooter;
		var jlPageStatus;
		var jlStatusMsg;
		var jlVersion;
		var jlVersionDate;
		var jsBrowserType = '';
		var jsColor = '';
		var jsCurrentTime = '';
		var jsLength = '';
		var jsMilling = '';
		var jsNoPrint = '';
		var jsProdCode = '';
		var jsProdType = '';
		var jsSort = '';
		var jsTDate = '';
		var jtblDeepDetails;
		var jtblProdDetailsByLoc;

		var MyProductData;
		var MyProdDeepDetails;
		var MyProdWeekDetails;

		var counter = 0;
		var DayNamesNV = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

		// page initiation section --------------------------------------------------------------------------------
		//#region PageInitiationR	JS
		$(document).ready(function () {
			jdToday = new Date();
			jsToday = getMyDateTimeStringDm(jdToday, 18);
			jsCurrentTime = getMyDateTimeStringDm(jdToday, 7);
			//alert(jdToday + '/' + jsToday + '/' + jsCurrentTime);
			updateClockNV();
			KeepSessionAlive();
			if(jbgIA === 1) { jbA = true;}

			// set global default values
			//alert('Ready starting');
			jiPageID = 29;
			jsPageVersion = '1.0.0';
			jsPageVersDate = '10/18/2017';
			jbViewOnly = true;
			//alert('loading seed values');
			// Load global page-loaded variables
			jiByID = jigEmpID;
			jsBrowserType = jsgBrowserType;
			jiProdManagedID = jsgPMID;
			jsUserName = jsgNm;
			//alert(jsUserName);
			$('#Form1').on("submit", function (evt) {
				evt.preventDefault();
			});
			jsProdType = jsgPT;
			jsProdCode = jsgPC;
			jsLength = jsgLN;
			jsColor = jsgCL;
			jsSort = jsgSR;
			jsMilling = jsgML;
			jsNoPrint = jsgNP;
			jsTDate = jsgTDt;
			jiWeekNbr = jigWN;

			jbtnSeeDeepDetails = document.getElementById('btnSeeDeepDetails');
			jdivInventoryChangeItem = document.getElementById('divInventoryChangeItem');
			jlStatusMsg = document.getElementById('lblStatusMsg');
			jtblProdDetailsByLoc = document.getElementById('tblProdDetailsByLoc');

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
			if(jbA === true) {
				jbtnSeeDeepDetails.style.display = 'inline';
			}
			jiPgNbrPj[0] = 0;
			jiPageSize = 20;
			//if (jiAr < 3) {
			//}
			EstablishMainPgElementsPj(1, 0);
			GetProductData(jsProdType, jsProdCode, jiProdManagedID);
			PopulateProdDescripters();
			GetCatProdDetailsForWeek(0, jsProdType, jsProdCode, jsLength, jsColor, jsSort, jsMilling, jsNoPrint, jsTDate);
			PopulateProdDetails();

			//createDatePickerOnTextWc('txtBeginDateF', null, null, 0, 3, 'show', 11);
			//createDatePickerOnTextWc('txtEndDateF', null, null, 0, 3, 'show', 12);
			document.getElementById('lblPageIDInFooter').innerHTML = 'Page ID: ' + jiPageID.toString();
			//alert('Initiation done');
			return false;
		}
		// END of page initiation section --------------------------------------------------------------------------------
		//#endregion PageInitiationR	JS

		// **************************** AJAX FUNCTIONS *********************************

		function DataCall1() {
			jiPageNbr = jiPgNbrPj[0];
			//alert('Page ' + jiPageNbr);
			GetProcessList(0, 0);
			PopulateProcessList();
			return false;
		}

		function DataCall2() {
			GetProdDeepDetails(jsProdType, jsProdCode, jsColor, jsSort, jsMilling, jsNoPrint, jiWeekNbr, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			PopulateDeepDetails();
			//alert('Done!');
			return false;
		}
		
		function GetProductData(pt, pcode, pmid) {
			var url = "../shared/AJAXServices.asmx/SelectProductItemDataWide";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ProdType':'" + pt + "','ProdCode':'" + pcode + "','PMID':'" + pmid.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProductData = response; });
			return false;
		}

		function GetCatProdDetailsForWeek(lid, pt, pcode, ln, clr, sort, mill, np, tdate) {
			var url = "../shared/AJAXServices.asmx/SelectCatProductDetailsForWeek";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ListID':'" + lid.toString() + "','ProdType':'" + pt + "','Product':'" + pcode + "','Len':'" + ln + "','Color':'" + clr + "','fSort':'" + sort + "',";
			MyData = MyData + "'Milling':'" + mill + "','NoPrint':'" + np + "','TDate':'" + tdate + "','Sort':'0','Active':'1','PgNbr':'" + jiPgNbrPj[0].toString() + "','PgSize':'" + jiPageSize.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProdWeekDetails = response; });
			return false;
		} 
		
		function GetProdDeepDetails(pt, pcode, clr, fsort, mill, noprint, wk, roll, rprod, noloc, nocust, nofc, noord, noprod, noInv, sort) {
			var url = "../shared/GridSupportServices.asmx/SelectProductDataForTargetWeek2";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ProdType':'" + pt + "','ProdCode':'" + pcode + "','Color':'" + clr + "','fSort':'" + fsort + "','Milling':'" + mill + "','NoPrint':'" + noprint + "',";
			MyData = MyData + "'WeekNbr':'" + wk.toString() + "','Rollup':'" + roll.toString() + "','RollProd':'" + rprod.toString() + "','NoLoc':'" + noloc.toString() + "', 'NoCust':'" + nocust.toString() + "',";
			MyData = MyData + "'NoForecast':'" + nofc.toString() + "','NoOrd':'" + noord.toString() + "','NoProd':'" + noprod.toString() + "','NoInv':'" + noInv.toString() + "','Sort':'" + sort.toString() + "',";
			MyData = MyData + "'PgNbr':'" + jiPgNbrPj[1].toString() + "', 'PgSize':'" + jiPageSize.toString() + "', 'ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProdDeepDetails = response; });
			return false;
		} 

		// **************************** Populating *********************************

		function PopulateProdDescripters() {
			ClearProdDescripters();
			if (!IsContentsNullUndefinedGu(MyProductData)) {
				document.getElementById('lblDescVal1').innerHTML = MyProductData[0]['desc1'].toString();
				document.getElementById('lblDescVal2').innerHTML = MyProductData[0]['desc2'].toString();
				document.getElementById('lblDescVal3').innerHTML = MyProductData[0]['desc3'].toString();
				document.getElementById('lblDescVal4').innerHTML = MyProductData[0]['desc4'].toString();
				document.getElementById('lblDescVal5').innerHTML = MyProductData[0]['desc5'].toString();
				document.getElementById('lblDescVal6').innerHTML = MyProductData[0]['desc6'].toString();
				document.getElementById('lblDescVal7').innerHTML = MyProductData[0]['desc7'].toString();
				document.getElementById('lblDescVal8').innerHTML = MyProductData[0]['desc8'].toString();
				document.getElementById('lblDescVal9').innerHTML = MyProductData[0]['desc9'].toString();
				document.getElementById('lblDescVal10').innerHTML = MyProductData[0]['desc10'].toString();
			}
			return false;
		}

		function PopulateProdDetails() {
			//alert('Filling Proc List');
			jlStatusMsg.innerHTML = '';
			var cellClass = 'StdTableCellLarger';
			var nCol = 10;
			// Cols: 0-LocType, 1-LocCode, 2-Name, 3-City, 4-StProv, 5-UOM, 6-Qty, 7-OrdQty, 8-ForecastQty, 9-ProdQty
			//alert('arrays');
			var cWidth = [50, 60, 260, 70, 72, 58, 100, 70, 70, 70, 0, 0, 0, 0, 0];
			var corientH = ['center', 'center', 'left', 'left', 'center', 'center', 'right', 'right', 'right', 'right', 'right', '', '', '', ''];
			var corientV = ['top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', '', '', '', ''];
			var cbrdrL = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrR = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrT = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrB = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cnames = ['loctype', 'LocCode', 'LocName', 'City', 'StProv', 'UOM', 'QTY', 'OrdQty', 'ForecastQty', 'ProdQty', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var aggType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var shown = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
			//alert('DDL list data - ' + MyProdWeekDetails.length);

			if (!IsContentsNullUndefinedGu(MyProdWeekDetails)) {
				//alert('Proc List Len: ' + MyProdWeekDetails.length);
				var bdy = FormDataGridBodyMinimumDg(1, nCol, 'tdProdWkDetails', cellClass, false, false, false, false, '', 'button blue-gradient glossy', false, 0, MyProdWeekDetails, 'RowID', cnames, cType, cWidth, corientH, corientV, cbrdrL, cbrdrR, cbrdrT, cbrdrB, aggType, shown, true, true);
				//alert('Grid done');
				jtblProdDetailsByLoc.style.display = 'block';
			}
			else {
				alert('Proc List bad data');
				ShowStatusMsg('An unidentified error occurred. No records could be extracted.');
			}
			//alert('Attaching body');
			try {
				var oldBody = jtblProdDetailsByLoc.getElementsByTagName("tbody")[0];
				jtblProdDetailsByLoc.replaceChild(bdy, oldBody);
			}
			catch (ex) {
				// nothing
			}
			//alert('body attached - final pagination');
			joPgNbrLblPj.innerHTML = (jiPgNbrPj[0] + 1).toString();
			joMaxPgNbrLblPj.innerHTML = jiNbrPagesPj[0].toString();
			jdivInventoryChangeItem.style.display = 'block';
			//alert('done!');
			return false;
		}

		function PopulateDeepDetails() {
			//alert('Filling Proc List');
			jtblDeepDetails = document.getElementById('tblDeepDetails');
			jlStatusMsg.innerHTML = '';
			var bdy = document.createElement("tbody");
			var cellClass = 'StdTableCellWBorderLarge';
			var nCol = 12;
			//var oldBody = jtblDeepDetails.getElementsByTagName("tbody")[0];
			//jtblDeepDetails.replaceChild(bdy, oldBody);
			// Cols: 0-Type, 1-Loc, 2-Length, 3-Color, 4-Sort, 5-Milling, 6-NoPrint, 7-Qty, 8-UOM, 9-Order, 10-sTargetDate, 11-Customer
			//alert('arrays');
			var cWidth = [90, 60, 80, 80, 80, 80, 80, 120, 60, 100, 120, 110, 0, 0, 0];
			var corientH = ['center', 'center', 'left', 'left', 'center', 'center', 'right', 'center', 'center', 'center', 'center', 'center', 'center', '', ''];
			var corientV = ['top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', '', '', ''];
			var cbrdrL = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrR = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrT = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrB = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cnames = ['RowType', 'LocCode', 'LengthCode', 'Color', 'Sort', 'Milling', 'NoPrint', 'Qty', 'UOM', 'OrdNbr', 'sTargetDate', 'CustCode', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var aggType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var shown = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];
			//alert('DDL list data - ' + MyProdDeepDetails.length);

			if(!IsContentsNullUndefinedGu(MyProdDeepDetails)) {
				//alert('Proc List Len: ' + MyProdDeepDetails.length);
				bdy = FormDataGridBodyMinimumDg(2, nCol, 'tdProdDeepDetails', cellClass, false, false, false, false, '', 'button blue-gradient glossy', false, 0, MyProdDeepDetails, 'RowID', cnames, cType, cWidth, corientH, corientV, cbrdrL, cbrdrR, cbrdrT, cbrdrB, aggType, shown, true, true);
				//alert('Grid done');
				jtblDeepDetails.style.display = 'block';
			}
			else {
				alert('Proc List bad data');
				ShowStatusMsg('An unidentified error occurred. No records could be extracted.');
			}
			//alert('Attaching body');
			try {
				var oldBody = jtblDeepDetails.getElementsByTagName("tbody")[0];
				jtblDeepDetails.replaceChild(bdy, oldBody);
				//alert('tbody replaced');
			}
			catch(ex) {
				// nothing
			}
			//alert('body attached - final pagination');
			joPgNbrLblPj2.innerHTML = (jiPgNbrPj[1] + 1).toString();
			//alert('done!');
			return false;
		}

		// **************************** Background *********************************

		function ClearProdDescripters() {
			for (var row = 1; row <= 10; row++) {
				document.getElementById('lblDescVal' + row.toString()).innerHTML = '';
			}
			return false;
		}

		// **************************** Dialogs *********************************

		function ShowDeepDetailDialog() {
			var content = '';
			var emptyval = StringifyTx('');
			var fig = 0;
			var ht = 620;
			var nbrpgs = 0;
			jiPgNbrPj[1] = 0;
			jiNbrPagesPj[1] = 0;
			//alert('1');
			var showit = 'display:none';
			var ttl = 'Deep Detailed View of Forecast/Orders/Production for ' + jsProdType + '-' + jsProdCode + ' in week nbr ' + jiWeekNbr.toString();
			var wdth = 904;
			//alert('2 - data ' + jsProdType + '/' + jsProdCode + '/' + jiWeekNbr);
			GetProdDeepDetails(jsProdType, jsProdCode, jsColor, jsSort, jsMilling, jsNoPrint, jiWeekNbr, 0, 0, 0, 0, 0, 0, 0, 0, 0);
			content = '<table id="tblDeepDetails" class="TableMain" style="margin-top:6px;"><thead><tr><th class="TableHdrCell" style="width:90px;">Type</th><th class="TableHdrCell">Loc</th><th class="TableHdrCell" style="width:80px;">Length</th>';
			content = content + '<th class="TableHdrCell" style="width:80px;">Color</th><th class="TableHdrCell" style="width:80px;">Sort</th><th class="TableHdrCell" style="width:80px;">Milling</th>';
			content = content + '<th class="TableHdrCell" style="width:80px;">NoPrint</th><th class="TableHdrCell" style="width:120px;">Qty</th><th class="TableHdrCell">UoM</th>';
			content = content + '<th class="TableHdrCell" style="width:100px;">Order</th><th class="TableHdrCell" style="width:120px;">Load Date</th>';
			content = content + '<th class="TableHdrCell" style="width:110px;">Customer</th></tr></thead><tbody>';
			//alert('3 - contents -' + MyProdDeepDetails.length);
			if(!IsContentsNullUndefEmptyGu(MyProdDeepDetails)) {
				nbrpgs = parseInt(MyProdDeepDetails[0]['NbrPages'], 10);
				jiNbrRowsPj[1] = parseInt(MyProdDeepDetails[0]['NbrRows'], 10);
				jiNbrPagesPj[1] = nbrpgs;
				//alert('Start ' + jiNbrPagesPj[1].toString());
				if(nbrpgs > 1) { showit = 'display:inline'; }
				for (var row = 0; row < MyProdDeepDetails.length; row++) {
					content = content + '<tr><td class="StdTableCellWBorderLarge">' + MyProdDeepDetails[row]['RowType'].toString() + '</td><td class="StdTableCellWBorderLarge">' + MyProdDeepDetails[row]['LocCode'].toString() + '</td>';
					content = content + '<td class="StdTableCellWBorderLarge">' + MyProdDeepDetails[row]['LengthCode'].toString() + '</td><td class="StdTableCellWBorderLarge">' + MyProdDeepDetails[row]['Color'].toString() + '</td>';
					content = content + '<td class="StdTableCellWBorderLarge">' + MyProdDeepDetails[row]['Sort'].toString() + '</td><td class="StdTableCellWBorderLarge">' + MyProdDeepDetails[row]['Milling'].toString() + '</td>';
					fig = parseFloat(MyProdDeepDetails[row]['Qty']);
					content = content + '<td class="StdTableCellWBorderLarge">' + MyProdDeepDetails[row]['NoPrint'].toString() + '</td><td class="StdTableCellWBorderLarge" style="text-align:right;">' + getNbrStringFormattedTx(fig, 3, ',', '.', '', 2) + '</td>';
					content = content + '<td class="StdTableCellWBorderLarge">' + MyProdDeepDetails[row]['UOM'].toString() + '</td>';
					content = content + '<td class="StdTableCellWBorderLarge" style="text-align:center;">' + MyProdDeepDetails[row]['OrdNbr'].toString() + '</td>';
					content = content + '<td class="StdTableCellWBorderLarge" style="text-align:center;">' + MyProdDeepDetails[row]['sTargetDate'].toString() + '</td>';
					content = content + '<td class="StdTableCellWBorderLarge" style="text-align:center;">' + MyProdDeepDetails[row]['CustCode'].toString() + '</td></tr>';
				}
			}
			else {
				content = content + '<tr><td class="StdTableCellWBorderLarge" colspan="11">No Detail Rows were found</td></tr>';
			}
			content = content + '<tbody></table>';
			content = content + '<div id= "divTablePageBar2" style= "width:99%;text-align:center;' + showit + ';margin-top:6px;font-family:Calibri;vertical-align:middle;">';
			content = content + '<div id="divTableContainer2" class="effect1" style="border:1px solid lightgray;width:320px;line-height:14px;height:24px;margin: auto auto;">';
			content = content + '<table style="border:none;padding-left:20px;padding-right:20px;border-spacing:0px;height:24px;margin: auto auto;">';
			content = content + '<tr><td style="vertical-align:middle;"><a href="#" id="lnkPageFirst2" onclick="javascript:GoToNewPagePj(2, 0, ' + emptyval + ');return false" style="line-height:12px;height:18px;width:30px;font-size:20pt;text-decoration:none;">&#171;</a>&nbsp;</td>';
			content = content + '<td style="vertical-align:middle;"><a href="#" id="lnkPagePrev2" onclick="javascript:GoToNewPagePj(2, 1, ' + emptyval + ');return false;" style="line-height:12px;height:18px;width:30px;font-size:20pt;text-decoration:none;">&lsaquo;</a>&nbsp;&nbsp;&nbsp;</td>';
			content = content + '<td style="vertical-align:middle;">Page&nbsp;<label id="lblPageNbr2">1</label>&nbsp;of&nbsp;<label id="lblMaxPgNbr2">' + nbrpgs.toString() + '</label>&nbsp;&nbsp;&nbsp;</td>';
			content = content + '<td style="vertical-align:middle;"><a href="#" id="lnkPageNext2" onclick="javascript:GoToNewPagePj(2, 2, ' + emptyval + ');return false;" style="line-height:12px;height:18px;width:30px;font-size:20pt;text-decoration:none;">&rsaquo;</a>&nbsp;</td>';
			content = content + '<td style="vertical-align:middle;"><a href="#" id="lnkPageLast2" onclick="javascript:GoToNewPagePj(2,3, ' + emptyval + ');return false;" style="line-height:12px;height:18px;width:30px;font-size:20pt;text-decoration:none;">&#187;</a>&nbsp;&nbsp;&nbsp;</td>';
			content = content + '<td style="vertical-align:middle;">Goto&nbsp;Page:&nbsp;<input type="text" id="txtGotoPgNbr2" onblur="javascript:GoToNewPagePj(2, 4, this.value);" style="width:20px;height:18px;line-height:16px;padding:0px;margin:0px;" /></td>';
			content = content + '</tr></table></div></div>';
			//alert('4');
			//alert('displaying popup');
			ShowSpecialDialogBox1Dx('divMainPopup', ttl, true, true, ht, wdth, '', '', window, content, 'Done', '11pt', '1px', 'fadeIn', 'fadeOut', 11)
			jtblDeepDetails = document.getElementById('tblDeepDetails');
			//alert('2');
			EstablishMainPgElementsPj(2, 0);
			jiNbrPagesPj[1] = nbrpgs;
			joMaxPgNbrLblPj2.innerHTML = jiNbrPagesPj[1].toString();
			//alert('Dialog: ' + jiNbrPagesPj[1].toString());
			//alert('3');
			return false;
		}


		// **************************** Attachments *********************************
		// **************************** UI *********************************

		function ChangePageSize(val) {
			jiPageSize = parseInt(val, 10);
			Datacall1();
			return false;
		}

		function ShowDeepDetails() {
			ShowDeepDetailDialog();
			return false;
		}

		// **************************** External *********************************

		function CloseThisWindow() {
			window.open('', '_self').close();
			//window.close();
		}

	</script>

	<link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />

</head>
<body>
	<img id="imgSessionKeepAlive" width="1" height="1" style="display: none;" src="../Images/clearpixel.gif" />
	<form id="form1" runat="server">
		<asp:ScriptManager runat="server"></asp:ScriptManager>
		<input type="hidden" id="hfPageID" value="29" />

		<div id="divMainPopup" style="display: none;"></div>

		<div class="container body-content">

			<div id="divPAGEHDR" style="width: 98%;margin-left:10px;margin-top:10px;margin-bottom:10px;display: block;"> 
				<div id="divInvAdjFormHdr" style="width: 100%;" class="SpecHeaderTitle">
					<strong>Details For:</strong>&nbsp;&nbsp;
					Prod Type:&nbsp<label ID="lblProdTypeHdr" runat="server" style="color:blanchedalmond;"></label>&nbsp;&bull;&nbsp;
					Product ID:&nbsp<label ID="lblProductHdr" runat="server" style="color:blanchedalmond;"></label>&nbsp;&bull;&nbsp;
					Target Date:&nbsp<label ID="lblTDateHdr" runat="server" style="color:blanchedalmond;"></label>&nbsp;-&nbsp;Week:&nbsp;<label ID="lblTWeek" runat="server" style="color:blanchedalmond;"></label><br />
					Length:&nbsp;<label ID="lblLengthP" runat="server" style="color:blanchedalmond;">&nbsp;</label>&nbsp;&bull;&nbsp;
					Color:&nbsp;<label ID="lblColorP" runat="server" style="color:blanchedalmond;">&nbsp;</label>&nbsp;&bull;&nbsp;
					Sort:&nbsp;<label ID="lblSortP" runat="server" style="color:blanchedalmond;">&nbsp;</label>&nbsp;&bull;&nbsp;
					Milling:&nbsp;<label ID="lblMillingP" runat="server" style="color:blanchedalmond;">&nbsp;</label>&nbsp;&bull;&nbsp;
					NoPrint:&nbsp;<label ID="lblNoPrintP" runat="server" style="color:blanchedalmond;">&nbsp;</label>&nbsp;&bull;&nbsp;
					Master&nbsp;ID:&nbsp;<label ID="lblMasterID" runat="server" style="color:blanchedalmond;"></label>
				</div>

				<table style="padding:1px;border-spacing:0px;margin:auto auto;">
				<tr>
					<td>
						<table id="tblProductDescs" style="padding:1px;border-spacing:0px;margin:auto auto;">
						<thead>
						<tr>
							<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
								<label id="lblDesc1Hdr">1</label>
							</th>
							<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
								<label id="lblDesc2Hdr">2</label>
							</th>
							<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
								<label id="lblDesc3Hdr">3</label>
							</th>
							<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
								<label id="lblDesc4Hdr">4</label>
							</th>
							<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
								<label id="lblDesc5Hdr">5</label>
							</th>
							<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
								<label id="lblDesc6Hdr">6</label>
							</th>
							<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
								<label id="lblDesc7Hdr">7</label>
							</th>
							<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
								<label id="lblDesc8Hdr"></label>
							</th>
							<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
								<label id="lblDesc9Hdr"></label>
							</th>
							<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
								<label id="lblDesc10Hdr"></label>
							</th>
						</tr>
						</thead>
						<tr>
							<td class="MedTableStd">
								<label ID="lblDescVal1" class="StdCellContent"></label>
							</td>
							<td class="MedTableStd">
								<label ID="lblDescVal2" class="StdCellContent"></label>
							</td>
							<td class="MedTableStd">
								<label ID="lblDescVal3" class="StdCellContent"></label>
							</td>
							<td class="MedTableStd">
								<label ID="lblDescVal4" class="StdCellContent"></label>
							</td>
							<td class="MedTableStd">
								<label ID="lblDescVal5" class="StdCellContent"></label>
							</td>
							<td class="MedTableStd">
								<label ID="lblDescVal6" class="StdCellContent"></label>
							</td>
							<td class="MedTableStd">
								<label ID="lblDescVal7" class="StdCellContent"></label>
							</td>
							<td class="MedTableStd">
								<label ID="lblDescVal8" class="StdCellContent"></label>
							</td>
							<td class="MedTableStd">
								<label ID="lblDescVal9" class="StdCellContent"></label>
							</td>
							<td class="MedTableStd">
								<label ID="lblDescVal10" class="StdCellContent"></label>
							</td>
						</tr>
						</table>
					</td>
					<td>
						&nbsp;&nbsp;
					</td>
					<td style="vertical-align:top;">
						Page Size:&nbsp<select id="selPageSize" onchange="javascript:ChangePageSize(this.value);return false;" style="margin-left: 10px;">
							<option value="10">10</option>
							<option value="20" selected="selected">20</option>
							<option value="25">25</option>
							<option value="30">30</option>
							<option value="35">35</option>
							<option value="40">40</option>
							<option value="50">50</option>
						</select>
					</td>
				</tr>
				</table>
			</div>

			<div id="divPAGEMAIN" style="width: 98%; margin-left: 10px;">
				<div id="divInventoryChangeItem" style="width:100%;text-align:center;background-color:antiquewhite;display:none;">
					<label id="lblInvChangeEditHdr" style="color: darkgoldenrod; font-size: 12pt; font-weight: bold;">Product Details By Location:</label>
					<table style="border:none; margin:auto auto;"><tr><td>
						<table id="tblProdDetailsByLoc" class="LargerTableStd" style="margin: auto auto;">
						<thead>
						<tr>
							<th class="TableHdrCellLarge" style="width:50px;">&nbsp;Type&nbsp;</th>
							<th class="TableHdrCellLarge" style="width:60px;">&nbsp;Loc&nbsp;</th>
							<th class="TableHdrCellLarge" style="width:120px;">&nbsp;Location Name&nbsp;</th>
							<th class="TableHdrCellLarge" style="width:100px;">&nbsp;City&nbsp;</th>
							<th class="TableHdrCellLarge" style="width:72px;">StateProv</th>
							<th class="TableHdrCellLarge" style="width:58px;">UoM</th>
							<th class="TableHdrCellLarge" style="width:100px;">&nbsp;Qty&nbsp;</th>
							<th class="TableHdrCellLarge" style="width:70px;">&nbsp;Orders&nbsp;</th>
							<th class="TableHdrCellLarge" style="width:70px;">&nbsp;Forecast&nbsp;</th>
							<th class="TableHdrCellLarge" style="width:70px;">&nbsp;Prod&nbsp;</th>
						</tr>
						</thead>
						<tbody>
						</tbody>
						</table>
					</td></tr></table>

<!-- #include file="../inc/incPaginationDiv.inc" -->

			    <button id="btnCLoseThisForm" onclick="javascript:CloseThisWindow();return false;" class="button blue-gradient glossy">Close Window</button>
					
					<button id="btnSeeDeepDetails" class="button blue-gradient glossy" onclick="javascript:ShowDeepDetails();return false;" style="margin-left:6px;display:none;">Show Details</button>
					<br />

				</div>
			</div>

			<!----------------------------------------- FOOTER PORTION ----------------------------------------------->
			<div id="divPAGEFOOTER" style="width: 99%; margin-left: 10px; margin-bottom: 10px;">
				<div id="divStatusMsg" style="width: 100%;">
					<label id="lblStatusMsg" style="color: maroon; font-size: 12pt; font-weight: bold;"></label>
				</div>
			</div>

			<footer>
				<div id="divMasterFooter" style="border-top: 1px solid gray; line-height: 16px; margin: 0px; font-size: 9pt;">
					<table id="tblMasterFooter" style="width: 100%; padding: 1px; border-spacing: 0px;">
						<tr>
							<td style="width: 50%;">&nbsp;Version&nbsp;<label id="lblVersion" runat="server"></label>&nbsp;
							dated&nbsp;<label id="lblVersionDate" runat="server"></label>&nbsp;
							Build:&nbsp;<label id="lblBuildNbr" runat="server"></label>&nbsp;
							&copy;
								<label id="lblCurrentYearFtr" runat="server">1999</label>
								Northwest Hardwoods, Inc.
							</td>
							<td style="width: 50%; text-align: right;">&nbsp;<label id="lblPageIDInFooter"></label>
								&nbsp;&nbsp;<span id="spnCurrDateNV" style="color: #A0A0A0;">&nbsp;</span>&nbsp;&nbsp;Session Start:&nbsp;<span id="clockNV" style="color: #A0A0A0;">&nbsp;</span>&nbsp;
							</td>
						</tr>
					</table>
				</div>
			</footer>

		</div>
	</form>
</body>
</html>
