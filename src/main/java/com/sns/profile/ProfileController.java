package com.sns.profile;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sns.timeline.bo.TimelineBO;
import com.sns.timeline.card.CardView;
import com.sns.user.Entity.UserEntity;
import com.sns.user.bo.UserBO;

@RequestMapping("/profile")
@Controller
public class ProfileController {
// 유저 프로필 view Controller
	
	@Autowired
	private UserBO userBO;
	
	@Autowired
	private TimelineBO timelineBO;
	
	
	@GetMapping("/user-profile-view")
	public String profileView(
			@RequestParam("userId") int userId,
			Model model) {
		
		// DB select - UserEntity + CardView(userId)
		UserEntity user = userBO.getUserEntityByUserId(userId); // 프로필 주인의 user 정보
		List<CardView> cardViewList = timelineBO.generateCardViewByUserId(userId);
		// user가 작성한 타임라인의 List
		
		// model에 정보 담기
		model.addAttribute("viewName", "profile/profile");
		model.addAttribute("user", user);
		model.addAttribute("cardViewList", cardViewList);
		
		return "template/layout";
	}
	
}
