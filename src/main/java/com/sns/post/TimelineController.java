package com.sns.post;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/timeline")
@Controller
public class TimelineController {
// view Controller
	
	// 타임라인 목록
	// url: http://localhost:8080/timeline/timeline-view
	@GetMapping("timeline-view")
	public String timelineView(Model model, HttpSession session) {
		// 로그인 권한 검사
		Integer userId = (Integer)session.getAttribute("userId");
//		if (userId == null) {
//			// 비-로그인 상태
//			return "redirect:/user/sign-in-view";
//		}
		
		// DB select - 모든 글 select
		
		// 응답값
		model.addAttribute("viewName", "timeline/timeline");
		
		// 리턴
		return "template/layout";
	}
}
