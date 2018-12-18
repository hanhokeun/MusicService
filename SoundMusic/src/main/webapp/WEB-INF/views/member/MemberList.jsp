<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  
</head>
<body>
<a href="../main.jsp"><img src="../resources/images/admin.png" alt="사진"/></a>
<div class="container">	
		<ul class="nav navbar-nav navbar-right">			
			<li><a href="../main.jsp"><span class="glyphicon glyphicon-log-in"></span> 나가기</a></li>
		</ul>	
  <div class="row">
  </br><hr></br>
 <ul class="nav nav-tabs nav-justified">
    <li class="active"><a href="#">회원관리</a></li>
    <li><a href="#">-</a></li>
    <li><a href="#">-</a></li>
    <li><a href="#">-</a></li>
  </ul></br></br>      
  <table class="table table-bordered">
    <thead>
      <tr class>      	
        <th>회원번호</th>
        <th>회원아이디</th>
        <th>회원이름</th>
        <th>이메일</th>
        <th>가입일</th>
        <th>삭제</th>        
      </tr>
    </thead>
    <tbody>
    	<c:forEach var="data" items="${LIST}" varStatus="status"> <%--REQ에서 가져온 LIST를 아이템에 입력, var는 내마음 --%>
      		<tr class="warning">      					
        		<td>${data.no}</td>
        		<td>${data.id}</td>
        		<td>${data.name}</td>
        		<td>${data.email}</td>
        		<td>${data.bam}</td>
        		<td><a href="./MemberDelete.sm?id=${data.id}">추방</a></td>        
      		</tr>
      	</c:forEach>     
    </tbody>
  </table>
  </br>
 <div class="text-center">
  <%-- 페이지 이동기능 --%>	  
  <nav aria-label="Page navigation example">
  	<ul class="pagination justify-content-center">
  		<li class="page-item disabled">
  		<%--[<] --%>
  		<%-- 현재페이지가 1인 경우 --%>
  		<c:if test="${PINFO.nowPage eq 1}">
  		<a class="page-link">Previous</a>
  		</c:if>
  		</li>
  		<li class="page-item">
  		<%-- 현재페이지가 1이 아닌 경우 --%>
  		<c:if test="${PINFO.nowPage ne 1}">
  		<a class="page-link" href="../member/MemberList.sm?nowPage=${PINFO.nowPage-1}">Previous</a>
  		</c:if> 		
  		</li>
  		
  		<li class="page-item">
  		<%-- [1][2][3][4][5]--%>
  		<c:forEach var="page" begin="${PINFO.startPage}" end="${PINFO.endPage}">
  		 <a class="page-link" href="../member/MemberList.sm?nowPage=${page}">[${page}]</a>
  		</c:forEach>
  		</li>
  		
  		<li class="page-item disabled">
  		<%--[>] --%>
  		<%-- 현재 보고 있는 페이지가 마지막페이지까지 갔으면 --%>
  		<c:if test="${PINFO.nowPage eq PINFO.totalPage}">
  			<a class="page-link">Next</a>
  		</c:if>
  		</li>
  		
  		<li class="page-item">
  		<c:if test="${PINFO.nowPage ne PINFO.totalPage}">
  			<a class="page-link" href="../member/MemberList.sm?nowPage=${PINFO.nowPage+1}">Next</a>
  		</c:if>
  		</li>
  		
   		</ul>
	</nav>
	</br><hr> 
	</div>
  </div>
 </div> 
</body>
</html>