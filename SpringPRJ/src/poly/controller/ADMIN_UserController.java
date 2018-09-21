package poly.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
public class ADMIN_UserController {
	public Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="ADMIN_UserService")
	private ADMIN_IUserService userService;
	
/*----------------------------------------------------------------------------------------*/
	
	public String getDate() {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy. MM. dd / HH:mm:ss");
		String date = sdf1.format(cal.getTime());
		
		return date;
	}
	
/*유저관리----------------------------------------------------------------------------------------*/	
	
	//유저 리스트
	@RequestMapping(value="admin/user/user_list")
	public String user_list(HttpServletRequest request, Model model) throws Exception{
		List<ADMIN_User_InfoDTO> userList = userService.getUser_InfoList();
		
		//유저목록 쪼개기
		model.addAttribute("pageNum", request.getParameter("pageNum"));
		model.addAttribute("pageSize", request.getParameter("pageSize"));

		model.addAttribute("userList", userList);
		
		return "/admin/user/user_list";
	}
	
	//유저 검색 리스트
	@RequestMapping(value="admin/user/user_search_list", method=RequestMethod.GET)
	public String user_search_list(HttpServletRequest request, Model model) throws Exception{
		ADMIN_User_InfoDTO uDTO = new ADMIN_User_InfoDTO();
		uDTO.setOption(request.getParameter("option"));
		uDTO.setValue(request.getParameter("value"));
		
		List<ADMIN_User_InfoDTO> user_SearchList = userService.getUser_Search(uDTO);
		
		model.addAttribute("option", request.getParameter("option"));
		model.addAttribute("value", request.getParameter("value"));
		
		//게시판 쪼개기
		model.addAttribute("pageNum", request.getParameter("pageNum"));
		model.addAttribute("pageSize", request.getParameter("pageSize"));

		model.addAttribute("user_SearchList", user_SearchList);
		
		return "/admin/user/user_search_list";
	}
	
	//유저 활동정지
	@RequestMapping(value="admin/user/user_active", method=RequestMethod.GET)
	public String user_active(HttpServletRequest request, Model model) throws Exception{
		ADMIN_User_InfoDTO uDTO = new ADMIN_User_InfoDTO();
		String ArrUser_Seq = request.getParameter("ArrUser_Seq");
		String[] array = ArrUser_Seq.split(",");
		for(int i=0; i<array.length; i++) {
			uDTO.setUser_chan(getDate());
			uDTO.setUser_seq(Integer.parseInt(array[i]));
			uDTO.setStatus("1");
			userService.user_Active(uDTO);
		}
		return user_list(request, model);
	}
	
	//유저 강제탈퇴
	@RequestMapping(value="admin/user/user_drop", method=RequestMethod.GET)
	public String user_drop(HttpServletRequest request, Model model) throws Exception{
		ADMIN_User_InfoDTO uDTO = new ADMIN_User_InfoDTO();
		String ArrUser_Seq = request.getParameter("ArrUser_Seq");
		String[] array = ArrUser_Seq.split(",");
		for(int i=0; i<array.length; i++) {
			uDTO.setUser_chan(getDate());
			uDTO.setUser_seq(Integer.parseInt(array[i]));
			uDTO.setStatus("-1");
			userService.user_Drop(uDTO);
		}
		return user_list(request, model);
	}
	
	//유저 등급변경
	@RequestMapping(value="admin/user/user_auth", method=RequestMethod.GET)
	public String user_auth(HttpServletRequest request, Model model) throws Exception{
		ADMIN_User_InfoDTO uDTO = new ADMIN_User_InfoDTO();
		String ArrUser_Seq = request.getParameter("ArrUser_Seq");
		String ArrUser_Auth = request.getParameter("ArrUser_Auth");
		String[] array = ArrUser_Seq.split(",");
		String[] array2 = ArrUser_Auth.split(",");
		for(int i=0; i<array.length; i++) {
			uDTO.setUser_seq(Integer.parseInt(array[i]));
			uDTO.setUser_auth(Integer.parseInt(array2[i]));
			userService.user_Auth(uDTO);
		}
		return user_list(request, model);
	}
	

//정지 탈퇴 유저관리------------------------------------------------------------------------------------------------------------------------------------
	//정지-탈퇴 유저 리스트
	@RequestMapping(value="admin/user/user_activity_list")
	public String user_activity_list(HttpServletRequest request, Model model) throws Exception{
		List<ADMIN_User_InfoDTO> userList = userService.getUser_InfoList();
		List<ADMIN_User_InfoDTO> activity_userList = new ArrayList<ADMIN_User_InfoDTO>();
		for(ADMIN_User_InfoDTO uDTO : userList) {
			if(!uDTO.getStatus().equals("0")) {
				activity_userList.add(uDTO);
			}
		}
		//유저목록 쪼개기
		model.addAttribute("pageNum", request.getParameter("pageNum"));
		model.addAttribute("pageSize", request.getParameter("pageSize"));

		model.addAttribute("userList", activity_userList);
		
		return "/admin/user/user_activity_list";
	}
			
	//정지-탈퇴 유저 검색 리스트
	@RequestMapping(value="admin/user/user_activity_search_list", method=RequestMethod.GET)
	public String user_activity_search_list(HttpServletRequest request, Model model) throws Exception{
		ADMIN_User_InfoDTO uDTO = new ADMIN_User_InfoDTO();
		uDTO.setOption(request.getParameter("option"));
		uDTO.setValue(request.getParameter("value"));
		
		List<ADMIN_User_InfoDTO> user_SearchList = userService.getUser_Search(uDTO);
		
		List<ADMIN_User_InfoDTO> activity_userList = new ArrayList<ADMIN_User_InfoDTO>();
		for(ADMIN_User_InfoDTO usDTO : user_SearchList) {
			if(!usDTO.getStatus().equals("0")) {
				activity_userList.add(usDTO);
			}
		}
		model.addAttribute("option", request.getParameter("option"));
		model.addAttribute("value", request.getParameter("value"));
		
		//게시판 쪼개기
		model.addAttribute("pageNum", request.getParameter("pageNum"));
		model.addAttribute("pageSize", request.getParameter("pageSize"));

		model.addAttribute("user_SearchList", activity_userList);
		
		return "/admin/user/user_activity_search_list";
	}
	
	//유저 활동정지 해제
		@RequestMapping(value="admin/user/user_activity_active", method=RequestMethod.GET)
		public String user_activity_active(HttpServletRequest request, Model model) throws Exception{
			ADMIN_User_InfoDTO uDTO = new ADMIN_User_InfoDTO();
			String ArrUser_Seq = request.getParameter("ArrUser_Seq");
			String[] array = ArrUser_Seq.split(",");
			for(int i=0; i<array.length; i++) {
				uDTO.setUser_chan(getDate());
				uDTO.setUser_seq(Integer.parseInt(array[i]));
				uDTO.setStatus("0");
				userService.user_Active(uDTO);
			}
			return user_activity_list(request, model);
		}
		
		//유저 강제탈퇴 해제
		@RequestMapping(value="admin/user/user_activity_drop", method=RequestMethod.GET)
		public String user_activity_drop(HttpServletRequest request, Model model) throws Exception{
			ADMIN_User_InfoDTO uDTO = new ADMIN_User_InfoDTO();
			String ArrUser_Seq = request.getParameter("ArrUser_Seq");
			String[] array = ArrUser_Seq.split(",");
			for(int i=0; i<array.length; i++) {
				uDTO.setUser_chan(getDate());
				uDTO.setUser_seq(Integer.parseInt(array[i]));
				uDTO.setStatus("0");
				userService.user_Drop(uDTO);
			}
			return user_activity_list(request, model);
		}
		
		//유저 등급변경
		@RequestMapping(value="admin/user/user_activity_auth", method=RequestMethod.GET)
		public String user_activity_auth(HttpServletRequest request, Model model) throws Exception{
			ADMIN_User_InfoDTO uDTO = new ADMIN_User_InfoDTO();
			String ArrUser_Seq = request.getParameter("ArrUser_Seq");
			String ArrUser_Auth = request.getParameter("ArrUser_Auth");
			String[] array = ArrUser_Seq.split(",");
			String[] array2 = ArrUser_Auth.split(",");
			for(int i=0; i<array.length; i++) {
				uDTO.setUser_seq(Integer.parseInt(array[i]));
				uDTO.setUser_auth(Integer.parseInt(array2[i]));
				userService.user_Auth(uDTO);
			}
			return user_activity_list(request, model);
		}
	
}
