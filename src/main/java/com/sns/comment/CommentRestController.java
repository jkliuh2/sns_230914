package com.sns.comment;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
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
	
	
	// 댓글 삭제 API
	@DeleteMapping("/delete")
	public Map<String, Object> delete(
			@RequestParam("commentId") int commentId,
			HttpSession session) {
		// 리턴 할 result Map
		Map<String, Object> result = new HashMap<>();
		
		// 세션에서 로그인 정보 얻기
		Integer userId = (Integer)session.getAttribute("userId");
		
		if (userId == null) {
			// 세션 만료되었을 때.
			result.put("code", 502);
			result.put("error_message", "세션이 만료되었습니다. 다시 로그인해주세요.");
			return result;
		}
		
		// DB delete (삭제되면 1, 안되면 0)
		int rowCount;
		
		// 응답
		result.put("code", 200);
		result.put("success_message", "댓글을 삭제하였습니다.");
		
		// return
		return result;
	}
}
