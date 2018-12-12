<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>

	<a href="./member/LoginForm.sm">login-</a>
	<p/>
	
	<a href="./fileBoard/boardList.sm">fileBoard(목록보기)</a>
	<p/><p/>	
	<a href="./notice/noticeList.sm">freeBoard(목록보기)</a>
</body>
</html>
