package poly.controller;


import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.OutputStreamWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.naming.Context;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.ws.spi.http.HttpContext;

import org.apache.log4j.Logger;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.dto.consumer.CONSUMER_FtReviewDTO;
import poly.dto.consumer.CONSUMER_RcmmndFtDTO;
import poly.dto.consumer.CONSUMER_RcmmndMenuDTO;
import poly.dto.consumer.CONSUMER_Search_Trend_WDateDTO;
import poly.service.CONSUMER_IFtService;
import poly.util.CmmUtil;
import poly.util.RServe;
import poly.util.ReadCSV;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/*
 * Controller 선언해야만 Spring 프레임워크에서 Controller인지 인식 가능
 * 자바 서블릿 역할 수행
 * */
@Controller
public class CONSUMER_DataAnalysisController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "CONSUMER_FtService")
	private CONSUMER_IFtService ftService;
	
	//추천 메뉴 페이지 메인
	@RequestMapping(value="consumer/rcmmnd/rcmmndMain", method=RequestMethod.GET)
	public String rcmmndMain(HttpServletRequest request, Model model) throws Exception{
		
		return "/consumer/rcmmnd/rcmmndMain";
	}
	
	//트럭왔냠의 추천 메뉴
	@RequestMapping(value="consumer/rcmmnd/rcmmndMenu", method=RequestMethod.GET)
	public String rcmmndMenu(HttpServletRequest request, Model model) throws Exception{
			
			String myAddress= CmmUtil.nvl(request.getParameter("myAddress"));
			String sido = "서울"; //기본 값 시도 명 서울
			if(!"".equals(myAddress)) sido = myAddress.split(" ")[0]; //값이 존재할 경우 시도 명 지정
			
			List<CONSUMER_RcmmndMenuDTO> rcmmndMenuDTO = ftService.getRcmmndMenuList(sido);
			
			model.addAttribute("rcmmndMenuDTO", rcmmndMenuDTO);

			return "/consumer/rcmmnd/rcmmndMenu";
	}
	
	//소비자 맞춤 추천 푸드트럭
	@RequestMapping(value="consumer/rcmmnd/CustomRcmmnd")
	public String CustomRcmmnd(HttpServletRequest request, Model model, HttpSession session) throws Exception{
		
		//로그인 안되어 있는 경우
		String userSeq = (CmmUtil.nvl((String)session.getAttribute("userSeq")));
		if("".equals(userSeq)) {
			String url = "/cmmn/main.do"; //로그인 화면 이동
			String msg = "로그인 후 이용해주시길 바랍니다.";
			model.addAttribute("url", url);
			model.addAttribute("msg", msg);
			return "/cmmn/alert";
		}
		
		//추천 대상이 되는 유저의 리뷰 DTO
		List<CONSUMER_FtReviewDTO> mainUserRvDTO = ftService.getUsersReviewList(Integer.parseInt(userSeq));
		
		//데이터가 충분히 쌓이지 않은 경우
		if( mainUserRvDTO == null || mainUserRvDTO.isEmpty()) {
			return "/consumer/rcmmnd/customRcmmnd";
		}
		
		//비교 대상이 되는 유저들의 리뷰 DTO
		List<CONSUMER_FtReviewDTO> compUsersRvDTO = ftService.getReviewList(Integer.parseInt(userSeq));
		
		//해쉬맵 생성 및 함수 호출
		List<CONSUMER_RcmmndFtDTO> rftDTOArr = null;
		RServe rserve = new RServe();
		rftDTOArr = rserve.usrEcldDist(mainUserRvDTO, compUsersRvDTO);
		
		//DB로 받아 올 푸드트럭 목록들
		List<CONSUMER_RcmmndFtDTO> rftDTOArrRslt = null;
		rftDTOArrRslt = ftService.getRcmmndFtList(rftDTOArr);
		
		//추천점수 이식
		for(CONSUMER_RcmmndFtDTO rftDTORslt : rftDTOArrRslt) {
			for(CONSUMER_RcmmndFtDTO rftDTO : rftDTOArr) {
				if(rftDTORslt.getUserSeq().equals(rftDTO.getUserSeq())) {
					rftDTORslt.setRcmmndRating(rftDTO.getRcmmndRating());
				}
			}
		}
		
		//거리 순으로 정렬 낮은값이 앞으로 옴
		for(int i = 0; i < rftDTOArrRslt.size() - 1; i++) {
			for(int j = i + 1; j < rftDTOArrRslt.size(); j++) {
				Double pivot = Double.parseDouble(rftDTOArrRslt.get(i).getRcmmndRating()); 
				Double compare = Double.parseDouble(rftDTOArrRslt.get(j).getRcmmndRating());
				CONSUMER_RcmmndFtDTO temp;
				if(pivot > compare) {
					temp = rftDTOArrRslt.get(j);
					rftDTOArrRslt.set(j, rftDTOArrRslt.get(i));
					rftDTOArrRslt.set(i, temp);
				}
			}
		}
		
		model.addAttribute("rftDTOArr", rftDTOArrRslt);
		
		return "/consumer/rcmmnd/customRcmmnd";
	}
	
	//검색어 트렌드 워드클라우드
	@RequestMapping(value="consumer/rcmmnd/wordCloudTrend")
	public String wordCloudTrend(HttpServletRequest request, Model model, HttpSession session) throws Exception{
		
		//csv파일을 저장할 실제경로
		String realPathCSV = request.getSession().getServletContext().getRealPath("/")+ "resources/js/consumer/d3Cloud/" + "searchTrend.csv";
		System.out.println(realPathCSV);
		
		//DB에서 검색어 목록,빈도수 가져오기
		ArrayList<Map<String, String>> trndKywrdMap = ftService.getSearchTrnd();
		
		//csv 읽기 함수
		ReadCSV rcsv = new ReadCSV();
		rcsv.wirteWrdCldCsv(realPathCSV, trndKywrdMap);
		
		/*-------------------------------------------- */
		
		//DB에서  날짜별 상위 3개 검색어 목록 가져오기
		
		String[] threeSrchTrndKywrd = ftService.getThreeSearchTrnd();
		Map<String, String> thrSrchKywrd = new HashMap<String, String>();
		
		thrSrchKywrd.put("first", threeSrchTrndKywrd[0]);
		thrSrchKywrd.put("second", threeSrchTrndKywrd[1]);
		thrSrchKywrd.put("third", threeSrchTrndKywrd[2]);
		log.info(threeSrchTrndKywrd[0]);
		log.info(threeSrchTrndKywrd[1]);
		log.info(threeSrchTrndKywrd[2]);
		
		List<CONSUMER_Search_Trend_WDateDTO> trndKywrdWDate = ftService.getSearchTrndWDate(thrSrchKywrd);

		String realPathCSV2 = request.getSession().getServletContext().getRealPath("/")+ "resources\\js\\consumer\\d3Cloud\\" + "topTrndKywrd.csv";
		
		/*rcsv.wirteTrndCsv(realPathCSV2, thrSrchKywrd, trndKywrdWDate);*/
		return "/consumer/rcmmnd/wordCloudTrend";
	}
	
}
