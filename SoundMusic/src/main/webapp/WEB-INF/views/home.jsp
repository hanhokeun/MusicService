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

	<a href="./member/LoginForm.sm">로그인-오라클연동</a>
	<p/>
	
	<a href="./fileBoard/boardList.sm">업로드 게시판(목록보기)</a>
	<p/><p/>	
	<a href="./notice/noticeList.sm">자유게시판(목록보기)</a>
</body>
</html>
