package com.sns.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sns.common.EncryptUtils;
import com.sns.user.Entity.UserEntity;
import com.sns.user.bo.UserBO;

@RequestMapping("/user")
@RestController
public class UserRestController {
// API용 컨트롤러
	
	@Autowired
	private UserBO userBO;
	
	/**
	 * 중복확인 API
	 * 
	 * @param loginId
	 * @return
	 */
	@RequestMapping("/is-duplicated-id")
	public Map<String, Object> isDuplicatedId(
			@RequestParam("loginId") String loginId) {
		
		// DB select
		UserEntity user = userBO.getUserEntityByLoginId(loginId);
		
		// 응답값
		Map<String, Object> result = new HashMap<>();
		if (user != null) { // user 값 존재 -> 중복
			result.put("code", 200);
			result.put("is_duplicated_id", true);
		} else { // user 값 없음 -> 중복X
			result.put("code", 200);
			result.put("is_duplicated_id", false);
		}
		
		return result;
	}
	
	/**
	 * 회원가입 API
	 * 
	 * @param loginId
	 * @param password
	 * @param name
	 * @param email
	 * @return
	 */
	@PostMapping("/sign-up")
	public Map<String, Object> signUp(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			@RequestParam("name") String name,
			@RequestParam("email") String email) {
		
		// 비밀번호 암호화
		String hashedPassword = EncryptUtils.md5(password); // 비밀번호 암호화
		
		// DB insert -> id(pk) 리턴
		Integer userId = userBO.addUser(loginId, hashedPassword, name, email);
		
		// 응답값
		Map<String, Object> result = new HashMap<>();
		if (userId != null) { // 성공적으로 리턴
			result.put("code", 200);
			result.put("result", "성공");
		} else {
			result.put("code", 500);
			result.put("error_message", "회원가입에 실패했습니다.");
		}
		return result;
	}
	
}
