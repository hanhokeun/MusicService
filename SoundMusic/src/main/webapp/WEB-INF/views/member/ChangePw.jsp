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
  	
  	function ChangeForm(){  		
  		
  		var pw = $("#pw").val();
  		var cpw = $("#cpw").val();
  		var cpw1 = $("#cpw1").val();  		
  		
  		if(pw.length<4 || pw.length>12 ){
  			alert("비밀번호는 4~12 자입니다.");
  			$("#pw").focus();
  			return false; 
  		}
  		
  		if(cpw.length<4 || cpw.length>12 ){
  			alert("비밀번호는 4~12 자입니다.");
  			$("#cpw").focus();
  			return false; 
  		}
  		
  		if(cpw1.length<4 || cpw1.length>12 ){
  			alert("비밀번호는 4~12 자입니다.");
  			$("#cpw1").focus();
  			return false; 
  		}
  		
  		if(cpw != cpw1){
  			alert("새 비밀번호가 같지 않습니다.")
  			$("#cpw1").focus();
  			return false;
  		}  		
  		
  		if(confirm('비밀번호를 변경 하시겠습니까?')){
  			alert("수정이 완료되었습니다.")
  			$("#cFrm").submit();			 
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
    <li class="active"><a href="../member/Profile.sm">프로필관리</a></li>
    <li><a href="../member/ChangePw.sm">비밀번호 변경</a></li>
    <li><a href="#">-</a></li>    
    <li><a href="#" onclick="defileForm()">회원탈퇴</a></li>    
  </ul></br></br>
  <form method="post" action="../member/ChangePwProc.sm" id="cFrm">      
  <table class="table table-bordered">
    <tbody>
    	<tr>
  			<th>현재 비밀번호</th>
  			<td colspan="2">
  				<input type="password" name="pw"  id="pw" class="form-control" placeholder="현재 비밀번호" style="width: 360px;"/>
  			</td>
  		</tr>
  		<tr>
  			<th>새 비밀번호</th>
  			<td colspan="2">
  				<input type="password" name="cpw"  id="cpw" class="form-control" placeholder="새 비밀번호" style="width: 360px;"/>
  			</td>
  		</tr>
  		<tr>
  			<th>새 비밀번호확인</th>
  			<td colspan="2">
  				<input type="password" name="cpw1"  id="cpw1" class="form-control" placeholder="새 비밀번호" style="width: 360px;"/>
  			</td>
  		</tr>  		 
  		<tr>
  			<td colspan="2">
  				<input type="button" class="btn btn-primary pull-right" onclick="ChangeForm()" value="비밀번호 변경"  /> 
	            
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