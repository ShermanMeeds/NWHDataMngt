<%@ Page Language="C#" AutoEventWireup="true" Inherits="NoAccess" Codebehind="NoAccess.aspx.cs" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head runat="server">
	<meta http-equiv="X-UA-Compatible" content="IE=11; IE=10; IE=9; IE=EDGE" />
  <title>No Access</title>
</head>
<body style="background-color:ghostwhite;">

    <form id="form1" runat="server">
    <div id="divMain" runat="server">
			<asp:Label ID="lblUpperLine" runat="server" Text="You do not have access to this web site." style="color:maroon;font-size:14pt;font-weight:bold;"></asp:Label>
			<br /><br />

			<label id="lblSpecMsg" style="color:black;font-weight:bold;"></label>
    </div>
    </form>

	<script type="text/javascript">
		document.getElementById('lblSpecMsg').innerHTML = jsgMsg;
	</script>

</body>
</html>