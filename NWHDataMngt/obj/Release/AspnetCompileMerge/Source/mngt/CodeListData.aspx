<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CodeListData.aspx.cs" Inherits="DataMngt.mngt.CodeListData" %>
<%@ Register Src="~/tools/ctlButtonBarNoSess.ascx" TagName="BtnBar1" TagPrefix="bb1" %>

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
		var jbViewOnly = true;
		var jdToday = new Date();
		var jiAR = 0;
		var jiByID = 0;
		var jiCurrentGrid = 0;
		var jiNbrPages = 0;
		var jiNbrRows = 0;
		var jiPageID = 33;
		var jiPageNbr = 0;
		var jiPageSize = 20;
		var jiTotalRows = 0;
		var jiUserID = 0;
		var jiViewType = 0;
		var jlPageStatus;
		var jlStatusMsg;
		var jlWeekNbr;
		var jsBrowserType = '';
		var jsCurrentTime = '';
		var jselPageSize;
		var jsErrorMsg = '';
		var jsLocationCode = '';
		var jsPageVersion = '';
		var jsPageVersDate = '';
		var jsRegionCode = '';
		var jsToday = '';

		var MyDataList;
		var MyReturn;

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
			jiPageID = 33;
			jsPageVersion = '1.0.0';
			jsPageVersDate = '11/15/2017';
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

			jdivAdminLogs = document.getElementById('divAdminLogs');
			jdivProcessItemEdit = document.getElementById('divProcessItemEdit');
			jdivProcessList = document.getElementById('divProcessList');
			jdivProcessSettingEdit = document.getElementById('divProcessSettingEdit');
			jdivProcessSettings = document.getElementById('divProcessSettings');
			jdivProcessStatusList = document.getElementById('divProcessStatusList');
			jlStatusMsg = document.getElementById('lblStatusMsg');
			jselAdminLogDBF = document.getElementById('selAdminLogDBF');
			jselAdminLogSchemaF = document.getElementById('selAdminLogSchemaF');
			jselAdminLogTypeF = document.getElementById('selAdminLogTypeF');
			jselNotificationType2F = document.getElementById('selNotificationType2F');
			jselSettingsActiveF = document.getElementById('selSettingsActiveF');
			jselSettingsDatabaseF = document.getElementById('selSettingsDatabaseF');
			jselSettingsProcessF = document.getElementById('selSettingsProcessF');
			jselSettingsSequenceF = document.getElementById('selSettingsSequenceF');
			jselProcessStatF = document.getElementById('selProcessStatF');
			jtAdminErrorIDF = document.getElementById('txtAdminErrorIDF');
			jtAdminLogDateBF = document.getElementById('txtAdminLogDateBF');
			jtAdminLogDateEF = document.getElementById('txtAdminLogDateEF');
			jtAdminLogIDF = document.getElementById('txtAdminLogIDF');
			jtAdminOtherIDF = document.getElementById('txtAdminOtherIDF');
			jtblAdminLogs = document.getElementById('tblAdminLogs');
			jtblProcessList = document.getElementById('tblProcessList');
			jtblProcessSettings = document.getElementById('tblProcessSettings');
			jtblProcessStatList = document.getElementById('tblProcessStatList');

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
			PopulateNotificationList();

			//alert('setting pagination');
			EstablishMainPgElementsPj(1, 0);
			EstablishMainPgElementsPj(2, 0);
			EstablishMainPgElementsPj(3, 0);
			EstablishMainPgElementsPj(4, 0);
			jiNbrPagesPj[0] = 0;
			jiNbrRowsPj[0] = 0;
			jiNbrPagesPj[1] = 0;
			jiNbrRowsPj[1] = 0;
			jiNbrPagesPj[2] = 0;
			jiNbrRowsPj[2] = 0;
			jiNbrPagesPj[3] = 0;
			jiNbrRowsPj[3] = 0;
			jiPageSize = 20;
			//alert('Initiation done');

			//createDatePickerOnTextWc('txtBeginDateF', null, null, 0, 3, 'show', 11);
			//createDatePickerOnTextWc('txtEndDateF', null, null, 0, 3, 'show', 12);

			document.getElementById('lblPageIDInFooter').innerHTML = 'Page ID: ' + jiPageID.toString();
			return false;
		}
		// END of page initiation section --------------------------------------------------------------------------------

		// **************************** AJAX FUNCTIONS *********************************

		function DataCall1() {
			jiPageNbr = jiPgNbrPj[0];
			//alert('Page ' + jiPageNbr);
			GetProcessList(0, 0);
			PopulateProcessList();
			return false;
		}

		function DataCall3() {
			GetProcessStatusList(0, 0, 0, 0);
			PopulateProcStatusGrid();
		}

		function DataCall4() {
			PopulateProcessSettingsList();
			return false;
		}

		function GetNotificationsList() {
			var url = "../shared/AdminServices.asmx/SelectNotificationsList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','Sort':'0','PgNbr':'0','PgSize':'999','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyNotificationsList = response; });
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

		function GetProcessSettings(procid, dbid, scode, sort, act) {
			var url = "../shared/AdminServices.asmx/SelectProcessSettings";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ProcID':'" + procid.toString() + "','DbID':'" + dbid.toString() + "','SeqCode':'" + scode + "','Sort':'" + sort.toString() + "',";
			MyData = MyData + "'Active':'" + act.toString() + "','PgNbr':'" + jiPgNbrPj[3].toString() + "','PgSize':'" + jiPageSize.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProcSettingsData = response; });
			return false;
		}

		// **************************** Populate *********************************

		function PopulateDataGrid() {
			//alert('Filling Proc Status List');
			var bdy;
			var cellClass = 'StdTableCell';
			var nCol = 13;
				// Cols: 0-ID, 1-Code, 2-Name, 3-Type, 4-Schedule, 5-Seq, 6-DBName, 7-LastRunDate, 8-EndRunDate, 9-#Rows, 10-UserID, 11-ErrorID
				//alert('arrays');
			var cWidth = [50, 100, 260, 80, 100, 110, 120, 120, 120, 90, 60, 60, 200, 0, 0, 0, 0];
			var corientH = ['center', 'left', 'left', 'left', 'left', 'left', 'left', 'center', 'center', 'left', 'right', 'center', 'left', '', '', ''];
			var corientV = ['top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', '', '', '', ''];
			var cbrdrL = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrR = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrT = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrB = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cnames = ['ProcessID', 'ProcessCode', 'ProcessName', 'ProcessType', 'Schedule', 'ScheduleSeq', 'DatabaseName', 'sBeginDateTime', 'sEndDateTime', 'NbrSeconds', 'NbrRowsAffected', 'UserID', 'ErrorMsg', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var aggType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var shown = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
			//alert('1');
			if (!IsContentsNullUndefinedTx(MyProcStatusList)) {
				//alert('forming grid');
				//alert('Proc List Len: ' + MyProcStatusList.length);
				bdy = FormDataGridBodyMinimumDg(3, nCol, 'tdProcStList', cellClass, false, false, false, false, '', 'button blue-gradient glossy', false, 0, MyProcStatusList, 'ProcessID', cnames, cType, cWidth, corientH, corientV, cbrdrL, cbrdrR, cbrdrT, cbrdrB, aggType, shown, true, true);
				//alert('Grid done');
				jtblProcessStatList.style.display = 'block';
			}
			else {
				ShowStatusMsg('An unidentified error occurred. No records could be extracted.');
			}
			//alert('Attaching body');
			try {
				var oldBody = jtblProcessStatList.getElementsByTagName("tbody")[0];
				jtblProcessStatList.replaceChild(bdy, oldBody);
			}
			catch (ex) {
				// nothing
			}
			//alert('pagination updates');
			joPgNbrLblPj3.innerHTML = (jiPgNbrPj[2] + 1).toString();
			joMaxPgNbrLblPj3.innerHTML = jiNbrPagesPj[2].toString();
			return false;
	}

		// **************************** Dialogs *********************************

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
				case 1:
					break;
				case 93:
					break;
				default:
					break;
			}
		}

		function ChangeInputVal(id, row, col, objid, val) {

		}

		function ChangeRadioBtn(id, objid, val, ischecked) {
			return false;
		}

		function DialogAction1(dChoice, Src) {
			switch (Src) {
				case 2: // nothing
					break;
				case 5:
					// nothing
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
			switch (objid) {
				case 1: // process
					break;
				default:
					break;
			}

			return false;
		}

		function DeleteOneRec(id, row, objid) {
			switch (objid) {
				case 1:
					DeleteOneProcess(id);
					break;
				default:
					break;
			}
			return false;
		}

		function SpecialGridAction(id,row,col,objid) {
			switch (objid) {
				case 1: // restart process
					RestartProcess(id);
					break;
				default:
					break;
			}
			return false;
		}

		// **************************** Background *********************************

		function ShowStatusMsg(msg) {
			jlStatusMsg.innerHTML = msg;
			return false;
		}

		// **************************** UI FUNCTIONS *********************************

		function ChangePageSize(val) {
			jiPageSize = parseInt(val, 10);
			refreshDataGrid();
			return false;
		}

		// **************************** External Links *********************************

	</script>


	<link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />

</head>
<body>
	<img id="imgSessionKeepAlive" width="1" height="1" style="display: none;" src="../Images/clearpixel.gif" />
	<form id="form1" runat="server">
		<asp:ScriptManager runat="server"></asp:ScriptManager>
		<asp:HiddenField ID="hfPageID" runat="server" Value="33" />

		<div id="divMainPopup" style="display: none;"></div>

		<div class="container body-content">
			<div id="divMainIcon" style="width: 99%; margin-left: 10px;">
				<table style="padding: 0px; border-spacing: 0px; width: 100%;">
					<tr>
						<td style="width: 124px; padding-right: 2px; vertical-align: middle;">
							<img src="../Images/nwhlogo.png" style="width: 120px; height: 36px; margin: 4px;" />
						</td>
						<td style="vertical-align: middle;">
							<bb1:BtnBar1 ID="ctlButtonBar1" runat="server"></bb1:BtnBar1>
						</td>
					</tr>
				</table>
			</div>

			<div id="divPAGEHEADER" style="width: 100%; margin-left: 10px; margin-bottom: 10px;">
				<div id="divPageHdrTitle" style="width: 100%;">
					<label id="lblOricMngtHdrTitle" class="LabelGridHdrStd" style="font-size: 12pt; margin-left: 6px;">Process Management:</label>
					<label id="lblPageStatus" style="position: absolute; font-size: 10pt; font-weight: bold; color: darkgray; right: 70px;">Page Ready</label>
				</div>
				<div id="divMainHdrSelects" style="width: 100%; text-align: center;">
					<label id="lblMainHdrSelectItem" style="color: blue; font-weight: bold; font-size: 12pt;">Edit or View Data:</label>&nbsp;
					<select id="selEditViewType" style="font-size: 12pt;" onchange="javascript:ChangeViewType(this.value);return false;">
						<option value="0" selected="selected">None Selected</option>
						<option value="1">Process List</option>
						<option value="2">Process Status</option>
						<option value="3">Process Settings</option>
						<option value="4">Admin Logs</option>
					</select>
					<span id="spnSpacerFOrItemsPerPage" style="margin-left: 10px;">
						<label style="margin-left: 5px;">Items per Page:</label>
						<select id="selPageSize" style="margin-left: 10px;" onchange="javascript:ChangePageSize(this.value);return false;">
							<option value="10">10</option>
							<option value="20" selected="selected">20</option>
							<option value="25">25</option>
							<option value="30">30</option>
							<option value="35">35</option>
							<option value="40">40</option>
							<option value="50">50</option>
							<option value="75">75</option>
							<option value="100">100</option>
							<option value="150">150</option>
						</select>&nbsp;&nbsp;&bull;&nbsp;&nbsp;
						<button id="btnRefreshStatus" class="button blue-gradient glossy" onclick="javascript:RefreshCurrentDataGrid();return false;">Refresh Data</button>
					</span>
				</div>
			</div>

			<div id="divPAGEMAINSECTION" style="width: 100%; margin-left: 10px;">


			</div>

			<div id="divPAGEFOOTER" style="width: 99%; margin-left: 10px; margin-bottom: 10px;">
				<label id="lblStatusMsg" style="color: maroon; font-size: 12pt; font-weight: bold;"></label>
			</div>

			<footer>
				<div id="divMasterFooter" runat="server" style="border-top: 1px solid gray; line-height: 16px; margin: 0px; font-size: 9pt;">
					<table style="width: 100%; padding: 1px; border-spacing: 0px;">
						<tr>
							<td style="width: 50%;">&nbsp;Version&nbsp;<asp:Label ID="lblVersion" runat="server"></asp:Label>&nbsp;
							dated&nbsp;<asp:Label ID="lblVersionDate" runat="server"></asp:Label>&nbsp;
							Build:&nbsp;<asp:Label ID="lblBuildNbr" runat="server"></asp:Label>&nbsp;
							&copy; <%: DateTime.Now.Year %> Northwest Hardwoods, Inc.
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
