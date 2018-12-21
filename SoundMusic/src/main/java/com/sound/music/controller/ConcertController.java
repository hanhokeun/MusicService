package com.sound.music.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.text.DateFormat;
//import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;

import org.slf4j.LoggerFactory;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

//import com.sound.music.io.IOException.LocalFileExecutionServlet2;
import com.sound.music.service.ConcertService;
import com.sound.music.util.PageUtil;
import com.sound.music.vo.ConcertVO;

// 콘서트 게시판의 컨트롤러 클래스
@Controller
@RequestMapping("/concert")
public class ConcertController {
	
	//서비스 클래스를 자동주입
	@Autowired
	private ConcertService cService;
	
	//목록보기
	@RequestMapping("/concertList")
	public void concertList(@RequestParam(value="nowPage", defaultValue="1") int nowPage,
			HttpServletRequest req) {		
			
			//페이지 이동 기능
			PageUtil pInfo = cService.getPageInfo(nowPage);
			
			//개막예정 콘서트 목록보기
			ArrayList list2 = cService.concertSchedule();
			//게시물 꺼내오기
			ArrayList list = cService.getConcertList(pInfo);
//			System.out.println("콘서트 수= "+list.size());
			
			//모델
			req.setAttribute("PINFO", pInfo);
			req.setAttribute("LIST", list);
			req.setAttribute("LIST2", list2);
	}
	
	//최신 목록으로 업데이트
	/*@RequestMapping("/concertListUpdate")
	public String concertListUpdate(HttpServletRequest req)
			throws Exception{
		System.out.println("concertListUpdate요청 컨트롤러 실행");
		
		String fileName = req.getParameter("fileName");
		LocalFileExecutionServlet2 fOpenTest = new LocalFileExecutionServlet2();
		fOpenTest.service(fileName);
		
		return "/concert/concertList";	
	}*/	
	
	/*@RequestMapping("/concertListUpdate")
	public String concertListUpdate(){
		System.out.println("concertListUpdate요청 컨트롤러 실행");
		return "/localhost:8080/concert_update.py";
	}*/
	
	private static final Logger logger = LoggerFactory.getLogger(ConcertController.class);
	
	@RequestMapping("/concertUpdate")
	public String concertUpdate(Locale locale,Model model){
		
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		try {
			ProcessBuilder pb = new ProcessBuilder("python","E:\\SecondPj\\soundPj\\concert_dataupdate.py");
			Process p;
			p = pb.start();
			BufferedReader bfr = new BufferedReader(new InputStreamReader(p.getInputStream()));
			String line = "";
			//System.out.println("Running Python starts: " + line);
			line = bfr.readLine();
			//System.out.println("First Line: " + line);
			while((line = bfr.readLine()) !=null) {
				System.out.println("Python Output: " + line);
			}
		} catch (Exception e) {
			System.out.println(e.getStackTrace());
		}
		model.addAttribute("serverTime", formattedDate );
		
		return "concert/testOK";
	}
		
	
	//상세보기 요청 처리 함수
	@RequestMapping("/concertView")
	public ModelAndView concertView(@RequestParam(value="oriNo",defaultValue="1") String oriNo,
			@RequestParam(value="nowPage",defaultValue="1") int nowPage,
			@RequestParam(value="artist") String artist) {
		
		//상세보기 내용검색
		ConcertVO vo = cService.getConcertView(oriNo);
		//System.out.println("conertView 에서의 artist : "+artist);
		//관련콘서트 내용검색
		ArrayList list = cService.getrelationConcert(artist);
		
		//모델
		ModelAndView mv = new ModelAndView();
		mv.addObject("VIEW",vo);			//내용
		mv.addObject("nowPage",nowPage);	//릴레이용
		mv.addObject("RERA",list);
		
		//뷰
		mv.setViewName("concert/concertView");
		
		return mv;
	}
	
	//검색하기
	@RequestMapping("/concertSearch")
	public ModelAndView concertSearch(ModelAndView mv, HttpServletRequest req) {
		//파라미터
		String target = req.getParameter("target");
		String word = req.getParameter("word");
		
		String strPage = req.getParameter("nowPage");
		int nowPage = 1;
		if(strPage==null || strPage.length()==0) {
			nowPage = 1;
		}
		else {
			nowPage = Integer.parseInt(strPage);
		}
		
		//검색결과가 많아 질 수 있으므로 페이지이동기능을 위한 데이터.. totalCount
		ConcertVO vo = new ConcertVO();
		vo.setTarget(target);
		vo.setWord(word);
		PageUtil pInfo = cService.getSearchPage(vo, nowPage);
		
		//검색어를 이용하여 실제 데이터를 db에서 검색하고
		ArrayList list = cService.concertSearch(vo,pInfo);
		
		//모델
		mv.addObject("target",target);
		mv.addObject("word",word);
		mv.addObject("PINFO",pInfo);
		mv.addObject("LIST",list);
		
		//뷰
		mv.setViewName("concert/concertSearch");
		return mv;
	}
}