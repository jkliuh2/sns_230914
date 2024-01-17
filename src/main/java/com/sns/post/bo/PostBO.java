package com.sns.post.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sns.common.FileManagerService;
import com.sns.post.entity.PostEntity;
import com.sns.post.repository.PostRepository;

@Service
public class PostBO {
	
	@Autowired
	private PostRepository postRepository;
	
	@Autowired
	private FileManagerService fileManagerService;

	// 모든 글 Select(최신순)
	// input:X / output:List<PostEntity>
	public List<PostEntity> getPostListOrderByIdDesc() {
		return postRepository.findAllByOrderByIdDesc();
	}
	
	// insert
	// input:지금은 loginId, content / output:PostEntity(insert한 데이터)
	public PostEntity addPost(int userId, String userLoginId,
			String content, MultipartFile file) {
		
		// DB에 넣을 이미지 경로 지정
		String imagePath = null;
		
		// file이 null이 아닐 경우 => 그림파일 저장하고 경로값으로 변경
		if (file != null) {
			imagePath = fileManagerService.saveFile(userLoginId, file);
		}
		
		// Builder로 insert할 객체 생성
		PostEntity post = PostEntity.builder()
				.userId(userId)
				.content(content)
				.imagePath(imagePath)
				.build();
		
		// insert+리턴
		return postRepository.save(post);
	}
}
