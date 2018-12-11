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
	$('#sValue').click(function(){
		$('#sValue').val("");
	})
})
function getView(nowPage,no){
	$('#no').val(no);
	$('#nowPage').val(nowPage);
	$('#mView').submit();
}
</script>	
</head>
<body>
  <h1>음악 전체 리스트</h1>
  ${PINFO.startPage}<br/>
  ${PINFO.getEndPage()}<br/>
  
  <!-- 검색창  -->
<form id="sForm" method="get" action="#">

	<table width="70%" cellpadding="0px" align="center">
		<tr>
			<td colspan="3" align="right">
				<select name="sub">
					<option value="0">---선택하세요---</option>
					<option value="1">곡</option>
					<option value="2">아티스트</option>
					<option value="3">앨범</option>
				</select>
				<input type="text" id="sValue" name="sValue" value="검색어를 입력해주세요"/>
				<input type="button" id="sBtn" name="sBtn" value="검색"/>
			</td>
		</tr>
	</table>
</form>
<form id="mView" method="get" action="../musiclist/musicinfo.sm">
	<input type="hidden" id="nowPage" name="nowPage"/>
	<input type="hidden" id="no" name="no" />
</form>
  <!-- 리스트  -->
 <table border="1" width="70%" align="center">
 	<tr>
 		<td colspan="2"><b>곡</b></td>
 		<td><b>아티스트</b></td>
 		<td><b>앨범</b></td>
 		<td><b>추천수</b></td>
 	</tr>
 	<c:forEach var="test" items="${LIST}" begin="0" end="100" step="1">
 	<tr>
 		<td><img src="${test.path}" width="50px" height="50px"></td>
 		<td>
 			<a href="javascript:void(0);" onclick="javascript:getView('1','${test.no}')">${test.title}</a>
 		</td>
 		<td>${test.artist}</td>
 		<td>${test.album}</td>
 		<td>${test.star}</td>
 	</tr>
 	</c:forEach>
 	<table border="1" width="45%" align="center">
		<tr>
			<td align="center">
			<%-- 이전 링크 만들기 --%>
			<c:if test="${PINFO.startPage eq 1}">
				[이전]
			</c:if>
			<c:if test="${PINFO.startPage ne 1}">
				<a href="../musiclist/musiclist.sm?nowPage=${PINFO.startPage-1}">[이전]</a>
			</c:if>
			<%-- [1][2][3]링크만들기 --%>
			<c:forEach var="page" begin="${PINFO.startPage}" end="${PINFO.endPage}">
				<a href="../musiclist/musiclist.sm?nowPage=${page}">[${page}]</a>
			</c:forEach>	
			<%-- 다음 링크 만들기 --%>
			<c:if test="${PINFO.endPage eq PINFO.totalPage}">
				[다음]
			</c:if>
			<c:if test="${PINFO.endPage ne PINFO.totalPage}">
				<a href="../musiclist/musiclist.sm?nowPage=${PINFO.endPage+1}">[다음]</a>
			</c:if>
			</td>		
		</tr>
	</table>	
 </table>
</body>
</html>
