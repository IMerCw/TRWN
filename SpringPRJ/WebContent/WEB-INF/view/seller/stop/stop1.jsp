<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

	<!-- 테이블 부트스트랩 -->
	<script src="<%=request.getContextPath()%>/resources/js/admin/jquery-1.11.2.min.js"></script>
	<!-- <script src="//cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
	<link rel="stylesheet" href="//cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" /> -->

	<!-- by ADMIN JS&CSS -->
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/admin/editablegrid-1.0.10.css"  type="text/css" />
		<!-- include javascript and css files for this demo -->
		<script src="<%=request.getContextPath() %>/resources/js/admin/demo.js" ></script>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/admin/demo.css" /> 
		<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/admin/bootstrap.css">
	<!-- ----------------------- -->
		
<script>
	var TopageSize;
	var pageSize;
	var pageNum;
	var startNum;
	var total_cnt = 100;
	
	window.onload = function(){
		if (pageNum==null){//새로 목록을 불러올때 무조건 1페이지를 표시하게끔
			pageNum = "1";
			startNum = 1;
		}
		
		var TopageSize = pageSize;
		if(TopageSize==null){
			pageSize=10;
		}else{
			pageSize= TopageSize;
		}
		ajax_data();
	}
	
	function pageSizeEdit(ps, pn){
		console.log("starttt pageSize Edit" + ps + " , " + pn);
		pageSize = ps;
		pageNum = pn;
		ajax_data();
	}
	
	
	function pageMove(n,s,t){
		console.log("n : " + n);
		console.log("s : " + s);
		console.log("t : " + t);
		pageNum = 0;
		pageSize = 0;
		console.log("초기화"+pageNum);
		pageNum = n;
		console.log("초기화결과"+pageNum);
		pageSize = s;
		total_cnt = t;
		
		ajax_data();
	}
	
	
	function ajax_data(){
	$.ajax({
		url :'/seller/stop/stop2.do',	
		method : 'post',
		data : {
			'pageNum' : pageNum,
			'pageSize' : pageSize,
			'total_cnt' : total_cnt	
		},
		success : function(data){
			console.log(data);
			total_cnt = data.total_cnt;
			pageSize = data.pageSize;
			pageNum = data.pageNum;
			startNum = pageNum;
			console.log("startNUm22 : " + startNum);
			console.log("pageSize test:" + pageSize);
			console.log("pageNum test:" + pageNum);
			console.log("total_cnt : "+ total_cnt );
			
			
			var pageSelect = '';
			pageSelect += '<div style=" position:relative; float:right; margin-bottom:10px; margin-right:10px;">';
			pageSelect += '<select name="boardCount" class="form-control" onchange="javascript:pageSizeEdit(this.value,'+pageNum+')">';
			pageSelect += '<option selected="selected">'+pageSize+'개씩 보기 </option>';
			pageSelect += '<option value="10">10개씩 보기</option>';
			pageSelect += '<option value="15">15개씩 보기</option>';
			pageSelect += '<option value="30">30개씩 보기</option>';
			pageSelect += '<option value="50">50개씩 보기</option>';
			pageSelect += '<option value="100">100개씩 보기</option>';
			pageSelect += '</select>';
			pageSelect += '</div>';
			
			$('#pageSelect').html(pageSelect); 
			
			var result = data.I0490;
			/* console.log("result size : "+data.size);
			console.log("result : "+result.row[0]);
			console.log("result.RESULT : "+result.row[0].BSSHNM);  */
			var contentLi ='';
				contentLi +='<table id="htmlgrid" class="testgrid" style="width:1920px;">';
				contentLi +='<tr>';
				contentLi +='<th>식품분류</th>';
				contentLi +='<th>제품명</th>';
				contentLi +='<th>회수사유</th>';
				contentLi +='<th>등록일</th>';
				contentLi +='<th>제조업체명</th>';
				contentLi +='<th>포장단위</th>';
				contentLi +='<th>회수방법</th>';
				contentLi +='<th>바코드번호</th>';
				contentLi +='<th>제조일자</th>';
				contentLi +='<th>전화번호</th>';
				contentLi +='<th>업체주소</th>';
				contentLi +='</tr>';
				contentLi +='<tbody>';
				
			console.log("test");
			console.log(data.I0490.row);
			
				$.each(data.I0490.row, function (key,value){
					
						console.log("resultis" + value.PRDLST_TYPE);
						contentLi +='<tr>';
						contentLi +='<td>'+value.PRDLST_TYPE+'<br/><a href="'+value.IMG_FILE_PATH+'" target="_blank" style="font-size:12px; color:#333333;">&lt;제품이미지&gt;</a></td>';
						contentLi +='<td>'+value.PRDTNM+'</td>';
						contentLi +='<td>'+value.RTRVLPRVNS+'</td>';
						contentLi +='<td>'+value.CRET_DTM+'</td>';
						contentLi +='<td>'+value.BSSHNM+'</td>';
						contentLi +='<td>'+value.FRMLCUNIT+'</td>';
						contentLi +='<td>'+value.RTRVLPLANDOC_RTRVLMTHD+'</td>';
						contentLi +='<td>'+value.BRCDNO+'</td>';
						contentLi +='<td>'+value.MNFDT+'</td>';
						contentLi +='<td>'+value.PRCSCITYPOINT_TELNO+'</td>';
						contentLi +='<td>'+value.ADDR+'</td>';
						contentLi +='</tr>';
				});  
				contentLi +='</tbody>';
				contentLi +='</table>';
				console.log(contentLi);
				
				//리스트 테이블 옵션 
				$('#stop').html(contentLi); 
				
				
				/* $('#DT').DataTable({
					"pageLength": 5,
					"lengthMenu": [ 5, 10, 15 ],
					"pagingType": "simple",
				    "order": [[2,'asc']],
				    "searching": false,
				    "info": false
				}); */
				/* $(document).ready( function () {
				    $('#DT').DataTable();
				} ); */
				console.log("if test start");
				if (total_cnt>0){
					var pageing = '';
					var pageCount = total_cnt/pageSize + (total_cnt % pageSize == 0 ? 0 : 1);
					var pageBlock = 5;
					var startPage = (Math.floor(eval(startNum-1)/pageBlock) * pageBlock + 1);
					var endPage = startPage + eval(pageBlock - 1);
					console.log("pageCount : " + pageCount);
					console.log("pageBlock : " + pageBlock);
					console.log("startPage : " + startPage);
					console.log("endPage : " + endPage);
					if (endPage>pageCount) endPage = pageCount;
					if (startPage>pageBlock){
						pageing += '<input type="button" value="<" class="btn btn-default" onClick="JavaScript:pageMove('+eval(startPage-pageBlock)+','+pageSize+','+total_cnt+');">';
					}
					
					for(var i=startPage; i<=endPage; ++i){
						if(pageNum==i){ 
							pageing += '<input type="button" value="'+i+'" class="btn btn-primary" onClick="JavaScript:pageMove('+i+','+pageSize+','+total_cnt+');">';
						}else{ 
							pageing += '<input type="button" value="'+i+'" class="btn btn-default" onClick="JavaScript:pageMove('+i+','+pageSize+','+total_cnt+');">';
						} 
					}
					
					if (endPage<pageCount){
						pageing += '<input type="button" value=">" class="btn btn-default" onClick="JavaScript:pageMove('+eval(startPage+pageBlock)+','+pageSize+','+total_cnt+');">';
					}
					console.log("test count");
					console.log(startPage+pageBlock+','+pageSize+','+total_cnt);
					$('#edition').html(pageing); 
				}
				console.log("if test end");
			}
		}) 
	}
</script>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>트럭왔냠 - 식품안전정보</title>
</head>
<body>
	   
		<div>
			<%@ include file="/WEB-INF/view/seller/top.jsp" %>
		</div>
		<div style="float:right; width:32%; padding-top:30px;" id="pageSelect">
		
        </div>
		<div style="width:100%; overflow-x:scroll;">
		
		<div id="stop" style="height:50%">
		
		
		</div>
		<div id="edition"  align="center"  style="clear:both;">
        
        </div>		
	</div>
	<div>
		
	</div>
</body>
</html>