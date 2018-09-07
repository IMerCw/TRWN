<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="poly.dto.admin.ADMIN_User_InfoDTO" %>
<%@page import="java.util.List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

 <% 
 	List<ADMIN_User_InfoDTO> uDTOArr = (List<ADMIN_User_InfoDTO>)request.getAttribute("userList");
 	String option = (String)request.getAttribute("option");
 	String value = (String)request.getAttribute("value");
 	
 	if(uDTOArr == null){
 		uDTOArr = (List<ADMIN_User_InfoDTO>)request.getAttribute("user_SearchList");
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
		<title>회원정보관리</title>
		
		<!-- include javascript and css files for the EditableGrid library -->
		<!--<script src="../editablegrid-1.0.10.js"></script>-->
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/admin/editablegrid-1.0.10.css"  type="text/css" />
		
		<!-- include javascript and css files for this demo -->
		<script src="<%=request.getContextPath() %>/resources/js/demo.js" ></script>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/admin/demo.css" /> 
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/admin/bootstrap.css">
		<script>
			function pageSizeEdit(pageSize){
				location.href="<%=request.getContextPath()%>/admin/user/user_search_list.do?option=<%=option%>&value=<%=value%>&pageSize="+pageSize+"&pageNum=<%=pageNum%>";
			}
		
			function allCheck(){
				  cbox = input_form.user_check;
				    if(cbox.length) {  // 여러 개일 경우
				        for(var i = 0; i<cbox.length;i++) {
				            cbox[i].checked=input_form.all.checked;
				        }
				    } else { // 한 개일 경우
				        cbox.checked=input_form.all.checked;
				    }
			}	
			
			function checkUser(mode){
				var cObj = document.getElementsByName("user_check"); //체크박스 값 받는 곳
				var check_Cnt = 0;
				var check_Arr = ""; //선택항목 값 담는 곳
				var auth_Arr = ""; //변경등급 값 담는 곳
				
				for(var i=0; i<cObj.length; i++){
					if(cObj[i].checked){
						check_Arr += cObj[i].value+',';
						check_Cnt++;
						var user_auth = document.getElementById("user_auth"+i);
						auth_Arr += user_auth.value+',';
					}
				}
				if(mode==1 && check_Cnt != 0){
					location.href="<%=request.getContextPath()%>/admin/user/user_active.do?ArrUser_Seq="+check_Arr;
				}else if(mode==2 && check_Cnt != 0){
					location.href="<%=request.getContextPath()%>/admin/user/user_drop.do?ArrUser_Seq="+check_Arr;
				}else if(mode==3 && check_Cnt != 0){
					location.href="<%=request.getContextPath()%>/admin/user/user_auth.do?ArrUser_Seq="+check_Arr+"&ArrUser_Auth="+auth_Arr;
				}
			}
		</script>
	</head>
	
	<body>
		<div style="position:relative; float:left; width:68%;">
            		<p>검색된 회원 수 : <%=uDTOArr.size()%></p>
                   선택 회원&nbsp; 
                   <input type="button" value="활동정지" class="btn btn-default" onClick="javascript:checkUser(1)"> 
                   <input type="button" value="강제탈퇴" class="btn btn-default" onClick="javascript:checkUser(2)">
                   <input type="button" value="등급변경" class="btn btn-default" onClick="javascript:checkUser(3)">
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
				<th width="8%">회원번호</th>
				<th width="35%">이메일(닉네임)</th>
				<th width="15%">등급</th>
				<th>성별</th>
				<th>핸드폰 번호</th>
				<th>가입일</th>
				<th>회원상태</th>
			</tr>
			<%
				if(uDTOArr.size()==0 || uDTOArr==null){%>
					<tr height="80px"><td align="center" colspan="8">가입된 회원이 없습니다.</td></tr>	
				<%}else{
				int startCnt=(startNum-1)*pageSize;	//시작 그룹번호
				int endCnt=pageSize*startNum; //끝 그룹번호
				int cnt = 0;
				for(int i=startCnt; i<endCnt; i++){%>
					<tr id="<%=cnt%>"> 
	            	<td><input type="checkbox" name="user_check" value="<%=uDTOArr.get(i).getUser_seq()%>"/></td>
	            	<td><%=uDTOArr.get(i).getUser_seq() %></td>
	                <td><%=uDTOArr.get(i).getUser_email()%>(<%=uDTOArr.get(i).getUser_nick()%>)</td>
					<td>
						<select class="form-control" style="width:160px;" id="user_auth<%=cnt%>">
							<option value="1" <%if(uDTOArr.get(i).getUser_auth()==1){%> selected="selected"<%}%>>일반회원</option>
							<option value="2" <%if(uDTOArr.get(i).getUser_auth()==2){%> selected="selected"<%}%>>사업자회원</option>
						</select>
					</td>
					<td><%=uDTOArr.get(i).getUser_gender() %></td>
					<td><%=uDTOArr.get(i).getUser_hp()%></td>
					<td><%=uDTOArr.get(i).getUser_regdate()%></td>
					<td>
						<%if(uDTOArr.get(i).getStatus().equals("0")){ %>정상<%} 
						else if(uDTOArr.get(i).getStatus().equals("1")){ %>활동정지<%}
						else if(uDTOArr.get(i).getStatus().equals("-1")){ %>탈퇴대기<%}%>
					</td>
					</tr>
					<%cnt++;
					
					if(uDTOArr.size()==i+1)break;
				} 
			}
			%>
		</table>
		</form>
		<div style="margin-top:10px;">
			<div class="form-group"  style="position:relative; float:left;">
	         	선택 회원&nbsp; 
                   <input type="button" value="활동정지" class="btn btn-default" onClick="javascript:checkUser(1)"> 
                   <input type="button" value="강제탈퇴" class="btn btn-default" onClick="javascript:checkUser(2)">
                   <input type="button" value="등급변경" class="btn btn-default" onClick="javascript:checkUser(3)">
	    	</div>
	     </div>
		<div  id="edition"  align="center"  style="clear:both;">
        	<%if (uDTOArr.size()>0){
				int pageCount = uDTOArr.size()/pageSize + (uDTOArr.size()%pageSize==0 ? 0 : 1); // 게시글 전체개수/한 페이지에 표시되는 게시글수
				int pageBlock = 5;
				int startPage = ((startNum-1)/pageBlock) * pageBlock + 1;
				int endPage = startPage + pageBlock - 1;
				if (endPage>pageCount) endPage = pageCount;
				
				if (startPage>pageBlock){%>
					<input type="button" value="<" class="btn btn-default" onClick="location.href='<%=request.getContextPath()%>/admin/user/user_search_list.do?option=<%=option%>&value=<%=value%>&pageNum=<%=startPage-pageBlock%>&pageSize=<%=pageSize%>''">
	<%		}
				for(int i=startPage; i<=endPage; ++i){%>
				<%if(Integer.parseInt(pageNum)==i){ %>
					<input type="button" value="<%=i %>" class="btn btn-primary"  onClick="location.href='<%=request.getContextPath()%>/admin/user/user_search_list.do?option=<%=option%>&value=<%=value%>&pageNum=<%=i%>&pageSize=<%=pageSize%>'">		
				<%}else{ %>
					<input type="button" value="<%=i %>" class="btn btn-default"  onClick="location.href='<%=request.getContextPath()%>/admin/user/user_search_list.do?option=<%=option%>&value=<%=value%>&pageNum=<%=i%>&pageSize=<%=pageSize%>'">		
				<%} %>
	<%		}
				if (endPage<pageCount){%>
					<input type="button" value=">" class="btn btn-default" onClick="location.href='<%=request.getContextPath()%>/admin/user/user_search_list.do?option=<%=option%>&value=<%=value%>&pageNum=<%=startPage+pageBlock%>&pageSize=<%=pageSize%>'">
	<%		}
			}
%>
        </div>		
	</body>
	
</html>
