<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="poly.dto.admin.ADMIN_BoardDTO" %>
<%@page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

 <% 
 	List<ADMIN_BoardDTO> bDTOArr = (List<ADMIN_BoardDTO>)request.getAttribute("boardList");
 	if(bDTOArr == null){
		bDTOArr = (List<ADMIN_BoardDTO>)request.getAttribute("boardSearchList");
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
<style>
	.table_Hline{
		padding-top:15px;
		padding-bottom:15px;
		padding-left:20px;
		padding-right:20px;
		background-color:#F2F2F2;
		font-weight:bold;
	}
	.table_line{
		padding-top:15px;
		padding-bottom:15px;
		padding-left:20px;
		padding-right:20px; 
	}
</style>
	<head>
		<title>게시판리스트</title>
		
		<!-- include javascript and css files for the EditableGrid library -->
		<!--<script src="../editablegrid-1.0.10.js"></script>-->
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/admin/editablegrid-1.0.10.css"  type="text/css" />
		
		<!-- include javascript and css files for this demo -->
		<script src="<%=request.getContextPath() %>/resources/js/admin/demo.js" ></script>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/admin/demo.css" /> 
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/admin/bootstrap.css">
		<script>
	function pageSizeEdit(pageSize){
		location.href="<%=request.getContextPath()%>/admin/board/board_list.do?pageSize="+pageSize+"&pageNum=<%=pageNum%>";
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
			location.href="<%=request.getContextPath()%>/admin/board/board_delete.do?ArrBoard_Seq="+check_Arr;
		}else if(mode==2 && check_Cnt != 0){
			location.href="<%=request.getContextPath()%>/admin/board/board_exp_yn.do?ArrBoard_Seq="+check_Arr;
		}
	}
	</script>
	</head>
	
	<body>
		<div style="position:relative; float:left; width:68%;">
            		<p>전체 게시판 수 : <%=bDTOArr.size() %></p>
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
				<th>게시판번호</th>
				<th width="35%">게시판이름</th>
				<th>읽기권한</th>
				<th>쓰기권한</th>
				<th>댓글권한</th>
				<th>전체게시글</th>
				<th>만든날자</th>
				<th>노출상태</th>
			</tr>
			<%
				if(bDTOArr.size()==0 || bDTOArr==null){%>
					<tr height="80px"><td align="center" colspan="9">게시판이 없습니다.</td></tr>	
				<%}else{
				int startCnt=(startNum-1)*pageSize;	//시작 그룹번호
				int endCnt=pageSize*startNum; //끝 그룹번호
				int cnt = 0;
				for(int i=startCnt; i<endCnt; i++){%>
					<tr id="<%=cnt%>"> 
	            	<td><input type="checkbox" name="board_check"  value="<%=bDTOArr.get(i).getBoard_seq()%>"/></td>
	                <td><%=bDTOArr.get(i).getBoard_seq()%></td>
					<td  style="cursor:pointer;" onclick="location.href='<%=request.getContextPath()%>/admin/board/board_edit.do?board_seq=<%=bDTOArr.get(i).getBoard_seq()%>'">
					<%=bDTOArr.get(i).getBoard_name() %>
					</td>
					<td>
						<%if(bDTOArr.get(i).getBoard_read()==0){ %>일반회원<%} 
						else if(bDTOArr.get(i).getBoard_read()==1){ %>사업자회원<%}
						else if(bDTOArr.get(i).getBoard_read()==9){ %>관리자<%} %>
					</td>
					<td>
						<%if(bDTOArr.get(i).getBoard_write()==0){ %>일반회원<%} 
						else if(bDTOArr.get(i).getBoard_write()==1){ %>사업자회원<%}
						else if(bDTOArr.get(i).getBoard_write()==9){ %>관리자<%} %>
					</td>
					<td>
						<%if(bDTOArr.get(i).getBoard_reple()==0){ %>일반회원<%} 
						else if(bDTOArr.get(i).getBoard_reple()==1){ %>사업자회원<%}
						else if(bDTOArr.get(i).getBoard_reple()==9){ %>관리자<%} %>
					</td>
					<td><%=bDTOArr.get(i).getBoard_p_count()%></td>
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
	         선택 게시판&nbsp; 
         <input type="button" value="삭제" class="btn btn-default" onClick="javascript:checkBoard(1)">
         <input type="button" value="노출변경" class="btn btn-default" onClick="javascript:checkBoard(2)">
	    	</div>
			<div class="form-group" style="position:relative; float:right;">
	            	<input type="button"  value="게시판 만들기"  class="btn btn-primary"  data-toggle="modal" data-target="#myModal" > 
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
					<input type="button" value="<" class="btn btn-default" onClick="location.href='<%=request.getContextPath()%>/admin/board/board_list.do?pageNum=<%=startPage-pageBlock%>&pageSize=<%=pageSize%>''">
	<%		}
				for(int i=startPage; i<=endPage; ++i){%>
					<%if(Integer.parseInt(pageNum)==i){ %>
					<input type="button" value="<%=i %>" class="btn btn-primary"  onClick="location.href='<%=request.getContextPath()%>/admin/board/board_list.do?pageNum=<%=i%>&pageSize=<%=pageSize%>'">		
					<%}else{ %>
					<input type="button" value="<%=i %>" class="btn btn-default"  onClick="location.href='<%=request.getContextPath()%>/admin/board/board_list.do?pageNum=<%=i%>&pageSize=<%=pageSize%>'">		
					<%} %>
	<%		}
				if (endPage<pageCount){%>
					<input type="button" value=">" class="btn btn-default" onClick="location.href='<%=request.getContextPath()%>/admin/board/board_list.do?pageNum=<%=startPage+pageBlock%>&pageSize=<%=pageSize%>'">
	<%		}
			}
%>
		 </div>		
<!-- Modal -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h3 class="modal-title" id="myModalLabel">&nbsp;<b>게시판 만들기</b></h3>
		      </div>
		      <div class="modal-body">
		      		<form action="<%=request.getContextPath()%>/admin/board/board_create.do" method="post"  name="board_create">
		       			<%@ include file="board_create.jsp" %>
		       		</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
		        <button type="button" class="btn btn-primary" onClick="javascript:board_create.submit()">저장</button>
		      </div>
		    </div>
		  </div>
		</div>
		
	</body>
	
</html>
