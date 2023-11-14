<%@page import="kr.or.everyware.everyware.contact.vo.Folder"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta id="_csrf" name="_csrf" content="${_csrf.token}" />
    <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
    <title>Insert title here</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
	<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js" defer></script>
    <script src="../../../../resources/bootstrap/plugins/moment/moment.min.js"></script>
    <script src="../../../../resources/bootstrap/plugins/inputmask/jquery.inputmask.min.js"></script>
</head>
<style>
    .select2-selection.select2-selection--single{
        height: 38px;
    }
    .contact-out-form{
        width: 100%;
    }
    .table td{
        padding: 0.25rem;
    }
    .form-group{
        width: 300px;
    }
    .invalid-tr{
        background-color: #f3a6ae !important;
    }
    .invalid-tr td{
        border: none !important;
    }
    .invalid-select{
        background-color: #f3a6ae!important;
    }
    .submenu-body {
        margin-bottom: 1px;
    }
</style>
<body>
    <sec:authentication var="empId" property="principal.employee.empId"/>

    <!-- <button type="button" onclick="addRow()">추가</button> -->
    <div class="content-container">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>주소록</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active">주소록 등록</li>
                        </ol>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </section>

        <!-- Main content -->
        <section class="content">
            <div class="container-fluid">
                <div class="row">
                    <!-- subMenu -->
                    <div class="col-md-2">
                        <!-- <a href="/everyware/contacts/new" class="btn btn-primary btn-block mb-2 write-btn">주소록 추가</a> -->
                        <div class="btn-group new-btn-wrap mb-2" style="user-select: auto; width: 100%;">
                            <button type="button" class="btn btn-block btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="user-select: auto;">주소록 추가</button>
                            <div class="dropdown-menu" style="user-select: auto; position: absolute; transform: translate3d(0px, -2px, 0px); top: 0px; left: 0px; will-change: transform;" x-placement="top-start">
                              <a class="dropdown-item" href="/everyware/contacts/in/new" style="user-select: auto;">사내주소록</a>
                              <a class="dropdown-item" href="/everyware/contacts/out/new" style="user-select: auto;">사외주소록</a>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card card-light submenu-body">
                                <div class="card-header">
                                    <h3 class="card-title">주소록</h3>
                                    <div class="card-tools">
                                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                            <i class="fas fa-minus"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="card-body p-0" style="display: block;">
                                    <ul class="nav nav-pills flex-column">
                                        <li class="nav-item active">
                                            <a href="/everyware/contacts/in" class="nav-link">
                                                사내주소록
                                            </a>
                                        </li>
                                        <li class="nav-item">
                                            <a href="/everyware/contacts/out" class="nav-link">
                                                사외주소록
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                            <div class="card card-light submenu-body">
                                <div class="card-header">
                                    <h3 class="card-title">설정</h3>
                                    <div class="card-tools">
                                        <button type="button" class="btn btn-tool" data-card-widget="collapse">
                                            <i class="fas fa-minus"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="card-body p-0" style="display: block;">
                                    <ul class="nav nav-pills flex-column">
                                        <li class="nav-item active">
                                            <a href="/everyware/contacts/folder" class="nav-link">
                                                폴더설정
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /.subMenu -->
                    <div class="col-10">
                        <div class="card">
                            <div class="card-header">
                                <h3 class="card-title">사내주소록 등록</h3>
                            </div>
                            <!-- /.card-header -->
                            <div class="card-body contact-content">
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
        <!-- /.content -->
    </div>
    <%@ include file="./contactModal.jsp" %>
<script>
$(function(){
    var csrfHeader = $('meta[name="_csrf_header"]').attr('content');
    var csrfToken = $('meta[name="_csrf"]').attr('content');

    var contactTree = $('#tree-modal .modal-body').html();
    console.log(contactTree);
    $('.contact-content').html(contactTree);
})

</script>
</body>
</html>