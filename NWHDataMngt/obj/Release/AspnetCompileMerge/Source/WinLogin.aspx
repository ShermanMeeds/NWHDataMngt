<%@ Page Language="C#" AutoEventWireup="true" Codebehind="WinLogin.aspx.cs" Inherits="WindowsLogin"  %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta http-equiv="X-UA-Compatible" content="IE=10; IE=9; IE=8; IE=7; IE=EDGE" />
  <title>Data Management</title>
</head>
<body>
  <form id="form1" runat="server">
  <div runat="server">
	<asp:HiddenField ID="hfPageID" runat="server" Value="4" />

      Northwest Hardwoods Data Management

    </div>

		<div id="divShowStatus" runat="server" style="width:99%;">
			<asp:Label ID="lblStatusMsg" runat="server"></asp:Label>
		</div>
    </form>
</body>
</html>
