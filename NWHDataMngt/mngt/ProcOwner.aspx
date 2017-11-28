<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProcOwner.aspx.cs" Inherits="DataMngt.mngt.ProcOwner1" %>
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
		var jchkNoEmptyProds;
		var jchkShowZeros;
		var jchkShowCurrentWeek;
		var jchkShowWeekends;
		var jdivDataGrid;
		var jdivProcOwnerEditBlock;
		var jdivProcOwnerFilters;
		var jdToday = new Date();
		var jiAR = 0;
		var jiByID = 0;
		var jiNbrPages = 0;
		var jiNbrRows = 0;
		var jiPageID = 56;
		var jiPageNbr = 0;
		var jiPageSize = 20;
		var jiTotalRows = 0;
		var jiUserID = 0;
		var jlPageStatus;
		var jlProcOwnerIDE;
		var jlStatusMsg;
		var jsBrowserType = '';
		var jsCurrentTime = '';
		var jselPOMandatoryE;
		var jselProcListE;
		var jselProcOwnerActiveE;
		var jselProcOwnerE;
		var jselProcOwnerF;
		var jsErrorMsg = '';
		var jsPageVersion = '';
		var jsPageVersDate = '';
		var jsToday = '';
		var jtblProcOwners;
		var jtProcNameF;

		var MyProcessList;
		var MyProcOwnerData;
		var MyReturn;
		var MyUserList;

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
			jiPageID = 56;
			jsPageVersion = '1.0.0';
			jsPageVersDate = '7/10/2017';
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
			//alert('loaded seed values');
			jsErrorMsg = jsgError;

			jdivProcOwnerEditBlock = document.getElementById('divProcOwnerEditBlock');
			jdivProcOwnerFilters = document.getElementById('divProcOwnerFilters');
			jlPageStatus = document.getElementById('lblPageStatus');
			jlProcOwnerIDE = document.getElementById('lblProcOwnerIDE');
			jselPOMandatoryE = document.getElementById('selPOMandatoryE');
			jselProcOwnerActiveE = document.getElementById('selProcOwnerActiveE');
			jselProcListE = document.getElementById('selProcListE');
			jselProcOwnerE = document.getElementById('selProcOwnerE');
			jselProcOwnerF = document.getElementById('selProcOwnerF');
			jtblProcOwners = document.getElementById('tblProcOwners');
			jtProcNameF = document.getElementById('txtProcNameF');

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
			var d = new Date();
			jiNbrRows = 0;
			//alert('initiation 0');
			jiPageSize = 20;
			jiPgSizePj[0] = 20;
			jiPgNbrPj[0] = 0;
			jiNbrPagesPj[0] = 0;
			jiNbrPages = 0;
			jsRegionCode = '0';
			jsLocationCode = '0';
			//alert('Initiated');
			EstablishMainPgElementsPj(1, 0);
			PopulateUserListDropDown();
			RefreshPOODataGrid();
			PopulateProcessList();
			jlPageStatus.innerHTML = 'Page Ready';
			return false;
		}

		// **************************** AJAX FUNCTIONS *********************************

		function DataCall1() {
			//jiPageNbr = jiPgNbrPj[0];
			//alert('Page ' + jiPageNbr);
			var uid = parseInt(jselProcOwnerF.value, 10);
			var nm = jtProcNameF.value;
			GetProcOwnerList(0, uid, nm, 0, 1);
			PopulateProcOwnerList();
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

		function GetProcOwnerList(pid, uid, nm, sort, act) {
			var url = "../shared/AdminServices.asmx/SelectProcessOwnerList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ProcID':'" + pid.toString() + "','UserID':'" + uid.toString() + "','sName':'" + nm + "','Sort':'" + sort.toString() + "','Active':'" + act.toString() + "',";
			MyData = MyData + "'PgNbr':'" + jiPgNbrPj[0].toString() + "','PgSize':'" + jiPageSize.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProcOwnerData = response; });
			return false;
		}	

		function GetUserList(nm, pos, sort, act) {
			var url = "../shared/AjaxServices.asmx/SelectUserListMin";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','Name':'" + nm + "','Pos':'" + pos + "','HasEmail':'1','Sort':'" + sort.toString() + "','Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyUserList = response; });
			return false;
		}

		function DeleteOneOwnerRecord(id) {
			var url = "../shared/AdminServices.asmx/DeleteOneProcOwner";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ID':'" + id.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			return false;
		}

		function UpdateProcOwner(id, uid, pid, mand, act) {
			var url = "../shared/AdminServices.asmx/UpdateProcessOwner";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ID':'" + id.toString() + "','OwnerID':'" + uid.toString() + "','ProcID':'" + pid.toString() + "','iType':'1','Mand':'" + mand.toString() + "',";
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

		// **************************** POPULATE OBJECTS **********************************

		function PopulateProcOwnerList() {
			//alert('Filling Proc Owner List - ' + MyProcOwnerData.length);
			var bdy;
			var cellClass = 'StdTableCell';
			var nCol = 6;
			// Cols: 0-ID, 1-Process, 2-Owner, 3-Mandatory, 4-Active, 5-ACTION
			//alert('arrays');
			var cWidth = [62, 240, 170, 130, 62, 88, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var corientH = ['center', 'left', 'left', 'center', 'center', 'center', 'center', 'center', 'center', 'center', 'right', 'center', 'left', 'left', 'center', 'left', 'center', '', ''];
			var corientV = ['top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top'];
			var cbrdrL = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', ''];
			var cbrdrR = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', ''];
			var cbrdrT = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', ''];
			var cbrdrB = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', ''];
			var cnames = ['ProcessOwnerID', 'ProcessName', 'sOwnerFullName', 'MandatoryAuth', 'sActive', 'ACTION', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var aggType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var shown = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
			//alert('1');
			if (!IsContentsNullUndefinedTx(MyProcOwnerData)) {
				//alert('forming grid');
				//alert('Proc List Len: ' + MyProcStatusList.length);
				bdy = FormDataGridBodyMinimumDg(1, nCol, 'tdProcOwnerList', cellClass, true, true, false, false, '', 'button blue-gradient glossy', false, 0, MyProcOwnerData, 'ProcessOwnerID', cnames, cType, cWidth, corientH, corientV, cbrdrL, cbrdrR, cbrdrT, cbrdrB, aggType, shown, true, true);
				//alert('Grid done');
				jtblProcOwners.style.display = 'block';
			}
			else {
				ShowStatusMsg('An unidentified error occurred. No records could be extracted.');
			}
			//alert('Attaching body');
			try {
				var oldBody = jtblProcOwners.getElementsByTagName("tbody")[0];
				jtblProcOwners.replaceChild(bdy, oldBody);
			}
			catch (ex) {
				// nothing
			}
			//alert('pagination updates');
			joPgNbrLblPj.innerHTML = (jiPgNbrPj[0] + 1).toString();
			joMaxPgNbrLblPj.innerHTML = jiNbrPagesPj[0].toString();
			return false;
		}

		function PopulateUserListDropDown() {
			GetUserList('', '', 0, 1);
			if (MyUserList !== undefined && MyUserList !== null) {
				ClearDDLOptionsGu('selProcOwnerF', 1);
				fillDropDownListGu(MyUserList, jselProcOwnerF, 0, 'UserFullName', 'UserID');

				ClearDDLOptionsGu('selProcOwnerE', 1);
				fillDropDownListGu(MyUserList, jselProcOwnerE, 0, 'UserFullName', 'UserID');
			}
			return false;
		}

		function PopulateProcessList() {
			GetProcessList(0, 0);
			if (MyProcessList !== undefined && MyProcessList !== null) {
				ClearDDLOptionsGu('selProcListE', 1);
				fillDropDownListGu(MyProcessList, jselProcListE, 0, 'ProcessName', 'ProcessID');
			}
			return false;
		}

		// **************************** DIALOGs *********************************

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
			if (confirm('This will permanently delete ID ' + id.toString() + '. Continue?')) {
				switch (Src) {
					case 1:
						DeleteOneOwnerRecord(id);
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
					jlProcOwnerIDE.innerHTML = MyProcOwnerData[row]['ProcessOwnerID'].toString();
					jselProcOwnerE.value = MyProcOwnerData[row]['OwnerUserID'].toString();
					jselProcListE.value = MyProcOwnerData[row]['ProcessProcID'].toString();
					jselPOMandatoryE.value = MyProcOwnerData[row]['MandatoryAuthorization'].toString();
					jselProcOwnerActiveE.value = MyProcOwnerData[row]['IsActive'].toString();
					jdivProcOwnerFilters.style.display = 'none';
					jdivProcOwnerEditBlock.style.display = 'block';
					break;
				default:
					break;
			}
			return false;
		}

		// **************************** BACKGROUND FUNCTIONS *********************************

		function ShowStatusMsg(msg) {
			jlStatusMsg.innerHTML = msg;
			return false;
		}

		// **************************** UI FUNCTIONS *********************************

		function ClosePOEditBlock() {
			jdivProcOwnerEditBlock.style.display = 'none';
			jdivProcOwnerFilters.style.display = 'block';
			return false;
		}

		function LoadProcOwnerList() {
			var uid = parseInt(jselProcOwnerF.value, 10);
			var nm = jtProcNameF.value;
			GetProcOwnerList(0, uid, nm, 0, 1);
			PopulateProcOwnerList();
			return false;
		}

		function MakeNewProcOwner() {
			jlProcOwnerIDE.innerHTML = '0';
			jselProcOwnerE.value = '0';
			jselProcListE.value = '0';
			jselProcOwnerActiveE.value = '1';
			jselPOMandatoryE.value = '0';
			jdivProcOwnerFilters.style.display = 'none';
			jdivProcOwnerEditBlock.style.display = 'block';
			return false;
		}

		function RefreshPOODataGrid() {
			jiPgNbrPj[0] = 0;
			LoadProcOwnerList();
			return false;
		}

		function SaveProcOwnerData() {
			var id = parseInt(jlProcOwnerIDE.innerHTML, 10);
			var poid = parseInt(jselProcOwnerE.value, 10);
			var pid = parseInt(jselProcListE.value, 10);
			var act = parseInt(jselProcOwnerActiveE.value, 10);
			var mand = parseInt(jselPOMandatoryE.value, 10);
			UpdateProcOwner(id, poid, pid, mand, act);
			LoadProcOwnerList();
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
			alert('opening ' + url);
			window.open(url, '_popup', '', false);
			return false;
		}

		function GotoQuickAccessPage() {
			document.location.href = '../prod/ForecastTool.aspx';
			return false;
		}

	</script>
		
</head>
<body>
	<img id="imgSessionKeepAlive" width="1" height="1" style="display:none;" src="../Images/clearpixel.gif" />
  <form id="form1" runat="server">
  <asp:ScriptManager runat="server"></asp:ScriptManager>
	<asp:HiddenField ID="hfPageID" runat="server" Value="56" />

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


				<div id="divPageHEADER" style="width:99%;margin-bottom:8px;margin-left:10px;">
						<table style="padding:1px;width:100%;border:none;">
						<tr>
							<td style="width:33%;text-align:left;">
								&nbsp;
							</td>
							<td style="width:34%;text-align:center;">
								<label id="lblProcOwnerHdr" style="font-size:14pt;color:blue;font-weight:bold;">Process Owner Management</label>			
							</td>
							<td style="width:33%;text-align:right;">
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
								</select>&nbsp;&nbsp;&nbsp;
								<label id="lblPageStatus" style="font-size:10pt;font-weight:bold;color:darkgray;">Page Loading...</label>&nbsp;
							</td>
						</tr>
						</table>
				</div>

				<div id="divPageMAINCONTENT" style="width:99%;margin-bottom:8px;margin-left:10px;">
					<div id="divProcOwnerFilters" style="width:100%;text-align:center;background-color:antiquewhite;padding:2px;">
						<strong>Filters:</strong>&nbsp;Owner:&nbsp;<select id="selProcOwnerF">
							<option value="0" selected="selected">ALL</option>
						</select>&nbsp;&nbsp;-&nbsp;Process&nbsp;Name:&nbsp;
						<input type="text" id="txtProcNameF" style="width:120px;" />
						<span id="spnRefreshData" style="margin-left:10px;">
							<button id="btnRefreshDataList" class="button blue-gradient glossy" onclick="javascript:RefreshPOODataGrid();return false;">Refresh Data</button>
							<button id="btnNewProcOwner" class="button blue-gradient glossy" onclick="javascript:MakeNewProcOwner();return false;">New Owner</button>
						</span>
					</div>

					<div id="divProcOwnerEditBlock" style="width:100%;display:none;background-color:antiquewhite;margin-bottom:10px;padding-bottom:6px;">
						<label id="lblProOwnerEditHdr" style="color:blue;font-weight:bold;">Edit Process Owner Data:</label>
						<table id="tblProcOwnerEdit" style="padding:1px;border:none;border-spacing:0px;margin: auto auto;">
						<tr>
							<td>
								ID:&nbsp;
							</td>
							<td>
								<label id="lblProcOwnerIDE" style="font-weight:bold;color:darkgreen;"></label>
							</td>
							<td>&nbsp;</td>
							<td>
								Process:&nbsp;
							</td>
							<td>
								<select id="selProcListE">
									<option value="0" selected="selected">None Selected</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>
								Owner:&nbsp;
							</td>
							<td>
								<select id="selProcOwnerE">
									<option value="0" selected="selected">None Selected</option>
								</select>
							</td>
							<td>&nbsp;</td>
							<td>
								Mandatory&nbsp;Authorization:&nbsp;
							</td>
							<td>
								<select id="selPOMandatoryE">
									<option value="1" selected="selected">Yes</option>
									<option value="0">No</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>
								Active:&nbsp;
							</td>
							<td>
								<select id="selProcOwnerActiveE">
									<option value="1" selected="selected">Yes</option>
									<option value="0">No</option>
								</select>
							</td>
							<td>&nbsp;</td>
							<td>
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr>
							<td colspan="5" style="text-align:center;">
								<button id="btnSavePOData" class="button blue-gradient glossy" onclick="javascript:SaveProcOwnerData();return false;">Save</button>
								<button id="btnClosePOEditBlock" class="button blue-gradient glossy" onclick="javascript:ClosePOEditBlock();return false;" style="margin-left:20px;">Close</button>
							</td>
						</tr>
						</table>
					</div>

					<div id="divProcOwnerTable" style="width:100%;">
						<div id="divPOTableHdr" style="width:100%;text-align:center;">
							<label id="lblPOTableHdr" style="color:darkblue;font-size:12pt;font-weight:bold;">Process Owner List:</label>
						</div>
						<div id="divProcOwnTable" style="width:100%;text-align:center;">
							<table style="padding:1px;border-spacing:0px;margin: auto auto;"><tr><td>
								<table id="tblProcOwners" style="padding:1px;border-spacing:0px;border-collapse:collapse;margin: auto auto;">
								<thead>
								<tr>
									<th class="TableHdrCell" style="width:62px;">ID</th>
									<th class="TableHdrCell" style="width:240px;">Process</th>
									<th class="TableHdrCell" style="width:170px;">Owner</th>
									<th class="TableHdrCell" style="width:130px;">Mandatory Auth</th>
									<th class="TableHdrCell" style="width:62px;">Active</th>
									<th class="TableHdrCell" style="width:88px;">Action</th>
								</tr>
								</thead>
								<tbody>

								</tbody>
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
