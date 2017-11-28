<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site.Master" AutoEventWireup="true" CodeBehind="CreditExcReq.aspx.cs" Inherits="DataMngt.page.CreditExcReq" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<asp:HiddenField ID="hfPageID" runat="server" Value="23" />

	<script type="text/javascript">
		var jiPageID = 23;

	</script>

<div id="divPAGECONTENT" runat="server" style="width:99%;">

	<div id="divPAGEHDR" style="width:98%;margin-left:10px;">
		<table id="tblPgHdr" style="width:100%;padding:0px;border-spacing:0px;">
		<tr>
			<td style="width:34%;">
				<asp:Label ID="lblInvAjdPage" runat="server" Text="Credit Exception Request" CssClass="LabelGridHdrLarger"></asp:Label>&nbsp;
			</td>
			<td style="width:33%;">
				ID:&nbsp;<asp:Label ID="lblCreditExcIDE" runat="server" Text="0" ForeColor="Blue" Font-Bold="true"></asp:Label>
				Status:&nbsp;<asp:Label ID="lblCERStatusH" runat="server" Text=""></asp:Label>&nbsp;
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
				<asp:Button ID="btnNewCERAdj" runat="server" Text="New C.E.R." OnClick="btnNewCERAdj_Click" />&nbsp;&nbsp;
				<asp:Button ID="btnFindCERAdj" runat="server" Text="Find C.E.R." OnClick="btnFindCERAdj_Click" />
			</td>
		</tr>
		</table>
		<div id="divFindCER" runat="server" style="width:100%;height:40px;text-align:center;display:none;">
			Customer:&nbsp;<asp:TextBox ID="txtFindCustomerCE" runat="server" Width="100px" Text=""></asp:TextBox>&nbsp;
			CER ID:&nbsp;<asp:TextBox ID="txtCERIDE" runat="server" Width="100px" Text=""></asp:TextBox>
			<asp:Button ID="btnFindCER" runat="server" CssClass="button blue-gradient glossy" Text="Find" OnClick="btnFindCER_Click" />&nbsp;&nbsp;&nbsp;
		</div>
	</div>

	<div id="divPAGEMAIN" style="width:98%;margin-left:10px;">

		<table style="border-spacing:0px;padding:0px;">
		<tr>
			<td style="border-bottom:1px solid gray;border-left:1px solid gray;border-top:1px solid gray;">
				&nbsp;Customer Name:&nbsp;
			</td>
			<td colspan="3" style="border-bottom:1px solid gray;border-right:1px solid gray;border-top:1px solid gray;">
				<asp:TextBox ID="txtCustName" runat="server" ReadOnly="true" Width="300px"></asp:TextBox>
			</td>
			<td style="border-bottom:1px solid gray;border-left:1px solid gray;border-top:1px solid gray;">
				&nbsp;Account #:&nbsp;
			</td>
			<td colspan="2" style="border-bottom:1px solid gray;border-right:1px solid gray;border-top:1px solid gray;">
				<asp:TextBox ID="txtAccountNbr" runat="server" ReadOnly="true" Width="200px"></asp:TextBox>
			</td>
			<td style="border-bottom:1px solid gray;border-left:1px solid gray;border-top:1px solid gray;" colspan="2">
				&nbsp;Request Date:&nbsp;
			</td>
			<td style="border-bottom:1px solid gray;border-right:1px solid gray;border-top:1px solid gray;">
				<asp:TextBox ID="txtReqDate" runat="server" ReadOnly="true" Width="100px"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td style="border-bottom:1px solid gray;border-left:1px solid gray;border-top:1px solid gray;">
				&nbsp;Address:&nbsp;
			</td>
			<td colspan="2" style="border-bottom:1px solid gray;border-right:1px solid gray;border-top:1px solid gray;">
				<asp:TextBox ID="txtCustAddress" runat="server" ReadOnly="true" Width="200px"></asp:TextBox>
			</td>
			<td style="border-bottom:1px solid gray;border-left:1px solid gray;border-top:1px solid gray;">
				&nbsp;City/State:&nbsp;
			</td>
			<td colspan="3" style="border-bottom:1px solid gray;border-right:1px solid gray;border-top:1px solid gray;">
				<asp:TextBox ID="txtCustCityState" runat="server" ReadOnly="true" Width="300px"></asp:TextBox>
			</td>
			<td style="border-bottom:1px solid gray;border-left:1px solid gray;border-top:1px solid gray;">
				&nbsp;Zip Code:&nbsp;
			</td>
			<td colspan="2" style="border-bottom:1px solid gray;border-right:1px solid gray;border-top:1px solid gray;">
				<asp:TextBox ID="txtCustZip" runat="server" ReadOnly="true" Width="200px"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td style="border-bottom:1px solid gray;border-left:1px solid gray;border-top:1px solid gray;">
				&nbsp;Customer&nbsp;Contact:&nbsp;
			</td>
			<td colspan="2" style="border-bottom:1px solid gray;border-right:1px solid gray;border-top:1px solid gray;">
				<asp:TextBox ID="txtCustContact" runat="server" ReadOnly="true" Width="200px"></asp:TextBox>
			</td>
			<td style="border-bottom:1px solid gray;border-left:1px solid gray;border-top:1px solid gray;">
				&nbsp;Phone:&nbsp;
			</td>
			<td colspan="3" style="border-bottom:1px solid gray;border-right:1px solid gray;border-top:1px solid gray;">
				<asp:TextBox ID="txtCustPhone" runat="server" ReadOnly="true" Width="300px"></asp:TextBox>
			</td>
			<td style="border-bottom:1px solid gray;border-left:1px solid gray;border-top:1px solid gray;">
				&nbsp;Email:&nbsp;
			</td>
			<td colspan="2" style="border-bottom:1px solid gray;border-right:1px solid gray;border-top:1px solid gray;">
				<asp:TextBox ID="txtCustEmail" runat="server" ReadOnly="true" Width="200px"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td style="border-bottom:1px solid gray;border-left:1px solid gray;border-top:1px solid gray;">
				&nbsp;Sales&nbsp;Lead:&nbsp;
			</td>
			<td colspan="2" style="border-bottom:1px solid gray;border-right:1px solid gray;border-top:1px solid gray;">
				<asp:TextBox ID="txtSalesLead" runat="server" ReadOnly="true" Width="200px"></asp:TextBox>
			</td>
			<td style="border-bottom:1px solid gray;border-left:1px solid gray;border-top:1px solid gray;">
				&nbsp;Credit&nbsp;Limit:&nbsp;
			</td>
			<td colspan="3" style="border-bottom:1px solid gray;border-right:1px solid gray;border-top:1px solid gray;">
				<asp:TextBox ID="txtCreditLimit" runat="server" ReadOnly="true" Width="300px"></asp:TextBox>
			</td>
			<td style="border-bottom:1px solid gray;border-left:1px solid gray;border-top:1px solid gray;">
				&nbsp;Terms:&nbsp;
			</td>
			<td colspan="2" style="border-bottom:1px solid gray;border-right:1px solid gray;border-top:1px solid gray;">
				<asp:TextBox ID="txtCustTerms" runat="server" ReadOnly="true" Width="200px"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td style="border-bottom:2px solid gray;border-left:1px solid gray;border-top:1px solid gray;">
				&nbsp;Annual&nbsp;Sales:&nbsp;
			</td>
			<td colspan="2" style="border-bottom:2px solid gray;border-right:1px solid gray;border-top:1px solid gray;">
				<asp:TextBox ID="txtAnnualSales" runat="server" ReadOnly="true" Width="200px"></asp:TextBox>
			</td>
			<td colspan="2" style="border-bottom:2px solid gray;border-left:1px solid gray;border-top:1px solid gray;">
				&nbsp;Account&nbsp;Balance:&nbsp;
			</td>
			<td colspan="2" style="border-bottom:2px solid gray;border-right:1px solid gray;border-top:1px solid gray;">
				<asp:TextBox ID="txtAcctBalance" runat="server" ReadOnly="true" Width="200px"></asp:TextBox>
			</td>
			<td style="border-bottom:2px solid gray;border-left:1px solid gray;border-top:1px solid gray;">
				&nbsp;Pay&nbsp;Trend:&nbsp;
			</td>
			<td colspan="2" style="border-bottom:2px solid gray;border-right:1px solid gray;border-top:1px solid gray;">
				<asp:TextBox ID="txtPayTrend" runat="server" ReadOnly="true" Width="200px"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td colspan="10" style="height:10px;font-size:8pt;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td colspan="10" style="background-color:lightgray;">
				&nbsp;Decision for increased Credit Limit/Terms Exceptions&nbsp;(when data does not support increase or extended terms)
			</td>
		</tr>
		<tr>
			<td colspan="10" style="height:10px;font-size:8pt;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td colspan="2">
				&nbsp;Current&nbsp;Financials:&nbsp;
			</td>
			<td colspan="3">
				<asp:DropDownList ID="ddlCurrentFinancials" runat="server" >
					<asp:ListItem Value="2" Text="Unselected" Selected="True"></asp:ListItem>
					<asp:ListItem Value="1" Text="Yes"></asp:ListItem>
					<asp:ListItem Value="0" Text="No"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td>
				&nbsp;Product&nbsp;Type:&nbsp;
			</td>
			<td colspan="4">
				<asp:TextBox ID="txtProductType" runat="server" Width="300px"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td colspan="10" style="height:10px;font-size:8pt;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td colspan="2">
				&nbsp;Additional&nbsp;Credit&nbsp;Needed:&nbsp;
			</td>
			<td colspan="3">
				$<asp:TextBox ID="txtAddtlCreditNeeded" runat="server" Width="140px"></asp:TextBox>
			</td>
			<td colspan="2">
				&nbsp;Requested&nbsp;Credit&nbsp;Limit:&nbsp;
			</td>
			<td colspan="3">
				<asp:TextBox ID="txtReqCreditLimit" runat="server" Width="140px"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td colspan="10" style="height:10px;font-size:8pt;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td colspan="2">
				&nbsp;Extended&nbsp;Credit&nbsp;Limit:&nbsp;
			</td>
			<td colspan="2">
				$<asp:TextBox ID="txtExtCreditLimit" runat="server" Width="140px"></asp:TextBox>
			</td>
			<td colspan="6">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td colspan="10" style="height:10px;font-size:8pt;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;Requested&nbsp;Terms:&nbsp;
			</td>
			<td>
				<asp:TextBox ID="txtReqTerms1" runat="server" Width="50px"></asp:TextBox>
			</td>
			<td colspan="4">
				<asp:TextBox ID="txtReqTerms2" runat="server" Width="300px"></asp:TextBox>
			</td>
			<td>
				&nbsp;Approved:&nbsp;
			</td>
			<td colspan="3">
				<asp:DropDownList ID="ddlApproved" runat="server">
					<asp:ListItem Value="2" Text="Unselected" Selected="True"></asp:ListItem>
					<asp:ListItem Value="1" Text="Yes"></asp:ListItem>
					<asp:ListItem Value="0" Text="No"></asp:ListItem>
				</asp:DropDownList>
			</td>
		</tr>
		<tr>
			<td colspan="10" style="height:16px;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td colspan="3">
				&nbsp;Is&nbsp;the&nbsp;Credit&nbsp;Limit&nbsp;temporary:&nbsp;
			</td>
			<td colspan="2">
				<asp:DropDownList ID="ddlLimitTemporary" runat="server">
					<asp:ListItem Value="2" Text="Unselected" Selected="True"></asp:ListItem>
					<asp:ListItem Value="1" Text="Yes"></asp:ListItem>
					<asp:ListItem Value="0" Text="No"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td>
				&nbsp;Start&nbsp;Date:&nbsp;
			</td>
			<td>
				<asp:TextBox ID="txtStartDate" runat="server" Width="100px"></asp:TextBox>
			</td>
			<td>
				&nbsp;End&nbsp;Date:&nbsp;
			</td>
			<td colspan="2">
				<asp:TextBox ID="txtEndDate" runat="server" Width="100px"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td colspan="10" style="height:10px;font-size:8pt;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td colspan="3">
				&nbsp;Is&nbsp;the&nbsp;Exception&nbsp;in&nbsp;Terms&nbsp;temporary:&nbsp;
			</td>
			<td colspan="2">
				<asp:DropDownList ID="ddlExpInTermsTemporary" runat="server">
					<asp:ListItem Value="2" Text="Unselected" Selected="True"></asp:ListItem>
					<asp:ListItem Value="1" Text="Yes"></asp:ListItem>
					<asp:ListItem Value="0" Text="No"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td>
				&nbsp;Start&nbsp;Date:&nbsp;
			</td>
			<td>
				<asp:TextBox ID="TextBox1" runat="server" Width="100px"></asp:TextBox>
			</td>
			<td>
				&nbsp;End&nbsp;Date:&nbsp;
			</td>
			<td colspan="2">
				<asp:TextBox ID="TextBox2" runat="server" Width="100px"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td colspan="10" style="height:10px;font-size:8pt;border-bottom:2px solid gray;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td colspan="10" style="height:360px;border-bottom:2px solid gray;font-size:9pt;">
				<asp:Label ID="lblComments" Font-Bold="true" Text="Comments:" runat="server"></asp:Label>&nbsp;(Reason for Approved Credit when data does not support. Reason for Temporary increase in credit line or Exception for terms change)<br />
				<asp:TextBox ID="txtComments" Height="350px" Width="100%" TextMode="MultiLine" Text="" runat="server"></asp:TextBox>
			</td>
		</tr>
		<tr>
			<td colspan="10" style="background-color:lightgray;text-align:center;font-weight:bold;font-size:12pt;">
				&nbsp;Approvals&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;Credit&nbsp;Manager:&nbsp;
			</td>
			<td colspan="5">
				<asp:Label ID="lblCreditManagerAppr" runat="server"></asp:Label>
			</td>
			<td>
				&nbsp;Date:&nbsp;
			</td>
			<td colspan="3">
				<asp:Label ID="lblCreditMngrApprDate" runat="server"></asp:Label>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;Sales&nbsp;Lead:&nbsp;
			</td>
			<td colspan="5">
				<asp:Label ID="lblSalesLeadAppr" runat="server"></asp:Label>
			</td>
			<td>
				&nbsp;Date:&nbsp;
			</td>
			<td colspan="3">
				<asp:Label ID="lblSalesLeadDate" runat="server"></asp:Label>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;VP&nbsp;of&nbsp;Sales:&nbsp;
			</td>
			<td colspan="5">
				<asp:Label ID="lblVPSalesAppr" runat="server"></asp:Label>
			</td>
			<td>
				&nbsp;Date:&nbsp;
			</td>
			<td colspan="3">
				<asp:Label ID="lblVPSalesDate" runat="server"></asp:Label>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;CFO:&nbsp;
			</td>
			<td colspan="5">
				<asp:Label ID="lblCFOAppr" runat="server"></asp:Label>
			</td>
			<td>
				&nbsp;Date:&nbsp;
			</td>
			<td colspan="3">
				<asp:Label ID="lblCFODate" runat="server"></asp:Label>
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;CEO:&nbsp;
			</td>
			<td colspan="5">
				<asp:Label ID="lblCEOAppr" runat="server"></asp:Label>
			</td>
			<td>
				&nbsp;Date:&nbsp;
			</td>
			<td colspan="3">
				<asp:Label ID="lblCEODate" runat="server"></asp:Label>
			</td>
		</tr>
		<tr>
			<td colspan="10" style="height:10px;font-size:8pt;">
				&nbsp;
			</td>
		</tr>
		<tr>
			<td>
				&nbsp;LumberTrack Updated:&nbsp;
			</td>
			<td colspan="5">
				<asp:Label ID="lblLTUpdatedBy" runat="server"></asp:Label>
			</td>
			<td>
				&nbsp;Date:&nbsp;
			</td>
			<td colspan="3">
				<asp:Label ID="lblLTUpdatedDate" runat="server"></asp:Label>
			</td>
		</tr>
		<tr>
			<td colspan="10" style="height:10px;font-size:8pt;border-bottom:2px solid gray;">
				&nbsp;
			</td>
		</tr>
	</div>

	<div id="divPAGEFTR" style="width:98%;margin-left:10px;">
		<asp:Label ID="lblStatusMsg" runat="server" CssClass="StdErrorMode"></asp:Label>
	</div>

</div>

</asp:Content>
