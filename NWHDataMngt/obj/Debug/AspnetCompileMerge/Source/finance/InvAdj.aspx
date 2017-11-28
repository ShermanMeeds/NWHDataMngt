<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site.Master" AutoEventWireup="true" CodeBehind="InvAdj.aspx.cs" Inherits="DataMngt.page.InvAdj" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<asp:HiddenField ID="hfPageID" runat="server" Value="22" />

	<script type="text/javascript">
		var jiPageID = 22;

	</script>


<div id="divPAGECONTENT" runat="server" style="width:99%;">

	<div id="divPAGEHDR" style="width:98%;margin-left:10px;">
		<table id="tblPgHdr" style="width:100%;padding:0px;border-spacing:0px;">
		<tr>
			<td style="width:34%;">
				<asp:Label ID="lblInvAjdPage" runat="server" Text="Invoice Adjustment Request" CssClass="LabelGridHdrLarger"></asp:Label>&nbsp;
			</td>
			<td style="width:33%;">
				ID:&nbsp;<asp:Label ID="lblInvAdjIDE" runat="server" Text="0" ForeColor="Blue" Font-Bold="true"></asp:Label>
				Status:&nbsp;<asp:Label ID="lblInvStatusH" runat="server" Text=""></asp:Label>&nbsp;
				<span id="spnSubmitBlock" runat="server" style="display:inline-table;">
					<asp:Button ID="btnSubmitReq" runat="server" Text="Submit" OnClick="btnSubmitReq_Click" CssClass="button blue-gradient glossy" />
				</span>
				<span id="spnSendToComplete" runat="server" style="display:none;">
					<asp:Button ID="btnSendToComp" runat="server" Text="Submit" OnClick="btnSendToComp_Click" CssClass="button blue-gradient glossy" />
				</span>
				<span id="spnCompleteReq" runat="server" style="display:none;">
					<asp:Button ID="btnCompleteReq" runat="server" Text="Submit" OnClick="btnCompleteReq_Click" CssClass="button blue-gradient glossy" />
				</span>
				<asp:Button ID="btnSendToPDF" runat="server" Text="Gen PDF" OnClick="btnSendToPDF_Click" CssClass="button blue-gradient glossy" />

			</td>
			<td style="width:33%;text-align:right;">
				<asp:Button ID="btnNewInvAdj" runat="server" Text="New Inv Adj" OnClick="btnNewInvAdj_Click" />&nbsp;&nbsp;
				<asp:Button ID="btnFindInvAdj" runat="server" Text="Find Inv Adj" OnClick="btnFindInvAdj_Click" />
			</td>
		</tr>
		</table>
		<div id="divFindInvAdj" runat="server" style="width:100%;height:40px;text-align:center;display:none;">
			Invoice Nbr:&nbsp;<asp:TextBox ID="txtFindInvNbr" runat="server" Width="100px" Text=""></asp:TextBox>&nbsp;
			Inv Adj ID:&nbsp;<asp:TextBox ID="txtInvAdjIDE" runat="server" Width="100px" Text=""></asp:TextBox>
			<asp:Button ID="btnFindInvNbr" runat="server" CssClass="button blue-gradient glossy" Text="Find" OnClick="btnFindInvNbr_Click" />&nbsp;&nbsp;&nbsp;
		</div>
	</div>

	<div id="divPAGEMAIN" style="width:98%;margin-left:10px;">

		<table style="border-spacing:0px;padding:0px;">
		<tr>
			<td class="StdTableCellWBorderDarker" style="text-align:center;">
				Date Req.
			</td>
			<td class="StdTableCellWBorderDarker" style="text-align:center;">
				Requested By
			</td>
			<td class="StdTableCellWBorderDarker" style="text-align:center;">
				Credit Rep
			</td>
			<td class="StdTableCellWBorderDarker" style="text-align:center;">
				Sales Lead
			</td>
			<td colspan="3" class="StdTableCellWBorderDarker" style="text-align:center;">
				Shipped From Location Code
			</td>
		</tr>
		<tr>
			<td class="StdTableCellWBorder">
				<asp:TextBox ID="txtDateReqE" Width="100px" runat="server" Text="" CssClass="InputTextWNoBorder"></asp:TextBox>
			</td>
			<td class="StdTableCellWBorder">
				<asp:TextBox ID="txtReqByE" Width="100px" runat="server" Text="" CssClass="InputTextWNoBorder"></asp:TextBox>
			</td>
			<td class="StdTableCellWBorder" style="text-align:right;">
				<asp:DropDownList ID="ddlCreditRepE" runat="server" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
					<asp:ListItem Value="C" Text="Carolyn Gahan"></asp:ListItem>
					<asp:ListItem Value="N" Text="Nicole Hawkins"></asp:ListItem>
					<asp:ListItem Value="S" Text="Shelly Norman"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td class="StdTableCellWBorder" style="text-align:right;">
				<asp:DropDownList ID="ddlSalesLeadE" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td colspan="3" class="StdTableCellWBorder" style="text-align:right;">
				<asp:DropDownList ID="ddlShipFmLocationE" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB">
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
		</tr>
		<tr>
			<td class="StdTableCellWBorderDarker" style="text-align:center;">
				Customer #
			</td>
			<td class="StdTableCellWBorderDarker" style="text-align:center;">
				Customer Name
			</td>
			<td class="StdTableCellWBorderDarker" style="text-align:center;">
				S/O Number
			</td>
			<td class="StdTableCellWBorderDarker" style="text-align:center;">
				Invoice #
			</td>
			<td colspan="3" class="StdTableCellWBorderDarker" style="text-align:center;">
				Reason Code
			</td>
		</tr>
		<tr>
			<td class="StdTableCellWBorder">
				<asp:TextBox ID="txtCustNbrE" Width="100px" runat="server" Text="" CssClass="InputTextWNoBorder"></asp:TextBox>
			</td>
			<td class="StdTableCellWBorder">
				<asp:TextBox ID="txtCustNameE" Width="100px" runat="server" Text="" CssClass="InputTextWNoBorder"></asp:TextBox>
			</td>
			<td class="StdTableCellWBorder">
				<asp:TextBox ID="txtSONbrE" Width="100px" runat="server" Text="" CssClass="InputTextWNoBorder"></asp:TextBox>
			</td>
			<td class="StdTableCellWBorder">
				<asp:TextBox ID="txtInvoiceNbrE" Width="100px" runat="server" Text="" CssClass="InputTextWNoBorder" OnTextChanged="txtInvoiceNbrE_TextChanged" ></asp:TextBox>
			</td>
			<td colspan="3" class="StdTableCellWBorder" style="text-align:right;">
				<asp:DropDownList ID="ddlReasonCodeE" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
		</tr>
		<tr>
			<td colspan="7" class="TableSeperatorRow" style="line-height:10px;height:10px;">
				&nbsp;
			</td>
		</tr>
		<tr style="border:1px solid gray;">
			<td colspan="3" style="text-align:center;font-size:11pt;color:darkblue;border:1px solid gray;">
				Required Document	
			</td>
			<td colspan="4" style="text-align:center;font-size:11pt;color:darkblue;border:1px solid gray;">
				Reason for Credit/Invoice Adjustment:
			</td>
		</tr>
		<tr>
			<td colspan="3" class="StdTableCellWBorder" style="text-align:right;">
				Invoice Adjustment:&nbsp;
				<asp:CheckBox ID="chkInvoiceAdjE" runat="server" Checked="false" />
			</td>
			<td colspan="4" rowspan="4" class="StdTableCellWBorder">
				<asp:TextBox ID="txaReasonForAdjE" runat="server" CssClass="InputTextWNoBorder" Height="80px" Width="98%" TextMode="MultiLine"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td colspan="3" class="StdTableCellWBorder" style="text-align:right;">
				Manual Credit / Debit Note:&nbsp;
				<asp:CheckBox ID="chkManualCDNoteE" runat="server" Checked="false" />
			</td>
		</tr>
		<tr>
			<td colspan="3" class="StdTableCellWBorderDarker" style="text-align:center;font-size:11pt;font-weight:bold;" >
				Customer Requirement:
			</td>
		</tr>
		<tr>
			<td colspan="3" class="StdTableCellWBorder" style="text-align:right;">
				&nbsp;<asp:Label ID="lblCustReqCopyInv2" Text="Customer REQUIRES COPY of revised invoice:" runat="server" ForeColor="DarkRed" Font-Bold="true"></asp:Label>&nbsp;<asp:CheckBox ID="chkCustReqCopyE" runat="server" Checked="false" />
			</td>
		</tr>
		<tr>
			<td colspan="7" class="TableSeperatorRow" style="line-height:10px;height:10px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td colspan="2" class="StdTableCellWBorderDarker" style="text-align:center;">
				<asp:Button ID="btnAddItemLine" runat="server" Text="Add Line" CssClass="button blue-gradient glossy" OnClick="btnAddItemLine_Click" />
				&nbsp;
			</td>
			<td colspan="2" class="StdTableCellWBorderDarker" style="text-align:center;font-weight:bold;">
				Quantity
			</td>
			<td colspan="2" class="StdTableCellWBorderDarker"style="text-align:center;font-weight:bold;">
				Price
			</td>
			<td rowspan="2" class="StdTableCellWBorderDarker">
				TOTAL CR/DB AMOUNT
			</td>
		</tr>
		<tr>
			<td class="StdTableCellWBorderDarker" style="text-align:center;">
				ProdType & Code
			</td>
			<td class="StdTableCellWBorderDarker" style="text-align:center;">
				Item Description
			</td>
			<td class="StdTableCellWBorderDarker" style="text-align:center;">
				Original
			</td>
			<td class="StdTableCellWBorderDarker" style="text-align:center;">
				Revised
			</td>
			<td class="StdTableCellWBorderDarker" style="text-align:center;">
				Original
			</td>
			<td class="StdTableCellWBorderDarker" style="text-align:center;">
				Revised
			</td>
		</tr>
		<tr id="rwProd1">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlProdType1" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtProdDesc1" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigQty1" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevQty1" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigPrice1" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevPrice1" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:TextBox ID="txtTotalAmount1" runat="server" CssClass="InputTextWNoBorder" Text="" Width="120px"></asp:TextBox>
			</td>
		</tr>
		<tr id="rwProd2">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlProdType2" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtProdDesc2" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigQty2" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevQty2" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigPrice2" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevPrice2" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:TextBox ID="txtTotalAmount2" runat="server" CssClass="InputTextWNoBorder" Text="" Width="120px"></asp:TextBox>
			</td>
		</tr>
		<tr id="rwProd3">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlProdType3" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtProdDesc3" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigQty3" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevQty3" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigPrice3" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevPrice3" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:TextBox ID="txtTotalAmount3" runat="server" CssClass="InputTextWNoBorder" Text="" Width="120px"></asp:TextBox>
			</td>
		</tr>
		<tr id="rwProd4">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlProdType4" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtProdDesc4" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigQty4" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevQty4" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigPrice4" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevPrice4" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:TextBox ID="txtTotalAmount4" runat="server" CssClass="InputTextWNoBorder" Text="" Width="120px"></asp:TextBox>
			</td>
		</tr>
		<tr id="rwProd5">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlProdType5" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtProdDesc5" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigQty5" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevQty5" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigPrice5" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevPrice5" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:TextBox ID="txtTotalAmount5" runat="server" CssClass="InputTextWNoBorder" Text="" Width="120px"></asp:TextBox>
			</td>
		</tr>
		<tr id="rwProd6" style="display:none;">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlProdType6" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtProdDesc6" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigQty6" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevQty6" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigPrice6" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevPrice6" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:TextBox ID="txtTotalAmount6" runat="server" CssClass="InputTextWNoBorder" Text="" Width="120px"></asp:TextBox>
			</td>
		</tr>
		<tr id="rwProd7" style="display:none;">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlProdType7" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtProdDesc7" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigQty7" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevQty7" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigPrice7" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevPrice7" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:TextBox ID="txtTotalAmount7" runat="server" CssClass="InputTextWNoBorder" Text="" Width="120px"></asp:TextBox>
			</td>
		</tr>
		<tr id="rwProd8" style="display:none;">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlProdType8" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtProdDesc8" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigQty8" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevQty8" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigPrice8" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevPrice8" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:TextBox ID="txtTotalAmount8" runat="server" CssClass="InputTextWNoBorder" Text="" Width="120px"></asp:TextBox>
			</td>
		</tr>
		<tr id="rwProd9" style="display:none;">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlProdType9" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtProdDesc9" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigQty9" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevQty9" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigPrice9" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevPrice9" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:TextBox ID="txtTotalAmount9" runat="server" CssClass="InputTextWNoBorder" Text="" Width="120px"></asp:TextBox>
			</td>
		</tr>
		<tr id="rwProd10" style="display:none;">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlProdType10" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtProdDesc10" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigQty10" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevQty10" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigPrice10" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevPrice10" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:TextBox ID="txtTotalAmount10" runat="server" CssClass="InputTextWNoBorder" Text="" Width="120px"></asp:TextBox>
			</td>
		</tr>
		<tr id="rwProd11" style="display:none;">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlProdType11" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtProdDesc11" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigQty11" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevQty11" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigPrice11" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevPrice11" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:TextBox ID="txtTotalAmount11" runat="server" CssClass="InputTextWNoBorder" Text="" Width="120px"></asp:TextBox>
			</td>
		</tr>
		<tr id="rwProd12" style="display:none;">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlProdType12" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtProdDesc12" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigQty12" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevQty12" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigPrice12" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevPrice12" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:TextBox ID="txtTotalAmount12" runat="server" CssClass="InputTextWNoBorder" Text="" Width="120px"></asp:TextBox>
			</td>
		</tr>
		<tr id="rwProd13" style="display:none;">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlProdType13" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtProdDesc13" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigQty13" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevQty13" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigPrice13" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevPrice13" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:TextBox ID="txtTotalAmount13" runat="server" CssClass="InputTextWNoBorder" Text="" Width="120px"></asp:TextBox>
			</td>
		</tr>
		<tr id="rwProd14" style="display:none;">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlProdType14" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtProdDesc14" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigQty14" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevQty14" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigPrice14" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevPrice14" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:TextBox ID="txtTotalAmount14" runat="server" CssClass="InputTextWNoBorder" Text="" Width="120px"></asp:TextBox>
			</td>
		</tr>
		<tr id="rwProd15" style="display:none;">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlProdType15" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtProdDesc15" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigQty15" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevQty15" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigPrice15" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevPrice15" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:TextBox ID="txtTotalAmount15" runat="server" CssClass="InputTextWNoBorder" Text="" Width="120px"></asp:TextBox>
			</td>
		</tr>
		<tr id="rwProd16" style="display:none;">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlProdType16" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtProdDesc16" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigQty16" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevQty16" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigPrice16" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevPrice16" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:TextBox ID="txtTotalAmount16" runat="server" CssClass="InputTextWNoBorder" Text="" Width="120px"></asp:TextBox>
			</td>
		</tr>
		<tr id="rwProd17" style="display:none;">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlProdType17" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtProdDesc17" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigQty17" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevQty17" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigPrice17" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevPrice17" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:TextBox ID="txtTotalAmount17" runat="server" CssClass="InputTextWNoBorder" Text="" Width="120px"></asp:TextBox>
			</td>
		</tr>
		<tr id="rwProd18" style="display:none;">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlProdType18" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtProdDesc18" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigQty18" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevQty18" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigPrice18" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevPrice18" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:TextBox ID="txtTotalAmount18" runat="server" CssClass="InputTextWNoBorder" Text="" Width="120px"></asp:TextBox>
			</td>
		</tr>
		<tr id="rwProd19" style="display:none;">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlProdType19" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtProdDesc19" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigQty19" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevQty19" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigPrice19" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevPrice19" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:TextBox ID="txtTotalAmount19" runat="server" CssClass="InputTextWNoBorder" Text="" Width="120px"></asp:TextBox>
			</td>
		</tr>
		<tr id="rwProd20" style="display:none;">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlProdType20" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtProdDesc20" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigQty20" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevQty20" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigPrice20" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRevPrice20" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:TextBox ID="txtTotalAmount20" runat="server" CssClass="InputTextWNoBorder" Text="" Width="120px"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td class="StdTableCellWBorderDarker" colspan="4" rowspan="3">
				&nbsp;
			</td>
			<td  class="StdTableCellWBorder" colspan="2" style="text-align:right;background-color:aquamarine;">
				Original Invoice Amount:&nbsp;
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtOrigInvoiceAmt" runat="server" CssClass="InputNbrWNoBorder" Text="" Width="120px" ></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td  class="StdTableCellWBorder" colspan="2" style="text-align:right;background-color:aquamarine;">
				Adjusted Invoice Amount:&nbsp;
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtAdjInvoiceAmt" runat="server" CssClass="InputNbrWNoBorder" Text="" Width="120px"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td  class="StdTableCellWBorder" colspan="2" style="text-align:right;background-color:aquamarine;">
				Adjustment Amount:&nbsp;
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtAdjustmentAmt" runat="server" CssClass="InputNbrWNoBorder" Text="" Width="120px"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td colspan="7" class="TableSeperatorRow" style="line-height:10px;height:10px;">
				<hr style="border:5px solid blue;" />
			</td>
		</tr>
		<tr id="rwRtnManifest">
			<td class="StdTableCellWBorder" colspan="2" style="font-weight:bold;font-size:11pt;">
				&nbsp;RETURN MANIFEST:&nbsp;&nbsp;<asp:CheckBox ID="chkRtnManifest" runat="server" Checked="false" />
			</td>
			<td  class="StdTableCellWBorder" colspan="5" style="background-color:#555555;">
				&nbsp;
			</td>
		</tr>
		<tr id="rwRtnManifestHdr">
			<td class="StdTableCellWBorderDarker" style="text-align:center;font-weight:bold;">
				Requested Rtn Date
			</td>
			<td  class="StdTableCellWBorderDarker" style="text-align:center;font-weight:bold;">
				Requested By
			</td>
			<td  class="StdTableCellWBorderDarker" style="text-align:center;font-weight:bold;">
				Credit Rep
			</td>
			<td  class="StdTableCellWBorderDarker" style="text-align:center;font-weight:bold;">
				Sales Lead
			</td>
			<td  class="StdTableCellWBorderDarker" style="text-align:center;font-weight:bold;" colspan="3">
				Shipped FROM Location Code:
			</td>
		</tr>
		<tr id="rwRtnManifest1">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtReqRtnDateM" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRequestedByM" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:right;">
				<asp:DropDownList ID="ddlCreditRepM" runat="server" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
					<asp:ListItem Value="C" Text="Carolyn Gahan"></asp:ListItem>
					<asp:ListItem Value="N" Text="Nicole Hawkins"></asp:ListItem>
					<asp:ListItem Value="S" Text="Shelly Norman"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:right;">
				<asp:DropDownList ID="ddlSalesLeadM" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB">
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:right;" colspan="3">
				<asp:DropDownList ID="ddlShipFMLocationM" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
		</tr>
		<tr id="rwRtnManifestHdr2">
			<td class="StdTableCellWBorderDarker" style="text-align:center;font-weight:bold;">
				Customer #
			</td>
			<td  class="StdTableCellWBorderDarker" style="text-align:center;font-weight:bold;">
				Customer Name
			</td>
			<td  class="StdTableCellWBorderDarker" style="text-align:center;font-weight:bold;">
				S/O Number
			</td>
			<td  class="StdTableCellWBorderDarker" style="text-align:center;font-weight:bold;">
				Invoice #
			</td>
			<td  class="StdTableCellWBorderDarker" style="text-align:center;font-weight:bold;" colspan="3">
				Reason Code:
			</td>
		</tr>
		<tr id="rwRtnManifest2">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtCustomerNbrM" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtCustNameM" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtSONbrM" runat="server" Text="" Width="100%" CssClass="InputTextWNoBorder"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtInvoiceNbrM" runat="server" Text="" Width="100%" CssClass="InputTextWNoBorder"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:right;" colspan="3">
				<asp:DropDownList ID="ddlReasonCodeM" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB">
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
		</tr>
		<tr>
			<td colspan="7" class="TableSeperatorRow" style="line-height:10px;height:10px;">
				&nbsp;
			</td>
		</tr>
		<tr id="rwRtnManifestHdr3">
			<td class="StdTableCellWBorderDarker" style="text-align:center;font-weight:bold;">
				Actual Rtn Date
			</td>
			<td  class="StdTableCellWBorderDarker" style="text-align:center;font-weight:bold;">
				Carrier Used for Return
			</td>
			<td  class="StdTableCellWBorderDarker" style="text-align:center;font-weight:bold;">
				Freight Rate for Return
			</td>
			<td  class="StdTableCellWBorderDarker" style="text-align:center;font-weight:bold;">
				Transfer Order #
			</td>
			<td  class="StdTableCellWBorderDarker" style="text-align:center;font-weight:bold;" colspan="3">
				Shipped TO Location Code:
			</td>
		</tr>
		<tr id="rwRtnManifest3">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtActRtnDateM" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:right;">
				<asp:DropDownList ID="ddlRtnCarrierM" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB">
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtRtnFreightRateM" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTransOrderNbrM" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:right;" colspan="3">
				<asp:DropDownList ID="ddlShipTOLocationM" runat="server" AppendDataBoundItems="true" CssClass="ControlNoBorderWB">
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
		</tr>
		<tr id="rwRtnManifestHdr4">
			<td class="StdTableCellWBorder" style="text-align:center;font-weight:bold;font-size:11pt;background-color:aquamarine;" colspan="3">
				Required Customer Documents:
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;font-weight:bold;font-size:11pt;background-color:aquamarine;" colspan="4">
				Reason For Return:
			</td>
		</tr>
		<tr id="rwRtnManifest4">
			<td class="StdTableCellWBorder" style="text-align:center;" colspan="3">
				<asp:Label ID="lblCustReqCopyRevisedInv" Text="Customer REQUIRES COPY of revised invoice:" runat="server" ForeColor="DarkRed" Font-Bold="true"></asp:Label>&nbsp;<asp:CheckBox ID="chkRevisedInvCopyM" Checked="false" runat="server" />
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;" colspan="4" rowspan="4">
				<asp:TextBox ID="txaRtnReasonM" TextMode="MultiLine" runat="server" Height="100px" Width="99%" CssClass="InputTextWNoBorder"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td class="StdTableCellWBorder" style="line-height:10px;height:10px;background-color:#555555;" colspan="3">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td class="StdTableCellWBorder" style="text-align:right;" colspan="2">
				Manual Inventory Adjustment:
			</td>
			<td class="StdTableCellWBorder" style="line-height:10px;height:10px;text-align:center;">
				<asp:CheckBox ID="chkManInvAdjMI" runat="server" Checked="false" />
			</td>
		</tr>
		<tr>
			<td class="StdTableCellWBorder" style="text-align:right;" colspan="2">
				AP Notification Needed:
			</td>
			<td class="StdTableCellWBorder" style="line-height:10px;height:10px;text-align:center;">
				<asp:CheckBox ID="chkAPNotificationMI" runat="server" Checked="false" />
			</td>
		</tr>
		<tr>
			<td class="StdTableCellWBorder" style="text-align:right;" colspan="7">
				<asp:Button ID="btnAddNewTicket" runat="server" Text="Add Line" CssClass="button blue-gradient glossy" OnClick="btnAddNewTicket_Click" />
			</td>
		</tr>
		<tr id="rwTicketPckgHdr">
			<td class="StdTableCellWBorderDarker" style="text-align:center;">
				ProdType & Code
			</td>
			<td  class="StdTableCellWBorderDarker" style="text-align:center;">
				Ticket #'s
			</td>
			<td  class="StdTableCellWBorderDarker" style="text-align:center;">
				Quantity
			</td>
			<td  class="StdTableCellWBorderDarker" style="text-align:center;">
				Total # Pkg/Pcs
			</td>
			<td  class="StdTableCellWBorderDarker" style="text-align:center;">
				Qty Checked In
			</td>
			<td  class="StdTableCellWBorderDarker" style="text-align:center;">
				Red Tag?
			</td>
			<td  class="StdTableCellWBorderDarker" style="text-align:center;">
				Inventory Adj?
			</td>
		</tr>
		<tr id="rwTicketPckg1">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlTKProdType1" runat="server" AppendDataBoundItems="true" CssClass="InputTextWNoBorder">
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKTicketNbr1" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKQty1" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKTotalPkgCount1" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKQtyCheckedIn1" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:Checkbox ID="chkTKRedTag1" runat="server" Checked="false"></asp:Checkbox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:Checkbox ID="chkTKInvAdj1" runat="server" Checked="false"></asp:Checkbox>
			</td>
		</tr>
		<tr id="rwTicketPckg2">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlTKProdType2" runat="server" AppendDataBoundItems="true" CssClass="InputTextWNoBorder">
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKTicketNbr2" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKQty2" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKTotalPkgCount2" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKQtyCheckedIn2" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:Checkbox ID="chkTKRedTag2" runat="server" Checked="false"></asp:Checkbox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:Checkbox ID="chkTKInvAdj2" runat="server" Checked="false"></asp:Checkbox>
			</td>
		</tr>
		<tr id="rwTicketPckg3" runat="server">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlTKProdType3" runat="server" AppendDataBoundItems="true" CssClass="InputTextWNoBorder">
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKTicketNbr3" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKQty3" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKTotalPkgCount3" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKQtyCheckedIn3" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:Checkbox ID="chkTKRedTag3" runat="server" Checked="false"></asp:Checkbox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:Checkbox ID="chkTKInvAdj3" runat="server" Checked="false"></asp:Checkbox>
			</td>
		</tr>
		<tr id="rwTicketPckg4" runat="server">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlTKProdType4" runat="server" AppendDataBoundItems="true" CssClass="InputTextWNoBorder">
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKTicketNbr4" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKQty4" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKTotalPkgCount4" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKQtyCheckedIn4" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:Checkbox ID="chkTKRedTag4" runat="server" Checked="false"></asp:Checkbox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:Checkbox ID="chkTKInvAdj4" runat="server" Checked="false"></asp:Checkbox>
			</td>
		</tr>
		<tr id="rwTicketPckg5" runat="server">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlTKProdType5" runat="server" AppendDataBoundItems="true" CssClass="InputTextWNoBorder">
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKTicketNbr5" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKQty5" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKTotalPkgCount5" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKQtyCheckedIn5" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:Checkbox ID="chkTKRedTag5" runat="server" Checked="false"></asp:Checkbox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:Checkbox ID="chkTKInvAdj5" runat="server" Checked="false"></asp:Checkbox>
			</td>
		</tr>
		<tr id="rwTicketPckg6" runat="server" style="display:none;">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlTKProdType6" runat="server" AppendDataBoundItems="true" CssClass="InputTextWNoBorder">
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKTicketNbr6" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKQty6" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKTotalPkgCount6" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKQtyCheckedIn6" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:Checkbox ID="chkTKRedTag6" runat="server" Checked="false"></asp:Checkbox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:Checkbox ID="chkTKInvAdj6" runat="server" Checked="false"></asp:Checkbox>
			</td>
		</tr>
		<tr id="rwTicketPckg7" runat="server" style="display:none;">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlTKProdType7" runat="server" AppendDataBoundItems="true" CssClass="InputTextWNoBorder">
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKTicketNbr7" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKQty7" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKTotalPkgCount7" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKQtyCheckedIn7" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:Checkbox ID="chkTKRedTag7" runat="server" Checked="false"></asp:Checkbox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:Checkbox ID="chkTKInvAdj7" runat="server" Checked="false"></asp:Checkbox>
			</td>
		</tr>
		<tr id="rwTicketPckg8" runat="server" style="display:none;">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlTKProdType8" runat="server" AppendDataBoundItems="true" CssClass="InputTextWNoBorder">
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKTicketNbr8" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKQty8" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKTotalPkgCount8" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKQtyCheckedIn8" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:Checkbox ID="chkTKRedTag8" runat="server" Checked="false"></asp:Checkbox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:Checkbox ID="chkTKInvAdj8" runat="server" Checked="false"></asp:Checkbox>
			</td>
		</tr>
		<tr id="rwTicketPckg9" runat="server" style="display:none;">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlTKProdType9" runat="server" AppendDataBoundItems="true" CssClass="InputTextWNoBorder">
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKTicketNbr9" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKQty9" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKTotalPkgCount9" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKQtyCheckedIn9" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:Checkbox ID="chkTKRedTag9" runat="server" Checked="false"></asp:Checkbox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:Checkbox ID="chkTKInvAdj9" runat="server" Checked="false"></asp:Checkbox>
			</td>
		</tr>
		<tr id="rwTicketPckg10" runat="server" style="display:none;">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlTKProdType10" runat="server" AppendDataBoundItems="true" CssClass="InputTextWNoBorder">
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKTicketNbr10" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKQty10" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKTotalPkgCount10" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKQtyCheckedIn10" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:Checkbox ID="chkTKRedTag10" runat="server" Checked="false"></asp:Checkbox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:Checkbox ID="chkTKInvAdj10" runat="server" Checked="false"></asp:Checkbox>
			</td>
		</tr>
		<tr id="rwTicketPckg11" runat="server" style="display:none;">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlTKProdType11" runat="server" AppendDataBoundItems="true" CssClass="InputTextWNoBorder">
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKTicketNbr11" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKQty11" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKTotalPkgCount11" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKQtyCheckedIn11" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:Checkbox ID="chkTKRedTag11" runat="server" Checked="false"></asp:Checkbox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:Checkbox ID="chkTKInvAdj11" runat="server" Checked="false"></asp:Checkbox>
			</td>
		</tr>
		<tr id="rwTicketPckg12" runat="server" style="display:none;">
			<td class="StdTableCellWBorder" style="text-align:center;">
				<asp:DropDownList ID="ddlTKProdType12" runat="server" AppendDataBoundItems="true" >
					<asp:ListItem Value="0" Text="Not Selected" Selected="True"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKTicketNbr12" runat="server" CssClass="InputTextWNoBorder" Text="" Width="200px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKQty12" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKTotalPkgCount12" runat="server" Text="" Width="80px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:TextBox ID="txtTKQtyCheckedIn12" runat="server" CssClass="InputTextWNoBorder" Text="" Width="100px"></asp:TextBox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;">
				<asp:Checkbox ID="chkTKRedTag12" runat="server" Checked="false"></asp:Checkbox>
			</td>
			<td  class="StdTableCellWBorder" style="text-align:center;background-color:#DDDDDD;">
				<asp:Checkbox ID="chkTKInvAdj12" runat="server" Checked="false"></asp:Checkbox>
			</td>
		</tr>
		<tr>
			<td colspan="7" class="TableSeperatorRow" style="line-height:16px;height:16px;">
				<hr style="border:5px solid blue;" />
			</td>
		</tr>
		<tr>
			<td style="text-align:right;">
				Loaded By:&nbsp;
			</td>
			<td>
				<asp:TextBox ID="txtLoadedByZ" runat="server" Text="" Width="120px"></asp:TextBox>
			</td>
			<td style="text-align:right;">
				Signature:&nbsp;
			</td>
			<td colspan="2">
				<asp:TextBox ID="txtLoadSignatureZ" runat="server" Text="" Width="200px"></asp:TextBox>
			</td>
			<td style="text-align:right;">
				Date:&nbsp;
			</td>
			<td>
				<asp:TextBox ID="txtLoadDateZ" runat="server" Text="" Width="90px"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td style="text-align:right;">
				Driver:&nbsp;
			</td>
			<td>
				<asp:TextBox ID="txtDriverZ" runat="server" Text="" Width="120px"></asp:TextBox>
			</td>
			<td style="text-align:right;">
				Signature:&nbsp;
			</td>
			<td colspan="2">
				<asp:TextBox ID="txtDriverSignatureZ" runat="server" Text="" Width="200px"></asp:TextBox>
			</td>
			<td style="text-align:right;">
				Date:&nbsp;
			</td>
			<td>
				<asp:TextBox ID="txtDriverDateZ" runat="server" Text="" Width="90px"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td style="text-align:right;">
				Received By:&nbsp;
			</td>
			<td>
				<asp:TextBox ID="txtReceivedByZ" runat="server" Text="" Width="120px"></asp:TextBox>
			</td>
			<td style="text-align:right;">
				Signature:&nbsp;
			</td>
			<td colspan="2">
				<asp:TextBox ID="txtReceivedSignatureZ" runat="server" Text="" Width="200px"></asp:TextBox>
			</td>
			<td style="text-align:right;">
				Date:&nbsp;
			</td>
			<td>
				<asp:TextBox ID="txtReceivedDateZ" runat="server" Text="" Width="90px"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td colspan="7" style="text-align:center;font-style:italic;">
				Product Returns must be verified and match quantity/tag numbers prior to signing.
			</td>
		</tr>
		</table>
	</div>

	<div id="divPAGEFTR" style="width:98%;margin-left:10px;">
		<asp:Label ID="lblStatusMsg" runat="server" CssClass="StdErrorMode"></asp:Label>
	</div>

</div>


</asp:Content>
