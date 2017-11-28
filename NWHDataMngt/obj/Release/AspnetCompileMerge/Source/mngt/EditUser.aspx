<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site.Master" AutoEventWireup="true" CodeBehind="EditUser.aspx.cs" Inherits="DataMngt.page.EditUser" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<asp:HiddenField ID="hfPageID" runat="server" Value="3" />

	<script type="text/javascript">
		jiPageID = 3;

	</script>

  <div id="divPAGEHEADER" style="width:98%;margin-left:8px;margin-top:10px;" class="LabelGridHdrLarge">
    User List
  </div>

  <div id="divPAGEMAIN" style="width:98%;margin-left:8px;">

    <div id="divUserFilters" style="width:100%;text-align:center;">
      <asp:Label ID="lblFilterBy" runat="server" Text="Filter By:" CssClass="LabelGridHdrStd"></asp:Label>&nbsp;
      User:&nbsp;<asp:DropDownList ID="ddlUserListF" runat="server" AppendDataBoundItems="true">
        <asp:ListItem Value="0" Text="All Users" Selected="True"></asp:ListItem>
      </asp:DropDownList>

			<table style="padding:1px;border-spacing:0px;text-align:left;margin:auto auto;"	 >
			<tr>
				<td>
					&nbsp;
				</td>
				<td>
					Name:&nbsp;
				</td>
				<td>
					<asp:TextBox ID="txtUserNameF" runat="server" Width="200"></asp:TextBox>
				</td>
				<td>&nbsp;</td>
				<td>
					Active Only:&nbsp;
				</td>
				<td>
					<asp:CheckBox ID="chkActiveOnlyF" runat="server" Checked="true" />
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
        <td style="text-align:right;">
          Location:&nbsp;
        </td>
        <td style="text-align:left;">
					<asp:DropDownList ID="ddlLocationCodeF" runat="server" AppendDataBoundItems="true">
						<asp:ListItem Value="0" Text="All" Selected="True"></asp:ListItem>
					</asp:DropDownList>
        </td>
				<td>&nbsp;</td>
				<td>
					City:&nbsp;
				</td>
				<td>
					<asp:TextBox ID="txtCityF" runat="server" Width="140"></asp:TextBox>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
        <td style="text-align:right;">
          Country:&nbsp;
        </td>
        <td style="text-align:left;">
					<asp:TextBox ID="txtCountryCodeF" runat="server" Width="70"></asp:TextBox>
        </td>
				<td>&nbsp;</td>
				<td>
					Position:&nbsp;
				</td>
				<td>
					<asp:DropDownList ID="ddlPositionF" runat="server" AppendDataBoundItems="true">
						<asp:ListItem Value="0" Text="All" Selected="True"></asp:ListItem>
					</asp:DropDownList>
				</td>
				<td>&nbsp;</td>
			</tr>
			</table>
    </div>

    <div id="divAddNewUser" style="width:100%;text-align:center;margin-bottom:10px;">
      <asp:Button ID="btnRefreshDataGrid" runat="server" CssClass="button blue-gradient glossy" OnClick="btnRefreshDataGrid_Click" Text="Refresh User List" />&nbsp;&nbsp;
      <asp:Button ID="btnOpenNewUser" runat="server" CssClass="button blue-gradient glossy" OnClick="btnOpenNewUser_Click" Text="Add New User" />
    </div>

    <div id="divEditUserData" runat="server" style="width:100%;display:none;border:1px solid gray;background-color:#E9E9E9;text-align:center;margin-bottom:10px;">
      <asp:Label ID="lblUserChngType" runat="server" Text="New User Data below"></asp:Label>:<br />
      <table style="border:none;padding:0px;border-spacing:0px;margin:auto auto;">
      <tr>
        <td style="text-align:right;">
          User Login:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:TextBox ID="txtUserLoginE" runat="server" Width="220px" Text=""></asp:TextBox>&nbsp;&nbsp;&nbsp;
        </td>
        <td>&nbsp;</td>
        <td style="text-align:right;">
          ID:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:Label ID="lblUserIDE" runat="server" Text="0"></asp:Label>
        </td>
      </tr>
      <tr>
        <td style="text-align:right;">
          Names:&nbsp;
        </td>
        <td colspan="4">
          <table style="border:none;padding:0px;border-spacing:0px;margin:4px;">
          <tr>
            <td style="text-align:right;">
              Last:&nbsp;
            </td>
            <td style="text-align:left;">
              <asp:TextBox ID="txtNameLastE" runat="server" Width="140px" Text=""></asp:TextBox>
            </td>
            <td>
              &nbsp;
            </td>
            <td style="text-align:right;">
              First:&nbsp;
            </td>
            <td style="text-align:left;">
              <asp:TextBox ID="txtNameFirstE" runat="server" Width="140px" Text=""></asp:TextBox>
            </td>
            <td>
              &nbsp;
            </td>
            <td style="text-align:right;">
              Middle:&nbsp;
            </td>
            <td style="text-align:left;">
              <asp:TextBox ID="txtNameMiddleE" runat="server" Width="140px" Text=""></asp:TextBox>
            </td>
          </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td style="text-align:right;">
          Active:&nbsp;
        </td>
        <td style="text-align:left;">
           <asp:DropDownList ID="ddlIsActiveE" runat="server">
              <asp:ListItem Value="0" Text="No"></asp:ListItem>
              <asp:ListItem Value="1" Text="Yes" Selected="True"></asp:ListItem>
           </asp:DropDownList>
        </td>
        <td>&nbsp;</td>
        <td style="text-align:right;">
          Is Contractor:&nbsp;
        </td>
        <td style="text-align:left;">
           <asp:DropDownList ID="ddlIsContractorE" runat="server">
              <asp:ListItem Value="0" Text="No" Selected="True"></asp:ListItem>
              <asp:ListItem Value="1" Text="Yes"></asp:ListItem>
           </asp:DropDownList>
        </td>
      </tr>
      <tr>
        <td style="text-align:right;">
          Email Address:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:TextBox ID="txtEmailAddrE" runat="server" Width="260px" Text=""></asp:TextBox>&nbsp;&nbsp;&nbsp;
        </td>
        <td>&nbsp;</td>
        <td style="text-align:right;">
          Position:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:TextBox ID="txtPositionE" runat="server" Width="140px" Text=""></asp:TextBox>&nbsp;&nbsp;&nbsp;Emp ID:&nbsp;<asp:TextBox ID="txtEmpIDE" runat="server" Width="80px" Text=""></asp:TextBox>
        </td>
			</tr>
      <tr>
        <td style="text-align:right;">
          Location:&nbsp;
        </td>
        <td style="text-align:left;">
					<asp:DropDownList ID="ddlLocationCodeE" runat="server" AppendDataBoundItems="true">
						<asp:ListItem Value="0" Text="Undefined" Selected="True"></asp:ListItem>
					</asp:DropDownList>
        </td>
        <td>&nbsp;</td>
        <td style="text-align:right;">
          &nbsp;
        </td>
        <td style="text-align:left;">
          &nbsp;
        </td>
			</tr>
      <tr>
        <td style="text-align:center;" colspan="5">
					<hr style="color:gray;width:500px;" />
        </td>
      </tr>
      <tr>
        <td style="text-align:right;">
          Begin Date:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:TextBox ID="txtBeginDateN" runat="server" Width="90px" Text=""></asp:TextBox>
        </td>
        <td>&nbsp;</td>
        <td style="text-align:right;">
          End Date:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:TextBox ID="txtEndDateN" runat="server" Width="90px" Text=""></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td style="text-align:center;" colspan="5">
          <asp:Button ID="btnAddNewUser" runat="server" CssClass="button blue-gradient glossy" OnClick="btnAddNewUser_Click" Text="Add User" />&nbsp;&nbsp;
          <asp:Button ID="btnCloseArea2" runat="server" CssClass="button blue-gradient glossy" OnClick="btnCloseArea2_Click" Text="Close Area" />
          <asp:Button ID="btnClearArea2" runat="server" CssClass="button blue-gradient glossy" OnClick="btnClearArea2_Click" Text="Clear Fields" />
        </td>
      </tr>
      </table>
    </div>

    <div id="divUserListGV" style="width:100%;text-align:center;">
      <asp:Label ID="lblUserListGrid" runat="server" CssClass="MyHeaderLabel" Text="User List" ForeColor="ForestGreen"></asp:Label><br />
      <table style="margin:auto auto;"><tr><td>
        <asp:GridView ID="gvUserList" runat="server" DataKeyNames="UserID" AllowSorting="True" OnRowDataBound="gvUserList_RowDataBound" OnRowEditing="gvUserList_RowEditing" OnSorting="gvUserList_Sorting" OnSorted="gvUserList_Sorted"
          OnRowUpdated="gvUserList_RowUpdated" OnRowCommand="gvUserList_RowCommand" AutoGenerateColumns="false" AllowPaging="true" PageSize="20" OnPageIndexChanged="gvUserList_PageIndexChanged" OnPageIndexChanging="gvUserList_PageIndexChanging"
					EnableViewState="true" PagerSettings-Mode="Numeric" >
          <HeaderStyle CssClass="TableHdrCell" Font-Size="10pt" Font-Bold="true" />
          <Columns>
						<asp:BoundField DataField="UserID" HeaderText="UserID" ItemStyle-Width="60" />
						<asp:BoundField DataField="UserLogin" HeaderText="Login" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="190" />
						<asp:BoundField DataField="UserLastName" HeaderText="LastName" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="120" />
						<asp:BoundField DataField="UserFirstName" HeaderText="FirstName" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="120" />
						<asp:BoundField DataField="UserMiddleName" HeaderText="MiddleName" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="110" />
						<asp:BoundField DataField="EmailAddress" HeaderText="Email" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="130" />
						<asp:BoundField DataField="EmpPosition" HeaderText="Position" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="200" />
						<asp:BoundField DataField="LocationCode" HeaderText="Location" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="90" />
						<asp:BoundField DataField="sBeginDate" HeaderText="Begin Date" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80" />
						<asp:BoundField DataField="sEndDate" HeaderText="End Date" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="80" />
						<asp:TemplateField HeaderText="Active" ItemStyle-HorizontalAlign="Center">
							<ItemTemplate>
								<div id="divActiveCol" style="padding-left:4px;padding-right:4px;">
									<asp:CheckBox ID="chkUserActive" runat="server" />
								</div>
							</ItemTemplate>
						</asp:TemplateField>
						<asp:TemplateField HeaderText="Contr" ItemStyle-HorizontalAlign="Center">
							<ItemTemplate>
								<div id="divContractorCol" style="padding-left:4px;padding-right:4px;">
									<asp:CheckBox ID="chkUserContractor" runat="server" />
								</div>
							</ItemTemplate>
						</asp:TemplateField>
            <asp:TemplateField HeaderText="Action" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Center">
              <ItemTemplate>
                <asp:Button ID="btnEditUser" runat="server" CommandName="Edit1" CssClass="button blue-gradient glossy" CommandArgument="<%# Container.DataItemIndex %>" Text="Edit" Height="20px" Width="42" />
                <asp:Button ID="btnInactivateUser" runat="server" CommandName="Inact1" CssClass="button blue-gradient glossy" CommandArgument="<%# Container.DataItemIndex %>" Text="Inact" Height="20px" Width="42" />
                <asp:Button ID="btnRemoveUser" runat="server" CommandName="Del1" CssClass="button blue-gradient glossy" CommandArgument="<%# Container.DataItemIndex %>" Text="Del" Height="20px" Width="42" />
              </ItemTemplate>
            </asp:TemplateField>
          </Columns>
        </asp:GridView>
      </td></tr></table>
    </div>
  </div>

  <div id="divPAGEFOOTER" style="width:98%;margin-left:8px;">
    <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Maroon" Font-Bold="true" Font-Size="Large"></asp:Label>
  </div>

</asp:Content>
