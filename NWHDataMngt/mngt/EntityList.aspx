<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site.Master" AutoEventWireup="true" CodeBehind="EntityList.aspx.cs" Inherits="DataMngt.page.EntityList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

	<div id="divPAGEHEADER" style="width:99%;margin-left:10px;text-align:center;">
		<asp:Label ID="lblMainHdr" runat="server" Font-Size="14pt" ForeColor="Blue" Font-Bold="true" Text="Master Entity Data"></asp:Label>
	</div>

	<div id="divPAGEMAIN" style="width:99%;margin-left:10px;">

    <div id="divEditItem" runat="server" style="display:none;background-color:beige;">
			<asp:Label ID="lblEntityEditHdr" runat="server" Text="Entity Edit:" ForeColor="Blue" Font-Bold="true"></asp:Label>&nbsp;ID: <asp:Label ID="lblEntityIDE" Text="0" runat="server" ForeColor="Blue" Font-Bold="true"></asp:Label><br />
      <table>
      <tr>
        <td style="text-align:right;">
					Entity&nbsp;Type:&nbsp;
        </td>
        <td style="text-align:left;width:260px;">
					<asp:DropDownList ID="ddlEntityTypeE" runat="server" OnSelectedIndexChanged="ddlEntityTypeE_SelectedIndexChanged" AutoPostBack="true">
						<asp:ListItem Value="0" Text="None Selected" Selected="True"></asp:ListItem>
						<asp:ListItem Value="MIL" Text="Mill/Yard"></asp:ListItem>
						<asp:ListItem Value="STO" Text="Storage/Warehouse"></asp:ListItem>
						<asp:ListItem Value="FAC" Text="Internal Facility"></asp:ListItem>
						<asp:ListItem Value="CMP" Text="Business/Company"></asp:ListItem>
						<asp:ListItem Value="IND" Text="Individual"></asp:ListItem>
						<asp:ListItem Value="EMP" Text="Employee"></asp:ListItem>
						<asp:ListItem Value="GOV" Text="Government Entity"></asp:ListItem>
						<asp:ListItem Value="OTH" Text="Other"></asp:ListItem>
					</asp:DropDownList>
        </td>
        <td>&nbsp;</td>
        <td style="text-align:right;">
					<asp:Label ID="lblEntNameE" runat="server" Text="Name:"></asp:Label>&nbsp;
        </td>
        <td style="text-align:left;width:260px;">
					<asp:TextBox ID="txtEntityNameE" runat="server" Text="" Width="200px"></asp:TextBox>
        </td>
        <td>&nbsp;</td>
        <td style="text-align:right;">
					Entity&nbsp;Code:&nbsp;
        </td>
        <td style="text-align:left;">
					<asp:TextBox ID="txtEntityCodeE" runat="server" Text="" Width="100"></asp:TextBox>
        </td>
      </tr>
      <tr id="trIndividualNameE" runat="server">
        <td style="text-align:right;">
					Last&nbsp;Name:&nbsp;
        </td>
        <td style="text-align:left;">
					<asp:TextBox ID="txtLastNameE" runat="server" Text="" Width="200px"></asp:TextBox>
        </td>
        <td>&nbsp;</td>
        <td style="text-align:right;">
					First&nbsp;Name:&nbsp;
        </td>
        <td style="text-align:left;">
					<asp:TextBox ID="txtFirstNameE" runat="server" Text=""></asp:TextBox>
        </td>
        <td>&nbsp;</td>
        <td style="text-align:right;">
					Middle&nbsp;Name:&nbsp;
        </td>
        <td style="text-align:left;">
					<asp:TextBox ID="txtMiddleNameE" runat="server" Text=""></asp:TextBox>&nbsp;&nbsp;
					Suffix:&nbsp;<asp:TextBox ID="txtSuffixE" runat="server" Text=""></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td style="text-align:right;">
					Status:&nbsp;
        </td>
        <td style="text-align:left;">
					<asp:DropDownList ID="ddlEntityStatusE" runat="server">
						<asp:ListItem Value="A" Text="Active" Selected="True"></asp:ListItem>
						<asp:ListItem Value="INA" Text="Inactive"></asp:ListItem>
						<asp:ListItem Value="OTH" Text="Other"></asp:ListItem>
					</asp:DropDownList>
        </td>
        <td>&nbsp;</td>
        <td style="text-align:right;vertical-align:top;">
					Attributes:&nbsp;
        </td>
        <td style="text-align:left;" colspan="4">
					Cust:<asp:CheckBox ID="chkCustomerE" runat="server" OnCheckedChanged="chkCustomerE_CheckedChanged" AutoPostBack="true" />&nbsp;
					Vend:<asp:CheckBox ID="chkVendorE" runat="server" OnCheckedChanged="chkVendorE_CheckedChanged" AutoPostBack="true" />&nbsp;
					Suppl:<asp:CheckBox ID="chkSupplierE" runat="server" OnCheckedChanged="chkSupplierE_CheckedChanged" AutoPostBack="true" />&nbsp;
					Emp:<asp:CheckBox ID="chkEmployeeE" runat="server" OnCheckedChanged="chkEmployeeE_CheckedChanged" AutoPostBack="true" />&nbsp;
					Source:<asp:CheckBox ID="chkSourceE" runat="server" OnCheckedChanged="chkSourceE_CheckedChanged" AutoPostBack="true" />&nbsp;<br />

					Access:&nbsp;LT:<asp:CheckBox ID="chkAccessLT" runat="server" OnCheckedChanged="chkAccessLT_CheckedChanged" AutoPostBack="true" />&nbsp;
					LIMS:<asp:CheckBox ID="chkAccessLIMS" runat="server" OnCheckedChanged="chkAccessLIMS_CheckedChanged" AutoPostBack="true" />&nbsp;
					GP:<asp:CheckBox ID="chkAccessGP" runat="server" OnCheckedChanged="chkAccessGP_CheckedChanged" AutoPostBack="true" />
        </td>
      </tr>
      <tr>
        <td style="text-align:right;vertical-align:top;">
					Description:&nbsp;
        </td>
        <td style="text-align:left;" colspan="7">
					<asp:TextBox ID="txtDescriptionE" runat="server" TextMode="MultiLine" Width="600px" Height="60px" Font-Names="Calibri"></asp:TextBox>
        </td>
			</tr>
      <tr>
        <td style="text-align:right;">
					Geo&nbsp;Area:&nbsp;
        </td>
        <td style="text-align:left;">
					<asp:DropDownList ID="ddlGeoAreaE" runat="server" AppendDataBoundItems="true">
						<asp:ListItem Value="0" Text="None Selected" Selected="True"></asp:ListItem>
					</asp:DropDownList>
        </td>
        <td>&nbsp;</td>
        <td style="text-align:right;">
					Dates:&nbsp;
        </td>
        <td style="text-align:left;" colspan="4">
					Begin:<asp:TextBox ID="txtBeginDateE" runat="server" Text="" Width="82px"></asp:TextBox>&nbsp;&nbsp;
					End:<asp:TextBox ID="txtEndDateE" runat="server" Text="" Width="82px"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td style="text-align:right;">
					HQ Address:&nbsp;
        </td>
        <td style="text-align:left;" colspan="4">
					<asp:TextBox ID="txtAddressE" runat="server" Text="" Width="400px"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td style="text-align:right;vertical-align:top;">
					City:&nbsp;
        </td>
        <td style="text-align:left;vertical-align:top;">
					<asp:TextBox ID="txtAddrCityE" runat="server" Text="" Width="120px"></asp:TextBox>
        </td>
        <td>&nbsp;</td>
        <td style="text-align:right;vertical-align:top;">
					State-Province:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:DropDownList ID="ddlStateProvE" runat="server" >
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
            <asp:ListItem Value="NL" Text="Newfoundland-Labrador (CAN)"></asp:ListItem>
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
            <asp:ListItem Value="UM" Text="US Minor Outer Islands (UMI)"></asp:ListItem>
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
          <asp:DropDownList ID="ddlCountryListE" runat="server" AppendDataBoundItems="true">
            <asp:ListItem Value="0" Text="All" Selected="True"></asp:ListItem>
          </asp:DropDownList>&nbsp;&nbsp;
        </td>
      </tr>
      <tr>
        <td style="text-align:right;">
					FEIN&nbsp;Tax&nbsp;Nbr:&nbsp;
        </td>
        <td style="text-align:left;">
					<asp:TextBox ID="txtFEINTaxNbrE" runat="server" Text="" Width="90px"></asp:TextBox>
        </td>
        <td>&nbsp;</td>
        <td style="text-align:right;">
					Postal&nbsp;Code:&nbsp;
        </td>
        <td style="text-align:left;" colspan="4">
					<asp:TextBox ID="txtPostalCodeE" runat="server" Width="80px"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td style="text-align:right;">
					Main&nbsp;Phone:&nbsp;
        </td>
        <td style="text-align:left;">
					<asp:TextBox ID="txtMainPhoneE" runat="server" Text="" Width="110px"></asp:TextBox>
        </td>
        <td>&nbsp;</td>
        <td style="text-align:right;">
					Cell&nbsp;Phone:&nbsp;
        </td>
        <td style="text-align:left;" colspan="4">
					<asp:TextBox ID="txtCellPhoneE" runat="server" Width="110px"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td style="text-align:right;">
					Fax:&nbsp;
        </td>
        <td style="text-align:left;">
					<asp:TextBox ID="txtFaxE" runat="server" Text="" Width="110px"></asp:TextBox>
        </td>
        <td>&nbsp;</td>
        <td style="text-align:right;">
					Email&nbsp;Address:&nbsp;
        </td>
        <td style="text-align:left;" colspan="4">
					<asp:TextBox ID="txtEmailAddrE" runat="server" Width="160px"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td style="text-align:right;">
					Currency:&nbsp;
        </td>
        <td style="text-align:left;">
					<asp:DropDownList ID="ddlCurrencyE" runat="server" AppendDataBoundItems="true">
						<asp:ListItem Value="0" Text="None Selected" Selected="True"></asp:ListItem>
					</asp:DropDownList> 
        </td>
        <td>&nbsp;</td>
        <td style="text-align:right;">
					Active:&nbsp;
        </td>
        <td style="text-align:left;" colspan="4">
					<asp:DropDownList ID="ddlActiveE" runat="server">
						<asp:ListItem Value="0" Text="Inactive"></asp:ListItem>
						<asp:ListItem Value="1" Text="Active" Selected="True"></asp:ListItem>
					</asp:DropDownList>
        </td>
      </tr>
      <tr>
        <td style="text-align:right;">
					Division:&nbsp;
        </td>
        <td style="text-align:left;">
					<asp:DropDownList ID="ddlDivIDE" runat="server" AppendDataBoundItems="true">
						<asp:ListItem Value="0" Text="None Selected" Selected="True"></asp:ListItem>
					</asp:DropDownList> 
        </td>
        <td>&nbsp;</td>
        <td style="text-align:right;">
					Contact:&nbsp;
        </td>
        <td style="text-align:left;" colspan="4">
					Name:&nbsp;<asp:TextBox ID="txtContactNameE" runat="server" Width="160px"></asp:TextBox>&nbsp;&nbsp;
					Phone:&nbsp;<asp:TextBox ID="txtContactPhoneE" runat="server" Width="100px"></asp:TextBox>&nbsp;&nbsp;
					Email:&nbsp;<asp:TextBox ID="txtContactEmailE" runat="server" Width="120px"></asp:TextBox>
        </td>
      </tr>
      </table>

			<div id="divEditItemVendor" runat="server" style="display:none;">
				<table style="padding:0px;border-spacing:0px;">
				<tr>
					<td style="text-align:right;">
						Vendor&nbsp;ID:&nbsp;
					</td>
					<td style="text-align:left;">
						<asp:TextBox ID="txtVendorIDE" runat="server" Text="" Width="120px"></asp:TextBox>
					</td>
					<td style="width:100px;">&nbsp;</td>
					<td style="text-align:right;">
						Vendor&nbsp;Type:&nbsp;
					</td>
					<td style="text-align:left;" colspan="4">
						<asp:DropDownList ID="ddlVendorTypeE" runat="server" AppendDataBoundItems="true">
							<asp:ListItem Value="0" Text="None Selected" Selected="True"></asp:ListItem>
						</asp:DropDownList>
					</td>
				</tr>
				<tr>
					<td style="text-align:right;">
						Vendor&nbsp;Class:&nbsp;
					</td>
					<td style="text-align:left;">
						<asp:TextBox ID="txtVendorClassE" runat="server" Text="" Width="120px"></asp:TextBox>
					</td>
					<td style="width:100px;">&nbsp;</td>
					<td style="text-align:right;">
						&nbsp;
					</td>
					<td style="text-align:left;" colspan="4">
						&nbsp;
					</td>
				</tr>
				</table>
			</div>

			<div id="divEditItemCustomer" runat="server" style="display:none;">
				<table style="padding:0px;border-spacing:0px;">
				<tr>
					<td style="text-align:right;">
						Customer&nbsp;ID:&nbsp;
					</td>
					<td style="text-align:left;">
						<asp:TextBox ID="txtCustomerIDE" runat="server" Text="" Width="120px"></asp:TextBox>
					</td>
					<td>&nbsp;</td>
					<td style="text-align:right;">
						&nbsp;
					</td>
					<td style="text-align:left;" colspan="4">
						&nbsp;
					</td>
				</tr>
				</table>
			</div>

			<div id="divEditItemSupplier" runat="server" style="display:none;">
				<table style="padding:0px;border-spacing:0px;">
				<tr>
					<td style="text-align:right;">
						Supplier&nbsp;ID:&nbsp;
					</td>
					<td style="text-align:left;">
						<asp:TextBox ID="txtSupplierIDE" runat="server" Text="" Width="120px"></asp:TextBox>
					</td>
					<td>&nbsp;</td>
					<td style="text-align:right;">
						&nbsp;
					</td>
					<td style="text-align:left;" colspan="4">
						&nbsp;
					</td>
				</tr>
				</table>

			</div>

			<div id="divEditLowerButtonBar" style="width:100%;text-align:center;">
				<asp:Button ID="btnSaveEntityData" runat="server" OnClick="btnSaveEntityData_Click" CssClass="button blue-gradient glossy" Text="Save Data" />
			</div>
    </div>

    <div id="divGridFilters" runat="server" style="width:100%;text-align:center;margin-top:2px;margin-bottom:8px;background-color:whitesmoke;" class="MyFilterCriteria">
			<div id="divGridFiltersHdr" runat="server" style="width:100%;text-align:left;">
				<asp:Label ID="lblFilterHdr" runat="server" Font-Size="12pt" ForeColor="Blue" Font-Bold="true" Text="Filters:"></asp:Label>
			</div>

      <table class="width:100%;text-align:left;margin:auto auto;">
      <tr>
        <td style="text-align:right;">
          Type:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:DropDownList ID="ddlTypeF" runat="server">
            <asp:ListItem Value="0" Text="All" Selected="True"></asp:ListItem>
            <asp:ListItem Value="2" Text="Customers"></asp:ListItem>
            <asp:ListItem Value="4" Text="Employees"></asp:ListItem>
            <asp:ListItem Value="3" Text="Suppliers"></asp:ListItem>
            <asp:ListItem Value="1" Text="Vendors"></asp:ListItem>
          </asp:DropDownList>
        </td>
        <td>&nbsp;</td>
        <td style="text-align:right;">
          Name:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:TextBox ID="txtNameF" runat="server" CssClass="TextFilterBoxStd" Width="260px"></asp:TextBox> 
        </td>
      </tr>
      <tr>
        <td style="text-align:right;">
          Code:&bull;&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:TextBox ID="txtCodeF" runat="server" CssClass="TextFilterBoxSpec" Width="60px"></asp:TextBox> 
        </td>
        <td>&nbsp;</td>
        <td style="text-align:right;">
          Status:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:DropDownList ID="ddlStatusF" runat="server">
            <asp:ListItem Value="2" Text="All" Selected="True"></asp:ListItem>
            <asp:ListItem Value="1" Text="Active Only"></asp:ListItem>
            <asp:ListItem Value="0" Text="Inactive Only"></asp:ListItem>
          </asp:DropDownList>
        </td>
      </tr>
      <tr>
        <td style="text-align:right;">
          Address:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:TextBox ID="txtAddressF" runat="server" CssClass="TextFilterBoxStd" Width="200px"></asp:TextBox> 
        </td>
        <td>&nbsp;</td>
        <td style="text-align:right;">
          Email&nbsp;Address:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:TextBox ID="txtEmailAddressF" runat="server" CssClass="TextFilterBoxStd" Width="220px"></asp:TextBox> 
        </td>
      </tr>
      <tr>
        <td style="text-align:right;">
          City:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:TextBox ID="txtCityF" runat="server" CssClass="TextFilterBoxStd" Width="140px"></asp:TextBox>&nbsp;St:&nbsp;
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
            <asp:ListItem Value="NL" Text="Newfoundland-Labrador (CAN)"></asp:ListItem>
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
            <asp:ListItem Value="UM" Text="US Minor Outer Islands (UMI)"></asp:ListItem>
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
        <td style="text-align:right;">
          Geo&nbsp;Area&nbsp;Code:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:TextBox ID="txtGeoAreaF" runat="server" Width="80px"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td style="text-align:right;">
          Phone:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:TextBox ID="txtPhoneF" runat="server" Width="100px"></asp:TextBox>
        </td>
        <td>&nbsp;</td>
        <td style="text-align:right;">
          FEIN&nbsp;Tax&nbsp;Nbr:&nbsp;
        </td>
        <td style="text-align:left;">
          <asp:TextBox ID="txtFEINTaxNbrF" runat="server" Width="100px"></asp:TextBox>
        </td>
			</tr>
      <tr>
        <td style="text-align:right;">
          <asp:Label ID="lblItemsPPage" runat="server" Text="Items per Page:"></asp:Label>&nbsp;
        </td>
        <td style="text-align:left;">
					<asp:DropDownList ID="ddlPageSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
						<asp:ListItem Text="10" Value="10" />
						<asp:ListItem Text="20" Value="20" Selected="True" />
						<asp:ListItem Text="25" Value="25" />
						<asp:ListItem Text="50" Value="50" />
						<asp:ListItem Text="100" Value="100" />
						<asp:ListItem Text="250" Value="250" />
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
        <td colspan="5" style="text-align:left;">
          NOTE: &bull; indicates exact match is required.
        </td>
      </tr>
      </table>

      <asp:Button ID="btnRefilterDataGrid" runat="server" CssClass="button blue-gradient glossy" OnClick="btnRefilterDataGrid_Click"	Text="Refilter Grid" />
    </div>

    <div id="divDataGrid" runat="server" style="width:100%;">
			<div id="divDataGridHdr" style="width:100%;text-align:center;">
				<table id="tblDataGridHdr" style="margin:90%;padding:0px;border-spacing:0px;margin: auto auto;">
				<tr>
					<td style="width:50%;">
						<asp:Label ID="lblDataGridHdr" runat="server" Font-Size="12pt" ForeColor="Blue" Font-Bold="true" Text="Entities (Vendors/Customers/Suppliers/Etc.):"></asp:Label>
					</td>
					<td style="width:50%;text-align:right;">
						<asp:Button ID="btnAddNew" runat="server" Text="Add New Entity" CssClass="button blue-gradient glossy" OnClick="btnAddNew_Click" Height="22px" />
					</td>
				</tr>
				</table>
			</div>

			<asp:GridView ID="gvMainData" runat="server" AllowPaging="true" AlternatingRowStyle-BackColor="#ccffcc" BorderColor="#009999" DataKeyNames="EntityID" OnRowCommand="gvMainData_RowCommand" 
				AutoGenerateColumns="false" HorizontalAlign="Center">
				<Columns>
          <asp:BoundField DataField="EntityID" HeaderText="ID" HeaderStyle-CssClass="TableHdrCell" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Center" />
          <asp:BoundField DataField="EntityFullName" HeaderText="Name" HeaderStyle-CssClass="TableHdrCell" ItemStyle-CssClass="StdTableCell" />
          <asp:BoundField DataField="EntityStatus" HeaderText="Status" HeaderStyle-CssClass="TableHdrCell" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Center" />
          <asp:BoundField DataField="sBeginDate" HeaderText="Begin Date" HeaderStyle-CssClass="TableHdrCell" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="76px" ItemStyle-HorizontalAlign="Center" />
          <asp:BoundField DataField="sEndDate" HeaderText="End Date" HeaderStyle-CssClass="TableHdrCell" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="76px" ItemStyle-HorizontalAlign="Center" />
          <asp:BoundField DataField="MainCity" HeaderText="City" HeaderStyle-CssClass="TableHdrCell" ItemStyle-CssClass="StdTableCell" />
          <asp:BoundField DataField="MainStateCode" HeaderText="State" HeaderStyle-CssClass="TableHdrCell" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Center" />
          <asp:BoundField DataField="MainCountryCode" HeaderText="Country" HeaderStyle-CssClass="TableHdrCell" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Center" />
          <asp:BoundField DataField="sActive" HeaderText="Active" HeaderStyle-CssClass="TableHdrCell" ItemStyle-CssClass="StdTableCell" ItemStyle-HorizontalAlign="Center" />
          <asp:BoundField DataField="sIsCustomer" HeaderText="Customer" HeaderStyle-CssClass="TableHdrCell" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="72px" ItemStyle-HorizontalAlign="Center" />
          <asp:BoundField DataField="sIsVendor" HeaderText="Vendor" HeaderStyle-CssClass="TableHdrCell" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="72px" ItemStyle-HorizontalAlign="Center" />
          <asp:BoundField DataField="sIsSupplier" HeaderText="Supplier" HeaderStyle-CssClass="TableHdrCell" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="72px" ItemStyle-HorizontalAlign="Center" />
          <asp:BoundField DataField="sIsCompany" HeaderText="Company" HeaderStyle-CssClass="TableHdrCell" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="72px" ItemStyle-HorizontalAlign="Center" />
          <asp:BoundField DataField="sIsExternal" HeaderText="External" HeaderStyle-CssClass="TableHdrCell" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="72px" ItemStyle-HorizontalAlign="Center" />
          <asp:BoundField DataField="sIsExport" HeaderText="Export" HeaderStyle-CssClass="TableHdrCell" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="72px" ItemStyle-HorizontalAlign="Center" />
          <asp:BoundField DataField="ApplicationList" HeaderText="Applications" HeaderStyle-CssClass="TableHdrCell" ItemStyle-CssClass="StdTableCell" ItemStyle-Width="200px" />
					<asp:TemplateField HeaderText="Action">
						<ItemTemplate>
							<div id="divGVRowBtns" style="padding-left:4px;padding-right:4px;">
								<asp:Button ID="btnGVRowEdit" runat="server" Text="Edit" CommandName="Edit1" CommandArgument='<%# Container.DataItemIndex %>' />
							</div>
						</ItemTemplate>
					</asp:TemplateField>
				</Columns>
			</asp:GridView>
		</div>

	</div>

	<div id="divPAGEFOOTER" style="width:99%;margin-left:10px;">
    <asp:Label ID="lblErrorMsg" runat="server" CssClass="StdErrorMode"></asp:Label>
	</div>
</asp:Content>
