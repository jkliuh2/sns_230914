package com.sns.profile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sns.user.Entity.UserEntity;
import com.sns.user.bo.UserBO;

@RequestMapping("/profile")
@Controller
public class ProfileController {
// 유저 프로필 view Controller
	
	@Autowired
	private UserBO userBO;
	
	
	@GetMapping("/user-profile-view")
	public String profileView(
			@RequestParam("userId") int userId,
			Model model) {
		
		// DB select - UserEntity + CardView(userId)
		UserEntity user = userBO.getUserEntityByUserId(userId);
		
		// model에 정보 담기
		model.addAttribute("viewName", "user/profile");
		model.addAttribute("user", user);
		
		return "template/layout";
	}
	
}
