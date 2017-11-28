/* WebControls.js - last updated by S. Meeds
--Requires:GenUtils.js, DataGrids.js, DateMngt.js, FileFunctions.js, AjaxFunctions.js
--Code checked 5/28/2015
Contents:
  setHierarchicalSelListValsWc(iULPadL, iULPadR, iULPadT, iULPadB, iLIPadL, iLIPadR, iLIPadT, iLIPadB, internalPad, iULMargL, iULMargR, iULMargT, iULMargB)
  initializeSelectedWc(nbr)
  setPreSelectedWc(selObj)
  getNbrStringWc(i, nbr, padChar)
  createHierarchicalSelListWc(objname, liPref, chkPref, wdth, ht, datgrid, textColName, valColName, gType, openImg, closeImg, ListStyle, LSPos, lvlLPdPix, iMarg, sIndent, openLvl, showNonSel, showHdr, seedid, objid)
  ToggleOpenViewWc(row)
  SetRowSelectionWc(row, ischecked)
  SetTextBoxAutoCompleteWc(objname, MyData, fld)
  GetIDFromSelectedTextWc(objname, MyData, fld, idfld)
  SetTextBoxAutoComplete2Wc(objname, MyData, fld)
  GetIDFromSelectedText2Wc(objname, MyData, fld, idfld)
	setSelectMenuItemWc(selname, wdth, objid)
	HandleSelMenuSelectionWc(objid, val)
	InitiateTextBoxSelectListWc(parentname, dataSrc, valField, txtField, hIDField, minChar)
	UpdateSpecListWc()
	SetTextBoxValueWc(val)
	generateBarcodeWc(btarget, txt, wdth, ht, bcol, fcol, outpt, typ)
	setHoverTextWc(objname, txt)
	createViewDocumentWc(objname, ht, wt, btype, filenm, content, errorlbl, objid)
	createProgressBarWc(objname, txtname, iVal, iMaxVal, objid)
	getProgressIndicatorValWc(objname)
	updateProgressBarWc(objname, iVal, objid)
	setDatePickerDefaultsWc(regioncd)
	createDatePickerOnTextWc(objname, mindt, maxdt, iFmt, mindt, maxdt, nbrmo, tanim, nbrmo, objid)
	removeDatePickerOnTextWc(objname, objid)
	setDateForDatePickerOnTextWc(objname, dtstring, objid)
	ChangeDatePickerOnTextWc(objname, actn, objid)
	createDragAndDropMngrWc(objname, statuslbl, objid)
	setObjectAsDragDropWc(objname, typ)
	initializeToolbarContentsWc(nObj, toolbarid)
	setToolbarItemWc(nCol, toolbarid, srctxt, ht, wt, iFunctType, t1, t2, iShowType)
	createOneLineToolbarWc(objname, canhide, sHt, sWdth, nbrItems, toolbarid)
	createFeedbackBlockWc(objname, ht, wt, lblht, lbltxt, fontnm, fontsz, lbl, content, objid)
	captureFeedbackWc(objid)
	createInLineEditBlockWc(divname, objname, row, col, ht, wt, objid)
	setInLineEditBlockDataWc(divname, objname, imgname, row, col, objid)
	HotKeyManagerWc(event)
	createSpinnerControlWc(objname, cloc, upicon, dnicon, holdsteps, iMin, iMax, iPg, iStep, fmt, objid)
	ChangeSpinnerControlWc(objname, typ, objid)
	createRatingBlockWc(objname, tgtobjname, ht, wt, nbrcells, objid)
	establishRatingDisplayWc(col, nbrcells, tgtobjname, objid)
	createContextMenuWc(objname, tgtctlname, objid)
	createTwoListConnectWc(objname, nbritems, list1hdr, list2hdr, src1, src2, vfield1, vfield2, tfield1, tfield2, displayobjnm, objid)
	connectTwoListItemsWc(side, rw, objid)
	transferSelectedToListWc(objid)
	RemoveThisItemWc(row)
	createAttachDGStatusBarWc(parentTableNm, nCols, bcolor, fcolor, inittext, objid)
	createHelpForBlockWc(objname, content, objid)
	createInfoBarWc(objname, content, objid)
	createGrowingTextAreaWc(objname, objid)
	createFloatingFooterWc(objname, objid)
	createMultiSelectWithChoiceListWc(objname, listdata, objid)
	transferSelectedItemListWc(rw, objid)
	RemoveThisListItemWc(row)
  GetIDFromSelectedTextWc(objname, tgtobj, idreq)
  FindEmployeeFromStrWc(val)
  FindAddressFromStrWc(pgid, objid, namefield, addrname, cityname, stname, zipname, coname, phonename, idname, val, byid, fieldtype)
*/

var jsWCVersion = '1.0.3';
var jsWCVersDate = '6/6/2017';

var jbWCNoCriticalKeys = false;
var jbWCNoDangerousChars = false;
var jbWCHierarchicalListLoaded = false;

var jiaWCSelected;
var jiaWCOpen;
var jiaWCPreSelected;

var jiaWCHLControlN;
var jiaWCHLControlT;
var jiWCHLListType = 0;
var jiWCHLNbrArrayCols = 5;
var jiWCHLNbrItems = 0;
var jiWCHLObjID = 0;
var jiWCCurrentCol = 0;
var jiWCCurrentID = 0;
var jiWCCurrentRow = 0;
var jiWCCurrObjectID = 0;
var jsWCColText = '';
var jsWCColVal = '';
var jsWCFeedbackBlock = '';
var jsWCNbrItems1 = 0;
var jsWCNbrItems2 = 0;
var jsWCObjHelpData = ['', '', '', '', '', '', '', '', '', '', ''];
var jsWCSelectNbr = 0;
var jsWCSelectNbr2 = 0;
var jsWCHLULPadL = '';
var jsWCHLULPadR = '';
var jsWCHLULPadT = '';
var jsWCHLULPadB = '';
var jsWCHLLIPadL = '';
var jsWCHLLIPadR = '';
var jsWCHLLIPadT = '';
var jsWCHLLIPadB = '';
var jsWCHLintPad = '';
var jsWCHLULMargL = '';
var jsWCHLULMargR = '';
var jsWCHLULMargT = '';
var jsWCHLULMargB = '';
var jtWCACObjName = '';
var jtWCACTgtObj = '';
var jtWCHLChkPref = '';
var jtWCHLLIPref = '';
var jtWCHLObjName = '';
var jsWCRatBColor1 = '#CCCCCC';
var jsWCRatBColor2 = '#FFFFFF';

var MyListDataWC;

var jiWCToolbarIcons = createDimension3ArrayGu(5, 30, 5, 0);
var jsWCTwoColListData = createDimension3ArrayGu(2, 5, 3, 0);
var jsWCSelectedData = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
var jsWCSelectedData2 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

/* ******************************** HIERARCHICAL UL LIST *******************************************/

function setHierarchicalSelListValsWc(iULPadL, iULPadR, iULPadT, iULPadB, iLIPadL, iLIPadR, iLIPadT, iLIPadB, internalPad, iULMargL, iULMargR, iULMargT, iULMargB) {
	jsWCHLULPadL = parseInt(iULPadL, 10).toString() + 'px';
	jsWCHLULPadR = parseInt(iULPadR, 10).toString() + 'px'; 
	jsWCHLULPadT = parseInt(iULPadT, 10).toString() + 'px';
	jsWCHLULPadB = parseInt(iULPadB, 10).toString() + 'px';
	jsWCHLLIPadL = parseInt(iLIPadL, 10).toString() + 'px';
	jsWCHLLIPadR = parseInt(iLIPadR, 10).toString() + 'px';
	jsWCHLLIPadT = parseInt(iLIPadT, 10).toString() + 'px';
	jsWCHLLIPadB = parseInt(iLIPadB, 10).toString() + 'px';
	jsWCHLintPad = parseInt(internalPad, 10).toString() + 'px';
	jsWCHLULMargL = parseInt(iULMargL, 10).toString() + 'px';
	jsWCHLULMargR = parseInt(iULMargR, 10).toString() + 'px';
	jsWCHLULMargT = parseInt(iULMargT, 10).toString() + 'px';
	jsWCHLULMargB = parseInt(iULMargB, 10).toString() + 'px';
}

function initializeSelectedWc(nbr) {
	jiaWCSelected = createArrayInitGu(nbr, true);
	jiaWCOpen = createArrayInitGu(nbr, true);
	jiaWCHLControlN = MultiDimensionalArrayGu(nbr, jiWCHLNbrArrayCols);
	jiaWCHLControlT = MultiDimensionalArrayGu(nbr, jiWCHLNbrArrayCols);
	for (var row = 0; row < nbr.length; row++) {
		jiaWCSelected[row] = false;
		jiaWCOpen[row] = false;
		for (var col = 0; col < 5; col++) {
			jiaWCHLControlN[row][col] = 0;
			jiaWCHLControlT[row][col] = '';
		}
	}
}

function setPreSelectedWc(selObj) {
	if (selObj === undefined || selObj === null) {
		return false;
	}
	if (selObj.length > 0) {
		for (var row=0;row<selObj.length;row++) {
			if (parseInt(selObj[row],10) === 1) {
				jiaWCSelected[row] = true;
			}
			else {
				jiaWCSelected[row] = false;
			}
		}
	}
	return false;
}

function getNbrStringWc(i, nbr, padChar) {
	var s = i.toString();
	while (s.length < nbr) {
		s = padChar + s;
	}
	return s;
}

function createHierarchicalSelListWc(objname, liPref, chkPref, wdth, ht, datgrid, textColName, valColName, gType, openImg, closeImg, ListStyle, LSPos, lvlLPdPix, iMarg, sIndent, openLvl, showNonSel, showHdr, seedid, objid) {
	//datgrid standard required columns: ID, ParentID, Lvl, NbrChild, sIsSelectable, 
	//gType: 0-normal grid, open, close, etc., 1-static (stays all open), __
	var chk;
	var iID = 0;
	var iLvl = 0;
	var inContent = false;
	var iSeed = 0;
	var isSel = false;
	var iVal = 0;
	var joLI;
	var joLIParent;
	var lastLvl = 0;
	var lPad = 0;
	var lvl = 0;
	var oLvl1;
	var oLvl2;
	var oLvl3;
	var oLvl4;
	var oLvl5;
	var oLvl6;
	var oLvl7;
	var oLvl8;
	var oLvl9;
	var oLvl10;
	var seedLvl = 0;
	var sLvl = '';
	var sRow = '';
	var tnode;
	var val = '';
	if (datgrid === undefined || datgrid === null) {
		return '';
	}

	var nRows = datgrid.length;
	jiWCHLNbrItems = nRows;
	jtWCHLChkPref = chkPref;
	jtWCHLLIPref = liPref;
	jtWCHLObjName = objname;
	jiWCHLListType = gType;
	jiWCHLObjID = objid;
	iSeed = parseInt(seedid, 10);

	var content = '<ul id="' + objname + '" style="';
	content = content + 'width:' + wdth.toString() + 'px;height:' + ht.toString() + 'px;list-style-type:' + ListStyle + ';margin-left:' + jsWCHLULMargL + ';margin-right:' + jsWCHLULMargR + ';margin-top:' + jsWCHLULMargT + ';';
	content = content + 'padding-left:' + jsWCHLULPadL + ';padding-right:' + jsWCHLULPadR + ';padding-top:' + jsWCHLULPadT + ';padding-bottom:' + jsWCHLULPadB + ';">';
	iLvl = parseInt(datgrid[0]['Lvl'], 10);
	lastLvl = iLvl;
	//alert(seedid);

	if (nRows > 1) {
		// Add level 0's to UL
		inContent = false;
		for (var row = 1; row < nRows; row++) {
			sRow = getNbrStringWc(row, 3, '0');
			lvl = parseInt(datgrid[row]['Lvl'], 10);

			if (showHdr === true && parseInt(datgrid[row]['ID'], 10) === parseInt(seedid, 10)) {
				content = content + '<div style="color:blue;font-weight:bold;margin-bottom:6px;">' + datgrid[row][textColName].toString() + '</div>';
			}

			if (seedid === 0) { inContent = true; }

			// fill standard background arrays
			//if (jbHierarchicalListLoaded === false) {
				jiaWCHLControlN[row][0] = parseInt(datgrid[row]['ID'], 10);
				jiaWCHLControlN[row][1] = lvl;
				jiaWCHLControlN[row][2] = parseInt(datgrid[row]['NbrChild'], 10);
				jiaWCHLControlN[row][3] = parseInt(datgrid[row]['ParentID'], 10);
				jiaWCHLControlT[row][0] = datgrid[row]['ID'].toString();
				jiaWCHLControlT[row][1] = datgrid[row][textColName].toString();
				jiaWCHLControlT[row][2] = liPref + sRow;
				//alert(jiaCHLControlN[row][0] + '/' + jiaCHLControlN[row][1] + '/' + jiaCHLControlN[row][2] + '/' + jiaCHLControlN[row][3] + '/T:' + jiaCHLControlT[row][0] + '/' + jiaCHLControlT[row][1] + '/' + jiaCHLControlT[row][2]);
			//}

			isSel = false;
			if (datgrid[row]['sIsSelectable'].toString() === 'Yes') { isSel = true; }
			if (inContent === true) {
				if (lastLvl !== lvl && row !== 1) {
					if (lvl < lastLvl) {
						content = content + '</li></ul></li>';
						iVal = lastLvl - lvl;
						//if (lvl === 2) { alert(iVal); }
						if (iVal > 4) {
							content = content + '</li></ul></li>';
						}
						if (iVal > 3) {
							content = content + '</li></ul></li>';
						}
						if (iVal > 2) {
							content = content + '</li></ul></li>';
						}
						if (iVal > 1) {
							//alert('triggered');
							content = content + '</li></ul></li>';
						}
					}
					if (lvl > lastLvl) {
						sLvl = getNbrStringWc(lvl, 2, '0');
						val = getNbrStringWc(jiaCHLControlN[row - 1][0], 14, '0');
						content = content + '<ul id="U' + liPref + val + '" style="';
						if (lvl <= openLvl) {
							content = content + 'display:block;';
						}
						else {
							content = content + 'display:none;';
						}
						content = content + '">';
					}
				}
				else {
					if (row > 1) { content = content + '</li>'; }
				}
			}
			lastLvl = lvl;

			// check to see if to show the content for this row
			if (seedid > 0) {
				if (lvl < seedLvl && inContent === true) {
					//alert('Stopped handling seed id at row ' + row.toString() + ': ' + jiaCHLControlT[row][1]);
					inContent = false;
				}
				if (parseInt(jiaWCHLControlN[row][3], 10) === parseInt(seedid, 10)) {
					//alert('Found seed id at row ' + row.toString() + ': ' + jiaCHLControlT[row][1]);
					inContent = true;
					seedLvl = lvl;
				}
			}
			
			//if (jbHierarchicalListLoaded === false) {
				// establish parent row ID
				for (var row2 = 1; row2 < row; row2++) {
					if (jiaWCHLControlN[row2][3] === NaN) { jiaWCHLControlN[row2][3] = 0; }
					if (jiaWCHLControlN[row2][1] > 0) {
						for (var p = 0; p < nRows; p++) {
							if (jiaWCHLControlN[row2][3] === jiaWCHLControlN[p][0]) {
								jiaWCHLControlN[row2][4] = p;
								break;
							}
						}
					}
				}
			//}

			if ((showNonSel === true || isSel === true || jiaWCHLControlN[row][2] > 0) && inContent === true) {
				// form visible content
				content = content + '<li id="' + liPref + sRow + '" style="list-style-type:' + ListStyle + ';';
				val = iMarg.toString() + 'px';
				content = content + 'margin-left:' + sIndent + ';margin-right:' + val + ';margin-top:' + val + ';margin-bottom:' + val + ';padding-left:' + jsWCHLLIPadL + ';padding-right:' + jsWCHLLIPadR + ';padding-top:' + jsWCHLLIPadT + ';padding-bottom:' + jsWCHLLIPadB + ';">';
				content = content + '<img id="HLI' + sRow + objid.toString() + '" src="../Images/';
				if (jiaWCHLControlN[row][2] === 0) {
					content = content + openImg + '"';
				}
				else {
					if (lvl < openLvl) {
						content = content + openImg + '"';
					}
					else {
						content = content + closeImg + '"';
					}
				}
				if (openLvl > lvl) {
					jiaWCOpen[row] = true;
				}
				else {
					jiaWCOpen[row] = false;
				}
				content = content + ' style="padding-right:' + jsWCHLintPad + '" onclick="javascript:ToggleOpenViewWc(' + row.toString() + ');return false;" />';
				if (isSel === true) {
					content = content + '<input type="checkbox" id="' + chkPref + sRow + '" style="padding-left:4px;padding-right:' + jsWCHLintPad + '"';
					if (jiaWCSelected[row] === true) {
						content = content + ' checked="true"';
					}
					content = content + ' onchange="javascript:SetRowSelectionWc(' + row.toString() + ',this.checked);return false;" />';
				}
				content = content + datgrid[row][textColName].toString();
			} //if (datgrid[row]['sIsSelectable'].toString() === 'Yes')
			// if (showNonSel === true || jiaCHLControlN[row][2] > 0)
		}
	}
	content = content + '</li></ul>';
	jbWCHierarchicalListLoaded = true;
	return content;
}

function ToggleOpenViewWc(row) {
	var val = '';
	var id = jiaWCHLControlN[row][0];
	var isOpen = jiaCOpen[row];
	if (jiaWCHLControlN[row][2] > 0 && jiWCHLNbrItems > 0) {
		val = getNbrStringWc(jiaWCHLControlN[row][0], 14, '0');
		if (isOpen === true) {
			document.getElementById('U' + jtWCHLLIPref + val).style.display = 'none';
		}
		else {
			document.getElementById('U' + jtWCHLLIPref + val).style.display = 'block';
		}
	}
	if (isOpen === true) {
		jiaWCOpen[row] = false;
	}
	else {
		jiaWCOpen[row] = true;
	}
	return false;
}

function SetRowSelectionWc(row, ischecked) {
	//alert('Fired! - ' + row.toString() + '/' + ischecked);
	jiaWCSelected[row] = ischecked;
	return false;
}

// **************************************************************************************************************************
// makes text box autocomplete - S. Meeds on 4/6/2015  - Expects MyListDataWC has been loaded with data in appropriate format 0-ID, 1-TextToShow
function SetTextBoxAutoCompleteWc(objname, nchar, tgtObj) {
	// load autocomplete list - objname is for a textbox
	jtWCACObjName = objname;
	jtWCACTgtObj = tgtObj;
	var narray = createArrayInitGu(3, 0);
	if (MyListDataWC !== undefined && MyListDataWC !== null) {
		if (MyListDataWC.length > 2) {
			var ln = MyListDataWC.length;
			for (var rw = 0; rw < ln; rw++) {
				narray[rw] = MyListDataWC[rw][1].toString();
			}
			$("#" + objname).autocomplete({
				source: narray,
				minLength: nchar
			});
		}
	}
	return false;
}

// makes gets autocomplete id when text box is filled in - S. Meeds on 4/6/2015
function GetIDFromSelectedTextWc() {
	$("#" + jtWCCObjName).autocomplete("close");
	var id = 0;
	var txt = jtWCCObjName.value;
	if (MyListDataWC !== undefined && MyListDataWC !== null) {
		if (MyListDataWC.length > 2) {
			var ln = MyListDataWC.length;
			for (var rw = 0; rw < ln; rw++) {
				if (MyListDataWC[rw][1].toString() === txt) {
					id = MyListDataWC[rw][0].toString();  //parseInt(MyListDataWC[rw][0], 10);
					break;
				}
			}
		}
	}
	if (jtWCACTgtObj.length > 0) { document.getElementById(jtWCACTgtObj).value = id.toString(); }
	return id;
}

// **************************************************************************************************************************
// makes text box autocomplete - S. Meeds on 6/6/2017  - Expects MyListDataWC has been loaded with data in appropriate format 0-ID, 1-TextToShow
function SetTextBoxAutoComplete2Wc(objname, nchar, tgtObj, datasrc, valcol, txtcol) {
	// load autocomplete list - objname is for a textbox
	jtWCACObjName = document.getElementById(objname);
	jtWCACTgtObj = tgtObj;
	MyListDataWC = datasrc;
	jsWCColText = txtcol;
	jsWCColVal = valcol;
	jtWCCObjName = objname;
	var narray = createArrayInitGu(3, 0);
	if (datasrc !== undefined && datasrc !== null) {
		if (datasrc.length > 2) {
			var ln = datasrc.length;
			for (var rw = 0; rw < ln; rw++) {
				narray[rw] = datasrc[rw][txtcol].toString();
			}
			$("#" + objname).autocomplete({
				source: narray,
				minLength: nchar
			});
		}
	}
	return false;
}

// gets autocomplete id when text box is filled in - S. Meeds on 4/6/2015
function GetIDFromSelectedText2Wc() {
	//alert('Fired!');
	//$("#" + jtWCCObjName).autocomplete("close");
	jtWCACTgtObj.value = '';
	try {
		var id = 0;
		//alert(jtWCACObjName.value + '/' + MyListDataWC.length);
		var txt = jtWCACObjName.value;
		//alert(txt);
		if (MyListDataWC !== undefined && MyListDataWC !== null && txt !== '') {
			if (MyListDataWC.length > 2) {
				var ln = MyListDataWC.length;
				for (var rw = 0; rw < ln; rw++) {
					if (MyListDataWC[rw][jsWCColText].toString() === txt) {
						id = MyListDataWC[rw][jsWCColVal].toString();
						//alert(id);
						break;
					}
				}
			}
		}
		jtWCACTgtObj.value = id.toString();
	}
	catch (ex) {
		// nothing
	}
	return false;
}

function setSelectMenuItemWc(selname, wdth, objid) {
	$("#" + selname).selectmenu({
		change: function (event, data) {
			HandleSelMenuSelection(objid, data.item.value);
		}
	});
	document.getElementById(selname).style.width = wdth;
}

function HandleSelMenuSelectionWc(objid, val) {
	switch (objid) {
		case 1: //

			break;
		default:
			break;
	}
}
// **************************************************************************************************************************

function InitiateTextBoxSelectListWc(parentname, dataSrc, valField, txtField, hIDField, minChar) {
	jiWCHStatusID = 3;
	jiWCMinChar = minChar;
	jsWCObjName = 'selSpecListWc';
	jsWCObjName2 = parentname;
	jsWCDataSrcName = dataSrc;
	jsWCEnteredChars = '';
	joWCDivList = document.getElementById('divPopupListWc');
	joWCSelSpecList = document.getElementById('selSpecListWc');
	jiWCObjectTop = top;
	jiWCObjectLeft = left;
	joWCParentObject = document.getElementById(parentname);
	var position = joWCParentObject.position();
	jiWNVerticalOffset = 22;
	jiWCHorizOffset = 100;
	joWCHDivList.style.display = 'flexbox';
	joWCHDivList.style.top = (position.top + jiWCVerticalOffset).toString() + 'px';
	joWCHDivList.style.left = (position.left + jiWCHorizOffset).toString() + 'px';
	jiWCNbrRows = dataSrc.length;
	jsWCTextField = txtField;
	jsWCValField = valField;
	jiWCHHfIDField = hIDField;
	// pick list is not visible at this point. Div is but with a transparent background
}

// for special DDL interaction
function UpdateSpecListWc() {
	var icount = 0;
	var ln = jsWCEnteredChars.length;
	var row = 0;
	var txt = '';
	var val = '';
	var nbrRows = 0;
	if (ln < jiWCMinChar) {
		ClearDDLOptionsUt('selSpecListWc', 0);
	}
	if (ln === jiCNMinChar) {
		ClearDDLOptionsUt('selSpecListWc', 0); // clear list
		for (row = 0; row < jiWCNbrRows; row++) {
			if (jsWCEnteredChars === jsWCDataSrcName[row][jsWCTextField].substr(0, ln)) {
				val = jsWCDataSrcName[row][jsWCValField];
				txt = jsWCDataSrcName[row][jsWCTextField];
				appendDDLOptionGu('selSpecListWC', val, txt);
				jaWCItems[row] = 1;
				icount++;
			}
			else {
				jaWCItems[row] = 0;
			}
		}
	}
	if (ln > jiWCMinChar && jiWCItemsInList > 0) {
		nbrRows = joWCSelSpecList.length;
		for (row = 0; row < nbrRows; row++) {
			if (jaWCItems[row] === 1) {
				icount++;
				if (jsWCEnteredChars !== jsWCDataSrcName[row][jsCNTextField].substr(0, ln)) {
					val = jsWCDataSrcName[row][jsCNValField];
					RemoveDDLOptionItemGu('selSpecListWc', val);
					jaWCItems[row] = 0;
				}
			}
		}
	}
	jiWCItemsInList = iCount;
	if (icount > 0) {
		document.getElementById('selSpecListWc').size = icount;
		document.getElementById('selSpecListWc').style.display = 'inline-block';
	}
	else {
		document.getElementById('selSpecListWc').style.display = 'none';
	}
}

// for special DDL interaction
function SetTextBoxValueWc(val) {
	var txt = getDDLSelectedTextGu('selSpecListWc');
	document.getElementById('jsWCObjName').value = txt;
	document.getElementById('jiWCHfIDField').value = val;
	document.getElementById('selSpecListWc').style.display = 'none';
	jiWCHStatusID = 0;
}

function generateBarcodeWc(btarget, txt, wdth, ht, bcol, fcol, outpt, typ) {
	if (typ === '') { typ = 'code128'; }
	var settings = {
		output: outpt,
		bgColor: bcol,
		color: fcol,
		barWidth: wdth,
		barHeight: ht,
		moduleSize: '5'
	};
	$("#" + btarget).html("").show().barcode(txt, typ, settings);
	//bcol:'#FFFFFF', fcol:'#000000', 'output: css, bmp, etc.
	return false;
}

function setHoverTextWc(objname, txt) {
	document.getElementById(objname).title = txt;
}

function createViewDocumentWc(objname, ht, wt, btype, filenm, content, errorlbl, objid) {
	var s = '';
	var obj = document.getElementById(objname);
	obj.style.height = ht.toString() + 'px';
	obj.style.width = wt.toString() + 'px';

	if (content.length > 0) {
		// insert text if content was submitted
		document.getElementById(objname).innerHTML = contents;
	}
	else {
		// grab file text based on browser type if filename
		if (filenm.length > 0) {
			if (btype === 'internetexplorer11' || btype === 'ie10' || btype === 'ie9') {
				s = isReadFileInIEtxtFf(filenm);
			}
			else {
				s = isReadFileInNonIEFf(filenm);
			}
			document.getElementById(objname).innerHTML = s;
		}
		else {
			document.getElementById(errorlbl).innerHTML = 'No filename or text content was submitted.';
		}
	}
	return false;
}

function createProgressBarWc(objname, txtname, iVal, iMaxVal, objid) {
	$("#" + objname).progressbar({
		max: iMaxVal,
		value: iVal,
		change: function (event, ui) {
			document.getElementById(txtname).value = $( "." + objname ).progressbar( "value" );
		},
		complete: function (event, ui) {
			ProgressBarController(3, objid);
		}
	});
}

function updateProgressBarWc(objname, iVal, objid) {
	$("#" + objname).progressbar({
		value: iVal
	});
	return false;
}

function getProgressIndicatorValWc(objname) {
	return $( "." + objname ).progressbar( "value" );
}

function setDatePickerDefaultsWc(regioncd) {
	var yr = jsDMfToday.getFullYear();
	var mo = jsDMfToday.getMonth()+1;
	var dy = dsDMfToday.getDay();
	var dtformat = "yyyy-mm-dd";
	$.datepicker.setDefaults({
		showOn: "both",
		buttonImageOnly: true,
		buttonImage: "calendar.gif",
		buttonText: "Calendar",
		dateFormat: 'yy-mm-dd', firstDay: 0
	});
	$.datepicker.setDefaults($.datepicker.regional[regioncd]);
	}

	//$.datepicker.regional['fr'] = {clearText: 'Effacer', clearStatus: '',
	//	closeText: 'Fermer', closeStatus: 'Fermer sans modifier',
	//	prevText: '&lt;Préc', prevStatus: 'Voir le mois précédent',
	//	nextText: 'Suiv&gt;', nextStatus: 'Voir le mois suivant',
	//	currentText: 'Courant', currentStatus: 'Voir le mois courant',
	//	monthNames: ['Janvier','Février','Mars','Avril','Mai','Juin',
  //  'Juillet','Août','Septembre','Octobre','Novembre','Décembre'],
	//	monthNamesShort: ['Jan','Fév','Mar','Avr','Mai','Jun',
  //  'Jul','Aoû','Sep','Oct','Nov','Déc'],
	//	monthStatus: 'Voir un autre mois', yearStatus: 'Voir un autre année',
	//	weekHeader: 'Sm', weekStatus: '',
	//	dayNames: ['Dimanche','Lundi','Mardi','Mercredi','Jeudi','Vendredi','Samedi'],
	//	dayNamesShort: ['Dim','Lun','Mar','Mer','Jeu','Ven','Sam'],
	//	dayNamesMin: ['Di','Lu','Ma','Me','Je','Ve','Sa'],
	//	dayStatus: 'Utiliser DD comme premier jour de la semaine', dateStatus: 'Choisir le DD, MM d',
	//	initStatus: 'Choisir la date', isRTL: false};

function createDatePickerOnTextWc(objname, mindt, maxdt, iFmt, nbrmo, tanim, objid) {
	// mindt, maxdt in string format YYYY-mm-dd or NULL; nbrmo is integer (1, 2, 3); tanim: show, slideDown, fadeIn, fold, etc
	$("#" + objname).datepicker({
		dateFormat: 'yy-mm-dd',
		gotoCurrent: true,
		minDate: mindt,
		maxDate: maxdt,
		numberOfMonths: nbrmo,
		showAnim: tanim,
		showOn: "both",
		showButtonPanel: true,
		appendText: "(yyyy-mm-dd)"
	});
	//onClose: function (txt) {
	//}
	return false;
}
// control available when open
//PAGE UP: Move to the previous month.
//PAGE DOWN: Move to the next month.
//CTRL + PAGE UP: Move to the previous year.
//CTRL + PAGE DOWN: Move to the next year.
//CTRL + HOME: Open the datepicker if closed.
//CTRL/COMMAND + HOME: Move to the current month.
//CTRL/COMMAND + LEFT: Move to the previous day.
//CTRL/COMMAND + RIGHT: Move to the next day.
//CTRL/COMMAND + UP: Move to the previous week.
//CTRL/COMMAND + DOWN: Move to the next week.
//	ENTER: Select the focused date.
//	CTRL/COMMAND + END: Close the datepicker and erase the date.
//	ESCAPE: Close the datepicker without selection.PAGE UP: Move to the previous month.
//PAGE DOWN: Move to the next month.
//CTRL + PAGE UP: Move to the previous year.
//CTRL + PAGE DOWN: Move to the next year.
//CTRL + HOME: Open the datepicker if closed.
//CTRL/COMMAND + HOME: Move to the current month.
//CTRL/COMMAND + LEFT: Move to the previous day.
//CTRL/COMMAND + RIGHT: Move to the next day.
//CTRL/COMMAND + UP: Move to the previous week.
//CTRL/COMMAND + DOWN: Move to the next week.
//ENTER: Select the focused date.
//CTRL/COMMAND + END: Close the datepicker and erase the date.
//	ESCAPE: Close the datepicker without selection.

function removeDatePickerOnTextWc(objname, objid) {
	$("#" + objname).datepicker("destroy");
	return false;
}

function setDateForDatePickerOnTextWc(objname, dtstring, objid) {
	$("#" + objname).datepicker("setDate", dtstring);
	return false;
}

function ChangeDatePickerOnTextWc(objname, actn, objid) {
	if (actn === 0) {	$("#" + objname).datepicker("hide");}
	if (actn === 1) {	$("#" + objname).datepicker("show");}
	if (actn === 2) {	$("#" + objname).datepicker("refresh");}
	return false;
}

function setObjectDraggableWc(objname) {
	$('#' + objname).draggable();
}

function createDragAndDropMngrWc(objname, statuslbl, objid) {
	var obj = document.getElementById(objname);
	setObjectAsDragDropWc(objname, 1);

	return false;
}

function setObjectAsDragDropWc(objname, typ) {
	// make target draggable
	if (typ === 0 ) {
		$("#" + objname).draggable();
	}
	// add target for drops
	if (typ === 1 ) {
		$("#" + objname).droppable({
			drop: function (event, ui) {
				this.addClass("ui-state-highlight");
				HandleObjDrop(event, ui);
			},
			out: function (event, ui) {
				HandleObjRemoval(event, ui);
			}
		});
	}
}

function initializeToolbarContentsWc(nObj, toolbarid) {
	for (var row=0;row<nObj;row++) {
		for (var col=0;col<7;col++) {
			jiWCToolbarIcons[toolbarid][row][col] = '';
		}
	}
}

function setToolbarItemWc(nCol, toolbarid, srctxt, ht, wt, iFunctType, t1, t2, iShowType) {
	//iFunctType: 0-N/A, 1-addnew, 2-edit, 3-delete, 99-other
	if (iFunctType === undefined || iFunctType === null) {iFunctType = 0;}
	if (iShowType === undefined || iShowType === null) {iShowType = 0;}
	if (ht === undefined || ht === null) {ht = 0;}
	if (wt === undefined || wt === null) {wt = 0;}
	jiWCToolbarIcons[toolbarid][nCol][0] = iFunctType.toString();
	jiWCToolbarIcons[toolbarid][nCol][1] = iShowType.toString();
	jiWCToolbarIcons[toolbarid][nCol][2] = srctxt;
	jiWCToolbarIcons[toolbarid][nCol][3] = ht.toString();
	jiWCToolbarIcons[toolbarid][nCol][4] = wt.toString();
	jiWCToolbarIcons[toolbarid][nCol][5] = t1;
	jiWCToolbarIcons[toolbarid][nCol][6] = t2;
	return false;
}

function createOneLineToolbarWc(objname, canhide, sHt, sWdth, bcol, fcol, nbrItems, toolbarid) {
	//objname is expected to be a div or someplace a bar can be inserted into
	var cell;
	var rht = parseInt(sHt.replace('%', '').replace('px', ''), 10);
	var rwt = parseInt(sWdth.replace('%', '').replace('px', ''), 10);
	var iSType = 0;
	var tb = document.createElement('table');
	tb.style.borderSpacing = '0px';
	tb.style.padding = '0px';
	var tr = document.createElement('tr');
	for (var col=0;col<nbrItems;col++) {
		iSType = parseInt(jiWCToolbarIcons[toolbarid][col][1], 10);
		cell = createBasicCellDg('TBC' + toolbarid.toString(), rht, rwt, bcol, fcol, 'left', '1px', '1px', '1px', '1px', toolbarid);
		switch (iSType) {
			case 1: // icon
				cell.innerHTML = '<a href="#" onclick="HandleToolBarClick(' + toolbarid.toString() + ',' + col.toString() + ',' + jiWCToolbarIcons[toolbarid][col][0].toString() + ');return false;"><img src="' + jiWCToolbarIcons[toolbarid][col][2].toString() + '" style="width:' + (rwt-1).toString() + 'px;height:' + (rht-1).toString() + 'px;" /></a>';
				break;
			case 2: //text
				cell.innerHTML = jiWCToolbarIcons[toolbarid][col][2].toString();
				break;
			case 3: //button
				cell.innerHTML = '<button id="" onclick="" style="width:' + (rwt-1).toString() + 'px;height:' + (rht-1).toString() + 'px;" />' + jiWCToolbarIcons[toolbarid][col][2].toString() + '</button>';
				break;
			default:
				break;
		}
		tr.appendChild(cell);
	}
	tb.appendChild(tr);
	document.getElementById(objname).appendChild(tb);
	return false;
}

function createFeedbackBlockWc(objname, ht, wt, lblht, lbltxt, fontnm, fontsz, lbl, content, objid) {
	// objects are created and used to fill objname, considered a container
	var obj = document.getElementById(objname);
	var dv = document.createElement('div');
	dv.id = 'divFBB' + objid.toString();
	dv.style.width = wt.toString() + 'px';
	dv.style.height = (ht+lblht).toString() + 'px';
	var dvlbl = document.createElement('div');
	dvlbl.id = 'divFBBLbl' + objid.toString();
	dvlbl.width = '100%';
	dvlbl.height = lblht.toString() + 'px';
	dvlbl.innerHTML = lbltxt;
	dv.appendChild(dvlbl);
	var dvBlock = document.createElement('textarea');
	dvBlock.id = 'txaFBBBlock' + objid.toString();
	jsWCFeedbackBlock = 'txaFBBBlock' + objid.toString();
	dvBlock.height = ht.toString() + 'px';
	dvBlock.width = wt.toString() + 'px';
	dvBlock.value = content;
	dv.appendChild(dbBlock);
	obj.appendChild(dv);
	return false;
}

function captureFeedbackWc(objid) {
	var fdbk = document.getElementById(jsWCFeedbackBlock).value;
	SaveFeedbackAf(jiPageID, objid, fdbk);
	return false;
}

function createInLineEditBlockWc(divname, objname, row, col, ht, wt, objid) {
	// objname expected to be textbox in divname
	var sCol = col.toString();
	var sRow = row.toString();
	if (sCol.length === 1) {sCol = '0' + sCol;}
	if (sRow.length === 2) {sRow = '0' + sRow;}
	if (sRow.length === 1) {sRow = '00' + sRow;}
	var obj = document.getElementById(objname);
	obj.style.readOnly = false;
	var dv = document.getElementById(divname);
	// insert image
	var ig = document.createElement('img');
	ig.id = 'imgILB' + sRow + sCol;
	ig.src = '../Images/Available.gif';
	ig.style.height = ht.toString() + 'px';
	ig.style.width = wt.toString() + 'px';
	// attach event
	ig.onclick = function() {
		setInLineEditBlockDataWc(divname, objname, row, 'imgILB' + sRow + sCol, row, col, objid);
	};
	dv.appendChild(ig);
	return false;
}

function setInLineEditBlockDataWc(divname, objname, imgname, row, col, objid) {
	var obj = document.getElementById(objname);
	obj.style.readOnly = false;
	var dv = document.getElementById(divname);
	obj.style.readOnly = true;
	HandleEditBlockData(objname, row, col, obj.value, objid);
	return false;	
}

function HotKeyManagerWc(event) {
	var c = event.which || event.keyCode;
	var cr = String.fromCharCode(c);
	switch (c) {
		//case 8: // backspace
		//    break;
		//case 9: // tab
		//    break;
		case 13: // ENTER
			return false;
			break;
		//case 17: // zoom
		//	break;
		case 19: // pause/break
			HandleEscapeChar();
			break;
			//case 20: // capslock
			//    break;
		case 27: // escape/abandon
			HandleEscapeChar();
			break;
		case 33: // page up
			if (jiWCCurrObjectID > 0) {
				setNewPgNbrPj(jiWCCurrObjectID, 1, '');
			}
			break;
		case 34: // page down
			if (jiWCCurrObjectID > 0) {
				setNewPgNbrPj(jiWCCurrObjectID, 2, '');
			}
			break;
		case 35: // end
			if (jiWCCurrObjectID > 0) {
				setNewPgNbrPj(jiWCCurrObjectID, 3, '');
			}
			break;
		case 36: // home
			if (jiWCCurrObjectID > 0) {
				setNewPgNbrPj(jiWCCurrObjectID, 0, '');
			}
			break;
		case 37: // left arrow
			if (jiWCCurrObjectID > 0 && jiWCCurrentID > 0 && jiWCCurrentRow > 0) {
				MoveDataGridPointer(jiWCCurrentID, jiWCCurrentRow, jiWCCurrObjectID, 5);
			}
			break;
		case 38: // up arrow
			if (jiWCCurrObjectID > 0 && jiWCCurrentID > 0 && jiWCCurrentRow > 0) {
				MoveDataGridPointer(jiWCCurrentID, jiWCCurrentRow, jiWCCurrObjectID, 0);
			}
			break;
		case 39: // right arrow
			if (jiWCCurrObjectID > 0 && jiWCCurrentID > 0 && jiWCCurrentRow > 0) {
				MoveDataGridPointer(jiWCCurrentID, jiWCCurrentRow, jiWCCurrObjectID, 6);
			}
			break;
		case 40: // down arrow
			if (jiWCCurrObjectID > 0 && jiWCCurrentID > 0 && jiWCCurrentRow > 0) {
				MoveDataGridPointer(jiWCCurrentID, jiWCCurrentRow, jiWCCurrObjectID, 1);
			}
			break;
		case 45: // insert
			if (jiWCCurrObjectID > 0) {
				EditOneRec(0, 0, jiWCCurrObjectID);
			}
			break;
		case 46: // delete
			if (jiWCCurrObjectID > 0 && jiWCCurrentID > 0 && jiWCCurrentRow > 0) {
				DeleteOneRec(jiWCCurrentID, jiWCCurrentRow, jiWCCurrObjectID);
			}
			break;
		case 91: // left window key
			break;
		case 92: // right window key / Natural Keyboard extra 1 key at top
			break;
		case 93: // select/List key
			break;
		//case 106: // multiply
		//	break;
		//case 107: // add
		//	break;
		//case 109: // subtract
		//	break;
		//case 110: // decimal point
		//	break;
		//case 111: // divide
		//	break;
		case 112: // F1 Help
			if (jiWCCurrObjectID > 0) {
				//StandardHelpDisplay(jiWCCurrObjectID, jiWCCurrentCol);
				alert(jsWCObjHelpData[jiWCCurrObjectID]);
			}
			break;
		//case 113: // F2 Undo
		//	break;
		//case 114: // F3 Redo
		//	break;
		case 115: // F4 New
			if (jiWCCurrObjectID > 0) {
				EditOneRec(0, 0, jiWCCurrObjectID);
			}
			break;
		//case 116: // F5 Open
		//	break;
		//case 117: // F6 Close
		//	break;
		//case 118: // F7 Reply
		//	break;
		//case 119: // F8 Fwd
		//	break;
		//case 120: // F9 Send
		//	break;
		//case 121: // F10 Spell
		//	break;
		case 122: // F11 Save
			if (jiWCCurrObjectID > 0 && jiWNCurrentID > 0 && jiWCCurrentRow > 0) {
				SaveOneRec(jiWCCurrentID, jiWCCurrentRow, jiWCCurrObjectID);
			}
			break;
		case 123: // F12 Print
			window.print();
			break;
			//case 144: // num lock
			//    break;
			//case 145: // scroll lock
			//    break;
		case 186: // semi-colon
			if (jbWCNoDangerousChars === true) {return false;}
			break;
		//case 187: // equal sign
		//	break;
		//case 188: // comma
		//	break;
		//case 189: // dash
		//	break;
		//case 190: // period
		//	break;
		//case 191: // forward slash
		//	break;
		//case 192: // grave accent
		//	break;
		//case 219: // open bracket
		//	break;
		case 220: // back slash
			if (jbWCNoDangerousChars === true) {return false;}
			break;
		//case 221: // close bracket
		//	break;
		case 222: // single quote
			if (jbWCNoDangerousChars === true) {return false;}
			break;
		default:
			break;
	}
	if (jbWCNoDangerousChars === true) {
		switch (cr) {
			case '&':
				return false;
				break;
			case '%':
				return false;
				break;
			case '"':
				return false;
				break;
			default:
				break;
		}
		if (jbWCNoCriticalKeys === true && (cr==="'" || cr===';')) {return false;}
	}
	return true;
}

function createSpinnerControlWc(objname, cloc, upicon, dnicon, holdsteps, iMin, iMax, iPg, iStep, fmt, objid) {
	//default upicon ui-icon-triangle-l-n, default dnicon ui-icon-triangle-l-s
	//iMax = null if no max, iMin = null if no min
	//fmt: 'C' currency, 'n' decimal numbers
	if (fmt === undefined || fmt === null ) {fmt = 'n';}
	if (iMin === undefined || iMin === null ) {iMin = 0;}
	if (iPg === undefined || iPg === null ) {iPg = 5;}
	if (iStep === undefined || iStep === null ) {iStep = 1;}
	if (iStep === 0) {iStep = 1;}
	if (fmt === '') {fmt = 'n';}
	$("#" + objname).spinner({
		incremental: false,
		min: iMin,
		max: iMax,
		page: iPg,
		step: iStep,
		numberFormat: fmt,
		culture: cloc,
		icons: {
			down: dnicon,
			up: upicon
		}
	});
	return false;
}

function ChangeSpinnerControlWc(objname, typ, objid) {
	if (typ === 0) {$("#" + objname).spinner("destroy");}
	if (typ === 1) {$("#" + objname).spinner("disable");}
	if (typ === 2) {$("#" + objname).spinner("enable");}
	return false;
}

function createRatingBlockWc(objname, tgtobjname, ht, wt, nbrcells, objid) {
	var cell;
	var tbl = document.createElement('table');
	tbl.id='RatBk' + objid.toString();
	tbl.style.height = ht.toString() + 'px';
	if (nbrcells === undefined || nbrcells === null) {nbrcells = 1;}
	if (nbrcells === 0) {nbrcells = 1;}
	var clwdth = parseint(wt/nbrcells);
	tbl.style.width = (clwdth*nbrcells).toString() + 'px';
	var tr = document.createElement('tr');
	for (var c=0;c<nbrCells;c++) {
		cell = createBasicCellDg('RBC' + objid.toString(), ht, clwdth, bcol, fcol, 'center', '1px', '1px', '1px', '1px', objid);
		cell.style.border = '1px solid gray';
		cell.style.backgroundColor = jsWCRatBColor2;
		cell.onclick= function(){establishRatingDisplayWc(c, nbrcells, tgtobjname, objid);};
		tr.appendChild(cell);
	}
	tbl.appendChild(tr);
	return tbl;
}

function establishRatingDisplayWc(col, nbrcells, tgtobjname, objid) {
	for (var c=0;c<nbrcells;c++) {
		if (col<=nbrcells) {
			document.getElementById('RBC' + objid.toString()).style.backgroundColor = jsWCRatBColor1;
		}
		else {
			document.getElementById('RBC' + objid.toString()).style.backgroundColor = jsWCRatBColor2;
		}
	}
	document.getElementById(tgtobjname).value = col.toString();
	return false;
}

function createContextMenuWc(objname, tgtctlname, objid) {
	// must have custom-contextm style class defined with large zindex and position absolute
	if (tgtctlName === undefined || tgtctlname === null) {tgtctlname = 'body';}
	if (tgtctlName === '') {tgtctlname = 'body';}
	$(document).bind("contextmenu", function (event) {
		// Avoid the real one
		event.preventDefault();
		// Show contextmenu
		$(".custom-contextm").finish().toggle(100).
    // In the right position (the mouse)
    css({
    	top: event.pageY + "px",
    	left: event.pageX + "px"
    });
	});

	// If the document is clicked somewhere
	$(document).bind("mousedown", function (e) {
		// If the clicked element is not the menu
		if (!$(e.target).parents(".custom-contextm").length > 0) {
			// Hide it
			$(".custom-contextm").hide(100);
		}
	});

	// If the menu element is clicked
	$(".custom-contextm li").click(function(){
		// This is the triggered action name
		switch($(this).attr("data-action")) {
			case "first":
				HandleContextMenu(1);
				break;
			case "second":
				HandleContextMenu(2);
				break;
			case "third":
				HandleContextMenu(3);
				break;
			default:
				break;
		}
		// Hide it AFTER the action was triggered
		$(".custom-contextm").hide(100);
	});
}

function createTwoListConnectWc(objname, nbritems, list1hdr, list2hdr, src1, src2, vfield1, vfield2, tfield1, tfield2, displayobjnm, objid) {
	// objname is expected to be a DIV object
	var sli;
	var sRow = '';
	jsWCSelectNbr = -1;
	jsWCSelectNbr2 = -1;
	jsWCNbrItems = 0;
	jsWCNbrItems2 = nbritems;
	jsWCSelectedData = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
	jsWCSelectedData2 = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
	var obj = document.getElementById(objname);

	var tbl = document.createElement('table');
	tbl.id = 'T2LConn' + objid.toString();
	tbl.style.width = '100%';
	var tr = document.createElement('tr');
	var c1 = document.createElement('td');
	var c2 = document.createElement('td');
	var ol1 = document.createElement('ol');
	ol1.id = 'OListS1' + objid.toString();
	var ol2 = document.createElement('ol');
	ol2.id = 'OListS2' + objid.toString();
	// top column headers
	c1.innerHTML = list1hdr;
	c2.innerHTML = list2hdr;
	tr.appendChild(c1);
	tr.appendChild(c2);
	tbl.appendChild(tr);
	// data columns
	tr = document.createElement('tr');
	c1 = document.createElement('td');
	c2 = document.createElement('td');
	// load list 1 and attach click event to load left item in display
	for (var r=0;r < jsWCNbrItems2; r++) {
		sRow = r.toString();
		if (sRow.length === 1) {sRow = '0' + sRow;}
		if (r < src1.length) {
			sli = document.createElement('li');
			sli.id = 'T2LConn1' + sRow + objid.toString();
			sli.value = src1[r][vfield1].toString();
			jsWCTwoColListData[0][r][0] = src1[r][vfield1].toString();
			sli.innerHTML = src1[r][tfield1].toString();
			jsWCTwoColListData[0][r][1] = src1[r][tfield1].toString();
			sli.onclick=function() {
				Select2ColListItem(1, r, objid);
			};
			ol1.appendChild(sli);
		}
		if (r < src2.length) {
			sli = document.createElement('li');
			sli.id = 'T2LConn2' + sRow + objid.toString();
			sli.value = src2[r][vfield2].toString();
			jsWCTwoColListData[1][r][0] = src2[r][vfield2].toString();
			sli.innerHTML = src2[r][tfield2].toString();
			jsWCTwoColListData[1][r][1] = src2[r][tfield2].toString();
			sli.onclick=function() {
				Select2ColListItem(2, r, objid);
			};
			ol2.appendChild(sli);
		}
	}
	c1.appendChild(ol1);
	c2.appendChild(ol2);
	tr.appendChild(c1);
	tr.appendChild(c2);
	tbl.appendChild(tr);
	// set selected items header
	tr = document.createElement('tr');
	tr.id = 'T2LConnx3' + objid.toString();
	c1 = document.createElement('td');
	c1.colSpan = '2';
	c1.innerHTML = 'Selected Items:';
	tr.appendChild(c1);
	tbl.appendChild(tr);
	// attach place to hold selected text temporarily
	c1 = document.createElement('td');
	c2 = document.createElement('td');
	c1.id = 'SelTxtCol1' + objid.toString();
	c2.id = 'SelTxtCol2' + objid.toString();
	tr.appendChild(c1);
	tr.appendChild(c2);
	tbl.appendChild(tr);

	c1 = document.createElement('td');
	c2 = document.createElement('td');
	c1.innerHTML = list1hdr;
	c2.innerHTML = list2hdr;
	tr.appendChild(c1);
	tr.appendChild(c2);
	tbl.appendChild(tr);

	tr = document.createElement('tr');
	tr.id = 'T2LConnx4' + objid.toString();
	c1 = document.createElement('td');
	c2 = document.createElement('td');

	// set selected items block
	tr = document.createElement('tr');
	tr.id = 'T2LConnx5' + objid.toString();
	c1 = document.createElement('td');
	c1.innerHTML = 'Selected Items:';
	c1.colSpan = '2';
	tr.appendChild(c1);
	tbl.appendChild(tr);
	tr = document.createElement('tr');
	tr.id = 'T2LConnx5' + objid.toString();
	c1 = document.createElement('td');
	c1.colSpan = '2';

	var tbl2 = document.createElement('table');
	tbl2.id = 'tblSelectedItems' + objid.toString();
	var tr2 = document.createElement('tr');
	c2 = document.createElement('td');
	c2.style.backgroundColor = '#EFEFEF';
	c2.innerHTML = 'Item #1';
	tr2.appendChild(c2);
	c2 = document.createElement('td');
	c2.style.backgroundColor = '#EFEFEF';
	c2.innerHTML = 'Item #2';
	tr2.appendChild(c2);
	c2 = document.createElement('td');
	c2.style.backgroundColor = '#EFEFEF';
	c2.innerHTML = 'Action';
	tr2.appendChild(c2);
	tbl2.appendChild(tr2);
	c1.appendChild(tbl2);	
	tr.appendChild(c1);
	tbl.AppendChild(tr);
	// establish display area
	return false;
}

function connectTwoListItemsWc(side, rw, objid) {
	var obj;
	var sRow = rw.toString();
	if (sRow.length !== 2) {sRow = '0' + sRow;}
	var sli = document.createElement('li');
	if (side === 1) {
		if (jsWCSelectedData[rw] === 0) {
			obj = document.getElementById('T2LConn1' + sRow + objid.toString());
			document.getElementById('SelTxtCol1' + objid.toString()).innerHTML = obj.value;
			obj.style.backgroundColor = '#D0D0D0';
			jsWCSelectNbr = parseInt(jsWCTwoColListData[0][rw][0], 10);
			jsWCSelectedData[rw] = 1;
		}
		//else {
		//}
	}
	else {
		if (jsWCSelectedData2[rw] !== 0) {
			obj = document.getElementById('T2LConn2' + sRow + objid.toString());
			document.getElementById('SelTxtCol2' + objid.toString()).innerHTML = obj.value;
			obj.style.backgroundColor = '#D0D0D0';
			jsWCSelectNbr2 = parseInt(jsWCTwoColListData[1][rw][0], 10);
			jsWCSelectedData2[rw] = 1;
		}
		//else {
		//}
	}
	transferSelectedToListWc(objid);
	return false;
}

function transferSelectedToListWc(objid) {
	var sTd;
	var obj1 = document.getElementById('SelTxtCol1' + objid.toString());
	var obj2 = document.getElementById('SelTxtCol2' + objid.toString());
	var s = obj1.value;
	var s2 = obj2.value;
	if ((s.length > 0 && s2.length > 0) || (jsWCSelectNbr > -1 && jsWCSelectNbr2 > -1)) {
		jsWCNbrItems1++;
		var tbl = document.getElementById('tblSelectedItems' + objid.toString());
		var sTr = document.createElement('tr');
		sTr.id = 'SItmRow' + jsWCSelectNbr.toString();
		sTd = document.createElement('td');
		std.innerHTML = s + '<input type="hidden" id="hfSelItm1' + jsWCNbrItems1.toString() + '" value="' + jsWCSelectNbr.toString() + '" />';
		sTr.appendChild(sTd);
		sTd = document.createElement('td');
		std.innerHTML = s2 + '<input type="hidden" id="hfSelItm2' + jsWCNbrItems1.toString() + '" value="' + jsWCSelectNbr2.toString() + '" />';
		sTr.appendChild(sTd);
		sTd = document.createElement('td');
		std.innerHTML = '<a id="" "#" onclick="javascript:RemoveThisItem(' + jsWCNbrItems1.toString() + ');return false;">Remove</a>';
		sTr.appendChild(sTd);
		obj1.value = '';
		obj2.value = '';
		jsWCSelectNbr = 0;
		jsWCSelectNbr2 = 0;
	}
}

function RemoveThisItemWc(row) {
	// remove source row after getting IDs
	var obj = document.getElementById('SItmRow' + row.toString());
	var id = parseInt(document.getElementById('hfSelItm1' + row.toString()).value, 10);
	var id2 = parseInt(document.getElementById('hfSelItm2' + row.toString()).value, 10);
	var pobj = obj.parentElement();
	var sRow = '';
	pobj.removeChild(obj);
	// remove background color for select and unselect
	for (var itm=0; itm < jsWCNbrItems2; itm++) {
		sRow = itm.toString();
		if (sRow.length === 1) {sRow = '0' + sRow;}
		if (parseInt(jsWCTwoColListData[0][itm][0], 10) === id) {
			document.getElementById('T2LConn1' + sRow + objid.toString()).style.backgroundColor = '#FFFFFF';
			jsWCSelectedData[itm] = 0;
		}
		if (parseInt(jsWCTwoColListData[1][itm][0], 10) === id2) {
			document.getElementById('T2LConn2' + sRow + objid.toString()).style.backgroundColor = '#FFFFFF';
			jsWCSelectedData2[itm] = 0;
		}
	}
}

function createAttachDGStatusBarWc(parentTableNm, nCols, bcolor, fcolor, inittext, objid) {
	if (inittext === undefined || inittext === null) {inittext = '';}
	var rw = document.createElement('tr');
	var cell = document.createElement('td');
	cell.colSpan = nCols.toString();
	cell.style.backgroundColor = bcolor;
	cell.style.color = fcolor;
	cell.innerHTML = '<label id="lblDataGridStatus" >' + inittext + '</label>';
	var tbl = document.getElementById(parentTableNm);
	rw.appendChild(cell);
	tbl.appendChild(rw);
	return false;
}

function createHelpForBlockWc(objname, content, objid) {
	jsWCObjHelpData[objid] = content;
}

function createInfoBarWc(objname, content, objid) {
	// must be a table object at this point
	if (inittext === undefined || inittext === null) {inittext = '';}
	var rw = document.createElement('tr');
	var cell = document.createElement('td');
	cell.colSpan = nCols.toString();
	cell.style.backgroundColor = bcolor;
	cell.style.color = fcolor;
	cell.innerHTML = '<label id="lblObjectStatus' + objid.toString() + '" >' + content + '</label>';
	var tbl = document.getElementById(parentTableNm);
	rw.appendChild(cell);
	tbl.appendChild(rw);
	return false;
}

function createGrowingTextAreaWc(objname, objid) {
	// will not reduce after expansion
	//$(objname).keyup(function(e) {
	//	while($(this).outerHeight() < this.scrollHeight + parseFloat($(this).css("borderTopWidth")) + parseFloat($(this).css("borderBottomWidth"))) {
	//		$(this).height($(this).height()+1);
	//	};
	//});

	// expands or contracts
	$(document)
    .one('focus.textarea', '.autoExpand', function(){
    	var savedValue = this.value;
    	this.value = '';
    	this.baseScrollHeight = this.scrollHeight;
    	this.value = savedValue;
    })
    .on('input.textarea', '.autoExpand', function(){
    	var minRows = this.getAttribute('data-min-rows')|0,
					rows;
    	this.rows = minRows;
    	rows = Math.ceil((this.scrollHeight - this.baseScrollHeight) / 16);
    	this.rows = minRows + rows;
    });
}

function createFloatingFooterWc(objname, objid) {
	// Window load event used just in case window height is dependant upon images
	$(window).bind("load", function() { 
		var footerHeight = 0, footerTop = 0, $footer = $("#" + objname);
		positionFooter();
       
		function positionFooter() {
			footerHeight = $footer.height();
			footerTop = ($(window).scrollTop() + $(window).height() - footerHeight) + "px";

			if (($(document.body).height() + footerHeight) < $(window).height()) {
				$footer.css({
					position: "absolute"
				}).animate({
					top: footerTop
				});
			}
			else {
				$footer.css({
					position: "static"
				});
			}
		}

		$(window).scroll(positionFooter)
				.resize(positionFooter);
	});
}

function createMultiSelectWithChoiceListWc(objname, listdata, objid) {
	// objname is expected to be a DIV object
	var sli;
	var sRow = '';
	jsWCSelectNbr = -1;
	jsWCSelectNbr2 = -1;
	jsWCNbrItems = 0;
	jsWCNbrItems2 = nbritems;
	jsWCSelectedData = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
	var obj = document.getElementById(objname);

	var tbl = document.createElement('table');
	tbl.id = 'T2LConn' + objid.toString();
	tbl.style.width = '100%';
	var tr = document.createElement('tr');
	var c1 = document.createElement('td');
	var ol1 = document.createElement('ol');
	ol1.id = 'OListS1' + objid.toString();
	// top column headers
	c1.innerHTML = list1hdr;
	tr.appendChild(c1);
	tbl.appendChild(tr);
	// data columns
	tr = document.createElement('tr');
	c1 = document.createElement('td');
	// load list 1 and attach click event to load left item in display
	for (var r=0;r < jsWCNbrItems2; r++) {
		sRow = r.toString();
		if (sRow.length === 1) {sRow = '0' + sRow;}
		if (r < src1.length) {
			sli = document.createElement('li');
			sli.id = 'T2LConn1' + sRow + objid.toString();
			sli.value = src1[r][vfield1].toString();
			jsWCTwoColListData[0][r][0] = src1[r][vfield1].toString();
			sli.innerHTML = src1[r][tfield1].toString();
			jsWCTwoColListData[0][r][1] = src1[r][tfield1].toString();
			sli.onclick=function() {
				transferSelectedItemListWc(r, objid);
			};
			ol1.appendChild(sli);
		}
	}
	c1.appendChild(ol1);
	tr.appendChild(c1);
	tbl.appendChild(tr);
	// set selected items header
	tr = document.createElement('tr');
	tr.id = 'T2LConnx3' + objid.toString();
	c1 = document.createElement('td');
	c1.innerHTML = 'Selected Items:';
	tr.appendChild(c1);
	tbl.appendChild(tr);
	// attach place to hold selected text temporarily
	c1 = document.createElement('td');
	c1.id = 'SelTxtCol1' + objid.toString();
	tr.appendChild(c1);
	tbl.appendChild(tr);
	c1 = document.createElement('td');
	c1.innerHTML = list1hdr;
	tr.appendChild(c1);
	tbl.appendChild(tr);

	tr = document.createElement('tr');
	tr.id = 'T2LConnx4' + objid.toString();
	c1 = document.createElement('td');

	// set selected items block
	tr = document.createElement('tr');
	tr.id = 'T2LConnx5' + objid.toString();
	c1 = document.createElement('td');
	c1.innerHTML = 'Selected Items:';
	tr.appendChild(c1);
	tbl.appendChild(tr);
	tr = document.createElement('tr');
	tr.id = 'T2LConnx5' + objid.toString();
	c1 = document.createElement('td');
	var tbl2 = document.createElement('table');
	tbl2.id = 'tblSelectedItems' + objid.toString();
	var tr2 = document.createElement('tr');
	c2 = document.createElement('td');
	c2.style.backgroundColor = '#EFEFEF';
	c2.innerHTML = 'Item #1';
	tr2.appendChild(c2);
	c2 = document.createElement('td');
	c2.style.backgroundColor = '#EFEFEF';
	c2.innerHTML = 'Action';
	tr2.appendChild(c2);
	tbl2.appendChild(tr2);
	c1.appendChild(tbl2);	
	tr.appendChild(c1);
	tbl.AppendChild(tr);
	// establish display area
	return false;
}

// supports single item multiple pick list
function transferSelectedItemListWc(rw, objid) {
	var sTd;
	var s = jsWCTwoColListData[0][rw][1].value;
	if (s.length > 0 ) {
		jsWCNbrItems1++;
		var tbl = document.getElementById('tblSelectedItems' + objid.toString());
		var sTr = document.createElement('tr');
		sTr.id = 'SItmRow' + jsWCSelectNbr.toString();
		sTd = document.createElement('td');
		std.innerHTML = s + '<input type="hidden" id="hfSelItm1' + jsWCNbrItems1.toString() + '" value="' + jsWCTwoColListData[0][rw][0].toString() + '" />';
		sTr.appendChild(sTd);
		sTd = document.createElement('td');
		std.innerHTML = '<a id="" "#" onclick="javascript:RemoveThisItem(' + jsWCNbrItems1.toString() + ');return false;">Remove</a>';
		sTr.appendChild(sTd);
		jsWCSelectedData[rw] = 1;
		jsWCSelectNbr = 0;
	}
}

// supports single item multiple pick list
function RemoveThisListItemWc(row) {
	// remove source row after getting IDs
	var obj = document.getElementById('SItmRow' + row.toString());
	var id = parseInt(document.getElementById('hfSelItm1' + row.toString()).value, 10);
	var pobj = obj.parentElement();
	var sRow = '';
	pobj.removeChild(obj);
	// remove background color for select and unselect
	for (var itm=0; itm < jsWCNbrItems2; itm++) {
		sRow = itm.toString();
		if (sRow.length === 1) {sRow = '0' + sRow;}
		if (parseInt(jsWCTwoColListData[0][itm][0], 10) === id) {
			document.getElementById('T2LConn1' + sRow + objid.toString()).style.backgroundColor = '#FFFFFF';
		}
	}
	jsWCSelectedData[rw] = 0;
	return false;
}

// makes gets autocomplete id when text box is filled in - S. Meeds on 4/6/2015
function GetIDFromSelectedTextWc(objname, tgtobj, idreq) {
  //alert('fired!');
  var tval = '';
  var val = '';
  var txt = document.getElementById(objname).value;
  $("#" + objname).autocomplete("close");
  var id = 0;
  if (tgtobj.length > 0) {
    jtCACTgtObj = tgtobj;
  }
  var tlen = txt.length;
  //alert(tlen);
  //alert(jtCACTgtObj);
  if (tlen > 0) {
    if (MyListDataCn !== undefined && MyListDataCn !== null) {
      if (MyListDataCn.length > 2) {
        //alert(MyListDataCn.length);
        var ln = MyListDataCn.length;
        for (var row = 0; row < ln; row++) {
          val = MyListDataCn[row][1].toString().substr(0, tlen);
          //alert(val + '/' + txt);
          if (val === txt) {
            id = parseInt(MyListDataCn[row][0], 10);
            tval = MyListDataCn[row][1].toString();
            //alert(id);
            break;
          }
        }
      }
    }
    //alert(jtCACTgtObj);
    if (id > 0) {
      if (jtCACTgtObj.length > 0) {
        document.getElementById(jtCACTgtObj).value = id.toString();
      }
      document.getElementById(objname).value = tval;
    }
    else {
      if (idreq === 1) {
        alert('The text box value entered could not be found in the selection list.');
        document.getElementById(objname).value = '';
        document.getElementById(objname).focus();
      }
    }
    return id;
  }
  else {
    return 0;
  }
}

function FindEmployeeFromStrWc(pgid, objid, objname, idname, val, byid) {
  var MyReturnData;
  var id = 0;
  var url = "../Shared/AJAXServices.asmx/IdentifyOneEmployee";
  var MyData = "{'PgID':'" + pgid.toString() + "','ObjID':'" + objid.toString() + "','Val':'" + val + "','ByID':'" + byid.toString() + "'}";
  //alert(MyData);
  getJSONReturnDataAf(url, MyData, function (response)
  { MyReturnData = response; });
  //alert('Finished!');
  if (MyReturnData !== undefined && MyReturnData !== null) {
    if (MyReturnData.length > 0) {
      if (parseInt(MyReturnData[0].Found, 10) === 1) {
        id = parseInt(MyReturnData[0].EmpID, 10);
        document.getElementById(objname).value = MyReturnData[0].EmpFullName.toString();
        document.getElementById(idname).value = id.toString();
      }
    }
  }
  return false;
}

function FindAddressFromStrWc(pgid, objid, namefield, addrfield, cityfield, stfield, zipfield, cofield, phonefield, idfield, val, byid, fieldtype) {
  var MyReturnData;
  var id = 0;
  var val2 = '';
  if (namefield === undefined || namefield === null) { namefield = ''; }
  if (addrfield === undefined || addrfield === null) { addrfield = ''; }
  if (cityfield === undefined || cityfield === null) { cityfield = ''; }
  if (stfield === undefined || stfield === null) { stfield = ''; }
  if (zipfield === undefined || zipfield === null) { zipfield = ''; }
  if (cofield === undefined || cofield === null) { cofield = ''; }
  if (phonefield === undefined || phonefield === null) { phonefield = ''; }
  if (idfield === undefined || idfield === null) { idfield = ''; }
  if (val === undefined || val === null || val === '') { return false; }

  // AJAX Call
  var url = "../Shared/AJAXServices.asmx/IdentifyOneAddress";
  var MyData = "{'PgID':'" + pgid.toString() + "','ObjID':'" + objid.toString() + "','Val':'" + val + "','FieldType':'" + fieldtype.toString() + "','ByID':'" + byid.toString() + "'}";
  //alert(MyData);
  getJSONReturnDataAf(url, MyData, function (response)
  { MyReturnData = response; });
  //alert('Finished!');
  if (MyReturnData !== undefined && MyReturnData !== null) {
    if (MyReturnData.length > 0) {
      if (parseInt(MyReturnData[0].Found, 10) === 1) {
        //alert('Insert Fired!');
        id = parseInt(MyReturnData[0].DestID, 10);
        // company name
        if (namefield.length > 0) {
          document.getElementById(namefield).value = MyReturnData[0].CoName.toString();
        }
        // street address
        if (addrfield.length > 0) {
          document.getElementById(addrfield).value = MyReturnData[0].CoAddress.toString();
        }
        val2 = MyReturnData[0].CoCity.toString();
        if (val2 !== '' && cityfield.length > 0) { document.getElementById(cityfield).value = val2; }
        val2 = MyReturnData[0].CompState.toString();
        if (val2 !== '' && stfield.length > 0) { document.getElementById(stfield).value = val2; }
        val2 = MyReturnData[0].CompZip.toString();
        if (val2 !== '' && zipfield.length > 0) { document.getElementById(zipfield).value = val2; }
        val2 = MyReturnData[0].CoCountry.toString();
        if (val2 !== '' && cofield.length > 0) { document.getElementById(cofield).value = val2; }
        val2 = MyReturnData[0].CoPhone.toString();
        if (val2 !== '' && phonefield.length > 0) { document.getElementById(phonefield).value = val2; }
        document.getElementById(idfield).value = id.toString();
      }
    }
  }
  return false;
}
