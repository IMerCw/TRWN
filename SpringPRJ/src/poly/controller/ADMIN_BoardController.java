package poly.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import poly.dto.admin.ADMIN_BoardDTO;
import poly.dto.admin.ADMIN_Board_PostDTO;
import poly.dto.admin.ADMIN_Board_RepleDTO;
import poly.dto.admin.ADMIN_Ft_InfoDTO;
import poly.dto.admin.ADMIN_Ft_ReviewDTO;
import poly.dto.admin.ADMIN_ImageDTO;
import poly.dto.admin.ADMIN_User_InfoDTO;
import poly.service.ADMIN_IBoardService;
import poly.service.ADMIN_IImageService;
import poly.service.ADMIN_IUserService;
import poly.util.ADMIN_UtilFile;

@Controller
public class ADMIN_BoardController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="ADMIN_UserService")
	private ADMIN_IUserService userService;
	
	@Resource(name = "ADMIN_BoardService")
	private ADMIN_IBoardService boardService;
	
	@Resource(name="ADMIN_ImageService")
	private ADMIN_IImageService imgService;
	
/*----------------------------------------------------------------------------------------*/
	
	public String getDate() {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy. MM. dd / HH:mm:ss");
		String date = sdf1.format(cal.getTime());
		
		return date;
	}
	
/*----------------------------------------------------------------------------------------*/
	
	//게시판 리스트
	@RequestMapping(value="admin/board/board_list", method=RequestMethod.GET)
	public String board_list(HttpServletRequest request, Model model) throws Exception{
		List<ADMIN_BoardDTO> boardList = boardService.getBoard_List();
		
		//신규 게시물, 전체 게시물 갯수, 유저 세팅
		for(int i=0; i<boardList.size(); i++) {
			boardList.get(i).setBoard_p_count(boardService.board_P_Count(boardList.get(i).getBoard_seq()));
		}
		
		//게시판 쪼개기
		model.addAttribute("pageNum", request.getParameter("pageNum"));
		model.addAttribute("pageSize", request.getParameter("pageSize"));

		model.addAttribute("boardList", boardList);
		
		return "/admin/board/board_list";
	}
	
	//게시판 검색
	@RequestMapping(value="admin/board/boardSearch_list", method=RequestMethod.GET)
	public String board_search(HttpServletRequest request, Model model) throws Exception{
		String option = request.getParameter("option");
		String value = request.getParameter("value");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("option", option);
		map.put("value", value);
		
		List<ADMIN_BoardDTO> boardSearchList = boardService.getBoard_Search(map);
		//신규 게시물, 전체 게시물 갯수 세팅
		for(int i=0; i<boardSearchList.size(); i++) {
			boardSearchList.get(i).setBoard_p_count(boardService.board_P_Count(boardSearchList.get(i).getBoard_seq()));
		}
		//게시판 쪼개기
		model.addAttribute("pageNum", request.getParameter("pageNum"));
		model.addAttribute("pageSize", request.getParameter("pageSize"));

		model.addAttribute("boardSearchList", boardSearchList);
		
		model.addAttribute("option", option);
		model.addAttribute("value", value);
		
		return "/admin/board/boardSearch_list";
	}
	
	//게시판 만들기
	@RequestMapping(value="admin/board/board_create", method=RequestMethod.POST) 
	public String board_create(HttpServletRequest request, Model model) throws Exception{
		String board_name = request.getParameter("board_name");
		int board_read = Integer.parseInt(request.getParameter("read"));
		int board_write = Integer.parseInt(request.getParameter("write"));
		int board_reple = Integer.parseInt(request.getParameter("reple"));
		int exp_yn = Integer.parseInt(request.getParameter("exp_yn"));
		
		String date = getDate();
		
		ADMIN_BoardDTO bDTO = new ADMIN_BoardDTO();
		bDTO.setBoard_name(board_name);
		bDTO.setBoard_read(board_read);
		bDTO.setBoard_write(board_write);
		bDTO.setBoard_reple(board_reple);
		bDTO.setExp_yn(exp_yn);
		bDTO.setReg_date(date);
		
		int result = boardService.board_Create(bDTO);
		
		String msg="";
		
		if(result>0) {
			msg = "게시판이 추가되었습니다.";
		}else {
			msg = "게시판 추가 실패";
		}
		model.addAttribute("msg", msg);
		
		return board_list(request, model);
	}
	
	//게시판 수정 (페이지 이동)
		@RequestMapping(value="admin/board/board_edit", method=RequestMethod.GET)
		public String board_edit(HttpServletRequest request, Model model) throws Exception{
			int board_seq = Integer.parseInt(request.getParameter("board_seq"));
			ADMIN_BoardDTO bDTO = boardService.getBoard_Detail(board_seq); 
			model.addAttribute("bDTO", bDTO);
			return "/admin/board/board_edit";
		}
	
	//게시판 수정 (완료)
	@RequestMapping(value="admin/board/board_edit_ok", method=RequestMethod.POST)
	public String board_edit_ok(HttpServletRequest request, Model model) throws Exception{
		int board_seq = Integer.parseInt(request.getParameter("board_seq"));
		String board_name = request.getParameter("board_name");
		int board_read = Integer.parseInt(request.getParameter("read"));
		int board_write = Integer.parseInt(request.getParameter("write"));
		int board_reple = Integer.parseInt(request.getParameter("reple"));
		int exp_yn = Integer.parseInt(request.getParameter("exp_yn"));
		
		ADMIN_BoardDTO bDTO = new ADMIN_BoardDTO();
		bDTO.setBoard_seq(board_seq);
		bDTO.setBoard_name(board_name);
		bDTO.setBoard_read(board_read);
		bDTO.setBoard_write(board_write);
		bDTO.setBoard_reple(board_reple);
		bDTO.setExp_yn(exp_yn);
		
		int result = boardService.board_Edit(bDTO);
		
		String msg="";
		
		if(result>0) {
			msg = "게시판이 수정되었습니다.";
		}else {
			msg = "게시판 수정 실패";
		}
		model.addAttribute("msg", msg);
		
		return board_list(request, model);
	}
	
	//게시판 삭제
	@RequestMapping(value="admin/board/board_delete", method=RequestMethod.GET)
	public String board_delate(HttpServletRequest request, Model model) throws Exception{
		String ArrBoard_Seq = request.getParameter("ArrBoard_Seq");
		String[] array = ArrBoard_Seq.split(",");
		for(int i=0; i<array.length; i++) {
			boardService.board_Delete(Integer.parseInt(array[i]));
		}
		return board_list(request, model);
	}
	
	//게시판 노출여부 설정
	@RequestMapping(value="admin/board/board_exp_yn", method=RequestMethod.GET)
	public String board_exp_yn(HttpServletRequest request, Model model) throws Exception{
		String ArrBoard_Seq = request.getParameter("ArrBoard_Seq");
		String[] array = ArrBoard_Seq.split(",");
		for(int i=0; i<array.length; i++) {
			boardService.board_Exp_yn(Integer.parseInt(array[i]));
		}
		
		return board_list(request, model);
	}
	
/*게시물 관리----------------------------------------------------------------------------------------*/
	
	//게시물 리스트
	@RequestMapping(value="admin/board_p/board_p_list", method=RequestMethod.GET)
	public String board_p_list(HttpServletRequest request, Model model) throws Exception{
		String board_select = request.getParameter("board_select");
		List<ADMIN_Board_PostDTO> board_P_List;
		List<ADMIN_User_InfoDTO> bp_uDTOarr = new ArrayList<ADMIN_User_InfoDTO>();
		
		if(board_select != null) {
			if(board_select.equals("all")) {
				board_P_List = boardService.getBoard_P_List();
			}else{
				board_P_List = boardService.getBoard_P_List_S(Integer.parseInt(board_select));
				model.addAttribute("board_seq", board_select);
			}
		}else {
		board_P_List = boardService.getBoard_P_List();
		}
		List<ADMIN_BoardDTO> boardList = boardService.getBoard_List();
		
		model.addAttribute("boardList", boardList);
		//게시판 쪼개기
		model.addAttribute("pageNum", request.getParameter("pageNum"));
		model.addAttribute("pageSize", request.getParameter("pageSize"));
		
		//댓글갯수, 유저 세팅
		for(int i=0; i<board_P_List.size(); i++) {
			board_P_List.get(i).setReple_count(boardService.board_R_Count(board_P_List.get(i).getBoard_p_seq()));
			bp_uDTOarr.add(userService.getUser(board_P_List.get(i).getUser_seq()));
		}
		model.addAttribute("bp_uDTOarr", bp_uDTOarr);
		model.addAttribute("board_select", board_select);
		model.addAttribute("board_P_List", board_P_List);
		
		
		
		return "/admin/board_p/board_p_list";
	}
	
	//게시물 검색
	@RequestMapping(value="admin/board_p/board_p_search_list", method=RequestMethod.GET)
	public String board_p_search_list(HttpServletRequest request, Model model) throws Exception{
		
		String board_select = request.getParameter("board_select");
		String option = request.getParameter("option");
		String value = request.getParameter("value");
		
		List<ADMIN_Board_PostDTO> board_P_SearchList=null;
		List<ADMIN_User_InfoDTO> uDTOarr = new ArrayList<ADMIN_User_InfoDTO>();
		
		if(board_select != null) {
			ADMIN_Board_PostDTO bpDTO = new ADMIN_Board_PostDTO();
			if(board_select.equals("all")) {
				bpDTO.setOption(option);
				bpDTO.setValue(value);
				board_P_SearchList = boardService.getBoard_P_ALL_Search(bpDTO); 
			}else {
				bpDTO.setBoard_seq(Integer.parseInt(board_select));
				bpDTO.setOption(option);
				bpDTO.setValue(value);
				board_P_SearchList = boardService.getBoard_P_Search(bpDTO);
				model.addAttribute("board_seq", board_select);
			}
		}
		
		model.addAttribute("option", option);
		model.addAttribute("value", value);
		model.addAttribute("board_select", board_select);
		
		List<ADMIN_BoardDTO> boardList = boardService.getBoard_List();
		model.addAttribute("boardList", boardList);
		//게시판 쪼개기
		model.addAttribute("pageNum", request.getParameter("pageNum"));
		model.addAttribute("pageSize", request.getParameter("pageSize"));
		
		//댓글갯수 세팅
		for(int i=0; i<board_P_SearchList.size(); i++) {
			board_P_SearchList.get(i).setReple_count(boardService.board_R_Count(board_P_SearchList.get(i).getBoard_p_seq()));
			uDTOarr.add(userService.getUser(board_P_SearchList.get(i).getUser_seq()));
		}
		model.addAttribute("bp_uDTOarr", uDTOarr);
		model.addAttribute("board_P_SearchList", board_P_SearchList);
		return "/admin/board_p/board_p_search_list";
	}
	
	//게시물 보기
	@RequestMapping(value="admin/board_p/board_p_info", method=RequestMethod.GET)
	public String board_p_info(HttpServletRequest request, Model model) throws Exception{
		int board_p_seq = Integer.parseInt(request.getParameter("board_p_seq"));
		
		boardService.board_P_CountUP(board_p_seq); // 조회수 증가
		
		ADMIN_Board_PostDTO bpDTO = boardService.getBoard_P_Detail(board_p_seq); 
		ADMIN_BoardDTO bDTO = boardService.getBoard_Detail(bpDTO.getBoard_seq());
		List<ADMIN_Board_RepleDTO> repleList = boardService.getBoard_R_List(board_p_seq); // 댓글리스트
		bpDTO.setReple_count(boardService.board_R_Count(bpDTO.getBoard_p_seq())); // 댓글갯수 세팅
		
		//게시물 작성자 정보
		ADMIN_User_InfoDTO bp_uDTO = userService.getUser(bpDTO.getUser_seq());
		model.addAttribute("bp_uDTO", bp_uDTO);
		
		//댓글 작성자 정보
		List<ADMIN_User_InfoDTO> br_uDTOarr = new ArrayList<ADMIN_User_InfoDTO>();
		for(ADMIN_Board_RepleDTO brDTO : repleList){
			br_uDTOarr.add(userService.getUser(brDTO.getUser_seq()));
		}
		model.addAttribute("br_uDTOarr", br_uDTOarr);
		
		ADMIN_ImageDTO imgDTO = new ADMIN_ImageDTO();
		if(bpDTO.getFile_id()!="-1") {
			imgDTO = imgService.getImageInfo(bpDTO.getFile_id());
			model.addAttribute("imgDTO", imgDTO);
		}
		
		model.addAttribute("board_name", bDTO.getBoard_name());
		model.addAttribute("bpDTO", bpDTO);
		model.addAttribute("repleList", repleList);
		
		return "/admin/board_p/board_p_info";
	}
	
	//게시물 쓰기(페이지 이동)
	@RequestMapping(value="admin/board_p/board_p_create", method=RequestMethod.GET)
	public String board_p_create(HttpServletRequest request, Model model) throws Exception{
		List<ADMIN_BoardDTO> boardList = boardService.getBoard_List();
		model.addAttribute("boardList", boardList);
		
		return "/admin/board_p/board_p_create";
	}
	
	//게시물 쓰기 완료
	@RequestMapping(value="admin/board_p/board_p_create_ok", method=RequestMethod.POST)
	public String board_p_create_ok(@RequestParam("uploadFile") MultipartFile uploadFile, MultipartHttpServletRequest request, Model model) throws Exception{
		int board_seq = Integer.parseInt(request.getParameter("board_seq"));
		//int user_seq = Integer.parseInt(request.getParameter("user_seq"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String date = getDate();
		
		ADMIN_Board_PostDTO bpDTO = new ADMIN_Board_PostDTO();
		bpDTO.setBoard_seq(board_seq);
		bpDTO.setUser_seq(0);
		
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
			
	        bpDTO.setFile_id(String.valueOf(Integer.parseInt(file_id)));
		}else {
			bpDTO.setFile_id("-1");
		}
		
		bpDTO.setTitle(title);
		bpDTO.setContent(content);
		bpDTO.setBoard_count(0);
		bpDTO.setReg_date(date);
		bpDTO.setBoard_level("0");
		bpDTO.setExp_yn(1);
		
		int result = boardService.board_P_Create(bpDTO);
		
		
		List<ADMIN_Board_PostDTO> board_P_List = boardService.getBoard_P_List();
		//테이블생성 시 해당 테이블의 시퀀스값을 board_level 컬럼에 저장
		boardService.board_P_CreateUpdate(board_P_List.get(board_P_List.size()-1).getBoard_p_seq());
		String msg="";
		
		if(result>0) {
			msg = "게시물이 저장되었습니다.";
		}else {
			msg = "게시물 저장 실패";
		}
		model.addAttribute("msg", msg);
		
		return board_p_list(request, model);
	}
	
	//게시물 답글쓰기
	@RequestMapping(value="admin/board_p/board_p_Lcreate", method=RequestMethod.GET)
	public String board_p_Lcreate(HttpServletRequest request, Model model) throws Exception{
		int board_p_seq = Integer.parseInt(request.getParameter("board_p_seq"));
		ADMIN_Board_PostDTO bpDTO = boardService.getBoard_P_Detail(board_p_seq); 
		
		ADMIN_BoardDTO bDTO = boardService.getBoard_Detail(bpDTO.getBoard_seq());
		model.addAttribute("board_name", bDTO.getBoard_name());
		model.addAttribute("bpDTO", bpDTO);
		
		return "/admin/board_p/board_p_Lcreate";
	}
	
	//게시물 답글 쓰기 완료
	@RequestMapping(value="admin/board_p/board_p_Lcreate_ok", method=RequestMethod.POST)
	public String board_p_Lcreate_ok(@RequestParam("uploadFile") MultipartFile uploadFile, MultipartHttpServletRequest request, Model model) throws Exception{
		int board_seq = Integer.parseInt(request.getParameter("board_seq"));
		String board_p_seq = request.getParameter("board_p_seq");
		//int user_seq = Integer.parseInt(request.getParameter("user_seq"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String date = getDate();
		String search_level = String.valueOf(Integer.parseInt(board_p_seq)-1)+"-";
		List<ADMIN_Board_PostDTO> board_LevP_List = boardService.getBoard_LevP_List(search_level);
		for(ADMIN_Board_PostDTO bpDTO : board_LevP_List) {
			ADMIN_Board_PostDTO ibpDTO = new ADMIN_Board_PostDTO();
			String split[] = bpDTO.getBoard_level().split("-");
			ibpDTO.setBoard_p_seq(bpDTO.getBoard_p_seq());
			ibpDTO.setBoard_level(split[0]+"-"+String.valueOf(Integer.parseInt(split[1])+1));
			boardService.board_P_LCreateUpdate(ibpDTO);
		}
		
		ADMIN_Board_PostDTO bpDTO = new ADMIN_Board_PostDTO();
		bpDTO.setBoard_seq(board_seq);
		bpDTO.setUser_seq(0);
		
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
			
	        bpDTO.setFile_id(String.valueOf(Integer.parseInt(file_id)));
		}else {
			bpDTO.setFile_id("-1");
		}
		
		bpDTO.setTitle(title);
		bpDTO.setContent(content);
		bpDTO.setBoard_count(0);
		bpDTO.setReg_date(date);
		bpDTO.setBoard_level(search_level+"1");
		bpDTO.setExp_yn(1);
		
		int result = boardService.board_P_Create(bpDTO);
		
		String msg="";
		
		if(result>0) {
			msg = "게시물이 저장되었습니다.";
		}else {
			msg = "게시물 저장 실패";
		}
		model.addAttribute("msg", msg);
		
		return board_p_list(request, model);
	}
	
	//게시물 수정 (페이지 이동)
	@RequestMapping(value="admin/board_p/board_p_edit", method=RequestMethod.GET)
	public String board_p_edit(HttpServletRequest request, Model model) throws Exception{
		int board_p_seq = Integer.parseInt(request.getParameter("board_p_seq"));
		ADMIN_Board_PostDTO bpDTO = boardService.getBoard_P_Detail(board_p_seq); 
		ADMIN_BoardDTO bDTO = boardService.getBoard_Detail(bpDTO.getBoard_seq());
		
		//작성자 셋팅
		ADMIN_User_InfoDTO bp_uDTO = userService.getUser(bpDTO.getUser_seq());
		
		ADMIN_ImageDTO imgDTO = new ADMIN_ImageDTO();
		if(bpDTO.getFile_id().equals("-1")) {
			imgDTO.setFile_orgname("파일없음");
		}else {
			imgDTO = imgService.getImageInfo(bpDTO.getFile_id());
		}
		
		model.addAttribute("bp_uDTO", bp_uDTO);
		model.addAttribute("imgDTO", imgDTO);
		model.addAttribute("board_name", bDTO.getBoard_name());
		model.addAttribute("bpDTO", bpDTO);
		
		return "/admin/board_p/board_p_edit";
	}
		
	//게시물 수정 (완료)
	@RequestMapping(value="admin/board_p/board_p_edit_ok", method=RequestMethod.POST)
	public String board_p_edit_ok(@RequestParam("uploadFile") MultipartFile uploadFile, MultipartHttpServletRequest request, Model model) throws Exception{
		int board_p_seq = Integer.parseInt(request.getParameter("board_p_seq"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		int exp_yn;
		if(request.getParameter("exp_yn")!=null && request.getParameter("exp_yn").equals("on")){
			exp_yn = 1;
		}else {
			exp_yn = -1;
		}
		ADMIN_Board_PostDTO bpDTO = new ADMIN_Board_PostDTO();
		bpDTO.setBoard_p_seq(board_p_seq);
		
		ADMIN_ImageDTO imgDTO = new ADMIN_ImageDTO();
		//이미지 변경 체크
		if(!uploadFile.isEmpty()) { //업로드된 파일 확인
//	      UtilFile 객체 생성
	        ADMIN_UtilFile utilFile = new ADMIN_UtilFile();
	        
//	      파일 업로드 결과값을 path로 받아온다(이미 fileUpload() 메소드에서 해당 경로에 업로드는 끝났음)
	        String uploadPath = utilFile.fileUpload(request, uploadFile, imgDTO);
	        imgDTO.setUser_seq(Integer.parseInt(request.getParameter("user_seq")));
	        imgDTO.setFile_path(uploadPath);
//	      해당 경로만 받아 db에 저장
	        imgService.Image_Add(imgDTO);
	        String file_id = imgService.getFile_Seq();
	        //System.out.println("RewardController reAddProCtrl n : " + n);
	        System.out.println("RewardController reAddProCtrl uploadPath : " + uploadPath);
			
	        bpDTO.setFile_id(String.valueOf(Integer.parseInt(file_id)));
		}else { //업로드된 파일 없을때
			if(request.getParameter("org_file_id")!="-1"){//변경이 없을경우
				System.out.println(request.getParameter("org_file_id"));
				bpDTO.setFile_id(request.getParameter("org_file_id"));
			}else {
				bpDTO.setFile_id("-1");
			}
		}
		
		bpDTO.setTitle(title);
		bpDTO.setContent(content);
		bpDTO.setExp_yn(exp_yn);
		
		int result = boardService.board_P_Edit(bpDTO);
		
		String msg="";
		
		if(result>0) {
			msg = "게시물이 수정되었습니다.";
		}else {
			msg = "게시물 수정 실패";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("board_p_seq", board_p_seq);
		
		return board_p_info(request, model);
	}
	
	//게시물 삭제
	@RequestMapping(value="admin/board_p/board_p_delete", method=RequestMethod.GET)
	public String board_p_delete(HttpServletRequest request, Model model) throws Exception{
		String ArrBoard_Seq = request.getParameter("ArrBoard_Seq");
		String board_p_seq = request.getParameter("board_p_seq");
		if(ArrBoard_Seq!=null) {
			String[] array = ArrBoard_Seq.split(",");
			for(int i=0; i<array.length; i++) {
				boardService.board_P_Delete(Integer.parseInt(array[i]));
			}
		}
		if(board_p_seq!=null) {
			boardService.board_P_Delete(Integer.parseInt(board_p_seq));
		}
		return board_p_list(request, model);
	}

	//게시물 노출여부 설정
	@RequestMapping(value="admin/board_p/board_p_exp_yn", method=RequestMethod.GET)
	public String board_p_exp_yn(HttpServletRequest request, Model model) throws Exception{
		String ArrBoard_Seq = request.getParameter("ArrBoard_Seq");
		String[] array = ArrBoard_Seq.split(",");
		for(int i=0; i<array.length; i++) {
			boardService.board_P_Exp_yn(Integer.parseInt(array[i]));
		}
		
		return board_p_list(request, model);
	}
	
/*댓글 관리----------------------------------------------------------------------------------------*/
	
	//댓글쓰기
	@RequestMapping(value="admin/board_reple/board_reple_create", method=RequestMethod.POST)
	public String board_reple_create(HttpServletRequest request, Model model) throws Exception{
		int board_p_seq = Integer.parseInt(request.getParameter("board_p_seq"));
		//int user_seq = Integer.parseInt(request.getParameter("user_seq"));
		String content = request.getParameter("content");
		int exp_yn = 1;
		/*if(request.getParameter("exp_yn").equals("on")){
			exp_yn = 1;
		}else {
			exp_yn = -1;
		}*/
		String date = getDate();
		
		ADMIN_Board_RepleDTO brDTO = new ADMIN_Board_RepleDTO();
		brDTO.setBoard_p_seq(board_p_seq);
		brDTO.setUser_seq(0);
		brDTO.setBoard_reple_content(content);
		brDTO.setReg_date(date);
		brDTO.setBoard_reple_level("0");
		brDTO.setExp_yn(exp_yn);
		
		int result = boardService.board_R_Create(brDTO);
		
		
		List<ADMIN_Board_RepleDTO> board_R_List = boardService.getBoard_R_List(board_p_seq);
		//테이블생성 시 해당 테이블의 시퀀스값을 board_level 컬럼에 저장
		boardService.board_R_CreateUpdate(board_R_List.get(board_R_List.size()-1).getReple_seq());
		String msg="";
		
		if(result>0) {
			msg = "댓글이 저장되었습니다.";
		}else {
			msg = "댓글 저장 실패";
		}
		model.addAttribute("msg", msg);
		
		return board_p_info(request, model);
	}
	
	//덧글쓰기
	@RequestMapping(value="admin/board_reple/board_reple_Lcreate", method=RequestMethod.POST)
	public String board_reple_Lcreate(HttpServletRequest request, Model model) throws Exception{
		int board_p_seq = Integer.parseInt(request.getParameter("board_p_seq"));
		int reple_seq = Integer.parseInt(request.getParameter("reple_seq"));
		//int user_seq = Integer.parseInt(request.getParameter("user_seq"));
		String content = request.getParameter("content");
		int exp_yn = 1;
		/*if(request.getParameter("exp_yn").equals("on")){
			exp_yn = 1;
		}else {
			exp_yn = -1;
		}*/
		String date = getDate();
		
		String search_level = String.valueOf(reple_seq-1)+"-";
		List<ADMIN_Board_RepleDTO> board_LevR_List = boardService.getBoard_LevR_List(search_level);
		for(ADMIN_Board_RepleDTO brDTO : board_LevR_List) {
			ADMIN_Board_RepleDTO ibrDTO = new ADMIN_Board_RepleDTO();
			String split[] = brDTO.getBoard_reple_level().split("-");
			ibrDTO.setReple_seq(brDTO.getReple_seq());
			ibrDTO.setBoard_reple_level(split[0]+"-"+String.valueOf(Integer.parseInt(split[1])+1));
			boardService.board_R_LCreateUpdate(ibrDTO);
		}
		
		ADMIN_Board_RepleDTO brDTO = new ADMIN_Board_RepleDTO();
		brDTO.setBoard_p_seq(board_p_seq);
		brDTO.setUser_seq(0);
		brDTO.setBoard_reple_content(content);
		brDTO.setReg_date(date);
		brDTO.setBoard_reple_level(search_level+"1");
		brDTO.setExp_yn(exp_yn);
		
		int result = boardService.board_R_Create(brDTO);
		
		String msg="";
		
		if(result>0) {
			msg = "댓글이 저장되었습니다.";
		}else {
			msg = "댓글 저장 실패";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("board_p_seq", board_p_seq);
		
		return board_p_info(request, model);
	}
	
	//댓글수정
	@RequestMapping(value="admin/board_reple/board_reple_edit", method=RequestMethod.POST)
	public String board_reple_edit(HttpServletRequest request, Model model) throws Exception{
		int board_p_seq = Integer.parseInt(request.getParameter("board_p_seq"));
		int reple_seq = Integer.parseInt(request.getParameter("reple_seq"));
		String content = request.getParameter("content");
		int exp_yn=1;
		/*if(request.getParameter("exp_yn").equals("on")){
			exp_yn = 1;
		}else {
			exp_yn = -1;
		}*/
		ADMIN_Board_RepleDTO brDTO = new ADMIN_Board_RepleDTO();
		brDTO.setReple_seq(reple_seq);
		brDTO.setBoard_reple_content(content);
		brDTO.setExp_yn(exp_yn);
		
		int result = boardService.board_R_Edit(brDTO);
		
		String msg="";
		
		if(result>0) {
			msg = "댓글이 수정되었습니다.";
		}else {
			msg = "댓글 수정 실패";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("board_p_seq", board_p_seq);
		
		return board_p_info(request, model);
	}
	
	//댓글삭제
	@RequestMapping(value="admin/board_reple/board_reple_delete", method=RequestMethod.GET)
	public String board_reple_delete(HttpServletRequest request, Model model) throws Exception{
		String board_p_seq = request.getParameter("board_p_seq");
		String reple_seq = request.getParameter("reple_seq");
		boardService.board_R_Delete(Integer.parseInt(reple_seq));
		model.addAttribute(board_p_seq);
		return board_p_info(request, model);
	}
}

