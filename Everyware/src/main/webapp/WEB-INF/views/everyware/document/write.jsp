    <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
<title>Insert title here</title>
<link rel="stylesheet" href="../../../../resources/bootstrap/dist/css/adminlte.min.css">
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://unpkg.com/dropzone@5/dist/min/dropzone.min.css" type="text/css" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js" defer></script>
<style>
    label{
        width: 50px;
        top: 5px;
        position: relative;
        text-align: right;
        margin-right: 20px;
    }
    .search-btn{
        width: 250px;
    }
    .form-daterange{
        position: relative;
    }
    .form-daterange-info{
        position: absolute;
        bottom: 36px;
        font-size: 0.8em;
        color: gray;
    }
    #document-table_length{
        float: right;
    }
    .border-bottom{
        margin-bottom: 20px;
    }
    ion-icon{
        font-size: 1.3em;
        top: 4px;
        position: relative;
        margin-right: 3px;
    }
    .write-btns button{
        font-size: 15px;
    }
    .temp-list-btn{
        min-width: 107px;
        border: none;
        padding-left: 14px;
    }
    .dropdown:hover .dropdown-menu {
        display: block;
        margin-top: 0; /* remove the gap so it doesn't close */
    }
    .add-btn-wrap{
        text-align: center;
    }
    .selected-list{
        border: 1px solid rgba(0,0,0,.125);
    }
    .selected-list>li{
        height: 36px;
        padding: 5px 18px;
    }
    .selected-list-item-aprv{
        background-color: #e7f7ff;
        border-radius: 40px;
        font-size: 13px;
        text-align: center;
        color: #595959;
        line-height: 25px;
    }
    .selected-list-item-agree{
        background-color: #ffe7e7;
        border-radius: 40px;
        font-size: 13px;
        text-align: center;
        color: #595959;
        line-height: 25px;
    }
    .dcrb-icon{
        font-size: 16px;
        color: #ffc107;
    }
    .selected-approver-list{
        /* width:280px; */
        padding:0 5px;
        overflow:hidden;
        text-overflow:ellipsis;
        white-space:nowrap;
    }

    .file-list-div{
        border: 1px solid rgba(0,0,0,.125);
        height: 70px;
        overflow-y: auto;
        width: 100%;
    }
    
    .btn-file{
        width: 100%;
        height: 70px;
        padding: 9px 12px !important;
    }

    .doc-header {
        background-color: rgb(240, 240, 240);
        text-align: center;
    }
</style>
</head>
<body>
    <div class="content-container">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>결재문서 작성</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active">전자결재</li>
                            <li class="breadcrumb-item active">문서작성</li>
                        </ol>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </section>
        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-9">
                        <div class="card card-outline card-primary content-card">
                            <div class="card-header">
                                <div class="col-md-12">
                                    <button type="button" class="btn btn-light doc-cancel-btn">
                                        <ion-icon name="close-circle-outline"></ion-icon>취소
                                    </button>
                                    <div class="btn-group float-right write-btns" role="group" aria-label="Basic example">
                                        <div class="dropdown">
                                            <button type="button" class="btn btn-light dropdown temp-save-btn" id="tempSaveBtn" aria-haspopup="true" aria-expanded="false">
                                                <ion-icon name="save-outline"></ion-icon>임시저장
                                            </button>
                                            <button type="button" class="btn btn-light dropdown-menu temp-list-btn"
                                            aria-labelledby="tempSaveBtn" onclick="tempList()">
                                                <ion-icon name="list-outline"></ion-icon>저장목록
                                            </button>
                                        </div>
                                        <button type="button" class="btn btn-light write-preview-btn">
                                            <ion-icon name="eye-outline"></ion-icon>미리보기
                                        </button>
                                        <button type="button" class="btn btn-light auto-insert-btn">
                                            자동입력
                                        </button>
                                        <button type="button" class="btn btn-primary write-complete-btn">
                                            <ion-icon name="chevron-down-circle-outline"></ion-icon>완료
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <!-- 문서번호 aprvSn -->
                            <input type="hidden" id="aprvSn" value="${document.aprvSn}">
                            <input type="hidden" id="status" value="${status}">
                            <!-- /.card-header -->
                            <div class="card-body">
                                <div class="form-group row">
                                    <label>제목</label>
                                    <div class="col">
                                        <input type="text" class="form-control" id="write-title" value="${document.aprvTtl}">
                                    </div>
                                </div>
                                <div class="form-group aprvCn" data="$aprvCn">
                                    <c:choose>
                                        <c:when test="${document.aprvSn > 0}">
                                            ${document.aprvCn}
                                        </c:when>
                                        <c:otherwise>
                                            ${template.tmpltCn}
                                        </c:otherwise>
                                    </c:choose>
                                    <!-- <textarea id="editorArea"></textarea> -->
                                </div>
                                <div>
                                    <div class="row">
                                        <!-- <form class="dropzone"> -->
                                            <div class="col-md-1 form-group">

                                                <div class="btn btn-default btn-file">
                                                    <i class="fas fa-paperclip"></i> 파일
                                                    <input type="file" name="attachment" multiple>
                                                </div>
                                            </div>
                                            <div class="col-md-11">
                                                <div id="dropzone" class="file-list-div">
                                                    <!-- <ul class="file-list-ul">
                                                        
                                                    </ul> -->
                                                </div>
                                            </div>
                                        <!-- </form> -->
                                    </div>
                                </div>
                            </div>
                            <!-- /.card-body -->
                        </div>
                        <!-- /.card -->
                    </div>
                    <!-- /.col -->

                    <div class="col-md-3 approver-wrap">
                        <div class="card bg-primary">
                            <div class="card-header">
                                <h3 class="card-title">
                                    문서 양식
                                </h3>
                            </div>
                            <div class="card-body" style="display: block;">
                                ${template.tmpltNm}
                            </div>
                        </div>
                        
                        <div class="card border-light">
                            <div class="card-header">
                                <h3 class="card-title">결재선</h3>
                                <div class="card-tools">
                                    <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                        <i class="fas fa-minus"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="card-body p-0" style="display: block;">
                                <ul class="list-group list-group-flush selected-approver-list selected-list">
                                    <c:forEach items="${document.approvalLine }" var="aprvLine">
                                        <c:if test="${aprvLine.aprvSeCd == 1}">
                                            <li class="list-group-item">
                                                <div class="row">
                                                    <div class="col-sm-3 selected-list-item-aprv">결재</div>
                                                    <div class="col-sm-9">
                                                        ${aprvLine.deptNm} ${aprvLine.empName} ${aprvLine.jbgdNm}
                                                        <c:if test="${aprvLine.dcrbYn == 'Y'}">
                                                            <ion-icon name="sparkles" class="dcrb-icon md hydrated" role="img"></ion-icon>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </li>
                                        </c:if>
                                        <c:if test="${aprvLine.aprvSeCd == 3}">
                                            <li class="list-group-item">
                                                <div class="row">
                                                    <div class="col-sm-3 selected-list-item-agree">합의</div>
                                                    <div class="col-sm-9">${aprvLine.deptNm} ${aprvLine.empName} ${aprvLine.jbgdNm}</div>
                                                </div>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                                <ul class="nav nav-pills flex-column">
                                    <li class="nav-item active add-btn-wrap">
                                        <a href="#" class="nav-link" data-toggle="modal" data-target="#approval-modal">
                                            <ion-icon name="add-circle-sharp"></ion-icon>결재선 선택
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <c:if test="${config.refUseYn == 'Y' }">
                        <div class="card border-light">
                            <div class="card-header">
                                <h3 class="card-title">참조자</h3>
                                <div class="card-tools">
                                    <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                        <i class="fas fa-minus"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="card-body p-0" style="display: block;">
                                <ul class="list-group list-group-flush selected-refferrer-list selected-list">
                                    <c:forEach items="${document.approvalLine}" var="aprvLine">
                                        <c:if test="${aprvLine.aprvSeCd == 4}">
                                            <li class="list-group-item">
                                                <div">${aprvLine.deptNm} ${aprvLine.empName} ${aprvLine.jbgdNm}</div>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                                <ul class="nav nav-pills flex-column">
                                    <li class="nav-item active add-btn-wrap">
                                        <a href="#" class="nav-link refferrer-a" data-toggle="modal" data-target="#tree-modal">
                                            <ion-icon name="add-circle-sharp"></ion-icon>참조자 선택
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        </c:if>
                        
                        <c:if test="${config.viewUseYn == 'Y' }">
                        <div class="card border-light">
                            <div class="card-header">
                                <h3 class="card-title">열람자</h3>
                                <div class="card-tools">
                                    <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                        <i class="fas fa-minus"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="card-body p-0" style="display: block;">
                                <ul class="list-group list-group-flush selected-reader-list selected-list">
                                    <c:forEach items="${document.approvalLine}" var="aprvLine">
                                        <c:if test="${aprvLine.aprvSeCd == 5}">
                                            <li class="list-group-item">
                                                <div>${aprvLine.deptNm} ${aprvLine.empName} ${aprvLine.jbgdNm}</div>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                </ul>
                                <ul class="nav nav-pills flex-column">
                                    <li class="nav-item active add-btn-wrap">
                                        <a href="#" class="nav-link reader-a" data-toggle="modal" data-target="#tree-modal">
                                            <ion-icon name="add-circle-sharp"></ion-icon>열람자 선택
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        </c:if>
                    
                        <div class="card border-light">
                            <div class="card-header">
                                <h3 class="card-title">수신처</h3>
                                <div class="card-tools">
                                    <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                        <i class="fas fa-minus"></i>
                                    </button>
                                </div>
                            </div>
                        <div class="card-body p-0" style="display: block;">
                            <ul class="list-group list-group-flush selected-destination-list selected-list">
                                <c:forEach items="${document.destinations}" var="dest">
                                    <li class="list-group-item">
                                        <div>${dest.deptNm}</div>
                                    </li>
                                </c:forEach>
                                </ul>
                                <ul class="nav nav-pills flex-column">
                                    <li class="nav-item active add-btn-wrap">
                                        <a href="#" class="nav-link" data-toggle="modal" data-target="#dept-modal">
                                            <ion-icon name="add-circle-sharp"></ion-icon>수신처 선택
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->
            </div>
            <!-- /.container-fluid -->
        </section>
        <!-- /.content -->
    </div>
    <input type="hidden" value="${template.tmpltCd}" id="tmpltCd">
    <c:if test="${config.refUseYn == 'Y' || config.viewUseYn == 'Y' }">
    <%@ include file="../contacts/contactModal.jsp" %>
    </c:if>
    <%@ include file="approvalModal.jsp" %>
    <%@ include file="../contacts/departmentModal.jsp" %>
   <%--  <%@ include file="tempListModal.jsp" %> --%>
    <script src="/resources/ckeditor/ckeditor.js"></script>
    <script src="https://unpkg.com/dropzone@5/dist/min/dropzone.min.js"></script>
    
    <sec:authentication property="principal.employee.empId" var="empId"/>
<script>
    var csrfHeader = $('meta[name="_csrf_header"]').attr('content');
    var csrfToken = $('meta[name="_csrf"]').attr('content');
    
    var approvers = [];
    var refferrers = [];
    var viewers = [];
    var destinations = [];

    var jsonMap = '${map}';
    var map = JSON.parse(jsonMap);
    console.log(map);

    var approvalLine = "${document.approvalLine}";
    <c:forEach items="${document.approvalLine}" var="aprvLine">
        <c:if test="${aprvLine.aprvSeCd == 1 || aprvLine.aprvSeCd == 3}">
            approvers.push({
                empId: "${aprvLine.empId}"
                ,empName: "${aprvLine.empName}"
                ,aprvSeCd: "${aprvLine.aprvSeCd}"
                ,dcrbYn: "${aprvLine.dcrbYn}"
                ,deptNm: "${aprvLine.deptNm}"
                ,jbgdNm: "${aprvLine.jbgdNm}"
                ,aprvOrder: "${aprvLine.aprvOrder}"
            	});
        </c:if>
        <c:if test="${aprvLine.aprvSeCd == 4}">
            refferrers.push({
                empId: "${aprvLine.empId}"
                    ,empName: "${aprvLine.empName}"
                    ,aprvSeCd: "${aprvLine.aprvSeCd}"
                    ,dcrbYn: "${aprvLine.dcrbYn}"
                    ,deptNm: "${aprvLine.deptNm}"
                    ,jbgdNm: "${aprvLine.jbgdNm}"
                	});
        </c:if>
        <c:if test="${aprvLine.aprvSeCd == 5}">
            viewers.push({
                empId: "${aprvLine.empId}"
                    ,empName: "${aprvLine.empName}"
                    ,aprvSeCd: "${aprvLine.aprvSeCd}"
                    ,dcrbYn: "${aprvLine.dcrbYn}"
                    ,deptNm: "${aprvLine.deptNm}"
                    ,jbgdNm: "${aprvLine.jbgdNm}"
                	});
        </c:if>
    </c:forEach>
    
    <c:forEach items="${document.destinations}" var="dest">
        var aa = "${dest}";
        console.log(aa);
        destinations.push({
        	deptId: "${dest.deptId}"
        	,deptNm: "${dest.deptNm}"
        });
    </c:forEach>
    
    $(function(){
        var tmpltCd = parseInt($('#tmpltCd').val());
        var currentMenu = '';
        
        var select2 = $('.select2')
        var approverUl = $('.selected-approver-list');
        var selectedApproverList = $('.selected-approver-list');
        var selectedRefferrerList = $('.selected-refferrer-list');
        var selectedReaderList = $('.selected-reader-list');
        var selectedDestinationList = $('.selected-destination-list');
        var writeCompleteBtn = $('.write-complete-btn');
        var cancelBtn = $('.doc-cancel-btn');
        var tempSaveBtn = $('.temp-save-btn');
        var tempListBtn = $('.temp-list-btn');
        var previewBtn = $('.write-preview-btn');
        var approverWrap = $('.approver-wrap');

        var selectedRefferrerNode = [];
        var selectedReaderNode = [];

        var aprvSn = $('#aprvSn').val();
        var status = $('#status').val();

        console.log('수신처',destinations);
        
        CKEDITOR.replace("editorArea");
        CKEDITOR.config.allowedContent = true;

        if(status == 'modify'){
            approverWrap.css('opacity', '0.4');
            approverWrap.on('click', function(){
                return false;
            })
        }

        var autoNodes = $('.auto').get();
        $.each(autoNodes, function(i, auto){
            var attrNm = $(auto).attr('id');
            console.log(attrNm);
            $(auto).html(map[attrNm]);
        })


        // var myDropzone = new Dropzone("div#dropzone", { url: "/file/post"});

        Dropzone.options.fileDropzone = {
            url: 'Fileupload', //업로드할 url (ex)컨트롤러)
            init: function () {
                /* 최초 dropzone 설정시 init을 통해 호출 */
                var submitButton = document.querySelector("#btn-upload-file");
                var myDropzone = this; //closure
                submitButton.addEventListener("click", function () {
                    console.log("업로드"); //tell Dropzone to process all queued files
                    myDropzone.processQueue();
                });
            },
            autoProcessQueue: false, // 자동업로드 여부 (true일 경우, 바로 업로드 되어지며, false일 경우, 서버에는 올라가지 않은 상태임 processQueue() 호출시 올라간다.)
            clickable: true, // 클릭가능여부
            thumbnailHeight: 90, // Upload icon size
            thumbnailWidth: 90, // Upload icon size
            maxFiles: 1, // 업로드 파일수
            maxFilesize: 10, // 최대업로드용량 : 10MB
            parallelUploads: 1, // 동시파일업로드 수(이걸 지정한 수 만큼 여러파일을 한번에 컨트롤러에 넘긴다.)
            addRemoveLinks: true, // 삭제버튼 표시 여부
            dictRemoveFile: '삭제', // 삭제버튼 표시 텍스트
            uploadMultiple: false, // 다중업로드 기능
        };

        cancelBtn.on('click', function(){
            // TODO 취소 시 임시저장 여부 확인
            location.href = '/everyware/approval';
        })
        
        // 수정/재기안 일 때
        if(aprvSn){
            var aprvTtl = $('#write-title').val();
            var textSpans = $('span.text').get();
            var dateSpans = $('span.date').get();
            var textareaSpans = $('span.textarea').get();
            var readonly = $('.readonly').get();
            var checked = $('.checked').get();

            $.each(textSpans, function(i,span){
                var val = $(span).html();
                var input = document.createElement('input');
                $(input).attr('type', 'text');
                $(input).addClass('form-control');
                $(input).val(val);
                $(span).html(input);
            })
            
            $.each(dateSpans, function(i,span){
                var val = $(span).html();
                console.log(val);
                var input = document.createElement('input');
                $(input).attr('type', 'date');
                $(input).addClass('form-control');
                $(input).val(val);
                $(span).html(input);
            })

            $.each(textareaSpans, function(i,span){
                var val = $(span).html();
                var textarea = document.createElement('textarea');
                $(textarea).addClass('form-control');
                $(textarea).attr('rows', 3);
                $(textarea).val(val);
                $(span).html(textarea);
            })

            $.each(checked, function(i, v){
                $(v).prop('checked', true);
                $(v).removeClass('checked');
            })

            $.each(readonly, function(i, v){
                $(v).removeClass('readonly');
            })

        }



        writeCompleteBtn.on('click', function(){
            var cntApprovers = selectedApproverList.children().length;
            var cntDestinations = selectedDestinationList.children().length;

            if(!cntApprovers){
                alert('결재선을 선택해주세요.');
                return false;
            }
            if(!cntDestinations){
                alert('수신처를 선택해주세요.');
                return false;
            }

            if(cntApprovers && cntDestinations){
                var aprvTtl = $('#write-title').val();
                
                var inputNodes = $('.aprvCn input:not([type="checkbox"]):not([type="radio"])').get();
                var textareaNodes = $('.aprvCn textarea').get();
                var checkNodes = $('.aprvCn input:checkbox').get();
                var radioNodes = $('.aprvCn input:radio').get();

                $.each(inputNodes, function(i, input){
                    var value = $(input).val();
                    console.log(value);
                    var span = $(input).parent('span');
                    $(span).html(value);
                })
                
                $.each(textareaNodes, function(i, textarea){
                    var value = $(textarea).val();
                    console.log(value);
                    var span = $(textarea).parent('span');
                    $(span).html(value);
                })

                $.each(checkNodes, function(i, check){
                    $(check).addClass("readonly");
                    if($(check).is(":checked")){
                        $(check).addClass('checked');
                        return true;
                    }
                })
                $.each(radioNodes, function(i, radio){
                    $(radio).addClass("readonly");
                    if($(radio).is(":checked")){
                        $(radio).addClass('checked');
                        return true;
                    }
                })


                // var aprvCn = CKEDITOR.instances["editorArea"].getData();

                var aprvCn = $('.aprvCn').prop('outerHTML');
                var approvalLine = [];

                $.each(approvers, function(i, approver){
                    if(i == approvers.length - 1){
                        // 결재 상태 대기
                        approver.prgrsSttsCd = 2;
                    }else{
                        // 결재 상태 예정
                        approver.prgrsSttsCd = 1;
                    }
                    approvalLine.push(approver);
                })
                $.each(refferrers, function(i, refferrer){
                    refferrer.aprvSeCd = 4;
                    approvalLine.push(refferrer);
                })
                $.each(viewers, function(i, viewer){
                    viewer.aprvSeCd = 5;
                    approvalLine.push(viewer);
                })

                delete map._csrf;
                // return false;

                // ///////////

                // alert(approvalLine);
                
                var document = {
                	tmpltCd,
                	aprvTtl,
                    aprvCn,
                    approvalLine,
                    destinations,
                    // 문서상태 대기
                    prgrsSttsCd: 3,
                    tmpltNm: '${template.tmpltNm}',
                    jsonObject: JSON.stringify(map)
                };
                console.log(document);
                if(status == 'modify'){
                    document.aprvSn = aprvSn;
                    document.status = status;
                    modifyDoc(document);
                    return true;
                }else{
                    draftDoc(document);
                    return true;
                }
            }
        })

        modifyDoc = function(document){
            console.log(document); 
            $.ajax({
                url: '/everyware/documents',
                method: 'PUT',
                data: JSON.stringify(document),
                contentType : "application/json; charset=utf-8",
                dataType : "text",
                beforeSend : function(xhr){
                  xhr.setRequestHeader(csrfHeader,csrfToken);
                },
                success: function(aprvSn){
                    location.href = '/everyware/approval/'+ aprvSn ;
                }
            })
        }

        draftDoc = function(document){
            console.log(document); 
            $.ajax({
                url: '/everyware/documents',
                method: 'POST',
                data: JSON.stringify(document),
                contentType : "application/json; charset=utf-8",
                dataType : "text",
                beforeSend : function(xhr){
                  xhr.setRequestHeader(csrfHeader,csrfToken);
                },
                success: function(aprvSn){
                    var nextApprover = approvers[approvers.length - 1].empId;
                    console.log(nextApprover);
                    var socketObj={				
							type:"al",
							alarm:{
								sndrNm:"${empId}",
								empId:nextApprover,
								alarmType:10,
								urlAddr:'/everyware/approval/' + aprvSn
							}
					}
					ws.send(JSON.stringify(socketObj));
                    location.href = '/everyware/approval/' + aprvSn ;
                }
            })
        }



        $('.tree-return-btn').on('click', function(){
            modalReturn(selectEmp);
	    });

        $('.approval-tree-return-btn').on('click', function(){
            approvalModalReturn(selectApprover);
	    });

        $('.dept-tree-return-btn').on('click', function(){
            deptModalReturn(selectDept);
	    });

        $('.refferrer-a').on('click', function(){
            $('.select-ul').html('');
            dataToSelectBoxNode(refferrers);
            currentMenu = 'refferrer';
        })
        $('.reader-a').on('click', function(){
            $('.select-ul').html('');
            dataToSelectBoxNode(viewers);
            currentMenu = 'reader';
        })
        
        selectApprover = function(datas){
            selectedApproverList.html('');
            approvers = datas;

            $.each(datas, function(i,data){
                var li = document.createElement('li');
                $(li).addClass('list-group-item');
    
                var row = document.createElement('div');
                $(row).addClass('row');
    
                var idx = document.createElement('div');
                if(data.aprvSeCd == 1){
                    $(idx).addClass('col-sm-3 selected-list-item-aprv');
                    idx.innerText = '결재';
                }else{
                    $(idx).addClass('col-sm-3 selected-list-item-agree');
                    idx.innerText = '합의';
                }
    
                var name = document.createElement('div');
                $(name).addClass('col-sm-9');
                var nameValue = data.deptNm + ' ' + data.empName + ' ' + data.jbgdNm;

                if(data.dcrbYn == 'Y'){
                    nameValue += "&nbsp;&nbsp;" + '<ion-icon name="sparkles" class="dcrb-icon"></ion-icon>';
                }
                name.innerHTML = nameValue;

                row.append(idx);
                row.append(name);
                li.append(row);
                selectedApproverList.append(li);
            })
        }

        dataToSelectBoxNode = function(datas){
            $.each(datas, function(i, data){
                var node = document.createElement('li');
                $(node).addClass('list-group-item selected-emp');
        
                node.innerText = data.deptNm + ' ' + data.empName + ' ' + data.jbgdNm;
                $(node).attr('empId', data.id);
                $(node).attr('empName', data.empName);
                $(node).attr('empMail', data.empMail);
                $(node).attr('empTel', data.empTel);
                $(node).attr('empProfile', data.icon);
                $(node).attr('jbgdNm', data.jbgdNm);
                $(node).attr('deptNm', data.deptNm);
                
                var checkbox = document.createElement('input');
                $(checkbox).attr('type', 'checkbox');
                node.prepend(checkbox);
    
                $('.select-ul').append(node);
            })
            return true;
        }
        
        selectEmp = function(datas){
            if(currentMenu == 'reader'){
                selectViewer(datas);
                return true;
            }
            if(currentMenu = 'refferrer'){
                selectReferrer(datas);
                return true;
            }
        }
        
        selectReferrer = function(datas){
            selectedRefferrerList.html('');
            refferrers = datas;
            
            $.each(datas, function(i,data){
                var li = document.createElement('li');
                $(li).addClass('list-group-item');
            
                var name = document.createElement('div');
                name.innerText = data.deptNm + ' ' + data.empName + ' ' + data.jbgdNm;
                
                li.append(name);
                selectedRefferrerList.append(li);
            })
        }
        
        selectViewer = function(datas){
            selectedReaderList.html('');
            viewers = datas;
            
            $.each(datas, function(i,data){
                var li = document.createElement('li');
                $(li).addClass('list-group-item');
            
                var name = document.createElement('div');
                name.innerText = data.deptNm + ' ' + data.empName + ' ' + data.jbgdNm;
    
                li.append(name);
                selectedReaderList.append(li);
            })
        }
        
        selectDept = function(datas){
            selectedDestinationList.html('');
            destinations = datas;
            console.log(destinations);
            
            $.each(datas, function(i,data){
                var li = document.createElement('li');
                $(li).addClass('list-group-item');
            
                var name = document.createElement('div');
                name.innerText = data.deptNm;
    
                li.append(name);
                selectedDestinationList.append(li);
            })
        }

        $('.auto-insert-btn').on('click', function(){
            $('#write-title').val('대덕인재개발원 풀스택 개발자 양성과정 교육 신청');
            $('#traningNm').val('풀스택 개발자 양성과정');
            $('#trainingDt').val('2023-08-31');
            $('#trainingPlace').val('대덕인재개발원');
            $('#trainingCharge').val('10,135,000');
            $('#myJob').val('멋진 개발자');
            $("#check1").prop('checked', true);
            $("#check2").prop('checked', true);
            $('#trainingReason').val('더 멋진 개발자가 되고 싶어요');
        })

    })
</script>
</body>
</html>