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
  	function mPForm(){
  		location.href="./../member/ProfileModify.sm"
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
  <table class="table table-bordered">
  <h2>회원정보</h2>
  <div class="container-fluid full-width">
    <div class="row-fluid">                    
    	<input type="button" class="btn pull-right" onclick="mPForm()" value="회원정보 수정" /><br>
    </div>
  </div></br>
  
    <tbody>
  		<tr>
  			<th>아이디</th>
  			<td>${MEM.id}</td> 			
  		</tr>  		  		
  		<tr>
  			<th>이름</th>
  			<td colspan="2">${MEM.name}</td>
  		</tr>
  		<tr>
  			<th>성별</th>
  			<td colspan="2">${MEM.gender}</td>
  		</tr>
  		<tr>
  			<th>이메일</th>
	  		<td colspan="2">${MEM.email}</td>
  		</tr>  		
  		</tbody>
  </table>  
  </br>
  
	</br><hr> 
  </div>
 </div> 
</body>
</html>