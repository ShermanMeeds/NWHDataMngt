<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site.Master" AutoEventWireup="true" CodeBehind="ReportGen.aspx.cs" Inherits="DataMngt.report.ReportGen" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div id="divMainGen" style="width:99%;font-family:Calibri;font-size:10pt;">

	<style type="text/css">
		ul
		{
			color:Green;
			font-weight:bold;
		}
	
		ul#tabs { list-style-type: none; margin: 30px 0 0 0; padding: 0 0 0.3em 0; }
		ul#tabs li { display: inline; }
		ul#tabs li a { color: #42454a; background-color: #dedbde; border: 1px solid #c9c3ba; border-bottom: none; padding: 0.3em; text-decoration: none; }
		ul#tabs li a:hover { background-color: #f1f0ee; }
		ul#tabs li a.selected { color: #000; background-color: #f1f0ee; font-weight: bold; padding: 0.7em 0.3em 0.38em 0.3em; }
		div.tabContent { border: 1px solid #c9c3ba; padding: 0.5em; background-color: #f1f0ee; }

	</style>

	<script type="text/javascript">
		// establish global variables
		var rid = 0;
		var jiPageID = 2;
		var jsPageVers = '1.0.0';
		var jsPageVersDate = '6/22/2015';
		var today = new Date();
		var tabsVisible = 1;
		var IsTranslated = 0;
		var lastValue = '';

		var jbGenUser = true;
		var jbIsAdmin = false;
		var jbParamVisible = true;
		var jsReportID = 0;
		var jsEmpID = 0;
		var jsBrowserType = '';
		var jsLastParams = '';
		var jbIsLoadedTab1 = false;
		var jbIsLoadedTab2 = false;
		var jbIsLoadedTab3 = false;
		var jbIsLoadedTab4 = false;
		var jbIsLoadedTab5 = false;
		var jbIsLoadedTab6 = false;
		var jbIsLoadedTab7 = false;
		var jbIsLoadedTab8 = false;
		var jbShowFilterDates = false;
		var jbShowFilterProj = false;
		var jbShowFilterGD = false;
		var jbShowFilterGL = false;
		var jbShowFilterGR = false;
		var jbShowFilterGG = false;
		var jbShowFilterStat = false;
		var jbShowFilterSettings = false;
		var jbShowFilterSort = false;
		var jbTab1Shown = false;
		var jbTab2Shown = false;
		var jbTab3Shown = false;
		var jbTab4Shown = false;
		var jbTab5Shown = false;
		var jbTab6Shown = false;
		var jbTab7Shown = false;
		var jbTab8Shown = false;
		var jbGroupBy = false;
		var jbUseGroupings = false;
		var jiCurrentPage = 9;
		var jiPageSize = 20;
		var jiTotalPages = 0;
		var jiProjFilter = 0;
		var jiTaskFilter = 0;
		var jiEmpFilter = 0;
		var jiSupFilter = 0;
		var jiGroupByCol = 0;
		var jssUserName = '';
		var jssDeptName = '';
		var jssFirstName = '';
		var jssLastName = '';
		var jssFullName = '';
		var jsbIsContractor = false;
		var jsbIsEmpMngr = false;
		var jsbIsProjAdmin = false;
		var jsbIsAdmin = false;
		var jsbIsHR = false;
		var jsbIsProjMngr = false;
		var jsbIsFinMgr = false;
		var jsbIsFinWkr = false;

		// report settings
		var jsbAllowSurrogates = false;
		var jsbSetGridLines = false;
		var jsbSetPaginate = false;
		var jsbShowAggregates = false;
		var jsbShowCount = false;
		var jsbSetPageSz = 0; // 'w:8.5";h:11"';
		var jsfSetFontSize = 10;
		var jsfSetMargLeft = 0.5;
		var jsfSetMargRight = 0.5;
		var jsfSetPadTop = 0;
		var jsfSetPadBottom = 0;
		var jssSetFontFam = 'Calibri';
		var jssSetForeColor = '#000000';
		var jssSetInGridCSS = '';
		var jssSetOutGridCSS = '';
		var jssSetRptTitle = '';
		var jssSetUserName = '';
		var jssSetHeaderMsg = '';
		var jssSetFooterMsg = '';
		var jstStatusMsg = '';

		var ThisReportList;
		var ThisReportAttributes;
		var ThisReportStructure;
		var ThisReportData;
		var ThisEmpIDList;
		var ThisProjIDList;
		var ThisTaskIDList;
		var ThisGroupIDList;
		var ThisDeptIDList;
		var ThisLocIDList;
		var ThisRoleIDList;
		var ThisStatusList;
		var ThisSortList;
		var ThisSupervisorList;
		var ThisUserData;

		var jsParamBeginDate = '';
		var jsParamEndDate = '';
		var jsParamTgtDate = '';
		var jsParamEmpID = 0;
		var jsParamDeptID = 0;
		var jsParamRoleID = 0;
		var jsParamGroupID = 0;
		var jsParamLocID = 0;
		var jsParamProjID = 0;
		var jsParamTaskID = 0;
		var jsParamSupID = 0;
		var jsParamProjCode = '';
		var jsParamProjName = '';
		var jsParamTaskCode = '';
		var jsParamTaskName = '';
		var jsParamEmpNameL = '';
		var jsParamEmpNameF = '';
		var jsParamMgrNameL = '';
		var jsParamMgrNameF = '';
		var jsParamStatusID = 0;
		var jsParamPayPrdID = 0;
		var jsParamSubClass = 0;
		var jsParamSort = 0;

		var jsoDivBottomBtn;
		var jsoDivParmSection;
		var jsoDivButtonBar;
		var jsoDivDateRange;
		var jsoDivDeptData;
		var jsoDivEmpData;
		var jsoDivEmpFLName;
		var jsoDivEmployeeDataBlock;
		var jsoDivEmpListData;
		var jsoDivEmpNameBlock;
		var jsoSpnEmpName1;
		var jsoDivFiltersBlock;
		var jsoDivGroupBy;
		var jsoDivGroupByContent;
		var jsoDivLocData;
		var jsoDivProjData;
		var jsoDivProjList;
		var jsoDivProjTextID;
		var jsoDivReportFtr;
		var jsoDivReportHdr;
		var jsoDivReportMain;
		var jsoDivReportPg;
		var jsoDivReportView;
		var jsoDivRoleData;
		var jsoDivSettings;
		var jsoDivSettings1;
		var jsoDivSorting;
		var jsoDivStatusData;
		var jsoDivSupData;
		var jsoDivSupList;
		var jsoDivSupName;
		//var jsoDivSupNameBlock;
		var jsoDivTaskData;
		var jsoDivTaskIdent;
		var jsoDivTaskList;
		var jsoLblNbrPage;
		var jsoLblPgNbr;
		var jsoLblParamsChosen;
		var jsoSpnEmpData;
		var jsoSpnProjLbl;
		var jsoSpnStatusLbl;
		var jsoSpnSupLbl;
		var jsoTblMain;
		var jsoTabs;
		var jsoTab1;
		var jsoTab2;
		var jsoTab3;
		var jsoTab4;
		var jsoTab5;
		var jsoTab6;
		var jsoTab7;
		var jsoTab8;
		var jsoToggleBtn;
		var jsoTxtBeginDt;
		var jsoTxtEndDt;

		var jsfHfRptName;
		var jsfProjCode;
		var jsfProjName;
		var jsfTaskCode;
		var jsfTaskName;
		var jsfEmpID;
		var jshEmpID;
		var jsfEmpLastName;
		var jsfEmpFirstName;
		var jsfMgrLastName;
		var jsfMgrFirstName;
		var	sfHfStartDt;
		var jsfHfEndDt;
		var jsfHfProjID;
		var jsfHfTaskID;
		var jsfHfPCode;
		var jsfHfPName;
		var jsfHfTCode;
		var jsfHfTName;
		var jsfHfLastName;
		var jsfHfFirstName;
		var jsfHfMiddleName;
		var jsfHfMgrID;
		var jsfHfMgrLast;
		var jsfHfMgrFirst;
		var jsfHfRoleID;
		var jsfHfGroupID;
		var jsfHfLocID;
		var jsfHfDeptID;
		var jsfHfSupID;
		var jsfHfStatusID;
		var jsfHfSortID;
		var jsfHfProjText;
		var jsfHfTaskText;
		var jsfHfRoleText;
		var jsfHfGroupText;
		var jsfHfLocText;
		var jsfHfDeptText;
		var jsfHfStatusText;
		var jsfHfSortText;
		var jsfHfMgrText;
		var jsfHfPEmpName;
		var jsfHfPEmpID;
		var jsfHfPaginationText;
		var jsfHfSumOnly;
		var jsfHfExcludeEmpty;
		var jssReportList;
		var jssEmpList;
		var jssProjList;
		var jssTaskList;
		var jssDeptList;
		var jssLocationList;
		var jssRoleList;
		var jssGroupList;
		var jssSupervisorList;
		var jssStatusList;
		var jssSortList;
		var jssPagination;

		$(":submit").closest("form").submit(function () {
			$(':submit').attr('disabled', 'disabled');
		});

		$(document).ready(function () {
			//alert('Ready Start');
			jsoDivBottomBtn = document.getElementById('C_divBottomBtn');
			jsoDivParmSection = document.getElementById('divParamSection');
			jsoDivButtonBar = document.getElementById('divButtonBar');
			jsoDivDateRange = document.getElementById('divDateRange');
			jsoDivDeptData = document.getElementById('divDeptData');
			jsoDivEmpData = document.getElementById('divEmpData');
			jsoDivEmpFLName = document.getElementById('divEmpLastFirstName');
			jsoDivEmpListData = document.getElementById('divEmpListData');
			jsoDivEmpNameBlock = document.getElementById('divEmpNameBlock');
			jsoDivEmployeeDataBlock = document.getElementById('divEmployeeDataBlock');
			jsoDivFiltersBlock = document.getElementById('divFiltersBlock');
			jsoDivGroupBy = document.getElementById('divGroupBy');
			jsoDivGroupByContent = document.getElementById('divGroupByContent');
			jsoDivGroupData = document.getElementById('divGroupData');
			jsoDivLocData = document.getElementById('divLocationData');
			jsoDivProjData = document.getElementById('divProjData');
			jsoDivProjList = document.getElementById('divProjList');
			jsoDivProjTextID = document.getElementById('divProjTextID');
			jsoDivReportFtr = document.getElementById('divReportFtr');
			jsoDivReportHdr = document.getElementById('divReportHdr');
			jsoDivReportMain = document.getElementById('divReportMain');
			jsoDivReportPg = document.getElementById('divReportMainPg');
			jsoDivReportView = document.getElementById('C_divReportView');
			jsoDivRoleData = document.getElementById('divRoleData');
			jsoDivSettings = document.getElementById('divSettings');
			jsoDivSettings1 = document.getElementById('divSettings1');
			jsoDivSorting = document.getElementById('divSorting');
			jsoDivStatusData = document.getElementById('divStatusData');
			jsoDivSupData = document.getElementById('divSupervisorData');
			jsoDivSupList = document.getElementById('divSupList');
			jsoDivSupName = document.getElementById('divSupervisorName');
			//jsoDivSupNameBlock = document.getElementById('divSupNameBlock');
			jsoDivTaskData = document.getElementById('divTaskData');
			jsoDivTaskIdent = document.getElementById('divTaskCodeIdent');
			jsoLblNbrPage = document.getElementById('lblNbrPages');
			jsoLblPgNbr = document.getElementById('lblPageNbr');
			jsoLblParamsChosen = document.getElementById('C_lblParamsChosen');
			jsoDivTaskList = document.getElementById('divTaskList');
			jsoSpnEmpData = document.getElementById('spnEmpData');
			jsoSpnProjLbl = document.getElementById('spnProjLbl');
			jsoSpnStatusLbl = document.getElementById('spnStatusLbl');
			jsoSpnSupLbl = document.getElementById('spnSupervisorLbl');
			jsoTabs = document.getElementById('tabs');
			jsoTab1 = document.getElementById('tabs-1');
			jsoTab2 = document.getElementById('tabs-2');
			jsoTab3 = document.getElementById('tabs-3');
			jsoTab4 = document.getElementById('tabs-4');
			jsoTab5 = document.getElementById('tabs-5');
			jsoTab6 = document.getElementById('tabs-6');
			jsoTab7 = document.getElementById('tabs-7');
			jsoTab8 = document.getElementById('tabs-8');
			jsoToggleBtn = document.getElementById('btnToggleTabDisplay');
			jsoTblMain = document.getElementById('tblMainData');
			jsoTxtBeginDt = document.getElementById('txtBeginDate');
			jsoTxtEndDt = document.getElementById('txtEndDate');
			jssReportList = document.getElementById('selReport');
			jssEmpList = document.getElementById('selEmpList');
			jssProjList = document.getElementById('selProjectList');
			jssTaskList = document.getElementById('selTaskList');
			jssDeptList = document.getElementById('selDeptID');
			jssLocationList = document.getElementById('selLocationID');
			jssRoleList = document.getElementById('selRoleID');
			jssGroupList = document.getElementById('selGroupID');
			jssSupervisorList = document.getElementById('selSupervisorID');
			jssStatusList = document.getElementById('selStatusID');
			jssSortList = document.getElementById('selSortList');
			jssPagination = document.getElementById('selPagination');
			jsfProjCode = document.getElementById('txtProjCode');
			jsfProjName = document.getElementById('txtProjName');
			jsfTaskCode = document.getElementById('txtTaskCode');
			jsfTaskName = document.getElementById('txtTaskName');
			jsfEmpID = document.getElementById('txtEmpID');
			jshEmpID = document.getElementById('hfTargetEmpID');
			jsfEmpLastName = document.getElementById('txtLastName');
			jsfEmpFirstName = document.getElementById('txtFirstName');
			jsfMgrLastName = document.getElementById('txtSupLastName');
			jsfMgrFirstName = document.getElementById('txtSupFirstName');
			jsfHfStartDt = document.getElementById('C_hfStartDt');
			jsfHfEndDt = document.getElementById('C_hfEndDt');
			jsfHfProjID = document.getElementById('C_hfProjID');
			jsfHfTaskID = document.getElementById('C_hfTaskID');
			jsfHfPCode = document.getElementById('C_hfPCode');
			jsfHfPName = document.getElementById('C_hfPName');
			jsfHfTCode = document.getElementById('C_hfTCode');
			jsfHfTName = document.getElementById('C_hfTName');
			jsfHfLastName = document.getElementById('C_hfLastName');
			jsfHfFirstName = document.getElementById('C_hfFirstName');
			jsfHfMiddleName = document.getElementById('C_hfMiddleName');
			jsfHfMgrID = document.getElementById('C_hfMgrID');
			jsfHfMgrLast = document.getElementById('C_hfMgrLast');
			jsfHfMgrFirst = document.getElementById('C_hfMgrFirst');
			jsfHfRoleID = document.getElementById('C_hfRoleID');
			jsfHfGroupID = document.getElementById('C_hfGroupID');
			jsfHfLocID = document.getElementById('C_hfLocID');
			jsfHfDeptID = document.getElementById('C_hfDeptID');
			jsfHfSupID = document.getElementById('C_hfSupID');
			jsfHfStatusID = document.getElementById('C_hfStatusID');
			jsfHfSortID = document.getElementById('C_hfSortID');
			jsfHfProjText = document.getElementById('C_hfSortID');
			jsfHfTaskText = document.getElementById('C_hfSortID');
			jsfHfRoleText = document.getElementById('C_hfSortID');
			jsfHfGroupText = document.getElementById('C_hfSortID');
			jsfHfLocText = document.getElementById('C_hfSortID');
			jsfHfDeptText = document.getElementById('C_hfSortID');
			jsfHfStatusText = document.getElementById('C_hfSortID');
			jsfHfSortText = document.getElementById('C_hfSortID');
			jsfHfMgrText = document.getElementById('C_hfMgrText');
			jsfHfPEmpName = document.getElementById('C_hfPEmpName');
			jsfHfPEmpID = document.getElementById('C_hfPEmpID');
			jsfHfRptName = document.getElementById('C_hfRptName');
			jsfHfPaginationText = document.getElementById('C_hfPaginationText');
			jsfHfSumOnly = document.getElementById('C_hfSumOnly');
			jsfHfExcludeEmpty = document.getElementById('C_hfExcludeEmpty');
			jstStatusMsg = document.getElementById('C_lblStatusMsg');

			// set tabs initial view
			//jsoTabs.style.display = 'block';
			tabsVisible = 1;
			jbIsLoadedTab1 = false;
			jbIsLoadedTab2 = false;
			jbIsLoadedTab3 = false;
			jbIsLoadedTab4 = false;
			jbIsLoadedTab5 = false;
			jbIsLoadedTab6 = false;
			jbIsLoadedTab7 = false;
			jbIsLoadedTab8 = false;
			jbShowFilterDates = false;
			jbShowFilterProj = false;
			jbShowFilterGD = false;
			jbShowFilterGL = false;
			jbShowFilterGR = false;
			jbShowFilterGG = false;
			jbShowFilterStat = false;
			jbShowFilterSort = false;
			jiProjFilter = 0;
			jiTaskFilter = 0;
			jiEmpFilter = 0;
			jiSupFilter = 0;
			jbParamVisible = true;
			jiCurrentPage = 0;
			jiTotalPages = 0;
			jiPageSize = 20;

			//alert('Loading global page initialization values');
			jsReportID = parseInt(jsgReportID, 10); // document.getElementById('C_hfRptID').value;  //affected by master page
			jsEmpID = parseInt(jsgEmpID, 10); // document.getElementById('C_hfEmpID').value;  //affected by master page
			jsBrowserType = jsgBrowserType; // document.getElementById('C_hfBT').value;  //affected by master page
			jbIsAdmin = jsgA;

			ThisPageInitialization();
			//alert('Page Initiated!');
			var dt = new Date();
			jsoDivReportView.style.display = 'none';
			jsoDivReportHdr.style.display = 'none';
			//alert('Inserting user name');
			document.getElementById('C_lblUserName').innerHTML = jssUserName; //affected by master page

			// Tab initialization
			$("#liTab1").on("click", function () {
				if (jbIsLoadedTab1 === false) {
					dt = getLastMonday(today);
					jsoTxtBeginDt.value = getMyDateString(dt, 1, 0);
					jsoTxtEndDt.value = getMyDateString(dt, 1, 6);
					jsfHfStartDt.value = jsoTxtBeginDt.value;
					jsfHfEndDt.value = jsoTxtEndDt.value;

					jbIsLoadedTab1 = true;
					//alert('Show Tab1');
					showTabContents(1);
					jsoTab1.style.height = '100px';
					jsoTab2.style.height = '100px';
					jsoTab3.style.height = '100px';
					jsoTab4.style.height = '100px';
					jsoTab5.style.height = '100px';
					jsoTab6.style.height = '100px';
					jsoTab7.style.height = '100px';
					jsoTab8.style.height = '100px';
				}
			});
			$("#liTab2").on("click", function () {
				if (jbIsLoadedTab2 === false) {
					if (jiProjFilter === 1) {
						//alert('Loading Proj List');
						LoadProjIDList();
					}
					jbIsLoadedTab2 = true;
					showTabContents(2);
					jsoTab1.style.height = '100px';
					jsoTab2.style.height = '100px';
					jsoTab3.style.height = '100px';
					jsoTab4.style.height = '100px';
					jsoTab5.style.height = '100px';
					jsoTab6.style.height = '100px';
					jsoTab7.style.height = '100px';
					jsoTab8.style.height = '100px';
				}
			});
			$("#liTab3").on("click", function () {
				if (jbIsLoadedTab3 === false) {
					if (jiEmpFilter === 1) {
						LoadEmpIDList();
					}
					if (jiSupFilter === 1) {
						LoadSupervisorIDList();
					}
					if (jiSupFilter === 9) {
						jsoSpnEmpData.innerHTML = 'My Data';
					}
					jbIsLoadedTab3 = true;
					jsoTab1.style.height = '100px';
					jsoTab2.style.height = '100px';
					jsoTab3.style.height = '100px';
					jsoTab4.style.height = '100px';
					jsoTab5.style.height = '100px';
					jsoTab6.style.height = '100px';
					jsoTab7.style.height = '100px';
					jsoTab8.style.height = '100px';
					showTabContents(3);
				}
			});
			$("#liTab4").on("click", function () {
				if (jbIsLoadedTab4 === false) {
					if (jbShowFilterGD) {
						LoadDeptIDList();
					}
					if (jbShowFilterGL) {
						LoadLocIDList();
					}
					if (jbShowFilterGR) {
						LoadRoleIDList();
					}
					if (jbShowFilterGG) {
						LoadGroupIDList();
					}
					jbIsLoadedTab4 = true;
					jsoTab1.style.height = '100px';
					jsoTab2.style.height = '100px';
					jsoTab3.style.height = '100px';
					jsoTab4.style.height = '100px';
					jsoTab5.style.height = '100px';
					jsoTab6.style.height = '100px';
					jsoTab7.style.height = '100px';
					jsoTab8.style.height = '100px';
					showTabContents(4);
				}
			});
			$("#liTab5").on("click", function () {
				if (jbIsLoadedTab5 === false) {
					if (jiProjFilter > 0) {
						LoadStatusList(3);
					}
					else {
						//if (jiEmpFilter > 0) {
							LoadStatusList(2);
						//}
					}
					//alert('Fired!');
					jbIsLoadedTab5 = true;
					jsoTab1.style.height = '100px';
					jsoTab2.style.height = '100px';
					jsoTab3.style.height = '100px';
					jsoTab4.style.height = '100px';
					jsoTab5.style.height = '100px';
					jsoTab6.style.height = '100px';
					jsoTab7.style.height = '100px';
					jsoTab8.style.height = '100px';
					showTabContents(5);
				}
			});
			$("#liTab6").on("click", function () {
				if (jbIsLoadedTab6 === false) {
					jbIsLoadedTab6 = true;
					jsoTab1.style.height = '100px';
					jsoTab2.style.height = '100px';
					jsoTab3.style.height = '100px';
					jsoTab4.style.height = '100px';
					jsoTab5.style.height = '100px';
					jsoTab6.style.height = '100px';
					jsoTab7.style.height = '100px';
					jsoTab8.style.height = '100px';
					showTabContents(6);
				}
			});
			$("#liTab7").on("click", function () {
				if (jbIsLoadedTab7 === false) {
					//alert('Fired!');
					LoadSortList();
					jbIsLoadedTab7 = true;
					jsoTab1.style.height = '100px';
					jsoTab2.style.height = '100px';
					jsoTab3.style.height = '100px';
					jsoTab4.style.height = '100px';
					jsoTab5.style.height = '100px';
					jsoTab6.style.height = '100px';
					jsoTab7.style.height = '100px';
					jsoTab8.style.height = '100px';
					showTabContents(7);
				}
			});
			$("#liTab8").on("click", function () {
				if (jbIsLoadedTab8 === false) {
					//alert('Fired!');
					LoadGroupByList();
					jbIsLoadedTab8 = true;
					jsoTab1.style.height = '100px';
					jsoTab2.style.height = '100px';
					jsoTab3.style.height = '100px';
					jsoTab4.style.height = '100px';
					jsoTab5.style.height = '100px';
					jsoTab6.style.height = '100px';
					jsoTab7.style.height = '100px';
					jsoTab8.style.height = '100px';
					showTabContents(8);
				}
			});

			return false;
		});

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

		function ThisPageInitialization() {
			dt = getLastMonday(today);
			jsoTxtBeginDt.value = getMyDateString(dt, 1, 0);
			jsoTxtEndDt.value = getMyDateString(dt, 1, 6);
			jsfHfStartDt.value = jsoTxtBeginDt.value;
			jsfHfEndDt.value = jsoTxtEndDt.value;

			//alert('Loading user data');
			LoadUserBaseData();
			//alert('Loading report list');
			LoadReportList();
			//alert('Page initialized!');
			return false;
		}

		// ***************************************************
		// UI MODIFICATION FUNCTIONS
		// ***************************************************

		// Set parameter blocks for user based on Report ID
		function SetReportParamView(plist) {
			var dt = new Date();
			var obj = null;
			var v = '';
			var v1 = 0;
			var incSurrogates = 0;
			jbTab1Shown = false;
			jbTab2Shown = false;
			jbTab3Shown = false;
			jbTab4Shown = false;
			jbTab5Shown = false;
			jbTab6Shown = false;
			jbTab7Shown = false;
			// get report data
			jsReportID = parseInt(plist.value, 10);
			//alert(jsReportID);
			LoadReportHeader();
			LoadReportStructure();

			// hide all major elements - only show necessary ones later
			jsoDivDateRange.style.display = 'none';
			jsoDivEmpData.style.display = 'none';
			jsoDivDeptData.style.display = 'none';
			jsoDivLocData.style.display = 'none';
			jsoDivRoleData.style.display = 'none';
			jsoDivGroupData.style.display = 'none';
			jsoDivSupData.style.display = 'none';
			jsoDivStatusData.style.display = 'none';
			jsoDivSettings.style.display = 'none';
			jsoDivSorting.style.display = 'none';
			jsoDivReportView.style.display = 'none';
			jsoDivProjData.style.display = 'none';
			jsoDivProjList.style.display = 'none';
			jsoDivTaskList.style.display = 'none';
			jsoDivTaskIdent.style.display = 'none';
			jsoDivProjTextID.style.display = 'none';
			jsoDivSupList.style.display = 'none';
			jsoDivTaskData.style.display = 'none';
			jsfTaskCode.style.display = 'none';
			jsfTaskName.style.display = 'none';
			jsfProjCode.style.display = 'none';
			jsfProjName.style.display = 'none';
			jsoTab1.style.display = 'none';
			jsoTab2.style.display = 'none';
			jsoTab3.style.display = 'none';
			jsoTab4.style.display = 'none';
			jsoTab5.style.display = 'none';
			jsoTab6.style.display = 'none';
			jsoTab7.style.display = 'none';
			jsoTab8.style.display = 'none';
			jiProjFilter = 0;
			jiTaskFilter = 0;
			jiEmpFilter = 0;
			jiSupFilter = 0;
			jbShowFilterDates = true;
			jbShowFilterStat = false;
			jbShowFilterSort = false;
			jbShowFilterSettings = false;

			// display parameter tab controls
			//jsoTabs.style.display = 'none';
			tabsVisible = 1;
			jbIsLoadedTab1 = false;
			jbIsLoadedTab2 = false;
			jbIsLoadedTab3 = false;
			jbIsLoadedTab4 = false;
			jbIsLoadedTab5 = false;
			jbIsLoadedTab6 = false;
			jbIsLoadedTab7 = false;
			jsbAllowSurrogates = false;
			dt = new Date();

			//alert(jsReportID);
			if (ThisReportAttributes[0].AllowSurrogates) {
				incSurrogates = 1;
				jsbAllowSurrogates = true;
			}
			jsRptHeaderMsg = ThisReportAttributes[0].RptHeaderMsg;
			jsRptFooterMsg = ThisReportAttributes[0].RptFooterMsg;
			jsbShowCount = false;
			if (ThisReportAttributes[0].ShowCountAtEnd) {jsbShowCount = true; }

			if (ThisReportAttributes[0].FilterDateRange) {
				jbShowFilterDates = true;
			}
			jiProjFilter = parseInt(ThisReportAttributes[0].FilterProj, 10);
			jiTaskFilter = parseInt(ThisReportAttributes[0].FilterTask, 10);
			//Employee data
			jiEmpFilter = parseInt(ThisReportAttributes[0].FilterEmp, 10);
			// Supervisor data
			jiSupFilter = parseInt(ThisReportAttributes[0].FilterSupervisor, 10);

			jbShowFilterGD = false;
			if (parseInt(ThisReportAttributes[0].FilterDept, 10) === 1) { jbShowFilterGD = true; }
			jbShowFilterGL = false;
			if (parseInt(ThisReportAttributes[0].FilterLoc, 10) === 1) { jbShowFilterGL = true; }
			jbShowFilterGR = false;
			if (parseInt(ThisReportAttributes[0].FilterRole, 10) === 1) { jbShowFilterGR = true; }
			jbShowFilterGG = false;
			if (parseInt(ThisReportAttributes[0].FilterGroup, 10) === 1) { jbShowFilterGG = true; }

			if (ThisReportAttributes[0].FilterDateRange) { jbShowFilterDates = true; }
			if (ThisReportAttributes[0].FilterStatus) {	jbShowFilterStat = true; }
			if (ThisReportAttributes[0].AllowSorting) { jbShowFilterSort = false; }
			if (ThisReportAttributes[0].Settings) { jbShowFilterSettings = false; }

			//alert('About to display tabs');
			if (jiProjFilter > 0) { jsoDivProjData.style.display = 'block'; }

			jsoDivParmSection.style.display = 'block';
			jsoTabs.style.display = 'block';
			tabsVisible = 1;
			jiCurrentPage = 1;
			jiTotalPages = 1;
			jiPageSize = 20;
			return false;
		}

		function ExtractReportData() {
			//alert('Fired Extract Report Data!');
			LoadReportHeader();
			if (ThisReportAttributes === undefined || ThisReportAttributes === null) {
				alert('Could not load report attributes because of an error');
			}
			LoadReportStructure();
			if (ThisReportStructure === undefined || ThisReportStructure === null) {
				alert('Report structural design data could not be loaded.');
			}
			//alert('Structure stuff loaded');
			jiCurrentPage = 1;
			jiPageSize = jssPagination[jssPagination.selectedIndex].value;
			if (jiPageSize === undefined || jiPageSize === null || jiPageSize === '0') {
				jiPageSize = '20';
			}
			//alert('Getting Report Paged data');
			GetReportPageData(jiCurrentPage);
		}

		function GetReportPageData(pg) {
			//alert('Fired page data load!');
			jsoDivBottomBtn.style.display = 'none';
			var url = '';
			var MyParams = new Object();
			var v = 0;
			var obj;
			var v1 = ''; // chksumonly
			var v2 = ''; // chkexcempties
			var v3 = '';
			var v4 = '';
			var v5 = '';
			var v6 = '';
			var v7 = '';
			var v8 = '';
			var v9 = '';
			var pcode = '';
			var pname = '';
			var tcode = '';
			var tname = '';
			var empL = '';
			var empF = '';
			var empM = '';
			var supL = '';
			var supF = '';
			var eid = '0';
			var mgrid = '0';
			var pid = '0';
			var tid = '0';
			var did = '0';
			var lid = '0';
			var rlid = '0';
			var gid = '0';
			var sid = '0';
			var stid = '0';
			var StartDt = '';
			var EndDt = '';
			var Sort = '0';

			// if report ID is not defined, get out
			//alert('Analyzing report ID ' + jsReportID);
			if (jsReportID === undefined || jsReportID === null) { return false; }
			if (jsReportID === 0) { return false; }

			// read any completed parameter
			//alert('setting parameters');
			var sDate = ''; 
			//convertStringDatetoFormat(sDt, typ)
			if (jsoTxtBeginDt !== undefined && jsoTxtBeginDt.value !== null) {
				sDate = jsoTxtBeginDt.value;
				StartDt = convertStringDatetoFormat(sDate, 0);
			}
			if (jsoTxtEndDt !== undefined && jsoTxtEndDt.value !== null) {
				sDate = jsoTxtEndDt.value;
				EndDt = convertStringDatetoFormat(sDate, 0);
			}
			if (jssProjList !== undefined && jssProjList.value !== null) { pid = jssProjList.value; }
			if (jssTaskList !== undefined && jssTaskList.value !== null) { tid = jssTaskList.value; }
			if (jssDeptList !== undefined && jssDeptList.value !== null) { did = jssDeptList.value; }
			if (jssLocationList !== undefined && jssLocationList.value !== null) { lid = jssLocationList.value; }
			if (jssRoleList !== undefined && jssRoleList.value !== null) { rlid = jssRoleList.value; }
			if (jssGroupList !== undefined && jssGroupList.value !== null) { gid = jssGroupList.value; }
			if (jssEmpList !== undefined && jssEmpList.value !== null) {
				eid = jssEmpList.value;
				if (eid.length === 0) {eid = '0'; }
			}
			if (jssSupervisorList !== undefined && jssSupervisorList.value !== null) { sid = jssSupervisorList.value; }
			if (jssStatusList !== undefined && jssStatusList.value !== null) {stid = jssStatusList.value; }
			if (jssSortList !== undefined && jssSortList.value !== null) {
				Sort = jssSortList.value;
				if (Sort === '-') {Sort = '0'; }
			}

			if (jsfProjCode !== undefined && jsfProjCode.value !== null) { pcode = CleanTextMinimalTx(jsfProjCode.value, 1); }
			if (jsfProjName !== undefined && jsfProjName.value !== null) { pname = StripSingleQuotesTx(jsfProjName.value); }
			if (jsfTaskCode !== undefined && jsfTaskCode.value !== null) { tcode = CleanTextMinimalTx(jsfTaskCode.value, 1); }
			if (jsfTaskName !== undefined && jsfTaskName.value !== null) { tname = StripSingleQuotesTx(jsfTaskName.value); }

			if (jshEmpID !== undefined && jshEmpID.value !== null) {
				eid = jshEmpID.value;
				if (eid.length === 0) { eid = '0'; }
			}
			if (jsfEmpLastName !== undefined && jsfEmpLastName.value !== null) { empL = CleanTextMinimalTx(jsfEmpLastName.value, 1); }
			if (jsfEmpFirstName !== undefined && jsfEmpFirstName.value !== null) { empF = CleanTextMinimalTx(jsfEmpFirstName.value, 1); }
			if (jsfMgrLastName !== undefined && jsfMgrLastName.value !== null) { supL = CleanTextMinimalTx(jsfMgrLastName.value, 1); }
			if (jsfMgrFirstName !== undefined && jsfMgrFirstName.value !== null) { supF = CleanTextMinimalTx(jsfMgrFirstName.value, 1); }
			//alert('initial setting parameters done');

			if (jiEmpFilter === 9) { eid = jsEmpID.toString(); }
			//alert('Eid: ' + eid + '/' + jiEmpFilter.toString() + '/' + jsEmpID.toString());

			var msg2 = '';
			obj = document.getElementById('chkSumOnly');
			if (obj !== undefined && obj !== null) {
				v = 0;
				if (obj.checked) { v = 1; }
				v1 = v.toString();
			}
			obj = document.getElementById('chkExcEmpties');
			if (obj !== undefined && obj !== null) {
				v = 0;
				if (obj.checked) { v = 1; }
				v2 = v.toString();
			}

			// clear data table
			jsoTblMain.deleteTHead();
			$("#tblMainData > tbody").html("");

			jiPageSize = jssPagination[jssPagination.selectedIndex].value;
			if (jiPageSize === undefined || jiPageSize === null || jiPageSize === '0') {
				jiPageSize = '20';
			}

			//alert(pg.toString() + '-' + jiPageSize.toString());
			if (StartDt.length > 0) { StartDt = StartDt.replace(/\//gi, '-'); }
			if (EndDt.length > 0) { EndDt = EndDt.replace(/\//gi, '-'); }
			// Extract data using AJAX call
			//alert('AJAX call');

			var grps = did + '-' + sid + '-' + rlid + '-' + gid + '-' + lid + '-' + stid + '-' + mgrid;
			var vAll = v1 + '-' + v2 + '-' + v3 + '-' + v4 + '-' + v5 + '-' + v6 + '-' + v7 + '-' + v8 + '-' + v9;
			var p1 = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','r':'" + jsReportID + "','StartDt':'" + StartDt + "','EndDt':'" + EndDt + "','e':'" + eid + "','p':'" + pid + "','t':'" + tid + "','g':'" + grps + "'";
			var p2 = ",'pcode':'" + pcode + "','pname':'" + pname + "', 'tcode':'" + tcode + "', 'tname':'" + tname + "'";
			var p3 = ",'NL':'" + empL + "','NF':'" + empF + "','NM':'" + empM + "','mgrL':'" + supL + "','mgrF':'" + supF + "', 'Mgrid':'" + mgrid + "'";
			var p4 = ",'v1':'" + vAll + "','Pg':'" + pg.toString() + "','PgSz':'" + jiPageSize.toString() + "'";
			var MyData = p1 + p2 + p3 + p4 + ",'Sort':'" + Sort + "','ByID':'" + jsEmpID.toString() + "'}";
			//alert(MyData);
			jsLastParams = MyData;
			url = '../Shared/TimeLiveController.asmx/ViewInternalReport';
			getJSONReturnData(url, MyData, function (response)
			{ ThisReportData = response; LoadAllReportData(); });
			return false;
		}

		function ExportReportData(typ) {
			//alert('Fired!');
			var url = '';
			var MyParams = new Object();
			var v = 0;
			var obj;
			var pcode = '';
			var pname = '';
			var tcode = '';
			var tname = '';
			var empL = '';
			var empF = '';
			var empM = '';
			var supL = '';
			var supF = '';
			var eid = '0';
			var mgrid = '0';
			var pid = '0';
			var tid = '0';
			var did = '0';
			var lid = '0';
			var rlid = '0';
			var gid = '0';
			var sid = '0';
			var stid = '0';
			var StartDt = '';
			var EndDt = '';
			var Sort = '0';

			// if report ID is not defined, get out
			//alert('Analyzing report ID ' + jsReportID);
			if (jsReportID === undefined || jsReportID === null) { return false; }
			if (jsReportID === 0) { return false; }

			// read any completed parameter
			//alert('setting parameters');
			if (jsoTxtBeginDt !== undefined && jsoTxtBeginDt.value !== null) { StartDt = jsoTxtBeginDt.value; }
			if (jsoTxtEndDt !== undefined && jsoTxtEndDt.value !== null) { EndDt = jsoTxtEndDt.value; }
			if (jssProjList !== undefined && jssProjList.value !== null) { pid = jssProjList.value; }
			if (jssTaskList !== undefined && jssTaskList.value !== null) { tid = jssTaskList.value; }
			if (jssDeptList !== undefined && jssDeptList.value !== null) { did = jssDeptList.value; }
			if (jssLocationList !== undefined && jssLocationList.value !== null) { lid = jssLocationList.value; }
			if (jssRoleList !== undefined && jssRoleList.value !== null) { rlid = jssRoleList.value; }
			if (jssGroupList !== undefined && jssGroupList.value !== null) { gid = jssGroupList.value; }
			if (jssEmpList !== undefined && jssEmpList.value !== null) {
				eid = jssEmpList.value;
				if (eid.length === 0) { eid = '0'; }
			}
			if (jssSupervisorList !== undefined && jssSupervisorList.value !== null) { sid = jssSupervisorList.value; }
			if (jssStatusList !== undefined && jssStatusList.value !== null) { stid = jssStatusList.value; }
			if (jssSortList !== undefined && jssSortList.value !== null) {
				Sort = jssSortList.value;
				if (Sort === '-') { Sort = '0'; }
			}

			if (jsfProjCode !== undefined && jsfProjCode.value !== null) { pcode = jsfProjCode.value; }
			if (jsfProjName !== undefined && jsfProjName.value !== null) { pname = jsfProjName.value; }
			if (jsfTaskCode !== undefined && jsfTaskCode.value !== null) { tcode = jsfTaskCode.value; }
			if (jsfTaskName !== undefined && jsfTaskName.value !== null) { tname = jsfTaskName.value; }

			if (jshEmpID !== undefined && jshEmpID.value !== null) {
				eid = jshEmpID.value;
				if (eid.length === 0) { eid = '0'; }
			}
			if (jsfEmpLastName !== undefined && jsfEmpLastName.value !== null) { empL = jsfEmpLastName.value; }
			if (jsfEmpFirstName !== undefined && jsfEmpFirstName.value !== null) { empF = jsfEmpFirstName.value; }
			if (jsfMgrLastName !== undefined && jsfMgrLastName.value !== null) { supL = jsfMgrLastName.value; }
			if (jsfMgrFirstName !== undefined && jsfMgrFirstName.value !== null) { supF = jsfMgrFirstName.value; }
			//alert('initial setting parameters done');

			if (jiEmpFilter === 9) { eid = jsEmpID.toString(); }
			//alert('Eid: ' + eid + '/' + jiEmpFilter.toString() + '/' + jsEmpID.toString());

			var msg2 = '';
			obj = document.getElementById('chkSumOnly');
			if (obj !== undefined && obj !== null) {
				v = 0;
				if (obj.checked) { v = 1; }
				v1 = v.toString();
			}
			obj = document.getElementById('chkExcEmpties');
			if (obj !== undefined && obj !== null) {
				v = 0;
				if (obj.checked) { v = 1; }
				v2 = v.toString();
			}

			jiPageSize = jssPagination[jssPagination.selectedIndex].value;
			if (jiPageSize === undefined || jiPageSize === null || jiPageSize === '0') {
				jiPageSize = '20';
			}

			//alert(pg.toString() + '-' + jiPageSize.toString());
			if (StartDt.length > 0) { StartDt = StartDt.replace(/\//g, '_'); }
			if (EndDt.length > 0) { EndDt = EndDt.replace(/\//g, '_'); }
			// Extract data using AJAX call
			//alert('AJAX call');

			// clean data for transfer to AJAX page
			pcode = CleanForRequestSubmitTx(pname, 0, '_', 1, 1, 1, 1);
			pname = CleanForRequestSubmitTx(pname, 0, '_', 1, 1, 1, 1);
			//tcode = '  -!@#$%^&*()  ';
			tcode = CleanForRequestSubmitTx(tcode, 0, '_', 1, 1, 1, 1);
			//alert('TCode: ' + tcode);
			tname = CleanForRequestSubmitTx(tname, 0, '_', 1, 1, 1, 1);
			empL = CleanForRequestSubmitTx(empL, 0, '_', 1, 1, 1, 1);
			empF = CleanForRequestSubmitTx(empF, 0, '_', 1, 1, 1, 1);
			empM = CleanForRequestSubmitTx(empM, 0, '_', 1, 1, 1, 1);
			supL = CleanForRequestSubmitTx(supL, 0, '_', 1, 1, 1, 1);
			supF = CleanForRequestSubmitTx(supF, 0, '_', 1, 1, 1, 1);

			// set non-table values for export into session variables
			setSessionVal('RptName', document.getElementById('C_lblRptName').innerHTML);
			setSessionVal('RptDateTime', document.getElementById('C_lblRptDateTime').innerHTML);
			setSessionVal('RptGenBy', document.getElementById('C_lblRptGenBy').innerHTML);
			setSessionVal('RptParams', jsoLblParamsChosen.innerHTML);
			setSessionVal('RptHdrMsg', document.getElementById('C_lblRptHdrMsg').innerHTML);
			setSessionVal('RptFtrMsg', jssSetFooterMsg);

			var p1 = StartDt + '-' + EndDt + '-' + eid + '-' + pid + '-' + tid + '-' + did + '-' + sid + '-' + rlid + '-' + gid + '-' + lid + '-' + stid + '-';
			var p2 = mgrid + '-' + pcode + '-' + pname + '-' + tcode + '-' + tname + '-' + empL + '-' + empF + '-' + empM + '-' + supL + '-' + supF + '-';
			var p3 = mgrid + '-' + Sort.toString() + "-" + jsEmpID.toString();
			var MyData = p1 + p2 + p3;
			var myFileName = prompt('Enter filename with no path or extension (required):', '');
			//alert(myFileName);
			myFileName = CleanForRequestSubmitTx(myFileName, 3, '_', 1, 1, 1, 1);
			//alert(myFileName);
			setSessionVal('RptFileName', myFileName);
			setSessionVal('RptGenElements', MyData);
			//alert(MyData);
			window.open('../Shared/AjaxDataExport.aspx?r=' + jsReportID.toString() + '&t=' + typ, 'popup', '', '');
			return false;
		}

		function LoadAllReportData() {
			//alert('Fired! - Load all report data');
			jstStatusMsg.innerHTML = '';
			jiTotalPages = 1;
			//alert(ThisReportData.length);
			//alert(ThisReportData[0].NbrPages);
			if (ThisReportData.length > 0) {
				jiTotalPages = parseInt(ThisReportData[0].NbrPages, 10);
				//alert('populating header');
				populateReportHdr();
				//alert('populating report');
				populateReportData();
				jsoDivBottomBtn.style.display = 'block';
			}
			else {
				alert('Your request extracted no data.');
				jstStatusMsg.innerHTML = 'Your request extracted no data';
			}
			return false;
		}

		// ***************************************************
		// FUNCTIONS FOR JQUERY LOADING DATA OBJECTS
		// ***************************************************

		function LoadUserBaseData() {
			var url = "../Shared/TimeLiveController.asmx/GetUserBaseData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','EmpID':'" + jsEmpID + "'}";
			//alert(MyData);
			getJSONReturnData(url, MyData, function (response)
			{ ThisUserData = response; populateUserData(); });
			return false;
		}

		// get report structural data
		function LoadReportList() {
			var url = "../Shared/TimeLiveController.asmx/GetReportList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ByID':'" + jsEmpID + "'}";
			//alert('Report List: ' + MyData);
			getJSONReturnData(url, MyData, function (response)
			{ ThisReportList = response; populateReportList(); });
			return false;
		}

		// Load standard report header
		function LoadReportHeader() {
			var url = "../Shared/TimeLiveController.asmx/GetReportAttributes";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','RptID':'" + jsReportID + "','ByID':'" + jsEmpID + "'}";
			//alert(MyData);
			getJSONReturnData(url, MyData, function (response)
			{ ThisReportAttributes = response; });
			return false;
		}

		// get report structural data
		function LoadReportStructure() {
			var url = "../Shared/TimeLiveController.asmx/GetReportColumnData";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','RptID':'" + jsReportID + "','ByID':'" + jsEmpID + "'}";
			//alert(MyData);
			getJSONReturnData(url, MyData, function (response)
			{ ThisReportStructure = response; });
			return false;
		}

		function LoadProjIDList() {
			var url = "../Shared/TimeLiveController.asmx/GetMyProjectList";
			var mo = 0;
			if (jsbIsAdmin === true || jsbIsHR === true || jsbIsProjAdmin === true || jsbIsFinMgr === true) {mo = 1; }
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','EmpID':'" + jsEmpID + "','IsPAdmin':'" + mo.toString() + "','ByID':'" + jsEmpID + "'}";
			//alert('ProjList: ' + MyData);
			getJSONReturnData(url, MyData, function (response)
			{ ThisProjIDList = response; populateProjIDList(); });
			return false;
		}

		function LoadTaskIDList(projid, ptxt) {
			//alert(projid);
			jsfHfProjID.value = projid;
			jsfHfProjText.value = ptxt;
			var url = "../Shared/TimeLiveController.asmx/GetProjectTaskList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ProjID':'" + projid + "','ByID':'" + jsEmpID + "'}";
			//alert(MyData);
			getJSONReturnData(url, MyData, function (response)
			{ ThisTaskIDList = response; populateTaskIDList(); });
			return false;
		}

		// load emp id list
		function LoadEmpIDList() {
			// Timesheet employee list automatically tailors list based on user rights
			var allowsrgt = 0;
			if (jsbAllowSurrogates === true) { allowsrgt = 1; }
			var url = "../Shared/TimeLiveController.asmx/GetTimesheetEmployeeList";
			//var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','AllowSurrogates':'" + allowsrgt.toString() + "','EmpID':'" + jsEmpID + "'}";
			var MyData = "{'EmpID':'" + jsEmpID + "'}";
			//alert(MyData);
			getJSONReturnData(url, MyData, function (response)
			{ ThisEmpIDList = response; populateEmpIDList(); });
			return false;
		}

		function LoadSupervisorIDList() {
			var url = "../Shared/TimeLiveController.asmx/GetSupervisorList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ByID':'" + jsEmpID + "'}";
			//alert(MyData);
			getJSONReturnData(url, MyData, function (response)
			{ ThisSupervisorList = response; populateSupervisorList(); });
			return false;
		}
		
		function LoadDeptIDList() {
			var url = "../Shared/TimeLiveController.asmx/GetDeptList2";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ByID':'" + jsEmpID + "'}";
			//alert('Dept: ' + MyData);
			getJSONReturnData(url, MyData, function (response)
			{ ThisDeptIDList = response; populateDeptIDList(); });
			return false;
		}

		function LoadLocIDList() {
			var url = "../Shared/TimeLiveController.asmx/GetLocationList2";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ByID':'" + jsEmpID + "'}";
			//alert('Loc: ' + MyData);
			getJSONReturnData(url, MyData, function (response)
			{ ThisLocIDList = response; populateLocIDList(); });
			return false;
		}

		function LoadRoleIDList() {
			var url = "../Shared/TimeLiveController.asmx/GetRoleList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ByID':'" + jsEmpID + "'}";
			//alert(MyData);
			getJSONReturnData(url, MyData, function (response)
			{ ThisRoleIDList = response; populateRoleIDList(); });
			return false;
		}

		function LoadGroupIDList() {
			var url = "../Shared/TimeLiveController.asmx/GetGroupList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','ByID':'" + jsEmpID + "'}";
			//alert(MyData);
			getJSONReturnData(url, MyData, function (response)
			{ ThisGroupIDList = response; populateGroupIDList(); });
			return false;
		}

		function LoadStatusList(typ) {
			var url = "../Shared/TimeLiveController.asmx/GetStatusList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','iType':'" + typ + "','ByID':'" + jsEmpID + "'}";
			//alert(MyData);
			getJSONReturnData(url, MyData, function (response)
			{ ThisStatusList = response; populateStatusList(); });
			return false;
		}

		function LoadSortList() {
			var url = "../Shared/TimeLiveController.asmx/GetReportSortList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','RptID':'" + jsReportID + "','ByID':'" + jsEmpID + "'}";
			//alert(MyData);
			getJSONReturnData(url, MyData, function (response)
			{ ThisSortList = response; populateSortList(); });
			//alert('Done!');
			return false;
		}

		function LoadGroupByList() {
			jiGroupByCol = 0;
			jbGroupBy = false;
			var str = '';
			var colname = '';
			//alert('populating Group By List');
			for (var i = 0; i < ThisReportStructure.length; i++) {
				//alert(ThisReportStructure[i].GroupingLevel);
				if (ThisReportStructure[i].GroupingLevel > 0) {
					colname = ThisReportStructure[i].ColumnTitle.toString();
					str = str + '&nbsp;' + colname + ':<input type="radio" id="rbgroupings' + (i + 1).toString() + '" name="rbgroupings" value="' + (i + 1).toString() + '"/><label for="rbgroupings' + (i + 1).toString() + '">' + colname + '</label>';
					jbGroupBy = true;
					jbUseGroupings = true;
					//alert('Fired!');
				}
			}
			if (str.length > 0) {
				//alert(str);
				jsoDivGroupByContent.innerHTML = '<strong>Group By:</strong>&nbsp;<input type="radio" id="rbgroupings0" name="rbgroupings" value="-1" checked="checked"/><label for="rbgroupings0">No Grouping</label>' + str;
			}
		}

		function setSessionVal(valName, val) {
			setSessionValGu(valName, val);
			//var resp = '';
			//val = val.replace(/\'/gi, '`');
			//val = val.replace(/\"/gi, '`');
			//var url = "../Shared/TimeLiveController.asmx/SetSessionValueFromAJAX";
			//var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','SessionValName':'" + valName + "','val':'" + val + "'}";
			//getJSONReturnStatus(url, MyData, function (response)
			//{ resp = response; });
			return false;
		}

		function LoadSpecSubGroupList() {
		}

		// ***************************************************
		// FUNCTIONS FOR BUILDING/VIEWING DATA
		// ***************************************************

		function populateUserData() {
			// EmployeeCode, etc
			//alert('Fired!');
			var sRoles = '';
			jsbIsContractor = false;
			jsbIsEmpMngr = false;
			jsbIsProjAdmin = false;
			jsbIsAdmin = false;
			jsbIsHR = false;
			jsbIsProjMngr = false;
			jsbIsFinMgr = false;
			jsbIsFinWkr = false;
			if (ThisUserData.length > 0) {
				jssUserName = ThisUserData[0].FullName2.toString();
				jssDeptName = ThisUserData[0].DepartmentName.toString();
				jssFirstName = ThisUserData[0].FirstName.toString();
				jssLastName = ThisUserData[0].LastName.toString();
				if (ThisUserData[0].IsContractor === '1') { jsbIsContractor = true; }
				sRoles = ThisUserData[0].Roles.toString();
				if (!IsContentsNullUndefEmptyGu(sRoles)) {
					if (sRoles.indexOf('EmpMgr') >= 0) {
						jsbIsEmpMngr = true;
						jbGenUser = false;
					}
					if (sRoles.indexOf('HR') >= 0) {
						jsbIsHR = true;
						jbGenUser = false;
					}
					if (sRoles.indexOf('ProjMgr') >= 0) {
						jsbIsProjMngr = true;
						jbGenUser = false;
					}
					if (sRoles.indexOf('ProjAdmin') >= 0) {
						jsbIsProjAdmin = true;
						jbGenUser = false;
					}
					if (sRoles.indexOf('Administrator') >= 0) {
						jsbIsAdmin = true;
						jbGenUser = false;
					}
					if (sRoles.indexOf('FinMgr') >= 0) {
						jsbIsFinMgr = true;
						jbGenUser = false;
					}
				}
			}
		}

		function populateReportList() {
			//alert('Report List fill starting');
			var txt = fillDropDownListGu(ThisReportList, jssReportList, jsReportID, 'ReportName', 'ReportID');
			jsfHfRptName.value = txt;
			//alert('Report List filled');
		}

		// Show Report header data
		function populateReportHdr() {
			jsoDivReportHdr.style.display = 'block';
			// data in ThisReportAttributes
			// load main report settings
			//alert('Populating report header');
			jsbSetGridLines = false;
			jsbSetPaginate = false;
			if (ThisReportAttributes[0].UseGridLines === "True") { jsbSetGridLines = true; }
			if (ThisReportAttributes[0].Paginate === 'True') {jsbSetGridLines = true; }
			jsbSetPageSz = parseFloat(ThisReportAttributes[0].PageSize); // 'w:8.5";h:11"';
			jsfSetFontSize = parseFloat(ThisReportAttributes[0].FontSizePoints);
			jsfSetMargLeft = parseFloat(ThisReportAttributes[0].MarginLeft);
			jsfSetMargRight = parseFloat(ThisReportAttributes[0].MarginRight);
			jsfSetPadTop = parseFloat(ThisReportAttributes[0].PaddingTop);
			jsfSetPadBottom = parseFloat(ThisReportAttributes[0].PaddingBottom);
			jssSetFontFam = ThisReportAttributes[0].FontFamily.toString();
			jssSetInGridCSS = ThisReportAttributes[0].InnerGridLineCSS.toString();
			jssSetOutGridCSS = ThisReportAttributes[0].OuterGridLineCSS.toString();
			jssSetRptTitle = ThisReportAttributes[0].ReportTitle.toString();
			jssSetHeaderMsg = ThisReportAttributes[0].RptHeaderMsg.toString();
			jssSetFooterMsg = ThisReportAttributes[0].RptFooterMsg.toString();
			jssSetForeColor = ThisReportAttributes[0].ForeColor.toString();
			jssSetUserName = ThisReportAttributes[0].FullName.toString();
			if (ThisReportAttributes[0].ShowCountAtEnd) {jsbShowCount = true; }
			jsbShowAggregates = false;
			if (ThisReportAttributes[0].ShowAggregates === 'True') {jsbShowAggregates = true; }

			//alert('setting margins');
			jsoDivReportHdr.style.marginLeft = jsfSetMargLeft;
			jsoDivReportHdr.style.marginRight = jsfSetMargRight;
			jsoDivReportHdr.style.paddingTop = jsfSetPadTop;
			jsoDivReportHdr.style.paddingBottom = jsfSetPadBottom;

			//alert('setting miscellaneous fields');
			document.getElementById('C_lblRptName').innerHTML = jssSetRptTitle; //affected by master page
			var dt = new Date();
			document.getElementById('C_lblRptDateTime').innerHTML = formatDateAsStdString(dt); //affected by master page
			document.getElementById('C_lblRptGenBy').innerHTML = jssSetUserName; //affected by master page
			document.getElementById('C_lblRptHdrMsg').innerHTML = jssSetHeaderMsg; //affected by master page

			// show params chosen
			jsoLblParamsChosen.innerHTML = formParamsText();

			//show pagination data
			jsoLblPgNbr.innerHTML = jiCurrentPage.toString();
			jsoLblNbrPage.innerHTML = jiTotalPages.toString();
			jsoDivReportPg.style.display = 'block';
			if (parseInt(jiTotalPages, 10) < 2) {
				jsoDivReportPg.style.display = 'none';
			}
			//alert('Report Header Populated');
		}

		function formParamsText() {
			//alert('Fired!');
			var newval = '';
			if (jsfHfStartDt.value !== '') {newval = newval + 'Start Date: ' + jsfHfStartDt.value; }
			if (jsfHfEndDt.value !== '') {
				if (newval === '') {
					newval = 'No Start Date';
				}
				newval = newval + ', End Date: ' + jsfHfEndDt.value; 
			}
			if (jsfHfProjID.value !== '' && jsfHfProjID.value !=='0') {
				if (newval !== '') {newval = newval + ', '; }
				newval = newval + 'Project: ' + jsfHfProjText.value; 
			}
			if (jsfHfTaskID.value !== '' && jsfHfTaskID.value !=='0') {
				if (newval !== '') {newval = newval + ', '; }
				newval = newval + 'Task: ' + jsfHfTaskText.value; 
			}
			//alert('1: ' + newval);
			if (jsfHfPCode.value !== '') {
				if (newval !== '') {newval = newval + ', '; }
				newval = newval + 'Proj Code: ' + jsfHfPCode.value; 
			}
			if (jsfHfPName.value !== '') {
				if (newval !== '') {newval = newval + ', '; }
				newval = newval + 'Proj Name: ' + jsfHfPName.value; 
			}
			if (jsfHfTCode.value !== '') {
				if (newval !== '') {newval = newval + ', '; }
				newval = newval + 'Task Code: ' + jsfHfTCode.value; 
			}
			if (jsfHfTName.value !== '') {
				if (newval !== '') {newval = newval + ', '; }
				newval = newval + 'Task Name: ' + jsfHfTName.value; 
			}
			//alert('2: ' + newval);
			if (jsfHfLastName.value !== '') {
				if (newval !== '') {newval = newval + ', '; }
				newval = newval + 'Last Name: ' + jsfHfLastName.value; 
			}
			if (jsfHfFirstName.value !== '') {
				if (newval !== '') {newval = newval + ', '; }
				newval = newval + 'First Name: ' + jsfHfFirstName.value; 
			}
			if (jsfHfMiddleName.value !== '') {
				if (newval !== '') {newval = newval + ', '; }
				newval = newval + 'Middle Name: ' + jsfHfMiddleName.value; 
			}
			if (jsfHfMgrID.value !== '' && jsfHfMgrID.value !=='0') {
				if (newval !== '') {newval = newval + ', '; }
				newval = newval + 'Supervisor: ' + jsfHfMgrText.value; 
			}
			//alert('3: ' + newval);
			if (jsfHfMgrLast.value !== '') {
				if (newval !== '') {newval = newval + ', '; }
				newval = newval + 'Sup LastName: ' + jsfHfMgrLast.value; 
			}
			if (jsfHfMgrFirst.value !== '') {
				if (newval !== '') {newval = newval + ', '; }
				newval = newval + 'Sup FirstName: ' + jsfHfMgrFirst.value; 
			}
			if (jsfHfRoleID.value !== '' && jsfHfRoleID.value !=='0') {
				if (newval !== '') {newval = newval + ', '; }
				newval = newval + 'Role: ' + jsfHfRoleText.value; 
			}
			if (jsfHfGroupID.value !== '' && jsfHfGroupID.value !=='0') {
				if (newval !== '') {newval = newval + ', '; }
				newval = newval + 'Group: ' + jsfHfGroupText.value; 
			}
			if (jsfHfLocID.value !== '' && jsfHfLocID.value !=='0') {
				if (newval !== '') {newval = newval + ', '; }
				newval = newval + 'Loc: ' + jsfHfLocText.value; 
			}
			//alert('4: ' + newval);
			if (jsfHfDeptID.value !== '' && jsfHfDeptID.value !== '0') {
				if (newval !== '') {newval = newval + ', '; }
				newval = newval + 'Dept: ' + jsfHfDeptText.value; 
			}
			//if (jsfHfSupID.value !== '' && jsfHfSupID.value !=='0') {
			//}
			if (jsfHfStatusID.value !== '' && jsfHfStatusID.value !=='0') {
				if (newval !== '') {newval = newval + ', '; }
				newval = newval + 'Status: ' + jsfHfStatusText.value; 
			}
			if (jsfHfSortID.value !== '' && jsfHfSortID.value !=='0') {
				if (newval !== '') {newval = newval + ', '; }
				newval = newval + 'Sort: ' + jsfHfSortText.value;
			}

			if (jsoSpnEmpData.innerHTML === 'My Data') {
				if (newval !== '') { newval = newval + ', '; }
				newval = newval + 'My Data';
			}
			if (jsfHfSumOnly.value !== '0') {
				if (newval !== '') { newval = newval + ', '; }
				newval = newval + 'Summary Only';
			}
			if (jsfHfExcludeEmpty.value !== '0') {
				if (newval !== '') { newval = newval + ', '; }
				newval = newval + 'Exclude Empty Rows';
			}
			//alert('Final: ' + newval);
			return newval;
		}

		// Show Report data in table format
		function populateReportData() {
			// data in ThisReportData
			var bAvgs = false;
			var bCounts = false;
			var bHit = false;
			var bHiVal = false;
			var bLwVal = false;
			var brdr = '';
			var bSumOnly = false;
			var bSums = false;
			var cell;
			var col;
			var DisplayFormat = '';
			var fig1 = 0;
			var fig2 = 0;
			var fig3 = 0;
			var iRptCount = 0;
			var iGroupCount = 0;
			var IsVisible = '';
			var JResult = '';
			var MinLen = 0;
			var myJson = '';
			var NbrInt = 0;
			var NbrCols = 0;
			var NbrColsVisible = 0;
			var NbrRows = 0;
			var obj;
			var Paginate = 0;
			var Prec = 0;
			var sHAlign = 'left';
			var sVAlign = 'middle';
			var sBkColor = '#FFFFFF';
			var sHBkColor = '#FFFFFF';
			var sGBkColor = '#F0F0F0';
			var sFrColor = '#000000';
			var sHFrColor = '#000000';
			var sGFrColor = '#090909';
			var sDataType = '';
			var sHt = '16px';
			var sTitle = '';
			var sval = '';
			var sWdth = '0';
			var val = 0;

			// create data arrays for aggregation
			var colValues = createArrayGu(); //  (rows, columns) Load only for data to be aggregated (usually #'s) 
			var colHasAgg = createArrayGu();
			var colCount = createArrayGu(); //count is of rows with data
			var colAvg = createArrayGu(); //avg for each column
			var colSum = createArrayGu();
			var colHiVal = createArrayGu();
			var colLwVal = createArrayGu();
			var colCountG = createArrayGu(); //count is of rows with data
			var colAvgG = createArrayGu(); //avg for each column
			var colSumG = createArrayGu();
			var colHiValG = createArrayGu();
			var colLwValG = createArrayGu();

			//alert('Populating report grid');

			if (ThisReportStructure === undefined || ThisReportStructure === null || ThisReportAttributes === undefined || ThisReportAttributes === null) {
				alert('Error: Report structure was not loaded correctly');
				return false;
			}
			if (ThisReportData === undefined || ThisReportData === null) {
				alert('Error: Report Data did not load correctly for an unknown reason');
				return false;
			}

			// empty any previous rows
			jsoTblMain.deleteTHead();
			$("#tblMainData > tbody").html("");
			//alert('Beginning datagrid fill');

			//alert(jsfSetMargLeft);
			jsoDivReportMain.style.marginLeft = jsfSetMargLeft;
			//alert(jsfSetMargRight);
			jsoDivReportMain.style.marginRight = jsfSetMargRight;
			//alert(jsfSetPadTop);
			jsoDivReportMain.style.paddingTop = jsfSetPadTop;
			//alert(jsfSetPadBottom);
			jsoDivReportMain.style.paddingBottom = jsfSetPadBottom;

			// grab paginate setting
			//alert('Getting basic format settings');
			jsbSetGridLines = false;
			Paginate = parseInt(ThisReportAttributes[0].Paginate, 10);
			//alert(ThisReportAttributes[0].UseGridLines);
			if (ThisReportAttributes[0].UseGridLines === "True") {
				jsbSetGridLines = true;
			}
			NbrCols = ThisReportStructure.length;
			//alert('NbrCols: ' + NbrCols);

			//alert('basic CSS');
			if (jsbSetGridLines === true) {
				jsoTblMain.style.border = jssSetOutGridCSS;
			}
			jssSetForeColor = ThisReportAttributes[0].ForeColor.toString();
			jsfSetFontSize = parseFloat(ThisReportAttributes[0].FontSizePoints);

			// get grouping settings and set whether to show group footer-header
			//alert('Getting whether groups are involved');
			ShowGroupings = 0;
			jiGroupByCol = 0;
			sval = '';
			if (jbUseGroupings === true) {
				if (document.form1.rbgroupings !== undefined) {
					//alert('table row length');
					//alert(document.form1.rbgroupings.length);
					if (document.form1.rbgroupings !== undefined && document.form1.rbgroupings !== null) {
						NbrInt = document.form1.rbgroupings.length;
						for (var ig = 0; ig < NbrInt; ig++) {
							if (document.form1.rbgroupings[ig].checked) {
								sval = document.form1.rbgroupings[ig].value;
								break;
							}
						}
						if (sval.length > 0) {
							if (sval !== '-1') {
								jiGroupByCol = parseInt(sval, 10);
								ShowGroupings = 1;
							}
						}
						//alert(jiGroupByCol);
					}
				}
			}


			// find if only summary will be shown
			if (jsfHfSumOnly === '1') { bSumOnly = true; }

			// Establish table HEAD
			//alert('Beginning head - NbrCol: ' + NbrCols.toString());
			var hd = document.createElement("thead");
			//alert('Getting number of data rows');
			NbrRows = ThisReportData.length;

			// Establish TH row - ThisReportStructure
			// initialize aggregation arrays
			//alert('Initializing aggregation arrays');
			for (col = 0; col < NbrCols; col++) {
				if (ThisReportStructure[col].IsVisible === 'True') {NbrColsVisible++;}
				colValues[col] = '';
				colCount[col] = 0;
				colAvg[col] = 0; //avg for each column
				colSum[col] = 0;
				colHiVal[col] = '';
				colLwVal[col] = '';
				colCountG[col] = 0; //count is of rows with data
				colAvgG[col] = 0; //avg for each column
				colSumG[col] = 0;
				colHiValG[col] = '';
				colLwValG[col] = '';
				sval = ThisReportStructure[col].DataObjectType.toString();
				// set whether column can have aggregates
				colHasAgg[col] = false;
				//alert(ThisReportStructure[col].AggregateAvg);
				if (ThisReportStructure[col].AggregateAvg === 'True' || ThisReportStructure[col].AggregateCount === 'True' || ThisReportStructure[col].AggregateSum === 'True' || ThisReportStructure[col].GetHighValue === 'True' || ThisReportStructure[col].GetLowValue === 'True' || ThisReportStructure[col].AggregateLevel === 'True') {
					if (sval === 'int' || sval === 'decimal' || sval === 'tinyint' || sval === 'numeric' || sval === 'money' || sval === 'real' || sval === 'smallmoney' || sval === 'smallint' || sval === 'float' || sval === 'bit') {
						colHasAgg[col] = true;
					}
					if (ThisReportStructure[col].AggregateSum === 'True') {
						bSums = true;
					}
					if (ThisReportStructure[col].AggregateCount === 'True') {
						bCounts = true;
					}
					if (ThisReportStructure[col].AggregateAvg === 'True') {
						bAvgs = true;
					}
					if (ThisReportStructure[col].GetHighValue === 'True') {
						bHiVal = true;
					}
					if (ThisReportStructure[col].GetLowValue === 'True') {
						bLwVal = true;
					}
				}
			}

			// add header line
			//alert('Adding Header Line');
			row = createGroupColHdrRow(NbrCols, '', '18px', sHFrColor, 'bold', 'center', 'middle', '2px', '2px', '0px', '0px');
			hd.appendChild(row);
			// Add to table
			jsoTblMain.appendChild(hd);

			// add body portion
			//alert('Beginning body - ' + NbrRows.toString() + ' GridLines: ' + jsbSetGridLines + '/' + jsLastParams);
			var bdy = document.createElement('tbody');

			// add rows for all data rows
			for (var rowid = 0; rowid < NbrRows; rowid++) {
				iRptCount++;
				iGroupCount++;
				sval = '';

				// check for insert aggregate group row
				//alert('Checking for grouping - Row ' + iRptCount.toString());
				if (ShowGroupings === 1) {
					if (col === jiGroupByCol) {
						sTitle = ThisReportStructure[col].ColumnTitle;
						sval = ThisReportData[rowid][sTitle].toString();
						// Insert data row
						//alert(sval);

						if (sval !== colValues[col].toString()) {
							// Insert group aggregate row 
							row = document.createElement("tr");
							for (col = 0; col < NbrCols; col++) {
								sval = ThisReportData[row][col].toString();
								sWdth = ThisReportStructure[col].WidthInPx.toString();

								if (parseInt(ThisReportStructure[col].GroupingLevel, 10) === 1) {
									if (parseInt(ThisReportStructure[col].AggregateAvg, 10) === 1) {
										sval = (colAvgG[col] / iGroupCount).toString();
										colAvgG[col] = 0;
									}
									if (parseInt(ThisReportStructure[col].AggregateCount, 10) === 1) {
										sval = colCountG[col].toString();
										colCountG[col] = 0;
									}
									if (parseInt(ThisReportStructure[col].AggregateSum, 10) === 1) {
										sval = colSumG[col].toString();
										colSumG[col] = 0;
									}
									if (parseInt(ThisReportStructure[col].GetHighValue, 10) === 1) {
										sval = colHiValG[col].toString();
										colHiValG[col] = '';
									}
									if (parseInt(ThisReportStructure[col].GetLowValue, 10) === 1) {
										sval = colLwValG[col].toString();
										colLwValG[col] = '';
									}
									colAvgG[col] = 0;
								}

								cell = createNewCellGu(createObjIDGu('GCELL', rowid, col), sHt, sWdth, sval, sGBkColor, sGFrColor, brdr, 'center', 'middle', '4px', '4px', '0px', '0px', '9pt', false, 'visible', true, false, '','', '');
							}
							bdy.appendChild(row);
							iGroupCount = 0;

							// append group header title row
							row = createGroupHdrRow(createObjIDGu('GHRW', rowid, col), content, nbrCols, '1px solid Gray', ht, wdth, bgColor, frColor, fWght, hAlign, vAlign, padr, padl, padt, padb);
							bdy.appendChild(row);
							// insert column header row
							row = createGroupColHdrRow(NbrCols, '', '18px', sHFrColor, 'bold', 'center', 'middle', '2px', '2px', '0px', '0px');
							bdy.appendChild(row);

							colValues[col] = sval;
						}
					}
				}

				//alert('Beginning data row');
				if (bSumOnly === false) {
					row = document.createElement("tr"); // create blank row
				}
				// create data row
				for (col = 0; col < NbrCols; col++) {
					//alert('Col ' + col.toString());
					brdr = '';
					//alert(ThisReportStructure[col].IsVisible);
					if (ThisReportStructure[col].IsVisible === 'True') {
						sHAlign = ThisReportStructure[col].HorizontalAlign.toString();
						sVAlign = ThisReportStructure[col].VerticalAlign.toString();
						sBkColor = ThisReportStructure[col].BackgroundColor.toString();
						sTitle = ThisReportStructure[col].ObjName;
						sDataType = ThisReportStructure[col].DataObjectType;
						IsVisible = '';
						if (ThisReportStructure[col].NotVisible === 'True') {
							IsVisible = 'hidden';
						}

						//alert('Part 2');
						if (jsbSetGridLines === true) { brdr = ThisReportStructure[col].BorderCSS.toString(); }
						sWdth = ThisReportStructure[col].WidthInPx.toString();
						if (sWdth !== '0') { sWdth = sWdth + 'px'; }
						//alert('Part 3 - ' + sDataType + '-' + sTitle);
						//sval = '';
						sval = ThisReportData[rowid][sTitle].toString();

						// establish special format if one is identified
						if (sval !== null) {
							DisplayFormat = ThisReportStructure[col].DisplayFormatCode.toString();
							if (DisplayFormat !== 'Normal' && DisplayFormat !== 'norm') {
								fig1 = 0;
								fig2 = 0;
								fig3 = 0;
								if (IsNumberString(sval)) {
									fig1 = parseFloat(sval); // actual figure
									fig2 = parseFloat(ThisReportStructure[col].TargetAmount); // 100%
									fig3 = 80; // #px equating to 100%
								}
								//alert(sval + '/' + DisplayFormat);
								sval = getSpecialFormatStringTx(sval, DisplayFormat, fig1, fig2, fig3);
							}
							//alert(sval);
						}

						//alert('Create and append cell - value: ' + sval  + sDataType + '-' + sTitle);
						if (bSumOnly === false) {
							cell = createNewCellGu(createObjIDGu('BCELL', rowid, col), sHt, sWdth, sval, sBkColor, sFrColor, brdr, sHAlign, sVAlign, '4px', '4px', '0px', '0px', '9pt', false, 'visible', true, false, IsVisible, '', '');
							row.appendChild(cell);
						}

						// aggregate - add/calculate values
						if (colHasAgg[col] === true) {
							if (bAvgs === true) {
								if (sval === '') { sval = '0'; }
								val = parseFloat(sval);
								if (val !== NaN) {
									colAvg[col] = colAvg[col] + val;
									colAvgG[col] = colAvgG[col] + val;
								}
							}
							if (bCounts === true) {
								if (sval.length > 0) {
									colCount[col] = colCount[col] + 1;
									colCountG[col] = colCountG[col] + 1;
								}
							}
							if (bSums === true) {
								if (sval === '') { sval = '0'; }
								val = parseFloat(sval);
								if (val !== NaN) {
									colSum[col] = colSum[col] + val;
									colSumG[col] = colSumG[col] + val;
								}
							}
							if (bHiVal === true && sval !== '') {
								if (sval > colHiVal[col].toString()) {
									colHiVal[col] = sval;
								}
								if (sval > colHiValG[col].toString()) {
									colHiValG[col] = sval;
								}
							}
							if (bLwVal === true && sval !== '') {
								if (sval < colLwVal[col].toString()) {
									colLwVal[col] = sval;
								}
								if (sval < colLwValG[col].toString()) {
									colLwValG[col] = sval;
								}
							} //bLwVal === true && sval !== ''
						} //colHasAgg[col] === true
					} //ThisReportStructure[col].IsVisible === true
				} //for (col = 0; col < NbrCols; col++)
				if (bSumOnly === false) {
					bdy.appendChild(row);
				}
			} //for (var rowid = 0; rowid < NbrRows; rowid++)

			// show summary row if checked
			if (bSumOnly === true || jsbShowAggregates === true) {
				//alert('Showing final Aggregate line(s)');
				// Handle averages
				if (bAvgs === true) {
					row = document.createElement("tr"); // create blank row

					for (col = 0; col < NbrCols; col++) {
						brdr = '';
						sval = '';
						sBkColor = '#D9D9D9';
						IsVisible = '';
						if (ThisReportStructure[col].IsVisible === 'True') {
							if (ThisReportStructure[col].NotVisible === true) {
								IsVisible = 'hidden';
							}
							if (jsbSetGridLines === true) { brdr = ThisReportStructure[col].BorderCSS.toString(); }
							sWdth = ThisReportStructure[col].WidthInPx.toString();
							if (sWdth !== '0') { sWdth = sWdth + 'px'; }
							if (col === 0) {
								sHAlign = 'center';
								sVAlign = 'middle';
								sval = 'Averages';
							}
							else {
								sHAlign = ThisReportStructure[col].HorizontalAlign.toString();
								sVAlign = ThisReportStructure[col].VerticalAlign.toString();
								sDataType = ThisReportStructure[col].DataObjectType;
								if (colHasAgg[col] === true) {
									sval = colAvg[col].toString();
									Prec = parseInt(ThisReportStructure[col].NbrPrecision, 10);
									sval = fixNumericStringTx(parseFloat(sval), ' ', 0, Prec);
								}
							}
							cell = createNewCellGu(createObjIDGu('BCELL', rowid, col), sHt, sWdth, sval, sBkColor, sFrColor, brdr, sHAlign, sVAlign, '4px', '4px', '0px', '0px', '9pt', true, 'visible', true, false, IsVisible, '', '');
							row.appendChild(cell);
						}
					}
					bdy.appendChild(row);
				}

				// Handle counts
				if (bCounts === true) {
					row = document.createElement("tr"); // create blank row
					for (col = 0; col < NbrCols; col++) {
						brdr = '';
						sval = '';
						sBkColor = '#D9D9D9';
						IsVisible = '';
						if (ThisReportStructure[col].IsVisible === 'True') {
							if (ThisReportStructure[col].NotVisible === true) {
								IsVisible = 'hidden';
							}
							if (jsbSetGridLines === true) { brdr = ThisReportStructure[col].BorderCSS.toString(); }
							sWdth = ThisReportStructure[col].WidthInPx.toString();
							if (sWdth !== '0') { sWdth = sWdth + 'px'; }
							if (col === 0) {
								sHAlign = 'center';
								sVAlign = 'middle';
								sval = 'Counts';
							}
							else {
								sHAlign = ThisReportStructure[col].HorizontalAlign.toString();
								sVAlign = ThisReportStructure[col].VerticalAlign.toString();
								sDataType = ThisReportStructure[col].DataObjectType;
								if (colHasAgg[col] === true) {
									sval = colCount[col].toString();
								}
							}
							cell = createNewCellGu(createObjIDGu('BCELL', rowid, col), sHt, sWdth, sval, sBkColor, sFrColor, brdr, sHAlign, sVAlign, '4px', '4px', '0px', '0px', '9pt', true, 'visible', true, false, IsVisible, '', '');
							row.appendChild(cell);
						}
					}
					bdy.appendChild(row);
				}

				// Handle Sums
				if (bSums === true) {
					row = document.createElement("tr"); // create blank row
					for (col = 0; col < NbrCols; col++) {
						brdr = '';
						sval = '';
						sBkColor = '#D9D9D9';
						IsVisible = '';
						if (ThisReportStructure[col].IsVisible === 'True') {
							if (ThisReportStructure[col].NotVisible === true) {
								IsVisible = 'hidden';
							}
							if (jsbSetGridLines === true) { brdr = ThisReportStructure[col].BorderCSS.toString(); }
							sWdth = ThisReportStructure[col].WidthInPx.toString();
							if (sWdth !== '0') { sWdth = sWdth + 'px'; }
							if (col === 0) {
								sHAlign = 'center';
								sVAlign = 'middle';
								sval = 'Totals';
							}
							else {
								sHAlign = ThisReportStructure[col].HorizontalAlign.toString();
								sVAlign = ThisReportStructure[col].VerticalAlign.toString();
								sDataType = ThisReportStructure[col].DataObjectType;
								if (colHasAgg[col] === true) {
									sval = colSum[col].toString();
									Prec = parseInt(ThisReportStructure[col].NbrPrecision, 10);
									sval = fixNumericStringTx(parseFloat(sval), ' ', 0, Prec);
								}
							}
							cell = createNewCellGu(createObjIDGu('BCELL', rowid, col), sHt, sWdth, sval, sBkColor, sFrColor, brdr, sHAlign, sVAlign, '4px', '4px', '0px', '0px', '9pt', true, 'visible', true, false, IsVisible, '', '');
							row.appendChild(cell);
						}
					}
					bdy.appendChild(row);
				}

				// Handle High Vals
				if (bHiVal === true) {
					row = document.createElement("tr"); // create blank row
					for (col = 0; col < NbrCols; col++) {
						brdr = '';
						sval = '';
						sBkColor = '#D9D9D9';
						IsVisible = '';
						if (ThisReportStructure[col].IsVisible === 'True') {
							if (ThisReportStructure[col].NotVisible === true) {
								IsVisible = 'hidden';
							}
							if (jsbSetGridLines === true) { brdr = ThisReportStructure[col].BorderCSS.toString(); }
							sWdth = ThisReportStructure[col].WidthInPx.toString();
							if (sWdth !== '0') { sWdth = sWdth + 'px'; }
							if (col === 0) {
								sHAlign = 'center';
								sVAlign = 'middle';
								sval = 'Highest Value';
							}
							else {
								sHAlign = ThisReportStructure[col].HorizontalAlign.toString();
								sVAlign = ThisReportStructure[col].VerticalAlign.toString();
								sDataType = ThisReportStructure[col].DataObjectType;
								if (colHasAgg[col] === true) {
									sval = colHiVal[col].toString();
								}
							}
							cell = createNewCellGu(createObjIDGu('BCELL', rowid, col), sHt, sWdth, sval, sBkColor, sFrColor, brdr, sHAlign, sVAlign, '4px', '4px', '0px', '0px', '9pt', true, 'visible', true, false, IsVisible, '', '');
							row.appendChild(cell);
						}
					}
					bdy.appendChild(row);
				}

				// Handle Low Vals
				if (bLwVal === true) {
					row = document.createElement("tr"); // create blank row
					for (col = 0; col < NbrCols; col++) {
						brdr = '';
						sval = '';
						sBkColor = '#D9D9D9';
						IsVisible = '';
						if (ThisReportStructure[col].IsVisible === 'True') {
							if (ThisReportStructure[col].NotVisible === true) {
								IsVisible = 'hidden';
							}
							if (jsbSetGridLines === true) { brdr = ThisReportStructure[col].BorderCSS.toString(); }
							sWdth = ThisReportStructure[col].WidthInPx.toString();
							if (sWdth !== '0') { sWdth = sWdth + 'px'; }
							if (col === 0) {
								sHAlign = 'center';
								sVAlign = 'middle';
								sval = 'Lowest Value';
							}
							else {
								sHAlign = ThisReportStructure[col].HorizontalAlign.toString();
								sVAlign = ThisReportStructure[col].VerticalAlign.toString();
								sDataType = ThisReportStructure[col].DataObjectType;
								if (colHasAgg[col] === true) {
									sval = colLwVal[col].toString();
								}
							}
							cell = createNewCellGu(createObjIDGu('BCELL', rowid, col), sHt, sWdth, sval, sBkColor, sFrColor, brdr, sHAlign, sVAlign, '4px', '4px', '0px', '0px', '9pt', true, 'visible', true, false, IsVisible, '', '');
							row.appendChild(cell);
						}
					}
					bdy.appendChild(row);
				}
			}

			// Add count line if necessary
			//alert('Showing count row, if necessary');
			if (jsbShowCount === true) {
				sval = 'Number of Items: ' + NbrRows.toString() ;
				row = createGroupHdrRow(createObjIDGu('CTRW', 0, 0), sval, NbrColsVisible, '', '18px', '', '#FFFFFF', '#000000', 'bold', 'right', 'middle', '4px', '2px', '0px', '0px');
				bdy.appendChild(row);
			}

			jsoTblMain.appendChild(bdy);
			//alert('Body has been appended');

			// show footer data, if any
			populateReportFtr();
			//alert('Footer done');

			// show report area
			jsoDivReportView.style.display = 'block';
			jsoDivBottomBtn.style.display = 'block';

			// hide parameters field areas
			ToggleTabDisplay('hide');
		}

		function populateReportFtr() {
			// data comes from calculations in populateReportData that are passed on
			jsoDivReportFtr.style.marginLeft = jsfSetMargLeft;
			jsoDivReportFtr.style.marginRight = jsfSetMargRight;
			jsoDivReportFtr.style.paddingTop = jsfSetPadTop;
			jsoDivReportFtr.style.paddingBottom = jsfSetPadBottom;

			document.getElementById('C_lblRptFtrMsg').innerHTML = jssSetFooterMsg; //affected by master page
		}
		// -----------------------------------------------------------------

		function populateEmpIDList() {
			//alert('Populating Emp List');
			var txt = fillDropDownListGu(ThisEmpIDList, jssEmpList, 0, 'FullName', 'AccountEmployeeId');
			jsfHfPEmpID.value = '0';
			jsfHfPEmpName = txt;
		}

		function populateProjIDList() {
			//alert('Populating Proj List');
			ClearDDLOptionsGu(objname, keepfirst);

			var txt = fillDropDownListGu(ThisProjIDList, jssProjList, -1, 'ProjNameWithCode', 'AccountProjectId');
			jsfHfProjID.value = '-1';
			jsfHfProjText.value = txt;
		}

		function populateTaskIDList() {
			//alert('Populating Task List');
			var txt = fillDropDownListGu(ThisTaskIDList, jssTaskList, 0, 'TaskCodeName', 'AccountProjectTaskId');
			jsfHfTaskID.value = '0';
			jsfHfTaskText.value = txt;
		}

		function populateDeptIDList() {
			//alert('Populating Dept List');
			var txt = fillDropDownListGu(ThisDeptIDList, jssDeptList, 0, 'DepartmentName', 'AccountDepartmentID');
			jsfHfDeptID.value = '0';
			jsfHfDeptText.value = txt;
		}

		function populateLocIDList() {
			//alert('Populating Location List');
			var txt = fillDropDownListGu(ThisLocIDList, jssLocationList, 0, 'AccountLocation', 'AccountLocationID');
			jsfHfLocID.value = '0';
			jsfHfLocText.value = txt;
		}

		function populateRoleIDList() {
			//alert('Populating Role List');
			var txt = fillDropDownListGu(ThisRoleIDList, jssRoleList, 0, 'Role', 'AccountRoleID');
			jsfHfRoleID.value = '0';
			jsfHfRoleText.value = txt;
		}

		function populateGroupIDList() {
			//alert('Populating Group List');
			var txt = fillDropDownListGu(ThisGroupIDList, jssGroupList, 0, 'GroupName', 'AccountGroupID');
			jsfHfGroupID.value = '0';
			jsfHfGroupText.value = txt;
		}

		function populateSupervisorList() {
			//alert('Populating Supervisor List');
			var txt = fillDropDownListGu(ThisSupervisorList, jssSupervisorList, 0, 'FullName2', 'AccountEmployeeId');
			jsfHfMgrID.value = '0';
			jsfHfMgrText.value = txt;
		}

		function populateStatusList() {
			//alert('Populating Status List');
			var txt = fillDropDownListGu(ThisStatusList, jssStatusList, 0, 'StatusCode', 'AccountStatusId');
			jsfHfStatusID.value = '0';
			jsfHfStatusText.value = txt;
		}

		function populateSortList() {
			//alert('Populating Sort List');
			var txt = fillDropDownListGu(ThisSortList, jssSortList, 0, 'SortText', 'SortValue');
			jsfHfSortID.value = '0';
			jsfHfSortText.value = txt;
			//alert('Done!');
		}

		function populateSpecSubGroupList() {
			// nothing yet
		}

		// ***************************************************
		// TABLE FUNCTIONS
		// ***************************************************

		function createGroupColHdrRow(nbrCols, brdr, ht, frColor, fWght, hAlign, vAlign, padr, padl, padt, padb) {
			var bColor = '#E9E9E9';
			var sTitle = '';
			var sWdth = '';
			var sBrdr = '';
			row = document.createElement("tr");
			for (var col = 0; col < nbrCols; col++) {
				if (ThisReportStructure[col].IsVisible === 'True') {
					//sBrdr = ThisReportStructure[col].BorderCSS.toString();
					bColor = ThisReportStructure[col].HdrBackColor.toString();
					if (jsbSetGridLines === true) {
						sBrdr = ThisReportStructure[col].BorderCSS.toString();
					}
					sTitle = ThisReportStructure[col].ColumnTitle.toString();
					sWdth = ThisReportStructure[col].WidthInPx.toString();
					if (sWdth !== '0') { sWdth = sWdth + 'px'; }
					cell = createNewCellGu(createObjIDGu('HCELL', 0, col), ht, sWdth, sTitle, bColor, frColor, sBrdr, 'center', 'middle', padr, padl, padt, padb, '8pt', true, 'visible', true, false, true, '', '');
					row.appendChild(cell);
				}
			}
			return row;
		}

		function createGroupHdrRow(id, content, nbrCols, brdr, ht, wdth, bkColor, frColor, fWght, hAlign, vAlign, padr, padl, padt, padb) {
			var row = document.createElement("tr");
			var c = document.createElement("td");
			c.id = id;
			c.style.height = ht;
			c.style.paddingRight = padr;
			c.style.paddingLeft = padl;
			c.style.paddingTop = padt;
			c.style.paddingBottom = padb;
			c.style.textAlign = hAlign;
			c.style.fontWeight = fWght;
			c.style.verticalAlign = vAlign;
			c.style.backgroundColor = bkColor;
			c.style.color = frColor;
			c.style.border = brdr;
			c.textContent = content;
			c.colSpan = nbrCols;
			row.appendChild(c);
			return row;
		}

		// ***************************************************
		// TAB FUNCTIONS
		// ***************************************************

		$(function () {
			$("#tabs").tabs();
		});

		function activateTab(tabid) {
			$("#tabs").tabs({
				active: tabid
			});
			showTabContents(tabid);
		}

		$(function () {
			$('div.tabs').tabs();
		});

		function showTabContents(tabid) {
			//alert(tabid);
			switch (tabid) {
				case 1:
					if (jbTab1Shown === false) {
						if (jbShowFilterDates === true) {
							jsoTab1.style.display = 'block';
							jsoDivDateRange.style.display = 'block';
						}
						jbTab1Shown = true;
					}
					break;
				case 2:
					if (jbTab2Shown === false) {
						if (jiProjFilter > 0) {
							jsoTab2.style.display = 'block';
							jsoDivProjData.style.display = 'block';
							if (jiProjFilter === 1) {
								jsoDivProjList.style.display = 'block';
								jsoSpnProjLbl.innerHTML = 'Choose Project:';
							}
							if (jiProjFilter === 2 || jiProjFilter === 4) {
								jsoDivProjTextID.style.display = 'block';
								jsoSpnProjLbl.innerHTML = 'Project Data:';
								jsfProjCode.style.display = 'block';
							}
							if (jiProjFilter === 3 || jiProjFilter === 4) {
								jsoDivProjTextID.style.display = 'block';
								jsoSpnProjLbl.innerHTML = 'Project Data:';
								jsfProjName.style.display = 'block';
							}

							// Handle task data
							if (jiTaskFilter > 0) {
								jsoTab2.style.display = 'block';
								jsoDivTaskData.style.display = 'block';
								if (jiTaskFilter === 1) {
									jsoDivTaskList.style.display = 'block';
								}
								if (jiTaskFilter === 2 || jiTaskFilter === 3 || jiTaskFilter === 4) {
									jsoDivTaskIdent.style.display = 'block';
									if (jiTaskFilter === 2 || jiTaskFilter === 4) {
										jsfTaskCode.style.display = 'block';
									}
									if (jiTaskFilter === 3 || jiTaskFilter === 4) {
										jsfTaskName.style.display = 'block';
									}
								}
							}
						}
						jbTab2Shown = true;
					}
					break;
				case 3:
					if (jbTab3Shown === false) {
						if (jbGenUser === true) { jiEmpFilter === 9; }
						//Employee data
						if (jiEmpFilter > 0) {
							jsoTab3.style.display = 'block';
							jsoDivEmpData.style.display = 'block';
							if (jiEmpFilter > 0) {
								if (jiEmpFilter === 1) {
									jsoDivEmpListData.style.display = 'block';
								}
								if (jiEmpFilter === 2) {
									jsoDivEmpFLName.style.display = 'block';
									jsoDivEmpNameBlock.style.display = 'block';
								}
								if (jiEmpFilter === 3) {
									jsoSpnEmpName1.style.display = 'block';
									jsoDivEmpFLName.style.display = 'block';
								}
								if (jiEmpFilter === 9) {
									jsoDivEmpListData.style.display = 'none';
									jsoDivEmpFLName.style.display = 'none';
									jsoSpnEmpData.innerHTML = 'My Data';
									jsoDivEmpData.style.display = 'none';
									jsoSpnSupLbl.style.display = 'none';
									jsoDivSupData.style.display = 'none';
									//jsoDivSupNameBlock.style.display = 'none';
								}
							}
						}
						// Supervisor data
						if (jiSupFilter > 0 && jiEmpFilter !== 9 && jbGenUser === false) {
							jsoTab3.style.display = 'block';
							jsoDivEmpData.style.display = 'block';
							if (jiSupFilter > 0) {
								jsoDivSupData.style.display = 'block';
								if (jiSupFilter === 1) {
									jsoDivSupList.style.display = 'block';
								}
								//if (jiSupFilter === 2) {
								//	jsoDivSupNameBlock.style.display = 'block';
								//}
								if (jiSupFilter === 3) {
									jsoDivSupName.style.display = 'block';
								}
							}
						}

						jbTab3Shown = true;
					}
					break;
				case 4:
					if (jbTab4Shown === false) {
						if (jbShowFilterGD || jbShowFilterGL || jbShowFilterGR || jbShowFilterGG) {
							jsoTab4.style.display = 'block';
							if (jbShowFilterGD) {
								jsoDivDeptData.style.display = 'block';
							}
							if (jbShowFilterGL) {
								jsoDivLocData.style.display = 'block';
							}
							if (jbShowFilterGR) {
								jsoDivRoleData.style.display = 'block';
							}
							if (jbShowFilterGG) {
								jsoDivGroupData.style.display = 'block';
							}
						}
						jbTab4Shown = true;	
					}
					break;
				case 5:
					if (jbTab5Shown === false) {
						if (jbShowFilterStat === true) {
							jsoTab5.style.display = 'block';
							jsoDivStatusData.style.display = 'block';
							jsoDivTaskList.style.display = 'block';
							if (jiProjFilter > 0) {
								jsoSpnStatusLbl.innerHTML = 'Project Status:';
							}
							else {
								if (jiEmpFilter > 0) {
									jsoSpnStatusLbl.innerHTML = 'Employee Status:';
								}
							}
						}
						jbTab5Shown = true;
					}
					break;
				case 6:
					if (jbTab6Shown === false) {
						var v = ThisReportAttributes[0].Settings.toString();
						if (v.length > 0) {
							jsoTab6.style.display = 'block';
							jsoDivSettings.style.display = 'block';
							jsoDivSettings1.style.display = 'none';
							var sSettings = ',' + ThisReportAttributes[0].Settings.toString() + ',';
							//alert(sSettings);
							if (!IsContentsNullUndefEmptyGu(sSettings)) {
								if (sSettings.indexOf(',1,') > -1) {
									//alert('should be shown');
									jsoDivSettings1.style.display = 'block';
								}
							}
						}
						jbTab6Shown = true;
					}
					break;
				case 7:
					if (jbTab7Shown === false) {
						if (jbShowFilterSort === true) {
							jsoTab7.style.display = 'block';
							jsoDivSorting.style.display = 'block';
						}
						jbTab7Shown = true;
					}
					break;
				case 8:
					if (jbTab8Shown === false) {
						//if (jbShowFilterSort == true) {
							jsoTab8.style.display = 'block';
							jsoDivGroupBy.style.display = 'block';
						//}
						jbTab8Shown = true;
					}
					break;
				default:
					break;
			}
			return false;
		}

		// 'show' or 'hide' or '' to toggle
		function ToggleTabDisplay(v) {
			var vsbl = 0;
			if (v === undefined || v === null) {v = ''; }
			if (v === 'hide') {vsbl = 1; }
			if (v === 'show') {vsbl = 2; }

			if (jbParamVisible === true || vsbl === 1) {
				//jsoTabs.style.height = '0px';
				jsoTab1.style.height = '0px';
				jsoTab2.style.height = '0px';
				jsoTab3.style.height = '0px';
				jsoTab4.style.height = '0px';
				jsoTab5.style.height = '0px';
				jsoTab6.style.height = '0px';
				jsoTab7.style.height = '0px';
				jsoTab8.style.height = '0px';
				// Handle tab contents
				if (jbShowFilterDates === true) {
					jsoDivDateRange.style.display = 'none';
				}
				if (jiProjFilter > 0) {
					jsoDivProjData.style.display = 'none';
				}
				jsoDivEmployeeDataBlock.style.display = 'none';
				jsoDivFiltersBlock.style.display = 'none';
				if (jbShowFilterStat === true) {
					jsoDivStatusData.style.display = 'none';
				}
				jsoDivSettings.style.display = 'none';
				if (jbShowFilterSort === true) {
					jsoDivSorting.style.display = 'none';
				}
				if (jbTab8Shown === true) {
					jsoDivGroupBy.style.display = 'none';
				}
				jbParamVisible = false;
			}
			else {
				jsoTab1.style.height = '100px';
				jsoTab2.style.height = '100px';
				jsoTab3.style.height = '100px';
				jsoTab4.style.height = '100px';
				jsoTab5.style.height = '100px';
				jsoTab6.style.height = '100px';
				jsoTab7.style.height = '100px';
				jsoTab8.style.height = '100px';


				if (jbShowFilterDates === true) {
					jsoDivDateRange.style.display = 'block';
				}
				if (jiProjFilter > 0) {
					jsoDivProjData.style.display = 'block';
				}
				jsoDivEmployeeDataBlock.style.display = 'block';
				jsoDivFiltersBlock.style.display = 'block';
				if (jbShowFilterStat === true) {
					jsoDivStatusData.style.display = 'block';
				}
				jsoDivSettings.style.display = 'block';
				if (jbShowFilterSort === true) {
					jsoDivSorting.style.display = 'block';
				}
				if (jbTab8Shown === true) {
					jsoDivGroupBy.style.display = 'block';
				}
				jbParamVisible = true;
			}
		}

		// change page number
		function changePgNbr(dir, pg) {
			if (pg === 0) {
				// increment/decrement 
				switch (dir) {
					case 1:
						jiCurrentPage = 1;
						break;
					case 2:
						jiCurrentPage--;
						break;
					case 3:
						jiCurrentPage++;
						break;
					case 4:
						jiCurrentPage = jiTotalPages;
						break;
					default:
						break;
				}
			}
			else {
				jiCurrentPage = pg;
			}
			if (jiCurrentPage < 1) {jiCurrentPage = 1;}
			if (jiCurrentPage > jiTotalPages) { jiCurrentPage = jiTotalPages; }

			// Refresh report data
			GetReportPageData(jiCurrentPage);
		}

		// change rows per page setting
		function changePaginationSetting(val, txt) {
			jiPageSize = val;
			jsfHfPaginationText.value = txt;
			//alert(jiPageSize);
		}

		// change stored parameter settings
		function changeParamSetting(typ, val, txt) {
			//alert(val);
			switch (typ) {
				case 0: //hfStartDt
					jsfHfStartDt.value = val;
					break;
				case 1: //hfEndDt
					jsfHfEndDt.value = val;
					break;
				//case 2: //hfProjID
				//	document.getElementById('C_hfProjID').value = val; 
				//	break;
				case 3: //hfTaskID
					jsfHfTaskID.value = val;
					jsfHfTaskText = txt;
					break;
				case 4: //hfPCode
					jsfHfPCode.value = val;
					break;
				case 5: //hfPName
					jsfHfPName.value = val;
					break;
				case 6: //hfTCode
					jsfHfTCode.value = val;
					break;
				case 7: //hfTName
					jsfHfTName.value = val;
					break;
				case 8: //hfLastName
					jsfHfLastName.value = val;
					break;
				case 9: //hfFirstName
					jsfHfFirstName.value = val;
					break;
				//case 10: //hfMiddleName
				//	jsfHfMiddleName.value = val; 
				//	break;
				case 11: //hfMgrID
					jsfHfMgrID.value = val;
					jsfHfMgrText.value = txt;
					break;
				case 12: //hfMgrLast
					jsfHfMgrLast.value = val;
					break;
				case 13: //hfMgrFirst
					jsfHfMgrFirst.value = val;
					break;
				case 14: //hfRoleID
					jsfHfRoleID.value = val;
					jsfHfRoleText.value = txt;
					break;
				case 15: //hfGroupID
					jsfHfGroupID.value = val;
					jsfHfGroupText.value = txt;
					break;
				case 16: //hfLocID
					jsfHfLocID.value = val;
					jsfHfLocText.value = txt;
					break;
				case 17: //hfDeptID
					jsfHfDeptID.value = val;
					jsfHfDeptText.value = txt;
					break;
				case 18: //hfSupID
					jsfHfSupID.value = val;
					break;
				case 19: //hfStatusID
					jsfHfStatusID.value = val;
					jsfHfStatusText.value = txt;
					break;
				case 20: //hfSortID
					jsfHfSortID.value = val;
					jsfHfSortText.value = txt;
					break;
				case 21: //hfPEmpID
					jsfHfPEmpID.value = val;
					jsfHfPEmpName.value = txt;
					break;
				case 22: //hfSumOnly
					if (val === true) {
						jsfHfSumOnly.value = '1';
					}
					else {
						jsfHfSumOnly.value = '0';
					}
					break;
				case 23: //hfExcludeEmpty
					if (val === true) {
						jsfHfExcludeEmpty.value = '1';
					}
					else {
						jsfHfExcludeEmpty.value = '0';
					}
					break;
				default:
					// do nothing
					break;
			}
		}

		function TranslateEntryToName(obj) {
			obj.style.border = '2px solid #D9D9D9';
			var val = obj.value;
			var newVal = '';

			// check if a value has more than 1 char, and not yet been translated or person has put a period in the box to force re-translation, etc.
			if (val.length > 1 && lastValue != val && (IsTranslated === 0 || val.indexOf('.') > 0)) {
				var MyQString = 't=0&ts=' + val + '&i=0';
				//alert(MyQString);
				var result = $.ajax({
					type: "POST",
					url: "../Shared/AjaxGetData.aspx",
					data: MyQString,
					contentType: "application/x-www-form-urlencoded; charset=UTF-8",
					dataType: "text",
					async: false,
					error: function (response, q, t) {
						var rsp = response.responseText;
						var rslt = '';
						if (!IsContentsNullUndefEmptyGu(rsp)) {
							rslt = rsp.substring(0, rsp.indexOf("\n"));
						}
						alert("Your entry could not be evaluated because of an error: " + rslt);
					}
				}).responseText;

				if (result.length > 0) {
					if (result.indexOf('\n') > 0) {
						if (result.indexOf('\n') > 1) {
							result = result.substring(0, result.indexOf('\n') - 1);
							newVal = result;

							// insert new value
							if (newVal.indexOf('|') > 0) {
								var MyArray = newVal.split('|');
								obj.value = MyArray[0];
								jsfHfPEmpName = MyArray[0];
								jsfHfPEmpID = MyArray[1];
								lastVal = MyArray[0];
							}
							else {
								obj.value = newVal;
								lastVal = newVal;
								jsfHfPEmpName = '';
								jsfHfPEmpID = '0';
							}
							// set standard border since it worked and validated
							obj.style.border = '2px solid #D9D9D9';
						}
						else {
							obj.value = '';
							obj.style.border = '3px solid red';
						}
					}

				}
				else {
					obj.value = val;
					alert('The evaluation and replacement of your entry failed for an unknown reason.');
				}
			}
			else {
				if (val.length === 1) {
					obj.value = '';
				}
			}
		}

		function ExportReportData2() {
			var obj = document.getElementById('selExportDataType');
			var typ = obj[obj.selectedIndex].value;
			ExportReportData(typ);
			return false;
		}
	</script>

	<br />

	<asp:HiddenField ID="hfEmpID" runat="server" Value="0"></asp:HiddenField>
	<asp:HiddenField ID="hfPEmpID" runat="server" Value="0"></asp:HiddenField>
	<asp:HiddenField ID="hfPEmpName" runat="server" Value=""></asp:HiddenField>
	<asp:HiddenField ID="hfRptID" runat="server" Value="0"></asp:HiddenField>
	<asp:HiddenField ID="hfRptName" runat="server" Value=""></asp:HiddenField>
	<asp:HiddenField ID="hfBT" runat="server" Value=""></asp:HiddenField>
	<asp:HiddenField ID="hfStartDt" runat="server" Value=""></asp:HiddenField>
	<asp:HiddenField ID="hfEndDt" runat="server" Value=""></asp:HiddenField>
	<asp:HiddenField ID="hfProjID" runat="server" Value="0"></asp:HiddenField>
	<asp:HiddenField ID="hfTaskID" runat="server" Value="0"></asp:HiddenField>
	<asp:HiddenField ID="hfPCode" runat="server" Value=""></asp:HiddenField>
	<asp:HiddenField ID="hfPName" runat="server" Value=""></asp:HiddenField>
	<asp:HiddenField ID="hfTCode" runat="server" Value=""></asp:HiddenField>
	<asp:HiddenField ID="hfTName" runat="server" Value=""></asp:HiddenField>
	<asp:HiddenField ID="hfLastName" runat="server" Value=""></asp:HiddenField>
	<asp:HiddenField ID="hfFirstName" runat="server" Value=""></asp:HiddenField>
	<asp:HiddenField ID="hfMiddleName" runat="server" Value=""></asp:HiddenField>
	<asp:HiddenField ID="hfMgrID" runat="server" Value="0"></asp:HiddenField>
	<asp:HiddenField ID="hfMgrLast" runat="server" Value=""></asp:HiddenField>
	<asp:HiddenField ID="hfMgrFirst" runat="server" Value=""></asp:HiddenField>
	<asp:HiddenField ID="hfRoleID" runat="server" Value="0"></asp:HiddenField>
	<asp:HiddenField ID="hfGroupID" runat="server" Value="0"></asp:HiddenField>
	<asp:HiddenField ID="hfLocID" runat="server" Value="0"></asp:HiddenField>
	<asp:HiddenField ID="hfDeptID" runat="server" Value="0"></asp:HiddenField>
	<asp:HiddenField ID="hfSupID" runat="server" Value="0"></asp:HiddenField>
	<asp:HiddenField ID="hfStatusID" runat="server" Value="0"></asp:HiddenField>
	<asp:HiddenField ID="hfSortID" runat="server" Value="0"></asp:HiddenField>
	<asp:HiddenField ID="hfMgrText" runat="server" Value="0"></asp:HiddenField>
	<asp:HiddenField ID="hfProjText" runat="server" Value="0"></asp:HiddenField>
	<asp:HiddenField ID="hfTaskText" runat="server" Value="0"></asp:HiddenField>
	<asp:HiddenField ID="hfRoleText" runat="server" Value="0"></asp:HiddenField>
	<asp:HiddenField ID="hfGroupText" runat="server" Value="0"></asp:HiddenField>
	<asp:HiddenField ID="hfLocText" runat="server" Value="0"></asp:HiddenField>
	<asp:HiddenField ID="hfDeptText" runat="server" Value="0"></asp:HiddenField>
	<asp:HiddenField ID="hfStatusText" runat="server" Value="0"></asp:HiddenField>
	<asp:HiddenField ID="hfSortText" runat="server" Value="0"></asp:HiddenField>
	<asp:HiddenField ID="hfPaginationText" runat="server" Value="0"></asp:HiddenField>
	<asp:HiddenField ID="hfSumOnly" runat="server" Value="0"></asp:HiddenField>
	<asp:HiddenField ID="hfExcludeEmpty" runat="server" Value="0"></asp:HiddenField>

	<!------------------------------------------- NON-REPORT HEADER ----------------------------------------------->
	<div id="divNonReportHdr" style="width:100%;display:block;margin-left:10px;">
		<div id="divRRSLink" style="width:100%;text-align:right;">
			<a href="http://reports.corp.morpho.com/Reports/Pages/Folder.aspx?ItemPath=%2fTimeLive+Reports&ViewMode=List" style="padding-left:10px;"><span style="color:blue;text-decoration:underline;">MorphoTrak TimeLive Reporting Services (External Site)</span></a>&nbsp;&nbsp;&nbsp;
			<br /><br />
		</div>

		<!--------------------------------------------- Report List ------------------------------------------------->

		<div id="divHelloMsg" style="width:99%;text-align:left;vertical-align:middle;border:none;margin-bottom:4px;">
			<asp:Label ID="Label1" runat="server" Text="" style="font-size:12pt;font-family:Tahoma;font-weight:bold;width:100%;">Hello, </asp:Label><asp:Label ID="lblUserName" runat="server" Text="" style="font-size:12pt;font-family:Tahoma;font-weight:bold;width:100%;"></asp:Label><br />
		</div>

		<div id="divMainHdr" style="width:99%;text-align:left;height:32px;vertical-align:middle;border:1px solid Blue;background-color:AntiqueWhite;margin-bottom:4px;">
			<div id="divMainHdrT" style="width:100%;height:20px;margin-top:5px;">
			<table style="border-collapse:collapse;padding:1px;">
			<tr>
				<td style="text-align:right;font-size:10pt;color:Blue;font-family:tahoma;font-weight:bold;text-align:right;">
					&nbsp;Select Report:&nbsp;
				</td>
				<td style="text-align:left;">
					<select id="selReport" onchange="javascript:SetReportParamView(this)" style="font-size:10pt;font-family:tahoma;color:Blue;font-weight:bold;">
						<option value="0" selected="selected">- No Report Selected -</option>
					</select>
				</td>		
			</tr>		
			</table>
			</div>

			<br />

		</div>

		<!--------------------------------------------- Parameters ------------------------------------------------->
		<div id="divParamSection" style="display:none;width:98%;vertical-align:top;text-align:left;">
			<div id="divParamsTabHdr" style="width:100%;">
				<table style="width:100%;">
				<tr>
					<td style="text-align:left;font-weight:bold;padding:0px;">
						Report Parameters:
					</td>
					<td style="text-align:right;padding:0px;">
						&nbsp;&nbsp;&nbsp;<button id="btnToggleTabDisplay" onclick="ToggleTabDisplay('');" style="height:22px;font-size:10pt;">Toggle Parameter Area Visibility</button>
					</td>
				</tr>
				</table>
			</div>

			<div id="tabs" style="font-size:9pt;font-family:Calibri;font-weight:bold;">
				<ul>
					<li id="liTab1"><a href="#tabs-1">Dates</a></li>
					<li id="liTab2"><a href="#tabs-2">Projects</a></li>
					<li id="liTab3"><a href="#tabs-3">Employees</a></li>
					<li id="liTab4"><a href="#tabs-4">Filters</a></li>
					<li id="liTab5"><a href="#tabs-5">Status</a></li>
					<li id="liTab6"><a href="#tabs-6">Settings</a></li>
					<li id="liTab7"><a href="#tabs-7">Sorting</a></li>
					<li id="liTab8"><a href="#tabs-8">Group By</a></li>
				</ul>

				<!------------------------ Dates - TAB 1 -------------------------->
				<div id="tabs-1" style="height:100px;">
					<div id="divDateRange" style="width:98%;display:none;height:100px;">
						<br />
						<span id="spnDateRangeLbl" style="padding-left:6px;font-weight:bold;color:DarkGray;font-size:9pt;">Date Range:</span>&nbsp;
						<span style="font-size:9pt;">From:&nbsp;<input id="txtBeginDate" value="" style="width:84px;color:Blue;" onchange="changeParamSetting(0, this.value, '');" />&nbsp;&nbsp;to:&nbsp;
						<input id="txtEndDate" value="" style="width:84px;color:Blue;" onchange="javascript:changeParamSetting(1, this.value, '');" /></span>
					</div>
				</div>
		
				<!------------------------ Projects - TAB 2 -------------------------->
				<div id="tabs-2" style="height:100px;">
					<div id="divProjData" style="width:98%;display:none;height:100px;">
						<br />
						<table style="padding:0px;width:100%;">
						<tr>
							<td style="vertical-align:top;width:130px;padding:0px;border-spacing:0px;">
								<span id="spnProjLbl" style="padding-left:6px;">Project:</span>&nbsp;
							</td>					
							<td style="vertical-align:top;text-align:left;padding:0px;border-spacing:0px;">
								<div id="divProjList" style="width:98%;display:none;">
									<select id="selProjectList" onchange="javascript:LoadTaskIDList(this[this.selectedIndex].value, this[this.selectedIndex].text);" style="font-size:9pt;" >
										<option value="-1" selected="selected">None Selected</option>
										<option value="0">All</option>
									</select>
								</div>
								<div id="divProjTextID" style="width:98%;display:none;">

									<table style="padding:0px;height:22px;font-size:9pt;">
									<tr>
										<td style="vertical-align:middle;padding:0px;border-spacing:0px;">
											<span style="font-size:9pt;">Code:</span>
										</td>
										<td style="vertical-align:middle;padding:0px;border-spacing:0px;">
											<input id="txtProjCode" style="width:100px;" value="" onchange="javascript:changeParamSetting(4, this.value, '');" />
										</td>
										<td style="vertical-align:middle;padding:0px;border-spacing:0px;">
											&nbsp;Name:
										</td>
										<td style="vertical-align:middle;padding:0px;border-spacing:0px;">
											<input id="txtProjName" style="width:200px;" value="" onchange="javascript:changeParamSetting(5, this.value, '');" />
										</td>
									</tr>
									</table>
									
								</div>
							</td>					
						</tr>
						<tr>
							<td style="vertical-align:top;width:130px;padding:0px;border-spacing:0px;">
								<span id="spnTaskDataLbl" style="padding-left:6px;">Task Data:</span>&nbsp;
							</td>					
							<td style="vertical-align:top;text-align:left;padding:0px;border-spacing:0px;">
								<div id="divTaskData" style="width:100%;display:none;font-size:9pt;">
									<div id="divTaskList" style="width:98%;display:none;">
										<select id="selTaskList" onchange="javascript:changeParamSetting(3,this[this.selectedIndex].value, this[this.selectedIndex].text);">
											<option value="0" selected="selected">All</option>
										</select>
									</div>
									<div id="divTaskCodeIdent" style="width:98%;display:none;font-size:9pt;">

										<table style="padding:0px;height:22px;font-size:9pt;">
										<tr>
											<td style="vertical-align:middle;padding:0px;border-spacing:0px;">
												<span style="font-size:9pt;">Code:</span>
											</td>
											<td style="vertical-align:middle;padding:0px;border-spacing:0px;">
												<span style="font-size:9pt;"><input id="txtTaskCode" style="width:100px;" value="" onchange="javascript:changeParamSetting(6, this.value, '');" /></span>
											</td>
											<td style="vertical-align:middle;padding:0px;border-spacing:0px;">
												<span style="font-size:9pt;">&nbsp;Name:</span>
											</td>
											<td style="vertical-align:middle;padding:0px;border-spacing:0px;">
												<span style="font-size:9pt;"><input id="txtTaskName" style="width:200px;" value="" onchange="javascript:changeParamSetting(7, this.value, '');" /></span>
											</td>
										</tr>
										</table>

									</div>
								</div>
							</td>					
						</tr>
						</table>
					</div>

				</div>

				<!------------------------ Employees - TAB 3 -------------------------->
				<div id="tabs-3" style="height:100px;">
					<div id="divEmployeeDataBlock" style="width:98%;height:100px;">
						<br />

						<table style="padding:0px;line-height:24px;">
						<tr>
							<td style="vertical-align:middle;padding:0px;border-spacing:0px;">
								<span id="spnEmpData" style="padding-left:6px;">Employee Data:</span>&nbsp;
							</td>
							<td style="vertical-align:middle;padding:0px;border-spacing:0px;">
								<div id="divEmpData" style="width:98%;display:none;font-size:9pt;">
									<div id="divEmpListData" style="display:none;font-size:9pt;">
										<select id="selEmpList" onchange="javascript:changeParamSetting(21, this[this.selectedIndex].value, this[this.selectedIndex].text);" >
										<option value="0" selected="selected">All</option>
										</select>
									</div>
									<div id="divEmpNameBlock" style="width:98%;display:none;font-size:9pt;">
										<span id="spnEmpData2" style="display:none;">Employee Ident: <input id="txtEmpID" value="" style="width:120px;"  onchange="javascript:TranslateEntryToName(this);" /></span>
										<input type="hidden" id="hfTargetEmpID" value="" />
									</div>
									<div id="divEmpLastFirstName" style="width:98%;display:none;font-size:9pt;">
										Last Name: <input id="txtLastName" value="" onchange="javascript:changeParamSetting(8, this.value, '');" />, First Name: <input id="txtFirstName" value="" onchange="javascript:changeParamSetting(9, this.value, '');" />
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<td style="vertical-align:middle;padding:0px;border-spacing:0px;">
								<span id="spnSupervisorLbl" style="padding-left:6px;">Supervisor:</span>&nbsp;
							</td>
							<td style="vertical-align:middle;padding:0px;border-spacing:0px;">
								<div id="divSupervisorData" style="width:98%;display:none;font-size:9pt;">
									<div id="divSupList" style="width:98%;display:none;font-size:9pt;">
										<select id="selSupervisorID" onchange="javascript:changeParamSetting(11,this[this.selectedIndex].value);" >
											<option value="0" selected="selected">All</option>
										</select>
									</div>
									<!--div id="divSupNameBlock" style="width:98%;display:none;height:30px;font-size:9pt;">
										Name: <input id="txtSupName" value="" onchange="javascript:changeParamSetting(1, this.value);" />
									</div-->
									<div id="divSupervisorName" style="width:98%;display:none;height:30px;">
										Last Name: <input id="txtSupLastName" value="" onchange="javascript:changeParamSetting(12, this.value);" />, First Name: <input id="txtSupFirstName" value="" onchange="javascript:changeParamSetting(13, this.value);" />
									</div>
								</div>
							</td>
						</tr>
						</table>
					</div>
				</div>

				<!------------------------ Groupings - TAB 4 -------------------------->
				<div id="tabs-4" style="height:100px;">
					<div id="divFiltersBlock" style="width:98%;height:100px;">

						<table style="width:100%;height:100px;font-size:9pt;">
						<tr>
							<td style="vertical-align:top;width:25%;padding:0px;border-spacing:0px;">
								<div id="divDeptData" style="width:98%;display:none;font-size:9pt;">
									<br />
									<span id="spnDeptDataLbl" style="padding-left:6px;">Department:</span>&nbsp;
									<select id="selDeptID" onchange="javascript:changeParamSetting(17, this[this.selectedIndex].value);">
										<option value="0" selected="selected">All</option>
									</select>
								</div>
							</td>
							<td style="vertical-align:top;width:25%;padding:0px;border-spacing:0px;">
								<div id="divLocationData" style="width:98%;display:none;font-size:9pt;">
									<br />
									<span id="spnLocDataLbl" style="padding-left:6px;">Location:</span>&nbsp;
									<select id="selLocationID" onchange="javascript:changeParamSetting(16, this[this.selectedIndex].value);" >
										<option value="0" selected="selected">All</option>
									</select>
								</div>
							</td>
							<td style="vertical-align:top;width:25%;padding:0px;border-spacing:0px;">
								<div id="divRoleData" style="width:98%;display:none;font-size:9pt;">
									<br />
									<span id="spnRoleLbl" style="padding-left:6px;">Role:</span>&nbsp;
									<select id="selRoleID" onchange="javascript:changeParamSetting(14, this[this.selectedIndex].value, this[this.selectedIndex].text);"  >
										<option value="0" selected="selected">All</option>
									</select>
								</div>
							</td>
							<td style="vertical-align:top;width:25%;padding:0px;border-spacing:0px;">
								<div id="divGroupData" style="width:98%;display:none;font-size:9pt;">
									<br />
									<span id="spnGroupLbl" style="padding-left:6px;">Group:</span>&nbsp;
									<select id="selGroupID" onchange="javascript:changeParamSetting(16, this[this.selectedIndex].value, this[this.selectedIndex].text);" >
										<option value="0" selected="selected">All</option>
									</select>
								</div>
							</td>
						</tr>
						</table>
					</div>
				</div>

				<!------------------------ Status - TAB 5 -------------------------->
				<div id="tabs-5" style="height:100px;">
					<div id="divStatusData" style="width:98%;display:none;font-size:9pt;">
						<br />
						<span id="spnStatusLbl" style="padding-left:6px;">Status:</span>&nbsp;
						<select id="selStatusID" onchange="javascript:changeParamSetting(19, this[this.selectedIndex].value, this[this.selectedIndex].text);" >
							<option value="0" selected="selected">All</option>
						</select>
					</div>
				</div>

				<!------------------------ Settings - TAB 6 -------------------------->
				<div id="tabs-6" style="height:100px;">
					<div id="divSettings" style="width:98%;display:none;font-size:9pt;">
						<br />
						<table style="padding:1px;border-collapse:collapse;">
						<tr>
							<td style="vertical-align:middle;height:20px;padding:1px;border-spacing:0px;">
								<span id="spnPaginationLbl" style="padding-left:6px;font-weight:bold;color:DarkGray;height:20px;">Pagination:</span>&nbsp;&nbsp;
							</td>
							<td style="vertical-align:middle;height:20px;">
								<select id="selPagination" onchange="changePaginationSetting(this[this.selectedIndex].value, this[this.selectedIndex].text)">
									<option value="1000000">Unset</option>
									<option value="10">10 Rows Per Page</option>
									<option value="20" selected="selected">20 Rows Per Page</option>
									<option value="30">30 Rows Per Page</option>
									<option value="40">40 Rows Per Page</option>
									<option value="50">50 Rows Per Page</option>
								</select>
							</td>
						</tr>
						<tr>
							<td style="vertical-align:middle;height:20px;padding:1px;border-spacing:0px;">
								<span id="spnSettingsLbl" style="padding-left:6px;font-weight:bold;color:DarkGray;height:20px;">Settings:</span>&nbsp;&nbsp;
							</td>
							<td style="vertical-align:middle;height:20px;">
								<div id="divSettings1" style="display:none;height:20px;">
									<table style="padding:0px;height:20px;">
									<tr>
										<td style="vertical-align:middle;padding:0px;border-spacing:0px;">
											Summary Only&nbsp;
										</td>								
										<td style="vertical-align:middle;padding:0px;border-spacing:0px;">
											<input type="checkbox" id="chkSumOnly" onclick="javascript:changeParamSetting(22, this.checked, 'Summary Only');" />&nbsp;&nbsp;
										</td>								
										<td style="vertical-align:middle;padding:0px;border-spacing:0px;">
											Exclude Empties&nbsp;
										</td>								
										<td style="vertical-align:middle;padding:0px;border-spacing:0px;">
											<input type="checkbox" id="chkExcEmpties" onclick="javascript:changeParamSetting(23, this.checked, 'Exclude Empties');" />
										</td>								
									</tr>
									</table>
								</div>
							</td>
						</tr>
						</table>
					</div>
				</div>

				<!------------------------ Sorting - TAB 7 -------------------------->
				<div id="tabs-7" style="height:100px;">
					<div id="divSorting" style="width:98%;display:none;font-size:9pt;">
						<br />
						<span id="spnSortingLbl" style="padding-left:6px;">Sorting:</span>&nbsp;
						<span id="spnSort1" style="display:none;">
							<select id="selSortList" onchange="javascript:changeParamSetting(20, this[this.selectedIndex].value);" >
								<option value="-" selected="selected">None Selected (default)</option>
							</select>
						</span>
					</div>
				</div>

				<!------------------------ Sorting - TAB 8 -------------------------->
				<div id="tabs-8" style="height:100px;">
					<div id="divGroupBy" style="width:98%;display:none;font-size:9pt;">
						<br />
						<div id="divGroupByContent" style="width:99%;">
						</div>
					</div>
				</div>
			</div>

			<div id="divButtonBar" style="width:98%;display:block;text-align:left;">
				<br />
				<button id="btnGenerateReport" onclick="javascript:ExtractReportData();"  class="button blue-gradient glossy" style="width:120px;">Generate Report</button>
			</div>

		</div>
	</div>

	<!--------------------------------------------- REPORT VIEW ------------------------------------------------->
	<div id="divReportView" runat="server" style="width:100%;padding-top:2px;padding-bottom:2px;padding-left:10px;padding-right:5px;display:none;font-weight:normal;font-size:8pt;">
    
		<hr style="height:5px;color:Gray;background-color:Gray;" />

		<div id="divReportHdr" style="width:100%;padding:0px;margin:0px;display:none;font-size:9pt;">
			<asp:Label ID="lblRptName" runat="server" Text="" style="font-size:12pt;font-family:Tahoma;font-weight:bold;width:100%;"></asp:Label><br />
			Ran:&nbsp;<asp:Label ID="lblRptDateTime" runat="server" Text="" style="font-size:8pt;font-style:italic;"></asp:Label>&nbsp;-&nbsp;Generated By:&nbsp;<asp:Label ID="lblRptGenBy" runat="server" Text="" style="font-size:8pt;font-style:italic;"></asp:Label><br />
			Parameters:&nbsp;<asp:Label ID="lblParamsChosen" runat="server" Text="" style="font-weight:normal;font-size:8pt;"></asp:Label><br />
			<asp:Label ID="lblRptHdrMsg" runat="server" Text="" style="width:100%;font-weight:normal;font-size:10pt;"></asp:Label>
		</div>

		<div id="divReportMain" style="width:100%;padding:0px;margin-left:0px;margin-right:0px;margin-top:8px;margin-bottom:4px;">
			<div id="divReportMainPg" style="width:100%;padding:0px;margin-bottom:4px;">
				<a href="#" onclick="changePgNbr(1, 0);">|<</a>&nbsp;&nbsp;<a href="#" onclick="changePgNbr(2, 0);"><</a>&nbsp;&nbsp;Page <label id="lblPageNbr" style="color:Blue;font-weight:bold;">1</label>&nbsp;of&nbsp;<label id="lblNbrPages" style="color:Blue;font-weight:bold;" onclick="changePgNbr(4, 0);">1</label>&nbsp;&nbsp;<a href="#" onclick="changePgNbr(3, 0);">></a>&nbsp;&nbsp;<a href="#" onclick="changePgNbr(4, 0);">>|</a>&nbsp;&nbsp;<label id="Label2" style="font-size:9pt;font-weight:normal;">Page Nbr:</label>&nbsp;<input type="text" id="txtNewPgNbr" onchange="changePgNbr(0, this.value);" style="width:50px;" />
			</div>
			<table id="tblMainData" style="padding:0px;border-collapse:collapse;">
			</table>
		</div>

		<div id="divReportFtr" style="width:100%;padding:0px;margin:0px;">
			<asp:Label ID="lblRptFtrMsg" runat="server" Text="" style="width:100%;"></asp:Label>
		</div>

    </div>

	<div id="divBottomBtn" runat="server" style="width:100%;text-align:left;display:none;margin-top:6px;margin-left:14px;">
		<table>
		<tr>
			<td style="padding:0px;border-spacing:0px;vertical-align:top;">
				Export Report Data to a file:&nbsp;
			</td>		
			<td style="padding:0px;border-spacing:0px;vertical-align:middle;">
				<select id="selExportDataType" onchange="ExportReportData(this[this.selectedIndex].value);" >
				<option value="0" selected="selected">Excel</option>
				<option value="1" selected="selected">CSV</option>
				<option value="2" selected="selected">XML</option>
				<option value="3" selected="selected">HTML</option>
				</select>&nbsp;&nbsp;
			</td>		
			<td style="padding:0px;border-spacing:0px;vertical-align:middle;">
				<button id="btnExportData" onclick="ExportReportData2();" style="line-height:14px;height:20px;font-size:9pt;">Export</button>
			</td>		
		</tr>
		
		</table>

	</div>

	<br />
	<asp:Label ID="lblStatusMsg" runat="server" text="" style="width:100%;color:Maroon;font-weight:bold;margin-left:30px;"></asp:Label>

</div>

</asp:Content>
