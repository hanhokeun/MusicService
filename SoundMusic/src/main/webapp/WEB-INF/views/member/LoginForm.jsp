<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
	<title>Insert title here</title>
 <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<script>
		 
	 function LoginProc(){
		var idData = document.getElementById("id").value; //로 사용가능
		var pwData = document.getElementById("pw").value; //로 사용가능
		//alert(idData+"  /   "+pwData);
	
		if(idData=="" || idData.length==0){
			alert("아이디를  입력해주세요");
			document.getElementById("id").focus();
			return; // 함수의 강제종료
		}
		if(pwData=="" || pwData.length==0 ){
			alert("비밀번호를 입력해주세요");
			document.getElementById("pw").focus();
			return; // 함수의 강제종료		
		}		
	}
	
	// 회원가입 버튼 클릭시 회원가입 화면으로 이동
	function MemberJoin() {
	    location.href="./../member/SignUp.sm";
	}

	// ID찾기 버튼 클릭시 ID찾기 화면으로 이동
	function IdSearch() {
    	location.href="./../member/IdSearch.sm";
	}
	
	// PW찾기 버튼 클릭시 PW찾기 화면으로 이동
	function PwSearch() {
    	location.href="./../member/PwSearch.sm";
	}
	
	$(document).ready(function(){
		$("#lBtn").click(function(){	
			$("#LoginFrm").submit();
		});	
	});

</script>
<body>

<div class="container">
	<div class="row">	
	<div class="col-lg-3"></div>		
		<div class="col-lg-7"><br><br>			
			<a href="../main.jsp"><img src="../resources/images/music.png" alt="사진"/></a>
			<br><br><br>
			<div class="jumbotron" style="padding-top:20px;">
				<form method="GET" action="../member/LoginProc.sm" id="LoginFrm">
					<h3 style="text-align:center;">로그인 화면</h3>
					<div class="form-group">
						<label for="id">아이디:</label>
							<input type="text" class="form-control" placeholder="아이디" name="id"  id="id"  maxlength="20">
					</div>
					<div class="form-group">
						<label for="pw">비밀번호:</label>
							<input type="password" class="form-control" placeholder="비밀번호" name="pw"   id="pw"   maxlength="20">
					</div>
					<input type="button" class="btn btn-primary form-control" id ="lBtn" onClick="LoginProc()" value="LOGIN" >
				</form>
			</div>
		
			<hr><br><p>아이디가 기억나지않으세요?</p>
			<div class="btn-group">
				<input type="button"  class="btn btn-default" id ="Mbtn" onClick="MemberJoin()" value="회원가입" />
				<input type="button"  class="btn btn-default"  id ="Idbtn" onClick="IdSearch()" value="아이디찾기" />
				<input type="button"  class="btn btn-default"  id ="Pwbtn" onClick="PwSearch()" value="비밀번호찾기"/>
			</div>
		</div>
		<div class="col-lg-2"></div>
	</div>	
</div> 
</body>
</html>
