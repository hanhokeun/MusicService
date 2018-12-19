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
  <script>
  function pSForm(){
	  	var id = $("#id").val();
		var name = $("#name").val();
		var gender = $("input[name=gender]:checked").val()
		var email = $("#email").val();		
		
		
		if(id=="" || id.length==0){
			alert("아이디를  입력해주세요");
			$("#id").focus();		
			return false; 
		}else{
			 var idReg = /^[a-z]+[a-z0-9]{3,14}$/g;
		     if( !idReg.test(id)){
		     	alert("아이디는 영문자로 시작하는 4~15자 영문자 또는 숫자이어야 합니다.");
		        return false;
		        }	
		}		
		if(name.length<=1 || name.length==0 ){
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
			data : {'id':id,'name':name,'gender':gender, 'email':email},
			url : "PwSearchProc.sm",			
			dataType : 'text',
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",				
			success : function(result){
				
				if(result==""){
					alert("일치하는 정보가 없습니다.")	
				}
				else{
					  $("#contentBody").html("<h2>회원 비밀번호 : "+result +"<h2>");
				        $("#myModal").modal('show'); 
					/* alert("회원님의 아이디는 : " +result+"입니다.") */
					/* $("#idList").append("<h1>"+"회원님의 아이디는 :"+result +"입니다. </h1>") */	
				
				}
				
			}
			
		});		
		
	}
  
  </script>
</head>
<body>
 <div class="container"> 
 	<div class="col-lg-2"></div>		
		<div class="col-lg-8">			
			<a href="../main.jsp"><img src="../resources/images/music.png" alt="사진"/></a>
			<br><br>					
			<h3>비밀번호 찾기</h3><hr><br>
			
			<form method="post" action="../member/PwSearchProc.sm" id="PwSearch" name="PwSearch">					
  				<table class="table table-bordered table-hover" style="text-align:center, border:1px;">
				<thead>
					<tr><th colspan="3" style="text-align:center;"><h5>등록된 회원정보로 찾기</h5></tr>
				</thead>
				<tbody>
					<tr>
  						<th>아이디</th>
  							<td colspan="2">
  							<input type="text" name="id"  id="id" class="form-control" placeholder="아이디" style="width: 360px;"/>
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
  						<button type="button" class="btn btn-info" onclick="pSForm()" style="width: 700px; height: 50px;">비밀번호찾기</button>
  						</td> 					
  					</tr>
					</tbody>  					
				<span id="idList"></span> 
				</form>
 			<!-- </div> -->
 		<div class="col-lg-2"></div>		
 	</div>
	</div>	
 <footer>
 	<!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">비밀번호 찾기</h4>
        </div>
        <div class="modal-body" id="contentBody">
          <h3>사용자 비밀번호 : </h3>
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
