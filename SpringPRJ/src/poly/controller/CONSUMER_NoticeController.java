package poly.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import poly.dto.consumer.CONSUMER_DissInfoDTO;
import poly.dto.consumer.CONSUMER_Gps_TableDTO;
import poly.dto.consumer.CONSUMER_ImageDTO;
import poly.dto.consumer.CONSUMER_WeatherDTO;
import poly.service.CONSUMER_IFtService;
import poly.service.CONSUMER_IUserService;
import poly.util.Coord;
import poly.util.OpenAPI;
import poly.util.SortRegCode;
import poly.util.UtilTime;


/*
 * Controller 선언해야만 Spring 프레임워크에서 Controller인지 인식 가능
 * 자바 서블릿 역할 수행
 * */

@Controller
public class CONSUMER_NoticeController {
	private Logger log = Logger.getLogger(this.getClass());

	
	@Resource(name = "CONSUMER_FtService")
	private CONSUMER_IFtService ftService;
	@Resource(name = "CONSUMER_UserService")
	private CONSUMER_IUserService userService;
	
	//MAIN페이지
	@RequestMapping(value="/consumer/main") 
	public String maintest(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception{
		log.info("Access main");
		
		//현재 배너 이미지 3개로 제한하여 사용
		////////////////////배너 사진 List로 불러오기////////////////// 											
		log.info(this.getClass() + " // Getting BannerImages start !!");
		List<CONSUMER_ImageDTO> imgDTOs = new ArrayList<CONSUMER_ImageDTO>();
		
													
		imgDTOs = ftService.getBannerImages();
		
		if (imgDTOs == null) {			
		imgDTOs = new ArrayList<CONSUMER_ImageDTO>();
		}
		//받아온 이미지 DTO 들 확인
		for(int i = 0; i < imgDTOs.size(); i++) {
		log.info("ImgDTOs. get : " + imgDTOs.get(i).getFileId());											
		log.info("ImgDTOs. get : " + imgDTOs.get(i).getFileOrgname());
		log.info("ImgDTOs.get : " + imgDTOs.get(i).getFilePath());				
		log.info("ImgDTOs. get : " + imgDTOs.get(i).getFileSevname());
		log.info("ImgDTOs.get : " + imgDTOs.get(i).getUserSeq());
		}
		
		model.addAttribute("imgDTOs",imgDTOs);
	
		imgDTOs = null;
		
		log.info(this.getClass() + "truckImage end !!");
		return "/consumer/main";
	}
	
	//날씨 정보, 식중독 예방 정보 페이지
	@RequestMapping(value="/consumer/weatherInfo", method=RequestMethod.GET) 
	public String weatherInfo(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception{
		log.info("Access weatherInfo");
		String myAddress = request.getParameter("myAddress");
		String regCode = request.getParameter("regCode");
		
		if("".equals(myAddress) || "".equals(regCode)) {
			//위치설정 안되어 있는 경우
			String url= "/consumer/cnsmr/findMyLoc.do";
			String msg ="위치 설정 후 사용해주세요.";

			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			
			return "/cmmn/alert";
		}
		String url = "http://apis.data.go.kr/B550928/dissForecastInfoSvc/getDissForecastInfo"
				//서비스 키
				+ "?serviceKey=NM1oJvYCcGILHPKU0R8dmv9P%2BvAxnAXIoSLH29uHh4TFUkRZdD9iqZF7HnKPYCQHBM1eM29GDwkz5of%2BiHtT0g%3D%3D"
				// 반환 데이터 타입
				+ "&type=json"
				// 질병 코드:3 식중독
				+ "&dissCd=3"
				// 지역코드
				+ "&znCd="+ regCode;
		CONSUMER_DissInfoDTO dissInfoDTO = OpenAPI.getDissInfo(url);
		model.addAttribute("dissInfoDTO", dissInfoDTO); //식중독 예방정보가 할당된 1개의 객체 전송
		dissInfoDTO = null; url = null;
		/*model.addAttribute("myAddress", myAddress);*/ //topBody.jsp에 세션이 있기 때문에 model 사용하지 않음
		log.info("Terminate weatherInfo");		
		return "/consumer/weatherInfo";
	}
	
	// 내 위치 찾기 페이지 이동
	@RequestMapping(value="/consumer/cnsmr/findMyLoc")
	public String findMyLoc() throws Exception{
		log.info("access FindMyLoc");
		
		return "/consumer/cnsmr/findMyLoc";
	}
	
	//위치정보 받아와서 처리 -- PROCEDURE
	@RequestMapping(value="/consumer/myLocProc", method=RequestMethod.POST) 
	public String myLocProc(HttpServletRequest request, HttpServletResponse response, Model model, HttpSession session) throws Exception{
		log.info("Access myLocProc");
		
		String userSeq = request.getParameter("userSeq"); // 유저번호
		String myLat = request.getParameter("myLat"); // 위도
		String myLon = request.getParameter("myLon"); // 경도
		String myAddress = request.getParameter("myAddress"); // 지번 주소 명
		String gridX = request.getParameter("gridX"); //날씨용 좌표 X
		String gridY = request.getParameter("gridY"); //날씨용 좌표 Y
		String []myAddrArr = myAddress.split(" "); // 시도구 시군구 읍면동 정보
		String sido = myAddrArr[0];
		String sigungu = myAddrArr[1];
		String dong = myAddrArr[2];
		String gpsEtc = "";  
		for(int i = 3; i < myAddrArr.length; i++) {
			gpsEtc += myAddrArr[i];
		}
		//미 로그인시 유저번호는 -1로 지정하여 DB에 저장
		if(userSeq.equals("")) {
			userSeq = "-1";
			System.out.println("null check complete");
		}
		
		log.info(userSeq);
		log.info(myLat);
		log.info(myLon);
		log.info(myAddress);
		log.info(sido);
		log.info(sigungu);
		log.info(dong);
		log.info(gpsEtc);
		log.info("날씨용 지역 코드 X : " + gridX); //날씨용 지역코드 변환
		log.info("날씨용 지역 코드 Y : " + gridY); //날씨용 지역코드 변환
		
		//유저번호, GPS정보 DB저장
		CONSUMER_Gps_TableDTO gpsDTO = new CONSUMER_Gps_TableDTO();
		gpsDTO.setUser_seq(Integer.parseInt(userSeq));
		gpsDTO.setGps_x(myLat);
		gpsDTO.setGps_y(myLon);
		gpsDTO.setGps_sido(sido);
		gpsDTO.setGps_sigungu(sigungu);
		gpsDTO.setGps_dong(dong);
		gpsDTO.setGps_etc(gpsEtc);
		gpsDTO.setGps_renew_date(UtilTime.getDateYMDhms());
		
		int resultSet = userService.setGps(gpsDTO);
		int resultUpdate = userService.updateGps(gpsDTO); //gpsDTO에 있는 gps_seq 값과 user_Seq값 이용
		log.info(gpsDTO.getGps_seq());
		log.info("DB저장 결과(1: 성공)  >>>>>>>> " + resultSet + ", " + resultUpdate);
		
		
		
		//////////////동네날씨예보 API시작!!!//////////////
		Coord coord = new Coord(gridX, gridY);	//지역코드
		String skyCode =null, ptyCode = null, t3hCode = null; 
		
		//skycode 하늘상태(맑음:1, 구름조금:2, 구름많음:3, 흐림:4)
		//ptyCode 강수형태(없음:0, 비:1, 비/눈:2, 눈:3)
		//t3hCode 3시간 동안의 기온(단위 ℃)
		List<CONSUMER_WeatherDTO> weatherDTOs = OpenAPI.getWeatherData(coord);
		if(weatherDTOs != null) {
			for(CONSUMER_WeatherDTO weatherDTO: weatherDTOs) {
				switch(weatherDTO.getCategory()) {
					case "SKY": skyCode = weatherDTO.getFcstValue(); break; 
					case "PTY": ptyCode = weatherDTO.getFcstValue(); break; 
					case "T3H": t3hCode = weatherDTO.getFcstValue(); break;
					default: break;
				}
			}	
		}
		
		String regCode = SortRegCode.chgToRegCode(myAddress); //질병예방 API 용 지역코드
		log.info("Your regCode is : " + regCode);
		session.setAttribute("myLat", myLat);
		session.setAttribute("myLon", myLon);
		session.setAttribute("myAddress", myAddress);
		session.setAttribute("regCode", regCode);
		session.setAttribute("skyCode", skyCode);
		session.setAttribute("ptyCode", ptyCode);
		session.setAttribute("t3hCode", t3hCode);
		weatherDTOs = null;
		/////////////////////////////////////////////
		log.info("Terminate myLocProc");
		return "redirect:/consumer/main.do";
		
	}
	


}
