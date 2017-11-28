<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site.Master" AutoEventWireup="true" CodeBehind="DatabaseRights.aspx.cs" Inherits="DataMngt.mngt.DatabaseRights" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

	<div id="pgMAINHEADER" style="width:99%;">
		Application User/Database Security
	</div>

	<div id="pgMAINCONTENT" style="width:99%;">

		<div id="divApplicationRights" style="width:100%;">
			<label id="lblAppRightsTitle" style="color:darkgray;font-size:10pt;font-weight:bold;">Application Rights</label>

			<div id="divAppRightsDataGrid" style="width:100%;">

			</div>

		</div>

		<div id="divDatabseRights" style="width:100%;">
			<label id="lblDBRightsTitle" style="color:darkgray;font-size:10pt;font-weight:bold;">Database Rights</label>

			<div id="divDBRightsDataGrid1" style="width:100%;">

			</div>

			<div id="divDBRightsDataGrid2" style="width:100%;">

			</div>

			<div id="divDBRightsDataGrid3" style="width:100%;">

			</div>

		</div>


	</div>

	<div id="pgMAINFOOTER" style="width:99%;">

	</div>

</asp:Content>
