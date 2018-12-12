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

import com.sound.music.service.FileBoardService;
import com.sound.music.util.FileUtil;
import com.sound.music.util.PageUtil;
import com.sound.music.vo.FileBoardVO;

//업로드 파일 게시판의 컨트롤러 클래스
@Controller
@RequestMapping("/fileBoard")
public class FileBoardController {
	
	@Autowired
	private FileBoardService fService;

	//목록보기
	@RequestMapping("/boardList")
	public void fileBoardList(@RequestParam(value="nowPage",defaultValue="1") int nowPage
			,HttpServletRequest req) {
		//할일
		//	클라이언트가 보고 싶은 페이지를 받아서  페이지 이동 기능을 만들고
		//	그 페이지에 뿌려줄 데이터를 검색해서
		//	모델로 만들어서 준다
		/*String strPage = req.getParameter("nowPage");
		int nowPage = 0;
		if(strPage==null||strPage.length()==0) {
			nowPage=1;
		}else {
			nowPage = Integer.parseInt(strPage);
		}*/
		
		//1.파라미터 받고
		//2.서비스위임(비즈니스로직)
		//페이지 이동 기능
		PageUtil pInfo= fService.getPageInfo(nowPage);
		
		//게시물 꺼내오기
		ArrayList list = fService.getBoardList(pInfo);
		System.out.println("게시물 수 = " + list.size());
		
		//3.모델
		req.setAttribute("PINFO", pInfo);
		req.setAttribute("LIST", list);
		//4.뷰
	}
	
	//글쓰기 폼보여줘 요청
	@RequestMapping("/writeForm.sm")
	public String wrtieForm() {
		//할일
		//글쓰기 폼을 보여줄 거야
		//인터셉터를 이용하여 로그인처리했기 때문에 딱히 할일이 없다
		System.out.println("writeForm.sm요청컨트롤러~~~");
		return "/fileBoard/writeForm";
	}
	
	//글쓰기
	@RequestMapping("/writeProc.sm")
	public ModelAndView writeProc(FileBoardVO vo, HttpSession session)	{	
//	public void writeProc(@RequestParam(value="files") MultipartFile[] files,
//						  @RequestParam(value="files") String title, ~)	{
		//할일
		//1.파라미터받기
		// FileBoardVO를 이용해서 받았다
		
		/*이 정보를 이용해서 임시 저장된 업로드된 파일을
		강제로 원하는 폴더에 실제 업로드(복사)를 실행시켜 주어야 한다*/
		String path="E:\\upload";

		//업로드된 파일의 정보를 이용해서 파일의 이름을 꺼낸다
		//업로드된 파일의 정보는 배열변수에 기억되므로 배열을 이용해서 받아야 한다
//		File file =new File(path,vo.getFiles()[0].getOriginalFilename());	//1개만
		ArrayList list = new ArrayList();//파일 정보를 하나로 묶기 위한 변수
		
		for(int i=0; i<vo.getFiles().length ;i++) {							//2개 이상
			//하나씩 파일의 실제이름을 알아내자
			String oriName = vo.getFiles()[i].getOriginalFilename();
			
			//파일이 업로드되지 않으면 다음 파일작업을 시도한다
			if(oriName==null || oriName.length()==0) {
				continue;
			}
			
			String saveName = FileUtil.renameTo(path, oriName);
			
			File file = new File(path,saveName);
			
			//transferTo()를 이용해서 복사
			try {
				vo.getFiles()[i].transferTo(file);
			} catch (Exception e) {			
				e.printStackTrace();
				System.out.println("강제 복사 에러= "+e);
			} //try catch
			//이제 하나의 파일이 업로드 된 상태이다.
			//업로드된 파일의 정보를 Map으로 묶자(path,oriName,saveName,len)
			HashMap map = new HashMap();
			map.put("path", path);
			map.put("oriName", oriName);
			map.put("saveName", saveName);
			map.put("len", file.length());
			
			list.add(map);
			
		}//for
		
		
		//2.service(비즈니스로직)
		//문제는 한건의 게시물에달린 업로드 파일의 정보가 최대 5개까지 존재한다.
		//한개의 파일정보를 map으로 묶고 이것을 다시 ArrayList로 묶어 알려주기로 하였다.
		fService.insertBoard(vo,session, list);
			
		
		System.out.println("writeProc.sm요청컨트롤러~~~");
		//3.모델
		//4.뷰호출
		//글쓰기가 완료가 되면 목록보기를 호출하기로 하였다.
		//컨트롤러에서 직접 Redirect 시켜주는 방법이 아래와 같다.
		ModelAndView mv = new ModelAndView();
		RedirectView view = new RedirectView("../fileBoard/boardList.sm");
		mv.setView(view);
		return mv;
	}
	//조회수 증가 요청
	@RequestMapping("/hit.proc")
	public ModelAndView boardHitProc(HttpServletRequest req,ModelAndView mv){
		//할일
		//파라미터 받고
		String strNo = (String) req.getAttribute("oriNo");
		int oriNo = Integer.parseInt(strNo);
		String nowPage= (String) req.getAttribute("nowPage");
		//로직..서비스위임
		//모델
		//뷰를지정
		RedirectView rv = new RedirectView("../fileBoard/boardView.sm");
		//컨트롤러에서 Redirect 하면서 parameter을 담아서 보내고 싶다면 
		//rv.addStaticAttribute("String name"<=key,data=> value)
		rv.addStaticAttribute("oriNo", oriNo);
		rv.addStaticAttribute("nowPage", nowPage);
		mv.setView(rv);
		return mv;
		
		
	}
}