<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RequestMngt.aspx.cs" Inherits="DataMngt.page.RequestMngt" %>
<%@ Register Src="~/tools/ctlButtonBarNoSess.ascx" TagName="BtnBar1" TagPrefix="bb1"  %>

<!DOCTYPE html>
<html lang="en">
<head>
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

			.GridHdrCells {
				background-color:lightgray;
				text-align: center;
				font-size:12pt;
				font-weight:bold;
				width:460px;
				height:30px;
				border:3px solid gray;
				overflow: hidden;
			}

			.CommentCells {
				text-align: left;
				font-size: 11pt;
				font-weight: normal;
				color: black;
				background-color: white;
				vertical-align: top;
				overflow: hidden;
				height:250px;
				width:460px;
				border:3px solid gray;
				padding:2px;
			}

			.ButtonBlock {
				text-align: center;
				padding-left: 2px;
				padding-right: 2px;
				padding-top: 1px;
				padding-bottom: 1px;
				font-weight: bold;
			}

			.MainDisplayDIVs {
				position:relative;
				width:99%;
				margin-left:30px;
				margin-right:30px;
				text-align:center;
			}

			.GraphSectionHdr {
				text-align:center;
				font-size:13pt;
				font-family:Tahoma;
				font-weight:bold;
				background-color:#EAEAEA;
			}

	</style>

	<script type="text/javascript">
		var jbA = false;
		var jbAllLocations = false;
		var jbCanEdit = false;
		var jbPaginate = false;
		var jbShowHistory = false;
		var jbViewOnly = true;
		var jdTarget = new Date();
		var jdToday = new Date();
		var jiAR = 0;
		var jiByID = 0;
		var jiListType = 0;
		var jiNbrPages = 0;
		var jiNbrRows = 0;
		var jiPageID = 47;
		var jiPageNbr = 0;
		var jiPageSize = 20;
		var jiUserID = 0;
		var jlPageStatus;
		var jlRequestGridHdr;
		var jlStatusMsg;
		var jsBrowserType = '';
		var jsCurrentTime = '';
		var jselReqTypeF;
		var jselRequesterIDF;
		var jsErrorMsg = '';
		var jsPageVersion = '';
		var jsPageVersDate = '';
		var jspnSpacerFOrItemsPerPage;
		var jsToday = '';
		var jtBeginDateF;
		var jtblRequestGrid;
		var jtEndDateF;

		var MyCodeList;
		var MyRecDecItem;
		var MyRecDecList;
		var MyReturn;
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
			jiPageID = 45;
			jsPageVersion = '1.0.0';
			jsPageVersDate = '8/21/2017';
			jbViewOnly = true;
			jbCanEdit = false;
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

			jlPageStatus = document.getElementById('lblPageStatus');
			jlRequestGridHdr = document.getElementById('lblRequestGridHdr');
			jlStatusMsg = document.getElementById('lblStatusMsg');
			jselReqTypeF = document.getElementById('selReqTypeF');
			jselRequesterIDF = document.getElementById('selRequesterIDF');
			jspnSpacerFOrItemsPerPage = document.getElementById('spnSpacerFOrItemsPerPage');
			jtblRequestGrid = document.getElementById('tblRequestGrid');

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
			if ((evt2.keyCode == 9) && (jbEditingComment === true)) { jtaCommentE.innerHTML = jtaCommentE.innerHTML + '     '; return false; }
			if (evt2.ctrlKey && (jbEditingComment === true)) {
				var val = String.fromCharCode(event.which).toLowerCase();
				GetMacroTextEM(0, 1, val, jtaCommentE);
				event.preventDefault();
			}
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
			return false;
		}

		// initial data loads for page initiation
		function PageInitiation() {
			//alert('beginning initiation');
			if (jbA !== true) {
				//alert('stuff');
			}
			if (jbA === true || jigCW === true) {
				//appendDDLOptionGu(jselLocationCodeE, 'HQ', 'Company Comment');
				//alert('stuff');
			}
			else {
				//jbtnMillOrder.style.display = 'none';
			}

			jiListType = 0;
			jiPgNbrPj[0] = 0;
			jiNbrPagesPj[0] = 0;
			jiNbrRowsPj[0] = 0;
			jiNbrPagesPj[1] = 0;
			jiNbrRowsPj[1] = 0;
			jiPageSize = 20;
			//alert(jiCommentType);
			
			//alert('set 1');
			EstablishMainPgElementsPj(1, 0);
			//EstablishMainPgElementsPj(2, 0);
			var typ = '1';
			//alert('loading filter data');
			PopulateUserList();
			PopulateReqTypeList();
			//alert('loading grid');
			DataCall1();

			createDatePickerOnTextWc('txtBeginDateF', null, null, 0, 3, 'show', 11);
			createDatePickerOnTextWc('txtEndDateF', null, null, 0, 3, 'show', 12);

			//alert('Initiation done');
			jlPageStatus.innerHTML = 'Page Ready';
			document.getElementById('lblPageIDInFooter').innerHTML = 'Page ID: ' + jiPageID.toString();
			return false;
		}
		// END of page initiation section --------------------------------------------------------------------------------

		// **************************** AJAX FUNCTIONS *********************************

		function DataCall1() {
			jiPageNbr = jiPgNbrPj[0];
			var hist = 0;
			if (jbShowHistory === true) { hist = 1;}
			//alert('Page ' + jiPageNbr + '/' + typ);
			GetReqDecisionsList(0, 0, 0, 0, hist, '', '');
			PopulateRequestGrid();
			return false;
		}

		function DataCall2() {
			jiPageNbr = jiPgNbrPj[1];
			return false;
		}

		function GetUserList(id, nm, ctry, city, loc, pos, grp, sort, act) {
			var url = "../shared/AdminServices.asmx/SelectUserList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ID':'" + id.toString() + "','Name':'" + nm + "','Ctry':'" + ctry + "','City':'" + city + "','Loc':'" + loc + "','Pos':'" + pos + "','Grp':'" + grp + "',";
			MyData = MyData + "'Sort':'" + sort.toString() + "','Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyUserList = response; });
			return false;
		}

		function GetReqDecisionsList(rid, uid, rtid, sort, hist, bdt, edt) {
			var url = "../shared/GridSupportServices.asmx/SelectUserRequestData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ReqID':'" + rid.toString() + "','UserID':'" + uid.toString() + "','ReqTypeID':'" + rtid.toString() + "','ListType':'" + jiListType.toString() + "',";
			MyData = MyData + "'Sort':'" + sort.toString() + "','Hist':'" + hist.toString() + "','BDate':'" + bdt + "','EDate':'" + edt + "','PgNbr':'" + jiPgNbrPj[0].toString() + "','PgSize':'" + jiPageSize.toString() + "',";
			MyData = MyData + "'ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyRecDecList = response; });
			return false;
		}	

		function GetRequestItem(rid) {
			var url = "../shared/GridSupportServices.asmx/SelectUserRequestData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ReqID':'" + rid.toString() + "','UserID':'0','ReqTypeID':'0','ListType':'2',";
			MyData = MyData + "'Sort':'0','Hist':'1','BDate':'','EDate':'','PgNbr':'0','PgSize':'20','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyRecDecItem = response; });
			return false;
		}

		function GetWebCodeList(grp, sort, act) {
			var url = "../shared/AdminServices.asmx/SelectWebCodeList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','CodeGrp':'" + grp + "','Sort':'" + sort.toString() + "','Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCodeList = response; });
			return false;
		}

		function UpdateRequestData(id, val, typ) {


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

		function PopulateRequestGrid() {
			//alert('Filling Proc List');
			var CanEdit = jbCanEdit;
			var cellClass = 'StdTableCell';
			var nCol = 15;
			// Cols: 0-ID, 1-Requester, 2-Type, 3-Title, 4-Text, 5-RequestDate, 6-Pri, 7-Step, 8-Status, 9-StatusDate, 10-Decider, 11-DueDate, 12-Comp, 13-DecTree, 14-ACTION
			//alert('arrays');
			var cWidth = [60, 160, 110, 140, 400, 80, 40, 80, 60, 80, 80, 80, 80, 50, 180, 100, 0, 0, 0, 0];
			var corientH = ['center', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', '', '', ''];
			var corientV = ['top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', '', '', '', ''];
			var cbrdrL = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', ''];
			var cbrdrR = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', ''];
			var cbrdrT = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', ''];
			var cbrdrB = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', ''];
			var cnames = ['RequestID', 'sReqUserName', 'ReqType', 'RequestTitle', 'RequestDescription', 'sRequestDate','ReqPriorityID', 'CurrentStepNbr', 'CurrDecisionCode', 'sCurrDecisionDate', 'sDecUserName', 'sDueDate', 'sFinal', 'DecTree', 'ACTION', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
			var cType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var aggType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var shown = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
			//alert('DDL list data');

			if (!IsContentsNullUndefinedTx(MyRecDecList)) {
				//alert('List Len: ' + MyCommentList.length);
				var bdy = FormDataGridBodyMinimumDg(1, nCol, 'tdRecDecList', cellClass, false, false, false, true, 'Manage', 'button blue-gradient glossy', false, 0, MyRecDecList, 'RequestID', cnames, cType, cWidth, corientH, corientV, cbrdrL, cbrdrR, cbrdrT, cbrdrB, aggType, shown, true, true);
				//alert('Grid done');
				jtblRequestGrid.style.display = 'block';
			}
			else {
				alert('Comment List bad data');
				ShowStatusMsg('An unidentified error occurred. No records could be extracted.');
			}
				//alert('Attaching body');
				try {
					var oldBody = jtblRequestGrid.getElementsByTagName("tbody")[0];
					jtblRequestGrid.replaceChild(bdy, oldBody);
				}
				catch (ex) {
					// nothing
				}
				joPgNbrLblPj.innerHTML = (jiPgNbrPj[0]+1).toString();
				joMaxPgNbrLblPj.innerHTML = jiNbrPagesPj[0].toString();

			return false;
		}

		function PopulateReqTypeList() {
			GetWebCodeList('ReqType', 0, 1);
			alert(MyCodeList.length);
			if (!IsContentsNullUndefinedTx(MyCodeList)) {
				ClearDDLOptionsGu('selReqTypeF', 1);
				fillDropDownListGu(MyCodeList, jselReqTypeF, 0, 'ItemTitle', 'ItemCode');
			}
			return false;
		}

		function PopulateUserList() {
			GetUserList(0, '', '', '', '', '', '', 0, 1);
			if (!IsContentsNullUndefinedTx(MyUserList)) {
				ClearDDLOptionsGu('selRequesterIDF', 1);
				fillDropDownListGu(MyUserList, jselRequesterIDF, 0, 'UserFullName', 'UserID');
			}
			return false;
		}
		
		// **************************** Background Functions *********************************

		function ShowStatusMsg(msg) {
			jlStatusMsg.innerHTML = msg;
			return false;
		}

		// **************************** Dialog *********************************

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

		function ChangeInputVal(id, row, col, objid, val) {
			switch (objid) {
				case 1:
					break;
				case 2:
					UpdateSetting(id, val);
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
			switch (objid) {
				case 1:
					break;
				case 6:
					break;
				default:
					break;
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
				case 1: // comment
					break;
				case 6:
					break;
				default:
					break;
			}

			return false;
		}

		function ShowManageItemDialog(id) {
			//alert('opening dialog now');
			var content = '<table style="padding:1px;border-spacing:0px;text-align:center;"><tr><td>';
			var apprid = 0;
			var approvers = '';
			var final = 0;
			var ht = 700;
			var IsApprover = 0;
			var ttl = 'Manage Request ID ' + id.toString();
			var wdth = 900;
			var requserid = 0;

			if (!IsContentsNullUndefEmptyTx(MyRecDecItem)) {
				requserid = parseInt(MyRecDecItem[0]['RequestorUserID'], 10);
				if (MyRecDecItem[0]['sFinal'].toString() === 'Yes') { final = 1; }
				if (final === 0) {
					apprid = parseInt(MyRecDecItem[0]['DeciderUserID'], 10);
					approvers = ';' + MyRecDecItem[0]['UserGrpMembers'].toString() + ';';
					if (requserid === jiByID) {
						content = content + '<button id="btnRecallOneRequest" class="button blue-gradient glossy" onclick="javascript:ChangeThisRequest(' + id.toString() + ', 3);return false;">Recall</button>';
						content = content + '<button id="btnCancelOneRequest" class="button blue-gradient glossy" onclick="javascript:ChangeThisRequest(' + id.toString() + ', 4);return false;">Cancel</button>';
					}
					else {
						if (apprid === jiByID) {
							IsApprover = 1;
						}
						else {
							if (!IsContentsNullUndefEmptyGu(approvers)) {
								if (approvers.indexOf(';' + jiByID.toString() + ';') > -1) { IsApprover = 1; }
							}
						}
						if (IsApprover === 1) {
							content = content + '<button id="btnRecallOneRequest" class="button blue-gradient glossy" onclick="javascript:ChangeThisRequest(' + id.toString() + ',' + StringifyTx() + ', 0);return false;">Approve</button>';
							content = content + '<button id="btnCancelOneRequest" class="button blue-gradient glossy" onclick="javascript:ChangeThisRequest(' + id.toString() + ',' + StringifyTx() + ', 1);return false;">Deny</button>';
						}
					}
				}
				else {
					content = content + 'No action is possible because the request has been finalized.';
				}
				// show personal buttons
			}

			content = content + '</td></tr></table>';
			ShowSpecialDialogBox1Dx('divMainPopup', ttl, true, true, ht, wdth, '', '', window, content, 'Done', '11pt', '1px', 'fadeIn', 'fadeOut', 11)
			//alert('Done!');
			return false;
		}
		
		function SpecialGridAction(id, row, col, objid) {
			switch (objid) {
				case 1: // manage
					GetRequestItem(id);
					ShowManageItemDialog(id);
					break;
				default:
					break;
			}

			return false;
		}

		function ViewOneRec(id, row, objid) {
			return false;
		}

		// **************************** UI Events *********************************

		function ChangeThisRequest(id, typ) {
			switch (typ) {
				case 0:
					break;
				case 1:
					break;
				case 2:
					break;
				case 3: //recall
					UpdateRequestData(id, '', typ);
					break;
				case 4: // cancell
					UpdateRequestData(id, '', typ);
					break;
				default:
					break;
			}

			return false;
		}

		function ChangePageSize(val) {
			jiPageSize = parseInt(val, 10);
			refreshDataGrid();
			return false;
		}

		function ChangeShowHistory(chckd) {
			jbShowHistory = chckd;
			return false;
		}

		function RefreshDataGrid() {
			DataCall1();
			return false;
		}

		function ShowDataGridData(typ) {
			switch (typ) {
				case 0: // decisions due
					jiListType = 0;
					jlRequestGridHdr.innerHTML = 'Current Outstanding Requests';
					break;
				case 1: // requests
					jiListType = 1;
					jlRequestGridHdr.innerHTML = 'Requests Submitted';
					break;
				case 2: // decisions past
					jiListType = 2;
					jlRequestGridHdr.innerHTML = 'Decisions made on Requests';
					break;
				default:
					break;
			}
			DataCall1();
			return false;
		}

	</script>
			
  <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />

</head>
<body>
	<img id="imgSessionKeepAlive" width="1" height="1" style="display:none;" src="../Images/clearpixel.gif" />
  <form id="form1" runat="server">
  <asp:ScriptManager runat="server"></asp:ScriptManager>
	<asp:HiddenField ID="hfPageID" runat="server" Value="47" />

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

			<div id="divPAGEHEADER" style="width:100%;margin-left:10px;margin-bottom:10px;display:block;">
				<div id="divPageHdrLine1" style="width:100%;text-align:center;">
					<table style="width:100%;border:none;border-spacing:0px;padding:0px;">
					<tr>
						<td style="width:33%;text-align:left;">
							<label id="lblWebCalHdrTitle" class="LabelGridHdrStd" style="font-size:11pt;">Request Management:</label>
						</td>
						<td style="width:34%;text-align:right;">
							<span id="spnSpacerFOrItemsPerPage" style="margin-left:6px;">
								<label style="margin-left: 2px;">Items per Page:</label>&nbsp;<select id="selPageSize" style="margin-left: 10px;" onchange="javascript:ChangePageSize(this.value);return false;">
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
							</span>	
						</td>
						<td style="width:33%;text-align:right;">
							<label id="lblPageStatus" style="position:absolute;font-size:10pt;font-weight:bold;color:darkgray;right:70px;">Page Loading...</label>&nbsp;&nbsp;
						</td>
					</tr>
					</table>
				</div>
				<div id="divMainFilterBar" style="width:100%;text-align:center;background-color:antiquewhite;margin-top:8px;">
					<table id="tblMainFilterBar" style="padding:2px;margin: auto auto;">
					<tr>
						<td style="background-color:blue;color:white;width:80px;text-align:center;">Filters</td>
						<td>
							&nbsp;Requester:&nbsp;
							<select id="selRequesterIDF">
								<option value="0" selected="selected">ALL</option>
							</select>
						</td>
						<td>&nbsp;&nbsp;</td>
						<td>
							<label id="lblDateRangeF" style="color:darkgreen;font-weight:bold;">Date&nbsp;Range:</label>&nbsp;
							Begin:&nbsp;<input type="text" id="txtBeginDateF" style="width:80px;" />&nbsp;
							End:&nbsp;<input type="text" id="txtEndDateF" style="width:80px;" />&nbsp;&nbsp;
						</td>
						<td>&nbsp;</td>
						<td>
							Type:&nbsp;
							<select id="selReqTypeF">
								<option value="0" selected="selected">ALL</option>
							</select>
						</td>
						<td>&nbsp;&nbsp;</td>
						<td>
							Show&nbsp;History:&nbsp;<input type="checkbox" id="chkShowHistoryF" onchange="javascript:ChangeShowHistory(this.checked);return false;" />
						</td>
						<td>&nbsp;&nbsp;</td>
						<td>
							<button id="btnRefreshDataGrid" class="button blue-gradient glossy" onclick="javascript:RefreshDataGrid();return false;">Refresh Data</button>
						</td>
					</tr>
					</table>
				</div>
					
					
				<div id="divMainBtnBar" style="width:100%;text-align:center;margin-top:8px;">
					<button id="btnShowDecisionsDue" class="button blue-gradient glossy" onclick="javascript:ShowDataGridData(0);return false;" style="width:120px;">Decisions Due</button>
					<button id="btnShowDecisions" class="button blue-gradient glossy" onclick="javascript:ShowDataGridData(2);return false;" style="width:120px;">Decisions Made</button>
					<button id="btnShowRequests" class="button blue-gradient glossy" onclick="javascript:ShowDataGridData(1);return false;" style="width:120px;">Requests</button>
				</div>
	    </div>

			<div id="divPAGEMAINSECTION" style="width:100%;margin-left:10px;display:block;margin-top:10px;">


				<div id="divRequestGrid" style="width:100%;text-align:center;">
					<div id="divRequestGridHdr" style="width:100%;padding:1px;">
						<label id="lblRequestGridHdr" style="font-size:14pt;color:blue;font-weight:bold;">Current Outstanding Requests</label>
					</div>
					<table id="tblRequestGrid" style="padding:1px;border:1px solid gray;border-collapse:collapse;border-spacing:0px;margin: auto auto;">
					<thead>
					<tr>
						<th class="ColHeaderStd" style="width:60px;">ID</th>
						<th class="ColHeaderStd" style="width:160px;">Requester</th>
						<th class="ColHeaderStd" style="width:110px;">Type</th>
						<th class="ColHeaderStd" style="width:140px;">Title</th>
						<th class="ColHeaderStd" style="width:400px;">Request</th>
						<th class="ColHeaderStd" style="width:80px;">Made On</th>
						<th class="ColHeaderStd" style="width:40px;">Pri</th>
						<th class="ColHeaderStd" style="width:80px;">Step</th>
						<th class="ColHeaderStd" style="width:60px;">Status</th>
						<th class="ColHeaderStd" style="width:80px;">Status Date</th>
						<th class="ColHeaderStd" style="width:80px;">Decider</th>
						<th class="ColHeaderStd" style="width:80px;">Due Date</th>
						<th class="ColHeaderStd" style="width:50px;">Comp</th>
						<th class="ColHeaderStd" style="width:180px;">Decision Tree</th>
						<th class="ColHeaderStd" style="width:100px;">Action</th>
					</tr>
					</thead>
					<tbody>
					</tbody>
					</table>

<!-- #include file="../inc/incPaginationDiv.inc" -->
				
				</div>



	    </div>

			<div id="divPAGEFOOTER" style="width:99%;margin-left:10px;margin-bottom:10px;display:block;">
				</div>
				<div id="divFooterStatusMsg" style="width:100%;margin-left:10px;">
					<label id="lblStatusMsg" style="color:maroon;font-size:12pt;font-weight:bold;"></label>
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