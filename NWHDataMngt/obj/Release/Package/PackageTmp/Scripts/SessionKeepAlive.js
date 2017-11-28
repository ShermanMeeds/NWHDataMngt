SessionKeepAlive =
 {
	//Delay set to 10 minutes
 	delay: 600000,
 	url: undefined,
 	run: function () {
 		if (this.url) {
 			$.get(this.url + "?d=" + escape(new Date().getTime()));
 			setTimeout("SessionKeepAlive.run()", this.delay);
 		}
 	},
 	start: function (delay, url) {
 		// Set ajax timeout to 2 seconds
 		$.ajaxSetup({ timeout: 2000 });

 		// Convert delay to millis
 		this.delay = parseInt(delay) * 60000;
 		this.url = url;
 		setTimeout("SessionKeepAlive.run()", this.delay);
 	}
 };