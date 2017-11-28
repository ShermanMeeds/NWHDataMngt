<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site.Master" AutoEventWireup="true" CodeBehind="SearchProducts.aspx.cs" Inherits="DataMngt.page.SearchProducts" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<asp:HiddenField ID="hfPageID" runat="server" Value="53" />

	<div id="divPAGEHEADER" style="width:99%;margin-left:10px;text-align:center;">
		<asp:Label ID="lblMainHdr" runat="server" Font-Size="14pt" ForeColor="Blue" Font-Bold="true" Text="Search Product Data"></asp:Label>
	</div>

	<div id="divPAGEMAIN" style="width:99%;margin-left:10px;margin-bottom: 0px;">

    <div id="divGridFilters" runat="server" style="width:100%;text-align:center;margin-top:2px;margin-bottom:8px;background-color:whitesmoke;" class="MyFilterCriteria">
			<div id="divGridFiltersHdr" runat="server" style="width:100%;text-align:left;">
				<asp:Label ID="lblFilterHdr" runat="server" Font-Size="12pt" ForeColor="Blue" Font-Bold="true" Text="Filters:"></asp:Label>
                <table style="width:99%">
                    <tr>
                        <td style="border-style: solid; border-color: inherit; border-width: medium; width: 387px; vertical-align: top;">
                            <table>
                                <tr>
                                    <td style="font-weight:bold; height: 40px;">
                                        Search by ...
                                    </td>
                                    <td style="width: 295px; height: 40px;">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right; vertical-align: top;">Type
                                    </td>
                                    <td style="text-align: left; vertical-align: top; width: 295px;">
                                        <asp:DropDownList ID="drpProdTypes" runat="server" CssClass="silver-bg" Height="16px" Width="100px" AutoPostBack="true" OnSelectedIndexChanged="drpProdTypes_SelectedIndexChanged" DataTextField="code" DescriptionField="code">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right; vertical-align: top;">Code
                                    </td>
                                    <td style="text-align: left; vertical-align: top; width: 295px;">
                                        <asp:DropDownList ID="drpCodeList" runat="server" CssClass="silver-bg" Height="16px" Width="100px" AutoPostBack="true" OnSelectedIndexChanged="drpCodeList_SelectedIndexChanged" TabIndex="1" DataTextField="code" DescriptionField="code" Enabled="False">
                                        </asp:DropDownList>
                                        &nbsp;&nbsp;&nbsp;&nbsp;Direct&nbsp;&nbsp;<asp:TextBox ID="txtCode" CssClass="TextFilterBoxStd" runat="server" Width="69px" Enabled="False" AutoPostBack="true" OnTextChanged="txtCode_TextChanged"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                    <td style="font-weight:bold; text-align: center;">
                                        --- Or By ---
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right; vertical-align: top;">Description
                                    </td>
                                    <td style="text-align: left; vertical-align: top; width: 295px;">
                                      <asp:TextBox ID="txtProdDesc" runat="server" CssClass="TextFilterBoxStd" MaxLength="255" OnTextChanged="txtProdDesc_TextChanged" Width="293px" TabIndex="2">
                                      </asp:TextBox>  
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="border:solid; width:100%">
                            <table>
                                <tr>
                                    <td style="font-weight:bold; width: 8%;">
                                        Or by ...
                                    </td>
                                    <td style="width: 26%; text-align: right">Product Type&nbsp;&nbsp;
                                        <asp:DropDownList ID="drpProFilter" runat="server" AutoPostBack="True" CssClass="silver-bg" Height="16px" Width="200px" OnSelectedIndexChanged="drpProFilter_SelectedIndexChanged" TabIndex="0" DataTextField="code" DescriptionField="code"> 
                                        </asp:DropDownList>

                                    </td>
                                    <td style="width: 8%;">

                                    </td>
                                    <td style="width: 25%;">

                                    </td>
                                    <td style="width: 8%;">

                                    </td>
                                    <td style="width: 25%;">

                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right; vertical-align: top; ">
                                        Specie
                                    </td>
                                    <td style="text-align: right; vertical-align: top;">                                        
                                        <asp:DropDownList ID="drpSpecie" runat="server" CssClass="drop-down" Width="300px" AutoPostBack="true" OnSelectedIndexChanged="drpSpecie_SelectedIndexChanged" DataValueField="code" DataTextField="Description" Enabled="False">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="text-align: right; vertical-align: top;">
                                        Rework
                                    </td>
                                    <td style="text-align: right; vertical-align: top;">                                      
                                        <asp:DropDownList ID="drpRework" runat="server" CssClass="drop-down" Width="300px" AutoPostBack="true" OnSelectedIndexChanged="drpRework_SelectedIndexChanged" TabIndex="5"  DataValueField="code" DataTextField="Description" Enabled="False">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="text-align: right; vertical-align: top;">
                                        Width
                                    </td>
                                    <td style="text-align: right; vertical-align: top;">                                    
                                        <asp:DropDownList ID="drpWidth" runat="server" CssClass="drop-down" Width="300px" AutoPostBack="true" OnSelectedIndexChanged="drpWidth_SelectedIndexChanged" TabIndex="10" DataValueField="code" DataTextField="Description" Enabled="False">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right; vertical-align: top;">
                                       Color 
                                    </td>
                                    <td style="text-align: right; vertical-align: top;">                                      
                                        <asp:DropDownList ID="drpColor" runat="server" CssClass="drop-down" Width="300px" AutoPostBack="true" OnSelectedIndexChanged="drpColor_SelectedIndexChanged" TabIndex="1"  DataValueField="code" DataTextField="Description" Enabled="False">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="text-align: right; vertical-align: top;">
                                        Sort
                                    </td>
                                    <td style="text-align: right; vertical-align: top;">                                      
                                        <asp:DropDownList ID="drpSort" runat="server" CssClass="drop-down" Width="300px" AutoPostBack="true" OnSelectedIndexChanged="drpSort_SelectedIndexChanged" TabIndex="6"  DataValueField="code" DataTextField="Description" Enabled="False">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="text-align: right; vertical-align: top;">
                                        Length
                                    </td>
                                    <td style="text-align: right; vertical-align: top;">                                    
                                        <asp:DropDownList ID="drpLength" runat="server" CssClass="drop-down" Width="300px" AutoPostBack="true" OnSelectedIndexChanged="drpLength_SelectedIndexChanged" TabIndex="11"  DataValueField="code" DataTextField="Description" Enabled="False">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right; vertical-align: top;">
                                       Grade 
                                    </td>
                                    <td style="text-align: right; vertical-align: top;">                                      
                                        <asp:DropDownList ID="drpGrade" runat="server" CssClass="drop-down" Width="300px" AutoPostBack="true" OnSelectedIndexChanged="drpGrade_SelectedIndexChanged" TabIndex="2"  DataValueField="code" DataTextField="Description" Enabled="False">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="text-align: right; vertical-align: top;">
                                        Certification
                                    </td>
                                    <td style="text-align: right; vertical-align: top;">                                      
                                        <asp:DropDownList ID="drpCert" runat="server" CssClass="drop-down" Width="300px" AutoPostBack="true" OnSelectedIndexChanged="drpCert_SelectedIndexChanged" TabIndex="7"  DataValueField="code" DataTextField="Description" Enabled="False">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="text-align: right; vertical-align: top;">
                                        Thickness
                                    </td>
                                    <td style="text-align: Left; vertical-align: top;">                                    
                                        <asp:DropDownList ID="drpThickness" runat="server" CssClass="drop-down" Width="300px" AutoPostBack="true" OnSelectedIndexChanged="drpThickness_SelectedIndexChanged" TabIndex="11" DataValueField="code" DataTextField="Description" Enabled="False">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right; vertical-align: top;">
                                        Seasoning
                                    </td>
                                    <td style="text-align: right; vertical-align: top;">                                      
                                        <asp:DropDownList ID="drpDryness" runat="server" CssClass="drop-down" Width="300px" AutoPostBack="true" OnSelectedIndexChanged="drpDryness_SelectedIndexChanged" TabIndex="3"  DataValueField="code" DataTextField="Description" Enabled="False">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="text-align: right; vertical-align: top;">
                                        Others
                                    </td>
                                    <td style="text-align: right; vertical-align: top;">                                      
                                        <asp:DropDownList ID="drpOthers" runat="server" CssClass="drop-down" Width="300px" AutoPostBack="true" OnSelectedIndexChanged="drpOthers_SelectedIndexChanged" TabIndex="8"  DataValueField="code" DataTextField="Description" Enabled="False">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="text-align: right; vertical-align: top;">
                                        Additional 1
                                    </td>
                                    <td style="text-align: Left; vertical-align: top;">                                     
                                        <asp:DropDownList ID="drpAdd1" runat="server" CssClass="drop-down" Width="300px" AutoPostBack="true" OnSelectedIndexChanged="drpAdd1_SelectedIndexChanged" TabIndex="13"  DataValueField="code" DataTextField="Description" Enabled="False">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: right; vertical-align: top;">
                                      Surface  
                                    </td>
                                    <td style="text-align: right; vertical-align: top;">                                      
                                        <asp:DropDownList ID="drpSurface" runat="server" CssClass="drop-down" Width="300px" AutoPostBack="true" OnSelectedIndexChanged="drpSurface_SelectedIndexChanged" TabIndex="4"  DataValueField="code" DataTextField="Description" Enabled="False">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="text-align: right; vertical-align: top;">
                                        Owner                                    
                                    </td>
                                    <td style="text-align: right; vertical-align: top;">                                                                           
                                        <asp:DropDownList ID="drpOwner" runat="server" CssClass="drop-down" Width="300px" AutoPostBack="true" OnSelectedIndexChanged="drpOwner_SelectedIndexChanged" TabIndex="9"  DataValueField="code" DataTextField="Description" Enabled="False">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="text-align: right; vertical-align: top;">
                                        Additional 2
                                    </td>
                                    <td style="text-align: right; vertical-align: top;">                                    
                                        <asp:DropDownList ID="drpAdd2" runat="server" CssClass="drop-down" Width="300px" AutoPostBack="true" OnSelectedIndexChanged="drpAdd2_SelectedIndexChanged" TabIndex="14"  DataValueField="code" DataTextField="Description" Enabled="False">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 387px; height: 21px;">
                            <asp:Label ID="lblItmPerPage" runat="server" Text="Items per Page:"></asp:Label>
                        </td>
                        <td style="height: 21px">
                            <asp:DropDownList ID="drpPageSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="drpPageSize_SelectedIndexChanged">
						        <asp:ListItem Text="10" Value="10" />
						        <asp:ListItem Text="20" Value="20" Selected="True" />
						        <asp:ListItem Text="25" Value="25" />
						        <asp:ListItem Text="50" Value="50" />
						        <asp:ListItem Text="100" Value="100" />
						        <asp:ListItem Text="250" Value="250" />
					        </asp:DropDownList>
                            &nbsp;&nbsp;
                            <asp:Label ID="lblSrchError" runat="server" Width="1000px"></asp:Label>
                        </td>
                    </tr>
                </table>
			</div>

      <asp:Button ID="btnRefilterDataGrid" runat="server" CssClass="button blue-gradient glossy" OnClick="btnRefilterDataGrid_Click"	Text="Load Grid" TabIndex="1" />
    </div>

        <asp:Label ID="lblErrorMsg" runat="server" CssClass="StdErrorMode"></asp:Label>

    <div id="divDataGrid" runat="server" style="width:100%;">
			<div id="divDataGridHdr" style="width:100%;text-align:center;">
				<table id="tblDataGridHdr" style="margin:90%;padding:0px;border-spacing:0px;margin: auto auto;">
				<tr>
					<td style="width:50%; font-size: 12pt; color: #0000FF;">
						<span class="bold">Products Matching the Search Criteria</span></td>
					<td style="width:50%;text-align:right;">
						&nbsp;</td>
				</tr>
				</table>
			</div>

			<asp:GridView ID="gvMainData" runat="server" AllowPaging="True" AlternatingRowStyle-BackColor="#ccffcc" BorderColor="#009999" DataKeyNames="ProductLinkId" EmptyDataText="No entries found."
				AutoGenerateColumns="False" HorizontalAlign="Center" AllowSorting="False" EnableSortingAndPagingCallbacks="False" Width="1489px" Visible="True" ShowHeaderWhenEmpty="True"
                OnPageIndexChanged="gvMainData_PageIndexChanged" OnPageIndexChanging="gvMainData_PageIndexChanging">
                <AlternatingRowStyle BackColor="#CCFFCC"></AlternatingRowStyle>
				<Columns>
                    <asp:TemplateField ItemStyle-HorizontalAlign="center" HeaderStyle-Width="30px" HeaderStyle-CssClass="table-header">
                        <HeaderTemplate>
                            <br />
                            Version
                        </HeaderTemplate> 
                        <ItemTemplate>
                            <asp:Label ID="lblOld" runat="server" Text="Old" Font-Bold="True" ></asp:Label>
                            <hr/>
                            <asp:Label ID="lblNew" runat="server" Text="New" Font-Bold="True" ></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-HorizontalAlign="center" HeaderStyle-Width="25px" HeaderStyle-CssClass="table-header">
                        <HeaderTemplate>
                            <br />
                            Type
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="OldProductType" runat="server" ReadOnly="true" Width="25px" Text='<%# Eval("OldProductType") %>'></asp:Label><br /><hr>
                            <asp:Label ID="NewProductType" runat="server" ReadOnly="true" Width="25px" Text='<%# Eval("NewProductType") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="45px" HeaderStyle-CssClass="table-header">
                        <HeaderTemplate>
                            <br />
                            Code
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="OldProductCode" runat="server" ReadOnly="true" Width="40px" Text='<%# Eval("OldProductCode") %>'></asp:Label><br /><hr>
                            <asp:Label ID="NewProductCode" runat="server" ReadOnly="true" Width="40px" Text='<%# Eval("NewProductCode") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-HorizontalAlign="center" HeaderStyle-Width="374px" HeaderStyle-CssClass="table-header">
                        <HeaderTemplate>
                            <br />
                            Description
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="OldProductDescription" runat="server" ReadOnly="true" Width="370px" Text='<%# Eval("OldProductDescription") %>'></asp:Label><br /><hr>
                            <asp:Label ID="NewProductDescription" runat="server" ReadOnly="true" Width="370px" Text='<%# Eval("NewProductDescription") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-HorizontalAlign="center" HeaderStyle-Width="80px" HeaderStyle-CssClass="table-header">
                        <HeaderTemplate>
                            Desc 1<br />
                            Attrib 1
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="OldDesc1" runat="server" ReadOnly="true" Width="75px" Text='<%# Eval("OldDesc1") %>'></asp:Label><br /><hr />
                            <asp:Label ID="NewDesc1" runat="server" ReadOnly="true" Width="75px" Text='<%# Eval("NewDesc1") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-HorizontalAlign="center" HeaderStyle-Width="80px" HeaderStyle-CssClass="table-header">
                        <HeaderTemplate>
                            Desc 2<br />
                            Attrib 2
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="OldDesc2" runat="server" ReadOnly="true" Width="75px" Text='<%# Eval("OldDesc2") %>'></asp:Label><br /><hr />
                            <asp:Label ID="NewDesc2" runat="server" ReadOnly="true" Width="75px" Text='<%# Eval("NewDesc2") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-HorizontalAlign="center" HeaderStyle-Width="80px" HeaderStyle-CssClass="table-header">
                        <HeaderTemplate>
                            Desc 3<br />
                            Attrib 3
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="OldDesc3" runat="server" ReadOnly="true" Width="75px" Text='<%# Eval("OldDesc3") %>'></asp:Label><br /><hr />
                            <asp:Label ID="NewDesc3" runat="server" ReadOnly="true" Width="75px" Text='<%# Eval("NewDesc3") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-HorizontalAlign="center" HeaderStyle-Width="80px" HeaderStyle-CssClass="table-header">
                        <HeaderTemplate>
                            Desc 4<br />
                            Attrib 4
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="OldDesc4" runat="server" ReadOnly="true" Width="75px" Text='<%# Eval("OldDesc4") %>'></asp:Label><br /><hr />
                            <asp:Label ID="NewDesc4" runat="server" ReadOnly="true" Width="75px" Text='<%# Eval("NewDesc4") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-HorizontalAlign="center" HeaderStyle-Width="80px" HeaderStyle-CssClass="table-header">
                        <HeaderTemplate>
                            Desc 5<br />
                            Attrib 5
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="OldDesc5" runat="server" ReadOnly="true" Width="75px" Text='<%# Eval("OldDesc5") %>'></asp:Label><br /><hr />
                            <asp:Label ID="NewDesc5" runat="server" ReadOnly="true" Width="75px" Text='<%# Eval("NewDesc5") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-HorizontalAlign="center" HeaderStyle-Width="80px" HeaderStyle-CssClass="table-header">
                        <HeaderTemplate>
                            Desc 6<br />
                            Attrib 6
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="OldDesc6" runat="server" ReadOnly="true" Width="75px" Text='<%# Eval("OldDesc6") %>'></asp:Label><br /><hr />
                            <asp:Label ID="NewDesc6" runat="server" ReadOnly="true" Width="75px" Text='<%# Eval("NewDesc6") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-HorizontalAlign="center" HeaderStyle-Width="80px" HeaderStyle-CssClass="table-header">
                        <HeaderTemplate>
                            Desc 7<br />
                            Attrib 7
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="OldDesc7" runat="server" ReadOnly="true" Width="75px" Text='<%# Eval("OldDesc7") %>'></asp:Label><br /><hr />
                            <asp:Label ID="NewDesc7" runat="server" ReadOnly="true" Width="75px" Text='<%# Eval("NewDesc8") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-HorizontalAlign="center" HeaderStyle-Width="80px" HeaderStyle-CssClass="table-header">
                        <HeaderTemplate>
                            <br />
                            Attrib 8
                        </HeaderTemplate>
                        <ItemTemplate>
                            <br /><hr />
                            <asp:Label ID="NewDesc8" runat="server" ReadOnly="true" Width="75px" Text='<%# Eval("NewDesc8") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-HorizontalAlign="center" HeaderStyle-Width="80px" HeaderStyle-CssClass="table-header">
                        <HeaderTemplate>
                            <br />
                            Attrib 9
                        </HeaderTemplate>
                        <ItemTemplate>
                            <br /><hr />
                            <asp:Label ID="NewDesc9" runat="server" ReadOnly="true" Width="75px" Text='<%# Eval("NewDesc9") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-HorizontalAlign="center" HeaderStyle-Width="80px" HeaderStyle-CssClass="table-header">
                        <HeaderTemplate>
                            <br />
                            Attrib 10
                        </HeaderTemplate>
                        <ItemTemplate>
                            <br /><hr />
                            <asp:Label ID="NewDesc10" runat="server" ReadOnly="true" Width="75px" Text='<%# Eval("NewDesc10") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-HorizontalAlign="center" HeaderStyle-Width="80px" HeaderStyle-CssClass="table-header">
                        <HeaderTemplate>
                            <br />
                            Attrib 11
                        </HeaderTemplate>
                        <ItemTemplate>
                            <br /><hr />
                            <asp:Label ID="NewDesc11" runat="server" ReadOnly="true" Width="75px" Text='<%# Eval("NewDesc11") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-HorizontalAlign="center" HeaderStyle-Width="80px" HeaderStyle-CssClass="table-header">
                        <HeaderTemplate>
                            <br />
                            Attrib 12
                        </HeaderTemplate>
                        <ItemTemplate>
                            <br /><hr />
                            <asp:Label ID="NewDesc12" runat="server" ReadOnly="true" Width="75px" Text='<%# Eval("NewDesc12") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-HorizontalAlign="center" HeaderStyle-Width="80px" HeaderStyle-CssClass="table-header">
                        <HeaderTemplate>
                            <br />
                            Attrib 13
                        </HeaderTemplate>
                        <ItemTemplate>
                            <br /><hr />
                            <asp:Label ID="NewDesc13" runat="server" ReadOnly="true" Width="75px" Text='<%# Eval("NewDesc13") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-HorizontalAlign="center" HeaderStyle-Width="80px" HeaderStyle-CssClass="table-header">
                        <HeaderTemplate>
                            <br />
                            Attrib 14
                        </HeaderTemplate>
                        <ItemTemplate>
                            <br /><hr />
                            <asp:Label ID="NewDesc14" runat="server" ReadOnly="true" Width="75px" Text='<%# Eval("NewDesc14") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField ItemStyle-HorizontalAlign="center" HeaderStyle-Width="80px" HeaderStyle-CssClass="table-header">
                        <HeaderTemplate>
                            <br />
                            Attrib 15
                        </HeaderTemplate>
                        <ItemTemplate>
                            <br /><hr />
                            <asp:Label ID="NewDesc15" runat="server" ReadOnly="true" Width="75px" Text='<%# Eval("NewDesc15") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField ItemStyle-HorizontalAlign="center" HeaderStyle-Width="0" Visible="false">
                        <HeaderTemplate>
                            <br />
                            Product Link Id
                        </HeaderTemplate>
                        <ItemTemplate>
                            <br /><hr />
                            <asp:Label ID="ProductLinkId" runat="server" ReadOnly="true" Width="75px" Text='<%# Eval("ProductLinkId") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
				</Columns>
                <EmptyDataRowStyle BackColor="White" ForeColor="DarkBlue"></EmptyDataRowStyle>
			</asp:GridView>
		</div>

	</div>
</asp:Content>
