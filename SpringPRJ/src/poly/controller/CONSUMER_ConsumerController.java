package poly.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
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

import poly.dto.admin.ADMIN_Ft_Menu_CateDTO;
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
import poly.util.UtilTime;
import poly.service.CONSUMER_IImageService;
import poly.service.CONSUMER_IUserService;
import poly.service.impl.CONSUMER_ImageService;
import poly.service.impl.CONSUMER_UserService;

/*
 * Controller 선언해야만 Spring 프레임워크에서 Controller인지 인식 가능
 * 자바 서블릿 역할 수행
 * */
@Controller
public class CONSUMER_ConsumerController {
	private Logger log = Logger.getLogger(this.getClass());
	
	/*String savePath= "C:\\TWtest\\SpringPRJ\\WebContent\\uploadImg\\"; 
	// 이거는 로컬 경로를 뜻하는지 알아야됨
	*/	
	@Resource(name = "CONSUMER_FtService")
	private CONSUMER_IFtService ftService;
	
	@Resource(name="CONSUMER_ImageService")
	private CONSUMER_IImageService imgService;

	@Resource(name="CONSUMER_UserService")
	private CONSUMER_IUserService UserService;
	
	public String getDate() {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy. MM. dd / hh:mm:ss");
		String date = sdf1.format(cal.getTime());
		return date;
	}

	
	// 근처 푸드트럭 찾기
	@RequestMapping(value="consumer/cnsmr/findAdjFt", method=RequestMethod.GET)
	public String findAdjFt(HttpServletRequest request, Model model) throws Exception{
		//값 받아 오기 및 확인
		log.info("access findAdjFt");
		String myAddress= request.getParameter("myAddress");
		//String regCode = request.getParameter("regCode"); //GET방식으로 받은 지역코드를 변수에 할당
		
		//위치 미 설정시 내 위치 설정 페이지로 이동
		if("".equals(myAddress)) {
			String msg= "위치 설정을 먼저 해주세요";
			String url= "/consumer/cnsmr/findMyLoc.do";
			
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return "/cmmn/alert";
			
		}
		String []locPosition = request.getParameter("locPosition").split(","); //GET방식으로 받은 locPosition을 분리하여 어레이 변수에 할당
		
		
		log.info("Current Location's Longitude is :" + locPosition[0]); //받아온 위도 확인
		log.info("Current Location's Latitude is :" + locPosition[1]);	// 받아온 경도 확인
		log.info("User's Location is :" + myAddress);	// 받아온 지역코드 확인
		
		List<CONSUMER_Ft_InfoDTO> ftList = ftService.getFtList(myAddress.split(" ")[0]); //리스트형식의 푸드트럭객체들을 지역코드를 파라미터를 사용해 테이블로부터 불러옴
		
		ftList = SortTruck.getAdjTrucks(ftList, locPosition); // 가까운 트럭들만 모아놓을 리스트 변수 선언
		ftList = SortTruck.sortFtClose(ftList); // 가까운 거리부터 순서대로 정렬 하여 리스트에 할당
		
		model.addAttribute("locPositionLat", locPosition[0]); //전송
		model.addAttribute("locPositionLon", locPosition[1]); //전송
		model.addAttribute("ftList", ftList); //fList라는 변수로 리턴으로 가져갈 리스트 변수 전송 
		
		////////////////////트럭 사진 리스트 불러오기////////////////// 											
		log.info(this.getClass() + " // truckImages start !!");
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
			
			imgDTOs = null;
		}
			log.info(this.getClass() + "truckImage end !!");
		///////////////////////////////////////////////////////
		
		return "/consumer/cnsmr/findAdjFt";
	}

	
	// 푸드트럭 상세 보기
	@RequestMapping(value="consumer/cnsmr/ftDetail", method=RequestMethod.GET) //POST방식으로 데이터를 받음
	public String ftDetail(HttpServletRequest request, Model model) throws Exception {
		log.info("Access cnsmr/ftDetail.do");
		String user_seq = CmmUtil.nvl(request.getParameter("userSeq"));
		String ft_seq = CmmUtil.nvl(request.getParameter("ft_seq"));
		// 푸드트럭 상세 보기 페이지 내의 어느 탭으로 이동할지를 결정 ---  0-정보 1-메뉴 2-리뷰
		String cmd = request.getParameter("cmd"); 
		if("".equals(cmd)) { //cmd 값이 지정되지 않았다면 정보 탭으로 이동합니다.
			cmd = "0";
		}
		model.addAttribute("cmd",cmd);
		
		log.info("access ftDetail");
		log.info("ft_seq : " + ft_seq);		
		CONSUMER_Ft_InfoDTO fDTO = ftService.getFtDetail(ft_seq);
		model.addAttribute("fDTO", fDTO); //푸드트럭 정보 1개 객체 전송
		
		//트럭 이미지 전송
		CONSUMER_ImageDTO imgDTO = ftService.getFtImage(fDTO.getFile_id());
		model.addAttribute("imgDTO",imgDTO);
		
		//관심매장 추가 여부 확인
		String FtLikeResult= "-1";
		if(!"".equals(user_seq) && user_seq != null) {
			CONSUMER_FtLikeDTO ftLikeDTO = new CONSUMER_FtLikeDTO();
			ftLikeDTO.setFt_seq(ft_seq);
			ftLikeDTO.setUser_seq(user_seq);
			
			if(!"".equals(user_seq)) {
				CONSUMER_FtLikeDTO checkDTO = UserService.ftCheckFavrotie(ftLikeDTO);
				if(checkDTO != null) {
					if(checkDTO.getFt_seq().equals(ftLikeDTO.getFt_seq()) && checkDTO.getUser_seq().equals(ftLikeDTO.getUser_seq())) {
						FtLikeResult = "1"; // 확인 됨 
					}
				}
			}

		}
		model.addAttribute("FtLikeResult", FtLikeResult);
		return "/consumer/cnsmr/ftDetail";		  
	}
	
	
	// 푸드트럭 상세보기 페이지 내의 리뷰 보기 탭 - AJAX
	@RequestMapping(value="consumer/cnsmr/ftDetailReview.do", method=RequestMethod.GET)
	public String ftDetailReview(HttpServletRequest request, Model model) throws Exception{
		int ft_seq = Integer.parseInt(request.getParameter("ft_seq"));
		log.info("Access ftDetailReview: " + ft_seq);
		
		////리뷰리스트////
		List<CONSUMER_Ft_ReviewDTO> repleList = new ArrayList<CONSUMER_Ft_ReviewDTO>();
		repleList = ftService.getFt_Review_List_ftDetail(ft_seq);	//특정 푸드트럭 상세 정보 리뷰 리스트-- 답글 제외
		//날짜 수정
		for(int i =0; i < repleList.size();i++) {
			String newRegDate = UtilTime.SetupRegDate(repleList.get(i).getRev_regdate());
			repleList.get(i).setRev_regdate(newRegDate);
			log.info(repleList.get(i).getRev_regdate());
			log.info(repleList.get(i).getRev_title());
		}
		model.addAttribute("repleList", repleList);
		/////////////
		
		///푸드트럭 정보//
		CONSUMER_Ft_InfoDTO fDTO = ftService.getFtDetail(String.valueOf(ft_seq));
		model.addAttribute("fDTO", fDTO);
		/////////////
		
		
		
		return "/consumer/cnsmr/ftDetailReview";
	}
	
	// 푸드트럭 상세보기 페이지 내의 메뉴 탭 - AJAX
	@RequestMapping(value="consumer/cnsmr/ftDetailMenu.do", method=RequestMethod.GET)
	public String ftDetailMenu(HttpServletRequest request, Model model) throws Exception{
		String ft_seq = request.getParameter("ft_seq");
		log.info("Access ftDetailMenu: " + ft_seq);
		
		//메뉴리스트 가져오기
		List<CONSUMER_Menu_InfoDTO> menuDTOs = ftService.getFtMenuList(ft_seq);
		model.addAttribute("menuDTOs", menuDTOs);
		//메뉴 카테고리 가져오기
		List<CONSUMER_FtMenuCateDTO> cateDTOs = ftService.getFT_Cate_List(Integer.parseInt(ft_seq));
		model.addAttribute("cateDTOs", cateDTOs);
		
		
		//////////////////메뉴 사진들 불러오기////////////////// 	
		log.info("fMenuList is NULL?" + menuDTOs.isEmpty()); //리뷰 테이블에 정보가 있는지 확인하고 있으면 가져옴
		if(menuDTOs.isEmpty() == false) {
			log.info(this.getClass() + " // Menu Images start !!");
			List<CONSUMER_ImageDTO> imgDTOs = new ArrayList<CONSUMER_ImageDTO>();
			
			
			for(int i = 0; i < menuDTOs.size(); i++) {
				CONSUMER_ImageDTO ImgDTO = new CONSUMER_ImageDTO(); //리스트에 추가할 객체 선언
				ImgDTO.setFileId(menuDTOs.get(i).getFile_id());	// 각 객체에 필요 파일 id정보 불러오기
				imgDTOs.add(ImgDTO); //리스트에 추가
			}
			
			imgDTOs = ftService.getMenuImage(imgDTOs);
			
			if (imgDTOs == null) {			
				imgDTOs = new ArrayList<CONSUMER_ImageDTO>();
			}		
			log.info("ImgDTOs size is :" + imgDTOs.size());
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
			
			log.info(this.getClass() + "Menu Image end !!");
			
		}
		///////////////////////////////////////////////////////
		
		
		menuDTOs = null;
		return "/consumer/cnsmr/ftDetailMenu";
	}
	
	////////////////////////푸드트럭 리뷰////////////////////////
	//푸드트럭 리뷰 쓰기
	@RequestMapping(value="consumer/review/writeReivew.do", method=RequestMethod.POST)
	public String writeReivew(HttpServletRequest request, Model model) throws Exception {
		log.info("Access wrtieReview");
		String ft_seq = request.getParameter("ft_seq"); // 푸드트럭 번호
		String userSeq = request.getParameter("userSeq"); // 로그인 한 유저 번호
		String ft_name = request.getParameter("ft_name"); // 푸드트럭 이름
		
		//로그인 안되어 있는 경우
		if("".equals(userSeq) || userSeq.isEmpty() == true) {
			String url = "/cmmn/main.do"; //로그인 화면 이동
			String msg = "로그인 후 이용해주시길 바랍니다.";
			model.addAttribute("url", url);
			model.addAttribute("msg", msg);
			return "/cmmn/alert";
		}
		
		model.addAttribute("ft_name", ft_name);
		model.addAttribute("ft_seq",ft_seq);
		model.addAttribute("userSeq",userSeq);
		return "/consumer/review/writeReview";
	}

	//리뷰 쓰기 WRTIE PROC
	@RequestMapping(value="consumer/review/writeReviewProc.do", method=RequestMethod.POST)
	public String writeReviewProc(@RequestParam("uploadFile") MultipartFile uploadFile, MultipartHttpServletRequest request, Model model, HttpSession session) throws Exception{
		////////////////////////////
		CONSUMER_Ft_ReviewDTO revDTO = new CONSUMER_Ft_ReviewDTO();
		int ft_seq = Integer.parseInt(request.getParameter("ft_seq"));
		revDTO.setFt_seq(ft_seq);
		revDTO.setUser_seq(Integer.parseInt(CmmUtil.nvl((String)session.getAttribute("userSeq"))));
		CONSUMER_ImageDTO imgDTO = new CONSUMER_ImageDTO();
		if(!uploadFile.isEmpty()) {
			//	      UtilFile 객체 생성
	        CONSUMER_UtilFile utilFile = new CONSUMER_UtilFile();
	        
	        	//	      파일 업로드 결과값을 path로 받아온다(이미 fileUpload() 메소드에서 해당 경로에 업로드는 끝났음)
	        String uploadPath = utilFile.fileUpload(request, uploadFile, imgDTO);
	        imgDTO.setUserSeq(CmmUtil.nvl((String)session.getAttribute("userSeq")));
	        imgDTO.setFilePath(uploadPath);
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
		revDTO.setRev_regdate(getDate());
		revDTO.setRev_level(" ");
		revDTO.setExp_yn(1);
		ftService.ft_Review_Create(revDTO);
		
		List<CONSUMER_Ft_ReviewDTO> revDTOarr = ftService.getFT_Review_List(ft_seq);
		//테이블생성 시 해당 테이블의 시퀀스값을 board_level 컬럼에 저장
		int review_seq = revDTOarr.get(revDTOarr.size()-1).getReview_seq();
		ftService.ft_Set_Rev_level(review_seq);
		//작성한 글을 보기 위해 모델 객체 생성 후 리뷰글 기본키 전송
		
		log.info(review_seq);
		model.addAttribute("review_seq", review_seq);
		
		return "redirect:/consumer/review/viewReview.do";
	}
	
	//리뷰 글 상세 보기
	@RequestMapping(value="consumer/review/viewReview.do")
	public String viewReview(HttpServletRequest request, Model model) throws Exception {
		log.info("Access viewReview - test");
		int review_seq = Integer.parseInt(request.getParameter("review_seq")); // 리뷰글 기본키 값;
		log.info(review_seq);
		CONSUMER_Ft_ReviewDTO revDTO = ftService.getFT_Review_Info(review_seq); //리뷰 글 상세 정보 가져오기
		log.info(revDTO == null);
		//리뷰 댓글 가져오기
		List<CONSUMER_Ft_ReviewDTO> ALL_review_List; // 모든 리뷰 리스트 변수 선언
		int ft_seq = revDTO.getFt_seq();	// 리뷰 댓글 불러오기 함수 파라미터 선언
		List<CONSUMER_Ft_ReviewDTO> repleList = new ArrayList<CONSUMER_Ft_ReviewDTO>(); //댓글 리스트 변수 선언
		
		ALL_review_List = ftService.getFT_Review_List(ft_seq); //임의의 푸드트럭의 모든 리뷰 리스트 가져오기 
		
		for(CONSUMER_Ft_ReviewDTO revpDTO : ALL_review_List) {
			String[] array = revpDTO.getRev_level().split("-");
			if(!String.valueOf(revpDTO.getReview_seq()).equals(
					revpDTO.getRev_level())&&
					(review_seq-1)==Integer.parseInt(array[0])) {
				repleList.add(revpDTO);
			}
		}
		//리뷰 이미지 전송
		CONSUMER_ImageDTO imgDTO = new CONSUMER_ImageDTO();
		if(revDTO.getFile_id()!="-1") {
			imgDTO = imgService.getImageInfo(revDTO.getFile_id());
		}
		
		model.addAttribute("imgDTO", imgDTO);
		model.addAttribute("repleList", repleList);
		model.addAttribute("revDTO", revDTO);
		
		return "/consumer/review/viewReview";
	}
	
	//리뷰 댓글 쓰기
	@RequestMapping(value="consumer/review/ReviewReplProc.do", method=RequestMethod.POST)
	public String ReviewReplProc(HttpServletRequest request, Model model) throws Exception{
		log.info("Access review/ReviewReplProc.do");
		CONSUMER_Ft_ReviewDTO revDTO = new CONSUMER_Ft_ReviewDTO();
		int ft_seq = Integer.parseInt(request.getParameter("ft_seq"));
		int user_seq = Integer.parseInt(request.getParameter("userSeq"));
		int review_seq = Integer.parseInt(request.getParameter("review_seq"));
		 
		String search_level = String.valueOf(review_seq-1)+"-";
		List<CONSUMER_Ft_ReviewDTO> review_LevP_List = ftService.getReview_LevP_List(search_level);
		
		//테이블생성 시 해당 테이블의 시퀀스값을 board_level 컬럼에 저장
		for(CONSUMER_Ft_ReviewDTO revpDTO : review_LevP_List) {
			CONSUMER_Ft_ReviewDTO irevpDTO = new CONSUMER_Ft_ReviewDTO();
			String split[] = revpDTO.getRev_level().split("-");
			irevpDTO.setReview_seq(revpDTO.getReview_seq());
			irevpDTO.setRev_level(split[0]+"-"+String.valueOf(Integer.parseInt(split[1])+1));
			ftService.ft_Set_Revp_level(irevpDTO);
		}
		
		revDTO.setFt_seq(ft_seq);
		revDTO.setUser_seq(user_seq);
		revDTO.setFile_id("-1");
		revDTO.setRev_title(" ");
		revDTO.setRev_text(request.getParameter("rev_text"));
		revDTO.setRev_point(0);
		revDTO.setRev_regdate(getDate());
		revDTO.setRev_level(search_level+"1");
		revDTO.setExp_yn(1);
		ftService.ft_Review_Create(revDTO);
		
		log.info(review_seq);
		model.addAttribute("review_seq", review_seq);
		log.info("Terminate /review/ReviewReplProc.do");
		
		return "redirect:/consumer/review/viewReview.do";
	}
	
	//리뷰답글 수정
	@RequestMapping(value="consumer/review/ReviewReplEdit.do", method=RequestMethod.POST)
	public String ReviewReplEdit(HttpServletRequest request, Model model) throws Exception{
		log.info("Access ReviewReplEdit");
		int edit_review_seq = Integer.parseInt(request.getParameter("edit_review_seq")); //수정하려는 댓글 번호
		int review_seq = Integer.parseInt(request.getParameter("review_seq")); // 수정하려는 댓글을 가진 리뷰글
		CONSUMER_Ft_ReviewDTO edit_reviewDTO = ftService.getFT_Review_Info(edit_review_seq);
		log.info(review_seq);
		log.info(edit_review_seq);
		
		model.addAttribute("review_seq", review_seq);
		model.addAttribute("edit_reviewDTO", edit_reviewDTO);
		
		return "/consumer/review/editReply";
	}
	
	//리뷰답글 수정 -- PROCEDURE
	@RequestMapping(value="/consumer/review/ReviewReplEditProc.do", method=RequestMethod.POST)
	public String ReviewReplEditProc(HttpServletRequest request, Model model) throws Exception{
		log.info("Access ReviewReplEdit -- PROCEDURE");
		int edit_review_seq = Integer.parseInt(request.getParameter("edit_review_seq")); //수정하려는 댓글 번호
		int review_seq = Integer.parseInt(request.getParameter("review_seq")); // 수정하려는 댓글을 가진 리뷰글
		String rev_text = request.getParameter("rev_text");
		
		CONSUMER_Ft_ReviewDTO revDTO = new CONSUMER_Ft_ReviewDTO();
		revDTO.setReview_seq(edit_review_seq);
		revDTO.setRev_text(rev_text);
		ftService.ft_Review_Reple_Edit(revDTO);
		
		model.addAttribute("review_seq", review_seq);
		
		return "redirect:/consumer/review/viewReview.do";
	}
	
	//리뷰답글 삭제
	@RequestMapping(value="consumer/review/ReviewReplDelete.do", method=RequestMethod.POST)
	public String ReviewReplDelete(HttpServletRequest request, Model model) throws Exception{
		String edit_review_seq = request.getParameter("edit_review_seq");
		String review_seq = request.getParameter("review_seq");
		
		ftService.ft_Review_Delete(Integer.parseInt(edit_review_seq));
		model.addAttribute("review_seq", review_seq);
		
		return "redirect:/consumer/review/viewReview.do";
	}
	
	
	//리뷰글 수정 페이지 이동
	@RequestMapping(value="consumer/review/ReviewEdit.do", method=RequestMethod.POST)
	public String ReviewEdit(HttpServletRequest request, Model model) throws Exception{
		log.info("Access ReviewEdit");
		/*int user_seq = Integer.parseInt(request.getParameter("userSeq"));*/
		int review_seq = Integer.parseInt(request.getParameter("review_seq"));
		
		CONSUMER_Ft_ReviewDTO edit_reviewDTO = ftService.getFT_Review_Info(review_seq);
		log.info(review_seq);
		
		CONSUMER_ImageDTO imgDTO = ftService.getFtImage(edit_reviewDTO.getFile_id()); //리뷰 이미지 가져오기
		
		model.addAttribute("edit_reviewDTO", edit_reviewDTO);
		model.addAttribute("imgDTO", imgDTO);
		
		return "/consumer/review/editReview";
		
		
		
	}
	
	//리뷰 게시글 본 글! 수정 -- PROCEDURE
	@RequestMapping(value="consumer/review/ReviewEditProc.do", method=RequestMethod.POST)
	public String ReviewEditProc(@RequestParam("uploadFile") MultipartFile uploadFile, MultipartHttpServletRequest request, Model model) throws Exception{
		log.info("Access ReviewEditProc -- PROCEDURE");
		int edit_review_seq = Integer.parseInt(request.getParameter("edit_review_seq")); //수정하려는 리뷰 번호
		String userSeq = request.getParameter("userSeq"); //수정하려는 사용자 번호
		String rev_text = request.getParameter("rev_text"); //수정하려는 리뷰 제목
		String rev_title = request.getParameter("rev_title"); //수정하려는 리뷰 내용
		int rev_point = Integer.parseInt(request.getParameter("rev_point")); //수정하려는 리뷰 별점 갯수
		
		CONSUMER_Ft_ReviewDTO revDTO = new CONSUMER_Ft_ReviewDTO();


	
		CONSUMER_ImageDTO imgDTO = new CONSUMER_ImageDTO();
		//이미지 변경 체크
		if(!uploadFile.isEmpty()) { //업로드된 파일 확인
			//	      UtilFile 객체 생성
	        CONSUMER_UtilFile utilFile = new CONSUMER_UtilFile();
	        
	        //	      파일 업로드 결과값을 path로 받아온다(이미 fileUpload() 메소드에서 해당 경로에 업로드는 끝났음)
	        String uploadPath = utilFile.fileUpload(request, uploadFile, imgDTO);
	        imgDTO.setUserSeq(userSeq);
	        imgDTO.setFilePath(uploadPath);
	        //	      해당 경로만 받아 db에 저장
	        imgService.Image_Add(imgDTO);
	        String file_id = imgService.getFile_Seq();
	        //System.out.println("RewardController reAddProCtrl n : " + n);
	        System.out.println("RewardController reAddProCtrl uploadPath : " + uploadPath);
			
	        revDTO.setFile_id(String.valueOf(Integer.parseInt(file_id)));
	        
		} else { //업로드된 파일 없을때
			if(request.getParameter("org_file_id")!="-1"){//변경이 없을 경우
				System.out.println(request.getParameter("org_file_id"));
				revDTO.setFile_id(request.getParameter("org_file_id"));
			} else {
				revDTO.setFile_id("-1"); //파일 삭제 경우
			}
		}
		
		revDTO.setReview_seq(edit_review_seq);
		revDTO.setRev_point(rev_point);
		revDTO.setRev_title(rev_title);
		revDTO.setRev_text(rev_text);
		ftService.ft_Review_Edit(revDTO);
		
		model.addAttribute("review_seq", edit_review_seq);
		
		return "redirect:/consumer/review/viewReview.do";
	}
	
	//리뷰글 삭제
	@RequestMapping(value="consumer/review/ReviewDelete.do")
	public String ReviewDelete(HttpServletRequest request, Model model) throws Exception{
		log.info("Access /review/ReviewDelete");
		String review_seq = request.getParameter("review_seq");
		String ft_seq = request.getParameter("ft_seq");
		
		ftService.ft_Review_Delete(Integer.parseInt(review_seq));
		model.addAttribute("cmd", "2"); //리뷰 리스트 탭으로 이동 하기 위한 명령어 설정
		model.addAttribute("ft_seq", ft_seq);
		return "redirect:/consumer/cnsmr/ftDetail.do";
	}

		
}
