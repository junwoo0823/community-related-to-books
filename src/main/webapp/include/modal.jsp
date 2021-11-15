<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="modal fade shadow-sm" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Logout</h5>
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">정말 로그아웃을 하시겠습니까?</div>
			<div class="modal-footer">
				<a class="btn btn-primary" href="/member/logout.jsp">예</a>
				<button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>