package com.sns.post.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sns.comment.bo.CommentBO;
import com.sns.common.FileManagerService;
import com.sns.like.bo.LikeBO;
import com.sns.post.entity.PostEntity;
import com.sns.post.repository.PostRepository;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PostBO {
	
	@Autowired
	private PostRepository postRepository;
	
	@Autowired
	private CommentBO commentBO;
	
	@Autowired
	private LikeBO likeBO;
	
	@Autowired
	private FileManagerService fileManagerService;

	// 모든 글 Select(최신순)
	// input:X / output:List<PostEntity>
	public List<PostEntity> getPostEntityListOrderByIdDesc() {
		return postRepository.findAllByOrderByIdDesc();
	}
	
	// insert
	// input:지금은 loginId, content / output:PostEntity(insert한 데이터)
	public PostEntity addPostEntity(int userId, String userLoginId,
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
	
	
	// userId에 일치하는 post select(DESC)
	// input: userId / output: List<PostEntity>
	public List<PostEntity> getPostEntityListByUserIdOrderById(int userId) {
		return postRepository.findByUserIdOrderByIdDesc(userId);
	}
	
	
	// 글 삭제
	public int deletePostByPostIdUserId(int postId, int userId) {
		// 기존 글 가져오기
		PostEntity post = postRepository.findById(postId).orElse(null);
		if (post == null) {
			log.info("[글 삭제] post is null. postId:{}", postId);
			return 0;
		}
		
		// 글 삭제
		postRepository.delete(post);
		
		// 이미지 있으면 삭제
		if (post.getImagePath() != null) {
			fileManagerService.deleteFile(post.getImagePath());
		}
		
		// 댓글들 삭제
		commentBO.deleteCommentByPostId(postId);
		
		// 좋아요 삭제
		likeBO.deleteLikeByPostId(postId);
		
		// 리턴
		return 1;
	}
}
