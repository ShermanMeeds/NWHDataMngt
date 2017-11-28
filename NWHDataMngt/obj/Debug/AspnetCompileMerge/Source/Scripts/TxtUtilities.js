/* TxtUtilities.js
-- Code checked 6/26/2017
Contents:
  IsContentsNullUndefinedTx(val)
  IsContentsNullUndefEmptyTx(txt, typ)
  getNbrStringFormattedTx(nbr, prec, sepchar, decchar, prefix, iShow0)
  getIntNbrPaddedTx(nbr, padchar, lgth, paddir)
  getIntNbrPaddedTx2(nbr, padchar, lgth, paddir)
  CleanForRequestSubmitTx(str, spc, rpchr, nodash, nofs, nobs, noprn)
  fixNumericStringTx(ns, padchar, minlength, prec)
  getSpecFormattedStringTx(sval, nval, dval, FormatID, lgth, ht, idstr, FColor)
  getSpecialFormatStringTx(val, sFormat, fig1, fig2, fig3)
  TrimTx(val)
  RTrimTx(val)
  LTrimTx(val)
  changeCaseTx(val, typ)
  formatMoneyStringTx(nbr, prefix, UseSep, SepChar)
  jsLeftTx(val, nbr)
  jsRightTx(val, nbr)
  jsMidTx(strMid, intBeg, intEnd)
	PrepareJSONStringValueTx(val, typ)
  MakeSecureHTMLCodeMinTx(val)
	CleanTextToSecureTx(val)
  CleanDateValTx(val)
  CleanTimeValTx(val)
  CleanNbrValTx(val)
  StripOutCurrencySymbolTx(str)
  CleanEmailValTx(val)
	CleanTextMin2Tx(val, withqt)
  CleanTextMinimalTx(val, withqt)
  peekTx(str, loc)
  StripInsecureTextCharsTx(val)
  StripSingleQuotesTx(val)
	EncodeSingleQuotesTx(val)
  StripHTMLTagsTx(str, arguments)
  StripURLTx(val)
  PrepareJSONForHTMLTx(val, typ)
  PrepareHTMLForViewTx(val, typ)
  getChrTx(iChr)
  StringifyTx(txt)
  compareTwoStringsSmartTx(s1, s2, NoCase)
  compareTwoStringsWithResultsTx(s1, s2, tlist, objid)
  compareTwoDivsWithResultsTx(divname1, divname2, tlist, objid)
  compareTwoDocumentsWithResultsTx(filenm1, filenm2, tlist, objid)
	ParseStringIntoLinesTx(s)
	ReplaceTabsWithUprightsTx(s)
	getArrayFromLinedTabbedStrTx(s, maxCols)
	getArrayFromLinedCommaStrTx(s, maxCols)
	IsOneStringInAnotherTx(findtxt, fulltxt)
*/
var jsTUfVersion = '1.1.7';
var jsTUfVersDate = '10/5/2017';

// First, checks if it isn't implemented yet.
//if (!String.prototype.format) {
//	String.prototype.format = function () {
//		var args = arguments;
//		return this.replace(/{(\d+)}/g, function (match, number) {
//			return typeof args[number] != 'undefined'
//        ? args[number]
//        : match
//			;
//		});
//	};
//}
// "{0} is dead, but {1} is alive! {0} {2}".format("ASP", "ASP.NET")

if (!String.format) {
	String.format = function (format) {
		var args = Array.prototype.slice.call(arguments, 1);
		return format.replace(/{(\d+)}/g, function (match, number) {
			return typeof args[number] != 'undefined'
        ? args[number]
        : match
			;
		});
	};
}
// String.format('{0} is dead, but {1} is alive! {0} {2}', 'ASP', 'ASP.NET');

function IsContentsNullUndefinedTx(val) {
	if (val === undefined || val === null) {
		return true;
	}
	else {
		return false;
	}
}

function IsContentsNullUndefEmptyTx(txt, typ) {
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

// iShow0: 0-Suppress zeros (default), 1-show if zero , 2-show empty as zero
function getNbrStringFormattedTx(nbr, prec, sepchar, decchar, prefix, iShow0) {
	if (IsContentsNullUndefEmptyGu(nbr.toString())) {	nbr = '0';}
	if (nbr) {
		var nVal = parseFloat(nbr); // ensure a float
		var sNbr = nVal.toFixed(prec); // get string of that precision
		if (sNbr.length === 0 && iShow0 === 2) { sNbr = '0'; }
		if (sNbr === '0' && iShow0 === 1) { sNbr = '0'; }
		if (prec === undefined || prec === null) { prec = 0; }
		if (sepchar === undefined || sepchar === null) { sepchar = ''; }
		if (prefix === undefined || prefix === null) { prefix = ''; }
		if (decchar === undefined || decchar === null) { decchar = '.'; }
		if (decchar === '') { decchar = '.'; }
		//alert(nVal);
		var specprefix = '';
		if (sNbr.indexOf('-') > -1) {
			specprefix = '-';
			sNbr = sNbr.replace('-', '');
		}
		if (nbr !== 0) {
			//alert(sNbr);
			// make return format
			if (decchar !== '.') { snbr = sNbr.replace(".", decchar); }
			if (sepchar !== '') {
				var ln = sNbr.length;
				var loc = sNbr.indexOf('.');
				if (loc > 3) {
					sNbr = sNbr.substr(0, loc - 3) + sepchar + sNbr.substr(loc - 3, ln - (loc - 3));
				}
			}
			if (sNbr === '') {sNbr = '0'; }
			if (parseFloat(sNbr) === 0 && iShow0 === 0) {
				return '';
			}
			else {
				return prefix + specprefix + sNbr;
			}
		}
		else {
			if (iShow0 === 2) { return prefix + specprefix + sNbr; }
			return '';
		}
	}
	else {
		var zero = '';
		if (iShow0 === 2) { zero = '0'; }
		return zero;
	}
}

function getPaddedStringValTx(val, len, sChr, side) {
  var pstr = '';
  if (val !== undefined && val !== null) {
    pstr = val;
    var ln = pstr.length;
    if (ln > len) {
      // truncate item
      pstr = pstr.substr(0, len);
    }
    else {
      if (ln < len) {
        // pad item
        for (var lval = ln; lval < len; lval++) {
          if (side === 'L') {
            pstr = sChr + pstr;
          }
          else {
            pstr = pstr + sChr;
          }
        }
      }
    }
  }
  return pstr;
}

function getIntNbrPaddedTx(nbr, padchar, lgth, paddir) {
  //alert('fired!');
  if (padchar === undefined || padchar === null) { padchar = ' '; }
  if (paddir === undefined || paddir === null) { paddir = 'left'; }
  var npaddir = paddir.toUpperCase();
  if (npaddir !== 'LEFT' || npaddir !== 'RIGHT') { paddir = 'LEFT'; }
  if (nbr === undefined || nbr === null) { nbr = 0; }
  var newNbr = parseInt(nbr, 10); // establish integer value
  var sNbr = newNbr.toString();
  //alert(sNbr);
  if (lgth === undefined || lgth === null) { sNbr.length; }
  if (sNbr.length < lgth) {
    if (npaddir === 'LEFT') {
      sNbr = Array(lgth - sNbr.length + 1).join(padchar) + sNbr;
    }
    else {
      sNbr = sNbr + Array(lgth - sNbr.length + 1).join(padchar);
    }
  }
  return sNbr;
}

function getIntNbrPaddedTx2(nbr, padchar, lgth, paddir) {
  //alert('fired!');
  if (nbr === undefined || nbr === null) { nbr = 0; }
  if (padchar === undefined || padchar === null) { padchar = ' '; }
  if (lgth === undefined || lgth === null) { lgth = 0; }
  var newNbr = parseInt(nbr, 10); // establish integer value
  var sNbr = newNbr.toString();
  //alert(sNbr + '/' + lgth.toString());
  while (sNbr.length < lgth) {
    //alert('checking');
    if (paddir.toUpperCase() === 'LEFT') {
      //alert('Left');
      sNbr = padchar + sNbr;
    }
    else {
      //alert('Right');
      sNbr = sNbr + padchar;
    }
  }
  return sNbr;
}

function CleanForRequestSubmitTx(str, spc, rpchr, nodash, nofs, nobs, noprn) {
	// slashes, dashes, *, &, !, ?, and % not allowed - no leading/trailing spaces

	// take out leading/trailing spaces
	var newval = str.replace(/^\s+|\s+$/g, '');
	// remove spaces if necessary
	if (spc === 1) {
		newval = newval.replace(/\s/g, '');
	}
	if (spc === 2) {
		newval = newval.replace(/\s/g, '%20');
	}
	if (spc === 3) {
		newval = newval.replace(/\s/g, '_');
	}
	// remove inappropriate characters
	newval = newval.replace(/\!/g, '');
	newval = newval.replace(/\$/g, '');
	newval = newval.replace(/\*/g, '');
	newval = newval.replace(/\"/g, '`');
	newval = newval.replace(/\'/g, '`');

	// replace inappropriate characters
	newval = newval.replace(/\%/g, '');
	newval = newval.replace(/\#/g, 'No');
	newval = newval.replace(/\&/g, 'and');
	if (nofs === 1) {
		newval = newval.replace(/\//g, rpchr);
	}
	if (nobs === 1) {
		newval = newval.replace(/\\/g, rpchr);
	}
	if (noprn === 1) {
		newval = newval.replace(/\(/g, '[');
	}
	if (noprn === 1) {
		newval = newval.replace(/\)/g, ']');
	}
	if (nodash === 1) {
		newval = newval.replace(/\-/g, rpchr);
	}
	return newval;
}

function fixNumericStringTx(ns, padchar, minlength, prec) {
	if (ns === undefined || ns === null) {ns = 0;}
	var n1 = 0;
	if (prec === 0 ) {ns = Math.round(ns); }
	var sn = ns.toString();
	sn = sn + '';
	var loc = sn.indexOf('.');
	padchar = padchar || '0';

	// check and adjust for precision
	if (prec > 0) {
		if (sn.indexOf('.') < 0) {sn = sn + '.0'; }
		loc = sn.indexOf('.');
		n1 = sn.length - loc;
		while (n1 < prec) {
			sn = sn + '0';
			n1++;
		}
	}

	// check and adjust for total length
	if (minlength > 0) {
		while (sn.length < minlength) {
			sn = padchar + sn;
		}
	}
	return sn;	
}

function TrimTx(val) {
	return val.replace(/^\s+|\s+$/g,"");
}

function RTrimTx(val) {
	return val.replace(/\s+$/, "");
}

function LTrimTx(val) {
	return val.replace(/^\s+/, "");
}

function changeCaseTx(val, typ) {
	var t = '';
	var tright = '';
	if (val === undefined || val === null) { val = ''; }
	switch (typ) {
		case 0: // upper case
			return val.toUpperCase();
			break;
		case 1: // lower case
			return val.toLowerCase();
			break;
		case 2: // title case
			if (val.length > 0) {
				if (val.indefOf(' ') > 0) {
					var s = val.split(' ');
					var md = createArrayGu(s.length);
					for (var l = 0; l < s.length; l++) {
						t = '';
						tright = '';
						if (s[l].length > 0) {
							t = s[l].substr(0, 1).toUpperCase();
							if (s[l].length > 1) { tright = s[l].substr(1, s[l].length - 1); }
							tright = tright.toLowerCase();
						}
						md[l] = t + tright;
					}
					return md.join();
				}
				else {
					t = val.substr(0, 1).toUpperCase();
					tright = '';
					if (val.length > 1) { tright = val.substr(1, val.length - 1); }
					tright = tright.toLowerCase();
					return t + tright;
				}
			}
			break;
		default:
			break;
	}
	return val;
}

// return value formatted as a string in way indicated - dates return MM/DD/YYYY format
function getSpecFormattedStringTx(sval, nval, dval, FormatID, lgth, ht, idstr, FColor) {
	var newval = '';
	var newnbr = 0;
	var hr = '';
	var min = '';
	var sec = '';
	var msec = '';
	// if string number was submitted, set number from it
	if (FormatID === 5 || FormatID === 6 || FormatID === 7 || FormatID === 8 || FormatID === 15 || FormatID === 18 || FormatID === 19 || FormatID === 20 || FormatID === 21 || FormatID === 22) {
		if (sval !== undefined && sval !== null && (nval === undefined || nval === null)) {
			if (sval.length > 0) {
				nval = parseFloat(sval);
			}
		}
	}
	// change boolean string values to number
	if (FormatID > 8 && FormatID < 14) {
		if (sval !== undefined && sval !== null && (nval === undefined || nval === null)) {
			if (sval.length > 0) {
				nval = 0;
				if (sval.toLowerCase() === 'yes' || sval.toLowerCase() === 'true' || sval === '1') {
					nval = 1;
				}
			}
		}
	}
	// establish string format
	switch (FormatID) {
		case 0: // do nothing - normal
			if (sval.length > 0) {
				newval = sval;
			}
			else {
				if (nval !== undefined && nval !== null) {
					newval = sval;
				}
			}
			break;
		case 1: // Short Date
			if (dval !== undefined && dval !== null) {
				newval = (dval.getMonth() + 1).toString() + '/' + dval.getDate().toString() + '/' + dval.getFullYear();
			}
			break;
		case 2: // Long Date
			if (dval !== undefined && dval !== null) {
				hr = dval.getHours().toString();
				if (hr.length === 1) { hr = '0' + hr; }
				min = dval.getMinutes().toString();
				if (min.length === 1) { min = '0' + min; }
				sec = dval.getSeconds().toString();
				if (sec.length === 1) { sec = '0' + sec; }
				newval = (dval.getMonth() + 1).toString() + '/' + dval.getDate().toString() + '/' + dval.getFullYear() + ' ' + hr + ':' + min + ':' + sec;
			}
			break;
		case 3: // Short Time
			if (dval !== undefined && dval !== null) {
				hr = dval.getHours().toString();
				if (hr.length === 1) { hr = '0' + hr; }
				min = dval.getMinutes().toString();
				if (min.length === 1) { min = '0' + min; }
				sec = dval.getSeconds().toString();
				if (sec.length === 1) { sec = '0' + sec; }
				newval = hr + ':' + min + ':' + sec;
			}
			break;
		case 4: // Long Time
			if (dval !== undefined && dval !== null) {
				hr = dval.getHours().toString();
				if (hr.length === 1) { hr = '0' + hr; }
				min = dval.getMinutes().toString();
				if (min.length === 1) { min = '0' + min; }
				sec = dval.getSeconds().toString();
				if (sec.length === 1) { sec = '0' + sec; }
				msec = dval.getMilliseconds().toString();
				if (msec.length === 2) { sec = '0' + msec; }
				if (msec.length === 1) { sec = '00' + msec; }
				newval = hr + ':' + min + ':' + sec + ':' + msec;
			}
			break;
		case 5: // Currency with 2 decimals
			if (nval !== undefined && nval !== null) {
				newnbr = RoundFloatNbrNf(nval, 2);
				newval = '$' + newnbr.toString();
			}
			break;
		case 6: // Currency with no decimals (decimals dropped)(
			if (nval !== undefined && nval !== null) {
				newnbr = parseInt(nval, 10);
				newval = '$' + newnbr.toString();
			}
			break;
		case 7: // Uros (currency with 2 decimals and Uro character &#8364; or &euro;
			if (nval !== undefined && nval !== null) {
				newnbr = parseFloat(nval);
				newval = newnbr.toString();
			}
			break;
		case 8: // Integer with extra dropped
			if (nval !== undefined && nval !== null) {
				newnbr = parseInt(nval, 10);
				newval = newnbr.toString();
			}
			break;
		case 9: // boolean yes-no
			if (nval !== undefined && nval !== null) {
				if (nval === 1) {
					newval = 'Yes';
				}
				else {
					newval = 'No';
				}
			}
			break;
		case 10: // boolean true-false
			if (nval !== undefined && nval !== null) {
				if (nval === 1) {
					newval = 'True';
				}
				else {
					newval = 'False';
				}
			}
			break;
		case 11: // boolean on-off
			if (nval !== undefined && nval !== null) {
				if (nval === 1) {
					newval = 'On';
				}
				else {
					newval = 'Off';
				}
			}
			break;
		case 12: // boolean - show only YES
			if (nval !== undefined && nval !== null) {
				if (nval === 1) {
					newval = 'Yes';
				}
			}
			break;
		case 13: // boolean - show checkbox
			if (nval !== undefined && nval !== null) {
				newval = '<input type="checkbox" id="' + idstr + '" checked="';
				if (nval === 1) {
					newval = newval + 'true';
				}
				else {
					newval = newval + 'false';
				}
				newval = newval + '" />';
			}
			break;
		case 14: // general date in MMM dd, YYYY HH:MM format
			newval = dval.toString();
			break;
		case 15: // Show numbers as-is but not if 0
			if (nval !== undefined && nval !== null) {
				if (nval !== 0) {
					newval = nval.toString();
				}
			}
			break;
		case 16: // bolded
			if (sval !== undefined && sval !== null) {
				newval = '<strong>' + sval + '</strong>';
			}
			break;
		case 17: // Percent Completed Status Bar - nval must be float, about 1, lgth and ht must be set as integers
			var len1 = 0;
			var len2 = 0;
			if (nval !== undefined && nval !== null) {
				// ignore 0 values
				if (nval > 0) {
					len1 = 0;
					len2 = 0;
					if (nval < 1) {
						len1 = nval * lgth;
						len2 = 1 - nval;
					}
					else {
						if (nval === 1) {
							len1 = lgth;
						}
						else {
							len1 = lgth;
							len2 = nval - 1;
						}
					}
					len1 = len1.round();
					len2 = len2.round();
					newval = '<input type="text" text="" style="width:' + len1 + 'px;background-color:green;padding:0px;margin:0px;" />';
					if (len2 > 0) {
						if (nval < 1) {
							newval = newval + '<input type="text" text="" style="width:' + len2 + 'px;background-color:yellow;padding:0px;margin:0px;" />';
						}
						else {
							newval = newval + '<input type="text" text="" style="width:' + len1 + 'px;background-color:red;padding:0px;margin:0px;" />';
						}
					}
				}
			}
			break;
		case 18: // Float with 1 decimal
			if (nval !== undefined && nval !== null) {
				newnbr = RoundFloatNbrNf(nval, 1);
				newval = newnbr.toString();
			}
			break;
		case 19: // Float with 2 decimals
			if (nval !== undefined && nval !== null) {
				newnbr = RoundFloatNbrNf(nval, 2);
				newval = newnbr.toString();
			}
			break;
		case 20: // Float with 3 decimals
			if (nval !== undefined && nval !== null) {
				newnbr = RoundFloatNbrNf(nval, 3);
				newval = newnbr.toString();
			}
			break;
		case 21: // Float rounded to integer
			if (nval !== undefined && nval !== null) {
				newnbr = Math.round(nval);
				newval = newnbr.toString();
			}
			break;
		case 22: // Float with 4 decimals
			if (nval !== undefined && nval !== null) {
				newnbr = RoundFloatNbrNf(nval, 4);
				newval = newnbr.toString();
			}
			break;
		case 23: // Integer rounded
			if (nval !== undefined && nval !== null) {
				newnbr = Math.round(nval);
				newval = newnbr.toString();
			}
			break;
		case 24: //Bolded & Italicized
			if (sval !== undefined && sval !== null) {
				newval = '<strong>' + sval + '</strong>';
				newval = newval.italics();
			}
			break;
		default:
			break;
	}
	if (FColor !== undefined && FColor !== null) {
		if (FColor.length > 0) {
			newval = '<span style="color:' + FColor + ';">' + newval + '</span>';
		}
	}
	return newval;
}

//function inprecise_round(value, decPlaces) {
//	return Math.round(value * Math.pow(10, decPlaces)) / Math.pow(10, decPlaces);
//}

//function precise_round(value, decPlaces) {
//	var val = value * Math.pow(10, decPlaces);
//	var fraction = (Math.round((val - parseInt(val)) * 10) / 10);

//	//this line is for consistency with .NET Decimal.Round behavior
//	// -342.055 => -342.06
//	if (fraction == -0.5) fraction = -0.6;

//	val = Math.round(parseInt(val) + fraction) / Math.pow(10, decPlaces);
//	return val;
//}
function getSpecialFormatStringTx(val, sFormat, fig1, fig2, fig3) {
	// If Date, is expected to be in YYYY-MM-DD HH:MM:SS format
	var nbr = 0;
	var fig4 = 0;
	var v1 = '';
	if (val !== undefined && val !== null) {
		if (val !== '') {
			switch (sFormat) {
				case 'boldstr': //bolded
					return '<strong>' + val + '</strong>';
					break;
				case 'boldital': //bolded and italics
					return '<i><strong>' + val + '</strong></i>';
					break;
				case 'capitals':
					return val.toUpperCase();
					break;
				case 'lowercs':
					return val.toLowerCase();
					break;
				case 'sdate': //short date
					//alert('Fired! - ' + val);
					return getMyDateTimeStringDm(val, 0);
					break;
				case 'ldate': //long date
					return getMyDateTimeStringDm(val, 4);
					break;
				case 'stime': //short time
					return getMyDateTimeStringDm(val, 6);
					break;
				case 'ltime': //long time
					return getMyDateTimeStringDm(val, 6);
					break;
				case 'boolyes':
					if (val === 'True' || val === '1' || val === 'On') {
						return 'Yes';
					}
					else {
						return 'No';
					}
					break;
				case 'booltrue':
					if (val === 'True' || val === '1' || val === 'On') {
						return 'True';
					}
					else {
						return 'False';
					}
					break;
				case 'boolon':
					if (val === 'True' || val === '1' || val === 'On') {
						return 'On';
					}
					else {
						return 'Off';
					}
					break;
				case 'boolyessp':
					if (val === 'True' || val === '1' || val === 'On') {
						return 'Yes';
					}
					else {
						return '';
					}
					break;
				case 'ucurrency': //Currency with no decimals (int)
					return '$' + Math.round(parseFloat(val)).toString();
					break;
				case 'ucurrencyd': //Currency with 2 decimals
					nbr = RoundFloatNbrNf(parseFloat(val), 2);
					return formatMoneyStringTx(nbr, '$', true, ',');
					break;
				case 'int': // integer with any decimals dropped
					return Math.floor(parseFloat(val)).toString();
					break;
				case 'intmd': //integer rounded
					return Math.Round(parseFloat(val)).toString();
					break;
				case 'float1':
					return RoundFloatNbrNf(parseFloat(val), 1).toString();
					break;
				case 'float2':
					return RoundFloatNbrNf(parseFloat(val), 2).toString();
					break;
				case 'float3':
					return RoundFloatNbrNf(parseFloat(val), 3).toString();
					break;
				case 'float4':
					return RoundFloatNbrNf(parseFloat(val), 4).toString();
					break;
				case 'emptyzero':
					if (val.isNaN || val === '0') { val = ''; }
					return val;
					break;
				case 'pccompstat': //percent completed status bar
					if (fig1 === undefined || fig1 === null) { fig1 = 0;}
					if (fig2 === undefined || fig2 === null) { fig2 = 1; }
					if (fig1 === 0 || fig2 === 0 || fig3 === 0) {
						return '';
					}
					else {
						// If fig2 = 0, fig1 is assumed to be a percentage
						if (fig2 === 0) { fig2 = 1; }
						// fig 1 is item value, fig2 = 100% value (target value), fig3 = width in pixels for 100% value
						if (fig1 === fig2) {
							return '<span style="font-size:7pt;border:1px solid gray;background-color:green;height=10px;width=' + fig3.toString() + 'px;display:inline-block;">100%</span>';
						}
						else if (fig1 > fig2) {
							fig4 = (fig1-fig2) / fig2 * fig3;
							v1 = '<span style="font-size:7pt;border:1px solid gray;background-color:green;height=10px;width=' + fig3.toString() + 'px;display:inline-block;">100%</span>';
							return v1 + '<span style="font-size:7pt;border:1px solid gray;background-color:red;height=10px;width=' + fig4.toString() + 'px;display:inline-block;">' + (fig4*100).toString() + '%</span>';
						}
						else {
							fig4 = fig1 / fig2 * fig3;
							return '<span style="border:1px solid gray;background-color:green;height=10px;width=' + fig4.toString() + 'px;display:inline-block;">' + (fig4 * 100).toString() + '%</span>';
						}
					}
					break;
				case 'euros': // show in Euros with 2 decimals
					nbr = RoundFloatNbrNf(parseFloat(val), 2);
					return '&euro;' + nbr.toString();
					break;
				default:
					return val;
					break;
			}
		}
	}
	return '';
}

function formatMoneyStringTx(nbr, prefix, UseSep, SepChar) {
	if (SepChar === undefined || SepChar === null) { SepChar = ',';}
	if (SepChar === '') { SepChar = ','; }
	if (nbr.isNaN) {
		return 'NAN';
	}
	else {
		var s = nbr.toString();
		if (UseSep === true && s !== '') {
			if (s.indexOf('.') > -1) {
				var parts = x.toString().split(".");
				parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, SepChar);
				parts[1] = jsLeftTx(parts[1], 2);
				return prefix + parts.join(".");
			}
			else {
				return prefix + s.replace(/\B(?=(\d{3})+(?!\d))/g, SepChar);
			}
		}
	}
	return prefix + s;
}

function jsLeftTx(val, nbr) {
	if (val === undefined && val === null) { val = '';}
	if (nbr >= val.length) { return val;}
	if (val !== '') {
		return val.substring(0, nbr);
	}
	return val;
}

function jsRightTx(val, nbr) {
	if (val === undefined && val === null) { val = '';}
	if (nbr >= val.length) { return val; }
	if (val !== '') {
		var fig = val.length - nbr + 1;
		return val.substring(fig, nbr);
	}
	return val;
}

function jsMidTx(strMid, intBeg, intEnd) {
	if (strMid === null || strMid === '' || intBeg < 0) {
		return '';
	}
	intBeg -= 1;
	if (intEnd === null || intEnd === '') {
		return strMid.substr(intBeg);
	} else {
		return strMid.substr(intBeg, intEnd);
	}
}

function PrepareJSONStringValueTx(val, typ) {
	if (val === undefined || val === null) { val = ''; }
	val = val.replace(/\]/gi, "\\\]");
	val = val.replace(/\[/gi, "\\\[");
	val = val.replace(/\}/gi, "\\\}");
	val = val.replace(/\{/gi, "\\\{");
	val = val.replace(/&/gi, '\\\&');
	val = val.replace(/\\/gi, "\\");
	if (typ === 1) {
		val = val.replace(/\'/gi, "\\\'");
		val = val.replace(/\"/gi, '\\\"');
	}
	else {
		val = val.replace(/\'/gi, "`");
		val = val.replace(/\"/gi, '[DOUBLEQUOTE]');
	}
	return val;
}

function MakeSecureHTMLCodeMinTx(val) {
	if (val === undefined || val === null) { val = ''; }
	var specChars = "\"&'";
	for (var i = 0; i < specChars.length; i++) {
		val = val.replace(new RegExp("\\" + specChars[i], 'gi'), '');
	}
	return val;
}

function CleanTextToSecureTx(val) {
	//alert(val);
	if (val === undefined || val === null) { val = ''; }
	var specChars = "\"!@#$^&%*()+=[]\/{}|:<>?'"; //,.-
	for (var i = 0; i < specChars.length; i++) {
		val = val.replace(new RegExp("\\" + specChars[i], 'gi'), '');
	}
	//alert(val);
	return val;
}

function CleanDateValTx(dt) {
	var val = dt.toString();
	if (val === undefined || val === null) { val = ''; }
	if (val.length > 0) {
		// can have / and -, numbers only
		var specChars = "\"!@#$^&%*()+=[]\\{}|:<>?,' ";
		for (var i = 0; i < specChars.length; i++) {
			val = val.replace(new RegExp("\\" + specChars[i], 'gi'), '');
		}
	}
	return val;
}

function CleanTimeValTx(tm) {
	var val = tm.toString();
	if (val.length > 0) {
		// can have / and -, numbers only
		var specChars = "\"!@#$^&%*()+=[]\\{}|<>?,' ";
		for (var i = 0; i < specChars.length; i++) {
			val = val.replace(new RegExp("\\" + specChars[i], 'gi'), '');
		}
	}
	return val;
}

function CleanNbrValTx(nbr) {
	if (nbr === undefined || nbr === null) {
		val = '';
	}
	else {
		var val = nbr.toString();
		if (val.length > 0) {
			// can have number digits, comma, period, -
			var specChars = "\"!@#$^&%*()+=[]\/{}|:<>?' ";
			for (var i = 0; i < specChars.length; i++) {
				val = val.replace(new RegExp("\\" + specChars[i], 'gi'), '');
			}
		}
	}
	return val;
}

function StripOutCurrencySymbolTx(str) {
  if (str === undefined || str === null) { return ''; }
  str = str.replace('$', '').replace('AED', '');
  str = str.replace('€', '').replace('£', '');
  str = str.replace('kr', '').replace('kr.', '');
  str = str.replace('CHF', '').replace('NIS', '');
  str = str.replace('Rs', '').replace('F', '');
  str = str.replace('RO', '').replace('R', '');
  str = str.replace('SR', '').replace('D', '');
  return str;
}

function CleanEmailValTx(val) {
	if (val !== undefined && val !== null) {
		if (val.length > 0) {
			// can have number digits, comma, period, -
			var specChars = "\"!#$^&%*()+=[]\/{}|:<>?,' ";
			for (var i = 0; i < specChars.length; i++) {
				val = val.replace(new RegExp("\\" + specChars[i], 'gi'), '');
			}
		}
	}
	else {
		val = '';
	}
	return val;
}

function CleanTextMin2Tx(val, withqt) {
	if (val === undefined || val === null) { val = ''; }
	if (val.length > 0) {
		if (withqt === 1) {
			val = val.replace(/\'/gi, '`');
			val = val.replace(/\"/gi, '`');
		}
		if (withqt === 2) {
			val = val.replace(/\'/gi, '');
			val = val.replace(/\"/gi, '');
		}
		var specChars = "!@$^%*()[]\/{}|:<>";
		for (var i = 0; i < specChars.length; i++) {
			val = val.replace(new RegExp("\\" + specChars[i], 'gi'), '');
		}
	}
	return val;
}

function CleanTextMinimalTx(val, withqt) {
	if (val === undefined || val === null) { val = ''; }
	if (val.length > 0) {
		if (withqt === 1) {
			val = val.replace(/\'/gi, '`');
			val = val.replace(/\"/gi, '`');
		}
		if (withqt === 2) {
			val = val.replace(/\'/gi, '');
			val = val.replace(/\"/gi, '');
		}
		var specChars = "!@#$^&%*()+=[]\/{}|:<>?.,";
		for (var i = 0; i < specChars.length; i++) {
			val = val.replace(new RegExp("\\" + specChars[i], 'gi'), '');
		}
	}
	return val;
}

function StripInsecureTextCharsTx(val) {
	if (val === undefined || val === null) { val = '';}
	val = val.replace(/[^\w\s]/gi, '');
	return val;
}

function StripSingleQuotesTx(val) {
	if (val === undefined || val === null) { val = ''; }
	val = val.replace(/\'/gi, '');
	return val;
}

function EncodeSingleQuotesTx(val) {
	if (val === undefined || val === null) { val = ''; }
	val = val.replace(/\'\'/gi, '[XSQUOTEGRP]');
	val = val.replace(/\'/gi, '[XSQUOTE]');
	val = val.replace(/\"/gi, '[XDQUOTE]');
	val = val.replace(/;/gi, '[CMDTERMINATE]');
	return val;
}

function StripHTMLTagsTx(str, arguments) {
	var args = arguments.length > 0 ? arguments : [''];
	multiArgs(args, function (tag) {
		str = str.replace(RegExp('<\/?' + tag + '[^<>]*>', 'gi'), '');
	});
	return new this.constructor(str);
}

// =&?.:/ are okay
function StripURLTx(val) {
	if (val === undefined || val === null) { val = ''; }
	val = val.replace(/\'/gi, '');
	val = val.replace('"', '`').replace(';', '');
	val = val.replace(/\\/gi, '');
	val = val.replace('{', '`').replace('}', '');
	val = val.replace('(', '`').replace(')', '');
	val = val.replace('[', '`').replace(']', '');
	val = val.replace('|', '`').replace('%', '');
	val = val.replace('<', '`').replace('>', '');
	return val;
}

function PrepareJSONForHTMLTx(tval, typ) {
	if (tval === undefined || tval === null) { tval = ''; }
	var val = tval.toString();
	val = val.replace(/\t/g, '  ');
	val = val.replace(/\&/gi, '&amp;');
	val = val.replace(/\;/gi, '&#59;');
	val = val.replace(/\'/gi, '&#39;');
	val = val.replace(/\"/gi, '&quot;');
	val = val.replace(/\]/gi, '&#93;');
	val = val.replace(/\[/gi, '&#91;');
	val = val.replace(/\</gi, '&lt;');
	val = val.replace(/\>/gi, '&gt;');
	val = val.replace(/}/gi, '&#125;');
	val = val.replace(/{/gi, '&#123;');
	//val = val.replace(/\#/gi, '&#35;');
	val = val.replace(/\:/gi, '&#58;');
	val = val.replace(/\//gi, '&#47;');
	val = val.replace(/\\/gi, '&#123;');
	if (typ > 0) {
		val = val.replace(/\=/gi, '&#61;');
		val = val.replace(/\?/gi, '&#63;');
	}
	if (typ > 1) {
		val = val.replace(/\(/gi, '&#40;');
		val = val.replace(/\)/gi, '&#41;');
	}
	TrimTx(val);
	return val;
}

function PrepareHTMLForViewTx(tval, typ) {
	if (tval === undefined || tval === null) { tval = ''; }
	var val = tval.toString();
	val = val.replace(/&amp;/gi, '&');
	val = val.replace(/&#39;/gi, "'");
	val = val.replace(/&quot;/gi, '"');
	val = val.replace(/&#93;/gi, ']');
	val = val.replace(/&#91;/gi, '[');
	val = val.replace(/&lt;/gi, '<');
	val = val.replace(/&gt;/gi, '>');
	//val = val.replace(/&#35;/gi, '#');
	val = val.replace(/&#125;/gi, '}');
	val = val.replace(/&#123;/gi, '{');
	val = val.replace(/&#59;/gi, ';');
	val = val.replace(/&#58;/gi, ':');
	val = val.replace(/&#47;/gi, '/');
	val = val.replace(/&#123;/gi, '\\');
	// basic text
	if (typ > 0) {
		val = val.replace(/&#61;/gi, '=');
		val = val.replace(/&#63;/gi, '?');
	}
	// extended text
	if (typ > 1) {
		val = val.replace(/\&#40;/gi, '(');
		val = val.replace(/\&#41;/gi, ')');
	}
	return val;
}

// loc begins with 1 not 0, function handles charAt which is 0 based
function peekTx(str, loc) {
	return str.charAt(loc - 1);
}

function getChrTx(iChr) {
	return String.fromCharCode(iChr);
}																								 

function StringifyTx(txt) {
	if (txt === undefined || txt === null) { txt = '';}
	return "'" + txt + "'";
}

function compareTwoStringsSmartTx(s1, s2, NoCase) {
	if (s1 === undefined || s1 === null) { s1 = ''; }
	if (s2 === undefined || s2 === null) { s2 = ''; }
	if (s1 === '' || s2 === '') { return false; }
	if (NoCase === 1) {
		if (s1.toLowerCase() === s2.toLowerCase()) {
			return true;
		}
		else {
			return false;
		}
	}
	else {
		if (s1 === s2) {
			return true;
		}
		else {
			return false;
		}
	}
	return false;
}

function compareTwoStringsWithResultsTx(s1, s2, tlist, objid) {
	var tobj = document.getElementById(tlist);



	return 'not operational';
}

function compareTwoDivsWithResultsTx(divname1, divname2, tlist, objid) {
	var tdiv1 = document.getElementById(divname1);
	var tdiv2 = document.getElementById(divname2);
	var s1 = tdiv1.innerHTML;
	var s2 = tdiv2.innerHTML;



	//return false;
	return 'not operational';
}

function compareTwoDocumentsWithResultsTx(filenm1, filenm2, tlist, objid) {



	return 'not operational';
}

function ParseStringIntoLinesTx(s) {
	return csvdata.split(/[\r\n]+/g);
}

function ReplaceTabsWithUprightsTx(s) {
	return s.replace(/\t/g, '|');
}

function getArrayFromLinedTabbedStrTx(s, maxCols) {
	s = s.replace(/\t/g, '|');
	var line;
	var lines = ParseStringIntoLinesTx(s);
	var nr = 0;
	var a = createDimension2Array(lines.length, maxCols, 1)
	for (var row = 0; row < lines.length; row++) {
		line = lines[row].split('|');
		nr = line.length;
		if (nr > maxCols) { nr = maxCols;}
		for (var col = 0; col < nr; col++) {
			a[row][col] = line[col].toString();
		}
	}
	return a;
}

function getArrayFromLinedCommaStrTx(s, maxCols) {
	var chr = '';
	var inQ = false;
	var line = '';
	var lines = ParseStringIntoLinesTx(s);
	var newline = '';
	var nr = 0;
	var sa = '';
	var a = createDimension2Array(lines.length, maxCols, 1)
	for (var row = 0; row < lines.length; row++) {
		line = lines[row].toString();
		newline = '';
		// replace comma delimiters with upright chars
		for (var c = 0; c < line.length; c++) {
			chr = line.substr(c, 1);
			if (chr === '"') {
				if (inQ === true) {
					inQ = false;
				}
				else {
					inQ = true;
				}
			}
			else {
				if (chr === ',' && inQ === false) {chr = '|';}
			}
			newline = newline + chr;
		}
		sa = newline.split('|');
		nr = sa.length;
		if (nr > maxCols) { nr = maxCols; }
		for (var col = 0; col < nr; col++) {
			a[row][col] = sa[col].toString();
		}
	}
	return a;
}

function PrepareJSStringForHTMLDisplayTx(txt) {
	var val = txt.replace(/(\n)+/g, '<br />');
	val = val.replace(/\t/g, '&nbsp;&nbsp;&nbsp;&nbsp;');
	return val;
}

function IsOneStringInAnotherTx(findtxt, fulltxt) {
	if (fulltxt.indexOf(findtxt)) {
		return true;
	}
	else {
		return false;
	}
}