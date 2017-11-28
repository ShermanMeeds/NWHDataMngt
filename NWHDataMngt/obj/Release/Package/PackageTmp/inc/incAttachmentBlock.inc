<script type="text/javascript">
  var MyAttachmentList;

  function getItemAttachmentList() {
  jsErrorMsg = '';
  var url = "../Shared/ApprovalServices.asmx/getAttachmentListPaged";
  var MyData = "{'ApproveID':'" + jiApprovalID.toString() + "','PgNbr':'" + jiPgNbrPj2.toString() + "','PgSize':'" + jiPgSizePj.toString() + "','ByID':'" + jiByID.toString() + "'}";
  //alert(MyData);
  getJSONReturnDataUt(url, MyData, function (response)
  { MyAttachmentList = response; populateAttachmentList(); });
  return false;
  }

  // requires that MyOrderAttachments be dim'd already
  function populateAttachmentList() {
  joDivLoadStatus2.style.display = 'none';
  var val = '';
  var NbrCols = 9;
  prepareColDataArrayDg(NbrCols);
  //COLS: Doc ID, Source, Source Name, File Name, File Size, File Type, Content Type, Submitted On, Action
  //FillOneColArrayDataTDg(nCol, datacol, hOrient, vOrient, fmt, vis, hdrTxt, hdrBld, hdrbColor, hdrfColor, defVal, blankVal, lnkV1CNm, lnkV2CNm, lnkV3CNm, radGrpName, chkval1, t2, t3, t4, t5, contenttype)
  //FillOneColArrayDataNDg(nCol, wdth, typ, iCast, hlt, tgt, agg, iSort, iFilter, iVanish, hdrCSpan, hdrRSpan, iGroup, iWdthFixed, iPadDiv, iEdit, hl, iBoldset, isHl, showToolTipVal, x1, x2, x3, x4, x5, x6) {
  FillOneColArrayDataTDg(0, 'DocID', 'center', 'middle', '', '', '', null, '', '', '', '', '', '', '', '', '', '', '', '', '', 'd');
  FillOneColArrayDataNDg(0, 56, 2, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 3, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0);
  FillOneColArrayDataTDg(1, 'Source', 'center', 'middle', '', '', '', null, '', '', '', '', '', '', '', '', '', '', '', '', '', 'd');
  FillOneColArrayDataNDg(1, 70, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
  FillOneColArrayDataTDg(2, 'SourceName', 'left', 'middle', '', '', '', null, '', '', '', '', '', '', '', '', '', '', '', '', '', 'd');
  FillOneColArrayDataNDg(2, 140, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
  FillOneColArrayDataTDg(3, 'FileName', 'left', 'middle', '', '', '', null, '', '', '', '', '', '', '', '', '', '', '', '', '', 'd');
  FillOneColArrayDataNDg(3, 400, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
  FillOneColArrayDataTDg(4, 'FileSize', 'right', 'middle', '', '', '', null, '', '', '', '', '', '', '', '', '', '', '', '', '', 'd');
  FillOneColArrayDataNDg(4, 70, 3, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
  FillOneColArrayDataTDg(5, 'FileType', 'center', 'middle', '', '', '', null, '', '', '', '', '', '', '', '', '', '', '', '', '', 'd');
  FillOneColArrayDataNDg(5, 62, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
  FillOneColArrayDataTDg(6, 'ContentTypeDes', 'left', 'middle', '', '', '', null, '', '', '', '', '', '', '', '', '', '', '', '', '', 'd');
  FillOneColArrayDataNDg(6, 110, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
  FillOneColArrayDataTDg(7, 'sSubmittedOn', 'center', 'middle', '', '', '', null, '', '', '', '', '', '', '', '', '', '', '', '', '', 'd');
  FillOneColArrayDataNDg(7, 100, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
  FillOneColArrayDataTDg(8, '', 'center', 'middle', '', '', '', null, '', '', '', '', '', '', '', '', '', '', '', '', '', 't');
  FillOneColArrayDataNDg(8, 74, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

  setGridFormattingDg('#111111', '#000000', '#000000', null, '#FFFFFF', '#DDDDDD', '#DDDDDD', null, 'red', '17px', '16px', '10pt', false, '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', '2px', '2px', '0px', '0px', '0px', '', '', '', '', '0px', '', '', true, false, '0', '0', '#B0B0B0', '#CCCCCC', '#555555', false, false, false, false, false);
  sResult = FormDataGridDg(joTblAttachmentList, 'ALRC', true, '1px solid gray', false, false, 'Totals', NbrCols, MyAttachmentList, 'hidden', 9, 0, 0, 'DocID', 0, 0, 0, 0, false, false, '', true, false, 0, 2);
  if (sResult.substr(0, 4) !== 'Okay') {
  joDivLoadStatus2.style.display = 'block';
  joLblStatusMsg2.innerHTML = sResult;
  }
  return false;
  }

  // show attachment body as popup
  function ViewAttachment(docid, row) {
  window.open('ViewAttachment.aspx?d=' + docid, 'Attachment', 'height=500,width=775,left=150,top=150,location=no,menubar=no,resizable=no, scrollbars=yes, titlebar=yes, toolbar=no', true);
  return false;
  }

</script>

<!----------------------------------------- ATTACHMENTS ------------------------------------------------->
<div id="divAttachmentList" style="display:block;width:100%;text-align:left;padding:0px;border-spacing:0px;margin-top:10px;">
	<table style="width:93%;">
		<tr>
			<td style="padding:0px;width:40%;text-align:left;">
				&nbsp;<span id="lblAttachmentHdr" class="MyHeaderLabel" style="color:blue;">Order Attachment Data:</span>&nbsp;&nbsp;&nbsp;
			</td>
			<td style="padding:0px;width:60%;text-align:right;margin-right:50px;">
				&nbsp;Page&nbsp;Size:&nbsp;<select id="selPageSize2" onchange="javascript:ChangePgSizePj2(this[this.selectedIndex].value);return false;" style="font-size:10pt;font-family:Calibri;">
					<option value="10">10 Rows</option>
					<option value="20" selected="selected">20 Rows</option>
					<option value="30">30 Rows</option>
					<option value="40">40 Rows</option>
					<option value="50">50 Rows</option>
					<option value="100">100 Rows</option>
				</select>&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
	</table>

	<!-- ColWidths=[56, 70, 140, 400, 70, 62, 110, 100, 74]-->
			<table id="tblAttachmentList" style="border:1px solid gray;padding:1px;border-spacing:0px;border-collapse:collapse;margin-top:4px;">
			<thead>
			<tr>
				<th class="TableHdrCellSub" style="width:56px;">
					Doc ID
				</th>
				<th class="TableHdrCellSub" style="width:70px;">
					Source
				</th>
				<th class="TableHdrCellSub" style="width:140px;">
					Source Name
				</th>
				<th class="TableHdrCellSub" style="width:400px;">
					File Name
				</th>
				<th class="TableHdrCellSub" style="width:70px;">
					File Size
				</th>
				<th class="TableHdrCellSub" style="width:62px;">
					File Type
				</th>
				<th class="TableHdrCellSub" style="width:110px;">
					Content Type
				</th>
				<th class="TableHdrCellSub" style="width:100px;">
					Submitted On
				</th>
				<th class="TableHdrCellSub" style="width:74px;">
					Action
				</th>
			</tr>
			</thead>
			<tbody>
			</tbody>
			</table>
</div>

<div id="divAttachLoadStatus2" style="width:100%;display:none;margin-top:4px;margin-left:4px;">
	<label id="lblAttachStatusMsg2" style="color:maroon;font-weight:bold;"></label>
</div>

