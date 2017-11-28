<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WurthTagPreview.aspx.cs" Inherits="DataMngt.prod.WurthTagPreview" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>Wurth Tag</title>
	<script type="text/javascript" src="../Scripts/jquery-3.2.1.min.js?v=<%=BuildNbr %>"></script>
	<script type="text/javascript" src="../Scripts/jquery-ui.1.12.1.min.js?v=<%=BuildNbr %>"></script>
	<script type="text/javascript" src="../Scripts/jqueryAJAXTransport.js?v=<%=BuildNbr %>"></script>
	<script type="text/javascript" src="../Scripts/GenUtils.js?v=<%=BuildNbr %>"></script>
	<script type="text/javascript" src="../Scripts/DateMngt.js?v=<%=BuildNbr %>"></script>
	<script type="text/javascript" src="../Scripts/TxtUtilities.js?v=<%=BuildNbr %>"></script>
  <script type="text/javascript" src="../Scripts/barcode.js?v=<%=BuildNbr %>"></script>

	<link rel="stylesheet" type="text/css" href="../style/Site.css" />
	<style type="text/css">

		@page {
		  size: landscape;
			margin:0px;
		}

		@font-face{
			font-family:free3of9x;
			src: url(free3of9x.ttf);
		}

		@media print{@page {size: portrait}}

		.FirstDivInSet {
			margin-top:10px;
			margin-left:40px;
			font-size:20pt;
			width:100%;
		}

		.BarCodeTable {
			margin:0px;
			padding:1px;
			border-spacing:0px;
			width:100%;
			font-size:12pt;
			text-align:left;
			line-height:16px;
		}
		
		.BarCodeTableDiv {
			margin-left:40px;
			width:100%;
		}

		.ItemNbrFieldPg {
			margin-left: 30px;
			font-size: 16pt;
			font-weight: normal;
		}

		.StdHdrIdent {
			top:40px;
			left:480px;
			font-size:14pt;
		}

		.StdDivItemTFirst {
			width: 750px;
			height: 300px;
			top:30px;
			position:relative;
			/*page-break-after:always;*/
			margin-bottom:2px;
			margin-top:10px;
			padding-top:10px;
		}

		.StdDivItemT {
			width: 750px;
			height: 300px;
			top:30px;
			position:relative;
			/*page-break-after:always;*/
			margin-bottom:2px;
			margin-top:10px;
			padding-top:20px;
		}

		.StdDivItemB {
			width: 750px;
			height: 300px;
			position:relative;
			page-break-after:always;
			margin-top: 0px;
			margin-bottom:2px;
			padding-top:0px;
		}

		.StdDivItemLast {
			width: 750px;
			height: 300px;
			position:relative;
			margin-bottom:2px;
			padding-top:0px;
		}

		.StdBarCodeLabel {
			font-size:18pt;
			margin: 0px;
		}

		.StdBarCodeText {
			font-size:18pt;
			margin: 0px;
		}

		.StdItemLabelPg {
			font-size:18pt;
			vertical-align: top;
			text-align: left;
			font-weight: bold;
			height:66px;
		}

		.LowerAddressBlock {
			margin-left:40px;
			font-size:18pt;
			color:darkslategray;
		}

		.UnitNbrBlock {
			margin-top:10px;
			margin-left:40px;
			font-size:18pt;
			border-top: 1px solid gray;
			border-bottom: 1px solid gray;
		}
	</style>

	<script type="text/javascript">
		var cmPX = 0;
		var jiNbrRows = 0;
		var jObj;
		var joFt;
		var joItemNbr;
		var joLen;
		var joPONbr;
		var joWidth = 0;
		var jsErrorMsg = '';
		var NbrPxPerInch = 0;
		var s = '';

		$.when($.ready).then(function () {
			//alert('Fired!');
			jdToday = new Date;
			var nbrlines = 0;
			try {
				jiNbrRows = jgNItems;
				//joItemNbr = jogItemNbr;
				//joFt = jogFootage;
				//joLen = jogLen;
				//joPONbr = jogPONbr;
				  // var jgNItems=2;var jogItemNbr=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];var jogPONbr=['VA Stock sw1711','VA Stock sw1711','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0'];var jogFootage=[4000.0000000000,4000.0000000000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];var jogLen=[8,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];

				// get pixels per cm
				cmPX = GetNbrPxInCM();
				NbrPxPerInch = ConvertCMtoInches(GetNbrPxInCM());
				var tdivheight = NbrPxPerInch * 5; //.25;
				//alert(tdivheight);
				//var tdivwidth = NbrPxPerInch * 8.5;

				if (jiNbrRows > 0) {
					// DrawHTMLBarcode_Code39(data,	checkDigit, humanReadable, units, minBarWidth, width, height, barWidthRatio, textLocation, textAlignment, textStyle, foreColor, backColor)
					for (var row = 0; row < jiNbrRows; row++) {
						joWidth = 2.0;
						jObj = get_object("lblItemNbrBarCode" + row.toString());
						//jObj.style.display = 'none';
						s = jObj.innerHTML;
						DrawBarCodeInField(jObj, s, GetBarCodeFieldLen(s), 0); //jObj.innerHTML = DrawHTMLBarcode_Code39(jObj.innerHTML, 1, "yes", "in", 0, GetBarCodeFieldLen(s), .8, 3, "bottom", "left", "", "black", "white");
						jObj = get_object("lblPONbrBarCode" + row.toString());
						s = jObj.innerHTML;
						DrawBarCodeInField(jObj, s, GetBarCodeFieldLen(s), 1);
						//jObj.innerHTML = DrawHTMLBarcode_Code39(jObj.innerHTML, 1, "yes", "in", 0, GetBarCodeFieldLen(s), .8, 2, "bottom", "left", "", "black", "white");
						jObj = get_object("lblFootageBarCode" + row.toString());
						s = jObj.innerHTML;
						DrawBarCodeInField(jObj, s, GetBarCodeFieldLen(s), 1);
						//jObj.innerHTML = DrawHTMLBarcode_Code39(jObj.innerHTML, 1, "yes", "in", 0, GetBarCodeFieldLen(s), .8, 3, "bottom", "left", "", "black", "white");
						jObj = get_object("lblLengthBarCode" + row.toString());
						s = jObj.innerHTML;
						DrawBarCodeInField(jObj, s, GetBarCodeFieldLen(s), 1);
						//jObj.innerHTML = DrawHTMLBarcode_Code39(jObj.innerHTML, 1, "yes", "in", 0, GetBarCodeFieldLen(s), .8, 3, "bottom", "left", "", "black", "white");
						jObj = get_object("divOrderItem" + row.toString());
						s = jObj.innerHTML;
						jObj.style.height = tdivheight.toString() + 'px';
						nbrlines++;
					}
				}
			}
			catch (ex) {
				jbFailed = true;
				alert('Error while loading initial data for tag. The tag cannot be printed at this time-' + nbrlines.ToString() + '.' + ex.message);
			}
			//alert('last part to Printing');
			if (jsErrorMsg.length > 0) {
				alert(jsErrorMsg);
			}
			else {
				//alert('Printing...');
				printAllLabels();
			}
			// ***********************************************************************************************
		});

		function DrawBarCodeInField(tobj, txt, len, withtxt) {
			var tratio = 3;
			//if (txt.length > 6) { tratio = 2.4;}
			if (txt !== '0') {
				if (withtxt === 1) {
					tobj.innerHTML = DrawHTMLBarcode_Code39(txt, 1, "yes", "in", 0, len, .6, tratio, "bottom", "left", "", "black", "white");
				}
				else {
					tobj.innerHTML = DrawHTMLBarcode_Code39(txt, 1, "no", "in", 0, len, .6, tratio, "bottom", "left", "", "black", "white");
				}
			}
			else {
				tobj.innerHTML = '';
			}
		}

		function GetBarCodeFieldLen(txt) {
			var fig = txt.length * .2;
			//if (fig < .4) { fig = .4;}
			return fig + .6;
		}

		function get_object(id) {
			return document.getElementById(id);
		}

		function px2cm(px) {
			var d = $("<div/>").css({ position: 'absolute', top: '-1000cm', left: '-1000cm', height: '1000cm', width: '1000cm' }).appendTo('body');
			var px_per_cm = d.height() / 1000;
			d.remove();
			return px / px_per_cm;
		}

		function GetNbrPxInCM() {
			var d = $("<div/>").css({ position: 'absolute', top: '-1000cm', left: '-1000cm', height: '1000cm', width: '1000cm' }).appendTo('body');
			var px_per_cm = d.height() / 1000;
			d.remove();
			return px_per_cm;
		}

		function ConvertCMtoInches(cmfig) {
			return cmfig / 0.393700;
		}

		function cmConverter(cmfig, typ) {
			switch (typ) {
				case 0: // inches
					return cmfig / 2.54;
					break;
				default: // feet
					return cmfig / 30.48;
					break;
			}
			return 0;
		}

		function inchConverter(inchfig, typ) {
			switch (typ) {
				case 0: // cm
					return inchfig * 2.54;
					break;
				default: // feet
					return inchfig / 12;
					break;
			}
			return 0;
		}

		function feetConverter(fig, typ) {
			switch (typ) {
				case 0: // cm
					return fig * 30.48;
					break;
				default: // inches
					return fig * 12;
					break;
			}
			return 0;
		}

		function ConvertBFToCubicMtrs(fig) {
			var cf = fig / 12;
			return cf * .02831685;
		}

		function printAllLabels() {
			//alert('Printing');
			window.print();
		//	window.onfocus = function () { window.close(); }
		}

	</script>

</head>
<body style="color:black;background-color:white;" onblur="self.focus()"">
  <form id="form1" runat="server">

	<div id="divMainPageContent" style="left:30px;">

    <div id="divOrderItem0" runat="server" class="StdDivItemTFirst" style="height:300px;display:block;">
			<div id="divMainTagHeader0" runat="server" class="FirstDivInSet">
				<asp:Label id="lblMainTagHeader0" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderAddress0" runat="server" class="LowerAddressBlock">
				<asp:Label id="lblTagHdrAddress0" runat="server" Text=""></asp:Label><br />
				<asp:Label id="lblTagHdrCityStZip0" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<asp:Label id="lblTagHdrCountry0" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderIdent0" runat="server" class="StdHdrIdent" style="position:absolute;">
				<table style="padding:2px;border-spacing:0px;line-height:22px;">
				<tr><td style="width:80px;">ORDER&nbsp;NO</td><td>-&nbsp;</td><td><asp:Label ID="lblOrderNbr0" runat="server" Text=""></asp:Label></td></tr>
				<tr><td style="width:80px;">SHIP&nbsp;DATE</td><td>-&nbsp;</td><td><asp:Label ID="lblShipDate0" runat="server" Text=""></asp:Label></td></tr>
				</table>
			</div>
			<div id="divUnitNbr0" runat="server" class="UnitNbrBlock" style="margin-bottom:12px;">
				<span style="width:220px;"><asp:Label ID="lblUnitNbrLabel0" runat="server" Text="Unit Number:"></asp:Label></span>
				<span style="margin-left:20px;"><asp:Label ID="lblUnitNbrValue0" runat="server" Text=""></asp:Label></span>
			</div>
			<div id="divItemNbr0" runat="server" class="BarCodeTableDiv">
				<table class="BarCodeTable">
				<tr style="height:74px;">
					<td style="width:190px;" class="StdItemLabelPg">Item Number:<br /><span style="margin-top:6px;"><asp:Label ID="lblItemNbr0" runat="server" CssClass="ItemNbrFieldPg" Font-Size="15pt" ></asp:Label></span></td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;vertical-align:top;" colspan="3"><asp:Label ID="lblItemNbrBarCode0" runat="server" CssClass="StdBarCodeText"></asp:Label></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">P.O. Number:</td><td>&nbsp;</td>
					<td colspan="3" style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblPONbrBarCode0" runat="server" CssClass="StdBarCodeLabel" ></asp:Label><br /></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">Footage/Length:</td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;width:200px;vertical-align:top;"><asp:Label ID="lblFootageBarCode0" runat="server" CssClass="StdBarCodeText" ></asp:Label><br /></td>
					<td>&nbsp;</td><td style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblLengthBarCode0" runat="server"></asp:Label><br /></td>
				</tr>
				</table>
			</div>
    </div>

		<div id="divOrderItem1" runat="server" class="StdDivItemB" style="display:none;height:300px;">
			<div id="divMainTagHeader1" runat="server" class="FirstDivInSet">
				<asp:Label id="lblMainTagHeader1" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderAddress1" runat="server" class="LowerAddressBlock">
				<asp:Label id="lblTagHdrAddress1" runat="server" Text=""></asp:Label><br />
				<asp:Label id="lblTagHdrCityStZip1" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<asp:Label id="lblTagHdrCountry1" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderIdent1" runat="server" class="StdHdrIdent" style="position:absolute;">
				<table style="padding:2px;border-spacing:0px;line-height:26px;">
				<tr><td style="width:80px;">ORDER&nbsp;NO</td><td>-&nbsp;</td><td><asp:Label ID="lblOrderNbr1" runat="server" Text=""></asp:Label></td></tr>
				<tr><td style="width:80px;">SHIP&nbsp;DATE</td><td>-&nbsp;</td><td><asp:Label ID="lblShipDate1" runat="server" Text=""></asp:Label></td></tr>
				</table>
			</div>
			<div id="divUnitNbr1" runat="server" class="UnitNbrBlock" style="margin-bottom:12px;">
				<span style="width:220px;"><asp:Label ID="lblUnitNbrLabel1" runat="server" Text="Unit Number:"></asp:Label></span>
				<span style="margin-left:20px;"><asp:Label ID="lblUnitNbrValue1" runat="server" Text=""></asp:Label></span>
			</div>
			<div id="divItemNbr1" runat="server" class="BarCodeTableDiv">
				<table class="BarCodeTable">
				<tr style="height:74px;">
					<td style="width:190px;" class="StdItemLabelPg">Item Number:<br /><span style="margin-top:6px;"><asp:Label ID="lblItemNbr1" runat="server" CssClass="ItemNbrFieldPg"></asp:Label></span></td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;vertical-align:top;" colspan="3"><asp:Label ID="lblItemNbrBarCode1" runat="server" CssClass="StdBarCodeText"></asp:Label></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">P.O. Number:</td><td>&nbsp;</td>
					<td colspan="3" style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblPONbrBarCode1" runat="server" CssClass="StdBarCodeLabel" ></asp:Label><br /></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">Footage/Length:</td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;width:200px;vertical-align:top;"><asp:Label ID="lblFootageBarCode1" runat="server" CssClass="StdBarCodeText" ></asp:Label><br /></td>
					<td>&nbsp;</td><td style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblLengthBarCode1" runat="server"></asp:Label><br /></td>
				</tr>
				</table>
			</div>
    </div>

    <div id="divOrderItem2" runat="server" class="StdDivItemT" style="display:none;height:300px;">
			<div id="divMainTagHeader2" runat="server" class="FirstDivInSet">
				<asp:Label id="lblMainTagHeader2" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderAddress2" runat="server" class="LowerAddressBlock">
				<asp:Label id="lblTagHdrAddress2" runat="server" Text=""></asp:Label><br />
				<asp:Label id="lblTagHdrCityStZip2" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<asp:Label id="lblTagHdrCountry2" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderIdent2" runat="server" class="StdHdrIdent" style="position:absolute;">
				<table style="padding:2px;border-spacing:0px;line-height:22px;">
				<tr><td style="width:80px;">ORDER&nbsp;NO</td><td>-&nbsp;</td><td><asp:Label ID="lblOrderNbr2" runat="server" Text=""></asp:Label></td></tr>
				<tr><td style="width:80px;">SHIP&nbsp;DATE</td><td>-&nbsp;</td><td><asp:Label ID="lblShipDate2" runat="server" Text=""></asp:Label></td></tr>
				</table>
			</div>
			<div id="divUnitNbr2" runat="server" class="UnitNbrBlock" style="margin-bottom:12px;">
				<span style="width:220px;"><asp:Label ID="lblUnitNbrLabel2" runat="server" Text="Unit Number:"></asp:Label></span>
				<span style="margin-left:20px;"><asp:Label ID="lblUnitNbrValue2" runat="server" Text=""></asp:Label></span>
			</div>
			<div id="divItemNbr2" runat="server" class="BarCodeTableDiv">
				<table class="BarCodeTable">
				<tr style="height:74px;">
					<td style="width:190px;" class="StdItemLabelPg">Item Number:<br /><span style="margin-top:6px;"><asp:Label ID="lblItemNbr2" runat="server" CssClass="ItemNbrFieldPg" ></asp:Label></span></td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;vertical-align:top;" colspan="3"><asp:Label ID="lblItemNbrBarCode2" runat="server" CssClass="StdBarCodeText"></asp:Label></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">P.O. Number:</td><td>&nbsp;</td>
					<td colspan="3" style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblPONbrBarCode2" runat="server" CssClass="StdBarCodeLabel" ></asp:Label><br /></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">Footage/Length:</td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;width:200px;vertical-align:top;"><asp:Label ID="lblFootageBarCode2" runat="server" CssClass="StdBarCodeText" ></asp:Label><br /></td>
					<td>&nbsp;</td><td style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblLengthBarCode2" runat="server"></asp:Label><br /></td>
				</tr>
				</table>
			</div>
    </div>

		<div id="divOrderItem3" runat="server" class="StdDivItemB" style="display:none;">
			<div id="divMainTagHeader3" runat="server" class="FirstDivInSet">
				<asp:Label id="lblMainTagHeader3" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderAddress3" runat="server" class="LowerAddressBlock">
				<asp:Label id="lblTagHdrAddress3" runat="server" Text=""></asp:Label><br />
				<asp:Label id="lblTagHdrCityStZip3" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<asp:Label id="lblTagHdrCountry3" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderIdent3" runat="server" class="StdHdrIdent" style="position:absolute;">
				<table style="padding:2px;border-spacing:0px;line-height:22px;">
				<tr><td style="width:80px;">ORDER&nbsp;NO</td><td>-&nbsp;</td><td><asp:Label ID="lblOrderNbr3" runat="server" Text=""></asp:Label></td></tr>
				<tr><td style="width:80px;">SHIP&nbsp;DATE</td><td>-&nbsp;</td><td><asp:Label ID="lblShipDate3" runat="server" Text=""></asp:Label></td></tr>
				</table>
			</div>
			<div id="divUnitNbr3" runat="server" class="UnitNbrBlock" style="margin-bottom:12px;">
				<span style="width:220px;"><asp:Label ID="lblUnitNbrLabel3" runat="server" Text="Unit Number:"></asp:Label></span>
				<span style="margin-left:20px;"><asp:Label ID="lblUnitNbrValue3" runat="server" Text=""></asp:Label></span>
			</div>
			<div id="divItemNbr3" runat="server" class="BarCodeTableDiv">
				<table class="BarCodeTable">
				<tr style="height:74px;">
					<td style="width:190px;" class="StdItemLabelPg">Item Number:<br /><span style="margin-top:6px;"><asp:Label ID="lblItemNbr3" runat="server" CssClass="ItemNbrFieldPg" ></asp:Label></span></td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;vertical-align:top;" colspan="3"><asp:Label ID="lblItemNbrBarCode3" runat="server" CssClass="StdBarCodeText"></asp:Label></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">P.O. Number:</td><td>&nbsp;</td>
					<td colspan="3" style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblPONbrBarCode3" runat="server" CssClass="StdBarCodeLabel" ></asp:Label><br /></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">Footage/Length:</td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;width:200px;vertical-align:top;"><asp:Label ID="lblFootageBarCode3" runat="server" CssClass="StdBarCodeText" ></asp:Label><br /></td>
					<td>&nbsp;</td><td style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblLengthBarCode3" runat="server"></asp:Label><br /></td>
				</tr>
				</table>
			</div>
    </div>

    <div id="divOrderItem4" runat="server" class="StdDivItemT" style="display:none;height:300px;">
			<div id="divMainTagHeader4" runat="server" class="FirstDivInSet">
				<asp:Label id="lblMainTagHeader4" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderAddress4" runat="server" class="LowerAddressBlock">
				<asp:Label id="lblTagHdrAddress4" runat="server" Text=""></asp:Label><br />
				<asp:Label id="lblTagHdrCityStZip4" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<asp:Label id="lblTagHdrCountry4" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderIdent4" runat="server" class="StdHdrIdent" style="position:absolute;">
				<table style="padding:2px;border-spacing:0px;line-height:22px;">
				<tr><td style="width:80px;">ORDER&nbsp;NO</td><td>-&nbsp;</td><td><asp:Label ID="lblOrderNbr4" runat="server" Text=""></asp:Label></td></tr>
				<tr><td style="width:80px;">SHIP&nbsp;DATE</td><td>-&nbsp;</td><td><asp:Label ID="lblShipDate4" runat="server" Text=""></asp:Label></td></tr>
				</table>
			</div>
			<div id="divUnitNbr4" runat="server" class="UnitNbrBlock" style="margin-bottom:12px;">
				<span style="width:220px;"><asp:Label ID="lblUnitNbrLabel4" runat="server" Text="Unit Number:"></asp:Label></span>
				<span style="margin-left:20px;"><asp:Label ID="lblUnitNbrValue4" runat="server" Text=""></asp:Label></span>
			</div>
			<div id="divItemNbr4" runat="server" class="BarCodeTableDiv">
				<table class="BarCodeTable">
				<tr style="height:74px;">
					<td style="width:190px;" class="StdItemLabelPg">Item Number:<br /><span style="margin-top:6px;"><asp:Label ID="lblItemNbr4" runat="server" CssClass="ItemNbrFieldPg" ></asp:Label></span></td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;vertical-align:top;" colspan="3"><asp:Label ID="lblItemNbrBarCode4" runat="server" CssClass="StdBarCodeText"></asp:Label></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">P.O. Number:</td><td>&nbsp;</td>
					<td colspan="3" style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblPONbrBarCode4" runat="server" CssClass="StdBarCodeLabel" ></asp:Label><br /></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">Footage/Length:</td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;width:200px;vertical-align:top;"><asp:Label ID="lblFootageBarCode4" runat="server" CssClass="StdBarCodeText" ></asp:Label><br /></td>
					<td>&nbsp;</td><td style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblLengthBarCode4" runat="server"></asp:Label><br /></td>
				</tr>
				</table>
			</div>
    </div>

		<div id="divOrderItem5" runat="server" class="StdDivItemB" style="display:none;">
			<div id="divMainTagHeader5" runat="server" class="FirstDivInSet">
				<asp:Label id="lblMainTagHeader5" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderAddress5" runat="server" class="LowerAddressBlock">
				<asp:Label id="lblTagHdrAddress5" runat="server" Text=""></asp:Label><br />
				<asp:Label id="lblTagHdrCityStZip5" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<asp:Label id="lblTagHdrCountry5" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderIdent5" runat="server" class="StdHdrIdent" style="position:absolute;">
				<table style="padding:2px;border-spacing:0px;line-height:22px;">
				<tr><td style="width:80px;">ORDER&nbsp;NO</td><td>-&nbsp;</td><td><asp:Label ID="lblOrderNbr5" runat="server" Text=""></asp:Label></td></tr>
				<tr><td style="width:80px;">SHIP&nbsp;DATE</td><td>-&nbsp;</td><td><asp:Label ID="lblShipDate5" runat="server" Text=""></asp:Label></td></tr>
				</table>
			</div>
			<div id="divUnitNbr5" runat="server" class="UnitNbrBlock" style="margin-bottom:12px;">
				<span style="width:220px;"><asp:Label ID="lblUnitNbrLabel5" runat="server" Text="Unit Number:"></asp:Label></span>
				<span style="margin-left:20px;"><asp:Label ID="lblUnitNbrValue5" runat="server" Text=""></asp:Label></span>
			</div>
			<div id="divItemNbr5" runat="server" class="BarCodeTableDiv">
				<table class="BarCodeTable">
				<tr style="height:74px;">
					<td style="width:190px;" class="StdItemLabelPg">Item Number:<br /><span style="margin-top:6px;"><asp:Label ID="lblItemNbr5" runat="server" CssClass="ItemNbrFieldPg" ></asp:Label></span></td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;vertical-align:top;" colspan="3"><asp:Label ID="lblItemNbrBarCode5" runat="server" CssClass="StdBarCodeText"></asp:Label></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">P.O. Number:</td><td>&nbsp;</td>
					<td colspan="3" style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblPONbrBarCode5" runat="server" CssClass="StdBarCodeLabel" ></asp:Label><br /></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">Footage/Length:</td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;width:200px;vertical-align:top;"><asp:Label ID="lblFootageBarCode5" runat="server" CssClass="StdBarCodeText" ></asp:Label><br /></td>
					<td>&nbsp;</td><td style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblLengthBarCode5" runat="server"></asp:Label><br /></td>
				</tr>
				</table>
			</div>
    </div>
		
    <div id="divOrderItem6" runat="server" class="StdDivItemT" style="display:none;height:300px;">
			<div id="divMainTagHeader6" runat="server" class="FirstDivInSet">
				<asp:Label id="lblMainTagHeader6" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderAddress6" runat="server" class="LowerAddressBlock">
				<asp:Label id="lblTagHdrAddress6" runat="server" Text=""></asp:Label><br />
				<asp:Label id="lblTagHdrCityStZip6" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<asp:Label id="lblTagHdrCountry6" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderIdent6" runat="server" class="StdHdrIdent" style="position:absolute;">
				<table style="padding:2px;border-spacing:0px;line-height:22px;">
				<tr><td style="width:80px;">ORDER&nbsp;NO</td><td>-&nbsp;</td><td><asp:Label ID="lblOrderNbr6" runat="server" Text=""></asp:Label></td></tr>
				<tr><td style="width:80px;">SHIP&nbsp;DATE</td><td>-&nbsp;</td><td><asp:Label ID="lblShipDate6" runat="server" Text=""></asp:Label></td></tr>
				</table>
			</div>
			<div id="divUnitNbr6" runat="server" class="UnitNbrBlock" style="margin-bottom:12px;">
				<span style="width:220px;"><asp:Label ID="lblUnitNbrLabel6" runat="server" Text="Unit Number:"></asp:Label></span>
				<span style="margin-left:20px;"><asp:Label ID="lblUnitNbrValue6" runat="server" Text=""></asp:Label></span>
			</div>
			<div id="divItemNbr6" runat="server" class="BarCodeTableDiv">
				<table class="BarCodeTable">
				<tr style="height:74px;">
					<td style="width:190px;" class="StdItemLabelPg">Item Number:<br /><span style="margin-top:6px;"><asp:Label ID="lblItemNbr6" runat="server" CssClass="ItemNbrFieldPg" ></asp:Label></span></td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;vertical-align:top;" colspan="3"><asp:Label ID="lblItemNbrBarCode6" runat="server" CssClass="StdBarCodeText"></asp:Label></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">P.O. Number:</td><td>&nbsp;</td>
					<td colspan="3" style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblPONbrBarCode6" runat="server" CssClass="StdBarCodeLabel" ></asp:Label><br /></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">Footage/Length:</td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;width:200px;vertical-align:top;"><asp:Label ID="lblFootageBarCode6" runat="server" CssClass="StdBarCodeText" ></asp:Label><br /></td>
					<td>&nbsp;</td><td style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblLengthBarCode6" runat="server"></asp:Label><br /></td>
				</tr>
				</table>
			</div>
    </div>

		<div id="divOrderItem7" runat="server" class="StdDivItemB" style="display:none;">
			<div id="divMainTagHeader7" runat="server" class="FirstDivInSet">
				<asp:Label id="lblMainTagHeader7" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderAddress7" runat="server" class="LowerAddressBlock">
				<asp:Label id="lblTagHdrAddress7" runat="server" Text=""></asp:Label><br />
				<asp:Label id="lblTagHdrCityStZip7" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<asp:Label id="lblTagHdrCountry7" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderIdent7" runat="server" class="StdHdrIdent" style="position:absolute;">
				<table style="padding:2px;border-spacing:0px;line-height:22px;">
				<tr><td style="width:80px;">ORDER&nbsp;NO</td><td>-&nbsp;</td><td><asp:Label ID="lblOrderNbr7" runat="server" Text=""></asp:Label></td></tr>
				<tr><td style="width:80px;">SHIP&nbsp;DATE</td><td>-&nbsp;</td><td><asp:Label ID="lblShipDate7" runat="server" Text=""></asp:Label></td></tr>
				</table>
			</div>
			<div id="divUnitNbr7" runat="server" class="UnitNbrBlock" style="margin-bottom:12px;">
				<span style="width:220px;"><asp:Label ID="lblUnitNbrLabel7" runat="server" Text="Unit Number:"></asp:Label></span>
				<span style="margin-left:20px;"><asp:Label ID="lblUnitNbrValue7" runat="server" Text=""></asp:Label></span>
			</div>
			<div id="divItemNbr7" runat="server" class="BarCodeTableDiv">
				<table class="BarCodeTable">
				<tr style="height:74px;">
					<td style="width:190px;" class="StdItemLabelPg">Item Number:<br /><span style="margin-top:6px;"><asp:Label ID="lblItemNbr7" runat="server" CssClass="ItemNbrFieldPg" ></asp:Label></span></td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;vertical-align:top;" colspan="3"><asp:Label ID="lblItemNbrBarCode7" runat="server" CssClass="StdBarCodeText"></asp:Label></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">P.O. Number:</td><td>&nbsp;</td>
					<td colspan="3" style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblPONbrBarCode7" runat="server" CssClass="StdBarCodeLabel" ></asp:Label><br /></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">Footage/Length:</td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;width:200px;vertical-align:top;"><asp:Label ID="lblFootageBarCode7" runat="server" CssClass="StdBarCodeText" ></asp:Label><br /></td>
					<td>&nbsp;</td><td style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblLengthBarCode7" runat="server"></asp:Label><br /></td>
				</tr>
				</table>
			</div>
    </div>

    <div id="divOrderItem8" runat="server" class="StdDivItemT" style="display:none;height:300px;">
			<div id="divMainTagHeader8" runat="server" class="FirstDivInSet">
				<asp:Label id="lblMainTagHeader8" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderAddress8" runat="server" class="LowerAddressBlock">
				<asp:Label id="lblTagHdrAddress8" runat="server" Text=""></asp:Label><br />
				<asp:Label id="lblTagHdrCityStZip8" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<asp:Label id="lblTagHdrCountry8" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderIdent8" runat="server" class="StdHdrIdent" style="position:absolute;">
				<table style="padding:2px;border-spacing:0px;line-height:22px;">
				<tr><td style="width:80px;">ORDER&nbsp;NO</td><td>-&nbsp;</td><td><asp:Label ID="lblOrderNbr8" runat="server" Text=""></asp:Label></td></tr>
				<tr><td style="width:80px;">SHIP&nbsp;DATE</td><td>-&nbsp;</td><td><asp:Label ID="lblShipDate8" runat="server" Text=""></asp:Label></td></tr>
				</table>
			</div>
			<div id="divUnitNbr8" runat="server" class="UnitNbrBlock" style="margin-bottom:12px;">
				<span style="width:220px;"><asp:Label ID="lblUnitNbrLabel8" runat="server" Text="Unit Number:"></asp:Label></span>
				<span style="margin-left:20px;"><asp:Label ID="lblUnitNbrValue8" runat="server" Text=""></asp:Label></span>
			</div>
			<div id="divItemNbr8" runat="server" class="BarCodeTableDiv">
				<table class="BarCodeTable">
				<tr style="height:74px;">
					<td style="width:190px;" class="StdItemLabelPg">Item Number:<br /><span style="margin-top:6px;"><asp:Label ID="lblItemNbr8" runat="server" CssClass="ItemNbrFieldPg" ></asp:Label></span></td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;vertical-align:top;" colspan="3"><asp:Label ID="lblItemNbrBarCode8" runat="server" CssClass="StdBarCodeText"></asp:Label></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">P.O. Number:</td><td>&nbsp;</td>
					<td colspan="3" style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblPONbrBarCode8" runat="server" CssClass="StdBarCodeLabel" ></asp:Label><br /></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">Footage/Length:</td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;width:200px;vertical-align:top;"><asp:Label ID="lblFootageBarCode8" runat="server" CssClass="StdBarCodeText" ></asp:Label><br /></td>
					<td>&nbsp;</td><td style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblLengthBarCode8" runat="server"></asp:Label><br /></td>
				</tr>
				</table>
			</div>
    </div>

		<div id="divOrderItem9" runat="server" class="StdDivItemB" style="display:none;">
			<div id="divMainTagHeader9" runat="server" class="FirstDivInSet">
				<asp:Label id="lblMainTagHeader9" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderAddress9" runat="server" class="LowerAddressBlock">
				<asp:Label id="lblTagHdrAddress9" runat="server" Text=""></asp:Label><br />
				<asp:Label id="lblTagHdrCityStZip9" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<asp:Label id="lblTagHdrCountry9" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderIdent9" runat="server" class="StdHdrIdent" style="position:absolute;">
				<table style="padding:2px;border-spacing:0px;line-height:22px;">
				<tr><td style="width:80px;">ORDER&nbsp;NO</td><td>-&nbsp;</td><td><asp:Label ID="lblOrderNbr9" runat="server" Text=""></asp:Label></td></tr>
				<tr><td style="width:80px;">SHIP&nbsp;DATE</td><td>-&nbsp;</td><td><asp:Label ID="lblShipDate9" runat="server" Text=""></asp:Label></td></tr>
				</table>
			</div>
			<div id="divUnitNbr9" runat="server" class="UnitNbrBlock" style="margin-bottom:12px;">
				<span style="width:220px;"><asp:Label ID="lblUnitNbrLabel9" runat="server" Text="Unit Number:"></asp:Label></span>
				<span style="margin-left:20px;"><asp:Label ID="lblUnitNbrValue9" runat="server" Text=""></asp:Label></span>
			</div>
			<div id="divItemNbr9" runat="server" class="BarCodeTableDiv">
				<table class="BarCodeTable">
				<tr style="height:74px;">
					<td style="width:190px;" class="StdItemLabelPg">Item Number:<br /><span style="margin-top:6px;"><asp:Label ID="lblItemNbr9" runat="server" CssClass="ItemNbrFieldPg" ></asp:Label></span></td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;vertical-align:top;" colspan="3"><asp:Label ID="lblItemNbrBarCode9" runat="server" CssClass="StdBarCodeText"></asp:Label></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">P.O. Number:</td><td>&nbsp;</td>
					<td colspan="3" style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblPONbrBarCode9" runat="server" CssClass="StdBarCodeLabel" ></asp:Label><br /></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">Footage/Length:</td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;width:200px;vertical-align:top;"><asp:Label ID="lblFootageBarCode9" runat="server" CssClass="StdBarCodeText" ></asp:Label><br /></td>
					<td>&nbsp;</td><td style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblLengthBarCode9" runat="server"></asp:Label><br /></td>
				</tr>
				</table>
			</div>
    </div>

    <div id="divOrderItem10" runat="server" class="StdDivItemT" style="display:none;height:300px;">
			<div id="divMainTagHeader10" runat="server" class="FirstDivInSet">
				<asp:Label id="lblMainTagHeader10" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderAddress10" runat="server" class="LowerAddressBlock">
				<asp:Label id="lblTagHdrAddress10" runat="server" Text=""></asp:Label><br />
				<asp:Label id="lblTagHdrCityStZip10" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<asp:Label id="lblTagHdrCountry10" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderIdent10" runat="server" class="StdHdrIdent" style="position:absolute;">
				<table style="padding:2px;border-spacing:0px;line-height:22px;">
				<tr><td style="width:80px;">ORDER&nbsp;NO</td><td>-&nbsp;</td><td><asp:Label ID="lblOrderNbr10" runat="server" Text=""></asp:Label></td></tr>
				<tr><td style="width:80px;">SHIP&nbsp;DATE</td><td>-&nbsp;</td><td><asp:Label ID="lblShipDate10" runat="server" Text=""></asp:Label></td></tr>
				</table>
			</div>
			<div id="divUnitNbr10" runat="server" class="UnitNbrBlock" style="margin-bottom:12px;">
				<span style="width:220px;"><asp:Label ID="lblUnitNbrLabel10" runat="server" Text="Unit Number:"></asp:Label></span>
				<span style="margin-left:20px;"><asp:Label ID="lblUnitNbrValue10" runat="server" Text=""></asp:Label></span>
			</div>
			<div id="divItemNbr10" runat="server" class="BarCodeTableDiv">
				<table class="BarCodeTable">
				<tr style="height:74px;">
					<td style="width:190px;" class="StdItemLabelPg">Item Number:<br /><span style="margin-top:6px;"><asp:Label ID="lblItemNbr10" runat="server" CssClass="ItemNbrFieldPg" ></asp:Label></span></td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;vertical-align:top;" colspan="3"><asp:Label ID="lblItemNbrBarCode10" runat="server" CssClass="StdBarCodeText"></asp:Label></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">P.O. Number:</td><td>&nbsp;</td>
					<td colspan="3" style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblPONbrBarCode10" runat="server" CssClass="StdBarCodeLabel" ></asp:Label><br /></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">Footage/Length:</td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;width:200px;vertical-align:top;"><asp:Label ID="lblFootageBarCode10" runat="server" CssClass="StdBarCodeText" ></asp:Label><br /></td>
					<td>&nbsp;</td><td style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblLengthBarCode10" runat="server"></asp:Label><br /></td>
				</tr>
				</table>
			</div>
    </div>

		<div id="divOrderItem11" runat="server" class="StdDivItemB" style="display:none;">
			<div id="divMainTagHeader11" runat="server" class="FirstDivInSet">
				<asp:Label id="lblMainTagHeader11" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderAddress11" runat="server" class="LowerAddressBlock">
				<asp:Label id="lblTagHdrAddress11" runat="server" Text=""></asp:Label><br />
				<asp:Label id="lblTagHdrCityStZip11" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<asp:Label id="lblTagHdrCountry11" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderIdent11" runat="server" class="StdHdrIdent" style="position:absolute;">
				<table style="padding:2px;border-spacing:0px;line-height:22px;">
				<tr><td style="width:80px;">ORDER&nbsp;NO</td><td>-&nbsp;</td><td><asp:Label ID="lblOrderNbr11" runat="server" Text=""></asp:Label></td></tr>
				<tr><td style="width:80px;">SHIP&nbsp;DATE</td><td>-&nbsp;</td><td><asp:Label ID="lblShipDate11" runat="server" Text=""></asp:Label></td></tr>
				</table>
			</div>
			<div id="divUnitNbr11" runat="server" class="UnitNbrBlock" style="margin-bottom:12px;">
				<span style="width:220px;"><asp:Label ID="lblUnitNbrLabel11" runat="server" Text="Unit Number:"></asp:Label></span>
				<span style="margin-left:20px;"><asp:Label ID="lblUnitNbrValue11" runat="server" Text=""></asp:Label></span>
			</div>
			<div id="divItemNbr11" runat="server" class="BarCodeTableDiv">
				<table class="BarCodeTable">
				<tr style="height:74px;">
					<td style="width:190px;" class="StdItemLabelPg">Item Number:<br /><span style="margin-top:6px;"><asp:Label ID="lblItemNbr11" runat="server" CssClass="ItemNbrFieldPg" ></asp:Label></span></td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;vertical-align:top;" colspan="3"><asp:Label ID="lblItemNbrBarCode11" runat="server" CssClass="StdBarCodeText"></asp:Label></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">P.O. Number:</td><td>&nbsp;</td>
					<td colspan="3" style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblPONbrBarCode11" runat="server" CssClass="StdBarCodeLabel" ></asp:Label><br /></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">Footage/Length:</td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;width:200px;vertical-align:top;"><asp:Label ID="lblFootageBarCode11" runat="server" CssClass="StdBarCodeText" ></asp:Label><br /></td>
					<td>&nbsp;</td><td style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblLengthBarCode11" runat="server"></asp:Label><br /></td>
				</tr>
				</table>
			</div>
    </div>

    <div id="divOrderItem12" runat="server" class="StdDivItemT" style="display:none;height:300px;">
			<div id="divMainTagHeader12" runat="server" class="FirstDivInSet">
				<asp:Label id="lblMainTagHeader12" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderAddress12" runat="server" class="LowerAddressBlock">
				<asp:Label id="lblTagHdrAddress12" runat="server" Text=""></asp:Label><br />
				<asp:Label id="lblTagHdrCityStZip12" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<asp:Label id="lblTagHdrCountry12" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderIdent12" runat="server" class="StdHdrIdent" style="position:absolute;">
				<table style="padding:2px;border-spacing:0px;line-height:22px;">
				<tr><td style="width:80px;">ORDER&nbsp;NO</td><td>-&nbsp;</td><td><asp:Label ID="lblOrderNbr12" runat="server" Text=""></asp:Label></td></tr>
				<tr><td style="width:80px;">SHIP&nbsp;DATE</td><td>-&nbsp;</td><td><asp:Label ID="lblShipDate12" runat="server" Text=""></asp:Label></td></tr>
				</table>
			</div>
			<div id="divUnitNbr12" runat="server" class="UnitNbrBlock" style="margin-bottom:12px;">
				<span style="width:220px;"><asp:Label ID="lblUnitNbrLabel12" runat="server" Text="Unit Number:"></asp:Label></span>
				<span style="margin-left:20px;"><asp:Label ID="lblUnitNbrValue12" runat="server" Text=""></asp:Label></span>
			</div>
			<div id="divItemNbr12" runat="server" class="BarCodeTableDiv">
				<table class="BarCodeTable">
				<tr style="height:74px;">
					<td style="width:190px;" class="StdItemLabelPg">Item Number:<br /><span style="margin-top:6px;"><asp:Label ID="lblItemNbr12" runat="server" CssClass="ItemNbrFieldPg" ></asp:Label></span></td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;vertical-align:top;" colspan="3"><asp:Label ID="lblItemNbrBarCode12" runat="server" CssClass="StdBarCodeText"></asp:Label></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">P.O. Number:</td><td>&nbsp;</td>
					<td colspan="3" style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblPONbrBarCode12" runat="server" CssClass="StdBarCodeLabel" ></asp:Label><br /></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">Footage/Length:</td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;width:200px;vertical-align:top;"><asp:Label ID="lblFootageBarCode12" runat="server" CssClass="StdBarCodeText" ></asp:Label><br /></td>
					<td>&nbsp;</td><td style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblLengthBarCode12" runat="server"></asp:Label><br /></td>
				</tr>
				</table>
			</div>
    </div>

		<div id="divOrderItem13" runat="server" class="StdDivItemB" style="display:none;">
			<div id="divMainTagHeader13" runat="server" class="FirstDivInSet">
				<asp:Label id="lblMainTagHeader13" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderAddress13" runat="server" class="LowerAddressBlock">
				<asp:Label id="lblTagHdrAddress13" runat="server" Text=""></asp:Label><br />
				<asp:Label id="lblTagHdrCityStZip13" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<asp:Label id="lblTagHdrCountry13" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderIdent13" runat="server" class="StdHdrIdent" style="position:absolute;">
				<table style="padding:2px;border-spacing:0px;line-height:22px;">
				<tr><td style="width:80px;">ORDER&nbsp;NO</td><td>-&nbsp;</td><td><asp:Label ID="lblOrderNbr13" runat="server" Text=""></asp:Label></td></tr>
				<tr><td style="width:80px;">SHIP&nbsp;DATE</td><td>-&nbsp;</td><td><asp:Label ID="lblShipDate13" runat="server" Text=""></asp:Label></td></tr>
				</table>
			</div>
			<div id="divUnitNbr13" runat="server" class="UnitNbrBlock" style="margin-bottom:12px;">
				<span style="width:220px;"><asp:Label ID="lblUnitNbrLabel13" runat="server" Text="Unit Number:"></asp:Label></span>
				<span style="margin-left:20px;"><asp:Label ID="lblUnitNbrValue13" runat="server" Text=""></asp:Label></span>
			</div>
			<div id="divItemNbr13" runat="server" class="BarCodeTableDiv">
				<table class="BarCodeTable">
				<tr style="height:74px;">
					<td style="width:190px;" class="StdItemLabelPg">Item Number:<br /><span style="margin-top:6px;"><asp:Label ID="lblItemNbr13" runat="server" CssClass="ItemNbrFieldPg" ></asp:Label></span></td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;vertical-align:top;" colspan="3"><asp:Label ID="lblItemNbrBarCode13" runat="server" CssClass="StdBarCodeText"></asp:Label></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">P.O. Number:</td><td>&nbsp;</td>
					<td colspan="3" style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblPONbrBarCode13" runat="server" CssClass="StdBarCodeLabel" ></asp:Label><br /></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">Footage/Length:</td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;width:200px;vertical-align:top;"><asp:Label ID="lblFootageBarCode13" runat="server" CssClass="StdBarCodeText" ></asp:Label><br /></td>
					<td>&nbsp;</td><td style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblLengthBarCode13" runat="server"></asp:Label><br /></td>
				</tr>
				</table>
			</div>
    </div>

    <div id="divOrderItem14" runat="server" class="StdDivItemT" style="display:none;height:300px;">
			<div id="divMainTagHeader14" runat="server" class="FirstDivInSet">
				<asp:Label id="lblMainTagHeader14" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderAddress14" runat="server" class="LowerAddressBlock">
				<asp:Label id="lblTagHdrAddress14" runat="server" Text=""></asp:Label><br />
				<asp:Label id="lblTagHdrCityStZip14" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<asp:Label id="lblTagHdrCountry14" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderIdent14" runat="server" class="StdHdrIdent" style="position:absolute;">
				<table style="padding:2px;border-spacing:0px;line-height:22px;">
				<tr><td style="width:80px;">ORDER&nbsp;NO</td><td>-&nbsp;</td><td><asp:Label ID="lblOrderNbr14" runat="server" Text=""></asp:Label></td></tr>
				<tr><td style="width:80px;">SHIP&nbsp;DATE</td><td>-&nbsp;</td><td><asp:Label ID="lblShipDate14" runat="server" Text=""></asp:Label></td></tr>
				</table>
			</div>
			<div id="divUnitNbr14" runat="server" class="UnitNbrBlock" style="margin-bottom:12px;">
				<span style="width:220px;"><asp:Label ID="lblUnitNbrLabel14" runat="server" Text="Unit Number:"></asp:Label></span>
				<span style="margin-left:20px;"><asp:Label ID="lblUnitNbrValue14" runat="server" Text=""></asp:Label></span>
			</div>
			<div id="divItemNbr14" runat="server" class="BarCodeTableDiv">
				<table class="BarCodeTable">
				<tr style="height:74px;">
					<td style="width:190px;" class="StdItemLabelPg">Item Number:<br /><span style="margin-top:6px;"><asp:Label ID="lblItemNbr14" runat="server" CssClass="ItemNbrFieldPg" ></asp:Label></span></td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;vertical-align:top;" colspan="3"><asp:Label ID="lblItemNbrBarCode14" runat="server" CssClass="StdBarCodeText"></asp:Label></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">P.O. Number:</td><td>&nbsp;</td>
					<td colspan="3" style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblPONbrBarCode14" runat="server" CssClass="StdBarCodeLabel" ></asp:Label><br /></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">Footage/Length:</td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;width:200px;vertical-align:top;"><asp:Label ID="lblFootageBarCode14" runat="server" CssClass="StdBarCodeText" ></asp:Label><br /></td>
					<td>&nbsp;</td><td style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblLengthBarCode14" runat="server"></asp:Label><br /></td>
				</tr>
				</table>
			</div>
    </div>

		<div id="divOrderItem15" runat="server" class="StdDivItemB" style="display:none;">
			<div id="divMainTagHeader15" runat="server" class="FirstDivInSet">
				<asp:Label id="lblMainTagHeader15" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderAddress15" runat="server" class="LowerAddressBlock">
				<asp:Label id="lblTagHdrAddress15" runat="server" Text=""></asp:Label><br />
				<asp:Label id="lblTagHdrCityStZip15" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<asp:Label id="lblTagHdrCountry15" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderIdent15" runat="server" class="StdHdrIdent" style="position:absolute;">
				<table style="padding:2px;border-spacing:0px;line-height:22px;">
				<tr><td style="width:80px;">ORDER&nbsp;NO</td><td>-&nbsp;</td><td><asp:Label ID="lblOrderNbr15" runat="server" Text=""></asp:Label></td></tr>
				<tr><td style="width:80px;">SHIP&nbsp;DATE</td><td>-&nbsp;</td><td><asp:Label ID="lblShipDate15" runat="server" Text=""></asp:Label></td></tr>
				</table>
			</div>
			<div id="divUnitNbr15" runat="server" class="UnitNbrBlock" style="margin-bottom:12px;">
				<span style="width:220px;"><asp:Label ID="lblUnitNbrLabel15" runat="server" Text="Unit Number:"></asp:Label></span>
				<span style="margin-left:20px;"><asp:Label ID="lblUnitNbrValue15" runat="server" Text=""></asp:Label></span>
			</div>
			<div id="divItemNbr15" runat="server" class="BarCodeTableDiv">
				<table class="BarCodeTable">
				<tr style="height:74px;">
					<td style="width:190px;" class="StdItemLabelPg">Item Number:<br /><span style="margin-top:6px;"><asp:Label ID="lblItemNbr15" runat="server" CssClass="ItemNbrFieldPg" ></asp:Label></span></td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;vertical-align:top;" colspan="3"><asp:Label ID="lblItemNbrBarCode15" runat="server" CssClass="StdBarCodeText"></asp:Label></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">P.O. Number:</td><td>&nbsp;</td>
					<td colspan="3" style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblPONbrBarCode15" runat="server" CssClass="StdBarCodeLabel" ></asp:Label><br /></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">Footage/Length:</td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;width:200px;vertical-align:top;"><asp:Label ID="lblFootageBarCode15" runat="server" CssClass="StdBarCodeText" ></asp:Label><br /></td>
					<td>&nbsp;</td><td style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblLengthBarCode15" runat="server"></asp:Label><br /></td>
				</tr>
				</table>
			</div>
    </div>

    <div id="divOrderItem16" runat="server" class="StdDivItemT" style="display:none;height:300px;">
			<div id="divMainTagHeader16" runat="server" class="FirstDivInSet">
				<asp:Label id="lblMainTagHeader16" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderAddress16" runat="server" class="LowerAddressBlock">
				<asp:Label id="lblTagHdrAddress16" runat="server" Text=""></asp:Label><br />
				<asp:Label id="lblTagHdrCityStZip16" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<asp:Label id="lblTagHdrCountry16" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderIdent16" runat="server" class="StdHdrIdent" style="position:absolute;">
				<table style="padding:2px;border-spacing:0px;line-height:22px;">
				<tr><td style="width:80px;">ORDER&nbsp;NO</td><td>-&nbsp;</td><td><asp:Label ID="lblOrderNbr16" runat="server" Text=""></asp:Label></td></tr>
				<tr><td style="width:80px;">SHIP&nbsp;DATE</td><td>-&nbsp;</td><td><asp:Label ID="lblShipDate16" runat="server" Text=""></asp:Label></td></tr>
				</table>
			</div>
			<div id="divUnitNbr16" runat="server" class="UnitNbrBlock" style="margin-bottom:12px;">
				<span style="width:220px;"><asp:Label ID="lblUnitNbrLabel16" runat="server" Text="Unit Number:"></asp:Label></span>
				<span style="margin-left:20px;"><asp:Label ID="lblUnitNbrValue16" runat="server" Text=""></asp:Label></span>
			</div>
			<div id="divItemNbr16" runat="server" class="BarCodeTableDiv">
				<table class="BarCodeTable">
				<tr style="height:74px;">
					<td style="width:190px;" class="StdItemLabelPg">Item Number:<br /><span style="margin-top:6px;"><asp:Label ID="lblItemNbr16" runat="server" CssClass="ItemNbrFieldPg" ></asp:Label></span></td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;vertical-align:top;" colspan="3"><asp:Label ID="lblItemNbrBarCode16" runat="server" CssClass="StdBarCodeText"></asp:Label></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">P.O. Number:</td><td>&nbsp;</td>
					<td colspan="3" style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblPONbrBarCode16" runat="server" CssClass="StdBarCodeLabel" ></asp:Label><br /></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">Footage/Length:</td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;width:200px;vertical-align:top;"><asp:Label ID="lblFootageBarCode16" runat="server" CssClass="StdBarCodeText" ></asp:Label><br /></td>
					<td>&nbsp;</td><td style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblLengthBarCode16" runat="server"></asp:Label><br /></td>
				</tr>
				</table>
			</div>
    </div>

		<div id="divOrderItem17" runat="server" class="StdDivItemB" style="display:none;">
			<div id="divMainTagHeader17" runat="server" class="FirstDivInSet">
				<asp:Label id="lblMainTagHeader17" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderAddress17" runat="server" class="LowerAddressBlock">
				<asp:Label id="lblTagHdrAddress17" runat="server" Text=""></asp:Label><br />
				<asp:Label id="lblTagHdrCityStZip17" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<asp:Label id="lblTagHdrCountry17" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderIdent17" runat="server" class="StdHdrIdent" style="position:absolute;">
				<table style="padding:2px;border-spacing:0px;line-height:22px;">
				<tr><td style="width:80px;">ORDER&nbsp;NO</td><td>-&nbsp;</td><td><asp:Label ID="lblOrderNbr17" runat="server" Text=""></asp:Label></td></tr>
				<tr><td style="width:80px;">SHIP&nbsp;DATE</td><td>-&nbsp;</td><td><asp:Label ID="lblShipDate17" runat="server" Text=""></asp:Label></td></tr>
				</table>
			</div>
			<div id="divUnitNbr17" runat="server" class="UnitNbrBlock" style="margin-bottom:12px;">
				<span style="width:220px;"><asp:Label ID="lblUnitNbrLabel17" runat="server" Text="Unit Number:"></asp:Label></span>
				<span style="margin-left:20px;"><asp:Label ID="lblUnitNbrValue17" runat="server" Text=""></asp:Label></span>
			</div>
			<div id="divItemNbr17" runat="server" class="BarCodeTableDiv">
				<table class="BarCodeTable">
				<tr style="height:74px;">
					<td style="width:190px;" class="StdItemLabelPg">Item Number:<br /><span style="margin-top:6px;"><asp:Label ID="lblItemNbr17" runat="server" CssClass="ItemNbrFieldPg" ></asp:Label></span></td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;vertical-align:top;" colspan="3"><asp:Label ID="lblItemNbrBarCode17" runat="server" CssClass="StdBarCodeText"></asp:Label></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">P.O. Number:</td><td>&nbsp;</td>
					<td colspan="3" style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblPONbrBarCode17" runat="server" CssClass="StdBarCodeLabel" ></asp:Label><br /></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">Footage/Length:</td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;width:200px;vertical-align:top;"><asp:Label ID="lblFootageBarCode17" runat="server" CssClass="StdBarCodeText" ></asp:Label><br /></td>
					<td>&nbsp;</td><td style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblLengthBarCode17" runat="server"></asp:Label><br /></td>
				</tr>
				</table>
			</div>
    </div>

    <div id="divOrderItem18" runat="server" class="StdDivItemT" style="display:none;height:300px;">
			<div id="divMainTagHeader18" runat="server" class="FirstDivInSet">
				<asp:Label id="lblMainTagHeader18" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderAddress18" runat="server" class="LowerAddressBlock">
				<asp:Label id="lblTagHdrAddress18" runat="server" Text=""></asp:Label><br />
				<asp:Label id="lblTagHdrCityStZip18" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<asp:Label id="lblTagHdrCountry18" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderIdent18" runat="server" class="StdHdrIdent" style="position:absolute;">
				<table style="padding:2px;border-spacing:0px;line-height:22px;">
				<tr><td style="width:80px;">ORDER&nbsp;NO</td><td>-&nbsp;</td><td><asp:Label ID="lblOrderNbr18" runat="server" Text=""></asp:Label></td></tr>
				<tr><td style="width:80px;">SHIP&nbsp;DATE</td><td>-&nbsp;</td><td><asp:Label ID="lblShipDate18" runat="server" Text=""></asp:Label></td></tr>
				</table>
			</div>
			<div id="divUnitNbr18" runat="server" class="UnitNbrBlock" style="margin-bottom:12px;">
				<span style="width:220px;"><asp:Label ID="lblUnitNbrLabel18" runat="server" Text="Unit Number:"></asp:Label></span>
				<span style="margin-left:20px;"><asp:Label ID="lblUnitNbrValue18" runat="server" Text=""></asp:Label></span>
			</div>
			<div id="divItemNbr18" runat="server" class="BarCodeTableDiv">
				<table class="BarCodeTable">
				<tr style="height:74px;">
					<td style="width:190px;" class="StdItemLabelPg">Item Number:<br /><span style="margin-top:6px;"><asp:Label ID="lblItemNbr18" runat="server" CssClass="ItemNbrFieldPg" ></asp:Label></span></td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;vertical-align:top;" colspan="3"><asp:Label ID="lblItemNbrBarCode18" runat="server" CssClass="StdBarCodeText"></asp:Label></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">P.O. Number:</td><td>&nbsp;</td>
					<td colspan="3" style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblPONbrBarCode18" runat="server" CssClass="StdBarCodeLabel" ></asp:Label><br /></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">Footage/Length:</td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;width:200px;vertical-align:top;"><asp:Label ID="lblFootageBarCode18" runat="server" CssClass="StdBarCodeText" ></asp:Label><br /></td>
					<td>&nbsp;</td><td style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblLengthBarCode18" runat="server"></asp:Label><br /></td>
				</tr>
				</table>
			</div>
    </div>

		<div id="divOrderItem19" runat="server" class="StdDivItemLast" style="display:none;">
			<div id="divMainTagHeader19" runat="server" class="FirstDivInSet">
				<asp:Label id="lblMainTagHeader19" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderAddress19" runat="server" class="LowerAddressBlock">
				<asp:Label id="lblTagHdrAddress19" runat="server" Text=""></asp:Label><br />
				<asp:Label id="lblTagHdrCityStZip19" runat="server" Text=""></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<asp:Label id="lblTagHdrCountry19" runat="server" Text=""></asp:Label>
			</div>
			<div id="divMainTagHeaderIdent19" runat="server" class="StdHdrIdent" style="position:absolute;">
				<table style="padding:2px;border-spacing:0px;line-height:22px;">
				<tr><td style="width:80px;">ORDER&nbsp;NO</td><td>-&nbsp;</td><td><asp:Label ID="lblOrderNbr19" runat="server" Text=""></asp:Label></td></tr>
				<tr><td style="width:80px;">SHIP&nbsp;DATE</td><td>-&nbsp;</td><td><asp:Label ID="lblShipDate19" runat="server" Text=""></asp:Label></td></tr>
				</table>
			</div>
			<div id="divUnitNbr19" runat="server" class="UnitNbrBlock" style="margin-bottom:12px;">
				<span style="width:220px;"><asp:Label ID="lblUnitNbrLabel19" runat="server" Text="Unit Number:"></asp:Label></span>
				<span style="margin-left:20px;"><asp:Label ID="lblUnitNbrValue19" runat="server" Text=""></asp:Label></span>
			</div>
			<div id="divItemNbr19" runat="server" class="BarCodeTableDiv">
				<table class="BarCodeTable">
				<tr style="height:74px;">
					<td style="width:190px;" class="StdItemLabelPg">Item Number:<br /><span style="margin-top:6px;"><asp:Label ID="lblItemNbr19" runat="server" CssClass="ItemNbrFieldPg" ></asp:Label></span></td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;vertical-align:top;" colspan="3"><asp:Label ID="lblItemNbrBarCode19" runat="server" CssClass="StdBarCodeText"></asp:Label></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">P.O. Number:</td><td>&nbsp;</td>
					<td colspan="3" style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblPONbrBarCode19" runat="server" CssClass="StdBarCodeLabel" ></asp:Label><br /></td>
				</tr>
				<tr style="height:60px;">
					<td style="width:190px;" class="StdItemLabelPg">Footage/Length:</td><td>&nbsp;</td>
					<td style="white-space:nowrap;text-align:left;width:200px;vertical-align:top;"><asp:Label ID="lblFootageBarCode19" runat="server" CssClass="StdBarCodeText" ></asp:Label><br /></td>
					<td>&nbsp;</td><td style="white-space:nowrap;text-align:left;vertical-align:top;"><asp:Label ID="lblLengthBarCode19" runat="server"></asp:Label><br /></td>
				</tr>
				</table>
			</div>
    </div>

		<div id="divErrorMsg" style="width:100%;display:none;" runat="server">
			<asp:Label ID="lblErrorMsg"	style="color:maroon;font-weight:bold;font-size:12pt;" runat="server"></asp:Label>
		</div>

	</div>
  </form>
</body>
</html>
