<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site.Master" AutoEventWireup="true" CodeBehind="UserADInterface.aspx.cs" Inherits="DataMngt.page.UserADInterface" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

	<div id="divPAGECONTENTHDR" runat="server" style="width:99%;margin-left:10px;margin-right:10px;">

	</div>

	<div id="divPAGECONTENTMAIN" runat="server" style="width:99%;margin-left:10px;margin-right:10px;">
		
		<div id="divMainButtonBar" runat="server" style="width:100%;padding:2px;background-color:antiquewhite;border:6px ridge cyan;margin-right:30px;">
			<asp:Button ID="btnSearchForUser" runat="server" Text="Find User" OnClick="btnSearchForUser_Click" />&nbsp;&nbsp;
			Edit&nbsp;User:&nbsp;
			<asp:DropDownList ID="ddlUserList" runat="server" OnSelectedIndexChanged="ddlUserList_SelectedIndexChanged" AppendDataBoundItems="true">
				<asp:ListItem value="0" Text="None Selected" Selected="True"></asp:ListItem>
			</asp:DropDownList>&nbsp;&nbsp;
			<asp:Button ID="btnGenerateExcelList" runat="server" Text="Export to Excel" OnClick="btnGenerateExcelList_Click" />&nbsp;&nbsp;
		</div>

		<div id="divUserData" runat="server" style="width:100%;display:none;">
			<div id="divUserDataHdr" runat="server" style="width:100%;">
				<asp:Label ID="lblUserDataHdr" runat="server" Text="User Data:"></asp:Label>

			</div>
			<div id="divUserDataTable" runat="server" style="width:100%;text-align:center;">
				<table id="tblUserData" style="padding:1px;border-spacing:0px;margin: auto auto;">
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
						Access:&nbsp;
					</td>
					<td style="text-align:left;">
						<asp:DropDownList ID="ddlUserAccessAreaE" runat="server">
							<asp:ListItem Value="L" Selected="True" Text="Local"></asp:ListItem>
							<asp:ListItem Value="D" Text="Division"></asp:ListItem>
							<asp:ListItem Value="G" Text="Global"></asp:ListItem>
						</asp:DropDownList>
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
					<td style="text-align:right;">
						Phone:&nbsp;
					</td>
					<td style="text-align:left;">
						<asp:TextBox ID="txtUserPhoneE" runat="server" Width="90px" Text=""></asp:TextBox>
					</td>
					<td>&nbsp;</td>
					<td style="text-align:right;">
						Cell:&nbsp;
					</td>
					<td style="text-align:left;">
						<asp:TextBox ID="txtUserCellE" runat="server" Width="90px" Text=""></asp:TextBox>
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


UserID	int	Unchecked
UserLogin	varchar(70)	Unchecked
UserFirstName	varchar(40)	Unchecked
UserLastName	varchar(40)	Unchecked
UserMiddleName	varchar(40)	Checked
EmpID	int	Checked
EmailAddress	varchar(100)	Checked
EmpPosition	varchar(50)	Checked
LocationCode	varchar(20)	Unchecked
AccessArea	char(1)	Unchecked
IsContractor	bit	Unchecked
OfficePhone	varchar(26)	Unchecked
CellPhone	varchar(20)	Unchecked
MgrID	int	Unchecked
LastLogDateTime	datetime	Checked
BeginDate	datetime	Unchecked
EndDate	datetime	Checked
IsActive	bit	Unchecked


			</div>
		</div>

		<div id="divStatusMsg" runat="server" style="width:100%;">
			<asp:Label ID="lblStatusMsg" runat="server" ForeColor="Maroon" Font-Size="12" Font-Bold="true"></asp:Label>
		</div>
	</div>

	<div id="divPAGECONTENTFTR" runat="server" style="width:99%;margin-left:10px;margin-right:10px;">

	</div>

</asp:Content>
