package com.sns.timeline;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sns.timeline.bo.TimelineBO;
import com.sns.timeline.card.CardView;

@RequestMapping("/timeline")
@Controller
public class TimelineController {
// view Controller
	
//	@Autowired
//	private PostBO postBO;
//	
//	@Autowired
//	private CommentBO commentBO;
	
	@Autowired
	private TimelineBO timelineBO;

	
	/**
	 * 타임라인 목록 view
	 * http://localhost:8080/timeline/timeline-view
	 * @param model
	 * @return
	 */
	@GetMapping("/timeline-view")
	public String timelineView(Model model) {
		
		// DB select - 모든 글 select + 모든 comment select
//		List<PostEntity> postList = postBO.getPostListOrderByIdDesc();
//		List<CommentEntity> commentList = commentBO.getCommentList();
		
		// DB select - CardView 이용
		List<CardView> cardViewList = timelineBO.generateCardView();
		
		
		
		// 응답값
//		model.addAttribute("postList", postList);
//		model.addAttribute("commentList", commentList);
		model.addAttribute("cardViewList", cardViewList);
		model.addAttribute("viewName", "timeline/timeline");
		
		// 리턴
		return "template/layout";
	}
}
