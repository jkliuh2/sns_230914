package com.sns.post.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sns.post.domain.Post;

@Mapper
public interface PostMapper {

	// test select
	// input:X / output:List<Map>
	public List<Map<String, Object>> selectPostList();
	
	public List<Post> selectPostListOrderByDesc();
}
