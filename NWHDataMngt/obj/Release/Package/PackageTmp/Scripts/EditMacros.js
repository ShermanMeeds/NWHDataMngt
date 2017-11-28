/* EDitMacros.js  - Last updated by S. Meeds on 8/10/2017
Contents:
  GetMacroTextEM(alt, ctl, txt, objp)
  getCursorPosEM(input)
  setCursorPosEM(input, start, end)
	insertAtCursorEM(myField, myValue)
*/

var jiEMCurrentPos = 0;
var jsEMFirstPart = '';
var jsEMLastPart = '';

var jsEMVersion = '1.0.0';
var jsEMVersDate = '8/10/2017';
																		 
function GetMacroTextEM(alt, ctl, txt, objp, cursloc) {
	//alert('Fired!');
	var txtselected = '';
	switch (ctl) {
		case 0:
			break;
		case 1:
			//alert('Fired 2! - ' + txt);
			var start = objp.selectionStart;
			var end = objp.selectionEnd;
			var sfirst = objp.value.substring(0, cursloc);
			var slast = objp.value.substring(cursloc);
			//alert(cursloc);
			//alert(sfirst + '/' + slast);
			switch (txt) {
				case '0':
					objp.innerHTML = sfirst + '&mdash;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case '1':
					objp.innerHTML = sfirst + '&ring;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					event.preventDefault();
					break;
				case '2':
					objp.innerHTML = sfirst + '&frac12;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case '3':
					objp.innerHTML = sfirst + '&frac34;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case '4':
					objp.innerHTML = sfirst + '&frac14;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case '5':
					objp.innerHTML = sfirst + '&raquo;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case '6':
					objp.innerHTML = sfirst + '&larr;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case '7':
					objp.innerHTML = sfirst + '&uarr;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case '8':
					objp.innerHTML = sfirst + '&rarr;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case '9':
					objp.innerHTML = sfirst + '&darr;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case 'a':
					objp.innerHTML = sfirst + '&commat;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case 'b':
					objp.innerHTML = sfirst + '&bull;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case 'c':
					objp.innerHTML = sfirst + '&check;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case 'd':
					objp.innerHTML = sfirst + '&diams;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case 'e':
					objp.innerHTML = sfirst + '&loz;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case 'f':
					objp.innerHTML = sfirst + '&infin;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case 'g':
					objp.innerHTML = sfirst + '&deg;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case 'h':
					objp.innerHTML = sfirst + '&#9786;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case 'i':
					objp.innerHTML = sfirst + '&sim;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case 'j':
					objp.innerHTML = sfirst + '&hearts;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case 'k':
					objp.innerHTML = sfirst + '&#9785;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case 'l':
					objp.innerHTML = sfirst + '&ofcir;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case 'p':
					objp.innerHTML = sfirst + '&pound;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					event.preventDefault();
					break;
				case 'q':
					objp.innerHTML = sfirst + '&squ;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case 'r':
					objp.innerHTML = sfirst + '&star;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case 't':
					objp.innerHTML = sfirst + '&trade;' + slast;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case 'v':
					objp.innerHTML = sfirst + '&rtri;' + slast;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case 'u':
					objp.innerHTML = sfirst + '&ne;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case 'w':
					objp.innerHTML = sfirst + '&ang;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case 'y':
					objp.innerHTML = sfirst + '&yen;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				case 'z':
					objp.innerHTML = sfirst + '&copy;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					break;
				default:
					break;
			}
			//if (txt !== null) {
			//	alert(txt + '/' + txt.length);
			//}
			//objp.focus();
			break;
		default:
			break;
	}
	switch (alt) {
		case 0:
			break;
		case 1:
			var start = objp.selectionStart;
			var end = objp.selectionEnd;
			var sfirst = objp.value.substring(0, start);
			var slast = objp.value.substring(end);
			switch (txt) {
				case '0':
					objp.innerHTML = sfirst + 'this week' + slast;// return false;
					event.preventDefault();
					break;
				case '1':
					objp.innerHTML = sfirst + 'this month' + slast;// return false;
					event.preventDefault();
					break;
				case '2':
					objp.innerHTML = sfirst + 'this year' + slast;// return false;
					event.preventDefault();
					break;
				case '3':
					objp.innerHTML = sfirst + 'rest of this month' + slast;// return false;
					event.preventDefault();
					break;
				case '4':
					objp.innerHTML = sfirst + 'rest of this year' + slast;// return false;
					event.preventDefault();
					break;
				case '5':
					objp.innerHTML = sfirst + 'production was up' + slast;// return false;
					event.preventDefault();
					break;
				case '6':
					objp.innerHTML = sfirst + 'production was down' + slast;// return false;
					event.preventDefault();
					break;
				case '7':
					objp.innerHTML = sfirst + 'inventory went down' + slast;// return false;
					event.preventDefault();
					break;
				case '8':
					objp.innerHTML = sfirst + 'inventory went up' + slast;// return false;
					event.preventDefault();
					break;
				case '9':
					objp.innerHTML = sfirst + 'overtime was necessary' + slast;// return false;
					event.preventDefault();
					break;
				case 'b':
					txtselected = UnderlineBoldSelectedTextGu(GetSelectionInsideTextareaGu(objp), 1);
					objp.innerHTML = sfirst + txtselected + slast;// return false;
					event.preventDefault();
					break;
				case 'c':
					objp.innerHTML = sfirst + '&#9925;' + slast;// return false;
					event.preventDefault();
					break;
				case 'g':	// insert spot for graphic file InsertGraphic.png
					objp.innerHTML = sfirst + '&otimes;' + slast;// return false;
						try {
							jchkInsertGraphicOn.checked = true;
							jspnGraphicsData.style.display = 'inline';
						}
						catch (ex) {
							// nothing
						}
					event.preventDefault();
					break;
				case 'i':
					txtselected = UnderlineBoldSelectedTextGu(GetSelectionInsideTextareaGu(objp), 4);
					objp.innerHTML = sfirst + txtselected + slast;// return false;
					event.preventDefault();
					break;
				case 'l':
					objp.innerHTML = sfirst + '<br />' + slast;// return false;
					event.preventDefault();
					break;
				case 'r':
					objp.innerHTML = sfirst + '&#9928;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					event.preventDefault();
					break;
				case 's':
					objp.innerHTML = sfirst + '&#9733;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					event.preventDefault();
					break;
				case 't':
					objp.innerHTML = sfirst + '&#9951;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					event.preventDefault();
					break;
				case 'u':
					txtselected = UnderlineBoldSelectedTextGu(GetSelectionInsideTextareaGu(objp), 2);
					objp.innerHTML = sfirst + txtselected + slast;// return false;
					event.preventDefault();
					break;
				case 'w':
					objp.innerHTML = sfirst + '&#9888;' + slast;// return false;
					objp.selectionStart = cursloc + 1;
					objp.selectionEnd = cursloc + 1;
					event.preventDefault();
					break;
				case '^':
					txtselected = UnderlineBoldSelectedTextGu(GetSelectionInsideTextareaGu(objp), 3);
					objp.innerHTML = sfirst + txtselected + slast;// return false;
					event.preventDefault();
					break;
				case '!':
					txtselected = UnderlineBoldSelectedTextGu(GetSelectionInsideTextareaGu(objp), 5);
					objp.innerHTML = sfirst + txtselected + slast;// return false;
					event.preventDefault();
					break;
				default:
					break;
			}
			break;
		default:
			break;
	}
	return false;
}

function getCursorPosEM(input) {
	if ("selectionStart" in input && document.activeElement == input) {
		return {
			start: input.selectionStart,
			end: input.selectionEnd
		};
	}
	else if (input.createTextRange) {
		var sel = document.selection.createRange();
		if (sel.parentElement() === input) {
			var rng = input.createTextRange();
			rng.moveToBookmark(sel.getBookmark());
			for (var len = 0;
							 rng.compareEndPoints("EndToStart", rng) > 0;
							 rng.moveEnd("character", -1)) {
				len++;
			}
			rng.setEndPoint("StartToStart", input.createTextRange());
			for (var pos = { start: 0, end: len };
							 rng.compareEndPoints("EndToStart", rng) > 0;
							 rng.moveEnd("character", -1)) {
				pos.start++;
				pos.end++;
			}
			return pos;
		}
	}
	return -1;
}

function setCursorPosEM(input, start, end) {
	if (arguments.length < 3) end = start;
	if ("selectionStart" in input) {
		setTimeout(function () {
			input.selectionStart = start;
			input.selectionEnd = end;
		}, 1);
	}
	else if (input.createTextRange) {
		var rng = input.createTextRange();
		rng.moveStart("character", start);
		rng.collapse();
		rng.moveEnd("character", end - start);
		rng.select();
	}
}

function insertAtCursorEM(myField, myValue) {
	//IE support
	if (document.selection) {
		myField.focus();
		sel = document.selection.createRange();
		sel.text = myValue;
	}
		//MOZILLA and others
	else if (myField.selectionStart || myField.selectionStart == '0') {
		var startPos = myField.selectionStart;
		var endPos = myField.selectionEnd;
		myField.value = myField.value.substring(0, startPos)
				+ myValue
				+ myField.value.substring(endPos, myField.value.length);
	} else {
		myField.value += myValue;
	}
}

//$('input[type=button]').on('click', function () {
//	var cursorPos = $('#text_id').prop('selectionStart');
//	var v = $('#text_id').val();
//	var textBefore = v.substring(0, cursorPos);
//	var textAfter = v.substring(cursorPos, v.length);

//	$('#text').val(textBefore + $(this).val() + textAfter);
//});

//function GradTextPortionsFromPosEM(input) {
//	alert(input);
//	jiEMCurrentPos = getCursorPosEM(input);
//	alert(jiEMCurrentPos);
//	var v = $(input).val();
//	var jsEMFirstPart = v.substring(0, jiEMCurrentPos);
//	var jsEMLastPart = v.substring(jiEMCurrentPos, v.length);
//	alert(jsEMFirstPart + '/' + jsEMLastPart);
//	return false;
//}

