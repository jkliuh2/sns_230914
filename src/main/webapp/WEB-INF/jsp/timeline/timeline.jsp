<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="d-flex justify-content-center">
	<div class="content-box w-50">
		<%-- 로그인 상태일 때 보이는 글 쓰기 상자 --%>
		<c:if test="${not empty userId}">
		<div id="post-box" class="border rounded m-3">
			<textarea id="content" name="content" rows="3" placeholder="내용을 입력해주세요." class="w-100 border-0"></textarea>
			<div class="d-flex justify-content-between p-2">
				<div class="file-upload d-flex">
					<a href="#" id="fileUploadBtn"><img src="/static/img/img-icon.png" alt="이미지 아이콘" width="24"></a>
				</div>
				<button type="submit" class="btn btn-primary btn-sm">업로드</button>				
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
					<span>글 내용</span>
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