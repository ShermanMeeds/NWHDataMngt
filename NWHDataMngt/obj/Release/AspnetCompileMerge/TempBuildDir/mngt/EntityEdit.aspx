<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site.Master" AutoEventWireup="true" CodeBehind="EntityEdit.aspx.cs" Inherits="DataMngt.page.EntityEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

	<div id="divPAGEHEADER" style="width:99%;">
     Master Entity Data
	</div>

	<div id="divPAGEMAIN" style="width:99%;">


    <div id="divEditItem" runat="server" style="display:none;">
      Entity Edit: ID: <asp:Label ID="lblEntityIDE" Text="0" runat="server"></asp:Label><br />
      <table>
      <tr>
        <td>

        </td>
        <td>

        </td>
        <td>

        </td>
        <td>

        </td>
      </tr>
      </table>
    </div>

    <div id="divEditItemVendor" runat="server" style="display:none;">

    </div>

   <div id="divEditItemCustomer" runat="server" style="display:none;">

    </div>

    <div id="divEditItemSupplier" runat="server" style="display:none;">

    </div>

    <div id="divGridFilters" runat="server" style="width:100%;text-align:center;" class="MyFilterCriteria">
      <table class="margin:auto auto;">
      <tr>
        <td>
          Type:&nbsp;
        </td>
        <td>
          <asp:DropDownList ID="ddlTypeF" runat="server">
            <asp:ListItem Value="0" Text="All" Selected="True"></asp:ListItem>
            <asp:ListItem Value="2" Text="Customers"></asp:ListItem>
            <asp:ListItem Value="4" Text="Employees"></asp:ListItem>
            <asp:ListItem Value="3" Text="Suppliers"></asp:ListItem>
            <asp:ListItem Value="1" Text="Vendors"></asp:ListItem>
          </asp:DropDownList>
        </td>
        <td>&nbsp;</td>
        <td>
          Name:&nbsp;
        </td>
        <td>
          <asp:TextBox ID="txtNameF" runat="server" CssClass="TextFilterBoxStd" Width="200px"></asp:TextBox> 
        </td>
      </tr>
      <tr>
        <td>
          Code:&bull;&nbsp;
        </td>
        <td>
          <asp:TextBox ID="txtCodeF" runat="server" CssClass="TextFilterBoxSpec" Width="60px"></asp:TextBox> 
        </td>
        <td>&nbsp;</td>
        <td>
          Status:&nbsp;
        </td>
        <td>
          <asp:DropDownList ID="ddlStatusF" runat="server">
            <asp:ListItem Value="2" Text="All" Selected="True"></asp:ListItem>
            <asp:ListItem Value="1" Text="Active Only"></asp:ListItem>
            <asp:ListItem Value="0" Text="Inactive Only"></asp:ListItem>
          </asp:DropDownList>
        </td>
      </tr>
      <tr>
        <td>
          Address:&nbsp;
        </td>
        <td>
          <asp:TextBox ID="txtAddressF" runat="server" CssClass="TextFilterBoxStd" Width="200px"></asp:TextBox> 
        </td>
        <td>&nbsp;</td>
        <td>

        </td>
        <td>

        </td>
      </tr>
      <tr>
        <td>
          City:&nbsp;
        </td>
        <td>
          <asp:TextBox ID="txtCityF" runat="server" CssClass="TextFilterBoxStd" Width="120px"></asp:TextBox>&nbsp;St:&nbsp;
          <asp:DropDownList ID="ddlStateIDF" runat="server" >
            <asp:ListItem Value="0" Text="ALL" Selected="True"></asp:ListItem>
            <asp:ListItem Value="AB" Text="Alberta (CAN)"></asp:ListItem>
            <asp:ListItem Value="AK" Text="Alaska"></asp:ListItem>
            <asp:ListItem Value="AL" Text="Alabama"></asp:ListItem>
            <asp:ListItem Value="AS" Text="American Samoa (ASM)"></asp:ListItem>
            <asp:ListItem Value="AR" Text="Arkansas"></asp:ListItem>
            <asp:ListItem Value="AZ" Text="Arizona"></asp:ListItem>
            <asp:ListItem Value="81" Text="Baker Island"></asp:ListItem>
            <asp:ListItem Value="BC" Text="British Columbia (CAN)"></asp:ListItem>
            <asp:ListItem Value="CA" Text="California"></asp:ListItem>
            <asp:ListItem Value="CO" Text="Colorado"></asp:ListItem>
            <asp:ListItem Value="CT" Text="Conneticut"></asp:ListItem>
            <asp:ListItem Value="DE" Text="Delaware"></asp:ListItem>
            <asp:ListItem Value="DC" Text="District of Columbia"></asp:ListItem>
            <asp:ListItem Value="FL" Text="Florida"></asp:ListItem>
            <asp:ListItem Value="GA" Text="Georgia"></asp:ListItem>
            <asp:ListItem Value="GU" Text="Guam (GUM)"></asp:ListItem>
            <asp:ListItem Value="HI" Text="Hawaii"></asp:ListItem>
            <asp:ListItem Value="IA" Text="Iowa"></asp:ListItem>
            <asp:ListItem Value="ID" Text="Idaho"></asp:ListItem>
            <asp:ListItem Value="IL" Text="Illinois"></asp:ListItem>
            <asp:ListItem Value="IN" Text="Indiana"></asp:ListItem>
            <asp:ListItem Value="KS" Text="Kansas"></asp:ListItem>
            <asp:ListItem Value="KY" Text="Kentucky"></asp:ListItem>
            <asp:ListItem Value="LA" Text="Lousiana"></asp:ListItem>
            <asp:ListItem Value="MB" Text="Manitoba (CAN)"></asp:ListItem>
            <asp:ListItem Value="MA" Text="Massachusetts"></asp:ListItem>
            <asp:ListItem Value="MD" Text="Maryland"></asp:ListItem>
            <asp:ListItem Value="ME" Text="Maine"></asp:ListItem>
            <asp:ListItem Value="MI" Text="Michigan"></asp:ListItem>
            <asp:ListItem Value="71" Text="Midway Islands"></asp:ListItem>
            <asp:ListItem Value="MN" Text="Minnesota"></asp:ListItem>
            <asp:ListItem Value="MS" Text="Mississippi"></asp:ListItem>
            <asp:ListItem Value="MO" Text="Missouri"></asp:ListItem>
            <asp:ListItem Value="MT" Text="Montana"></asp:ListItem>
            <asp:ListItem Value="76" Text="Navassa Islands"></asp:ListItem>
            <asp:ListItem Value="NC" Text="North Carolina"></asp:ListItem>
            <asp:ListItem Value="ND" Text="North Dakota"></asp:ListItem>
            <asp:ListItem Value="MP" Text="Northern Mariana Islands (NMP)"></asp:ListItem>
            <asp:ListItem Value="NE" Text="Nebraska"></asp:ListItem>
            <asp:ListItem Value="NV" Text="Nevada"></asp:ListItem>
            <asp:ListItem Value="NB" Text="New Brunswick (CAN)"></asp:ListItem>
            <asp:ListItem Value="NH" Text="New Hampshire"></asp:ListItem>
            <asp:ListItem Value="NJ" Text="New Jersey"></asp:ListItem>
            <asp:ListItem Value="NM" Text="New Mexico"></asp:ListItem>
            <asp:ListItem Value="NY" Text="New York"></asp:ListItem>
            <asp:ListItem Value="NL" Text="Newfoundland and Labrador (CAN)"></asp:ListItem>
            <asp:ListItem Value="NT" Text="Northwest Territories (CAN)"></asp:ListItem>
            <asp:ListItem Value="NS" Text="Nova Scotia (CAN)"></asp:ListItem>
            <asp:ListItem Value="NU" Text="Nunavut (CAN)"></asp:ListItem>
            <asp:ListItem Value="OH" Text="Ohio"></asp:ListItem>
            <asp:ListItem Value="OK" Text="Oklahoma"></asp:ListItem>
            <asp:ListItem Value="ON" Text="Ontario (CAN)"></asp:ListItem>
            <asp:ListItem Value="OR" Text="Oregon"></asp:ListItem>
            <asp:ListItem Value="PW" Text="Palau (PAL)"></asp:ListItem>
            <asp:ListItem Value="PA" Text="Pennsylvania"></asp:ListItem>
            <asp:ListItem Value="PE" Text="Prince Edward Island (CAN)"></asp:ListItem>
            <asp:ListItem Value="PR" Text="Puerto Rico (PRI)"></asp:ListItem>
            <asp:ListItem Value="QC" Text="Quebec (CAN)"></asp:ListItem>
            <asp:ListItem Value="RI" Text="Rhode Island"></asp:ListItem>
            <asp:ListItem Value="SK" Text="Saskatchewan (CAN)"></asp:ListItem>
            <asp:ListItem Value="SC" Text="South Carolina"></asp:ListItem>
            <asp:ListItem Value="SD" Text="South Dakota"></asp:ListItem>
            <asp:ListItem Value="TN" Text="Tennessee"></asp:ListItem>
            <asp:ListItem Value="TX" Text="Texas"></asp:ListItem>
            <asp:ListItem Value="UM" Text="US Minor Outlying Islands (UMI)"></asp:ListItem>
            <asp:ListItem Value="VI" Text="US Virgin Islands (VIR)"></asp:ListItem>
            <asp:ListItem Value="UT" Text="Utah"></asp:ListItem>
            <asp:ListItem Value="VT" Text="Vermont"></asp:ListItem>
            <asp:ListItem Value="VA" Text="Virginia"></asp:ListItem>
            <asp:ListItem Value="WA" Text="Washington"></asp:ListItem>
            <asp:ListItem Value="WI" Text="Wisconsin"></asp:ListItem>
            <asp:ListItem Value="WV" Text="West Virginia"></asp:ListItem>
            <asp:ListItem Value="WY" Text="Wyoming"></asp:ListItem>
            <asp:ListItem Value="YT" Text="Yukon (CAN)"></asp:ListItem>
          </asp:DropDownList>&nbsp;&nbsp;
          Country:&nbsp;
          <asp:DropDownList ID="ddlCountryListF" runat="server" AppendDataBoundItems="true">
            <asp:ListItem Value="0" Text="All" Selected="True"></asp:ListItem>
          </asp:DropDownList>&nbsp;&nbsp;
          Postal&nbsp;Code:&nbsp;<asp:TextBox ID="txtPostalCodeF" runat="server" Width="80px"></asp:TextBox>
        </td>
        <td>&nbsp;</td>
        <td>

        </td>
        <td>

        </td>
      </tr>
      <tr>
        <td colspan="5">
          NOTE: &bull; indicates exact match is required.
        </td>
      </tr>
      </table>
    </div>

    <div id="divDataGrid" runat="server" style="width:100%;">
			<asp:GridView ID="gvMainData" runat="server" AllowPaging="true" AlternatingRowStyle-BackColor="#ccffcc" BorderColor="#009999">
				<Columns>
					






				</Columns>
			</asp:GridView>
		</div>

         <!-- IsVendor, IsCustomer, IsSupplier, InLIMS, InLT, InGP -->


	</div>

	<div id="divPAGEFOOTER" style="width:99%;">
    <asp:Label ID="lblErrorMsg" runat="server" CssClass="StdErrorMode"></asp:Label>
	</div>

</asp:Content>
