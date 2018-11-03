<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="poly.dto.admin.ADMIN_Ft_InfoDTO" %>
<%@page import="poly.dto.admin.ADMIN_Ft_Menu_CateDTO" %>
<%@page import="poly.dto.admin.ADMIN_Menu_InfoDTO" %>
<%@page import="poly.dto.admin.ADMIN_ImageDTO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	ADMIN_Ft_InfoDTO ftDTO2 = (ADMIN_Ft_InfoDTO)request.getAttribute("ftDTO");
	List<ADMIN_Ft_Menu_CateDTO> cateDTOarr = (List<ADMIN_Ft_Menu_CateDTO>)request.getAttribute("cateDTOarr");
	List<ADMIN_Menu_InfoDTO> menuDTOarr = (List<ADMIN_Menu_InfoDTO>)request.getAttribute("menuDTOarr");
	List<ADMIN_ImageDTO> imgDTOarr = (List<ADMIN_ImageDTO>)request.getAttribute("imgDTOarr");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>트럭왔냠 - 내 트럭 관리</title>
</head>
<body>
			<div style="float:left; width:70%; height:42px;">
				<h3>메뉴/카테고리</h3>
			</div>
			<div style="float:right; width:30%; height:42px; text-align:right; padding-top:15px;">
				<input type="button" class="btn btn-default" style="height: 36px; font-size: 18px; font-weight: bold;"
					value="카테고리 설정" onclick="location.href='<%=request.getContextPath()%>/seller/ft/ft_info.do?cmd=category_list&ft_seq=<%=ftDTO2.getFt_seq()%>'">
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
			  				style="border-radius:4px; border:1px solid #D9534F; box-sizing:border-box;"
			  			<%}%>>
				  			<%=cateDTO.getCate_name()%>
				  		</a>
			  		</li>
			  	<%}else{%> 
			  		<li role="presentation">
			  			<a href="#cate<%=cateDTO.getCate_sort_no()%>" aria-controls="cate<%=cateDTO.getCate_sort_no()%>" role="tab" data-toggle="tab"
			  			<%if(cateDTO.getExp_yn()==-1){%>
			  				style="border-radius:4px; border:1px solid #D9534F; box-sizing:border-box;"
			  			<%}%>>
			  				<%=cateDTO.getCate_name()%>
			  			</a>
			  		</li>
			  	<%} %>
			  <%} %>
			  </ul>
			
			  <!-- Tab panes -->
			  <div class="tab-content" style="margin-top:10px; height:620px; overflow:auto;">
			  	<%int i=0; %>
			  	<%for(ADMIN_Ft_Menu_CateDTO cateDTO : cateDTOarr){ %>
			  		<%if(cateDTO.getCate_sort_no()==1){ %>
			  			<div role="tabpanel" class="tab-pane active" id="home">
			  		<%}else{ %>
			  			<div role="tabpanel" class="tab-pane" id="cate<%=cateDTO.getCate_sort_no()%>">
			  		<%} %>
			  			<%for(ADMIN_Menu_InfoDTO menuDTO : menuDTOarr){ %>
			  				<%if(cateDTO.getCate_sort_no()==menuDTO.getCate_sort_no()){ %>
			  					<div style="border:1px solid #cccccc; width:150px; height:200px; margin:3px; float:left; cursor:pointer;"
			  					onmouseover="this.style='border:1px solid #D9534F; width:150px; height:200px; margin:3px; float:left; cursor:pointer;'"
			  					onmouseout="this.style='border:1px solid #cccccc; width:150px; height:200px; margin:3px; float:left; cursor:pointer;'"
			  					onclick="location.href='<%=request.getContextPath()%>/seller/ft/ft_info.do?cmd=menu_info&ft_seq=<%=ftDTO2.getFt_seq()%>&menu_seq=<%=menuDTO.getMenu_seq()%>'">
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
				  			<div style="border:1px solid #cccccc; width:150px; height:200px; margin:3px; float:left; cursor:pointer; text-align:center;"
				  					onmouseover="this.style='border:1px solid #D9534F; width:150px; height:200px; margin:3px; float:left; cursor:pointer; background-color:#f2f2f2;'"
				  					onmouseout="this.style='border:1px solid #cccccc; width:150px; height:200px; margin:3px; float:left; cursor:pointer; background-color:#f2f2f2;'"
				  					onclick="location.href='<%=request.getContextPath()%>/seller/ft/ft_info.do?cmd=menu_create&ft_seq=<%=ftDTO2.getFt_seq()%>&cate_sort_no=<%=cateDTO.getCate_sort_no()%>'">
					    			<img src="<%=request.getContextPath()%>/resources/img/admin/menu_create_icon.png">
					    	</div>
			  			</div>
			  	<%} %>
			  </div>
			  <div style="margin-top:10px; margin-bottom:10px; border-bottom:1px solid #f2f2f2;"></div>
			</div>
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) --> 
		<script src="<%=request.getContextPath()%>/resources/js/admin/jquery-1.11.2.min.js"></script> 
		<!-- Include all compiled plugins (below), or include individual files as needed --> 
		<script src="<%=request.getContextPath()%>/resources/js/admin/bootstrap.min.js"></script>
</body>
</html>