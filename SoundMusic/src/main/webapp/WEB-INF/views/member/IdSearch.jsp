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
  function iSForm(){				
		var name = $("#name").val();
		var gender = $("input[name=gender]:checked").val()
		console.log(gender)		
		var email = $("#email").val();		
		
		if(name.length=="" || name.length==0 ){
			alert("이름을 입력해주세요");
			$("#name").focus();
			return false; 
		}	
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
		
		$.ajax({			
			type : 'GET',
			data : {'name':name,'gender':gender, 'email':email},
			url : "IdSearchProc.sm",			
			dataType : 'text',
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",				
			success : function(result){
				
				if(result==""){
					alert("일치하는 아이디가 없습니다.")	
				}
				else{
					  $("#contentBody").html("<h2>회원 아이디 : "+result +"<h2>");
				        $("#myModal").modal('show'); 
					/* alert("회원님의 아이디는 : " +result+"입니다.") */
					/* $("#idList").append("<h1>"+"회원님의 아이디는 :"+result +"입니다. </h1>") */	
				
				}
				
			}
			
		});		
		
	}
  
	//회원가입 버튼 클릭시 회원가입 화면으로 이동
	function MemberJoin() {
	    location.href="./../member/SignUp.sm";
	}	
	// PW찾기 버튼 클릭시 PW찾기 화면으로 이동
	function PwSearch() {
  	location.href="./../member/PwSearch.sm";
	}
  
  </script>
</head>
<body>
 <div class="container"> 
 	<div class="col-lg-2"></div>		
		<div class="col-lg-8">			
			<a href="../main.jsp"><img src="../resources/images/music.png" alt="사진"/></a>
			<br><br><br>					
			<h3>아이디 찾기</h3><hr><br>
			
			<form method="post" action="../member/IdSearchProc.sm" id="IdSearch" name="IdSearch">					
  				<table class="table table-bordered table-hover" style="text-align:center, border:1px;">
				<thead>
					<tr><th colspan="3" style="text-align:center;"><h5>등록된 회원정보로 찾기</h5></tr>
				</thead>
				<tbody>
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
  							<input type="text" name="email"  id="email" class="form-control" placeholder="이메일" style="width: 360px;"/>
  						</td>
  					</tr>
  					<tr>
  						<td colspan="3">
  						<button type="button" class="btn btn-info" onclick="iSForm()" style="width: 700px; height: 50px;">아이디찾기</button>
  						</td> 					
  					</tr>
					</tbody>  					
				<span id="idList"></span>
				</table> 
			</form><br>
			<hr><span>아이디가 기억나지않으세요?</span>
			<div class="btn-group">
				<input type="button"  class="btn btn-default" id ="Mbtn" onClick="MemberJoin()" value="회원가입" />				
				<input type="button"  class="btn btn-default"  id ="Pwbtn" onClick="PwSearch()" value="비밀번호찾기"/>
			</div> 			 			
		</div>
 		<div class="col-lg-2"></div>		
	</div>	
 <footer>
 	<!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">아이디 찾기</h4>
        </div>
        <div class="modal-body" id="contentBody">
          <h3>사용자 아이디 : </h3>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
 </footer>	
</body>
</html>
