<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="poly.dto.consumer.CONSUMER_ImageDTO"%>
<%@ page import="poly.dto.consumer.CONSUMER_Ft_ReviewDTO"%>
<%@ page import="java.util.List"%>
<%
	CONSUMER_Ft_ReviewDTO revDTO = (CONSUMER_Ft_ReviewDTO) request.getAttribute("revDTO");	
	List<CONSUMER_Ft_ReviewDTO> repleList = (List<CONSUMER_Ft_ReviewDTO>) request.getAttribute("repleList");
	CONSUMER_ImageDTO imgDTO = (CONSUMER_ImageDTO) request.getAttribute("imgDTO");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>트럭왔냠 - 리뷰 작성</title>
</head>
<style>
	.row{
		margin: 5px 0;
	}

</style>
<body>
<%@include file="/WEB-INF/view/consumer/topBody.jsp" %>

	
		
		<div class="container-fluid">
			<div class="row" >
				<div class="col-xs-4">
					<!-- 목록으로 가기 // 뒤로 가기 -->
					<a href="/consumer/cnsmr/ftDetail.do?ft_seq=<%=revDTO.getFt_seq()%>&cmd=2">
						<img src="/resources/img/consumer/left-arrow.png" width="35px" style="margin-top:10px;"/>
					</a>
				</div>
			</div>
		</div>
		<div class="container-fluid">
			<div class="row" >
				<div class="col-xs-6">
					<h2 style="font-weight:bold"><%=revDTO.getRev_title() %></h2>
				</div>
				<div class="col-xs-6" style="padding:20px; text-align:right;">
					<h5>
						<%for(int q = 0; q < (revDTO.getRev_point()); q++) {%>
								<img src="/resources/img/consumer/starRating.png">
						<%} %>
					</h5>
				</div>
			</div>
			
			
			<div class="row" style="margin-top:15px; margin-bottom:15px;">
				<div class="col-xs-6">
					<%int personalCon = (revDTO.getUser_seq() < 1) ?  0 : revDTO.getUser_seq() % 62;%>
					<img src="<%=request.getContextPath()%>/resources/img/consumer/personalCon/psnlCn (<%=personalCon%>).png" style="height: 40px; margin-right:10px;"/>
					<%=revDTO.getUser_nick() %>
				</div>
				<div class="col-xs-6" style="text-align:right; font-size: 12px; padding-top: 6px;">
					<%=revDTO.getRev_regdate()%>
				</div>
			</div>

			<div class="row" >
				<div style="background-color:#cecece; height:2px; margin:20px 10px;">
				</div>
			</div>
			<div class="row" >
				<div class="col-xs-12">
					<%=revDTO.getRev_text() %>
				</div>
			</div>
			
			<%try {%> <!-- 리뷰 이미지 출력 여부 확인 -->
				<%if(imgDTO.getFileSevname()!=null) {%>
				<div class="row" >
					<div class="col-xs-12">
						<div class="form-group">
							<img src="<%=request.getContextPath()%>/resources/files/<%=imgDTO.getFileSevname()%>" style="max-width:100%; height:auto;" />
						</div>
					</div>
				</div>
				<%} %>
			<%} catch(NullPointerException ne) {%>
			<%} %>
					
			

			<div class="row" >
				<div style="background-color:#cecece; height:2px; margin:20px 10px;">
				</div>
			</div>
		</div>
			<div style="padding:4px 0;"></div>
			<%if(userSeq == String.valueOf(revDTO.getUser_seq())) {%>
				<!-- 수정 버튼 -->
				<div class="row" >
					<button onclick="javscript:void(0)" class="btn btn-primary" style="width:100%;">
						<img src="<%=request.getContextPath()%>/resources/img/consumer/menu_icon/logout.png"/>
					</button>
				</div>
				<div style="padding:4px 0;"></div>
				<!-- 삭제 버튼 -->
				<div class="row" >
					<button onclick="javscript:void(0)"  class="btn btn-danger" style="width:100%;">
						<img src="<%=request.getContextPath()%>/resources/img/consumer/menu_icon/cancel.png"/>
					</button>
				</div>
			<%} %>
			<div style="padding:18px 0;"></div>
			<!-- 댓글 div -->
			
			<!-- 댓글 수정 / 삭제 -->
			<div class="container-fluid" id="replCont">
				<%if(repleList.isEmpty()==false) {%>
					<%for(int i = 0; i < repleList.size(); i++) { %>
					<form method="POST" id="formEditRemove<%=i%>">
						<input type="hidden" value="<%=repleList.get(i).getReview_seq() %>" name="edit_review_seq"/>
						<input type="hidden" value="<%=revDTO.getReview_seq()%>" name="review_seq"/>
						<div id="replTxtBox<%=i%>">
							<div class="row" >
								<div class="col-xs-6">
									<%personalCon = (repleList.get(i).getUser_seq() < 1) ?  0 : repleList.get(i).getUser_seq() % 62;%>
									<img src="<%=request.getContextPath()%>/resources/img/consumer/personalCon/psnlCn (<%=personalCon%>).png" style="height: 30px; margin-right:10px;"/>
									<%=repleList.get(i).getUser_nick()%>
								</div>
								<div class="col-xs-6" style="text-align:right; font-size: 12px; padding-top: 6px;">
									<%=repleList.get(i).getRev_regdate()%>
								</div>
							</div>
							<div class="row" style="padding: 10px 0;">
								<div class="col-xs-12"><%=repleList.get(i).getRev_text() %></div>
							</div>
						</div>	
						<%if(userSeq.equals(String.valueOf(repleList.get(i).getUser_seq()))) {%>
							<!-- 댓글 수정/삭제 버튼 - 로그인 세션 정보와 댓글쓴이가 일치해야 나타남 -->
							<div class="row" id="bttnCont" style="float:right; margin-right: 3px;">
								<!-- 인덱스값을 넘겨서 해당 div를 수정할 수 있도록 함-->
								<button onclick="editReply(<%=i%>)" class="btn btn-primary float-right" style="margin-right:5px;">
										<img src="<%=request.getContextPath()%>/resources/img/consumer/menu_icon/tools.png" height="13px"/>
								</button>
								<button onclick="removeReply(<%=i%>)" class="btn btn-danger float-right">
										<img src="<%=request.getContextPath()%>/resources/img/consumer/menu_icon/cancel.png" height="13px"/>
								</button>
							</div>
						<%} %>
					</form>
					<%} %>
				<%} %>
			</div>
			
			<div style="padding:12px 0;"></div>
			<!-- 댓글 쓰기 // 댓글작성과 리뷰 수정, 삭제 모두 같은 폼 태그 ID 사용-->
				<form method="POST" id="EdtRmvReview"> 
					<input type="hidden" name="userSeq" value="<%=userSeq%>"/> 
					<input type="hidden" name="ft_seq" value="<%=revDTO.getFt_seq()%>"/> 
					<input type="hidden" name="review_seq" value="<%=revDTO.getReview_seq()%>"/>
					<input type="hidden" name="edit_review_seq" value="<%=revDTO.getReview_seq()%>"/>
 
					<div class="container-fluid">
						<div class="row" >
							<div class="col-xs-12"> 
								<div class="form-group">
									<textarea class="form-control" rows="2" name="rev_text"></textarea>
								</div>
							</div>
						</div>
						<div class="row" style="padding:0 15px;">
							<%--  로그인세션 유저 기본키 값과 리뷰글의 유저시퀀스 값이 일치 할 경우 dd --%>
							<%if (userSeq.equals(String.valueOf(revDTO.getUser_seq()))) {%>
								<button onclick="editReview();" style="float:left; margin-right: 10px;"class="btn btn-primary">
									<img src="<%=request.getContextPath()%>/resources/img/consumer/menu_icon/tools.png"/>
								</button>
								<button onclick="removeReview();" style="float:left;"class="btn btn-danger">
									<img src="<%=request.getContextPath()%>/resources/img/consumer/menu_icon/cancel.png"/>
								</button>
							<%}else{ %>
							<!-- 일치하지 않을 경우 빈자리 채우기 -->
								<div class="col-xs-4"></div>
							<%} %>
								<button onclick="writeReply()" style=" float:right;"class="btn btn-default">
									<img src="<%=request.getContextPath()%>/resources/img/consumer/menu_icon/edit.png"/>
								</button>
						</div>
					</div>
				</form>
		</div>

</body>
<script>


	/* 댓글 삭제 */
	function removeReply(index) {
		var r = confirm('정말로 삭제 하시겠습니까?');
		if(r == true) {
			$('#formEditRemove'+index).attr("action", "/consumer/review/ReviewReplDelete.do");
			$('#formEditRemove'+index).submit();
		}
	}
	
	/* 댓글 수정 */
	function editReply(index) {
		$('#formEditRemove'+index).attr("action", "/consumer/review/ReviewReplEdit.do");
		$('#formEditRemove'+index).submit();
	}
	
	/* 댓글 쓰기 */
	function writeReply(){
		var userSeq = '<%=userSeq%>';
		//유저 로그인 여부 확인
		if(!userSeq) {
			alert('로그인을 먼저 해주세요.');
		}
		//로그인 상태
		else {
			$('#EdtRmvReview').attr("action", "/consumer/review/ReviewReplProc.do");
			$('#EdtRmvReview').submit();
		}
	}
	
	/* 리뷰 삭제 */
	function removeReview() {
		var r = confirm('정말로 삭제 하시겠습니까?');
		if(r == true) {
			$('#EdtRmvReview').attr("action", "/consumer/review/ReviewDelete.do");
			$('#EdtRmvReview').submit();
		}
	}
	
	/* 리뷰 수정 */
	function editReview() {
		$('#EdtRmvReview').attr("action", "/consumer/review/ReviewEdit.do");
		$('#EdtRmvReview').submit();
	}
	
</script>
</html>