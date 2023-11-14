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

#mWaStatus, #mWorkState{
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
        <!-- <div class="row">
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
                                    <th style="text-align: center;">요일</th>
                                    <th style="text-align: center;">사원명</th>
                                    <th style="text-align: center;">부서</th>
                                    <th style="text-align: center;">직급</th>
                                    <th style="text-align: center;">출근시간</th>
                                    <th style="text-align: center;">퇴근시간</th>
                                    <th style="text-align: center;">근무시간</th>
                                    <th style="text-align: center;">승인여부</th>
                                    <th style="text-align: center;">상세보기</th>
                                </tr>
                            </thead>
                            <tbody id="workAdjAdmin">
                                workAdjAdmin
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="card-footer clearfix" id="pagingArea">
                        <ul class="pagination pagination-sm m-0 float-right">
                        </ul>
                    </div>

                </div>

            </div>
        </div> -->

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
                                    <th style="text-align: center;">사원번호</th>
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
                            <label for="" class="col-sm-2 col-form-label">사원번호</label>
                            <div class="col pr-4">
                                <input type="text" class="form-control" id="mEmpId" name="mEmpId" disabled>
                            </div>

                            <label for="" class="col-sm-2 col-form-label">사원명</label>
                            <div class="col pr-4">
                                <input type="text" class="form-control" id="mEmpName" name="mEmpName" disabled>
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="" class="col-sm-2 col-form-label">부서</label>
                            <div class="col pr-4">
                                <input type="text" class="form-control" id="mDeptNm" name="mDeptNm" disabled>
                            </div>

                            <label for="" class="col-sm-2 col-form-label">직급</label>
                            <div class="col pr-4">
                                <input type="text" class="form-control" id="mJbgdNm" name="mJbgdNm" disabled>
                            </div>
                        </div>


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
                            <div class="col pr-4">
                                <input type="text" class="form-control" id="mTimeDiff" name="mTimeDiff" disabled>
                            </div>

                            <label for="mWorkState" class="col-sm-2 col-form-label">근무상태</label>
                            <div class="col pr-4">
                                <div class="form-control" id="mWorkState" name="mWorkState">근무상태</div>
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="mApprover" class="col-sm-2 col-form-label">결재자</label>
                            <div class="col pr-4">
                                <input type="text" class="form-control" id="mApprover" name="mApprover" disabled>
                            </div>

                            <label for="mWaStatus" class="col-sm-2 col-form-label">결재여부</label>
                            <div class="col pr-4">
                                <div class="form-control" id="mWaStatus" name="mWaStatus">결재여부</div>
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

        </div>
    </div>
</div>






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

    // workAdjAdmin(obj, addList);

    // 검색
	$("#searchBtn").on("click", function (e) {
		e.preventDefault();

		obj.searchStartDate = $("#searchStartDate").val();
		obj.searchEndDate = $("#searchEndDate").val();
		obj.searchState = $("#searchState").val();

		workAdjAdmin(obj,addList);
	});

    // 페이지 번호 클릭시
    pagingArea.on("click", "a", function (event) {
        event.preventDefault();
        var pageNo = $(this).data("page"); // 페이지 번호가 넘어옴
        obj.page = pageNo;
        workAdjAdmin(obj, addList);
    });


    // 상세보기
    $(document).on("click", ".btnDetail", function (event) {
        var waNo = $(this).closest(".workAdjTable").find("input[name='waNo']").val();
        // console.log(waNo);

        $.ajax({
            type: "get",
            url: `/everyware/admin/workAdj/getOneWorkAdjAdmin/\${waNo}`,
            contentType: 'application/json; charset=utf-8',
            dataType: "json",
            beforeSend: function (xhr) {
                xhr.setRequestHeader(headerName, token);
            },
            success: function (res) {
                console.log("res", res);

                var empId = res.empId;
                var empName = res.empName;
                var deptNm = res.deptNm;
                var jbgdNm = res.jbgdNm;
                var workDt = res.workDt;

                var waBfrBgngDt = res.waBfrBgngDt;
                var waBfrEndDt = res.waBfrEndDt;
                var waBgngDt = res.waBgngDt;
                var waEndDt = res.waEndDt;

                var timeDiff = calculateTimeDifference(waBgngDt, waEndDt);
                var workState = res.workState;
                // var approver = res.approver;
                var waStatus = res.waStatus;
                var waReason = res.waReason;

                $('#mEmpId').val(empId);
                $('#mEmpName').val(empName);
                $('#mDeptNm').val(deptNm);
                $('#mJbgdNm').val(jbgdNm);

                $('#mWorkDt').val(workDt);
                $('#mWaBfrBgngDt').val(waBfrBgngDt);
                $('#mWaBfrEndDt').val(waBfrEndDt);
                $('#mWaBgngDt').val(waBgngDt);
                $('#mWaEndDt').val(waEndDt);

                $('#mTimeDiff').val(timeDiff);
                // $('#mApprover').val(timeDiff);
                $('#mWorkState').val(workState);
                $('#mWaStatus').val(waStatus);
                $('#mWaReason').val(waReason);

                statusStr = "";

                if (waStatus == 4) {
                    statusStr += `<span class="badge bg-warning">진행</span>`;
                }
                if (waStatus == 6) {
                    statusStr += `<span class="badge bg-success">승인</span>`;
                }
                if (waStatus == 7) {
                    statusStr += `<span class="badge bg-danger">반려</span>`;
                }

                workStateStr = "";
                if (workState == "정상"){
                    workStateStr += `<span class="badge bg-success">정상</span>`;
                }
                if (workState == "연장"){
                    workStateStr += `<span class="badge bg-warning">연장</span>`;
                }
                if (workState == "지각"){
                    workStateStr += `<span class="badge bg-danger">지각</span>`;
                }
                if (workState == "조퇴"){
                    workStateStr += `<span class="badge bg-info">조퇴</span>`;
                }
                if (workState == "휴가"){
                    workStateStr += `<span class="badge bg-indigo color-palette">휴가</span>`;
                }   
                

                $('#mWaStatus').html(statusStr);
                $('#mWorkState').html(workStateStr);
                $('#modal-workAdjForm').modal("show");

            },
            error: function (xhr) {
                alert("Error: " + xhr.status);
            }

        });
    });





    workAdjSummary();
    workAdjAdminListJson();

});


// 목록
function workAdjAdmin(data, callback){
    $.ajax({
       url: `/everyware/admin/workAdj/getAdminWorkAdj`,
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

function addList(res){
    console.log("res", res);
    $("#workAdjAdmin").html("");
	$("#pagingArea").html("");

    var dataList = res.dataList;
    var workAdjAdminStr = "";
    var pagingAreaStr = res.workAdjAdmin.pagingHTML;

    var totalRecode = res.totalRecode;
    var approved = res.approved;
    var progress = res.progress;
    var rejected = res.rejected;

    if(dataList.length == 0){
        workAdjAdminStr += `<tr><td colspan='10'>조회하신 기록이 존재하지 않습니다.</td></tr>`;
    } else {
        for(let i = 0; i < dataList.length; i++){
            workAdjAdminStr += 
            `<tr class="workAdjTable">
                <input type="hidden" id="\${dataList[i].waNo}" name="waNo" value="\${dataList[i].waNo}">
                <th style="text-align: center;">\${dataList[i].workDt}</th>
                <th style="text-align: center;">\${dataList[i].workDw}</th>
                <th style="text-align: center;">\${dataList[i].empName}</th>
                <th style="text-align: center;">\${dataList[i].deptNm}</th>
                <th style="text-align: center;">\${dataList[i].jbgdNm}</th>
                <th style="text-align: center;">\${dataList[i].waBgngDt}</th>
                <th style="text-align: center;">\${dataList[i].waEndDt}</th>
                <th style="text-align: center;">`;
            
            var timeDiff = calculateTimeDifference(dataList[i].waBgngDt, dataList[i].waEndDt);
			workAdjAdminStr += timeDiff;        

            workAdjAdminStr += `</th>`;

            if (`\${dataList[i].waStatus}` == 4) {
                workAdjAdminStr +=
                `<th style="text-align: center;">
                    <input type="hidden" value="\${dataList[i].waStatus}" />
                    <span class="badge bg-warning">
                        진행
                    </span>
                </th>`;
            }

            if (`\${dataList[i].waStatus}` == 6) {
                workAdjAdminStr +=
                `<th style="text-align: center;">
                    <input type="hidden" value="\${dataList[i].waStatus}" />
                    <span class="badge bg-success">
                        승인
                    </span>
                </th>`;
            }

            if (`\${dataList[i].waStatus}` == 7) {
                workAdjAdminStr +=
                `<th style="text-align: center;">
                    <input type="hidden" value="\${dataList[i].waStatus}" />
                    <span class="badge bg-danger">
                        반려
                    </span>
                </th>`;
            }

            workAdjAdminStr += 
                `<th style="text-align: center;">
                    <button type="button" class="btn btn-tool bg-info btnDetail">
                        <i class="fas fa-pencil-alt"></i>
                    </button>
                </th>
            </tr>`;
        }
    }
    
    $("#workAdjAdmin").html(workAdjAdminStr);
    $("#pagingArea").html(pagingAreaStr);
}


// 수정--------------------------------------------

function workAdjAdminListJson(){
    $.ajax({
       url: `/everyware/workAdj/getWorkAdjAdminJson`,
       type: "get",
       contentType: 'application/json; charset=utf-8',
        dataType: "text",
        beforeSend: function (xhr) {
            // xhr.setRequestHeader("${_headerName}","${token}");
            xhr.setRequestHeader(headerName, token);
        },
        success: function (res) {
            console.log(res);
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
                        <th style="text-align: center;">\${dataList[i].workAdj.empId}</th>
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
        url: `/everyware/workAdj/getWorkAdjAdminSummary`,
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