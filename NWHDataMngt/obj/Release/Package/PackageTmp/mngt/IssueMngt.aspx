<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IssueMngt.aspx.cs" Inherits="DataMngt.mngt.IssueMngt1" %>
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
		var jbViewOnly = true;
		var jdivIssueMngtContentEdit;
		var jdivIssueMngtFilters;
		var jdToday = new Date();
		var jiAR = 0;
		var jiApprovalID = 0;
		var jiByID = 0;
		var jiForecastUser = 0;
		var jiNbrCols = 0;
		var jiNbrPages = 0;
		var jiNbrRows = 0;
		var jiPageID = 46;
		var jiPageNbr = 0;
		var jiPageSize = 20;
		var jiTotalRows = 0;
		var jiUserID = 0;
		var jlIssueIDE;
		var jlSignOffDateE;
		var jlPageStatus;
		var jlStatusMsg;
		var jsBrowserType = '';
		var jsCurrentTime = '';
		var jselAppAreaE;
		var jselAppAreaF;
		var jselAppForIssueE;
		var jselDesignElementE;
		var jselDesignElementF;
		var jselIssueActiveE;
		var jselIssueClassE;
		var jselIssueClassF;
		var jselIssueTypeE
		var jselIssueTypeF;
		var jselSignoffByIDE;
		var jsErrorMsg = '';
		var jsLocationCode = '';
		var jsPageVersion = '';
		var jsPageVersDate = '';
		var jsRegionCode = '';
		var jsStartDate = '';
		var jsToday = '';
		var jtBeginDateF;
		var jtblIssueMngtContent;
		var jtEndDateF;
		var jtIssueDescriptionE;
		var jtIssueSignoffE;
		var jtIssueTitleE;
		var jtOtherInfoE;
		var jtPersonNameF;

		var counter = 0;
		var DayNamesNV = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

		var MyAppAreaList;
		var MyApplicationList;
		var MyDesignCompList;
		var MyIssueClassList;
		var MyIssueList;
		var MyIssueTypeList;
		var MyQueryData;
		var MyQueryList;
		var MyReturn;

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
			//alert('loaded seed values');

			jdivIssueMngtContentEdit = document.getElementById('divIssueMngtContentEdit');
			jdivIssueMngtFilters = document.getElementById('divIssueMngtFilters');
			jlIssueIDE = document.getElementById('lblIssueIDE');
			jlPageStatus = document.getElementById('lblPageStatus');
			jlSignOffDateE = document.getElementById('lblSignOffDateE');
			jlStatusMsg = document.getElementById('lblStatusMsg');
			jselAppAreaE = document.getElementById('selAppAreaE');
			jselAppAreaF = document.getElementById('selAppAreaF');
			jselAppForIssueE = document.getElementById('selAppForIssueE');
			jselDesignElementE = document.getElementById('selDesignElementE')
			jselDesignElementF = document.getElementById('selDesignElementF');
			jselIssueActiveE = document.getElementById('selIssueActiveE');
			jselIssueClassE = document.getElementById('selIssueClassE');
			jselIssueClassF = document.getElementById('selIssueClassF');
			jselIssueTypeE = document.getElementById('selIssueTypeE');
			jselIssueTypeF = document.getElementById('selIssueTypeF');
			jselSignoffByIDE = document.getElementById('selSignoffByIDE');
			jtBeginDateF = document.getElementById('txtBeginDateF');
			jtblIssueMngtContent = document.getElementById('tblIssueMngtContent');
			jtEndDateF = document.getElementById('txtEndDateF');
			jtIssueDescriptionE = document.getElementById('txaIssueDescriptionE');
			jtIssueSignoffE = document.getElementById('txaIssueSignoffE');
			jtIssueTitleE = document.getElementById('txtIssueTitleE');
			jtOtherInfoE = document.getElementById('txtOtherInfoE');
			jtPersonNameF = document.getElementById('txtPersonNameF');

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
			if (jbA === true) {
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
			PopulateApplicationList();
			PopulateIssuesClassList();
			PopulateIssuesTypeList();
			PopulateDesignComponentList();
			PopulateAppAreaList();
			EstablishMainPgElementsPj(1, 0);
			jselIssueClassF.value = '0';
			jselIssueTypeF.value = '0';
			jselDesignElementF.value = '0';
			jlPageStatus.innerHTML = 'Page Ready';
			return false;
		}

		// **************************** AJAX FUNCTIONS *********************************

		function DataCall1() {
			jiPageNbr = jiPgNbrPj[0];
			LoadIssuesList();
			return false;
		}

		function GetAppAreaList(id, acode, aarea) {
			var url = "../shared/AdminServices.asmx/SelectAppAreaList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ID':'" + id.toString() + "','AppCode':'" + acode + "','AreaCode':'" + aarea + "','Sort':'0','Active':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyAppAreaList = response; });
			return false;
		}

		function GetApplicationList() {
			var url = "../shared/AdminServices.asmx/SelectApplicationList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ID':'0','Sort':'0','Current':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyApplicationList = response; });
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

		function GetIssuesList(id, cls, typ, aarea, dcomp, bdt, edt, bypers) {
			//alert('FiredGetIssues');				//
			var url = "../shared/AdminServices.asmx/SelectIssuesList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ID':'" + id.toString() + "','Class':'" + cls.toString() + "','iType':'" + typ.toString() + "','AppArea':'" + aarea.toString() + "',";
			//alert('1');
			MyData = MyData + "'DesignComp':'" + dcomp.toString() + "','bdt':'" + bdt + "','edt':'" + edt + "','ByPers':'" + bypers + "','Sort':'0','Active':'1','PgNbr':'" + jiPgNbrPj[0].toString() + "',";
			//alert('2');
			MyData = MyData + "'PgSize':'" + jiPageSize.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyIssueList = response; });
			return false;
		}			

		function GetIssuesClassList() {
			var url = "../shared/AdminServices.asmx/SelectIssueClassList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','Sort':'0','Active':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyIssueClassList = response; });
			return false;
		}

		function GetIssuesTypeList() {
			var url = "../shared/AdminServices.asmx/SelectIssueTypeList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','Sort':'0','Active':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyIssueTypeList = response; });
			return false;
		}

		function GetDesignComponentList() {
			var url = "../shared/AdminServices.asmx/SelectDesignComponentList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','Sort':'0','Active':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyDesignCompList = response; });
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

		function UpdateSignOffText(id, so) {



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

		function UpdateUserRightLevel(id, val) {
			var url = "../shared/AjaxServices.asmx/UpdateColumnSetting";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'3','ID':'" + id.toString() + "','UserID':'0','GroupCode':'','RightLevel':'" + val + "','PageID':'" + jiPageID.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			return false;
		}

		// **************************** Populate *********************************

		function PopulateAppAreaList() {
			GetAppAreaList(0, '', '');
			if (MyAppAreaList !== undefined && MyAppAreaList !== null) {
				// load edit
				ClearDDLOptionsGu('selAppAreaE', 1);
				fillDropDownListGu(MyAppAreaList, jselAppAreaE, 0, 'AppAreaName', 'AppAreaID');
				// load filter
				ClearDDLOptionsGu('selAppAreaF', 1);
				fillDropDownListGu(MyAppAreaList, jselAppAreaF, 0, 'AppAreaName', 'AppAreaID');
			}
			return false;
		}

		function PopulateApplicationList() {
			GetApplicationList();
			if (MyApplicationList !== undefined && MyApplicationList !== null) {
				// load edit
				ClearDDLOptionsGu('selAppAreaE', 1);
				fillDropDownListGu(MyApplicationList, jselAppForIssueE, 0, 'AppName', 'ApplicationID');
			}
		}
		
		function PopulateDesignComponentList() {
			GetDesignComponentList();
			//alert(MyProductListMini.length);
			if (MyDesignCompList !== undefined && MyDesignCompList !== null) {
				// load edit
				ClearDDLOptionsGu('selDesignElementE', 1);
				fillDropDownListGu(MyDesignCompList, jselDesignElementE, 0, 'DesignComponent', 'DesignComponentID');
				// load filter
				ClearDDLOptionsGu('selDesignElementF', 1);
				fillDropDownListGu(MyDesignCompList, jselDesignElementF, 0, 'DesignComponent', 'DesignComponentID');
			}
			return false;
		}

		function PopulateIssuesClassList() {
			GetIssuesClassList();
			//alert(MyIssueClassList.length);
			if (MyIssueClassList !== undefined && MyIssueClassList !== null) {
				// load edit
				ClearDDLOptionsGu('selIssueClassE', 1);
				fillDropDownListGu(MyIssueClassList, jselIssueClassE, 0, 'IssueClass', 'IssueClassID');
				// load filter
				ClearDDLOptionsGu('selIssueClassF', 1);
				fillDropDownListGu(MyIssueClassList, jselIssueClassF, 0, 'IssueClass', 'IssueClassID');
			}
			return false;
		}

		function PopulateIssueList() {
			//alert('Filling Proc Status List');
			var bdy;
			var cellClass = 'StdTableCell';
			var nCol = 16;
			// Cols: 0-ID, 1-App, 2-AppArea, 3-SpecLoc, 4-Issue, 5-Desc, 6-Status, 7-Class, 8-Type, 9-DesignComp, 10-ReportedBy, 11-AssocInfo, 12-Signoff, 13-SignoffDate, 14-SignoffBy, 15-ACTION
			//alert('arrays');
			var cWidth = [60, 100, 100, 100, 200, 300, 40, 90, 90, 90, 120, 200, 200, 70, 110, 140, 0, 0, 0, 0];
			var corientH = ['center', 'left', 'left', 'left', 'left', 'left', 'center', 'center', 'center', 'center', 'right', 'center', 'left', 'left', 'center', 'left', 'center', '', ''];
			var corientV = ['top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top'];
			var cbrdrL = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', ''];
			var cbrdrR = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', ''];
			var cbrdrT = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', ''];
			var cbrdrB = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', ''];
			var cnames = ['IssueID', 'AppCode', 'AppAreaName', 'SpecificLocation', 'IssueTitle', 'IssueDescription', 'IssueStatus', 'IssueClass', 'IssueType', 'DesignComponent', 'sReportByFullName2', 'AssociatedInfo', 'IssueSignoffDetails', 'sSignedOffDate', 'sSignOffByFullName2', 'ACTION', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var aggType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var shown = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
			//alert('1');
			if (!IsContentsNullUndefinedTx(MyIssueList)) {
				//alert('forming grid');
				//alert('Proc List Len: ' + MyProcStatusList.length);
				bdy = FormDataGridBodyMinimumDg(1, nCol, 'tdIssueList', cellClass, true, true, false, true, 'SignOff', 'button blue-gradient glossy', false, 0, MyIssueList, 'IssueID', cnames, cType, cWidth, corientH, corientV, cbrdrL, cbrdrR, cbrdrT, cbrdrB, aggType, shown, true, true);
				//alert('Grid done');
				jtblIssueMngtContent.style.display = 'block';
			}
			else {
				ShowStatusMsg('An unidentified error occurred. No records could be extracted.');
			}
			//alert('Attaching body');
			try {
				var oldBody = jtblIssueMngtContent.getElementsByTagName("tbody")[0];
				jtblIssueMngtContent.replaceChild(bdy, oldBody);
			}
			catch (ex) {
				// nothing
			}
			//alert('pagination updates');
			joPgNbrLblPj.innerHTML = (jiPgNbrPj[0] + 1).toString();
			joMaxPgNbrLblPj.innerHTML = jiNbrPagesPj[0].toString();
			return false;
		}

		function PopulateIssuesTypeList() {
			GetIssuesTypeList();
			//alert(MyProductListMini.length);
			if (MyIssueTypeList !== undefined && MyIssueTypeList !== null) {
				// load edit
				ClearDDLOptionsGu('selIssueTypeE', 1);
				fillDropDownListGu(MyIssueTypeList, jselIssueTypeE, 0, 'IssueType', 'IssueTypeID');
				// load filter
				ClearDDLOptionsGu('jselIssueTypeF', 1);
				fillDropDownListGu(MyIssueTypeList, jselIssueTypeF, 0, 'IssueType', 'IssueTypeID');
			}
			return false;
		}

		// **************************** BACKGROUND FUNCTIONS *********************************

		function ShowStatusMsg(msg) {
			jlStatusMsg.innerHTML = msg;
			return false;
		}

		// **************************** Dialog *********************************

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

		function DeleteOneRec(id, row, Src) {
			switch (Src) {
				case 1:
					var so = document.getElementById('txaIssueSignoffPu').value;
					break;
				default:
					break;
			}
			return false;
		}

		function DialogAction1(dChoice, Src) {
			var id = 0;
			if (dChoice > 0) {
				switch (Src) {
					case 1:
						break;
					case 5:
						id = parseInt(document.getElementById('hfIssueIDPu').value, 10);
						var so = document.getElementById('txaIssueSignoffPu').value;
						UpdateSignOffText(id, so);
						SleepForSecondsGu(1);
						LoadIssuesList();
						break;
					default:
						break;
				}
			}
			return false;
		}

		function EditOneRec(id, row, Src) {
			switch (Src) {
				case 1:
					jlIssueIDE.innerHTML = MyIssueList[row]['IssueID'].toString();
					jselAppForIssueE.value = MyIssueList[row]['ApplicationID'].toString();
					jselAppAreaE.value = MyIssueList[row]['AppAreaID'].toString();
					jselIssueClassE.value = MyIssueList[row]['IssueClassID'].toString();
					jselIssueTypeE.value = MyIssueList[row]['IssueTypeID'].toString();
					jselDesignElementE.value = MyIssueList[row]['DesignComponentID'].toString();
					jselSignoffByIDE.value = MyIssueList[row]['SignedOffByID'].toString();
					jtIssueTitleE.value = MyIssueList[row]['IssueTitle'].toString();
					jtIssueDescriptionE.value = MyIssueList[row]['IssueDescription'].toString();
					jtOtherInfoE.value = MyIssueList[row]['AssociatedInfo'].toString();
					jtIssueSignoffE.value = MyIssueList[row]['IssueSignoffDetails'].toString();
					jlSignOffDateE.value = MyIssueList[row]['sSignedOffDate'].toString();
					jselIssueActiveE.value = MyIssueList[row]['IsActive'].toString();
					jdivIssueMngtFilters.style.display = 'none';
					jdivIssueMngtContentEdit.style.display = 'block';
					break;
				default:
					break;
			}
			return false;
		}

		function SignOffIssue(id, so) {
			//alert('opening dialog');
			document.getElementById('hfIssueIDPu').value = id.toString();
			if (so.length > 0) { document.getElementById('txaIssueSignoffPu').value = so; }
			//alert('opening dialog now');
			var ht = 200;
			var wdth = 800;
			ShowSpecialDialogBox1Dx('divSignOffPopup', 'Signoff', true, true, ht, wdth, '', '', window, '', 'Signoff', '11pt', '1px', 'fadeIn', 'fadeOut', 5)
			//alert('Done!');
			return false;
		}

		function SpecialGridAction(id, row, col, Src) {
			//alert('Fired! ' + id + '/' + row + '/' + col + '/' + Src);
			switch (Src) {
				case 1:
					//alert('Got it!');
					var so = MyIssueList[row]['IssueSignoffDetails'].toString();
					alert(so);
					SignOffIssue(id, so);
					break;
				default:
					break;
			}
			return false;
		}

		function ViewOneRec(id, row, Src) {
			switch (Src) {
				case 1:
					break;
				default:
					break;
			}
			return false;
		}

		// **************************** UI *********************************

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

		function CloseIssueEditBlock() {
			jdivIssueMngtContentEdit.style.display = 'none';
			jdivIssueMngtFilters.style.display = 'block';
			return false;
		}

		function MakeNewIssue() {
			jlIssueIDE.innerHTML = '0';
			jselAppForIssueE.value = '0';
			jselAppAreaE.value = '0';
			jselIssueClassE.value = '0';
			jselIssueTypeE.value = '0';
			jselDesignElementE.value = '0';
			jselSignoffByIDE.value = '0';
			jtIssueTitleE.value = '';
			jtIssueDescriptionE.value = '';
			jtOtherInfoE.value = '';
			jtIssueSignoffE.value = '';
			jlSignOffDateE.value = '';
			jdivIssueMngtFilters.style.display = 'none';
			jdivIssueMngtContentEdit.style.display = 'block';
			return false;
		}

		function LoadIssuesList() {
			var cls = parseInt(jselIssueClassF.value, 10);
			var typ = parseInt(jselIssueTypeF.value, 10);
			var aarea = jselAppAreaF.value;
			var dcomp = parseInt(jselDesignElementF.value, 10);
			var btd = jtBeginDateF.value;
			var edt = jtEndDateF.value;
			var bypers = jtPersonNameF.value;
			GetIssuesList(0, cls, typ, aarea, dcomp, bdt, edt, bypers);
			PopulateIssueList();
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
						if (cust.substr(0, 3) === 'FF|') {
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


		function RefreshIssueGrid() {
			jiPgNbrPj[0] = 0;
			//alert('starting');
			var cls = parseInt(jselIssueClassF.value, 10);
			var typ = parseInt(jselIssueTypeF.value, 10);
			var aarea = jselAppAreaF.value;
			var dcomp = parseInt(jselDesignElementF.value, 10);
			var bdt = jtBeginDateF.value;
			var edt = jtEndDateF.value;
			var bypers = jtPersonNameF.value;
			//alert('ready to pull data');
			//alert(cls + '/' + typ);
			//alert(aarea);
			//alert(dcomp);
			//alert(btd + '/' + edt + '/' + bypers);
			GetIssuesList(0, cls, typ, aarea, dcomp, bdt, edt, bypers);	 //GetIssuesList(id, cls, typ, aarea, dcomp, bdt, edt, bypers)
			PopulateIssueList();
			return false;
		}

		function SaveIssueData() {
			var id = parseInt(jlIssueIDE.innerHTML, 10);
			var app = jselAppForIssueE.value;
			var aarea = jselAppAreaE.value;
			var cls = jselIssueClassE.value;
			var typ = jselIssueTypeE.value;
			var delement = jselDesignElementE.value;
			var sob = jselSignoffByIDE.value;
			var title = jtIssueTitleE.value;
			var desc = jtIssueDescriptionE.value;
			var other = jtOtherInfoE.value;
			var signoff = jtIssueSignoffE.value;
			var act = jsel
			//jlSignOffDateE.value = '';





			return false;
		}

	</script>
		
</head>
<body>
	<img id="imgSessionKeepAlive" width="1" height="1" style="display:none;" src="../Images/clearpixel.gif" />
  <form id="form1" runat="server">
  <asp:ScriptManager runat="server"></asp:ScriptManager>
	<asp:HiddenField ID="hfPageID" runat="server" Value="46" />

		<div id="divSignOffPopup" style="display:none;">
			<table style="border-spacing:0px;border:none;">
			<tr>
				<td>
					<textarea id="txaIssueSignoffPu" style="width:720px;height:80px;"></textarea>
					<input type="hidden" id="hfIssueIDPu" value="" />
				</td>
			</tr>
			</table>
		</div>

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

				<div id="divPAGEMainHDR" style="width:100%;margin-left:10px;">
					<div id="divPageHdrTitle" style="width:100%;">
						<table style="padding:0px;border-spacing:0px;width:100%;">
						<tr>
							<td style="width:30%;text-align:left;">
								<label id="lblIssueMngtHdr" style="color:blue;font-size:14pt;font-weight:bold;">Issue Management</label>
							</td>
							<td style="width:30%;text-align:center;">
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
								</select>&nbsp;
							</td>
							<td style="width:30%;">
								<label id="lblPageStatus" style="position:absolute;font-size:10pt;font-weight:bold;color:darkgray;right:70px;">Page Loading...</label>&nbsp;
							</td>
						</tr>
						</table>

					</div>
									
					<div id="divIssueMngtFilters" style="width:100%;text-align:center;background-color:antiquewhite;">
						<table style="padding:1px;border-spacing:0px;margin: auto auto;"><tr><td>
							<table id="tblIssueMngtFilters" style="padding:1px;border-spacing:0px;margin: auto auto;">
							<tr>
								<td colspan="8" style="text-align:center;font-weight:bold;font-size:12pt;color:blue;">
									Filters:&nbsp;
								</td>
							</tr>
							<tr>
								<td style="text-align:right;">
									Class:&nbsp;
								</td>
								<td style="text-align:left;">
									<select id="selIssueClassF" >
										<option value="0" selected="selected">ALL</option>
									</select>
								</td>
								<td>&nbsp;</td>
								<td style="text-align:right;">
									Type:&nbsp;
								</td>
								<td style="text-align:left;">
									<select id="selIssueTypeF" >
										<option value="0" selected="selected">ALL</option>
									</select>
								</td>
								<td>&nbsp;</td>
								<td style="text-align:right;">
									Design&nbsp;Element:&nbsp;
								</td>
								<td style="text-align:left;">
									<select id="selDesignElementF" >
										<option value="0" selected="selected">ALL</option>
									</select>
								</td>
							</tr>
							<tr>
								<td style="text-align:right;">
									App&nbsp;Area:&nbsp;
								</td>
								<td style="text-align:left;">
									<select id="selAppAreaF" >
										<option value="0" selected="selected">ALL</option>
									</select>
								</td>
								<td>&nbsp;</td>
								<td style="text-align:right;">
									Begin&nbsp;Date:&nbsp;
								</td>
								<td style="text-align:left;">
									<input type="text" id="txtBeginDateF" style="width:80px;" />
								</td>
								<td>&nbsp;</td>
								<td style="text-align:right;">
									End&nbsp;Date:&nbsp;
								</td>
								<td style="text-align:left;">
									<input type="text" id="txtEndDateF" style="width:80px;" />
								</td>
							</tr>
							<tr>
								<td style="text-align:right;">
									Person&nbsp;Name:&nbsp;
								</td>
								<td>
									<input type="text" id="txtPersonNameF" style="width:160px;" />&nbsp;(Format: Last, First)
								</td>
								<td>&nbsp;</td>
								<td style="text-align:right;">
									&nbsp;
								</td>
								<td style="text-align:left;">
									&nbsp;
								</td>
								<td>&nbsp;</td>
								<td style="text-align:right;">
									&nbsp;
								</td>
								<td style="text-align:left;">
									&nbsp;
								</td>
							</tr>
							<tr>
								<td colspan="8" style="text-align:center;">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button id="btnRefreshIssueListGrid" class="button blue-gradient glossy" onclick="javascript:RefreshIssueGrid();return false;">Refresh Data</button>
									<span id="spnQueryMngt" style="margin-left:20px;margin-right:20px;padding:2px;background-color:aquamarine;">
										Saved Queries:&nbsp;
										<select id="selQueryList" onchange="javascript:LoadSavedQueryData(this.value);return false;" >
											<option value="0" selected="selected">None Selected</option>
										</select>
										Query Title:&nbsp;<input type="text" id="txtQueryTitle" style="width:160px;" />&nbsp;
										<button id="btnSaveQueryFormat" onclick="javascript:SaveQueryFormat();return false;" class="button blue-gradient glossy">Save</button>&nbsp;
										<button id="btnManageQueryList" onclick="javascript:ManageQueryList();return false;" class="button blue-gradient glossy">Manage</button>
									</span>	
								</td>
							</tr>
							</table>
						</td></tr></table>
					</div>

				</div>

				<div id="divPAGEMainCONTENT" style="width:100%;margin-left:10px;">
					<div id="divIssueMngtContentEdit" style="width:100%;display:none;padding-bottom:10px;">
						<div id="divIssueMngtEditHdr" style="width:100%;background-color:antiquewhite;">
							<label id="lblIssueEditBlockHdr" style="color:darkblue;font-weight:bold;font-size:12pt;margin-left:8px;">Edit Issue Data:</label>
						</div>
						<div id="divIssueMngtEditBlock" style="width:100%;background-color:antiquewhite;text-align:center;">
							<table style="padding:0px;border-spacing:0px;margin: auto auto;"><tr><td>
								<table id="tblIssueMngtEditBlock" style="padding:1px;border-spacing:0px;margin: auto auto;">
								<tr>
									<td style="text-align:right;vertical-align:top;">
										ID:&nbsp;
									</td>
									<td style="text-align:left;vertical-align:top;">
										<label id="lblIssueIDE" style="color:blue;font-weight:bold;">0</label>
									</td>
									<td>&nbsp;</td>
									<td style="text-align:right;vertical-align:top;">
										Application:&nbsp;
									</td>
									<td style="text-align:left;vertical-align:top;">
										<select id="selAppForIssueE">
											<option value="0" selected="selected">None Selected</option>
										</select>
									</td>
									<td>&nbsp;</td>
									<td style="text-align:right;vertical-align:top;">
										App&nbsp;Area:&nbsp;
									</td>
									<td style="text-align:left;vertical-align:top;">
										<select id="selAppAreaE" >
											<option value="0" selected="selected">ALL</option>
										</select>
									</td>
								</tr>
								<tr>
									<td style="text-align:right;vertical-align:top;">
										Title:&nbsp;
									</td>
									<td style="text-align:left;vertical-align:top;">
										<input type="text" id="txtIssueTitleE" style="width:200px;" />
									</td>
									<td>&nbsp;</td>
									<td style="text-align:right;vertical-align:top;">
										Description:&nbsp;
									</td>
									<td colspan="4" style="text-align:left;vertical-align:top;">
										<textarea id="txaIssueDescriptionE" style="width:800px;height:60px;"></textarea>
									</td>
								</tr>
								<tr>
									<td style="text-align:right;vertical-align:top;">
										Class:&nbsp;
									</td>
									<td style="text-align:left;vertical-align:top;">
										<select id="selIssueClassE" >
											<option value="0" selected="selected">ALL</option>
										</select>
									</td>
									<td>&nbsp;</td>
									<td style="text-align:right;vertical-align:top;">
										Type:&nbsp;
									</td>
									<td style="text-align:left;vertical-align:top;">
										<select id="selIssueTypeE" >
											<option value="0" selected="selected">ALL</option>
										</select>
									</td>
									<td>&nbsp;</td>
									<td style="text-align:right;vertical-align:top;">
										Design&nbsp;Element:&nbsp;
									</td>
									<td style="text-align:left;vertical-align:top;">
										<select id="selDesignElementE" >
											<option value="0" selected="selected">ALL</option>
										</select>
									</td>
								</tr>
								<tr>
									<td style="text-align:right;vertical-align:top;">
										Other&nbsp;Info:&nbsp;
									</td>
									<td style="text-align:left;vertical-align:top;">
										<input type="text" id="txtOtherInfoE" style="width:240px;" />
									</td>
									<td>&nbsp;</td>
									<td style="text-align:right;vertical-align:top;">
										SignOff:&nbsp;
									</td>
									<td colspan="4" style="text-align:left;vertical-align:top;">
										<textarea id="txaIssueSignoffE" style="width:800px;height:60px;"></textarea>
									</td>
								</tr>
								<tr>
									<td style="text-align:right;vertical-align:top;">
										Active:&nbsp;
									</td>
									<td style="text-align:left;vertical-align:top;">
										<select id="selIssueActiveE">
											<option value="1" selected="selected">Yes</option>
											<option value="0">No</option>
										</select>
									</td>
									<td>&nbsp;</td>
									<td style="text-align:right;vertical-align:top;">
										SignOff&nbsp;Date:&nbsp;
									</td>
									<td style="text-align:left;vertical-align:top;">
										<label id="lblSignOffDateE"></label>
									</td>
									<td>&nbsp;</td>
									<td style="text-align:right;vertical-align:top;">
										Signoff&nbsp;By:&nbsp;
									</td>
									<td style="text-align:left;vertical-align:top;">
										<select id="selSignoffByIDE">
											<option value="0" selected="selected">None Selected</option>
										</select>
									</td>
								</tr>
								<tr>
									<td colspan="8" style="text-align:center;">
										<button id="btnSaveIssueData" class="button blue-gradient glossy" onclick="javascript:SaveIssueData();return false;">Save Data</button>
										<button id="btnCloseIssueEditBlock" class="button blue-gradient glossy" onclick="javascript:CloseIssueEditBlock();return false;" style="margin-left:20px;">Close</button>
									</td>
								</tr>
								</table>
							</td></tr></table>
						</div>
					</div>

					<div id="divIssueMngtContentHdr" style="width:100%;">
						<table style="padding:1px;border-spacing:0px;width:100%;">
						<tr>
							<td style="width:50%;text-align:left;">
								<label id="lblIssueMngtContentHdr" style="font-weight:bold;font-size:12pt;color:blue;">Issues:</label>
							</td>
							<td style="width:50%;text-align:right;">
								<button id="btnAddNewIssue" class="button blue-gradient glossy" onclick="javascript:MakeNewIssue();return false;" style="right:20px;">New Issue</button>
							</td>
						</tr>
						</table>
					</div>

					<div id="divIssueMngtDataTable" style="width:100%;">
						<table id="tblIssueMngtContent" style="padding:1px;border-spacing:0px;border-collapse:collapse;">
						<thead>
						<tr>
							<th class="TableHdrCell" style="width:60px;">ID</th>
							<th class="TableHdrCell" style="width:100px;">Application</th>
							<th class="TableHdrCell" style="width:100px;">App Area</th>
							<th class="TableHdrCell" style="width:100px;">Specific Loc</th>
							<th class="TableHdrCell" style="width:200px;">Issue</th>
							<th class="TableHdrCell" style="width:300px;">Description</th>
							<th class="TableHdrCell" style="width:40px;">Stat</th>
							<th class="TableHdrCell" style="width:90px;">Class</th>
							<th class="TableHdrCell" style="width:90px;">Type</th>
							<th class="TableHdrCell" style="width:90px;">Design Comp</th>
							<th class="TableHdrCell" style="width:120px;">Reported By</th>
							<th class="TableHdrCell" style="width:200px;">Associated Info</th>
							<th class="TableHdrCell" style="width:200px;">SignOff</th>
							<th class="TableHdrCell" style="width:70px;">Signoff Date</th>
							<th class="TableHdrCell" style="width:110px;">SignOff By</th>
							<th class="TableHdrCell" style="width:140px;">Action</th>

						</tr>
						</thead>
						<tbody>

						</tbody>
						</table>
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
