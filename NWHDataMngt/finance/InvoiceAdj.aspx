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
		.FormLabelStdPg {
			text-align: right;
		}
		
		.FormFieldStdPg {
			text-align: left;
		}

		.HelpHdrLine {
			color: indianred; 
			font-weight: bold; 
			text-align: left;
		}

		.HelpNbrCell {
			width: 50px; 
			text-align: center; 
			vertical-align: top;
		}

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

		.TabHdrBoxes {
			border: 1px solid gray; 
			width: 150px; 
			height: 28px; 
			font-size: 10pt; 
			text-align: center; 
			border-top-left-radius: 10px; 
			border-top-right-radius: 10px; 
			color: blue; 
			background-color: #D1D0CE;
			border-bottom: none;
		}

	</style>

	<script type="text/javascript">
		var counter = 0;
		var jaAttributes;
		var jbA = false;
		var jbAllLocations = false;
		var jbCanApprove = false;
		var jbCanEdit = true;
		var jbCanInitiate = true;
		var jbIsDirty=false;
		var jbLoadedCarrierList = false;
		var jbLoadedCreditRepList = false;
		var jbLoadedCustomerList = false;
		var jbLoadedInvoiceItems = false;
		var jbLoadedSalesLeadList = false;
		var jbLoadedLocationList = false;
		var jbLoadedLocationList2 = false;
		var jbLoadedDestinationList = false;
		var jbLoadedLossDmgCodes = false;
		var jbLoadedProdCodeList = false;
		var jbLoadedProdTypeList = false;
		var jbLoadedSalesLeadList = false;
		var jbLoadedSalesStaffList = false;
		var jbLoadedReasonList = false;
		var jbLoadedVendorList = false;
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
		var jdivTab4;
		var jdivTabHdr1;
		var jdivTabHdr2;
		var jdivTabHdr3;
		var jdivTabHdr4;
		var jdivVendorClaim;
		var jdToday = new Date();
		var jfInvoiceAdjAmount = 0;
		var jfInvoiceAmtNew = 0;
		var jfInvoiceAmtOrig = 0;
		var jfPageTotal = 0;
		var jhfCustCodeCC;
		var jhfCustCodeE;
		var jhfCustCodeFAE;
		var jhfCustCodeLAD;
		var jhfCustCodeM;
		var jhfCustCodeMCE;
		var jhfCustCodeVCE;
		var jhfInvoiceDate;
		var jhfInvoiceID;
		var jhfReqByIDE;
		var jhfRequestedByIDM;
		var jhfRequestID;
		var jhfSubmittedByIDHDR;
		var jhfVendorCodeCC;
		var jhfVendorCodeVCE;
		var jiAddLineIDX = 16;
		var jiAddTicketIDX = 40;
		var jiAR = 0;
		var jiByID = 0;
		var jiCommentID = 0;
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
		var jiRequesterID = 0;
		var jiRequestID = 0;
		var jiTableRowIdxRM = 39;
		var jiTargetRow=0;
		var jiTotalRows = 0;
		var jiUserID = 0;
		var jlRequestIDE;
		var jlBuildNbr;
		var jlCurrentYearFtr;
		var jlIncludedSections;
		var jlInvoiceAdjReqHdr;
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
		var jselLossDmgClass;
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
		var jsLastAJAXCall = '';
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
		var jsRegionCode = '';
		var jsStartDate = '';
		var jsStatusCode = '';
		var jdToday = new Date();
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
		var jtSubmittedByHDR;
		var jtSubmittedOnCC;
		var jtSubmittedOnHDR;
		var jtTransOrderNbrM;

		var MyAttachmentList;
		var MyCarrierList;
		var MyCodeListData;
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
		var MyLocationList2;
		var MyLossDmgCodeList;
		var MyLTCodeList;
		var MyPersPositionList;
		var MyProdTypeCodeList;
		var MyProdTypeList;
		var MyProductItemData;
		var MyProductList;
		var MyReasonList;
		var MyRequestData;
		var MyRequestDocsData;
		var MySalesLeadList;
		var MySalesPersList;

		var DayNamesNV = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
		var jiaDocTypeID = [0, 0, 0, 0, 0, 0];
		var jiaFormatType = createArrayGu(15);
		var jiaInvoiceReqID = [0, 0, 0, 0, 0, 0];
		var jsaDocType = ['', '', '', '', '', ''];
		var jsaStatus = ['', '', '', '', '', '', '', '', '', ''];
		var jsaTypeCodes = ['NONE', '', 'INVADJ', 'RMANF', 'FRTACC', 'VENDCLM', 'LSSDMG', 'INVCHG', 'MACADJ', 'MNLCRED', 'CUSTCLM', '', ''];
		var jsaTypeNames = ['NONE', '', 'Invoice Adj', 'Rtn Manifest', 'Freight Acc', 'Vendor Claim', 'LossDmg Claim', 'Inventory Adj', 'MAC Adjust', 'Manual Credit', 'Cust Claim', '', ''];

		// page initiation section --------------------------------------------------------------------------------
		//#region PageInitiationR	JS
		$(document).ready(function () {
			jsToday = getMyDateTimeStringDm(jdToday, 9);
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
			jdivTab4 = document.getElementById('divTab4');
			jdivTabHdr1 = document.getElementById('divTabHdr1');
			jdivTabHdr2 = document.getElementById('divTabHdr2');
			jdivTabHdr3 = document.getElementById('divTabHdr3');
			jdivTabHdr4 = document.getElementById('divTabHdr4');
			jhfCustCodeCC = document.getElementById('hfCustCodeCC');
			jhfCustCodeE = document.getElementById('hfCustCodeE');
			jhfCustCodeFAE = document.getElementById('hfCustCodeFAE');
			jhfCustCodeLAD = document.getElementById('hfCustCodeLAD');
			jhfCustCodeM = document.getElementById('hfCustCodeM');
			jhfCustCodeMCE = document.getElementById('hfCustCodeMCE');
			jhfCustCodeVCE = document.getElementById('hfCustCodeVCE');
			jhfInvoiceDate = document.getElementById('hfInvoiceDate');
			jhfInvoiceID = document.getElementById('hfInvoiceID');
			jhfReqByIDE = document.getElementById('hfReqByIDE');
			jhfRequestedByIDM = document.getElementById('hfRequestedByIDM');
			jhfRequestID = document.getElementById('hfRequestID');
			jhfSubmittedByIDHDR = document.getElementById('hfSubmittedByIDHDR');
			jhfVendorCodeCC = document.getElementById('hfVendorCodeCC');
			jhfVendorCodeVCE = document.getElementById('hfVendorCodeVCE');
			jlRequestIDE = document.getElementById('lblRequestIDE');
			jlBuildNbr = document.getElementById('lblBuildNbr');
			jlCurrentYearFtr = document.getElementById('lblCurrentYearFtr');
			jlIncludedSections = document.getElementById('lblIncludedSections');
			jlInvoiceAdjReqHdr=document.getElementById('lblInvoiceAdjReqHdr');
			jlRequestStatusH = document.getElementById('lblRequestStatusH');
			jlPageIDInhFooter = document.getElementById('lblPageIDInhFooter');
			jlStatusMsg = document.getElementById('lblStatusMsg');
			jselCreditRepE = document.getElementById('selCreditRepE');
			jselCreditRepM = document.getElementById('selCreditRepM');
			jselDocumentType = document.getElementById('selDocumentType');
			//jselProdCodeLAD1 = document.getElementById('selProdCodeLAD01');
			//jselProdCodeLAD2 = document.getElementById('selProdCodeLAD02');
			//jselProdCodeLAD3 = document.getElementById('selProdCodeLAD03');
			jselLossDmgClass = document.getElementById('selLossDmgClass');
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
			jtSubmittedByHDR = document.getElementById('txtSubmittedByHDR');
			jtSubmittedOnCC = document.getElementById('txtSubmittedOnCC');
			jtSubmittedOnHDR = document.getElementById('txtSubmittedOnHDR');
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
			jtReqByE.value = jsUserName;
			jiDocumentType = 0;
			jsDocType = '';
			jiPgNbrPj[0] = 0;
			jiNbrProdsMAC = 1;
			jiNbrProdsLAD = 3;
			jiRequestID = 0;
			jiInvoiceID = 0;
			jtDateReqE.value = jsToday;
			jselDocumentType.value = '0';
			jsDocType = '';

			//alert('loading initial data');
			PopulateDocTypes();
			//alert('1');
			GetProdTypeLists('', 0, 1);
			//alert('2');
			GetCustomerList('');
			//alert('3');
			GetVendorList('');

			//alert('establishing page elements');
			EstablishMainPgElementsPj(1, 0);
			EstablishMainPgElementsPj(2, 0);

			if(jiInvoiceReqID === 0) {
				jsDocumentStatus = 'U';
				FillDocumentStatus(jsDocumentStatus);
				jsaStatus[0] = jsDocumentStatus;
				PopulateDocStatusFlow(0);
			}
			else {
				alert('initializing ' + jiInvoiceReqID.toString());
				InitializeInvAdj();
			}
			//alert('setting form elements');
			jspnAttachMessage.style.display = 'none';
			jspnRightAttachDrop.style.display = 'none';
			document.getElementById('lblPageIDInFooter').innerHTML = 'Page ID: ' + jiPageID.toString();
			jtFindInvoiceNbr.readOnly = true;
			jtRequestIDE.readOnly = true;
			jdivFormFooter.style.display = 'none';
			jdivFormBlank.style.display = 'block';
			jspnSaveRequest.style.display = 'none';
			jspnExportToPDFbtn.style.display = 'none';
			//jsStatusCode = 'U';
			createDatePickerOnTextWc('txtRequiredDateE', null, null, 0, 3, 'show', 11);
			//createDatePickerOnTextWc('txtEndDateF', null, null, 0, 3, 'show', 12);
			SetTabVisible(1);
			//alert('Initiation done');
			return false;
		}
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
			jsLastAJAXCall = MyData;
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyAttachmentList = response; });
			return false;
		}

		function GetAttachmentList2(dtype, dtype2, dtype3, id, id2, ext, sort) {
			var url = "../shared/AJAXServices.asmx/GetAttachmentList2";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','DocType':'" + dtype + "','DocType2':'" + dtype2 + "','DocType3':'" + dtype3 + "','ID':'" + id.toString() + "','ID2':'" + id2.toString() + "',";
			MyData = MyData + "'Ext':'" + ext + "','PgNbr':'','PgSize':'" + jiPageSize2.toString() + "','Sort':'" + sort.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			jsLastAJAXCall = MyData;
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
			jsLastAJAXCall = MyData;
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyCustomerData = response; });
			if(!IsContentsNullUndefEmptyGu(MyCustomerData)) { jbLoadedCustomerList = true; }
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
			jsLastAJAXCall = MyData;
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyInventoryItemData = response; });
			return false;
		}

		function GetInvoiceData() {
			var url = "../shared/FinanceServices.asmx/SelectInvoiceData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','InvoiceID':'" + jiInvoiceID.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			jsLastAJAXCall = MyData;
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

		function GetInvoiceRequestData() {
			var url = "../shared/FinanceServices.asmx/SelectInvoiceRequestData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','InvReqID':'" + jiInvoiceReqID.toString() + "','ByID':'" + jiByID.toString() + "'}";
			alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function(response)
			{ MyInvRequestData = response; });
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

		function GetLocationList2(reg, loc, ltype, ctry, city, cls, sort, act) {
			var url = "../shared/AdminServices.asmx/SelectLocationListM";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','Region':'" + reg + "','Loc':'" + loc + "','LocType':'" + ltype + "','Country':'" + ctry + "','City':'" + city + "','Class':'" + cls.toString() + "','Sort':'" + sort.toString() + "',";
			MyData = MyData + "'Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyLocationList2 = response; });
			jbLoadedLocationList2 = true;
			return false;
		}
		
		function GetLossDmgCodeList(sort, act) {
			var url = "../shared/AdminServices.asmx/SelectBusinessCodeList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','BCClass':'','CodeGrp':'LossDmgClass','Active':'" + act.toString() + "','Shown':'1',";
			MyData = MyData + "'Sort':'" + sort.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyLossDmgCodeList = response; });
			jbLoadedLossDmgCodes = true;
			return false;
		}

		function GetLTProdCodeList(pref, sort, act) {
			var url="../shared/GridSupportServices.asmx/SelectLTProdCodeList";
			var MyData="{'PgID':'"+jiPageID.toString()+"','ObjID':'0','Prefix':'"+pref+"','Sort':'"+sort.toString() + "','Active':'" + act.toString() + "','ByID':'"+jiByID.toString()+"'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function(response)
			{ MyLTCodeList = response; });
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

		function GetProductData(pmid, plid, pt, pcode) {
			var region = jselRegionMF.value;
			var loc = jselLocationMF.value;
			var url = "../shared/AjaxServices.asmx/SelectProductItemData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','PMID':'" + pmid.toString() + "','PLID':'" + plid.toString() + "','ProdType':'" + pt + "','ProdCode':'" + pcode + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyProductItemData = response; });
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
			jbLoadedProdTypeList = true;
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

		function GetRequestData(irid) {
			var url = "../shared/FinanceServices.asmx/SelectRequestData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ReqID':'" + jiRequestID.toString() + "','InvReqID':'" + irid.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			jsLastAJAXCall = MyData;
			getJSONReturnDataAs(url, MyData, function(response)
			{ MyRequestData = response; });
			if(MyRequestData.length > 0) {
				jsDocumentStatus = MyRequestData[0]['StatusCode'].toString();
			}
			return false;
		}

		function GetRequestDocTypeList() {
			var url = "../shared/FinanceServices.asmx/SelectRequestDocsData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','InvReqID':'" + jiRequestID.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function(response)
			{ MyRequestDocsData = response; });
			if(MyRequestDocsData.length > 0) {
				jsDocumentStatus = MyRequestDocsData[0]['StatusCode'].toString();
			}
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

		function GetUserDocRights(doctype, id) {
			jiDocRightLevel = 0;
			var url = "../shared/AdminServices.asmx/GetUserDocRights";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','DocType':'" + doctype + "','RequestID':'" + id.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			jsLastAJAXCall = MyData;
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			if(!IsContentsNullUndefEmptyGu(MyReturn)) {
				jiDocRightLevel = parseInt(MyReturn[0]['RightLevel'], 10);
			}
			return false;
		}

		function GetVendorList(seed) {
			var url = "../shared/FinanceServices.asmx/SelectVendorList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','Seed':'" + seed + "','Sort':'0','Min':'1','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function(response)
			{ MyVendorList = response; });
			if(!IsContentsNullUndefEmptyGu(MyVendorList)) { jbLoadedVendorList = true; }
			return false;
		}

		function UpdateInvRequest(dtreq, byid, stat, idt, crepid, spid, slead, sfm, rc, rdet, cust, ctlnbr, cid, vend, onbr, shpnbr, onbr1, onbr2, loc2, loc3, crc, set1, set2, set3, set4, set5, set6, amt, aiamt, aamt, frate, oamt, oval1, oval2, pval1, pval2, pval3, rdate, tdate, adate1, adate2, tdate1, tdate2, nprod, cmt, act) {
			jsErrorMsg = '';
			var url = "../Shared/FinanceServices.asmx/UpdateInvRequestData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','RequestID':'" + jiRequestID.toString() + "','InvReqID':'" + jiInvoiceReqID.toString() + "','DTReq':'" + dtreq + "','ReqByID':'" + byid.toString() + "',";
			MyData = MyData + "'DocType':'" + jsDocType + "','DispID':'" + jiDocumentType.toString() + "','StatusCode':'" + stat + "','CustCode':'" + cust + "','CustCtlNbr':'" + ctlnbr + "','CarrierID':'" + cid.toString() + "',";
			MyData = MyData + "'VendorCode':'" + vend + "','InvNbr':'" + jiInvoiceID.toString() + "','InvDt':'" + idt + "','OrdNbr':'" + onbr.toString() + "','ShipNbr':'" + shpnbr + "','OtherNbr1':'" + onbr1.toString() + "',";
			MyData = MyData + "'OtherNbr2':'" + onbr2.toString() + "','CreditRepID':'" + crepid.toString() + "','SalesPID':'" + spid.toString() + "','SalesLead':'" + slead + "','ShipFmLoc':'" + sfm + "','LocCode2':'" + loc2 + "',";
			MyData = MyData + "'LocCode3':'" + loc3 + "','ReasonCode':'" + rc + "','ReasonDetail':'" + rdet + "','CustReqCopy':'" + crc.toString() + "','Setting1':'" + set1.toString() + "',";
			MyData = MyData + "'Setting2':'" + set2.toString() + "','Setting3':'" + set3.toString() + "','Setting4':'" + set4.toString() + "','Setting5':'" + set5.toString() + "','Setting6':'" + set6.toString() + "',";
			MyData = MyData + "'OrigAmt':'" + oamt.toString() + "','AdjInvoiceAmt':'" + aiamt.toString() + "','AdjAmt':'" + aamt.toString() + "','FrtRate':'" + frate.toString() + "','OtherAmt':'" + oamt + "',";
			MyData = MyData + "'OtherVal1':'" + oval1 + "','OtherVal2':'" + oval2 + "','ProdVal1':'" + pval1 + "','ProdVal2':'" + pval2 + "','ProdVal3':'" + pval3 + "','RequiredDt':'" + rdate + "','TgtDT':'" + tdate + "',";
			MyData = MyData + "'ActDate1':'" + adate1 + "','ActDate2':'" + adate2 + "','TransDT1':'" + tdate1 + "','TransDT2':'" + tdate2 + "','NbrProd':'" + nprod.toString() + "','Active':'" + act.toString() + "',";
			MyData = MyData + "'ByID':'" + jiByID.toString() + "'}";
			alert(MyData);
			jsLastAJAXCall = MyData;
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyResponse = response; });
			EvaluateStdDatabaseReturnAs(MyResponse, jdivStatusMsg, jlStatusMsg, 'Claim request could not be saved because of an error.', 'No response came from the database when attempting to save claim request.');
			if(!IsContentsNullUndefEmptyGu(MyResponse)) {
				jiInvoiceReqID = parseInt(MyResponse[0]['InvoiceRequestID'], 10);
			}
			//GetAttachments();      
			return false;
		} 

		function UpdateInvReqLine(lnid, inbr, ptype, pcode, desc, Attribs, oqty, oqty2, rqty, rqty2, oprice, rprice, crdbamt, ia, rtag, rtnqty, rpkg, qchkin, tkt, expl, loc, rtn, act) {
			jlStatusMsg.innerHTML = '';
			jaAttributes = Attribs.split('|');
			var url = "../shared/FinanceServices.asmx/UpdateInvRequestLine";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','IRLineID':'" + lnid.toString() + "','InvReqID':'" + jiInvoiceReqID.toString() + "','ItemNbr':'" + inbr.toString() + "','iDoctType':'" + jiDocumentType.toString() + "',";
			MyData = MyData + "'ProdType':'" + ptype + "','ProdCode':'" + pcode + "','Desc':'" + desc + "','A1':'" + jaAttributes[0] + "','A2':'" + jaAttributes[1] + "','A3':'" + jaAttributes[2] + "',";
			MyData = MyData + "'A4':'" + jaAttributes[3] + "', 'A5':'" + jaAttributes[4] + "', 'A6':'" + jaAttributes[5] + "', 'A7':'" + jaAttributes[6] + "','A8':'" + jaAttributes[7] + "','A9':'" + jaAttributes[8] + "',";
			MyData = MyData + "'A10':'" + jaAttributes[9] + "','A11':'" + jaAttributes[10] + "','A12':'" + jaAttributes[11] + "','A13':'" + jaAttributes[12] + "','OrigQty':'" + oqty.toString() + "','OrigQty2':'" + oqty2.toString() + "',";
			MyData = MyData + "'RevQty':'" + rqty.toString() + "','RevQty2':'" + rqty2.toString() + "','OrigPrice':'" + oprice.toString() + "','RevPrice':'" + rprice.toString() + "','TotalCRDBAmt':'" + crdbamt.toString() + "',";
			MyData = MyData + "'InvAdj':'" + ia.toString() + "','RedTag':'" + rtag.toString() + "','RtnQty':'" + rtnqty.toString() + "','RtnPkg':'" + rpkg.toString() + "','RtnQtyCheckedIn':'" + qchkin.toString() + "','Tickets':'" + tkt + "',";
			MyData = MyData + "'Explanation':'" + expl + "', 'LocCode':'" + loc + "', 'IsRtn':'" + rtn.toString() + "', 'Active':'" + act.toString() + "', 'ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			jsLastAJAXCall = MyData;
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			EvaluateStdDatabaseReturnAs(MyResponse, jdivStatusMsg, jlStatusMsg, 'Request Line ' + iNbr.toString() + ' could not be saved because of an error.', 'No response came from the database when attempting to save Line ' + iNbr.toString() + '.');
			return false;
		}

		function UpdateRequestData(rid, sdate, rbyid, dispid, stat, nbrcomp, critical, cmt, emailto, doctypes, doctypeIDs, reqon, act) {
			jsErrorMsg = '';
			var url = "../Shared/FinanceServices.asmx/UpdateRequest";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ReqID':'" + rid.toString() + "','sDate':'" + sdate + "','ReqByID':'" + rbyid.toString() + "','DispID':'" + dispid.toString() + "','Stat':'" + stat + "',";
			MyData = MyData + "'NbrComp':'" + nbrcomp.toString() + "','Critical':'" + critical.toString() + "','InvNbr':'" + jiInvoiceID.toString() + "','OrdNbr':'" + jiOrderNbr.toString() + "','Cmt':'" + cmt + "','EmailTo':'" + emailto + "',";
			MyData = MyData + "'DocTypes':'" + doctypes + "','DocTypeIDs':'" + doctypeIDs + "','RequiredOn':'" + reqon + "','Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
			alert(MyData);
			jsLastAJAXCall = MyData;
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyResponse = response; });
			//(dtable, statusobj, accfailmsg, nortnmsg, msginvalidmsg)
			EvaluateStdDatabaseReturnAs(MyResponse, jdivStatusMsg, jlStatusMsg, 'Request could not be saved because of an error.', 'No response came from the database when attempting to save the request.');
			if(!IsContentsNullUndefEmptyGu(MyResponse)) {
				jiRequestID = parseInt(MyResponse[0]['RequestID'], 10);
				alert(jiRequestID);
			}
			//GetAttachments();
			return false;
		}

		function UpdateCommentData(cid, inbr, typ, ctype, ttl, loc, tdt, origid, fieldnm, cmt) {
			jsErrorMsg = '';
			if(jiInvoiceReqID===0) {
				alert('No valid Invoice Request Document ID exists.');
				return false;
			}
			var url = "../Shared/GridSupportServices.asmx/UpdateCommentRequestData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','InvReqID':'" + jiInvoiceReqID.toString() + "','CmtID':'" + cid.toString() + "','ItemNbr':'" + inbr.toString() + "','iType':'" + typ.toString() + "',";
			MyData = MyData + "'CmtType':'" + ctype.toString() + "','Title':'" + ttl + "','Loc':'" + loc + "','Comment':'" + cmt + "','InsGraph':'0','Wdth':'0','Ht':'0','TDt':'" + tdt + "',";
			MyData = MyData + "'OrigID':'" + origid.toString() + "','Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
			alert(MyData);
			jsLastAJAXCall = MyData;
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyResponse = response; });
			EvaluateStdDatabaseReturnAs(MyResponse, jdivStatusMsg, jlStatusMsg, 'Data for ' +  fieldnm + ' could not be saved because of an error.', 'No response came from the database when attempting to save ' +  fieldnm + '.');
			if(!IsContentsNullUndefEmptyGu(MyResponse)) {
				jiCommentID = parseInt(MyResponse[0]['CommentID'], 10);
			}
			return false;
		}

		function DeleteInvRequestLine(lid, inbr) {
			var url = "../shared/FinanceServices.asmx/DeleteInvRequestLine";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','InvRequestID':'" + jiInvoiceReqID.toString() + "','ItemNbr':'" + inbr.toString() + "','LineID':'" + lid.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			jsLastAJAXCall = MyData;
			getJSONReturnDataAs(url, MyData, function(response)
			{ MyReturn = response; });
			EvaluateStdDatabaseReturnAs(MyResponse, jdivStatusMsg, jlStatusMsg, 'Request Line ' + iNbr.toString() + ' could not be removed because of an error.', 'No response came from the database when attempting to remove Line ' + iNbr.toString() + '.');
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

		function PopulateCreditRepListsFA() {
			if(jbLoadedCreditRepList === false || IsContentsNullUndefEmptyGu(MyCreditRepList)) {
				GetCreditRepList(0, 1);	// MyCreditRepList
				jbLoadedCreditRepList = true;
			}
			ClearDDLOptionsGu('selCreditRepFAE', 1);
			if(!IsContentsNullUndefEmptyGu(MyCreditRepList)) {
				var sCreditReps = document.getElementById('selCreditRepFAE');
				fillDropDownListGu(MyCreditRepList, sCreditReps, 0, 'ItemDescription', 'ItemCode');
			}
			return false;
		}

		function PopulateCreditRepListsMC() {
			if(jbLoadedCreditRepList === false || IsContentsNullUndefEmptyGu(MyCreditRepList)) {
				GetCreditRepList(0, 1);	// MyCreditRepList
				jbLoadedCreditRepList = true;
			}
			ClearDDLOptionsGu('selCreditRepMCE', 1);
			if(!IsContentsNullUndefEmptyGu(MyCreditRepList)) {
				var sCreditReps = document.getElementById('selCreditRepMCE');
				fillDropDownListGu(MyCreditRepList, sCreditReps, 0, 'ItemDescription', 'ItemCode');
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

		function PopulateCreditRepListsVC() {
			if(jbLoadedCreditRepList === false || IsContentsNullUndefEmptyGu(MyCreditRepList)) {
				GetCreditRepList(0, 1);	// MyCreditRepList
				jbLoadedCreditRepList = true;
			}
			ClearDDLOptionsGu('selCreditRepVCE', 1);
			if(!IsContentsNullUndefEmptyGu(MyCreditRepList)) {
				var sl = document.getElementById('selCreditRepVCE');
				fillDropDownListGu(MyCreditRepList, sl, 0, 'ItemDescription', 'ItemCode');
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
			LoadStatusBtnBar();
			//ClearDDLOptionsGu('selSetNewStatus', 1);
			//if(MyDocStatFlow !== undefined && MyDocStatFlow !== null) {
			//	fillDropDownListGu(MyDocStatFlow, jselSetNewStatus, 0, 'StatusActionLabel', 'NewStatusCode');
			//}
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
		
		function PopulateGradeList() {
			GetProdCodeList('Grade');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				//alert('Grade - ' + MyCodeListData.length);
				ClearDDLOptionsGu('selGradeCC', 1);
				var sel = document.getElementById('selGradeCC');
				fillDropDownListGu(MyCodeListData, sel, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			//alert('Done with grades');
			return false;
		}

		function PopulateGradeListByRegion() {
			GetProdCodeListForRegion('Grade');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selGradeCC', 1);
				var sel = document.getElementById('selGradeCC');
				fillDropDownListGu(MyCodeListData, sel, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateInventoryChgItems() {
			PopulateLocationListsIC();
			PopulateProdTypeListsIC();
			jlStatusMsg.innerHTML = '';
			if(jiInvoiceID > 0) { GetInvoiceItems('INVCHG'); }
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
				alert('Proc List Len: ' + MyInvoiceItems.length);
				var bdy = FormDataGridBodyMinimumDg(1, nCol, 'tdInventChgList', cellClass, true, true, false, false, '', 'button blue-gradient glossy', false, 0, MyInvoiceItems, 'LineID', cnames, cType, cWidth, corientH, corientV, cbrdrL, cbrdrR, cbrdrT, cbrdrB, aggType, shown, true, true);
				//alert('Grid done');
				jtblInvChangeItems.style.display = 'block';

				// disable buttons if the person cannot initiate 
				if(jbCanInitiate===false) {
					for(var row=0; row<MyInvoiceItems.length; row++) {
						document.getElementById('btnEditRow' + row.toString() + '_1').disabled = true;
						document.getElementById('btnDeleteRow' + row.toString() + '_1').disabled = true;
					}
				}
			}
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
			//alert(jsaDocType);
			// MyInvAdjData, MyInvoiceData
			jhfInvoiceDate.value = '';
			jiOrderNbr = 0;
			if(!IsContentsNullUndefEmptyGu(MyInvoiceData)) {
				jhfInvoiceDate.value = MyInvoiceData[0]['sInvDate'].toString();
				jiOrderNbr = parseInt(MyInvoiceData[0]['OrdNbr'], 10);
				for(var dtype=0; dtype<jiNbrDocs; dtype++) {
					//alert(jiaDocTypeID[dtype]);
					switch(jiaDocTypeID[dtype]) {
						case 2:	//InvAdjustment Only
							PopulateInvoiceDataIA();
							break;
						case 3:	//Return Manifest
							PopulateInvoiceDataRM();
							break;
						case 4:	//Freight Accrual
							PopulateInvoiceDataFA();
							break;
						case 5:	//Vendor Claim
							PopulateInvoiceDataVC();
							break;
						case 6:	//Loss & Damage Claim
							PopulateInvoiceDataLAD();
							break;
						case 7:	//Inventory Change
							// nothing
							break;
						case 8:	//MAC Adjustment
							PopulateInvoiceDataMA();
							break;
						case 9:	//Manual Credit
							PopulateInvoiceDataMC();
							break;
						case 10: //Cust Claim
							PopulateInvoiceDataCC();
							break;
						default:
							break;
					}
				}
			}
			return false;
		}

		function PopulateInvoiceLineData() {
			//GetInvoiceItems(sdtype)
			if(!IsContentsNullUndefEmptyGu(MyInvoiceItems)) {
				switch(jiDocumentType) {
					case 2:	//InvAdjustment Only
						PopulateInvoiceLinesIA();
						break;
					case 3:	//Return Manifest
						PopulateInvoiceLinesRM();
						break;
					//case 4:	//Freight Accrual
					//	break;
					//case 5:	//Vendor Claim
					//	break;
					case 6:	//Loss & Damage Claim
						PopulateLossDamageLines();
						break;
					case 7:	//Inventory Adjustment
						PopulateInventoryChgItems();
						break;
					case 8:	//MAC Adjustment
						PopulateMACAdjustLines();
						break;
					//case 9:	//Manual Credit
					//	break;
					//case 10: //Cust Claim
					//	break;
					default:
						break;
				}
			}
			return false;
		}

		function PopulateInvoiceDataCC() {
			if(!IsContentsNullUndefEmptyGu(MyInvoiceData)) {
				document.getElementById('txtSubmittedByCC').value=jsUserName;
				document.getElementById('txtSubmittedOnCC').value=jsToday;
				document.getElementById('txtOrderNbrCC').value=MyInvoiceData[0]['OrdNbr'].toString();
				document.getElementById('hfCustCodeCC').value=MyInvoiceData[0]['cust'].toString();
				document.getElementById('txtCustNameCC').value=MyInvoiceData[0]['CustName'].toString();
				document.getElementById('txtInvoiceNbrCC').value=MyInvoiceData[0]['InvoiceNbr'].toString();
				document.getElementById('selRegionCC').value=MyInvoiceData[0]['RegionCode'].toString();
				document.getElementById('selMillLocationCC').value=MyInvoiceData[0]['loc'].toString();
				document.getElementById('txtShipmentNbrCC').value=MyInvoiceData[0]['shpnum'].toString();
				document.getElementById('txtVendorNameCC').value=MyInvoiceData[0]['VendorName'].toString();
				document.getElementById('hfVendorCodeCC').value=MyInvoiceData[0]['vendor'].toString();
				document.getElementById('selSalesLeadCC').value=MyInvoiceData[0]['slsgrp'].toString();
				document.getElementById('radMillErrorN').checked=true;
				createDatePickerOnTextWc('txtResolutionDateCC', null, null, 0, 3, 'show', 11);
				SetTextBoxAutoComplete2Wc('hfCustCodeCC', 3, jhfCustCodeCC, MyCustomerData, 'cust', 'CustName');
				SetTextBoxAutoComplete2Wc('hfVendorCodeCC', 3, jhfVendorCodeCC, MyVendorList, 'vendor', 'VendorName');
			}
			return false;
		}

		function PopulateInvoiceDataFA() {
			if(!IsContentsNullUndefEmptyGu(MyInvoiceData)) {
				document.getElementById('hfReqByIDFAE').value=jiByID.toString();
				document.getElementById('selSalesRepFAE').value=MyInvoiceData[0]['salesp'].toString();
				document.getElementById('selSalesLeadFAE').value=MyInvoiceData[0]['slsgrp'].toString();
				document.getElementById('selShipFmLocationFAE').value=MyInvoiceData[0]['loc'].toString();
				document.getElementById('txtCustNbrFAE').value=MyInvoiceData[0]['custpo'].toString();
				document.getElementById('hfCustCodeFAE').value=MyInvoiceData[0]['cust'].toString();
				document.getElementById('txtCustNameFAE').value=MyInvoiceData[0]['CustName'].toString();
				document.getElementById('txtSONbrFAE').value=MyInvoiceData[0]['OrdNbr'].toString();
				document.getElementById('txtInvoiceNbrFAE').value=MyInvoiceData[0]['InvoiceNbr'].toString();
				document.getElementById('txtOrigInvoiceAmtFA').value=getNbrStringFormattedTx(parseFloat(MyInvoiceData[0]['totalamnt']), 2, ',', '.', 2);
				document.getElementById('txtAdjInvoiceAmtFA').value=getNbrStringFormattedTx(parseFloat(MyInvoiceData[0]['totalamnt']), 2, ',', '.', 2);
				document.getElementById('txtAdjustmentAmtFA').value='0'; 
				SetTextBoxAutoComplete2Wc('hfCustCodeFAE', 3, jhfCustCodeFAE, MyCustomerData, 'cust', 'CustName');
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
				//alert(MyInvoiceData[0]['cust'].toString());
				jtCustNameE.value = MyInvoiceData[0]['CustName'].toString();
				//alert('C - ' + MyInvoiceData[0]['CustName'].toString());
				jiOrderNbr = parseInt(MyInvoiceData[0]['OrdNbr'], 10);
				jtSONbrE.value = jiOrderNbr.toString();
				//alert('D - ' + jiOrderNbr.toString());
				jtInvoiceNbrE.value = jiInvoiceID.toString();
				//alert('E = ' + jiInvoiceID.toString());
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

		function PopulateInvoiceDataLAD() {
			if(!IsContentsNullUndefEmptyGu(MyInvoiceData)) {
				document.getElementById('txtCustomerLAndD').value=MyInvoiceData[0]['CustName'].toString();
				document.getElementById('hfCustCodeLAD').value=MyInvoiceData[0]['cust'].toString();
				document.getElementById('selNbrTypeLAndD').value='ordnum';
				document.getElementById('txtControlNbrLAndD').value=MyInvoiceData[0]['OrdNbr'].toString();
				document.getElementById('txtCustNbrLAD').value = MyInvoiceData[0]['custpo'].toString();
				PopulateInvoiceLinesLAD();
			}
			return false;
		}

		function PopulateInvoiceDataMA() {
			if(!IsContentsNullUndefEmptyGu(MyInvoiceData)) {
				document.getElementById('hfInvRequestIDMA').value=MyInvoiceData[0]['0'].toString();
				PopulateMACAdjustLines();
			}
			return false;
		}

		function PopulateInvoiceDataMC() {
			if(!IsContentsNullUndefEmptyGu(MyInvoiceData)) {
				//alert(MyInvoiceData[0]['salesp'].toString());
				document.getElementById('selSalesRepMCE').value = MyInvoiceData[0]['salesp'].toString();
				//document.getElementById('selCreditRepMCE').value=MyInvoiceData[0][''].toString();
				document.getElementById('selSalesLeadMCE').value=MyInvoiceData[0]['slsgrp'].toString();
				document.getElementById('selShipFmLocationMCE').value=MyInvoiceData[0]['loc'].toString();
				document.getElementById('txtCustNbrMCE').value=MyInvoiceData[0]['custpo'].toString();
				document.getElementById('hfCustCodeMCE').value=MyInvoiceData[0]['cust'].toString();
				document.getElementById('txtCustNameMCE').value=MyInvoiceData[0]['CustName'].toString();
				document.getElementById('txtSONbrMCE').value=MyInvoiceData[0]['OrdNbr'].toString();
				document.getElementById('txtInvoiceNbrMCE').value=MyInvoiceData[0]['InvoiceNbr'].toString();
				//document.getElementById('selReasonCodeMCE').value=MyInvoiceData[0][''].toString();
				//document.getElementById('txaReasonForAdjMCE').value= MyInvoiceData[0][''].toString();
				document.getElementById('txtManCredOrigInvAmt').value= getNbrStringFormattedTx(parseFloat(MyInvoiceData[0]['totalamt']), 2, ',', '.', 2);
				document.getElementById('txtManCredAdjInvAmt').value=getNbrStringFormattedTx(parseFloat(MyInvoiceData[0]['totalamt']), 2, ',', '.', 2);
				document.getElementById('txtManCredAdjustAmt').value='0'; //MyInvoiceData[0][''].toString();
				document.getElementById('chkMCCustReqCopyE').checked=false;
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

		function PopulateInvoiceDataVC() {
			if(!IsContentsNullUndefEmptyGu(MyInvoiceData)) {
				document.getElementById('selSalesRepVCE').value=MyInvoiceData[0]['salesp'].toString();
				document.getElementById('selSalesLeadVCE').value=MyInvoiceData[0]['slsgrp'].toString();
				document.getElementById('selShipFmLocationVCE').value=MyInvoiceData[0]['loc'].toString();
				document.getElementById('txtCustNbrVCE').value=MyInvoiceData[0]['custpo'].toString();
				document.getElementById('hfCustCodeVCE').value=MyInvoiceData[0]['cust'].toString();
				document.getElementById('txtCustNameVCE').value=MyInvoiceData[0]['CustName'].toString();
				document.getElementById('txtSONbrVCE').value=MyInvoiceData[0]['OrdNbr'].toString();
				document.getElementById('txtInvoiceNbrVCE').value=MyInvoiceData[0]['InvoiceNbr'].toString();
				document.getElementById('txtOrigInvoiceAmtVC').value=MyInvoiceData[0]['totalamt'].toString();
				document.getElementById('txtAdjInvoiceAmtVC').value=MyInvoiceData[0]['totalamt'].toString();
				document.getElementById('txtAdjustmentAmtVC').value='0';
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
			var subdoctype = '';
			var tbox;
			//alert('initiating lines');
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
					tbox = document.getElementById('txtProdType' + row.toString());
					tbox.value = MyInvoiceItems[row - 1]['ProdType'].toString();
					if(jbCanEdit===true) {
						tbox.readOnly = false;
					}
					else {
						tbox.readOnly = true;
					}
					//if (row === 7) { alert('2'); }
					document.getElementById('hfIAitemID' + row.toString()).value = MyInvoiceItems[row - 1]['InvReqItemID'].toString();
					document.getElementById('hfIAitemNbr' + row.toString()).value = MyInvoiceItems[row - 1]['ItemNbr'].toString();
					tbox = document.getElementById('txtProdCode' + row.toString());
					tbox.value = MyInvoiceItems[row - 1]['ProdCode'].toString();
					if(jbCanEdit===true) {
						tbox.readOnly = false;
					}
					else {
						tbox.readOnly = true;
					}
					//if (row === 7) { alert('3'); }
					tbox = document.getElementById('txtProdDesc' + row.toString());
					tbox.value = MyInvoiceItems[row - 1]['ProdDesc'].toString();
					if(jbCanEdit===true) {
						tbox.readOnly = false;
					}
					else {
						tbox.readOnly = true;
					}
					//if (row === 7) { alert('4'); }
					document.getElementById('hfIAitemID' + row.toString()).value = '0';
					//if (row === 7) { alert('5'); }
					tbox = document.getElementById('txtLineStatus' + row.toString());
					tbox.value = MyInvoiceItems[row - 1]['LineStatus'].toString();
					if(jbCanEdit===true) {
						tbox.readOnly = false;
					}
					else {
						tbox.readOnly = true;
					}
					//if (row === 7) { alert('6'); }
					qtyORIG = parseFloat(MyInvoiceItems[row - 1]['OriginalQty']);
					//if (row === 7) { alert('7'); }
					tbox = document.getElementById('txtOrigQty' + row.toString());
					tbox.value = getNbrStringFormattedTx(qtyORIG, 3, ',', '.', '', 2);
					if(jbCanEdit===true) {
						tbox.readOnly = false;
					}
					else {
						tbox.readOnly = true;
					}
					//if (row === 7) { alert('8'); }
					qty = parseFloat(MyInvoiceItems[row - 1]['RevisedQty']);
					//if (row === 7) { alert('9'); }
					tbox = document.getElementById('txtRevQty' + row.toString());
					tbox.value = getNbrStringFormattedTx(qty, 3, ',', '.', '', 2);
					if(jbCanEdit===true) {
						tbox.readOnly = false;
					}
					else {
						tbox.readOnly = true;
					}
					//if (row === 7) { alert('10'); }
					priceORIG = parseFloat(MyInvoiceItems[row - 1]['OriginalPrice']);
					//if (row === 7) { alert('11'); }
					tbox = document.getElementById('txtOrigPrice' + row.toString());
					tbox.value = getNbrStringFormattedTx(priceORIG, 2, ',', '.', '$', 2);
					if(jbCanEdit===true) {
						tbox.readOnly = false;
					}
					else {
						tbox.readOnly = true;
					}
					//if (row === 7) { alert('12'); }
					price = parseFloat(MyInvoiceItems[row - 1]['RevisedPrice']);
					//if (row === 7) { alert('13'); }
					tbox = document.getElementById('txtRevPrice' + row.toString());
					tbox.value = getNbrStringFormattedTx(price, 2, ',', '.', '$', 2);
					if(jbCanEdit===true) {
						tbox.readOnly = false;
					}
					else {
						tbox.readOnly = true;
					}
					//if (row === 7) { alert('14'); }
					//alert('calculating for line ' + row.toString());
					lntotal = qty * price;
					//alert('calculating 2');
					lntotalORIG = qtyORIG * priceORIG;
					//alert('calculating 3');
					tbox = document.getElementById('txtTotalAmountO' + row.toString());
					tbox.value = getNbrStringFormattedTx(lntotal, 2, ',', '.', '$', 2);
					tbox = document.getElementById('txtTotalAmountA' + row.toString());
					tbox.value = getNbrStringFormattedTx(lntotal, 2, ',', '.', '$', 2);
					//alert('calculating 4');
					grandTotalNEW = grandTotalNEW + lntotal;
					//alert('calculating 5');
					grandTotalORIG = grandTotalORIG + lntotalORIG;
					//alert('calculating done');
				}
				tbox = document.getElementById('txtAdjInvoiceAmt');
				tbox.value = getNbrStringFormattedTx(grandTotalNEW, 2, ',', '.', '$', 2);
					if(jbCanEdit===true) {
						tbox.readOnly = false;
					}
					else {
						tbox.readOnly = true;
					}
			}
			else {
				document.getElementById('txtAdjInvoiceAmt').value = '0';
			}
			tbox = document.getElementById('');

			return false;
		}

		function PopulateInvoiceLinesLAD() {
			if(!IsContentsNullUndefEmptyGu(MyInvoiceItems)) {
				var bdy=document.createElement("tbody");
				var col;
				var pt='';
				var sRow = '';
				var srw = '';
				var val = '';
				jiNbrLinesLAD=MyInvoiceItems.length;
				for(var rw=1; rw<=jiNbrLinesLAD; rw++) {
					row = document.createElement("tr");
					srw = rw.toString();
					sRow = srw;
					if(sRow.length < 2) { sRow = '0' + sRow; }
					row.id = 'trLossDamage' + sRow;
					col = CreateTableColumn('tdLossDamage1_' + srw, 'StdTableCell', 80, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val=FormHDDropDown(MyInvoiceItems[rw-1]['ProdType'].toString(), 'selProdTypeLAD', sRow); //form drop down list
					val = val + '<input type="text" id="txtProdCodeLAD' + sRow + '" style="width:80px;" value="' + MyInvoiceItems[rw-1]['ProdCode'].toString() + '"';
					if(jbCanEdit===false) {
						val = val + ' readonly="readonly"'; // disabled="disabled"';
					}
					val = val + '/>';
					val = val + '<input type="hidden" id="hfLineIDLAD' + srw + '" value="' + MyInvoiceItems[rw-1]['LineID'].toString() + '" /><input type="hidden" id="hfItemNbrLAD' + srw + '" value="' + MyInvoiceItems[rw-1]['ItemNbr'].toString() + '" />';
					val = val + '<input type="hidden" id="hfLADItemAttribs' + srw + '" value="' + MyInvoiceItems[rw-1]['sAttributes'].toString() + '" /><input type="hidden" id="hfLADProdDesc' + srw + '" value="' + MyInvoiceItems[rw-1]['ProdDesc'].toString() + '" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdLossDamage2_' + srw, 'StdTableCell', 90, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtAmountLAD' + sRow + '" style="width:90px;border:none;text-align:right;"';
					if(jbCanEdit===false) {
						val = val + ' readonly="readonly"';
					}
					else {
						val = val + ' onchange="javascript:ChangeTotalClaimAmt();return false;"';
					}
					val = val + ' value="' + getNbrStringFormattedTx(parseFloat(MyInvoiceItems[rw-1]['RevisedQty']), 2, ',', '.', 2) + '" />';
					val = val + '<input type="hidden" id="hfOrigAmtLAD' + srw + '" value="' + MyInvoiceItems[rw-1]['OriginalQty'].toString() + '" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdLossDamage3_' + srw, 'StdTableCell', 320, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtLineCommmentsLAD' + sRow + '" style="width:320px;border:none;" value="' + MyInvoiceItems[rw-1]['Explanation'].toString() + '" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdLossDamage4_' + srw, 'StdTableCell', 160, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<button id="btnSaveLADItem' + srw + '" class="button blue-gradient glossy" onclick="javascript:SaveLADItem(' + srw + ');return false;"';
					if(jbCanEdit===false) {
						val = val + ' disabled="disabled"';
					}
					val = val + '>Save</button>';
					val = val + '<button id="btnRemoveLADItem' + srw + '" class="button blue-gradient glossy" onclick="javascript:RemoveLADItem(' + srw + ');return false;"';
					if(jbCanEdit===false) {
						val = val + ' disabled="disabled"';
					}
					val = val + '>Remove</button>';
					val = val + '<button id="btnEditAtributesLAD' + srw + '" class="button blue-gradient glossy" onclick="javascript:EditAttributesLAD(' + srw + ');return false;">Attribs</button>';
					col.innerHTML = val;
					row.appendChild(col);
					bdy.appendChild(row);
					// load new selProdTypeLAD + sRow select list
				}
				try {
					var oldBody = jtblLADProducts.getElementsByTagName("tbody")[0];
					jtblLADProducts.replaceChild(bdy, oldBody);
				}
				catch(ex) {
					// nothing
				}
			}
			return false;
		}

		function PopulateInvoiceLinesRM() {
			var lnbr = 0;
			var qty = 0;
			var qtycheckedin = 0;
			var pkg = 0;
			var tbox;
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
						tbox = document.getElementById('txtTKProdType' + lnbr.toString());
						tbox.value = MyInvoiceItems[row - 1]['ProdType'].toString();
						if(jbCanEdit===false) {
							tbox.readOnly = true;
						}
						else {
							tbox.readOnly = false;
						}
						//alert('2');
						tbox = document.getElementById('txtTKProdCode' + lnbr.toString());
						tbox.value = MyInvoiceItems[row - 1]['ProdCode'].toString();
						if(jbCanEdit===false) {
							tbox.readOnly = true;
						}
						else {
							tbox.readOnly = false;
						}
						document.getElementById('hfRMitemID' + lnbr.toString()).value = MyInvoiceItems[row - 1]['LineID'].toString();
						document.getElementById('hfRMitemNbr' + row.toString()).value = MyInvoiceItems[row - 1]['ItemNbr'].toString();
						//alert('3');
						tbox = document.getElementById('txtTKTicketNbr' + lnbr.toString());
						tbox.value = MyInvoiceItems[row - 1]['TicketNbrs'].toString();
						if(jbCanEdit===false) {
							tbox.readOnly = true;
						}
						else {
							tbox.readOnly = false;
						}
						document.getElementById('hfRMitemID' + lnbr.toString()).value = '0';
						//alert('4');
						tbox = document.getElementById('txtTKStatus' + lnbr.toString());
						tbox.value = MyInvoiceItems[row - 1]['LineStatus'].toString();
						if(jbCanEdit===false) {
							tbox.readOnly = true;
						}
						else {
							tbox.readOnly = false;
						}
						qty = parseFloat(MyInvoiceItems[row - 1]['RtnQty']);
						tbox = document.getElementById('txtTKQty' + lnbr.toString());
						tbox.value = getNbrStringFormattedTx(qty, 2, ',', '.', '', 2);
						if(jbCanEdit===false) {
							tbox.readOnly = true;
						}
						else {
							tbox.readOnly = false;
						}
						qty = parseFloat(MyInvoiceItems[row - 1]['OriginalQty']);
						document.getElementById('hfTKOrigQty' + lnbr.toString()).value = getNbrStringFormattedTx(qty, 2, ',', '.', '', 2);
						//alert('5');
						pkg = parseFloat(MyInvoiceItems[row - 1]['RtnPkgCount']);
						tbox = document.getElementById('txtTKTotalPkgCount' + lnbr.toString());
						tbox.value = getNbrStringFormattedTx(pkg, 2, ',', '.', '', 2);
						if(jbCanEdit===false) {
							tbox.readOnly = true;
						}
						else {
							tbox.readOnly = false;
						}
						qtycheckedin = parseFloat(MyInvoiceItems[row - 1]['RtnQtyCheckedIn']);
						//alert('6');
						tbox = document.getElementById('txtTKQtyCheckedIn' + lnbr.toString());
						tbox.value = getNbrStringFormattedTx(qtycheckedin, 2, ',', '.', '$', 2);
						if(jbCanEdit===false) {
							tbox.readOnly = true;
						}
						else {
							tbox.readOnly = false;
						}
						if(MyInvoiceItems[row - 1]['sRedTag'].toString() === 'Yes') {
							document.getElementById('chkTKRedTag' + lnbr.toString()).checked = true;
						}
						else {
							document.getElementById('chkTKRedTag' + lnbr.toString()).checked = false;
						}
						if(jbCanEdit===false) {
							document.getElementById('chkTKRedTag' + lnbr.toString()).disabled = true;
						}
						else {
							document.getElementById('chkTKRedTag' + lnbr.toString()).disabled = false;
						}
						if(MyInvoiceItems[row - 1]['sInvAdj'].toString() === 'Yes') {
							document.getElementById('chkTKInvAdj' + lnbr.toString()).checked = true;
						}
						else {
							document.getElementById('chkTKInvAdj' + lnbr.toString()).checked = false;
						}
						if(jbCanEdit===false) {
							document.getElementById('chkTKInvAdj' + lnbr.toString()).disabled = true;
						}
						else {
							document.getElementById('chkTKInvAdj' + lnbr.toString()).disabled = false;
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

		function PopulateLocationListByRegion() {
			if(jbLoadedLocationList2 === false || IsContentsNullUndefEmptyGu(MyLocationList2)) {
				GetLocationLists2(jsRegionCode, '', '', '', '', 2, 0, 1);
				jbLoadedLocationList2 = true;
			}
			if(!IsContentsNullUndefEmptyGu(MyLocationList2)) {
				ClearDDLOptionsGu('selMillLocationCC', 1);
				var ml = document.getElementById('selMillLocationCC');
				fillDropDownListGu(MyLocationList2, ml, 0, 'Name', 'loc');
			}
			return false;
		}

		function PopulateLocationListCC() {
			if(jbLoadedLocationList2 === false || IsContentsNullUndefEmptyGu(MyLocationList2)) {
				GetLocationList2('', '', '', '', '', 2, 0, 1);
				jbLoadedLocationList2 = true;
			}
			if(!IsContentsNullUndefEmptyGu(MyLocationList2)) {
				ClearDDLOptionsGu('selMillLocationCC', 1);
				var ml = document.getElementById('selMillLocationCC');
				fillDropDownListGu(MyLocationList2, ml, 0, 'LocationName', 'locationCode');
			}
			return false;
		}

		function PopulateLocationListFA() {
			if(jbLoadedLocationList === false || IsContentsNullUndefEmptyGu(MyLocationList)) {
				GetLocationLists('', '', '', '', 0, 0, 1);
				jbLoadedLocationList = true;
			}
			if(!IsContentsNullUndefEmptyGu(MyLocationList)) {
				ClearDDLOptionsGu('selShipFmLocationFAE', 1);
				var sel = document.getElementById('selShipFmLocationFAE');
				fillDropDownListGu(MyLocationList, sel, 0, 'Name', 'loc');
			}
			return false;
		}

		function PopulateLocationListsIC() {
			if(jbLoadedLocationList === false || IsContentsNullUndefEmptyGu(MyLocationList)) {
				GetLocationLists('', '', '', '', 0, 0, 1);
				jbLoadedLocationList = true;
			}
			if(!IsContentsNullUndefEmptyGu(MyLocationList)) {
				ClearDDLOptionsGu('selLocationIAdjE', 1);
				var sel = document.getElementById('selLocationIAdjE');
				fillDropDownListGu(MyLocationList, sel, 0, 'Name', 'loc');
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
					var sel = document.getElementById('selLocationMACA' + row.toString());
					fillDropDownListGu(MyLocationList, sel, 0, 'Name', 'loc');
				}
			}
			return false;
		}

		function PopulateLocationListsMC() {
			if(jbLoadedLocationList === false || IsContentsNullUndefEmptyGu(MyLocationList)) {
				GetLocationLists('', '', '', '', 0, 0, 1);
				jbLoadedLocationList = true;
			}
			if(!IsContentsNullUndefEmptyGu(MyLocationList)) {
				ClearDDLOptionsGu('selShipFmLocationMCE', 1);
				jsLocationMC = document.getElementById('selShipFmLocationMCE');
				fillDropDownListGu(MyLocationList, jsLocationMC, 0, 'Name', 'loc');
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

		function PopulateLocationListsVC() {
			if(jbLoadedLocationList === false || IsContentsNullUndefEmptyGu(MyLocationList)) {
				GetLocationLists('', '', '', '', 0, 0, 1);
				jbLoadedLocationList = true;
			}
			if(!IsContentsNullUndefEmptyGu(MyLocationList)) {
				ClearDDLOptionsGu('selShipFmLocationVCE', 1);
				var selLocation = document.getElementById('selShipFmLocationVCE');
				fillDropDownListGu(MyLocationList, selLocation, 0, 'Name', 'loc');
			}
			return false;
		}

		function PopulateLossDmgCodes() {
			if(jbLoadedLossDmgCodes === false) { GetLossDmgCodeList(0, 1); }
			if(!IsContentsNullUndefEmptyGu(MyLossDmgCodeList)) {
				for(var row = 1; row <= jiNbrLinesMAC; row++) {
					ClearDDLOptionsGu('selLossDmgClass' + row.toString(), 1);
					jselLocationMAC = document.getElementById('selLocationMACA' + row.toString());
					fillDropDownListGu(MyLossDmgCodeList, jselLossDmgClass, 0, 'ItemDescription', 'ItemCode');
				}
			}
			return false;
		}

		function PopulateLossDamageLines() {
			var obj;
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
					obj = document.getElementById('selProdTypeLAD' + sRow.toString());
					obj.value = MyInvoiceItems[row-1]['ProdType'].toString();
					if(jbCanEdit===true) {
						obj.readOnly = false;
					}
					else {
						obj.readOnly = true;
					}
					obj = document.getElementById('txtProdCodeLAD' + sRow.toString());
					obj.value = MyInvoiceItems[row - 1]['ProdCode'].toString();
					if(jbCanEdit===true) {
						obj.readOnly = false;
					}
					else {
						obj.readOnly = true;
					}
					obj = document.getElementById('txtAmountLAD' + sRow.toString());
					obj.value = MyInvoiceItems[row - 1]['OriginalQty'].toString();
					if(jbCanEdit===true) {
						obj.readOnly = false;
					}
					else {
						obj.readOnly = true;
					}
					obj = document.getElementById('txtLineCommentsLAD' + sRow.toString()); 
					obj.value = MyInvoiceItems[row - 1]['Comments'].toString();
					if(jbCanEdit===true) {
						obj.readOnly = false;
					}
					else {
						obj.readOnly = true;
					}
					document.getElementById('hfItemNbrLAD' + row.toString()).value = MyInvoiceItems[row - 1]['ItemNbr'].toString();
					document.getElementById('hfLineIDLAD' + row.toString()).value = MyInvoiceItems[row - 1]['InvReqItemID'].toString();
				}
			}
			return false;
		}

		function PopulateMACAdjustLines() {
			var bdy = document.createdElement("tbody");
			var cellClass = 'StdTableCell';
			var col;
			var ptc = '';
			var ptc2 = '';
			var row;
			var sRow = '';
			var srw = '';
			var tblname = 'tblMACAdjustment';
			var val = '';
			if(jiInvoiceID > 0) {
				GetInvoiceItems('MACADJ');
				if(!IsContentsNullUndefinedGu(MyInvoiceItems)) {
					jiNbrLinesMAC = MyInvoiceItems.length;
					for(var rw = 1; rw <= jiNbrLinesMAC; rw++) {
						row = document.createElement("tr");
						srw = rw.toString();
						sRow = srw;
						if(sRow.length < 2) { sRow = '0' + sRow; }
						row.id = 'trMACAdjustment' + sRow;
						ptc = MyInvoiceItems[rw]['ProdType'].toString();
						col = CreateTableColumn('tdMACAdjust1_' + srw, cellClass, 60, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
						val = '<select id="selProdTypeMACA' + srw + '"';
						if (jbCanEdit === false) { val = val + ' disabled="disabled"'; }
						val = val + '><option value="0"';
						if(ptc = '0') { val = val + ' selected="selected"'; }
						val = val + '>Not Selected</option>';
						if(!IsContentsNullUndefEmptyGu(MyProdTypeList)) {
							for(var itm = 0; itm < MyProdTypeList.length; itm++) {
								ptc2 = MyProdTypeList[itm]['ProductTypeCode'].toString();
								val = val + '<option value="' + ptc2 + '"';
								if(ptc2 === ptc) { val = val + ' selected="selected"';}
								val = val + '>' + MyProdTypeList[itm]['ProductType'].toString() + '</option >';
							}
						}
						val = val + '</select>';
						val = val + '<input type="hidden" id="hfLineIDMACAE' + srw + '" value="' + MyInvoiceItems[rw]['LineID'].toString() + '" />';
						val = val + '<input type="hidden" id="hfItemNbrMACAE' + srw + '" value="' + MyInvoiceItems[rw]['ItemNbr'].toString() + '" />';
						val = val + '<input type="hidden" id="hfMACItemAttribs' + srw + '" value="' + MyInvoiceItems[rw]['sAttributes'].toString() + '" />';
						col.innerHTML = val;
						row.appendChild(col);
						col = CreateTableColumn('tdMACAdjust2_' + srw, cellClass, 80, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
						val = '<input type="text" id="txtProdCodeMACA' + srw + '" style="width:80px;" value="' + MyInvoiceItems[rw]['ProdCode'].toString() + '"';
						if (jbCanEdit === false) {val = val + ' readonly="readonly"';}
						val = val + '/>';
						col.innerHTML = val;
						row.appendChild(col);
						col = CreateTableColumn('tdMACAdjust3_' + srw, cellClass, 140, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
						val = '<input type="text" id="txtProdDescMACA' + srw + '" style="width:140px;" value="' + MyInvoiceItems[rw]['ProdDesc'].toString() + '"';
						if (jbCanEdit === false) {val = val + ' readonly="readonly';}
						val = val + '/>';
						col.innerHTML = val;
						row.appendChild(col);
						col = CreateTableColumn('tdMACAdjust4_' + srw, cellClass, 60, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
						val = '<select id="selLocationMACA' + srw + '"';
						if (jbCanEdit === false) {val = val + ' disabled="disabled"';}
						val = val + '><option value="0"';
						ptc = MyInvoiceItems[rw]['LocCode'].toString();
						if(ptc === '0') { val = val + ' selected="selected"';}
						val = val + '> Not Selected</option >';
						if(!IsContentsNullUndefEmptyGu(MyLocationList)) {
							for(var itm2 = 0; itm2 < MyLocationList.length; itm2++) {
								ptc2 = MyLocationList[itm2]['loc'].toString();
								val = val + '<option value="' + ptc2 + '"';
								if(ptc2 === ptc) { val = val + ' selected="selected"';}
								val = val + '>' + MyLocationList[itm2]['Name'].toString() + '</option >';
							}
						}
						val = val + '</select > ';
						col.innerHTML = val;
						row.appendChild(col);
						col = CreateTableColumn('tdMACAdjust5_' + srw, cellClass, 100, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
						val = '<input type="text" id="txtCostIDMACA' + srw + '" style="width:100px;" value="' + MyInvoiceItems[rw]['costid'].toString() + '"';
						if(jbCanEdit===false) {
							val = val + ' readonly="readonly"';
						}
						val = val + '/>';
						col.innerHTML = val;
						row.appendChild(col);
						col = CreateTableColumn('tdMACAdjust6_' + srw, cellClass, 100, 0, 'right', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
						val = '<input type="text" id="txtCurrentMACA' + srw + '" style="width:100px;" value="' + getNbrStringFormattedTx(parseFloat(MyInvoiceItems[rw]['OriginalQty']), 2, ',', '.', 2) + '"';
						if(jbCanEdit===false) {
							val = val + ' readonly="readonly"';
						}
						val = val + '/>';
						col.innerHTML = val;
						row.appendChild(col);
						col = CreateTableColumn('tdMACAdjust7_' + srw, cellClass, 100, 0, 'right', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
						val = '<input type="text" id="txtCorrectMACA' + srw + '" style="width:100px;" value="' + getNbrStringFormattedTx(parseFloat(MyInvoiceItems[rw]['RevisedQty']), 2, ',', '.', 2) + '"';
						if(jbCanEdit===false) {
							val = val + ' readonly="readonly"';
						}
						val = val + '/>';
						col.innerHTML = val;
						row.appendChild(col);
						col = CreateTableColumn('tdMACAdjust8_' + srw, cellClass, 90, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
						val = '<input type="text" id="txtMACCostID' + srw + '" style="width:90px;" value="' + MyInvoiceItems[rw]['costid'].toString() + '"';
						if(jbCanEdit===false) {
							val = val + ' readonly="readonly"';
						}
						val = val + '/>';
						col.innerHTML = val;
						row.appendChild(col);
						col = CreateTableColumn('tdMACAdjust9_' + srw, cellClass, 90, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
						val = '<input type="text" id="txtMACReason' + srw + '" style="width:90px;" value="' + MyInvoiceItems[rw]['costid'].toString() + '"';
						if(jbCanEdit===false) {
							val = val + ' readonly="readonly"';
						}
						val = val + '/>';
						col.innerHTML = val;
						row.appendChild(col);
						col = CreateTableColumn('tdMACAdjust10_' + srw, cellClass, 160, 0, 'center', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
						val = '<button id="btnRemoveMACItem' + srw + '" class="button blue-gradient glossy" ';
						if(jbCanEdit===false) {
							val = val + ' disabled="disabled"';
						}
						if(rw === 1) {
							val = val + ' style="display:none;"';
						}
						else {
							val = val + ' onclick="javascript:RemoveMACItem(' + srw + ');return false;"';
						}
						val = val + '>Remove</button>';
						val = val + '<button id="btnEditAttribsMAC' + srw + '" class="button blue-gradient glossy" onclick="javascript:EditAttributesMAC(' + srw + ');return false;">Attribs</button>';
						col.innerHTML = val;
						row.appendChild(col);
						bdy.appendChild(row);
						//InsertRowIntoTableGu(tblname, rw - 1, row);
					}
					try {
						var oldBody = jtblMACAdjustment.getElementsByTagName("tbody")[0];
						jtblMACAdjustment.replaceChild(bdy, oldBody);
					}
					catch(ex) {
						alert('Error while creating MAC Adjustment lines: ' + ex.message);
					}
					//joPgNbrLblPj.innerHTML = (jiPgNbrPj[0] + 1).toString();
					//joMaxPgNbrLblPj.innerHTML = jiNbrPagesPj[0].toString();
				}
			}
			else {
				// nothing
			}
			return false;
		}

		function PopulateProdTypeListsIC() {
			//alert('loading');
			if(jbLoadedProdTypeList === false || IsContentsNullUndefinedGu(MyProdTypeList)) {
				GetProdTypeLists('', 0, 1);
				jbLoadedProdTypeList = true;
			}
			//alert('adding');
			if(!IsContentsNullUndefEmptyGu(MyProdTypeList)) {
				ClearDDLOptionsGu('selProdTypeIAdjE', 1);
				var sel = document.getElementById('selProdTypeIAdjE');
				fillDropDownListGu(MyProdTypeList, sel, 0, 'ProductTypeCode', 'ProductTypeCode');
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

		function PopulateReasonListFA() {
			if(jbLoadedReasonList === false || IsContentsNullUndefEmptyGu(MyReasonList)) {
				GetReasonList(0, 1);
				jbLoadedReasonList = true;
			}
			//alert(MyReasonList.length);
			if(!IsContentsNullUndefEmptyGu(MyReasonList)) {
				ClearDDLOptionsGu('selReasonCodeFAE', 1);
				var sReasonCodes = document.getElementById('selReasonCodeFAE');
				fillDropDownListGu(MyReasonList, sReasonCodes, 0, 'ItemDescription', 'ItemCode');
			}
			return false;
		}

		function PopulateReasonListMC() {
			if(jbLoadedReasonList === false || IsContentsNullUndefEmptyGu(MyReasonList)) {
				GetReasonList(0, 1);
				jbLoadedReasonList = true;
			}
			//alert(MyReasonList.length);
			if(!IsContentsNullUndefEmptyGu(MyReasonList)) {
				ClearDDLOptionsGu('selReasonCodeMCE', 1);
				var sReasonCodes = document.getElementById('selReasonCodeMCE');
				fillDropDownListGu(MyReasonList, sReasonCodes, 0, 'ItemDescription', 'ItemCode');
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

		function PopulateReasonListVC() {
			if(jbLoadedReasonList === false || IsContentsNullUndefEmptyGu(MyReasonList)) {
				GetReasonList(0, 1);
				jbLoadedReasonList = true;
			}
			//alert(MyReasonList.length);
			if(!IsContentsNullUndefEmptyGu(MyReasonList)) {
				ClearDDLOptionsGu('selReasonCodeVCE', 1);
				var rc = document.getElementById('selReasonCodeVCE');
				fillDropDownListGu(MyReasonList, rc, 0, 'ItemDescription', 'ItemCode');
			}
			return false;
		}

		function PopulateRequest() {
			if(!IsContentsNullUndefEmptyGu(MyRequestData)) {
				jhfInvoiceDate.value = MyRequestData[0]['sInvoiceDate'].toString();
				PopulateDocStatusFlow();
				// fill header line data
				jlRequestIDE.innerHTML = jiRequestID.toString();
				jsStatusCode = MyRequestData[0]['StatusCode'].toString();
				jselSetNewStatus.value = jsStatusCode;
				FillDocumentStatus(jsStatusCode);
				jtDateReqE.value = MyRequestData[0]['sDateRequested'].toString();
				jtReqByE.value = MyRequestData[0]['sFullName2'].toString();
				jhfReqByIDE.value = MyRequestData[0]['RequestedByID'].toString();
				if(MyRequestData[0]['sCriticalLevel'].toString() === 'Yes') {
					jchkCriticalImportance.checked = true;
				}
				else {
					jchkCriticalImportance.checked = false;
				}
				jtEmailsToInclude.value = MyRequestData[0]['ExtraEmailTo'].toString();
				jtaGenCommentIAE.value = UncodeSingleQuotesTx(MyRequestData[0]['Comment'].toString());
				// load data for all doc type portions
				jiNbrDocs = 0;
				GetRequestDocTypeList(); // loads MyRequestDocsData
				for(var row = 0; row < MyRequestDocsData.length; row++) {
					jiDocumentType = parseInt(MyRequestDocsData[row]['DocDisplayTypeID'], 10);
					jsaDocType[jiNbrDocs] = MyRequestDocsData[row]['DocTypeCode'].toString();
					jiDocumentType = parseInt(MyRequestDocsData[row]['DocDisplayTypeID'], 10); 
					jiaDocTypeID[jiNbrDocs] = jiDocumentType;
					jiNbrDocs++;
					jiInvoiceReqID = parseInt(MyRequestDocsData[row]['InvoiceRequestID'].toString());
					jiaInvoiceReqID[row] = jiInvoiceReqID;
					GetInvoiceRequestData();
					switch(jiDocumentType) {
						//case 1:	//InvAdj-Rtn Manifest
						//	LoadInvAdjustmentData();
						//	LoadReturnManifestData();
						//	break;
						case 2:	//InvAdjustment Only
							PopulateRequestDataIA();
							break;
						case 3:	//Return Manifest
							PopulateRequestDataRM();
							break;
						case 4:	//Freight Accrual
							PopulateRequestDataFA();
							break;
						case 5:	//Vendor Claim
							PopulateRequestDataVC();
							break;
						case 6:	//Loss & Damage Claim
							PopulateRequestDataLAD();
							break;
						case 7:	//Inventory Adjustment
							PopulateInventoryChgItems();
							break;
						case 8:	//MAC Adjustment
							PopulateRequestDataMA();
							break;
						case 9:	//Manual Credit
							PopulateRequestDataMC();
							break;
						case 10: //Cust Claim
							PopulateRequestDataCC();
							break;
						default:
							break;
					}
				}
				LoadDocTypesList();
			}
			return false;
		}

		function PopulateRequestDataCC() {
			if(!IsContentsNullUndefEmptyGu(MyInvRequestData)) {
				jsRegionCode = MyInvRequestData[0]['OtherValue1'].toString();
				document.getElementById('selRegionCC').value = jsRegionCode;
				PopulateLocationListByRegion();
				PopulateThicknessListByRegion();
				PopulateGradeListByRegion();
				PopulateSpeciesListByRegion();
				document.getElementById('txtSubmittedByCC').value = MyInvRequestData[0]['sFullName2'].toString();
				document.getElementById('hfCustCodeCC').value = MyInvRequestData[0]['CustCode'].toString();
				document.getElementById('txtCustNameCC').value = MyInvRequestData[0]['CustomerName'].toString();
				document.getElementById('txtOrderNbrCC').value = MyInvRequestData[0]['SalesOrderNbr'].toString();
				document.getElementById('txtSubmmittedOnCC').value = MyInvRequestData[0]['sReqDate'].toString();
				document.getElementById('txtInvoiceNbrCC').value = MyInvRequestData[0]['InvoiceNbr'].toString();
				document.getElementById('txtShipmentNbrCC').value = MyInvRequestData[0]['ShipmentNbr'].toString();
				document.getElementById('selMillLocationCC').value = MyInvRequestData[0]['ShipFmLocCode'].toString();
				document.getElementById('selSalesLeadCC').value = MyInvRequestData[0]['SalesLeadCode'].toString();
				document.getElementById('hfVendorCodeCC').value = MyInvRequestData[0]['VendorCode'].toString();
				document.getElementById('txtVendorNameCC').value = MyInvRequestData[0]['VendorName'].toString();
				document.getElementById('selGradeCC').value = MyInvRequestData[0]['ProdValue1'].toString();
				document.getElementById('selThicknessCC').value = MyInvRequestData[0]['ProdValue2'].toString();
				document.getElementById('selSpecieCC').value = MyInvRequestData[0]['ProdValue3'].toString();
				document.getElementById('selReasonCodeCC').value = MyInvRequestData[0]['ReasonCode'].toString();
				document.getElementById('txaMiscInfoCC').value = PrepareHTMLForViewTx(MyInvRequestData[0]['ReasonForAdj'].toString());
				document.getElementById('txaCustClaimDesc').value = PrepareHTMLForViewTx(MyInvRequestData[0]['CommentItem1'].toString(), 1);
				document.getElementById('txaCustClaimInvestigation').value = PrepareHTMLForViewTx(MyInvRequestData[0]['CommentItem2'].toString(), 1);
				document.getElementById('txaCustClaimResolution').value = PrepareHTMLForViewTx(MyInvRequestData[0]['CommentItem3'].toString(), 1);
				document.getElementById('txtResolutionDateCC').value = MyInvRequestData[0]['sActionDate1'].toString();
				document.getElementById('txtResolutionAmtCC').value = getNbrStringFormattedTx(parseFloat(MyInvRequestData[0]['AdmustmentAmt']), 2, ',', '.', 2);
				document.getElementById('hfOrigAmtCC').value = MyInvRequestData[0]['OrigInvAmt'].toString();
				document.getElementById('hfInvRequestIDCC').value = MyInvRequestData[0]['InvoiceRequestID'].toString();
				if(MyInvRequestData[0]['sSetting1'].toString()==='Yes') {
					document.getElementById('radMillErrorY').checked=true;
				}
				else {
					document.getElementById('radMillErrorN').checked=true;
				}
				SetTextBoxAutoComplete2Wc('txtCustNameCC', 3, jhfCustCodeCC, MyCustomerData, 'cust', 'CustName');
				SetTextBoxAutoComplete2Wc('txtVendorNameCC', 3,jhfVendorCodeCC, MyVendorList, 'vendor', 'VendorName');
			}
			return false;
		}

		function PopulateRequestDataFA() {
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
				document.getElementById('hfCustCodeFAE').value = MyInvRequestData[0]['CustCode'].toString();
				SetTextBoxAutoComplete2Wc('txtCustNameFAE', 3, jhfCustCodeFAE, MyCustomerData, 'cust', 'CustName');
			}
			return false;
		}

		function PopulateRequestDataIA() {
			if(!IsContentsNullUndefEmptyGu(MyInvRequestData)) {
				document.getElementById('hfInvAdjIDE').value = MyInvoiceData[0]['InvoiceRequestID'].toString();;
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
				SetTextBoxAutoComplete2Wc('hfCustCodeE', 3, jhfCustCodeE, MyCustomerData, 'cust', 'CustName');

				// load lines
				if(jbLoadedInvoiceItems === false) { GetInvoiceItems(jsDocType); }
				PopulateInvoiceLinesIA();
			}
			return false;
		}

		function PopulateRequestDataLAD() {
			if(!IsContentsNullUndefEmptyGu(MyInvRequestData)) {
				document.getElementById('txtLADTransDate').value=MyInvRequestData[0]['sReqDate'].toString();
				document.getElementById('txtCustomerLAndD').value=MyInvRequestData[0]['CustomerName'].toString();
				document.getElementById('txtControlNbrLAndD').value=MyInvRequestData[0]['CustControlNbr'].toString();
				document.getElementById('hfCustCodeLAD').value=MyInvRequestData[0]['Custcode'].toString();
				document.getElementById('selNbrTypeLAndD').value=MyInvRequestData[0]['OtherNbr1'].toString();
				document.getElementById('selLossDmgClass').value=MyInvRequestData[0]['ReasonCode'].toString();
				document.getElementById('txtCustNbrLAD').value = MyInvRequestData[0]['CustControlNbr'].toString();
				SetTextBoxAutoComplete2Wc('hfCustCodeLAD', 3, jhfCustCodeLAD, MyCustomerData, 'cust', 'CustName');
				PopulateInvoiceLinesLAD();
			}
			return false;
		}

		function PopulateRequestDataMA() {
			if(!IsContentsNullUndefEmptyGu(MyInvRequestData)) {
				PopulateMACAdjustLines();
			}
			return false;
		}

		function PopulateRequestDataMC() {
			PopulateSalesStaffListMC();
			PopulateSalesLeadListsMC();
			PopulateLocationListsMC();
			PopulateReasonListMC();
			PopulateCreditRepListsMC();
			if(!IsContentsNullUndefEmptyGu(MyInvRequestData)) {
				document.getElementById('hfInvAdjIDMCE').value = MyInvRequestData[0][''].toString();
				document.getElementById('txtDateReqMCE').value = MyInvRequestData[0][''].toString();
				document.getElementById('txtReqByMCE').value = MyInvRequestData[0][''].toString();
				document.getElementById('hfReqByIDMCE').value = MyInvRequestData[0][''].toString();
				document.getElementById('selSalesRepMCE').value = MyInvRequestData[0][''].toString();
				document.getElementById('selCreditRepMCE').value = MyInvRequestData[0][''].toString();
				document.getElementById('selSalesLeadeMCE').value = MyInvRequestData[0][''].toString();
				document.getElementById('selShipFmLocationMCE').value = MyInvRequestData[0][''].toString();
				document.getElementById('txtCustNbrMCE').value = MyInvRequestData[0][''].toString();
				document.getElementById('txtCustNameMCE').value = MyInvRequestData[0][''].toString();
				document.getElementById('hfCustCodeMCE').value = MyInvRequestData[0][''].toString();
				document.getElementById('txtSONbrMCE').value = MyInvRequestData[0][''].toString();
				document.getElementById('txtInvoiceNbrMCE').value = MyInvRequestData[0][''].toString();
				document.getElementById('selReasonCodeMCE').value = MyInvRequestData[0][''].toString();
				document.getElementById('txaReasonForAdjMCE').value = MyInvRequestData[0][''].toString();
				document.getElementById('txtManCredOrigInvAmt').value = getNbrStringFormattedTx(parseFloat(MyInvRequestData[0][''].toString()), 2, ',', '.', 2);
				document.getElementById('txtManCredAdjInvAmt').value = getNbrStringFormattedTx(parseFloat(MyInvRequestData[0][''].toString()), 2, ',', '.', 2);
				document.getElementById('txtManCredAdjustment').value = getNbrStringFormattedTx(parseFloat(MyInvRequestData[0][''].toString()), 2, ',', '.', 2);
				if(MyInvRequestData[0]['sCustReqCopy'].toString()==='Yes') {
					document.getElementById('chkMCCustReqCopyE').checked = true;
				}
				else {
					document.getElementById('chkMCCustReqCopyE').checked = false;
				SetTextBoxAutoComplete2Wc('hfCustCodeMCE', 3, jhfCustCodeMCE, MyCustomerData, 'cust', 'CustName');
				}
			}
			return false;
		}

		function PopulateRequestDataRM() {
			if(!IsContentsNullUndefEmptyGu(MyInvRequestData)) {
				document.getElementById('hfRtnManifestIDM').value =	MyInvRequestData[0]['InvoiceRequestID'].toString();
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
				if(!IsComponentShown('INVADJ')) {
					SetTextBoxAutoComplete2Wc('hfCustCodeM', 3, jhfCustCodeM, MyCustomerData, 'cust', 'CustName');
				}
				PopulateInvoiceLinesRM();
			}
			return false;
		}

		function PopulateRequestDataVC() {
			PopulateSalesLeadListsVC();
			PopulateSalesStaffListVC();
			PopulateCreditRepListsVC();
			PopulateLocationListsVC();
			PopulateReasonListVC(); 
			if(!IsContentsNullUndefEmptyGu(MyInvRequestData)) {
				document.getElementById('txtVendorClaimIdentVC').value=MyInvRequestData[0]['VendorName'].toString();
				document.getElementById('txtDateReqVCE').value=MyInvRequestData[0]['sReqDate'].toString();
				document.getElementById('txtReqByVCE').value=MyInvRequestData[0]['sFullName2'].toString();
				document.getElementById('hfReqByIDVCE').value=MyInvRequestData[0]['RequestedByID'].toString();
				document.getElementById('hfVendorCodeVCE').value=MyInvRequestData[0]['VendorCode'].toString();
				document.getElementById('selSalesRepVCE').value=MyInvRequestData[0]['SalesPersonID'].toString();
				document.getElementById('selCreditRepVCE').value=MyInvRequestData[0]['CreditRepID'].toString();
				document.getElementById('selSalesLeadVCE').value=MyInvRequestData[0]['SalesLeadCode'].toString();
				document.getElementById('selShipFmLocationVCE').value=MyInvRequestData[0]['ShipFmLocCode'].toString();
				document.getElementById('txtCustNbrVCE').value=MyInvRequestData[0]['CustControlNbr'].toString();
				document.getElementById('hfCustCodeVCE').value=MyInvRequestData[0]['Custcode'].toString();
				document.getElementById('txtCustNameVCE').value=MyInvRequestData[0]['CustomerName'].toString();
				document.getElementById('txtSONbrVCE').value=MyInvRequestData[0]['SalesOrderNbr'].toString();
				document.getElementById('txtInvoiceNbrVCE').value=MyInvRequestData[0]['InvoiceNbr'].toString();
				document.getElementById('selReasonCodeVCE').value=MyInvRequestData[0]['ReasonCode'].toString();
				document.getElementById('txaReasonForAdjVCE').value=MyInvRequestData[0]['ReasonforAdj'].toString();
				document.getElementById('txtOrigInvoiceAmtVC').value= getNbrStringFormattedTx(parseFloat(MyInvRequestData[0]['OrigInvAmt']), 2, ',', '.', 2);
				document.getElementById('txtAdjInvoiceAmtVC').value=getNbrStringFormattedTx(parseFloat(MyInvRequestData[0]['AdjInvoiceAmt']), 2, ',', '.', 2);
				document.getElementById('txtAdjustmentAmtVC').value=getNbrStringFormattedTx(parseFloat(MyInvRequestData[0]['AdjustmentAmt']), 2, ',', '.', 2);
				document.getElementById('hfInvRequestIDVC').value=MyInvRequestData[0]['InvoiceRequestID'].toString();
				SetTextBoxAutoComplete2Wc('hfCustCodeVCE', 3, jhfCustCodeVCE, MyCustomerData, 'cust', 'CustName');
				SetTextBoxAutoComplete2Wc('txtVendorClaimIdentVC', 3, jhfVendorCodeVCE, MyVendorList, 'vendor', 'VendorName');
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

		function PopulateSalesLeadListsCC() {
			if(jbLoadedSalesLeadList === false || IsContentsNullUndefEmptyGu(MySalesLeadList)) {
				GetSalesGrpList();
				jbLoadedSalesLeadList = true;
			}
			if(!IsContentsNullUndefEmptyGu(MySalesLeadList)) {
				ClearDDLOptionsGu('selSalesLeadCC', 1);
				var jSalesLeadMCE = document.getElementById('selSalesLeadCC');
				fillDropDownListGu(MySalesLeadList, jSalesLeadMCE, 0, 'Grp', 'Code');
			}
			return false;
		}

		function PopulateSalesLeadListsFA() {
			if(jbLoadedSalesLeadList === false || IsContentsNullUndefEmptyGu(MySalesLeadList)) {
				GetSalesGrpList();
				jbLoadedSalesLeadList = true;
			}
			if(!IsContentsNullUndefEmptyGu(MySalesLeadList)) {
				ClearDDLOptionsGu('selSalesLeadFAE', 1);
				var sel = document.getElementById('selSalesLeadFAE');
				fillDropDownListGu(MySalesLeadList, sel, 0, 'Grp', 'Code');
			}
			return false;
		}

		function PopulateSalesLeadListsMC() {
			if(jbLoadedSalesLeadList === false || IsContentsNullUndefEmptyGu(MySalesLeadList)) {
				GetSalesGrpList();
				jbLoadedSalesLeadList = true;
			}
			if(!IsContentsNullUndefEmptyGu(MySalesLeadList)) {
				ClearDDLOptionsGu('selSalesLeadMCE', 1);
				var sel = document.getElementById('selSalesLeadMCE');
				fillDropDownListGu(MySalesLeadList, sel, 0, 'Grp', 'Code');
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

		function PopulateSalesLeadListsVC() {
			if(jbLoadedSalesLeadList === false || IsContentsNullUndefEmptyGu(MySalesLeadList)) {
				GetSalesGrpList();
				jbLoadedSalesLeadList = true;
			}
			if(!IsContentsNullUndefEmptyGu(MySalesLeadList)) {
				ClearDDLOptionsGu('selSalesLeadVCE', 1);
				var SLead = document.getElementById('selSalesLeadVCE');
				fillDropDownListGu(MySalesLeadList, SLead, 0, 'Grp', 'Code');
			}
			return false;
		}

		function PopulateSalesStaffLists() {
			if(jbLoadedSalesStaffList === false || IsContentsNullUndefEmptyGu(MySalesPersList)) {
				GetSalesStaffList();
				//GetSalesPersonList(1);
				jbLoadedSalesStaffList = true;
			}
			if(!IsContentsNullUndefEmptyGu(MySalesPersList)) {
				ClearDDLOptionsGu('selSalesRepE', 1);
				fillDropDownListGu(MySalesPersList, jselSalesRepE, 0, 'Grp', 'Code');
			}
			return false;
		}

		function PopulateSalesStaffListFA() {
			if(jbLoadedSalesStaffList === false || IsContentsNullUndefEmptyGu(MySalesPersList)) {
				GetSalesStaffList();
				//GetSalesPersonList(1);
				jbLoadedSalesStaffList = true;
			}
			if(!IsContentsNullUndefEmptyGu(MySalesPersList)) {
				ClearDDLOptionsGu('selSalesRepFAE', 1);
				var sSalesRep = document.getElementById('selSalesRepFAE');
				fillDropDownListGu(MySalesPersList, sSalesRep, 0, 'Grp', 'Code');
			}
			return false;
		}

		function PopulateSalesStaffListMC() {
			if(jbLoadedSalesStaffList === false || IsContentsNullUndefEmptyGu(MySalesPersList)) {
				GetSalesStaffList();
				//GetSalesPersonList(1);
				jbLoadedSalesStaffList = true;
			}
			if(!IsContentsNullUndefEmptyGu(MySalesPersList)) {
				ClearDDLOptionsGu('selSalesRepMCE', 1);
				var sSalesRep = document.getElementById('selSalesRepMCE');
				fillDropDownListGu(MySalesPersList, sSalesRep, 0, 'Grp', 'Code');
			}
			return false;
		}

		function PopulateSalesStaffListVC() {
			if(jbLoadedSalesStaffList === false || IsContentsNullUndefEmptyGu(MySalesPersList)) {
				GetSalesStaffList();
				//GetSalesPersonList(1);
				jbLoadedSalesStaffList = true;
			}
			if(!IsContentsNullUndefEmptyGu(MySalesPersList)) {
				ClearDDLOptionsGu('selSalesRepVCE', 1);
				var sSalesRep = document.getElementById('selSalesRepVCE');
				fillDropDownListGu(MySalesPersList, sSalesRep, 0, 'Grp', 'Code');
			}
			return false;
		}

		function PopulateSpeciesList() {
			GetProdCodeList('Species');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selSpecieCC', 1);
				var sel = document.getElementById('selSpecieCC');
				fillDropDownListGu(MyCodeListData, sel, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateSpeciesListByRegion() {
			GetProdCodeListForRegion('Species');
			//alert('Species: ' + MyCodeListData.length);
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selSpecieCC', 1);
				var sel = document.getElementById('selSpecieCC');
				fillDropDownListGu(MyCodeListData, sel, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateThicknessList() {
			GetProdCodeList('Thickness');
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selThicknessCC', 1);
				var sel = document.getElementById('selThicknessCC');
				fillDropDownListGu(MyCodeListData, sel, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}

		function PopulateThicknessListByRegion() {
			GetProdCodeListForRegion('Thickness')
			if (MyCodeListData !== undefined && MyCodeListData !== null) {
				ClearDDLOptionsGu('selThicknessCC', 1);
				var sel = document.getElementById('selThicknessCC');
				fillDropDownListGu(MyCodeListData, sel, 0, 'CodeDescAbbreviated', 'CatCode');
			}
			return false;
		}
		//#endregion PopulatePageObjectsR JS

		// **************************** Background *********************************

		// #region BackgroundFunctionsR JS
		function AddLineToTable(doctype, idx) {
			//alert('Line add: ' + doctype + '/' + idx);
			if (jbCanInitiate === false) { return false;}
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
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtProdType' + srw + '" class="InputTextWNoBorder" style="width:34px;" />-<input type="text" id="txtProdCode' + srw + '" class="InputTextWNoBorder" style="width:70px;" />';
					val = val + '<input type="hidden" id="hfIAitemID' + srw + '" value="0" /><input type="hidden" id="hfIAitemNbr' + srw + '" value="0" />';
					val = val + '<input type="hidden" id="hfIAItemAttribs' + srw + '" value="" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', 'antiquewhite', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtProdDesc' + srw + '" class="InputTextWNoBorder" style="width:200px;background-color:antiquewhite;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtLineStatus' + srw + '" class="InputTextWNoBorder" style="width:40px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<button id="btnRemoveIAitem' + srw + '" class="button blue-gradient glossy" onclick="javascript:RemoveAIitem(' + srw + ');return false;" style="display:none;">Remove</button>';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', 'antiquewhite', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtOrigQty' + srw + '" class="InputTextWNoBorder" style="width:70px;background-color:antiquewhite;"  onchange="javascript:ChangeIALineItem(' + srw + ');return false;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtRevQty' + srw + '" class="InputTextWNoBorder" style="width:70px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', 'antiquewhite', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtOrigPrice' + srw + '" class="InputTextWNoBorder" style="width:100px;background-color:antiquewhite;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtRevPrice' + srw + '" class="InputTextWNoBorder" style="width:100px;" onchange="javascript:ChangeIALineItem(' + srw + ');return false;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '#DDDDDD', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtTotalAmountO' + srw + '" class="InputTextWNoBorder" style="width:110px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '#DDDDDD', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtTotalAmountA' + srw + '" class="InputTextWNoBorder" style="width:110px;" />';
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
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtTKProdType' + srw + '" class="InputTextWNoBorder" style="width:34px;" />-<input type="text" id="txtTKProdCode' + srw + '" class="InputTextWNoBorder" style="width:70px;" />';
					val = val + '<input type="hidden" id="hfRMitemID' + srw + '" value="0" /><input type="hidden" id="hfRMitemNbr' + srw + '" value="0" />';
					val = val + '<input type="hidden" id="hfRMItemAttribs' + srw + '" value="0" /><input type="hidden" id="hfRMItemDesc' + srw + '" value="" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', '', 2); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtTKTicketNbr' + srw + '" class="InputTextWNoBorder" style="width:200px"/>';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtTKStatus' + srw + '" class="InputTextWNoBorder" style="width:40px"/>';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<button id="btnRemoveRMitem' + srw + '" class="button blue-gradient glossy" onclick="javascript:RemoveRMitem(' + srw + ');return false;" style="display:none;">Remove</button>';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtTKQty' + srw + '" class="InputTextWNoBorder" style="width:80px"/>';
					val = val + '<input type="hidden" id="hfTKOrigQty' + srw + '" value=""/>';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtTKTotalPkgCount' + srw + '" class="InputTextWNoBorder" style="width:80px"/>';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtTKQtyCheckedIn' + srw + '" class="InputTextWNoBorder" style="width:100px"/>';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="checkbox" id="chkTKRedTag' + srw + '" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('', 'StdTableCellWBorder', 0, 0, 'center', 'top', '#DDDDDD', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="checkbox" id="chkTKInvAdj' + srw + '" />';
					col.innerHTML = val;
					row.appendChild(col);
					//alert('adding row - index: ' tblName + ' - ' + (jiAddTicketIDX + (idx - 10)).toString());
					InsertRowIntoTableGu('tblInvAdjForm', jiAddTicketIDX + (idx - 5), row);
					break;
				case 'MACADJ':
					row.id = 'trMACAdjustment' + sRow;
					col = CreateTableColumn('tdMACAdjust1_'+srw, 'StdTableCell', 60, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<select id="selProdTypeMACA' + srw + '"><option value="0" selected="selected" onchange="javascript:ChangeProductMAC(0,' + srw + ');return false;" >Not Selected</option>';
					if(!IsContentsNullUndefEmptyGu(MyProdTypeList)) {
						for(var r3=0;r3 < MyProdTypeList.length; r3++) {
							val = val + '<option value="' + MyProdTypeList[r3]['ProdType'].toString() + '">' + MyProdTypeList[r3]['ProdType'].toString() + '</option>';
						}
					}
					val = '</select>';
					val = val + '<input type="hidden" id="hfLineIDMACAE' + srw + '" value="0" /><input type="hidden" id="hfItemNbrMACAE' + srw + '" value="0" />';
					val = val + '<input type="hidden" id="hfMACItemAttribs' + srw + '" value="0" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdMACAdjust2_' + srw, 'StdTableCell', 80, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtProdCodeMACA' + srw + '" style="width:80px;" onchange="javascript:ChangeProductMAC(1,' + srw + ');return false;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdMACAdjust3_' + srw, 'StdTableCell', 140, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtProdDescMACA' + srw + '" style="width:140px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdMACAdjust4_' + srw, 'StdTableCell', 60, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<select id="selLocationMACA' + srw + '"><option value="0" selected="selected">Not Selected</option>';
					if(!IsContentsNullUndefEmptyGu(MyLocationList)) {
						for(var r4=r4; r4<MyLocationList.length; r4++) {
							val = val + '<option value="' + MyLocationList[r4]['LocationCode'].toString() + '">' + MyProdTypeList[r4]['LocationName'].toString() + '</option>';
						}
					}
					val = val + '</select>';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdMACAdjust5_' + srw, 'StdTableCell', 100, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtCostIDMACA' + srw + '" style="width:100px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdMACAdjust6_' + srw, 'StdTableCell', 90, 0, 'right', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtCurrentMACA' + srw + '" style="width:90px;" onchange="javascript:ChangeCurrentMAC(0,' + srw + ',this.value);return false;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdMACAdjust7_' + srw, 'StdTableCell', 90, 0, 'right', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtCorrectMACA' + srw + '" style="width:90px;" onchange="javascript:ChangeCurrentMAC(1,,' + srw + ',this.value);return false;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdMACAdjust8_' + srw, 'StdTableCell', 80, 0, 'right', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtMACDifference' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdMACAdjust9_' + srw, 'StdTableCell', 90, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtMACCostID' + srw + '" style="width:90px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdMACAdjust10_' + srw, 'StdTableCell', 160, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtMACReason' + srw + '" style="width:160px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdMACAdjust11_' + srw, 'StdTableCell', 160, 0, 'center', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<button id="btnRemoveMACItem' + srw + '" class="button blue-gradient glossy" ';
					if(idx === 1) {
						val = val + ' style="display:none;"';
					}
					else {
						if(jbCanEdit===true) {
							val = val + ' onclick="javascript:RemoveMACItem(' + srw + ');return false;"';
						}
					}
					val = val + '> Remove</button>';
					val = val + '<button id="btnEditAttribsMAC' + srw + '" class="button blue-gradient glossy" onclick="javascript:EditAttributesMAC(' + srw + ');return false;">Attribs</button>';
					col.innerHTML = val;
					row.appendChild(col);
					InsertRowIntoTableGu(tblname, idx - 1, row);
					jiNbrLinesMAC++;
					break;
				case 'INVCHG':
					row.id = 'trInventoryChg' + sRow;
					col = CreateTableColumn('tdInventChg1_' + srw, 'StdTableCellWBorder', 0, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICLocation' + srw + '" style="width:60px;" />';
					val = val + '<input type="hidden" id="hfInvReqLineIDIAdjE' + srw + '" value="0" /><input type="hidden" id="hfItemNbrIAdjE' + srw + '" value="0" />';
					val = val + '<input type="hidden" id="hfInvRequestIDIAdjE' + srw + '" value="0" /><input type="hidden" id="hfProdDescIAdjE' + srw + '" value="0" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg2_' + srw, 'StdTableCellWBorder', 0, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICProdType' + srw + '" style="width:60px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg3_' + srw, 'StdTableCellWBorder', 0, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICProdCode' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg4_' + srw, 'StdTableCellWBorder', 0, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr1_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg5_' + srw, 'StdTableCellWBorder', 0, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr2_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg6_' + srw, 'StdTableCellWBorder', 0, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr3_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg7_' + srw, 'StdTableCellWBorder', 0, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr4_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg8_' + srw, 'StdTableCellWBorder', 0, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr5_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg9_' + srw, 'StdTableCellWBorder', 0, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr6_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg10_' + srw, 'StdTableCellWBorder', 0, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr7_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg11_' + srw, 'StdTableCellWBorder', 0, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr8_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg12_' + srw, 'StdTableCellWBorder', 0, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr9_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg13_' + srw, 'StdTableCellWBorder', 0, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr10_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg14_' + srw, 'StdTableCellWBorder', 0, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr11_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg15_' + srw, 'StdTableCellWBorder', 0, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr12_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg16_' + srw, 'StdTableCellWBorder', 0, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICAttr13_' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg17_' + srw, 'StdTableCellWBorder', 0, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICChangedQty' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg18_' + srw, 'StdTableCellWBorder', 0, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICChangedPieces' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg19_' + srw, 'StdTableCellWBorder', 0, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtICDetailedExp' + srw + '" style="width:80px;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdInventChg20_' + srw, 'StdTableCellWBorder', 0, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<button id="btnEditItemIAdj' + srw + '" class="button blue-gradient glossy" onclick="javascript:EditInvChgItem(' + srw + ');return false;"';
					if (jbCanInitiate === false) {val = val + ' disabled="disabled"';}
					val = val + '>Edit</button>';
					val = val + '<button id="btnRemoveItemIAdj' + srw + '" class="button blue-gradient glossy" onclick="javascript:RemoveInvChgItem(' + srw + ');return false;"';
					if (jbCanInitiate === false) {val = val + ' disabled="disabled"';}
					val = val + '>Remove</button>';
					col.innerHTML = val;
					row.appendChild(col);
					InsertRowIntoTableGu(tblname, idx - 1, row);
					jiNbrLinesInventoryAdj++;
					break;
				case 'LSSDMG':
					row.id = 'trLossDamage' + sRow;
					col = CreateTableColumn('tdLossDamage1_' + srw, 'StdTableCell', 80, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<select id="selProdTypeLAD' + sRow + '" style="border:none;"><option value="0" selected="selected">None Selected</option>';
					if(!IsContentsNullUndefEmptyGu(MyProdTypeList)) {
						for(var r5=0; r5<MyProdTypeList.length; r5++) {
							val = val + '<option value="' + MyProdTypeList[r5]['ProdType'].toString() + '">' + MyProdTypeList[r5]['ProdType'].toString() + '</option>';
						}
					}
					val = val + '</select>';
					val = val + '<input type="text" id="txtProdCodeLAD' + sRow + '" style="width:80px;" />';
					val = val + '<input type="hidden" id="hfLineIDLAD' + srw + '" value="0" /><input type="hidden" id="hfItemNbrLAD' + srw + '" value="0" />';
					val = val + '<input type="hidden" id="hfLADItemAttribs' + srw + '" value="0" /><input type="hidden" id="hfLADProdDesc' + srw + '" value="" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdLossDamage2_' + srw, 'StdTableCell', 90, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtAmountLAD' + sRow + '" style="width:90px;border:none;text-align:right;" onchange="javascript:ChangeTotalClaimAmt();return false;" />';
					val = val + '<input type="hidden" id="hfOrigAmtLAD' + srw + '" value="" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdLossDamage3_' + srw, 'StdTableCell', 320, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<input type="text" id="txtLineCommmentsLAD' + sRow + '" style="width:320px;border:none;" />';
					col.innerHTML = val;
					row.appendChild(col);
					col = CreateTableColumn('tdLossDamage4_' + srw, 'StdTableCell', 204, 0, 'left', 'top', '', '', 0); //id, cls, wdth, ht, horient, vorient)
					val = '<button id="btnSaveLADItem' + srw + '" class="button blue-gradient glossy" onclick="javascript:SaveLADItem(' + srw + ');return false;"';
					if (jbCanInitiate === false) {val = val + ' disabled="disabled"';}
					val = val + '>Save</button>';
					val = val + '<button id="btnRemoveLADItem' + srw + '" class="button blue-gradient glossy" onclick="javascript:RemoveLADItem(' + srw + ');return false;"';
					if (jbCanInitiate === false) {val = val + ' disabled="disabled"';}
					val = val + '>Remove</button>';
					val=val+'<button id="btnEditAtributesLAD' + srw + '" class="button blue-gradient glossy" onclick="javascript:EditAttributesLAD(' + srw + ');return false;">Attribs</button>';
					col.innerHTML = val;
					row.appendChild(col);
					InsertRowIntoTableGu(tblname, idx - 1, row);
					jiNbrLinesLAD++;
					break;
				default:
					break;
			}

			// change 
			if(doctype === 'INVADJ') { jiTableRowIdxRM++; }
			return false;
		}

		function CreateTableColumn(id, cls, wdth, ht, horient, vorient, bcolor, fcolor, colspan) {
			var col = document.createElement("td");
			if(id !== '') { col.id = id; }
			if(cls !== '') { col.className = cls; }
			if(wdth > 0) { col.style.width = wdth.toString() + 'px'; }
			if(ht > 0) { col.style.height = ht.toString() + 'px'; }
			if(horient !== '') { col.style.textAlign = horient; }
			if(vorient !== '') { col.style.verticalAlign = vorient; }
			if(bcolor !== '') { col.style.backgroundColor = bcolor; }
			if(fcolor !== '') { col.style.color = fcolor; }
			if(colspan>0) {
				col.colSpan = colspan.toString();
			}
			return col;
		}

		function FillDocumentStatus(stat) {
			switch(stat) {
				case 'U':
					jlRequestStatusH.innerHTML = 'Unsubmitted';
					if(jiRequesterID === jiByID) {
						jbCanEdit = true;
					}
					break;
				case 'SB':
					jlRequestStatusH.innerHTML = 'Submitted';
					if(jiRequesterID !== jiByID) {
						jbCanEdit = true;
					}
					break;
				case 'AP':
					jlRequestStatusH.innerHTML = 'In Approval';
					jbCanEdit = false;
					break;
				case 'AC':
					jlRequestStatusH.innerHTML = 'Approved';
					jbCanEdit = false;
					break;
				case 'RJ':
					jlRequestStatusH.innerHTML = 'Rejected';
					jbCanEdit = false;
					break;
				case 'HLD':
					jlRequestStatusH.innerHTML = 'Hold';
					jbCanEdit = false;
					break;
				case 'CMP':
					jlRequestStatusH.innerHTML = 'Complete';
					jbCanEdit = false;
					break;
				case 'VL':
					jlRequestStatusH.innerHTML = 'In Validation';
					jbCanEdit = false;
					break;
				case 'CX':
					jlRequestStatusH.innerHTML = 'Canceled';
					jbCanEdit = false;
					break;
				case 'SPR':
					jlRequestStatusH.innerHTML = 'Superceded';
					jbCanEdit = false;
					break;
				default:
					break;
			}
		}

		function FormHDDropDown(val, objnm, srw) {
			var pt='';
			var str='';
			str='<select id="'+ objnm + srw +'" style="border:none;"><option value="0"';
			if (val === '0') { str = str + 'selected="selected"';}
			str = str + '>None Selected</option>';
			if(!IsContentsNullUndefEmptyGu(MyProdTypeList)) {
				for(var r1=0; r1<MyProdTypeList.length; r1++) {
					pt=MyProdTypeList[r1]['ProdTypeCode'].toString(); 
					val=val+'<option value="' + pt + '"';
					if(pt===MyInvoiceItems[rw-1]['ProdTypeCode'].toString()) { val=val+' selected="selected"';}
					val = val + '>' + MyProdTypeList[r1]['ProdTypeCode'].toString() + '</option>';
				}
			}
			str = str + '</select>';
			return str;
		}
			
		function GetErrorType(nbr, fieldname) {
			switch(nbr) {
				case 1:
					return fieldname + ' is required.\n';
					break;
				case 2:
					return fieldname + ' is too short.\n';
					break;
				case 3:
					return fieldname + ' is too long.\n';
					break;
				case 4:
					return fieldname + ' cannot be 0.\n';
					break;
				case 5:
					return fieldname + ' contains invalid characters.\n';
					break;
				default:
					break;
			}
			return '';
		}

		function IdentifyProdTypeLevel(pt) {
			var lvl = 0;
			for(var i = 0; i < MyProdTypeList.length; i++) {
				if(pt === MyProdTypeList[i]['ProductTypeCode'].toString()) {
					lvl = i;
					break;
				}
			}
			return lvl;
		}

		function InitializeInvAdj() {
			jtRequestIDE.value = jiRequestID.toString();
			FindRequest();
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
				document.getElementById('txtTotalAmountO' + row.toString()).value = '0';
				document.getElementById('txtTotalAmountA' + row.toString()).value = '0';
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

		function LoadAttributeArray(attribs) {
			jaAttributes = attribs.split('|');
			return false;
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

		function StoreAttributeValues() {
			var attribs='';
			for(var itm=1; itm<=13; itm++) {
				if(jiaFormatType[itm-1]===0) {
					jaAttributes[itm-1]=document.getElementById('').value;
				}
				else {
					jaAttributes[itm-1]=document.getElementById('').value;
				}
			}
			for(var i2=0; i2<13; i2++) {
				if(attribs.length>0) { attribs=attribs+'|';}
				attribs=attribs+jaAttributes[i2];
			}
			switch(jsDocType) {
				case 'MACADJ':
					document.getElementById('hfMACItemAttribs'+jiTargetRow.toString()).value=attribs;
					break;
				default:
					break;
			}
			jbIsDirty=true;
			return false;
		}

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

		function DialogAction1(itm, src) {
			switch(src) {
				case 22: //attributes edit
					StoreAttributeValues();
					break;
				default:
					break;
			}
			return false;
		}

		function EditOneRec(id, row, objid) {
			switch(objid) {
				case 1: // inventory change
					EditInvChgItem(id, row);
					break;
				default:
					break;
			}
			return false;
		}

		function ShowAttributesEdit(doctype, pt, row) {
			jsDocType=doctype;
			jiTargetRow=row;
			var ht = 300;
			var pref = '';
			var sRow = '';
			var val = '';
			var wdth = 920;
			// load labels and drop down lists
			if(jbLoadedProdTypeList === false) { GetProdTypeLists('', 0, 1);}
			var lvl = IdentifyProdTypeLevel(pt);
			for(var a = 1; a <= 13; a++) {
				sRow = a.toString();
				if(sRow.length < 2) { sRow = '0' + sRow; }
				if(!IsContentsNullUndefEmptyGu(MyProdTypeList)) {
					pref = MyProdTypeList[lvl]['AttribSource' + sRow].toString();
				}
				else {
					pref = '';
				}
				document.getElementById('lblAttribE' + a.toString()).innerHTML = MyProdTypeList[lvl]['AttribLabel' + sRow].toString();
				if(pref === '') {
					document.getElementById('tdAttributes1').innerHTML = '<input type="text" id="txtAttributeE' + a.toString() + '" value="' + jaAttributes[a-1] + '" style="width:80px;border:none;" />';
					jiaFormatType[a-1]=0;
				}
				else if(pref.substr(0, 2).toUpperCase()==='X(') {
					document.getElementById('tdAttributes1').innerHTML='<input type="text" id="txtAttributeE'+a.toString()+'" value="'+jaAttributes[a-1]+'" style="width:80px;border:none;" />';
					jiaFormatType[a-1]=0;
				}
				else {
					jiaFormatType[a-1]=1;
					val = '<select id="selAttributeE3" style="border:none;"><option value="0"';
					if(jaAttributes[a-1] === '0') { val = val + ' selected="selected"'; }
					val = val + '>Not Selected</option>';
					GetLTProdCodeList(pref, 0, 1);
					if(!IsContentsNullUndefEmptyGu(MyLTCodeList)) {
						for(var itm=0; itm<MyLTCodeList.length; itm++) {
							val=val+'<option value="' + MyLTCodeList[itm]['code'].toString() + '"';
							if(jaAttributes[a-1]===MyLTCodeList[itm]['code'].toString()) { val=val+' selected="selected"'; }
							val = val + '>' + MyLTCodeList[itm]['codedesc'].toString() + '</option>';
						}
					}
					val=val + '</select>';
					document.getElementById('tdAttributes' + a.toString()).innerHTML = val;
				}
			}
			// show dialog
			ShowSpecialDialogBox1Dx('divAttributesEdit', 'Edit Attributes', true, true, ht, wdth, '', '', window, '', 'Save', '11pt', '1px', 'fadeIn', 'fadeOut', 22);
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
			sdata = sdata + 'Page ID: ' + jiPageID.toString() + '\n';
			sdata = sdata + 'Last AJAX: ' + jsLastAJAXCall;
			alert(sdata);
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

		// #region TabFunctions JS
		function SetTabVisible(tb) {
			switch(tb) {
				case 1:
					jdivTab1.style.display = 'block';
					jdivTab2.style.display = 'none';
					jdivTab3.style.display = 'none';
					jdivTab4.style.display = 'none';
					jdivHideBottomLine.style.display = 'block';
					//jdivHideBottomLine.style.position = 'absolute';
					jdivTabHdr1.style.backgroundColor = 'white';
					jdivTabHdr2.style.backgroundColor = '#D1D0CE';
					jdivTabHdr3.style.backgroundColor = '#D1D0CE';
					jdivTabHdr4.style.backgroundColor = '#D1D0CE';
					//jdivHideBottomLine.style.top = '173px';
					//jdivHideBottomLine.style.left = '16px';
					$( "#divHideBottomLine" ).position({
						my: "center",
						at: "bottom",
						of: "#divTabHdr1"
					});
					break;
				case 2:
					jdivTab1.style.display = 'none';
					jdivTab2.style.display = 'block';
					jdivTab3.style.display = 'none';
					jdivTab4.style.display = 'none';
					jdivHideBottomLine.style.display = 'block';
					//jdivHideBottomLine.style.position = 'absolute';
					//jdivHideBottomLine.style.top = '173px';
					//jdivHideBottomLine.style.left = '170px';
					jdivTabHdr1.style.backgroundColor = '#D1D0CE';
					jdivTabHdr2.style.backgroundColor = 'white';
					jdivTabHdr3.style.backgroundColor = '#D1D0CE';
					jdivTabHdr4.style.backgroundColor = '#D1D0CE';
					$( "#divHideBottomLine" ).position({
						my: "center",
						at: "bottom",
						of: "#divTabHdr2"
					});
					break;
				case 3:
					jdivTab1.style.display = 'none';
					jdivTab2.style.display = 'none';
					jdivTab3.style.display = 'block';
					jdivTab4.style.display = 'none';
					jdivHideBottomLine.style.display = 'block';
					//jdivHideBottomLine.style.position = 'absolute';
					//jdivHideBottomLine.style.top = '173px';
					//jdivHideBottomLine.style.left = '324px';
					jdivTabHdr1.style.backgroundColor = '#D1D0CE';
					jdivTabHdr2.style.backgroundColor = '#D1D0CE';
					jdivTabHdr3.style.backgroundColor = 'white';
					jdivTabHdr4.style.backgroundColor = '#D1D0CE';
					$( "#divHideBottomLine" ).position({
						my: "center",
						at: "bottom",
						of: "#divTabHdr3"
					});
					break;
				case 4:
					jdivTab1.style.display = 'none';
					jdivTab2.style.display = 'none';
					jdivTab3.style.display = 'none';
					jdivTab4.style.display = 'block';
					jdivHideBottomLine.style.display = 'block';
					jdivHideBottomLine.style.position = 'absolute';
					jdivHideBottomLine.style.top = '173px';
					jdivHideBottomLine.style.left = '478px';
					jdivTabHdr1.style.backgroundColor = '#D1D0CE';
					jdivTabHdr2.style.backgroundColor = '#D1D0CE';
					jdivTabHdr3.style.backgroundColor = '#D1D0CE';
					jdivTabHdr4.style.backgroundColor = 'white';
					$( "#divHideBottomLine" ).position({
						my: "center",
						at: "bottom",
						of: "#divTabHdr4"
					});
					break;
				default:
					jdivTab1.style.display = 'none';
					jdivTab2.style.display = 'none';
					jdivTab3.style.display = 'none';
					jdivTab4.style.display = 'none';
					jdivTabHdr1.style.backgroundColor = '#D1D0CE';
					jdivTabHdr2.style.backgroundColor = '#D1D0CE';
					jdivTabHdr3.style.backgroundColor = '#D1D0CE';
					jdivTabHdr4.style.backgroundColor = '#D1D0CE';
					jdivHideBottomLine.style.display = 'none';
					break;
			}
			return false;
		}
		// #endregion TabFunctions JS

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
				GetUserDocRights(jsDocType, 0);
				//alert('Right ' + jiDocRightLevel);
				//alert(jsDocType + ' BEGIN - gets rights');
				jdivFormFooter.style.display = 'block';
				//alert(jiDocRightLevel);
				if(jiDocRightLevel > 0) {
					// set doc type in list
					jsaDocType[jiNbrDocs] = jsDocName;
					jiaDocTypeID[jiNbrDocs] = jiDocumentType;
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
							//jbShowInvAdj = false;
							//PopulateCarrierList();
							//PopulateCreditRepLists();
							//PopulateSalesLeadLists();
							//PopulateLocationLists();
							//PopulateDestinationList();
							//PopulateSalesLeadLists();
							//PopulateSalesStaffLists();
							//PopulateReasonList();
							//jdivInvAdjManifest.style.display = 'block';
							//ChangeInvAdjManifestView(2, 1);
							//SetTextBoxAutoComplete2Wc('txtCustNameE', 3, jhfCustCodeE, MyCustomerData, 'cust', 'CustName');
							NewInvAdjSection();
							jspnAttachMessage.style.display = 'inline';
							break;
						case 3: // Return Manifest
							//jbShowRManf = false;
							//jtRequestedByM.value = jsUserName;
							//jhfRequestedByIDM.value = jiByID.toString();
							//PopulateCarrierList();
							//PopulateCreditRepListsRM();
							//PopulateSalesLeadListsRM();
							//PopulateLocationListsRM();
							//PopulateDestinationList();
							//PopulateSalesStaffLists();
							//PopulateReasonListRM();
							//jdivInvAdjManifest.style.display = 'block';
							//ChangeInvAdjManifestView(3, 1);
							//if(jsaDocType[0] !== 'INVADJ') {
							//	SetTextBoxAutoComplete2Wc('txtCustNameM', 3, jhfCustCodeLAD, MyCustomerData, 'cust', 'CustName');
							//}
							NewRtnManifest();
							jspnAttachMessage.style.display = 'inline';
							//alert('Done!');
							break;
						case 4: // Freight Accrual
							//alert('Freight Accrual');
							NewFreightAccrual();
							jdivFreightAccrual.style.display = 'block';
							jspnAttachMessage.style.display = 'inline';
							break;
						case 5: //Vendor Claim
							//PopulateSalesLeadListsVC();
							//PopulateSalesStaffListVC();
							//PopulateCreditRepListsVC();
							//PopulateLocationListsVC();
							//PopulateReasonListVC(); 
							NewVendorClaim();
							jdivVendorClaim.style.display = 'block';
							jspnAttachMessage.style.display = 'inline';
							break;
						case 6:	// Loss & Damage Claim
							//alert('Loss and Damage');
							//PopulateProdTypeListsLAD();
							//SetTextBoxAutoComplete2Wc('txtCustomerLAndD', 3, jhfCustCodeLAD, MyCustomerData, 'cust', 'CustName');
							NewLossAndDamageClaim();
							jdivLossAndDamageClaim.style.display = 'block';
							jspnAttachMessage.style.display = 'inline';
							break;
						case 7: // Inventory Adjustment
							PopulateLocationListsIC();
							PopulateProdTypeListsIC();
							jdivInventoryChangeReq.style.display = 'block';
							jspnAttachMessage.style.display = 'inline';
							
							
							if(!IsContentsNullUndefEmptyGu(MyInvoiceItems)) {
								PopulateInventoryChgItems();
							}
							jdivInventoryChangeReq.style.display = 'block';
							jspnAttachMessage.style.display = 'inline';
							break;
						case 8: // MAC Adjustment
							//PopulateProdTypeListsMA();
							//PopulateLocationListsMA();
							NewMACAdjustment();
							jdivMACAdjustment.style.display = 'block';
							jspnAttachMessage.style.display = 'inline';
							break;
						case 9: // Manual credit
							//PopulateSalesStaffListMC();
							//PopulateSalesLeadListsMC();
							//PopulateLocationListsMC();
							//PopulateReasonListMC();
							//PopulateCreditRepListsMC();
							NewManualCredit()
							jdivManualCredit.style.display = 'block';
							jspnAttachMessage.style.display = 'inline';
							break;
						case 10: // Cust Claim
							//PopulateSalesLeadListsCC();
							//PopulateLocationListCC();
							//PopulateThicknessList();
							//PopulateGradeList();
							//PopulateSpeciesList();
							NewCustClaim();
							jdivCustClaim.style.display = 'block';
							jspnAttachMessage.style.display = 'inline';
							break;
						default:
							break;
					}
					ChangeEditStatus(true);
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

		function ChangeEditStatus(edt) {
			jbCanEdit = edt;
			jtSubmittedByHDR.readOnly = true;
			jtSubmittedOnHDR.readOnly = true;
			if(jbCanEdit===false) {
				document.getElementById('btnStatus0').disabled = true;
				jtInvoiceNbrE.readOnly = true;
			}
			else {
				document.getElementById('btnStatus0').disabled = false;
				if(jbCanInitiate===false) {
					jtInvoiceNbrE.readOnly = true;
				}
				else {
					jtInvoiceNbrE.readOnly = false;
				}
			}
			switch(jiDocumentType) {
				case 2:	// invoice adj
					SetInvoiceAdjEdit(jbCanEdit);
					break;
				case 3: // return manifest
					SetRtnManifestEdit(jbCanEdit);
					break;
				case 4:	// freight accrual
					SetFreightAccrualEdit(jbCanEdit);
					break;
				case 5: // vendor claim
					SetVendorClaimEdit(jbCanEdit);
					break;
				case 6:	// loss dmg
					SetLossDamageEdit(jbCanEdit);
					break;
				case 7:	// inventory change
					SetInvChangeEdit(jbCanEdit);
					break;
				case 8:	// MAC adjust
					SetMACAdjustEdit(jbCanEdit);
					break;
				case 9: // manual credit
					SetManualCreditEdit(jbCanEdit);
					break;
				case 10:
					SetCustomerClaimEdit(jbCanEdit);
					break;
				default:
					break;
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

		// initial status change
		function ChangeReqStatus(btn) {
			jsStatusCode = jsaStatus[btn]; // 0 is SAVE button, just existing status
			SaveRequest();
			PopulateDocStatusFlow(jiRequestID);
			//FillDocumentStatus(jsStatusCode);
			return false;
		}

		function ChangePageSize(val) {
			jiPageSize = parseInt(val, 10);
			GetDocStatusChanges(jiRequestID);
			PopulateDocStatusChanges();
			return false;
		}

		function ChangePageSize2(val) {
			jiPageSize2 = parseInt(val, 10);
			GetAttachmentList(jsDocType, jiInvoiceReqID, '');
			PopulateAttachmentList();
			return false;
		}

		function ChangeRegionCode(val) {
			//jlPageStatus.innerHTML = "Updating filters, Please wait...";
			jsRegionCode = val;
			PopulateLocationListByRegion();
			PopulateProductList();
			PopulateThicknessListByRegion();
			PopulateGradeListByRegion();
			PopulateSpeciesListByRegion();
			jlPageStatus.innerHTML = "Page Ready";
			return false;
		}

		// Main Request Load start
		function FindRequest() {
			var fig = parseInt(jtRequestIDE.value, 10);
			if(jiRequestID !== fig) {
				jbIsDirty=false;
				HideAllAreas();
				jiRequestID = fig;
				GetRequestData(0);  // MyRequestData
				jsStatusCode = 'U';
				if(!IsContentsNullUndefEmptyGu(MyRequestData)) {
					PopulateDocStatusFlow(jiRequestID);
					jsStatuscode = MyRequestData[0]['StatusCode'].toString();
					jiRequesterID = parseInt(MyRequestData[0]['RequestedByID'], 10);
					jsaDocType = MyRequestData[0]['DocTypes'].toString().split(';');
					jiaDocTypeID = MyRequestData[0]['DocTypeIDs'].toString().split(',');
					jsDocType = jsaDocType[0];
					GetUserDocRights(jsDocType, jiRequestID);


					if(jsStatusCode === 'U') {
						jspnDocumentTypeLabel.style.display = 'inline';
						jspnDocumentTypeList.style.display = 'inline';
						jtSubmittedOnHDR.value = jsToday;
						jtSubmittedByHDR.value = jsUserName;
						jhfSubmittedByIDHDR.value = jiByID;
						jbCanInitiate = true;
						ChangeEditStatus(true);
					}
					else {
						jspnDocumentTypeLabel.style.display = 'none';
						jspnDocumentTypeList.style.display = 'none';
						jbCanInitiate = false;
						ChangeEditStatus(false);
					}
					jiOrderNbr = parseInt(MyInvoiceData[0]['SalesOrderNbr'], 10);
					GetRequestDocTypeList();
					PopulateRequest();
				}
				else {
					alert('No Request data was found matching that number.');
				}
				jsaStatus[0] = jsStatusCode;
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
				jiInvoiceID = fig;
				//alert('Getting Invoice data');
				GetInvoiceData(); //MyInvoiceData
				//alert('populating invoice data');
				PopulateInvoiceData();
				jhfInvoiceID.value = jiInvoiceID.toString();
				jbIsDirty=true;
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

		function LoadStatusBtnBar() {
			var btn;
			jsaStatus = ['', '', '', '', '', '', '', '', '', ''];
			if(!IsContentsNullUndefEmptyGu(MyDocStatFlow)) {
				for(var itm=0; itm<9; itm++) {
					btn = document.getElementById('btnStatus' + (itm+1).toString());
					if(itm<MyDocStatFlow.length) {
						btn.innerText = MyDocStatFlow[itm]['StatusActionLabel'].toString();
						jsaStatus[itm+1] = MyDocStatFlow[itm]['NewStatusCode'].toString()
						btn.style.display = 'inline';
					}
					else {
						btn.style.display = 'none';
					}
				}
			}
			return false;
		}

		// Set form for a new form of whatever type
		function NewInvRequest() {
			jbIsDirty=false;
			SetTabVisible(1);
			jiRequesterID = jiByID;
			jbCanApprove = false;
			jbCanInitiate = true;
			jbtnAddNewType2.style.display = 'inline';
			jiDocumentType = parseInt(jselDocumentType.value, 10);
			if(jiDocumentType === 0) {
				alert('You have not selected your initial document type. Please select one before clicking on New Request.');
			}
			if(jiDocumentType > 0) {
				jiNbrDocs = 1;
				SetDocType(); //		jsDocType/jsDocName filled in
				//alert(jsDocType);
				GetUserDocRights(jsDocType, 0);
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
				jtSubmittedOnHDR.value = jsToday;
				jtSubmittedByHDR.value = jsUserName;
				jhfSubmittedByIDHDR.value = jiByID;
				jbLoadedInvoiceItems = false;
				jtFindInvoiceNbr.readOnly = false;
				jtRequestIDE.readOnly = false;
				jtRequestIDE.value = '0';
				jsStatusCode = 'U';
				FillDocumentStatus(jsStatusCode);
				jsaStatus[0] = 'U';
				jiaInvoiceReqID = [0, 0, 0, 0, 0, 0];
				jsaDocType = [jsDocName, '', '', '', '', ''];
				jiaDocTypeID = [jiDocumentType, 0, 0, 0, 0, 0];
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
							NewInvAdjSection();
							jlInvoiceAdjReqHdr.style.display='inline';
							jspnAttachMessage.style.display='inline';
							break;
						case 3:	//Return Manifest
							NewRtnManifest();
							jdivInvAdjManifest.style.display = 'block';
							jlInvoiceAdjReqHdr.style.display='inline';
							jspnAttachMessage.style.display = 'inline';
							break;
						case 4:	//Freight Accrual
							NewFreightAccrual();
							jlInvoiceAdjReqHdr.style.display='none';
							jdivInvAdjManifest.style.display = 'block';
							break;
						case 5:	//Vendor Claim
							NewVendorClaim();
							jlInvoiceAdjReqHdr.style.display='none';
							jdivInvAdjManifest.style.display = 'block';
							break;
						case 6:	//Loss & Damage Claim
							NewLossAndDamageClaim();
							jlInvoiceAdjReqHdr.style.display='none';
							jdivInvAdjManifest.style.display = 'block';
							break;
						case 7:	//Inventory Adjustment
							NewInventoryChange();
							jlInvoiceAdjReqHdr.style.display='none';
							jdivInvAdjManifest.style.display = 'block';
							break;
						case 8:	//MAC Adjustment
							NewMACAdjustment();
							jlInvoiceAdjReqHdr.style.display='none';
							break;
						case 9:	//Manual Credit
							NewManualCredit();
							jdivInvAdjManifest.style.display = 'block';
							jlInvoiceAdjReqHdr.style.display='none';
							break;
						case 10: //Cust claim
							NewCustClaim();
							jlInvoiceAdjReqHdr.style.display='none';
							jdivInvAdjManifest.style.display = 'block';
							break;
						default:
							jdivFormBlank.style.display = 'block';
							break;
					}
					// remove status changes
					ChangeEditStatus(true);
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

		function ReloadRequest() {
			if(jiRequestID > 0) {
				jtRequestIDE.value = jiRequestID.toString();
				FindRequest();
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
			var cmt = EncodeSingleQuotesTx(jtaGenCommentIAE.value);
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
			var sdate = jtSubmittedOnCC.value;
			var spid = 0;
			var stat = jsStatusCode;
			var slead = '';
			var sto = '';
			var tonbr = 0;
			var val = '';
			var reqon = '';
			var doctypes = jsaDocType.join().replace(/,/g, ';');
			var doctypeIDs = '';
			for(var i=0; i<jiNbrDocs; i++) {
				if (doctypeIDs.length > 0) {doctypeIDs = doctypeIDs + ',';}
				doctypeIDs = doctypeIDs + jiaDocTypeID[i].toString();
			}
			if(jchkCriticalImportance.checked === true) { critical = 1; }
			jiRequestID = parseInt(jlRequestIDE.innerHTML, 10);
			jiMinDocumentType = jiaDocTypeID[0];
			// update main request record
			if(ValidateRequestData()) {
				UpdateRequestData(jiRequestID, sdate, byid, jiMinDocumentType, stat, jiNbrDocs, critical, cmt, emailto, doctypes, doctypeIDs, reqon, 1);
				alert('Request saved!');
				// Save doc types data
				for(var itm = 0; itm < jiNbrDocs; itm++) {
					jiDocumentType = jiaDocTypeID[itm];
					switch(jiDocumentType) {
						//case 1:	//InvAdj-Rtn Manifest
						//	SaveInvoiceAdjLines();
						//	break;
						case 2:	//InvAdjustment Only
							SaveInvoiceAdjData();
							SaveInvoiceAdjLines();
							break;
						case 3:	//Return Manifest
							SaveRtnManifestData();
							SaveRtnManifestLines();
							break;
						case 4:	//Freight Accrual
							SaveFreightAccrual();
							break;
						case 5:	//Vendor Claim
							SaveVendorClaim();
							break;
						case 6:	//Loss & Damage Claim
							SaveLADData();
							SaveLossDamageLines();
							break;
						case 7:	//Inventory Adjustment
							SaveInvChangeHdr();
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
			}
			return false;
		}

		function SetDocType() {
			jsDocType = jsaTypeCodes[jiDocumentType];
			jsDocName = jsaTypeNames[jiDocumentType];
			return false;
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

		function ValidateRequestData() {
			var okay = true;
			var errors = '';
			var val = '';
			if (jtSubmittedByHDR.value === '') { errors = errors.concat('Submitted By cannot be blank.\n'); }
			if (jtSubmittedOnHDR.value === '') { errors = errors.concat('Submmitted On cannot be blank.\n');}
			val = jtEmailsToInclude.value;
			if (ValidateEmailStringTx(val) === false && val !== '') { errors = errors.concat('Emails to Include data is not in the correct format.\n');}
			val = PrepareJSONForHTMLTx(jtaGenCommentIAE.value);
			if (val.length > 300) {errors = errors.concat('General Comments field is too long.\n');}

			for(var doc=0; doc<jiNbrDocs; doc++) {
				switch(jiaDocTypeID[doc]) {
					case 2:	// inv adj
						errors = errors.concat(ValidateInvAdj());
						break;
					case 3: // rtn manifest
						errors = errors.concat(ValidateRtnManifest());
						break;
					case 4:	// freight accrual
						errors = errors.concat(ValidateFreightAccrual());
						break;
					case 5:
						errors = errors.concat(ValidateVendorClaim());
						break;
					case 6: // loss damage
						errors = errors.concat(ValidateLossAndDamage());
						break;
					case 7:	// inventory change
						errors = errors.concat(ValidateInventoryChange());
						break;
					case 8:	// mac adjust
						errors = errors.concat(ValidateMaCAdjust());
						break;
					case 9:	// manual credit
						errors = errors.concat(ValidateManualCredit());
						break;
					case 10: // customer claim
						errors = errors.concat(ValidateCustClaim());
						break;
					default:
						break;
				}
			}

			if(errors !== '') {
				alert('===VALIDATION FAILURE===\n' + errors);
				return false;
			}
			else {
				return true;
			}
		}

		// **************************** FORM: Customer Claim *********************************
		
		//#region CustomerClaim JS
		function NewCustClaim() {
			PopulateSalesLeadListsCC();
			PopulateLocationListCC();
			PopulateThicknessList();
			PopulateGradeList();
			PopulateSpeciesList();
			document.getElementById('hfSubmittedByIDCC').value = jiByID.toString();
			document.getElementById('hfCustCodeCC').value = '';
			document.getElementById('txtShipmentNbrCC').value = '0';
			document.getElementById('hfVendorCodeCC').value = '';
			document.getElementById('txtSubmittedByCC').value = jsUserName;
			document.getElementById('txtSubmittedOnCC').value = jsToday;
			document.getElementById('txtCustNameCC').value = '';
			document.getElementById('txtOrderNbrCC').value = '0';
			document.getElementById('txtInvoiceNbrCC').value = '0';
			document.getElementById('selRegionCC').value = '0';
			document.getElementById('selMillLocationCC').value = '0';
			document.getElementById('txtShipmentNbrCC').value = '0';
			document.getElementById('txtVendorNameCC').value = '';
			document.getElementById('selSalesLeadCC').value = '0';
			document.getElementById('selGradeCC').value = '0';
			document.getElementById('selThicknessCC').value = '0';
			document.getElementById('selSpecieCC').value = '0';
			document.getElementById('txaMiscInfoCC').value = '';
			document.getElementById('txaCustClaimDesc').value = '';
			document.getElementById('txaCustClaimInvestigation').value = '';
			document.getElementById('txaCustClaimResolution').value = '';
			document.getElementById('txtResolutionDateCC').value = '';
			document.getElementById('txtResolutionAmtCC').value = '0';
			document.getElementById('hfOrigAmtCC').value = '0';
			document.getElementById('radMillErrorN').checked = true;
			jsRegionCode = '0';
			jdivCustClaim.style.display = 'block';
			return false;
		}

		function SaveCustClaim() {
			var dtreq = document.getElementById('txtSubmittedOnCC').value;
			var byid = parseInt(document.getElementById('hfSubmittedByIDCC').value, 10);
			var stat = jsStatusCode;
			var idt = '';
			var crepid = '0'; 
			var spid = '0';
			var slead = document.getElementById('selSalesLeadCC').value;
			var sfm = document.getElementById('selMillLocationCC').value;
			var rc = document.getElementById('selReasonCodeCC').value;
			var cust = document.getElementById('hfCustCodeCC').value; 
			var ctlnbr = '';
			var cid = '';
			var vend =''; 
			var onbr = CleanNbrValTx(document.getElementById('txtOrderNbrCC').value); 
			var shpnbr = document.getElementById('txtShipmentNbrCC').value;
			var onbr1 = '';
			var onbr2 = '';
			var loc2='';
			var loc3='';
			var set1=0;
			if (document.getElementById('radMillErrorY').checked === true) {set1 = 1;}
			var set2=0;
			var set3=0;
			var set4=0;
			var set5=0;
			var set6=0;
			var amt = parseFloat(CleanNbrValTx(document.getElementById('hfOrigAmtCC').value));
			var aiamt= 0;
			var aamt = parseFloat(CleanNbrValTx(document.getElementById('txtResolutionAmtCC').value));
			var frate = 0;
			var oamt = 0;
			var oval1 = document.getElementById('selRegionCC').value;
			var oval2 = '';
			var pval1 = document.getElementById('selGradeCC').value;
			var pval2 = document.getElementById('selThicknessCC').value;
			var pval3 = document.getElementById('selSpecieCC').value;
			var rdate = '';
			var tdate = '';
			var adate1 = document.getElementById('txtResolutionDateCC').value;
			var adate2 = '';
			var tdate1 = '';
			var tdate2 = '';
			var nprod = 0;
			var cmt = PrepareJSONForHTMLTx(jtaGenCommentIAE.value, 1);
			var act = 1;
			var rdet = PrepareJSONForHTMLTx(document.getElementById('txaMiscInfoCC').value, 1);
			var crc = 0;
			var val = '';
			alert('Ready to save CC invoicereq');
			UpdateInvRequest(dtreq, byid, stat, idt, crepid, spid, slead, sfm, rc, rdet, cust, ctlnbr, cid, vend, onbr, shpnbr, onbr1, onbr2, loc2, loc3, crc, set1, set2, set3, set4, set5, set6, amt, aiamt, aamt, frate, oamt, oval1, oval2, pval1, pval2, pval3, rdate, tdate, adate1, adate2, tdate1, tdate2, nprod, cmt, act);
			// save comments
			if(jiInvoiceReqID>0) {
				val = PrepareJSONForHTMLTx(document.getElementById('txaCustClaimDesc').value, 1);
				UpdateCommentData(cid, 1, typ, ctype, ttl, loc, tdt, origid, fieldnm, val);
				val = PrepareJSONForHTMLTx(document.getElementById('txaCustClaimInvestigation').value, 1);
				UpdateCommentData(cid, 2, typ, ctype, ttl, loc, tdt, origid, fieldnm, val);
				val = PrepareJSONForHTMLTx(document.getElementById('txaCustClaimResolution').value, 1);
				UpdateCommentData(cid, 3, typ, ctype, ttl, loc, tdt, origid, fieldnm, val);
			}
			return false;
		}

		function SetCustomerClaimEdit(edt) {
			var rOnly = false;
			if (edt === 0) { rOnly = true;}
			if(jbCanInitiate===false) {
				document.getElementById('txtSubmittedByCC').readOnly = true;
				document.getElementById('txtSubmittedOnCC').readOnly = true;
				document.getElementById('txtCustNameCC').readOnly = true;
				document.getElementById('txtOrderNbrCC').readOnly = true;
				document.getElementById('txtInvoiceNbrCC').readOnly = true;
				document.getElementById('txtVendorNameCC').readOnly = true;
				document.getElementById('selRegionCC').disabled = true;
				document.getElementById('selMillLocationCC').disabled = true;
			}
			else {
				document.getElementById('txtSubmittedByCC').readOnly = rOnly;
				document.getElementById('txtSubmittedOnCC').readOnly = rOnly;
				document.getElementById('txtCustNameCC').readOnly = rOnly;
				document.getElementById('txtOrderNbrCC').readOnly = rOnly;
				document.getElementById('txtInvoiceNbrCC').readOnly = rOnly;
				document.getElementById('txtVendorNameCC').readOnly = rOnly;
				document.getElementById('selRegionCC').disabled = rOnly;
				document.getElementById('selMillLocationCC').disabled = rOnly;
			}
			document.getElementById('txtShipmentNbrCC').readOnly = rOnly;
			document.getElementById('selSalesLeadCC').disabled = rOnly;
			document.getElementById('selGradeCC').disabled = rOnly;
			document.getElementById('selThicknessCC').disabled = rOnly;
			document.getElementById('selSpecieCC').disabled = rOnly;
			document.getElementById('txaMiscInfoCC').readOnly = rOnly;
			document.getElementById('txaCustClaimDesc').readOnly = rOnly;
			document.getElementById('txaCustClaimInvestigation').readOnly = rOnly;
			document.getElementById('txaCustClaimResolution').readOnly = rOnly;
			document.getElementById('radMillErrorY').readOnly = rOnly;
			document.getElementById('radMillErrorN').readOnly = rOnly;

			document.getElementById('txtResolutionDateCC').readOnly = rOnly;
			document.getElementById('txtResolutionAmtCC').readOnly = rOnly;
			return false;
		}

		function ValidateCustClaim() {
			var errors = '';
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtSubmittedByCC', 0, 1, 1, 0, "'!@#$%&.", ""), 'Submitted By'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtSubmittedOnCC', 0, 1, 1, 0, "'!@#$%&.", ""), 'Submitted On'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtCustNameCC', 0, 1, 1, 0, "'!@#$%&.", ""), 'Cust Name'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('selRegionCC', 0, 2, 1, 0, "", ""), 'Region'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('selMillLocationCC', 0, 2, 1, 0, "", ""), 'Mill'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtOrderNbrCC', 0, 0, 0, 0, "'$,.#!%&", ""), 'Order Nbr'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtInvoiceNbrCC', 0, 0, 0, 0, "'$,.#!%&", ""), 'Invoice Nbr'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtShipmentNbrCC', 0, 0, 0, 0, "'$,.#!%&", ""), 'Shipment Nbr'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('selSalesLeadCC', 0, 2, 1, 0, "", ""), 'Salesman/Lead'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txaCustClaimDesc', 0, 1, 1, 0, "", ""), 'Brief Description'));

			if (errors !== '') {errors = '>>Customer Claim Errors:\n' + errors;}
			return errors;
		}

		//#endregion CustomerClaim JS

		// **************************** FORM: Freight Accrual *********************************

		//#region FreightAccrual JS
		function NewFreightAccrual() {
			PopulateSalesStaffListFA();
			PopulateSalesLeadListsFA();
			PopulateReasonListFA();
			PopulateLocationListFA();
			PopulateCreditRepListsFA();
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
			var dtreq = CleanDateValTx(jtRequiredDateE.value);
			var byid = document.getElementById('hfReqByIDFAE').value;
			var stat = jsStatusCode;
			var idt = jhfInvoiceDate.value;
			var crepid = document.getElementById('selCreditRepFAE').value;
			var spid = document.getElementById('selSalesRepFAE').value;
			var slead = document.getElementById('selSalesLeadFAE').value;
			var sfm = document.getElementById('selShipFmLocationFAE').value;
			var rc = document.getElementById('selReasonCodeFAE').value; 
			var cust = document.getElementById('hfCustCodeFAE').value;
			var ctlnbr = document.getElementById('txtCustNbrFAE').value; 
			var cid = 0; //document.getElementById('').value;
			var vend = ''; //document.getElementById('').value;
			var onbr = 0; //document.getElementById('').value;
			var shpnbr = document.getElementById('hfShipNbrFA').value;
			var rdet = StripSingleQuotesTx(document.getElementById('txaReasonForAdjFAE').value);
			var onbr1 = 0;
			var onbr2 = 0; 
			var loc2='';
			var loc3='';
			var set1=0;
			var set2=0;
			var set3=0;
			var set4=0;
			var set5=0;
			var set6=0;
			var amt= parseFloat(CleanNbrValTx(document.getElementById('txtOrigInvoiceAmtFA').value));
			var aiamt= parseFloat(CleanNbrValTx(document.getElementById('txtAdjInvoiceAmtFA').value));
			var aamt = parseFloat(CleanNbrValTx(document.getElementById('txtAdjustmentAmtFA').value));
			var frate = 0;
			var oamt = 0;
			var oval1 = '';
			var oval2 = '';
			var pval1 = '';
			var pval2 = '';
			var pval3 = '';
			var rdate = '';
			var tdate = '';
			var adate1 = '';
			var adate2 = '';
			var tdate1 = '';
			var tdate2 = '';
			var nprod = 0;
			var cmt = StripSingleQuotesTx(jtaGenCommentIAE.value);
			var act = 1;
			var crc = 0;
			UpdateInvRequest(dtreq, byid, stat, idt, crepid, spid, slead, sfm, rc, rdet, cust, ctlnbr, cid, vend, onbr, shpnbr, onbr1, onbr2, loc2, loc3, crc, set1, set2, set3, set4, set5, set6, amt, aiamt, aamt, frate, oamt, oval1, oval2, pval1, pval2, pval3, rdate, tdate, adate1, adate2, tdate1, tdate2, nprod, cmt, act)

			return false;
		}

		function SetFreightAccrualEdit(edt) {
			var rOnly = false;
			if (edt === 0) { rOnly = true;}
			if(jbCanInitiate===false) {
				document.getElementById('txtDateReqFAE').readOnly = true;
				document.getElementById('txtReqByFAE').readOnly = true;
				document.getElementById('txtCustNbrFAE').readOnly = true;
				document.getElementById('txtCustNameFAE').readOnly = true;
				document.getElementById('txtSONbrFAE').readOnly = true;
				document.getElementById('txtInvoiceNbrFAE').readOnly = true;
				document.getElementById('txaReasonForAdjFAE').readOnly = true;
				document.getElementById('txtOrigInvoiceAmtFA').readOnly = true;
				document.getElementById('txtAdjInvoiceAmtFA').readOnly = true;
				document.getElementById('txtAdjustmentAmtFA').readOnly = true;
				document.getElementById('selSalesRepFAE').disabled = true;
				document.getElementById('selCreditRepFAE').disabled = true;
				document.getElementById('selSalesLeadFAE').disabled = true;
				document.getElementById('selShipFmLocationFAE').disabled = true;
				document.getElementById('selReasonCodeFAE').disabled = true;
			}
			else {
				document.getElementById('txtDateReqFAE').readOnly = rOnly;
				document.getElementById('txtReqByFAE').readOnly = rOnly;
				document.getElementById('txtCustNbrFAE').readOnly = rOnly;
				document.getElementById('txtCustNameFAE').readOnly = rOnly;
				document.getElementById('txtSONbrFAE').readOnly = rOnly;
				document.getElementById('txtInvoiceNbrFAE').readOnly = rOnly;
				document.getElementById('txaReasonForAdjFAE').readOnly = rOnly;
				document.getElementById('txtOrigInvoiceAmtFA').readOnly = rOnly;
				document.getElementById('txtAdjInvoiceAmtFA').readOnly = rOnly;
				document.getElementById('txtAdjustmentAmtFA').readOnly = rOnly;
				document.getElementById('selSalesRepFAE').disabled = rOnly;
				document.getElementById('selCreditRepFAE').disabled = rOnly;
				document.getElementById('selSalesLeadFAE').disabled = rOnly;
				document.getElementById('selShipFmLocationFAE').disabled = rOnly;
				document.getElementById('selReasonCodeFAE').disabled = rOnly;
			}
			return false;
		}

		function UpdateTotalAmtFA() {
			var fig1 = 0;
			var fig2 = 0;
			var ttl = 0;
			try {
				fig1 = parseFloat(CleanNbrValTx(document.getElementById('txtOrigInvoiceAmtFA').value));
				fig2 = parseFloat(CleanNbrValTx(document.getElementById('txtAdjInvoiceAmtFA').value));
				ttl = fig2 = fig1;
				document.getElementById('txtAdjustmentAmtFA').value = getNbrStringFormattedTx(ttl, 2, ',', '.', '$', 2);
			}
			catch(ex) {
				alert('You have non-numeric characters in the invoice and adjusted amount fields.');
			}

			return false;
		}

		function ValidateFreightAccrual() {
			var errors = '';
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtReqByFAE', 0, 1, 1, 0, "'!@#$%&.", ""), 'Requested By'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtDateReqFAE', 0, 1, 1, 0, "'!@#$%&.", ""), 'Date Requested'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtCustNameFAE', 0, 1, 1, 0, "'!@#$%&.", ""), 'Customer Name'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('selSalesRepFAE', 0, 2, 1, 0, "", ""), 'Sales Rep'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('selCreditRepFAE', 0, 2, 1, 0, "", ""), 'Credit Rep'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('selSalesLeadFAE', 0, 2, 1, 0, "", ""), 'Sales Lead'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('selShipFmLocationFAE', 0, 2, 1, 0, "", ""), 'Shipped Fm Location'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtOrderNbrFAE', 0, 2, 1, 24, "'$,.#!%&", ""), 'Order Nbr'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtInvoiceNbrFAE', 0, 2, 1, 24, "'$,.#!%&", ""), 'Invoice Nbr'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('selReasonCodeFAE', 0, 2, 1, 24, "", ""), 'Reason Code'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txaReasonForAdjFAE', 0, 1, 1, 300, "", ""), 'Reason For Adjustment'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('hfCustCodeFAE', 0, 2, 1, 24, "", ""), 'Customer Code'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtAdjustmentAmtFA', 0, 2, 1, 0, "'#!%&", ""), 'Total Adjustment Amt'));
			if (errors !== '') {errors = '>>Freight Accrual Errors:\n' + errors;}
			return errors;
		}

		//#endregion FreightAccrual JS

		// **************************** FORM: Inventory Chg *********************************

		//#region InventoryChg JS
		function AddNewInvChgItem() {
			var sRow = '';
			document.getElementById('selLocationIAdjE').value = '0';
			document.getElementById('selProdTypeIAdjE').value = '0';
			document.getElementById('selProdCodeIAdjE').value = '0';
			document.getElementById('txtQtyAdjustmentIAdj').value = '0';
			document.getElementById('txtPcPkgAdjustmentIAdj').value = '0';
			for(var a=1; a<=13; a++) {
				sRow = a.toString();
				if (sRow.length < 2) {sRow = '0' + sRow;}
				ClearDDLOptionsGu('selAttrib' + sRow + 'IAdjE', 1);
				document.getElementById('selAttrib' + sRow + 'IAdjE').value = '0';
			}
			document.getElementById('txaDetailedExplanationIAdj').value = '';
			jdivInventoryChangeItem.style.display = 'block';
		}

		function ChangeIAdjProdType(val) {
			var obj;
			jsProdType = val;
			GetProductList(jsProdType);
			ClearDDLOptionsGu('selProdCodeIAdjE', 1);
			if(!IsContentsNullUndefinedGu(MyProductList)) {
				obj = document.getElementById('selProdCodeIAdjE');
				fillDropDownListGu(MyProductList, obj, 0, 'description', 'product')
			}
			GetProdTypeCodeList(jsProdType, 0, 1);
			ClearDDLOptionsGu('selAttrib01IAdjE', 1);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				obj = document.getElementById('selAttrib01IAdjE');
				fillDropDownListGu(MyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			GetProdTypeCodeList(jsProdType, 0, 2);
			ClearDDLOptionsGu('selAttrib02IAdjE', 1);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				obj = document.getElementById('selAttrib02IAdjE');
				fillDropDownListGu(MyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			GetProdTypeCodeList(jsProdType, 0, 3);
			ClearDDLOptionsGu('selAttrib03IAdjE', 1);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				obj = document.getElementById('selAttrib03IAdjE');
				fillDropDownListGu(MyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			GetProdTypeCodeList(jsProdType, 0, 4);
			ClearDDLOptionsGu('selAttrib04IAdjE', 1);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				obj = document.getElementById('selAttrib04IAdjE');
				fillDropDownListGu(MyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			GetProdTypeCodeList(jsProdType, 0, 5);
			ClearDDLOptionsGu('selAttrib05IAdjE', 1);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				obj = document.getElementById('selAttrib05IAdjE');
				fillDropDownListGu(MyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			GetProdTypeCodeList(jsProdType, 0, 6);
			ClearDDLOptionsGu('selAttrib06IAdjE', 1);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				obj = document.getElementById('selAttrib06IAdjE');
				fillDropDownListGu(MyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			GetProdTypeCodeList(jsProdType, 0, 7);
			ClearDDLOptionsGu('selAttrib07IAdjE', 1);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				obj = document.getElementById('selAttrib07IAdjE');
				fillDropDownListGu(MyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			GetProdTypeCodeList(jsProdType, 0, 8);
			ClearDDLOptionsGu('selAttrib08IAdjE', 1);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				obj = document.getElementById('selAttrib08IAdjE');
				fillDropDownListGu(MyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			GetProdTypeCodeList(jsProdType, 0, 9);
			ClearDDLOptionsGu('selAttrib09IAdjE', 1);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				obj = document.getElementById('selAttrib09IAdjE');
				fillDropDownListGu(MyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			GetProdTypeCodeList(jsProdType, 0, 10);
			ClearDDLOptionsGu('selAttrib10IAdjE', 1);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				obj = document.getElementById('selAttrib10IAdjE');
				fillDropDownListGu(MyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			GetProdTypeCodeList(jsProdType, 0, 11);
			ClearDDLOptionsGu('selAttrib11IAdjE', 1);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				obj = document.getElementById('selAttrib11IAdjE');
				fillDropDownListGu(MyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			GetProdTypeCodeList(jsProdType, 0, 12);
			ClearDDLOptionsGu('selAttrib12IAdjE', 1);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				obj = document.getElementById('selAttrib12IAdjE');
				fillDropDownListGu(MyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			GetProdTypeCodeList(jsProdType, 0, 13);
			ClearDDLOptionsGu('selAttrib13IAdjE', 1);
			if(!IsContentsNullUndefinedGu(MyProdTypeCodeList)) {
				obj = document.getElementById('selAttrib13IAdjE');
				fillDropDownListGu(MyProdTypeCodeList, obj, 0, 'codedesc', 'code')
			}
			return false;
		}

		function CloseInventoryAdjDataEdit() {
			jdivInventoryChangeItem.style.display = 'none';
			return false;
		}

		function EditInvChgItem(id, itm) {
			document.getElementById('hfInvReqLineIDIAdjE').value = id.toString();
			document.getElementById('selLocationIAdjE').value = MyInventoryItemData[itm]['LocCode'].value;
			document.getElementById('hfInvRequestIDIAdjE').value = MyInventoryItemData[itm]['InvoiceRequestID'].value;
			document.getElementById('hfProdDescIAdjE').value = MyInventoryItemData[itm]['ItemDescription'].value;
			document.getElementById('hfItemNbrIAdjE').value = MyInventoryItemData[itm]['ItemNbr'].value;
			document.getElementById('selProdTypeIAdjE').value = MyInventoryItemData[itm]['ProdTypeCode'].value;
			document.getElementById('selProdCodeIAdjE').value = MyInventoryItemData[itm]['ProdCode'].value;
			document.getElementById('txtQtyAdjustmentIAdj').value = MyInventoryItemData[itm]['RevisedQty'].value;
			document.getElementById('hfQtyAdjOrigIAdj').value = MyInventoryItemData[itm]['OriginalQty'].value;
			document.getElementById('txtPcPkgAdjustmentIAdj').value = MyInventoryItemData[itm]['RevisedQty2'].value;
			document.getElementById('hfPkgAdjOrigIAdj').value = MyInventoryItemData[itm]['OriginalQty2'].value;
			document.getElementById('selAttrib01IAdjE').value = MyInventoryItemData[itm]['attribute01'].value;
			document.getElementById('selAttrib02IAdjE').value = MyInventoryItemData[itm]['attribute02'].value;
			document.getElementById('selAttrib03IAdjE').value = MyInventoryItemData[itm]['attribute03'].value;
			document.getElementById('selAttrib04IAdjE').value = MyInventoryItemData[itm]['attribute04'].value;
			document.getElementById('selAttrib05IAdjE').value = MyInventoryItemData[itm]['attribute05'].value;
			document.getElementById('selAttrib06IAdjE').value = MyInventoryItemData[itm]['attribute06'].value;
			document.getElementById('selAttrib07IAdjE').value = MyInventoryItemData[itm]['attribute07'].value;
			document.getElementById('selAttrib08IAdjE').value = MyInventoryItemData[itm]['attribute08'].value;
			document.getElementById('selAttrib09IAdjE').value = MyInventoryItemData[itm]['attribute09'].value;
			document.getElementById('selAttrib10IAdjE').value = MyInventoryItemData[itm]['attribute10'].value;
			document.getElementById('selAttrib11IAdjE').value = MyInventoryItemData[itm]['attribute11'].value;
			document.getElementById('selAttrib12IAdjE').value = MyInventoryItemData[itm]['attribute12'].value;
			document.getElementById('selAttrib13IAdjE').value = MyInventoryItemData[itm]['attribute13'].value;
			document.getElementById('txaDetailedExplanationIAdj').value = MyInventoryItemData[itm - 1][''].value;
			jdivInventoryChangeItem.style.display = 'block';
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

		function NewInventoryChange() {
			PopulateLocationListsIC();
			PopulateProdTypeListsIC();
			document.getElementById('hfInvRequestIDIC').value = '0';
			PopulateInventoryChgItems();
			GetInvoiceItems(jsDocType);
			jdivInventoryChangeReq.style.display = 'block';
			return false;
		}

		function RemoveInvChgItem(itm) {
			var lid = parseInt(document.getElementById('hfInvReqLindIDIAdjE').value, 10);
			var inbr = parseInt(document.getElementById('hfItemNbrIAdjE').value, 10);
			DeleteInvRequestLine(lid, inbr);

			return false;
		}

		function SaveInvChangeHdr() {
			var dtreq = document.getElementById('txtSubmittedOnCC').value;
			var byid = parseInt(document.getElementById('hfSubmittedByIDCC').value, 10);
			var stat = jsStatusCode;
			var idt = '';
			var crepid = '0'; 
			var spid = '0';
			var slead = '0';
			var sfm = '0';
			var rc = '0';
			var cust = '0'; 
			var ctlnbr = '';
			var cid = '';
			var vend =''; 
			var onbr = 0;  
			var shpnbr = '0';
			var onbr1 = '';
			var onbr2 = '';
			var loc2='';
			var loc3='';
			var set1=0;
			var set2=0;
			var set3=0;
			var set4=0;
			var set5=0;
			var set6=0;
			var amt = 0;
			var aiamt= 0;
			var aamt = 0; 
			var frate = 0;
			var oamt = 0;
			var oval1 = '';
			var oval2 = '';
			var pval1 = ''; 
			var pval2 = ''; 
			var pval3 = ''; 
			var rdate = '';
			var tdate = '';
			var adate1 = '';
			var adate2 = '';
			var tdate1 = '';
			var tdate2 = '';
			var nprod = 0;
			var cmt = PrepareJSONForHTMLTx(jtaGenCommentIAE.value, 1);
			var act = 1;
			var rdet = PrepareJSONForHTMLTx(document.getElementById('txaMiscInfoCC').value, 1);
			var crc = 0;
			var val = '';
			alert('Ready to save IChg invoicereq');
			UpdateInvRequest(dtreq, byid, stat, idt, crepid, spid, slead, sfm, rc, rdet, cust, ctlnbr, cid, vend, onbr, shpnbr, onbr1, onbr2, loc2, loc3, crc, set1, set2, set3, set4, set5, set6, amt, aiamt, aamt, frate, oamt, oval1, oval2, pval1, pval2, pval3, rdate, tdate, adate1, adate2, tdate1, tdate2, nprod, cmt, act);
			return false;
		}

		function SaveInvChangeLine() {
			var lnid = parseInt(document.getElementById('lblInvChgEditIDE').innerHTML, 10);
			var inbr = parseInt(document.getElementById('hfItemNbrIAdjE').value, 10);
			var ptype = document.getElementById('selProdTypeIAdjE').value;
			var ddl = document.getElementById('selProdCodeIAdjE');
			var pcode = ddl.value;
			var desc = getSelectedTextByIndexGu('selProdCodeIAdjE', ddl.selectedIndex);
			var a1 = StripSingleQuotesTx(document.getElementById('selAttrib01IAdjE').value);
			var a2 = StripSingleQuotesTx(document.getElementById('selAttrib02IAdjE').value);
			var a3 = StripSingleQuotesTx(document.getElementById('selAttrib03IAdjE').value);
			var a4 = StripSingleQuotesTx(document.getElementById('selAttrib04IAdjE').value);
			var a5 = StripSingleQuotesTx(document.getElementById('selAttrib05IAdjE').value);
			var a6 = StripSingleQuotesTx(document.getElementById('selAttrib06IAdjE').value);
			var a7 = StripSingleQuotesTx(document.getElementById('selAttrib07IAdjE').value);
			var a8 = StripSingleQuotesTx(document.getElementById('selAttrib08IAdjE').value);
			var a9 = StripSingleQuotesTx(document.getElementById('selAttrib09IAdjE').value);
			var a10 = StripSingleQuotesTx(document.getElementById('selAttrib10IAdjE').value);
			var a11 = StripSingleQuotesTx(document.getElementById('selAttrib11IAdjE').value);
			var a12 = StripSingleQuotesTx(document.getElementById('selAttrib12IAdjE').value);
			var a13 = StripSingleQuotesTx(document.getElementById('selAttrib13IAdjE').value);
			var oqty = parseFloat(document.getElementById('hfQtyAdjOrig').value);
			var oqty2 = parseFloat(document.getElementById('hfPkgAdjOrig').value);
			var rqty = parseFloat(CleanNbrValTx(document.getElementById('txtQtyAdjustment').value));
			var rqty2 = parseFloat(CleanNbrValTx(document.getElementById('txtPcPkgAdjustment').value));
			UpdateInvReqLine(lnid, inbr, ptype, pcode, desc, Attribs, oqty, oqty2, rqty, rqty2, oprice, rprice, crdbamt, ia, rtag, rtnqty, rpkg, qchkin, tkt, expl, loc, rtn, act);
			jdivInventoryChangeItem.style.display = 'none';
			Get
			return false;
		}
		
		function SetInvChangeEdit(edt) {
			var rOnly = false;
			if (edt === 0) { rOnly = true;}
			// nothing to do
		}

		function ValidateInventoryChange() {
			var errors = '';
			var errors = '';
			for(var row=0; row<jiNbrLinesInventoryAdj; row++) {
				errors = errors.concat(GetErrorType(ValidateStringFieldTx('selLocationIAdjE' + row.toString(), 0, 1, 1, 0, "", ""), 'Location Line ' + (row+1).toString()));
				errors = errors.concat(GetErrorType(ValidateStringFieldTx('selProdTypeIAdjE' + row.toString(), 0, 1, 1, 0, "", ""), 'Prod Type Line ' + (row+1).toString()));
				errors = errors.concat(GetErrorType(ValidateStringFieldTx('selProdCodeIAdjE' + row.toString(), 0, 1, 1, 0, "'!@#$%&.", ""), 'Prod Code Line ' + (row+1).toString()));
				errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtDetailedExplaination', 0, 1, 1, 300, "'&", ""), 'Detailed Explanation Line ' + (row+1).toString()));
				if((document.getElementById('txtQtyAdjustment'+row.toString()).value==='0'||document.getElementById('txtQtyAdjustment'+row.toString()).value==='')&&(document.getElementById('txtPcPkgAdjustmentIAdj'+row.toString()).value==='0'||document.getElementById('txtPcPkgAdjustmentIAdj'+row.toString()).value==='')) {
					errors = errors.concat('No value entered for line ' + (row+1).toString() + '.\n');
				}
			}
			if (errors !== '') {errors = '>>Inventory Change Errors:\n' + errors;}
			return errors;
		}

		//#endregion InventoryChg JS

		// **************************** FORM: Invoice Adjustment *********************************

		//#region InvoiceAdjManf JS

		function ChangeIALineItem(line) {
			var flineA = 0;
			var flineO = 0;
			var PriceA = 0;
			var PriceO = 0;
			var QtyA = 0;
			var QtyO = 0;
			var ttlO = 0;
			var ttlA = 0;
			var ttlG = 0;
			try {
				for(var row=1; row<=jiNbrLinesShownIA; row++) {
					QtyO = parseFloat(CleanNbrValTx(document.getElementById('txtOrigQty' + row.toString()).value));
					QtyA = parseFloat(CleanNbrValTx(document.getElementById('txtRevQty' + row.toString()).value));
					PriceO = parseFloat(CleanNbrValTx(document.getElementById('txtOrigPrice' + row.toString()).value));
					PriceA = parseFloat(CleanNbrValTx(document.getElementById('txtRevPrice' + row.toString()).value));
					flineO = QtyO * PriceO;
					ttlO += flineO;
					ttlA += flineA;
					flineA = QtyA * PriceA;
					document.getElementById('txtTotalAmountO'+row.toString()).value = getNbrStringFormattedTx(flineO, 2, ',', '.', '$', 2);
					document.getElementById('txtTotalAmountA'+row.toString()).value = getNbrStringFormattedTx(flineA, 2, ',', '.', '$', 2);
				}
				jfInvoiceAmtOrig = ttlO;
				jfInvoiceAmtNew = ttlA;
				ttlG = ttlA - ttlO;
				document.getElementById('txtOrigInvoiceAmt').value = getNbrStringFormattedTx(jfInvoiceAmtOrig, 2, ',', '.', '$', 2);
				document.getElementById('txtAdjInvoiceAmt').value = getNbrStringFormattedTx(jfInvoiceAmtNew, 2, ',', '.', '$', 2);
				document.getElementById('txtAdjustmentAmt').value = getNbrStringFormattedTx(ttlG, 2, ',', '.', '$', 2);
			}
			catch(ex) {
				alert('You have non-numeric values in numeric columns for Invoice Adjustment product data.');
			}
			return false;
		}

		function NewInvAdjSection() {
			var sRow = '';
			jiNbrProdsIA = 5;
			jbShowInvAdj = false;
			PopulateCreditRepLists();
			PopulateSalesLeadLists();
			PopulateLocationLists();
			PopulateSalesLeadLists();
			PopulateSalesStaffLists();
			PopulateReasonList();
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
			ShowOnePortion(2);
			jdivInvAdjManifest.style.display = 'block';
			ChangeInvAdjManifestView(2, 1);
			SetTextBoxAutoComplete2Wc('txtCustNameE', 3, jhfCustCodeE, MyCustomerData, 'cust', 'CustName');
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
			jiInvoiceReqID=parseInt(document.getElementById('hfInvAdjIDE').value, 10);
			var aamt = jfInvoiceAdjAmount;
			var aiamt = jfInvoiceAmtNew;
			var amt = jfInvoiceAmtOrig;
			var byid = parseInt(document.getElementById('hfReqByIDE').value, 10);
			var cmt = jtaGenCommentIAE.value;
			var ctlnbr=document.getElementById('txtCustNbrE').value;
			var crc = 0;
			var crepid = parseInt(jselCreditRepE.value, 10);
			var cust = jhfCustCodeE.value;
			var dtreq = CleanDateValTx(document.getElementById('txtDateReqE').value);
			var ia = 1;
			var id = document.getElementById('hfInvAdjIDE').value;
			var idt= jhfInvoiceDate.value;
			var mannt = 0; //
			var nprod = jiNbrLinesShownIA;
			var oamt = jfInvoiceAmtOrig;
			var onbr = CleanNbrValTx(document.getElementById('txtSONbrE').value);
			var rc = jselReasonCodeE.value;
			var rdet = PrepareJSONForSpecialHTMLTx(jtaReasonForAdjE.value, 0); 
			var rdate = CleanDateValTx(jtRequiredDateE.value);
			var rdet = document.getElementById('txaReasonForAdjE').toString();
			var shpnbr = document.getElementById('hfShipNbrIA').toString();
			var spid = parseInt(jselSalesRepE.value, 10);
			var slead = jselSalesLeadE.value;
			var sfm = jselShipFmLocationE.value;
			var stat=jselSetNewStatus.value;
			var onbr = jiOrderNbr;
			var crc = 0;
			if(jchkCustReqCopyE.checked === true) { crc = 1; }
			UpdateInvRequest(dtreq, byid, stat, idt, crepid, spid, slead, sfm, rc, rdet, cust, ctlnbr, 0, '', onbr, shpnbr, 0, 0, '', '', crc, 0, 0, 0, 0, 0, 0, amt, aiamt, aamt,0, 0, '', '', '', '', '', rdate, '', '', '', '', '', jiNbrLinesShownIA, cmt, 1);
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
					var pcode = CleanTextToSecureTx(document.getElementById('txtProdCode' + rw).value);
					var desc = document.getElementById('txtProdDesc' + rw).value;
					var oqty = parseFloat(CleanNbrValTx(document.getElementById('txtOrigQty' + rw).value));
					var oqty2 = 0;
					var rqty = parseFloat(CleanNbrValTx(document.getElementById('txtRevQty' + rw).value));
					var rqty2 = 0;
					var oprice = parseFloat(CleanNbrValTx(document.getElementById('txtOrigPrice' + rw).value));
					var rprice = parseFloat(CleanNbrValTx(document.getElementById('txtRevPrice' + rw).value));
					var crdbamt = 0;
					var Attribs = document.getElementById('hfIAItemAttribs' + row.toString()).value;
					UpdateInvReqLine(lnid, inbr, ptype, pcode, desc, Attribs, oqty, oqty2, rqty, rqty2, oprice, rprice, crdbamt, 0, 0, rtnqty, 0, 0, '', '', '', 0, 1);
				}
			}
			return false;
		}

		function SetInvoiceAdjEdit(edt) {
			var rOnly = false;
			if (edt === 0) { rOnly = true;}
			if(jbCanInitiate===false) {
				document.getElementById('txtDateReqE').readOnly = true;
				document.getElementById('txtReqByE').readOnly = true;
				document.getElementById('txtCustNbrE').readOnly = true;
				document.getElementById('txtCustNameE').readOnly = true;
				document.getElementById('txtSONbrE').readOnly = true;
				document.getElementById('txtInvoiceNbrE').readOnly = true;
				document.getElementById('txtOrigInvoiceAmt').readOnly = true;
				document.getElementById('txtAdjInvoiceAmt').readOnly = true;
				document.getElementById('txtAdjustmentAmt').readOnly = true;
				document.getElementById('selSalesRepE').disabled = true;
				document.getElementById('selCreditRepE').disabled = true;
				document.getElementById('selSalesLeadE').disabled = true;
				document.getElementById('selShipFmLocationE').disabled = true;
				document.getElementById('selReasonCodeE').disabled = true;
				document.getElementById('chkCustReqCopyE').disabled = true;
			}
			else {
				document.getElementById('txtDateReqE').readOnly = rOnly;
				document.getElementById('txtReqByE').readOnly = rOnly;
				document.getElementById('txtCustNbrE').readOnly = rOnly;
				document.getElementById('txtCustNameE').readOnly = rOnly;
				document.getElementById('txtSONbrE').readOnly = rOnly;
				document.getElementById('txtInvoiceNbrE').readOnly = rOnly;
				document.getElementById('txtOrigInvoiceAmt').readOnly = rOnly;
				document.getElementById('txtAdjInvoiceAmt').readOnly = rOnly;
				document.getElementById('txtAdjustmentAmt').readOnly = rOnly;
				document.getElementById('selSalesRepE').disabled = rOnly;
				document.getElementById('selCreditRepE').disabled = rOnly;
				document.getElementById('selSalesLeadE').disabled = rOnly;
				document.getElementById('selShipFmLocationE').disabled = rOnly;
				document.getElementById('selReasonCodeE').disabled = rOnly;
				document.getElementById('chkCustReqCopyE').disabled = rOnly;
			}
			return false;
		}

		function ValidateInvAdj() {
			var errors = '';
			var sRow = '';
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtDateReqE', 0, 1, 1, 0, "'!@#$%&.", ""), 'Date Requested'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtReqByE', 0, 1, 1, 0, "'!@#$%&.", ""), 'Requested By'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('selSalesRepE', 0, 2, 1, 0, "", ""), 'Sales Rep'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('selCreditRepE', 0, 2, 1, 0, "", ""), 'Credit Rep'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('selSalesLeadE', 0, 2, 1, 0, "", ""), 'Sales Lead'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('selShipFmLocationE', 0, 2, 1, 0, "", ""), 'Shipped Fm Location'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtCustNameE', 0, 1, 1, 0, "'!@#$%&.", ""), 'Customer Name'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtOrderNbrE', 0, 2, 1, 24, "'$,.#!%&", ""), 'Order Nbr'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtInvoiceNbrE', 0, 2, 1, 24, "'$,.#!%&", ""), 'Invoice Nbr'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('selReasonCodeE', 0, 2, 1, 24, "", ""), 'Reason Code'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txaReasonForAdjE', 0, 1, 1, 300, "", ""), 'Reason For Adjustment'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('hfCustCodeE', 0, 2, 1, 24, "", ""), 'Customer Code'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtAdjustmentAmt', 0, 2, 1, 0, "'#!%&", ""), 'Total Adjustment Amt'));
			for(var row=1; row<=jiNbrLinesShownIA; row++) {
				sRow = row.toString();
				errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtProdType' + sRow, 0, 2, 1, 0, "'#!%&$_", ""), 'ProdType Line ' + sRow));
				errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtProdCode' + sRow, 0, 2, 1, 0, "'#!%&4_", ""), 'ProdCode Line ' + sRow));
				errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtProdDesc' + sRow, 0, 2, 1, 0, "'#!%&$_", ""), 'ProdDesc Line ' + sRow));
				errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtOrigQty' + sRow, 0, 2, 1, 0, "'#!%&$_", ""), 'Original Qty Line ' + sRow));
				errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtRevQty' + sRow, 0, 2, 1, 0, "'#!%&$_", ""), 'Revised Qty Line ' + sRow));
				errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtOrigPrice' + sRow, 0, 2, 1, 0, "'#!%&$_", ""), 'Original Price Line ' + sRow));
				errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtRevPrice' + sRow, 0, 2, 1, 0, "'#!%&$_", ""), 'Revised Price Line ' + sRow));
				//if (sRow.length < 2) {sRow = '0' + sRow;}
			}
			if (errors !== '') {errors = '>>Invoice Adjustment Errors:\n' + errors;}
			return errors;
		}

		//#endregion InvoiceAdjManf JS

		// **************************** FORM: LossDamage *********************************

		//#region LossDamage JS
		function AddLossDamageItem() {

		}

		function ChangeTotalClaimAmt() {
			var fig = 0;
			var sRow = '';
			var ttl = 0;
			try {
				for(var row=1; row<=jiNbrLinesLAD; row++) {
					sRow = row.toString();
					if (sRow.length < 2) {sRow = '0' + sRow;}
					fig = parseFloat(CleanNbrValTx(document.getElementById('txtAmountLAD' + sRow).value));
					ttl += fig;
				}
				document.getElementById('txtAmountLAndD').value = getNbrStringFormattedTx(ttl, 2, ',', '.', '$', 1);
			}
			catch(ex) {
				alert('Item amount fields contain non-numeric values');
			}
			return false;
		}

		function EditAttributesLAD(row) {
			var sRow=row.toString();
			if(sRow.length<2) { sRow='0'+sRow;}
			var pt = document.getElementById('selProdTypeLAD' + sRow.toString()).value;
			LoadAttributeArray(document.getElementById('hfLADItemAttribs' + row.toString()).value);
			ShowAttributesEdit('LSSDMG', pt, row);
			ReloadRequest();
		}

		function NewLossAndDamageClaim() {
			PopulateLossDmgCodes();
			PopulateProdTypeListsLAD();
			document.getElementById('txaGenCommentIAE').value = '';
			document.getElementById('txtLADTransDate').value = jsToday;
			document.getElementById('txtCustomerLAndD').value = '';
			SetTextBoxAutoComplete2Wc('txtCustomerLAndD', 3, jhfCustCodeLAD, MyCustomerData, 'cust', 'CustName');
			createDatePickerOnTextWc('txtLADTransDate', null, null, 0, 3, 'show', 11);
			jselNbrTypeLAndD.value = '0';
			document.getElementById('txtControlNbrLAndD').value = '';
			document.getElementById('txtCustNbrLAD').value = '';
			PopulateLossDamageLines();
			jdivLossAndDamageClaim.style.display = 'block';
			return false;
		}

		function RemoveLADItem(itm) {
			var lid = parseInt(document.getElementById('hfLineIDLAD' + itm.toString()).value, 10);
			var inbr = parseInt(document.getElementById('hfItemNbrLAD' + itm.toString()).value, 10);
			DeleteInvRequestLine(lid, inbr);
			GetInvoiceItems(jsDocType);
			PopulateInvoiceLineData();
			return;
		}

		function SaveLADItem(row)    {
			if (SaveLADData()) {
				var sRow = '';
				var srw = '';
				srw = row.toString();
				sRow = srw;
				if(sRow.length < 2) { sRow = '0' + sRow;}
				var Attribs = document.getElementById('hfLADItemAttribs' + row.toString()).value;
				var desc = document.getElementById('hfLADProdDesc' + row.toString()).value;
				var expl = CleanTextMinimalTx(document.getElementById('txtLineCommentsLAD' + sRow).value, 1);
				var inbr = parseInt(document.getElementById('hfItemNbrLAD' + srw), 10);
				var lnid = parseInt(document.getElementById('hfLineIDLAD').value, 10);
				var oqty = parseFloat(document.getElementById('hfOrigAmtLAD' + srw));
				var pcode = document.getElementById('txtProdCodeLAD' + sRow).toString();;
				var ptype = document.getElementById('selProdTypeLAD' + sRow).toString(); 
				var Qty = parseFloat(CleanNbrValTx(document.getElementById('txtAmountLAD' + sRow)));
				var expl = '';
				var loc = '';
				UpdateInvReqLine(lnid, inbr, ptype, pcode, desc, Attribs, oqty, 0, Qty, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', expl, loc, 0, 1);
			}
			return false;
		}

		function SaveLADData() {
			var dtreq =  CleanDateValTx(jtSubmittedOnHDR.value);
			var byid = jhfSubmittedByIDHDR.value;
			var stat = jsStatusCode;
			var idt = jhfInvoiceDate.value;
			var crepid = 0;
			var spid = 0;
			var slead = '';
			var sfm = '';
			var rc = document.getElementById('selLossDmgClass').value;
			var cust = document.getElementById('hfCustCodeLAD').value;
			var ctlnbr = document.getElementById('txtCustNbrLAD').value;
			var cid = 0;
			var vend = '';
			var onbr = jiOrderNbr;
			var shpnbr = document.getElementById('hfShipNbrLAD').value;
			var onbr1 = parseInt(document.getElementById('selNbrTypeLAndD').value, 10);
			var onbr2 = parseInt(CleanNbrValTx(document.getElementById('txtControlNbrLAndD').value), 10);
			var loc2='';
			var loc3='';
			var set1=0;
			var set2=0;
			var set3=0;
			var set4=0;
			var set5=0;
			var set6=0;
			var amt= 0 
			var aiamt=0;
			var aamt = parseFloat(CleanNbrValTx(document.getElementById('txtAmountLAndD').value));
			var frate = 0;
			var oamt = 0;
			var oval1 = '';
			var oval2 = '';
			var pval1 = '';
			var pval2 = '';
			var pval3 = '';
			var rdate = '';
			var tdate = '';
			var adate1 = '';
			var adate2 = '';
			var tdate1 = '';
			var tdate2 = '';
			var nprod = jiNbrLinesLAD;
			var cmt = StripSingleQuotesTx(jtaGenCommentIAE.value);
			var act = 1;
			var rdet = '';
			var crc = 0;
			UpdateInvRequest(dtreq, byid, stat, idt, crepid, spid, slead, sfm, rc, rdet, cust, ctlnbr, cid, vend, onbr, shpnbr, onbr1, onbr2, loc2, loc3, crc, set1, set2, set3, set4, set5, set6, amt, aiamt, aamt, frate, oamt, oval1, oval2, pval1, pval2, pval3, rdate, tdate, adate1, adate2, tdate1, tdate2, nprod, cmt, act)
			return true; 
		}

		function SaveLossDamageLines() {
			var Attribs = '';
			var desc = '';
			var expl = '';
			var inbr = 0;
			var lnid = 0;
			var loc = '';
			var oqty = 0;
			var pcode = '';
			var ptype = '';
			var Qty = 0;
			var sRow = '';
			var srw = '';
			if(jiNbrLinesLAD > 0) {
				for(var row = 1; row <= jiNbrLinesLAD; row++) {
					srw = row.toString();
					sRow = srw;
					if(sRow.length < 2) { sRow = '0' + sRow; }
					Attribs = document.getElementById('hfLADItemAttribs' + srw).toString();
					lnid = parseInt(document.getElementById('hfLineIDLAD' + srw), 10);
					inbr = parseInt(document.getElementById('hfItemNbrLAD' + srw), 10);
					Qty = parseFloat(document.getElementById('txtAmountLAD' + sRow));
					oqty = parseFloat(document.getElementById('hfOrigAmtLAD' + srw));
					ptype = document.getElementById('selProdTypeLAD' + sRow).toString();
					pcode = document.getElementById('txtProdCodeLAD' + sRow).toString();
					desc = document.getElementById('txtLADProdDesc' + sRow).toString();
					expl = document.getElementById('txtLineCommmentsLAD' + sRow).toString();
					loc = '';
					UpdateInvReqLine(lnid, inbr, ptype, pcode, desc, Attribs, oqty, 0, Qty, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', expl, loc, 0, 1);
				}
			}
			return false;
		}
		
		function SetLossDamageEdit(edt) {
			var rOnly = false;
			if (edt === 0) { rOnly = true;}
			if(jbCanInitiate===false) {
				document.getElementById('txtLADTransDate').readOnly = true;
				document.getElementById('txtCustomerLAndD').readOnly = true;
				document.getElementById('txtControlNbrLAndD').readOnly = true;
				document.getElementById('txtCustNbrLAD').readOnly = true;
				document.getElementById('txtAmountLAndD').readOnly = true;
				document.getElementById('selNbrTypeLAndD').disabled = true;
				document.getElementById('selLossDmgClass').disabled = true;
			}
			else {
				document.getElementById('txtLADTransDate').readOnly = rOnly;
				document.getElementById('txtCustomerLAndD').readOnly = rOnly;
				document.getElementById('txtControlNbrLAndD').readOnly = rOnly;
				document.getElementById('txtCustNbrLAD').readOnly = rOnly;
				document.getElementById('txtAmountLAndD').readOnly = rOnly;
				document.getElementById('selNbrTypeLAndD').disabled = rOnly;
				document.getElementById('selLossDmgClass').disabled = rOnly;
			}
			return false;
		}

		function ValidateLossAndDamage() {
			var errors = '';
			var sRow = '';
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtLADTransDate', 0, 1, 1, 0, "'!@#$%&.", ""), 'Date Requested'));

			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtReqByE', 0, 1, 1, 0, "'!@#$%&.", ""), 'Requested By'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('selSalesRepE', 0, 2, 1, 0, "", ""), 'Sales Rep'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('selCreditRepE', 0, 2, 1, 0, "", ""), 'Credit Rep'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('selSalesLeadE', 0, 2, 1, 0, "", ""), 'Sales Lead'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('selShipFmLocationE', 0, 2, 1, 0, "", ""), 'Shipped Fm Location'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtCustNameE', 0, 1, 1, 0, "'!@#$%&.", ""), 'Customer Name'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtOrderNbrE', 0, 2, 1, 24, "'$,.#!%&", ""), 'Order Nbr'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtInvoiceNbrE', 0, 2, 1, 24, "'$,.#!%&", ""), 'Invoice Nbr'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('selReasonCodeE', 0, 2, 1, 24, "", ""), 'Reason Code'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txaReasonForAdjE', 0, 1, 1, 300, "", ""), 'Reason For Adjustment'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('hfCustCodeE', 0, 2, 1, 24, "", ""), 'Customer Code'));
			errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtAdjustmentAmt', 0, 2, 1, 0, "'#!%&", ""), 'Total Adjustment Amt'));
			for(var row=1; row<=jiNbrLinesShownIA; row++) {
				sRow = row.toString();
				errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtProdType' + sRow, 0, 2, 1, 0, "'#!%&$_", ""), 'ProdType Line ' + sRow));
				errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtProdCode' + sRow, 0, 2, 1, 0, "'#!%&4_", ""), 'ProdCode Line ' + sRow));
				errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtProdDesc' + sRow, 0, 2, 1, 0, "'#!%&$_", ""), 'ProdDesc Line ' + sRow));
				errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtOrigQty' + sRow, 0, 2, 1, 0, "'#!%&$_", ""), 'Original Qty Line ' + sRow));
				errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtRevQty' + sRow, 0, 2, 1, 0, "'#!%&$_", ""), 'Revised Qty Line ' + sRow));
				errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtOrigPrice' + sRow, 0, 2, 1, 0, "'#!%&$_", ""), 'Original Price Line ' + sRow));
				errors = errors.concat(GetErrorType(ValidateStringFieldTx('txtRevPrice' + sRow, 0, 2, 1, 0, "'#!%&$_", ""), 'Revised Price Line ' + sRow));
				//if (sRow.length < 2) {sRow = '0' + sRow;}
			}
			if (errors !== '') {errors = '>>Invoice Adjustment Errors:\n' + errors;}
			return errors;
		}

		//#endregion LossDamage JS

		// **************************** FORM: MAC Adjust *********************************

		//#region MACAdjust JS
		function AddNewMACLine() {
			AddLineToTable('MACADJ', jiNbrLinesMAC);
			return false;
		}

		function ChangeCorrectMAC(typ, line, val) {
			var fig1 = parseFloat(CleanNbrValTx(document.getElementById('txtCurrentMACA' + line.toString()).value));
			var fig2 = parseFloat(CleanNbrValTx(document.getElementById('txtCorrectMACA' + line.toString()).value));
			var dif = fig2 - fig1;
			document.getElementById('txtMACDifference' + line.toString()).value = getNbrStringFormattedTx(dif, 2, ',', '.', '', 2);
			return false;
		}

		function ChangeProductMAC(typ, row) {
			// load desc
			var pt = document.getElementById('').value;
			var pt = document.getElementById('').value;
			GetProductData(0, 0,  pt, pcode)

		}

		function EditAttributesMAC(row) {
			var pt = document.getElementById('selProdTypeMACA' + row.toString()).value;
			LoadAttributeArray(document.getElementById('hfMACItemAttribs' + row.toString()).value);
			ShowAttributesEdit('MACADJ', pt, row);
			ReloadRequest();
			return false;
		}

		function NewMACAdjustment() {
			PopulateLocationListsMA();
			PopulateProdTypeListsMA();
			document.getElementById('txtProdCodeMACA1').value = '';
			document.getElementById('selLocationMACA1').value = '';
			document.getElementById('txtCostIDMACA1').value = '';
			document.getElementById('txtCurrentMACA1').value = '';
			document.getElementById('txtCorrectMACA1').value = '';
			document.getElementById('txtMACCostID1').value = '';
			jiNbrLinesMAC = 1;
			InitiateMACAdjustLines();
			jdivMACAdjustment.style.display = 'block';
			return false;
		}

		function RemoveMACItem(row) {


			return false;
		}

		function SaveMACAdjustData() {
			var dtreq =  CleanDateValTx(jtSubmittedOnHDR.value);
			var byid = jhfSubmittedByIDHDR.value;
			var stat = jsStatusCode;
			var idt = jhfInvoiceDate.value;
			var crepid = 0;
			var spid = 0;
			var slead = '';
			var sfm = '';
			var rc = '0'; 
			var cust = '';
			var ctlnbr = '';
			var cid = 0;
			var vend = '';
			var onbr = jiOrderNbr;
			var shpnbr = '';
			var onbr1 = 0; 
			var onbr2 = 0; 
			var loc2='';
			var loc3='';
			var set1=0;
			var set2=0;
			var set3=0;
			var set4=0;
			var set5=0;
			var set6=0;
			var amt= 0; 
			var aiamt=0;
			var aamt = 0;
			for(var row=1; row<=jiNbrLinesMAC; row++) {
				amt += parseFloat(CleanNbrValTx(document.getElementById('txtCurrentMACA' + row.toString()).value));
				aamt += parseFloat(CleanNbrValTx(document.getElementById('txtCorrectMACA' + row.toString()).value));
			}
			var frate = 0;
			var oamt = 0;
			var oval1 = '';
			var oval2 = '';
			var pval1 = '';
			var pval2 = '';
			var pval3 = '';
			var rdate = '';
			var tdate = '';
			var adate1 = '';
			var adate2 = '';
			var tdate1 = '';
			var tdate2 = '';
			var nprod = jiNbrLinesMAC;
			var cmt = StripSingleQuotesTx(jtaGenCommentIAE.value);
			var act = 1;
			var rdet = '';
			var crc = 0;
			UpdateInvRequest(dtreq, byid, stat, idt, crepid, spid, slead, sfm, rc, rdet, cust, ctlnbr, cid, vend, onbr, shpnbr, onbr1, onbr2, loc2, loc3, crc, set1, set2, set3, set4, set5, set6, amt, aiamt, aamt, frate, oamt, oval1, oval2, pval1, pval2, pval3, rdate, tdate, adate1, adate2, tdate1, tdate2, nprod, cmt, act)
			return false;
		}
		
		function SaveMACAdjustLines() {
			var Attribs = '';
			var desc = '';
			var expl = '';
			var inbr = 0;
			var lnid = 0;
			var loc = '';
			var oqty = 0;
			var pcode = '';
			var ptype = '';
			var Qty = 0;
			var sRow = '';
			var srw = '';
			if(jiNbrLinesMAC > 0) {
				for(var row = 1; row <= jiNbrLinesMAC; row++) {
					srw = row.toString();
					sRow = srw;
					if(sRow.length < 2) { sRow = '0' + sRow; }
					Attribs = document.getElementById('hfMACItemAttribs' + srw).toString();
					lnid = parseInt(document.getElementById('hfLineIDMACAE' + srw), 10);
					inbr = parseInt(document.getElementById('hfItemNbrMACAE' + srw), 10);
					Qty = parseFloat(CleanNbrValTx(document.getElementById('txtCorrectMACA' + srw)));
					oqty = parseFloat(CleanNbrValTx(document.getElementById('txtCurrentMACA' + srw)));
					ptype = document.getElementById('selProdTypeMACA' + srw).toString();
					pcode = StripSingleQuotesTx(document.getElementById('txtProdCodeMACA' + srw).toString());
					desc = StripSingleQuotesTx(document.getElementById('txtProdDescMACA' + srw).toString());
					expl = StripSingleQuotesTx(document.getElementById('txtMACReason' + srw).toString());
					loc = document.getElementById('selLocationMACA' + srw).toString();;
					UpdateInvReqLine(lnid, inbr, ptype, pcode, desc, Attribs, oqty, 0, Qty, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', expl, loc, 0, 1);
				}
			}
			return false;
		}
		
		function SetMACAdjustEdit(edt) {
			var rOnly = false;
			if (edt === 0) { rOnly = true;}
			//if(jbCanInitiate===false) {
			//}
			//else {
			//}
			return false;
		}

		function ValidateMaCAdjust() {
			var errors = '';
 			//val = 
			//if (ValidateNumericStringTx(txt) === false && val !== '') { errors = errors.concat'Emails to Include data is not in the correct format.\n');}




			if (errors !== '') {errors = '>>MAC Adjust Errors:\n' + errors;}
			return errors;
		}

		//#endregion MACAdjust JS

		// **************************** FORM: Manual Credit *********************************

		//#region ManualCredit JS
		function NewManualCredit() {
			PopulateSalesStaffListMC();
			PopulateSalesLeadListsMC();
			PopulateLocationListsMC();
			PopulateReasonListMC();
			PopulateCreditRepListsMC();
			document.getElementById('txtDateReqMCE').value = jsToday;
			document.getElementById('hfInvAdjIDMCE').value = jiInvoiceReqID.toString();
			document.getElementById('txtReqByMCE').value = jsUserName;
			document.getElementById('hfReqByIDMCE').value = jiByID.toString();
			document.getElementById('selSalesRepMCE').value = '0';
			document.getElementById('selCreditRepMCE').value = '0';
			document.getElementById('selSalesLeadMCE').value = '0';
			document.getElementById('selShipFmLocationMCE').value = '0';
			document.getElementById('selReasonCodeMCE').value = '0';
			document.getElementById('txtCustNbrMCE').value = '';
			document.getElementById('txtCustNameMCE').value = '';
			document.getElementById('txtSONbrMCE').value = '';
			document.getElementById('txtInvoiceNbrMCE').value = '';
			document.getElementById('txaReasonForAdjMCE').value = '';
			document.getElementById('chkMCCustReqCopyE').checked = false;
			document.getElementById('txtManCredOrigInvAmt').value = '0';
			document.getElementById('txtManCredAdjInvAmt').value = '0';
			document.getElementById('txtManCredAdjustAmt').value = '0';
			SetTextBoxAutoComplete2Wc('txtCustomerNameMCE', 3, jhfCustCodeMCE, MyCustomerData, 'cust', 'CustName');
			jdivManualCredit.style.display='block';
			return false;
		}

		function SaveManualCredit() {
			var dtreq = CleanDateValTx(jtRequiredDateE.value);
			var byid = document.getElementById('hfReqByIDMCE').value;
			var stat = jsStatusCode; 
			var idt = jhfInvoiceDate.value;
			var crepid = document.getElementById('selCreditRepMCE').value;
			var spid = document.getElementById('selSalesRepMCE').value;
			var slead = document.getElementById('selSalesLeadMCE').value;
			var sfm = document.getElementById('selShipFmLocationMCE').value;
			var rc = document.getElementById('selReasonCodeMCE').value;
			var cust = document.getElementById('hfCustCodeMCE').value;
			var ctlnbr = CleanTextMin2Tx(document.getElementById('txtCustNbrMCE').value);
			var cid = '0';
			var vend = '';
			var onbr = CleanNbrValTx(document.getElementById('txtSONbrMCE').value);
			var shpnbr = document.getElementById('hfShipNbrMC').value;
			var onbr1 = '';
			var onbr2 = '';
			var loc2='';
			var loc3='';
			var set1=0;
			var set2=0;
			var set3=0;
			var set4=0;
			var set5=0;
			var set6=0;
			var amt = parseFloat(CleanNbrValTx(document.getElementById('txtManCredOrigInvAmt').value));
			var aiamt = parseFloat(CleanNbrValTx(document.getElementById('txtManCredAdjInvAmt').value));
			var aamt = parseFloat(CleanNbrValTx(document.getElementById('txtManCredAdjustAmt').value));
			var frate = 0;
			var oamt = 0;
			var oval1 = '';
			var oval2 = '';
			var pval1 = '';
			var pval2 = '';
			var pval3 = '';
			var rdate = '';
			var tdate = '';
			var adate1 = '';
			var adate2 = '';
			var tdate1 = '';
			var tdate2 = '';
			var nprod = 0;
			var cmt = PrepareJSONForHTMLTx(jtaGenCommentIAE.value, 1);
			var act = 1;
			var rdet = PrepareJSONForHTMLTx(document.getElementById('txaReasonForAdjMCE').value, 1);
			var crc = 0;
			if (document.getElementById('chkMCCustReqCopyE').checked === true) {crc = 1;}
			UpdateInvRequest(dtreq, byid, stat, idt, crepid, spid, slead, sfm, rc, rdet, cust, ctlnbr, cid, vend, onbr, shpnbr, onbr1, onbr2, loc2, loc3, crc, set1, set2, set3, set4, set5, set6, amt, aiamt, aamt, frate, oamt, oval1, oval2, pval1, pval2, pval3, rdate, tdate, adate1, adate2, tdate1, tdate2, nprod, cmt, act)

			return false;
		}

		function SetManualCreditEdit(edt) {
			var rOnly = false;
			if (edt === 0) { rOnly = true;}
			if(jbCanInitiate===false) {
				document.getElementById('txtDateReqMCE').readOnly = true;
				document.getElementById('txtReqByMCE').readOnly = true;
				document.getElementById('txtCustNbrMCE').readOnly = true;
				document.getElementById('txtCustNameMCE').readOnly = true;
				document.getElementById('txtSONbrMCE').readOnly = true;
				document.getElementById('txtInvoiceNbrMCE').readOnly = true;
				document.getElementById('txaReasonForAdjMCE').readOnly = true;
				document.getElementById('txtManCredOrigInvAmt').readOnly = true;
				document.getElementById('txtManCredAdjInvAmt').readOnly = true;
				document.getElementById('txtManCredAdjustAmt').readOnly = true;
				document.getElementById('selSalesRepMCE').disabled = true;
				document.getElementById('selCreditRepMCE').disabled = true;
				document.getElementById('selSalesLeadMCE').disabled = true;
				document.getElementById('selShipFmLocationMCE').disabled = true;
				document.getElementById('selReasonCodeMCE').disabled = true;
				document.getElementById('chkMCCustReqCopyE').disabled = rOnly;
			}
			else {
				document.getElementById('txtDateReqMCE').readOnly = rOnly;
				document.getElementById('txtReqByMCE').readOnly = rOnly;
				document.getElementById('txtCustNbrMCE').readOnly = rOnly;
				document.getElementById('txtCustNameMCE').readOnly = rOnly;
				document.getElementById('txtSONbrMCE').readOnly = rOnly;
				document.getElementById('txtInvoiceNbrMCE').readOnly = rOnly;
				document.getElementById('txaReasonForAdjMCE').readOnly = rOnly;
				document.getElementById('txtManCredOrigInvAmt').readOnly = rOnly;
				document.getElementById('txtManCredAdjInvAmt').readOnly = rOnly;
				document.getElementById('txtManCredAdjustAmt').readOnly = rOnly;
				document.getElementById('selSalesRepMCE').disabled = rOnly;
				document.getElementById('selCreditRepMCE').disabled = rOnly;
				document.getElementById('selSalesLeadMCE').disabled = rOnly;
				document.getElementById('selShipFmLocationMCE').disabled = rOnly;
				document.getElementById('selReasonCodeMCE').disabled = rOnly;
				document.getElementById('chkMCCustReqCopyE').disabled = rOnly;
			}
			return false;
		}

		function UpdateTotalAdjustmentMC() {
			var fig1 = parseFloat(CleanNbrValTx(document.getElementById('txtManCredOrigInvAmt').value));
			var fig2 = parseFloat(CleanNbrValTx(document.getElementById('txtManCredAdjInvAmt').value));
			var ttl = fig2 - fig1;
			document.getElementById('txtManCredAdjustAmt').value = getNbrStringFormattedTx(ttl, 2, ',', '.', '$', 2);
		}

		function ValidateManualCredit() {
			var errors = '';
 			//val = 
			//if (ValidateNumericStringTx(txt) === false && val !== '') { errors = errors.concat'Emails to Include data is not in the correct format.\n');}

			if (errors !== '') {errors = 'Customer Claim Errors:\n' + errors;}
			return errors;
		}

		//#endregion ManualCredit JS

		// **************************** FORM: Invoice Adj/Rtn Manifest *********************************

		//#region RtnManifest JS

		function NewRtnManifest() {
			var sRow = '';
			document.getElementById('hfRtnManifestIDM').value = '0';
			jbShowRManf = false;
			jiNbrProdsRM = 5;
			jtReqRtnDateM.value = jsToday;;
			jtRequestedByM.value = jsUserName;
			jhfRequestedByIDM.value = jiByID.toString();
			PopulateCarrierList();
			PopulateCreditRepListsRM();
			PopulateSalesLeadListsRM();
			PopulateLocationListsRM();
			PopulateDestinationList();
			PopulateReasonListRM();
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
			SetTextBoxAutoComplete2Wc('txtCustNameM', 3, jhfCustCodeLAD, MyCustomerData, 'cust', 'CustName');
			EnableItemRows(3, 'table-row');
			ShowOnePortion(3);
			return false;
		}

		function RemoveRMitem(row) {
			var id = document.getElementById('hfRMitemID' + row.toString()).value;
			if(confirm('This will remove this item from the request. Do you wish to continue?')) {
				RemoveItemFromListRM(id);



			}
			return false;
		}

		function SaveRtnManifestData() {
			// update sub document types
			jiInvoiceReqID=parseInt(document.getElementById('hfInvAdjIDE').value, 10);
			var aamt = jfInvoiceAdjAmount;
			var aiamt = jfInvoiceAmtNew;
			var amt = jfInvoiceAmtOrig;
			var byid = parseInt(document.getElementById('hfReqByIDE').value, 10);
			var cmt = jtaGenCommentIAE.value;
			var ctlnbr=document.getElementById('txtCustNbrE').value;
			var crc = 0;
			var crepid = parseInt(jselCreditRepE.value, 10);
			var cust = jhfCustCodeE.value;
			var dtreq = CleanDateValTx(document.getElementById('txtDateReqE').value);
			var ia = 1;
			var id = document.getElementById('hfInvAdjIDE').value;
			var idt= jhfInvoiceDate.value;
			var mannt = 0; //
			var nprod = jiNbrLinesShownIA;
			var oamt = jfInvoiceAmtOrig;
			var onbr= CleanNbrValTx(document.getElementById('txtSONbrE').value);
			var rc = jselReasonCodeE.value;
			var rdet = PrepareJSONForSpecialHTMLTx(jtaReasonForAdjE.value, 0) 
			var rdate = CleanDateValTx(jtRequiredDateE.value);
			var rdet = document.getElementById('txaReasonForAdjE').toString();
			var shpnbr = CleanNbrValTx(document.getElementById('hfShipNbrIA').toString());
			var spid = parseInt(jselSalesRepE.value, 10);
			var slead = jselSalesLeadE.value;
			var sfm = jselShipFmLocationE.value;
			var stat=jselSetNewStatus.value;
			var onbr = jiOrderNbr;
			if(jchkCustReqCopyE.checked === true) { crc = 1; }
			var crc = 0;
			UpdateInvRequest(dtreq, byid, stat, idt, crepid, spid, slead, sfm, rc, rdet, cust, ctlnbr, cid, vend, onbr, shpnbr, onbr1, onbr2, loc2, loc3, crc, set1, set2, set3, set4, set5, set6, amt, aiamt, aamt, frate, oamt, oval1, oval2, pval1, pval2, pval3, rdate, tdate, adate1, adate2, tdate1, tdate2, nprod, cmt, act)

			SaveRtnManifestLines();
			return false;
		}

		function SaveRtnManifestLines() {
					var ia = 0;
					var rtag = 0;
					var lnid = 0;
					var inbr = 0;
					var ptype = '';
					var pcode = ''
					var desc = '';
					var oqty = 0;
					var oqty2 = 0;
					var rqty = 0;
					var rqty2 = 0;
					var oprice = 0;
					var rprice = 0;
					var crdbamt = 0;
					var ia = 0;
					var rtag = 0;
					var rtnqty = 0;
					var rpkg = 0;
					var qchkin = 0;
					var tkt = '';
					var expl = '';
					var rtn = 0;
					var Attribs = '';
			if(jiNbrLinesShownRM > 0) {
				for(var row = 1; row <= jiNbrLinesShownRM; row++) {
					ia = 0;
					rtag = 0;
					lnid = parseInt(document.getElementById('hfRMItemID' + row.toString()).innerHTML, 10);
					inbr = parseInt(document.getElementById('hfRMItemNbrIA' + row.toString()).value, 10);
					ptype = document.getElementById('txtTKProdType' + rw).value;
					pcode = document.getElementById('txtTKProdCode' + rw).value;
					desc = document.getElementById('hfRmItemDesc' + row.toString()).value;
					oqty = parseFloat(CleanNbrValTx(document.getElementById('txtTKQty' + rw).value));
					oqty2 = parseFloat(CleanNbrValTx(document.getElementById('txtTKTotalPkgCount' + rw).value));
					rqty = parseFloat(CleanNbrValTx(document.getElementById('txtRevQty' + rw).value));
					rqty2 = 0;
					oprice = parseFloat(CleanNbrValTx(document.getElementById('txtOrigPrice' + rw).value));
					rprice = parseFloat(CleanNbrValTx(document.getElementById('txtRevPrice' + rw).value));
					crdbamt = 0;
					ia = 0;
					if(document.getElementById('chkTKInvAdj' + rw).checked === true) { ia = 1; }
					rtag = 0;
					if(document.getElementById('chkTKRedTag' + rw).checked === true) { rtag = 1; }
					var rtnqty = parseFloat(CleanNbrValTx(document.getElementById('txtTKQty' + rw).value));
					rpkg = parseFloat(CleanNbrValTx(document.getElementById('txtTKTotalPkgCount' + rw).value));
					qchkin = parseFloat(CleanNbrValTx(document.getElementById('txtTKQtyCheckedIn' + rw).value));
					tkt = StripSingleQuotesTx(document.getElementById('txtTKTicketNbr' + rw).value);
					expl = '';
					rtn = 0;
					Attribs = document.getElementById('hfRmItemAttribs' + row.toString()).value;
					UpdateInvReqLine(lnid, inbr, ptype, pcode, desc, Attribs, oqty, oqty2, rqty, rqty2, oprice, rprice, crdbamt, ia, rtag, rtnqty, rpkg, qchkin, tkt, expl, loc, rtn, act);
				}
			}
			return false;
		}

		function SetRtnManifestEdit(edt) {
			var rOnly = false;
			if (edt === 0) { rOnly = true;}
			if(jbCanInitiate===false) {
				document.getElementById('txtReqRtnDateM').readOnly = true;
				document.getElementById('txtRequestedByM').readOnly = true;
				document.getElementById('txtCustomerNbrM').readOnly = true;
				document.getElementById('txtCustNameM').readOnly = true;
				document.getElementById('txtSONbrM').readOnly = true;
				document.getElementById('txtInvoiceNbrM').readOnly = true;
				document.getElementById('txtTransOrderNbrM').readOnly = true;
				document.getElementById('txaRtnReasonM').readOnly = true;
				document.getElementById('selCreditRepM').disabled = true;
				document.getElementById('selSalesLeadM').disabled = true;
				document.getElementById('selShipFMLocationM').disabled = true;
				document.getElementById('selReasonCodeM').disabled = true;
				document.getElementById('txtActRtnDateM').readOnly = rOnly;
				document.getElementById('txtRtnFreightRateM').readOnly = rOnly;
				document.getElementById('selRtnCarrierM').disabled = rOnly;
				jselShipTOLocationM.disabled = rOnly;
				document.getElementById('chkRevisedInvCopyM').disabled = rOnly;
				document.getElementById('chkManInvAdjMI').disabled = rOnly;
				document.getElementById('chkAPNotificationMI').disabled = rOnly;
			}
			else {
				document.getElementById('txtReqRtnDateM').readOnly = rOnly;
				document.getElementById('txtRequestedByM').readOnly = rOnly;
				document.getElementById('txtCustomerNbrM').readOnly = rOnly;
				document.getElementById('txtCustNameM').readOnly = rOnly;
				document.getElementById('txtSONbrM').readOnly = rOnly;
				document.getElementById('txtInvoiceNbrM').readOnly = rOnly;
				document.getElementById('txtTransOrderNbrM').readOnly = rOnly;
				document.getElementById('txtActRtnDateM').readOnly = rOnly;
				document.getElementById('txaRtnReasonM').readOnly = rOnly;
				document.getElementById('selCreditRepM').disabled = rOnly;
				document.getElementById('selSalesLeadM').disabled = rOnly;
				document.getElementById('txtRtnFreightRateM').readOnly = rOnly;
				document.getElementById('selShipFMLocationM').disabled = rOnly;
				document.getElementById('selReasonCodeM').disabled = rOnly;
				document.getElementById('selRtnCarrierM').disabled = rOnly;
				jselShipTOLocationM.disabled = rOnly;
				document.getElementById('chkRevisedInvCopyM').disabled = rOnly;
				document.getElementById('chkManInvAdjMI').disabled = rOnly;
				document.getElementById('chkAPNotificationMI').disabled = rOnly;
			}
			return false;
		}

		function ValidateRtnManifest() {
			var errors = '';
 			//val = 
			//if (ValidateNumericStringTx(txt) === false && val !== '') { errors = errors.concat'Emails to Include data is not in the correct format.\n');}

			if (errors !== '') {errors = 'Customer Claim Errors:\n' + errors;}
			return errors;
		}

		//#endregion RtnManifest JS

		// **************************** FORM: Vendor Claim *********************************

		//#region VendorClaim JS
		
		function NewVendorClaim() {
			PopulateSalesLeadListsVC();
			PopulateSalesStaffListVC();
			PopulateCreditRepListsVC();
			PopulateLocationListsVC();
			PopulateReasonListVC();
			document.getElementById('txtVendorClaimIdentVC').value = '';
			document.getElementById('hfVendorCodeVCE').value = '';
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
			SetTextBoxAutoComplete2Wc('txtVendorClaimIdent', 3, jhfVendorCodeVCE, MyVendorList, 'vendor', 'VendorName');
			SetTextBoxAutoComplete2Wc('txtCustomerNameVCE', 3, jhfCustCodeVCE, MyCustomerData, 'cust', 'CustName');
			return false;
		}

		function SaveVendorClaim() {
			var dtreq = jtSubmittedOnCC.value;
			var byid = jiRequesterID;
			var stat = jsStatusCode;
			var crepid = document.getElementById('selCreditRepVCE').value;
			var spid = document.getElementById('selSalesRepVCE').value;
			var slead = document.getElementById('selSalesLeadVCE').value;
			var sfm = document.getElementById('selShipFmLocationVCE').value;
			var rc = document.getElementById('selReasonCodeVCE').value;
			var rdet = document.getElementById('txaReasonForAdjVCE').value;
			var cust = document.getElementById('hfCustCodeVCE').value;
			var ctlnbr = document.getElementById('txtCustNbrVCE').value;
			var vend = document.getElementById('hfVendorCodeVCE').value;
			var onbr = document.getElementById('txtSONbrVCE').value;
			var shpnbr = document.getElementById('hfShipNbrVC').value;
			var amt = parseFloat(CleanNbrValTx(document.getElementById('txtOrigInvoiceAmtVC').value));
			var aiamt = parseFloat(CleanNbrValTx(document.getElementById('txtAdjInvoiceAmtVC').value));
			var aamt = parseFloat(CleanNbrValTx(document.getElementById('txtAdjustmentAmtVC').value));
			var cmt = PrepareJSONForHTMLTx(jtaGenCommentIAE.value, 1);
			UpdateInvRequest(dtreq, byid, stat, '', crepid, spid, slead, sfm, rc, rdet, cust, ctlnbr, 0, vend, onbr, shpnbr, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, amt, aiamt, aamt, 0, 0, '', '', '', '', '', '', '', '', '', '', '', 0, cmt, 1);
			return false;
		}

		function SetVendorClaimEdit(edt) {
			var rOnly = false;
			if (edt === 0) { rOnly = true;}
			if(jbCanInitiate===false) {
				document.getElementById('txtDateReqVCE').readOnly = true;
				document.getElementById('txtReqByVCE').readOnly = true;
				document.getElementById('txtCustNbrVCE').readOnly = true;
				document.getElementById('txtCustNameVCE').readOnly = true;
				document.getElementById('txtSONbrVCE').readOnly = true;
				document.getElementById('txtInvoiceNbrVCE').readOnly = true;
				document.getElementById('txaReasonForAdjVCE').readOnly = true;
				document.getElementById('selSalesRepVCE').disabled = true;
				document.getElementById('selCreditRepVCE').disabled = true;
				document.getElementById('selSalesLeadVCE').disabled = true;
				document.getElementById('selShipFmLocationVCE').disabled = true;
				document.getElementById('selReasonCodeVCE').disabled = true;
				document.getElementById('txtOrigInvoiceAmtVC').readOnly = true;
				document.getElementById('txtAdjInvoiceAmtVC').readOnly = true;
				document.getElementById('txtAdjustmentAmtVC').readOnly = true;
			}
			else {
				document.getElementById('txtDateReqVCE').readOnly = rOnly;
				document.getElementById('txtReqByVCE').readOnly = rOnly;
				document.getElementById('txtCustNbrVCE').readOnly = rOnly;
				document.getElementById('txtCustNameVCE').readOnly = rOnly;
				document.getElementById('txtSONbrVCE').readOnly = rOnly;
				document.getElementById('txtInvoiceNbrVCE').readOnly = rOnly;
				document.getElementById('txaReasonForAdjVCE').readOnly = rOnly;
				document.getElementById('selSalesRepVCE').disabled = rOnly;
				document.getElementById('selCreditRepVCE').disabled = rOnly;
				document.getElementById('selSalesLeadVCE').disabled = rOnly;
				document.getElementById('selShipFmLocationVCE').disabled = rOnly;
				document.getElementById('selReasonCodeVCE').disabled = rOnly;
				document.getElementById('txtOrigInvoiceAmtVC').readOnly = rOnly;
				document.getElementById('txtAdjInvoiceAmtVC').readOnly = rOnly;
				document.getElementById('txtAdjustmentAmtVC').readOnly = rOnly;
			}
			return false;
		}

		function UpdateTotalAmtVC() {
			var fig1 = 0;
			var fig2 = 0;
			var ttl = 0;
			try {
				fig1 = parseFloat(CleanNbrValTx(document.getElementById('txtOrigInvoiceAmtVC').value));
				fig2 = parseFloat(CleanNbrValTx(document.getElementById('txtAdjInvoiceAmtVC').value));
				ttl = fig2-fig1;
			}
			catch(ex) {
				alert('You have non-numeric characters in the invoice or adjusted amount field');
			}
			document.getElementById('txtAdjustmentAmtVC').value = getNbrStringFormattedTx(ttl, 2, ',', '.', '$', 2);
			return false;
		}

		function ValidateVendorClaim() {
			var errors = '';
 			//val = 
			//if (ValidateNumericStringTx(txt) === false && val !== '') { errors = errors.concat'Emails to Include data is not in the correct format.\n');}

			if (errors !== '') {errors = 'Customer Claim Errors:\n' + errors;}
			return errors;
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
		<div id="divAttributesEdit" style="display:none;">
			<label id="lblAttributesType" style="font-weight:bold;color:blue;">Attributes</label>
			<table id="tblAttributesEditE" style="padding:1px;border-spacing:0px;border:1px solid gray;border-collapse:collapse;">
			<tr>
				<th class="TableHdrCell"><label id="lblAttribE1">A 1</label></th>
				<th class="TableHdrCell"><label id="lblAttribE2">A 2</label></th>
				<th class="TableHdrCell"><label id="lblAttribE3">A 3</label></th>
				<th class="TableHdrCell"><label id="lblAttribE4">A 4</label></th>
				<th class="TableHdrCell"><label id="lblAttribE5">A 5</label></th>
				<th class="TableHdrCell"><label id="lblAttribE6">A 6</label></th>
				<th class="TableHdrCell"><label id="lblAttribE7">A 7</label></th>
				<th class="TableHdrCell"><label id="lblAttribE8">A 8</label></th>
				<th class="TableHdrCell"><label id="lblAttribE9">A 9</label></th>
				<th class="TableHdrCell"><label id="lblAttribE10">A 10</label></th>
				<th class="TableHdrCell"><label id="lblAttribE11">A 11</label></th>
				<th class="TableHdrCell"><label id="lblAttribE12">A 12</label></th>
				<th class="TableHdrCell"><label id="lblAttribE13">A 13</label></th>
			</tr>
			<tr>
				<td class="StdTableCell" id="tdAttributes1" style="width:84px;text-align:center;"><select id="selAttributeE1" style="border:none;"><option value="0" selected="selected">Not Selected</option></select></td>
				<td class="StdTableCell" id="tdAttributes2" style="width: 84px; text-align: center;"><select id="selAttributeE2" style="border:none;"><option value="0" selected="selected">Not Selected</option></select></td>
				<td class="StdTableCell" id="tdAttributes3" style="width: 84px; text-align: center;"><select id="selAttributeE3" style="border:none;"><option value="0" selected="selected">Not Selected</option></select></td>
				<td class="StdTableCell" id="tdAttributes4" style="width: 84px; text-align: center;"><input type="text" id="txtAttributeE4" value="" style="width:80px;border:none;" /></td>
				<td class="StdTableCell" id="tdAttributes5" style="width: 84px; text-align: center;"><input type="text" id="txtAttributeE5" value="" style="width:80px;border:none;" /></td>
				<td class="StdTableCell" id="tdAttributes6" style="width: 84px; text-align: center;"><input type="text" id="txtAttributeE6" value="" style="width:80px;border:none;" /></td>
				<td class="StdTableCell" id="tdAttributes7" style="width: 84px; text-align: center;"><select id="selAttributeE7" style="border:none;"><option value="0" selected="selected">Not Selected</option></select></td>
				<td class="StdTableCell" id="tdAttributes8" style="width: 84px; text-align: center;"><input type="text" id="txtAttributeE8" value="" style="width:80px;border:none;" /></td>
				<td class="StdTableCell" id="tdAttributes9" style="width: 84px; text-align: center;"><input type="text" id="txtAttributeE9" value="" style="width:80px;border:none;" /></td>
				<td class="StdTableCell" id="tdAttributes10" style="width: 84px; text-align: center;"><select id="selAttributeE10" style="border:none;"><option value="0" selected="selected">Not Selected</option></select></td>
				<td class="StdTableCell" id="tdAttributes11" style="width: 84px; text-align: center;"><input type="text" id="txtAttributeE11" value="" style="width:80px;border:none;" /></td>
				<td class="StdTableCell" id="tdAttributes12" style="width: 84px; text-align: center;"><input type="text" id="txtAttributeE12" value="" style="width:80px;border:none;" /></td>
				<td class="StdTableCell" id="tdAttributes13" style="width: 84px; text-align: center;"><select id="selAttributeE13" style="border:none;"><option value="0" selected="selected">Not Selected</option></select></td>
			</tr>
			</table>
		</div>

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
											<option value="10">Customer Claim</option>
											<option value="4">Freight Accrual</option>
											<option value="2">Invoice Adjustment</option>
											<option value="7">Inventory Adjustment</option>
											<option value="6">Loss & Damage Claim</option>
											<option value="8">MAC Adjustment</option>
											<option value="9">Manual Credit</option>
											<option value="3">Return Manifest</option>
											<option value="5">Vendor Claim</option>
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
									Status:&nbsp;<label id="lblRequestStatusH" style="color: blue; font-weight: bold;"></label>&nbsp;&nbsp;
									<label id="lblCriticalItem" style="color: maroon; font-weight: bold;">Critical:</label><input type="checkbox" id="chkCriticalImportance">&nbsp;&nbsp;
									<span id="spnStatusBtnBar" style="display:inline;">
										<button id="btnStatus0" class="button blue-gradient glossy" onclick="javascript:ChangeReqStatus(0);return false;">Save</button>
										<button id="btnStatus1" class="button blue-gradient glossy" onclick="javascript:ChangeReqStatus(1);return false;">Btn 2</button>
										<button id="btnStatus2" class="button blue-gradient glossy" onclick="javascript:ChangeReqStatus(2);return false;">Btn 3</button>
										<button id="btnStatus3" class="button blue-gradient glossy" onclick="javascript:ChangeReqStatus(3);return false;">Btn 4</button>
										<button id="btnStatus4" class="button blue-gradient glossy" onclick="javascript:ChangeReqStatus(4);return false;">Btn 5</button>
										<button id="btnStatus5" class="button blue-gradient glossy" onclick="javascript:ChangeReqStatus(5);return false;">Btn 6</button>
										<button id="btnStatus6" class="button blue-gradient glossy" onclick="javascript:ChangeReqStatus(6);return false;">Btn 7</button>
										<button id="btnStatus7" class="button blue-gradient glossy" onclick="javascript:ChangeReqStatus(7);return false;">Btn 8</button>
										<button id="btnStatus8" class="button blue-gradient glossy" onclick="javascript:ChangeReqStatus(8);return false;">Btn 9</button>
										<button id="btnStatus9" class="button blue-gradient glossy" onclick="javascript:ChangeReqStatus(9);return false;">Btn10</button>
									</span>
								</td>
								<td>&nbsp;</td>
								<td style="text-align: right; font-size: 12pt;">Request/Claim&nbsp;Submitted&nbsp;By:&nbsp;</td>
								<td style="vertical-align: middle; text-align: left; font-size: 12pt;">
									<input type="text" id="txtSubmittedByHDR" style="width: 174px" readonly="readonly" />&nbsp;
									<input type="hidden" id="hfSubmittedByIDHDR" value="0" />
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
									Submitted&nbsp;On:&nbsp;<input type="text" id="txtSubmittedOnHDR" style="width: 90px" readonly="readonly" />&nbsp;&nbsp;
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

				<div id="divHideBottomLine" style="border: none; background-color: white; width: 150px; height: 10px; display: none;">&nbsp;</div>

				<div id="divTabBlockTabs" style="margin-bottom: 0px; padding-bottom: 0px; text-align: left; margin-top: 6px;">
					<table style="padding: 0px; border: none; border-spacing: 0px; margin-left: 4px;">
						<tr>
							<td>
								<div id="divTabHdr1" class="TabHdrBoxes" onclick="javascript:SetTabVisible(1);return false;">
									<label style="font-family: 'Copperplate Gothic'; font-weight: bold;">CLAIM FORM</label>
								</div>
							</td>
							<td>
								<div id="divTabHdr2" class="TabHdrBoxes" onclick="javascript:SetTabVisible(2);return false;">
									<label style="font-family: 'Copperplate Gothic'; font-weight: bold;">STATUS HISTORY</label>
								</div>
							</td>
							<td>
								<div id="divTabHdr3" class="TabHdrBoxes" onclick="javascript:SetTabVisible(3);return false;">
									<label style="font-family: 'Copperplate Gothic'; font-weight: bold;">ATTACHMENTS</label>
								</div>
							</td>
							<td>
								<div id="divTabHdr4" class="TabHdrBoxes" onclick="javascript:SetTabVisible(4);return false;">
									<label style="font-family: 'Copperplate Gothic'; font-weight: bold;">HELP</label>
								</div>
							</td>
						</tr>
					</table>

				</div>

				<div id="divTabBlock" style="border: 1px solid gray; background-color: white; padding: 2px; margin: 0px; border-spacing: 0px; height: 700px; width: 100%; margin: 0px;">
					<div id="divTab1" style="border: none; width: 100%; height: 100%; margin: 0px; overflow: scroll;padding:2px;">

						<table id="tblInvAdjMainHolder" style="width: 100%;">
							<tr>
								<td>

									<!------------------------------------------------------ Doc Type Blocks --------------------------------------------------------->
									<div id="divCustClaim" style="width: 100%; display: none; margin-bottom: 10px;">
										<label id="lblCustCLaimHdr" style="color: blue; font-size: 14pt; font-weight: bold;">Customer Comment / Claim Form</label><br />

										<div id="divCustClaimForm" style="width: 100%;">
											<table id="tblCustCLaimForm" style="padding: 1px; border-spacing: 0px; border: none;">
												<tr>
													<td class="FormLabelStdPg">Submitted&nbsp;By:&nbsp;
													</td>
													<td colspan="3">
														<input type="text" id="txtSubmittedByCC" style="width: 160px" />
														<input type="hidden" id="hfSubmittedByIDCC" value="" />
													</td>
													<td>&nbsp;</td>
													<td>&nbsp;</td>
													<td style="text-align: right;">Submitted&nbsp;Date:&nbsp;
													</td>
													<td>
														<input type="text" id="txtSubmittedOnCC" style="width: 90px" />
													</td>
													<td>&nbsp;</td>
												</tr>
												<tr>
													<td style="text-align: right;">Cust&nbsp;Name:&nbsp;
													</td>
													<td colspan="3">
														<input type="text" id="txtCustNameCC" style="width: 300px" />
														<input type="hidden" id="hfCustCodeCC" value="" />
														<input type="hidden" id="hfInvRequestIDCC" value="" />
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
														<select id="selRegionCC" onchange="javascript:ChangeRegionCode(this.value);return false;">
															<option value="0" selected="selected">None Selected</option>
															<option value="APP">APP</option>
															<option value="GLA">Glacial</option>
															<option value="NORTH">North</option>
															<option value="WEST">West</option>
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
													<td colspan="2">&nbsp;
													</td>
													<td style="text-align:right;">
														Reason&nbsp;Code:&nbsp;
													</td>
													<td>
														<select id="selReasonCodeCC">
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
														<input type="hidden" id="hfOrigAmtCC" style="width: 120px; background-color: gainsboro;" />
													</td>
												</tr>
											</table>
										</div>
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
														<input type="hidden" id="hfShipNbrFA" value="0" />
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
														<input type="text" id="txtOrigInvoiceAmtFA" class="InputNbrWNoBorder" style="width: 120px" onchange="javascript:UpdateTotalAmtFA();return false;" />
													</td>
												</tr>
												<tr id="trFreightAccRow09">
													<td class="StdTableCellWBorder" colspan="2" style="text-align: right; background-color: aquamarine;">Adjusted Freight Amount:&nbsp;
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtAdjInvoiceAmtFA" class="InputNbrWNoBorder" style="width: 120px" onchange="javascript:UpdateTotalAmtFA();return false;" />
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
													<td class="StdTableCellWBorderDarker" style="text-align: center;" colspan="2">Sales Lead
													</td>
													<td colspan="2" class="StdTableCellWBorderDarker" style="text-align: center;">Shipped From Location Code
													</td>
												</tr>
												<tr id="trInvAdjRow02">
													<td class="StdTableCellWBorder">
														<input type="text" id="txtDateReqE" class="InputTextWNoBorder" style="width: 80px;" />
														<input type="hidden" id="hfInvAdjIDE" value="0" />
														<input type="hidden" id="hfShipNbrIA" value="0" />
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
													<td class="StdTableCellWBorder" style="text-align: right;" colspan="2">
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
													<td colspan="4" class="StdTableCellWBorderDarker" style="text-align: center;">Reason Code
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
													<td colspan="4" class="StdTableCellWBorder" style="text-align: right;">
														<select id="selReasonCodeE" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
														</select>
													</td>
												</tr>
												<tr id="trInvAdjRow05">
													<td colspan="10" class="TableSeperatorRow" style="line-height: 10px; height: 10px;">&nbsp;
													</td>
												</tr>
												<tr id="trInvAdjRow06" style="border: 1px solid gray;">
													<td colspan="4" style="text-align: center; font-size: 11pt; color: darkblue; border: 1px solid gray; background-color: aquamarine">Required Document	
													</td>
													<td colspan="6" style="text-align: center; font-size: 11pt; color: darkblue; border: 1px solid gray; background-color: aquamarine">Reason&nbsp;for&nbsp;Credit/Invoice&nbsp;Adjustment
													</td>
												</tr>
												<tr id="trInvAdjRow07">
													<td colspan="2" class="StdTableCellWBorder" style="text-align: right;">&nbsp;
													</td>
													<td colspan="2" class="StdTableCellWBorder" style="text-align: right;">&nbsp;
													</td>
													<td colspan="6" rowspan="4" class="StdTableCellWBorder">
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
													<td colspan="10" class="TableSeperatorRow" style="line-height: 10px; height: 10px;">&nbsp;
													</td>
												</tr>
												<tr id="trInvAdjRow11">
													<td colspan="3" class="StdTableCellWBorderDarker" style="text-align: center;">
														<label id="lblProdListHdrx">PRODUCTS</label>&nbsp;<label id="lblProdNbrItemsHdrx"></label>
														<button id="btnAddItemLine" class="button blue-gradient glossy" onclick="javascript:AddInvoiceAdjItemLine();return false;" style="margin-left:50px;" />
														Add Line</button>
													&nbsp;
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center; font-weight: bold;" rowspan="2">Action</td>
													<td colspan="2" class="StdTableCellWBorderDarker" style="text-align: center; font-weight: bold;">Quantity
													</td>
													<td colspan="2" class="StdTableCellWBorderDarker" style="text-align: center; font-weight: bold;">Price
													</td>
													<td class="StdTableCellWBorderDarker" colspan="2" style="text-align: center; font-weight: bold;">TOTAL CR/DB AMOUNT
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
														<input type="text" id="txtRevQty1" class="InputTextWNoBorder" style="width: 70px;" onchange="javascript:ChangeIALineItem(1);return false;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: antiquewhite;">
														<input type="text" id="txtOrigPrice1" class="InputTextWNoBorder" style="width: 100px; background-color: antiquewhite;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtRevPrice1" class="InputTextWNoBorder" style="width: 100px;" onchange="javascript:ChangeIALineItem(1);return false;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: #DDDDDD;">
														<input type="text" id="txtTotalAmountO1" class="InputTextWNoBorder" style="width: 110px;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: #DDDDDD;">
														<input type="text" id="txtTotalAmountA1" class="InputTextWNoBorder" style="width: 110px;" />
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
														<input type="text" id="txtRevQty2" class="InputTextWNoBorder" style="width: 70px;" onchange="javascript:ChangeIALineItem(1);return false;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: antiquewhite;">
														<input type="text" id="txtOrigPrice2" class="InputTextWNoBorder" style="width: 100px; background-color: antiquewhite;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtRevPrice2" class="InputTextWNoBorder" style="width: 100px;" onchange="javascript:ChangeIALineItem(1);return false;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: #DDDDDD;">
														<input type="text" id="txtTotalAmountO2" class="InputTextWNoBorder" style="width: 110px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: #DDDDDD;">
														<input type="text" id="txtTotalAmountA2" class="InputTextWNoBorder" style="width: 110px" />
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
														<input type="text" id="txtRevQty3" class="InputTextWNoBorder" style="width: 70px;" onchange="javascript:ChangeIALineItem(1);return false;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: antiquewhite;">
														<input type="text" id="txtOrigPrice3" class="InputTextWNoBorder" style="width: 100px; background-color: antiquewhite;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtRevPrice3" class="InputTextWNoBorder" style="width: 100px;" onchange="javascript:ChangeIALineItem(1);return false;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: #DDDDDD;">
														<input type="text" id="txtTotalAmountO3" class="InputTextWNoBorder" style="width: 110px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: #DDDDDD;">
														<input type="text" id="txtTotalAmountA3" class="InputTextWNoBorder" style="width: 110px" />
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
														<input type="text" id="txtRevQty4" class="InputTextWNoBorder" style="width: 70px;" onchange="javascript:ChangeIALineItem(1);return false;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: antiquewhite;">
														<input type="text" id="txtOrigPrice4" class="InputTextWNoBorder" style="width: 100px; background-color: antiquewhite;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtRevPrice4" class="InputTextWNoBorder" style="width: 100px;" onchange="javascript:ChangeIALineItem(1);return false;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: #DDDDDD;">
														<input type="text" id="txtTotalAmountO4" class="InputTextWNoBorder" style="width: 110px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: #DDDDDD;">
														<input type="text" id="txtTotalAmountA4" class="InputTextWNoBorder" style="width: 110px" />
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
														<input type="text" id="txtRevQty5" class="InputTextWNoBorder" style="width: 70px;" onchange="javascript:ChangeIALineItem(1);return false;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: antiquewhite;">
														<input type="text" id="txtOrigPrice5" class="InputTextWNoBorder" style="width: 100px; background-color: antiquewhite;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtRevPrice5" class="InputTextWNoBorder" style="width: 100px;" onchange="javascript:ChangeIALineItem(1);return false;" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: #DDDDDD;">
														<input type="text" id="txtTotalAmountO5" class="InputTextWNoBorder" style="width: 110px" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; background-color: #DDDDDD;">
														<input type="text" id="txtTotalAmountA5" class="InputTextWNoBorder" style="width: 110px" />
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
													<td style="background-color:#555555;">
														&nbsp;
													</td>
												</tr>
												<tr id="trInvAdjRow14">
													<td class="StdTableCellWBorder" colspan="3" style="text-align: right; background-color: aquamarine;">Adjusted Invoice Amount:&nbsp;
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtAdjInvoiceAmt" class="InputNbrWNoBorder" style="width: 120px" />
													</td>
												</tr>
												<tr id="trInvAdjRow15">
													<td class="StdTableCellWBorder" colspan="3" style="text-align: right; background-color: aquamarine;">Adjustment Amount:&nbsp;
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtAdjustmentAmt" class="InputNbrWNoBorder" style="width: 120px" />
													</td>
												</tr>
												<tr id="trInvAdjComment">
													<td class="StdTableCellWBorder" style="text-align: right;">Comments:
													</td>
													<td class="StdTableCellWBorder" colspan="9">
														<textarea id="txaGenCommentIAE" style="width: 860px; height: 36px;" class="InputNbrWNoBorder"></textarea>
													</td>
												</tr>
												<tr id="trInvAdjRow16">
													<td colspan="10" class="TableSeperatorRow" style="line-height: 10px; height: 10px;">
														<hr style="border: 5px solid blue;" />
													</td>
												</tr>
												<tr id="trRtnManifestRow00">
													<td class="StdTableCellWBorder" colspan="2" style="font-weight: bold; font-size: 11pt;">&nbsp;RETURN MANIFEST:&nbsp;&nbsp;
													</td>
													<td class="StdTableCellWBorder" colspan="8" style="background-color: #555555;">&nbsp;
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
													<td class="StdTableCellWBorderDarker" style="text-align: center; font-weight: bold;" colspan="4">Shipped FROM Location Code:
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
													<td class="StdTableCellWBorder" style="text-align: right;" colspan="4">
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
													<td class="StdTableCellWBorderDarker" style="text-align: center; font-weight: bold;" colspan="4">Reason Code:
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
													<td class="StdTableCellWBorder" style="text-align: right;" colspan="4">
														<select id="selReasonCodeM" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
														</select>
													</td>
												</tr>
												<tr id="trRtnManifestRow05">
													<td colspan="10" class="TableSeperatorRow" style="line-height: 10px; height: 10px;">&nbsp;
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
													<td class="StdTableCellWBorderDarker" style="text-align: center; font-weight: bold;" colspan="4">Shipped TO Location Code:
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
													<td class="StdTableCellWBorder" style="text-align: right;" colspan="4">
														<select id="selShipTOLocationM" class="ControlNoBorderWB">
															<option value="0" selected="selected">Not Selected</option>
														</select>
													</td>
												</tr>
												<tr id="trRtnManifestRow08">
													<td class="StdTableCellWBorder" style="text-align: center; font-weight: bold; font-size: 11pt; background-color: aquamarine;" colspan="5">Required Customer Documents:
													</td>
													<td class="StdTableCellWBorder" style="text-align: center; font-weight: bold; font-size: 11pt; background-color: aquamarine;" colspan="5">Reason For Return:
													</td>
												</tr>
												<tr id="trRtnManifestRow09">
													<td class="StdTableCellWBorder" style="text-align: center;" colspan="4">
														<label id="lblCustReqCopyRevisedInv" style="color: darkred; font-weight: bold;">Customer REQUIRES COPY of revised invoice:</label>&nbsp;
													<input type="checkbox" id="chkRevisedInvCopyM" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;" colspan="6" rowspan="4">
														<textarea id="txaRtnReasonM" class="InputTextWNoBorder" style="width: 99%; height: 100px;"></textarea>
													</td>
												</tr>
												<tr id="trRtnManifestRow10">
													<td class="StdTableCellWBorder" style="line-height: 10px; height: 10px; background-color: #555555;" colspan="4">
														&nbsp;
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
													<td class="StdTableCellWBorder" style="text-align: left;" colspan="10">
														<label id="lblProdListHdr" style="font-weight:bold;color:darkgreen;">MANIFEST PRODUCTS</label>
														<button id="btnAddNewTicket" class="button blue-gradient glossy" onclick="javascript:AddNewTicket();return false;" style="margin-left: 30px; display: none;">Add Line</button>
													</td>
												</tr>
												<tr id="trRtnManifestRow14">
													<td class="StdTableCellWBorderDarker" style="text-align: center;">ProdType & Code
													</td>
													<td class="StdTableCellWBorderDarker" style="text-align: center;" colspan="2">Ticket #'s
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
														<input type="hidden" id="hfRMItemDesc1" value="" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;" colspan="2">
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
														<input type="hidden" id="hfTKOrigQty1" value=""/>
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
														<input type="hidden" id="hfRMItemDesc2" value="" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;" colspan="2">
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
														<input type="hidden" id="hfTKOrigQty2" value=""/>
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
														<input type="hidden" id="hfRMItemDesc3" value="" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;" colspan="2">
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
														<input type="hidden" id="hfTKOrigQty3" value=""/>
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
														<input type="hidden" id="hfRMItemDesc4" value="" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;" colspan="2">
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
														<input type="hidden" id="hfTKOrigQty4" value=""/>
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
														<input type="hidden" id="hfRMItemDesc5" value="" />
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;" colspan="2">
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
														<input type="hidden" id="hfTKOrigQty5" value=""/>
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
													<td class="StdTableCellWBorder" style="text-align: center; background-color: #DDDDDD;"">
														<input type="checkbox" id="chkTKInvAdj5" />
													</td>
												</tr>
												<tr id="trRtnManifestRow15">
													<td colspan="10" class="TableSeperatorRow" style="line-height: 16px; height: 16px;">
														<hr style="border: 5px solid blue;" />
													</td>
												</tr>
												<tr id="trRtnManifestRow16">
													<td colspan="10" style="text-align: center; font-style: italic;">Product Returns must be verified and match quantity/tag numbers prior to signing.
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
											<input type="hidden" id="hfShipNbrIC" value="0" />
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
															<input type="hidden" id="hfInvReqLineIDIAdjE" value="0" />
															<input type="hidden" id="hfItemNbrIAdjE" value="0" />
															<input type="hidden" id="hfInvRequestIDIAdjE" value="0" />
															<input type="hidden" id="hfProdDescIAdjE" value="0" />
														</td>
														<td class="StdTableCell" style="width: 50px;">
															<select id="selProdTypeIAdjE" onchange="javascript:ChangeIAdjProdType(this.value);return false;">
																<option value="0" selected="selected">None</option>
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
															<input type="text" id="txtQtyAdjustmentIAdj" style="width: 60px;" />
															<input type="hidden" id="hfQtyAdjOrigIAdj" value="0" />
														</td>
														<td class="StdTableCell" style="width: 100px;">
															<input type="text" id="txtPcPkgAdjustmentIAdj" style="width: 60px;" />
															<input type="hidden" id="hfPkgAdjOrigIAdj" value="0" />
														</td>
														<td class="StdTableCell" style="width: 300px;">
															<textarea id="txaDetailedExplanationIAdj" style="width: 300px; height: 48px;"></textarea>
														</td>
													</tr>
													<tr>
														<td colspan="19">
															<table style="width:100%;border:none;padding:0px;border-spacing:0px;">
															<tr>
																<td style="width:40px;">
																	<label style="color:darkblue;font-weight:bold;">NOTE:</label>
																</td>
																<td style="width: 30px;">
																	1.&nbsp;
																</td>
																<td>
																	Select Location and P/T first. This will tailor the remainder of the identity columns for the location and product type chosen.	Changing the product type will cause a delay while the data is loaded.
																</td>
															</tr>
																<tr>
																	<td style="width: 40px;">&nbsp;</td>
																	<td style="width: 30px;">
																		2.&nbsp;
																	</td>
																	<td>
																		A change in the columns identifying a specific item (location/prodtype/code and attributes) will cause the existing inventory data to be loaded. Please save your data before changing product identification fields.<br />
																	</td>
																</tr>
															</table>
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

											<div id="divChangeTotalsIC" style="width:100%;display:none;">
											<table style="border-spacing:0px;padding:2px;border:none;">
											<tr>
												<td>
													
												</td>
												<td>

												</td>
											</tr>
											</table>

											</div>

										</div>
									</div>

									<div id="divLossAndDamageClaim" style="width: 100%; text-align: center; margin-bottom: 10px; display: none;">
										<label id="lblLossAndDamageHdr" style="color: blue; font-size: 14pt; font-weight: bold;">Loss and Damage Claim</label><br />

										<table style="padding-top: 4px; padding-bottom:4px;padding-left:20px;padding-right:20px; border-spacing: 0px; border: 1px solid gray; background-color: beige; margin: auto auto;">
											<tr>
												<td>
													<table id="tblLossAndDamage" style="padding: 1px; border: none; border-spacing: 0px;">
														<tr>
															<td style="text-align: right; vertical-align: top;">Date:&nbsp;
															</td>
															<td style="text-align: left;">
																<input type="text" id="txtLADTransDate" style="width: 82px;" />
																<input type="hidden" id="hfShipNbrLAD" value="0" />
															</td>
															<td>&nbsp;</td>
															<td style="text-align: right; vertical-align: top;">Customer:&nbsp;
															</td>
															<td style="text-align: left;">
																<input type="text" id="txtCustomerLAndD" style="width: 260px;" />
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
															<td style="text-align: right; vertical-align: top;">
																Loss&nbsp;&&nbsp;Damage&nbsp;Class:&nbsp;
															</td>
															<td style="text-align: left;">
																<select id="selLossDmgClass">
																	<option value="0" selected="selected">None Selected</option>
																</select>
															</td>
															<td>&nbsp;</td>
															<td>Customer&nbsp;Nbr:&nbsp;</td>
															<td style="text-align: left;">
																<input type="text" id="txtCustNbrLAD" style="width: 76px;" />
															</td>
														</tr>
														<tr>
															<td colspan="5" style="text-align: center; font-style: italic; font-weight: bold;">
															</td>
														</tr>
														<tr>
															<td colspan="5" style="text-align: center;">

																<table id="tblLADProducts" style="padding: 4px; border: none; background-color:white;  margin: auto auto; vertical-align: top; border-collapse: collapse; margin-bottom: 6px;">
																<thead style="padding:1px;">
																	<tr>
																		<th style="border: none; background-color: beige; text-align: left;" colspan="2">
																			Product(s):&nbsp;
																		</th>
																		<th style="border: none; background-color: beige; text-align: right;" colspan="3">
																			<button id="btnAddLossDamageItem" class="button blue-gradient glossy" onclick="javascript:AddLossDamageItem();return false;" style="right: 30px;">Add Line</button>
																		</th>
																	</tr>
																	<tr>
																		<th class="TableHdrCell" style="width: 50px;">P/T</th>
																		<th class="TableHdrCell" style="width: 80px;">Product</th>
																		<th class="TableHdrCell" style="width: 90px;">Amount</th>
																		<th class="TableHdrCell" style="width: 320px;">Comments</th>
																		<th class="TableHdrCell" style="width: 204px;">Action</th>
																	</tr>
																</thead>
																<tbody style="padding: 1px;">
																	<tr id="trLossDamage01">
																		<td class="StdTableCell" style="vertical-align: top;">
																			<select id="selProdTypeLAD01" style="border: none;">
																				<option value="0" selected="selected">None Selected</option>
																			</select>
																			<input type="hidden" id="hfLineIDLAD1" value="0" />
																			<input type="hidden" id="hfItemNbrLAD1" value="0" />
																			<input type="hidden" id="hfLADItemAttribs1" value="" />
																			<input type="hidden" id="hfLADProdDesc1" value="" />
																		</td>
																		<td class="StdTableCell" style="vertical-align: top;">
																			<!--select id="selProdCodeLAD01" style="border:none;"><option value="0" selected="selected">None Selected</option></select -->
																			<input type="text" id="txtProdCodeLAD01" style="width: 80px; border: none;" />
																		</td>
																		<td class="StdTableCell" style="vertical-align: top;">
																			<input type="text" id="txtAmountLAD01" style="width: 90px; border: none; text-align: right;" onchange="javascript:ChangeTotalClaimAmt();return false;" />
																			<input type="hidden" id="hfOrigAmtLAD1" value="" />
																		</td>
																		<td class="StdTableCell" style="vertical-align: top;">
																			<input type="text" id="txtLineCommmentsLAD01" style="width: 320px; border: none;" />
																		</td>
																		<td class="StdTableCell" style="vertical-align: top; width: 204px;">
																			<button id="btnSaveLADItem1" class="button blue-gradient glossy" onclick="javascript:SaveLADItem(1);return false;">Save</button>
																			<button id="btnRemoveLADItem1" class="button blue-gradient glossy" onclick="javascript:RemoveLADItem(1);return false;">Remove</button>
																			<button id="btnEditAtributesLAD1" class="button blue-gradient glossy" onclick="javascript:EditAttributesLAD(1);return false;">Attribs</button>
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
																			<input type="hidden" id="hfLADProdDesc2" value="" />
																		</td>
																		<td class="StdTableCell" style="vertical-align: top;">
																			<input type="text" id="txtProdCodeLAD02" style="width: 80px; border: none;" />
																		</td>
																		<td class="StdTableCell" style="vertical-align: top;">
																			<input type="text" id="txtAmountLAD02" style="width: 90px; border: none; text-align: right;" onchange="javascript:ChangeTotalClaimAmt();return false;" />
																			<input type="hidden" id="hfOrigAmtLAD2" value="" />
																		</td>
																		<td class="StdTableCell" style="vertical-align: top;">
																			<input type="text" id="txtLineCommmentsLAD02" style="width: 320px; border: none;" />
																		</td>
																		<td class="StdTableCell" style="vertical-align: top; width: 204px;">
																			<button id="btnSaveLADItem2" class="button blue-gradient glossy" onclick="javascript:SaveLADItem(2);return false;">Save</button>
																			<button id="btnRemoveLADItem2" class="button blue-gradient glossy" onclick="javascript:RemoveLADItem(2);return false;">Remove</button>
																			<button id="btnEditAtributesLAD2" class="button blue-gradient glossy" onclick="javascript:EditAttributesLAD(2);return false;">Attribs</button>
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
																			<input type="hidden" id="hfLADProdDesc3" value="" />
																		</td>
																		<td class="StdTableCell" style="vertical-align: top;">
																			<input type="text" id="txtProdCodeLAD03" style="width: 80px; border: none;" />
																		</td>
																		<td class="StdTableCell" style="vertical-align: top;">
																			<input type="text" id="txtAmountLAD03" style="width: 90px; border: none; text-align: right;" onchange="javascript:ChangeTotalClaimAmt();return false;" />
																			<input type="hidden" id="hfOrigAmtLAD3" value="" />
																		</td>
																		<td class="StdTableCell" style="vertical-align: top;">
																			<input type="text" id="txtLineCommmentsLAD03" style="width: 320px; border: none;" />
																		</td>
																		<td class="StdTableCell" style="vertical-align: top; width: 204px;">
																			<button id="btnSaveLADItem3" class="button blue-gradient glossy" onclick="javascript:SaveLADItem(3);return false;">Save</button>
																			<button id="btnRemoveLADItem3" class="button blue-gradient glossy" onclick="javascript:RemoveLADItem(3);return false;">Remove</button>
																			<button id="btnEditAtributesLAD3" class="button blue-gradient glossy" onclick="javascript:EditAttributesLAD(3);return false;">Attribs</button>
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
																<input type="hidden" id="hfOrigAmtLAD" style="width: 140px; text-align: right;" readonly="readonly" />
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

									<div id="divMACAdjustment" style="width: 100%; display: none; margin-bottom: 10px;">
										<label id="lblMACAdjustmentHdr" style="color: blue; font-size: 14pt; font-weight: bold;">MAC Adjustment</label><br />

										<div id="divMACAdjustmentMain" style="width: 100%; text-align: center;">
											<table id="tblMACAdjustment" style="padding: 1px; border-spacing: 0px; border-collapse: collapse; margin: auto auto;">
												<thead>
													<tr>
														<td style="border: none; text-align: left;" colspan="3">
															<label id="lblMacAdjMainHdr" style="font-weight: bold; color: darkgreen;">Enter the following information:</label>&nbsp;&nbsp;
															<input type="hidden" id="hfInvRequestIDMA" value="0" />
															<input type="hidden" id="hfShipNbrMA" value="0" />
														</td>
														<td style="border: none; text-align: right;" colspan="7">
															<button id="btnAddNewMACline" class="button blue-gradient glossy" onclick="javascript:AddNewMACLine();return false;" style="margin-left: 50px;">Add New Line</button>
														</td>
													</tr>
													<tr>
														<th class="TableHdrCell" style="width: 60px;" rowspan="2">P/T</th>
														<th class="TableHdrCell" style="width: 80px;" rowspan="2">Product</th>
														<th class="TableHdrCell" style="width: 140px;" rowspan="2">Description</th>
														<th class="TableHdrCell" style="width: 60px;" rowspan="2">Location</th>
														<th class="TableHdrCell" style="width: 60px;" rowspan="2">Cost ID</th>
														<th class="TableHdrCell" style="width: 204px;" colspan="3">MAC</th>
														<th class="TableHdrCell" style="width: 60px;" rowspan="2">Cost ID</th>
														<th class="TableHdrCell" style="width: 200px;" rowspan="2">Reason</th>
														<th class="TableHdrCell" style="width: 160px;" rowspan="2">Action</th>
													</tr>
													<tr>
														<th class="TableHdrCell" style="width: 90px;">Current</th>
														<th class="TableHdrCell" style="width: 90px;">Correct</th>
														<th class="TableHdrCell" style="width: 80px;">Difference</th>
													</tr>
												</thead>
												<tbody>
													<tr id="trMACAdjustItem1">
														<td class="StdTableCell" style="width: 60px;">
															<select id="selProdTypeMACA1" class="ControlNoBorderWB" onchange="javascript:ChangeProductMAC(0, 1);return false;">
																<option value="0" selected="selected">Not Selected</option>
															</select>
															<input type="hidden" id="hfLineIDMACAE1" value="0" />
															<input type="hidden" id="hfItemNbrMACAE1" value="0" />
															<input type="hidden" id="hfMACItemAttribs1" value="" />
														</td>
														<td class="StdTableCell" style="width: 80px;">
															<input type="text" id="txtProdCodeMACA1" style="width: 80px;" class="ControlNoBorderWB" onchange="javascript:ChangeProductMAC(1, 1);return false;" />
														</td>
														<td class="StdTableCell" style="width: 140px;">
															<input type="text" id="txtProdDescMACA1" style="width: 140px;" class="ControlNoBorderWB" />
														</td>
														<td class="StdTableCell" style="width: 60px;">
															<select id="selLocationMACA1" class="ControlNoBorderWB">
																<option value="0" selected="selected">Not Selected</option>
															</select>
														</td>
														<td class="StdTableCell" style="width: 100px;">
															<input type="text" id="txtCostIDMACA1" class="ControlNoBorderWB" style="width: 100px;" />
														</td>
														<th class="StdTableCell" style="width: 90px;">
															<input type="text" id="txtCurrentMACA1" class="ControlNoBorderWB" style="width: 90px;" onchange="javascript:ChangeCurrentMAC(0, 1, this.value);return false;" />
														</th>
														<th class="StdTableCell" style="width: 90px;">
															<input type="text" id="txtCorrectMACA1" class="ControlNoBorderWB" style="width: 90px;" onchange="javascript:ChangeCorrectMAC(1, 1, this.value);return false;" />
														</th>
														<th class="StdTableCell" style="width: 80px;">
															<input type="text" id="txtMACDifference1" class="ControlNoBorderWB" style="width: 80px;" readonly="readonly" />
														</th>
														<td class="StdTableCell" style="width: 90px;">
															<input type="text" id="txtMACCostID1" class="ControlNoBorderWB" style="width: 90px;" />
														</td>
														<td class="StdTableCell" style="width: 160px;text-align:left;">
															<input type="text" id="txtMACReason1" class="ControlNoBorderWB" style="width: 160px;" />
														</td>
														<td class="StdTableCell" style="width: 160px;text-align:center;">
															<button id="btnRemoveMACItem1" class="button blue-gradient glossy" style="display:none;">Remove</button>
															<button id="btnEditAttribsMAC1" class="button blue-gradient glossy" onclick="javascript:EditAttributesMAC(1);return false;">Attribs</button>
														</td>
													</tr>
													<tr>
													</tr>
												</tbody>
											</table>

											<div id="divMAWorkOrderData" style="width: 100%;">
												Work Orders<br />
											</div>

											<div id="divMAReceivingData" style="width:100%;">
												Receiving<br />
											</div>

											<div id="divMAShippingData" style="width: 100%;">
												Shipping<br />
											</div>

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
														<input type="hidden" id="hfShipNbrMC" value="0" />
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
													<td colspan="9" style="line-height: 10px; height: 10px;border:none;">&nbsp;
													</td>
												</tr>
												<tr id="trManCredRow07">
													<td colspan="9" style="text-align: right;border:none;">&nbsp;<label id="lblCustReqCopyManCred2" style="color: darkred; font-weight: bold;">Customer REQUIRES COPY of revised invoice:</label>&nbsp;
														<input type="checkbox" id="chkMCCustReqCopyE" />
													</td>
												</tr>
												<tr id="trManCredRow06" style="border: 1px solid gray;">
													<td colspan="6" style="text-align: center; font-size: 11pt; color: darkblue; border: 1px solid gray; background-color: aquamarine">Reason&nbsp;for&nbsp;Credit/Invoice&nbsp;Adjustment	
													</td>
													<td colspan="3" style="text-align: center; font-size: 11pt; color: darkblue; border: 1px solid gray; background-color: aquamarine">Adjustment&nbsp;Amounts
													</td>
												</tr>
												<tr id="trManCredRow10">
													<td class="StdTableCellWBorder" colspan="6" rowspan="3">&nbsp;
														<textarea id="txaReasonForAdjMCE" class="InputTextWNoBorder" style="width: 98%; height: 80px;"></textarea>
													</td>
													<td class="StdTableCellWBorder" colspan="2" style="text-align: right; background-color: aquamarine;">Original Invoice Amount:&nbsp;
													</td>
													<td class="StdTableCellWBorder" style="text-align: right;">
														<input type="text" id="txtManCredOrigInvAmt" class="InputNbrWNoBorder" style="width: 160px" onchange="javascript:UpdateTotalAdjustmentMC();return false;" />&nbsp;
													</td>
												</tr>
												<tr id="trManCredRow11">
													<td class="StdTableCellWBorder" colspan="2" style="text-align: right; background-color: aquamarine;">Adjusted Invoice Amount:&nbsp;
													</td>
													<td class="StdTableCellWBorder" style="text-align: right;">
														<input type="text" id="txtManCredAdjInvAmt" class="InputNbrWNoBorder" style="width: 160px" onchange="javascript:UpdateTotalAdjustmentMC();return false;" />&nbsp;
													</td>
												</tr>
												<tr id="trManCredRow12">
													<td class="StdTableCellWBorder" colspan="2" style="text-align: right; background-color: aquamarine;">Adjustment Amount:&nbsp;
													</td>
													<td class="StdTableCellWBorder" style="text-align: right;">
														<input type="text" id="txtManCredAdjustAmt" class="InputNbrWNoBorder" style="width: 160px" />&nbsp;
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
														<label id="lblVendorIdentVC" style="font-weight: bold; color: darkblue;">Vendor:</label>&nbsp;<input type="text" id="txtVendorClaimIdentVC" style="width: 200px;" />
														<input type="hidden" id="hfVendorCodeVCE" value="" />
														<input type="hidden" id="hfInvRequestIDVC" value="" />
														<input type="hidden" id="hfShipNbrVC" value="0" />
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
														<input type="text" id="txtOrigInvoiceAmtVC" class="InputNbrWNoBorder" style="width: 120px" onchange="javascript:UpdateTotalAmtVC();return false;" />
													</td>
												</tr>
												<tr id="trVendClaimRow08">
													<td class="StdTableCellWBorder" colspan="2" style="text-align: right; background-color: aquamarine;">Adjustment:&nbsp;
													</td>
													<td class="StdTableCellWBorder" style="text-align: center;">
														<input type="text" id="txtAdjInvoiceAmtVC" class="InputNbrWNoBorder" style="width: 120px" onchange="javascript:UpdateTotalAmtVC();return false;" />
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
					<div id="divTab2" style="border: none; width: 100%; height: 100%; display: none; margin: 0px; overflow: scroll;padding:2px;">

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
					<div id="divTab3" style="border: none; width: 100%; height: 100%; display: none; margin: 0px; overflow: scroll;padding:2px;">

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
							<div id="divAttachmentHdr" style="width: 100%;">
								<label id="lblAttachmentsHdr" style="color: darkgreen; font-weight: bold; font-size: 14pt;">Attachments</label>
							</div>
							<div id="divAttachmentList" style="width: 100%;">
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
					<div id="divTab4" style="border: none; width: 100%; height: 100%; display: none; margin: 0px; overflow: scroll;padding:2px;">
						<div id="divHelpHdr" style="width: 100%;">
							<label id="lblHelpHdr" style="color: darkgreen; font-weight: bold; font-size: 14pt;">Help Information</label>
						</div>
						<div id="divHelpData" style="width: 100%;">
							<table id="tblHelpData" style="border:none;border-spacing:0px;padding:1px;">
							<tr>
								<td style="width:50px;text-align:center;">1.</td>
								<td>
									<span style="color:maroon;">Single quote and ; characters are dangerous on any web site.</span>	We recommend you do not use them on this site. The accent key (under the ~ on the keyboard) can be used.
								</td>
							</tr>
							<tr><td colspan="2" style="line-height:8px;">&nbsp;</td></tr>
							<tr><td class="HelpHdrLine" colspan="2">Customer Claim</td></tr>
							<tr>
								<td class="HelpNbrCell">1.</td>
								<td><strong>Required fields</strong> include Customer Name, Region, Mill, Brief Description of claim block, and Salesman/Lead.
								</td>
							</tr>
							<tr><td class="HelpHdrLine" colspan="2">Freight Accrual</td></tr>
							<tr>
								<td class="HelpNbrCell">1.</td>
								<td><strong>Required fields</strong> include Date Requested, Requested By, Sales Rep, Credit Rep, Sales Lead, Shipped From Location Code, Customer Name, S/O Number, Invoice #, Reason Code,
									Reason for Adjustment, and amount fields.
								</td>
							</tr>
							<tr><td class="HelpHdrLine" colspan="2">Invoice Adjustment</td></tr>
							<tr>
								<td class="HelpNbrCell">1.</td>
								<td><strong>Required fields</strong> include Date Requested, Requested By, Sales Rep, Credit Rep, Sales Lead, Shipped From Location Code, Customer Name, S/O Number, Invoice #, Reason Code,
								Reason for Adjustment, and amount fields.
								</td>
							</tr>
							<tr>
								<td class="HelpNbrCell">2.</td>
								<td>At least one product line is required and Adjustment Amount must be > 0.
								</td>
							</tr>
							<tr><td class="HelpHdrLine" colspan="2">Inventory Change</td></tr>
							<tr>
								<td class="HelpNbrCell">1.</td>
								<td><strong>Required fields</strong> include Location, Detailed Explanation, Qty, Product Type, Product, and all attributes that uniquely identify the item being changed for each line. At least one line is required.
								</td>
							</tr>
							<tr><td class="HelpHdrLine" colspan="2">Loss and Damage</td></tr>
							<tr>
								<td class="HelpNbrCell">1.</td>
								<td><strong>Required fields</strong> include Date, Customer, Number Type, Nbr, Loss & Damage Class, Explanation, and at least one Product Line. Product Line requires Product Type, Product, and Amount.
								</td>
							</tr>
							<tr>
								<td class="HelpNbrCell">2.</td>
								<td>Nbr field must contain an Order Number, Shipment Number, or Claim Number as identified by the Number Type field. Customer Nbr field should contain the customer's number pertaining to the claim.
								</td>
							</tr>
							<tr><td class="HelpHdrLine" colspan="2">MAC Adjustment</td></tr>
							<tr>
								<td class="HelpNbrCell">1.</td>
								<td>At least one line must be submitted having Product Type, Product, Description, Location, Reason, Cost ID, and both Current and Corect MAC Amounts.
								</td>
							</tr>
							<tr><td class="HelpHdrLine" colspan="2">Manual Credit</td></tr>
							<tr>
								<td class="HelpNbrCell">1.</td>
								<td><strong>Required fields</strong> include Date Requested, Requested By, Sales Rep, Credit Rep, Sales Lead, Shipped From Location Code, Customer Name, S/O Number, Invoice #, Reason Code,
								Reason for Adjustment, and amount fields. Adjustment Amount must be > 0.
								</td>
							</tr>
							<tr><td class="HelpHdrLine" colspan="2">Return Manifest</td></tr>
							<tr>
								<td class="HelpNbrCell">1.</td>
								<td><strong>Required fields</strong> include Requested Rtn Date, Requested By, Credit Rep, Sales Lead, Shipped From Location Code, Customer Name, S/O Number, Invoice #, Reason Code,
								Reason for Return, and at least one Manifest Product line. Product line must include ProdType & Code, and Quantity.
								</td>
							</tr>
							<tr><td class="HelpHdrLine" colspan="2">Vendor Claim</td></tr>
							<tr>
								<td class="HelpNbrCell">1.</td>
								<td><strong>Required fields</strong> include Date Requested, Requested By, Sales Rep, Credit Rep, Sales Lead, Shipped From Location Code, Customer Name, S/O Number, Invoice #, Reason Code,
								Reason for Adjustment, and all three amount fields.
								</td>
							</tr>
							</table>
						</div>
					</div>
				</div>

				<!----------------------------------------- FOOTER PORTION ----------------------------------------------->

				<div id="divFormFooter" style="width: 100%; display: none;">
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
