<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
<link href="https://fonts.googleapis.com/css?family=Sunflower:300" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  <script
  src="https://code.jquery.com/jquery-3.3.1.js"
  integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
  crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>  
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="css/codingBooster.css"> 
<style>
	body{font-family: 'Sunflower', sans-serif;}

	  .carousel-inner img {
	      width: 100%;
	      height: 50%;
	  }
	  .collapse navbar-collapse justify-content-end{
	  	display: block;
	  }
	  
</style>
<title>Insert title here</title>
</head>
<body>
<!-- 로그인이 된 사람들의 세션을 만들어 준다. 
회원값이 있는 사람들은 ID에 정보가 담기게 되고
아닌 사람은 null값을 가지게 된다.
-->
<%

		String id = null;
		if(session.getAttribute("UID") != null){
		id = (String) session.getAttribute("UID");
		}
%>
	<!-- nav -->
	<!-- Grey with black text -->
	<nav class="navbar navbar-expand-sm bg-secondary navbar-dark">
	  <a class="navbar-brand" href="main.jsp"><img src="music.png" alt="Logo" style="width:70px;"/></a>
	  <ul class="navbar-nav">
	    <li class="nav-item">
	      <a class="nav-link" href="#">실시간 차트</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link disabled" href="#">공지사항</a>
	    </li>
	   	<li class="nav-item">
	      <a class="nav-link" href="#">음악정보</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="#">콘서트</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="#">음악통계</a>
	    </li>
	   	<li class="nav-item">
	      <a class="nav-link" href="#">자유게시판</a>
	    </li>
	  </ul>
	<%
	if(id == null){
	%> 
	<div class="collapse navbar-collapse justify-content-end">
	    <form class="nav navbar-nav navbar-right">     
	      <ul class="nav justify-content-end"> 			
			<li><a href="member/LoginForm.sm" class="btn btn-outline-dark btn-sm">로그인</a></li>
			<li><a href="member/SignUp.sm" class="btn btn-outline-dark btn-sm">회원가입</a></li>		
		</ul>
	    </form>
	  </div>
	<% 
	}else if(id.equals("admin")){
	%>	   
	<div class="collapse navbar-collapse justify-content-end">
	    <form class="nav navbar-nav navbar-right">                  
	      <ul class="nav justify-content-end">
	      	<li><a href="member/MemberList.sm"  class="btn btn-outline-dark btn-sm">회원관리</a></li>      	
			<li><a href="member/LogOut.sm" class="btn btn-outline-dark btn-sm">로그아웃</a></li>			
		</ul>
	    </form> 
	 </div>   
	<% 
	}else{
	%>	   
	 <div class="collapse navbar-collapse justify-content-end">
	    <form class="nav navbar-nav navbar-right">                  
	      	<ul class="nav justify-content-end">
	      		<li><a href="member/Profile.sm"  class="btn btn-outline-dark btn-sm">회원관리</a></li>      	
				<li><a href="member/LogOut.sm" class="btn btn-outline-dark btn-sm">로그아웃</a></li>			
			</ul>
	    </form>
	  </div>
	<%
	}
	%>    
</nav>

<div id="section1" class="container-fluid bg-light" style="padding-top:70px;padding-bottom:70px">
  <h5 align="center">이시간 인기있는 동영상</h5><br/>
  <div id="demo" class="carousel slide" data-ride="carousel">
	  <ul class="carousel-indicators">
	    <li data-target="#demo" data-slide-to="0"></li>
	    <li data-target="#demo" data-slide-to="1"></li>
	    <li data-target="#demo" data-slide-to="2"></li>
	    <li data-target="#demo" data-slide-to="3"></li>
	  </ul>
	  <div class="carousel-inner">
	    <div class="carousel-item active">
	    	<p align="middle">
	    		<iframe align="center" width="560" height="315" src="https://www.youtube.com/embed/SAdmzjsFVQo?rel=0&autoplay=1&amp;loop=1" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	    		<iframe align="center" width="560" height="315" src="https://www.youtube.com/embed/SAdmzjsFVQo?rel=0&autoplay=1&amp;loop=1" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	      <!--  <img src="yes.jpg" alt="yes" width="">-->
	      	</p>
	    </div>
	    <div class="carousel-item">
	    	<p align="middle">
	    		<iframe width="560" height="315" src="https://www.youtube.com/embed/IWJUPY-2EIM?rel=0&autoplay=1&amp;loop=1" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	    		<iframe width="560" height="315" src="https://www.youtube.com/embed/IWJUPY-2EIM?rel=0&autoplay=1&amp;loop=1" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	    	</p>
	    </div>
	    <div class="carousel-item">
	      <p align="middle">
	      	<iframe width="560" height="315" src="https://www.youtube.com/embed/pSudEWBAYRE?rel=0&autoplay=1&amp;loop=1"  frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	      	<iframe width="560" height="315" src="https://www.youtube.com/embed/pSudEWBAYRE?autoplay=1&loop=1"  frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	      </p>
	    </div>
	    <div class="carousel-item">
	    	<p align="middle">
	      		<iframe width="560" height="315" src="https://www.youtube.com/embed/b73BI9eUkjM?rel=0&autoplay=1&amp;loop=1"  frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	      		<iframe width="560" height="315" src="https://www.youtube.com/embed/b73BI9eUkjM?rel=0&autoplay=1&amp;loop=1"  frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
	    	</p>
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
	</div>
	<div id="section2" class="container-fluid bg-light" style="padding-top:70px;padding-bottom:70px">
	  <h3 align="center">실시간 차트<button type="button" class="btn btn-link" >바로가기</button></h3>
	  	<p align="center">엠넷, 벅스의 실시간 차트를 비교할 수 있는 게시판입니다<br/>지금 바로 확인하세요</p>
	  	<p align="center">
			<img src="musictime.png">
		</p>
	</div>
	<div id="section3" class="container-fluid bg-light" style="padding-top:70px;padding-bottom:70px">
	  <h3 align="center">콘서트<button type="button" class="btn btn-link" >바로가기</button></h3>
	  <p align="middle">일정 시간으로 업데이트되는 공연정보를 볼 수 있는 게시판입니다<br/>지금 바로 확인하세요</p>
	  <p align="middle">
	  		<img src="concert.png">
	  </p>
	</div>
	<div id="section4" class="container-fluid bg-light" style="padding-top:70px;padding-bottom:70px">
	  <h3 align="center">음악정보<button type="button" class="btn btn-link" >바로가기</button></h3>
	  <p align="middle">음악에 대한 정보를 볼 수 있는 게시판입니다<br/>지금 바로 확인하세요</p>
	  <p align="middle">
	  		<img src="musicNew.png">
	  </p>
	</div>
</body>
</html>