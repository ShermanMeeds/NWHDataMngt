<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForecastTool.aspx.cs" Inherits="DataMngt.prod.ForecastTool" EnableSessionState="false" %>

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

					.ForecastShiftBx {
						width:20px;
						text-align:center;
					}

					.ForecastAmtBx {
						text-align: right;
					}


					.FrozenCell
					{ 
									background-color:#EBEBEB;
									position: relative;
									cursor: default;
									left: expression(document.getElementById("divForecastMatrixMAIN").scrollLeft-2);
					}

					.CellWithComment{position:relative;}

					.CellComment
					{
									visibility: hidden;
									width: auto;
									position:absolute; 
									z-index:100;
									text-align: Left;
									opacity: 0.4;
									transition: opacity 2s;
									border-radius: 6px;
									background-color: #555;
									padding:3px;
									top:-30px; 
									left:0px;
					}   
					.CellWithComment:hover span.CellComment {visibility: visible;opacity: 1;}
	
	</style>

	<script type="text/javascript">
		var idSelected = '';
		var jbA = false;
		var jbPaginate = false;
		var jbViewOnly = false;
		var jiAR = 0;
		var jiActionStatusCode = '';
		var jiActionStatusID = 0;
		var jiActionStatusMsg = '';
		var jiApprovalID = 0;
		var jiByID = 0;
		var jiCurrentRow = 0;
		var jiDataGrid = 0;
		var jiMaxShift = 3;
		var jiUserID = 0;
		var jiPageID = 50;
		var jsBrowserType = '';
		var jsErrorMsg = '';
		var jsPageVersion = '';
		var jsPageVersDate = '';
		var jiApproverID = 0;
		var jdToday = new Date();
		var jsToday = '';
		var jsCurrentCtl = '';
		var jsCurrentTime = '';

		var MyReturn;

		var counter = 0;
		var DayNamesNV = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

		$(document).ready(function () {
			jsToday = getMyDateTimeStringDm(jdToday, 18);
			jsCurrentTime = getMyDateTimeStringDm(jdToday, 7);
			//alert(jdToday + '/' + jsToday + '/' + jsCurrentTime);
			updateClockNV();
			KeepSessionAlive();

			createDatePickerOnTextWc('txtTargetDateH', null, null, 0, 3, 'show', 11);

		});

		function KeepSessionAlive() {
			counter++;
			if (counter > 10000) { counter = 0; }
			var img = document.getElementById("imgSessionKeepAlive");
			img.src = "../ka.html?c=" + counter;
			setTimeout(KeepSessionAlive, 300000);
		}

		document.onkeydown = function (e) {
			switch (e.keyCode) {
				case 37: // left
					getNextField(0);
					break;
				case 38: // up
					getNextField(1);
					break;
				case 39: // right
					getNextField(2);
					break;
				case 40: // down
					getNextField(3);
					break;
			}
		};

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

		function getNextField(dir) {
			var a;
			var b;
			var fld = '';
			var newid = '';
			var nrows = 0;
			var wk = 0;
			var dy = 0;
			var shft = 0;
			if (jsCurrentCtl !== undefined && jsCurrentCtl !== null) {
				var id2 = jsCurrentCtl;
				if (jsCurrentCtl.length > 0) {
					//alert(jsCurrentCtl);
					// finish view -- 	lblWk1_1Amt1v	   lblWk6Amt1v // forecast view --- txtWk1_4Amt1	 txtWk6Amt1
					id2 = id2.replace('txt', '').replace('lbl', '');
					id2 = id2.replace('Wk', '').replace('v', '');
					id2 = id2.replace('Amt', ',');
					//alert(id2);
					if (id2.indexOf('_') > 0) {
						a = id2.split('_');
						wk = parseInt(a[0], 10);
						b = a[1].split(',');
						dy = parseInt(b[0], 10);
						shft = parseInt(b[1], 10);
					}
					else {
						a = id2.split(',');
						wk = parseInt(a[0], 10);
						dy = 0;
						shft = parseInt(a[1], 10);
					}

					//alert(dir + '/' + wk + '/' + dy + '/' + shft + '/' + jiDataGrid + '/' + id2);
					switch (dir) {
						case 0:	 // left
							//alert('left');
							if (dy == 0) {
								wk--;
								if (wk < 2) {
									dy = 7;
								}
							}
							else {
								dy--;
								if (dy < 1 && wk > 1) {
									wk--;
									dy = 7;
								}
								if (dy < 1) { dy = 1; }
							}
							break;
						case 1: // up
							//alert('up');
							if (shft > 1 || jiCurrentRow > 0) {
								if (jiCurrentRow === 0) {
									shft--;
								}
								else {
									if (shft > 1) {
										shft--;
									}
									else {
										jiCurrentRow--;
										shft = jiMaxShift;
									}
								}
							}
							if (jiCurrentRow < 0) { jiCurrentRow = 0; }
							break;
						case 2: // right
							//alert('right');
							if (wk > 2 && wk < 12) {
								wk++;
							}
							else {
								if (wk > 1 || dy > 1) {
									if (wk === 2 && dy === 7) {
										wk = 3;
										dy = 0;
									}
									else {
										dy++;
										if (dy > 7) {
											wk = 2;
											dy = 1;
										}
									}
								}
							}
							break;
						case 3: // down
							//alert('down');
							nrows = 0;
							switch (jiDataGrid) {
								case 3:
									nrows = parseInt(document.getElementById('MainContent_hfgvForecastDataNbrRows').value, 10);
									break;
								case 4:
									nrows = parseInt(document.getElementById('MainContent_hfgvFinishNbrRows').value, 10);
									break;
								default:
									break;
							}
							//alert('NRows: ' + nrows);
							if (jiCurrentRow < (nrows - 1) || shft < jiMaxShift) {
								if (jiCurrentRow === (nrows - 1)) {
									if (shft < jiMaxShift) { shft++; }
								}
								else {
									if (shft < jiMaxShift) {
										shft++;
									}
									else {
										jiCurrentRow++;
										shft = 1;
									}
								}
							}
							break;
						default:
							break;
					}
					if (shft > jiMaxShift) { shft = jiMaxShift; }
					newid = 'MainContent_gvForecastData_';
					//alert(dir + '/' + wk + '/' + dy + '/' + shft + '/' + jiDataGrid + '/' + id2 + '/' + newid);
					switch (jiDataGrid) {
						case 3:
							newid = newid + 'txtWk' + wk.toString();
							if (wk < 3) {
								newid = newid + '_' + dy.toString() + 'Amt' + shft.toString();
							}
							else {
								newid = newid + 'Amt' + shft.toString();
							}
							break;
						case 4:
							newid = newid + 'lblWk' + wk.toString();
							if (wk < 3) {
								newid = newid + '_' + dy.toString() + 'Amt' + shft.toString() + 'v';
							}
							else {
								newid = newid + 'Amt' + shft.toString() + 'v';
							}
							break;
						default:
							break;
					}
					newid = newid + '_' + jiCurrentRow.toString();
					//alert(newid);
					document.getElementById(newid).focus();
				}
			}
			return false; // fld;
		}

		function SetFocusField(fldnm) {
			if (fldnm !== undefined && fldnm !== null) {
				//alert(fldnm);
				var a = fldnm.split('_');
				if (fldnm.indexOf('gvForecastData') > -1) { jiDataGrid = 3; }
				if (fldnm.indexOf('gvFinishView') > -1) { jiDataGrid = 4; }
				if (a.length > 4) {
					jsCurrentCtl = a[2] + '_' + a[3];
					jiCurrentRow = parseInt(a[4], 10);
				}
				else {
					jsCurrentCtl = a[2];
					jiCurrentRow = parseInt(a[3], 10);
				}
			}
			//alert(jsCurrentCtl + '/' + jiCurrentRow+ '/' + fldnm + '/' + a.length);
			return false;
		}

		$(document).ready(function () {
			jiMaxShift = document.getElementById('hfMaxShiftID').value;
			PageInitiation();
		});

		function PageInitiation() {
			//alert(jiMaxShift);
		}

		function SetMaxShift(val) {
			//alert(val);
			jiMaxShift = parseInt(val, 10);
		}
	</script>

  <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />

</head>
<body>
	<img id="imgSessionKeepAlive" width="1" height="1" style="display:none;" src="../Images/clearpixel.gif" />
  <form id="Form1" runat="server">
  <asp:ScriptManager runat="server"></asp:ScriptManager>
	<asp:HiddenField ID="hfPageID" runat="server" Value="50" />

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

				<input type="hidden" id="hfControlIDm" value="" />
				<asp:HiddenField ID="hfControlID" runat="server" Value="" ViewStateMode="Enabled" />
				<asp:HiddenField ID="hfMaxShiftID" runat="server" Value="" ViewStateMode="Enabled" />

				<div id="divPAGEHEADER" style="width:99%;margin-left:10px;margin-bottom:10px;" runat="server">
					<div id="divHdrBtnBar" style="width:100%;height:28px;background-color:blanchedalmond;vertical-align:middle;text-align:center;" runat="server">
						<table style="padding:0px;border-spacing:0px;height:28px;">
						<tr>
							<td style="white-space:nowrap;vertical-align:middle;">
								&nbsp;<asp:Button ID="btnEditProductList" runat="server" OnClick="btnEditProductList_Click" Text="Edit Products" CssClass="button blue-gradient glossy" Width="100" />&nbsp;&nbsp;
								<asp:Button ID="btnEditMixList" runat="server" OnClick="btnEditMixList_Click" Text="Edit Mix List" CssClass="button blue-gradient glossy" Width="100" />&nbsp;&nbsp;
								<asp:Button ID="btnEditMixContents" runat="server" OnClick="btnEditMixContents_Click" Text="Edit Mix Contents" CssClass="button blue-gradient glossy" Width="126" />&nbsp;&nbsp;
								<asp:Button ID="btnEditForecast" runat="server" OnClick="btnEditForecast_Click" Text="Edit Forecast" CssClass="button blue-gradient glossy" Width="106" ForeColor="WhiteSmoke" />&nbsp;&nbsp;
							</td>
							<td style="white-space:nowrap;vertical-align:middle;">
								<label style="margin-left: 5px;">Location:</label>&nbsp;<span id="spnLocationListAdm" style="display:none;margin-left:10px;" runat="server">
									<asp:DropDownList ID="ddlLocationListF" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlLocationListF_SelectedIndexChanged" AppendDataBoundItems="true">
										<asp:ListItem Text="ALL" Value="0" />
									</asp:DropDownList>
									<label ID="lblLocationCode" runat="server" style="display:none;font-weight:bold;color:maroon;"></label>
								</span>
								<span id="spnLocationIdent" style="margin-left:10px;" runat="server"><asp:Label ID="lblLocationIdent" runat="server" Text="" Font-Bold="true" ForeColor="Blue"></asp:Label></span>
								&nbsp;&nbsp;&bull;&nbsp;&nbsp;
								<asp:Label ID="lblCurrentRegion" runat="server"></asp:Label>&nbsp;&nbsp;&bull;&nbsp;&nbsp;
							</td>
							<td style="white-space:nowrap;vertical-align:middle;display:none;">
								<div id="divSpeciesSelection" style="margin-left:10px;" runat="server">
									<label style="margin-left: 5px;">Species:</label>
									<asp:DropDownList ID="ddlSpeciesOverall" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSpeciesOverall_SelectedIndexChanged" AppendDataBoundItems="true">
										<asp:ListItem Text="ALL" Value="0"/>
									</asp:DropDownList>&nbsp;&nbsp;&bull;&nbsp;&nbsp;
								</div>
							</td>
							<td style="white-space:nowrap;vertical-align:middle;">
								<label style="margin-left: 5px;">Items per Page:</label>
								<asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged" style="margin-left: 10px;">
									<asp:ListItem Text="10" Value="10" />
									<asp:ListItem Text="20" Value="20" Selected="True" />
									<asp:ListItem Text="25" Value="25" />
									<asp:ListItem Text="30" Value="30" />
									<asp:ListItem Text="35" Value="35" />
									<asp:ListItem Text="40" Value="40" />
									<asp:ListItem Text="50" Value="50" />
									<asp:ListItem Text="75" Value="75" />
									<asp:ListItem Text="100" Value="100" />
									<asp:ListItem Text="250" Value="250" />
								</asp:DropDownList>&nbsp;&nbsp;&bull;&nbsp;&nbsp;
							</td>
							<td style="white-space:nowrap;vertical-align:middle;">
								<div id="divPresentationBtns" style="margin-right:10px;" runat="server">
									<asp:Button ID="btnFinishPresent" runat="server" OnClick="btnFinishPresent_Click" Text="Finish View" CssClass="button blue-gradient glossy" Width="94" />&nbsp;&nbsp;&nbsp;&nbsp;
									<asp:Button ID="btnForecastCodes" runat="server" OnClick="btnForecastCodes_Click" Text="Edit Codes and Lists" CssClass="button blue-gradient glossy" Width="140" />&nbsp;&nbsp;&nbsp;&nbsp;
									<asp:Button ID="btnGotoCalendar" runat="server" OnClick="btnGotoCalendar_Click" Text="Calendar" CssClass="button blue-gradient glossy" Width="82" />&nbsp;&nbsp;&nbsp;&nbsp;
									<asp:Button ID="btnCheckInLocation" runat="server" Text="Check in Everything" OnClick="btnCheckInLocation_Click" CssClass="button blue-gradient glossy" />&nbsp;&nbsp;&nbsp;&nbsp;
									<asp:Button ID="btnGotoConsolidation" runat="server" Text="Consol Tool" OnClick="btnGotoConsolidation_Click" CssClass="button blue-gradient glossy" />
								</div>
							</td>
						</tr>
						</table>

					</div>
				</div>
	
				<!------------------------------------------------------------------------------------------------------------>

				<div id="divPAGEMAINCONTENT" style="width:99%;margin-left:10px;margin-top:10px;" runat="server">
		
					<div id="divProductItemEdit" style="width:100%;display:none;background-color:antiquewhite;" runat="server">
						&nbsp;<asp:Label ID="lblEditProductHdr" Text="Edit Product Item:" runat="server" Font-Bold="true" Font-Size="12pt" ForeColor="blue"></asp:Label>
						<br />
						<div id="divProdItemEditBlock" style="width:100%;" runat="server">
							<table id="tblProdItemEdit" style="padding:2px;border-spacing:1px;">
							<tr>
								<td style="text-align:right;">
									PM&nbsp;ID:&nbsp;
								</td>
								<td>
									<asp:Label ID="lblProductManagedIDE" Text="0" runat="server" Font-Bold="true" ForeColor="DarkBlue"></asp:Label>
								</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td style="text-align:right;">
									 ProdType:&nbsp;
								</td>
								<td>
									<asp:DropDownList ID="ddlProdProdTypeListE" runat="server" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="ddlProdProdTypeListE_SelectedIndexChanged">
										<asp:ListItem Value="0" Text="Not Selected"></asp:ListItem>
										<asp:ListItem Value="HD" Text="HD" Selected="True"></asp:ListItem>
									</asp:DropDownList>
								</td>
								<td>&nbsp;</td>
								<td style="text-align:right;">
									 Product:&nbsp;
								</td>
								<td>
									<asp:DropDownList ID="ddlProdProductListE" runat="server" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="ddlProdProductListE_SelectedIndexChanged">
										<asp:ListItem Value="0" Text="Not Selected"></asp:ListItem>
									</asp:DropDownList>&nbsp;
									<span id="spnProdIDdisplay" style="width:100px;white-space:nowrap;display:inline-block;"><asp:Label ID="lblProdIDE" runat="server" Font-Bold="true" ForeColor="blue" ></asp:Label></span>&nbsp;
									All<asp:CheckBox ID="chkShowAllProducts" runat="server" Checked="false" />&nbsp;
								</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td style="text-align:right;">Descriptors:&nbsp;</td>
								<td colspan="7" style="text-align:center;">
									<table id="tblNewProdDesc" style="margin:auto auto;">
 									<tr>
										<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
											<asp:Label ID="lblPDesc1Hdr" runat="server" Text="1"></asp:Label>
										</th>
										<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
											<asp:Label ID="lblPDesc2Hdr" runat="server" Text="2"></asp:Label>
										</th>
										<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
											<asp:Label ID="lblPDesc3Hdr" runat="server" Text="3"></asp:Label>
										</th>
										<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
											<asp:Label ID="lblPDesc4Hdr" runat="server" Text="4"></asp:Label>
										</th>
										<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
											<asp:Label ID="lblPDesc5Hdr" runat="server" Text="5"></asp:Label>
										</th>
										<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
											<asp:Label ID="lblPDesc6Hdr" runat="server" Text="6"></asp:Label>
										</th>
										<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
											<asp:Label ID="lblPDesc7Hdr" runat="server" Text="7"></asp:Label>
										</th>
										<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
											<asp:Label ID="lblPDesc8Hdr" runat="server" Text=""></asp:Label>
										</th>
										<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
											<asp:Label ID="lblPDesc9Hdr" runat="server" Text=""></asp:Label>
										</th>
										<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
											<asp:Label ID="lblPDesc10Hdr" runat="server" Text=""></asp:Label>
										</th>
									</tr>
									<tr>
										<td class="MedTableStd">
											<asp:TextBox ID="txtPDescVal1" runat="server" Text="" ReadOnly="true" Width="80" CssClass="InputTextWNoBorder" BackColor="Transparent"></asp:TextBox>
										</td>
										<td class="MedTableStd">
											<asp:TextBox ID="txtPDescVal2" runat="server" Text="" ReadOnly="true" Width="80" CssClass="InputTextWNoBorder" BackColor="Transparent"></asp:TextBox>
										</td>
										<td class="MedTableStd">
											<asp:TextBox ID="txtPDescVal3" runat="server" Text="" ReadOnly="true" Width="80" CssClass="InputTextWNoBorder" BackColor="Transparent"></asp:TextBox>
										</td>
										<td class="MedTableStd">
											<asp:TextBox ID="txtPDescVal4" runat="server" Text="" ReadOnly="true" Width="80" CssClass="InputTextWNoBorder" BackColor="Transparent"></asp:TextBox>
										</td>
										<td class="MedTableStd">
											<asp:TextBox ID="txtPDescVal5" runat="server" Text="" ReadOnly="true" Width="80" CssClass="InputTextWNoBorder" BackColor="Transparent"></asp:TextBox>
										</td>
										<td class="MedTableStd">
											<asp:TextBox ID="txtPDescVal6" runat="server" Text="" ReadOnly="true" Width="80" CssClass="InputTextWNoBorder" BackColor="Transparent"></asp:TextBox>
										</td>
										<td class="MedTableStd">
											<asp:TextBox ID="txtPDescVal7" runat="server" Text="" ReadOnly="true" Width="80" CssClass="InputTextWNoBorder" BackColor="Transparent"></asp:TextBox>
										</td>
										<td class="MedTableStd">
											<asp:TextBox ID="txtPDescVal8" runat="server" Text="" ReadOnly="true" Width="80" CssClass="InputTextWNoBorder" BackColor="Transparent"></asp:TextBox>
										</td>
										<td class="MedTableStd">
											<asp:TextBox ID="txtPDescVal9" runat="server" Text="" ReadOnly="true" Width="80" CssClass="InputTextWNoBorder" BackColor="Transparent"></asp:TextBox>
										</td>
										<td class="MedTableStd">
											<asp:TextBox ID="txtPDescVal10" runat="server" Text="" ReadOnly="true" Width="80" CssClass="InputTextWNoBorder" BackColor="Transparent"></asp:TextBox>
										</td>
									</tr>
									</table>
								</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td style="text-align:right;">
									Target Attributes:&nbsp;
								</td>
								<td colspan="7">
									<table style="padding:0;border-spacing:0px;">
									<tr>
										<th class="TableHdrCell">
											Length
										</th>
										<th class="TableHdrCell">
											Color
										</th>
										<th class="TableHdrCell">
											Sort
										</th>
										<th class="TableHdrCell">
											Milling
										</th>
										<th class="TableHdrCell">
											NoPrint
										</th>
									</tr>
									<tr>
										<td class="StdTableCell">
											<asp:DropDownList ID="ddlLengthT" runat="server" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="UpdatePMIDData">
												<asp:ListItem Value="0" Text="Unset"></asp:ListItem>
											</asp:DropDownList>
										</td>
										<td class="StdTableCell">
											<asp:DropDownList ID="ddlColorT" runat="server" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="UpdatePMIDData">
												<asp:ListItem Value="0" Text="Unset"></asp:ListItem>
											</asp:DropDownList>
										</td>
										<td class="StdTableCell">
											<asp:DropDownList ID="ddlSortT" runat="server" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="UpdatePMIDData">
												<asp:ListItem Value="0" Text="Unset"></asp:ListItem>
											</asp:DropDownList>
										</td>
										<td class="StdTableCell">
											<asp:DropDownList ID="ddlMillingT" runat="server" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="UpdatePMIDData">
												<asp:ListItem Value="0" Text="Unset"></asp:ListItem>
											</asp:DropDownList>
										</td>
										<td class="StdTableCell">
											<asp:DropDownList ID="ddlNoPrintT" runat="server" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="UpdatePMIDData">
												<asp:ListItem Value="0" Text="Unset"></asp:ListItem>
											</asp:DropDownList>
										</td>
									</tr>
									</table>
								</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td style="text-align:right;">
									Description:&nbsp;
								</td>
								<td colspan="4">
									<asp:TextBox ID="txtProdDescriptionE" Width="340" runat="server"></asp:TextBox>
									<asp:HiddenField ID="hfProdManagedIDE" runat="server" Value="" />
								</td>
								<td>&nbsp;</td>
								<td style="text-align:right;">
									 Active:&nbsp;
								</td>
								<td>
									<asp:CheckBox ID="chkProdActiveE" runat="server" Checked="true" />
								</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td colspan="8" style="text-align:center;">
									<asp:Button ID="btnSaveProductData" runat="server" Text="Save" CssClass="button blue-gradient glossy" OnClick="btnSaveProductData_Click" />&nbsp;&nbsp;&nbsp;
									<asp:Button ID="btnCloseProdDataEdit" runat="server" Text="Close Edit Area" CssClass="button blue-gradient glossy" OnClick="btnCloseProdDataEdit_Click"	/>
								</td>
								<td>&nbsp;</td>
							</tr>
							</table>
						</div>
					</div>

					<div id="divMixItemEdit" style="width:100%;display:none;background-color:antiquewhite;" runat="server">
						&nbsp;<asp:Label ID="lblEditMixItemHdr" Text="Edit Mix Item:" runat="server" Font-Bold="true" Font-Size="12pt" ForeColor="blue"></asp:Label>
						<br />
						<div id="divMixItemEditBlock" style="width:100%;" runat="server">
							<table id="tblMixItemEdit" style="padding:2px;border-spacing:1px;">
							<tr>
									<td style="text-align:right;">
										ID:&nbsp;
									</td>
									<td>
										<asp:Label ID="lblMixItemIDE" runat="server">0</asp:Label>
									</td>
									<td>&nbsp;&nbsp;&nbsp;</td>
									<td style="text-align:right;">
										Active:&nbsp;
									</td>
									<td>
									 <asp:DropDownList ID="ddlMixItemActiveE" runat="server">
										 <asp:ListItem Value="1" Selected="True" Text="Active"></asp:ListItem>
										 <asp:ListItem Value="0" Text="Inactive"></asp:ListItem>
									 </asp:DropDownList>
									</td>
									<td>&nbsp;</td>
									<td style="text-align:right;">
										Name&nbsp;Suffix:&nbsp;
									</td>
									<td>
									 <asp:TextBox ID="txtMixItemNameE" runat="server" Width="220" ></asp:TextBox>
									 <asp:TextBox ID="txtMixItemCodeE" runat="server" Width="100" ></asp:TextBox>
									</td>
									<td>&nbsp;&nbsp;&nbsp;</td>
									<td>
									</td>
									<td>
									</td>
							</tr>
							<tr>
									<td style="text-align:right;">
										Thickness:&nbsp;
									</td>
									<td>
									 <asp:DropDownList ID="ddlThicknessForMixItem" runat="server" AppendDataBoundItems="true">
										 <asp:ListItem Value="0" Text="ALL"></asp:ListItem>
									 </asp:DropDownList>
									</td>
									<td>&nbsp;</td>
									<td style="text-align:right;">
									 Species:&nbsp;
									</td>
									<td>
									 <asp:DropDownList ID="ddlSpeciesForMixItem" runat="server" AppendDataBoundItems="true">
										 <asp:ListItem Value="0" Text="ALL"></asp:ListItem>
									 </asp:DropDownList>
									</td>
									<td>&nbsp;&nbsp;&nbsp;</td>
									<td>
										Grade:&nbsp;
									</td>
									<td>
									 <asp:DropDownList ID="ddlGradeForMixItem" runat="server" AppendDataBoundItems="true">
										 <asp:ListItem Value="0" Text="ALL"></asp:ListItem>
									 </asp:DropDownList>
									</td>
									<td style="text-align:right;">
										Length:&nbsp;
									</td>
									<td>
									 <asp:DropDownList ID="ddlLengthForMixItem" runat="server" AppendDataBoundItems="true">
										 <asp:ListItem Value="0" Text="ALL"></asp:ListItem>
									 </asp:DropDownList>
									</td>
									<td>&nbsp;&nbsp;&nbsp;</td>
							</tr>
							<tr>
									<td>
									 Content&nbsp;Definition:&nbsp;
									</td>
									<td colspan="4">
									 <asp:TextBox ID="txtMixItemContentE" runat="server" Width="300" ></asp:TextBox>
									</td>
									<td>&nbsp;&nbsp;&nbsp;</td>
									<td>
									 Comments:&nbsp;
									</td>
									<td colspan="4">
									 <asp:TextBox ID="txtMixItemCommentsE" runat="server" Width="400" ></asp:TextBox>
									</td>
							</tr>
							<tr>
									<td colspan="8" style="text-align:center;">
										<asp:Button ID="btnSaveMixItemData" runat="server" Text="Save" CssClass="button blue-gradient glossy" OnClick="btnSaveMixItemData_Click" />&nbsp;&nbsp;
										<asp:Button ID="btnCloseMixItemEdit" runat="server" Text="Close Edit Area" CssClass="button blue-gradient glossy" OnClick="btnCloseMixItemEdit_Click"	/>
									</td>
							</tr>
							</table>
						</div>
					</div>

 					<div id="divMixProductEdit" style="width:100%;display:none;background-color:antiquewhite;" runat="server">
						<div id="divMixProductEditBlock" style="width:100%;text-align:center;" runat="server">
							<asp:Label ID="lblMixProductEditHdr" runat="server" cssclass="MyHeaderLabel" Text="Edit Product for this Mix"></asp:Label><br />
							<table id="tblMixProductEdit" style="padding:2px;border-spacing:1px;margin:auto auto;">
							<tr>
								<td>&nbsp;</td>
								<td style="text-align:right;">
									Product:&nbsp;
								</td>
								<td style="text-align:left;">
									<asp:DropDownList ID="ddlProdItemE" runat="server" AppendDataBoundItems="true">
										<asp:ListItem Value="0" Text="Not Selected"></asp:ListItem>
									</asp:DropDownList>
								</td>
								<td>&nbsp;</td>
								<td style="text-align:right;">
									 Percent:&nbsp;
								</td>
								<td style="text-align:left;">
									<asp:TextBox ID="txtProdItemPercent" Width="90" runat="server" Text=""></asp:TextBox>
								</td>
								<td>&nbsp;</td>
								<td style="text-align:right;">
									 Length:&nbsp;
								</td>
								<td style="text-align:left;">
									<asp:DropDownList ID="ddlMixProdLength" runat="server" AppendDataBoundItems="true" >
										<asp:ListItem Value="0" Selected="True" Text="None Set"></asp:ListItem>
									</asp:DropDownList>
								</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td colspan="10" style="text-align:center;">
									<asp:Button ID="btnSaveMixProdData" runat="server" Text="Save" CssClass="button blue-gradient glossy" OnClick="btnSaveMixProdData_Click" />&nbsp;&nbsp;
									<asp:Button ID="btnCloseMixProdArea" runat="server" Text="Close Edit Area" CssClass="button blue-gradient glossy" OnClick="btnCloseMixProdArea_Click" />
								</td>
							</tr>
							</table>
						</div>
					</div>

					<div id="divProductBulkCopy" style="width:100%;display:none;" runat="server">
						Item to change:
						<table style="padding:0;border-spacing:0px;">
									<tr>
										<th class="TableHdrCell">
											Length
										</th>
										<th class="TableHdrCell">
											Color
										</th>
										<th class="TableHdrCell">
											Sort
										</th>
										<th class="TableHdrCell">
											Milling
										</th>
										<th class="TableHdrCell">
											NoPrint
										</th>
									</tr>
									<tr>
										<td class="StdTableCell">
											<asp:DropDownList ID="ddlLengthBC" runat="server" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="UpdatePMIDData">
												<asp:ListItem Value="0" Text="Unset"></asp:ListItem>
											</asp:DropDownList>
										</td>
										<td class="StdTableCell">
											<asp:DropDownList ID="ddlColorBC" runat="server" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="UpdatePMIDData">
												<asp:ListItem Value="0" Text="Unset"></asp:ListItem>
											</asp:DropDownList>
										</td>
										<td class="StdTableCell">
											<asp:DropDownList ID="ddlSortBC" runat="server" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="UpdatePMIDData">
												<asp:ListItem Value="0" Text="Unset"></asp:ListItem>
											</asp:DropDownList>
										</td>
										<td class="StdTableCell">
											<asp:DropDownList ID="ddlMillingBC" runat="server" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="UpdatePMIDData">
												<asp:ListItem Value="0" Text="Unset"></asp:ListItem>
											</asp:DropDownList>
										</td>
										<td class="StdTableCell">
											<asp:DropDownList ID="ddlNoPrintBC" runat="server" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="UpdatePMIDData">
												<asp:ListItem Value="0" Text="Unset"></asp:ListItem>
											</asp:DropDownList>
										</td>
									</tr>
									<tr>
										<td colspan="5" style="text-align:center;">
											<asp:Button ID="btnUpdateCheckedItems" runat="server" Text="Copy Checked Items" CssClass="button blue-gradient glossy" OnClick="btnUpdateCheckedItems_Click" />
										</td>
									</tr>
									</table>

					</div>

					<div id="divEditStatusMsg" style="width:100%;display:none;" runat="server">
						<asp:Label ID="lblEditStatusMsg" runat="server" Font-Bold="true" Font-Size="12pt" ForeColor="Maroon" Text=""></asp:Label>
					</div>

					<!------------------------------------------------------------------------------------------------------------>

					<div id="divProductList" style="width:100%;display:none;" runat="server">
						<div id="divProductListHdr" style="width:100%;" runat="server">
							<table id="tblProdListHdr" style="width:100%;padding:1px;border-spacing:0px;">
							<tr>
								<td style="text-align:right;width:33%;">
									&nbsp;
								</td>
								<td style="text-align:center;width:34%;">
									<asp:Label runat="server" ID="lblProductListHdr" Text="Product List" CssClass="SpecHeaderTitle" Width="300" ></asp:Label>&nbsp;&nbsp;&nbsp;
								</td>
								<td style="width:33%;text-align:center;">
									<asp:Button runat="server" ID="btnAddNewProduct" Text="Add New Product" CssClass="button blue-gradient glossy" OnClick="btnAddNewProduct_Click" />&nbsp;&nbsp;
									<asp:Button runat="server" ID="btnCheckAllThisPage" Text="Check All" CssClass="button blue-gradient glossy" OnClick="btnCheckAllThisPage_Click" Width="100" />&nbsp;&nbsp;
									<asp:Button runat="server" ID="btnUncheckAllThisPage" Text="Uncheck All" CssClass="button blue-gradient glossy" OnClick="btnUncheckAllThisPage_Click" Width="100" />&nbsp;&nbsp;
									<asp:Button runat="server" ID="btnCopyChecked" Text="Copy Checked" CssClass="button blue-gradient glossy" OnClick="btnCopyChecked_Click" />&nbsp;&nbsp;
									<asp:Button runat="server" ID="btnDeleteChecked" Text="Delete Checked" CssClass="button blue-gradient glossy" OnClick="btnDeleteChecked_Click" />&nbsp;&nbsp;
								</td>
							</tr>
							</table>
						</div>

						<div id="divProductListCheckout" style="display:none;height:26px;width:100%;background-color:lightgoldenrodyellow;color:cornflowerblue;text-align:center;vertical-align:middle;margin-top:6px;margin-bottom:6px;" runat="server">
							Checked Out to <asp:Label ID="lblProdListCheckoutPerson" runat="server"></asp:Label> on <asp:Label ID="lblProdListCheckoutTime" runat="server"></asp:Label>
						</div>

						<div id="divProductDataGrid" style="width:100%;text-align:center;height:684px;overflow:auto;" runat="server">
							<center>
							<asp:GridView ID="gvProducts" runat="server" AllowPaging="true" AllowSorting="true" OnRowCommand="gvProducts_RowCommand" DataKeyNames="ProductManagedID" OnRowDeleting="gvProducts_RowDeleting" OnRowDeleted="gvProducts_RowDeleted"
								OnPageIndexChanged="gvProducts_PageIndexChanged" OnPageIndexChanging="gvProducts_PageIndexChanging" OnRowDataBound="gvProducts_RowDataBound" OnDataBound="gvProducts_DataBound"
								AlternatingRowStyle-BackColor="WhiteSmoke" AutoGenerateColumns="false" CellPadding="1" PageSize="20" EnableViewState="true">
								<HeaderStyle CssClass="ColHeaderStd"  />
							<Columns>
								<asp:TemplateField>
									<ItemTemplate>
										<asp:CheckBox ID="chkProductSelected" runat="server" Checked="false" />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:BoundField DataField="ProductManagedID" HeaderText="MstrID" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="44" />
								<asp:BoundField DataField="ProdType" HeaderText="P/T" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="34" ItemStyle-HorizontalAlign="Center" />
								<asp:BoundField DataField="ProductCode" HeaderText="Prod Code" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="60" ItemStyle-HorizontalAlign="Center" />
								<asp:BoundField DataField="sManagedItemIdent" HeaderText="Description" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="370" />
								<asp:BoundField DataField="Region" HeaderText="Region" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="70" />
								<asp:BoundField DataField="Thickness" HeaderText="Thickness" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="70" />
								<asp:BoundField DataField="Specie" HeaderText="Species" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="70" />
								<asp:BoundField DataField="Grade" HeaderText="Grade" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="70" />
								<asp:BoundField DataField="Length" HeaderText="Length" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="70" />
								<asp:BoundField DataField="Color" HeaderText="Color" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="70" />
								<asp:BoundField DataField="Sort" HeaderText="Sort" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="70" />
								<asp:BoundField DataField="Milling" HeaderText="Milling" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="70" />
								<asp:BoundField DataField="NoPrint" HeaderText="NoPrint" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="70" />
								<asp:BoundField DataField="sManaged" HeaderText="Mgd" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="40" ItemStyle-HorizontalAlign="Center" />
								<asp:BoundField DataField="sActive" HeaderText="Active" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="40" ItemStyle-HorizontalAlign="Center" />
								<asp:TemplateField HeaderText="Action">
									<ItemTemplate>
										<asp:Button ID="btnDeleteItem" runat="server" CssClass="button blue-gradient glossy" CommandArgument='<%# Container.DataItemIndex %>' CommandName="Delete" Text="Del" />
										<asp:HiddenField ID="hfProductLinkID" runat="server" value='<%# Eval("ProductToLocID") %>' />
										<asp:HiddenField ID="hfProductMngdID" runat="server" value='<%# Eval("ProductManagedID") %>' />
									</ItemTemplate>
								</asp:TemplateField>
							</Columns>
							</asp:GridView>
							</center>
						</div>
					</div>

					<div id="divMixList" style="width:100%;display:none;" runat="server">
						<div id="divMixListHdr" style="width:100%;" runat="server">
							<table id="tblMixListHdr" style="width:100%;padding:1px;border-spacing:0px;">
							<tr>
								<td style="text-align:right;width:33%;">
									&nbsp;
								</td>
								<td style="text-align:center;width:34%;">
									<asp:Label runat="server" ID="lblMixListHdr" Text="Mix List" CssClass="SpecHeaderTitle" Width="300" ></asp:Label>&nbsp;&nbsp;&nbsp;
								</td>
								<td style="text-align:center;width:33%;">
									<asp:Button runat="server" ID="btnAddNewMix" Text="Add New Mix" CssClass="button blue-gradient glossy" OnClick="btnAddNewMix_Click2" />&nbsp;&nbsp;
								</td>
							</tr>
							</table>
						</div>

						<div id="divMixListCheckout" style="display:none;height:26px;width:100%;background-color:lightgoldenrodyellow;color:cornflowerblue;text-align:center;vertical-align:middle;margin-top:6px;margin-bottom:6px;" runat="server">
							Checked Out to <asp:Label ID="lblMixListCheckoutPerson" runat="server"></asp:Label> on <asp:Label ID="lblMixListCHeckoutTime" runat="server"></asp:Label>
						</div>

						<div id="divMixGridBlock" style="width:100%;text-align:center;margin-left:auto; margin-right:auto;height:684px;overflow:auto;" runat="server">
							<center>
							<asp:GridView ID="gvMixList" runat="server" AllowPaging="true" OnPageIndexChanging="gvMixList_PageIndexChanging" AllowSorting="true" AlternatingRowStyle-BackColor="WhiteSmoke" AutoGenerateColumns="false" 
									AutoGenerateEditButton="true" OnPageIndexChanged="gvMixList_PageIndexChanged" DataKeyNames="ForecastMixID" CellPadding="1" OnRowCommand="gvMixList_RowCommand" PageSize="20" OnRowEditing="gvMixList_RowEditing" 
									OnRowUpdated="gvMixList_RowUpdated" OnRowUpdating="gvMixList_RowUpdating" OnRowCancelingEdit="gvMixList_RowCancelingEdit"
									OnRowDataBound="gvMixList_RowDataBound" OnSorted="gvMixList_Sorted" OnSorting="gvMixList_Sorting" OnRowDeleting="gvMixList_RowDeleting" OnRowDeleted="gvMixList_RowDeleted"
									OnDataBinding="gvMixList_DataBinding" OnDataBound="gvMixList_DataBound" EnableViewstate="true">
								<RowStyle HorizontalAlign="Center" />
								<HeaderStyle Font-Bold="true" CssClass="ColHeaderStd" />
								<Columns>
									<asp:BoundField DataField="MixFullName" HeaderText="Full Name" ItemStyle-Width="210" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
									<asp:TemplateField HeaderText="Thickness" >
										<ItemTemplate>
											<asp:Label ID="lblMixThickness" runat="server" Text='<%# Eval("ThickDesc") %>'></asp:Label>
										</ItemTemplate>
										<EditItemTemplate>
											<asp:DropDownList ID="ddlGVMixThickness" runat="server" AppendDataBoundItems="true">
												<asp:ListItem Value="0" Text="ANY"></asp:ListItem>
											</asp:DropDownList>
										</EditItemTemplate>
										<ItemStyle Width="100" HorizontalAlign="Left" CssClass="StdTableCell" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Species" >
										<ItemTemplate>
											<asp:Label ID="lblMixSpecies" runat="server" Text='<%# Eval("SpeciesDesc") %>'></asp:Label>
										</ItemTemplate>
										<EditItemTemplate>
											<asp:DropDownList ID="ddlGVMixSpecies" runat="server" AppendDataBoundItems="true">
												<asp:ListItem Value="0" Text="ANY"></asp:ListItem>
											</asp:DropDownList>
										</EditItemTemplate>
										<ItemStyle Width="150" HorizontalAlign="Left" CssClass="StdTableCell" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Grade" >
										<ItemTemplate>
											<asp:Label ID="lblMixGrade" runat="server" Text='<%# Eval("GradeDesc") %>'></asp:Label>
										</ItemTemplate>
										<EditItemTemplate>
											<asp:DropDownList ID="ddlGVMixGrade" runat="server" AppendDataBoundItems="true">
												<asp:ListItem Value="0" Text="ANY"></asp:ListItem>
											</asp:DropDownList>
										</EditItemTemplate>
										<ItemStyle Width="150" HorizontalAlign="Left" CssClass="StdTableCell" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Length" >
										<ItemTemplate>
											<asp:Label ID="lblMixLength" runat="server" Text='<%# Eval("LengthDesc") %>'></asp:Label>
										</ItemTemplate>
										<EditItemTemplate>
											<asp:DropDownList ID="ddlGVMixLength" runat="server" AppendDataBoundItems="true">
												<asp:ListItem Value="0" Text="ANY"></asp:ListItem>
											</asp:DropDownList>
										</EditItemTemplate>
										<ItemStyle Width="150" HorizontalAlign="Left" CssClass="StdTableCell" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Name Suffix" >
										<ItemTemplate>
											<asp:Label ID="lblMixName" runat="server" Text='<%# Eval("MixName") %>'></asp:Label>
										</ItemTemplate>
										<EditItemTemplate>
												<asp:TextBox runat="server" ID="txtMixName" Text='<%# Eval("MixName") %>' Width="140"/>
										</EditItemTemplate>
										<ItemStyle Width="182" HorizontalAlign="Left" CssClass="StdTableCell" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Contents">
										<ItemTemplate>
											<asp:Label ID="lblMixContents" runat="server" Text='<%# Eval("ContentDefinition") %>'></asp:Label>
										</ItemTemplate>
										<EditItemTemplate>
												<asp:TextBox runat="server" ID="txtMixContents" Text='<%# Eval("ContentDefinition") %>' Width="200"/>
										</EditItemTemplate>
										<ItemStyle Width="200" HorizontalAlign="Left" CssClass="StdTableCell" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Comments">
										<ItemTemplate>
											<asp:Label ID="lblMixComments" runat="server" Text='<%# Eval("Comments") %>'></asp:Label>
										</ItemTemplate>
										<EditItemTemplate>
												<asp:TextBox runat="server" ID="txtMixComments" Text='<%#Eval("Comments") %>'  Width="200" />
										</EditItemTemplate>
										<ItemStyle Width="200" HorizontalAlign="Left" CssClass="StdTableCell" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Active">
										<ItemTemplate>
											<asp:Label ID="lblMixActive" runat="server" Text='<%# Eval("sActive") %>'></asp:Label>
										</ItemTemplate>
										<EditItemTemplate>
											<asp:CheckBox runat="server" ID="chkMixActive"  AutoPostBack="true" Width="60" CommandArgument='<%# Container.DataItemIndex %>'/>
										</EditItemTemplate>
										<ItemStyle HorizontalAlign="Center" Width="50" CssClass="StdTableCell" />
									</asp:TemplateField>
									<asp:BoundField DataField="sUpdatedDate" HeaderText="Last Updated" ReadOnly="true"  ItemStyle-CssClass="StdTableCell" ItemStyle-Width="90" />
									<asp:TemplateField HeaderText="Action">
										<ItemTemplate>
											<asp:Button id="btnDelMix" runat="server" CommandArgument='<%# Container.DataItemIndex %>' CommandName="Delete" Text="Del" CssClass="button blue-gradient glossy" />
											<asp:HiddenField ID="hfMixItemID" runat="server" Value='<%# Eval("ForecastMixID") %>' />
											<asp:HiddenField ID="hfMixItemLoc" runat="server" Value='<%# Eval("LocCode") %>' />
										</ItemTemplate>
									</asp:TemplateField>
								</Columns>
							</asp:GridView>
							</center>
						</div>

						<div id="divMixListNotes" style="width:100%;font-size:9pt;" runat="server">
							<strong>NOTE:</strong> Changing code will update pointers in existing data. 
						</div>

					</div>

					<div id="divMixContents" style="width:100%;display:none;" runat="server">
						<div id="divMixContentsHdr" style="width:100%;" runat="server">
							<table id="tblMixContentsHdr" style="width:100%;padding:1px;border-spacing:0px;">
							<tr>
								<td style="width:10%;text-align:right;font-weight:bold;vertical-align:middle;">
									Mix:&nbsp;
								</td>
								<td style="width:30%;text-align:left;">
									<asp:DropDownList ID="ddlMixListProdContents"	runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlMixListProdContents_SelectedIndexChanged">
										<asp:ListItem Value="0" Text="Unselected"></asp:ListItem>
									</asp:DropDownList>&nbsp;&nbsp;
								</td>
								<td style="width:20%;">
									<asp:Label ID="lblMixContentsHdr" runat="server" CssClass="SpecHeaderTitle" Width="300" Text="Mix Product Contents"></asp:Label>&nbsp;
								</td>
								<td style="width:40%;text-align:center;">
									<asp:Button ID="btnAddNewMixProduct" runat="server" Text="Add New Product" CssClass="button blue-gradient glossy" OnClick="btnAddNewMixProduct_Click" />&nbsp;&nbsp;&nbsp;&nbsp;
									<asp:Button runat="server" ID="btnCheckAllMixProds" Text="Check All" CssClass="button blue-gradient glossy" OnClick="btnCheckAllMixProds_Click" Width="100" />&nbsp;
									<asp:Button runat="server" ID="btnUncheckAllMixProds" Text="Uncheck All" CssClass="button blue-gradient glossy" OnClick="btnUncheckAllMixProds_Click" Width="100" />&nbsp;&nbsp;&nbsp;
									<asp:Button ID="btnCopyMixContents"	runat="server" Text="Copy Mix Contents" CssClass="button blue-gradient glossy" OnClick="btnCopyMixContents_Click" />&nbsp;
									<asp:Button ID="btnPasteMixContents"	runat="server" Text="Paste Mix Contents" CssClass="button blue-gradient glossy" OnClick="btnPasteMixContents_Click" />&nbsp;
								</td>
							</tr>
							</table>
						</div>
			
						<div id="divMixContentsCheckout" style="display:none;height:26px;width:100%;background-color:lightgoldenrodyellow;color:cornflowerblue;text-align:center;vertical-align:middle;margin-top:6px;margin-bottom:6px;" runat="server">
							Checked Out to <asp:Label ID="lblMixContentsCheckoutPerson" runat="server"></asp:Label> on <asp:Label ID="lblMixContentsCheckoutTime" runat="server"></asp:Label>
						</div>

						<div id="divMixContentsBlock" style="width:100%;margin-bottom:4px;height:684px;overflow:auto;" runat="server">
							<center>
							<asp:GridView ID="gvMixContents" runat="server" AllowPaging="true" AllowSorting="true" AlternatingRowStyle-BackColor="WhiteSmoke" AutoGenerateColumns="false" CellPadding="1" OnDataBinding="gvMixContents_DataBinding" PageSize="20" 
								OnPageIndexChanged="gvMixContents_PageIndexChanged" OnPageIndexChanging="gvMixContents_PageIndexChanging" OnRowDataBound="gvMixContents_RowDataBound" OnDataBound="gvMixContents_DataBound" 
								OnSorted="gvMixContents_Sorted" OnSorting="gvMixContents_Sorting" OnRowCommand="gvMixContents_RowCommand">
								<HeaderStyle CssClass="ColHeaderStd" />
							<Columns>
								<asp:TemplateField>
									<ItemTemplate>
										<asp:CheckBox ID="chkProductSelected2" runat="server" Checked="false" />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:BoundField DataField="ProductManagedID" HeaderText="Mgd ID" ItemStyle-Width="40" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="StdTableCell" />
								<asp:BoundField DataField="ProdType" HeaderText="P/T" ItemStyle-Width="30" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="StdTableCell" />
								<asp:BoundField DataField="ProductCode" HeaderText="Prod Code" ItemStyle-Width="60" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="StdTableCell" />
								<asp:BoundField DataField="ProdDesc" HeaderText="Description" ItemStyle-Width="300" ItemStyle-CssClass="StdTableCell" />
								<asp:BoundField DataField="ILength" HeaderText="Length" ItemStyle-Width="70" ItemStyle-CssClass="StdTableCell" />
								<asp:BoundField DataField="Color" HeaderText="Color" ItemStyle-Width="70" ItemStyle-CssClass="StdTableCell" />
								<asp:BoundField DataField="Sort" HeaderText="Sort" ItemStyle-Width="70" ItemStyle-CssClass="StdTableCell" />
								<asp:BoundField DataField="Milling" HeaderText="Milling" ItemStyle-Width="70" ItemStyle-CssClass="StdTableCell" />
								<asp:BoundField DataField="NoPrint" HeaderText="NoPrint" ItemStyle-Width="70" ItemStyle-CssClass="StdTableCell" />
								<asp:BoundField DataField="sYieldPct" HeaderText="Percent" ItemStyle-Width="54" ItemStyle-HorizontalAlign="Right" ItemStyle-CssClass="StdTableCell" />
								<asp:TemplateField HeaderText="Action">
									<ItemTemplate>
										<asp:Button ID="btnEditContentItem" runat="server" CssClass="button blue-gradient glossy"	 CommandArgument='<%# Container.DataItemIndex %>' CommandName="Edit1" Text="Edit" />
										<asp:Button ID="btnDelContentItem" runat="server" CssClass="button blue-gradient glossy"	 CommandArgument='<%# Container.DataItemIndex %>' CommandName="Del1" Text="Del" />
										<asp:HiddenField ID="hfProdManagedID" runat="server" Value='<%# Eval("ProductManagedID") %>' />
										<asp:HiddenField ID="hfMixProdLinkID" runat="server" Value='<%# Eval("MixProductID") %>' />
										<asp:HiddenField ID="hfProdLength" runat="server" Value='<%# Eval("ILength") %>' />
									</ItemTemplate>
									<ItemStyle CssClass="StdTableCell" />
								</asp:TemplateField>
							</Columns>
							</asp:GridView>
							</center>
						</div>

						<div id="divMixSummary" style="width:100%;margin-bottom:4px;text-align:center;" runat="server">
							<table style="margin:auto auto;">
							<tr>
								<td style="width:10%;">

								</td>
								<td style="width:80%;text-align:center;">
									Total&nbsp;Items:&nbsp;<span id="spnTotalItemsLabel" style="display:inline-block;width:60px;margin-right:10px;"><asp:Label ID="lblNbrItems" runat="server" Font-Bold="true" ForeColor="blue"></asp:Label></span>
									Total&nbsp;Percentage:&nbsp;<span id="spnTotalItemPctLabel" style="display:inline-block;width:60px;margin-right:10px;"><asp:Label ID="lblTotalPct" runat="server" Font-Bold="true" ForeColor="blue"></asp:Label></span>
								</td>
								<td style="width:10%;">

								</td>
							</tr>
							</table>
						</div>

						<div id="divMixProdComments" style="width:100%;font-size:9pt;" runat="server">
							<strong>NOTE:</strong> Changes to mix contents will be immediately applied to future forecast data. 
						</div>

					</div>

					<div id="divForecastMatrix" style="width:100%;display:none;" runat="server">
						<div id="divForecastMatrixHdr" style="width:100%;" runat="server">
							<table id="tblForecastMatrixHdr" style="width:100%;background-color:antiquewhite;padding:0px;border-spacing:0px;">
							<tr>
								<td style="font-weight:bold;vertical-align:top;text-align:right;font-weight:bold;">
									View:&nbsp;
								</td>
								<td style="text-align:left;vertical-align:top;">
									<asp:DropDownList ID="ddlForecastMatrixView" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlForecastMatrixView_SelectedIndexChanged">
										<asp:ListItem Value="0" Text="Both" Selected="True"></asp:ListItem>
										<asp:ListItem Value="1" Text="Tactical"></asp:ListItem>
										<asp:ListItem Value="2" Text="Strategic"></asp:ListItem>
										<asp:ListItem Value="3" Text="Week 1"></asp:ListItem>
										<asp:ListItem Value="4" Text="Week 2"></asp:ListItem>
									</asp:DropDownList>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:center;" colspan="3">
									&nbsp;
								</td>
								<td colspan="3">&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;">
									Include Current Week:&nbsp<asp:CheckBox ID="chkEditCurrentWeek" runat="server" Checked="false" AutoPostBack="true" OnCheckedChanged="chkEditCurrentWeek_CheckedChanged1" />
								</td>
								<td colspan="8" style="text-align:right;">
									<span style="font-style:italic;">Week&nbsp;1&nbsp;MBF:</span>&nbsp;<asp:Label ID="lblWk1Totalp" CssClass="StdBlueLabel" Text="0" runat="server"></asp:Label>&nbsp;&bull;&nbsp;
									<span style="font-style:italic;">Week&nbsp;2&nbsp;MBF:</span>&nbsp;<asp:Label ID="lblWk2Totalp" CssClass="StdBlueLabel" Text="0" runat="server"></asp:Label>&nbsp;&bull;&nbsp;
									<span style="font-style:italic;">Strategic&nbsp;MBF:</span>&nbsp;<asp:Label ID="lblStrategicTotalp" CssClass="StdBlueLabel" Text="0" runat="server"></asp:Label>&nbsp;&bull;&nbsp;
									<span style="font-style:italic;">Total&nbsp;MBF:</span>&nbsp;<asp:Label ID="lblTotalMBFp" CssClass="StdBlueLabel" Text="0" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;
								</td>
							</tr>
							<tr>
								<td style="vertical-align:top;font-weight:bold;" rowspan="2">
									Filter&nbsp;By:&nbsp;
								</td>
								<td style="text-align:left;vertical-align:top;font-weight:bold;">
									Mix
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;font-weight:bold;">
									Species
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;font-weight:bold;">
									Thickness
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;font-weight:bold;">
									Grade
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;font-weight:bold;">
									Color
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;font-weight:bold;">
									Sort
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;font-weight:bold;">
									NoPrint
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;font-weight:bold;">
									Description
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="vertical-align:top;">
									Action
								</td>
							</tr>
							<tr>
								<td style="text-align:left;vertical-align:top;">
									<asp:ListBox ID="lbxCMixListF" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false">
										<asp:ListItem Value="0" Text="ALL" Selected="True"></asp:ListItem>
									</asp:ListBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;">
									<asp:ListBox ID="lbxSpeciesF" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false">
										<asp:ListItem Value="0" Text="ALL" Selected="True"></asp:ListItem>
									</asp:ListBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;">
									<asp:ListBox ID="lbxThicknessF" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false">
										<asp:ListItem Value="0" Text="ALL" Selected="True"></asp:ListItem>
									</asp:ListBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;">
									<asp:ListBox ID="lbxGradeF" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false">
										<asp:ListItem value="0" Text="ALL" Selected="True"></asp:ListItem>
									</asp:ListBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;">
									<asp:ListBox ID="lbxColorF" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false">
										<asp:ListItem value="0" Text="ALL" Selected="True"></asp:ListItem>
									</asp:ListBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;">
									<asp:ListBox ID="lbxSortF" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false">
										<asp:ListItem value="0" Text="ALL" Selected="True"></asp:ListItem>
									</asp:ListBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;">
									<asp:ListBox ID="lbxNoPrintF" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false">
										<asp:ListItem value="0" Text="ALL" Selected="True"></asp:ListItem>
									</asp:ListBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;">
									<asp:TextBox ID="txtProdDescF" runat="server" Width="150"></asp:TextBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="vertical-align:top;">
									<asp:Button ID="btnRefreshMatrixData" runat="server" Text="Refresh Data" OnClick="btnRefreshMatrixData_Click" CssClass="button blue-gradient glossy" />
								</td>
							</tr>
							<tr style="border-bottom:none;border-left:none;border-right:none;background-color:white;">
								<td style="text-align:left;vertical-align:bottom;background-color:white;border-bottom:none;border-left:none;border-right:none;" colspan="3">
									<asp:Button ID="btnUpdateForecastGridData" runat="server" CssClass="button blue-gradient glossy" Text="Save Forecast Data" OnClick="btnUpdateForecastGridData_Click" />&nbsp;
									<span id="spnWeekNbr" style="color:cadetblue;font-weight:bold;font-size:12pt;">First&nbsp;Week:&nbsp;<asp:Label ID="lblWeekNbr" runat="server" Text="00"></asp:Label></span>
								</td>
								<td colspan="12" style="text-align:center;background-color:white;vertical-align:bottom;border-bottom:none;border-left:none;border-right:none;">
									<asp:Label ID="lblForecastMatrix" runat="server" Font-Bold="true" CssClass="SpecHeaderTitle" Width="300" Text="Forecast"></asp:Label>
								</td>
								<td style="text-align:right;vertical-align:bottom;background-color:white;border-bottom:none;border-left:none;border-right:none;" colspan="3">
									<asp:Label ID="lblStatusForecastMatrix" runat="server" Text="" Font-Bold="true"></asp:Label>&nbsp;&nbsp;
								</td>
							</tr>
							</table>
						</div>

						<div id="divForecastCheckout" style="display:none;height:26px;width:100%;background-color:lightgoldenrodyellow;color:cornflowerblue;text-align:center;vertical-align:middle;margin-top:6px;margin-bottom:6px;" runat="server">
							Checked Out to <asp:Label ID="lblForecastCheckoutPerson" runat="server"></asp:Label> on <asp:Label ID="lblForecastCheckoutTime" runat="server"></asp:Label>
						</div>

						<div id="divForecastMatrixMAIN" style="width:100%;height:650px;overflow:auto;" runat="server">
							<asp:GridView ID="gvForecastData" runat="server" AllowPaging="true" AllowSorting="true" OnSelectedIndexChanged="gvForecastData_SelectedIndexChanged" OnSelectedIndexChanging="gvForecastData_SelectedIndexChanging"
								OnRowCommand="gvForecastData_RowCommand" OnRowDataBound="gvForecastData_RowDataBound" OnPageIndexChanged="gvForecastData_PageIndexChanged" OnPageIndexChanging="gvForecastData_PageIndexChanging"
								OnDataBound="gvForecastData_DataBound" AlternatingRowStyle-BackColor="WhiteSmoke" AutoGenerateColumns="false" CellPadding="1" PageSize="20">
								<HeaderStyle CssClass="FrozenHeader TableHdrCell" />
								<Columns>
									<asp:BoundField DataField="MixFullName" HeaderText="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mix&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" ItemStyle-VerticalAlign="Top" ItemStyle-Font-Bold="true" ItemStyle-BackColor="#EEEEFF" ItemStyle-Width="120" ControlStyle-CssClass="FrozenCell GridViewIdentField" ItemStyle-BorderStyle="Solid" ItemStyle-BorderColor="gray">
									</asp:BoundField>
									<asp:BoundField DataField="OutTurnPercent" HeaderText="&nbsp;Yield&nbsp;%&nbsp;" ItemStyle-VerticalAlign="Top" ItemStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Center" ItemStyle-BackColor="#EEEEFF" ControlStyle-CssClass="GridViewIdentField" ItemStyle-BorderStyle="Solid" ItemStyle-BorderColor="gray" ControlStyle-BorderWidth="1">
									</asp:BoundField>
									<asp:TemplateField HeaderText="Wk1-Day1">
										<ItemTemplate>
											<div id="divForecastGrid0101" class="ListBoxPaddingTB" style="width:100px;" runat="server">
												<table id="tblForecastGridc2" class="TableSubEditStd" >
												<tr id="trForecastc2s1" runat="server" title="Week 1-Day 1-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td onfocus="javascript:SetFocusField('txtWk1_1Amt1|<%# Container.DataItemIndex %>');return false;">
														<asp:TextBox ID="txtWk1_1Amt1" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk1_1Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk1_1Amt1" runat="server" Value='<%# Eval("Wk1_1Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc2s2" runat="server" title="Week 1-Day 1-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td onfocus="javascript:SetFocusField('txtWk1_1Amt2|<%# Container.DataItemIndex %>');return false;">
														<asp:TextBox ID="txtWk1_1Amt2" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk1_1Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk1_1Amt2" runat="server" Value='<%# Eval("Wk1_1Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc2s3" runat="server" title="Week 1-Day 1-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td onfocus="javascript:SetFocusField('txtWk1_1Amt3|<%# Container.DataItemIndex %>');return false;">
														<asp:TextBox ID="txtWk1_1Amt3" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk1_1Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk1_1Amt3" runat="server" Value='<%# Eval("Wk1_1Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk1-Day2">
										<ItemTemplate>
											<div id="divForecastGrid0102" class="ListBoxPaddingTB" style="width:100px;" runat="server">
												<table id="tblForecastGridc3" class="TableSubEditStd">
												<tr id="trForecastc3s1" runat="server" title="Week 1-Day 2-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWk1_2Amt1" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk1_2Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk1_2Amt1" runat="server" Value='<%# Eval("Wk1_2Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc3s2" runat="server" title="Week 1-Day 2-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWk1_2Amt2" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk1_2Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk1_2Amt2" runat="server" Value='<%# Eval("Wk1_2Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc3s3" runat="server" title="Week 1-Day 2-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWk1_2Amt3" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk1_2Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk1_2Amt3" runat="server" Value='<%# Eval("Wk1_2Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk1-Day3">
										<ItemTemplate>
											<div id="divForecastGrid0103" class="ListBoxPaddingTB" style="width:100px;" runat="server">
												<table id="tblForecastGridc4" class="TableSubEditStd">
												<tr id="trForecastc4s1" runat="server" title="Week 1-Day 3-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWk1_3Amt1" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk1_3Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk1_3Amt1" runat="server" Value='<%# Eval("Wk1_3Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc4s2" runat="server" title="Week 1-Day 3-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWk1_3Amt2" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk1_3Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk1_3Amt2" runat="server" Value='<%# Eval("Wk1_3Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc4s3" runat="server" title="Week 1-Day 3-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWk1_3Amt3" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk1_3Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk1_3Amt3" runat="server" Value='<%# Eval("Wk1_3Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk1-Day4">
										<ItemTemplate>
											<div id="divForecastGrid0104" class="ListBoxPaddingTB" style="width:100px;" runat="server">
												<table id="tblForecastGridc5" class="TableSubEditStd">
												<tr id="trForecastc5s1" runat="server" title="Week 1-Day 4-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWk1_4Amt1" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk1_4Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk1_4Amt1" runat="server" Value='<%# Eval("Wk1_4Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc5s2" runat="server" title="Week 1-Day 4-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWk1_4Amt2" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk1_4Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk1_4Amt2" runat="server" Value='<%# Eval("Wk1_4Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc5s3" runat="server" title="Week 1-Day 4-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWk1_4Amt3" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk1_4Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk1_4Amt3" runat="server" Value='<%# Eval("Wk1_4Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk1-Day5">
										<ItemTemplate>
											<div id="divForecastGrid0105" class="ListBoxPaddingTB" style="width:100px;" runat="server">
												<table id="tblForecastGridc6" class="TableSubEditStd">
												<tr id="trForecastc6s1" runat="server" title="Week 1-Day 5-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWk1_5Amt1" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk1_5Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk1_5Amt1" runat="server" Value='<%# Eval("Wk1_5Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc6s2" runat="server" title="Week 1-Day 5-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWk1_5Amt2" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk1_5Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk1_5Amt2" runat="server" Value='<%# Eval("Wk1_5Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc6s3" runat="server" title="Week 1-Day 5-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWk1_5Amt3" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk1_5Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk1_5Amt3" runat="server" Value='<%# Eval("Wk1_5Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk1-Day6">
										<ItemTemplate>
											<div id="divForecastGrid0106" class="ListBoxPaddingTB" style="width:100px;background-color:antiquewhite;" runat="server">
												<table id="tblForecastGridc7" class="TableSubEditStd">
												<tr id="trForecastc7s1" runat="server" title="Week 1-Day 6-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWk1_6Amt1" runat="server" CssClass="InputTextWeekend" Text='<%# Eval("Wk1_6Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk1_6Amt1" runat="server" Value='<%# Eval("Wk1_6Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc7s2" runat="server" title="Week 1-Day 6-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWk1_6Amt2" runat="server" CssClass="InputTextWeekend" Text='<%# Eval("Wk1_6Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk1_6Amt2" runat="server" Value='<%# Eval("Wk1_6Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc7s3" runat="server" title="Week 1-Day 6-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWk1_6Amt3" runat="server" CssClass="InputTextWeekend" Text='<%# Eval("Wk1_6Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk1_6Amt3" runat="server" Value='<%# Eval("Wk1_6Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="AntiqueWhite" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk1-Day7">
										<ItemTemplate>
											<div id="divForecastGrid0107" class="ListBoxPaddingTB" style="width:100px;background-color:antiquewhite;" runat="server">
												<table id="tblForecastGridc8" class="TableSubEditStd">
												<tr id="trForecastc8s1" runat="server" title="Week 1-Day 7-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWk1_7Amt1" runat="server" CssClass="InputTextWeekend" Text='<%# Eval("Wk1_7Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk1_7Amt1" runat="server" Value='<%# Eval("Wk1_7Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc8s2" runat="server" title="Week 1-Day 7-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWk1_7Amt2" runat="server" CssClass="InputTextWeekend" Text='<%# Eval("Wk1_7Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk1_7Amt2" runat="server" Value='<%# Eval("Wk1_7Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc8s3" runat="server" title="Week 1-Day 7-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWk1_7Amt3" runat="server" CssClass="InputTextWeekend" Text='<%# Eval("Wk1_7Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk1_7Amt3" runat="server" Value='<%# Eval("Wk1_7Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="AntiqueWhite" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk2-Day1">
										<ItemTemplate>
											<div id="divForecastGrid0201" class="ListBoxPaddingTB" style="width:100px;" runat="server">
												<table id="tblForecastGridc9" class="TableSubEditStd">
												<tr id="trForecastc9s1" runat="server" title="Week 2-Day 1-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWk2_1Amt1" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk2_1Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk2_1Amt1" runat="server" Value='<%# Eval("Wk2_1Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc9s2" runat="server" title="Week 2-Day 1-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWk2_1Amt2" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk2_1Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk2_1Amt2" runat="server" Value='<%# Eval("Wk2_1Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc9s3" runat="server" title="Week 2-Day 1-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWk2_1Amt3" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk2_1Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk2_1Amt3" runat="server" Value='<%# Eval("Wk2_1Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk2-Day2">
										<ItemTemplate>
											<div id="divForecastGrid0202" class="ListBoxPaddingTB" style="width:100px;" runat="server">
												<table id="tblForecastGridc10" class="TableSubEditStd">
												<tr id="trForecastc10s1" runat="server" title="Week 2-Day 2-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWk2_2Amt1" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk2_2Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk2_2Amt1" runat="server" Value='<%# Eval("Wk2_2Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc10s2" runat="server" title="Week 2-Day 2-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWk2_2Amt2" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk2_2Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk2_2Amt2" runat="server" Value='<%# Eval("Wk2_2Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc10s3" runat="server" title="Week 2-Day 2-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWk2_2Amt3" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk2_2Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk2_2Amt3" runat="server" Value='<%# Eval("Wk2_2Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk2-Day3">
										<ItemTemplate>
											<div id="divForecastGrid0203" class="ListBoxPaddingTB" style="width:100px;" runat="server">
												<table id="tblForecastGridc11" class="TableSubEditStd">
												<tr id="trForecastc11s1" runat="server" title="Week 2-Day 3-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWk2_3Amt1" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk2_3Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk2_3Amt1" runat="server" Value='<%# Eval("Wk2_3Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc11s2" runat="server" title="Week 2-Day 3-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWk2_3Amt2" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk2_3Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk2_3Amt2" runat="server" Value='<%# Eval("Wk2_3Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc11s3" runat="server" title="Week 2-Day 3-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWk2_3Amt3" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk2_3Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk2_3Amt3" runat="server" Value='<%# Eval("Wk2_3Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk2-Day4">
										<ItemTemplate>
											<div id="divForecastGrid0204" class="ListBoxPaddingTB" style="width:100px;" runat="server">
												<table id="tblForecastGridc12" class="TableSubEditStd">
												<tr id="trForecastc12s1" runat="server" title="Week 2-Day 4-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWk2_4Amt1" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk2_4Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk2_4Amt1" runat="server" Value='<%# Eval("Wk2_4Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc12s2" runat="server" title="Week 2-Day 4-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWk2_4Amt2" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk2_4Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk2_4Amt2" runat="server" Value='<%# Eval("Wk2_4Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc12s3" runat="server" title="Week 2-Day 4-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWk2_4Amt3" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk2_4Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk2_4Amt3" runat="server" Value='<%# Eval("Wk2_4Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk2-Day5">
										<ItemTemplate>
											<div id="divForecastGrid0205" class="ListBoxPaddingTB" style="width:100px;" runat="server">
												<table id="tblForecastGridc13" class="TableSubEditStd">
												<tr id="trForecastc13s1" runat="server" title="Week 2-Day 5-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWk2_5Amt1" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk2_5Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk2_5Amt1" runat="server" Value='<%# Eval("Wk2_5Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc13s2" runat="server" title="Week 2-Day 5-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWk2_5Amt2" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk2_5Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk2_5Amt2" runat="server" Value='<%# Eval("Wk2_5Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc13s3" runat="server" title="Week 2-Day 5-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWk2_5Amt3" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk2_5Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk2_5Amt3" runat="server" Value='<%# Eval("Wk2_5Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk2-Day6">
										<ItemTemplate>
											<div id="divForecastGrid0206" class="ListBoxPaddingTB" style="width:100px;background-color:antiquewhite;" runat="server">
												<table id="tblForecastGridc14" class="TableSubEditStd">
												<tr id="trForecastc14s1" runat="server" title="Week 2-Day 6-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWk2_6Amt1" runat="server" CssClass="InputTextWeekend" Text='<%# Eval("Wk2_6Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk2_6Amt1" runat="server" Value='<%# Eval("Wk2_6Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc14s2" runat="server" title="Week 2-Day 6-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWk2_6Amt2" runat="server" CssClass="InputTextWeekend" Text='<%# Eval("Wk2_6Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk2_6Amt2" runat="server" Value='<%# Eval("Wk2_6Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc14s3" runat="server" title="Week 2-Day 6-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWk2_6Amt3" runat="server" CssClass="InputTextWeekend" Text='<%# Eval("Wk2_6Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk2_6Amt3" runat="server" Value='<%# Eval("Wk2_6Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="AntiqueWhite" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk2-Day7">
										<ItemTemplate>
											<div id="divForecastGrid0207" class="ListBoxPaddingTB" style="width:100px;background-color:antiquewhite;" runat="server">
												<table id="tblForecastGridc15" class="TableSubEditStd">
												<tr id="trForecastc15s1" runat="server" title="Week 2-Day 7-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWk2_7Amt1" runat="server" CssClass="InputTextWeekend" Text='<%# Eval("Wk2_7Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk2_7Amt1" runat="server" Value='<%# Eval("Wk2_7Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc15s2" runat="server" title="Week 2-Day 7-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWk2_7Amt2" runat="server" CssClass="InputTextWeekend" Text='<%# Eval("Wk2_7Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk2_7Amt2" runat="server" Value='<%# Eval("Wk2_7Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc15s3" runat="server" title="Week 2-Day 7-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWk2_7Amt3" runat="server" CssClass="InputTextWeekend" Text='<%# Eval("Wk2_7Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk2_7Amt3" runat="server" Value='<%# Eval("Wk2_7Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="AntiqueWhite" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Week3">
										<ItemTemplate>
											<div id="divForecastGrid03" class="ListBoxPaddingTB" style="width:100px;background-color:#FFDD00;" runat="server">
												<table id="tblForecastGridc16" class="TableSubEditStd">
												<tr id="trForecastc16s1" runat="server" title="Week 3-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWk3Amt1" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk3Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk3Amt1" runat="server" Value='<%# Eval("Wk3Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc16s2" runat="server" title="Week 3-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWk3Amt2" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk3Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk3Amt2" runat="server" Value='<%# Eval("Wk3Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc16s3" runat="server" title="Week 3-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWk3Amt3" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk3Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk3Amt3" runat="server" Value='<%# Eval("Wk3Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="#FFDD00" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Week4">
										<ItemTemplate>
											<div id="divForecastGrid04" class="ListBoxPaddingTB" style="width:100px;background-color:#FFDD00;" runat="server">
												<table id="tblForecastGridc17" class="TableSubEditStd">
												<tr id="trForecastc17s1" runat="server" title="Week 4-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWk4Amt1" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk4Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk4Amt1" runat="server" Value='<%# Eval("Wk4Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc17s2" runat="server" title="Week 4-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWk4Amt2" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk4Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk4Amt2" runat="server" Value='<%# Eval("Wk4Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc17s3" runat="server" title="Week 4-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWk4Amt3" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk4Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk4Amt3" runat="server" Value='<%# Eval("Wk4Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="#FFDD00" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Week5">
										<ItemTemplate>
											<div id="divForecastGrid05" class="ListBoxPaddingTB" style="width:100px;background-color:#FFDD00;" runat="server">
												<table id="tblForecastGridc18" class="TableSubEditStd">
												<tr id="trForecastc18s1" runat="server" title="Week 5-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWk5Amt1" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk5Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk5Amt1" runat="server" Value='<%# Eval("Wk5Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc18s2" runat="server" title="Week 5-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWk5Amt2" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk5Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk5Amt2" runat="server" Value='<%# Eval("Wk5Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc18s3" runat="server" title="Week 5-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWk5Amt3" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk5Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk5Amt3" runat="server" Value='<%# Eval("Wk5Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="#FFDD00" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Week6">
										<ItemTemplate>
											<div id="divForecastGrid06" class="ListBoxPaddingTB" style="width:100px;background-color:#FFDD00;" runat="server">
												<table id="tblForecastGridc19" class="TableSubEditStd">
												<tr id="trForecastc19s1" runat="server" title="Week 6-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWk6Amt1" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk6Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk6Amt1" runat="server" Value='<%# Eval("Wk6Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc19s2" runat="server" title="Week 6-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWk6Amt2" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk6Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk6Amt2" runat="server" Value='<%# Eval("Wk6Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc19s3" runat="server" title="Week 6-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWk6Amt3" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk6Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk6Amt3" runat="server" Value='<%# Eval("Wk6Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="#FFDD00" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Week7">
										<ItemTemplate>
											<div id="divForecastGrid07" class="ListBoxPaddingTB" style="width:100px;background-color:#FFDD00;" runat="server">
												<table id="tblForecastGridc20" class="TableSubEditStd">
												<tr id="trForecastc20s1" runat="server" title="Week 7-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWk7Amt1" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk7Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk7Amt1" runat="server" Value='<%# Eval("Wk7Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc20s2" runat="server" title="Week 7-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWk7Amt2" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk7Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk7Amt2" runat="server" Value='<%# Eval("Wk7Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc20s3" runat="server" title="Week 7-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWk7Amt3" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk7Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk7Amt3" runat="server" Value='<%# Eval("Wk7Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="#FFDD00" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Week8">
										<ItemTemplate>
											<div id="divForecastGrid08" class="ListBoxPaddingTB" style="width:100px;background-color:#FFDD00;" runat="server">
												<table id="tblForecastGridc21" class="TableSubEditStd">
												<tr id="trForecastc21s1" runat="server" title="Week 8-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWk8Amt1" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk8Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk8Amt1" runat="server" Value='<%# Eval("Wk8Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc21s2" runat="server" title="Week 8-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWk8Amt2" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk8Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk8Amt2" runat="server" Value='<%# Eval("Wk8Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc21s3" runat="server" title="Week 8-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWk8Amt3" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk8Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk8Amt3" runat="server" Value='<%# Eval("Wk8Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="#FFDD00" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Week9">
										<ItemTemplate>
											<div id="divForecastGrid09" class="ListBoxPaddingTB" style="width:100px;background-color:#FFDD00;" runat="server">
												<table id="tblForecastGridc22" class="TableSubEditStd">
												<tr id="trForecastc22s1" runat="server" title="Week 9-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWk9Amt1" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk9Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk9Amt1" runat="server" Value='<%# Eval("Wk9Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc22s2" runat="server" title="Week 9-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWk9Amt2" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk9Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk9Amt2" runat="server" Value='<%# Eval("Wk9Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc22s3" runat="server" title="Week 9-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWk9Amt3" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk9Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk9Amt3" runat="server" Value='<%# Eval("Wk9Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="#FFDD00" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Week10">
										<ItemTemplate>
											<div id="divForecastGrid10" class="ListBoxPaddingTB" style="width:100px;background-color:#FFDD00;" runat="server">
												<table id="tblForecastGridc23" class="TableSubEditStd">
												<tr id="trForecastc23s1" runat="server" title="Week 10-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWk10Amt1" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk10Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk10Amt1" runat="server" Value='<%# Eval("Wk10Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc23s2" runat="server" title="Week 10-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWk10Amt2" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk10Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk10Amt2" runat="server" Value='<%# Eval("Wk10Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc23s3" runat="server" title="Week 10-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWk10Amt3" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk10Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk10Amt3" runat="server" Value='<%# Eval("Wk10Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="#FFDD00" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Week11">
										<ItemTemplate>
											<div id="divForecastGrid11" class="ListBoxPaddingTB" style="width:100px;background-color:#FFDD00;" runat="server">
												<table id="tblForecastGridc24" class="TableSubEditStd">
												<tr id="trForecastc24s1" runat="server" title="Week 11-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWk11Amt1" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk11Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk11Amt1" runat="server" Value='<%# Eval("Wk11Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc24s2" runat="server" title="Week 11-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWk11Amt2" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk11Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk11Amt2" runat="server" Value='<%# Eval("Wk11Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc24s3" runat="server" title="Week 11-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWk11Amt3" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk11Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk11Amt3" runat="server" Value='<%# Eval("Wk11Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="#FFDD00" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Week12">
										<ItemTemplate>
											<div id="divForecastGrid12" class="ListBoxPaddingTB" style="width:100px;background-color:#FFDD00;" runat="server">
												<table id="tblForecastGridc25" class="TableSubEditStd">
												<tr id="trForecastc25s1" runat="server" title="Week 12-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWk12Amt1" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk12Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk12Amt1" runat="server" Value='<%# Eval("Wk12Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc25s2" runat="server" title="Week 12-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWk12Amt2" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk12Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk12Amt2" runat="server" Value='<%# Eval("Wk12Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc25s3" runat="server" title="Week 12-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWk12Amt3" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk12Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk12Amt3" runat="server" Value='<%# Eval("Wk12Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="#FFDD00" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Week13">
										<ItemTemplate>
											<div id="divForecastGrid13" class="ListBoxPaddingTB" style="width:100px;background-color:#FFDD00;" runat="server">
												<table id="tblForecastGridc26" class="TableSubEditStd">
												<tr id="trForecastc26s1" runat="server" title="Week 13-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWk13Amt1" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk13Shft1") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk13Amt1" runat="server" Value='<%# Eval("Wk13Shft1") %>' />
													</td>
												</tr>
												<tr id="trForecastc26s2" runat="server" title="Week 13-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWk13Amt2" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk13Shft2") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk13Amt2" runat="server" Value='<%# Eval("Wk13Shft2") %>' />
													</td>
												</tr>
												<tr id="trForecastc26s3" runat="server" title="Week 13-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWk13Amt3" runat="server" CssClass="StdInputTextWk" Text='<%# Eval("Wk13Shft3") %>' OnTextChanged="ForecastFieldValueChanged" onfocus="javascript:SetFocusField(this.id);return false;"></asp:TextBox>
														<asp:HiddenField ID="hfWk13Amt3" runat="server" Value='<%# Eval("Wk13Shft3") %>' />
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="#FFDD00" />
									</asp:TemplateField>
									<asp:BoundField DataField="MixFullName" HeaderText="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mix&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" ItemStyle-VerticalAlign="Top" ItemStyle-Font-Bold="true" ItemStyle-BackColor="#EEEEFF" ItemStyle-Width="120" ControlStyle-CssClass="FrozenCell GridViewIdentField" ItemStyle-BorderStyle="Solid" ItemStyle-BorderColor="gray">
									</asp:BoundField>
									<asp:TemplateField HeaderText="Total">
										<ItemTemplate>
											<div id="divForecastGridTotals" class="ListBoxPaddingTB" style="width:100px;background-color:#FFAA00;" runat="server">
												<table id="tblForecastGridc27" class="TableSubEditStd">
												<tr id="trForecastc27s1" runat="server" title="Totals-Shift 1">
													<td style="width:20px;text-align:center;">
														1:
													</td>
													<td>
														<asp:TextBox ID="txtWkTotalAmt1" runat="server" CssClass="StdInputTextWk" ReadOnly="true"></asp:TextBox>
													</td>
												</tr>
												<tr id="trForecastc27s2" runat="server" title="Totals-Shift 2">
													<td style="width:20px;text-align:center;">
														2:
													</td>
													<td>
														<asp:TextBox ID="txtWkTotalAmt2" runat="server" CssClass="StdInputTextWk" ReadOnly="true"></asp:TextBox>
													</td>
												</tr>
												<tr id="trForecastc27s3" runat="server" title="Totals-Shift 3">
													<td style="width:20px;text-align:center;">
														3:
													</td>
													<td>
														<asp:TextBox ID="txtWkTotalAmt3" runat="server" CssClass="StdInputTextWk" ReadOnly="true"></asp:TextBox>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="#FFAA00" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Action">
										<ItemTemplate>
											<div id="divGVForecastDataAction" runat="server" style="text-align:center;">
												<asp:Button ID="btnRemoveMixFromForecast" runat="server" CssClass="button blue-gradient glossy"	 CommandArgument='<%# Container.DataItemIndex %>' CommandName="Del" Text="Empty Mix Data" /> 
											</div>
											<asp:HiddenField ID="hfTotalYieldPct" runat="server" Value='<%# Eval("TotalYieldPct") %>' />
											<asp:HiddenField ID="hfMixFullName" runat="server" Value='<%# Eval("MixFullName") %>' />
											<asp:HiddenField ID="hfMixID" value='<%# Eval("ForecastMixID") %>' runat="server" />
										</ItemTemplate>
										<ItemStyle VerticalAlign="Top" />
									</asp:TemplateField>
								</Columns>
							</asp:GridView>
							<asp:HiddenField ID="hfgvForecastDataNbrRows" runat="server" Value="0" />
						</div>
					</div>

					<div id="divFinishView" style="width:100%;display:none;" runat="server">
						<div id="divFinishViewHdr" style="width:100%;" runat="server">
							<table id="tblForecastProdViewHdr" style="width:100%;background-color:antiquewhite;padding:0px;border-spacing:0px;">
							<tr>
								<td style="font-weight:bold;vertical-align:top;text-align:left;font-weight:bold;">
									&nbsp;View:&nbsp;
								</td>
								<td style="text-align:left;vertical-align:top;">
									<asp:DropDownList ID="ddlForecastProdView" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlForecastProdView_SelectedIndexChanged"	>
										<asp:ListItem Value="0" Text="Both" Selected="True"></asp:ListItem>
										<asp:ListItem Value="1" Text="Tactical"></asp:ListItem>
										<asp:ListItem Value="2" Text="Strategic"></asp:ListItem>
										<asp:ListItem Value="3" Text="Week 1"></asp:ListItem>
										<asp:ListItem Value="4" Text="Week 2"></asp:ListItem>
									</asp:DropDownList>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:right;vertical-align:top;">
									<asp:Label ID="lblCurrentWeekF" Text="Current Week:" runat="server"></asp:Label>&nbsp;
								</td>
								<td style="text-align:left;vertical-align:top;" colspan="4">
									<span id="spnCurrentWeekChk" runat="server">
										<asp:CheckBox ID="chkShowCurrentWeekPV" runat="server" Checked="true" AutoPostBack="true" OnCheckedChanged="chkShowCurrentWeekPV_CheckedChanged" />
									</span>
									&nbsp;&nbsp;&nbsp;&nbsp;History:&nbsp;<asp:CheckBox ID="chkShowHistory" runat="server" Checked="false" AutoPostBack="true" OnCheckedChanged="chkShowHistory_CheckedChanged" />
									<span id="spnTargetDateH" runat="server" style="display:none;">
										Target&nbsp;Date:<asp:TextBox ID="txtTargetDateH" runat="server" Text="" Width="86"></asp:TextBox>
									</span>
									&nbsp;&nbsp;&nbsp;&nbsp;
								</td>
								<td style="text-align:right;vertical-align:top;" colspan="2">
									No Empty Products:&nbsp
								</td>
								<td style="text-align:left;vertical-align:top;" colspan="2">
									<asp:CheckBox ID="chkNoEmptyProducts" runat="server" Checked="true" AutoPostBack="true" OnCheckedChanged="chkNoEmptyProducts_CheckedChanged" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td colspan="7" style="text-align:right;">
									<span style="font-style:italic;">Week&nbsp;1&nbsp;MBF:</span>&nbsp;<asp:Label ID="lblWeek1Totalf" CssClass="StdBlueLabel" Text="0" runat="server"></asp:Label>&nbsp;&bull;&nbsp;
									<span style="font-style:italic;">Week&nbsp;2&nbsp;MBF:</span>&nbsp;<asp:Label ID="lblWeek2Totalf" CssClass="StdBlueLabel" Text="0" runat="server"></asp:Label>&nbsp;&bull;&nbsp;
									<span style="font-style:italic;">Strategic&nbsp;MBF:</span>&nbsp;<asp:Label ID="lblStrategicTotalf" CssClass="StdBlueLabel" Text="0" runat="server"></asp:Label>&nbsp;&bull;&nbsp;
									<span style="font-style:italic;">Total&nbsp;MBF:</span>&nbsp;<asp:Label ID="lblTotalAmtf" CssClass="StdBlueLabel" Text="0" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;
								</td>
							</tr>
							<tr>
								<td style="vertical-align:top;font-weight:bold;" rowspan="2">
									&nbsp;Filter&nbsp;By:&nbsp;
								</td>
								<td style="text-align:left;vertical-align:top;font-weight:bold;">
									Region
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;font-weight:bold;">
									Species
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;font-weight:bold;">
									Thickness
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;font-weight:bold;">
									Grade
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;font-weight:bold;">
									Length
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;font-weight:bold;">
									Color
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;font-weight:bold;">
									Sort
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;font-weight:bold;">
									Milling
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;font-weight:bold;">
									NoPrint
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="vertical-align:top;">
									Action
								</td>
							</tr>
							<tr>
								<td style="text-align:left;vertical-align:top;">
									<asp:ListBox ID="lbxRegionFv" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false">
										<asp:ListItem Value="0" Text="ALL" Selected="True"></asp:ListItem>
										<asp:ListItem Value="APP" Text="Appalachian"></asp:ListItem>
										<asp:ListItem Value="GLA" Text="Glacial"></asp:ListItem>
										<asp:ListItem Value="WEST" Text="Western"></asp:ListItem>
									</asp:ListBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;">
									<asp:ListBox ID="lbxSpeciesFv" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false">
										<asp:ListItem Value="0" Text="ALL" Selected="True"></asp:ListItem>
									</asp:ListBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;">
									<asp:ListBox ID="lbxThicknessFv" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false">
										<asp:ListItem Value="0" Text="ALL" Selected="True"></asp:ListItem>
									</asp:ListBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;">
									<asp:ListBox ID="lbxGradeFv" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false">
										<asp:ListItem value="0" Text="ALL" Selected="True"></asp:ListItem>
									</asp:ListBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;">
									<asp:ListBox ID="lbxLengthFv" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false">
										<asp:ListItem value="0" Text="ALL" Selected="True"></asp:ListItem>
									</asp:ListBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;">
									<asp:ListBox ID="lbxColorFv" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false">
										<asp:ListItem value="0" Text="ALL" Selected="True"></asp:ListItem>
									</asp:ListBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;">
									<asp:ListBox ID="lbxSortFv" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false">
										<asp:ListItem value="0" Text="ALL" Selected="True"></asp:ListItem>
									</asp:ListBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;">
									<asp:ListBox ID="lbxMillingFv" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false">
										<asp:ListItem value="0" Text="ALL" Selected="True"></asp:ListItem>
									</asp:ListBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;">
									<asp:ListBox ID="lbxNoPrintFv" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false">
										<asp:ListItem value="0" Text="ALL" Selected="True"></asp:ListItem>
									</asp:ListBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="vertical-align:top;">
									<asp:Button ID="btnRefreshProdView" runat="server" Text="Refresh View" CssClass="button blue-gradient glossy" OnClick="btnRefreshProdView_Click" />
								</td>
							</tr>
							<tr style="background-color:white;">
								<td style="text-align:left;vertical-align:top;background-color:white;" colspan="3">
									&nbsp;<span id="spnWeekNbrFV" style="color:cadetblue;font-weight:bold;font-size:12pt;">First&nbsp;Week:&nbsp;<asp:Label ID="lblWeekNbrFV" runat="server" Text="00"></asp:Label></span>

								</td>
								<td colspan="14" style="text-align:center;background-color:white;vertical-align:bottom;">
									<asp:Label ID="lblFinishView" CssClass="SpecHeaderTitle" Width="300" Text="Finish View" runat="server"></asp:Label><br />
								</td>
								<td style="text-align:center;vertical-align:top;background-color:white;" colspan="3">
									&nbsp;
								</td>
							</tr>
							</table>
							<asp:HiddenField ID="hfgvFinishNbrRows" runat="server" Value="0" />
						</div>

						<div id="divFinishGrid" runat="server" style="width:100%;height:644px;overflow:auto;">
							<asp:GridView ID="gvFinishView" runat="server" CellPadding="0" AutoGenerateColumns="false" OnRowDataBound="gvFinishView_RowDataBound1"  OnDataBound="gvFinishView_DataBound" OnPageIndexChanging="gvFinishView_PageIndexChanging"
								OnPageIndexChanged="gvFinishView_PageIndexChanged" AllowPaging="true" PageIndex="0" PageSize="20" EnableViewState="true">
								<HeaderStyle CssClass="TableHdrCell" />
								<Columns>
									<asp:BoundField DataField="ProdType" HeaderText="P/T" ItemStyle-Wrap="false" ItemStyle-VerticalAlign="Top" HeaderStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" />
									<asp:BoundField DataField="ProductCode" HeaderText="Prod" HeaderStyle-Wrap="false">
										<ItemStyle Width="60" VerticalAlign="Top" CssClass="GridViewPadding" />
									</asp:BoundField>
									<asp:BoundField DataField="ProductFullName" HeaderText="Description">
										<ItemStyle Width="160" VerticalAlign="Top" Wrap="false" CssClass="GridViewPadding" />
									</asp:BoundField>
									<asp:BoundField DataField="Region" HeaderText="Region" ItemStyle-Wrap="false" ItemStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="60" />
									<asp:TemplateField HeaderText="Wk1-Day1">
										<ItemTemplate>
											<div id="divForecastGrid0101v" class="ListBoxPaddingTB" style="width:100px;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc4s1" runat="server" title="Week 1-Day 1-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk1_1Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk1_1Shft1") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc4s2" runat="server" title="Week 1-Day 1-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk1_1Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk1_1Shft2") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc4s3" runat="server" title="Week 1-Day 1-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk1_1Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk1_1Shft3") %>'></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk1-Day2">
										<ItemTemplate>
											<div id="divForecastGrid0102v" class="ListBoxPaddingTB" style="width:100px;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc5s1" runat="server" title="Week 1-Day 2-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk1_2Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk1_2Shft1") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc5s2" runat="server" title="Week 1-Day 2-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk1_2Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk1_2Shft2") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc5s3" runat="server" title="Week 1-Day 2-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk1_2Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk1_2Shft3") %>'></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk1-Day3">
										<ItemTemplate>
											<div id="divForecastGrid0103v" class="ListBoxPaddingTB" style="width:100px;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc6s1" runat="server" title="Week 1-Day 3-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk1_3Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk1_3Shft1") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc6s2" runat="server" title="Week 1-Day 3-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk1_3Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk1_3Shft2") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc6s3" runat="server" title="Week 1-Day 3-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk1_3Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk1_3Shft3") %>'></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk1-Day4">
										<ItemTemplate>
											<div id="divForecastGrid0104v" class="ListBoxPaddingTB" style="width:100px;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc7s1" runat="server" title="Week 1-Day 4-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk1_4Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk1_4Shft1") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc7s2" runat="server" title="Week 1-Day 4-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk1_4Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk1_4Shft2") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc7s3" runat="server" title="Week 1-Day 4-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk1_4Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk1_4Shft3") %>'></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk1-Day5">
										<ItemTemplate>
											<div id="divForecastGrid0105v" class="ListBoxPaddingTB" style="width:100px;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc8s1" runat="server" title="Week 1-Day 5-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk1_5Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk1_5Shft1") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc8s2" runat="server" title="Week 1-Day 5-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk1_5Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk1_5Shft2") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc8s3" runat="server" title="Week 1-Day 5-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk1_5Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk1_5Shft3") %>'></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk1-Day6">
										<ItemTemplate>
											<div id="divForecastGrid0106v" class="ListBoxPaddingTB" style="width:100px;background-color:antiquewhite;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc9s1" runat="server" title="Week 1-Day 6-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk1_6Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk1_6Shft1") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc9s2" runat="server" title="Week 1-Day 6-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk1_6Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk1_6Shft2") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc9s3" runat="server" title="Week 1-Day 6-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk1_6Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk1_6Shft3") %>'></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="AntiqueWhite" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk1-Day7">
										<ItemTemplate>
											<div id="divForecastGrid0107v" class="ListBoxPaddingTB" style="width:100px;background-color:antiquewhite;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc10s1" runat="server" title="Week 1-Day 7-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk1_7Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk1_7Shft1") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc10s2" runat="server" title="Week 1-Day 7-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk1_7Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk1_7Shft2") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc10s3" runat="server" title="Week 1-Day 7-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk1_7Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk1_7Shft3") %>'></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="AntiqueWhite" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk2-Day1">
										<ItemTemplate>
											<div id="divForecastGrid0201v" class="ListBoxPaddingTB" style="width:100px;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc11s1" runat="server" title="Week 2-Day 1-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk2_1Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk2_1Shft1") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc11s2" runat="server" title="Week 2-Day 1-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk2_1Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk2_1Shft2") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc11s3" runat="server" title="Week 2-Day 1-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk2_1Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk2_1Shft3") %>'></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk2-Day2">
										<ItemTemplate>
											<div id="divForecastGrid0202v" class="ListBoxPaddingTB" style="width:100px;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc12s1" runat="server" title="Week 2-Day 2-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk2_2Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk2_2Shft1") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc12s2" runat="server" title="Week 2-Day 2-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk2_2Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk2_2Shft2") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc12s3" runat="server" title="Week 2-Day 2-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk2_2Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk2_2Shft3") %>'></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk2-Day3">
										<ItemTemplate>
											<div id="divForecastGrid0203v" class="ListBoxPaddingTB" style="width:100px;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc13s1" runat="server" title="Week 2-Day 3-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk2_3Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk2_3Shft1") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc13s2" runat="server" title="Week 2-Day 3-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk2_3Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk2_3Shft2") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc13s3" runat="server" title="Week 2-Day 3-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk2_3Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk2_3Shft3") %>'></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk2-Day4">
										<ItemTemplate>
											<div id="divForecastGrid0204v" class="ListBoxPaddingTB" style="width:100px;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc14s1" runat="server" title="Week 2-Day 4-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk2_4Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk2_4Shft1") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc14s2" runat="server" title="Week 2-Day 4-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk2_4Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk2_4Shft2") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc14s3" runat="server" title="Week 2-Day 4-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk2_4Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk2_4Shft3") %>'></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk2-Day5">
										<ItemTemplate>
											<div id="divForecastGrid0205v" class="ListBoxPaddingTB" style="width:100px;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc15s1" runat="server" title="Week 2-Day 5-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk2_5Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk2_5Shft1") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc15s2" runat="server" title="Week 2-Day 5-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk2_5Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk2_5Shft2") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc15s3" runat="server" title="Week 2-Day 5-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk2_5Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk2_5Shft3") %>'></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk2-Day6">
										<ItemTemplate>
											<div id="divForecastGrid0206v" class="ListBoxPaddingTB" style="width:100px;background-color:antiquewhite;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc16s1" runat="server" title="Week 2-Day 6-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk2_6Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk2_6Shft1") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc16s2" runat="server" title="Week 2-Day 6-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk2_6Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk2_6Shft2") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc16s3" runat="server" title="Week 2-Day 6-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk2_6Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk2_6Shft3") %>'></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="AntiqueWhite" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Wk2-Day7">
										<ItemTemplate>
											<div id="divForecastGrid0207v" class="ListBoxPaddingTB" style="width:100px;background-color:antiquewhite;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc17s1" runat="server" title="Week 2-Day 7-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk2_7Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk2_7Shft1") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc17s2" runat="server" title="Week 2-Day 7-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk2_7Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk2_7Shft2") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc17s3" runat="server" title="Week 2-Day 7-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk2_7Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk2_7Shft3") %>'></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="AntiqueWhite" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Week3">
										<ItemTemplate>
											<div id="divForecastGrid03v" class="ListBoxPaddingTB" style="width:100px;background-color:#FFDD00;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc18s1" runat="server" title="Week 3-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk3Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk3Shft1") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc18s2" runat="server" title="Week 3-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk3Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk3Shft2") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc18s3" runat="server" title="Week 3-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk3Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk3Shft3") %>'></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="#FFDD00" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Week4">
										<ItemTemplate>
											<div id="divForecastGrid04v" class="ListBoxPaddingTB" style="width:100px;background-color:#FFDD00;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc19s1" runat="server" title="Week 4-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk4Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk4Shft1") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc19s2" runat="server" title="Week 4-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk4Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk4Shft2") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc19s3" runat="server" title="Week 4-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk4Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk4Shft3") %>'></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="#FFDD00" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Week5">
										<ItemTemplate>
											<div id="divForecastGrid05v" class="ListBoxPaddingTB" style="width:100px;background-color:#FFDD00;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc20s1" runat="server" title="Week 5-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk5Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk5Shft1") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc20s2" runat="server" title="Week 5-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk5Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk5Shft2") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc20s3" runat="server" title="Week 5-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk5Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk5Shft3") %>'></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="#FFDD00" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Week6">
										<ItemTemplate>
											<div id="divForecastGrid06v" class="ListBoxPaddingTB" style="width:100px;background-color:#FFDD00;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc21s1" runat="server" title="Week 6-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk6Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk6Shft1") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc21s2" runat="server" title="Week 6-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk6Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk6Shft2") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc21s3" runat="server" title="Week 6-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk6Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk6Shft3") %>'></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="#FFDD00" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Week7">
										<ItemTemplate>
											<div id="divForecastGrid07v" class="ListBoxPaddingTB" style="width:100px;background-color:#FFDD00;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc22s1" runat="server" title="Week 7-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk7Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk7Shft1") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc22s2" runat="server" title="Week 7-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk7Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk7Shft2") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc22s3" runat="server" title="Week 7-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk7Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk7Shft3") %>'></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="#FFDD00" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Week8">
										<ItemTemplate>
											<div id="divForecastGrid08v" class="ListBoxPaddingTB" style="width:100px;background-color:#FFDD00;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc23s1" runat="server" title="Week 8-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk8Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk8Shft1") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc23s2" runat="server" title="Week 8-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk8Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk8Shft2") %>'></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc23s3" runat="server" title="Week 8-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk8Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk8Shft3") %>'></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="#FFDD00" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Week9">
										<ItemTemplate>
											<div id="divForecastGrid09v" class="ListBoxPaddingTB" style="width:100px;background-color:#FFDD00;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc24s1" runat="server" title="Week 9-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk9Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk9Shft1") %>' ></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc24s2" runat="server" title="Week 9-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk9Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk9Shft2") %>' ></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc24s3" runat="server" title="Week 9-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk9Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk9Shft3") %>' ></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="#FFDD00" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Week10">
										<ItemTemplate>
											<div id="divForecastGrid10v" class="ListBoxPaddingTB" style="width:100px;background-color:#FFDD00;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc25s1" runat="server" title="Week 10-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk10Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk10Shft1") %>' ></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc25s2" runat="server" title="Week 10-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk10Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk10Shft2") %>' ></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc25s3" runat="server" title="Week 10-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk10Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk10Shft3") %>' ></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="#FFDD00" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Week11">
										<ItemTemplate>
											<div id="divForecastGrid11v" class="ListBoxPaddingTB" style="width:100px;background-color:#FFDD00;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc26s1" runat="server" title="Week 11-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk11Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk11Shft1") %>' ></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc26s2" runat="server" title="Week 11-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk11Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk11Shft2") %>' ></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc26s3" runat="server" title="Week 11-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk11Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk11Shft3") %>' ></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="#FFDD00" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Week12">
										<ItemTemplate>
											<div id="divForecastGrid12v" class="ListBoxPaddingTB" style="width:100px;background-color:#FFDD00;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc27s1" runat="server" title="Week 12-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk12Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk12Shft1") %>' ></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc27s2" runat="server" title="Week 12-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk12Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk12Shft2") %>' ></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc27s3" runat="server" title="Week 12-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk12Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk12Shft3") %>' ></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="#FFDD00" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Week13">
										<ItemTemplate>
											<div id="divForecastGrid13v" class="ListBoxPaddingTB" style="width:100px;background-color:#FFDD00;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc28s1" runat="server" title="Week 13-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk13Amt1v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk13Shft1") %>' ></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc28s2" runat="server" title="Week 13-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk13Amt2v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk13Shft2") %>' ></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc28s3" runat="server" title="Week 13-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWk13Amt3v" runat="server" CssClass="GridDisplayLabel" Text='<%# Eval("Wk13Shft3") %>' ></asp:Label>
													</td>
												</tr>
												</table>
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="#FFDD00" />
									</asp:TemplateField>
									<asp:BoundField DataField="ProductFullName" HeaderText="Description">
										<ItemStyle Width="160" VerticalAlign="Top" Wrap="false" CssClass="GridViewPadding" />
									</asp:BoundField>
									<asp:TemplateField HeaderText="Total">
										<ItemTemplate>
											<div id="divForecastGridTotals2" class="ListBoxPaddingTB" style="width:100px;background-color:#FFAA00;" runat="server">
												<table class="TablePresentationStd">
												<tr id="trFinishc30s1" runat="server" title="Totals-Shift 1">
													<td class="ForecastShiftBx">
														1:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWkTotalAmt1v" runat="server" CssClass="GridDisplayLabel" ForeColor="DarkBlue" ReadOnly="true"></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc30s2" runat="server" title="Totals-Shift 2">
													<td class="ForecastShiftBx">
														2:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWkTotalAmt2v" runat="server" CssClass="GridDisplayLabel" ForeColor="DarkBlue" ReadOnly="true"></asp:Label>
													</td>
												</tr>
												<tr id="trFinishc30s3" runat="server" title="Totals-Shift 3">
													<td class="ForecastShiftBx">
														3:
													</td>
													<td class="ForecastAmtBx">
														<asp:Label ID="lblWkTotalAmt3v" runat="server" CssClass="GridDisplayLabel" ForeColor="DarkBlue" ReadOnly="true"></asp:Label>
													</td>
												</tr>
												</table>
												<asp:HiddenField ID="hfProdType" runat="server" Value='<%# Eval("ProdType") %>' />
												<asp:HiddenField ID="hfFProdCode" runat="server" Value='<%# Eval("ProductCode") %>' />
												<asp:HiddenField ID="hfFPProdFullName" runat="server" Value='<%# Eval("ProductFullName") %>' />
											</div>
										</ItemTemplate>
										<ItemStyle BackColor="#FFAA00" />
									</asp:TemplateField>
								</Columns>
							</asp:GridView>
						</div>

						<div id="divFinishGridH" runat="server" style="width:100%;height:644px;overflow:auto;display:none;">
							<asp:GridView ID="gvFinishViewH" runat="server" AllowPaging="true" AutoGenerateColumns="false" GridLines="Both"  
									OnPageIndexChanged="gvFinishViewH_PageIndexChanged" OnPageIndexChanging="gvFinishViewH_PageIndexChanging"
									OnDataBinding="gvFinishViewH_DataBinding" OnRowDataBound="gvFinishViewH_RowDataBound" >
								<Columns>
									<asp:BoundField DataField="ProdType" HeaderText="P/T" ItemStyle-Wrap="false" ItemStyle-VerticalAlign="Top" HeaderStyle-Wrap="false" ItemStyle-HorizontalAlign="Center" />
									<asp:BoundField DataField="ProductCode" HeaderText="Prod" HeaderStyle-Wrap="false">
										<ItemStyle Width="60" VerticalAlign="Top" CssClass="GridViewPadding" />
									</asp:BoundField>
									<asp:BoundField DataField="ProductFullName" HeaderText="Description">
										<ItemStyle Width="160" VerticalAlign="Top" Wrap="false" CssClass="GridViewPadding" />
									</asp:BoundField>
									<asp:BoundField DataField="Region" HeaderText="Region" ItemStyle-Wrap="false" ItemStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="60" />
									<asp:TemplateField HeaderText="WK00">
										<ItemTemplate>
											<asp:Label id="lblFGHWK00" runat="server" Text=""></asp:Label>
										</ItemTemplate>
										<ItemStyle HorizontalAlign="Right" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="WK01">
										<ItemTemplate>
											<asp:Label id="lblFGHWK01" runat="server" Text=""></asp:Label>
										</ItemTemplate>
										<ItemStyle HorizontalAlign="Right" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="WK02">
										<ItemTemplate>
											<asp:Label id="lblFGHWK02" runat="server" Text=""></asp:Label>
										</ItemTemplate>
										<ItemStyle HorizontalAlign="Right" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="WK03">
										<ItemTemplate>
											<asp:Label id="lblFGHWK03" runat="server" Text=""></asp:Label>
										</ItemTemplate>
										<ItemStyle HorizontalAlign="Right" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="WK04">
										<ItemTemplate>
											<asp:Label id="lblFGHWK04" runat="server" Text=""></asp:Label>
										</ItemTemplate>
										<ItemStyle HorizontalAlign="Right" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="WK05">
										<ItemTemplate>
											<asp:Label id="lblFGHWK05" runat="server" Text=""></asp:Label>
										</ItemTemplate>
										<ItemStyle HorizontalAlign="Right" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="WK06">
										<ItemTemplate>
											<asp:Label id="lblFGHWK06" runat="server" Text=""></asp:Label>
										</ItemTemplate>
										<ItemStyle HorizontalAlign="Right" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="WK07">
										<ItemTemplate>
											<asp:Label id="lblFGHWK07" runat="server" Text=""></asp:Label>
										</ItemTemplate>
										<ItemStyle HorizontalAlign="Right" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="WK08">
										<ItemTemplate>
											<asp:Label id="lblFGHWK08" runat="server" Text=""></asp:Label>
										</ItemTemplate>
										<ItemStyle HorizontalAlign="Right" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="WK09">
										<ItemTemplate>
											<asp:Label id="lblFGHWK09" runat="server" Text=""></asp:Label>
										</ItemTemplate>
										<ItemStyle HorizontalAlign="Right" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="WK10">
										<ItemTemplate>
											<asp:Label id="lblFGHWK10" runat="server" Text=""></asp:Label>
										</ItemTemplate>
										<ItemStyle HorizontalAlign="Right" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="WK11">
										<ItemTemplate>
											<asp:Label id="lblFGHWK11" runat="server" Text=""></asp:Label>
										</ItemTemplate>
										<ItemStyle HorizontalAlign="Right" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="WK12">
										<ItemTemplate>
											<asp:Label id="lblFGHWK12" runat="server" Text=""></asp:Label>
										</ItemTemplate>
										<ItemStyle HorizontalAlign="Right" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="WK13">
										<ItemTemplate>
											<asp:Label id="lblFGHWK13" runat="server" Text=""></asp:Label>
										</ItemTemplate>
										<ItemStyle HorizontalAlign="Right" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Total">
										<ItemTemplate>
											<asp:Label id="lblFGHWKTotal" runat="server" Text=""></asp:Label>
										</ItemTemplate>
										<ItemStyle HorizontalAlign="Right" />
									</asp:TemplateField>
								</Columns>
							</asp:GridView>
						</div>
					</div>

					<div id="divForecastCodes" style="width:100%;display:none;" runat="server">
						<div id="divForecastCodesHdr" style="width:100%;text-align:center;margin-bottom:10px;">
							<table id="tblForecastCodeHdr" style="width:100%;padding:1px;border-spacing:0px;">
							<tr>
								<td style="text-align:right;width:33%;">
									&nbsp;
								</td>
								<td style="text-align:center;width:34%;">
									<asp:Label ID="lblForecastCodesHdr" CssClass="SpecHeaderTitle" Width="300" Text="Forecast Codes and Lists" runat="server"></asp:Label><br />
								</td>
								<td style="text-align:center;width:33%;">
									&nbsp;
								</td>
							</tr>
							<tr>
								<td style="text-align:center;" colspan="3">
									Code&nbsp;Type:&nbsp;
									<asp:DropDownList ID="ddlEditForecastCodeType" OnSelectedIndexChanged="ddlEditForecastCodeType_SelectedIndexChanged" runat="server" AutoPostBack="true" >
										<asp:ListItem Value="0" Selected="True" Text="Settings"></asp:ListItem>
										<asp:ListItem Value="1" Text="Lengths"></asp:ListItem>
									</asp:DropDownList>&nbsp;&nbsp;&nbsp;
									<asp:Button ID="btnCloneLocation" runat="server" Text="Clone a Location" OnClick="btnCloneLocation_Click" CssClass="button blue-gradient glossy" />&nbsp;&nbsp;
									<asp:Button ID="btnCheckInEntireLoc" runat="server" Text="Check in Entire Location" OnClick="btnCheckInEntireLoc_Click" CssClass="button blue-gradient glossy" />
								</td>
							</tr>
							</table>
						</div>

						<div id="divCodeTypeLabel" style="width:100%;text-align:center;margin-bottom:10px;" runat="server">
							<asp:Label ID="lblForecastCodeType" Text="" Font-Bold="true" ForeColor="Blue" runat="server" Font-Size="12pt"></asp:Label>
						</div>

						<div id="divForecastCodesGrid" runat="server" style="width:100%;text-align:center;height:670px;overflow:auto;">
							<center>
							<asp:GridView ID="gvForecastCodes" runat="server" AllowPaging="true" AllowSorting="true" PageIndex="0" OnRowEditing="gvForecastCodes_RowEditing" OnSelectedIndexChanged="gvForecastCodes_SelectedIndexChanged" 
								OnSelectedIndexChanging="gvForecastCodes_SelectedIndexChanging" OnRowCommand="gvForecastCodes_RowCommand" OnRowDataBound="gvForecastCodes_RowDataBound"	OnPageIndexChanged="gvForecastCodes_PageIndexChanged" 
								OnPageIndexChanging="gvForecastCodes_PageIndexChanging"	 OnDataBound="gvForecastCodes_DataBound" AlternatingRowStyle-BackColor="WhiteSmoke" AutoGenerateColumns="false" CellPadding="1" PageSize="20">
								<HeaderStyle CssClass="TableHdrCell" />
								<Columns>
									<asp:BoundField DataField="CodeID" HeaderText="ID" ItemStyle-Width="36" />
									<asp:BoundField DataField="CodeType" HeaderText="Type" ItemStyle-Width="70" />
									<asp:BoundField DataField="Code" HeaderText="Code" ItemStyle-Width="70" />
									<asp:BoundField DataField="CodeDescription" HeaderText="Description" ItemStyle-Width="200" />
									<asp:TemplateField HeaderText="Setting Value">
										<ItemTemplate>
											<div id="divForecastCodesC4" class="GridViewPadding">
												<asp:CheckBox ID="chkUseShift" runat="server" Checked="true" OnCheckedChanged="chkUseShift_CheckedChanged" AutoPostBack="true" />
												<asp:HiddenField ID="hfCodeID" runat="server" Value='<%# Eval("CodeID") %>' />
												<asp:HiddenField ID="hfCodeValue" runat="server" Value='<%# Eval("Code") %>' />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
								</Columns>
							</asp:GridView>
							</center>
						</div>

						<div id="divForecastLengthCodesGrid" runat="server" style="width:100%;text-align:center;height:684px;overflow:auto;display:none;">
							<center>
							<asp:GridView ID="gvLengthCodes" runat="server" AllowPaging="true" PageIndex="0" PageSize="20" OnRowDataBound="gvLengthCodes_RowDataBound" OnPageIndexChanged="gvLengthCodes_PageIndexChanged" OnPageIndexChanging="gvLengthCodes_PageIndexChanging"
								OnRowCommand="gvLengthCodes_RowCommand" OnRowEditing="gvLengthCodes_RowEditing" AutoGenerateColumns="false" >
								<HeaderStyle CssClass="TableHdrCell" />
								<Columns>
									<asp:BoundField DataField="CatCodeID" HeaderText="ID" ControlStyle-CssClass="StdTableCell" />
									<asp:BoundField DataField="CatCode" HeaderText="Code" ControlStyle-CssClass="StdTableCell" />
									<asp:BoundField DataField="CodeDescription" HeaderTExt="Description" ControlStyle-CssClass="StdTableCell" />
									<asp:TemplateField HeaderText="Shown" ControlStyle-CssClass="StdTableCell" >
										<ItemTemplate>
											<div id="divForecastCodesC4" class="GridViewPadding">
												<asp:CheckBox ID="chkCodeIsShown" runat="server" AutoPostBack="true"  OnCheckedChanged="chkCodeIsShown_CheckedChanged" />
												<asp:HiddenField ID="hfCatCodeID" runat="server" Value='<%# Eval("CatCodeID") %>' />
												<asp:HiddenField ID="hfUserCodeID" runat="server" Value='<%# Eval("UserCodeID") %>' />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
								</Columns>
							</asp:GridView>
							</center>
						</div>

						<div id="divForecastCloneLoc" runat="server" style="width:100%;display:none;text-align:center;">
							<center>
							<table style="border-spacing:1px;">
							<tr>
								<td style="text-align:right;">
									<asp:Label ID="lblCloneLeft" runat="server" Text="Clone" Font-Bold="true" ForeColor="DarkRed" ></asp:Label>&nbsp;<asp:DropDownList ID="ddlSrcLocationCode" AppendDataBoundItems="true" runat="server">
										<asp:ListItem Value="0" Selected="True" Text="Not Selected"></asp:ListItem>
									</asp:DropDownList>&nbsp;
								</td>
								<td style="text-align:center;">
									 <asp:Label ID="Label1" runat="server" Text="to" Font-Bold="true" ForeColor="DarkRed" ></asp:Label>&nbsp;
								</td>
								<td>
									<asp:DropDownList ID="ddlTgtLocationCode" AppendDataBoundItems="true" runat="server">
										<asp:ListItem value="0" Selected="True" Text="Not Selected"></asp:ListItem>
									</asp:DropDownList>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<div id="divItemsToIncludeInCloning" style="width:100%;margin-top:10px;text-align:center;margin-top:10px;margin-bottom:10px;">
										<asp:Label ID="lblIncludeItems" runat="server" Text="Include" Font-Bold="true" ForeColor="Blue"></asp:Label>&nbsp;Products<asp:CheckBox ID="chkCloneProducts" Checked="true" runat="server" />&nbsp;
										Mixes:<asp:CheckBox ID="chkCloneMixes" Checked="true" runat="server" />&nbsp;
										Mixes&nbsp;Contents:<asp:CheckBox ID="chkCloneMixContents" Checked="true" runat="server" />&nbsp;
										Settings:<asp:CheckBox ID="chkCloneSettings" Checked="true" runat="server" />
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3" style="color:darkgray;">
									<div id="divNotesForCloning" style="width:100%;margin-top:10px;margin-bottom:10px;">
										Notes: Including items above will mean that items will be copied into the cloned location if they do not already exist.  For mixes, the mix will be copied if the thickness, species, grade, length, and suffix are not equal.
										Settings only includes the Use Shift settings for shift 1, 2, and 3.
									</div>
								</td>
							</tr>
							<tr>
								<td style="text-align:center;" colspan="3">
									<asp:Button ID="btnCloneLocationsNow" Text="Clone Location" runat="server" OnClick="btnCloneLocationsNow_Click" CssClass="button blue-gradient glossy" />&nbsp;
									<asp:Button ID="btnCloseCloneEditArea" Text="Close Area" runat="server" CssClass="button blue-gradient glossy" OnClick="btnCloseCloneEditArea_Click" />
								</td>
							</tr>
							</table>
							</center>
						</div>

					</div>

				</div>

				<!------------------------------------------------------------------------------------------------------------>

				<div id="divPAGEFOOTER" style="width:99%;margin-left:10px;margin-top:6px;">
					<div id="divErrorMsg" style="width:100%;">
						<asp:Label ID="lblErrorMsg"	style="color:maroon;font-weight:bold;font-size:12pt;" runat="server"></asp:Label>
					</div>
				</div>
        
          <footer>
             <div id="divMasterFooter" runat="server" style="border-top:1px solid gray;line-height:16px;margin:0px;font-size:9pt;margin-top:6px;">
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
