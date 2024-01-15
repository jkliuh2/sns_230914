package com.sns.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/user")
@RestController
public class UserRestController {
// API용 컨트롤러
	
	// 회원가입
	@PostMapping("/sign-up")
	public Map<String, Object> signUp() {
		
		// DB insert
		
		// 응답값
		Map<String, Object> result = new HashMap<>();
		result.put("code", 200);
		return result;
	}
	
	// 회원가입시 중복확인 API
	@RequestMapping("/is-duplicated-id")
	public Map<String, Object> isDuplicatedId() {
		
		// DB select
		
		// 응답값
		Map<String, Object> result = new HashMap<>();
		result.put("code", 200);
		result.put("is_duplicated_id", false);
		
		return result;
	}
}
