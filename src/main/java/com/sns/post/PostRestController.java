package com.sns.post;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.sns.post.bo.PostBO;
import com.sns.post.entity.PostEntity;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/post")
@RestController
public class PostRestController {
// API용 Controller
	
	@Autowired
	private PostBO postBO;
	
	
	// 타임라인 작성
	@PostMapping("/create")
	public Map<String, Object> create(
			@RequestParam("content") String content,
			@RequestParam(value = "file", required = false) MultipartFile file,
			HttpSession session) {
		
		// 로그인 정보 가져오기
		int userId = (int)session.getAttribute("userId");
		String userLoginId = (String)session.getAttribute("userLoginId");
		
		Map<String, Object> result = new HashMap<>();
		
		// 로그인 풀려있을 때 처리
		if (userLoginId == null) {
			result.put("code", 500);
			result.put("error_message", "로그인을 해주세요.");
			return result;
		}
		
		// DB insert
		PostEntity post = postBO.addPost(userId, userLoginId, content, file);
		
		// 응답값
		if (post.getId() > 0) {
			result.put("code", 200);
		} else {
			result.put("code", 500);
			result.put("error_message", "DB에 타임라인을 저장하지 못했습니다.");
		}
		
		// 리턴
		return result;
	}
}
