package com.sns.comment.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.comment.domain.CommentView;
import com.sns.comment.entity.CommentEntity;
import com.sns.comment.repository.CommentRepository;
import com.sns.user.Entity.UserEntity;
import com.sns.user.bo.UserBO;

@Service
public class CommentBO {
	
	@Autowired
	private CommentRepository commentRepository;
	
	@Autowired
	private UserBO userBO;

	// insert
	// input:postId, userId, content / output:CommentEntity
	public CommentEntity addComment(int postId, int userId, String content) {
		
		// Build
		CommentEntity comment = CommentEntity.builder()
				.postId(postId)
				.userId(userId)
				.content(content)
				.build();
		
		// insert
		return commentRepository.save(comment);
	}
	
	
	// delete
	// input:
	
	
	// select - 테이블 전체
	// input:X / output:List<CommentEntity>
	public List<CommentEntity> getCommentList() {
		return commentRepository.findAll();
	}
	
	
	
	// postId에 해당하는 Comment들을 CommentView로 바꿔서 List로
	public List<CommentView> generateCommentViewListByPostId(int postId) {
		// 결과 리스트 만들기
		List<CommentView> commentList = new ArrayList<>();
		
		// 글에 해당하는 댓글 목록 가져오기
		List<CommentEntity> commentEntityList = commentRepository.findByPostIdOrderById(postId);
		
		// 반복문 순회 -> List<CommentEntity> -> List<CommentView>(유저정보 포함)
		for (CommentEntity comment : commentEntityList) {
			// comment 1개에 대응하는 commentView 생성 + View에 넣기
			CommentView commentView = new CommentView();
			commentView.setComment(comment);
			
			// 댓글 쓴 유저 정보 - comment의 userId로 select해서 View에 넣기
			UserEntity user = userBO.getUserEntityByUserId(comment.getUserId());
			commentView.setUser(user);
			
			// (최종) 세팅이 다 끝난 CommentView를 List에 commentView 넣기
			commentList.add(commentView);
		}
		
		// 결과 리턴
		return commentList;
	}
}
