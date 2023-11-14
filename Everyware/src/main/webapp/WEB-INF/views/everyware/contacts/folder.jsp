<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
<title>폴더관리</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.15/themes/default/style.min.css" />
<script src="/resources/jstree/dist/jstree.min.js"></script>
<style>
	* {
		box-sizing: border-box;
	}
/* 
	.tree-folder {
		width: 350px;
		height: 500px;
		border: 1px solid red;
	}

	.folder-form {
		width: 500px;
		height: 500px;
		border: 1px solid red;
	} */
	.folder-list-card{
		height: 400px;
	}
	.submenu-body {
        margin-bottom: 1px;
    }
</style>
</head>

<body>
	<div class="content-container">
		<section class="content-header">
            <div class="container-fluid">
                <div class="row mb-2">
                    <div class="col-sm-6">
                        <h1>주소록</h1>
                    </div>
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item active">주소록</li>
                            <li class="breadcrumb-item active">폴더설정</li>
                        </ol>
                    </div>
                </div>
            </div><!-- /.container-fluid -->
        </section>
		<section class="content">
            <div class="container-fluid">
				<div class="row">
					<!-- subMenu -->
                    <div class="col-md-2">
                        <a href="/everyware/contacts/new" class="btn btn-primary btn-block mb-2 write-btn">주소록 추가</a>
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
					<div class="col-md-10">
						<!-- <div class="card card-light"> -->
							<!-- <div class="card-header">
								<h3 class="card-title">폴더 설정</h3>
							</div> -->
							<!-- <div class="card-body px-5 py-5"> -->
								<div class="row">
									<div class="col-md-5">
										<div class="card card-primary card-outline folder-list-card">
											<div class="card-header">
												<h3 class="card-title">내 폴더</h3>
												<div class="card-tools"><button type="button" class="btn btn-xs px-3 btn-outline-primary create-btn">+</button></div>
											</div>
											<div class="card-body">
												<div class="tree-folder"></div>
											</div>
										</div>
									</div>
		
									<div class="col-md-7 ml-auto folder-form">
										<div class="card card-primary">
											<div class="card-header">
												<h3 class="card-title">상세조회</h3>
											</div>
											<div class="card-body">
												<form>
													<input type="hidden" name="folSn" id="folSn">
													<div class="form-group">
														<label for="type">폴더 종류</label><br/>
														<div class="row">
															<div class="col-md-4">
																<div class="icheck-primary d-inline">
																	<input type="radio" id="incmpny" name="addrBookCd" value="1">
																	<label for="radioPrimary1">
																		사내주소록
																	</label>
																</div>
															</div>
															<div class="col-md-4">
																<div class="icheck-primary d-inline">
																	<input type="radio" id="outcmpny" name="addrBookCd" value="2">
																	<label for="radioPrimary1">
																		사외주소록
																	</label>
																</div>
															</div>
														</div>
													</div>
													<div class="form-group">
														<label for="exampleInputEmail1">폴더명</label>
														<input type="text" class="form-control" id="folNm" name="folNm"
															placeholder="폴더명을 입력해주세요.">
													</div>
													<div class="form-group">
														<label for="folder-select-box">상위 폴더</label>
														<input type="text" class="form-control" name="upFolNm" id="upFolNm" readonly>
													</div>
													<button type="button" class="btn btn-warning folder-delete-btn">삭제</button>
													<button type="button" class="btn btn-primary folder-save-btn float-right">저장</button>
													
													<!-- <div class="card-footer justify-content-between">
													</div> -->
												</form>
											</div>
										</div>
									</div>
								</div>
							<!-- </div> -->
						<!-- </div> -->
					</div>
				</div>
			</div>
		</section>
	</div>
<script>
	var csrfHeader = $('meta[name="_csrf_header"]').attr('content');
	var csrfToken = $('meta[name="_csrf"]').attr('content');

	var tree = $('.tree-folder');

	const folSn = $('#folSn');
	const folNm = $('#folNm');
	const incmpny = $('#incmpny');
	const outcmpny = $('#outcmpny');
	const upFolNm = $('#upFolNm');
	const deleteBtn = $('.folder-delete-btn');
	const saveBtn = $('.folder-save-btn');

	$(function () {
		$.ajax({
			url: "/everyware/contacts/folders",
			type: "GET",
			dataType: "json",
			success: function (rslt) {
				showFolderTree(rslt);
				tree.jstree("open_all");
			}
		});
	})

	showFolderTree = function (data) {
		tree.jstree({
			// 트리 설정
			'core': {
				check_callback: true,
				"themes": {
					"responsive": true
				},
				'data': data
			},
			'types': {
				'default': {
					'icon': 'fa fa-folder text-warning'
				}
			},
			'plugins': [
				'types',
				'search',
				'dnd'
			]
		}).on('loaded.jstree', function() {
			tree.jstree('open_all');
		});
	}

	// 선택
	tree.on('select_node.jstree', function (e, data) {
		var node = data.node;
		console.log(node.original); // 원시 정보 출력
		var id = node.original.id;

		$(incmpny).prop('checked', false);
		$(outcmpny).prop('checked', false);

		$(upFolNm).val('');

		selectFolder(id);
	});

	selectFolder = function(id){
		$.ajax({
			url: '/everyware/contacts/folders/' + id,
			method: 'GET',
			data: JSON.stringify(id),
			contentType : "application/json; charset=utf-8",
			dataType : "text",
			beforeSend : function(xhr){
				xhr.setRequestHeader(csrfHeader,csrfToken);
			},
			success: function(folder){
				var folder = JSON.parse(folder);
				console.log(folder);
				$(folSn).val(folder.folSn);

				$(folNm).val(folder.folNm);

				if(folder.upFolNm != null){
					$(upFolNm).val(folder.upFolNm);
				}

				if(folder.addrBookCd == 1){
					$(incmpny).prop('checked', true);
				}else{
					$(outcmpny).prop('checked', true);
				}

			}
		})
	}

	// 드래그앤드롭
	tree.on('move_node.jstree', function (e, data) {
		var folSn = data.node.id;
		var upFolSn = data.parent;

		console.log(data);

		var folder = {
			folSn,
			upFolSn
		}

		modifyUpFolder(folder);
	});

	modifyUpFolder = function(folder){
		$.ajax({
			url: '/everyware/contacts/folders',
			method: 'PATCH',
			data: JSON.stringify(folder),
			contentType : "application/json; charset=utf-8",
			dataType : "text",
			beforeSend : function(xhr){
				xhr.setRequestHeader(csrfHeader,csrfToken);
			},
			success: function(rslt){
				console.log('상위폴더 변경 성공');
			}
		})
	}

	
	// 이름변경
	$(tree).on('rename_node.jstree', function (e, data) {
		var newNode = data.node.original;

		var newFolder = {
			upFolSn : newNode.upFolSn,
			folNm : data.text
		}

		console.log(newFolder);
		createFolder(newFolder);
	});

	createFolder = function(newFolder){
		$.ajax({
			url: '/everyware/contacts/folders',
			method: 'POST',
			data: JSON.stringify(newFolder),
			contentType : "application/json; charset=utf-8",
			dataType : "text",
			beforeSend : function(xhr){
				xhr.setRequestHeader(csrfHeader,csrfToken);
			},
			success: function(rslt){
				console.log(newFolder.original);

			}
		})
	}
	
	$('.create-btn').on('click', function(){
		console.log('create');
		var upFolSn = null;
		var parent = 0;
		var selectedNode = tree.jstree('get_selected', true)[0];
		if(selectedNode){
			upFolSn = selectedNode.id;
			parent = selectedNode;
		}
		var newNode = {
			'upFolSn': upFolSn,
			'new' : true,
			'text': '새폴더',
			'type': 'default'
		};
		newNode = tree.jstree('create_node', parent, newNode, 'last', function(newNode){
			tree.jstree("open_node", tree.jstree("get_selected"));
			var inst = $.jstree.reference(newNode);
			inst.edit(newNode);
		});
		console.log(newNode);
		// console.log(newNode.original);
		// createFolder(newNode);
	})

	deleteBtn.on('click', function(){
		var id = folsn.val();
		// folderDelete(id);
	})

	saveBtn.on('click', function(){
		
	})



	
</script>
</body>

</html>