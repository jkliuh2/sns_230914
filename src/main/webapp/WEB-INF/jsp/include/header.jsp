<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- header 영역 --%>
<div class="d-flex h-100 w-100">
	<!-- logo 영역 -->
	<div id="logo-box" class="col-5 d-flex align-items-center">
		<a id="logo" href="/timeline/timeline-view"><h3>Marondalgram</h3></a>
	</div>
	<!-- 중간 영역 -->
	<div id="hello-user" class="col-5 d-flex justify-content-end align-items-center">
		<c:if test="${not empty userName}">
			<%-- 로그인 사용자 이름. 프로필 창으로 이동 --%>
			<span class="font-weight-bold">
				<a href="/user/profile-view?userId=${userId}" id="hello-user-a">${userName}</a>님 안녕하세요!
			</span>
		</c:if>
	</div>
	<!-- 로그인or로그아웃 영역 -->
	<div id="log-in-out" class="col-2 d-flex justify-content-center align-items-center">
		<c:if test="${not empty userName}">
			<a class="sign-in-out" href="/user/sign-out">로그아웃</a>
		</c:if>
		<c:if test="${empty userName}">
			<a class="sign-in-out" href="/user/sign-in-view">로그인</a>
		</c:if>
	</div>
</div>