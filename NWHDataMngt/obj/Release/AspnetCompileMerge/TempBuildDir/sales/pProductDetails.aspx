<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pProductDetails.aspx.cs" Inherits="DataMngt.page.pProductDetails" %>

<script type="text/javascript">
	function CloseThisWindow() {
		window.open('', '_self').close();
		//window.close();
	}

</script>


<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta http-equiv="X-UA-Compatible" content="IE=10; IE=9; IE=8; IE=7; IE=EDGE" />
  <title>Product Details</title>

	<script type="text/javascript" src="../Scripts/jquery-1.10.2.min.js"></script>
	<script type="text/javascript" src="../Scripts/jquery-ui-min-1.11.1.js"></script>
	<script type="text/javascript" src="../Scripts/jqueryAJAXTransport.js"></script>
	<script type="text/javascript" src="../Scripts/Modernizr-2.6.2.js"></script>

	<link rel="stylesheet" type="text/css" href="../style/Site.css?v=1" />
  <link rel="stylesheet" type="text/css" href="../style/jquery-ui.min-1.11.1.css?v=1" />
  <link rel="stylesheet" type="text/css" href="../style/jquery-ui.structure.min.css?v=1" />
  <link rel="stylesheet" type="text/css" href="../style/jquery-ui.theme.min.css?v=1" />
  <link rel="stylesheet" type="text/css" href="../style/themes/base/jquery-ui.css?v=1" />
	<link rel="stylesheet" type="text/css" href="../style/Dialogs.css?v=1" /> 
	<link rel="stylesheet" type="text/css" href="../style/colors.css?v=1" /> 
	<link rel="stylesheet" type="text/css" href="../style/Controls.css?v=1" /> 
</head>
<body>
  <form id="form1" runat="server">
	<asp:HiddenField ID="hfPageID" runat="server" Value="29" />

  <div id="divPOPUPHEADER" style="width:99%;margin-bottom:0px;margin-top:10px;margin-left:10px;" class="SpecHeaderTitle">
    <strong>Details For:</strong>&nbsp;&nbsp;
    Prod Type:&nbsp<asp:Label ID="lblProdTypeHdr" runat="server"></asp:Label>&nbsp;&bull;&nbsp;
    Product ID:&nbsp<asp:Label ID="lblProductHdr" runat="server"></asp:Label>&nbsp;&bull;&nbsp;
    Target Date:&nbsp<asp:Label ID="lblTDateHdr" runat="server"></asp:Label>&nbsp;-&nbsp;Week:&nbsp;<asp:Label ID="lblTWeek" runat="server" Text=""></asp:Label><br />
		Length:&nbsp;<asp:Label ID="lblLengthP" runat="server">&nbsp;</asp:Label>&nbsp;&bull;&nbsp;
		Color:&nbsp;<asp:Label ID="lblColorP" runat="server">&nbsp;</asp:Label>&nbsp;&bull;&nbsp;
		Sort:&nbsp;<asp:Label ID="lblSortP" runat="server">&nbsp;</asp:Label>&nbsp;&bull;&nbsp;
		Milling:&nbsp;<asp:Label ID="lblMillingP" runat="server">&nbsp;</asp:Label>&nbsp;&bull;&nbsp;
		NoPrint:&nbsp;<asp:Label ID="lblNoPrintP" runat="server">&nbsp;</asp:Label>&nbsp;&bull;&nbsp;
		Master&nbsp;ID:&nbsp;<asp:Label ID="lblMasterID" runat="server"></asp:Label>
  </div>

	<div id="divProductIdent" style="width:99%;margin-bottom:10px;margin-top:0px;margin-left:10px;text-align:center;">
		<label ID="lblProductDescHdr" style="font-weight:bold;font-size:12pt;color:blue;" ></label>Product Descripters:<br />
		<table style="padding:1px;border-spacing:0px;margin:auto auto;">
		<tr>
			<td>
				<table id="tblProductDescs" style="padding:1px;border-spacing:0px;margin:auto auto;">
				<thead>
				<tr>
					<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
						<asp:Label ID="lblDesc1Hdr" runat="server" Text="1"></asp:Label>
					</th>
					<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
						<asp:Label ID="lblDesc2Hdr" runat="server" Text="2"></asp:Label>
					</th>
					<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
						<asp:Label ID="lblDesc3Hdr" runat="server" Text="3"></asp:Label>
					</th>
					<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
						<asp:Label ID="lblDesc4Hdr" runat="server" Text="4"></asp:Label>
					</th>
					<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
						<asp:Label ID="lblDesc5Hdr" runat="server" Text="5"></asp:Label>
					</th>
					<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
						<asp:Label ID="lblDesc6Hdr" runat="server" Text="6"></asp:Label>
					</th>
					<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
						<asp:Label ID="lblDesc7Hdr" runat="server" Text="7"></asp:Label>
					</th>
					<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
						<asp:Label ID="lblDesc8Hdr" runat="server" Text=""></asp:Label>
					</th>
					<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
						<asp:Label ID="lblDesc9Hdr" runat="server" Text=""></asp:Label>
					</th>
					<th class="ColHeaderStd" style="width:70px;padding-left:4px;padding-right:4px;white-space:normal;">
						<asp:Label ID="lblDesc10Hdr" runat="server" Text=""></asp:Label>
					</th>
				</tr>
				</thead>
				<tr>
					<td class="MedTableStd">
						<asp:Label ID="lblDescVal1" runat="server" Text="" CssClass="StdCellContent"></asp:Label>
					</td>
					<td class="MedTableStd">
						<asp:Label ID="lblDescVal2" runat="server" Text="" CssClass="StdCellContent"></asp:Label>
					</td>
					<td class="MedTableStd">
						<asp:Label ID="lblDescVal3" runat="server" Text="" CssClass="StdCellContent"></asp:Label>
					</td>
					<td class="MedTableStd">
						<asp:Label ID="lblDescVal4" runat="server" Text="" CssClass="StdCellContent"></asp:Label>
					</td>
					<td class="MedTableStd">
						<asp:Label ID="lblDescVal5" runat="server" Text="" CssClass="StdCellContent"></asp:Label>
					</td>
					<td class="MedTableStd">
						<asp:Label ID="lblDescVal6" runat="server" Text="" CssClass="StdCellContent"></asp:Label>
					</td>
					<td class="MedTableStd">
						<asp:Label ID="lblDescVal7" runat="server" Text="" CssClass="StdCellContent"></asp:Label>
					</td>
					<td class="MedTableStd">
						<asp:Label ID="lblDescVal8" runat="server" Text="" CssClass="StdCellContent"></asp:Label>
					</td>
					<td class="MedTableStd">
						<asp:Label ID="lblDescVal9" runat="server" Text="" CssClass="StdCellContent"></asp:Label>
					</td>
					<td class="MedTableStd">
						<asp:Label ID="lblDescVal10" runat="server" Text="" CssClass="StdCellContent"></asp:Label>
					</td>
				</tr>
				</table>
			</td>
			<td>
				&nbsp;&nbsp;
			</td>
			<td style="vertical-align:top;">
				Page Size:&nbsp<asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged" style="margin-left: 10px;">
					<asp:ListItem Text="10" Value="10" />
					<asp:ListItem Text="20" Value="20" Selected="True" />
					<asp:ListItem Text="25" Value="25" />
					<asp:ListItem Text="50" Value="50" />
					<asp:ListItem Text="100" Value="100" />
					<asp:ListItem Text="250" Value="250" />
				</asp:DropDownList>
			</td>
		</tr>
		</table>
	</div>

  <div id="divPOPUPMAIN" style="width:99%;text-align:center;margin-left:10px;margin-bottom:10px;" runat="server">
    <div id="divProductDetailsHdr" style="width:100%;text-align:center;margin-bottom:6px;">
			<label id="lblProductDetails" class="MyHeaderLabel" style="">Product Details by Location:</label><br />
    </div>

		<div id="divProductDetailsGrid"	style="width:100%;" runat="server">
			<table id="tblProductDetailsGrid" style="margin:auto auto;" class="BoxShadow" runat="server"><tr><td>
				<asp:GridView ID="gvProductDetails" runat="server" CssClass="GridViewMain" AutoGenerateColumns="false" AllowPaging="true" PageSize="20" OnPageIndexChanged="gvProductDetails_PageIndexChanged"
					OnPageIndexChanging="gvProductDetails_PageIndexChanging">
					<HeaderStyle BackColor="#C3CCF1" BorderColor="Gray" BorderWidth="1px" Font-Bold="true" HorizontalAlign="Center" />
					<Columns>
						<asp:BoundField DataField="loctype" HeaderText="&nbsp;Type&nbsp;" ControlStyle-CssClass="GridViewPadding" ItemStyle-CssClass="StdCellContent" />
						<asp:BoundField DataField="LocCode" HeaderText="&nbsp;Loc&nbsp;" ControlStyle-CssClass="GridViewPadding" ItemStyle-CssClass="StdCellContent" />
						<asp:BoundField DataField="LocName" HeaderText="&nbsp;Location&nbsp;Name&nbsp;" ControlStyle-CssClass="GridViewPadding" ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="StdCellContent" />
						<asp:BoundField DataField="City" HeaderText="&nbsp;City&nbsp;" ControlStyle-CssClass="GridViewPadding" ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="StdCellContent" />
						<asp:BoundField DataField="StProv" HeaderText="&nbsp;State/Prov&nbsp;" ControlStyle-CssClass="GridViewPadding" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="StdCellContent" />
						<asp:BoundField DataField="UOM" HeaderText="&nbsp;UoM&nbsp;" ControlStyle-CssClass="GridViewPadding" ItemStyle-CssClass="StdCellContent" />
						<asp:BoundField DataField="QTY" HeaderText="&nbsp;Qty&nbsp;" ControlStyle-CssClass="GridViewPadding" ItemStyle-CssClass="StdCellContent" />
						<asp:BoundField DataField="OrdQty" HeaderText="&nbsp;Orders&nbsp;" ControlStyle-CssClass="GridViewPadding" ItemStyle-CssClass="StdCellContent" />
						<asp:BoundField DataField="ForecastQty" HeaderText="&nbsp;Forecast&nbsp;" ControlStyle-CssClass="GridViewPadding" ItemStyle-CssClass="StdCellContent" />
						<asp:BoundField DataField="ProdQty" HeaderText="&nbsp;Prod&nbsp;" ControlStyle-CssClass="GridViewPadding" ItemStyle-CssClass="StdCellContent" />
					</Columns>
				</asp:GridView>
			</td></tr></table>
		</div>

		<div id="divShowProdDetailNoRows" style="width:100%;text-align:center;" runat="server">
			<asp:Label ID="lblProdDetailNoRows" Text="No Rows were found." runat="server"></asp:Label>
		</div>
  </div>

  <div id="divPOPUPFOOTER" style="width:99%;text-align:center;margin-left:10px;">
    <button id="btnCLoseThisForm" onclick="javascript:CloseThisWindow();return false;" class="button blue-gradient glossy">Close Window</button><br />
    <asp:Label ID="lblErrorMsg" runat="server" Font-Size="Large" ForeColor="Maroon" Font-Bold="true"></asp:Label>
  </div>
    </form>
</body>
</html>
