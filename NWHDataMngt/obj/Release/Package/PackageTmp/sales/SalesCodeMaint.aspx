<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site.Master" AutoEventWireup="true" CodeBehind="SalesCodeMaint.aspx.cs" Inherits="DataMngt.sales.SalesCodeMaint" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<asp:HiddenField ID="hfPageID" runat="server" Value="49" />

	<div id="divPAGEHEADER" style="width:99%;text-align:center;margin-left:10px;">
		<asp:Label ID="lblSalesCodeMaintHdr" CssClass="LabelGridHdrLarger" Text="Sales Code Maintenance" runat="server"></asp:Label><br />
		<table style="padding:0px;border-spacing:0px;margin:auto auto;">
		<tr>
			<td>
				Code Type:&nbsp;
			</td>
			<td>
				<asp:DropDownList ID="ddlCodeTypeF" runat="server" OnSelectedIndexChanged="ddlCodeTypeF_SelectedIndexChanged">
					<asp:ListItem Value="0" Text="ALL" Selected="True"></asp:ListItem>
					<asp:ListItem Value="Color" Text="Color"></asp:ListItem>
					<asp:ListItem Value="Grade" Text="Grade"></asp:ListItem>
					<asp:ListItem Value="Length" Text="Length"></asp:ListItem>
					<asp:ListItem Value="Location" Text="Location"></asp:ListItem>
					<asp:ListItem Value="Milling" Text="Milling"></asp:ListItem>
					<asp:ListItem Value="NoPrint" Text="NoPrint"></asp:ListItem>
					<asp:ListItem Value="Region" Text="Region"></asp:ListItem>
					<asp:ListItem Value="Sort" Text="Sort"></asp:ListItem>
					<asp:ListItem Value="Species" Text="Species"></asp:ListItem>
					<asp:ListItem Value="Thickness" Text="Thickness"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td>
				<label style="margin-left: 5px;">Items per Page:</label>
				<asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged" style="margin-left: 10px;">
					<asp:ListItem Text="10" Value="10" />
					<asp:ListItem Text="20" Value="20" Selected="True" />
					<asp:ListItem Text="25" Value="25" />
					<asp:ListItem Text="50" Value="50" />
					<asp:ListItem Text="100" Value="100" />
					<asp:ListItem Text="250" Value="250" />
				</asp:DropDownList>&nbsp;&nbsp;&bull;&nbsp;&nbsp;
			</td>
		</tr>
		</table>
	</div>

	<div id="divCodeEditBlock" style="width:100%;display:none;margin-left:10px;" runat="server">
		<table id="tblCodeEditBlock">
		<tr>
			<td>&nbsp;</td>
			<td style="text-align:right;">
				Edit:&nbsp;
			</td>
			<td>
				Code&nbsp;Type:&nbsp;
			</td>
			<td>
				<asp:DropDownList ID="ddlCodeTypeE" runat="server">
					<asp:ListItem Value="0" Text="ALL" Selected="True"></asp:ListItem>
					<asp:ListItem Value="Color" Text="Color"></asp:ListItem>
					<asp:ListItem Value="Grade" Text="Grade"></asp:ListItem>
					<asp:ListItem Value="Length" Text="Length"></asp:ListItem>
					<asp:ListItem Value="Location" Text="Location"></asp:ListItem>
					<asp:ListItem Value="Milling" Text="Milling"></asp:ListItem>
					<asp:ListItem Value="NoPrint" Text="NoPrint"></asp:ListItem>
					<asp:ListItem Value="Region" Text="Region"></asp:ListItem>
					<asp:ListItem Value="Sort" Text="Sort"></asp:ListItem>
					<asp:ListItem Value="Species" Text="Species"></asp:ListItem>
					<asp:ListItem Value="Thickness" Text="Thickness"></asp:ListItem>
				</asp:DropDownList>
			</td>
			<td>&nbsp;</td>
			<td>
				Code:&nbsp;
			</td>
			<td>
				<asp:TextBox ID="txtCodeE" runat="server" Width="100"></asp:TextBox>
			</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td colspan="3">&nbsp;</td>
			<td style="text-align:right;">
				Description:&nbsp;
			</td>
			<td style="text-align:right;">
				Description:&nbsp;
			</td>
			<td colspan="4">
				<asp:TextBox ID="txtCodeDescE" Width="500" runat="server"></asp:TextBox>
			</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td colspan="3">&nbsp;</td>
			<td style="text-align:right;">
				Seq:&nbsp;
			</td>
			<td>
				<asp:TextBox ID="txtSortOrderE" Width="60" runat="server"></asp:TextBox>
			</td>
			<td>&nbsp;</td>
			<td>
				Settings:&nbsp;
			</td>
			<td>
				<asp:Checkbox ID="chkIsShownE" runat="server" checked="true"></asp:Checkbox>Shown&nbsp;&nbsp;
				<asp:Checkbox ID="chkIsActiveE" runat="server" checked="true"></asp:Checkbox>Active
			</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td colspan="9" style="text-align:center;">
				<asp:Button ID="btnSaveCodeData" runat="server" OnClick="btnSaveCodeData_Click" Text="Save" CssClass="button blue-gradient glossy"	/>
			</td>
		</tr>
		</table>
	</div>

	<div id="divPAGEMAINCONTENT" style="width:99%;margin-left:10px;">
		<div id="divGVHeader" style="width:100%;">
			<asp:Label ID="lblGridHdr" Font-Bold="true" Font-Size="12pt" ForeColor="SlateBlue" Text="Data" runat="server"></asp:Label>
		</div>
		<div id="divCodeDataGrid" style="width:100%;">
			<asp:GridView ID="gvCodeList" runat="server" PageIndex="0" AllowPaging="true" AutoGenerateColumns="false" HeaderStyle-CssClass="TableHdrCell" OnRowCommand="gvCodeList_RowCommand"
					OnPageIndexChanged="gvCodeList_PageIndexChanged" OnPageIndexChanging="gvCodeList_PageIndexChanging" >
				<RowStyle CssClass="StdTableCell" />
				<Columns>
					<asp:BoundField DataField="CatCodeID" HeaderText="ID" ItemStyle-Width="60" />
					<asp:BoundField DataField="CodeType" HeaderText="Type" ItemStyle-Width="90" />
					<asp:BoundField DataField="CatCode" HeaderText="Code" ItemStyle-Width="120" />
					<asp:BoundField DataField="CodeDescription" HeaderText="Description" ItemStyle-Width="360" />
					<asp:BoundField DataField="ViewOrder" HeaderText="Order" ItemStyle-Width="60" />
					<asp:BoundField DataField="sShown" HeaderText="Shown" ItemStyle-Width="70" />
					<asp:BoundField DataField="sActive" HeaderText="Active" ItemStyle-Width="70" />
					<asp:TemplateField>
						<ItemTemplate>
							<asp:Button ID="btnEditCodeItem" CssClass="button blue-gradient glossy" CommandName="Edit" CommandArgument="<%# Container.DataItemIndex %>"  Text="Edit" />
							<asp:Button ID="btnDelCodeItem" CssClass="button blue-gradient glossy" CommandName="Delete" CommandArgument="<%# Container.DataItemIndex %>"  Text="Del" />
						</ItemTemplate>
					</asp:TemplateField>
				</Columns>
			</asp:GridView>
		</div>
		
	</div>

	<div id="divPAGEFOOTER" style="width:99%;margin-left:10px;">
		<div id="divStatusMsg" style="width:100%;">
			<asp:Label ID="lblStatusMsg" runat="server" Font-Bold="true" Font-Size="11pt" ForeColor="Maroon"></asp:Label>
		</div>
	</div>

</asp:Content>
