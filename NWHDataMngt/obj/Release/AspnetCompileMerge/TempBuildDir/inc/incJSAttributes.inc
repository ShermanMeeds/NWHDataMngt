<div id="divIncJSCodeAttributes" style="">
		<img id="imgSeeJSCodeAttributes" src="../../Images/script_code.png" style="width:14px;height:14px;" onclick="javascript:showJSObjectAttribs();return false;" />
		<script type="text/javascript">
			function showJSObjectAttribs() {
				var msg = 'DataTables Functions ';
				var emsg = 'NOT RUNNING.\n';
				//alert('1');
				try {
					msg = msg + 'Version ' + jsDTfVersion.toString() + ' dated ' + jsDTfVersDate.toString() + '.\n';
				}
				catch (ex) {
					msg = msg + emsg;
				}
				//alert('2');
				msg = msg + 'Date Management ';
				try {
					msg = msg + 'Functions Version ' + jsDMfVersion.toString() + ' dated ' + jsDMfVersDate.toString() + '.\n';
				}
				catch (ex) {
					msg = msg + emsg;
				}
				//alert('3');
				msg = msg + 'Dialog Functions ';
				try {
					msg = msg + 'Version ' + jiDGVersion.toString() + ' dated ' + jiDGVersDate.toString() + '.\n';
				}
				catch (ex) {
					msg = msg + emsg;
				}
				//alert('4');
				msg = msg + 'GenUtility Functions ';
				try {
					msg = msg + 'Version ' + jsGUfVersion.toString() + ' dated ' + jsGUfVersDate.toString() + '.\n';
				}
				catch (ex) {
					msg = msg + emsg;
				}
				//alert('5');
				msg = msg + 'Report Utility Functions ';
				try {
					msg = msg + 'Version ' + jsRUfVersion.toString() + ' dated ' + jsRUfVersDate.toString() + '.\n';
				}
				catch (ex) {
					msg = msg + emsg;
				}
				//alert('6');
				msg = msg + 'Text Utility Functions ';
				try {
					msg = msg + 'Version ' + jsTUfVersion.toString() + ' dated ' + jsTUfVersDate.toString() + '.\n';
				}
				catch (ex) {
					msg = msg + emsg;
				}
				//alert('7');
				msg = msg + 'WeekView Functions ';
				try {
					msg = msg + 'Version ' + jsWVfVersion.toString() + ' dated ' + jsWVfVersDate.toString() + '.\n';
				}
				catch (ex) {
					msg = msg + emsg;
				}
				alert(msg);
			}
		</script>
</div>
