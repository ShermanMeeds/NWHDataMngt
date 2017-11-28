<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site.Master" AutoEventWireup="true" CodeBehind="EditUserRights.aspx.cs" Inherits="DataMngt.page.EditUserRights" ClientIDMode="Predictable" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<asp:HiddenField ID="hfPageID" runat="server" Value="2" />

	<script type="text/javascript">
		var jiPageID = 2;
	</script>
	
	<div id="divPAGEHEADER" style="width:99%;margin-left:8px;margin-top:10px;" >
		<table style="width:100%;padding:1px;border-spacing:0px;">
		<tr>
			<td class="LabelGridHdrLarge" style="width:30%;">
		    Edit User Application Rights
			</td>
			<td style="width:70%;text-align:right;margin-right:10px;">
				&nbsp;Edit&nbsp;Group:&nbsp;
				<asp:DropDownList ID="ddlEditUserGroupMaster" runat="server" AppendDataBoundItems="true" OnTextChanged="ddlEditUserGroupMaster_TextChanged" AutoPostBack="true">
					<asp:ListItem value="0" Text="ALL" Selected="True"></asp:ListItem>
				</asp:DropDownList>&nbsp;&nbsp;&nbsp;
				&nbsp;<asp:Button ID="btnMakeNewUserGroup" runat="server" CssClass="button blue-gradient glossy" Text="New User Group" OnClick="btnMakeNewUserGroup_Click" />&nbsp;
				&nbsp;Edit&nbsp;App&nbsp;Area:&nbsp;
				<asp:DropDownList ID="ddlAppAreaMasterList" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlAppAreaMasterList_SelectedIndexChanged">
					<asp:ListItem Value="0" Text="None" Selected="True"></asp:ListItem>
				</asp:DropDownList>&nbsp;&nbsp;&nbsp;
				&nbsp;<asp:Button ID="btnMakeNewAppArea" runat="server" CssClass="button blue-gradient glossy" Text="New App Area" OnClick="btnMakeNewAppArea_Click" />&nbsp;
				&nbsp;View&nbsp;By:&nbsp;
				<asp:DropDownList ID="ddlMainView" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlMainView_SelectedIndexChanged1">
					<asp:ListItem Value="0" Selected="true" Text="User Rights by User"></asp:ListItem>
					<asp:ListItem Value="1" Text="User Rights by Group"></asp:ListItem>
				</asp:DropDownList>
			</td>
		</tr>
		</table>
  </div>

  <div id="divPAGEMAIN" style="width:99%;margin-left:8px;">

    <div id="divUserFilters" style="width:100%;text-align:center;margin-bottom:6px;">
      <asp:Label ID="lblFilterBy" runat="server" Text="Filter By:" CssClass="LabelGridHdrStd"></asp:Label>&nbsp;
      User:&nbsp;<asp:DropDownList ID="ddlUserListF" runat="server" AppendDataBoundItems="true" OnTextChanged="ddlUserListF_TextChanged" AutoPostBack="true">
        <asp:ListItem Value="0" Text="All Users" Selected="True"></asp:ListItem>
      </asp:DropDownList>&nbsp;&nbsp;&nbsp;
			LastName:&nbsp;<asp:TextBox ID="txtLastNameF" runat="server" Width="100" Text="" OnTextChanged="txtLastNameF_TextChanged" AutoPostBack="true"></asp:TextBox>&nbsp;&nbsp;&nbsp;
			Group:&nbsp;<asp:DropDownList ID="ddlRightsGroupF" runat="server" AppendDataBoundItems="true" OnTextChanged="ddlRightsGroupF_TextChanged" AutoPostBack="true">
				<asp:ListItem value="0" Text="ALL" Selected="True"></asp:ListItem>
			</asp:DropDownList>&nbsp;&nbsp;&nbsp;
			Position:&nbsp;<asp:DropDownList ID="ddlUserPositionF" runat="server" AppendDataBoundItems="true" OnTextChanged="ddlUserPositionF_TextChanged" AutoPostBack="true">
				<asp:ListItem value="0" Text="ALL" Selected="True"></asp:ListItem>
			</asp:DropDownList>
    </div>

    <div id="divEditUserRightData" runat="server" style="width:99%;height:500px;display:none;border:1px solid gray;background-color:#E9E9E9;text-align:center;margin-bottom:10px;overflow:scroll;">
      <asp:Label ID="lblUserRightsEdit" runat="server" Text="Add" Font-Size="11pt" ForeColor="CadetBlue" Font-Bold="true"></asp:Label>&nbsp;
      <asp:Label ID="Label1" runat="server" Text="New User Right below then click on button to save:" Font-Size="11pt" ForeColor="CadetBlue" Font-Bold="true"></asp:Label><br />

			<div id="divUserRightsDataBlock" style="width:100%;text-align:center;margin-bottom:6px;">
				<table style="border:none;padding:0px;border-spacing:0px;table-layout:fixed;margin:auto auto;">
				<tr style="height:30px;background-color:darkturquoise;padding:2px;">
					<td style="text-align:left;font-weight:bold;color:darkblue;" colspan="3">
						&nbsp;User:&nbsp;
						<asp:DropDownList ID="ddlUserList" runat="server" AppendDataBoundItems="true" AutoPostBack="true" OnTextChanged="ddlUserList_TextChanged">
							<asp:ListItem Value="0" Text="None Selected" Selected="True"></asp:ListItem>
						</asp:DropDownList>&nbsp;&nbsp;&nbsp;ID:&nbsp;<asp:Label ID="lblUserIDRE" runat="server" Text="0"></asp:Label>&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
				<tr>
 					<td style="vertical-align:top;">

						<div id="divUserRightsFilterGrp" style="width:100%;text-align:left;margin-bottom:10px;">
							<span style="width:100px;font-weight:bold;">Location&nbsp;User&nbsp;Group:&nbsp;</span>
							<asp:DropDownList id="ddlForecastLocGroup" runat="server" AutoPostBack="true" OnTextChanged="ddlForecastLocGroup_TextChanged">
								<asp:ListItem Value="consoldvw" Text="Consolidation View"></asp:ListItem>
								<asp:ListItem Value="consoldv2" Text="Consolidation Global"></asp:ListItem>
								<asp:ListItem value="forecastedit" Text="Forecast Edit" Selected="True"></asp:ListItem>
								<asp:ListItem value="forecastadm" Text="Forecast Admin"></asp:ListItem>
								<asp:ListItem Value="forecastvw" Text="Forecast ViewOnly"></asp:ListItem>
								<asp:ListItem Value="cmtmngtedt" Text="Comment Management-Edit"></asp:ListItem>
							</asp:DropDownList>
						</div>
						<div id="divLocationsTable" style="width:100%;text-align:left;margin-bottom:10px;">
							<span style="width:100px;font-weight:bold;">Forecast&nbsp;Locations:&nbsp;</span>
							<asp:GridView ID="gvForecastLocations" runat="server" OnRowCommand="gvForecastLocations_RowCommand" AutoGenerateColumns="false">
								<RowStyle CssClass="StdTableCell" />
								<HeaderStyle CssClass="TableHdrCell" />
								<Columns>
									<asp:BoundField DataField="LocationCode" HeaderText="Code" ItemStyle-BorderStyle="Solid" />
									<asp:BoundField DataField="LocationName" HeaderText="Name" ItemStyle-BorderStyle="Solid" />
									<asp:BoundField DataField="RegionCode" HeaderText="Region" ItemStyle-BorderStyle="Solid" />
									<asp:BoundField DataField="StateProvCode" HeaderText="State" ItemStyle-BorderStyle="Solid" />
									<asp:BoundField DataField="UserGroupCode" HeaderText="Group" ItemStyle-BorderStyle="Solid" />
									<asp:TemplateField HeaderText="Action" ItemStyle-BorderStyle="Solid" >
										<ItemTemplate>
											<asp:Button ID="btnDeleteLoc" runat="server" CssClass="button blue-gradient glossy" Text="Remove" OnClick="btnDeleteLoc_Click" CommandName="del" CommandArgument="<%# Container.DataItemIndex %>"  />
											<asp:HiddenField ID="hfLocCode" runat="server" Value='<%# Eval("LocationCode") %>' />
											<asp:HiddenField ID="hfGrpCode" runat="server" Value='<%# Eval("UserGroupCode") %>' />
										</ItemTemplate>
									</asp:TemplateField>
								</Columns>
							</asp:GridView>
							<asp:Label ID="lblShowNoResults"  runat="server" Text="No locations were found"></asp:Label>

						</div>
						<div id="" style="width:100%;text-align:left;margin-bottom:10px;">
							Add&nbsp;Location:&nbsp;<asp:DropDownList ID="ddlFCLocation" AutoPostBack="true" runat="server" AppendDataBoundItems="true" OnTextChanged="ddlFCLocation_TextChanged">
								<asp:ListItem value="0" Text="None Selected" Selected="True"></asp:ListItem>
							</asp:DropDownList>
						</div>

 					</td>
 					<td style="vertical-align:top;">
						&nbsp;&nbsp;&nbsp;
 					</td>
 					<td style="vertical-align:top;">
						<table>
						<tr>
							<td style="text-align:right;vertical-align:top;font-weight:bold;">
								Existing&nbsp;Rights:&nbsp;
							</td>
							<td style="text-align:left;vertical-align:top;overflow:scroll;height:200px;">
								<asp:GridView ID="gvExistingRights" runat="server" OnRowDataBound="gvExistingRights_RowDataBound" OnRowCommand="gvExistingRights_RowCommand" AutoGenerateColumns="false">
									<RowStyle CssClass="StdTableCell" />
									<HeaderStyle CssClass="TableHdrCell" />
									<Columns>
										<asp:BoundField DataField="AppArea" HeaderText="Area" ItemStyle-BorderStyle="Solid" />
										<asp:BoundField DataField="UserGroupCode" HeaderText="Group Code" ItemStyle-BorderStyle="Solid" />
										<asp:TemplateField HeaderText="Level" ItemStyle-BorderStyle="Solid">
											<ItemTemplate>
												<asp:DropDownList id="ddlRightsLevel" runat="server" AutoPostBack="true" OnTextChanged="ddlRightsLevel_TextChanged" >
													<asp:ListItem Value="0" Text="None" Selected="True"></asp:ListItem>
													<asp:ListItem Value="1" Text="Read Only"></asp:ListItem>
													<asp:ListItem Value="2" Text="Restricted"></asp:ListItem>
													<asp:ListItem Value="3" Text="Edit"></asp:ListItem>
													<asp:ListItem Value="4" Text="SuperUser"></asp:ListItem>
													<asp:ListItem Value="5" Text="Admin"></asp:ListItem>
												</asp:DropDownList>
											</ItemTemplate>
										</asp:TemplateField>
										<asp:BoundField DataField="sRightLevel" HeaderText="Level" ItemStyle-BorderStyle="Solid"  />
										<asp:BoundField DataField="sBeginDate" HeaderText="Since" ItemStyle-BorderStyle="Solid"  />
										<asp:TemplateField HeaderText="Action" ItemStyle-BorderStyle="Solid" >
											<ItemTemplate>
												<asp:Button ID="btnRemoveRight" runat="server" Text="Remove" CssClass="button blue-gradient glossy" CommandName="Remove" CommandArgument="<%# Container.DataItemIndex %>" Height="20px"  />
												<asp:HiddenField ID="hfUserGroupCode" runat="server" Value='<%# Eval("UserGroupCode") %>' />
											</ItemTemplate>
										</asp:TemplateField>
									</Columns>
								</asp:GridView>
								<asp:Label ID="lblRightsLevelNoRows"  runat="server" Text="No rights were found"></asp:Label>
							</td>
						</tr>
						<tr><td colspan="2">&nbsp;</td></tr>
						<tr>
							<td style="text-align:right;font-weight:bold;">
								New&nbsp;Area:&nbsp;
							</td>
							<td style="text-align:left;">
								<asp:DropDownList ID="ddlAppAreaNU" runat="server">
									<asp:ListItem Value="0" Text="None" Selected="True"></asp:ListItem>
								</asp:DropDownList>&nbsp;&nbsp;&nbsp;
								Right Level:&nbsp;
								<asp:DropDownList ID="ddlRightsLevelNU" runat="server">
									<asp:ListItem Value="0" Text="None" Selected="True"></asp:ListItem>
									<asp:ListItem Value="1" Text="Read Only"></asp:ListItem>
									<asp:ListItem Value="2" Text="Restricted"></asp:ListItem>
									<asp:ListItem Value="3" Text="Edit"></asp:ListItem>
									<asp:ListItem Value="4" Text="SuperUser"></asp:ListItem>
									<asp:ListItem Value="5" Text="Admin"></asp:ListItem>
								</asp:DropDownList>&nbsp;&nbsp;
								<asp:Button ID="btnAddNewUserRight" runat="server" CssClass="button blue-gradient glossy" OnClick="btnAddNewUserRight_Click" Text="Add User Right" />
							</td>
						</tr>
						</table>
 					</td>
				</tr>
				</table>				
			</div>

      <asp:Button ID="btnCloseArea1" runat="server" CssClass="button blue-gradient glossy" OnClick="btnCloseArea1_Click" Text="Close Area" />&nbsp;&nbsp;
    </div>

		<div id="divEditUserGroup" runat="server" style="width:100%;display:none;text-align:center;background-color:antiquewhite;">
			<asp:Label ID="lblEditUserGroup" runat="server" ForeColor="Blue" Font-Size="14pt" Font-Bold="true" Text="User Group Data"></asp:Label>:
			
			<div id="divEditUserGroupTbl" style="width:100%;margin-bottom:10px;padding-bottom:4px;">
				<table id="tblEditUserGroup" style="border:none;padding:1px;border-spacing:0px;margin: auto auto;">
				<tr>
					<td style="text-align:right;">
						Group Code:&nbsp;
					</td>
					<td style="text-align:left;">
						<asp:TextBox ID="txtGrpCodeE" runat="server" Width="100"></asp:TextBox>&nbsp;&nbsp;ID:&nbsp;<asp:Label ID="lblUserGrpIDE" ForeColor="Blue" Font-Bold="true" runat="server"></asp:Label>
						<asp:HiddenField ID="hfAppAreaID" runat="server" Value="0" />
					</td>
					<td>&nbsp;</td>
					<td style="text-align:right;">
						Group Name:&nbsp;
					</td>
					<td style="text-align:left;">
						<asp:TextBox ID="txtGrpNameE" runat="server" Width="260"></asp:TextBox>
					</td>
				</tr>
				<tr>
					<td style="text-align:right;">
						App Area:&nbsp;
					</td>
					<td style="text-align:left;">
						<asp:DropDownList ID="ddlAppAreaGE" runat="server">
							<asp:ListItem Value="0" Text="None" Selected="True"></asp:ListItem>
						</asp:DropDownList>&nbsp;&nbsp;&nbsp;
					</td>
					<td>&nbsp;</td>
					<td style="text-align:right;">
						Rights Level:&nbsp;
					</td>
					<td style="text-align:left;">
						<asp:DropDownList id="ddlRightsLevelGE" runat="server">
							<asp:ListItem Value="0" Text="None" Selected="True"></asp:ListItem>
							<asp:ListItem Value="1" Text="Read Only"></asp:ListItem>
							<asp:ListItem Value="2" Text="Restricted"></asp:ListItem>
							<asp:ListItem Value="3" Text="Edit"></asp:ListItem>
							<asp:ListItem Value="4" Text="SuperUser"></asp:ListItem>
							<asp:ListItem Value="5" Text="Admin"></asp:ListItem>
						</asp:DropDownList>
					</td>
				</tr>
				<tr>
					<td>
						Active:&nbsp;
					</td>
					<td style="text-align:left;">
						<asp:CheckBox ID="chkGroupCodeActive" runat="server" Checked="true" />
					</td>
					<td>&nbsp;</td>
					<td style="text-align:right;">
						Nbr Users:&nbsp;
					</td>
					<td style="text-align:left;">
						<asp:Label ID="lblNbrUsersInGroup" runat="server" ForeColor="SlateGray" Font-Bold="true"></asp:Label>
					</td>
				</tr>
				<tr>
					<td colspan="5" style="text-align:center;">
						<span id="spnSaveUserGrp"><asp:Button ID="btnSaveUserGrp" runat="server" CssClass="button blue-gradient glossy" Text="Save" OnClick="btnSaveUserGrp_Click" Width="100" /></span>
						<span id="spnCloseUserGrpArea" style="margin-left:50px;"><asp:Button ID="btnCloseThisArea2" runat="server" CssClass="button blue-gradient glossy" Text="Close" OnClick="btnCloseThisArea2_Click" Width="100" />
						<span id="spnAddNewPersToGrp" style="margin-left:50px;"><asp:Button ID="btnAddAnotherPerson" runat="server" CssClass="button blue-gradient glossy" Text="Add Person" OnClick="btnAddAnotherPerson_Click" Width="100" />
					</td>
				</tr>
				</table>

			</div>

			<div id="divAddNewPersonToGrp" runat="server" style="width:100%;margin-bottom:10px;padding-bottom:4px;display:none;">
				People:&nbsp;
				<asp:DropDownList ID="ddlPeopleNotInGrp" AppendDataBoundItems="true" runat="server">
					<asp:ListItem value="0" Selected="True" Text="None Selected"></asp:ListItem>
				</asp:DropDownList>&nbsp;
				<asp:Button ID="btnAddPersonToGrp" runat="server" CssClass="button blue-gradient glossy" Text="Add Person to Group" OnClick="btnAddPersonToGrp_Click" />
			</div>
		</div>

		<div id="divEditAppArea" runat="server" style="width:100%;display:none;text-align:center;background-color:antiquewhite;">
 			<asp:Label ID="lblEditAppAreaHdr" runat="server" ForeColor="Blue" Font-Size="14pt" Font-Bold="true" Text="App Area Data"></asp:Label>:
			<table id="tblAppAreaEdit" style="border:none;padding:1px;border-spacing:0px;margin: auto auto;">
			<tr>
				<td style="text-align:left;">
					App Area Code:&nbsp;
				</td>
				<td style="text-align:left;">
					<asp:TextBox ID="txtAppAreaCodeE" runat="server" Width="160"></asp:TextBox>&nbsp;&nbsp;ID:&nbsp;<asp:Label ID="lblAppAreaIDE" ForeColor="Blue" Font-Bold="true" runat="server"></asp:Label>
				</td>
			</tr>
			<tr>
				<td style="text-align:left;">
					App Area Name:&nbsp;
				</td>
				<td style="text-align:left;">
					<asp:TextBox ID="txtAppAreaNameE" runat="server" Width="260"></asp:TextBox>&nbsp;&nbsp;&nbsp;Active:&nbsp;<asp:CheckBox ID="chkAppAreaActiveE" Checked="true" runat="server" />
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:center;">
					<table id="tblAppAreaRights" style="padding:1px;border-spacing:0px;margin: auto auto;">
					<tr>
						<th class="TableHdrCell" colspan="2">
							Sec&nbsp;Level
						</th>
						<th class="TableHdrCell">
							User&nbsp;Group&nbsp;Code
						</th>
						<th class="TableHdrCell">
							Group&nbsp;Name
						</th>
					</tr>
					<tr>
						<td class="StdTableCell" style="text-align:center;">
							1
						</td>
						<td class="StdTableCell" style="text-align:center;">
							View Only
						</td>
						<td class="StdTableCell" style="text-align:left;">
							<asp:TextBox ID="txtAppAreaRights1" Text="" runat="server" Width="110"></asp:TextBox>
						</td>
						<td class="StdTableCell" style="text-align:left;">
							<asp:TextBox ID="txtAppAreaRName1" Text="" runat="server" Width="260"></asp:TextBox>&nbsp;
							<asp:HiddenField ID="hfAppAreaRightsID1" runat="server" Value="0"></asp:HiddenField>
						</td>
					</tr>
					<tr>
						<td class="StdTableCell" style="text-align:center;">
							2
						</td>
						<td class="StdTableCell" style="text-align:center;">
							Limited Edit
						</td>
						<td class="StdTableCell" style="text-align:left;">
							<asp:TextBox ID="txtAppAreaRights2" Text="" runat="server" Width="110"></asp:TextBox>
						</td>
						<td class="StdTableCell" style="text-align:left;">
							<asp:TextBox ID="txtAppAreaRName2" Text="" runat="server" Width="260"></asp:TextBox>&nbsp;
							<asp:HiddenField ID="hfAppAreaRightsID2" runat="server" Value="0"></asp:HiddenField>
						</td>
					</tr>
					<tr>
						<td class="StdTableCell" style="text-align:center;">
							3
						</td>
						<td class="StdTableCell" style="text-align:center;">
							Edit
						</td>
						<td class="StdTableCell" style="text-align:left;">
							<asp:TextBox ID="txtAppAreaRights3" Text="" runat="server" Width="110"></asp:TextBox>
						</td>
						<td class="StdTableCell" style="text-align:left;">
							<asp:TextBox ID="txtAppAreaRName3" Text="" runat="server" Width="260"></asp:TextBox>&nbsp;
							<asp:HiddenField ID="hfAppAreaRightsID3" runat="server" Value="0"></asp:HiddenField>
						</td>
					</tr>
					<tr>
						<td class="StdTableCell" style="text-align:center;">
							4
						</td>
						<td class="StdTableCell" style="text-align:center;">
							Super User/Approver
						</td>
						<td class="StdTableCell" style="text-align:left;">
							<asp:TextBox ID="txtAppAreaRights4" Text="" runat="server" Width="110"></asp:TextBox>
						</td>
						<td class="StdTableCell" style="text-align:left;">
							<asp:TextBox ID="txtAppAreaRName4" Text="" runat="server" Width="260"></asp:TextBox>&nbsp;
							<asp:HiddenField ID="hfAppAreaRightsID4" runat="server" Value="0"></asp:HiddenField>
						</td>
					</tr>
					<tr>
						<td class="StdTableCell" style="text-align:center;">
							5
						</td>
						<td class="StdTableCell" style="text-align:center;">
							Administrator
						</td>
						<td class="StdTableCell" style="text-align:left;">
							<asp:TextBox ID="txtAppAreaRights5" Text="" runat="server" Width="110"></asp:TextBox>
						</td>
						<td class="StdTableCell" style="text-align:left;">
							<asp:TextBox ID="txtAppAreaRName5" Text="" runat="server" Width="260"></asp:TextBox>&nbsp;
							<asp:HiddenField ID="hfAppAreaRightsID5" runat="server" Value="0"></asp:HiddenField>
						</td>
					</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:center;">
					<asp:Button ID="btnSaveAppAreaData" runat="server" CssClass="button blue-gradient glossy" Text="Save" OnClick="btnSaveAppAreaData_Click" />
					<asp:Button ID="btnCloseThisArea3" runat="server" CssClass="button blue-gradient glossy" Text="Close" OnClick="btnCloseThisArea3_Click" />
				</td>
			</tr>
			</table>

			<div id="divAppAreaEditStatus" style="width:100%;text-align:center;">
				<asp:Label id="lblAppAreaEditStatus" runat="server" ForeColor="Maroon" Font-Bold="true" Text=""></asp:Label>
			</div>
		</div>

    <div id="divUserListGV" style="width:100%;text-align:center;margin-top:10px;" runat="server">
 			<div id="divUserListGrid" style="width:100%;" runat="server">
				<asp:Label ID="lblUserListGrid" runat="server" CssClass="MyHeaderLabel" Text="User Rights" ForeColor="ForestGreen" Font-Size="14pt"></asp:Label><br />
				<table style="margin:auto auto;"><tr><td>
					<asp:GridView ID="gvUserList" runat="server" DataKeyNames="UserID" AllowSorting="True" OnRowDataBound="gvUserList_RowDataBound" OnRowEditing="gvUserList_RowEditing" OnSorting="gvUserList_Sorting" OnSorted="gvUserList_Sorted"
						OnRowUpdated="gvUserList_RowUpdated" OnRowCommand="gvUserList_RowCommand" AutoGenerateColumns="false" AllowPaging="true" PageSize="20" OnPageIndexChanged="gvUserList_PageIndexChanged" OnPageIndexChanging="gvUserList_PageIndexChanging"
						EnableViewState="true" RowStyle-Wrap="true" >
						<HeaderStyle CssClass="TableHdrCell" Font-Size="9pt" />
						<Columns>
							<asp:BoundField DataField="UserID" HeaderText="ID" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="StdTableCell"  />
							<asp:BoundField DataField="UserFullName" HeaderText="User Name" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Left" />
							<asp:BoundField DataField="UserLogin" HeaderText="Login" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Left" />
							<asp:BoundField DataField="EmailAddress" HeaderText="Email Address" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Left" />
							<asp:BoundField DataField="EmpPosition" HeaderText="Position" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Left" ItemStyle-Width="200px" />
							<asp:BoundField DataField="LocationCode" HeaderText="Location" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="StdTableCell" />
							<asp:BoundField DataField="sBeginDate" HeaderText="Begin Date" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="80px" />
							<asp:BoundField DataField="sEndDate" HeaderText="End Date" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="80px" />
							<asp:BoundField DataField="sContractor" HeaderText="Cntr" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="50px" />
							<asp:BoundField DataField="GroupRights" HeaderText="Groups" ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="200px" >
								<ItemStyle Wrap="true"  />
							</asp:BoundField>
							<asp:BoundField DataField="GrpLocations" HeaderText="Locations" ItemStyle-HorizontalAlign="Left" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="160px">
								<ItemStyle Wrap="true" />
							</asp:BoundField>
							<asp:BoundField DataField="sActive" HeaderText="Active" ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="50px" />
							<asp:TemplateField HeaderText="Action"  ItemStyle-CssClass="StdTableCell" >
								<ItemTemplate>
									<asp:Button ID="btnEditRight" runat="server" CommandName="Edit1" CssClass="button blue-gradient glossy" CommandArgument="<%# Container.DataItemIndex %>" Text="Edit" Height="20px" />
									<asp:HiddenField ID="hfUserLastName" runat="server" Value='<%# Eval("UserLastName") %>' />
									<asp:HiddenField ID="hfUserFirstName" runat="server" Value='<%# Eval("UserFirstName") %>' />
									<asp:HiddenField ID="hfUserMiddleName" runat="server" Value='<%# Eval("UserMiddleName") %>' />
									<asp:HiddenField ID="hfEmailAddress" runat="server" Value='<%# Eval("EmailAddress") %>' />
									<asp:HiddenField ID="hfEmpPosition" runat="server" Value='<%# Eval("EmpPosition") %>' />
									<asp:HiddenField ID="hfUserLogin" runat="server" Value='<%# Eval("UserLogin") %>' />
									<asp:HiddenField ID="hfActive" runat="server" Value='<%# Eval("sActive") %>' />
									<asp:HiddenField ID="hfContractor" runat="server" Value='<%# Eval("sContractor") %>' />
									<asp:HiddenField ID="hfUserID" runat="server" Value='<%# Eval("UserID") %>' />
									<asp:HiddenField ID="hfEmpID" runat="server" Value='<%# Eval("EmpID") %>' />
								</ItemTemplate>
							</asp:TemplateField>
						</Columns>
					</asp:GridView>
				</td></tr></table>
 			</div>
			<div id="divUserGroupMembers" style="width:100%;display:none;" runat="server">
				<asp:Label ID="lblUserGroupGrid" runat="server" CssClass="MyHeaderLabel" Text="Rights by User Group" ForeColor="ForestGreen" Font-Size="14pt"></asp:Label><br />
				<table style="margin:auto auto;"><tr><td>
					<asp:GridView ID="gvUserGroupMembers" runat="server" DataKeyNames="UserID" AllowSorting="True" EnableViewState="true" AllowPaging="true" PageSize="20" OnRowCommand="gvUserGroupMembers_RowCommand" AutoGenerateColumns="false" 
						OnSorted="gvUserGroupMembers_Sorted" OnSorting="gvUserGroupMembers_Sorting" 
						OnPageIndexChanged="gvUserGroupMembers_PageIndexChanged" OnPageIndexChanging="gvUserGroupMembers_PageIndexChanging" >
						<HeaderStyle CssClass="TableHdrCell" Font-Size="9pt" />
						<Columns>
							<asp:BoundField DataField="UserID" HeaderText="UserID" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Center" />
							<asp:BoundField DataField="sFullName" HeaderText="Name" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Left" />
							<asp:BoundField DataField="EmpPosition"	HeaderText="Position" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Left" />
							<asp:BoundField DataField="sBeginDate" HeaderText="Begin Date" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Center" />
							<asp:BoundField DataField="sEndDate" HeaderText="End Date" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Center" />
							<asp:BoundField DataField="LocationCode" HeaderText="Loc" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Center" />
							<asp:BoundField DataField="AccessArea" HeaderText="Access Scope" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Center" />
							<asp:TemplateField HeaderText="Action">
								<ItemTemplate>
									<asp:Button ID="btnRemoveMember" runat="server" CommandArgument="<%# Container.DataItemIndex %>" CommandName="Del" Text="Del" CssClass="button blue-gradient glossy" />
									<asp:HiddenField ID="hfUserID" runat="server" Value='<%# Eval("UserID") %>' />
								</ItemTemplate>
							</asp:TemplateField>
						</Columns>
					</asp:GridView>
			
					<div id="divAddNewPerson" style="width:100%;text-align:center;margin-top:10px;margin-bottom:6px;">
						Non-Members:&nbsp;
						<asp:DropDownList ID="ddlGrpNonMembers" runat="server" AppendDataBoundItems="true">
							<asp:ListItem Value="0" Selected="True" Text="None Selected"></asp:ListItem>
						</asp:DropDownList>&nbsp;
						<asp:Button ID="btnAddNewPerson" runat="server" Text="Add Member" CssClass="button blue-gradient glossy" OnClick="btnAddNewPerson_Click" />

					</div>
						
				
				</td></tr></table>

			</div>
    </div>
  </div>

  <div id="divPAGEFOOTER" style="width:98%;margin-left:8px;">
    <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Maroon" Font-Bold="true" Font-Size="Large"></asp:Label>
  </div>

</asp:Content>
