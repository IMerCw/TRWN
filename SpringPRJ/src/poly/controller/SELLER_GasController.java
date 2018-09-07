package poly.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.util.CmmUtil;
import poly.util.HttpUtil;
import poly.util.StringUtil;

@Controller
public class SELLER_GasController {
		private Logger log = Logger.getLogger(this.getClass());
		//로그를 찍고 파일로 남십니다 .
		
		@RequestMapping(value="/seller/gasStation/gas")
		public String gas()throws Exception{
			log.info(this.getClass() + "gas start ~~!!");
			log.info(this.getClass() + "gas end ~~!!");
			return "/seller/gasStation/gas";
		}
		@RequestMapping(value="/gasStation/test" , method=RequestMethod.POST)
		public @ResponseBody Map<String, Object> test(HttpServletRequest request) throws Exception{
			log.info(this.getClass() + " testController start !!");
			String x = CmmUtil.nvl(request.getParameter("x"));
			log.info("gasStation Controller x : " + x );
			String y = CmmUtil.nvl(request.getParameter("y"));
			log.info("gasStation Controller y : " + y );
			String prodcd = CmmUtil.nvl(request.getParameter("prodcd"));
			log.info("prodcd : " + prodcd);
			
			
			
			HashMap<String, String> hashmapJson = new HashMap<String, String>();
			HashMap<String, Object> hashmapRes = new HashMap<String, Object>();

			try{

				String charSet = "EUC-KR";
				
				HashMap<String, String> hashmapResponse = (HashMap<String, String>) HttpUtil.callURLGet("http://www.opinet.co.kr/api/aroundAll.do?code=F329180723&x="+x+"&y="+y+"&radius=3000&sort=1&prodcd="+prodcd+"&out=json", charSet);
				if ("200".equals(hashmapResponse.get("httpStatus"))){
					String responseBody = String.valueOf(hashmapResponse.get("responseBody"));
					hashmapRes = StringUtil.JsonStringToObject(responseBody);
				}else{
					hashmapRes.put("REP_CODE", "9999");
					hashmapRes.put("REP_MSG", "오류가 발생했습니다.");
				}
			}catch (Exception e){
				hashmapRes.put("REP_CODE", "9999");
				hashmapRes.put("REP_MSG", "오류가 발생했습니다.");
			}
				
			Iterator<String> i =  hashmapRes.keySet().iterator();
			while(i.hasNext()) {
				String key = i.next();
				System.out.println(hashmapRes.get(key));
			}
				
			log.info(this.getClass() + " test Controller end !!");
			
			return hashmapRes;
		}
		
		

}
