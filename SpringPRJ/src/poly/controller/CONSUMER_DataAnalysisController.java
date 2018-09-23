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
import poly.dto.consumer.CONSUMER_RcmmndMenuDTO;
import poly.service.CONSUMER_IFtService;
import poly.util.CmmUtil;
import poly.util.RServe;
import poly.util.ReadCSV;

import java.util.ArrayList;
import java.util.HashMap;
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
			System.out.println(sido);
			List<CONSUMER_RcmmndMenuDTO> rcmmndMenuDTO = ftService.getRcmmndMenuList(sido);
			model.addAttribute("rcmmndMenuDTO", rcmmndMenuDTO);
			
			return "/consumer/rcmmnd/rcmmndMenu";
	}
	
	//소비자 맞춤 추천 메뉴
	@RequestMapping(value="consumer/rcmmnd/CustomRcmmnd")
	public String CustomRcmmnd(HttpServletRequest request, Model model, HttpSession session) throws Exception{
		log.info("Access CustomRcmmnd...");
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
		List<CONSUMER_FtReviewDTO> mainUserRvDTO = ftService.getReviewList(Integer.parseInt(userSeq));
		//비교 대상이 되는 유저들의 리뷰 DTO
		List<CONSUMER_FtReviewDTO> compUsersRvDTO = ftService.getUsersReviewList(Integer.parseInt(userSeq));
		
		
	
		RServe rserve = new RServe();
		rserve.test(mainUserRvDTO, compUsersRvDTO);
	
		log.info("Terminate CustomRcmmnd...");
		return "/consumer/rcmmnd/customRcmmnd";
	}
	
	//검색어 트렌드 워드클라우드
	@RequestMapping(value="consumer/rcmmnd/wordCloudTrend")
	public String wordCloudTrend(HttpServletRequest request, Model model, HttpSession session) throws Exception{
		
		//csv파일을 저장할 실제경로
		String realPathCSV = request.getSession().getServletContext().getRealPath("/")+ "resources\\js\\consumer\\d3Cloud\\" + "searchTrend.csv";
		/*System.out.println(realPathCSV);*/ //실제 경로
		
		//DB에서 검색어 목록,빈도수 가져오기
		ArrayList<Map<String, String>> trndKywrdMap = ftService.getSearchTrnd();
		
		//csv 읽기 함수
		ReadCSV rcsv = new ReadCSV();
		rcsv.wirteTrendCsv(realPathCSV, trndKywrdMap);
		
		return "/consumer/rcmmnd/wordCloudTrend";
	}
	
}
