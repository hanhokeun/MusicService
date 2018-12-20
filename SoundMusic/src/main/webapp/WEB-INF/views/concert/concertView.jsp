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
   			//목록으로 돌아가기
   			$("#lBtn").click(function(){
   				$(location).attr("href","../concert/concertList.sm?nowPage=${nowPage}")
   			});
   		});
   </script>
   </head>
<body>
	<!-- 상세보기 내용 출력 -->
	<table width="700" border="1" align="center">
  	<tbody>
  		<tr>
  			<th width="100">CNO</th>
  			<td width="600">${VIEW.cno}</td>
  		</tr>
  		<tr>
  			<th>IMG</th>
  			<td>
			<img src="${VIEW.img}" width="50px" height="50px"/>
			</td>
  		</tr>
   		<tr>
  			<th>TITLE</th>
  			<td>${VIEW.title}</td>
  		</tr>
  		<tr>
  			<th>GENRE</th>
  			<td>${VIEW.genre}</td>
  		</tr>
   		<tr>
  			<th>DATE</th>
  			<td>${VIEW.day}</td>
  		</tr>
    	<tr>
  			<th>LOC</th>
  			<td>${VIEW.loc}</td>
  		</tr>
  		<tr>
  			<th>ARTIST</th>
  			<td>${VIEW.artist}</td>
  		</tr>		 		  		 		
  	</tbody> 
  </table>
  
  <%-- 기타기능.. 목록보기 --%>
  <table width="700" border="1" align="center">
  	<tbody>
  		<tr>
  			<td align="center">
  				<input type="button" id="lBtn" value="Back"/>
  			</td>
  		</tr>
  	</tbody>
  </table>	
  
  <!-- 관련콘서트 목록 -->
  <table width="700" border="1" align="center">
  	<tbody>
  		<c:forEach var="rera" items="${RERA}">
  		<tr>
  			<th width="100">CNO</th>
  			<td width="600">${rera.cno}</td>
  		</tr>
  		<tr>
  			<th>IMG</th>
  			<td>
			<img src="${rera.img}" width="50px" height="50px"/>
			</td>
  		</tr>
   		<tr>
  			<th>TITLE</th>
  			<td>${rera.title}</td>
  		</tr>
  		<tr>
  			<th>GENRE</th>
  			<td>${rera.genre}</td>
  		</tr>
   		<tr>
  			<th>DATE</th>
  			<td>${rera.day}</td>
  		</tr>
    	<tr>
  			<th>LOC</th>
  			<td>${rera.loc}</td>
  		</tr>
  		<tr>
  			<th>ARTIST</th>
  			<td>${rera.artist}</td>
  		</tr>
  		</c:forEach>		 		  		 		
  	</tbody> 
  </table>
</body>
</html>