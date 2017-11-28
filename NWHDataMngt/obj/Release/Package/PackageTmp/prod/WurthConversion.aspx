<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WurthConversion.aspx.cs" Inherits="DataMngt.prod.WurthConversion" %>
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
		var jbFiltersVisible = true;
		var jbViewOnly = true;
		var jdivConvertDataEdit;
		var jdivMainFilterBlock;
		var jdToday = new Date();
		var jiAR = 0;
		var jiApprovalID = 0;
		var jiByID = 0;
		var jiForecastUser = 0;
		var jiNbrCols = 0;
		var jiNbrPages = 0;
		var jiNbrRows = 0;
		var jiPageID = 26;
		var jiPageNbr = 0;
		var jiPageSize = 20;
		var jiTotalRows = 0;
		var jiUserID = 0;
		var jlPageStatus;
		var jlStatusMsg;
		var jlWurthDataIDE;
		var jsBrowserType = '';
		var jsColorCode = '';
		var jsCurrentTime = '';
		var jselMActiveF;
		var jselMColorF;
		var jselMGradeF;
		var jselMMillingF;
		var jselMProdCodeF;
		var jselMProdTypeF;
		var jselMSortF;
		var jselMSpeciesF;
		var jselMThicknessF;
		var jselMWidthF;
		var jselPageSize;
		var jselWDActiveE;
		var jselWDColorE;
		var jselWDMillingE;
		var jselWDProdTypeE;
		var jselWDSortE;
		var jselWDWidthE;
		var jsErrorMsg = '';
		var jsLocationCode = '';
		var jsMillingCode = '';
		var jsPageVersion = '';
		var jsPageVersDate = '';
		var jsProdType = '';
		var jsProdCode = '';
		var jsRegionCode = '';
		var jsSortCode = '';
		var jsStartDate = '';
		var jsToday = '';
		var jsWidthCode = '';
		var jtblConvertData;
		var jtLTCustNbrE;
		var jtProdCodeE;
		var jtWDProdDescriptionE;
		var jtWurthCustCodeE;
		var jtWurthCustDescE;
		var jtWurthCustNbrE;
		var jtWurthItemNotesE;
		var jtXrefNbrE;

		var counter = 0;
		var DayNamesNV = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

		var MyCodeListData;
		var MyProdItemData;
		var MyProdTypeList;
		var MyProductList;
		var MyProductListMini;
		var MyReturn;
		var MyWurthData;

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

			jdivConvertDataEdit = document.getElementById('divConvertDataEdit');
			jdivMainFilterBlock = document.getElementById('divMainFilterBlock');
			jlPageStatus = document.getElementById('lblPageStatus');
			jlStatusMsg = document.getElementById('lblStatusMsg');
			jlWurthDataIDE = document.getElementById('lblWurthDataIDE');
			jselMActiveF = document.getElementById('selMActiveF');
			jselMColorF = document.getElementById('selMColorF');
			jselMGradeF = document.getElementById('selMGradeF');
			jselMMillingF = document.getElementById('selMMillingF');
			jselMProdCodeF = document.getElementById('selMProdCodeF');
			jselMProdTypeF = document.getElementById('selMProdTypeF');
			jselMSortF = document.getElementById('selMSortF');
			jselMSpeciesF = document.getElementById('selMSpeciesF');
			jselMThicknessF = document.getElementById('selMThicknessF');
			jselMWidthF = document.getElementById('selMWidthF');
			jselPageSize = document.getElementById('selPageSize');
			jselWDActiveE = document.getElementById('selWDActiveE');
			jselWDColorE = document.getElementById('selWDColorE');
			jselWDMillingE = document.getElementById('selWDMillingE');
			jselWDProdTypeE = document.getElementById('selWDProdTypeE');
			jselWDSortE = document.getElementById('selWDSortE');
			jselWDWidthE = document.getElementById('selWDWidthE');
			jtblConvertData = document.getElementById('tblConvertData');
			jtLTCustNbrE = document.getElementById('txtLTCustNbrE');
			jtProdCodeE = document.getElementById('txtProdCodeE');
			jtWDProdDescriptionE = document.getElementById('txtProdDescriptionE');
			jtWurthCustCodeE = document.getElementById('txtWurthCustCodeE');
			jtWurthCustDescE = document.getElementById('txtWurthCustDescE');
			jtWurthCustNbrE = document.getElementById('txtWurthCustNbrE');
			jtWurthItemNotesE = document.getElementById('txtWurthItemNotesE');
			jtXrefNbrE = document.getElementById('txtXrefNbrE');

			jsErrorMsg = jsgError;
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
			jiPageSize = 20;
			jiPgSizePj[0] = 20;
			jiPgNbrPj[0] = 0;
			jiNbrPagesPj[0] = 0;
			jiNbrPages = 0;
			jsRegionCode = '0';
			jsLocationCode = '0';
			//alert('Initiated');
			EstablishMainPgElementsPj(1, 0);

			//alert('prodtype');
			PopulateProdTypeList();
			//alert('color');
			PopulateColorList();
			//alert('milling');
			PopulateMillingList();
			//alert('sort');
			PopulateSortList();
			//alert('width');
			PopulateWidthList();
			PopulateGradeList();
			PopulateSpeciesList();
			PopulateThicknessList();
			//alert('done loading filters');
			RefreshWurthDataGrid();

			jlPageStatus.innerHTML = 'Page Ready';
			return false;
		}

		// **************************** AJAX FUNCTIONS *********************************

		function DataCall1() {
			jiPageNbr = jiPgNbrPj[0];
			LoadWurthDataPage();
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

		function GetProdCodeListSpecial(ctype, grp1, grp2, grp3, sort, act) {
			var url = "../shared/AjaxServices.asmx/SelectProductCodeListSpecial";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','CodeType':'" + ctype + "','Grp1':'" + grp1.toString() + "','Grp2':'" + grp2.toString() + "','Grp3':'" + grp3.toString() + "',";
			MyData = MyData + "'Sort':'" + sort.toString() + "','Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCodeListData = response; });
			return false;
		}	

		function GetProductItemData(pmid, plid, pt, pcode) {
			var url = "../shared/GridSupportServices.asmx/SelectProductItemData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','PMID':'" + pmid.toString() + "','PLID':'" + plid.toString() + "','ProdType':'" + pt + "','ProdCode':'" + pcode + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProdItemData = response; });
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

		function GetProductItemData(ptype, pcode, pmid) {
			var url = "../shared/AjaxServices.asmx/SelectProductItemDataWide";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ProdType':'" + ptype + "','ProdCode':'" + pcode + "','PMID':'" + pmid.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProdItemData = response; });
			return false;
		}

		function GetProductListMini() {
			var region = ''; // jselRegionMF.value;
			var loc = ''; // jselLocationMF.value;
			var url = "../shared/AjaxServices.asmx/GetForecastProductListMini";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','Loc':'" + loc + "','Region':'" + region + "','ProdCode':'','MixID':'0','Sort':'0','Active':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProductListMini = response; });
			return false;
		}

		function GetProdTypesList() {
			var url = "../shared/AjaxServices.asmx/SelectProductTypesList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ProdType':'','Sort':'0','Active':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProdTypeList = response; });
			return false;
		}

		function GetWurthProdConversionData(id, ptype, pcode, wdth, clr, fsort, milling, sort, act) {
			var spec = jselMSpeciesF.value;
			var grade = jselMGradeF.value;
			var thick = jselMThicknessF.value;
			var url = "../shared/AjaxServices.asmx/SelectWurthProdConversionData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ID':'" + id.toString() + "','PType':'" + ptype + "','ProdCode':'" + pcode + "','Thick':'" + thick + "','Specie':'" + spec + "','Grade':'" + grade + "',";
			MyData = MyData + "'Width':'" + wdth + "','Color':'" + clr + "','fSort':'" + fsort + "','Milling':'" + milling + "','Sort':'0','Active':'1','PgNbr':'" + jiPgNbrPj[0].toString() + "','PgSize':'" + jiPageSize.toString() + "',";
			MyData = MyData + "'ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyWurthData = response; });
			return false;
		}		

		function GetWurthProdCodeList(ptype) {
			var url = "../shared/AjaxServices.asmx/SelectWurthProductCodeList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','PType':'" + ptype + "','Sort':'0','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProductListMini = response; });
		}

		//       UpdateWurthDataItem(0, id, pcode, ptype, desc, wdth, len, clr, milling, sort, nprint, act, xref, custcode, custnbr, custdesc, cmt, prgid, tol, ppkg, rsp, cert)
		function UpdateWurthDataItem(typ, id, pcode, ptype, desc, wdth, len, clr, milling, sort, nprint, act, xref, custcode, custnbr, wurthcode, custdesc, cmt, prgid, tol, ppkg, rsp, cert) {
			var url = "../shared/AjaxServices.asmx/UpdateWurthConversionData";
			if (IsContentsNullUndefinedGu(clr)) { clr = '';}
			if (IsContentsNullUndefinedGu(wdth)) { wdth = ''; }
			if (IsContentsNullUndefinedGu(wdth)) { len = ''; }
			if (IsContentsNullUndefinedGu(wdth)) { prgid = ''; }
			if (IsContentsNullUndefinedGu(wdth)) { cert = ''; }
			//alert('A');
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ID':'" + id.toString() + "','Xrefnbr':'" + xref + "','Cust':'" + custcode + "','CustNbr':'" + custnbr + "','CustDesc':'" + custdesc + "',";
			MyData = MyData + "'WurthCode':'" + wurthcode + "','PType':'" + ptype + "','ProdCode':'" + pcode + "','Desc':'" + desc + "','Width':'" + wdth + "','Len':'" + len + "','Color':'" + clr + "','ExpPrgID':'" + prgid + "','Cert':'" + cert + "',";
			MyData = MyData + "'Sort':'" + sort + "','Tolerance':'" + tol + "','HPPcsPkg':'" + ppkg + "','Milling':'" + milling + "','NoPrint':'" + nprint + "','Resp':'" + rsp + "','Cmt':'" + cmt + "',";
			MyData = MyData + "'iType':'" + typ.toString() + "','Active':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			return false;
		}	

		// **************************** Populate *********************************

		function PopulateColorList() {
			GetProdCodeList('Color');
			if (!IsContentsNullUndefinedGu(MyCodeListData)) {
				// filter
				ClearDDLOptionsGu('selMColorF', 1);
				fillDropDownListGu(MyCodeListData, jselMColorF, 0, 'CodeDescription', 'CatCode');
				// edit
				ClearDDLOptionsGu('selWDColorE', 1);
				fillDropDownListGu(MyCodeListData, jselWDColorE, 0, 'CodeDescription', 'CatCode');
			}
			return false;
		}

		function PopulateGradeList() {
			GetProdCodeList('Grade');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				//alert('Grade - ' + MyCodeListData.length);
				ClearDDLOptionsGu('selMGradeF', 1);
				fillDropDownListGu(MyCodeListData, jselMGradeF, 0, 'CodeDescAbbreviated', 'CatCode');
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

		function PopulateMillingList() {
			GetProdCodeList('Milling');
			if (!IsContentsNullUndefinedGu(MyCodeListData)) {
				// filter
				ClearDDLOptionsGu('selMMillingF', 1);
				fillDropDownListGu(MyCodeListData, jselMMillingF, 0, 'CodeDescAbbreviated', 'CatCode');
				// edit
				ClearDDLOptionsGu('selWDMillingE', 1);
				fillDropDownListGu(MyCodeListData, jselWDMillingE, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateProdTypeList() {
			GetProdTypesList();
			if (MyProdTypeList !== undefined && MyProdTypeList !== null) {
				// filter
				ClearDDLOptionsGu('selMProdTypeF', 1);
				fillDropDownListGu(MyProdTypeList, jselMProdTypeF, 0, 'ProductTypeDesc', 'ProductType');
				// edit
				ClearDDLOptionsGu('selWDProdTypeE', 1);
				fillDropDownListGu(MyProdTypeList, jselWDProdTypeE, 0, 'ProductTypeDesc', 'ProductType');
			}
			return false;
		}

		function PopulateSortList() {
			GetProdCodeList('Sort');
			if (!IsContentsNullUndefinedGu(MyCodeListData)) {
				// filter
				ClearDDLOptionsGu('selMSortF', 1);
				fillDropDownListGu(MyCodeListData, jselMSortF, 0, 'CodeDescAbbreviated', 'CatCode');
				// edit
				ClearDDLOptionsGu('selWDSortE', 1);
				fillDropDownListGu(MyCodeListData, jselWDSortE, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateSpeciesList() {
			GetProdCodeList('Species');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selMSpeciesF', 1);
				fillDropDownListGu(MyCodeListData, jselMSpeciesF, 0, 'CodeDescAbbreviated', 'CatCode');
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

		function PopulateThicknessList() {
			GetProdCodeList('Thickness');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selMThicknessF', 1);
				fillDropDownListGu(MyCodeListData, jselMThicknessF, 0, 'CodeDescAbbreviated', 'CatCode');
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

		function PopulateWidthList() {
			//GetProdCodeList('Width');
			GetProdCodeListSpecial('Width', 0, 0, 1, 0, 1);
			if (!IsContentsNullUndefinedGu(MyCodeListData)) {
			 //filter
				ClearDDLOptionsGu('selMWidthF', 1);
				fillDropDownListGu(MyCodeListData, jselMWidthF, 0, 'CodeDescAbbreviated', 'CatCode');
			 //edit
				ClearDDLOptionsGu('selWDWidthE', 1);
				fillDropDownListGu(MyCodeListData, jselWDWidthE, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateWurthDataList() {
			//alert('Filling Proc List');
			var bdy = document.createElement("tbody");
			var cellClass = 'StdTableCell';
			var nCol = 14;
			// Cols: 0-ID, 1-XRefNbr, 2-PT, 3-ProdCode, 4-Desc, 5-Width, 6-Color, 7-Sort, 8-Milling, 9-Notes, 10-CustCode, 11-CustNbr, 13-Action
			//alert('arrays');
			var cWidth = [52, 106, 90, 38, 52, 320, 82, 82, 82, 82, 220, 70, 62, 70, 86, 0, 0, 0];
			var corientH = ['center', 'left', 'left', 'center', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'center', 'center', 'center', 'center', '', '', ''];
			var corientV = ['top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', '', ''];
			var cbrdrL = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', ''];
			var cbrdrR = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', ''];
			var cbrdrT = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', ''];
			var cbrdrB = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', ''];
			var cnames = ['TransRowID', 'ProductXRefs', 'WurthCode', 'ProdType', 'ProductCode', 'ProdDescription', 'Width', 'Color', 'Sort', 'Milling', 'Comments', 'CustCode', 'CustomerNbr', 'ACTION', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var aggType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var shown = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
			//alert('DDL list data');
			//EmptyDDLListsDg();
			//alert('1');
			//jsDGColDDLOpts[3][0] = '0|None';
			//jsDGColDDLOpts[3][1] = '1|Maintenance';
			//jsDGColDDLOpts[3][2] = '2|Event';
			//jsDGColDDLOpts[3][3] = '3|ErrorHandle';
			//jsDGColDDLOpts[3][4] = '4|Transaction';
			//jsDGColDDLOpts[3][5] = '5|Check';
			//jsDGColDDLOpts[7][0] = '0|Anytime';
			//jsDGColDDLOpts[7][1] = '1|Same Day';
			//jsDGColDDLOpts[7][2] = '2|Same Week';
			//jsDGColDDLOpts[7][3] = '3|Same Hour';
			//jsDGColDDLOpts[7][4] = '9|None';
			//jsDGColDDLOpts[8][0] = '0|Job';
			//jsDGColDDLOpts[8][1] = '1|SP';
			//jsDGColDDLOpts[8][2] = '3|SQL';
			//jsDGColDDLOpts[8][3] = '4|Other';
			//jsDGColDDLOpts[10][0] = '0|No';
			//jsDGColDDLOpts[10][1] = '1|Yes';

			if (!IsContentsNullUndefinedTx(MyWurthData)) {
				//alert('Proc List Len: ' + MyProcessList.length);
				bdy = FormDataGridBodyMinimumDg(1, nCol, 'tdWurthList', cellClass, true, true, false, false, '', 'button blue-gradient glossy', false, 0, MyWurthData, 'TransRowID', cnames, cType, cWidth, corientH, corientV, cbrdrL, cbrdrR, cbrdrT, cbrdrB, aggType, shown, true, true);
				//alert('Grid done');
				jtblConvertData.style.display = 'block';
			}
			else {
				alert('Proc List bad data');
				ShowStatusMsg('An unidentified error occurred. No records could be extracted.');
			}
			//alert('Attaching body');
			try {
				var oldBody = jtblConvertData.getElementsByTagName("tbody")[0];
				jtblConvertData.replaceChild(bdy, oldBody);
			}
			catch (ex) {
				// nothing
			}
			joPgNbrLblPj.innerHTML = (jiPgNbrPj[0] + 1).toString();
			joMaxPgNbrLblPj.innerHTML = jiNbrPagesPj[0].toString();

			return false;
		}

		// **************************** Dialog Boxes *********************************

		function DeleteOneRec(id, row, objid) {
			switch (objid) {
				case 1:
					if (confirm('This will permanently remove this Wurth data item. Continue? (Y/N)')) {
						UpdateWurthDataItem(3, id, '', '', '', '', '', '', '', '', '', 0, '', '', '', '', '', '', '', '', '', '');
					}
					break;
				default:
					break;
			}
			return false;
		}

		function DialogAction1(dChoice, Src) {
			switch (Src) {
				case 3:
					break;
				default:
					break;
			}
			return false;
		}

		function EditOneRec(id, row, objid) {
			//alert('Fired!');
			var val = '';
			switch (objid) {
				case 1:
					//alert('1');
					jselWDActiveE.value = MyWurthData[row]['IsActive'].toString();
					val = MyWurthData[row]['Color'].toString();
					if (val === '') { val = '0';}
					jselWDColorE.value = val;
					//alert('2');
					val = MyWurthData[row]['Milling'].toString();
					if (val === '') { val = '0'; }
					jselWDMillingE.value = val;
					val = MyWurthData[row]['ProductCode'].toString();
					if (val === '') { val = '0'; }
					jtProdCodeE.value = val;
					val = MyWurthData[row]['ProdDescription'].toString();
					jtWDProdDescriptionE.value = val;
					val = MyWurthData[row]['ProdType'].toString();
					if (val === '') { val = '0'; }
					//alert(val);
					jselWDProdTypeE.value = val;
					//alert('3');
					val = MyWurthData[row]['Sort'].toString();
					//alert(val);
					if (val === '') { val = '0'; }
					jselWDSortE.value = val;
					jselWDWidthE.value = MyWurthData[row]['Width'].toString();
					//alert('4');
					jlWurthDataIDE.innerHTML = MyWurthData[row]['TransRowID'].toString();
					jtXrefNbrE.value = MyWurthData[row]['ProductXRefs'].toString();
					//alert('5');
					jtWurthCustCodeE.value = MyWurthData[row]['WurthCode'].toString();
					//alert('5a');
					jtLTCustNbrE.value = MyWurthData[row]['CustCode'].toString();
					//alert('5b');
					jtWurthCustNbrE.value = MyWurthData[row]['CustomerNbr'].toString();
					//alert('6');
					jtWurthItemNotesE.value = MyWurthData[row]['Comments'].toString();
					jtWurthCustDescE.value = MyWurthData[row]['CustomerDescription'].toString();
					jbFiltersVisible = false;
					jdivMainFilterBlock.style.display = 'none';
					jdivConvertDataEdit.style.display = 'block';
					break;
				default:
					break;
			}
			return false;
		}

		// **************************** UI *********************************

		function ChangePageSize(val) {
			//alert('1');
			jiPageSize = parseInt(val, 10);
			//alert('2');
			jiPgSizePj[0] = jiPageSize;
			//alert('3');
			RefreshWurthDataGrid();
			return false;
		}

		function CloseWurthDataItemEdit() {
			jdivMainFilterBlock.style.display = 'block';
			jdivConvertDataEdit.style.display = 'none';
			return false;
		}

		function OpenAddNewWurthData() {
			jlWurthDataIDE.innerHTML = '0';
			jtProdCodeE.value = '';
			jtXrefNbrE.value = '';
			jtWurthCustCodeE.value = '';
			jtWurthCustNbrE.value = '';
			jtWurthItemNotesE.value = '';
			jselWDActiveE.value = '0';
			jselWDColorE.value = '0';
			jselWDMillingE.value = '0';
			jtWDProdDescriptionE.value = '';
			jselWDProdTypeE.value = 'HD';
			jselWDSortE.value = '0';
			jselWDWidthE.value = '0';
			jtWurthCustDescE.value = '';
			jtLTCustNbrE.value = '';
			jbFiltersVisible = false;
			jdivMainFilterBlock.style.display = 'none';
			jdivConvertDataEdit.style.display = 'block';
			return false;
		}

		function LoadWurthDataPage() {
			GetWurthProdConversionData(0, jsProdType, jsProdCode, jsWidthCode, jsColorCode, jsSortCode, jsMillingCode, 0, 1);
			//alert('Data loaded - ' + MyWurthData.length);
			PopulateWurthDataList();
			return false;
		}

		function RefreshWurthDataGrid() {
			jiPgNbrPj[0] = 0;
			jiPageNbr = jiPgNbrPj[0];
			jsProdType = jselMProdTypeF.value;
			jsProdCode = jselMProdCodeF.value;
			jsWidthCode =  jselMWidthF.value;
			jsColorCode = jselMColorF.value;
			jsSortCode = jselMSortF.value;
			jsMillingCode = jselMMillingF.value;
			GetWurthProdConversionData(0, jsProdType, jsProdCode, jsWidthCode, jsColorCode, jsSortCode, jsMillingCode, 0, 1);
			//alert('Data loaded - ' + MyWurthData.length);
			PopulateWurthDataList();
			return false;
		}

		function SaveWurthDataItem() {
			//alert('saving');
			var act = parseInt(jselWDActiveE.value, 10);
			var clr = jselWDColorE.value.replace('{EMPTY}', '');
			//alert('1');
			var milling = jselWDMillingE.value.replace('{EMPTY}', '');
			var pcode = jtProdCodeE.value;
			//alert('2');
			var ptype = jselWDProdTypeE.value.replace('{EMPTY}', '0');
			var sort = jselWDSortE.value.replace('{EMPTY}', '');
			//alert('3');
			var wdth = jselWDWidthE.value.replace('{EMPTY}', '');
			var id = parseInt(document.getElementById('lblWurthDataIDE').innerHTML, 10);
			//alert('4');
			var xref = CleanTextMinimalTx(document.getElementById('txtXrefNbrE').value, 1);
			var wurthcode = StripSingleQuotesTx(jtWurthCustCodeE.value);	// Item Nbr-Wurth Code
			//alert('5');
			var custnbr = CleanTextMinimalTx(jtWurthCustNbrE.value, 1); // 4-digit Wurth Customer
			var custcode = CleanTextMinimalTx(jtLTCustNbrE.value, 1);	// LT customer code
			var cmt = StripSingleQuotesTx(jtWurthItemNotesE.value);
			//alert('6');
			var desc = jtWDProdDescriptionE.value;
			var cdesc = jtWurthCustDescE.value.replace(/\'/g, '`');
			var len = '';
			var nprint = '';
			var prgid = '';
			var tol = '';
			var ppkg = '';
			var rsp = '';
			var cert = '';
			//alert('calling save function');
			//                                                                                         xref  lt cust   4-digit  
			UpdateWurthDataItem(0, id, pcode, ptype, desc, wdth, len, clr, milling, sort, nprint, act, xref, custcode, custnbr, wurthcode, cdesc, cmt, prgid, tol, ppkg, rsp, cert);
			// match is made only on prodtype, prodcode, width, color, sort, milling
			jdivMainFilterBlock.style.display = 'block';
			jdivConvertDataEdit.style.display = 'none';
			DataCall1();
			return false;
		}

		function SetProductCodeE(val) {
			//alert('fired!');
			var pt = jselWDProdTypeE.value;
			if (!IsContentsNullUndefEmptyGu(val) && !IsContentsNullUndefEmptyGu(pt)) {
				//alert('ready to get data');
				GetProductItemData(pt, val, 0);
				if (!IsContentsNullUndefEmptyGu(MyProdItemData)) {
					//alert('got data');
					jtWDProdDescriptionE.value = MyProdItemData[0]['ProdDesc'].toString();
				}
			}
			return false;
		}
		function ToggleFilterVisibility() {
			if (jbFiltersVisible === true) {
				jbFiltersVisible = false;
				jdivMainFilterBlock.style.display = 'none';
			}
			else {
				jbFiltersVisible = true;
				jdivMainFilterBlock.style.display = 'block';
			}
			return false;
		}

	</script>
		
</head>
<body>
	<img id="imgSessionKeepAlive" width="1" height="1" style="display:none;" src="../Images/clearpixel.gif" />
  <form id="form1" runat="server">
  <asp:ScriptManager runat="server"></asp:ScriptManager>
	<asp:HiddenField ID="hfPageID" runat="server" Value="26" />

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

				<div id="divPAGEMainHDR" style="width:100%;">
					<table style="width:100%;padding:1px;border-spacing:0px">
					<tr>
						<td style="width:50%;">
							<label id="lblWurthConvertDataHdr" style="color:blue;font-size:14pt;font-weight:bold;">Wurth Conversion Data</label>:
						</td>
						<td style="width:50%;text-align:right:">
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
							</span>
							<button id="btnToggleFilterVisibility" class="button blue-gradient glossy" onclick="javascript:ToggleFilterVisibility();return false;">Hide Filters</button>&nbsp;&nbsp;
							<button id="btnAddNewWurthItem" class="button blue-gradient glossy" onclick="javascript:OpenAddNewWurthData();return false;">Add New Wurth Item</button>&nbsp;&nbsp;&nbsp;
							<label id="lblPageStatus" style="position:absolute;font-size:10pt;font-weight:bold;color:darkgray;right:70px;">Page Loading...</label>&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
					</table>
					
					<div id="divMainFilterBlock" style="width:100%;background-color:blanchedalmond;padding:2px;text-align:center;">
						<table style="padding:1px;border-spacing:0px;margin: auto auto;">
						<tr>
							<td colspan="10" style="font-weight:bold;color:darkblue;">Data&nbsp;Filters:&nbsp;</td>
						</tr>
						<tr>
							<td style="text-align:right;">
								Prod Type:&nbsp;
							</td>
							<td style="text-align:left;">
								<select id="selMProdTypeF">
									<option value="0" selected="selected">ALL</option>
								</select>
							</td>
							<td>&nbsp;</td>
							<td style="text-align:right;">
								Product:&nbsp;
							</td>
							<td style="text-align:left;">
								<select id="selMProdCodeF">
									<option value="0" selected="selected">ALL</option>
								</select>
							</td>
							<td>&nbsp;</td>
							<td style="text-align:right;">
								Thickness:&nbsp;
							</td>
							<td style="text-align:left;" >
								<select id="selMThicknessF">
									<option value="0" selected="selected">ALL</option>
								</select>
							</td>
							<td>&nbsp;</td>
							<td style="text-align:right;">
								Species:&nbsp;
							</td>
							<td style="text-align:left;">
								<select id="selMSpeciesF">
									<option value="0" selected="selected">ALL</option>
								</select>
							</td>
							<td>&nbsp;</td>
							<td style="text-align:right;">
								Grade:&nbsp;
							</td>
							<td style="text-align:left;">
								<select id="selMGradeF">
									<option value="0" selected="selected">ALL</option>
								</select>
							</td>
						</tr>
						<tr>
							<td style="text-align:right;">
								Width:&nbsp;
							</td>
							<td style="text-align:left;">
								<select id="selMWidthF">
									<option value="0" selected="selected">ALL</option>
								</select>
							</td>
							<td>&nbsp;</td>
							<td style="text-align:right;">
								Color:&nbsp;
							</td>
							<td style="text-align:left;">
								<select id="selMColorF">
									<option value="0" selected="selected">ALL</option>
								</select>
							</td>
							<td>&nbsp;</td>
							<td style="text-align:right;">
								Sort:&nbsp;
							</td>
							<td style="text-align:left;">
								<select id="selMSortF">
									<option value="0" selected="selected">ALL</option>
								</select>
							</td>
							<td>&nbsp;</td>
							<td style="text-align:right;">
								Milling:&nbsp;
							</td>
							<td style="text-align:left;">
								<select id="selMMillingF">
									<option value="0" selected="selected">ALL</option>
								</select>
							</td>
							<td>&nbsp;</td>
							<td style="text-align:right;">
								Active:&nbsp;
							</td>
							<td style="text-align:left;" colspan="4">
								<select id="selMActiveF">
									<option value="1" selected="selected">Yes</option>
									<option value="0">No</option>
								</select>
							</td>
						</tr>
						<tr>
							<td colspan="13" style="text-align:center;">
								<div id="divFilterButtonBar" style="width:100%;text-align:center;margin-top:6px;margin-bottom:6px;">
									<button id="btnRefreshWurthGrid" class="button blue-gradient glossy" onclick="javascript:RefreshWurthDataGrid();return false;">Refresh Data Grid</button>
								</div>
							</td>
						</tr>
						</table>
					</div>

				</div>

				<div id="divPAGEMainCONTENT" style="width:100%;margin-top:10px;margin-bottom:6px;text-align:center;">
					<div id="divConvertDataEdit" style="width:100%;display:none;text-align:center;background-color:blanchedalmond;margin-bottom:10px;padding-bottom:4px;">
						<label id="lblEditWurthDataHdr"	style="color:blue;font-weight:bold;font-size:14pt;">Edit Wurth Data</label>:<br />
						<table id="tblWurthDataEdit" style="padding:1px;border-spacing:0px;margin: auto auto;">
						<tr>
							<td style="text-align:right;">
								ID:&nbsp;
							</td>
							<td style="text-align:left;">
								<label id="lblWurthDataIDE" style="font-weight:bold;color:blue;"></label>
							</td>
							<td>&nbsp;</td>
							<td style="text-align:right;">
								&nbsp;
							</td>
							<td style="text-align:left;" colspan="3">
								&nbsp;
							</td>
							<td>&nbsp;</td>
							<td style="text-align:right;">
								Active:&nbsp;
							</td>
							<td style="text-align:left;">
								<select id="selWDActiveE">
									<option value="1" selected="selected">Yes</option>
									<option value="0">No</option>
								</select>
							</td>
						</tr>
						<tr><td colspan="10" style="background-color:cadetblue;text-align:center;color:white;">Product Identification</td></tr>
						<tr>
							<td style="text-align:right;">
								Prod&nbsp;Type:&nbsp;
							</td>
							<td style="text-align:left;">
								<select id="selWDProdTypeE">
									<option value="0" selected="selected">ALL</option>
								</select>
							</td>
							<td>&nbsp;</td>
							<td style="text-align:right;">
								Product:&nbsp;
							</td>
							<td style="text-align:left;" colspan="3">
								<input type="text" id="txtProdCodeE" style="width:70px;" onchange="javascript:SetProductCodeE(this.value);return false;" />&nbsp;
								<input type="text" id="txtProdDescriptionE" style="width:320px;" readonly="readonly" />
							</td>
							<td>&nbsp;</td>
							<td style="text-align:right;">
								Width:&nbsp;
							</td>
							<td style="text-align:left;">
								<select id="selWDWidthE">
									<option value="0" selected="selected">ALL</option>
									<option value="">{BLANK}</option>
									<option value="8&W">8&W</option>
									<option value="10&W">10&W</option>
								</select>
							</td>
						</tr>
						<tr>
							<td style="text-align:right;">
								Color:&nbsp;
							</td>
							<td style="text-align:left;">
								<select id="selWDColorE">
									<option value="0" selected="selected">ALL</option>
								</select>
							</td>
							<td>&nbsp;</td>
							<td style="text-align:right;">
								Sort:&nbsp;
							</td>
							<td style="text-align:left;" colspan="3">
								<select id="selWDSortE">
									<option value="0" selected="selected">ALL</option>
								</select>
							</td>
							<td>&nbsp;</td>
							<td style="text-align:right;">
								Milling:&nbsp;
							</td>
							<td style="text-align:left;">
								<select id="selWDMillingE">
									<option value="0" selected="selected">ALL</option>
								</select>
							</td>
						</tr>
						<tr><td colspan="10" style="background-color:cadetblue;text-align:center;color:white;">Wurth Identification</td></tr>
						<tr>
							<td style="text-align:right;">
								XRef&nbsp;Nbr:&nbsp;
							</td>
							<td style="text-align:left;">
								<input type="text" id="txtXrefNbrE" style="width:130px;" value="" />
							</td>
							<td>&nbsp;</td>
							<td style="text-align:right;">
								Item&nbsp;Code:&nbsp;
							</td>
							<td style="text-align:left;">
								<input type="text" id="txtWurthCustCodeE" style="width:100px;" />
							</td>
							<td style="text-align:right;">
								&nbsp;Cust&nbsp;Desc:&nbsp;
							</td>
							<td style="text-align:left;">
								<input type="text" id="txtWurthCustDescE" style="width:300px;" />
							</td>
							<td>&nbsp;</td>
							<td style="text-align:right;">
								Cust:&nbsp;
							</td>
							<td style="text-align:left;">
								<input type="text" id="txtWurthCustNbrE" style="width:60px;" />-<input type="text" id="txtLTCustNbrE" style="width:100px;" />
							</td>
						</tr>
						<tr><td colspan="10" style="background-color:cadetblue;text-align:center;color:white;">Other</td></tr>
						<tr>
							<td style="text-align:right;">
								Comments:&nbsp;
							</td>
							<td colspan="9" style="text-align:left;">
								<input type="text" id="txtWurthItemNotesE" style="width:600px;" />
							</td>
						</tr>
						<tr>
							<td colspan="10" style="text-align:center;">
								<button id="btnSaveWurthItem" class="button blue-gradient glossy" onclick="javascript:SaveWurthDataItem();return false;">Save Data</button>
								<button id="btnCloseWurthItemEdit" class="button blue-gradient glossy" onclick="javascript:CloseWurthDataItemEdit();return false;">Close Edit</button>
						  </td>
						</tr>
						</table>
					</div>

					<div id="divConvertDataTable" style="width:100%;text-align:center;">
						<table style="margin: auto auto;"><tr><td>
							<table id="tblConvertData" style="padding:1px;border-spacing:0px;margin: auto auto;">
							<thead>
							<tr>
								<th class="TableHdrCell" style="width:52px;">ID</th>
								<th class="TableHdrCell" style="width:106px;">XRef Nbr</th>
								<th class="TableHdrCell" style="width:90px;">Item Nbr</th>
								<th class="TableHdrCell" style="width:38px;">P/T</th>
								<th class="TableHdrCell" style="width:52px;">Prod</th>
								<th class="TableHdrCell" style="width:320px;">Product Description</th>
								<th class="TableHdrCell" style="width:82px;">Width</th>
								<th class="TableHdrCell" style="width:82px;">Color</th>
								<th class="TableHdrCell" style="width:82px;">Sort</th>
								<th class="TableHdrCell" style="width:82px;">Milling</th>
								<th class="TableHdrCell" style="width:220px;">Notes/Comments</th>
								<th class="TableHdrCell" style="width:70px;">Cust Code</th>
								<th class="TableHdrCell" style="width:62px;">Cust Nbr</th>
								<th class="TableHdrCell" style="width:86px;">Action</th>
							</tr>
							</thead>
							<tbody>

							</tbody>
							</table>
						</td></tr></table>
					</div>

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
