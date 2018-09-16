<%@page import="poly.util.CmmUtil"%>
<%@page import="poly.dto.admin.ADMIN_ImageDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="poly.dto.admin.ADMIN_Menu_InfoDTO"%>
<%@page import="poly.dto.admin.ADMIN_Ft_Menu_CateDTO"%>
<%@page import="java.util.List"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="poly.dto.admin.ADMIN_Ft_InfoDTO" %>

<%
	ADMIN_Ft_InfoDTO ftDTO2 = (ADMIN_Ft_InfoDTO)request.getAttribute("ftDTO");
	List<ADMIN_Ft_Menu_CateDTO> cateDTOarr = (List<ADMIN_Ft_Menu_CateDTO>)request.getAttribute("cateDTOarr");
	List<ADMIN_Menu_InfoDTO> menuDTOarr = (List<ADMIN_Menu_InfoDTO>)request.getAttribute("menuDTOarr");
	List<ADMIN_ImageDTO> imgDTOarr = (List<ADMIN_ImageDTO>)request.getAttribute("imgDTOarr");
%>
<%
	ADMIN_Ft_InfoDTO ftDTO = (ADMIN_Ft_InfoDTO)request.getAttribute("ftDTO");
	String[] array_optime = ftDTO.getFt_optime().split("/");
	String[] array = ftDTO.getFt_func().split("/"); 
	
	String cmd = (String)request.getAttribute("cmd");
	if(cmd==null){
		cmd="";
	} 
%>
<% String userSequence = CmmUtil.nvl((String)request.getParameter("userSeq")); %>
<%
	List<HashMap> Ilist = (List<HashMap>)session.getAttribute("Ilist");
	int sum =0;
	if(Ilist == null){
		sum = 0;
	}else{
		for(int i=0; i< Ilist.size(); i++) {
			String menuPriceTemp =  (String) Ilist.get(i).get("menuPrice");
			int amntTemp =  (int) Ilist.get(i).get("amnt");
			int price = Integer.parseInt(menuPriceTemp);
			int amnt = amntTemp;
			sum += (price*amnt);
	}
}

	
%>

<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/bootstrap.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/admin/ft_info.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
	      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
	      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	    <![endif]-->

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>트럭왔냠 - 주문하기</title>
	
	
		
	<script type="text/javascript">
		//메뉴 클릭시 action
		function item(a,b,cmd){
			//alert(cmd);
			console.log("ftSeq : "+a);
			console.log("menuSeq : "+b);
			if(cmd =='RegItem'){
			//	alert("ftSeq : " +a);
			//	alert("menuSeq :" +b);
				//무조건 error 화면 전화 하려고 쓴거임 location 쓰면 reload 때문에 안됌 왜지?
					 $.ajax({
						url : "/seller/out/item.do",
						type : "post",
						data : {
							"ftSeq" : a,
							"menuSeq" : b
						},
						success: function(data){
							console.log(data);
						},
						error : function(error){
							
						}
					}); 
					location.reload();
					
				}		
			};
			
		
		//item btn 마다 cmd 다르게 줘서 다른 action 이루어지게 항거임
		function itemBtn(index,cmd){
			//alert(cmd);	
			//alert(index);
				//location.href="/out/itemBtn.do?index="+index+"&cmd="+cmd;
				 $.ajax({
						url : "/seller/out/itemBtn.do",
						type : "post",
						data : {
							"index" : index,
							"cmd" : cmd
						},
						success: function(data){
							console.log(data);
						},
						error : function(error){
						}
					}); 
				location.reload();
			
		};
		
		function complete(a,b){
			
			if(<%=sum%> == 0){
				alert("주문할 상품을 선택해주세요")
				return false;
			}
			
			location.href="/seller/order/orderLogin.do?sum="+a+"&userSeq="+b;
			//location.href="/seller/order/orderInfo.do?sum="+a+"&userSeq="+b;
		}
		
		
		
		</script> 
	<style>
		/* body{
			background-image:url('/resource/img/seller/pic02.jpg'); 
		}
		 */
	</style>
</head>
<body>
		<%-- <%@ include file="/WEB-INF/view/seller/top.jsp" %> --%>
		<!-- 	<td style="background-image:url('/resources/img/seller/pic02.jpg');"> -->
		
			<!-- 판매자 푸드트럭관리 -->
		<div id="menuContainer">
			<div class="menuInnerContainer" style="width:90%; margin:0 auto; background-color:white;">
				<div><!------------------ 주문하기  ------------------>
				<div>
					<div style="float:left; width:70%; height:42px;">
							<h3>메뉴/카테고리</h3>
					</div>
					<div style="clear:both;"></div>
					<hr>
					<!-- Nav tabs -->
			  <ul class="nav nav-pills">
			  <%for(ADMIN_Ft_Menu_CateDTO cateDTO : cateDTOarr){ %>
			  	<%if(cateDTO.getCate_sort_no()==1){ %>
			  		<li role="presentation" class="active">
				  		<a href="#home" aria-controls="home" role="tab" data-toggle="tab"
						<%if(cateDTO.getExp_yn()==-1){%>
			  				style="border-radius:4px; border:1px solid #D9534F; box-sizing:border-box; display:none;"
			  			<%}%>>
				  			<%=cateDTO.getCate_name()%>
				  		</a>
			  		</li> 
			  	<%}else{%> 
			  		<li role="presentation">
			  			<a href="#cate<%=cateDTO.getCate_sort_no()%>" aria-controls="cate<%=cateDTO.getCate_sort_no()%>" role="tab" data-toggle="tab"
			  			<%if(cateDTO.getExp_yn()==-1){%>
			  				style="border-radius:4px; border:1px solid #D9534F; box-sizing:border-box; display:none;"
			  			<%}%>>
			  				<%=cateDTO.getCate_name()%>
			  			</a>
			  		</li>
			  	<%} %>
			  <%} %>
			  </ul>
			
			  <!-- Tab panes -->
			  <div class="tab-content" style="margin-top:10px; height:465px; overflow:auto;">
			  	<%int i=0; %>
			  	<%for(ADMIN_Ft_Menu_CateDTO cateDTO : cateDTOarr){ %>
			  		<%if(cateDTO.getCate_sort_no()==1){ %>
			  			<div role="tabpanel" class="tab-pane active" id="home">
			  		<%}else{ %>
			  			<div role="tabpanel" class="tab-pane" id="cate<%=cateDTO.getCate_sort_no()%>">
			  		<%} %>
			  			<%for(ADMIN_Menu_InfoDTO menuDTO : menuDTOarr){ %>
			  				<%if(cateDTO.getCate_sort_no()==menuDTO.getCate_sort_no()){ %>
			  					<div style="border:1px solid #cccccc; width:138px; height:200px; margin:3px; float:left; cursor:pointer;"
			  					onmouseover="this.style='border:1px solid #D9534F; width:165px; height:200px; margin:3px; float:left; cursor:pointer;'"
			  					onmouseout="this.style='border:1px solid #cccccc; width:165px; height:200px; margin:3px; float:left; cursor:pointer;'"
			  					onclick="JavaScript:item('<%=ftDTO2.getFt_seq()%>','<%=menuDTO.getMenu_seq()%>','RegItem');">
			  					<%-- onclick="location.href='<%=request.getContextPath()%>/admin/ft/ft_info.do?cmd=menu_info&ft_seq=<%=ftDTO2.getFt_seq()%>&menu_seq=<%=menuDTO.getMenu_seq()%>'"> --%>
						    		<div style="width:100%; height:165px; padding:3px; ">
						    		<%if(!menuDTO.getFile_id().equals("-1")){%>
						    			<%for(ADMIN_ImageDTO imgDTO : imgDTOarr){ %>
						    				<%if(imgDTO.getFile_id().equals(menuDTO.getFile_id())){ %>
						    					<img src="<%=request.getContextPath()%>/resources/files/<%=imgDTO.getFile_sevname()%>" width="100%" height="100%">
						    				<%} %>
						    			<%} %>
						    		<% i++;
						    		}else{ %>
						    			등록된 이미지가 없습니다.
						    		<%} %>
						    		</div>
						    		<div style="width:100%; height:35px; padding-top:4px; text-align:center; border-top:1px solid #cccccc;">
						    			<%=menuDTO.getMenu_name()%>
						    		</div> 
						    	</div>
			  				<%} %>
			  			<% } %>
			  			</div>
			  	<%} %>
			  </div>
			  <div style="margin-top:10px; margin-bottom:10px; border-bottom:1px solid #f2f2f2;"></div>
			</div>
						<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
		<script src="<%=request.getContextPath()%>/resources/js/admin/jquery-1.11.2.min.js"></script> 
		<!-- Include all compiled plugins (below), or include individual files as needed --> 
		<script src="<%=request.getContextPath()%>/resources/js/admin/bootstrap.min.js"></script>
						</div>
						
						</div>
				</div>
				<!-- 주문하기  -->
				
				
					
			</div>
		<!-- 장바구니  -->
		<div class="container-fluid" >
			<%-- 장바구니 --%>
			<%if(Ilist == null){ %>
		
			<div class="row" style="padding :0; height:120px;">
				<button type="button" class="btn btn-default col-sm-2">취소</button>
				<p><b>메뉴이름</b></p>
				<button type="button" class="btn btn-default col-sm-1">-</button>
				<p style="padding :0; text-align:center"><b>수량</b></p>
				<button type="button" class="btn btn-default col-sm-1" >+</button>
			</div>
				
				
				
			<%}else{ %>
				 <%for(int j=0; j<Ilist.size(); j++) {%>
					<div class="row" style="padding :0;">
						<div class="col-xs-2">
							<button type="button" class="btn btn-default" onclick="JavaScript:itemBtn('<%=j%>','amntMinus');">-</button>
						</div>
						<div class="col-xs-2" style="text-align:center;">
							<%=Ilist.get(j).get("amnt")%>
						</div>
						<div class="col-xs-2">
							<button type="button" class="btn btn-default" onclick="JavaScript:itemBtn('<%=j%>','amntPlus');" >+</button>
						</div>
						<div class="col-xs-4" style="text-align:center;">
							<%=Ilist.get(j).get("menuName")%>
						</div>
						<div class="col-xs-2">
							<button type="button" style="width:100%;" class="btn btn-default" onclick="JavaScript:itemBtn('<%=j%>','delItem');">
								 <b style="text-align:center;">X</b>
							</button>
						</div>
					</div>
				<%} %>
			<%} %>
			<div style="height:32px;"></div>
			<%-- 총금액 표시--%>
			<div class="row" style="padding :0;">
				<div class="col-xs-12">
					<button type="button" style="width:100%" class="btn btn-default" onclick="JavaScript:itemBtn('1','delAll');">전체메뉴취소</button>
					<div class="col-xs-4" style="text-align:center; height:34px;"><b>총금액</b></div>
					<div class="col-xs-4" style="text-align:center; height:34px;">
						<div style="padding :0;">
						<%=sum %> 원
						</div>
					</div>
					<div class="col-xs-4">
						<button type="button" class="btn btn-default" onclick="Javascript:complete(<%=sum%>,<%=userSequence%>)">주문완료</button>
					</div>
				</div>
			</div>
			
		 
		</div>
		
		<div id="orderFooter">
		</div>
		

</body>

</html>