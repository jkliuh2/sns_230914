<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 로그인 section 영역 -->
<div class="d-flex justify-content-center">
	<div class="section-inner-box">
		<h3 class="m-2">로그인</h3>
		<!-- 로그인 form -->
		<form id="loginForm" method="post" action="/user/sign-in">
			<div class="border-box border d-flex justify-content-center align-items-center">
				<div id="login-input-box">
					<%-- 로그인 ID input --%>
					<input type="text" placeholder="Username" name="loginId" class="form-control my-2"> 
					<%-- password input --%>
					<input type="password" placeholder="password" name="password" class="form-control my-2">
					<div class="d-flex justify-content-between my-2">
						<%-- 회원가입으로 가는 <a> 버튼 --%>
						<a href="/user/sign-up-view">
							<button type="button" class="log-in-btn btn btn-secondary">회원가입</button>
						</a>
						<%-- 로그인 submit 버튼 --%>
						<button type="submit" class="log-in-btn btn btn-primary">로그인</button>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>

<script>
	$(document).ready(function() {
		
		// 로그인 버튼 클릭이벤트
		$('#loginForm').on('submit', function(e) {
			e.preventDefault(); // submit 기능 막기
			//alert("로그인");
			
			// validation check
			let loginId = $('input[name=loginId]').val().trim();
			let password = $('input[name=password]').val();
			if (!loginId) {
				alert("Id를 입력하세요.");
				return false;
			}
			if (!password) {
				alert("비밀번호를 입력하세요.");
				return false;
			}
			
			// AJAX - select 후 로그인
			//let loginId = $('input[name=loginId]').val();
			//let password = $('input[name=password]').val();
			let url = $(this).attr("action");
			let params = $(this).serialize();
			$.post(url, params)
			.done(function(data) {
				if (data.code == 200) {
					// 로그인 성공
					location.href="/timeline/timeline-view";
				} else {
					// 로그인 실패
					alert(data.error_message);
				}
			}); // AJAX 끝
			
		}); // 로그인 버튼 클릭이벤트 끝
	}); // 레디이벤트 끝
</script>