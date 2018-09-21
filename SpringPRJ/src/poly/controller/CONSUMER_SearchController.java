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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import poly.dto.consumer.CONSUMER_FtLikeDTO;
import poly.dto.consumer.CONSUMER_FtMenuCateDTO;
import poly.dto.consumer.CONSUMER_Ft_InfoDTO;
import poly.dto.consumer.CONSUMER_Ft_ReviewDTO;
import poly.dto.consumer.CONSUMER_ImageDTO;
import poly.dto.consumer.CONSUMER_Menu_InfoDTO;
import poly.dto.consumer.CONSUMER_UserDTO;
import poly.service.CONSUMER_IFtService;
import poly.util.CmmUtil;
import poly.util.GeoUtil;
import poly.util.CONSUMER_UtilFile;
import poly.util.SortTruck;
import poly.util.UtilRegex;
import poly.service.CONSUMER_IImageService;
import poly.service.CONSUMER_IUserService;
import poly.service.impl.CONSUMER_ImageService;
import poly.service.impl.CONSUMER_UserService;

/*
 * Controller 선언해야만 Spring 프레임워크에서 Controller인지 인식 가능
 * 자바 서블릿 역할 수행
 * */
@Controller
public class CONSUMER_SearchController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "CONSUMER_FtService")
	private CONSUMER_IFtService ftService;
	
	@Resource(name="CONSUMER_ImageService")
	private CONSUMER_IImageService imgService;

	@Resource(name="CONSUMER_UserService")
	private CONSUMER_IUserService UserService;
	
	

	//키워드로 메뉴를 검색한 페이지 
	@RequestMapping(value="consumer/cnsmr/findFtByMenu", method=RequestMethod.POST)
	public String findFtByMenu(HttpServletRequest request, Model model) throws Exception {
		log.info("Access consumer/cnsmr/findFtByMenu");

				
		String keyWord = request.getParameter("keyWord"); //cnsmrMain 페이지에서 아이디가 menu인 텍스트 상자에 입력받은 값을 불러옴
		String []locPosition = request.getParameter("locPosition").split(","); //GET방식으로 받은 locPosition을 분리하여 어레이 변수에 할당
		String []myAddress = request.getParameter("myAddress").split(" "); //현 사용자의 시도구 구군 읍면동 주소 정보
		//위치 미 설정시 내 위치 설정 페이지로 이동
		if("".equals(request.getParameter("myAddress")) || "".equals(request.getParameter("locPosition"))) {
			String msg= "위치 설정을 먼저 해주세요";
			String url= "/consumer/cnsmr/findMyLoc.do";
			
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return "/cmmn/alert";
		}
		
		log.info("위치 확인" + locPosition[0] + ", " + locPosition[1]);
		log.info("주소 확인" + myAddress);
		
		log.info(keyWord); //검색어 확인
		
		//검색어 정규표현식 검사
		String []keyWordList = keyWord.split(" "); // 검색어를 공백으로 나눠서 어레이에 저장
		boolean sidoCheck=false, dongCheck= false, sigunguCheck = false; //시도구 검사 , 동면읍리 검사 , 시군구 검사
		String keyWordMenu =""; //키워드 메뉴 부분
		
		for(int i = 0 ; i < keyWordList.length; i++) {
			log.info("키워드 확인 ......... "+keyWordList[i]);
			//검색어 정규표현식 검사
			sidoCheck = UtilRegex.sidoPattern(keyWordList[i]);
			log.info("시도검사 : " + sidoCheck);
			log.info("....................................");
			if(sidoCheck) continue;
			sigunguCheck = UtilRegex.sigunguPattern(keyWordList[i]);
			log.info("시군구검사 : " + sigunguCheck);
			log.info("....................................");
			if(sigunguCheck) continue;
			
			dongCheck = UtilRegex.dongPattern(keyWordList[i]);
			log.info("동검사 : " + dongCheck);
			log.info("....................................");
			if(dongCheck) continue;
			
			//위의 3중 아무것에도 속하지 않을 경우 메뉴키워드로 지정
			keyWordMenu = keyWordList[i];
			log.info("키워드메뉴검색" +keyWordMenu);
		}
		List<CONSUMER_Menu_InfoDTO> menuDTO  = new ArrayList<CONSUMER_Menu_InfoDTO>();
		List<CONSUMER_Menu_InfoDTO> newMenuDTO  = new ArrayList<CONSUMER_Menu_InfoDTO>();
		
		//검색어 분류
		//////1. 주소만 검색한 경우 - 시도구 검색
		if(sidoCheck && "".equals(keyWordMenu)) {
			
			log.info("시도구만 검색한 경우");
			
			List<CONSUMER_Ft_InfoDTO> ftList = ftService.getFtList(keyWordList[0]); //리스트형식의 푸드트럭 객체들을 테이블로부터 불러옴
			if(!ftList.isEmpty()) {
				menuDTO = ftService.getMenuListWithFtList(ftList);
			}
			 
		
		}////1. 주소만 검색한 경우 - 시군구 검색
		
		else if(sigunguCheck && "".equals(keyWordMenu)) {
		
			log.info("시군구만 검색 한 경우");
			
			List<CONSUMER_Ft_InfoDTO> ftList = ftService.getFtListSigungu(keyWordList[0]); //리스트형식의 푸드트럭 객체들을 테이블로부터 불러옴
			if(!ftList.isEmpty()) {
				menuDTO = ftService.getMenuListWithFtList(ftList);
			}
		
		}////1. 주소만 검색한 경우 - 동면읍리 검색
		
		else if(dongCheck && "".equals(keyWordMenu)) {
		
			log.info("동면읍리만 검색 한 경우");
			
			List<CONSUMER_Ft_InfoDTO> ftList = ftService.getFtListDong(keyWordList[0]); //리스트형식의 푸드트럭 객체들을 테이블로부터 불러옴
			if(!ftList.isEmpty()) {
				menuDTO = ftService.getMenuListWithFtList(ftList);
			}
		
		}/////3. 주소와 메뉴를 같이 검색한 경우
		
		else if ((sidoCheck || dongCheck) && !"".equals(keyWordMenu)) {
		
			log.info("주소와 메뉴를 같이 검색한 경우");
			
			menuDTO = ftService.getMenuList(keyWordMenu); 
			for(int i = 0; i < menuDTO.size(); i++) {
				if(menuDTO.get(i).getFtAddress().contains(keyWordList[0])) {
					newMenuDTO.add(menuDTO.get(i));
				}
			}
			menuDTO = newMenuDTO; //교체
		
		}/////4. 메뉴만 검색한 경우
		
		else if (!"".equals(keyWordMenu)){
		
			log.info("메뉴만 검색한 경우");
			
			//검색어가 포함된 메뉴들의 목록 가져오기
			
			menuDTO = ftService.getMenuList(keyWordMenu); 
			
		}
		//////menuDTO를 가까운 위치부터 정렬합니다.
		//메뉴 리스트 받아온 값 확인 해 보기
		for(int i = 0; i < menuDTO.size() && menuDTO != null; i++) {
			log.info(menuDTO.get(i).getMenu_name());
		}
		List<CONSUMER_Ft_InfoDTO> ftList = ftService.getFtList(myAddress[0]);
		//가까운 거리의 푸드트럭부터 메뉴DTO를 가져오는 정렬 함수
		List<CONSUMER_Menu_InfoDTO> sortedMenuDTO = SortTruck.getMenuDTO(menuDTO, ftList, locPosition);
		
		//sort 최종 확인
		for(int i = 0; i < sortedMenuDTO.size(); i++) {
			log.info(sortedMenuDTO.get(i).getMenu_name());	
		}	
		
		//////////////////메뉴 사진들 불러오기////////////////// 	
		log.info("menuList is NULL?" + sortedMenuDTO.isEmpty()); //리뷰 테이블에 정보가 있는지 확인하고 있으면 가져옴
		if(sortedMenuDTO.isEmpty() == false) {
			log.info(this.getClass() + " // Menu Images start !!");
			List<CONSUMER_ImageDTO> imgDTOs = new ArrayList<CONSUMER_ImageDTO>();
			
			
			for(int i = 0; i < sortedMenuDTO.size(); i++) {
				CONSUMER_ImageDTO ImgDTO = new CONSUMER_ImageDTO(); //리스트에 추가할 객체 선언
				ImgDTO.setFileId(sortedMenuDTO.get(i).getFile_id());	// 각 객체에 필요 파일 id정보 불러오기
				imgDTOs.add(ImgDTO); //리스트에 추가
			}
			
			imgDTOs = ftService.getMenuImage(imgDTOs);
			
			if (imgDTOs == null) {			
				imgDTOs = new ArrayList<CONSUMER_ImageDTO>();
			}		
			log.info("ImgDTOs size is :" + imgDTOs.size());
			
			//받아온 이미지 DTO 확인
			for(int i = 0; i < imgDTOs.size(); i++) {
				log.info("ImgDTOs. get : " + imgDTOs.get(i).getFileId());											
				log.info("ImgDTOs. get : " + imgDTOs.get(i).getFileOrgname());
				log.info("ImgDTOs.get : " + imgDTOs.get(i).getFilePath());				
				log.info("ImgDTOs. get : " + imgDTOs.get(i).getFileSevname());
				log.info("ImgDTOs.get : " + imgDTOs.get(i).getUserSeq());
			}
			
			model.addAttribute("imgDTOs",imgDTOs);
			imgDTOs = null;
			log.info(this.getClass() + "Menu Image end !!");
		}
		model.addAttribute("menuDTO", sortedMenuDTO); // 메뉴 DTO 전송
		///////////////////////////////////////////////////////
		
		
		//근처 푸드트럭 검색
		log.info(".............................");
		log.info("Current Location's Longitude is :" + locPosition[0]); //받아온 위도 확인
		log.info("Current Location's Latitude is :" + locPosition[1]);	// 받아온 경도 확인
		log.info(".............................");
		

		
		
		model.addAttribute("keyWord", keyWord); // 검색한 키워드 전송 
		log.info("Terminate consumer/cnsmr/findFtByMenu");
		log.info(".............................");
		return "/consumer/cnsmr/findFtByMenu";
	}
		
}
