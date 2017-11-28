<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SessionMngt.aspx.cs" Inherits="DataMngt.page.SessionMngt" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title></title>
	<script type="text/javascript">
		var jiPageID = 24;

		function UpdateUserRightLevel(id, val) {
			var url = "../shared/AjaxServices.asmx/UpdateColumnSetting";
			var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'3','ID':'" + id.toString() + "','UserID':'0','GroupCode':'','RightLevel':'" + val + "','PageID':'" + jiPageID.toString() + "','ByID':'" + jiByID.toString() + "'}";
			//alert(MyData);
			getJSONReturnDataAs(url, MyData, function (response)
			{ MyReturn = response; });
			return false;
		}

		function ChangeDropDownVal(id, objid, row, col, val) {
			switch (objid) {
				case 93:
					//alert('Fired!');
					UpdateUserRightLevel(id, val);
					break;
				default:
					break;
			}
			return false;
		}


	</script>

</head>
<body>
  <form id="form1" runat="server">
	<asp:HiddenField ID="hfPageID" runat="server" Value="24" />

		<div id="divPageHEADER" style="width:99%;margin-left:10px;">

		</div>
    
		<div id="divPageMAINCONTENT" style="width:99%;margin-left:10px;">

		</div>
    
		<div id="divPageFOOTER" style="width:99%;margin-left:10px;">

		</div>
    
    </form>
</body>
</html>
