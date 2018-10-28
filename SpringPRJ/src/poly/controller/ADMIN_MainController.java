package poly.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import poly.dto.admin.ADMIN_BoardDTO;
import poly.dto.admin.ADMIN_Board_PostDTO;
import poly.dto.admin.ADMIN_Order_InfoDTO;
import poly.dto.admin.ADMIN_Search_TrendDTO;
import poly.dto.admin.ADMIN_User_InfoDTO;
import poly.dto.consumer.CONSUMER_Ft_InfoDTO;
import poly.dto.consumer.CONSUMER_ImageDTO;
import poly.service.ADMIN_IBoardService;
import poly.service.ADMIN_IImageService;
import poly.service.ADMIN_IOrderService;
import poly.service.ADMIN_IUserService;
import poly.service.CONSUMER_IFtService;
import poly.service.CONSUMER_IImageService;
import poly.service.CONSUMER_IUserService;
import poly.service.impl.ADMIN_MainService;
import poly.util.CmmUtil;
import poly.util.SortTruck;

@Controller
public class ADMIN_MainController {
	public Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="ADMIN_MainService")
	private ADMIN_MainService mainService;
	
	@Resource(name="ADMIN_UserService")
	private ADMIN_IUserService userService;
	
	@Resource(name = "ADMIN_BoardService")
	private ADMIN_IBoardService boardService;
	
	@Resource(name="ADMIN_ImageService")
	private ADMIN_IImageService imgService;
	
	@Resource(name="ADMIN_OrderService")
	private ADMIN_IOrderService orderService;
	
	@Resource(name = "CONSUMER_FtService")
	private CONSUMER_IFtService ftService;
	
	@Resource(name="CONSUMER_ImageService")
	private CONSUMER_IImageService cimgService;

/*----------------------------------------------------------------------------------------*/
	
	public String getDate() {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy.MM.dd / HH:mm:ss");
		String date = sdf1.format(cal.getTime());
		
		return date;
	}
	
	public String getDate2() {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy.MM.dd");
		String date = sdf1.format(cal.getTime());
		
		return date;
	}
	
	public static List sortByValue(final Map map){
        List<String> list = new ArrayList();
        list.addAll(map.keySet());
         
        Collections.sort(list,new Comparator(){
             
            public int compare(Object o1,Object o2){
                Object v1 = map.get(o1);
                Object v2 = map.get(o2);
                 
                return ((Comparable) v1).compareTo(v2);
            }
             
        });
        Collections.reverse(list); // 주석시 오름차순
        return list;
    }
/*----------------------------------------------------------------------------------------*/
	
	@RequestMapping(value="admin/admin_main")
	public String main(HttpServletRequest request, Model model, HttpSession session) throws Exception{
		if(session.getAttribute("userSeq")==null){
			return ADMIN_LoginController.admin_login(request, model);
		}
		
		//공지사항-----------------------------------------------------------------------
		List<ADMIN_Board_PostDTO> board_P_List;
		List<ADMIN_User_InfoDTO> bp_uDTOarr = new ArrayList<ADMIN_User_InfoDTO>();
		
		board_P_List = boardService.getBoard_P_List_S(1);
		
		//댓글갯수, 유저 세팅
		for(int i=0; i<board_P_List.size(); i++) {
			board_P_List.get(i).setReple_count(boardService.board_R_Count(board_P_List.get(i).getBoard_p_seq()));
			bp_uDTOarr.add(userService.getUser(board_P_List.get(i).getUser_seq()));
		}
		model.addAttribute("bp_uDTOarr", bp_uDTOarr);
		model.addAttribute("board_P_List", board_P_List);
		
		
		//[매출정보]-------------------------------------------------------------------------------------------------
		List<ADMIN_Order_InfoDTO> ordDTOarr = orderService.getOrder_List();
		
		//매출정보 세팅
		String date = getDate2();
		String today[] = date.trim().split("\\."); //현재시간
		int date_3[] = {0, 0, 0, 0, 0, 0}; //3일전
		int date_2[] = {0, 0, 0, 0, 0, 0}; //2일전
		int date_1[] = {0, 0, 0, 0, 0, 0}; //1일전
		int date_today[] = {0, 0, 0, 0, 0, 0}; //오늘
		int date_week_avg[] = {0, 0, 0, 0, 0, 0}; //주 평균
		int date_week_sum[] = {0, 0, 0, 0, 0, 0}; //주 합계
		int date_month_avg[] = {0, 0, 0, 0, 0, 0}; //달 평균
		int date_month_sum[] = {0, 0, 0, 0, 0, 0}; //달 합계
		
		int year_month_avg[] = {0,0,0,0,0,0,0,0,0,0,0,0}; //연-월 평균
		int year_month_sum[] = {0,0,0,0,0,0,0,0,0,0,0,0}; //연-월 합계
		int year_month_cnt[] = {0,0,0,0,0,0,0,0,0,0,0,0}; //연-월 거래 카운트
		
		int year_month_user_join[] = {0,0,0,0,0,0,0,0,0,0,0,0}; //연-월 접속자 카운트
		
		for(ADMIN_Order_InfoDTO ordDTO : ordDTOarr){
			String ord_date_full[] = ordDTO.getOrd_date().trim().split("/");
			String ord_date[] = ord_date_full[0].trim().split("\\.");
			if(Integer.parseInt(ord_date[0].trim()) == Integer.parseInt(today[0].trim()) && Integer.parseInt(ord_date[1].trim())==Integer.parseInt(today[1].trim())){
				if(Integer.parseInt(ord_date[2].trim())==Integer.parseInt(today[2].trim())-3){//3일전
					if(ordDTO.getOrd_status()==0) {
						date_3[0] += ordDTO.getOrd_sumprice();
						date_3[3] += 1;
					}else if(ordDTO.getOrd_status()==1){
						date_3[1] += ordDTO.getOrd_sumprice();
						date_3[4] += 1;
					}else if(ordDTO.getOrd_status()==9){
						date_3[2] += ordDTO.getOrd_sumprice();
						date_3[5] += 1;
					}
				}
				if(Integer.parseInt(ord_date[2].trim())==Integer.parseInt(today[2].trim())-2){//2일전
					if(ordDTO.getOrd_status()==0) {
						date_2[0] += ordDTO.getOrd_sumprice();
						date_2[3] += 1;
					}else if(ordDTO.getOrd_status()==1){
						date_2[1] += ordDTO.getOrd_sumprice();
						date_2[4] += 1;
					}else if(ordDTO.getOrd_status()==9){
						date_2[2] += ordDTO.getOrd_sumprice();
						date_2[5] += 1;
					}
				}
				if(Integer.parseInt(ord_date[2].trim())==Integer.parseInt(today[2].trim())-1){//1일전
					if(ordDTO.getOrd_status()==0) {
						date_1[0] += ordDTO.getOrd_sumprice();
						date_1[3] += 1;
					}else if(ordDTO.getOrd_status()==1){
						date_1[1] += ordDTO.getOrd_sumprice();
						date_1[4] += 1;
					}else if(ordDTO.getOrd_status()==9){
						date_1[2] += ordDTO.getOrd_sumprice();
						date_1[5] += 1;
					}
				}
				if(Integer.parseInt(ord_date[2].trim())==Integer.parseInt(today[2].trim())){//오늘
					if(ordDTO.getOrd_status()==0) {
						date_today[0] += ordDTO.getOrd_sumprice();
						date_today[3] += 1;
					}else if(ordDTO.getOrd_status()==1){
						date_today[1] += ordDTO.getOrd_sumprice();
						date_today[4] += 1;
					}else if(ordDTO.getOrd_status()==9){
						date_today[2] += ordDTO.getOrd_sumprice();
						date_today[5] += 1;
					}
				}
				if(Integer.parseInt(ord_date[2].trim())>=Integer.parseInt(today[2].trim())-7) {//1주 통계
					if(ordDTO.getOrd_status()==0) {
						date_week_sum[0] += ordDTO.getOrd_sumprice();
						date_week_sum[3] += 1;
						date_week_avg[3] += 1;
					}else if(ordDTO.getOrd_status()==1){
						date_week_sum[1] += ordDTO.getOrd_sumprice();
						date_week_sum[4] += 1;
						date_week_avg[4] += 1;
					}else if(ordDTO.getOrd_status()==9){
						date_week_sum[2] += ordDTO.getOrd_sumprice();
						date_week_sum[5] += 1;
						date_week_avg[5] += 1;
					}
				}
				if(Integer.parseInt(ord_date[1].trim())==Integer.parseInt(today[1].trim())){//1달 통계
					if(ordDTO.getOrd_status()==0) { 
						date_month_sum[0] += ordDTO.getOrd_sumprice();
						date_month_sum[3] += 1;
						date_month_avg[3] += 1;
					}else if(ordDTO.getOrd_status()==1){
						date_month_sum[1] += ordDTO.getOrd_sumprice();
						date_month_sum[4] += 1;
						date_month_avg[4] += 1;
					}else if(ordDTO.getOrd_status()==9){
						date_month_sum[2] += ordDTO.getOrd_sumprice();
						date_month_sum[5] += 1;
						date_month_avg[5] += 1;
					}
				}
			}
			if(Integer.parseInt(ord_date[0].trim())==Integer.parseInt(today[0].trim())){
				if(ordDTO.getOrd_status()==1){
					year_month_sum[Integer.parseInt(ord_date[1].trim())-1] += ordDTO.getOrd_sumprice();
					year_month_cnt[Integer.parseInt(ord_date[1].trim())-1] += 1;
				}
			}
		}
		date_week_avg[0] = date_week_sum[0]/7;
		date_week_avg[1] = date_week_sum[1]/7;
		date_week_avg[2] = date_week_sum[2]/7;
		
		date_month_avg[0] = date_month_sum[0]/30;
		date_month_avg[1] = date_month_sum[1]/30;
		date_month_avg[2] = date_month_sum[2]/30;
		
		for(int x=0; x<12; x++) {
			year_month_avg[x] = year_month_sum[x]/30;
			year_month_user_join[x] = mainService.getSite_Stat_Month(x+1);
		}
		model.addAttribute("date_3", date_3);
		model.addAttribute("date_2", date_2);
		model.addAttribute("date_1", date_1);
		model.addAttribute("date_today", date_today);
		model.addAttribute("date_week_avg", date_week_avg);
		model.addAttribute("date_week_sum", date_week_sum);
		model.addAttribute("date_month_avg", date_month_avg);
		model.addAttribute("date_month_sum", date_month_sum);
		model.addAttribute("year_month_avg", year_month_avg);
		model.addAttribute("year_month_sum", year_month_sum);
		model.addAttribute("year_month_cnt", year_month_cnt);
		
		model.addAttribute("year_month_user_join", year_month_user_join);
		
		//실시간 검색 로직---------------------------------------------------------------
		List<ADMIN_Search_TrendDTO> stDTOarr = mainService.getSearch_Trend_List();
		HashMap<String, Integer> sc = new HashMap<String, Integer>();
		
		for(int i=0; i<stDTOarr.size(); i++) {
			String Search_date_full[] = stDTOarr.get(i).getSearch_date().trim().split("/");
			String Search_date[] = Search_date_full[0].trim().split("\\.");
			if(Integer.parseInt(today[2].trim()) == Integer.parseInt(Search_date[2].trim())){
				if(sc.get(stDTOarr.get(i).getSearch_word())!=null) {
					sc.replace(stDTOarr.get(i).getSearch_word(), sc.get(stDTOarr.get(i).getSearch_word())+1);
				}else {
					sc.put(stDTOarr.get(i).getSearch_word(), 1);
				}
			}
		}
		 Iterator it = sortByValue(sc).iterator();
		 
		model.addAttribute("it", it);
		model.addAttribute("sc", sc);
		
		//접속량--------------------------------------------------------------------------------------------------------
			// [이번달 가입량]
			log.info(today[0]+"."+today[1].trim()+"."+"01");
			log.info("pcw");
			int thisMonth_UserSubmit_Count = mainService.getUser_Submit_Full(today[0]+"."+today[1].trim()+"."+"01");
			model.addAttribute("thisMonth_UserSubmit_Count", thisMonth_UserSubmit_Count);
			// [이번달 접속자 수]
			int thisMonth_UserJoin_Count = mainService.getSite_Stat_Full(today[0]+"."+today[1].trim()+"."+"01");
			model.addAttribute("thisMonth_UserJoin_Count", thisMonth_UserJoin_Count);
			
		
		//푸드트럭 지도 셋팅---------------------------------------------------------------------------------------------
		String []locPosition = {"37.54961852825523", "126.8426243815202"}; //GET방식으로 받은 locPosition을 분리하여 어레이 변수에 할당
		
		List<CONSUMER_Ft_InfoDTO> ftList = ftService.getFtList_ALL(); //리스트형식의 푸드트럭객체들을 지역코드를 파라미터를 사용해 테이블로부터 불러옴
		
		model.addAttribute("locPositionLat", locPosition[0]); //전송
		model.addAttribute("locPositionLon", locPosition[1]); //전송
		model.addAttribute("ftList", ftList); //fList라는 변수로 리턴으로 가져갈 리스트 변수 전송 
		
		////////////////////트럭 사진 리스트 불러오기////////////////// 											
		List<CONSUMER_ImageDTO> imgDTOs = new ArrayList<CONSUMER_ImageDTO>();
		
		if(ftList.isEmpty() == false) {
			for(int i = 0; i < ftList.size(); i++) {
				CONSUMER_ImageDTO imgDTO = new CONSUMER_ImageDTO();
				imgDTO.setFtSeq(CmmUtil.nvl(Integer.toString(ftList.get(i).getFt_seq())));
				imgDTO.setUserSeq(CmmUtil.nvl(Integer.toString(ftList.get(i).getUser_seq())));
				imgDTO.setFileId(CmmUtil.nvl((ftList.get(i).getFile_id())));
				imgDTOs.add(imgDTO);
				log.info("file ftSeqs : " + imgDTO.getFtSeq());
				log.info("file userSeqs : " + imgDTO.getUserSeq());
			}
															
			imgDTOs = ftService.getTruckImage(imgDTOs);
			
			if (imgDTOs == null) {			
				imgDTOs = new ArrayList<CONSUMER_ImageDTO>();
			}		
			//받아온 이미지 DTO 들 확인
			for(int i = 0; i < imgDTOs.size(); i++) {
				log.info("imgDTOs. get : " + imgDTOs.get(i).getFileId());											
				log.info("imgDTOs. get : " + imgDTOs.get(i).getFileOrgname());
				log.info("imgDTOs.get : " + imgDTOs.get(i).getFilePath());				
				log.info("imgDTOs. get : " + imgDTOs.get(i).getFileSevname());
				log.info("imgDTOs.get : " + imgDTOs.get(i).getUserSeq());
			}
			
			model.addAttribute("imgDTOs",imgDTOs);
		}
		
		return "/admin/admin_main";
	}
	
}
