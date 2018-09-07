package poly.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.dto.seller.SELLER_FtSellerDTO;
import poly.dto.seller.SELLER_WaitDTO;
import poly.service.SELLER_IOrderWaitService;
import poly.util.CmmUtil;

@Controller
public class SELLER_OrderWaitController {
	private Logger log = Logger.getLogger(this.getClass());
	//로그를 찍고 파일로 남깁니다 .
	
	@Resource(name="SELLER_OrderWaitService")
	public SELLER_IOrderWaitService orderWaitService;
	//메로리에 올려두고 싱글톤 패턴을 적용기켜줍니다 .
	
	//주문대기열 화면 
	@RequestMapping(value="seller/orderWait/orderWait", method=RequestMethod.GET)
	public String OrderWaitMapper(HttpServletRequest request, Model model)throws Exception{
		log.info(this.getClass() + "orderWait start !! ");
		String userSeq = CmmUtil.nvl(request.getParameter("userSeq"));
		log.info("userSeq : " + userSeq);
		
		SELLER_FtSellerDTO ftsDTO = new SELLER_FtSellerDTO();
		ftsDTO.setUserSeq(userSeq);
		
		ftsDTO = orderWaitService.getftSeqDTO(ftsDTO);
		if (ftsDTO == null) {
			ftsDTO = new SELLER_FtSellerDTO();
			return "/seller/orderWait/waitEmpty";
		}
		SELLER_WaitDTO wDTO = new SELLER_WaitDTO();
		wDTO.setFtSeq(ftsDTO.getFtSeq());
		
		List<SELLER_WaitDTO> wList = orderWaitService.getwaitDTO(wDTO);
		if(wList.isEmpty()) {
			log.info("if wList.isEmpty");
			return  "/seller/orderWait/waitEmpty";
		}
		
		
		model.addAttribute("wList",wList);
		
		wList=null;
		ftsDTO=null;
		wDTO =null;
		
		log.info(this.getClass() + "orderWait end !! ");
		return "/seller/orderWait/orderWait";
	}
	@RequestMapping(value="seller/orderWait/waitComplete")
	public @ResponseBody List<SELLER_WaitDTO> waitComplete(HttpServletRequest request, Model model)throws Exception{
		log.info(this.getClass() + "waitComplete start !! ");
		String waitSeq = CmmUtil.nvl(request.getParameter("waitSeq"));
		log.info("waitSeq : " + waitSeq);
		String ftSeq = CmmUtil.nvl(request.getParameter("ftSeq"));
		log.info("ftSeq : " + ftSeq);
		
		SELLER_WaitDTO wDTO = new SELLER_WaitDTO();
		wDTO.setWaitSeq(waitSeq);
		wDTO.setFtSeq(ftSeq);
		
		List<SELLER_WaitDTO> wList = orderWaitService.getWaitComplete(wDTO);
		for(int i=0; i<wList.size(); i++) {
			System.out.println("wList Hp : "+ wList.get(i).getUserHp());
			System.out.println("wList userSeq: " +wList.get(i).getUserSeq());
			System.out.println("wList  : " + wList.get(i).getOrdSeq());
			System.out.println("wList waitSeq : " + wList.get(i).getWaitSeq());
			System.out.println("wList ftSeq : " + wList.get(i).getFtSeq());
			System.out.println("==================================");
		}
		model.addAttribute("wList",wList);
		
		
		log.info(this.getClass() + "waitComplete end !!! ");
		return wList;
	}
	
}
