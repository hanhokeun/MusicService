<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
	<title>Document</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
  	<link href="https://fonts.googleapis.com/css?family=Poor+Story" rel="stylesheet">
  	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<style>
			body{
				font-family: 'Poor Story', cursive;
				font-size: 20px;
			}
	</style>
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
				if($('#song').val()==""){
					alert('노래 제목을 입력해주세요');
					$('#song').focus();
					return; 
				}
				if($('#artist').val()==""){
					alert('가수 이름을 입력해주세요');
					$('#artist').focus();
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
							"<td colspan='3'><input type='file' name='files' id='files"+count+
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
			$('#lBtn').click(function(){
				$(location).attr('href','../static/staticList.sm');
			});
		});
	</script>
</head>
<body>
	<div class="container">
		<div class="row">
		<div class="col-lg-1"></div>
			<div class="col-lg-10">
			  	<h1 align="center">통계 페이지 글 작성하기</h1>
			  		<form id="wForm"  method="post"  action="../static/staticWriteProc.sm"
			  			encType="multipart/form-data">
			  			<table class="table">
					  		<tr>
					  			<th>제목</th>
					  			<td colspan="3"><input type="text" name="title" id="title" class="form-control form-control-sm"/></td>
					  		</tr>
					  		<tr>
					  			<th>노래 제목</th>
					  			<td><input type="text" name="song" id="song" class="form-control form-control-sm"/></td>
					  			<th>가수 이름</th>
					  			<td><input type="text" name="artist" id="artist" class="form-control form-control-sm"/></td>
					  		</tr>
					  		<tr>
					  			<th>본문</th>
					  			<td colspan="3"><textarea name="body" id="body" cols="80" rows="5" class="form-control"></textarea></td>
					  		</tr>
					  		<tr>
					  			<th>첨부파일</th>
					  			<td colspan="3">
					  				<input type="button" id="aBtn" value="추가"/>
					  				<input type="button" id="dBtn" value="삭제"/>
					  			</td>
					  		</tr>
					  		<tr>
					  			<th>첨부파일</th>
					  			<td colspan="3">
					  				<input type="file" name="files" id="files" value="파일 선택"/>
					  			</td>
					  		</tr>
					  		<tr id="copy">
					  			<td colspan="5" align="center">
						  			<div class="btn-group btn-group">
						  				<button  type="button" class="btn btn-outline-secondary" id="sBtn">글쓰기</button>
						  				<button  type="button" class="btn btn-outline-secondary" id="lBtn">목록보기</button>
						  			</div>
					  			</td>
					  		</tr>
			  			</table>
			  	</form>
			</div>
			<div class="col-lg-1"></div>
		</div>
	</div>
</body>
</html>