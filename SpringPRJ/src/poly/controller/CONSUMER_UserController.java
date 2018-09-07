package poly.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.tree.ExpandVetoException;

import org.apache.ibatis.jdbc.Null;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.SystemEnvironmentPropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

//import com.sun.java.util.jar.pack.Package.Class.Method;
import com.sun.mail.handlers.message_rfc822;

import poly.dto.consumer.CONSUMER_CouponIssueDTO;
import poly.dto.consumer.CONSUMER_FtLikeDTO;
import poly.dto.consumer.CONSUMER_OrderInfoDTO;
import poly.dto.consumer.CONSUMER_UserDTO;
import poly.dto.seller.SELLER_OrderInfoDTO;
import poly.service.CONSUMER_ICouponService;
import poly.service.CONSUMER_IFtService;
import poly.service.CONSUMER_IUserService;
import poly.service.SELLER_IOrderService;
import poly.util.CmmUtil;
import poly.util.Email;
import poly.util.EmailSender;
import poly.util.SHA256Util;

@Controller
public class CONSUMER_UserController {
	private Logger log = Logger.getLogger(this.getClass());
	/*로그를 찍고 파일로 남깁니다 .*/
	String msg = "";
	String url = "";
	
	@Autowired
	private EmailSender emailSender;

	@Resource(name="CONSUMER_UserService")
	private CONSUMER_IUserService UserService;
	
	@Resource(name="CONSUMER_CouponService")
	private CONSUMER_ICouponService CouponService;
	
	@Resource(name="CONSUMER_FtService")
	private CONSUMER_IFtService ftService;
	//현재 날짜를 구하는 함수
	public String getDate() {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy. MM. dd / hh:mm:ss");
		String date = sdf1.format(cal.getTime());
		return date;
	}
	
	//로그아웃
	@RequestMapping(value="consumer/user/logout")
	public String logout(HttpSession session) throws Exception{
		//세션을 초기화 시키는 함수
		session.invalidate();
		//로그아웃 끝
		
		return "redirect:/cmmn/main.do";
	}
		
	
	
	
	//수정 화면 업데이트
	@RequestMapping(value="consumer/user/userUpdateView", method=RequestMethod.GET)
	
	public String userUpdateView(HttpServletRequest request , Model model) throws Exception{
		log.info("userUpdateView Start");

		String userSeq = request.getParameter("userSeq");
		log.info("userSeq : " + userSeq);
		
		CONSUMER_UserDTO uDTO = new CONSUMER_UserDTO();
		uDTO.setUserSeq(userSeq);
		log.info("uDTOseq : " + userSeq);
		
		uDTO = UserService.getUserDetail(uDTO);
		
		model.addAttribute("uDTO",uDTO);
		log.info("userUpdateView End");
		return "/consumer/user/userUpdateView";
	}
	
	
	//업데이트 db 저장
	@RequestMapping(value="consumer/user/userUpdateProc", method=RequestMethod.POST)
	public String userUpdateProc(HttpServletRequest request, Model model) throws Exception{
		log.info("userUpdateViewProc Start");
	
		String userSeq = request.getParameter("userSeq");
		log.info("user_No :" + userSeq);
		String userEmail = request.getParameter("email");
		log.info("email : " + userEmail);
		String userPwd = SHA256Util.sha256(CmmUtil.nvl(request.getParameter("userPassword")));
		log.info("userPassword : "  + userPwd);
		String userNick = request.getParameter("nickname");
		log.info("nickname : " + userNick);
		String userGender = request.getParameter("gender");
		log.info("gender : " + userGender);
		String userHp = request.getParameter("phone");
		log.info("phone : " + userHp);
		
		CONSUMER_UserDTO uDTO = new CONSUMER_UserDTO();
		uDTO.setUserSeq(userSeq);
		uDTO.setUserEmail(userEmail);
		uDTO.setUserPwd(userPwd);
		log.info("userPasswordGet : " + uDTO.getUserPwd());
		uDTO.setUserNick(userNick);
		uDTO.setUserGender(userGender);
		uDTO.setUserHp(userHp);
		
		int result = UserService.updateUser(uDTO);
		
		if(result != 0) {
			msg="수정성공";
			url="/consumer/main.do";
		}else {
			msg="수정실패";
			url="/user/userList"; //수정필요합니다.
		}
		
		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		
		log.info("userUpdateViewProc End");
		return "/cmmn/alert";
	}
	
	
	
	
	//////////////마이페이지
	//마이페이지 - 회원정보
	@RequestMapping(value="consumer/user/mypage", method=RequestMethod.GET)
	public String mypage(HttpServletRequest request, Model model, HttpSession session) throws Exception {
		log.info("mypage Start");
		String userSeq = CmmUtil.nvl((String)session.getAttribute("userSeq"));
		log.info("getuserSeq : " + userSeq);
		String userEmail = CmmUtil.nvl((String)session.getAttribute("userEmail"));
		log.info("getUserEmail : " + userEmail);
		
		CONSUMER_UserDTO uDTO = new CONSUMER_UserDTO();
		uDTO.setUserSeq(userSeq);
		log.info("uDTO Userseq : " + uDTO.getUserSeq());
		uDTO.setUserEmail(userEmail);
		log.info("uDTO UserEmail : " + uDTO.getUserEmail());
		
		uDTO = UserService.getUserDetail(uDTO);
		
		model.addAttribute("uDTO",uDTO);
		
		log.info("mypage End");
		
		if(!"".equals(userSeq)) {
			return "/consumer/user/mypage";
		} else {
			model.addAttribute("msg", "로그인 후 이용하시기 바랍니다.");
			model.addAttribute("url", "cmmn/main.do");
			return "/cmmn/alert";
		}
		
	}
	
	//주문내역
	@RequestMapping(value="consumer/user/userOrderInfo", method=RequestMethod.GET)
	public String userOrderInfo(HttpServletRequest request, Model model, HttpSession session) throws Exception {
		log.info("Access userOrderInfo");
		//dupyo 주문내역
		String userSeq = (String)session.getAttribute("userSeq");
		List<CONSUMER_OrderInfoDTO> oList = UserService.getOrderList(userSeq);
		if(oList == null) {
			log.info("주문내역 불러오기 실패;;");
		} else {
			log.info("주문내역 불러오기 성공 oList : " + oList);
			model.addAttribute("oList", oList);
			log.info("---------------------------");
		}
		log.info("Terminate userOrderInfo");
		return "/consumer/user/userOrderInfo";
	}
	
	//관심매장
	@RequestMapping(value="consumer/user/userFavoriteFt", method=RequestMethod.GET)
	public String userFavoriteFt(HttpServletRequest request, Model model, HttpSession session) throws Exception {
		log.info("Access userFavoriteFt");
		//dupyo 관심매장	
		String userSeq = (String)session.getAttribute("userSeq");
		List<CONSUMER_FtLikeDTO> fList = ftService.getFavoriteFt(userSeq);
		if(fList == null) {
			log.info("관심매장 불러오기 실패;;");
		} else {
			log.info("관심매장 불러오기 성공 fList : " + fList);
			model.addAttribute("fList", fList);
			log.info("---------------------------");

		}
		
		log.info("Terminate userFavoriteFt");
		return "/consumer/user/userFavoriteFt";
	}
	
	//내 쿠폰목록
	@RequestMapping(value="consumer/user/userCouponList", method=RequestMethod.GET)
	public String mycoupon(HttpServletRequest request, Model model, HttpSession session) throws Exception {
		log.info("Access mycoupon");
		//dupyo 쿠폰목록
		String userSeq = (String)session.getAttribute("userSeq");
		List<CONSUMER_CouponIssueDTO> cList = CouponService.couponList(userSeq);
		if(cList == null) {
			log.info("쿠폰목록 불러오기 실패;;");
		} else {
			log.info("쿠폰목록 불러오기 성공 couponList : " + cList);
			model.addAttribute("cList", cList);
			log.info("---------------------------");
		}
		
		log.info("Terminate mycoupon");
		return "/consumer/user/userCouponList";
	}
	
	
	
	
	
	
	
	//관심매장 추가 - ajax
	@RequestMapping(value="consumer/cnsmr/favoriteFtAdd", method=RequestMethod.POST)
	public @ResponseBody int favoriteFtAdd(HttpServletRequest request, Model model, HttpServletResponse response )throws Exception{
		log.info(this.getClass() + "cnsmr/favoriteFtAdd start !!!");
		String user_seq = request.getParameter("user_seq");
		String ft_seq = request.getParameter("ft_seq");
		String like_regdate = getDate();
		CONSUMER_FtLikeDTO ftLikeDTO = new CONSUMER_FtLikeDTO();
		ftLikeDTO.setFt_seq(ft_seq);
		ftLikeDTO.setUser_seq(user_seq);
		ftLikeDTO.setLike_regdate(like_regdate);

		int result = UserService.ftAddFavorite(ftLikeDTO);
		
		
		log.info(this.getClass() + "cnsmr/favoriteFtAdd end !!!");
		return result;
		
	}
	
	//관심매장 삭제 - ajax
	@RequestMapping(value="consumer/cnsmr/favoriteFtRemove", method=RequestMethod.POST)
	public @ResponseBody int favoriteFtRemove(HttpServletRequest request, Model model, HttpServletResponse response)throws Exception{
		log.info(this.getClass() + "cnsmr/favoriteFtRemove start !!!");
		String user_seq = request.getParameter("user_seq");
		String ft_seq = request.getParameter("ft_seq");
		CONSUMER_FtLikeDTO ftLikeDTO = new CONSUMER_FtLikeDTO();
		ftLikeDTO.setFt_seq(ft_seq);
		ftLikeDTO.setUser_seq(user_seq);
		
		int result = UserService.ftRemoveFavorite(ftLikeDTO);
		
		
		log.info(this.getClass() + "cnsmr/favoriteFtRemove end !!!");
		return result;
		
	}
	
	
	
	
}
	
	


