<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewAttachment.aspx.cs" Inherits="DataMngt.page.page_ViewAttachment" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title></title>
	<script type="text/javascript" src="../Scripts/jquery-3.2.1.min.js?v=<%=BuildNbr %>"></script>
	<link rel="stylesheet" type="text/css" href="../style/jquery-ui.1.12.1.min.css?v=1" />
	<link rel="stylesheet" type="text/css" href="../style/Site.css?v=1" />
	<link rel="stylesheet" type="text/css" href="../style/jquery-ui.structure.min.css?v=1" />
	<link rel="stylesheet" type="text/css" href="../style/jquery-ui.theme.min.css?v=1" />
	<link rel="stylesheet" type="text/css" href="../style/themes/base/jquery-ui.css?v=1" />
	<link rel="stylesheet" type="text/css" href="../style/Dialogs.css?v=1" />
	<link rel="stylesheet" type="text/css" href="../style/colors.css?v=1" />
	<link rel="stylesheet" type="text/css" href="../style/Controls.css?v=1" />

	<meta http-equiv="X-UA-Compatible" content="IE=10; IE=9; IE=8; IE=7; IE=EDGE" />
</head>
<body>
  <script type="text/javascript">
		var jiPageID = 13;

		$(document).ready(function () {
      try {
        if (jsgMsg !== '') {
          document.getElementById('lblStatusMsg').innerHTML = jsgMsg;
        }
      }
      catch (ex) {
        // nothing yet
      }
    });
  </script>



    <form id="form1" runat="server">
    <div>
    
		<label id="lblStatusMsg" style="font-family:Calibri; font-size:12pt; color:Maroon;font-weight:bold;"></label>

    </div>
    <div id="divAVControlHolder" runat="server" style="width:99%;">

    </div>
    </form>
</body>
</html>
