package com.sound.music.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

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
	
	//음악 리스트를 띄워줄 컨트롤러
	@RequestMapping("/musiclist")
	public ModelAndView MusicList(@RequestParam(value="nowPage",defaultValue="1") int nowPage,
						@RequestParam(value="genre",defaultValue="") String genre, HttpServletRequest req,
						MusicInfoVO mvo, 
						ModelAndView mv1) throws Exception {
		String sub = req.getParameter("sub");
		String sValue = req.getParameter("svalue");
		if(sub == null) sub = "0";
		if(sValue == null) sValue = "";
		
		int nSub = Integer.parseInt(sub);
		
		mvo.setGenre(genre);
		mvo.setSub(nSub);
		mvo.setSvalue(sValue);
		//페이징 기능
		PageUtil pInfo= musicInfoService.getPageInfo(nowPage,mvo);
//		System.out.println(pInfo.getTotalCount());
//		System.out.println(pInfo.getStartPage());
//		System.out.println(pInfo.getEndPage());
//		System.out.println(pInfo.getTotalPage());
		//뿌리기
		List<MusicInfoVO> vo1 = (List<MusicInfoVO>)musicInfoService.mList(pInfo,mvo);
		
//		for(MusicInfoVO v : vo1) {
//			System.out.println("내용확인 album = "+v.getAlbum());
//		}
		mv1.addObject("GENRE",genre);
		mv1.addObject("PINFO",pInfo);
		mv1.addObject("LIST",vo1);
		mv1.setViewName("musiclist/musiclist");
		return mv1;
	}
	
	//음악의 상세 정보를 표기하기위한 컨트롤러
	@RequestMapping("/musicinfo")
	public ModelAndView musicInfo(@RequestParam(value="no",defaultValue="1") int no,
			@RequestParam(value="nowPage",defaultValue="1") int nowPage ,
			@RequestParam(value="genre") String genre,
			MusicInfoVO vo2, ModelAndView mv2) throws Exception {
		//할일
		//1.파라미터
		//2.서비스위임(비즈니스로직)
		vo2 = musicInfoService.info(no);
		//3.모델
		//4.뷰
		mv2.addObject("GENRE",genre);
		mv2.addObject("NO",no);
		mv2.addObject("NOWPAGE",nowPage);
		mv2.addObject("INFO", vo2);
		mv2.setViewName("/musiclist/musicinfo");
		return mv2;
	}
	
	//음악 추가 폼 보여주기
	@RequestMapping("/musiclistadd")
	public String musicListAdd() {
		return"musiclist/musiclistadd";
	}
	
	//음악 추가
	@RequestMapping("/musiclistaddproc")
	public ModelAndView musicListAddProc(ModelAndView mv, HttpServletRequest req, MusicInfoVO vo ) throws Exception {
		//파라미터
		String title = req.getParameter("aTitle");
		String artist = req.getParameter("aArtist");
		String album = req.getParameter("aAlbum");
		String path = req.getParameter("aImgpath");
		String genre = req.getParameter("aGenre");
		String lyrics = req.getParameter("aLyrics");
		vo.setGenre(genre);
		vo.setTitle(title);
		vo.setArtist(artist);
		vo.setAlbum(album);
		vo.setPath(path);
		vo.setLyrics(lyrics);
		System.out.println(vo.getGenre());
		//서비스
		musicInfoService.create(vo);
		//모델
		//뷰
		RedirectView rv = new RedirectView("../musiclist/musiclist.sm");
		mv.setView(rv);
		return mv;
	}
}	
