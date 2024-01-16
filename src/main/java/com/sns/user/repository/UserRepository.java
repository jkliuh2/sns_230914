package com.sns.user.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sns.user.Entity.UserEntity;

public interface UserRepository extends JpaRepository<UserEntity, Integer> {

	// input:loginId / output:UserEntity(단건)
	public UserEntity findByLoginId(String loginId);
	
	// input:loginId, password / output: UserEntity
	public UserEntity findByLoginIdAndPassword(String loginId, String password);
}
