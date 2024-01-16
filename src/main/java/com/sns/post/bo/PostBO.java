package com.sns.post.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sns.post.domain.Post;
import com.sns.post.mapper.PostMapper;

@Service
public class PostBO {
	
	@Autowired
	private PostMapper postMapper;

	// 모든 글 Select(최신순)
	// input:X / output:List<Post>
	public List<Post> getPostListOrderByDesc() {
		return postMapper.selectPostListOrderByDesc();
	}
}
