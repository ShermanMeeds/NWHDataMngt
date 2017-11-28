<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site.Master" AutoEventWireup="true" Inherits="DataMngt.page.VendorEdit" Codebehind="EntityEdit.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<asp:HiddenField ID="hfPageID" runat="server" Value="10" />

	<script type="text/javascript">
		var jiPageID = 10;

	</script>

	<div id="divPAGEHEADER" style="width:99%;">
     Master Entity Data
	</div>

	<div id="divPAGEMAIN" style="width:99%;">
		<div id="divDataGrid" style="width:100%;">
			<asp:GridView ID="gvMainData" runat="server" AllowPaging="true" AlternatingRowStyle-BackColor="#ccffcc" BorderColor="#009999">
				<Columns>
					






				</Columns>
			</asp:GridView>
		</div>

         <!-- IsVendor, IsCustomer, IsSupplier, InLIMS, InLT, InGP -->


	</div>

	<div id="divPAGEFOOTER" style="width:99%;">

	</div>

</asp:Content>
