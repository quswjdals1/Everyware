<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
<meta http-equiv="x-ua-compatible" content="ie=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Cropper.js</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.5.13/cropper.css">
<style>
  .submenu-body {
    margin-bottom: 1px !important;
  }


  .img-container {
    margin: 20px auto;
    width: 100%;
  }

  img {
    max-width: 100%;
  }

  /*동글이*/
  .cropper-view-box,
  .cropper-face {
    border-radius: 50%;
  }

  /* The css styles for `outline` do not follow `border-radius` on iOS/Safari (#979). */
  .cropper-view-box {
    outline: 0;
    box-shadow: 0 0 0 1px #39f;
  }

  #imageInput{
    display: none;
  }

  #input{
    width: 200px;
  }

  .write-btn {
    height: 50px;
    line-height: 36px;
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
            <h1>전자결재</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">전자결재</li>
              <li class="breadcrumb-item active">서명관리</li>
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
            <a href="#" data-href="/everyware/writeTest" class="btn btn-primary btn-block mb-2 write-btn"
              data-toggle="modal" data-target="#template-modal">새 문서 작성</a>
            <a href="/everyware/approval" class="btn btn-warning btn-block mb-2 home-btn">결재 HOME</a>
            <div class="card">
              <div class="card card-light submenu-body">
                <div class="card-header">
                  <h3 class="card-title">결재문서함</h3>
                  <div class="card-tools">
                    <button type="button" class="btn btn-tool" data-card-widget="collapse">
                      <i class="fas fa-minus"></i>
                    </button>
                  </div>
                </div>
                <div class="card-body p-0" style="display: block;">
                  <ul class="nav nav-pills flex-column">
                    <li class="nav-item" onclick="selectSubmenu(this, pending, 'pending')">
                      <a href="#" class="nav-link">
                        결재 대기
                      </a>
                    </li>
                    <li class="nav-item scheduled" onclick="selectSubmenu(this, scheduled, 'scheduled')">
                      <a href="#" class="nav-link">
                        결재 예정
                      </a>
                    </li>
                    <li class="nav-item completed" onclick="selectSubmenu(this, completed, 'completed')">
                      <a href="#" class="nav-link">
                        결재 완료
                      </a>
                    </li>
                  </ul>
                </div>
              </div>

              <div class="card card-light submenu-body">
                <div class="card-header">
                  <h3 class="card-title">수신문서함</h3>
                  <div class="card-tools">
                    <button type="button" class="btn btn-tool" data-card-widget="collapse">
                      <i class="fas fa-minus"></i>
                    </button>
                  </div>
                </div>
                <div class="card-body p-0" style="display: block;">
                  <ul class="nav nav-pills flex-column">
                    <li class="nav-item department" onclick="selectSubmenu(this, department, 'department')">
                      <a href="#" class="nav-link">
                        부서 수신
                      </a>
                    </li>
                    <li class="nav-item reference" onclick="selectSubmenu(this, reference, 'reference')">
                      <a href="#" class="nav-link">
                        참조/열람
                      </a>
                    </li>
                  </ul>
                </div>
              </div>

              <div class="card card-light submenu-body">
                <div class="card-header">
                  <h3 class="card-title">개인문서함</h3>
                  <div class="card-tools">
                    <button type="button" class="btn btn-tool" data-card-widget="collapse">
                      <i class="fas fa-minus"></i>
                    </button>
                  </div>
                </div>
                <div class="card-body p-0" style="display: block;">
                  <ul class="nav nav-pills flex-column">
                    <li class="nav-item drafts" onclick="selectSubmenu(this, drafts, 'drafts')">
                      <a href="#" class="nav-link">
                        내 기안
                      </a>
                    </li>
                    <li class="nav-item temp" onclick="selectSubmenu(this, temp, 'temp')">
                      <a href="#" class="nav-link">
                        임시저장
                      </a>
                    </li>
                    <li class="nav-item scraps" onclick="selectSubmenu(this, scraps, 'scraps')">
                      <a href="#" class="nav-link">
                        스크랩
                      </a>
                    </li>
                    <li class="nav-item scraps" onclick="selectSubmenu(this, shared, 'shared')">
                      <a href="#" class="nav-link">
                        공유
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
                    <li class="nav-item sign" onclick="selectSubmenu(this, sign, 'sign')">
                      <a href="/everyware/approval/sign" class="nav-link">
                        서명관리
                      </a>
                    </li>
                    <li class="nav-item proxy" onclick="selectSubmenu(this, proxy, 'proxy')">
                      <a href="/everyware/approval/proxy" class="nav-link">
                        대결관리
                      </a>
                    </li>
                  </ul>
                </div>
              </div>

            </div>
          </div>
          <!-- /.subMenu -->

          <!-- approval Home -->
          <div class="col-md-10">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">서명관리</h3>
              </div>
              <div class="card-body">
                <div class="row">
                  <div class="col-md-3">
                    <div class="card card-primary card-outline">
                      <div class="card-header">
                        <h3 class="card-title">현재 서명</h3>
                      </div>
                      <div class="card-body">
                        <div class="img-wrap p-4 text-center">
                          <img class="rounded" id="input" src="data:image/jpeg;base64,${img}" onerror="this.style.display='none'">
                          <c:if test="${empty img}">
                            <span id="emptySignSpan">서명을 등록해주세요.</span>
                          </c:if>
                        </div>
                      </div>
                      <div class="card-footer justify-content-between">
                        <!-- db 이미지 삽입 -->
                        <div class="float-rigth"></div>
                        <button type="button" class="btn btn-primary img-save-btn float-right">저장</button>
                        <label class="btn btn-warning mb-0 mx-2 float-right" for="imageInput">변경</label>
                        <input type="file" src="" id="imageInput" name="file" accept="image/*">
                      </div>
                    </div>
                  </div>
                  <div class="col-md-9">
                    미리보기 영역
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>


  <!-- Modal -->
  <div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="modalLabel">이미지 업로드</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="img-container">
            <img id="image" src="" alt="Picture">
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
          <button type="button" class="btn btn-primary" id="crop">확인</button>
        </div>
      </div>
    </div>
  </div>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.5.13/cropper.min.js"></script>
  <script>
    var csrfHeader = $('meta[name="_csrf_header"]').attr('content');
    var csrfToken = $('meta[name="_csrf"]').attr('content');


    window.addEventListener('DOMContentLoaded', function () {
      var image = document.querySelector('#image');
      var input = document.querySelector('#input');
      var cropper;
    })

    var cropBtn = $('#crop');
    var modal = $('#modal');
    var saveBtn = $('.img-save-btn');

    $(function () {

      $('#imageInput').change(function (event) {

        file = event.target.files[0];
        $('#image').attr('src', URL.createObjectURL(file));

        cropper = new Cropper(image, {
          dragMode: 'move',
          aspectRatio: 1 / 1,
          autoCropArea: 0.65,
          restore: false,
          guides: false,
          center: false,
          highlight: false,
          cropBoxMovable: false,
          cropBoxResizable: false,
          toggleDragModeOnDblclick: false,
          minContainerWidth: 465,
          minContainerHeight: 300,
        });

        $('#modal').modal('show');

      });


      modal.on("hidden.bs.modal", function () {
        cropper.destroy();
        $('#imageInput').attr('scr', '');
        // cropper = null;
      });


      var initialImageURL;
      var canvas;

      cropBtn.on('click', function () {
        console.log('crop clicked');

        modal.modal('hide');

        if (cropper) {
          canvas = cropper.getCroppedCanvas({
            width: 100,
            height: 100,
          });
          initialImageURL = image.src;
          // image.src = canvas.toDataURL();
          input.src = canvas.toDataURL();
        }
        $('#emptySignSpan').hide();
        $(input).show();

      })

      saveBtn.on('click', function () {
        canvas.toBlob(function (blob) {
          var formData = new FormData();
          console.log(blob);

          formData.append('image', blob, 'sign.jpg');

          $.ajax({
            url: '/everyware/approval/sign',
            method: 'POST',
            data: formData,
            contentType: false,
            processData: false,
            beforeSend: function (xhr) {
              xhr.setRequestHeader(csrfHeader, csrfToken);
            },

            success: function () {
              alert("저장되었습니다.");
            },

            error: function () {
              image.src = initialImageURL;
              alert("Error!");
            },

          });
        });
      })

    });
  </script>
</body>

</html>