/* Javascript: NbrFunc.js - last updated 9/1/2015 by S. Meeds
Contents:
  Number.prototype.between
  IsOddNf(x)
  IsEvenNf(x)
	isTrueIntegerNf(val)
  jsfNumberFormatNf(number, decimals, dec_point, thousands_sep)
  RoundFloatNbrNf(value, exp)
  getRandomIntInRangeNf(min, max)
  readableNumberLimiterNf = function (number,limiter)
  extractFloatNf()
  StripNbrDisplayCharsNf(sval)
  ConvertDecToHexNf(nbr)
  ConvertHexToDecNf(nbr)
  ConvertDecToBinaryNf(nbr)
  ConvertBinaryToDecNf(nbr)
  checkBinNf(n)
  checkDecNf(n)
  checkHexNf(n)
  padNf(s, z)
  unpadNf(s)
  Dec2BinNf(n)
  Dec2HexNf(n)
  Bin2DecNf(n)
  Bin2HexNf(n)
  Hex2BinNf(n)
  Hex2DecNf(n)
  TryParseIntNf(str, defaultValue)
  TryParseFloatNf(str, defaultValue)
}
*/
var jiNFVersion = '1.0.3';
var jiNFVersDate = '9/1/2015';

//Number.prototype.between = function()
// { return this>arguments[0] && this < arguments[1]; };

//// Javascript modulus operator always returning a positive number
//Number.prototype.mod = function(n) {
//    return ((this % n) + n) % n;
//};

// ************************************************************************************
// checks if number is odd
// Last updated: 10/10/2014
function IsOddNf(x) {
	return x & 1;
}

// ************************************************************************************
// checks if number is even
// Last updated: 10/10/2014
function IsEvenNf(x) {
	return !(x & 1);
}

function isTrueIntegerNf(val) {
	if ((val === undefined) || (val === null)) {
		return false;
	}
	val = val.replace(',', '').replace('$', '');
	val = val.replace('%', '').replace('#', '');
	val = val.replace('-', '').replace('(', '').replace(')', '');
	return val % 1 == 0;
}

// ************************************************************************************
// formats number as string
// Last updated: 10/10/2014
function jsfNumberFormatNf(number, decimals, dec_point, thousands_sep) {
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

//function inprecise_roundNf(value, decPlaces) {
//	return Math.round(value * Math.pow(10, decPlaces)) / Math.pow(10, decPlaces);
//}

//function precise_roundNf(value, decPlaces) {
//	var val = value * Math.pow(10, decPlaces);
//	var fraction = (Math.round((val - parseInt(val)) * 10) / 10);

//	//this line is for consistency with .NET Decimal.Round behavior
//	// -342.055 => -342.06
//	if (fraction == -0.5) fraction = -0.6;

//	val = Math.round(parseInt(val) + fraction) / Math.pow(10, decPlaces);
//	return val;
//}

// ************************************************************************************
// returns number rounded to decimal place
// Last updated: 10/10/2014
function RoundFloatNbrNf(value, exp) {
  if (typeof exp === 'undefined' || +exp === 0) {
    return Math.round(value);
  }
  value = +value;
  exp = +exp;

  if (isNaN(value) || !(typeof exp === 'number' && exp % 1 === 0)) {
    return NaN;
  }
  // Shift
  value = value.toString().split('e');
  value = Math.round(+(value[0] + 'e' + (value[1] ? (+value[1] + exp) : exp)));

  // Shift back
  value = value.toString().split('e');
  return +(value[0] + 'e' + (value[1] ? (+value[1] - exp) : -exp));
}

// ************************************************************************************
// returns random number in defined range
// Last updated: 10/10/2014
function getRandomIntInRangeNf(min, max) {
  return Math.floor(Math.random()*(max-min+1)+min);

}

// ************************************************************************************
// Adds commas to integer string
// Last updated: 10/10/2014
readableNumberLimiterNf = function (number,limiter)
{
  return number.toString().replace(
     new RegExp(
         "(^\\d{"+(number.toString().length%3||-1)+"})(?=\\d{3})"),
         "$1"+limiter
         ).replace(/(\d{3})(?=\d)/g,"$1"+limiter);
};

// ************************************************************************************
// extract float number from formatted string
// Last updated: 10/10/2014
function extractFloatNf() {
    var  x = arguments[0].split(/,|\./), x2 = x.join('').replace(new RegExp(x[x.length-1]+'$'),'.'+x[x.length-1]);
    return parseFloat(x2);
}

function StripNbrDisplayCharsNf(sval) {
	var specialChars = "#$^&%*+=[]\/{}|:<>?,";
	for (var i = 0; i < specialChars.length; i++) {
		sval = sval.replace(new RegExp("\\" + specialChars[i], 'gi'), '');
	}
}

function ConvertDecToHexNf(nbr){
  var decNumber = Number(nbr);
  return decNumber.toString(16).toUpperCase();
}

function ConvertHexToDecNf(nbr) {
  return parseInt(nbr,16);
}
 
function ConvertDecToBinaryNf(nbr){
  var decNumber = Number(nbr);
  return decNumber.toString(2).toUpperCase();
}

function ConvertBinaryToDecNf(nbr){
  return parseInt(nbr, 2);
}

//Useful Functions
function checkBinNf(n) {
  return /^[01]{1,64}$/.test(n)
}
function checkDecNf(n) {
  return /^[0-9]{1,64}$/.test(n)
}
function checkHexNf(n) {
  return /^[0-9A-Fa-f]{1,64}$/.test(n)
}
function padNf(s, z) {
  s = "" + s;
  return s.length < z ? pad("0" + s, z) : s
}
function unpadNf(s) {
  s = "" + s;
  return s.replace(/^0+/, '')
}

//Decimal operations
function Dec2BinNf(n) {
  if (!checkDec(n) || n < 0) return 0;
  return n.toString(2)
}
function Dec2HexNf(n) {
  if (!checkDec(n) || n < 0) return 0;
  return n.toString(16)
}

//Binary Operations
function Bin2DecNf(n) {
  if (!checkBin(n)) return 0;
  return parseInt(n, 2).toString(10)
}
function Bin2HexNf(n) {
  if (!checkBin(n)) return 0;
  return parseInt(n, 2).toString(16)
}

//Hexadecimal Operations
function Hex2BinNf(n) {
  if (!checkHex(n)) return 0;
  return parseInt(n, 16).toString(2)
}
function Hex2DecNf(n) {
  if (!checkHex(n)) return 0;
  return parseInt(n, 16).toString(10)
}

function TryParseIntNf(str, defaultValue) {
  var retValue = defaultValue;
  if (str !== null) {
    if (str.length > 0) {
      if (!isNaN(str)) {
        retValue = parseInt(str, 10);
      }
    }
  }
  return retValue;
}

function TryParseFloatNf(str, defaultValue) {
  var retValue = defaultValue;
  if (str !== null) {
    if (str.length > 0) {
      if (!isNaN(str)) {
        retValue = parseFloat(str);
      }
    }
  }
  return retValue;
}

