package com.sound.music.dao;

	import java.util.ArrayList;

	import org.mybatis.spring.SqlSessionTemplate;
	import org.mybatis.spring.support.SqlSessionDaoSupport;
	import org.springframework.beans.factory.annotation.Autowired;

	import com.sound.music.vo.FileBoardVO;

	

	//파일업로드 게시판 관련질의를 실행할 DAO 클래스이다.
	public class FileBoardDAO extends SqlSessionDaoSupport{
		
		@Autowired
		private SqlSessionTemplate session;
		
		
		public void insertBoard(FileBoardVO vo, String kind) {
			//vo 의 의미
			//질의문을 실행할 때 필요한 데이터를 VO로 알려주기로 했으므로..
			// kind의 의미
			// 어떤 질의 명령을 실행할지를 선택해서 변수등록.
			
			if(kind.equals("board")) {
				session.insert("fileBoard.insertBoard",vo);
				
			}
			else if(kind.equals("fileInfo")){
				session.insert("fileBoard.insertFileInfo",vo);
				
			}
			
			
		}
		//게시물 총 개수 구하기 질의 실행 함수
		public int getTotalCount() {
			
			//질의를 실행할 스테이트 먼트 구하기
			
			//질의 실행
			int result = session.selectOne("fileBoard.totalcount");
			//결과를 서비스에게 반환
			return result;
		}

			//해당 페이지에 보여줄 게시물 정보 구하기 질의 실행함수
			public ArrayList getBoardList(FileBoardVO vo){
				//스테이트먼트구하기->질의 실행
			return (ArrayList)session.selectList("fileBoard.boardList",vo);
			}
	}


