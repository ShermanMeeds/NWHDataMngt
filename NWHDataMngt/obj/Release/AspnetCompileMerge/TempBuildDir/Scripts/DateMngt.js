/* DateMngt.js - Dated: 4/11/2017
functions:	
  Date.prototype.addDays
	addDaysDm(date, amount)
	DaysOfMonthDm(nYear, nMonth)
  IncrementDateDm(dt, incDays)
  getMyDateStringDm(dt, itype, incDays)
  getMyDateTimeStringDm(dt, itype)
  getLastMondayDm(dt)
  formatJSONDateDm(jsonDate)
  ConvertJSONDateDm(jsonDate)
  getMonthNameStrDm(iMo, typ)
  convertStringToLocalDateDm(dt)
  convertStringDatetoFormatDm(sDt, typ)
  convertDatetoStringFormatDm(dt, typ)
	iDateDm(format, timestamp)
	jsfValidateDateObjectDm(dt)
	checkdateDm(m, d, y)
	jsfGetTimeOfDayDm(return_float)
	toJavaScriptDateDm(value)
*/

var jsgDMVersion = '1.0.3';
var jsgDMVersDate = '9/8/2017';
var jaDMmonthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
var jaDMmonthNames2 = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
var jaDMDayNames = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
var jaDMDayNames2 = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

Date.prototype.addDays = function (days) {
	this.setDate(this.getDate() + parseInt(days));
	return this;
};

function addDaysDm(date, amount) {
	var tzOff = date.getTimezoneOffset() * 60 * 1000,
      t = date.getTime(),
      d = new Date(),
      tzOff2;

	t += (1000 * 60 * 60 * 24) * amount;
	d.setTime(t);

	tzOff2 = d.getTimezoneOffset() * 60 * 1000;
	if (tzOff != tzOff2) {
		var diff = tzOff2 - tzOff;
		t += diff;
		d.setTime(t);
	}

	return d;
}

function DaysOfMonthDm(nYear, nMonth) {
	switch (nMonth) {
		case 0:     // January
			return 31;
		case 1:     // February
			if ((nYear % 4) === 0) {
				return 29;
			}
			else {
				return 28;
			}
		case 2:     // March
			return 31; 
		case 3:     // April
			return 30;
		case 4:     // May
			return 31;
		case 5:     // June
			return 30;
		case 6:     // July
			return 31;
		case 7:     // August
			return 31;
		case 8:     // September
			return 30;
		case 9:     // October
			return 31;
		case 10:     // November
			return 30;
		default:     // December
			return 31;
	}
	return 31;
}

/* Accepts a date and number of days to increment, returns date */
/* tDate must be a date object or else it will fail */
function IncrementDateDm(dt, incDays) {
	return new Date(dt.getFullYear(), dt.getMonth(), dt.getDate() + incDays);
}
//	var nYear = dt.getFullYear();
//	var nMonth = dt.getMonth();
//	var nDate = dt.getDate();
//	//alert(nDate);
//	var remainDays = incDays;
//	var dRunDate = dt;

//	var remainDaysinmonth = DaysOfMonth(nYear, nMonth) - nDate;
//	if (remainDaysinmonth > incDays) {
//		nDate = nDate + incDays; //  + 1;
//	}
//	else {
//		nDate = nDate - remainDaysinmonth;
//		nMonth = nMonth + 1;
//		if (nMonth > 11) {
//			nMonth = nMonth - 12;
//			nYear = nYear + 1;
//		}
//	}

//	dRunDate = Date(nYear, nMonth, nDate);
//	return new Date(nYear, nMonth, nDate);
//}

function getMyDateStringDm(dt, itype, incDays) {
	var sDt = Date.parse(dt);
	//alert(sDt);
	var MyDt = new Date(sDt);
	if (incDays > 0) {
		//MyDt = IncrementDate(MyDt, incDays);
		MyDt.setDate(MyDt.getDate() + incDays);
	}
	//alert(MyDt);
	var mo = MyDt.getMonth() + 1;
	var dy = MyDt.getDate();
	var yr = MyDt.getFullYear();
	var sYear = yr.toString();
	var sDay = dy.toString();
	var sMonth = mo.toString();
	if (sMonth.length === 1) { sMonth = '0' + sMonth; }
	if (sDay.length === 1) { sDay = '0' + sDay; }
	switch (itype) {
		case 0:
			return sYear + '-' + sMonth + '-' + sDay;
			break;
		case 1:
			return sMonth + '/' + sDay + '/' + sYear;
			break;
		case 2:
			return sDay + '/' + sMonth + '/' + sYear;
			break;
		case 3:
			return jaDMmonthNames2[MyDt.getMonth()] + ' ' + sDay + ' ' + sYear;
			break;
		case 4:
			return sYear + sMonth + sDay;
			break;
		case 5:
			return sDay + '/' + sMonth;
			break;
		default:
			return sYear + '-' + sMonth + '-' + sDay;
	}
	return sYear + '-' + sMonth + '-' + sDay;
}

function getMyDateTimeStringDm(dt, itype) {
	var nDt = Date.parse(dt);
	//alert(sDt);
	var sval = '';
	var sTime = '';
	var NewDt = new Date(nDt);
	//alert(nDt);
	var mo = NewDt.getMonth() + 1;
	var dy = NewDt.getDate();
	var yr = NewDt.getFullYear();
	if (yr === NaN || dy === NaN || mo === NaN) {
		return '';
	}

	// form time string
	var hrs = NewDt.getHours();
	sval = hrs.toString();
	if (sval.length < 2) {sval = '0' + sval; }
	sTime = sval;
	var mins = NewDt.getMinutes();
	sval = mins.toString();
	if (sval.length < 2) { sval = '0' + sval; }
	sTime = sTime + ':' + sval;
	var secs = NewDt.getSeconds();
	sval = secs.toString();
	if (sval.length < 2) { sval = '0' + sval; }
	sTime = sTime + ':' + sval;

	var sYear = yr.toString();
	var sDay = dy.toString();
	var sMonth = mo.toString();
	// only add zeros to formats
	if (sMonth.length === 1 && itype < 10) { sMonth = '0' + sMonth; }
	if (sDay.length === 1 && itype < 10) { sDay = '0' + sDay; }
	switch (itype) {
		case 0:
			return sYear + '-' + sMonth + '-' + sDay + ' ' + sTime;
			break;
		case 1:
			return sMonth + '/' + sDay + '/' + sYear + ' ' + sTime;
			break;
		case 2:
			return sDay + '/' + sMonth + '/' + sYear + ' ' + sTime;
			break;
		case 3:
			return jaDMmonthNames2[NewDt.getMonth()] + ' ' + sDay + ' ' + sYear + ' ' + sTime;
			break;
		case 4:
			return sYear + sMonth + sDay + ' ' + sTime;
			break;
		case 5:
			return sDay + '/' + sMonth + ' ' + sTime;
			break;
		case 6:
			return sYear + sMonth + sDay; //YYYYMMDD
			break;
		case 7:
			return sTime;
			break;
		case 8:
			return sYear + '-' + sMonth + '-' + sDay;
			break;
		case 9:
			if (sMonth.length < 2) {sMonth = '0' + sMonth;}
			if (sDay.length < 2) {sDay = '0' + sDay;}
			return sYear + '-' + sMonth + '-' + sDay;
			break;
		case 10:
			return sYear + '-' + sMonth + '-' + sDay + ' ' + sTime;
			break;
		case 11:
			return sMonth + '/' + sDay + '/' + sYear + ' ' + sTime;
			break;
		case 12:
			return sDay + '/' + sMonth + '/' + sYear + ' ' + sTime;
			break;
		case 13:
			return jaDMmonthNames2[NewDt.getMonth()] + ' ' + sDay + ' ' + sYear + ' ' + sTime;
			break;
		case 14:
			return sYear + sMonth + sDay + ' ' + sTime;
			break;
		case 15:
			return sDay + '/' + sMonth + ' ' + sTime;
			break;
		case 16:
			// not used since YYYYMMDD format requires leading zeros
			break;
		case 17:
			return sTime;
			break;
		case 18:
			return sYear + '-' + sMonth + '-' + sDay;
			break;
		case 112:
			return sYear + sMonth + sDay; //YYYYMMDD
			break;
		default:
			return sYear + '-' + sMonth + '-' + sDay + ' ' + sTime;
	}
	return sYear + '-' + sMonth + '-' + sDay + ' ' + sTime;
}

function getLastMondayDm(dt) {
	//alert(dt);
	var nd = dt.getDay();
	var newdt = new Date(dt);
	var nnd = 0;
	//alert(nd);
	if (nd === 0) { nnd = 6; }
	if (nd === 1) { nnd = 0; }
	if (nd > 1) { nnd = 5 - (6 - nd); }
	var mo = newdt.getMonth();
	//alert(mo);
	var yr = newdt.getFullYear();
	//alert(yr);
	var dy = newdt.getDate();
	//alert(dy + '/' + nnd);
	if (dy - nnd < 1) {
		mo--;
		if (mo < 0) {
			yr--;
			mo = 12;
		}
		dy = DaysOfMonthDm(yr, mo) + dy - nnd;
	}
	else {
		dy = dy - nnd;
	}
	return new Date(yr, mo, dy);
}

function formatJSONDateDm(jsonDate) {
	var d = new Date((jsonDate.slice(6, -2) * 1));
	var day = d.getDate() * 1;
	var month = (d.getMonth() * 1) + 1;
	var s = (day < 10 ? "0" : "") + day + "-" + (month < 10 ? "0" : "") + month + "-" + d.getFullYear();
	return s;
}

function ConvertJSONDateDm(jsonDate) {
	return new Date((jsonDate.slice(6, -2) * 1));
}

// ******************************************************************
// Function accepts string variable and checks for proper date. 
// Formats: mm-dd-yyyy, mm/dd/yyyy, yyyy-mm-dd. 
// Returns: true if valid date, false if not.
// ******************************************************************
function IsValidDateDm(dateStr) {
	// change YYYY-MM-DD to mm/dd/yyyy format
	if (!IsContentsNullUndefEmptyGu(dateStr)) {
		if (dateStr.length === 10 && dateStr.indexOf('-') === 4) {
			var p1 = dateStr.substr(8, 2) + '/' + dateStr.substr(5, 2) + '/' + dateStr.substr(0, 4);
		}
		var datePat = /^(\d{1,2})(\/|-)(\d{1,2})(\/|-)(\d{4})$/;
		var matchArray = dateStr.match(datePat); // is the format ok?

		if (matchArray === null) {
			alert("Please enter date as either mm/dd/yyyy or mm-dd-yyyy.");
			return false;
		}

		month = matchArray[1]; // p@rse date into variables
		day = matchArray[3];
		year = matchArray[5];

		if (month < 1 || month > 12) { // check month range
			alert("Month must be between 1 and 12.");
			return false;
		}

		if (day < 1 || day > 31) {
			alert("Day must be between 1 and 31.");
			return false;
		}

		if ((month === 4 || month === 6 || month === 9 || month === 11) && day === 31) {
			alert("Month " + month + " doesn`t have 31 days!");
			return false;
		}

		if (month == 2) { // check for february 29th
			var isleap = (year % 4 === 0 && (year % 100 !== 0 || year % 400 === 0));
			if (day > 29 || (day == 29 && !isleap)) {
				alert("February " + year + " doesn`t have " + day + " days!");
				return false;
			}
		}
		return true; // date is valid
	}
	else {
		return false;
	}
}

function getMonthNameStrDm(iMo, typ) {
	if (iMo === undefined || iMo === null) { iMo = 0; }
	if (typ === 0) {
		return jaDMmonthNames[iMo];
	}
	else {
		return jaDMmonthNames2[iMo];
	}
}

function convertStringToLocalDateDm(dt) {
	if (dt !== undefined && dt !== null && typeof dt === 'string') {
		var adt = dt.split('-');
		var yr = parseInt(adt[0], 10);
		var mo = parseInt(adt[1], 10) - 1;
		var dy = parseInt(adt[2], 10);
		//alert(yr + '/' + mo + '/' + dy);
		var MyDt = new Date(yr, mo, dy);
		return MyDt;
	}
	else {
		return null;
	}
}

function convertStringDatetoFormatDm(sDt, typ) {
	var dt = new Date(sDt);
	var mo = dt.getMonth() + 1;
	var dy = dt.getDate();
	var yr = dt.getFullYear();
	var sMonth = mo.toString();
	var sDay = dy.toString();
	if (sMonth.length === 1) {
		sMonth = '0' + sMonth;
	}
	if (sDay.length === 1) {
		sDay = '0' + sDay;
	}
	switch (typ) {
		case 0: // YYYY-MM-DD
			return yr.toString() + '-' + sMonth + '-' + sDay;
			break;
		case 1: // MM/DD/YYYY
			return sMonth + '/' + sDay + '/' + yr.toString();
			break;
		case 2:  // MM-DD-YYYY
			return sMonth + '-' + sDay + '-' + yr.toString();
			break;
		case 3:// MMM DD, YYYY
			jaDMmonthNames[mo - 1].substring(0, 3) + ' ' + sDay + ', ' + yr.toString();
			break;
		case 112: // YYYYMMDD
			return yr.toString() + sMonth + sDay;
			break;
		default:
			return yr.toString() + '-' + sMonth + '-' + sDay;
			break;
	}
	return yr.toString() + '-' + sMonth + '-' + sDay;
}

function convertDatetoStringFormatDm(dt, typ) {
	var mo = dt.getMonth() + 1;
	var dy = dt.getDate();
	var yr = dt.getFullYear();
	var sMonth = mo.toString();
	var sDay = dy.toString();
	if (sMonth.length === 1) {
		sMonth = '0' + sMonth;
	}
	if (sDay.length === 1) {
		sDay = '0' + sDay;
	}
	switch (typ) {
		case 0: // YYYY-MM-DD
			return yr.toString() + '-' + sMonth + '-' + sDay;
			break;
		case 1: // MM/DD/YYYY
			return sMonth + '/' + sDay + '/' + yr.toString();
			break;
		case 2:  // MM-DD-YYYY
			return sMonth + '-' + sDay + '-' + yr.toString();
			break;
		case 3:// MMM DD, YYYY
			jaDMmonthNames[mo - 1].substring(0, 3) + ' ' + sDay + ', ' + yr.toString();
			break;
		case 112: // YYYYMMDD
			return yr.toString() + sMonth + sDay;
			break;
		default:
			return yr.toString() + '-' + sMonth + '-' + sDay;
			break;
	}
	return yr.toString() + '-' + sMonth + '-' + sDay;
}

function CompareTwoDatesDm(dt1, dt2) {
	var same = false;
	dt1.setHours(0, 0, 0, 0);
	dt2.setHours(0, 0, 0, 0);
	if (dt1 === dt2) { same = true;}
	return same;
}

function iDateDm(format, timestamp) {
	// From: http://phpjs.org/functions
	// +  derived from: date
	// +  derived from: gettimeofday
	// *     example 1: idate('y'); returns 1: 4
	if (format === undefined) {
		throw 'idate() expects at least 1 parameter, 0 given';
	}
	if (!format.length || format.length > 1) {
		throw 'idate format is one char';
	}

	// Fix: Need to allow date_default_timezone_set() (check for this.php_js.default_timezone and use)
	var date = ((typeof timestamp === 'undefined') ? new Date() : (timestamp instanceof Date) ? new Date(timestamp) : // Javascript Date()
		new Date(timestamp * 1000)), a;  // UNIX timestamp (auto-convert to int)

	switch (format) {
		case 'B':
			return Math.floor(((date.getUTCHours() * 36e2) + (date.getUTCMinutes() * 60) + date.getUTCSeconds() + 36e2) / 86.4) % 1e3;
		case 'd':
			return date.getDate();
		case 'h':
			return date.getHours() % 12 || 12;
		case 'H':
			return date.getHours();
		case 'i':
			return date.getMinutes();
		case 'I':
			// capital 'i' - Logic derived from getimeofday(). Compares Jan 1 minus Jan 1 UTC to Jul 1 minus Jul 1 UTC. If they are not equal, then DST is observed.
			a = date.getFullYear();
			return 0 + (((new Date(a, 0)) - Date.UTC(a, 0)) !== ((new Date(a, 6)) - Date.UTC(a, 6)));
		case 'L':
			a = date.getFullYear();
			return (!(a & 3) && (a % 1e2 || !(a % 4e2))) ? 1 : 0;
		case 'm':
			return date.getMonth() + 1;
		case 's':
			return date.getSeconds();
		case 't':
			return (new Date(date.getFullYear(), date.getMonth() + 1, 0)).getDate();
		case 'U':
			return Math.round(date.getTime() / 1000);
		case 'w':
			return date.getDay();
		case 'W':
			a = new Date(date.getFullYear(), date.getMonth(), date.getDate() - (date.getDay() || 7) + 3);
			return 1 + Math.round((a - (new Date(a.getFullYear(), 0, 4))) / 864e5 / 7);
		case 'y':
			return parseInt((date.getFullYear() + '').slice(2), 10); // This function returns an integer, unlike date()
		case 'Y':
			return date.getFullYear();
		case 'z':
			return Math.floor((date - new Date(date.getFullYear(), 0, 1)) / 864e5);
		case 'Z':
			return -date.getTimezoneOffset() * 60;
		default:
			throw 'Unrecognized date format token';
	}
}

function jsfValidateDateObjectDm(dt) {
	var m = dt.getMonth();
	var d = dt.getDate();
	var y = dt.getFullYear();
	return checkdate(m, d, y);
}

function checkdateDm(m, d, y) {
	// From: http://phpjs.org/functions
	// *     example 1: checkdate(12, 31, 2000); returns 1: true
	// *     example 2: checkdate(2, 29, 2001); returns 2: false
	// *     example 3: checkdate(3, 31, 2008); returns 3: true
	// *     example 4: checkdate(1, 390, 2000); returns 4: false
	return m > 0 && m < 13 && y > 0 && y < 32768 && d > 0 && d <= (new Date(y, m, 0)).getDate();
}

function jsfGetTimeOfDayDm(return_float) {
	// From: http://phpjs.org/functions
	// *   example 1: gettimeofday(); returns 1: {sec: 12, usec: 153000, minuteswest: -480, dsttime: 0}
	// *   example 1: gettimeofday(true); returns 1: 1238748978.49
	var t = new Date(),
    y = 0;

	if (return_float) {
		return t.getTime() / 1000;
	}

	y = t.getFullYear(); // Store current year.
	return {
		sec: t.getUTCSeconds(),
		usec: t.getUTCMilliseconds() * 1000,
		minuteswest: t.getTimezoneOffset(),
		// Compare Jan 1 minus Jan 1 UTC to Jul 1 minus Jul 1 UTC to see if DST is observed.
		dsttime: 0 + (((new Date(y, 0)) - Date.UTC(y, 0)) !== ((new Date(y, 6)) - Date.UTC(y, 6)))
	};
}

function toJavaScriptDateDm(value) {
	var pattern = /Date\(([^)]+)\)/;
	var results = pattern.exec(value);
	var dt = new Date(parseFloat(results[1]));
	return (dt.getMonth() + 1) + "/" + dt.getDate() + "/" + dt.getFullYear();
}

