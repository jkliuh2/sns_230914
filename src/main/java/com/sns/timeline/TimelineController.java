package com.sns.timeline;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sns.timeline.bo.TimelineBO;
import com.sns.timeline.card.CardView;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/timeline")
@Controller
public class TimelineController {
// view Controller
	
	@Autowired
	private TimelineBO timelineBO;

	
	/**
	 * 타임라인 목록 view
	 * http://localhost:8080/timeline/timeline-view
	 * @param model
	 * @return
	 */
	@GetMapping("/timeline-view")
	public String timelineView(Model model,
			HttpSession session) {
		
		// 로그인 userId 가져오기
		Integer userId = (Integer)session.getAttribute("userId");
		
		// DB select - CardView 이용 (BO에서 알아서 Card로 가공해서 List로 가져온다)
		List<CardView> cardViewList = timelineBO.generateCardView(userId);
		
		// 응답값
		model.addAttribute("cardViewList", cardViewList);
		model.addAttribute("viewName", "timeline/timeline");
		
		// 리턴
		return "template/layout";
	}
}
