<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ctlButtonBar.ascx.cs" Inherits="DataMngt.tools.ctlButtonBar" %>

  <script type="text/javascript">
  	var joCBbtnAssumeUserRights;
  	var joCBbtnDropUserRights;
  	var MyCBReturn7;
  	var MyCBUserList7;

  	$(document).ready(function () {
  		joCBbtnAssumeUserRights = document.getElementById('btnAssumeUserRights');
  		joCBbtnDropUserRights = document.getElementById('btnDropUserRights');
  		//alert(jsgCBAssumd);
  		if (jsgCBAssumd === 1) {
  			joCBbtnAssumeUserRights.style.display = 'none';
  			joCBbtnDropUserRights.style.display = 'inline';
  		}
  		else {
  			joCBbtnAssumeUserRights.style.display = 'inline';
  			joCBbtnDropUserRights.style.display = 'none';
  		}
  	});


  	function GotoTargetPage(url) {
      document.location.href = url;
    }

    function GetPageRightsCB() {
    	//var typ = 1;
    	//var yr = jselCalYear.value;
    	//var url = "../shared/AdminServices.asmx/SelectCalendarEvents";
    	//var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','CalType':'" + typ + "','Yr':'" + yr + "','Mo':'0','ByID':'" + jiByID.toString() + "'}";
    	////alert(MyData);																																																																	  
    	//getJSONReturnDataAs(url, MyData, function (response)
    	//{ MyCalendarEvents = response; });
    	return false;
    }

    function GetCBUserListData() {
    	//var typ = 1;
    	//var yr = jselCalYear.value;
    	var url = "../shared/AJAXServices.asmx/SelectUserListMin";
    	var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'1','Name':'','Pos':'','HasEmail':'0','Sort':'0','Active':'1','ByID':'" + jiByID.toString() + "'}";
    	//alert(MyData);																																																																	  
    	getJSONReturnDataAs(url, MyData, function (response)
    	{ MyCBUserList7 = response; });
    	return false;
    }

    function SaveSessionDataCB(nm, val) {
    	var url = "../shared/AJAXServices.asmx/SetSessionValueFromAJAX";
    	var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','SessionValName':'" + nm + "','val':'" + val + "'}";
    	//alert(MyData);																																																																	  
    	getJSONReturnDataAs(url, MyData, function (response)
    	{ MyCBReturn7 = response; });
    	return false;
		}

    function EditPgRights() {
    	alert('PageID: ' + jiPageID.toString());
    }

    function CBAssumeUserRights() {
    	var val = prompt('Enter the user login:', '');
    	if (val !== '') {
    		SaveSessionDataCB('AssumedEntityLogin', val);
    		GotoTargetPage('../page/MainMenu.aspx?v=0');
    	}
    	return false;
    }

    function CBDropUserRights() {
    	SaveSessionDataCB('AssumedEntityLogin', '');
    	GotoTargetPage('../page/MainMenu.aspx?v=0');
    	return false;
    }

    function QuitApplication() {
    	//alert('Closing!');
    	//window.close();
    	open(location, '_self').close();
    	//window.onfocus = function () { window.close(); }
    }

  </script>

<div id="divCBPopupBlock" style="display:none;"></div>

<div id="divButtonBarMAIN" runat="server" class="StdButtonBar" style="background-color:antiquewhite;border-style:ridge;border-width:thin;border-color:whitesmoke;margin-top:4px;margin-left:4px;margin-bottom:4px;margin-right:8px;">
	<table style="border: none;width:100%;padding:1px;border-spacing:0px;">
	<tr>
		<td style="text-align:left;">
			 &nbsp;Person:&nbsp;<asp:Label ID="lblPersonLoggedInName" CssClass="lblHighlightedBlueSmallest" Text="" runat="server" ></asp:Label>
		</td>
		<td style="width:70%;text-align:center;">
			<button id="btnGotoMainMenu" class="button blue-gradient glossy" onclick="javascript:GotoTargetPage('../page/MainMenu.aspx');return false;" style="margin-left:6px;margin-right:10px;margin-top:2px;margin-bottom:2px;">
				Main Menu
			</button>
			<button id="btnGotoAbout" class="button blue-gradient glossy" onclick="javascript:GotoTargetPage('../page/About.aspx');return false;" style="margin-left:6px;margin-right:10px;margin-top:2px;margin-bottom:2px;">
				About
			</button>
			<button id="btnGotoContact" class="button blue-gradient glossy" onclick="javascript:GotoTargetPage('../page/Contact.aspx');return false;" style="margin-left:6px;margin-right:10px;margin-top:2px;margin-bottom:2px;">
				Contact Information
			</button>
			<div id="divShowAdminStuff" runat="server" style="display:none;">
				<button id="btnEditPageRights" class="button blue-gradient glossy" onclick="javascript:EditPgRights();return false;" style="margin-left:6px;margin-right:10px;margin-top:2px;margin-bottom:2px;">
					Edit Page Rights
				</button>
				<button id="btnEditUserRights" class="button blue-gradient glossy" onclick="javascript:GotoTargetPage('../mngt/EditUserRights.aspx');return false;" style="margin-left:6px;margin-right:10px;margin-top:2px;margin-bottom:2px;">
					Edit User Rights
				</button>
				<button id="btnEditUsers" class="button blue-gradient glossy" onclick="javascript:GotoTargetPage('../mngt/EditUser.aspx');return false;" style="margin-left:6px;margin-right:10px;margin-top:2px;margin-bottom:2px;">
					Edit Users
				</button>
				<button id="btnAssumeUserRights" class="button blue-gradient glossy" onclick="javascript:CBAssumeUserRights();return false;" style="margin-left:6px;margin-right:10px;margin-top:2px;margin-bottom:2px;">
					Assume User
				</button>
			</div>
			<button id="btnDropUserRights" class="button blue-gradient glossy" onclick="javascript:CBDropUserRights();return false;" style="margin-left:6px;margin-right:10px;margin-top:2px;margin-bottom:2px;display:none;">
				Drop Assumed Rights
			</button>
			<asp:Button ID="btnQuitApplication" runat="server" class="button blue-gradient glossy" OnClientClick="javascript:QuitApplication();return false;" Text="Exit this Application">
			</asp:Button>
		</td>
		<td style="text-align:right;">
			Environment:&nbsp;<asp:Label ID="lblEnvironmentName" runat="server" CssClass="lblHighlightedBlueSmallest" Text="PRODUCTION"></asp:Label> &nbsp;
		</td>
	</tr>
	</table>
</div>