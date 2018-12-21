<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
<title>Document</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <%--광고판--%>
  	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    
    <%-- 기능 --%>
	<script>
		$(document).ready(function(){
			//검색하기
			$("#sBtn").click(function(){
				//무결성검사하기
				if($('#word').val()==""){
					alert('검색어를 입력하세요');
					$('#word').focus();
					return; 
				}
				$("#sForm").submit();
			});
			
			//업데이트
			$("#uBtn").click(function(){
				alert('최신목록으로 업데이트하시겠습니까?');
			});
		});
	</script>
	
	<%-- 스타일 --%>
	<style>
		
		input {
			vertical-align: middle;
		}
		
		input.form-text{
			border: 6px solid #d82e84;
			border-radius: 40px 40px;
			width: 300px;
			height: 28px;
		}
	
		input.img-button{
			background:url("../resources/images/searchicon.png") no-repeat;
			border: none;
			width: 50px;
			height: 50px;
			cursor: pointer;
		}
			
		.carousel-inner img {
	      width: 100%;
	      height: 100%;
	  	}
	  		  
	  	#word {border: 6px solid #d82e84; border-radius: 40px 40px; width: 400px; height: 41px;}
		#target {border: 6px solid #d82e84; border-radius: 40px 40px; width: 80px; height: 41px; background-color: #ffffff;}
		#tb_1 {float: left; width: 500px; height: 600px;}
		#img_1 {width: 100%; height: 100%; align: center;}
		#tb_2 {float: left; width: 30px;}
		#img_2 {width: 275px; height: 300px; align: center;}
		#tb_3 {float: left; width: 30px;}
		#img_3 {width: 274px; height: 300px; align: center;}
		#tb_4 {float: left; width: 30px;}
		#img_4 {width: 274px; height: 300px; align: center;}
		#tab_ranking {
			background-image: url(../resources/images/coming2.png);
			border-collapse:separate;
    		border-radius:6px;
    		-moz-border-radius:6px;
		}
		#ranking_text{
			text-align: right; 
		}
		#list{
			text-align: center;
			padding-top: 50px;
			margin-top: 50px;
		}
	</style>
</head>

<%-- 보여지는 페이지 --%>
<body>
	
	<%-- 검색기능 --%>
	  <form id="sForm" method="post" action="../concert/concertSearch.sm">
	    <table id="searchtb" border="0" width="600" align="center">
	  	<tr align="center">
	  		<td width="100">
	  			<!-- 검색대상 -->
	  			<select name="target" id="target">
	  				<option value="both">전체</option>
	  				<option value="title">제목</option>
	  				<option value="artist">가수</option>
	  			</select>
	  		</td>
	  		<td width="100">
	  			<!-- 검색단어 -->
	  			<input type="text" name="word" id="word" class="form-text" />
	  		</td>
	  		<td width="80">	
	  			<!-- 검색버튼 -->
	  			<input type="button" id="sBtn" class="img-button" />
	  		</td>
	  	</tr>
	  </table>
	 </form> 
	 
	 <%--광고판--%>
	<div id="demo" class="carousel slide" data-ride="carousel">
	
	  <!-- Indicators -->
	  <ul class="carousel-indicators">
	    <li data-target="#demo" data-slide-to="0" class="active"></li>
	    <li data-target="#demo" data-slide-to="1"></li>
	    <li data-target="#demo" data-slide-to="2"></li>
	  </ul>
	  
	  <!-- The slideshow -->
	  <div class="carousel-inner">
	    <div class="carousel-item active">
	      <img src="../resources/images/ONEOKROCKHeader.jpg" alt="ONE" style="width: 100%;">
	    </div>
	    <div class="carousel-item">
	      <img src="../resources/images/ONEOKROCKHeader.jpg" alt="RBB" style="width: 100%;">
	    </div>
	    <div class="carousel-item">
	      <img src="../resources/images/ONEOKROCKHeader.jpg" alt="New York" style="width: 100%;">
	    </div>
	  </div>
	  
	  <!-- Left and right controls -->
	  <a class="carousel-control-prev" href="#demo" data-slide="prev">
	    <span class="carousel-control-prev-icon"></span>
	  </a>
	  <a class="carousel-control-next" href="#demo" data-slide="next">
	    <span class="carousel-control-next-icon"></span>
	  </a>
	</div>
	 
	<!-- 개막예정 콘서트 목록보기 -->
	<c:forEach var="data2" items="${LIST2}">
		<table id="tb_${data2.rno}" border="0" width="700" align="center">	
				<tr>
					<td>
						<a href="../concert/concertView.sm?oriNo=${data2.cno}&nowPage=${PINFO.nowPage}&artist=${data2.artist}">
							<img id="img_${data2.rno}" src="${data2.img}"/>
						</a>
					</td>
				</tr>
		</table>
	</c:forEach>
	
	<table id="tab_ranking" border="0" width="830" height="297" align="left">
		<c:forEach var="data2" items="${LIST2}">
			<tr>
				<td id="ranking_text">
					<a href="../concert/concertView.sm?oriNo=${data2.cno}&nowPage=${PINFO.nowPage}&artist=${data2.artist}">
					<img src="../resources/images/star2.png" style="width : 20px;"> ${data2.title} | ${data2.day} &nbsp; &nbsp; &nbsp;</a>
				</td>
			</tr>
		</c:forEach>
	</table>		
  	
	<!-- 콘서트 목록보기 -->
	<!-- 모델 req.setAttribute("LIST",list); 사용 -->
	<table id="list" border="0" width="1000" align="center" cellpadding="5px">
		<thead>
			<tr>
				<td><br/></td>
			</tr>
			<tr style="border-bottom:1px dashed  #cccccc;">
				<th>&nbsp;&nbsp;&nbsp;</th>
				<th>&nbsp;&nbsp;&nbsp;</th>
				<th><img src="../resources/images/weekly.png" alt="weekly" style="width: 200px; align: center;"></th>
				<th>&nbsp;&nbsp;&nbsp;</th>
				<th>&nbsp;&nbsp;&nbsp;</th>
				<th>&nbsp;&nbsp;&nbsp;</th>
				<th>&nbsp;&nbsp;&nbsp;</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="data" items="${LIST}">
				<tr style="border-bottom:1px dashed  #cccccc;">
					<td>${data.rno}</td>
					<td>
						<a href="../concert/concertView.sm?oriNo=${data.cno}&nowPage=${PINFO.nowPage}&artist=${data.artist}">
						<img src="${data.img}" width="100px" height="140px"/>
						</a>
					</td>
					<td><a href="../concert/concertView.sm?oriNo=${data.cno}&nowPage=${PINFO.nowPage}&artist=${data.artist}">
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
	  <table border="0" width="700" align="center">
	  	<tr>
	  		<td align="center">
	  		<%-- [<][1][2][3][4][5][>] --%>
	  		<%-- 이전페이지 [<] --%>
	  		<%-- 현재페이지가 1인경우 --%>
	  		<c:if test="${PINFO.nowPage eq 1}">
	  			이전
	  		</c:if>
	  		
	  		<%-- 현재페이지가 1이 아닌 경우 --%>
	  		<c:if test="${PINFO.nowPage ne 1}">
	  			<a href="../concert/concertList.sm?nowPage=${PINFO.nowPage-1}"></a>
	  		</c:if>
	  		
	  		<%-- [1][2][3][4][5] --%>
	  		<c:forEach var="page" begin="${PINFO.startPage}" end="${PINFO.endPage}">
	  			<a href="../concert/concertList.sm?nowPage=${page}">[${page}]</a>
	  		</c:forEach>
	  		[total ${PINFO.nowPage}/${PINFO.totalPage}]
	  		<%-- 다음페이지 [>] --%>
	  		<%-- 현재 보고있는페이지가 마지막페이지까지 갔으면 --%>
	  		<c:if test="${PINFO.nowPage eq PINFO.totalPage}">
	 			[>]
	  		</c:if>
	  		
	  		<c:if test="${PINFO.nowPage ne PINFO.totalPage}">
	 			<a href="../concert/concertList.sm?nowPage=${PINFO.nowPage+1}">다음</a>
	  		</c:if>
	  	
	  		</td>
	  	</tr>
	  </table>
	  
	<!-- 최신 목록으로 업데이트 -->
	<form action="../concert/concertUpdate.sm">
	<table border="0" width="700" align="center">
		<tr>
		<td align="center">
			<input type="submit" id="uBtn" value="concertListUpdate">
		</td>
		</tr>
	</table>	
	</form>
</body>
</html>