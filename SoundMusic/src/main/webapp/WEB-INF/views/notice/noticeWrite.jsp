<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
	<title>Document</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script>
	$(function(){
		var count=1;
		//id="sBtn" value ="글쓰기"
		$('#sBtn').click(function(){
			if(title==''){
				alert('제목을 입력해 주세요.')
			}
			$('#wForm').submit();
		})

		//첨부파일 추가버튼 id = 'aBtn'value =추가 
		//e동적 추가 버튼
		$("#aBtn").click(function(){
			//할일
			count++;// 추가할 때 마다 1씩 증가
			//업로드 파일 최대 갯수 제한 걸거임
			if(count==6){
				alert("더 이상 파일을 첨부할 수 없습니다.")
				count=5;
				return;
			}
			//추가할 폼
			var tr = "<tr><th>첨부파일</th><td><input type='file' name='files"+count+"' id='files"+count+"'/></td></tr>"
			//원하는 위치에 추가한다.
			$("#copy").before(tr);
			//원하는 위치를 먼저 찾고 ( id가 copy인 element => <tr></tr>)
			//추가하는 기능 을 추가한다.
			
		})
		
		//첨부파일 삭제 버튼 dBtn , 삭제 동적 제거
		$("#dBtn").click(function(){
			$('#files'+count).parents('tr').remove()
                count--;
                if(count==0){
                    alert('제거할 수 있는 첨부 파일이 없습니다.')
                    count=1;
                    return;
                }
		})
		$("#hBtn").click(function(){
				$(location).attr("href","../index.sm");
			})
	
			
	})
	!function(t){t.fn.snowit=function(a){var e=t('<div class="lis-flake" />').css({top:"-50px",position:"fixed"}).html("&#9836;"),n=t(document).height();documentWidth=t(document).width(),defaults={minSize:10,maxSize:20,total:25,speed:n/105,flakeColor:"#FFFFFF"},a=t.extend({},defaults,a),inStyle="<style>body { position: relative; }.lis-flake { position: absolute; color:#ff0000;}.lis-flake:nth-child(odd) {-moz-animation:snow1 "+a.speed+"s linear infinite;-webkit-animation:snow1 "+a.speed+"s linear infinite;animation:snow1 "+a.speed+"s linear infinite}.lis-flake:nth-child(even) {-moz-animation:snow2 "+(a.speed-a.speed/8)+"s linear infinite;-webkit-animation:snow2 "+(a.speed-a.speed/8)+"s linear infinite;animation:snow2 "+(a.speed-a.speed/8)+"s linear infinite}@-moz-keyframes snow1{0%{-moz-transform:translate(-250, 0);opacity:1}100%{-moz-transform:translate(250px, "+n+"px);opacity:0}}@-webkit-keyframes snow1{0%{-webkit-transform:translate(-250, 0);opacity:1}100%{-webkit-transform:translate(250px, "+n+"px);opacity:0}}@keyframes snow1{0%{transform:translate(-250, 0);opacity:1}100%{transform:translate(250px, "+n+"px);opacity:0}}@-moz-keyframes snow2{0%{-moz-transform:translate(0, 0);opacity:1}100%{-moz-transform:translate(0, "+n+"px);opacity:0.2}}@-webkit-keyframes snow2{0%{-webkit-transform:translate(0, 0);opacity:1}100%{-webkit-transform:translate(0, "+n+"px);opacity:0.2}}@keyframes snow2{0%{transform:translate(0, 0);opacity:1}100%{transform:translate(0, "+n+"px);opacity:0.2}}</style>";var i=function(){var i=Math.random()*documentWidth-250,o=0-(Math.random()*n-40);startOpacity=.8*Math.random(),num=parseInt(t(".lis-flake").length)+1,sizeFlake=a.minSize+Math.random()*a.maxSize,e.attr("num",num).clone().appendTo("body").css({left:i,top:o,opacity:startOpacity,"font-size":sizeFlake,color:a.flakeColor})};t("head").append(inStyle);for(var o=1;o<=a.total;o++)i()}}(jQuery);
	</script>
	</head>
<body>
<%-- 글쓰기 폼을 보여주자 파일업로드가 포함 .. 스트림방식으로 처리할 수 있도록
	encType="multipart/form-data를 지정해야한다. --%>
  <h1>글쓰기 폼이다</h1>
  <script>
        $.fn.snowit({ flakeColor:'#F00',minSize:12,maxSize:22,total:200 });//total 숫자 높을수록 폭설, 숫자 1000을 넘기지마세요
    </script>
  <form id="wForm" method="post" action="../notice/noticeProc.sm" encType="multipart/form-data">
  	<table border="1" width="700"align="center">
  		<tr>
  			<th>글쓴이</th>
  			<td><input type='text' name ="writer" id="writer"></td>
  		</tr>
  		<tr>
  			<th>제목</th>
  			<td><input type='text' name ="title" id="title"></td>
  		</tr>
  		<tr>
  			<th>본문</th>
  			<td><textarea rows="10" cols="20" name="content" id ="content"></textarea></td>
  		</tr>
  		<tr>
  			
  		</tr>
  		<tr>
  			<th>첨부파일</th>
  			<td><input type='button' id="aBtn" value="추가">
  				<input type='button' id="dBtn" value="삭제">
  			</td>
  		</tr>
  		<tr>
  			<th>첨부파일</th>
  			<td><input type='file' name="files" id="files"></td>
  		</tr>
  		<tr id="copy">
  			<td colspan="2"><input type="button" id="sBtn" value="글쓰기">
  					<input type="button" name="hBtn" id="hBtn" value="홈으로"/>
  			</td>
  			
  		</tr>	
  	</table>
  </form>
  
</body>
</html>
