<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site.Master" AutoEventWireup="true" CodeBehind="WurthStyleTag.aspx.cs" Inherits="DataMngt.prod.WurthStyleTag" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<asp:HiddenField ID="hfPageID" runat="server" Value="25" />

	<style type="text/css">
		.PageStatusPg {
			margin-right:30px;
		}
	</style>

	<script type="text/javascript">
		var jiPageID = 25;
		var jsOrderNbr = '';
		
		$.when($.ready).then(function () {
			$('#MainContent_txtOrderNbr').focus();
		});

		function OpenPrintPage(pg) {
			jsOrderNbr = $('#MainContent_txtOrderNbr').val();
			var WurthOnly = '0';
			var chk = document.getElementById('MainContent_chkWurthOnly');
			if (chk.checked === true) { WurthOnly = '1';}
			window.open('WurthTagPreview.aspx?p=' + pg.toString() + '&o=' + jsOrderNbr + '&w=' + WurthOnly, '_popup', '');
		}
	</script>

	<div id="divPAGEHDR" style="width:99%;margin-left:10px;" runat="server">

	</div>

	<div id="divPAGEMAIN" style="width:99%;margin-left:10px;" runat="server">

		<table id="tblOrderDataHolder" style="width:100%;">
		<tr>
			<td>

				<table id="tblOrderData" style="padding:2px;border-spacing:0px;">
				<tr>
					<td style="vertical-align:top;padding-bottom:14px;"><asp:Label ID="lblTopHeader" ForeColor="Blue" Font-Bold="true" runat="server" Text="ORDER DATA:"></asp:Label>&nbsp;&nbsp;</td>
					<td style="text-align:right;vertical-align:top;padding-bottom:14px;">Order Nbr:&nbsp;</td>
					<td style="vertical-align:top;padding-bottom:14px;" colspan="3">
						<asp:TextBox id="txtOrderNbr" runat="server" AutoPostBack="true" OnTextChanged="txtOrderNbr_TextChanged" Font-Bold="true" ></asp:TextBox>
					</td>
					<td style="text-align:left;" colspan="2">
						Wurth Items Only:&nbsp;
						<asp:CheckBox ID="chkWurthOnly" Checked="false" runat="server" />
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td style="vertical-align:top;">Customer:&nbsp;</td>
					<td style="vertical-align:top;">
						<asp:TextBox ID="txtCustomerName" runat="server" Width="340" BackColor="Wheat"></asp:TextBox>
					</td>
					<td>&nbsp;&nbsp;&nbsp;</td>
					<td style="vertical-align:top;" rowspan="2">Location:&nbsp;</td>
					<td style="line-height:28px;vertical-align:top;" rowspan="2">
						<asp:TextBox ID="txtLocType" runat="server" Width="400" BackColor="Wheat"></asp:TextBox><br />
						<asp:TextBox ID="txtLocationName" runat="server" Width="400" BackColor="Wheat"></asp:TextBox>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td style="vertical-align:top;">Nbr Tags:&nbsp;</td>
					<td style="vertical-align:top;">
						<asp:TextBox ID="txtNbrItems" runat="server" Width="50" BackColor="Wheat"></asp:TextBox>
					</td>
					<td>&nbsp;&nbsp;&nbsp;</td>
				</tr>
				<tr>
					<td colspan="7" style="text-align:center;">
						<div id="divPrintButtonGroup" style="width:100%;text-align:center;margin-top:10px;margin-bottom:10px;">
							<span id="spnPrintBtn1" style="display:none;" runat="server"><asp:Button ID="btnPrintWurthTag" runat="server" Text="Print Items 1-20" CssClass="button blue-gradient glossy" OnClientClick="javascript:OpenPrintPage(0);return false;" Width="130" /><br /></span>
							<span id="spnPrintBtn2" style="display:none;" runat="server"><asp:Button ID="btnPrintWurthTag2" runat="server" Text="Print Items 21-40" CssClass="button blue-gradient glossy" OnClientClick="javascript:OpenPrintPage(1);return false;" Width="130" /><br /></span>
							<span id="spnPrintBtn3" style="display:none;" runat="server"><asp:Button ID="btnPrintWurthTag3" runat="server" Text="Print Items 41-60" CssClass="button blue-gradient glossy" OnClientClick="javascript:OpenPrintPage(2);return false;" Width="130" /><br /></span>
							<span id="spnPrintBtn4" style="display:none;" runat="server"><asp:Button ID="btnPrintWurthTag4" runat="server" Text="Print Items 61-80" CssClass="button blue-gradient glossy" OnClientClick="javascript:OpenPrintPage(3);return false;" Width="130" /><br /></span>
							<span id="spnPrintBtn5" style="display:none;" runat="server"><asp:Button ID="btnPrintWurthTag5" runat="server" Text="Print Items 81-100" CssClass="button blue-gradient glossy" OnClientClick="javascript:OpenPrintPage(4);return false;" Width="130" /><br /></span>
							<span id="spnPrintBtn6" style="display:none;" runat="server"><asp:Button ID="btnPrintWurthTag6" runat="server" Text="Print Items 101-120" CssClass="button blue-gradient glossy" OnClientClick="javascript:OpenPrintPage(5);return false;" Width="130" /></span>
						</div>
					</td>
				</tr>
				</table>

			</td>
			<td style="text-align:right;vertical-align:top;">
				<asp:Label ID="lblPageStatus" ForeColor="DarkGray" Font-Bold="true" Font-Italic="true" Text="" runat="server" CssClass="PageStatusPg"></asp:Label>
			</td>
		</tr>
		</table>

		<div id="divOrderItemGrid" style="width:100%;margin-bottom:20px;">
			<div id="divOrderItemGridHdr" style="width:100%;">
				<asp:Label ID="lblOrderItemGridHdr" font-bold="true" ForeColor="Blue" Font-Size="12pt" runat="server" Text="Order Item Details"></asp:Label>
			</div>
			<div id="divOrderItemGridData" style="width:100%;">
				<asp:GridView ID="gvOrderItems" runat="server" AutoGenerateColumns="false" >
					<HeaderStyle CssClass="TableHdrCell" />
					<Columns>
						<asp:BoundField DataField="ProdCode" HeaderText="ProdCode" ItemStyle-Width="70" ItemStyle-HorizontalAlign="Center" />
						<asp:BoundField DataField="ProdDesc" HeaderText="Description" ItemStyle-Width="200" />
						<asp:BoundField DataField="desc1" HeaderText="Desc 1" ItemStyle-Width="60" />
						<asp:BoundField DataField="desc2" HeaderText="Desc 2" ItemStyle-Width="68" />
						<asp:BoundField DataField="desc3" HeaderText="Desc 3" ItemStyle-Width="68" />
						<asp:BoundField DataField="desc4" HeaderText="Desc 4" ItemStyle-Width="70" />
						<asp:BoundField DataField="desc5" HeaderText="Desc 5" ItemStyle-Width="68" />
						<asp:BoundField DataField="desc6" HeaderText="Desc 6" ItemStyle-Width="68" />
						<asp:BoundField DataField="desc7" HeaderText="Desc 7" ItemStyle-Width="66" />
						<asp:BoundField DataField="ProdWidth" HeaderText="Width" ItemStyle-Width="62" />
						<asp:BoundField DataField="sProdLength" HeaderText="Length" ItemStyle-Width="64" />
						<asp:BoundField DataField="ProdColor" HeaderText="Color" ItemStyle-Width="68" />
						<asp:BoundField DataField="ProdSort" HeaderText="Sort" ItemStyle-Width="72" />
						<asp:BoundField DataField="ProdMilling" HeaderText="Milling" ItemStyle-Width="80" />
						<asp:BoundField DataField="UOM" HeaderText="UOM" ItemStyle-Width="50" ItemStyle-HorizontalAlign="Center" />
						<asp:BoundField DataField="TagNbr" HeaderText="Tag#" ItemStyle-Width="66" ItemStyle-HorizontalAlign="Right" />
						<asp:BoundField DataField="TagVol" HeaderText="Qty" ItemStyle-Width="80" ItemStyle-HorizontalAlign="Right" />
						<asp:BoundField DataField="sShipDate" HeaderText="Ship Date" ItemStyle-Width="82" ItemStyle-HorizontalAlign="Center" />
						<asp:BoundField DataField="sWurthItem" HeaderText="Wurth" ItemStyle-Width="60" ItemStyle-HorizontalAlign="Center" />
					</Columns>
				</asp:GridView>
			</div>
		</div>

		<div id="divPrinterSetup" style="width:100%;margin-left:40px;margin-right:40px;">
			<hr style="color:cadetblue" />
			<label style="font-weight:bold;color:maroon;">Browser/Printer&nbsp;setup:</label>&nbsp;Both the browser and printer must be set up properly for the Wurth tags to print properly:<br />
			All headers and footers in the browser should be turned off.<br />
			Margins for IE11 and FireFox browsers should be set to .25" for all sides. Margins in the Chrome Browser must be equal to or less than .4".<br />
			Printing should be set to letter/Portrait, black and white, and two-sided printing must be turned off.<br /><br />
			Page view in the browser should be set with Zoom = 100% (standard size) and Text Size set to Medium. This are the default settings.<br />
			In IE11, right-click the mouse over the page and select Print Preview to edit many options.<br />	
			In Chrome, right-click the mouse over the document to print and select Print; you will need to edit the left column values.<br />
			In FireFox, there is an icon in the upper right corner with three horizontal lines; click on that and your page will be shown in print-preview mode, allowing you to edit the settings at the top.<br />
			<hr style="color:cadetblue" />
		</div>

	</div>

	<div id="divPAGEFTR" style="width:99%;margin-left:10px;" runat="server">
		<div id="divErrorMsg" style="width:100%;">
			<asp:Label ID="lblErrorMsg"	style="color:maroon;font-weight:bold;font-size:12pt;" runat="server"></asp:Label>
		</div>
	</div>

</asp:Content>
