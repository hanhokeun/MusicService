package com.sound.music.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.sound.music.service.StaticServiceInter;
import com.sound.music.util.FileUtil;
import com.sound.music.util.PageUtil;
import com.sound.music.util.RVPage;
import com.sound.music.vo.StaticVO;

@Controller
@RequestMapping("static")
public class StaticController {
	@Autowired
	private StaticServiceInter sService; 
	//목록보기
	@RequestMapping("/staticList.sm")
	public ModelAndView staticList(@RequestParam(value="nowPage",
	defaultValue="1")int nowPage,HttpServletRequest req, StaticVO vo,
			ModelAndView mv) throws Exception{
		//모델: 페이지정보 전달, 목록리스트 전달
		//ArrayList list = sService.List(pInfo);
		String strOption = req.getParameter("searchOption");
		String keyword = req.getParameter("keyword");
		if(strOption == null) strOption = "0";
		if(keyword == null) keyword = "";
		int searchOption = Integer.parseInt(strOption);
		vo.setSearchOption(searchOption);
		vo.setKeyword(keyword);
		//검색한 뒤에 검색값이 없으면 모든 목록, 아니면 검색한 목록 보여주기
		PageUtil pInfo = sService.totalCount(nowPage,vo);
		ArrayList list = sService.SearchList(pInfo, vo);
		mv.addObject("KEYWORD", keyword);
		mv.addObject("SEARCHOPTION",searchOption);
		mv.addObject("LIST", list);
		mv.addObject("PINFO",pInfo);
		mv.setViewName("static/staticList");
		return mv;
	}
	//원글 삭제하기
	@RequestMapping("/staticDelete.sm")
	public ModelAndView staticDelete(HttpServletRequest req,ModelAndView mv) throws Exception {
		String nowPage=req.getParameter("nowPage");
		String strNo = req.getParameter("oriNo");
		int oriNo = Integer.parseInt(strNo);
		ArrayList list = sService.selectFileInfo(oriNo);
		for(int i=0; i<list.size();i++) {
			StaticVO vo = new StaticVO();
			vo= (StaticVO) list.get(i);
			System.out.println("vo정보:"+vo.getPath()+vo.getSaveName());
			File file = new File(vo.getPath(),vo.getSaveName());
			file.delete(); //물리적 파일 삭제			
		}
		sService.deleteAllFile(oriNo);//첨부파일 DB정보삭제
		sService.delete(oriNo); //글 정보 삭제
		RedirectView rv = new RedirectView("../static/staticList.sm");
		rv.addStaticAttribute("nowPage", nowPage);
		mv.setView(rv);
		return mv;
	}
	//원글 수정처리하기
	@RequestMapping("/staticModifyProc.sm")
	public ModelAndView staticModifyProc(HttpServletRequest req,
			StaticVO vo,ModelAndView mv) throws Exception {
		String nowPage=req.getParameter("nowPage");
		int oriNo = vo.getOriNo();
		System.out.println("oriNo="+oriNo);
		String path=req.getSession().getServletContext().getRealPath("/upload/");
		ArrayList list=new ArrayList(); //파일 정보를 하나로 묶는 list
		for(int i =0; i<vo.getFiles().length;i++) {
			//파일의 실제이름
			System.out.println("파일의 길이length:"+vo.getFiles().length);
			String oriName=vo.getFiles()[i].getOriginalFilename();
			System.out.println("oriName:"+oriName);
			if(oriName==null||oriName.length()==0) {
				continue; //파일 업로드되지 않은 부분 건너뛰기
			}
			String saveName=FileUtil.renameTo(path,oriName);
			File file = new File(path,saveName);
			try {
				vo.getFiles()[i].transferTo(file);
			}catch(Exception e) {
				System.out.println("강제 복사 에러:"+e);
			}
			//파일 업로드 완료 -> 업로드된 파일의 정보를 Map으로 묶어보내기
			HashMap map = new HashMap();
			map.put("path", path);
			map.put("oriName",oriName);
			map.put("saveName",saveName);
			map.put("len",file.length());
			list.add(map);			
		}
		sService.update(vo, list); //원글 내용 수정
		//서비스위임
		//한개의 파일 정보를 Map으로 묶고 여러 개의 파일 정보들이 담긴 Map을 List로 묶어 전달
		RedirectView rv = new RedirectView("../static/staticDetail.sm");
		rv.addStaticAttribute("nowPage", nowPage);
		rv.addStaticAttribute("oriNo", oriNo);
		mv.setView(rv);
		return mv;
	}
	//파일 정보삭제하기
	@RequestMapping("/staticFileDelete.sm")
	public ModelAndView staticFileDelete(HttpServletRequest req,
			ModelAndView mv,StaticVO vo) throws Exception {
		int oriNo = vo.getOriNo();
		String nowPage=req.getParameter("nowPage");
		int fileNo = vo.getFileNo();
		//int fileNo = Integer.parseInt(strFNo);
		//삭제할 파일 정보 검색
		StaticVO dvo=sService.downNDelFile(fileNo);
		//DB에 있는 삭제할 파일 삭제
		sService.deleteFile(fileNo);
		File file = new File(dvo.getPath(),dvo.getSaveName());
		file.delete(); //물리적 파일 삭제
		RedirectView rv = new RedirectView("../static/staticModifyForm.sm");
		rv.addStaticAttribute("nowPage", nowPage);
		rv.addStaticAttribute("oriNo", oriNo);
		mv.setView(rv);
		return mv;
	}
	//원글 수정하기폼
	@RequestMapping("/staticModifyForm.sm")
	public ModelAndView staticModifyForm(HttpServletRequest req,
			ModelAndView mv) throws Exception {
		String strNo=req.getParameter("oriNo");
		int oriNo = Integer.parseInt(strNo);
		String nowPage = req.getParameter("nowPage");
		StaticVO vo = sService.detail(oriNo);
		ArrayList list=sService.selectFileInfo(oriNo);
		mv.addObject("VIEW",vo); //원글 내용
		mv.addObject("FILE",list); //파일정보
		mv.addObject("nowPage",nowPage); //릴레이용
		mv.setViewName("static/staticModifyForm");
		return mv;
	}
	//파일 다운로드 횟수 증가
	@RequestMapping("/staticDownloadCount.sm")
	public ModelAndView fileDownloadCount(HttpServletRequest req,ModelAndView mv) throws Exception {
		String strNo=req.getParameter("fileNo");
		int fileNo = Integer.parseInt(strNo);
		sService.downloadCount(fileNo);
		RedirectView rv = new RedirectView("../static/staticFileDownload.sm");
		rv.addStaticAttribute("fileNo", fileNo);
		mv.setView(rv);
		return mv;
	}
	//파일 다운로드 처리
	@RequestMapping("/staticFileDownload.sm")
	public ModelAndView fileDownload(@RequestParam(value="fileNo")int fileNo) throws Exception {
		StaticVO vo = sService.downNDelFile(fileNo);
		System.out.println("fileNo"+fileNo);
		System.out.println("vo.getPath():"+vo.getPath());
		System.out.println("vo.getSaveName():"+vo.getSaveName());
		File file = new File(vo.getPath(),vo.getSaveName()); //다운로드 파일 정보
		//사용자 다운로드 뷰 호출
		ModelAndView mv = new ModelAndView("download","downloadFile",file);
		return mv;
	}
	//상세보기
	@RequestMapping("/staticDetail.sm")
	public ModelAndView staticDetail(StaticVO vo,
			@RequestParam(value="nowPage")int nowPage, 
			@RequestParam(value="rvPage", defaultValue="1")int rvPage) throws Exception {
		StaticVO svo = new StaticVO();
		svo= sService.detail(vo.getOriNo()); //글 내용
		ArrayList fileList = sService.selectFileInfo(vo.getOriNo()); //파일 정보
		System.out.println("fileList의 size"+fileList.size());
		RVPage rPage = sService.getRvPageInfo(rvPage,vo.getOriNo());
		ArrayList replyList = sService.selectReply(vo.getOriNo()); //댓글 정보
		//댓글 페이징 처리
		
		ModelAndView mv = new ModelAndView(); 
		mv.addObject("VIEW", svo);
		mv.addObject("nowPage", nowPage);
		mv.addObject("FILE", fileList);
		mv.addObject("RPAGE", rPage);
		mv.addObject("REPLY",replyList);
		mv.setViewName("static/staticDetail");
		return mv;
	}
	//조회수 증가
	@RequestMapping("/staticHit.sm")
	public ModelAndView staticHit(HttpServletRequest req,
			ModelAndView mv, HttpSession session) throws Exception {
		String strNo=req.getParameter("oriNo");
		int oriNo = Integer.parseInt(strNo);
		String nowPage = req.getParameter("nowPage");
		
		//조회수증가처리
			sService.increaseHit(oriNo, session);
		//모델,뷰 상세보기로 Redirect
		RedirectView rv = new RedirectView("../static/staticDetail.sm");
		rv.addStaticAttribute("oriNo", oriNo);
		rv.addStaticAttribute("nowPage", nowPage);
		mv.setView(rv);
		return mv;
	}
	//댓글 등록하기
	@RequestMapping("/staticReplyWrite.sm")
	public ModelAndView staticReplyWrite(HttpServletRequest req, 
			ModelAndView mv,HttpSession session,StaticVO vo) throws Exception {
		int oriNo=vo.getOriNo();
		System.out.println("oriNo"+oriNo);
		String nowPage=req.getParameter("nowPage");
		session = req.getSession();
		//String mId = (String)session.getAttribute("UID");
		String mId="hongid";
		//VO에 id값 담아주기
		vo.setmId(mId);
		//vo.setOriNo(oriNo);
		//비즈니스로직-댓글등록
		sService.insertReply(vo);
		RedirectView rv = new RedirectView("../static/staticDetail.sm");
		rv.addStaticAttribute("nowPage", nowPage);
		rv.addStaticAttribute("oriNo", oriNo);
		mv.setView(rv);
		return mv;
	}
	//댓글 수정하기
	@RequestMapping("/staticReplyModify.sm")
	public ModelAndView staticReplyModify(StaticVO vo, HttpServletRequest req) throws Exception {
		String nowPage=req.getParameter("nowPage");
		int oriNo = vo.getOriNo();
		sService.updateReply(vo);
		ModelAndView mv = new ModelAndView();
		RedirectView rv=new RedirectView("../static/staticDetail.sm");
		rv.addStaticAttribute("nowPage", nowPage);
		rv.addStaticAttribute("oriNo", oriNo);
		mv.setView(rv);
		return mv;
	}
	//댓글 삭제하기
	@RequestMapping("/staticReplyDelete.sm")
	public ModelAndView staticReplyDelete(StaticVO vo,
			HttpServletRequest req, ModelAndView mv) throws Exception {
		String nowPage=req.getParameter("nowPage");
		int oriNo = vo.getOriNo();
		sService.deleteReply(vo);
		RedirectView rv = new RedirectView("../static/staticDetail.sm");
		rv.addStaticAttribute("nowPage", nowPage);
		rv.addStaticAttribute("oriNo", oriNo);
		mv.setView(rv);
		return mv;
	}
	//글쓰기 폼보기
	@RequestMapping("/staticWriteForm.sm")
	public String staticWriteForm() {
		//관리자에게 글쓰기 폼을 보여주기		
		return "/static/staticWriteForm";
	}
	//글등록하기
	@RequestMapping("/staticWriteProc.sm")
	public ModelAndView staticWriteProc(StaticVO vo, HttpSession session,
			HttpServletRequest req) throws Exception {
		//StaticVO클래스 이용해 파일의 정보를 받고
		//업로드된 파일을 원하는 폴더에 실제 업로드를 실행시켜줌
		String path=req.getSession().getServletContext().getRealPath("/upload/");
		System.out.println("path:"+path);
		ArrayList list=new ArrayList(); //파일 정보를 하나로 묶는 list
		for(int i =0; i<vo.getFiles().length;i++) {
			//파일의 실제이름
			System.out.println("l파일의 길이ength:"+vo.getFiles().length);
			System.out.println("글번호"+vo.getNo());
			String oriName=vo.getFiles()[i].getOriginalFilename();
			if(oriName==null||oriName.length()==0) {
				continue; //파일 업로드되지 않은 부분 건너뛰기
			}
			String saveName=FileUtil.renameTo(path,oriName);
			File file = new File(path,saveName);
			try {
				vo.getFiles()[i].transferTo(file);
			}catch(Exception e) {
				System.out.println("강제 복사 에러:"+e);
			}
			//파일 업로드 완료 -> 업로드된 파일의 정보를 Map으로 묶어보내기
			HashMap map = new HashMap();
			map.put("path", path);
			map.put("oriName",oriName);
			map.put("saveName",saveName);
			map.put("len",file.length());
			list.add(map);			
			System.out.println(path);
			System.out.println(oriName);
			System.out.println(saveName);
			System.out.println(file.length());
		}
		//서비스위임
		//한개의 파일 정보를 Map으로 묶고 여러 개의 파일 정보들이 담긴 Map을 List로 묶어 전달
		sService.insertStatic(vo, list);
		//모델,뷰 -> 목록보기를 호출하기 위해서 Redirect
		ModelAndView mv = new ModelAndView();
		RedirectView view = new RedirectView("../static/staticList.sm");
		mv.setView(view);
		return mv;
	}
}
