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

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

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
	
	
	/**
	 * 로그인API
	 * 
	 * @param loginId
	 * @param password
	 * @param request
	 * @return
	 */
	@PostMapping("/sign-in")
	public Map<String, Object> signIn(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			HttpServletRequest request
			) {
		
		// 비밀번호 암호화
		String hashingPassword = EncryptUtils.md5(password);
		
		// DB select (null or UserEntity)
		UserEntity user = userBO.getUserEntityByLoginIdPassword(loginId, hashingPassword);
		
		// 응답값 + 로그인 처리
		Map<String, Object> result = new HashMap<>();
		if (user != null) {
			// 로그인 성공
			// 로그인 정보 세션에 담기
			HttpSession session = request.getSession();
			session.setAttribute("userId", user.getId());
			session.setAttribute("userLoginId", user.getLoginId());
			session.setAttribute("userName", user.getName());
			// 응답으로 내려주는 정보 작성
			result.put("code", 200);
			result.put("result", "성공");
		} else {
			// 로그인 실패
			result.put("code", 300);
			result.put("error_message", "존재하지 않는 사용자입니다.");
		}
		
		// 리턴
		return result;
	}
}
