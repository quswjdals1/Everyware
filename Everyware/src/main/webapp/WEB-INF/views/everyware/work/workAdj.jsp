<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
    let headerName = "${_csrf.headerName}"
    let token = "${_csrf.token}"
</script>

<style>
#searchState, #searchStartDate, #searchEndDate{
    border: 1px solid #ced4da;
}

.info-box {
    height: 100px;
}

.info-box .info-box-number {
    font-size: large;
}

#mWaStatus{
    border: none;
}
</style>


<section class="content-header">
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h1>근태조정</h1>
			</div>
			<div class="col-sm-6">
				<ol class="breadcrumb float-sm-right">
					<li class="breadcrumb-item"><a href="#">Home</a></li>
					<li class="breadcrumb-item active">근태관리 > 근태조정</li>
				</ol>
			</div>
		</div>
	</div><!-- /.container-fluid -->
 </section>


<section class="content py-3">
    <div class="container-fluid">

        
        <!-- 근태조정현황-->
        <div class="row">
            <div class="col">
                
                <div class="card card-primary card-outline">
                    <div class="card-header">
                        <h3 class="card-title">근태조정 Summary</h3>

                        <div class="card-tools">
                            <form class="input-group input-group-sm" id="searchForm">
                                <span>기간&nbsp;</span>
                                <input type="date" pattern="yyyy-MM-dd" name="searchStartDate" id="searchStartDate" value="${searchStartDate}">
                                <span>&nbsp; ~ &nbsp;</span>
                                <input type="date" pattern="yyyy-MM-dd" name="searchEndDate" id="searchEndDate" value="${searchEndDate}">
                            
                                <span>&nbsp; &nbsp;검색항목 &nbsp;</span>
                                <select class="" id="searchState" name="searchState">
                                    <option value="0" selected="selected">전체</option>
                                    <option value="6" <c:if test="${searchState == '승인' }">
                                        <c:out value="selected" />
                                        </c:if>>승인
                                    </option>
                                    <option value="4" <c:if test="${searchState == '진행' }">
                                        <c:out value="selected" />
                                        </c:if>>승인대기
                                    </option>
                                    <option value="7" <c:if test="${searchState == '반려' }">
                                        <c:out value="selected" />
                                        </c:if>>반려
                                    </option>
                                </select>
                            
                                <div class="input-group-append">
                                    <button type="submit" class="btn btn-default" id="searchBtn">
                                        <i class="fas fa-search"></i>검색
                                    </button>
                                </div>
                                <sec:csrfInput />
                            
                            </form>
                        </div>
                    </div>


                    <div class="card-body" style="display: block;">
                        <div class="row">
                            <div class="col-md-3 col-sm-6 col-12">
                                <div class="info-box bg-primary">
                                    <span class="info-box-icon"><i class="far fa-bookmark"></i></span>
                                    <div class="info-box-content">
                                        <span class="info-box-text">전체</span>
                                        <span class="info-box-number" id="totalRecode">0건</span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3 col-sm-6 col-12">
                                <div class="info-box bg-success">
                                    <span class="info-box-icon"><i class="far fa-thumbs-up"></i></span>
                                    <div class="info-box-content">
                                        <span class="info-box-text">승인</span>
                                        <span class="info-box-number" id="approved">0건</span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3 col-sm-6 col-12">
                                <div class="info-box bg-warning">
                                    <span class="info-box-icon"><ion-icon name="ellipsis-horizontal-circle-outline"></ion-icon></span>
                                    <div class="info-box-content">
                                        <span class="info-box-text">진행</span>
                                        <span class="info-box-number" id="progress">0건</span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3 col-sm-6 col-12">
                                <div class="info-box bg-danger">
                                    <span class="info-box-icon"><ion-icon name="ban-outline"></ion-icon></span>
                                    <div class="info-box-content">
                                        <span class="info-box-text">반려</span>
                                        <span class="info-box-number" id="rejected">0건</span>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>

            </div>
        </div>       

        <!-- 근태조정신청내역 -->
        <div class="row">
            <div class="col">

                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">근태조정신청내역</h3>
                    </div>
                    <div class="card-body"  style="overflow-Y: scroll; height: 650px;display: block; padding: 0%">
                        <table class="table table-striped projects">
                            <thead>
                                <tr>
                                    <th style="text-align: center;">조정일자</th>
                                    <!-- <th style="text-align: center;">요일</th> -->
                                    <th style="text-align: center;">출근시간</th>
                                    <th style="text-align: center;">퇴근시간</th>
                                    <th style="text-align: center;">조정출근시간</th>
                                    <th style="text-align: center;">조정퇴근시간</th>
                                    <th style="text-align: center;">근무시간</th>
                                    <th style="text-align: center;">승인여부</th>
                                    <th style="text-align: center;">상세보기</th>
                                </tr>
                            </thead>
                            <tbody id="workAdjList">
                                <!-- workAdjList -->
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- 페이지번호 -->
                    <div class="card-footer clearfix" id="pagingArea">
                        <ul class="pagination pagination-sm m-0 float-right">
                            <!-- ${pagingVO.pagingHTML } -->
                        </ul>
                    </div>

                </div>

            </div>
        </div>

    </div>
</section>




<!-- modal-workAdjForm-->
<div class="modal fade" id="modal-workAdjForm">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="modalTtl">근태조정신청내역</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <div class="modal-body">
                <form class="form-horizontal" method="post" id="">
                    <input type="hidden" id="mWorkNo" name="">

                    <div class="card-body">
						<div class="form-group row">
							<label for="" class="col-sm-2 col-form-label">근무일</label>
							<div class="col-sm-10 pr-4">
								<input type="text" class="form-control" id="mWorkDt" name="mWorkDt" disabled>
							</div>
						</div>
							
						<div class="form-group row">
							<label for="" class="col-sm-2 col-form-label">출퇴근시간</label>
							<div class="col-sm-10 row">
								<div class="col-sm-6 row mr-1">
									<label for="mWorkBgngDt" class="col-sm-4 col-form-label text-secondary">출근시간</label>
									<input type="time" class="form-control col-sm-8" name="mWaBfrBgngDt" id="mWaBfrBgngDt" value="" disabled>
								</div>
								<div class="col-sm-6 row ml-1">
									<label for="mWorkEndDt" class="col-sm-4 col-form-label text-secondary">퇴근시간</label>
									<input type="time" class="form-control col-sm-8" name="mWaBfrEndDt" id="mWaBfrEndDt" value="" disabled>
								</div>
							</div>
                        </div>
						
                        <div class="form-group row">
							<label for="" class="col-sm-2 col-form-label">조정시간</label>
							
							<div class="col-sm-10 row">
								<div class="col-sm-6 row mr-1">
									<label for="mWorkAdjBgngDt" class="col-sm-4 col-form-label text-secondary">출근시간</label>
									<input type="time" class="form-control col-sm-8" id="mWaBgngDt" value="" disabled>
								</div>
								<div class="col-sm-6 row ml-1">
									<label for="mWorkAdjEndDt" class="col-sm-4 col-form-label text-secondary">퇴근시간</label>
									<input type="time" class="form-control col-sm-8" id="mWaEndDt" value="" disabled>
								</div>
							</div>
                        </div>
						
                        <div class="form-group row">
                            <label for="mTimeDiff" class="col-sm-2 col-form-label">총 근무시간</label>
                            <div class="col-sm-10 pr-4">
                                <input type="text" class="form-control" id="mTimeDiff" name="mTimeDiff" disabled>
                            </div>
                            
                        </div>

                        <div class="form-group row">
                            <label for="mApprover" class="col-sm-2 col-form-label">결재자</label>
                            
                            <div class="col-sm-10 row">
                                <div class="col-sm-6">
                                    <div class="form-control" id="mApprover" name="mApprover" data-toggle="modal" data-target="#approval-modal" disabled>
                                        <ul class="selected-agt-ul"></ul>
                                    </div>
                                </div>
                                <div class="col-sm-6 row ml-1">
                                    <label for="mWorkAdjEndDt" class="col-sm-4 col-form-label text-secondary">결재여부</label>
                                    <div class="form-control col-sm-8" id="mWaStatus">결재여부</div>
                                </div>
                            </div>
                        </div>


                        <div class="form-group row">
                            <label for="mWorkAdjReason" class="col-sm-2 col-form-label">조정사유</label>
                            <div class="col-sm-10 pr-4">
                                <div class="input-group mb-3">
                                    <textarea class="form-control" id="mWaReason" name="" rows="10" placeholder="" disabled></textarea>
                                </div>
                            </div>
                        </div>


                    </div>
                </form>
            </div>

            <!-- <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div> -->

        </div>
    </div>
</div>























<script src="/resources/bootstrap/plugins/jquery/jquery.min.js"></script>

<script>

$(function(){

    var searchStartDate = $("#searchStartDate").val();
    var searchEndDate = $("#searchEndDate").val();

    var searchForm = $("#searchForm");
    var pagingArea = $("#pagingArea");
    
    var obj = {
        page: 1,
        searchStartDate: searchStartDate,
        searchEndDate: searchEndDate,
        searchState: 0
    }

    workAdjListJson();
    workAdjSummary();
    // workAdjList(obj, addList);

    // 페이지 번호 클릭시
    // pagingArea.on("click", "a", function(event) {
    //     event.preventDefault();
    //     var pageNo = $(this).data("page"); // 페이지 번호가 넘어옴
    //     obj.page=pageNo;
    //     workAdjList(obj,addList);
    // });


    // 검색
	$("#searchBtn").on("click", function (e) {
		e.preventDefault();

		obj.searchStartDate = $("#searchStartDate").val();
		obj.searchEndDate = $("#searchEndDate").val();
		obj.searchState = $("#searchState").val();

		// workAdjList(obj,addList);
	});

    // 상세보기
    $(document).on("click", ".btnDetail", function(event) {
        var waNo = $(this).closest(".workAdjTable").find("input[name='waNo']").val();
        // console.log(waNo);

        $.ajax({
			type: "get",
			url: `/everyware/workAdj/getOneWorkAdj/\${waNo}`,
			contentType: 'application/json; charset=utf-8',
			dataType: "json",
			beforeSend: function (xhr) {
				xhr.setRequestHeader(headerName, token);
			},
			success: function (res) {
				console.log("res", res);
                var workDt = res.workDt;
                var waBfrBgngDt = res.waBfrBgngDt;
                var waBfrEndDt = res.waBfrEndDt;
                var waBgngDt = res.waBgngDt;
                var waEndDt = res.waEndDt;
                var waStatus = res.waStatus;
                var waReason = res.waReason;
				var timeDiff = calculateTimeDifference(waBgngDt, waEndDt);

				$('#mWorkDt').val(workDt);
				$('#mWaBfrBgngDt').val(waBfrBgngDt);
				$('#mWaBfrEndDt').val(waBfrEndDt);
				$('#mWaBgngDt').val(waBgngDt);
				$('#mWaEndDt').val(waEndDt);
				// $('#mWaStatus').val(waStatus);
				$('#mTimeDiff').val(timeDiff);
				// $('#mApprover').val(timeDiff);
				$('#mWaReason').val(waReason);
                statusStr = "";
                
                if(waStatus == 4){
                    statusStr += `<span class="badge bg-warning">진행</span>`;
                }
                if(waStatus == 6){
                    statusStr += `<span class="badge bg-success">승인</span>`;
                }
                if(waStatus == 7){
                    statusStr += `<span class="badge bg-danger">반려</span>`;
                }
                
				$('#modal-workAdjForm').modal("show");
                $('#mWaStatus').html(statusStr);
                
			},
			error: function (xhr) {
				alert("Error: " + xhr.status);
			}

		});
	});


});


// 근태조정내역
function workAdjList(data, callback){
    $.ajax({
       url: `/everyware/workAdj/getWorkAdjList`,
       type: "post",
       contentType: 'application/json; charset=utf-8',
        dataType: "json",
        data: JSON.stringify(data),
        beforeSend: function (xhr) {
            // xhr.setRequestHeader("${_headerName}","${token}");
            xhr.setRequestHeader(headerName, token);
        },
        success: function (res) {
            if (typeof callback != "undefined") {
                callback(res)
            }
        },
        error: function (xhr) {
            alert("Error: " + xhr.status);
        }
    });
}


function addList(res) {
    console.log("res", res);
    $("#workAdjList").html("");
	$("#pagingArea").html("");

    var dataList = res.dataList;
	var workAdjListStr = "";
	var pagingAreaStr = res.workAdj.pagingHTML;
    
    var totalRecode = res.totalRecode;
    var approved = res.approved;
    var progress = res.progress;
    var rejected = res.rejected;

    if(dataList.length == 0){
        workAdjListStr += `<tr><td colspan='7'>조회하신 기록이 존재하지 않습니다.</td></tr>`;
    } else {
        for(let i = 0 ; i < dataList.length; i++){
            workAdjListStr +=
            `<tr class="workAdjTable">
                <input type="hidden" id="\${dataList[i].waNo}" name="waNo" value="\${dataList[i].waNo}">
                <th style="text-align: center;">\${dataList[i].workDt}</th>
                <th style="text-align: center;">\${dataList[i].workDw}</th>
                <th style="text-align: center;">\${dataList[i].waBgngDt}</th>
                <th style="text-align: center;">\${dataList[i].waEndDt}</th>
                <th style="text-align: center;">`;
            
            var timeDiff = calculateTimeDifference(dataList[i].waBgngDt, dataList[i].waEndDt);
			workAdjListStr += timeDiff;        

            workAdjListStr += `</th>`;

            if (`\${dataList[i].waStatus}` == 4) {
                workAdjListStr +=
                `<th style="text-align: center;">
                    <input type="hidden" value="\${dataList[i].waStatus}" />
                    <span class="badge bg-warning">
                        진행
                    </span>
                </th>`;
            }

            if (`\${dataList[i].waStatus}` == 6) {
                workAdjListStr +=
                `<th style="text-align: center;">
                    <input type="hidden" value="\${dataList[i].waStatus}" />
                    <span class="badge bg-success">
                        승인
                    </span>
                </th>`;
            }

            if (`\${dataList[i].waStatus}` == 7) {
                workAdjListStr +=
                `<th style="text-align: center;">
                    <input type="hidden" value="\${dataList[i].waStatus}" />
                    <span class="badge bg-danger">
                        반려
                    </span>
                </th>`;
            }

            workAdjListStr += 
                `<th style="text-align: center;">
                    <button type="button" class="btn btn-tool bg-info btnDetail">
                        <i class="fas fa-pencil-alt"></i>
                    </button>
                </th>
            </tr>`;

        }
    }
        

    // 현황
    $("#totalRecode").text(totalRecode + '건');
    $("#approved").text(approved + '건');
    $("#progress").text(progress + '건');
    $("#rejected").text(rejected + '건');

    // 목록 
	$("#workAdjList").html(workAdjListStr);
	$("#pagingArea").html(pagingAreaStr);


}




// 근태조정내역
function workAdjListJson(){
    $.ajax({
       url: `/everyware/workAdj/getWorkAdjJson`,
       type: "get",
       contentType: 'application/json; charset=utf-8',
        dataType: "text",
        beforeSend: function (xhr) {
            // xhr.setRequestHeader("${_headerName}","${token}");
            xhr.setRequestHeader(headerName, token);
        },
        success: function (res) {
            var dataList = JSON.parse(res);
            console.log("dataList : ", dataList);
            
            // var dataList = workAdj.workA
            var workAdjStr = "";
            
            
            if(dataList.length == 0){
                workAdjStr += `<tr><td colspan='8'>조회하신 기록이 존재하지 않습니다.</td></tr>`;
            } else {
                for(let i = 0; i < dataList.length; i++){
                    workAdjStr += 
                    `<tr class="workAdjTable">
                        <input type="hidden" id="\${dataList[i].workAdj.waNo}" name="waNo" value="\${dataList[i].workAdj.waNo}">
                        <th style="text-align: center;">\${dataList[i].workAdj.workDt}</th>
                        <th style="text-align: center;">\${dataList[i].workAdj.waBfrBgngDt}</th>
                        <th style="text-align: center;">\${dataList[i].workAdj.waBfrEndDt}</th>
                        <th style="text-align: center;">\${dataList[i].workAdj.waBgngDt}</th>
                        <th style="text-align: center;">\${dataList[i].workAdj.waEndDt}</th>
                        <th style="text-align: center;">`
                            
                        var timeDiff = calculateTimeDifference(dataList[i].workAdj.waBgngDt, dataList[i].workAdj.waEndDt);
                        workAdjStr += timeDiff;
                        workAdjStr += `</th>`;
                    
                    // 승인여부
                    if(dataList[i].prgrsSttsCd = 6) {
                        workAdjStr +=
                        `<th style="text-align: center;">
                            <span class="badge bg-success">
                                승인
                            </span>
                        </th>`
                    } else if(dataList[i].prgrsSttsCd = 7){
                        workAdjStr +=
                        `<th style="text-align: center;">
                            <span class="badge bg-danger">
                                반려
                            </span>
                        </th>`
                    } else {
                        workAdjStr +=
                        `<th style="text-align: center;">
                            <span class="badge bg-warning">
                                미승인
                            </span>
                        </th>`
                    }

                    workAdjStr += 
                        `<th style="text-align: center;">
                            <button type="button" class="btn btn-tool bg-info btnDetail">
                                <i class="fas fa-pencil-alt"></i>
                            </button>
                        </th>`;
                    
                    workAdjStr += `</tr>`;

                }
            }






            $("#workAdjList").html(workAdjStr);
        },
        error: function (xhr) {
            alert("Error: " + xhr.status);
        }
    });
}


function workAdjSummary() {
    $.ajax({
        url: `/everyware/workAdj/getWorkAdjSummary`,
        type: "get",
        contentType: 'application/json; charset=utf-8',
        dataType: "json",
        beforeSend: function (xhr) {
            // xhr.setRequestHeader("${_headerName}","${token}");
            xhr.setRequestHeader(headerName, token);
        },
        success: function (res) {
            console.log(res);
            var totalRecode = res.totalRecode;
            var approved = res.approved;
            var progress = res.progress;
            var rejected = res.rejected;

            $("#totalRecode").text(totalRecode + '건');
            $("#approved").text(approved + '건');
            $("#progress").text(progress + '건');
            $("#rejected").text(rejected + '건');
        },
        error: function (xhr) {
            alert("Error: " + xhr.status);
        }
    });    
}




function parseTime(timeString) {
	// console.log(timeString)
	  const [hours, minutes, seconds] = timeString.split(":");
	  return {
	    hours: parseInt(hours),
	    minutes: parseInt(minutes),
	    seconds: parseInt(seconds),
	  };
	}

function formatTime(time) { 
	  return time.toString().padStart(2, "0");
	}
	
function calculateTimeDifference(startTime, endTime) {
	const start = parseTime(startTime);
	const end = parseTime(endTime);
	// console.log(start)
	// console.log(end)

	let hoursDiff = end.hours - start.hours;
	let minutesDiff = end.minutes - start.minutes;
	let secondsDiff = end.seconds - start.seconds;

	if (secondsDiff < 0) {
	secondsDiff += 60;
	minutesDiff--;
	}

	if (minutesDiff < 0) {
	minutesDiff += 60;
	hoursDiff--;
	}
	return formatTime(hoursDiff) +":"+formatTime(minutesDiff) +":"+formatTime(secondsDiff);
}
</script>