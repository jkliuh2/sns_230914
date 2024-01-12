<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 회원가입 section 영역 -->
<div class="d-flex justify-content-center">
	<div class="section-inner-box">
		<h3 class="m-2">회원 가입</h3>
		<!-- 회원 가입 form -->
		<form method="post" action="/user/sign-up">
			<div class="border-box border">
				<div class="m-2">
					<label>ID</label>
					<div class="d-flex align-items-center">
						<input type="text" name="loginId" placeholder="ID를 입력해주세요."
							class="form-control col-7">
						<!-- 중복확인 버튼 -->
						<small><button id="loginId-check-btn"
								class="btn btn-primary btn-sm ml-3">중복확인</button></small>
					</div>
					<small id="loginId-dupl-message" class="text-danger">사용중인
						아이디 입니다.</small>
				</div>
				<div class="m-2">
					<label>password</label> <input type="password" name="password"
						placeholder="****" class="form-control col-6">
				</div>
				<div class="m-2">
					<label>confirm password</label> <input type="password"
						name="confirm-password" placeholder="****"
						class="form-control col-6">
				</div>
				<div class="m-2">
					<label>이름</label> <input type="text" name="name"
						placeholder="이름을 입력해주세요" class="form-control col-7">
				</div>
				<div class="m-2">
					<label>이메일</label> <input type="text" name="email"
						placeholder="이메일을 입력해주세요" class="form-control col-7">
				</div>
				<div class="m-2 d-flex justify-content-center">
					<input type="submit" value="가입하기" class="btn btn-primary">
				</div>
			</div>
		</form>
	</div>
</div>

<script>
	$(document).ready(function() {
		
	}); // 레디이벤트
</script>