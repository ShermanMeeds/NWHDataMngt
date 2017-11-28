<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SalesProducts.aspx.cs" Inherits="DataMngt.sales.SalesProducts" %>
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
		var jbtnAddNewRow;
		var jbtnCancelEdit;
		var jbtnEditCatAvail;
		var jbtnSaveEdit;
		var jbViewOnly = true;
		var jchkManagedOnly;
		var jchkPrinterFriendly;
		var jdivGridFilters;
		var jdivProdItemEdit;
		var jdToday = new Date();
		var jiActionStatusID = 0;	 // required for MyReturn analysis
		var jiAR = 0;
		var jiByID = 0;
		var jiDirection = 0;
		var jiNbrPages = 0;
		var jiNbrRows = 0;
		var jiPageID = 31;
		var jiPageNbr = 0;
		var jiPageSize = 20;
		var jiActionStatusCode = '';	 // required for MyReturn analysis
		var jiActionStatusMsg = '';		 // required for MyReturn analysis
		var jimgSortDir;
		var jiTotalRows = 0;
		var jiWeekNbr = 0;
		var jiUserID = 0;
		var jlCatDataIDE;
		var jlPageStatus;
		var jlStatusMsg;
		var jlWeekStatus;
		var jsBrowserType = '';
		var jsCurrentTime = '';
		var jselColorF;
		var jselDataSort;
		var jselGradeF;
		var jselIsManagedE;
		var jselIsTrackedE;
		var jselItemColorE;
		var jselItemGradeE;
		var jselItemLengthE;
		var jselItemMillingE;
		var jselItemNoPrintE;
		var jselItemSortE;
		var jselItemSpeciesE;
		var jselItemThicknessE;
		var jselLengthF;
		var jselMillingF;
		var jselNoPrintF;
		var jselPageSize;
		var jselProductCodeE;
		var jselProductTypeE;
		var jselRegionE;
		var jselRegionF;
		var jselSortF;
		var jselSpeciesF;
		var jselThicknessF;
		var jsErrorMsg = '';
		var jsPageVersion = '';
		var jsPageVersDate = '';
		var jspnAddNewRowBtn;
		var jspnSaveDataBtn;
		var jspnCancelEditBtn;
		var jsToday = '';
		var jtaProdDescE;
		var jtblProdItemList;
		var jtCommentsF;

		var jtPriceE;
		var jtCommentPmE;
		var jbtnSaveProdItemData;
		var jbtnCloseProdItemEdit;

		var MyCodeList;
		var MyColorList;
		var MyGradeList;
		var MyLengthList;
		var MyLocationList;
		var MyMillingList;
		var MyNoPrintList;
		var MyCodeListData;
		var MyProductData;
		var MyProdItemData;
		var MyProductListMngd;
		var MyProductTypes;
		var MyReturn;
		var MySortList;
		var MySpeciesList;
		var MyThicknessList;
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
			jiPageID = 31;
			jsPageVersion = '1.0.0';
			jsPageVersDate = '9/25/2017';
			jbViewOnly = true;
			jbCanEdit = false;
			//alert('loading seed values');
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

			$('#Form1').on("submit", function (evt) {
				evt.preventDefault();
			});

			//alert('setting pointers');
			jbtnCloseProdItemEdit = document.getElementById('btnCloseProdItemEdit');
			jbtnSaveProdItemData = document.getElementById('btnSaveProdItemData');
			jchkManagedOnly = document.getElementById('chkManagedOnly');
			jdivGridFilters = document.getElementById('divGridFilters');
			jdivProdItemEdit = document.getElementById('divProdItemEdit');
			jlCatDataIDE = document.getElementById('lblCatDataIDE');
			jlPageStatus = document.getElementById('lblPageStatus');
			jlStatusMsg = document.getElementById('lblStatusMsg');
			jselColorF = document.getElementById('selColorF');
			//alert('1');
			jselGradeF = document.getElementById('selGradeF');
			jselIsManagedE = document.getElementById('selIsManagedE');
			jselIsTrackedE = document.getElementById('selIsTrackedE');
			jselItemColorE = document.getElementById('selItemColorE');
			jselItemGradeE = document.getElementById('selItemGradeE');
			jselItemLengthE = document.getElementById('selItemLengthE');
			jselItemMillingE = document.getElementById('selItemMillingE');
			jselItemNoPrintE = document.getElementById('selItemNoPrintE');
			jselItemSortE = document.getElementById('selItemSortE');
			jselItemSpeciesE = document.getElementById('selItemSpeciesE');
			jselItemThicknessE = document.getElementById('selItemThicknessE');
			jselLengthF = document.getElementById('selLengthF');
			//alert('2');
			jselMillingF = document.getElementById('selMillingF');
			//alert('2a');
			jselNoPrintF = document.getElementById('selNoPrintF');
			jselPageSize = document.getElementById('selPageSize');
			jselProductCodeE = document.getElementById('selProductCodeE');
			//alert('2b');
			jselProductTypeE = document.getElementById('selProductTypeE');
			jselSpeciesF = document.getElementById('selSpeciesF');
			//alert('3');
			jselProductCodeE = document.getElementById('selProductCodeE');
			jselRegionE = document.getElementById('selRegionE');
			jselRegionF = document.getElementById('selRegionF');
			jselSortF = document.getElementById('selSortF');
			jselSpeciesF = document.getElementById('selSpeciesF');
			jselThicknessF = document.getElementById('selThicknessF');
			jtblProdItemList = document.getElementById('tblProdItemList');
			jtaProdDescE = document.getElementById('txaProdDescE');
			jtCommentPmE = document.getElementById('txtCommentPmE');
			jtCommentsF = document.getElementById('txtCommentsF');
			jtPriceE = document.getElementById('txtPriceE');

			jspnAddNewRowBtn = document.getElementById('spnAddNewRowBtn');
			jspnSaveDataBtn = document.getElementById('spnSaveDataBtn');
			jspnCancelEditBtn = document.getElementById('spnCancelEditBtn');
			jbtnEditCatAvail = document.getElementById('btnEditCatAvail');
			jbtnAddNewRow = document.getElementById('btnAddNewRow');
			jbtnCancelEdit = document.getElementById('btnCancelEdit');
			jbtnSaveEdit = document.getElementById('btnSaveEdit');
			jchkPrinterFriendly = document.getElementById('chkPrinterFriendly');
			jselDataSort = document.getElementById('selDataSort');
			jimgSortDir = document.getElementById('imgSortDir');

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
			//alert('beginning initiation');
			var val = '';
			if (jbA === true) {
				// nothing
			}
			else {
				// nothing
			}

			jiPgNbrPj[0] = 0;
			jiNbrPagesPj[0] = 0;
			jiNbrRowsPj[0] = 0;
			jiPageSize = 20;

			//alert('setting pagination');
			EstablishMainPgElementsPj(1, 0);
			try {
				//alert('loading filters');
				PopulateColorList();
				PopulateGradeList();
				PopulateLengthList();
				PopulateMillingList();
				PopulateNoPrintList();
				PopulateSortList();
				PopulateSpeciesList();
				PopulateThicknessList();
				PopulateProductList();
				PopulateProductTypes();
			}
			catch (ex) {
				alert(ex);
			}
			//createDatePickerOnTextWc('txtBeginDateF', null, null, 0, 3, 'show', 11);
			//createDatePickerOnTextWc('txtEndDateF', null, null, 0, 3, 'show', 12);
			//createDatePickerOnTextWc('txtCommentDateE', null, null, 0, 1, 'show', 16);

			DataCall1();
			//alert('Initiation done');
			jlPageStatus.innerHTML = 'Page Ready';
			document.getElementById('lblPageIDInFooter').innerHTML = 'Page ID: ' + jiPageID.toString();
			return false;
		}
		// END of page initiation section --------------------------------------------------------------------------------

		// **************************** AJAX FUNCTIONS *********************************

		function DataCall1() {
			//alert('loading main data');
			jiPageNbr = jiPgNbrPj[0];
			GetProductData();
			PopulateProductGrid();
			return false;
		}

		function GetCodeList(typ) {
			var url = "../shared/AjaxServices.asmx/GetCatCodeList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'2','CodeType':'" + typ.toString() + "','Sort':'0','Active':'1','UserList':'0', 'NoBlank':'1','Shown':'0','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCodeList = response; });
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
			var region = jselRegionF.value;
			var url = "../shared/AjaxServices.asmx/SelectProductCodeListForRegion";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','Region':'" + region + "','CodeType':'" + ctype + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCodeListData = response; });
			return false;
		}

		function GetProdItemData(pmid, plid, ptype, pcode) {
			var url = "../shared/GridSupportServices.asmx/SelectProductItemData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','PMID':'" + pmid.toString() + "','PLID':'" + plid.toString() + "','ProdType':'" + ptype + "','ProdCode':'" + pcode + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProdItemData = response; });
			return false;
		}
              
		function GetProductData() {
			var region = jselRegionF.value;
			var spec = jselSpeciesF.value;
			var grade = jselGradeF.value;
			var thick = jselThicknessF.value;
			var color = jselColorF.value;
			var len = jselLengthF.value;
			var milling = jselMillingF.value;
			var noprint = jselNoPrintF.value;
			var fsort = jselSortF.value;
			var mgd = 0;
			if (jchkManagedOnly.checked === true) {mgd = 1;}
			var cmt = jtCommentsF.value;

			var url = "../shared/GridSupportServices.asmx/SelectSalesProductList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','Region':'" + region + "','Species':'" + spec + "','Grade':'" + grade + "','Thick':'" + thick + "','Len':'" + len + "','Color':'" + color + "',";
			MyData = MyData + "'fSort':'" + fsort + "','Milling':'" + milling + "','NoPrint':'" + noprint + "','Comment':'" + cmt + "','Mngd':'" + mgd.toString() + "','Active':'1','Sort':'0','Dir':'" + jiDirection.toString() + "',";
			MyData = MyData + "'PgNbr':'" + jiPgNbrPj[0].toString() + "','PgSize':'" + jiPageSize.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProductData = response; });
			return false;
		}

		function GetProductListManaged(pmid, ptype, pcode, reg, thick, spec, grade, sort, act) {
			var region = jselRegionF.value;
			var loc = '';
			var url = "../shared/AjaxServices.asmx/SelectProductListManaged";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','PMID':'" + pmid.toString() + "','ProdType':'" + ptype + "','ProdCode':'" + pcode + "','Reg':'" + reg + "','Thickness':'" + thick + "','Specie':'" + spec + "',";
			MyData = MyData + "'Grade':'" + grade + "','Sort':'" + sort.toString() + "','Active':'" + act.toString() + "','Short':'1','PgNbr':'0','PgSize':'9999','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProductListMngd = response; });
			return false;
		}

		function GetProductTypes(pt) {
			var url = "../shared/AjaxServices.asmx/SelectProductTypesList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ProdType':'" + pt + "','Sort':'0','Active':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProductTypes = response; });
			return false;
		}

		function UpdateProductData(id, reg, pcode, desc, prc, cmt, spec, thick, grade, len, clr, sort, mill, noprint, nattach, mngd, trkd) {
			var url = "../shared/GridSupportServices.asmx/SelectSalesProductData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ID':'" + id.toString() + "','Region':'" + reg + "','Product':'" + pcode + "','ProdID':'" + pcode + "','Desc':'" + desc + "','Price':'" + prc + "',";
			MyData = MyData + "'Comments':'" + cmt + "','Specie':'" + spec + "','Thickness':'" + thick + "','Grade':'" + grade + "','Len':'" + len + "','Color':'" + clr + "','Sort':'" + sort + "','Milling':'" + mill + "',";
			MyData = MyData + "'NoPrint':'" + noprint + "','NbrAttach':'" + nattach.toString() + "','Mngd':'" + mngd.toString() + "','Track':'" + trkd.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			EvaluateStdDatabaseReturnAs(MyReturn, jlStatusMsg, 'An error stopped database update', 'Unexpected return from update attempt. The data was probably not updated.', 'Update failed. Please check status for more information.');
			return false;
		}

		function UpdateProductDataItem(id, typ, val) {
			var url = "../shared/GridSupportServices.asmx/UpdateProductDataItem";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ID':'" + id.toString() + "','Typ':'" + typ.toString() + "','Val':'" + val + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			EvaluateStdDatabaseReturnAs(MyReturn, jlStatusMsg, 'An error stopped database update', 'Unexpected return from update attempt. The data was probably not updated.', 'Update failed. Please check status for more information.');
			return false;
		}

		function DeleteProductItem(id) {




		}

		// **************************** Populate *********************************
		
		function PopulateColorList() {
			GetProdCodeList('Color');
			if (!IsContentsNullUndefinedGu(MyCodeListData)) {
				// filter
				ClearDDLOptionsGu('selColorF', 1);
				fillDropDownListGu(MyCodeListData, jselColorF, 0, 'CodeDescAbbreviated', 'CatCode');
				// edit list
				ClearDDLOptionsGu('selItemColorE', 1);
				fillDropDownListGu(MyCodeListData, jselItemColorE, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateGradeList() {
			GetProdCodeList('Grade');
			if (!IsContentsNullUndefinedGu(MyCodeListData)) {
				// filter
				ClearDDLOptionsGu('selGradeF', 1);
				fillDropDownListGu(MyCodeListData, jselGradeF, 0, 'CodeDescAbbreviated', 'CatCode');
				// edit list
				ClearDDLOptionsGu('selItemGradeE', 1);
				fillDropDownListGu(MyCodeListData, jselItemGradeE, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateLengthList() {
			GetProdCodeList('Length');
			if (!IsContentsNullUndefinedGu(MyCodeListData)) {
				// filter
				ClearDDLOptionsGu('selLengthF', 1);
				fillDropDownListGu(MyCodeListData, jselLengthF, 0, 'CodeDescAbbreviated', 'CatCode');
				// edit list
				ClearDDLOptionsGu('jselItemLengthE', 1);
				fillDropDownListGu(MyCodeListData, jselItemLengthE, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateMillingList() {
			GetProdCodeList('Milling');
			if (!IsContentsNullUndefinedGu(MyCodeListData)) {
				// filter
				ClearDDLOptionsGu('selMillingF', 1);
				fillDropDownListGu(MyCodeListData, jselMillingF, 0, 'CodeDescAbbreviated', 'CatCode');
				// edit list
				ClearDDLOptionsGu('selItemMillingE', 1);
				fillDropDownListGu(MyCodeListData, jselItemMillingE, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateNoPrintList() {
			GetProdCodeList('NoPrint');
			if (!IsContentsNullUndefinedGu(MyCodeListData)) {
				// filter
				ClearDDLOptionsGu('selNoPrintF', 1);
				fillDropDownListGu(MyCodeListData, jselNoPrintF, 0, 'CodeDescAbbreviated', 'CatCode');
				// edit list
				ClearDDLOptionsGu('selItemNoPrintE', 1);
				fillDropDownListGu(MyCodeListData, jselItemNoPrintE, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateSortList() {
			GetProdCodeList('Sort');
			if (!IsContentsNullUndefinedGu(MyCodeListData)) {
				// filter
				ClearDDLOptionsGu('selSortF', 1);
				fillDropDownListGu(MyCodeListData, jselSortF, 0, 'CodeDescAbbreviated', 'CatCode');
				// edit list
				ClearDDLOptionsGu('selItemSortE', 1);
				fillDropDownListGu(MyCodeListData, jselItemSortE, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateSpeciesList() {
			GetProdCodeList('Species');
			if (!IsContentsNullUndefinedGu(MyCodeListData)) {
				// filter
				ClearDDLOptionsGu('selSpeciesF', 1);
				fillDropDownListGu(MyCodeListData, jselSpeciesF, 0, 'CodeDescAbbreviated', 'CatCode');
				// edit list
				ClearDDLOptionsGu('selItemSpeciesE', 1);
				fillDropDownListGu(MyCodeListData, jselItemSpeciesE, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateThicknessList() {
			GetProdCodeList('Thickness');
			if (!IsContentsNullUndefinedGu(MyCodeListData)) {
				// filter
				ClearDDLOptionsGu('selThicknessF', 1);
				fillDropDownListGu(MyCodeListData, jselThicknessF, 0, 'CodeDescAbbreviated', 'CatCode');
				// edit list
				ClearDDLOptionsGu('selItemThicknessE', 1);
				fillDropDownListGu(MyCodeListData, jselItemThicknessE, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateProductGrid() {
			//alert('Filling settings List');
			var cellClass = 'StdTableCell';
			var nCol = 17;
			// Cols: 0-ID, 1-Active, 2-Managed, 3-Specie, 4-Thickness, 5-Grade, 6-Region, 7-ProductCode, 8-Desc, 9-Length, 10-Color, 11-Sort, 12-Milling, 13-NoPrint, 14-Price, 15-Comments, 16-ACTION
			//alert('arrays');
			var cWidth = [50, 42, 42, 70, 70, 70, 60, 62, 336, 80, 80, 80, 80, 80, 100, 200, 126, 0, 0, 0, 0];
			var corientH = ['center', 'center', 'center', 'center', 'center', 'left', 'left', 'left', 'left', 'center', 'center', 'left', 'left', 'left', 'right', 'left', 'center', '', '', '', '', ''];
			var corientV = ['top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', '', '', '', ''];
			var cbrdrL = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrR = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrT = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrB = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', ''];
			var cnames = ['ProductManagedID', 'sIsActive', 'ManagedItem', 'Specie', 'Thickness', 'Grade', 'Region', 'ProdID', 'Product', 'Length', 'Color', 'Sort', 'Milling', 'NoPrint', 'sPrice', 'Comments', 'ACTION', '', '', '', '', '', '', '', '', '', '', ''];
			var cType = [0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 0, 0, 0, 0, 0, 0];	// 1-int, 2-money, 3-money 2prec, 4-textbox, 5-checkbox, 6-ddl, 999-pre
			var aggType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var shown = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
			//alert('DDL list data');

			if (!IsContentsNullUndefinedGu(MyProductData)) {
				//alert('List Len: ' + MyProductData.length);
				var bdy = FormDataGridBodyMinimumDg(1, nCol, 'tdProdItemList', cellClass, true, true, false, true, 'New', 'button blue-gradient glossy', false, 0, MyProductData, 'ProductManagedID', cnames, cType, cWidth, corientH, corientV, cbrdrL, cbrdrR, cbrdrT, cbrdrB, aggType, shown, true, true);
				//alert('Grid done');
				jtblProdItemList.style.display = 'block';
			}
			else {
				alert('Comment List bad data');
				ShowStatusMsg('An unidentified error occurred. No records could be extracted.');
			}
			//alert('Attaching body');
			try {
				var oldBody = jtblProdItemList.getElementsByTagName("tbody")[0];
				jtblProdItemList.replaceChild(bdy, oldBody);
			}
			catch (ex) {
				// nothing
			}
			joPgNbrLblPj.innerHTML = (jiPgNbrPj[0]+1).toString();
			joMaxPgNbrLblPj.innerHTML = jiNbrPagesPj[0].toString();
			return false;
		}

		function PopulateProductList() {
			GetProductListManaged(0, '', '', '', '', '', '', 0, 1);
			//alert(MyProductListMini.length);
			if (!IsContentsNullUndefinedGu(MyProductListMngd)) {
				ClearDDLOptionsGu('selProductCodeE', 1);
				fillDropDownListGu(MyProductListMngd, jselProductCodeE, 0, 'ProdDesc', 'ProductManagedID');
			}
			return false;
		}

		function PopulateProductTypes() {
			GetProductTypes('');
			if (!IsContentsNullUndefinedGu(MyProductTypes)) {
				ClearDDLOptionsGu('selProductTypeE', 1);
				fillDropDownListGu(MyProductTypes, jselProductTypeE, 0, 'ProdCodeType', 'ProductTypeCode');
			}
			return false;
		}

		// **************************** Dialogs *********************************

		function ActivateHyperlink(id, objid, val1, val2, val3) {
			return false;
		}

		function ChangeCheckBox(id, row, col, objid, val) {
			//alert('Fired -' + id + '/' + objid + '/' + val);
			if (id > 0) {
				switch (objid) {
					case 1:
						var ischecked = '0';
						if (val === 'on') { ischecked = '1'; };
						UpdateProductDataItem(id, 2, ischecked);
						break;
					default:
						break;
				}
			}
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
					if (id > 0) {
						switch (col) {
							case 14: //price
								UpdateProductDataItem(id, 0, val);
								break;
							case 15: // comment
								UpdateProductDataItem(id, 1, val);
								break;
							default:
								break;
						}
					}
					break;
				case 2:
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
			if (confirm('This will remove the item from the active list. Do you want to continue?')) {
				switch (objid) {
					case 1:
						DeleteProductItem(id);
						break;
					case 6:
						break;
					default:
						break;
				}
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
				case 1: // prod
					jlCatDataIDE.innerHTML = MyProductData[row]['ProductManagedID'].toString();
					jselRegionE.value = MyProductData[row]['Region'].toString();
					jselProductCodeE.value = MyProductData[row]['ProductCode'].toString();
					jtaProdDescE.value = MyProductData[row]['Product'].toString();
					jtPriceE.value = MyProductData[row]['Price'].toString();
					jtCommentPmE.value = MyProductData[row]['Comments'].toString();
					jselItemSpeciesE.value = MyProductData[row]['Specie'].toString();
					jselItemThicknessE.value = MyProductData[row]['Thickness'].toString();
					jselItemGradeE.value = MyProductData[row]['Grade'].toString();
					jselItemLengthE.value = MyProductData[row]['Length'].toString();
					jselItemColorE.value = MyProductData[row]['Color'].toString();
					jselItemSortE.value = MyProductData[row]['Sort'].toString();
					jselItemMillingE.value = MyProductData[row]['Milling'].toString();
					jselItemNoPrintE.value = MyProductData[row]['NoPrint'].toString();
					jselProductCodeE.value = MyProductData[row]['ProductManagedID'].toString();
					jselProductTypeE.value = MyProductData[row]['ProdType'].toString();
					if (MyProductData[row]['sManaged'].toString() === 'Yes') {
						jchkManagedOnly.checked = true;
					}
					else {
						jchkManagedOnly.checked = false;
					}
					jdivProdItemEdit.style.display = 'block';
					jdivGridFilters.style.display = 'none';
					break;
				case 6:
					break;
				default:
					break;
			}

			return false;
		}

		function SpecialGridAction(id, row, col, objid) {
			switch (objid) {
				case 1: // new item based on existing one
					jlCatDataIDE.innerHTML = '0'; //MyProductData[row]['ProductManagedID'].toString();
					jselRegionE.value = MyProductData[row]['Region'].toString();
					jselProductCodeE.value = MyProductData[row]['ProductCode'].toString();
					jtaProdDescE.value = MyProductData[row]['Product'].toString();
					jtPriceE.value = MyProductData[row]['Price'].toString();
					jtCommentPmE.value = MyProductData[row]['Comments'].toString();
					jselItemSpeciesE.value = MyProductData[row]['Specie'].toString();
					jselItemThicknessE.value = MyProductData[row]['Thickness'].toString();
					jselItemGradeE.value = MyProductData[row]['Grade'].toString();
					jselItemLengthE.value = MyProductData[row]['Length'].toString();
					jselItemColorE.value = MyProductData[row]['Color'].toString();
					jselItemSortE.value = MyProductData[row]['Sort'].toString();
					jselItemMillingE.value = MyProductData[row]['Milling'].toString();
					jselItemNoPrintE.value = MyProductData[row]['NoPrint'].toString();
					jselProductCodeE.value = MyProductData[row]['ProductManagedID'].toString();
					jselProductTypeE.value = MyProductData[row]['ProdType'].toString();
					if (MyProductData[row]['sManaged'].toString() === 'Yes') {
						jchkManagedOnly.checked = true;
					}
					else {
						jchkManagedOnly.checked = false;
					}
					jdivProdItemEdit.style.display = 'block';
					jdivGridFilters.style.display = 'none';
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

		function AddNewRow() {
			jlCatDataIDE.innerHTML = '0';
			jselRegionE.value = '0';
			jselProductCodeE.value = '0';
			jtaProdDescE.value = '';
			jtPriceE.value = '0.00';
			jtCommentPmE.value = '';
			jselItemSpeciesE.value = '0';
			jselItemThicknessE.value = '0';
			jselItemGradeE.value = '0';
			jselItemLengthE.value = '0';
			jselItemColorE.value = '0';
			jselItemSortE.value = '0';
			jselItemMillingE.value = '0';
			jselItemNoPrintE.value = '0';
			jchkManagedOnly.checked = false;
			jdivProdItemEdit.style.display = 'block';
			jdivGridFilters.style.display = 'none';
			return false;
		}

		function ChangeSortDir() {
			if (jiDirection === 0) {
				jimgSortDir.src = '../Images/arrow2_s.gif';
				jiDirection = 1;
			}
			else {
				jimgSortDir.src = '../Images/arrow2_n.gif';
				jiDirection = 0;
			}
			return false;
		}

		function ChangePageSize(val) {
			jiPageSize = parseInt(val, 10);
			RefreshDataGrid();
			return false;
		}

		function CloseProdItemEdit() {
			jdivGridFilters.style.display = 'block';
			jdivProdItemEdit.style.display = 'none';
			return false;
		}
		
		function GetProdCodeData(val) {
			// val is product code
			var ptype = jselProductTypeE.value;
			if (ptype === '0') {
				alert('Product Type must be selected');
			}
			else {
				GetProdItemData(0, 0, ptype, val);
				if (!IsContentsNullUndefEmptyGu(MyProdItemData)) {
					jselItemColorE.value = MyProdItemData[0]['Color'].toString();
					jselItemGradeE.value = MyProdItemData[0]['Grade'].toString();
					jselItemLengthE.value = MyProdItemData[0]['Length'].toString();
					jselItemMillingE.value = MyProdItemData[0]['Milling'].toString();
					jselItemNoPrintE.value = MyProdItemData[0]['NoPrint'].toString();
					jselItemSortE.value = MyProdItemData[0]['Sort'].toString();
					jselItemSpeciesE.value = MyProdItemData[0]['Specie'].toString();
					jselItemThicknessE.value = MyProdItemData[0]['Thickness'].toString();
					jtPriceE.value = MyProdItemData[0]['Price'].toString();
					jtCommentPmE.value = MyProdItemData[0]['Comments'].toString();
				}
			}
			return false;
		}

		function RefreshDataGrid() {
			DataCall1();
			return false;
		}

		function SaveProdItemData() {
			var id = jlCatDataIDE.innerHTML;
			var reg = jselRegionE.value;
			var pcode = jselProductCodeE.value;
			var desc = jtaProdDescE.value; 
			var prc = jtPriceE.value.replace('$', '');
			prc = prc.replace(',', '');
			var cmt = jtCommentPmE.value.replace(/\'/g, '');
			var spec = jselItemSpeciesE.value;
			var thick = jselItemThicknessE.value;
			var grade = jselItemGradeE.value;
			var len = jselItemLengthE.value;
			var clr = jselItemColorE.value;
			var sort = jselItemSortE.value;
			var mill = jselItemMillingE.value;
			var noprint = jselItemNoPrintE.value;
			var nattach = 0;
			var mngd = 0;
			var trkd = 1;
			if (jchkManagedOnly.checked === true) {mngd = 1;}
			UpdateProductData(id, reg, pcode, desc, prc, cmt, spec, thick, grade, len, clr, sort, mill, noprint, nattach, mngd, trkd);
			CloseProdItemEdit();
			DataCall1();
			return false;
		}

		// **************************** External Links *********************************

		function GotoOtherPage(url) {
			document.location.href = url;
			return false;
		}

	</script>
			
  <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />

</head>
<body>
	<img id="imgSessionKeepAlive" width="1" height="1" style="display:none;" src="../Images/clearpixel.gif" />
  <form id="form1" runat="server">
  <asp:ScriptManager runat="server"></asp:ScriptManager>
	<asp:HiddenField ID="hfPageID" runat="server" Value="44" />

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

			<div id="divPAGEHEADER" style="width:98%;margin-left:10px;margin-bottom:10px;">
				<table style="width:100%;border-spacing:0px;padding:0px;padding-bottom:4px;margin-right:20px;">
				<tr>
					<td style="width:25%;">
						<span id="spnREgPriceGVLbllit" style="color:blue;font-size:14pt;font-weight:bold;"><asp:Literal ID="RegPriceGVLbllit" runat="server" Text="Region Price Tracking"></asp:Literal></span>
					</td>
					<td style="width:25%;">
						<div id="divUpperBtnBar" runat="server" style="text-align:center;">
							<span id="spnAddNewRowBtn" style="display:inline;"><button ID="btnAddNewRow" class="button blue-gradient glossy" onclick="javascript:AddNewRow();return false;">Add New Row</button>&nbsp;&nbsp;</span>
							<span id="spnSaveDataBtn" style="display:none;"><button ID="btnSaveEdit" class="button blue-gradient glossy" onclick="javascript:SaveProdItemData();return false;">Update</button>&nbsp;&nbsp;</span>
							<span id="spnCancelEditBtn" style="display:none;"><button ID="btnCancelEdit" class="button blue-gradient glossy" onclick="javascript:CloseProdItemEdit();return false;" >Cancel</button>&nbsp;&nbsp;</span>
							<button ID="btnEditCatAvail" style="" class="button blue-gradient glossy" onclick="javascript:GotoOtherPage('../sales/CatTool.aspx?v=1');return false;" >View Availability</button>&nbsp;&nbsp;
							Printer Friendly:&nbsp;<input type="checkbox" id="chkPrinterFriendly" onchange="javascript:ChangeDisplayPrinterFriendly();return false;" />
						</div>
					</td>
					<td style="width:25%;text-align:Center;vertical-align:bottom;">
						<label style="margin-left: 5px;">Sort Data By:</label>
						<select id="selDataSort" onclick="javascript:DataSortChanged(this.value);return false;" style="margin-left: 6px;">
							<option value="0" Selected="selected">Region-Product-Specie</option>
							<option value="1">Product-Specie-Thickness</option>
							<option value="2">Specie-Thickness-Grade</option>
							<option value="3">Product Code</option>
							<option value="4">Price-Product Code</option>
						</select>&nbsp;&nbsp;
						<input type="image" id="imgSortDir" src="../Images/arrow2_n.gif" style="width:20px;height:20px;" onclick="javascript:ChangeSortDir();return false;" />
					</td>
					<td>
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
					</td>
					<td style="text-align:right;">
						<label id="lblPageStatus" style="position:absolute;font-size:10pt;font-weight:bold;color:darkgray;right:70px;">Page Loading...</label>&nbsp;
					</td>
				</tr>
				</table>
			</div>

			<div id="divPAGEMAINSECTION" style="width:100%;margin-left:10px;">
				<div id="divProdItemEdit" style="width:100%;background-color:antiquewhite;display:none;margin-bottom:6px;">
					<label id="lblEditMsg" style="font-style:italic;color:maroon;font-weight:bold;">Edit Item Data Below and click on SAVE button:</label><br />
					<table style="padding:4px;margin:auto auto;"><tr><td>
						<table id="tblProdItemEdit" style="padding:1px;border-spacing:0px;border-collapse:collapse;margin:auto auto;">
						<tr>
							<td style="text-align:right;">
								ID:&nbsp;
							</td>
							<td style="text-align:left;vertical-align:top;" colspan="5">
								<label id="lblCatDataIDE" style="font-weight:bold;color:blue;">0</label>&nbsp;&nbsp;&nbsp;
								<span style="margin-left:30px;">
									Is&nbsp;Managed:&nbsp;
									<select ID="selIsManagedE">
										<option Value="1" selected="selected">Yes</option>
										<option Value="0">No</option>
									</select>
								</span>
								<span style="margin-left:30px;">
									Is&nbsp;Tracked:&nbsp;
									<select ID="selIsTrackedE">
										<option Value="1" selected="selected">Yes</option>
										<option Value="0">No</option>
									</select>&nbsp;&nbsp;&nbsp;
								</span>
							</td>
						</tr>
						<tr>
							<td style="text-align:right;vertical-align:top;">
								Product:&nbsp;
							</td>
							<td style="text-align:left;vertical-align:top;">
								<select id="selProductTypeE">
									<option Value="0" selected="selected">None Selected</option>
								</select>

								<select id="selProductCodeE" onchange="javascript:GetProdCodeData(this.value);return false;">
									<option Value="0" selected="selected">None Selected</option>
								</select>
							</td>
							<td>
								&nbsp;
							</td>
							<td style="text-align:right;vertical-align:top;" rowspan="2">
								Description:&nbsp;
							</td>
							<td style="text-align:left;" colspan="4" rowspan="2">
								<textarea id="txaProdDescE" style="width:500px;height:40px;"></textarea>
							</td>
						</tr>
							<td style="text-align:right;vertical-align:top;">
								Region:&nbsp;
							</td>
							<td style="text-align:left;">
								<select ID="selRegionE">
									<option Value="0" selected="selected">ALL</option>
									<option Value="APP">Appalachian</option>
									<option Value="GLA">Glacial</option>
									<option Value="NORTH">North</option>
									<option Value="WEST">West</option>
								</select>
								&nbsp;&nbsp;&nbsp;
							</td>
						<tr>
							<td style="text-align:right;vertical-align:top;">
								Thickness:&nbsp;
							</td>
							<td style="text-align:left;">
								<select ID="selItemThicknessE">
									<option Value="0" selected="selected">None Selected</option>
								</select>
							</td>
							<td>
								&nbsp;
							</td>
							<td style="text-align:right;vertical-align:top;">
								Specie:&nbsp;
							</td>
							<td style="text-align:left;">
								<select ID="selItemSpeciesE">
									<option Value="0" selected="selected">None Selected</option>
								</select>
							</td>
							<td>
								&nbsp;
							</td>
							<td style="text-align:right;vertical-align:top;">
								Grade:&nbsp;
							</td>
							<td style="text-align:left;">
								<select ID="selItemGradeE">
									<option Value="0" selected="selected">None Selected</option>
								</select>
							</td>
						</tr>
						<tr>
							<td style="text-align:right;vertical-align:top;">
								Length:&nbsp;
							</td>
							<td style="text-align:left;">
								<select id="selItemLengthE">
									<option Value="0" selected="selected">None Selected</option>
								</select>
							</td>
							<td>
								&nbsp;
							</td>
							<td style="text-align:right;vertical-align:top;">
								Color:&nbsp;
							</td>
							<td style="text-align:left;">
								<select id="selItemColorE">
									<option Value="0" selected="selected">None Selected</option>
								</select>
							</td>
							<td>
								&nbsp;
							</td>
							<td style="text-align:right;vertical-align:top;">
								Sort:&nbsp;
							</td>
							<td style="text-align:left;">
								<select id="selItemSortE">
									<option Value="0" selected="selected">None Selected</option>
								</select>
							</td>
						</tr>
						<tr>
							<td style="text-align:right;vertical-align:top;">
								Milling:&nbsp;
							</td>
							<td style="text-align:left;">
								<select id="selItemMillingE">
									<option Value="0" selected="selected">None Selected</option>
								</select>
							</td>
							<td>
								&nbsp;
							</td>
							<td style="text-align:right;vertical-align:top;">
								NoPrint:&nbsp;
							</td>
							<td style="text-align:left;">
								<select id="selItemNoPrintE">
									<option Value="0" selected="selected">None Selected</option>
								</select>
							</td>
							<td>
								&nbsp;
							</td>
							<td style="text-align:right;vertical-align:top;">
								Price p/MBF:&nbsp;
							</td>
							<td style="text-align:left;">
								<input type="text" id="txtPriceE" style="text-align:right;width:100px;" value="0.00" />&nbsp;(Format:9,999.00)
							</td>
						</tr>
						<tr>
							<td style="text-align:right;vertical-align:top;">
								Comments:&nbsp;
							</td>
							<td style="text-align:left;" colspan="7">
								<input type="text" id="txtCommentPmE" style="width:600px;" />
							</td>
						</tr>
						</table>
					</td></tr></table>

					<div id="divProdItemEditFtr" style="width:100%;text-align:center;">
						<button id="btnSaveProdItemData" class="button blue-gradient glossy" onclick="javascript:SaveProdItemData();return false;" style="width:140px;">Save</button>&nbsp;
						<button id="btnCloseProdItemEdit" class="button blue-gradient glossy" onclick="javascript:CloseProdItemEdit();return false;" style="width:140px;">Close Edit Area</button>
					</div>
				</div>

				<div id="divGridFilters" style="width:99%;background-color:antiquewhite;margin-bottom:6px;">
					<table id="tblGVHdr" style="width:100%;border-spacing:0px;padding:1px;font-size:10pt;">
					<tr style="color:darkblue;font-weight:bold;">
						<td style="vertical-align:top;" rowspan="2">
							<label id="lblMainFilters" style="color:blue;font-weight:bold;">FILTERS:</label>
						</td>
						<td style="vertical-align:top;">
							<Label id="lblManagedF" >Managed</Label>
						</td>
						<td rowspan="2">
							&nbsp;
						</td>
						<td style="text-align:left;vertical-align:top;">
							Region:&nbsp;
						</td>
						<td rowspan="2">
							&nbsp;
						</td>
						<td style="text-align:left;vertical-align:top;">
							Specie:&nbsp;
						</td>
						<td rowspan="2">
							&nbsp;
						</td>
						<td style="text-align:left;vertical-align:top;">
							Grade:&nbsp;
						</td>
						<td rowspan="2">
							&nbsp;
						</td>
						<td style="text-align:left;vertical-align:top;">
							Thickness:&nbsp;
						</td>
						<td rowspan="2">
							&nbsp;
						</td>
						<td style="text-align:left;vertical-align:top;">
							Length:&nbsp;
						</td>
						<td rowspan="2">
							&nbsp;
						</td>
						<td style="text-align:left;vertical-align:top;">
							Color:&nbsp;
						</td>
						<td rowspan="2">
							&nbsp;
						</td>
						<td style="text-align:left;vertical-align:top;">
							Sort:&nbsp;
						</td>
						<td rowspan="2">
							&nbsp;
						</td>
						<td style="text-align:left;vertical-align:top;">
							Milling:&nbsp;
						</td>
						<td rowspan="2">
							&nbsp;
						</td>
						<td style="text-align:left;vertical-align:top;">
							NoPrint:&nbsp;
						</td>
						<td rowspan="2">
							&nbsp;
						</td>
						<td style="text-align:left;vertical-align:top;">
							Comment Text:&nbsp;
						</td>
						<td rowspan="2">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td style="vertical-align:top;">
							<input type="checkbox" id="chkManagedOnly" />
						</td>
						<td style="text-align:left;">
							<select ID="selRegionF">
								<option value="0" selected="selected">ALL</option>
								<option value="APP">Appalachian</option>
								<option value="GLA">Glacial</option>
								<option value="NORTH">North</option>
								<option value="WEST">West</option>
							</select>
						</td>
						<td style="text-align:left;">
							<select ID="selSpeciesF">
								<option value="0" selected="selected">ALL</option>
							</select>
						</td>
						<td style="text-align:left;">
							<select ID="selGradeF">
								<option value="0" selected="selected">ALL</option>
							</select>
						</td>
						<td style="text-align:left;">
							<select ID="selThicknessF">
								<option value="0" selected="selected">ALL</option>
							</select>
						</td>
						<td style="text-align:left;">
							<select ID="selLengthF">
								<option value="0" selected="selected">ALL</option>
							</select>
						</td>
						<td style="text-align:left;">
							<select ID="selColorF">
								<option value="0" selected="selected">ALL</option>
							</select>
						</td>
						<td style="text-align:left;">
							<select ID="selSortF">
								<option value="0" selected="selected">ALL</option>
							</select>
						</td>
						<td style="text-align:left;">
							<select ID="selMillingF">
								<option value="0" selected="selected">ALL</option>
							</select>
						</td>
						<td style="text-align:left;">
							<select ID="selNoPrintF">
								<option value="0" selected="selected">ALL</option>
							</select>
						</td>
						<td style="text-align:left;">
							<input type="text" id="txtCommentsF" />
						</td>
						<td>
							<button ID="btnRefreshDataGrid" onclick="javascript:RefreshDataGrid();return false;" class="button blue-gradient glossy" >Refresh Data</button>
						</td>
					</tr>
					</table>
				</div>

				<div id="divProductData" style="width:100%;">
 					<table style="padding:0px;border-spacing:0px;margin: auto auto;"><tr><td>
						<table id="tblProdItemList" style="padding:1px;border-spacing:0px;border-collapse:collapse;font-family:Arial narrow;margin:auto auto;">
						<thead id="tblProdItemHd">
						<tr>
							<th id="thProdItemCol100" class="TableHdrCell" style="width:50px;">ID</th>
							<th id="thProdItemCol101" class="TableHdrCell" style="width:42x;">Actv</th>
							<th id="thProdItemCol102" class="TableHdrCell" style="width:42px;">Mng</th>
							<th id="thProdItemCol103" class="TableHdrCell" style="width:70px;">Specie</th>
							<th id="thProdItemCol104" class="TableHdrCell" style="width:70px;">Thickness</th>
							<th id="thProdItemCol105" class="TableHdrCell" style="width:70px;">Grade</th>
							<th id="thProdItemCol106" class="TableHdrCell" style="width:70px;">Region</th>
							<th id="thProdItemCol107" class="TableHdrCell" style="width:60px;">Product</th>
							<th id="thProdItemCol108" class="TableHdrCell" style="width:336px;">Description</th>
							<th id="thProdItemCol109" class="TableHdrCell" style="width:80px;">Length</th>
							<th id="thProdItemCol110" class="TableHdrCell" style="width:80px;">Color</th>
							<th id="thProdItemCol111" class="TableHdrCell" style="width:80px;">Sort</th>
							<th id="thProdItemCol112" class="TableHdrCell" style="width:80px;">Milling</th>
							<th id="thProdItemCol113" class="TableHdrCell" style="width:80px;">NoPrint</th>
							<th id="thProdItemCol114" class="TableHdrCell" style="width:100px;">Price</th>
							<th id="thProdItemCol115" class="TableHdrCell" style="width:200px;">Comments</th>
							<th id="thProdItemCol116" class="TableHdrCell" style="width:126px;">Action</th>
						</tr>
						</thead>
						<tbody id="tbProdItemListBd">
						</tbody>
						</table>
					</td></tr></table>
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
							&nbsp;<label id="lblPageIDInFooter"></label>
							&nbsp;&nbsp;<span id="spnCurrDateNV" style="color:#A0A0A0;"">&nbsp;</span>&nbsp;&nbsp;Session Start:&nbsp;<span id="clockNV" style="color:#A0A0A0;">&nbsp;</span>&nbsp;
						</td>
					</tr>
					</table>
					</div>
			</footer>

		</div>
  </form>
</body>
</html>
