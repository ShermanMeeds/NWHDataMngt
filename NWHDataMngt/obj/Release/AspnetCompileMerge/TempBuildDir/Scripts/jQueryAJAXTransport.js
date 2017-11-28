/**
*
* jquery.binarytransport.js
*
* @description. jQuery ajax transport for making binary data type requests.
* @version 1.0 
* @author Henry Algus <henryalgus@gmail.com>
*
*/

// use this transport for "binary" data type
$.ajaxTransport("+binary", function (options, originalOptions, jqXHR) {
	// check for conditions and support for blob / arraybuffer response type
	if (window.FormData && ((options.dataType && (options.dataType == 'binary')) || (options.data && ((window.ArrayBuffer && options.data instanceof ArrayBuffer) || (window.Blob && options.data instanceof Blob))))) {
		return {
			// create new XMLHttpRequest
			send: function (headers, callback) {
				// setup all variables
				var xhr = new XMLHttpRequest(),
					url = options.url,
					type = options.type,
					async = options.async || true,
					// blob or arraybuffer. Default is blob
					dataType = options.responseType || "blob",
					data = options.data || null,
					username = options.username || null,
					password = options.password || null;

				xhr.addEventListener('load', function () {
					var data = {};
					data[options.dataType] = xhr.response;
					// make callback and send data
					callback(xhr.status, xhr.statusText, data, xhr.getAllResponseHeaders());
				});

				xhr.open(type, url, async, username, password);

				// setup custom headers
				for (var i in headers) {
					xhr.setRequestHeader(i, headers[i]);
				}

				xhr.responseType = dataType;
				xhr.send(data);
			},
			abort: function () { }
		};
	}
});

//While creating request, setup dataType as "binary"
//$.ajax({
//	url: "image.png",
//	type: "GET",
//	dataType: 'binary',
//	processData: false,
//	success: function(result){
//	}
//});             
//Default response type is blob. If you want receive ArrayBuffer as a response type, you can use responseType parameter while creating an Ajax request:
//responseType:'arraybuffer', 

//It is possible to set multiple custom headers when you are making the request. To set custom headers, you can use "header" parameter and set its value as an object, which has list of headers:
//$.ajax({
//	url: "image.png",
//	type: "GET",
//	dataType: 'binary',
//	headers:{'Content-Type':'image/png','X-Requested-With':'XMLHttpRequest'},
//	processData: false,
//	success: function(result){
//	}
//}); 

//** Asynchronous or synchronous execution **
//It is possible to change execution type from asynchronous to synchrous when setting parameter "async" to false. 
//	async:false, 

// ** Login with user name and password **

//If your script needs to have authentication during the request, you can use username and password parameters.
//	username:'john',   password:'smith', 

//BinaryTransport requires XHR2 responseType, ArrayBuffer and Blob response type support from your browser, otherwise it does not work as expected. Currently most major browsers should work fine. 
//Firefox: 13.0+ Chrome: 20+ Internet Explorer: 10.0+ Safari: 6.0 Opera: 12.10 
