<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--작성자: 장수경
	통계에 대한 게시글을 보여주는 폼
	댓글달기가 가능하다
	댓글의 삭제, 수정, 해당 게시글의 수정,삭제가 가능하도록 한다
	업로드한 파일에 대한 정보를 보여준다
 --%>
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
				$(location).attr('href','../static/staticList.sm?nowPage=${nowPage}')
			});
			//원글 수정하기
			$('#mBtn').click(function(){
				$(location).attr('href','../static/staticModifyForm.sm?oriNo=${VIEW.no}&nowPage=${nowPage}')
			});
			//원글 삭제하기
			$('#dBtn').click(function(){
				$('#imsiOriNo').val('${VIEW.no}');
				$('#imsiNowPage').val('${nowPage}');
				$('#imsiFrm').submit();
			});
			//댓글 수정폼 보여주기
			$('.rmBtn').click(function(){
				var button = $(this);
				var table=button.parents('table');
				var id=table.attr('id');
				$('#'+id).hide();
				var formid="frm"+id;
				$('#'+formid).show();
			});
			//댓글 수정처리
			$('.modifyB').click(function(){
				var form = $(this).parents("form");
				$(form).submit();
			});
			//댓글 삭제하기
			$('.rdBtn').click(function(){
				var reNo = $(this).attr('param');
				var pw = prompt('비밀번호를 입력해주세요')
				$('#tempReOriNo').val("${VIEW.no}");
				$('#tempRePw').val(pw);
				$('#tempReNo').val(reNo);
				$('#tempRenowPage').val("${nowPage}");
				$('#tempReFrm').submit();
			});
			//댓글 등록하기
			$('#wrBtn').click(function(){
				if($('#body').val()==""){
					alert('내용을 입력해주세요')
					$('#body').focus();
					return;
				}
				if($('#pw').val()==""){
					alert('비밀번호를 입력해주세요')
					$('#pw').focus();
					return;
				}
				$('#wrFrm').submit();
			})
		});
	</script>
</head>
<body>
  <%--상세보기 내용 출력 --%>
  <table border="1" width="700" align="center">
  	<tbody>
  		<tr align="center">
  			<th width="100">글번호</th>
  			<td width="50">${VIEW.no}</td>
  			<th width="100">조회수</th>
  			<td width="50">${VIEW.hit}</td>
  			<th>작성일</th>
  			<td>${VIEW.date}</td>
  		</tr>
  		<tr>
  			<th>노래 제목</th>
  			<td colspan="3">${VIEW.song}</td>
  			<th>가수 이름</th>
  			<td>${VIEW.artist}</td>
  		</tr>
  		<tr>
  			<th>제목</th>
  			<td colspan="5">${VIEW.title}</td>
  		</tr>
  		<tr>
  			<th>내용</th>
  			<td colspan="5" width="500">${VIEW.brBody}</td>
  		</tr>
  	</tbody>
  </table>
  <%-- 첨부파일 내용 출력 --%>
  <table width="700" border="1" align="center">
  	<c:forEach items="${FILE}" var="info">
  		<tr>
  			<td><img src="../upload/${info.saveName}" width="200" height="200"/></td>
  			<td><a href="../static/staticDownloadCount.sm?fileNo=${info.no}">${info.oriName} (${info.cnt}회 다운로드됨)</a></td>
  		</tr>
  	</c:forEach>
  </table>
 <%-- 기타기능.. 목록보기 --%>
  <table border="1" width="700" align="center">
  	<tbody>
  		<tr>
  			<td align="center">
	  			<input type="button" id="lBtn" value="목록보기"/>
	  			<%-- <c:if test="${sessionScope.UID eq 'admin'}">--%>
	  			<input type="button" id="mBtn" value="수정하기"/>
  				<input type="button" id="dBtn" value="삭제하기"/>
  			</td>
  			<%-- </c:if> --%>
  		</tr>
  	</tbody>
  </table>
  <%--댓글보기--%>
  <%--댓글이 존재하지 않는 경우 --%>
  <c:if test="${empty REPLY}">
  	<table border="1" width="700" align="center">
  		<tr>
  			<td align="center">새로운 댓글을 등록해주세요</td>
  		</tr>
  	</table>
  </c:if>
  <%--댓글이 존재하는 경우 댓글 수만큼 반복 출력 --%>
  <c:if test="${not empty REPLY}">
  	<c:forEach var="reply" items="${REPLY}">
  		<table border="1" id="${reply.no}"  width="700" align="center">
  			<tr>
  				<th width="100">글쓴이</th>
  				<td width="150">${reply.mId}</td>
  				<th width="100" >작성일</th>
  				<th width="200">${reply.date}</th>
  				<td><button type="button" class="button_like" width="50">
  					<i class="fa fa-heart"></i>
  				</button></td>
  			</tr>
  			<tr>
  				<th>내용</th>
  				<td colspan="3">${reply.brBody}</td>
  			<%-- <c:if test="${sessionScope.UID eq reply.mId }">--%>
  				<td align="center">
  					<input type="button" class="rmBtn" value="수정" param="${reply.no}"/>
  					<input type="button" class="rdBtn" value="삭제" param="${reply.no}"/>
  				</td>
  			<%-- </c:if>--%>
  		</table>
  <%--댓글 수정폼 --%>
		  <form id="frm${reply.no}" method="post" action="../static/staticReplyModify.sm" style="display:none;">
		  	<input type="hidden" name="no" value="${reply.no}"/>
		  	<input type="hidden" name="oriNo" value="${reply.oriNo}"/>
		  	<input type="hidden" name="nowPage" value="${nowPage}"/>
		  	<table border="1" width="700" align="center">
		  		<tr>
		  			<th>내용</th>
		  			<td colspan="2"><textarea name="body" id="body${reply.no}">${reply.body}</textarea>
		  		</td>
		  		<tr>
		  			<th>비밀번호</th>
		  			<td><input type="password" name="pw" id="pw${reply.no}"></td>
		  			<td><input type="button"  class="modifyB" value="수정"/></td>
		  		</tr>
		  	</table>
		  </form>
    	</c:forEach>
  </c:if>
  <%--댓글 쓰기 폼--%>
  <form id="wrFrm" method="post" action="../static/staticReplyWrite.sm">
  	<input type="hidden" id="oriNo" name="oriNo" value="${VIEW.no}">
  	<input type="hidden" id="nowPage" name="nowPage" value="${nowPage}">
  	<table border="1" width="700" align="center">
  		<tr>
  			<th>글내용</th>
  			<td><textarea name="body" id="body"></textarea></td>
  		</tr>
  		<tr>
  			<th>비밀번호</th>
  			<td><input type="password" name="pw" id="pw"/></td>
  		</tr>		
  		<tr><th colspan="2"><input type="button" value="글등록" id="wrBtn"/></th>
  	</table>
  </form>
  	<%--원글 삭제를 위한 임시 폼 --%>
	<form id="imsiFrm" method="post" action="../static/staticDelete.sm">
		<input type="hidden" name="oriNo" id="imsiOriNo"/>
		<input type="hidden" name="nowPage" id="imsiNowPage"/>
	</form>
	<%--댓글 삭제를 위한 임시 폼 --%>
	<form id="tempReFrm" method="post" action="../static/staticReplyDelete.sm">
		<input type="hidden" name="oriNo" id="tempReOriNo"/>
		<input type="hidden" name="pw" id="tempRePw"/>
		<input type="hidden" name="no" id="tempReNo"/>
		<input type="hidden" name="nowPage" id="tempRenowPage"/>
	</form>
</body>
</html>