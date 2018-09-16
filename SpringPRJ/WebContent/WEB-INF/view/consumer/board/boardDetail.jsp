<!-- 홍두표테스트 -->
<%@page import="poly.dto.consumer.CONSUMER_BoardRepleDTO"%>
<%@page import="java.util.List"%>
<%@page import="poly.dto.consumer.CONSUMER_BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
		CONSUMER_BoardDTO bDTO = (CONSUMER_BoardDTO)request.getAttribute("bDTO");
		List<CONSUMER_BoardRepleDTO> rList = (List<CONSUMER_BoardRepleDTO>)request.getAttribute("rList");
	%>
<html>
<head>
<title>트럭왔냠 - 게시판 상세보기</title>
<%@ include file="/WEB-INF/view/consumer/topCssScript.jsp" %>
<script type="text/javascript">
	function deleteBoard(boardPSeq){
		location.href="/consumer/board/boardDelete.do?boardPSeq=" + boardPSeq;
	}

</script>
  <script>
/* $(function (){
	  
  }) */
		
		//댓글 Ajax
    	function ajaxTest(){
    		var content = $('#contentAjax').val();
    		var boardPSeq = $('#boardPSeqAjax').val();
    		var userSeq	 = $('#userSeqAjax').val();
    		
    		$.ajax({
    			type:'post',
    			url: "/consumer/board/reple.do",
    			data: {
    				'content':content,
    				'boardPSeq':boardPSeq,
    				'userSeq':userSeq
    			},
    			success: function(data) {
    				console.log(data);
    				var contents ='';
                    
                    $.each(data,function (key,value){
                    	contents += "<div class='container'>";
                        contents += "<div><table class='table'><h6><strong>userSeq : " + value.userSeq + "&nbsp;&nbsp;Date : " + value.regDate +"</strong></h6>";
                        contents += value.content + "<tr><td><div align='right'><button class='btn btn-default'>수정</button><button class='btn btn-default'>삭제</button></div></td></tr>";
                        contents += "</table></div>";
                        contents += "</div>";
                     });
					$('#ListAjax').html(contents);
    			},  
    			error : function(error) {
    	            alert("error : " + error);
    	        
    			}
    			
    		})
    	
		}
		
    </script>

</head>
<body>
	<%@include file="/WEB-INF/view/consumer/topBody.jsp" %>
		<div class="container" style="bgcolor:#e0e0e0">
			<ul style="list-style:none;">
				<li>제목 : <%=bDTO.getTitle()%></li>
			</ul>
			<hr/>
			<ul style="list-style:none;">
				<li>작성자 : <%=bDTO.getUserNick()%></li>
			</ul>
			<hr/>
			<ul style="list-style:none;">
				<li>작성일 : <%=bDTO.getRegDate()%></li>
			</ul>
			<hr/>
			<ul style="list-style:none;">
				<li>내용 : <%=bDTO.getContent()%></li>
			</ul>
               
			<div style="height:100px">
			</div>
			
			<!-- 삭제 수정버튼 -->
			<div align="right" style="height:200px">
				<div style="line-height:100%; margin-left:10px; margin-right:10px;">
				<button class="btn btn-default" onclick="location.href='/consumer/board/boardUpdateView.do?boardPSeq=<%=bDTO.getBoardPSeq()%>';">수정하기</button>
				<button class="btn btn-default" onclick="deleteBoard('<%=bDTO.getBoardPSeq()%>');">삭제하기</button>
				</div>
			</div>
			
			<!-- 댓글 달기 버튼-->
			<div align="right">
				<p>댓글을 달아주세요:</p><textarea id="contentAjax" name="content" placeholder="댓글을 입력하세요"></textarea>
				<button class="btn btn-default" style="margin-left:10px; margin-right:10px;" onclick="ajaxTest()">댓글</button> 
				<input type="hidden"id="boardPSeqAjax" value="<%=bDTO.getBoardPSeq()%>" /> 
				<input type="hidden" id="userSeqAjax" value="<%=userSeq%>" />
			</div>
			
			<!-- 댓글 불러오기 -->
			<div id="ListAjax">
				<%for (int i=0; i < rList.size(); i++) {%>
				<div><table class='table'><h6 style="font-weight:bold">userSeq : <%=rList.get(i).getUserSeq()%> &nbsp;&nbsp;Date : <%=rList.get(i).getRegDate() %></h6>
				<%=rList.get(i).getContent() %><tr><td><div align="right"><button class="btn btn-default">수정</button><button class="btn btn-default">삭제</button></div></td></tr>
				</table></div>
				<%} %>
			</div>
		</div>
</body>
</html>

	