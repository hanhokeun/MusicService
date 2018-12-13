<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
	<title>Document</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
	$(document).ready(function(){
		//검색하기 무결성
		$('#sBtn').click(function(){
			if($('#target').val()==""){
				alert('분류를 선택해주세요');
				$('#target').focus();
				return; 
			}
			if($('#word').val()==""){
				alert('내용을 입력해주세요');
				$('#word').focus();
				return; 
			}
			$('#sForm').submit();
		});
		//글쓰기 버튼
		$('#wBtn').click(function(){
			//글쓰기(폼보여주기)요청
			$(location).attr("href","../static/staticWriteForm.sm");
		});
	})
</script>
</head>
<body>
  	<h1>파일 게시판 목록보기</h1>
  	<%-- 검색 기능 --%>
  	<form id="sForm"  method="post"  action="">
	  	 <table border="1" width="700" align="center">
	  		<tr>
	  			<td align="center">
					<!-- 검색 대상 -->
					<select name="" id="target">
						<option value="title">제목</option>
						<option value="body">내용</option>
						<option value="both">제목+내용</option>
					</select>
					<!-- 검색 단어 -->
					<input type="text" name="word" id="word"/>
					<!-- 검색 버튼 -->
					<input type="button" id="sBtn" value="검색하기"/>
	  			</td>
	  		</tr>
	  	</table>
  	</form>
  	<%-- 게시판 목록보기 --%>
  	<table border="1" width="700" align="center">
  		<thead>
  			<tr>
  				<th>번호</th>
				<th>제목</th>
				<th>작성일</th>
				<th>조회수</th>
				<th>첨부파일</th>
				<th>첨부파일이미지</th>
  			</tr>
  		</thead>
  		<tbody>
	  		<c:forEach var="data" items="${LIST}">
	  		  	<tr>
	  				<td>${data.no}</td>
	  				<td>
	  					<a href="../static/staticHit.sm?oriNo=${data.no}&nowPage=${PINFO.nowPage}">${data.title}</a>
	  				</td>
					<td>${data.date}</td>
					<td>${data.hit}</td>
					<td>${data.fileCount}</td>
	  			</tr>
	  		</c:forEach>
  		</tbody>
  	</table>
  	<%-- 페이지 이동기능 --%>
  	<table border="1" align="center" width="700">
  		<tr>
  			<td align="center">
	  			<%--이전링크 만들기--%>
	  			<c:if test="${PINFO.startPage eq 1}">[<]</c:if>
	  			<c:if test="${PINFO.startPage ne 1}">
	  				<a href="../static/staticList.sm?nowPage=${PINFO.nowPage-1}">[<]</a></c:if>
	  			<c:forEach var="page" begin="${PINFO.startPage}" end="${PINFO.endPage}">
	  				<a href="../static/staticList.sm?nowPage=${page}">[${page}]</a>
	  			</c:forEach>
	  			<%--다음링크 만들기--%>
	  			<c:if test="${PINFO.endPage eq PINFO.totalPage}">[>]</c:if>
	  			<c:if test="${PINFO.endPage ne PINFO.totalPage}">
	  				<a href="../static/staticList.sm?nowPage=${PINFO.endPage+1}">[>]</a>
	  			</c:if>
	  		</td>
  		</tr>
  	</table>
  	<%-- 글쓰기(기타기능) 관리자만 가능하게 한다--%>
  	<%-- <c:if test="${sessionScope.UID eq 'admin'}">--%>
	  	<form id="wForm"  method="get">
		  	<table border="1" width="700" align="center">
		  		<tr>
		  			<td align="center">
		  				<input type="button" id="wBtn" value="글쓰기"/>
		  			</td>
		  		</tr>
		  	</table>
		 </form>
	<%--</c:if>--%>
</body>
</html>