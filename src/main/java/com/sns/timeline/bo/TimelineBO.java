package com.sns.timeline.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.comment.bo.CommentBO;
import com.sns.comment.domain.CommentView;
import com.sns.post.bo.PostBO;
import com.sns.post.entity.PostEntity;
import com.sns.timeline.card.CardView;
import com.sns.user.Entity.UserEntity;
import com.sns.user.bo.UserBO;

@Service
public class TimelineBO {
	
	@Autowired
	private PostBO postBO;
	
	@Autowired
	private UserBO userBO;
	
	@Autowired
	private CommentBO commentBO;

	
	// 타임라인에 뿌릴 Card select하기 (모든 타임라인)
	// input:X / output: List<CardView>
	public List<CardView> generateCardView() {
		List<CardView> cardViewList = new ArrayList<>();
		
		// post 전체 가져온다. List
		List<PostEntity> postList = postBO.getPostEntityListOrderByIdDesc();
		
		// List 반복문 순회
			// post => cardView  -> cardViewList에 넣기
		for (PostEntity post : postList) {
			// CardView 생성 + CardView에 post 넣기
			CardView card = new CardView();
			card.setPost(post); // post-card 1:1 대응
			
			// 유저 정보(글쓴이) 넣기 - post의 userId로 글쓴이 정보를 가져온다.
			UserEntity user = userBO.getUserEntityByUserId(post.getUserId());
			card.setUser(user);
			
			// 댓글 - CommentView라는 묶음데이터로 묶어서 처리.
			List<CommentView> commentList = commentBO.generateCommentViewListByPostId(post.getId());
			card.setCommentList(commentList);
			
			// 좋아요
			
			
			// card를 List에 넣기 ★
			cardViewList.add(card);
		}
		return cardViewList;
	}
	
	
	// 프로필 화면에 뿌릴 타임라인(프로필 화면이 쓴 타임라인만 리턴할 것임)
	// input: userId / output: List<CardView>
	public List<CardView> generateCardViewByUserId(int userId) {
		List<CardView> cardViewList = new ArrayList<>();
		
		// userId에 일치하는 postList와 user(한 개. 글쓴이는 어차피 프로필주인)
		UserEntity user = userBO.getUserEntityByUserId(userId); // 프로필주인의 유저정보(1개)
		List<PostEntity> postList = postBO.getPostEntityListByUserIdOrderById(userId);
		// 프로필 주인이 쓴 postlist
		
		// CardViewList 만들기
		for (PostEntity post : postList) {
			CardView card = new CardView();
			card.setPost(post); // post 넣기
			card.setUser(user); // 글쓴이 user 넣기
			
			// 댓글 
			List<CommentView> commentList = commentBO.generateCommentViewListByPostId(post.getId());
			card.setCommentList(commentList);
			
			// 좋아요
			
			// 최종
			cardViewList.add(card);
		}
		
		return cardViewList;
	}
}
