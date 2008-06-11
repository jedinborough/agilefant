<%@ include file="./inc/_taglibs.jsp"%>
<%@ include file="./inc/_header.jsp"%>

<aef:menu navi="timesheet" pageHierarchy="${pageHierarchy}" />
<aef:existingObjects />

<aef:productList />
<aef:userList />
<aef:teamList />
<aef:currentUser />




<h2>Timesheets</h2>

<table>
	<tbody>
		<tr>
			<td>
				<ww:form action="generateTree">
					<div id="subItems" style="margin-top: 0pt;">
						<div id="subItemHeader">				
							<table cellpadding="0" cellspacing="0">
								<tbody><tr>
									<td class="header">Query</td>
								</tr>
								</tbody>
							</table>
						</div>
						<table class="formTable">
							<tbody>
	
								<tr>
									<td>
										Backlogs
									</td>
									<td>
										<select multiple="multiple" name="backlogIds">
										<%-- Resolve if product is selected or is in 'path' and set variable 'class' accordingly--%>
												<c:forEach items="${productList}" var="product">
												<c:if test="${aef:listContains(selected, product.id)}">
													<option value="${product.id}" selected="selected">${aef:out(product.name)}</option>
												</c:if>	
												<c:if test="${!aef:listContains(selected, product.id)}">
													<option value="${product.id}">${aef:out(product.name)}</option>
												</c:if>
												<c:forEach items="${product.projects}" var="project">
													<c:if test="${aef:listContains(selected, project.id)}">						
														<option value="${project.id}" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;${aef:out(project.name)}</option>
													</c:if>
													<c:if test="${!aef:listContains(selected, project.id)}">						
														<option value="${project.id}">&nbsp;&nbsp;&nbsp;&nbsp;${aef:out(project.name)}</option>
													</c:if>
									                	<c:forEach items="${project.iterations}" var="it">
									                		<c:if test="${aef:listContains(selected, it.id)}">
	                    										<option value="${it.id}" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${aef:out(it.name)}</option>
	                										</c:if>
	                										<c:if test="${!aef:listContains(selected, it.id)}">
	                    										<option value="${it.id}">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${aef:out(it.name)}</option>
	                										</c:if>
	                									</c:forEach>
	                							</c:forEach>
	            							</c:forEach>
			
										</select>
									</td>
								</tr>
								<!-- Interval selection -->			
								<tr>
									<td>Interval</td>
					
									<td colspan="2">
										<script type="text/javascript">
											function addZero($string) {
												if($string < 10) {
													return '0' + $string;
												} else {
													return $string;
												}
											}
			
											function change_selected_interval(value) {
												var startDate = document.getElementById('effStartDate');
												var endDate = document.getElementById('effEndDate');
												// Current timestamp
												var now = new Date();
												
												// Yesterday's timestamp
												var yesterday = new Date(now.getTime() - 86400000);
												
												// This monday
												var daysfrommonday = 0;
												if(now.getDay() == 0) {
													daysfrommonday = 6;
												} else {
													daysfrommonday = now.getDay() - 1;
												}
												var thismonday = new Date(now.getTime() - (86400000 * daysfrommonday));
												
												// Last week's monday
												var lastmonday = new Date(thismonday.getTime() - (86400000 * 7));
												
												// Last month
												var lastmonth = new Date();
												if(now.getMonth() == 0) {
													lastmonth.setMonth(11)
													lastmonth.setFullYear(now.getFullYear() - 1);
												} else {
													lastmonth.setMonth(now.getMonth() - 1)
												}
												
												
												if (value == 'TODAY') {
													startDate.value = now.getFullYear() + '-' + addZero(now.getMonth() + 1) + '-' + addZero(now.getDate()) + ' 00:00';
													endDate.value   = now.getFullYear() + '-' + addZero(now.getMonth() + 1) + '-' + addZero(now.getDate()) + ' ' + addZero(now.getHours()) + ':' + addZero(now.getMinutes());
												} else if (value == 'YESTERDAY') {
													startDate.value = yesterday.getFullYear() + '-' + addZero(yesterday.getMonth() + 1) + '-' + addZero(yesterday.getDate()) + ' 00:00';
													endDate.value   = now.getFullYear() + '-' + addZero(now.getMonth() + 1) + '-' + addZero(now.getDate()) + ' 00:00';
												} else if (value == 'THIS_WEEK') {
													startDate.value = thismonday.getFullYear() + '-' + addZero(thismonday.getMonth() + 1) + '-' + addZero(thismonday.getDate()) + ' 00:00';
													endDate.value   = now.getFullYear() + '-' + addZero(now.getMonth() + 1) + '-' + addZero(now.getDate()) + ' ' + addZero(now.getHours()) + ':' + addZero(now.getMinutes());
												} else if (value == 'LAST_WEEK') {
													startDate.value = lastmonday.getFullYear() + '-' + addZero(lastmonday.getMonth() + 1) + '-' + addZero(lastmonday.getDate()) + ' 00:00';
													endDate.value   = thismonday.getFullYear() + '-' + addZero(thismonday.getMonth() + 1) + '-' + addZero(thismonday.getDate()) + ' 00:00';
												} else if (value == 'THIS_MONTH') {
													startDate.value = now.getFullYear() + '-' + addZero(now.getMonth() + 1) + '-01 00:00';
													endDate.value   = now.getFullYear() + '-' + addZero(now.getMonth() + 1) + '-' + addZero(now.getDate()) + ' ' + addZero(now.getHours()) + ':' + addZero(now.getMinutes());
												} else if (value == 'LAST_MONTH') {
													startDate.value = lastmonth.getFullYear() + '-' + addZero(lastmonth.getMonth() + 1) + '-01 00:00';
													endDate.value   = now.getFullYear() + '-' + addZero(now.getMonth() + 1) + '-01 00:00';
												} else if (value == 'THIS_YEAR') {
													startDate.value = now.getFullYear() + '-01-01 00:00';
													endDate.value   = now.getFullYear() + '-' + addZero(now.getMonth() + 1) + '-' + addZero(now.getDate()) + ' ' + addZero(now.getHours()) + ':' + addZero(now.getMinutes());
												} else if (value == 'LAST_YEAR') {
													startDate.value = (now.getFullYear() - 1) + '-01-01 00:00';
													endDate.value   = now.getFullYear() + '-01-01 00:00';
												} else if (value == 'NO_INTERVAL') {
													startDate.value = '';
													endDate.value   = '';
												}
											}
											$(document).ready( function() {
												var interval = document.getElementById('interval');
												<ww:set name="currently" value="#attr.interval" />
												var current = "${currently}";
												if (current == 'TODAY') {
													change_selected_interval('TODAY');
												} else if (current == 'YESTERDAY') {
													change_selected_interval('YESTERDAY');
												} else if (current == 'THIS_WEEK') {
													change_selected_interval('THIS_WEEK');
												} else if (current == 'LAST_WEEK') {
													change_selected_interval('LAST_WEEK');
												} else if (current == 'THIS_MONTH') {
													change_selected_interval('THIS_MONTH');
												} else if (current == 'LAST_MONTH') {
													change_selected_interval('LAST_MONTH');
												} else if (current == 'THIS_YEAR') {
													change_selected_interval('THIS_YEAR');
												} else if (current == 'LAST_YEAR') {
													change_selected_interval('LAST_YEAR');
												} else if (current == 'NO_INTERVAL') {
													change_selected_interval('NO_INTERVAL');
												} else {
													change_selected_interval('TODAY');
												}
													
											});
										</script> 
										<%--REFACTOR PLZ--%>
										<select name="interval" id="interval" onchange="change_selected_interval(this.value);">
											<c:if test="${empty interval || interval == 'TODAY'}">
												<option value="TODAY" selected="selected">Today</option>
												<option value="YESTERDAY">Yesterday</option>
												<option value="THIS_WEEK">This week</option>
												<option value="LAST_WEEK">Last week</option>
												<option value="THIS_MONTH">This month</option>
												<option value="LAST_MONTH">Last month</option>
												<option value="THIS_YEAR">This year</option>
												<option value="LAST_YEAR">Last year</option>
												<option value="NO_INTERVAL">(All past entries)</option>
											</c:if>
											<c:if test="${interval == 'YESTERDAY'}">
												<option value="TODAY">Today</option>
												<option value="YESTERDAY" selected="selected">Yesterday</option>
												<option value="THIS_WEEK">This week</option>
												<option value="LAST_WEEK">Last week</option>
												<option value="THIS_MONTH">This month</option>
												<option value="LAST_MONTH">Last month</option>
												<option value="THIS_YEAR">This year</option>
												<option value="LAST_YEAR">Last year</option>
												<option value="NO_INTERVAL">(All past entries)</option>
											</c:if>
											<c:if test="${interval == 'THIS_WEEK'}">
												<option value="TODAY">Today</option>
												<option value="YESTERDAY">Yesterday</option>
												<option value="THIS_WEEK" selected="selected">This week</option>
												<option value="LAST_WEEK">Last week</option>
												<option value="THIS_MONTH">This month</option>
												<option value="LAST_MONTH">Last month</option>
												<option value="THIS_YEAR">This year</option>
												<option value="LAST_YEAR">Last year</option>
												<option value="NO_INTERVAL">(All past entries)</option>
											</c:if>
											<c:if test="${interval == 'LAST_WEEK'}">
												<option value="TODAY">Today</option>
												<option value="YESTERDAY">Yesterday</option>
												<option value="THIS_WEEK">This week</option>
												<option value="LAST_WEEK" selected="selected">Last week</option>
												<option value="THIS_MONTH">This month</option>
												<option value="LAST_MONTH">Last month</option>
												<option value="THIS_YEAR">This year</option>
												<option value="LAST_YEAR">Last year</option>
												<option value="NO_INTERVAL">(All past entries)</option>											</c:if>
											<c:if test="${interval == 'THIS_MONTH'}">
												<option value="TODAY">Today</option>
												<option value="YESTERDAY">Yesterday</option>
												<option value="THIS_WEEK">This week</option>
												<option value="LAST_WEEK">Last week</option>
												<option value="THIS_MONTH" selected="selected">This month</option>
												<option value="LAST_MONTH">Last month</option>
												<option value="THIS_YEAR">This year</option>
												<option value="LAST_YEAR">Last year</option>
												<option value="NO_INTERVAL">(All past entries)</option>
											</c:if>
											<c:if test="${interval == 'LAST_MONTH'}">
												<option value="TODAY">Today</option>
												<option value="YESTERDAY">Yesterday</option>
												<option value="THIS_WEEK">This week</option>
												<option value="LAST_WEEK">Last week</option>
												<option value="THIS_MONTH">This month</option>
												<option value="LAST_MONTH" selected="selected">Last month</option>
												<option value="THIS_YEAR">This year</option>
												<option value="LAST_YEAR">Last year</option>
												<option value="NO_INTERVAL">(All past entries)</option>
											</c:if>
											<c:if test="${interval == 'THIS_YEAR'}">
												<option value="TODAY">Today</option>
												<option value="YESTERDAY">Yesterday</option>
												<option value="THIS_WEEK">This week</option>
												<option value="LAST_WEEK">Last week</option>
												<option value="THIS_MONTH">This month</option>
												<option value="LAST_MONTH">Last month</option>
												<option value="THIS_YEAR" selected="selected">This year</option>
												<option value="LAST_YEAR">Last year</option>
												<option value="NO_INTERVAL">(All past entries)</option>
											</c:if>
											<c:if test="${interval == 'LAST_YEAR'}">
												<option value="TODAY">Today</option>
												<option value="YESTERDAY">Yesterday</option>
												<option value="THIS_WEEK">This week</option>
												<option value="LAST_WEEK">Last week</option>
												<option value="THIS_MONTH">This month</option>
												<option value="LAST_MONTH">Last month</option>
												<option value="THIS_YEAR">This year</option>
												<option value="LAST_YEAR" selected="selected">Last year</option>
												<option value="NO_INTERVAL">(All past entries)</option>
											</c:if>
											<c:if test="${interval == 'NO_INTERVAL'}">
												<option value="TODAY">Today</option>
												<option value="YESTERDAY">Yesterday</option>
												<option value="THIS_WEEK">This week</option>
												<option value="LAST_WEEK">Last week</option>
												<option value="THIS_MONTH">This month</option>
												<option value="LAST_MONTH">Last month</option>
												<option value="THIS_YEAR">This year</option>
												<option value="LAST_YEAR">Last year</option>
												<option value="NO_INTERVAL" selected="selected">(All past entries)</option>
											</c:if>
										</select>
									</td>
								</tr>
								<!--  Start date -->
								<tr>				
									<td>Start date</td>
									<td>
										<ww:datepicker size="15" showstime="false"
	                       					format="%{getText('webwork.datepicker.format')}" id="effStartDate" name="startDate" value=""/>
									</td>
								</tr>
								<!--  End date -->
								<tr>				
									<td>End date</td>
									<td>
	               						<ww:datepicker size="15" showstime="false"
	                       					format="%{getText('webwork.datepicker.format')}" id="effEndDate" name="endDate" value=""/>
									</td>
								</tr>
								<!--  User selection -->				
								<tr>
									<td>Active users</td>
					
				
									<td><c:set var="divId" value="1" scope="page" />
	
	                    				<div id="assigneesLink">
	                    					<a href="javascript:toggleDiv(${divId});">
	                        					<img src="static/img/users.png" />
	                        					select
	                    					</a>
	                    				</div>
	                        
	                    				<div id="${divId}" class="userSelector" style="display: none;">
	                 
	                    					<div id="userselect" class="userSelector">
	                    						<div class="left">
	                    							<label>Enabled users</label>
	                    							<ul class="users_0"></ul>
	                    		
	                    							<label>Disabled users</label>
	                    							<ul class="users_1"></ul>
	                    							
	                    						</div>
	                        					<div class="right">
	                            					<label>Teams</label>
	                            					<ul class="groups" />
	                    						</div>
	                    						<script type="text/javascript">
	                        						$(document).ready( function() {
	                            						<aef:teamList />
	                            						<aef:enabledUserList />
	                            						<aef:userList />
	                            						<ww:set name="teamList" value="#attr.teamList" />
	                            						<ww:set name="enabledUserList" value="#attr.enabledUserList" />
	                            						<ww:set name="userList" value="#attr.userList" />
	                            						<ww:set name="selectedID" value="#attr.selUId" />
	                            						var teams = [<aef:teamJson items="${teamList}" />];
	                            						var preferred = [<aef:userJson items="${enabledUserList}" />];
	                           						 	var other = [<aef:userJson items="${aef:listSubstract(userList, enabledUserList)}" />];
	                           						 	<c:if test="${!empty selectedID}">
	                            							var selected = ${selectedID};
	                            						</c:if>
	                            						<c:if test="${empty selectedID}">
	                            							var selected = [];
	                            						</c:if>
	                           	 						$('#userselect').multiuserselect({users: [preferred, other], groups: teams, root: $('#userselect')}).selectusers(selected);
	                        						});
	                        					</script>
	                    					</div>
	                    				</div>
	                    			</td>
								</tr>
								<!-- Submit button -->
								<tr>
									<td></td>
									<td>
										<ww:submit value="Calculate" />
									</td>
								</tr>
							</tbody>
						</table>
					</ww:form>
				</div>
			</td>
		</tr>
	</tbody>
</table>
<%---UGLY!!! Refactor this---%>
<style>

table.reportTable {
	width:100%;
	padding:3px;
}

table.reportTable tr {
	
}

table.reportTable tr th {
	text-align:left;
	background-color:#b2b2b2;
	padding:4px;
}

table.reportTable tr th.product {
	text-align:left;
	background-color:#cccccc;
	padding:4px;
	font-weight:normal;
	border-top:1px solid #000000;
}

table.reportTable tr th.project {
	text-align:left;
	background-color:#dddddd;
	padding:4px;
	font-weight:normal;
}

table.reportTable tr th.iteration {
	text-align:left;
	background-color:#e6e6e6;
	padding:4px;
	font-weight:normal;
}

table.reportTable tr th.backlogitem {
	text-align:left;
	background-color:#f5f5f5;
	padding:4px;
	font-weight:normal;
}

table.reportTable tr.backlogitem {
	display:none;
}

table.reportTable tr.special th {
	background-color:#e6eee6 !important;
	background-color:#e4ecff !important;
}

table.reportTable tr.special th.first {
	background-image:url(static/img/special-hour-entry-report.gif);
	background-repeat:no-repeat;
	background-position:16px 9px;
	padding-left:31px;
}

table.reportTable tr.special.backlogitemshead th.first {
	font-weight:normal;
}

table.reportTable tr.special.hourentryhead th {
	border-top:0px solid #000000;
}

tr.leftborder .first {
	border-left:4px solid #b2d8b2; /* #dddda8 */
	border-left:4px solid #b2caff;
}

tr.leftborder {
	display:none;
}

table.reportTable tr th.backlogitem a,
table.reportTable tr th.iteration a,
table.reportTable tr th.project a,
table.reportTable tr th.product a {
	text-decoration:none;
	color:blue;
	cursor:pointer;
}

table.reportTable tr th.backlogitem a:hover,
table.reportTable tr th.iteration a:hover,
table.reportTable tr th.project a:hover,
table.reportTable tr th.product a:hover {
	text-decoration:underline;
	color:blue;
}

table.reportTable tr th.backlogitem.second {
	font-weight:bold;
}

table.reportTable tr th.backlogitem.third {
	font-weight:bold;
}

table.reportTable tr.hourentries {
	display:none;
}

table.reportTable tr td.hourentry {
	text-align:left;
	background-color:#ffffff;
	padding:4px;
	font-weight:normal;
}

table.reportTable tr td.hourentry.first {
	padding-left:30px;
}

table.reportTable tr.total th.total {
	border-top:1px solid #000000;
}

				</style>


<%--/UGLY!!! --%>

<%--show the tree--%>
<c:if test="${!empty products}">
	<table style="margin-top:20px;">
		<tbody>
			<tr>
				<td>
					<div id="subItems" style="margin-top: 0pt;">
						<div id="subItemHeader">
							<table>
								<tbody>
									<tr>
										<td class="header">Entries</td>
										<td class="icons">
											<a onclick="javascript:$('.toggleall').show();" style="cursor:pointer;"><img src="static/img/plus.png" alt="Expand" title="Expand" height="18" width="18"></a>
											<a onclick="javascript:$('.toggleall').hide();" style="cursor:pointer;"><img src="static/img/minus.png" alt="Collapse" title="Collapse" height="18" width="18"></a>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div id="subItemContent">
						<div id="listProjectHours" style="">
						<c:set var="totalSum" value="${null}" />
						<table class="reportTable" cellpadding="0" cellspacing="0">
							<tbody>
								<tr>
									<th>Name / Comment</th>
									<th>&nbsp;</th>
									<th>&nbsp;</th>
									<th style="width:120px;">Effort spent</th>
								</tr>
								
								<c:forEach items="${products}" var="prod">
									<c:set var="divId" value="${divId + 1}" scope="page" />
									<tr>
										<c:if test="${!(empty prod.hourEntries && empty prod.childBacklogItems)}">
										<th class="product first" colspan="3"><a onclick="javascript:if($('.backlogitem.prod${divId}').is(':visible')) { $('.prod${divId}').hide(); } else { $('.backlogitem.prod${divId}').show(); }"><c:out value="${prod.backlog.name}"/></a></th>
										</c:if>
										<c:if test="${empty prod.hourEntries && empty prod.childBacklogItems}">
										<th class="product first" colspan="3"><c:out value="${prod.backlog.name}"/></th>
										</c:if>
										<th class="product"><c:out value="${prod.hourTotal}"/></th> 
										<c:set var="totalSum" value="${aef:calculateAFTimeSum(totalSum, prod.hourTotal)}" />
									</tr>
									<c:if test="${!empty prod.hourEntries}">
										<c:set var="heDivId" value="${heDivId + 1}" scope="page" />
										<tr class="backlogitem prod${divId} special hourentryhead leftborder toggleall">
											<th class="backlogitem first" colspan="3"><a onclick="javascript:$('.hour${heDivId}').toggle();">Logged effort</a></th>
											<th class="backlogitem fourth">summa</th>
										</tr>
										<c:forEach items="${prod.hourEntries}" var="he">
											<tr class="hourentries hour${heDivId} prod${divId} leftborder toggleall">
												<td class="hourentry first"><c:out value="${he.description}"/></td>
												<td class="hourentry second"><ww:date name="#attr.he.date" format="dd.MM.yyyy HH:mm" /></td>
												<td class="hourentry third">${aef:html(he.user.fullName)}</td>
												<td class="hourentry fourth">${aef:html(he.timeSpent)}</td>
											</tr>
										</c:forEach>
									</c:if>
									<c:if test="${!empty prod.childBacklogItems}">
										<tr class="backlogitem prod${divId} special backlogitemshead leftborder toggleall">
											<th class="backlogitem first" colspan="3">Backlog items</th>
											<th class="backlogitem fourth">summa</th>
										</tr>
										<c:forEach items="${prod.childBacklogItems}" var="bli">
											<c:set var="heDivId" value="${heDivId + 1}" scope="page" />
											<tr class="backlogitem prod${divId} leftborder toggleall">
												<c:if test="${!empty bli.hourEntries}">
													<th class="backlogitem first" colspan="3">&nbsp; &nbsp; &raquo; <a onclick="javascript:$('.hour${heDivId}').toggle();"><c:out value="${bli.backlogItem.name}"/></a></th>
												</c:if>
												<c:if test="${empty bli.hourEntries}">
													<th class="backlogitem first" colspan="3">&nbsp; &nbsp; &raquo; <c:out value="${bli.backlogItem.name}"/></th>
												</c:if>
												<th class="backlogitem"><c:out value="${bli.hourTotal}"/></th>
											</tr>
											<c:forEach items="${bli.hourEntries}" var="he">
												<tr class="hourentries hour${heDivId} prod${divId} leftborder toggleall">
													<td class="hourentry first"><c:out value="${he.description}"/></td>
													<td class="hourentry second"><ww:date name="#attr.he.date" format="dd.MM.yyyy HH:mm" /></td>
													<td class="hourentry third">${aef:html(he.user.fullName)}</td>
													<td class="hourentry fourth">${aef:html(he.timeSpent)}</td>
												</tr>
											</c:forEach>
										</c:forEach>										
									</c:if>
									<c:if test="${!empty prod.childBacklogs}">
										<c:forEach items="${prod.childBacklogs}" var="proj">
											<c:set var="divId" value="${divId + 1}" scope="page" />
											<tr>
												<c:if test="${!(empty proj.hourEntries && empty proj.childBacklogItems)}">
												<th class="project first" colspan="3">&raquo; <a onclick="javascript:if($('.backlogitem.proj${divId}').is(':visible')) { $('.proj${divId}').hide(); } else { $('.backlogitem.proj${divId}').show(); }"><c:out value="${proj.backlog.name}"/></a></th>
												</c:if>
												<c:if test="${empty proj.hourEntries && empty proj.childBacklogItems}">
												<th class="project first" colspan="3">&raquo; <c:out value="${proj.backlog.name}"/></th>
												</c:if>
												<th class="project"><c:out value="${proj.hourTotal}"/></th>
											</tr>
											<c:if test="${!empty proj.hourEntries}">
												<c:set var="heDivId" value="${heDivId + 1}" scope="page" />
												<tr class="backlogitem proj${divId} special hourentryhead leftborder toggleall">
														<th class="backlogitem first" colspan="3"><a onclick="javascript:$('.hour${heDivId}').toggle();">Logged effort</a></th>
														<th class="backlogitem fourth">summa</th>
												</tr>
												<c:forEach items="${proj.hourEntries}" var="he">
													<tr class="hourentries hour${heDivId} proj${divId} leftborder toggleall">
														<td class="hourentry first"><c:out value="${he.description}"/></td>
														<td class="hourentry second"><ww:date name="#attr.he.date" format="dd.MM.yyyy HH:mm" /></td>
														<td class="hourentry third">${aef:html(he.user.fullName)}</td>
														<td class="hourentry fourth">${aef:html(he.timeSpent)}</td>
													</tr>
												</c:forEach>
											</c:if>
											<c:if test="${!empty proj.childBacklogItems}">
												<tr class="backlogitem proj${divId} special backlogitemshead leftborder toggleall">
													<th class="backlogitem first" colspan="3">Backlog items</th>
													<th class="backlogitem fourth">summa</th>
												</tr>
												<c:forEach items="${proj.childBacklogItems}" var="bli">
													<c:set var="heDivId" value="${heDivId + 1}" scope="page" />
													<tr class="backlogitem proj${divId} leftborder toggleall">
														<c:if test="${!empty bli.hourEntries}">
															<th class="backlogitem first" colspan="3">&nbsp; &nbsp; &raquo; <a onclick="javascript:$('.hour${heDivId}').toggle();"><c:out value="${bli.backlogItem.name}"/></a></th>
														</c:if>
														<c:if test="${empty bli.hourEntries}">
															<th class="backlogitem first" colspan="3">&nbsp; &nbsp; &raquo; <c:out value="${bli.backlogItem.name}"/></th>
														</c:if>
														<th class="backlogitem"><c:out value="${bli.hourTotal}"/></th>
													</tr>
													<c:forEach items="${bli.hourEntries}" var="he">
														<tr class="hourentries hour${heDivId} proj${divId} leftborder toggleall">
															<td class="hourentry first"><c:out value="${he.description}"/></td>
															<td class="hourentry second"><ww:date name="#attr.he.date" format="dd.MM.yyyy HH:mm" /></td>
															<td class="hourentry third">${aef:html(he.user.fullName)}</td>
															<td class="hourentry fourth">${aef:html(he.timeSpent)}</td>
														</tr>
													</c:forEach>
												</c:forEach>										
											</c:if>
											<c:if test="${!empty proj.childBacklogs}">
												<c:forEach items="${proj.childBacklogs}" var="iter">
													<c:set var="divId" value="${divId + 1}" scope="page" />
													<tr>
														<c:if test="${!(empty iter.hourEntries && empty iter.childBacklogItems)}">
														<th class="iteration first" colspan="3">&nbsp;&nbsp;&raquo; <a onclick="javascript:if($('.backlogitem.iter${divId}').is(':visible')) { $('.iter${divId}').hide(); } else { $('.backlogitem.iter${divId}').show(); }"><c:out value="${iter.backlog.name}"/></a></th>
														</c:if>
														<c:if test="${empty iter.hourEntries && empty iter.childBacklogItems}">
														<th class="iteration first" colspan="3">&nbsp;&nbsp;&raquo; <c:out value="${iter.backlog.name}"/></th>
														</c:if>
														<th class="iteration"><c:out value="${iter.hourTotal}"/></th>
													</tr>
													<c:if test="${!empty iter.hourEntries}">
														<c:set var="heDivId" value="${heDivId + 1}" scope="page" />
														<tr class="backlogitem proj${divId} special hourentryhead leftborder toggleall">
																<th class="backlogitem first" colspan="3"><a onclick="javascript:$('.hour${heDivId}').toggle();">Logged effort</a></th>
																<th class="backlogitem fourth">summa</th>
														</tr>
														<c:forEach items="${iter.hourEntries}" var="he">
															<tr class="hourentries hour${heDivId} proj${divId} leftborder toggleall">
																<td class="hourentry first"><c:out value="${he.description}"/></td>
																<td class="hourentry second"><ww:date name="#attr.he.date" format="dd.MM.yyyy HH:mm" /></td>
																<td class="hourentry third">${aef:html(he.user.fullName)}</td>
																<td class="hourentry fourth">${aef:html(he.timeSpent)}</td>
															</tr>
														</c:forEach>
													</c:if>
													<c:if test="${!empty iter.childBacklogItems}">
														<c:forEach items="${iter.childBacklogItems}" var="bli">
															<c:set var="heDivId" value="${heDivId + 1}" scope="page" />
															<tr class="backlogitem iter${divId} toggleall">
																<c:if test="${!empty bli.hourEntries}">
																<th class="backlogitem first" colspan="3">&nbsp; &nbsp; &raquo; <a onclick="javascript:$('.hour${heDivId}').toggle();"><c:out value="${bli.backlogItem.name}"/></a></th>
																</c:if>
																<c:if test="${empty bli.hourEntries}">
																<th class="backlogitem first" colspan="3">&nbsp; &nbsp; &raquo; <c:out value="${bli.backlogItem.name}"/></th>
																</c:if>
																<th class="backlogitem"><c:out value="${bli.hourTotal}"/></th>
															</tr>
															<c:forEach items="${bli.hourEntries}" var="he">
																<tr class="hourentries hour${heDivId} iter${divId} toggleall">
																	<td class="hourentry first"><c:out value="${he.description}"/></td>
																	<td class="hourentry second"><ww:date name="#attr.he.date" format="dd.MM.yyyy HH:mm" /></td>
																	<td class="hourentry third">${aef:html(he.user.fullName)}</td>
																	<td class="hourentry fourth">${aef:html(he.timeSpent)}</td>
																</tr>
															</c:forEach>
														</c:forEach>										
													</c:if>													
												</c:forEach>
											</c:if>
										</c:forEach>
									</c:if>
								</c:forEach>
								<tr class="total">
									<th class="total">Query total</th>
									<th class="total">&nbsp;</th>
									<th class="total">&nbsp;</th>
									<th class="total"><c:out value="${totalSum}"/></th>
								</tr>
							</tbody>
						</table>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</c:if>
<%@ include file="./inc/_footer.jsp"%>