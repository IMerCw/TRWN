package poly.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import poly.dto.admin.ADMIN_User_InfoDTO;
import poly.service.ADMIN_IUserService;

@Controller
public class ADMIN_LoginController {
	public Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="ADMIN_UserService")
	private ADMIN_IUserService userService;
	
/*----------------------------------------------------------------------------------------*/
	
	public String getDate() {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy. MM. dd / hh:mm:ss");
		String date = sdf1.format(cal.getTime());
		
		return date;
	}
	
/*관리자 로그인----------------------------------------------------------------------------------------*/	
	
	//로그인 메인 이동
	@RequestMapping(value="/admin")
	public String admin_login(HttpServletRequest request, Model model) throws Exception{
		
		return "/admin/admin_login";
	}
	
	/*//유저 검색 리스트
	@RequestMapping(value="admin/login", method=RequestMethod.GET)
	public String admin_login_ok(HttpServletRequest request, Model model) throws Exception{
		
		return "/admin/user/user_search_list";
	}*/
}