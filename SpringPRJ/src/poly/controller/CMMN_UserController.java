package poly.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.dto.cmmn.CMMN_UserDTO;
import poly.service.CMMN_IUserService;
import poly.service.SELLER_IOutService;
import poly.util.CmmUtil;
import poly.util.Email;
import poly.util.EmailSender;
import poly.util.SHA256Util;
import poly.util.UtilTime;

@Controller
public class CMMN_UserController {
	private Logger log = Logger.getLogger(this.getClass());
	/*로그를 찍고 파일로 남깁니다 .*/
	String msg = "";
	String url = "";
	
	@Autowired
	private EmailSender emailSender;

	@Resource(name="CMMN_UserService")
	private CMMN_IUserService UserService;
	
	@Resource(name="SELLER_OutService")
	private SELLER_IOutService SELLER_OutService;
	
	//현재 날짜를 구하는 함수
	public String getDate() {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy. MM. dd / hh:mm:ss");
		String date = sdf1.format(cal.getTime());
		return date;
	}
	
	//로그인, 회원가입 화면은 메인페이지로 대체 합니다.
	//로그인 화면
/*  @RequestMapping(value="consumer/user/userLogin")
	public String userLogin() throws Exception{
		log.info(this.getClass() + "userLogin start!!!");
		
		
		log.info(this.getClass() + "userLogin end!!!");
		return "/consumer/user/userLogin";
	}*/
	
	//로그인 
	@RequestMapping(value="cmmn/user/loginProc", method=RequestMethod.POST)
	public String loginProc(HttpServletRequest request, HttpSession session, Model model)throws Exception{
		log.info(this.getClass() + "loginProc start ~~!");
		String userEmail = CmmUtil.nvl(request.getParameter("user_Email"));
		String userPwd = SHA256Util.sha256(CmmUtil.nvl(request.getParameter("user_Pwd")));
		
		log.info("userEmail 아이디 받기 :" + userEmail);
		log.info("userPwd 비밀번호받기:" + userPwd);
		
		//아이디 패스워드 받아서 
		CMMN_UserDTO uDTO = new CMMN_UserDTO();
		uDTO.setUserEmail(userEmail);
		uDTO.setUserPwd(userPwd);
		log.info("비밀번호 확인 CONTROLLER : " + uDTO.getUserPwd());
		
		uDTO=UserService.getUserLogin(uDTO, log);
		System.out.println("udto 널 확인");
		System.out.println(uDTO == null);
		
		
		if(uDTO == null) {
			//로그인실패
			String msg="로그인 실패 \\n 1.아이디/비밀번호 다시 확인해주세요 \\n 2.이메일 인증 확인해주세요";
			url="/cmmn/main.do";
			
			model.addAttribute("msg",msg);
			model.addAttribute("url",url);
		
			return "/cmmn/alert";
		}
		else {
			log.info("로그인 성공 : " + uDTO.getUserEmail());
			log.info("로그인 성공 : " + uDTO.getUserSeq());
			log.info(uDTO.getUserNick());
			log.info(uDTO.getUserGender());
			log.info(uDTO.getUserHp());
			
			//로그인 성공
			session.setAttribute("userSeq", uDTO.getUserSeq());
			session.setAttribute("userAuth", uDTO.getUserAuth());
			session.setAttribute("userEmail", uDTO.getUserEmail());
			session.setAttribute("userNick", uDTO.getUserNick());
			session.setAttribute("userGender", uDTO.getUserGender());
			session.setAttribute("userHp", uDTO.getUserHp());
		}
		
		
		if (uDTO.getUserAuth().equals("2")) { //USER_AUTH가 2일 경우 판매자로 접속
			log.info(uDTO.getUserEmail() + "님이 판매자로 접속합니다.");
			return "redirect:/seller/out/inOut.do";
		} else if(uDTO.getUserAuth().equals("9")) { //USER_AUTH가 9 일 경우 관리자 페이지로 이동
			return "redirect:/admin/admin_main.do";
		}
		
		
		log.info(uDTO.getUserEmail() + "님이 소비자로 접속합니다.");
		
		uDTO = null;
		log.info(this.getClass() + "loginProc end ~~!");
		return "redirect:/consumer/main.do";
	}
		
	
	//로그아웃
	@RequestMapping(value="cmmn/user/logout")
	public String logout(HttpSession session, Model model) throws Exception{
		//세션을 초기화 시키는 함수
		session.invalidate();
		return "redirect:/cmmn/main.do"; //메인페이지(로그인화면)로 이동
	}
		
	
	//이메일/비밀번호 찾기 화면
	@RequestMapping(value="cmmn/user/userFindInfo")
	public String userFindInfo() throws Exception{
		return "/cmmn/user/userFindInfo";
	}
	
	
	//이메일 체크
	@RequestMapping(value="cmmn/user/emailCheck", method=RequestMethod.POST)
	public @ResponseBody String emailCheck(HttpServletRequest request, Model model, HttpServletResponse response )throws Exception{
		log.info(this.getClass() + "/user/emailCheck start !!!");
		String email = CmmUtil.nvl(request.getParameter("email"));
		log.info("emailCK : " + email);
		
		CMMN_UserDTO uDTO = new CMMN_UserDTO();
		uDTO.setUserEmail(email);
		log.info("uDTO.emailck : " + uDTO.getUserEmail());
		int rowcount = UserService.emailCheck(uDTO);
		
		log.info(this.getClass() + "/user/emailCheck end !!!");
		return String.valueOf(rowcount);
	}
	
	
	
	//이메일 찾기 
	@RequestMapping(value="cmmn/user/userFindEmail" , method=RequestMethod.POST)
	public String userFindEmail(HttpServletRequest request , HttpServletResponse response , Model model ) throws Exception{
		log.info(this.getClass() + "userFindEmail start!!!!");
		String userNick = CmmUtil.nvl(request.getParameter("userNick"));
		log.info("userFindNick : " + userNick);
		String userHp = CmmUtil.nvl(request.getParameter("userHp"));
		log.info("userFindHp : " + userHp);
		
		
		CMMN_UserDTO uDTO = new CMMN_UserDTO();
		uDTO.setUserNick(userNick);
		uDTO.setUserHp(userHp);
		log.info("uDTOHP : " + userHp);
		
		uDTO = UserService.getUserFindEmail(uDTO);
	
		if(uDTO == null) {
			uDTO = new CMMN_UserDTO();
		}
		log.info("userEmail model  : " + uDTO.getUserEmail());
		model.addAttribute("uDTO",uDTO);
		
		
		uDTO = null;
		log.info(this.getClass() + "userFindEmail end !!");
		
		return "/cmmn/user/userFindEmail";
	}
	
	
	
	//비밀번호 찾기 / 임시비밀번호
	@RequestMapping(value="cmmn/user/userFindPwd", method=RequestMethod.POST)
	public String userFindPwd(HttpServletRequest request , HttpServletResponse response , Model model) throws Exception{
		log.info(this.getClass() + "userFindPwd start !! ");
		String userNick = CmmUtil.nvl(request.getParameter("userNick"));
		log.info("userNick : " + userNick );
		String userEmail = CmmUtil.nvl(request.getParameter("userEmail"));
		log.info("userEmail : " + userEmail);
		String userHp = CmmUtil.nvl(request.getParameter("userHp"));
		log.info("userHp : " + userHp);
		Email sendEmail = new Email();
		
		CMMN_UserDTO uDTO = new CMMN_UserDTO();
		uDTO.setUserNick(userNick);
		uDTO.setUserEmail(userEmail);
		uDTO.setUserHp(userHp);
		log.info("uDTO 셋팅 :" + uDTO.getUserNick());
		log.info("uDTO 셋팅 :" + uDTO.getUserEmail());
		log.info("uDTO 셋팅 :" + uDTO.getUserHp());
		String msg ="";
		String url ="";

		HashMap<String, Object> hMap = new HashMap<>();
		hMap.put("uDTO", uDTO);
		
		hMap = UserService.updateTmpPass(hMap);
		int result = (int)hMap.get("result");
	
		if(result == 0) {
			msg = "회원정보가 일치하지 않습니다.";
			url = "/cmmn/user/userFindInfo.do";
			
		}else{
			sendEmail.setReciver(userEmail);
			sendEmail.setSubject(userNick + "님 트럭왔냠 임시비밀번호");
			sendEmail.setContent(sendEmail.setContents(hMap));
			emailSender.SendEmail(sendEmail);
			msg = "가입하신 이메일로 임시비밀번호가 전송되었습니다.";
			url = "/cmmn/main.do";
		}

		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		model.addAttribute("uDTO",uDTO);
		log.info("uDTO 모델 넘기기: " + uDTO.getUserEmail());
		log.info("uDTO : " +uDTO.getUserHp());
		log.info("uDTO : " + uDTO.getUserNick());
		log.info("uDTOSeq : " + uDTO.getUserSeq());
		
		msg =null;
		url =null;
		uDTO = null;
		log.info(this.getClass() + " userFindPwd end !!! ");
		return "/cmmn/alert";
	}
	
		
	//private IUserService userService = new UserService();
	//차이점은 싱글톤 패턴을 적용시켜준다 .
	
	/*
	@RequestMapping(value="consumer/user/userReg")
	public String usreReg() throws Exception{
		
		return "/user/userReg";
	}
	*/
	
	//회원가입 - 회원정보 insert 코드
	@RequestMapping(value="cmmn/user/userRegProc", method=RequestMethod.POST)
	public String userRegProc(HttpServletRequest request, Model model) throws Exception{
		log.info(this.getClass()+"userRegProc start!!!");
		String user_Email = request.getParameter("email");
		log.info("email : " + user_Email);
		//String user_Pwd = request.getParameter("userPassword");
		String user_Pwd = SHA256Util.sha256(CmmUtil.nvl(request.getParameter("userPassword")));
		log.info("userPassword : "  + user_Pwd);
		String user_Nick = request.getParameter("nickname");
		log.info("nickname : " + user_Nick);
		String user_Gender = request.getParameter("gender");
		log.info("gender : " + user_Gender);
		String user_Hp = request.getParameter("phone");
		log.info("phone : " + user_Hp);
		String userStatus = CmmUtil.nvl(request.getParameter("userStatus"));
		log.info("userStatus " + userStatus);
		String count = request.getParameter("count");
		log.info("count : " + count);
		
		Email sendEmail = new Email();
		
		sendEmail.setReciver(user_Email);
		sendEmail.setSubject("트럭왔냠 이메일 인증");
		sendEmail.setContent("<a href=\"http://192.168.170.104:8080/user/updateAuth.do?userStatus=AuthY&userEmail="+user_Email+"\">트럭왔냠 이메일 인증 클릭</a>");
		//sendEmail.setContentsE()
		emailSender.SendEmail(sendEmail);

		//현재시간 가져오기
		String userRegDate = UtilTime.getDateYMDhms();
		CMMN_UserDTO uDTO = new CMMN_UserDTO();
		uDTO.setUserEmail(user_Email);
		uDTO.setUserPwd(user_Pwd);
		uDTO.setUserNick(user_Nick);
		uDTO.setUserGender(user_Gender);
		uDTO.setUserHp(user_Hp);
		uDTO.setUserStatus(userStatus);
		uDTO.setUserRegDate(userRegDate);
		
		log.info("uDTO userStatus :" + userStatus);
		
		int result = UserService.insertUserDTO(uDTO);
		
		
		if(result != 0) {
			//회원가입이 정상적으로 이루어진 상태
			msg="이메일 인증 후 로그인해주세요 .";
			url="/cmmn/main.do";
		}else {
			//회원가입이 이루어지지 않은 상태
			msg="회원가입 실패";
			url="/cmmn/main.do";
		}
		
		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		
		uDTO = null;
		msg =null;
		url = null;
		
		log.info(this.getClass()+"logRegProc end ~!!!");
		return "/cmmn/alert";
		
		
	}
	
	


	
	//회원목록 삭제
	@RequestMapping(value="cmmn/user/userDelete", method=RequestMethod.GET)
	public String userDelete(HttpServletRequest request, Model model) throws Exception{
		log.info("userDelete Start");
		String userSeq = CmmUtil.nvl( request.getParameter("userSeq") );
		log.info("userSeq : " + userSeq);
		
		CMMN_UserDTO uDTO = new CMMN_UserDTO();
		
		uDTO.setUserSeq(userSeq);
		log.info("uDTOdel : " + uDTO.getUserSeq());
		
		int result = UserService.deleteUser(uDTO);
		//오류 ....반환가
		
		log.info("uDTOdel2 : " + uDTO.getUserSeq());
		
		if(result != 0) {
			msg="삭제 성공";
			url="/cmmn/main.do";
		}else {
			msg="삭제 실패";
			url="/cmmn/main.do";
		}
		
		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		
		log.info("userDelete End");
		return "/cmmn/alert";
	}
	
	
	
	//수정 화면 업데이트
	@RequestMapping(value="cmmn/user/userUpdateView", method=RequestMethod.GET)
	
	public String userUpdateView(HttpServletRequest request , Model model) throws Exception{
		log.info("userUpdateView Start");

		String userSeq = request.getParameter("userSeq");
		log.info("userSeq : " + userSeq);
		
		CMMN_UserDTO uDTO = new CMMN_UserDTO();
		uDTO.setUserSeq(userSeq);
		log.info("uDTOseq : " + userSeq);
		
		uDTO = UserService.getUserDetail(uDTO);
		
		model.addAttribute("uDTO",uDTO);
		log.info("userUpdateView End");
		return "/cmmn/user/userUpdateView";
	}
	
	
	//업데이트 db 저장
	@RequestMapping(value="cmmn/user/userUpdateProc", method=RequestMethod.POST)
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
		
		CMMN_UserDTO uDTO = new CMMN_UserDTO();
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
			url="/cmmn/main.do";
		}else {
			msg="수정실패";
			url="/cmmn/user/userList";
		}
		
		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		
		log.info("userUpdateViewProc End");
		return "/cmmn/alert";
	}
	
	
	
	
	
	//이메일 인증 확인 
	@RequestMapping(value="cmmn/user/updateAuth",method=RequestMethod.GET)
	public String updateAuth(HttpServletResponse response, HttpServletRequest request,Model model)throws Exception{
		log.info(this.getClass() + "updateAuth start !!");
		String userStatus = CmmUtil.nvl( request.getParameter("userStatus") );
		log.info("userStatus : " + userStatus);
		String userEmail = CmmUtil.nvl(request.getParameter("userEmail"));
		log.info("userEmail : " + userEmail);
		
		CMMN_UserDTO uDTO = new CMMN_UserDTO();
		
		uDTO.setUserEmail(userEmail);
		uDTO.setUserStatus(userStatus);
		log.info("uDTO Email : " + uDTO.getUserEmail());
		
		int result = UserService.updateUserStatus(uDTO);
		
		String msg = "";
		String url = "";
		
		if(result != 0) {
			//이메일 인증 성공
			msg="이메일 인증 성공하셨습니다.";
			url="/cmmn/main.do";
		}else {
			//이메일 인증 실패
			msg="이메일 인증 실패";
			url="/cmmn/main.do";
			
		}
		
		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		
		msg=null;
		url=null;
		uDTO=null;
		
		
		log.info(this.getClass() + "updateAuth end !! ");
		return "/cmmn/alert";
	}
	
	
	

	//이메일 인증 버린다...나중에 공부하자,, ㅜㅜ
 
  /*	@RequestMapping(value="consumer/user/emailAuth", method=RequestMethod.POST)
	public void emailAuth(HttpServletRequest request, Model model, HttpServletResponse response)throws Exception{		
		log.info(this.getClass() + "user/emailAuth start !!");
		String userEmail = CmmUtil.nvl(request.getParameter("email"));
		log.info("emailAuth : " + userEmail);
		String userPwd = CmmUtil.nvl(request.getParameter("userPwd"));
		log.info("userPwdAuth : " + userPwd);
		String userNick = CmmUtil.nvl(request.getParameter("userNick"));
		log.info("userNick : " + userNick);
		String gender = CmmUtil.nvl(request.getParameter("gender"));
		log.info("gender : " + gender);
		String userHp = CmmUtil.nvl(request.getParameter("userHp"));
		log.info("userHp : " + userHp);
		String userStatus = CmmUtil.nvl(request.getParameter("userStatus"));
		log.info("userStatus : " +userStatus);
		Email sendEmail = new Email();
		
		UserDTO uDTO = new UserDTO();
		uDTO.setUserEmail(userEmail);
		log.info("emailAuth uDTO " + uDTO.getUserEmail());
		
		int ran =new Random().nextInt(10000) + 10000; //10000 ~ 99999
		String joinCode = String.valueOf(ran);
		session.invalidate(); 세션 초기화
		log.info("session joinCode :" + joinCode);

		HashMap<String, Object> hMap = new HashMap<>();
		hMap.put("uDTO", uDTO);
		hMap.put("joinCode", joinCode);
		
		
		//UserDTO uDTO = (UserDTO)hMap.get("uDTO");
		//hMap = UserService.updateTmpPass(hMap);
		//int result = (int)hMap.get("result");
	
		sendEmail.setReciver(userEmail);
		sendEmail.setSubject("트럭왔냠 이메일 인증");
		sendEmail.setContent("<a href=\"http://192.168.170.124:8080/user/updateAuth.do?userStatus=AuthY\">test</a>");
		//sendEmail.setContentsE()
		emailSender.SendEmail(sendEmail);

		model.addAttribute("uDTO",uDTO);
		log.info("uDTO sendEmail 끝: " + uDTO.getUserEmail());
		uDTO = null;
		log.info(this.getClass() + "user/emailAuth end !!");
		response.getWriter().println("success");
	
	}*/
	
	///////마이페이지
	//마이페이지 - 회원정보
	@RequestMapping(value="cmmn/user/mypage", method=RequestMethod.GET)
	public String mypage(HttpServletRequest request, Model model) throws Exception {
		log.info("mypage Start");
		
		String userSeq = CmmUtil.nvl(request.getParameter("userSeq"));
		log.info("getuserSeq : " + userSeq);
		String userEmail = CmmUtil.nvl(request.getParameter("userEmail"));
		log.info("getUserEmail : " + userEmail);
		
		CMMN_UserDTO uDTO = new CMMN_UserDTO();
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
			model.addAttribute("url", "/cmmn/main.do");
			return "/cmmn/alert";
		}
		
	}
	
	
}
	
	


