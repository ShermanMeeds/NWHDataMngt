<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainMenu.aspx.cs" Inherits="DataMngt.page.MainMenu1" %>
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
		var jdToday = new Date();
		var jiAR = 0;
		var jiByID = 0;
		var jiNbrPages = 0;
		var jiNbrRows = 0;
		var jiPageID = 1;
		var jiPageNbr = 0;
		var jiPageSize = 20;
		var jiTotalRows = 0;
		var jiUserID = 0;
		var jiViewType = 0;
		var jlPageStatus;
		var jlStatusMsg;
		var jsBrowserType = '';
		var jsCurrentTime = '';
		var jsErrorMsg = '';
		var jsPageVersion = '';
		var jsPageVersDate = '';
		var jsToday = '';
		var julReqDocs;
		var julMngtFunctions;
		var julGeneralFunctions;
		var julSalesFunctions;
		var julFinanceMenu;

		var counter = 0;
		var MyMenuItems;

		$(document).ready(function () {
			jsToday = getMyDateTimeStringDm(jdToday, 18);
			jsCurrentTime = getMyDateTimeStringDm(jdToday, 7);
			//alert(jdToday + '/' + jsToday + '/' + jsCurrentTime);
			updateClockNV();
			KeepSessionAlive();

			// set global default values
			//alert('Ready starting');
			jiPageID = 1;
			jsPageVersion = '1.0.0';
			jsPageVersDate = '9/8/2017';
			jbViewOnly = true;
			//alert('loading seed values');
			// Load global page-loaded variables
			jiByID = jigEmpID;
			jsBrowserType = jsgBrowserType;
			//alert(jsBrowserType);

			$('#Form1').on("submit", function (evt) {
				evt.preventDefault();
			});

			jlStatusMsg = document.getElementById('lblStatusMsg');
			julReqDocs = document.getElementById('ulReqDocs');
			julMngtFunctions = document.getElementById('ulMngtFunctions');
			julGeneralFunctions = document.getElementById('ulGeneralFunctions');
			julSalesFunctions = document.getElementById('ulSalesFunctions');
			julFinanceMenu = document.getElementById('ulFinanceMenu');

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
			var sCurrDate = jaDMDayNames[currentTime.getDay()] + ' ' + currentTime.toLocaleDateString(); // currentTime.toDateString();

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
			//alert('setting pagination');
			//EstablishMainPgElementsPj(1, 0);
			//EstablishMainPgElementsPj(2, 0);
			//EstablishMainPgElementsPj(3, 0);
			//EstablishMainPgElementsPj(4, 0);
			//jiNbrPagesPj[0] = 0;
			//jiNbrRowsPj[0] = 0;
			//jiNbrPagesPj[1] = 0;
			//jiNbrRowsPj[1] = 0;
			//jiNbrPagesPj[2] = 0;
			//jiNbrRowsPj[2] = 0;
			//jiNbrPagesPj[3] = 0;
			//jiNbrRowsPj[3] = 0;
			//jiPageSize = 20;
			//alert('Initiation done');

			//createDatePickerOnTextWc('txtBeginDateF', null, null, 0, 3, 'show', 11);
			//createDatePickerOnTextWc('txtEndDateF', null, null, 0, 3, 'show', 12);
			GetMenuItems(9999, 9999, '');
			PopulateMenu();
			document.getElementById('lblPageIDInFooter').innerHTML = 'Page ID: ' + jiPageID.toString();
			return false;
		}

		function GetMenuItems(sec, itm, nm) {
			var url = "../shared/AdminServices.asmx/SelectMenuItemList";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','Section':'" + sec.toString() + "','Item':'" + itm.toString() + "','Nm':'" + nm + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);																																																																	  
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyMenuItems = response; });
			return false;
		}	

		function PopulateMenu() {
			var Section = 0;
			var sid = '';
			var ttl = '';
			var txt = '';
			if (!IsContentsNullUndefEmptyGu(MyMenuItems)) {
				for (var row = 0; row < MyMenuItems.length; row++) {
					Section = parseInt(MyMenuItems[row]['MenuSection'], 10);
					sid = 'row' + Section.toString() + '_' + row.toString() + '_Item';
					ttl = MyMenuItems[row]['MenuTitle'].toString();
					if (ttl === '') {
						txt = '';
					}
					else {
						txt = '<a href="' + MyMenuItems[row]['MenuURL'].toString() + '">' + ttl + '</a>';
					}
					switch (Section) {
						case 0:
							AppendItemToULListGu(julReqDocs, sid, txt, 1);
							break;
						case 1:
							AppendItemToULListGu(julMngtFunctions, sid, txt, 1);
							break;
						case 2:
							AppendItemToULListGu(julGeneralFunctions, sid, txt, 1);
							break;
						case 3:
							AppendItemToULListGu(julSalesFunctions, sid, txt, 1);
							break;
						case 4:
							AppendItemToULListGu(julFinanceMenu, sid, txt, 1);
							break;
						default:
							break;
					}
				}
			}
			return false;
		}

		function GotoPage(url) {
			document.location.href = url;
		}

	</script>

  <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />

</head>
<body>
	<img id="imgSessionKeepAlive" width="1" height="1" style="display:none;" src="../Images/clearpixel.gif" />
  <form id="form2" runat="server">
  <asp:ScriptManager runat="server"></asp:ScriptManager>
	<asp:HiddenField ID="hfPageID" runat="server" Value="1" />

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

			<div id="divPAGEHEADER" style="width:100%;margin-left:10px;margin-bottom:10px;display:none;">
    	</div>

			<div id="divPAGEMAINCONTENT" style="width:100%;margin-left:10px;margin-bottom:10px;">
				<div id="divMyHeaderLines" class="MyHeaderLine" style="margin-bottom:10px;color:aliceblue;font-family:Tahoma;">
					Northwest Hardwoods Data Management<br />
					Main Menu
				</div>

				<div id="divMainMenu" style="width:100%;">
					<table id="tblMainMenu" style="padding:0px;border-spacing:0px;width:100%;">
					<tr>
						<td style="width:20%;border:none;height:500px;vertical-align:top;padding:4px;text-align:center;">
							<div id="divGenHdrA">
								<label id="lblGenHdrMA" class="lblHighlightedBlue">Request Documents</label>
							</div>
							<div id="divRequestDocsBlock" class="TableMain" style="width:100%;height:500px;text-align:center;">
								<ul id="ulReqDocs" style="width:210px;line-height:24px;padding:4px;font-family:Calibri;font-size:12pt;list-style-type:none;margin: auto auto;">
								</ul>
							</div>
						</td>
						<td style="width:20%;border:none;height:500px;vertical-align:top;padding:4px;text-align:center;">
							<div id="divGenHdrB">
								<label id="Label2" class="lblHighlightedBlue">Management Functions</label>
							</div>
							<div id="divMngtFunctionsBlock" class="TableMain" style="width:100%;height:500px;text-align:center;">
								<ul id="ulMngtFunctions" style="width:210px;line-height:24px;padding:4px;font-family:Calibri;font-size:12pt;list-style-type:none;margin: auto auto;">
								</ul>
							</div>
						</td>
						<td style="width:20%;border:none;height:500px;vertical-align:top;padding:4px;text-align:center;">
							<div id="divGenHdrC">
								<label id="lblGenHdrMM" class="lblHighlightedBlue">General Functions</label>
							</div>
							<div id="divGenFunctionsBlock" class="TableMain" style="width:100%;height:500px;text-align:center;">
								<ul id="ulGeneralFunctions" style="width:210px;line-height:24px;padding:4px;font-family:Calibri;font-size:12pt;list-style-type:none;margin: auto auto;">
								</ul>
							</div>
						</td>
						<td style="width:20%;border:none;height:500px;vertical-align:top;padding:4px;text-align:center;">
							<div id="divSalesHdr">
								<label id="Label1" class="lblHighlightedBlue">Sales</label>
							</div>
							<div id="divSalesFunctionsBlock" class="TableMain" style="width:100%;height:500px;text-align:center;">
								<ul id="ulSalesFunctions" style="width:210px;line-height:24px;padding:4px;font-family:Calibri;font-size:12pt;list-style-type:none;margin: auto auto;">
								</ul>
							</div>
						</td>
						<td style="width:20%;border:none;height:500px;vertical-align:top;padding:4px;text-align:center;">
							<div id="divFinanceHdr">
								<label id="lblFinanceHdrMM" class="lblHighlightedBlue">Finance Functions</label>
							</div>
							<div id="divFinanceFunctionsBlock" class="TableMain" style="width:100%;height:500px;text-align:center;">
								<ul id="ulFinanceMenu" style="width:210px;line-height:24px;padding:4px;font-family:Calibri;font-size:12pt;list-style-type:none;margin: auto auto;">
								</ul>
							</div>
						</td>
					</tr>
					</table>
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
