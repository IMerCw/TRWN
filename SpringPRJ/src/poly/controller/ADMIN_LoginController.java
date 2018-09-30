package poly.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import poly.dto.admin.ADMIN_User_InfoDTO;
import poly.dto.cmmn.CMMN_UserDTO;
import poly.service.ADMIN_IUserService;
import poly.service.CMMN_IUserService;
import poly.util.CmmUtil;
import poly.util.SHA256Util;

@Controller
public class ADMIN_LoginController {
	public Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="ADMIN_UserService")
	private ADMIN_IUserService userService;
	
	@Resource(name="CMMN_UserService")
	private CMMN_IUserService UserService;
	
/*----------------------------------------------------------------------------------------*/
	
	public String getDate() {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy. MM. dd / HH:mm:ss");
		String date = sdf1.format(cal.getTime());
		
		return date;
	}
	
/*관리자 로그인----------------------------------------------------------------------------------------*/	
	
	//로그인 메인 이동
	@RequestMapping(value="/admin")
	public static String admin_login(HttpServletRequest request, Model model) throws Exception{
		return "/admin/admin_login";
	}
	
	//로그인 
	@RequestMapping(value="/admin/loginProc", method=RequestMethod.POST)
	public String admin_loginProc(HttpServletRequest request, HttpSession session, Model model)throws Exception{
		String userEmail = CmmUtil.nvl(request.getParameter("user_Email"));
		String userPwd = SHA256Util.sha256(CmmUtil.nvl(request.getParameter("user_Pwd")));
		
		//아이디 패스워드 받아서 
		CMMN_UserDTO uDTO = new CMMN_UserDTO();
		uDTO.setUserEmail(userEmail);
		uDTO.setUserPwd(userPwd);
		
		uDTO=UserService.getUserLogin(uDTO, log);
		
		
		if(uDTO != null && uDTO.getUserEmail().equals("admin") && uDTO.getUserSeq().equals("0") && uDTO.getUserAuth().equals("9")) {
			//로그인 성공
			session.setAttribute("join_date", getDate());
			session.setAttribute("userSeq", uDTO.getUserSeq());
			
			return "redirect:/admin/admin_main.do";
		}else {
			String msg = "아이디 또는 비밀번호가 맞지 않습니다.";
			String url = "/admin.do";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return "/cmmn/alert";
		}
	}
		
	
	//로그아웃
	@RequestMapping(value="/admin/logout")
	public String admin_logout(HttpSession session, Model model) throws Exception{
		//세션을 초기화 시키는 함수
		session.invalidate();
		return "redirect:/admin.do"; //메인페이지(로그인화면)로 이동
	}
}