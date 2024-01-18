package com.sns.post;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sns.post.bo.PostBO;
import com.sns.post.entity.PostEntity;

@RequestMapping("/timeline")
@Controller
public class TimelineController {
// view Controller
	
	@Autowired
	private PostBO postBO;

	
	// 타임라인 목록
	// url: http://localhost:8080/timeline/timeline-view
	@GetMapping("/timeline-view")
	public String timelineView(Model model) {
		
		// DB select - 모든 글 select
		List<PostEntity> postList = postBO.getPostListOrderByIdDesc();
		
		// 응답값
		model.addAttribute("viewName", "timeline/timeline");
		model.addAttribute("postList", postList);
		
		// 리턴
		return "template/layout";
	}
}
