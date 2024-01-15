<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 회원가입 section 영역 -->
<div class="d-flex justify-content-center">
	<div class="section-inner-box">
		<h3 class="m-2">회원 가입</h3>
		<!-- 회원 가입 form -->
		<form id="signUpForm" method="post" action="/user/sign-up">
			<div class="border-box border">
				<div class="m-2">
					<label>ID</label>
					<div class="d-flex align-items-center">
						<input type="text" name="loginId" placeholder="ID를 입력해주세요."
							class="form-control col-7">
						<%-- 중복확인 버튼 --%>
						<small><button type="button" id="loginId-check-btn"
								class="btn btn-primary btn-sm ml-3">중복확인</button></small>
					</div>
					<%-- 중복확인 관련 메시지 3종 --%>
					<small id="loginId-dupl-message" class="dupl-message text-danger d-none">
						사용중인 아이디입니다.
					</small>
					<small id="loginId-4word-message" class="dupl-message text-danger d-none">
						아이디는 4자 이상이어야 합니다.
					</small>
					<small id="loginId-good-message" class="dupl-message text-success d-none">
						사용 가능한 아이디입니다.
					</small>
				</div>
				<div class="m-2">
					<label>password</label> 
					<input type="password" name="password" placeholder="****" class="form-control col-6">
				</div>
				<div class="m-2">
					<label>confirm password</label> 
					<input type="password" id="confirmPassword" placeholder="****" class="form-control col-6">
				</div>
				<div class="m-2">
					<label>이름</label> 
					<input type="text" name="name" placeholder="이름을 입력해주세요" class="form-control col-7">
				</div>
				<div class="m-2">
					<label>이메일</label> 
					<input type="text" name="email" placeholder="이메일을 입력해주세요" class="form-control col-7">
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
		
		// 중복확인 버튼 이벤트
		$("#loginId-check-btn").on('click', function() {
			//alert("중복확인");
			
			// 메시지 초기화
			$('.dupl-message').addClass("d-none");
			
			// 아이디 4자 이상 문구 띄우기
			let loginId = $('input[name=loginId]').val().trim();
			if (loginId.length < 4) {
				$('#loginId-4word-message').removeClass("d-none");
				return;
			}
			
			// AJAX - 중복확인
			$.get("/user/is-duplicated-id", {"loginId":loginId})
			.done(function(data) {
				if (data.code == 200) {
					if (data.is_duplicated_id) {
						// 중복일때
						$('#loginId-dupl-message').removeClass("d-none");
					} else {
						// 아닐때
						$('#loginId-good-message').removeClass("d-none");
					}
				} else {
					// 확인 실패할때
					alert("중복확인에 실패했습니다. 관리자에게 문의하세요.");
				}
			});
			
		});
		
		
		// submit 버튼 이벤트
		$('#signUpForm').on('submit', function(e) {
			e.preventDefault();// submit 기능 끄기
			//alert("submit");
			
			// validation check
			let loginId = $("input[name=loginId]").val().trim();
			let password = $("input[name=password]").val();
			let confirmPassword = $("#confirmPassword").val();
			let name = $("input[name=name]").val().trim();
			let email = $("input[name=email]").val().trim();
			if (!loginId) {
				alert("아이디을 입력하세요.");
				return false;
			}
			if (!password || !confirmPassword) {
				alert("비밀번호를 입력하세요.");
				return false;
			}
			if (password != confirmPassword) {
				alert("비밀번호가 일치하지 않습니다.")
				return false;
			}
			if (!name) {
				alert("이름을 입력하세요.");
				return false;
			}
			if (!email) {
				alert("이메일을 입력하세요.");
				return false;
			}
			
			// 중복확인 후 사용가능한 아이디인지 확인
			if ($("#loginId-good-message").hasClass("d-none")) {
				alert("아이디 중복확인을 해주세요.");
				return false;
			}
			
			// 데이터 전송
			let url = $(this).attr("action"); // url에 /user/sign-up
			let params = $(this).serialize(); // name속성값들 파라미터로 구성
			
			$.post(url, params) // request
			.done(function(data) { // response
				
				if (data.code == 200) {
					alert("가입을 환영합니다. 로그인 해주세요.");
					location.href="/user/sign-ㅑㅜ-view";
				} else {
					alert(data.error_message);
				}
			
			}); // $.post() 끝
			
		}); // submit 버튼 끝
	}); // 레디이벤트
</script>