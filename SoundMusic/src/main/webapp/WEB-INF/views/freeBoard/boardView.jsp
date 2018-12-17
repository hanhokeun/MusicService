<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
<title>Document</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
		$(function(){
			$("#lbtn").click(function(){
				$(location).attr("href","../freeBoard/boardList.sm?nowPage=${nowPage}");
			})
			$("#mbtn").click(function(){
				$(location).attr("href","../freeBoard/modifyForm.sm?nowPage=${nowPage}&oriNo=${VIEW.no}");			})
			$("#dbtn").click(function(){
				$('#tform').attr("action","../freeBoard/boardDelete.sm");
				$('#tform').submit();
			})
		})
	</script>
	</head>
<body>
  <%-- 상세보기 내용 출력 --%>
  <form id="tform" method="POST" encType="multipart/form-data">
  	<input id="oriNo" name="oriNo" value="${VIEW.no}" type="hidden" >
  	<input id="nowPage" name="nowPage" value="${nowPage}" type="hidden" >
  </form>
  <table width="700"border="1" align="center">
  	<tbody>
  		<tr>
  			<th width="100">글번호</th>
  			<td width="600">${VIEW.no}</td>
  		</tr>
  		<tr>
  			<th>작성자</th>
  			<td>${VIEW.id}</td>
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
  			<td>${VIEW.br}</td>
  		</tr>  		
  	</tbody>
  </table>
  <%-- 첨부파일 내용 출력 --%>
 <table width="700" border="1" align="center">
     <c:forEach var="info" items="${LIST}">
         <tr>
             <td>
                 <a href="../freeBoard/fileDownload.sm?fileNo=${info.no}">${info.oriName}</a> ( ${info.co} Byte )
             </td>
         </tr>
     </c:forEach>
 </table>
  <%-- 기타기능 .. 목록 보기 --%>
  <table width="700" border="1" align="center">
  	<tbody>
  		<tr>
  			<td>
  				<input type="button" name="lbtn"id="lbtn" value ="목록보기"/>
  				<!-- 로그인 한사람에게만 수정 삭제 버튼 보이기 -->
  				<c:if test="${sessionScope.UID eq VIEW.id}">
  				<input type="button" name="dbtn"id="dbtn" value ="삭제하기"/>
  				<input type="button" name="mbtn"id="mbtn" value ="수정하기"/>
  				</c:if>
  			</td>
  		</tr>
  	</tbody>
  </table>
</body>
</html>
