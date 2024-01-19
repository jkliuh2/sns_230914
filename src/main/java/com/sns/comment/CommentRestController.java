package com.sns.comment;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sns.comment.bo.CommentBO;
import com.sns.comment.entity.CommentEntity;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/comment")
@RestController
public class CommentRestController {
// comment용 API 컨트롤러
	
	@Autowired
	private CommentBO commentBO;
	
	/**
	 * 댓글 쓰기 API
	 * 
	 * @param userId
	 * @param postId
	 * @param content
	 * @param session
	 * @return
	 */
	@PostMapping("/create")
	public Map<String, Object> create(
			@RequestParam("userId") int userId,
			@RequestParam("postId") int postId,
			@RequestParam("content") String content,
			HttpSession session
			) {
		
		// 리턴 할 Map
		Map<String, Object> result = new HashMap<>();
		
		// 로그인 정보에서 userId와 대조
		Integer sessionUserId = (Integer)session.getAttribute("userId");
		if (sessionUserId != userId || sessionUserId == null) {
			result.put("code", 500);
			result.put("error_message", "로그인 정보가 정상적이지 않습니다. 다시 로그인 해주세요.");
		}
		
		// DB insert
		CommentEntity comment = commentBO.addComment(postId, userId, content);
		
		
		// 응답값
		if (comment != null) {
			result.put("code", 200);
			result.put("result", "댓글을 작성했습니다");
		} else {
			result.put("code", 500);
			result.put("error_message", "댓글 저장에 실패했습니다.");
		}
		
		return result;
	}
}
