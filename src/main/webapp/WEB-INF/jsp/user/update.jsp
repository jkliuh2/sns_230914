<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="d-flex justify-content-center">
	<%-- 실제 box --%>
	<div id="update-box" class="d-flex">
	
		<%-- 유저 프로필 사진 들어갈 곳 --%>
		<div class="col-3 p-1 mt-5">
			<div>
				<div class="border">
					<img id="profile-img-show" src="/static/img/no-profile-img.png" class="w-100" alt="프로필 이미지">
				</div>
			</div>
			<div class="d-flex justify-content-center mt-2">
				<button id="profileBtn" type="button" class="btn btn-primary">프로필 업로드</button>
			</div>
			<input id="profileImg" type="file" class="d-none">
		</div>
		
		<%-- 그 외 유저정보 들어갈 곳 --%>
		<div class="col-9 p-3 d-flex justify-content-center">
			<div class="w-75">
				<div class="my-5">
					<span>ID</span>
					<input type="text" id="LoginId" class="form-control" value="${user.loginId}">
				</div>
				<div class="my-5">
					<span>이름</span>
					<input type="text" id="name" class="form-control" value="${user.name}">
				</div>
				<div class="my-5">
					<span>이메일</span>
					<input type="text" id="email" class="form-control" value="${user.email}">
				</div>
				<div class="my-5">
					<span>비밀번호</span>
					<input type="password" id="password" class="form-control" placeholder="수정할 비밀번호를 입력하세요.">
					<small class="text-info">비밀번호 수정을 원하지 않는다면, 입력하지 않으셔도 됩니다.</small>
				</div>
				<div class="my-5">
					<span>비밀번호 확인</span>
					<input type="password" id="confirmPassword" class="form-control" placeholder="비밀번호와 같아야 합니다.">
				</div>
				<%-- 뒤로, 수정 버튼 --%>
				<div class="d-flex justify-content-between">
					<a href="/profile/user-profile-view?userId=${user.id}">
						<button class="btn btn-dark btn-lg">뒤로</button>
					</a>
					<button class="btn btn-success btn-lg">수정</button>
				</div>
			</div>
		</div>
	</div>
</div>