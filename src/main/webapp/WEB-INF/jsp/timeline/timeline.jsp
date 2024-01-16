<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="d-flex justify-content-center">
	<div class="w-50">
		<%-- 로그인 상태일 때 보이는 글 쓰기 상자 --%>
		<div id="post-box" class="border m-3">
			<textarea id="content" name="content" rows="3" placeholder="내용을 입력해주세요." class="form-control border-0"></textarea>
			<div class="d-flex justify-content-between p-2">
				<img src="/static/img/img-icon.png" alt="이미지 아이콘" width="24">
				<button type="submit" class="btn btn-primary btn-sm">업로드</button>
			</div>
		</div>
		
		
		<%-- postList box --%>
		<div class="m-3">
			<%-- 내부의 header 부분 --%>
			<div class="d-flex justify-content-between px-2 back-color">
				<%-- post 글쓴이 --%>
				<div>
					<span class="font-weight-bold">marobiana</span>
				</div>
				<%-- 삭제 더보기 --%>
				<div>
					<img src="/static/img/more.png" width="25" alt="더보기 아이콘">
				</div>
			</div>
			
			<%-- 이미지  --%>
			<div class="d-flex justify-content-center my-2">
				<img class="post-img" src="/static/img/post1.webp" alt="게시글 이미지">
			</div>
			<%-- 좋아요 --%>
			<div class="my-2">
				<img src="/static/img/empty-heart.png" alt="좋아요" width="18">
				<span class="font-weight-bold">좋아요 n개</span>
			</div>
			
			<%-- 댓글 header 부분 --%>
			<div class="back-color my-2">
				<small class="font-weight-bold mx-2">댓글</small>
			</div>
			
			<%-- 댓글 내용 부분 --%>
			<div>
				<table>
					<tr>
						<th>댓글1</th>
						<td>ㅁ므므므믐므ㅡ</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>