<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CatTool.aspx.cs" Inherits="DataMngt.sales.CatTool" EnableSessionState="false" %>
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
	<script type="text/javascript" src="../Scripts/Utilities.js?v=<%=BuildNbr %>"></script>
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

	</style>

	<script type="text/javascript">
		var jbA = false;
		var jbPaginate = false;
		var jbViewOnly = false;
		var jiAR = 0;
		var jiActionStatusCode = '';
		var jiActionStatusID = 0;
		var jiActionStatusMsg = '';
		var jiApprovalID = 0;
		var jiByID = 0;
		var jiUserID = 0;
		var jiPageID = 27;
		var jsBrowserType = '';
		var jsErrorMsg = '';
		var jsPageVersion = '';
		var jsPageVersDate = '';
		var jiApproverID = 0;
		var jdToday = new Date();
		var jsToday = '';
		var jsCurrentTime = '';

		var MyReturn;

		var counter = 0;
		var DayNamesNV = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

		$(document).ready(function () {
			jsToday = getMyDateTimeStringDm(jdToday, 18);
			jsCurrentTime = getMyDateTimeStringDm(jdToday, 7);
			//alert(jdToday + '/' + jsToday + '/' + jsCurrentTime);
			updateClockNV();
			jiPageID = 27;
			KeepSessionAlive();
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

	</script>

  <link href="~/favicon.ico" rel="shortcut icon" type="image/x-icon" />

</head>
<body>
	<img id="imgSessionKeepAlive" width="1" height="1" style="display:none;" src="../Images/clearpixel.gif" />
  <form id="Form1" runat="server">
  <asp:ScriptManager runat="server"></asp:ScriptManager>
	<asp:HiddenField ID="hfPageID" runat="server" Value="27" />

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

					<script type="text/javascript">

						function MakeProductManaged() {

						}

					</script>

					<div id="divPAGEHEADER" class="MainDiv"  style="display:none;">
						&nbsp;
					</div>

					<div id="divPAGEMAIN" class="MainDiv" style="margin-left:8px;margin-bottom:8px;">
						<div id="divMainFilterBarLbl" style="width:100%;text-align:center;">
						</div>
						<div id="divFilterBar" class="TableFilterHdrCell" style="width:99%;text-align:center;margin-bottom:10px;line-height:28px;" runat="server">
							<table style="border-spacing:0px;padding:0px;border:none;width:100%;">
							<tr>
								<td colspan="25">
									<asp:Label ID="lblMainFilterBar" runat="server" style="color:blue;font-size:12pt;font-weight:bold;">Filters for CAT Data:</asp:Label>
									<span style="padding-right: 10px">&nbsp;</span>
									<label style="margin-left: 5px; margin-right: 10px;">Show Forecasted Weeks:</label><asp:CheckBox ID="CheckBox1" runat="server" OnCheckedChanged="CheckBox1_CheckedChanged" ForeColor="Black" AutoPostBack="true" Checked="False" />
									<span style="padding-right: 5px">&nbsp;</span>
									<label style="margin-left: 6px; margin-right: 10px;">Hide Comments:</label><asp:CheckBox ID="CheckBox2" runat="server" OnCheckedChanged="CheckBox2_CheckedChanged" ForeColor="Black" AutoPostBack="true" Checked="False" />
									<span style="padding-right: 10px">&nbsp;</span>
									<label style="margin-left: 6px; margin-right: 10px;">Exclude 0s:</label><asp:CheckBox ID="chkExclude0" runat="server" OnCheckedChanged="chkExclude0_CheckedChanged" ForeColor="Black" AutoPostBack="true" Checked="True" />
									<span style="padding-right: 10px">&nbsp;</span>
									<label style="margin-left: 6px; margin-right: 10px;">Narrow:</label><asp:CheckBox ID="chkNarrowView" runat="server" AutoPostBack="true" OnCheckedChanged="chkNarrowView_CheckedChanged" />
									<span style="padding-right: 10px">&nbsp;</span>
									<label style="margin-left: 5px; margin-right: 10px;">Printer Friendly:</label><asp:CheckBox ID="chkPrinterFriendly" runat="server" AutoPostBack="true" OnCheckedChanged="chkPrinterFriendly_CheckedChanged" />
									<span style="padding-right: 6px">&nbsp;</span>

									<div id="divSpecialBtnGroup" style="display:inline;" runat="server">
										<asp:Button ID="Button1" runat="server" Text="- Font Size" CssClass="button blue-gradient glossy" OnClick="Button1_Click" />
										<asp:Button ID="Button2" runat="server" Text="+ Font Size" CssClass="button blue-gradient glossy" OnClick="Button2_Click" />
										<asp:Button ID="Button3" runat="server" Text="Reset" CssClass="button blue-gradient glossy" OnClick="Button3_Click" />
										<span style="padding-right: 50px">&nbsp;</span>

										<asp:Button ID="btnEmailPDF" runat="server" style="" CssClass="button blue-gradient glossy" OnClick="btnEmailPDF_Click" Text="Export to PDF" />&nbsp;
										<asp:Button ID="btnExcelCopy" runat="server" style="" CssClass="button blue-gradient glossy" OnClick="btnExcelCopy_Click" Text="Export to Excel" />&nbsp;
										<asp:Button ID="btnEditCatItems" runat="server" style="" CssClass="button blue-gradient glossy" OnClick="btnEditCatItems_Click" Text="Edit CAT Product List" />&nbsp;
									</div>
								</td>
							</tr>
							<tr id="trFilterLine1" runat="server">
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;width:100px;">
									<asp:Label ID="Label5" runat="server" Text="Region:" ForeColor="DarkBlue" Font-Bold="true"></asp:Label>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;width:200px;">
									<asp:Label ID="Label1" runat="server" Text="Location:" ForeColor="DarkBlue" Font-Bold="true"></asp:Label>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;width:100px;">
									<asp:Label ID="Label2" runat="server" Text="Species:" ForeColor="DarkBlue" Font-Bold="true"></asp:Label>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;width:100px;">
									<asp:Label ID="Label3" runat="server" Text="Thickness:" ForeColor="DarkBlue" Font-Bold="true"></asp:Label>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;width:160px;">
									<asp:Label ID="Label4" runat="server" Text="Grade:" ForeColor="DarkBlue" Font-Bold="true"></asp:Label>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;width:100px;">
									<asp:Label ID="Label6" runat="server" Text="Color:" ForeColor="DarkBlue" Font-Bold="true"></asp:Label>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;width:100px;">
									<asp:Label ID="Label7" runat="server" Text="Sort:" ForeColor="DarkBlue" Font-Bold="true"></asp:Label>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;width:100px;">
									<asp:Label ID="Label8" runat="server" Text="NoPrint:" ForeColor="DarkBlue" Font-Bold="true"></asp:Label>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
							</tr>
							<tr id="trFilterLine2" runat="server">
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;width:90px;">
									<asp:ListBox ID="lbxRegionF" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false">
										<asp:ListItem Value="0" Text="ALL" Selected="True"></asp:ListItem>
										<asp:ListItem Value="APP" Text="Appalachian"></asp:ListItem>
										<asp:ListItem Value="GLA" Text="Glacial"></asp:ListItem>
										<asp:ListItem Value="NORTH" Text="North"></asp:ListItem>
										<asp:ListItem Value="WEST" Text="West"></asp:ListItem>
									</asp:ListBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;width:200px;">
									<asp:ListBox ID="lbxLocationF" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false">
										<asp:ListItem Value="0" Text="ALL" Selected="True"></asp:ListItem>
									</asp:ListBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;width:100px;">
									<asp:ListBox ID="lbxSpeciesF" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false">
										<asp:ListItem Value="0" Text="ALL" Selected="True"></asp:ListItem>
									</asp:ListBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;width:90px;">
									<asp:ListBox ID="lbxThicknessF" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false">
										<asp:ListItem Value="0" Text="ALL" Selected="True"></asp:ListItem>
									</asp:ListBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;width:160px;">
									<asp:ListBox ID="lbxGradeF" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false">
										<asp:ListItem value="0" Text="ALL" Selected="True"></asp:ListItem>
									</asp:ListBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;width:100px;">
									<asp:ListBox ID="lbxColorF" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false">
										<asp:ListItem value="0" Text="ALL" Selected="True"></asp:ListItem>
									</asp:ListBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;width:100px;">
									<asp:ListBox ID="lbxSortF" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false">
										<asp:ListItem value="0" Text="ALL" Selected="True"></asp:ListItem>
									</asp:ListBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td style="text-align:left;vertical-align:top;width:90px;">
									<asp:ListBox ID="lbxNoPrintF" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false">
										<asp:ListItem value="0" Text="ALL" Selected="True"></asp:ListItem>
										<asp:ListItem value="CLR" Text="CLR"></asp:ListItem>
										<asp:ListItem value="SLT" Text="SLT"></asp:ListItem>
										<asp:ListItem value="RT" Text="RT"></asp:ListItem>
									</asp:ListBox>
								</td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
							</tr>
							<tr id="trFilterLine3" runat="server">
								<td colspan="15" style="text-align:center;">
									&nbsp;Source&nbsp;Type:&nbsp;
									<asp:DropDownList ID="ddlSourceType" runat="server" AutoPostBack="true" OnTextChanged="ddlSourceType_TextChanged">
										<asp:ListItem Value="0" Text="Standard" Selected="True"></asp:ListItem>
										<asp:ListItem Value="1" Text="Service"></asp:ListItem>
									</asp:DropDownList>&nbsp;&nbsp;&bull;&nbsp;&nbsp;
									Product:&nbsp;<asp:TextBox ID="txtProductS" runat="server" style="width:120px;"></asp:TextBox>&nbsp;&nbsp;&bull;&nbsp;&nbsp;
									Description:&nbsp;<asp:TextBox ID="txtDescriptionS" runat="server" style="width:220px;"></asp:TextBox>&nbsp;&nbsp;&bull;&nbsp;&nbsp;
									<label style="margin-left: 5px;">Sort By:</label>
									<asp:DropDownList ID="ddlSortF" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSortF_SelectedIndexChanged" style="margin-left: 10px;">
											<asp:ListItem Text="Species (default)" Value="0" Selected="True" />
											<asp:ListItem Text="Thickness-Species" Value="1" />
											<asp:ListItem Text="Grade-Species" Value="2" />
											<asp:ListItem Text="Product Code" Value="3" />
											<asp:ListItem Text="Region-Species" Value="4" />
									</asp:DropDownList>&nbsp;&nbsp;&bull;&nbsp;&nbsp;
									<label style="margin-left: 5px;">View:</label>
									<asp:DropDownList ID="ddlDataViewScope" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlDataViewScope_SelectedIndexChanged" style="margin-left: 10px;">
										<asp:ListItem Value="0" Selected="True" Text="Normal"></asp:ListItem>
										<asp:ListItem Value="1" Text="Service CTR"></asp:ListItem>
									</asp:DropDownList>&nbsp;&nbsp;&bull;&nbsp;&nbsp;
									<label style="margin-left: 5px;">Items per Page:</label>
									<asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged" style="margin-left: 10px;">
											<asp:ListItem Text="10" Value="10" />
											<asp:ListItem Text="20" Value="20" Selected="True" />
											<asp:ListItem Text="25" Value="25" />
											<asp:ListItem Text="50" Value="50" />
											<asp:ListItem Text="100" Value="100" />
											<asp:ListItem Text="250" Value="250" />
											<asp:ListItem Text="300" Value="300" />
											<asp:ListItem Text="400" Value="400" />
											<asp:ListItem Text="500" Value="500" />
									</asp:DropDownList>&nbsp;&nbsp;&bull;&nbsp;&nbsp;
									<asp:Button ID="btnRefreshData" runat="server" CssClass="button blue-gradient glossy" style="width:140px;" Text="Refresh Data" OnClick="btnRefreshData_Click" />&nbsp;&nbsp;&nbsp;&nbsp;
								<asp:Button ID="btnShowColEdit" runat="server" CssClass="button blue-gradient glossy" OnClick="btnShowColEdit_Click" Text="Cols" />
								</td>
							</tr>
							</table>
						</div>

						<div id="divShowCurrentFiltersSet" style="width:100%;display:none;font-size:9pt;" runat="server">
							<asp:Label ID="lblShowCurrentFiltersSet" Text="Filters Set: None" runat="server" Font-Size="9"></asp:Label>
						</div>

						<div id="divColumnShownEdit" runat="server" style="width:100%;display:none;text-align:center;margin-bottom:6px;">
							<span id="spnColShownEdit" style="background-color:lightgoldenrodyellow;padding-left:10px;padding-right:10px;padding-top:2px;padding-bottom:4px;border:1px solid gray;vertical-align:middle;">
								&nbsp;<asp:Label runat="server" Text="Show Columns:" ForeColor="DarkGreen" Font-Bold="true" ></asp:Label>
								&nbsp;&nbsp;Mgd:<asp:CheckBox ID="chkShowManagedCol" runat="server" Checked="true" />&nbsp;
								Color:<asp:CheckBox ID="chkShowColorCol" runat="server" Checked="true" />&nbsp;
								Sort:<asp:CheckBox ID="chkShowSortCol" runat="server" Checked="true" />&nbsp;
								NoPrint:<asp:CheckBox ID="chkShowNoPrintCol" runat="server" Checked="true" />&nbsp;&nbsp;
								<asp:Button ID="btnRefreshData2" runat="server" CssClass="button blue-gradient glossy" OnClick="btnRefreshData2_Click" Text="Update Table" />&nbsp;
								<asp:Button ID="btnCloseThisDiv" runat="server" CssClass="button blue-gradient glossy" OnClick="btnCloseThisDiv_Click" Text="Close" />&nbsp;
							</span>
						</div>
						
						<div id="divGvCatDataHolder" runat="server" style="width:100%;text-align:center;">
							<asp:GridView ID="gvCatData" runat="server" AutoGenerateColumns="False" BorderStyle="Solid" BorderColor="#000000" BorderWidth="1px" HeaderStyle-BorderColor="#000000" 
								HeaderStyle-BorderStyle="Solid" HeaderStyle-BorderWidth="1px" PageSize="25" OnPageIndexChanging="gvCatData_PageIndexChanging" OnRowDataBound="gvCatData_RowDataBound" AllowPaging="True" OnDataBound="gvCatData_DataBound"
								PageIndex="0" CellPadding="4" Font-Size="10" >
								<Columns>
										<asp:BoundField DataField="Specie" HeaderText="Species" ItemStyle-BackColor="Yellow" ItemStyle-ForeColor="Black" ItemStyle-VerticalAlign="Top" ItemStyle-Font-Bold="true" />
										<asp:BoundField DataField="Thickness" HeaderText="Thickness" ItemStyle-VerticalAlign="Top" ItemStyle-Font-Bold="true" ItemStyle-Width="60px" />
										<asp:BoundField DataField="Grade" HeaderText="Grade" ItemStyle-VerticalAlign="Top" ItemStyle-Font-Bold="true" ItemStyle-Width="66px" />
										<asp:BoundField DataField="sIsTracked" HeaderText="Mgd"  ItemStyle-VerticalAlign="Top" />
										<asp:BoundField DataField="Color" HeaderText="Color" ItemStyle-Width="54px" ItemStyle-VerticalAlign="Top" />
										<asp:BoundField DataField="Sort" HeaderText="Sort" ItemStyle-Width="54px" ItemStyle-VerticalAlign="Top" />
										<asp:BoundField DataField="NoPrint" HeaderText="NoPrint" ItemStyle-Width="54px" ItemStyle-VerticalAlign="Top" />
										<asp:BoundField DataField="Product" HeaderText="PRODUCT" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="66px" />
										<asp:BoundField DataField="sProdDescription" HeaderText="PRODUCT" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="330px" />
										<asp:HyperLinkField dataTextfield="Week1Qty" Target="_popup" DataNavigateUrlFields="Product, Wk1Date, ProdType, Length, Color, Sort, Milling, NoPrint, ProductManagedID" DataNavigateUrlFormatString="CatWeekDetails.aspx?p={0}&d={1}&pt={2}&ln={3}&c={4}&st={5}&m={6}&np={7}&w=1&mid={8}" />
										<asp:HyperLinkField dataTextfield="Week2Qty" Target="_popup" DataNavigateUrlFields="Product, Wk2Date, ProdType, Length, Color, Sort, Milling, NoPrint, ProductManagedID" DataNavigateUrlFormatString="CatWeekDetails.aspx?p={0}&d={1}&pt={2}&ln={3}&c={4}&st={5}&m={6}&np={7}&w=2&mid={8}" />
										<asp:HyperLinkField dataTextfield="Week3Qty" Target="_popup" DataNavigateUrlFields="Product, Wk3Date, ProdType, Length, Color, Sort, Milling, NoPrint, ProductManagedID" DataNavigateUrlFormatString="CatWeekDetails.aspx?p={0}&d={1}&pt={2}&ln={3}&c={4}&st={5}&m={6}&np={7}&w=3&mid={8}" />
										<asp:HyperLinkField dataTextfield="Week4Qty" Target="_popup" DataNavigateUrlFields="Product, Wk4Date, ProdType, Length, Color, Sort, Milling, NoPrint, ProductManagedID" DataNavigateUrlFormatString="CatWeekDetails.aspx?p={0}&d={1}&pt={2}&ln={3}&c={4}&st={5}&m={6}&np={7}&w=4&mid={8}" />
										<asp:HyperLinkField dataTextfield="Week5Qty" Target="_popup" DataNavigateUrlFields="Product, Wk5Date, ProdType, Length, Color, Sort, Milling, NoPrint, ProductManagedID" DataNavigateUrlFormatString="CatWeekDetails.aspx?p={0}&d={1}&pt={2}&ln={3}&c={4}&st={5}&m={6}&np={7}&w=5&mid={8}" />
										<asp:HyperLinkField dataTextfield="Week6Qty" Target="_popup" DataNavigateUrlFields="Product, Wk6Date, ProdType, Length, Color, Sort, Milling, NoPrint, ProductManagedID" DataNavigateUrlFormatString="CatWeekDetails.aspx?p={0}&d={1}&pt={2}&ln={3}&c={4}&st={5}&m={6}&np={7}&w=6&mid={8}" />
										<asp:HyperLinkField dataTextfield="Week7Qty" Target="_popup" DataNavigateUrlFields="Product, Wk7Date, ProdType, Length, Color, Sort, Milling, NoPrint, ProductManagedID" DataNavigateUrlFormatString="CatWeekDetails.aspx?p={0}&d={1}&pt={2}&ln={3}&c={4}&st={5}&m={6}&np={7}&w=7&mid={8}" />
										<asp:HyperLinkField dataTextfield="Week8Qty" Target="_popup" DataNavigateUrlFields="Product, Wk8Date, ProdType, Length, Color, Sort, Milling, NoPrint, ProductManagedID" DataNavigateUrlFormatString="CatWeekDetails.aspx?p={0}&d={1}&pt={2}&ln={3}&c={4}&st={5}&m={6}&np={7}&w=8&mid={8}" />
										<asp:HyperLinkField dataTextfield="Week9Qty" Target="_popup" DataNavigateUrlFields="Product, Wk9Date, ProdType, Length, Color, Sort, Milling, NoPrint, ProductManagedID" DataNavigateUrlFormatString="CatWeekDetails.aspx?p={0}&d={1}&pt={2}&ln={3}&c={4}&st={5}&m={6}&np={7}&w=9&mid={8}" />
										<asp:HyperLinkField dataTextfield="Week10Qty" Target="_popup" DataNavigateUrlFields="Product, Wk10Date, ProdType, Length, Color, Sort, Milling, NoPrint, ProductManagedID" DataNavigateUrlFormatString="CatWeekDetails.aspx?p={0}&d={1}&pt={2}&ln={3}&c={4}&st={5}&m={6}&np={7}&w=10&mid={8}" />
										<asp:HyperLinkField dataTextfield="Week11Qty" Target="_popup" DataNavigateUrlFields="Product, Wk11Date, ProdType, Length, Color, Sort, Milling, NoPrint, ProductManagedID" DataNavigateUrlFormatString="CatWeekDetails.aspx?p={0}&d={1}&pt={2}&ln={3}&c={4}&st={5}&m={6}&np={7}&w=11&mid={8}" />
										<asp:HyperLinkField dataTextfield="Week12Qty" Target="_popup" DataNavigateUrlFields="Product, Wk12Date, ProdType, Length, Color, Sort, Milling, NoPrint, ProductManagedID" DataNavigateUrlFormatString="CatWeekDetails.aspx?p={0}&d={1}&pt={2}&ln={3}&c={4}&st={5}&m={6}&np={7}&w=12&mid={8}" />
										<asp:HyperLinkField dataTextfield="Week13Qty" Target="_popup" DataNavigateUrlFields="Product, Wk13Date, ProdType, Length, Color, Sort, Milling, NoPrint, ProductManagedID" DataNavigateUrlFormatString="CatWeekDetails.aspx?p={0}&d={1}&pt={2}&ln={3}&c={4}&st={5}&m={6}&np={7}&w=13&mid={8}" />
										<asp:BoundField DataField="sPrice" HeaderText="List Price" ItemStyle-HorizontalAlign="Right"  ItemStyle-Width="64px" />
										<asp:BoundField DataField="Comments" HeaderText="Comments" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="300px" />
								</Columns>
								<RowStyle BackColor="White" />
								<HeaderStyle BackColor="#0099FF" Font-Bold="True" ForeColor="White" CssClass="headClass" />
							</asp:GridView>
						</div>
						<div id="divBottomBtn" runat="server" style="text-align:center;display:none;padding-top:6px;">
							<table id="tblBottomBtn" style="width:100%;padding:0px;border-spacing:0px">
							<tr>
								<td style="width:33%;">
									<div id="divBottomNotes" runat="server" style="font-size:10pt;font-family:Calibri;">
										<span style="font-weight:bold;">Color Code:</span>&nbsp;Managed&nbsp;<input type="text" value="" style="width:10px;background-color:PaleTurquoise;border:none;" />&nbsp;&nbsp;Amount Highpoint&nbsp;<input type="text" value="" style="width:10px;background-color:MistyRose;border:none;" />
									</div>
								</td>
								<td style="width:34%;text-align:center;">
									<asp:Button ID ="btnPrevPage" runat="server" Text="Prev" CssClass="button blue-gradient glossy" OnClick="btnPrevPage_Click" />&nbsp;&nbsp;
									<asp:Button ID="btnNextPage" runat="server" Text="Next" CssClass="button blue-gradient glossy" OnClick="btnNextPage_Click" />
								</td>
								<td style="width:33%;">
									&nbsp;
								</td>
							</tr>
							</table>
						</div>


						<div id="divLoadingGif" class="loading" runat="server" style="display:none;text-align:center;">
							Loading. Please wait.<br />
							<br />
							<img src="../images/aniLoadingCircle.gif" alt="" />
						</div>
					</div>

					<div id="divPAGEFOOTER" runat="server" class="MainDiv" style="margin-left:8px;">
						<div id="divShowErrorMsg" runat="server" style="width:100%;">
							<asp:Label ID="lblErrorMsg" runat="server" style="color:maroon;font-size:11pt;font-weight:bold;"></asp:Label>
						</div>
					</div>
        
          <br />
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
