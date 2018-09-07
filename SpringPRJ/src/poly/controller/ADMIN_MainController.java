package poly.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import poly.dto.admin.ADMIN_BoardDTO;
import poly.dto.admin.ADMIN_Board_PostDTO;
import poly.dto.admin.ADMIN_Order_InfoDTO;
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
import poly.util.CmmUtil;
import poly.util.SortTruck;

@Controller
public class ADMIN_MainController {
	public Logger log = Logger.getLogger(this.getClass());
	
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
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy. MM. dd / hh:mm:ss");
		String date = sdf1.format(cal.getTime());
		
		return date;
	}
	
	public String getDate2() {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy.MM.dd");
		String date = sdf1.format(cal.getTime());
		
		return date;
	}
	
/*----------------------------------------------------------------------------------------*/
	
	@RequestMapping(value="admin/admin_main")
	public String main(HttpServletRequest request, Model model) throws Exception{
		//공지사항
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
		//월 매출정보 세팅
		int month_sum[] = {0,0,0,0,0,0,0,0,0,0,0,0};
		
		//매출정보 세팅
		String date = getDate2();
		String today[] = date.trim().split("\\."); //현재시간
		int date_3[] = {0, 0, 0, 0, 0, 0};
		int date_2[] = {0, 0, 0, 0, 0, 0};
		int date_1[] = {0, 0, 0, 0, 0, 0};
		int date_today[] = {0, 0, 0, 0, 0, 0};
		int date_week_avg[] = {0, 0, 0, 0, 0, 0};
		int date_week_sum[] = {0, 0, 0, 0, 0, 0};
		int date_month_avg[] = {0, 0, 0, 0, 0, 0};
		int date_month_sum[] = {0, 0, 0, 0, 0, 0};
		for(ADMIN_Order_InfoDTO ordDTO : ordDTOarr){
			String ord_date_full[] = ordDTO.getOrd_date().trim().split("/");
			String ord_date[] = ord_date_full[0].trim().split("\\.");
			if(ord_date[0].equals(today[0]) && ord_date[1].equals(today[1])) {
				if(Integer.parseInt(ord_date[2])==Integer.parseInt(today[2])-3){//3일전
					if(ordDTO.getOrd_status()==1) {
						date_3[0] += ordDTO.getOrd_sumprice();
						date_3[3] += 1;
					}else if(ordDTO.getOrd_status()==2){
						date_3[1] += ordDTO.getOrd_sumprice();
						date_3[4] += 1;
					}else if(ordDTO.getOrd_status()==9){
						date_3[2] += ordDTO.getOrd_sumprice();
						date_3[5] += 1;
					}
				}
				if(Integer.parseInt(ord_date[2])==Integer.parseInt(today[2])-2){//2일전
					if(ordDTO.getOrd_status()==1) {
						date_2[0] += ordDTO.getOrd_sumprice();
						date_2[3] += 1;
					}else if(ordDTO.getOrd_status()==2){
						date_2[1] += ordDTO.getOrd_sumprice();
						date_2[4] += 1;
					}else if(ordDTO.getOrd_status()==9){
						date_2[2] += ordDTO.getOrd_sumprice();
						date_2[5] += 1;
					}
				}
				if(Integer.parseInt(ord_date[2])==Integer.parseInt(today[2])-1){//1일전
					if(ordDTO.getOrd_status()==1) {
						date_1[0] += ordDTO.getOrd_sumprice();
						date_1[3] += 1;
					}else if(ordDTO.getOrd_status()==2){
						date_1[1] += ordDTO.getOrd_sumprice();
						date_1[4] += 1;
					}else if(ordDTO.getOrd_status()==9){
						date_1[2] += ordDTO.getOrd_sumprice();
						date_1[5] += 1;
					}
				}
				if(Integer.parseInt(ord_date[2])==Integer.parseInt(today[2])){//오늘
					if(ordDTO.getOrd_status()==1) {
						date_today[0] += ordDTO.getOrd_sumprice();
						date_today[3] += 1;
					}else if(ordDTO.getOrd_status()==2){
						date_today[1] += ordDTO.getOrd_sumprice();
						date_today[4] += 1;
					}else if(ordDTO.getOrd_status()==9){
						date_today[2] += ordDTO.getOrd_sumprice();
						date_today[5] += 1;
					}
				}
				if(Integer.parseInt(ord_date[2])>=Integer.parseInt(today[2])-7) {//1주 통계
					if(ordDTO.getOrd_status()==1) {
						date_week_sum[0] += ordDTO.getOrd_sumprice();
						date_week_sum[3] += 1;
						date_week_avg[3] += 1;
					}else if(ordDTO.getOrd_status()==2){
						date_week_sum[1] += ordDTO.getOrd_sumprice();
						date_week_sum[4] += 1;
						date_week_avg[4] += 1;
					}else if(ordDTO.getOrd_status()==9){
						date_week_sum[2] += ordDTO.getOrd_sumprice();
						date_week_sum[5] += 1;
						date_week_avg[5] += 1;
					}
				}
				if(Integer.parseInt(ord_date[1])==Integer.parseInt(today[1])){//1달 통계
					if(ordDTO.getOrd_status()==1) {
						date_month_sum[0] += ordDTO.getOrd_sumprice();
						date_month_sum[3] += 1;
						date_month_avg[3] += 1;
					}else if(ordDTO.getOrd_status()==2){
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
		}
		date_week_avg[0] = date_week_sum[0]/7;
		date_week_avg[1] = date_week_sum[1]/7;
		date_week_avg[2] = date_week_sum[2]/7;
		
		date_month_avg[0] = date_month_sum[0]/30;
		date_month_avg[1] = date_month_sum[1]/30;
		date_month_avg[2] = date_month_sum[2]/30;
		
		model.addAttribute("date_3", date_3);
		model.addAttribute("date_2", date_2);
		model.addAttribute("date_1", date_1);
		model.addAttribute("date_today", date_today);
		model.addAttribute("date_week_avg", date_week_avg);
		model.addAttribute("date_week_sum", date_week_sum);
		model.addAttribute("date_month_avg", date_month_avg);
		model.addAttribute("date_month_sum", date_month_sum);
		
		//푸드트럭 지도 셋팅
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
