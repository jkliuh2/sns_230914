package com.sns.like.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.like.mapper.LikeMapper;

@Service
public class LikeBO {
	
	@Autowired
	private LikeMapper likeMapper;
	

	// input:postId, userId / output: X
	public void likeToggle(int postId, int userId) {
		// 생성+삭제 모두 되는 메소드
		
		// DB select => 결과로 이후 진행
		if (likeMapper.selectLikeCountByPostIdOrUserId(postId, userId) > 0) {
			// 기존 like 존재. => like delete
			likeMapper.deleteLikeByPostIdUserId(postId, userId);
		} else {
			// 기존 like 없음. => like create
			likeMapper.insertLikeByPostIdUserId(postId, userId);
		}
	}
	
	
	// post의 좋아요 갯수
	// input:postId, / output: int
	public int likeCount(int postId) {
		
		// DB select
		int likeCount = likeMapper.selectLikeCountByPostIdOrUserId(postId, null);
		
		return likeCount;
	}
	
	
	// 로그인 유저가 좋아요 눌렀는지 여부 리턴
	public boolean filledLike(int postId, Integer userId) {
		// userId가 null일 경우 -> false 리턴해야 한다.
		
		if (likeMapper.selectLikeCountByPostIdOrUserId(postId, userId) > 0) {
			return true;
		} else {
			return false;
		}
	}
}
