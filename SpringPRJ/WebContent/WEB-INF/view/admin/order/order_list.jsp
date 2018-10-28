<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="poly.dto.admin.ADMIN_Order_InfoDTO" %>
<%@page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

 <% 
 	List<ADMIN_Order_InfoDTO> orDTOarr = (List<ADMIN_Order_InfoDTO>)request.getAttribute("orDTOarr");
 	
	 String pageNum = (String)request.getAttribute("pageNum");
		int startNum;
		if (pageNum==null || pageNum.equals("null")){//새로 목록을 불러올때 무조건 1페이지를 표시하게끔
			pageNum = "1";
			startNum = 1;
		}else{
			startNum = Integer.parseInt(pageNum); //현재 표시되는 페이지번호
		}
		
		String TopageSize=(String)request.getAttribute("pageSize");
		int pageSize;
		if(TopageSize==null || TopageSize.equals("null")){
			pageSize=10;
		}else{
			pageSize=Integer.parseInt(TopageSize);
		}
 %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html" >
		<title>주문내역</title>
		
		<!-- include javascript and css files for the EditableGrid library -->
		<!--<script src="../editablegrid-1.0.10.js"></script>-->
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/admin/editablegrid-1.0.10.css"  type="text/css" />
		
		<!-- include javascript and css files for this demo -->
		<script src="<%=request.getContextPath() %>/resources/js/admin/demo.js" ></script>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/admin/demo.css" /> 
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/admin/bootstrap.css">
		<script>
			function pageSizeEdit(pageSize){
				location.href="<%=request.getContextPath()%>/admin/order/order_main.do?cmd=order_list&pageSize="+pageSize+"&pageNum=<%=pageNum%>";
			}
		
			function allCheck(){
				  cbox = input_form.order_check;
				    if(cbox.length) {  // 여러 개일 경우
				        for(var i = 0; i<cbox.length;i++) {
				            cbox[i].checked=input_form.all.checked;
				        }
				    } else { // 한 개일 경우
				        cbox.checked=input_form.all.checked;
				    }
			}	
			
			function checkOrder(mode){
				var cObj = document.getElementsByName("order_check"); //체크박스 값 받는 곳
				var check_Cnt = 0;
				var check_Arr = ""; //선택항목 값 담는 곳
				var auth_Arr = ""; //변경등급 값 담는 곳
				
				for(var i=0; i<cObj.length; i++){
					if(cObj[i].checked){
						check_Arr += cObj[i].value+',';
						check_Cnt++;
					}
				}
				if(mode==1 && check_Cnt != 0){
					location.href="<%=request.getContextPath()%>/admin/order/order_delete.do?ArrOrd_seq="+check_Arr;
				}
			}
		</script>
	</head>
	
	<body>
		<h2>주문내역</h2>
    <div style="border-bottom:1px solid #444444; margin-top:15px;"></div>
	<div style="margin-top:15px; margin-bottom:25px;">
        <form class="form-inline" action="<%=request.getContextPath()%>/admin/order/order_main.do" method="get">
        	<input type="hidden" name="cmd" value="order_search_list">
            <div class="form-group">
            	<h4>주문내역 검색</h4>
                    <select class="form-control" name="option">
                   		<option value="user_seq">유저 번호</option>
                        <option value="ft_seq">푸드트럭 번호</option>
                    </select>
                    <input type="text" name="value" class="form-control">
                    <input type="submit" value="검색" class="btn btn-default">
            </div>
        </form>
    </div>
    <div style="border-bottom:1px solid #cccccc; margin-top:15px; margin-bottom:15px;"></div>
		<div style="position:relative; float:left; width:68%;">
            		<p>전체주문 수 : <%=orDTOarr.size()%></p>
                   선택 주문&nbsp; 
                   <input type="button" value="삭제" class="btn btn-default" onClick="javascript:checkOrder(1)"> 
                </div>
                <div style="float:right; width:32%; padding-top:30px;">
                    <div style=" position:relative; float:right;">
                        <select name="boardCount" class="form-control" onchange="pageSizeEdit(this.value)">
                            <option selected="selected"><%=pageSize%>개씩 보기</option>
							<option value="10">10개씩 보기</option>
							<option value="15">15개씩 보기</option>
							<option value="30">30개씩 보기</option>
							<option value="50">50개씩 보기</option>
							<option value="100">100개씩 보기</option>
                        </select>
                    </div>
                </div>
        <div style="clear:both;"></div>
		<!-- In real life this HTML table would have been generated with eg. a PHP server-side script -->
		<!--  The first row of your table will serve as table header, you don't have to put it in a <THEAD> but it's better of course -->
       	<form name="input_form">
		<table id="htmlgrid" class="testgrid" style="margin-top:10px;">
			<tr>
            	<th width="2%"><input type="checkbox" name="all" onClick="allCheck()"/></th>
				<th width="8%">주문번호</th>
				<th width="12%">주문일시</th>
				<th width="10%">주문자</th>
				<th width="8%">총 상품금액</th>
				<th width="8%">총 배송비</th>
				<th width="8%">총 주문금액</th>
				<th width="7%">결제방법</th>
				<th width="7%">결제상태</th>
			</tr>
			<%
				if(orDTOarr.size()==0 || orDTOarr==null){%>
					<tr height="80px"><td align="center" colspan="9">주문내역이 없습니다.</td></tr>	
				<%}else{
				int startCnt=(startNum-1)*pageSize;	//시작 그룹번호
				int endCnt=pageSize*startNum; //끝 그룹번호
				int cnt = 0;
				for(int i=startCnt; i<endCnt; i++){%>
					<tr id="<%=cnt%>"> 
		            	<td><input type="checkbox" name="order_check" value="<%=orDTOarr.get(i).getOrd_seq()%>"/></td>
		            	<td><%=orDTOarr.get(i).getOrd_seq() %></td>
		            	<td><%=orDTOarr.get(i).getOrd_date() %></td>
		            	<td><%=orDTOarr.get(i).getUser_nick()%></td>
						<td>
							<%if(orDTOarr.get(i).getOrd_way() != null && orDTOarr.get(i).getOrd_way().equals("배달")){ %>
								<%=orDTOarr.get(i).getOrd_sumprice()%>원
							<%}else{ %>
								<%=orDTOarr.get(i).getOrd_sumprice()%>
							<%} %>
						</td>
						<td>
							<%if(orDTOarr.get(i).getOrd_way() != null && orDTOarr.get(i).getOrd_way().equals("배달")){ %>
								2500원
							<%}else{ %>
								0원
							<%} %>
						</td>
						<td>
							<%if(orDTOarr.get(i).getOrd_way() != null && orDTOarr.get(i).getOrd_way().equals("배달")){ %>
								<%=orDTOarr.get(i).getOrd_sumprice()+2500%>원
							<%}else{ %>
								<%=orDTOarr.get(i).getOrd_sumprice()%>
							<%} %>
						</td>
						<td><%=orDTOarr.get(i).getBuy_way()%></td>
						<td><%=orDTOarr.get(i).getOrd_status()%></td>
					</tr> 
					<%cnt++;
					if(orDTOarr.size()==i+1)break;
				} 
			}
			%>
		</table>
		</form>
		<div style="margin-top:10px;">
			<div class="form-group"  style="position:relative; float:left;">
			     선택 주문&nbsp; 
		         <input type="button" value="삭제" class="btn btn-default" onClick="javascript:checkOrder(1)"> 
			</div>
     	</div>
		<div  id="edition"  align="center"  style="clear:both;">
        	<%if (orDTOarr.size()>0){
				int pageCount = orDTOarr.size()/pageSize + (orDTOarr.size()%pageSize==0 ? 0 : 1); // 게시글 전체개수/한 페이지에 표시되는 게시글수
				int pageBlock = 5;
				int startPage = ((startNum-1)/pageBlock) * pageBlock + 1;
				int endPage = startPage + pageBlock - 1;
				if (endPage>pageCount) endPage = pageCount;
				
				if (startPage>pageBlock){%>
					<input type="button" value="<" class="btn btn-default" onClick="location.href='<%=request.getContextPath()%>/admin/order/order_main.do?cmd=order_list&pageNum=<%=startPage-pageBlock%>&pageSize=<%=pageSize%>'">
	<%		}
				for(int i=startPage; i<=endPage; ++i){%>
				<%if(Integer.parseInt(pageNum)==i){ %>
					<input type="button" value="<%=i %>" class="btn btn-primary"  onClick="location.href='<%=request.getContextPath()%>/admin/order/order_main.do?cmd=order_list&pageNum=<%=i%>&pageSize=<%=pageSize%>'">		
				<%}else{ %>
					<input type="button" value="<%=i %>" class="btn btn-default"  onClick="location.href='<%=request.getContextPath()%>/admin/order/order_main.do?cmd=order_list&pageNum=<%=i%>&pageSize=<%=pageSize%>'">		
				<%} %>
	<%		}
				if (endPage<pageCount){%>
					<input type="button" value=">" class="btn btn-default" onClick="location.href='<%=request.getContextPath()%>/admin/order/order_main.do?cmd=order_list&pageNum=<%=startPage+pageBlock%>&pageSize=<%=pageSize%>'">
	<%			}
			}
%>
        </div>
	</body>
	
</html>
