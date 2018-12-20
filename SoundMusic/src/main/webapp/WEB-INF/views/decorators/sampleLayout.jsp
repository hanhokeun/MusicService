<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<title><decorator:title default="JLStory" /></title>
<decorator:head />
</head>
<link href="https://fonts.googleapis.com/css?family=Poor+Story|Sunflower:300" rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<style>
	body{
		font-family: 'Sunflower', sans-serif;
		font-size: 15px;
	}
</style>
<body>
<% String path = "http://localhost:80/music"; %>
	<!-- header -->
	<header>
		<%
	
			String id = null;
			if(session.getAttribute("UID") != null){
			id = (String) session.getAttribute("UID");
			}
	%>
	<!-- Grey with black text -->
	<nav class="navbar navbar-expand-sm bg-light navbar-light">
	  <a class="navbar-brand" href="<%=path%>/main.jsp"><img src="../resources/images/music.png" alt="Logo" style="width:70px;"/></a>
	  <ul class="navbar-nav">
	    <li class="nav-item">
	      <a class="nav-link" href="#">실시간 차트</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link disabled" href="#">공지사항</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="<%=path%>/freeBoard/boardList.sm">자유게시판</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="<%=path%>/concert/concertList.sm">콘서트</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link disabled" href="<%=path%>/static/staticList.sm">통계 게시판</a>
	    </li>
	  </ul>
	<%
	if(id == null){
	%> 
	<div class="collapse navbar-collapse justify-content-end">
	    <form class="nav navbar-nav navbar-right">     
	      <ul class="nav justify-content-end"> 			
			<li><a href="<%=path%>/member/LoginForm.sm" class="btn btn-outline-secondary btn-sm">로그인</a></li>
			<li><a href="<%=path%>/member/SignUp.sm" class="btn btn-outline-secondary btn-sm">회원가입</a></li>		
		</ul>
	    </form>
	  </div>
	<% 
	}else if(id.equals("admin")){
	%>	   
	<div class="collapse navbar-collapse justify-content-end">
	    <form class="nav navbar-nav navbar-right">                  
	      <ul class="nav justify-content-end">
	      	<li><a href="<%=path%>/member/MemberList.sm"  class="btn btn-outline-secondary btn-sm">회원관리</a></li>      	
			<li><a href="<%=path%>/member/LogOut.sm" class="btn btn-outline-secondary btn-sm">로그아웃</a></li>			
		</ul>
	    </form> 
	 </div>   
	<% 
	}else{
	%>	   
	 <div class="collapse navbar-collapse justify-content-end">
	    <form class="nav navbar-nav navbar-right">                  
	      	<ul class="nav justify-content-end">
	      		<li><a href="<%=path%>/member/Profile.sm"  class="btn btn-outline-secondary btn-sm">회원관리</a></li>      	
				<li><a href="<%=path%>/member/LogOut.sm" class="btn btn-outline-secondary btn-sm">로그아웃</a></li>			
			</ul>
	    </form>
	  </div>
	<%
	}
	%>    
	</nav>
	</header>
	
	
	<!-- content -->
	<decorator:body></decorator:body>


	<!-- FOOTER -->
	<footer style="background-color: #4C4C4C; color: #ffffff">
		<div class="container">
				<br>
				<div class="row">
					<div class="col-sm-4" style="text-align: center;"><h6>copyright &copy; 2018</h6><br><h8>구로 IT경영기술 개발원</h8><br>2018.06.29~2019.01.02<br>마지막 프로젝트</div>
					<div class="col-sm-4" style="text-align: center;"><h6>팀소개</h6><br>김대현 한호근 유남기 장수경 이현정</h6><br>302호<br>푸터는 아무도 보지 않는다.<br>푸터보고 오시면 츄파츕스 드릴께요.</div>
					<div class="col-sm-4" style="text-align: center;"><h6>개발목표</h6><br>음악정보지원서비스는 음악사이트별 차트 비교 및 전반적인 음악에 대한 정보를 제공하며 음악 정보데데이터를 통하여 빅데이터 분석 음악에 대한 추세와 사용자간의 관심분야에 대해 인사이트를 추출한다.</div>						
				</div>							
		</div>	
	
	</footer>


</body>
</html>
