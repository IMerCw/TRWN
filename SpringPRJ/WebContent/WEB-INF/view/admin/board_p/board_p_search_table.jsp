<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="poly.dto.admin.ADMIN_User_InfoDTO" %>
<%@page import="poly.dto.admin.ADMIN_Board_PostDTO" %>
<%@page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

 <% 
 	List<ADMIN_Board_PostDTO> bDTOArr = (List<ADMIN_Board_PostDTO>)request.getAttribute("board_P_List");
 	List<ADMIN_User_InfoDTO> bp_uDTOarr = (List<ADMIN_User_InfoDTO>)request.getAttribute("bp_uDTOarr");
 	String option = (String)request.getAttribute("option");
 	String value = (String)request.getAttribute("value");
 	String board_select = (String)request.getAttribute("board_select");
 	if(board_select==null){
 		board_select="all";
 	}
 	if(bDTOArr == null){
		bDTOArr = (List<ADMIN_Board_PostDTO>)request.getAttribute("board_P_SearchList");
 	}
 	
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
		<title>게시물리스트</title>
		
		<!-- include javascript and css files for the EditableGrid library -->
		<!--<script src="../editablegrid-1.0.10.js"></script>-->
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/admin/editablegrid-1.0.10.css"  type="text/css" />
		
		<!-- include javascript and css files for this demo -->
		<script src="<%=request.getContextPath() %>/resources/js/admin/demo.js" ></script>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/admin/demo.css" /> 
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/admin/bootstrap.css">
	<script>
	function pageSizeEdit(pageSize){
		location.href="<%=request.getContextPath()%>/admin/board_p/board_p_search_list.do?board_select=<%=board_select%>&pageSize="+pageSize+"&pageNum=<%=pageNum%>&option=<%=option%>&value=<%=value%>";
	}

	function allCheck(){
		  cbox = input_form.board_check;
		    if(cbox.length) {  // 여러 개일 경우
		        for(var i = 0; i<cbox.length;i++) {
		            cbox[i].checked=input_form.all.checked;
		        }
		    } else { // 한 개일 경우
		        cbox.checked=input_form.all.checked;
		    }
	}	
	
	function checkBoard(mode){
		var cObj = document.getElementsByName("board_check"); //체크박스 값 받는 곳
		var check_Cnt = 0;
		var check_Arr = ""; //선택항목 값 담는 곳
		
		for(var i=0; i<cObj.length; i++){
			if(cObj[i].checked){
				check_Arr += cObj[i].value+',';
				check_Cnt++;
			}
		}
		if(mode==1 && check_Cnt != 0){
			location.href="<%=request.getContextPath()%>/admin/board_p/board_p_delete.do?ArrBoard_Seq="+check_Arr;
		}else if(mode==2 && check_Cnt != 0){
			location.href="<%=request.getContextPath()%>/admin/board_p/board_p_exp_yn.do?ArrBoard_Seq="+check_Arr;
		}
	}
	</script>
	
	</head>
	
	<body>
            	<div style="position:relative; float:left; width:68%;">
            		<p>검색된 게시물 수 : <%=bDTOArr.size() %></p>
                   선택 게시판&nbsp; 
                   <input type="button" value="삭제" class="btn btn-default" onClick="javascript:checkBoard(1)"> 
                   <input type="button" value="노출변경" class="btn btn-default" onClick="javascript:checkBoard(2)">
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
				<th>게시물번호</th>
				<th width="45%">제목</th>
				<th width="10%">작성자</th>
				<th>조회수</th>
				<th>작성일</th>
				<th>노출상태</th>
			</tr>
			<%
				if(bDTOArr.size()==0 || bDTOArr==null){%>
					<tr height="80px"><td align="center" colspan="7">게시글이 없습니다.</td></tr>	
				<%}else{
				int startCnt=(startNum-1)*pageSize;	//시작 그룹번호
				int endCnt=pageSize*startNum; //끝 그룹번호
				int cnt = 0;
				for(int i=startCnt; i<endCnt; i++){%>
					<tr id="<%=cnt%>"> 
	            	<td><input type="checkbox" name="board_check" value="<%=bDTOArr.get(i).getBoard_p_seq()%>"/></td>
	                <td><%=bDTOArr.get(i).getBoard_p_seq()%></td>
					<td  style="cursor:pointer;" onclick="location.href='<%=request.getContextPath()%>/admin/board_p/board_p_info.do?board_p_seq=<%=bDTOArr.get(i).getBoard_p_seq()%>'">
					<%if(!bDTOArr.get(i).getBoard_level().equals(String.valueOf(bDTOArr.get(i).getBoard_p_seq()))){ %>
   									<img src="<%=request.getContextPath()%>/resources/img/admin/reple_icon.png">
   								<%} %>
					<%=bDTOArr.get(i).getTitle()%>&nbsp;<b>[<%=bDTOArr.get(i).getReple_count()%>]</b>
					<%if(!bDTOArr.get(i).getFile_id().equals("-1")){ %>
						<img src="<%=request.getContextPath()%>/resources/img/admin/c3.png">
					<%} %>
					</td>
					<td><%=bp_uDTOarr.get(i).getUser_nick()%></td>
					<td><%=bDTOArr.get(i).getBoard_count() %></td>
					<td><%=bDTOArr.get(i).getReg_date() %></td>
					<td>
						<%if(bDTOArr.get(i).getExp_yn()==1){ %>노출<%} 
						else if(bDTOArr.get(i).getExp_yn()==-1){ %>비노출<%}%>
					</td>
					</tr>
					<%cnt++;
					
					if(bDTOArr.size()==i+1)break;
				} 
			}
			%>
		</table>
		</form>
		<div style="margin-top:10px;">
			<div class="form-group"  style="position:relative; float:left;">
	         선택 게시물&nbsp;
	        <input type="button" value="삭제" class="btn btn-default" onClick="javascript:checkBoard(1)">
         	<input type="button" value="노출변경" class="btn btn-default" onClick="javascript:checkBoard(2)">
	    	</div>
			<div class="form-group" style="position:relative; float:right;">
	            	<input type="button"  value="게시물 쓰기"  class="btn btn-primary" onClick="window.parent.location.href='<%=request.getContextPath()%>/admin/board_p/board_p_create.do'">
	        </div> 
	     </div>
		<div  id="edition"  align="center"  style="clear:both;">
        	<%if (bDTOArr.size()>0){
				int pageCount = bDTOArr.size()/pageSize + (bDTOArr.size()%pageSize==0 ? 0 : 1); // 게시글 전체개수/한 페이지에 표시되는 게시글수
				int pageBlock = 5;
				int startPage = ((startNum-1)/pageBlock) * pageBlock + 1;
				int endPage = startPage + pageBlock - 1;
				if (endPage>pageCount) endPage = pageCount;
				
				if (startPage>pageBlock){%>
					<input type="button" value="<" class="btn btn-default" onClick="location.href='<%=request.getContextPath()%>/admin/board_p/board_p_search_list.do?board_select=<%=board_select%>&pageNum=<%=startPage-pageBlock%>&pageSize=<%=pageSize%>&option=<%=option%>&value=<%=value%>'">
	<%		}
				for(int i=startPage; i<=endPage; ++i){%>
				<%if(Integer.parseInt(pageNum)==i){ %>
					<input type="button" value="<%=i %>" class="btn btn-primary"  onClick="location.href='<%=request.getContextPath()%>/admin/board_p/board_p_search_list.do?board_select=<%=board_select%>&pageNum=<%=i%>&pageSize=<%=pageSize%>&option=<%=option%>&value=<%=value%>'">		
				<%}else{ %>
					<input type="button" value="<%=i %>" class="btn btn-default"  onClick="location.href='<%=request.getContextPath()%>/admin/board_p/board_p_search_list.do?board_select=<%=board_select%>&pageNum=<%=i%>&pageSize=<%=pageSize%>&option=<%=option%>&value=<%=value%>'">		
				<%} %>
	<%		}
				if (endPage<pageCount){%>
					<input type="button" value=">" class="btn btn-default" onClick="location.href='<%=request.getContextPath()%>/admin/board_p/board_p_search_list.do?board_select=<%=board_select%>&pageNum=<%=startPage+pageBlock%>&pageSize=<%=pageSize%>&option=<%=option%>&value=<%=value%>'">
	<%		}
			}
%>
        </div>		
	</body>
	
</html>
