package poly.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
import poly.service.SELLER_IOrderService;
import poly.service.impl.SELLER_OrderService;
import poly.util.CmmUtil;

@Controller
public class SELLER_OrderController {
	private Logger log = Logger.getLogger(this.getClass());
	//로그를 찍고 파일로 남깁니다 .
	
	@Resource(name="SELLER_OrderService")
	private SELLER_IOrderService orderService;
	//메모리에 올려두고 싱글톤 패턴을 적용시켜줍니다 .
	
	//주문서 작성 화면 
	@RequestMapping(value="/seller/order/orderInfo")
	public String orderInfo(HttpServletRequest request,Model model) throws Exception{
		log.info(this.getClass() + "orderInfo start !!!!!!");
		String sum = CmmUtil.nvl(request.getParameter("sum"));
		log.info("sum : " + sum);
		String userSeq = CmmUtil.nvl(request.getParameter("userSeq"));
		log.info("userSeq : " + userSeq);
		
		CMMN_UserDTO uDTO = new CMMN_UserDTO();
		uDTO.setUserSeq(userSeq);
		
		uDTO = orderService.getOrderUserDTO(uDTO);
		log.info("uDTO. get : " + uDTO.getUserEmail());
		log.info("uDTO. get : " + uDTO.getUserNick());
		
		
		model.addAttribute("uDTO",uDTO);
		model.addAttribute("sum",sum);
		
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
		
		//
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
	
	 //페이누리로 보내는 RETURN_URL(결제결과 데이터 받기)에 대응하는 메소드
	   /*@RequestMapping(value="orderComplete")
	   public void orerComplete(HttpServletRequest req, HttpServletResponse resp, Model model, HttpSession session) throws Exception{
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
	      String sale_date =CmmUtil.nvl(req.getParameter("SALE_DATE"));
	      log.info(this.getClass() + " sale_date : " + sale_date);
	      //고객이름
	      String customer_name =CmmUtil.nvl(req.getParameter("CUSTOMER_NAME"));
	      log.info(this.getClass() + " customer_name : " + customer_name);
	      //고객 이메일
	      String customer_email =CmmUtil.nvl(req.getParameter("CUSTOMER_EMAIL"));
	      log.info(this.getClass() + " customer_email : " + customer_email);
	      //고객 전화번호
	      String customer_tel   =CmmUtil.nvl(req.getParameter("CUSTOMER_TEL"));
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
	      String etc_data1 =CmmUtil.nvl(req.getParameter("ETC_DATA1"));//사용자 번호 넘어올것
	      log.info(this.getClass() + " etc_data1 : " + etc_data1);
	      String etc_data2 =CmmUtil.nvl(req.getParameter("ETC_DATA2"));
	      log.info(this.getClass() + " etc_data2 : " + etc_data2);//수령시간
	      String etc_data3 =CmmUtil.nvl(req.getParameter("ETC_DATA3"));      
	      log.info(this.getClass() + " etc_data3 : " + etc_data3);//주문 제품 목록
	      if(rep_code.equals("0000")){
	         *//**
	          * 결제 성공
	          *//*

	         log.info("orderss ss_user_no = "+session.getAttribute("ss_user_no"));
	         Order_infoDTO oDTO = new Order_infoDTO();
	         oDTO.setOrd_no(tran_no);
	         oDTO.setReal_ord_price(amt);
	         if(tran_type.equals("PHON")){
	            oDTO.setPayment_tp("p");
	         }else{
	            oDTO.setPayment_tp("c");
	         }
	         oDTO.setOrd_stat("1");
	         oDTO.setUsr_rcv_time(etc_data2);
	         oDTO.setRcv_yn("n");
	         oDTO.setTid(tid);
	         String[] userNoAndMil = etc_data1.split(";");
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
	         }
	         String[] orderItems = etc_data3.split("-");
	         List<Order_itemDTO> oList = new ArrayList<Order_itemDTO>();
	         for(int i = 0; i< orderItems.length; i++){
	            String[] orderItem = orderItems[i].split(":");
	            Order_itemDTO oIDTO = new Order_itemDTO();
	            oIDTO.setOrd_no(tran_no);
	            oIDTO.setPrdt_no(orderItem[0]);
	            oIDTO.setOrd_amnt(orderItem[1]);
	            oIDTO.setReg_user_no(userNoAndMil[0]);
	            oList.add(oIDTO);
	         }
	         log.info(this.getClass() + " useremail" + CmmUtil.nvl((String)session.getAttribute("ss_user_email")));
	         session.setAttribute("ss_tmpBasket", "");
	         req.setAttribute("user_no", userNoAndMil[0]);
	         orderService.insertOrderSuccess(oDTO, oList, milMap);
	      }else{
	         *//**
	          * 
	          * 
	          * 
	          * 결제 실패
	          * 
	          * 
	          *//*
	      }
	      log.info(this.getClass() + "orderComplete end!!!");
	      
	   }*/
	   
	   
	   /****************************************************************
	    * 여기도 컵밥ㅂ 코드 싹다 수정해야합니다 .
	    * 
	    */
	   //페이누리로 보내는 COMPLETE_URL(결제 성공후 가맹점 페이지로 넘어갈 URL)에 대응하는 메소드
	  /* @RequestMapping(value="orderSuccess")
	   public String orderSuccess(HttpServletRequest req, HttpServletResponse resp, Model model, HttpSession session) throws Exception{
	      log.info(this.getClass() + "orderSuccess start!!!");
	      String userNo = CmmUtil.nvl(req.getParameter("uNo")).split("[?]")[0];
	      session.setAttribute("ss_user_no", userNo);
	      log.info(this.getClass() + "user_no = "+userNo);
	      Order_infoDTO oDTO = orderService.getOrderNo(userNo);
	      if(oDTO == null){
	         oDTO = new Order_infoDTO();
	      }
	      log.info(this.getClass() + " ordno = " + oDTO.getOrd_no());
	      Order_itemDTO otDTO = new Order_itemDTO();
	      otDTO.setOrd_no(oDTO.getOrd_no());
	      List<Order_itemDTO> otList = orderService.getOrdItem(otDTO);
	      if(otList ==null){
	    	  otList = new ArrayList<Order_itemDTO>();
	      }
	      log.info(this.getClass() + " otListSize = "+ otList.size());
	      
	      model.addAttribute("ordNo", CmmUtil.nvl(oDTO.getOrd_no()));
	      model.addAttribute("otList", otList);
	      session.setAttribute("ss_tmpBasket", null);
	      userNo = null;
	      oDTO = null;
	      otList = null;
	      log.info(this.getClass() + "orderSuccess end!!!");
	      return "user/orderSuccess";
	   }*/
	   
	 //이거슨 결제 도중 취소 URL이였던 것이였던 것이다
	 	/*	@RequestMapping(value="orderCancelResult")
	 		public String orderCancelResult(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception{
	 			session.setAttribute("ss_tmpBasket", null);
	 			return "redirect:userMenuList.do";
	 		
	 		}*/
	
	
}
