/* Tabs.js - Last updated by S. Meeds on 4/7/2015
 -- requires Pagination.js, GenUtilities.js, DataGrids.js
 -- Code checked 5/28/2015
Contents:
  initializeColSettings(nbrTabs, MaxNbrCols)
	initializeTabDataSettings()
	SetTabsFormatTb(brdr, bColor, fColor, thbColor, thfColor, tfbColor, tffColor, altColor, hlColor, tbClass, cellClass, tbHdrClass, tbFtrClass, tbSubHdrClass, MaintblClass, ToolbarClass, BtnClass, BtnStyle, SelClass, fontsz, fontfam, sPad, lnht, cellht, subHdrOrient, hdrbld, bld)
  SetOneTabData(iTab, aggLabel, altRowA, NbrCols, NbrHdrRows, iEdit, iPadDiv, isLocked, HasParamBar, showRowNbr, showTotals, ovrflw, idCol, vwCol, edtCol, delCol, lnk1Col, lnk2Col, lnk3Col, colDataN, colDataT, DataSrc)
  SetParamsFormatTb(bColor, fColor, fontsz, fontfam)
  LoadTabSortData(iTab, tabData)
  LoadTabFilterData(iTab, tabData)
  EstablishTabsTb(divName, prefx, ht, wdth, NbrTabs, HasBrdr, tabData, hdrCtrContent, ftrContent, activeContent, ftrOrient, Paginate, incPath, LateBindingOn, objid)
  CreateOneTabTb(obj, iTab, prefx, ht, wdth, HasBrdr, tabData, hdrCtrContent, ftrContent, activeContent, ftrOrient, Paginate, incPath, LateBindingOn, bAddNew, bDataGrid, bFilter, bPaginate, bSort, bToolbar, bUpdate, objid)
  CreateToolbarTb(iTab, pref, iPRows, hdrCtrContent, TabDataTitle, bAddNew, bUpdate, bPaginate, objid)
  CreatePaginateDivTb(iTab, pref, fname, incPath, objid)
  CreateStatusDivTb(iTab, pref, lblPref, fColor, boldSet, objid)
  CreateContentDivTb(iTab, pref, content, wdth, ht, mleft, mtop, lpad, rpad, tpad, bpad, objid)
  formatOneTabTb(tabid, ht, wdth, bColor, fColor, fSize, sFont)
  InitiateTabControl(tabctlName, NbrTabs, iActiveTab, ht, wdth, bColor, fColor, fSize, sFont, tb0, tb1, tb2, tb3, tb4, tb5, tb6, tb7, tb8, tb9, tb10, tb11, tb12, tb13, tb14, tb15, tb16, tb17, tb18, tb19, tb20)
  ActivateOneTabTb(tabctlName, tabid)
  HideVisibleTab()
  setTabsStdAppearance(ht, wdth, bColor, fColor, fSize, sFont)
  showTabContents(tabid)
*/

var jsTBVersion = '1.0.0';
var jsTBVersDate = '2/23/2015';

var jbTBTab0Visible = false;
var jbTBTab1Visible = false;
var jbTBTab2Visible = false;
var jbTBTab3Visible = false;
var jbTBTab4Visible = false;
var jbTBTab5Visible = false;
var jbTBTab6Visible = false;
var jbTBTab7Visible = false;
var jbTBTab8Visible = false;
var jbTBTab9Visible = false;
var jbTBTab10Visible = false;
var jbTBTab12Visible = false;
var jbTBTab11Visible = false;
var jbTBTab13Visible = false;
var jbTBTab14Visible = false;
var jbTBTab15Visible = false;
var jbTBTab16Visible = false;
var jbTBTab17Visible = false;
var jbTBTab18Visible = false;
var jbTBTab19Visible = false;
var jbTBTab20Visible = false;

var jiTBActiveTab = 0;
var jiTBFontSize = 10;
var jiTBHeight;
var jiTBNbrTabs = 0;
var jiTBWidth;

var joTBTabCtrl;
var joTBTab0;
var joTBTab1;
var joTBTab2;
var joTBTab3;
var joTBTab4;
var joTBTab5;
var joTBTab6;
var joTBTab7;
var joTBTab8;
var joTBTab9;
var joTBTab10;
var joTBTab11;
var joTBTab12;
var joTBTab13;
var joTBTab14;
var joTBTab15;
var joTBTab16;
var joTBTab17;
var joTBTab18;
var joTBTab19;
var joTBTab20;

var jsTBAltRowColor = '';
var jsTBBold = '';
var jsTBBColor = '#FFFFFF';
var jsTBBtnClass = '';
var jsTBBtnStyle = 'font-size:10pt;font-family:Calibri;text-align:center;vertical-align:middle;line-height:16px;height:20px;padding-left:4px;padding-right:4px;';
var jsTBCellClass = '';
var jsTBCellHeight = '';
var jsTBFColor = '#000000';
var jsTBFontFam = 'Calibri';
var jsTBFontSize = '10pt';
var jsTBFtrbColor = '#FFFFFF';
var jsTBFtrfColor = '#000000';
var jsTBHdrBold = '';
var jsTBHighLtColor = '';
var jsTBTabFtrClass = '';
var jsTBHdrBColor = '#FFFFFF';
var jsTBHdrFColor = '#000000';
var jsTBLnHeight = '';
var jsTBMainTblClass = '';
var jsTBPad = '';
var jsTBParamBColor = '#FFFFFF';
var jsTBParamFColor = '#000000';
var jsTBParamFontSz = '10pt';
var jsTBParamFontFam = 'Calibri';
var jsTBSelectClass = '';
var jsTBStdBorder = '1px solid gray';
var jsTBSubHdrClass = '';
var jsTBSubHdrOrient = '';
var jsTBTabClass = '';
var jsTBTabHdrClass = '';
var jsTBToolbarClass = '';

var jaTab0Sort = createDimension2ArrayGu(2, 3, 1);
var jaTab1Sort = createDimension2ArrayGu(2, 3, 1);
var jaTab2Sort = createDimension2ArrayGu(2, 3, 1);
var jaTab3Sort = createDimension2ArrayGu(2, 3, 1);
var jaTab4Sort = createDimension2ArrayGu(2, 3, 1);
var jaTab5Sort = createDimension2ArrayGu(2, 3, 1);
var jaTab6Sort = createDimension2ArrayGu(2, 3, 1);
var jaTab7Sort = createDimension2ArrayGu(2, 3, 1);
var jaTab8Sort = createDimension2ArrayGu(2, 3, 1);
var jaTab9Sort = createDimension2ArrayGu(2, 3, 1);
var jaTab10Sort = createDimension2ArrayGu(2, 3, 1);
var jaTab11Sort = createDimension2ArrayGu(2, 3, 1);
var jaTab12Sort = createDimension2ArrayGu(2, 3, 1);
var jaTab13Sort = createDimension2ArrayGu(2, 3, 1);
var jaTab14Sort = createDimension2ArrayGu(2, 3, 1);
var jaTab15Sort = createDimension2ArrayGu(2, 3, 1);
var jaTab16Sort = createDimension2ArrayGu(2, 3, 1);
var jaTab17Sort = createDimension2ArrayGu(2, 3, 1);
var jaTab18Sort = createDimension2ArrayGu(2, 3, 1);
var jaTab19Sort = createDimension2ArrayGu(2, 3, 1);
var jaTab20Sort = createDimension2ArrayGu(2, 3, 1);
var jaTab0Filter = createDimension2ArrayGu(2, 3, 1);
var jaTab1Filter = createDimension2ArrayGu(2, 3, 1);
var jaTab2Filter = createDimension2ArrayGu(2, 3, 1);
var jaTab3Filter = createDimension2ArrayGu(2, 3, 1);
var jaTab4Filter = createDimension2ArrayGu(2, 3, 1);
var jaTab5Filter = createDimension2ArrayGu(2, 3, 1);
var jaTab6Filter = createDimension2ArrayGu(2, 3, 1);
var jaTab7Filter = createDimension2ArrayGu(2, 3, 1);
var jaTab8Filter = createDimension2ArrayGu(2, 3, 1);
var jaTab9Filter = createDimension2ArrayGu(2, 3, 1);
var jaTab10Filter = createDimension2ArrayGu(2, 3, 1);
var jaTab11Filter = createDimension2ArrayGu(2, 3, 1);
var jaTab12Filter = createDimension2ArrayGu(2, 3, 1);
var jaTab13Filter = createDimension2ArrayGu(2, 3, 1);
var jaTab14Filter = createDimension2ArrayGu(2, 3, 1);
var jaTab15Filter = createDimension2ArrayGu(2, 3, 1);
var jaTab16Filter = createDimension2ArrayGu(2, 3, 1);
var jaTab17Filter = createDimension2ArrayGu(2, 3, 1);
var jaTab18Filter = createDimension2ArrayGu(2, 3, 1);
var jaTab19Filter = createDimension2ArrayGu(2, 3, 1);
var jaTab20Filter = createDimension2ArrayGu(2, 3, 1);

var jaTBColDataN = [0, 0, 0];
var jaTBColDataT = [0, 0, 0];

var jaTBAggLabel = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];  
var jaTBaltRowA = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
var jaTBDataSrc = [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null];
var jaTBDelCol = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
var jaTBEdtCol = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
var jaTBGridNbrCols = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
var jaTBIDCol = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
var jaTBiPadDiv = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
var jaTBIsEdit = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]; 
var jaTBIsLocked = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
var jaTBLnk1Col = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
var jaTBLnk2Col = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
var jaTBLnk3Col = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
var jaTBNbrHdrRows = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
var jaTBOvrflw = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
var jaTBParamBar = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
var jaTBShowRowNm = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]; 
var jaTBShowTotalC = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false]; 
var jaTBVwCol = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

var MyDataTab1;
var MyDataTab2;
var MyDataTab3;
var MyDataTab4;
var MyDataTab5;
var MyDataTab6;
var MyDataTab7;
var MyDataTab8;
var MyDataTab9;
var MyDataTab10;
var MyDataTab11;
var MyDataTab12;
var MyDataTab13;
var MyDataTab14;
var MyDataTab15;
var MyDataTab16;
var MyDataTab17;
var MyDataTab18;
var MyDataTab19;
var MyDataTab20;


// **************************************************************************
// Preparation
function initializeColSettings(nbrTabs, MaxNbrCols) {
	jaTBColDataN = createDimension3Array(nbrTabs, MaxNbrCols, jsDGNbrDimsN, 0);
	jaTBColDataT = createDimension3Array(nbrTabs, MaxNbrCols, jsDGNbrDimsT, 1);
}

function initializeTabDataSettings() {
	jaTBAggLabel = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
	jaTBaltRowA = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
	jaTBGridNbrCols = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
	jaTBiPadDiv = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
	jaTBIsEdit = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
	jaTBIsLocked = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
	jaTBNbrHdrRows = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
	jaTBParamBar = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
	jaTBShowRowNm = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
	jaTBShowTotalC = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];
	jaTBOvrflw = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
	jaTBVwCol = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
	jaTBEdtCol = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
	jaTBDelCol = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
	jaTBIDCol = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
	jaTBLnk1Col = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
	jaTBLnk2Col = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
	jaTBLnk3Col = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
	jaTBDataSrc = [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null];
}

function SetTabsFormatTb(brdr, bColor, fColor, thbColor, thfColor, tfbColor, tffColor, altColor, hlColor, tbClass, cellClass, tbHdrClass, tbFtrClass, tbSubHdrClass, MaintblClass, ToolbarClass, BtnClass, BtnStyle, SelClass, fontsz, fontfam, sPad, lnht, cellht, subHdrOrient, hdrbld, bld) {
	if (brdr === undefined || brdr === null) { brdr = '1px solid gray'; }
	if (altColor === undefined || altColor === null) { altColor = '#FFFFFF'; }
	if (altColor === '') { altColor = '#FFFFFF'; }
	if (hlColor === undefined || hlColor === null) { hlColor = ''; }
	if (bColor === undefined || bColor === null) { bColor = '#FFFFFF'; }
	if (fColor === undefined || fColor === null) { fColor = '#000000'; }
	if (thbColor === undefined || thbColor === null) { thbColor = '#FFFFFF'; }
	if (thfColor === undefined || thfColor === null) { thfColor = '#000000'; }
	if (tfbColor === undefined || tfbColor === null) { tfbColor = '#FFFFFF'; }
	if (tffColor === undefined || tffColor === null) { tffColor = '#000000'; }
	if (tbClass === undefined || tbClass === null) { tbClass = ''; }
	if (tbHdrClass === undefined || tbHdrClass === null) { tbHdrClass = ''; }
	if (tbFtrClass === undefined || tbFtrClass === null) { tbFtrClass = ''; }
	if (tbSubHdrClass === undefined || tbSubHdrClass === null) { tbSubHdrClass = ''; }
	if (MaintblClass === undefined || MaintblClass === null) { MaintblClass = ''; }
	if (ToolbarClass === undefined || ToolbarClass === null) { ToolbarClass = ''; }
	if (cellClass === undefined || cellClass === null) { cellClass = ''; }
	if (SelClass === undefined || SelClass === null) { SelClass = ''; }
	if (BtnStyle === undefined || BtnStyle === null) { BtnStyle = 'font-size:10pt;font-family:Calibri;text-align:center;vertical-align:middle;line-height:16px;height:20px;padding-left:4px;padding-right:4px;'; }
	if (BtnStyle === '') { BtnStyle = 'font-size:10pt;font-family:Calibri;text-align:center;vertical-align:middle;line-height:16px;height:20px;padding-left:4px;padding-right:4px;'; }
	if (BtnClass === undefined || BtnClass === null) { BtnClass = ''; }
	if (fontsz === undefined || fontsz === null) { fontsz = '10pt'; }
	if (fontfam === undefined || fontfam === null) { fontfam = 'Calibri'; }
	if (sPad === undefined || sPad === null) { sPad = '0px'; }
	if (sPad === '') { sPad = '0px'; }
	if (subHdrOrient === undefined || subHdrOrient === null) { subHdrOrient = 'left'; }
	if (subHdrOrient === '') { subHdrOrient = 'left'; }
	if (lnht === undefined || lnht === null) { lnht = '16px'; }
	if (lnht === '') { lnht = '16px'; }
	if (cellht === undefined || cellht === null) { cellht = '18px'; }
	if (cellht === '') { cellht = '18px'; }
	if (bld === undefined || bld === null) { bld = ''; }
	if (hdrbld === undefined || hdrbld === null) { hdrbld = ''; }
	if (brdr.length > 0) {
		jsTBStdBorder = brdr;
	}
	else {
		jsTBStdBorder = '1px solid gray';
	}
	if (bColor.length > 0) {
		jsTBBColor = bColor;
	}
	else {
		jsTBBColor = '#FFFFFF';
	}
	if (fColor.length > 0) {
		jsTBFColor = fColor;
	}
	else {
		jsTBFColor = '#000000';
	}
	if (tfbColor.length > 0) {
		jsTBFtrBColor = bColor;
	}
	else {
		jsTBFtrBColor = '#FFFFFF';
	}
	if (tffColor.length > 0) {
		jsTBFtrFColor = fColor;
	}
	else {
		jsTBFtrFColor = '#000000';
	}
	if (thbColor.length > 0) {
		jsTBHdrBColor = thbColor;
	}
	else {
		jsTBHdrBColor = '#FFFFFF';
	}
	if (thfColor.length > 0) {
		jsTBHdrFColor = thfColor;
	}
	else {
		jsTBHdrFColor = '#000000';
	}
	jsTBTabClass = tbClass;  // could be empty
	jsTBTabHdrClass = tbHdrClass; // could be empty
	jsTBTabFtrClass = tbFtrClass; // could be empty
	jsTBSubHdrClass = tbSubHdrClass; // could be empty
	jsTBMainTblClass = MaintblClass; // could be empty
	jsTBToolbarClass = ToolbarClass; // could be empty
	jsTBSelectClass = SelClass; // could be empty
	jsTBBtnStyle = BtnStyle; // could be empty
	jsTBBtnClass = BtnClass; // could be empty
	jsTBCellClass = cellClass; // could be empty
	jsTBFontFam = fontfam;
	jsTBFontSize = fontsz;
	jsTBPad = sPad;
	jsTBSubHdrOrient = subHdrOrient;
	jsTBLnHeight = lnht;
	jsTBCellHeight = cellht;
	jsTBBold = bld;
	jsTBHdrBold = hdrbld;
	jsTBAltRowColor = altColor;
	jsTBHighLtColor = hlColor;
}

function SetTabObject(objname) {
  $(function () {
    $("#" + objname).tabs();
  });
  $("#" + objname).tabs({ active: 1 });
  return false;
}


// 4/7/2015
function SetOneTabData(iTab, aggLabel, altRowA, NbrCols, NbrHdrRows, iEdit, iPadDiv, isLocked, HasParamBar, showRowNbr, showTotals, ovrflw, idCol, vwCol, edtCol, delCol, lnk1Col, lnk2Col, lnk3Col, colDataN, colDataT, DataSrc) {
	var n;
	var t;
	// validate/correct data
	if (iTab === undefined || iTab === null) { return 'No tab identified'; }
	if (aggLabel === undefined || aggLabel === null) { aggLabel = ''; }
	if (NbrCols === undefined || NbrCols === null) { return 'Number of columns invalid'; }
	if (NbrHdrRows === undefined || NbrHdrRows === null) { NbrHdrRows = 1; }
	if (iEdit === undefined || iEdit === null) { iEdit = false; }
	if (iPadDiv === undefined || iPadDiv === null) { iPadDiv = 0; }
	if (isLocked === undefined || isLocked === null) { isLocked = false; }
	if (HasParamBar === undefined || HasParamBar === null) { HasParamBar = false; }
	if (showRowNbr === undefined || showRowNbr === null) { showRowNbr = false; }
	if (showTotals === undefined || showTotals === null) { showTotals = false; }
	if (idCol === undefined || idCol === null) { idCol = ''; }
	if (ovrflw === undefined || ovrflw === null) { ovrflw = ''; }
	if (vwCol === undefined || vwCol === null) { vwCol = 0; }
	if (edtCol === undefined || edtCol === null) { edtCol = 0; }
	if (delCol === undefined || delCol === null) { delCol = 0; }
	if (lnk1Col === undefined || lnk1Col === null) { lnk1Col = ''; }
	if (lnk2Col === undefined || lnk2Col === null) { lnk2Col = ''; }
	if (lnk3Col === undefined || lnk3Col === null) { lnk3Col = ''; }
	if (colDataN !== undefined && colDataN !== null) {
		if (colDataN.length > 0) {
			for (var row = 0; row < colDataN.length; row++) {
				n = colDataN[row].toString().split('|');
				for (var col = 0; col < n.length; col++) {
					jaTBColDataN[iTab][row][col] = n[col].toString();
				}
			}
		}
	}
	if (colDataT !== undefined && colDataT !== null) {
		if (colDataT.length > 0) {
			for (var row2 = 0; row2 < colDataT.length; row2++) {
				t = colDataT[row2].toString().split('|');
				for (var col2 = 0; col2 < t.length; col2++) {
					jaTBColDataT[iTab][row2][col2] = t[col2].toString();
				}
			}
		}
	}

	// set values
	jaTBAggLabel[iTab] = aggLabel;
	jaTBaltRowA[iTab] = altRowA;
	jaTBGridNbrCols[iTab] = NbrCols;
	jaTBiPadDiv[iTab] = iPadDiv;
	jaTBIsEdit[iTab] = iEdit;
	jaTBIsLocked[iTab] = isLocked;
	jaTBNbrHdrRows[iTab] = NbrHdrRows;
	jaTBParamBar[iTab] = HsParamBar;
	jaTBShowRowNm[iTab] = showRowNbr;
	jaTBShowTotalC[iTab] = showTotals;
	jaTBOvrflw[iTab] = ovrflw;
	jaTBVwCol[iTab] = vwCol;
	jaTBEdtCol[iTab] = edtCol;
	jaTBDelCol[iTab] = delCol;
	jaTBIDCol[iTab] = idCol;
	jaTBLnk1Col[iTab] = lnk1Col;
	jaTBLnk2Col[iTab] = lnk2Col;
	jaTBLnk3Col[iTab] = lnk3Col;
	jaTBDataSrc[iTab] = DataSrc;
	return false;
}

function SetParamsFormatTb(bColor, fColor, fontsz, fontfam) {
	if (bColor === undefined || bColor === null) { bColor = '#FFFFFF'; }
	if (bColor === '') { bColor = '#FFFFFF'; }
	if (fColor === undefined || fColor === null) { fColor = '#000000'; }
	if (fColor === '') { fColor = '#000000'; }
	if (fontsz === undefined || fontsz === null) { fontsz = '10pt'; }
	if (fontsz === '') { fontsz = '10pt'; }
	if (fontfam === undefined || fontfam === null) { fontfam = 'Calibri'; }
	if (fontfam === '') { fontfam = 'Calibri'; }
	jsTBParamBColor = bColor;
	jsTBParamFColor = fColor;
	jsTBParamFontSz = fontsz;
	jsTBParamFontFam = fontfam;
}

function LoadTabSortData(iTab, tabData) {
	var okay = true;
	if (tabData !== undefined && tabData !== null) {
		if (tabData.length > 0) {
			for (var row = 0; row < tabData.length; row++) {
				switch (iTab) {
					case 0:
						jaTab0Sort[row][0] = tabData[row][0].toString();
						jaTab0Sort[row][1] = tabData[row][1].toString();
						jaTab0Sort[row][2] = tabData[row][2].toString();
						break;
					case 1:
						jaTab1Sort[row][0] = tabData[row][0].toString();
						jaTab1Sort[row][1] = tabData[row][1].toString();
						jaTab1Sort[row][2] = tabData[row][2].toString();
						break;
					case 2:
						jaTab2Sort[row][0] = tabData[row][0].toString();
						jaTab2Sort[row][1] = tabData[row][1].toString();
						jaTab2Sort[row][2] = tabData[row][2].toString();
						break;
					case 3:
						jaTab3Sort[row][0] = tabData[row][0].toString();
						jaTab3Sort[row][1] = tabData[row][1].toString();
						jaTab3Sort[row][2] = tabData[row][2].toString();
						break;
					case 4:
						jaTab4Sort[row][0] = tabData[row][0].toString();
						jaTab4Sort[row][1] = tabData[row][1].toString();
						jaTab4Sort[row][2] = tabData[row][2].toString();
						break;
					case 5:
						jaTab5Sort[row][0] = tabData[row][0].toString();
						jaTab5Sort[row][1] = tabData[row][1].toString();
						jaTab5Sort[row][2] = tabData[row][2].toString();
						break;
					case 6:
						jaTab6Sort[row][0] = tabData[row][0].toString();
						jaTab6Sort[row][1] = tabData[row][1].toString();
						jaTab6Sort[row][2] = tabData[row][2].toString();
						break;
					case 7:
						jaTab7Sort[row][0] = tabData[row][0].toString();
						jaTab7Sort[row][1] = tabData[row][1].toString();
						jaTab7Sort[row][2] = tabData[row][2].toString();
						break;
					case 8:
						jaTab8Sort[row][0] = tabData[row][0].toString();
						jaTab8Sort[row][1] = tabData[row][1].toString();
						jaTab8Sort[row][2] = tabData[row][2].toString();
						break;
					case 9:
						jaTab9Sort[row][0] = tabData[row][0].toString();
						jaTab9Sort[row][1] = tabData[row][1].toString();
						jaTab9Sort[row][2] = tabData[row][2].toString();
						break;
					case 10:
						jaTab10Sort[row][0] = tabData[row][0].toString();
						jaTab10Sort[row][1] = tabData[row][1].toString();
						jaTab10Sort[row][2] = tabData[row][2].toString();
						break;
					case 11:
						jaTab11Sort[row][0] = tabData[row][0].toString();
						jaTab11Sort[row][1] = tabData[row][1].toString();
						jaTab11Sort[row][2] = tabData[row][2].toString();
						break;
					case 12:
						jaTab12Sort[row][0] = tabData[row][0].toString();
						jaTab12Sort[row][1] = tabData[row][1].toString();
						jaTab12Sort[row][2] = tabData[row][2].toString();
						break;
					case 13:
						jaTab13Sort[row][0] = tabData[row][0].toString();
						jaTab13Sort[row][1] = tabData[row][1].toString();
						jaTab13Sort[row][2] = tabData[row][2].toString();
						break;
					case 14:
						jaTab14Sort[row][0] = tabData[row][0].toString();
						jaTab14Sort[row][1] = tabData[row][1].toString();
						jaTab14Sort[row][2] = tabData[row][2].toString();
						break;
					case 15:
						jaTab15Sort[row][0] = tabData[row][0].toString();
						jaTab15Sort[row][1] = tabData[row][1].toString();
						jaTab15Sort[row][2] = tabData[row][2].toString();
						break;
					case 16:
						jaTab16Sort[row][0] = tabData[row][0].toString();
						jaTab16Sort[row][1] = tabData[row][1].toString();
						jaTab16Sort[row][2] = tabData[row][2].toString();
						break;
					case 17:
						jaTab17Sort[row][0] = tabData[row][0].toString();
						jaTab17Sort[row][1] = tabData[row][1].toString();
						jaTab17Sort[row][2] = tabData[row][2].toString();
						break;
					case 18:
						jaTab18Sort[row][0] = tabData[row][0].toString();
						jaTab18Sort[row][1] = tabData[row][1].toString();
						jaTab18Sort[row][2] = tabData[row][2].toString();
						break;
					case 19:
						jaTab19Sort[row][0] = tabData[row][0].toString();
						jaTab19Sort[row][1] = tabData[row][1].toString();
						jaTab19Sort[row][2] = tabData[row][2].toString();
						break;
					case 20:
						jaTab20Sort[row][0] = tabData[row][0].toString();
						jaTab20Sort[row][1] = tabData[row][1].toString();
						jaTab20Sort[row][2] = tabData[row][2].toString();
						break;
					default:
						break;
				}
			}
		}
		else {
			okay = false;
		}
	}
	else {
		okay = false;
	}
	return okay;
}

function LoadTabFilterData(iTab, tabData) {
	var okay = true;
	if (tabData !== undefined && tabData !== null) {
		if (tabData.length > 0) {
			for (var row = 0; row < tabData.length; row++) {
				switch (iTab) {
					case 0:
						jaTab0Filter[row][0] = tabData[row][0].toString();
						jaTab0Filter[row][1] = tabData[row][1].toString();
						jaTab0Filter[row][2] = tabData[row][2].toString();
						break;
					case 1:
						jaTab1Filter[row][0] = tabData[row][0].toString();
						jaTab1Filter[row][1] = tabData[row][1].toString();
						jaTab1Filter[row][2] = tabData[row][2].toString();
						break;
					case 2:
						jaTab2Filter[row][0] = tabData[row][0].toString();
						jaTab2Filter[row][1] = tabData[row][1].toString();
						jaTab2Filter[row][2] = tabData[row][2].toString();
						break;
					case 3:
						jaTab3Filter[row][0] = tabData[row][0].toString();
						jaTab3Filter[row][1] = tabData[row][1].toString();
						jaTab3Filter[row][2] = tabData[row][2].toString();
						break;
					case 4:
						jaTab4Filter[row][0] = tabData[row][0].toString();
						jaTab4Filter[row][1] = tabData[row][1].toString();
						jaTab4Filter[row][2] = tabData[row][2].toString();
						break;
					case 5:
						jaTab5Filter[row][0] = tabData[row][0].toString();
						jaTab5Filter[row][1] = tabData[row][1].toString();
						jaTab5Filter[row][2] = tabData[row][2].toString();
						break;
					case 6:
						jaTab6Filter[row][0] = tabData[row][0].toString();
						jaTab6Filter[row][1] = tabData[row][1].toString();
						jaTab6Filter[row][2] = tabData[row][2].toString();
						break;
					case 7:
						jaTab7Filter[row][0] = tabData[row][0].toString();
						jaTab7Filter[row][1] = tabData[row][1].toString();
						jaTab7Filter[row][2] = tabData[row][2].toString();
						break;
					case 8:
						jaTab8Filter[row][0] = tabData[row][0].toString();
						jaTab8Filter[row][1] = tabData[row][1].toString();
						jaTab8Filter[row][2] = tabData[row][2].toString();
						break;
					case 9:
						jaTab9Filter[row][0] = tabData[row][0].toString();
						jaTab9Filter[row][1] = tabData[row][1].toString();
						jaTab9Filter[row][2] = tabData[row][2].toString();
						break;
					case 10:
						jaTab10Filter[row][0] = tabData[row][0].toString();
						jaTab10Filter[row][1] = tabData[row][1].toString();
						jaTab10Filter[row][2] = tabData[row][2].toString();
						break;
					case 11:
						jaTab11Filter[row][0] = tabData[row][0].toString();
						jaTab11Filter[row][1] = tabData[row][1].toString();
						jaTab11Filter[row][2] = tabData[row][2].toString();
						break;
					case 12:
						jaTab12Filter[row][0] = tabData[row][0].toString();
						jaTab12Filter[row][1] = tabData[row][1].toString();
						jaTab12Filter[row][2] = tabData[row][2].toString();
						break;
					case 13:
						jaTab13Filter[row][0] = tabData[row][0].toString();
						jaTab13Filter[row][1] = tabData[row][1].toString();
						jaTab13Filter[row][2] = tabData[row][2].toString();
						break;
					case 14:
						jaTab14Filter[row][0] = tabData[row][0].toString();
						jaTab14Filter[row][1] = tabData[row][1].toString();
						jaTab14Filter[row][2] = tabData[row][2].toString();
						break;
					case 15:
						jaTab15Filter[row][0] = tabData[row][0].toString();
						jaTab15Filter[row][1] = tabData[row][1].toString();
						jaTab15Filter[row][2] = tabData[row][2].toString();
						break;
					case 16:
						jaTab16Filter[row][0] = tabData[row][0].toString();
						jaTab16Filter[row][1] = tabData[row][1].toString();
						jaTab16Filter[row][2] = tabData[row][2].toString();
						break;
					case 17:
						jaTab17Filter[row][0] = tabData[row][0].toString();
						jaTab17Filter[row][1] = tabData[row][1].toString();
						jaTab17Filter[row][2] = tabData[row][2].toString();
						break;
					case 18:
						jaTab18Filter[row][0] = tabData[row][0].toString();
						jaTab18Filter[row][1] = tabData[row][1].toString();
						jaTab18Filter[row][2] = tabData[row][2].toString();
						break;
					case 19:
						jaTab19Filter[row][0] = tabData[row][0].toString();
						jaTab19Filter[row][1] = tabData[row][1].toString();
						jaTab19Filter[row][2] = tabData[row][2].toString();
						break;
					case 20:
						jaTab20Filter[row][0] = tabData[row][0].toString();
						jaTab20Filter[row][1] = tabData[row][1].toString();
						jaTab20Filter[row][2] = tabData[row][2].toString();
						break;
					default:
						break;
				}
			}
		}
		else {
			okay = false;
		}
	}
	else {
		okay = false;
	}
	return okay;
}


// ***********************************************************************************************************************
// MAIN TABS CALL
function EstablishTabsTb(divName, prefx, ht, wdth, NbrTabs, HasBrdr, tabData, hdrCtrContent, ftrContent, activeContent, ftrOrient, Paginate, incPath, LateBindingOn, objid) {
	// tabData: TabTitle, SubHdrTitle, TabDataTitle, Paginate, HasDataGrid, ShowToolbar, DoAddNew, DoUpdate, DoSort, SortVal, DoFilter, FilterVal, rowData
	if (LateBindingOn === undefined || LateBindingOn === null) { LateBindingOn = false;}
	var liZ;
	var bAddNew = false;
	var bDataGrid = false;
	var bFilter = false;
	var bPaginate = false;
	var bSort = false;
	var bToolbar = false;
	var bUpdate = false;
	var iPRows = 0;
	var MainCell;
	var MainRow;
	var n = '';
	var nCol = 0;
	var NewDiv;
	var NewLabel;
	var NewSubDiv;
	var sFilterVal = '';
	var sPref = '';
	var sSortVal = '';
	var sTab = '';
	var t = '';
	var tbl;
	var val = '';
	var val2 = '';
	var tabSet = document.getElementById(divName);
	if (hdrCtrContent === undefined || hdrCtrContent === null) { hdrCtrContent = ''; }
	if (activeContent === undefined || activeContent === null) { activeContent = ''; }
	if (incPath === undefined || incPath === null) { incPath = ''; }
	if (ftrOrient === undefined || ftrOrient === null) { ftrOrient = 'left'; }
	if (ftrOrient === '') { ftrOrient = 'left'; }
	if (Paginate === true) { InitializePgNbrsPj(); }

	if (ftrContent === undefined || ftrContent === null) { ftrContent = ''; }
	if (tabData === undefined || tabData === null) { return 'No Data'; }
	if (objid === undefined || objid === null) { return 'No Object ID'; }
	if (divName === undefined || divName === null) { return 'Div Name missing'; }
	if (divName === '') { return 'Div Name missing'; }
	if (NbrTabs === undefined || NbrTabs === null) { return 'NBr Tabs bad';}
	if (prefx === undefined || prefx === null) { prefx = 'PCtabs'; }
	if (prefx === '') { prefx = 'PCtabs'; }
	if (ht === undefined || ht === null) { ht = '100px'; }
	if (ht === '') { ht = '100px'; }
	if (wdth === undefined || wdth === null) { wdth = '500px'; }
	if (wdth === '') { wdth = '500px'; }
	if (hasBrdr === undefined || HasBrdr === null) { HasBrdr = true;}
	tabSet.style.textAlign = 'left';
	tabSet.style.verticalAlign = 'top';
	tabSet.style.height = ht;
	tabSet.style.width = wdth;
	tabSet.style.fontSize = fsize;
	tabSet.style.backgroundColor = bColor;
	tabSet.style.color = fColor;

	// add tab headers
	var ul1 = document.createElement("ul");
	ul1.id = 'ulMainPCTabHdr' + objid.toString();
	ul1.className = 'tabs container';
	ul1.style.listStyle = 'none';
	ul1.style.backgroundColor = thbColor;
	ul1.style.color = thfColor;
	ul1.borderBottom = '1px solid gray';
	ul1.borderTop = 'none';
	ul1.borderLeft = 'none';
	ul1.borderRight = 'none';
	ul1.marginBottom = '0px';
	ul1.paddingBottom = '0px';

	// establish Hdr tab rows
	for (var tb = 0; tb < NbrTabs; tb++) {
		sTab = (tb+1).toString();
		liZ = document.createElement('li');
		liZ.className = tabHdrClass;
		liZ.style.borderBottom = 'none';
		liZ.innerHTML = '<a href="#' + prefx + sTab + '" onclick="javascript:ActivateOneTabPC(' + sTab + ');return false;">' + tabData[tb].TabTitle.toString() + '</a>';
		ul1.appendChild(liZ);
	}
	tabSet.appendChild(ul1);

	// add tabs
	for (var tb2 = 0; tb2 < NbrTabs; t2b++) {
		bAddNew = false;
		bDataGrid = false;
		bFilter = false;
		bPaginate = false;
		bSort = false;
		bToolbar = false;
		bUpdate = false;
		if (parseInt(tabData[tb2].ShowToolbar, 10) === 1) {bToolbar = true;}
		if (parseInt(tabData[tb2].DoUpdate, 10) === 1) {bUpdate = true;}
		if (parseInt(tabData[tb2].DoAddNew, 10) === 1) {bAddNew = true;}
		if (parseInt(tabData[tb2].Paginate, 10) === 1) { bPaginate = true; }
		if (parseInt(tabData[tb2].DoSort, 10) === 1) { bSort = true; }
		if (parseInt(tabData[tb2].DoFilter, 10) === 1) { bFilter = true; }
		if (parseInt(tabData[tb2].HasDataGrid, 10) === 1) { bDataGrid = true; }
		tabSet.appendChild(CreateOneTabTb(obj, tb2, prefx, ht, wdth, HasBrdr, tabData, hdrCtrContent, ftrContent, activeContent, ftrOrient, Paginate, incPath, LateBindingOn, bAddNew, bDataGrid, bFilter, bPaginate, bSort, bToolbar, bUpdate, objid));
	}
	return false;
}

// Used by Main Tabs Call
function CreateOneTabTb(obj, iTab, prefx, ht, wdth, HasBrdr, tabData, hdrCtrContent, ftrContent, activeContent, ftrOrient, Paginate, incPath, LateBindingOn, bAddNew, bDataGrid, bFilter, bPaginate, bSort, bToolbar, bUpdate, objid) {
	var liZ;
	var MainCell;
	var MainRow;
	var n = '';
	var nCol = 0;
	var NewDiv;
	var NewLabel;
	var NewSubDiv;
	var sFilterVal = '';
	var sPref = '';
	var sSortVal = '';
	var sTab = '';
	var t = '';
	var tbl;
	var val = '';
	var val2 = '';
	var iPRows = jiaPgSizePj[iTab];
	sTab = (iTab + 1).toString();
	NewDiv = document.createElement('div');
	NewDiv.id = prefx + sTab;
	NewDiv.className = tabClass;
	NewDiv.style.height = ht;
	NewDiv.style.width = wdth;
	if (HasBrdr === true) {
		NewDiv.style.border = jsTBStdBorder;
	}
	NewDiv.style.borderTop = 'none';
	tbl = document.createElement("table");
	tbl.id = 'tbl' + prefx + sTab + '_' + objid.toString();
	tbl.className = jsTBMainTblClass;
	tbl.style.width = '100%';
	tbl.style.padding = jsTBPad;
	tbl.style.borderSpacing = '0px';
	tbl.style.borderCollapse = 'collapse';
	tbl.style.marginTop = '0px';
	// attach header row
	MainRow = document.createElement('tr');
	MainRow.id = 'trTabHdr' + sTab + '_' + objid.toString();
	MainCell = document.createElement('th');
	MainCell.id = 'thTabHdr' + sTab + '_' + objid.toString();
	MainCell.className = jsTBSubHdrClass;
	MainCell.style.textAlign = jsTBSubHdrOrient;
	MainCell.innerHTML = tabData[iTab].SubHdrTitle.toString();
	MainRow.appendChild(MainCell);
	tbl.appendChild(MainRow);
	if (bToolbar === true) {
		MainRow = CreateToolbarTb(iTab, 'BtnBarTab', iPRows, hdrCtrContent, tabData[iTab].TabDataTitle, bAddNew, bUpdate, bPaginate, objid);
		tbl.appendChild(MainRow);
	}
	// END OF TOOLBAR section

	// add activecontent form fields
	if (activeContent.length > 0) {
		MainRow = document.createElement('tr');
		MainRow.id = 'trActvContentTab' + sTab + '_' + objid.toString();
		MainCell = document.createElement('td');
		MainCell.id = 'tdActvContentTab' + sTab + '_' + objid.toString();
		NewSubDiv = CreateContentDivTb(iTab, 'divContentHolder', activeContent, '100%', null, '', '4px', '', '', '', '', objid);
		MainCell.appendChild(NewSubDiv);
		MainRow.appendChild(MainCell);
		tbl.appendChild(MainRow);
	}
	// add data header row
	if (bDataGrid === true) {
		// add header
		MainRow = document.createElement('tr');
		MainRow.id = 'trDataGridHdrTab' + sTab + '_' + objid.toString();
		MainCell = document.createElement('td');
		MainCell.id = 'tdDataGridHdrTab' + sTab + '_' + objid.toString();
		MainCell.style.textAlign = 'left';
		MainCell.appendChild(CreateContentDivTb(iTab, 'divDataGridLabel', '&nbsp;&nbsp;&nbsp;<label id="lblTaskTmSel" style="width:240px;color:Blue;font-weight:bold;font-size:11pt;" >Task Team Selection:</label>', '100%', null, '', '4px', '', '', '', '', objid));
		MainRow.appendChild(MainCell);
		tbl.appendChild(MainRow);
		NewSubDiv = document.createElement('div');
		val = 'divDataGrid' + sTab + '_' + objid.toString();
		NewSubDiv.id = val;
		val2 = 'tblDataGrid' + sTab + '_' + objid.toString();
		sPref = 'trc' + sTab + '_';
		nCol = jaTBGridNbrCols[objid];
		for (var col = 0; col < nCol; col++) {
			//n: 0-col, 1-wdth, 2-typ, 3-iCast, 4-hlt, 5-tgt, 6-agg, 7-iSort, 8-iFilter, 9-iVanish, 10-hdrCSpan, 11-hdrRSpan, 12-iGroup, 13-iWdthFixed, 14-iPadDiv, 15-iEdit, 16-hl, 17-iBoldset, 18-isHl, 19-showToolTipVal
			FillOneColArrayDataNDg(col, jaTBColDataN[iTab][col][1], jaTBColDataN[iTab][col][2], jaTBColDataN[iTab][col][3], jaTBColDataN[iTab][col][4], jaTBColDataN[iTab][col][5], jaTBColDataN[iTab][col][6], jaTBColDataN[iTab][col][7], jaTBColDataN[iTab][col][8], jaTBColDataN[iTab][col][9], jaTBColDataN[iTab][col][10], jaTBColDataN[iTab][col][11], jaTBColDataN[iTab][col][12], jaTBColDataN[iTab][col][13], jaTBColDataN[iTab][col][14], jaTBColDataN[iTab][col][15], jaTBColDataN[iTab][col][16], jaTBColDataN[iTab][col][17], jaTBColDataN[iTab][col][18], jaTBColDataN[iTab][col][19], 0, 0, 0, 0, 0, 0);
			//t: 0-nCol, 1-datacol, 2-hOrient, 3-vOrient, 4-fmt, 5-vis, 6-hdrTxt, 7-hdrBld, 8-hdrbColor, 9-hdrfColor, 10-defVal, 11-blankVal, 12-lnkV1CNm, 13-lnkV2CNm, 14-lnkV3CNm, 15-radGrpName, 16-chkval1, 17-t2, 18-t3, 19-t4, 20-t5, 21-contenttype
			FillOneColArrayDataTDg(col, jaTBColDataT[iTab][col][1], jaTBColDataT[iTab][col][2], jaTBColDataT[iTab][col][3], jaTBColDataT[iTab][col][4], jaTBColDataT[iTab][col][5], jaTBColDataT[iTab][col][6], jaTBColDataT[iTab][col][7], jaTBColDataT[iTab][col][8], jaTBColDataT[iTab][col][9], jaTBColDataT[iTab][col][10], jaTBColDataT[iTab][col][11], jaTBColDataT[iTab][col][12], jaTBColDataT[iTab][col][13], jaTBColDataT[iTab][col][14], jaTBColDataT[iTab][col][15], jaTBColDataT[iTab][col][16], '', '', '', '', jaTBColDataT[iTab][col][21]);
		}

		FormDataGridHdrDg(val, val2, sPref, nCol, jaTBNbrHdrRows[objid], 'center', 'middle', jsTBHdrBColor, jsTBHdrFColor, jsTBStdBorder, jsTBPad, jsTBPad, jsTBPad, jsTBPad, jsTBTabHdrClass, objid);
		setGridFormattingDg(jsTBFColor, jsTBHdrFColor, jsTBFtrFColor, jsTBParamFColor, jsTBBColor, jsTBHdrBColor, jsTBFtrBColor, jsTBParamBColor, jsTBHighLtColor, jsTBLnHeight, jsTBCellHeight, jsTBFontSize, jsTBBold, jsTBStdBorder, jsTBStdBorder, jsTBStdBorder, jsTBStdBorder, jsTBPad, jsTBPad, jsTBPad, jsTBPad, jsTBPad, '', '', '', '', '0px', 0, jsTBMainTblClass, true, false, hBold, 0, jsTBAltRowColor);
		if (LateBindingOn === false) {
			var sResult = FormDataGridDg(val2, sPref, jaTBaltRowA[objid], jsTBStdBorder, jaTBShowTotalC[objid], jaTBShowRowNm[objid], jaTBAggLabel[objid], nCol, jaTBDataSrc[objid], jaTBOvrflw[objid], jaTBVwCol[objid], jaTBEdtCol[objid], jaTBDelCol[objid], jaTBIDCol[objid], jaTBLnk1Col[objid], jaTBLnk2Col[objid], jaTBLnk3Col[objid], jaTBiPadDiv[objid], jaTBParamBar[objid], jaTBIsEdit[objid], jsTBCellClass, jaTBIsLocked[objid], objid);
			//switch (objid) {
			//	case 1:
			//		var sResult = FormDataGridDg(val2, sPref, jaTBaltRowA[objid], jsTBStdBorder, jaTBShowTotalC[objid], jaTBShowRowNm[objid], jaTBAggLabel[objid], nCol, jaTBDataSrc[objid], jaTBOvrflw[objid], jaTBVwCol[objid], jaTBEdtCol[objid], jaTBDelCol[objid], jaTBIDCol[objid], jaTBLnk1Col[objid], jaTBLnk2Col[objid], jaTBLnk3Col[objid], jaTBiPadDiv[objid], jaTBParamBar[objid], jaTBIsEdit[objid], jsTBCellClass, jaTBIsLocked[objid], objid);
			//		break;
			//	case 2:
			//		var sResult = FormDataGridDg(val2, sPref, jaTBaltRowA[objid], jsTBStdBorder, jaTBShowTotalC[objid], jaTBShowRowNm[objid], jaTBAggLabel[objid], nCol, MyDataTab2, jaTBOvrflw[objid], jaTBVwCol[objid], jaTBEdtCol[objid], jaTBDelCol[objid], jaTBIDCol[objid], jaTBLnk1Col[objid], jaTBLnk2Col[objid], jaTBLnk3Col[objid], jaTBiPadDiv[objid], jaTBParamBar[objid], jaTBIsEdit[objid], jsTBCellClass, jaTBIsLocked[objid], objid);
			//		break;
			//	case 3:
			//		var sResult = FormDataGridDg(val2, sPref, jaTBaltRowA[objid], jsTBStdBorder, jaTBShowTotalC[objid], jaTBShowRowNm[objid], jaTBAggLabel[objid], nCol, MyDataTab3, jaTBOvrflw[objid], jaTBVwCol[objid], jaTBEdtCol[objid], jaTBDelCol[objid], jaTBIDCol[objid], jaTBLnk1Col[objid], jaTBLnk2Col[objid], jaTBLnk3Col[objid], jaTBiPadDiv[objid], jaTBParamBar[objid], jaTBIsEdit[objid], jsTBCellClass, jaTBIsLocked[objid], objid);
			//		break;
			//	case 4:
			//		var sResult = FormDataGridDg(val2, sPref, jaTBaltRowA[objid], jsTBStdBorder, jaTBShowTotalC[objid], jaTBShowRowNm[objid], jaTBAggLabel[objid], nCol, MyDataTab4, jaTBOvrflw[objid], jaTBVwCol[objid], jaTBEdtCol[objid], jaTBDelCol[objid], jaTBIDCol[objid], jaTBLnk1Col[objid], jaTBLnk2Col[objid], jaTBLnk3Col[objid], jaTBiPadDiv[objid], jaTBParamBar[objid], jaTBIsEdit[objid], jsTBCellClass, jaTBIsLocked[objid], objid);
			//		break;
			//	case 5:
			//		var sResult = FormDataGridDg(val2, sPref, jaTBaltRowA[objid], jsTBStdBorder, jaTBShowTotalC[objid], jaTBShowRowNm[objid], jaTBAggLabel[objid], nCol, MyDataTab5, jaTBOvrflw[objid], jaTBVwCol[objid], jaTBEdtCol[objid], jaTBDelCol[objid], jaTBIDCol[objid], jaTBLnk1Col[objid], jaTBLnk2Col[objid], jaTBLnk3Col[objid], jaTBiPadDiv[objid], jaTBParamBar[objid], jaTBIsEdit[objid], jsTBCellClass, jaTBIsLocked[objid], objid);
			//		break;
			//	case 6:
			//		var sResult = FormDataGridDg(val2, sPref, jaTBaltRowA[objid], jsTBStdBorder, jaTBShowTotalC[objid], jaTBShowRowNm[objid], jaTBAggLabel[objid], nCol, MyDataTab6, jaTBOvrflw[objid], jaTBVwCol[objid], jaTBEdtCol[objid], jaTBDelCol[objid], jaTBIDCol[objid], jaTBLnk1Col[objid], jaTBLnk2Col[objid], jaTBLnk3Col[objid], jaTBiPadDiv[objid], jaTBParamBar[objid], jaTBIsEdit[objid], jsTBCellClass, jaTBIsLocked[objid], objid);
			//		break;
			//	case 7:
			//		var sResult = FormDataGridDg(val2, sPref, jaTBaltRowA[objid], jsTBStdBorder, jaTBShowTotalC[objid], jaTBShowRowNm[objid], jaTBAggLabel[objid], nCol, MyDataTab7, jaTBOvrflw[objid], jaTBVwCol[objid], jaTBEdtCol[objid], jaTBDelCol[objid], jaTBIDCol[objid], jaTBLnk1Col[objid], jaTBLnk2Col[objid], jaTBLnk3Col[objid], jaTBiPadDiv[objid], jaTBParamBar[objid], jaTBIsEdit[objid], jsTBCellClass, jaTBIsLocked[objid], objid);
			//		break;
			//	case 8:
			//		var sResult = FormDataGridDg(val2, sPref, jaTBaltRowA[objid], jsTBStdBorder, jaTBShowTotalC[objid], jaTBShowRowNm[objid], jaTBAggLabel[objid], nCol, MyDataTab8, jaTBOvrflw[objid], jaTBVwCol[objid], jaTBEdtCol[objid], jaTBDelCol[objid], jaTBIDCol[objid], jaTBLnk1Col[objid], jaTBLnk2Col[objid], jaTBLnk3Col[objid], jaTBiPadDiv[objid], jaTBParamBar[objid], jaTBIsEdit[objid], jsTBCellClass, jaTBIsLocked[objid], objid);
			//		break;
			//	case 9:
			//		var sResult = FormDataGridDg(val2, sPref, jaTBaltRowA[objid], jsTBStdBorder, jaTBShowTotalC[objid], jaTBShowRowNm[objid], jaTBAggLabel[objid], nCol, MyDataTab9, jaTBOvrflw[objid], jaTBVwCol[objid], jaTBEdtCol[objid], jaTBDelCol[objid], jaTBIDCol[objid], jaTBLnk1Col[objid], jaTBLnk2Col[objid], jaTBLnk3Col[objid], jaTBiPadDiv[objid], jaTBParamBar[objid], jaTBIsEdit[objid], jsTBCellClass, jaTBIsLocked[objid], objid);
			//		break;
			//	case 10:
			//		var sResult = FormDataGridDg(val2, sPref, jaTBaltRowA[objid], jsTBStdBorder, jaTBShowTotalC[objid], jaTBShowRowNm[objid], jaTBAggLabel[objid], nCol, MyDataTab10, jaTBOvrflw[objid], jaTBVwCol[objid], jaTBEdtCol[objid], jaTBDelCol[objid], jaTBIDCol[objid], jaTBLnk1Col[objid], jaTBLnk2Col[objid], jaTBLnk3Col[objid], jaTBiPadDiv[objid], jaTBParamBar[objid], jaTBIsEdit[objid], jsTBCellClass, jaTBIsLocked[objid], objid);
			//		break;
			//	case 11:
			//		var sResult = FormDataGridDg(val2, sPref, jaTBaltRowA[objid], jsTBStdBorder, jaTBShowTotalC[objid], jaTBShowRowNm[objid], jaTBAggLabel[objid], nCol, MyDataTab11, jaTBOvrflw[objid], jaTBVwCol[objid], jaTBEdtCol[objid], jaTBDelCol[objid], jaTBIDCol[objid], jaTBLnk1Col[objid], jaTBLnk2Col[objid], jaTBLnk3Col[objid], jaTBiPadDiv[objid], jaTBParamBar[objid], jaTBIsEdit[objid], jsTBCellClass, jaTBIsLocked[objid], objid);
			//		break;
			//	case 12:
			//		var sResult = FormDataGridDg(val2, sPref, jaTBaltRowA[objid], jsTBStdBorder, jaTBShowTotalC[objid], jaTBShowRowNm[objid], jaTBAggLabel[objid], nCol, MyDataTab12, jaTBOvrflw[objid], jaTBVwCol[objid], jaTBEdtCol[objid], jaTBDelCol[objid], jaTBIDCol[objid], jaTBLnk1Col[objid], jaTBLnk2Col[objid], jaTBLnk3Col[objid], jaTBiPadDiv[objid], jaTBParamBar[objid], jaTBIsEdit[objid], jsTBCellClass, jaTBIsLocked[objid], objid);
			//		break;
			//	case 13:
			//		var sResult = FormDataGridDg(val2, sPref, jaTBaltRowA[objid], jsTBStdBorder, jaTBShowTotalC[objid], jaTBShowRowNm[objid], jaTBAggLabel[objid], nCol, MyDataTab13, jaTBOvrflw[objid], jaTBVwCol[objid], jaTBEdtCol[objid], jaTBDelCol[objid], jaTBIDCol[objid], jaTBLnk1Col[objid], jaTBLnk2Col[objid], jaTBLnk3Col[objid], jaTBiPadDiv[objid], jaTBParamBar[objid], jaTBIsEdit[objid], jsTBCellClass, jaTBIsLocked[objid], objid);
			//		break;
			//	case 14:
			//		var sResult = FormDataGridDg(val2, sPref, jaTBaltRowA[objid], jsTBStdBorder, jaTBShowTotalC[objid], jaTBShowRowNm[objid], jaTBAggLabel[objid], nCol, MyDataTab14, jaTBOvrflw[objid], jaTBVwCol[objid], jaTBEdtCol[objid], jaTBDelCol[objid], jaTBIDCol[objid], jaTBLnk1Col[objid], jaTBLnk2Col[objid], jaTBLnk3Col[objid], jaTBiPadDiv[objid], jaTBParamBar[objid], jaTBIsEdit[objid], jsTBCellClass, jaTBIsLocked[objid], objid);
			//		break;
			//	case 15:
			//		var sResult = FormDataGridDg(val2, sPref, jaTBaltRowA[objid], jsTBStdBorder, jaTBShowTotalC[objid], jaTBShowRowNm[objid], jaTBAggLabel[objid], nCol, MyDataTab15, jaTBOvrflw[objid], jaTBVwCol[objid], jaTBEdtCol[objid], jaTBDelCol[objid], jaTBIDCol[objid], jaTBLnk1Col[objid], jaTBLnk2Col[objid], jaTBLnk3Col[objid], jaTBiPadDiv[objid], jaTBParamBar[objid], jaTBIsEdit[objid], jsTBCellClass, jaTBIsLocked[objid], objid);
			//		break;
			//	case 16:
			//		var sResult = FormDataGridDg(val2, sPref, jaTBaltRowA[objid], jsTBStdBorder, jaTBShowTotalC[objid], jaTBShowRowNm[objid], jaTBAggLabel[objid], nCol, MyDataTab16, jaTBOvrflw[objid], jaTBVwCol[objid], jaTBEdtCol[objid], jaTBDelCol[objid], jaTBIDCol[objid], jaTBLnk1Col[objid], jaTBLnk2Col[objid], jaTBLnk3Col[objid], jaTBiPadDiv[objid], jaTBParamBar[objid], jaTBIsEdit[objid], jsTBCellClass, jaTBIsLocked[objid], objid);
			//		break;
			//	case 17:
			//		var sResult = FormDataGridDg(val2, sPref, jaTBaltRowA[objid], jsTBStdBorder, jaTBShowTotalC[objid], jaTBShowRowNm[objid], jaTBAggLabel[objid], nCol, MyDataTab17, jaTBOvrflw[objid], jaTBVwCol[objid], jaTBEdtCol[objid], jaTBDelCol[objid], jaTBIDCol[objid], jaTBLnk1Col[objid], jaTBLnk2Col[objid], jaTBLnk3Col[objid], jaTBiPadDiv[objid], jaTBParamBar[objid], jaTBIsEdit[objid], jsTBCellClass, jaTBIsLocked[objid], objid);
			//		break;
			//	case 18:
			//		var sResult = FormDataGridDg(val2, sPref, jaTBaltRowA[objid], jsTBStdBorder, jaTBShowTotalC[objid], jaTBShowRowNm[objid], jaTBAggLabel[objid], nCol, MyDataTab18, jaTBOvrflw[objid], jaTBVwCol[objid], jaTBEdtCol[objid], jaTBDelCol[objid], jaTBIDCol[objid], jaTBLnk1Col[objid], jaTBLnk2Col[objid], jaTBLnk3Col[objid], jaTBiPadDiv[objid], jaTBParamBar[objid], jaTBIsEdit[objid], jsTBCellClass, jaTBIsLocked[objid], objid);
			//		break;
			//	case 19:
			//		var sResult = FormDataGridDg(val2, sPref, jaTBaltRowA[objid], jsTBStdBorder, jaTBShowTotalC[objid], jaTBShowRowNm[objid], jaTBAggLabel[objid], nCol, MyDataTab19, jaTBOvrflw[objid], jaTBVwCol[objid], jaTBEdtCol[objid], jaTBDelCol[objid], jaTBIDCol[objid], jaTBLnk1Col[objid], jaTBLnk2Col[objid], jaTBLnk3Col[objid], jaTBiPadDiv[objid], jaTBParamBar[objid], jaTBIsEdit[objid], jsTBCellClass, jaTBIsLocked[objid], objid);
			//		break;
			//	case 20:
			//		var sResult = FormDataGridDg(val2, sPref, jaTBaltRowA[objid], jsTBStdBorder, jaTBShowTotalC[objid], jaTBShowRowNm[objid], jaTBAggLabel[objid], nCol, MyDataTab20, jaTBOvrflw[objid], jaTBVwCol[objid], jaTBEdtCol[objid], jaTBDelCol[objid], jaTBIDCol[objid], jaTBLnk1Col[objid], jaTBLnk2Col[objid], jaTBLnk3Col[objid], jaTBiPadDiv[objid], jaTBParamBar[objid], jaTBIsEdit[objid], jsTBCellClass, jaTBIsLocked[objid], objid);
			//		break;
			//}
		}

		// add pagination bar
		if (Paginate === true) {
			NewDiv.appendChild(CreatePaginateDivTb(iTab, 'divPaginationObjects', 'incPaginationDiv', incPath, objid));
		}
	}
	NewDiv.appendChild(tbl);

	// append status block
	NewDiv.appendChild(CreateStatusDivTb(iTab, 'divDataGridStatus', 'lblTDGStatus', 'maroon', 'bold', objid));

	// append footer
	if (ftrContent.length > 0) {
		NewDiv.appendChild(CreateContentDivTb(iTab, 'divTabFtr', ftrContent, '100%', null, '', '4px', '', '', '', '', objid));
	}

	return NewDiv;
}

function CreateToolbarTb(iTab, pref, iPRows, hdrCtrContent, TabDataTitle, bAddNew, bUpdate, bPaginate, objid) {
	var MainCell;
	var MainRow;
	var sFilterVal = '';
	var sSortVal = '';
	var sTab = iTab.toString();
	var val = '';
	var val2 = '';

	MainRow = document.createElement('tr');
	MainRow.id = 'tr' + pref + sTab + '_' + objid.toString();
	MainCell = document.createElement('td');
	MainCell.id = 'td' + pref + sTab + '_' + objid.toString();
	val = '<table style="width:100%;padding:0px;border-spacing:0px;vertical-align:middle;height:22px;"><tr>';
	if (jsTBToolbarClass.length > 0) {
		MainCell.className = jsTBToolbarClass;
	}
	else {
		MainCell.style.height = '18px';
		MainCell.style.width = '100%';
		MainCell.style.textAlign = 'center';
		MainCell.style.verticalAlign = 'middle';
		MainCell.style.lineHeight = '16px';
		MainCell.style.backgroundColor = '#A0E0FF';
		MainCell.style.padding = '4px 0px 4px 0px';
	}
	if (bAddNew === true) {
		val = val + '<td style="width:200px;vertical-align:middle;text-align:center;">';
		val = val + '<button id="btnAddNewTab' + sTab + '_' + objid.toString() + '" onclick="javascrpt:AddOneTabRec(' + sTab + ',' + objid.toString() + ');return false;" class="' + jsTBBtnClass + '" style="' + jsTBBtnStyle + 'width:184px;" >Add New Team Member</button>';
		val = val + '</td>';
	}
	if (bUpdate === true) {
		val = val + '<td style="width:160px;vertical-align:middle;text-align:center;">';
		val = val + '<button id="btnUpdateTab' + sTab + 'Data' + objid.toString() + '" class="' + jsTBBtnClass + '" onclick="javascript:UpdateTabData(' + sTab + ',' + objid.toString() + ');return false;" style="' + jsTBBtnStyle + 'width:140px;">Update ' + TabDataTitle + ' Data</button>';
		val = val + '</td>';
	}
	if (hdrCtrContent.length > 0) {
		val = val + '<td style="vertical-align:middle;text-align:center;">' + hdrCtrContent + '</td>';
	}
	if (bPaginate === true) {
		val2 = '';
		if (iTab > 0) { val2 = sTab; }
		val = val + '<td style="vertical-align:middle;text-align:center;">';
		val = val + '&nbsp;Page&nbsp;Size:&nbsp;<select id="selPageSize' + val2 + '" onchange="javascript:ChangePgSizePj(' + val2 + ',this[this.selectedIndex].value);return false;" class="' + jsTBSelectClass + '">';
		val = val + '<option value="10"';
		if (iPRows === 10) { val = val + ' selected="selected"'; }
		val = val + '>10 Rows</option>';
		val = val + '<option value="20"';
		if (iPRows === 20) { val = val + ' selected="selected"'; }
		val = val + '>20 Rows</option>';
		val = val + '<option value="30"';
		if (iPRows === 30) { val = val + ' selected="selected"'; }
		val = val + '>30 Rows</option>';
		val = val + '<option value="40"';
		if (iPRows === 40) { val = val + ' selected="selected"'; }
		val = val + '>40 Rows</option>';
		val = val + '<option value="50"';
		if (iPRows === 50) { val = val + ' selected="selected"'; }
		val = val + '>50 Rows</option>';
		val = val + '<option value="100"';
		if (iPRows === 100) { val = val + ' selected="selected"'; }
		val = val + '>100 Rows</option>';
		val = val + '</select>&nbsp;&nbsp;&nbsp;';
		val = val + '</td>';
	}
	if (bSort === true) {
		sSortVal = tabData[iTab].SortVal.toString();
		val = val + '<td style="vertical-align:middle;text-align:center;">';
		val = val + '&nbsp;Sort&nbsp;By:&nbsp;<select id="selDataSort' + sTab + '_' + objid.toString() + '" onchange="javascript:ChangeTabDataSort(this[this.selectedIndex].value,' + sTab + ',' + objid.ToString() + ');return false;" class="' + jsTBSelectClass + '">';
		switch (iTab) {
			case 0:
				for (var t10 = 0; t10 < jaTab0Sort.length; t10++) {
					val = val + '<option value="' + jaTab0Sort[t10][0] + '"';
					if (jaTab0Sort[t10][0] === sSortVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab0Sort[t10][1] + '</option>';
				}
				break;
			case 1:
				for (var t11 = 0; t11 < jaTab1Sort.length; t11++) {
					val = val + '<option value="' + jaTab1Sort[t11][0] + '"';
					if (jaTab1Sort[t11][0] === sSortVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab1Sort[t11][1] + '</option>';
				}
				break;
			case 2:
				for (var t12 = 0; t12 < jaTab2Sort.length; t12++) {
					val = val + '<option value="' + jaTab2Sort[t12][0] + '"';
					if (jaTab2Sort[t12][0] === sSortVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab2Sort[t12][1] + '</option>';
				}
				break;
			case 3:
				for (var t13 = 0; t13 < jaTab3Sort.length; t13++) {
					val = val + '<option value="' + jaTab3Sort[t13][0] + '"';
					if (jaTab3Sort[t13][0] === sSortVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab3Sort[t13][1] + '</option>';
				}
				break;
			case 4:
				for (var t14 = 0; t14 < jaTab4Sort.length; t14++) {
					val = val + '<option value="' + jaTab4Sort[t14][0] + '"';
					if (jaTab4Sort[t14][0] === sSortVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab4Sort[t14][1] + '</option>';
				}
				break;
			case 5:
				for (var t15 = 0; t15 < jaTab5Sort.length; t15++) {
					val = val + '<option value="' + jaTab5Sort[t15][0] + '"';
					if (jaTab5Sort[t15][0] === sSortVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab5Sort[t15][1] + '</option>';
				}
				break;
			case 6:
				for (var t16 = 0; t16 < jaTab6Sort.length; t16++) {
					val = val + '<option value="' + jaTab6Sort[t16][0] + '"';
					if (jaTab6Sort[t16][0] === sSortVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab6Sort[t16][1] + '</option>';
				}
				break;
			case 7:
				for (var t17 = 0; t17 < jaTab7Sort.length; t17++) {
					val = val + '<option value="' + jaTab7Sort[t17][0] + '"';
					if (jaTab7Sort[t17][0] === sSortVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab7Sort[t17][1] + '</option>';
				}
				break;
			case 8:
				for (var t18 = 0; t18 < jaTab8Sort.length; t18++) {
					val = val + '<option value="' + jaTab8Sort[t18][0] + '"';
					if (jaTab8Sort[t18][0] === sSortVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab8Sort[t18][1] + '</option>';
				}
				break;
			case 9:
				for (var t19 = 0; t19 < jaTab9Sort.length; t19++) {
					val = val + '<option value="' + jaTab9Sort[t19][0] + '"';
					if (jaTab9Sort[t19][0] === sSortVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab9Sort[t19][1] + '</option>';
				}
				break;
			case 10:
				for (var t20 = 0; t20 < jaTab10Sort.length; t20++) {
					val = val + '<option value="' + jaTab10Sort[t20][0] + '"';
					if (jaTab10Sort[t20][0] === sSortVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab10Sort[t20][1] + '</option>';
				}
				break;
			case 11:
				for (var t21 = 0; t21 < jaTab11Sort.length; t21++) {
					val = val + '<option value="' + jaTab11Sort[t21][0] + '"';
					if (jaTab11Sort[t21][0] === sSortVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab11Sort[t21][1] + '</option>';
				}
				break;
			case 12:
				for (var t22 = 0; t22 < jaTab12Sort.length; t22++) {
					val = val + '<option value="' + jaTab12Sort[t22][0] + '"';
					if (jaTab12Sort[t22][0] === sSortVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab12Sort[t22][1] + '</option>';
				}
				break;
			case 13:
				for (var t23 = 0; t23 < jaTab13Sort.length; t23++) {
					val = val + '<option value="' + jaTab13Sort[t23][0] + '"';
					if (jaTab13Sort[t23][0] === sSortVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab13Sort[t23][1] + '</option>';
				}
				break;
			case 14:
				for (var t24 = 0; t24 < jaTab14Sort.length; t24++) {
					val = val + '<option value="' + jaTab14Sort[t24][0] + '"';
					if (jaTab14Sort[t24][0] === sSortVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab14Sort[t24][1] + '</option>';
				}
				break;
			case 15:
				for (var t25 = 0; t25 < jaTab15Sort.length; t25++) {
					val = val + '<option value="' + jaTab15Sort[t25][0] + '"';
					if (jaTab15Sort[t25][0] === sSortVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab15Sort[t25][1] + '</option>';
				}
				break;
			case 16:
				for (var t26 = 0; t26 < jaTab16Sort.length; t26++) {
					val = val + '<option value="' + jaTab16Sort[t26][0] + '"';
					if (jaTab16Sort[t26][0] === sSortVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab16Sort[t26][1] + '</option>';
				}
				break;
			case 17:
				for (var t27 = 0; t27 < jaTab17Sort.length; t27++) {
					val = val + '<option value="' + jaTab17Sort[t27][0] + '"';
					if (jaTab17Sort[t27][0] === sSortVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab17Sort[t27][1] + '</option>';
				}
				break;
			case 18:
				for (var t28 = 0; t28 < jaTab18Sort.length; t28++) {
					val = val + '<option value="' + jaTab18Sort[t28][0] + '"';
					if (jaTab18Sort[t28][0] === sSortVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab18Sort[t28][1] + '</option>';
				}
				break;
			case 19:
				for (var t29 = 0; t29 < jaTab19Sort.length; t29++) {
					val = val + '<option value="' + jaTab19Sort[t29][0] + '"';
					if (jaTab19Sort[t29][0] === sSortVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab19Sort[t29][1] + '</option>';
				}
				break;
			case 20:
				for (var t30 = 0; t30 < jaTab20Sort.length; t30++) {
					val = val + '<option value="' + jaTab20Sort[t30][0] + '"';
					if (jaTab20Sort[t30][0] === sSortVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab20Sort[t30][1] + '</option>';
				}
				break;
			default:
				break;
		}
		val = val + '</td>';
	}
	if (bFilter === true) {
		sFilterVal = tabData[iTab].FilterVal.toString();
		val = val + '<td style="vertical-align:middle;text-align:center;">';
		val = val + '&nbsp;Filter&nbsp;By:&nbsp;<select id="selDataFilter' + sTab + '_' + objid.toString() + '" onchange="javascript:ChangeTabDataFilter(this[this.selectedIndex].value,' + sTab + ',' + objid.ToString() + ');return false;" class="' + jsTBSelectClass + '">';
		switch (iTab) {
			case 0:
				for (var t10z = 0; t10z < jaTab0Filter.length; t10z++) {
					val = val + '<option value="' + jaTab0Filter[t10z][0] + '"';
					if (jaTab0Filter[t10z][0] === sFilterVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab0Filter[t10z][1] + '</option>';
				}
				break;
			case 1:
				for (var t11z = 0; t11z < jaTab1Filter.length; t11z++) {
					val = val + '<option value="' + jaTab1Filter[t11z][0] + '"';
					if (jaTab1Filter[t11z][0] === sFilterVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab1Filter[t11z][1] + '</option>';
				}
				break;
			case 2:
				for (var t12z = 0; t12z < jaTab2Filter.length; t12z++) {
					val = val + '<option value="' + jaTab2Filter[t12z][0] + '"';
					if (jaTab2Filter[t12z][0] === sFilterVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab2Filter[t12z][1] + '</option>';
				}
				break;
			case 3:
				for (var t13z = 0; t13z < jaTab3Filter.length; t13z++) {
					val = val + '<option value="' + jaTab3Filter[t13z][0] + '"';
					if (jaTab3Filter[t13z][0] === sFilterVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab3Filter[t13z][1] + '</option>';
				}
				break;
			case 4:
				for (var t14z = 0; t14z < jaTab4Filter.length; t14z++) {
					val = val + '<option value="' + jaTab4Filter[t14z][0] + '"';
					if (jaTab4Filter[t14z][0] === sFilterVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab4Filter[t14z][1] + '</option>';
				}
				break;
			case 5:
				for (var t15z = 0; t15z < jaTab5Filter.length; t15z++) {
					val = val + '<option value="' + jaTab5Filter[t15z][0] + '"';
					if (jaTab5Filter[t15z][0] === sFilterVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab5Filter[t15z][1] + '</option>';
				}
				break;
			case 6:
				for (var t16z = 0; t16z < jaTab6Filter.length; t16z++) {
					val = val + '<option value="' + jaTab6Filter[t16z][0] + '"';
					if (jaTab6Filter[t16z][0] === sFilterVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab6Filter[t16z][1] + '</option>';
				}
				break;
			case 7:
				for (var t17z = 0; t17z < jaTab7Filter.length; t17z++) {
					val = val + '<option value="' + jaTab7Filter[t17z][0] + '"';
					if (jaTab7Filter[t17z][0] === sFilterVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab7Filter[t17z][1] + '</option>';
				}
				break;
			case 8:
				for (var t18z = 0; t18z < jaTab8Filter.length; t18z++) {
					val = val + '<option value="' + jaTab8Filter[t18z][0] + '"';
					if (jaTab8Filter[t18z][0] === sFilterVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab8Filter[t18z][1] + '</option>';
				}
				break;
			case 9:
				for (var t19z = 0; t19z < jaTab9Filter.length; t19z++) {
					val = val + '<option value="' + jaTab9Filter[t19z][0] + '"';
					if (jaTab9Filter[t19z][0] === sFilterVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab9Filter[t19z][1] + '</option>';
				}
				break;
			case 10:
				for (var t20z = 0; t20z < jaTab10Filter.length; t20z++) {
					val = val + '<option value="' + jaTab10Filter[t20z][0] + '"';
					if (jaTab10Filter[t20z][0] === sFilterVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab10Filter[t20z][1] + '</option>';
				}
				break;
			case 11:
				for (var t21z = 0; t21z < jaTab11Filter.length; t21z++) {
					val = val + '<option value="' + jaTab11Filter[t21z][0] + '"';
					if (jaTab11Filter[t21z][0] === sFilterValz) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab11Filter[t21z][1] + '</option>';
				}
				break;
			case 12:
				for (var t22z = 0; t22z < jaTab12Filter.length; t22z++) {
					val = val + '<option value="' + jaTab12Filter[t22z][0] + '"';
					if (jaTab12Filter[t22z][0] === sFilterVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab12Filter[t22z][1] + '</option>';
				}
				break;
			case 13:
				for (var t23z = 0; t23z < jaTab13Filter.length; t23z++) {
					val = val + '<option value="' + jaTab13Filter[t23z][0] + '"';
					if (jaTab13Filter[t23z][0] === sFilterVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab13Filter[t23z][1] + '</option>';
				}
				break;
			case 14:
				for (var t24z = 0; t24z < jaTab14Filter.length; t24z++) {
					val = val + '<option value="' + jaTab14Filter[t24z][0] + '"';
					if (jaTab14Filter[t24z][0] === sFilterVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab14Filter[t24z][1] + '</option>';
				}
				break;
			case 15:
				for (var t25z = 0; t25z < jaTab15Filter.length; t25z++) {
					val = val + '<option value="' + jaTab15Filter[t25z][0] + '"';
					if (jaTab15Filter[t25z][0] === sFilterVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab15Filter[t25z][1] + '</option>';
				}
				break;
			case 16:
				for (var t26z= 0; t26z < jaTab16Filter.length; t26z++) {
					val = val + '<option value="' + jaTab16Filter[t26z][0] + '"';
					if (jaTab16Filter[t26z][0] === sFilterVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab16Filter[t26z][1] + '</option>';
				}
				break;
			case 17:
				for (var t27z = 0; t27z < jaTab17Filter.length; t27z++) {
					val = val + '<option value="' + jaTab17Filter[t27z][0] + '"';
					if (jaTab17Filter[t27z][0] === sFilterVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab17Filter[t27z][1] + '</option>';
				}
				break;
			case 18:
				for (var t28z = 0; t28z < jaTab18Filter.length; t28z++) {
					val = val + '<option value="' + jaTab18Filter[t28z][0] + '"';
					if (jaTab18Filter[t28z][0] === sFilterVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab18Filter[t28z][1] + '</option>';
				}
				break;
			case 19:
				for (var t29z = 0; t29z < jaTab19Filter.length; t29z++) {
					val = val + '<option value="' + jaTab19Filter[t29z][0] + '"';
					if (jaTab19Filter[t29z][0] === sFilterVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab19Filter[t29z][1] + '</option>';
				}
				break;
			case 20:
				for (var t30z = 0; t30z < jaTab20Filter.length; t30z++) {
					val = val + '<option value="' + jaTab20Filter[t30z][0] + '"';
					if (jaTab20Filter[t30z][0] === sFilterVal) { val = val + ' selected="selected"'; }
					val = val + '>' + jaTab20Filter[t30z][1] + '</option>';
				}
				break;
			default:
				break;
		}
		val = val + '</td>';
	}

	val = '</td></tr></table>';
	MainCell.innerHTML = val;
	MainRow.appendChild(MainCell);
	return MainRow;
}

function CreatePaginateDivTb(iTab, pref, fname, incPath, objid) {
	var NewSubDiv;
	var sTab = iTab.toString();
	NewSubDiv = document.createElement('div');
	NewSubDiv.id = pref + sTab + '_' + objid.toString();
	NewSubDiv.innerHTML = '<!-- #include file="' + incPath + fname + objid.toString() + '.inc" -->';
	return NewSubDiv;
}

function CreateStatusDivTb(iTab, pref, lblPref, fColor, boldSet, objid) {
	var NewSubDiv;
	var sTab = iTab.toString();
	NewSubDiv = document.createElement('div');
	NewSubDiv.id = pref + sTab + '_' + objid.toString();
	NewLabel = document.createElement('label');
	NewLabel.id = lblPref + sTab + '_' + objid.toString();
	NewLabel.style.color = fColor;
	NewLabel.style.fontWeight = boldSet;
	NewSubDiv.appendChild(NewLabel);
	return NewSubDiv;
}

function CreateContentDivTb(iTab, pref, content, wdth, ht, mleft, mtop, lpad, rpad, tpad, bpad, objid) {
	var NewSubDiv;
	var sTab = iTab.toString();
	NewSubDiv = document.createElement('div');
	NewSubDiv.id = pref + sTab + '_' + objid.toString();
	if (wdth.length > 0) {NewSubDiv.style.width = wdth; }
	if (ht !== undefined && ht !== null) {
		if (ht.length > 0 ) { NewSubDiv.style.height = ht; }
	}
	if (mleft !== undefined && mleft !== null) {
		if (mleft.length >0 ){NewSubDiv.style.marginLeft = mleft;}
	}
	if (mtop !== undefined && mtop !== null) {
		if (mtop.length >0 ){NewSubDiv.style.marginTop = mtop;}
	}
	if (lpad !== undefined && lpad !== null) {
		if (lpad.length > 0) { NewSubDiv.style.paddingLeft = lpad; }
	}
	if (rpad !== undefined && rpad !== null) {
		if (rpad.length > 0) { NewSubDiv.style.paddingRight = rpad; }
	}
	if (tpad !== undefined && tpad !== null) {
		if (tpad.length > 0) { NewSubDiv.style.paddingTop = tpad; }
	}
	if (bpad !== undefined && bpad !== null) {
		if (bpad.length > 0) { NewSubDiv.style.paddingBottom = bpad; }
	}
	NewSubDiv.innerHTML = content;
	return NewSubDiv;
}

// **************************************************************************
// Tabs UI

function formatOneTabTb(tabid, ht, wdth, bColor, fColor, fSize, sFont) {
	switch (tabid) {
		case 0:
			joTBTab0.style.height = ht.toString() + 'px';
			joTBTab0.style.width = wdth.toString() + 'px';
			joTBTab0.style.backgroundColor = bColor;
			joTBTab0.style.color = fColor;
			break;
		case 1:
			joTBTab1.style.height = ht.toString() + 'px';
			joTBTab1.style.width = wdth.toString() + 'px';
			joTBTab1.style.backgroundColor = bColor;
			joTBTab1.style.color = fColor;
			break;
		case 2:
			joTBTab2.style.height = ht.toString() + 'px';
			joTBTab2.style.width = wdth.toString() + 'px';
			joTBTab2.style.backgroundColor = bColor;
			joTBTab2.style.color = fColor;
			break;
		case 3:
			joTBTab3.style.height = ht.toString() + 'px';
			joTBTab3.style.width = wdth.toString() + 'px';
			joTBTab3.style.backgroundColor = bColor;
			joTBTab3.style.color = fColor;
			break;
		case 4:
			joTBTab4.style.height = ht.toString() + 'px';
			joTBTab4.style.width = wdth.toString() + 'px';
			joTBTab4.style.backgroundColor = bColor;
			joTBTab4.style.color = fColor;
			break;
		case 5:
			joTBTab5.style.height = ht.toString() + 'px';
			joTBTab5.style.width = wdth.toString() + 'px';
			joTBTab5.style.backgroundColor = bColor;
			joTBTab5.style.color = fColor;
			break;
		case 6:
			joTBTab6.style.height = ht.toString() + 'px';
			joTBTab6.style.width = wdth.toString() + 'px';
			joTBTab6.style.backgroundColor = bColor;
			joTBTab6.style.color = fColor;
			break;
		case 7:
			joTBTab7.style.height = ht.toString() + 'px';
			joTBTab7.style.width = wdth.toString() + 'px';
			joTBTab7.style.backgroundColor = bColor;
			joTBTab7.style.color = fColor;
			break;
		case 8:
			joTBTab8.style.height = ht.toString() + 'px';
			joTBTab8.style.width = wdth.toString() + 'px';
			joTBTab8.style.backgroundColor = bColor;
			joTBTab8.style.color = fColor;
			break;
		case 9:
			joTBTab9.style.height = ht.toString() + 'px';
			joTBTab9.style.width = wdth.toString() + 'px';
			joTBTab9.style.backgroundColor = bColor;
			joTBTab9.style.color = fColor;
			break;
		case 10:
			joTBTab10.style.height = ht.toString() + 'px';
			joTBTab10.style.width = wdth.toString() + 'px';
			joTBTab10.style.backgroundColor = bColor;
			joTBTab10.style.color = fColor;
			break;
		case 11:
			joTBTab11.style.height = ht.toString() + 'px';
			joTBTab11.style.width = wdth.toString() + 'px';
			joTBTab11.style.backgroundColor = bColor;
			joTBTab11.style.color = fColor;
			break;
		case 12:
			joTBTab12.style.height = ht.toString() + 'px';
			joTBTab12.style.width = wdth.toString() + 'px';
			joTBTab12.style.backgroundColor = bColor;
			joTBTab12.style.color = fColor;
			break;
		case 13:
			joTBTab13.style.height = ht.toString() + 'px';
			joTBTab13.style.width = wdth.toString() + 'px';
			joTBTab13.style.backgroundColor = bColor;
			joTBTab13.style.color = fColor;
			break;
		case 14:
			joTBTab14.style.height = ht.toString() + 'px';
			joTBTab14.style.width = wdth.toString() + 'px';
			joTBTab14.style.backgroundColor = bColor;
			joTBTab14.style.color = fColor;
			break;
		case 15:
			joTBTab15.style.height = ht.toString() + 'px';
			joTBTab15.style.width = wdth.toString() + 'px';
			joTBTab15.style.backgroundColor = bColor;
			joTBTab15.style.color = fColor;
			break;
		case 16:
			joTBTab16.style.height = ht.toString() + 'px';
			joTBTab16.style.width = wdth.toString() + 'px';
			joTBTab16.style.backgroundColor = bColor;
			joTBTab16.style.color = fColor;
			break;
		case 17:
			joTBTab17.style.height = ht.toString() + 'px';
			joTBTab17.style.width = wdth.toString() + 'px';
			joTBTab17.style.backgroundColor = bColor;
			joTBTab17.style.color = fColor;
			break;
		case 18:
			joTBTab18.style.height = ht.toString() + 'px';
			joTBTab18.style.width = wdth.toString() + 'px';
			joTBTab18.style.backgroundColor = bColor;
			joTBTab18.style.color = fColor;
			break;
		case 19:
			joTBTab19.style.height = ht.toString() + 'px';
			joTBTab19.style.width = wdth.toString() + 'px';
			joTBTab19.style.backgroundColor = bColor;
			joTBTab19.style.color = fColor;
			break;
		case 20:
			joTBTab20.style.height = ht.toString() + 'px';
			joTBTab20.style.width = wdth.toString() + 'px';
			joTBTab20.style.backgroundColor = bColor;
			joTBTab20.style.color = fColor;
			break;
		default:
			break;
	}
}

function InitiateTabControl(tabctlName, NbrTabs, iActiveTab, ht, wdth, bColor, fColor, fSize, sFont, tb0, tb1, tb2, tb3, tb4, tb5, tb6, tb7, tb8, tb9, tb10, tb11, tb12, tb13, tb14, tb15, tb16, tb17, tb18, tb19, tb20) {
	joTBTabCtrl = document.getElementById(tabctlName);
	jiTBNbrTabs = NbrTabs;
	setTabsStdAppearance(ht, wdth, bColor, fColor, fSize, sFont);
	if (tb0.length > 0) { joTBTab0 = document.getElementById(tb0); }
	if (tb1.length > 0 && NbrTabs > 1) { joTBTab0 = document.getElementById(tb1); }
	if (tb2.length > 0 && NbrTabs > 2) { joTBTab2 = document.getElementById(tb2); }
	if (tb3.length > 0 && NbrTabs > 3) { joTBTab3 = document.getElementById(tb3); }
	if (tb4.length > 0 && NbrTabs > 4) { joTBTab4 = document.getElementById(tb4); }
	if (tb5.length > 0 && NbrTabs > 5) { joTBTab5 = document.getElementById(tb5); }
	if (tb6.length > 0 && NbrTabs > 6) { joTBTab6 = document.getElementById(tb6); }
	if (tb7.length > 0 && NbrTabs > 7) { joTBTab7 = document.getElementById(tb7); }
	if (tb8.length > 0 && NbrTabs > 8) { joTBTab8 = document.getElementById(tb8); }
	if (tb9.length > 0 && NbrTabs > 9) { joTBTab9 = document.getElementById(tb9); }
	if (tb10.length > 0 && NbrTabs > 10) { joTBTab10 = document.getElementById(tb10); }
	if (tb11.length > 0 && NbrTabs > 11) { joTBTab11 = document.getElementById(tb11); }
	if (tb12.length > 0 && NbrTabs > 12) { joTBTab12 = document.getElementById(tb12); }
	if (tb13.length > 0 && NbrTabs > 13) { joTBTab13 = document.getElementById(tb13); }
	if (tb14.length > 0 && NbrTabs > 14) { joTBTab14 = document.getElementById(tb14); }
	if (tb15.length > 0 && NbrTabs > 15) { joTBTab15 = document.getElementById(tb15); }
	if (tb16.length > 0 && NbrTabs > 16) { joTBTab16 = document.getElementById(tb16); }
	if (tb17.length > 0 && NbrTabs > 17) { joTBTab17 = document.getElementById(tb17); }
	if (tb18.length > 0 && NbrTabs > 18) { joTBTab18 = document.getElementById(tb18); }
	if (tb19.length > 0 && NbrTabs > 19) { joTBTab19 = document.getElementById(tb19); }
	if (tb20.length > 0 && NbrTabs > 20) { joTBTab20 = document.getElementById(tb20); }
	jiTBActiveTab = iActiveTab;
}

// page must have loadObjectsTabNbr functions
function ActivateOneTabTb(tabctlName, tabid) {
	// activate tab
	$("#" + tabctlName).tabs({
		active: tabid
	});
	jiTBActiveTab = tabid + 1;
	// instantiate/show/load data for one tab
	showTabContents(tabid + 1);
}

function HideVisibleTab() {
	if (jiTBActiveTab !== 1) { joTBTab1.style.display = 'none'; }
	if (jiTBActiveTab !== 2 && jiTBNbrTabs > 1) { joTBTab2.style.display = 'none'; }
	if (jiTBActiveTab !== 3 && jiTBNbrTabs > 2) { joTBTab9.style.display = 'none'; }
	if (jiTBActiveTab !== 4 && jiTBNbrTabs > 3) { joTBTab9.style.display = 'none'; }
	if (jiTBActiveTab !== 5 && jiTBNbrTabs > 4) { joTBTab9.style.display = 'none'; }
	if (jiTBActiveTab !== 6 && jiTBNbrTabs > 5) { joTBTab9.style.display = 'none'; }
	if (jiTBActiveTab !== 7 && jiTBNbrTabs > 6) { joTBTab9.style.display = 'none'; }
	if (jiTBActiveTab !== 8 && jiTBNbrTabs > 7) { joTBTab9.style.display = 'none'; }
	if (jiTBActiveTab !== 9 && jiTBNbrTabs > 8) { joTBTab9.style.display = 'none'; }
	if (jiTBActiveTab !== 10 && jiTBNbrTabs > 9) { joTBTab9.style.display = 'none'; }
	if (jiTBActiveTab !== 11 && jiTBNbrTabs > 10) { joTBTab9.style.display = 'none'; }
	if (jiTBActiveTab !== 12 && jiTBNbrTabs > 11) { joTBTab9.style.display = 'none'; }
	if (jiTBActiveTab !== 13 && jiTBNbrTabs > 12) { joTBTab9.style.display = 'none'; }
	if (jiTBActiveTab !== 14 && jiTBNbrTabs > 13) { joTBTab9.style.display = 'none'; }
	if (jiTBActiveTab !== 15 && jiTBNbrTabs > 14) { joTBTab9.style.display = 'none'; }
	if (jiTBActiveTab !== 16 && jiTBNbrTabs > 15) { joTBTab9.style.display = 'none'; }
	if (jiTBActiveTab !== 17 && jiTBNbrTabs > 16) { joTBTab9.style.display = 'none'; }
	if (jiTBActiveTab !== 18 && jiTBNbrTabs > 17) { joTBTab9.style.display = 'none'; }
	if (jiTBActiveTab !== 19 && jiTBNbrTabs > 18) { joTBTab9.style.display = 'none'; }
	if (jiTBActiveTab !== 20 && jiTBNbrTabs > 19) { joTBTab9.style.display = 'none'; }
	return false;
}

function setTabsStdAppearance(ht, wdth, bColor, fColor, fSize, sFont) {
	jsTBBColor = bColor;
	jsTBFColor = fColor;
	jiTBWidth = wdth;
	jiTBHeight = ht;
	jiTBFontSize = fSize;
	jsTBFont = sFont;

	joTBTab1.style.height = ht.toString() + 'px';
	joTBTab1.style.width = wdth.toString() + 'px';
	joTBTab1.style.backgroundColor = bColor;
	joTBTab1.style.color = fColor;
	joTBTab1.style.fontFamily = sFont;
	joTBTab1.style.fontSize = fSize.toString() + 'pt';
	if (jiTBNbrTabs > 1) {
		joTBTab2.style.height = ht.toString() + 'px';
		joTBTab2.style.width = wdth.toString() + 'px';
		joTBTab2.style.backgroundColor = bColor;
		joTBTab2.style.color = fColor;
		joTBTab2.style.fontFamily = sFont;
		joTBTab2.style.fontSize = fSize.toString() + 'pt';
	}
	if (jiTBNbrTabs > 2) {
		joTBTab3.style.height = ht.toString() + 'px';
		joTBTab3.style.width = wdth.toString() + 'px';
		joTBTab3.style.backgroundColor = bColor;
		joTBTab3.style.color = fColor;
		joTBTab3.style.fontFamily = sFont;
		joTBTab3.style.fontSize = fSize.toString() + 'pt';
	}
	if (jiTBNbrTabs > 3) {
		joTBTab4.style.height = ht.toString() + 'px';
		joTBTab4.style.width = wdth.toString() + 'px';
		joTBTab4.style.backgroundColor = bColor;
		joTBTab4.style.color = fColor;
		joTBTab4.style.fontFamily = sFont;
		joTBTab4.style.fontSize = fSize.toString() + 'pt';
	}
	if (jiTBNbrTabs > 4) {
		joTBTab5.style.height = ht.toString() + 'px';
		joTBTab5.style.width = wdth.toString() + 'px';
		joTBTab5.style.backgroundColor = bColor;
		joTBTab5.style.color = fColor;
		joTBTab5.style.fontFamily = sFont;
		joTBTab5.style.fontSize = fSize.toString() + 'pt';
	}
	if (jiTBNbrTabs > 5) {
		joTBTab6.style.height = ht.toString() + 'px';
		joTBTab6.style.width = wdth.toString() + 'px';
		joTBTab6.style.backgroundColor = bColor;
		joTBTab6.style.color = fColor;
		joTBTab6.style.fontFamily = sFont;
		joTBTab6.style.fontSize = fSize.toString() + 'pt';
	}
	if (jiTBNbrTabs > 6) {
		joTBTab7.style.height = ht.toString() + 'px';
		joTBTab7.style.width = wdth.toString() + 'px';
		joTBTab7.style.backgroundColor = bColor;
		joTBTab7.style.color = fColor;
		joTBTab7.style.fontFamily = sFont;
		joTBTab7.style.fontSize = fSize.toString() + 'pt';
	}
	if (jiTBNbrTabs > 7) {
		joTBTab8.style.height = ht.toString() + 'px';
		joTBTab8.style.width = wdth.toString() + 'px';
		joTBTab8.style.backgroundColor = bColor;
		joTBTab8.style.color = fColor;
		joTBTab8.style.fontFamily = sFont;
		joTBTab8.style.fontSize = fSize.toString() + 'pt';
	}
	if (jiTBNbrTabs > 8) {
		joTBTab9.style.height = ht.toString() + 'px';
		joTBTab9.style.width = wdth.toString() + 'px';
		joTBTab9.style.backgroundColor = bColor;
		joTBTab9.style.color = fColor;
		joTBTab9.style.fontFamily = sFont;
		joTBTab9.style.fontSize = fSize.toString() + 'pt';
	}
	if (jiTBNbrTabs > 9) {
		joTBTab10.style.height = ht.toString() + 'px';
		joTBTab10.style.width = wdth.toString() + 'px';
		joTBTab10.style.backgroundColor = bColor;
		joTBTab10.style.color = fColor;
		joTBTab10.style.fontFamily = sFont;
		joTBTab10.style.fontSize = fSize.toString() + 'pt';
	}
	if (jiTBNbrTabs > 10) {
		joTBTab11.style.height = ht.toString() + 'px';
		joTBTab11.style.width = wdth.toString() + 'px';
		joTBTab11.style.backgroundColor = bColor;
		joTBTab11.style.color = fColor;
		joTBTab11.style.fontFamily = sFont;
		joTBTab11.style.fontSize = fSize.toString() + 'pt';
	}
	if (jiTBNbrTabs > 11) {
		joTBTab12.style.height = ht.toString() + 'px';
		joTBTab12.style.width = wdth.toString() + 'px';
		joTBTab12.style.backgroundColor = bColor;
		joTBTab12.style.color = fColor;
		joTBTab12.style.fontFamily = sFont;
		joTBTab12.style.fontSize = fSize.toString() + 'pt';
	}
	if (jiTBNbrTabs > 12) {
		joTBTab13.style.height = ht.toString() + 'px';
		joTBTab13.style.width = wdth.toString() + 'px';
		joTBTab13.style.backgroundColor = bColor;
		joTBTab13.style.color = fColor;
		joTBTab13.style.fontFamily = sFont;
		joTBTab13.style.fontSize = fSize.toString() + 'pt';
	}
	if (jiTBNbrTabs > 13) {
		joTBTab14.style.height = ht.toString() + 'px';
		joTBTab14.style.width = wdth.toString() + 'px';
		joTBTab14.style.backgroundColor = bColor;
		joTBTab14.style.color = fColor;
		joTBTab14.style.fontFamily = sFont;
		joTBTab14.style.fontSize = fSize.toString() + 'pt';
	}
	if (jiTBNbrTabs > 14) {
		joTBTab15.style.height = ht.toString() + 'px';
		joTBTab15.style.width = wdth.toString() + 'px';
		joTBTab15.style.backgroundColor = bColor;
		joTBTab15.style.color = fColor;
		joTBTab15.style.fontFamily = sFont;
		joTBTab15.style.fontSize = fSize.toString() + 'pt';
	}
	if (jiTBNbrTabs > 15) {
		joTBTab16.style.height = ht.toString() + 'px';
		joTBTab16.style.width = wdth.toString() + 'px';
		joTBTab16.style.backgroundColor = bColor;
		joTBTab16.style.color = fColor;
		joTBTab16.style.fontFamily = sFont;
		joTBTab16.style.fontSize = fSize.toString() + 'pt';
	}
	if (jiTBNbrTabs > 16) {
		joTBTab17.style.height = ht.toString() + 'px';
		joTBTab17.style.width = wdth.toString() + 'px';
		joTBTab17.style.backgroundColor = bColor;
		joTBTab17.style.color = fColor;
		joTBTab17.style.fontFamily = sFont;
		joTBTab17.style.fontSize = fSize.toString() + 'pt';
	}
	if (jiTBNbrTabs > 17) {
		joTBTab18.style.height = ht.toString() + 'px';
		joTBTab18.style.width = wdth.toString() + 'px';
		joTBTab18.style.backgroundColor = bColor;
		joTBTab18.style.color = fColor;
		joTBTab18.style.fontFamily = sFont;
		joTBTab18.style.fontSize = fSize.toString() + 'pt';
	}
	if (jiTBNbrTabs > 18) {
		joTBTab19.style.height = ht.toString() + 'px';
		joTBTab19.style.width = wdth.toString() + 'px';
		joTBTab19.style.backgroundColor = bColor;
		joTBTab19.style.color = fColor;
		joTBTab19.style.fontFamily = sFont;
		joTBTab19.style.fontSize = fSize.toString() + 'pt';
	}
	if (jiTBNbrTabs > 19) {
		joTBTab20.style.height = ht.toString() + 'px';
		joTBTab20.style.width = wdth.toString() + 'px';
		joTBTab20.style.backgroundColor = bColor;
		joTBTab20.style.color = fColor;
		joTBTab20.style.fontFamily = sFont;
		joTBTab20.style.fontSize = fSize.toString() + 'pt';
	}
	return false;
}

function showTabContents(tabid) {
	switch (tabid) {
		case 0:
			loadObjectsTab0();
			break;
		case 1:
			loadObjectsTab1();
			break;
		case 2:
			loadObjectsTab2();
			break;
		case 3:
			loadObjectsTab3();
			break;
		case 4:
			loadObjectsTab4();
			break;
		case 5:
			loadObjectsTab5();
			break;
		case 6:
			loadObjectsTab6();
			break;
		case 7:
			loadObjectsTab7();
			break;
		case 8:
			loadObjectsTab8();
			break;
		case 9:
			loadObjectsTab9();
			break;
		case 10:
			loadObjectsTab10();
			break;
		case 11:
			loadObjectsTab11();
			break;
		case 12:
			loadObjectsTab12();
			break;
		case 13:
			loadObjectsTab13();
			break;
		case 14:
			loadObjectsTab14();
			break;
		case 15:
			loadObjectsTab15();
			break;
		case 16:
			loadObjectsTab16();
			break;
		case 17:
			loadObjectsTab17();
			break;
		case 18:
			loadObjectsTab18();
			break;
		case 19:
			loadObjectsTab19();
			break;
		case 20:
			loadObjectsTab20();
			break;
		default:
			break;
	}
	return false;
}

