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
	<link href="https://fonts.googleapis.com/css?family=Poor+Story|Sunflower:300" rel="stylesheet">
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="viewport" content="width=device-width, initial-scale=1">
 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<style>
		body{
			font-family: 'Poor Story', cursive;
			font-size: 17px;
		}
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
	//유튜브 API
		var apiKey="AIzaSyCIDBmbgWL7cuxwMA0umIEFm5UjP_N1iQU";
		$.ajax({
			url:'https://www.googleapis.com/youtube/v3/search?key='+apiKey+'&part=id&maxResults=1&q="${VIEW.song} ${VIEW.artist}"',
			dataType:"json",
			success:function(data){
				$.each(data.items,function(key,value){
					$('#youtube').attr("src","https://www.youtube.com/embed/"+value.id.videoId)
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
		          $(self).find("iframe").attr(dataVideo);
		        });
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
			});
		})
	</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-lg-1"></div>
			<div class="col-lg-10">
  			<%--상세보기 내용 출력 --%>
			  <table align="center" class="table">
			  	<tbody>
			  		<tr align="center">
			  			<td align="center"><b>글번호</b></td>
			  			<td>${VIEW.no}</td>
			  			<td align="center"><b>조회수</b></td>
			  			<td>${VIEW.hit}</td>
			  			<td align="center"><b>작성일/수정일</b></td>
			  			<td>${VIEW.date}</td>
			  		</tr>
			  		<tr>
			  			<td align="center"><b>노래 제목</b></td>
			  			<td colspan="3"  align="center">${VIEW.song}</td>
			  			<td align="center"><b>가수 이름</b></td>
			  			<td align="center">${VIEW.artist}</td>
			  		</tr>
			  		<tr>
			  			<td align="center"><b>제목</b></td>
			  			<td colspan="4" >${VIEW.title}</td>
			  			<td align="center">
			  				<div class="container">
			        			<div class="row">
			        				<div class="col-xs-12">
			         				 	<div class="page">
			            						<button type="button" id="youtube" class="bmd-modalButton" data-toggle="modal"  data-bmdWidth="600" data-bmdHeight="400" data-target="#myModal"  data-bmdVideoFullscreen="true">${VIEW.song} 영상보기</button>           
			      						</div>
			        				</div>
			      				</div>
			      			</div>
			      		</td>
			  		</tr>
			  		<tr>
			  			<td align="center"><b>내용</b></td>
			  			<td colspan="6">${VIEW.brBody}</td>
			      	</tr>
			   	</tbody>
			  </table>
			  <%-- 첨부파일 내용 출력 --%>
			  <table align="center" class="table">
			  	<c:forEach items="${FILE}" var="info">
			  		<tr>
			  			<td><img src="../upload/${info.saveName}" width="500" height="300" class="mx-auto d-block"/></td>
			  			<td><a href="../static/staticDownloadCount.sm?fileNo=${info.no}">${info.oriName}<br/>(${info.cnt}회 다운)</a></td>
			  		</tr>
			  	</c:forEach>
			  </table>
			 <%-- 기타기능.. 목록보기 --%>
			 <div class="container">
				  <table align="center" class="table-borderless">
				  	<tbody>
				  		<tr>
				  			<td align="center">
				  				<div class="btn-group">
					  				<button type="button" class="btn btn-light btn-sm" id="lBtn" >목록보기</button>
					  			<%-- <c:if test="${sessionScope.UID eq 'admin'}">--%>
							  			<button type="button" class="btn btn-light btn-sm" id="mBtn" >수정하기</button>
							  			<button type="button" class="btn btn-light btn-sm" id="dBtn" >삭제하기</button>
						  		</div>
					  			<%-- </c:if> --%>
				  			</td>
				  		</tr>
				  	</tbody>
				  </table>
			  </div>
			  <%--댓글보기--%>
			  <%--댓글이 존재하지 않는 경우 --%>
			  <c:if test="${empty REPLY}">
			  	<table align="center" class="table">
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
			  				<td>${reply.mId}</td>
			  				<th>작성일</th>
			  				<th>${reply.date}</th>
			  			</tr>
			  			<tr>
			  				<th>내용</th>
			  				<td colspan="2">${reply.brBody}</td>
			  			<c:if test="${sessionScope.UID eq (reply.mId || 'admin') }">
			  				<td align="center">
			  					<input type="button" class="rmBtn" value="수정" param="${reply.no}"/>
			  					<input type="button" class="rdBtn" value="삭제" param="${reply.no}"/>
			  				</td>
			  			</c:if>
			  		</table>
			  <%--댓글 수정폼 --%>
					  <form id="frm${reply.no}" method="post" action="../static/staticReplyModify.sm" style="display:none;">
					  	<input type="hidden" name="no" value="${reply.no}"/>
					  	<input type="hidden" name="oriNo" value="${reply.oriNo}"/>
					  	<input type="hidden" name="nowPage" value="${nowPage}"/>
					  	<table align="center" class="table">
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
				  	<table align="center"  class="table">
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
			  	<table align="center" class="table">
					<tr>
					  	<th>글내용</th>
				  		<td colspan="2">
				  			<div class="form-group">
				  				<textarea  class="form-control" name="body" id="body"></textarea>
				  			</div>
				  		</td>
					</tr>
			  		<tr>
			  			<th>비밀번호</th>
			  			<td><input type="password" name="pw" id="pw" class="form-control form-control-sm"/></td>
			  			<td>
			  				<button  type="button" class="btn btn-outline-secondary btn-sm" id="wrBtn">댓글 등록</button>
			  			</td>
			  		</tr>		
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
						<div class="modal-dialog modal-lg">
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
			</div>
			<div class="col-lg-1"></div>
		</div>
	</div>
</body>
</html>