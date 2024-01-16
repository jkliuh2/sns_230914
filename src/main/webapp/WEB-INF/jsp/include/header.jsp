<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- header 영역 --%>
<div class="d-flex h-100 w-100">
	<!-- logo 영역 -->
	<div id="logo-box" class="col-5 d-flex align-items-center">
		<a id="logo" href="/timeline/list-view"><h3>Marondalgram</h3></a>
	</div>
	<!-- 중간 영역 -->
	<div id="hello-user" class="col-5 d-flex justify-content-end align-items-center">
		<span class="font-weight-bold">${userName}님 안녕하세요!</span>
	</div>
	<!-- 로그인or로그아웃 영역 -->
	<div id="log-in-out" class="col-2 d-flex justify-content-center align-items-center">
		<a id="sign-in-out" href="#">로그인</a>
	</div>
</div>