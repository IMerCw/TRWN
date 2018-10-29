<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- 테이블 부트스트랩 -->

<script src="//cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="//cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" />
<script>
 	$.ajax({
		url :'/seller/stop/stop2.do',	
		method : 'post',
		data : {
			},
		success : function(data){
			console.log(data);
			
			var result = data.I0490;
			/* console.log("result size : "+result.size);
			console.log("result : "+result.row[0]);
			console.log("result.RESULT : "+result.row[0].BSSHNM); */
			var contentLi ='';
				contentLi +='<table border="1px solid black" width="80%" height="100%" id="DT">';
				contentLi +='<thead>';
				contentLi +='<tr>';
				contentLi +='<th height="50px;" rowspan="3">식품분류</th>';
				contentLi +='<th>제품명</th>';
				contentLi +='<th>회수사유</th>';
				contentLi +='<th>등록일</th>';
				contentLi +='<th>제조업체명</th>';
				contentLi +='<th>포장단위</th>';
				contentLi +='</tr>';
				contentLi +='<tr>';
				contentLi +='<th>회수방법</th>';
				contentLi +='<th>바코드번호</th>';
				contentLi +='<th>제조일자</th>';
				contentLi +='<th>전화번호</th>';
				contentLi +='<th>업체주소</th>';
				contentLi +='</tr>';
				contentLi +='<tr>';
				contentLi +='<th colspan="5">제품사진url</th>';
				contentLi +='</tr>';
				
				
				contentLi += '</thead>';
				contentLi +='<tbody>';
				
				 $.each(data,function (key,value){
					console.log(value);
					console.log("valuerowis"+ value.row);
					console.log("value.row[0]" + value.row[0]);
					console.log(value.row[0].BSSHNM);
					
					value.row.forEach(function(element) {
						console.log("resultis" + element.PRDTNM);
						contentLi +='<tr>';
						contentLi +='<td height="50px;" rowspan="3">'+element.PRDLST_TYPE+'</td>';
						contentLi +='<td>'+element.PRDTNM+'</td>';
						contentLi +='<td>'+element.RTRVLPRVNS+'</td>';
						contentLi +='<td>'+element.CRET_DTM+'</td>';
						contentLi +='<td>'+element.BSSHNM+'</td>';
						contentLi +='<td>'+element.FRMLCUNIT+'</td>';
						contentLi +='</tr>';
						contentLi +='<tr>';
						contentLi +='<td>'+element.RTRVLPLANDOC_RTRVLMTHD+'</td>';
						contentLi +='<td>'+element.BRCDNO+'</td>';
						contentLi +='<td>'+element.MNFDT+'</td>';
						contentLi +='<td>'+element.PRCSCITYPOINT_TELNO+'</td>';
						contentLi +='<td>'+element.ADDR+'</td>';
						contentLi +='</tr>';
						contentLi +='<tr>';
						contentLi +='<td colspan="5"><a href="'+element.IMG_FILE_PATH+'">제품사진</a></td>';
						contentLi +='</tr>';
					});
				});  
				contentLi +='</tbody>';
				contentLi +='</table>';
				console.log(contentLi);
				//리스트 테이블 옵션 
				$('#stop').html(contentLi); 
				
				/* $('#DT').DataTable({
				
				}); */
				$(document).ready( function () {
				    $('#DT').DataTable({
				    	"pageLength": 5,
						"lengthMenu": [ 5, 10, 15 ],
						"pagingType": "simple",
					    "order": [[2,'asc']],
					    "searching": false,
					    "info": false
				    	
				    });
				} );
		}
	}) 

</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	   
	<div>
		<%@ include file="/WEB-INF/view/seller/top.jsp" %>
	</div>
	
	<div style="height:5%; backgroud-color:white;" ></div>
	
	<div id="stop" style="height:50%">
	</div>
	
	<div>
		
	</div>
</body>
</html>