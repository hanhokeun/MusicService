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
   //검색하기
   	$(document).ready(function(){
   		$("#sBtn").click(function(){
   		//무결성검사하기
			if($('#word').val()==""){
				alert('검색어를 입력하세요');
				$('#word').focus();
				return; 
			}	
		$("#sForm").submit();
   		});
   
   //전체보기
	   $("#lBtn").click(function(){
	   		$(location).attr("href","../concert/concertList.sm?nowPage=${1}");
	   	});
   	});
   </script>
</head>
<body>
  <%-- 검색기능  --%>
  		<form id="sForm" method="post" action="../concert/concertSearch.sm">
	    <table border="1" width="700" align="center">
	  	<tr>
	  		<td align="center">
	  			<!-- 검색대상 -->
	  			<select name="target" id="target">
	  				<option value="both">전체검색</option>
	  				<option value="title">제목</option>
	  				<option value="artist">가수</option>
	  			</select>
	  			<!-- 검색단어 -->
	  			<input type="text" name="word" id="word" />
	  			<!-- 검색버튼 -->
	  				<input type="button" id="sBtn" value="search" />
	  			<!-- 전체보기버튼 -->
	  				<input type="button" id="lBtn" value="list" />
	  		</td>
	  	</tr>
	  </table>
	  </form>
  	<%-- 검색결과 출력   mv.addObject("LIST",list); --%>
    <table border="1" width="700" align="center">
		<thead>
			<tr>
				<th>CNO</th>
				<th>IMG</th>
				<th>TITLE</th>
				<th>GENRE</th>
				<th>DATE</th>
				<th>LOC</th>
				<th>ARTIST</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="data" items="${LIST}">
				<tr>
					<td>${data.rno}</td>
					<td>
						<a href="../concert/concertView.sm?oriNo=${data.cno}&nowPage=${PINFO.nowPage}&artist=${data.artist}">
						<img src="${data.img}" width="50px" height="50px"/>
						</a>
					</td>
					<td>
						<a href="../concert/concertView.sm?oriNo=${data.cno}&nowPage=${PINFO.nowPage}&artist=${data.artist}">
						${data.title}
						</a>
					</td>
					<td>${data.genre}</td>
					<td>${data.day}</td>
					<td>${data.loc}</td>
					<td>${data.artist}</td>
				</tr>
			</c:forEach>
		</tbody>	
	</table>
  	  <%-- 페이지 이동기능 --%>
	  <%-- 모델 req.setAttribute("PINFO", pInfo); 사용 --%>
	  <table border="1" width="700" align="center">
	  	<tr>
	  		<td align="center">
	  		<%-- [<][1][2][3][4][5][>] --%>
	  		<%-- 이전페이지 [<] --%>
	  		<%-- 현재페이지가 1인경우 --%>
	  		<c:if test="${PINFO.nowPage eq 1}">
	  			[<]
	  		</c:if>
	  		
	  		<%-- 현재페이지가 1이 아닌 경우 --%>
	  		<c:if test="${PINFO.nowPage ne 1}">
	  			<a href="../concert/concertList.sm?nowPage=${PINFO.nowPage-1}">[<]</a>
	  		</c:if>
	  		
	  		<%-- [1][2][3][4][5] --%>
	  		<c:forEach var="page" begin="${PINFO.startPage}" end="${PINFO.endPage}">
	  			<a href="../concert/concertList.sm?nowPage=${page}">[${page}]</a>
	  		</c:forEach>
	  		
	  		<%-- 다음페이지 [>] --%>
	  		<%-- 현재 보고있는페이지가 마지막페이지까지 갔으면 --%>
	  		<c:if test="${PINFO.nowPage eq PINFO.totalPage}">
	 			[>]
	  		</c:if>
	  		
	  		<c:if test="${PINFO.nowPage ne PINFO.totalPage}">
	 			<a href="../concert/concertList.sm?nowPage=${PINFO.nowPage+1}">[>]</a>
	  		</c:if>
	  		</td>
	  	</tr>
	  </table>
</body>
</html>