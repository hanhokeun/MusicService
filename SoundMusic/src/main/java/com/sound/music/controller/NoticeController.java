package com.sound.music.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sound.music.service.NoticeService;
import com.sound.music.vo.NoticeVO;

@Controller
@RequestMapping("/notice/*")
public class NoticeController {
	// 스프링은 하나의 컨트롤러에 여러 개의 요청처리함수를 만들 수 있다.
	// 요청처리함수를 알려주기 위해서 @RequestMapping() 처리를 해주어야 한다.
	// 반환값 void, String, ModelAndView 중 택일 => 뷰 호출방식 결정
	@Inject
	NoticeService noticeService;
	
	//01. 게시글 목록 
	@RequestMapping("noticeList.sm")
	public ModelAndView noticeList() throws Exception{
		List<NoticeVO> list = noticeService.listAll();
		ModelAndView mv = new ModelAndView();
		mv.setViewName("notice/noticeList");
		mv.addObject("list",list);
		return mv;		
	}
	//02_01 게시글 작성 화면
	//@RequestMapping("noticeWrite.sm")
	// value ="", method="전송방식"
	@RequestMapping(value="noticeWrite.sm", method=RequestMethod.GET)
	public String noticeWrite() {
		return "notice/noticeWrite";
	}
	//02_02 게시글 작성 처리
	@RequestMapping(value="noticeProc.sm",method=RequestMethod.POST)
	public String noticeProc(@ModelAttribute NoticeVO vo) throws Exception{
		noticeService.create(vo);
		return "redirect:noticeList.sm";
	}
	//03. 게시글 상세내용 조회, 게시글 조회수 증가처리
	//@RequestParam : get/post 방식으로 전달된 변수 1개
	// HttpSession 세션 객체
	@RequestMapping(value="noticeDetail.sm", method=RequestMethod.GET)
	public ModelAndView view(@RequestParam int no,HttpSession session)throws Exception {
		//조회수 증가 처리
		noticeService.increaseViewcnt(no,session);
		//모델 (데이터 + 뷰 를 함꼐 전달하는 객체
		ModelAndView mv = new ModelAndView();
		// 뷰의 이름
		mv.setViewName("notice/noticeDetail");
		// 뷰에 전달할 데이터 
		mv.addObject("dto",noticeService.read(no));
		return mv;		
	}
	//04. 게시글 수정 
	// 폼에서 입력한 내용들은 @ModelAttribute BoardVO vo 로 전달됨
	@RequestMapping(value="noticeUpdate.sm", method=RequestMethod.POST)
	public String noticeUpdate(@ModelAttribute NoticeVO vo) throws Exception{
		noticeService.update(vo);
		return "redirect:noticeList.sm";
	}
	//05. 게시글 삭제 
	@RequestMapping("noticeDelete.sm")
	public String noticeDelete(@RequestParam int no) throws Exception{
		noticeService.delete(no);
		return "redirect:noticeList.sm";
		
	}
}
