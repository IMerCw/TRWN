<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="poly.dto.admin.ADMIN_Ft_InfoDTO" %>
<%@page import="poly.dto.admin.ADMIN_Ft_ReviewDTO" %>
<%@page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

 <% 
 	List<ADMIN_Ft_ReviewDTO> revDTOarr = (List<ADMIN_Ft_ReviewDTO>)request.getAttribute("review_List");
 	ADMIN_Ft_InfoDTO ftDTO2 = (ADMIN_Ft_InfoDTO)request.getAttribute("ftDTO");
 	
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
		<title>리뷰관리</title>
		
		<!-- include javascript and css files for the EditableGrid library -->
		<!--<script src="../editablegrid-1.0.10.js"></script>-->
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/admin/editablegrid-1.0.10.css"  type="text/css" />
		
		<!-- include javascript and css files for this demo -->
		<script src="<%=request.getContextPath() %>/resources/js/admin/demo.js" ></script>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/admin/demo.css" /> 
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/admin/bootstrap.css">
	<script>
	function pageSizeEdit(pageSize){
		location.href="<%=request.getContextPath()%>/admin/ft/ft_info.do?cmd=review_list&ft_seq=<%=ftDTO2.getFt_seq()%>&pageSize="+pageSize+"&pageNum=<%=pageNum%>";
	}

	function allCheck(){
		  cbox = input_form.review_check;
		    if(cbox.length) {  // 여러 개일 경우
		        for(var i = 0; i<cbox.length;i++) {
		            cbox[i].checked=input_form.all.checked;
		        }
		    } else { // 한 개일 경우
		        cbox.checked=input_form.all.checked;
		    }
	}	
	
	function checkReview(mode){
		var cObj = document.getElementsByName("review_check"); //체크박스 값 받는 곳
		var check_Cnt = 0;
		var check_Arr = ""; //선택항목 값 담는 곳
		
		for(var i=0; i<cObj.length; i++){
			if(cObj[i].checked){
				check_Arr += cObj[i].value+',';
				check_Cnt++;
			}
		}
		if(mode==1 && check_Cnt != 0){
			location.href="<%=request.getContextPath()%>/admin/ft/ft_review_delete.do?cmd=review_list&ft_seq=<%=ftDTO2.getFt_seq()%>&ArrReview_Seq="+check_Arr;
		}else if(mode==2 && check_Cnt != 0){
			location.href="<%=request.getContextPath()%>/admin/ft/ft_review_exp_yn.do?cmd=review_list&ft_seq=<%=ftDTO2.getFt_seq()%>&ArrReview_Seq="+check_Arr;
		}
	}
	</script>
	
	</head>
	
	<body>
			<div style="float:left; width:70%; height:42px;">
				<h3>리뷰관리</h3>
			</div>
			<div style="float:right; width:30%; height:42px; text-align:right; padding-top:15px;">
				<input type="button" class="btn btn-default" value="뒤로가기" onclick="location.href='<%=request.getContextPath()%>/admin/ft/ft_info.do?ft_seq=<%=ftDTO2.getFt_seq()%>'">
			</div>
			<div style="clear:both;"></div>
			<hr>
            	<div style="position:relative; float:left; width:68%;">
            		<p>전체 리뷰 수 : <%=revDTOarr.size() %></p>
                   선택 리뷰&nbsp; 
                   <input type="button" value="삭제" class="btn btn-default" onClick="javascript:checkReview(1)"> 
                   <input type="button" value="노출변경" class="btn btn-default" onClick="javascript:checkReview(2)">
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
            	<th  width="2%"><input type="checkbox" name="all" onClick="allCheck()"/></th>
				<th>작성자</th>
				<th width="45%">제목</th>
				<th width="12%">평점</th>
				<th>작성일</th>
				<th>노출상태</th>
			</tr>
			<%
				if(revDTOarr.size()==0 || revDTOarr==null){%>
					<tr height="80px"><td align="center" colspan="6">작성된 리뷰가 없습니다.</td></tr>	
				<%}else{
				int startCnt=(startNum-1)*pageSize;	//시작 그룹번호
				int endCnt=pageSize*startNum; //끝 그룹번호
				int cnt = 0;
				for(int i=startCnt; i<endCnt; i++){%>
					<tr id="<%=cnt%>"> 
	            	<td><input type="checkbox" name="review_check" value="<%=revDTOarr.get(i).getReview_seq()%>"/></td> 
	                <td>//작성자//</td>
					<td  style="cursor:pointer;" onclick="location.href='<%=request.getContextPath()%>/admin/ft/ft_info.do?cmd=review_info&ft_seq=<%=ftDTO2.getFt_seq()%>&review_seq=<%=revDTOarr.get(i).getReview_seq()%>'">
					<%=revDTOarr.get(i).getRev_title()%>&nbsp;<b>[<%=revDTOarr.get(i).getReple_cnt()%>]</b>
					<%if(!revDTOarr.get(i).getFile_id().equals("-1")){ %>
						<img src="<%=request.getContextPath()%>/resources/img/admin/c3.png">
					<%} %>
					</td>
					<td>
					<%for(int x=0; x<5; x++){ 
						if(x<revDTOarr.get(i).getRev_point()){%>
						<img src="<%=request.getContextPath()%>/resources/img/admin/star.png" width="14%">
						<%}else{ %>
						<img src="<%=request.getContextPath()%>/resources/img/admin/non_star.png" width="14%">
						<%} %>
					<%} %>
					</td>
					<td><%=revDTOarr.get(i).getRev_regdate() %></td>
					<td>
						<%if(revDTOarr.get(i).getExp_yn()==1){ %>노출<%} 
						else if(revDTOarr.get(i).getExp_yn()==-1){ %>비노출<%}%>
					</td>
					</tr>
					<%cnt++;
					
					if(revDTOarr.size()==i+1)break;
					} 
				}
			%>
		</table>
		</form>
		<div style="margin-top:10px;">
			<div class="form-group"  style="position:relative; float:left;">
	         선택 리뷰&nbsp;
	        <input type="button" value="삭제" class="btn btn-default" onClick="javascript:checkReview(1)">
         	<input type="button" value="노출변경" class="btn btn-default" onClick="javascript:checkReview(2)">
	    	</div>
			<div class="form-group" style="position:relative; float:right;">
	            	<input type="button"  value="리뷰쓰기"  class="btn btn-primary" onclick="location.href='<%=request.getContextPath()%>/admin/ft/ft_info.do?cmd=review_create&ft_seq=<%=ftDTO2.getFt_seq()%>'" > 
	        </div> 
	     </div>
		<div  id="edition"  align="center"  style="clear:both;">
        	<%if (revDTOarr.size()>0){
				int pageCount = revDTOarr.size()/pageSize + (revDTOarr.size()%pageSize==0 ? 0 : 1); // 게시글 전체개수/한 페이지에 표시되는 게시글수
				int pageBlock = 5;
				int startPage = ((startNum-1)/pageBlock) * pageBlock + 1;
				int endPage = startPage + pageBlock - 1;
				if (endPage>pageCount) endPage = pageCount;
				
				if (startPage>pageBlock){%>
					<input type="button" value="<" class="btn btn-default" onClick="location.href='<%=request.getContextPath()%>/admin/ft/ft_info.do?cmd=review_list&ft_seq=<%=ftDTO2.getFt_seq()%>&pageNum=<%=startPage-pageBlock%>&pageSize=<%=pageSize%>''">
	<%		}
				for(int i=startPage; i<=endPage; ++i){%>
				<%if(Integer.parseInt(pageNum)==i){ %>
					<input type="button" value="<%=i %>" class="btn btn-primary"  onClick="location.href='<%=request.getContextPath()%>/admin/ft/ft_info.do?cmd=review_list&ft_seq=<%=ftDTO2.getFt_seq()%>&pageNum=<%=i%>&pageSize=<%=pageSize%>'">		
				<%}else{ %>
					<input type="button" value="<%=i %>" class="btn btn-default"  onClick="location.href='<%=request.getContextPath()%>/admin/ft/ft_info.do?cmd=review_list&ft_seq=<%=ftDTO2.getFt_seq()%>&pageNum=<%=i%>&pageSize=<%=pageSize%>'">		
				<%} %>
	<%		}
				if (endPage<pageCount){%>
					<input type="button" value=">" class="btn btn-default" onClick="location.href='<%=request.getContextPath()%>/admin/ft/ft_info.do?cmd=review_list&ft_seq=<%=ftDTO2.getFt_seq()%>&pageNum=<%=startPage+pageBlock%>&pageSize=<%=pageSize%>'">
	<%		}
			}
%>
        </div>		
	</body>
	
</html>
