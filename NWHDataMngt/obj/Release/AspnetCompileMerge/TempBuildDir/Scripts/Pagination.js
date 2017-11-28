/*Javascript file: Pagination.js
Contents:
  EstablishMainPgElementsPj(lvl, minonly)
  FillMainPgElementsPj(lvl)
  UpdateUIPageSettingPj(typ, objid, Nbr, sDt, val)
  ChangePgSizePj(val, objid)
  GoToNewPagePj(iLvl, dir, val)
  GotoItemEditPj(row, lastrow, dir)
  GotoItemEditPj2(row, lastrow, dir)
  getUIPageSettingsPj(lvl)
  UpdateUIPageSettingPj(typ, objid, Nbr, sDt, val)
*/

// Define main control element variable
var jiPfVersion = '1.0.0';
var jiPfVersDate = '10/23/2014';
var jbPagination = true;
var jiItemIDPj = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
var jiNbrPagesPj = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
var jiNbrRowsPj = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
var jiPgNbrPj = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
var jiPgObjType = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
var jiPgSizeDef = 20;
var jiPgSizePj = [20, 10, 10, 10, 10, 10, 10, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20];
var joBtnPageFirstPj;
var joBtnPageFirstPj2;
var joBtnPageFirstPj3;
var joBtnPageFirstPj4;
var joBtnPageFirstPj5;
var joBtnPageFirstPj6;
var joBtnPagePrevPj;
var joBtnPagePrevPj2;
var joBtnPagePrevPj3;
var joBtnPagePrevPj4;
var joBtnPagePrevPj5;
var joBtnPagePrevPj6;
var joBtnPageNextPj;
var joBtnPageNextPj2;
var joBtnPageNextPj3;
var joBtnPageNextPj4;
var joBtnPageNextPj5;
var joBtnPageNextPj6;
var joBtnPageLastPj;
var joBtnPageLastPj2;
var joBtnPageLastPj3;
var joLnkItemFirstPj;
var joLnkItemFirstPj2;
var joLnkItemFirstPj3;
var joLnkItemFirstPj4;
var joLnkItemFirstPj5;
var joLnkItemFirstPj6;
var joLnkItemPrevPj;
var joLnkItemPrevPj2;
var joLnkItemPrevPj3;
var joLnkItemPrevPj4;
var joLnkItemPrevPj5;
var joLnkItemPrevPj6;
var joLnkItemNextPj;
var joLnkItemNextPj2;
var joLnkItemNextPj3;
var joLnkItemNextPj4;
var joLnkItemNextPj5;
var joLnkItemNextPj6;
var joLnkItemLastPj;
var joLnkItemLastPj2;
var joLnkItemLastPj3;
var joLnkItemLastPj4;
var joLnkItemLastPj5;
var joLnkItemLastPj6;
var joMaxPgNbrLblPj;
var joMaxPgNbrLbl2Pj;
var joMaxPgNbrLblPj3;
var joMaxPgNbrLblPj4;
var joMaxPgNbrLblPj5;
var joMaxPgNbrLblPj6;
var joPaginationBarPj;
var joPaginationBarPj2;
var joPaginationBarPj3;
var joPaginationBarPj4;
var joPaginationBarPj5;
var joPaginationBarPj6;
var joPgNbrLblPj;
var joPgNbrLblPj2;
var joPgNbrLblPj3;
var joPgNbrLblPj4;
var joPgNbrLblPj5;
var joPgNbrLblPj6;
var joSelPgSizePj;
var joSelPgSizePj2;
var joSelPgSizePj3;
var joSelPgSizePj4;
var joSelPgSizePj5;
var joSelPgSizePj6;
var jotGotoPgNbrPj;
var jotGotoPgNbrPj2;
var jotGotoPgNbrPj3;
var jotGotoPgNbrPj4;
var jotGotoPgNbrPj5;
var jotGotoPgNbrPj6;
var MyPgSettingsPj;
var MyResultsPj;

function EstablishMainPgElementsPj(lvl, minonly) {
	jiPgNbrPj[lvl - 1] = 0;
	jiNbrPagesPj[lvl - 1] = 0;
	jiPgObjType[lvl - 1] = minonly;
	if (lvl === 1) {
		joPaginationBarPj = document.getElementById('divTablePageBar');
		joBtnPageFirstPj = document.getElementById('lnkPageFirst');
		joBtnPagePrevPj = document.getElementById('lnkPagePrev');
		joBtnPageNextPj = document.getElementById('lnkPageNext');
		joBtnPageLastPj = document.getElementById('lnkPageLast');
		joSelPgSizePj = document.getElementById('selPageSize');
		if (minonly === 0) {
			joPgNbrLblPj = document.getElementById('lblPageNbr');
			jotGotoPgNbrPj = document.getElementById('txtGotoPgNbr');
			joMaxPgNbrLblPj = document.getElementById('lblMaxPgNbr');
		}
		//alert('Done pagination!');
	}
	if (lvl === 2) {
		joPaginationBarPj2 = document.getElementById('divTablePageBar2');
		joBtnPageFirstPj2 = document.getElementById('lnkPageFirst2');
		joBtnPagePrevPj2 = document.getElementById('lnkPagePrev2');
		joBtnPageNextPj2 = document.getElementById('lnkPageNext2');
		joBtnPageLastPj2 = document.getElementById('lnkPageLast2');
		//joSelPgSizePj2 = document.getElementById('selPageSize2');
		if (minonly === 0) {
			joPgNbrLblPj2 = document.getElementById('lblPageNbr2');
			jotGotoPgNbrPj2 = document.getElementById('txtGotoPgNbr2');
			joMaxPgNbrLblPj2 = document.getElementById('lblMaxPgNbr2');
		}
	}
	if (lvl === 3) {
		joPaginationBarPj3 = document.getElementById('divTablePageBar3');
		joBtnPageFirstPj3 = document.getElementById('lnkPageFirst3');
		joBtnPagePrevPj3 = document.getElementById('lnkPagePrev3');
		joBtnPageNextPj3 = document.getElementById('lnkPageNext3');
		joBtnPageLastPj3 = document.getElementById('lnkPageLast3');
		joSelPgSizePj3 = document.getElementById('selPageSize3');
		if (minonly === 0) {
			joPgNbrLblPj3 = document.getElementById('lblPageNbr3');
			jotGotoPgNbrPj3 = document.getElementById('txtGotoPgNbr3');
			joMaxPgNbrLblPj3 = document.getElementById('lblMaxPgNbr3');
		}
	}
	if (lvl === 4) {
		joPaginationBarPj4 = document.getElementById('divTablePageBar4');
		joBtnPageFirstPj4 = document.getElementById('lnkPageFirst4');
		joBtnPagePrevPj4 = document.getElementById('lnkPagePrev4');
		joBtnPageNextPj4 = document.getElementById('lnkPageNext4');
		joBtnPageLastPj4 = document.getElementById('lnkPageLast4');
		joSelPgSizePj4 = document.getElementById('selPageSize4');
		if (minonly === 0) {
			joPgNbrLblPj4 = document.getElementById('lblPageNbr4');
			jotGotoPgNbrPj4 = document.getElementById('txtGotoPgNbr4');
			joMaxPgNbrLblPj4 = document.getElementById('lblMaxPgNbr4');
		}
	}
	if (lvl === 5) {
		joPaginationBarPj5 = document.getElementById('divTablePageBar5');
		joBtnPageFirstPj5 = document.getElementById('lnkPageFirst5');
		joBtnPagePrevPj5 = document.getElementById('lnkPagePrev5');
		joBtnPageNextPj5 = document.getElementById('lnkPageNext5');
		joBtnPageLastPj5 = document.getElementById('lnkPageLast5');
		joSelPgSizePj5 = document.getElementById('selPageSize5');
		if (minonly === 0) {
			joPgNbrLblPj5 = document.getElementById('lblPageNbr5');
			jotGotoPgNbrPj5 = document.getElementById('txtGotoPgNbr5');
			joMaxPgNbrLblPj5 = document.getElementById('lblMaxPgNbr5');
		}
	}
	if (lvl === 6) {
		joPaginationBarPj6 = document.getElementById('divTablePageBar6');
		joBtnPageFirstPj6 = document.getElementById('lnkPageFirst6');
		joBtnPagePrevPj6 = document.getElementById('lnkPagePrev6');
		joBtnPageNextPj6 = document.getElementById('lnkPageNext6');
		joBtnPageLastPj6 = document.getElementById('lnkPageLast6');
		joSelPgSizePj6 = document.getElementById('selPageSize6');
		if (minonly === 0) {
			joPgNbrLblPj6 = document.getElementById('lblPageNbr6');
			jotGotoPgNbrPj6 = document.getElementById('txtGotoPgNbr6');
			joMaxPgNbrLblPj6 = document.getElementById('lblMaxPgNbr6');
		}
	}
	if (lvl === 34) {
		joLnkItemFirstPj = document.getElementById('lnkGotoItemFirst');
		joLnkItemPrevPj = document.getElementById('lnkGotoItemPrev');
		joLnkItemNextPj = document.getElementById('lnkGotoItemNext');
		joLnkItemLastPj = document.getElementById('lnkGotoItemLast');
	}
	if (lvl === 35) {
		joLnkItemFirstPj2 = document.getElementById('lnkGotoItemFirst2');
		joLnkItemPrevPj2 = document.getElementById('lnkGotoItemPrev2');
		joLnkItemNextPj2 = document.getElementById('lnkGotoItemNext2');
		joLnkItemLastPj2 = document.getElementById('lnkGotoItemLast2');
	}
}

function FillMainPgElementsPj(lvl) {
	//alert('Fired 1!');
	var ps = 0;
	if (MyPgSettingsPj !== undefined && MyPgSettingsPj !== null) {
		//alert('Fired 1.1!');
		if (MyPgSettingsPj.length > 0) {
			jiPgNbrPj[lvl-1] = parseInt(MyPgSettingsPj[0].PgNbr, 10);
			jiNbrPagesPj[lvl-1] = 1;
			ps = parseInt(MyPgSettingsPj[0].PgSize, 10);
			if (ps < 10) { ps = jiPgSizeDef; }
			jiPgSizePj[lvl-1] = ps;
			//alert('Has Rows!');
			if (lvl === 1) {
				jotGotoPgNbrPj.value = '';
				joSelPgSizePj.value = jiPgSizePj[lvl-1].toString();
				joPgNbrLblPj.innerHTML = (jiPgNbrPj[lvl-1] + 1).toString();
			}
			if (lvl === 2) {
				jotGotoPgNbrPj2.value = '';
				joPgNbrLblPj2.innerHTML = (jiPgNbrPj[lvl-1]+1).toString();
				joSelPgSizePj2.value = jiPgSizePj[lvl-1].toString();
			}
			if (lvl === 3) {
				jotGotoPgNbrPj3.value = '';
				joPgNbrLblPj3.innerHTML = (jiPgNbrPj[lvl - 1] + 1).toString();
				joSelPgSizePj3.value = jiPgSizePj[lvl - 1].toString();
			}
			if (lvl === 4) {
				jotGotoPgNbrPj4.value = '';
				joPgNbrLblPj4.innerHTML = (jiPgNbrPj[lvl - 1] + 1).toString();
				joSelPgSizePj4.value = jiPgSizePj[lvl - 1].toString();
			}
			if (lvl === 5) {
				jotGotoPgNbrPj5.value = '';
				joPgNbrLblPj5.innerHTML = (jiPgNbrPj[lvl - 1] + 1).toString();
				joSelPgSizePj5.value = jiPgSizePj[lvl - 1].toString();
			}
			if (lvl === 6) {
				jotGotoPgNbrPj6.value = '';
				joPgNbrLblPj6.innerHTML = (jiPgNbrPj[lvl - 1] + 1).toString();
				joSelPgSizePj6.value = jiPgSizePj[lvl - 1].toString();
			}
		}
		else {
			jiPgNbrPj[lvl - 1] = 0;
			jiNbrPagesPj[lvl - 1] = 0;
			if (lvl === 1) {
				jotGotoPgNbrPj.value = '';
				joSelPgSizePj.value = jiPgSizePj.toString();
				joPgNbrLblPj.innerHTML = '1';
			}
			if (lvl === 2) {
				jotGotoPgNbrPj2.value = '';
				joPgNbrLblPj2.innerHTML = (jiPgNbrPj[lvl - 1] + 1).toString();
			}
			if (lvl === 3) {
				jotGotoPgNbrPj3.value = '';
				joPgNbrLblPj3.innerHTML = (jiPgNbrPj[lvl - 1] + 1).toString();
			}
			if (lvl === 4) {
				jotGotoPgNbrPj4.value = '';
				joPgNbrLblPj4.innerHTML = (jiPgNbrPj[lvl - 1] + 1).toString();
			}
			if (lvl === 5) {
				jotGotoPgNbrPj5.value = '';
				joPgNbrLblPj5.innerHTML = (jiPgNbrPj[lvl - 1] + 1).toString();
			}
			if (lvl === 6) {
				jotGotoPgNbrPj6.value = '';
				joPgNbrLblPj6.innerHTML = (jiPgNbrPj[lvl - 1] + 1).toString();
			}
		}
	}
}

/*****************************************************************/
function GoToNewPagePj(iLvl, dir, val) {
	var objid = iLvl;
	iLvl--;
	var pg = jiPgNbrPj[iLvl];
	var pgL = jiNbrPagesPj[iLvl];
	//alert('Got it! - ' + iLvl + '/' + dir + '/' + val + '/' + pg + '/' + pgL);
	// change page number
	switch (dir) {
		case 0:
			jiPgNbrPj[iLvl] = 0;
			break;
		case 1:
			if(jiPgNbrPj[iLvl] > 0) {
				//alert('going down');
				jiPgNbrPj[iLvl]--;
			}
			break;
		case 2:
			if(jiPgNbrPj[iLvl] < (pgL - 1)) {
				//alert('going up');
				jiPgNbrPj[iLvl]++;
			}
			break;
		case 3:
			jiPgNbrPj[iLvl] = pgL-1;
			break;
		case 4:
			if(parseInt(val, 10) <= pgL) {
				jiPgNbrPj[iLvl] = parseInt(val, 10) - 1;
			}
			break;
		default:
			// nothing
			break;
	}
	//alert('Part 2- ' + iLvl + '/' + dir + '/' + val + '/' + pg + '/' + pgL);

	// ensure changed page numbers are within limits
	if (jiPgNbrPj[iLvl] < 0) { jiPgNbrPj[iLvl] = 0; }
	if(jiPgNbrPj[iLvl] > (jiNbrPagesPj[iLvl] - 1)) { jiPgNbrPj[iLvl] = jiNbrPagesPj[iLvl] - 1; }
	pg = jiPgNbrPj[iLvl];
	pgL = jiNbrPagesPj[iLvl];
	//alert(jiPgNbrPj[iLvl] + '/' + jiNbrPagesPj[iLvl] + '/' + pg + '/' + pgL);

	// Goto new page
	switch (objid) {
		case 1:
			if (pg > 0 && pg < pgL) {
				joBtnPageFirstPj.disabled = false;
				joBtnPagePrevPj.disabled = false;
				joBtnPageNextPj.disabled = false;
				joBtnPageLastPj.disabled = false;
			}
			else {
				if (pg === 0) {
					joBtnPageFirstPj.disabled = true;
					joBtnPagePrevPj.disabled = true;
					joBtnPageNextPj.disabled = false;
					joBtnPageLastPj.disabled = false;
				}
				if (pg === pgL) {
					joBtnPageFirstPj.disabled = false;
					joBtnPagePrevPj.disabled = false;
					joBtnPageNextPj.disabled = true;
					joBtnPageLastPj.disabled = true;
				}
			}
			jotGotoPgNbrPj.value = '';
			joPgNbrLblPj.innerHTML = (pg + 1).toString();
			DataCall1();
			break;
		case 2:
			if (pg > 0 && pg < pgL) {
				joBtnPageFirstPj2.disabled = false;
				joBtnPagePrevPj2.disabled = false;
				joBtnPageNextPj2.disabled = false;
				joBtnPageLastPj2.disabled = false;
			}
			else {
				if (pg === 0) {
					joBtnPageFirstPj2.disabled = true;
					joBtnPagePrevPj2.disabled = true;
					joBtnPageNextPj2.disabled = false;
					joBtnPageLastPj2.disabled = false;
				}
				if (pg === pgL) {
					joBtnPageFirstPj2.disabled = false;
					joBtnPagePrevPj2.disabled = false;
					joBtnPageNextPj2.disabled = true;
					joBtnPageLastPj2.disabled = true;
				}
			}
			jotGotoPgNbrPj2.value = '';
			joPgNbrLblPj2.innerHTML = (pg + 1).toString();
			DataCall2();
			break;
		case 3:
			if (pg > 0 && pg < pgL) {
				joBtnPageFirstPj3.disabled = false;
				joBtnPagePrevPj3.disabled = false;
				joBtnPageNextPj3.disabled = false;
				joBtnPageLastPj3.disabled = false;
			}
			else {
				if (pg === 0) {
					joBtnPageFirstPj3.disabled = true;
					joBtnPagePrevPj3.disabled = true;
					joBtnPageNextPj3.disabled = false;
					joBtnPageLastPj3.disabled = false;
				}
				if (pg === pgL) {
					joBtnPageFirstPj3.disabled = false;
					joBtnPagePrevPj3.disabled = false;
					joBtnPageNextPj3.disabled = true;
					joBtnPageLastPj3.disabled = true;
				}
			}
			jotGotoPgNbrPj3.value = '';
			joPgNbrLblPj3.innerHTML = (pg + 1).toString();
			DataCall3();
			break;
		case 4:
			if (pg > 0 && pg < pgL) {
				joBtnPageFirstPj4.disabled = false;
				joBtnPagePrevPj4.disabled = false;
				joBtnPageNextPj4.disabled = false;
				joBtnPageLastPj4.disabled = false;
			}
			else {
				if (pg === 0) {
					joBtnPageFirstPj4.disabled = true;
					joBtnPagePrevPj4.disabled = true;
					joBtnPageNextPj4.disabled = false;
					joBtnPageLastPj4.disabled = false;
				}
				if (pg === pgL) {
					joBtnPageFirstPj4.disabled = false;
					joBtnPagePrevPj4.disabled = false;
					joBtnPageNextPj4.disabled = true;
					joBtnPageLastPj4.disabled = true;
				}
			}
			jotGotoPgNbrPj4.value = '';
			joPgNbrLblPj4.innerHTML = (pg + 1).toString();
			DataCall4();
			break;
		case 5:
			if (pg > 0 && pg < pgL) {
				joBtnPageFirstPj5.disabled = false;
				joBtnPagePrevPj5.disabled = false;
				joBtnPageNextPj5.disabled = false;
				joBtnPageLastPj5.disabled = false;
			}
			else {
				if (pg === 0) {
					joBtnPageFirstPj5.disabled = true;
					joBtnPagePrevPj5.disabled = true;
					joBtnPageNextPj5.disabled = false;
					joBtnPageLastPj5.disabled = false;
				}
				if (pg === pgL) {
					joBtnPageFirstPj5.disabled = false;
					joBtnPagePrevPj5.disabled = false;
					joBtnPageNextPj5.disabled = true;
					joBtnPageLastPj5.disabled = true;
				}
			}
			jotGotoPgNbrPj5.value = '';
			joPgNbrLblPj5.innerHTML = (pg + 1).toString();
			DataCall5();
			break;
		case 6:
			if (pg > 0 && pg < pgL) {
				joBtnPageFirstPj6.disabled = false;
				joBtnPagePrevPj6.disabled = false;
				joBtnPageNextPj6.disabled = false;
				joBtnPageLastPj6.disabled = false;
			}
			else {
				if (pg === 0) {
					joBtnPageFirstPj6.disabled = true;
					joBtnPagePrevPj6.disabled = true;
					joBtnPageNextPj6.disabled = false;
					joBtnPageLastPj6.disabled = false;
				}
				if (pg === pgL) {
					joBtnPageFirstPj6.disabled = false;
					joBtnPagePrevPj6.disabled = false;
					joBtnPageNextPj6.disabled = true;
					joBtnPageLastPj6.disabled = true;
				}
			}
			jotGotoPgNbrPj6.value = '';
			joPgNbrLblPj6.innerHTML = (pg + 1).toString();
			DataCall6();
			break;
		default:
			break;
	}
	return false;
}

/*****************************************************************/
function ChangePgSizePj(val, objid) {
	var pgsz = parseInt(val, 10);
	jiPgSizePj[objid-1] = pgsz;
	UpdateUIPageSettingPj(1, objid, pgsz, '', '');
	jiPgNbrPj[objid-1] = 0;

	switch (objid) {
		case 1:
			DataCall1();
			break;
		case 2:
			DataCall2();
			break;
		case 3:
			DataCall3();
			break;
		case 4:
			DataCall4();
			break;
		case 5:
			DataCall5();
			break;
		case 6:
			DataCall6();
			break;
		default:
			// nothing
			break;
	}
	return false;
}

/*****************************************************************/
function GotoItemEditPj(row, lastrow, dir, objid) {
	switch (objid) {
		case 1:
			switch (dir) {
				case 0: // first
					row = 0;
					joLnkItemFirstPj.disabled = true;
					joLnkItemPrevPj.disabled = true;
					if (row < lastrow) {
						joLnkItemNextPj.disabled = false;
						joLnkItemLastPj.disabled = false;
					}
					break;
				case 1: // prev
					row--;
					if (row === 0) {
						joLnkItemFirstPj.disabled = true;
						joLnkItemPrevPj.disabled = true;
						if (row < lastrow) {
							joLnkItemNextPj.disabled = false;
							joLnkItemLastPj.disabled = false;
						}
					}
					break;
				case 2: // next
					row++;
					if (row === lastrow) {
						joLnkItemNextPj.disabled = true;
						joLnkItemLastPj.disabled = true;
					}
					if (row > 0) {
						joLnkItemFirstPj.disabled = false;
						joLnkItemPrevPj.disabled = false;
					}
					break;
				case 3: // last
					row = lastrow;
					joLnkItemNextPj.disabled = true;
					joLnkItemLastPj.disabled = true;
					if (row > 0) {
						joLnkItemFirstPj.disabled = false;
						joLnkItemPrevPj.disabled = false;
					}
					break;
				default:
					break;
			}
			break;
		case 2:
			switch (dir) {
				case 0: // first
					row = 0;
					joLnkItemFirstPj2.disabled = true;
					joLnkItemPrevPj2.disabled = true;
					if (row < lastrow) {
						joLnkItemNextPj2.disabled = false;
						joLnkItemLastPj2.disabled = false;
					}
					break;
				case 1: // prev
					row--;
					if (row === 0) {
						joLnkItemFirstPj2.disabled = true;
						joLnkItemPrevPj2.disabled = true;
						if (row < lastrow) {
							joLnkItemNextPj2.disabled = false;
							joLnkItemLastPj2.disabled = false;
						}
					}
					break;
				case 2: // next
					row++;
					if (row === lastrow) {
						joLnkItemNextPj2.disabled = true;
						joLnkItemLastPj2.disabled = true;
					}
					if (row > 0) {
						joLnkItemFirstPj2.disabled = false;
						joLnkItemPrevPj2.disabled = false;
					}
					break;
				case 3: // last
					row = lastrow;
					joLnkItemNextPj2.disabled = true;
					joLnkItemLastPj2.disabled = true;
					if (row > 0) {
						joLnkItemFirstPj2.disabled = false;
						joLnkItemPrevPj2.disabled = false;
					}
					break;
				default:
					break;
			}
			break;
		default:
			break;
	}

	return row;
}

/*****************************************************************/
function getUIPageSettingsPj(lvl) {
	var url = "Shared/Pagination.asmx/getUIPageSettings";
	var MyData = "{'PageID':'" + jiPageID.toString() + "','ObjID':'" + lvl.toString() + "','ByID':'" + jiUserID.toString() + "'}";
	//alert(MyData);
	getJSONReturnDataUt(url, MyData, function (response)
	{ MyPgSettingsPj = response; });
	return false;
}

function UpdateUIPageSettingPj(typ, objid, Nbr, sDt, val) {
	//alert('Fired save!');
	var url = "Shared/Pagination.asmx/UpdateUIPageSetting";
	var MyData = "{'PageID':'" + jiPageID.toString() + "','ObjID':'" + objid.toString() + "','iType':'" + typ.toString() + "','Nbr':'" + Nbr.toString() + "',";
	MyData = MyData + "'dte':'" + sDt.toString() + "','Value':'" + val + "','ByID':'" + jiUserID.toString() + "'}";
	//alert('UpateUIPgSet ' + MyData);
	getJSONReturnDataUt(url, MyData, function (response)
	{ MyResultsPj = response; });
	return false;
}

function UpdateGenUserTracks() {

}
