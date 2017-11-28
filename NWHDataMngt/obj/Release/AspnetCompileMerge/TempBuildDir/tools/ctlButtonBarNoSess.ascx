<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ctlButtonBarNoSess.ascx.cs" Inherits="DataMngt.tools.ctlButtonBarNoSess" %>

  <script type="text/javascript">
  	var jCBbIsAdmin = false;
  	var jCBiByID = 0;
  	var jCBiPageID = 0;
  	var jCBsBrowserType = '';
  	var jselCBAddPersonE;
  	var jselCBAddRightsE;
  	var jCBsErrMsg = '';
  	var jCBsPA = '';
  	var joCBbtnAssumeUserRights;
  	var joCBbtnDropUserRights;
  	var jtblCBPageRights;
  	var MyCBPageRightsList;
  	var MyReturnCB;
  	var MyUserListCB;

  	$(document).ready(function () {
  		jCBsBrowserType = jsgCBBrowserType;
  		jCBiByID = jCBigEmpID;
  		if (jgCBA === true) { jCBbIsAdmin = true; }
  		jCBsErrMsg = jCBsgError;
  		jCBsPA = jsgCBPageA;
  		//alert('here 1');
  		try {
  			jCBiPageID = document.getElementById('hfPageID').value;
  		}
  		catch (ex) {
				// nothing
  		}
  		try {
  			if (jCBiPageID === 0) {
  				jCBiPageID = document.getElementById('MainContent_hfPageID').value;
  			}
  		}
  		catch (ex) {
				// nothing
  		}
  		if (jCBbIsAdmin === false && jCBsPA.length > 0) {
  			// make admin for this page if admin for this page ID
  			if (!IsContentsNullUndefEmptyGu(jCBsPA)) {
  				if (jCBsPA.indexOf('|' + jCBiPageID.toString() + '|') > -1) { jCBbIsAdmin = true; }
  			}
  		}
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

  		if (jCBbIsAdmin === true) {
  			document.getElementById('btnEditPageRights').style.display = 'inline';
  		}

  		//alert(jCBiPageID + '/' + jCBbIsAdmin + '/' + jCBiByID + '/' + jgCBA + '/' + jCBsPA);
  		if (jCBbIsAdmin === true && jCBiPageID > 0 && !IsContentsNullUndefinedGu(MyCBPageRightsList)) {
  			GetPageRightsCB();
  			var idx = IdentifyArrayIndexGu(MyCBPageRightsList, 'RightLvl', '5');	// index beginning at 1 not 0
  			if (idx > 0 && idx < 999) { document.getElementById('btnEditPageRights').style.display = 'inline'; }
  		}

  		jselCBAddPersonE = document.getElementById('selCBAddPersonE');
  		jselCBAddRightsE = document.getElementById('selCBAddRightsE');
  		jtblCBPageRights = document.getElementById('tblCBPageRights');
  		//alert('here 2');

  	});

  	function GotoTargetPage(url) {
      document.location.href = url;
    }

    function GetPageRightsCB() {
    	var url = "../shared/AdminServices.asmx/SelectPageRightsList";
    	var MyData = "{'PgID':'" + jCBiPageID.toString() + "','ObjID':'0','ByID':'" + jCBiByID.toString() + "'}";
    	//alert(MyData);																																																																	  
    	getJSONReturnDataAs(url, MyData, function (response)
    	{ MyCBPageRightsList = response; });
    	return false;
    }

    function GetUserListCB(id, nm, ctry, city, loc, pos, grp, sort, act) {
    	var url = "../shared/AdminServices.asmx/SelectUserList";
    	var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','ID':'" + id.toString() + "','Name':'" + nm + "','Ctry':'" + ctry + "','City':'" + city + "','Loc':'" + loc + "','Pos':'" + pos + "','Grp':'" + grp + "',";
    	MyData = MyData + "'Sort':'" + sort.toString() + "','Active':'" + act.toString() + "','ByID':'" + jiByID.toString() + "'}";
    	//alert(MyData);
    	getJSONReturnDataAs(url, MyData, function (response)
    	{ MyUserListCB = response; });
    	return false;
    }

    function AddNewRightsToPers() {
    	var id = parseInt(jselCBAddPersonE.value, 10);
    	var rl = parseInt(jselCBAddRightsE.value, 10);
    	var url = "../shared/AdminServices.asmx/UpdateUserRightLevel";
    	var MyData = "{'PgID':'" + jiPageID.toString() + "','ObjID':'0','UserID':'" + id.toString() + "','GroupCode':'','RightLevel':'" + rl.toString() + "','PageID':'" + jCBiPageID.toString() + "',";
    	MyData = MyData + "'ByID':'" + jiByID.toString() + "'}";
    	//alert(MyData);
    	getJSONReturnDataAs(url, MyData, function (response)
    	{ MyReturnCB = response; });
    	return false;
    }

    function PopulateCBPageRightsCB() {
    	//alert('Filling Proc List');
    	var bdyCB;
    	var nColCB = 5;
    	// Cols: 0-UserID, 1-Name, 2-GroupCode, 3-Level DDL, 4-Action
    	var cWidthCB = [50, 160, 80, 80, 36, 0, 0, 0, 0, 0];
    	var corientHCB = ['center', 'left', 'center', 'left', 'center', 'center', 'center', ''];
    	var corientVCB = ['top', 'top', 'top', 'top', 'top', 'top', '', '', ''];
    	var cbrdrLCB = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', ''];
    	var cbrdrRCB = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', ''];
    	var cbrdrTCB = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', ''];
    	var cbrdrBCB = ['1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', ''];
    	var cnamesCB = ['UserID', 'sFullName', 'UserGroupCode', 'RightLvl', 'ACTION', '', '', ''];
    	var cTypeCB = [0, 0, 0, 6, 0, 0, 0, 0];
    	var aggTypeCB = [0, 0, 0, 0, 0, 0, 0, 0];
			var shown = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
    	EmptyDDLListsDg();
    	jsDGColDDLOpts[3][0] = '1|View';
    	jsDGColDDLOpts[3][1] = '2|Restricted';
    	jsDGColDDLOpts[3][2] = '3|Editor';
    	jsDGColDDLOpts[3][3] = '4|SuperUser';
    	jsDGColDDLOpts[3][4] = '5|Admin';
    	if (!IsContentsNullUndefinedTx(MyCBPageRightsList)) {
    		bdyCB = FormDataGridBodyMinimumDg(93, nColCB, 'tdCBPgRightz', 'StdTableCell', false, true, false, false, '', 'button blue-gradient glossy', false, 0, MyCBPageRightsList, 'GroupUserID', cnamesCB, cTypeCB, cWidthCB, corientHCB, corientVCB, cbrdrLCB, cbrdrRCB, cbrdrTCB, cbrdrBCB, aggTypeCB, shown, false, true);
    	}
    	//alert('Attaching body');
    	try {
    		var oldBody = jtblCBPageRights.getElementsByTagName("tbody")[0];
    		jtblCBPageRights.replaceChild(bdyCB, oldBody);
    	}
    	catch (ex) {
    		// nothing
    	}
    }

    function PopulateUserListCB() {
    	GetUserListCB(0, '', '', '', '', '', '', 0, 1);
    	if (!IsContentsNullUndefinedTx(MyUserListCB)) {
    		ClearDDLOptionsGu('selCBAddPersonE', 1);
    		fillDropDownListGu(MyUserListCB, jselCBAddPersonE, 0, 'UserFullName', 'UserID');
    	}
    	return false;
    }

    function EditPgRightsCB() {
    	var ht = 900;
    	var wdth = 516;
    	//alert('1');
    	GetPageRightsCB();
    	//alert('2');
    	PopulateCBPageRightsCB();
    	//alert('3');
    	ShowSpecialDialogBox1Dx('divCBPopupTemplate', 'PageRights for Page ID ' + jCBiPageID.toString(), true, true, ht, wdth, '', '', window, '', 'Done', '11pt', '1px', 'fadeIn', 'fadeOut', 94)
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

	<div id="divCBPopupTemplate" style="display:none;">
		<div id="divCBPopupHdr" style="width:100%;text-align:center;margin-bottom:8px;background-color:antiquewhite;">
			Add&nbsp;Person:&nbsp;
			<select id="selCBAddPersonE">
				<option value="0" selected="selected">None Selected</option>
			</select>&nbsp;Rights:&nbsp;
			<select id="selCBAddRightsE">
				<option value="0" selected="selected">None Selected</option>
				<option value="1">View Only</option>
				<option value="2">Restricted-Edit</option>
				<option value="3">Editor</option>
				<option value="4">Super-User</option>
				<option value="5">Administrator</option>
			</select>&nbsp;&nbsp;
			<button id="btnCBAddPersonRights" class="button blue-gradient glossy" onclick="javascript:AddNewRightsToPers();return false;">Add</button>
		</div>
		<table id="tblCBPageRights" style="padding:1px;border-spacing:0px;border:1px solid gray;">
		<thead>
		<tr>
			<th class="ColHeaderStd" style="width:50px;">UserID</th>
			<th class="ColHeaderStd" style="width:160px;">Name</th>
			<th class="ColHeaderStd" style="width:80px;">Group</th>
			<th class="ColHeaderStd" style="width:80px;">Level</th>
			<th class="ColHeaderStd" style="width:36px;">Action</th>
		</tr>
		</thead>
		<tbody></tbody>
		</table>
	</div>

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
				<button id="btnEditPageRights" class="button blue-gradient glossy" onclick="javascript:EditPgRightsCB();return false;" style="margin-left:6px;margin-right:10px;margin-top:2px;margin-bottom:2px;display:none;">
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
