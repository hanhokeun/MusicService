<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
function mProc(){
	$('#mForm').submit();
}
</script>
</head>
<body>
<h1 align="center">음악리스트 수정</h1>
<form id=mForm method="POST" action="../musiclist/musiclistmodifyproc.sm">
	<input type="hidden" name="mNo" value="${LIST.no}" />
	<input type="hidden" name="nowPage" value="${LIST.nowPage}" />
	<table border="1" align="center" width="450">
		<tr>
			<th>곡명</th>
			<td width="30%">
				<input type="text" id="mTitle" name="mTitle" size="45" value="${LIST.title}"/>			
			</td>
		</tr>
		<tr>
			<th>아티스트</th>
			<td><input type="text" id="mArtist" name="mArtist" size="45" value="${LIST.artist}"/></td>
		</tr>
		<tr>
			<th>앨범</th>
			<td><input type="text" id="mAlbum" name="mAlbum" size="45" value="${LIST.album}"/></td>
		</tr>
		<tr>
			<th>이미지</th>
			<td><input type="text" id="mImgpath" name="mImgpath" size="45" value="${LIST.path}" /></td>
		</tr>
		<tr>
			<th>장르</th>
			<td>
				<select id="mGenre" name="mGenre">
					<option value="0">--필수!선택하세요--</option>
					<option value="발라드/댄스/팝">발라드/댄스/팝</option>
					<option value="랩/힙합">랩/힙합</option>
					<option value="알앤비/소울">알앤비/소울</option>
					<option value="일렉트로닉">일렉트로닉</option>
					<option value="락/메탈">락/메탈</option>
					<option value="재즈">재즈</option>
					<option value="인디">인디</option>
				</select>			
			</td>
		</tr>
		<tr>
			<th>가사</th>
			<td>
				<textarea cols="46" id="mLyrics" name="mLyrics">${LIST.lyrics}</textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" onclick="mProc()" value="수정하기"/>
				<input type="reset" id="rBtn" value="취소"/>
			</td>
		</tr>
	</table>
</form>
</body>
</html>