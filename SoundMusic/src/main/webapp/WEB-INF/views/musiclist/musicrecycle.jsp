<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
function getView(nowPage,no,genre){
	$('#no').val(no);
	$('#nowPage').val(nowPage);
	$('#genre').val(genre)
	$('#mView').submit();
};
function rcProc(no){
	$('#rcNo').val(no);
	$('#rcFrm').submit();
}
function gMain(){
	$(location).attr('href','../musiclist/musiclist.sm')
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
<div class="container">
	<% String path = "http://192.168.35.142/music/musiclist";	 %>
<form id="rcFrm" method="POST" action="../musiclist/rcyProc.sm">
<input type="hidden" id="rcNo" name="rcNo" />
</form>
<br/>
<br/>
<h1 align="center" style="box-shadow:4px 4px 6px 4px"]><i><font color="#996633">LIST RESTORATION</font></i></h1>
<br/>
<br/>
<input type="button" class="btn btn-outline-success" value="메인으로" onclick="gMain()" />
<hr>
<!-- 장르 선택 테이블 -->
  <table class="genre"  align="center" width="930px">
  	<tr>
  		<td width="12.5%" align="center">
  			<a class="genre" href="<%=path%>/musicrecycle.sm?genre=">전체</a>
  		</td>
		<td width="12.5%" align="center">
			<a class="genre" href="<%=path%>/musicrecycle.sm?genre=발라드/댄스/팝">발라드/댄스/팝</a>
		</td>
		<td width="12.5%" align="center">
			<a class="genre" href="<%=path%>/musicrecycle.sm?genre=랩/힙합">랩/힙합</a>
		</td>  
		<td width="12.5%" align="center">
			<a class="genre" href="<%=path%>/musicrecycle.sm?genre=알앤비/소울">알앤비/소울</a>
		</td>  
		<td width="12.5%" align="center">
			<a class="genre" href="<%=path%>/musicrecycle.sm?genre=일렉트로닉">일렉트로닉</a>
		</td>  
		<td width="12.5%" align="center">
			<a class="genre" href="<%=path%>/musicrecycle.sm?genre=락/메탈">락/메탈</a>
		</td>  
		<td width="12.5%" align="center">
			<a class="genre" href="<%=path%>/musicrecycle.sm?genre=재즈">재즈</a>
		</td>
		<td width="12.5%" align="center">
			<a class="genre" href="<%=path%>/musicrecycle.sm?genre=인디">인디</a>
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
 		<td><b>복원</b></td>
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
	 		<td>
	 			<input type="button" class="btn btn-outline-primary" id="rcBtn_${test.no}" name="rcBtn" value="복원" 
	 			onclick="javascript:rcProc('${test.no}')" />
	 		</td>
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
				<a class="page-link" href="<%=path%>/musicrecycle.sm?nowPage=${PINFO.nowPage-1}&genre=${GENRE}">이전</a>
				</li>
			</c:if>
			<%-- [1][2][3]링크만들기 --%>
			<c:forEach var="page" begin="${PINFO.startPage}" end="${PINFO.endPage}">
				<li class="page-item">
				<a class="page-link" href="<%=path%>/musicrecycle.sm?nowPage=${page}&genre=${GENRE}">${page}</a>
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
				<a class="page-link" href="<%=path%>/musicrecycle.sm?nowPage=${PINFO.nowPage+1}&genre=${GENRE}">다음</a>
				</li>
			</c:if>
		</ul>
	</div>	
</div>
</body>
</html>