/* AJAXSupport.js - Last updated by S. Meeds on 6/14/2017
CONTENTS:
  CheckMyReturnAs()
	EvaluateStdDatabaseReturnAs(dtable, statusobj, accfailmsg, nortnmsg, msginvalidmsg)
	fixStringForAJAXAs(str)
	fixStringForSendAs(str)
	fixStringAfterReceiptAs(str)
	getJSONAs(url, data, success)
  getJSONReturnDataAs(url, MyData, success)
  getJSONReturnStatusAs(url, MyData, success)
	HandleJSONRequestToListAs(parentobjname, url, data)
	HandleJSONRequestToSelAs(parentobjname, url, data)
	handleStdAJAXDataErrorAs(msg)
*/

var jsASlibVersion = '1.0.0';
var jsASlibVersDate = '2017-06-14';

// last updated 11/7/2014 by S. Meeds
// Check MyReturn data table and analyze status info - StatusID (0-okay, 1-failed), Status (1 digit specific action), StatusMsg to show 
function CheckMyReturnAs() {
	//alert('Fired My return');
	jbHadError = false;
	jiActionStatusID = 0;
	jiActionStatusCode = '';
	jiActionStatusMsg = '';
	if (MyReturn === undefined || MyReturn === null) {
		alert('An error prevented that action.');
		jiActionStatusID = 3;
		return false;
	}
	if (MyReturn.length < 1) {
		jiActionStatusID = 2;
		alert('No status was returned from the database when that action was attempted. The action might not have completed successfully.');
		return false;
	}
	//alert(parseInt(MyReturn[0]['StatusID'], 10));
	var sid = parseInt(MyReturn[0]['StatusID'], 10);
	var msg = MyReturn[0]['StatusMsg'].toString();
	//var cd = MyReturn[0].Status.toString().substr(0, 1);
	//alert('Cd: ' + cd + '/ Msg ' + msg + '/' + msg.length);
	if (sid === undefined || sid === null || sid === NaN) { sid = 0; }
	jiActionStatusID = sid;
	//jiActionStatusCode = MyReturn[0].Status.toString().substr(0, 1);
	jiActionStatusMsg = MyReturn[0]['StatusMsg'].toString();
	//alert('Status Message: ' + sid.toString() + ' ' + MyReturn[0]['StatusMsg'].toString());
	return true;
}

function EvaluateStdDatabaseReturnAs(dtable, statusobj, accfailmsg, nortnmsg, msginvalidmsg) {
	if (dtable !== undefined && dtable !== null) {
		if (dtable.length > 0) {
			try {
				if (parseInt(dtable[0]['StatusID'], 10) !== 0) {
					statusobj.innerHTML = dtable[0]['StatusMsg'].toString();
				}
			}
			catch (ex) {
				statusobj.innerHTML = msginvalidmsg;
			}
		}
		else {
			statusobj.innerHTML = nortnmsg;
		}
	}
	else {
		statusobj.innerHTML = accfailmsg;
	}
	return false;
}

function fixStringForAJAXAs(str) {
	// , / ? : @ & = + $ #
	newstr = newstr.replace(/\'/g, '`');
	return str;
}

function fixStringForSendAs(str) {
	// , / ? : @ & = + $ #
	newstr = encodeURIComponent(str);
	newstr = newstr.replace(/\'/g, '`');
	return newstr;
}

function fixStringAfterReceiptAs(str) {
	newstr = decodeURIComponent(str);
	newstr = newstr.replace(/`/g, '\'');
	return newstr;
}

// ************************************************************************************
// Makes JSON call to ServicesControl.ascx/cs web service
// Last updated: 1/12/2014
function getJSONAs(url, data, success) {
	//alert(url + '/' + data + '/' + success);
	jstProcStatus.value = 'C';
	$.ajax({
		type: "POST",
		url: url,
		data: data,
		cache: false,
		async: false,
		contentType: "application/json; charset=utf-8",
		datatype: "json",
		timeout: 0,
		success: function (response) {
			success(eval(response.d));
			jstProcStatus.value = 'S';
		},
		error: function (response) {
			alert(response.responseText);
			jstProcStatus.value = 'E';
		}
	});
	jstProcStatus.value = 'F';
}

function getJSONReturnDataAs(url, MyData, success) {
	var IsOkay = true;
	//alert('JSON Proc to : ' + url + '/' + MyData);
	$.ajax({
		type: "POST",
		url: url,
		data: MyData,
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		cache: false,
		async: false,
		timeout: 0,
		success: function (response) {
			if (response.d.length === 0) {
				alert('No data was returned');
			}
			else {
				//alert(response.d);
				if (response.d.substr(0, 17) === '{"success":"false') {
					var nmsg = handleStdAJAXDataErrorAs(response.d);
					if (nmsg.length > 1) {
						alert(nmsg); // + '///' + nmsg.length);
						jsErrorMsg = nmsg;
					}
				}
				else {
					success(eval(response.d));
				}
			}
		},
		error: function (response) {
			alert(handleStdAJAXDataErrorAs(response.responseText));
			IsOkay = false;
		},
		failure: function () {
			IsOkay = false;
			alert('Your report data could not be retrieved because of an error - ' + response.message);
		}//,
		//statusCoe: {
		//	404: function () {
		//		alert("page not found");
		//	}
		//}
	});
	return IsOkay;
}

function getJSONReturnStatusAs(url, MyData, success) {
	var IsOkay = true;
	$.ajax({
		type: "POST",
		url: url,
		data: MyData,
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		cache: false,
		async: false,
		timeout: 0,
		success: function (msg) {
			alert(msg);
			var response = $.parseJSON(msg.d);
			if (response.success === 'false') {
				IsOkay = false;
				var msg2 = response.message;
				alert(handleStdAJAXDataErrorAs(msg2));
				//msg = msg.replace('"', '`');
				alert('Could not save your decision because of an error - ' + msg);
			}
			else {
				alert('Okay');
				IsOkay = true;
			}
		},
		error: function (response) {
			alert(response.responseText);
			IsOkay = false;
		},
		failure: function () {
			IsOkay = false;
			alert('Your report data could not be retrieved because of an error - ' + response.message);
		}
	});
	return IsOkay;
}

// data must return in "data1":"data2" format for each row where data1 becomes id and data2 is the value shown
function HandleJSONRequestToListAs(parentobjname, url, data) {
	var obj = document.getElementById(parentobjname);
	var MyUL = document.createElement("ul");
	var MyLI;
	$.getJSON(url, function (data) {
		//var items = [];
		$.each(data, function (key, val) {
			MyLI = document.createElement("li");
			MyLI.id = key;
			MyLI.textContent = val;
			//items.push("<li id='" + key + "'>" + val + "</li>");
			MyUL.appendChild(MyLI);
		});

		//$("<ul/>", {
		//	"class": "my-new-list",
		//	html: items.join("")
		//}).appendTo("body");
	});
	return MyUL;
}

// data must return in "data1":"data2" format for each row where data1 becomes id and data2 is the value shown
function HandleJSONRequestToSelAs(parentobjname, url, data) {
	var obj = document.getElementById(parentobjname);
	var MyOpt;
	$.getJSON(url, function (data) {
		//var items = [];
		$.each(data, function (key, val) {
			MyOpt = document.createElement("option");
			MyOpt.value = key;
			MyOpt.text = val;
			//items.push("<li id='" + key + "'>" + val + "</li>");
			obj.appendChild(MyOpt);
		});

		//$("<ul/>", {
		//	"class": "my-new-list",
		//	html: items.join("")
		//}).appendTo("body");
	});
	return false;
}

function handleStdAJAXDataErrorAs(msg) {
	var newmsg = '';
	var loc = 0;
	//alert('Fired!');
	// get to just the message portion
	if (msg == undefined || msg === null) { msg = 'NO RETURN VALUE'; }
	msg = msg.replace('{"success":"false","message":"', '');
	msg = msg.replace('"}', '');
	msg = msg.replace(/\\u0027/g, '"');
	msg = msg.replace(/\\r\\n/g, ' ');
	// remove first part identifying error
	if (msg.substr(0, 6) === 'Error:') {
		//alert('Error IDd');
		msg = msg.replace('Error: ', '');
		loc = msg.indexOf(',');
		//alert(loc);
		if (loc > 1) {
			// establish procedure name
			newmsg = 'Procedure: ' + msg.substr(0, loc) + '\n';
			msg = LTrimTx(msg.replace(msg.substr(0, loc + 1), ''));
			loc = msg.indexOf(',');
			if (loc > 1) {
				// add task area
				newmsg = newmsg + 'Task Area: ' + msg.substr(0, loc) + '\n';
				msg = LTrimTx(msg.replace(msg.substr(0, loc + 1), ''));
				msg = msg.replace('Err-', '');
				newmsg = newmsg + 'Error: ' + msg;
			}
			else {
				newmsg = newmsg + 'Error: ' + msg;
			}
		}
		else {
			newmsg = msg;
		}
	}
	else {
		newmsg = msg;
	}
	//alert('Msg: ' + msg);
	//newmsg = newmsg.replace(/\\u0027/g, '"');
	return newmsg;
}

