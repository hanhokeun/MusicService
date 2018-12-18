<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>soundMusic</title>
</head>
<link href="https://fonts.googleapis.com/css?family=Poor+Story|Sunflower:300" rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<style>
	body{
		font-family: 'Sunflower', sans-serif;
		font-size: 20px;
	}
</style>
<body>
	<%
	
			String id = null;
			if(session.getAttribute("UID") != null){
			id = (String) session.getAttribute("UID");
			}
	%>
	<!-- Grey with black text -->
	<nav class="navbar navbar-expand-sm bg-light navbar-light">
	  <a class="navbar-brand" href="main.jsp"><img src="music.png" alt="Logo" style="width:70px;"/></a>
	  <ul class="navbar-nav">
	    <li class="nav-item">
	      <a class="nav-link" href="#">실시간 차트</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link disabled" href="#">공지사항</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="./freeBoard/boardList.sm">자유게시판</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link" href="./concert/concertList.sm">콘서트</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link disabled" href="./static/staticList.sm">통계 게시판</a>
	    </li>
	  </ul>
	<%
	if(id == null){
	%> 
	<div class="collapse navbar-collapse justify-content-end">
	    <form class="nav navbar-nav navbar-right">     
	      <ul class="nav justify-content-end"> 			
			<li><a href="member/LoginForm.sm" class="btn btn-outline-secondary btn-sm">로그인</a></li>
			<li><a href="member/SignUp.sm" class="btn btn-outline-secondary btn-sm">회원가입</a></li>		
		</ul>
	    </form>
	  </div>
	<% 
	}else if(id.equals("admin")){
	%>	   
	<div class="collapse navbar-collapse justify-content-end">
	    <form class="nav navbar-nav navbar-right">                  
	      <ul class="nav justify-content-end">
	      	<li><a href="member/MemberList.sm"  class="btn btn-outline-secondary btn-sm">회원관리</a></li>      	
			<li><a href="member/LogOut.sm" class="btn btn-outline-secondary btn-sm">로그아웃</a></li>			
		</ul>
	    </form> 
	 </div>   
	<% 
	}else{
	%>	   
	 <div class="collapse navbar-collapse justify-content-end">
	    <form class="nav navbar-nav navbar-right">                  
	      	<ul class="nav justify-content-end">
	      		<li><a href="member/Profile.sm"  class="btn btn-outline-secondary btn-sm">회원관리</a></li>      	
				<li><a href="member/LogOut.sm" class="btn btn-outline-secondary btn-sm">로그아웃</a></li>			
			</ul>
	    </form>
	  </div>
	<%
	}
	%>    
	</nav>
</body>
</html>