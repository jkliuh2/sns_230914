package com.sns.user.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.user.Entity.UserEntity;
import com.sns.user.repository.UserRepository;

@Service
public class UserBO {
	
	@Autowired
	private UserRepository userRepository;

	// 중복확인
	// input:loginId / output:UserEntity(단건) or null
	public UserEntity getUserEntityByLoginId(String loginId) {
		return userRepository.findByLoginId(loginId);
	}
	
	// 회원가입
	// input: 4개 파라미터 / output: id(pk) or null
	public Integer addUser(String loginId, String password, String name, String email) {
		
		UserEntity userEntity = userRepository.save(
					UserEntity.builder()
					.loginId(loginId)
					.password(password)
					.name(name)
					.email(email)
					.build()
				);
		return userEntity == null ? null : userEntity.getId();
	}
	
	// 로그인
	// input: loginId, password / output: UserEntity
	public UserEntity getUserEntityByLoginIdPassword(String loginId, String password) {
		return userRepository.findByLoginIdAndPassword(loginId, password);
	}
	
	
	// 유저 목록 select
	// input: X / output: List<UserEntity>
	public List<UserEntity> getUserEntityList() {
		return userRepository.findAll();
	}
}
