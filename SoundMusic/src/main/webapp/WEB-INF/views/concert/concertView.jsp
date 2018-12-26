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
   				$(location).attr("href","../concert/concertList.sm?nowPage=${nowPage}&artist=${artist}")
   			});
   		});
   </script>
   <style>
   
 	 input.img-button{
			background:url("../resources/images/back.png") no-repeat;
			border: none;
			width: 500px;
			height: 100px;
			cursor: pointer;
		}
	a:link {color:black;}
	a:hover {color:red;}
	a:visited {color:black;}	 
   </style> 
</head>
<body>
	<!-- 상세보기 내용 출력 -->
	<tr>
				<td><br/></td>
	</tr>
	<table width="700" border="0" align="center" cellpadding="10px">
  	<tbody>
  		<tr style="border-bottom:1px dashed  #cccccc; color: #e6005c";">
  			<th width="100">NO</th>
  			<td width="600">${VIEW.cno}</td>
  		</tr>
  		<tr style="border-bottom:1px dashed  #cccccc;">
  			<th>IMG</th>
  			<td>
			<img src="${VIEW.img}" width="300px" height="300px"/>
			</td>
  		</tr>
   		<tr style="border-bottom:1px dashed  #cccccc; color: #e6005c;">
  			<th>TITLE</th>
  			<td>${VIEW.title}</td>
  		</tr>
  		<tr style="border-bottom:1px dashed  #cccccc;">
  			<th>GENRE</th>
  			<td>${VIEW.genre}</td>
  		</tr>
   		<tr style="border-bottom:1px dashed  #cccccc;">
  			<th>DATE</th>
  			<td>${VIEW.day}</td>
  		</tr>
    	<tr>
  			<th>LOC</th>
  			<td>${VIEW.loc}</td>
  		</tr>
  		<tr style="border-bottom:1px dashed  #cccccc;">
  			<th>ARTIST</th>
  			<td>${VIEW.artist}</td>
  		</tr>		 		  		 		
  	</tbody> 
  </table>
  
  <%-- 기타기능.. 목록보기 --%>
  <table width="700" border="0" align="center" cellpadding="10px">
  	<tbody>
  		<tr>
  			<td align="center">
  				<input type="button" id="lBtn" class="img-button" />
  			</td>
  		</tr>
  	</tbody>
  </table>	
  
  <!-- 관련콘서트 목록 -->
  <tr>
				<td><br/></td>
  </tr>
  <table width="700" border="0" align="center" cellpadding="10px">
  	<tbody>
  		<c:forEach var="rera" items="${RERA}">
  		<tr style="border-bottom:1px dashed  #cccccc; color: #e6005c">
  		<td width="600">
  			${rera.cno} &nbsp;
			<img src="${rera.img}" width="100px" height="100px"/>
			<a href="../concert/concertView.sm?oriNo=${data.cno}&nowPage=${PINFO.nowPage}&artist=${data.artist}" style="text-decoration:none;">
			&nbsp; ${rera.title}
			</a>
		</td>
		</tr>
  		</c:forEach>		 			 		
  	</tbody>
  </table>
  <br/>
</body>
</html>