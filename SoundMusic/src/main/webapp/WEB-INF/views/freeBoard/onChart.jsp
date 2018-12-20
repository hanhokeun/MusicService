<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<style>
table {
  border-collapse: collapse;
  width: 100%;
}

th, td {
  text-align: left;
  padding: 8px;
}

tr:nth-child(even) {background-color: #f2f2f2;}
#customers {
  font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

#customers td, #customers th {
  border: 1px solid #ddd;
  padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #4CAF50;
  color: white;
}
</style>
<div class="container">
<div class="row">
	<div class="col-md-12">
	</div>
</div>

	<div class="row">
		<div class="col-md-1"></div>
		
			<div class="col-md-4">
			<h3 align="center">Bugs onChart</h3>
				<table >
					<tr align="center">
						<th>순위</th>						
						<th>이미지</th>				
						<th>제목</th>						
						<th>가수</th>					
						<th>앨범</th>						
					</tr>
						<c:forEach var="list" items="${LIST}">
							<tr>						
								<td>${list.rank}</td>
							
								<td><img src="${list.imgsrc}"/></td>
													
								<td>${list.title}</td>
													
								<td>${list.singer}</td>
													
								<td>${list.album}</td>
							</tr>					
						</c:forEach>
					</table>
				</div>
				<div class="col-md-2"></div>
				<div class="col-md-4">
					<h3 align="center">Mnet onChart</h3>
					<table>
						<tr align="center">
							<th>순위</th>
						
							<th>이미지</th>
						
							<th>제목</th>
						
							<th>가수</th>
						
							<th>앨범</th>
						</tr>
					<c:forEach var="list2" items="${LIST2}">
						<tr>						
							<td>${list2.rank}</td>
						
							<td><img src="${list2.imgsrc}"/></td>
												
							<td>${list2.title}</td>
												
							<td>${list2.singer}</td>
												
							<td>${list2.album}</td>
						</tr>						
					</c:forEach>					
				</table>
			</div>
		<div class="col-md-1"></div>
	</div>	
</div>
</body>
</html>