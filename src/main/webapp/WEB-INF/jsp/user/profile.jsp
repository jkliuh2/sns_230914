<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex justify-content-center">
	<%-- 프로필 페이지 영역 --%>
	<div class="profile-box">
		<%-- 유저 프로필 영역 --%>
		<div class="border p-2 mt-5">
			<%-- 사진 + 유저정보 영역 --%>
			<div id="user-box" class="d-flex">
				<%-- 프로필 사진 + 팔로우 버튼 --%>
				<div class="col-3 h-100">
					<%-- 프로필 사진 --%>
					<div id="profile-img-box" class="w-100 border d-flex justify-content-center align-items-center">
						<img id="profile-img" src="/static/img/no-profile-img.png" class="w-100">
					</div>
					<%-- 팔로우 버튼 --%>
					<div id="follow-btn-box" class="d-flex justify-content-center align-items-center">
						<button id="followBtn" type="button" class="btn btn-primary">팔로우</button>
					</div>
				</div>
				
				<%-- 유저 정보 + 정보 수정 + 팔로우 --%>
				<div class="col-9 h-100">
					<div id="user-loginId-box" class="d-flex justify-content-center">
						<h2>${user.loginId}</h2>
					</div>
					<div id="user-field-box">
						<%-- 유저 field 리스트 --%>
						<div class="half-div d-flex align-items-center">
							<ul>
								<li>이름 : ${user.name}</li>
								<li>이메일 : ${user.email}</li>
							</ul>
						</div>
							
						<%-- 게시물, 팔로우, 팔로워 --%>
						<div class="half-div">
							<div class="d-flex font-weight-bold">
								<div class="col-4 mt-3">
									<div class="d-flex justify-content-center"><h3>5</h3></div>
									<div class="d-flex justify-content-center">게시물</div>
								</div>
								<div class="col-4 mt-3">
									<div class="d-flex justify-content-center"><h3>5</h3></div>
									<div class="d-flex justify-content-center">팔로우</div>
								</div>
								<div class="col-4 mt-3">
									<div class="d-flex justify-content-center"><h3>5</h3></div>
									<div class="d-flex justify-content-center">팔로워</div>
								</div>
							</div>
						</div>
						
					</div>
				</div> <%-- 유저 정보 + 정보 수정 + 팔로우 --%>
			</div> <%-- 사진 + 유저정보 끝 --%>
		</div> <%-- 유저 프로필 영역 끝 --%>
	
		<%-- 타임라인 영역 --%>
		<div class="content-box">
		</div>
		
	</div> <%-- 프로필 페이지 끝 --%>
</div>