package com.sound.music.controller;

import java.io.File;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sound.music.vo.FileBoardVO;

// 업로드 파일 게시판의 컨트롤러 클래스
@Controller
@RequestMapping("/fileBoard")
public class FileBoardController {

	//글쓰기요청처리
	@RequestMapping("/writeProc")
	public void writeProc(FileBoardVO vo) {		
	/*public void writeProc(@RequestParam(value="files") MultipartFile[] file,
							@RequestParam(value="title") String title,
							@RequestParam(value="body") String body,
							@RequestParam(value="pw") String pw
	 ){*/
		
		//할일
		// 1.파라미터받기		
		/*이 정보를 이용해서 임시 저장된 업로드된 파일을 강제로 원하는 폴더에 실제 
		  업로드(복사)를 실행시켜 주어야 한다. */
		String path = "E:\\upload";		

		// 업로드된 파일의 정보를 이용해서 파일의 이름을 꺼낸다. 하나씩
		/*File file =new File(path,vo.getFiles()[0].getOriginalFilename());*/
		
		for (int i=0; i<vo.getFiles().length;i++) {
			// 하나씩 파일의 실제이름을 알아내자.
			String oriName = vo.getFiles()[i].getOriginalFilename(); // 파일을 만든다.
			File file = new File(path, oriName);
					
			try {
				vo.getFiles()[i].transferTo(file);
			} catch (Exception e) {			
				System.out.println("transferTo강제복사에러"+e);
			}
		} // end for
		
		// transferTo() 를 이용해서복사
		
		
		// 2.service(비즈니스로직)
		// 3. 모델
		// 4. 뷰
		System.out.println("writeproc 컨트롤러");
		
		
	}
	
	
	//글쓰기 폼보여줘 요청
	@RequestMapping("/writeForm")
	public String writeForm() {
		//할일
		//글쓰기 폼을 보여줄 거야
		//인터셉터를 이용하여 로그인처리했기 때문에 딱히 할일이 없다
		System.out.println("writeForm.sun요청컨트롤러~~~");
		return "/fileBoard/writeForm";
	}
	
	
	// 목록보기
	@RequestMapping("/boardList")
	public void fileboardList() {
		//할일
		// 클라이언트가 보고싶은 페이지를 받아서 페이지 이동 기능을 만들고
		// 그 페이지에 뿌려줄 데이터를 검색
		// 1.파라미터받고
		// 2.비즈니스 로직(서비스클래스)
		// 3.모델
		// 4.뷰
	}
	
}
