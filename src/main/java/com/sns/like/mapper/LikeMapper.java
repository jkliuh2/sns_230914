package com.sns.like.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface LikeMapper {

	// 좋아요 select -> count
	// input: postId, userId / output: int(count)
	public int selectLikeCountByPostIdUserId(
			@Param("postId") int postId, 
			@Param("userId") Integer userId);
	
	// 좋아요 생성
	// input:postId, userId / output: int
	public int insertLikeByPostIdUserId(
			@Param("postId") int postId, 
			@Param("userId") int userId);
	
	// 좋아요 삭제
	// input:postId, userId / output: int
	public int deleteLikeByPostIdUserId(
			@Param("postId") int postId, 
			@Param("userId") int userId);
	
	
	// 좋아요 갯수
	// input:postId / output:int(count)
	public int selectLikeCountByPostId(int postId);
}
