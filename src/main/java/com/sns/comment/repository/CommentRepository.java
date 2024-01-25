package com.sns.comment.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.sns.comment.entity.CommentEntity;

public interface CommentRepository extends JpaRepository<CommentEntity, Integer> {

	public List<CommentEntity> findByPostIdOrderById(int postId);
	
	public CommentEntity findByIdAndUserId(int id, int userId);
	
	@Query(value = "delete from comment where postId =:postId", nativeQuery = true)
	public void deleteCommentByPostId(@Param("postId") int postId);
}
