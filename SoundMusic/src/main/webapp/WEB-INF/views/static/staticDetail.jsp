<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
	<title>Document</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
		$(document).ready(function(){
			//목록보기
			$('#lBtn').click(function(){
				
			});
		});
	</script>
</head>
<body>
  <%--상세보기 내용 출력 --%>
  <table border="1" width="700" align="center">
  	<tbody>
  		<tr>
  			<th width="100">글번호</th>
  			<td width="600">${VIEW.no}</td>
  		</tr>
  		<tr>
  			<th>작성일</th>
  			<td>${VIEW.date}</td>
  		</tr>
  		<tr>
  			<th>조회수</th>
  			<td>${VIEW.hit}</td>
  		</tr>
  		<tr>
  			<th>제목</th>
  			<td>${VIEW.title}</td>
  		</tr>
  		<tr>
  			<th>내용</th>
  			<td>${VIEW.body}</td>
  		</tr>
  	</tbody>
  </table>
  <%-- 첨부파일 내용 출력 --%>
  <table width="700" border="1" align="center">
  	<c:forEach items="${LIST}" var="info">
  		<tr>
  			<td>${info.oriName}( ${info.len}Byte )</td>
  		</tr>
  	</c:forEach>
  </table>
  <%--댓글보기--%>
  <%--댓글이 존재하지 않는 경우 --%>
  <c:if test="${empty REPLY }">
  	<table>
  		<tr>
  			<td align="center">새로운 댓글을 등록해주세요</td>
  		</tr>
  	</table>
  </c:if>
  <%--댓글이 존재하는 경우 댓글 수만큼 반복 출력 --%>
  <c:if test="${not empty REPLY}">
  	<c:forEach var="reply" items="${REPLY}">
  		<table id="${reply.no}"  width="700" >
  			<tr>
  				<th width="50">댓글번호</th>
  				<td width="50">${reply.no}</td>
  				<th width="50">글쓴이</th>
  				<td width="150">${reply.writer}</td>
  				<th width="50">작성일</th>
  				<th width="300">${reply.date}</th>
  				<button type="button" class="button_like" width="50">
  					<i class="fa fa-heart"></i>
  				</button>
  			</tr>
  			<tr>
  				<th>내용</th>
  				<td colspan="3">${reply.brBody}</td>
  				<td><img src="" id=""/></td>
  			</tr>
  		</table>
  	</c:forEach>
  </c:if>
  <table></table>
  <%-- 기타기능.. 목록보기 --%>
  <table border="1" width="700" align="center">
  	<tbody>
  		<tr>
  			<td align="center"><input type="button" id="lBtn" value="목록보기"/></td>
  			<td align="center"><input type="button" id="eBtn" value="수정하기"/></td>
  			<td align="center"><input type="button" id="dBtn" value="삭제하기"/></td>
  		</tr>
  	</tbody>
  </table>
  	<%--원글 삭제를 위한 임시 폼 --%>
	<form id="imsiFrm" method="post" action="../static/staticDelete.sm">
		<input type="hidden" name="oriNo" id="imsiOriNo"/>	
	</form>
	<%--댓글 삭제를 위한 임시 폼 --%>
	<form id="tempReFrm" method="post" action="../static/staticReplyDelete.sm">
		<input type="hidden" name="oriNo" id="tempReOriNo"/>
		<input type="hidden" name="pw" id="tempRePw"/>
		<input type="hidden" name="reNo" id="tempReNo"/>
		<input type="hidden" name="nowPage" id="tempRenowPage"/>
	</form>
</body>
</html>