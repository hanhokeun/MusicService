package com.sound.music.util;

public class PageUtil {

	private		int		nowPage;		//	현재 보고싶은 페이지
	private		int		totalCount;		//	총 데이터 개수
	private		int		listCount;		//	한페이지에 나타날 게시물 개수
	private		int		pageCount;		//	한페이지에 나타날 페이지 이동 개수	
	private		int		totalPage;		//	총 페이지수
	private		int		startPage;		//	화면에 표시할 시작 페이지수
	private		int		endPage;		//	화면에 표시할 마지막 페이지수
	
	
	
	public PageUtil(int np, int tc) {
//		this.nowPage = np;
//		this.totalCount = tc;
//		this.listCount = 10;
//		this.pageCount = 5;
		//	아래쪽에 만든 또다른 생성자를 강제로 호출하면서 필요한 데이터(10, 5)를 강제로
		//	주게 되면 소스가 좀더 간편해 진다.
		this(np, tc, 10, 5);
	}	
	
//		4개의 데이터를 개발자가 모두 지정하도록 해보자.
	public PageUtil(int np, int tc, int lc, int pc) {
		this.nowPage = np;
		this.totalCount = tc;
		this.listCount = lc;
		this.pageCount = pc;
		
		//	new를 시키는 순간 자동 계산되도록 해보자.
		calcTotalPage();
		calcStartPage();
		calcEndPage();
	}
	
	//필요한 계산을 하자
	//총 페이지 수 계산
	protected void calcTotalPage() {
//		구하는 원리
			//		보고싶은 페이지가 어느 그룹에 속하는지는 알아낸다.
			//		예>		한화면당 5개씩 보여준다고 가정하면..
			//				(1, 2, 3, 4, 5)	/ 5) + 1		1그룹
			//					1,2,3,4는 5로 나눈 나머지가 존재하고	이 경우에는 +1을 해주고
			//					5는 5로나눈 나머지가 0이므로...			이 경우에는 +1을 안하면 된다.
			//				6, 7, 8, 9, 10) / 5) + 1		2그룹
			//				11, 12, 13, 14, 15) / 5) + 1	3그룹
			//				...
			totalPage = (totalCount % listCount == 0) ? (totalCount / listCount) : 
																		(totalCount / listCount) + 1;
	}
	
	protected void calcStartPage() {
		//현재 페이지를 가운데 놓고
		//좌우에 이전 혹은 다음 페이지를 위치시키는 방식으로 만든다
		startPage=nowPage-(pageCount/2);
		
		if(startPage<=0) {
			startPage=1;
		}
	}
	
	protected void calcEndPage() {
		endPage = startPage + pageCount - 1;
		if(endPage >=totalPage) {
			endPage = totalPage;
		}
	}

	public int getNowPage() {
		return nowPage;
	}

	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getListCount() {
		return listCount;
	}

	public void setListCount(int listCount) {
		this.listCount = listCount;
	}

	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	
	
	
}
