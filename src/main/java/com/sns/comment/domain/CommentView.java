package com.sns.comment.domain;

import com.sns.comment.entity.CommentEntity;
import com.sns.user.Entity.UserEntity;

import lombok.Data;
import lombok.ToString;

@ToString
@Data
public class CommentView {
// 댓글 한개에 대한 묶음 데이터. CommentEntity : CommentView = 1:1

	// 댓글 1개
	private CommentEntity comment;
	
	// 댓글 작성자
	private UserEntity user;
}
