<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
	<title>Document</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script>


// 아이디 중복체크
function IdCheck(){
	var userid = $("#id").val();
	var result=0;	
	$.ajax({		
		async:false,
		type : 'POST',
		data: userid,
		url : "IdCheck.sm",
		dataType : "text",
		contentType: "application/json; charset=UTF-8",		
		success : function(result){

			console.log(result)
			if(result==""){				
				alert("사용할 수 있는 아이디입니다.")
				$("#pw").focus();
				result = 1;
				console.log(result);				
				$("#submit1").removeAttr("disabled") 	
			}
			else{
				alert("사용할 수 없는 아이디입니다.")				
				result = 0;		
				console.log(result);				
				$("#id").focus();
				$("#submit1").attr("disabled","disabled")
						
																
			}		
		}	
	})	
}


function JoinForm(){	
	var userid = $("#id").val();
	var userpwd = $("#pw").val();
	var userpwdch = $("#pw1").val();	
	var username = $("#name").val();
	var useremail = $("#email").val();
	
	
	 
	if(userid=="" || userid.length==0){
		alert("아이디를  입력해주세요");
		$("#id").focus();		
		return false; 
	}

	if(userpwd.length<4 || userpwd.length>12 ){
		alert("비밀번호를 4~12자까지 입력해주세요");
		$("#pw").focus();
		return false; 
	}
	if(userpwd != userpwdch ){
		alert("비밀번호가 서로 다릅니다. 비밀번호를 확인해주세요.")
		$("#pw1").focus();
		return false; 
	}
	if(username.length<=1 || username.length==0 ){
		alert("이름을 두글자이상 입력해주세요");
		$("#name").focus();
		return false; 
	}	
	if(useremail=="" || useremail.length==0 ){
		alert("이메일를 입력해주세요");
		$("#email").focus();
		return false; 
	}else {
        var emailRegex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        if (!emailRegex.test(useremail)) {
            alert('이메일 주소가 유효하지 않습니다. ex)abc@gmail.com');
            $("#email").focus();
            return false;
        }
    }		
    
	 if(confirm('등록신청을 하시겠습니까?')){
		alert("회원가입을 축하드립니다.")
		$("#jFrm").submit();			 
	 }
	
    
}



	
</script>
</head>
<body>
<div class="container">	
	<div class="col-lg-2"></div>
	<div class="col-lg-8">
	<a href="../main.jsp">
			<img src="../resources/images/music.png" alt="사진" width="700" height="100" /></a>
			<br><br>
			<h3>회원 등록양식</h3><hr><br>
			
	<form method="post" action="../member/SignProc.sm" id="jFrm">		
		<table class="table table-striped" style="text-align:center, border:1px;">		
		<tbody>
  		<tr class>
  			<th>아이디</th>
  			<td><input type="text" name="id"  id="id" class="form-control" placeholder="아이디" style="width: 200px;"/></td>
  			<td><input type="button"  class="btn btn-default"  id ="idbtn" onClick="IdCheck()" value="중복체크"/></td>
  			
  		</tr>
  		<tr>
  			<th>비밀번호</th>
  			<td colspan="2">
  				<input type="password" name="pw"  id="pw" class="form-control" placeholder="비밀번호" style="width: 360px;"/>
  			</td>
  		</tr>
  		<tr>
  			<th>비밀번호확인</th>
  			<td colspan="2">
  				<input type="password" name="pw1"  id="pw1" class="form-control" placeholder="비밀번호" style="width: 360px;"/>
  			</td>
  		</tr>
  		<tr>
  			<th>이름</th>
  			<td colspan="2">
  				<input type="text" name="name"  id="name" class="form-control" placeholder="이름" style="width: 360px;"/>
  			</td>
  		</tr>
  		<tr>
  			<th>성별</th>
  			<td colspan="2">
  				<input type="radio" name="gender"  id="gender" value="남" checked/>남자
 				<input type="radio" name="gender"  id="gender1" value="여"/>여자
  			</td>
  		</tr>
  		<tr>
  			<th>이메일</th>
	  		<td colspan="2">
  				<input type="text" name="email"  id="email" class="form-control" placeholder="이메일(XXXX@XX.XX)" style="width: 360px;"/>
  			</td>
  		</tr>
  		<tr>
  			<td colspan="3">
  				<input type="button" class="btn btn-outline-primary pull-right" id="submit1" disabled="disabled" onclick="JoinForm()" value="회원가입" /> 
	            <input type="reset" class="btn btn-outline-primary"  value="Reset" />
  			</td>
  		</tr>
  		</tbody>
  		</table>
	</form>
	</div>
	<div class="col-lg-2"></div>	
</div>
</body>
</html>
