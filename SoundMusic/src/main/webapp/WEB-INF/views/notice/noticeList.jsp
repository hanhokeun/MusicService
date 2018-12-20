<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
<title>Document</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	</head>
<body>
<h1>게시글 목록</h1>
<script>
		$(function(){
			 //글쓰기 버튼
			$("#wBtn").click(function(){
				//글쓰기(폼보여줘)요청
				$(location).attr("href","../notice/noticeWrite.sm");
				
				//(글쓰기, 수정하기,삭제하기등등..)
				//로그인한 user만 글쓰기를 할 수 있도록 하겠다.
				//인터셉터를 이용하여 자동으로 로그인 기능으로 유도하고자 한다.
				
				
			}) 
			$("#hBtn").click(function(){
				$(location).attr("href","#");
			})
		})
	</script>
	</head>
<body>
  
   <%-- 게시판 목록보기 --%>
  <table border="1"width="700"align="center">
  	<thead>
  		<tr>
  			<th>번호</th>
  			<th>제목</th>
  			<th>작성자</th>
  			<th>작성일</th>
  			<th>조회수</th>
  			
  		</tr>
  	</thead>
  	<tbody>
  		<c:forEach var="temp" items="${list}">
  		<tr>
  			<td>${temp.no}</td>
  			<td>${temp.title}</td>
  			<td>${temp.writer}</td>
  			<td>${temp.regdate}</td>
  			<td>${temp.viewcnt}</td>
  			
  		</tr>
  	</c:forEach>
  	</tbody>
  </table>
  <%-- 페이지 이동기능 --%>
  <%-- 글쓰기 (기타기능)--%>
  <form id="wForm" method="get" action="">
		<table border="1" width="700" align="center">
			<tr>
				<td align="center">
					<input type="button" id="wBtn" value="글쓰기" />
					<input type="button" name="hBtn" id="hBtn" value="홈으로"/>
				</td>
			</tr>
		</table>
	</form>
	 <%-- 페이지 이동기능 
  req.setAttribute("PINFO", pInfo);		--%>
  <table border="1"width="700"align="center">
  	<tr>
  		<td align="center">
  			<!-- [<][1][2][3][4][5][>] -->
  			<%--이전페이지 [<] --%>
  			<c:if test="${PINFO.nowPage eq 1}">
  			 	[<]
  			 </c:if>
  			 <c:if test="${PINFO.nowPage ne 1}">
  			 <a href="../notice/noticeList.sm?nowPage=${PINFO.nowPage-1}">[<]</a>
  			 </c:if>
  				
  			<%-- [1][2][3][4][5] --%>
  			<c:forEach var="page" begin="${PINFO.startPage}"
  			 end="${PINFO.endPage}" 
  			 >
  				<a href="../notice/noticeList.sm?nowPage=${page}">[${page}]</a>
  			</c:forEach>
  			<%--다음 페이지 현재 보고 있는 페이지가 마지막페이지까지 갔으면 --%>
  			 <c:if test="${PINFO.nowPage eq PINFO.totalPage}">
  			 	[>]
  			 </c:if>
  			 <c:if test="${PINFO.nowPage ne PINFO.totalPage}">
  			 <a href="../notice/noticeList.sm?nowPage=${PINFO.nowPage+1}">[>]</a>
  			 </c:if>
  			
  		</td>
  	</tr>
  </table>

  
</body>
</html>
