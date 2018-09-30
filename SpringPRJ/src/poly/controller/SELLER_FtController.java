package poly.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.httpclient.HttpsURL;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import poly.dto.admin.ADMIN_Ft_InfoDTO;
import poly.dto.admin.ADMIN_Ft_Menu_CateDTO;
import poly.dto.admin.ADMIN_Ft_ReviewDTO;
import poly.dto.admin.ADMIN_ImageDTO;
import poly.dto.admin.ADMIN_Menu_InfoDTO;
import poly.dto.admin.ADMIN_User_InfoDTO;
import poly.service.ADMIN_IFtService;
import poly.service.ADMIN_IImageService;
import poly.service.ADMIN_IUserService;
import poly.service.impl.ADMIN_ImageService;
import poly.util.ADMIN_UtilFile;
import poly.util.CmmUtil;
import poly.util.UtilTime;


@Controller
public class SELLER_FtController {
	public Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="ADMIN_FtService")
	private ADMIN_IFtService ftService;
	
	@Resource(name="ADMIN_ImageService")
	private ADMIN_IImageService imgService;
	
	@Resource(name="ADMIN_UserService")
	private ADMIN_IUserService userService;
	
/*----------------------------------------------------------------------------------------*/
	

	

/*푸드트럭 관리----------------------------------------------------------------------------------------*/	
	
	//푸드트럭 리스트
	@RequestMapping(value="seller/ft/ft_list")
	public String ft_list(HttpServletRequest request, Model model) throws Exception{
		List<ADMIN_Ft_InfoDTO> ftList = ftService.getFT_InfoList();
		
		//목록 쪼개기
		model.addAttribute("pageNum", request.getParameter("pageNum"));
		model.addAttribute("pageSize", request.getParameter("pageSize"));

		model.addAttribute("ftList", ftList);
		
		return "/admin/ft/ft_list";
	}
	
	//푸드트럭 검색 리스트
	@RequestMapping(value="seller/ft/ft_search_list", method=RequestMethod.GET)
	public String ft_search_list(HttpServletRequest request, Model model) throws Exception{
		ADMIN_Ft_InfoDTO fDTO = new ADMIN_Ft_InfoDTO();
		fDTO.setOption(request.getParameter("option"));
		fDTO.setValue(request.getParameter("value"));
		
		List<ADMIN_Ft_InfoDTO> ft_SearchList = ftService.getFT_Search(fDTO);
		
		model.addAttribute("option", request.getParameter("option"));
		model.addAttribute("value", request.getParameter("value"));
		
		//목록 쪼개기
		model.addAttribute("pageNum", request.getParameter("pageNum"));
		model.addAttribute("pageSize", request.getParameter("pageSize"));

		model.addAttribute("ft_SearchList", ft_SearchList);
		
		return "/seller/ft/ft_search_list";
	}
	
	//푸드트럭 활동정지
	@RequestMapping(value="seller/ft/ft_active", method=RequestMethod.GET)
	public String ft_active(HttpServletRequest request, Model model) throws Exception{
		ADMIN_Ft_InfoDTO fDTO = new ADMIN_Ft_InfoDTO();
		String ArrFt_Seq = request.getParameter("ArrFt_Seq");
		String[] array = ArrFt_Seq.split(",");
		for(int i=0; i<array.length; i++) {
			fDTO.setFt_chan(UtilTime.getDateYMDhms());
			fDTO.setFt_seq(Integer.parseInt(array[i]));
			fDTO.setFt_status(1);
			ftService.ft_Active(fDTO);
		}
		return ft_list(request, model);
	}
	
	//푸드트럭 강제탈퇴
	@RequestMapping(value="seller/ft/ft_drop", method=RequestMethod.GET)
	public String ft_drop(HttpServletRequest request, Model model) throws Exception{
		ADMIN_Ft_InfoDTO fDTO = new ADMIN_Ft_InfoDTO();
		String ArrFt_Seq = request.getParameter("ArrFt_Seq");
		String[] array = ArrFt_Seq.split(",");
		for(int i=0; i<array.length; i++) {
			fDTO.setFt_chan(UtilTime.getDateYMDhms());
			fDTO.setFt_seq(Integer.parseInt(array[i]));
			fDTO.setFt_status(-1);
			ftService.ft_Drop(fDTO);
		}
		return ft_list(request, model);
	}
	
	//푸드트럭 상세정보[리뷰, 카테고리, 메뉴, 정보변경]--------------------------------------------------------------------------------------
		@RequestMapping(value="seller/ft/ft_info", method=RequestMethod.GET)
		public String ft_info(HttpServletRequest request, Model model, HttpSession session) throws Exception{
			log.info("seller/ft_info================================================");
			//페이지 커맨드 cmd
			String cmd = request.getParameter("cmd");
			if(cmd==null) {
				cmd="";
			}
			String ftSeq = CmmUtil.nvl((String)session.getAttribute("ftSeq"));
			
			if("".equals(ftSeq)) {
				String msg="로그인을 해주시기 바랍니다.";
				String url="/cmmn/main.do";
				 
				 return "/cmmn/alert";
			}
			
			int ft_seq = Integer.parseInt(ftSeq);
			
			ADMIN_Ft_InfoDTO fDTO = new ADMIN_Ft_InfoDTO();
			//좌측 푸드트럭 기본정보
			fDTO = ftService.getFT_Info(ft_seq);
			ADMIN_ImageDTO LimgDTO = new ADMIN_ImageDTO();
			if(fDTO.getFile_id()!="-1") {
				LimgDTO = imgService.getImageInfo(fDTO.getFile_id());
				model.addAttribute("LimgDTO", LimgDTO);
			}
			
			//페이지 커맨드 전송
			model.addAttribute("cmd", cmd);
			model.addAttribute("ftDTO", fDTO);
			model.addAttribute("ft_seq", ft_seq);
			
			//분류
			if(cmd.equals("ft_info_edit")) {
				ADMIN_ImageDTO imgDTO = new ADMIN_ImageDTO();
				if(fDTO.getFile_id()!="-1") {
					if(fDTO.getFile_id().equals("-1")) {
						imgDTO.setFile_orgname("파일없음");
					}else {
						imgDTO = imgService.getImageInfo(fDTO.getFile_id());
					}
					model.addAttribute("imgDTO", imgDTO);
				}
			}else if(cmd.equals("review_list")) { //리뷰 리스트
				List<ADMIN_Ft_ReviewDTO> ALL_review_List;
				ALL_review_List = ftService.getFT_Review_List(ft_seq);
				List<ADMIN_Ft_ReviewDTO> review_List = new ArrayList<ADMIN_Ft_ReviewDTO>();
				List<ADMIN_User_InfoDTO> uDTOarr = new ArrayList<ADMIN_User_InfoDTO>();
				
				
				//리뷰&답글 분류
				int reple_cnt = 0;
				for(ADMIN_Ft_ReviewDTO irevDTO : ALL_review_List) {
					if(String.valueOf(irevDTO.getReview_seq()).equals(irevDTO.getRev_level())) {
						//답글 개수셋팅
						String search_level = String.valueOf(irevDTO.getReview_seq()-1)+"-";
						reple_cnt = ftService.getReview_Reple_Cnt(search_level);
						irevDTO.setReple_cnt(reple_cnt);
						
						//작성자 셋팅
						uDTOarr.add(userService.getUser(irevDTO.getUser_seq()));
						
						review_List.add(irevDTO);
					}
				}
				
				model.addAttribute("uDTOarr", uDTOarr);
				model.addAttribute("review_List", review_List);
				
				//게시판 갯수 쪼개기
				model.addAttribute("pageNum", request.getParameter("pageNum"));
				model.addAttribute("pageSize", request.getParameter("pageSize"));
				
			}else if(cmd.equals("review_info")){ //리뷰 보기
				List<ADMIN_Ft_ReviewDTO> ALL_review_List;
				ADMIN_Ft_ReviewDTO revDTO = new ADMIN_Ft_ReviewDTO();
				revDTO = ftService.getFT_Review_Info(Integer.parseInt(request.getParameter("review_seq")));
				ALL_review_List = ftService.getFT_Review_List(ft_seq);
				List<ADMIN_Ft_ReviewDTO> repleList = new ArrayList<ADMIN_Ft_ReviewDTO>();
				String user_nick = CmmUtil.nvl((String)(request.getParameter("user_nick")));
				
				List<ADMIN_User_InfoDTO> revp_uDTOarr = new ArrayList<ADMIN_User_InfoDTO>();
				for(ADMIN_Ft_ReviewDTO revpDTO : ALL_review_List) {
					String[] array = revpDTO.getRev_level().split("-");
					if(!String.valueOf(revpDTO.getReview_seq()).equals(revpDTO.getRev_level())&&(Integer.parseInt(request.getParameter("review_seq"))-1)==Integer.parseInt(array[0])) {
						//리뷰답글 작성자 리스트
						revp_uDTOarr.add(userService.getUser(revpDTO.getUser_seq()));
						
						//리뷰답글 리스트
						repleList.add(revpDTO);
					}
				}
				ADMIN_ImageDTO imgDTO = new ADMIN_ImageDTO();
				if(revDTO.getFile_id()!="-1") {
					imgDTO = imgService.getImageInfo(revDTO.getFile_id());
					model.addAttribute("imgDTO", imgDTO);
				}
				
				model.addAttribute("revDTO", revDTO);
				model.addAttribute("repleList", repleList);
				model.addAttribute("user_nick", user_nick);
				model.addAttribute("revp_uDTOarr", revp_uDTOarr);
				
			}else if(cmd.equals("review_edit")){ //리뷰 수정
				ADMIN_Ft_ReviewDTO revDTO = new ADMIN_Ft_ReviewDTO();
				ADMIN_ImageDTO imgDTO = new ADMIN_ImageDTO();
				revDTO = ftService.getFT_Review_Info(Integer.parseInt(request.getParameter("review_seq")));
				if(revDTO.getFile_id().equals("-1")) {
					imgDTO.setFile_orgname("파일없음");
				}else {
					imgDTO = imgService.getImageInfo(revDTO.getFile_id());
				}
				model.addAttribute("imgDTO", imgDTO);
				model.addAttribute("revDTO", revDTO);
			}else if(cmd.equals("category_list")){ //카테고리 리스트
				List<ADMIN_Ft_Menu_CateDTO> cateDTOarr = ftService.getFT_Cate_List(ft_seq);
				model.addAttribute("cateDTOarr", cateDTOarr);
				
				//게시판 갯수 쪼개기
				model.addAttribute("pageNum", request.getParameter("pageNum"));
				model.addAttribute("pageSize", request.getParameter("pageSize"));
			}else if(cmd.equals("category_edit")) { //카테고리 수정
				ADMIN_Ft_Menu_CateDTO cateDTO = new ADMIN_Ft_Menu_CateDTO();
				cateDTO.setCate_sort_no(Integer.parseInt(request.getParameter("cate_sort_no")));
				cateDTO.setFt_seq(Integer.parseInt(request.getParameter("ft_seq")));
				cateDTO = ftService.getFt_Cate_Info(cateDTO);
				model.addAttribute("cateDTO", cateDTO);
			}else if(cmd.equals("menu_create")) { //메뉴 만들기
				List<ADMIN_Ft_Menu_CateDTO> cateDTOarr = ftService.getFT_Cate_List(ft_seq);
				model.addAttribute("cate_sort_no", request.getParameter("cate_sort_no"));
				model.addAttribute("cateDTOarr", cateDTOarr);
			}else if(cmd.equals("menu_info")) { //메뉴 보기
				ADMIN_Menu_InfoDTO menuDTO = new ADMIN_Menu_InfoDTO();
				menuDTO = ftService.getFt_Menu_Info(Integer.parseInt(request.getParameter("menu_seq")));
				List<ADMIN_Ft_Menu_CateDTO> cateDTOarr = ftService.getFT_Cate_List(ft_seq);
				if(menuDTO.getFile_id()!="-1") {
					ADMIN_ImageDTO imgDTO = imgService.getImageInfo(menuDTO.getFile_id());
					model.addAttribute("imgDTO", imgDTO);
				}
				model.addAttribute("menuDTO", menuDTO);
				model.addAttribute("cateDTOarr", cateDTOarr);
			}else if(cmd.equals("menu_edit")) { //메뉴 수정
				ADMIN_Menu_InfoDTO menuDTO = new ADMIN_Menu_InfoDTO();
				ADMIN_ImageDTO imgDTO = new ADMIN_ImageDTO();
				menuDTO = ftService.getFt_Menu_Info(Integer.parseInt(request.getParameter("menu_seq")));
				List<ADMIN_Ft_Menu_CateDTO> cateDTOarr = ftService.getFT_Cate_List(ft_seq);
				model.addAttribute("menuDTO", menuDTO);
				model.addAttribute("cateDTOarr", cateDTOarr);
				if(menuDTO.getFile_id().equals("-1")) {
					imgDTO.setFile_orgname("파일없음");
				}else {
					imgDTO = imgService.getImageInfo(menuDTO.getFile_id());
				}
				model.addAttribute("imgDTO", imgDTO);
			}else{//메뉴&카테고리 리스트
				List<ADMIN_Ft_Menu_CateDTO> cateDTOarr = ftService.getFT_Cate_List(ft_seq);
				List<ADMIN_Menu_InfoDTO> menuDTOarr = ftService.getFt_Menu_List(ft_seq);
				List<String> ImgDTOs = new ArrayList<String>();
				if(menuDTOarr.size()!=0) {
					int i=0;
					for(ADMIN_Menu_InfoDTO menuDTO : menuDTOarr) {
						ImgDTOs.add(menuDTO.getFile_id());
						i++;
					}
					List<ADMIN_ImageDTO> imgDTOarr = imgService.getMenuImage(ImgDTOs);
					model.addAttribute("imgDTOarr", imgDTOarr);
				}
				model.addAttribute("cateDTOarr", cateDTOarr);
				model.addAttribute("menuDTOarr", menuDTOarr);
			}
			log.info("seller/ft_info end=========================================");
			return "/seller/ft/ft_info";
		}
/*푸드트럭 정보수정----------------------------------------------------------------------------------------------------*/
		@RequestMapping(value="seller/ft/ft_info_edit", method=RequestMethod.POST)
		public String ft_info_edit(@RequestParam("uploadFile") MultipartFile uploadFile, HttpSession session, MultipartHttpServletRequest request, Model model) throws Exception{
			int ft_seq = Integer.parseInt(request.getParameter("ft_seq"));
			String sel_name = request.getParameter("sel_name");
			String sel_no = request.getParameter("sel_no");
			String ft_name = request.getParameter("ft_name");
			String ft_intro = request.getParameter("ft_intro");
			//String ft_loc = request.getParameter("ft_loc");
			String ft_optime = request.getParameter("ft_bday")+"/"+request.getParameter("ft_open_time")+"/"+request.getParameter("ft_close_time");
			String ft_func=""; 
			if(request.getParameter("delivery")!=null) {
				ft_func += request.getParameter("delivery")+"/";
			}
			if(request.getParameter("order")!=null) {
				ft_func += request.getParameter("order")+"/";
			}
			if(request.getParameter("catering")!=null) {
				ft_func += request.getParameter("catering")+"/";
			}
			String ft_chan = UtilTime.getDateYMDhms();
			int ft_status = Integer.parseInt(request.getParameter("ft_status"));
			
			ADMIN_Ft_InfoDTO ftDTO = new ADMIN_Ft_InfoDTO();
			ftDTO.setFt_seq(ft_seq);
			
			ADMIN_ImageDTO imgDTO = new ADMIN_ImageDTO();
			//이미지 변경 체크
			if(!uploadFile.isEmpty()) { //업로드된 파일 확인
	//	      UtilFile 객체 생성
		        ADMIN_UtilFile utilFile = new ADMIN_UtilFile();
		        
	//	      파일 업로드 결과값을 path로 받아온다(이미 fileUpload() 메소드에서 해당 경로에 업로드는 끝났음)
		        String uploadPath = utilFile.fileUpload(request, uploadFile, imgDTO);
		        imgDTO.setUser_seq(0);
		        imgDTO.setFile_path(uploadPath);
	//	      해당 경로만 받아 db에 저장
		        imgService.Image_Add(imgDTO);
		        String file_id = imgService.getFile_Seq();
		        //System.out.println("RewardController reAddProCtrl n : " + n);
		        System.out.println("RewardController reAddProCtrl uploadPath : " + uploadPath);
				
		        ftDTO.setFile_id(String.valueOf(Integer.parseInt(file_id)));
			}else { //업로드된 파일 없을때
				if(request.getParameter("org_file_id")!="-1"){//변경이 없을경우
					System.out.println(request.getParameter("org_file_id"));
					ftDTO.setFile_id(request.getParameter("org_file_id"));
				}else {
					ftDTO.setFile_id("-1");
				}
			}
			
			ftDTO.setSel_name(sel_name);
			ftDTO.setSel_no(sel_no);
			ftDTO.setFt_name(ft_name);
			ftDTO.setFt_intro(ft_intro);
			//ftDTO.setFt_loc("0");
			ftDTO.setFt_optime(ft_optime);
			ftDTO.setFt_func(ft_func);
			ftDTO.setFt_chan(ft_chan);
			ftDTO.setFt_chan(ft_chan);
			ftDTO.setFt_status(ft_status);
			
			ftService.ft_Info_Edit(ftDTO);
			return ft_info(request, model, session);
		}	
		
/*리뷰관리----------------------------------------------------------------------------------------------------*/
		//리뷰 수정 완료
		@RequestMapping(value="seller/ft/ft_review_edit", method=RequestMethod.POST)
		public String ft_Review_Edit(@RequestParam("uploadFile") MultipartFile uploadFile, HttpSession session, MultipartHttpServletRequest request, Model model) throws Exception{
			ADMIN_Ft_ReviewDTO revDTO = new ADMIN_Ft_ReviewDTO();
			int review_seq = Integer.parseInt(request.getParameter("review_seq"));
			String rev_title = request.getParameter("rev_title");
			String rev_text = request.getParameter("rev_text");
			int rev_point = Integer.parseInt(request.getParameter("rev_point"));
			int exp_yn;
			if(request.getParameter("exp_yn").equals("on")){
				exp_yn = 1;
			}else {
				exp_yn = -1;
			}
			revDTO.setReview_seq(review_seq);
			ADMIN_ImageDTO imgDTO = new ADMIN_ImageDTO();
			//이미지 변경 체크
			if(!uploadFile.isEmpty()) { //업로드된 파일 확인
	//	      UtilFile 객체 생성
		        ADMIN_UtilFile utilFile = new ADMIN_UtilFile();
		        
	//	      파일 업로드 결과값을 path로 받아온다(이미 fileUpload() 메소드에서 해당 경로에 업로드는 끝났음)
		        String uploadPath = utilFile.fileUpload(request, uploadFile, imgDTO);
		        imgDTO.setUser_seq(0);
		        imgDTO.setFile_path(uploadPath);
	//	      해당 경로만 받아 db에 저장
		        imgService.Image_Add(imgDTO);
		        String file_id = imgService.getFile_Seq();
		        //System.out.println("RewardController reAddProCtrl n : " + n);
		        System.out.println("RewardController reAddProCtrl uploadPath : " + uploadPath);
				
		        revDTO.setFile_id(String.valueOf(Integer.parseInt(file_id)));
			}else { //업로드된 파일 없을때
				if(request.getParameter("org_file_id")!="-1"){//변경이 없을경우
					System.out.println(request.getParameter("org_file_id"));
					revDTO.setFile_id(request.getParameter("org_file_id"));
				}else {
					revDTO.setFile_id("-1");
				}
			}
			revDTO.setRev_point(rev_point);
			revDTO.setRev_title(rev_title);
			revDTO.setRev_text(rev_text);
			revDTO.setExp_yn(exp_yn);
			ftService.ft_Review_Edit(revDTO);
			return ft_info(request, model, session);
		}
		
		//리뷰 삭제
		@RequestMapping(value="seller/ft/ft_review_delete", method=RequestMethod.GET)
		public String ft_Review_Delete(HttpServletRequest request, Model model, HttpSession session) throws Exception{
			String ArrReview_Seq = request.getParameter("ArrReview_Seq");
			String review_seq = request.getParameter("review_seq");
			String revp_seq = request.getParameter("revp_seq");
			if(ArrReview_Seq!=null) {
				String[] array = ArrReview_Seq.split(",");
				for(int i=0; i<array.length; i++) {
					ftService.ft_Review_Delete(Integer.parseInt(array[i]));
				}
			}
			if(review_seq!=null && !request.getParameter("cmd").equals("review_info")) {
				ftService.ft_Review_Delete(Integer.parseInt(review_seq));
			}
			if(revp_seq!=null  && request.getParameter("cmd").equals("review_info")){
				ftService.ft_Review_Delete(Integer.parseInt(revp_seq));
			}
			
			return ft_info(request, model, session);
		}
		
		//리뷰 노출변경
		@RequestMapping(value="seller/ft/ft_review_exp_yn", method=RequestMethod.GET)
		public String ft_Review_Exp_Yn(HttpServletRequest request, Model model, HttpSession session) throws Exception{
			String ArrReview_Seq = request.getParameter("ArrReview_Seq");
			String[] array = ArrReview_Seq.split(",");
			for(int i=0; i<array.length; i++) {
				ftService.ft_Review_Exp_Yn(Integer.parseInt(array[i]));
			}
			
			return ft_info(request, model, session);
		}
		
		//리뷰 쓰기
		@RequestMapping(value="seller/ft/ft_review_create", method=RequestMethod.POST)
		public String ft_Review_Create(@RequestParam("uploadFile") MultipartFile uploadFile, HttpSession session, MultipartHttpServletRequest request, Model model) throws Exception{
			ADMIN_Ft_ReviewDTO revDTO = new ADMIN_Ft_ReviewDTO();
			int ft_seq = Integer.parseInt(request.getParameter("ft_seq"));
			revDTO.setFt_seq(ft_seq);
			revDTO.setUser_seq(0);
			ADMIN_ImageDTO imgDTO = new ADMIN_ImageDTO();
			if(!uploadFile.isEmpty()) {
	//	      UtilFile 객체 생성
		        ADMIN_UtilFile utilFile = new ADMIN_UtilFile();
		        
	//	      파일 업로드 결과값을 path로 받아온다(이미 fileUpload() 메소드에서 해당 경로에 업로드는 끝났음)
		        String uploadPath = utilFile.fileUpload(request, uploadFile, imgDTO);
		        imgDTO.setUser_seq(0);
		        imgDTO.setFile_path(uploadPath);
	//	      해당 경로만 받아 db에 저장
		        imgService.Image_Add(imgDTO);
		        String file_id = imgService.getFile_Seq();
		        //System.out.println("RewardController reAddProCtrl n : " + n);
		        System.out.println("RewardController reAddProCtrl uploadPath : " + uploadPath);
				
		        revDTO.setFile_id(String.valueOf(Integer.parseInt(file_id)));
			}else {
				revDTO.setFile_id("-1");
			}
			revDTO.setRev_title(request.getParameter("rev_title"));
			revDTO.setRev_text(request.getParameter("rev_text"));
			revDTO.setRev_point(Integer.parseInt(request.getParameter("rev_point")));
			revDTO.setRev_regdate(UtilTime.getDateYMDhms());
			revDTO.setRev_level(" ");
			revDTO.setExp_yn(1);
			ftService.ft_Review_Create(revDTO);
			
			List<ADMIN_Ft_ReviewDTO> revDTOarr = ftService.getFT_Review_List(ft_seq);
			//테이블생성 시 해당 테이블의 시퀀스값을 board_level 컬럼에 저장
			ftService.ft_Set_Rev_level(revDTOarr.get(revDTOarr.size()-1).getReview_seq());
			
			return ft_info(request, model, session);
		}
		
		//리뷰답글 쓰기
		@RequestMapping(value="seller/ft/ft_review_reple_create", method=RequestMethod.POST)
		public String ft_Review_Reple_Create(HttpServletRequest request, Model model,HttpSession session) throws Exception{
			ADMIN_Ft_ReviewDTO revDTO = new ADMIN_Ft_ReviewDTO();
			int ft_seq = Integer.parseInt(request.getParameter("ft_seq"));
			
			String search_level = String.valueOf(Integer.parseInt(request.getParameter("review_seq"))-1)+"-";
			List<ADMIN_Ft_ReviewDTO> review_LevP_List = ftService.getReview_LevP_List(search_level);
			//테이블생성 시 해당 테이블의 시퀀스값을 board_level 컬럼에 저장
			for(ADMIN_Ft_ReviewDTO revpDTO : review_LevP_List) {
				ADMIN_Ft_ReviewDTO irevpDTO = new ADMIN_Ft_ReviewDTO();
				String split[] = revpDTO.getRev_level().split("-");
				irevpDTO.setReview_seq(revpDTO.getReview_seq());
				irevpDTO.setRev_level(split[0]+"-"+String.valueOf(Integer.parseInt(split[1])+1));
				ftService.ft_Set_Revp_level(irevpDTO);
			}
			
			revDTO.setFt_seq(ft_seq);
			revDTO.setUser_seq(0);
			revDTO.setFile_id("-1");
			revDTO.setRev_title(" ");
			revDTO.setRev_text(request.getParameter("rev_text"));
			revDTO.setRev_point(0);
			revDTO.setRev_regdate(UtilTime.getDateYMDhms());
			revDTO.setRev_level(search_level+"1");
			revDTO.setExp_yn(1);
			ftService.ft_Review_Create(revDTO);
			
			return ft_info(request, model, session);
		}
		
		//리뷰답글 수정
		@RequestMapping(value="seller/ft/ft_review_reple_edit", method=RequestMethod.POST)
		public String ft_Review_Reple_Edit(HttpServletRequest request, Model model, HttpSession session) throws Exception{
			ADMIN_Ft_ReviewDTO revDTO = new ADMIN_Ft_ReviewDTO();
			revDTO.setReview_seq(Integer.parseInt(request.getParameter("edit_review_seq")));
			revDTO.setRev_text(request.getParameter("rev_text"));
			ftService.ft_Review_Reple_Edit(revDTO);
			return ft_info(request, model, session);
		}
		
/*푸드트럭 메뉴 카테고리 관리----------------------------------------------------------------------------------------------------*/
		
		//카테고리 만들기
		@RequestMapping(value="seller/ft/ft_cate_create", method=RequestMethod.POST)
		public String ft_Cate_Create(HttpServletRequest request, Model model, HttpSession session) throws Exception{
			ADMIN_Ft_Menu_CateDTO cateDTO = new ADMIN_Ft_Menu_CateDTO();
			cateDTO.setFt_seq(Integer.parseInt(request.getParameter("ft_seq")));
			cateDTO.setCate_name(request.getParameter("cate_name"));
			cateDTO.setExp_yn(Integer.parseInt(request.getParameter("exp_yn")));
			List<ADMIN_Ft_Menu_CateDTO> cateDTOarr = ftService.getFT_Cate_List(Integer.parseInt(request.getParameter("ft_seq")));
			cateDTO.setCate_sort_no(cateDTOarr.size()+1);
			ftService.ft_Cate_Create(cateDTO);
			
			return ft_info(request, model, session);
		}
		
		//카테고리 삭제
		@RequestMapping(value="seller/ft/ft_cate_delete", method=RequestMethod.GET)
		public String ft_Cate_Delete(HttpServletRequest request, Model model, HttpSession session) throws Exception{
			String ArrCate_Seq = request.getParameter("ArrCate_Seq");
			String cate_sort_no = request.getParameter("cate_sort_no");
			ADMIN_Ft_Menu_CateDTO cateDTO = new ADMIN_Ft_Menu_CateDTO();
			cateDTO.setFt_seq(Integer.parseInt(request.getParameter("ft_seq")));
			if(ArrCate_Seq!=null) {
				String[] array = ArrCate_Seq.split(",");
				for(int i=0; i<array.length; i++) {
					cateDTO.setCate_sort_no(Integer.parseInt(array[i]));
					ftService.ft_Cate_Delete(cateDTO);
				}
			}
			if(cate_sort_no!=null) {
				cateDTO.setCate_sort_no(Integer.parseInt(cate_sort_no));
				ftService.ft_Cate_Delete(cateDTO);
			}
			
			return ft_info(request, model, session);
		}
		
		//카테고리 올리기
		@RequestMapping(value="seller/ft/ft_cate_up", method=RequestMethod.GET)
		public String ft_Cate_Up(HttpServletRequest request, Model model, HttpSession session) throws Exception{
			ADMIN_Ft_Menu_CateDTO cateDTO = new ADMIN_Ft_Menu_CateDTO();
			String ArrCate_Seq = request.getParameter("ArrCate_Seq");
			if(ArrCate_Seq!=null) {
				List<ADMIN_Ft_Menu_CateDTO> cateDTOarr = ftService.getFT_Cate_List(Integer.parseInt(request.getParameter("ft_seq")));
				String[] array = ArrCate_Seq.split(",");
				if(Integer.parseInt(array[0]) != 1 && cateDTOarr.size() != 1) {
					cateDTO.setFt_seq(Integer.parseInt(request.getParameter("ft_seq")));
					cateDTO.setCate_sort_no(Integer.parseInt(array[0]));
					cateDTO.setEdit_cate_sort_no(0);
					ftService.ft_Cate_Sort(cateDTO);
					cateDTO.setCate_sort_no(Integer.parseInt(array[0])-1);
					cateDTO.setEdit_cate_sort_no(Integer.parseInt(array[0]));
					ftService.ft_Cate_Sort(cateDTO);
					cateDTO.setCate_sort_no(0);
					cateDTO.setEdit_cate_sort_no(Integer.parseInt(array[0])-1);
					ftService.ft_Cate_Sort(cateDTO);
				}
			}
			
			return ft_info(request, model, session);
		}
		
		//카테고리 내리기
		@RequestMapping(value="seller/ft/ft_cate_down", method=RequestMethod.GET)
		public String ft_Cate_Down(HttpServletRequest request, Model model, HttpSession session) throws Exception{
			ADMIN_Ft_Menu_CateDTO cateDTO = new ADMIN_Ft_Menu_CateDTO();
			String ArrCate_Seq = request.getParameter("ArrCate_Seq");
			if(ArrCate_Seq!=null) {
				List<ADMIN_Ft_Menu_CateDTO> cateDTOarr = ftService.getFT_Cate_List(Integer.parseInt(request.getParameter("ft_seq")));
				String[] array = ArrCate_Seq.split(",");
				if(Integer.parseInt(array[0]) != cateDTOarr.size() && cateDTOarr.size() != 1) {
					cateDTO.setFt_seq(Integer.parseInt(request.getParameter("ft_seq")));
					cateDTO.setCate_sort_no(Integer.parseInt(array[0]));
					cateDTO.setEdit_cate_sort_no(0);
					ftService.ft_Cate_Sort(cateDTO);
					cateDTO.setCate_sort_no(Integer.parseInt(array[0])+1);
					cateDTO.setEdit_cate_sort_no(Integer.parseInt(array[0]));
					ftService.ft_Cate_Sort(cateDTO);
					cateDTO.setCate_sort_no(0);
					cateDTO.setEdit_cate_sort_no(Integer.parseInt(array[0])+1);
					ftService.ft_Cate_Sort(cateDTO);
				}
			}
			
			return ft_info(request, model, session);
		}
		
		//카테고리 수정
		@RequestMapping(value="seller/ft/ft_cate_edit", method=RequestMethod.POST)
		public String ft_cate_edit(HttpServletRequest request, Model model, HttpSession session) throws Exception{
			ADMIN_Ft_Menu_CateDTO cateDTO = new ADMIN_Ft_Menu_CateDTO();
			cateDTO.setFt_seq(Integer.parseInt(request.getParameter("ft_seq")));
			cateDTO.setCate_name(request.getParameter("cate_name"));
			cateDTO.setExp_yn(Integer.parseInt(request.getParameter("exp_yn")));
			cateDTO.setCate_sort_no(Integer.parseInt(request.getParameter("cate_sort_no")));
			ftService.ft_Cate_Edit(cateDTO);
			
			return ft_info(request, model, session);
		}
		
		//메뉴추가
		@RequestMapping(value="seller/ft/ft_menu_create", method=RequestMethod.POST)
		public String ft_Menu_Create(@RequestParam("uploadFile") MultipartFile uploadFile, HttpSession session, MultipartHttpServletRequest request, Model model) throws Exception{
			ADMIN_Menu_InfoDTO menuDTO = new ADMIN_Menu_InfoDTO();
			ADMIN_ImageDTO imgDTO = new ADMIN_ImageDTO();
			int ft_seq = Integer.parseInt(request.getParameter("ft_seq"));
			int cate_sort_no = Integer.parseInt(request.getParameter("cate_sort_no"));
			if(!uploadFile.isEmpty()) {
	//	      UtilFile 객체 생성
		        ADMIN_UtilFile utilFile = new ADMIN_UtilFile();
		        
	//	      파일 업로드 결과값을 path로 받아온다(이미 fileUpload() 메소드에서 해당 경로에 업로드는 끝났음)
		        String uploadPath = utilFile.fileUpload(request, uploadFile, imgDTO);
		        imgDTO.setUser_seq(0);
		        imgDTO.setFile_path(uploadPath);
	//	      해당 경로만 받아 db에 저장
		        imgService.Image_Add(imgDTO);
		        String file_id = imgService.getFile_Seq();
		        //System.out.println("RewardController reAddProCtrl n : " + n);
		        System.out.println("RewardController reAddProCtrl uploadPath : " + uploadPath);
				
		        menuDTO.setFile_id(String.valueOf(Integer.parseInt(file_id)));
			}else {
				menuDTO.setFile_id("-1");
			}
			menuDTO.setFt_seq(ft_seq);
			menuDTO.setCate_sort_no(cate_sort_no);
			
			List<ADMIN_Menu_InfoDTO> CateToMenuDTOarr = ftService.getFt_CateToMenu_List(menuDTO);
			int menu_sort_no = CateToMenuDTOarr.size()+1;
			
			String menu_name = request.getParameter("menu_name");
			int menu_price = Integer.parseInt(request.getParameter("menu_price"));
			String menu_intro = request.getParameter("menu_intro");
			int menu_rqtime = Integer.parseInt(request.getParameter("menu_rqtime"));
			String orign = request.getParameter("orign");
			int exp_yn = Integer.parseInt(request.getParameter("exp_yn"));
			
			menuDTO.setMenu_sort_no(menu_sort_no);
			menuDTO.setMenu_name(menu_name);
			menuDTO.setMenu_price(menu_price);
			menuDTO.setMenu_intro(menu_intro);
			menuDTO.setMenu_rqtime(menu_rqtime);
			menuDTO.setOrign(orign);
			menuDTO.setExp_yn(exp_yn);
			
			ftService.ft_Menu_Create(menuDTO);
			
			return "redirect:/seller/ft/ft_info.do";
		}
		
		//메뉴수정
		@RequestMapping(value="/seller/ft/ft_menu_edit", method=RequestMethod.POST)
		public String ft_Menu_Edit(@RequestParam("uploadFile") MultipartFile uploadFile, HttpSession session, MultipartHttpServletRequest request, Model model) throws Exception{
			ADMIN_Menu_InfoDTO menuDTO = new ADMIN_Menu_InfoDTO();
			ADMIN_ImageDTO imgDTO = new ADMIN_ImageDTO();
			int menu_seq = Integer.parseInt(request.getParameter("menu_seq"));
			int cate_sort_no = Integer.parseInt(request.getParameter("cate_sort_no"));
			menuDTO.setMenu_seq(menu_seq);
			menuDTO.setCate_sort_no(cate_sort_no);
			//이미지 변경 체크
			if(!uploadFile.isEmpty()) { //업로드된 파일 확인
	//	      UtilFile 객체 생성
		        ADMIN_UtilFile utilFile = new ADMIN_UtilFile();
		        
	//	      파일 업로드 결과값을 path로 받아온다(이미 fileUpload() 메소드에서 해당 경로에 업로드는 끝났음)
		        String uploadPath = utilFile.fileUpload(request, uploadFile, imgDTO);
		        imgDTO.setUser_seq(0);
		        imgDTO.setFile_path(uploadPath);
	//	      해당 경로만 받아 db에 저장
		        imgService.Image_Add(imgDTO);
		        String file_id = imgService.getFile_Seq();
		        //System.out.println("RewardController reAddProCtrl n : " + n);
		        System.out.println("RewardController reAddProCtrl uploadPath : " + uploadPath);
				
		        menuDTO.setFile_id(String.valueOf(Integer.parseInt(file_id)));
			}else { //업로드된 파일 없을때
				if(request.getParameter("org_file_id")!="-1"){//변경이 없을경우
					System.out.println(request.getParameter("org_file_id"));
					menuDTO.setFile_id(request.getParameter("org_file_id"));
				}else {
					menuDTO.setFile_id("-1");
				}
			}
			int menu_sort_no;
			if(request.getParameter("org_cate_sort_no").equals(request.getParameter("cate_sort_no"))) {
				menu_sort_no = Integer.parseInt(request.getParameter("menu_sort_no"));
			}else {
				List<ADMIN_Menu_InfoDTO> CateToMenuDTOarr = ftService.getFt_CateToMenu_List(menuDTO);
				menu_sort_no = CateToMenuDTOarr.size()+1;
			}
			String menu_name = request.getParameter("menu_name");
			int menu_price = Integer.parseInt(request.getParameter("menu_price"));
			String menu_intro = request.getParameter("menu_intro");
			int menu_rqtime = Integer.parseInt(request.getParameter("menu_rqtime"));
			String orign = request.getParameter("orign");
			int exp_yn = Integer.parseInt(request.getParameter("exp_yn"));
			
			menuDTO.setMenu_sort_no(menu_sort_no);
			menuDTO.setMenu_name(menu_name);
			menuDTO.setMenu_price(menu_price);
			menuDTO.setMenu_intro(menu_intro);
			menuDTO.setMenu_rqtime(menu_rqtime);
			menuDTO.setOrign(orign);
			menuDTO.setExp_yn(exp_yn);
			
			ftService.ft_Menu_Edit(menuDTO);
			
			return ft_info(request, model, session);
		}
		
		//메뉴 삭제
		@RequestMapping(value="seller/ft/ft_menu_delete", method=RequestMethod.GET)
		public String ft_Menu_Delete(HttpServletRequest request, Model model, HttpSession session) throws Exception{
			int menu_seq = Integer.parseInt(request.getParameter("menu_seq"));
			ftService.ft_Menu_Delete(menu_seq);
			
			return ft_info(request, model, session);
		}
		
		//메뉴 올리기
		@RequestMapping(value="seller/ft/ft_menu_up", method=RequestMethod.GET)
		public String ft_Menu_Up(HttpServletRequest request, Model model, HttpSession session) throws Exception{
			ADMIN_Menu_InfoDTO menuDTO = new ADMIN_Menu_InfoDTO();
			int ft_seq = Integer.parseInt(request.getParameter("ft_seq"));
			int cate_sort_no = Integer.parseInt(request.getParameter("cate_sort_no"));
			int menu_sort_no = Integer.parseInt(request.getParameter("menu_sort_no"));
			menuDTO.setFt_seq(ft_seq);
			menuDTO.setCate_sort_no(cate_sort_no);
			menuDTO.setMenu_sort_no(menu_sort_no);
			List<ADMIN_Menu_InfoDTO> menuDTOarr = ftService.getFt_CateToMenu_List(menuDTO);
			if(menu_sort_no != 1 && menuDTOarr.size() != 1) {
				menuDTO.setMenu_sort_no(menu_sort_no);
				menuDTO.setEdit_menu_sort_no(0);
				ftService.ft_Menu_Sort(menuDTO);
				menuDTO.setMenu_sort_no(menu_sort_no-1);
				menuDTO.setEdit_menu_sort_no(menu_sort_no);
				ftService.ft_Menu_Sort(menuDTO);
				menuDTO.setMenu_sort_no(0);
				menuDTO.setEdit_menu_sort_no(menu_sort_no-1);
				ftService.ft_Menu_Sort(menuDTO);
			}
			
			return ft_info(request, model, session);
		}
				
		//메뉴 내리기
		@RequestMapping(value="seller/ft/ft_menu_down", method=RequestMethod.GET)
		public String ft_Menu_Down(HttpServletRequest request, Model model, HttpSession session) throws Exception{
			ADMIN_Menu_InfoDTO menuDTO = new ADMIN_Menu_InfoDTO();
			int ft_seq = Integer.parseInt(request.getParameter("ft_seq"));
			int menu_seq = Integer.parseInt(request.getParameter("menu_seq"));
			int cate_sort_no = Integer.parseInt(request.getParameter("cate_sort_no"));
			int menu_sort_no = Integer.parseInt(request.getParameter("menu_sort_no"));
			menuDTO.setMenu_seq(menu_seq);
			menuDTO.setFt_seq(ft_seq);
			menuDTO.setCate_sort_no(cate_sort_no);
			menuDTO.setMenu_sort_no(menu_sort_no);
			List<ADMIN_Menu_InfoDTO> menuDTOarr = ftService.getFt_CateToMenu_List(menuDTO);
				if(menu_sort_no != menuDTOarr.size() && menuDTOarr.size() != 1) {
					menuDTO.setMenu_sort_no(menu_sort_no);
					menuDTO.setEdit_menu_sort_no(0);
					ftService.ft_Menu_Sort(menuDTO);
					menuDTO.setMenu_sort_no(menu_sort_no+1);
					menuDTO.setEdit_menu_sort_no(menu_sort_no);
					ftService.ft_Menu_Sort(menuDTO);
					menuDTO.setMenu_sort_no(0);
					menuDTO.setEdit_menu_sort_no(menu_sort_no+1);
					ftService.ft_Menu_Sort(menuDTO);
				}
			
			return ft_info(request, model, session);
		}
}








