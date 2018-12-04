<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  	$(document).ready(function(){
  		//Search버튼
  		$("#sBtn").click(function(){  			
  			var search = document.getElementById("word").value; //로 사용가능
  			if(search=="" || search.length==0){
  				alert("검색어를  입력해주세요");
  				document.getElementById("word").focus();
  				return; // 함수의 강제종료
  			}
  			$("#sForm").submit;
  		});
  		
  		// 글쓰기 버튼
  		$("#wBtn").click(function(){  			
  			//글쓰기요청(폼보여줘)
  			
  			//로그인한 user만 글쓰기를 할 수 있도록 하겠다.
  			// 인터셉터를 이용하여 자동으로 로그인기능으로 유도하고자 한다.
  			/* location.href="../fileBoard/writeForm.sun"; */
  			$(location).attr("href","../fileBoard/writeForm.sm");
  		});
  		
  	});
  </script>
</head>
<body>  
	<%-- 검색기능 --%>
	<form action="" method="post" id="sForm">	
	<table class="table table-bordered" align="center">
  	<tr>
  		<td align="center">
  			<!-- 검색대상 -->
  			<select name="target" id="target">
  				<option value="title">제목</option>
  				<option value="body">내용</option>
  				<option value="writer">작성자</option>
  				<option value="both">제목+내용</option>
  			</select>
  			<!-- 검색단어 -->
  			<input type="text" name="word" id="word"/>
  			<!-- 검색버튼 -->
  			<input type="button" id="sBtn" value="Search"/>
  		</td>
  	</tr>
  </table>
  </form>
	<%-- 게시판 목록보기 --%>
	<div class="container">
  <h2>파일 게시판 목록</h2>        
  <table class="table table-bordered">
    <thead>
      <tr class="success">
        <th>글 번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성일</th>
        <th>조회수</th>
        <th>첨부파일</th>
      </tr>
    </thead>
    <tbody>
      <tr class="warning">
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
        <td>-</td>
      </tr>     
    </tbody>
  </table>
  
  
	<%-- 페이지 이동기능 --%>
	<%-- 글쓰기(기타기능) --%>
  <form action="" method="post" id="wForm">
  <table class="table table-bordered" align="center">
  	<tr>
  		<td align="center">
  			<input type="button" id="wBtn" value="글쓰기"/>
  		</td>
  	</tr>
  </table>
  </form>
</div>
</body>
</html>
