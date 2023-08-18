<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<style>
.form-check-label {
	padding-left: 20px;
}
.eventRemoveBtn{
	float: right;
	display: inline-block;
	width: 23px;
	height: 23px;
	
}
#new-event-content{
	margin: 20px 0;
	resize: none;
}
 .fc-event {
    text-align: center;
  }
</style>
<section class="content-header">
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h1>Calendar</h1>
			</div>
			<div class="col-sm-6">
				<ol class="breadcrumb float-sm-right">
					<li class="breadcrumb-item"><a href="#">Home</a></li>
					<li class="breadcrumb-item active">Calendar</li>
				</ol>
			</div>
		</div>
	</div>
	<!-- /.container-fluid -->
</section>
<section class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-3">
				<div class="sticky-top mb-3">
					<div class="card">
						<div class="card-header">
							<h4 class="card-title">Draggable Events</h4>
						</div>
						<div class="card-body">
							<!-- the events -->
							<div id="external-events">
								<c:if test="${not empty undoEventList }">
									<c:forEach items="${undoEventList }" var="event">
										<div class="external-event ui-draggable ui-draggable-handle" 
										data-schdltype="${event.schdlType }" data-schdlid="${event.schdlId }" data-empid="${event.empId}"
										style="background-color: ${event.schdlColor }; border-color: ${event.schdlColor }; color: rgb(255, 255, 255); position: relative;"><span>${event.schdlTtl }</span><img src="/resources/img/xbtn.png" class="eventRemoveBtn"></div>
									</c:forEach>
								</c:if>
								<div class="checkbox">
								</div>
							</div>
						</div>
						<!-- /.card-body -->
					</div>
					<!-- /.card -->
					<div class="card">
						<div class="card-header">
							<h3 class="card-title">Create Event</h3>
						</div>
						<div class="card-body">
							<div class="btn-group" style="width: 100%; margin-bottom: 10px;">
								<ul class="fc-color-picker" id="color-chooser">
									<li><a class="text-primary" href="#"><i
											class="fas fa-square"></i></a></li>
									<li><a class="text-warning" href="#"><i
											class="fas fa-square"></i></a></li>
									<li><a class="text-success" href="#"><i
											class="fas fa-square"></i></a></li>
									<li><a class="text-danger" href="#"><i
											class="fas fa-square"></i></a></li>
									<li><a class="text-muted" href="#"><i
											class="fas fa-square"></i></a></li>
								</ul>
							</div>
							<!-- /btn-group -->

							<input id="new-event" type="text" class="form-control"
								placeholder="Event Title"> 
							<textarea id="new-event-content" class="form-control col-sm-12" rows="10" placeholder="Event Content"></textarea>
							<label class="form-check-label"> <input type="radio"
								name="schdlType" class="form-check-input" value="e">개인
							</label> <label class="form-check-label"> <input type="radio"
								name="schdlType" class="form-check-input" value="d">부서
							</label>
							<button id="add-new-event" type="button" class="btn btn-primary">Add</button>
							<!-- /btn-group -->
						</div>
					</div>
				</div>
			</div>
			<!-- /.col -->
			<div class="col-md-9">
				<div class="card card-primary">
					<div class="card-body p-0">
						<!-- THE CALENDAR -->
						<div id="calendar"
							class="fc fc-media-screen fc-direction-ltr fc-theme-bootstrap">
							<div class="fc-header-toolbar fc-toolbar fc-toolbar-ltr">
								<div class="fc-toolbar-chunk">
									<div class="btn-group">
										<button type="button" title="Previous month"
											aria-pressed="false" class="fc-prev-button btn btn-primary">
											<span class="fa fa-chevron-left"></span>
										</button>
										<button type="button" title="Next month" aria-pressed="false"
											class="fc-next-button btn btn-primary">
											<span class="fa fa-chevron-right"></span>
										</button>
									</div>
									<button type="button" title="This month" disabled=""
										aria-pressed="false" class="fc-today-button btn btn-primary">today</button>
								</div>
								<div class="fc-toolbar-chunk">
									<h2 class="fc-toolbar-title" id="fc-dom-1">June 2023</h2>
								</div>
								<div class="fc-toolbar-chunk">
									<div class="btn-group">
										<button type="button" title="month view" aria-pressed="true"
											class="fc-dayGridMonth-button btn btn-primary active">month</button>
										<button type="button" title="week view" aria-pressed="false"
											class="fc-timeGridWeek-button btn btn-primary">week</button>
										<button type="button" title="day view" aria-pressed="false"
											class="fc-timeGridDay-button btn btn-primary">day</button>
									</div>
								</div>
							</div>
							<div aria-labelledby="fc-dom-1"
								class="fc-view-harness fc-view-harness-active"
								style="height: 409.63px;">
								<div class="fc-daygrid fc-dayGridMonth-view fc-view">
									<table role="grid"
										class="fc-scrollgrid table-bordered fc-scrollgrid-liquid">
										<thead role="rowgroup">
											<tr role="presentation"
												class="fc-scrollgrid-section fc-scrollgrid-section-header ">
												<th role="presentation"><div
														class="fc-scroller-harness">
														<div class="fc-scroller" style="overflow: hidden;">
															<table role="presentation" class="fc-col-header "
																style="width: 551px;">
																<colgroup></colgroup>
																<thead role="presentation">
																	<tr role="row">
																		<th role="columnheader"
																			class="fc-col-header-cell fc-day fc-day-sun"><div
																				class="fc-scrollgrid-sync-inner">
																				<a aria-label="Sunday"
																					class="fc-col-header-cell-cushion ">Sun</a>
																			</div></th>
																		<th role="columnheader"
																			class="fc-col-header-cell fc-day fc-day-mon"><div
																				class="fc-scrollgrid-sync-inner">
																				<a aria-label="Monday"
																					class="fc-col-header-cell-cushion ">Mon</a>
																			</div></th>
																		<th role="columnheader"
																			class="fc-col-header-cell fc-day fc-day-tue"><div
																				class="fc-scrollgrid-sync-inner">
																				<a aria-label="Tuesday"
																					class="fc-col-header-cell-cushion ">Tue</a>
																			</div></th>
																		<th role="columnheader"
																			class="fc-col-header-cell fc-day fc-day-wed"><div
																				class="fc-scrollgrid-sync-inner">
																				<a aria-label="Wednesday"
																					class="fc-col-header-cell-cushion ">Wed</a>
																			</div></th>
																		<th role="columnheader"
																			class="fc-col-header-cell fc-day fc-day-thu"><div
																				class="fc-scrollgrid-sync-inner">
																				<a aria-label="Thursday"
																					class="fc-col-header-cell-cushion ">Thu</a>
																			</div></th>
																		<th role="columnheader"
																			class="fc-col-header-cell fc-day fc-day-fri"><div
																				class="fc-scrollgrid-sync-inner">
																				<a aria-label="Friday"
																					class="fc-col-header-cell-cushion ">Fri</a>
																			</div></th>
																		<th role="columnheader"
																			class="fc-col-header-cell fc-day fc-day-sat"><div
																				class="fc-scrollgrid-sync-inner">
																				<a aria-label="Saturday"
																					class="fc-col-header-cell-cushion ">Sat</a>
																			</div></th>
																	</tr>
																</thead>
															</table>
														</div>
													</div></th>
											</tr>
										</thead>
										<tbody role="rowgroup">
											<tr role="presentation"
												class="fc-scrollgrid-section fc-scrollgrid-section-body  fc-scrollgrid-section-liquid">
												<td role="presentation"><div
														class="fc-scroller-harness fc-scroller-harness-liquid">
														<div class="fc-scroller fc-scroller-liquid-absolute"
															style="overflow: hidden auto;">
															<div class="fc-daygrid-body fc-daygrid-body-balanced "
																style="width: 551px;">
																<table role="presentation"
																	class="fc-scrollgrid-sync-table"
																	style="width: 551px; height: 377px;">
																	<colgroup></colgroup>
																	<tbody role="presentation">
																		<tr role="row">
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-sun fc-day-past fc-day-other"
																				data-date="2023-05-28" aria-labelledby="fc-dom-2"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-2" class="fc-daygrid-day-number"
																							aria-label="May 28, 2023">28</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-mon fc-day-past fc-day-other"
																				data-date="2023-05-29" aria-labelledby="fc-dom-4"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-4" class="fc-daygrid-day-number"
																							aria-label="May 29, 2023">29</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-tue fc-day-past fc-day-other"
																				data-date="2023-05-30" aria-labelledby="fc-dom-6"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-6" class="fc-daygrid-day-number"
																							aria-label="May 30, 2023">30</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-wed fc-day-past fc-day-other"
																				data-date="2023-05-31" aria-labelledby="fc-dom-8"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-8" class="fc-daygrid-day-number"
																							aria-label="May 31, 2023">31</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-thu fc-day-past"
																				data-date="2023-06-01" aria-labelledby="fc-dom-10"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-10" class="fc-daygrid-day-number"
																							aria-label="June 1, 2023">1</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-event-harness"
																							style="margin-top: 0px;">
																							<a
																								class="fc-daygrid-event fc-daygrid-block-event fc-h-event fc-event fc-event-draggable fc-event-resizable fc-event-start fc-event-end fc-event-past"
																								tabindex="0"
																								style="border-color: rgb(245, 105, 84); background-color: rgb(245, 105, 84);"><div
																									class="fc-event-main">
																									<div class="fc-event-main-frame">
																										<div class="fc-event-title-container">
																											<div class="fc-event-title fc-sticky">All
																												Day Event</div>
																										</div>
																									</div>
																								</div>
																								<div
																									class="fc-event-resizer fc-event-resizer-end"></div></a>
																						</div>
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-fri fc-day-past"
																				data-date="2023-06-02" aria-labelledby="fc-dom-12"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-12" class="fc-daygrid-day-number"
																							aria-label="June 2, 2023">2</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-sat fc-day-past"
																				data-date="2023-06-03" aria-labelledby="fc-dom-14"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-14" class="fc-daygrid-day-number"
																							aria-label="June 3, 2023">3</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																		</tr>
																		<tr role="row">
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-sun fc-day-past"
																				data-date="2023-06-04" aria-labelledby="fc-dom-16"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-16" class="fc-daygrid-day-number"
																							aria-label="June 4, 2023">4</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-mon fc-day-past"
																				data-date="2023-06-05" aria-labelledby="fc-dom-18"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-18" class="fc-daygrid-day-number"
																							aria-label="June 5, 2023">5</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-event-harness"
																							style="margin-top: 0px;">
																							<a
																								class="fc-daygrid-event fc-daygrid-dot-event fc-event fc-event-draggable fc-event-resizable fc-event-start fc-event-end fc-event-past"
																								tabindex="0"><div
																									class="fc-daygrid-event-dot"></div>
																								<div class="fc-event-time">10a</div>
																								<div class="fc-event-title">New Event</div></a>
																						</div>
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-tue fc-day-past"
																				data-date="2023-06-06" aria-labelledby="fc-dom-20"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-20" class="fc-daygrid-day-number"
																							aria-label="June 6, 2023">6</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-wed fc-day-past"
																				data-date="2023-06-07" aria-labelledby="fc-dom-22"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-22" class="fc-daygrid-day-number"
																							aria-label="June 7, 2023">7</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-thu fc-day-past"
																				data-date="2023-06-08" aria-labelledby="fc-dom-24"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-24" class="fc-daygrid-day-number"
																							aria-label="June 8, 2023">8</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-fri fc-day-past"
																				data-date="2023-06-09" aria-labelledby="fc-dom-26"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-26" class="fc-daygrid-day-number"
																							aria-label="June 9, 2023">9</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-sat fc-day-past"
																				data-date="2023-06-10" aria-labelledby="fc-dom-28"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-28" class="fc-daygrid-day-number"
																							aria-label="June 10, 2023">10</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																		</tr>
																		<tr role="row">
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-sun fc-day-past"
																				data-date="2023-06-11" aria-labelledby="fc-dom-30"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-30" class="fc-daygrid-day-number"
																							aria-label="June 11, 2023">11</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-mon fc-day-past"
																				data-date="2023-06-12" aria-labelledby="fc-dom-32"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-32" class="fc-daygrid-day-number"
																							aria-label="June 12, 2023">12</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-tue fc-day-past"
																				data-date="2023-06-13" aria-labelledby="fc-dom-34"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-34" class="fc-daygrid-day-number"
																							aria-label="June 13, 2023">13</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-wed fc-day-past"
																				data-date="2023-06-14" aria-labelledby="fc-dom-36"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-36" class="fc-daygrid-day-number"
																							aria-label="June 14, 2023">14</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-thu fc-day-past"
																				data-date="2023-06-15" aria-labelledby="fc-dom-38"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-38" class="fc-daygrid-day-number"
																							aria-label="June 15, 2023">15</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-fri fc-day-past"
																				data-date="2023-06-16" aria-labelledby="fc-dom-40"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-40" class="fc-daygrid-day-number"
																							aria-label="June 16, 2023">16</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-sat fc-day-past"
																				data-date="2023-06-17" aria-labelledby="fc-dom-42"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-42" class="fc-daygrid-day-number"
																							aria-label="June 17, 2023">17</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																		</tr>
																		<tr role="row">
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-sun fc-day-past"
																				data-date="2023-06-18" aria-labelledby="fc-dom-44"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-44" class="fc-daygrid-day-number"
																							aria-label="June 18, 2023">18</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-mon fc-day-past"
																				data-date="2023-06-19" aria-labelledby="fc-dom-46"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-46" class="fc-daygrid-day-number"
																							aria-label="June 19, 2023">19</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-tue fc-day-past"
																				data-date="2023-06-20" aria-labelledby="fc-dom-48"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-48" class="fc-daygrid-day-number"
																							aria-label="June 20, 2023">20</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-wed fc-day-past"
																				data-date="2023-06-21" aria-labelledby="fc-dom-50"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-50" class="fc-daygrid-day-number"
																							aria-label="June 21, 2023">21</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-thu fc-day-past"
																				data-date="2023-06-22" aria-labelledby="fc-dom-52"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-52" class="fc-daygrid-day-number"
																							aria-label="June 22, 2023">22</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-fri fc-day-past"
																				data-date="2023-06-23" aria-labelledby="fc-dom-54"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-54" class="fc-daygrid-day-number"
																							aria-label="June 23, 2023">23</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-sat fc-day-past"
																				data-date="2023-06-24" aria-labelledby="fc-dom-56"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-56" class="fc-daygrid-day-number"
																							aria-label="June 24, 2023">24</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																		</tr>
																		<tr role="row">
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-sun fc-day-past"
																				data-date="2023-06-25" aria-labelledby="fc-dom-58"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-58" class="fc-daygrid-day-number"
																							aria-label="June 25, 2023">25</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div
																							class="fc-daygrid-event-harness fc-daygrid-event-harness-abs"
																							style="top: 0px; left: 0px; right: -157.406px;">
																							<a
																								class="fc-daygrid-event fc-daygrid-block-event fc-h-event fc-event fc-event-draggable fc-event-start fc-event-end fc-event-past"
																								tabindex="0"
																								style="border-color: rgb(243, 156, 18); background-color: rgb(243, 156, 18);"><div
																									class="fc-event-main">
																									<div class="fc-event-main-frame">
																										<div class="fc-event-time">12a</div>
																										<div class="fc-event-title-container">
																											<div class="fc-event-title fc-sticky">Long
																												Event</div>
																										</div>
																									</div>
																								</div></a>
																						</div>
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 25px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-mon fc-day-past"
																				data-date="2023-06-26" aria-labelledby="fc-dom-60"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-60" class="fc-daygrid-day-number"
																							aria-label="June 26, 2023">26</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 25px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-tue fc-day-past"
																				data-date="2023-06-27" aria-labelledby="fc-dom-62"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-62" class="fc-daygrid-day-number"
																							aria-label="June 27, 2023">27</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 25px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-wed fc-day-past"
																				data-date="2023-06-28" aria-labelledby="fc-dom-64"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-64" class="fc-daygrid-day-number"
																							aria-label="June 28, 2023">28</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-event-harness"
																							style="margin-top: 0px;">
																							<a
																								class="fc-daygrid-event fc-daygrid-dot-event fc-event fc-event-draggable fc-event-resizable fc-event-start fc-event-end fc-event-past"
																								href="https://www.google.com/"><div
																									class="fc-daygrid-event-dot"
																									style="border-color: rgb(60, 141, 188);"></div>
																								<div class="fc-event-time">12a</div>
																								<div class="fc-event-title">Click for
																									Google</div></a>
																						</div>
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-thu fc-day-past"
																				data-date="2023-06-29" aria-labelledby="fc-dom-66"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-66" class="fc-daygrid-day-number"
																							aria-label="June 29, 2023">29</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-fri fc-day-today "
																				data-date="2023-06-30" aria-labelledby="fc-dom-68"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-68" class="fc-daygrid-day-number"
																							aria-label="June 30, 2023">30</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div
																							class="fc-daygrid-event-harness fc-daygrid-event-harness-abs"
																							style="visibility: hidden; top: 0px; left: 0px; right: 0px;">
																							<a
																								class="fc-daygrid-event fc-daygrid-dot-event fc-event fc-event-draggable fc-event-resizable fc-event-start fc-event-end fc-event-today"
																								tabindex="0"><div
																									class="fc-daygrid-event-dot"
																									style="border-color: rgb(0, 115, 183);"></div>
																								<div class="fc-event-time">10:30a</div>
																								<div class="fc-event-title">Meeting</div></a>
																						</div>
																						<div
																							class="fc-daygrid-event-harness fc-daygrid-event-harness-abs"
																							style="visibility: hidden; top: 0px; left: 0px; right: 0px;">
																							<a
																								class="fc-daygrid-event fc-daygrid-dot-event fc-event fc-event-draggable fc-event-resizable fc-event-start fc-event-end fc-event-today"
																								tabindex="0"><div
																									class="fc-daygrid-event-dot"
																									style="border-color: rgb(0, 192, 239);"></div>
																								<div class="fc-event-time">12p</div>
																								<div class="fc-event-title">Lunch</div></a>
																						</div>
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;">
																							<a class="fc-daygrid-more-link fc-more-link"
																								title="Show 2 more events" aria-expanded="false"
																								aria-controls="" tabindex="0">+2 more</a>
																						</div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-sat fc-day-future fc-day-other"
																				data-date="2023-07-01" aria-labelledby="fc-dom-70"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-70" class="fc-daygrid-day-number"
																							aria-label="July 1, 2023">1</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-event-harness"
																							style="margin-top: 0px;">
																							<a
																								class="fc-daygrid-event fc-daygrid-dot-event fc-event fc-event-draggable fc-event-resizable fc-event-start fc-event-end fc-event-future"
																								tabindex="0"><div
																									class="fc-daygrid-event-dot"
																									style="border-color: rgb(0, 166, 90);"></div>
																								<div class="fc-event-time">7p</div>
																								<div class="fc-event-title">Birthday Party</div></a>
																						</div>
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																		</tr>
																		<tr role="row">
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-sun fc-day-future fc-day-other"
																				data-date="2023-07-02" aria-labelledby="fc-dom-72"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-72" class="fc-daygrid-day-number"
																							aria-label="July 2, 2023">2</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-mon fc-day-future fc-day-other"
																				data-date="2023-07-03" aria-labelledby="fc-dom-74"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-74" class="fc-daygrid-day-number"
																							aria-label="July 3, 2023">3</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-tue fc-day-future fc-day-other"
																				data-date="2023-07-04" aria-labelledby="fc-dom-76"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-76" class="fc-daygrid-day-number"
																							aria-label="July 4, 2023">4</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-wed fc-day-future fc-day-other"
																				data-date="2023-07-05" aria-labelledby="fc-dom-78"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-78" class="fc-daygrid-day-number"
																							aria-label="July 5, 2023">5</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-thu fc-day-future fc-day-other"
																				data-date="2023-07-06" aria-labelledby="fc-dom-80"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-80" class="fc-daygrid-day-number"
																							aria-label="July 6, 2023">6</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-fri fc-day-future fc-day-other"
																				data-date="2023-07-07" aria-labelledby="fc-dom-82"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-82" class="fc-daygrid-day-number"
																							aria-label="July 7, 2023">7</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																			<td role="gridcell"
																				class="fc-daygrid-day fc-day fc-day-sat fc-day-future fc-day-other"
																				data-date="2023-07-08" aria-labelledby="fc-dom-84"><div
																					class="fc-daygrid-day-frame fc-scrollgrid-sync-inner">
																					<div class="fc-daygrid-day-top">
																						<a id="fc-dom-84" class="fc-daygrid-day-number"
																							aria-label="July 8, 2023">8</a>
																					</div>
																					<div class="fc-daygrid-day-events">
																						<div class="fc-daygrid-day-bottom"
																							style="margin-top: 0px;"></div>
																					</div>
																					<div class="fc-daygrid-day-bg"></div>
																				</div></td>
																		</tr>
																	</tbody>
																</table>
															</div>
														</div>
													</div></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					<!-- /.card-body -->
				</div>
				<!-- /.card -->
			</div>
			<!-- /.col -->
		</div>
		<!-- /.row -->
	</div>
	<!-- /.container-fluid -->
</section>


<!-- fullCalendar 2.2.5 -->
<script src="/resources/bootstrap/plugins/moment/moment.min.js"></script>
<script src="/resources/bootstrap/plugins/fullcalendar/main.js"></script>
<!-- tippy 툴팁-->
<script
	src="https://unpkg.com/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://unpkg.com/tippy.js@6.3.3/dist/tippy.umd.js"></script>
<script>
$(function () {

    /* initialize the external events
     -----------------------------------------------------------------*/
    function ini_events(ele) {
      ele.each(function () {

        // create an Event Object (https://fullcalendar.io/docs/event-object)
        // it doesn't need to have a start or end
        var eventObject = {
          title: $.trim($(this).text()) // use the element's text as the event title
        }

        // store the Event Object in the DOM element so we can get to it later
        $(this).data('eventObject', eventObject)

        // make the event draggable using jQuery UI
        $(this).draggable({
          zIndex        : 1070,
          revert        : true, // will cause the event to go back to its
          revertDuration: 0  //  original position after the drag
        })
      })
    }

    ini_events($('#external-events div.external-event'))

    /* initialize the calendar
     -----------------------------------------------------------------*/
    //Date for the calendar events (dummy data)
    var date = new Date()
    var d    = date.getDate(),
        m    = date.getMonth(),
        y    = date.getFullYear()

    var Calendar = FullCalendar.Calendar;
    var Draggable = FullCalendar.Draggable;

    var containerEl = document.getElementById('external-events');
    var calendarEl = document.getElementById('calendar');

    // initialize the external events
    // -----------------------------------------------------------------

    new Draggable(containerEl, {
      itemSelector: '.external-event',
      eventData: function(eventEl) {
        console.log("만듬")
        return {
          title: eventEl.innerText,
          schdlType: $(eventEl).data("schdltype"),
          schdlId:$(eventEl).data("schdlid"),
          schdlCn:$(eventEl).data("schdlcn"),
          empId:$(eventEl).data("empid"),
          backgroundColor: window.getComputedStyle( eventEl ,null).getPropertyValue('background-color'),
          borderColor: window.getComputedStyle( eventEl ,null).getPropertyValue('background-color'),
          textColor: window.getComputedStyle( eventEl ,null).getPropertyValue('color'),
        };
      }
    });

    var tooltips={};
    var calendar = new Calendar(calendarEl, {
      dayMaxEvents: true,
      headerToolbar: {
        left  : 'prev,next today',
        center: 'title',
        right : 'dayGridMonth,timeGridWeek,timeGridDay'
      },
      themeSystem: 'bootstrap',
      //Random default events
      
      
      editable  : true,
      droppable : true, // this allows things to be dropped onto the calendar !!!
      eventResize: function(event, delta, revertFunc) {

        console.log("리사이즈 실행")       	
      },
      eventDrop: function(event, delta, revertFunc) {

        console.log("이벤트드랍 실행")
        //event.revert() ajax 처리 실패시 다시 일정을 원레위치로 되돌리는 함수
      },
      eventClick: function(event) {
  		//console.log(event.event._def.extendedProps.content)
  		//console.log(event.event)
  		console.log("이벤트 클릭 실행")
  		console.log(event)
		/* $("#modal_back").css("display","block")
		$("body").css("overflow","hidden") */
		
      },
      drop      : function(info) {
        // is the "remove after drop" checkbox checked?
     /*    console.log(info.draggedEl.innerText)
        console.dir(info.date) */
        var empId = $(info.draggedEl).data("empid")
        
        if(empId!="${employee.empId}"){
        	alert("회원님의 일정이 아닙니다.")
        	return;
        }
        var obj = {
        	schdlId:$(info.draggedEl).data("schdlid"),
        	schdlBgngDt:info.date,
        	schdlAllday:info.allDay
        }
        console.log("인포", info)
        console.log(typeof info.allDay)
		 $.ajax({
  			  url: '/everyware/calendar/modify', // 요청을 보낼 URL
  			  method: 'post', // HTTP 메서드 (GET, POST 등)
  			  data: obj, // 요청에 첨부할 데이터 (선택 사항)
  			  beforeSend : function(xhr){
  			  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
  	  		  },
  			  success: function(response) {
  				  if(response=="OK"){
  					  alert("성공")
  					  info.draggedEl.parentNode.removeChild(info.draggedEl);
  				  }else{
  					alert("일정 등록 실패..")
  					location.reload();
  				  }
  			    
  			  },
  			  error: function(xhr, status, error) {
  				alert("일정 등록 실패..")
  				location.reload();
  			  }
  			}); 

      },

        eventDidMount: function(info) {
        	console.log("이벤트디드마운트")
        	console.log(info)
            var eventEl = info.el;
        	var type = info.event._def.extendedProps.schdlType;
        	var content = "";
        	if(type=="e"){
        		content=""
        	}else if(type=="d"){
        		
        	}else if(type=="c"){
        		
        	}
        	// 나중에 부서명or개인or회사 + 일정 수행인원을  툴팁으로 띄울것
            var tooltip = tippy(eventEl, {
              content: "부서or개인or회사명+일정수행인원", // content 값을 이벤트의 extendedProps에서 가져옴
              placement: 'top',
            });
          },
          
          eventChange: function(obj) {
        	  console.log("이벤트체인지 실행")
        	  console.log(obj.event)
        	  var newEvent=obj.event
        	  var empId=newEvent._def.extendedProps.empId
        	  if(empId!="${employee.empId}"){
              	alert("회원님의 일정이 아닙니다.")
              	return;
              }
        	  var ajaxObj={
        		  schdlId:newEvent._def.extendedProps.schdlId,
        		  schdlType:newEvent._def.extendedProps.schdlType,
        		  schdlAllday:newEvent._def.allDay,
        		  schdlTtl:newEvent._def.title,
        		  schdlId:newEvent._def.extendedProps.schdlId,
        		  color:newEvent._def.ui.backgroundColor,
        		  schdlBgngDt:newEvent._instance.range.start,
        		  schdlEndDt:newEvent._instance.range.end,
        		  schdlCn:newEvent._def.extendedProps.schdlCn
        	  }
        	  console.log(ajaxObj)
        	  $.ajax({
      			  url: '/everyware/calendar/modify', // 요청을 보낼 URL
      			  method: 'post', // HTTP 메서드 (GET, POST 등)
      			  data: ajaxObj, // 요청에 첨부할 데이터 (선택 사항)
      			  beforeSend : function(xhr){
      			  	xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
  	  		  	  },
      			  success: function(response) { 
      			    alert("일정 수정 성공")
      			  },
      			  error: function(xhr, status, error) {
      				alert("일정 등록 실패..")
      				obj.revert()
      			  }
      			});
          }
    });
    
    var eventList=JSON.parse('${eventList}')
    eventList.forEach(function(data){
    	
    	var allDay=""
    	if(data.schdlAllday=="true"){
    		 allDay=true
    	}else{
    		allDay=false
    	}
    	var event = {
    		 title: data.schdlTtl,
    		 start: new Date(data.schdlBgngDt),
    		 end: new Date(data.schdlEndDt),
    		 allDay:allDay,
    		 backgroundColor: data.schdlColor,
    		 borderColor: data.schdlColor,
	    	 schdlId:data.schdlId,
			 schdlType: data.schdlType,
			 schdlCn : data.schdlCn,
			 empId : data.empId
    	};    		
    	calendar.addEvent(event);
    	console.log(event);
    })
	
    calendar.render();
    // $('#calendar').fullCalendar()
    /* ADDING EVENTS */
    var currColor = '#3c8dbc' //Red by default
    // Color chooser button
    $('#color-chooser > li > a').click(function (e) {
      e.preventDefault()
      // Save color
      currColor = $(this).css('color')
      // Add color effect to button
      $('#add-new-event').css({
        'background-color': currColor,
        'border-color'    : currColor
      })
    })
    $('#add-new-event').click(function (e) {
      e.preventDefault()
      // Get value and make sure it is not null
      var val = $('#new-event').val()
      var content = $("#new-event-content").val().replace(/\n/g, '<br>')
      var schdlType = $("input[name=schdlType]:checked").val()
      console.log("콘텐트:",content)
      if (val.length == 0) {
        return
      }
      if(typeof schdlType=='undefined' || schdlType==null){
    	  return;
      }
      var obj = {
          	schdlTtl:val,
          	schdlType:schdlType,
          	schdlColor:currColor,
          	schdlCn:content
          }
  		$.ajax({
  			  url: '/everyware/calendar/register', // 요청을 보낼 URL
  			  method: 'post', // HTTP 메서드 (GET, POST 등)
  			  data: obj, // 요청에 첨부할 데이터 (선택 사항)
	  		  beforeSend : function(xhr){
			  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	  		  },
  			  success: function(response) {
  			    
  			    var schdlId=response;
	  		      // Create events
	  		      var event = $('<div />')
	  		      event.css({
	  		        'background-color': currColor,
	  		        'border-color'    : currColor,
	  		        'color'           : '#fff'
	  		      }).addClass('external-event')
	  		      event.append($("<span>"+val+"</span>"))
	  		      event.attr("data-schdlType",schdlType)
	  		      event.attr("data-schdlId",schdlId)
	  		      event.attr("data-schdlCn",content);
	  		      event.attr("data-empId","${employee.empId}");
	  		      event.append($("<img src='/resources/img/xbtn.png' class='eventRemoveBtn'>").clone())
	  		      $('#external-events').prepend(event)
	
	  		      // Add draggable funtionality
	  		      ini_events(event)
  			  },
  			  error: function(xhr, status, error) {
  				alert("일정 등록 실패..")
  			  }
  			});



      // Remove event from text input
      $('#new-event').val('')
      $("#new-event-content").val("")
    })
    
    $(document).on("click",".eventRemoveBtn",function(){
    	var schdlId=$(this).parent().data("schdlid")
    	console.log(schdlId)
    	var title=$(this).parent().text()
    	if(confirm(title+" 일정을 삭제하시겠습니까?")){
    		$.ajax({
    			  url: '/everyware/calendar/delete', // 요청을 보낼 URL
    			  method: 'post', // HTTP 메서드 (GET, POST 등)
    			  data: {schdlId:schdlId}, // 요청에 첨부할 데이터 (선택 사항)
    			  beforeSend : function(xhr){
    				  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
    		  	  },
    			  success: function(response) {
    				  if(response=="OK"){
	    				  alert("삭제되었습니다.")
	    				  $(".external-event[data-schdlId="+schdlId+"]").remove();
    				  }else{
    					  alert("일정 삭제 실패..")
    				  }
    			  },
    			  error: function(xhr, status, error) {
    				alert("일정 삭제 실패..")
    			  }
    			});
    	}
    })
  })
</script>