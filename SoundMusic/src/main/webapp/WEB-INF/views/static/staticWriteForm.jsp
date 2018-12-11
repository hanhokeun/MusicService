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
			//글쓰기버튼 클릭
			$("#sBtn").click(function(){
				//무결성 검사
				if($('#title').val()==""){
					alert('제목을 입력해주세요');
					$('#title').focus();
					return; 
				}
				if($('#body').val()==""){
					alert('내용을 입력해주세요');
					$('#body').focus();
					return; 
				}
				if($('#pw').val()==""){
					alert('내용을 입력해주세요');
					$('#pw').focus();
					return; 
				}
				$('#wForm').submit();
			})
			
			//첨부파일추가버튼
			$('#aBtn').click(function(){
				//할일
				//업로드파일의 개수 제한
				count++; //추가할 때마다 증가
				if(count==6){
					alert("6개 이상은 추가할 수 없습니다");
					count=5;
					return;
				}
				//추가할 폼
				var tr= "<tr><th>첨부파일</th>"+
							"<td><input type='file' name='files' id='files"+count+
							"' value='파일선택'/></td></tr>"
				//원하는 위치에 추가
				$('#copy').before(tr);
			})
			//첨부파일삭제버튼
			$('#dBtn').click(function(){
				if(count==1){
					alert('더이상 삭제할 수 없습니다');
					return;
				}
				//현재 마지막 count번호를 가진 tr을 구한다
				var tr=$("#files"+count).parents("tr");
				tr.remove();
				count--;
			});
		});

		
	</script>
</head>
<body>
  <h1>글쓰기 폼(writeForm.jsp)</h1>
  <form id="wForm"  method="post"  action="../static/staticWriteProc.sm"
  			encType="multipart/form-data">
  	<table border="1" width="700" align="center">
  		<tr>
  			<th>글쓴이</th>
  			<td>${sessionScope.UNICK}</td>
  		</tr>
  		<tr>
  			<th>제목</th>
  			<td><input type="text" name="title" id="title"/></td>
  		</tr>
  		<tr>
  			<th>본문</th>
  			<td><textarea name="body" id="body" cols="80" rows="5"></textarea></td>
  		</tr>
  		<tr>
  			<th>비밀번호</th>
  			<td><input type="text" id="pw" name="pw" /></td>
  		</tr>
  		<tr>
  			<th>첨부파일</th>
  			<td>
  				<input type="button" id="aBtn" value="추가"/>
  				<input type="button" id="dBtn" value="삭제"/>
  			</td>
  		</tr>
  		<tr>
  			<th>첨부파일</th>
  			<td><input type="file" name="files" id="files" value="파일 선택"/></td>
  		</tr>
  		<tr id="copy">
  			<th colspan="2"><input type="button" id="sBtn" value="글쓰기"/></th>
  		</tr>
  	</table>
  </form>
</body>
</html>