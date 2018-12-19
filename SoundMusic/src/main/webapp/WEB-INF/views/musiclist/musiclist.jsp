<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<title>Document</title>
<script>
$(document).ready(function(){
	//음악 추가 폼
	$('#aList').click(function(){
		$(location).attr('href','../musiclist/musiclistadd.sm');
	});
	
	//음악 복원 폼
	$('#rcList').click(function(){
		$(location).attr('href','../musiclist/musicrecycle.sm');
	})
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
function gMain(){
	$(location).attr('href','../main.jsp');
}
</script>
<style>
a {text-decoration:none;}
a.genre:link{color:white;}
a.genre:visited{color:#4444FF;}
a.genre:hover{color:#1FDA11;}
a.music:link{color:brown;}
a.music:visited{color:blue;}
a.music:hover{color:black;}
</style>	
</head>
<body>
<img src = "../resources/images/musiclist.png" />
<div class="container">
<% String path = "http://localhost:80/music/musiclist";	 %>
  <!-- 검색창  -->
<form id="sForm" method="post" action="<%=path%>/musicrecycle.sm?nowPage=${PINFO.nowPage}&genre=${GENRE}">
	<table width="930px" cellpadding="0px" align="center">
		<tr>
			<td><br/></td>
		</tr>
		<tr>
			<td align="left">
				<input type="button" class="btn btn-outline-success" id="goMain" name="goMain" 
				onclick="gMain()" value="홈으로" />
			</td>	
			<td align="right">
				<select class="form-control" id="sMenu" name="sub" style="width:180px;height:40px;">
					<option value="0">---선택하세요---</option>
					<option value="1">곡</option>
					<option value="2">아티스트</option>
					<option value="3">앨범</option>
				</select>
			</td>
			<td>	
				<input type="text" class="form-control" id="svalue" name="svalue" 
				placeholder="검색어를 입력해주세요" size="25"/>
			</td>
			<td>
				<input type="button" class="btn btn-primary" id="sBtn" name="sBtn" value="검색"
				 onclick="getSearchValue()"/>
				 <c:if test="${ID eq 'admin'}">
				<input type="button" class="btn" id="aList" value="음악 추가" />
				<input type="button" class="btn" id="rcList" value="복원" />	
				</c:if>
			</td>
		</tr>
	</table>
</form>
<br/>
<hr>
<!-- 장르 선택 테이블 -->
  <table class="genre" width="930px" align="center">
  	<tr>
  		<td class="genre" width="12.5%" align="center">
  			<a class="genre" href="<%=path%>/musiclist.sm?genre=">전체</a>
  		</td>
		<td class="genre" width="12.5%" align="center" >
			<a class="genre" href="<%=path%>/musiclist.sm?genre=발라드/댄스/팝">발라드/댄스/팝</a>
		</td>
		<td class="genre" width="12.5%" align="center" >
			<a class="genre" href="<%=path%>/musiclist.sm?genre=랩/힙합">랩/힙합</a>
		</td>  
		<td class="genre" width="12.5%" align="center" >
			<a class="genre" href="<%=path%>/musiclist.sm?genre=알앤비/소울">알앤비/소울</a>
		</td>  
		<td class="genre" width="12.5%" align="center" >
			<a class="genre" href="<%=path%>/musiclist.sm?genre=일렉트로닉">일렉트로닉</a>
		</td>  
		<td class="genre" width="12.5%" align="center">
			<a class="genre" href="<%=path%>/musiclist.sm?genre=락/메탈">락/메탈</a>
		</td>  
		<td class="genre" width="12.5%" align="center">
			<a class="genre" href="<%=path%>/musiclist.sm?genre=재즈">재즈</a>
		</td>
		<td class="genre" width="12.5%" align="center">
			<a class="genre" href="<%=path%>/musiclist.sm?genre=인디">인디</a>
		</td>      
  	</tr>
  </table>
<form id="mView" method="get" action="../musiclist/musicinfo.sm">
	<input type="hidden" id="nowPage" name="nowPage"/>
	<input type="hidden" id="no" name="no" />
	<input type="hidden" id="genre" name="genre"/>
</form>
<hr>
  <!-- 리스트  -->
 <table class="table table-hover" align="center">
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
 <%--페이징 --%>
 	<div class="text-center" >
 		<ul class="pagination justify-content-center">
			<%-- 이전 링크 만들기 --%>
			<c:if test="${PINFO.startPage eq 1}">
			<li class="page-item">
				<a class="page-link" href="#">이전</a>
			</li>	
			</c:if>
			<c:if test="${PINFO.startPage ne 1}">
				<li class="page-item">
				<a class="page-link" href="<%=path%>/musiclist.sm?nowPage=${PINFO.nowPage-1}&genre=${GENRE}">이전</a>
				</li>
			</c:if>
			<%-- [1][2][3]링크만들기 --%>
			<c:forEach var="page" begin="${PINFO.startPage}" end="${PINFO.endPage}">
				<li class="page-item">
					<a class="page-link" href="<%=path%>/musiclist.sm?nowPage=${page}&genre=${GENRE}">${page}</a>
				</li>
			</c:forEach>	
			<%-- 다음 링크 만들기 --%>
			<c:if test="${PINFO.endPage eq PINFO.totalPage}">
				<li class="page-item">
				<a class="page-link" href="#">다음</a>
				</li>
			</c:if>
			<c:if test="${PINFO.endPage ne PINFO.totalPage}">
				<li class="page-item">
				<a class="page-link" href="<%=path%>/musiclist.sm?nowPage=${PINFO.nowPage+1}&genre=${GENRE}">다음</a>
				</li>
			</c:if>
		</ul>
	</div>	
 </div>	
</body>
</html>