<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site.Master" AutoEventWireup="true" CodeBehind="SalesPlan.aspx.cs" Inherits="DataMngt.page.SalesPlan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

	<script type="text/javascript" src="../Scripts/ExpandListBoxes.js?v=<%=BuildNbr %>"></script>

	<script type="text/javascript">
		var jiPageID = 37;
	</script>

	<div id="divPAGEHEADER" class="MainDiv" style="margin-left:8px;margin-bottom:8px;">
		<div id="divMainFilterBarLbl" style="width:100%;text-align:center;">
			&nbsp;Northwest Hardwoods Sales Planning
		</div>
		<div id="divFilterBar" class="TableFilterHdrCell" style="width:1890px; text-align:center;margin-bottom:10px;line-height:28px;">
			<table style="border-spacing:0px;padding:0px;border:none; width:100%;">
			<tr>
				<td style="color: #00008B; vertical-align: top; text-align: right; width: 50px;">
					<asp:Label ID="lblprotype" runat="server" Text="Type:&nbsp;" ForeColor="DarkBlue" Font-Bold="true"></asp:Label>
                    <br />
                    <asp:Label ID="lblMGD" runat="server" Text="MGD:&nbsp;" ForeColor="DarkBlue" Font-Bold="true"></asp:Label>
				</td>
                <td style="text-align:left;vertical-align:top; width: 186px;">
					 <asp:DropDownList ID="drpProTypes" runat="server" CssClass="silver-bg" Height="26px" Width="98%" AutoPostBack="true" OnSelectedIndexChanged="drpProTypes_SelectedIndexChanged">
                     </asp:DropDownList>
                    <br />                    
					 <asp:DropDownList ID="drpMGD" runat="server" CssClass="silver-bg" Height="26px" Width="98%" AutoPostBack="true" OnSelectedIndexChanged="drpMGD_SelectedIndexChanged" >
                         <asp:ListItem Value="BOTH" Selected="True">Both</asp:ListItem>
                         <asp:ListItem Value="YES">Yes</asp:ListItem>
                         <asp:ListItem Value="NO">No</asp:ListItem>
                     </asp:DropDownList>
				</td>
				<td style="text-align:left;vertical-align:top;">	
                    <asp:Label ID="lblRegion" runat="server" Text="Region:&nbsp;" ForeColor="DarkBlue" Font-Bold="true"></asp:Label>
				</td>
				<td colspan="2" style="text-align:left;vertical-align:top; width: 200px;">	
                    <div style="width:100%; height:90px; overflow:auto;"> 
                    <asp:CheckBoxList ID="lstRegionChk" runat="server" 
                        BackColor="White" BorderStyle="Solid"  BorderColor="Gray" BorderWidth="1px" CssClass="CheckBoxList"
                        OnSelectedIndexChanged="lstRegionChk_SelectedIndexChanged" AutoPostBack="true"
                        AppendDataBoundItems="true" Width="98%" RepeatColumns="1" RepeatDirection="Vertical" TextAlign="Right">
		            </asp:CheckBoxList>
                    </div>
				</td>
				<td style="width: 5px">&nbsp</td>
				<td style="text-align:right;vertical-align:top; width: 66px;">
                    <asp:Button ID="btnLoc" runat="server" Text="Location" CssClass="button blue-gradient glossy" Width="100%" OnClick="btnLoc_Click"/>  
				</td>
				<td style="text-align:left;vertical-align:top; width: 700px;">
                    <div style="width:100%; height:90px; overflow:auto;"> 
                    <asp:CheckBoxList ID="lstLocChk" runat="server" 
                        BackColor="White" BorderStyle="Solid"  BorderColor="Gray" BorderWidth="1px" CssClass="CheckBoxList"
                        OnSelectedIndexChanged="lstLocChk_SelectedIndexChanged" AutoPostBack="true"
                        AppendDataBoundItems="true" Width="98%" RepeatColumns="1" RepeatDirection="Vertical" TextAlign="Right">
		            </asp:CheckBoxList>
                    </div>
				</td>
				<td style="width: 5px">&nbsp</td>

				<td colspan="4" style="text-align:left;vertical-align:top;">
                    <table>
                        <tr>
                            <td>
                                <asp:RadioButton ID="optSales" runat="server"  GroupName="runOpt" AutoPostBack="true" OnCheckedChanged ="optSales_CheckedChanged"/>
                                <asp:label ID="LblSales" runat="server" Text="Sales" ForeColor="DarkBlue" Font-Bold="true"></asp:label>
                            </td>
                                <td><asp:RadioButton ID="optProduction" runat="server" GroupName="runOpt" AutoPostBack="true" OnCheckedChanged="optProduction_CheckedChanged"/>
                                <asp:label ID="lblProdOpt" runat="server" Text="Prodution" ForeColor="DarkBlue" Font-Bold="true"></asp:label>
                            </td>
                            <td>
                                <asp:RadioButton ID="optEither" runat="server" GroupName="runOpt" AutoPostBack="true" Checked="True" OnCheckedChanged="optEither_CheckedChanged"/>
                                <asp:label ID="lblEitherOpt" runat="server" Text="Both" ForeColor="DarkBlue" Font-Bold="true"></asp:label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox ID="chkShowCust" runat="server" AutoPostBack="true" Checked="false" OnCheckedChanged="chkShowCust_CheckedChanged"/>
                                <asp:label ID="lblChkCust" runat="server" Text="Customers&nbsp;" ForeColor="DarkBlue" Font-Bold="true"></asp:label>
                            </td>
                            <td>
                                <asp:CheckBox ID="chkHolds" runat="server" AutoPostBack="True" Checked="false" OnCheckedChanged="chkHolds_CheckedChanged"/>
                                <asp:label ID="lblHolds" runat="server" Text="Holds" ForeColor="DarkBlue" Font-Bold="true"></asp:label>
                            </td>
                            <td>		
                                <asp:CheckBox ID="chkHist" runat="server" AutoPostBack="True" Checked="true" OnCheckedChanged="chkHist_CheckedChanged"/>
                                <asp:label ID="lblHist" runat="server" Text="History" ForeColor="DarkBlue" Font-Bold="true"></asp:label>					
                            </td>
                        </tr>
                    </table>
				</td>
			</tr>
			<tr>
                <td colspan="24" style="text-align:center; vertical-align:top;  border:1px solid gray; padding: 2px;">
					<label>Items per Page:</label>
					<asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged" style="margin-left: 10px;">
							<asp:ListItem Text="10" Value="10"  Selected="True"/>
							<asp:ListItem Text="20" Value="20"/>
							<asp:ListItem Text="25" Value="25" />
							<asp:ListItem Text="50" Value="50" />
							<asp:ListItem Text="100" Value="100" />
							<asp:ListItem Text="250" Value="250" />
					</asp:DropDownList>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<asp:Button ID="btnRefreshData" runat="server" CssClass="button blue-gradient glossy" Text="Fill Data" OnClick="btnRefreshData_Click" Width="118px" />                    
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnEmailPDF" runat="server" style="" CssClass="button blue-gradient glossy" OnClick="btnEmailPDF_Click" Text="Export to PDF" />                    
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<asp:Button ID="btnExcelCopy" runat="server" style="" CssClass="button blue-gradient glossy" OnClick="btnExcelCopy_Click" Text="Export to Excel" /> 
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<asp:Button ID="btnSaveSettings" runat="server" style="" CssClass="button blue-gradient glossy" OnClick="btnSaveSettings_Click" Text="Save Settings" />
				</td>
			</tr>
            <tr>
                <td>
                    <input id="btnExp" type="button" value=&#x21E9; class="button blue-gradient glossy" data-Dir="down" onclick="btnExp_onclick(this);"/>
                </td>
                <td colspan ="24" style="text-align:center;">
                    <table style="width:100%;">
                        <tr>
                            <td style="width:10%; vertical-align:bottom; text-align:center;">
                                <asp:Button ID="btnSpecie" runat="server" Text="Specie" CssClass="button blue-gradient glossy" Width="100%" OnClick="btnSpecie_Click"/>                         
                                <div class="expBar" style="width:100%; height:45px; overflow:auto; text-align:left;"> 
                                <asp:CheckBoxList ID="lstSpeciesChk" runat="server" ClientIDMode="Static"
                                    BackColor="White" BorderStyle="Solid"  BorderColor="Gray" BorderWidth="1px" CssClass="CheckBoxList" 
                                    OnKeyPress="javascript: List_KeyPress(this); return false;" 
                                    OnSelectedIndexChanged="lstSpeciesChk_SelectedIndexChanged" AutoPostBack="true"
                                    AppendDataBoundItems="true" Enabled="false"  RepeatColumns="1" RepeatDirection="Vertical" TextAlign="Right" 
                                    Width="98%" Height="45px">
                                </asp:CheckBoxList>
                                </div>
                            </td>
                            <td style="width:10%; vertical-align:bottom; text-align:center;">
                                <asp:Button ID="btnThick" runat="server" Text="Thickness"  CssClass="button blue-gradient glossy"  Width="100%" OnClick="btnThickness_Click"/>                               
                                <div class="expBar" style="width:100%; height:45px; overflow:auto; text-align:left;"> 
                                <asp:CheckBoxList ID="lstThickChk" runat="server"  
                                    BackColor="White" BorderStyle="Solid"  BorderColor="Gray" BorderWidth="1px" CssClass="CheckBoxList"  
                                    OnKeyPress="javascript: List_KeyPress(this); return false;"  
                                    OnSelectedIndexChanged="lstThickChk_SelectedIndexChanged" AutoPostBack="true"
                                    AppendDataBoundItems="true" Enabled ="false" RepeatColumns="1" RepeatDirection="Vertical" TextAlign="Right"
                                    Width="98%" Height="45px">
						        </asp:CheckBoxList>
                                </div>
                            </td>
                            <td style="width:10%; vertical-align:bottom; text-align:center;">
                                <asp:Button ID="btnGrade" runat="server" Text="Grade" CssClass="button blue-gradient glossy"  Width="100%" OnClick="btnGrade_Click"/>                               
                                <div class="expBar" style="width:100%; height:45px; overflow:auto; text-align:left;"> 
                                <asp:CheckBoxList ID="lstGradeChk" runat="server"  
                                    BackColor="White" BorderStyle="Solid"  BorderColor="Gray" BorderWidth="1px" CssClass="CheckBoxList" 
                                    OnKeyPress="javascript: List_KeyPress(this); return false;"  
                                    OnSelectedIndexChanged="lstGradeChk_SelectedIndexChanged" AutoPostBack="true"
                                    AppendDataBoundItems="true" Enabled ="false"  RepeatColumns="1" RepeatDirection="Vertical" TextAlign="Right"
                                    Width="98%" Height="45px">
						        </asp:CheckBoxList>
                                </div>
                            </td>
                            <td style="width:10%; vertical-align:bottom; text-align:center;">
                                <asp:Button ID="btnColor" runat="server" Text="Color" CssClass="button blue-gradient glossy"  Width="100%" OnClick="btnColor_Click"/>                               
                                <div class="expBar" style="width:100%; height:45px; overflow:auto; text-align:left;"> 
                                <asp:CheckBoxList ID="lstColorChk" runat="server"  
                                    BackColor="White" BorderStyle="Solid"  BorderColor="Gray" BorderWidth="1px" CssClass="CheckBoxList"  
                                    OnKeyPress="javascript: List_KeyPress(this); return false;" 
                                    OnSelectedIndexChanged="lstColorChk_SelectedIndexChanged" AutoPostBack="true"
                                    AppendDataBoundItems="true" Enabled ="false"  RepeatColumns="1" RepeatDirection="Vertical" TextAlign="Right"
                                    Width="98%" Height="45px">
						        </asp:CheckBoxList>
                                </div>
                            </td>
                            <td style="width:10%; vertical-align:bottom; text-align:center;">
                                <asp:Button ID="btnSort" runat="server" Text="Sort" CssClass="button blue-gradient glossy"  Width="100%" OnClick="btnSort_Click"/>                               
                                <div class="expBar" style="width:100%; height:45px; overflow:auto; text-align:left;"> 
                                <asp:CheckBoxList ID="lstSortChk" runat="server"  
                                    BackColor="White" BorderStyle="Solid"  BorderColor="Gray" BorderWidth="1px" CssClass="CheckBoxList" 
                                    OnKeyPress="javascript: List_KeyPress(this); return false;"  
                                    OnSelectedIndexChanged="lstSortChk_SelectedIndexChanged" AutoPostBack="true" 
                                    AppendDataBoundItems="true" Enabled ="false"  RepeatColumns="1" RepeatDirection="Vertical" TextAlign="Right"
                                    Width="98%" Height="45px">
						        </asp:CheckBoxList>
                                </div>
                            </td>
                            <td style="width:10%; vertical-align:bottom; text-align:center;">
                                <asp:Button ID="btnNoPrint" runat="server" Text="No Print" CssClass="button blue-gradient glossy"  Width="100%" OnClick="btnNoPrint_Click"/>                               
                                <div class="expBar" style="width:100%; height:45px; overflow:auto; text-align:left;"> 
                                <asp:CheckBoxList ID="lstNoPrintChk" runat="server"  
                                    BackColor="White" BorderStyle="Solid"  BorderColor="Gray" BorderWidth="1px" CssClass="CheckBoxList" 
                                    OnKeyPress="javascript: List_KeyPress(this); return false;"  
                                    OnSelectedIndexChanged="lstNoPrintChk_SelectedIndexChanged" AutoPostBack="true" 
                                    AppendDataBoundItems="true" Enabled ="false"  RepeatColumns="1" RepeatDirection="Vertical" TextAlign="Right"
                                    Width="98%" Height="45px">
						        </asp:CheckBoxList>
                                </div>
                            </td>
                            <td style="width:10%; vertical-align:bottom; text-align:center;">
                                <asp:Button ID="btnType" runat="server" Text="Type" CssClass="button blue-gradient glossy"  Width="100%" OnClick="btnType_Click"/>                               
                                <div class="expBar" style="width:100%; height:45px; overflow:auto; text-align:left;"> 
                                <asp:CheckBoxList ID="lstTypeChk" runat="server"  
                                    BackColor="White" BorderStyle="Solid"  BorderColor="Gray" BorderWidth="1px" CssClass="CheckBoxList" 
                                    OnKeyPress="javascript: List_KeyPress(this); return false;"  
                                    OnSelectedIndexChanged="lstTypeChk_SelectedIndexChanged" AutoPostBack="true" 
                                    AppendDataBoundItems="true" Enabled ="false" RepeatColumns="1" RepeatDirection="Vertical" TextAlign="Right"
                                    Width="98%" Height="45px">
                                </asp:CheckBoxList>
                                </div> 
                            </td>
                            <td style="width:10%; vertical-align:bottom; text-align:center;">
                                <asp:Button ID="btnMgr" runat="server" Text="Mgr" CssClass="button blue-gradient glossy"  Width="100%" OnClick="btnMgr_Click"/>                               
                                <div class="expBar" style="width:100%; height:45px; overflow:auto; text-align:left;"> 
                                <asp:CheckBoxList ID="lstMgrChk" runat="server"  
                                    BackColor="White" BorderStyle="Solid"  BorderColor="Gray" BorderWidth="1px" CssClass="CheckBoxList" 
                                    OnKeyPress="javascript: List_KeyPress(this); return false;" 
                                    OnSelectedIndexChanged="lstMgrChk_SelectedIndexChanged" AutoPostBack="true"
                                    AppendDataBoundItems="true" enabled="false" RepeatColumns="1" RepeatDirection="Vertical" TextAlign="Right"
                                    Width="98%" Height="45px"> 
                                </asp:CheckBoxList> 
                                </div>
                            </td>
                            <td style="width:10%; vertical-align:bottom; text-align:center;">
                                <asp:Button ID="btnCust" runat="server" Text="Customer" CssClass="button blue-gradient glossy" Width="100%"  OnClick="btnCust_Click"/>                               
                                <div class="expBar" style="width:100%; height:45px; overflow:auto; text-align:left;"> 
                                <asp:CheckBoxList ID="lstCustChk" runat="server"  
                                    BackColor="White" BorderStyle="Solid" BorderColor="Gray" BorderWidth="1px" CssClass="CheckBoxList" 
                                    OnKeyPress="javascript: List_KeyPress(this); return false;" 
                                    OnSelectedIndexChanged="lstCustChk_SelectedIndexChanged" AutoPostBack="true"
                                    AppendDataBoundItems="true" Enabled ="false"  RepeatColumns="1" RepeatDirection="Vertical" TextAlign="Right"
                                    Width="98%" Height="45px">
                                </asp:CheckBoxList> 
                                </div>
                            </td>
                            <td style="width:10%; vertical-align:bottom; text-align:center;">
                                <asp:Button ID="btnProd" runat="server" Text="Product" CssClass="button blue-gradient glossy" Width="100%"  OnClick="btnProd_Click"/>                               
                                <div class="expBar" style="width:100%; height:45px; overflow:auto; text-align:left;"> 
                                <asp:CheckBoxList ID="lstProdChk" runat="server"  
                                    BackColor="White" BorderStyle="Solid" BorderColor="Gray" BorderWidth="1px" CssClass="CheckBoxList" 
                                    OnKeyPress="javascript: List_KeyPress(this); return false;" 
                                    OnSelectedIndexChanged="lstProdChk_SelectedIndexChanged" AutoPostBack="true"
                                    AppendDataBoundItems="true" Enabled ="false"  RepeatColumns="1" RepeatDirection="Vertical" TextAlign="Right"
                                    Width="98%" Height="45px">
                                </asp:CheckBoxList> 
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
			</table>
		</div>
	</div>

	<div id="divPAGECONTENT" class="MainDiv" style="margin-left:8px;margin-bottom:8px; width: 1900px;">
        <table style="width: 100%; vertical-align: top; height: 90%">
            <tr>
                <td style="width: 85%; vertical-align: top; height: 100%;">
                    <asp:Panel ID="pnlGrid" runat="server" Width="100%" Height="100%" style="OVERFLOW: auto; margin-bottom: 0px;">
                        <asp:GridView ID="grdData" runat="server" Height="199px" Width="1660px" AllowPaging="True" AutoGenerateColumns = "False" 
                            cellpadding="2" 
                            OnRowDataBound="grdData_RowDataBound"
                            ShowFooter="True" BackColor="#FFFF66" CssClass="GridViewMain" OnPageIndexChanging="grdData_PageIndexChanging" style="left: 0px; top: 0px" DataMember="grdRowData">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col1Id" runat="server" ReadOnly="true" Text='<%# Eval("col1") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col2Id" runat="server" ReadOnly="true" Text='<%# Eval("col2") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col3Id" runat="server" ReadOnly="true" Text='<%# Eval("col3") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col4Id" runat="server" ReadOnly="true" Text='<%# Eval("col4") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col5Id" runat="server" ReadOnly="true" Text='<%# Eval("col5") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col6Id" runat="server" ReadOnly="true" Text='<%# Eval("col6") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col7Id" runat="server" ReadOnly="true" Text='<%# Eval("col7") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col8Id" runat="server" ReadOnly="true" Text='<%# Eval("col8") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col9Id" runat="server" ReadOnly="true" Text='<%# Eval("col9") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                                    
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col10Id" runat="server" ReadOnly="true" Text='<%# Eval("col10") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col11Id" runat="server" ReadOnly="true" Text='<%# Eval("col11") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col12Id" runat="server" ReadOnly="true" Text='<%# Eval("col12") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>                                
                                
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col13Id" runat="server" ReadOnly="true" Text='<%# Eval("col13") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col14Id" runat="server" ReadOnly="true" Text='<%# Eval("col14") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col15Id" runat="server" ReadOnly="true" Text='<%# Eval("col15") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col16Id" runat="server" ReadOnly="true" Text='<%# Eval("col16") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col17Id" runat="server" ReadOnly="true" Text='<%# Eval("col17") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col18Id" runat="server" ReadOnly="true" Text='<%# Eval("col18") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col19Id" runat="server" ReadOnly="true" Text='<%# Eval("col19") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col20Id" runat="server" ReadOnly="true" Text='<%# Eval("col20") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col21Id" runat="server" ReadOnly="true" Text='<%# Eval("col21") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col22Id" runat="server" ReadOnly="true" Text='<%# Eval("col22") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col23Id" runat="server" ReadOnly="true" Text='<%# Eval("col23") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col24Id" runat="server" ReadOnly="true" Text='<%# Eval("col24") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col25Id" runat="server" ReadOnly="true" Text='<%# Eval("col25") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                                                
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col26Id" runat="server" ReadOnly="true" Text='<%# Eval("col26") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                                                
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col27Id" runat="server" ReadOnly="true" Text='<%# Eval("col27") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                                                
                                <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderStyle-CssClass="table-header">
                                    <ItemTemplate>
                                        <asp:Label ID="col28Id" runat="server" ReadOnly="true" Text='<%# Eval("col28") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField InsertVisible="false" Visible="false">
                                    <HeaderTemplate>Detail</HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="DETAILId" runat="server" ReadOnly="true" Visible ="false" Text='<%# Eval("DETAIL") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField InsertVisible="false" Visible="false">
                                    <HeaderTemplate>Orders</HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="ORDNUMId" runat="server" ReadOnly="true" Visible ="false" Text='<%# Eval("ORDNUM") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>                                                     
                                
                            </Columns>
                            <EmptyDataRowStyle BackColor="#CCFFCC" />
                            <HeaderStyle BackColor="#99ccff" Font-Bold="true" HorizontalAlign="Center" Wrap="false"/>
                        </asp:GridView>
                    </asp:Panel>
                </td>
                <td style="width: 15%; vertical-align: top; height: 327px;">
                    <asp:Panel ID="pnlPick" runat="server" Width="100%" Height="100%">
                        <table style="width: 100%; border: thin solid whitesmoke; height: 316px;">
                            <tr style="background-color: antiquewhite">
                                <td style="width: 45%; vertical-align: top; text-align: center; height: 24px;">
                                    <asp:Label ID="Label1" runat="server" Text="Available Columns" ForeColor="DarkBlue" Font-Bold="true"></asp:Label>                                    
                                </td>
                                <td style="vertical-align: top; text-align: center; height: 24px;">
                                    <asp:Label ID="Label2" runat="server" Text="Cmd" ForeColor="DarkBlue" Font-Bold="true"></asp:Label>      
                                </td>
                                <td style="width: 45%; vertical-align: top; text-align: center; height: 24px;">
                                    <asp:Label ID="Label3" runat="server" Text="Group(Check)/Sort By" ForeColor="DarkBlue" Font-Bold="true"></asp:Label>  
                                </td>
                            </tr>

                            <tr>
                                <td style="width: 45%; vertical-align: top; height: 150px;">
                                    <asp:ListBox ID="lstColsAvail" runat="server" width="100%" Height="99%" Sorted="true" ForeColor="DarkBlue" SelectionMode="Single"
                                        style="margin-right: 0px; margin-bottom: 0px"  AutoPostBack="true" 
                                        OnSelectedIndexChanged="lstColsAvail_SelectedIndexChanged">
                                        <asp:ListItem Value="P13">P13</asp:ListItem>
                                        <asp:ListItem Value="P8">P8</asp:ListItem>
                                        <asp:ListItem Value="P4">P4</asp:ListItem>
                                        <asp:ListItem Value="Totals">Totals</asp:ListItem>
                                        <asp:ListItem Value="W00">W00</asp:ListItem>
                                        <asp:ListItem Value="W01">W01</asp:ListItem>
                                        <asp:ListItem Value="W02">W02</asp:ListItem>
                                        <asp:ListItem Value="W03">W03</asp:ListItem>
                                        <asp:ListItem Value="W04">W04</asp:ListItem> 
                                        <asp:ListItem Value="W05">W05</asp:ListItem>
                                        <asp:ListItem Value="W06">W06</asp:ListItem>
                                        <asp:ListItem Value="W07">W07</asp:ListItem>
                                        <asp:ListItem Value="W08">W08</asp:ListItem> 
                                        <asp:ListItem Value="W09">W09</asp:ListItem>
                                        <asp:ListItem Value="W10">W10</asp:ListItem>
                                        <asp:ListItem Value="W11">W11</asp:ListItem>
                                        <asp:ListItem Value="W12">W12</asp:ListItem>
                                        <asp:ListItem Value="W13">W13</asp:ListItem>
                                    </asp:ListBox>
                                </td>

                                <td style="text-align:center; background-color: antiquewhite; height: 150px;">
                                    <br />
                                    <asp:Button ID="btnAddCol" name="btnAddCol"
                                        runat="server" Text=&#x21E8; height="22px" width="22px" 
                                        CssClass="button blue-gradient glossy" Font-Bold="true" 
                                        OnClick="btnAddCol_Click"
                                        ToolTip="click here to add a new column to the sort/grouping control" />  
                                    <br />
                                    <br /> 
                                    <asp:Button ID="btnDelCol" name="btnDelCol"
                                        runat="server" Text=&#x21E6; height="22px" width="22px" 
                                        CssClass="button blue-gradient glossy" Font-Bold="true"
                                        OnClick="btnDelCol_Click"  
                                        ToolTip="click here to remove a column from the sort/grouping control"/>  
                                    <br />
                                    <br />
                                    <asp:Button ID="btnUpCol" name="btnUpCol"
                                        runat="server" Text=&#x21E7; height="22px" width="22px" 
                                        CssClass="button blue-gradient glossy" Font-Bold="true" 
                                        OnClick="btnUpCol_Click" 
                                        ToolTip="click here to move a column upwards in the sort/grouping control"/>  
                                    <br />
                                    <br /> 
                                    <asp:Button ID="btnDownCol" name="btnDownCol"
                                        runat="server" Text=&#x21E9; height="22px" width="22px" 
                                        CssClass="button blue-gradient glossy" Font-Bold="true" 
                                        OnClick="btnDownCol_Click"
                                        ToolTip="click here to move a column downward in the sort/grouping control"/>  
                                    <br /> 
                                    <br /> 
                                </td>

                                <td style="width: 45%; vertical-align: top; height: 150px;">
                                    <asp:CheckBoxList ID="lstColsSort" runat="server" AutoPostBack="true"
                                        BorderStyle="Solid" width="100%" Height="99%" border="0"
                                        ForeColor="DarkBlue" BackColor="White"
                                        OnSelectedIndexChanged="lstColsSort_SelectedIndexChanged"
                                        ToolTip="Check to group on that column"
                                        AppendDataBoundItems="true" RepeatColumns="1" RepeatDirection="Vertical" TextAlign="Right">
                                        <asp:ListItem Selected="true" Value="specie">specie</asp:ListItem>
                                        <asp:ListItem Selected="false" Value="thick">thick</asp:ListItem>
                                        <asp:ListItem Selected="true" Value="grade">grade</asp:ListItem>
                                        <asp:ListItem Selected="false" Value="Color">Color</asp:ListItem>
                                        <asp:ListItem Selected="false" Value="Sort">Sort</asp:ListItem>
                                        <asp:ListItem Selected="false" Value="NoPrint">NoPrint</asp:ListItem>
                                        <asp:ListItem Selected="true" Value="PRODUCT">PRODUCT</asp:ListItem>
                                        <asp:ListItem Selected="true" Value="TYPE">TYPE</asp:ListItem>
                                        <asp:ListItem Selected="false" Value="Mgr">Mgr</asp:ListItem>
                                        <asp:ListItem Selected="false" Value="CUSTOMER">CUSTOMER</asp:ListItem>
		                            </asp:CheckBoxList>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
        </table>
    	
    <asp:Label ID="errMsg" runat="server" Text="" CssClass="failureNotification" width="100%"></asp:Label>   
	<div id="divPAGEFOOTER" class="MainDiv" style="margin-left:8px;margin-bottom:8px; height: 25px; margin-top: 14px;">
	</div>

    </div>
</asp:Content>
