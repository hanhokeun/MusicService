<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
  <title>Document</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
		$(document).ready(function(){
			var count=1; //업로드할 파일의 개수
			
			//id="sBtn" value="글쓰기" 
			$("#sBtn").click(function(){
				//무결성검사하고
				if($("#title").val == ""){
					alert('제목을 입력하...')
				}
				
				$("#wForm").submit();
			});
			$("#lBtn").click(function(){
				$(location).attr('href',"../freeBoard/boardList.sm")
			})
			
			//첨부파일추가버튼.. 동적추가
			$("#aBtn").click(function(){
				//할일
				//업로드할 파일의 개수제한
				count++; //추가할 때 마다 증가
				if(count==6){
					alert("5개 이상은 추가할 수 없습니다");
					count=5;
					return;
				}
				
				//추가할 폼
				var tr = "<tr><th>첨부파일</th>"+
											"<td><input type='file' name='files' id='files"+count+"'/>"+
											"</td></tr>";				
			
				$("#copy").before(tr);
			});
			
			
	  	//첨부파일삭제버튼.. 동적제거
			$("#dBtn").click(function(){
				
				if(count==1){
					alert("한개는 반드시 있어야 합니다");
					return;
				}
				
				//현재 마지막count번호를 가진 tr를 구한다
				var tr = $("#files"+count).parents("tr");
				tr.remove();
				count--;
			});
			
		});
	</script>
</head>
<body>
<div class="container">
	<div class="row">
		<br><h1>글쓰기 </h1></br></br>
		<div class="col-md-1"></div>
			<div class="col-md-10"><hr>
  				<form id="wForm" method="POST" action="../freeBoard/writeProc.sm" encType="multipart/form-data">
  					<table class="table table-bordered">
	  					<tr>
	  						<th>작성자</th>
	  						<td>${sessionScope.UID}</td>
	  					</tr>
	  					<tr>
	  						<th>제목</th>
	  						<td>
	  							<input type="text" name="title" id="title" />
	  						</td>
	  					</tr>
	  					<tr>
	  						<th>내용</th>
	  						<td>
	  							<textarea name="body" id="body" cols="80" rows="5"></textarea>
	  						</td>
	  					</tr>
	  					<tr>
	  						<th>첨부파일</th>
	  						<td>
	  							<input type="button" id="aBtn" value="추가" />
	  							<input type="button" id="dBtn" value="삭제" />
	  						</td>
	  						</tr>
	  						<tr>
	  							<th>첨부파일</th>
	  							<td>
	  								<input type="file" name="files" id="files"/>
	  							</td>
	  						</tr>
	  						<tr id="copy">
	  							<td colspan="2" align="center">
	  								<input type="button" id="sBtn" value="글쓰기" />
	  								<input type="button" id="lBtn" value="목록으로" />
	  							</td>
	  						</tr>
	  				</table>		
 				 </form>
  			</div>
  		<div class="col-md-1"></div>
  </div>
</div>
</body>
</html>











