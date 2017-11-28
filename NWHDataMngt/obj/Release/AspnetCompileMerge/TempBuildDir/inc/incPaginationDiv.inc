		<div id="divTablePageBar" style="width:99%;text-align:center;display:none;margin-top:6px;font-family:Calibri;vertical-align:middle;">
			<div id="divTableContainer1" class="effect1" style="border:1px solid lightgray;width:320px;line-height:14px;height:24px;margin: auto auto;">
				<table style="border:none;padding-left:20px;padding-right:20px;border-spacing:0px;height:24px;margin: auto auto;">
					<tr>
						<td style="vertical-align:middle;">
							<a href="#" id="lnkPageFirst" onclick="javascript:GoToNewPagePj(1, 0, '');return false" style="line-height:12px;height:18px;width:30px;font-size:20pt;text-decoration:none;">&#171;</a>&nbsp;
						</td>
						<td style="vertical-align:middle;">
							<a href="#" id="lnkPagePrev" onclick="javascript:GoToNewPagePj(1, 1, '');return false;" style="line-height:12px;height:18px;width:30px;font-size:20pt;text-decoration:none;">&lsaquo;</a>&nbsp;&nbsp;&nbsp;
						</td>
						<td style="vertical-align:middle;">
							Page&nbsp;<label id="lblPageNbr"></label>&nbsp;of&nbsp;<label id="lblMaxPgNbr"></label>&nbsp;&nbsp;&nbsp;
						</td>
						<td style="vertical-align:middle;">
							<a href="#" id="lnkPageNext" onclick="javascript:GoToNewPagePj(1, 2, '');return false;" style="line-height:12px;height:18px;width:30px;font-size:20pt;text-decoration:none;">&rsaquo;</a>&nbsp;
						</td>
						<td style="vertical-align:middle;">
							<a href="#" id="lnkPageLast" onclick="javascript:GoToNewPagePj(1,3, '');return false;" style="line-height:12px;height:18px;width:30px;font-size:20pt;text-decoration:none;">&#187;</a>&nbsp;&nbsp;&nbsp;
						</td>
						<td style="vertical-align:middle;">
							Goto&nbsp;Page:&nbsp;<input type="text" id="txtGotoPgNbr" onblur="javascript:GoToNewPagePj(1, 4, this.value);" style="width:20px;height:18px;line-height:16px;padding:0px;margin:0px;" />
						</td>
					</tr>
				</table>
			</div>
		</div>
