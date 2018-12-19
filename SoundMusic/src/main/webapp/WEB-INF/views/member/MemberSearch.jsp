<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>Insert title here</title>
 <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript">
  $(document).ready(function(){
		//Search버튼
		$("#sBtn").click(function(){			
			var search = document.getElementById("word").value; //로 사용가능
			if(search=="" || search.length==0){
				alert("검색어를  입력해주세요");
				document.getElementById("word").focus();				
				return; // 함수의 강제종료
			}
			$("#sForm").submit();
		});
});
  </script>
</head>
<body>
<a href="../member/MemberList.sm"><img src="../resources/images/admin.png" alt="사진"/></a>
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
  
  <%-- 검색기능 --%>
  	<form action="../member/MemberSearch.sm" method="post" id="sForm">		
		<table class="table table-bordered" align="center">
  			<tr>
  				<td align="center">
  				<!-- 검색대상 -->
  				<select name="target" id="target">
  					<option value="id">아이디</option>
  					<option value="name">이름</option>  				
  					<option value="both">아이디+이름</option>
  				</select>
  				<!-- 검색단어 -->
  				<input type="text" name="word" id="word"/>
  				<!-- 검색버튼 -->
  				<input type="button" id="sBtn" value="Search"/>
  				</td>
  			</tr>
  		</table>
  	</form>
        
  <table class="table table-bordered">
    <thead>
      <tr class>      	
        <th>회원번호</th>
        <th>회원아이디</th>
        <th>회원이름</th>
        <th>이메일</th>
        <th>가입일</th>
        <th>추방</th>        
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
  		<a class="page-link" href="../member/MemberSearch.sm?nowPage=${PINFO.nowPage-1}&target=${target}&word=${word}">Previous</a>
  		</c:if> 		
  		</li>
  		
  		<li class="page-item">
  		<%-- [1][2][3][4][5]--%>
  		<c:forEach var="page" begin="${PINFO.startPage}" end="${PINFO.endPage}">
  		 <a class="page-link" href="../member/MemberSearch.sm?nowPage=${page}&target=${target}&word=${word}">[${page}]</a>
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
  			<a class="page-link" href="../member/MemberSearch.sm?nowPage=${PINFO.nowPage+1}&target=${target}&word=${word}">Next</a>
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