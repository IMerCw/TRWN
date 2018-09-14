<%@page import="poly.dto.cmmn.CMMN_UserDTO"%>
<%@page import="java.io.Console"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="poly.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<HashMap> Ilist = (List<HashMap>)session.getAttribute("Ilist");
	String sum = (String)request.getAttribute("sum");
	if(Ilist == null){
		sum = "";
	}
	
	CMMN_UserDTO uDTO = (CMMN_UserDTO)request.getAttribute("uDTO");
	
	
	String hour = new SimpleDateFormat("HH").format(new Date());
	hour = CmmUtil.nvl(hour, "0");
	String minute = new SimpleDateFormat("mm").format(new Date());
	//시간 설정하기 위한 변수
	int tmpMinute = Integer.parseInt(minute);
	tmpMinute = (tmpMinute/10)*10 + 10;
	
	/* Map<String, TmpDTO> tMap = (Map<String, TmpDTO>)session.getAttribute("Ilist");
	if(tMap == null){
		tMap = new HashMap();	
	} */
	session.setAttribute("userHp", uDTO.getUserHp());
	
	String ftSeq = (String)session.getAttribute("ftSeq");
	
	
%>
	
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>order</title>
	
	<meta name="viewport" content="width=device-width, initial-scale=1">
  
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	
	<!-- icon -->
	<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/solid.js" integrity="sha384-+Ga2s7YBbhOD6nie0DzrZpJes+b2K1xkpKxTFFcx59QmVPaSA8c7pycsNaFwUK6l" crossorigin="anonymous"></script>
	<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/fontawesome.js" integrity="sha384-7ox8Q2yzO/uWircfojVuCQOZl+ZZBg2D2J5nkpLqzH1HY0C1dHlTKIbpRz/LG23c" crossorigin="anonymous"></script>
	
	<!-- 우편검색 -->
	<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
	<script>
	    function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var fullAddr = ''; // 최종 주소 변수
	                var extraAddr = ''; // 조합형 주소 변수
	
	                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    fullAddr = data.roadAddress;
	
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    fullAddr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	                if(data.userSelectedType === 'R'){
	                    //법정동명이 있을 경우 추가한다.
	                    if(data.bname !== ''){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있을 경우 추가한다.
	                    if(data.buildingName !== ''){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
	                document.getElementById('sample6_address').value = fullAddr;
	
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById('sample6_address2').focus();
	            }
	        }).open();
	    }
	</script>
	
<!-- 접기 펼치기 -->
	<script type="text/javascript">
		function toggleBtn(){
			if($('#toggleupdown').hasClass('fa-chevron-up')){
				$('#toggleupdown').removeClass('fa-chevron-up');
				$('#toggleupdown').addClass('fa-chevron-down');
			}else{
				$('#toggleupdown').removeClass('fa-chevron-down');
				$('#toggleupdown').addClass('fa-chevron-up');
			}
			$('#orderInfo').toggle();
		}
		function deliveryBtn(){
			if($('#deliveryupdown').hasClass('fa-chevron-up')){
				$('#deliveryupdown').removeClass('fa-chevron-up');
				$('#deliveryupdown').addClass('fa-chevron-down');
			}else{
				$('#deliveryupdown').removeClass('fa-chevron-down');
				$('#deliveryupdown').addClass('fa-chevron-up');
			}
			$('#deliveryBtn').toggle();
			
		}function orderMenu(){
			if($('#orderMenuupdown').hasClass('fa-chevron-up')){
				$('#orderMenuupdown').removeClass('fa-chevron-up');
				$('#orderMenuupdown').addClass('fa-chevron-down');
			}else{
				$('#orderMenuupdown').removeClass('fa-chevron-down');
				$('#orderMenuupdown').addClass('fa-chevron-up');
			}
			$('#orderMenu').toggle();
			
		}function coupon(){
			if($('#couponupdown').hasClass('fa-chevron-up')){
				$('#couponupdown').removeClass('fa-chevron-up');
				$('#couponupdown').addClass('fa-chevron-down');
			}else{
				$('#couponupdown').removeClass('fa-chevron-down');
				$('#couponupdown').addClass('fa-chevron-up');
			}
			$('#coupon').toggle();
			
		}function card(){
			if($('#cardupdown').hasClass('fa-chevron-up')){
				$('#cardupdown').removeClass('fa-chevron-up');
				$('#cardupdown').addClass('fa-chevron-down');
			}else{
				$('#cardupdown').removeClass('fa-chevron-down');
				$('#cardupdown').addClass('fa-chevron-up');
			}
			$('#card').toggle();
		}
		
		
		//전화번호 유효성 검사 함수
		 $(function() {
		   $('#CUSTOMER_TEL').keydown(function(e){
			  	//alert("test");
		      	 /* if((e.keyCode<48 || e.keyCode>57)&&e.keyCode!=8&&(e.keyCode<96||e.keyCode>105)){
		         alert("전화번호는 숫자만 입력됩니다.");
		         return false;
		      }   */
		   });
		  }); 
		
		function radioPhonCheck(){
			var phonCheckBox = document.getElementsByName('TRAN_TYPE');
			phonCheckBox[0].checked = true;
		}
		
		function radioCardCheck(){
			var cardCheckBox = document.getElementsByName('TRAN_TYPE');
			cardCheckBox[1].checked = true;
		}
		
		
		/*******************************************************************************
		 * 연락처 포멧 사용법 : id1,id2,id3에 해당 input id를 string 형태로 넣는다. EX) if(
		 * !telChk('telNum1', 'telNum2', 'telNum3' ) ){ return; }
		 ******************************************************************************/
		function telChk(id1, id2, id3) {

			var tel1 = document.getElementById(id1);
			var tel2 = document.getElementById(id2);
			var tel3 = document.getElementById(id3);

			var tel1v = tel1.value;
			var tel2v = tel2.value;
			var tel3v = tel3.value;

			if ( tel1v == "" || tel2v == "" || tel3v == "" ) {
				alert("연락처를 확인해 주십시오. ");
				tel1.focus();

				return (false);

			} else {

				if ( !(tel2v.length == 3 || tel2v.length == 4) ) {
					alert("연락처 가운데 자릿수를 확인해 주십시오.");
					tel2.focus();
					return (false);
				}

				if ( tel3v.length != 4 ) {
					alert("연락처 마지막 자릿수를 확인해 주십시오.");
					tel3.focus();
					return (false);
				}
			}

			return (true);
		}
		 /*****************************************************************************
			 * numPhn을 class를 이용한 숫자체크 사용법 : 태그 class 에 numPhn를 추가해준다. 단, 입력태그만 가능 (text,
			 * input) even KeyCode 추가 빽스페이스와 탭 은 허용(20150422)
			 ****************************************************************************/
	/* 	 $(function() {
			 $("#CUSTOMER_TEL").keyup(function(e) {

				if ( e.keyCode == "8" || e.keyCode == "9" ) {
				} else {
					if ( !$.numberChk($(this).val()) ) {

						$(this).val("");
						alert("숫자만 가능합니다.");
						$(this).val("");
						return false;
					}
				}

				return true;
			});
		 });  */
		 
	

		
		
	/************************************************************************************************************* 
	결제화면 
	상품명은 ~~외 몇건 이런식으로 데이터 보내고 

	아래 여분 데이터 etc? 인가 있는데 거기에 
	메뉴 수량이랑 이름 split 으로 ,엮어서 다 보내고 나중에 그 부분을 받아서 DB에 저장합니다 .
 	*/	
 	
 	
 </script>
 <script>
 /* 쿠폰 리스트 가져오기  */
 	var sum = 0;
	function couponList(){
	var userSeq = <%=uDTO.getUserSeq() %>;
	sum = <%=sum%>;
			$.ajax({
				url:"/seller/orderinfo/coupon.do",
				method:"post",
				data : {
					"userSeq" : userSeq
				},
				success : function(data){
					console.log(data);
					
					
					 var content = "";
						content += "<table class='col-sm-12'>";
						content += " <thead> ";
						content += " <tr style='border-bottom:1px solid black;'> ";
						content += " <th style='text-align: center;'>선택</th> ";
						content += " <th style='text-align: center;'>쿠폰코드</th> ";
						content += " <th style='text-align: center;'>쿠폰명</th> ";
						content += " <th style='text-align: center;'>기간</th>";
						content += " <th style='text-align: center;'>수량</th> ";
						content += " <th style='text-align: center;'>쿠폰옵션</th>";
						content += " </tr> ";
						content += " </thead> ";
						content += " <tbody> ";
						
						$.each(data, function(key,value){
						var option = value.coupon_option.split("/");
						console.log(option);
						var sale = option[0];
						console.log(option[0]);
						console.log("sale : " + sale);
						useWay = option[1];
						option = option[0]+option[1];
						
						
							content += "<tr style='border-bottom:1px solid black;'>";
							content += "<td style='text-align: center;'>";
							content += "<input type='radio' name='couponUse' value='"+value.coupon_code+"/"+sale+"/"+useWay+"/"+value.coupon_use+"'";
							content += "</td>";
							content += "<td style='text-align: center;'>"+ value.coupon_code+"</td>";
							content += "<td style='text-align: center;'>"+ value.coupon_name+"</td>";
							content += "<td style='text-align: center;'>"+ value.coupon_date+"</td>";
							content += "<td style='text-align: center;'>"+ value.coupon_count+"</td>";
							content += "<td style='text-align: center;'>"+ option+"</td>";
							content += "</tr>";
						});
						content += "</tbody>";
						content += "</table>"; 
						content += "<div style='text-align: center;' id='couponSum'>";
						content +=  "총결제 금액 : "+sum;
					 	content += "<button type='button' class='btn btn-default' onclick='JavaScript:couponUseFunc(); return false;'>사용</button>";
					 	content += "</div>";
					$('#couponList').html(content);
					
					
				}
			})
			
		 }

</script>
<script>
	 var code =0;
	 var useVal=0;
	function couponUseFunc(){
		
		
		
		var couponUse = document.querySelector('input[name="couponUse"]:checked').value;
		
		
		var UseSplit = couponUse.split("/");
		//alert("UseSplit : " + UseSplit);
		code = UseSplit[0];
		var sale = UseSplit[1];
		var useWay = UseSplit[2];
			useVal = UseSplit[3];
		//alert("useVal : " + useVal);
		//alert("Code : " + code);
		//alert("sale : " + sale);
		//alert("useWay : " + useWay);
		
			if(useWay == '원'){
				//alert("원입니다.");
				
				sum = <%=sum%>-sale ;
				//alert("sum  : " + sum);
				$('#couponSum').text("총결제 금액 : "+sum+"원");
				$('#sum').text(sum+"원 결제하기"); 
			}else{
				 //alert("%입니다.")
				sum = <%=sum%>-(<%=sum%>/sale) ;
				//alert("sum : " + sum);
				$('#couponSum').text("총결제 금액 : "+sum+"원");
				$('#sum').text(sum+"원 결제하기");  
			}
		
	}
	
	
	
	// submit
	function doSubmitOrder(){
		
		var f = document.getElementById("frmPayment");
		if(document.getElementById('CUSTOMER_NAME').value==""){
			alert("이름을 입력해주세요");
			document.getElementById('CUSTOMER_NAME').focus();
			return false;
		}
		if(document.getElementById('CUSTOMER_TEL').value == ""){
			alert("연락처를 입력해 주세요.");
			document.getElementById('CUSTOMER_TEL').focus();
			return false;
		}
		
		//alert(sum);
		f.sumPrice.value=sum;
		
		//ajax 로 couponUse 사용 값 컨트롤러 태우기 
		$.ajax({
			url: "/seller/coupon/couponUse.do",
			method : "post",
			data : {
				"couponCode" : code,
				"useVal" : useVal
			},
			success : function(data){
				console.log(data);	
			}			
		});
		
		
		f.submit();
	
		/* var tel1 = $('#CUSTOMER_TEL1').val();
		var tel2 = $('#CUSTOMER_TEL2').val();
		var tel3 = $('#CUSTOMER_TEL3').val();
		
		if( !telChk('CUSTOMER_TEL1', 'CUSTOMER_TEL2' ,'CUSTOMER_TEL3')){
			return;
		}; */
		/* var tel = tel1 + tel2 + tel3 ;
		f.CUSTOMER_TEL.value=tel;
		console.log(f.CUSTOMER_TEL.value); */
	}
</script>

</head>
<body>
	<table style="height: 100%; width: 100%">
		<tr height="7%" bgcolor="black">
			<td>
				<div class="contatiner">
					<h5 style="text-align:center;" class="text-white">주문서 작성</h5>
				</div>
			</td>
		</tr>
		<tr bgcolor="#EAEAEA">
			<td>
				<div style="height:100%; width:100%;">
					<form class="form" method="post" name="frmPayment" id="frmPayment" action="https://pg.paynuri.com/paymentgateway/mobile/reqPay.do" accept-charset="euc-kr" target="_self">
						<!-- <input type="hidden" id="REP_CODE" name="REP_CODE" value="0000"> -->
						<!-- 가맹점 번호 -->
						<input type="hidden" id="STOREID" name="STOREID" value="1500000088" readonly="readonly" />
						<!-- 가맹점 key -->
						<input type="hidden" id="CRYPTO_KEY" name="CRYPTO_KEY" value="AF866C9C429290750A6D4255590C0328" />
						<!-- 가맹점 명 -->
						<input type="hidden" id="STORE_NAME" name="STORE_NAME" value="페이누리쇼핑몰" />
						<!-- 가맹점 로고 -->
						<input type="hidden" id="STORE_LOGO" name="STORE_LOGO" value="https://demo.paynuri.com/images/logo_shop.png" />
						<!-- 사업자 번호 -->
						<input type="hidden" id="BUSINESS_NO" name="BUSINESS_NO" value="1068621229" />
						<!-- 가맹점 주문 번호 -->
						<input type="hidden" id="TRAN_NO" name="TRAN_NO" value="1533290500507" size=20 maxlength=20 />
						<!-- 상품 구분 -->
						<input type="hidden" id="PRODUCTTYPE_1" name="PRODUCTTYPE" value="1" checked="checked"/>
						<input type="hidden" id="PRODUCTTYPE_2" name="PRODUCTTYPE" value="2" />
						<!-- 결제금액 -->
						<input type="hidden" id="sumPrice" name="sumPrice" value="0" />
						<!-- 상품명   !!!!!!!!!!!!!!!!!!!!!!!!이거는 바꿔줘야하는 파라미터!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
						<%--  <%
							String prdtNames = "";
							int prdtCnt = 0;
							if(tMap.size()>1){
								prdtCnt = tMap.size() - 1;
								Iterator<String> keys = tMap.keySet().iterator();
								String key = keys.next();
								TmpDTO tDTO = tMap.get(key);
								prdtNames += tDTO.getTmpPrdtName() + " 외 " + prdtCnt;
							}else{
								Iterator<String> keys = tMap.keySet().iterator();
								String key = keys.next();
								TmpDTO tDTO = tMap.get(key);
								prdtNames += tDTO.getTmpPrdtName();
							}
						%>  --%>
						<%
							String prdtNames2 = "";
							int prdtCnt2 = 0;
							if(Ilist.size()>1){
								prdtCnt2 = Ilist.size() -1;
								for(int i=0; i< Ilist.size(); i++){
									prdtNames2 += Ilist.get(i).get("menuName") + " 외" + prdtCnt2;
								}
							}else{
								prdtNames2 += Ilist.get(0).get("menuName");
							}
						%>
						
						
						<input type="hidden" type="text" id="GOODS_NAME" name="GOODS_NAME" value="<%=prdtNames2%>" size=15 maxlength=20 />
						<!-- 결제 금액  !!!!!!!!!!!!!!!!!!!!!!!!이거는 바꿔줘야하는 파라미터!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
						<input type="hidden" type="text" id="AMT" name="AMT" value="1004" size=8 />
						<!-- 상품 갯수 !!!!!!!!!!!!!!!!!!!!!!!!이거는 바꿔줘야하는 파라미터!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
						<input type="hidden" type="text" id="QUANTITY" name="QUANTITY" value="<%=Ilist.size() %>" size=3 maxlength=3/>
						<!-- 거래 일자  오늘 날짜로 바꿔주기-->
						<input type="hidden" id="SALE_DATE" name="SALE_DATE" value="150923" size=8 maxlength=6 />
						<!-- 고객명  !!!!!!!!!!!!!!!!!!!!!!!!이거는 바꿔줘야하는 파라미터!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
						<!-- <input type="hidden" id="CUSTOMER_NAME" name="CUSTOMER_NAME" value="홍길동" size=30 maxlength=100 /> -->
						<!-- 리턴 URL  !!!!!!!!!!!!!!!!!!!!!!!!이거는 바꿔줘야하는 파라미터!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
						<input type="hidden" id="RETURN_URL" name="RETURN_URL" value="http://54.180.77.82:8080/orderComplete.do" size=30 maxlength=100 />
						<!-- 결제 성공  URL !!!!!!!!!!!!!!!!!!!!!!!!이거는 바꿔줘야하는 파라미터!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
						<input type="hidden" id="COMPLETE_URL" name="COMPLETE_URL" value="http://54.180.77.82:8080/orderSuccess.do?uNo=<%=CmmUtil.nvl((String)session.getAttribute("ss_user_no"))%>" size=30 maxlength=100 />
						<!-- 결제도중 취소  URL !!!!!!!!!!!!!!!!!!!!!!!!이거는 바꿔줘야하는 파라미터!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!-->
						<input type="hidden" id="CANCEL_URL" name="CANCEL_URL" value="http://54.180.77.82:8080/orderCancelResult.do" size=30 maxlength=100 />
						<!-- 여분의 데이터 1 -->
						<input type="hidden" id="ETC_DATA1" name="ETC_DATA1" value="<%=uDTO.getUserSeq()%>,<%=ftSeq%>" />
						<!-- 여분의 데이터 2 -->
						<!-- 여분의 데이터 3 -->
						<%--<%
							String orderItems = "";
							Iterator<String> keyss = tMap.keySet().iterator();
							while(keyss.hasNext()){
								String key = keyss.next();
								TmpDTO tDTO = tMap.get(key);
								orderItems += tDTO.getTmpPrdtNo() + ":" + tDTO.getTmpPrdtQty()  + "-";
							}
						%> --%>
						<%
							String orderItems2 = "";
							for(int i=0; i< Ilist.size(); i++){
								orderItems2 += Ilist.get(i).get("menuName") + " : " + Ilist.get(i).get("amnt") + "-";
							}
							
						%>
						
						
						<input type="hidden" id="ETC_DATA3" name="ETC_DATA3" value="<%=orderItems2%>" />
						
									
							<!-- 주문자 정보  -->
							<section class="section-orderer" style="background-color:white;">
								<h6 class="title-sugject">
									<a href="#" onclick="JavaScript:toggleBtn();" style="text-decoration:none; color:black;">
										<span class="fas fa-chevron-up" id="toggleupdown"></span>
										<b>주문자 정보</b>
									</a>
								</h6>
								<div style="display:block;" id="orderInfo">
								<hr>
									<div class="col-sm-12">
										이름 : <input type="text" value="<%=uDTO.getUserNick() %>" name="CUSTOMER_NAME" id="CUSTOMER_NAME" class="col-sm-11" style="text-align:center; padding:0;"/>
									</div>
									<br/>
									<div class="col-sm-12">
										휴대전화 : <input type="tel" value="<%=uDTO.getUserHp() %>" name="CUSTOMER_TEL" id="CUSTOMER_TEL" maxlength="11" size="11" class="col-sm-10" style="text-align:center;padding:0;">
									</div>
									<br/>
									
									<div class="col-sm-12">
										희망 수령시간: 
										<select class="orderSelect form-control" id="ETC_DATA2" name="ETC_DATA2">
											<%for(int i = Integer.parseInt(hour); i< 22; i++){
												for(int j = tmpMinute; j<=50; j+=10){
													String min = "";
													if(j<10){
														min = "00"; 
													}else{
														min = j + "";
													}
													%>
											<option value="<%=i %>:<%=min %>"><%=i %> : <%=min %></option>
												<%}
												  tmpMinute = 0;
												}%>
										</select>
										<br />
										!<small>푸드트럭 특성상 시간을 정확하게 맞추지 못할 수 있습니다. 양해바랍니다^^</small> 
									</div>
									<div class="col-sm-12">
										<br/>
										<div>요청사항 </div>
										<textarea rows="3" class="col-sm-12"></textarea>
									</div>		
								</div>
								<br/>
							</section>
								<br/>
							<!-- 배송정보 -->
							<section class="section-orderer" style="background-color:white;">
								<h6 class="title-sugject">
									<a href="#" onclick="JavaScript:deliveryBtn();" style="text-decoration:none; color:black;">
										<span class="fas fa-chevron-down" id="deliveryupdown"></span>
										<b>배송지</b> 
									</a>
								</h6>
								<div style="display:none;" id="deliveryBtn">
									<hr>
									<div class="col-sm-12">
										<small style="display:block;">앱 결제시 배송가능 푸드트럭에서만 작성해주세요^^</small>
										<br/>
										<div class="col-sm-12">
											<input type="text" id="sample6_postcode" placeholder="우편번호" class="col-sm-8" style="padding:0;">
											<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"class="col-sm-3" style="padding:0;" ><br>
										</div>
										<div class="col-sm-12">
											<input type="text" id="sample6_address" placeholder="주소" class="col-sm-12">
											<input type="text" id="sample6_address2" placeholder="상세주소" class="col-sm-12">
										</div>
									</div>
								</div>
								<br/>
							</section>
							<!-- 주문내역  -->
							<br/>
							<section class="section-orderer" style="background-color:white;">
								<h6 class="title-sugject">
									<a href="#" onclick="JavaScript:orderMenu();" style="text-decoration:none; color:black;">
										<span class="fas fa-chevron-up" id="orderMenuupdown"></span>
										<b>상품정보</b> 
									</a>
								</h6>
								<div style="display:block;" id="orderMenu">
										
									<hr>
									<div class="col-sm-12">
										<table class="col-sm-12" >
											<thead >
												<tr>
													<th style="width:60%;"> 메뉴 이름 </th>
													<th style="width:20%; text-align:right;"> 가격 </th>
													<th style="width:20%; text-align:right;"> 수량 </th>
												</tr>
											</thead>
											<tbody>
												<%for(int i=0; i< Ilist.size(); i++){ %>
												<tr style="border-bottom:1px solid #BDBDBD;">
													<td> <%=Ilist.get(i).get("menuName")%> </td>
													<td style="text-align:right;"> <%=Ilist.get(i).get("menuPrice")%> </td>
													<td style="text-align:right;"> <%=Ilist.get(i).get("amnt")%> </td>
												</tr>
												<%} %>
											</tbody>
										</table>
									</div>
									
								</div>
								<br/>
							</section>
							<!-- 쿠폰 -->
							<br/>
							<section class="section-orderer" style="background-color:white;">
								<h6 class="title-sugject">
									<a href="#" onclick="JavaScript:coupon(); return false;" style="text-decoration:none; color:black;">
										<span class="fas fa-chevron-down" id="couponupdown"></span>
										<b>쿠폰</b> 
									</a>
								</h6>
								<div style="display:none;" id="coupon">
										
									<hr>
									<div class="col-sm-12" id="couponList">
										<button type="button" class="btn btn-default" onClick="JavaScript:couponList(); return false;">쿠폰조회/적용</button>
										<small>(쿠폰 허용 상품 / 일부 쿠폰 제외)</small>
									</div>
								</div>
								<br/>
							</section>
							<!-- 결제정보 -->
								<br/>
							<section class="section-orderer" style="background-color:white;">
								<h6 class="title-sugject">
									<a href="#" onclick="JavaScript:card();" style="text-decoration:none; color:black;">
										<span class="fas fa-chevron-up" id="cardupdown"></span>
										<b>결제정보</b> 
									</a>
								</h6>
								<div style="display:block;" id="card">
									<hr>
									<div class="radio icheck-asbestos">
										<input type="radio" id="TRAN_TYPE" name="TRAN_TYPE" value="PHON" checked="checked"/> <label
											for="asbestos1" onclick="radioPhonCheck();">휴대폰 소액 결제</label>
									</div>
									<div class="radio icheck-asbestos">
										<input type="radio" id="TRAN_TYPE" name="TRAN_TYPE" value="CARD"/> <label
											for="asbestos2" onclick="radioCardCheck();">신용카드(온라인 결제)</label>
									</div>
								</div>
								<br/>
							</section>
						</form>
						<button type="button" style="height:5%;"class=" btn-dark orderButton02 col-sm-12" onclick="doSubmitOrder(); return false;" id="sum"><%=sum%>원 결제하기</button>
				</div>
			</td>
		</tr>
		<tr height="7%" bgcolor="black">
			<td>
				<%@ include file="/WEB-INF/view/seller/bottom.jsp" %>
			</td>
		</tr>
	</table>
	

</body>

</html>