<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>Insert title here</title>
<script>
$(document).ready(function(){
	$('#aBtn').click(function(){
		//유효성 검사
		if($('#aTitle').val()==null || $('#aTitle').val()==''){
			alert('곡 이름을 입력해주세요!')
			$('#aTitle').focus();
			return false;
		}
		else if($('#aArtist').val()==null || $('#aArtist').val()==''){
			alert('아티스트를 입력해주세요!')
			$('#aArtist').focus();
			return false;
		}
		else if($('#aAlbum').val()==null || $('#aAlbum').val()==''){
			alert('앨범을 입력해주세요!')
			$('#aAlbum').focus();
			return false;
		}	
		else if($('#aImgpath').val()==null || $('#aImgpath').val()==''){
			alert('이미지 경로를 입력해주세요!')
			$('#aImgpath').focus();
			return false;
		}
		else if($('#aGenre').val()=='0'){
			alert('장르를 선택하세요!')
			$('#aGenre').focus();
			return false;
		}
		else if($('#aLyrics').val()==null || $('#aLyrics').val()==''){
			$('#aLyrics').val('가사없음')
		}
		$('#aForm').submit();
	})
})
</script>
</head>
<body>
<h1 align="center">음악리스트 추가</h1>
<form id=aForm method="POST" action="../musiclist/musiclistaddproc.sm">
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
				<textarea cols="46" id="aLyrics" name="aLyrics"></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" id="aBtn" value="추가하기"/>
				<input type="reset" id="rBtn" value="취소"/>
			</td>
		</tr>
	</table>
</form>
</body>
</html>