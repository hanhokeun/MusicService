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
			$("#sBtn").click(function(){
				//무결성검사하고..
				if(word==''){
					alert('검색어를 입력하세요.')
				}
				//넘기기
				//"#sForm"
				$("#sForm").submit();
			})
			
			
			 //글쓰기 버튼
			$("#wBtn").click(function(){
				//글쓰기(폼보여줘)요청
				$(location).attr("href","../notice/noticeWrite.sm");
				
				//(글쓰기, 수정하기,삭제하기등등..)
				//로그인한 user만 글쓰기를 할 수 있도록 하겠다.
				//인터셉터를 이용하여 자동으로 로그인 기능으로 유도하고자 한다.
				
				
			}) 
			$("#hBtn").click(function(){
				$(location).attr("href","../index.sm");
			})
		})
	</script>
	</head>
<body>
  <h1> 여기에 내가 boardList를 뿌릴 것이다. 언젠가는</h1>
  <%-- 검색기능 --%>
  <form id="sForm" method="post" action="">
  	<table border="1"width="700"align="center">
  		<tr>
  			<td align="center">
  			<%-- 검색 대상 --%>
  			<select name="target" id="target">
  				<option value="title">제목</option>
  				<option value="body">내용</option>
  				<option value="writer">작성자</option>
  				<option value="both">제목+내용</option>
  			</select>
  			<!-- 검색 단어 -->
  			<input type="text" name="word" id="word"/>
  			<!-- 검색 버튼 -->
  			<input type="button" id="sBtn" value="search"/>
  			</td>
  		</tr>
  	</table>
  </form>
  <%-- 게시판 목록보기 --%>
  <table border="1"width="700"align="center">
  	<thead>
  		<tr>
  			<th>번호</th>
  			<th>제목</th>
  			<th>작성자</th>
  			<th>작성일</th>
  			<th>조회수</th>
  			<th>첨부파일</th>
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
  			<td>{}</td>
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

  
</body>
</html>
