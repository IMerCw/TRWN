package poly.controller;


import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.OutputStreamWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.rosuda.REngine.Rserve.RConnection;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import poly.dto.consumer.CONSUMER_FtLikeDTO;
import poly.dto.consumer.CONSUMER_FtMenuCateDTO;
import poly.dto.consumer.CONSUMER_FtReviewDTO;
import poly.dto.consumer.CONSUMER_Ft_InfoDTO;
import poly.dto.consumer.CONSUMER_Ft_ReviewDTO;
import poly.dto.consumer.CONSUMER_ImageDTO;
import poly.dto.consumer.CONSUMER_Menu_InfoDTO;
import poly.dto.consumer.CONSUMER_RcmmndMenuDTO;
import poly.dto.consumer.CONSUMER_UserDTO;
import poly.service.CONSUMER_IFtService;
import poly.util.CmmUtil;
import poly.util.CosineSimilarity;
import poly.util.GeoUtil;
import poly.util.RServe;
import poly.util.CONSUMER_UtilFile;
import poly.util.SortTruck;
import poly.util.UtilRegex;
import poly.service.CONSUMER_IImageService;
import poly.service.CONSUMER_IUserService;
import poly.service.impl.CONSUMER_ImageService;
import poly.service.impl.CONSUMER_UserService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

/*
 * Controller 선언해야만 Spring 프레임워크에서 Controller인지 인식 가능
 * 자바 서블릿 역할 수행
 * */
@Controller
public class CONSUMER_DataAnalysisController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "CONSUMER_FtService")
	private CONSUMER_IFtService ftService;
	
	//트럭왔냠의 추천 메뉴
	@RequestMapping(value="consumer/rcmmnd/rcmmndMenu", method=RequestMethod.GET)
	public String rcmmndMenu(HttpServletRequest request, Model model) throws Exception{
			log.info("Access rcmmndMenu.........");
			String myAddress= CmmUtil.nvl(request.getParameter("myAddress"));
			String sido = "서울"; //기본 값 시도 명 서울
			if(!"".equals(myAddress)) sido = myAddress.split(" ")[0]; //값이 존재할 경우 시도 명 지정
			System.out.println(sido);
			List<CONSUMER_RcmmndMenuDTO> rcmmndMenuDTO = ftService.getRcmmndMenuList(sido);
			model.addAttribute("rcmmndMenuDTO", rcmmndMenuDTO);
			
			log.info("Terminate rcmmndMenu.........");
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
		
		
		CosineSimilarity cossim = new CosineSimilarity();
		List<CONSUMER_FtReviewDTO> usersReivew = ftService.getUsersReviewList(Integer.parseInt(userSeq));
		Map<CharSequence, Integer> mainVector = new HashMap<>();

		for(int i = 0; i < usersReivew.size(); i++) {
			mainVector.put(String.valueOf(usersReivew.get(i).getFt_seq()), usersReivew.get(i).getRev_point());
			log.info("메인 벡터:" + usersReivew.get(i).getFt_seq() + " // " + usersReivew.get(i).getRev_point());
			
		}
		
		
		List<Map<CharSequence, Integer>> vectorList = new ArrayList<>(); //비교대상이 되는 벡터들을 저장할 리스트
		List<CONSUMER_FtReviewDTO> frDTO = ftService.getReviewList(Integer.parseInt(userSeq)); //유저들의 리뷰 정보
		Map<CharSequence, Integer> compVector = new HashMap<>(); //비교 대상이 될 벡터형식의 리뷰 값 <푸드트럭번호, 리뷰점수>
		
		log.info("현재 유저번호 :" + userSeq);
		
		Double result = cossim.cosineSimilarity(mainVector, compVector);
		
		
		
		log.info("The cosine Similariry of two vectors is "+ result);
		
		log.info("Terminate CustomRcmmnd...");
		return "/consumer/rcmmnd/customRcmmnd";
	}
	
	
	//리스트에서 비교할 벡터를 가져옴
	private Map<CharSequence, Integer> getCompVector(List<CONSUMER_FtReviewDTO> frDTO, int index) {
		Map<CharSequence, Integer> compVec = new HashMap<>();
		
		for(int i = index; i < frDTO.size(); i++) {
			log.info(frDTO.get(i).getUser_seq());
			if(frDTO.get(index).getUser_seq() != frDTO.get(i).getUser_seq()) {
				index=i;
				break;
			}
			log.info("비교대상 벡터 :" +frDTO.get(i).getFt_seq() + " // " + frDTO.get(i).getRev_point());
			compVec.put(String.valueOf(frDTO.get(i).getFt_seq()) ,frDTO.get(i).getRev_point());
		}
		return compVec;
	}
}
