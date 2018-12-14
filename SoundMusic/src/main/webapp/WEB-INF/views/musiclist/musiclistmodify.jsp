<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1 align="center">음악리스트 수정</h1>
<form id=aForm method="POST" action="#">
	<table border="1" align="center" width="450">
		<tr>
			<th>곡명</th>
			<td width="30%">
				<input type="text" id="aTitle" name="aTitle" size="45"/>			
			</td>
		</tr>
		<tr>
			<th>아티스트</th>
			<td><input type="text" id="aArtist" name="aArtist" size="45" /></td>
		</tr>
		<tr>
			<th>앨범</th>
			<td><input type="text" id="aAlbum" name="aAlbum" size="45" /></td>
		</tr>
		<tr>
			<th>이미지</th>
			<td><input type="text" id="aImgpath" name="aImgpath" size="45" /></td>
		</tr>
		<tr>
			<th>장르</th>
			<td>
				<select id="aGenre" name="aGenre">
					<option value="0">--필수!선택하세요--</option>
					<option value="1">발라드/댄스/팝</option>
					<option value="2">랩/힙합</option>
					<option value="3">알앤비/소울</option>
					<option value="4">일렉트로닉</option>
					<option value="5">락/메탈</option>
					<option value="6">재즈</option>
					<option value="7">인디</option>
				</select>			
			</td>
		</tr>
		<tr>
			<th>가사</th>
			<td>
				<textarea cols="46"></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" id="mBtn" value="수정하기"/>
				<input type="reset" id="rBtn" value="취소"/>
			</td>
		</tr>
	</table>
</form>
</body>
</html>