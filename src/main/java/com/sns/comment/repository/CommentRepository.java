package com.sns.comment.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sns.comment.entity.CommentEntity;

public interface CommentRepository extends JpaRepository<CommentEntity, Integer> {

}
