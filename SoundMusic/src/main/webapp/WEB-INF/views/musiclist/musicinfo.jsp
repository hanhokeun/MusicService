<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<title>Document</title>
</head>
<script>
$(document).ready(function(){
	$('#goList').click(function(){
		$(location).attr('href',"../musiclist/musiclist.sm?nowPage=${NOWPAGE}&genre=${GENRE}")
	})
})
</script>
<body>
  	<!-- 이곳은 음악의 상세 정보를 표시하는 창
  	VO로부터 파라미터를 가져와서 표시할 예정  -->

<span class="title">
	<h1>${INFO.title}</h1>
</span>
<table  border="1" width="60%">	
	<tr>
		<td rowspan="3" width="200px" height="200px">
			<img src="${INFO.path}" width="200px" height="200px">
		</td>
		<td>아티스트</td>
		<td>${INFO.artist}</td>
	</tr>
	<tr>
		<td>앨범</td>
		<td>${INFO.album}</td>
	</tr>
	<tr>
		<td colspan="3">
			<input type="button" id="goList" name="goList" value="목록으로">
			<input type="button" id="like" name="like" value="추천하기 ${INFO.star}">
			<input type="button" id="mBtn" name="mBtn" value="수정하기">
		</td>
	</tr>
</table>
<div class="lyrics">
	<h2>가사</h2>
	<hr>
	${INFO.lyrics}
</div>
<hr>
</body>
</html>
