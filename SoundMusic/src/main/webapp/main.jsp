<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<head>
  <title>Insert title here</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  <link href="https://fonts.googleapis.com/css?family=Poor+Story" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
  <style> 
	  body{
		font-family: 'Poor Story', cursive;  
		font-size: 20px;
	  }
	  
	/*   hr.new1{
	  	border: solid 0.3px;
	  } */
  </style>
</head>
<body>
<%
		String id = null;
		if(session.getAttribute("UID") != null){
		id = (String) session.getAttribute("UID");
		}
%>
<div class="container">		
  <!--해더 로고 및 로그인버튼-->
  <div class="row">   
    <div class="col-md-12">
      <div class="header" style="background-color:coral;">      	
      	<img src="./resources/images/logo.png" alt="list">
      	<div>
	 		<ul class="nav justify-content-end">
      	<%
		if(id == null){
		%>
    			<li class="nav-item"><a class="nav-link" href="member/LoginForm.sm""><i class='fas fa-user-check' style='font-size:24px'></i> 로그인</a></li>
    			<li class="nav-item"><a class="nav-link" href="member/SignUp.sm"><i class='fas fa-user-plus' style='font-size:24px'></i> 회원가입</a></li>
	  	<% 
		}else if(id.equals("admin")){
		%>
				<li class="nav-item"><a class="nav-link" href="#"><i class='fas fa-user-circle' style='font-size:24px'></i> ${sessionScope.UID}</a></li>
    			<li class="nav-item"><a class="nav-link" href="member/MemberList.sm"><i class='fas fa-user-friends' style='font-size:24px'></i> 회원관리</a></li>
    			<li class="nav-item"><a class="nav-link" href="member/LogOut.sm"><i class='fas fa-user-times' style='font-size:24px'></i> 로그아웃</a></li>
	  	<% 
		}else{
		%>	
				<li class="nav-item"><a class="nav-link" href="#"><i class='fas fa-user-circle' style='font-size:24px'></i> ${sessionScope.UID}</a></li>
    			<li class="nav-item"><a class="nav-link" href="member/Profile.sm"><i class='fas fa-portrait' style='font-size:24px'></i> My Page</a></li>
    			<li class="nav-item"><a class="nav-link" href="member/LogOut.sm"><i class='fas fa-user-times' style='font-size:24px'></i> 로그아웃</a></li>
	  	<%
		}
      	%>
      	  	</ul>	   
	  	</div>
      	
	  	<br>
      	<div>
      		<ul class="nav nav-tabs nav-justified">
      			<li class="nav-item"><a class="nav-link active" href="#"><i class="fa fa-signal" style="font-size:24px"></i> 실시간차트</a></li>
    			<li class="nav-item"><a class="nav-link active" href="musiclist/musiclist.sm"><i class='fas fa-headphones' style='font-size:24px'></i> Music List</a></li>    			
    			<li class="nav-item"><a class="nav-link active" href="concert/concertList.sm"><i class='fas fa-microphone-alt' style='font-size:24px'></i> 콘서트</a></li>
    			<li class="nav-item"><a class="nav-link active" href="freeBoard/boardList.sm"><i class='fas fa-pencil-alt' style='font-size:24px'></i> 커뮤니티</a></li>    			
    			<li class="nav-item"><a class="nav-link active" href="static/staticList.sm"><i class='fab fa-r-project' style='font-size:24px'></i> Music BigData</a></li>	    			
  			</ul>			
  		</div>	
      </div>
    </div>
  </div>
  <hr class="new1">
  <br>

  <!--왼쪽 사이드바-->
  <div class="row">
    <div class="col-md-3">
      <div class="menubar">
      	<ul class="list-group list-group-flush">
        	<li class="list-group-item"><a href="#" class="list-group-item list-group-item-action"> 실시간 차트</a></li>
        	<li class="list-group-item"><a href="musiclist/musiclist.sm" class="list-group-item list-group-item-action"> Music List</a></li>
        	<li class="list-group-item"><a href="concert/concertList.sm" class="list-group-item list-group-item-action"> 콘서트</a></li>
        	<li class="list-group-item"><a href="freeBoard/boardList.sm" class="list-group-item list-group-item-action"> 커뮤니티</a></li>        	
        	<li class="list-group-item"><a href="static/staticList.sm" class="list-group-item list-group-item-action"> Music BigData</a></li>
        </ul>   
      </div>
    </div>
    <!--메인 컨텐츠 실시간 동영상-->
    <div class="col-md-9"">
       <div class="carousel-inner">
        <div class="carousel-item active">
          <p align="middle">
          	<h4><i class='fab fa-youtube' style='font-size:24px'></i> 실시간 인기 동영상  <a href="#" class="btn btn-outline-light text-dark"> 더보기</a> </h4><hr>    	
          <iframe align="center" width="800" height="400" src="https://www.youtube.com/embed/SAdmzjsFVQo?rel=0&autoplay=1&amp;loop=1" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>         
          </p>
        </div>
      </div>
    </div>
  </div> 
<hr><br>

  <div class="row">
  	<!-- 실시간 차트 -->
    <div class="col-md-3">
        <h3><i class="fa fa-signal" style="font-size:30px"></i>실시간 차트 <a href="#" class="btn btn-outline-light text-dark"> 더보기</a></h3><hr>
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
      <img src="./resources/images/mnetc.png" class="img-thumbnail" alt="Los Angeles" width="300" height="500">
    </div>
    <div class="carousel-item">
      <img src="./resources/images/bugsc.png" class="img-thumbnail" alt="Chicago" width="300" height="500">
    </div>
    <div class="carousel-item">
      <img src="./resources/images/melonc.png" class="img-thumbnail" alt="New York" width="300" height="500">
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

    <!-- 뮤직리스트-->
    <div class="col-md-9">
    	<div>
        <h3><i class='fas fa-headphones' style='font-size:24px'></i> Music List <a href="musiclist/musiclist.sm" class="btn btn-outline-light text-dark"> 더보기</a></h3><hr>
        	<img src="./resources/images/musiclist.png" class="img-thumbnail" alt="music list" width="900" height="600">
    	</div>
    </div>
 </div>
  <hr><br>

  <!-- 콘서트 -->
  <div class="row">
    <div class="col-md-12">
      <h3><i class='fas fa-microphone-alt' style='font-size:24px'></i> 콘서트 <a href="concert/concertList.sm" class="btn btn-outline-light text-dark"> 더보기</a></h3><hr>
      <img src="./resources/images/consert.png" class="img-thumbnail" alt="consert"  width="1100">
    </div>
  </div> 
  <hr> 
</div>

<!-- footer-->
<footer style="background-color: #4C4C4C; color: #ffffff">
		<div class="container">
				<br>
				<div class="row">
					<div class="col-sm-4" style="text-align: center;"><h6>copyright &copy; 2018</h6><br><h8>구로 IT경영기술 개발원</h8><br>2018.06.29~2019.01.02<br>마지막 프로젝트</div>
					<div class="col-sm-4" style="text-align: center;"><h6>팀소개</h6><br>김대현 한호근 유남기 장수경 이현정</h6><br>302호 드림팀<br>어렵게 한자리에 모였습니다.<br>이 순간이 지나면 백수가 된다는것을.</div>
					<div class="col-sm-4" style="text-align: center;"><h6>개발목표</h6><br>음악정보지원서비스는 음악사이트별 차트 비교 및 전반적인 음악에 대한 정보를 제공하며 음악 빅데이터 분석 음악에 대한 추세와 사용자간의 관심분야에 대해 인사이트를 추출</div>						
				</div>							
		</div>	
	
	</footer>	
</body>
</html>
