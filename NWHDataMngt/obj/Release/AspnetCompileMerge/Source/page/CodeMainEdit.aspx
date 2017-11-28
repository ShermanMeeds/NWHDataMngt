<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site.Master" AutoEventWireup="true" CodeBehind="CodeMainEdit.aspx.cs" Inherits="DataMngt.page.CodeMainEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<asp:HiddenField ID="hfPageID" runat="server" Value="11" />

	<div id="divPAGEHEADER" runat="server" style="width:99%;text-align:center;margin-bottom:12px;">
		<asp:Label ID="lblPageHdrTitle" runat="server" Font-Bold="true" Font-Size="16pt" Font-Names="Tahoma">Code List</asp:Label> (Paginated)<br />
		<table style="border:1px solid gray;padding:0px;border-spacing:0px;margin:auto auto;"><tr><td>
		<table id="tblListFilters" style="background-color:antiquewhite;border-spacing:0px;padding:2px;">
		<tr>
			<td colspan="8" style="text-align:center;">
				<span runat="server" style="font-weight:bold;color:darkgreen;font-size:12pt;">List&nbsp;Filters:&nbsp;</span>
			</td>
		</tr>
		<tr>
			<td>
				Application Area:&nbsp;
			</td>
			<td>
				<asp:DropDownList ID="ddlAppAreaF" runat="server">
					<asp:ListItem Value="0" Text="All" Selected="True"></asp:ListItem>
					<asp:ListItem Value="Cat" Text="Cat"></asp:ListItem>
					<asp:ListItem Value="Mstr" Text="Master Data"></asp:ListItem>
        </asp:DropDownList>
			</td>
			<td style="width:50px;">
				&nbsp;
			</td>
			<td>
				Code&nbsp;Group:&nbsp;
			</td>
			<td>
				<asp:DropDownList ID="ddlCodeGroupF" runat="server">
					<asp:ListItem Value="0" Text="All" Selected="True"></asp:ListItem>
					<asp:ListItem Value="CatGrade" Text="Cat Grade"></asp:ListItem>
					<asp:ListItem Value="CatThickness" Text="Cat Thickness"></asp:ListItem>
					<asp:ListItem Value="CatSpecies" Text="Cat Species"></asp:ListItem>
        </asp:DropDownList>
			</td>
			<td style="width:50px;">
				&nbsp;
			</td>
			<td>
				Active Status:&nbsp;
			</td>
			<td>
				<asp:DropDownList ID="ddlActiveStatusF" runat="server">
					<asp:ListItem Value="2" Text="All" Selected="True"></asp:ListItem>
					<asp:ListItem Value="1" Text="Active"></asp:ListItem>
					<asp:ListItem Value="0" Text="Inactive"></asp:ListItem>
        </asp:DropDownList>
			</td>
		</tr>
		<tr>
			<td colspan="8">
				<div id="divFilterButtons" style="width:100%;text-align:center;margin-top:6px;">
					<asp:Button ID="btnRequeryData" runat="server" OnClick="btnRequeryData_Click" Text="Refresh Data" />
				</div>
			</td>
		</tr>
		</table>
		</td></tr></table>
	</div>

	<div id="divPAGECONTENT" runat="server" style="width:99%;">
		<div id="divDataGridMAIN" runat="server" style="width:100%;">
			<div id="divDataGridHdr" runat="server" style="width:100%;text-align:center;">
			
				<table id="tblDataGridHdr" style="margin:auto auto;width:660px;" runat="server">
				<tr>
					<td style="width:50%;text-align:left;">
						<asp:Label ID="lblDataGridHdr" runat="server" ForeColor="Blue" Font-Bold="true" Font-Size="14pt">Codes:</asp:Label>&nbsp;&nbsp;&nbsp;
					</td>
					<td style="width:50%;text-align:right;">
						&nbsp;&nbsp;&nbsp;Page&nbsp;Size:&nbsp;
						<asp:DropDownList ID="ddlPageSize" runat="server" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
							<asp:ListItem Value="10" Text="10 lines"></asp:ListItem>
							<asp:ListItem Value="20" Text="20 lines" Selected="True"></asp:ListItem>
							<asp:ListItem Value="30" Text="30 Lines"></asp:ListItem>
							<asp:ListItem Value="40" Text="40 lines"></asp:ListItem>
							<asp:ListItem Value="50" Text="50 lines"></asp:ListItem>
							<asp:ListItem Value="100" Text="100 Lines"></asp:ListItem>
						</asp:DropDownList>
					</td>
				</tr>
				</table>
			
			</div>
		
			<div id="divDataGrid" runat="server" style="width:100%;text-align:center;">
				<table style="padding:0px;border-spacing:0px;margin:auto auto;"><tr><td>
				<asp:GridView ID="gvCodeList" runat="server" AllowPaging="true" AllowSorting="true" AlternatingRowStyle-BackColor="Wheat" AutoGenerateColumns="false" BorderColor="Gray" 
					OnPageIndexChanged="gvCodeList_PageIndexChanged" OnPageIndexChanging="gvCodeList_PageIndexChanging" OnDataBound="gvCodeList_DataBound" OnRowCommand="gvCodeList_RowCommand" OnRowDataBound="gvCodeList_RowDataBound" 
					OnSorting="gvCodeList_Sorting" OnSorted="gvCodeList_Sorted" EnableViewState="true" PageSize="20">
					<HeaderStyle Font-Bold="true" HorizontalAlign="Center" BackColor="#66ffff" />
					<Columns>
						<asp:BoundField DataField="CodeID" HeaderText="ID" ItemStyle-Width="60" />
						<asp:BoundField DataField="sCodeGroup" HeaderText ="Group" ItemStyle-Width="100" />
						<asp:BoundField DataField="ItemCode" HeaderText ="Code" ItemStyle-Width="130" ItemStyle-HorizontalAlign="Left" />
						<asp:BoundField DataField="ItemDescription" HeaderText="Description" ItemStyle-Width="280" ItemStyle-HorizontalAlign="Left" />
						<asp:BoundField DataField="sActive" HeaderText="Active" ItemStyle-Width="60" />
						<asp:TemplateField HeaderText="Change">
							<ItemTemplate>
								<asp:Button ID="btnChangeShownVal" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="Change" Text="" OnClick="btnChangeShownVal_Click" />
								<asp:HiddenField ID="hfSelectedVal" runat="server" Value='<%# Eval("sShown") %>' />
								<asp:HiddenField ID="hfCodeID" runat="server" Value='<%# Eval("CodeID") %>' />
							</ItemTemplate>
						</asp:TemplateField>
					</Columns>
				</asp:GridView>
				</td></tr></table>
			</div>		
		</div>
	</div>

	<div id="divPAGEFtr" runat="server" style="width:99%;">
		<div id="divStatusMsg" runat="server" style="width:100%;"></div>
		<asp:Label ID="lblStatusMsg" runat="server" ForeColor="Maroon" Font-Bold="true" Text=""></asp:Label>
	</div>

</asp:Content>
