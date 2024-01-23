<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
					<div id="user-loginId-box" class="d-flex justify-content-center align-items-center">
						<h2>${user.loginId}</h2>
						<%-- 내 정보 수정(세션id == 프로필id) --%>
						<c:if test="${userId == user.id}">
							<form id="user-update-form" method="post" action="/user/update-view">
								<input class="d-none" name="userId" value="${user.id}">
								<button id="user-update-btn" type="submit" class="btn btn-dark ml-5">내 정보 수정</button>
							</form>
						</c:if>
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
									<div class="d-flex justify-content-center"><h3>${cardViewList.size()}</h3></div>
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
		<div class="d-flex justify-content-center">
			<div class="content-box">
				<%-- 타임라인 복붙한 영역 --%>
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
							<c:choose>
								<c:when test="${card.filledLike}">
									<%-- 채워진 하트 --%>
									<a href="#" class="like-btn" data-post-id="${card.post.id}">
										<img src="/static/img/fill-heart.png" alt="좋아요" width="18" height="18">
									</a>
								</c:when>
								<c:otherwise>
									<%-- 빈 하트 --%>
									<a href="#" class="like-btn" data-post-id="${card.post.id}">
										<img src="/static/img/empty-heart.png" alt="좋아요" width="18" height="18">
									</a>
								</c:otherwise>
							</c:choose>
								
								<span class="font-weight-bold">좋아요 ${card.likeCount}개</span>
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
									<c:if test="${userId eq commentView.user.id}">
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
					
				</div><%-- 복붙 영역 끝 --%>				
			</div>
		</div> <%-- 타임라인 영역 끝 --%>
		
	</div> <%-- 프로필 페이지 끝 --%>
</div>

<script>
	$(document).ready(function() {
		
		// 좋아요 토글 이벤트
		$('.like-btn').on('click', function(e) {
			e.preventDefault();
			
			let postId = $(this).data("post-id");
			
			$.ajax({
				// request
				url:"/like/" + postId    // 와일드카드에서 url 보낼 때
			
				// response
				, success:function(data) {
					if (data.code == 200) {
						// 좋아요 생성or삭제 성공 => 새로고침
						location.reload();
					} else if (data.code == 300) {
						// 로그인 만료 -> 로그인 페이지로 이동
						alert(data.error_message);
						location.href = "/user/sign-in-view";
					}
				}
				, error:function(request, status, error) {
					alert("오류가 발생했습니다. 관리자에게 문의해주세요.");
				}
				
			}); // ajax 끝
		}); // 좋아요 토글 이벤트 끝
		
		
		// 댓글 삭제 버튼
		$('.comment-del-btn').on('click', function(e) {
			e.preventDefault(); // <a> 기능 막기
			
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
						alert(data.success_message); // 댓글 성공
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
		
		
	}); // 레디이벤트
</script>