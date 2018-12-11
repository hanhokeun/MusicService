package com.sound.music.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sound.music.service.MusicInfoService;
import com.sound.music.util.PageUtil;
import com.sound.music.vo.MusicInfoVO;


/* 이 클래스는 음악 리스트에관한 모든것을 관리할 컨트롤러이다
 * 기본,장르별 리스트를 연결해준다
 */
@Controller
@RequestMapping("/musiclist")
public class MusicListController {
	@Autowired
	MusicInfoService musicInfoService;
	
	//음악 전체 리스트를 띄워줄 컨트롤러
	@RequestMapping("/musiclist")
	public ModelAndView MusicList(@RequestParam(value="nowPage",defaultValue="1") int nowPage,
			ModelAndView mv1) throws Exception {
		System.out.println("음악 전체리스트 실행");
		//페이징 기능
		PageUtil pInfo= musicInfoService.getPageInfo(nowPage);
		System.out.println(pInfo.getTotalCount());
		System.out.println(pInfo.getStartPage());
		System.out.println(pInfo.getEndPage());
		System.out.println(pInfo.getTotalPage());
		//뿌리기
		List<MusicInfoVO> vo1 = (List<MusicInfoVO>)musicInfoService.allList();
		mv1.addObject("PINFO",pInfo);
		mv1.addObject("LIST",vo1);
		mv1.setViewName("/musiclist/musiclist");
		return mv1;
	}
	
	//음악의 상세 정보를 표기하기위한 컨트롤러
	@RequestMapping("/musicinfo")
	public ModelAndView musicInfo(@RequestParam(value="no",defaultValue="1") int no,
			@RequestParam(value="nowPage",defaultValue="1") int nowPage ,
			MusicInfoVO vo2, ModelAndView mv2) throws Exception {
		//할일
		//1.파라미터
		//2.서비스위임(비즈니스로직)
		vo2 = musicInfoService.info(no);
		//3.모델
		//4.뷰
		System.out.println("음악 상세정보 표기 컨트롤러");
		mv2.addObject("NO",no);
		mv2.addObject("NOWPAGE",nowPage);
		mv2.addObject("INFO", vo2);
		mv2.setViewName("/musiclist/musicinfo");
		return mv2;
	}
	
}	
