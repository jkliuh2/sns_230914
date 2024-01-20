<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="d-flex justify-content-center">
	<div class="section-inner-box">
		<h3 class="m-2">본인확인</h3>
		<!-- 본인확인 form -->
		<form id="identificationForm" method="post" action="/user/identification">
			<div class="border-box border d-flex justify-content-center align-items-center">
				<div id="login-input-box">
					<%-- 로그인 ID input --%>
					<input type="text" placeholder="Username" name="loginId" class="form-control my-2"> 
					<%-- password input --%>
					<input type="password" placeholder="password" name="password" class="form-control my-2">
					<div class="d-flex justify-content-between my-2">
						<%-- 다시 프로필 화면으로 돌아가기 --%>
						<a href="#">
							<button type="button" class="log-in-btn btn btn-secondary">뒤로</button>
						</a>
						<%-- 본인인증 확인버튼 --%>
						<button type="submit" class="log-in-btn btn btn-primary">확인</button>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>

<script>
	$(document).ready(function() {
		
		// 본인확인 submit 이벤트
		$('#identificationForm').on("submit", function(e) {
			e.preventDefault();
			// alert("본인확인");
			
			// validation check
			let loginId = $('input[name=loginId]').val().trim();
			let password = $('input[name=password]').val();
			if (!loginId) {
				alert("아이디를 입력하세요");
				return false;
			}
			if (!password) {
				alert("비밀번호를 입력하세요");
				return false;
			}
			
			// AJAX - 본인확인
			let url = $(this).attr("action");
			let params = $(this).serialize();
			
			$.post(url, params) // request
			.done(function(data)) { // response
				if (data.code == 200) {
					// 본인확인 성공
					location.href = "/user/user-update-view"; // 이거 GET 방식 아님?
				} else if (data.code == 500) {
					// 세션의 정보와 input의 정보가 불일치
					alert("error_message"); // "입력하신 정보가 틀립니다."
					$("input").val("");
				} else if (data.code == 400) {
					// 로그인 세션 만료
					alert("error_message"); // "로그인 세션이 만료되었습니다. 다시 로그인 해주세요."
					location.href="/user/sign-in-view";
				}
			}
			
		}); // submit 이벤트 끝
	}); // 레디이벤트 끝
</script>