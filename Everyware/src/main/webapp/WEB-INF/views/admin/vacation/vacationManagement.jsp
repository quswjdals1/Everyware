<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
    let headerName = "${_csrf.headerName}"
    let token = "${_csrf.token}"
</script>

<style>

input:disabled {
  background-color: transparent;
  border: none;
  color: black;
}

select:disabled {
  background-color: transparent;
  border: none; 
  color: black;
}

</style>

<section class="content-header">
	<div class="container-fluid">
		<div class="row mb-2">
			<div class="col-sm-6">
				<h1>휴가설정</h1>
			</div>
			
			<div class="col-sm-6">
				<ol class="breadcrumb float-sm-right">
					<li class="breadcrumb-item"><a href="#">Home</a></li>
					<li class="breadcrumb-item active">근태관리 > 휴가설정</li>
				</ol>
			</div>
		</div>
	</div><!-- /.container-fluid -->
 </section>

<section class="content-header">
	<div class="container-fluid">

        <div class="row">
            <div class="col">
            <div class="card card-primary card-outline card-tabs">
                <div class="card-header p-0 pt-1 border-bottom-0">
                <ul class="nav nav-tabs" id="custom-tabs-three-tab" role="tablist">
                    <!-- Tab1 -->
                    <li class="nav-item">
                        <a class="nav-link active" id="custom-tabs-three-hldy-tab" data-toggle="pill" href="#custom-tabs-three-hldy" role="tab" aria-controls="custom-tabs-three-hldy" aria-selected="true">공통휴일관리</a>
                    </li>
                    
                    <!-- Tab2 -->
                    <li class="nav-item">
                        <a class="nav-link" id="custom-tabs-three-vacItem-tab" data-toggle="pill" href="#custom-tabs-three-vacItem" role="tab" aria-controls="custom-tabs-three-vacItem" aria-selected="false">휴가항목관리</a>
                    </li>
                    
                    <!-- Tab3 -->
                    <li class="nav-item">
                        <a class="nav-link" id="custom-tabs-three-workYear-tab" data-toggle="pill" href="#custom-tabs-three-workYear" role="tab" aria-controls="custom-tabs-three-workYear" aria-selected="false">휴가일수관리</a>
                    </li>
                    
                </ul>
                </div>

                <div class="card-body">
                    <div class="tab-content" id="custom-tabs-three-tabContent">
                        <!-- Tab1 -->
                        <div class="tab-pane fade show active" id="custom-tabs-three-hldy" role="tabpanel" aria-labelledby="custom-tabs-three-hldy-tab">
                            <div style="margin: 10px;" class="text-right">
                                <button type="button" id="AddHldyRow" class="btn btn-primary">+ 휴일 추가하기</button>
                            </div>

                            <div>
                                <table class="table table-striped projects" id="hldyTable">
                                    <thead>
                                        <tr>
                                            <th class="text-center">순번</th>
                                            <th class="text-center">일자</th>
                                            <th class="text-center">휴일명</th>
                                            <th class="text-center">휴일여부</th>
                                            <th class="text-center" style="width: 500px;">비고</th>
                                            <th class="text-center"></th>
                                        </tr>
                                    </thead>
                                    <tbody id="hldyList">
                                        <!-- hldyList -->
                                    </tbody>
                                </table>
                            </div>


                        </div>
                        
                        <!-- Tab2 -->
                        <div class="tab-pane fade" id="custom-tabs-three-vacItem" role="tabpanel" aria-labelledby="custom-tabs-three-vacItem-tab">

                            <div style="margin: 10px;" class="text-right">
                                <button type="button" id="addVacItemRow" class="btn btn-primary">+ 휴가항목 추가하기</button>
                            </div>
        
                            <div>
                                <table class="table table-striped projects" id="vacItemTable">
                                    <thead>
                                        <tr>
                                            <th class="text-center">순번</th>
                                            <th class="text-center">휴가구분</th>
                                            <th class="text-center">차감일수</th>
                                            <th class="text-center" style="width: 500px;">휴가설명</th>
                                            <th class="text-center"></th>
                                        </tr>
                                    </thead>
                                    <tbody id="vacItemList">
                                        <!-- vacItemList -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                        <!-- Tab3 -->
                        <div class="tab-pane fade" id="custom-tabs-three-workYear" role="tabpanel" aria-labelledby="custom-tabs-three-workYear-tab">
                            <div style="margin: 10px;" class="text-right">
                                <button type="button" id="AddWorkYearRow" class="btn btn-primary">+ 휴가일수 추가하기</button>
                            </div>
    
                            <div>
                                <table class="table table-striped projects" id="workYearTable">
                                    <thead>
                                        <tr>
                                            <th class="text-center">순번</th>
                                            <th class="text-center">근속연수</th>
                                            <th class="text-center">휴가일수</th>
                                            <th class="text-center" style="width: 500px;">비고</th>
                                            <th class="text-center"></th>
                                        </tr>
                                    </thead>
                                    <tbody id="workYearList">
                                        <!-- workYearList -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                    </div>
                </div>
                <!-- /.card -->
            </div>
            </div>
        </div>

    </div>
</section>

<script>
$(function(){

    HldyList();
    vacItemList();
    workYearList();






	// 수정 - 저장
	$(document).on("click", ".hldyUpdate", function () {
		console.log("hldyUpdate");

        const hldyNo = $(this).data('hldyno');
		const row = $(this).closest("tr");
		const hldyDt = row.find("td:eq(1) input").val();
		const hldyNm = row.find("td:eq(2) input").val();
		const hldyYn = row.find("td:eq(3) select").val();
		const hldyMemo = row.find("td:eq(4) input").val();

		let hldyData = {
            hldyNo : hldyNo,
			hldyDt : hldyDt,
			hldyNm : hldyNm,
			hldyYn : hldyYn,
            hldyMemo : hldyMemo
		};

		console.log("hldyData", hldyData);

		if (hldyDt == null || hldyDt == "") {
			Swal.fire(
				'일자를 선택해주세요.',
				'',
				'warning'
			)
			return false;
		}

		if (hldyNm == null || hldyNm == "") {
			Swal.fire(
				'휴일명을 입력해주세요.',
				'',
				'warning'
			)
			return false;
		}

		if (hldyYn == null || hldyYn == "") {
			Swal.fire(
				'휴일여부를 선택해주세요.',
				'',
				'warning'
			)
			return false;
		}


		$.ajax({
			type : "put",
			url : '/everyware/admin/vacationManagement/editHldy',
			contentType: "application/json; charset=utf-8",
			data: JSON.stringify(hldyData),
			dataType:"text",
			beforeSend: function (xhr) {
				xhr.setRequestHeader(headerName,token);
			},
			success: function(res){
				console.log(res);
				if (res == "success") {
					Swal.fire(
						'수정되었습니다.',
						'',
						'success'
					).then(function () {
						HldyList();
					});

				} else {
					Swal.fire(
						'다시 시도해 주세요.',
						'',
						'error'
					);
				}
			}
		});

	});


	// 수정 - 저장
	$(document).on("click", ".viUpdate", function () {
		console.log("viUpdate");

		const viNo = $(this).data('vino');
		const row = $(this).closest("tr");
		const viType = row.find("td:eq(1) input").val();
		const viDay = row.find("td:eq(2) input").val();
		const viMemo = row.find("td:eq(3) input").val();

		let vacItemData = {
			viNo : viNo,
			viType : viType,
			viDay : viDay,
			viMemo : viMemo
		};

		console.log("vacItemData", vacItemData);

		if (viType == null || viType == "") {
			Swal.fire(
				'휴가항목를 입력해주세요.',
				'',
				'warning'
			)
			return false;
		}

		if (viDay == null || viDay == "") {
			Swal.fire(
				'차감일수를 입력해주세요.',
				'',
				'warning'
			)
			return false;
		}


		$.ajax({
			type : "put",
			url : '/everyware/admin/vacation/vacItem/editVacItem',
			contentType: "application/json; charset=utf-8",
			data: JSON.stringify(vacItemData),
			dataType:"text",
			beforeSend: function (xhr) {
				xhr.setRequestHeader(headerName,token);
			},
			success: function(res){
				console.log(res);
				if (res == "success") {
					Swal.fire(
						'수정되었습니다.',
						'',
						'success'
					).then(function () {
						vacItemList();
					});

				} else {
					Swal.fire(
						'다시 시도해 주세요.',
						'',
						'error'
					);
				}
			}
		});

	});


	// 수정 - 저장
	$(document).on("click", ".wyUpdate", function () {
		console.log("wyUpdate");

		const wyNo = $(this).data('wyno');
		const row = $(this).closest("tr");
		const wyYear = row.find("td:eq(1) input").val();
		const wyHldy = row.find("td:eq(2) input").val();
		const wyMemo = row.find("td:eq(3) input").val();

		let workYearData = {
			wyNo : wyNo
			, wyYear : wyYear
			, wyHldy : wyHldy
			, wyMemo : wyMemo
		};

		console.log("workYearData", workYearData);

		if (wyYear == null || wyYear == "") {
			Swal.fire(
				'근속연수를 입력해주세요.',
				'',
				'warning'
			)
			return false;
		}

		if (wyHldy == null || wyHldy == "") {
			Swal.fire(
				'휴가일수를 입력해주세요.',
				'',
				'warning'
			)
			return false;
		}

		$.ajax({
			type : "put",
			url : '/everyware/admin/workYear/editWorkYear',
			contentType: "application/json; charset=utf-8",
			data: JSON.stringify(workYearData),
			dataType:"text",
			beforeSend: function (xhr) {
				xhr.setRequestHeader(headerName,token);
			},
			success: function(res){
				console.log(res);
				if (res == "success") {
					Swal.fire(
						'수정되었습니다.',
						'',
						'success'
					).then(function () {
						workYearList();
					});

				} else {
					Swal.fire(
						'다시 시도해 주세요.',
						'',
						'error'
					);
				}
			}
		});

	});










	// 수정 버튼 
	$(document).on("click", ".hldyEdit", function () {
		console.log("hldyEdit");

		const row = $(this).closest("tr");
		const inputs = row.find("input");
		const select = row.find("select");

		inputs.removeAttr("disabled");
		select.removeAttr("disabled");

		inputs.eq(0).focus();

		$(this).text("저장");
		$(this).removeClass("hldyEdit").addClass("hldyUpdate");
		$(this).removeClass("btn-info").addClass("btn-primary");
	});


    // 수정 버튼 
	$(document).on("click", ".viEdit", function () {
        console.log("viEdit");

        const row = $(this).closest("tr");
        row.find("input").prop("disabled", false);

        $(this).text("저장");
        $(this).removeClass("viEdit").addClass("viUpdate");
        $(this).removeClass("btn-info").addClass("btn-primary"); 
    });


    // 수정 버튼 
	$(document).on("click", ".wyEdit", function () {
        console.log("wyEdit");

        const row = $(this).closest("tr");
        row.find("input").prop("disabled", false);

        $(this).text("저장");
        $(this).removeClass("wyEdit").addClass("wyUpdate");
        $(this).removeClass("btn-info").addClass("btn-primary"); 
    });






    // 취소
    $(document).on("click", ".btnCancel", function () {
        console.log("btnCancel");
        $(this).closest("tr").remove();
    });







    // 추가
    $(document).on("click", "#AddHldyRow", function () {
		addHldyRow();
	});

    $(document).on("click", "#addVacItemRow", function () {
        addVacItemRow();
	});

    $(document).on("click", "#AddWorkYearRow", function () {
        addWorkYearRow();
	});
    
    





    
    // 삭제
	$(document).on('click', '.hldyDel', function () {
		console.log("hldyDel");

		const hldyNo = $(this).data('hldyno');
        console.log("hldyNo : ", hldyNo);
		
		Swal.fire({
			title: '삭제하시겠습니까?',
			icon: 'warning',

			showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
			confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			cancelButtonText: '취소', // cancel 버튼 텍스트 지정

			reverseButtons: true, // 버튼 순서 거꾸로

		}).then(result => {
			// 만약 Promise리턴을 받으면,
			if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면

				$.ajax({
					type: "delete",
					url: `/everyware/admin/vacationManagement/delHldy/\${hldyNo}`,
					contentType: "application/json; charset=utf-8",
					dataType: "text",
					beforeSend: function (xhr) {
						xhr.setRequestHeader(headerName, token);
					},
					success: function (res) {
						if (res == "success") {
							Swal.fire(
								'삭제되었습니다.',
								'',
								'success'
							).then(function () {
								HldyList();
							});
						} else {
							Swal.fire(
								'다시 시도해 주세요.',
								'',
								'error'
							);
						}
					},
					error: function (xhr) {
						alert("Error: " + xhr.status);
					}
				});
			}
		});


	});


    // 삭제
	$(document).on('click', '.viDel', function () {
		console.log("viDel");

		const viNo = $(this).data('vino');
        console.log("viNo : ", viNo);
		
		Swal.fire({
			title: '삭제하시겠습니까?',
			icon: 'warning',

			showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
			confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			cancelButtonText: '취소', // cancel 버튼 텍스트 지정

			reverseButtons: true, // 버튼 순서 거꾸로

		}).then(result => {
			// 만약 Promise리턴을 받으면,
			if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면


				$.ajax({
					type: "delete",
					url: `/everyware/admin/vacation/vacItem/delVacItem/\${viNo}`,
					contentType: "application/json; charset=utf-8",
					dataType: "text",
					beforeSend: function (xhr) {
						xhr.setRequestHeader(headerName, token);
					},
					success: function (res) {
						if (res == "success") {
							Swal.fire(
								'삭제되었습니다.',
								'',
								'success'
							).then(function () {
								vacItemList();
							});
						} else {
							Swal.fire(
								'다시 시도해 주세요.',
								'',
								'error'
							);
						}
					},
					error: function (xhr) {
						alert("Error: " + xhr.status);
					}
				});
			}
		});


	});



	// 삭제
	$(document).on('click', '.wyDel', function () {
		console.log("wyDel");

		const wyNo = $(this).data('wyno');
		console.log("wyNo : ", wyNo);

		Swal.fire({
			title: '삭제하시겠습니까?',
			icon: 'warning',

			showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
			confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
			cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
			confirmButtonText: '확인', // confirm 버튼 텍스트 지정
			cancelButtonText: '취소', // cancel 버튼 텍스트 지정

			reverseButtons: true, // 버튼 순서 거꾸로

		}).then(result => {
			// 만약 Promise리턴을 받으면,
			if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면

				$.ajax({
					type: "delete",
					url: `/everyware/admin/workYear/delWorkYear/\${wyNo}`,
					contentType: "application/json; charset=utf-8",
					dataType: "text",
					beforeSend: function (xhr) {
						xhr.setRequestHeader(headerName, token);
					},
					success: function (res) {
						if (res == "success") {
							Swal.fire(
								'삭제되었습니다.',
								'',
								'success'
							).then(function () {
								workYearList();
							});
						} else {
							Swal.fire(
								'다시 시도해 주세요.',
								'',
								'error'
							);
						}
					},
					error: function (xhr) {
						alert("Error: " + xhr.status);
					}
				});

			}
		});


	});





	// 등록 - 저장
	$(document).on("click", ".hldySave", function () {
		console.log("hldySave")

		const row = $(this).closest("tr");
		const hldyDt = row.find("td:eq(1) input").val();
		const hldyNm = row.find("td:eq(2) input").val();
		const hldyYn = row.find("td:eq(3) select").val();
		const hldyMemo = row.find("td:eq(4) input").val();

		let hldyData = {
			hldyDt : hldyDt,
			hldyNm : hldyNm,
			hldyYn : hldyYn,
            hldyMemo : hldyMemo
		};

		console.log("hldyData", hldyData);

		if (hldyDt == null || hldyDt == "") {
			Swal.fire(
				'일자를 선택해주세요.',
				'',
				'warning'
			)
			return false;
		}

		if (hldyNm == null || hldyNm == "") {
			Swal.fire(
				'휴일명을 입력해주세요.',
				'',
				'warning'
			)
			return false;
		}

		if (hldyYn == null || hldyYn == "") {
			Swal.fire(
				'휴일여부를 선택해주세요.',
				'',
				'warning'
			)
			return false;
		}

		$.ajax({
			type : "POST",
			url : '/everyware/admin/vacationManagement/addHldy',
			contentType: "application/json; charset=utf-8",
            data: JSON.stringify(hldyData),
            dataType:"text",
            beforeSend: function (xhr) {
                xhr.setRequestHeader(headerName,token);
            },
			success: function(res){
				console.log(res);
				if (res == "success") {
                    Swal.fire(
                        '등록되었습니다.',
                        '',
                        'success'
                    ).then(function () {
						HldyList();
                    });

                } else {
                    Swal.fire(
                        '다시 시도해 주세요.',
                        '',
                        'error'
                    );
                }
			}
		});

	});



	// 등록 - 저장
	$(document).on("click", ".viSave", function () {
		console.log("viSave")

		const row = $(this).closest("tr");
		const viType = row.find("td:eq(1) input").val();
		const viDay = row.find("td:eq(2) input").val();
		const viMemo = row.find("td:eq(3) input").val();

		let vacItemData = {
			viType : viType,
			viDay : viDay,
			viMemo : viMemo
		};

		console.log("workYearData", vacItemData);

		if (viType == null || viType == "") {
			Swal.fire(
				'휴가항목를 입력해주세요.',
				'',
				'warning'
			)
			return false;
		}

		if (viDay == null || viDay == "") {
			Swal.fire(
				'차감일수를 입력해주세요.',
				'',
				'warning'
			)
			return false;
		}

		$.ajax({
			type : "POST",
			url : '/everyware/admin/vacation/vacItem/addVacItem',
			contentType: "application/json; charset=utf-8",
            data: JSON.stringify(vacItemData),
            dataType:"text",
            beforeSend: function (xhr) {
                xhr.setRequestHeader(headerName,token);
            },
			success: function(res){
				console.log(res);
				if (res == "success") {
                    Swal.fire(
                        '등록되었습니다.',
                        '',
                        'success'
                    ).then(function () {
						vacItemList();
                    });

                } else {
                    Swal.fire(
                        '다시 시도해 주세요.',
                        '',
                        'error'
                    );
                }
			}
		});

	});



    // 등록 - 저장
	$(document).on("click", ".wySave", function () {
        console.log("wySave");
		const row = $(this).closest("tr");
        const wyYear = row.find("td:eq(1) input").val();
        const wyHldy = row.find("td:eq(2) input").val();
        const wyMemo = row.find("td:eq(3) input").val();

		let workYearData = {
			wyYear : wyYear,
			wyHldy : wyHldy,
			wyMemo : wyMemo
		};

		console.log("workYearData", workYearData);

		if (wyYear == null || wyYear == "") {
			Swal.fire(
				'근속연수를 입력해주세요.',
				'',
				'warning'
			)
			return false;
		}

		if (wyHldy == null || wyHldy == "") {
			Swal.fire(
				'휴가일수를 입력해주세요.',
				'',
				'warning'
			)
			return false;
		}

		$.ajax({
			type : "POST",
			url : '/everyware/admin/workYear/addWorkYear',
			contentType: "application/json; charset=utf-8",
            data: JSON.stringify(workYearData),
            dataType:"text",
            beforeSend: function (xhr) {
                xhr.setRequestHeader(headerName,token);
            },
			success: function(res){
				console.log(res);
				if (res == "success") {
                    Swal.fire(
                        '등록되었습니다.',
                        '',
                        'success'
                    ).then(function () {
						workYearList();
                    });

                } else {
                    Swal.fire(
                        '다시 시도해 주세요.',
                        '',
                        'error'
                    );
                }
			}
		});

	});
    
    
    
    
    
    
    
    
    
    
    
    
    
    









});







// Hldy목록
function HldyList() {

    $.ajax({
        url: `/everyware/admin/vacationManagement/getHldy`,
        type: "GET",
        contentType: 'application/json; charset=utf-8',
        dataType: "json",
        beforeSend: function (xhr) {
            xhr.setRequestHeader(headerName, token);
        },
        success: function (res) {
            console.log(res);

            var hldyStr = "";
            var hldy = res.hldy;

            if (hldy.length != 0) {
                for (let i = 0; i < hldy.length; i++) {
                    var rownum = i + 1;
                    hldyStr +=
                    `<tr>
                        <input type="hidden" id="\${hldy[i].hldyNo}" name="hldyNo" value="\${hldy[i].hldyNo}>
                        <td class="text-center">\${hldy[i].rownum}</td>
                        <td class="text-center">\${rownum}</td>
                        <td class="text-center"><input type="Date" class="" style="border:0 padding-top:2; text-align:center;" id="\${hldy[i].hldyDt}" name="hldyDt" value="\${hldy[i].hldyDt}" disabled></td>
                        <td class="text-center"><input type="text" class="" style="border:0 padding-top:2; text-align:center;" id="\${hldy[i].hldyNm}" name="hldyNm" value="\${hldy[i].hldyNm}" disabled></td>
                        <td class="text-center">
							<select class="" id="hldyYn" name="hldyYn" disabled>
								<option value="Y" \${hldy[i].hldyYn === 'Y' ? 'selected' : ''}>Y</option>
								<option value="N" \${hldy[i].hldyYn === 'N' ? 'selected' : ''}>N</option>
							</select>
						</td>
                        <td class="text-center"><input type="text" class="" style="border:0 padding-top:2; text-align:center; width: 500px;" id="\${hldy[i].hldyMemo}" name="hldyDay" value="\${hldy[i].hldyMemo != null ? hldy[i].viMemo : ''}" disabled></td>
                        <td class="text-center">
                            <button type="button" id="hldyEdit" class="btn btn-info hldyEdit" data-hldyNo="\${hldy[i].hldyNo}">수정</button>
                            <button type="button" id="hldyDel" class="btn btn-danger hldyDel" data-hldyNo="\${hldy[i].hldyNo}">삭제</button>
                        </td>
                    </tr>`;
                }

            } else {
                hldyStr +=
                `<tr>
                    <td colspan="6">조회하신 기록이 존재하지 않습니다.</td>
                </tr>`;
            }

            $("#hldyList").html(hldyStr);


        },
        error: function (xhr) {
            alert("Error: " + xhr.status);
        }
    });

};



// vacItem목록
function vacItemList() {

    $.ajax({
        url: `/everyware/admin/vacation/vacItem/vacItemList`,
        type: "GET",
        contentType: 'application/json; charset=utf-8',
        dataType: "json",
        beforeSend: function (xhr) {
            xhr.setRequestHeader(headerName, token);
        },
        success: function (res) {
            console.log(res);

            var vacItemStr = "";
            var vacItem = res.vacItem;

            if (vacItem.length != 0) {
                for (let i = 0; i < vacItem.length; i++) {
                    var rownum = i + 1;
                    vacItemStr +=
                    `<tr>
                        <input type="hidden" id="\${vacItem[i].viNo}" name="viNo" value="\${vacItem[i].viNo}>
                        <td class="text-center">\${vacItem[i].rownum}</td>
                        <td class="text-center">\${rownum}</td>
                        <td class="text-center"><input type="text" class="" style="border:0 padding-top:2; text-align:center;" id="\${vacItem[i].viType}" name="viType" value="\${vacItem[i].viType}" disabled></td>
                        <td class="text-center"><input type="text" class="" style="border:0 padding-top:2; text-align:center;" id="\${vacItem[i].viDay}" name="viDay" value="\${vacItem[i].viDay}" disabled></td>
                        <td class="text-center"><input type="text" class="" style="border:0 padding-top:2; text-align:center; width: 500px;" id="\${vacItem[i].viMemo}" name="viMemo" value="\${vacItem[i].viMemo != null ? vacItem[i].viMemo : ''}" disabled></td>
                        <td class="text-center">
                            <button type="button" id="viEdit" class="btn btn-info viEdit" data-viNo="\${vacItem[i].viNo}">수정</button>
                            <button type="button" id="viDel" class="btn btn-danger viDel" data-viNo="\${vacItem[i].viNo}">삭제</button>
                        </td>
                    </tr>`;
                }

            } else {
                vacItemStr +=
                `<tr>
                    <td colspan="5">조회하신 기록이 존재하지 않습니다.</td>
                </tr>`;
            }

            $("#vacItemList").html(vacItemStr);


        },
        error: function (xhr) {
            alert("Error: " + xhr.status);
        }
    });

};



// workYear목록
function workYearList() {
	$.ajax({
		url: `/everyware/admin/workYear/workYearList`,
		type: "GET",
		contentType: 'application/json; charset=utf-8',
		dataType: "json",
		beforeSend: function (xhr) {
			xhr.setRequestHeader(headerName, token);
		},
		success: function (res) {
			console.log(res);

			var workYearStr = "";
			var workYear = res.workYear;

			if (workYear.length != 0) {
				for (let i = 0; i < workYear.length; i++) {
					var rownum = i + 1;
					workYearStr +=
					`<tr>
						<input type="hidden" id="\${workYear[i].wyNo}" name="wyNo" value="\${workYear[i].wyNo}>
						<td class="text-center">\${workYear[i].rownum}</td>
						<td class="text-center">\${rownum}</td>
						<td class="text-center"><input type="text" class="" style="border:0 padding-top:2; text-align:center;" id="\${workYear[i].wyYear}" name="wyYear" value="\${workYear[i].wyYear}" disabled></td>
						<td class="text-center"><input type="text" class="" style="border:0 padding-top:2; text-align:center;" id="\${workYear[i].wyHldy}" name="wyHldy" value="\${workYear[i].wyHldy}" disabled></td>
						<td class="text-center"><input type="text" class="" style="border:0 padding-top:2; text-align:center; width: 500px;" id="\${workYear[i].wyMemo}" name="wyMemo" value="\${workYear[i].wyMemo != null ? workYear[i].wyMemo : ''}" disabled></td>
						<td class="text-center">
							<button type="button" id="wyEdit" class="btn btn-info wyEdit" data-wyNo="\${workYear[i].wyNo}">수정</button>
							<button type="button" id="wyDel" class="btn btn-danger wyDel" data-wyNo="\${workYear[i].wyNo}">삭제</button>
						</td>
					</tr>`;
				}

			} else {
				workYearStr +=
				`<tr>
					<td colspan="5">조회하신 기록이 존재하지 않습니다.</td>
				</tr>`;
			}

			$("#workYearList").html(workYearStr);


		},
		error: function (xhr) {
			alert("Error: " + xhr.status);
		}
	});


}











// 행추가
function addHldyRow() {
    if ($("#custom-tabs-three-hldy").hasClass("show") && $("#custom-tabs-three-hldy").hasClass("active")) {
        const newRowHtml =
            `<tr>
                <td class="text-center"></td>
                <td class="text-center"><input type="date"></td>
                <td class="text-center"><input type="text"></td>
                <td class="text-center">
                    <select class="" id="hldyYn" name="hldyYn">
                        <option value="Y" selected="selected">Y</option>
                        <option value="N">N</option>
                    </select>
                </td>
                <td class="text-center"><input type="text"></td>
                <td class="text-center">
                    <button type="button" id="hldySave" class="btn btn-primary hldySave">저장</button>
                    <button type="button" id="btnCancel" class="btn btn-warning btnCancel">취소</button>
                </td>
            </tr>`;

        $("table#hldyTable tbody#hldyList").append(newRowHtml);
    }
}


function addVacItemRow() {
    if ($("#custom-tabs-three-vacItem").hasClass("show") && $("#custom-tabs-three-vacItem").hasClass("active")) {

        const newRowHtml =
            `<tr>
                <td class="text-center"></td>
                <td class="text-center"><input type="text"></td>
                <td class="text-center"><input type="text"></td>
                <td class="text-center"><input type="text"></td>
                <td class="text-center">
                    <button type="button" id="viSave" class="btn btn-primary viSave">저장</button>	
                    <button type="button" id="btnCancel" class="btn btn-warning btnCancel">취소</button>	
                </td>
            </tr>`;


        $("table#vacItemTable tbody#vacItemList").append(newRowHtml);
    }
}


function addWorkYearRow() {
    if ($("#custom-tabs-three-workYear").hasClass("show") && $("#custom-tabs-three-workYear").hasClass("active")) {

        const newRowHtml =
            `<tr>
                <td class="text-center"></td>
                <td class="text-center"><input type="text"></td>
                <td class="text-center"><input type="text"></td>
                <td class="text-center"><input type="text"></td>
                <td class="text-center">
                    <button type="button" id="wySave" class="btn btn-primary wySave">저장</button>	
                    <button type="button" id="btnCancel" class="btn btn-warning btnCancel">취소</button>	
                </td>
            </tr>`;

        $("table#workYearTable tbody#workYearList").append(newRowHtml);
    }
}





</script>

