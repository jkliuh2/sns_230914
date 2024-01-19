package com.sns.timeline.card;

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
	
	// 댓글들
	
	// 좋아요 개수
}
