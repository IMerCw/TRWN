package poly.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


import poly.dto.seller.SELLER_BoardDTO;
import poly.dto.seller.SELLER_ReviewDTO;
import poly.service.SELLER_IBoardService;
import poly.util.CmmUtil;

@Controller
public class SELLER_FoodSafety {
	
	private Logger log = Logger.getLogger(this.getClass());
	/*로그를 찍고 파일로 남깁니다 .*/
	
	@Resource(name="SELLER_BoardService")
	private SELLER_IBoardService BoardService;
	
	//식품 안전 정보 메인
	@RequestMapping(value="/seller/foodSafety/fdSftyMain")
	public String foodSafety_main(HttpServletRequest request, Model model ) throws Exception{
		
		
		return "/seller/foodSafety/fdSftyMain";
	}
	
	

}
