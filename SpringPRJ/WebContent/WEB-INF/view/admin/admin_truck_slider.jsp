<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="poly.dto.consumer.CONSUMER_Ft_InfoDTO" %>
<%@page import="poly.dto.consumer.CONSUMER_ImageDTO" %>
<%@page import="java.util.List"%>

<%
	
	List<CONSUMER_Ft_InfoDTO> ftList2 = (List<CONSUMER_Ft_InfoDTO>)request.getAttribute("ftList");
	List<CONSUMER_ImageDTO> imgDTOs2 = (List<CONSUMER_ImageDTO>)request.getAttribute("imgDTOs");
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sly example</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.3/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Sly/1.6.1/sly.min.js"></script>
    <style>
        .frame {
            height: 320px;
            line-height: 42px;
            overflow: hidden;
        }
        .frame ul {
            list-style: none;
            margin: 0;
            padding: 0;
            height: 100%;
            font-size: 16px;
        }
        .frame ul li {
            float: left;
            width: 227px;
            height: 100%;
            margin: 0 1px 0 0;
            padding: 0;
            background: #ffffff;
            border:1px solid #cccccc;
            color: #333333;
            text-align: center;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="frame">
    <ul class="slidee">
    <%for(int cv=0; cv<ftList2.size(); cv++){ %>
    	<li onClick="location.href='<%=request.getContextPath()%>/admin/ft/ft_info.do?ft_seq=<%=ftList2.get(cv).getFt_seq()%>'">
    		<div style="height:85%">
    			<img src='<%=request.getContextPath()%>/resources/files/<%=imgDTOs2.get(cv).getFileSevname()%>' width='100%' height='99%'>
    		</div>
    		<div style="height:15%">
    			<%=ftList2.get(cv).getFt_name()%>
    		</div>
    	</li>
    <%} %>
    </ul>
</div>
<script>
    var sly = new Sly($('.frame'), {
        horizontal: 1, // required
        itemNav: 'basic', // required
        smart: 1,
        mouseDragging: 1,
        touchDragging: 1,
        releaseSwing: 1,
        scrollBy: 1,
        speed: 300,
        elasticBounds: 1,
        dragHandle: 1,
        dynamicHandle: 1,
        clickBar: 1
    }, null).init();
    var counter = 0;
    setInterval(function () {
    });
</script>
</body>
</html>