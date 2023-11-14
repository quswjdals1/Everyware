<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
.tagify{    
  width: 100%;
  max-width: 700px;
  background: rgba(white, .8);
    max-height:100px!important;
  overflow-y: auto;
  overflow-x: hidden;
    width: 100%;
  max-width: 100%;
}

/* Suggestions items */
.tagify__dropdown.users-list .tagify__dropdown__item{
    padding: .5em .7em;
    display: grid;
    grid-template-columns: auto 1fr;
    gap: 0 1em;
    grid-template-areas: "avatar name"
                         "avatar email";
}
.download_btn{
	float: right;
}

.tagify__dropdown.users-list .tagify__dropdown__item:hover .tagify__dropdown__item__avatar-wrap{
    transform: scale(1.2);
}

.tagify__dropdown.users-list .tagify__dropdown__item__avatar-wrap{
    grid-area: avatar;
    width: 36px;
    height: 36px;
    border-radius: 50%;
    overflow: hidden;
    background: #EEE;
    transition: .1s ease-out;
}

.tagify__dropdown.users-list img{
    width: 100%;
    vertical-align: top;
}

.tagify__dropdown.users-list strong{
    grid-area: name;
    width: 100%;
    align-self: center;
}

.tagify__dropdown.users-list span{
    grid-area: email;
    width: 100%;
    font-size: .9em;
    opacity: .6;
}

.tagify__dropdown.users-list .tagify__dropdown__item__addAll{
    border-bottom: 1px solid #DDD;
    gap: 0;
}

.customActive{
	background: #e6f3ff;
}

/* Tags items */
.tagify__tag{
    white-space: nowrap;
}

.tagify__tag:hover .tagify__tag__avatar-wrap{
    transform: scale(1.6) translateX(-10%);
}

.tagify__tag .tagify__tag__avatar-wrap{
    width: 16px;
    height: 16px;
    white-space: normal;
    border-radius: 50%;
    background: silver;
    margin:5px 0;
    margin-right: 5px;
    transition: .12s ease-out;
}

.tagify__tag img{
    width: 100%;
    vertical-align: top;
    pointer-events: none;
}
/* Suggestions items */
:root {
    --tagify-dd-item-pad: .5em .7em;
}

.tagify__dropdown.users-list .tagify__dropdown__item{
    display: grid;
    grid-template-columns: auto 1fr;
    gap: 0 1em;
    grid-template-areas: "avatar name"
                        "avatar email";
}

.tagify__dropdown.users-list .tagify__dropdown__item:hover .tagify__dropdown__item__avatar-wrap{
    transform: scale(1.2);
}

.tagify__dropdown.users-list .tagify__dropdown__item__avatar-wrap{
    grid-area: avatar;
    width: 36px;
    height: 36px;
    border-radius: 50%;
    overflow: hidden;
    background: #EEE;
    transition: .1s ease-out;
}

.tagify__dropdown.users-list img{
    width: 100%;
    vertical-align: top;
}

.tagify__dropdown.users-list header.tagify__dropdown__item > div,
.tagify__dropdown.users-list .tagify__dropdown__item strong{
    grid-area: name;
    width: 100%;
    align-self: center;
}

.tagify__dropdown.users-list span{
    grid-area: email;
    width: 100%;
    font-size: .9em;
    opacity: .6;
}

.tagify__dropdown.users-list .tagify__dropdown__item__addAll{
    border-bottom: 1px solid #DDD;
    gap: 0;
}

.tagify__dropdown.users-list .remove-all-tags{
    float: right;
    font-size: .8em;
    padding: .2em .3em;
    border-radius: 3px;
    user-select: none;
}

.tagify__dropdown.users-list .remove-all-tags:hover{
    color: white;
    background: salmon;
}


/* Tags items */
#users-list .tagify__tag{
    white-space: nowrap;
}

#users-list .tagify__tag img{
    width: 100%;
    vertical-align: top;
    pointer-events: none;
}


#users-list .tagify__tag:hover .tagify__tag__avatar-wrap{
    transform: scale(1.6) translateX(-10%);
}

#users-list .tagify__tag .tagify__tag__avatar-wrap{
    width: 16px;
    height: 16px;
    white-space: normal;
    border-radius: 50%;
    background: silver;
    margin-right: 5px;
    transition: .12s ease-out;
}

.users-list .tagify__dropdown__itemsGroup:empty{
    display: none;
}

.users-list .tagify__dropdown__itemsGroup::before{
    content: attr(data-title);
    display: inline-block;
    font-size: .9em;
    padding: 4px 6px;
    margin: var(--tagify-dd-item-pad);
    font-style: italic;
    border-radius: 4px;
    background: #00ce8d;
    color: white;
    font-weight: 600;
}

.users-list .tagify__dropdown__itemsGroup:not(:first-of-type){
    border-top: 1px solid #DDD;
}
.tag_container{
	padding: 2px 10px!important;
}
#member{
	min-height: 150px;
	overflow-y: auto; 
}
</style>



<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
    let headerName = "${_csrf.headerName}"
    let token = "${_csrf.token}"
</script>

<section class="content py-3">
    <div class="container-fluid">

        <div class="row" style="padding: 10px;">

            <div class="col">

                <div class="card card-primary">
                    <div class="card-header">
                        <h3 class="card-title">SURVEY FORM</h3>
                    </div>

                    <form class="form-horizontal" method="post" id="suvyForm">
                        <div class="card-body">
                            <!-- line1 -->
                            <div class="form-group row">
                                <label for="suvyTtl" class="col-sm-2 col-form-label">제목</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="suvyTtl" name="suvyTtl" placeholder="제목을 입력하세요." value="">
                                </div>
                                <div class="col-sm-2">
							      <button class="btn btn-outline-secondary" id="auto_fill">자동입력</button>
							    </div>
                            </div>

                            <!-- line2 -->
                            <div class="form-group row">
                                <label class="col-sm-2 col-form-label">설문대상자</label>
                                <div class="col-sm-8">
                                        <input type="text" id="member" name="users-list-tags" placeholder="주소록을 클릭하세요.">
                                </div>
                                <div class="col-sm-2" style="flex-direction: column;">
                                    <button class="btn btn-outline-secondary" type="button" data-toggle="modal" data-target="#tree-modal" id="address_book_btn">주소록</button>
                                </div>
                            </div>

                            <!-- line3 -->
                            <div class="form-group row">
                                <label class="col-sm-2 col-form-label">설문기간</label>
                                <div class="col-sm-10">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">
                                                <i class="far fa-calendar-alt"></i>
                                            </span>
                                        </div>
                                        <input type="text" class="form-control float-right" id="reservation" name="suvyDate">
                                    </div>
                                </div>
                            </div>

                            <!-- line4 -->
                            <div class="form-group row">
                                <label class="col-sm-2 col-form-label">설문설정</label>
                                <div class="col-sm-10">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text">
                                                        <input type="checkbox" id="suvySigned" name="suvySigned">
                                                    </span>
                                                </div>
                                                <input type="text" class="form-control" value="결과 공개 여부" disabled>
                                            </div>
                                        </div>
    
                                        <div class="col-lg-6">
                                            <div class="input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text">
                                                        <input type="checkbox" id="suvyDuplicate" name="suvyDuplicate">
                                                    </span>
                                                </div>
                                                <input type="text" class="form-control" value="중복투표" disabled>
                                            </div>
                                        </div>
                                    
                                    </div>
                                
                                </div>
                            </div>
                            
                            <!-- line5 -->
                            <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">내용</label>
                                <div class="col-sm-10">
                                    <div class="input-group mb-3">
                                        <textarea class="form-control" id="suvyCn" name="suvyCn" rows="10" placeholder="내용을 입력하세요."></textarea>
                                    </div>
                                </div>
                            </div>

                            <!-- line6 -->
                            <div class="form-group row">
                                <label for="" class="col-sm-2 col-form-label">항목</label>
                                <div class="col-sm-10">
                                    <div id="suvyItems">
                                        <div class="input-group mb-3 suvyItem">
                                            <input type="text" class="form-control suvyInput" id="siCn" name="siCn" placeholder="항목을 입력하세요.">
                                            <div class="input-group-append">
                                                <span class="input-group-text"><ion-icon name="clipboard"></ion-icon></span>
                                                <button type="button" class="btn btn-tool btnSuvyItemRemove">
                                                    <i class="fas fa-times"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- + -->
                                    <button type="button" class="btn btn-tool" id="btnSuvyItemAdd">
                                      <i class="fas fa-plus"></i>
                                    </button>
                                </div>
                            </div>
                            


                        </div>

                        <div class="card-footer">
                            <button type="button" class="btn btn-primary" id="btnSuvyAdd">등록</button>
                            <button type="button" class="btn btn-default float-right" id="btnCancel">목록</button>
                        </div>
                        <sec:csrfInput/>
                    </form>

                </div>

            </div>

        </div>

    </div>
</section>



<%@ include file="../contacts/contactModal.jsp" %>






<script src="/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@yaireo/tagify"></script>
<script src="https://cdn.jsdelivr.net/npm/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/@yaireo/tagify/dist/tagify.css" rel="stylesheet" type="text/css" />


<script>
window.toInput = document.querySelector('#member');
$(()=>{
    var suvyItemCount = 1;
    const btnSuvyItemAdd = $("#btnSuvyItemAdd");
    const btnSuvyItemRemove = $(".btnSuvyItemRemove");

    const addressBookBtn=$("#address_book_btn")
    var tags = $(".tagify__tag")
    const draftBtn = $("#draft_btn")

    getAllProfileList()
    
    //auto_fill 시연용 자동입력 버튼 
    $("#auto_fill").on("click",function(e){
    	e.preventDefault()
    	$("#suvyTtl").val("대덕인재 개발원에 대해 어떻게 생각하시나요?")
    	$("#suvyCn").val("결과를 공개하지 않고 익명성이 보장되니 편하게 설문에 참여해 주세요^^")
    	
    })
    
    $('.tree-return-btn').on("click",function(){
		modalReturn(function(data){
			var fList=[]
			
			$.each(data,function(i,v){
				var profile ="/resources/img/basicProfile.png"
				if(v.empProfile!=null){
					profile = "/everyware/mypage/thumbnail?empId="+v.empId
				}
				var obj = {
							"value": v.empId,
							"name" : v.empName,
							"jbgdNm":v.jbgdNm,
							"deptNm":v.deptNm,
							"avatar":profile,
							"email":v.empMail
					}
					fList.push(obj)
			})
			tagify.addTags(fList)
            
		});
	})



    // 등록 버튼 클릭시
    $(document).on("click", "#btnSuvyAdd", function () {
        var suvyTtl = $("#suvyTtl").val();
        var suvyCn = $("#suvyCn").val();

        // 설문기간
        var suvyDate1 = $("input[name=suvyDate]").val();
        var suvyDate2 = suvyDate1.split(" ~ ");
		
        var suvyBgngDt = suvyDate2[0];
        var suvyEndDt = suvyDate2[1]; 

        var suvySigned = "";
        if($('#suvySigned').is(':checked')){
            suvySigned = 'Y'
        } else {
            suvySigned = 'N'
        }
        var suvyDuplicate = "";
        if($('#suvyDuplicate').is(':checked')){
            suvyDuplicate = 'Y'
        } else {
            suvyDuplicate = 'N'
        }
        
        var suvyItemList = [];
        var siCn = [];
        var siCnValuesLength = $("input[name=siCn]").length;

        for (let i = 0; i < siCnValuesLength; i++) { 
            var siCnValue = $("input[name=siCn]").eq(i).val();
            
            if (siCnValue != '' && siCnValue != null) {
                suvyItemList.push({ ["siCn"] : siCnValue});
            }
        }
        var idList = tagify.value.map(obj => obj.value);
        let suvyData = {
            suvyTtl : suvyTtl,
            suvyCn : suvyCn,
            suvyBgngDt : suvyBgngDt,
            suvyEndDt : suvyEndDt,
            suvySigned : suvySigned,
            suvyDuplicate : suvyDuplicate,
            suvyItemList : suvyItemList,
            idList : idList
        }


        $.ajax({
            type: 'POST',
            url: '/everyware/suvy/addSuvy',
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify(suvyData),
            dataType:"text",
            beforeSend: function (xhr) {
                xhr.setRequestHeader(headerName,token);
            },
            success:function(res){
                if(res=="success"){
                    alert("등록 되었습니다.");
                    location.href = "/everyware/suvy";
                }else {
                    alert("잘안되네용, 담에 다시 해용");
                }
            },
            error: function(xhr) {
                alert("Error: " + xhr.status);
            }
        });

    });



    // Cancel버튼 클릭시
    $(document).on("click", "#btnCancel", function () {
        if(!confirm("설문을 작성 중입니다. 목록으로 이동하시겠습니까?")){
            // 취소
        } else {
            // 확인
            location.href = "/everyware/suvy";
        }
    });

    //설문항목 삭제 x
    $(document).on("click", ".btnSuvyItemRemove", function(){
        $(this).closest(".suvyItem").remove();
    });

    btnSuvyItemAdd.on("click", function () {
        var suvyItems = $("#suvyItems");

        // 새로운 항목을 생성하여 suvyItems에 추가
        var newSuvyItem =
        `<div class="input-group mb-3 suvyItem">
            <input type="text" class="form-control suvyInput" id="siCn" name="siCn" placeholder="항목을 입력하세요.">
            <label for="siNo" hidden></label>
            <div class="input-group-append">
                <span class="input-group-text"><ion-icon name="clipboard"></ion-icon></span>
                <button type="button" class="btn btn-tool btnSuvyItemRemove">
                <i class="fas fa-times"></i>
                </button>
            </div>
        </div>`;
        suvyItems.append(newSuvyItem);
    });

    //Date range picker
    $("#reservation").daterangepicker({
		   locale: {
			    "separator": " ~ ",                     // 시작일시와 종료일시 구분자
			    "format": 'YYYY/MM/DD',     // 일시 노출 포맷
			    "applyLabel": "확인",                    // 확인 버튼 텍스트
			    "cancelLabel": "취소",                   // 취소 버튼 텍스트
			    "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
			    "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
			    },
			    autoApply: false, 
			    startDate: new Date(),
			    endDate: moment().add(1, 'month'),
			    drops: "auto"
	})
})


function getAllProfileList(){
	$.ajax({
		  url: '/everyware/calendar/allProfileList', // 요청을 보낼 URL
		  method: 'post', // HTTP 메서드 (GET, POST 등)
		  beforeSend : function(xhr){
			  xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
	  	  },
		  success: function(response) {

				var list=[]
				$.each(response,function(i,v){
					var profile ="/resources/img/basicProfile.png"
					if(v.empProfile!=null){
						profile = "/everyware/mypage/thumbnail?empId="+v.empId
					}
					var obj = {
							"value": v.empId,
							"name" : v.empName,
							"jbgdNm":v.jbgdNm,
							"deptNm":v.deptNm,
							"avatar":profile,
							"email":v.empMail
					}
					list.push(obj)
				})
				tagify.settings.whitelist=list
			
		  },
		  error: function(xhr, status, error) {
			alert("프로필 리스트 가져오기 실패")
		  }
		});
}

</script>

<script src="/resources/js/mail_tagify.js"></script> 
