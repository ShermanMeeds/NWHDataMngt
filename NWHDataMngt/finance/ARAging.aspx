<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site.Master" AutoEventWireup="true" CodeBehind="ARAging.aspx.cs" Inherits="DataMngt.page.APAging" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<asp:HiddenField ID="hfPageID" runat="server" Value="28" />

	<script type="text/javascript">
		var jiPageID = 28;

		$(document).keypress(function (e) {
			if (e.keyCode === 13) {
				e.preventDefault();
				return false;
			}
		});
	</script>

	<div id="divPAGEHEADER" style="width:98%;margin-left:10px;">
		<div id="divMainPageHdrLbl" style="width:100%;text-align:center;">
      <asp:Label ID="lblMainHdr" runat="server" Text="AR AGING REPORT" CssClass="MyHeaderLabel"></asp:Label>
		</div>
	</div>

	<div id="divPAGEMAIN" style="width:98%;margin-left:10px;">
		<div id="divFilterBar" style="width:100%;text-align:center;">
			<div id="divFilterBar" class="TableFilterHdrCell" style="width:99%;text-align:center;vertical-align:top;margin-bottom:10px;line-height:28px;">
				<table id="tblFilters" style="padding:0px;border-spacing:0px;margin:auto auto;">
				<tr>
					<td style="text-align:left;vertical-align:top;">
						<asp:Label ID="lblMainFilterBar" runat="server" style="color:blue;font-size:12pt;font-weight:bold;">Filters:</asp:Label><span style="padding-right: 20px">&nbsp;</span>
					</td>
					<td style="text-align:left;vertical-align:top;">
						Customer Nbr:&nbsp;
					</td>
					<td style="text-align:left;vertical-align:top;">
						<asp:TextBox ID="txtCustNbrF" runat="server" Width="120px"></asp:TextBox>&nbsp;&nbsp;
					</td>
					<td style="text-align:left;vertical-align:top;">
						&nbsp;
					</td>
					<td style="text-align:right;vertical-align:top;">
						Cust Name:&nbsp;
					</td>
					<td style="text-align:left;vertical-align:top;">
						<asp:TextBox ID="txtCustomerF" runat="server" Width="120px"></asp:TextBox>
					</td>
					<td style="text-align:left;vertical-align:top;">
						&nbsp;
					</td>
					<td style="text-align:right;vertical-align:top;">
						Sales&nbsp;Person:&nbsp;
					</td>
					<td style="text-align:left;vertical-align:top;">
						<asp:ListBox ID="lbxSalesPersonF" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false" CssClass="ListBoxFilter" >
							<asp:ListItem Text="ALL" Value="0" Selected="True"></asp:ListItem>
						 </asp:ListBox>
					</td>
					<td style="text-align:left;vertical-align:top;">
						&nbsp;
					</td>
					<td style="text-align:right;vertical-align:top;">
						Sales&nbsp;Group:&nbsp;
					</td>
					<td style="text-align:left;vertical-align:top;">
						<asp:ListBox ID="lbxSalesGroupF" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false" CssClass="ListBoxFilter">
							<asp:ListItem Text="ALL" Value="0" Selected="True"></asp:ListItem>
            </asp:ListBox>
					</td>
				</tr>
				<tr>
					<td style="text-align:left;vertical-align:top;">
						&nbsp;
					</td>
					<td style="text-align:right;vertical-align:top;">
						AR&nbsp;Type:&nbsp;
					</td>
					<td style="text-align:left;vertical-align:top;">
						<asp:ListBox ID="lbxARTypeF" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false" CssClass="ListBoxFilter">
							<asp:ListItem Text="ALL" Value="0" Selected="True"></asp:ListItem>
            </asp:ListBox>
					</td>
					<td style="text-align:left;vertical-align:top;">
						&nbsp;
					</td>
					<td style="text-align:right;vertical-align:top;">
						Credit&nbsp;Controller:&nbsp;
					</td>
					<td style="text-align:left;vertical-align:top;">
						<asp:ListBox ID="lbxControllerF" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false" CssClass="ListBoxFilter" >
							<asp:ListItem Text="ALL" Value="0" Selected="True"></asp:ListItem>
						</asp:ListBox>
					</td>
					<td style="text-align:left;vertical-align:top;">
						&nbsp;
					</td>
					<td style="text-align:right;vertical-align:top;">
						Credit&nbsp;Group:&nbsp;
					</td>
					<td style="text-align:left;vertical-align:top;">
						<asp:ListBox ID="lbxCreditGroupF" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false" CssClass="ListBoxFilter" >
							<asp:ListItem Text="ALL" Value="0" Selected="True"></asp:ListItem>
						</asp:ListBox>
					</td>
					<td style="text-align:left;vertical-align:top;">
						&nbsp;
					</td>
					<td style="text-align:right;vertical-align:top;">
						Payment&nbsp;Terms:&nbsp;
					</td>
					<td style="text-align:left;vertical-align:top;">
						<asp:ListBox ID="lbxPaymentTermsF" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false" CssClass="ListBoxFilter" >
							<asp:ListItem Text="ALL" Value="0" Selected="True"></asp:ListItem>
						</asp:ListBox>
					</td>
				</tr>
				<tr>
					<td style="text-align:left;vertical-align:top;">
						&nbsp;
					</td>
					<td style="text-align:right;vertical-align:top;">
						Currency:&nbsp;
					</td>
					<td style="text-align:left;vertical-align:top;">
						<asp:DropDownList ID="ddlCurrencyF" runat="server" AppendDataBoundItems="true">
							<asp:ListItem Text="ALL" Value="0" Selected="True"></asp:ListItem>
							<asp:ListItem Text="USD" Value="USD"></asp:ListItem>
							<asp:ListItem Text="Euro" Value="EU"></asp:ListItem>
						</asp:DropDownList>
					</td>
					<td style="text-align:left;vertical-align:top;">
						&nbsp;
					</td>
					<td style="text-align:right;vertical-align:top;">
						Threshold:&nbsp;
					</td>
					<td style="text-align:left;vertical-align:top;">
						<asp:DropDownList ID="ddlThresholdF" runat="server" AppendDataBoundItems="true">
							<asp:ListItem Text="ALL" Value="0" Selected="True"></asp:ListItem>
							<asp:ListItem Text="16 days or above" Value="1"></asp:ListItem>
							<asp:ListItem Text="31 days or above" Value="2"></asp:ListItem>
							<asp:ListItem Text="61 days or above" Value="3"></asp:ListItem>
							<asp:ListItem Text="91 days or above" Value="4"></asp:ListItem>
						</asp:DropDownList>
					</td>
					<td style="text-align:left;vertical-align:top;">
						&nbsp;
					</td>
					<td style="text-align:right;vertical-align:top;">
						Branch:&nbsp;
					</td>
					<td style="text-align:left;vertical-align:top;">
						<asp:ListBox ID="lbxBranchYardF" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false" CssClass="ListBoxFilter" >
							<asp:ListItem Text="ALL" Value="0" Selected="True"></asp:ListItem>
						</asp:ListBox>
					</td>
					<td style="text-align:left;vertical-align:top;">
						&nbsp;
					</td>
					<td style="text-align:right;vertical-align:top;">
						Country:&nbsp;
					</td>
					<td style="text-align:left;vertical-align:top;">
						<asp:ListBox ID="lbxCountryF" runat="server" AppendDataBoundItems="true" SelectionMode="Multiple" AutoPostBack="false" CssClass="ListBoxFilter" >
							<asp:ListItem Text="ALL" Value="0" Selected="True"></asp:ListItem>
						</asp:ListBox>
					</td>
				</tr>
				<tr>
					<td style="text-align:left;vertical-align:top;">
						&nbsp;
					</td>
					<td colspan="6" style="text-align:center;">
						Source:&nbsp;
						<asp:DropDownList ID="ddlSourceTypeF" runat="server">
							<asp:ListItem Value="0" Text="ALL" Selected="True"></asp:ListItem>
							<asp:ListItem Value="LT" Text="LumberTrack"></asp:ListItem>
							<asp:ListItem Value="ITL" Text="ITL Only"></asp:ListItem>
						</asp:DropDownList>&nbsp;&nbsp;&bull;&nbsp;&nbsp;
						Earliest Invoice Date:&nbsp;
						<asp:TextBox ID="txtBeginInvDateF" runat="server" Width="100"></asp:TextBox>&nbsp;&nbsp;&bull;&nbsp;&nbsp;
						<label style="margin-left: 5px;">Items per Page:</label>
						<asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged" style="margin-left: 10px;">
							<asp:ListItem Text="10" Value="10" />
							<asp:ListItem Text="20" Value="20" Selected="True" />
							<asp:ListItem Text="25" Value="25" />
							<asp:ListItem Text="50" Value="50" />
							<asp:ListItem Text="100" Value="100" />
							<asp:ListItem Text="250" Value="250" />
						</asp:DropDownList>
					</td>
					<td style="text-align:left;vertical-align:top;">
						&nbsp;
					</td>
					<td colspan="4" style="text-align:center;">
						<asp:Button ID="btnRefreshData" runat="server" CssClass="button blue-gradient glossy" Width="140px" Text="Refresh Data" OnClick="btnRefreshData_Click" />&nbsp;
						<asp:Button ID="btnResetDefaultF" runat="server" CssClass="button blue-gradient glossy" Width="140px" Text="Reset Defaults" OnClick="btnResetDefaultF_Click" />&nbsp;&nbsp;&nbsp;
						<asp:Button ID="btnExportToExcel" runat="server" CssClass="button blue-gradient glossy" Width="140px" Text="Export to Excel" ForeColor="LightGreen" OnClick="btnExportToExcel_Click" />&nbsp;
						<asp:Button ID="btnExportToPDF" runat="server" CssClass="button blue-gradient glossy" Width="140px" Text="Export to PDF" ForeColor="LightGreen" OnClick="btnExportToPDF_Click" />
					</td>
				</tr>
				</table>

			</div>
		</div>

    <asp:Label ID="lblInvoiceGrid" Text="Invoices in Aging" runat="server" CssClass="LabelGridHdrStd"></asp:Label><br />

    <asp:GridView ID="gvInvoiceList" runat="server" AllowPaging="true" AllowSorting="true" AutoGenerateColumns="false" BorderColor="Gray" CssClass="xGridViewTS" PageSize="20" 
			OnRowCommand="gvInvoiceList_RowCommand" OnRowDataBound="gvInvoiceList_RowDataBound"
      OnPageIndexChanged="gvInvoiceList_PageIndexChanged" OnPageIndexChanging="gvInvoiceList_PageIndexChanging">
      <HeaderStyle CssClass="ColHeaderStd" />
			<PagerStyle ForeColor="Black" HorizontalAlign="Center" BackColor="#C6C3C6" />
      <Columns>
        <asp:BoundField DataField="Customer" HeaderText="Customer" ItemStyle-CssClass="GridViewPadding" />
        <asp:BoundField DataField="CustomerName" HeaderText="Customer Name" ItemStyle-CssClass="GridViewPadding" />
        <asp:BoundField DataField="sDueDate" HeaderText="Due Date" ItemStyle-CssClass="GridViewPadding" />
        <asp:BoundField DataField="Currency" HeaderText="Currency" ItemStyle-CssClass="GridViewPadding" />
        <asp:BoundField DataField="terms" HeaderText="TermsID" ItemStyle-CssClass="GridViewPadding" />
        <asp:BoundField DataField="termsDesc" HeaderText="Terms Description" ItemStyle-CssClass="GridViewPadding" />
        <asp:BoundField DataField="TotalAmt" HeaderText="Total Amount" ItemStyle-CssClass="GridViewPadding" DataFormatString="{0:c}" />
        <asp:BoundField DataField="Src" HeaderText="Source" ItemStyle-CssClass="GridViewPadding" />
        <asp:BoundField DataField="CredCntrlr" HeaderText="Credit Controller" ItemStyle-CssClass="GridViewPadding" />
        <asp:BoundField DataField="Day0to1" HeaderText="Days 0-1" ItemStyle-CssClass="GridViewPadding" DataFormatString="{0:c}" />
        <asp:BoundField DataField="Day2to15" HeaderText="Days 2-15" ItemStyle-CssClass="GridViewPadding" DataFormatString="{0:c}" />
        <asp:BoundField DataField="Day16to30" HeaderText="Days 16-30" ItemStyle-CssClass="GridViewPadding" DataFormatString="{0:c}" />
        <asp:BoundField DataField="Day31to60" HeaderText="Days 31-60" ItemStyle-CssClass="GridViewPadding" DataFormatString="{0:c}" />
        <asp:BoundField DataField="Day61to90" HeaderText="Days 61-90" ItemStyle-CssClass="GridViewPadding" DataFormatString="{0:c}" />
        <asp:BoundField DataField="Day91plus" HeaderText="Days 91+" ItemStyle-CssClass="GridViewPadding" DataFormatString="{0:c}" />
				<asp:BoundField DataField="sDisputed" HeaderText="Disputed" ItemStyle-CssClass="GridViewPadding" />
				<asp:BoundField DataField="PayTrend" HeaderText="Pay Trend" ItemStyle-CssClass="GridViewPadding" DataFormatString="{0:0.0}" />
      </Columns>
    </asp:GridView>

		<div id="divPaginationView" style="width:100%;text-align:center;">
			Page <%=gvInvoiceList.PageIndex+1 %> of <%=gvInvoiceList.PageCount %>
		</div>

		<div id="divInvoiceNotes" style="width:100%;" class="SmallerTextBlock">
			<table id="tblInvoiceNotes" style="padding:0px;border-spacing:0px">
			<tr>
				<td colspan="2">
					Notes:&nbsp;
				</td>
			</tr>
			<tr>
				<td>
					1.&nbsp;
				</td>
				<td>
					Default view shows all invoices with aging amounts.
				</td>
			</tr>
			</table>
		</div>

	</div>

	<div id="divPAGEFOOTER" style="width:98%;margin-left:10px;">
		<div id="divShowErrorMsg" runat="server" style="width:100%;">
			<asp:Label ID="lblErrorMsg" runat="server" style="color:maroon;font-size:11pt;font-weight:bold;"></asp:Label>
		</div>
	</div>

</asp:Content>
