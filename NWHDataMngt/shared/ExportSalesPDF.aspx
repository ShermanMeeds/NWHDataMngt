<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExportSalesPDF.aspx.cs" Inherits="DataMngt.shared.ExportPDF" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

		<asp:Label ID="lblPageDefault" runat="server" Text="CSV/Excel Data Export" style="color:Blue;font-weight:bold;font-size:12pt;"></asp:Label><br />
		<br />

		<asp:Label ID="lblStatusMsg" runat="server" Text="" style="color:Maroon;font-weight:bold;"></asp:Label>
    
    </div>
    </form>
</body>
</html>
