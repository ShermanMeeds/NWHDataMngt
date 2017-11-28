<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InvoiceAdj.aspx.cs" Inherits="DataMngt.finance.InvoiceAdj" %>

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
		var jbAllLocations = false;
		var jbLoadedCarrierList = false;
		var jbLoadedCreditRepList = false;
		var jbLoadedCustomerList = false;
		var jbLoadedInvoiceItems = false;
		var jbLoadedSalesLeadList = false;
		var jbLoadedLocationList = false;
		var jbLoadedDestinationList = false;
		var jbLoadedProdCodeList = false;
		var jbLoadedProdTypeList = false;
		var jbLoadedSalesLeadList = false;
		var jbLoadedSalesStaffList = false;
		var jbLoadedReasonList = false;
		var jbPaginate = false;
		var jbShowInvAdj = false;
		var jbShowRManf = false;
		var jbtnAddItemLine;
		var jbtnAddNewTicket;
		var jbtnAddNewType2;
		var jbtnCompleteReq;
		var jbtnFindRequest;
		var jbtnFindInvoiceNbr;
		var jbtnInvChgEditSave;
		var jbtnNewInvAdj;
		var jbtnSaveRequest;
		var jbtnSendToPDF;
		var jbViewOnly = true;
		var jchkAPNotificationMI;
		var jchkCriticalImportance;
		var jchkCustReqCopyE;
		var jchkFreightAccrualE;
		var jchkInvoiceAdjE;
		var jchkManInvAdjMI;
		var jchkRtnManifest;
		var jchkManualCDNoteE;
		var jchkRevisedInvCopyM;
		var jchkVendorClaimE;
		var jdivCustClaim;
		var jdivDocStatusChanges;
		var jdivFindInvAdj;
		var jdivFormBlank;
		var jdivFormFooter;
		var jdivFreightAccrual;
		var jdivHideBottomLine;
		var jdivInvAdjManifest;
		var jdivInventoryChangeItem;
		var jdivInventoryChangeReq;
		var jdivFormAttachments;
		var jdivLossAndDamageClaim;
		var jdivMACAdjustment;
		var jdivManualCredit;
		var jdivStatusMsg;
		var jdivTab1;
		var jdivTab2;
		var jdivTab3;
		var jdivTabHdr1;
		var jdivTabHdr2;
		var jdivTabHdr3;
		var jdivVendorClaim;
		var jdToday = new Date();
		var jfInvoiceAdjAmount = 0;
		var jfInvoiceAmtNew = 0;
		var jfInvoiceAmtOrig = 0;
		var jfPageTotal = 0;
		var jhfCustCodeE;
		var jhfCustCodeLAD;
		var jhfCustCodeM;
		var jhfInvoiceDate;
		var jhfInvoiceID;
		var jhfReqByIDE;
		var jhfRequestedByIDM;
		var jhfRequestID;
		var jhfSubmittedByIDCC;
		var jiAddLineIDX = 16;
		var jiAddTicketIDX = 40;
		var jiAR = 0;
		var jiByID = 0;
		var jiDocRightLevel = 0;
		var jiDocumentType = 0;
		var jiInvoiceID = 0;
		var jiInvoiceReqID = 0;
		var jiMinDocumentType = 0;
		var jiNbrCols = 0;
		var jiNbrDocs = 0;
		var jiNbrLinesInventoryAdj = 0;
		var jiNbrLinesLAD = 3;
		var jiNbrLinesMAC = 1;
		var jiNbrLinesShownIA = 5;
		var jiNbrLinesShownRM = 5;
		var jiNbrPages = 0;
		var jiNbrProdsIA = 5;
		var jiNbrProdsLAD = 3;
		var jiNbrProdsMAC = 1;
		var jiNbrProdsRM = 5;
		var jiNbrRows = 0;
		var jiOrderNbr = 0;
		var jiPageID = 22;
		var jiPageNbr = 0;
		var jiPageSize = 20;
		var jiPageSize2 = 20;
		var jiRequestID = 0;
		var jiTableRowIdxRM = 39;
		var jiTotalRows = 0;
		var jiUserID = 0;
		var jlRequestIDE;
		var jlBuildNbr;
		var jlCurrentYearFtr;
		var jlIncludedSections;
		var jlRequestStatusH;
		var jlPageIDInhFooter;
		var jlPageStatus;
		var jlStatusMsg;
		var jlVersion;
		var jlVersionDate;
		var jsBrowserType = '';
		var jsCurrentTime = '';
		var jsDocumentStatus = 'U';
		var jselCreditRepE;
		var jselCreditRepM;
		var jselDocumentType;
		var jselLocationMAC;
		var jselNbrTypeLAndD;
		var jselProdTypeMACA;
		var jselProdTypeLAD1;
		var jselProdTypeLAD2;
		var jselProdTypeLAD3;
		var jselReasonCodeE;
		var jselReasonCodeM;
		var jselRtnCarrierM;
		var jselSalesLeadE;
		var jselSalesLeadM;
		var jselSalesRepE;
		var jselSetNewStatus;
		var jselShipFmLocationE;
		var jselShipFMLocationM;
		var jselShipTOLocationM;
		var jsDocName = '';
		var jsDocType = '';
		var jsErrorMsg = '';
		var jsGroups = '';
		var jsLocationCode = '';
		var jsPageVersion = '';
		var jsPageVersDate = '';
		var jspnAddNewSection;
		var jspnAttachMessage;
		var jspnClockNV;
		var jspnCurrDateNV;
		var jspnDocumentTypeLabel;
		var jspnDocumentTypeList;
		var jspnExportToPDFbtn;
		var jspnRightAttachDrop;
		var jspnSaveRequest;
		var jsProdType = '';
		var jsStartDate = '';
		var jsStatusCode = '';
		var jsToday = '';
		var jsUserName = '';
		var jtaGenCommentIAE;
		var jtaReasonForAdjE;
		var jtaRtnReasonM;
		var jtActRtnDateM;
		var jtAdjInvoiceAmt;
		var jtAdjustmentAmt;
		var jtblAttachmentsList;
		var jtblCustClaim;
		var jtblInvAdjForm;
		var jtblInvChangeItems;
		var jtblLADProducts;
		var jtblMACAdjustment;
		var jtblStatusList;
		var jtCustNameE;
		var jtCustNameM;
		var jtCustNbrE;
		var jtCustomerNbrM;
		var jtDateReqE;
		var jtDriverDateZ;
		var jtDriverZ;
		var jtDriverSignatureZ;
		var jtEmailsToInclude;
		var jtFindInvoiceNbr;
		var jtInvoiceNbrE;
		var jtInvoiceNbrM;
		var jtLoadedByZ;
		var jtLoadDateZ;
		var jtLoadSignatureZ;
		var jtOrigInvoiceAmt;
		var jtReceivedDateZ;
		var jtReceivedSignatureZ;
		var jtReceivedByZ;
		var jtReqByE;
		var jtReqRtnDateM;
		var jtRequestedByM;
		var jtRequiredDateE;
		var jtRtnFreightRateM;
		var jtSONbrE;
		var jtSONbrM;
		var jtSubmittedByCC;
		var jtSubmittedOnCC;
		var jtTransOrderNbrM;

		var MyAttachmentList;
		var MyCarrierList;
		var MyCreditRepList;
		var MyCustomerData;
		var MyDestinationList;
		var MyDocStatChanges;
		var MyDocStatFlow;
		var MyDocTypeAssociations;
		var MyInventoryItemData;
		var MyInvRequestData;
		var MyInvoiceData;
		var MyInvoiceItems;
		var MyLocationList;
		var MyPersPositionList;
		var MyProdTypeCodeList;
		var MyProdTypeList;
		var MyProductList;
		var MyReasonList;
		var MyRequestData;
		var MySalesLeadList;
		var MySalesPersList;

		var counter = 0;
		var DayNamesNV = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
		var jiaInvoiceReqID = [0, 0, 0, 0, 0, 0];
		var jsaDocType = ['', '', '', '', '', ''];
		var jsaTypeCodes = ['NONE', '', 'INVADJ', 'RMANF', 'FRTACC', 'VENDCLM', 'LSSDMG', 'INVCHG', 'MACADJ', 'MNLCRED', 'CUSTCLM', '', ''];
		var jsaTypeNames = ['NONE', '', 'Invoice Adj', 'Rtn Manifest', 'Freight Acc', 'Vendor Claim', 'LossDmg Claim', 'Inventory Adj', 'MAC Adjust', 'Manual Credit', 'Cust Claim', '', ''];

		// page initiation section --------------------------------------------------------------------------------
		//#region PageInitiationR	JS
		$(document).ready(function () {
			jsToday = getMyDateTimeStringDm(jdToday, 18);
			jsCurrentTime = getMyDateTimeStringDm(jdToday, 7);
			//alert(jdToday + '/' + jsToday + '/' + jsCurrentTime);
			updateClockNV();
			KeepSessionAlive();

			// set global default values
			//alert('Ready starting');
			jiPageID = 22;
			jsPageVersion = '1.0.0';
			jsPageVersDate = '9/15/2017';
			jbViewOnly = true;
			//alert('loading seed values');
			// Load global page-loaded variables
			jiByID = jigEmpID;
			jsBrowserType = jsgBrowserType;
			jiInvoiceReqID = jigInvAdj;
			//alert(jsBrowserType);
			jiAR = jsgAR;
			if(jiAR > 4 || jgA === 1) {
				jbA = true;
				jiAR = 5;
				//alert('Admin');
			}
			if(jsgAr > 1) {
				jbAllLocations = true;
			}
			jsUserName = jsgNm;
			jsGroups = jsgGrps;
			//alert(jsUserName);
			$('#Form1').on("submit", function (evt) {
				evt.preventDefault();
			});

			jbtnAddItemLine = document.getElementById('btnAddItemLine');
			jbtnAddNewTicket = document.getElementById('btnAddNewTicket');
			jbtnAddNewType2 = document.getElementById('btnAddNewType2');
			jbtnFindRequest = document.getElementById('btnFindRequest');
			jbtnFindInvoiceNbr = document.getElementById('btnFindInvoiceNbr');
			jbtnInvChgEditSave = document.getElementById('btnInvChgEditSave');
			jbtnNewInvAdj = document.getElementById('btnNewInvRequest');
			jbtnSaveRequest = document.getElementById('btnSaveRequest');
			jbtnSendToPDF = document.getElementById('btnSendToPDF');
			jchkAPNotificationMI = document.getElementById('chkAPNotificationMI');
			jchkCriticalImportance = document.getElementById('chkCriticalImportance');
			jchkCustReqCopyE = document.getElementById('chkCustReqCopyE');
			jchkFreightAccrualE = document.getElementById('chkFreightAccrualE');
			jchkInvoiceAdjE = document.getElementById('chkInvoiceAdjE');
			jchkManInvAdjMI = document.getElementById('chkManInvAdjMI');
			jchkRtnManifest = document.getElementById('chkRtnManifest');
			jchkManualCDNoteE = document.getElementById('chkManualCDNoteE');
			jchkRevisedInvCopyM = document.getElementById('chkRevisedInvCopyM');
			jchkVendorClaimE = document.getElementById('chkVendorClaimE');
			jdivDocStatusChanges = document.getElementById('divDocStatusChanges');
			jdivFindInvAdj = document.getElementById('divFindInvAdj');
			jdivFormBlank = document.getElementById('divFormBlank');
			jdivFormFooter = document.getElementById('divFormFooter');
			jdivFreightAccrual = document.getElementById('divFreightAccrual');
			jdivHideBottomLine = document.getElementById('divHideBottomLine');
			jdivInvAdjManifest = document.getElementById('divInvAdjManifest');
			jdivInventoryChangeItem = document.getElementById('divInventoryChangeItem');
			jdivInventoryChangeReq = document.getElementById('divInventoryChangeReq');
			jdivFormAttachments = document.getElementById('divFormAttachments');
			jdivLossAndDamageClaim = document.getElementById('divLossAndDamageClaim');
			jdivMACAdjustment = document.getElementById('divMACAdjustment');
			jdivManualCredit = document.getElementById('divManualCredit');
			jdivCustClaim = document.getElementById('divCustClaim');
			jdivVendorClaim = document.getElementById('divVendorClaim');
			jdivStatusMsg = document.getElementById('divStatusMsg');
			jdivTab1 = document.getElementById('divTab1');
			jdivTab2 = document.getElementById('divTab2');
			jdivTab3 = document.getElementById('divTab3');
			jdivTabHdr1 = document.getElementById('divTabHdr1');
			jdivTabHdr2 = document.getElementById('divTabHdr2');
			jdivTabHdr3 = document.getElementById('divTabHdr3');
			jhfCustCodeE = document.getElementById('hfCustCodeE');
			jhfCustCodeLAD = document.getElementById('hfCustCodeLAD');
			jhfCustCodeM = document.getElementById('hfCustCodeM');
			jhfInvoiceDate = document.getElementById('hfInvoiceDate');
			jhfInvoiceID = document.getElementById('hfInvoiceID');
			jhfReqByIDE = document.getElementById('hfReqByIDE');
			jhfRequestedByIDM = document.getElementById('hfRequestedByIDM');
			jhfRequestID = document.getElementById('hfRequestID');
			jhfSubmittedByIDCC = document.getElementById('hfSubmittedByIDCC');
			jlRequestIDE = document.getElementById('lblRequestIDE');
			jlBuildNbr = document.getElementById('lblBuildNbr');
			jlCurrentYearFtr = document.getElementById('lblCurrentYearFtr');
			jlIncludedSections = document.getElementById('lblIncludedSections');
			jlRequestStatusH = document.getElementById('lblRequestStatusH');
			jlPageIDInhFooter = document.getElementById('lblPageIDInhFooter');
			jlStatusMsg = document.getElementById('lblStatusMsg');
			jselCreditRepE = document.getElementById('selCreditRepE');
			jselCreditRepM = document.getElementById('selCreditRepM');
			jselDocumentType = document.getElementById('selDocumentType');
			//jselProdCodeLAD1 = document.getElementById('selProdCodeLAD01');
			//jselProdCodeLAD2 = document.getElementById('selProdCodeLAD02');
			//jselProdCodeLAD3 = document.getElementById('selProdCodeLAD03');
			jselNbrTypeLAndD = document.getElementById('selNbrTypeLAndD');
			jselProdTypeMACA = document.getElementById('selProdTypeMACA');
			jselProdTypeLAD1 = document.getElementById('selProdTypeLAD01');
			jselProdTypeLAD2 = document.getElementById('selProdTypeLAD02');
			jselProdTypeLAD3 = document.getElementById('selProdTypeLAD03');
			jselReasonCodeE = document.getElementById('selReasonCodeE');
			jselReasonCodeM = document.getElementById('selReasonCodeM');
			jselRtnCarrierM = document.getElementById('selRtnCarrierM');
			jselSalesLeadE = document.getElementById('selSalesLeadE');
			jselSalesLeadM = document.getElementById('selSalesLeadM');
			jselSalesRepE = document.getElementById('selSalesRepE');
			jselSetNewStatus = document.getElementById('selSetNewStatus');
			jselShipFmLocationE = document.getElementById('selShipFmLocationE');
			jselShipFMLocationM = document.getElementById('selShipFMLocationM');
			jselShipTOLocationM = document.getElementById('selShipTOLocationM');
			jspnAddNewSection = document.getElementById('spnAddNewSection');
			jspnAttachMessage = document.getElementById('spnAttachMessage');
			jspnClockNV = document.getElementById('clockNV');
			jspnCurrDateNV = document.getElementById('spnCurrDateNV');
			jspnDocumentTypeLabel = document.getElementById('spnDocumentTypeLabel');
			jspnDocumentTypeList = document.getElementById('spnDocumentTypeList');
			jspnExportToPDFbtn = document.getElementById('spnExportToPDFbtn');
			jspnRightAttachDrop = document.getElementById('spnRightAttachDrop');
			jspnSaveRequest = document.getElementById('spnSaveRequest');
			jtaGenCommentIAE = document.getElementById('txaGenCommentIAE');
			jtaReasonForAdjE = document.getElementById('txaReasonForAdjE');
			jtaRtnReasonM = document.getElementById('txaRtnReasonM');
			jtActRtnDateM = document.getElementById('txtActRtnDateM');
			jtAdjInvoiceAmt = document.getElementById('txtAdjInvoiceAmt');
			jtAdjustmentAmt = document.getElementById('txtAdjustmentAmt');
			jtblAttachmentsList = document.getElementById('tblAttachmentsList');
			jtblCustClaim = document.getElementById('tblCustClaim');
			jtblInvAdjForm = document.getElementById('tblInvAdjForm');
			jtblInvChangeItems = document.getElementById('tblInvChangeItems');
			jtblLADProducts = document.getElementById('tblLADProducts');
			jtblMACAdjustment = document.getElementById('tblMACAdjustment');
			jtblStatusList = document.getElementById('tblStatusList');
			jtCustNameE = document.getElementById('txtCustNameE');
			jtCustNameM = document.getElementById('txtCustNameM');
			jtCustNbrE = document.getElementById('txtCustNbrE');
			jtCustomerNbrM = document.getElementById('txtCustomerNbrM');
			jtDateReqE = document.getElementById('txtDateReqE');
			jtDriverDateZ = document.getElementById('txtDriverDateZ');
			jtDriverZ = document.getElementById('txtDriverZ');
			jtDriverSignatureZ = document.getElementById('txtDriverSignatureZ');
			jtEmailsToInclude = document.getElementById('txtEmailsToInclude');
			jtFindInvoiceNbr = document.getElementById('txtFindInvoiceNbr');
			jtRequestIDE = document.getElementById('txtRequestIDE');
			jtInvoiceNbrE = document.getElementById('txtInvoiceNbrE');
			jtInvoiceNbrM = document.getElementById('txtInvoiceNbrM');
			jtLoadedByZ = document.getElementById('txtLoadedByZ');
			jtLoadDateZ = document.getElementById('txtLoadDateZ');
			jtLoadSignatureZ = document.getElementById('txtLoadSignatureZ');
			jtOrigInvoiceAmt = document.getElementById('txtOrigInvoiceAmt');
			jtReceivedDateZ = document.getElementById('txtReceivedDateZ');
			jtReceivedSignatureZ = document.getElementById('txtReceivedSignatureZ');
			jtReceivedByZ = document.getElementById('txtReceivedByZ');
			jtReqByE = document.getElementById('txtReqByE');
			jtReqRtnDateM = document.getElementById('txtReqRtnDateM');
			jtRequestedByM = document.getElementById('txtRequestedByM');
			jtRequiredDateE = document.getElementById('txtRequiredDateE');
			jtRtnFreightRateM = document.getElementById('txtRtnFreightRateM');
			jtSONbrE = document.getElementById('txtSONbrE');
			jtSONbrM = document.getElementById('txtSONbrM');
			jtSubmittedByCC = document.getElementById('txtSubmittedByCC');
			jtSubmittedOnCC = document.getElementById('txtSubmittedOnCC');
			jtTransOrderNbrM = document.getElementById('txtTransOrderNbrM');

			PageInitiation();
		});

		function KeepSessionAlive() {
			counter++;
			if(counter > 10000) { counter = 0; }
			var img = document.getElementById("imgSessionKeepAlive");
			img.src = "../ka.html?c=" + counter;
			setTimeout(KeepSessionAlive, 300000);
		}

		function disableEnterKey(e) {
			var key;
			if(window.event) {
				key = window.event.keyCode;     //IE
			}
			else {
				key = e.which;     //firefox
			}
			if(key == 13) {
				return false;
			}
			else {
				return true;
			}
		}

		function stopRKey(evt) {
			var evt2 = (evt) ? evt : ((event) ? event : null);
			var node = (evt2.target) ? evt2.target : ((evt2.srcElement) ? evt2.srcElement : null);
			if((evt2.keyCode == 13) && (node.type == "text")) { return false; }
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
			jsDocumentStatus = 'U';
			jtReqByE.value = jsUserName;
			FillDocumentStatus(jsDocumentStatus);
			jiDocumentType = 0;
			jsDocType = '';
			PopulateDocTypes();
			GetCustomerList('');
			jbLoadedCustomerList = true;
			jiPgNbrPj[0] = 0;
			jiNbrProdsMAC = 1;
			jiNbrProdsLAD = 3;
			jiRequestID = 0;
			jiInvoiceID = 0;

			EstablishMainPgElementsPj(1, 0);
			EstablishMainPgElementsPj(2, 0);

			if(jiInvoiceReqID > 0) {
				InitializeInvAdj();
			}
			jtDateReqE.value = jsToday;
			jselDocumentType.value = '0';
			jsDocType = '';
			jspnAttachMessage.style.display = 'none';
			jspnRightAttachDrop.style.display = 'none';
			document.getElementById('lblPageIDInFooter').innerHTML = 'Page ID: ' + jiPageID.toString();
			jtFindInvoiceNbr.readOnly = true;
			jtRequestIDE.readOnly = true;
			jdivFormFooter.style.display = 'none';
			jdivFormBlank.style.display = 'block';
			jspnSaveRequest.style.display = 'none';
			jspnExportToPDFbtn.style.display = 'none';
			jsStatusCode = 'U';
			createDatePickerOnTextWc('txtRequiredDateE', null, null, 0, 3, 'show', 11);
			//createDatePickerOnTextWc('txtEndDateF', null, null, 0, 3, 'show', 12);
			SetTabVisible(1);
			//alert('Initiation done');
			return false;
		}
		// END of page initiation section --------------------------------------------------------------------------------
		//#endregion PageInitiationR	JS

		// **************************** AJAX FUNCTIONS *********************************

		//#region AjaxCallsR	JS
		function DataCall1() {
			switch(jiDocumentType) {
				case 1:	//InvAdj-Rtn Manifest
					GetAttachmentList2('INVADJ', 'RMANF', '', jiInvoiceReqID, 0, '', 0);
					break;
				case 2: // InvAdjustment Only
					GetAttachmentList('INVADJ', jiInvoiceReqID, '');
					break;
				case 3: // Return Manifest
					GetAttachmentList('RMANF', jiInvoiceReqID, '');
					break;
				case 4: // Freight Accrual
					GetAttachmentList('FRTACC', jiInvoiceReqID, '');
					break;
				case 5: //Vendor Claim
					GetAttachmentList('VENDCLM', jiInvoiceReqID, '');
					break;
				case 6:	// Loss & Damage Claim
					GetAttachmentList('LSSDMG', jiInvoiceReqID, '');
					break;
				case 7: // Inventory Adjustment
					GetAttachmentList('INVCHG', jiInvoiceReqID, '');
					break;
				case 8: // MAC Adjustment
					GetAttachmentList('MACADJ', jiInvoiceReqID, '');
					break;
				case 9: // Manual credit
					GetAttachmentList('MNLCRED', jiInvoiceReqID, '');
					break;
				case 10: // Cust Claim
					GetAttachmentList('CUSTCLM', jiInvoiceReqID, '');
					break;
				default:
					break;
			}
			PopulateInvRequest();
			return false;
		}

		function GetAttachmentList(dtype, id, ext) {
			var url = "../shared/AdminServices.asmx/SelectAttachmentList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','DocType':'" + dtype + "','ID':'" + id.toString() + "','Ext':'" + ext + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																					jiPageSize2 ****
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyAttachmentList = response; });
			return false;
		}

		function GetAttachmentList2(dtype, dtype2, dtype3, id, id2, ext, sort) {
			var url = "../shared/AJAXServices.asmx/GetAttachmentList2";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','DocType':'" + dtype + "','DocType2':'" + dtype2 + "','DocType3':'" + dtype3 + "','ID':'" + id.toString() + "','ID2':'" + id2.toString() + "',";
			MyData = MyData + "'Ext':'" + ext + "','PgNbr':'','PgSize':'" + jiPageSize2.toString() + "','Sort':'" + sort.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyAttachmentList = response; });
			return false;
		}

		function GetCreditRepList(sort, act) {
			var url = "../shared/AdminServices.asmx/SelectBusinessCodeList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','BCClass':'','CodeGrp':'CreditRep','Active':'" + act.toString() + "','Shown':'1',";
			MyData = MyData + "'Sort':'" + sort.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCreditRepList = response; });
			return false;
		}

		function GetCarrierList(nm, sort, act) {
			var url = "../shared/FinanceServices.asmx/SelectCarrierList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','VendName':'" + nm + "','Sort':'" + sort.toString() + "','Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCarrierList = response; });
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

		function GetDocStatusFlow(rowid) {
			var url = "../shared/AdminServices.asmx/SelectDocStatusFlow";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','DocTypeCode':'invadj','RowID':'" + rowid.toString() + "','OldStat':'" + jsDocumentStatus + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyDocStatFlow = response; });
			return false;
		}

		function GetDocStatusChanges(reqid, invreqid, sort) {
			var url = "../shared/GridSupportServices.asmx/SelectDocumentStatusChangeList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ReqID':'" + reqid.toString() + "','InvReqID':'" + invreqid.toString() + "','Sort':'" + sort.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyDocStatChanges = response; });
			return false;
		}

		function GetDocTypeAssociations() {
			var url = "../shared/GridSupportServices.asmx/SelectDocTypeAssociations";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','DocTypeCode':'" + jsDocType + "','iType':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyDocTypeAssociations = response; });
			return false;
		}

		function GetInventoryItemData(pt, pc, loc, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13) {
			var url = "../shared/GridSupportServices.asmx/SelectInventoryItemData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ProdType':'" + pt + "','ProdCode':'" + pc + "','Loc':'" + loc + "','A1':'" + a1 + "','A2':'" + a2 + "','A3':'" + a3 + "','A4':'" + a4 + "',";
			MyData = MyData + "'A5':'" + a5 + "','A6':'" + a6 + "','A7':'" + a7 + "','A8':'" + a8 + "','A9':'" + a9 + "','A10':'" + a10 + "','A11':'" + a11 + "','A12':'" + a12 + "','A13':'" + a13 + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyInventoryItemData = response; });
			return false;
		}

		function GetInvoiceRequestData() {
			var url = "../shared/FinanceServices.asmx/SelectInvoiceRequestData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','InvReqID':'" + jiInvoiceReqID.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyInvRequestData = response; });
			if(MyInvRequestData.length > 0) {
				jsDocumentStatus = MyInvRequestData[0]['StatusCode'].toString();
			}
			return false;
		}

		function GetInvoiceData() {
			var url = "../shared/FinanceServices.asmx/SelectInvoiceData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','InvoiceID':'" + jiInvoiceID.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyInvoiceData = response; });
			return false;
		}

		function GetInvoiceItems(sdtype) {
			//alert('fired');
			if(jiInvoiceReqID > 0 || jiInvoiceID > 0) {
				var url = "../shared/FinanceServices.asmx/SelectInvoiceItems";
				var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ReqID':'" + jiInvoiceReqID.toString() + "','InvoiceID':'" + jiInvoiceID.toString() + "','SubDocType':'" + sdtype + "','ByID':'" + jiByID.toString() + "'}";
				//alert(MyData);																																																																	  
				getJSONReturnDataAs(url, MyData, function (response)
				{ MyInvoiceItems = response; });
				jbLoadedInvoiceItems = true;
			}
			return false;
		}

		function GetLocationLists(loc, ltype, ctry, city, sort, lclass, act) {
			var url = "../shared/FinanceServices.asmx/SelectLocationList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','Loc':'" + loc + "','LocType':'" + ltype + "','Country':'" + ctry + "','City':'" + city + "','Sort':'" + sort.toString() + "',";
			MyData = MyData + "'Class':'" + lclass.toString() + "','Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyLocationList = response; });
			return false;
		}

		function GetLocationDestinations(loc, ltype, reg, ctry, st, city) {
			var url = "../shared/AdminServices.asmx/SelectLocationListDW";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','Loc':'" + loc + "','LocType':'" + ltype + "','Region':'" + reg + "','Country':'" + ctry + "','St':'" + st + "','City':'" + city + "','Sort':'0',";
			MyData = MyData + "'Class':'3','Active':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyDestinationList = response; });
			return false;
		}

		function GetProductList(pt) {
			var region = ''; // jselRegionMF.value;
			var loc = ''; // jselLocationMF.value;
			var url = "../shared/AjaxServices.asmx/SelectProductListMaster";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ProdType':'" + pt + "','Region':'" + region + "','ShowAll':'1','Sort':'0','Active':'1','List':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProductList = response; });
			return false;
		}

		function GetProdTypeCodeList(pt, desc, attrib) {
			var url = "../shared/GridSupportServices.asmx/SelectProdTypeCodeList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ProdType':'" + pt + "','Desc':'" + desc.toString() + "','Attrib':'" + attrib.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProdTypeCodeList = response; });
			return false;
		}

		function GetProdTypeLists(pt, sort, act) {
			var url = "../shared/FinanceServices.asmx/SelectProductTypeList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ProdType':'" + pt + "','Sort':'" + sort.toString() + "','Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProdTypeList = response; });
			return false;
		}

		function GetPersListForPosition(pos, sort, act) {
			var url = "../shared/FinanceServices.asmx/SelectPersListForPosition";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','Pos':'" + pos + "','Sort':'" + sort.toString() + "','Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyPersPositionList = response; });
			return false;
		}

		function GetReasonList(sort, act) {
			var url = "../shared/AdminServices.asmx/SelectBusinessCodeList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','BCClass':'','CodeGrp':'invadjReason','Active':'" + act.toString() + "','Shown':'1',";
			MyData = MyData + "'Sort':'" + sort.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReasonList = response; });
			return false;
		}

		function GetRequestData(rid) {
			var url = "../shared/FinanceServices.asmx/SelectRequestData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','RequestID':'" + rid.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyRequestData = response; });
			return false;
		}

		function GetSalesGrpList() {
			var url = "../shared/GridSupportServices.asmx/SelectSalesGroupList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','Active':'1','iType':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MySalesLeadList = response; });
			return false;
		}

		function GetSalesStaffList() {
			var url = "../shared/GridSupportServices.asmx/SelectSalesGroupList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','Active':'1','iType':'3','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MySalesPersList = response; });
			return false;
		}

		//function GetSalesLeadList(act) {
		//	var url = "../shared/GridSupportServices.asmx/SelectSalesLeadList";
		//	var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
		//	//alert(MyData);																																																																	  
		//	getJSONReturnDataAs(url, MyData, function (response)
		//	{ MySalesLeadList = response; });
		//	return false;
		//}

		//function GetSalesPersonList(act) {
		//	var url = "../shared/GridSupportServices.asmx/SelectSalesPersonList";
		//	var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
		//	//alert(MyData);																																																																	  
		//	getJSONReturnDataAs(url, MyData, function (response)
		//	{ MySalesPersList = response; });
		//	return false;
		//}

		function GetUserDocRights(doctype) {
			jiDocRightLevel = 0;
			var url = "../shared/AdminServices.asmx/GetUserDocRights";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','DocType':'" + doctype + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			if(!IsContentsNullUndefEmptyGu(MyReturn)) {
				jiDocRightLevel = parseInt(MyReturn[0]['RightLevel'], 10);
			}
			return false;
		}

		function UpdateInvRequest(id, dtreq, byid, stat, idt, crepid, spid, slead, sfm, rc, cust, ctlnbr, cid, vend, onbr, shpnbr, onbr1, onbr2, loc2, loc3, set1, set2, set3, set4, set5, set6, amt, aiamt, aamt, frate, oamt, oval1, oval2, rdate, tdate, adate1, adate2, tdate1, tdate2, nprod, cmt, act) {
			jsErrorMsg = '';
			var url = "../Shared/FinanceServices.asmx/UpdateInvRequestData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','InvReqID':'" + id.toString() + "','DTReq':'" + dtreq + "','ReqByID':'" + byid.toString() + "','DocType':'" + jsDocType + "',";
			MyData = MyData + "'DispID':'" + jiDocumentType.toString() + "','StatusCode':'" + stat + "','CustCode':'" + cust + "','CustCtlNbr':'" + ctlnbr + "','CarrierID':'" + cid.toString() + "','VendorCode':'" + vend + "',";
			MyData = MyData + "'InvNbr':'" + jiInvoiceID.toString() + "','InvDt':'" + idt + "','OrdNbr':'" + onbr.toString() + "','ShipNbr':'" + shpnbr + "','OtherNbr1':'" + onbr1.toString() + "','OtherNbr2':'" + onbr2.toString() + "',";
			MyData = MyData + "'CreditRepID':'" + crepid.toString() + "','SalesPID':'" + spid.toString() + "','SalesLead':'" + slead + "','ShipFmLoc':'" + sfm + "','LocCode2':'" + loc2 + "','LocCode3':'" + loc3 + "',";
			MyData = MyData + "'ReasonCode':'" + rc + "','ReasonDetail':'" + rdet + "','CustReqCopy':'" + crc.toString() + "','Setting1':'" + set1.toString() + "','Setting2':'" + set2.toString() + "','Setting3':'" + set3.toString() + "',";
			MyData = MyData + "'Setting4':'" + set4.toString() + "','Setting5':'" + set5.toString() + "','Setting6':'" + set6.toString() + "','OrigAmt':'" + oamt.toString() + "','AdjInvoiceAmt':'" + aiamt.toString() + "',";
			MyData = MyData + "'AdjAmt':'" + aamt.toString() + "','FrtRate':'" + frate.toString() + "','OtherAmt':'" + oamt + "','OtherVal1':'" + oval1 + "','OtherVal2':'" + oval2 + "','RequiredDt':'" + rdate + "',";
			MyData = MyData + "'TgtDT':'" + tdate + "','ActDate1':'" + adate1 + "','ActDate2':'" + adate2 + "','TransDT1':'" + tdate1 + "','TransDT2':'" + tdate2 + "',";
			MyData = MyData + "'Cmt':'" + cmt + "','NbrProd':'" + nprod.toString() + "','Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyResponse = response; });
			EvaluateStdDatabaseReturnAs(MyResponse, jdivStatusMsg, jlStatusMsg, 'Request could not be saved because of an error.', 'No response came from the database when attempting to save request.');
			//GetAttachments();      
			return false;
		}

		function UpdateInvReqLine(lnid, inbr, ptype, pcode, desc, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, oqty, oqty2, rqty, rqty2, oprice, rprice, crdbamt, ia, rtag, rtnqty, rpkg, qchkin, tkt, expl, rtn, act) {
			jlStatusMsg.innerHTML = '';
			var url = "../shared/FinanceServices.asmx/UpdateInvRequestLine";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','IRLineID':'" + lnid.toString() + "','InvReqID':'" + jiInvoiceReqID.toString() + "','ItemNbr':'" + inbr.toString() + "','iDoctType':'" + jiDocumentType.toString() + "',";
			MyData = MyData + "'ProdType':'" + ptype + "','ProdCode':'" + pcode + "','Desc':'" + desc + "','A1':'" + a1 + "','A2':'" + a2 + "','A3':'" + a3 + "','A4':'" + a4 + "','A5':'" + a5 + "','A6':'" + a6 + "','A7':'" + a7 + "',";
			MyData = MyData + "'A8':'" + a8 + "','A9':'" + a9 + "','A10':'" + a10 + "','A11':'" + a11 + "','A12':'" + a12 + "','A13':'" + a13 + "','OrigQty':'" + oqty.toString() + "','OrigQty2':'" + oqty2.toString() + "',";
			MyData = MyData + "'RevQty':'" + rqty.toString() + "','RevQty2':'" + rqty2.toString() + "','OrigPrice':'" + oprice.toString() + "','RevPrice':'" + rprice.toString() + "','TotalCRDBAmt':'" + crdbamt.toString() + "',";
			MyData = MyData + "'InvAdj':'" + ia.toString() + "','RedTag':'" + rtag.toString() + "','RtnQty':'" + rtnqty.toString() + "','RtnPkg':'" + rpkg.toString() + "','RtnQtyCheckedIn':'" + qchkin.toString() + "','Tickets':'" + tkt + "',";
			MyData = MyData + "'Explanation':'" + expl + "','IsRtn':'" + rtn.toString() + "','Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			EvaluateStdDatabaseReturnAs(MyResponse, jdivStatusMsg, jlStatusMsg, 'Request Line ' + iNbr.toString() + ' could not be saved because of an error.', 'No response came from the database when attempting to save Line ' + iNbr.toString() + '.');
			return false;
		}

		function UpdateRequestData(rid, sdate, rbyid, dispid, stat, nbrcomp, critical, cmt, emailto, doctypes, reqon, act) {
			jsErrorMsg = '';
			var url = "../Shared/FinanceServices.asmx/UpdateRequest";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ReqID':'" + rid.toString() + "','sDate':'" + sdate + "','ReqByID':'" + rbyid.toString() + "','DispID':'" + dispid.toString() + "','Stat':'" + stat + "',";
			MyData = MyData + "'NbrComp':'" + nbrcomp.toString() + "','Critical':'" + critical.toString() + "','InvNbr':'" + jiInvoiceID.toString() + "','OrdNbr':'" + jiOrderNbr.toString() + "','Cmt':'" + cmt + "','EmailTo':'" + emailto + "',";
			MyData = MyData + "'DocTypes':'" + doctypes + "','RequiredOn':'" + reqon + "','Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyResponse = response; });
			//(dtable, statusobj, accfailmsg, nortnmsg, msginvalidmsg)
			EvaluateStdDatabaseReturnAs(MyResponse, jdivStatusMsg, jlStatusMsg, 'Request could not be saved because of an error.', 'No response came from the database when attempting to save the request.');
			if(!IsContentsNullUndefEmptyGu(MyResponse)) {
				jiRequestID = parseInt(MyResponse[0]['ReqID'], 10);
			}
			//GetAttachments();
			return false;
		}

		function DeleteAnAttachment(docid, attachid) {
			jsErrorMsg = '';
			var url = "../Shared/GridSupportServices.asmx/DeleteDocAttachment";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'2','DocID':'" + docid.toString() + "','AttachID':'" + attachid.toString() + "','Src':'DataMngt','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyResponse = response; });
			(dtable, statusobj, accfailmsg, nortnmsg, msginvalidmsg)
			EvaluateStdDatabaseReturnAs(MyResponse, jdivStatusMsg, jlStatusMsg, 'Attachment could not be removed because of an error.', 'No response came from the database when attempting to remove attachment.');
			//GetAttachments();      
			return false;
		}
		//#endregion AjaxCallsR	JS

		// **************************** Populating *********************************
		//#region PopulatePageObjectsR JS
		function PopulateAttachmentList() {
			var bdy = document.createElement("tbody");
			var nrows = 0;
			var dtyp2 = '';
			jlStatusMsg.innerHTML = '';
			var cellClass = 'StdTableCell';
			if(jiDocumentType === 2) { dtyp2 = 'RMANF'; }
			if(jsDocType !== '' && jiRequestID > 0) {
				GetAttachmentList2(jsDocType, dtyp2, '', jiRequestID, 0, '', 0);
				nrows = MyAttachmentList.length;
				//alert('Filling Proc List');
				var nCol = 9;
				// Cols: 0-ID, 1-Title, 2-Description, 3-ContentType, 4-FileType, 5-FIleSize, 6-InsertedOn, 7-InsertedBy, 8-Action
				//alert('arrays');
				var cWidth = [70, 190, 260, 90, 90, 80, 90, 170, 90, 0, 0, 0, 0, 0, 0];
				var corientH = ['center', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'center', 'center', 'left', '', '', ''];
				var corientV = ['top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', '', '', '', ''];
				var cbrdrL = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', '', ''];
				var cbrdrR = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', '', ''];
				var cbrdrT = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', '', ''];
				var cbrdrB = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', '', ''];
				var cnames = ['DocID', 'DocTitle', 'ContentTypeDesc', 'ContentType', 'FileType', 'FileSize', 'sSubmittedOn', 'sFullName', 'ACTION', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
				var cType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0];
				var aggType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
				var shown = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
				//alert('DDL list data');

				if(!IsContentsNullUndefinedGu(MyAttachmentList)) {
					//alert('Proc List Len: ' + MyProcessList.length);
					bdy = FormDataGridBodyMinimumDg(1, nCol, 'tdAttachList', cellClass, false, false, true, false, '', 'button blue-gradient glossy', false, 0, MyAttachmentList, 'DocID', cnames, cType, cWidth, corientH, corientV, cbrdrL, cbrdrR, cbrdrT, cbrdrB, aggType, shown, true, true);
					//alert('Grid done');
					jtblAttachmentsList.style.display = 'block';
				}
				else {
					alert('Proc List bad data');
					ShowStatusMsg('An unidentified error occurred. No records could be extracted.');
				}
				if(nrows === 0) {
					var rw = document.createElement("tr");
						//                       tx  nbr nbr   txt      txt      txt      txt    txt    txt    txt    txt     txt     txt   txt   txt   txt   txt     bool    bool      txt     bool    bool    txt	   txt     txt        displaytxt
					var cell = createNewCellDg('tdAttachList1', 0, 0, 'No data was found', 'white', 'black', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', 'center', 'middle', '1px', '1px', padt, '1px', '11pt', true, false, 'hidden', false, false, '', nCol, cellClass, '', false);
					rw.appendChild(cell);
					bdy.appendChild(rw);
				}
			}

			//alert('Attaching body');
			try {
				var oldBody = jtblAttachmentsList.getElementsByTagName("tbody")[0];
				jtblAttachmentsList.replaceChild(bdy, oldBody);
			}
			catch(ex) {
				// nothing
			}
			joPgNbrLblPj.innerHTML = (jiPgNbrPj[0] + 1).toString();
			joMaxPgNbrLblPj.innerHTML = jiNbrPagesPj[0].toString();
			return false;
		}

		function PopulateCarrierList() {
			if(jbLoadedCarrierList === false || IsContentsNullUndefEmptyGu(MyCarrierList)) {
				GetCarrierList('', 0, 1);
				jbLoadedCarrierList = true;
			}
			ClearDDLOptionsGu('selRtnCarrierM', 1);
			if(!IsContentsNullUndefEmptyGu(MyCarrierList)) {
				fillDropDownListGu(MyCarrierList, jselRtnCarrierM, 0, 'EntityFullName', 'VendorID');
			}
			return false;
		}

		function PopulateCreditRepLists() {
			if(jbLoadedCreditRepList === false || IsContentsNullUndefEmptyGu(MyCreditRepList)) {
				GetCreditRepList(0, 1);	// MyCreditRepList
				jbLoadedCreditRepList = true;
			}
			ClearDDLOptionsGu('selCreditRepE', 1);
			if(!IsContentsNullUndefEmptyGu(MyCreditRepList)) {
				fillDropDownListGu(MyCreditRepList, jselCreditRepE, 0, 'ItemDescription', 'ItemCode');
			}
			return false;
		}

		function PopulateCreditRepListsRM() {
			if(jbLoadedCreditRepList === false || IsContentsNullUndefEmptyGu(MyCreditRepList)) {
				GetCreditRepList(0, 1);	// MyCreditRepList
				jbLoadedCreditRepList = true;
			}
			ClearDDLOptionsGu('selCreditRepM', 1);
			if(!IsContentsNullUndefEmptyGu(MyCreditRepList)) {
				fillDropDownListGu(MyCreditRepList, jselCreditRepM, 0, 'ItemDescription', 'ItemCode');
			}
			return false;
		}

		function PopulateDestinationList() {
			if(jbLoadedDestinationList === false || IsContentsNullUndefEmptyGu(MyDestinationList)) {
				GetLocationDestinations('', '', '', '', '', '');
				jbLoadedDestinationList = true;
			}
			//alert('loading list - ' + MyDestinationList.length);
			if(!IsContentsNullUndefEmptyGu(MyDestinationList)) {
				ClearDDLOptionsGu('selShipTOLocationM', 1);
				fillDropDownListGu(MyDestinationList, jselShipTOLocationM, 0, 'Name', 'loc');
			}
			return false;
		}

		function PopulateDocStatusChanges() {
			//alert('Filling Proc List');
			jlStatusMsg.innerHTML = '';
			var bdy = document.createElement("tbody");
			var cellClass = 'StdTableCell';
			var nCol = 5;
			var nrows = 0;
			if(jiRequestID > 0) {
				GetDocStatusChanges(0, jiRequestID, 0);
				nrows = MyDocStatChanges.length;
				// Cols: 0-Step, 1-Status, 2-StatusDate, 3-ChangeBy, 4-Comments
				//alert('arrays');
				var cWidth = [60, 140, 160, 160, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
				var corientH = ['center', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'center', 'center', 'left', '', '', ''];
				var corientV = ['top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', '', '', '', ''];
				var cbrdrL = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', '', ''];
				var cbrdrR = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', '', ''];
				var cbrdrT = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', '', ''];
				var cbrdrB = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', '', '', ''];
				var cnames = ['Step', 'DocStatusWithCode', 'sStateDateTime', 'UserFullName', 'Comments', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
				var cType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0];
				var aggType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
				var shown = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
				//alert('DDL list data');

				if(!IsContentsNullUndefinedGu(MyDocStatChanges)) {
					//alert('Proc List Len: ' + MyProcessList.length);
					bdy = FormDataGridBodyMinimumDg(2, nCol, 'tdStatChangeList', cellClass, false, false, false, false, '', 'button blue-gradient glossy', false, 0, MyDocStatChanges, 'RowID', cnames, cType, cWidth, corientH, corientV, cbrdrL, cbrdrR, cbrdrT, cbrdrB, aggType, shown, true, true);
					//alert('Grid done');
					jtblStatusList.style.display = 'block';
				}
				else {
					alert('Proc List bad data');
					ShowStatusMsg('An unidentified error occurred. No records could be extracted.');
				}
				if(nrows === 0) {
					var rw = document.createElement("tr");
					//                       tx  nbr nbr   txt      txt      txt      txt    txt    txt    txt    txt     txt     txt   txt   txt   txt   txt     bool    bool      txt     bool    bool    txt	   txt     txt        displaytxt
					var cell = createNewCellDg('tdStatChangeList1', 0, 0, 'No data was found', 'white', 'black', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', 'center', 'middle', '1px', '1px', padt, '1px', '11pt', true, false, 'hidden', false, false, '', nCol, cellClass, '', false);
					rw.appendChild(cell);
					bdy.appendChild(rw);
				}
			}
			//alert('Attaching body');
			try {
				var oldBody = jtblStatusList.getElementsByTagName("tbody")[0];
				jtblStatusList.replaceChild(bdy, oldBody);
			}
			catch(ex) {
				// nothing
			}
			//joPgNbrLblPj.innerHTML = (jiPgNbrPj[0]+1).toString();
			//joMaxPgNbrLblPj.innerHTML = jiNbrPagesPj[0].toString();
			return false;
		}

		function PopulateDocStatusFlow(id) {
			GetDocStatusFlow(id);
			ClearDDLOptionsGu('selSetNewStatus', 1);
			if(MyDocStatFlow !== undefined && MyDocStatFlow !== null) {
				fillDropDownListGu(MyDocStatFlow, jselSetNewStatus, 0, 'DocumentStatus', 'NewStatusCode');
			}
			return false;
		}

		function PopulateDocTypes() {
			//if(jsaDocType[0] === '') {
			//	appendDDLOptionGu(jselDocumentType, '2', 'Invoice Adjustment');
			//	appendDDLOptionGu(jselDocumentType, '3', 'Rtn Manifest');
			//	appendDDLOptionGu(jselDocumentType, '4', 'Freight Accrual');
			//	appendDDLOptionGu(jselDocumentType, '5', 'Vendor Claim');
			//	appendDDLOptionGu(jselDocumentType, '6', 'Loss-Damage Claim');
			//	appendDDLOptionGu(jselDocumentType, '7', 'Inventory Change');
			//	appendDDLOptionGu(jselDocumentType, '8', 'MAC Adjustment');
			//	appendDDLOptionGu(jselDocumentType, '9', 'Manual Credit');
			//	appendDDLOptionGu(jselDocumentType, '10', 'Customer Claim');
			//}
			//else {
			//	//alert('got data');
			//	if(jsDocType !== '') { GetDocTypeAssociations(); }
			//	ClearDDLOptionsGu('selDocumentType', 1);
			//	//alert(FindFirstMatchValueInJSONArrayGu('DocTypeCode', 'INVADJ', MyDocTypeAssociations));
			//	if(IsComponentShown('INVADJ') === false && FindFirstMatchValueInJSONArrayGu('DocTypeCode', 'INVADJ', MyDocTypeAssociations) > -1) {
			//		appendDDLOptionGu(jselDocumentType, '2', 'Invoice Adjustment');
			//	}
			//	if(IsComponentShown('RMANF') === false && FindFirstMatchValueInJSONArrayGu('DocTypeCode', 'RMANF', MyDocTypeAssociations) > -1) {
			//		appendDDLOptionGu(jselDocumentType, '3', 'Rtn Manifest');
			//	}
			//	if(IsComponentShown('FRTACC') === false && FindFirstMatchValueInJSONArrayGu('DocTypeCode', 'FRTACC', MyDocTypeAssociations) > -1) {
			//		appendDDLOptionGu(jselDocumentType, '4', 'Freight Accrual');
			//	}
			//	if(IsComponentShown('VENDCLM') === false && FindFirstMatchValueInJSONArrayGu('DocTypeCode', 'VENDCLM', MyDocTypeAssociations) > -1) {
			//		appendDDLOptionGu(jselDocumentType, '5', 'Vendor Claim');
			//	}
			//	if(IsComponentShown('LSSDMG') === false && FindFirstMatchValueInJSONArrayGu('DocTypeCode', 'LSSDMG', MyDocTypeAssociations) > -1) {
			//		appendDDLOptionGu(jselDocumentType, '6', 'Loss-Damage Claim');
			//	}
			//	if(IsComponentShown('INVCHG') === false && FindFirstMatchValueInJSONArrayGu('DocTypeCode', 'INVCHG', MyDocTypeAssociations) > -1) {
			//		appendDDLOptionGu(jselDocumentType, '7', 'Inventory Change');
			//	}
			//	if(IsComponentShown('MACADJ') === false && FindFirstMatchValueInJSONArrayGu('DocTypeCode', 'MACADJ', MyDocTypeAssociations) > -1) {
			//		appendDDLOptionGu(jselDocumentType, '8', 'MAC Adjustment');
			//	}
			//	if(IsComponentShown('MNLCRED') === false && FindFirstMatchValueInJSONArrayGu('DocTypeCode', 'MNLCRED', MyDocTypeAssociations) > -1) {
			//		appendDDLOptionGu(jselDocumentType, '9', 'Manual Credit');
			//	}
			//	if(IsComponentShown('CUSTCLM') === false && FindFirstMatchValueInJSONArrayGu('DocTypeCode', 'CUSTCLM', MyDocTypeAssociations) > -1) {
			//		appendDDLOptionGu(jselDocumentType, '10', 'Customer Claim');
			//	}
			//}
			return false;
		}
		
		function PopulateInventoryChgItems() {
			jlStatusMsg.innerHTML = '';
			GetInvoiceItems('INVCHG');
			var cellClass = 'StdTableCell';
			var nCol = 19;
			// Cols: 0-Loc, 1-P/T, 2-Product, 3-Attrib1, 4-Attrib2, 5-Attrib3, 6-Attrib4, 7-Attrib5, 8-Attrib6, 9-Attrib7, 10-Attrib8, 11-Attrib9, 12-Attrib10, 13-Attrib11, 14-Attrib12, 15-Attrib13, 16-Changed Qty, 17-Changed PcsPkg, 18-DetailedExp, 19-ACTION
			//alert('arrays');
			var cWidth = [120, 50, 200, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 120, 130, 80, 80, 300, 160, 0, 0, 0, 0, 0];
			var corientH = ['center', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'center', 'center', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', 'left', ''];
			var corientV = ['top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', 'top', '', ''];
			var cbrdrL = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrR = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrT = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', ''];
			var cbrdrB = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '', '', '', '', '', '', '', '', '', '', ''];
			var cnames = ['LocCode', 'ProdType', 'ProdCode', 'Attribute01', 'Attribute02', 'Attribute03', 'Attribute04', 'Attribute05', 'Attribute06', 'Attribute07', 'Attribute08', 'Attribute09', 'Attribute10', 'Attribute11', 'Attribute12', 'Attribute13', 'RevisedQty', 'RevisedQty2', 'Explanation', 'ACTION', '', '', '', '', '', '', '', '', ''];
			var cType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var aggType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var shown = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
			//alert('DDL list data');

			if(!IsContentsNullUndefinedGu(MyInvoiceItems)) {
				//alert('Proc List Len: ' + MyInvoiceItems.length);
				var bdy = FormDataGridBodyMinimumDg(1, nCol, 'tdInventChgList', cellClass, false, false, true, false, '', 'button blue-gradient glossy', false, 0, MyInvoiceItems, 'DocID', cnames, cType, cWidth, corientH, corientV, cbrdrL, cbrdrR, cbrdrT, cbrdrB, aggType, shown, true, true);
				//alert('Grid done');
				jtblInvChangeItems.style.display = 'block';
			}
			else {
				alert('Proc List bad data');
				ShowStatusMsg('An unidentified error occurred. No records could be extracted.');
			}
			//alert('Attaching body');
			try {
				var oldBody = jtblInvChangeItems.getElementsByTagName("tbody")[0];
				jtblInvChangeItems.replaceChild(bdy, oldBody);
			}
			catch(ex) {
				// nothing
			}
			joPgNbrLblPj.innerHTML = (jiPgNbrPj[0] + 1).toString();
			joMaxPgNbrLblPj.innerHTML = jiNbrPagesPj[0].toString();
			return false;
		}

		function PopulateInvoiceData() {
			// MyInvAdjData, MyInvoiceData
			jhfInvoiceDate.value = '';
			if(!IsContentsNullUndefEmptyGu(MyInvoiceData)) {
				jhfInvoiceDate.value = MyInvoiceData[0]['sInvDate'].toString();
				switch(jiDocumentType) {
					case 2:	//InvAdjustment Only
						PopulateInvoiceDataIA();
						break;
					case 3:	//Return Manifest
						PopulateInvoiceDataRM()
						break;
					case 4:	//Freight Accrual
						LoadFreightAccrualData();
						break;
					case 5:	//Vendor Claim
						LoadVendorClaimData();
						break;
					case 6:	//Loss & Damage Claim
						LoadLossDamageClaimData();
						break;
					case 7:	//Inventory Adjustment
						break;
					case 8:	//MAC Adjustment
						break;
					case 9:	//Manual Credit
						break;
					case 10: //Cust Claim
						break;
					default:
						break;
				}
			}
			return false;
		}

		function PopulateInvoiceDataIA() {
			if(!IsContentsNullUndefEmptyGu(MyInvoiceData)) {
				jselCreditRepE.value = MyInvoiceData[0]['salesp'].toString();
				jselSalesLeadE.value = MyInvoiceData[0]['slsgrp'].toString();
				//alert('A');
				jselShipFmLocationE.value = MyInvoiceData[0]['loc'].toString();   ///////////////////
				jtCustNbrE.value = MyInvoiceData[0]['cust'].toString();
				//alert('B');
				jhfCustCodeE.value = MyInvoiceData[0]['cust'].toString();
				jtCustNameE.value = MyInvoiceData[0]['CustName'].toString();
				//alert('C');
				jiOrderNbr = parseInt(MyInvoiceData[0]['OrdNbr'], 10);
				jtSONbrE.value = jiOrderNbr.toString();
				//alert('D');
				jtInvoiceNbrE.value = jiInvoiceID.toString();
				//alert('E');
				jselReasonCodeE.value = '0'; // MyInvoiceData[0]['0'].toString();
				jfInvoiceAmtOrig = parseFloat(MyInvoiceData[0]['totalamt']);
				jtOrigInvoiceAmt.value = getNbrStringFormattedTx(jfInvoiceAmtOrig, 2, ',', '.', '$', 2);
				jfInvoiceAmtNew = jfInvoiceAmtOrig;
				jtAdjInvoiceAmt.value = getNbrStringFormattedTx(jfInvoiceAmtNew, 2, ',', '.', '$', 2);
				jfInvoiceAdjAmount = jfInvoiceAmtNew - jfInvoiceAmtOrig;
				jtAdjustmentAmt.value = getNbrStringFormattedTx(jfInvoiceAdjAmount, 2, ',', '.', '$', 2);
				jselSalesRepE.value = MyInvoiceData[0]['salesp'].toString();
				//alert('lines are next');
				// load lines
				PopulateInvoiceLinesIA();
			}
			return false;
		}

		function PopulateInvoiceLinesIA() {
			var grandTotalNEW = 0;
			var grandTotalORIG = 0;
			var lntotal = 0;
			var lntotalORIG = 0;
			var fig = 0;
			var price = 0;
			var priceORIG = 0;
			var qty = 0;
			var qtyORIG = 0;
			//var sRow = '';
			//alert('initiating lines');
			var subdoctype = '';
			if(jiInvoiceReqID > 0) { subdoctype = 'INVADJ'; }
			GetInvoiceItems(subdoctype); //MyInvoiceItems
			//alert('got invoice line data');
			jiNbrProdsIA = MyInvoiceItems.length;
			//alert('initiating lines - ' + jiNbrProdsIA.toString());
			InitiateInvAdjLines();
			if(!IsContentsNullUndefEmptyGu(MyInvoiceItems)) {
				var nbritems = MyInvoiceItems.length;
				//alert(nbritems);
				//alert('showing items in grid');
				for(var row = 1; row <= nbritems; row++) {
					lntotal = 0;
					//alert('Row ' + row.toString());
					//if (row === 7) { alert('1');}
					document.getElementById('txtProdType' + row.toString()).value = MyInvoiceItems[row - 1]['ProdType'].toString();
					//if (row === 7) { alert('2'); }
					document.getElementById('hfIAitemID' + row.toString()).value = MyInvoiceItems[row - 1]['InvReqItemID'].toString();
					document.getElementById('hfIAitemNbr' + row.toString()).value = MyInvoiceItems[row - 1]['ItemNbr'].toString();
					document.getElementById('txtProdCode' + row.toString()).value = MyInvoiceItems[row - 1]['ProdCode'].toString();
					//if (row === 7) { alert('3'); }
					document.getElementById('txtProdDesc' + row.toString()).value = MyInvoiceItems[row - 1]['ProdDesc'].toString();
					//if (row === 7) { alert('4'); }
					document.getElementById('hfIAitemID' + row.toString()).value = '0';
					//if (row === 7) { alert('5'); }
					document.getElementById('txtLineStatus' + row.toString()).value = MyInvoiceItems[row - 1]['LineStatus'].toString();
					//if (row === 7) { alert('6'); }
					qtyORIG = parseFloat(MyInvoiceItems[row - 1]['OriginalQty']);
					//if (row === 7) { alert('7'); }
					document.getElementById('txtOrigQty' + row.toString()).value = getNbrStringFormattedTx(qtyORIG, 5, ',', '.', '', 2);
					//if (row === 7) { alert('8'); }
					qty = parseFloat(MyInvoiceItems[row - 1]['RevisedQty']);
					//if (row === 7) { alert('9'); }
					document.getElementById('txtRevQty' + row.toString()).value = getNbrStringFormattedTx(qty, 5, ',', '.', '', 2);
					//if (row === 7) { alert('10'); }
					priceORIG = parseFloat(MyInvoiceItems[row - 1]['OriginalPrice']);
					//if (row === 7) { alert('11'); }
					document.getElementById('txtOrigPrice' + row.toString()).value = getNbrStringFormattedTx(priceORIG, 2, ',', '.', '$', 2);
					//if (row === 7) { alert('12'); }
					price = parseFloat(MyInvoiceItems[row - 1]['RevisedPrice']);
					//if (row === 7) { alert('13'); }
					document.getElementById('txtRevPrice' + row.toString()).value = getNbrStringFormattedTx(price, 2, ',', '.', '$', 2);
					//if (row === 7) { alert('14'); }
					//alert('calculating for line ' + row.toString());
					lntotal = qty * price;
					//alert('calculating 2');
					lntotalORIG = qtyORIG * priceORIG;
					//alert('calculating 3');
					document.getElementById('txtTotalAmount' + row.toString()).value = getNbrStringFormattedTx(lntotal, 2, ',', '.', '$', 2);
					//alert('calculating 4');
					grandTotalNEW = grandTotalNEW + lntotal;
					//alert('calculating 5');
					grandTotalORIG = grandTotalORIG + lntotalORIG;
					//alert('calculating done');
				}
				document.getElementById('txtAdjInvoiceAmt').value = getNbrStringFormattedTx(grandTotalNEW, 2, ',', '.', '$', 2);
			}
			else {
				document.getElementById('txtAdjInvoiceAmt').value = '0';
			}
			return false;
		}

		function PopulateInvoiceDataRM() {
			var val = '';
			if(!IsContentsNullUndefEmptyGu(MyInvoiceData)) {
				//jtRequestedByM.value = MyInvoiceData[0][''].toString();
				//jhfRequestedByIDM.value = MyInvoiceData[0][''].toString();
				jselCreditRepM.value = '0'; // MyInvoiceData[0][''].toString();
				jselSalesLeadM.value = MyInvoiceData[0]['slsgrp'].toString();
				jselShipFMLocationM.value = MyInvoiceData[0]['loc'].toString();
				jtCustomerNbrM.value = MyInvoiceData[0]['cust'].toString();
				jtCustNameM.value = MyInvoiceData[0]['CustName'].toString();
				jhfCustCodeM.value = MyInvoiceData[0]['cust'].toString();
				jtSONbrM.value = MyInvoiceData[0]['OrdNbr'].toString();
				jtInvoiceNbrM.value = jiInvoiceID.toString();

				jtReqRtnDateM.value = '';
				jselShipTOLocationM.value = '';
				jselReasonCodeM.value = '0';
				jtaRtnReasonM.value = '';
				jtRtnFreightRateM.value = '';
				jtTransOrderNbrM.value = '';
				jselRtnCarrierM.value = '';
				jtActRtnDateM.value = '';
				jchkRevisedInvCopyM.checked = false;
				jchkManInvAdjMI.checked = false;
				jchkAPNotificationMI.checked = false;
				PopulateInvoiceLinesRM();
			}
			return false;
		}

		function PopulateInvoiceLinesRM() {
			var lnbr = 0;
			var qty = 0;
			var qtycheckedin = 0;
			var pkg = 0;
			if(jbLoadedInvoiceItems === false) { GetInvoiceItems('RMANF'); }
			jiNbrProdsRM = MyInvoiceItems.length;
			//alert('initiating lines - ' + jiNbrProdsRM.toString());
			InitiateRtnManfLines();
			//alert('line data cleared');
			if(!IsContentsNullUndefEmptyGu(MyInvoiceItems)) {
				var nbritems = MyInvoiceItems.length;
				// show items in shown grid
				//alert('RM Lines: ' + nbritems);
				for(var row = 1; row <= nbritems; row++) {
					if(MyInvoiceItems[row - 1]['sReturn'].toString() === 'Yes') {
						lnbr++;
						//alert('txtProdType' + row.toString());
						//alert('1');
						document.getElementById('txtTKProdType' + lnbr.toString()).value = MyInvoiceItems[row - 1]['ProdType'].toString();
						//alert('2');
						document.getElementById('txtTKProdCode' + lnbr.toString()).value = MyInvoiceItems[row - 1]['ProdCode'].toString();
						document.getElementById('hfRMitemID' + lnbr.toString()).value = MyInvoiceItems[row - 1]['InvReqItemID'].toString();
						document.getElementById('hfRMitemNbr' + row.toString()).value = MyInvoiceItems[row - 1]['ItemNbr'].toString();
						//alert('3');
						document.getElementById('txtTKTicketNbr' + lnbr.toString()).value = MyInvoiceItems[row - 1]['TicketNbrs'].toString();
						document.getElementById('hfRMitemID' + lnbr.toString()).value = '0';
						//alert('4');
						document.getElementById('txtTKStatus' + lnbr.toString()).value = MyInvoiceItems[row - 1]['LineStatus'].toString();
						qty = parseFloat(MyInvoiceItems[row - 1]['RtnQty']);
						document.getElementById('txtTKQty' + lnbr.toString()).value = getNbrStringFormattedTx(qty, 2, ',', '.', '', 2);
						//alert('5');
						pkg = parseFloat(MyInvoiceItems[row - 1]['RtnPkgCount']);
						document.getElementById('txtTKTotalPkgCount' + lnbr.toString()).value = getNbrStringFormattedTx(pkg, 2, ',', '.', '', 2);
						qtycheckedin = parseFloat(MyInvoiceItems[row - 1]['RtnQtyCheckedIn']);
						//alert('6');
						document.getElementById('txtTKQtyCheckedIn' + lnbr.toString()).value = getNbrStringFormattedTx(qtycheckedin, 2, ',', '.', '$', 2);
						if(MyInvoiceItems[row - 1]['sRedTag'].toString() === 'Yes') {
							document.getElementById('chkTKRedTag' + lnbr.toString()).checked = true;
						}
						else {
							document.getElementById('chkTKRedTag' + lnbr.toString()).checked = false;
						}
						if(MyInvoiceItems[row - 1]['sInvAdj'].toString() === 'Yes') {
							document.getElementById('chkTKInvAdj' + lnbr.toString()).checked = true;
						}
						else {
							document.getElementById('chkTKInvAdj' + lnbr.toString()).checked = false;
						}
					}
				}
				jiNbrLinesShownRM = lnbr;
			}
			return false;
		}

		function PopulateLocationLists() {
			if(jbLoadedLocationList === false || IsContentsNullUndefEmptyGu(MyLocationList)) {
				GetLocationLists('', '', '', '', 0, 0, 1);
				jbLoadedLocationList = true;
			}
			if(!IsContentsNullUndefEmptyGu(MyLocationList)) {
				ClearDDLOptionsGu('selShipFmLocationE', 1);
				fillDropDownListGu(MyLocationList, jselShipFmLocationE, 0, 'Name', 'loc');
			}
			return false;
		}

		function PopulateLocationListsRM() {
			if(jbLoadedLocationList === false || IsContentsNullUndefEmptyGu(MyLocationList)) {
				GetLocationLists('', '', '', '', 0, 0, 1);
				jbLoadedLocationList = true;
			}
			if(!IsContentsNullUndefEmptyGu(MyLocationList)) {
				ClearDDLOptionsGu('selShipFMLocationM', 1);
				fillDropDownListGu(MyLocationList, jselShipFMLocationM, 0, 'Name', 'loc');
			}
			return false;
		}

		function PopulateLocationListsMA() {
			if(jbLoadedLocationList === false || IsContentsNullUndefEmptyGu(MyLocationList)) {
				GetLocationLists('', '', '', '', 0, 0, 1);
				jbLoadedLocationList = true;
			}
			if(!IsContentsNullUndefEmptyGu(MyLocationList)) {
				for(var row = 1; row <= jiNbrLinesMAC; row++) {
					ClearDDLOptionsGu('selLocationMACA' + row.toString(), 1);
					jselLocationMAC = document.getElementById('selLocationMACA' + row.toString());
					fillDropDownListGu(MyLocationList, jselLocationMAC, 0, 'Name', 'loc');
				}
			}
			return false;
		}

		function PopulateLossDamageLines() {
			if(jiRequestID !== 0) {
				//alert('fired');
				if(jiInvoiceReqID > 0 || jiInvoiceID > 0) {
					if(jbLoadedInvoiceItems === false) {
						GetInvoiceItems('LSSDMG'); //MyInvoiceItems
					}
				}
				jiNbrLinesLAD = MyInvoiceItems.length;
				InitiateLossDamageLines();

				for(var row = 1; row <= jiNbrLinesLAD; row++) {
					sRow = row.toString();
					if(sRow.length < 2) { sRow = '0' + sRow; }
					document.getElementById('selProdTypeLAD' + sRow.toString()).value = MyInvoiceItems[row-1]['ProdType'].toString();
					document.getElementById('txtProdCodeLAD' + sRow.toString()).value = MyInvoiceItems[row - 1]['ProdCode'].toString();
					document.getElementById('txtAmountLAD' + sRow.toString()).value = MyInvoiceItems[row - 1]['OriginalQty'].toString();
					document.getElementById('txtLineCommentsLAD' + sRow.toString()).value = MyInvoiceItems[row - 1]['Comments'].toString();
					document.getElementById('hfItemNbrLAD' + row.toString()).value = MyInvoiceItems[row - 1]['ItemNbr'].toString();
					document.getElementById('hfLineIDLAD' + row.toString()).value = MyInvoiceItems[row - 1]['InvReqItemID'].toString();
				}
			}
			return false;
		}

		function PopulateProdCodeListsLAD() {
			if(jbLoadedProdCodeList === false || IsContentsNullUndefinedGu(MyProductList)) {
				alert('getting data');
				GetProductList('');
				jbLoadedProdCodeList = true;
			}
			alert('loading lists - ' + MyProductList.length);
			if(!IsContentsNullUndefEmptyGu(MyProductList)) {
				ClearDDLOptionsGu('selProdCodeLAD01', 1);
				fillDropDownListGu(MyProductList, jselProdCodeLAD1, 0, 'description', 'product');
				alert('list2');
				ClearDDLOptionsGu('selProdCodeLAD02', 1);
				fillDropDownListGu(MyProductList, jselProdCodeLAD2, 0, 'description', 'product');
				alert('list3');
				ClearDDLOptionsGu('selProdCodeLAD03', 1);
				fillDropDownListGu(MyProductList, jselProdCodeLAD3, 0, 'description', 'product');
			}
			alert('Done!');
			return false;
		}

		function PopulateProdTypeListsMA() {
			//alert('loading');
			if(jbLoadedProdTypeList === false || IsContentsNullUndefinedGu(MyProdTypeList)) {
				GetProdTypeLists('', 0, 1);
				jbLoadedProdTypeList = true;
			}
			//alert('adding');
			if(!IsContentsNullUndefEmptyGu(MyProdTypeList)) {
				for(var row = 1; row <= jiNbrLinesMAC; row++) {
					ClearDDLOptionsGu('selProdTypeMACA' + row.toString(), 1);
					jselProdTypeMACA = document.getElementById('selProdTypeMACA' + row.toString());
					fillDropDownListGu(MyProdTypeList, jselProdTypeMACA, 0, 'ProductTypeCode', 'ProductTypeCode');
				}
			}
			return false;
		}

		function PopulateProdTypeListsLAD() {
			//alert('loading');
			if(jbLoadedProdTypeList === false || IsContentsNullUndefinedGu(MyProdTypeList)) {
				GetProdTypeLists('', 0, 1);
				jbLoadedProdTypeList = true;
			}
			//alert('adding');
			if(!IsContentsNullUndefEmptyGu(MyProdTypeList)) {
				ClearDDLOptionsGu('selProdTypeLAD01', 1);
				fillDropDownListGu(MyProdTypeList, jselProdTypeLAD1, 0, 'ProductTypeCode', 'ProductTypeCode');
				ClearDDLOptionsGu('selProdTypeLAD02', 1);
				fillDropDownListGu(MyProdTypeList, jselProdTypeLAD2, 0, 'ProductTypeCode', 'ProductTypeCode');
				ClearDDLOptionsGu('selProdTypeLAD03', 1);
				fillDropDownListGu(MyProdTypeList, jselProdTypeLAD3, 0, 'ProductTypeCode', 'ProductTypeCode');
			}
			return false;
		}

		function PopulateReasonList() {
			if(jbLoadedReasonList === false || IsContentsNullUndefEmptyGu(MyReasonList)) {
				GetReasonList(0, 1);
				jbLoadedReasonList = true;
			}
			//alert(MyReasonList.length);
			if(!IsContentsNullUndefEmptyGu(MyReasonList)) {
				ClearDDLOptionsGu('selReasonCodeE', 1);
				fillDropDownListGu(MyReasonList, jselReasonCodeE, 0, 'ItemDescription', 'ItemCode');
			}
			return false;
		}

		function PopulateReasonListRM() {
			if(jbLoadedReasonList === false || IsContentsNullUndefEmptyGu(MyReasonList)) {
				GetReasonList(0, 1);
				jbLoadedReasonList = true;
			}
			//alert(MyReasonList.length);
			if(!IsContentsNullUndefEmptyGu(MyReasonList)) {
				ClearDDLOptionsGu('selReasonCodeM', 1);
				fillDropDownListGu(MyReasonList, jselReasonCodeM, 0, 'ItemDescription', 'ItemCode');
			}
			return false;
		}

		function PopulateRequest() {
			if(!IsContentsNullUndefEmptyGu(MyInvRequestData)) {
				jhfInvoiceDate.value = MyInvRequestData[0]['sInvoiceDate'].toString();
				PopulateDocStatusFlow();
				// fill header line data
				jlRequestIDE.innerHTML = jiRequestID.toString();
				jsStatusCode = MyInvRequestData[0]['StatusCode'].toString();
				jselSetNewStatus.value = jsStatusCode;
				FillDocumentStatus(jsStatusCode);
				jtDateReqE.value = MyInvRequestData[0]['sDateRequested'].toString();
				jtReqByE.value = MyInvRequestData[0]['sFullName2'].toString();
				jhfReqByIDE.value = MyInvRequestData[0]['RequestedByID'].toString();
				if(MyInvRequestData[0]['sCriticalLevel'].toString() === 'Yes') {
					jchkCriticalImportance.checked = true;
				}
				else {
					jchkCriticalImportance.checked = false;
				}
				jtEmailsToInclude.value = MyInvRequestData[0]['ExtraEmailTo'].toString();
				jiNbrDocs = 0;
				for(var row = 0; row < MyRequestData.length; row++) {
					jiDocumentType = parseInt(MyRequestData[row]['DocDisplayTypeID'], 10);
					jiNbrDocs++;
					jsaDocType[jiNbrDocs] = MyRequestData[row]['DocTypeCode'].toString();
					switch(jiDocumentType) {
						//case 1:	//InvAdj-Rtn Manifest
						//	LoadInvAdjustmentData();
						//	LoadReturnManifestData();
						//	break;
						case 2:	//InvAdjustment Only
							LoadInvAdjustmentData();
							break;
						case 3:	//Return Manifest
							LoadReturnManifestData();
							break;
						case 4:	//Freight Accrual
							LoadFreightAccrualData();
							break;
						case 5:	//Vendor Claim
							LoadVendorClaimData();
							break;
						case 6:	//Loss & Damage Claim
							LoadLossDamageClaimData();
							break;
						case 7:	//Inventory Adjustment
							LoadInventoryAdjData();
							break;
						case 8:	//MAC Adjustment
							LoadMACAdjustData();
							break;
						case 9:	//Manual Credit
							LoadManualCreditData();
							break;
						case 10: //Cust Claim
							LoadCustClaimData();
							break;
						default:
							break;
					}
				}
				LoadDocTypesList();
			}
			return false;
		}

		function PopulateSalesLeadLists() {
			if(jbLoadedSalesLeadList === false || IsContentsNullUndefEmptyGu(MySalesLeadList)) {
				GetSalesGrpList();
				jbLoadedSalesLeadList = true;
			}
			if(!IsContentsNullUndefEmptyGu(MySalesLeadList)) {
				ClearDDLOptionsGu('selSalesLeadE', 1);
				fillDropDownListGu(MySalesLeadList, jselSalesLeadE, 0, 'Grp', 'Code');
			}
			return false;
		}

		function PopulateSalesLeadListsRM() {
			if(jbLoadedSalesLeadList === false || IsContentsNullUndefEmptyGu(MySalesLeadList)) {
				GetSalesGrpList();
				jbLoadedSalesLeadList = true;
			}
			if(!IsContentsNullUndefEmptyGu(MySalesLeadList)) {
				ClearDDLOptionsGu('selSalesLeadM', 1);
				fillDropDownListGu(MySalesLeadList, jselSalesLeadM, 0, 'Grp', 'Code');
			}
			return false;
		}

		function PopulateSalesStaffLists() {
			if(jbLoadedSalesStaffList === false || IsContentsNullUndefEmptyGu(MySalesPersList)) {
				GetSalesStaffList();
				//GetSalesPersonList(1);
				jbLoadedSalesStaffList = true;
			}
			if(!IsContentsNullUndefEmptyGu(MySalesLeadList)) {
				ClearDDLOptionsGu('selSalesRepE', 1);
				fillDropDownListGu(MySalesPersList, jselSalesRepE, 0, 'Grp', 'ID');
			}
			return false;
		}
		//#endregion PopulatePageObjectsR JS

		// **************************** Background *********************************

		// #region BackgroundFunctionsR JS
		function AddLineToTable(doctype, idx) {
			//alert('Line add: ' + doctype + '/' + idx);
			var col;
			var sRow = '';
			var srw = '';
			var val = '';
			row = document.createElement("tr");
			srw = idx.toString();
			sRow = srw;
			if(sRow.length < 2) { sRow = '0' + sRow; }
			switch(doctype) {
				case 'INVADJ':
					//alert('Adding line - rwProd' + sRow);
					row.id = 'rwProd' + sRow;
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtProdType' + srw + '" class="InputTextWNoBorder" style="width:34px;" />-<input type="text" id="txtProdCode' + srw + '" class="InputTextWNoBorder" style="width:70px;" />';
					val = val + '<input type="hidden" id="hfIAitemID' + srw + '" value="0" /><input type="hidden" id="hfIAitemNbr' + srw + '" value="0" />';
					val = val + '<input type="hidden" id="hfIAItemAttribs' + srw + '" value="" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', 'antiquewhite', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtProdDesc' + srw + '" class="InputTextWNoBorder" style="width:200px;background-color:antiquewhite;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtLineStatus' + srw + '" class="InputTextWNoBorder" style="width:40px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<button id="btnRemoveIAitem' + srw + '" class="button blue-gradient glossy" onclick="javascript:RemoveAIitem(' + srw + ');return false;" style="display:none;">Remove</button>';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', 'antiquewhite', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtOrigQty' + srw + '" class="InputTextWNoBorder" style="width:70px;background-color:antiquewhite;"  onchange="javascript:ChangeIAQty(' + srw + ', this.value);return false;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtRevQty' + srw + '" class="InputTextWNoBorder" style="width:70px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', 'antiquewhite', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtOrigPrice' + srw + '" class="InputTextWNoBorder" style="width:100px;background-color:antiquewhite;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtRevPrice' + srw + '" class="InputTextWNoBorder" style="width:100px;" onchange="javascript:ChangeIAPrice(' + srw + ', this.value);return false;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '#DDDDDD', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtTotalAmount' + srw + '" class="InputTextWNoBorder" style="width:120px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					//alert('inserting new row');
					InsertRowIntoTableGu('tblInvAdjForm', jiAddLineIDX + (idx - 6), row);
					//jiNbrProdsIA++;
					jiNbrLinesShownIA++;
					jiAddTicketIDX++;
					break;
				case 'RMANF':
					row.id = 'trRtnManifestItem' + sRow;
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtTKProdType' + srw + '" class="InputTextWNoBorder" style="width:34px;" />-<input type="text" id="txtTKProdCode' + srw + '" class="InputTextWNoBorder" style="width:70px;" />';
					val = val + '<input type="hidden" id="hfRMitemID' + srw + '" value="0" /><input type="hidden" id="hfRMitemNbr' + srw + '" value="0" />';
					val = val + '<input type="hidden" id="hfRMItemAttribs' + srw + '" value="0" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtTKTicketNbr' + srw + '" class="InputTextWNoBorder" style="width:200px"/>';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtTKStatus' + srw + '" class="InputTextWNoBorder" style="width:40px"/>';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<button id="btnRemoveRMitem' + srw + '" class="button blue-gradient glossy" onclick="javascript:RemoveRMitem(' + srw + ');return false;" style="display:none;">Remove</button>';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtTKQty' + srw + '" class="InputTextWNoBorder" style="width:80px"/>';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtTKTotalPkgCount' + srw + '" class="InputTextWNoBorder" style="width:80px"/>';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtTKQtyCheckedIn' + srw + '" class="InputTextWNoBorder" style="width:100px"/>';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="checkbox" id="chkTKRedTag' + srw + '" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '#DDDDDD', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="checkbox" id="chkTKInvAdj' + srw + '" />';
					col.innerHTML = val;
					row.appendChild(col);
					//alert('adding row - index: ' tblName + ' - ' + (jiAddTicketIDX + (idx - 10)).toString());
					if(jiDocumentType === 1) {
						InsertRowIntoTableGu('tblInvAdjForm', jiAddTicketIDX + (idx - 5), row);
					}
					else {
						InsertRowIntoTableGu('tblInvAdjForm', 15 + (idx - 5), row);
					}
					break;
				case 'MACADJ':
					row.id = 'trMACAdjustment' + sRow;
					col = CreateTableColumn('tdMACAdjust', 'StdTableCell', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<select id="selProdTypeMACA' + srw + '"><option value="0" selected="selected">Not Selected</option></select>';
					val = val + '<input type="hidden" id="hfLineIDMACAE' + srw + '" value="0" /><input type="hidden" id="hfItemNbrMACAE' + srw + '" value="0" />';
					val = val + '<input type="hidden" id="hfMACItemAttribs' + srw + '" value="0" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdMACAdjust', 'StdTableCell', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtProdCodeMACA' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdMACAdjust', 'StdTableCell', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<select id="selLocationMACA' + srw + '"><option value="0" selected="selected">Not Selected</option></select>';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdMACAdjust', 'StdTableCell', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtCostIDMACA' + srw + '" style="width:100px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdMACAdjust', 'StdTableCell', 0, 0, 'right', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtCurrentMACA' + srw + '" style="width:100px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdMACAdjust', 'StdTableCell', 0, 0, 'right', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtCorrectMACA' + srw + '" style="width:100px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdMACAdjust', 'StdTableCell', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtMACCostID' + srw + '" style="width:90px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdMACAdjust', 'StdTableCell', 0, 0, 'center', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<button id="btnRemoveMACItem' + srw + '" class="button blue-gradient glossy" onclick="javascript:RemoveMACItem(' + srw + ');return false;">Remove</button>';
					col.innerHTML = val;
					row.appendChild(col);
					InsertRowIntoTableGu(tblname, idx - 1, row);
					if(!IsContentsNullUndefEmptyGu(MyProdTypeList)) {
						var selpointer = document.getElementById('selProdTypeMACA' + srw);
						ClearDDLOptionsGu('selProdTypeMACA' + srw, 1);
						fillDropDownListGu(MyProdTypeList, selpointer, 0, 'ProductTypeCode', 'ProductTypeCode');
						//selProdTypeMACA' + srw 
					}
					if(!IsContentsNullUndefEmptyGu(MyLocationList)) {
						var selpointer = document.getElementById('selLocationMACA' + srw);
						ClearDDLOptionsGu('selLocationMACA' + srw, 1);
						fillDropDownListGu(MyLocationList, selpointer, 0, 'Name', 'loc');
					}
					jiNbrLinesMAC++;
					break;
				case 'INVCHG':
					row.id = 'trInventoryChg' + sRow;
					col = CreateTableColumn('tdInventChg', 'StdTableCellWBorder', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICLocation' + srw + '" style="width:60px;" />';
					val = val + '<input type="hidden" id="hfLineIDIAdjE' + srw + '" value="0" /><input type="hidden" id="hfItemNbrIAdjE' + srw + '" value="0" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg', 'StdTableCellWBorder', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICProdType' + srw + '" style="width:60px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg', 'StdTableCellWBorder', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICProdCode' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg', 'StdTableCellWBorder', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICChangedQty' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg', 'StdTableCellWBorder', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICChangedPieces' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg', 'StdTableCellWBorder', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr1_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg', 'StdTableCellWBorder', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr2_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg', 'StdTableCellWBorder', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr3_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg', 'StdTableCellWBorder', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr4_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg', 'StdTableCellWBorder', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr5_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg', 'StdTableCellWBorder', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr6_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg', 'StdTableCellWBorder', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr7_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg', 'StdTableCellWBorder', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr8_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg', 'StdTableCellWBorder', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr9_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg', 'StdTableCellWBorder', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr10_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg', 'StdTableCellWBorder', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr11_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg', 'StdTableCellWBorder', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr12_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg', 'StdTableCellWBorder', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr13_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg', 'StdTableCellWBorder', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICDetailedExp' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg', 'StdTableCellWBorder', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '_';
					col.innerHTML = val;
					row.appendChild(col);
					InsertRowIntoTableGu(tblname, idx - 1, row);
					jiNbrLinesInventoryAdj++;
					break;
				case 'LSSDMG':
					row.id = 'trLossDamage' + sRow;
					col = CreateTableColumn('tdLossDamage', 'StdTableCell', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<select id="selProdTypeLAD' + sRow + '" style="border:none;"><option value="0" selected="selected">None Selected</option></select>';
					val = val + '<input type="text" id="txtProdCodeLAD' + sRow + '" style="width:80px;" />';
					val = val + '<input type="hidden" id="hfLineIDLAD' + srw + '" value="0" /><input type="hidden" id="hfItemNbrLAD' + srw + '" value="0" />';
					val = val + '<input type="hidden" id="hfLADItemAttribs' + srw + '" value="0" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdLossDamage', 'StdTableCell', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtAmountLAD' + sRow + '" style="width:90px;border:none;text-align:right;" onchange="javascript:ChangeTotalClaimAmt();return false;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdLossDamage', 'StdTableCell', 0, 0, 'left', 'top', '', ''); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtLineCommmentsLAD' + sRow + '" style="width:320px;border:none;" />';
					col.innerHTML = val;
					row.appendChild(col);
					InsertRowIntoTableGu(tblname, idx - 1, row);
					jiNbrLinesLAD++;
					// load new selProdTypeLAD + sRow select list
					if(!IsContentsNullUndefEmptyGu(MyProdTypeList)) {
						var selpointer = document.getElementById('selProdTypeLAD' + sRow);
						ClearDDLOptionsGu('selProdTypeLAD' + sRow, 1);
						fillDropDownListGu(MyProdTypeList, selpointer, 0, 'ProductTypeCode', 'ProductTypeCode');
					}
					break;
				default:
					break;
			}

			// change 
			if(doctype === 'INVADJ') { jiTableRowIdxRM++; }
			return false;
		}

		function CreateTableColumn(id, cls, wdth, ht, horient, vorient, bcolor, fcolor) {
			var col = document.createElement("td");
			if(id !== '') { col.id = id; }
			if(cls !== '') { col.className = cls; }
			if(wdth > 0) { col.style.width = wdth.toString() + 'px'; }
			if(ht > 0) { col.style.height = ht.toString() + 'px'; }
			if(horient !== '') { col.style.textAlign = horient; }
			if(vorient !== '') { col.style.verticalAlign = vorient; }
			if(bcolor !== '') { col.style.backgroundColor = bcolor; }
			if(fcolor !== '') { col.style.color = fcolor; }
			return col;
		}

		function FillDocumentStatus(stat) {
			switch(stat) {
				case 'U':
					jlRequestStatusH.innerHTML = 'Unsubmitted';
					break;
				case 'SB':
					jlRequestStatusH.innerHTML = 'Submitted';
					break;
				case 'AP':
					jlRequestStatusH.innerHTML = 'In Approval';
					break;
				case 'AC':
					jlRequestStatusH.innerHTML = 'Approved';
					break;
				case 'RJ':
					jlRequestStatusH.innerHTML = 'Rejected';
					break;
				case 'HLD':
					jlRequestStatusH.innerHTML = 'Hold';
					break;
				case 'CMP':
					jlRequestStatusH.innerHTML = 'Complete';
					break;
				case 'VL':
					jlRequestStatusH.innerHTML = 'In Validation';
					break;
				case 'CX':
					jlRequestStatusH.innerHTML = 'Canceled';
					break;
				case 'SPR':
					jlRequestStatusH.innerHTML = 'Superceded';
					break;
				default:
					break;
			}
		}

		function InitializeInvAdj() {
			GetInvoiceAdjData();
			if(!IsContentsNullUndefEmptyGu(MyInvAdjData)) {
				jiInvoiceID = parseInt(MyInvAdjData[0]['InvoiceNbr'], 10);
				GetInvoiceData();
			}
			PopulateInvRequest();
			return false;
		}

		function InitiateInvAdjLines() {
			//var nlines = jiNbrProdsIA;
			var sRow = '';
			//if (nlines < 5) { nlines = 5; }
			//alert(jiNbrProdsIA);
			for(var row = 1; row <= jiNbrProdsIA; row++) {
				sRow = row.toString();
				if(sRow.length < 2) { sRow = '0' + sRow; }
				if(row <= 5) {
					//alert('rwProd' + sRow);
					document.getElementById('rwProd' + sRow).style.display = 'table-row';
				}
				else {
					//alert('adding a new line for ' + sRow);
					AddLineToTable('INVADJ', row);
				}
				document.getElementById('txtProdType' + row.toString()).value = '';
				document.getElementById('txtProdCode' + row.toString()).value = '';
				document.getElementById('txtProdDesc' + row.toString()).value = '';
				document.getElementById('txtLineStatus' + row.toString()).value = '';
				document.getElementById('txtOrigQty' + row.toString()).value = '';
				document.getElementById('txtRevQty' + row.toString()).value = '';
				document.getElementById('txtOrigPrice' + row.toString()).value = '';
				document.getElementById('txtRevPrice' + row.toString()).value = '';
				document.getElementById('txtTotalAmount' + row.toString()).value = '0';
				document.getElementById('btnRemoveIAitem' + row.toString()).style.display = 'none';
			}
			return false;
		}

		function InitiateMACAdjustLines() {
			var sRow = '';
			//alert('Total Rows: ' + jiNbrProdsRM);
			for(var row = 1; row <= jiNbrLinesMAC; row++) {
				sRow = row.toString();
				if(sRow.length < 2) { sRow = '0' + sRow; }
				if(row <= 1) {
					document.getElementById('trMACAdjustItem' + row.toString()).style.display = 'table-row';
					document.getElementById('btnRemoveMACItem1').style.display = 'none';
				}
				else {
					//alert('adding a new line for ' + sRow);
					AddLineToTable('MACADJ', row);
					document.getElementById('btnRemoveMACItem' + row.toString()).style.display = 'inline';
				}
				document.getElementById('selProdTypeMACA' + row.toString()).value = '0';
				document.getElementById('hfItemNbrMACAE' + row.toString()).value = '0';
				document.getElementById('hfLineIDMACAE' + row.toString()).value = '0';
				document.getElementById('txtProdCodeMACA' + row.toString()).value = '';
				document.getElementById('selLocationMACA' + row.toString()).value = '0';
				document.getElementById('txtCostIDMACA' + row.toString()).value = '';
				document.getElementById('txtCurrentMACA' + row.toString()).value = '';
				document.getElementById('txtCorrectMACA' + row.toString()).value = '';
				document.getElementById('txtMACCostID' + row.toString()).value = '';
			}
			//alert('done with line initiation');
			return false;
		}

		function InitiateRtnManfLines() {
			var sRow = '';
			//alert('Total Rows: ' + jiNbrProdsRM);
			for(var row = 1; row <= jiNbrProdsRM; row++) {
				sRow = row.toString();
				if(sRow.length < 2) { sRow = '0' + sRow; }
				if(row <= 5) {
					document.getElementById('trRtnManifestItem' + sRow).style.display = 'table-row';
				}
				else {
					//alert('adding a new line for ' + sRow);
					AddLineToTable('RMANF', row);
				}
				document.getElementById('txtTKProdType' + row.toString()).value = '';
				document.getElementById('txtTKProdCode' + row.toString()).value = '';
				document.getElementById('hfRMitemID' + row.toString()).value = '0';
				document.getElementById('txtTKTicketNbr' + row.toString()).value = '';
				document.getElementById('txtTKStatus' + row.toString()).value = '';
				document.getElementById('txtTKQty' + row.toString()).value = '';
				document.getElementById('txtTKTotalPkgCount' + row.toString()).value = '';
				document.getElementById('txtTKQtyCheckedIn' + row.toString()).value = '';
				document.getElementById('btnRemoveRMitem' + row.toString()).style.display = 'inline';
				document.getElementById('chkTKRedTag' + row.toString()).checked = false;
				document.getElementById('chkTKInvAdj' + row.toString()).checked = false;
			}
			//alert('done with line initiation');
			return false;
		}

		function InitiateLossDamageLines() {
			var sRow = '';
			//alert('Total Rows: ' + jiNbrProdsRM);
			for(var row = 1; row <= jiNbrLinesLAD; row++) {
				sRow = row.toString();
				if(sRow.length < 2) { sRow = '0' + sRow; }
				if(row <= 3) {
					document.getElementById('trLossDamage' + sRow).style.display = 'table-row';
				}
				else {
					//alert('adding a new line for ' + sRow);
					AddLineToTable('LSSDMG', row);
				}
				document.getElementById('selProdTypeLAD' + sRow.toString()).value = '0';
				document.getElementById('txtProdCodeLAD' + sRow.toString()).value = '';
				document.getElementById('txtAmountLAD' + sRow.toString()).value = '0';
				document.getElementById('txtLineCommentsLAD' + sRow.toString()).value = '';
				document.getElementById('hfItemNbrLAD' + row.toString()).value = '0';
				document.getElementById('hfLineIDLAD' + row.toString()).value = '0';
			}
			//alert('done with line initiation');
			return false;
		}

		function IsComponentShown(doctype) {
			var shown = false;
			for(var i = 2; i <= 10; i++) {
				if(jsaDocType[i] === doctype) {
					shown = true;
					break;
				}
			}
			return shown;
		}

		function LoadDocTypesList() {
			var lst = '';
			for(var i = 0; i < 6; i++) {
				//alert(jsaDocType[i]);
				if(jsaDocType[i] !== '') {
					if(lst.length > 0) { lst = lst + '; '; }
					lst = lst + jsaDocType[i];
				}
			}
			//alert(lst);
			jlIncludedSections.innerHTML = lst;
			return false;
		}

		function RemoveLineFromTable(doctype, idx) {
			var tblname = '';
			switch(doctype) {
				case 'INVADJ':
					tblname = 'tblInvAdjForm';
					break;
				case 'RMANF':
					tblname = 'tblInvAdjForm';
					break;
				case 'MACADJ':
					tblname = 'tblMACAdjustment';
					break;
				case 'INVCHG':
					tblname = 'tblInvChangeItems';
					break;
				case 'LSSDMG':
					tblname = 'tblLADProducts';
					break;
				default:
					break;
			}
			RemoveRowFromTableGu(tblname, idx);
			return false;
		}
		// #endregion BackgroundFunctionsR JS

		// **************************** Dialogs *********************************

		// #region DialogFunctionsR JS
		function DeleteOneRec(id, row, objid) {
			if(id > 0) {
				switch(objid) {
					case 1: //status change -NO LINE REMOVAL
						//RemoveLineFromTable(doctype, row);
						break;
					case 2:
						DeleteAnAttachment(jiInvoiceReqID, id);
						PopulateAttachmentList();
						RemoveLineFromTable(doctype, row);
						break;
					case 3:
						RemoveLineFromTable('LSSDMG', row);
						break;
					case 4:
						RemoveLineFromTable('MACADJ', row);
						break;
					case 5:
						RemoveLineFromTable('INVADJ', row);
						break;
					case 6:
						RemoveLineFromTable('RMANF', row);
						break;
					default:
						break;
				}
			}
			return false;
		}

		function ShowOneAttachment(row, id) {
			//	if (jbEditCapable === true) {
			var ht = 240;
			var typ = 1;
			var wt = 700;
			var ttl = 'Request Attachment Data'
			var content = '';
			if(id > 0) {
				typ = 2;
			}

			// fill content type picklist if it has been previously
			//if (jbContentTypesLoaded1 === false) {
			//	if (MyContentTypes !== undefined && MyContentTypes !== null) {
			//		if (MyContentTypes.length > 0) {
			//			fillDropDownListGu(MyContentTypes, joSelContentTypeE, 0, 'ContentTypeDes', 'ContentType');
			//		}
			//	}
			//	jbContentTypesLoaded1 = true;
			//}

			//FillAttachmentData(row, id);
			showPopupEditBoxDb('divAttachData', ttl, true, true, ht, wt, '', '', window, '', typ, 11, 1, 'fadeIn', 'fadeOut', '', '', 3);
			//}
			return false;
		}
		// #endregion DialogFunctionsR JS

		// **************************** Attachments *********************************

		// #region AttachmentFunctionsR JS
		function DeleteOneAttachment(id, row) {
			if(id > 0) {
				DeleteAnAttachment(id);
			}
			return false;
		}

		function DeleteSelectedAttachments() {
			ShowStatisBlockMsg(2, '');
			var id = 0;
			var rows = document.getElementsByName('chkSelObj2');
			//alert(rows.length);
			for(var row = 0; row < rows.length; row++) {
				if(rows[row].checked === true) {
					id = parseInt(MyAttachments[row].DocID, 10);
					//alert('ID ' + id.toString());
					DeleteOneAttachment(id, row);
				}
			}
			GetAttachments();
			return false;
		}

		function EnterAttachAttributes(id) {
			// file content is in divPopup
			var ctypecode = '0';
			var docttl = '';
			var ht = 300;
			var ttl = 'Enter Attachment Attributes';
			var wdth = 500;

			var content = '<table>';
			content = content + '<tr><td>Document Title</td><td><input type="text" id="txtDocTitleE" value="' + docttl + '" style="width:200px;" /></td><td>&nbsp;</td><td>Content Type</td><td>';
			content = content + '<select id=""><option value="0" selected="selected">Not Selected</option>';
			if(MyContentTypes !== undefined || MyContentTypes !== null) {
				if(MyContentTypes.length > 0) {

				}
			}
			content = content + '</td></tr><tr><td colspan="5">';
			content = content + '<input type="file" id="MyFile" />';
			//content = content + '</td></tr><tr><td colspan="5">';
			content = content + '</td><tr></table>';
			ShowSpecialDialogBox1Dx('divPopup', ttl, true, true, ht, wdth, '', '', window, content, 'Save', 11, 1, 'fadeIn', 'fadeOut', 2);
			return false;
		}

		function FillAttachmentData(row, id) {
			//var ctype = '0';
			//var fname = '';
			//var ttl = '';
			//jiCurrentAID = parseInt(id, 10);
			//jiCurrentRowA = parseInt(row, 10);
			//jiAttachLineID = parseInt(id, 10);
			//jiAttachRowID = parseInt(row, 10);
			//if (jiAttachLineID > 0) {
			//	ctype = MyAttachments[row].ContentType.toString();
			//	ttl = MyAttachments[row].DocTitle.toString();
			//	fname = MyAttachments[row].FileName.toString();
			//}
			//jolAttachIDE.innerHTML = id.toString();
			//jolAttachFNameE.innerHTML = fname;
			//jotAttachDocNameE.value = ttl;
			//joSelContentTypeE.value = ctype;
			return false;
		}

		function viewAttachedFile(docid) {
			jsErrorMsg = '';
			window.open('ViewAttachment.aspx?d=' + docid, 'Attachment', 'height=500,width=775,left=150,top=150,location=no,menubar=no,resizable=no, scrollbars=yes, titlebar=yes, toolbar=no', true);
			return false;
		}
		// #endregion AttachmentFunctionsR JS

		// **************************** TABs *********************************

		function SetTabVisible(tb) {
			switch(tb) {
				case 1:
					jdivTab1.style.display = 'block';
					jdivTab2.style.display = 'none';
					jdivTab3.style.display = 'none';
					jdivHideBottomLine.style.display = 'block';
					jdivHideBottomLine.style.position = 'absolute';
					jdivTabHdr1.style.backgroundColor = 'white';
					jdivTabHdr2.style.backgroundColor = '#D1D0CE';
					jdivTabHdr3.style.backgroundColor = '#D1D0CE';
					jdivHideBottomLine.style.top = '176px';
					jdivHideBottomLine.style.left = '16px';
					break;
				case 2:
					jdivTab1.style.display = 'none';
					jdivTab2.style.display = 'block';
					jdivTab3.style.display = 'none';
					jdivHideBottomLine.style.display = 'block';
					jdivHideBottomLine.style.position = 'absolute';
					jdivHideBottomLine.style.top = '176px';
					jdivHideBottomLine.style.left = '170px';
					jdivTabHdr1.style.backgroundColor = '#D1D0CE';
					jdivTabHdr2.style.backgroundColor = 'white';
					jdivTabHdr3.style.backgroundColor = '#D1D0CE';
					break;
				case 3:
					jdivTab1.style.display = 'none';
					jdivTab2.style.display = 'none';
					jdivTab3.style.display = 'block';
					jdivHideBottomLine.style.display = 'block';
					jdivHideBottomLine.style.position = 'absolute';
					jdivHideBottomLine.style.top = '176px';
					jdivHideBottomLine.style.left = '324px';
					jdivTabHdr1.style.backgroundColor = '#D1D0CE';
					jdivTabHdr2.style.backgroundColor = '#D1D0CE';
					jdivTabHdr3.style.backgroundColor = 'white';
					break;
				default:
					jdivTab1.style.display = 'none';
					jdivTab2.style.display = 'none';
					jdivTab3.style.display = 'none';
					jdivTabHdr1.style.backgroundColor = '#D1D0CE';
					jdivTabHdr2.style.backgroundColor = '#D1D0CE';
					jdivTabHdr3.style.backgroundColor = '#D1D0CE';
					jdivHideBottomLine.style.display = 'none';
					break;
			}
			return false;
		}

		// **************************** UI *********************************

		function AddDocumentType() {
			SetTabVisible(1);
			if(jiDocumentType === parseInt(jselDocumentType.value, 10)) { return false; }
			if(jsDocType[0] === '') {
				alert('The initial document type must be established using "New Request" button before you can add a document type to it.');
				return false;
			}
			jiDocumentType = parseInt(jselDocumentType.value, 10);
			if(jiDocumentType < jiMinDocumentType || jiMinDocumentType === 0) { jiMinDocumentType = jiDocumentType; }
			SetDocType();
			//alert(jsDocType + '/' + )
			if(IsComponentShown(jsDocType) === true || FindFirstMatchValueInJSONArrayGu('DocTypeCode', jsDocType, MyDocTypeAssociations) === -1) {
				alert('This component type cannot be added to a request having the first type chosen.');
				return false;
			}

			//alert(jsDocType + '/' + jsDocName);
			// if doctype not already in use show it
			if(!IsComponentShown(jsDocType) && jiNbrDocs < 6) {
				GetUserDocRights(jsDocType);
				//alert('Right ' + jiDocRightLevel);
				//alert(jsDocType + ' BEGIN - gets rights');
				jdivFormFooter.style.display = 'block';
				//alert(jiDocRightLevel);
				if(jiDocRightLevel > 0) {
					// set doc type in list
					jsaDocType[jiNbrDocs] = jsDocName;
					jiNbrDocs++;
					LoadDocTypesList();
					//alert('handling doc type');
					switch(jiDocumentType) {
						case 0:
							jtFindInvoiceNbr.readOnly = true;
							jtRequestIDE.readOnly = true;
							jtRequestIDE.value = '0';
							jdivFormFooter.style.display = 'none';
							jdivFormBlank.style.display = 'block';
							break;
						case 2: // InvAdjustment Only
							jbShowInvAdj = false;
							PopulateCarrierList();
							PopulateCreditRepLists();
							PopulateSalesLeadLists();
							PopulateLocationLists();
							PopulateDestinationList();
							PopulateSalesLeadLists();
							PopulateSalesStaffLists();
							PopulateReasonList();
							jdivInvAdjManifest.style.display = 'block';
							ChangeInvAdjManifestView(2, 1);
							SetTextBoxAutoComplete2Wc('txtCustNameE', 3, jhfCustCodeE, MyCustomerData, 'cust', 'CustName');
							jspnAttachMessage.style.display = 'inline';
							break;
						case 3: // Return Manifest
							jbShowRManf = false;
							jtRequestedByM.value = jsUserName;
							jhfRequestedByIDM.value = jiByID.toString();
							//alert('1');
							PopulateCarrierList();
							PopulateCreditRepLists();
							//alert('2');
							PopulateSalesLeadLists();
							PopulateLocationLists();
							//alert('3');
							PopulateDestinationList();
							PopulateSalesLeadLists();
							//alert('4');
							PopulateSalesStaffLists();
							PopulateReasonList();
							//alert('5');
							jdivInvAdjManifest.style.display = 'block';
							ChangeInvAdjManifestView(3, 1);
							//alert('6');
							if(jsaDocType[0] !== 'INVADJ') {
								SetTextBoxAutoComplete2Wc('txtCustNameM', 3, jhfCustCodeLAD, MyCustomerData, 'cust', 'CustName');
							}
							//alert('7');
							jspnAttachMessage.style.display = 'inline';
							//alert('Done!');
							break;
						case 4: // Freight Accrual
							//alert('Freight Accrual');
							jdivFreightAccrual.style.display = 'block';
							jspnAttachMessage.style.display = 'inline';
							break;
						case 5: //Vendor Claim
							//alert('Vendor Claim');
							jdivVendorClaim.style.display = 'block';
							jspnAttachMessage.style.display = 'inline';
							break;
						case 6:	// Loss & Damage Claim
							//alert('Loss and Damage');
							PopulateProdTypeListsLAD();
							jdivLossAndDamageClaim.style.display = 'block';
							SetTextBoxAutoComplete2Wc('txtCustomerLAndD', 3, jhfCustCodeLAD, MyCustomerData, 'cust', 'CustName');
							jspnAttachMessage.style.display = 'inline';
							break;
						case 7: // Inventory Adjustment
							jdivInventoryChangeReq.style.display = 'block';
							jspnAttachMessage.style.display = 'inline';
							GetInvoiceItems(jsDocType);
							if(!IsContentsNullUndefEmptyGu(MyInvoiceItems)) {
								PopulateInventoryChgItems();
							}
							jdivInventoryChangeReq.style.display = 'block';
							jspnAttachMessage.style.display = 'inline';
							break;
						case 8: // MAC Adjustment
							PopulateProdTypeListsMA();
							PopulateLocationListsMA();
							jdivMACAdjustment.style.display = 'block';
							jspnAttachMessage.style.display = 'inline';
							break;
						case 9: // Manual credit
							jdivManualCredit.style.display = 'block';
							jspnAttachMessage.style.display = 'inline';
							break;
						case 10: // Cust Claim
							jdivCustClaim.style.display = 'block';
							jspnAttachMessage.style.display = 'inline';
							break;
						default:
							break;
					}
					if(jtRequestIDE.value !== '') {
						jiRequestID = jtRequestIDE.value;
						PopulateRequest();
					}
					if(jiInvoiceID !== 0) {
						PopulateInvoiceData();
					}
				}
				else {
					alert('You do not have rights for this type of document.');
				}
				PopulateDocStatusFlow(jiRequestID);
			}
			return false;
		}

		// modifies main table with 2 portions to only display appropriate part
		function ChangeInvAdjManifestView(typ, isshow) {
			var sRow = '';
			//alert('Type: ' + typ + '-Part 1');
			if(isshow === 0) {
				HideOnePortion(typ);
			}
			else {
				ShowOnePortion(typ);
			}
			return false;
		}

		function ChangeInvRequestStatus(val) {
			if(val !== '0') {



			}
			return false;
		}

		function ChangePageSize(val) {
			jiPageSize = parseInt(val, 10);





			return false;
		}

		function ChangePageSize2(val) {
			jiPageSize2 = parseInt(val, 10);
			GetAttachmentList(jsDocType, jiInvoiceReqID, '');



			return false;
		}

		//INVADJ	Invoice Adjustment, INVCHG	Inventory Change Request, LSSDMG	Loss & Damage Claim, RMANF	Return Manifold, FRTACC	Freight Accrual, VENDCLM	Vendor Claim, MACADJ	MAC Adjustment, MNLCRED	Manual Credit, CUSTCLM
		function FindRequest() {
			var fig = parseInt(jtRequestIDE.value, 10);
			if(jiRequestID !== fig) {
				HideAllAreas();
				jiRequestID = fig;
				GetRequestData(jiRequestID);  // MyRequestData
				jsStatusCode = 'U';
				if(!IsContentsNullUndefEmptyGu(MyRequestData)) {
					PopulateDocStatusFlow(jiRequestID);
					jsStatuscode = MyRequestData[0]['StatusCode'].toString();
					if(jsStatusCode === 'U') {
						jspnDocumentTypeLabel.style.display = 'inline';
						jspnDocumentTypeList.style.display = 'inline';
					}
					else {
						jspnDocumentTypeLabel.style.display = 'none';
						jspnDocumentTypeList.style.display = 'none';
					}
					jiInvoiceReqID = parseInt(jtRequestIDE.value, 10);
					jbLoadedInvoiceItems = false;
					GetUserDocRights(jsaDocType[0]);
					PopulateRequest();
					jspnAttachMessage.style.display = 'inline';
					jspnRightAttachDrop.style.display = 'none';
					// stop changes if 
					if(jiDocRightLevel < 3) {
						jspnSaveRequest.style.display = 'none';
						jspnExportToPDFbtn.style.display = 'none';
						document.getElementById('files[]').style.display = 'none';
						if(IsComponentShown('INVADJ')) { EnableItemRows(2, 'none'); }
						if(IsComponentShown('RMANF')) { EnableItemRows(3, 'none'); }
					}
					else {
						jspnSaveRequest.style.display = 'inline';
						jspnExportToPDFbtn.style.display = 'inline';
						document.getElementById('files[]').style.display = 'inline';
						if(IsComponentShown('INVADJ')) { EnableItemRows(2, 'inline'); }
						if(IsComponentShown('RMANF')) { EnableItemRows(3, 'inline'); }
					}
					PopulateDocStatusChanges();
					PopulateAttachmentList();
					LoadDocTypesList();
					if(jsStatusCode === 'U') {
						jbtnAddNewType2.style.display = 'inline';
					}
					else {
						jbtnAddNewType2.style.display = 'none';
					}
				}
				else {
					alert('No Request data was found matching that number.');
				}
			}
			return false;
		}

		function EnableItemRows(itm, showitem) {
			switch(itm) {
				case 2:
					for(var row = 1; row <= jiNbrLinesShownIA; row++) {
						document.getElementById('btnRemoveIAitem' + row.toString()).style.display = showitem;
					}
					break;
				case 3:
					for(var row = 1; row <= jiNbrLinesShownRM; row++) {
						document.getElementById('btnRemoveIAitem' + row.toString()).style.display = showitem;
					}
					break;
				default:
					break;
			}
		}

		function FindInvoiceNbr() {
			var fig = parseInt(jtFindInvoiceNbr.value, 10);
			if(jiInvoiceID !== fig) {
				jbLoadedInvoiceItems = false;
				jiInvoiceID = parseInt(jtFindInvoiceNbr.value, 10);
				//alert('Getting Invoice data');
				GetInvoiceData(); //MyInvoiceData
				//alert('Getting items');
				GetInvoiceItems(jsDocType); //MyInvoiceItems
				//alert('populating invoice data');
				PopulateInvoiceData();
				jhfInvoiceID.value = jiInvoiceID.toString();
			}
			return false;
		}

		function HideAllAreas() {
			jdivInvAdjManifest.style.display = 'none';
			jdivInventoryChangeReq.style.display = 'none';
			jdivLossAndDamageClaim.style.display = 'none';
			jdivFreightAccrual.style.display = 'none';
			jdivVendorClaim.style.display = 'none';
			jdivMACAdjustment.style.display = 'none';
			jdivManualCredit.style.display = 'none';
			jdivCustClaim.style.display = 'none';
			jspnSaveRequest.style.display = 'none';
			jspnExportToPDFbtn.style.display = 'none';
			jbShowInvAdj = false;
			jbShowRManf = false;
			HideOnePortion(2);
			HideOnePortion(3);
			return false;
		}

		function HideOnePortion(typ) {
			if(typ === 2) {
				//alert('hidding Part 1');
				for(var row3 = 1; row3 <= 16; row3++) {
					sRow = row3.toString();
					if(sRow.length < 2) { sRow = '0' + sRow; }
					document.getElementById('trInvAdjRow' + sRow).style.display = 'none';
				}
				//alert('hidding Part 1 items - ' + jiNbrProdsIA);
				for(var row4 = 1; row4 <= jiNbrProdsIA; row4++) {
					sRow = row4.toString();
					if(sRow.length < 2) { sRow = '0' + sRow; }
					document.getElementById('rwProd' + sRow).style.display = 'none';
				}
			}
			else {
				//alert('hidding Part 2');
				for(var row7 = 0; row7 <= 16; row7++) {
					sRow = row7.toString();
					if(sRow.length < 2) { sRow = '0' + sRow; }
					document.getElementById('trRtnManifestRow' + sRow).style.display = 'none';
				}
				//alert('hidding Part 2 items');
				for(var row6 = 1; row6 <= jiNbrProdsRM; row6++) {
					sRow = row6.toString();
					if(sRow.length < 2) { sRow = '0' + sRow; }
					document.getElementById('trRtnManifestItem' + sRow).style.display = 'none';
				}
			}
			return false;
		}

		function LoadInvoiceAdjData() {


			return false;
		}

		// Set form for a new form of whatever type
		function NewInvRequest() {
			SetTabVisible(1);
			jbtnAddNewType2.style.display = 'inline';
			jiDocumentType = parseInt(jselDocumentType.value, 10);
			if(jiDocumentType === 0) {
				alert('You have not selected your initial document type. Please select one before clicking on New Request.');
			}
			if(jiDocumentType > 0) {
				jiNbrDocs = 1;
				SetDocType(); //		jsDocType/jsDocName filled in
				//alert(jsDocType);
				GetUserDocRights(jsDocType);
				if(jiAR > 1) {
					jspnSaveRequest.style.display = 'inline';
					jspnExportToPDFbtn.style.display = 'inline';
				}
				else {
					jtFindInvoiceNbr.readOnly = true;
					jtRequestIDE.readOnly = true;
					jspnSaveRequest.style.display = 'none';
					if(jiAR === 0) {
						return false;
					}
				}
				jiRequestID = 0;
				jiInvoiceID = 0;
				jiInvoiceReqID = 0;
				document.getElementById('txaGenCommentIAE').value = '';
				jbLoadedInvoiceItems = false;
				jtFindInvoiceNbr.readOnly = false;
				jtRequestIDE.readOnly = false;
				jtRequestIDE.value = '0';
				jsStatusCode = 'U';
				FillDocumentStatus(jsStatusCode);
				jiaInvoiceReqID = [0, 0, 0, 0, 0, 0];
				jsaDocType = [jsDocName, '', '', '', '', ''];
				GetDocTypeAssociations(); // load MyDocTypeAssociations
				//alert(jsaDocType);
				if(jiDocRightLevel > 1) {
					//alert('hiding areas');
					jiNbrLinesShownIA = 5;
					jiNbrLinesShownRM = 5;
					jiNbrLinesLAD = 3;
					jiNbrLinesMAC = 1;
					HideAllAreas();
					LoadDocTypesList();
					jspnAttachMessage.style.display = 'inline';
					jspnRightAttachDrop.style.display = 'none';
					jdivInvAdjManifest.style.display = 'block';
					jsDocumentStatus = 'U';
					FillDocumentStatus(jsStatusCode);
					jselSetNewStatus.value = 'U';
					//alert('Getting doc status');
					jselDocumentType.value = '0';
					jtFindInvoiceNbr.value = '';
					
					jtDateReqE.value = jsToday;
					//alert('Getting status flow');
					PopulateDocStatusFlow(0);
					jiNbrLinesShownIA = 5;
					jiAddLineIDX = 16;
					jiAddTicketIDX = 39;
					jtReqByE.value = jsUserName;
					jhfReqByIDE.value = jiByID;
					jdivFormBlank.style.display = 'none';
					switch(jiDocumentType) {
						case 2:	//InvAdjustment Only
							//alert('new inv adj');
							//EnableItemRows(2, 'table-row');
							jiNbrProdsIA = 5;
							ShowOnePortion(2);
							NewInvAdjSection();
							jbShowInvAdj = false;
							PopulateCreditRepLists();
							PopulateSalesLeadLists();
							PopulateLocationLists();
							PopulateSalesLeadLists();
							PopulateSalesStaffLists();
							PopulateReasonList();
							jdivInvAdjManifest.style.display = 'block';
							ChangeInvAdjManifestView(2, 1);
							SetTextBoxAutoComplete2Wc('txtCustNameE', 3, jhfCustCodeE, MyCustomerData, 'cust', 'CustName');
							jspnAttachMessage.style.display = 'inline';
							break;
						case 3:	//Return Manifest
							EnableItemRows(3, 'table-row');
							jiNbrProdsRM = 5;
							ShowOnePortion(3);
							NewRtnManifest();
							jbShowRManf = false;
							jtRequestedByM.value = jsUserName;
							jhfRequestedByIDM.value = jiByID.toString();
							PopulateCarrierList();
							PopulateCreditRepListsRM();
							PopulateSalesLeadListsRM();
							PopulateLocationListsRM();
							PopulateDestinationList();
							PopulateReasonListRM();
							//alert('2');
							jdivInvAdjManifest.style.display = 'block';
							//ChangeInvAdjManifestView(3, 1);
							//alert('3');
							SetTextBoxAutoComplete2Wc('txtCustNameM', 3, jhfCustCodeLAD, MyCustomerData, 'cust', 'CustName');
							//alert('4');
							jspnAttachMessage.style.display = 'inline';
							break;
						case 4:	//Freight Accrual
							jdivInvAdjManifest.style.display = 'block';
							NewFreightAccrual();
							break;
						case 5:	//Vendor Claim
							jdivInvAdjManifest.style.display = 'block';
							NewVendorClaim();
							break;
						case 6:	//Loss & Damage Claim
							jdivInvAdjManifest.style.display = 'block';
							NewLossAndDamageClaim();
							break;
						case 7:	//Inventory Adjustment
							jdivInvAdjManifest.style.display = 'block';
							NewInventoryAdj();
							break;
						case 8:	//MAC Adjustment
							NewMACAdjustment();
							break;
						case 9:	//Manual Credit
							jdivInvAdjManifest.style.display = 'block';
							NewManualCredit();
							break;
						case 10: //Cust claim
							jdivInvAdjManifest.style.display = 'block';
							NewCustClaim();
							break;
						default:
							jdivFormBlank.style.display = 'block';
							break;
					}
					// remove status changes
					PopulateDocStatusChanges();
					// remove attachment list
					PopulateAttachmentList();
					PopulateDocTypes();
				}
				else {
					alert('You do not have rights to create a new request.');
				}
			}
			return false;
		}

		function SaveRequest() {
			var aamt = 0;
			var act = 1;
			var aiamt = 0;
			var ardt = '';
			var byid = parseInt(jhfReqByIDE.value, 10);
			var cid = 0;
			var crc = 0;
			var crepid = 0;
			var cmt = '';
			var critical = 0;
			var cust = '';
			var dtreq = jtDateReqE.toString();
			var emailto = jtEmailsToInclude.value;
			var frate = 0;
			var ia = 0;
			var idt = jhfInvoiceDate.value;
			var mbid = 0;
			var mannt = 0; //
			var nprod = 0;
			var ntick = 0;
			var oamt = 0;
			var onbr = 0;
			var rc = '';
			var rm = 0;
			var rdet = '';
			var rrdt = '';
			var rrtn = '';
			var spid = 0;
			var stat = jselSetNewStatus.value;
			var slead = '';
			var sto = '';
			var tonbr = 0;
			var val = '';
			var reqon = '';
			var doctypes = jsaDocType.join().replace(/,/g, ';');
			if(jchkCriticalImportance.checked === true) { critical = 1; }
			jiRequestID = parseInt(jlRequestIDE.innerHTML, 10);
			// update main request record
			UpdateRequestData(jiRequestID, sdate, byid, jiMinDocumentType, stat, jiNbrDocs, critical, cmt, emailto, doctypes, reqon, 1);

			// Save doc types data
			for(var itm = 0; itm < jiNbrDocs; itm++) {
				jiDocumentType = jiaInvoiceReqID[itm];
				switch(jiDocumentType) {
					//case 1:	//InvAdj-Rtn Manifest
					//	SaveInvoiceAdjLines();
					//	break;
					case 2:	//InvAdjustment Only
						SaveInvoiceAdjLines();
						break;
					case 3:	//Return Manifest
						SaveRtnManifestLines();
						break;
					case 4:	//Freight Accrual
						SaveFreightAccrual();
						break;
					case 5:	//Vendor Claim
						SaveVendorClaim();
						break;
					case 6:	//Loss & Damage Claim
						SaveLossDamageLines();
						break;
					case 7:	//Inventory Adjustment
						SaveInvChangeLines();
						break;
					case 8:	//MAC Adjustment
						SaveMACAdjustLines();
						break;
					case 9:	//Manual Credit
						SaveManualCredit();
						break;
					case 10: //Cust Claim
						SaveCustClaim();
						break;
					default:
						break;
				}
			}
			PopulateDocStatusFlow(jiRequestID);
			return false;
		}

		function SetDocType() {
			jsDocType = jsaTypeCodes[jiDocumentType];
			jsDocName = jsaTypeNames[jiDocumentType];
			return false;
		}

		function ShowDebugInfo() {
			var sdata = 'IA Nbr Items: ' + jiNbrProdsIA.toString() + '\n';
			sdata = sdata + 'RM Nbr Items: ' + jiNbrProdsRM.toString() + '\n';
			sdata = sdata + 'LAD Nbr Items: ' + jiNbrProdsLAD.toString() + '\n';
			//alert('1');
			sdata = sdata + 'MAC Nbr Items: ' + jiNbrProdsMAC.toString() + '\n\n';
			sdata = sdata + 'Invoice Request ID: ' + jiInvoiceReqID.toString() + '\n';
			//alert('3');
			sdata = sdata + 'Invoice ID: ' + jiInvoiceID.toString() + '\n';
			sdata = sdata + 'Doc Type int: ' + jiDocumentType.toString() + '\n';
			sdata = sdata + 'Doc Type code: ' + jsDocType + '\n';
			//alert('2');
			//alert('4');
			sdata = sdata + 'Document Status: ' + jsDocumentStatus + '\n\n';
			sdata = sdata + 'Nbr Customers: ' + MyCustomerData.length.toString() + '\n';
			sdata = sdata + 'Attachment Page: ' + jiPgNbrPj[0].toString() + '\n';
			sdata = sdata + 'Total Grid Rows: ' + jiTotalRows.toString() + '\n';
			sdata = sdata + 'Orig Invoice Amt: ' + jfInvoiceAmtOrig.toString() + '\n';
			sdata = sdata + 'New Invoice Amt: ' + jfInvoiceAmtNew.toString() + '\n\n';
			//sdata = sdata + 'Doc Type code: ' + jsDocType + '\n';
			//sdata = sdata + 'Doc Type code: ' + jsDocType + '\n';
			//sdata = sdata + 'Browser Type: ' + jsBrowserType + '\n';
			//alert('5');
			sdata = sdata + 'User: ' + jiByID.toString() + '-' + jsUserName + '\n';
			sdata = sdata + 'Is Admin: ' + jbA.toString() + '\n';
			sdata = sdata + 'Groups: ' + jsGroups + '\n';
			sdata = sdata + 'Page ID: ' + jiPageID.toString();
			alert(sdata);
		}

		function ShowOneArea(itm) {
			jiDocumentType = itm;
			switch(itm) {
				case 2:
					jdivInvAdjManifest.style.display = 'none';
					EnableItemRows('hidden');
					break;
				case 3:
					jdivInvAdjManifest.style.display = 'block';
					break;
			}
			return false;
		}

		function ShowOnePortion(typ) {
			if(typ === 2) {
				//alert('showing Part 1');
				for(var row = 1; row <= 16; row++) {
					sRow = row.toString();
					if(sRow.length < 2) { sRow = '0' + sRow; }
					document.getElementById('trInvAdjRow' + sRow).style.display = 'table-row';
				}
				//alert('showing Part 1 items');
				for(var row2 = 1; row2 <= jiNbrProdsIA; row2++) {
					sRow = row2.toString();
					if(sRow.length < 2) { sRow = '0' + sRow; }
					document.getElementById('rwProd' + sRow).style.display = 'table-row';
				}
			}
			else {
				//alert('showing Part 2');
				for(var row5 = 0; row5 <= 16; row5++) {
					sRow = row5.toString();
					if(sRow.length < 2) { sRow = '0' + sRow; }
					document.getElementById('trRtnManifestRow' + sRow).style.display = 'table-row';
				}
				//alert('showing Part 2 items');
				for(var row6 = 1; row6 <= jiNbrProdsRM; row6++) {
					sRow = row6.toString();
					if(sRow.length < 2) { sRow = '0' + sRow; }
					document.getElementById('trRtnManifestItem' + sRow).style.display = 'table-row';
				}
			}
			return false;
		}

		function ShowStatusMsg(msg) {
			jlStatusMsg.innerHTML = msg;
			return false;
		}

		// **************************** FORM: Invoice Adjustment *********************************
		//#region InvoiceAdjManf JS
		function ChangeIAPrice(line, val) {

		}

		function ChangeIAQty(line, val) {

		}

		// Load type 1/2 data for upper area ONLY
		function LoadInvAdjustmentData() {
			if(!IsContentsNullUndefEmptyGu(MyInvRequestData)) {
				document.getElementById('hfInvAdjIDE').value = '0';




				jselSalesRepE.value = MyInvoiceData[0]['SalesPersonID'].toString();
				jselCreditRepE.value = MyInvoiceData[0]['CreditRepID'].toString();
				jselSalesLeadE.value = MyInvoiceData[0]['SalesLeadCode'].toString();
				jselShipFmLocationE.value = MyInvoiceData[0]['ShipFmLocCode'].toString();   ///////////////////
				jhfCustCodeE.value = MyInvoiceData[0]['CustCode'].toString();
				jtCustNbrE.value = MyInvoiceData[0]['CustCode'].toString();
				jtCustNameE.value = MyInvoiceData[0]['CustName'].toString();
				jiOrderNbr = parseInt(MyInvoiceData[0]['SalesOrderNbr'], 10);
				jtSONbrE.value = jiOrderNbr.toString();
				jiInvoiceID = parseInt(MyInvoiceData[0]['InvoiceNbr'], 10);
				jtInvoiceNbrE.value = jiInvoiceID.toString();
				jselReasonCodeE.value = MyInvoiceData[0]['ReasonCode'].toString();
				jfInvoiceAmtOrig = parseFloat(MyInvoiceData[0]['OrigInvAmt']);
				jtOrigInvoiceAmt.value = getNbrStringFormattedTx(jfInvoiceAmtOrig, 2, ',', '.', '$', 2);
				jfInvoiceAmtNew = parseFloat(MyInvoiceData[0]['AdjInvoiceAmtt']);
				jtAdjInvoiceAmt.value = getNbrStringFormattedTx(jfInvoiceAmtNew, 2, ',', '.', '$', 2);
				jfInvoiceAdjAmount = jfInvoiceAmtNew - jfInvoiceAmtOrig;
				jtAdjustmentAmt.value = getNbrStringFormattedTx(jfInvoiceAdjAmount, 2, ',', '.', '$', 2);
				jtaReasonForAdjE.value = MyInvoiceData[0]['ReturnForAdj'].toString();
				jselSetNewStatus.value = MyInvoiceData[0]['StatusCode'].toString();
				if(MyInvoiceData[0]['sCustRequiresCopy'].toString() === 'Yes') {
					jchkCustReqCopyE.checked = true;
				}
				else {
					jchkCustReqCopyE.checked = false;
				}

				// load lines
				if(jbLoadedInvoiceItems === false) { GetInvoiceItems(jsDocType); }
				PopulateInvoiceLinesIA();
			}
			return false;
		}

		function NewInvAdjSection() {
			var sRow = '';
			document.getElementById('hfInvAdjIDE').value = '0';
			jselSalesRepE.value = '0';
			jselSalesLeadE.value = '0';
			jselCreditRepE.value = '0';
			jselShipFmLocationE.value = '0';
			jtCustNameE.value = '';
			jtCustNbrE.value = '';
			jhfCustCodeLAD.value = '';
			jtSONbrE.value = '';
			jtInvoiceNbrE.value = '';
			jselReasonCodeE.value = '0';
			jchkCustReqCopyE.checked = false;
			jtaReasonForAdjE.value = '';
			jtOrigInvoiceAmt.value = '0';
			jtAdjInvoiceAmt.value = '0';
			jtAdjustmentAmt.value = '0';
			jfInvoiceAmtNew = 0;
			jfInvoiceAmtOrig = 0;
			InitiateInvAdjLines();
			return false;
		}

		function RemoveAIitem(row) {
			var id = document.getElementById('hfIAitemID' + row.toString()).value;
			if(confirm('This will remove this item from the request. Do you wish to continue?')) {
				RemoveItemFromListAI(id);



			}
			return false;
		}

		function SaveInvoiceAdjData() {
			// update sub document types
			var aamt = jfInvoiceAdjAmount;
			var aiamt = jfInvoiceAmtNew;
			var cmt = jtaGenCommentIAE.value;
			var crc = 0;
			var crepid = parseInt(jselCreditRepE.value, 10);
			var cust = jhfCustCodeE.value;
			var ia = 1;
			var id = document.getElementById('hfInvAdjIDE').value;
			var mannt = 0; //
			var nprod = jiNbrLinesShownIA;
			var oamt = jfInvoiceAmtOrig;
			var rc = jselReasonCodeE.value;
			var rdet = document.getElementById('txaReasonForAdjE').toString();
			var spid = parseInt(jselSalesRepE.value, 10);
			var slead = jselSalesLeadE.value;
			var sfm = jselShipFmLocationE.value;
			var onbr = jiOrderNbr;
			if(jchkCustReqCopyE.checked === true) { crc = 1; }
			UpdateInvRequest(id, dtreq, byid, stat, idt, crepid, spid, slead, sfm, rc, cust, ctlnbr, cid, vend, onbr, shpnbr, onbr1, onbr2, loc2, loc3, set1, set2, set3, set4, set5, set6, amt, aiamt, aamt, frate, oamt, oval1, oval2, rdate, tdate, adate1, adate2, tdate1, tdate2, nprod, cmt, act);


			jspnAttachMessage.style.display = 'none';
			jspnRightAttachDrop.style.display = 'inline';
			// save lines
			SaveInvoiceAdjLines();
			return false;
		}

		function SaveInvoiceAdjLines() {
			var lnid = 0;
			var inbr = 0;
			var rw = '';
			var sRow = '';
			if(jiNbrLinesShownIA > 0) {
				for(var row = 1; row <= jiNbrLinesShownIA; row++) {
					rw = row.toString();
					sRow = rw;
					if(sRow.length < 2) { sRow = '0' + sRow; }
					lnid = parseInt(document.getElementById('hfIAItemID' + row.toString()).innerHTML, 10);
					inbr = parseInt(document.getElementById('hfIAItemNbrIA' + row.toString()).value, 10);
					var ptype = document.getElementById('txtProdType' + rw).value;
					var pcode = document.getElementById('txtProdCode' + rw).value;
					var desc = document.getElementById('txtProdDesc' + rw).value;
					var oqty = parseFloat(document.getElementById('txtOrigQty' + rw).value);
					var oqty2 = 0;
					var rqty = parseFloat(document.getElementById('txtRevQty' + rw).value);
					var rqty2 = 0;
					var oprice = parseFloat(document.getElementById('txtOrigPrice' + rw).value);
					var rprice = parseFloat(document.getElementById('txtRevPrice' + rw).value);
					var crdbamt = 0;
					var a1 = '';
					var a2 = '';
					var a3 = '';
					var a4 = '';
					var a5 = '';
					var a6 = '';
					var a7 = '';
					var a8 = '';
					var a9 = '';
					var a10 = '';
					var a11 = '';
					var a12 = '';
					var a13 = '';

					//                           attributes????

					UpdateInvReqLine(lnid, inbr, ptype, pcode, desc, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, oqty, oqty2, rqty, rqty2, oprice, rprice, crdbamt, 0, 0, 0, 0, 0, '', '', 0, 1);
				}
			}
			return false;
		}


		//#endregion InvoiceAdjManf JS

		// **************************** FORM: Invoice Adj/Rtn Manifest *********************************
		//#region RtnManifest JS

		function LoadReturnManifestData() {
			if(!IsContentsNullUndefEmptyGu(MyInvRequestData)) {
				document.getElementById('hfRtnManifestIDM').value =

				jtReqRtnDateM.value = MyInvRequestData[0]['sReqRtnDate'].toString();
				jtRequestedByM.value = MyInvRequestData[0]['sFullName2'].toString();
				jhfRequestedByIDM.value = MyInvRequestData[0]['RequestedByID'].toString();
				jselCreditRepM.value = MyInvRequestData[0]['CreditRepManifID'].toString();
				jselSalesLeadM.value = MyInvRequestData[0]['SalesLeadManifest'].toString();
				jselShipFMLocationM.value = MyInvRequestData[0]['ShipFmLocCodeM'].toString();
				jtCustomerNbrM.value = MyInvRequestData[0]['CustCode'].toString();
				jtCustNameM.value = MyInvRequestData[0]['CustName'].toString();
				jhfCustCodeM.value = MyInvRequestData[0]['CustCode'].toString();
				jtSONbrM.value = MyInvRequestData[0]['SalesOrderNbr'].toString();
				jtInvoiceNbrM.value = MyInvRequestData[0]['InvoiceNbr'].toString();
				jselReasonCodeM.value = MyInvRequestData[0]['ReasonCodeM'].toString();
				jtActRtnDateM.value = MyInvRequestData[0]['sActRtnDate'].toString();
				jselRtnCarrierM.value = MyInvRequestData[0]['CarrierID'].toString();
				jtRtnFreightRateM.value = MyInvRequestData[0]['FreightRateRtn'].toString();
				jtTransOrderNbrM.value = MyInvRequestData[0]['TransferOrderNbr'].toString();
				jselShipTOLocationM.value = MyInvRequestData[0]['ShippedToLocCodeM'].toString();
				jtaRtnReasonM.value = MyInvRequestData[0]['ReturnReasonDetailed'].toString();
				if(MyInvRequestData[0]['sCustRequiresCopy'].toString() === 'Yes') {
					jchkRevisedInvCopyM.checked = true;
				}
				else {
					jchkRevisedInvCopyM.checked = false;
				}
				if(MyInvRequestData[0]['sManInvAdjM'].toString() === 'Yes') {
					jchkManInvAdjMI.checked = true;
				}
				else {
					jchkManInvAdjMI.checked = false;
				}
				if(MyInvRequestData[0]['sAPNotification'].toString() === 'Yes') {
					jchkAPNotificationMI.checked = true;
				}
				else {
					jchkAPNotificationMI.checked = false;
				}
				PopulateInvoiceLinesRM();
			}
			return false;
		}

		function NewRtnManifest() {
			var sRow = '';
			document.getElementById('hfRtnManifestIDM').value = '0';
			jtReqRtnDateM.value = jsToday;;
			jtRequestedByM.value = jsUserName;
			jhfRequestedByIDM.value = jiByID.toString();
			jselCreditRepM.value = '0';
			jselSalesLeadM.value = '0';
			jselShipFMLocationM.value = '0';
			jtCustomerNbrM.value = '';
			jhfCustCodeM.value = '0';
			jtCustNameM.value = '';
			jtSONbrM.value = '';
			jtInvoiceNbrM.value = '';
			jselReasonCodeM.value = '0';
			jtActRtnDateM.value = '';
			jselRtnCarrierM.value = '0';
			jtRtnFreightRateM.value = '';
			jtTransOrderNbrM.value = '';
			jselShipTOLocationM.value = '';
			jchkManInvAdjMI.checked = false;
			jchkAPNotificationMI.checked = false;
			jchkRevisedInvCopyM.checked = false;
			jtaRtnReasonM.value = '';

			for(var i = 1; i <= jiNbrProdsRM; i++) {
				document.getElementById('txtTKProdType' + i.toString()).value = '';
				document.getElementById('txtTKProdCode' + i.toString()).value = '';
				document.getElementById('txtTKTicketNbr' + i.toString()).value = '';
				document.getElementById('txtTKStatus' + i.toString()).value = '';
				document.getElementById('txtTKQty' + i.toString()).value = '';
				document.getElementById('txtTKTotalPkgCount' + i.toString()).value = '';
				document.getElementById('txtTKQtyCheckedIn' + i.toString()).value = '';
				document.getElementById('chkTKRedTag' + i.toString()).checked = false;
				document.getElementById('chkTKInvAdj' + i.toString()).checked = false;
			}
			if(jiNbrProdsRM > 5) {
				for(var i2 = 6; i2 <= jiNbrProdsRM; i2++) {
					sRow = i2.toString();
					if(sRow.length < 2) { sRow = '0' + sRow; }
					document.getElementById('trRtnManifestItem' + sRow).style.display = 'none';
				}
			}
			return false;
		}

		function RemoveRMitem(row) {
			var id = document.getElementById('hfRMitemID' + row.toString()).value;
			if(confirm('This will remove this item from the request. Do you wish to continue?')) {
				RemoveItemFromListRM(id);



			}
			return false;
		}

		function SavertnManifestData() {



			SaveRtnManifestLines();
			return false;
		}

		function SaveRtnManifestLines() {
			if(jiNbrLinesShownRM > 0) {
				for(var row = 1; row <= jiNbrLinesShownRM; row++) {
					var ia = 0;
					var rtag = 0;
					lnid = parseInt(document.getElementById('hfRMItemID' + row.toString()).innerHTML, 10);
					inbr = parseInt(document.getElementById('hfRMItemNbrIA' + row.toString()).value, 10);
					var ptype = document.getElementById('txtTKProdType' + rw).value;
					var pcode = document.getElementById('txtTKProdCode' + rw).value;
					var desc = '';
					var oqty = parseFloat(document.getElementById('txtTKQty' + rw).value);
					var oqty2 = parseFloat(document.getElementById('txtTKTotalPkgCount' + rw).value);;
					var rqty = parseFloat(document.getElementById('txtRevQty' + rw).value);
					var rqty2 = 0;
					var oprice = parseFloat(document.getElementById('txtOrigPrice' + rw).value);
					var rprice = parseFloat(document.getElementById('txtRevPrice' + rw).value);
					var crdbamt = 0;
					var a1 = '';
					var a2 = '';
					var a3 = '';
					var a4 = '';
					var a5 = '';
					var a6 = '';
					var a7 = '';
					var a8 = '';
					var a9 = '';
					var a10 = '';
					var a11 = '';
					var a12 = '';
					var a13 = '';
					var ia = 0;
					if(document.getElementById('chkTKInvAdj' + rw).checked === true) { ia = 1; }
					var rtag = 0;
					if(document.getElementById('chkTKRedTag' + rw).checked === true) { rtag = 1; }
					var rtnqty = parseFloat(document.getElementById('txtTKQty' + rw).value);
					var rpkg = parseFloat(document.getElementById('txtTKTotalPkgCount' + rw).value);
					var qchkin = parseFloat(document.getElementById('txtTKQtyCheckedIn' + rw).value);
					var tkt = document.getElementById('txtTKTicketNbr' + rw).value
					var expl = '';
					var rtn = 0;

					UpdateInvReqLine(lnid, inbr, ptype, pcode, desc, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, oqty, oqty2, rqty, rqty2, oprice, rprice, crdbamt, ia, rtag, rtnqty, rpkg, qchkin, tkt, expl, 1, 1);
				}
			}
			return false;
		}

		//#endregion RtnManifest JS

		// **************************** FORM: Inventory Chg *********************************

		//#region InventoryChg JS
		function AddNewInvChgItem() {

		}

		function ChangeIAdjProdType(val) {
			var obj;
			jsProdType = val;
			GetProductList(jsProdType);
			if(!IsContentsNullUndefinedGu(MyProductList)) {
				ClearDDLOptionsGu('selProdCodeIAdjE', 1);
				obj = document.getElementById('selProdCodeIAdjE');
				fillDropDownListGu(MyProductList, obj, 0, 'description', 'product')
			}
			GetProdTypeCodeList(jsProdType, 0, 1);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				ClearDDLOptionsGu('selAttrib01IAdjE', 1);
				obj = document.getElementById('selAttrib01IAdjE');
				fillDropDownListGu(MiyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			GetProdTypeCodeList(jsProdType, 0, 2);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				ClearDDLOptionsGu('selAttrib02IAdjE', 1);
				obj = document.getElementById('selAttrib02IAdjE');
				fillDropDownListGu(MiyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			GetProdTypeCodeList(jsProdType, 0, 3);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				ClearDDLOptionsGu('selAttrib03IAdjE', 1);
				obj = document.getElementById('selAttrib03IAdjE');
				fillDropDownListGu(MiyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			GetProdTypeCodeList(jsProdType, 0, 4);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				ClearDDLOptionsGu('selAttrib04IAdjE', 1);
				obj = document.getElementById('selAttrib04IAdjE');
				fillDropDownListGu(MiyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			GetProdTypeCodeList(jsProdType, 0, 5);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				ClearDDLOptionsGu('selAttrib05IAdjE', 1);
				obj = document.getElementById('selAttrib05IAdjE');
				fillDropDownListGu(MiyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			GetProdTypeCodeList(jsProdType, 0, 6);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				ClearDDLOptionsGu('selAttrib06IAdjE', 1);
				obj = document.getElementById('selAttrib06IAdjE');
				fillDropDownListGu(MiyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			GetProdTypeCodeList(jsProdType, 0, 7);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				ClearDDLOptionsGu('selAttrib07IAdjE', 1);
				obj = document.getElementById('selAttrib07IAdjE');
				fillDropDownListGu(MiyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			GetProdTypeCodeList(jsProdType, 0, 8);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				ClearDDLOptionsGu('selAttrib08IAdjE', 1);
				obj = document.getElementById('selAttrib08IAdjE');
				fillDropDownListGu(MiyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			GetProdTypeCodeList(jsProdType, 0, 9);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				ClearDDLOptionsGu('selAttrib09IAdjE', 1);
				obj = document.getElementById('selAttrib09IAdjE');
				fillDropDownListGu(MiyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			GetProdTypeCodeList(jsProdType, 0, 10);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				ClearDDLOptionsGu('selAttrib10IAdjE', 1);
				obj = document.getElementById('selAttrib10IAdjE');
				fillDropDownListGu(MiyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			GetProdTypeCodeList(jsProdType, 0, 11);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				ClearDDLOptionsGu('selAttrib11IAdjE', 1);
				obj = document.getElementById('selAttrib11IAdjE');
				fillDropDownListGu(MiyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			GetProdTypeCodeList(jsProdType, 0, 12);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				ClearDDLOptionsGu('selAttrib12IAdjE', 1);
				obj = document.getElementById('selAttrib12IAdjE');
				fillDropDownListGu(MiyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			GetProdTypeCodeList(jsProdType, 0, 13);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				ClearDDLOptionsGu('selAttrib13IAdjE', 1);
				obj = document.getElementById('selAttrib13IAdjE');
				fillDropDownListGu(MiyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			return false;
		}

		function CloseInventoryAdjDataEdit() {
			jdivInventoryChangeItem.style.display = 'none';
			return false;
		}

		function GetExistingInvData(itm) {
			var loc = document.getElementById('selLocationIAdjE').value;
			var pt = document.getElementById('selProdTypeIAdjE').value;
			var pc = document.getElementById('selProdCodeIAdjE').value;
			var a1 = document.getElementById('selAttrib01IAdjE').value;
			var a2 = document.getElementById('selAttrib02IAdjE').value;
			var a3 = document.getElementById('selAttrib03IAdjE').value;
			var a4 = document.getElementById('selAttrib04IAdjE').value;
			var a5 = document.getElementById('selAttrib05IAdjE').value;
			var a6 = document.getElementById('selAttrib06IAdjE').value;
			var a7 = document.getElementById('selAttrib07IAdjE').value;
			var a8 = document.getElementById('selAttrib08IAdjE').value;
			var a9 = document.getElementById('selAttrib09IAdjE').value;
			var a10 = document.getElementById('selAttrib10IAdjE').value;
			var a11 = document.getElementById('selAttrib11IAdjE').value;
			var a12 = document.getElementById('selAttrib12IAdjE').value;
			var a13 = document.getElementById('selAttrib13IAdjE').value;
			GetInventoryItemData(pt, pc, loc, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13);
			if(!IsContentsNullUndefEmptyGu(MyInventoryItemData)) {
				document.getElementById('txtQtyAdjustment').value = MyInventoryItemData[0]['StartingQty'].toString();
				document.getElementById('hfQtyAdjOrig').value = MyInventoryItemData[0]['StartingQty'].toString();
				document.getElementById('txtPcPkgAdjustment').value = MyInventoryItemData[0]['StartingPc'].toString();
				document.getElementById('hfPkgAdjOrig').value = MyInventoryItemData[0]['StartingPc'].toString();
			}
			return false;
		}

		function LoadInventoryAdjData() {
			if(!IsContentsNullUndefEmptyGu(MyInvRequestData)) {
				document.getElementById('hfInvRequestIDIC').value = jiInvoiceReqID.toString();
				jselSetNewStatus.value = MyInvoiceData[0]['StatusCode'].toString();
				PopulateInventoryChgItems();
			}
			return false;
		}

		function NewInventoryAdj() {
			document.getElementById('hfInvRequestIDIC').value = '0';
			jselSetNewStatus.value = 'U';
			PopulateInventoryChgItems();
			jdivInventoryChangeReq.style.display = 'block';
			return false;
		}

		function SaveInvChangeLine() {
			var lnid = parseInt(document.getElementById('lblInvChgEditIDE').innerHTML, 10);
			var inbr = parseInt(document.getElementById('hfItemNbrIAdjE').value, 10);
			var ptype = document.getElementById('selProdTypeIAdjE').value;
			var ddl = document.getElementById('selProdCodeIAdjE');
			var pcode = ddl.value;
			var desc = getSelectedTextByIndexGu('selProdCodeIAdjE', ddl.selectedIndex);
			var a1 = document.getElementById('selAttrib01IAdjE').value;
			var a2 = document.getElementById('selAttrib02IAdjE').value;
			var a3 = document.getElementById('selAttrib03IAdjE').value;
			var a4 = document.getElementById('selAttrib04IAdjE').value;
			var a5 = document.getElementById('selAttrib05IAdjE').value;
			var a6 = document.getElementById('selAttrib06IAdjE').value;
			var a7 = document.getElementById('selAttrib07IAdjE').value;
			var a8 = document.getElementById('selAttrib08IAdjE').value;
			var a9 = document.getElementById('selAttrib09IAdjE').value;
			var a10 = document.getElementById('selAttrib10IAdjE').value;
			var a11 = document.getElementById('selAttrib11IAdjE').value;
			var a12 = document.getElementById('selAttrib12IAdjE').value;
			var a13 = document.getElementById('selAttrib13IAdjE').value;
			var oqty = parseFloat(document.getElementById('hfQtyAdjOrig').value);
			var oqty2 = parseFloat(document.getElementById('hfPkgAdjOrig').value);
			var rqty = parseFloat(document.getElementById('txtQtyAdjustment').value);
			var rqty2 = parseFloat(document.getElementById('txtPcPkgAdjustment').value);
			UpdateInvReqLine(lnid, inbr, ptype, pcode, desc, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, oqty, oqty2, rqty, rqty2, oprice, rprice, crdbamt, ia, rtag, rtnqty, rpkg, qchkin, tkt, expl, rtn, act);
			jdivInventoryChangeItem.style.display = 'none';
			Get
			return false;
		}
		//#endregion InventoryChg JS

		// **************************** FORM: LossDamage *********************************

		//#region LossDamage JS
		function AddLossDamageItem() {

		}

		function ChangeTotalClaimAmt() {
			var fig = 0;
			try {
				fig = parseInt(document.getElementById('txtAmountLAD01'), 10) + parseInt(document.getElementById('txtAmountLAD02'), 10) + parseInt(document.getElementById('txtAmountLAD03'), 10);
				document.getElementById('txtAmountLAndD').value = getNbrStringFormattedTx(fig, 2, ',', '.', '$', 1);
			}
			catch(ex) {
				alert('Item amount fields contain non-numeric values');
			}
			return false;
		}

		function LoadLossDamageClaimData() {
			if(!IsContentsNullUndefEmptyGu(MyInvRequestData)) {

			}
			return false;
		}

		function NewLossAndDamageClaim() {
			document.getElementById('txaGenCommentIAE').value = '';
			document.getElementById('txtLADTransDate').value = jsToday;
			createDatePickerOnTextWc('txtLADTransDate', null, null, 0, 3, 'show', 11);
			document.getElementById('txtCustomerLAndD').value = '';
			SetTextBoxAutoComplete2Wc('txtCustomerLAndD', 3, jhfCustCodeLAD, MyCustomerData, 'cust', 'CustName');
			jselNbrTypeLAndD.value = '0';
			document.getElementById('txtControlNbrLAndD').value = '';
			PopulateLossDamageLines();
			jdivLossAndDamageClaim.style.display = 'block';
			return false;
		}

		function SaveLossDamageLines() {
			if(jiNbrLinesLAD > 0) {
				for(var row = 1; row <= jiNbrLinesLAD; row++) {
					UpdateInvReqLine(lnid, inbr, ptype, pcode, desc, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, oqty, oqty2, rqty, rqty2, oprice, rprice, crdbamt, ia, rtag, rtnqty, rpkg, qchkin, tkt, expl, rtn, act);
				}
			}
			return false;
		}
		//#endregion LossDamage JS

		// **************************** FORM: MAC Adjust *********************************

		//#region MACAdjust JS
		function AddNewMACLine() {

		}

		function ChangeCorrectMAC(line, val) {


		}

		function ChangeCurrentMAC(line, val) {


		}

		function LoadMACAdjustData() {
			if(!IsContentsNullUndefEmptyGu(MyInvRequestData)) {

			}
			return false;
		}

		function NewMACAdjustment() {
			jiNbrLinesMAC = 1;
			InitiateMACAdjustLines();
			jdivMACAdjustment.style.display = 'block';
			return false;
		}

		function RemoveMACItem(row) {


			return false;
		}

		function SaveMACAdjustLines() {
			if(jiNbrLinesMAC > 0) {
				for(var row = 1; row <= jiNbrLinesMAC; row++) {


					UpdateInvReqLine(lnid, inbr, ptype, pcode, desc, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, oqty, oqty2, rqty, rqty2, oprice, rprice, crdbamt, ia, rtag, rtnqty, rpkg, qchkin, tkt, expl, rtn, act);
				}
			}
			return false;
		}
		//#endregion MACAdjust JS

		// **************************** FORM: Freight Accrual *********************************

		//#region FreightAccrual JS
		function LoadFreightAccrualData() {
			if(jiRequestID > 0 && !IsContentsNullUndefEmptyGu(MyInvRequestData)) {
				document.getElementById('txtDateReqFAE').value = jsToday;
				document.getElementById('txtReqByFAE').value = jsUserName;
				document.getElementById('selSalesRepFAE').value = MyInvRequestData[0]['SalesPersonID'].toString();
				document.getElementById('selCreditRepFAE').value = MyInvRequestData[0]['CreditRepID'].toString();
				document.getElementById('selSalesLeadFAE').value = MyInvRequestData[0]['SalesLeadCode'].toString();
				document.getElementById('selShipFmLocationFAE').value = MyInvRequestData[0]['ShipFmLocCode'].toString();
				document.getElementById('txtCustNbrFAE').value = MyInvRequestData[0]['CustCode'].toString();
				document.getElementById('txtCustNameFAE').value = MyInvRequestData[0]['CustName'].toString();
				document.getElementById('txtSONbrFAE').value = MyInvRequestData[0]['SalesOrderNbr'].toString();
				document.getElementById('txtInvoiceNbrFAE').value = MyInvRequestData[0]['InvoiceNbr'].toString();
				document.getElementById('selReasonCodeFAE').value = MyInvRequestData[0]['ReasonCode'].toString();
				document.getElementById('txaReasonForAdjFAE').value = MyInvRequestData[0]['ReasonForAdj'].toString();
				document.getElementById('txtOrigInvoiceAmtFA').value = getNbrStringFormattedTx(parseFloat(MyInvRequestData[0]['OrigInvAmt']), 2, ',', '.', '$', 2);
				document.getElementById('txtAdjInvoiceAmtFA').value = getNbrStringFormattedTx(parseFloat(MyInvRequestData[0]['AdjInvoiceAmt']), 2, ',', '.', '$', 2);
				document.getElementById('txtAdjustmentAmtFA').value = getNbrStringFormattedTx(parseFloat(MyInvRequestData[0]['AdjustmentAmt']), 2, ',', '.', '$', 2);
				document.getElementById('hfInvAdjIDFAE').value = jiInvoiceReqID.toString();
				document.getElementById('hfReqByIDFAE').value = jiByID.toString();
				SetTextBoxAutoComplete2Wc('txtCustNameFAE', 3, jhfCustCodeLAD, MyCustomerData, 'cust', 'CustName');
			}
			return false;
		}

		function NewFreightAccrual() {
			document.getElementById('txtDateReqFAE').value = jsToday;
			document.getElementById('txtReqByFAE').value = jsUserName;
			document.getElementById('selSalesRepFAE').value = '0';
			document.getElementById('selCreditRepFAE').value = '0';
			document.getElementById('selSalesLeadFAE').value = '0';
			document.getElementById('selShipFmLocationFAE').value = '0';
			document.getElementById('txtCustNbrFAE').value = '';
			document.getElementById('txtCustNameFAE').value = '';
			document.getElementById('txtSONbrFAE').value = '';
			document.getElementById('txtInvoiceNbrFAE').value = '';
			document.getElementById('selReasonCodeFAE').value = '0';
			document.getElementById('txaReasonForAdjFAE').value = '';
			document.getElementById('txtOrigInvoiceAmtFA').value = '0';
			document.getElementById('txtAdjInvoiceAmtFA').value = '0';
			document.getElementById('txtAdjustmentAmtFA').value = '0';
			document.getElementById('hfInvAdjIDFAE').value = jiInvoiceReqID.toString();
			document.getElementById('hfReqByIDFAE').value = jiByID.toString();
			SetTextBoxAutoComplete2Wc('txtCustNameFAE', 3, jhfCustCodeLAD, MyCustomerData, 'cust', 'CustName');
			jdivFreightAccrual.style.display = 'block';
			return false;
		}

		function SaveFreightAccrual() {
			// save it

			return false;
		}

		//#endregion FreightAccrual JS

		// **************************** FORM: Manual Credit *********************************

		//#region ManualCredit JS
		function LoadManualCreditData() {
			if(!IsContentsNullUndefEmptyGu(MyInvRequestData)) {

			}
			return false;
		}

		function NewManualCredit() {

			return false;
		}

		function SaveManualCredit() {

			return false;
		}

		//#endregion ManualCredit JS

		// **************************** FORM: Customer Claim *********************************

		//#region CustomerClaim JS
		function LoadCustClaimData() {
			if(!IsContentsNullUndefEmptyGu(MyInvRequestData)) {

			}
			return false;
		}

		function NewCustClaim() {


			return false;
		}

		function SaveCustClaim() {

			return false;
		}

		//#endregion CustomerClaim JS

		// **************************** FORM: Vendor Claim *********************************

		//#region VendorClaim JS
		function LoadVendorClaimData() {
			if(!IsContentsNullUndefEmptyGu(MyInvRequestData)) {

			}
			return false;
		}

		function NewVendorClaim() {
			document.getElementById('txtVendorClaimIdent').value = '';
			document.getElementById('hfVendorCodeE').value = '';
			document.getElementById('txtDateReqVCE').value = jsToday;
			document.getElementById('txtReqByVCE').value = jsUserName;
			document.getElementById('hfReqByIDVCE').value = jiByID.toString();
			document.getElementById('selSalesRepVCE').value = '0';
			document.getElementById('selCreditRepVCE').value = '0';
			document.getElementById('selSalesLeadVCE').value = '0';
			document.getElementById('selShipFmLocationVCE').value = '0';
			document.getElementById('txtCustNbrVCE').value = '';
			document.getElementById('txtCustNameVCE').value = '';
			document.getElementById('hfCustCodeVCE').value = '';
			document.getElementById('txtSONbrVCE').value = '';
			document.getElementById('txtInvoiceNbrVCE').value = '';
			document.getElementById('selReasonCodeVCE').value = '0';
			document.getElementById('txaReasonForAdjVCE').value = '';
			document.getElementById('txtOrigInvoiceAmtVC').value = '0';
			document.getElementById('txtAdjInvoiceAmtVC').value = '0';
			document.getElementById('txtAdjustmentAmtVC').value = '0';
			jdivVendorClaim.style.display = 'block';
			return false;
		}

		function SaveVendorClaim() {

			return false;
		}

		//#endregion VendorClaim JS

		// **************************** External *********************************

		// #region ExternalPaths JS
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
    // #endregion ExternalPaths JS

	</script>

	<link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />

</head>
<body>
	<img id="imgSessionKeepAlive" width="1" height="1" style="display: none;" src="../Images/clearpixel.gif" />
	<form id="form1" runat="server">
		<asp:ScriptManager runat="server"></asp:ScriptManager>
		<input type="hidden" id="hfPageID" value="57" />

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

			<div id="divPAGEHDR" style="width: 98%; margin-left: 10px; display: block;">
				<div id="divInvAdjFormHdr" style="width: 100%;">
					<div id="divMainHdrBtnBar" style="width: 100%;">

						<table id="tblInvAdjFormHdrLine" style="border-spacing: 0px; padding: 0px; width: 100%; background-color: lightgrey; border: 6px inset lightgrey; vertical-align: middle; padding-bottom: 4px;">
							<tr>
								<td style="border: none; vertical-align: middle;">&nbsp;<label id="lblInvAdjPage" class="LabelGridHdrLarger">Claims Management</label>&nbsp;
								<a href="#" onclick="javascript:ShowDebugInfo();return false">
									<img id="imgBulletPoint" src="../Images/bullet.png" /></a>&nbsp;&nbsp;
								</td>
								<td>&nbsp;</td>
								<td style="vertical-align: middle; text-align: right;">
									<button id="btnNewInvRequest" onclick="javascript:NewInvRequest();return false;" class="button blue-gradient glossy" style="margin-right: 6px;">New Request</button>
									<span id="spnDocumentTypeLabel" style="display: inline;">
										<label id="lblMainHdrSelectItem" style="color: blue; font-weight: bold; font-size: 12pt;">Document Type:</label>&nbsp;
									</span>
								</td>
								<td style="vertical-align: middle;">
									<span id="spnDocumentTypeList" style="display: inline;">
										<select id="selDocumentType" style="font-size: 12pt;" onchange="">
											<option value="0" selected="selected">None Selected</option>
											<option value="2">InvAdjustment</option>
											<option value="3">Return Manifest</option>
											<option value="4">Freight Accrual</option>
											<option value="5">Vendor Claim</option>
											<option value="8">MAC Adjustment</option>
											<option value="6">Loss & Damage Claim</option>
											<option value="9">Manual Credit</option>
											<option value="7">Inventory Adjustment</option>
											<option value="10">Customer Claim</option>
										</select>&nbsp;
									<span id="spnAddNewSection" style="display: inline;">
										<button id="btnAddNewType2" class="button blue-gradient glossy" onclick="javascript:AddDocumentType(this.value);return false;">Add New Type</button>&nbsp;&nbsp;</span>&nbsp;&nbsp;&nbsp;
									</span>
									<span id="spnSaveRequest" style="display: none;">
										<button id="btnSaveRequest" onclick="javascript:SaveRequest();return false;" class="button blue-gradient glossy">Save Form</button>&nbsp;&nbsp;</span>
									<span id="spnExportToPDFbtn" style="display: none;">
										<button id="btnSendToPDF" onclick="javascript:ExportToPDF();return false;" class="button blue-gradient glossy" style="margin-left: 10px;">Export to PDF</button>&nbsp;</span>
								</td>
								<td colspan="2">&nbsp;</td>
								<td style="text-align: right;">&nbsp;</td>
								<td style="text-align: right;">Invoice Nbr:&nbsp;</td>
								<td style="vertical-align: middle;">
									<input type="text" id="txtFindInvoiceNbr" style="width: 100px;" readonly="readonly" />&nbsp;
								<button id="btnFindInvoiceNbr" class="button blue-gradient glossy" onclick="javascript:FindInvoiceNbr();return false;">Load</button>&nbsp;&nbsp;&nbsp;
								</td>
							</tr>
							<tr>
								<td style="border: none; font-size: 12pt;">&nbsp;ID:&nbsp;<label id="lblRequestIDE" style="color: blue; font-weight: bold;">0</label>&nbsp;&nbsp;
								Status:&nbsp;<label id="lblRequestStatusH" style="color: blue; font-weight: bold;"></label>&nbsp;&nbsp;&nbsp;
								Set&nbsp;New&nbsp;Status:&nbsp;
								<select id="selSetNewStatus" onchange="javascript:ChangeInvRequestStatus(this.value);return false;" style="font-size: 12pt;">
									<option value="0" selected="selected">None Selected</option>
								</select>&nbsp;&nbsp;
								<label id="lblCriticalItem" style="color: maroon; font-weight: bold;">Critical:</label><input type="checkbox" id="chkCriticalImportance">&nbsp;&nbsp;
								</td>
								<td>&nbsp;</td>
								<td style="text-align: right; font-size: 12pt;">Request/Claim&nbsp;Submitted&nbsp;By:&nbsp;</td>
								<td style="vertical-align: middle; text-align: left; font-size: 12pt;">
									<input type="text" id="txtSubmittedByCC" style="width: 174px" readonly="readonly" />&nbsp;
									<input type="hidden" id="hfSubmittedByIDCC" value="0" />
								</td>
								<td style="vertical-align: middle; text-align: left;">&nbsp;
								</td>
								<td style="border: none; text-align: right;" colspan="3">Request&nbsp;ID:&nbsp;
								</td>
								<td style="border: none;">
									<span id="spnInitialLoadBtns">
										<input type="text" id="txtRequestIDE" style="width: 100px;" readonly="readonly" />&nbsp;
									<button id="btnFindRequest" onclick="javascript:FindRequest();return false;" class="button blue-gradient glossy">Find</button>
										<input type="hidden" id="hfRequestID" value="" />
										<input type="hidden" id="hfInvoiceID" value="" />
										<input type="hidden" id="hfInvoiceDate" value="" />
									</span>
								</td>
							</tr>
							<tr style="font-weight: bold; color: saddlebrown; font-size: 11pt;">
								<td style="text-align: left;">&nbsp;Included&nbsp;Types:&nbsp;
								<label id="lblIncludedSections" style="color: blue; font-weight: bold;">None</label>&nbsp;&nbsp;
								</td>
								<td style="vertical-align: middle; text-align: left;">&nbsp;
								</td>
								<td colspan="3" style="text-align: center;">
									Submitted&nbsp;On:&nbsp;<input type="text" id="txtSubmittedOnCC" style="width: 90px" readonly="readonly" />&nbsp;&nbsp;
									Required&nbsp;Date:&nbsp;<input type="text" id="txtRequiredDateE" style="width: 90px;" value="" />
								</td>
								<td style="text-align: right;" colspan="3">
									Emails&nbsp;to&nbsp;Include&nbsp;on&nbsp;status&nbsp;change notification:&nbsp;
								</td>
								<td style="border: none; text-align: left;">
									<input type="text" id="txtEmailsToInclude" style="width: 300px;" value="" />&nbsp;
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>

			<div id="divPAGEMAIN" style="width: 98%; margin-left: 10px;">

				<div id="divHideBottomLine" style="border: none; background-color: white; width: 150px; height: 6px; display: none;">&nbsp;</div>

				<div id="divTabBlockTabs" style="margin-bottom: 0px; padding-bottom: 0px; text-align: left; margin-top: 6px;">
					<table style="padding: 0px; border: none; border-spacing: 0px; margin-left: 4px;">
						<tr>
							<td>
								<div id="divTabHdr1" style="border: 1px solid gray; width: 150px; height: 28px; font-size: 10pt; text-align: center; border-top-left-radius: 10px; border-top-right-radius: 10px; color: blue; background-color: #D1D0CE;" onclick="javascript:SetTabVisible(1);return false;">
									<label style="font-family: 'Copperplate Gothic'; font-weight: bold;">CLAIM FORM</label>
								</div>
							</td>
							<td>
								<div id="divTabHdr2" style="border: 1px solid gray; width: 150px; height: 28px; font-size: 10pt; text-align: center; border-top-left-radius: 10px; border-top-right-radius: 10px; color: blue; background-color: #D1D0CE;" onclick="javascript:SetTabVisible(2);return false;">
									<label style="font-family: 'Copperplate Gothic'; font-weight: bold;">STATUS HISTORY</label>
								</div>
							</td>
							<td>
								<div id="divTabHdr3" style="border: 1px solid gray; width: 150px; height: 28px; font-size: 10pt; text-align: center; border-top-left-radius: 10px; border-top-right-radius: 10px; color: blue; background-color: #D1D0CE;" onclick="javascript:SetTabVisible(3);return false;">
									<label style="font-family: 'Copperplate Gothic'; font-weight: bold;">ATTACHMENTS</label>
								</div>
							</td>
						</tr>
					</table>

				</div>

				<div id="divTabBlock" style="border: 1px solid gray; background-color: white; padding: 2px; margin: 0px; border-spacing: 0px; height: 700px; width: 100%; margin: 0px;">
					<div id="divTab1" style="border: none; width: 100%; height: 100%; margin: 0px; overflow: scroll;">

						<table id="tblInvAdjMainHolder" style="width: 100%;">
							<tr>
								<td>

									<!------------------------------------------------------ InvAdj-ReturnManifest --------------------------------------------------------->
									<div id="divInvAdjManifest" style="width: 100%; margin-bottom: 10px; display: none;">
										<label id="lblInvoiceAdjReqHdr" style="color: blue; font-size: 14pt; font-weight: bold;">Invoice Adjustment Request</label><br />
										<div id="divInvoiceAdjForm" style="width: 100%;">
											<table id="tblInvAdjForm" style="border-spacing: 0px; padding: 0px;">
												<tr id="trInvAdjRow01">
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Date Requested
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Requested By
													</td>
													<td colspan="2" class="StdTableCellWBorderDarker" style="text-align: center;">Sales Rep
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;" colspan="2">Credit Rep
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Sales Lead
													</td>
													<td colspan="2" class="StdTableCellWBorderDarker" style="text-align: center;">Shipped From Location Code
													</td>
												</tr>
												<tr id="trInvAdjRow02">
													<td class="StdTableCellWBorder">
														<input type="text" id="txtDateReqE" class="InputTextWNoBorder" style="width: 80px;" />
														<input type="hidden" id="hfInvAdjIDE" value="0" />
													</td>
													<td class="StdTableCellWBorder">
														<input type="text" id="txtReqByE" class="InputTextWNoBorder" style="width: 140px;" />
														<input type="hidden" id="hfReqByIDE" value="" />
													</td>
													<td colspan="2" class="StdTableCellWBorder" style="text-align: right;">
														<select id="selSalesRepE" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
														</select>
													</td>
													<td class="StdTableCellWBorder" style="text-align: right;" colspan="2">
														<select id="selCreditRepE" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
															<option value="2546">Carolyn Gahan</option>
															<option value="2585">Nicole Hawkins</option>
															<option value="2777">Shelly Norman</option>
														</select>
													</td>
													<td class="StdTableCellWBorder" style="text-align: right;">
														<select id="selSalesLeadE" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
														</select>
													</td>
													<td colspan="2" class="StdTableCellWBorder" style="text-align: right;">
														<select id="selShipFmLocationE" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
														</select>
													</td>
												</tr>
												<tr id="trInvAdjRow03">
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Customer #
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Customer Name
													</td>
													<td colspan="2" class="StdTableCellWBorderDarker" style="text-align: center;">S/O Number
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;" colspan="2">Invoice #
													</td>
													<td colspan="3" class="StdTableCellWBorderDarker" style="text-align: center;">Reason Code
													</td>
												</tr>
												<tr id="trInvAdjRow04">
													<td class="StdTableCellWBorder">
														<input type="text" id="txtCustNbrE" class="InputTextWNoBorder" style="width: 100px;" />
														<input type="hidden" id="hfCustCodeE" value="" />
													</td>
													<td class="StdTableCellWBorder">
														<input type="text" id="txtCustNameE" class="InputTextWNoBorder" style="width: 200px;" />
													</td>
													<td colspan="2" class="StdTableCellWBorder">
														<input type="text" id="txtSONbrE" class="InputTextWNoBorder" style="width: 100px;" />
													</td>
													<td class="StdTableCellWBorder" colspan="2">
														<input type="text" id="txtInvoiceNbrE" class="InputTextWNoBorder" style="width: 100px;" />
													</td>
													<td colspan="3" class="StdTableCellWBorder" style="text-align: right;">
														<select id="selReasonCodeE" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
														</select>
													</td>
												</tr>
												<tr id="trInvAdjRow05">
													<td colspan="9" class="TableSeperatorRow" style="line-height: 10px; height: 10px;">&nbsp;
													</td>
												</tr>
												<tr id="trInvAdjRow06" style="border: 1px solid gray;">
													<td colspan="4" style="text-align: center; font-size: 11pt; color: darkblue; border: 1px solid gray; background-color: aquamarine">Required Document	
													</td>
													<td colspan="5" style="text-align: center; font-size: 11pt; color: darkblue; border: 1px solid gray; background-color: aquamarine">Reason&nbsp;for&nbsp;Credit/Invoice&nbsp;Adjustment
													</td>
												</tr>
												<tr id="trInvAdjRow07">
													<td colspan="2" class="StdTableCellWBorder" style="text-align: right;">&nbsp;
													</td>
													<td colspan="2" class="StdTableCellWBorder" style="text-align: right;">&nbsp;
													</td>
													<td colspan="5" rowspan="4" class="StdTableCellWBorder">
														<textarea id="txaReasonForAdjE" class="InputTextWNoBorder" style="width: 98%; height: 80px;"></textarea>
													</td>
												</tr>
												<tr id="trInvAdjRow08">
													<td colspan="4" class="StdTableCellWBorderDarker" style="text-align: center; font-size: 11pt; font-weight: bold;">Customer Requirement:
													</td>
												</tr>
												<tr id="trInvAdjRow09">
													<td colspan="4" class="StdTableCellWBorder" style="text-align: right;">&nbsp;<label id="lblCustReqCopyInv2" style="color: darkred; font-weight: bold;">Customer REQUIRES COPY of revised invoice:</label>&nbsp;
													<input type="checkbox" id="chkCustReqCopyE" />
													</td>
												</tr>
												<tr id="trInvAdjRow10">
													<td colspan="9" class="TableSeperatorRow" style="line-height: 10px; height: 10px;">&nbsp;
													</td>
												</tr>
												<tr id="trInvAdjRow11">
													<td colspan="3" class="StdTableCellWBorderDarker" style="text-align: center;">
														<label id="lblProdListHdrx">PRODUCTS</label>
														<button id="btnAddItemLine" class="button blue-gradient glossy" onclick="javascript:AddInvoiceAdjItemLine();return false;" style="margin-left: 30px;" />
														Add Line</button>
													&nbsp;
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center; font-weight: bold;" rowspan="2">Action</td>
													<td colspan="2" class="StdTableCellWBorderDarker" style="text-align: center; font-weight: bold;">Quantity
													</td>
													<td colspan="2" class="StdTableCellWBorderDarker" style="text-align: center; font-weight: bold;">Price
													</td>
													<td rowspan="2" class="StdTableCellWBorderDarker">TOTAL CR/DB AMOUNT
													</td>
												</tr>
												<tr id="trInvAdjRow12">
													<td class="StdTableCellWBorderDarker" style="text-align: center;">ProdType & Code
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Item Description
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Stat
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Original
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Revised
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Original
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Revised
													</td>
												</tr>
												<tr id="rwProd01">
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtProdType1" class="InputTextWNoBorder" style="width: 34px;" />-<input type="text" id="txtProdCode1" class="InputTextWNoBorder" style="width: 70px;" />
														<input type="hidden" id="hfIAitemID1" value="" />
														<input type="hidden" id="hfIAitemNbr1" value="" />
														<input type="hidden" id="hfIAItemAttribs1" value="" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: antiquewhite;">
														<input type="text" id="txtProdDesc1" class="InputTextWNoBorder" style="width: 200px; background-color: antiquewhite;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtLineStatus1" class="InputTextWNoBorder" style="width: 40px;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<button id="btnRemoveIAitem1" class="button blue-gradient glossy" onclick="javascript:RemoveAIitem(1);return false;" style="display: none;">Remove</button>
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: antiquewhite;">
														<input type="text" id="txtOrigQty1" class="InputTextWNoBorder" style="width: 70px; background-color: antiquewhite;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtRevQty1" class="InputTextWNoBorder" style="width: 70px;" onchange="javascript:ChangeIAQty(1, this.value);return false;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: antiquewhite;">
														<input type="text" id="txtOrigPrice1" class="InputTextWNoBorder" style="width: 100px; background-color: antiquewhite;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtRevPrice1" class="InputTextWNoBorder" style="width: 100px;" onchange="javascript:ChangeIAPrice(1, this.value);return false;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: #DDDDDD;">
														<input type="text" id="txtTotalAmount1" class="InputTextWNoBorder" style="width: 120px;" />
													</td>
												</tr>
												<tr id="rwProd02">
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtProdType2" class="InputTextWNoBorder" style="width: 34px;" />-<input type="text" id="txtProdCode2" class="InputTextWNoBorder" style="width: 70px;" />
														<input type="hidden" id="hfIAitemID2" value="" />
														<input type="hidden" id="hfIAitemNbr2" value="" />
														<input type="hidden" id="hfIAItemAttribs2" value="" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: antiquewhite;">
														<input type="text" id="txtProdDesc2" class="InputTextWNoBorder" style="width: 200px; background-color: antiquewhite;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtLineStatus2" class="InputTextWNoBorder" style="width: 40px;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<button id="btnRemoveIAitem2" class="button blue-gradient glossy" onclick="javascript:RemoveAIitem(2);return false;" style="display: none;">Remove</button>
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: antiquewhite;">
														<input type="text" id="txtOrigQty2" class="InputTextWNoBorder" style="width: 70px; background-color: antiquewhite;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtRevQty2" class="InputTextWNoBorder" style="width: 70px;" onchange="javascript:ChangeIAQty(2, this.value);return false;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: antiquewhite;">
														<input type="text" id="txtOrigPrice2" class="InputTextWNoBorder" style="width: 100px; background-color: antiquewhite;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtRevPrice2" class="InputTextWNoBorder" style="width: 100px;" onchange="javascript:ChangeIAPrice(2, this.value);return false;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: #DDDDDD;">
														<input type="text" id="txtTotalAmount2" class="InputTextWNoBorder" style="width: 120px" />
													</td>
												</tr>
												<tr id="rwProd03">
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtProdType3" class="InputTextWNoBorder" style="width: 34px;" />-<input type="text" id="txtProdCode3" class="InputTextWNoBorder" style="width: 70px;" />
														<input type="hidden" id="hfIAitemID3" value="" />
														<input type="hidden" id="hfIAitemNbr3" value="" />
														<input type="hidden" id="hfIAItemAttribs3" value="" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: antiquewhite;">
														<input type="text" id="txtProdDesc3" class="InputTextWNoBorder" style="width: 200px; background-color: antiquewhite;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtLineStatus3" class="InputTextWNoBorder" style="width: 40px;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<button id="btnRemoveIAitem3" class="button blue-gradient glossy" onclick="javascript:RemoveAIitem(3);return false;" style="display: none;">Remove</button>
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: antiquewhite;">
														<input type="text" id="txtOrigQty3" class="InputTextWNoBorder" style="width: 70px; background-color: antiquewhite;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtRevQty3" class="InputTextWNoBorder" style="width: 70px;" onchange="javascript:ChangeIAQty(3, this.value);return false;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: antiquewhite;">
														<input type="text" id="txtOrigPrice3" class="InputTextWNoBorder" style="width: 100px; background-color: antiquewhite;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtRevPrice3" class="InputTextWNoBorder" style="width: 100px;" onchange="javascript:ChangeIAPrice(3, this.value);return false;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: #DDDDDD;">
														<input type="text" id="txtTotalAmount3" class="InputTextWNoBorder" style="width: 120px" />
													</td>
												</tr>
												<tr id="rwProd04">
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtProdType4" class="InputTextWNoBorder" style="width: 34px;" />-<input type="text" id="txtProdCode4" class="InputTextWNoBorder" style="width: 70px;" />
														<input type="hidden" id="hfIAitemID4" value="" />
														<input type="hidden" id="hfIAitemNbr4" value="" />
														<input type="hidden" id="hfIAItemAttribs4" value="" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: antiquewhite;">
														<input type="text" id="txtProdDesc4" class="InputTextWNoBorder" style="width: 200px; background-color: antiquewhite;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtLineStatus4" class="InputTextWNoBorder" style="width: 40px;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<button id="btnRemoveIAitem4" class="button blue-gradient glossy" onclick="javascript:RemoveAIitem(4);return false;" style="display: none;">Remove</button>
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: antiquewhite;">
														<input type="text" id="txtOrigQty4" class="InputTextWNoBorder" style="width: 70px; background-color: antiquewhite;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtRevQty4" class="InputTextWNoBorder" style="width: 70px;" onchange="javascript:ChangeIAQty(4, this.value);return false;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: antiquewhite;">
														<input type="text" id="txtOrigPrice4" class="InputTextWNoBorder" style="width: 100px; background-color: antiquewhite;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtRevPrice4" class="InputTextWNoBorder" style="width: 100px;" onchange="javascript:ChangeIAPrice(4, this.value);return false;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: #DDDDDD;">
														<input type="text" id="txtTotalAmount4" class="InputTextWNoBorder" style="width: 120px" />
													</td>
												</tr>
												<tr id="rwProd05">
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtProdType5" class="InputTextWNoBorder" style="width: 34px;" />-<input type="text" id="txtProdCode5" class="InputTextWNoBorder" style="width: 70px;" />
														<input type="hidden" id="hfIAitemID5" value="" />
														<input type="hidden" id="hfIAitemNbr5" value="" />
														<input type="hidden" id="hfIAItemAttribs5" value="" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: antiquewhite;">
														<input type="text" id="txtProdDesc5" class="InputTextWNoBorder" style="width: 200px; background-color: antiquewhite;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtLineStatus5" class="InputTextWNoBorder" style="width: 40px;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<button id="btnRemoveIAitem5" class="button blue-gradient glossy" onclick="javascript:RemoveAIitem(5);return false;" style="display: none;">Remove</button>
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: antiquewhite;">
														<input type="text" id="txtOrigQty5" class="InputTextWNoBorder" style="width: 70px; background-color: antiquewhite;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtRevQty5" class="InputTextWNoBorder" style="width: 70px;" onchange="javascript:ChangeIAQty(5, this.value);return false;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: antiquewhite;">
														<input type="text" id="txtOrigPrice5" class="InputTextWNoBorder" style="width: 100px; background-color: antiquewhite;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtRevPrice5" class="InputTextWNoBorder" style="width: 100px;" onchange="javascript:ChangeIAPrice(5, this.value);return false;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: #DDDDDD;">
														<input type="text" id="txtTotalAmount5" class="InputTextWNoBorder" style="width: 120px" />
													</td>
												</tr>
												<tr id="trInvAdjRow13">
													<td class="StdTableCellWBorderDarker" colspan="6" rowspan="3">&nbsp;
													</td>
													<td class="StdTableCellWBorder" colspan="2" style="text-align: right; background-color: aquamarine;">Original Invoice Amount:&nbsp;
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtOrigInvoiceAmt" class="InputNbrWNoBorder" style="width: 120px" />
													</td>
												</tr>
												<tr id="trInvAdjRow14">
													<td class="StdTableCellWBorder" colspan="2" style="text-align: right; background-color: aquamarine;">Adjusted Invoice Amount:&nbsp;
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtAdjInvoiceAmt" class="InputNbrWNoBorder" style="width: 120px" />
													</td>
												</tr>
												<tr id="trInvAdjRow15">
													<td class="StdTableCellWBorder" colspan="2" style="text-align: right; background-color: aquamarine;">Adjustment Amount:&nbsp;
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtAdjustmentAmt" class="InputNbrWNoBorder" style="width: 120px" />
													</td>
												</tr>
												<tr id="trInvAdjComment">
													<td class="StdTableCellWBorder" style="text-align: right;">Comments:
													</td>
													<td class="StdTableCellWBorder" colspan="8">
														<textarea id="txaGenCommentIAE" style="width: 860px; height: 36px;"></textarea>
													</td>
												</tr>
												<tr id="trInvAdjRow16">
													<td colspan="9" class="TableSeperatorRow" style="line-height: 10px; height: 10px;">
														<hr style="border: 5px solid blue;" />
													</td>
												</tr>
												<tr id="trRtnManifestRow00">
													<td class="StdTableCellWBorder" colspan="2" style="font-weight: bold; font-size: 11pt;">&nbsp;RETURN MANIFEST:&nbsp;&nbsp;
													</td>
													<td class="StdTableCellWBorder" colspan="7" style="background-color: #555555;">&nbsp;
													</td>
												</tr>
												<tr id="trRtnManifestRow01">
													<td class="StdTableCellWBorderDarker" style="text-align: center; font-weight: bold;">Requested Rtn Date
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center; font-weight: bold;">Requested By
													</td>
													<td colspan="3" class="StdTableCellWBorderDarker" style="text-align: center; font-weight: bold;">Credit Rep
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center; font-weight: bold;">Sales Lead
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center; font-weight: bold;" colspan="3">Shipped FROM Location Code:
													</td>
												</tr>
												<tr id="trRtnManifestRow02">
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtReqRtnDateM" class="InputTextWNoBorder" style="width: 100px" />
														<input type="hidden" id="hfRtnManifestIDM" value="0" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtRequestedByM" class="InputTextWNoBorder" style="width: 200px" />
														<input type="hidden" id="hfRequestedByIDM" value="" />
													</td>
													<td colspan="3" class="StdTableCellWBorder" style="text-align: right;">
														<select id="selCreditRepM" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
															<option value="C">Carolyn Gahan</option>
															<option value="N">Nicole Hawkins</option>
															<option value="S">Shelly Norman</option>
														</select>
													</td>
													<td class="StdTableCellWBorder" style="text-align: right;">
														<select id="selSalesLeadM" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
														</select>
													</td>
													<td class="StdTableCellWBorder" style="text-align: right;" colspan="3">
														<select id="selShipFMLocationM" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
														</select>
													</td>
												</tr>
												<tr id="trRtnManifestRow03">
													<td class="StdTableCellWBorderDarker" style="text-align: center; font-weight: bold;">Customer #
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center; font-weight: bold;">Customer Name
													</td>
													<td colspan="3" class="StdTableCellWBorderDarker" style="text-align: center; font-weight: bold;">S/O Number
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center; font-weight: bold;">Invoice #
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center; font-weight: bold;" colspan="3">Reason Code:
													</td>
												</tr>
												<tr id="trRtnManifestRow04">
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtCustomerNbrM" class="InputTextWNoBorder" style="width: 100px" />
														<input type="hidden" id="hfCustCodeM" value="" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtCustNameM" class="InputTextWNoBorder" style="width: 280px" />
													</td>
													<td colspan="3" class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtSONbrM" style="width: 150px;" class="InputTextWNoBorder" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtInvoiceNbrM" style="width: 110px;" class="InputTextWNoBorder" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: right;" colspan="3">
														<select id="selReasonCodeM" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
														</select>
													</td>
												</tr>
												<tr id="trRtnManifestRow05">
													<td colspan="9" class="TableSeperatorRow" style="line-height: 10px; height: 10px;">&nbsp;
													</td>
												</tr>
												<tr id="trRtnManifestRow06">
													<td class="StdTableCellWBorderDarker" style="text-align: center; font-weight: bold;">Actual Rtn Date
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center; font-weight: bold;">Carrier Used for Return
													</td>
													<td colspan="3" class="StdTableCellWBorderDarker" style="text-align: center; font-weight: bold;">Freight Rate for Return
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center; font-weight: bold;">Transfer Order #
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center; font-weight: bold;" colspan="3">Shipped TO Location Code:
													</td>
												</tr>
												<tr id="trRtnManifestRow07">
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtActRtnDateM" class="InputTextWNoBorder" style="width: 100px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: right;">
														<select id="selRtnCarrierM" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
														</select>
													</td>
													<td colspan="3" class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtRtnFreightRateM" class="InputTextWNoBorder" style="width: 80px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTransOrderNbrM" class="InputTextWNoBorder" style="width: 80px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: right;" colspan="3">
														<select id="selShipTOLocationM" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
														</select>
													</td>
												</tr>
												<tr id="trRtnManifestRow08">
													<td class="StdTableCellWBorder" style="text-align: center; font-weight: bold; font-size: 11pt; background-color: aquamarine;" colspan="5">Required Customer Documents:
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; font-weight: bold; font-size: 11pt; background-color: aquamarine;" colspan="4">Reason For Return:
													</td>
												</tr>
												<tr id="trRtnManifestRow09">
													<td class="StdTableCellWBorder" style="text-align: center;" colspan="4">
														<label id="lblCustReqCopyRevisedInv" style="color: darkred; font-weight: bold;">Customer REQUIRES COPY of revised invoice:</label>&nbsp;
													<input type="checkbox" id="chkRevisedInvCopyM" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;" colspan="5" rowspan="4">
														<textarea id="txaRtnReasonM" class="InputTextWNoBorder" style="width: 99%; height: 100px;"></textarea>
													</td>
												</tr>
												<tr id="trRtnManifestRow10">
													<td class="StdTableCellWBorder" style="line-height: 10px; height: 10px; background-color: #555555;" colspan="4">&nbsp;
													</td>
												</tr>
												<tr id="trRtnManifestRow11">
													<td class="StdTableCellWBorder" style="text-align: right;" colspan="2">Manual Inventory Adjustment:
													</td>
													<td colspan="2" class="StdTableCellWBorder" style="line-height: 10px; height: 10px; text-align: left;">
														<input type="checkbox" id="chkManInvAdjMI" />
													</td>
												</tr>
												<tr id="trRtnManifestRow12">
													<td class="StdTableCellWBorder" style="text-align: right;" colspan="2">AP Notification Needed:
													</td>
													<td colspan="2" class="StdTableCellWBorder" style="line-height: 10px; height: 10px; text-align: left;">
														<input type="checkbox" id="chkAPNotificationMI" />
													</td>
												</tr>
												<tr id="trRtnManifestRow13">
													<td class="StdTableCellWBorder" style="text-align: left;" colspan="9">
														<label id="lblProdListHdr">MANIFEST PRODUCTS</label>
														<button id="btnAddNewTicket" class="button blue-gradient glossy" onclick="javascript:AddNewTicket();return false;" style="margin-left: 30px; display: none;">Add Line</button>
													</td>
												</tr>
												<tr id="trRtnManifestRow14">
													<td class="StdTableCellWBorderDarker" style="text-align: center;">ProdType & Code
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Ticket #'s
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Stat
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Action
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Quantity
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Total # Pkg/Pcs
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Qty Checked In
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Red Tag?
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Inventory Adj?
													</td>
												</tr>
												<tr id="trRtnManifestItem01">
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKProdType1" class="InputTextWNoBorder" style="width: 34px;" />-<input type="text" id="txtTKProdCode1" class="InputTextWNoBorder" style="width: 70px;" />
														<input type="hidden" id="hfRMitemID1" value="" />
														<input type="hidden" id="hfRMitemNbr1" value="" />
														<input type="hidden" id="hfRMItemAttribs1" value="" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKTicketNbr1" class="InputTextWNoBorder" style="width: 200px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKStatus1" class="InputTextWNoBorder" style="width: 40px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<button id="btnRemoveRMitem1" class="button blue-gradient glossy" onclick="javascript:RemoveRMitem(1);return false;" style="display: none;">Remove</button>
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKQty1" class="InputTextWNoBorder" style="width: 80px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKTotalPkgCount1" class="InputTextWNoBorder" style="width: 80px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKQtyCheckedIn1" class="InputTextWNoBorder" style="width: 100px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="checkbox" id="chkTKRedTag1" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: #DDDDDD;">
														<input type="checkbox" id="chkTKInvAdj1" />
													</td>
												</tr>
												<tr id="trRtnManifestItem02">
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKProdType2" class="InputTextWNoBorder" style="width: 34px;" />-<input type="text" id="txtTKProdCode2" class="InputTextWNoBorder" style="width: 70px;" />
														<input type="hidden" id="hfRMitemID2" value="" />
														<input type="hidden" id="hfRMitemNbr2" value="" />
														<input type="hidden" id="hfRMItemAttribs2" value="" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKTicketNbr2" class="InputTextWNoBorder" style="width: 200px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKStatus2" class="InputTextWNoBorder" style="width: 40px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<button id="btnRemoveRMitem2" class="button blue-gradient glossy" onclick="javascript:RemoveRMitem(2);return false;" style="display: none;">Remove</button>
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKQty2" class="InputTextWNoBorder" style="width: 80px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKTotalPkgCount2" class="InputTextWNoBorder" style="width: 80px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKQtyCheckedIn2" class="InputTextWNoBorder" style="width: 100px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="checkbox" id="chkTKRedTag2" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: #DDDDDD;">
														<input type="checkbox" id="chkTKInvAdj2" />
													</td>
												</tr>
												<tr id="trRtnManifestItem03">
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKProdType3" class="InputTextWNoBorder" style="width: 34px;" />-<input type="text" id="txtTKProdCode3" class="InputTextWNoBorder" style="width: 70px;" />
														<input type="hidden" id="hfRMitemID3" value="" />
														<input type="hidden" id="hfRMitemNbr3" value="" />
														<input type="hidden" id="hfRMItemAttribs3" value="" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKTicketNbr3" class="InputTextWNoBorder" style="width: 200px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKStatus3" class="InputTextWNoBorder" style="width: 40px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<button id="btnRemoveRMitem3" class="button blue-gradient glossy" onclick="javascript:RemoveRMitem(3);return false;" style="display: none;">Remove</button>
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKQty3" class="InputTextWNoBorder" style="width: 80px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKTotalPkgCount3" class="InputTextWNoBorder" style="width: 80px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKQtyCheckedIn3" class="InputTextWNoBorder" style="width: 100px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="checkbox" id="chkTKRedTag3" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: #DDDDDD;">
														<input type="checkbox" id="chkTKInvAdj3" />
													</td>
												</tr>
												<tr id="trRtnManifestItem04">
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKProdType4" class="InputTextWNoBorder" style="width: 34px;" />-<input type="text" id="txtTKProdCode4" class="InputTextWNoBorder" style="width: 70px;" />
														<input type="hidden" id="hfRMitemID4" value="" />
														<input type="hidden" id="hfRMitemNbr4" value="" />
														<input type="hidden" id="hfRMItemAttribs4" value="" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKTicketNbr4" class="InputTextWNoBorder" style="width: 200px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKStatus4" class="InputTextWNoBorder" style="width: 40px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<button id="btnRemoveRMitem4" class="button blue-gradient glossy" onclick="javascript:RemoveRMitem(4);return false;" style="display: none;">Remove</button>
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKQty4" class="InputTextWNoBorder" style="width: 80px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKTotalPkgCount4" class="InputTextWNoBorder" style="width: 80px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKQtyCheckedIn4" class="InputTextWNoBorder" style="width: 100px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="checkbox" id="chkTKRedTag4" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: #DDDDDD;">
														<input type="checkbox" id="chkTKInvAdj4" />
													</td>
												</tr>
												<tr id="trRtnManifestItem05">
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKProdType5" class="InputTextWNoBorder" style="width: 34px;" />-<input type="text" id="txtTKProdCode5" class="InputTextWNoBorder" style="width: 70px;" />
														<input type="hidden" id="hfRMitemID5" value="" />
														<input type="hidden" id="hfRMitemNbr5" value="" />
														<input type="hidden" id="hfRMItemAttribs5" value="" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKTicketNbr5" class="InputTextWNoBorder" style="width: 200px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKStatus5" class="InputTextWNoBorder" style="width: 40px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<button id="btnRemoveRMitem5" class="button blue-gradient glossy" onclick="javascript:RemoveRMitem(5);return false;" style="display: none;">Remove</button>
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKQty5" class="InputTextWNoBorder" style="width: 80px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKTotalPkgCount5" class="InputTextWNoBorder" style="width: 80px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtTKQtyCheckedIn5" class="InputTextWNoBorder" style="width: 100px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="checkbox" id="chkTKRedTag5" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: #DDDDDD;">
														<input type="checkbox" id="chkTKInvAdj5" />
													</td>
												</tr>
												<tr id="trRtnManifestRow15">
													<td colspan="9" class="TableSeperatorRow" style="line-height: 16px; height: 16px;">
														<hr style="border: 5px solid blue;" />
													</td>
												</tr>
												<tr id="trRtnManifestRow16">
													<td colspan="9" style="text-align: center; font-style: italic;">Product Returns must be verified and match quantity/tag numbers prior to signing.
													</td>
												</tr>
											</table>
										</div>
									</div>

									<div id="divInventoryChangeReq" style="width: 100%; display: none; margin-bottom: 10px;">
										<div id="divInventoryChgHdr" style="width: 100%;">
											<label id="lblInvChangeReqHdr" style="color: blue; font-size: 14pt; font-weight: bold;">Inventory Change Request</label><br />
											<input type="hidden" id="hfInvRequestIDIC" value="0" />
										</div>

										<div id="divInventoryChangeItem" style="width: 100%; background-color: antiquewhite; display: none;">
											<label id="lblInvChangeEditHdr" style="color: darkgoldenrod; font-size: 12pt; font-weight: bold;">New Item:</label>&nbsp;ID:&nbsp;<label id="lblInvChgEditIDE" style="font-size: 12pt; font-weight: bold; color: darkgoldenrod;">0</label><br />
											<table id="tblInvChangeEdit" style="padding: 1px; border: 1px solid gray; border-spacing: 0px; margin: auto auto;">
												<thead>
													<tr>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Location</th>
														<th class="TableHdrCell" style="width: 50px;" rowspan="2">P/T</th>
														<th class="TableHdrCell" style="width: 200px;" rowspan="2">Product</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 1</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 2</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 3</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 4</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 5</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 6</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 7</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 8</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 9</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 10</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 11</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 12</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 13</th>
														<th class="TableHdrCell" style="width: 160px;" colspan="2">Changed Amounts</th>
														<th class="TableHdrCell" style="width: 300px;" rowspan="2">Detailed Explanation</th>
													</tr>
													<tr>
														<th class="TableHdrCell" style="width: 80px;">Qty</th>
														<th class="TableHdrCell" style="width: 80px;">Pieces/Pkg</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td class="StdTableCell" style="width: 120px;">
															<select id="selLocationIAdjE" onchange="javascript:GetExistingInvData(0);return false;">
																<option value="0" selected="selected">Not Selected</option>
															</select>
															<input type="hidden" id="hfItemNbrIAdjE" value="0" />
														</td>
														<td class="StdTableCell" style="width: 50px;">
															<select id="selProdTypeIAdjE" onchange="javascript:ChangeIAdjProdType(this.value);return false;">
																<option value="0" selected="selected">Not Selected</option>
															</select>
														</td>
														<td class="StdTableCell" style="width: 200px;">
															<select id="selProdCodeIAdjE" onchange="javascript:GetExistingInvData(15);return false;">
																<option value="0" selected="selected">Not Selected</option>
															</select>
														</td>
														<td class="StdTableCell" style="width: 120px;">
															<select id="selAttrib01IAdjE" onchange="javascript:GetExistingInvData(1);return false;">
																<option value="0" selected="selected">Not Selected</option>
															</select>
														</td>
														<td class="StdTableCell" style="width: 120px;">
															<select id="selAttrib02IAdjE" onchange="javascript:GetExistingInvData(2);return false;">
																<option value="0" selected="selected">Not Selected</option>
															</select>
														</td>
														<td class="StdTableCell" style="width: 120px;">
															<select id="selAttrib03IAdjE" onchange="javascript:GetExistingInvData(3);return false;">
																<option value="0" selected="selected">Not Selected</option>
															</select>
														</td>
														<td class="StdTableCell" style="width: 120px;">
															<select id="selAttrib04IAdjE" onchange="javascript:GetExistingInvData(4);return false;">
																<option value="0" selected="selected">Not Selected</option>
															</select>
														</td>
														<td class="StdTableCell" style="width: 120px;">
															<select id="selAttrib05IAdjE" onchange="javascript:GetExistingInvData(5);return false;">
																<option value="0" selected="selected">Not Selected</option>
															</select>
														</td>
														<td class="StdTableCell" style="width: 120px;">
															<select id="selAttrib06IAdjE" onchange="javascript:GetExistingInvData(6);return false;">
																<option value="0" selected="selected">Not Selected</option>
															</select>
														</td>
														<td class="StdTableCell" style="width: 120px;">
															<select id="selAttrib07IAdjE" onchange="javascript:GetExistingInvData(7);return false;">
																<option value="0" selected="selected">Not Selected</option>
															</select>
														</td>
														<td class="StdTableCell" style="width: 120px;">
															<select id="selAttrib08IAdjE" onchange="javascript:GetExistingInvData(8);return false;">
																<option value="0" selected="selected">Not Selected</option>
															</select>
														</td>
														<td class="StdTableCell" style="width: 120px;">
															<select id="selAttrib09IAdjE" onchange="javascript:GetExistingInvData(9);return false;">
																<option value="0" selected="selected">Not Selected</option>
															</select>
														</td>
														<td class="StdTableCell" style="width: 120px;">
															<select id="selAttrib10IAdjE" onchange="javascript:GetExistingInvData(10);return false;">
																<option value="0" selected="selected">Not Selected</option>
															</select>
														</td>
														<td class="StdTableCell" style="width: 120px;">
															<select id="selAttrib11IAdjE" onchange="javascript:GetExistingInvData(11);return false;">
																<option value="0" selected="selected">Not Selected</option>
															</select>
														</td>
														<td class="StdTableCell" style="width: 120px;">
															<select id="selAttrib12IAdjE" onchange="javascript:GetExistingInvData(12);return false;">
																<option value="0" selected="selected">Not Selected</option>
															</select>
														</td>
														<td class="StdTableCell" style="width: 120px;">
															<select id="selAttrib13IAdjE" onchange="javascript:GetExistingInvData(13);return false;">
																<option value="0" selected="selected">Not Selected</option>
															</select>
														</td>
														<td class="StdTableCell" style="width: 100px;">
															<input type="text" id="txtQtyAdjustment" style="width: 60px;" />
															<input type="hidden" id="hfQtyAdjOrig" value="0" />
														</td>
														<td class="StdTableCell" style="width: 100px;">
															<input type="text" id="txtPcPkgAdjustment" style="width: 60px;" />
															<input type="hidden" id="hfPkgAdjOrig" value="0" />
														</td>
														<td class="StdTableCell" style="width: 300px;">
															<textarea id="txaDetailedExplaination" style="width: 300px; height: 48px;"></textarea>
														</td>
													</tr>
													<tr>
														<td colspan="19">NOTE: A change in the columns identifying a specific item (location/prodtype/code and attributes) will cause the existing inventory data to be loaded. Please save your data before changing product identification fields.
														</td>
													</tr>
												</tbody>
											</table>
											<div id="divInvChgEditFtr" style="width: 100%; text-align: center;">
												<button id="btnInvChgEditSave" class="button blue-gradient glossy" onclick="javascript:SaveInvChangeLine();return false;">Save</button>&nbsp;
											<button id="btnInvChgEditClose" class="button blue-gradient glossy" onclick="javascript:CloseInventoryAdjDataEdit();return false;">Close</button>&nbsp;
											</div>
										</div>

										<div id="divInventoryChgItems" style="margin-bottom: 4px;">
											<table id="tblInventoryChgItemHdr" style="width: 100%;">
												<tr>
													<td style="width: 200px;">
														<label id="lblInvChangeLinesHdr" style="color: darkgoldenrod; font-size: 12pt; font-weight: bold;">Entered Item(s):</label>
													</td>
													<td>
														<button id="btnAddNewInvChgLine" class="button blue-gradient glossy" onclick="javascript:AddNewInvChgItem();return false;">Add New Line</button>
													</td>
													<td>&nbsp;
													</td>
												</tr>
											</table>
										</div>

										<div id="divInvChangeTable" style="text-align: center; width: 100%;">
											<table id="tblInvChangeItems" style="padding: 1px; border: 1px solid gray; border-spacing: 0px; margin: auto auto;">
												<thead>
													<tr>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Location</th>
														<th class="TableHdrCell" style="width: 50px;" rowspan="2">P/T</th>
														<th class="TableHdrCell" style="width: 200px;" rowspan="2">Product</th>
														<th class="TableHdrCell" style="width: 160px;" colspan="2">Changed Amounts</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 1</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 2</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 3</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 4</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 5</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 6</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 7</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 8</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 9</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 10</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 11</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 12</th>
														<th class="TableHdrCell" style="width: 120px;" rowspan="2">Attribute 13</th>
														<th class="TableHdrCell" style="width: 300px;" rowspan="2">Detailed Explanation</th>
														<th class="TableHdrCell" style="width: 160px;" rowspan="2">Action</th>
													</tr>
													<tr>
														<th class="TableHdrCell" style="width: 80px;">Qty</th>
														<th class="TableHdrCell" style="width: 80px;">Pieces/Pkg</th>
													</tr>
												</thead>
												<tbody>
												</tbody>
											</table>
										</div>
									</div>

									<div id="divLossAndDamageClaim" style="width: 100%; text-align: center; margin-bottom: 10px; display: none;">
										<label id="lblLossAndDamageHdr" style="color: blue; font-size: 14pt; font-weight: bold;">Loss and Damage Claim</label><br />

										<table style="padding: 4px; border-spacing: 0px; border: 1px solid gray; margin: auto auto;">
											<tr>
												<td>
													<table id="tblLossAndDamage" style="padding: 1px; border: none; border-spacing: 0px;">
														<tr>
															<td style="text-align: right; vertical-align: top;">Date:&nbsp;
															</td>
															<td style="text-align: left;">
																<input type="text" id="txtLADTransDate" style="width: 82px;" />
															</td>
															<td>&nbsp;</td>
															<td style="text-align: right; vertical-align: top;">Customer:&nbsp;
															</td>
															<td style="text-align: left;">
																<input type="text" id="txtCustomerLAndD" style="width: 220px;" />
																<input type="hidden" id="hfCustCodeLAD" value="0" />
															</td>
														</tr>
														<tr>
															<td style="text-align: right; vertical-align: top;">Number Type:&nbsp;
															</td>
															<td style="text-align: left;">
																<select id="selNbrTypeLAndD">
																	<option value="ordnum" selected="selected">Order Nbr</option>
																	<option value="shpnum">Shipment Nbr</option>
																	<option value="claimnum">Claim Nbr</option>
																</select>
															</td>
															<td>&nbsp;</td>
															<td style="text-align: right; vertical-align: top;">Nbr:&nbsp;
															</td>
															<td style="text-align: left;">
																<input type="text" id="txtControlNbrLAndD" style="width: 76px;" />
															</td>
														</tr>
														<tr>
															<td colspan="5" style="text-align: center; font-style: italic; font-weight: bold;">Product(s):&nbsp;
																<button id="btnAddLossDamageItem" class="button blue-gradient glossy" onclick="javascript:AddLossDamageItem();return false;" style="right: 30px;">Add Line</button>
															</td>
														</tr>
														<tr>
															<td colspan="5" style="text-align: center;">

																<table id="tblLADProducts" style="padding: 1px; border: 1px solid gray; margin: auto auto; vertical-align: top; border-collapse: collapse; margin-bottom: 6px;">
																	<thead>
																		<tr>
																			<th class="TableHdrCell" style="width: 50px;">P/T</th>
																			<th class="TableHdrCell" style="width: 80px;">Product</th>
																			<th class="TableHdrCell" style="width: 90px;">Amount</th>
																			<th class="TableHdrCell" style="width: 320px;">Comments</th>
																			<th class="TableHdrCell" style="width: 90px;">Action</th>
																		</tr>
																	</thead>
																	<tbody>
																		<tr id="trLossDamage01">
																			<td class="StdTableCell" style="vertical-align: top;">
																				<select id="selProdTypeLAD01" style="border: none;">
																					<option value="0" selected="selected">None Selected</option>
																				</select>
																				<input type="hidden" id="hfLineIDLAD1" value="0" />
																				<input type="hidden" id="hfItemNbrLAD1" value="0" />
																				<input type="hidden" id="hfLADItemAttribs1" value="" />
																			</td>
																			<td class="StdTableCell" style="vertical-align: top;">
																				<!--select id="selProdCodeLAD01" style="border:none;"><option value="0" selected="selected">None Selected</option></select -->
																				<input type="text" id="txtProdCodeLAD01" style="width: 80px;" />
																			</td>
																			<td class="StdTableCell" style="vertical-align: top;">
																				<input type="text" id="txtAmountLAD01" style="width: 90px; border: none; text-align: right;" onchange="javascript:ChangeTotalClaimAmt();return false;" />
																			</td>
																			<td class="StdTableCell" style="vertical-align: top;">
																				<input type="text" id="txtLineCommmentsLAD01" style="width: 320px; border: none;" />
																			</td>
																			<td class="StdTableCell" style="vertical-align: top; width: 90px;">
																				<button id="btnRemoveLADItem1" class="button blue-gradient glossy" onclick="javascript:RemoveLADItem(1);return false;">Remove</button>
																			</td>
																		</tr>
																		<tr id="trLossDamage02">
																			<td class="StdTableCell" style="vertical-align: top;">
																				<select id="selProdTypeLAD02" style="border: none;">
																					<option value="0" selected="selected">None Selected</option>
																				</select>
																				<input type="hidden" id="hfLineIDLAD2" value="0" />
																				<input type="hidden" id="hfItemNbrLAD2" value="0" />
																				<input type="hidden" id="hfLADItemAttribs2" value="" />
																			</td>
																			<td class="StdTableCell" style="vertical-align: top;">
																				<!--select id="selProdCodeLAD02" style="border:none;"><option value="0" selected="selected">None Selected</option></select-->
																				<input type="text" id="txtProdCodeLAD02" style="width: 80px;" />
																			</td>
																			<td class="StdTableCell" style="vertical-align: top;">
																				<input type="text" id="txtAmountLAD02" style="width: 90px; border: none; text-align: right;" onchange="javascript:ChangeTotalClaimAmt();return false;" />
																			</td>
																			<td class="StdTableCell" style="vertical-align: top;">
																				<input type="text" id="txtLineCommmentsLAD02" style="width: 320px; border: none;" />
																			</td>
																			<td class="StdTableCell" style="vertical-align: top; width: 90px;">
																				<button id="btnRemoveLADItem2" class="button blue-gradient glossy" onclick="javascript:RemoveLADItem(2);return false;">Remove</button>
																			</td>
																		</tr>
																		<tr id="trLossDamage03">
																			<td class="StdTableCell" style="vertical-align: top;">
																				<select id="selProdTypeLAD03" style="border: none;">
																					<option value="0" selected="selected">None Selected</option>
																				</select>
																				<input type="hidden" id="hfLineIDLAD3" value="0" />
																				<input type="hidden" id="hfItemNbrLAD3" value="0" />
																				<input type="hidden" id="hfLADItemAttribs3" value="" />
																			</td>
																			<td class="StdTableCell" style="vertical-align: top;">
																				<!--select id="selProdCodeLAD03" style="border:none;"><option value="0" selected="selected">None Selected</option></select-->
																				<input type="text" id="txtProdCodeLAD03" style="width: 80px;" />
																			</td>
																			<td class="StdTableCell" style="vertical-align: top;">
																				<input type="text" id="txtAmountLAD03" style="width: 90px; border: none; text-align: right;" onchange="javascript:ChangeTotalClaimAmt();return false;" />
																			</td>
																			<td class="StdTableCell" style="vertical-align: top;">
																				<input type="text" id="txtLineCommmentsLAD03" style="width: 320px; border: none;" />
																			</td>
																			<td class="StdTableCell" style="vertical-align: top; width: 90px;">
																				<button id="btnRemoveLADItem3" class="button blue-gradient glossy" onclick="javascript:RemoveLADItem(3);return false;">Remove</button>
																			</td>
																		</tr>
																	</tbody>
																</table>

															</td>
														</tr>
														<tr>
															<td style="text-align: right; vertical-align: top;">Explanation:&nbsp;
															</td>
															<td colspan="4" style="text-align: left;">
																<textarea id="txaLossAndDmgExplanation" style="width: 700px; height: 70px;"></textarea>
															</td>
														</tr>
														<tr>
															<td style="text-align: right;">Total Claim Amount:&nbsp;
															</td>
															<td style="text-align: left;">
																<input type="text" id="txtAmountLAndD" style="width: 140px; text-align: right;" readonly="readonly" />
															</td>
															<td>&nbsp;</td>
															<td>&nbsp;</td>
															<td>&nbsp;</td>
														</tr>
														<tr>
															<td style="text-align: right;">Attach:&nbsp;
															</td>
															<td colspan="4" style="text-align: left;">
																<span style="color: darkgreen;">Delivery&nbsp;Receipts&nbsp;and&nbsp;Origional&nbsp;BOL:</span>&nbsp;<input type="checkbox" id="chkLADAttachReceiptsBOL" />&nbsp;-&nbsp;
											<span style="color: darkgreen;">Customer&nbsp;Invoice:</span>&nbsp;<input type="checkbox" id="chkLADAttachCustInvoice" />
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>

									</div>

									<div id="divFreightAccrual" style="width: 100%; display: none; margin-bottom: 10px;">
										<label id="lblFreightAccrualReqHdr" style="color: blue; font-size: 14pt; font-weight: bold;">Freight Accrual</label><br />

										<div id="divFreightAccrualData" style="width: 100%;">
											<table id="tblFreightAccrualData" style="padding: 1px; border-spacing: 0px;">
												<tr id="trFreightAccRow01">
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Date Requested
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Requested By
													</td>
													<td colspan="2" class="StdTableCellWBorderDarker" style="text-align: center;">Sales Rep
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;" colspan="2">Credit Rep
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Sales Lead
													</td>
													<td colspan="2" class="StdTableCellWBorderDarker" style="text-align: center;">Shipped From Location Code
													</td>
												</tr>
												<tr id="trFreightAccRow02">
													<td class="StdTableCellWBorder">
														<input type="text" id="txtDateReqFAE" class="InputTextWNoBorder" style="width: 80px;" />
														<input type="hidden" id="hfInvAdjIDFAE" value="0" />
													</td>
													<td class="StdTableCellWBorder">
														<input type="text" id="txtReqByFAE" class="InputTextWNoBorder" style="width: 140px;" />
														<input type="hidden" id="hfReqByIDFAE" value="" />
													</td>
													<td colspan="2" class="StdTableCellWBorder" style="text-align: right;">
														<select id="selSalesRepFAE" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
														</select>
													</td>
													<td class="StdTableCellWBorder" style="text-align: right;" colspan="2">
														<select id="selCreditRepFAE" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
															<option value="C">Carolyn Gahan</option>
															<option value="N">Nicole Hawkins</option>
															<option value="S">Shelly Norman</option>
														</select>
													</td>
													<td class="StdTableCellWBorder" style="text-align: right;">
														<select id="selSalesLeadFAE" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
														</select>
													</td>
													<td colspan="2" class="StdTableCellWBorder" style="text-align: right;">
														<select id="selShipFmLocationFAE" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
														</select>
													</td>
												</tr>
												<tr id="trFreightAccRow03">
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Customer #
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Customer Name
													</td>
													<td colspan="2" class="StdTableCellWBorderDarker" style="text-align: center;">S/O Number
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;" colspan="2">Invoice #
													</td>
													<td colspan="3" class="StdTableCellWBorderDarker" style="text-align: center;">Reason Code
													</td>
												</tr>
												<tr id="trFreightAccRow04">
													<td class="StdTableCellWBorder">
														<input type="text" id="txtCustNbrFAE" class="InputTextWNoBorder" style="width: 100px;" />
														<input type="hidden" id="hfCustCodeFAE" value="" />
													</td>
													<td class="StdTableCellWBorder">
														<input type="text" id="txtCustNameFAE" class="InputTextWNoBorder" style="width: 200px;" />
													</td>
													<td colspan="2" class="StdTableCellWBorder">
														<input type="text" id="txtSONbrFAE" class="InputTextWNoBorder" style="width: 100px;" />
													</td>
													<td class="StdTableCellWBorder" colspan="2">
														<input type="text" id="txtInvoiceNbrFAE" class="InputTextWNoBorder" style="width: 100px;" />
													</td>
													<td colspan="3" class="StdTableCellWBorder" style="text-align: right;">
														<select id="selReasonCodeFAE" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
														</select>
													</td>
												</tr>
												<tr id="trFreightAccRow05">
													<td colspan="9" class="TableSeperatorRow" style="line-height: 10px; height: 10px;">&nbsp;
													</td>
												</tr>
												<tr id="trFreightAccRow06" style="border: 1px solid gray;">
													<td colspan="4" style="text-align: center; font-size: 11pt; color: darkblue; border: 1px solid gray; background-color: aquamarine">Reason&nbsp;for&nbsp;Credit/Invoice&nbsp;Adjustment
													</td>
													<td colspan="5" style="text-align: center; font-size: 11pt; color: darkblue; border: 1px solid gray; background-color: aquamarine">Amounts
													</td>
												</tr>
												<tr id="trFreightAccRow07">
													<td colspan="6" rowspan="4" class="StdTableCellWBorder">
														<textarea id="txaReasonForAdjFAE" class="InputTextWNoBorder" style="width: 98%; height: 80px;"></textarea>
													</td>
												</tr>
												<tr id="trFreightAccRow08">
													<td class="StdTableCellWBorder" colspan="2" style="text-align: right; background-color: aquamarine;">Original Invoice Amount:&nbsp;
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtOrigInvoiceAmtFA" class="InputNbrWNoBorder" style="width: 120px" />
													</td>
												</tr>
												<tr id="trFreightAccRow09">
													<td class="StdTableCellWBorder" colspan="2" style="text-align: right; background-color: aquamarine;">Adjusted Freight Amount:&nbsp;
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtAdjInvoiceAmtFA" class="InputNbrWNoBorder" style="width: 120px" />
													</td>
												</tr>
												<tr id="trFreightAccRow10">
													<td class="StdTableCellWBorder" colspan="2" style="text-align: right; background-color: aquamarine;">Adjusted Total Amount:&nbsp;
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtAdjustmentAmtFA" class="InputNbrWNoBorder" style="width: 120px" />
													</td>
												</tr>
											</table>
										</div>
									</div>

									<div id="divVendorClaim" style="width: 100%; display: none; margin-bottom: 10px;">
										<div id="divVendorClaimHdr" style="width: 100%;">
											<table id="tblVendorClaimHdr" style="padding: 0px; border-spacing: 0px; width: 100%;">
												<tr>
													<td style="width: 200px;">
														<label id="lblVendorClaimReqHdr" style="color: blue; font-size: 14pt; font-weight: bold;">Vendor Claim</label>
													</td>
													<td>
														<label id="lblVendorIdent" style="font-weight: bold; color: darkblue;">Vendor:</label>&nbsp;<input type="text" id="txtVendorClaimIdent" style="width: 200px;" />
														<input type="hidden" id="hfVendorCodeE" value="" />
													</td>
													<td>&nbsp;
													</td>
												</tr>
											</table>
										</div>

										<div id="divVendorClaimData" style="width: 100%;">
											<table id="tblVendorClaimData" style="padding: 1px; border-spacing: 0px;">
												<tr id="trVendClaimRow01">
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Date Requested
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Requested By
													</td>
													<td colspan="2" class="StdTableCellWBorderDarker" style="text-align: center;">Sales Rep
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;" colspan="2">Credit Rep
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Sales Lead
													</td>
													<td colspan="2" class="StdTableCellWBorderDarker" style="text-align: center;">Shipped From Location Code
													</td>
												</tr>
												<tr id="trVendClaimRow02">
													<td class="StdTableCellWBorder">
														<input type="text" id="txtDateReqVCE" class="InputTextWNoBorder" style="width: 80px;" />
														<input type="hidden" id="hfInvAdjIDVCE" value="0" />
													</td>
													<td class="StdTableCellWBorder">
														<input type="text" id="txtReqByVCE" class="InputTextWNoBorder" style="width: 140px;" />
														<input type="hidden" id="hfReqByIDVCE" value="" />
													</td>
													<td colspan="2" class="StdTableCellWBorder" style="text-align: right;">
														<select id="selSalesRepVCE" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
														</select>
													</td>
													<td class="StdTableCellWBorder" style="text-align: right;" colspan="2">
														<select id="selCreditRepVCE" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
															<option value="C">Carolyn Gahan</option>
															<option value="N">Nicole Hawkins</option>
															<option value="S">Shelly Norman</option>
														</select>
													</td>
													<td class="StdTableCellWBorder" style="text-align: right;">
														<select id="selSalesLeadVCE" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
														</select>
													</td>
													<td colspan="2" class="StdTableCellWBorder" style="text-align: right;">
														<select id="selShipFmLocationVCE" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
														</select>
													</td>
												</tr>
												<tr id="trVendClaimRow03">
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Customer #
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Customer Name
													</td>
													<td colspan="2" class="StdTableCellWBorderDarker" style="text-align: center;">S/O Number
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;" colspan="2">Invoice #
													</td>
													<td colspan="3" class="StdTableCellWBorderDarker" style="text-align: center;">Reason Code
													</td>
												</tr>
												<tr id="trVendClaimRow04">
													<td class="StdTableCellWBorder">
														<input type="text" id="txtCustNbrVCE" class="InputTextWNoBorder" style="width: 100px;" />
														<input type="hidden" id="hfCustCodeVCE" value="" />
													</td>
													<td class="StdTableCellWBorder">
														<input type="text" id="txtCustNameVCE" class="InputTextWNoBorder" style="width: 200px;" />
													</td>
													<td colspan="2" class="StdTableCellWBorder">
														<input type="text" id="txtSONbrVCE" class="InputTextWNoBorder" style="width: 100px;" />
													</td>
													<td class="StdTableCellWBorder" colspan="2">
														<input type="text" id="txtInvoiceNbrVCE" class="InputTextWNoBorder" style="width: 100px;" />
													</td>
													<td colspan="3" class="StdTableCellWBorder" style="text-align: right;">
														<select id="selReasonCodeVCE" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
														</select>
													</td>
												</tr>
												<tr id="trVendClaimRow05">
													<td colspan="9" class="TableSeperatorRow" style="line-height: 10px; height: 10px;">&nbsp;
													</td>
												</tr>
												<tr id="trVendClaimRow06" style="border: 1px solid gray;">
													<td colspan="4" style="text-align: center; font-size: 11pt; color: darkblue; border: 1px solid gray; background-color: aquamarine">Reason&nbsp;for&nbsp;Credit/Invoice&nbsp;Adjustment
													</td>
													<td colspan="5" style="text-align: center; font-size: 11pt; color: darkblue; border: 1px solid gray; background-color: aquamarine">Amounts
													</td>
												</tr>
												<tr id="trVendClaimRow07">
													<td colspan="6" rowspan="3" class="StdTableCellWBorder">
														<textarea id="txaReasonForAdjVCE" class="InputTextWNoBorder" style="width: 98%; height: 80px;"></textarea>
													</td>
													<td class="StdTableCellWBorder" colspan="2" style="text-align: right; background-color: aquamarine;">Original Invoice Amount:&nbsp;
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtOrigInvoiceAmtVC" class="InputNbrWNoBorder" style="width: 120px" />
													</td>
												</tr>
												<tr id="trVendClaimRow08">
													<td class="StdTableCellWBorder" colspan="2" style="text-align: right; background-color: aquamarine;">Adjustment:&nbsp;
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtAdjInvoiceAmtVC" class="InputNbrWNoBorder" style="width: 120px" />
													</td>
												</tr>
												<tr id="trVendClaimRow09">
													<td class="StdTableCellWBorder" colspan="2" style="text-align: right; background-color: aquamarine;">Adjusted Amount:&nbsp;
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtAdjustmentAmtVC" class="InputNbrWNoBorder" style="width: 120px" />
													</td>
												</tr>
											</table>
										</div>
									</div>

									<div id="divMACAdjustment" style="width: 100%; display: none; margin-bottom: 10px;">
										<label id="lblMACAdjustmentHdr" style="color: blue; font-size: 14pt; font-weight: bold;">MAC Adjustment</label><br />

										<div id="divMACAdjustmentMain" style="width: 100%; text-align: center;">
											<table id="tblMACAdjustment" style="padding: 1px; border-spacing: 0px; border-collapse: collapse; margin: auto auto;">
												<thead>
													<tr>
														<td style="border: none; text-align: left;" colspan="3">
															<label id="lblMacAdjMainHdr" style="font-weight: bold; color: darkgreen;">Enter the following information:</label>&nbsp;&nbsp;
														</td>
														<td style="border: none; text-align: right;" colspan="4">
															<button id="btnAddNewMACline" class="button blue-gradient glossy" onclick="javascript:AddNewMACLine();return false;" style="margin-left: 50px;">Add New Line</button>
														</td>
													</tr>
													<tr>
														<th class="TableHdrCell" style="width: 60px;" rowspan="2">P/T</th>
														<th class="TableHdrCell" style="width: 60px;" rowspan="2">Product</th>
														<th class="TableHdrCell" style="width: 60px;" rowspan="2">Location</th>
														<th class="TableHdrCell" style="width: 60px;" rowspan="2">Cost ID</th>
														<th class="TableHdrCell" style="width: 60px;" colspan="2">MAC</th>
														<th class="TableHdrCell" style="width: 60px;" rowspan="2">Cost ID</th>
														<th class="TableHdrCell" style="width: 60px;" rowspan="2">Action</th>
													</tr>
													<tr>
														<th class="TableHdrCell" style="width: 60px;" rowspan="2">Current</th>
														<th class="TableHdrCell" style="width: 60px;" rowspan="2">Correct</th>
													</tr>
												</thead>
												<tbody>
													<tr id="trMACAdjustItem1">
														<td class="StdTableCell" style="width: 60px;">
															<select id="selProdTypeMACA1" class="ControlNoBorderWB">
																<option value="0" selected="selected">Not Selected</option>
															</select>
															<input type="hidden" id="hfLineIDMACAE1" value="0" />
															<input type="hidden" id="hfItemNbrMACAE1" value="0" />
															<input type="hidden" id="hfMACItemAttribs1" value="" />
														</td>
														<td class="StdTableCell" style="width: 60px;">
															<input type="text" id="txtProdCodeMACA1" style="width: 80px;" class="ControlNoBorderWB" />
														</td>
														<td class="StdTableCell" style="width: 60px;">
															<select id="selLocationMACA1" class="ControlNoBorderWB">
																<option value="0" selected="selected">Not Selected</option>
															</select>
														</td>
														<td class="StdTableCell" style="width: 60px;">
															<input type="text" id="txtCostIDMACA1" class="ControlNoBorderWB" style="width: 100px;" />
														</td>
														<th class="StdTableCell" style="width: 60px;">
															<input type="text" id="txtCurrentMACA1" class="ControlNoBorderWB" style="width: 100px;" onchange="javascript:ChangeCurrentMAC(1, this.value);return false;" />
														</th>
														<th class="StdTableCell" style="width: 60px;">
															<input type="text" id="txtCorrectMACA1" class="ControlNoBorderWB" style="width: 100px;" onchange="javascript:ChangeCorrectMAC(1, this.value);return false;" />
														</th>
														<td class="StdTableCell" style="width: 60px;">
															<input type="text" id="txtMACCostID1" class="ControlNoBorderWB" style="width: 90px;" />
														</td>
														<td class="StdTableCell" style="width: 60px;">
															<button id="btnRemoveMACItem1" class="button blue-gradient glossy" style="display:none;">Remove</button>
														</td>
													</tr>
													<tr>
													</tr>
												</tbody>
											</table>
											Work Orders<br />
											<br />
											Receiving<br />
											<br />
											Shipping<br />
											<br />
										</div>




									</div>

									<div id="divManualCredit" style="width: 100%; display: none; margin-bottom: 10px;">
										<label id="lblManualCreditHdr" style="color: blue; font-size: 14pt; font-weight: bold;">Manual Credit</label><br />

										<div id="divManualCreditForm" style="width: 100%;">
											<table id="tblManualCreditLines" style="border-spacing: 0px; padding: 0px;">
												<tr id="trManCredRow01">
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Date Requested
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Requested By
													</td>
													<td colspan="2" class="StdTableCellWBorderDarker" style="text-align: center;">Sales Rep
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;" colspan="2">Credit Rep
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Sales Lead
													</td>
													<td colspan="2" class="StdTableCellWBorderDarker" style="text-align: center;">Shipped From Location Code
													</td>
												</tr>
												<tr id="trManCredRow02">
													<td class="StdTableCellWBorder">
														<input type="text" id="txtDateReqMCE" class="InputTextWNoBorder" style="width: 80px;" />
														<input type="hidden" id="hfInvAdjIDMCE" value="0" />
													</td>
													<td class="StdTableCellWBorder">
														<input type="text" id="txtReqByMCE" class="InputTextWNoBorder" style="width: 140px;" />
														<input type="hidden" id="hfReqByIDMCE" value="" />
													</td>
													<td colspan="2" class="StdTableCellWBorder" style="text-align: right;">
														<select id="selSalesRepMCE" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
														</select>
													</td>
													<td class="StdTableCellWBorder" style="text-align: right;" colspan="2">
														<select id="selCreditRepMCE" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
															<option value="C">Carolyn Gahan</option>
															<option value="N">Nicole Hawkins</option>
															<option value="S">Shelly Norman</option>
														</select>
													</td>
													<td class="StdTableCellWBorder" style="text-align: right;">
														<select id="selSalesLeadMCE" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
														</select>
													</td>
													<td colspan="2" class="StdTableCellWBorder" style="text-align: right;">
														<select id="selShipFmLocationMCE" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
														</select>
													</td>
												</tr>
												<tr id="trManCredRow03">
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Customer #
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;">Customer Name
													</td>
													<td colspan="2" class="StdTableCellWBorderDarker" style="text-align: center;">S/O Number
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;" colspan="2">Invoice #
													</td>
													<td colspan="3" class="StdTableCellWBorderDarker" style="text-align: center;">Reason Code
													</td>
												</tr>
												<tr id="trManCredRow04">
													<td class="StdTableCellWBorder">
														<input type="text" id="txtCustNbrMCE" class="InputTextWNoBorder" style="width: 100px;" />
														<input type="hidden" id="hfCustCodeMCE" value="" />
													</td>
													<td class="StdTableCellWBorder">
														<input type="text" id="txtCustNameMCE" class="InputTextWNoBorder" style="width: 200px;" />
													</td>
													<td colspan="2" class="StdTableCellWBorder">
														<input type="text" id="txtSONbrMCE" class="InputTextWNoBorder" style="width: 100px;" />
													</td>
													<td class="StdTableCellWBorder" colspan="2">
														<input type="text" id="txtInvoiceNbrMCE" class="InputTextWNoBorder" style="width: 100px;" />
													</td>
													<td colspan="3" class="StdTableCellWBorder" style="text-align: right;">
														<select id="selReasonCodeMCE" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
														</select>
													</td>
												</tr>
												<tr id="trManCredRow05">
													<td colspan="9" class="TableSeperatorRow" style="line-height: 10px; height: 10px;">&nbsp;
													</td>
												</tr>
												<tr id="trManCredRow06" style="border: 1px solid gray;">
													<td colspan="4" style="text-align: center; font-size: 11pt; color: darkblue; border: 1px solid gray; background-color: aquamarine">Customer Requirement	
													</td>
													<td colspan="5" style="text-align: center; font-size: 11pt; color: darkblue; border: 1px solid gray; background-color: aquamarine">Reason&nbsp;for&nbsp;Credit/Invoice&nbsp;Adjustment
													</td>
												</tr>
												<tr id="trManCredRow07">
													<td colspan="4" class="StdTableCellWBorder" style="text-align: right;">&nbsp;<label id="lblCustReqCopyManCred2" style="color: darkred; font-weight: bold;">Customer REQUIRES COPY of revised invoice:</label>&nbsp;
												<input type="checkbox" id="chkMCCustReqCopyE" />
													</td>
													<td colspan="5" rowspan="3" class="StdTableCellWBorder">
														<textarea id="txaReasonForAdjMCE" class="InputTextWNoBorder" style="width: 98%; height: 80px;"></textarea>
													</td>
												</tr>
												<tr id="trManCredRow08">
													<td colspan="2" class="StdTableCellWBorder" style="text-align: right;">&nbsp;
													</td>
													<td colspan="2" class="StdTableCellWBorder" style="text-align: right;">&nbsp;
													</td>
												</tr>
												<tr id="trManCredRow09">
													<td colspan="2" class="StdTableCellWBorder" style="text-align: right;">&nbsp;
													</td>
													<td colspan="2" class="StdTableCellWBorder" style="text-align: right;">&nbsp;
													</td>
												</tr>
												<tr id="trManCredRow10">
													<td class="StdTableCellWBorderDarker" colspan="6" rowspan="3">&nbsp;
													</td>
													<td class="StdTableCellWBorder" colspan="2" style="text-align: right; background-color: aquamarine;">Original Invoice Amount:&nbsp;
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtManCredOrigInvAmt" class="InputNbrWNoBorder" style="width: 120px" />
													</td>
												</tr>
												<tr id="trManCredRow11">
													<td class="StdTableCellWBorder" colspan="2" style="text-align: right; background-color: aquamarine;">Adjusted Invoice Amount:&nbsp;
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtManCredAdjInvAmt" class="InputNbrWNoBorder" style="width: 120px" />
													</td>
												</tr>
												<tr id="trManCredRow12">
													<td class="StdTableCellWBorder" colspan="2" style="text-align: right; background-color: aquamarine;">Adjustment Amount:&nbsp;
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtManCredAdjustAmt" class="InputNbrWNoBorder" style="width: 120px" />
													</td>
												</tr>
											</table>
										</div>

									</div>

									<div id="divCustClaim" style="width: 100%; display: none; margin-bottom: 10px;">
										<label id="lblCustCLaimHdr" style="color: blue; font-size: 14pt; font-weight: bold;">Customer Comment / Claim Form</label><br />

										<div id="divCustClaimForm" style="width: 100%;">
											<table id="tblCustCLaimForm" style="padding: 1px; border-spacing: 0px; border: none;">
												<tr>
													<td style="text-align: right;">Cust&nbsp;Name:&nbsp;
													</td>
													<td colspan="3">
														<input type="text" id="txtCustNameCC" style="width: 300px" />
														<input type="hidden" id="hfCustCodeCC" value="" />
													</td>
													<td style="text-align: right;">Order&nbsp;Nbr:&nbsp;
													</td>
													<td style="text-align: left;">
														<input type="text" id="txtOrderNbrCC" style="width: 90px" />
													</td>
													<td style="text-align: right;">Invoice&nbsp;Nbr:&nbsp;
													</td>
													<td>
														<input type="text" id="txtInvoiceNbrCC" style="width: 90px" />
													</td>
													<td>&nbsp;</td>
												</tr>
												<tr>
													<td style="text-align: right;">Region:&nbsp;
													</td>
													<td colspan="3">
														<select id="selRegionCC">
															<option value="0" selected="selected">None Selected</option>
														</select>
													</td>
													<td style="text-align: right;">Mill:&nbsp;
													</td>
													<td>
														<select id="selMillLocationCC">
															<option value="0" selected="selected">None Selected</option>
														</select>
													</td>
													<td style="text-align: right;">Shipment&nbsp;Nbr:&nbsp;
													</td>
													<td>
														<input type="text" id="txtShipmentNbrCC" style="width: 90px" />
													</td>
													<td>&nbsp;</td>
												</tr>
												<tr>
													<td style="text-align: right;">Vendor:&nbsp;
													</td>
													<td colspan="4">
														<input type="text" id="txtVendorNameCC" style="width: 400px" />
														<input type="hidden" id="hfVendorCodeCC" value="" />
													</td>
													<td colspan="2" style="text-align: right;">Salesman/Lead:&nbsp;
													</td>
													<td colspan="2">
														<select id="selSalesLeadCC">
															<option value="0" selected="selected">None Selected</option>
														</select>
													</td>
												</tr>
												<tr>
													<td colspan="9" style="line-height: 8px;">&nbsp;
													</td>
												</tr>
												<tr>
													<td colspan="9" style="border-top: 1px solid gray;">
														<label id="lblExplanationOfClaim" style="font-weight: bold; color: darkred;">EXPLANATION OF COMMENT/CLAIM:</label>
													</td>
												</tr>
												<tr>
													<td colspan="9" style="border-bottom: 4px double gray; height: 26px; vertical-align: bottom;">
														<label id="lblCClaimDirections1" style="font-size: 9pt; color: darkgray;">
															Please include a copy of your customer comment report with your request
														if this is a quality or tally issue. Also attach any backup information for our files.</label>
													</td>
												</tr>
												<tr>
													<td>Grade:&nbsp;
													</td>
													<td colspan="3">
														<select id="selGradeCC">
															<option value="0" selected="selected">None Selected</option>
														</select>
													</td>
													<td rowspan="2" style="vertical-align: top;">Misc&nbsp;Info:&nbsp;
													</td>
													<td rowspan="3" colspan="3" style="text-align: left;">
														<textarea id="txaMiscInfoCC" style="width: 460px; height: 66px;"></textarea>
													</td>
												</tr>
												<tr>
													<td>Size:&nbsp;
													</td>
													<td colspan="3">
														<select id="selThicknessCC">
															<option value="0" selected="selected">None Selected</option>
														</select>
													</td>
												</tr>
												<tr>
													<td>Specie:&nbsp;
													</td>
													<td colspan="3">
														<select id="selSpecieCC">
															<option value="0" selected="selected">None Selected</option>
														</select>
													</td>
												</tr>
												<tr>
													<td colspan="9">
														<label id="lblCClaimDirections2" style="font-size: 9pt; color: darkgray;">BRIEF DESCRIPTION OF QUALITY/TALLY COMMENT/CLAIM (to be filled out by sales person)</label>
													</td>
												</tr>
												<tr>
													<td colspan="9">
														<textarea id="txaCustClaimDesc" style="width: 960px; height: 120px; border: 1px solid gray; background-color: antiquewhite;"></textarea>
													</td>
												</tr>
												<tr>
													<td colspan="9">
														<label id="lblCClaimDirections3" style="font-size: 9pt; color: darkgray;">BRIEF DESCRIPTION OF INVESTIGATION (to be filled out by Resident QC)</label>
													</td>
												</tr>
												<tr>
													<td colspan="9">
														<textarea id="txaCustClaimInvestigation" style="width: 960px; height: 100px; border: 1px solid gray; background-color: lavenderblush;"></textarea>
													</td>
												</tr>
												<tr>
													<td colspan="9">
														<label id="lblMillErrorCC" style="color: darkblue;">Mill&nbsp;Error:</label>&nbsp;Yes<input type="radio" name="radMillError" id="radMillErrorY" />&nbsp;No<input type="radio" name="radMillError" id="radMillErrorN" checked="checked" />
													</td>
												</tr>
												<tr>
													<td colspan="9">
														<label id="lblCClaimDirections4" style="font-size: 9pt; color: darkgray;">BRIEF DESCRIPTION OF RESOLUTION (Must be approved by agreement between QC and Sales Management)</label>
													</td>
												</tr>
												<tr>
													<td colspan="9">
														<textarea id="txaCustClaimResolution" style="width: 960px; height: 100px; border: 1px solid gray; background-color: lavenderblush;"></textarea>
													</td>
												</tr>
												<tr>
													<td style="text-align: right;">Resolution&nbsp;Date:&nbsp;
													</td>
													<td colspan="7" style="text-align: left;">
														<input type="text" id="txtResolutionDateCC" style="width: 80px;" />
													</td>
													<td>&nbsp;</td>
												</tr>
												<tr>
													<td colspan="4" style="text-align: right;">Total&nbsp;Dollar&nbsp;Amount:&nbsp;
													</td>
													<td colspan="5" style="text-align: left;">
														<input type="text" id="txtResolutionAmtCC" style="width: 120px; background-color: gainsboro;" />
													</td>
												</tr>
											</table>
										</div>
									</div>

								</td>
								<td style="text-align: left; vertical-align: top;">

									<table>
										<tr>
											<td>
												<div id="spnRightAttachDrop" style="display: none;">
													<br />
													<br />
													<span style="color: maroon; font-size: 10pt;">Add Attachment</span>:&nbsp;<input type="file" name="files[]" id="files" multiple onchange="javascript:HandleMultiFilesFf(this.files, 41);return false;">
													<div id="divFileContents" style="display: none;"></div>
													&nbsp;&nbsp;
												</div>
											</td>
											<td>
												<div id="spnAttachMessage" style="display: none; font-weight: bold;">
													<br />
													<br />
													To attach documents you must first save this request.
												</div>
											</td>
										</tr>
									</table>

								</td>
							</tr>
						</table>

						<div id="divFormBlank" style="width: 100%; display: none; height: 400px; text-align: center;">
							<br />
							<br />
							<br />
							<span id="spnBlankFormMsg" style="font-size: 16pt; font-family: Tahoma; font-weight: bold; color: maroon;">&diams;&nbsp;NO FORM TYPE SELECTED&nbsp;&diams;</span>
						</div>
					</div>
					<div id="divTab2" style="border: none; width: 100%; height: 100%; display: none; margin: 0px; overflow: scroll;">

						<span id="spnChangePageSize" style="display: inline; margin-right: 30px;">&nbsp;&nbsp;Page&nbsp;Size:&nbsp;
							<select id="selPageSize2" style="margin-left: 10px; display: inline;" onchange="javascript:ChangePageSize2();return false;">
								<option value="10">10</option>
								<option value="20" selected="selected">20</option>
								<option value="25">25</option>
								<option value="30">30</option>
								<option value="35">35</option>
								<option value="40">40</option>
								<option value="50">50</option>
							</select>
						</span>

						<div id="divDocStatusChanges" style="width: 100%; margin-top: 6px;">
							<div id="divInvAdjStatusChgHdr" style="width: 100%;">
								<label id="lblInvAdjStatusHdr" style="color: darkgreen; font-weight: bold; font-size: 14pt;">Status Changes</label>
							</div>
							<div id="divInvAdjStatusList" style="width: 100%;">
								<table id="tblStatusList" style="border: none; border-spacing: 0px; padding: 1px;">
									<thead>
										<tr>
											<th class="TableHdrCell" style="width: 60px;">Step</th>
											<th class="TableHdrCell" style="width: 140px;">Status</th>
											<th class="TableHdrCell" style="width: 160px;">Status Date</th>
											<th class="TableHdrCell" style="width: 160px;">Change By</th>
											<th class="TableHdrCell" style="width: 300px;">Comments</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<!-- #include file="../inc/incPaginationDiv2.inc" -->
							</div>
						</div>
					</div>
					<div id="divTab3" style="border: none; width: 100%; height: 100%; display: none; margin: 0px; overflow: scroll;">

						<span id="spnChangePageSize2" style="display: inline; margin-right: 30px;">&nbsp;&nbsp;Page&nbsp;Size:&nbsp;
							<select id="selPageSize" style="margin-left: 10px; display: inline;" onchange="javascript:ChangePageSize();return false;">
								<option value="10">10</option>
								<option value="20" selected="selected">20</option>
								<option value="25">25</option>
								<option value="30">30</option>
								<option value="35">35</option>
								<option value="40">40</option>
								<option value="50">50</option>
							</select>
						</span>

						<div id="divFormAttachments" style="width: 100%;">
							<div id="divInvAdjAttachmentHdr" style="width: 100%;">
								<label id="lblInvAdjAttachmentsHdr" style="color: darkgreen; font-weight: bold; font-size: 14pt;">Attachments</label>
							</div>
							<div id="divInvAdjAttachmentList" style="width: 100%;">
								<table id="tblAttachmentsList" style="border: 1px solid gray; border-spacing: 0px; padding: 1px; border-collapse: collapse;">
									<thead>
										<tr>
											<th class="TableHdrCell" style="width: 70px;">ID</th>
											<th class="TableHdrCell" style="width: 190px;">Title</th>
											<th class="TableHdrCell" style="width: 260px;">Description</th>
											<th class="TableHdrCell" style="width: 90px;">Content Type</th>
											<th class="TableHdrCell" style="width: 90px;">File Type</th>
											<th class="TableHdrCell" style="width: 80px;">File Size</th>
											<th class="TableHdrCell" style="width: 90px;">Inserted On</th>
											<th class="TableHdrCell" style="width: 170px;">Inserted By</th>
											<th class="TableHdrCell" style="width: 90px;">Action</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
								<!-- #include file="../inc/incPaginationDiv.inc" -->
							</div>
						</div>
					</div>
				</div>




				<!----------------------------------------- FOOTER PORTION ----------------------------------------------->


				<div id="divFormFooter" style="width: 100%; display: none;">
					<hr style="color: maroon; border: 3px solid maroon;" />
					<div id="divFormFooterHdr" style="width: 100%; text-align: right:">
					</div>


				</div>

			</div>

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
