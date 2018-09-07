package poly.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import poly.dto.admin.ADMIN_BoardDTO;
import poly.dto.admin.ADMIN_CouponDTO;
import poly.dto.admin.ADMIN_Coupon_IssueDTO;
import poly.dto.admin.ADMIN_Ft_Menu_CateDTO;
import poly.dto.admin.ADMIN_User_InfoDTO;
import poly.service.ADMIN_ICouponService;
import poly.service.ADMIN_IUserService;

@Controller
public class ADMIN_CouponController {
	public Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="ADMIN_CouponService")
	private ADMIN_ICouponService couponService;
	
	@Resource(name="ADMIN_UserService")
	private ADMIN_IUserService userService;
	
/*----------------------------------------------------------------------------------------*/
	
	public String getDate() {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy. MM. dd / hh:mm:ss");
		String date = sdf1.format(cal.getTime());
		
		return date;
	}
	
	public String coupon_Callender(String[] coupon_date1, String[] coupon_date2) {
		String cp_date1 ="";
		String cp_date2 ="";
		switch(coupon_date1[1]) {
			case "Jan" : coupon_date1[1] = "01"; break;
			case "Feb" : coupon_date1[1] = "02"; break;
			case "Mar" : coupon_date1[1] = "03"; break;
			case "Apr" : coupon_date1[1] = "04"; break;
			case "May" : coupon_date1[1] = "05"; break;
			case "Jun" : coupon_date1[1] = "06"; break;
			case "Jul" : coupon_date1[1] = "07"; break;
			case "Aug" : coupon_date1[1] = "08"; break;
			case "Sep" : coupon_date1[1] = "09"; break;
			case "Oct" : coupon_date1[1] = "10"; break;
			case "Nov" : coupon_date1[1] = "11"; break;
			case "Dec" : coupon_date1[1] = "12"; break;
			default : break;
		}
		switch(coupon_date2[1]) {
			case "Jan" : coupon_date2[1] = "01"; break;
			case "Feb" : coupon_date2[1] = "02"; break;
			case "Mar" : coupon_date2[1] = "03"; break;
			case "Apr" : coupon_date2[1] = "04"; break;
			case "May" : coupon_date2[1] = "05"; break;
			case "Jun" : coupon_date2[1] = "06"; break;
			case "Jul" : coupon_date2[1] = "07"; break;
			case "Aug" : coupon_date2[1] = "08"; break;
			case "Sep" : coupon_date2[1] = "09"; break;
			case "Oct" : coupon_date2[1] = "10"; break;
			case "Nov" : coupon_date2[1] = "11"; break;
			case "Dec" : coupon_date2[1] = "12"; break;
			default : break;
		}
			cp_date1 = coupon_date1[3]+". "+coupon_date1[1]+". "+coupon_date1[2];
			cp_date2 = coupon_date2[3]+". "+coupon_date2[1]+". "+coupon_date2[2];
		String coupon_date = cp_date1+" - "+cp_date2;
		
		return coupon_date;
	}
	
	//쿠폰메인
	@RequestMapping(value="admin/coupon/coupon_main", method=RequestMethod.GET)
	public String coupon_main(HttpServletRequest request, Model model) throws Exception{
		String cmd = request.getParameter("cmd");
		if(cmd==null) {
			cmd="coupon_list";
		}
		if(cmd.equals("coupon_list")) {
			List<ADMIN_CouponDTO> cpDTOarr = couponService.getCoupon_List();
			model.addAttribute("cpDTOarr", cpDTOarr);
			
			//게시판 쪼개기
			model.addAttribute("pageNum", request.getParameter("pageNum"));
			model.addAttribute("pageSize", request.getParameter("pageSize"));
			
		}else if(cmd.equals("coupon_search_list")) {
			String option = request.getParameter("option");
			String value = request.getParameter("value");
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("option", option);
			map.put("value", value);
			
			List<ADMIN_CouponDTO> cpDTOarr = couponService.getCoupon_Search_List(map);
			model.addAttribute("option", option);
			model.addAttribute("value", value);
			model.addAttribute("cpDTOarr", cpDTOarr);
			
			//게시판 쪼개기
			model.addAttribute("pageNum", request.getParameter("pageNum"));
			model.addAttribute("pageSize", request.getParameter("pageSize"));
			
		}else if(cmd.equals("coupon_edit")) {//쿠폰수정
			ADMIN_CouponDTO cpDTO = couponService.getCoupon_Info(request.getParameter("coupon_code"));
			model.addAttribute("cpDTO", cpDTO);
		}else if(cmd.equals("coupon_issue")) {//쿠폰발급
			List<ADMIN_User_InfoDTO> uDTOarr = userService.getUser_InfoList();
			model.addAttribute("uDTOarr", uDTOarr);
			List<ADMIN_CouponDTO> cpDTOarr = couponService.getCoupon_List();
			model.addAttribute("cpDTOarr", cpDTOarr);
		}else if(cmd.equals("coupon_issue_list")) {//쿠폰발급 리스트
			List<ADMIN_User_InfoDTO> uDTOarr = userService.getUser_InfoList();
			model.addAttribute("uDTOarr", uDTOarr);
			List<ADMIN_CouponDTO> cpDTOarr = couponService.getCoupon_List();
			model.addAttribute("cpDTOarr", cpDTOarr);
			List<ADMIN_Coupon_IssueDTO> cpisDTOarr = couponService.getCoupon_Issue_List();
			model.addAttribute("cpisDTOarr", cpisDTOarr);
			
			//쿠폰발급대상 셋팅
			List<ADMIN_User_InfoDTO> cpis_uDTOarr = new ArrayList<ADMIN_User_InfoDTO>();
			for(ADMIN_Coupon_IssueDTO cpisDTO : cpisDTOarr) {
				cpis_uDTOarr.add(userService.getUser(cpisDTO.getUser_seq()));
			}
			model.addAttribute("cpis_uDTOarr", cpis_uDTOarr);
			
			//게시판 쪼개기
			model.addAttribute("pageNum", request.getParameter("pageNum"));
			model.addAttribute("pageSize", request.getParameter("pageSize"));
		}else if(cmd.equals("coupon_issue_search_list")) {//쿠폰발급 검색리스트
			String option = request.getParameter("option");
			String value = request.getParameter("value");
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("option", option);
			map.put("value", value);
			
			List<ADMIN_User_InfoDTO> uDTOarr = userService.getUser_InfoList();
			model.addAttribute("uDTOarr", uDTOarr);
			List<ADMIN_CouponDTO> cpDTOarr = couponService.getCoupon_List();
			List<ADMIN_Coupon_IssueDTO> cpisDTOarr = couponService.getCoupon_Issue_Search_List(map);
			
			model.addAttribute("option", option);
			model.addAttribute("value", value);
			model.addAttribute("cpDTOarr", cpDTOarr);
			model.addAttribute("cpisDTOarr", cpisDTOarr);
			
			//게시판 쪼개기
			model.addAttribute("pageNum", request.getParameter("pageNum"));
			model.addAttribute("pageSize", request.getParameter("pageSize"));
		}
		
		model.addAttribute("cmd", cmd);
		
		return "/admin/coupon/coupon_main";
	}
	
	//쿠폰 만들기
	@RequestMapping(value="admin/coupon/coupon_create", method=RequestMethod.POST)
	public String coupon_create(HttpServletRequest request, Model model) throws Exception{
		ADMIN_CouponDTO cpDTO = new ADMIN_CouponDTO();
		String coupon_name = request.getParameter("coupon_name");
		String coupon_option = request.getParameter("dc_money1") + "/";
		coupon_option += request.getParameter("dc").equals("1")?"%":"원";
		coupon_option += "/" + request.getParameter("dc_money2") + "/" + request.getParameter("dc_money3");
		String[] coupon_date1 = request.getParameter("coupon_date1").split(" ");
		String[] coupon_date2 = request.getParameter("coupon_date2").split(" ");
		
		String coupon_date = coupon_Callender(coupon_date1, coupon_date2);
		cpDTO.setCoupon_name(coupon_name);
		cpDTO.setCoupon_option(coupon_option);
		cpDTO.setCoupon_date(coupon_date);
		couponService.Coupon_Create(cpDTO);
		
		return coupon_main(request, model);
	}
	
	//쿠폰삭제
	@RequestMapping(value="admin/coupon/coupon_delete", method=RequestMethod.GET)
	public String coupon_delete(HttpServletRequest request, Model model) throws Exception{
		String ArrCoupon_Code = request.getParameter("ArrCoupon_Code");
		if(ArrCoupon_Code!=null) {
			String[] array = ArrCoupon_Code.split(",");
			for(int i=0; i<array.length; i++) {
				couponService.Coupon_delete(array[i]);
			}
		}
		
		return coupon_main(request, model);
	}
	
	//쿠폰수정
	@RequestMapping(value="admin/coupon/coupon_edit", method=RequestMethod.POST)
	public String coupon_edit(HttpServletRequest request, Model model) throws Exception{
		ADMIN_CouponDTO cpDTO = new ADMIN_CouponDTO();
		String coupon_name = request.getParameter("coupon_name");
		String coupon_option = request.getParameter("dc_money1") + "/";
		coupon_option += request.getParameter("dc").equals("1")?"%":"원";
		coupon_option += "/" + request.getParameter("dc_money2") + "/" + request.getParameter("dc_money3");
		String[] coupon_date1 = request.getParameter("coupon_date1").split(" ");
		String[] coupon_date2 = request.getParameter("coupon_date2").split(" ");
		
		String coupon_date = coupon_Callender(coupon_date1, coupon_date2);
		cpDTO.setCoupon_code(request.getParameter("coupon_code"));
		cpDTO.setCoupon_name(coupon_name);
		cpDTO.setCoupon_option(coupon_option);
		cpDTO.setCoupon_date(coupon_date);
		couponService.Coupon_Edit(cpDTO);
		
		return coupon_main(request, model);
	}
	
	
	//--------------------------------------------------------------------------------------------------------
	
	//쿠폰 발급
		@RequestMapping(value="admin/coupon/coupon_issue", method=RequestMethod.POST)
		public String coupon_issue(HttpServletRequest request, Model model) throws Exception{
			ADMIN_Coupon_IssueDTO cpisDTO = new ADMIN_Coupon_IssueDTO();
			String coupon_code = request.getParameter("coupon_code");
			int coupon_count = Integer.parseInt(request.getParameter("coupon_count"));
			cpisDTO.setUser_seq(Integer.parseInt(request.getParameter("user_seq")));
			cpisDTO.setCoupon_code(coupon_code);
			cpisDTO.setCoupon_count(coupon_count);
			cpisDTO.setCoupon_issuedate(getDate());
			cpisDTO.setCoupon_use(0);
			
			couponService.Coupon_Issue(cpisDTO);
			
			return coupon_main(request, model);
		}
		
		//쿠폰 회수
		@RequestMapping(value="admin/coupon/coupon_issue_delete", method=RequestMethod.GET)
		public String coupon_issue_delete(HttpServletRequest request, Model model) throws Exception{
			String ArrIssue_Code = request.getParameter("ArrIssue_Code");
			String[] array = ArrIssue_Code.split(",");
			for(int i=0; i<array.length; i++) {
				couponService.Coupon_Issue_delete(Integer.parseInt(array[i]));
			}
			
			return coupon_main(request, model);
		}
}







