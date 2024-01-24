package com.sns.like;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.sns.like.bo.LikeBO;

import jakarta.servlet.http.HttpSession;

@RestController
public class LikeRestController {
// 좋아요 API용 컨트롤러
	
	@Autowired
	private LikeBO likeBO;

	
	// 1. 좋아요 토글(생성/삭제)
	// GET: /like?postId=13  => @RequestParam("postId")  // 기존 쓰던 방식
	// GET: /like/13         => @PathVariable
	@RequestMapping("/like/{postId}")
	public Map<String, Object> likeToggle(
			@PathVariable(name = "postId") Integer postId,
			HttpSession session) {
		
		Map<String, Object> result = new HashMap<>();
		
		// 로그인 여부 확인
		Integer userId = (Integer)session.getAttribute("userId");
		if (userId == null) {
			result.put("code", 300);
			result.put("error_message", "로그인이 만료되었습니다.");
		}
		
		// BO 호출 -> likeToggle(생성/삭제) => if문은 BO에서 할 것!
		likeBO.likeToggle(postId, userId);
		
		// 응답값
		result.put("code", 200);
		
		return result;
	}
}
