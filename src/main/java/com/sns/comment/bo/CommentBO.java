package com.sns.comment.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.comment.entity.CommentEntity;
import com.sns.comment.repository.CommentRepository;

@Service
public class CommentBO {
	
	@Autowired
	private CommentRepository commentRepository;

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
	
	// select - 테이블 전체
	// input:X / output:List<CommentEntity>
	public List<CommentEntity> getCommentList() {
		return commentRepository.findAll();
	}
}
