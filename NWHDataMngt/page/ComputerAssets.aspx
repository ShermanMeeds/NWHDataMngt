<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site.Master" AutoEventWireup="true" CodeBehind="ComputerAssets.aspx.cs" Inherits="DataMngt.page.ComputerAssets" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<asp:HiddenField ID="hfPageID" runat="server" Value="7" />

	<script type="text/javascript">
		jiPageID = 7;

	</script>

	<div id="divPageHEADER" style="width:99%;text-align:center;font-size:14pt;color:blue;font-weight:bold;margin-left:20px;" runat="server">
		Computer Assets: HITS
	</div>

	<div id="divPageMAIN" style="width:99%;margin-left:20px;" runat="server">
		<asp:Label ID="lblCompAssetGridHdr" ForeColor="Blue" Font-Bold="true" Text="Computer Assets:" runat="server"></asp:Label><br />

		<div id="divAssetGridView" style="width:100%;">
			<asp:GridView ID="gvAssetList" runat="server" AlternatingRowStyle-BackColor="Wheat" AutoGenerateColumns="false" BorderColor="Gray" BorderWidth="1px" CellPadding="2" DataKeyNames="HITSComputerID" HeaderStyle-CssClass="ColHeaderStd">
				<Columns>
					<asp:BoundField DataField="SeqNbr" HeaderText="Nbr" ItemStyle-CssClass="StdTableCellWide" />
					<asp:BoundField DataField="ComputerName" HeaderText="Name" ItemStyle-CssClass="StdTableCellWide" />
					<asp:BoundField DataField="StatusCode" HeaderText="Status" ItemStyle-CssClass="StdTableCellWide" ItemStyle-HorizontalAlign="Center" />
					<asp:BoundField DataField="LocationCode" HeaderText="Location" ItemStyle-CssClass="StdTableCellWide" ItemStyle-HorizontalAlign="Center" />
					<asp:BoundField DataField="StationNbr" HeaderText="Station" ItemStyle-CssClass="StdTableCellWide" ItemStyle-HorizontalAlign="Center" />
					<asp:BoundField DataField="AppBuildNbr" HeaderText="Build" ItemStyle-CssClass="StdTableCellWide" ItemStyle-HorizontalAlign="Right" />
					<asp:BoundField DataField="DatabaseVersion" HeaderText="DB Vers" ItemStyle-CssClass="StdTableCellWide" ItemStyle-HorizontalAlign="Right" />
					<asp:BoundField DataField="ScriptVersion" HeaderText="Script Vers" ItemStyle-CssClass="StdTableCellWide" ItemStyle-HorizontalAlign="Right" />
					<asp:BoundField DataField="sAppChangeDateTime"	HeaderText="App Changed" ItemStyle-CssClass="StdTableCellWide" />
					<asp:BoundField DataField="sDbChangeDateTime" HeaderText="DB Changed" ItemStyle-CssClass="StdTableCellWide" />
					<asp:BoundField DataField="sScriptChangeDateTime" HeaderText="Script Changed" ItemStyle-CssClass="StdTableCellWide" />
					<asp:BoundField DataField="ComputerSerNo" HeaderText="Ser Nbr" ItemStyle-CssClass="StdTableCellWide" />
					<asp:BoundField DataField="AssetTagNbr" HeaderText="Asset Tag Nbr" ItemStyle-CssClass="StdTableCellWide" />
					<asp:BoundField DataField="Comments" HeaderText="Comments" ItemStyle-CssClass="StdTableCellWide" ItemStyle-Width="300" />
				</Columns>
			</asp:GridView>
		</div>

		<br />

		<asp:Label ID="lblAppVersHistHdr" ForeColor="Blue" Font-Bold="true" Text="HITS Application Version History:" runat="server"></asp:Label><br />
		<div id="divAppVersionHistory" style="width:100%;">
			<asp:GridView ID="gvAppVersHistory" runat="server" HeaderStyle-CssClass="TableHdrCell" RowStyle-CssClass="StdTableCell" AutoGenerateColumns="false" >
				<Columns>
					<asp:BoundField DataField="VersionLevel" HeaderText="Vers" />
					<asp:BoundField DataField="VersionPart" HeaderText="Part" />
					<asp:BoundField DataField="VersionStep" HeaderText="Step" />
					<asp:BoundField DataField="sVersionDate" HeaderText="Vers Date" />
					<asp:BoundField DataField="sActive" HeaderText="Active" />
					<asp:BoundField DataField="TargetDBVersion" HeaderText="DB Vers" />
					<asp:BoundField DataField="TargetScriptVersion" HeaderText="Script Vers" />
					<asp:BoundField DataField="ContentsAndChanges" HeaderText="Contents and Changes" />
					<asp:BoundField DataField="DBVersionSupport" HeaderText="DB Req" />
					<asp:BoundField DataField="ScriptVersionSupport" HeaderText="Script Req" />
				</Columns>
			</asp:GridView>
		</div>

	</div>

	<div id="divPageFOOTER" style="width:99%;margin-left:20px;">
		<div id="divErrorDisplay" style="width:100%;" runat="server">
			<asp:Label ID="lblStatusMsg" runat="server" Font-Bold="true" Font-Size="12pt" ForeColor="Maroon"></asp:Label>
		</div>
	</div>

</asp:Content>
