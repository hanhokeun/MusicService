<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<title>Document</title>
<script>
$(document).ready(function(){
	$('#aList').click(function(){
		$(location).attr('href','../musiclist/musiclistadd.sm');
	});
});
function getSearchValue(){
		if($('#svalue').val()=='' || $('#svalue').val()== null ){
			alert('검색어를 입력해주세요!')
			return false;
		}
		$('#sForm').submit();
};
function getView(nowPage,no,genre){
	$('#no').val(no);
	$('#nowPage').val(nowPage);
	$('#genre').val(genre)
	$('#mView').submit();
};
</script>
<style>
a {text-decoration:none;}
a.genre:link{color:white;}
a.genre:visited{color:blue;}
a.music:link{color:brown;}
a.music:visited{color:blue;}
a.genre:hover{color:pink;}
a.music:hover{color:black;}

</style>	
</head>
<body>
  <h1>음악 전체 리스트</h1>
<% String path = "http://localhost:80/music/musiclist";	 %>
  <!-- 검색창  -->
<form id="sForm" method="post" action="<%=path%>/musiclist.sm?nowPage=${PINFO.nowPage}&genre=${GENRE}">
	<table width="70%" cellpadding="0px" align="center">
		<tr>
			<td colspan="3" align="right">
				<select id="sMenu" name="sub">
					<option value="0">---선택하세요---</option>
					<option value="1">곡</option>
					<option value="2">아티스트</option>
					<option value="3">앨범</option>
				</select>
				<input type="text" id="svalue" name="svalue" placeholder="검색어를 입력해주세요"/>
				<input type="button" id="sBtn" name="sBtn" value="검색" onclick="getSearchValue()"/>
			</td>
			<td>
				<input type="button" id="aList" value="음악 추가" />
			</td>
		</tr>
	</table>
</form>

<!-- 장르 선택 테이블 -->
  <table class="genre"  align="center" width="70%">
  	<tr>
  		<td width="12.5%" align="center" style="background-color:red;color:white;">
  			<a class="genre" href="<%=path%>/musiclist.sm?genre=">전체</a>
  		</td>
		<td width="12.5%" align="center" style="background-color:orange;color:white;">
			<a class="genre" href="<%=path%>/musiclist.sm?genre=발라드/댄스/팝">발라드/댄스/팝</a>
		</td>
		<td width="12.5%" align="center" style="background-color:yellow;color:white;">
			<a class="genre" href="<%=path%>/musiclist.sm?genre=랩/힙합">랩/힙합</a>
		</td>  
		<td width="12.5%" align="center" style="background-color:green;color:white;">
			<a class="genre" href="<%=path%>/musiclist.sm?genre=알앤비/소울">알앤비/소울</a>
		</td>  
		<td width="12.5%" align="center" style="background-color:blue;color:white;">
			<a class="genre" href="<%=path%>/musiclist.sm?genre=일렉트로닉">일렉트로닉</a>
		</td>  
		<td width="12.5%" align="center" style="background-color:navy;color:white;">
			<a class="genre" href="<%=path%>/musiclist.sm?genre=락/메탈">락/메탈</a>
		</td>  
		<td width="12.5%" align="center" style="background-color:purple;color:white;">
			<a class="genre" href="<%=path%>/musiclist.sm?genre=재즈">재즈</a>
		</td>
		<td width="12.5%" align="center" style="background-color:black;color:white;">
			<a class="genre" href="<%=path%>/musiclist.sm?genre=인디">인디</a>
		</td>      
  	</tr>
  </table>
<form id="mView" method="get" action="../musiclist/musicinfo.sm">
	<input type="hidden" id="nowPage" name="nowPage"/>
	<input type="hidden" id="no" name="no" />
	<input type="hidden" id="genre" name="genre"/>
</form>
  <!-- 리스트  -->
 <table border="1" width="70%" align="center">
 	<tr>
 		<td colspan="2"><b>곡</b></td>
 		<td><b>아티스트</b></td>
 		<td><b>앨범</b></td>
 		<td><b>추천수</b></td>
 	</tr>
 	<c:forEach var="test" items="${LIST}">
 	 	<tr>
	 		<td><img src="${test.path}" width="50px" height="50px"></td>
	 		<td>
	 			<a class="music" href="javascript:void(0);" onclick="javascript:getView('${PINFO.nowPage}','${test.no}','${GENRE}')">${test.title}</a>
	 		</td>
	 		<td>${test.artist}</td>
	 		<td>${test.album}</td>
	 		<td>${test.star}</td>
 		</tr> 
 	</c:forEach>
 </table>
 <table border="1" width="45%" align="center">
		<tr>
			<td align="center">
			<%-- 이전 링크 만들기 --%>
			<c:if test="${PINFO.startPage eq 1}">
				[이전]
			</c:if>
			<c:if test="${PINFO.startPage ne 1}">
				<a href="<%=path%>/musiclist.sm?nowPage=${PINFO.nowPage-1}&genre=${GENRE}">[이전]</a>
			</c:if>
			<%-- [1][2][3]링크만들기 --%>
			<c:forEach var="page" begin="${PINFO.startPage}" end="${PINFO.endPage}">
				<a href="<%=path%>/musiclist.sm?nowPage=${page}&genre=${GENRE}">[${page}]</a>
			</c:forEach>	
			<%-- 다음 링크 만들기 --%>
			<c:if test="${PINFO.endPage eq PINFO.totalPage}">
				[다음]
			</c:if>
			<c:if test="${PINFO.endPage ne PINFO.totalPage}">
				<a href="<%=path%>/musiclist.sm?nowPage=${PINFO.nowPage+1}&genre=${GENRE}">[다음]</a>
			</c:if>
			</td>		
		</tr>
	</table>
</body>
</html>