<%@ Page Title="" Language="C#" MasterPageFile="~/master/Site.Master" AutoEventWireup="true" Inherits="DataMngt.page.MainMenu" Codebehind="MainMenuBK.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
	<asp:HiddenField ID="hfPageID" runat="server" Value="1" />

	<script type="text/javascript">
		jiPageID = 1;


		function GotoPage(url) {
			document.location.href = url;
		}

		$(document).keypress(function (e) {
			if (e.keyCode === 13) {
				e.preventDefault();
				return false;
			}
		});
	</script>

	<div id="divMAINPGCONTENT" style="height:800px;">
		<div id="divMAINPGHEADER" style="margin-left:14px;width:98%;">
		</div>
		<div id="divMAINPGCENTER" style="text-align:center;margin-left:14px;width:98%;">
			<div id="divMyHeaderLines" class="MyHeaderLine" style="margin-bottom:10px;color:aliceblue;font-family:Tahoma;">
				Northwest Hardwoods Data Management<br />
				Main Menu
			</div>

			<div id="divMainMenu" style="width:100%;">
				<table id="tblMainMenu" style="padding:0px;border-spacing:0px;width:100%;">
				<tr>
					<td style="width:20%;border:none;height:500px;vertical-align:top;padding:4px;text-align:center;">
						<div id="divGenHdrA">
							<asp:Label ID="lblGenHdrMA" runat="server" Text="Request Documents" CssClass="lblHighlightedBlue"></asp:Label>
						</div>
						<div id="divRequestDocsBlock" class="TableMain" style="width:100%;height:500px;text-align:center;">
							<ul id="ulReqDocs" runat="server" style="width:210px;line-height:24px;padding:4px;font-family:Calibri;font-size:12pt;list-style-type:none;margin: auto auto;">
								<li ID="rowRequestMngt" runat="server"><a href="../page/RequestMngt.aspx?v=0">Request Management</a></li>
								<li ID="Li20" runat="server">&nbsp;</li>
								<li ID="rowInvAdj" runat="server"><a href="../finance/InvAdj.aspx?v=0">Invoice Adjustment Request</a></li>
								<li ID="rowCreditExcReq" runat="server"><a href="../finance/CreditExcReq.aspx?v=0">Credit Exception Request</a></li>
								<li ID="Li21" runat="server">&nbsp;</li>
								<li ID="Li3" runat="server">&nbsp;</li>
								<li ID="Li4" runat="server">&nbsp;</li>
								<li ID="Li7" runat="server">&nbsp;</li>
								<li ID="Li8" runat="server">&nbsp;</li>
							</ul>
						</div>
					</td>
					<td style="width:20%;border:none;height:500px;vertical-align:top;padding:4px;text-align:center;">
						<div id="divGenHdrB">
							<asp:Label ID="Label2" runat="server" Text="Management Functions" CssClass="lblHighlightedBlue"></asp:Label>
						</div>
						<div id="divMngtFunctionsBlock" class="TableMain" style="width:100%;height:500px;text-align:center;">
							<ul id="ul1" runat="server" style="width:210px;line-height:24px;padding:4px;font-family:Calibri;font-size:12pt;list-style-type:none;margin: auto auto;">
								<li ID="rowProcOwner" runat="server"><a href="../mngt/ProcOwner.aspx?v=0">Area-Process Owners</a></li>
								<li ID="rowEntities" runat="server"><a href="../mngt/EntityList.aspx?v=0">Entity/Company/Etc.</a></li>
								<li ID="rowLocations" runat="server"><a href="../mngt/LocationEdit.aspx?v=0">Edit Location</a></li>
								<li ID="rowAppCodes" runat="server"><a href="../mngt/CodeMainEdit.aspx?v=0">Edit App Codes</a></li>
								<li ID="rowEmailManagement" runat="server"><a href="../mngt/EmailMngt.aspx?v=0">Email Management</a></li>
								<li ID="rowProcManagement" runat="server"><a href="../mngt/ProcessManagement.aspx?v=0">Process Management</a></li>
								<li ID="rowUserADInterface" runat="server"><a href="../mngt/UserADInterface.aspx?v=0">User Management</a></li>
								<li ID="rowIssueMngt" runat="server"><a href="../mngt/IssueMngt.aspx?v=0">Issue Management</a></li>
								<li ID="Li18" runat="server">&nbsp;</li>
								<li ID="Li9" runat="server">&nbsp;</li>
								<li ID="Li19" runat="server">&nbsp;</li>
								<li ID="Li28" runat="server">&nbsp;</li>
							</ul>
						</div>
					</td>
					<td style="width:20%;border:none;height:500px;vertical-align:top;padding:4px;text-align:center;">
						<div id="divGenHdrC">
							<asp:Label ID="lblGenHdrMM" runat="server" Text="General Functions" CssClass="lblHighlightedBlue"></asp:Label>
						</div>
						<div id="divGenFunctionsBlock" class="TableMain" style="width:100%;height:500px;text-align:center;">
							<ul id="ulMainMenu" runat="server" style="width:210px;line-height:24px;padding:4px;font-family:Calibri;font-size:12pt;list-style-type:none;margin: auto auto;">
								<li ID="rowGenCalendar" runat="server"><a href="../page/WebCalendar.aspx?v=0">Calendar</a></li>
								<li ID="rowProdForecast" runat="server"><a href="../prod/ForecastTool.aspx?v=0">Production Forecast</a></li>
								<li ID="rowSearchProd" runat="server"><a href="../prod/SearchProducts.aspx?v=0">Search Products</a></li>
								<li ID="rowWurthSpacer" runat="server">&nbsp;</li>
								<li ID="rowWurthTags" runat="server"><a href="../prod/WurthStyleTag.aspx?v=0">Print Wurth Tags</a></li>
								<li ID="rowWurthConvert" runat="server"><a href="../prod/WurthConversion.aspx?v=0">Edit Wurth Conversion Data</a></li>
								<li ID="rowComputerAssetSpacer" runat="server">&nbsp;</li>
								<li ID="rowComputerAsset" runat="server"><a href="../page/ComputerAssets.aspx?v=0">HITS Computer List</a></li>
								<li ID="rowComments" runat="server"><a href="../page/GenComment.aspx?v=0">Comments Management</a></li>
								<li ID="Li10" runat="server">&nbsp;</li>
								<li ID="rowWeeklyRpt" runat="server"><a href="../page/WeeklyReport.aspx?v=0">Weekly Report</a></li>
								<li ID="Li22" runat="server">&nbsp;</li>
								<li ID="rowInvAnalysis" runat="server"><a href="../prod/InventoryAnalysis.aspx?v=0">Inventory Analysis</a></li>
								<li ID="Li24" runat="server">&nbsp;</li>
							</ul>
						</div>
					</td>
					<td style="width:20%;border:none;height:500px;vertical-align:top;padding:4px;text-align:center;">
						<div id="divSalesHdr">
							<asp:Label ID="Label1" runat="server" Text="Sales" CssClass="lblHighlightedBlue"></asp:Label>
						</div>
						<div id="divSalesFunctionsBlock" class="TableMain" style="width:100%;height:500px;text-align:center;">
							<ul id="ulGenFunctions" runat="server" style="width:210px;line-height:24px;padding:4px;font-family:Calibri;font-size:12pt;list-style-type:none;margin: auto auto;">
								<li ID="rowCatItems" runat="server"><a href="../sales/RegionPriceTracking.aspx?v=0">Sales Product List</a></li>
								<li ID="rowCatTool" runat="server"><a href="../sales/CatTool.aspx?v=0">CAT Product Availability</a></li>
								<li ID="rowForecastConsolidaton" runat="server"><a href="../prod/ForecastConsolidation.aspx?v=0">Forecast Consolidation</a></li>
								<li ID="rowSalesPlanspacer" runat="server">&nbsp;</li>
								<li ID="rowSalesPlan" runat="server"><a href="../sales/SalesPlan.aspx?v=0">Sales Plan</a></li>
								<li ID="rowSalesPlan2" runat="server"><a href="../sales/SalesPlanE.aspx?v=0">Sales Plan 2</a></li>
								<li ID="Li16" runat="server">&nbsp;</li>
								<li ID="Li17" runat="server">&nbsp;</li>
								<li ID="Li25" runat="server">&nbsp;</li>
								<li ID="Li26" runat="server">&nbsp;</li>
								<li ID="Li27" runat="server">&nbsp;</li>
							</ul>
						</div>
					</td>
					<td style="width:20%;border:none;height:500px;vertical-align:top;padding:4px;text-align:center;">
						<div id="divFinanceHdr">
							<asp:Label ID="lblFinanceHdrMM" runat="server" Text="Finance Functions" CssClass="lblHighlightedBlue"></asp:Label>
						</div>
						<div id="divFinanceFunctionsBlock" class="TableMain" style="width:100%;height:500px;text-align:center;">
							<ul id="ulFinanceMenu" runat="server" style="width:210px;line-height:24px;padding:4px;font-family:Calibri;font-size:12pt;list-style-type:none;margin: auto auto;">
								<li ID="rowARAging" runat="server"><a href="../finance/ARAging.aspx?v=0">AR Aging Report</a></li>
								<li ID="Li5" runat="server">&nbsp;</li>
								<li ID="Li6" runat="server">&nbsp;</li>
								<li ID="Li11" runat="server">&nbsp;</li>
								<li ID="Li12" runat="server">&nbsp;</li>
								<li ID="Li13" runat="server">&nbsp;</li>
								<li ID="Li14" runat="server">&nbsp;</li>
								<li ID="Li15" runat="server">&nbsp;</li>
							</ul>
						</div>
					</td>
				</tr>
				</table>
			</div>


		</div>
		<div id="divMAINPGFOOTER" style="margin-bottom:14px;margin-left:10px;width:98%;">

		</div>
	</div>
</asp:Content>
