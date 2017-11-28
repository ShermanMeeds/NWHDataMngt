/* GenUtils.js - last updated 7/10/2017
-- Code checked 5/28/2015
Contents:	
  IsContentsNullUndefinedGu(val)
  IsContentsNullUndefEmptyGu(txt, typ)
	createArrayGu(length)
	createArrayInitGu(length, isNbr)
	MultiDimensionalArrayGu(iRows, iCols)
	createDimension2ArrayGu(iRows, iCols, typ)
	createDimension3ArrayGu(iRows, iCols, i3, typ)
	IsNotEmptyGu(sval)
	IsNumberStringGu(sval)
	IsSameGu(val1, val2)
	IsEmailAddressGu(val)
  IsPhoneNbrGu(val, reqtype)
	fillDropDownListGu(lst, obj, tgtid, srctxt, srcval)
	fillDropDownList2Gu(lst, obj, tgtid, srctxt1, srctxt2, dchar, cast1, cast2, srcval)
	fillDropDownList3Gu(lst, obj, tgtid, srctxt1, srctxt2, srctxt3, dchar, cast1, cast2, cast3, srcval)
	fillOptionBoxGu(selbox, slst, sepchar, typ, sID)
	getSelectMultipleItemsGu(obj)
	getDDLSelectedTextGu(objname)
	getDDLSelectedValGu(objname)
  getSelectedTextByIndexGu(objname, idx)
	setDDLSelectedByTextGu(objname, txt)
  isObjArrayGu(Obj)
  isArrayGu(input)
  PrintDivGu(objname)
	createObjIDGu(pref, rw, col)
	createNewCellGu(id, ht, wdth, content, bkColor, frColor, brdr, hAlign, vAlign, padl, padr, padt, padb, fontSz, IsBold, ovrflw, RdOnly, dsabld, IsVisible, colspn, rwspn)
	createNewCellExpGu(id, ht, wdth, content, bkColor, frColor, brdrL, brdrR, brdrT, brdrB, hAlign, vAlign, padl, padr, padt, padb, fontSz, IsBold, ovrflw, RdOnly, dsabld, IsVisible, colspn, rwspn)
	ClearDDLOptionsGu(objname, keepfirst)
	appendDDLOptionGu(obj, val, text)
  RemoveDDLOptionItemGu(objname, val) {
	removeOptionsGu(selbox) {
	getWindowDimensionGu(typ)
	getDialogMarginPcntGu(typ, objname)
	setSessionValGu(valName, val)  --> Requires MyResponse object
	createKeyValMapGu(MyJSONList, valCol, txtCol, NbrType)
	createValueSetGu(MyJSONList, tCol, NbrType)
	fadeInObjectGu(objname)
	fadeOutObjectGu(objname)
	MoveObjectAnimatedGu(objname, sleft, stop, bwdth, spd)
	addEventHandlerGu(elem, eventType, handler)
	setDatePickerDialogGu(objname)
  arrayBufferToStrGu(buf)
  stringToArrayBufferGu(str)
  ConvertStringToArrayBufferGu2(string, callback)
  ConvertArrayBufferToStringGu2(buf, callback)
  dataURItoBlobGu(dataURI)
  GetMimeTypeGu(ftype)
  GetFileContentTypeGu(mtype)
  base64EncodeGu(text)
  base64DecodeGu(text)
  b64toBlobGu(b64Data, contentType, sliceSize)
  base64toBlobGu(base64Data, contentType)
  getBase64ImageGu(sdatUrl)
  convertArrayBufferToBase64Gu(buf)
  convertArrayBuffertoStringGu(buf)
  SleepForSecondsGu(scd)
  jsfTimeSleepUntilGu(timestamp)
  joinGu(glue, pieces)
  implodeGu(glue, pieces)
  convertJSONtoJSArrayGu(arr)
  PrintDivGu(objname)
  SetArrayOfInputObjectsGu()
  SetArrayOfFormInputObjectsGu()
  getNewRowGu(rowID, rowNbr, lnheight)
  showCurrentVarsGu()
  StripNbrDisplayCharsGu(sval)
  addEventHandlerGu(elem, eventType, handler)
  setDatePickerDialogGu(objname)
  ItemInJSONListGu(MyJSONList, colname)
  ItemInArrayGu(Arr, colname)
	FindFirstMatchValueInJSONArrayGu(key, value, haystack)
	findRadioSelectionGu(nm)
	FindItemInDDLGu(ddlpointer, val, typ, doselect)
	IdentifyArrayIndexGu(jsonlist, colname, val)
	AppendItemToULListGu(ulpointer, ulid, txt)
	UnderlineBoldSelectedTextGu(txt, typ)
	GetSelectionInsideTextareaGu(objpointer)
	InsertRowIntoTableGu(tblname, idx, rowobj)
	RemoveRowFromTableGu(tblname, idx)
*/
var jsGUfVersion = '1.2.2';
var jsGUfVersDate = '9/1/2017';

function IsContentsNullUndefinedGu(val) {
	if (val === undefined || val === null) {
		return true;
	}
	else {
		return false;
	}
}

function IsContentsNullUndefEmptyGu(txt, typ) {
	if (txt === undefined || txt === null) {
		return true;
	}
	else {
		if (typ === 0) {
			return false;
		}
		else {
			if (txt.length === 0) { return true; }
		}
	}
	return false;
}

// create multi-dimensional array - from http://stackoverflow.com/questions/966225/how-can-i-create-a-two-dimensional-array-in-javascript 
function createArrayGu(length) {
	var arr = new Array(length || 0), i = length;

	if (arguments.length > 1) {
		var args = Array.prototype.slice.call(arguments, 1);
		while (i--) {
			arr[length - 1 - i] = createArrayGu.apply(this, args);
		}
	}

	return arr;
}
//createArrayGu();     // [] or new Array()
//createArrayGu(2);    // new Array(2)
//createArrayGu(3, 2); // [new Array(2),

function createArrayInitGu(length, isNbr) {
	var arr = new Array(length || 0), i = length;

	if (arguments.length > 1) {
		var args = Array.prototype.slice.call(arguments, 1);
		while (i--) {
			arr[length - 1 - i] = createArrayInitGu.apply(this, args);
		}
	}
	for (var row = 0; row < length; row++) {
		if (isNbr === true) {
			arr[row] = 0;
		}
		else {
			arr[row] = '';
		}
	}
	return arr;
}

function MultiDimensionalArrayGu(iRows, iCols) {
	var i;
	var j;
	var table = new Array(iRows);
	for (i = 0; i < iRows; i++) {
		table[i] = new Array(iCols);
		for (j = 0; j < iCols; j++) {
			table[i][j] = "";
		}
	}
	return (table);
}

function createDimension2ArrayGu(iRows, iCols, typ) {
	var i;
	var j;
	var table = new Array(iRows);
	for (i = 0; i < iRows; i++) {
		table[i] = new Array(iCols);
		for (j = 0; j < iCols; j++) {
			if (typ === 0) {
				table[i][j] = 0;
			}
			else {
				table[i][j] = "";
			}
		}
	}
	return (table);
}

function createDimension3ArrayGu(iRows, iCols, i3, typ) {
	var i;
	var j;
	var k;
	var table = new Array(iRows);

	for (i = 0; i < iRows; i++) {
		table[i] = new Array(iCols);
		for (j = 0; j < iCols; j++) {
			table[i][j] = new Array(i3);
			for (k = 0; k < i3; k++) {
				if (typ === 0) {
					table[i][j][k] = 0;
				}
				else {
					table[i][j][k] = "";
				}
			}
		}
	}
	return (table);
}

function IsNotEmptyGu(sval) {
	var pattern = /\S+/;
	return pattern.test(sval);
}

function IsNumberStringGu(sval) {
	var pattern = /^-?\d*[\.]?\d+$/;
	//var pattern = /^\d+$/;
	return pattern.test(sval);
}

function IsSameGu(val1, val2) {
	return val1 === val2;
}

function IsEmailAddressGu(val) {
	var pattern = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
	return pattern.test(val);  // returns a boolean
}

function IsPhoneNbrGu(val, reqtype) {
	//reqtype: XXX-XXXX, XXX-XXX-XXXX, XXX-XXX-XXXX xXXXXX, (XXX) XXX-XXXX
	var iloc = 0;
	// change (xxx) xxx-xxx format to xxx-xxx-xxxx format
	val = val.replace('(', '').replace(') ', '- ');
	val = Trim(val.replace('- ', '-'));
	// remove any leading dash
	if (val.substr(0, 1) === '-') { val = val.substr(1, (val.length - 1));} 
	var b = val.split(' '); // ignore characters after space since that would be extension of varying nbr digits
	var a = b[0].split('-');
	switch (a.length) {
		case 1: // extension only
			if (reqtype !== 2) { return false; }
			break;
		case 2: // XXX-XXXX
			iloc = a[1].index(' ');
			if (a[0].length !== 3 || (a[1].length !== 4) ) { return false;}
			break;
		case 3: // XXX-XXX-XXXX
			if (a[0].length !== 3 || a[1].length !== 3 || a[2].length !== 4) { return false; }
			break;
		case 4: // XX-XXX-XXX-XXXX,
			if (a[0].length > 3 || a[1].length !== 3 || a[2].length !== 3 || a[3].length !== 4) { return false; }
		default:
			return false;
			break;
	}
	return true;
}

function fillDropDownListGu(lst, obj, tgtid, srctxt, srcval) {
	// check type of object !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	var txt = '';
	var t = '';
	var v = '';
	var tlgth = lst.length;
	//alert('Adding ' + tlgth + ' items');
	//alert('Browser Type: ' + jsBrowserType);
	for (var i = 0; i < tlgth; i++) {
		var opt = document.createElement("option");
		t = lst[i][srctxt];
		opt.text = t;
		v = lst[i][srcval];
		opt.value = lst[i][srcval];
		//alert(t + '/' + v);
		if (jsBrowserType == 'IE7' || jsBrowserType == 'IE6') {
			try {
				$(obj).append(opt);
				$(opt).text(t);
			}
			catch (err) {
				obj.options.add(opt);
			}
		}
		else {
			if (jsBrowserType == 'IE8' || jsBrowserType == 'IE8' || jsBrowserType == 'IE8' || jsBrowserType == 'IE8' || jsBrowserType == 'InternetExplorer11') {
				obj.add(opt);
			}
			else {
				obj.options.add(opt, null);
			}
		}
		if (lst[i][srcval] === tgtid) {
			obj.options[i].selected = true;
			txt = t;
		}
	}
	return txt;
}

function fillDropDownList2Gu(lst, obj, tgtid, srctxt1, srctxt2, dchar, cast1, cast2, srcval) {
	// check type of object !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	if (dchar === undefined || dchar === null || dchar === '') { dchar = ';'; }
	var txt = '';
	var t = '';
	var t1 = '';
	var t2 = '';
	var v = '';
	var tlgth = lst.length;
	//alert('Adding ' + tlgth + ' items');
	//alert('Browser Type: ' + jsBrowserType);
	setStringFormatDg(dat, typ)


	for (var i = 0; i < tlgth; i++) {
		var opt = document.createElement("option");
		t1 = lst[i][srctxt1];
		if (cast1 > 0) { t1 = setStringFormatDg(t1, cast1); }
		t2 = lst[i][srctxt2];
		if (cast2 > 0) { t2 = setStringFormatDg(t2, cast2); }
		t = t1 + dchar + t2;
		opt.text = t;
		v = lst[i][srcval];
		opt.value = lst[i][srcval];
		//alert(t + '/' + v);
		if (jsBrowserType == 'IE7' || jsBrowserType == 'IE6') {
			try {
				$(obj).append(opt);
				$(opt).text(t);
			}
			catch (err) {
				obj.options.add(opt);
			}
		}
		else {
			if (jsBrowserType == 'IE8' || jsBrowserType == 'IE8' || jsBrowserType == 'IE8' || jsBrowserType == 'IE8' || jsBrowserType == 'InternetExplorer11') {
				obj.add(opt);
			}
			else {
				obj.options.add(opt, null);
			}
		}
		if (lst[i][srcval] === tgtid) {
			obj.options[i].selected = true;
			txt = t;
		}
	}
	return txt;
}

function fillDropDownList3Gu(lst, obj, tgtid, srctxt1, srctxt2, srctxt3, dchar, cast1, cast2, cast3, srcval) {
	// check type of object !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	if (dchar === undefined || dchar === null || dchar === '') { dchar = ';'; }
	var txt = '';
	var t = '';
	var t1 = '';
	var t2 = '';
	var t3 = '';
	var v = '';
	var tlgth = lst.length;
	//alert('Adding ' + tlgth + ' items');
	//alert('Browser Type: ' + jsBrowserType);
	for (var i = 0; i < tlgth; i++) {
		var opt = document.createElement("option");
		t1 = lst[i][srctxt1];
		if (cast1 > 0) { t1 = setStringFormatDg(t1, cast1); }
		t2 = lst[i][srctxt2];
		if (cast2 > 0) { t2 = setStringFormatDg(t2, cast2); }
		t3 = lst[i][srctxt3];
		if (cast3 > 0) { t3 = setStringFormatDg(t3, cast3); }
		t = t1 + dchar + t2 + dchar + t3;
		opt.text = t;
		v = lst[i][srcval];
		opt.value = lst[i][srcval];
		//alert(t + '/' + v);
		if (jsBrowserType == 'IE7' || jsBrowserType == 'IE6') {
			try {
				$(obj).append(opt);
				$(opt).text(t);
			}
			catch (err) {
				obj.options.add(opt);
			}
		}
		else {
			if (jsBrowserType == 'IE8' || jsBrowserType == 'IE8' || jsBrowserType == 'IE8' || jsBrowserType == 'IE8' || jsBrowserType == 'InternetExplorer11') {
				obj.add(opt);
			}
			else {
				obj.options.add(opt, null);
			}
		}
		if (lst[i][srcval] === tgtid) {
			obj.options[i].selected = true;
			txt = t;
		}
	}
	return txt;
}

// updated: 11/25/2014 by S. Meeds
function fillOptionBoxGu(selbox, slst, sepchar, typ, sID) {
	var i = 0;
	var opt;
	//alert(slst.length);

	if (slst !== '') {
		var ListItems = slst.split(sepchar);
		// add ALL line if necessary
		if (typ === 1) {
			opt = document.createElement("option");
			opt.text = 'All';
			opt.value = '0';
			if (jsBrowserType == 'IE7' || jsBrowserType == 'IE6') {
				try {
					$(selbox).append(opt);
					$(opt).text(txt);
				}
				catch (err) {
					selbox.options.add(opt);
				}
			}
			else {
				if (jsBrowserType == 'IE8' || jsBrowserType == 'IE8' || jsBrowserType == 'IE8' || jsBrowserType == 'IE8' || jsBrowserType == 'InternetExplorer11') {
					selbox.add(opt);
				}
				else {
					selbox.options.add(opt, null);
				}
			}
		}
		if (typ === 2) {
			// nothing yet
		}

		// add all items on list
		for (i = 0; i < ListItems.length; i++) {
			txt = ListItems[i];
			val = ListItems[i];
			opt = document.createElement("option");
			opt.text = txt;
			opt.value = val;

			if (jsBrowserType == 'IE7' || jsBrowserType == 'IE6') {
				try {
					$(selbox).append(opt);
					$(opt).text(txt);
				}
				catch (err) {
					selbox.options.add(opt);
				}
			}
			else {
				if (jsBrowserType == 'IE8' || jsBrowserType == 'IE8' || jsBrowserType == 'IE8' || jsBrowserType == 'IE8' || jsBrowserType == 'InternetExplorer11') {
					selbox.add(opt);
				}
				else {
					selbox.options.add(opt, null);
				}
			}
		}
		if (sID !== undefined && sID !== null) {
			if (sID.length > 0) {
				selbox.value = sID;
			}
		}
	}
}

// updated: 11/25/2014 by S. Meeds
function EmptyDropDownListGu(lstname) {
	$('#' + lstname).empty();
}

function getSelectMultipleItemsGu(obj) {
	return $('#list :selected').each(function () {
		obj.push($(this).text());
	});
}

function getDDLSelectedTextGu(objname) {
	return $('#' + objname + ' option:selected').text();
}

function getDDLSelectedValGu(objname) {
	return $(objname).val();
}

function getSelectedTextByIndexGu(objname, idx) {
	$("#' + objname + '_option_selected")[idx].textContent;
}

function setDDLSelectedByTextGu(objname, objpointer, txt) {
	var dd;
	if (objname.length > 0) {
		dd = document.getElementById(objname);
	}
	else {
		dd = objpointer;
	}
	for (var i = 0; i < dd.options.length; i++) {
		if (dd.options[i].text === txt) {
			dd.selectedIndex = i;
			break;
		}
	}
}

// ************************************************************************************
// Find if array
// Last updated: 10/10/2014
function isObjArrayGu(Obj) {
	return Obj && !(Obj.propertyIsEnumerable('length')) && typeof Obj === 'object' && typeof Obj.length === 'number';
}

// ************************************************************************************
// True if object is array false if not
/*USAGE: isArrayGu(document.form.element) RETURNS false if array or true if collection */
function isArrayGu(input) {
	return typeof (input) == 'object' && (input instanceof Array);
}

function PrintDivGu(objname) {
	var contents = document.getElementById(objname).innerHTML;
	var frame1 = document.createElement('iframe');
	frame1.name = "frame1";
	frame1.style.position = "absolute";
	frame1.style.top = "-1000000px";
	document.body.appendChild(frame1);
	var frameDoc = frame1.contentWindow ? frame1.contentWindow : frame1.contentDocument.document ? frame1.contentDocument.document : frame1.contentDocument;
	frameDoc.document.open();
	frameDoc.document.write('<html><head><title>DIV Contents</title>');
	frameDoc.document.write('</head><body>');
	frameDoc.document.write(contents);
	frameDoc.document.write('</body></html>');
	frameDoc.document.close();
	setTimeout(function () {
		window.frames["frame1"].focus();
		window.frames["frame1"].print();
		document.body.removeChild(frame1);
	}, 500);
	return false;
}

function createObjIDGu(pref, rw, col) {
	var sRw = rw.toString();
	var sCol = col.toString();
	if (sRw.length === 2) { sRw = '0' + sRw; }
	if (sRw.length === 1) { sRw = '00' + sRw; }
	if (sCol.length === 2) { sCol = '0' + sCol; }
	if (sCol.length === 1) { sCol = '00' + sCol; }
	return pref + sRw + sCol;
}

function createNewCellGu(id, ht, wdth, content, bkColor, frColor, brdr, hAlign, vAlign, padl, padr, padt, padb, fontSz, IsBold, ovrflw, RdOnly, dsabld, IsVisible, colspn, rwspn) {
	var c = document.createElement("td");
	c.id = id;
	c.style.height = ht;
	if (wdth !== undefined && wdth !== null) {
		if (wdth !== '' && wdth !== '0') {
			c.style.width = wdth;
		}
	}
	c.style.paddingRight = padr;
	c.style.paddingLeft = padl;
	c.style.paddingTop = padt;
	if (RdOnly === true) {
		c.unselectable = 'on';
	}
	if (fontSz !== undefined && fontSz !== null) {
		if (fontSz.length > 0) {
			c.style.fontSize = fontSz;
		}
	}
	if (IsBold === true) {
		c.style.fontWeight = 'bold';
	}
	c.style.paddingBottom = padb;
	c.style.textAlign = hAlign;
	c.style.verticalAlign = vAlign;
	c.style.backgroundColor = bkColor;
	c.style.color = frColor;
	c.style.border = brdr;
	c.style.overflow = ovrflw;
	if (dsabld === true) {
		c.style.disable = true;
	}
	if (IsVisible !== undefined && IsVisible !== null) {
		if (IsVisible.length > 0) {
			c.style.visibility = IsVisible;
		}
	}
	if (colspn.length > 0) { c.colSpan = colspn; }
	if (rwspn.length > 0) { c.rowSpan = rwspn;}
	//alert('Cell ready');
	c.innerHTML = content;
	return c;
}

function createNewCellExpGu(id, ht, wdth, content, bkColor, frColor, brdrL, brdrR, brdrT, brdrB, hAlign, vAlign, padl, padr, padt, padb, fontSz, IsBold, ovrflw, RdOnly, dsabld, IsVisible, colspn, rwspn, lnht) {
	var c = document.createElement("td");
	c.id = id;
	c.style.height = ht;
	if (wdth !== undefined && wdth !== null) {
		if (wdth !== '' && wdth !== '0') {
			c.style.width = wdth;
		}
	}
	c.style.paddingRight = padr;
	c.style.paddingLeft = padl;
	c.style.paddingTop = padt;
	c.style.paddingBottom = padb;
	if (RdOnly === true) {
		c.unselectable = 'on';
	}
	if (fontSz !== undefined && fontSz !== null) {
		if (fontSz.length > 0) {
			c.style.fontSize = fontSz;
		}
	}
	if (IsBold === true) {
		c.style.fontWeight = 'bold';
	}
	c.style.paddingBottom = padb;
	c.style.textAlign = hAlign;
	c.style.verticalAlign = vAlign;
	c.style.backgroundColor = bkColor;
	c.style.color = frColor;
	if (lnht.length > 0) {
		c.style.lineHeight = lnht;
	}
	if (brdrL.length > 0) { c.style.borderLeft = brdrL; }
	if (brdrR.length > 0) { c.style.borderRight = brdrR; }
	if (brdrT.length > 0) { c.style.borderTop = brdrT; }
	if (brdrB.length > 0) { c.style.borderBottom = brdrB; }
	c.style.overflow = ovrflw;
	if (dsabld === true) {
		c.style.disable = true;
	}
	if (IsVisible !== undefined && IsVisible !== null) {
		if (IsVisible.length > 0) {
			c.style.visibility = IsVisible;
		}
	}
	if (colspn.length > 0) { c.colSpan = colspn; }
	if (rwspn.length > 0) { c.rowSpan = rwspn; }
	//alert('Cell ready');
	c.innerHTML = content;
	return c;
}

// ************************************************************************************
// Clears data list (select object) - if keepfirst = 1, it will keep first item in list
// Last updated: 12/2/2014
function ClearDDLOptionsGu(objname, keepfirst) {
	// objname is not a pointer name
	if (keepfirst === 1) {
		$('#' + objname).find('option:not(:first)').remove();
	}
	else {
		document.getElementById(objname).options.length = 0;
	}
}

function appendDDLOptionGu(obj, val, text) {
	var opt = document.createElement("option");
	opt.text = text;
	opt.value = val;
	//alert(t + '/' + v);
	if (jsBrowserType == 'IE7' || jsBrowserType == 'IE6') {
		try {
			$(obj).append(opt);
			$(opt).text(t);
		}
		catch (err) {
			obj.options.add(opt);
		}
	}
	else {
		if (jsBrowserType == 'IE8' || jsBrowserType == 'IE8' || jsBrowserType == 'IE8' || jsBrowserType == 'IE8' || jsBrowserType == 'InternetExplorer11') {
			obj.add(opt);
		}
		else {
			obj.options.add(opt, null);
		}
	}
	return false;
}

function RemoveDDLOptionItemGu(objname, val) {
	document.getElementById(objname).find('option[value=' + val).remove();
}

// updated: 11/25/2014 by S. Meeds
function removeOptionsGu(selbox) {
	var i;
	for (i = selbox.options.length - 1; i >= 0; i--) {
		selbox.remove(i);
	}
	//$("#droplist").empty();
}

function getWindowDimensionGu(typ) {
	if (typ === 0) {
		// window width
		if (window.innerWidth) {
			// All browsers except IE
			return window.innerWidth;
		}
		else if (document.documentElement && document.documentElement.clientWidth) {
			// IE6 with DOCTYPE
			return document.documentElement.clientWidth;
		}
		else if (document.body.clientWidth) {
			// IE4, IE5, IE6 without DOCTYPE
			return document.body.clientWidth;
		}
	}
	else {
		// window height
		if (window.innerWidth) {
			// All browsers except IE
			return window.innerHeight;
		}
		else if (document.documentElement && document.documentElement.clientWidth) {
			// IE6 with DOCTYPE
			return document.documentElement.clientHeight;
		}
		else if (document.body.clientWidth) {
			// IE4, IE5, IE6 without DOCTYPE
			return document.body.clientHeight;
		}
	}
}

function getDialogMarginPcntGu(typ, objname) {
	var pgdim = 0;
	var bxdim = 0;
	if (typ === 0) {
		pgdim = parseFloat(getWindowDimensionGu(0));
		//alert('w:' + wwidth);
		bxdim = parseFloat(document.getElementById(objname).style.width);
	}
	else {
		pgdim = parseFloat(getWindowDimensionGu(1));
		//alert('h:' + wwidth);
		bxdim = parseFloat(document.getElementById(objname).style.height);
	}
	return ((100 - (bxdim / pgdim * 100)) / 2).toString() + '%';
}

function setSessionValGu(valName, val) {
	var resp = '';
	val = val.replace(/\'/gi, '`');
	val = val.replace(/\"/gi, '`');
	var url = "../Shared/TimeLiveController.asmx/SetSessionValueFromAJAX";
	var MyData = "{'SessionValName':'" + valName + "','val':'" + val + "'}";
	//alert(MyData);
	getJSONReturnStatus(url, MyData, function (response)
	{ MyResponse = response; });
	//alert('Done!');
	return false;
}

function createKeyValMapGu(MyJSONList, valCol, txtCol, NbrType) {
	var mp = new Map();
	for (var row = 0; row < MyJSONList.length; row++) {
		switch (NbrType) {
			case 0: //all text
				mp.set(MyJSONList[row][valCol].toString(), MyJSONList[row][txtCol].toString());
				break;
			case 1: // val is int
				mp.set(parseInt(MyJSONList[row][valCol], 10), MyJSONList[row][txtCol].toString());
				break;
			case 2: // val is float
				mp.set(parseFloat(MyJSONList[row][valCol]), MyJSONList[row][txtCol].toString());
				break;
			default:
				mp.set(MyJSONList[row][valCol].toString(), MyJSONList[row][txtCol].toString());
				break;
		}
	}
	return mp;
}
//m.forEach(function (value, key, mapObj) {
//	document.write(item.toString() + "<br />");
//});

function createValueSetGu(MyJSONList, tCol, NbrType) {
	var st = new Set();
	for (var row = 0; row < MyJSONList.length; row++) {
		switch (NbrType) {
			case 0: //all text
				st.add(MyJSONList[row][tCol].toString());
				break;
			case 1: // val is int
				st.add(parseInt(MyJSONList[row][tCol], 10));
				break;
			case 2: // val is float
				st.add(parseFloat(MyJSONList[row][tCol]));
				break;
			default:
				st.add(MyJSONList[row][tCol].toString());
				break;
		}
	}
	return st;
}

function fadeInObjectGu(objname) {
	$('#' + objname).fadeIn('slow');
}

function fadeOutObjectGu(objname) {
	$('#' + objname).fadeOut();
}

// left/top are strings in pixels with just number, no 'px' - bwdth is number and px, i.e. 'ipx'
function MoveObjectAnimatedGu(objname, sleft, stop, bwdth, spd) {
	$('#' + objname).animate({
		'left': sleft,
		'top': stop,
		'border-width': bwdth
	}, spd);
}

function IsMouseOverObject(objname) {
	var objs = document.querySelectorAll(":hover");
	for (var itm = 0; itm < objs.length; itm++) {
		alert(itm);
		if (itm === objname) {return true;}
	}
	return false;
}

function addEventHandlerGu(elem, eventType, handler) {
	if (elem.addEventListener) {
		elem.addEventListener(eventType, handler, false);
	}
	else if (elem.attachEvent) {
		elem.attachEvent('on' + eventType, handler);
	}
	return false;
}

function setDatePickerDialogGu(objname) {
	$("#" + objname).datepicker({ dateFormat: 'm/d/yy', showOtherMonths: true, showButtonPanel: true, showStatus: true });
	return false;
}

function arrayBufferToStrGu(buf) {
  return String.fromCharCode.apply(null, new Uint8Array(buf));
}

function stringToArrayBufferGu(str) {
  var buf = new ArrayBuffer(str.length * 2); // 2 bytes for each char
  var bufView = new Uint16Array(buf);
  for (var i = 0, strLen = str.length; i < strLen; i++) {
    bufView[i] = str.charCodeAt(i);
  }
  return buf;
}

function ConvertStringToArrayBufferGu2(string, callback) {
  var bb = new BlobBuilder();
  bb.append(string);
  var f = new FileReader();
  f.onload = function (e) {
    callback(e.target.result);
  }
  f.readAsArrayBuffer(bb.getBlob());
}

function ConvertArrayBufferToStringGu2(buf, callback) {
  var bb = new BlobBuilder();
  bb.append(buf);
  var f = new FileReader();
  f.onload = function (e) {
    callback(e.target.result)
  }
  f.readAsText(bb.getBlob());
}

function dataURItoBlobGu(dataURI) {
	var binary = atob(dataURI.split(',')[1]);
  var array = [];
  for (var i = 0; i < binary.length; i++) {
    array.push(binary.charCodeAt(i));
  }
  return new Blob([new Uint8Array(array)], { type: 'image/jpeg' });
}

function GetMimeTypeGu(ftype) {
  switch (ftype) {
    case "csv":
      return "text/plain";
    case "xls":
      return "application/vnd.ms-excel";
    case "xlsx":
      return "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
    case "xlsm":
      return "application/vnd.ms-excel";
    case "doc":
      return "application/msword"; //application/octet-stream";
    case "docx":
      return "application/vnd.openxmlformats-officedocument.wordprocessingml.document"; //application/octet-stream";
    case "msg":
      return "application/octet-scream"; // "application/vnd.ms-outlook"; //octet-stream";
    case "pdf":
      return "application/pdf";
    case "txt":
      return "text/plain";
    case "htm":
      return "text/html";
    case "html":
      return "text/html";
    case "xml":
      return "Application/xml";
    case "rtf":
      return "text/richtext";
    case "png":
      return "image/x-png";
    case "jpg":
      return "image/jpeg";
    case "jpeg":
      return "image/jpeg";
    case "gif":
      return "image/gif";
    case "tiff":
      return "image/tiff";
    case "tif":
      return "image/tiff";
    case "bmp":
      return "image/bmp";
    case "mpg":
      return "video/mpeg";
    case "mpeg":
      return "video/mpeg";
    case "avi":
      return "video/avi";
    case "emf":
      return "image/x-emf";
    case "wmf":
      return "image/x-wmf";
    case "ppt":
      return "application/vnd.ms-powerpoint";
    case "pps":
      return "application/vnd.ms-powerpoint";
    case "pptx":
      return "application/vnd.openxmlformats-officedocument.presentationml.presentation";
    case "ppsx":
      return "application/vnd.openxmlformats-officedocument.presentationml.slideshow";
    case "exe":
      return "application/x-msdownload";
    case "tar":
      return "application/x-compressed";
    case "zip":
      return "application/x-zip-compressed";
    case "wav":
      return "audio/wav";
    case "mp3":
      return "audio/wav";
    default:
      break;
  }
  return "application/octet-stream";
}

function GetFileContentTypeGu(mtype) {
  switch (mtype) {
    case "text/plain":
      return "T-csv";
    case "application/vnd.ms-excel":
      return "_-xls";
    case "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet":
      return "_-xlsx";
    case "application/vnd.ms-excel":
      return "_-xlsm";
    case "application/msword":
      return "T-doc"; //application/octet-stream";
    case "application/vnd.openxmlformats-officedocument.wordprocessingml.document":
      return "_-docx"; //application/octet-stream";
    case "application/octet-scream":
      return "_-msg"; // "application/vnd.ms-outlook"; //octet-stream";
    case "application/pdf":
      return "_-pdf";
    case "text/plain":
      return "T-txt";
    case "text/html":
      return "T-htm";
    case "text/html":
      return "T-html";
    case "Application/xml":
      return "T-xml";
    case "text/richtext":
      return "T-rtf";
    case "image/x-png":
      return "B-png";
    case "image/jpeg":
      return "B-jpg";
    case "image/gif":
      return "B-gif";
    case "image/tiff":
      return "B-tif";
    case "image/bmp":
      return "B-bmp";
    case "video/mpeg":
      return "B-mpg";
    case "video/avi":
      return "B-avi";
    case "image/x-emf":
      return "B-emf";
    case "image/x-wmf":
      return "B-wmf";
    case "application/vnd.ms-powerpoint":
      return "_-pps";
    case "application/vnd.openxmlformats-officedocument.presentationml.presentation":
      return "_-pptx";
    case "application/vnd.openxmlformats-officedocument.presentationml.slideshow":
      return "_-ppsx";
    case "application/x-msdownload":
      return "B-exe";
    case "application/x-compressed":
      return "B-tar";
    case "application/x-zip-compressed":
      return "B-zip";
    case "audio/wav":
      return "B-wav";
    case "audio/wav":
      return "B-mp3";
    default:
      break;
  }
  return "B-exe";
}

function base64EncodeGu(text) {
  if (/([^\u0000-\u00ff])/.test(text)) {
    throw new Error("Can't base64 encode non-ASCII characters.");
  }

  var digits = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/",
      i = 0,
      cur, prev, byteNum,
      result = [];

  while (i < text.length) {
    cur = text.charCodeAt(i);
    byteNum = i % 3;
    switch (byteNum) {
      case 0: //first byte
        result.push(digits.charAt(cur >> 2));
        break;

      case 1: //second byte
        result.push(digits.charAt((prev & 3) << 4 | (cur >> 4)));
        break;

      case 2: //third byte
        result.push(digits.charAt((prev & 0x0f) << 2 | (cur >> 6)));
        result.push(digits.charAt(cur & 0x3f));
        break;
    }

    prev = cur;
    i++;
  }

  if (byteNum == 0) {
    result.push(digits.charAt((prev & 3) << 4));
    result.push("==");
  } else if (byteNum == 1) {
    result.push(digits.charAt((prev & 0x0f) << 2));
    result.push("=");
  }

  return result.join("");
}

function base64DecodeGu(text) {
	if (!IsContentsNullUndefEmptyGu(text)) {
		text = text.replace(/\s/g, "");

		if (!(/^[a-z0-9\+\/\s]+\={0,2}$/i.test(text)) || text.length % 4 > 0) {
			throw new Error("Not a base64-encoded string.");
		}

		//local variables
		var digits = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/",
				cur, prev, digitNum,
				i = 0,
				result = [];

		text = text.replace(/=/g, "");

		while (i < text.length) {

			cur = digits.indexOf(text.charAt(i));
			digitNum = i % 4;

			switch (digitNum) {

				//case 0: first digit - do nothing, not enough info to work with

				case 1: //second digit
					result.push(String.fromCharCode(prev << 2 | cur >> 4));
					break;

				case 2: //third digit
					result.push(String.fromCharCode((prev & 0x0f) << 4 | cur >> 2));
					break;

				case 3: //fourth digit
					result.push(String.fromCharCode((prev & 3) << 6 | cur));
					break;
			}

			prev = cur;
			i++;
		}

		return result.join("");
	}
	else {
		return '';
	}
}

function b64toBlobGu(b64Data, contentType, sliceSize) {
  contentType = contentType || '';
  sliceSize = sliceSize || 512;

  var byteCharacters = atob(b64Data);
  var byteArrays = [];

  for (var offset = 0; offset < byteCharacters.length; offset += sliceSize) {
    var slice = byteCharacters.slice(offset, offset + sliceSize);

    var byteNumbers = new Array(slice.length);
    for (var i = 0; i < slice.length; i++) {
      byteNumbers[i] = slice.charCodeAt(i);
    }

    var byteArray = new Uint8Array(byteNumbers);

    byteArrays.push(byteArray);
  }

  var blob = new Blob(byteArrays, { type: contentType });
  return blob;
}

function base64toBlobGu(base64Data, contentType) {
  contentType = contentType || '';
  var sliceSize = 1024;
  var byteCharacters = atob(base64Data);
  var bytesLength = byteCharacters.length;
  var slicesCount = Math.ceil(bytesLength / sliceSize);
  var byteArrays = new Array(slicesCount);

  for (var sliceIndex = 0; sliceIndex < slicesCount; ++sliceIndex) {
    var begin = sliceIndex * sliceSize;
    var end = Math.min(begin + sliceSize, bytesLength);

    var bytes = new Array(end - begin);
    for (var offset = begin, i = 0 ; offset < end; ++i, ++offset) {
      bytes[i] = byteCharacters[offset].charCodeAt(0);
    }
    byteArrays[sliceIndex] = new Uint8Array(bytes);
  }
  return new Blob(byteArrays, { type: contentType });
}

function getBase64ImageGu(sdatUrl) {
	if (!IsContentsNullUndefEmptyGu(text)) {
		var newdat = sdatUrl;
		if (newdat.indexOf(';base64,') > -1) {
			newdat = newdat.substr(newdat.indexOf(';base64,') + 8); //, newdat.length - 8);
		}
		return newdat;
	}
	else {
		return '';
	}
}

function convertArrayBufferToBase64Gu(buf) {
  var binary = '';
  var bytes = new Uint8Array(buf);
  var len = bytes.byteLength;
  //alert(len);
  for (var i = 0; i < len; i++) {
    binary += String.fromCharCode(bytes[i]);
  }
  //alert(binary.length);
  return window.btoa(binary);
}

function convertArrayBufferToStringGu(buf) {
  var binary = '';
  var bytes = new Uint8Array(buf);
  var len = bytes.byteLength;
  //alert(len);
  for (var i = 0; i < len; i++) {
    binary += String.fromCharCode(bytes[i]);
  }
  //alert(binary.length);
  return binary;
}

function SleepForSecondsGu(scd) {
  var milliseconds = scd * 1000;
  var start = new Date().getTime();
  for (var i = 0; i < 1e7; i++) {
    if ((new Date().getTime() - start) > milliseconds) {
      break;
    }
  }
}

function jsfTimeSleepUntilGu(timestamp) {
	// From: http://phpjs.org/functions
	// *     example 1: time_sleep_until(1233146501) // delays until the time indicated by the given timestamp is reached
	// *     returns 1: true
	while (new Date() < timestamp * 1000) { }
	return true;
}

/* STRING FUNCTIONS */

function joinGu(glue, pieces) {
	// From: http://phpjs.org/functions
	// -    depends on: implode
	// *     example 1: join(' ', ['Kevin', 'van', 'Zonneveld']); returns 1: 'Kevin van Zonneveld'
	return this.implode(glue, pieces);
}

function implodeGu(glue, pieces) {
	// From: http://phpjs.org/functions
	// *     example 1: implode(' ', ['Kevin', 'van', 'Zonneveld']); returns 1: 'Kevin van Zonneveld'
	// *     example 2: implode(' ', {first:'Kevin', last: 'van Zonneveld'}); returns 2: 'Kevin van Zonneveld'
	var i = '',
    retVal = '',
    tGlue = '';
	if (arguments.length === 1) {
		pieces = glue;
		glue = '';
	}
	if (typeof pieces === 'object') {
		if (Object.prototype.toString.call(pieces) === '[object Array]') {
			return pieces.join(glue);
		}
		for (i in pieces) {
			retVal += tGlue + pieces[i];
			tGlue = glue;
		}
		return retVal;
	}
	return pieces;
}

/* DATE FUNCTIONS */

function convertJSONtoJSArrayGu(arr) {
	var newarr = [];
	for (var prop in arr) {
		newarr.push(arr[prop]);
	}
	return newarr;
}

function SetArrayOfInputObjectsGu() {
	return $("#:input");
}

function SetArrayOfFormInputObjectsGu() {
	return $("form > *");
}

function getNewRowGu(rowID, rowNbr, lnheight) {
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

function showCurrentVarsGu(typ, showpg) {
	//alert('Fired!');
	var s = 'PageID: ' + jiPageID.toString() + '\nByID: ' + jiByID.toString() + '\n' + 'EmpID: ' + jiEmpID.toString() + '\n';
	s = s + 'BrowserType: ' + jsBrowserType + '\n';
	if (typ === 1) {
		s = s + 'Project ID: ' + jiProjectID.toString() + '\n' + 'Proj Tracking ID: ' + jiProjTrackID.toString() + '\n';
	}
	s = s + 'Page Version: ' + jsPageVers + '\n';
	s = s + 'Page Vers Date: ' + jsPageVersDate + '\n';
	if (showpg === 1) {
		if (jiPgNbrPj !== undefined && jiPgNbrPj !== null) {
			s = s + '\nDATA GRID PAGINATION:\n';
			s = s + 'Pagination Size: ' + jiPgSizePj.toString() + '\n';
			s = s + 'Page Nbr: ' + jiPgNbrPj.toString() + '\n' + 'NbrPages:' + jiNbrPagesPj.toString() + '\n';
		}
		if (jiPgNbrPj2 !== undefined && jiPgNbrPj2 !== null) {
			s = s + 'Pagination Size 2: ' + jiPgSizePj2.toString() + '\n';
			s = s + 'Page Nbr 2: ' + jiPgNbrPj2.toString() + '\n' + 'NbrPages 2:' + jiNbrPagesPj2.toString() + '\n';
		}
		if (jiPgNbrPj3 !== undefined && jiPgNbrPj3 !== null) {
			s = s + 'Pagination Size 3: ' + jiPgSizePj3.toString() + '\n';
			s = s + 'Page Nbr 3: ' + jiPgNbrPj3.toString() + '\n' + 'NbrPages 3:' + jiNbrPagesPj3.toString() + '\n';
		}
	}
	alert(s);
	return false;
}

// updated: 11/25/2014 by S. Meeds
function PrintDivGu(objname) {
	var contents = document.getElementById(objname).innerHTML;
	var frame1 = document.createElement('iframe');
	frame1.name = "frame1";
	frame1.style.position = "absolute";
	frame1.style.top = "-1000000px";
	document.body.appendChild(frame1);
	var frameDoc = frame1.contentWindow ? frame1.contentWindow : frame1.contentDocument.document ? frame1.contentDocument.document : frame1.contentDocument;
	frameDoc.document.open();
	frameDoc.document.write('<html><head><title>DIV Contents</title>');
	frameDoc.document.write('</head><body>');
	frameDoc.document.write(contents);
	frameDoc.document.write('</body></html>');
	frameDoc.document.close();
	setTimeout(function () {
		window.frames["frame1"].focus();
		window.frames["frame1"].print();
		document.body.removeChild(frame1);
	}, 500);
	return false;
}

function StripNbrDisplayCharsGu(sval) {
	var specialChars = "#$^&%*+=[]\/{}|:<>?,";
	for (var i = 0; i < specialChars.length; i++) {
		sval = sval.replace(new RegExp("\\" + specialChars[i], 'gi'), '');
	}
}

function addEventHandlerGu(elem, eventType, handler) {
	if (elem.addEventListener) {
		elem.addEventListener(eventType, handler, false);
	}
	else if (elem.attachEvent) {
		elem.attachEvent('on' + eventType, handler);
	}
	return false;
}

function setDatePickerDialogGu(objname) {
	$("#" + objname).datepicker({ dateFormat: 'm/d/yy', showOtherMonths: true, showButtonPanel: true, showStatus: true });
	return false;
}

function ItemInJSONListGu(MyJSONList, colname) {
	var keys = Object.keys(MyJSONList);
	//alert(keys.length);
	if (!IsContentsNullUndefEmptyGu(MyJSONList) && !IsContentsNullUndefEmptyGu(colname)) {
		if (keys.indexOf(colname) > -1) {
			return true;
		}
	}
	return false;
}

function ItemInArrayGu(Arr, colname) {
	return $.inArray(colname, Arr);
}

function FindFirstMatchValueInJSONArrayGu(key, value, haystack) {
	for (var i = 0; i < haystack.length; i++) {
		if (haystack[i][key] === value) {
			return i;
		}
	}
	return -1;
}

function findRadioSelectionGu(nm) {
	var val = '';
	var items = 'document.Form1.' + nm;
	for (i = 0; i < items.length; i++) {
		if (items[i].checked == true) {
			val = items[i].value;
		}
	}

	return val;
}

function ChangeDDLItemGu(objp, oldval, newval, newtext, typ) {
	var opts = objp.options;
	for (var opt, j = 0; opt = opts[j]; j++) {
		if (opt.value == oldval) {
			opt.value = newval;
			opt.text = newtext;
			if (typ === 1) { objp.selectedIndex = j; }
			break;
		}
	}
	return false;
}

function CopyToClipboardGu(containerid) {
	//alert('fired = ' + containerid);
	//document.querySelector("#" + containerid).select();
	//document.execCommand('copy');
	if (document.selection) {
		var range = document.body.createTextRange();
		range.moveToElementText(document.getElementById(containerid));
		range.select().createTextRange();
		document.execCommand("Copy");
	} else if (window.getSelection) {
		var range = document.createRange();
		range.selectNode(document.getElementById(containerid));
		window.getSelection().addRange(range);
		document.execCommand("Copy");
	}
	//else {
	//	alert('Nice try');
	//}
	//alert("text copied")
	return false;
}

function copyTextToClipboard(containerid) {
	var text = document.getElementById(containerid).innerHTML;
	var textArea = document.createElement("textarea");
	textArea.id = 'newtextareacopy';
	//alert('creating text area - ' + text);
	textArea.style.position = 'fixed';
	textArea.style.top = 0;
	textArea.style.left = 0;
	textArea.style.width = '2em';
	textArea.style.height = '2em';
	textArea.style.padding = 0;
	textArea.style.border = 'none';
	textArea.style.outline = 'none';
	textArea.style.boxShadow = 'none';
	textArea.style.background = 'transparent';
	textArea.value = text;
	document.body.appendChild(textArea);
	//alert(textArea.value);
	textArea.select();
	//$('#newtextareacopy').select();
	if (textArea.selectionStart == textArea.selectionEnd) { alert("Nothing is selected!"); }
	//alert(textArea.value.substring(textArea.selectionStart, textArea.selectionEnd));
	try {
		var successful = document.execCommand("copy");
		var msg = successful ? 'successful' : 'unsuccessful';
		alert('done');
		//console.log('Copying text command was ' + msg);
	} catch (err) {
		//console.log('Oops, unable to copy');
		alert(err.message);
	}
	//alert('removing text area');
	document.body.removeChild(textArea);
	return false;
}

function FindItemInDDLGu(ddlpointer, val, typ, doselect) {
	var idx = 999;
	for (var i = 0; i = ddlpointer.length; i++) {
		if (options[i].value===val && typ === 0) {
			idx = i;
			if (doselect === 1) {
				options[i].selected = true;
			}
			break;
		}
		if (options[i].text === val && typ === 1) {
			idx = i;
			if (doselect === 1) {
				options[i].selected = true;
			}
			break;
		}
	}
	return idx;
}

function IdentifyArrayIndexGu(jsonlist, colname, val) {
	var idx = 9999;
	for (var i = 0; i < jsonlist.length; i++) {
		var list_i = jsonlist[i];
		if (list_i[colname] == val) {
			idx = i;
			break;
		}
	}
	return idx+1;
}

function AppendItemToULListGu(ulpointer, ulid, txt, doall) {
	if (doall === 1 || txt !== '') {
		var li = document.createElement("li");
		li.setAttribute("id", ulid);
		li.innerHTML = txt;
		//li.appendChild(document.createTextNode(txt));
		ulpointer.appendChild(li);
	}
	return false;
}

function UnderlineBoldSelectedTextGu(txt, typ) {
	// typ: 0-nothing, 1-bold only, 2-underline only, 3-both
	var begintxt = '';
	var endtxt = '';
	switch (typ) {
		case 1:
			begintxt = '<b>';
			endtxt = '</b>';
			break;
		case 2:
			begintxt = '<u>';
			endtxt = '</u>';
			break;
		case 3:
			begintxt = '<b><u>';
			endtxt = '</u></b>';
			break;
		case 4:
			begintxt = '<i>';
			endtxt = '</i>';
			break;
		case 5:
			begintxt = '<b><i>';
			endtxt = '</i></b>';
			break;
		default:
			begintxt = '';
			endtxt = '';
			break;
	}
	return begintxt + txt + endtxt;
}

function GetSelectionInsideTextareaGu(objpointer) {

	var selectedText = '';
	// IE version
	if (document.selection != undefined) {
		objpointer.focus();
		var sel = document.selection.createRange();
		selectedText = sel.text;
	}
		// Mozilla version
	else if (objpointer.selectionStart != undefined) {
		var startPos = objpointer.selectionStart;
		var endPos = objpointer.selectionEnd;
		selectedText = objpointer.value.substring(startPos, endPos)
	}
	//alert("You selected: " + selectedText);
	return selectedText;
}


function InsertRowIntoTableGu(tblname, idx, rowobj) {
	// idx is zero-based
	//alert(tblname + '/' + idx + '/' + rowobj);
	$('#' + tblname + ' > tbody > tr').eq(idx).after(rowobj);
	return false;
}

function RemoveRowFromTableGu(tblname, idx) {
	$("#" + tblname + " tr:eq(" + idx.toString() + ")").remove();
	return false;
}