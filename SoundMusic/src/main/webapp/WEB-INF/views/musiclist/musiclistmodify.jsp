<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
function mProc(){
	$('#mForm').submit();
}
function gMain(){
	$(location).attr('href','../musiclist/musiclist.sm')
}
</script>
</head>
<body>
<div class="container">
	<div class="row">
		<div class="col-md-2"></div>
		<div class="col-md-8">
<br/>
<br/>
<br/>		
<h1 align="center" style="box-shadow:4px 4px 6px 4px"]><i><font color="#9999FF">MODIFY LIST</font></i></h1>
<br/>
<br/>
<form id=mForm method="POST" action="../musiclist/musiclistmodifyproc.sm">
	<input type="hidden" name="mNo" value="${LIST.no}" />
	<input type="hidden" name="nowPage" value="${LIST.nowPage}" />
	<table class="table table-striped" align="center">
		<tr>
			<th width="48%">곡명</th>
			<td>
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
				<textarea class="form-control" cols="46" rows="5" id="mLyrics" name="mLyrics" style="resize:none;">${LIST.lyrics}</textarea>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" onclick="mProc()" value="수정하기"/>
				<input type="reset" id="rBtn" value="취소"/>
				<input type="button" id="goList" name="goList" value="메인으로" onclick="gMain()" />
			</td>
		</tr>
	</table>
</form>
	</div>
	<div class="col-md-2"></div>
	</div>
</div>
</body>
</html>