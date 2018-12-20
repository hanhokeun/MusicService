package com.sound.music.controller;

import java.awt.Dimension;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.sound.music.service.MusicInfoService;
import com.sound.music.util.PageUtil;
import com.sound.music.util.RVPage;
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
						MusicInfoVO mvo, ModelAndView mv1, HttpSession session) throws Exception {
		String id = (String)session.getAttribute("UID");
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
		//뿌리기
		List<MusicInfoVO> vo1 = (List<MusicInfoVO>)musicInfoService.mList(pInfo,mvo);
		mv1.addObject("SUB", sub);
		mv1.addObject("SVALUE",sValue);
		mv1.addObject("ID", id);
		mv1.addObject("GENRE",genre);
		mv1.addObject("PINFO",pInfo);
		mv1.addObject("LIST",vo1);
		mv1.setViewName("musiclist/musiclist");
		return mv1;
	}
	
	//음악의 상세 정보를 표기하기위한 컨트롤러
	@RequestMapping("/musicinfo")
	public ModelAndView musicInfo(HttpServletRequest req, HttpSession session,
			@RequestParam(value="nowPage",defaultValue="1") int nowPage ,
			@RequestParam(value="genre") String genre,
			MusicInfoVO vo2, ModelAndView mv2,@RequestParam(value="rvPage",defaultValue="1") int rvPage)
			throws Exception {
		//할일
		//1.파라미터
		String id = (String)session.getAttribute("UID");
		String strNo = req.getParameter("no");
		int no = Integer.parseInt(strNo);
		String sub = req.getParameter("isub");
		String sValue = req.getParameter("isvalue");
		//2.서비스위임(비즈니스로직)
		vo2 = musicInfoService.info(no);
		//페이징 기능
		RVPage rPage= musicInfoService.getRvPageInfo(rvPage,no);
		List<MusicInfoVO> vo3 = (List<MusicInfoVO>)musicInfoService.rvList(rPage,no);
		//3.모델
		//4.뷰
		mv2.addObject("SUB", sub);
		mv2.addObject("SVALUE", sValue);
		mv2.addObject("ID", id);
		mv2.addObject("GENRE",genre);
		mv2.addObject("NOWPAGE",nowPage);
		mv2.addObject("INFO", vo2);
		mv2.addObject("REVIEW",vo3);
		mv2.addObject("RPAGE", rPage);
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
	public ModelAndView musicListAddProc(ModelAndView mv, HttpServletRequest req, MusicInfoVO vo) throws Exception {
		//파라미터
		String title = req.getParameter("aTitle");
		String artist = req.getParameter("aArtist");
		String album = req.getParameter("aAlbum");
		String path = req.getParameter("aImgpath");
		String lyrics = req.getParameter("aLyrics");
		String genre = req.getParameter("aGenre");
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
	
	//음악 수정 폼
	@RequestMapping("/musiclistmodify")
	public String musicListModify(HttpServletRequest req, MusicInfoVO vo) {
		String nowPage = req.getParameter("nowPage");
		String strNo = req.getParameter("mNo");
		int mNo = Integer.parseInt(strNo);
		String title = req.getParameter("title");
		String artist = req.getParameter("artist");
		String album = req.getParameter("album");
		String path = req.getParameter("path");
		String lyrics = req.getParameter("lyrics");
		vo.setNo(mNo);
		vo.setTitle(title);
		vo.setArtist(artist);
		vo.setAlbum(album);
		vo.setPath(path);
		vo.setLyrics(lyrics);
		vo.setNowPage(nowPage);
		req.setAttribute("LIST", vo);
		return "/musiclist/musiclistmodify";
	}
	
	//음악 수정
	@RequestMapping("/musiclistmodifyproc")
	public ModelAndView musicListModifyProc(ModelAndView mv, HttpServletRequest req, MusicInfoVO vo)
						throws Exception{
		//파라미터
		String nowPage = req.getParameter("nowPage");
		String strNo = req.getParameter("mNo");
		int no = Integer.parseInt(strNo);
		String title = req.getParameter("mTitle");
		String artist = req.getParameter("mArtist");
		String album = req.getParameter("mAlbum");
		String path = req.getParameter("mImgpath");
		String genre = req.getParameter("mGenre");
		String lyrics = req.getParameter("mLyrics");
		vo.setNo(no);
		vo.setTitle(title);
		vo.setArtist(artist);
		vo.setAlbum(album);
		vo.setPath(path);
		vo.setGenre(genre);
		vo.setLyrics(lyrics);
		
		//서비스
		musicInfoService.update(vo);
		
		//모델
		RedirectView rv = new RedirectView("../musiclist/musicinfo.sm?nowPage="+nowPage+"&no="+no+"&genre="+genre);
		mv.setView(rv);
		return mv;
	}
	
	//음악 삭제
	@RequestMapping("/musiclistdelete")
	public ModelAndView musicListDelete(HttpServletRequest req, ModelAndView mv) throws Exception {
		//파라미터
		String strNo = req.getParameter("dNo");
		int no = Integer.parseInt(strNo);
		//서비스
		musicInfoService.delete(no);
		//뷰
		RedirectView rv = new RedirectView("../musiclist/musiclist.sm");
		mv.setView(rv);
		return mv;
	}
	
	//리뷰 쓰기
	@RequestMapping("/rvWriteProc")
	public ModelAndView reviewWriteProc(ModelAndView mv, HttpServletRequest req, MusicInfoVO vo,
			HttpSession session) throws Exception {
		//파라미터
		String strNo = req.getParameter("mrNo");
		int oriNo = Integer.parseInt(strNo);
		String id = (String)session.getAttribute("UID");
		String body = req.getParameter("rvBody");
		String nowPage = req.getParameter("mrNowPage");
		String genre = req.getParameter("mrGenre");
		vo.setOriNo(oriNo);
		vo.setId(id);
		vo.setBody(body);
		//서비스
		musicInfoService.rvWrite(vo);
		//모델,뷰
		RedirectView rv = 
		new RedirectView("../musiclist/musicinfo.sm?nowPage="+nowPage+"&no="+oriNo+"&genre="+genre);
		mv.setView(rv);
		return mv;
	}
	
	//리뷰 수정
	@RequestMapping("/rvmProc")
	public ModelAndView reviewModifyProc(ModelAndView mv, HttpServletRequest req,
			MusicInfoVO rvo)throws Exception {
		//oriNo 곡번호
		String strNo = req.getParameter("mvNo");
		int oriNo = Integer.parseInt(strNo);
		//nowPage 릴레이용
		String nowPage = req.getParameter("rnowPage");
		//genre 릴레이용
		String genre = req.getParameter("rvGenre");
		//rvPage 릴레이용
		String rvPage = req.getParameter("rvPage");
		//rvno 댓글 번호
		String sNo = req.getParameter("rvNo");
		int rvno = Integer.parseInt(sNo);
		String body = req.getParameter("rvmBody");
		
		rvo.setBody(body);
		rvo.setNo(rvno);
		
		//서비스
		musicInfoService.rvModify(rvo);
		//모델,뷰
		RedirectView rv = new RedirectView("../musiclist/musicinfo.sm?nowPage="+nowPage+"&no="+oriNo+
				"&genre="+genre+"&rvPage="+rvPage);
		mv.setView(rv);
		return mv;
	}
	
	//리뷰 삭제
	@RequestMapping("/rvDelete")
	public ModelAndView reviewDeleteProc(ModelAndView mv, HttpServletRequest req) throws Exception {
		//oriNo 곡번호
		String strNo = req.getParameter("rdNo");
		int oriNo = Integer.parseInt(strNo);
		//nowPage 릴레이용
		String nowPage = req.getParameter("rdNowPage");
		//genre 릴레이용
		String genre = req.getParameter("rdGenre");
		//rvPage 릴레이용
		String rvPage = req.getParameter("rdPage");
		//rvno 댓글 번호
		String sNo = req.getParameter("rvDno");
		int rvno = Integer.parseInt(sNo);
		
		//서비스
		musicInfoService.rvDelete(rvno);
		//모델,뷰
		RedirectView rv = new RedirectView("../musiclist/musicinfo.sm?nowPage="+nowPage+"&no="+oriNo+
				"&genre="+genre+"&rvPage="+rvPage);
		mv.setView(rv);
		return mv;
	}
	//추천수 증가
	@RequestMapping("/updateStar")
	public ModelAndView updateStar(HttpServletRequest req, ModelAndView mv, HttpSession session,
			HttpServletResponse resp) throws Exception {
		//파라미터
		String strNo = req.getParameter("starNo");
		String id = (String)session.getAttribute("UID");
		int no = Integer.parseInt(strNo);
		String nowPage = req.getParameter("sNowPage");
		String genre = req.getParameter("sGenre");
		//서비스
		//넘어온 아이디가 내가 선택하려는 음악번호를 가지고있는 지 알아보자
		MusicInfoVO resVo = musicInfoService.selectStar(id,strNo);
		String res = resVo.getRes();
		//1. 만약 없다면
		//그 유저의 추천곡 리스트를 가져오자
		//추천수 증가와 유저의 추천곡 목록 수정
		
		boolean permit = resVo.isPermit();
		if(permit==true) {
			res = res+strNo+"/";
			musicInfoService.updateStar(no);
			musicInfoService.updateSlist(res,id);
		}
		//2. 만약 있다면..
		else {
			resp.setContentType("text/html; charset=UTF-8");
			resp.setContentType(" pageEncoding='UTF-8'");
			PrintWriter out = resp.getWriter();
			out.println("<script>");
			out.println("alert('You Already Recommended!');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
			
		}
		//모델, 뷰
		RedirectView rv = new RedirectView("../musiclist/musicinfo.sm?nowPage="+nowPage+"&no="+no+"&genre="+genre);
		mv.setView(rv);
		return mv;
	}
	
	//삭제된 음악 리스트
	@RequestMapping("/musicrecycle")
	public ModelAndView recycleMusic(@RequestParam(value="nowPage",defaultValue="1") int nowPage,
			@RequestParam(value="genre",defaultValue="") String genre, HttpServletRequest req, 
			ModelAndView mv1) throws Exception {
			//페이징 기능
			PageUtil pInfo= musicInfoService.getrcPageInfo(nowPage,genre);
			//뿌리기
			List<MusicInfoVO> vo1 = (List<MusicInfoVO>)musicInfoService.rcList(pInfo,genre);
			mv1.addObject("GENRE",genre);
			mv1.addObject("PINFO",pInfo);
			mv1.addObject("LIST",vo1);
			mv1.setViewName("musiclist/musicrecycle");
			return mv1;
	}
	
	//음악 복원
	@RequestMapping("/rcyProc")
	public ModelAndView recycleMusic(ModelAndView mv, HttpServletRequest req) throws Exception {
		//파라미터
		String strNo = req.getParameter("rcNo");
		int no = Integer.parseInt(strNo);
		//서비스
		musicInfoService.recycleMusic(no);
		//모델,뷰
		RedirectView rv = new RedirectView("../musiclist/musiclist.sm");
		mv.setView(rv);	
		return mv;
	}
	
}	
