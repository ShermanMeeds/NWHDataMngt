/* FileFunctions.js 
Contents:
  isReadFileInIEFf(filename)
  isReadFileInIEtxtFf(filename)
  isReadFileInNonIEFf(filename)
  isReadFileInNonIEtxtFf(filename, objname)
  getFileContentsFf(flnm)
  myFFunctionFf(arr)
  inputTargetFileNameFf(objname, reqext)
  ReadCSVFileFf(objname, objhint, objtitle)
  handleDragOverFf(evt)
  handleDropFf(evt)
  HandleMultiFilesFf(files, id, src, ctype, typ)
  checkItemsDataFf()
	cancelMultiFilesTransFf()
	HandleMultiFilesFf2(progobjname, lblobjname, objid)
	IEReadFileFf(filename)
	ParseReturnDataFf(tStat, err, jqXHR)
  GetBinaryFileContentsFf(fname)
	abortReadFf()
  errorHandlerFf(evt)
	getBinaryFf(file)
  GetFileAsBlobFf(fpath, fname, fsize, mdate)
  GetFileAsArrayBufferFf(fpath, fname, fsize, mdate)
	ParseFileNameFf(fname)
	encode64Ff(input)
	decode64Ff(input)
	base64EncodeFf(text)
	base64DecodeFf(text)
*/
 
var jsFLVersion = '1.0.0';
var jsFLVersDate = '6/5/2015';

var jbFLBlob = ['', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''];
var jaFLFileTransfer = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
var jbFLContinue = true;
var jbFLInDragDrop = false;
var jiFLObjectID = 0;
var jsFLDocType = '';
var jsFLFileContents = '';
var jsFLFileExtentions = ['vb','txt','cs','csv','jpg','gif','pdf','tif','tiff','mpeg','config','js','css','php','asp','aspx','csproj','ico','htm','html','xml','sln','user','dll','svg','ttf','png','master','asc','ascx','asm','asmx','doc','docx','xls','xlsx','mdf','xlsm','sql','ldf','mdb','exe','msi','msg','zip','7z','accdb','sdf','ps1','bak','wmv','avi','mov','flv','mpg','mp4','bmp','mht','iso','ost','vsd','mp3','mp2','mpa','wav','themepack'];
var jsFLHadError = false;
var jsFLItemData; // createDimension2ArrayGu(100, 3, 1);
var jsFLNbrItems = 0;
var keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";


function isReadFileInIEFf(filename, objname) {
	try {
		var fso = new ActiveXObject("Scripting.FileSystemObject");
		var fh = fso.OpenTextFile(filename, 1);
		var contents = fh.ReadAll();
		fh.Close();
		document.getElementById(objname).innerHTML = contents;
		return '';
	}
	catch (Exception) {
		return "Cannot open file :(";
	}
}

function isReadFileInIEtxtFf(filename) {
	try {
		var fso = new ActiveXObject("Scripting.FileSystemObject");
		var fh = fso.OpenTextFile(filename, 1);
		var contents = fh.ReadAll();
		fh.Close();
		return contents;
	}
	catch (Exception) {
		return "Cannot open file :(";
	}
}

function isReadFileInNonIEFf(filename) {
	var reader = new FileReader();
	reader.readAsText(file, "UTF-8");
	reader.onload = function (evt) {
	  return evt.target.result;
	};
	reader.onerror = function (evt) {
	  return "error reading file";
	};
}

function isReadFileInNonIEtxtFf(filename, objname) {
	var reader = new FileReader();
	reader.readAsText(file, "UTF-8");
	reader.onload = function (evt) {
	  document.getElementById(objname).innerHTML = evt.target.result;
	  return '';
	};
	reader.onerror = function (evt) {
	  return "error reading file";
	};
}

function getFileContentsFf(flnm) {
	var xmlhttp = new XMLHttpRequest();
	//var url = "file.txt";
	xmlhttp.onreadystatechange = function () {
	  if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
	    var myArr = JSON.parse(xmlhttp.responseText);
	    myFFunctionFl(myArr);
	    console.log("xmlhttp Request Asepted");
	  }
	};
	xmlhttp.open("GET", flnm, true);
	xmlhttp.send();
}

function myFFunctionFf(arr) {
	var out = "";
	var i;
	var row = 0;

	for(i = 0; i < arr.length; i++) {
			// console.log( arr[1].data); change data to what every you have in  your file
			// out +=  arr[i].data + '<br>' + arr[i].data2 ;
			jsFLFileContents = out;
	}
}

function inputTargetFileNameFf(objname, reqext) {
  //var ext = .split(".").pop().toLowerCase();
  var efile = ['', '', '0'];
  var afile = ['', '', '0'];
  var sFile = $("input#" + objname).val().toLowerCase();
  var lloc = sFile.lastIndexOf('.');
  var p1 = '';
  var p2 = sFile.substr(lloc+1, 20);
  if ($.inArray(p2, jsFLFileExtentions, 0) !== -1) {
    afile[2] = '1';
    p1 = sFile.replace('.'+p2, '');
    afile[0] = p1;
    afile[1] = p2;
  }
  else {
    afile[0] = sFile;
  }
  if (reqext !== '' && afile[1] !== reqext) {
    alert('File type ' + reqext + ' is required.');
    return efile;
  }
  return afile;
}

function ReadCSVFileFf(objname, objhint, objtitle) {
  //$("#" + filenm).change(function (e) {
    var ext = inputTargetFileName(objname, 'csv');
    if (ext[0] !== '') {
      if (e.target.files != undefined) {
        var reader = new FileReader();
        reader.onload = function (e) {
          var csvval = e.target.result.split("\n");
          var csvvalue = csvval[0].split(",");
          var inputrad = "";
          for (var i = 0; i < csvvalue.length; i++) {
            var temp = csvvalue[i];
            inputrad = inputrad + " " + temp;
          }
          $("#" + objhint).html(inputrad); //"#csvimporthint"
          $("#" + objtitle).show(); //"#csvimporthinttitle"
        };
        reader.readAsText(e.target.files.item(0));
      }
    }
    return false;
  //});
}

//function ReadTextFile(objname, fname) {
//  jQuery.get(fname, function (data) {
//    //process text file line by line
//    $('#' + objname).html(data);
//  });
//  return false;
//}

//function GetBinaryFileWithAJAX(url) {
//  $.ajax({
//    url: url,
//    type: "GET",
//    dataType: "binary",
//    async: false,
//    responseType: 'arraybuffer',
//    processData: false,
//    success: function (result) {
//      // do something with binary data
//      jsFLFileContents = result.
//    }
//  });
//}


//function readMultipleFilesFf(evt) {
//  var fname = '';
//  var fsize = 0;
//  var mdate = '';
//  var ftype = '';

//  // Reset progress indicator on new file selection.
//  progress.style.width = '0%';
//  progress.textContent = '0%';

//  // Check for the various File API support.
//  if (window.File && window.FileReader && window.FileList && window.Blob) {
//    // Great success! All the File APIs are supported.
//    //Retrieve all the files from the FileList object
//    var files = evt.target.files;
//    if (files) {
//      for (var i = 0, f; f = files[i]; i++) {
//        fname = f.name;
//        fsize = f.size;
//        ftype = f.type;
//        mdate = f.lastModifiedDate ? f.lastModifiedDate.toLocaleDateString() : 'n/a';

//        // load file and save to db
//        //GetFileAsArrayBufferFf(fpath, fname, fsize, mdate);
//        var rdr = new FileReader();
//        rdr.onload = function(e) {
//          var bBlob = reader.result;
//        }
//        rdr.readAsBinaryString(f);
//        //rdr.onerror = errorHandlerFf;
//        //rdr.onprogress = updateProgress;
//        //rdr.onabort = function (e) {
//        //  alert('File load cancelled');
//        //};
//        //rdr.onloadstart = function (e) {
//        //  document.getElementById('progress_bar').className = 'loading';
//        //};
//        //rdr.onload = function (e) {
//        //  // Ensure that the progress bar displays 100% at the end.
//        //  progress.style.width = '100%';
//        //  progress.textContent = '100%';
//        //  setTimeout("document.getElementById('progress_bar').className='';", 2000);
//        //}
//        //rdr.onloadend = function (evt) {
//        //  if (evt.target.readyState == FileReader.DONE) {
//        //    jsFLFileContents = evt.target.result;
//        //  }
//        //}
//        ////rdr.readAsText(f);
//        //rdr.readAsBinaryString(f);
//        ////rdr.readAsDataURL(f);
//      }
//    } else {
//      alert("Failed to load files");
//    }
//    return false;
//  } else {
//    alert('The File APIs are not fully supported in this browser.');
//    return false;
//  }
//}
//document.getElementById('files').addEventListener('change', HandleMultiFilesFf(this.files, jiDocID, '        ', '              ', 1), false);
//var dropZone = document.getElementById('divFileDropZone');

function handleDragOverFf(evt) {
  evt.stopPropagation();
  evt.preventDefault();
  evt.dataTransfer.dropEffect = 'copy'; //Explicitly show this is a copy.
}

function handleDropFf(evt) {
  evt.stopPropagation();
  evt.preventDefault();

  var dt = evt.dataTransfer;
  var files = dt.files;

  HandleMultiFilesFf(files, 41);
}

// grab and save list of files and trigger dialog to identify content type
function HandleMultiFilesFf(files, objid) {
  //alert('Fired!');
  //alert(files.length);
  var reqid = jiCodeReqID; // parseInt(id, 10);
  var fileList = files; 
  jaFLFileTransfer = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  if (window.File && window.FileReader && window.FileList && window.Blob) {
    //alert('compatibility checked!');
    var blob;
    var dtype = 'TX';
    var ht = 600;
    var mfpath = '';
    var wdth = 900;
    var s = '';
    var sRow = '';
    var val = '';
    var sTitle = 'File Attributes';
    var xfiles = document.getElementById('files').value;
    var fpaths = xfiles.split(',');
    var nbrFiles = 0;
    var nbrFiles2 = 0;
    if (files.length > 0) {
      //alert('has file list');
      // get file attributes from user
      jsFLItemData = createDimension2ArrayGu(100, 6, 1);
      jsFLNbrItems = files.length;

      s = '<div style="width:100%;text-align:center;"><table style="border-spacing:0px;border-collapse:collapse;border:1px solid gray;margin: auto auto;"><tr>';
      s = s + '<td class="TableHdrCell" style="width:300px;">Doc Title</td><td class="TableHdrCell" style="width:300px;">File Name</td>';
      s = s + '<td class="TableHdrCell" style="width:60px;">Size</td><td class="TableHdrCell" style="width:70px;">Type</td><td class="TableHdrCell">Content Type</td></tr>';

      // create line for each file in list - also grab file attributes
      for (var fl = 0, f; f = fileList[fl]; fl++) {
        nbrFiles = fl;
        if (fpaths.length > fl) { mfpath = fpaths[nbrFiles].replace(f.name.toString(), ''); }
        //alert(nbrFiles + '/' + fpaths.length);
        sRow = fl.toString();
        if (sRow.length === 2) { sRow = '0' + sRow; }
        if (sRow.length === 1) { sRow = '00' + sRow; }
        s = s + '<tr>';
        jsFLItemData[nbrFiles][0] = f.name;
        ft = ParseFileNameFf(jsFLItemData[nbrFiles][0]);
        val = f.name.replace('.' + ft[1].toString(), '').toString();
        s = s + '<td class="StdTableCellWBorder" style="text-align:left;"><input type="text" id="txtDocTitle' + sRow + objid.toString() + '" value="' + val + '" style="width:300px;" /></td>';
        jsFLItemData[nbrFiles][5] = val;
        s = s + '<td class="StdTableCellWBorder" style="text-align:left;">' + f.name + '</td>';
        jsFLItemData[nbrFiles][1] = f.size.toString();
        s = s + '<td class="StdTableCellWBorder" style="text-align:right;">' + f.size.toString() + '</td>';
        jsFLItemData[nbrFiles][2] = ft[1].toString();
        jsFLItemData[nbrFiles][4] = f.type;
        // establish type of data load
        if (f.type.substr(0, 5) === 'text/') {
          dtype = 'TX';
        }
        else {
          if (f.type.substr(0, 6) === 'image/') {
            dtype = 'AB'; //'DU';
          }
          else {
            if (f.type.substr(0, 5) === 'data/') {
              dtype = 'DT';
            }
            else {
              dtype = 'AB';
            }
          }
        }

        s = s + '<td class="StdTableCellWBorder" style="text-align:center;">' + ft[1].toString() + '</td>';
        jsFLItemData[nbrFiles][3] = f.lastModifiedDate ? f.lastModifiedDate.toLocaleDateString() : 'n/a';
        jsFLItemData[nbrFiles][6] = mfpath; 
        s = s + '<td class="StdTableCellWBorder" style="text-align:center;"><select id="selContentType' + sRow + objid.toString() + '" style="width:120px;"><option value="0" selected="selected">Undefined</option>';
        if (MyContentTypes !== undefined && MyContentTypes !== null) {
          if (MyContentTypes.length > 0) {
            for (var crow = 0; crow < MyContentTypes.length; crow++) {
              s = s + '<option value="' + MyContentTypes[crow].ContentType.toString() + '">' + MyContentTypes[crow].ContentTypeDes.toString() + '</option>';
            }
          }
        }
        s = s + '</select></td></tr>';
        s = s + '</table>';
        s = s + '<div id="divFileAttribsSaveP" style="width:100%;text-align:center;margin-top:10px;">';
        s = s + '<button id="btnSaveFileAttributesP" class="button blue-gradient glossy"';
        s = s + ' onclick="javascript:checkItemsDataFf();return false;">Save</button>&nbsp;&nbsp;';
        s = s + '<button id="btnCancelFileAttributesP" class="button blue-gradient glossy"';
        s = s + ' onclick="javascript:cancelMultiFilesTransFf();return false;">Cancel</button>';
        s = s + '</div></div>';
        //alert(s);
        //alert(jiVoucherNbr);

        // load file contents
        switch (dtype) {
          case 'TX':
            var r = new FileReader();
            r.onload = function (e) {
              var contents = e.target.result; // contents text
              jbFLBlob[nbrFiles2] = contents;
              //alert(nbrFiles2 + '__/ ' + contents);
              nbrFiles2++;
            }
            r.readAsText(f);
            break;
          case 'AB':
            var r = new FileReader();
            r.onload = function (e) {
              var contents = e.target.result; // contents is an arraybuffer
              //alert(contents.byteLength);
              var nContents = convertArrayBufferToStringGu(contents); // convertArrayBufferToBase64Ut(contents); // change to base64 string
              //alert(nContents.length);
              nContents = base64Encode(nContents);
              //alert('To64: ' + nContents.length);
              jbFLBlob[nbrFiles2] = nContents;
              nbrFiles2++;
            }
            r.readAsArrayBuffer(f);
            break;
          case 'DU':
            var r = new FileReader();
            r.onload = function (e) {
              var contents = e.target.result; // contents Data URL
              var blb = dataURItoBlobGu(contents);
              //alert(nbrFiles + ' / ' + contents);
              jbFLBlob[nbrFiles2] = contents;
              nbrFiles2++;
            }
            r.readAsDataURL(f);
            break;
          case 'DT':
            var r = new FileReader();
            r.onload = function (e) {
              var contents = e.target.result; // contents text
              //alert(contents);
              jbFLBlob[nbrFiles2] = contents;
              nbrFiles2++;
            }
            r.readAsText(f);
            break;
          default:
            var r = new FileReader();
            r.onload = function (e) {
              var contents = e.target.result; // contents is an arraybuffer
              contents = base64EncodeGu(arrayBufferToStrUt(contents)); // change to string
              //var x = new Int32Array(contents, 0, 2);
              //alert(x.Length) ;
              jbFLBlob[nbrFiles2] = x;
              nbrFiles2++;
            }
            r.readAsArrayBuffer(f);
            break;
        }
      }
      // show dialog box
      setTimeout(showPopupEditFormNoBtnDb('divPopup', sTitle, true, true, ht, wdth, '', '', window, s, 'fadeIn', 'fadeOut', '', '', 41), 2000);
      //setTimeout(showPopupEditBoxDb('divPopup', sTitle, true, true, ht, wdth, '', '', window, s, 1, 11, 1, 'fadeIn', 'fadeOut', '', '', objid), 2000);
    }
  }
  return false;
}

function checkItemsDataFf() {
  var msg = '';
  var okay = true;
  var tokay = true;
  var sRow = '';
  for (var row = 0; row < jsFLNbrItems; row++) {
    sRow = row.toString();
    if (sRow.length === 2) { sRow = '0' + sRow; }
    if (sRow.length === 1) { sRow = '00' + sRow; }

    if (document.getElementById('selContentType' + sRow + '41').value === '0') {
      okay = false;
    };
    if (document.getElementById('txtDocTitle' + sRow + '41').value === '') {
      tokay = false;
    };
  }
  if (okay === false) {
    msg = msg + 'One or more Content Types were not selected.\n';
  }
  if (tokay === false) {
    msg = msg + 'One or more file titles are blank.\n';
  }
  if (msg !== '') {
    alert(msg);
  }
  if (okay === false || tokay === false) {
    return false;
  }
  else {
    $('#divPopup').dialog('close');
    HandleMultiFilesFf2('spnFilesProcessed', 'lblNbrFilesProcessed', 41);
  }
  return false;
}

function cancelMultiFilesTransFf() {
  $('#divPopup').dialog('close');
}

function HandleMultiFilesFf2(progobjname, lblobjname, objid) {
  jbFLContinue = true;
  jsFLHadError = false;
  document.getElementById(progobjname).style.display = 'inline';
  var ctype = '';
  var fname = '';
  var fpath = '';
  var fsize = 0;
  var ftitle = '';
  var ft;
  var ftype = '';
  var mdate = '';
  var mtype = '';
  var nbrokay = 0;
  var sRow = '';
  var val = '';
  //alert('Forming response files: ' + jsFLDocType);
  var xReq = new XMLHttpRequest();
  for (var row = 0; row < jsFLNbrItems; row++) {
    if (jbFLContinue === true) {
      sRow = row.toString();
      if (sRow.length === 2) { sRow = '0' + sRow; }
      if (sRow.length === 1) { sRow = '00' + sRow; }
      fname = jsFLItemData[row][0]; //f.name;  -- HAS NO PATH
      fsize = jsFLItemData[row][1]; //f.size;
      ftype = jsFLItemData[row][2]; //f.type;
      mtype = jsFLItemData[row][4]; //f.type;
      mdate = jsFLItemData[row][3]; //f.lastModifiedDate ? f.lastModifiedDate.toLocaleDateString() : 'n/a';
      fpath = jsFLItemData[row][6]; // path
      ftitle = document.getElementById('txtDocTitle' + sRow + objid.toString()).value;
      ctype = document.getElementById('selContentType' + sRow + objid.toString()).value;

      // load blob file contents
      var mblob = jbFLBlob[row];
      //alert(mblob.length);
      if (mblob !== undefined && mblob !== null) {
        if (mblob.length === 0) {
          alert(fname + ' was empty and could not be imported.');
        }
        else {
          // build data into a forms object
          var frmData = new FormData();
          frmData.append('XFileName', fname);
          frmData.append('FSize', fsize);
          frmData.append('FType', ftype);
          frmData.append('MType', mtype);
          frmData.append('DType', jsFLDocType);
          frmData.append('CType', ctype);
          frmData.append('DTitle', ftitle);
          frmData.append('MDate', mdate.toString());
          frmData.append('ByID', jiUserID.toString());
          frmData.append('SrcID', jiVoucherNbr.toString());
          frmData.append('FPath',fpath);
          frmData.append('fcontents', mblob);
          frmData.append('lastprop', "xBlob");
          $.ajax({
            type: 'POST',
            url: '../Shared/AJAXServices.asmx/UpdateDocumentBlob',
            data: frmData,
            processData: false,
            contentType: false,
            cache: false,
            async: false,
            success: function (json) {
              jaFLFileTransfer[row] = 1;
            },
            error: function (jqXHR, textStatus, errorThrown) {
              var msg = ParseReturnData(textStatus, errorThrown, jqXHR.responseText);
              if (msg.length > 0) {
                alert('Error: ' + msg);
              }
              else {
                nbrokay++;
              }
              alert('Error! ' + textStatus + ' - ' + errorThrown + '\n\n' + jqXHR.responseText);
            }
          });
          //alert(MyData);
          document.getElementById(lblobjname).value = (row + 1).toString();
          //alert('File loaded: ' + fname);
        }
      }
      else {
        alert('Error: blob was not established');
      }
    }
  }
  //alert('Done saving file data');

  try {
    document.getElementById(progobjname).style.display = 'none';
    // clear files list
    document.getElementById('files').value = '';
  }
  catch (ex) {
    // nothing
  }
  jbFLInDragDrop = false;
  //alert('Attachments have been transferred to the database');
  GetRequestAttachments();
  populateAttachments();
  return false;
}

function IEReadFileFf(filename) {
  try {
    var fso = new ActiveXObject("Scripting.FileSystemObject");
    var fh = fso.OpenTextFile(filename, 1);
    var contents = fh.ReadAll();
    fh.Close();
    return contents;
  }
  catch (Exception) {
    return "Cannot open file :(";
  }
}

function ParseReturnDataFf(tStat, err, jqXHR) {
  var msg = '';
  //alert('textStatus: ' + tStat);
  //alert('Err: ' + err);
  //alert('jqXHR: ' + jqXHR);
  jqXHR = jqXHR.replace('<?xml version="1.0" encoding="utf-8"?>', '');
  jqXHR = jqXHR.replace('<string xmlns="http://tempuri.org/">[{', '');
  jqXHR = jqXHR.replace('}]</string>', '');
  if (jqXHR.indexOf('","NewID":') > 0) {
    jqXHR = jqXHR.replace('","NewID":"0"', '');
    //alert('jqXHR: ' + jqXHR);
    var statusid = 0;
    if (jqXHR.indexOf('"StatusID":"0"') > -1 || jqXHR.indexOf('"StatusID":0') > -1) {
      statusid = 0;
    }
    else {
      statusid = 1;
    }
    jqXHR = jqXHR.replace('"StatusID":"0",', '').replace('"StatusID":0,', '');
    jqXHR = jqXHR.replace('"StatusID":"1",', '').replace('"StatusID":1,', '');
    jqXHR = jqXHR.replace('"StatusMsg":"', '');
    if (statusid !== 0 || jqXHR.length > 5) {
      jqXHR = jqXHR.replace('Error: ', '').replace('dbo.', '').replace('web.', '').replace('pr.', '');
      var parts = jqXHR.split('=');
      var pieces = parts[0].split(',');
      msg = 'Procedure: ' + pieces[0].toString() + '\n';
      if (pieces.length > 1) {
        msg = msg + 'Location: ' + pieces[1].toString() + '\n';
      }
      if (parts.length > 1) {
        msg = msg + 'Error: ' + parts[1].toString() + '\n';
      }
      jsFLHadError = true;
    }
  }
  else {
    jiFLObjectID = jqXHR.replace('"DocID":', '').replace(',"StatusID":0,"StatusMsg":""', '');
    jsFLHadError = false;
    //alert(jiFLObjectID);
  }
  return msg;
}

// extracts binary file contents and returns BLOB
function GetBinaryFileContentsFf(fname) {
  var blob;
  alert(fname);
  var xReq = new XMLHttpRequest();
  xReq.responseType = 'blob';
  xReq.open("GET", fname, false);
  xReq.onload = function (e) {
    blob = xReq.response;
  };
  xReq.send(null);
  return blob;
}

function abortReadFf() {
  //  reader.abort();
  jbFLContinue = false;
}

function errorHandlerFf(evt) {
  switch (evt.target.error.code) {
    case evt.target.error.NOT_FOUND_ERR:
      alert('File Not Found!');
      break;
    case evt.target.error.NOT_READABLE_ERR:
      alert('File is not readable');
      break;
    case evt.target.error.ABORT_ERR:
      break; // noop
    default:
      alert('An error occurred reading this file.');
      break;
  }
}

function getBinaryFf(file){
  var xhr = new XMLHttpRequest();  
  xhr.open("GET", file, false);  
  xhr.overrideMimeType("text/plain; charset=x-user-defined");  
  xhr.send(null);
  return xhr.responseText;
}

function GetFileAsBlobFf(fpath, fname, ftype, fsize, mdate) {
  var xhr = new XMLHttpRequest();
  xhr.open('GET', fpath, true); //'/path/to/image.png'
  xhr.responseType = 'blob';
  xhr.onload = function(e) {
    if (this.status == 200) {
      // Note: .response instead of .responseText
      var blob = new Blob([this.response], {type: 'image/png'});
      // add save here
      return blob;
    }
    else {
      alert(fname + ' failed to load');
      return false;
    }
  };
  xhr.send();
  return false;
}

function GetFileAsArrayBufferFf(fpath, fname, fsize, mdate) {
  var xhr = new XMLHttpRequest();
  xhr.open('GET', fpath, true);
  xhr.responseType = 'arraybuffer';
  xhr.onload = function(e) {
    if (this.status == 200) {
      var uInt8Array = new Uint8Array(this.response); // this.response == uInt8Array.buffer
      // var byte3 = uInt8Array[4]; // byte at offset 4
      // add save here
      return Uint8Array;
    }
    else {
      alert(fname + ' failed to load');
      return false;
    }
  };

  xhr.send();
  return false;
}

function ParseFileNameFf(fname) {
  var fn = ['', ''];
  if (!IsContentsNullUndefEmptyGu(fname)) {
  	if (fname.indexOf('.') > -1) {
  		var loc = fname.lastIndexOf('.');
  		fn[0] = fname.substr(0, loc);
  		fn[1] = fname.substr(loc + 1, fname.length - loc);
  	}
  	else {
  		fn[0] = fname;
  	}
  }
  return fn;
}

function encode64Ff(input) { 
  input = escape(input); 
  var output = ""; 
  var chr1, chr2, chr3 = ""; 
  var enc1, enc2, enc3, enc4 = ""; 
  var i = 0; 

  do { 
    chr1 = input.charCodeAt(i++); 
    chr2 = input.charCodeAt(i++); 
    chr3 = input.charCodeAt(i++); 

    enc1 = chr1 >> 2; 
    enc2 = ((chr1 & 3) << 4) | (chr2 >> 4); 
    enc3 = ((chr2 & 15) << 2) | (chr3 >> 6); 
    enc4 = chr3 & 63; 

    if (isNaN(chr2)) { 
      enc3 = enc4 = 64; 
    } else if (isNaN(chr3)) { 
      enc4 = 64; 
    } 

    output = output + keyStr.charAt(enc1) + keyStr.charAt(enc2) + keyStr.charAt(enc3) + keyStr.charAt(enc4); 
    chr1 = chr2 = chr3 = ""; 
    enc1 = enc2 = enc3 = enc4 = ""; 
  } while (i < input.length); 

  return output; 
} 

function decode64Ff(input) { 
  var output = ""; 
  var chr1, chr2, chr3 = ""; 
  var enc1, enc2, enc3, enc4 = ""; 
  var i = 0; 
  if (!IsContentsNullUndefEmptyGu(input)) {
  	// remove all characters that are not A-Z, a-z, 0-9, +, /, or = 
  	var base64test = /[^A-Za-z0-9\+\/\=]/g;
  	if (base64test.exec(input)) {
  		alert("There were invalid base64 characters in the input text.\n" + "Valid base64 characters are A-Z, a-z, 0-9, '+', '/',and '='\n" + "Expect errors in decoding.");
  	}
  	input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");

  	do {
  		enc1 = keyStr.indexOf(input.charAt(i++));
  		enc2 = keyStr.indexOf(input.charAt(i++));
  		enc3 = keyStr.indexOf(input.charAt(i++));
  		enc4 = keyStr.indexOf(input.charAt(i++));

  		chr1 = (enc1 << 2) | (enc2 >> 4);
  		chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
  		chr3 = ((enc3 & 3) << 6) | enc4;

  		output = output + String.fromCharCode(chr1);

  		if (enc3 != 64) {
  			output = output + String.fromCharCode(chr2);
  		}
  		if (enc4 != 64) {
  			output = output + String.fromCharCode(chr3);
  		}

  		chr1 = chr2 = chr3 = "";
  		enc1 = enc2 = enc3 = enc4 = "";
  	} while (i < input.length);
  	return unescape(output);
  }
  else {
  	return null;
  }
} 

function base64EncodeFf(text) {
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

function base64DecodeFf(text) {
	if (IsContentsNullUndefEmptyGu(text)) { text = '';}
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
  if (text !== '') {
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

//$('#files').bind('fileuploadprogress', function (e, data) {
//  alert('Finished');
//});
//$('#fileupload').fileupload({
//  stop: function (e) { }, // .bind('fileuploadstop', func);
//});
//(function ($) {
//  $(function () {
//    jQueryObject = $({});
//    jQueryObject.ajaxSuccess(function (event, XMLHttpRequest, ajaxOptions) {
//      /* do something whenever an ajax call is successful */
//      alert('Ended');
//    });
//  });
//})(jQuery);
//function CheckForAllFilesUpload() {
//  var okay = true;
//  for (var i = 0; i < jsFLNbrItems; i++) {
//    if (jaFLFileTransfer[fl] === 0) { okay = false; }
//  }
//  return false;
//}


