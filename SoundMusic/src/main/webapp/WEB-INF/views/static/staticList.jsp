<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
	<title>Document</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="viewport" content="width=device-width, initial-scale=1">
  	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  	<link href="https://fonts.googleapis.com/css?family=Sunflower:300" rel="stylesheet">
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<style>
			body{
				font-family: 'Sunflower', sans-serif;
			}
	</style>
	<script>
		$(document).ready(function(){
			//검색하기 무결성
			$('#sBtn').click(function(){
				if($('#target').val()==""){
					alert('분류를 선택해주세요');
					$('#target').focus();
					return; 
				}
				if($('#word').val()==""){
					alert('내용을 입력해주세요');
					$('#word').focus();
					return; 
				}
				$('#sForm').submit();
			});
			$('#tBtn').click(function(){
				$(location).attr('href','../static/staticList.sm');
			});
			//글쓰기 버튼
			$('#wBtn').click(function(){
				//글쓰기(폼보여주기)요청
				$(location).attr("href","../static/staticWriteForm.sm");
			});
		})
	</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-lg-1"></div>
			<div class="col-lg-10">
			  	<h1 align="center">통계 게시판</h1>
			  	<%-- 검색 기능 --%>
			  	<form id="sForm" method="post"  action="../static/staticList.sm">
			  		<div class="dropdown">
				  	 <table width="700" align="center" class="table table-hover">
				  		<tr>
				  			<td align="center">
								<!-- 검색 대상 -->
								<select name="searchOption" id="target">
									<option value="0">==선택하세요==</option>
									<option value="1"  <c:if test="${SEARCHOPTION eq '1'}"> selected</c:if>>전체</option>
									<option value="2" <c:if test="${SEARCHOPTION eq '2'}"> selected</c:if>>제목</option>
									<option value="3" <c:if test="${SEARCHOPTION eq '3'}"> selected</c:if>>내용</option>
									<option value="4" <c:if test="${SEARCHOPTION eq '4'}"> selected</c:if>>노래명</option>
									<option value="5" <c:if test="${SEARCHOPTION eq '5'}"> selected</c:if>>가수명</option>
								</select>
								<!-- 검색 단어 -->
								<input type="text" name="keyword" id="word"  value="${KEYWORD}"/>
								<!-- 검색 버튼 -->
								<button type="button" class="btn btn-light btn-sm" id="sBtn">조회</button>
								<button type="button" class="btn btn-light btn-sm" id="tBtn">전체보기</button>
				  			</td>
				  		</tr>
				  	</table>
				  </div>
			  	</form>
		  	<%-- 게시판 목록보기 --%>
			  	<table width="700" align="center" class="table table-hover">
			  		<thead>
			  			<tr>
			  				<th>번호</th>
							<th>제목</th>
							<th>작성일/수정일</th>
							<th>조회수</th>
							<th>첨부파일</th>
			  			</tr>
			  		</thead>
			  		<tbody>
				  		<c:forEach var="data" items="${LIST}">
				  		  	<tr>
				  				<td>${data.no}</td>
				  				<td>
				  					<a href="../static/staticHit.sm?oriNo=${data.no}&nowPage=${PINFO.nowPage}">${data.title}</a>
				  				</td>
								<td>${data.date}</td>
								<td>${data.hit}</td>
								<td>${data.fileCount}건</td>
				  			</tr>
				  		</c:forEach>
			  		</tbody>
			  	</table>
		  	<%-- 페이지 이동기능 --%>
			  	<table align="center" width="700">
			  		<tr>
			  			<td align="center">
				  			<%--이전링크 만들기--%>
				  			<c:if test="${PINFO.startPage eq 1}">[<]</c:if>
				  			<c:if test="${PINFO.startPage ne 1}">
				  				<a href="../static/staticList.sm?nowPage=${PINFO.nowPage-1}&searchOption=${SEARCHOPTION}&keyword=${KEYWORD}">[<]</a></c:if>
				  			<c:forEach var="page" begin="${PINFO.startPage}" end="${PINFO.endPage}">
				  				<a href="../static/staticList.sm?nowPage=${page}&searchOption=${SEARCHOPTION}&keyword=${KEYWORD}">[${page}]</a>
				  			</c:forEach>
				  			<%--다음링크 만들기--%>
				  			<c:if test="${PINFO.endPage eq PINFO.totalPage}">[>]</c:if>
				  			<c:if test="${PINFO.endPage ne PINFO.totalPage}">
				  				<a href="../static/staticList.sm?nowPage=${PINFO.endPage+1}&searchOption=${SEARCHOPTION}&keyword=${KEYWORD}">[>]</a>
				  			</c:if>
				  		</td>
			  		</tr>
			  	</table>
		  	<%-- 글쓰기(기타기능) 관리자만 가능하게 한다--%>
		  	<%-- <c:if test="${sessionScope.UID eq 'admin'}">--%>
			  	<form id="wForm"  method="get">
				  	<table width="700" align="center" class="table table-hover">
				  		<tr>
				  			<td align="center">
				  				<button type="button" class="btn btn-light btn-block" id="wBtn">글쓰기</button>
				  			</td>
				  		</tr>
				  	</table>
				 </form>
			<%--</c:if>--%>
			</div>
		</div>
	</div>
</body>
</html>