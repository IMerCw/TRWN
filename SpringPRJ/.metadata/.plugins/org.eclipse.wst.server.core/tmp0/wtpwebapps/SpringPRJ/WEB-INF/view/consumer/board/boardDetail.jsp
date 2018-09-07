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
<title>Detail!</title>
<%@ include file="/WEB-INF/view/consumer/topCssScript.jsp" %>
<script type="text/javascript">
	function deleteBoard(boardPSeq){
		location.href="/consumer/board/boardDelete.do?boardPSeq=" + boardPSeq;
	}

</script>
  <script>
/*   $(function (){
	  
  }) */
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
                        contents += value.content + "<tr><td><div align='right'><button>수정</button><button>삭제</button></div></td></tr>";
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

	<table style="height: 100%; width: 100%">
		
		<tr bgcolor="">
			<td>
				<div class="container" style="bgcolor:#e0e0e0">
					<%-- <table>
						<tr>
							<th style="height:40px;">글제목 :</th>
							<td>&nbsp;<%=bDTO.getTitle()%></td>
						</tr>
						<tr>
							<th style="height:40px;">작성일 :</th>
							<td>&nbsp;<%=bDTO.getRegDate()%></td>
						</tr>
						<tr>
							<th style="height:40px;">글내용 :</th>
							<td>&nbsp;<%=bDTO.getBoardContent()%></td>
						</tr>
					</table> --%>
				
				<ul style="list-style:none;">
					<li>제목 : <%=bDTO.getTitle()%></li>
				</ul>
				<hr/>
				<ul style="list-style:none;">
					<li>작성자 : <%=bDTO.getUserEmail()%></li>
				</ul>
				<hr/>
				<ul style="list-style:none;">
					<li>작성일 : <%=bDTO.getRegDate()%></li>
				</ul>
				<hr/>
				<ul style="list-style:none;">
					<li>내용 : <%=bDTO.getBoardContent()%></li>
				</ul>
                
				</div>
				<div style="height:100px">
				</div>
				<div class="container" align="right" style="height:100px">
					<div style="line-height:100%">
					<button  onclick="location.href='/consumer/board/boardUpdateView.do?boardPSeq=<%=bDTO.getBoardPSeq()%>';">수정하기</button>
					<button onclick="deleteBoard('<%=bDTO.getBoardPSeq()%>');">삭제하기</button>
					</div>
				</div>
			</td>
		</tr>
		<tr>
			<td>
				<div class="container" align="right">
					댓글을 달아주세요:<input type="text" id="contentAjax" name="content">
					<button onclick="ajaxTest()">댓글</button> 
					<input type="hidden"id="boardPSeqAjax" value="<%=bDTO.getBoardPSeq()%>" /> 
					<input type="hidden" id="userSeqAjax" value="<%=userSeq%>" />
				</div>
				<div class="container" id="ListAjax">
					<%for (int i=0; i < rList.size(); i++) {%>
					<div><table class='table'><h6><strong>userSeq : <%=rList.get(i).getUserSeq()%> &nbsp;&nbsp;Date : <%=rList.get(i).getRegDate() %></strong></h6>
					<%=rList.get(i).getContent() %><tr><td><div align="right"><button>수정</button><button>삭제</button></div></td></tr>
					</table></div>
					<%} %>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>

	