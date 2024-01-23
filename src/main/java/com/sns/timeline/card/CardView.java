package com.sns.timeline.card;

import java.util.List;

import com.sns.comment.domain.CommentView;
import com.sns.post.entity.PostEntity;
import com.sns.user.Entity.UserEntity;

import lombok.Data;
import lombok.ToString;

@ToString
@Data
public class CardView {
// View용 객체
// 글 하나 = 카드뷰 하나 / 매핑됨
	
	// 글 1개
	private PostEntity post;
	
	// 글쓴이 정보
	private UserEntity user;
	
	// 댓글들 => CommentView(댓글들 + 댓글 쓴 사람의 유저정보)
	private List<CommentView> commentList;
	
	// 좋아요 개수
	private int likeCount;
	
	// 로그인 된 사람이 좋아요를 누른지 여부
	private boolean filledLike; // F:안누름(DB없음) / T:누름(DB존재)
}
