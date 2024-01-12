package com.sns.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sns.post.mapper.PostMapper;

@Controller
public class TestController {
	
	@Autowired
	private PostMapper postMapper;

	// 1. @Controller + @ResponseBody + Return String ⇒ HTML
	@GetMapping("/test1")
	@ResponseBody
	public String test1() {
		return "Hello world!";
	}
	
	// 2. @Controller + @ResponseBody + Return 객체 ⇒ JSON
	@GetMapping("/test2")
	@ResponseBody
	public Map<String, Object> test2() {
		Map<String, Object> map = new HashMap<>();
		map.put("aaa", 111);
		map.put("bbb", 222);
		map.put("ccc", 333);
		return map;
	}
	
	// 3. @Controller + return String ⇒ jsp ⇒ HTML
	@GetMapping("/test3")
	public String test3() {
		return "test/test";
	}
	
	// 4. DB 연동 ->
	@GetMapping("/test4")
	@ResponseBody
	public List<Map<String, Object>> test4() {
		return postMapper.selectPostList();
	}
}