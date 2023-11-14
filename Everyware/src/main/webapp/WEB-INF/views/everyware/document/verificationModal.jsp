<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="modal fade bd-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="verificationModal" aria-hidden="true" id="verif-modal">
    <div class="modal-dialog modal-sm modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="p-3">
                <label for="password">비밀번호</label>
                <input type="password" class="form-control" name="password" id="password" placeholder="비밀번호를 입력해주세요." autofocus>
            </div>

            <div class="modal-footer justify-content-between">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary verif-btn" data-dismiss="modal">확인</button>
            </div>
        </div>

</div>