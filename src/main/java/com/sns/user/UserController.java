package com.sns.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sns.user.Entity.UserEntity;
import com.sns.user.bo.UserBO;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/user")
@Controller
public class UserController {
// view용 컨트롤러
	
	@Autowired
	private UserBO userBO;
	

	/**
	 * 회원가입 화면 view
	 * url: http://localhost:8080/user/sign-up-view
	 * @param model
	 * @return
	 */
	@GetMapping("/sign-up-view")
	public String signUpView(Model model) {
		model.addAttribute("viewName", "user/signUp");
		return "template/layout";
	}
	
	
	/**
	 * 로그인 화면 view
	 * http://localhost:8080/user/sign-in-view
	 * @param model
	 * @return
	 */
	@GetMapping("/sign-in-view")
	public String signInView(Model model) {
		model.addAttribute("viewName", "user/signIn");
		return "template/layout";
	}
	
	/**
	 * 로그아웃 view
	 * @param session
	 * @return
	 */
	@RequestMapping("/sign-out")
	public String signOut(HttpSession session) {
		// 세션 정보 제거
		session.removeAttribute("userId");
		session.removeAttribute("userLoginId");
		session.removeAttribute("userName");
		
		// 로그인 화면으로 리다이렉트
		return "redirect:/user/sign-in-view";
	}
	
	
	// 유저 정보 update view (오직 프로필화면의 정보수정 버튼을 눌러야 접근 가능)
	@PostMapping("/update-view")
	public String updateView(
			@RequestParam("userId") int userId,
			HttpSession session,
			Model model) {
		
		// 프로필의 userId와 세션의 user.id가 일치하는지 확인.
		Integer sessionId = (Integer)session.getAttribute("userId"); // null 가능
		
		if (sessionId == null) {
			// 세션이 만료되었을 경우
			return "redirect:/user/sign-in-view";
			
		} else if (userId == sessionId) {
			// 본인이 맞을 경우
			
			// DB select
			UserEntity user = userBO.getUserEntityByUserId(userId);
			
			model.addAttribute("viewName", "user/update");
			model.addAttribute("user", user);
			
		} else {
			// 세션id가 일치하지 않을 경우.
			return "redirect:/profile/user-profile-view?userId=" + userId;
		}
		
		return "template/layout";
	}
	
	
	/* 일단 통째로 임시보관
	 * 
	// 본인확인 view
	@PostMapping("/identification-view")
	public String identificationView(Model model) {
		model.addAttribute("viewName", "user/identification");
		return "template/layout";
	}
	*/
}
