package poly.controller;


import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.executor.ReuseExecutor;
import org.apache.log4j.Logger;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.dto.admin.ADMIN_CouponDTO;
import poly.dto.admin.ADMIN_Coupon_IssueDTO;
import poly.dto.cmmn.CMMN_UserDTO;
import poly.dto.consumer.CONSUMER_Gps_TableDTO;
import poly.dto.seller.SELLER_FtSellerDTO;
import poly.dto.seller.SELLER_OrderInfoDTO;
import poly.dto.seller.SELLER_WaitDTO;
import poly.service.CONSUMER_IUserService;
import poly.service.SELLER_IOrderService;
import poly.service.impl.SELLER_OrderService;
import poly.util.CmmUtil;
import poly.util.SHA256Util;
import poly.util.UtilTime;

@Controller
public class SELLER_OrderController {
	private Logger log = Logger.getLogger(this.getClass());
	//로그를 찍고 파일로 남깁니다 .
	
	@Resource(name="SELLER_OrderService")
	private SELLER_IOrderService orderService;
	@Resource(name = "CONSUMER_UserService")
	private CONSUMER_IUserService userService;
	
	
	//회원 구매__결제 페이지 이동 Procedure 
	@RequestMapping(value="/seller/order/orderInfo", method=RequestMethod.POST)
	public String orderInfo(HttpServletRequest request,Model model) throws Exception{
		log.info(this.getClass() + "orderInfo start !!!!!!");
		String sum = CmmUtil.nvl(request.getParameter("sum"));
		log.info("sum : " + sum);
		String userSeq = CmmUtil.nvl(request.getParameter("userSeq"));
		log.info("userSeq : " + userSeq);
		String ftSeq = CmmUtil.nvl(request.getParameter("ftSeq"));
		log.info("ftSeq : " + ftSeq);
		String userAuth = "2";
		
		CMMN_UserDTO uDTO = new CMMN_UserDTO();
		
		uDTO.setUserSeq(userSeq);
		
		uDTO = orderService.getOrderUserDTO(uDTO);
		log.info("uDTO. get : " + uDTO.getUserEmail());
		log.info("uDTO. get : " + uDTO.getUserNick());
		
		model.addAttribute("uDTO",uDTO);
		model.addAttribute("sum",sum);
		model.addAttribute("ftSeq",ftSeq);
		model.addAttribute("userAuth",userAuth);
		
		log.info(this.getClass() + "orderInfo end ~~!!!");
		
		return "/seller/order/orderInfo";
	}
	
	//비회원 구매__결제 페이지 이동 Procedure
	@RequestMapping(value="/seller/order/orderInfo_nmmbr")
	public String orderInfo_nmmbr(HttpServletRequest request,Model model, HttpSession session) throws Exception{
		log.info(this.getClass() + "orderInfo start !!!!!!");
		String sum = CmmUtil.nvl(request.getParameter("sum"));
		String cstmrName = CmmUtil.nvl(request.getParameter("cstmrName"));
		String cstmrPhn = CmmUtil.nvl(request.getParameter("cstmrPhn"));
		String ftSeq = CmmUtil.nvl(request.getParameter("ftSeq"));
		String userAuth = "2";
		
		log.info(cstmrName);
		log.info("name : " + cstmrName);
		log.info("phone : " + cstmrPhn);
		
		CMMN_UserDTO uDTO = new CMMN_UserDTO();
		uDTO.setUserNick(cstmrName);
		uDTO.setUserHp(cstmrPhn);
		uDTO.setUserSeq("-1");
		
		model.addAttribute("uDTO",uDTO);
		model.addAttribute("sum",sum);
		model.addAttribute("ftSeq",ftSeq);
		model.addAttribute("userAuth",userAuth);
		
		log.info(this.getClass() + "orderInfo end ~~!!!");
		
		return "/seller/order/orderInfo";
	}
	
	
	//쿠폰 가져오기 
	@RequestMapping(value="/seller/orderinfo/coupon")
	public @ResponseBody List<ADMIN_Coupon_IssueDTO> coupon(HttpServletRequest request)throws Exception{
		log.info("coupon start !!!");
		String userSeq = CmmUtil.nvl(request.getParameter("userSeq"));
		log.info("userSeq : " + userSeq);
		//쿠폰 가져오기
		ADMIN_Coupon_IssueDTO couponList = new ADMIN_Coupon_IssueDTO();
		couponList.setUser_seq(Integer.parseInt(userSeq));
		log.info("couponLIst set userSeq : " + couponList.getUser_seq());
		List<ADMIN_Coupon_IssueDTO> couponListUse = orderService.getCpList(couponList);
		for(int i=0; i < couponListUse.size(); i++) {
			System.out.println(couponListUse.get(i).getCoupon_code());
			System.out.println("================================");
		}
		
		log.info("coupon end !!!!");
		return couponListUse;
	}
	
	//쿠폰 사용하면 사용 갯수 하나 늘리기
	@RequestMapping(value="/seller/coupon/couponUse", method=RequestMethod.POST)
	public void couponUse(HttpServletRequest request) throws Exception{
		log.info(this.getClass() + " couponUse start !!!!!");
		int code = Integer.parseInt(request.getParameter("couponCode"));
		log.info("code : " + code);
		int useVal = Integer.parseInt(request.getParameter("useVal"));
		log.info("useVal : " + useVal);
		useVal++;
		log.info("useVal++ : " + useVal);
		
		ADMIN_Coupon_IssueDTO codeDTO = new ADMIN_Coupon_IssueDTO();
		codeDTO.setIssue_code(code);
		codeDTO.setCoupon_use(useVal);
		
		int result = orderService.updateCouponUse(codeDTO);
		log.info("result : " + result);
		
		log.info(this.getClass() + " couponUse end !!!!");
	}
	
	//*******************************************************************************
	//결제 성공하면 1.DB에 저장 하고 2.소비자랑 판매자에게 알림을 띄워주고 3. 판매자는 알림뜨면 reload해서 주문대기열 DB최신 데이터로 바꿔줄 생각입니다 . 
			 
	/**************************************************************************
	 * 여기부터는 공인 ip 받고 다시 수정 들어가야 합니다 .
	 * 주문하기 코딩 일단 붙여놓을게요 
	 */
	@RequestMapping(value="/storeGpsData")
	public @ResponseBody String storeGpsData(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception{
		String gpsSeq; //리턴할 값
		String userSeq = request.getParameter("userSeq");
		String postAddress1 = request.getParameter("postAddress1");
		String postAddress2 = request.getParameter("postAddress2");
		String gpsX = request.getParameter("gpsX");
		String gpsY = request.getParameter("gpsY");
		String timeNow = UtilTime.getDateYMDhms(); //현재 시각
		
		log.info("postAddress1........" + postAddress1);
		log.info("postAddress2........" + postAddress2);
		
		CONSUMER_Gps_TableDTO gpsDTO = new CONSUMER_Gps_TableDTO();
		
		String usrGpsArr[] = postAddress1.split(" "); //1st index 지번,도로명 주소
		gpsDTO.setUser_seq(Integer.parseInt(userSeq));
		gpsDTO.setGps_sido(usrGpsArr[0]);
		gpsDTO.setGps_sigungu(usrGpsArr[1]);
		gpsDTO.setGps_dong(usrGpsArr[2]);
		
		String gpsEtc ="";
		
		for(int i = 3; i < usrGpsArr.length; i++) {
			log.info(usrGpsArr[i]);
			gpsEtc += usrGpsArr[i];
		}
		
		gpsEtc += postAddress2; //2nd index 주소 상세 정보
		log.info(gpsEtc);
		gpsDTO.setGps_etc(gpsEtc);	         
		gpsDTO.setGps_x(gpsX);	         
		gpsDTO.setGps_y(gpsY);	         
		gpsDTO.setGps_renew_date(timeNow);	         
		 
		int resultSet = userService.setGps(gpsDTO);
		 
		gpsSeq = String.valueOf(gpsDTO.getGps_seq());
		log.info("DB저장 결과_____________" + gpsSeq);
		
		return gpsSeq;
	}
		
	 //페이누리로 보내는 RETURN_URL(결제결과 데이터 받기)에 대응하는 메소드
	   @RequestMapping(value="/orderComplete")
	   public void orderComplete(HttpServletRequest req, HttpServletResponse resp, Model model, HttpSession session) throws Exception{
	      req.setCharacterEncoding("EUC-KR");
	      
		  log.info(this.getClass() + "orderComplete start!!!");
	      //결과코드
	      String rep_code =CmmUtil.nvl(req.getParameter("REP_CODE"));
	      log.info(this.getClass() + " rep_code : " + rep_code);
	      //승인 번호, 계좌 번호
	      String rep_auth_no =CmmUtil.nvl(req.getParameter("REP_AUTH_NO"));
	      log.info(this.getClass() + " rep_auth_no : " + rep_auth_no);
	      //거래 고유번호(페이누리측)
	      String tid =CmmUtil.nvl(req.getParameter("TID"));
	      log.info(this.getClass() + " tid : " + tid);
	      //은행 코드
	      String rep_bank =CmmUtil.nvl(req.getParameter("REP_BANK"));
	      log.info(this.getClass() + " rep_bank : " + rep_bank);
	      //가맹점 번호
	      String storeId   =CmmUtil.nvl(req.getParameter("STOREID"));
	      log.info(this.getClass() + " storeId : " + storeId);
	      //가맹점 이름
	      String store_name =CmmUtil.nvl(req.getParameter("STORE_NAME"));
	      log.info(this.getClass() + " store_name : " + store_name);
	      //가맹점 URL
	      String store_url =CmmUtil.nvl(req.getParameter("STORE_URL"));
	      log.info(this.getClass() + " store_url : " + store_url);
	      //사업자 번호
	      String business_no =CmmUtil.nvl(req.getParameter("BUSINESS_NO"));
	      log.info(this.getClass() + " business_no : " + business_no);
	      //가맹점 주문번호
	      String tran_no =CmmUtil.nvl(req.getParameter("TRAN_NO"));
	      log.info(this.getClass() + " tran_no : " + tran_no);
	      //카드종류
	      String cardCompany = CmmUtil.nvl(req.getParameter("CARDCOMPANY"));
	      log.info(this.getClass() + " cardCompany : " + cardCompany);
	      //상품명
	      String goods_name =CmmUtil.nvl(req.getParameter("GOODS_NAME"));
	      log.info(this.getClass() + " goods_name : " + goods_name);
	      //결제금액
	      String amt =CmmUtil.nvl(req.getParameter("AMT"));
	      log.info(this.getClass() + " amt : " + amt);
	      //상품수
	      String quantity   =CmmUtil.nvl(req.getParameter("QUANTITY"));
	      log.info(this.getClass() + " quantity : " + quantity);
	      //결제일자
	      String sale_date = CmmUtil.nvl(req.getParameter("SALE_DATE"));
	      log.info(this.getClass() + " sale_date : " + sale_date);
	      //고객이름
	      String customer_name = CmmUtil.nvl(req.getParameter("CUSTOMER_NAME"));
	      log.info(this.getClass() + " customer_name : " + customer_name);
	      //고객 이메일
	      String customer_email =CmmUtil.nvl(req.getParameter("CUSTOMER_EMAIL"));
	      log.info(this.getClass() + " customer_email : " + customer_email);
	      //고객 전화번호
	      String customer_tel = CmmUtil.nvl(req.getParameter("CUSTOMER_TEL"));
	      log.info(this.getClass() + " customer_tel : " + customer_tel);
	      //고객 아이피
	      String customer_ip =CmmUtil.nvl(req.getParameter("CUSTOMER_IP"));
	      log.info(this.getClass() + " customer_ip : " + customer_ip);
	      //입금통보URL
	      String notice_url =CmmUtil.nvl(req.getParameter("NOTICE_URL"));
	      log.info(this.getClass() + " notice_url : " + notice_url);
	      //거래 유형
	      String tran_type =CmmUtil.nvl(req.getParameter("TRAN_TYPE"));
	      log.info(this.getClass() + " tran_type : " + tran_type);
	      //결과 메세지
	      String rep_msg =CmmUtil.nvl(req.getParameter("REP_MSG"));
	      log.info(this.getClass() + " rep_msg : " + rep_msg);
	      //여분의 데이터
	      String etc_data1 =CmmUtil.nvl(req.getParameter("ETC_DATA1"));// 유저번호 , 푸드트럭번호 , gps번호 , 주문방법(직접,배달)
	      log.info(this.getClass() + " etc_data1 : " + etc_data1);
	      String etc_data2 =CmmUtil.nvl(req.getParameter("ETC_DATA2"));
	      log.info(this.getClass() + " etc_data2 : " + etc_data2);// 희망 수령시간
	      String etc_data3 =CmmUtil.nvl(req.getParameter("ETC_DATA3"));      
	      log.info(this.getClass() + " etc_data3 : " + etc_data3);//주문 제품 목록
	      
	      if(rep_code.equals("0000")){
	         /*
	         * 결제 성공
	         */
	    	 log.info("결제 성공");
	         log.info("orderss ss_user_no = " + session.getAttribute("userSeq"));
	         SELLER_OrderInfoDTO oDTO = new SELLER_OrderInfoDTO();
	         //etc_data1 첫 번째 split__유저번호( -1은 비회원 )
	         oDTO.setUser_seq(Integer.parseInt(etc_data1.split(",")[0])); 
	         log.info("oDTO get userSEq :"+ oDTO.getUser_seq());
	         //etc_data1 두 번째 split__푸드트럭 번호
	         oDTO.setFt_seq(etc_data1.split(",")[1]);
	         log.info("oDTO get ftsEQ : " +oDTO.getFt_seq());
	         //etc_data1 세 번째 split__GPS_SEQ
	         oDTO.setGps_seq(etc_data1.split(",")[2]);
	         log.info("oDTO get ftsEQ : " +oDTO.getGps_seq());
	         //etc_data1 네 번째 split__배달: 1 // 직접: -1
	         oDTO.setOrd_way(etc_data1.split(",")[3]);
	         log.info("oDTO get ftsEQ : " +oDTO.getOrd_way());
	         //etc_data1 다섯 번째 split__userAuth 1 : 소비자
	         String userAuth = etc_data1.split(",")[4];
	         log.info("userAuth : " + userAuth);
	         
	         String timeNow = UtilTime.getDateYMDhms(); //현재 시각
	         
	         String ord_date = timeNow;
	         log.info(ord_date);
	         oDTO.setOrd_date(ord_date);
	         oDTO.setTran_no(tran_no);
	         oDTO.setOrd_sumprice(Integer.parseInt(amt));
	         if(tran_type.equals("PHON")){
	            oDTO.setBuy_way("P");
	         }else{
	            oDTO.setBuy_way("C");
	         }
	         oDTO.setOrd_status(0);
	         oDTO.setUsr_rcv_time(etc_data2);
	         //oDTO.setRcv_yn("n");
	         oDTO.setTid(tid);
	         
	         
	         log.info("oDTO.setting");
	        /* String[] userNoAndMil = etc_data1.split(";");
	         String[] mil = userNoAndMil[1].split("-");
	         Map<String, String> milMap = new HashMap();
	         oDTO.setUser_no(userNoAndMil[0]);
	         if(mil[0].equals("dec")){//마일리지를 사용했을 경우 차감
	            oDTO.setMileage(mil[1]);
	            oDTO.setTotal_ord_price((Integer.parseInt(amt) + Integer.parseInt(mil[1])) + "");
	            oDTO.setReg_user_no(userNoAndMil[0]);
	            milMap.put("dec", mil[1]);
	         }else{//마일리지를 사용 안했을 경우 마일리지 증가
	            oDTO.setReg_user_no(userNoAndMil[0]);
	            oDTO.setTotal_ord_price(amt);
	            milMap.put("inc", mil[1]);
	         }*/
	        /* String[] orderItems = etc_data3.split("-");
	         List<SELLER_WaitDTO> oList = new ArrayList<SELLER_WaitDTO>();
	         for(int i = 0; i< orderItems.length; i++){
	            String[] orderItem = orderItems[i].split(":");
	        */ 
	         SELLER_WaitDTO oIDTO = new SELLER_WaitDTO();
	         oIDTO.setWaitSeq("");
	         oIDTO.setFtSeq(etc_data1.split(",")[1]);
	         log.info(oIDTO.getFtSeq());
	         oIDTO.setOrdDate(ord_date);
	         log.info(oIDTO.getOrdDate());
	         oIDTO.setOrdHis(etc_data3);
	         log.info(oIDTO.getOrdHis());
	         oIDTO.setOrdStatus("0");
	         oIDTO.setOrdSeq(tid);
	         log.info(oIDTO.getOrdSeq());
	         log.info("===============================================");
	         
	         oIDTO.setCstmrName(customer_name);
	         oIDTO.setCstmrTel(customer_tel);
	         oIDTO.setTranNO(tran_no);
	         log.info("Test over");
	         orderService.insertOrderSuccess(oDTO, oIDTO);
	         log.info("Insert end");
	         
	         session.setAttribute("ss_tmpBasket", "");
	         
	      }else{
	         /**
	          * 
	          * 결제 실패
	          * 
	          */
	    	  log.info("결제실패");
	      }
	      log.info(this.getClass() + "orderComplete end!!!");
	      
	   }
	   
	   
	   //페이누리로 보내는 COMPLETE_URL(결제 성공후 가맹점 페이지로 넘어갈 URL)에 대응하는 메소드
	   @RequestMapping(value="orderSuccess")
	   public String orderSuccess(HttpServletRequest req, HttpServletResponse resp, Model model, HttpSession session) throws Exception{
	      log.info(this.getClass() + "orderSuccess start!!!");
	      
	      String userNo = CmmUtil.nvl(req.getParameter("uNo")).split("[?]")[0];
	      session.setAttribute("ss_user_no", userNo);
	      
	      String userAuth = CmmUtil.nvl(req.getParameter("userAuth"));
	      String ftSeq = CmmUtil.nvl(req.getParameter("ftSeq"));
	      
	      session.setAttribute("ss_tmpBasket", null);
	      session.removeAttribute("Ilist");
	      
	      log.info(this.getClass() + "orderSuccess end!!!");
	      
	      //소비자 
	      if(userAuth.equals("1")) {
	    	  String msg="결제가 완료되었습니다.";
	    	  String url="/consumer/cnsmr/ftDetail.do?ft_seq=" + ftSeq;
	    	  model.addAttribute("msg", msg);
	    	  model.addAttribute("url", url);
	    	  return "/cmmn/alert";
	      //판매자
	      }else {
	    	  String msg="결제가 완료되었습니다.";
	    	  String url="/seller/out/out_info.do?&userAuth=2&ftSeq=" + ftSeq ;
	    	  model.addAttribute("msg", msg);
	    	  model.addAttribute("url", url);
	    	  
	    	  return "/cmmn/alert";
	      }
	   }
	   
	    //결제 도중 취소
 		@RequestMapping(value="orderCancelResult")
 		public String orderCancelResult(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception{
 			log.info("결제 도중 최소");
 			session.setAttribute("ss_tmpBasket", null);
 			return "redirect:userMenuList.do";
 		}
 		
 		//소비자로 접속 -> 결제화면으로 바로 이동
 		@RequestMapping(value="/seller/order/goCheck" ,method=RequestMethod.POST)
 		public String goCheck(HttpServletRequest request, Model model, HttpSession session) throws Exception{
 			
 			String sum = CmmUtil.nvl(request.getParameter("sum"));
 			log.info("sum : " + sum);
 			String userSeq = CmmUtil.nvl((String)session.getAttribute("userSeq"));
 			log.info("userSeq : " + userSeq);
 			String userAuth = CmmUtil.nvl(request.getParameter("userAuth"));
 			log.info("userAuth : " + userAuth);
 			String ftSeq = CmmUtil.nvl(request.getParameter("ftSeq"));
 			log.info("ftSeq : " + ftSeq);
 			
			//유저정보 전송
			CMMN_UserDTO uDTO = new CMMN_UserDTO();
			
			uDTO.setUserSeq(userSeq);
			
			uDTO = orderService.getOrderUserDTO(uDTO);
			log.info("uDTO. get : " + uDTO.getUserNick());
			
			model.addAttribute("sum", sum);
			model.addAttribute("uDTO", uDTO);
			model.addAttribute("ftSeq", ftSeq);
			model.addAttribute("userAuth", userAuth);
			
			return "/seller/order/orderInfo";
		
 		}
 		
	 	//로그인 화면 이동 이전
	 	@RequestMapping(value="seller/order/orderLogin" ,method=RequestMethod.POST)
	 	public String orderLogin(HttpServletRequest request, Model model) throws Exception{
	 		String sum = CmmUtil.nvl(request.getParameter("sum"));
			log.info("sum : " + sum);
			String userAuth = CmmUtil.nvl(request.getParameter("userAuth"));
			log.info("userAuth : " + userAuth);
			String ftSeq = CmmUtil.nvl(request.getParameter("ftSeq"));
			log.info("ftSeq : " + ftSeq);
						
			model.addAttribute("ftSeq",ftSeq);
			model.addAttribute("userAuth",userAuth);
			model.addAttribute("sum",sum);
	 		return "/seller/order/orderLogin";
	 	}
	 	
	 	@RequestMapping(value="seller/order/LoginOrder", method=RequestMethod.POST)
	 	public @ResponseBody CMMN_UserDTO loginOrder(HttpServletRequest request, Model model)throws Exception{
	 		log.info(this.getClass() + " LoginOrder start !!!");
	 		
	 		String email = CmmUtil.nvl(request.getParameter("email"));
	 		log.info("email : " + email);
	 		String pwd = SHA256Util.sha256(CmmUtil.nvl(request.getParameter("pwd")));
	 		log.info("pwd : " + pwd);
	 		
	 		CMMN_UserDTO uDTO = new CMMN_UserDTO();
	 		uDTO.setUserEmail(email);
	 		uDTO.setUserPwd(pwd);
	 		
	 		uDTO = orderService.getUserDTO(uDTO);
	 		if(uDTO == null) {
	 			//로그인실패
	 			log.info("로그인에 실패 하였습니다. 아이디 및 비밀번호를 확인해 주세요.");
	 			uDTO = new CMMN_UserDTO();
	 			uDTO.setUserAuth("-1");
	 		}
	 		log.info("uDTO get : " +uDTO.getUserSeq());
	 		log.info("uDTO get : " +uDTO.getUserEmail());
	 		
	 		
	 		log.info(this.getClass() + " LoginOrder end !!!!");
	 		return uDTO;
	 	}
	
	
}
