/* JavaScript: Dialogs.js - Last updated 10/14/2014
Contents:
  ShowSpecialDialogBox1Dx(objname, sTitle, bModal, bResizable, ht, wdth, myPos, atPos, ofPos, content, btn1, btnsz, pd, sshow, shide, src)
  ShowSpecialDialogBox2Dx(objname, sTitle, bModal, bResizable, ht, wdth, myPos, atPos, ofPos, content, btn1, btn2, btnsz, pd, sshow, shide, src)
  ShowSpecialDialogBox3Dx(objname, sTitle, bModal, bResizable, ht, wdth, myPos, atPos, ofPos, content, btn1, btn2, btn3, btnsz, pd, sshow, shide, src)
  ShowSpecialDialogBox4Dx(objname, sTitle, bModal, bResizable, ht, wdth, myPos, atPos, ofPos, content, btn1, btn2, btn3, btn4, btnsz, pd, sshow, shide, src)
  ShowSpecialMsgDialogBoxDx(objname, sTitle, bModal, bResizable, ht, wdth, myPos, atPos, ofPos, content, btnsz, sshow, shide, btntxt, pd)
  ShowSpecialConfirmDialogBoxDx(objname, sTitle, bModal, bResizable, ht, wdth, myPos, atPos, ofPos, content, btn1, btnsz, pd, sshow, shide, src)
  ShowSpecialConfirmDialogBoxYNDx(objname, sTitle, bModal, bResizable, ht, wdth, myPos, atPos, ofPos, content, btnsz, pd, sshow, shide, src)
  showPopupContinueCanxBoxDx(objname, title, ht, wdth, content, objid)
  showPopupMsgBoxDx(msg, objname, title, ht, wdth, ltop, lbtn, anchorName, sshow, shide)
  CloseSpecPopupBoxDx(objname)
  showPopupEditBoxDx(objname, sTitle, bModal, bResizable, ht, wdth, myPos, atPos, ofPos, content, typ, btnsz, pd, sshow, shide, btnClassNm, dlgClassNm, src)
	showPopupEditFormNoBtnDx(objname, sTitle, bModal, bResizable, ht, wdth, myPos, atPos, ofPos, content, sshow, shide, dlgClassNm, src)
	showPopupEditFormWithCanxDx(objname, sTitle, bModal, bResizable, ht, wdth, myPos, atPos, ofPos, content, sshow, shide, dlgClassNm, btnlabel, src)
  getDialogButtonDx(dialog_selector, button_name)
  setButtonDx(sDialogClass, sButtonName, sNewButtonName, bEnabled)
*/
var jiDGVersion = '1.0.2';
var jiDGVersDate = '5/27/2015';
var jiDialogChoice = 0;

// *******************************************************************
// last updated 10/31/2014
function ShowSpecialDialogBox1Dx(objname, sTitle, bModal, bResizable, ht, wdth, myPos, atPos, ofPos, content, btn1, btnsz, pd, sshow, shide, src) {
	//alert('Fired Box1!');
	if (content !== undefined && content !== null) {
		if (content.length > 0) {
			$("#" + objname).html(content);
		}
	}
	if (myPos.length > 0) {
		$("#" + objname).dialog({
			resizable: bResizable,
			modal: bModal,
			title: sTitle,
			height: ht,
			width: wdth,
			fluid: true,
			clickOut: true,
			responsive: true,
			showTitleBar: true,
			hide: shide,
			show: sshow,
			open: function () {
				$('.ui-widget-overlay').addClass('custom-overlay');
			},
			close: function() {
				$('.ui-widget-overlay').removeClass('custom-overlay');
			},
			position: {
				my: myPos,
				at: atPos,
				of: ofPos
			},
			buttons: {
				button1: {
					text: btn1,
					"class": "MyDialogButtonStd",
					click: function () {
						//if (ValidateThisDataItem(objid) === true) {
							//alert('test fired!');
							$(this).dialog('close');
							jiDialogChoice = 1;
							DialogAction1(jiDialogChoice, src);
						//};
					}
				},
				Cancel: {
					text: 'Cancel',
					"class": 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						document.getElementById(objname).style.display = 'none';
						jiDialogChoice = 0;
					}
				}
			}
		});
	}
	else {
		//alert('Part2');
		$("#" + objname).dialog({
			resizable: bResizable,
			modal: bModal,
			title: sTitle,
			height: ht,
			width: wdth,
			fluid: true,
			clickOut: true,
			responsive: true,
			showTitleBar: true,
			hide: shide,
			show: sshow,
			open: function () {
				$('.ui-widget-overlay').addClass('custom-overlay');
			},
			close: function () {
				$('.ui-widget-overlay').removeClass('custom-overlay');
			},
			buttons: {
				button1: {
					text: btn1,
					"class": "MyDialogButtonStd",
					click: function () {
						//alert('test fired!');
						//if (ValidateThisDataItem(objid) === true) {
							$(this).dialog('close');
							jiDialogChoice = 1;
							DialogAction1(jiDialogChoice, src);
						//}
						//else {
						//	alert('something wrong');
						//};
					}
				},
				Cancel: {
					text: 'Cancel',
					"class": 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						document.getElementById(objname).style.display = 'none';
						jiDialogChoice = 0;
					}
				}
			}
		});
	}

	switch (btnsz) {
		case 9:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "9px")
			break;
		case 10:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "10px")
			break;
		case 11:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "11px")
			break;
		case 12:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "12px")
			break;
		case 14:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "14px")
			break;
		default:
			break;
	}
	switch (pd) {
		case 0:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "0 0 0 0", "margin": "0 0 0 0" })
			break;
		case 1:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "1px 1px 1px 1px", "margin": "0 0 0 0" })
			break;
		case 2:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "2px 2px 2px 2px", "margin": "0 0 0 0" })
			break;
		default:
			break;
	}
	$("#" + objname).dialog("widget").find("button").css({ "padding": "0 .2em 0 .2em", "margin": "0 .5em 0 0" })
	$(".ui-dialog-titlebar-close").show();
}

// *******************************************************************
// last updated 10/31/2014
function ShowSpecialDialogBox2Dx(objname, sTitle, bModal, bResizable, ht, wdth, myPos, atPos, ofPos, content, btn1, btn2, btnsz, pd, sshow, shide, src) {
	//alert('Fired Box1!');
	if (content !== undefined && content !== null) {
		if (content.length > 0) {
			$("#" + objname).html(content);
		}
	}
	if (myPos.length > 0) {
		$("#" + objname).dialog({
			resizable: bResizable,
			modal: bModal,
			title: sTitle,
			height: ht,
			width: wdth,
			fluid: true,
			clickOut: true,
			responsive: true,
			showTitleBar: true,
			hide: shide,
			show: sshow,
			open: function () {
				$('.ui-widget-overlay').addClass('custom-overlay');
			},
			close: function () {
				$('.ui-widget-overlay').removeClass('custom-overlay');
			},
			position: {
				my: myPos,
				at: atPos,
				of: ofPos
			},
			buttons: {
				button1: {
					text: btn1,
					"class": 'MyDialogButtonStd',
					click: function () {
						//if (ValidateThisDataItem(objid) === true) {
							//alert('test fired!');
							$(this).dialog('close');
							jiDialogChoice = 1;
							DialogAction1(jiDialogChoice, src);
						//};
					}
				},
				button2: {
					text: btn2,
					"class": 'MyDialogButtonStd',
					click: function () {
						//if (ValidateThisDataItem(objid) === true) {
							//alert('test fired!');
							$(this).dialog('close');
							jiDialogChoice = 2;
							DialogAction1(jiDialogChoice, src);
						//};
					}
				},
				Cancel: {
					text: 'Cancel',
					"class": 'MyDialogButtonStd',
					click: function () {
						document.getElementById(objname).style.display = 'none';
						$(this).dialog('close');
						jiDialogChoice = 0;
					}
				}
			}
		});
	}
	else {
		$("#" + objname).dialog({
			resizable: bResizable,
			modal: bModal,
			title: sTitle,
			height: ht,
			width: wdth,
			fluid: true,
			clickOut: true,
			responsive: true,
			showTitleBar: true,
			hide: shide,
			show: sshow,
			open: function () {
				$('.ui-widget-overlay').addClass('custom-overlay');
			},
			close: function () {
				$('.ui-widget-overlay').removeClass('custom-overlay');
			},
			buttons: {
				button1: {
					text: btn1,
					"class": 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						jiDialogChoice = 1;
						DialogAction1(jiDialogChoice, src);
					}
				},
				button2: {
					text: btn2,
					"class": 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						jiDialogChoice = 2;
						DialogAction1(jiDialogChoice, src);
					}
				},
				Cancel: {
					text: 'Cancel',
					"class": 'MyDialogButtonStd',
					click: function () {
						document.getElementById(objname).style.display = 'none';
						$(this).dialog('close');
						jiDialogChoice = 0;
					}
				}
			}
		});
	}

	switch (btnsz) {
		case 9:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "9px")
			break;
		case 10:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "10px")
			break;
		case 11:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "11px")
			break;
		case 12:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "12px")
			break;
		case 14:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "14px")
			break;
		default:
			break;
	}
	switch (pd) {
		case 0:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "0 0 0 0", "margin": "0 0 0 0" })
			break;
		case 1:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "1px 1px 1px 1px", "margin": "0 0 0 0" })
			break;
		case 2:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "2px 2px 2px 2px", "margin": "0 0 0 0" })
			break;
		default:
			break;
	}
	$("#" + objname).dialog("widget").find("button").css({ "padding": "0 .2em 0 .2em", "margin": "0 .5em 0 0" })
	$(".ui-dialog-titlebar-close").show();
}

// *******************************************************************
// last updated 10/31/2014
function ShowSpecialDialogBox3Dx(objname, sTitle, bModal, bResizable, ht, wdth, myPos, atPos, ofPos, content, btn1, btn2, btn3, btnsz, pd, sshow, shide, src) {
	if (content !== undefined && content !== null) {
		if (content.length > 0) {
			$("#" + objname).html(content);
		}
	}
	if (myPos.length > 0) {
		$("#" + objname).dialog({
			resizable: bResizable,
			modal: bModal,
			title: sTitle,
			height: ht,
			width: wdth,
			fluid: true,
			clickOut: true,
			responsive: true,
			showTitleBar: true,
			hide: shide,
			show: sshow,
			open: function () {
				$('.ui-widget-overlay').addClass('custom-overlay');
			},
			close: function () {
				$('.ui-widget-overlay').removeClass('custom-overlay');
			},
			position: {
				my: myPos,
				at: atPos,
				of: ofPos
			},
			buttons: {
				button1: {
					text: btn1,
					"class": 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						jiDialogChoice = 1;
						DialogAction1(jiDialogChoice, src);
					}
				},
				button2: {
					text: btn2,
					"class": 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						jiDialogChoice = 2;
						DialogAction1(jiDialogChoice, src);
					}
				},
				button3: {
					text: btn3,
					"class": 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						jiDialogChoice = 0;
						DialogAction3(jiDialogChoice, src);
					}
				},
				Cancel: {
					text: 'Cancel',
					"class": 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						document.getElementById(objname).style.display = 'none';
						jiDialogChoice = 0;
					}
				}
			}
		});
	}
	else {
		$("#" + objname).dialog({
			resizable: bResizable,
			modal: bModal,
			title: sTitle,
			height: ht,
			width: wdth,
			fluid: true,
			clickOut: true,
			responsive: true,
			showTitleBar: true,
			hide: shide,
			show: sshow,
			open: function () {
				$('.ui-widget-overlay').addClass('custom-overlay');
			},
			close: function () {
				$('.ui-widget-overlay').removeClass('custom-overlay');
			},
			buttons: {
				button1: {
					text: btn1,
					"class": 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						jiDialogChoice = 1;
						DialogAction1(jiDialogChoice, src);
					}
				},
				button2: {
					text: btn2,
					"class": 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						jiDialogChoice = 2;
						DialogAction1(jiDialogChoice, src);
					}
				},
				button3: {
					text: btn3,
					"class": 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						jiDialogChoice = 0;
						DialogAction3(jiDialogChoice, src);
					}
				},
				Cancel: {
					text: 'Cancel',
					"class": 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						document.getElementById(objname).style.display = 'none';
						jiDialogChoice = 0;
					}
				}
			}
		});
	}

	switch (btnsz) {
		case 9:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "9px")
			break;
		case 10:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "10px")
			break;
		case 11:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "11px")
			break;
		case 12:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "12px")
			break;
		case 14:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "14px")
			break;
		default:
			break;
	}
	switch (pd) {
		case 0:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "0 0 0 0", "margin": "0 0 0 0" })
			break;
		case 1:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "1px 1px 1px 1px", "margin": "0 0 0 0" })
			break;
		case 2:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "2px 2px 2px 2px", "margin": "0 0 0 0" })
			break;
		default:
			break;
	}
	$("#" + objname).dialog("widget").find("button").css({ "padding": "0 .2em 0 .2em", "margin": "0 .5em 0 0" })
	$(".ui-dialog-titlebar-close").show();
}

// *******************************************************************
// last updated 10/31/2014
function ShowSpecialDialogBox4Dx(objname, sTitle, bModal, bResizable, ht, wdth, myPos, atPos, ofPos, content, btn1, btn2, btn3, btn4, btnsz, pd, sshow, shide, src) {
	if (content !== undefined && content !== null) {
		if (content.length > 0) {
			$("#" + objname).html(content);
		}
	}
	if (myPos.length > 0) {
		$("#" + objname).dialog({
			resizable: bResizable,
			modal: bModal,
			title: sTitle,
			height: ht,
			width: wdth,
			fluid: true,
			clickOut: true,
			responsive: true,
			showTitleBar: true,
			hide: shide,
			show: sshow,
			open: function () {
				$('.ui-widget-overlay').addClass('custom-overlay');
			},
			close: function () {
				$('.ui-widget-overlay').removeClass('custom-overlay');
			},
			position: {
				my: myPos,
				at: atPos,
				of: ofPos
			},
			buttons: {
				button1: {
					text: btn1,
					"class": 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						jiDialogChoice = 1;
						DialogAction1(jiDialogChoice, src);
					}
				},
				button2: {
					text: btn2,
					"class": 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						jiDialogChoice = 2;
						DialogAction1(jiDialogChoice, src);
					}
				},
				button3: {
					text: btn3,
					"class": 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						jiDialogChoice = 3;
						DialogAction1(jiDialogChoice, src);
					}
				},
				button4: {
					text: btn4,
					"class": 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						jiDialogChoice = 4;
						DialogAction1(jiDialogChoice, src);
					}
				},
				Cancel: {
					text: 'Cancel',
					"class": 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						document.getElementById(objname).style.display = 'none';
						jiDialogChoice = 0;
					}
				}
			}
		});
	}
	else {
		$("#" + objname).dialog({
			resizable: bResizable,
			modal: bModal,
			title: sTitle,
			height: ht,
			width: wdth,
			fluid: true,
			clickOut: true,
			responsive: true,
			showTitleBar: true,
			hide: shide,
			show: sshow,
			open: function () {
				$('.ui-widget-overlay').addClass('custom-overlay');
			},
			close: function () {
				$('.ui-widget-overlay').removeClass('custom-overlay');
			},
			buttons: {
				button1: {
					text: btn1,
					"class": 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						jiDialogChoice = 1;
						DialogAction1(jiDialogChoice, src);
					}
				},
				button2: {
					text: btn2,
					"class": 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						jiDialogChoice = 2;
						DialogAction1(jiDialogChoice, src);
					}
				},
				button3: {
					text: btn3,
					"class": 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						jiDialogChoice = 0;
						DialogAction1(jiDialogChoice, src);
					}
				},
				button4: {
					text: btn4,
					"class": 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						jiDialogChoice = 4;
						DialogAction1(jiDialogChoice, src);
					}
				},
				Cancel: {
					text: 'Cancel',
					"class": 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						document.getElementById(objname).style.display = 'none';
						jiDialogChoice = 0;
					}
				}
			}
		});
	}

	switch (btnsz) {
		case 9:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "9px")
			break;
		case 10:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "10px")
			break;
		case 11:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "11px")
			break;
		case 12:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "12px")
			break;
		case 14:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "14px")
			break;
		default:
			break;
	}
	switch (pd) {
		case 0:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "0 0 0 0", "margin": "0 0 0 0" })
			break;
		case 1:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "1px 1px 1px 1px", "margin": "0 0 0 0" })
			break;
		case 2:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "2px 2px 2px 2px", "margin": "0 0 0 0" })
			break;
		default:
			break;
	}
	$("#" + objname).dialog("widget").find("button").css({ "padding": "0 .2em 0 .2em", "margin": "0 .5em 0 0" })
	$(".ui-dialog-titlebar-close").show();
}

// *******************************************************************
// last updated 10/31/2014
function ShowSpecialMsgDialogBoxDx(objname, sTitle, bModal, bResizable, ht, wdth, myPos, atPos, ofPos, content, btnsz, sshow, shide, btntxt, pd) {
	//alert('Fired 2!');
	if (content !== undefined && content !== null) {
		if (content.length > 0) {
			$("#" + objname).html(content);
		}
	}
	if (myPos.length > 0) {
		$("#" + objname).dialog({
			resizable: bResizable,
			modal: bModal,
			title: sTitle,
			height: ht,
			width: wdth,
			fluid: true,
			clickOut: true,
			responsive: true,
			showTitleBar: true,
			hide: shide,
			show: sshow,
			open: function () {
				$('.ui-widget-overlay').addClass('custom-overlay');
			},
			close: function () {
				$('.ui-widget-overlay').removeClass('custom-overlay');
			},
			position: {
				my: myPos,
				at: atPos,
				of: ofPos
			},
			buttons: {
				button1: {
					text: btntxt,
					"class": 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						document.getElementById(objname).style.display = 'none';
						jiDialogChoice = 0;
						//alert(jiDialogChoice);
					}
				}
			}
		});
	}
	else {
		$("#" + objname).dialog({
			resizable: bResizable,
			modal: bModal,
			title: sTitle,
			height: ht,
			width: wdth,
			fluid: true,
			clickOut: true,
			responsive: true,
			showTitleBar: true,
			hide: shide,
			show: sshow,
			open: function () {
				$('.ui-widget-overlay').addClass('custom-overlay');
			},
			close: function () {
				$('.ui-widget-overlay').removeClass('custom-overlay');
			},
			buttons: {
				button1: {
					text: btntxt,
					"class": 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						jiDialogChoice = 0;
						document.getElementById(objname).style.display = 'none';
						//alert(jiDialogChoice);
					}
				}
			}
		});
	}

	switch (btnsz) {
		case 9:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "9px")
			break;
		case 10:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "10px")
			break;
		case 11:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "11px")
			break;
		case 12:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "12px")
			break;
		case 14:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "14px")
			break;
		default:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", btnsz.toString + "px")
			break;
	}
	switch (pd) {
		case 0:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "0 0 0 0", "margin": "0 0 0 0" })
			break;
		case 1:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "1px 1px 1px 1px", "margin": "0 0 0 0" })
			break;
		case 2:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "2px 2px 2px 2px", "margin": "0 0 0 0" })
			break;
		default:
			break;
	}
	$("#" + objname).dialog("widget").find("button").css({ "padding": "0 .2em 0 .2em", "margin": "0 .5em 0 0" })
}

// *******************************************************************
// last updated 10/31/2014
function ShowSpecialMsgDialogBox2Dx(objname, sTitle, bModal, bResizable, ht, wdth, myPos, atPos, ofPos, content, sshow, shide, pd) {
	//alert('Fired 2!');
	if (content !== undefined && content !== null) {
		if (content.length > 0) {
			$("#" + objname).html(content);
		}
	}
	if (myPos.length > 0) {
		$("#" + objname).dialog({
			resizable: bResizable,
			modal: bModal,
			title: sTitle,
			height: ht,
			width: wdth,
			fluid: true,
			clickOut: true,
			responsive: true,
			showTitleBar: true,
			hide: shide,
			show: sshow,
			open: function () {
				$('.ui-widget-overlay').addClass('custom-overlay');
			},
			close: function () {
				$('.ui-widget-overlay').removeClass('custom-overlay');
			},
			position: {
				my: myPos,
				at: atPos,
				of: ofPos
			}
		});
	}
	else {
		$("#" + objname).dialog({
			resizable: bResizable,
			modal: bModal,
			title: sTitle,
			height: ht,
			width: wdth,
			fluid: true,
			clickOut: true,
			responsive: true,
			showTitleBar: true,
			hide: shide,
			show: sshow,
			open: function () {
				$('.ui-widget-overlay').addClass('custom-overlay');
			},
			close: function () {
				$('.ui-widget-overlay').removeClass('custom-overlay');
			}
		});
	}

	switch (pd) {
		case 0:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "0 0 0 0", "margin": "0 0 0 0" })
			break;
		case 1:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "1px 1px 1px 1px", "margin": "0 0 0 0" })
			break;
		case 2:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "2px 2px 2px 2px", "margin": "0 0 0 0" })
			break;
		default:
			break;
	}
	$("#" + objname).dialog("widget").find("button").css({ "padding": "0 .2em 0 .2em", "margin": "0 .5em 0 0" })
}

// *******************************************************************
// last updated 10/31/2014
function ShowSpecialConfirmDialogBoxDx(objname, sTitle, bModal, bResizable, ht, wdth, myPos, atPos, ofPos, content, btn1, btnsz, pd, sshow, shide, src) {
	//alert('Fired!');
	if (content !== undefined && content !== null) {
		if (content.length > 0) {
			$("#" + objname).html(content);
		}
	}
	if (myPos.length > 0) {
		$("#" + objname).dialog({
			resizable: bResizable,
			modal: bModal,
			title: sTitle,
			height: ht,
			width: wdth,
			fluid: true,
			clickOut: true,
			responsive: true,
			showTitleBar: true,
			hide: shide,
			show: sshow,
			open: function () {
				$('.ui-widget-overlay').addClass('custom-overlay');
			},
			close: function () {
				$('.ui-widget-overlay').removeClass('custom-overlay');
			},
			position: {
				my: myPos,
				at: atPos,
				of: ofPos
			},
			buttons: {
				Continue: {
					text: btn1,
					class: 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						//alert('Fired!');
						jiDialogChoice = 1;
						DialogAction1(1, src);
					}
				},
				Cancel: {
					text: 'Cancel',
					class: 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						document.getElementById(objname).style.display = 'none';
						jiDialogChoice = 0;
					}
				}
			}
		});
	}
	else {
		$("#" + objname).dialog({
			resizable: bResizable,
			modal: bModal,
			title: sTitle,
			height: ht,
			width: wdth,
			fluid: true,
			clickOut: true,
			responsive: true,
			showTitleBar: true,
			hide: shide,
			show: sshow,
			open: function () {
				$('.ui-widget-overlay').addClass('custom-overlay');
			},
			close: function () {
				$('.ui-widget-overlay').removeClass('custom-overlay');
			},
			buttons: {
				Continue: {
					text: btn1,
					class: 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						jiDialogChoice = 1;
						DialogAction1(1, src);
					}
				},
				Cancel: {
					text: 'Cancel',
					class: 'MyDialogButtonStd',
					click: function () {
						$(this).dialog('close');
						document.getElementById(objname).style.display = 'none';
						jiDialogChoice = 0;
					}
				}
			}
		});
	}

	switch (btnsz) {
		case 9:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "9px")
			break;
		case 10:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "10px")
			break;
		case 11:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "11px")
			break;
		case 12:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "12px")
			break;
		case 14:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "14px")
			break;
		default:
			break;
	}
	switch (pd) {
		case 0:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "0 0 0 0", "margin": "0 0 0 0" })
			break;
		case 1:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "1px 1px 1px 1px", "margin": "0 0 0 0" })
			break;
		case 2:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "2px 2px 2px 2px", "margin": "0 0 0 0" })
			break;
		default:
			break;
	}
	$("#" + objname).dialog("widget").find("button").css({ "padding": "0 .2em 0 .2em", "margin": "0 .5em 0 0" })
	return false;
}

// *******************************************************************
// last updated 10/31/2014
function ShowSpecialConfirmDialogBoxYNDx(objname, sTitle, bModal, bResizable, ht, wdth, myPos, atPos, ofPos, content, btnsz, pd, sshow, shide, src) {
	//alert('Fired!');
	if (content !== undefined && content !== null) {
		if (content.length > 0) {
			$("#" + objname).html(content);
		}
	}
	if (myPos.length > 0) {
		$("#" + objname).dialog({
			resizable: bResizable,
			modal: bModal,
			title: sTitle,
			height: ht,
			width: wdth,
			fluid: true,
			clickOut: true,
			responsive: true,
			showTitleBar: true,
			hide: shide,
			show: sshow,
			open: function () {
				$('.ui-widget-overlay').addClass('custom-overlay');
			},
			close: function () {
				$('.ui-widget-overlay').removeClass('custom-overlay');
			},
			position: {
				my: myPos,
				at: atPos,
				of: ofPos
			},
			buttons: {
				'Yes': function () {
					$(this).dialog('close');
					jiDialogChoice = 1;
					DialogAction1(jiDialogChoice, src);
					//alert(jiDialogChoice);
				},
				'No': function () {
					$(this).dialog('close');
					jiDialogChoice = 0;
					DialogAction1(jiDialogChoice, src);
					//alert(jiDialogChoice);
				}
			}
		});
	}
	else {
		$("#" + objname).dialog({
			resizable: bResizable,
			modal: bModal,
			title: sTitle,
			height: ht,
			width: wdth,
			fluid: true,
			clickOut: true,
			responsive: true,
			showTitleBar: true,
			hide: shide,
			show: sshow,
			open: function () {
				$('.ui-widget-overlay').addClass('custom-overlay');
			},
			close: function () {
				$('.ui-widget-overlay').removeClass('custom-overlay');
			},
			buttons: {
				'Yes': function () {
					$(this).dialog('close');
					jiDialogChoice = 1;
					DialogAction1(jiDialogChoice, src);
					//alert(jiDialogChoice);
				},
				'No': function () {
					$(this).dialog('close');
					jiDialogChoice = 0;
					DialogAction1(jiDialogChoice, src);
					//alert(jiDialogChoice);
				}
			}
		});
	}
	switch (btnsz) {
		case 9:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "9px")
			break;
		case 10:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "10px")
			break;
		case 11:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "11px")
			break;
		case 12:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "12px")
			break;
		case 14:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "14px")
			break;
		default:
			break;
	}
	switch (pd) {
		case 0:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "0 0 0 0", "margin": "0 0 0 0" })
			break;
		case 1:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "1px 1px 1px 1px", "margin": "0 0 0 0" })
			break;
		case 2:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "2px 2px 2px 2px", "margin": "0 0 0 0" })
			break;
		default:
			break;
	}
	$("#" + objname).dialog("widget").find("button").css({ "padding": "0 .2em 0 .2em", "margin": "0 .5em 0 0" })
	//alert('complete');
}

function showPopupContinueCanxBoxDx(objname, title, ht, wdth, content, objid) {
	ShowSpecialDialogBox1Dx(objname, title, true, true, ht, wdth, 'center', 'center', window, content, 'Continue', 11, 0, 'slide', 'puff', objid);
}

function showPopupMsgBoxDx(msg, objname, title, ht, wdth, ltop, lbtn, anchorName, sshow, shide) {
	//var oAnchor = '#' + anchorName;
	//var obj = '#' + objname;
	//alert('Fired 1!');
	ShowSpecialMsgDialogBoxDx(objname, title, true, true, ht, wdth, ltop, ltbn, anchorName, msg, 11, sshow, shide, 'Continue', 0);  // anchorname may be oAnchor
	$(obj).dialog("option", "closeText", "Close");
	document.getElementById(objname).className = 'MyDialogStd';
	$(obj).dialog('open');
}

function CloseSpecPopupBoxDx(objname) {
	$("#" + objname).dialog('close');
}

function showPopupEditBoxDx(objname, sTitle, bModal, bResizable, ht, wdth, myPos, atPos, ofPos, content, typ, btnsz, pd, sshow, shide, btnClassNm, dlgClassNm, src) {
	var btn1 = 'Add';
	if (typ === 2) { btn1 = 'Update'; }
	if (typ === 3) { btn1 = 'Continue';}
	if (content !== undefined && content !== null) {
		if (content.length > 0) {
			$("#" + objname).html(content);
		}
	}
	//alert('part 1');
	if (myPos.length > 0) {
		$("#" + objname).dialog({
			resizable: bResizable,
			modal: bModal,
			title: sTitle,
			height: ht,
			width: wdth,
			hide: shide,
			show: sshow,
			position: {
				my: myPos,
				at: atPos,
				of: ofPos
			},
			buttons: {
				button1: {
					id: 'jqdButton1',
					text: btn1,
					"class": btnClassNm,
					click: function () {
						$(this).dialog('close');
						jiDialogChoice = 1;
						DialogAction1(jiDialogChoice, src);
					}
				},
				Cancel: {
					id: 'jqdCancel',
					text: 'Cancel',
					"class": btnClassNm,
					click: function () {
						$(this).dialog('close');
						jiDialogChoice = 0;
					}
				}
			}
		});
	}
	else {
		$("#" + objname).dialog({
			resizable: bResizable,
			modal: bModal,
			title: sTitle,
			height: ht,
			width: wdth,
			hide: shide,
			show: sshow,
			buttons: {
				button1: {
					id: 'jqdButton1',
					text: btn1,
					"class": btnClassNm,
					click: function () {
						$(this).dialog('close');
						jiDialogChoice = 1;
						DialogAction1(jiDialogChoice, src);
					}
				},
				Cancel: {
					id: 'jqdCancel',
					text: 'Cancel',
					"class": btnClassNm,
					click: function () {
						$(this).dialog('close');
						jiDialogChoice = 0;
					}
				}
			}
		});
	}

	//$("#" + objname).show();

	//alert('part 2');
	if (dlgClassNm !== '' && dlgClassNm !== null) {
		$(".ui-dialog").addClass(dlgClassNm);
	}

	//alert('part 3');
	switch (btnsz) {
		case 9:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "9px")
			break;
		case 10:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "10px")
			break;
		case 11:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "11px")
			break;
		case 12:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "12px")
			break;
		case 14:
			$("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "14px")
			break;
		default:
			break;
	}
	//alert('part 4');
	switch (pd) {
		case 0:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "0 0 0 0", "margin": "0 0 0 0" })
			break;
		case 1:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "1px 1px 1px 1px", "margin": "0 0 0 0" })
			break;
		case 2:
			$("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "2px 2px 2px 2px", "margin": "0 0 0 0" })
			break;
		default:
			break;
	}
	//alert('last part');
	$("#" + objname).dialog("widget").find("button").css({ "padding": "0 .2em 0 .2em", "margin": "0 .5em 0 0" })
}

function showPopupEditFormNoBtnDx(objname, sTitle, bModal, bResizable, ht, wdth, myPos, atPos, ofPos, content, sshow, shide, dlgClassNm, src) {
  if (content !== undefined && content !== null) {
    if (content.length > 0) {
      $("#" + objname).html(content);
    }
  }
  if (myPos.length > 0) {
    $("#" + objname).dialog({
      resizable: bResizable,
      modal: bModal,
      title: sTitle,
      height: ht,
      width: wdth,
      hide: shide,
      show: sshow,
      position: {
        my: myPos,
        at: atPos,
        of: ofPos
      }
    });
  }
  else {
    $("#" + objname).dialog({
      resizable: bResizable,
      modal: bModal,
      title: sTitle,
      height: ht,
      width: wdth,
      hide: shide,
      show: sshow
    });
  }

  if (dlgClassNm !== '' && dlgClassNm !== null) {
    $(".ui-dialog").addClass(dlgClassNm);
  }
}

function showPopupEditFormWithCanxDx(objname, sTitle, bModal, bResizable, ht, wdth, myPos, atPos, ofPos, content, sshow, shide, dlgClassNm, btnlabel, src) {
  if (content !== undefined && content !== null) {
    if (content.length > 0) {
      $("#" + objname).html(content);
    }
  }
  if (myPos.length > 0) {
    $("#" + objname).dialog({
      resizable: bResizable,
      modal: bModal,
      title: sTitle,
      height: ht,
      width: wdth,
      hide: shide,
      show: sshow,
      position: {
        my: myPos,
        at: atPos,
        of: ofPos
      },
      buttons: {
        Cancel: {
          text: btnlabel,
          "class": 'MyDialogButtonStd',
          click: function () {
            $(this).dialog('close');
            jiDialogChoice = 0;
          }
        }
      }
  });
  }
  else {
    $("#" + objname).dialog({
      resizable: bResizable,
      modal: bModal,
      title: sTitle,
      height: ht,
      width: wdth,
      hide: shide,
      show: sshow,
      buttons: {
      Cancel: {
        text: btnlabel,
          "class": 'MyDialogButtonStd',
          click: function () {
            $(this).dialog('close');
            jiDialogChoice = 0;
          }
      }
    }
  });
  }

  $("#" + objname).dialog("widget").find(".ui-button-text").css("font-size", "10px")
  $("#" + objname).dialog("widget").find(".ui-dialog-buttonpane").css({ "padding": "1px 1px 1px 1px", "margin": "0 0 0 0" })
  if (dlgClassNm !== '' && dlgClassNm !== null) {
    $(".ui-dialog").addClass(dlgClassNm);
  }
}

//Select the Dialog Buttons
function getDialogButtonDx(dialog_selector, button_name) {
	var buttons = $(dialog_selector + ' .ui-dialog-buttonpane button');
	for (var i = 0; i < buttons.length; ++i) {
		var jButton = $(buttons[i]);
		if (jButton.text() == button_name) {
			return jButton;
		}
	}
	return null;
}

//Button Controller for AJAX Loading:
function setButtonDx(sDialogClass, sButtonName, sNewButtonName, bEnabled) {
	var btn = getDialogButton(sDialogClass, sButtonName);
	btn.find('.ui-button-text').html(sNewButtonName);
	if (bEnabled) {
		btn.removeAttr('disabled', 'true');
		btn.removeClass('ui-state-disabled');
	} else {
		btn.attr('disabled', 'true');
		btn.addClass('ui-state-disabled');
	}
}

//<script type="text/javascript" src="../Scripts/Dialogs.js?v=<%=CBuildNbr %>"></script>
//<link rel="stylesheet" type="text/css" href="../Styles/Dialogs.css?v=<%=CBuildNbr %>" />
//$("#divTest").html("None");
//$("#divTest").dialog({ autoOpen: false });
//ShowSpecialMsgDialogBox('divTest', 'Initial Test', true, true, 200, 400, 'left top', 'left button', '#ContentPlaceHolder1_lblDetails', 'This is a test', 'Is Okay', 'No Way', 'Cancel', 11, 0, 1);
//$("#divTest").dialog("option", "closeText", "Close");
//document.getElementById('divTest').className = 'MyDialogStd';
//$("#divTest").dialog('open');
//<div id="divTest" style="width:100%;" title="Test Dialog" class="MyDialog">
//</div>

//$("#yourDialog").dialog("widget")
//   .next(".ui-widget-overlay")
//   .css("background", "#f00ba2");

//$("div#MyDialog").dialog({
//	title: "My Dialog Title",
//	open: function (event, ui) {
//		$(".ui-widget-overlay").css({
//			opacity: 1.0,
//			filter: "Alpha(Opacity=100)",
//			backgroundColor: "black"
//		});
//	},
//	modal: true
//});

//Change background:
//$(".ui-widget-overlay").css({background: "#000", opacity: 0.9});

//Restore background to CSS values:
//$(".ui-widget-overlay").css({background: '', opacity: ''});

// sshow fadeIn, slideDown
// sshide fadeOut, fold, slide, Blind, Bounce
//blind - up, down, left, right, vertical, horizontal
//bounce - (number of bounces)
//clip - up, vertical, horizontal
//drop - up, down, left, right
//explode - (number of pieces)
//puff - (number of scaling)
//pulsate - (number of pulsates)
//slide - left, right, up, down, (distance/direction)
//transfer - 
//$('#mypopup').dialog({
//	modal: true,
//	autoOpen: true,
//	resizable: false,
//	show: { effect: 'slide', duration: 250 },
//	hide: { effect: 'slide', duration: 250 }
//});