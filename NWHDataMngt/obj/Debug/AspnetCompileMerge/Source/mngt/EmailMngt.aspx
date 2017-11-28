<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmailMngt.aspx.cs" Inherits="DataMngt.page.EmailMngt" %>
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
		var jbViewOnly = true;
		var jchkIncludeAdmins;
		var jchkIncludeGlobals;
		var jdivDataGrid;
		var jdivEmailAddressEdit;
		var jdivEmailAddresses;
		var jdivEmailTemplateEdit;
		var jdivEmailTemplates;
		var jdivEmailTraffic;
		var jdivNotificationsEdit;
		var jdivNotificationTypes;
		var jdivSendEmail;
		var jdToday = new Date();
		var jiAR = 0;
		var jiActionStatusCode = '';
		var jiActionStatusID = 0;
		var jiActionStatusMsg = '';
		var jiApprovalID = 0;
		var jiByID = 0;
		var jiCurrentGrid = 0;
		var jiNbrEmails = 0;
		var jiNbrPages = 0;
		var jiNbrRows = 0;
		var jiPageID = 59;
		var jiPageNbr = 0;
		var jiPageSize = 20;
		var jiTargetEmailAddrID = 0;
		var jiTotalRows = 0;
		var jiUserID = 0;
		var jiViewType = 0;
		var jlNbrUsersSend;
		var jlPageStatus;
		var jlStatusMsg;
		var jlWeekNbr;
		var jsBrowserType = '';
		var jsCurrentTime = '';
		var jselAddressTypeF;
		var jselDatabaseIDf;
		var jselEmailTemplateSE;
		var jselErrorTypeF;
		var jselMainSortOrder;
		var jselNotificationTypeE;
		var jselNotificationTypeF;
		var jselNotificationType2F;
		var jselNotificationTypeForAddr;
		var jselNotificationTypeForAddrE2;
		var jselPageSize;
		var jselSendEmailApp;
		var jselSendUserGroup;
		var jselUserList;
		var jselUserList2;
		var jsEmailAddress = '';
		var jsEmailAddress2 = '';
		var jsEmailList = '';
		var jsErrorMsg = '';
		var jsLocationCode = '';
		var jsPageVersion = '';
		var jsPageVersDate = '';
		var jsRegionCode = '';
		var jsSendEmailApp = '';
		var jsSendEmailGrp = '';
		var jsToday = '';
		var jtblEmailAddresses;
		var jtblEmailTemplates;
		var jtblEmailTraffic;
		var jtblNotificationTypes;
		var jtEmailAddressF;
		var jtQueryTitle;
		var jtTemplateNameF;
		var jtTemplateSubjectF;
		var jtxaSendEmailSubj;
		var jtxaSendEmailText;

		var MyEmailAddressList;
		var MyEmailList;
		var MyEmailTemplateList;
		var MyEmailTraffic;
		var MyNotificationsList;
		var MyReturn;
		var MyUserGroupList;
		var MyUserList;

		// Objects: 0-EmailAddresses, 1-EmailTemplates, 2-EmailTraffic, 3-NotificationTypes
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
			jiPageID = 59;
			jsPageVersion = '1.0.0';
			jsPageVersDate = '6/25/2017';
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

			jchkIncludeAdmins = document.getElementById('chkIncludeAdmins');
			jchkIncludeGlobals = document.getElementById('chkIncludeGlobals');

			jdivEmailAddressEdit = document.getElementById('divEmailAddressEdit');
			jdivEmailAddresses = document.getElementById('divEmailAddresses');
			jdivEmailTemplateEdit = document.getElementById('divEmailTemplateEdit');
			jdivEmailTemplates = document.getElementById('divEmailTemplates');
			jdivEmailTraffic = document.getElementById('divEmailTraffic');
			jdivNotificationsEdit = document.getElementById('divNotificationsEdit');
			jdivNotificationTypes = document.getElementById('divNotificationTypes');
			jdivSendEmail = document.getElementById('divSendEmail');

			jlNbrUsersSend = document.getElementById('lblNbrUsersSend');
			jlPageStatus = document.getElementById('lblPageStatus');
			jlStatusMsg = document.getElementById('lblStatusMsg');
			jselAddressTypeF = document.getElementById('selAddressTypeF');
			jselDatabaseIDf = document.getElementById('selDatabaseIDf');
			jselEmailTemplateSE = document.getElementById('selEmailTemplateSE');
			jselErrorTypeF = document.getElementById('selErrorTypeF');
			jselMainSortOrder = document.getElementById('selMainSortOrder');
			jselNotificationTypeE = document.getElementById('selNotificationTypeE');
			jselNotificationTypeF = document.getElementById('selNotificationTypeF');
			jselNotificationType2F = document.getElementById('selNotificationType2F');
			jselNotificationTypeForAddr = document.getElementById('selNotificationTypeForAddrE');
			jselPageSize = document.getElementById('selPageSize');
			jselSendEmailApp = document.getElementById('selSendEmailApp');
			jselSendUserGroup = document.getElementById('selSendUserGroup');
			jselUserList = document.getElementById('selUserList');

			jtblEmailAddresses = document.getElementById('tblEmailAddresses');
			jtblEmailTemplates = document.getElementById('tblEmailTemplates');
			jtblEmailTraffic = document.getElementById('tblEmailTraffic');
			jtblNotificationTypes = document.getElementById('tblNotificationTypes');
			jtEmailAddressF = document.getElementById('txtEmailAddressF');
			jtTemplateNameF = document.getElementById('txtTemplateNameF');
			jtTemplateSubjectF = document.getElementById('txtTemplateSubjectF');
			jtxaSendEmailSubj = document.getElementById('txaSendEmailSubj');
			jtxaSendEmailText = document.getElementById('txaSendEmailText');

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
			jiNbrRows = 0;
			jiPageSize = 20;
			jiPgSizePj[0] = 20;
			jiPgNbrPj[0] = 0;
			jiPgNbrPj[1] = 0;
			jiPgNbrPj[2] = 0;
			jiPgNbrPj[3] = 0;
			jiNbrPagesPj[0] = 0;
			jiNbrPagesPj[1] = 0;
			jiNbrPagesPj[2] = 0;
			jiNbrPagesPj[3] = 0;
			jiNbrPages = 0;
			jsRegionCode = '0';
			jsLocationCode = '0';
			PopulateNotificationDropDown();
			PopulateUserListDropDown();
			//alert('Initiated');
			EstablishMainPgElementsPj(1, 0);
			//alert('set 1');
			EstablishMainPgElementsPj(2, 0);
			//alert('set 2');
			EstablishMainPgElementsPj(3, 0);
			//alert('set 3');
			EstablishMainPgElementsPj(4, 0);
			//alert('set 4');

			jlPageStatus.innerHTML = 'Page Ready';
			return false;
		}

		// **************************** AJAX FUNCTIONS *********************************

		function GetEmailAddressList(notifid, err, atype, act) {
			var sort = jselMainSortOrder.value;
			var url = "../shared/AdminServices.asmx/SelectEmailAddressList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','NotifID':'" + notifid.toString() + "','Error':'" + err.toString() + "','AddrType':'" + atype + "','Active':'" + act.toString() + "',";
			MyData = MyData + "'Sort':'" + sort.toString() + "','PgNbr':'" + jiPgNbrPj[0].toString() + "','PgSize':'" + jiPageSize.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyEmailAddressList = response; });
			return false;
		}

		function GetEmailAddresses(acode, gcode, iadm, iglb, inbr) {
			var url = "../shared/AdminServices.asmx/SelectEmailAddresses";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','AppCode':'" + acode + "','GrpCode':'" + gcode + "','IncAdmin':'" + iadm.toString() + "','IncGlobal':'" + iglb.toString() + "','IncNbr':'" + inbr.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			if (!IsContentsNullUndefEmptyTx(MyReturn, 1)) {
				var s = MyReturn[0]['EmailAddrList'].toString();
				var a = s.split('|');
				if (a.length > 1) {
					jiNbrEmails = a[0];
					jsEmailList = a[1];
				}
				else {
					jiNbrEmails = 0;
					jsEmailList = a[0];
				}
			}
			return false;
		}

		function GetEmailRecords(dbid, app, so, sort) {
			var url = "../shared/AdminServices.asmx/SelectEmailRecords";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','DBID':'" + dbid.toString() + "','App':'" + app + "','SentOnly':'" + so.toString() + "','Sort':'" + sort.toString() + "',";
			MyData = MyData + "'PgNbr':'" + jiPgNbrPj[2].toString() + "','PgSize':'" + jiPageSize.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyEmailList = response; });
			return false;
		}

		function GetEmailTemplateList(id, code, nm, subj, body) {
			var url = "../shared/AdminServices.asmx/SelectEmailTemplateList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','TemplateID':'" + id.toString() + "','Code':'" + code + "','Name':'" + nm + "','Subj':'" + subj + "','Body':'" + body + "',";
			MyData = MyData + "'Sort':'0','Active':'2','PgNbr':'" + jiPgNbrPj[1].toString() + "','PgSize':'" + jiPageSize.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyEmailTemplateList = response; });
			return false;
		}

		function GetEmailTraffic(dbid, sonly, sort) {
			var url = "../shared/AdminServices.asmx/SelectEmailRecords";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','DBID':'" + id.toString() + "','SentOnly':'" + sonly.toString() + "','Sort':'" + sort.toString() + "','PgNbr':'" + jiPgNbrPj[2].toString() + "','PgSize':'" + jiPageSize.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyEmailTraffic = response; });
			return false;
		}

		function GetNotificationsList(sort, showall) {
			var url = "../shared/AdminServices.asmx/SelectNotificationsList";
			var psize = jiPageSize;
			var pgn = jiPgNbrPj[3];
			if (showall === 1) {
				psize = 9999;
				pgn = 0;
			}
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','Sort':'0','ShowAll':'','PgNbr':'" + pgn.toString() + "','PgSize':'" + psize.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyNotificationsList = response; });
			return false;
		}

		function GetUserGroupList() {
			var url = "../shared/AdminServices.asmx/SelectUserGroupList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','Sort':'0','Active':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyUserGroupList = response; });
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

		function UpdateEmailAddress(id, email, userid, notif, err, atype, act) {
			var url = "../shared/AdminServices.asmx/UpdateEmailAddress";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','EmailAddrID':'" + id.toString() + "','EmailAddr':'" + email + "','UserID':'" + userid.toString() + "','NotifTypeID':'" + notif.toString() + "',";
			MyData = MyData + "'ErrorID':'" + err.toString() + "','EmailAddrType':'" + atype + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			if (!IsContentsNullUndefEmptyTx(MyReturn, 1)) {




			}
			return false;
		}

		function UpdateEmailTemplate(id, code, nm, subj, body, format, tt, nt, eto, impt, sens, iuser, imgr, iloc, iprod, isku, ientity, itrans, ttype, act) {
			var url = "../shared/AdminServices.asmx/UpdateEmailTemplate";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','TemplateID':'" + id.toString() + "','Code':'" + code + "','Name':'" + nm + "','Subj':'" + subj + "','Body':'" + body + "',";
			MyData = MyData + "'TransType':'" + tt.toString() + "','NotifType':'" + nt.toString() + "','EmailToType':'" + eto.toString() + "','Importance':'" + impt.toString() + "','Sensitivity':'" + sens.toString() + "',";
			MyData = MyData + "'IncUser':'" + iuser.toString() + "','IncMgr':'" + imgr.toString() + "','IncLoc':'" + iloc.toString() + "','IncProd':'" + iprod.toString() + "','IncSKU':'" + isku.toString() + "',";
			MyData = MyData + "'IncEnt':'" + ientity.toString() + "','IncTrans':'" + itrans.toString() + "','Fmt':'" + format.toString() + "','Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
			alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			if (!IsContentsNullUndefEmptyTx(MyReturn, 1)) {



			}
			return false;
		}

		function UpdateNotification(id, code, typ, sendnodata, aas, act) {
			var url = "../shared/AdminServices.asmx/UpdateNotificationType";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ID':'" + id.toString() + "','Code':'" + code + "','sType':'" + typ + "','SendIfNoData':'" + sendnodata.toString() + "','AfterActSQL':'" + aas + "',";
			MyData = MyData + "'Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			return false;
		}

		function EmailAddressDeletion(id) {
			var url = "../shared/AdminServices.asmx/DeleteEmailAddress";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','EmailAddrID':'" + id.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			if (!IsContentsNullUndefEmptyTx(MyReturn, 1)) {


			}
			return false;
		}

		function EmailTemplateDeletion(id) {
			var url = "../shared/AdminServices.asmx/DeleteManagementItem";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ID':'" + id.toString() + "','iType':'2','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			if (!IsContentsNullUndefEmptyTx(MyReturn, 1)) {


			}
			return false;
		}

		function DeleteNotification(id) {
			var url = "../shared/AdminServices.asmx/DeleteManagementItem";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ID':'" + id.toString() + "','iType':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			if (!IsContentsNullUndefEmptyTx(MyReturn, 1)) {



			}
			return false;
		}

		function SendEmail(acode, id, tcode, to, cc, bcc, grp, subj, bdy, imp, sens, fmt, logemail, emps, act) {
			// sanatize subj/bdy
			subj = PrepareJSONStringValueTx(subj, 0);
			bdy = PrepareJSONStringValueTx(bdy, 0);

			var url = "../shared/AdminServices.asmx/SendEmail";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'5','AppCode':'" + acode + "','EmailID':'" + id.toString() + "','TemplateCode':'" + tcode + "','EmailTo':'" + to + "','EmailCC':'" + cc + "','EmailBCC':'" + bcc + "',";
			MyData = MyData + "'Grp':'" + grp + "','Subj':'" + subj + "','Body':'" + bdy + "','Impt':'" + imp + "','Sens':'" + sens + "','Fmt':'" + fmt + "','LogEmail':'" + logemail.toString() + "','EmpIDs':'" + emps + "',";
			MyDadta = MyData + "'Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			if (!IsContentsNullUndefEmptyTx(MyReturn, 1)) {
				if (parseInt(MyReturn[0]['StatusID'], 10) === 0) {
					alert('Your message was sent.');
				}
				else {
					alert('A condition was identified: ' + MyReturn[0]['StatusMsg'].toString());
				}
			}
			else {
				alert('Unexpected response from the database. Your message was probably not sent.');
			}
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

		function PopulateEmailAddressList() {
			//alert('populating...');
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
			var td;
			var tr;
			var vAlign = 'top';
			var val = '';
			var Visbl = true;
			var wdth = 100
			var sResults = '';
			// Cols: 0-ID, 1-EmailAddr, 2-UserID, 3-NotificationType, 4-Error, 5-AddrType, 6-Active, 7-Action
			var cWidth = [60, 260, 70, 120, 60, 80, 70, 80, 50, 50, 50];
			var corient = ['left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left'];
			var bdy = document.createElement('tbody');

			if (MyEmailAddressList !== undefined && MyEmailAddressList !== null) {
				var nrows = MyEmailAddressList.length;
				if (nrows > 0) {
					NbrRows = parseInt(MyEmailAddressList[0]['NbrRows'], 10);
					jiNbrPagesPj[0] = parseInt(MyEmailAddressList[0]['NbrPages'], 10);
					jiNbrRowsPj[0] = parseInt(MyEmailAddressList[0]['NbrRows'], 10);
					for (var row = 0; row < nrows; row++) {
						tr = document.createElement("tr");
						td = document.createElement("td");
						td.id = "tdEmailAddrGridCol00";
						td.innerHTML = MyEmailAddressList[row]['EmailAddressID'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdEmailAddrGridCol01";
						td.innerHTML = MyEmailAddressList[row]['EmailAddress'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'left';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdEmailAddrGridCol02";
						td.innerHTML = MyEmailAddressList[row]['UserID'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdEmailAddrGridCol03";
						td.innerHTML = MyEmailAddressList[row]['NotificationType'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'left';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdEmailAddrGridCol04";
						td.innerHTML = MyEmailAddressList[row]['ErrorCondition'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdEmailAddrGridCol05";
						td.innerHTML = MyEmailAddressList[row]['EmailAddrType'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdEmailAddrGridCol06";
						td.innerHTML = MyEmailAddressList[row]['sActive'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdEmailAddrGridCol07";
						val = '<button id="btnEditEmail' + row.toString() +  '" class="button blue-gradient glossy" onclick="javascript:EmailAddressEdit(' + MyEmailAddressList[row]['EmailAddressID'].toString() + ',' + row.toString() + ');return false;">Edit</button>';
						val = val + '<button id="btnDelEmail' + row.toString() + '" class="button blue-gradient glossy" onclick="javascript:EmailAddressDelete(' + MyEmailAddressList[row]['EmailAddressID'].toString() + ',' + row.toString() + ');return false;" style="margin-left:2px;">Del</button>';
						td.innerHTML = val;
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						bdy.appendChild(tr);
					}

					joPaginationBarPj.style.display = 'none';
					if (NbrRows > nrows) {
						joPaginationBarPj.style.display = 'block';
					}
				}
				else {
					jlStatusMsg.innerHTML = 'No Email addresses were found that matched that criteria.';
					joPaginationBarPj.style.display = 'none';
				}
			}
			else {
				jlStatusMsg.innerHTML = 'Email addresses could not be extracted because of an unknown error.';
			}
			//alert('Attaching body');
			try {
				var oldBody = jtblEmailAddresses.getElementsByTagName("tbody")[0];
				jtblEmailAddresses.replaceChild(bdy, oldBody);
			}
			catch (ex) {

			}
			return false;
		}

		function PopulateEmailTemplateList() {
			//alert('populating...');
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
			var rowTotal = 0;
			var ShowStrat = 1;
			var ShowTac = 1;
			var td;
			var tr;
			var vAlign = 'top';
			var val = '';
			var Visbl = true;
			var wdth = 100
			var sResults = '';
			// 0-ID, 1-Code, 2-Name, 3-Subj, 4-TransType, 5-NotifType, 6-EmailTo, 7-Importance, 8-Sensitivity, 9-15-Includes, 16-CreatedOn, 17-ModifiedOn, 18-Active, 19-action
			// widths: 60, i70, 140, 200, 60, 60, 70, 60, 60, 60, 60, 60, 60, 60, 60, 60, 70, 70, 70, 70
			jiNbrRows = 0;
			jiTotalRows = 0;
			var bdy = document.createElement('tbody');

			if (MyEmailTemplateList !== undefined && MyEmailTemplateList !== null) {
				var nrows = MyEmailTemplateList.length;
				//alert(nrows);
				if (nrows > 0) {
					var cWidth = [60, 70, 140, 200, 60, 60, 70, 60, 60, 60, 60, 60, 60, 60, 60, 60, 70, 70, 70, 70, 70, 100, 100];
					var corient = ['left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left'];
					var LastVals = createArrayInitGu(15, 0);
					var NoDups = createArrayInitGu(NbrCols, 1);
					//alert('setting initial page - ' + NbrRows);
					jiNbrPagesPj[0] = parseInt(MyEmailTemplateList[0]['NbrPages'], 10);
					jiTotalRows = parseInt(MyEmailTemplateList[0]['NbrRows'], 10);
					//alert('2');
					jiPageNbr = 0;
					//alert('beginning rows - ' + nrows);
					for (var row = 0; row < nrows; row++) {
						//alert('Row ' + row.toString());
						rowTotal = 0;
						lineTotal = 0;
						jiNbrRows++;
						//alert('Col 0');
						tr = document.createElement("tr");
						tr.id = 'trEmailTemplRow' + row.toString();
						td = document.createElement("td");
						td.id = "tdEmailTemplGridCol00"; 
						td.innerHTML = MyEmailTemplateList[row]['EmailTemplateID'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdEmailTemplGridCol01";
						td.innerHTML = MyEmailTemplateList[row]['TemplateCode'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'left';
						tr.appendChild(td);
						//alert('Col 2');
						td = document.createElement("td");
						td.id = "tdEmailTemplGridCol02";
						td.innerHTML = MyEmailTemplateList[row]['TemplateName'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'left';
						td.style.whiteSpace = 'nowrap';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdEmailTemplGridCol03";
						td.innerHTML = MyEmailTemplateList[row]['Subject'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'left';
						td.style.whiteSpace = 'nowrap';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdEmailTemplGridCol04";
						td.innerHTML = MyEmailTemplateList[row]['TransType'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						//alert('Col 5');
						td = document.createElement("td");
						td.id = "tdEmailTemplGridCol05";
						td.innerHTML = MyEmailTemplateList[row]['NotifType'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdEmailTemplGridCol06";
						td.innerHTML = MyEmailTemplateList[row]['EmailToType'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdEmailTemplGridCol07";
						td.innerHTML = MyEmailTemplateList[row]['ImportanceLvl'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdEmailTemplGridCol08";
						td.innerHTML = MyEmailTemplateList[row]['SensitivityLvl'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						//alert('Col 9');
						td = document.createElement("td");
						td.id = "tdEmailTemplGridCol09";
						td.innerHTML = MyEmailTemplateList[row]['Col9'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdEmailTemplGridCol10";
						td.innerHTML = MyEmailTemplateList[row]['Col10'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdEmailTemplGridCol11";
						td.innerHTML = MyEmailTemplateList[row]['Col11'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						//alert('Col 12');
						td = document.createElement("td");
						td.id = "tdEmailTemplGridCol12";
						td.innerHTML = MyEmailTemplateList[row]['Col12'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						//alert('Col 13');
						td = document.createElement("td");
						td.id = "tdEmailTemplGridCol13";
						td.innerHTML = MyEmailTemplateList[row]['Col13'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						//alert('Col 14');
						td = document.createElement("td");
						td.id = "tdEmailTemplGridCol14";
						td.innerHTML = MyEmailTemplateList[row]['Col14'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						//alert('Col 15');
						td = document.createElement("td");
						td.id = "tdEmailTemplGridCol15";
						td.innerHTML = MyEmailTemplateList[row]['Col15'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						//alert('Col 16');
						td = document.createElement("td");
						td.id = "tdEmailTemplGridCol16";
						td.innerHTML = MyEmailTemplateList[row]['sCreatedOn'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdEmailTemplGridCol17";
						td.innerHTML = MyEmailTemplateList[row]['sModifiedOn'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdEmailTemplGridCol18";
						td.innerHTML = MyEmailTemplateList[row]['sActive'].toString();
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						//alert('Col 19');
						td = document.createElement("td");
						td.id = "tdEmailTemplGridCol19";
						val = '<button id="btnEmailTemplateEdit" class="button blue-gradient glossy" onclick="javascript:EmailTemplateEdit(' + MyEmailTemplateList[row]['EmailTemplateID'].toString() + ',' + row.toString() + ');return false;">Edit</button>';
						val = val + '<button id="btnEmailTemplateDel" class="button blue-gradient glossy" onclick="javascript:EmailTemplateDelete(' + MyEmailTemplateList[row]['EmailTemplateID'].toString() + ',' + row.toString() + ');return false;">Del</button>';
						td.innerHTML = val;
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						bdy.appendChild(tr);
					}
					//alert('attached rows to body');
					if (jiNbrRows < jiTotalRows) {
					}
					else {
						joPaginationBarPj2.style.display = 'none';
					}
				}
				else {
					alert('Template data could not be extracted because of an unidentified error.');
				}
			}
			else {

			}

			//alert('Attaching body Rows:' + bdy.rows.length);
			try {
				var oldBody = jtblEmailTemplates.getElementsByTagName("tbody")[0];
				jtblEmailTemplates.replaceChild(bdy, oldBody);
			}
			catch (ex) {
				alert('Error encountered when inserting body of data into data grid:' + ex.message);
			}
			//alert('checking nbr rows - ' + NbrRows);
			if (jiNbrRows === 0) {
				jlStatusMsg.innerHTML = 'No data matches that criteria.';
			}

			//alert(jiTotalRows + '/' + jiNbrRows);
			if (jiTotalRows > jiNbrRows) {
				alert('More Rows!');
				joPgNbrLblPj2.innerHTML = (jiPgNbrPj[1] + 1).toString();
				joMaxPgNbrLblPj2.innerHTML = jiNbrPagesPj[1].toString();
				joPaginationBarPj2.style.display = 'block';
			}
			return false;
		}

		function PopulateEmailTemplateSelect() {
			GetEmailTemplateList(0, '', '', '', '');
			if (MyEmailTemplateList !== undefined && MyEmailTemplateList !== null) {
				ClearDDLOptionsGu('selEmailTemplateSE', 1);
				fillDropDownListGu(MyEmailTemplateList, jselEmailTemplateSE, 0, 'TemplateName', 'EmailTemplateID');
			}
			return false;
		}

		function PopulateEmailTrafficGrid() {
			//alert('populating...');
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
			var td;
			var tr;
			var vAlign = 'top';
			var val = '';
			var Visbl = true;
			var wdth = 100
			var sResults = '';
			// Cols: 0-Database, 1-ID, 2-Template, 3-Subject, 4-To, 5-CC, 6-BCC, 7-Originated, 8-Sent, 9-Action
			var cWidth = [80, 70, 120, 200, 120, 120, 100, 110, 70, 70, 50, 50];
			var corient = ['left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left'];
			var bdy = document.createElement('tbody');
			if (MyEmailTraffic !== undefined && MyEmailTraffic !== null) {
				var nrows = MyEmailTraffic.length;
				if (nrows > 0) {
					for (var row = 0; row < nrows; row++) {
						tr = document.createElement("tr");
						td = document.createElement("td");
						td.id = "tdEmailTrafficCol00";
						td.innerHTML = MyEmailTraffic[row]['EmailAddressID'].toString();
						tr.className = 'StdTableCell';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdEmailTrafficCol01";
						td.innerHTML = MyEmailTraffic[row]['EmailAddress'].toString();
						tr.className = 'StdTableCell';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdEmailTrafficCol02";
						td.innerHTML = MyEmailTraffic[row]['UserID'].toString();
						tr.className = 'StdTableCell';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdEmailTrafficCol03";
						td.innerHTML = MyEmailTraffic[row]['NotificationType'].toString();
						tr.className = 'StdTableCell';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdEmailTrafficCol04";
						td.innerHTML = MyEmailTraffic[row]['ErrorCondition'].toString();
						tr.className = 'StdTableCell';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdEmailTrafficCol05";
						td.innerHTML = MyEmailTraffic[row]['EmailAddrType'].toString();
						tr.className = 'StdTableCell';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdEmailTrafficCol06";
						td.innerHTML = MyEmailTraffic[row]['sActive'].toString();
						tr.className = 'StdTableCell';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdEmailTrafficCol07";
						val = '<button id="" class="button blue-gradient glossy" onclick="javascript:EmailTrafficView(' + MyEmailTraffic[row]['EmailAddressID'].toString() + ',' + row.toString() + ');return false;">Edit</button>';
						td.innerHTML = val;
						tr.className = 'StdTableCell';
						tr.appendChild(td);
						bdy.appendChild(tr);
					}
				}
				else {
					jlStatusMsg.innerHTML = 'No Email addresses were found that matched that criteria.';
				}
			}
			else {
				jlStatusMsg.innerHTML = 'Email addresses could not be extracted because of an unknown error.';
			}
			//alert('Attaching body');
			try {
				var oldBody = jtblEmailTraffic.getElementsByTagName("tbody")[0];
				jtblEmailTraffic.replaceChild(bdy, oldBody);
			}
			catch (ex) {

			}
			return false;
		}

		function PopulateNotificationDropDown() {
			GetNotificationsList(0);
			if (MyNotificationsList !== undefined && MyNotificationsList !== null) {
				ClearDDLOptionsGu('selNotificationTypeF', 1);
				fillDropDownListGu(MyNotificationsList, jselNotificationTypeF, 0, 'NotificationType', 'NotificationTypeID');
				ClearDDLOptionsGu('selNotificationType2F', 1);
				fillDropDownListGu(MyNotificationsList, jselNotificationType2F, 0, 'NotificationType', 'NotificationTypeID');
				ClearDDLOptionsGu('selNotificationTypeForAddrE', 1);
				fillDropDownListGu(MyNotificationsList, jselNotificationTypeForAddr, 0, 'NotificationType', 'NotificationTypeID');
				ClearDDLOptionsGu('selNotificationTypeE', 1);
				fillDropDownListGu(MyNotificationsList, jselNotificationTypeE, 0, 'NotificationType', 'NotificationTypeID');
			} 
			return false;
		}

		function PopulateNotificationDropDown2() {
			jselNotificationTypeForAddrE2 = document.getElementById('selNotificationTypeForAddrE2');
			if (MyNotificationsList !== undefined && MyNotificationsList !== null) {
				ClearDDLOptionsGu('selNotificationTypeForAddrE2', 1);
				fillDropDownListGu(MyNotificationsList, jselNotificationTypeForAddrE2, 0, 'NotificationType', 'NotificationTypeID');
			}
		}

		function PopulateNotificationTypeGrid() {
			//alert('populating...');
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
			var td;
			var tr;
			var vAlign = 'top';
			var val = '';
			var Visbl = true;
			var wdth = 100
			var sResults = '';
			// Cols: 0-ID, 1-Code, 2-Type, 3-Active, 4-Action
			var cWidth = [60, 70, 120, 80, 80, 50, 50];
			var corient = ['left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left'];
			var bdy = document.createElement('tbody');

			if (MyNotificationsList !== undefined && MyNotificationsList !== null) {
				var nrows = MyNotificationsList.length;
				if (nrows > 0) {
					for (var row = 0; row < nrows; row++) {
						tr = document.createElement("tr");
						td = document.createElement("td");
						td.id = "tdNotificationGridCol00";
						td.innerHTML = MyNotificationsList[row]['NotificationTypeID'].toString();
						td.className = 'StdTableCell';
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdNotificationGridCol01";
						td.innerHTML = MyNotificationsList[row]['NotificationTypeCode'].toString();
						td.className = 'StdTableCell';
						td.style.border = '1px solid gray';
						td.style.textAlign = 'left';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdNotificationGridCol02";
						td.innerHTML = MyNotificationsList[row]['NotificationType'].toString();
						td.className = 'StdTableCell';
						td.style.border = '1px solid gray';
						td.style.textAlign = 'left';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdNotificationGridCol03";
						td.innerHTML = MyNotificationsList[row]['sActive'].toString();
						td.className = 'StdTableCell';
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						td = document.createElement("td");
						td.id = "tdNotificationGridCol04";
						val = '<button id="btnNotifEdit" class="button blue-gradient glossy" onclick="javascript:NotificationsEdit(' + MyNotificationsList[row]['NotificationTypeID'].toString() + ',' + row.toString() + ');return false;">Edit</button>';
						val = val + '<button id="btnNotifDelete" class="button blue-gradient glossy" onclick="javascript:NotificationsDelete(' + MyNotificationsList[row]['NotificationTypeID'].toString() + ',' + row.toString() + ');return false;" style="margin-left:2px;">Del</button>';
						val = val + '<button id="btnNotifViewEA" class="button blue-gradient glossy" onclick="javascript:EditEmailAddressesForNT(' + MyNotificationsList[row]['NotificationTypeID'].toString() + ',' + row.toString() + ');return false;" style="margin-left:2px;">Addrs</button>';
						td.innerHTML = val;
						td.className = 'StdTableCell';
						td.style.border = '1px solid gray';
						td.style.textAlign = 'center';
						tr.appendChild(td);
						bdy.appendChild(tr);
					}
				}
				else {
					jlStatusMsg.innerHTML = 'No notifications were found that matched that criteria.';
				}
			}
			else {
				jlStatusMsg.innerHTML = 'No notifications were returned because of an unknown error.';
			}
			//alert('Attaching body');
			try {
				var oldBody = jtblNotificationTypes.getElementsByTagName("tbody")[0];
				jtblNotificationTypes.replaceChild(bdy, oldBody);
			}
			catch (ex) {

			}
			return false;
		}

		function PopulateUserGroupList() {
			GetUserGroupList();
			if (MyUserGroupList !== undefined && MyUserGroupList !== null) {
				ClearDDLOptionsGu('selSendUserGroup', 1);
				fillDropDownListGu(MyUserGroupList, jselSendUserGroup, 0, 'UserGroup', 'UserGroupCode');
			}
			return false;
		}

		function PopulateUserListDropDown() {
			GetUserList('', '', 0, 1);
			if (MyUserList !== undefined && MyUserList !== null) {
				ClearDDLOptionsGu('selUserList', 1);
				fillDropDownListGu(MyUserList, jselUserList, 0, 'UserFullName', 'UserID');
			}
			return false;
		}

		function PopulateUserListDropDown2() {
			GetUserList('', '', 0, 1);
			//alert('here');
			jselUserList2 = document.getElementById('selUserList2');
			//alert('loading data');
			if (MyUserList !== undefined && MyUserList !== null) {
				ClearDDLOptionsGu('selUserList2', 1);
				fillDropDownListGu(MyUserList, jselUserList2, 0, 'UserFullName', 'UserID');
			}
		}

		// **************************** UI FUNCTIONS *********************************

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

		function EditEmailAddressesForNT(id, row) {
			jiTargetEmailAddrID = id;
			//alert('Fired dialog');
			var notiftype = MyNotificationsList[row]['NotificationType'].toString() + ' (' + MyNotificationsList[row]['NotificationTypeCode'].toString() + ')';
			var content = '';
			var hdrtitle = 'Email Addresses for ' + notiftype;
			var ht = 400;
			var wdth = 760;
			content = content + '<div id="divNotificationEmailEdit" style="width:100%;">' + FormNotifEmailsEditBlock(id) + '</div>';
			//alert('formed content');
			showPopupEditBoxDb('divMainPopup', hdrtitle, true, true, ht, wdth, '', '', window, content, 3, '11pt', '2px', 'fadeIn', 'fadeOut', 'MyDialogButtonStd', 'MyDialogStd', 5);
			PopulateUserListDropDown2();
			PopulateNotificationDropDown2();
			return false;
		}

		function FormNotifEmailsEditBlock(id) {
			GetEmailAddressList(id, 0, '', 1);
			//alert('got address list');
			var content = '';
			content = content + '<table id="tblNotificationEmails" style="padding:1px;border-spacing:0px;">';
			content = content + '<tr><th class="TableHdrCell" style="width:36px;">ID</th><th class="TableHdrCell" style="width:120px;">Email Address</th><th class="TableHdrCell" style="width:60px;">User ID</th>';
			content = content + '<th class="TableHdrCell" style="width:60px;">Error</th><th class="TableHdrCell" style="width:60px;">AddrType</th>';
			content = content + '<th class="TableHdrCell" style="width:60px;">Active</th><th class="TableHdrCell" style="width:120px;">Action</th></tr>';
			//alert('embedding addresses');
			if (MyEmailAddressList !== undefined && MyEmailAddressList !== null) {
				if (MyEmailAddressList.length > 0) {
					for (var rw = 0; rw < MyEmailAddressList.length; rw++) {
						content = content + '<tr><td class="StdTableCell">' + MyEmailAddressList[rw]['EmailAddressID'].toString() + '</td>';
						content = content + '<td class="StdTableCell">' + MyEmailAddressList[rw]['EmailAddress'].toString() + '</td>';
						content = content + '<td class="StdTableCell">' + MyEmailAddressList[rw]['UserID'].toString() + '</td>';
						content = content + '<td class="StdTableCell">' + MyEmailAddressList[rw]['ErrorCondition'].toString() + '</td>';
						content = content + '<td class="StdTableCell">' + MyEmailAddressList[rw]['EmailAddrType'].toString() + '</td>';
						content = content + '<td class="StdTableCell">' + MyEmailAddressList[rw]['sActive'].toString() + '</td>';
						content = content + '<td class="StdTableCell"><button id="btnNotifEmailAddrEdit" class="button blue-gradient glossy" onclick="javascript:NotifEmailAddressEdit(' + MyEmailAddressList[rw]['EmailAddressID'].toString() + ',' + rw.toString() + ');return false;">Edit</button>';
						content = content + '<button id="btnNotifEmailAddrDel" class="button blue-gradient glossy" onclick="javascript:NotifEmailAddressDelete(' + MyEmailAddressList[rw]['EmailAddressID'].toString() + ',' + rw.toString() + ');return false;">Remove</button></td></tr>';
					}
				}
				else {
					content = content + '<tr><td class="StdTableCell" colspan="7" style="text-align:center;">No email addresses for that notification type were found</td>';
				}
			}
			alert('addresses done');
			content = content + '</table><button id="btnAddNewEmailAddr2" class="button blue-gradient glossy" onclick="javascript:EmailAddressAddNew2();return false;">Add Email Address</button>';
			//alert('add new button added');
			// attach the emailaddr edit block
			content = content + '<div id="divEmailAddressEdit2" style="width:100%;display:none;padding:2px;">';
			content = content + '<label style="font-weight:bold;color:blue;font-size:13pt;">Edit Email Address:</label>&nbsp;-&nbsp;';
			content = content + 'ID:&nbsp;<label id="lblEmailAddrIDE2" style="color:blue;font-weight:bold;">0</label>';
			content = content + '<div id="divEditEmailAddress2" style="width:100%;background-color:blanchedalmond;text-align:center;padding:4px;">';
			content = content + '<table style="border:none;border-spacing:0px;padding:1px;margin:auto auto;">';
			//alert('1');
			content = content + '<tr><td style="text-align:right;">User:&nbsp;</td><td>';
			content = content + '<select id="selUserList2" onchange="javascript:ChangeUserSelected2(this.value);return false;">';
			content = content + '<option value="0" selected="selected">None Selected</option></select>';
			content = content + '</td><td>&nbsp;</td><td style="text-align:right;">Notification:&nbsp;</td><td>';
			content = content + '<select id="selNotificationTypeForAddrE2" ><option value="0" selected="selected">None Selected</option></select>';
			//alert('2');
			content = content + '</td></tr><tr><td style="text-align:right;">Error&nbsp;Condition:&nbsp;</td><td>';
			content = content + '<select id="selErrorTypeE2"><option value="0" selected="selected">All</option><option value="1">Failure</option><option value="2">Incomplete</option></select>';
			content = content + '</td><td>&nbsp;</td><td style="text-align:right;">AddrType:&nbsp;</td><td>';
			content = content + '<select id="selEAddressTypeE2"><option value="0" selected="selected">All</option><option value="TO">TO</option><option value="CC">CC</option><option value="BCC">BCC</option></select>';
			content = content + '</td></tr><tr><td style="text-align:right;">Active:&nbsp;</td><td>';
			content = content + '<select id="selEAddrActiveE2"><option value="0">No</option><option value="1" selected="selected">Yes</option></select>';
			//alert('3');
			content = content + '</td><td colspan="3">&nbsp;</td></tr><tr><td style="text-align:center;" colspan="5">';
			content = content + '<button id="btnSaveEmailAddress2" class="button blue-gradient glossy" onclick="javascript:SaveEmailAddress2();return false;">Save</button>&nbsp;';
			content = content + '<button id="btnCloseEmailAddressEdit2" class="button blue-gradient glossy" onclick="javascript:CloseEditBlock2();return false;">Close</button>&nbsp;';
			content = content + '</td></tr></table></div></div>';
			//alert('content done');
			return content;
		}

		// **************************** UI FUNCTIONS *********************************

		function ChangePageSize(val) {
		jiPageSize = parseInt(val, 10);
		refreshDataGrid();
		return false;
						}

		function ChangeEmailGroupData(val) {
			var inca = 0;
			var incg = 0;
			if (jchkIncludeAdmins.checked === true) { inca = 1; }
			if (jchkIncludeGlobals.checked === true) { incg = 1; }
			GetEmailAddresses('DataMngt', jsSendEmailGrp, inca, incg, 1);
			jlNbrUsersSend.innerHTML = '&nbsp;' + jiNbrEmails.toString() + '&nbsp;';
			jselSendUserGroup.title = jsEmailList;
			return false;
		}

		function ChangeSendEmailApp(val) {
			jsSendEmailApp = val;
			return false;
		}

		function ChangeSendEmailGroup(val) {
			jsSendEmailGrp = val;
			ChangeEmailGroupData(val);
			return false;
		}

		function ChangeSendIncludes() {
			ChangeEmailGroupData(jsSendEmailGrp);
			return false;
		}

		function ChangeUserSelected(val) {
			jsEmailAddress = '';
			var userid = parseInt(val, 10);
			if (MyUserList !== undefined && MyUserList !== null) {
				if (MyUserList.length > 0) {
					for (var row=0;row<MyUserList.length;row++) {
						if (parseInt(MyUserList[row]['UserID'], 10) === userid)	{
							jsEmailAddress = MyUserList[row]['EmailAddress'].toString();
							break;
						}
					}
				}
			}
			return false;
		}
		
		function ChangeUserSelected2(val) {
			jsEmailAddress2 = '';
			var userid = parseInt(val, 10);
			if (MyUserList !== undefined && MyUserList !== null) {
				if (MyUserList.length > 0) {
					for (var row = 0; row < MyUserList.length; row++) {
						if (parseInt(MyUserList[row]['UserID'], 10) === userid) {
							jsEmailAddress2 = MyUserList[row]['EmailAddress'].toString();
							break;
						}
					}
				}
			}
			return false;
		}

		function ChangeViewType(val) {
			//alert('Fired!');
			var code = '';
			var nm = '';
			HideAllAreas();
			jiCurrentGrid = parseInt(val);
			switch (jiCurrentGrid) {
				case 0: // nothing
					break;
				case 1: // addresses
					PopulateNotificationDropDown();
					var atype = jselAddressTypeF.value;
					GetEmailAddressList(0, 0, atype, 2);
					PopulateEmailAddressList();
					jdivEmailAddressEdit.style.display = 'none';
					jdivEmailAddresses.style.display = 'block';
					break;
				case 2: // templates
					code = '';
					nm = jtTemplateNameF.value;
					var subj = jtTemplateSubjectF.value;
					GetEmailTemplateList(0, code, nm, subj, '');
					PopulateEmailTemplateList();
					jdivEmailTemplateEdit.style.display = 'none';
					jdivEmailTemplates.style.display = 'block';
					//alert('Done!');
					break;
				case 3: // traffic
					GetEmailTraffic();
					PopulateEmailTrafficGrid();
					jdivEmailTraffic.style.display = 'block';
					break;
				case 4: //notification
					GetNotificationsList(0);
					PopulateNotificationTypeGrid();
					jdivNotificationsEdit.style.display = 'none';
					jdivNotificationTypes.style.display = 'block';
					break;
				case 5:	// Send email
					jsSendEmailApp = 'DataMngt';
					jsSendEmailGrp = '0';
					PopulateUserGroupList();
					PopulateEmailTemplateSelect();
					GetEmailAddresses('DataMngt', '', 0, 0, 1);
					jlNbrUsersSend.innerHTML = '&nbsp;' + jiNbrEmails.toString() + '&nbsp;';
					jdivSendEmail.style.display = 'block';
					break;
				default:
					break;
			}
			return false;
		}

		function ClearEmailText() {
			jtxaSendEmailSubj.value = '';
			jtxaSendEmailText.value = '';
			return false;
		}

		function CloseEditBlock() {
			switch (jiCurrentGrid) {
				case 0: // nothing
					break;
				case 1: // addresses
					jdivEmailAddressEdit.style.display = 'none';
					break;
				case 2: // templates
					jdivEmailTemplateEdit.style.display = 'none';
					break;
				case 3: // traffic
					// nothing
					break;
				case 4: //notification
					jdivNotificationsEdit.style.display = 'none';
					break;
				default:
					break;
			}
			return false;
		}

		function CloseEditBlock2() {
			document.getElementById('divEmailAddressEdit2').style.display = 'none';
			return false;
		}

		function HideAllAreas() {
			jdivEmailAddresses.style.display = 'none';
			jdivEmailTemplateEdit.style.display = 'none';
			jdivEmailTemplates.style.display = 'none';
			jdivEmailTraffic.style.display = 'none';
			jdivNotificationsEdit.style.display = 'none';
			jdivNotificationTypes.style.display = 'none';
			jdivSendEmail.style.display = 'none';
			return false;
		}

		function EmailAddressAddNew() {
			document.getElementById('lblEmailAddrIDE').value = '0';
			document.getElementById('selUserList').value = '0';
			document.getElementById('selNotificationTypeForAddrE').value = '0';
			document.getElementById('selErrorTypeE').value = '0';
			document.getElementById('selEAddressTypeE').value = '0';
			document.getElementById('selEAddrActiveE').value = '1';
			jdivEmailAddressEdit.style.display = 'block';
			return false;
		}

		function EmailAddressAddNew2() {
			document.getElementById('lblEmailAddrIDE2').value = '0';
			document.getElementById('selUserList2').value = '0';
			document.getElementById('selNotificationTypeForAddrE2').value = '0';
			document.getElementById('selErrorTypeE2').value = '0';
			document.getElementById('selEAddressTypeE2').value = '0';
			document.getElementById('selEAddrActiveE2').value = '1';
			document.getElementById('divEmailAddressEdit2').style.display = 'block';
			return false;
		}

		function EmailAddressDelete(id, row) {
			if (confirm('This will permanently delete this address. Are you sure?')) {
				EmailAddressDeletion(id);
				refreshDataGrid();
			}
			return false;
		}

		function EmailAddressEdit(id, row) {
			document.getElementById('lblEmailAddrIDE').value = MyEmailAddressList[row]['EmailAddressID'].toString();
			document.getElementById('selUserList').value = MyEmailAddressList[row]['UserID'].toString();
			document.getElementById('selNotificationTypeForAddrE').value = MyEmailAddressList[row]['NotificationTypeID'].toString();
			document.getElementById('selErrorTypeE').value = MyEmailAddressList[row]['ErrorCondition'].toString();
			document.getElementById('selEAddressTypeE').value = MyEmailAddressList[row]['EmailAddrType'].toString();
			//alert(MyEmailAddressList[row]['EmailAddrType'].toString());
			if (MyEmailAddressList[row]['sActive'].toString() === 'Yes') {
				document.getElementById('selEAddrActiveE').value = '1';
			}
			else {
				document.getElementById('selEAddrActiveE').value = '0';
			}
			jdivEmailAddressEdit.style.display = 'block';
			return false;
		}

		function EmailTemplateAddNew() {
			document.getElementById('lblEmailTemplateIDE').value = '0';
			document.getElementById('txtTemplateCodeE').value = '';
			document.getElementById('txtTemplateNameE').value = '';
			document.getElementById('txtEmailSubjectE').value = '';
			document.getElementById('selEmailFormatE').value = '0';
			document.getElementById('selEmailImportanceE').value = '0';
			document.getElementById('selEmailSensitivityE').value = '0';
			document.getElementById('selTransitionTypeE').value = '0';
			document.getElementById('selNotificationTypeE').value = '0';
			document.getElementById('chkUserIncE').checked = false;
			document.getElementById('chkMgrIncE').checked = false;
			document.getElementById('chkLocIncE').checked = false;
			document.getElementById('chkProdIncE').checked = false;
			document.getElementById('chkSKUIncE').checked = false;
			document.getElementById('chkEntityIncE').checked = false;
			document.getElementById('chkTransIncE').checked = false;
			document.getElementById('selTransTypeE').value = '0';
			document.getElementById('selEmailSentToE').value = '0';
			document.getElementById('selEmailTempActiveE').value = '1';
			document.getElementById('txaEmailBodyE').value = '';
			jdivEmailTemplateEdit.style.display = 'block';
			return false;
		}

		function EmailTemplateDelete(id, row) {
			if (confirm('This will permanently delete this email template. Are you sure?')) {
				EmailTemplateDeletion(id);
				refreshDataGrid();
			}
			return false;
		}

		function EmailTemplateEdit(id, row) {
			//alert(id);
			if (parseInt(id, 10) > 0) {
				document.getElementById('lblEmailTemplateIDE').value = MyEmailTemplateList[row]['EmailTemplateID'].toString();
				//alert('1');
				document.getElementById('txtTemplateCodeE').value = MyEmailTemplateList[row]['TemplateCode'].toString();
				document.getElementById('txtTemplateNameE').value = MyEmailTemplateList[row]['TemplateName'].toString();
				document.getElementById('txtEmailSubjectE').value = MyEmailTemplateList[row]['Subject'].toString();
				//alert('2');
				document.getElementById('selEmailFormatE').value = MyEmailTemplateList[row]['FormatStyle'].toString();
				document.getElementById('selEmailImportanceE').value = MyEmailTemplateList[row]['ImportanceLvl'].toString();
				document.getElementById('selEmailSensitivityE').value = MyEmailTemplateList[row]['SensitivityLvl'].toString();
				//alert('3');
				document.getElementById('selTransitionTypeE').value = MyEmailTemplateList[row]['TransTypeID'].toString();
				document.getElementById('selNotificationTypeE').value = MyEmailTemplateList[row]['NotifType'].toString();
				document.getElementById('selTransTypeE').value = MyEmailTemplateList[row]['TransType'].toString();
				//alert('4');
				document.getElementById('selEmailSentToE').value = MyEmailTemplateList[row]['EmailToType'].toString();
				document.getElementById('selEmailTempActiveE').value = MyEmailTemplateList[row]['IsActive'].toString();
				document.getElementById('txaEmailBodyE').value = MyEmailTemplateList[row]['Body'].toString();
				//alert('5');
				if (MyEmailTemplateList[row]['Col9'].toString() === 'Yes') {
					document.getElementById('chkUserIncE').checked = true;
				}
				else {
					document.getElementById('chkUserIncE').checked = false;
				}
				if (MyEmailTemplateList[row]['Col10'].toString() === 'Yes') {
					document.getElementById('chkMgrIncE').checked = true;
				}
				else {
					document.getElementById('chkMgrIncE').checked = false;
				}
				if (MyEmailTemplateList[row]['Col11'].toString() === 'Yes') {
					document.getElementById('chkLocIncE').checked = true;
				}
				else {
					document.getElementById('chkLocIncE').checked = false;
				}
				if (MyEmailTemplateList[row]['Col12'].toString() === 'Yes') {
					document.getElementById('chkProdIncE').checked = true;
				}
				else {
					document.getElementById('chkProdIncE').checked = false;
				}
				if (MyEmailTemplateList[row]['Col13'].toString() === 'Yes') {
					document.getElementById('chkSKUIncE').checked = true;
				}
				else {
					document.getElementById('chkSKUIncE').checked = false;
				}
				if (MyEmailTemplateList[row]['Col14'].toString() === 'Yes') {
					document.getElementById('chkEntityIncE').checked = true;
				}
				else {
					document.getElementById('chkEntityIncE').checked = false;
				}
				if (MyEmailTemplateList[row]['Col15'].toString() === 'Yes') {
					document.getElementById('chkTransIncE').checked = true;
				}
				else {
					document.getElementById('chkTransIncE').checked = false;
				}
			}
			jdivEmailTemplateEdit.style.display = 'block';
			return false;
		}

		function EmailTrafficView(id, row) {


		}

		function NotificationAddNew() {
			document.getElementById('lblNotificationIDE').innerHTML = '0';
			document.getElementById('txtNotificationCodeE').value = '';
			document.getElementById('txtNotificationTypeE').value = '';
			document.getElementById('selNotificationActiveE').value = '0';
			return false;
		}

		function NotifEmailAddressDelete(id, row) {
			FormNotifEmailsEditBlock(jiTargetEmailAddrID);
			document.getElementById('divNotificationEmailEdit').innerHTML = FormNotifEmailsEditBlock();
			return false;
		}

		function NotifEmailAddressEdit(id, row) {
			document.getElementById('lblEmailAddrIDE2').value =  MyEmailAddressList[row]['EmailAddressID'].toString();
			document.getElementById('selUserList2').value = MyEmailAddressList[row]['UserID'].toString();
			document.getElementById('selNotificationTypeForAddrE2').value = MyEmailAddressList[row]['NotificationTypeID'].toString();
			document.getElementById('selErrorTypeE2').value = MyEmailAddressList[row]['ErrorCondition'].toString();
			document.getElementById('selEAddressTypeE2').value = MyEmailAddressList[row]['EmailAddrType'].toString();
			if (MyEmailAddressList[row]['sActive'].toString() === 'Yes') {
				document.getElementById('selEAddrActiveE2').value = '1';
			}
			else {
				document.getElementById('selEAddrActiveE2').value = '0';
			}
			document.getElementById('divEmailAddressEdit2').style.display = 'block';
			return false;
		}

		function NotificationsEdit(id, row) {
			if (parseInt(id, 10) > 0) {
				document.getElementById('lblNotificationIDE').innerHTML = MyNotificationsList[row]['NotificationTypeID'].toString();
				document.getElementById('txtNotificationCodeE').value = MyNotificationsList[row]['NotificationTypeCode'].toString();
				document.getElementById('txtNotificationTypeE').value = MyNotificationsList[row]['NotificationType'].toString();
				if (MyNotificationsList[row]['sActive'].toString() === 'Yes') {
					document.getElementById('selNotificationActiveE').value = '1';
				}
				else {
					document.getElementById('selNotificationActiveE').value = '0';
				}
			}
			jdivNotificationsEdit.style.display = 'block';
			return false;
		}

		function NotificationsDelete(id, row) {
			if (confirm('This will permanently delete this notification. Are you sure?')) {
				DeleteNotification(id);
				refreshDataGrid();
			}
		}

		function refreshDataGrid() {
			switch (jiCurrentGrid) {
				case 0: // nothing
					break;
				case 1: // addresses
					//alert('4');
					var notifid = jselNotificationTypeF.value;
					var err = jselErrorTypeF.value;
					var addr = jtEmailAddressF.value;
					var atype = jselAddressTypeF.value;
					GetEmailAddressList(notifid, err, atype, 2);
					PopulateEmailAddressList();
					break;
				case 2: // templates
					nm = jtTemplateNameF.value;
					var subj = jtTemplateSubjectF.value;
					GetEmailTemplateList(0, code, nm, subj, '');
					PopulateEmailTemplateList();
					break;
				case 3: // traffic
					GetEmailTraffic();
					PopulateEmailTrafficGrid();
					break;
				case 4: //notification
					GetNotificationsList(sort);
					PopulateNotificationTypeGrid();
					break;
				case 5:
					break;
				default:
					break;
			}
			return false;
		}

		function SaveEmailAddress() {
			//MakeSecureHTMLCodeMinTx(val);
			var id = CleanNbrValTx(document.getElementById('lblEmailAddrIDE').value);
			var userid = parseInt(document.getElementById('selUserList').value, 10);
			var notif = parseInt(document.getElementById('selNotificationTypeForAddrE').value);
			var err = parseInt(document.getElementById('selErrorTypeE').value, 10);
			var atype = CleanTextToSecureTx(document.getElementById('selEAddressTypeE').value);
			act = parseInt(document.getElementById('selEAddrActiveE').value, 10);
			UpdateEmailAddress(id, jsEmailAddress, userid, notif, err, atype, act);
			return false;
		}

		function SaveEmailAddress2() {
			//MakeSecureHTMLCodeMinTx(val);
			var id = CleanNbrValTx(document.getElementById('lblEmailAddrIDE2').value);
			var userid = parseInt(document.getElementById('selUserList2').value, 10);
			var notif = parseInt(document.getElementById('selNotificationTypeForAddrE2').value);
			var err = parseInt(document.getElementById('selErrorTypeE2').value, 10);
			var atype = CleanTextToSecureTx(document.getElementById('selEAddressTypeE2').value);
			act = parseInt(document.getElementById('selEAddrActiveE2').value, 10);
			UpdateEmailAddress(id, jsEmailAddress2, userid, notif, err, atype, act);
			return false;
		}

		function SaveEmailTemplate() {
			alert('saving');
			var id = document.getElementById('lblEmailTemplateIDE').innerHTML;
			var code = document.getElementById('txtTemplateCodeE').value;
			var nm = document.getElementById('txtTemplateNameE').value;
			alert('1');
			var subj = document.getElementById('txtEmailSubjectE').value;
			var body = document.getElementById('txaEmailBodyE').value;
			var fmt = document.getElementById('selEmailFormatE').value;
			if (fmt === '') { fmt = 'html';}
			alert('2 - ' + fmt);
			var impt = document.getElementById('selEmailImportanceE').value;
			if (impt === '') { impt = 'normal';}
			var sens = document.getElementById('selEmailSensitivityE').value;
			if (sens === '') { sens = 'normal'; }
			var trans = document.getElementById('selTransitionTypeE').value;
			var notif = document.getElementById('selNotificationTypeE').value;
			var iuser = 0;
			var imgr = 0;
			var iloc = 0;
			var iprod = 0;
			var isku = 0;
			var ientity = 0;
			var itrans = 0;
			alert('3 - '+ impt + '/' + sens);
			if (document.getElementById('chkUserIncE').checked === true) { iuser = 1; };
			if (document.getElementById('chkMgrIncE').checked === true) { imgr = 1; };
			if (document.getElementById('chkLocIncE').checked === true) { iloc = 1; };
			if (document.getElementById('chkProdIncE').checked === true) { iprod = 1; };
			//alert('4');
			if (document.getElementById('chkSKUIncE').checked === true) { isku = 1; };
			if (document.getElementById('chkEntityIncE').checked === true) { ientity = 1; };
			if (document.getElementById('chkTransIncE').checked === true) { itrans = 1; };
			//alert('5');
			var ttype = document.getElementById('selTransTypeE').value;
			var eto = document.getElementById('selEmailSentToE').value;
			var act = document.getElementById('selEmailTempActiveE').value;
			//alert('updating');
			UpdateEmailTemplate(id, code, nm, subj, body, fmt, trans, notif, eto, impt, sens, iuser, imgr, iloc, iprod, isku, ientity, itrans, ttype, act);
			GetEmailTemplateList(0, '', '', '', '');
			PopulateEmailTemplateList();
			jdivEmailTemplateEdit.style.display = 'none';
			return false;
		}

		function SaveNotification() {
			var id = parseInt(document.getElementById('lblNotificationIDE').innerHTML, 10);
			var code = StripInsecureTextCharsTx(document.getElementById('txtNotificationCodeE').value);
			var type = StripInsecureTextCharsTx(document.getElementById('txtNotificationTypeE').value);
			var act = document.getElementById('selNotificationActiveE').value;
			var sendnodata = 0;
			if (document.getElementById('chkSendIfNoData').checked === true) { sendnodata = 1; }
			var aas = EncodeSingleQuotesTx(document.getElementById('txaAfterActionSQL').value);
			UpdateNotification(id, code, type, sendnodata, aas, act);
			return false;
		}

		function SetEmailTemplateData(val) {
			var val = '';
			if (val !== '0') {
				if (confirm('This will replace your text and subject data. Continue?')) {
					var id = parseInt(val, 10);
					var app = jselSendEmailApp.value;
					var grp = jselSendUserGroup.value;
					GetEmailTemplateList(id, '', '', '', '');
					if (!IsContentsNullUndefEmptyTx(MyEmailTemplateList, 1)) {
						val = MyEmailTemplateList[0]['Subject'].toString();
						jtxaSendEmailSubj.value = val;
						val = val.replace('[APPNAME]', app).replace('[GROUPNAME]', grp);
						val = MyEmailTemplateList[0]['Body'].toString();
						val = val.replace('[APPNAME]', app).replace('[GROUPNAME]', grp);
						jtxaSendEmailText.value = val;
					}
				}
			}
			return false;
		}

		function SendEmail() {
			var subj = document.getElementById('txaSendEmailSubj').value;
			var body = document.getElementById('txaSendEmailText').value;
			var acode = document.getElementById('selSendEmailApp').value;
			var grp = document.getElementById('selSendUserGroup').value;
			//;
			var id = document.getElementById('lblEmailID').innerHTML;
			var imp = document.getElementById('selEmailImportanceSEE').value;
			var sens = document.getElementById('selEmailSensitivitySEE').value;
			var cc = document.getElementById('txtEmailCC').value;
			var bcc = document.getElementById('txtEmailBCC').value;
			var tcode = document.getElementById('selEmailTemplateSE').value;
			var fmt = document.getElementById('selEmailFormatSE').value;
			var act = document.getElementById('selEmailActiveSE').value;
			SendEmail(acode, id, tcode, jsEmailList, cc, bcc, grp, subj, body, imp, sens, fmt, 1, '', act);
			return false;
		}

		// **************************** Off-Page *********************************

		function GotoQuickAccessPage() {
			document.location.href = '../prod/ForecastTool.aspx';
			return false;
		}

	</script>

  <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />

</head>
<body>
	<img id="imgSessionKeepAlive" width="1" height="1" style="display:none;" src="../Images/clearpixel.gif" />
  <form id="form1" runat="server">
  <asp:ScriptManager runat="server"></asp:ScriptManager>
	<asp:HiddenField ID="hfPageID" runat="server" Value="59" />

	<div id="divMainPopup" style="display:none;"></div>

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

			<div id="divPAGEHEADER" style="width:99%;margin-left:10px;margin-bottom:10px;">
				<div id="divCalendarTitle" style="width:100%;">
					<label id="lblWebCalHdrTitle" class="LabelGridHdrStd" style="font-size:12pt;">Email Management:</label>
					<label id="lblPageStatus" style="position:absolute;font-size:10pt;font-weight:bold;color:darkgray;right:70px;">Page Loading...</label>
				</div>
				<div id="divMainHdrSelects" style="width:100%;text-align:center;background-color:gainsboro;padding-top:4px;padding-bottom:4px;">
					<label id="lblMainHdrSelectItem" style="color:blue;font-weight:bold;font-size:12pt;">Edit or View Data:</label>&nbsp;
					<select id="selEditViewType" style="font-size:12pt;" onchange="javascript:ChangeViewType(this.value);return false;">
						<option value="0" selected="selected">None Selected</option>
						<option value="1">Email Addresses</option>
						<option value="2">Email Templates</option>
						<option value="3">Email Traffic</option>
						<option value="4">Notification Types</option>
						<option value="5">Send Group Email</option>
					</select>
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
				</div>

			</div>

			<div id="divPAGEMAINCONTENT" style="width:99%;margin-left:10px;">
				<!-------------------------------------------- Edit DIVs ---------------------------------------------------->

				<div id="divEmailAddressEdit" style="width:100%;display:none;padding:2px;">
					<label id="lblEmailAddressEdit" style="font-weight:bold;color:blue;font-size:13pt;">Edit Email Address:</label>&nbsp;-&nbsp;ID:&nbsp;<label id="lblEmailAddrIDE" style="color:blue;font-weight:bold;">0</label>
					<div id="divEditEmailAddress" style="width:100%;background-color:blanchedalmond;text-align:center;padding:4px;">
						<table style="border:none;border-spacing:0px;padding:1px;margin:auto auto;">
						<tr>
							<td style="text-align:right;">
								User:&nbsp;
							</td>
							<td>
								<select id="selUserList" onchange="javascript:ChangeUserSelected(this.value);return false;">
									<option value="0" selected="selected">None Selected</option>
								</select>
							</td>
							<td>&nbsp;</td>
							<td style="text-align:right;">
								Notification:&nbsp;
							</td>
							<td>
								<select id="selNotificationTypeForAddrE" >
									<option value="0" selected="selected">None Selected</option>
								</select>
							</td>
						</tr>
						<tr>
							<td style="text-align:right;">
								Error&nbsp;Condition:&nbsp;
							</td>
							<td>
								<select id="selErrorTypeE">
									<option value="0" selected="selected">All</option>
									<option value="1">Failure</option>
									<option value="2">Incomplete</option>
								</select>
							</td>
							<td>&nbsp;</td>
							<td style="text-align:right;">
								AddrType:&nbsp;
							</td>
							<td>
								<select id="selEAddressTypeE">
									<option value="0" selected="selected">All</option>
									<option value="TO">TO</option>
									<option value="CC">CC</option>
									<option value="BCC">BCC</option>
								</select>
							</td>
						</tr>
						<tr>
							<td style="text-align:right;">
								Active:&nbsp;
							</td>
							<td>
								<select id="selEAddrActiveE">
									<option value="0">No</option>
									<option value="1" selected="selected">Yes</option>
								</select>
							</td>
							<td>&nbsp;</td>
							<td style="text-align:right;">
								&nbsp;
							</td>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr>
							<td style="text-align:center;" colspan="5">
								<button id="btnSaveEmailAddress" class="button blue-gradient glossy" onclick="javascript:SaveEmailAddress();return false;">Save</button>&nbsp;
								<button id="btnCloseEmailAddressEdit" class="button blue-gradient glossy" onclick="javascript:CloseEditBlock();return false;">Close</button>&nbsp;
							</td>
						</tr>
						</table>

					</div>
				</div>

				<div id="divEmailTemplateEdit" style="width:100%;display:none;margin-bottom:10px;background-color:blanchedalmond;padding:2px;">
					<label id="lblEmailTemplateEdit" style="font-weight:bold;color:blue;font-size:13pt;">Edit Email Template:</label>&nbsp;&nbsp;-&nbsp;&nbsp;ID:&nbsp;<label id="lblEmailTemplateIDE" style="color:blue;font-weight:bold;">0</label>
					<div id="divEditEmailTemplate" style="width:100%;background-color:blanchedalmond;text-align:center;padding-bottom:4px;">
						<table >
						<tr>
							<td style="width:70%;">

								<table style="padding:1px;border-spacing:0px;border-collapse:collapse;margin:auto auto;">
								<tr>
									<td style="text-align:right;vertical-align:top;">
										Code:&nbsp;
									</td>
									<td style="text-align:left;vertical-align:top;">
										<input type="text" id="txtTemplateCodeE" style="width:160px;" />
									</td>
									<td>&nbsp;&nbsp;</td>
									<td style="text-align:right;vertical-align:top;">
										Name:&nbsp;
									</td>
									<td style="text-align:left;vertical-align:top;">
										<input type="text" id="txtTemplateNameE" style="width:260px;" />
									</td>
								</tr>
								<tr>
									<td style="text-align:right;vertical-align:top;">
										Subject:&nbsp;
									</td>
									<td colspan="4" style="text-align:left;vertical-align:top;">
										<input type="text" id="txtEmailSubjectE" style="width:740px;" />
									</td>
								</tr>
								<tr>
									<td style="text-align:right;vertical-align:top;">
										Format:&nbsp;
									</td>
									<td style="text-align:left;vertical-align:top;">
										<select id="selEmailFormatE" >
											<option value="html" selected="selected">HTML</option>
											<option value="text">Text</option>
										</select>
									</td>
									<td>&nbsp;&nbsp;</td>
									<td colspan="2" style="text-align:left;vertical-align:top;">
										Importance:&nbsp;<select id="selEmailImportanceE" >
											<option value="low">Low</option>
											<option value="normal" selected="selected">Normal</option>
											<option value="high">High</option>
										</select>&nbsp;&nbsp;-&nbsp;
										Sensitivity:&nbsp;<select id="selEmailSensitivityE" >
											<option value="normal" selected="selected">Normal</option>
											<option value="personal">Personal</option>
											<option value="private">Private</option>
											<option value="confidential">Confidential</option>
										</select>
									</td>
								</tr>
								<tr>
									<td style="text-align:right;vertical-align:top;">
										Transition Type:&nbsp;
									</td>
									<td style="text-align:left;vertical-align:top;">
										<select id="selTransitionTypeE" >
											<option value="0" selected="selected">None Selected</option>
										</select>
									</td>
									<td>&nbsp;&nbsp;</td>
									<td style="text-align:right;vertical-align:top;">
										Notification Type:&nbsp;
									</td>
									<td style="text-align:left;vertical-align:top;">
										<select id="selNotificationTypeE" >
											<option value="0" selected="selected">None Selected</option>
										</select>
									</td>
								</tr>
								<tr>
									<td style="text-align:right;vertical-align:top;">
										Include:&nbsp;
									</td>
									<td colspan="4" style="text-align:left;vertical-align:top;">
										User<input type="checkbox" id="chkUserIncE" />&nbsp;
										Mgr<input type="checkbox" id="chkMgrIncE" />&nbsp;
										Loc<input type="checkbox" id="chkLocIncE" />&nbsp;
										Product<input type="checkbox" id="chkProdIncE" />&nbsp;
										SKU<input type="checkbox" id="chkSKUIncE" />&nbsp;
										Entity<input type="checkbox" id="chkEntityIncE" />&nbsp;
										Trans<input type="checkbox" id="chkTransIncE" />&nbsp;Trans Type:&nbsp;
										<select id="selTransTypeE">
											<option value="0" selected="selected">none selected</option>
											<option value="1">Orders</option>
											<option value="5">Requests-Invoice Adjust</option>
											<option value="6">Requests-Credit Exception</option>
											<option value="2">Product/SKU Inventory</option>
											<option value="3">Tag</option>
											<option value="4">Price Change</option>
										</select>
									</td>
								</tr>
								<tr>
									<td style="text-align:right;vertical-align:top;">
										Email sent to:&nbsp;
									</td>
									<td style="text-align:left;vertical-align:top;">
										<select id="selEmailSentToE" >
											<option value="0" selected="selected">None Selected</option>
											<option value="Emp">Staff Member</option>
											<option value="Mgr">Supervisor</option>
											<option value="QA">Quality Assurance</option>
											<option value="HR">HR</option>
											<option value="FIN">Finance</option>
											<option value="AR">AR</option>
											<option value="AP">AP</option>
											<option value="OTH">Other</option>
										</select>
									</td>
									<td>&nbsp;&nbsp;</td>
									<td style="text-align:right;vertical-align:top;">
										Active:&nbsp;
									</td>
									<td style="text-align:left;vertical-align:top;">
										<select id="selEmailTempActiveE" >
											<option value="1" selected="selected">Yes</option>
											<option value="0">No</option>
										</select>
									</td>
								</tr>
								<tr>
									<td style="text-align:right;vertical-align:top;">
										Body:&nbsp;
									</td>
									<td colspan="4" style="text-align:left;vertical-align:top;">
										<textarea id="txaEmailBodyE" cols="100" rows="40" style="width:900px;height:400px;word-wrap:normal;vertical-align:top;"></textarea>
									</td>
								</tr>
								<tr>
									<td colspan="5" style="text-align:center;">
										<button id="btnSaveEmailTemplate" class="button blue-gradient glossy" onclick="javascript:SaveEmailTemplate();return false;">Save</button>&nbsp;
										<button id="btnCloseEmailTemplate" class="button blue-gradient glossy" onclick="javascript:CloseEditBlock();return false;">Close</button>&nbsp;
									</td>
								</tr>
								</table>

							</td>
							<td style="width:30%;text-align:left;vertical-align:top;">
								<label style="color:green;font-weight:bold;">Help:</label><br />
								<table style="padding:0px;border-spacing:0px;">
								<tr>
									<td style="width:40px;">
										<label style="color:green;font-weight:bold;">1.</label>&nbsp;
									</td>
									<td>
										 Subject and Body can have embedded fields that are dynamically filled from database. Embedded fields must have a [ prefix and an ] suffix. Normal standards are to use upper case for field names within [].
									</td>
								</tr>
								<tr>
									<td style="width:40px;">
										<label style="color:green;font-weight:bold;">2.</label>&nbsp;
									</td>
									<td>
										Standard data is automatically loaded into standard variables from the database based on certain fields submitted. If you turn on includes, the data for that submitted ID will be automatically loaded into
										the stored procedure. Check the User checkbox and submit a UserID and user data is automatically loaded and the standard user-oriented embedded fields will be replaced with database data.
									</td>
								</tr>
								</table>
							</td>
						</tr>
						</table>

					</div>

				</div>

				<div id="divNotificationsEdit" style="width:100%;display:none;background-color:blanchedalmond;padding:2px;">
					<label id="lblNotificationsEdit" style="font-weight:bold;color:blue;font-size:13pt;">Edit Email Address:</label>&nbsp;-&nbsp;ID:&nbsp;<label id="lblNotificationIDE" style="color:blue;font-weight:bold;">0</label>
					<div id="divEditNotification" style="width:100%;background-color:blanchedalmond;text-align:center;">
						<table style="border:none;border-spacing:0px;">
						<tr>
							<td>Code:&nbsp;</td>
							<td><input id="txtNotificationCodeE" style="width:120px;" /></td>
							<td>&nbsp;</td>
							<td>Notification Type:&nbsp;</td>
							<td><input type="text" id="txtNotificationTypeE" style="width:300px;" /></td>
						</tr>
						<tr>
							<td>Active:&nbsp;</td>
							<td>
								<select id="selNotificationActiveE" >
									<option value="1" selected="selected">Yes</option>
									<option value="0">No</option>
								</select>
							</td>
							<td>&nbsp;</td>
							<td>Send If No Data:&nbsp;</td>
							<td><input type="checkbox" id="chkSendIfNoData" /></td>
						</tr>
						<tr>
							<td>After&nbsp;Action&nbsp;SQL:&nbsp;</td>
							<td colspan="4">
								<textarea id="txaAfterActionSQL" style="width:500px;height:60px;"></textarea>
							</td>
						</tr>
						<tr>
							<td style="text-align:center;" colspan="5">
								<button id="btnSaveNotification" class="button blue-gradient glossy" onclick="javascript:SaveNotification();return false;">Save</button>&nbsp;
								<button id="btnCloseNotificationEdit" class="button blue-gradient glossy" onclick="javascript:CloseEditBlock();return false;">Close</button>&nbsp;
							</td>
						</tr>
						</table>
					</div>
				</div>

				<!-------------------------------------------- Main Grids ---------------------------------------------------->

				<div id="divEmailAddresses" style="width:100%;margin-bottom:10px;display:none;">
					<table style="width:100%;padding:1px;border-spacing:0px;border:none;margin-bottom:4px;">
					<tr>
						<td style="width:50%;">
							<label id="lblEmailAddresses" style="font-weight:bold;color:blue;font-size:13pt;">Email Address Management:</label>
						</td>
						<td style="width:50%;text-align:right;">
							<button id="btnAddNewEmailAddr" class="button blue-gradient glossy" onclick="javascript:EmailAddressAddNew();return false;" style="margin-right:10px;">Add New Address</button>
						</td>
					</tr>
					</table>
					<div id="divEmailAddressFilters" style="width:100%;text-align:center;margin-bottom:4px;">
						<table style="width:100%;padding:1px;border-spacing:0px;border:none;margin-bottom:4px;">
						<tr>
							<td style="text-align:center;">
								<label id="lblEmailAddressFilters" style="font-weight:bold;color:blue;">Filters:</label>&nbsp;
								Email&nbsp;Address:&nbsp;<input type="text"id="txtEmailAddressF" style="width:120px;" />&nbsp;&bull;&nbsp; 
								Notification:&nbsp;
								<select id="selNotificationTypeF">
									<option value="0" selected="selected">All</option>

								</select>&nbsp;&bull;&nbsp;
								Error:&nbsp;
								<select id="selErrorTypeF">
									<option value="0" selected="selected">All</option>
									<option value="1">Failure</option>
									<option value="2">Incomplete</option>
								</select>&nbsp;&bull;&nbsp;
								AddrType:&nbsp;
								<select id="selAddressTypeF">
									<option value="0" selected="selected">All</option>
									<option value="1">TO</option>
									<option value="2">CC</option>
									<option value="3">BCC</option>
								</select>
							</td>
						</tr>
						</table>
					</div>
					<div id="divEmailAddressOther" style="width:100%;text-align:center;margin-bottom:4px;">
						<table style="width:100%;padding:1px;border-spacing:0px;border:none;margin-bottom:4px;">
						<tr>
							<td style="text-align:center;">
								<label id="lblEmailAddresSort" style="font-weight:bold;color:blue;">Sort:</label>&nbsp;
								<select id="selMainSortOrder">
									<option value="0" selected="selected">Email Address</option>
									<option value="1">Notification Type</option>
									<option value="2">Address Type</option>
									<option value="3">Error Condition</option>
								</select>
								<span id="spnEARefreshButton" style="margin-left:20px;">
									<button id="btnEARefreshData" class="button blue-gradient glossy" onclick="javascript:refreshDataGrid();return false;" style="width:120px;">Refresh Data</button>
								</span>
							</td>
						</tr>
						</table>
					</div>

					<div id="divEmailAddressesDataGrid" style="width:100%;text-align:center;margin-top:6px;">
						<table id="tblEmailAddresses" style="text-align:left;padding:1px;border:1px solid gray;border-spacing:0px;border-collapse:collapse;margin:auto auto;">
						<thead id="tblEmailAddressesHd">
						<tr>
							<th id="thEmailAddrLCol100" class="TableHdrCell" style="width:56px;" rowspan="2">ID</th>
							<th id="thEmailAddrLCol101" class="TableHdrCell" style="width:270px;" rowspan="2">Email</th>
							<th id="thEmailAddrLCol102" class="TableHdrCell" style="width:66px;" rowspan="2">UserID</th>
							<th id="thEmailAddrLCol103" class="TableHdrCell" style="width:240px;" rowspan="2">Notification</th>
							<th id="thEmailAddrLCol104" class="TableHdrCell" style="width:54px;" rowspan="2">Error</th>
							<th id="thEmailAddrLCol105" class="TableHdrCell" style="width:80px;" rowspan="2">Addr Type</th>
							<th id="thEmailAddrLCol106" class="TableHdrCell" style="width:56px;" rowspan="2">Active</th>
							<th id="thEmailAddrLCol107" class="TableHdrCell" style="width:96px;" rowspan="2">Action</th>
						</tr>
						</thead>
						<tbody id="tblEmailAddressesBd">
						</tbody>
						<tfoot id="tblEmailAddressesFt">
						</tfoot>
						</table>
<!-- #include file="../inc/incPaginationDiv.inc" -->
					</div>			
				</div>

				<div id="divEmailTraffic" style="width:100%;margin-bottom:10px;display:none;">
					<div id="divEmailTrafficHdr" style="width:100%;">
						<table style="width:100%;padding:1px;border-spacing:0px;border:none;">
						<tr>
							<td style="width:100%;">
								<label id="lblEmailTraffic" style="font-weight:bold;color:blue;font-size:13pt;">Email Traffic:</label>
							</td>
							<td style="width:100%;">
								Filter:&nbsp;Database:&nbsp;
								<select id="selDatabaseIDf">
									<option value="0">All</option>
									<option value="nwhbus">Business Support</option>
									<option value="nwhdw">NWH Data Warehouse</option>
								</select>
							</td>
						</tr>
						</table>
					</div>

					<div id="divEmailTrafficDataGrid" style="width:100%;">
						<table id="tblEmailTraffic" style="padding:1px;border-spacing:0px;border-collapse:collapse;">
						<thead id="tblEmailTrafficHd">
						<tr>
							<th id="thEmailTraffCol00" class="TableHdrCell" style="width:80px;">Database</th>
							<th id="thEmailTraffCol01" class="TableHdrCell" style="width:70px;">ID</th>
							<th id="thEmailTraffCol03" class="TableHdrCell" style="width:120px;">Template</th>
							<th id="thEmailTraffCol04" class="TableHdrCell" style="width:200px;">Subject</th>
							<th id="thEmailTraffCol05" class="TableHdrCell" style="width:120px;">TO</th>
							<th id="thEmailTraffCol06" class="TableHdrCell" style="width:120px;">CC</th>
							<th id="thEmailTraffCol07" class="TableHdrCell" style="width:100px;">BCC</th>
							<th id="thEmailTraffCol08" class="TableHdrCell" style="width:110px;">Originated</th>
							<th id="thEmailTraffCol09" class="TableHdrCell" style="width:70px;">Sent</th>
							<th id="thEmailTraffCol10" class="TableHdrCell" style="width:70px;">Action</th>
						</tr>
						</thead>
						<tbody id="tblEmailTrafficBd">
						</tbody>
						<tfoot id="tblEmailTrafficFt">
						</tfoot>
						</table>
<!-- #include file="../inc/incPaginationDiv3.inc" -->
					</div>			
				</div>

				<div id="divNotificationTypes" style="width:100%;margin-bottom:10px;display:none;">
					<div id="divNotificationTypesHdr" style="width:100%;">
						<table style="padding:0px;border-spacing:0px;width:100%;">
						<tr>
							<td style="width:50%;">
								<label id="lblNotificationTypes" style="font-weight:bold;color:blue;font-size:13pt;">Notification Types:</label>
							</td>
							<td style="width:50%;">
								<button id="btnAddNotificationType" class="button blue-gradient glossy" onclick="javascript:NotificationAddNew();return false;">Add New Notification</button>
							</td>
						</tr>
						</table>
					</div>

					<div id="divNotificationTypesDataGrid" style="width:100%;text-align:center;">
						<table id="tblNotificationTypes" style="padding:1px;border-spacing:0px;border-collapse:collapse;margin:auto auto;">
						<thead id="tblNotificationTypesHd">
						<tr>
							<th id="thNotificationsCol100" class="TableHdrCell" style="width:52px;" rowspan="2">ID</th>
							<th id="thNotificationsCol101" class="TableHdrCell" style="width:80px;" rowspan="2">Code</th>
							<th id="thNotificationsCol102" class="TableHdrCell" style="width:240px;" rowspan="2">Type</th>
							<th id="thNotificationsCol103" class="TableHdrCell" style="width:70px;" rowspan="2">Active</th>
							<th id="thNotificationsCol104" class="TableHdrCell" style="width:156px;" rowspan="2">Action</th>
						</tr>
						</thead>
						<tbody id="tblNotificationTypesBd">
						</tbody>
						<tfoot id="tblNotificationTypesFt">
						</tfoot>
						</table>
<!-- #include file="../inc/incPaginationDiv4.inc" -->
					</div>			
				</div>

				<div id="divEmailTemplates" style="width:100%;margin-bottom:10px;display:none;">
					<table style="width:100%;padding:1px;border-spacing:0px;border:none;">
					<tr>
						<td style="width:50%;">
							<label id="lblEmailTemplates" style="font-weight:bold;color:blue;font-size:13pt;">Email Templates:</label>
						</td>
						<td style="width:50%;text-align:right;">
							<button id="btnAddNewEmailTemplate" class="button blue-gradient glossy" onclick="javascript:EmailTemplateAddNew();return false;">Add New Template</button>&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align:center;">
							<label id="lblEmailTemplateFilters" style="color:blue;font-weight:bold;">Filters:</label>&nbsp;Name:&nbsp;
							<input type="text"id="txtTemplateNameF" style="width:120px;" />, Subject:&nbsp;<input type="text"id="txtTemplateSubjectF" style="width:120px;" />
							Notification:&nbsp;
							<select id="selNotificationType2F">
								<option value="0" selected="selected">ALL</option>
							</select>
						</td>
					</tr>
					</table>
					<div id="divEmailTemplatesDataGrid" style="width:100%;text-align:center;margin-top:6px;">
						<table id="tblEmailTemplates" style="padding:1px;border-spacing:0px;border-collapse:collapse;font-family:Arial narrow; margin:auto auto;">
						<thead id="tblEmailTemplatesHd">
						<tr>
							<th id="thEmailAddrCol100" class="TableHdrCell" style="width:46px;" rowspan="2">ID</th>
							<th id="thEmailAddrCol101" class="TableHdrCell" style="width:86px;" rowspan="2">Code</th>
							<th id="thEmailAddrCol102" class="TableHdrCell" style="width:260px;" rowspan="2">Name</th>
							<th id="thEmailAddrCol103" class="TableHdrCell" style="width:420px;" rowspan="2">Subject</th>
							<th id="thEmailAddrCol104" class="TableHdrCell" style="width:46px;" rowspan="2">Trans Type</th>
							<th id="thEmailAddrCol105" class="TableHdrCell" style="width:46px;" rowspan="2">Notif Type</th>
							<th id="thEmailAddrCol106" class="TableHdrCell" style="width:62px;" rowspan="2">Email To</th>
							<th id="thEmailAddrCol107" class="TableHdrCell" style="width:60px;" rowspan="2">Importnc</th>
							<th id="thEmailAddrCol108" class="TableHdrCell" style="width:56px;" rowspan="2">Sensitv</th>
							<th id="thEmailAddrCol109" class="TableHdrCell" style="width:296px;" colspan="7">Include</th>
							<th id="thEmailAddrCol116" class="TableHdrCell" style="width:74px;" rowspan="2">Created</th>
							<th id="thEmailAddrCol117" class="TableHdrCell" style="width:74px;" rowspan="2">Modified</th>
							<th id="thEmailAddrCol118" class="TableHdrCell" style="width:52px;" rowspan="2">Active</th>
							<th id="thEmailAddrCol119" class="TableHdrCell" style="width:96px;" rowspan="2">Action</th>
						</tr>
						<tr>
							<th id="thEmailAddrCol209" class="TableHdrCell" style="width:42px;">User</th>
							<th id="thEmailAddrCol210" class="TableHdrCell" style="width:42px;">Mgr</th>
							<th id="thEmailAddrCol211" class="TableHdrCell" style="width:42px;">Loc</th>
							<th id="thEmailAddrCol212" class="TableHdrCell" style="width:42px;">Prod</th>
							<th id="thEmailAddrCol213" class="TableHdrCell" style="width:42px;">SKU</th>
							<th id="thEmailAddrCol214" class="TableHdrCell" style="width:42px;">Entity</th>
							<th id="thEmailAddrCol215" class="TableHdrCell" style="width:42px;">Trans</th>
						</tr>
						</thead>
						<tbody id="tblEmailTemplatesBd">
						</tbody>
						<tfoot id="tblEmailTemplatesFt">
						</tfoot>
						</table>
<!-- #include file="../inc/incPaginationDiv2.inc" -->
					</div>			
				</div>

				<div id="divSendEmail" style="width:100%;margin-bottom:10px;display:none;text-align:center;">
					<div id="divSendEmailHdr" style="width:100%;">
						<table style="padding:1px;border-spacing:0px;border:none;margin: auto auto;">
						<tr>
							<td style="width:30%;text-align:left;">
								<label id="lblSendEmailHdr" style="font-weight:bold;color:darkred;font-size:13pt;">Send Email Function:</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</td>
							<td style="width:80%;text-align:left;">
								<label id="lblSendEmailApp" style="color:blue;font-weight:bold;">Application:</label>&nbsp;
								<select id="selSendEmailApp" onchange="javascript:ChangeSendEmailApp(this.value);return false;">
									<option value="0">None Selected</option>
									<option value="DataMngt" selected="selected">Data Mngt (this web app)</option>
									<option value="Hits">HITS</option>
								</select>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align:center;">
								<label id="lblSendEmailGroup" style="color:blue;font-weight:bold;">User Group:</label>&nbsp;
								<select id="selSendUserGroup" onchange="javascript:ChangeSendEmailGroup(this.value);return false;">
									<option value="0" selected="selected">ALL Application User</option>
								</select>&nbsp;&nbsp;&nbsp;
								Nbr of users this email will be sent to:&nbsp;<label id="lblNbrUsersSend" style="color:blue;font-weight:bold;border:1px solid white;">&nbsp;</label>
							</td>
						</tr>
						</table>

					</div>
					<div id="divSendEmailEdit" style="width:100%;text-align:center;">
						<table style="padding:1px;border-spacing:0px;margin: auto auto;" >
						<tr>
							<td style="vertical-align:middle;" colspan="2">
								<label id="lblSendEmailID" style="color:darkgreen;">ID:</label>&nbsp;<label id="lblEmailID" style="color:blue;font-weight:bold;">0</label>&nbsp;&nbsp;-&nbsp;&nbsp;
								CC:&nbsp;<input type="text" id="txtEmailCC" style="width:200px;" />&nbsp;&nbsp;&bull;&nbsp;&nbsp;
								BCC:&nbsp;<input type="text" id="txtEmailBCC" style="width:140px;" />&nbsp;&nbsp;&bull;&nbsp;&nbsp;
								Include&nbsp;Admins:<input type="checkbox" id="chkIncludeAdmins" onchange="javascript:ChangeSendIncludes();return false;" />&nbsp;
								Globals:<input type="checkbox" id="chkIncludeGlobals" onchange="javascript:ChangeSendIncludes();return false;" />
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<div id="divSendEmailEditBtn" style="padding:2px;vertical-align:middle;text-align:center;">
									<button id="btnSendEmail" class="button blue-gradient glossy" onclick="javascript:SendEmail();return false;" style="width:100px;color:lightgoldenrodyellow;">Send Email</button>
									<button id="btnClearEmail" class="button blue-gradient glossy" onclick="javascript:ClearEmailText();return false;" style="margin-left:10px;margin-right:20px;">Clear Email</button>
									Template:&nbsp;<select id="selEmailTemplateSE" onchange="javascript:SetEmailTemplateData(this.value);return false;">
										<option value="0" selected="selected">None Selected</option>
									</select>&nbsp;
								</div>
							</td>
						</tr>
						<tr>
							<td style="vertical-align:middle;">
								Subject:&nbsp;
							</td>
							<td>
								<textarea id="txaSendEmailSubj"	style="width:860px;height:40px;font-family:Arial;font-size:11pt;color:black;">
								</textarea>
							</td>
						</tr>
						<tr>
							<td style="vertical-align:top;">
								Body:&nbsp;
							</td>
							<td>
								<textarea id="txaSendEmailText"	style="width:860px;height:580px;font-family:Arial;font-size:11pt;color:black;">
								</textarea>
							</td>
						</tr>
						<tr>
							<td colspan="2" style="text-align:center;">
								Importance:&nbsp;<select id="selEmailImportanceSEE" >
									<option value="low">Low</option>
									<option value="normal" selected="selected">Normal</option>
									<option value="high">High</option>
								</select>&nbsp;&nbsp;-&nbsp;
								Sensitivity:&nbsp;<select id="selEmailSensitivitySEE" >
									<option value="normal" selected="selected">Normal</option>
									<option value="personal">Personal</option>
									<option value="private">Private</option>
									<option value="confidential">Confidential</option>
								</select>&nbsp;&nbsp;-&nbsp;
								Format:&nbsp;<select id="selEmailFormatSE" >
									<option value="1" selected="selected">HTML</option>
									<option value="0">Text</option>
								</select>&nbsp;&nbsp;-&nbsp;
								Active:&nbsp;<select id="selEmailActiveSE" >
									<option value="1" selected="selected">Yes</option>
									<option value="0">No</option>
								</select>
							</td>
						</tr>
						<tr>
							<td style="text-align:center;" colspan="2">
							</td>
						</tr>
						</table>
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
