<%@page import="poly.dto.seller.SELLER_BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	List<SELLER_BoardDTO> bList = ( List<SELLER_BoardDTO> )request.getAttribute("bList");
	/* UserDTO uDTO = (UserDTO)request.getAttribute("uDTO"); */
%>

<!-- 
			session.setAttribute("userSeq", uDTO.getUserSeq());
			session.setAttribute("userAuth", uDTO.getUserAuth());
			session.setAttribute("userEmail", uDTO.getUserEmail());
			session.setAttribute("userNick", uDTO.getUserNick());
			session.setAttribute("userGender", uDTO.getUserGender());
			session.setAttribute("userHp", uDTO.getUserHp());
			session.setAttribute("userStatus", uDTO.getUserStatus()); 
-->

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<%-- <%@ include file="/WEB-INF/view/seller/topCssScript.jsp" %> --%>
	<!-- tabs -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
</head>
<body>
	<table style="height: 100%; width: 100%">
		<tr height="7%" bgcolor="#444">
			<td style="padding:0;"> 
				<%@ include file="/WEB-INF/view/seller/top.jsp" %>
				<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
				<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
				<!-- 테이블 페이징  -->
				<script src="//cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
				<!-- tabs -->
				  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
				  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
				  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
			
				
			
			</td>
		</tr>
		<tr>
			<td style="background-image:url('/resources/img/seller/pic02.jpg'); opacity:0.9!important;">
			<!--tab 부분 시작-->
			<div class="container" style="height:100%; margin-top:3%;" >
				<div class="row" >
					
			            <div class="panel with-nav-tabs panel-dark" style="width:100%; opacity: 0.9;">
			                <div class="panel-heading">
			                        <ul class="nav nav-tabs">
			                            <li class="active"><a href="#tab1info" data-toggle="tab">공지사항</a></li>
			                            <li><a href="#tab2info" data-toggle="tab" id="customer">고객센터</a></li>
			                            <li><a href="#tab3info" data-toggle="tab">업주커뮤니티</a></li>
			                            
			                        </ul>
			                </div>
			                <div class="panel-body">
			                    <div class="tab-content">
			                    <!-- 공지사항  시작-->
			                        <div class="tab-pane fade in active" id="tab1info">
			                        	<div class="row" id="boardNotice">
			                        		<div class="col-xs-6 col-sm-3" style="text-align:center">
			                        		
			                        		</div>	
			                        <!-- info1  끝  -->
			                       		</div>
			                        
			                        </div>
			                        <!-- info 2   -->
			                        <div class="tab-pane fade" id="tab2info">
			                        	<div class="row" id="customerCenter">
			                        		<div class="col-xs-6 col-sm-3" style="text-align:center">
			                        			
			                        		</div>	
			                        	</div>
			                        </div>
			                        <!-- info2 끝  -->
			                        
			                        <!-- info3 시작 -->
			                        <div class="tab-pane fade" id="tab3info">
			                        	<div class="row" id="boardCommunity">
			                        		<div class="col-xs-6 col-sm-3" style="text-align:center">
			                        		
			                        		</div>	
			                        <!-- info3  끝  -->
			                       		</div>
			                        </div>
			               
			                    </div>
			                </div>
			            </div>
					</div>
				</div>
				<!-- tab 부분 끝  -->
					
			

			</td>
		</tr>
		<tr height="7%" style="background-color:#444">
			<td>
			 	<%@ include file="/WEB-INF/view/seller/bottom.jsp" %> 
			
			</td>
		</tr>
	</table>
	<script>
	
	$(function(){
		// 공지사항 ajax 시작
		var boardSeq = 1;
		$.ajax({
			url: "/seller/board/boardNotice.do",
			method : "post",
			data : {
				'boardSeq' : boardSeq
				},
			//dataType : "json",
			success : function(data){
				
				var contents = createHTML(data);
				
				$('#boardNotice').html(contents);
				$('#datatable1').DataTable();
				$("#liActive").addClass("active");
		
			},
			error:function(x,e){
				if(x.status==0){
		            alert('네트워크가 정상적으로 동작하지 않습니다.');
		            alert('네트워크 상태를 확인 하거나 업체에게 문의해 주세요.')
		            }else if(x.status==404){
		            alert('페이지를 찾을수가 없습니다. 지금은 주문을 받을 수 없습니다. 업체에게 문의하세요.');
		            }else if(x.status==500){
		            alert('서버에서 오류가 발생했습니다. 지금은 주문을 받을 수 없습니다. 업체에게 문의하세요.');
		            }else if(e=='parsererror'){
		            alert('json파싱에 실패했습니다.');
		            }else if(e=='timeout'){
		            alert('응답 요청 시간이 지났습니다.');
		            }else {
		            alert('Unknow Error.n'+x.responseText);
		            }
		    }
		})
		//공지사항 ajax 끝 
		
			//고객센터 ajax 시작
			var boardSeq = 2;
			$.ajax({
				url: "/seller/board/boardCustomerCenter.do",
				method : "post",
				data : {
					'boardSeq' : boardSeq
					},
				//dataType : "json",
				success : function(data){
					
					var contents = createHTML(data);
					
					$('#customerCenter').html(contents);
					 $('#datatable2').DataTable();
			
				},
				error:function(x,e){
					if(x.status==0){
			            alert('네트워크가 정상적으로 동작하지 않습니다.');
			            alert('네트워크 상태를 확인 하거나 업체에게 문의해 주세요.')
			            }else if(x.status==404){
			            alert('페이지를 찾을수가 없습니다. 지금은 주문을 받을 수 없습니다. 업체에게 문의하세요.');
			            }else if(x.status==500){
			            alert('서버에서 오류가 발생했습니다. 지금은 주문을 받을 수 없습니다. 업체에게 문의하세요.');
			            }else if(e=='parsererror'){
			            alert('json파싱에 실패했습니다.');
			            }else if(e=='timeout'){
			            alert('응답 요청 시간이 지났습니다.');
			            }else {
			            alert('Unknow Error.n'+x.responseText);
			            }
			    }
			})
			// 고객센터 ajax 끝
			// 업주 커뮤니티 ajax 시작
			var boardSeq = 3;
			$.ajax({
				url: "/seller/board/boardCommunity.do",
				method : "post",
				data : {
					'boardSeq' : boardSeq
					},
				//dataType : "json",
				success : function(data){
					
					var contents = createHTML(data);
					
					$('#boardCommunity').html(contents);
					$('#datatable3').DataTable();
			
				},
				error:function(x,e){
					if(x.status==0){
			            alert('네트워크가 정상적으로 동작하지 않습니다.');
			            alert('네트워크 상태를 확인 하거나 업체에게 문의해 주세요.')
			            }else if(x.status==404){
			            alert('페이지를 찾을수가 없습니다. 지금은 주문을 받을 수 없습니다. 업체에게 문의하세요.');
			            }else if(x.status==500){
			            alert('서버에서 오류가 발생했습니다. 지금은 주문을 받을 수 없습니다. 업체에게 문의하세요.');
			            }else if(e=='parsererror'){
			            alert('json파싱에 실패했습니다.');
			            }else if(e=='timeout'){
			            alert('응답 요청 시간이 지났습니다.');
			            }else {
			            alert('Unknow Error.n'+x.responseText);
			            }
			    }
			})
			//업주 커뮤니티 ajax 끝 
			
			function createHTML(data){
				console.log(data);
				console.log("data.length : " +Object.keys(data).length);
				
				console.log("data[0].boardPSeq : " + data[0].boardPSeq);
				var tmp = 0;
				var contents = "";
				var userEmail = '<%=userEmail%>';
				var boardSeq = data[0].boardSeq;
				console.log("boardSeq : " + boardSeq);
				contents += " <table class='table table-striped' style='text-align: center; border: 1px solid #dddddd' id='datatable" + boardSeq + "'> ";
				contents += " <thead> ";
				contents += " <tr style='bgcolor:#BDBDBD;'> ";
				contents += " <th style='text-align: center;'>번호</th> ";
				contents += " <th style='text-align: center;'>제목</th> ";
				contents += " <th style='text-align: center;'>조회수</th>";
				contents += " <th style='text-align: center;'>작성일</th> ";
				contents += " <th style='text-align: center;'>작성자</th>";
				contents += " </tr> ";
				contents += " </thead> ";
				contents += " <tbody> ";
				$.each(data,function (key,value){
					
					/*console.log("-------------------------");
					console.log(tmp);
					console.log("boardSeq : " + value.boardPSeq);
					console.log("title : " + value.title);
					console.log("regDate  : " + value.regDate);
					console.log("userNick : " + value.userNick);
					console.log("-------------------------");
					tmp++; */
					contents += "<tr>";
					contents += "<td>" + value.boardPSeq + "</td>";
			//		contents += "<td>" + value.title + "</td>";
					 
					contents += "<td>";
					contents += " <a href='/seller/board/boardDetail.do?boardPSeq="+value.boardPSeq+"'>"+value.title+"</a>";
					contents += " </td>"; 
					contents += " <td>" + value.boardCount + "</td>";
					contents += " <td>" + value.regDate + "</td>";
					contents += " <td>" + value.userNick + "</td>";
					contents += " </tr>";
				});
				
				contents += "</tbody>";
				contents += "</table>";
				contents += "<div align='right' style='width:100%'>";
			
				contents += "<button><a href='Javascript:userLoginCk(\""+userEmail+"\",\""+boardSeq+"\");'>글쓰기</a></button>"
					
				contents += "</div>";
				
				return contents;
				

			}
			
			
			
	})	// ajax function 끝
	
	
	</script>
	<script type="text/javascript">
	function userLoginCk(e,b) {
		 
		//alert(e); 
		//alert(b);
	
		console.log(e);
		console.log(b); 
		
		 if("" != e){
			location.href="/seller/board/boardWrite.do?boardSeq="+b;
		}else{
		 	alert("로그인하세요");
			location.href="/cmmn/main.do";
		}   

		}
	 
	</script>
	
</body>
</html>