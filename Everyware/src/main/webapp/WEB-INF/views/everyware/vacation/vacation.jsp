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
/*
.vacationText {
    margin-top: 20px;
    margin-bottom: 10px;
}
*/

.info-box {
    height: 100px;
}

.year{
    width: 200px;
    border: none;
    box-sizing: border-box;
    padding: 12px 13px;
}

.year{
    border: 1px solid #9B51E0;
    box-sizing: border-box;
    border-radius: 10px;
    outline: 3px solid #F8E4FF;
    border-radius: 10px;
}

</style>

<sec:authentication property="principal.employee.empId" var="empId"/>
<section class="content-header">
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h1>휴가관리</h1>
<!-- 				<div style="color: gray;">연도별 휴가사용내역을 확인합니다.</div> -->
			</div>
			
			<div class="col-sm-6">
				<ol class="breadcrumb float-sm-right">
					<li class="breadcrumb-item"><a href="#">Home</a></li>
					<li class="breadcrumb-item active">근태관리 > 휴가관리</li>
				</ol>
			</div>
		</div>
	</div><!-- /.container-fluid -->
 </section>







<section class="content py-3">
    <div class="container-fluid">
        
        <div class="row">
            <div class="col">
                <div class="card card-primary card-outline">
                    
                    <div class="row vacationText" style="margin: 10px;">
                        <div class="col">
<!--                             <h3>휴가관리</h3> -->
<!--                             <div style="color: gray;">연도별 휴가사용내역을 확인합니다.</div> -->
                        </div>
            
                        <div class="col">
                            <form class="input-group input-group-sm" id="searchForm">
                                
                                <div class="input-group">
                                    <select id="searchDate">
                                        <option value=""></option>
                                    </select>
                                    <div>년도</div>
                                </div>
                    
                                <sec:csrfInput />
                            </form>
                        </div>
                        
                    </div>
                    
                    <!-- Vacation Summary -->
                    <div class="card-body" style="display: block;">
                        <div class="row">
                            <div class="col-md-4 col-sm-6 col-12">
                                <div class="info-box bg-primary">
                                    <span class="info-box-icon"><i class="far fa-bookmark"></i></span>
                                    <div class="info-box-content">
                                        <span class="info-box-text">총 휴가일 수</span>
                                        <span class="info-box-number" id="totalRecode">15건</span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-4 col-sm-6 col-12">
                                <div class="info-box bg-success">
                                    <span class="info-box-icon"><i class="far fa-calendar-alt"></i></span>
                                    <div class="info-box-content">
                                        <span class="info-box-text">휴가 사용일 수</span>
                                        <span class="info-box-number" id="approved">0건</span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-4 col-sm-6 col-12">
                                <div class="info-box bg-warning">
                                    <span class="info-box-icon"><i class="far fa-star"></i></span>
                                    <div class="info-box-content">
                                        <span class="info-box-text">휴가 잔여일 수</span>
                                        <span class="info-box-number" id="leftVac">0건</span>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>

                </div>
            </div>
        </div>       

        <!-- 근태조정신청내역 Type1-->
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">휴가신청내역</h3>

                        <div class="card-tools">
                            <button type="button" id="btnMvacation" class="btn btn-primary">+ 휴가 신청하기</button>
                        </div>
                    </div>


                    <div class="card-body"  style="overflow-Y: scroll; height: 650px;display: block; padding: 0%">
                        <table class="table table-striped projects">
                            <thead>
                                <tr>
                                    <th style="text-align: center;">승인여부</th>
                                    <th style="text-align: center;">신청일자</th>
                                    <th style="text-align: center;">휴가구분</th>
                                    <th style="text-align: center;">시작일자-종료일자</th>
                                    <th style="text-align: center;">소요시간</th>
                                    <th style="text-align: center;">차감일수</th>
                                    <!-- 상세보기 -->
                                    <th style="width: 10px"></th>
                                </tr>
                            </thead>
                            <tbody id="vacationList">
                                <!-- vacationList -->
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




<!-- modal-vacationForm-->
<div class="modal fade" id="modal-vacationForm">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="modalTtl">휴가신청서</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <form class="form-horizontal" method="post" id="vacationForm" action="/everyware/approval/new/2">
                <div class="modal-body">
                    <input type="hidden" id="empId" name="empId" value="${empId}">

                    <div class="card-body">
                        <div class="form-group row">
                            <label for="" class="col-sm-2 col-form-label">신청일자</label>
                            <div class="col-sm-10 pr-4">
                                <input type="text" class="form-control" id="todayStr" name="" disabled>
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="" class="col-sm-2 col-form-label">휴가항목</label>
                            <div class="col pr-4">
                                <div class="form-group">
                                    <select id="vacationItemSelect" class="form-control" name="viType">
                                    	<option>종일휴가</option>
                                    </select>
                                </div>
                            </div>

                            <label for="" class="col-sm-2 col-form-label">차감일수</label>
                            <div class="col pr-4">
                                <div class="form-control" id="viDay" name="viDay">1</div>
                            </div>
                        </div>
            
                        <div class="form-group row">
                            <label for="" class="col-sm-2 col-form-label">휴가일자</label>
                            <div class="col-sm-10 pr-4">
                                <!-- <div class="form-group"> -->
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="far fa-calendar-alt"></i>
                                            </span>
                                        </div>

                                        <input type="text" class="form-control float-right" id="reservation" name="vacPeriod">
                                    </div>
                                <!-- </div> -->
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="" class="col-sm-2 col-form-label">첨부파일</label>
                            <div class="col-sm-10 pr-4">
                                <input type="file" class="form-control" id="" name="">
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="" class="col-sm-2 col-form-label">신청사유</label>
                            <div class="col-sm-10 pr-4">
                                <div class="input-group mb-3">
                                    <textarea class="form-control" id="" name="vacReason" rows="10" placeholder="신청사유를 입력하세요."></textarea>
                                </div>
                            </div>
                        </div> 


                    </div>
                </div>
                
                <div class="modal-footer justify-content-between">
                    <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                    <div class="float-right"> 
                        <button type="submit" class="btn btn-primary" id="btnToDoAdd">저장</button>
                        <!-- <button type="button" class="btn btn-danger btnDel" data-tdNo="">Delete</button> -->
                    </div>
                </div>
            </form>

        </div>
    </div>
</div>










<script>
    $(function () {
    
        // var yearSelect = $("#year");
        var searchDate = $("#searchDate");
        var currentYear = new Date().getFullYear();
        
        $('#reservation').daterangepicker()
        $("#todayStr").val(getCurrentDate());
    
    
        // select 현재 년도 설정
        for (var i = currentYear; i >= 2000; i--) {
            var option = $("<option></option>");
            option.val(i);
            option.text(i);
            
            if (i === currentYear) {
                option.prop("selected", true);
            }
    
            searchDate.append(option);
        }
        
    


        // +휴가 신청하기
        $(document).on("click", "#btnMvacation", function () {
            console.log("btnMvacation");
            $('#modal-vacationForm').modal("show");
        });
        var selectTarget = $('.selectbox select');
    
        // focus 가 되었을 때와 focus 를 잃었을 때
        selectTarget.on({
            'focus': function () {
                $(this).parent().addClass('focus');
            },
            'blur': function () {
                $(this).parent().removeClass('focus');
            }
        });
    
        selectTarget.change(function () {
            var select_name = $(this).children('option:selected').text();
            $(this).siblings('label').text(select_name);
            $(this).parent().removeClass('focus');
        });
    
    
    
        //
        $("#searchDate").on("change", function () {
            var selectedYear = $(this).val(); // Get the selected year
            vacation2(selectedYear); // Call the function to update data based on selected year
            console.log(selectedYear);
        });









        vacation2();
        vacSummary();
    
    });
    
    // 항목
    function vacation(data, callback){  
        $.ajax({
            url: `/everyware/vacation/getVacationList`,
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
    
    
    // function addList(res){
    //     console.log(res);
    
    //     var vacItemList = res.vacItemList;
    //     var selectElement = $("#vacationItemSelect");
    
    //     selectElement.empty();
    
    //     for (var i = 0; i < vacItemList.length; i++) {
    //         var item = vacItemList[i];
    //         var option = $("<option></option>").val(item.viType).text(item.viType);
    //         selectElement.append(option);
    //     }
    
    
    //     // 목록
    //     var dataList = res.dataList;
    //     var vacationStr = "";
    //     if(dataList.length == 0){
    //         vacationStr += `<tr><td colspan='7'>조회하신 기록이 존재하지 않습니다.</td></tr>`;
    //     } else {
    //         for(let i = 0; i < dataList.length; i++){
    //             vacationStr += 
    //             `<tr class="vacationTable">
    //                 <input type="hidden" id="\${dataList.aprv_sn}">
    //                 <th style="text-align: center;">\${dataList[i].atrzDmndDt}</th>
    //                 <th style="text-align: center;">\${dataList[i].viNo}</th>
    //                 <th style="text-align: center;">\${dataList[i].vacBgngDt} - \${dataList[i].vacEndDt}</th>
    //                 <th style="text-align: center;">승인여부</th>
    //                 <th style="text-align: center;">
    //                     <button type="button" class="btn btn-tool bg-info btnDetail">
    //                         <i class="fas fa-pencil-alt"></i>
    //                     </button>
    //                 </th>
    //             </tr>`
    
    //         }
    //     }
    
    //     $("#vacationList").html(vacationStr);
    
    // }
    
    
    // 목록
    function vacation2(){  
    
        $.ajax({
            url: `/everyware/vacation/getVacationJson`,
            type: "get",
            contentType: 'application/json; charset=utf-8',
            dataType: "text",
            beforeSend: function (xhr) {
                xhr.setRequestHeader(headerName, token);
            },
            success: function (res) {
                var dataList = JSON.parse(res);
                console.log('dataList: ' + dataList);

                var vacStr = "";

                if(dataList.length == 0){
                    vacStr += `<tr><td colspan='8'>조회하신 기록이 존재하지 않습니다.</td></tr>`;
                }


                $("#vacationList").html(vacStr);

            },
            error: function (xhr) {
                alert("Error: " + xhr.status);
            }
        });
    
    }
    
    
    
    function vacSummary() {
        $.ajax({
            url: `/everyware/vacation/getVacationSummary`,
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
                var approved = res.approved;    // 휴사 사용일수
                var progress = res.progress;
                var rejected = res.rejected;

                var vacations = 15; // 휴가일수
                
                var leftover = vacations-approved;  //잔여일수


                // $("#totalRecode").text(totalRecode + '건');
                $("#approved").text(approved + '건');
                $("#progress").text(progress + '건');
                $("#leftover").text(leftover + '건');
            },
            error: function (xhr) {
                alert("Error: " + xhr.status);
            }
        });    
    }



    
    
    // 오늘 날짜 설정
    function getCurrentDate() {
        const now = new Date();
        const year = now.getFullYear();
        const month = String(now.getMonth() + 1).padStart(2, '0');
        const day = String(now.getDate()).padStart(2, '0');
        return `\${year}-\${month}-\${day}`;
    }
    
    
    </script>