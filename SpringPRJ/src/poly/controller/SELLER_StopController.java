package poly.controller;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.util.HttpUtil;
import poly.util.StringUtil;

@Controller
public class SELLER_StopController {
	private Logger log = Logger.getLogger(this.getClass());
	//로그를 찍고 파일로 남깁니다.
	
	/*@Resource(name="SELLER_StopService")
	public SELLER_IStopService stopService;
	*/
	@RequestMapping(value="seller/stop/stop1")
	public String stop1(HttpServletRequest request) throws Exception{
		log.info(this.getClass()+"stop1 start !!");
		
		log.info(this.getClass()+"stop1 end !!");
		return "/seller/stop/stop1";
	}
	//회수 판매 중지 json 형태 받아보기
	@RequestMapping(value="seller/stop/stop2")
	public @ResponseBody Map<String, Object> stop(HttpServletRequest request, Model model)throws Exception{
		log.info(this.getClass()+"stop start");
		
		
		HashMap<String, String> hashmapJson = new HashMap<String, String>();
		HashMap<String, Object> hashmapRes = new HashMap<String, Object>();
		try{

			String charSet = "EUC-KR";
			
			HashMap<String, String> hashmapResponse = (HashMap<String, String>) HttpUtil.callURLGet("http://openapi.foodsafetykorea.go.kr/api/8991ae93f67945e6b5ff/I0490/json/1/1000", charSet);
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
		
		
		log.info(this.getClass()+"stop end");
		return hashmapRes;
		
	}
	
}
