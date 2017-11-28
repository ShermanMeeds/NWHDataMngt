/* DataGrids.js - dated 6/5/2015 last updated by S. Meeds 
-- Requires TxtUtilitiess, GenUtilities, WebControls
--Code checked 5/28/2015
Contents:
  prepareColDataArrayDg(nbrcols)
  fillColDataArrayDg(itm, col, arr)
  fillColDataArrayAllDg(nCol, arrN0, arrN1, arrN2, arrN3, arrN4, arrN5, arrT0, arrT1, arrT2, arrT3, arrT4, arrT5)
  FillOneColArrayDataDg(nCol, wdth, typ, iCast, hlt, tgt, agg, colmap, hOrient, vOrient, fmt, vis, s5)
  FillOneColArrayDataNDg(nCol, wdth, typ, iCast, hlt, tgt, agg, iSort, iFilter, iVanish, hdrCSpan, hdrRSpan, iGroup, iWdthFixed, iPadDiv, iEdit, hl, iBoldset, isHl, showToolTipVal, x1, x2, x3, x4, x5, x6)
  FillOneColArrayDataTDg(nCol, datacol, hOrient, vOrient, fmt, vis, hdrTxt, hdrBld, hdrbColor, hdrfColor, defVal, blankVal, lnkV1CNm, lnkV2CNm, lnkV3CNm, radGrpName, chkval1, t2, t3, t4, t5, contenttype)
  FillOneColArrayDataMCNDg(nCol, nRow, wdth, typ, iCast, hlt, tgt, agg, iSort, iFilter, iVanish, hdrCSpan, hdrRSpan, iGroup, iWdthFixed, iPadDiv, iEdit, hl, iBoldset, rowspn, isHl, x2, x3, x4, x5, x6, x7)
  FillOneColArrayDataMCTDg(nCol, nRow, datacol, hOrient, vOrient, fmt, vis, hdrTxt, hdrBld, hdrbColor, hdrfColor, defVal, blankVal, lnkV1CNm, lnkV2CNm, lnkV3CNm, radGrpName, chkval1, t2, t3, t4, t5, contenttype)
  FillOneGroupArrayDataDg(nGroup, GrpName, bColor, fColor, bld, hOrient, lnHt, brdrPx, brdrColor, LRPad, TBPad, t10)
  setGridFormattingDg(fColor, fColorH, fColorF, fColorP, bColor, bColorH, bColorF, bColorP, hiltColor, lnHt, clHt, fsiz, bld, brdrL, brdrR, brdrT, brdrB, cpadL, cpadR, cpadT, cpadB, sPad, marL, marR, marT, marB, bSpace, sepBrdr, tblClass, hasHdr, hasFooter, boldsetH, boldsetF, AltBackColor, PgnBColor, PgnFColor, ShowDragIcon, ClickCol)
  FormDataGridHdrDg(parentobj, tblname, prfx, NbrCol, NbrHRows, oh, ov, bgclr, frclr, brdr, pdL, pdR, pdT, pdB, cellclassnm, objid)
  setHdrLine2Dg(nCols, colTxt, colWdth)
  FillGridFooterDataDg(nCol, txt, bld, bColor, fColor, AggType, t5)
  FormDataGridDg(parentObj, cellprfx, altRowA, brdr, showtotalC, showrownm, AggLabel, NbrCols, colData, ovrflw, vwCol, EdtCol, DelCol, idCol, iPadDiv, addParamBar, bEdit, UsePagBar, 0, objid)
	IdentifyTargetRowDg(row, lastrow, objid)
  FormDataGridMultiRowDg(parentObj, cellprfx, altRowA, brdr, showtotalC, showrownm, AggLabel, NbrCols, NbrRowsEA, colData, colData2, colData3, ovrflw, vwCol, EdtCol, DelCol, idCol, vwColRw, EdtColRw, DelColRw, idColRw, lnk1Col, lnk2Col, lnk3Col, iPadDiv, addParamBar, bEdit, cellClass, IsLocked, objid)
	IdentifyTargetMRowDg(row, lastrow, objid)
  GetPaginationFooterBarDg(nCol, msg, ht, wdth, bColor, tColor, msg, objid)
	createBasicCellDg(prefx, ht, wdth, bColor, tColor, txtorient, lpad, rpad, tpad, bpad, objid)
  validateDataSourceDg(dataSrc, nCol, idCol, vwCol, EdtCol, DelCol)
  FormGridSeperatorLineDg(nCol, row, ExPref, objid, Content, rHt, bColor, fColor, brdr, hOrient)
  setStringFormatDg(dat, typ)
  createObjIDDg(pref, rw, col)
  createNewCellDg(id, ht, wdth, content, bkColor, frColor, brdr, hAlign, vAlign, padl, padr, padt, padb, fontSz, IsBold, ovrflw, RdOnly, dsabld, IsVisible, colspn, disp, noWrap)
  createHdrCellDg(id, content, clspan, classnm, txtalign, valign, cellwidth, bgcolor, brdr, padL, padR, padT, padB, sBold, disp)
  getNewRowDg(rowID, rowNbr, lnheight)
  getNewTextBoxDg(rowNbr, colNbr, DayNoT, prefix, hght, wdth, IsReadOnly, IsVisible, content, bColor, TSStatus, TaskID, TOGuid, VEmpID, StartDt, TEDate, CanEditDesc, txtHAlign, txtVAlign, RoleID, EntryID)
  getNewCheckBoxDg(rowNbr, colNbr, DayNoT, prefix, IsReadOnly, IsVisible, IsChecked, bColor, TEmpID, VEmpID, TEDate)
  getNewDivObjectDg(rowNbr, colNbr, prefix, hght, wdth, content, bColor)
  getParamDataArrayDg(nbrCols, objid)
  createCalendarGridDg(parentObj, firstDate, altRowA, tblBrdr, tblspc, tblMargin, tblClass, clprfx, clBrdr, clClass, clBColor, clFColor, calData, hdBrdr, hdBColor, hdFColor, dtBColor, dtFColor, iPad, tWidth, tMinHt, hltToday, showWeekend, showOutDates, showTlTp, noOverflw)	
  createCalendarCellDg(row, tcell, prefx, suffx, colspn, showOutDates, brdrL, brdrR, brdrT, brdrB, bColor, fColor, isBold, noOverflw, ht, wdth, content, ttip)
  createBlockArrayDg(bHdr, bFtr, iMargin, iPad, iCols, iRows, cWdth, cHt, cbColor, cfColor, cBrdr, cfSize, cFont, cArray, cHOrient, cVOrient, ctipArray, hArray, ifCol, fArray)
  jsfNumberFormatDg(number, decimals, dec_point, thousands_sep)
	FormDataGridRowMinimumDg(objid, nCol, rowid, idprefix, cellclass, hasEdit, hasDel, hasView, btnClass, dt, idfldname, colnames, wdth, horient, vorient, brdrL, brdrR, brdrT, brdrB, Fmt)
	FormDataGridBodyMinimumDg(objid, nCol, idprefix, cellclass, hasEdit, hasDel, hasView, btnClass, showAggs, aggprec, dt, idfldname, colnames, coltype, wdth, horient, vorient, brdrL, brdrR, brdrT, brdrB, aggType, pg, wrp)
	EmptyDDLListsDg()
*/
var jsDGVersion = '1.3.0';
var jsDGVersDate = '7/15/2017';

var jgHighlightColor = '#FFFFAA';
var jsDGbShowClickCol = false;
var jsDGbShowDragIcon = false;
var jsDGbShowEditRow = false;
var jsDGbShowRowSel = false;
var jsDGAnalyzeAggCols;
var jsDGAnalyzeAggColsV;
var jsDGbgColor = '#FFFFFF';
var jsDGbgFtrColor = '#FFFFFF';
var jsDGbgHdrColor = '#FFFFFF';
var jsDGbgPrmColor = '#CCCCCC';
var jsDGbHasFooter = false;
var jsDGbrdrB = '';
var jsDGbrdrL = '';
var jsDGbrdrR = '';
var jsDGbrdrSpace = '';
var jsDGbrdrT = '';
var jsDGCellHt = '18px';
var jsDGCellHtHdr = '18px';
var jsDGCellHtFtr = '18px';
var jsDGCellPadB = '';
var jsDGCellPadL = '';
var jsDGCellPadR = '';
var jsDGCellPadT = '';
var jsDGErrorList = '';
var jsDGFontSz = '10pt';
var jsDGFontSzHdr = '10pt';
var jsDGFontSzFtr = '10pt';
var jsDGFontBold = '';
var jsDGforeColor = '#000000';
var jsDGforeHdrColor = '#000000';
var jsDGforeFtrColor = '#000000';
var jsDGforePrmColor = '#000000';
var jsDGHdrBoldSet = 0;
var jsDGFtrBoldSet = 0;
var jsDGHighlightColor = 'red';
var jsDGHRow1Width;
var jsDGHRow2Width;
var jsDGHRow1CSpan;
var jsDGHRow2CSpan;
var jsDGLineHt = '16px';
var jsDGMarginBottom = '0px';
var jsDGMarginLeft = '0px';
var jsDGMarginRight = '0px';
var jsDGMarginTop = '0px';
var jsDGPgnBColor = '#AAAAAA';
var jsDGPgnTColor = '#555555';
var jsDGRow1bgColor;
var jsDGRow1frColor;
var jsDGRow1OrientH;
var jsDGRow1OrientV;
var jsDGRow2bgColor;
var jsDGRow2frColor;
var jsDGRow2OrientH;
var jsDGRow2OrientV;
var jsDGSepBorder = false;
var jsDGTblClassName = '';
var jsDGTblPad = '';
var jsDGTglColor = '#E8E8E8';
var jsDGNbrDimsMCN = 26;
var jsDGNbrDimsMCT = 22;
var jsDGNbrDimsN = 26;
var jsDGNbrDimsT = 22;
var jsDGNbrDimsF = 5;
var jsDGColDataMCN = createDimension3ArrayGu(100, jsDGNbrDimsMCN, 3, 0);
var jsDGColDataMCT = createDimension3ArrayGu(100, jsDGNbrDimsMCT, 3, 0);
var jsDGColDataN = MultiDimensionalArrayGu(100, jsDGNbrDimsN);
var jsDGColDataT = MultiDimensionalArrayGu(100, jsDGNbrDimsT);
var jsDGColFtrData = MultiDimensionalArrayGu(100, jsDGNbrDimsF);
var jsDGColDDLOpts = MultiDimensionalArrayGu(40, 20);
var jsDGDayNames = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
var jsDGGroupData = MultiDimensionalArrayGu(3, 10);
var jsDGGroups = [0, 0, 0];
var jsDGParamData = createArrayGu(100);
var jsDGHdr2Text = createArrayGu(50);
var jsDGHdr2Wdth = createArrayGu(50);
var jsDGHdr2Col = 0;

// updated: 12/16/2014
// create background column info arrays and initiate them with 0's or empty strings - arrays 0-based
function prepareColDataArrayDg(nbrcols) {
	for (var col = 0; col < nbrcols; col++) {
		for (var itm = 0; itm <= jsDGNbrDimsN; itm++) {
			jsDGColDataN[col][itm] = 0;
		}
		for (var itm2 = 0; itm2 <= jsDGNbrDimsT; itm2++) {
			jsDGColDataT[col][itm2] = '';
		}
	}
}

//N = 0:width, 1:type, 2:Cast, 3:Hlt, 4:Tgt, 5:Agg
//S = 0:Map, 1:OrientH, 2-OrientV, 3:Fmt, 4:Vis, 5-Default
function fillColDataArrayDg(itm, col, arr) {
	for (var row = 0; row < arr.length; row++) {
		if (itm.toLowerCase() === 'n') {
			jsDGColDataN[row][col] = arr[row];
		}
		else {
			jsDGColDataT[row][col] = arr[row].toString();
		}
	}
}

//FillOneColArrayData(ColWidth, typeCol, iCast, highlightAction, targetValue, aggType, columnName, hOrient, vOrient, specformat, visible, s5 - unused);
function fillColDataArrayAllDg(nCol, arrN0, arrN1, arrN2, arrN3, arrN4, arrN5, arrT0, arrT1, arrT2, arrT3, arrT4, arrT5) {
	var n0 = (arrN0 === null) ? false : true;
	var n1 = (arrN1 === null) ? false : true;
	var n2 = (arrN2 === null) ? false : true;
	var n3 = (arrN3 === null) ? false : true;
	var n4 = (arrN4 === null) ? false : true;
	var n5 = (arrN5 === null) ? false : true;
	var t0 = (arrT0 === null) ? false : true;
	var t1 = (arrT1 === null) ? false : true;
	var t2 = (arrT2 === null) ? false : true;
	var t3 = (arrT3 === null) ? false : true;
	var t4 = (arrT4 === null) ? false : true;
	var t5 = (arrT5 === null) ? false : true;
	for (var row = 0; row < nCol; row++) {
		if (n0) { jsDGColDataN[row][0] = arrN0[row]; } // col widths
		if (n1) { jsDGColDataN[row][1] = arrN1[row]; } //0-text, 1-textCODE, 2-int, 3-numeric, 4-money, 5-bool, 6-date, 7-datetime, 8-time, 9-email, 10-phonenbr
		if (n2) { jsDGColDataN[row][2] = arrN2[row]; } // casts
		if (n3) { jsDGColDataN[row][3] = arrN3[row]; } //0-none, 1-below, 2-equal/below, 3-equal, 4-above/equal, 5-above
		if (n4) { jsDGColDataN[row][4] = arrN4[row]; } // tgt value for n3 action
		if (n5) { jsDGColDataN[row][5] = arrN5[row]; } // agg setting: 0-none, 1-count, 2-sum, 3-average, 4-High Value, 5-Low Value, 11-count ignore 0 or empty, 13-average ignore 0 or empty
		if (t0) { jsDGColDataT[row][0] = arrT0[row]; } // col mapping: Column Name
		if (t1) { jsDGColDataT[row][1] = arrT1[row]; } // colOrientH: center, left, right
		if (t2) { jsDGColDataT[row][2] = arrT2[row]; } // colOrientV: middle top, bottom
		if (t3) { jsDGColDataT[row][3] = arrT3[row]; } //fmt: bold, bc#000000, fc#000000, disabled, readonly
		if (t4) { jsDGColDataT[row][4] = arrT4[row]; } //vis: '', hidden
		if (t5) { jsDGColDataT[row][5] = arrT5[row]; }
	}
}

//n: 0-col, 1-wdth, 2-typ, 3-iCast, 4-hlt, 5-tgt, 6-agg, 7-iSort, 8-iFilter, 9-iVanish, 10-hdrCSpan, 11-hdrRSpan, 12-iGroup, 13-iWdthFixed, 14-iPadDiv, 15-iEdit, 16-hl, 17-iBoldset, 18-isHl, 19-showToolTipVal, 20-x1, 21-x2, 22-x3, 23-x4, 24-x5, 25-x6
function FillOneColArrayDataNDg(nCol, wdth, typ, iCast, hlt, tgt, agg, iSort, iFilter, iVanish, hdrCSpan, hdrRSpan, iGroup, iWdthFixed, iPadDiv, iEdit, hl, iBoldset, showToolTipVal, SupressDups, CleanStr, Disp, x3, x4, x5, x6) {
	if (wdth === null) { wdth = 0; } // col widths INT
	if (typ === null) { typ = 0; } //0-text, 1-textCODE, 2-int, 3-numeric, 4-money, 5-bool, 6-date, 7-datetime, 8-time, 9-email, 10-phonenbr
	if (iCast === null) { iCast = 0; } // casts
	if (hlt === null) { hlt = 0; } //0-none, 1-below, 2-equal/below, 3-equal, 4-above/equal, 5-above
	if (tgt === null) { tgt = ''; } // tgt value for n3 action
	if (agg === null) { agg = 0; } // agg setting: 0-none, 1-Count, 2-Sum, 3-Average, 4-High Value, 5-Low Value
	if (iSort === null) { iSort = 0; } // 
	if (iFilter === null) { iFilter = 0; } // 
	if (iVanish === null) { iVanish = 0; } // 
	if (hdrCSpan === null) { hdrCSpan = 0; } // 
	if (hdrRSpan === null) { hdrRSpan = 0; } // 
	if (iGroup === null) { iGroup = 0; } // 
	if (iWdthFixed === null) { iWdthFixed = 0; } // 
	if (iPadDiv === null) { iPadDiv = 0; } // col header text
	if (iEdit === null) { iEdit = 0; } // col edittype 1-edit optional value, 2-edit required value
	if (hl === null) { hl = 0; } // 
	if (iBoldset === null) { iBoldset = 0; } // 
	if (isHl === null) { isHl = 0; } // 
	if (showToolTipVal === null) { showToolTipVal = 0; } // 
	if (CleanStr === null) { CleanStr = 0; } // 
	if (SupressDups === null) { SupressDups = 0; } // 
	if (Disp === null) { Disp = 0; } // 
	if (x3 === null) { x3 = 0; } // 
	if (x4 === null) { x4 = 0; } // 
	if (x5 === null) { x5 = 0; } // 
	if (x6 === null) { x6 = 0; } // 

	if (nCol < 100) {
		jsDGColDataN[nCol][0] = wdth;
		jsDGColDataN[nCol][1] = typ;
		jsDGColDataN[nCol][2] = iCast;
		jsDGColDataN[nCol][3] = hlt;
		jsDGColDataN[nCol][4] = tgt;
		jsDGColDataN[nCol][5] = agg;
		jsDGColDataN[nCol][6] = iSort;
		jsDGColDataN[nCol][7] = iFilter;
		jsDGColDataN[nCol][8] = iVanish;
		jsDGColDataN[nCol][9] = hdrCSpan;
		jsDGColDataN[nCol][10] = hdrRSpan;
		jsDGColDataN[nCol][11] = iGroup;
		jsDGColDataN[nCol][12] = iWdthFixed;
		jsDGColDataN[nCol][13] = iPadDiv;
		jsDGColDataN[nCol][14] = iEdit;
		jsDGColDataN[nCol][15] = hl;
		jsDGColDataN[nCol][16] = iBoldset;
		jsDGColDataN[nCol][17] = SupressDups;
		jsDGColDataN[nCol][18] = showToolTipVal;
		jsDGColDataN[nCol][19] = CleanStr;
		jsDGColDataN[nCol][20] = Disp;
		jsDGColDataN[nCol][21] = x3;
		jsDGColDataN[nCol][22] = x4;
		jsDGColDataN[nCol][23] = x5;
		jsDGColDataN[nCol][24] = x6;
		return true;
	}
	else {
		return false;
	}
}

//t: 0-nCol, 1-datacol, 2-hOrient, 3-vOrient, 4-fmt, 5-vis, 6-hdrTxt, 7-hdrBld, 8-hdrbColor, 9-hdrfColor, 10-defVal, 11-blankVal, 12-lnkV1CNm, 13-lnkV2CNm, 14-lnkV3CNm, 15-radGrpName, 16-chkval1, 17-t2, 18-t3, 19-t4, 20-t5, 21-contenttype
function FillOneColArrayDataTDg(nCol, datacol, hOrient, vOrient, fmt, vis, hdrTxt, hdrBld, hdrbColor, hdrfColor, defVal, blankVal, lnkV1CNm, lnkV2CNm, lnkV3CNm, radGrpName, chkval1, t2, t3, t4, t5, contenttype) {
	//contenttype: 'd'-datacolumn, 't'-text (usually as link text)
	if (datacol === null) { datacol = ''; } // col name
	if (hOrient === null) { hOrient = ''; } // col horizontal orientation
	if (vOrient === null) { vOrient = ''; } // col vertical orientation
	if (fmt === null) { fmt = ''; } // col special formatting
	if (vis === null) { vis = ''; } // col visible 
	if (hdrTxt === null) { hdrTxt = ''; } // col header text
	if (hdrBld === null) { hdrBld = ''; } // col header text
	if (hdrbColor === null) { hdrbColor = ''; } // col header back color
	if (hdrfColor === null) { hdrfColor = ''; } // col header text color
	if (defVal === null) { defVal = ''; } // 
	if (blankVal === null) { blankVal = ''; } // col header text
	if (radGrpName === null) { radGrpName = ''; }
	if (contenttype === null) { contenttype = 'd'; }
	if (chkval1 === null) { chkval1 = ''; }
	if (lnkV1CNm === null) { lnkV1CNm = ''; }
	if (lnkV2CNm === null) { lnkV2CNm = ''; }
	if (lnkV3CNm === null) { lnkV3CNm = ''; }
	if (t2 === null) { t2 = ''; }
	if (t3 === null) { t3 = ''; }
	if (t4 === null) { t4 = ''; }
	if (t5 === null) { t5 = ''; }

	hOrient = hOrient.replace(';', '');
	vOrient = vOrient.replace(';', '');
	hdrbColor = hdrbColor.replace(';', '');
	hdrfColor = hdrfColor.replace(';', '');

	if (nCol < 100) {
		jsDGColDataT[nCol][0] = datacol; // col mapping
		jsDGColDataT[nCol][1] = hOrient; // colOrientH: center, left, right
		jsDGColDataT[nCol][2] = vOrient; // colOrientV: middle top, bottom
		jsDGColDataT[nCol][3] = fmt; //fmt: bold, bc#000000, fc#000000, disabled, readonly
		jsDGColDataT[nCol][4] = vis; //vis: '', hidden
		jsDGColDataT[nCol][5] = hdrTxt;
		jsDGColDataT[nCol][6] = hdrBld;
		jsDGColDataT[nCol][7] = hdrbColor;
		jsDGColDataT[nCol][8] = hdrfColor;
		jsDGColDataT[nCol][9] = defVal;
		jsDGColDataT[nCol][10] = blankVal;
		jsDGColDataT[nCol][11] = lnkV1CNm;
		jsDGColDataT[nCol][12] = lnkV2CNm;
		jsDGColDataT[nCol][13] = lnkV3CNm;
		jsDGColDataT[nCol][14] = radGrpName;
		jsDGColDataT[nCol][15] = chkval1;
		jsDGColDataT[nCol][16] = t2;
		jsDGColDataT[nCol][17] = t3;
		jsDGColDataT[nCol][18] = t4;
		jsDGColDataT[nCol][19] = t5;
		jsDGColDataT[nCol][20] = contenttype;
		return true;
	}
	else {
		return false;
	}
}

function FillOneColArrayDataMCNDg(nCol, nRow, wdth, typ, iCast, hlt, tgt, agg, iSort, iFilter, iVanish, hdrCSpan, hdrRSpan, iGroup, iWdthFixed, iPadDiv, iEdit, hl, iBoldset, rowspn, isHl, showToolTipVal, SupressDups, CleanStr, x5, x6, x7) {
	if (wdth === null) { wdth = 0; } // col widths INT
	if (typ === null) { typ = 0; } //0-text, 1-textCODE, 2-int, 3-numeric, 4-money, 5-bool, 6-date, 7-datetime, 8-time, 9-email, 10-phonenbr
	if (iCast === null) { iCast = 0; } // casts
	if (hlt === null) { hlt = 0; } //0-none, 1-below, 2-equal/below, 3-equal, 4-above/equal, 5-above
	if (tgt === null) { tgt = ''; } // tgt value for n3 action
	if (agg === null) { agg = 0; } // agg setting: 0-none, 1-Count, 2-Sum, 3-Average, 4-High Value, 5-Low Value
	if (iSort === null) { iSort = 0; } // 
	if (iFilter === null) { iFilter = 0; } // 
	if (iVanish === null) { iVanish = 0; } // 
	if (hdrCSpan === null) { hdrCSpan = 0; } // 
	if (hdrRSpan === null) { hdrRSpan = 0; } // 
	if (iGroup === null) { iGroup = 0; } // 
	if (iWdthFixed === null) { iWdthFixed = 0; } // 
	if (iPadDiv === null) { iPadDiv = 0; } // col header text
	if (iEdit === null) { iEdit = 0; } // col edittype 1-edit optional value, 2-edit required value
	if (hl === null) { hl = 0; } // 
	if (iBoldset === null) { iBoldset = 0; } // 
	if (isHl === null) { isHl = 0; } // Is Hyperlink for action 
	if (SupressDups === null) { SupressDups = 0; } // 
	if (CleanStr === null) { CleanStr = 0; } // 
	if (showToolTipVal === null) { showToolTipVal = 0; } // 
	if (x5 === null) { x5 = 0; } // 
	if (x6 === null) { x6 = 0; } // 
	if (x7 === null) { x7 = 0; } // 

	if (nCol < 100 && nRow > 0 && nRow <= 3) {
		var row = nRow -1;
		jsDGColDataMCN[nCol][0][row] = wdth;
		jsDGColDataMCN[nCol][1][row] = typ;
		jsDGColDataMCN[nCol][2][row] = iCast;
		jsDGColDataMCN[nCol][3][row] = hlt;
		jsDGColDataMCN[nCol][4][row] = tgt;
		jsDGColDataMCN[nCol][5][row] = agg;
		jsDGColDataMCN[nCol][6][row] = iSort;
		jsDGColDataMCN[nCol][7][row] = iFilter;
		jsDGColDataMCN[nCol][8][row] = iVanish;
		jsDGColDataMCN[nCol][9][row] = hdrCSpan;
		jsDGColDataMCN[nCol][10][row] = hdrRSpan;
		jsDGColDataMCN[nCol][11][row] = iGroup;
		jsDGColDataMCN[nCol][12][row] = iWdthFixed;
		jsDGColDataMCN[nCol][13][row] = iPadDiv;
		jsDGColDataMCN[nCol][14][row] = iEdit;
		jsDGColDataMCN[nCol][15][row] = hl;
		jsDGColDataMCN[nCol][16][row] = iBoldset;
		jsDGColDataMCN[nCol][17][row] = rowspn;
		jsDGColDataMCN[nCol][18][row] = isHl;
		jsDGColDataMCN[nCol][19][row] = SupressDups;
		jsDGColDataMCN[nCol][20][row] = CleanStr;
		jsDGColDataMCN[nCol][21][row] = showToolTipVal;
		jsDGColDataMCN[nCol][22][row] = x5;
		jsDGColDataMCN[nCol][23][row] = x6;
		jsDGColDataMCN[nCol][24][row] = x7;
		return true;
	}
	else {
		return false;
	}
}

function FillOneColArrayDataMCTDg(nCol, nRow, datacol, hOrient, vOrient, fmt, vis, hdrTxt, hdrBld, hdrbColor, hdrfColor, defVal, blankVal, lnkV1CNm, lnkV2CNm, lnkV3CNm, radGrpName, chkval1, chkColNm, HLCol, t4, t5, contenttype) {
	//contenttype: 'd'-datacolumn, 't'-text (usually as link text)
	if (datacol === null) { datacol = ''; } // col name
	if (hOrient === null) { hOrient = ''; } // col horizontal orientation
	if (vOrient === null) { vOrient = ''; } // col vertical orientation
	if (fmt === null) { fmt = ''; } // col special formatting
	if (vis === null) { vis = ''; } // col visible 
	if (hdrTxt === null) { hdrTxt = ''; } // col header text
	if (hdrBld === null) { hdrBld = ''; } // col header text
	if (hdrbColor === null) { hdrbColor = ''; } // col header back color
	if (hdrfColor === null) { hdrfColor = ''; } // col header text color
	if (defVal === null) { defVal = ''; } // 
	if (blankVal === null) { blankVal = ''; } // col header text
	if (radGrpName === null) { radGrpName = ''; }
	if (contenttype === null) { contenttype = 'd'; }
	if (chkval1 === null) { chkval1 = ''; }
	if (chkColNm === null) { chkColNm = ''; }
	if (HLCol === null) { HLCol = ''; }
	if (t4 === null) { t4 = ''; }
	if (t5 === null) { t5 = ''; }

	hOrient = hOrient.replace(';', '');
	vOrient = vOrient.replace(';', '');
	hdrbColor = hdrbColor.replace(';', '');
	hdrfColor = hdrfColor.replace(';', '');

	if (nCol < 100 && nRow > 0 && nRow <= 3) {
		var row = nRow -1;
		jsDGColDataMCT[nCol][0][row] = datacol; // col mapping
		jsDGColDataMCT[nCol][1][row] = hOrient; // colOrientH: center, left, right
		jsDGColDataMCT[nCol][2][row] = vOrient; // colOrientV: middle top, bottom
		jsDGColDataMCT[nCol][3][row] = fmt; //fmt: bold, bc#000000, fc#000000, disabled, readonly
		jsDGColDataMCT[nCol][4][row] = vis; //vis: '', hidden
		jsDGColDataMCT[nCol][5][row] = hdrTxt;
		jsDGColDataMCT[nCol][6][row] = hdrBld;
		jsDGColDataMCT[nCol][7][row] = hdrbColor;
		jsDGColDataMCT[nCol][8][row] = hdrfColor;
		jsDGColDataMCT[nCol][9][row] = defVal;
		jsDGColDataMCT[nCol][10][row] = blankVal;
		jsDGColDataMCT[nCol][11][row] = lnkV1CNm;
		jsDGColDataMCT[nCol][12][row] = lnkV2CNm;
		jsDGColDataMCT[nCol][13][row] = lnkV3CNm;
		jsDGColDataMCT[nCol][14][row] = radGrpName;
		jsDGColDataMCT[nCol][15][row] = chkval1;
		jsDGColDataMCT[nCol][16][row] = chkColNm;
		jsDGColDataMCT[nCol][17][row] = HLCol;
		jsDGColDataMCT[nCol][18][row] = t4;
		jsDGColDataMCT[nCol][19][row] = t5;
		jsDGColDataMCT[nCol][20][row] = contenttype;
		jsDGColDataMCT[nCol][21][row] = nRow;
		return true;
	}
	else {
		return false;
	}
}

function FillOneGroupArrayDataDg(nGroup, GrpName, bColor, fColor, bld, hOrient, lnHt, brdrPx, brdrColor, LRPad, TBPad, t10) {
	if (nGroup === 0) { jsDGGroup[0] = 1;}
	if (nGroup === 1) { jsDGGroup[1] = 1; }
	if (nGroup === 2) { jsDGGroup[2] = 1; }
	if (GrpName === null) { GrpName = ''; }
	if (bColor === null) { bColor = ''; }
	if (fColor === null) { fColor = ''; }
	if (bld === null) { bld = ''; }
	if (hOrient === null) { hOrient = ''; }
	if (lnHt === null) { lnHt = ''; }
	if (brdrPx === null) { brdrPx = ''; }
	if (brdrColor === null) { brdrColor = ''; }
	if (LRPad === null) { LRPad = ''; }
	if (TBPad === null) { TBPad = ''; }
	if (t10 === null) { t10 = ''; }
	bColor = bColor.replace(';', '');
	fColor = fColor.replace(';', '');
	lnHt = lnHt.replace(';', '');
	LRPad = LRPad.replace(';', '');
	TBPad = TBPad.replace(';', '');
	if (lnHt === undefined || lnHt === null) { lnHt = ''; }
	if (lnHt !== '') {
		if (lnHt.indexOf('px') < 1 && lnHt.length > 0) { lnHt = lnHt + 'px'; }
	}
	brdrColor = brdrColor.replace(';', '');
	brdrPx = brdrPx.replace('px', '').replace(';', '');
	jsDGGroupData[nGroup][0] = GrpName;
	jsDGGroupData[nGroup][1] = bColor;
	jsDGGroupData[nGroup][2] = fColor;
	jsDGGroupData[nGroup][3] = bld;
	jsDGGroupData[nGroup][4] = hOrient;
	jsDGGroupData[nGroup][5] = lnHt;
	jsDGGroupData[nGroup][6] = brdrPx;
	jsDGGroupData[nGroup][7] = brdrColor;
	jsDGGroupData[nGroup][8] = LRPad;
	jsDGGroupData[nGroup][9] = TBPad;
	jsDGGroupData[nGroup][10] = t10;
}

function setGridFormattingDg(fColor, fColorH, fColorF, fColorP, bColor, bColorH, bColorF, bColorP, hiltColor, lnHt, clHt, fsiz, bld, brdrL, brdrR, brdrT, brdrB, cpadL, cpadR, cpadT, cpadB, sPad, marL, marR, marT, marB, bSpace, sepBrdr, tblClass, hasHdr, hasFooter, boldsetH, boldsetF, AltBackColor, PgnBColor, PgnFColor, ShowDragIcon, ClickCol, showRowSl, showEditRow) {
	jsDGforeColor = '#000000';
	jsDGbgColor = '#FFFFFF';
	jsDGPgnBColor = '#AAAAAA';
	jsDGPgnTColor = '#555555';
	jsDGLineHt = '16px';
	jsDGCellHt = '18px';
	jsDGFontBold = '';
	jsDGFontSz = '10pt';
	if (bColor === null) { bColor = ''; }
	if (bColorH === null) { bColorH = ''; }
	if (bColorF === null) { bColorF = ''; }
	if (bColorP === null) { bColorP = ''; }
	if (fColor === null) { fColor = ''; }
	if (fColorH === null) { fColorH = ''; }
	if (fColorF === null) { fColorF = ''; }
	if (fColorP === null) { fColorP = ''; }
	if (hiltColor === null) { hiltColor = ''; }
	if (PgnBColor === null) { PgnBColor = '';}
	if (PgnFColor === null) { PgnFColor = '';}
	if (lnHt === null) { lnHt = ''; }
	if (clHt === null) { clHt = ''; }
	if (fsiz === null) { fsiz = ''; }
	if (bld === null) { bld = false; }
	if (showRowSl === null) {showRowSl = false;}
	if (showEditRow === null) {showEditRow = false;}

	if (fColor !== '') {
		fColor = fColor.replace(';', '');
		jsDGforeColor = fColor;
	}
	if (fColorH !== '') {
		fColorH = fColorH.replace(';', '');
		jsDGforeHdrColor = fColorH;
	}
	if (fColorF !== '') {
		fColorF = fColorF.replace(';', '');
		jsDGforeFtrColor = fColorF;
	}
	if (fColorP !== '') {
		fColorP = fColorP.replace(';', '');
		jsDGforePrmColor = fColorP;
	}
	if (bColor !== '') {
		bColor = bColor.replace(';', '');
		jsDGbgColor = bColor;
	}
	if (bColorH !== '') {
		bColorH = bColorH.replace(';', '');
		jsDGbgHdrColor = bColorH;
	}
	if (bColorF !== '') {
		bColorF = bColorF.replace(';', '');
		jsDGbgFtrColor = bColorF;
	}
	if (bColorP !== '') {
		bColorP = bColorP.replace(';', '');
		jsDGbgPrmColor = bColorP;
	}
	if (hiltColor !== '') {
		hiltColor = hiltColor.replace(';', '');
		jsDGHighlightColor = hiltColor;
	}
	if (lnHt !== '') {
		lnHt = lnHt.replace(';', '');
		if (lnHt.indexOf('px') < 1) { lnHt = lnHt + 'px'; }
		jsDGLineHt = lnHt;
	}
	if (clHt !== '') {
		clHt = clHt.replace(';', '');
		if (clHt.indexOf('px') < 1) { clHt = clHt + 'px'; }
		jsDGCellHt = clHt;
	}
	if (fsiz !== '') {
		fsiz = fsiz.replace(';', '').replace('px', '');
		if (fsiz.indexOf('pt') < 1) { fsiz = fsiz + 'pt'; }
		jsDGFontSz = fsiz;
	}

	jsDGHdrBoldSet = boldsetH;
	jsDGFtrBoldSet = boldsetF;
	jsDGFontBold = bld;
	jsDGbrdrB = '0px';
	jsDGbrdrL = '0px';
	jsDGbrdrR = '0px';
	jsDGbrdrT = '0px';
	if (brdrB.length > 0) { jsDGbrdrB = brdrB; }
	if (brdrL.length > 0) { jsDGbrdrL = brdrL; }
	if (brdrR.length > 0) { jsDGbrdrR = brdrR; }
	if (brdrT.length > 0) { jsDGbrdrT = brdrT; }
	jsDGCellPadB = '0px';
	jsDGCellPadL = '0px';
	jsDGCellPadR = '0px';
	jsDGCellPadT = '0px';
	if (cpadB !== '' && cpadB !== null) {
		if (cpadB.length > 4) { cpadB = cpadB.substr(0, 4); }
		if (cpadB.length > 0 && cpadB.indexOf('px') < 1) {
			cpadB = cpadB + 'px';
		}
		jsDGCellPadB = cpadB;
	}
	if (cpadL !== '' && cpadL !== null) {
		if (cpadL.length > 4) { cpadL = cpadL.substr(0, 4); }
		if (cpadL.length > 0 && cpadL.indexOf('px') < 1) {
			cpadL = cpadL + 'px';
		}
		jsDGCellPadL = cpadL;
	}
	if (cpadR !== '' && cpadR !== null) {
		if (cpadR.length > 4) { cpadR = cpadR.substr(0, 4); }
		if (cpadR.length > 0 && cpadR.indexOf('px') < 1) {
			cpadR = cpadR + 'px';
		}
		jsDGCellPadR = cpadR;
	}
	if (cpadT !== '' && cpadT !== null) {
		if (cpadT.length > 4) { cpadT = cpadT.substr(0, 4);}
		if (cpadT.length > 0 && cpadT.indexOf('px') < 1) {
			cpadT = cpadT + 'px';
		}
		jsDGCellPadT = cpadT;
	}
	if (marB !== '' && marB !== null) {jsDGMarginBottom = marB;}
	if (marL !== '' && marL !== null) { jsDGMarginLeft = marL; }
	if (marR !== '' && marR !== null) { jsDGMarginRight = marR; }
	if (marT !== '' && marT !== null) { jsDGMarginTop = marT; }

	jsDGTblPad = sPad;
	jsDGbrdrSpace = bSpace;
	jsDGSepBorder = sepBrdr;
	if (tblClass === null) { tblClass = '';}
	jsDGTblClassName = tblClass;
	jsDGbHasFooter = hasFooter;
	if (AltBackColor === undefined || AltBackColor === null) { AltBackColor = '';}
	if (AltBackColor.length > 0) {
		jsDGTglColor = AltBackColor;
	}
	else {
		jsDGTglColor = '#E8E8E8';
	}
	if (PgnBColor !== '') {jsDGPgnBColor = PgnBColor;}
	if (PgnFColor !== '') {jsDGPgnTColor = PgnFColor;}
	if (ShowDragIcon === undefined || ShowDragIcon === null) {ShowDragIcon = false;}
	jsDGbShowDragIcon = ShowDragIcon;
	if (ClickCol === undefined || ClickCol === null) { ClickCol = false; }
	jsDGbShowClickCol = ClickCol;
	jsDGbShowRowSel = showRowSl;
	jsDGbShowEditRow = showEditRow;
}

// ***************************************************************************************
// updated 12/17/2014 - fills global header line #2 format and text for use later
function setHdrLine2Dg(nCols, colTxt, colWdth) {
	jsDGHdr2Col = nCols;
	for (var col = 0; col < nCols; col++) {
		jsDGHdr2Text[col] = colTxt[col];
		jsDGHdr2Wdth[col] = colWdth[col];
	}
	return 'Okay';
}

function FillGridFooterDataDg(nCol, txt, bld, bColor, fColor, AggType, t5) {
	if (t4 === null) { t4 = ''; }
	if (t5 === null) { t5 = ''; }
	jsDGColFtrData[nCol][0] = txt.toString();
	jsDGColFtrData[nCol][1] = bld.toString();
	jsDGColFtrData[nCol][2] = bColor.toString();
	jsDGColFtrData[nCol][3] = fColor.toString();
	jsDGColFtrData[nCol][4] = isAgg.toString();
	jsDGColFtrData[nCol][5] = t5;
}

// ***************************************************************************************
// updated 12/9/2014 - Returns a formed table grid in a div with div caption at top for a datatable
function FormDataGridHdrDg(parentobj, tblname, prfx, NbrCol, NbrHRows, oh, ov, bgclr, frclr, brdr, pdL, pdR, pdT, pdB, cellclassnm, objid) {
	//oh: 0-left, 1-center, 2-right, 3-use settings by column
	//ov: 0-left, 1-center, 2-right, 3-use settings by column
	var bld = '';
	var tbl = document.createElement("table");
	var thd = document.createElement("thead");
	var tbdy = document.createElement("tbody");
	tbl.id = tblname;
	var orientH = 'center';
	var orientV = 'middle';
	var bColor = jsDGbgColor;
	var fColor = jsDGforeColor;

	if (nbrhdrrows > 0) {
		NewRow = document.createElement("tr");
		for (var col = 0; col < NbrCol; col++) {
			switch (oh) {
				case 0:
					orientH = 'left';
					break;
				case 1:
					orientH = 'center';
					break;
				case 2:
					orientH = 'right';
					break;
				default:
					orientH = 'center';
					break;
			}
			switch (ov) {
				case 0:
					orientV = 'top';
					break;
				case 1:
					orientV = 'middle';
					break;
				case 2:
					orientV = 'bottom';
					break;
				default:
					orientV = 'middle';
					break;
			}
			bld = jsDGColDataT[col][6].toString();
			bColor = jsDGbgHdrColor;
			if (jsDGColDataT[col][7].length > 0) { bColor = jsDGColDataT[col][7]; }
			fColor = jsDGforeHdrColor;
			if (jsDGColDataT[col][8].length > 0) { fColor = jsDGColDataT[col][8]; }
			//id, content, clspan, classnm, txtalign, valign, cellwidth, bgcolor
			NewRow.appendChild(createHdrCellDg(createObjIDDg('Hdr' + prfx + objid.toString(), 0, col), jsDGColDataT[col][5], jsDGColDataN[col][9].toString(), cellclassnm, orientH, orientV, jsDGColDataN[nCol][0].toString() + 'px', bColor, fColor, pdL, pdR, pdT, pdB, bld), '');
		}
		thd.appendChild(NewRow);
	}

	if (NbrHRows > 1) {
		NewRow = document.createElement("tr");
		for (var col2 = 0; col2 < jsDGHdr2Col; col2++) {
			switch (oh) {
				case 0:
					orientH = 'left';
					break;
				case 1:
					orientH = 'center';
					break;
				case 2:
					orientH = 'right';
					break;
				default:
					orientH = 'center';
					break;
			}
			switch (ov) {
				case 0:
					orientV = 'top';
					break;
				case 1:
					orientV = 'middle';
					break;
				case 2:
					orientV = 'bottom';
					break;
				default:
					orientV = 'middle';
					break;
			}
			bld = jsDGColDataT[col][6].toString();
			bColor = jsDGbgHdrColor;
			fColor = jsDGforeHdrColor;
			//id, content, clspan, cls, txtalign, valign, cellwidth, bgcolor
			NewRow.appendChild(createHdrCellDg(createObjIDDg('Hdr2' + prfx + objid.toString(), 0, col), jsDGHdr2Text[col2], '', cellclassnm, orientH, orientV, jsDGHdr2Wdth[col2].toString() + 'px', bColor, fColor, pdL, pdR, pdT, pdB, bld, ''));
		}
		thd.appendChild(NewRow);
	}
	tbl.appendChild(thd);
	tbl.appendChild(tbdy);

	var oldTable = parentobj.getElementsByTagName("table")[0];
	parentobj.replaceChild(tbl, oldTable);
}

// ***************************************************************************************
// 12/9/2014 - forms and attaches a new body to an existing HTML table
function FormDataGridDg(parentObj, cellprfx, altRowA, brdr, showtotalC, showrownm, AggLabel, NbrCols, colData, ovrflw, vwCol, EdtCol, DelCol, idCol, lnk1Col, lnk2Col, lnk3Col, iPadDiv, addParamBar, bEdit, cellClass, IsLocked, UsePageBar, t1, objid) {
	//alert('Fired!');
	var aggType = 0;
	var bColor = '';
	var bIsConstruct = false;
	var bld = false;
	var brdrL = '0px';
	var brdrR = '0px';
	var brdrT = '0px';
	var brdrB = '0px';
	var btn1 = '';
	var btn2 = '';
	var btn3 = '';
	var cellid = '';
	var ci = '';
	var colClass = 'T';
	var colID = '0';
	var colType = 0;
	var content = '';
	var divVal = '';
	var dsabld = false;
	var fColor = jsDGforeColor;
	var fig = 0;
	var fmt = 0;
	var HiLowCol = 0;
	var HiLowFig = 0;
	var HiLowVal = '';
	var hOrient = '';
	var ht = '';
	var iCast = 0;
	var id = 0;
	var iOverflow = 0;
	var iPadCellDiv = 0;
	var ischecked = false;
	var isItalic = false;
	var iVal = 0;
	var iVanish = 0;
	var lastGrp1 = '';
	var lastGrp2 = '';
	var lastGrp3 = '';
	var msg = '';
	var nbrRow = 0;
	var nbrCol = 0;
	var nCol = 0;
	var NewRow;
	var origVal = '';
	var RdOnly = false;
	var sAggValue = '';
	var sBlankVal = '';
	var sCol = '';
	var ShowTooltip = false;
	var sObjType = '';
	var sPgNbr = '';
	var SrcType = '';
	var sRow = '';
	var sValue = '';
	var sVis = '';
	var t = 0;
	var tgl = 1;
	var typ = 0;
	var uLimit = 0;
	var val = '';
	var val2 = '';
	var ValGrp1 = '';
	var ValGrp2 = '';
	var ValGrp3 = '';
	var vOrient = '';
	var wdth = 0;

	//if (!(validateDataSource(colData, NbrCols, idCol, vwCol, EdtCol, DelCol))) {
	//	alert(jsDGErrorList);
	//	return false;
	//}


	if (AggLabel === null) { AggLabel = 'Totals'; }
	if (colData !== undefined && colData !== null) {
		var tbdy = document.createElement("tbody");
		var NbrRows = colData.length;
		if (NbrRows > 0) {

			// handle pagination initiation
			if (objid > 0 && UsePageBar === false) {
				sPgNbr = (jiaPgNbrPj[objid] + 1).toString();
				jiaNbrPagesPj[objid] = parseInt(colData[0].NbrPages, 10);
				jiaNbrRowsPj[objid] = parseInt(colData[0].NbrRows, 10);
				switch (objid) {
					case 1:
						jotGotoPgNbrPj.value = '';
						joPgNbrLblPj.innerHTML = sPgNbr;
						joMaxPgNbrLblPj.innerHTML = jiaNbrPagesPj[1].toString();
						break;
					case 2:
						jotGotoPgNbrPj2.value = '';
						joPgNbrLblPj2.innerHTML = sPgNbr;
						joMaxPgNbrLblPj2.innerHTML = jiaNbrPagesPj[2].toString();
						break;
					case 3:
						jotGotoPgNbrPj3.value = '';
						joPgNbrLblPj3.innerHTML = sPgNbr;
						joMaxPgNbrLblPj3.innerHTML = jiaNbrPagesPj[3].toString();
						break;
					case 4:
						jotGotoPgNbrPj4.value = '';
						joPgNbrLblPj4.innerHTML = sPgNbr;
						joMaxPgNbrLblPj4.innerHTML = jiaNbrPagesPj[4].toString();
						break;
					case 5:
						jotGotoPgNbrPj5.value = '';
						joPgNbrLblPj5.innerHTML = sPgNbr;
						joMaxPgNbrLblPj5.innerHTML = jiaNbrPagesPj[5].toString();
						break;
					case 6:
						jotGotoPgNbrPj6.value = '';
						joPgNbrLblPj6.innerHTML = sPgNbr;
						joMaxPgNbrLblPj6.innerHTML = jiaNbrPagesPj[6].toString();
						break;
					case 7:
						jotGotoPgNbrPj7.value = '';
						joPgNbrLblPj7.innerHTML = sPgNbr;
						joMaxPgNbrLblPj6.innerHTML = jiaNbrPagesPj[7].toString();
						break;
					case 8:
						jotGotoPgNbrPj8.value = '';
						joPgNbrLblPj8.innerHTML = sPgNbr;
						joMaxPgNbrLblPj8.innerHTML = jiaNbrPagesPj[8].toString();
						break;
					case 9:
						jotGotoPgNbrPj9.value = '';
						joPgNbrLblPj9.innerHTML = sPgNbr;
						joMaxPgNbrLblPj9.innerHTML = jiaNbrPagesPj[9].toString();
						break;
					case 10:
						jotGotoPgNbrPj10.value = '';
						joPgNbrLblPj10.innerHTML = sPgNbr;
						joMaxPgNbrLblPj10.innerHTML = jiaNbrPagesPj[10].toString();
						break;
					case 11:
						jotGotoPgNbrPj11.value = '';
						joPgNbrLblPj11.innerHTML = sPgNbr;
						joMaxPgNbrLblPj11.innerHTML = jiaNbrPagesPj[11].toString();
						break;
					case 12:
						jotGotoPgNbrPj12.value = '';
						joPgNbrLblPj12.innerHTML = sPgNbr;
						joMaxPgNbrLblPj12.innerHTML = jiaNbrPagesPj[12].toString();
						break;
					case 13:
						jotGotoPgNbrPj13.value = '';
						joPgNbrLblPj13.innerHTML = sPgNbr;
						joMaxPgNbrLblPj13.innerHTML = jiaNbrPagesPj[13].toString();
						break;
					case 14:
						jotGotoPgNbrPj14.value = '';
						joPgNbrLblPj14.innerHTML = sPgNbr;
						joMaxPgNbrLblPj14.innerHTML = jiaNbrPagesPj[14].toString();
						break;
					case 15:
						jotGotoPgNbrPj15.value = '';
						joPgNbrLblPj15.innerHTML = sPgNbr;
						joMaxPgNbrLblPj15.innerHTML = jiaNbrPagesPj[15].toString();
						break;
					case 16:
						jotGotoPgNbrPj16.value = '';
						joPgNbrLblPj16.innerHTML = sPgNbr;
						joMaxPgNbrLblPj16.innerHTML = jiaNbrPagesPj[16].toString();
						break;
					case 17:
						jotGotoPgNbrPj17.value = '';
						joPgNbrLblPj17.innerHTML = sPgNbr;
						joMaxPgNbrLblPj17.innerHTML = jiaNbrPagesPj[17].toString();
						break;
					case 18:
						jotGotoPgNbrPj18.value = '';
						joPgNbrLblPj18.innerHTML = sPgNbr;
						joMaxPgNbrLblPj18.innerHTML = jiaNbrPagesPj[18].toString();
						break;
					case 19:
						jotGotoPgNbrPj19.value = '';
						joPgNbrLblPj19.innerHTML = sPgNbr;
						joMaxPgNbrLblPj19.innerHTML = jiaNbrPagesPj[19].toString();
						break;
					case 20:
						jotGotoPgNbrPj20.value = '';
						joPgNbrLblPj20.innerHTML = sPgNbr;
						joMaxPgNbrLblPj20.innerHTML = jiaNbrPagesPj[20].toString();
						break;
					default:
						break;
				}
			} //if (objid > 0)

			// create columns and insert data
			var ColAggs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var NbrRowsSel = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

			// establish grid cell borders
			if (brdr.length > 0) {
				brdrB = brdr;
				brdrL = brdr;
				brdrR = brdr;
				brdrT = brdr;
			}
			if (jsDGbrdrB !== '0px') { brdrB = jsDGbrdrB;}
			if (jsDGbrdrL !== '0px') { brdrL = jsDGbrdrL;}
			if (jsDGbrdrR !== '0px') { brdrR = jsDGbrdrR;}
			if (jsDGbrdrT !== '0px') { brdrT = jsDGbrdrT; }

			//alert('Param Bar');
			if (addParamBar === true) {
				NewRow = document.createElement("tr");
				if (showrownm === true) {
					NewRow.appendChild(createNewCellDg(createObjIDDg(cellprfx + 'RNPA', 0, 0), jsDGCellHt, '50px', '', '#000000', '#000000', brdr, 'center', 'top', jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, true, '', '', '', '', '', '', '', 0));
				}
				for (var colZ = 0; colZ < NbrCols; colZ++) {
					sCol = colZ.toString();
					if (sCol.length === 1) { sCol = '0' + sCol; }
					bColor = jsDGbgPrmColor;
					wdth = parseInt(jsDGColDataN[colZ][0], 10);
					hOrient = jsDGColDataT[colZ][1].toString();
					sVis = jsDGColDataT[colZ][4].toString();
					ht = jsDGCellHt;
					if (fmt.substr(0, 2) === 'ht') { ht = fmt.substr(2, 4); }
					val = '';
					if (jsDGColDataN[colZ][7] === 1) {
						val = '<input type="text" id="txtDGParamCol' + sCol + 'o' + objid.toString() + '" value="" style="border:0px;width=' + wdth.toString() + 'px' + 'px;color=' + jsDGforePrmColor + ';background-color:' + jsDGbgPrmColor + ';" />';
					}
					else {
						bColor = '#000000';
					}
					NewRow.appendChild(createNewCellDg(createObjIDDg(cellprfx + 'RNPA', 0, 0), ht, wdth.toString() + 'px', val, bColor, jsDGforePrmColor, brdr, hOrient, 'top', jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, true, '', '', '', sVis, '', '', '', 0));
				}
				tbdy.appendChild(NewRow);
			} //if (addParamBar === true)

			nCol = NbrCols;
			if (showrownm === true) { nCol++; }

			//alert('Handling data rows');
			// ****************************************************************************************************************
			for (var row = 0; row < NbrRows; row++) {
				if (tgl === 0) {
					tgl = 1;
				}
				else {
					tgl = 0;
				}

				NewRow = document.createElement("tr");
				sRow = row.toString();
				if (sRow.length === 2) { sRow = '0' + sRow;}
				if (sRow.length === 1) { sRow = '00' + sRow; }
				// identify and fill any ID value IMPORTANT
				if (idCol.length > 0) { id = parseInt(colData[row][idCol], 10); }

				// - - - - - - - INSERT ROW - - - - - - -					
				// show empty/unbordered cell to hold row selectors
				if (jsDGbShowRowSel === true) {
					NewRow.appendChild(createNewCellDg(('CSRSL' + sRow + objid.toString()), jsDGCellHt, '40px', '', bColor, fColor, brdrL, brdrR, brdrT, brdrB, 'right', 'middle', jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, true, false, '', '', '', '', '', cellClass, '', 0));
				}

				// show row number cell if necessary
				if (showrownm === true) {
					NewRow.appendChild(createNewCellDg(createObjIDDg(cellprfx + 'RN' + objid.toString(), row, 0), jsDGCellHt, '50px', row.toString(), bColor, fColor, brdrL, brdrR, brdrT, brdrB, 'center', 'top', jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, true, false, '', '', '', '', '', cellClass, '', 0));
				}
				// show Drag Icon if necessary
				if (jsDGbShowDragIcon === true) {
					ci = '<img id="imgRDI' + sRow + objid.toString() + '" src="../Images/build.gif" style="width:12px;height:12px;" />';
					NewRow.appendChild(createNewCellDg(createObjIDDg(cellprfx + 'RDI' + objid.toString(), row, 0), jsDGCellHt, '40px', ci, bColor, fColor, brdrL, brdrR, brdrT, brdrB, 'center', 'middle', jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, true, false, '', '', '', '', '', cellClass, '', 0));
				}
				if (jsDGbShowClickCol === true) {
					ci = '<input type="checkbox" id="chkSelRow' + sRow + objid.toString() + '" />';
					NewRow.appendChild(createNewCellDg(createObjIDDg(cellprfx + 'CSR' + objid.toString(), row, 0), jsDGCellHt, '40px', ci, bColor, fColor, brdrL, brdrR, brdrT, brdrB, 'center', 'middle', jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, true, false, '', '', '', '', '', cellClass, '', 0));
				}

				ValGrp1 = '';
				ValGrp2 = '';
				ValGrp3 = '';

				//alert('Handling columns');
				for (var col = 0; col < NbrCols; col++) {
					bIsConstruct = false;
					ShowTooltip = false;
					divVal = '';
					if (jsDGColDataN[col][18] === 1) { ShowTooltip = true; }
					// get col ident string
					sCol = col.toString();
					sValue = '';
					origVal = '';
					val = '';
					content = '';
					if (sCol.length === 1) { sCol = '0' + sCol; }
					// get value from mapped column
					colID = jsDGColDataT[col][0].toString(); //colMap[col].toString();
					SrcType = jsDGColDataT[col][20].toString().toLowerCase();
					fmt = jsDGColDataT[col][3].toString(); // colFmt[col].toString();
					bColor = jsDGbgColor;
					fColor = jsDGforeColor;
					ht = jsDGCellHt;

					switch (SrcType) {
						case 'x': // construct
							bIsConstruct = true;
							sObjType = '';
							if (fmt.substr(0, 3) === 'con') { sObjType = fmt; }
							//alert(sObjType);
							switch (sObjType) {
								case 'coninput':
									sValue = '<input type="text" id="txtVR' + sRow + 'C' + sCol + '" value="' + colData[row][colID].toString() + '"/>';
									break;
								case 'conchk':
									ischecked = false;
									var v = colData[row][colID].toString();
									//alert(col.toString() + ' ' + v);
									if (v === 'Yes' || v === 'True') { ischecked = true; }
									if (ischecked === true) { v = ' checked="checked"'; }
									sValue = '<input type="checkbox" id="chkVR' + sRow + 'C' + sCol + '" value="' + col.toString() + '" onchange="javascript:ChangeCheckBox(' + id.toString() + ',' + objid.toString() + ',';
									sValue = sValue + col.toString() + ',this.checked);return false;" ' + v + '/>';
									//alert(sValue);
									break;
								case 'conradio':
									val = jsDGColDataT[nCol][14].toString();
									ischecked = false;
									var v2 = colData[row][colID].toString();
									//alert(v2 + '/' + jsDGColDataT[col][15].toString());
									if (v2 === jsDGColDataT[col][15].toString()) { ischecked = true; }
									if (ischecked === true) { v2 = ' checked="checked" '; }
									sValue = '<input type="radio" id="radVR' + sRow + 'C' + sCol + '" name="radVR' + sRow + val + '" value="' + jsDGColDataT[col][15].toString() + '" onchange="javascript:ChangeRadioBtn(' + id.toString() + ',' + objid.toString() + ',';
									sValue = sValue + col.toString() + ',this.checked);return false;" ' + v2 + '/>';
									break;
								case 'conimage':
									wdth = parseInt(jsDGColDataN[col][0], 10) - 1;
									sValue = '<img id="imgR' + sRow + 'C' + sCol + '" src="' + colData[row][colID].toString() + '" style="width:' + wdth.toString() + 'px;height:' + (ht - 1).toString() + 'px;" ';
									sValue = sValue + 'onclick="javascript:HandleImageClick(' + id.toString() + ',' + col.toString() + ',' + objid.toString() + ');return false;" />';
									break;
								default:
									break;
							}
							break;
						case 't': // text only
							sValue = colID; // just text to show
							origVal = sValue;
							break;
						default:
							sValue = colData[row][colID].toString();
							origVal = sValue;
							break;
					}
					iPadCellDiv = parseInt(jsDGColDataN[col][13], 10);
					//alert(sValue);
					iVanish = parseInt(jsDGColDataN[col][8], 10);
					sBlankVal = jsDGColDataT[col][10].toString();

					// ------------------------------------------------------------------------------
					// add hyperlink if turned on
					if (jsDGColDataN[col][15] === 1 && sValue !== '' && SrcType !== 'x') {
						var hlid = 0;
						var h1 = '';
						var h2 = '';
						var h3 = '';
						var hval = '<a href="#" onclick="javascript:ActivateHyperlink(' + id.toString() + ',' + objid.toString() + ',';
						if (jsDGColDataT[col][11].length > 0) {
							hval = hval + colData[row][jsDGColDataT[col][11].toString()].toString();
							if (jsDGColDataT[col][12].length > 0) {
								hval = hval + "'" + colData[row][jsDGColDataT[col][12].toString()].toString() + "',";
								if (jsDGColDataT[col][13].length > 0) {
									hval = hval + "'" + colData[row][jsDGColDataT[col][13].toString()].toString() + "'";
								}
								else {
									hval = hval + "''";
								}
							}
							else {
								hval = hval + "'', ''";
							}
						}
						else {
							hval = hval + "'', '', ''";
						}
						sValue = hval + ');return false;">' + sValue + '<a>';
					}

					if (aggType > 0) {
						sAggValue = sValue;
					}

					// blank value if necessary
					if (sValue === sBlankVal) {
						sValue = '';
					}

					// clean data
					t = parseInt(jsDGColDataN[col][20], 10);
					if (t > 0) { sValue = PrepareHTMLForViewTx(sValue, t-1);}

					//alert('2 ' + sValue);
					typ = parseInt(jsDGColDataN[col][2], 10); //type: 0-text, 1-textCODE, 2-int, 3-numeric, 4-money, 5-bool, 6-date, 7-datetime, 8-time, 9-email, 10-phonenbr
					iCast = parseInt(jsDGColDataN[col][1], 10); //icast: 0-NONE, 1-Money ($), 2-Money ($) Blank 0, 3-Money ($) No Comma, 2-2 decimal Nbr, 2 decimal Nbr-Blank 0, 2 decimal Nbr-No Comma,
					// 3-Integer, 103-Integer-Blank 0, 203-Integer-No Comma, 4-Date, 5-Time, 6-Boolean (0,1), 106-Boolean (1 only), 7-Boolean (Yes,No), 107-Boolean (Yes only), 8-Boolean (True,False)
					if (sValue !== '' && SrcType !== 'x') {
						colClass = 'T';
						switch (typ) {
							case 2:
								sValue = parseInt(sValue, 10).toString();
								colClass = 'N';
								break;
							case 3:
								sValue = parseFloat(sValue).toString();
								colClass = 'N';
								break;
							case 4:
								sValue = parseFloat(sValue).toString();
								colClass = 'N';
								break;
							default:
								// nothing
								break;
						}
					}

					// cast into specific string if necessary
					if (iCast > 0) {
						content = setStringFormatDg(sValue, iCast);
					}
					else {
						content = sValue;
					}

					//alert(jsDGColDataN[col][11]);
					// set row group values if grouping is set
					if (jsDGColDataN[col][11] == 1 && ValGrp1 === '') { ValGrp1 = sValue; }
					if (jsDGColDataN[col][11] == 2 && ValGrp2 === '') { ValGrp2 = sValue; }
					if (jsDGColDataN[col][11] == 3 && ValGrp3 === '') { ValGrp3 = sValue; }

					// ------------------------------------------------------------------------------
					// set special formatting if necessary
					if (altRowA === true) {
						if (tgl === 1) {
							bColor = jsDGTglColor;
						}
					}
					if (bIsConstruct === false) {
						if (fmt.substr(0, 2) === 'bc') { bColor = fmt.substr(2, 7); }
						if (fmt.substr(0, 2) === 'fc') { fColor = fmt.substr(2, 7); }
						if (fmt.substr(0, 2) === 'ht') { ht = fmt.substr(2, 4); }
					}

					//alert('4 ' + content);
					// highlight text in highlight color if it exceeds threshold
					if (sValue !== '') {
						if (jsDGColDataN[col][3] === 1) {
							//alert('Fired! ' + jsDGHighlightColor + '/' + colClass);
							if (colClass === 'N') {
								uLimit = parseFloat(jsDGColDataN[col][4]);
								//alert('Fired! ' + jsDGHighlightColor + '/' + uLimit);
								if (parseFloat(sValue) < uLimit) {
									fColor = jsDGHighlightColor;
								}
							}
							if (colClass === 'T') {
								val2 = jsDGColDataN[col][4].toString();
								if (val < val2) {
									fColor = jsDGHighlightColor;
								}
							}
						}
					}

					// ------------------------------------------------------------------------------
					// set global format items
					bld = false;
					if (jsDGFontBold || fmt === 'bold' || parseInt(jsDGColDataN[col][16], 10) === 1) { bld = true; }
					if (parseInt(jsDGColDataN[col][16], 10) === 2) { isItalic = true; }
					dsabld = false;
					if (fmt === 'disabled') { dsabld = true; }
					RdOnly = false;
					if (fmt === 'readonly') { RdOnly = true; }

					// ------------------------------------------------------------------------------
					// set aggregation
					aggType = parseInt(jsDGColDataN[col][5], 10); // colAgg[col], 10);
					if (SrcType !== 'x') {
						if (sAggValue === null) { sAggValue = '';}
						if (aggType > 0 && sAggValue.length > 0) {
							switch (aggType) {
								case 1: // count
									ColAggs[col]++;
									NbrRowsSel[col]++;
									break;
								case 2: // sum
									if (colClass === 'N') {
										fig = parseFloat(sAggValue);
										ColAggs[col] = ColAggs[col] + fig;
									}
									NbrRowsSel[col]++;
									break;
								case 3: // average
									if (colClass === 'N') {
										fig = parseFloat(sAggValue);
										ColAggs[col] = ColAggs[col] + fig;
									}
									NbrRowsSel[col]++;
									break;
								case 4: // high value
									if (colClass === 'N') {
										fig = parseFloat(sAggValue);
										if (fig > HiLowFig) {
											HiLowFig = fig;
											HiLowCol = col;
										}
									}
									else {
										if (sAggValue > HiLowVal) {
											HiLowVal = sAggValue;
											HiLowCol = col;
										}
									}
									break;
								case 5: // low value
									if (colClass === 'N') {
										fig = parseFloat(sAggValue);
										if (fig < HiLowFig) {
											HiLowFig = fig;
											HiLowCol = col;
										}
									}
									else {
										if (sAggValue < HiLowVal) {
											HiLowVal = sAggValue;
											HiLowCol = col;
										}
									}
									break;
								case 11: //count no zero/empty
									if (colClass === 'N') {
										fig = parseFloat(sAggValue);
										if (fig > 0) {
											ColAggs[col]++;
											NbrRowsSel[col]++;
										}
									}
									else {
										ColAggs[col]++;
										NbrRowsSel[col]++;
									}
									break;
								case 13: //average no zero/empty
									if (colClass === 'N') {
										fig = parseFloat(sAggValue);
										if (fig > 0) {
											ColAggs[col] = ColAggs[col] + fig;
											NbrRowsSel[col]++;
										}
									}
									break;
								default:
									break;
							}
						}
					}

					divVal = '<div id="divTC' + sRow + sCol + objid.toString() + '" ';
					val2 = '';

					// ------------------------------------------------------------------------------
					// setting common formatting values
					wdth = parseInt(jsDGColDataN[col][0], 10);
					hOrient = jsDGColDataT[col][1].toString();
					vOrient = jsDGColDataT[col][2].toString();
					sVis = jsDGColDataT[col][4].toString();
					if (ht !== '') {
						if (ht.indexOf('px') < 1) { ht = ht + 'px'; }
					}
					iOverflow = parseInt(jsDGColDataN[col][12], 10);  //iFixedWidth setting
					//alert('Forming content - ' + bEdit);
					val2 = 'style="diplay:inline-table;width:99%;';
					if (iOverflow > 0 || iPadCellDiv > 0 || iPadDiv > 0) {
						val2 = val2 + 'height:' + ht + ';text-align:' + hOrient + ';vertical-align:' + vOrient + ';';
						// set padding
						iVal = iPadDiv;
						if (iPadCellDiv > 0) {
							iVal = iPadCellDiv;
							switch (iPadCellDiv) {
								case 1:
									val2 = val2 + 'padding-left:2px;padding-right:2px;';
									wdth = wdth + 4;
									break;
								case 2:
									val2 = val2 + 'padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;';
									wdth = wdth + 4;
									break;
								case 3:
									val2 = val2 + 'padding-left:4px;padding-right:4px;';
									wdth = wdth + 8;
									break;
								case 4:
									val2 = val2 + 'padding-left:4px;padding-right:4px;padding-top:1px;padding-bottom:1px;';
									wdth = wdth + 8;
									break;
								default:
									// do nothing
									break;
							}
						}

						// set content overflow
						switch (iOverflow) {
							case 1:
								val2 = val2 + 'white-space:nowrap;overflow:hidden;';
								break;
							case 2:
								val2 = val2 + 'white-space:nowrap;overflow:hidden;text-overflow:clip;';
								break;
							default:
								// do nothing
								break;
						}
					}
					divVal = divVal + val2 + 'width:' + wdth.toString() + 'px;background-color:' + bColor + ';"';

					if (ShowTooltip === true) {
						divVal = divVal + ' title="' + origVal + '"';
					}

					// ------------------------------------------------------------------------------
					// Content only contains value at this point - if to be placed in a control for editing, insert it now: typ = parseInt(jsDGColDataN[col][2])
					if (bEdit === true && IsLocked === false && SrcType === 'd' && parseInt(jsDGColDataN[col][14], 10) > 0) {
						// if the column can be edited, put value in an input textbox or checkbox
						if (typ < 300) {
							content = '<input type="text" id="' + cellprfx + 'X' + sRow + sCol + '" style="width:' + wdth.toString() + 'px;" value="' + content + '" />';
						}
						else {
							switch (typ) {
								case 300:
									val = 'false';
									if (content === '1' || content.toLowerCase() === 'true' || content.toLowerCase() === 'yes') { val = 'true'; }
									content = '<input type="checkbox" id="' + cellprfx + 'CK' + sRow + sCol + '" checked="' + val + '" />';
									break;
								default:
									break;
							}
						}
					}

					// ------------------------------------------------------------------------------
					// add hyperlink if turned on
					if (parseInt(jsDGColDataN[col][15],10) === 1 && content !== '' && SrcType !== 'x') {
						hlid = 0;
						h1 = '';
						h2 = '';
						h3 = '';
						hval = '';
						var ccontent = '<a href="#" onclick="javascript:ActivateHyperlink(' + id.toString() + ',' + objid.toString() + ',';
						if (jsDGColDataT[col][11].length > 0) {
							hval = sValue = colData[row][jsDGColDataT[col][11].toString()].toString();
							ccontent = ccontent + "'" + hval + "',";
							if (jsDGColDataT[col][12].length > 0) {
								hval = sValue = colData[row][jsDGColDataT[col][12].toString()].toString();
								ccontent = ccontent + "'" + hval + "',";
								if (jsDGColDataT[col][13].length > 0) {
									hval = sValue = colData[row][jsDGColDataT[col][12].toString()].toString();
									ccontent = ccontent + "'" + hval + "'";
								}
								else {
									ccontent = ccontent + "''";
								}
							}
							else {
								ccontent = ccontent + "'', ''";
							}
						}
						else {
							ccontent = ccontent + "'', '', ''";
						}
						ccontent = ccontent + ');return false;">';
						content = ccontent + content + '<a>';
					}

					val2 = '';
					btn1 = '';
					btn2 = '';
					btn3 = '';
					if (SrcType !== 'x') {
						// add any special event buttons
						if (vwCol === col + 1) {
							btn1 = '<a id="hlv' + sRow + '" style="width:40px;height:20px;line-height:16px;padding-left:2px;padding-right:2px;color:blue;text-decoration:underline;" href="#" onclick="javascript:ViewOneRec(' + id.toString() + ',' + row.toString() + ',' + objid.toString() + ');">';
							if (SrcType === 'd') {
								btn1 = btn1 + content + '</a>';
							}
							else {
								btn1 = btn1 + 'View</a>';
							}
						}
						if (EdtCol === col + 1 && IsLocked === false) {
							btn2 = '<a id="hle' + sRow + '" style="width:40px;height:20px;line-height:16px;padding-left:2px;padding-right:2px;color:blue;text-decoration:underline;" href="#" onclick="javascript:EditOneRec(' + id.toString() + ',' + row.toString() + ',' + objid.toString() + ');">';
							if (SrcType === 'd') {
								btn2 = btn2 + content + '</a>';
							}
							else {
								btn2 = btn2 + 'Edit</a>';
							}
						}
						if (DelCol === col + 1 && IsLocked === false) {
							btn3 = '<a id="hld' + sRow + '" style="width:32px;height:20px;line-height:16px;padding-left:2px;padding-right:2px;color:blue;text-decoration:underline;" href="#" onclick="javascript:DeleteOneRec(' + id.toString() + ',' + row.toString() + ',' + objid.toString() + ');">';
							if (SrcType === 'd') {
								btn3 = btn3 + content + '</a>';
							}
							else {
								btn3 = btn3 + 'Del</a>';
							}
						}
						if (btn1.length > 0 || btn2.length > 0 || btn3.length > 0) {
							content = btn1 + btn2 + btn3;
						}
					}

					// END padded div
					content = divVal + '>' + content + '</div>';
					// ------------------------------------------------------------------------------
					cellid = createObjIDDg(cellprfx + objid.toString(), row, col);
					//alert('Adding column - ID ' + val + '/' + ht + '/' + wdth.toString() + 'px/' + content + '/' + bColor + '/' + fColor + '/' + brdr + '/' + hOrient + '/' + vOrient);
					//alert('Adding column - ' + jsDGCellPadL + '/' + jsDGCellPadR + '/' + jsDGCellPadT + '/' + jsDGCellPadB + '/' + jsDGFontSz + '/' + bld + '/' + ovrflw + '/' + RdOnly + '/' + dsabld + '/' + sVis);
					// create column and fill it
					NewRow.appendChild(createNewCellDg(cellid, ht, wdth.toString + 'px', content, bColor, fColor, brdrL, brdrR, brdrT, brdrB, hOrient, vOrient, jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, bld, isItalic, ovrflw, RdOnly, dsabld, sVis, '', cellClass, '', 0));
					//alert('Column added');
				}
				// *********************************** END OF COLUMN ****************************************

				// append a group separator row if necessary
				val = '';
				bld = false;
				brdr = '';
				if (jsDGGroups[0] > 0) {
					if (lastGrp1 !== ValGrp1) {
						val = 'Group 1: ' + jsDGGroupData[0][0] + '-Value: ' + ValGrp1;
						if (jsDGGroupData[0][3].length > 0) { bld = true; }
						if (jsDGGroupData[0][6].length > 0) {
							brdr = jsDGGroupData[0][6] + 'px solid ' + jsDGGroupData[0][7];
						}
						tbdy.appendChild(FormGridSeperatorLineDg(nCol, row, objid, '1', val, jsDGGroupData[0][5], jsDGGroupData[0][1], jsDGGroupData[0][2], brdr, jsDGGroupData[0][4], bld));
						lastGrp1 = ValGrp1;
						lastGrp2 = ValGrp2;
						lastGrp3 = ValGrp3;
					}
					else {
						if (jsDGGroups[1] > 0) {
							if (lastGrp2 !== ValGrp2) {
								if (jsDGGroupData[1][3].length > 0) {bld = true;}
								val = 'Group 2: ' + jsDGGroupData[1][0] + '-Value: ' + ValGrp2;
								if (jsDGGroupData[1][6].length > 0) {
									brdr = jsDGGroupData[1][6] + 'px solid ' + jsDGGroupData[1][7];
								}
								tbdy.appendChild(FormGridSeperatorLineDg(nCol, row, objid, '2', val, jsDGGroupData[1][5], jsDGGroupData[1][1], jsDGGroupData[1][2], brdr, jsDGGroupData[1][4], bld));
								lastGrp2 = ValGrp2;
								lastGrp3 = ValGrp3;
							}
							else {
								if (jsDGGroups[2] > 0) {
									if (lastGrp3 !== ValGrp3) {
										if (jsDGGroupData[2][3].length > 0) {bld = true;}
										val = 'Group 3: ' + jsDGGroupData[2][0] + '-Value: ' + ValGrp3;
										if (jsDGGroupData[2][6].length > 0) {
											brdr = jsDGGroupData[2][6] + 'px solid ' + jsDGGroupData[2][7];
										}
										tbdy.appendChild(FormGridSeperatorLineDg(nCol, row, objid, '3', val, jsDGGroupData[2][5], jsDGGroupData[2][1], jsDGGroupData[2][2], brdr, jsDGGroupData[2][4], bld));
										lastGrp3 = ValGrp3;
									}
								}
							}
						}
					}
				}

				// show empty/unbordered cell to hold row selectors
				if (jsDGbShowRowSel === true) {
					NewRow.appendChild(createNewCellDg(createObjIDDg(('CSRSR' + sRow + objid.toString()), row, (col + 1)), jsDGCellHt, '40px', '', bColor, fColor, brdrL, brdrR, brdrT, brdrB, 'left', 'middle', jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, true, false, '', '', '', '', '', cellClass, '', 0));
				}

				tbdy.appendChild(NewRow);
			}
			//alert('Row handling completed');

			// ****************************************************************************************************************
			// show totals row if set
			if (showtotalC === true) {
				NewRow = document.createElement("tr");
				if (showrownm === true) {
					NewRow.appendChild(createNewCellDg(createObjIDDg(cellprfx + 'RN' + objid.toString(), 999, 0), jsDGCellHt, '50px', 'TTL', bColor, fColor, brdrL, brdrR, brdrT, brdrB, 'center', 'top', jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, true, false, '', '', '', '', '', '', '', 0));
				}
				for (var col2 = 0; col2 < NbrCols; col2++) {
					val = '';
					if (col2 === 0) {
						val = AggLabel;
					}
					else {
						aggType = parseInt(jsDGColDataN[col2][5], 10); 
						if (aggType > 0) {
							switch (aggType) {
								case 1: // count
									val = ColAggs[col2].toString();
									break;
								case 2: // sum
									val = ColAggs[col2].toString();
									break;
								case 3: // average
									val = (ColAggs[col2] / NbrRows).toString();
									break;
								case 4: // high value
									val = HiLowVal.toString() + ' (' + HiLowCol.toString() + ')';
									break;
								case 5: // low value
									val = HiLowVal.toString() + ' (' + HiLowCol.toString() + ')';
									break;
								case 11:
									val = ColAggs[col2].toString();
									break;
								case 13:
									val = (ColAggs[col2] / NbrRowsSel[col]).toString();
									break;
								default:
									break;
							}
						}
					}
					NewRow.appendChild(createNewCellDg(createObjIDDg((cellprfx + objid.toString()), 999, col), ht, '', val, bColor, fColor, '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', 'right', 'middle', jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, true, false, '', false, false, true, '', '', '', 0));
				}

				tbdy.appendChild(NewRow);
			}

			// append column footer
			if (jsDGbHasFooter === true) {
				for (var col3 = 0; col3 < NbrCols; col3++) {
					// get col ident string
					sCol = col3.toString();
					if (sCol.length === 1) { sCol = '0' + sCol; }
					if (jsDGColFtrData[col3][4] === '1') {
						switch (aggType) {
							case 1: // count
								val = ColAggs[col3].toString();
								break;
							case 2: // sum
								val = ColAggs[col3].toString();
								break;
							case 3: // average
								val = (ColAggs[col3] / NbrRows).toString();
								break;
							case 4: // high value
								val = HiLowVal.toString() + ' (' + HiLowCol.toString() + ')';
								break;
							case 5: // low value
								val = HiLowVal.toString() + ' (' + HiLowCol.toString() + ')';
								break;
							case 11:
								val = ColAggs[col3].toString();
								break;
							case 13:
								val = (ColAggs[col3] / NbrRowsSel[col3]).toString();
								break;
							default:
								break;
						}
					}
					else {
						val = jsDGColFtrData[col3][0].toString();
					}
					bld = false;
					if (jsDGFontBold || parseInt(jsDGColFtrData[col3][1], 10) === 1 || parseInt(jsDGColFtrData[col3][1], 10) === 3) { bld = true; }
					if (parseInt(jsDGColFtrData[col3][0], 10) === 2) { isItalic = true; }
					NewRow.appendChild(createNewCellDg(createObjIDDg('CFTR' + objid.toString(), 999, col), ht, '', val, jsDGColFtrData[col3][2], jsDGColFtrData[col3][3], '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', 'right', 'middle', jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, bld, isItalic, '', false, false, true, '', '', '', 0));
				}
				tbdy.appendChild(NewRow);
			}

			if (UsePageBar === true) {
				NewRow = GetPaginationFooterBarDg(nCol, '', 18, 0, jsDGPgnBColor, jsDGPgnTColor, '', objid);
				tbdy.appendChild(NewRow);
			}
			else {
				if (objid > 0) {
					switch (objid) {
						case 1:
							if (jiaNbrPagesPj[1] > 1) {
								joPaginationBarPj.style.display = 'block';
							}
							else {
								joPaginationBarPj.style.display = 'none';
							}
							break;
						case 2:
							if (jiaNbrPagesPj[2] > 1) {
								joPaginationBarPj2.style.display = 'block';
							}
							else {
								joPaginationBarPj2.style.display = 'none';
							}
							break;
						case 3:
							if (jiaNbrPagesPj[3] > 1) {
								joPaginationBarPj3.style.display = 'block';
							}
							else {
								joPaginationBarPj3.style.display = 'none';
							}
							break;
						case 4:
							if (jiaNbrPagesPj[4] > 1) {
								joPaginationBarPj4.style.display = 'block';
							}
							else {
								joPaginationBarPj4.style.display = 'none';
							}
							break;
						case 5:
							if (jiaNbrPagesPj[5] > 1) {
								joPaginationBarPj5.style.display = 'block';
							}
							else {
								joPaginationBarPj5.style.display = 'none';
							}
							break;
						case 6:
							if (jiaNbrPagesPj[6] > 1) {
								joPaginationBarPj6.style.display = 'block';
							}
							else {
								joPaginationBarPj6.style.display = 'none';
							}
							break;
						case 7:
							if (jiaNbrPagesPj[7] > 1) {
								joPaginationBarPj7.style.display = 'block';
							}
							else {
								joPaginationBarPj7.style.display = 'none';
							}
							break;
						case 8:
							if (jiaNbrPagesPj[8] > 1) {
								joPaginationBarPj8.style.display = 'block';
							}
							else {
								joPaginationBarPj8.style.display = 'none';
							}
							break;
						case 9:
							if (jiaNbrPagesPj[9] > 1) {
								joPaginationBarPj9.style.display = 'block';
							}
							else {
								joPaginationBarPj9.style.display = 'none';
							}
							break;
						case 10:
							if (jiaNbrPagesPj[10] > 1) {
								joPaginationBarPj10.style.display = 'block';
							}
							else {
								joPaginationBarPj10.style.display = 'none';
							}
							break;
						case 11:
							if (jiaNbrPagesPj[11] > 1) {
								joPaginationBarPj11.style.display = 'block';
							}
							else {
								joPaginationBarPj11.style.display = 'none';
							}
							break;
						case 12:
							if (jiaNbrPagesPj[12] > 1) {
								joPaginationBarPj12.style.display = 'block';
							}
							else {
								joPaginationBarPj12.style.display = 'none';
							}
							break;
						case 13:
							if (jiaNbrPagesPj[13] > 1) {
								joPaginationBarPj13.style.display = 'block';
							}
							else {
								joPaginationBarPj13.style.display = 'none';
							}
							break;
						case 14:
							if (jiaNbrPagesPj[14] > 1) {
								joPaginationBarPj14.style.display = 'block';
							}
							else {
								joPaginationBarPj14.style.display = 'none';
							}
							break;
						case 15:
							if (jiaNbrPagesPj[15] > 1) {
								joPaginationBarPj15.style.display = 'block';
							}
							else {
								joPaginationBarPj15.style.display = 'none';
							}
							break;
						case 16:
							if (jiaNbrPagesPj[16] > 1) {
								joPaginationBarPj16.style.display = 'block';
							}
							else {
								joPaginationBarPj16.style.display = 'none';
							}
							break;
						case 17:
							if (jiaNbrPagesPj[17] > 1) {
								joPaginationBarPj17.style.display = 'block';
							}
							else {
								joPaginationBarPj17.style.display = 'none';
							}
							break;
						case 18:
							if (jiaNbrPagesPj[18] > 1) {
								joPaginationBarPj18.style.display = 'block';
							}
							else {
								joPaginationBarPj18.style.display = 'none';
							}
							break;
						case 19:
							if (jiaNbrPagesPj[19] > 1) {
								joPaginationBarPj19.style.display = 'block';
							}
							else {
								joPaginationBarPj19.style.display = 'none';
							}
							break;
						case 20:
							if (jiaNbrPagesPj[20] > 1) {
								joPaginationBarPj20.style.display = 'block';
							}
							else {
								joPaginationBarPj20.style.display = 'none';
							}
							break;
						default:
							break;
					}
				}
			}

			// make drag icons draggable
			if (jsDGbShowDragIcon === true) {
				for (var rowDI=0;rowDI < NbrRows;rowDI++) {
					sRow = row.toString();
					if (sRow.length === 2) { sRow = '0' + sRow; }
					if (sRow.length === 1) { sRow = '00' + sRow; }
					setObjectDraggableWc('imgRDI' + sRow + objid.toString());
				}
			}

			msg = 'Okay ' + NbrRows.toString();
		} //NbrRows > 0
		else {
			if (objid > 0 && UsePageBar === false) {
				switch (objid) {
					case 1:
						joPaginationBarPj.style.display = 'none';
						break;
					case 2:
						joPaginationBarPj2.style.display = 'none';
						break;
					case 3:
						joPaginationBarPj3.style.display = 'none';
						break;
					case 4:
						joPaginationBarPj4.style.display = 'none';
						break;
					case 5:
						joPaginationBarPj5.style.display = 'none';
						break;
					case 6:
						joPaginationBarPj6.style.display = 'none';
						break;
					case 7:
						joPaginationBarPj7.style.display = 'none';
						break;
					case 8:
						joPaginationBarPj8.style.display = 'none';
						break;
					case 9:
						joPaginationBarPj9.style.display = 'none';
						break;
					case 10:
						joPaginationBarPj10.style.display = 'none';
						break;
					case 11:
						joPaginationBarPj11.style.display = 'none';
						break;
					case 12:
						joPaginationBarPj12.style.display = 'none';
						break;
					case 13:
						joPaginationBarPj13.style.display = 'none';
						break;
					case 14:
						joPaginationBarPj14.style.display = 'none';
						break;
					case 15:
						joPaginationBarPj15.style.display = 'none';
						break;
					case 16:
						joPaginationBarPj16.style.display = 'none';
						break;
					case 17:
						joPaginationBarPj17.style.display = 'none';
						break;
					case 18:
						joPaginationBarPj18.style.display = 'none';
						break;
					case 19:
						joPaginationBarPj19.style.display = 'none';
						break;
					case 20:
						joPaginationBarPj20.style.display = 'none';
						break;
					default:
						break;
				}
			}
			msg = 'No rows were found';
		}
	
		// insert new table over any old table inside parent object
		var oldBody = parentObj.getElementsByTagName("tbody")[0];
		parentObj.replaceChild(tbdy, oldBody);

	} //(colData !== undefined && colData !== null)
	else {
		if (objid > 0) {
			switch (objid && UsePageBar === false) {
				case 1:
					joPaginationBarPj.style.display = 'none';
					break;
				case 2:
					joPaginationBarPj2.style.display = 'none';
					break;
				case 3:
					joPaginationBarPj3.style.display = 'none';
					break;
				case 4:
					joPaginationBarPj4.style.display = 'none';
					break;
				case 5:
					joPaginationBarPj5.style.display = 'none';
					break;
				case 6:
					joPaginationBarPj6.style.display = 'none';
					break;
				case 7:
					joPaginationBarPj7.style.display = 'none';
					break;
				case 8:
					joPaginationBarPj8.style.display = 'none';
					break;
				case 9:
					joPaginationBarPj9.style.display = 'none';
					break;
				case 10:
					joPaginationBarPj10.style.display = 'none';
					break;
				case 11:
					joPaginationBarPj11.style.display = 'none';
					break;
				case 12:
					joPaginationBarPj12.style.display = 'none';
					break;
				case 13:
					joPaginationBarPj13.style.display = 'none';
					break;
				case 14:
					joPaginationBarPj14.style.display = 'none';
					break;
				case 15:
					joPaginationBarPj15.style.display = 'none';
					break;
				case 16:
					joPaginationBarPj16.style.display = 'none';
					break;
				case 17:
					joPaginationBarPj17.style.display = 'none';
					break;
				case 18:
					joPaginationBarPj18.style.display = 'none';
					break;
				case 19:
					joPaginationBarPj19.style.display = 'none';
					break;
				case 20:
					joPaginationBarPj20.style.display = 'none';
					break;
				default:
					break;
			}
		}
		msg = 'An error stopped data retrieval.';
	}
	return msg;
}

function IdentifyTargetRowDg(row, lastrow, objid) {
	var sRow = '';
	// empty old row
	if (lastrow > -1) {
		sRow = lastrow.toString();
		if (sRow.length === 2) {sRow = '0' + sRow;}
		if (sRow.length === 1) {sRow = '00' + sRow;}
		document.getElementById('CSRSL' + sRow + objid.toString()).innerHTML = '';
		document.getElementById('CSRSR' + sRow + objid.toString()).innerHTML = '';
	}
	// identify new row
	if (row > -1) {
		sRow = row.toString();
		if (sRow.length === 2) {sRow = '0' + sRow;}
		if (sRow.length === 1) {sRow = '00' + sRow;}
		document.getElementById('CSRSL' + sRow + objid.toString()).innerHTML = '&rArr;';
		document.getElementById('CSRSR' + sRow + objid.toString()).innerHTML = '&lArr;';
	}
	return false;
}

// ***************************************************************************************
// 12/9/2014 - forms and attaches a new body to an existing HTML table
function FormDataGridMultiRowDg(parentObj, cellprfx, altRowA, brdr, showtotalC, showrownm, AggLabel, NbrCols, NbrRowsEA, colData, colData2, colData3, ovrflw, vwCol, EdtCol, DelCol, idCol, vwColRw, EdtColRw, DelColRw, idColRw, lnk1Col, lnk2Col, lnk3Col, iPadDiv, addParamBar, bEdit, cellClass, IsLocked, UsePageBar, t1, objid) {
	// allows multiple rows of data per item - maximum of three rows - rowspn must be set for columns that have no data after row 1
	//alert('Fired!');
	var aggType = 0;
	var bColor = '';
	var bIsConstruct = false;
	var bld = false;
	var brdrL = '0px';
	var brdrR = '0px';
	var brdrT = '0px';
	var brdrB = '0px';
	var CastType = 0;
	var cellid = '';
	var ci = '';
	var colClass = 'T';
	var colID = '0';
	var colSpn = '';
	var colType = 0;
	var content = '';
	var SrcType = '';
	var dsabld = false;
	var fColor = jsDGforeColor;
	var fig = 0;
	var fmt = 0;
	var HiLowCol = 0;
	var HiLowFig = 0;
	var HiLowVal = '';
	var hOrient = '';
	var ht = '';
	var id = 0;
	var iPadCellDiv = 0;
	var iRow = 0;
	var isItalic = false;
	var iOverflow = 0;
	var iVal = 0;
	var iVanish = 0;
	var lastGrp1 = '';
	var lastGrp2 = '';
	var lastGrp3 = '';
	var msg = '';
	var nbrRow = 0;
	var nbrCol = 0;
	var nCol = 0;
	var NewRow;
	var NewRow2;
	var NewRow3;
	var RdOnly = false;
	var sAggValue = '';
	var sBlankVal = '';
	var sCol = '';
	var sCValue = '';
	var sObjType = '';
	var sPgNbr = '';
	var sRow = '';
	var sValue = '';
	var sVis = '';
	var t = 0;
	var tgl = 0;
	var uLimit = 0;
	var val = '';
	var val2 = '';
	var ValGrp1 = '';
	var ValGrp2 = '';
	var ValGrp3 = '';
	var vOrient = '';
	var wdth = 0;

	if (AggLabel === null) { AggLabel = 'Totals'; }
	if (colData !== undefined && colData !== null) {
		var tbdy = document.createElement("tbody");
		var NbrRows = colData.length;
		if (NbrRows > 0) {

			// handle pagination initiation
			if (objid > 0 && UsePageBar === false) {
				sPgNbr = (jiaPgNbrPj[objid] + 1).toString();
				jiaNbrPagesPj[objid] = parseInt(colData[0].NbrPages, 10);
				jiaNbrRowsPj[objid] = parseInt(colData[0].NbrRows, 10);
				switch (objid) {
					case 1:
						jotGotoPgNbrPj.value = '';
						joPgNbrLblPj.innerHTML = sPgNbr;
						joMaxPgNbrLblPj.innerHTML = jiaNbrPagesPj[1].toString();
						break;
					case 2:
						jotGotoPgNbrPj2.value = '';
						joPgNbrLblPj2.innerHTML = sPgNbr;
						joMaxPgNbrLblPj2.innerHTML = jiaNbrPagesPj[2].toString();
						break;
					case 3:
						jotGotoPgNbrPj3.value = '';
						joPgNbrLblPj3.innerHTML = sPgNbr;
						joMaxPgNbrLblPj3.innerHTML = jiaNbrPagesPj[3].toString();
						break;
					case 4:
						jotGotoPgNbrPj4.value = '';
						joPgNbrLblPj4.innerHTML = sPgNbr;
						joMaxPgNbrLblPj4.innerHTML = jiaNbrPagesPj[4].toString();
						break;
					case 5:
						jotGotoPgNbrPj5.value = '';
						joPgNbrLblPj5.innerHTML = sPgNbr;
						joMaxPgNbrLblPj5.innerHTML = jiaNbrPagesPj[5].toString();
						break;
					case 6:
						jotGotoPgNbrPj6.value = '';
						joPgNbrLblPj6.innerHTML = sPgNbr;
						joMaxPgNbrLblPj6.innerHTML = jiaNbrPagesPj[6].toString();
						break;
					case 7:
						jotGotoPgNbrPj7.value = '';
						joPgNbrLblPj7.innerHTML = sPgNbr;
						joMaxPgNbrLblPj6.innerHTML = jiaNbrPagesPj[7].toString();
						break;
					case 8:
						jotGotoPgNbrPj8.value = '';
						joPgNbrLblPj8.innerHTML = sPgNbr;
						joMaxPgNbrLblPj8.innerHTML = jiaNbrPagesPj[8].toString();
						break;
					case 9:
						jotGotoPgNbrPj9.value = '';
						joPgNbrLblPj9.innerHTML = sPgNbr;
						joMaxPgNbrLblPj9.innerHTML = jiaNbrPagesPj[9].toString();
						break;
					case 10:
						jotGotoPgNbrPj10.value = '';
						joPgNbrLblPj10.innerHTML = sPgNbr;
						joMaxPgNbrLblPj10.innerHTML = jiaNbrPagesPj[10].toString();
						break;
					case 11:
						jotGotoPgNbrPj11.value = '';
						joPgNbrLblPj11.innerHTML = sPgNbr;
						joMaxPgNbrLblPj11.innerHTML = jiaNbrPagesPj[11].toString();
						break;
					case 12:
						jotGotoPgNbrPj12.value = '';
						joPgNbrLblPj12.innerHTML = sPgNbr;
						joMaxPgNbrLblPj12.innerHTML = jiaNbrPagesPj[12].toString();
						break;
					case 13:
						jotGotoPgNbrPj13.value = '';
						joPgNbrLblPj13.innerHTML = sPgNbr;
						joMaxPgNbrLblPj13.innerHTML = jiaNbrPagesPj[13].toString();
						break;
					case 14:
						jotGotoPgNbrPj14.value = '';
						joPgNbrLblPj14.innerHTML = sPgNbr;
						joMaxPgNbrLblPj14.innerHTML = jiaNbrPagesPj[14].toString();
						break;
					case 15:
						jotGotoPgNbrPj15.value = '';
						joPgNbrLblPj15.innerHTML = sPgNbr;
						joMaxPgNbrLblPj15.innerHTML = jiaNbrPagesPj[15].toString();
						break;
					case 16:
						jotGotoPgNbrPj16.value = '';
						joPgNbrLblPj16.innerHTML = sPgNbr;
						joMaxPgNbrLblPj16.innerHTML = jiaNbrPagesPj[16].toString();
						break;
					case 17:
						jotGotoPgNbrPj17.value = '';
						joPgNbrLblPj17.innerHTML = sPgNbr;
						joMaxPgNbrLblPj17.innerHTML = jiaNbrPagesPj[17].toString();
						break;
					case 18:
						jotGotoPgNbrPj18.value = '';
						joPgNbrLblPj18.innerHTML = sPgNbr;
						joMaxPgNbrLblPj18.innerHTML = jiaNbrPagesPj[18].toString();
						break;
					case 19:
						jotGotoPgNbrPj19.value = '';
						joPgNbrLblPj19.innerHTML = sPgNbr;
						joMaxPgNbrLblPj19.innerHTML = jiaNbrPagesPj[19].toString();
						break;
					case 20:
						jotGotoPgNbrPj20.value = '';
						joPgNbrLblPj20.innerHTML = sPgNbr;
						joMaxPgNbrLblPj20.innerHTML = jiaNbrPagesPj[20].toString();
						break;
					default:
						break;
				}
			}

			// create columns and insert data
			var ColAggs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var NbrRowsSel = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

			// establish grid cell borders
			if (brdr.length > 0) {
				brdrB = brdr;
				brdrL = brdr;
				brdrR = brdr;
				brdrT = brdr;
			}
			if (jsDGbrdrB !== '0px') { brdrB = jsDGbrdrB; }
			if (jsDGbrdrL !== '0px') { brdrL = jsDGbrdrL; }
			if (jsDGbrdrR !== '0px') { brdrR = jsDGbrdrR; }
			if (jsDGbrdrT !== '0px') { brdrT = jsDGbrdrT; }

			//alert('Param Bar');
			if (addParamBar === true) {
				NewRow = document.createElement("tr");
				if (showrownm === true) {
					NewRow.appendChild(createNewCellDg(createObjIDDg(cellprfx + 'RNPA', 0, 0), jsDGCellHt, '50px', '', '#000000', '#000000', brdr, brdr, brdr, brdr, 'center', 'top', jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, true, '', '', '', '', '', '', '', 0));
				}
				for (var colZ = 0; colZ < NbrCols; colZ++) {
					sCol = colZ.toString();
					if (sCol.length === 1) { sCol = '0' + sCol; }
					bColor = jsDGbgPrmColor;
					wdth = parseInt(jsDGColDataN[colZ][0], 10);
					hOrient = jsDGColDataT[colZ][1].toString();
					sVis = jsDGColDataT[colZ][4].toString();
					ht = jsDGCellHt;
					if (fmt.substr(0, 2) === 'ht') { ht = fmt.substr(2, 4); }
					val = '';
					if (jsDGColDataN[colZ][7] === 1) {
						val = '<input type="text" id="txtDGParamCol' + sCol + 'o' + objid.toString() + '" value="" style="border:0px;width=' + wdth.toString() + 'px' + 'px;color=' + jsDGforePrmColor + ';background-color:' + jsDGbgPrmColor + ';" />';
					}
					else {
						bColor = '#000000';
					}
					NewRow.appendChild(createNewCellDg(createObjIDDg(cellprfx + 'RNPA', 0, 0), ht, wdth.toString() + 'px', val, bColor, jsDGforePrmColor, brdr, hOrient, 'top', jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, true, '', '', '', sVis, '', '', '', 0));
				}
				tbdy.appendChild(NewRow);
			}

			nCol = NbrCols;
			if (showrownm === true) { nCol++; }

			//alert('Handling data rows');
			// ****************************************************************************************************************
			for (var row = 0; row < NbrRows; row++) {
				NewRow = document.createElement("tr");
				if (NbrRowsEA > 1) {
					NewRow2 = document.createElement("tr");
				}
				if (NbrRowsEA > 2) {
					NewRow3 = document.createElement("tr");
				}
				sRow = row.toString();
				if (sRow.length === 2) { sRow = '0' + sRow; }
				if (sRow.length === 1) { sRow = '00' + sRow; }
				if (idCol > 0) { id = parseInt(colData[row][idCol - 1], 10); }

				// - - - - - - - INSERT ROW - - - - - - -					
				if (jsDGbShowRowSel === true) {
					NewRow.appendChild(createNewCellDg('CSMRSL' + sRow + objid.toString(), jsDGCellHt, '40px', '', bColor, fColor, brdrL, brdrR, brdrT, brdrB, 'right', 'middle', jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, true, false, '', '', '', '', '', cellClass, '', 0));
				}

				// show row number cell if necessary
				if (showrownm === true) {
					NewRow.appendChild(createNewCellDg(createObjIDDg(cellprfx + 'RN' + objid.toString(), row, 0), jsDGCellHt, '50px', row.toString(), bColor, fColor, brdr, brdr, brdr, brdr, 'center', 'top', jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, true, false, '', '', '', '', '', cellClass, '', 0));
				}
				// show Drag Icon if necessary
				if (jsDGbShowDragIcon === true) {
					ci = '<img id="imgRDI' + sRow + objid.toString() + '" src="../Images/build.gif" style="width:12px;height:12px;" />';
					NewRow.appendChild(createNewCellDg(createObjIDDg(cellprfx + 'RDI' + objid.toString(), row, 0), jsDGCellHt, '40px', ci, bColor, fColor, brdrL, brdrR, brdrT, brdrB, 'center', 'middle', jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, true, false, '', '', '', '', '', cellClass, '', 0));
				}
				if (jsDGbShowClickCol === true) {
					ci = '<input type="checkbox" id="chkSelRow' + sRow + objid.toString() + '" />';
					NewRow.appendChild(createNewCellDg(createObjIDDg(cellprfx + 'CSR' + objid.toString(), row, 0), jsDGCellHt, '40px', ci, bColor, fColor, brdrL, brdrR, brdrT, brdrB, 'center', 'middle', jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, true, false, '', '', '', '', '', cellClass, '', 0));
				}

				ValGrp1 = '';
				ValGrp2 = '';
				ValGrp3 = '';

				//alert('Handling columns');
				for (var col = 0; col < NbrCols; col++) {
					// get col ident string
					colSpn = '';
					sCol = col.toString();
					sValue = '';
					val = '';
					content = '';
					if (sCol.length === 1) { sCol = '0' + sCol; }
					colSpn = jsDGColDataMCN[nCol][17][0].toString();

					for (var col2 = 0; col2 < NbrRowsEA; col2++) {
						bIsConstruct = false;
						sCValue = '';
						if (parseInt(colSpn, 10) < 2) {
							colSpn = '';
						}

						// add column cell if there is no rowspan set and row > 1
						if (col2 === 1 || colSpn === '') {
							// get value from mapped column
							colID = jsDGColDataMCT[col][0][col2].toString(); //colMap[col].toString();
							SrcType = jsDGColDataMCT[col][20][col2].toString().toLowerCase();
							fmt = jsDGColDataMCT[col][3][col2].toString(); // colFmt[col].toString();
							bColor = jsDGbgColor;
							fColor = jsDGforeColor;
							ht = jsDGCellHt;
							switch (col2) {
								case 1:
									sCValue = colData[row][colID].toString();
									break;
								case 2:
									sCValue = colData2[row][colID].toString();
									break;
								case 3:
									sCValue = colData3[row][colID].toString();
									break;
								default:
									break;
							}

							switch (SrcType) {
								case 'x': // construct
									bIsConstruct = true;
									sObjType = fmt.replace('Constr: ', '');
									sValue = '';
									switch (sObjType) {
										case 'Input':
											sValue = '<input type="text" id="txtVR' + sRow + 'C' + sCol + '" value="' + sCValue + '"/>';
											break;
										case 'Checkbox':
											sValue = '<input type="checkbox" id="chkVR' + sRow + 'C' + sCol + '" value="' + sCValue + '"/>';
											break;
										case 'Radio':
											val = jsDGColDataT[nCol][14].toString();
											sValue = '<input type="radio" id="radVR' + sRow + 'C' + sCol + '" name="radVR' + sRow + val + '" value="' + sCValue + '"/>';
											break;
										case 'Image':
											wdth = parseInt(jsDGColDataN[col][0], 10) - 1;
											sValue = '<img id="imgR' + sRow + 'C' + sCol + '" src="' + sCValue + '" style="width:' + wdth.toString() + 'px;height:' + (ht - 1).toString() + 'px;" />';
											break;
										default:
											break;
									}
								case 't': // text only
									sValue = colID; // just text to show
									break;
								default:
									sValue = sCValue;
									break;
							}

							iPadCellDiv = parseInt(jsDGColDataMCN[col][13][col2], 10);
							//alert(sValue);
							iVanish = parseInt(jsDGColDataMCN[col][8][col2], 10);
							sBlankVal = jsDGColDataMCT[col][10][col2].toString();

							aggType = parseInt(jsDGColDataMCN[col][5][col2], 10); // colAgg[col], 10);
							if (aggType > 0) { sAggValue = sValue; }
							if (sAggValue === null) { sAggValue = ''; }

							// blank value if necessary
							if (sValue === sBlankVal) {
								sValue = '';
							}

							// clean data
							t = parseInt(jsDGColDataN[col][20], 10);
							if (t > 0) { sValue = PrepareHTMLForViewTx(sValue, t-1);}

							CastType = parseInt(jsDGColDataMCN[col][2][col2], 10);
							if (sValue !== '' && SrcType !== 'x') {
								fig = 0;
								colClass = 'T';
								//0-text, 1-textCODE, 2-int, 3-numeric, 4-money, 5-bool, 6-date, 7-datetime, 8-time, 9-email, 10-phonenbr
								colType = parseInt(jsDGColDataMCN[col][1][col2], 10);
								switch (colType) {
									case 2:
										sValue = parseInt(sValue, 10).toString();
										colClass = 'N';
										break;
									case 3:
										sValue = parseFloat(sValue).toString();
										colClass = 'N';
										break;
									case 4:
										sValue = parseFloat(sValue).toString();
										colClass = 'N';
										break;
									default:
										// nothing
										break;
								}

								// cast into specific string if necessary
								if (CastType > 0) {
									content = setStringFormatDg(sValue, CastType);
								}
								else {
									content = sValue;
								}
							}

							// set row group values if grouping is set - Grouping must be set on data in LINE 1
							if (jsDGColDataN[col][11][col2] == 1 && ValGrp1 === '') { ValGrp1 = sValue; }
							if (jsDGColDataN[col][11][col2] == 2 && ValGrp2 === '') { ValGrp2 = sValue; }
							if (jsDGColDataN[col][11][col2] == 3 && ValGrp3 === '') { ValGrp3 = sValue; }

							// ------------------------------------------------------------------------------
							// set special formatting if necessary
							if (bIsConstruct === false) {
								if (fmt.substr(0, 2) === 'bc') { bColor = fmt.substr(2, 7); }
								if (altRowA === true) {
									if (tgl === 0) {
										tgl = 1;
									}
									else {
										bColor = jsDGTglColor;
										tgl = 0;
									}
								}
								if (fmt.substr(0, 2) === 'fc') { fColor = fmt.substr(2, 7); }
								if (fmt.substr(0, 2) === 'ht') { ht = fmt.substr(2, 4); }
							}

							// highlight text in highlight color if it exceeds threshold
							if (sValue !== '') {
								if (jsDGColDataN[col][3][col2] === 1) {
									//alert('Fired! ' + jsDGHighlightColor + '/' + colClass);
									if (colClass === 'N') {
										if (jsDGColDataN[col][3][col2] === 1) {
											uLimit = parseFloat(jsDGColDataN[col][4][col2]);
											//alert('Fired! ' + jsDGHighlightColor + '/' + uLimit);
											if (parseFloat(sValue) < uLimit) {
												fColor = jsDGHighlightColor;
											}
										}
										if (colClass === 'T') {
											val2 = jsDGColDataN[col][4][col2].toString();
											if (val < val2) {
												fColor = jsDGHighlightColor;
											}
										}
									}
								}
							}

							// ------------------------------------------------------------------------------
							// set global format items
							bld = false;
							if (jsDGFontBold || fmt === 'bold' || parseInt(jsDGColDataN[col][16][col2], 10) === 1) { bld = true; }
							if (parseInt(jsDGColDataN[col][16][col2], 10) === 2) { isItalic = true; }
							dsabld = false;
							if (fmt === 'disabled') { dsabld = true; }
							RdOnly = false;
							if (fmt === 'readonly') { RdOnly = true; }

							// ------------------------------------------------------------------------------
							// set aggregation
							if (aggType > 0 && sAggValue.length > 0) {
								switch (aggType) {
									case 1: // count
										ColAggs[col]++;
										NbrRowsSel[col]++;
										break;
									case 2: // sum
										if (colClass === 'N') {
											fig = parseFloat(sAggValue);
											ColAggs[col] = ColAggs[col] + fig;
										}
										NbrRowsSel[col]++;
										break;
									case 3: // average
										if (colClass === 'N') {
											fig = parseFloat(sAggValue);
											ColAggs[col] = ColAggs[col] + fig;
										}
										NbrRowsSel[col]++;
										break;
									case 4: // high value
										if (colClass === 'N') {
											fig = parseFloat(sAggValue);
											if (fig > HiLowFig) {
												HiLowFig = fig;
												HiLowCol = col;
											}
										}
										else {
											if (sAggValue > HiLowVal) {
												HiLowVal = sAggValue;
												HiLowCol = col;
											}
										}
										break;
									case 5: // low value
										if (colClass === 'N') {
											fig = parseFloat(sAggValue);
											if (fig < HiLowFig) {
												HiLowFig = fig;
												HiLowCol = col;
											}
										}
										else {
											if (sAggValue < HiLowVal) {
												HiLowVal = sAggValue;
												HiLowCol = col;
											}
										}
										break;
									case 11: //count no zero/empty
										if (colClass === 'N') {
											fig = parseFloat(sAggValue);
											if (fig > 0) {
												ColAggs[col]++;
												NbrRowsSel[col]++;
											}
										}
										else {
											ColAggs[col]++;
											NbrRowsSel[col]++;
										}
										break;
									case 13: //average no zero/empty
										if (colClass === 'N') {
											fig = parseFloat(sAggValue);
											if (fig > 0) {
												ColAggs[col] = ColAggs[col] + fig;
												NbrRowsSel[col]++;
											}
										}
										break;
									default:
										break;
								}
							}

							// ------------------------------------------------------------------------------
							// setting common formatting values
							wdth = parseInt(jsDGColDataN[col][0][col2], 10);
							hOrient = jsDGColDataT[col][1][col2].toString();
							vOrient = jsDGColDataT[col][2][col2].toString();
							sVis = jsDGColDataT[col][4][col2].toString();
							if (ht !== '') {
								if (ht.indexOf('px') < 1) { ht = ht + 'px'; }
							}
							iOverflow = parseInt(jsDGColDataN[col][12][col2], 10);
							//alert('Forming content - ' + bEdit);
							if (iOverflow > 0 || iPadCellDiv > 0 || iPadDiv > 0) {
								val2 = '<div id="divTC' + sRow + sCol + '" style="display:inline-table;width:99%;height:' + ht + ';';
								// set padding
								iVal = iPadDiv;
								if (iPadCellDiv > 0) { iVal = iPadCellDiv; }
								switch (iVal) {
									case 1:
										val2 = val2 + 'padding-left:2px;padding-right:2px;';
										wdth = wdth + 4;
										break;
									case 2:
										val2 = val2 + 'padding-left:2px;padding-right:2px;padding-top:1px;padding-bottom:1px;';
										wdth = wdth + 4;
										break;
									case 3:
										val2 = val2 + 'padding-left:4px;padding-right:4px;';
										wdth = wdth + 8;
										break;
									case 4:
										val2 = val2 + 'padding-left:4px;padding-right:4px;padding-top:1px;padding-bottom:1px;';
										wdth = wdth + 8;
										break;
									default:
										// do nothing
										break;
								}

								// set content overflow
								switch (iOverflow) {
									case 1:
										val2 = val2 + 'white-space:nowrap;overflow:hidden;';
										break;
									case 2:
										val2 = val2 + 'white-space:nowrap;overflow:hidden;text-overflow:clip;';
										break;
									default:
										// do nothing
										break;
								}
								content = val2 + '">' + content;
							}

							// ------------------------------------------------------------------------------
							// Content only contains value at this point - if to be placed in a control for editing, insert it now: typ = parseInt(jsDGColDataN[col][2])
							if ((bEdit === true && IsLocked === false && parseInt(jsDGColDataN[col][14][col2], 10) > 0) && SrcType === 'd') {
								// if the column can be edited, put value in an input textbox or checkbox
								if (typ < 300) {
									content = '<input type="text" id="' + cellprfx + 'X' + sRow + sCol + '" style="width:' + wdth.toString() + 'px;" value="' + content + '" />';
								}
								else {
									switch (typ) {
										case 300:
											val = 'false';
											if (content === '1' || content.toLowerCase() === 'true' || content.toLowerCase() === 'yes') { val = 'true'; }
											content = '<input type="checkbox" id="' + cellprfx + 'CK' + sRow + sCol + '" checked="' + val + '" />';
											break;
										default:
											break;
									}
								}
							}

							// ------------------------------------------------------------------------------
							// add hyperlink if turned on
							if (jsDGColDataN[col][15][col2] === 1 && content !== '') {
								var hlid = 0;
								var h1 = '';
								var h2 = '';
								var h3 = '';
								var hval = '';
								var ccontent = '<a href="#" onclick="javascript:ActivateHyperlink(' + id.toString() + ',' + objid.toString() + ',';
								if (jsDGColDataT[col][11][col2].length > 0) {
									hval = sValue = colData[row][jsDGColDataT[col][11][col2].toString()].toString();
									ccontent = ccontent + "'" + hval + "',";
									if (jsDGColDataT[col][12][col2].length > 0) {
										hval = sValue = colData[row][jsDGColDataT[col][12][col2].toString()].toString();
										ccontent = ccontent + "'" + hval + "',";
										if (jsDGColDataT[col][13][col2].length > 0) {
											hval = sValue = colData[row][jsDGColDataT[col][12][col2].toString()].toString();
											ccontent = ccontent + "'" + hval + "'";
										}
										else {
											ccontent = ccontent + "''";
										}
									}
									else {
										ccontent = ccontent + "'', ''";
									}
								}
								else {
									ccontent = ccontent + "'', '', ''";
								}
								ccontent = ccontent + ');return false;">';
								content = ccontent + content + '<a>';
							}

							// add any special event buttons
							if (vwCol === col + 1) {
								content = content + '<a id="hlv' + sRow + '" style="width:40px;height:20px;line-height:16px;" href="#" onclick="javascript:ViewOneRec(' + id.toString() + ',' + row.toString() + ',' + objid.toString() + ');">View</a>';
							}
							if (EdtCol === col + 1 && IsLocked === false) {
								content = content + '<a id="hle' + sRow + '" style="width:40px;height:20px;line-height:16px;" href="#" onclick="javascript:EditOneRec(' + id.toString() + ',' + row.toString() + ',' + objid.toString() + ');">Edit</a>';
							}
							if (DelCol === col + 1 && IsLocked === false) {
								content = content + '<a id="hld' + sRow + '" style="width:32px;height:20px;line-height:16px;" href="#" onclick="javascript:DeleteOneRec(' + id.toString() + ',' + row.toString() + ',' + objid.toString() + ');">Del</a>';
							}
							// END padded div if necessary
							if (iPadDiv > 0) { content = content + '</div>'; }

							// ------------------------------------------------------------------------------
							cellid = createObjIDDg(cellprfx + objid.toString(), row, col);
							//alert('Adding column - ID ' + val + '/' + ht + '/' + wdth.toString() + 'px/' + content + '/' + bColor + '/' + fColor + '/' + brdr + '/' + hOrient + '/' + vOrient);
							//alert('Adding column - ' + jsDGCellPadL + '/' + jsDGCellPadR + '/' + jsDGCellPadT + '/' + jsDGCellPadB + '/' + jsDGFontSz + '/' + bld + '/' + ovrflw + '/' + RdOnly + '/' + dsabld + '/' + sVis);
							// create column and fill it

							switch (col2) {
								case 0:
									NewRow.appendChild(createNewCellDg(cellid, ht, wdth.toString + 'px', content, bColor, fColor, brdrL, brdrR, brdrT, brdrB, hOrient, vOrient, jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, bld, isItalic, ovrflw, RdOnly, dsabld, sVis, '', cellClass, '', 0));
									break;
								case 1:
									NewRow2.appendChild(createNewCellDg(cellid, ht, wdth.toString + 'px', content, bColor, fColor, brdrL, brdrR, brdrT, brdrB, hOrient, vOrient, jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, bld, isItalic, ovrflw, RdOnly, dsabld, sVis, '', cellClass, '', 0));
									break;
								case 2:
									NewRow3.appendChild(createNewCellDg(cellid, ht, wdth.toString + 'px', content, bColor, fColor, brdrL, brdrR, brdrT, brdrB, hOrient, vOrient, jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, bld, isItalic, ovrflw, RdOnly, dsabld, sVis, '', cellClass, '', 0));
									break;
								default:
									break;
							}

						}
					}
				}

				// append a group separator row if necessary
				val = '';
				bld = false;
				brdr = '';
				if (jsDGGroups[0] > 0) {
					if (lastGrp1 !== ValGrp1) {
						val = 'Group 1: ' + jsDGGroupData[0][0] + '-Value: ' + ValGrp1;
						if (jsDGGroupData[0][3].length > 0) { bld = true; }
						if (jsDGGroupData[0][6].length > 0) {
							brdr = jsDGGroupData[0][6] + 'px solid ' + jsDGGroupData[0][7];
						}
						tbdy.appendChild(FormGridSeperatorLineDg(nCol, row, objid, '1', val, jsDGGroupData[0][5], jsDGGroupData[0][1], jsDGGroupData[0][2], brdr, jsDGGroupData[0][4], bld));
						lastGrp1 = ValGrp1;
						lastGrp2 = ValGrp2;
						lastGrp3 = ValGrp3;
					}
					else {
						if (jsDGGroups[1] > 0) {
							if (lastGrp2 !== ValGrp2) {
								if (jsDGGroupData[1][3].length > 0) { bld = true; }
								val = 'Group 2: ' + jsDGGroupData[1][0] + '-Value: ' + ValGrp2;
								if (jsDGGroupData[1][6].length > 0) {
									brdr = jsDGGroupData[1][6] + 'px solid ' + jsDGGroupData[1][7];
								}
								tbdy.appendChild(FormGridSeperatorLineDg(nCol, row, objid, '2', val, jsDGGroupData[1][5], jsDGGroupData[1][1], jsDGGroupData[1][2], brdr, jsDGGroupData[1][4], bld));
								lastGrp2 = ValGrp2;
								lastGrp3 = ValGrp3;
							}
							else {
								if (jsDGGroups[2] > 0) {
									if (lastGrp3 !== ValGrp3) {
										if (jsDGGroupData[2][3].length > 0) { bld = true; }
										val = 'Group 3: ' + jsDGGroupData[2][0] + '-Value: ' + ValGrp3;
										if (jsDGGroupData[2][6].length > 0) {
											brdr = jsDGGroupData[2][6] + 'px solid ' + jsDGGroupData[2][7];
										}
										tbdy.appendChild(FormGridSeperatorLineDg(nCol, row, objid, '3', val, jsDGGroupData[2][5], jsDGGroupData[2][1], jsDGGroupData[2][2], brdr, jsDGGroupData[2][4], bld));
										lastGrp3 = ValGrp3;
									}
								}
							}
						}
					}
				}

				if (jsDGbShowRowSel === true) {
					NewRow.appendChild(createNewCellDg(createObjIDDg('CSMRSR' + sRow + objid.toString()), jsDGCellHt, '40px', '', bColor, fColor, brdrL, brdrR, brdrT, brdrB, 'left', 'middle', jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, true, false, '', '', '', '', '', cellClass, '', 0));
				}

				// Append row 1 to body
				tbdy.appendChild(NewRow);
				// Append row 2 to body
				if (NbrRowsEA > 1) {
					tbdy.appendChild(NewRow2);
				}
				// Append row 3 to body
				if (NbrRowsEA > 2) {
					tbdy.appendChild(NewRow3);
				}
			}
			//alert('Row handling completed');

			// ****************************************************************************************************************
			// show totals row if set
			if (showtotalC === true) {
				NewRow = document.createElement("tr");
				if (showrownm === true) {
					NewRow.appendChild(createNewCellDg(createObjIDDg(cellprfx + 'RN' + objid.toString(), 999, 0), jsDGCellHt, '50px', 'TTL', bColor, fColor, brdrL, brdrR, brdrT, brdrB, 'center', 'top', jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, true, false, '', '', '', '', '', '', '', 0));
				}
				for (var colx2 = 0; colx2 < NbrCols; colx2++) {
					val = '';
					if (colx2 === 0) {
						val = AggLabel;
					}
					else {
						aggType = parseInt(jsDGColDataN[col2][5], 10);
						if (aggType > 0) {
							switch (aggType) {
								case 1: // count
									val = ColAggs[colx2].toString();
									break;
								case 2: // sum
									val = ColAggs[colx2].toString();
									break;
								case 3: // average
									val = (ColAggs[colx2] / NbrRows).toString();
									break;
								case 4: // high value
									val = HiLowVal.toString() + ' (' + HiLowCol.toString() + ')';
									break;
								case 5: // low value
									val = HiLowVal.toString() + ' (' + HiLowCol.toString() + ')';
									break;
								case 11:
									val = ColAggs[colx2].toString();
									break;
								case 13:
									val = (ColAggs[colx2] / NbrRowsSel[col]).toString();
									break;
								default:
									break;
							}
						}
					}
					NewRow.appendChild(createNewCellDg(createObjIDDg(cellprfx + objid.toString(), 999, col), ht, '', val, bColor, fColor, '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', 'right', 'middle', jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, true, false, '', false, false, true, '', '', '', 0));
				}
				tbdy.appendChild(NewRow);
			}

			// append column footer
			if (jsDGbHasFooter === true) {
				for (var col3 = 0; col3 < NbrCols; col3++) {
					// get col ident string
					sCol = col3.toString();
					if (sCol.length === 1) { sCol = '0' + sCol; }
					if (jsDGColFtrData[col3][4] === '1') {
						switch (aggType) {
							case 1: // count
								val = ColAggs[col3].toString();
								break;
							case 2: // sum
								val = ColAggs[col3].toString();
								break;
							case 3: // average
								val = (ColAggs[col3] / NbrRows).toString();
								break;
							case 4: // high value
								val = HiLowVal.toString() + ' (' + HiLowCol.toString() + ')';
								break;
							case 5: // low value
								val = HiLowVal.toString() + ' (' + HiLowCol.toString() + ')';
								break;
							case 11:
								val = ColAggs[col3].toString();
								break;
							case 13:
								val = (ColAggs[col3] / NbrRowsSel[col3]).toString();
								break;
							default:
								break;
						}
					}
					else {
						val = jsDGColFtrData[col3][0].toString();
					}
					bld = false;
					if (jsDGFontBold || parseInt(jsDGColFtrData[col3][1], 10) === 1 || parseInt(jsDGColFtrData[col3][1], 10) === 3) { bld = true; }
					if (parseInt(jsDGColFtrData[col3][0], 10) === 2) { isItalic = true; }
					NewRow.appendChild(createNewCellDg(createObjIDDg('CFTR' + objid.toString(), 999, col), ht, '', val, jsDGColFtrData[col3][2], jsDGColFtrData[col3][3], '1px solid gray', '1px solid gray', '1px solid gray', '1px solid gray', 'right', 'middle', jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, bld, isItalic, '', false, false, true, '', '', '', 0));
				}

				tbdy.appendChild(NewRow);
			}

			if (UsePagBar === true) {
				NewRow = GetPaginationFooterBarDg(nCol, '', 18, 0, jsDGPgnBColor, jsDGPgnTColor, '', objid);
				tbdy.appendChild(NewRow);
			}
			else {
				if (objid > 0) {
					switch (objid) {
						case 1:
							if (jiaNbrPagesPj[1] > 1) {
								joPaginationBarPj.style.display = 'block';
							}
							else {
								joPaginationBarPj.style.display = 'none';
							}
							break;
						case 2:
							if (jiaNbrPagesPj[2] > 1) {
								joPaginationBarPj2.style.display = 'block';
							}
							else {
								joPaginationBarPj2.style.display = 'none';
							}
							break;
						case 3:
							if (jiaNbrPagesPj[3] > 1) {
								joPaginationBarPj3.style.display = 'block';
							}
							else {
								joPaginationBarPj3.style.display = 'none';
							}
							break;
						case 4:
							if (jiaNbrPagesPj[4] > 1) {
								joPaginationBarPj4.style.display = 'block';
							}
							else {
								joPaginationBarPj4.style.display = 'none';
							}
							break;
						case 5:
							if (jiaNbrPagesPj[5] > 1) {
								joPaginationBarPj5.style.display = 'block';
							}
							else {
								joPaginationBarPj5.style.display = 'none';
							}
							break;
						case 6:
							if (jiaNbrPagesPj[6] > 1) {
								joPaginationBarPj6.style.display = 'block';
							}
							else {
								joPaginationBarPj6.style.display = 'none';
							}
							break;
						case 7:
							if (jiaNbrPagesPj[7] > 1) {
								joPaginationBarPj7.style.display = 'block';
							}
							else {
								joPaginationBarPj7.style.display = 'none';
							}
							break;
						case 8:
							if (jiaNbrPagesPj[8] > 1) {
								joPaginationBarPj8.style.display = 'block';
							}
							else {
								joPaginationBarPj8.style.display = 'none';
							}
							break;
						case 9:
							if (jiaNbrPagesPj[9] > 1) {
								joPaginationBarPj9.style.display = 'block';
							}
							else {
								joPaginationBarPj9.style.display = 'none';
							}
							break;
						case 10:
							if (jiaNbrPagesPj[10] > 1) {
								joPaginationBarPj10.style.display = 'block';
							}
							else {
								joPaginationBarPj10.style.display = 'none';
							}
							break;
						case 11:
							if (jiaNbrPagesPj[11] > 1) {
								joPaginationBarPj11.style.display = 'block';
							}
							else {
								joPaginationBarPj11.style.display = 'none';
							}
							break;
						case 12:
							if (jiaNbrPagesPj[12] > 1) {
								joPaginationBarPj12.style.display = 'block';
							}
							else {
								joPaginationBarPj12.style.display = 'none';
							}
							break;
						case 13:
							if (jiaNbrPagesPj[13] > 1) {
								joPaginationBarPj13.style.display = 'block';
							}
							else {
								joPaginationBarPj13.style.display = 'none';
							}
							break;
						case 14:
							if (jiaNbrPagesPj[14] > 1) {
								joPaginationBarPj14.style.display = 'block';
							}
							else {
								joPaginationBarPj14.style.display = 'none';
							}
							break;
						case 15:
							if (jiaNbrPagesPj[15] > 1) {
								joPaginationBarPj15.style.display = 'block';
							}
							else {
								joPaginationBarPj15.style.display = 'none';
							}
							break;
						case 16:
							if (jiaNbrPagesPj[16] > 1) {
								joPaginationBarPj16.style.display = 'block';
							}
							else {
								joPaginationBarPj16.style.display = 'none';
							}
							break;
						case 17:
							if (jiaNbrPagesPj[17] > 1) {
								joPaginationBarPj17.style.display = 'block';
							}
							else {
								joPaginationBarPj17.style.display = 'none';
							}
							break;
						case 18:
							if (jiaNbrPagesPj[18] > 1) {
								joPaginationBarPj18.style.display = 'block';
							}
							else {
								joPaginationBarPj18.style.display = 'none';
							}
							break;
						case 19:
							if (jiaNbrPagesPj[19] > 1) {
								joPaginationBarPj19.style.display = 'block';
							}
							else {
								joPaginationBarPj19.style.display = 'none';
							}
							break;
						case 20:
							if (jiaNbrPagesPj[20] > 1) {
								joPaginationBarPj20.style.display = 'block';
							}
							else {
								joPaginationBarPj20.style.display = 'none';
							}
							break;
						default:
							break;
					}
				}
			}

			// make drag icons draggable
			if (jsDGbShowDragIcon === true) {
				for (var rowDI=0;rowDI < NbrRows;rowDI++) {
					sRow = row.toString();
					if (sRow.length === 2) { sRow = '0' + sRow; }
					if (sRow.length === 1) { sRow = '00' + sRow; }
					setObjectDraggableWc('imgRDI' + sRow + objid.toString());
				}
			}

			msg = 'Okay ' + NbrRows.toString();
		} //NbrRows > 0
		else {
			if (objid > 0 && UsePageBar === false) {
				switch (objid) {
					case 1:
						joPaginationBarPj.style.display = 'none';
						break;
					case 2:
						joPaginationBarPj2.style.display = 'none';
						break;
					case 3:
						joPaginationBarPj3.style.display = 'none';
						break;
					case 4:
						joPaginationBarPj4.style.display = 'none';
						break;
					case 5:
						joPaginationBarPj5.style.display = 'none';
						break;
					case 6:
						joPaginationBarPj6.style.display = 'none';
						break;
					case 7:
						joPaginationBarPj7.style.display = 'none';
						break;
					case 8:
						joPaginationBarPj8.style.display = 'none';
						break;
					case 9:
						joPaginationBarPj9.style.display = 'none';
						break;
					case 10:
						joPaginationBarPj10.style.display = 'none';
						break;
					case 11:
						joPaginationBarPj11.style.display = 'none';
						break;
					case 12:
						joPaginationBarPj12.style.display = 'none';
						break;
					case 13:
						joPaginationBarPj13.style.display = 'none';
						break;
					case 14:
						joPaginationBarPj14.style.display = 'none';
						break;
					case 15:
						joPaginationBarPj15.style.display = 'none';
						break;
					case 16:
						joPaginationBarPj16.style.display = 'none';
						break;
					case 17:
						joPaginationBarPj17.style.display = 'none';
						break;
					case 18:
						joPaginationBarPj18.style.display = 'none';
						break;
					case 19:
						joPaginationBarPj19.style.display = 'none';
						break;
					case 20:
						joPaginationBarPj20.style.display = 'none';
						break;
					default:
						break;
				}
			}
			msg = 'No rows were found';
		}

		// insert new table over any old table inside parent object
		var oldBody = parentObj.getElementsByTagName("tbody")[0];
		parentObj.replaceChild(tbdy, oldBody);

	} //(colData !== undefined && colData !== null)
	else {
		if (objid > 0 && UsePageBar === false) {
			switch (objid) {
				case 1:
					joPaginationBarPj.style.display = 'none';
					break;
				case 2:
					joPaginationBarPj2.style.display = 'none';
					break;
				case 3:
					joPaginationBarPj3.style.display = 'none';
					break;
				case 4:
					joPaginationBarPj4.style.display = 'none';
					break;
				case 5:
					joPaginationBarPj5.style.display = 'none';
					break;
				case 6:
					joPaginationBarPj6.style.display = 'none';
					break;
				case 7:
					joPaginationBarPj7.style.display = 'none';
					break;
				case 8:
					joPaginationBarPj8.style.display = 'none';
					break;
				case 9:
					joPaginationBarPj9.style.display = 'none';
					break;
				case 10:
					joPaginationBarPj10.style.display = 'none';
					break;
				case 11:
					joPaginationBarPj11.style.display = 'none';
					break;
				case 12:
					joPaginationBarPj12.style.display = 'none';
					break;
				case 13:
					joPaginationBarPj13.style.display = 'none';
					break;
				case 14:
					joPaginationBarPj14.style.display = 'none';
					break;
				case 15:
					joPaginationBarPj15.style.display = 'none';
					break;
				case 16:
					joPaginationBarPj16.style.display = 'none';
					break;
				case 17:
					joPaginationBarPj17.style.display = 'none';
					break;
				case 18:
					joPaginationBarPj18.style.display = 'none';
					break;
				case 19:
					joPaginationBarPj19.style.display = 'none';
					break;
				case 20:
					joPaginationBarPj20.style.display = 'none';
					break;
				default:
					break;
			}
		}
		msg = 'An error stopped data retrieval.';
	}
	return msg;
}

function IdentifyTargetMRowDg(row, lastrow, objid) {
	var sRow = '';
	// empty old row
	if (lastrow > -1) {
		sRow = lastrow.toString();
		if (sRow.length === 2) {sRow = '0' + sRow;}
		if (sRow.length === 1) {sRow = '00' + sRow;}
		document.getElementById('CSMRSL' + sRow + objid.toString()).innerHTML = '';
		document.getElementById('CSMRSR' + sRow + objid.toString()).innerHTML = '';
	}
	// identify new row
	if (row > -1) {
		sRow = row.toString();
		if (sRow.length === 2) {sRow = '0' + sRow;}
		if (sRow.length === 1) {sRow = '00' + sRow;}
		document.getElementById('CSMRSL' + sRow + objid.toString()).innerHTML = '&lArr;';
		document.getElementById('CSMRSR' + sRow + objid.toString()).innerHTML = '&rArr;';
	}
	return false;
}

function validateDataSourceDg(dataSrc, nCol, idCol, vwCol, EdtCol, DelCol) {
	var SrcType = '';
	var colID = '';
	var fmt = '';
	var sObjType = '';
	var sValue = '';
	var wdth = 0;
	jsDGErrorList = '';
	for (var row = 0; row < dataSrc.length; row++) {
		// verify row only data
		try {
			if (idCol.length > 0) { id = parseInt(dataSrc[row][idCol], 10); }
		}
		catch (ex) {
			jsDGErrorList = jsDGErrorList + 'Bad id column name - Row:' + row.toString() + ' = ' + idCol + '.\n';
		}

		// verify column data
		for (var col = 0; col < nCol; col++) {
			colID = jsDGColDataT[col][0].toString(); //colMap[col].toString();
			SrcType = jsDGColDataT[col][20].toString().toLowerCase();
			fmt = jsDGColDataT[col][3].toString(); // colFmt[col].toString();
			wdth = parseInt(jsDGColDataN[col][0], 10) - 1;
			if (wdth === 0) {
				jsDGErrorList = jsDGErrorList + 'Bad width - Col:' + col.toString() + ', Row:' + row.toString() + '.\n';
			}
			if (colID === undefined || colID === null) {
				jsDGErrorList = jsDGErrorList + 'Bad column source value - Col:' + col.toString() + ', Row:' + row.toString() + '.\n';
			}
			else {
				switch (SrcType) {
					case 'x': // construct
						try {
							sValue = dataSrc[row][colID].toString();
						}
						catch (ex) {
							jsDGErrorList = jsDGErrorList + 'Bad input construct - Col:' + col.toString() + ', Row:' + row.toString() + ' - ' + colID + '.\n';
						}
						sObjType = '';
						if (fmt.substr(0, 3) === 'con') { sObjType = fmt; }
						switch (sObjType) {
							case 'coninput':
								break;
							case 'conchk':
								var v = dataSrc[row][colID].toString();
								if (v !== 'Yes' && v !== 'True' && v !== 'No' && v != 'False') {
									jsDGErrorList = jsDGErrorList + 'Bad input checkbox construct - Col:' + col.toString() + ', Row:' + row.toString() + ' - ' + colID + '.\n';
								}
								break;
							case 'conradio':
								try {
									sValue = jsDGColDataT[nCol][14].toString();
									sValue = jsDGColDataT[nCol][colID].toString();
								}
								catch (ex) {
									jsDGErrorList = jsDGErrorList + 'Bad input radio button construct - Col:' + col.toString() + ', Row:' + row.toString() + ' - ' + colID + '.\n';
								}
								break;
							case 'conimage':
								try {
									sValue = dataSrc[row][colID].toString();
									$.get(image_url).done(function () {
										  	// Do nothing
										  }).fail(function () {
										  	jsDGErrorList = jsDGErrorList + 'Image does not exist - Col:' + col.toString() + ', Row:' + row.toString() + ' - ' + sValue + '.\n';
										  });
								}
								catch (ex) {
									jsDGErrorList = jsDGErrorList + 'Image/value error - Col:' + col.toString() + ', Row:' + row.toString() + ' - ' + colID + '.\n';
								}
								break;
							default:
								break;
						}
						break;
					case 't': // text only
						if (colID.length === 0 && vwCol !== (col + 1) && EdtCol !== (col+1) && DelCol !== (col+1)) {
							jsDGErrorList = jsDGErrorList + 'Text to show missing - Col:' + col.toString() + ', Row:' + row.toString() + '.\n';
						}
						break;
					default:
						try {
							sValue = dataSrc[row][colID].toString();
						}
						catch (ex) {
							jsDGErrorList = jsDGErrorList + 'Column name incorrect - Col:' + col.toString() + ', Row:' + row.toString() + ' - ' + colID + '.\n';
						}
						break;
				}
			}
		}
	}
	if (jsDGErrorList.length > 0) {
		return false;
	}
	else {
		return true;
	}
}

function GetPaginationFooterBarDg(nCol, ht, wdth, bColor, tColor, msg, objid) {
	// requires global variables from pagination.js
	var cell;
	var c;
	var emptyq = "''";
	var iHt = ht - 1;
	var iWdth = wdth - 1;
	var pg = 0;
	var tpg = 0;
	var tr = document.createElement('tr');
	tr.id = 'DGPR' + objid.toString();
	var td = document.createElement('td');
	td.id = 'DGPC' + objid.toString();
	td.colSpan = nCol.toString();
	// add in table to hold pagination that is not bound to same columns
	var tbl = document.createTable('table');
	tbl.id = 'DGTBL' + objid.toString();
	tbl.style.borderSpacing = '0px;';
	tbl.style.padding = '0px';
	tbl.style.width = '100%';
	var tr2 = document.createElement('tr');
	tr2.id = 'DGTBLR' + objid.toString();
	cell = createBasicCellDg('DGPCc00', ht, 40, bColor, tColor, 'center', '1px', '1px', '0px', '0px', objid);
	cell.innerHTML = '<a href="#" onclick="javascript:setNewPgNbrPj(' + objid.toString() + ', 0, ' + emptyq + ');return false;"><img id="imgDGPBc00" src="../Images/control_stop_left.png" style="width:' + iWdth.toString() + 'px;height:' + iHt.toString() + 'px;" /></a>';
	tr2.appendChild(cell);
	cell = createBasicCellDg('DGPCc01', ht, 6, bColor, tColor, 'center', '0px', '0px', '0px', '0px', objid);
	cell.innerHTML = '<img id="imgDGPBc00" src="../Images/control_left.png" style="width:6px;height:' + iHt.toString() + 'px;" />';
	tr2.appendChild(cell);
	cell = createBasicCellDg('DGPCc02', ht, 40, bColor, tColor, 'center', '1px', '1px', '0px', '0px', objid);
	cell.innerHTML = '<a href="#" onclick="javascript:setNewPgNbrPj(' + objid.toString() + ', 1, ' + emptyq + ');return false;"><img id="imgDGPBc00" src="../Images/control_left.png" style="width:' + iWdth.toString() + 'px;height:' + iHt.toString() + 'px;" /></a>';
	tr2.appendChild(cell);
	cell = createBasicCellDg('DGPCc03', ht, 6, bColor, tColor, 'center', '0px', '0px', '0px', '0px', objid);
	cell.innerHTML = '<img id="imgDGPBc00" src="../Images/control_left.png" style="width:6px;height:' + iHt.toString() + 'px;" />';
	tr2.appendChild(cell);
	cell = createBasicCellDg('DGPCc04', ht, 100, bColor, tColor, 'center', '1px', '1px', '0px', '0px', objid);
	cell.innerHTML = '&nbsp;Page <input type="text" id="" value="' + jiaPgNbrPj[objid].toString() + '" onchange="javascript:setNewPgNbrPj(' + objid.toString() + ', 4, this.value);return false;" /> of ' + jiaNbrPagesPj[objid].toString() + '&nbsp;';
	tr2.appendChild(cell);
	cell = createBasicCellDg('DGPCc05', ht, 6, bColor, tColor, 'center', '0px', '0px', '0px', '0px', objid);
	cell.innerHTML = '<img id="imgDGPBc00" src="../Images/control_left.png" style="width:6px;height:' + iHt.toString() + 'px;" />';
	tr2.appendChild(cell);
	cell = createBasicCellDg('DGPCc02', ht, 40, bColor, tColor, 'center', '1px', '1px', '0px', '0px', objid);
	cell.innerHTML = '<a href="#" onclick="javascript:setNewPgNbrPj(' + objid.toString() + ', 2, ' + emptyq + ');return false;"><img id="imgDGPBc00" src="../Images/control_right.png" style="width:' + iWdth.toString() + 'px;height:' + iHt.toString() + 'px;" /></a>';
	tr2.appendChild(cell);
	cell = createBasicCellDg('DGPCc05', ht, 6, bColor, tColor, 'center', '0px', '0px', '0px', '0px', objid);
	cell.innerHTML = '<img id="imgDGPBc00" src="../Images/control_left.png" style="width:6px;height:' + iHt.toString() + 'px;" />';
	tr2.appendChild(cell);
	cell = createBasicCellDg('DGPCc06', ht, 40, bColor, tColor, 'center', '1px', '1px', '0px', '0px', objid);
	cell.innerHTML = '<a href="#" onclick="javascript:setNewPgNbrPj(' + objid.toString() + ', 3, ' + emptyq + ');return false;"><img id="imgDGPBc00" src="../Images/control_stop_right.png" style="width:' + iWdth.toString() + 'px;height:' + iHt.toString() + 'px;" /></a>';
	tr2.appendChild(cell);
	cell = createBasicCellDg('DGPCc07', ht, 0, bColor, tColor, 'left', '0px', '0px', '0px', '0px', objid);
	cell.innerHTML = msg;
	tr2.appendChild(cell);
	tbl.appendChild(tr2);
	td.appendChild(tbl);
	tr.appendChild(td);
	return tr;
}

function createBasicCellDg(prefx, ht, wdth, bColor, tColor, txtorient, lpad, rpad, tpad, bpad, objid) {
	var td = document.createElement('td');
	td.id = prefx + objid.toString();
	if (ht > 0 ) {td.style.height = ht.toString() + 'px';}
	if (wdth > 0 ) {td.style.width = wdth.toString() + 'px';}
	td.style.backgroundColor = bColor;
	td.style.color = tColor;
	td.style.textAlign = txtorient;
	return td;
}

// ---------------------------------------------------------------------------------------------------------------------------------------------
// ***************************************************************************************
// 12/18/2014 - forms and returns a new separator line for an HTML table
function FormGridSeperatorLineDg(nCol, row, ExPref, objid, Content, rHt, bColor, fColor, brdr, hOrient, bld) {
	NewRow = document.createElement("tr");
	sRow = row.toString();
	if (sRow.length === 2) { sRow = '0' + sRow;}
	if (sRow.length === 1) { sRow = '00' + sRow; }
	sColSpan = nCol.toString();
	NewRow.appendChild(createNewCellDg(createObjIDDg('GRDSEP' + ExPref + objid.toString(), row, col), rHt, '', Content, bColor, fColor, brdr, hOrient, 'middle', jsDGCellPadL, jsDGCellPadR, jsDGCellPadT, jsDGCellPadB, jsDGFontSz, bld, '', false, false, true, sColSpan, false, false, '', '1', '', '', 0));

	return NewRow;
}

// ***************************************************************************************
// 12/9/2014 - Sets specific format for a data element (string, date, etc) - iCast value
function setStringFormatDg(dat, typ) {
	// typ must be < 299
	var flt = 0;
	switch (typ) {
		case 1: // money
			flt = parseFloat(dat);
			return '$' + jsfNumberFormatDg(flt, 2, '.', ',');
			break;
		case 2: // float, 2 digits
			flt = parseFloat(dat);
			return jsfNumberFormatDg(flt, 2, '.', ',');
			break;
		case 3: // int
			flt = parseInt(dat, 10);
			return jsfNumberFormatDg(flt, 0, '.', ',');
			break;
		case 4: // date only
			return getMyDateTimeStringDm(dat, 0);
			break;
		case 5: // time only
			return getMyDateTimeStringDm(dat, 7);
			break;
		case 6: // boolean to 0,1
			if (dat.toString().toLowerCase() === 'true') {
				return '1';
			}
			else {
				return '0';
			}
			break;
		case 7: // boolean to yes, no
			if (dat.toString().toLowerCase() === 'true') {
				return 'Yes';
			}
			else {
				return 'No';
			}
			break;
		case 8: // boolean to true, false
			if (dat.toString().toLowerCase() === 'true') {
				return 'true';
			}
			else {
				return 'false';
			}
			break;
		case 10: // float with 1 decimal
			flt = parseFloat(dat);
			return jsfNumberFormatDg(flt, 1, '.', ',');
			break;
		case 101: // money - blank 0
			flt = parseFloat(dat);
			if (flt === 0) {
				return '';
			}
			else {
				return '$' + jsfNumberFormatDg(flt, 2, '.', '');
			}
			break;
		case 102: // float - 2 digits - blank 0
			flt = parseFloat(dat);
			if (flt === 0) {
				return '';
			}
			else {
				return jsfNumberFormatDg(flt, 2, '.', '');
			}
			break;
		case 103: // int - blank 0
			flt = parseInt(dat, 10);
			if (flt === 0) {
				return '';
			}
			else {
				return jsfNumberFormatDg(flt, 0, '.', '');
			}
			break;
		case 106: // boolean to 0,1 - ignore 0
			if (dat.toString().toLowerCase() === 'true') {
				return '1';
			}
			else {
				return '';
			}
			break;
		case 107: // boolean to yes, no - blank no
			if (dat.toString().toLowerCase() === 'true') {
				return 'Yes';
			}
			else {
				return '';
			}
			break;
		case 201: // money - no commas
			flt = parseFloat(dat);
			return '$' + jsfNumberFormatDg(flt, 2, '.', '');
			break;
		case 202: // float - no commas
			flt = parseFloat(dat);
			return jsfNumberFormatDg(flt, 2, '.', '');
			break;
		case 203: // int - no commas
			flt = parseInt(dat, 10);
			return jsfNumberFormatDg(flt, 0, '.', '');
			break;
		default: // general string or numbers
			return dat.toString();
			break;
	}
	return '';
}

// ***************************************************************************************
// 12/9/2014 - returns standard data table object ID in format: PrefixROWCL -> RWC00100
function createObjIDDg(pref, rw, col) {
	var sRw = rw.toString();
	var sCol = col.toString();
	if (sRw.length === 2) { sRw = '0' + sRw; }
	if (sRw.length === 1) { sRw = '00' + sRw; }
	if (sCol.length === 2) { sCol = '0' + sCol; }
	if (sCol.length === 1) { sCol = '00' + sCol; }
	return pref + sRw + sCol;
}

// ***************************************************************************************
// 12/9/2014 - creates and returns standard data table cell already filled
//                       tx  nbr nbr   txt      txt      txt      txt    txt    txt    txt    txt     txt     txt   txt   txt   txt   txt     bool    bool      txt     bool    bool    txt	   txt     txt        displaytxt
function createNewCellDg(id, ht, wdth, content, bkColor, frColor, brdrL, brdrR, brdrT, brdrB, hAlign, vAlign, padl, padr, padt, padb, fontSz, IsBold, isItalic, ovrflw, RdOnly, dsabld, Visbl, colspn, cellClass, disp, noWrap) {
	//alert('Creating Cell');
	var c = document.createElement("td");
	c.id = id;
	c.style.height = ht;
	if (wdth !== undefined && wdth !== null && wdth !== '0' && wdth !== '') {
		c.style.width = wdth;
	}
	c.className = 'TableHdrCell';
	if (cellClass.length > 0) {
		c.className = cellClass;
	}
	c.style.paddingRight = padr;
	c.style.paddingLeft = padl;
	c.style.paddingTop = padt;
	if (fontSz.length > 0) {
		c.style.fontSize = fontSz;
	}
	if (IsBold === true) {
		c.style.fontWeight = 'bold';
	}
	//alert('Creating Cell 2');
	c.style.paddingBottom = padb;
	c.style.textAlign = hAlign;
	c.style.verticalAlign = vAlign;
	c.style.backgroundColor = bkColor;
	c.style.color = frColor;
	if (brdrL.length > 0) {	c.style.borderLeft = brdrL;}
	if (brdrR.length > 0) {	c.style.borderRight = brdrR;}
	if (brdrT.length > 0) {	c.style.borderTop = brdrT;}
	if (brdrB.length > 0) { c.style.borderBottom = brdrB; }
	c.style.overflow = ovrflw;
	if (colspn.length > 0) {
		c.colSpan = colspn;
	}
	//alert('Creating Cell 3');
	if (isItalic === true) {
		c.style.fontStyle = 'italic';
	}
	if (dsabld === true) {
		c.style.disable = true;
	}
	if (RdOnly === true) {
		c.unselectable = 'on';
	}
	if (Visbl.length > 0) {
		c.style.visibility = Visbl;
	}
	if (disp.length > 0) {
		c.style.display = disp;
	}
	if (noWrap === 1) {
		c.style.whiteSpace = 'nowrap';
	}
	//alert('Cell ready');
	c.innerHTML = content;
	return c;
}
//											 tx  tx       tx      tx       tx        tx      tx					tx			 tx		 tx		 tx		 tx		 tx		 '1'or'0' display tx
function createHdrCellDg(id, content, clspan, classnm, txtalign, valign, cellwidth, bgcolor, frcolor, brdr, padL, padR, padT, padB, sBold, disp) {
	var cell = document.createElement("th");
	cell.id = id;
	cell.className = classnm;
	cell.cellPadding = 0;
	cell.cellSpacing = 0;
	cell.style.fontSize = '10pt';
	cell.style.textAlign = txtalign;
	cell.style.verticalAlign = valign;
	cell.style.borderWidth = '1px';
	cell.style.borderColor = 'Gray';
	cell.style.borderStyle = 'solid';
	if (sBold === '1' || sBold === 'true') {cell.style.fontWeight = 'bold';}
	if (brdr !== '') {
		cell.style.border = brdr;
	}
	if (bgcolor.length > 0) {
		cell.style.backgroundColor = bgcolor;
	}
	if (frcolor.length > 0) {
		cell.style.color = frcolor;
	}
	if (cellwidth !== '') {
		cell.width = cellwidth;
	}
	if (clspan !== '') {
		cell.colSpan = clspan;
	}
	if (padL !== '') {
		cell.style.paddingLeft = padL;
	}
	if (padR !== '') {
		cell.style.paddingRight = padR;
	}
	if (padT !== '') {
		cell.style.paddingTop = padT;
	}
	if (padB !== '') {
		cell.style.paddingBottom = padB;
	}
	if (disp.length > 0) {
		cell.style.display = disp;
	}
	cell.innerHTML = content;
	return cell;
}

function getNewRowDg(rowID, rowNbr, lnheight) {
	var sRowNbr = rowNbr.toString();
	if (sRowNbr.length == 2) { sRowNbr = '0' + sRowNbr; }
	if (sRowNbr.length == 1) { sRowNbr = '00' + sRowNbr; }
	var row = document.createElement("TR");
	//alert(sRowNbr);
	if (jsBrowserType == 'IE7' || jsBrowserType == 'IE6' || jsBrowserType == 'IE8') {
		row.height = lnheight; // "16px";
	}
	else {
		row.clientHeight = lnheight; //  "16px";
	}
	row.id = rowID + sRowNbr;
	return row;
}

function getNewTextBoxDg(rowNbr, colNbr, DayNoT, prefix, hght, wdth, IsReadOnly, IsVisible, content, bColor, TSStatus, TaskID, TOGuid, VEmpID, StartDt, TEDate, CanEditDesc, txtHAlign, txtVAlign, RoleID, EntryID) {
	//alert('Creating new text box - for day ' + DayNoT);
	var tb = document.createElement("input");
	tb.type = 'text';
	tb.id = getGridObjectID(prefix, colNbr, rowNbr);
	//alert(tb.id + '/' + tb.type);
	//tb.clientHeight = hght;
	//tb.clientWidth = wdth;
	tb.style.height = hght;
	tb.style.width = wdth;
	tb.style.color = 'blue';
	tb.style.borderStyle = 'none';
	tb.style.backgroundColor = bColor;
	tb.style.textAlign = txtHAlign;
	//tb.style.textAlign = 'center';
	tb.style.verticalAlign = txtVAlign;
	if (IsReadOnly === true || bColor === 'transparent') {
		tb.readOnly = true;
	}
	if (IsVisible === false) {
		tb.style.visibility = 'hidden';
	}
	tb.value = content;
	if (TaskID === '') { TaskID = '0'; }
	if (TSStatus === 'Not Submitted' || TSStatus === 'Rejected' && colNbr > 1 && colNbr < 9 && prefix !== 'ST' && bColor !== 'transparent') {
		if (IsReadOnly === false) {
			tb.onblur = function () { CheckThisField2(this, DayNoT, TaskID, TOGuid, VEmpID, 0, TEDate); return false; };
			tb.onfocus = function () { SetFieldEntry(this); return false; };
		}
		tb.onkeydown = function () { return disableEnterKey(event); };
	}
	//alert('setting contextmenu event attributes');
	if (colNbr > 1 && colNbr !== 9 && prefix !== 'ST' && bColor !== 'transparent') {
		tb.oncontextmenu = function () { return ShowDescEditForm(tb.id, TaskID, rowNbr, TEDate, StartDt, CanEditDesc, TOGuid, VEmpID.toString(), StartDt, RoleID, EntryID); };
	}
	//alert('Done setting event attributes');
	return tb;
}

function getNewCheckBoxDg(rowNbr, colNbr, DayNoT, prefix, IsReadOnly, IsVisible, IsChecked, bColor, TEmpID, VEmpID, TEDate) {
	//alert('Creating new text box - for day ' + DayNoT);
	var chk = document.createElement("input");
	chk.type = 'checkbox';
	chk.id = getGridObjectID(prefix, colNbr, rowNbr);
	//alert(chk.id + '/' + chk.type);
	chk.style.backgroundColor = bColor;
	//chk.style.textAlign = 'center';
	if (IsReadOnly === true || bColor === 'transparent') {
		chk.readOnly = true;
	}
	if (IsVisible === false) {
		chk.style.visibility = 'hidden';
	}
	// establish checkbox events
	chk.onchange = function () { HandleFieldChanges(this, DayNoT, TEmpID, VEmpID, TEDate); return false; };
	chk.checked = false;
	if (IsChecked == 'True') { chk.checked = true; }
	return chk;
}

function getNewDivObjectDg(rowNbr, colNbr, prefix, hght, wdth, content, bColor) {
	var dv = document.createElement("div");
	dv.id = getGridObjectID(prefix, colNbr, rowNbr);
	dv.style.height = hght;
	dv.style.width = wdth;
	dv.style.display = 'none';
	dv.innerHTML = content;
	return dv;
}

function getParamDataArrayDg(nbrCols, objid) {
	var val = '';
	for (var col = 0; col < nbrCols; col++) {
		sCol = col.toString();
		if (sCol.length === 1) { sCol = '0' + sCol; }
		val = '';
		if (jsDGColDataN[col][7] === 1) {
			val = document.getElementById('txtDGParamCol' + sCol + 'o' + objid.toString()).value;
		}
		jsDGParamData[col] = val;
	}
	return 'Okay';
}

// parentobj text id, firstdate DATE, altRowA
function createCalendarGridDg(parentObj, firstDate, altRowA, tblBrdr, tblspc, tblMargin, tblClass, clprfx, clBrdr, clClass, clBColor, clFColor, calData, hdBrdr, hdBColor, hdFColor, dtBColor, dtFColor, iPad, tWidth, tMinHt, hltToday, showWeekend, showOutDates, showTlTp, noOverflw, PastDtCol, ffam, fsize) {
	// Data format: EventDate yyyy-mm-dd string format (in date order), EventTitle, EventToolTip
	var bColor = '';
	var brdr = '';
	var brdrB = '';
	var brdrL = '';
	var brdrR = '';
	var brdrT = '';
	var rowcell;
	var colspn = '';
	var dt;
	var fColor = '';
	var fColor2 = '';
	var hltcell = false;
	var ht = '';
	var iDay = 0;
	var iDay2 = 0;
	var iFirstWeekDay = 0;
	var iMo = firstDate.getMonth();
	var iMo2 = 0;
	var iWeekDay = 0;
	var iWeekD2 = 0;
	var iYr = firstDate.getFullYear();
	var iYr2 = 0;
	var NbrDataRows = 0;
	var rw;
	var rw2;
	var s = '';
	var tgl = 0;
	var today = new Date();
	var ttip = '';
	var val;
	var wdth = '';
	if (calData !== undefined && calData !== null) { NbrDataRows = calData.length; }
	if (PastDtCol === undefined || PastDtCol === null) {PastDtCol = '';}
	var tbl = document.createElement("table");
	var thd = document.createElement("thead");
	var tbdy = document.createElement("tbody");
	if (tWidth.length > 0) { tbl.width = tWidth;}
	if (tblspc.length > 0) { tbl.style.borderSpacing = tblspc;}
	if (tblMargin.length > 0 ) {tbl.style.margin = tblMargin;}
	if (tblClass.length > 0) {tbl.className = tblClass;}
	tbl.borderCollapse = 'collapse';
	if (showWeekend === false) { nbrCols = 10;}
	var dayname = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
	var iDaysInMo = DaysOfMonthDm(iYr, iMo);
	var iDayInWeek = firstDate.getDay(); // 0-6
	var today = new Date();
	today.setHours(0, 0, 0, 0);
	var DayOne = new Date(firstDate);
	DayOne.setDate(firstDate.getDate()-iDayInWeek);
	DayOne.setHours(0, 0, 0, 0);
	var lastDate = new Date(firstDate);
	lastDate.setDate(firstDate.getDate() + iDaysInMo - 1);
	lastDate.setHours(0, 0, 0, 0);
	//alert('Has Rows - ' + NbrDataRows);
	if (hdBColor === undefined || hdBColor === null) { hdBColor = '#FFFFFF';}
	if (hdFColor === undefined || hdFColor === null) { hdFColor = '#000000'; }
	if (today >= DayOne && today <= lastDate) {
		if (jsDGDayNames[today.getDate()] === '') { jsDGDayNames[today.getDate()] = '<strong>* TODAY *</strong>';}
	}

	// create thead
	rw = document.createElement("tr");
	for (var dncell = 0; dncell < 7; dncell++) {
		if (showWeekend === true || (dncell !== 0 && dncell !== 6)) {
			rowcell = document.createElement("th");
			rowcell.style.border = hdBrdr;
			rowcell.style.backgroundColor = hdBColor;
			rowcell.style.color = hdFColor;
			rowcell.colSpan = '2';
			rowcell.innerHTML = dayname[dncell];
			rw.appendChild(rowcell);
		}
	} //var dncell = 0; dncell < 7; dncell++
	thd.appendChild(rw);
	tbl.appendChild(thd);

	// create tbody
	var CurrDt = new Date(firstDate);
	CurrDt.setHours(0, 0, 0, 0);
	iFirstWeekDay = CurrDt.getDay();
	tgl = 1;
	iWeekDay = CurrDt.getDay();
	iWeekD2 = 0;
	//alert(showOutDates + '/' + clBrdr + '/' + iFirstWeekDay + '/' + iWeekD2 + '/' + DayOne + '/' + firstDate + '/' + lastDate); // ****************************************

	for (var row = 0; row < 6; row++) {
		// create small header row and data row for each week
		rw = document.createElement("tr");
		rw2 = document.createElement("tr");
		// toggle background change for row
		if (tgl === 1) {
			tgl = 0;
		}
		else {
			tgl = 1;
		}

		// cycle through cells
		for (var tcell = 0; tcell < 7; tcell++) {
			if (row === 0 && iWeekD2 < iFirstWeekDay) {
				//show empty cell with no border
				ht = '20px';
				wdth = '20px';
				rowcell = createCalendarCellDg(row, tcell, clprfx, 'T', '', showOutDates, 'none', 'none', 'none', 'none', 'white', 'black', false, true, ht, wdth, '', '', clClass, iPad, hltcell, '', '');
				rw.appendChild(rowcell);
				rowcell = createCalendarCellDg(row, tcell, clprfx, 'A', '', showOutDates, 'none', 'none', 'none', 'none', 'white', 'black', false, true, ht, '', '', '', clClass, iPad, hltcell, '', '');
				rw.appendChild(rowcell);
				rowcell = createCalendarCellDg(row, tcell, clprfx, 'D', '2', showOutDates, 'none', 'none', 'none', tblBrdr, 'white', 'black', false, true, tMinHt, '', '', '', clClass, iPad, hltcell, '', '');
				rw2.appendChild(rowcell);
				iWeekD2++;
				//alert('Fired!');
				//alert(iWeekDay + '/' + iWeekD2); // ****************************************
			}
			else {
				// show cell for day (empty or not)
				iWeekDay = CurrDt.getDay(); // 0-6
				if (showWeekend === true || (tcell !== 0 && tcell !== 6)) {
					val = '';
					if (CurrDt <= lastDate) {
						// Show date in little box
						bColor = '#FFFFFF';
						// set special formatting if necessary
						if (altRowA === true) {
							if (tgl === 1) { bColor = jsDGTglColor; }
						}
						fColor = '#000000';
						fColor2 = '#000000';
						ht = '20px';
						wdth = '20px';
						val = '';
						if (showOutDates === true) {
							brdr = tblBrdr; //'1px solid #DDDDDD';
							bColor = dtBColor;
							fColor = dtFColor;
							fColor2 = dtFColor;
							val = CurrDt.getDate().toString();
						}
						else {
							brdr = 'none';
						}
						hltcell = false;
						if (CurrDt < today) {
							if (PastDtCol !== '') {
								fColor = PastDtCol;
							}
						}
						else {
							//alert('today or after');
							if (CurrDt.toString() == today.toString()) {
								//&& hltToday === true) {
								hltcell = true;
								//alert('fired highlight setting');
							}
						}

						//alert('Date: ' + val);
						rowcell = createCalendarCellDg(row, tcell, clprfx, 'T', '', showOutDates, brdr, brdr, brdr, brdr, bColor, fColor, true, true, ht, wdth, val, '', clClass, iPad, false, '', '');
						rowcell.style.textAlign = 'center';
						rw.appendChild(rowcell);

						// show any dayname in cell top of large cell
						val = jsDGDayNames[CurrDt.getDate()];
						//alert('Name: ' + val);
						rowcell = createCalendarCellDg(row, tcell, clprfx, 'A', '', showOutDates, 'none', brdr, 'none', 'none', clBColor, clFColor, false, true, ht, '', val, '', clClass, iPad, hltcell, '', '');
						rowcell.style.textAlign = 'center';
						rw.appendChild(rowcell);

						colspn = '2';
						bColor = clBColor;
						fColor = clFColor;
						brdrT = 'none';
						brdrL = clBrdr;
						brdrR = clBrdr;
						brdrB = clBrdr;
						val = '';
						ttip = '';
						if (CurrDt < firstDate || CurrDt > lastDate) {
							if (showOutDates === true) {
								brdrT = 'none';
								brdrL = clBrdr; // '1px solid #DDDDDD';
								brdrR = clBrdr; //'1px solid #DDDDDD';
								brdrB = clBrdr; //'1px solid #DDDDDD';
								bColor = '#E9E9E9';
							}
							else {
								brdrT = 'none';
								brdrL = 'none';
								brdrR = 'none';
								brdrB = 'none';
								bColor = '#FFFFFF';
							}
						}
						else {
							// add content
							val = '';
							ttip = '';
							if (NbrDataRows > 0) {
								for (var itm = 0; itm < NbrDataRows; itm++) {
									s = calData[itm]['EventDate'].toString();	 // yyyy-mm-dd string format
									iDay2 = parseInt(s.substr(8, 2), 10);
									iMo2 = parseInt(s.substr(5, 2), 10);
									iYr2 = parseInt(s.substr(0, 4), 10);
									//alert(s + '/' + s.substr(0, 4) + '/' + s.substr(5, 2) + '/' + s.substr(8, 2));
									if (iDay2 === iDay && iYr2 === iYr && iMo2 === (iMo+1)) {
										s = calData[itm]['EventTitle'].toString();
										//alert(s);
										if (s !== undefined && s !== null) {
											val = val + s + '<br />';
											//alert('Found item');
										}
										if (showTlTp === true) {
											s = calData[itm]['EventToolTip'].toString();
											if (s !== undefined && s !== null) {
												ttip = ttip + s + '\n';
											}
										}
									}
								}
							}
							rowcell.title = ttip;
						}
						rowcell = createCalendarCellDg(row, tcell, clprfx, 'D', colspn, showOutDates, brdrL, brdrR, brdrT, brdrB, clBColor, clFColor, false, noOverflw, tMinHt, '', val, ttip, clClass, iPad, hltcell, ffam, fsize);
						rw2.appendChild(rowcell);
					}
					else {
						//show empty cell with no border
						ht = '20px';
						wdth = '20px';
						rowcell = createCalendarCellDg(row, tcell, clprfx, 'T', '', showOutDates, 'none', 'none', tblBrdr, 'none', 'white', 'black', false, true, ht, wdth, '', '', clClass, iPad, hltcell);
						rw.appendChild(rowcell);
						rowcell = createCalendarCellDg(row, tcell, clprfx, 'A', '', showOutDates, 'none', 'none', tblBrdr, 'none', 'white', 'black', false, true, ht, '', '', '', clClass, iPad, hltcell);
						rw.appendChild(rowcell);
						rowcell = createCalendarCellDg(row, tcell, clprfx, 'D', '2', showOutDates, 'none', 'none', 'none', 'none', 'white', 'black', false, true, tMinHt, '', '', '', clClass, iPad, hltcell);
						rw2.appendChild(rowcell);
					}
					CurrDt.setDate(CurrDt.getDate() + 1);
					CurrDt.setHours(0, 0, 0, 0);
					iDay = CurrDt.getDate();
				}
			}
		} //var tcell = 0; tcell < 7; tcell++
		tbdy.appendChild(rw);
		tbdy.appendChild(rw2);
	} //var row = 0; row < 6; row++
	tbl.appendChild(tbdy);
	return tbl;
}

function createCalendarCellDg(row, tcell, prefx, suffx, colspn, showOutDates, brdrL, brdrR, brdrT, brdrB, bColor, fColor, isBold, noOverflw, ht, wdth, content, ttip, clclass, ipad, hltcell, ffam, fsize) {
	cell = document.createElement("td");
	cell.id = prefx + row.toString() + tcell.toString() + suffx;
	if (clclass === undefined || clclass === null) { clclass = '';}
	//if (clclass !== '') { cell.className = clclass; }
	if (colspn.length > 0) { cell.colSpan = colspn; }
	if (ht.length > 0) { cell.height = ht; }
	if (wdth.length > 0) { cell.width = wdth; }
	if (brdrL !== '') { cell.style.borderTop = brdrT; }
	if (brdrL !== '') { cell.style.borderLeft = brdrL; }
	if (brdrL !== '') { cell.style.borderRight = brdrR;	}
	if (brdrL !== '') { cell.style.borderBottom = brdrB; }
	if (hltcell === true) {
		cell.style.backgroundColor = jgHighlightColor;
		//alert('Fired highlight');
	}
	else {
		cell.style.backgroundColor = bColor;
	}
	cell.style.color = fColor;
	if (ipad === undefined || ipad === null) { ipad = ''; }
	if (ipad !== '') { cell.style.padding = ipad; }
	if (isBold === true) { cell.style.fontWeight = 'bold'; }
	if (noOverflw === true) {
		cell.style.overflow = 'hidden';
		cell.style.whiteSpace = 'nowrap';
	}
	if (ffam === undefined || ffam === null) { ffam = '';}
	if (fsize === undefined || fsize === null) { fsize = ''; }
	if (ffam !== '') { cell.style.font = ffam; }
	if (fsize !== '') { cell.style.fontSize = fsize;}
	if (content === undefined || content === null) { content = ''; }
	cell.style.verticalAlign = 'top';
	cell.innerHTML = content;
	cell.title = ttip;
	return cell;
}

function createBlockArrayDg(bHdr, bFtr, iMargin, iPad, iCols, iRows, cWdth, cHt, cbColor, cfColor, cBrdr, cfSize, cFont, cArray, cHOrient, cVOrient, ctipArray, hArray, ifCol, fArray) {
	// cArray is basic set of HTML 5 content blocks = [row][col]
	// ctipArray is text [row][col]
	// hArray = [hwdth, hht, hbcol, hfcol, hbrdr, hfsize, hfont, hOrient, ttip, contentblock] (content HTML5)
	// fArray = [fwdth, fht, fbcol, ffcol, fbrdr, ffsize, ffont, hOrient, vOrient, ttip, contentblock] FOR EACH ROW (content HTML5)

	var aContent;
	var aHOrient;
	var aVOrient;
	var bColor = '';
	var brdr = '';
	var brdrB = '';
	var brdrL = '';
	var brdrR = '';
	var brdrT = '';
	var cl;
	var colspn = '';
	var dt;
	var fColor = '';
	var ht = '';
	var iNbrCol = 0;
	var rw;
	var rw2;
	var ttip = '';
	var val;
	var wdth = '';

	var tbl = document.createElement("table");
	if (iMargin.toString().length > 0) {tbl.style.margin = iMargin.toString() + 'px';}
	if (iPad.toString().length > 0) {tbl.style.padding = iPad.toString() + 'px';}
	
	//var thd = document.createElement("thead");
	var tbdy = document.createElement("tbody");

	// define header row (only one allowed)
	if (bHdr === true) {
		rw = document.createElement("tr");
		cl = document.createElement("td");
		cl.colSpan = iCols.toString();
		if (hArray[0].length > 0) {cl.width = hArray[0].toString();}
		if (hArray[1].length > 0) {cl.height = hArray[1].toString();}
		if (hArray[2].length > 0) {cl.style.backgroundColor = hArray[2].toString();}
		if (hArray[3].length > 0) {cl.style.color = hArray[3].toString();}
		if (hArray[4].length > 0) {cl.style.border = hArray[4].toString();}
		if (hArray[5].length > 0) {cl.style.fontSize = hArray[5].toString();}
		if (hArray[6].length > 0) {cl.style.fontFamily = hArray[6].toString();}
		if (hArray[7].length > 0) {cl.style.textAlign = hArray[7].toString();}
		cl.title = hArray[8].toString();
		cl.innerHTML = hArray[9].toString();
		rw.appendChild(cl);
		tbdy.appendChild(rw);
	}

	// Add content cells and rows 
	for (var row=0;row<iRows;row++) {
		rw = document.createElement("tr");
		for (var col=0;col<iCols;col++) {
			cl = document.createElement("td");
			if (cWdth.length > 0) {cl.width = cWdth.toString();}
			if (cHt.length > 0) {cl.height = cHt.toString();}
			if (cbColor.length > 0) {cl.style.backgroundColor = cbColor.toString();}
			if (cfColor.length > 0) {cl.style.color = cfColor.toString();}
			if (cBrdr.length > 0) {cl.style.border = cBrdr.toString();}
			if (cfSize.length > 0) {cl.style.fontSize = cfSize.toString();}
			if (cFont.length > 0) {cl.style.fontFamily = cFont.toString();}
			if (cHOrient[col].length > 0) {cl.style.textAlign = cHOrient[col].toString();}
			if (cVOrient[col].length > 0) {cl.style.verticalAlign = cVOrient[col].toString();}
			cl.title = ctipArray[row][col].toString();
			cl.innerHTML = cArray[row][col].toString();
			rw.appendChild(cl);
		}
		tbdy.appendChild(rw);
	}
	 
	// define footer row
	if (bFtr === true) {
		iNbrCol = parseInt(ifCol, 10);
		rw = document.createElement("tr");
		for (var row2 = 0;row2<iNbrCol;row2++) {
			cl = document.createElement("td");
			if (fArray[row2][0].length > 0) {cl.width = fArray[row2][0].toString();}
			if (fArray[row2][1].length > 0) {cl.height = fArray[row2][1].toString();}
			if (fArray[row2][2].length > 0) {cl.style.backgroundColor = fArray[row2][2].toString();}
			if (fArray[row2][3].length > 0) {cl.style.color = fArray[row2][3].toString();}
			if (fArray[row2][4].length > 0) {cl.style.border = fArray[row2][4].toString();}
			if (fArray[row2][5].length > 0) {cl.style.fontSize = fArray[row2][5].toString();}
			if (fArray[row2][6].length > 0) {cl.style.fontFamily = fArray[row2][6].toString();}
			if (fArray[row2][7].length > 0) {cl.style.textAlign = fArray[row2][7].toString();}
			if (fArray[row2][8].length > 0) {cl.style.verticalAlign = fArray[row2][8].toString();}
			cl.title = fArray[9].toString();
			cl.innerHTML = fArray[10].toString();
			rw.appendChild(cl);
		}
		tbdy.appendChild(rw);
	}

	// fill table and return
	tbl.appendChild(tbdy);
	return tbl;
} 

function jsfNumberFormatDg(number, decimals, dec_point, thousands_sep) {
	// From: http://phpjs.org/functions
	// *     example 1: number_format(1234.56);			returns 1: '1,235'
	// *     example 2: number_format(1234.56, 2, ',', ' '); returns 2: '1 234,56'
	// *     example 3: number_format(1234.5678, 2, '.', ''); returns 3: '1234.57'
	// *     example 4: number_format(67, 2, ',', '.'); returns 4: '67,00'
	// *     example 5: number_format(1000);			returns 5: '1,000'
	// *     example 6: number_format(67.311, 2);		returns 6: '67.31'
	// *     example 7: number_format(1000.55, 1);      returns 7: '1,000.6'
	// *     example 8: number_format(67000, 5, ',', '.'); returns 8: '67.000,00000'
	// *     example 9: number_format(0.9, 0);			returns 9: '1'
	// *    example 10: number_format('1.20', 2);		returns 10: '1.20'
	// *    example 11: number_format('1.20', 4);		returns 11: '1.2000'
	// *    example 12: number_format('1.2000', 3);		returns 12: '1.200'
	// *    example 13: number_format('1 000,50', 2, '.', ' '); returns 13: '100 050.00'
	// Strip all characters but numerical ones.
	number = (number + '').replace(/[^0-9+\-Ee.]/g, '');
	var n = !isFinite(+number) ? 0 : +number,
    prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
    sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
    dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
    s = '',
    toFixedFix = function (n, prec) {
    	var k = Math.pow(10, prec);
    	return '' + Math.round(n * k) / k;
    };
	// Fix for IE parseFloat(0.55).toFixed(0) = 0;
	s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
	if (s[0].length > 3) {
		s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
	}
	if ((s[1] || '').length < prec) {
		s[1] = s[1] || '';
		s[1] += new Array(prec - s[1].length + 1).join('0');
	}
	return s.join(dec);
}

// Call below function to initialize settings then set AggCols Col value
// Value = 0-no agg, 1-SUM, 2-AVG, 3-count values matching AggColsV, 4-Count having values, 5-Count no values, 6-Count outside range(V, V2), 7-Count inside range, 8-Count inside range inclusive, 10-> val, 11-< val, 12->= val, 13-<= val
function InitializeAnalyzeDataGrids(NbrRows, NbrCols) {
  jsDGAnalyzeAggCols = createArrayInitGu(NbrRows, 1);
  jsDGAnalyzeAggColsV = createArrayInitGu(NbrRows, 0);
  jsDGAnalyzeAggColsV2 = createArrayInitGu(NbrRows, 0);
}

function AnalyzeDataGridData(resultsobjname, datasrc, nCols, tcol, tval, objid) {
  var NbrRows = datasrc.length;
  var tvalCount = 0;
  var val = '';
  for (var row=0; row < NbrRows; row++) {
    for (var col=0;col<nCols;col++) {
      tcol = 0;
      tval = '';
      val = '';
      try {
        val = datasrc[row][col].toString();
      }
      catch (ex) {
        val = '';
      }
      if (col+1 === tcol && tval.length > 0 && tcol>0) {
        if (val === tval) {tvalCount++;}
      }
    }
  }

  // build and display analysis results




}

function FormDataGridRowMinimumDg(objid, nCol, rowid, idprefix, cellclass, hasEdit, hasDel, hasView, btnClass, dt, idfldname, colnames, wdth, horient, vorient, brdrL, brdrR, brdrT, brdrB, Fmt) {
	var a;
	var fig = 0;
	var sCol = '00';
	var sRow = rowid.toString();
	if (sRow.length === 1) { sRow = '0' + sRow; }
	var tr = document.createElement("tr");
	var val = '';
	var val2 = '';
	// insert cells for each column
	for (var col = 0; col < nCol; col++) {
		sCol = col.toString();
		if (sCol.length === 1) { sCol = '0' + sRow; }
		td = document.createElement("td");
		td.id = idprefix + 'R' + sRow + 'Col' + sCol;
		if (colnames[col].toString() !== 'ACTION') {
			val = dt[rowid][colnames[col].toString()].toString();
			switch (Fmt[col]) {
				case 0: // donothing
					break;
				case 1:	// integer
					val = jsfNumberFormatNf(parseInt(val), 0, '.', ',');
					break;
				case 2:	// money integer
					fig = parseFloat(val);
					val = '$' + jsfNumberFormatNf(parseInt(val), 0, '.', ',');
					break;
				case 3:	// money - 2 digit
					fig = parseFloat(val);
					val = '$' + jsfNumberFormatNf(parseInt(val), 2, '.', ',');
					break;
				case 4: // input textbox
					val = '<input type="text" id="txtInputCol' + sRow + sCol + '" value="' + val + '" onchange="javascript:ChangeInputVal(' + dt[rowid][colnames[col].toString()].toString() + ',' + rowid.toString() + ','+ col.toString()+ ',' + objid.toString() + ',this.value);return false;" />';
					break;
				case 5: // checkbox
					val = '<input type="checkbox" id="txtInputCol' + sRow + sCol + '"';
					if (val === '1') {val = val + ' checked="checked"';}
					val = val + '" onchange="javascript:ChangeInputVal(' + dt[rowid][colnames[col].toString()].toString() + ',' + rowid.toString() + ',' + col.toString() + ',' + objid.toString() + ',this.value);return false;" />';
					break;
				case 6: // drop down list
					val2 = '<select id="selListVal' + sRow + sCol + '" onchange="javascript:ChangeDropDownVal(' + dt[rowid][colnames[col].toString()].toString() + ',' + objid.toString() + ',' + rowid.toString() + ',' + col.toString() + ', this.value);return false;" >';
					for (var itm = 0; itm < 20; itm++) {
						if (jsDGColDDLOpts[itm] !== '') {
							a = jsDGColDDLOpts[itm].split('|');	// '47|Name'
							val2 = val2 + '<option value="' + a[0] + '"';
							if (val === a[0]) { val2 = val2 + ' selected="selected"';}
							val2 = val2 + '></option>'
						}
					}
					val = val2 + '</select>';
					break;
				default:
					break;
			}
			td.innerHTML = val;
		}
		else {
			val = '';
			if (hasDel === true) {
				val = val + '<button id="btnDeleteRow' + rowid.toString() + '_' + objid.toString() + '" class="' + btnClass + '" onclick="javascript:DeleteOneRec(' + dt[rowid][colnames[col].toString()].toString() + ',' + rowid.toString() + ',' + objid.toString() + ');return false;"></button>';
			}
			if (hasEdit === true) {
				val = val + '<button id="btnEditRow' + rowid.toString() + '_' + objid.toString() + '" class="' + btnClass + '" onclick="javascript:EditOneRec(' + dt[rowid][colnames[col].toString()].toString() + ',' + rowid.toString() + ',' + objid.toString() + ');return false;"></button>';
			}
			if (hasView === true) {
				val = val + '<button id="btnViewRow' + rowid.toString() + '_' + objid.toString() + '" class="' + btnClass + '" onclick="javascript:ViewOneRec(' + dt[rowid][colnames[col].toString()].toString() + ',' + rowid.toString() + ',' + objid.toString() + ');return false;"></button>';
			}
			td.innerHTML = val;
		}
		td.className = cellclass;
		td.style.borderLeft = brdrL[col];
		td.style.borderRight = brdrR[col];
		td.style.borderTop = brdrT[col];
		td.style.borderBottom = brdrB[col];
		td.style.textAlign = horient[col];
		td.style.verticalAlign = vorient[col];
		td.style.width = wdth.toString() + 'px';
		tr.appendChild(td);
	}
	return tr;
}

function FormDataGridBodyMinimumDg(objid, nCol, idprefix, cellclass, hasEdit, hasDel, hasView, hasSpec, SpecLbl, btnClass, showAggs, aggprec, dt, idfldname, colnames, coltype, wdth, horient, vorient, brdrL, brdrR, brdrT, brdrB, aggType, shown, pg, wrp) {
	//alert('Form min datagrid - ' + objid + '/' + nCol + '/' + idprefix + '/' + cellclass + '/' + btnClass + '/' + idfldname)                                                                                                                            true;
	// max 50 columns
	for (var ai = 0; ai < arguments.length; ai++) {
		if (IsContentsNullUndefinedGu(arguments[ai])) {
			alert('Bad parameter submitted for argument ' + ai.toString());
			return false;
		}
	}
	var fig = 0;
	var cname = '';
	var iCount = 0;
	var id = 0;
	var nRows = 0;
	var s = '';
	var sCol = '00';
	var sRow = '00';
	var tr;
	var val = '';
	var valStr = '';
	var aggs = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
	var vals = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
	if (pg === true) {
		jiNbrPagesPj[objid - 1] = 0; // parseInt(MyProcessList[0]['NbrPages'], 10);
		jiNbrRowsPj[objid - 1] = 0; // parseInt(MyProcessList[0]['NbrRows'], 10);
	}
	var bdy = document.createElement('tbody');

	if (!IsContentsNullUndefinedTx(dt)) {
		nRows = dt.length;
		//alert(nRows + ' found');
		if (nRows > 0) {
			if (pg === true) {
				jiNbrPagesPj[objid - 1] = parseInt(dt[0]['NbrPages'], 10);
				jiNbrRowsPj[objid - 1] = parseInt(dt[0]['NbrRows'], 10);
			}
			//alert('starting row insertion ' + dt.length.toString());
			for (var row = 0; row < dt.length; row++) {
				sRow = row.toString();
				if (sRow.length === 1) { sRow = '0' + sRow; }
				tr = document.createElement("tr");
				id = dt[row][idfldname].toString();
				//alert(sRow + '/' + id);
				// insert cells for each column
				val = '';
				for (var col = 0; col < nCol; col++) {
					if (shown[col] === 1) {
						//alert(col);
						//if (col > 6) { alert('Col: ' + col); }
						val = '';
						sCol = col.toString();
						if (sCol.length === 1) { sCol = '0' + sCol; }
						//if (col > 6) { alert(idprefix); }
						td = document.createElement("td");
						s = idprefix + 'R' + sRow + 'Col' + sCol;
						//if (col > 6) { alert(s); }
						td.id = s;
						//if (col > 6) { alert(colnames[col].toString()); }
						//if (col > 6) { alert(dt[row][colnames[col].toString()].toString()); }
						//if (col > 6) { alert(td.id); }
						cname = colnames[col].toString();
						if (cname.length > 0) {
							if (cname.toUpperCase() === 'ACTION') {
								//alert('ACTION col');
								if (hasDel === true) {
									//alert('Del');
									val = val + '<button id="btnDeleteRow' + row.toString() + '_' + objid.toString() + '" class="' + btnClass + '" onclick="javascript:DeleteOneRec(' + id + ',' + row.toString() + ',' + objid.toString() + ');return false;">Del</button>';
								}
								if (hasEdit === true) {
									//alert('Edit');
									val = val + '<button id="btnEditRow' + row.toString() + '_' + objid.toString() + '" class="' + btnClass + '" onclick="javascript:EditOneRec(' + id + ',' + row.toString() + ',' + objid.toString() + ');return false;">Edit</button>';
								}
								if (hasView === true) {
									//alert('View');
									val = val + '<button id="btnViewRow' + row.toString() + '_' + objid.toString() + '" class="' + btnClass + '" onclick="javascript:ViewOneRec(' + id + ',' + row.toString() + ',' + objid.toString() + ');return false;">View</button>';
								}
								if (hasSpec === true) {
									val = val + '<button id="btnSpecActRow' + row.toString() + '_' + objid.toString() + '" class="' + btnClass + '" onclick="javascript:SpecialGridAction(' + id + ',' + row.toString() + ',' + col.toString() + ',' + objid.toString() + ');return false;">' + SpecLbl + '</button>';
								}
							}
							else {
								//if (col > 6) { alert('setting val Col ' + col.toString() + '/' + coltype[col] + '/' + cname + '/' + dt[row][cnameing()].toString()); }
								valStr = val;	 // 1-int, 2-money, 3-money 2prec, 4-textbox, 5-checkbox, 6-ddl, 999-pre
								switch (coltype[col]) {
									case 1:	// integer
										val = jsfNumberFormatNf(parseInt(val), 0, '.', ',');
										break;
									case 2:	// money integer
										fig = parseFloat(val);
										val = '$' + jsfNumberFormatNf(parseInt(val), 0, '.', ',');
										break;
									case 3:	// money - 2 digit
										fig = parseFloat(val);
										val = '$' + jsfNumberFormatNf(parseInt(val), 2, '.', ',');
										break;
									case 4: // input textbox
										val = '<input type="text" id="txtInputCol' + sRow + sCol + '" value="' + dt[row][cname].toString() + '" onchange="javascript:ChangeInputVal(' + id + ',' + row.toString() + ',' + col.toString() + ',' + objid.toString() + ',this.value);return false;"  style="width:' + wdth[col].toString() + 'px;';
										if (horient[col] !== '') {
											//alert(horient[col]);
											val = val + 'text-align:' + horient[col] + ';';
										}
										val = val + '" />';
										break;
									case 5: // checkbox
										val = '<input type="checkbox" id="txtInputCol' + sRow + sCol + '"';
										if (dt[row][cname].toString() === '1' || dt[row][cname].toString() === 'Yes') { val = val + ' checked="checked"'; }
										val = val + '" onchange="javascript:ChangeCheckBox(' + id + ',' + row.toString() + ',' + col.toString() + ',' + objid.toString() + ',this.checked);return false;" />';
										break;
									case 6: // drop down list
										//alert('creating ddl');
										val = dt[row][colnames[col].toString()].toString();
										val2 = '<select id="selListVal' + sRow + sCol + '" onchange="javascript:ChangeDropDownVal(' + id + ',' + objid.toString() + ',' + row.toString() + ',' + col.toString() + ', this.value);return false;" >';
										//alert('adding options');
										for (var itm = 0; itm < 20; itm++) {
											if (jsDGColDDLOpts[col][itm] !== '') {
												a = jsDGColDDLOpts[col][itm].split('|');	// '47|Name'
												//alert(val + '/' + a[0] + '/' + a[1]);
												val2 = val2 + '<option value="' + a[0] + '"';
												if (val === a[0]) { val2 = val2 + ' selected="selected"'; }
												val2 = val2 + '>' + a[1] + '</option>';
											}
										}
										val = val2 + '</select>';
										//alert('val: ' + val);
										//alert('options done');
										break;
									case 99: // full-formatted HTML
										val = PrepareHTMLForViewTx(dt[row][cname].toString(), 2) + '</pre>';
									default:
										try {
											val = dt[row][cname].toString();
										}
										catch (ex) {
											alert('Could not cast data from col ' + col.toString() + ' (' + cname + '): ' + ex.message);
										}
										//alert(val + '/' + dt[row][cname].toString());
										break;
								}
							}
						}
						td.innerHTML = val;

						//if (col > 6) { 
						//alert(val + '/' + cellclass + '/' + brdrL[col] + '/' + brdrR[col] + '/' + brdrT[col] + '/' + brdrB[col] + '/' + horient[col] + '/' + vorient[col] + '/' + wdth[col].toString() + 'px'); 
						//}
						if (cellclass.length > 0) { td.className = cellclass; }
						if (brdrL[col].length > 0) { td.style.borderLeft = brdrL[col]; }
						if (brdrR[col].length > 0) { td.style.borderRight = brdrR[col]; }
						if (brdrT[col].length > 0) { td.style.borderTop = brdrT[col]; }
						if (brdrB[col].length > 0) { td.style.borderBottom = brdrB[col]; }
						if (horient[col].length > 0) { td.style.textAlign = horient[col]; }
						if (vorient[col].length > 0) { td.style.verticalAlign = vorient[col]; }
						if (wdth[col] > 0) { td.style.width = wdth[col].toString() + 'px'; }
						if (cname.toUpperCase() === 'ACTION' && wrp === true) {
							td.style.whiteSpace = 'nowrap';
						}

						//if (col >6) { alert('appending cell - col' + col.toString()); }
						// ************************* Append cell ****************************
						tr.appendChild(td);
						//if (col >6) { alert('appended Col ' + col.toString()); }
						// aggregate if necessary
						if (aggType[col] > 0) {
							//alert('aggregates');
							switch (aggType[col]) {
								case 1:	// count
									break;
								case 2: // sum
									aggs[col] = aggs[col] + parseFloat(val);
									break;
								case 3: //avg
									if (val !== '') {
										iCount++;
										aggs[col] = aggs[col] + parseFloat(val);
									}
									break;
								case 4: //max
									fig = parseFloat(val);
									if (coltype[col] === 'int' || coltype[col] === 'dec' || coltype[col] === 'money') {
										if (fig > aggs[col]) { aggs[col] = fig; }
									}
									else {
										if (val > vals[col]) { vals[col] = val; }
									}
									break;
								case 5: //min
									fig = parseFloat(val);
									if (coltype[col] === 'int' || coltype[col] === 'dec' || coltype[col] === 'money') {
										if (fig < aggs[col]) { aggs[col] = fig; }
									}
									else {
										if (val < vals[col]) { vals[col] = val; }
									}
									break;
								default: // do nothing
									break;
							}
						}
					}
				}

				//alert('appending row to body');

				// ******************* append row to body ***************************
				bdy.appendChild(tr);

			}
			//alert(dt.length + ' Rows inserted');
			if (showAggs === true) {
				tr = document.createElement("tr");
				for (var col = 0; col < nCol; col++) {
					sCol = col.toString();
					if (sCol.length === 1) { sCol = '0' + sRow; }
					td = document.createElement("td");
					td.id = idprefix + 'R' + sRow + 'Col' + sCol;
					if (coltype[col] === 'int' || coltype[col] === 'dec' || coltype[col] === 'money') {
						td.innerHTML = jsfNumberFormatNf(agg[col], aggprec, '.', ',');
					}
					else {
						td.innerHTML = vals[col].toString();
					}
					td.className = cellclass;
					td.style.borderLeft = brdrL[col];
					td.style.borderRight = brdrR[col];
					td.style.borderTop = brdrT[col];
					td.style.borderBottom = brdrB[col];
					td.style.textAlign = horient[col];
					td.style.verticalAlign = vorient[col];
					td.style.width = wdth.toString() + 'px';
					tr.appendChild(td);
				}
				bdy.appendChild(tr);
			}
		}
		else {
			// show empty row
			tr = document.createElement("tr");
			td = document.createElement("td");
			td.id = idprefix + 'R00Col00';
			td.innerHTML = 'No rows were found matching your criteria.';
			td.className = cellclass;
			td.style.borderLeft = brdrL[0];
			td.style.borderRight = brdrR[0];
			td.style.borderTop = brdrT[0];
			td.style.borderBottom = brdrB[0];
			td.style.textAlign = 'center';
			td.style.verticalAlign = 'top';
			td.colSpan = nCol.toString();
			//td.style.width = wdth[].toString() + 'px';
			tr.appendChild(td);
			bdy.appendChild(tr);
		}
	}
	// show or hide pagination block
	var disptype = 'none';
	//alert('pagination Pgn:' + pg);
	if (pg === true) {
		//alert(jiNbrRowsPj[objid - 1] + '/' + nRows);
		if (jiNbrRowsPj[objid - 1] > nRows) { disptype = 'block'; }
		switch (objid) {
			case 1:
				joPaginationBarPj.style.display = disptype;
				break;
			case 2:
				joPaginationBarPj2.style.display = disptype;
				break;
			case 3:
				//alert(disptype);
				joPaginationBarPj3.style.display = disptype;
				break;
			case 4:
				joPaginationBarPj4.style.display = disptype;
				break;
			case 5:
				joPaginationBarPj5.style.display = disptype;
				break;
			case 6:
				joPaginationBarPj6.style.display = disptype;
				break;
			case 7:
				joPaginationBarPj7.style.display = disptype;
				break;
			case 8:
				joPaginationBarPj8.style.display = disptype;
				break;
			case 9:
				joPaginationBarPj9.style.display = disptype;
				break;
			case 10:
				joPaginationBarPj10.style.display = disptype;
				break;
			case 11:
				joPaginationBarPj11.style.display = disptype;
				break;
			case 12:
				joPaginationBarPj12.style.display = disptype;
				break;
			case 13:
				joPaginationBarPj13.style.display = disptype;
				break;
			case 14:
				joPaginationBarPj14.style.display = disptype;
				break;
			case 15:
				joPaginationBarPj15.style.display = disptype;
				break;
			case 16:
				joPaginationBarPj16.style.display = disptype;
				break;
			case 17:
				joPaginationBarPj17.style.display = disptype;
				break;
			case 18:
				joPaginationBarPj18.style.display = disptype;
				break;
			case 19:
				joPaginationBarPj19.style.display = disptype;
				break;
			case 20:
				joPaginationBarPj20.style.display = disptype;
				break;
			default:
				break;
		}
	}
	return bdy;
}

function EmptyDDLListsDg() {
	for (var row = 0; row < 40; row++) {
		for (var col = 0; col < 20; col++) {
			jsDGColDDLOpts[row][col] = '';
		}
	}
	//alert('finished');
	return false;
}
