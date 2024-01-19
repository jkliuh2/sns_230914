package com.sns.timeline.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

	
	// 타임라인에 뿌릴 Card select하기
	// input:X / output: List<CardView>
	public List<CardView> generateCardView() {
		List<CardView> cardViewList = new ArrayList<>();
		
		// 글 목록 + user 목록 가져온다. List
		List<PostEntity> postList = postBO.getPostEntityListOrderByIdDesc();
		List<UserEntity> userList = userBO.getUserEntityList();
		
		// List 반복문 순회
			// post => cardView  -> cardViewList에 넣기
		for (PostEntity post : postList) {
			// CardView 생성 + CardView에 post 넣기
			CardView card = new CardView();
			card.setPost(post);
			
			// 유저 목록 순회
			for (UserEntity user : userList) {
				// post.userId == user.id 이면 CardView에 user 정보 넣고 순회 끝
				if (post.getUserId() == user.getId()) {
					card.setUser(user);
					break;
				}
			}
			
			// card를 List에 넣기
			cardViewList.add(card);
		}
		
		return cardViewList;
	}
}
