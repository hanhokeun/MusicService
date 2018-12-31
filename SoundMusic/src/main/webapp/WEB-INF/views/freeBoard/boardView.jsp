<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">
<head>
<title>Document</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://fonts.googleapis.com/css?family=Poor+Story|Sunflower:300"
	rel="stylesheet">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet"	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
	$(function() {
		$("#lbtn").click(
				function() {
					$(location).attr("href",
							"../freeBoard/boardList.sm?nowPage=${nowPage}");
				})
		$("#mbtn")
				.click(
						function() {
							$(location)
									.attr("href",
											"../freeBoard/modifyForm.sm?nowPage=${nowPage}&oriNo=${VIEW.no}");
						})
		$("#dbtn").click(function() {
			$('#tform').attr("action", "../freeBoard/boardDelete.sm");
			$('#tform').submit();
		})

		//댓글 수정폼 보여주기
		$('.rmBtn').click(function() {
			var button = $(this);
			var table = button.parents('table');
			var id = table.attr('id');
			$('#' + id).hide();
			var formid = "frm" + id;
			$('#' + formid).show();
		});
		//댓글 수정처리
		$('.modifyB').click(function() {
			var form = $(this).parents("form");
			$(form).submit();
		});
		//댓글 삭제하기
		$('.rdBtn').click(function() {
			var reNo = $(this).attr('param');
			$('#tempReOriNo').val("${VIEW.no}");
			$('#tempReNo').val(reNo);
			$('#tempRenowPage').val("${nowPage}");
			$('#tempReFrm').submit();
		});
		//댓글 등록하기
		$('#wrBtn').click(function() {
			var id = '${sessionScope.UID}'; 
			if(id == null || id == ''){
				alert('로그인을 한 후에 이용해주세요')
			}
			if ($('#body').val() == "") {
				alert('내용을 입력해주세요')
				$('#body').focus();
				return;
			}
			$('#wrFrm').submit();
		});
	})
</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-10">
				<br>
				<%-- 상세보기 내용 출력 --%>
				<form id="tform" method="POST" encType="multipart/form-data">
					<input id="oriNo" name="oriNo" value="${VIEW.no}" type="hidden">
					<input id="nowPage" name="nowPage" value="${nowPage}" type="hidden">
				</form>
				<table class="table table-bordered">
					<tbody>
						<tr>
							<th width="100">글번호</th>
							<td width="600">${VIEW.no}</td>
						</tr>
						<tr>
							<th>작성자</th>
							<td>${VIEW.id}</td>
						</tr>
						<tr>
							<th>작성일</th>
							<td>${VIEW.date}</td>
						</tr>
						<tr>
							<th>조회수</th>
							<td>${VIEW.hit}</td>
						</tr>
						<tr>
							<th>제목</th>
							<td>${VIEW.title}</td>
						</tr>
						<tr>
							<th>내용</th>
							<td>${VIEW.br}</td>
						</tr>
					</tbody>
				</table>
				<%-- 첨부파일 내용 출력 --%>
				<table class="table table-bordered">
					<c:forEach var="info" items="${LIST}">
						<tr>
							<td><a href="../freeBoard/fileDownload.sm?fileNo=${info.no}">${info.oriName}</a>
								( ${info.co} Byte )</td>
						</tr>
					</c:forEach>
				</table>
				<%-- 기타기능 .. 목록 보기 --%>
				<table class="table table-bordered">
					<tbody>
						<tr>
							<td><input type="button" name="lbtn" id="lbtn" value="목록보기" />
								<!-- 로그인 한사람에게만 수정 삭제 버튼 보이기 --> 
								<c:if test="${sessionScope.UID eq VIEW.id or sessionScope.UID eq 'admin'}">
									<input type="button" name="dbtn" id="dbtn" value="삭제하기" />
									<input type="button" name="mbtn" id="mbtn" value="수정하기" />
								</c:if> </td>
						</tr>
					</tbody>
				</table>
				<br>
				<%--댓글보기--%>
				<%--댓글이 존재하지 않는 경우 --%>
				<c:if test="${empty REPLY}">
					<table align="center" class="table table-borderless">
						<tr>
							<td align="center">새로운 댓글을 등록해주세요</td>
						</tr>
					</table>
				</c:if>
				<%--댓글이 존재하는 경우 댓글 수만큼 반복 출력 --%>
				<c:if test="${not empty REPLY}">
					<c:forEach var="reply" items="${REPLY}">
						<table id="${reply.no}" align="center" class="table">
							<tr>
								<th>글쓴이</th>
								<td>${reply.id}</td>
								<th>작성일</th>
								<th>${reply.date}</th>
							</tr>
							<tr>
								<th>내용</th>
								<td colspan="2">${reply.body}</td>
								<c:if test="${sessionScope.UID eq (reply.id || 'admin') }">
									<td align="center"><input type="button" class="rmBtn"
										value="수정" param="${reply.no}" /> <input type="button"
										class="rdBtn" value="삭제" param="${reply.no}" /></td>
								</c:if>
						</table>
						<%--댓글 수정폼 --%>
						<form id="frm${reply.no}" method="post"
							action="../freeBoard/freeBoardRM.sm" style="display: none;">
							<input type="hidden" name="no" value="${reply.no}" /> <input
								type="hidden" name="oriNo" value="${reply.oriNo}" /> <input
								type="hidden" name="nowPage" value="${nowPage}" />
							<table align="center" class="table table-borderless">
								<tr>
									<th>내용</th>
									<td colspan="2"><textarea name="body"
											id="body ${reply.no}">${reply.body}</textarea></td>
								<tr>
									<td><input type="button" class="modifyB" value="수정" /></td>
								</tr>
							</table>
						</form>
					</c:forEach>
					<%-- 페이지 이동기능 --%>
					<table align="center" class="table">
						<tr>
							<td align="center">
								<%--이전링크 만들기--%> <c:if test="${RPAGE.startPage eq 1}">[이전]</c:if>
								<c:if test="${RPAGE.startPage ne 1}">
									<a
										href="../freeBoard/boardView.sm?rvPage=${RPAGE.rvPage-1}&nowPage=${nowPage}&oriNo=${VIEW.no}">[이전]</a>
								</c:if> <c:forEach var="page" begin="${RPAGE.startPage}"
									end="${RPAGE.endPage}">
									<a
										href="../freeBoard/boardView.sm?rvPage=${page}&nowPage=${nowPage}&oriNo=${VIEW.no}">[${page}]</a>
								</c:forEach> <%--다음링크 만들기--%> <c:if
									test="${RPAGE.endPage eq RPAGE.totalPage}">[다음]</c:if> <c:if
									test="${RPAGE.endPage ne RPAGE.totalPage}">
									<a
										href="../freeBoard/boardView.sm?rvPage=${RPAGE.rvPage+1}&nowPage=${nowPage}&oriNo=${VIEW.no}">[다음]</a>
								</c:if>
							</td>
						</tr>
					</table>
				</c:if>
				<%--댓글 쓰기 폼--%>
				<form id="wrFrm" method="post" action="../freeBoard/freeBoardRe.sm">
					<input type="hidden" id="oriNo" name="oriNo" value="${VIEW.no}">
					<input type="hidden" id="nowPage" name="nowPage" value="${nowPage}">
					<table align="center" class="table">
						<tr>
							<th>글내용</th>
							<td colspan="2">
								<div class="form-group">
									<textarea class="form-control" name="body" id="body"></textarea>
								</div>
							</td>
							<td>
								<button type="button" class="btn btn-outline-secondary btn-sm"
									id="wrBtn">댓글 등록</button>
							</td>
						</tr>
					</table>
				</form>
				<%--댓글 삭제를 위한 임시 폼 --%>
				<form id="tempReFrm" method="post"
					action="../freeBoard/freeBoardRD.sm">
					<input type="hidden" name="oriNo" id="tempReOriNo" /> 
					<input type="hidden" name="no" id="tempReNo" /> <input type="hidden"
						name="nowPage" id="tempRenowPage" />
				</form>
			</div>
		</div>
	</div>

	<div class="col-md-1"></div>
</body>
</html>
