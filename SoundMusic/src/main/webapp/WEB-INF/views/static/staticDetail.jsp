<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--작성자: 장수경
	통계에 대한 게시글을 보여주는 폼
	댓글달기가 가능하다
	댓글의 삭제, 수정, 해당 게시글의 수정,삭제가 가능하도록 한다
	업로드한 파일에 대한 정보를 보여준다
 --%>
<!doctype html>
<html lang="en">
<head>
	<title>Document</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<!-- jQuery library -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<!-- Popper JS -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<!-- Latest compiled JavaScript -->	
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<style>
		.page {
		  padding: 15px  15px 15px 15px;
		}
		.bmd-modalButton {
		  display: block;
		}
		.close-button {
		  overflow: hidden;
		}
		.bmd-modalContent {
		  box-shadow: none;
		  background-color: transparent;
		  border: 0;
		}
		.bmd-modalContent .close {
		  font-size: 30px;
		  line-height: 30px;
		  padding: 7px 4px 7px 13px;
		  text-shadow: none;
		  opacity: .7;
		  color:#fff;
		}
		.bmd-modalContent .close span {
		  display: block;
		}
		.bmd-modalContent .close:hover,
		.bmd-modalContent .close:focus {
		  opacity: 1;
		  outline: none;
		}
		.bmd-modalContent iframe {
		  display: block;
		  margin: 0 auto;
		}
	</style>
	<script>
	var apiKey="AIzaSyCIDBmbgWL7cuxwMA0umIEFm5UjP_N1iQU";
	$.ajax({
		url:'https://www.googleapis.com/youtube/v3/search?key='+apiKey+'&part=id&maxResults=1&q="${VIEW.song}"',
		dataType:"json",
		success:function(data){
			$.each(data.items,function(key,value){
				$('#youtube').attr("src","https://www.youtube.com/embed/"+value.id.videoId);
/* 				var fragment=$(document.createDocumentFragment());
				fragment.append(['<iframe id="ytplayer" width=600" align="center" height="400" src="https://www.youtube.com/embed/'+value.id.videoId+'"frameborder="0"enablejsapi=1;allow="accelerometer; showinfo=0;encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>']);
				$('#youtube').append(fragment); */
			})
		}
	})
	</script>
	<script>
		(function($) {
		    
		    $.fn.bmdIframe = function( options ) {
		        var self = this;
		        var settings = $.extend({
		            classBtn: '.bmd-modalButton',
		            defaultW: 1000,
		            defaultH: 500
		        }, options );
		      
		        $(settings.classBtn).on('click', function(e) {
		          var allowFullscreen = $(this).attr('data-bmdVideoFullscreen') || false;
		          
		          var dataVideo = {
		            'src': $(this).attr('src'),
		            'height': $(this).attr('data-bmdHeight') || settings.defaultH,
		            'width': $(this).attr('data-bmdWidth') || settings.defaultW
		          };
		          
		          if ( allowFullscreen ) dataVideo.allowfullscreen = "";
		          
		          // stampiamo i nostri dati nell'iframe
		          $(self).find("iframe").attr(dataVideo);
		        });
		        // se si chiude la modale resettiamo i dati dell'iframe per impedire ad un video di continuare a riprodursi anche quando la modale è chiusa
		        this.on('hidden.bs.modal', function(){
		          $(this).find('iframe').html("").attr("src", "");
		        });
		        return this;
		    };
		  
		})(jQuery);
	</script>
	<script>
		$(document).ready(function(){
			$("#myModal").bmdIframe();
			//목록보기
			$('#lBtn').click(function(){
				$(location).attr('href','../static/staticList.sm?nowPage=${nowPage}')
			});
			//원글 수정하기
			$('#mBtn').click(function(){
				$(location).attr('href','../static/staticModifyForm.sm?oriNo=${VIEW.no}&nowPage=${nowPage}')
			});
			//원글 삭제하기
			$('#dBtn').click(function(){
				$('#imsiOriNo').val('${VIEW.no}');
				$('#imsiNowPage').val('${nowPage}');
				$('#imsiFrm').submit();
			});
			//댓글 수정폼 보여주기
			$('.rmBtn').click(function(){
				var button = $(this);
				var table=button.parents('table');
				var id=table.attr('id');
				$('#'+id).hide();
				var formid="frm"+id;
				$('#'+formid).show();
			});
			//댓글 수정처리
			$('.modifyB').click(function(){
				var form = $(this).parents("form");
				$(form).submit();
			});
			//댓글 삭제하기
			$('.rdBtn').click(function(){
				var reNo = $(this).attr('param');
				var pw = prompt('비밀번호를 입력해주세요')
				$('#tempReOriNo').val("${VIEW.no}");
				$('#tempRePw').val(pw);
				$('#tempReNo').val(reNo);
				$('#tempRenowPage').val("${nowPage}");
				$('#tempReFrm').submit();
			});
			//댓글 등록하기
			$('#wrBtn').click(function(){
				if($('#body').val()==""){
					alert('내용을 입력해주세요')
					$('#body').focus();
					return;
				}
				if($('#pw').val()==""){
					alert('비밀번호를 입력해주세요')
					$('#pw').focus();
					return;
				}
				$('#wrFrm').submit();
			})
		})
	</script>
</head>
<body>
  <%--상세보기 내용 출력 --%>
  <table border="1" width="700" align="center">
  	<tbody>
  		<tr align="center">
  			<th width="100">글번호</th>
  			<td width="50">${VIEW.no}</td>
  			<th width="100">조회수</th>
  			<td width="50">${VIEW.hit}</td>
  			<th width="100">작성일</th>
  			<td width="300">${VIEW.date}</td>
  		</tr>
  		<tr>
  			<th width="100">노래 제목</th>
  			<td colspan="3" width="300">${VIEW.song}</td>
  			<th width="100">가수 이름</th>
  			<td width="200">${VIEW.artist}</td>
  		</tr>
  		<tr>
  			<th width="100">제목</th>
  			<td colspan="4" width="450">${VIEW.title}</td>
  			<td width="150">
  				<div class="container">
        			<div class="row">
        				<div class="col-xs-12">
         				 	<div class="page">
            					<button type="button" id="youtube" class="bmd-modalButton" data-toggle="modal"  data-bmdWidth="400" data-bmdHeight="300" data-target="#myModal"  data-bmdVideoFullscreen="true">${VIEW.song} 동영상보기</button>           
      						</div>
        				</div>
      				</div>
      			</div>
      		</td>
  		</tr>
  		<tr>
  			<th width="100">내용</th>
  			<td colspan="6" width="600">${VIEW.brBody}</td>
      	</tr>
   	</tbody>
  </table>
  <%-- 첨부파일 내용 출력 --%>
  <table width="700" border="1" align="center">
  	<c:forEach items="${FILE}" var="info">
  		<tr>
  			<td><img src="../upload/${info.saveName}" width="500" height="300"/></td>
  			<td><a href="../static/staticDownloadCount.sm?fileNo=${info.no}">${info.oriName} (${info.cnt}회 다운로드됨)</a></td>
  		</tr>
  	</c:forEach>
  </table>
 <%-- 기타기능.. 목록보기 --%>
  <table border="1" width="700" align="center">
  	<tbody>
  		<tr>
  			<td align="center">
	  			<input type="button" id="lBtn" value="목록보기"/>
	  			<%-- <c:if test="${sessionScope.UID eq 'admin'}">--%>
	  			<input type="button" id="mBtn" value="수정하기"/>
  				<input type="button" id="dBtn" value="삭제하기"/>
  			</td>
  			<%-- </c:if> --%>
  		</tr>
  	</tbody>
  </table>
  <%--댓글보기--%>
  <%--댓글이 존재하지 않는 경우 --%>
  <c:if test="${empty REPLY}">
  	<table border="1" width="700" align="center">
  		<tr>
  			<td align="center">새로운 댓글을 등록해주세요</td>
  		</tr>
  	</table>
  </c:if>
  <%--댓글이 존재하는 경우 댓글 수만큼 반복 출력 --%>
  <c:if test="${not empty REPLY}">
  	<c:forEach var="reply" items="${REPLY}">
  		<table border="1" id="${reply.no}"  width="700" align="center">
  			<tr>
  				<th width="100">글쓴이</th>
  				<td width="150">${reply.mId}</td>
  				<th width="100" >작성일</th>
  				<th width="200">${reply.date}</th>
  				<td><button type="button" class="button_like" width="50">
  					<i class="fa fa-heart"></i>
  				</button></td>
  			</tr>
  			<tr>
  				<th>내용</th>
  				<td colspan="3">${reply.brBody}</td>
  			<%-- <c:if test="${sessionScope.UID eq reply.mId }">--%>
  				<td align="center">
  					<input type="button" class="rmBtn" value="수정" param="${reply.no}"/>
  					<input type="button" class="rdBtn" value="삭제" param="${reply.no}"/>
  				</td>
  			<%-- </c:if>--%>
  		</table>
  <%--댓글 수정폼 --%>
		  <form id="frm${reply.no}" method="post" action="../static/staticReplyModify.sm" style="display:none;">
		  	<input type="hidden" name="no" value="${reply.no}"/>
		  	<input type="hidden" name="oriNo" value="${reply.oriNo}"/>
		  	<input type="hidden" name="nowPage" value="${nowPage}"/>
		  	<table border="1" width="700" align="center">
		  		<tr>
		  			<th>내용</th>
		  			<td colspan="2"><textarea name="body" id="body${reply.no}">${reply.body}</textarea>
		  		</td>
		  		<tr>
		  			<th>비밀번호</th>
		  			<td><input type="password" name="pw" id="pw${reply.no}"></td>
		  			<td><input type="button"  class="modifyB" value="수정"/></td>
		  		</tr>
		  	</table>
		  </form>
    	</c:forEach>
    	  	<%-- 페이지 이동기능 --%>
	  	<table border="1" align="center" width="700">
	  		<tr>
	  			<td align="center">
		  			<%--이전링크 만들기--%>
		  			<c:if test="${RPAGE.startPage eq 1}">[<]</c:if>
		  			<c:if test="${RPAGE.startPage ne 1}">
		  				<a href="../static/staticDetail.sm?rvPage=${RPAGE.nowPage-1}&nowPage=${nowPage}&oriNo=${VIEW.no}">[<]</a></c:if>
		  			<c:forEach var="page" begin="${RPAGE.startPage}" end="${RPAGE.endPage}">
		  				<a href="../static/staticDetail.sm?rvPage=${page}&nowPage=${nowPage}&oriNo=${VIEW.no}">[${page}]</a>
		  			</c:forEach>
		  			<%--다음링크 만들기--%>
		  			<c:if test="${RPAGE.endPage eq RPAGE.totalPage}">[>]</c:if>
		  			<c:if test="${RPAGE.endPage ne RPAGE.totalPage}">
		  				<a href="../static/staticDetail.sm?rvPage=${RPAGE.endPage+1}&nowPage=${nowPage}&oriNo=${VIEW.no}">[>]</a>
		  			</c:if>
		  		</td>
	  		</tr>
	  	</table>
  </c:if>
  <%--댓글 쓰기 폼--%>
  <form id="wrFrm" method="post" action="../static/staticReplyWrite.sm">
  	<input type="hidden" id="oriNo" name="oriNo" value="${VIEW.no}">
  	<input type="hidden" id="nowPage" name="nowPage" value="${nowPage}">
  	<table border="1" width="700" align="center">
  		<tr>
  			<th>글내용</th>
  			<td><textarea name="body" id="body"></textarea></td>
  		</tr>
  		<tr>
  			<th>비밀번호</th>
  			<td><input type="password" name="pw" id="pw"/></td>
  		</tr>		
  		<tr><th colspan="2"><input type="button" value="글등록" id="wrBtn"/></th>
  	</table>
  </form>
  	<%--원글 삭제를 위한 임시 폼 --%>
	<form id="imsiFrm" method="post" action="../static/staticDelete.sm">
		<input type="hidden" name="oriNo" id="imsiOriNo"/>
		<input type="hidden" name="nowPage" id="imsiNowPage"/>
	</form>
	<%--댓글 삭제를 위한 임시 폼 --%>
	<form id="tempReFrm" method="post" action="../static/staticReplyDelete.sm">
		<input type="hidden" name="oriNo" id="tempReOriNo"/>
		<input type="hidden" name="pw" id="tempRePw"/>
		<input type="hidden" name="no" id="tempReNo"/>
		<input type="hidden" name="nowPage" id="tempRenowPage"/>
	</form>
	<footer>
		<div class="modal fade" id="myModal">
			<div class="modal-dialog">
				<div class="modal-content bmd-modalContent">
					<div class="modal-body">
          				<div class="close-button">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
         				</div>
          				<div class="embed-responsive embed-responsive-16by9">
					            <iframe class="embed-responsive-item" frameborder="0"></iframe>
          				</div>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
	</footer>
</body>
</html>