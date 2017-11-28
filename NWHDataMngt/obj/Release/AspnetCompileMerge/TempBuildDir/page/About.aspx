<%@ Page Title="About" Language="C#" MasterPageFile="~/master/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="DataMngt.About" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
	<asp:HiddenField ID="hfPageID" runat="server" Value="8" />

	<script type="text/javascript">
		jiPageID = 8;

	</script>

		<div id="divMainPageHEADER" style="width:99%;margin-left:10px;margin-bottom:20px;">
		  <h1><strong>NWH Data Management</strong></h1>
 			<table style="padding:2px;border-spacing:0px;">
			<tr>
				<td style="vertical-align:top;">
					<h3>Version&nbsp;&nbsp;</h3>
				</td>
				<td style="vertical-align:top;">
					<h3><asp:Label ID="lblAppVersion" runat="server" Text="1.0.0" Font-Bold="true" ForeColor="darkgreen"></asp:Label></h3>
				</td>
			</tr>
			<tr>
				<td style="vertical-align:top;text-align:right;">
					<h3>Dated&nbsp;&nbsp;</h3>
				</td>
				<td style="vertical-align:top;">
					<h3><asp:Label ID="lblAppVersDate" runat="server" Text="6/21/2017" Font-Bold="true" ForeColor="darkgreen"></asp:Label></h3>
				</td>
			</tr>
			</table>
		</div>

		<div id="divMainPageCONTENT" style="width:99%;margin-left:10px;">
			<asp:Label ID="Label1" runat="server" Text="About this website:" Font-Bold="true" ForeColor="Blue" Font-Size="13"></asp:Label>
			<table>
			<tr>
				<td style="vertical-align:top;">
					Webmaster:&nbsp;
				</td>
				<td>

					<table style="padding:0px;border:none;border-spacing:0px;">
					<tr>
						<td>
							Name:&nbsp;
						</td>
						<td>
							<asp:Label ID="lblWebmasterName" runat="server" Text="_" Font-Bold="true" ForeColor="Blue"></asp:Label>
						</td>
					</tr>
					<tr>
						<td>
							Phone:&nbsp;
						</td>
						<td>
							<asp:Label ID="lblWebmasterPhone" runat="server" Text="_" Font-Bold="true" ForeColor="Blue"></asp:Label>
						</td>
					</tr>
					<tr>
						<td>
							Email:&nbsp;
						</td>
						<td>
							<asp:Label ID="lblWebmasterEmail" runat="server" Text="_" Font-Bold="true" ForeColor="Blue"></asp:Label>
						</td>
					</tr>
					</table>

				</td>
			</tr>
			<tr>
				<td>
					Current Build:&nbsp;
				</td>
				<td>
					<asp:Label ID="lblCurrentBuild" runat="server" Text="_" Font-Bold="true" ForeColor="Blue"></asp:Label>
				</td>
			</tr>
			<tr>
				<td>
					Environment:&nbsp;
				</td>
				<td>
					<asp:Label ID="lblEnvironment" runat="server" Text="_" Font-Bold="true" ForeColor="Blue"></asp:Label>
				</td>
			</tr>
			<tr>
				<td>
					Authentication:&nbsp;
				</td>
				<td>
					<asp:Label ID="Label2" runat="server" Text="Windows Authentication" Font-Bold="true" ForeColor="Blue"></asp:Label>
				</td>
			</tr>
			<tr>
				<td>
					Language:&nbsp;
				</td>
				<td>
					<asp:Label ID="lblAppLanguage" runat="server" Text="C#, JavaScript, T-SQL" Font-Bold="true" ForeColor="Blue"></asp:Label>
				</td>
			</tr>
			</table>

			<br />

			<article style="background-color:antiquewhite;padding:2px;">
        <p>Northwest Hardwoods Data Management application is implemented using ASP.NET, Visual Studio 2015, and Sql Server 2014. It acts as the central application providing functionality that interfaces with LIMS, LumberTrack, Great Plains, 
          and associated databases/applications. It also provides an interface with NWH central data warehousing data. </p>
			</article>

			<div id="divDeepLinksList" style="width:100%;margin-top:10px;">
				<asp:Label ID="lblDeeplinksHeader" runat="server" Text="Deep Links:" Font-Bold="true" ForeColor="Blue" Font-Size="13"></asp:Label>
				<table>
				<tr>
					<td style="vertical-align:top;">Calendar:&nbsp;
					</td>
					<td style="vertical-align:top;">
						https://cat.nwhardwoods.com/DMWeb/WinLogin.aspx?p=8
					</td>
				</tr>
				<tr>
					<td style="vertical-align:top;">CAT Tool:&nbsp;
					</td>
					<td style="vertical-align:top;">
						https://cat.nwhardwoods.com/DMWeb/WinLogin.aspx?p=1
					</td>
				</tr>
				<tr>
					<td style="vertical-align: top;">Claims Management:&nbsp;
					</td>
					<td style="vertical-align: top;">https://cat.nwhardwoods.com/DMWeb/WinLogin.aspx?p=11
					</td>
				</tr>
				<tr>
					<td style="vertical-align: top;">Comments - Edit:&nbsp;
					</td>
					<td style="vertical-align: top;">https://cat.nwhardwoods.com/DMWeb/WinLogin.aspx?p=19
					</td>
				</tr>
				<tr>
					<td style="vertical-align:top;">Consolidation Tool:&nbsp;
					</td>
					<td style="vertical-align:top;">
						https://cat.nwhardwoods.com/DMWeb/WinLogin.aspx?p=6
					</td>
				</tr>
				<tr>
					<td style="vertical-align:top;">Forecast Tool:&nbsp;
					</td>
					<td style="vertical-align:top;">
						https://cat.nwhardwoods.com/DMWeb/WinLogin.aspx?p=5
					</td>
				</tr>
				<tr>
					<td style="vertical-align:top;">Sales Product List:&nbsp;
					</td>
					<td style="vertical-align:top;">
						https://cat.nwhardwoods.com/DMWeb/WinLogin.aspx?p=2
					</td>
				</tr>
				<tr>
					<td style="vertical-align:top;">Sales Plan:&nbsp;
					</td>
					<td style="vertical-align:top;">
						https://cat.nwhardwoods.com/DMWeb/WinLogin.aspx?p=7
					</td>
				</tr>
				<tr>
					<td style="vertical-align: top;">Wurth Conversion Data:&nbsp;
					</td>
					<td style="vertical-align: top;">https://cat.nwhardwoods.com/DMWeb/WinLogin.aspx?p=10
					</td>
				</tr>
				<tr>
					<td style="vertical-align:top;">
						Wurth Style Tags:&nbsp;
					</td>
					<td style="vertical-align:top;">
						https://cat.nwhardwoods.com/DMWeb/WinLogin.aspx?p=9
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center;color:darkgreen;"><strong>For Area/Site Administrators:</strong></td>
				</tr>
				<tr>
					<td style="vertical-align: top;">Email Mngt (site administrators only):&nbsp;
					</td>
					<td style="vertical-align: top;">https://cat.nwhardwoods.com/DMWeb/WinLogin.aspx?p=15
					</td>
				</tr>
				<tr>
					<td style="vertical-align: top;">Process Mngt (site administrators only):&nbsp;
					</td>
					<td style="vertical-align: top;">https://cat.nwhardwoods.com/DMWeb/WinLogin.aspx?p=16
					</td>
				</tr>
				<tr>
					<td style="vertical-align: top;">Session Mngt (site administrators only):&nbsp;
					</td>
					<td style="vertical-align: top;">https://cat.nwhardwoods.com/DMWeb/WinLogin.aspx?p=13
					</td>
				</tr>
				<tr>
					<td style="vertical-align: top;">User Data (site administrators only):&nbsp;
					</td>
					<td style="vertical-align: top;">https://cat.nwhardwoods.com/DMWeb/WinLogin.aspx?p=17
					</td>
				</tr>
				<tr>
					<td style="vertical-align:top;">
						User Rights (administrators only):&nbsp;
					</td>
					<td style="vertical-align:top;">
						https://cat.nwhardwoods.com/DMWeb/WinLogin.aspx?p=18
					</td>
				</tr>
				<tr>
					<td style="vertical-align:top;">
						Entity Management:&nbsp;
					</td>
					<td style="vertical-align:top;">
						https://cat.nwhardwoods.com/DMWeb/WinLogin.aspx?p=4
					</td>
				</tr>
				</table>
			</div>


		</div>
		<div id="divMainPageFOOTER" style="width:99%;margin-left:10px;">

		</div>


</asp:Content>