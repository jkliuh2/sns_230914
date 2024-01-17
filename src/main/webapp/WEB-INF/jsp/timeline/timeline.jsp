<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="d-flex justify-content-center">
	<div class="content-box w-50">
		<%-- 로그인 상태일 때 보이는 글 쓰기 상자 --%>
		<c:if test="${not empty userId}">
		<div id="post-box" class="border rounded m-3">
			<%-- content --%>
			<textarea id="content" rows="5" placeholder="내용을 입력해주세요." class="w-100 border-0"></textarea>
			<div class="d-flex justify-content-between p-2">
				<%-- 그림 업로드 --%>
				<div class="file-upload d-flex align-items-center">
					<%-- 업로드 버튼 --%>
					<label for="img-file">
						<div id="upload-img-div">
							<img src="/static/img/img-icon.png" alt="이미지 아이콘" width="24" height="24">
						</div>
					</label>
					<%-- 그림 file input --%>
					<input type="file" id="img-file" name="img-file" accept=".jpg, .png, .gif, .jpeg">
					<small id="imgUploadCheck" class="text-primary font-weight-bold ml-2 d-none">그림 파일 업로드</small>
				</div>
				<%-- 업로드 버튼 --%>
				<button id="uploadBtn" type="button" class="btn btn-primary btn-sm">업로드</button>				
			</div>
		</div>
		</c:if> <%-- 글 쓰기 상자 끝 --%>
		
		
		<%-- timeline 영역 --%>
		<div class="my-5">
			<c:forEach items="${postList}" var="post">
			<%-- 카드(반복되는 부분) --%>
			<div class="card border rounded mt-3">
				<%-- 글쓴이, 더보기(삭제) --%>
				<div class="d-flex justify-content-between px-2 back-color">
					<%-- post 글쓴이 --%>
					<div>
						<span class="font-weight-bold">${post.userId}</span>
					</div>
					<%-- 삭제 더보기 버튼 --%>
					<div>
						<a href="#" class="more-btn">
							<img src="/static/img/more.png" width="25" alt="더보기 아이콘">
						</a>
					</div>
				</div>
				
				<%-- 이미지  --%>
				<div class="card-img">
					<img class="w-100" src="/static/img/post1.webp" alt="게시글 이미지">
				</div>
				<%-- 좋아요 --%>
				<div class="card-like m-3">
					<a href="#" class="like-btn">
						<img src="/static/img/empty-heart.png" alt="좋아요" width="18" height="18">
					</a>
					<span class="font-weight-bold">좋아요 n개</span>
				</div>
				
				<%-- 글 내용 --%>
				<div class="card-post m-3">
					<span class="font-weight-bold">글쓴이</span>
					<span>${post.content}</span>
				</div>
				
				<%-- 댓글 header 부분 --%>
				<div class="card-comment-desc border-bottom back-color">
					<small class="font-weight-bold mx-2">댓글</small>
				</div>
				
				<%-- 댓글 목록 --%>
				<div class="card-comment-list m-2">
					<%-- 반복문 시작지점 --%>
					<c:forEach begin="1" end="3" var="i">
					<%-- 댓글 내용 --%>
					<div class="card-comment m-1">
						<small class="font-weight-bold">작성자${i}</small>
						<small>댓글내용${i}</small>
						
						<%-- 댓글 삭제 버튼 --%>
						<a href="#" class="comment-del-btn">
							<img src="/static/img/delete-button-x.png" width="10" height="10">
						</a>
					</div><%-- 댓글 내용 끝 --%>
					</c:forEach> <%-- 반복문 끝 --%>
				</div><%-- 댓글 목록 끝 --%>
			</div> <%-- 카드 영역 끝 --%>
			</c:forEach>
		</div> <%-- 타임라인 영역 끝 --%>
	</div> <%-- content-box 끝 --%>
</div>

<script>
	$(document).ready(function() {
		
		// 업로드 버튼 클릭 - post insert
		$('#uploadBtn').on('click', function() {
			//alert("업로드");
			
			let content = $('#content').val().trim();
			let fileName = $('#img-file').val();
			
			// validation check
			if (!content && !fileName) {
				alert("내용과 그림 중 하나는 입력되어야 합니다.");
				return;
			}
			// 파일이 업로드 된 경우에만 확장자 체크
			if (fileName) {
				// 확장자만 빼오기 (jpg)
				let extension = fileName.split(".").pop().toLowerCase();
				
				if ($.inArray(extension, ['jpg', 'png', 'gif', 'jpeg']) == -1) {
					// 정해진 확장자가 아닐 경우
					alert("이미지 파일만 업로드 할 수 있습니다.");
					$('#img-file').val("");
					return;
				}
			}
			
			// FormData
			let formData = new FormData();
			formData.append("content", content);
			formData.append("file", $('#img-file')[0].files[0]);
			
			// AJAX - insert
			$.ajax({
				// request
				type:"POST"
				, url:"/post/create"
				, data:formData
				, enctype:"multipart/form-data"
				, processData:false
				, contentType:false
				
				// response
				, success:function(data) {
					if (data.code == 200) {
						alert("타임라인을 작성하였습니다.");
						location.reload();
					} else {
						alert(data.error_message);
					}
				}
				, error(request, status, error) {
					alert("타임라인 저장에 실패했습니다. 관리자에게 문의해주세요.");
				}
			}); // AJAX-insert 끝
			
		}); // 업로드 버튼 끝
		
		
		// 그림파일 input 변경 이벤트
		$('#img-file').on('change', function() {
			//lert("그림파일 변경");
			
			// 업로드 글자표시 생성
			$('#imgUploadCheck').addClass("d-none");
			
			let fileCheck = $(this).val();
			if (fileCheck) {
				// 업로드 파일 존재
				$('#imgUploadCheck').removeClass("d-none"); // 글자 생성
			} 
		}); // 그림파일 변경 이벤트 끝
		
	}); // 레디이벤트 끝
</script>