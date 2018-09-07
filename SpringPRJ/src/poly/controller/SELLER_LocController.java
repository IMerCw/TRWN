package poly.controller;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.util.CmmUtil;
import poly.util.CrawlingUtil;

@Controller
public class SELLER_LocController {
	private Logger log = Logger.getLogger(this.getClass());
	//로그를 찍고 파일로 남깁니다 .
	
	/*
	 * @Resource(name="LocService")
	private ILocService LocService;
	//메모리에 올려주고 싱글톤 패턴을 적용시켜줍니다 .s
	 */	
	@RequestMapping(value="seller/loc/loc")
	public String loc(Model model)throws Exception{
		log.info(this.getClass() + "loc start ~!!@");
	
		String festivalHTML =CmmUtil.nvl(CrawlingUtil.getFestivalHTML());
		log.info(festivalHTML);
		//쉐프트럭 
		model.addAttribute("festivalHTML",festivalHTML);
		
		log.info(this.getClass() + "loc end!!@@");
		
		return "/seller/locF/loc";
	}

}
