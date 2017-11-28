<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site.Master" AutoEventWireup="true" CodeBehind="RegionPriceTracking.aspx.cs" Inherits="DataMngt.page.RegionPriceTracking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<asp:HiddenField ID="hfPageID" runat="server" Value="52" />

	<script type="text/javascript">
		var jiPageID = 52;

		function ConfirmDelete() {
			if (confirm("Are you sure to want to Delete?") == true)
				return true;
			else
				return false;
		}

	</script>

	<div id="divPAGEHEADER" style="width:99%;margin-top:10px;margin-left:10px;margin-right:10px;" runat="server">
    <table style="width:100%;border-spacing:0px;padding:0px;padding-bottom:4px;margin-right:20px;">
    <tr>
      <td style="width:25%;">
				<span id="spnREgPriceGVLbllit" style="color:blue;font-size:14pt;font-weight:bold;"><asp:Literal ID="RegPriceGVLbllit" runat="server" Text="Region Price Tracking"></asp:Literal></span>
      </td>
      <td style="width:25%;">
				<div id="divUpperBtnBar" runat="server" style="text-align:center;">
					<span id="spnAddNewRowBtn" style="display:inline;" runat="server"><asp:Button ID="btnAddNewRow" runat="server" Text="Add New Row" CssClass="button blue-gradient glossy" OnClick="btnAddNewRow_Click" />&nbsp;&nbsp;</span>
					<span id="spnSaveDataBtn" style="display:none;" runat="server"><asp:Button ID="btnSaveEdit" runat="server" Text="Update" CssClass="button blue-gradient glossy" OnClick="btnSaveEdit_Click" />&nbsp;&nbsp;</span>
					<span id="spnCancelEditBtn" style="display:none;" runat="server"><asp:Button ID="btnCancelEdit" runat="server" Text="Cancel" CssClass="button blue-gradient glossy" OnClick="btnCancelEdit_Click" />&nbsp;&nbsp;</span>
					<asp:Button ID="btnEditCatAvail" runat="server" style="" CssClass="button blue-gradient glossy" OnClick="btnEditCatAvail_Click" Text="View Availability" />&nbsp;
					<asp:CheckBox ID="chkPrinterFriendly" runat="server" AutoPostBack="true" OnCheckedChanged="chkPrinterFriendly_CheckedChanged" />
				</div>
      </td>
      <td style="width:25%;text-align:Center;vertical-align:bottom;">
        <label style="margin-left: 5px;">Sort Data By:</label>
			  <asp:DropDownList ID="ddlDataSort" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlDataSort_SelectedIndexChanged" style="margin-left: 6px;">
					<asp:ListItem Text="Region-Product-Specie" Value="0" Selected="True" />
					<asp:ListItem Text="Product-Specie-Thickness" Value="1" />
					<asp:ListItem Text="Specie-Thickness-Grade" Value="2" />
					<asp:ListItem Text="Product Code" Value="3" />
					<asp:ListItem Text="Price-Product Code" Value="4" />
			  </asp:DropDownList>&nbsp;&nbsp;
				<asp:ImageButton 	ID="imgSortDir" runat="server" ImageUrl="~/Images/arrow2_n.gif" Width="20" Height="20" OnClick="imgSortDir_Click" />
      </td>
      <td style="width:25%;text-align:right;">
        <label style="margin-left: 5px;">Items per Page:</label>
			  <asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged" style="margin-left: 6px;">
					<asp:ListItem Text="10" Value="10" />
					<asp:ListItem Text="20" Value="20" Selected="True" />
					<asp:ListItem Text="25" Value="25" />
					<asp:ListItem Text="50" Value="50" />
					<asp:ListItem Text="100" Value="100" />
					<asp:ListItem Text="250" Value="250" />
			  </asp:DropDownList>&nbsp;&nbsp;
      </td>
    </tr>
    </table>
	</div>

	<div id="divPAGEMAINSECTION" style="width:99%;margin-left:10px;" runat="server">

    <div id="divItemEdit" runat="server" style="width:100%;text-align:center;display:none;">
			<asp:Label ID="lblEditMsg" runat="server" style="font-style:italic;color:maroon;font-weight:bold;" Text="Edit Item Data Below and click on SAVE button:"></asp:Label><br />
      <table style="padding:4px;margin:auto auto;"><tr><td>
			<table style="background-color:antiquewhite;margin:auto auto;">
      <tr>
        <td style="text-align:right;vertical-align:top;">
          Region:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:DropDownList ID="ddlRegionE" runat="server" AppendDataBoundItems="true">
						<asp:ListItem Value="0" Text="ALL" Selected="True"></asp:ListItem>
						<asp:ListItem Value="APP" Text="Appalacian"></asp:ListItem>
						<asp:ListItem Value="GLA" Text="Glacial"></asp:ListItem>
						<asp:ListItem Value="NORTH" Text="North"></asp:ListItem>
						<asp:ListItem Value="WEST" Text="West"></asp:ListItem>
          </asp:DropDownList>
          &nbsp;&nbsp;&nbsp;ID:&nbsp;<asp:Label ID="lblCatDataIDE" runat="server" Text="0" Font-Bold="true" ForeColor="Blue"></asp:Label>
        </td>
        <td>
          &nbsp;
        </td>
        <td style="text-align:right;vertical-align:top;">
          Is&nbsp;Tracked:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:DropDownList ID="ddlIsTrackedE" runat="server" AppendDataBoundItems="true">
            <asp:ListItem Value="1" Text="Yes" Selected="True"></asp:ListItem>
            <asp:ListItem Value="0" Text="No"></asp:ListItem>
          </asp:DropDownList>
        </td>
        <td>
          &nbsp;
        </td>
        <td style="text-align:right;vertical-align:top;">
          Is&nbsp;Managed:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:DropDownList ID="ddlIsManagedE" runat="server" AppendDataBoundItems="true">
            <asp:ListItem Value="1" Text="Yes" Selected="True"></asp:ListItem>
            <asp:ListItem Value="0" Text="No"></asp:ListItem>
          </asp:DropDownList>
        </td>
      </tr>
      <tr>
        <td style="text-align:right;vertical-align:top;">
          Product Code (ID):&nbsp;
        </td>
        <td style="text-align:left;vertical-align:top;">
          <asp:TextBox ID="txtProductE" runat="server" Width="200px" OnTextChanged="txtProductE_TextChanged" ></asp:TextBox>
        </td>
        <td>
          &nbsp;
        </td>
        <td style="text-align:right;vertical-align:top;">
          Description:&nbsp;
        </td>
        <td style="text-align:left;" colspan="4">
          <asp:TextBox ID="txtProdDescE" runat="server" Width="500px" Height="40px" TextMode="MultiLine"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td style="text-align:right;vertical-align:top;">
          Thickness:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:DropDownList ID="ddlItemThicknessE" runat="server" AppendDataBoundItems="true">
						<asp:ListItem Value="0" Selected="True" Text="None Selected"></asp:ListItem>
          </asp:DropDownList>
        </td>
        <td>
          &nbsp;
        </td>
        <td style="text-align:right;vertical-align:top;">
          Specie:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:DropDownList ID="ddlItemSpeciesE" runat="server" AppendDataBoundItems="true">
						<asp:ListItem Value="0" Selected="True" Text="None Selected"></asp:ListItem>
          </asp:DropDownList>
        </td>
        <td>
          &nbsp;
        </td>
        <td style="text-align:right;vertical-align:top;">
          Grade:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:DropDownList ID="ddlItemGradeE" runat="server" AppendDataBoundItems="true">
						<asp:ListItem Value="0" Selected="True" Text="None Selected"></asp:ListItem>
          </asp:DropDownList>
        </td>
      </tr>
      <tr>
        <td style="text-align:right;vertical-align:top;">
          Length:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:DropDownList ID="ddlItemLengthE" runat="server" AppendDataBoundItems="true">
						<asp:ListItem Value="0" Selected="True" Text="None Selected"></asp:ListItem>
						<asp:ListItem Value="" Text=""></asp:ListItem>
          </asp:DropDownList>
        </td>
        <td>
          &nbsp;
        </td>
        <td style="text-align:right;vertical-align:top;">
          Color:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:DropDownList ID="ddlItemColorE" runat="server" AppendDataBoundItems="true">
						<asp:ListItem Value="0" Selected="True" Text="None Selected"></asp:ListItem>
          </asp:DropDownList>
        </td>
        <td>
          &nbsp;
        </td>
        <td style="text-align:right;vertical-align:top;">
          Sort:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:DropDownList ID="ddlItemSortE" runat="server" AppendDataBoundItems="true">
						<asp:ListItem Value="0" Selected="True" Text="None Selected"></asp:ListItem>
          </asp:DropDownList>
        </td>
      </tr>
      <tr>
        <td style="text-align:right;vertical-align:top;">
          Milling:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:DropDownList ID="ddlItemMillingE" runat="server" AppendDataBoundItems="true">
						<asp:ListItem Value="0" Selected="True" Text="None Selected"></asp:ListItem>
          </asp:DropDownList>
        </td>
        <td>
          &nbsp;
        </td>
        <td style="text-align:right;vertical-align:top;">
          NoPrint:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:DropDownList ID="ddlItemNoPrintE" runat="server" AppendDataBoundItems="true">
						<asp:ListItem Value="0" Selected="True" Text="None Selected"></asp:ListItem>
          </asp:DropDownList>
        </td>
        <td>
          &nbsp;
        </td>
        <td style="text-align:right;vertical-align:top;">
          Price p/MBF:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:TextBox ID="txtPriceE" runat="server" Width="100px" style="text-align:right;"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td style="text-align:right;vertical-align:top;">
          Comments:&nbsp;
        </td>
        <td style="text-align:left;" colspan="7">
          <asp:TextBox ID="txtCommentPmE" runat="server" Width="600px"></asp:TextBox>
        </td>
      </tr>
      </table>
			</td></tr></table>

    </div>

		<div id="divGVRegPriceLbl" runat="server" style="margin-top:10px">
			<table id="tblGVHdr" style="width:100%;border-spacing:0px;padding:1px;font-size:10pt;">
			<tr>
				<td style="vertical-align:top;" rowspan="2">
					<asp:Label ID="lblMainFilters" Text="FILTERS:" runat="server" ForeColor="Blue" Font-Bold="true"></asp:Label>
				</td>
				<td style="vertical-align:top;">
					<asp:Label ID="lblManagedF" Text="Managed Only" runat="server"></asp:Label>
				</td>
				<td rowspan="2">
					&nbsp;
				</td>
        <td style="text-align:left;vertical-align:top;">
          Region:&nbsp;
        </td>
				<td rowspan="2">
					&nbsp;
				</td>
        <td style="text-align:left;vertical-align:top;">
          Specie:&nbsp;
        </td>
				<td rowspan="2">
					&nbsp;
				</td>
        <td style="text-align:left;vertical-align:top;">
          Grade:&nbsp;
        </td>
				<td rowspan="2">
					&nbsp;
				</td>
        <td style="text-align:left;vertical-align:top;">
          Thickness:&nbsp;
        </td>
				<td rowspan="2">
					&nbsp;
				</td>
        <td style="text-align:left;vertical-align:top;">
          Length:&nbsp;
        </td>
        <td rowspan="2">
          &nbsp;
        </td>
        <td style="text-align:left;vertical-align:top;">
          Color:&nbsp;
        </td>
        <td rowspan="2">
          &nbsp;
        </td>
        <td style="text-align:left;vertical-align:top;">
          Sort:&nbsp;
        </td>
        <td rowspan="2">
          &nbsp;
        </td>
        <td style="text-align:left;vertical-align:top;">
          Milling:&nbsp;
        </td>
        <td rowspan="2">
          &nbsp;
        </td>
        <td style="text-align:left;vertical-align:top;">
          NoPrint:&nbsp;
        </td>
        <td rowspan="2">
          &nbsp;
        </td>
        <td style="text-align:left;vertical-align:top;">
          Comment Text:&nbsp;
        </td>
        <td rowspan="2">
          &nbsp;
        </td>
			</tr>
			<tr>
				<td style="vertical-align:top;">
					<asp:CheckBox ID="chkManagedOnly" runat="server" />
				</td>
        <td style="text-align:left;">
          <asp:DropDownList ID="ddlRegionF" runat="server" AppendDataBoundItems="true" Font-Size="Smaller" AutoPostBack="true">
						<asp:ListItem Value="0" Text="ALL" Selected="True"></asp:ListItem>
						<asp:ListItem Value="APP" Text="Appalachian"></asp:ListItem>
						<asp:ListItem Value="GLA" Text="Glacial"></asp:ListItem>
						<asp:ListItem Value="NORTH" Text="North"></asp:ListItem>
						<asp:ListItem Value="WEST" Text="West"></asp:ListItem>
          </asp:DropDownList>
        </td>
        <td style="text-align:left;">
          <asp:DropDownList ID="ddlSpeciesF" runat="server" AppendDataBoundItems="true" Font-Size="Smaller" >
						<asp:ListItem Value="0" Selected="True" Text="ALL"></asp:ListItem>
          </asp:DropDownList>
        </td>
        <td style="text-align:left;">
          <asp:DropDownList ID="ddlGradeF" runat="server" AppendDataBoundItems="true" Font-Size="Smaller">
						<asp:ListItem Value="0" Selected="True" Text="ALL"></asp:ListItem>
          </asp:DropDownList>
        </td>
        <td style="text-align:left;">
          <asp:DropDownList ID="ddlThicknessF" runat="server" AppendDataBoundItems="true" Font-Size="Smaller">
						<asp:ListItem Value="0" Selected="True" Text="ALL"></asp:ListItem>
          </asp:DropDownList>
        </td>
        <td style="text-align:left;">
          <asp:DropDownList ID="ddlLengthF" runat="server" AppendDataBoundItems="true" Font-Size="Smaller">
						<asp:ListItem Value="0" Selected="True" Text="ALL"></asp:ListItem>
						<asp:ListItem Value="" Text=""></asp:ListItem>
          </asp:DropDownList>
        </td>
        <td style="text-align:left;">
          <asp:DropDownList ID="ddlColorF" runat="server" AppendDataBoundItems="true" Font-Size="Smaller">
						<asp:ListItem Value="0" Selected="True" Text="ALL"></asp:ListItem>
          </asp:DropDownList>
        </td>
        <td style="text-align:left;">
          <asp:DropDownList ID="ddlSortF" runat="server" AppendDataBoundItems="true" Font-Size="Smaller">
						<asp:ListItem Value="0" Selected="True" Text="ALL"></asp:ListItem>
          </asp:DropDownList>
        </td>
        <td style="text-align:left;">
          <asp:DropDownList ID="ddlMillingF" runat="server" AppendDataBoundItems="true" Font-Size="Smaller">
						<asp:ListItem Value="0" Selected="True" Text="ALL"></asp:ListItem>
          </asp:DropDownList>
        </td>
        <td style="text-align:left;">
          <asp:DropDownList ID="ddlNoPrintF" runat="server" AppendDataBoundItems="true" Font-Size="Smaller">
						<asp:ListItem Value="0" Selected="True" Text="ALL"></asp:ListItem>
          </asp:DropDownList>
        </td>
        <td style="text-align:left;">
					<asp:TextBox ID="txtCommentsF" runat="server" AutoPostBack="true" Font-Size="Smaller"></asp:TextBox>
        </td>
				<td>
					<asp:Button ID="btnRefreshDataGrid" runat="server" OnClick="btnRefreshDataGrid_Click" CssClass="button blue-gradient glossy" Text="Refresh Data" />
				</td>
			</tr>
			</table>

		</div>

		<div id="divRegionPriceGV" style="width:100%;text-align:center;margin-top:4px;margin-bottom:4px;">
			<asp:GridView ID="gvRegionPriceTrack" runat="server" AllowPaging="true" PageSize="20" AllowSorting="true" AlternatingRowStyle-BackColor="#dddddd" BorderColor="#009999" AutoGenerateColumns="false"
				OnPageIndexChanged="gvRegionPriceTrack_PageIndexChanged" OnDataBound="gvRegionPriceTrack_DataBound" OnPageIndexChanging="gvRegionPriceTrack_PageIndexChanging" OnRowDataBound="gvRegionPriceTrack_RowDataBound2"
				OnRowCommand="gvRegionPriceTrack_RowCommand" OnDataBinding="gvRegionPriceTrack_DataBinding" DataKeyNames="CatDataID">
				<HeaderStyle CssClass="ColHeaderStd" />
				<Columns>
					<asp:TemplateField HeaderText="ID">
						<EditItemTemplate>
							<asp:Label id="lblRegPTID" runat="server" Text='<%# Eval("ProductManagedID") %>' Enabled="false"></asp:Label>
						</EditItemTemplate>
						<ItemTemplate>
							<asp:Label id="lblRegPTID" runat="server" Text='<%# Eval("CatDataID") %>' Enabled="false"></asp:Label>
							<asp:HiddenField ID="hfProdID" runat="server" Value='<%# Eval("ProdID") %>' />
						</ItemTemplate>
						<ItemStyle CssClass="GridViewPadding" Height="26px" HorizontalAlign="Center" Width="50" />
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Actv">
						<ItemTemplate>
							<asp:Label id="lblRegPTTrack" runat="server" Text='<%# Eval("sIsActive") %>' Enabled="false"></asp:Label>
						</ItemTemplate>
						<ItemStyle CssClass="GridViewPadding" Height="20px" HorizontalAlign="Center" Width="46" />
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Mng">
						<ItemTemplate>
							<asp:CheckBox ID="chkRegPTManaged" runat="server" Checked="false" AutoPostBack="true" CommandArgument="<%# Container.DataItemIndex %>" CommandName="MngdEdit" OnCheckedChanged="chkRegPTManaged_CheckedChanged" />
						</ItemTemplate>
						<ItemStyle CssClass="GridViewPadding" Height="20px" HorizontalAlign="Center" Width="46" />
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Specie">
						<ItemTemplate>
							<asp:Label id="lblRegPTSpecie" runat="server" Text='<%# Eval("Specie") %>' Enabled="false"></asp:Label>
						</ItemTemplate>
						<ItemStyle CssClass="GridViewPadding" Height="20px" HorizontalAlign="Center" Width="80" />
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Thickness">
						<ItemTemplate>
							<asp:Label id="lblRegPTThick" runat="server" Text='<%# Eval("Thickness") %>' Enabled="false"></asp:Label>
						</ItemTemplate>
						<ItemStyle CssClass="GridViewPadding" Height="20px" HorizontalAlign="Center" Width="80" />
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Grade">
						<ItemTemplate>
							<asp:Label id="lblRegPTGrade" runat="server" Text='<%# Eval("Grade") %>' Enabled="false"></asp:Label>
						</ItemTemplate>
						<ItemStyle CssClass="GridViewPadding" Height="20px" HorizontalAlign="Center" Width="80" />
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Region">
						<ItemTemplate>
							<asp:Label id="lblRegPTRegion" runat="server" Text='<%# Eval("Region") %>' Enabled="false"></asp:Label>
						</ItemTemplate>
						<ItemStyle CssClass="GridViewPadding" Height="20px" HorizontalAlign="Center" Width="70" />
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Product">
						<ItemTemplate>
							<asp:Label id="lblRegPTProduct" runat="server" Text='<%# Eval("ProdID") %>' Enabled="false"></asp:Label>
						</ItemTemplate>
						<ItemStyle CssClass="GridViewPadding" Height="20px" Width="64px" />
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Description">
						<ItemTemplate>
							<asp:Label id="lblRegPTProdDesc" runat="server" Text='<%# Eval("Product") %>' Enabled="false"></asp:Label>
						</ItemTemplate>
						<ItemStyle CssClass="GridViewPadding" Height="20px" Width="336px" HorizontalAlign="Left" />
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Length">
						<ItemTemplate>
							<asp:Label id="lblRegPTProdLen" runat="server" Text='<%# Eval("Length") %>' Enabled="false"></asp:Label>
						</ItemTemplate>
						<ItemStyle CssClass="GridViewPadding" Height="20px" Width="140px" />
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Color">
						<ItemTemplate>
							<asp:Label id="lblRegPTProdColor" runat="server" Text='<%# Eval("Color") %>' Enabled="false"></asp:Label>
						</ItemTemplate>
						<ItemStyle CssClass="GridViewPadding" Height="20px" Width="140px" />
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Sort">
						<ItemTemplate>
							<asp:Label id="lblRegPTProdSort" runat="server" Text='<%# Eval("Sort") %>' Enabled="false"></asp:Label>
						</ItemTemplate>
						<ItemStyle CssClass="GridViewPadding" Height="20px" Width="140px" />
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Milling">
						<ItemTemplate>
							<asp:Label id="lblRegPTProdMilling" runat="server" Text='<%# Eval("Milling") %>' Enabled="false"></asp:Label>
						</ItemTemplate>
						<ItemStyle CssClass="GridViewPadding" Height="20px" Width="140px" />
					</asp:TemplateField>
					<asp:TemplateField HeaderText="NoPrint">
						<ItemTemplate>
							<asp:Label id="lblRegPTProdNoPrint" runat="server" Text='<%# Eval("NoPrint") %>' Enabled="false"></asp:Label>
						</ItemTemplate>
						<ItemStyle CssClass="GridViewPadding" Height="20px" Width="140px" />
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Price" ItemStyle-HorizontalAlign="Right">
						<ItemTemplate>
							<asp:TextBox ID="txtRegPTPrice" runat="server" Text='<%# Eval("sPrice") %>' AutoPostBack="true" Width="90" CssClass="NumberInputBox" CommandArgument="<%# Container.DataItemIndex %>" CommandName="PriceEdit" OnTextChanged="txtRegPTPrice_TextChanged"></asp:TextBox>
						</ItemTemplate>
						<ItemStyle CssClass="GridViewPadding" Height="20px" Width="94" />
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Comments">
						<ItemTemplate>
							<asp:TextBox ID="txtRegPTComment" runat="server" Text='<%# Eval("Comments") %>' AutoPostBack="true" CommandArgument="<%# Container.DataItemIndex %>" CommandName="CommentEdit" OnTextChanged="txtRegPTComment_TextChanged" Width="220"></asp:TextBox>
						</ItemTemplate>
						<ItemStyle CssClass="GridViewPadding" Height="20px" HorizontalAlign="Left" Width="224px" />
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Action" ItemStyle-Width="130px">
						<ItemTemplate>
							<div id="divGVBtnRow" style="width:130px;text-align:center;padding:1px;height:20px;">
								<table style="padding:0px;border-spacing:0px;width:100%;height:22px;line-height:16px;">
								<tr>
									<td style="width:50%;text-align:center;">
										<asp:Button ID="btnEditRight" runat="server" CommandName="Edit1" CssClass="button blue-gradient glossy" CommandArgument="<%# Container.DataItemIndex %>" Text="Edit" Height="20px" Width="42px" />
									</td>
									<td style="width:50%;text-align:center;">
										<asp:Button ID="btnDelRight" runat="server" CommandName="Delete1" CssClass="button blue-gradient glossy" CommandArgument="<%# Container.DataItemIndex %>" Text="Del" Height="20px" Width="42px" />
									</td>
									<td style="width:50%;text-align:center;">
										<asp:Button ID="Button1" runat="server" CommandName="New1" CssClass="button blue-gradient glossy" CommandArgument="<%# Container.DataItemIndex %>" Text="New" Height="20px" Width="42px" />
									</td>
								</tr>
								</table>
							</div>
						</ItemTemplate>
						<ItemStyle CssClass="GridViewPadding" HorizontalAlign="Center" />
					</asp:TemplateField>
				</Columns>
			</asp:GridView>

		</div>

	</div>

	<div id="divPAGEFOOTER" style="width:99%;">

		<div id="divErrorMsgLbl" style="width:100%;padding-left:10px;">
			<asp:Label ID="lblErrorMsg" runat="server" style="color:maroon;font-size:11pt;font-weight:bold;"></asp:Label>
		</div>

	</div>

</asp:Content>
