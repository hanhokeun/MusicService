package com.sound.music.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sound.music.service.MusicInfoService;
import com.sound.music.vo.MusicInfoVO;

/* 이 클래스는 음악 리스트에관한 모든것을 관리할 컨트롤러이다
 * 기본,장르별 리스트를 연결해준다
 */
@Controller
@RequestMapping("/musiclist")
public class MusicListController {
	@Autowired
	MusicInfoService musicInfoService;
	
	/*//음악 전체 리스트를 띄워줄 컨트롤러
	@RequestMapping("/musiclist")
	public void MusicList() {
		System.out.println("음악 전체리스트 실행");
	}*/
	
	//음악의 상세 정보를 표기하기위한 컨트롤러
	@RequestMapping("/musicinfo")
	public String musicInfo(MusicInfoVO vo) throws Exception {
		
		//할일
		//1.파라미터
		//2.서비스위임(비즈니스로직)
		musicInfoService.create(vo);
		//3.모델
		//4.뷰
		System.out.println("음악 상세정보 표기 컨트롤러");
		return "/musiclist/musicinfo";
	}
}	
