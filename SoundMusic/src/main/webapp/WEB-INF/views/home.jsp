<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html lang="en">
<head>
	<title>Home</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>

	<a href="./member/LoginForm.sm">login-</a>
	<p/>
	
	<a href="./freeBoard/boardList.sm">freeBoard(가즈아)</a>
	<p/><p/>	
	<a href="./notice/noticeList.sm">noticeBoard(go)</a>
</body>
</html>
