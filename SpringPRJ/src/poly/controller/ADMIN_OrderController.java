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

import poly.dto.admin.ADMIN_CouponDTO;
import poly.dto.admin.ADMIN_Order_InfoDTO;
import poly.dto.admin.ADMIN_User_InfoDTO;
import poly.service.ADMIN_IOrderService;
import poly.service.ADMIN_IUserService;

@Controller
public class ADMIN_OrderController {
	public Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="ADMIN_UserService")
	private ADMIN_IUserService userService;
	
	@Resource(name="ADMIN_OrderService")
	private ADMIN_IOrderService orderService;
	
/*----------------------------------------------------------------------------------------*/
	
	public String getDate() {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy. MM. dd / hh:mm:ss");
		String date = sdf1.format(cal.getTime());
		
		return date;
	}
	
/*주문관리----------------------------------------------------------------------------------------*/	
	
	//주문 리스트
	@RequestMapping(value="admin/order/order_main", method=RequestMethod.GET)
	public String order_main(HttpServletRequest request, Model model) throws Exception{
		String cmd = request.getParameter("cmd");
		if(cmd==null) {
			cmd="order_list";
		}
		if(cmd.equals("order_list")) {
			List<ADMIN_User_InfoDTO> userList = userService.getUser_InfoList();
			List<ADMIN_Order_InfoDTO> orDTOarr = orderService.getOrder_List();
			model.addAttribute("orDTOarr", orDTOarr);
		}else if(cmd.equals("order_search_list")){
			ADMIN_Order_InfoDTO orDTO = new ADMIN_Order_InfoDTO();
			orDTO.setOption(request.getParameter("option"));
			orDTO.setValue(request.getParameter("value"));
			List<ADMIN_Order_InfoDTO> orDTOarr = orderService.getOrder_List_Search(orDTO);
			model.addAttribute("orDTOarr", orDTOarr);
			model.addAttribute("option", request.getParameter("option"));
			model.addAttribute("value", request.getParameter("value"));
		}
		
		//게시판 쪼개기
		model.addAttribute("pageNum", request.getParameter("pageNum"));
		model.addAttribute("pageSize", request.getParameter("pageSize"));
		
		//페이지 커맨드
		model.addAttribute("cmd", cmd);
		
		return "/admin/order/order_main";
	}
	
	//주문삭제
	@RequestMapping(value="admin/order/order_delete", method=RequestMethod.GET)
	public String coupon_delete(HttpServletRequest request, Model model) throws Exception{
		String ArrOrd_seq = request.getParameter("ArrOrd_seq");
		if(ArrOrd_seq!=null) {
			String[] array = ArrOrd_seq.split(",");
			for(int i=0; i<array.length; i++) {
				orderService.order_Delete(Integer.parseInt(array[i]));
			}
		}
		
		return order_main(request, model);
	}
}





