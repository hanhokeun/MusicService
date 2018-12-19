<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>Insert title here</title>
 <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script type="text/javascript">
  
  	function cPForm(){
  		location.href="./../member/ChangePw.sm"
  	}
  
  	function cForm(){
  		location.href="./../member/Profile.sm"
  	}
  	
  	function ProfileForm(){  		
  		
  		var email = $("#email").val();
  		
  		if(email=="" || email.length==0 ){
  			alert("이메일를 입력해주세요");
  			$("#email").focus();
  			return false; 
  		}else {
	        var emailRegex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	        if (!emailRegex.test(email)) {
	            alert('이메일 주소가 유효하지 않습니다. ex)abc@gmail.com');
	            $("#email").focus();
	            return false;
	        }
	    }
  		
  		
  		if(confirm('회원 수정을 하시겠습니까?')){
  			alert("수정이 완료되었습니다.")
  			$("#pFrm").submit();			 
  		 }  		
  	}
  	
  	function defileForm(){
  		if(confirm('회원탈퇴 하시겠습니까?')){
  			alert("정상적으로 탈퇴하였습니다.")
  			location.href = "../member/MemberDrop.sm"
  			return true;
  		}
  		else{
  			alert("회원 탈퇴를 취소하였습니다.")
  			return false;
  		}
  	}
  	
  
  </script>
  
</head>
<body>
<a href="../member/Profile.sm"><img src="../resources/images/mypage.png" alt="사진"/></a>
<div class="container">		
		<ul class="nav navbar-nav navbar-right">			
			<li><a href="../main.jsp"><span class="glyphicon glyphicon-log-in"></span> 나가기</a></li>
		</ul>	
  <div class="row">
  </br><hr></br>
  <div class="col-lg-2"></div>
 <ul class="nav nav-tabs nav-justified">
    <li class="active"><a href="../member/Profile.sm">프로필 관리</a></li>
    <li><a href="../member/ChangePw.sm">비밀번호 변경</a></li>
    <li><a href="#">-</a></li>    
    <li><a href="#" onclick="defileForm()">회원탈퇴</a></li>    
  </ul></br></br>
  <form method="post" action="../member/ProfileProc.sm" id="pFrm">      
  <table class="table table-bordered">
    <tbody>
  		<tr>
  			<th>아이디</th>
  			<td>${MEM.id}</td> 			
  		</tr>
  		<tr>
  			<th>비밀번호</th>
  			<td colspan="2">
  				<input type="button" class="btn btn-outline-primary" onclick="cPForm()" value="비밀번호 변경" />
  			</td>
  		</tr>  		
  		<tr>
  			<th>이름</th>
  			<td colspan="2">${MEM.name}</td>
  		</tr>
  		<tr>
  			<th>성별</th>  		
  			<td colspan="2">
  				<input type="radio" name="gender"  id="gender" value="남" 
  				<c:if test="${MEM.gender eq '남'}">checked </c:if> />남자
 				<input type="radio" name="gender"  id="gender1" value="여" 				
  				<c:if test="${MEM.gender eq '여'}">checked </c:if> />여자
  			</td>
  		</tr>
  		<tr>
  			<th>이메일</th>
	  		<td colspan="2">
  				<input type="text" name="email"  id="email" class="form-control" value="${MEM.email}" style="width: 360px;"/>
  			</td>
  		</tr>
  		<tr>
  			<td colspan="3">
  				<input type="button" class="btn btn-outline-primary" onclick="ProfileForm()" value="회원수정" /> 
	            <input type="button" class="btn btn-outline-primary" onclick="cForm()" value="취소" />
  			</td>
  		</tr>
  		</tbody>
  </table>
  </form>
  </br>
  
	</br><hr> 
  </div>
 </div> 
</body>
</html>