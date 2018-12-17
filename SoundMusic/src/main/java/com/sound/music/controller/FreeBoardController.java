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

import com.sound.music.service.FreeBoardService;
import com.sound.music.util.FileUtil;
import com.sound.music.util.PageUtil;
import com.sound.music.vo.FreeBoardVO;
import com.sound.music.vo.StaticVO;

@Controller
@RequestMapping("/freeBoard")
public class FreeBoardController {
	
	//서비스 클래스를 자동주입
	@Autowired
	private FreeBoardService frService;
	
	//목록 보기
	@RequestMapping("boardList")
	public void freeBoardList(@RequestParam(value="nowPage",defaultValue="1")int nowPage,
			HttpServletRequest req) throws Exception {
	
		// 페이지 이동 기능
		PageUtil pInfo = frService.getPageInfo(nowPage);
		// 게시물꺼내오기
		ArrayList list = frService.getBoardList(pInfo);
		System.out.println("게시물수 = "+list.size()); 
		//3.모델
		req.setAttribute("PINFO", pInfo);
		req.setAttribute("LIST",list);
	}
	//글쓰기 폼보여줘 요청
	@RequestMapping("/writeForm")
	public String writeForm(HttpSession session) throws Exception{
		//할일
		//글쓰기 폼을 보여줄 거야
		session.setAttribute("UID", "bros");
		session.setAttribute("UNICK", "bros");
		//인터셉터를 이용하여 로그인처리했기 때문에 딱히 할일이 없다
		System.out.println("writeForm.sm요청컨트롤러~~~");
		return "/freeBoard/writeForm";
	}
	//글쓰기
		@RequestMapping("/writeProc")
		public ModelAndView writeProc(FreeBoardVO vo, HttpSession session) throws Exception{
			System.out.println("writeProc.sm요청컨트롤러~~~");
				
			//1.파라미터받기				
			String path = "E:\\upload";			
			// 업로드된 파일의 정보를 이용해서 파일의 이름을 꺼낸다			
			ArrayList list = new ArrayList();//파일 정보를 하나로 묶기 위한 변수			
			for(int i=0; i<vo.getFiles().length ;i++) {
				//하나씩 파일의 실제이름을 알아내자
				String oriName = vo.getFiles()[i].getOriginalFilename();				
				//파일이 업로드되지 않으면 다음 파일작업을 시도한다
				if(oriName==null || oriName.length()==0 ) {
					continue;
				}
				String saveName= FileUtil.renameTo(path, oriName);				
				File file = new File(path, saveName);				
				try {
					vo.getFiles()[i].transferTo(file);
				} catch (Exception e) {
					e.printStackTrace();
					System.out.println("강제 복사 에러 = "+e);
				}			
				HashMap map = new HashMap();
				map.put("path",path);
				map.put("oriName",oriName);
				map.put("saveName",saveName);
				map.put("len",file.length());
				
				list.add(map);
				
			}//for	
			
			//2.service(비즈니스로직)
			frService.insertBoard(vo, session, list);			
			//3.모델
			//4.뷰호출			
			ModelAndView mv = new ModelAndView();
			RedirectView view = new RedirectView("../freeBoard/boardList.sm");
			mv.setView(view);
			return mv;
			
		}

		//증가
		@RequestMapping("/hitProc")
		public ModelAndView boardHitProc(HttpServletRequest req,
				ModelAndView mv,HttpSession session)throws Exception{
			//할일
			//파라미터받고
			String strNo= (String)req.getParameter("oriNo");
			System.out.println(strNo);
			int oriNo = Integer.parseInt(strNo);
			String nowPage = (String)req.getParameter("nowPage");//릴레이용
			
			//로직..서비스위임
			//조회수 증가처리
			//db를 이용하여 조회수 무한 증가되는것을 방지하는 방법을 사용.
			frService.updateHit(oriNo,session);
			//모델
			//뷰
			//컨트롤러에서 강제로 상세보기 Redirect
			RedirectView rv= new RedirectView("../freeBoard/boardView.sm");
			//컨트롤러에서 Redirect하면서 파라미터를 보내고 싶다면
			//rv.addStaticAttribute(String형태 "키값", 데이터);
			rv.addStaticAttribute("oriNo", oriNo);
			rv.addStaticAttribute("nowPage", nowPage);
			mv.setView(rv);
			return mv;
		}
		
		//상세보기 요청 처리 함수
		@RequestMapping("/boardView")
		public ModelAndView boardView(HttpServletRequest req)throws Exception {
			//파라미터 받고
			String strNo = req.getParameter("oriNo");
			int oriNo = Integer.parseInt(strNo);
			String nowPage = req.getParameter("nowPage");
			// 매개변수의 의미
			// oriNo는 해당글번호에 정보,파일정보 검색위한
			// nowPage 릴레이용
			
			//서비스(비지니스로직)
			  //1.상세보기 내용검색
			FreeBoardVO vo=frService.getBoardView(oriNo);
					
			  //2.파일정보 검색	
			ArrayList list = (ArrayList)frService.getFileInfo(oriNo);
			//모델
			ModelAndView mv = new ModelAndView();
			mv.addObject("VIEW", vo);		  	//내용
			mv.addObject("LIST",list);			//첨부파일 정보
			mv.addObject("nowPage", nowPage); 	//릴레이용

			//뷰
			mv.setViewName("freeBoard/boardView");
			
			return mv;
		}
		
		
		//파일다운로드 요청 처리함수
		@RequestMapping("/freeDownload")
		public ModelAndView fileDownload(
				@RequestParam(value="fileNo") int fileNo) throws Exception{
			//파라미터 받고
			//다운로드 해줄 파일의 정보를 DB에서 가져온다
			FreeBoardVO vo = frService.getDownloadFile(fileNo);
			//다운로드할 파일을 File이라는 클래스로 만들어서 제공하기로 했다.
			File file = new File(vo.getPath(),vo.getSaveName());
			
			//사용자 다운로드 뷰
			// ★★★★★사용자 정의 뷰 호출하기
			//형식 = ModelAndView를 이용해달라.
			// new ModelAndView("사용자정의뷰명","전달할 데이터키값",전달할 데이터);
			ModelAndView mv = new ModelAndView("download","downloadFile",file);
			return mv;
			
		}
		//수정하기 
		@RequestMapping("/modifyForm")
		public ModelAndView modifyForm(HttpServletRequest req, ModelAndView mv)throws Exception {
			String strNo = req.getParameter("oriNo");
			int oriNo = Integer.parseInt(strNo);
			String nowPage = req.getParameter("nowPage");
			
			//서비스
			FreeBoardVO vo = frService.getBoardView(oriNo);
			//모델
			mv.addObject("VIEW",vo);
			mv.addObject("nowPage",nowPage);
			//뷰
			
			mv.setViewName("freeBoard/modifyForm");
			return mv;
		}
		//원글 수정처리하기
		@RequestMapping("/modifyProc")
		public ModelAndView staticModifyProc(HttpServletRequest req,
				FreeBoardVO vo,ModelAndView mv) throws Exception {
			String nowPage=req.getParameter("nowPage");
			int oriNo = vo.getOriNo();
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
			//서비스위임
			//한개의 파일 정보를 Map으로 묶고 여러 개의 파일 정보들이 담긴 Map을 List로 묶어 전달
			frService.updateBoard(vo, list);
			RedirectView rv = new RedirectView("../freeBoard/boardView.sm");
			rv.addStaticAttribute("nowPage", nowPage);
			rv.addStaticAttribute("oriNo", oriNo);
			mv.setView(rv);
			return mv;
		}
		//삭제하기 
		//		게시판 내용 삭제
		@RequestMapping("/boardDelete")
		public ModelAndView boardDelete(
				 ModelAndView mv,HttpServletRequest req) {
			System.out.println("게시판 삭제 시작");
			//1. 파라미터
			String nowPage = req.getParameter("nowPage");
			String strNo = req.getParameter("oriNo");
			int oriNo = Integer.parseInt(strNo);
			System.out.println("oriNo = "+oriNo);
			int cnt = frService.deleteBoard(oriNo);
			//뷰
			RedirectView rv = null;
			
			//삭제가 성공하면 목록보기
			//삭제가 실패하면 상세보기
			
			//뷰
			if(cnt==0) {// 상세보기
				rv = new RedirectView("../freeBoard/boardView.sm?oriNo="+oriNo+"&nowPage="+nowPage);
				
			}else {
				rv = new RedirectView("../freeBoard/boardList.sm?nowPage="+nowPage);
			}
			
			mv.setView(rv);
			
			System.out.println("게시판 삭제 마감");

			return mv;
			
		}
			
		}
		
		
	

