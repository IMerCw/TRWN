<%@page import="poly.dto.seller.SELLER_BoardDTO"%>
<%@page import="poly.dto.seller.SELLER_ReviewDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	SELLER_BoardDTO bDTO = (SELLER_BoardDTO)request.getAttribute("bDTO");
	List<SELLER_ReviewDTO> rList = (List<SELLER_ReviewDTO>)request.getAttribute("rList");
	
%>

<html>
<head>
	<title>web</title>
	<%-- <%@ include file="/WEB-INF/view/seller/topCssScript.jsp" %> --%>
	<!--  
	<script type="text/javascript">
		function UpdateView(user_email) {
			조건 비교해줘야함 로그인된 정보랑 기존 게시판 데이터랑 동일한지 본인확인 필요
			  if(bDTO. == user_email){
				location.href="/board/boardWrite.do";
			}else{
			 	alert("로그인하세요");
				location.href="/user/userLogin.do";
			}  
		}
	</script> 
	-->
	<%-- <a href="/board/boardUpdateView.do?boardNo=<%=bDTO.getBd_no() %>">수정하기</a> --%>
	
	<script type="text/javascript">
		function boardDelete(boardPSeq){
			//alert(boardPSeq);
			location.href="/seller/board/boardDelete.do?boardPSeq="+boardPSeq;
		}
		
		function boardUpdateView(boardPSeq){
			//alert(boardPSeq);
			location.href="/seller/board/boardUpdateView.do?boardPSeq="+boardPSeq;
		}
	
		
	<!-- 리뷰 작성 -->
		//작설 펼치기
		function reWrite(){
				if($('#reWrite').hasClass('fa-chevron-up')){
					$('#reWrite').removeClass('fa-chevron-up');
					$('#reWrite').addClass('fa-chevron-down');
				}else{
					$('#reWrite').removeClass('fa-chevron-down');
					$('#reWrite').addClass('fa-chevron-up');
				}
				$('#writeView').toggle();
		}
	
		//댓글 등록
		function reReg(){
			//alert("test");
			$('#ajaxform').ajaxForm({
				beforeSubmit : function(){
					if($('#reContent').val() == ""){
						alert("내용을 입력해주세요");
						$('#reContent').focus();
						return false;
					};
					
				},
				success:function(data){
					console.log(data);
				 	var content = "";
				 		$.each(data,function(key,value){
						content +="<div style='margin-bottom:10%;'>";
						content +="userSeq : " + value.userSeq +" " + value.regDate + "<br/>";
						content +="content : " + value.content;
						content +="<div id='upWrite"+value.repleSeq+"'>";
						content +='<button class="btn btn-default pull-right" onclick="javascript:reClick(&#39;'+value.repleSeq+'&#39;,'+value.userSeq+')">...</button>'
						content +="</div>";
						content +="</div>";
						content +="<hr>";
						})
						
						$('#rList').html(content); 
				},
				error:function(){
					alert("error");
				}
				
				
			}).submit();
		}
		//댓글 수정 삭제 버튼
		function reClick(r,u){
			//r : reSeq 
			//u: userSeq
			//(String)session.getAttribute("userSeq")
		 	var ss_userSeq = <%=(String)session.getAttribute("userSeq")%>;
			var upWrite = "#upWrite"+r+"";
			alert(upWrite);
		 	if(ss_userSeq == u){
				<%-- upWrite<%=rList.get(i).getRepleSeq()%> --%>
				alert("수정 삭제");
				var upBtn="";
					//upBtn= "<button class='btn btn-default pull-right' onclick='#'>test</button>"
					upBtn += "<div class='btn-group pull-right' role='group' align='right' id='"+upWrite+"'>";
					upBtn +="<button type='button' class='btn btn-default' onClick='JavaScript:upBtn("+r+")'>수정</button>";
					upBtn +="<button type='button' class='btn btn-default' onClick='JavaScript:delBtn("+r+")'>삭제</button>";
					upBtn +="</div>"
				
				$(upWrite).html(upBtn);
			}else{
				alert("작성자만 수정 가능합니다.");
			}			
		}
		//댓글 수정  뷰
		function upBtn(r){
			var upView = "#upView"+r+"";
			//alert(upView);
			//alert(r);
			$.ajax({
				url : "/seller/board/upReple.do",
				method :"post",
				data : {
					"repleSeq" : r
					
				},
				success : function(data){
					console.log(data);
					var upBtnView ="";
						upBtnView += "<div style='margin-bottm:10%;'>";
						upBtnView += "<form id='ajaxfromUp' method='post' action='/seller/board/updateRe.do'>";
						upBtnView += "<textarea rows='3' class='col-sm-12 form-control' placeholder='"+data.content+"' id='reContentUp' name='reContentUp' maxlength='2048'></textarea>";
						upBtnView += "<input type='hidden' name='regDateUp'/>";
						upBtnView += "<input type='hidden' name='userSeqUp' value='"+data.userSeq+"'/>";
						upBtnView += "<input type='hidden' name='boardPSeqUp' value='"+data.boardPSeq+"'/>";
						upBtnView += "<input type='hidden' name='levelUp' value='1'/>";
						upBtnView += "<input type='hidden' name='repleSeq' value='"+r+"'/>";
						upBtnView += "</form>";
						upBtnView += "<button class='btn btn-default pull-right' onclick='JavaScript:updateRe()'>등록</button>";
						upBtnView += "</div>";
						
					$(upView).html(upBtnView);
					console.log(upBtnView);
				},
				error : function(){
					alert("error");
				}
				
				
			});
			
		}
		//댓글 업데이트 
		function updateRe(){
			//alert("test");
			$('#ajaxfromUp').ajaxForm({
				beforeSubmit : function(){
					if($('#reContentUp').val() == ""){
						alert("내용을 입력해주세요");
						$('#reContentUp').focus();
						return false;
					};
				},
				success:function(data){
					console.log(data);
				 	var content = "";
				 		$.each(data,function(key,value){
						content +="<div id='upView"+value.repleSeq+"'>";
						content +="userSeq : " + value.userSeq +" " + value.regDate + "<br/>";
						content +="content : " + value.content;
						content +="<div id='upWrite"+value.repleSeq+"'>";
						content +='<button class="btn btn-default pull-right" onclick="javascript:reClick(&#39;'+value.repleSeq+'&#39;,'+value.userSeq+')">...</button>';
						content +="</div>";
						content +="</div>";
						content +="<hr>";
						})
						
						$('#rList').html(content); 
				},
				error:function(){
					alert("error");
				}
			}).submit();
		}
		//댓글 삭제 
		function delBtn(r){
				var delRe = "#delRe"+r+"";
				alert(delRe);
				alert(r);
				$.ajax({
					url : "/seller/board/delReple.do",
					method :"post",
					data : {
						"repleSeq" : r
					},
					success : function(data){
						console.log(data);
					 	var content = "";
					 		$.each(data,function(key,value){
							content +="<div id='upView"+value.repleSeq+"'>";
							content +="userSeq : " + value.userSeq +" " + value.regDate + "<br/>";
							content +="content : " + value.content;
							content +="<div id='upWrite"+value.repleSeq+"'>";
							content +="<button class='btn btn-default pull-right' onclick='javascript:reClick(&#39;"+value.repleSeq+"&#39;,"+value.userSeq+")'>...</button>";
							content +="</div>";
							content +="</div>";
							content +="<hr>";
							})
							
							$('#rList').html(content); 
					},
					error : function(){
						alert("error");
					}
					
					
				});
				
			
			
		}
	
	</script>
	
	
	
			
</head>
<body>
	<table style="height: 100%; width: 100%">
		<tr style="height:7%; bgcolor:#444">
			<td style="padding:0;">
				<%@ include file="/WEB-INF/view/seller/top.jsp" %>
				
			</td>
		</tr>
		<tr bgcolor="">
			<td>
				<div class="container" style="height:100%;">
			<!-- 	<h2>지역행사정보</h2> -->
					<div class="row">
						<table class="table table-striped" style=" border: 1px solid #dddddd">
						<thead>
						<tr>
							<th colspan="3" style="background-color: #eeeeee; text-align: center;">공지사항 상세보기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 20%; style="text-align:left;">글번호 :</td>
							<td colspan="2";>
								<%=bDTO.getBoardPSeq() %>
							</td>
						</tr>
						<tr>
							<td >글제목 :</td>
							<td colspan="2"; style="text-align:left;" >
								<%=bDTO.getTitle() %>
							</td>
						</tr>
						<tr>
							<td >글내용 :</td>
							<td colspan="2" style="min-height:200px; text-align:left;">
								<%=bDTO.getContent() %>
							</td>
						</tr>
						<tr>
							<td >작성일자 :</td>
							<td colspan="2"; style="text-align:left;">
								<%=bDTO.getRegDate()%>
							</td>
						</tr>
						
					</tbody>
							
						</table>
						<!-- <input type="hidden" name="regdate"/> -->
						<!-- <input type="submit" class="btn btn-paimary pull-right" value="글쓰기"> -->
						<!-- <a href="/board/boardWrite.do">삭제</a> -->
						
						<div align="right" style="float:right;">
					<!-- 	<a href="/board/boardList.do" >목록</a> -->
						<button class="btn btn-default pull-right" onclick="location.href='/seller/board/boardList.do'">목록</button>
						<%if(userNick.equals(bDTO.getUserNick()) 
								&& !(bDTO.getBoardPSeq().equals("1") ||bDTO.getBoardPSeq().equals("2") || bDTO.getBoardPSeq().equals("3")
								) ) { %>
						 <button class="btn btn-default pull-right" onclick="boardDelete('<%=bDTO.getBoardPSeq()%>');">삭제</button> 
						 <button class="btn btn-default pull-right" onclick="boardUpdateView('<%=bDTO.getBoardPSeq()%>');">수정</button>
						<%} %>
						<%-- 
							<a href="Javascript:UpdateView('<%=user_email%>');" >수정하기</a> 
							 <a href="/board/boardUpdateView.do?boardNo=<%=bDTO.get %>">수정하기</a>
						 --%>
 				 		
						</div>
						
						<div class="review" style="width:100%;">
							<div align="left">
								<h6 class="reviewWrite">
									<a href="#" onclick="JavaScript:reWrite();" style="text-decoration:none; color:black;">
										<span class="fas fa-chevron-down" id="reWrite"></span>
										<b>댓글쓰기</b>
									</a>
								</h6>
							</div>
							<div style="display:none;" id="writeView">
								<hr>
								<div style="margin-bottom:10%;">
									<form id="ajaxform"method="post" action="/seller/board/reWriteProc.do">
										<textarea rows="3" class="col-sm-12 form-control" placeholder="댓글을 작성해주세요." id="reContent" name="reContent" maxlength="2048"></textarea>
										<div align="right">
										</div>
										<input type="hidden" name="regDate"/>
										<input type="hidden" name="userSeq" value="<%=userSeq%>"/>
										<input type="hidden" name="boardPSeq" value="<%=bDTO.getBoardPSeq()%>"/>
										<input type="hidden" name="level" value="1"/>
									</form>		
										<button class="btn btn-default pull-right" onclick="JavaScript:reReg()">등록</button>
								</div>
							</div>
							<hr>
							<div id="rList">
							<br/>
								<%if( rList.size()>0){ %>
									<% for(int i=0; i < rList.size(); i++){ %>
										<div id="upView<%=rList.get(i).getRepleSeq()%>">
										userSeq :<%=rList.get(i).getUserSeq() %>&nbsp;&nbsp;&nbsp; <%=rList.get(i).getRegDate() %><br/>
										content :<%=rList.get(i).getContent() %>
											<div id="upWrite<%=rList.get(i).getRepleSeq()%>">
												<button class="btn btn-default pull-right" onclick="javascript:reClick(<%=rList.get(i).getRepleSeq()%>,<%=rList.get(i).getUserSeq()%>)">...</button>
											</div>
										</div>
										<hr>
									<%} %>
								<%}else{ %>
									<div>댓글을 작성해주세요.</div>
								<%} %>
							</div>
						
						</div>
					
					</div>
				</div>

			</td>
		</tr>
		<tr height="7%" style="background-color:#444">
			<td>
			<%-- 	<%@ include file="/WEB-INF/view/bottom.jsp" %> --%>
			
			</td>
		</tr>
	</table>
</body>
</html>