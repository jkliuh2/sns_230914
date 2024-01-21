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
							<%-- post 글쓴이 --%>
							<div>
								<span class="font-weight-bold">${card.user.loginId}</span>
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
							<span class="font-weight-bold">${card.user.loginId}</span>
							<span>${card.post.content}</span>
						</div>
						
						<%-- 댓글 header 부분 --%>
						<div class="card-comment-desc border-bottom back-color">
							<small class="font-weight-bold mx-2">댓글</small>
						</div>
						
						<%-- 댓글 목록 --%>
						<div class="card-comment-list m-2">
							<%-- 댓글 반복문 시작지점 --%>
							<c:forEach begin="1" end="3" var="i">
							
								<%-- 글의 postId = comment의 postId가 일치하면 댓글 출력 --%>
								
								<%-- 댓글 내용 --%>
								<div class="card-comment m-1">
									<%-- 댓글 작성자(userId) --%>
									<small class="font-weight-bold">댓글 ${i}</small>
									<%-- 댓글 내용 --%>
									<small>댓글 내용 ${i}</small>
										
									<%-- 댓글 삭제 버튼 --%>
									<a href="#" class="comment-del-btn">
										<img src="/static/img/delete-button-x.png" width="10" height="10">
									</a>
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
					
				</div> <%-- 복붙 영역 끝 --%>
			</div>
		</div> <%-- 타임라인 영역 끝 --%>
		
	</div> <%-- 프로필 페이지 끝 --%>
</div>

<script>
	$(document).ready(function() {
		
	}); // 레디이벤트
</script>