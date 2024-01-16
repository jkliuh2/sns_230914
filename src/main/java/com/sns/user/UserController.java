package com.sns.user;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/user")
@Controller
public class UserController {
// view용 컨트롤러

	/**
	 * 회원가입 화면
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
	 * 로그인 화면
	 * http://localhost:8080/user/sign-in-view
	 * @param model
	 * @return
	 */
	@GetMapping("/sign-in-view")
	public String signInView(Model model) {
		model.addAttribute("viewName", "user/signIn");
		return "template/layout";
	}
	
	
	@RequestMapping("/sign-out")
	public String signOut(HttpSession session) {
		// 세션 정보 제거
		session.removeAttribute("userId");
		session.removeAttribute("userLoginId");
		session.removeAttribute("userName");
		
		// 로그인 화면으로 리다이렉트
		return "redirect:/user/sign-in-view";
	}
}
