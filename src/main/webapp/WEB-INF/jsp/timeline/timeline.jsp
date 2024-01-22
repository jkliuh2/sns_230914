<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="d-flex justify-content-center">
	<div class="content-box">
		<%-- 로그인 상태일 때 보이는 글 쓰기 상자 --%>
		<c:if test="${not empty userId}">
		<div id="post-box" class="border rounded m-3">
			<%-- content 영역 --%>
			<textarea id="content" rows="5" placeholder="내용을 입력해주세요." class="w-100 border-0"></textarea>
			<div class="d-flex justify-content-between p-2">
				<%-- 그림 업로드 영역 --%>
				<div class="file-upload d-flex align-items-center">
					<%-- 업로드 버튼 --%>
					<a href="#" id="fileUploadBtn">
						<img src="/static/img/img-icon.png" alt="이미지 아이콘" width="24" height="24">
					</a>
					<%-- 그림 file input --%>
					<input type="file" id="file" accept=".jpg, .png, .gif, .jpeg" class="d-none">
					<%-- 업로드 된 임시 이미지 파일 이름 나타내는 곳 --%>
					<div id="file-name" class="ml-2"></div>
				</div>
				<%-- 업로드 버튼 --%>
				<button id="uploadBtn" type="button" class="btn btn-primary btn-sm">업로드</button>				
			</div>
		</div>
		</c:if> <%-- 글 쓰기 상자 끝 --%>
		
		
		<%-- timeline 영역 --%>
		<div class="my-5">
			<c:forEach items="${cardViewList}" var="card">
			<%-- 카드(반복되는 부분) --%>
			<div class="card border rounded mt-3">
				<%-- 글쓴이, 더보기(삭제) --%>
				<div class="d-flex justify-content-between px-2 back-color">
					<%-- post 글쓴이(loginId) --%>
					<div>
						<a class="user-profile-link" href="/profile/user-profile-view?userId=${card.user.id}">
							<span class="font-weight-bold">${card.user.loginId}</span>
						</a>
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
					<c:choose>
						<c:when test="${empty card.post.imagePath}">
							<img class="w-100" src="/static/img/no-image.png" alt="게시글 이미지">
						</c:when>
						<c:otherwise>
							<img class="w-100" src="${card.post.imagePath}" alt="게시글 이미지">
						</c:otherwise>
					</c:choose>
				</div>
				<%-- 좋아요 --%>
				<div class="card-like m-3">
					<a href="#" id="like-btn">
						<img src="/static/img/empty-heart.png" alt="좋아요" width="18" height="18">
					</a>
					<span class="font-weight-bold">좋아요 n개</span>
				</div>
				
				<%-- 글 내용 --%>
				<div class="card-post m-3">
					<%-- 글 쓴이 + 글 내용 --%>
					<a class="user-profile-link" href="/profile/user-profile-view?userId=${card.user.id}">
						<span class="font-weight-bold">${card.user.loginId}</span>
					</a>
					<span>${card.post.content}</span>
				</div>
				
				<%-- 댓글 header 부분 --%>
				<div class="card-comment-desc border-bottom back-color">
					<small class="font-weight-bold mx-2">댓글</small>
				</div>
				
				<%-- 댓글 목록 --%>
				<div class="card-comment-list m-2">
					<%-- 댓글 반복문 시작지점 --%>
					<c:forEach items="${card.commentList}" var="commentView">
					
						<%-- 댓글 내용 --%>
						<div class="card-comment m-1">
							<%-- 댓글 작성자(userId) --%>
							<a class="user-profile-link" href="/profile/user-profile-view?userId=${commentView.user.id}">
								<small class="font-weight-bold">${commentView.user.loginId}</small>
							</a>
							<%-- 댓글 내용 --%>
							<small>${commentView.comment.content}</small>
								
							<%-- 댓글 삭제 버튼(세션의 유저정보=댓글 유저정보 이면 노출) --%>
							<c:if test="${userId == commentView.user.id}">
								<a href="#" class="comment-del-btn" data-comment-id="${commentView.comment.id}">
									<img src="/static/img/delete-button-x.png" width="10" height="10">
								</a>
							</c:if>
						</div><%-- 댓글 내용 끝 --%>
						
						
					
					</c:forEach> <%-- 댓글 반복문 끝 --%>
					
					<%-- 댓글 쓰기 영역 --%>
					<div class="d-flex border-top">
						<input type="text" name="content" class="form-control mr-2">
						<button type="submit" data-post-id="${card.post.id}" data-user-id="${userId}" class="commentBtn btn btn-info no-wrap">게시</button>
					</div>
					
				</div><%-- 댓글 목록 끝 --%>
			</div> <%-- 카드 영역 끝 --%>
			</c:forEach>
			
		</div> <%-- 타임라인 영역 끝 --%>
	</div> <%-- content-box 끝 --%>
</div>

<script>
	$(document).ready(function() {
		
		// 댓글 삭제 버튼
		$('.comment-del-btn').on('click', function(e) {
			e.preventDefault(); // <a> 기능 막기
			//alert("댓글 삭제");
			
			// 버튼의 data값으로 commentId 값 가져오기
			let commentId = $(this).data("comment-id");
			alert(commentId);
			
			// ajax - DELETE			
			$.ajax({
				// request
				type:"DELETE"
				, url:"/comment/delete"
				, data:{"commentId":commentId}
			
				// response
				, success:function(data) {
					if (data.code == 200) {
						// 성공
						alert(data.success_message);
						location.reload();
					} else if (data.code == 501) {
						// 세션이 버튼과 다른 유저 -> 페이지 새로고침
						alert(data.error_message);
						location.reload();
					} else if (data.code == 502) {
						// 세션 만료 -> 로그인화면으로
						alert(data.error_message);
						location.href = "/user/sign-in-view";
					} 
				}
				, error:function(request, status, error) {
					alert("댓글 삭제에 실패했습니다. 관리자에게 문의해주세요.");
				}
				
			}); // ajax 끝
	}); // 댓글삭제 이벤트 끝
		
		
		// 댓글 쓰기 버튼 클릭 이벤트(form)
		$('.commentBtn').on('click', function() {
			//alert("댓글 쓰기");
			
			// 로그인 된 사람의 userId - 이것도 그냥 버튼에 심어 뒀다.
			let userId = $(this).data('user-id'); 
			if (!userId) {
				// 비-로그인 이면 로그인 화면 이동
				alert("로그인을 해주세요.");
				location.href="/user/sign-in-view";
				return;
			}
			
			// 댓글다는 글(post)의 id
			let postId = $(this).data("post-id");
			
			// ★ 방금 클릭된 버튼의 "근처의" input값 가져오기
			// 1. 클릭된 버튼의 바로 위의 (이전 태그의) input 값 가져오기
			//let content = $(this).prev().val().trim();
			
			// 2. 방금 클릭된 버튼의 상위 div 내의 (형제 태그의) input 가져오기
			let content = $(this).siblings("input").val().trim();
			//alert(content);
			
			// AJAX - create
			$.ajax({
				// request
				type:"POST"
				, url:"/comment/create"
				, data:{"userId":userId, "postId":postId, "content":content}
				
				// response
				, success:function(data) {
					if (data.code == 200) {
						// 댓글 생성 성공
						alert(data.result); // "댓글을 작성했습니다."
						location.reload();
					}
				}
				, error:function(request, status, error) {
					alert("댓글 쓰기에 실패했습니다. 관리자에게 문의해주세요.")
				}
			}); // ajax-create 끝
		}); // 댓글 버튼 클릭 이벤트 끝
		
		
		
		// 업로드 버튼 클릭 - post insert
		$('#uploadBtn').on('click', function() {
			//alert("업로드");
			
			let content = $('#content').val().trim();
			let fileName = $('#file').val();
			
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
					$('#file').val("");
					return;
				}
			}
			
			// FormData
			let formData = new FormData();
			formData.append("content", content);
			formData.append("file", $('#file')[0].files[0]);
			
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
		
		
		// 파일 이미지 업로드 버튼 클릭이벤트
		$('#fileUploadBtn').on('click', function(e) {
			// 파일 이미지 클릭 => 숨겨져 있는 id="file" 동작시킨다.
			e.preventDefault(); // <a> 태그의 기본 동작 멈춤(스크롤 위로 올라감)
			$('#file').click(); // <input> file을 클릭한 효과
			
		}); // 파일 업로드 버튼 끝
		
		
		// <input id="file"> change 이벤트
		$('#file').on('change', function(e) {
			// 사용자가 이미지를 선택하는 순간 => 유효성체크 + 업로드된 파일명 노출
			
			// null 처리
			let file = e.target.files[0];
			if (file == null) {
				alert("null file");
				$('#file').val("");
				$('#file-name').text("");
				return;
			}
			
			
			let fileName = e.target.files[0].name; 
			// e.target=this / files[0] : 업로드한 파일 / name : 업로드 파일 이름
			//console.log(fileName); // 실제 파일 이름
			
			// 확장자 유효성 체크
			let ext = fileName.split(".").pop().toLowerCase();
			//alert(ext);
			if (ext != "jpg" && ext != "jpeg" && ext != "png" && ext != "gif") {
				alert("이미지 파일만 업로드 할 수 있습니다.");
				$('#file').val(""); // 파일 비우기★
				$('#file-name').text(""); // 파일명 노출도 비우기
				return;
			}
			
			// 유효성 통과한 이미지의 경우, 파일 명 노출
			$('#file-name').text(fileName);
			
		}); // file change 이벤트 끝
		
	}); // 레디이벤트 끝
</script>