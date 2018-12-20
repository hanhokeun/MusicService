<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<title>Document</title>
</head>
<script>
$(document).ready(function(){
	//목록보기
	$('#goList').click(function(){
		$(location).attr('href',"../musiclist/musiclist.sm?nowPage=${NOWPAGE}&genre=${GENRE}")
	});
});
//음악 수정하기
function mProc(){
	$('#a').submit();
}
//음악 삭제하기
function dProc(){
	confirm('정말 삭제하시겠습니까?')
	$('#d').submit();
}
//댓글쓰기
function rwProc(){
	if("${empty sessionScope.UID}"){
		alert('로그인을 한 후에 이용해주세요')
	}
	if($('#rvBody').val()=='' || $('#rvBody').val()== null){
		alert('내용을 입력해주세요')
		return false;
	}
	$('#reviewFrm').submit();
}
//수정폼 보여주기
function rmBtn(rno){
	$('#rmBtn_'+rno).hide();
	$('#reply_'+rno).attr('style','display:show;');
}
//수정하기
function rmProc(rno){
	if($('#rvmBody_'+rno).val()=='' || $('#rvmBody_'+rno).val()== null){
		alert('수정할 내용을 입력해주세요')
		$('#rvmBody_'+rno).focus();
		return false;
	}
	else{
		if(confirm('수정하시겠습니까?')) {
			$('#rvMProc_' + rno).submit();
		}
	}
}
//리뷰쓰기 취소하기
function rwCancel(){
	$('#rvBody').val('');
	$('#rvBody').focus();
}
//리뷰수정 취소하기
function rmcProc(rno){
	$('#reply_'+rno).attr('style','display:none;');
	$('#rvmBody_'+rno).val('');
	$('#rmBtn_'+rno).show();
}
//리뷰 삭제하기
function rdProc(rno){
	confirm('정말 삭제하시겠습니까?')
	$('#rvdFrm_'+rno).submit();
}
//추천기능
function likeProc(){
	if("${empty sessionScope.UID}"){
		alert('로그인을 한 후에 이용해주세요')
	}
	$('#c').submit();
}
</script>
<body>
<div class="container">
<% String path = "http://localhost:80/music/musiclist";	 %>
<form id="d" method="POST" action="../musiclist/musiclistdelete.sm?nowPage=${NOWPAGE}&mNo=${INFO.no}">
<input type="hidden" id="dNo" name="dNo" value="${INFO.no}" />
</form>
<form id="c" method="POST" action="../musiclist/updateStar.sm">
<input type="hidden" id="starNo" name="starNo" value="${INFO.no}" />
<input type="hidden" id="starId" name="starId" value="${list.writer}" />
<input type="hidden" id="sNowPage" name="sNowPage" value="${NOWPAGE}" />
<input type="hidden" id="sGenre" name="sGenre" value="${GENRE}" />
</form>
  	<!-- 이곳은 음악의 상세 정보를 표시하는 창
  	VO로부터 파라미터를 가져와서 표시할 예정  -->
<form id="a" method="POST" action="../musiclist/musiclistmodify.sm?nowPage=${NOWPAGE}&mNo=${INFO.no}">
<input type="hidden" id="mNo" name="mNo" value="${INFO.no}" />
<input type="hidden" id="genre" name="genre" value="${GENRE}" />
<input type="hidden" id="title" name="title" value="${INFO.title}" />
<input type="hidden" id="artist" name="artist" value="${INFO.artist}" />
<input type="hidden" id="album" name="album" value="${INFO.album}" />
<input type="hidden" id="path" name="path" value="${INFO.path}" />
<input type="hidden" id="lyrics" name="lyrics" value="${INFO.lyrics}" />
<input type="hidden" id="nowPage" name="nowPage" value="${NOWPAGE}" />

<span class="title">
	<h1 style="color:#3a3635;">${INFO.title}</h1>
</span>
<hr border="solid 0.3px #CCCCCC">
<table width="1000px">	
	<tr>
		<td rowspan="3" width="180px" height="180px">
			<img src="${INFO.path}" width="165px" height="165px">
		</td>
		<td>&nbsp;<font size="2.5pt" color="#3a3635">아티스트</font>&nbsp;&nbsp;&nbsp;&nbsp;${INFO.artist}</td>
	</tr>
	<tr>
		<td>&nbsp;<font size="2.5pt" color="#3a3635">앨범</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${INFO.album}</td>
	</tr>
	<tr>
		<td colspan="3">
			<br/>
			<br/>
			<input type="button" class="btn btn-info" id="goList" name="goList" value="목록으로">
			<input type="button" class="btn btn-success" id="like" name="like" 
			onclick="javascript:likeProc('${INFO.no}')" value="추천하기 ${INFO.star}">
			<c:if test="${ID eq 'admin'}">
			<input type="button" class="btn" onclick="mProc()" value="수정하기">
			<input type="button" class="btn" onclick="dProc()" value="삭제하기">	
			</c:if>
		</td>
	</tr>
</table>
<br/>
<div class="lyrics">
	<h2 style="color:#3a3635;">가사</h2>
	<hr>
	<span class="lyrics" style="color:#615e5d">
		${INFO.lyrics}
	</span>
</div>
</form>
<hr>
<!-- 음악에대한 댓글형 후기  -->
<!-- 후기쓰기 폼 -->
<form id=reviewFrm method="POST" action="../musiclist/rvWriteProc.sm"">
<input type="hidden" id="mrNo" name="mrNo" value="${INFO.no}" />
<input type="hidden" id="mrGenre" name="mrGenre" value="${GENRE}" />
<input type="hidden" id="mrNowPage" name="mrNowPage" value="${NOWPAGE}" />
	<table  class="table table-striped">
		<tr>
			<td colspan="2" align="left">
				<b><i>한마디</i></b>
			</td>
		</tr>
		<tr>
			<td>
				<textarea class="form-control" cols="100" rows="2" id="rvBody" name="rvBody" 
				style="resize:none;"></textarea>
			</td>
		</tr>
		<tr>
			<td>
				<input type="button" class="btn btn-primary pull-right" name="rwBtn" 
				onclick="rwProc()" value="글쓰기" />
				<input type="button" class="btn btn-secondary pull-right" name="rwcancel" 
				onclick="rwCancel()" value="취소" />
			</td>
		</tr>	
	</table>	
</form>
<!-- 후기 리스트-->
<table  class="table table-borderless">
<c:forEach var="list" items="${REVIEW}">
<tr>
	<td>
		<b>${list.writer}</b>
		<hr border="solid 0.5px #615e5d">
	</td>
	<td>
		${list.date}
	</td>
</tr>
<tr>
	<td>
		<font size="3pt">${list.body}</font>
	</td>
	<!-- 수정 버튼 -->
	<td>
	<c:if test="${list.writer eq (ID || 'admin')}">
	<button type="button" class="btn btn-primary" id="rmBtn_${list.rno}" name="rmBtn" 
	onclick="javascript:rmBtn('${list.rno}')">수정</button>
	<form id="rvdFrm_${list.rno}" method="POST" action="../musiclist/rvDelete.sm">
	<input type="hidden" name="rdNo" value="${INFO.no}" />
	<input type="hidden" name="rdNowPage" value="${NOWPAGE}" />
	<input type="hidden" name="rdPage" value="${RPAGE.rvPage}" />
	<input type="hidden" name="rvDno" value="${list.no}" />
	<input type="hidden" name="rdGenre" value="${GENRE}" />
	<!-- 삭제버튼 -->
	<button type="button" class="btn btn-dark" id="rdBtn_${list.rno}" name="rdBtn" 
	onclick="javascript:rdProc('${list.rno}')">삭제</button>
	</form>
	</c:if>
	</td>
</tr>
<tr>
	<td>
		<!-- 수정폼 -->
		<div class="rModify" id="reply_${list.rno}" style="display:none;">
		<form id="rvMProc_${list.rno}" method="POST" action="../musiclist/rvmProc.sm">
			<input type="hidden" name="mvNo" value="${INFO.no}" />
			<input type="hidden" name="rvNo" value="${list.no}" />	
			<input type="hidden" name="rnowPage" value="${NOWPAGE}" />
			<input type="hidden" name="rvPage" value="${RPAGE.rvPage}" />
			<input type="hidden" name="rvGenre" value="${GENRE}" />
			<input type="hidden" name="rmno" value="${list.rno}" />
			<table class="table table-borderless" id="rvmt${list.no}" width="70%" align="center">

				<tr>
					<td align="left">
						<b><i>수정하기</i></b>
					</td>
				</tr>
				<tr>
					<td>
						<textarea cols="100" rows="2" id="rvmBody_${list.rno}" name="rvmBody" style="resize:none;"></textarea>
					</td>
				</tr>	
				<tr>	
					<td>	
						<button type="button" class="btn btn-primary" name="mProc" 
						onclick="javascript:rmProc('${list.rno}')">수정</button>
						<button type="button" class="btn btn-dark" name="rdcBtn" 
						onclick="javascript:rmcProc('${list.rno}')">취소</button>
					</td>
				</tr>
			</table>
		</form>
		</div>
	</td>
</tr>
<tr>
	<td><hr style="border:solid 0.5px black;"></td>
</tr>		
</c:forEach>
</table>
	<ul class="pagination justify-content-center">
		<%-- 이전 링크 만들기 --%>
		<c:if test="${RPAGE.startPage eq 1}">
		<li class="page-item">
			<a class="page-link" href="#">이전</a>
		</li>	
		</c:if>
		<c:if test="${RPAGE.startPage ne 1}">
			<li class="page-item">
			<a class="page-link" href="<%=path%>/musicinfo.sm?nowPage=${NOWPAGE}&genre=${GENRE}&no=${INFO.no}&rvPage=${RPAGE.rvPage-1}">이전</a>
			</li>
		</c:if>
		<%-- [1][2][3]링크만들기 --%>
		<c:forEach var="page" begin="${RPAGE.startPage}" end="${RPAGE.endPage}">
			<li class="page-item">
			<a class="page-link" href="<%=path%>/musicinfo.sm?nowPage=${NOWPAGE}&genre=${GENRE}&no=${INFO.no}&rvPage=${page}">${page}</a>
			</li>
		</c:forEach>	
		<%-- 다음 링크 만들기 --%>
		<c:if test="${RPAGE.endPage eq RPAGE.totalPage}">
			<li class="page-item">
			<a class="page-link" href="#">다음</a>
			</li>
		</c:if>
		<c:if test="${RPAGE.endPage ne RPAGE.totalPage}">
			<li class="page-item">
			<a class="page-link" href="<%=path%>/musicinfo.sm?nowPage=${NOWPAGE}&genre=${GENRE}&no=${INFO.no}&rvPage=${RPAGE.rvPage+1}">다음</a>
			</li>
		</c:if>
	</ul>
</div>		
</body>
</html>