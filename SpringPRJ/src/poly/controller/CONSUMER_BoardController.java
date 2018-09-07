package poly.controller;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.ResponseBody;

import poly.dto.consumer.CONSUMER_BoardCounterDTO;
import poly.dto.consumer.CONSUMER_BoardDTO;
import poly.dto.consumer.CONSUMER_BoardRepleDTO;
import poly.dto.consumer.CONSUMER_FtLikeDTO;
import poly.dto.consumer.CONSUMER_UserDTO;
import poly.service.CONSUMER_IBoardService;
import poly.service.CONSUMER_IUserService;
import poly.util.CmmUtil;
import poly.util.UtilTime;

@Controller
public class CONSUMER_BoardController {
	
	private Logger log = Logger.getLogger(this.getClass());
	
	String msg = "";
	String url = "";
	
	@Resource(name="CONSUMER_BoardService")
	private CONSUMER_IBoardService boardService;
	
	@Resource(name="CONSUMER_UserService")
	private CONSUMER_IUserService userService;
	
	//게시글 작성
	@RequestMapping(value="consumer/board/boardWrite")
	public String boardWrtie(HttpServletRequest request, Model model) throws Exception{
		
		log.info("boardWrite Start");
		
		String userEmail = request.getParameter("userEmail");
		log.info("getUserEamil" + userEmail);
		
		
		if("".equals(userEmail)) {
			model.addAttribute("msg","로그인 후 이용하시기 바랍니다.");
			model.addAttribute("url","/cmmn/main.do");
			log.info("이전 페이지 : " + request.getHeader("referer"));		//이전페이지 주소를 불러오는 함수
			return "/cmmn/alert";
		}
		
		log.info("이전 페이지 : " + request.getHeader("referer"));		//이전페이지 주소를 불러오는 함수
		log.info("boardWrite End");
		return "/consumer/board/boardWrite";
	}
	
	//게시글 작성하기
	@RequestMapping(value="consumer/board/boardWriteProc", method=RequestMethod.POST)
	public String boardWriteProc(HttpServletRequest request, Model model) throws Exception{
		log.info("boardWriteProc Start");
		
		String title = request.getParameter("title");
		log.info("getTitle : " + title);
		String boardContent = request.getParameter("boardContent");
		log.info("getBoardContent : " + boardContent);
		String boardSeq = request.getParameter("boardSeq");
		log.info("getBoardSeq : " + boardSeq);
		String userEmail = request.getParameter("userEmail");
		log.info("getUesrEmail : " + userEmail);
		String userSeq = request.getParameter("userSeq");
		log.info("getUserSeq : " + userSeq);
		String regDate = UtilTime.getDateYMDhms();
		
		//변수들을 각각 넘기면 코드가 길어지고 귀찮으니까 DTO를 사용한다.
		CONSUMER_BoardDTO bDTO = new CONSUMER_BoardDTO();
		bDTO.setTitle(title);
		log.info("setTitle : " + bDTO.getTitle());
		bDTO.setContent(boardContent);
		log.info("setBoardContent : " + bDTO.getContent());
		bDTO.setBoardSeq(boardSeq);
		log.info("setBoardSeq : " + bDTO.getBoardSeq());
		bDTO.setUserSeq(userSeq);
		log.info("setUserSeq : " + bDTO.getUserSeq());
		bDTO.setRegDate(regDate);
		log.info("setRegDate: " + bDTO.getRegDate());
		
		int result = boardService.insertBoardDTO(bDTO);
		log.info("result full!!");
		
		if(result != 0) {
			msg = "게시글이 작성되었습니다.";
			url = "/consumer/board/boardList.do?userEmail=" + userEmail + "&userSeq=" + userSeq;
		} else {
			msg = "작성 실패";
			url = "/consumer/board/boardWrite.do";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		log.info("이전 페이지 : " + request.getHeader("referer"));		//이전페이지 주소를 불러오는 함수
		
		log.info("boardWriteProc End");
		return "/cmmn/alert";
	}
	
	//고객센터 보기
	@RequestMapping(value="consumer/board/boardList")
	public String boardList(HttpServletRequest request, Model model, HttpSession session) throws Exception{
		log.info("boardList Start");
		
		String userSeq = CmmUtil.nvl((String)session.getAttribute("userSeq"));
		if("".equals(userSeq)) {
			model.addAttribute("msg", "로그인 후 이용하시기 바랍니다.");
			model.addAttribute("url", "/cmmn/main.do");
			return "/cmmn/alert";
		}
		
		log.info("userSeq 아이디 받기 : " + userSeq);
															
		List<CONSUMER_BoardDTO> bList = boardService.getBoardList(userSeq); //현재 로그인된 회원번호와 일치하는 게시물만 가져옴
		model.addAttribute("bList", bList);
		
		//현재 날짜를 보냅니다.
		String now = UtilTime.getDateYMDhms().split("/")[0];
		String []today = now.split("\\.");
		System.out.println(today[2]);
		model.addAttribute("today", today);
		
		log.info("boardList End");
		return "/consumer/board/boardList";
	}
	
	//공지사항 보기
	@RequestMapping(value="consumer/board/noticeList")
	public String noticeList(HttpServletRequest request, Model model) throws Exception{
		
		log.info("noticeList Start");
		
/*		String userEmail = CmmUtil.nvl(request.getParameter("userEmail"));
		log.info("userEmail 아이디 받기 :" + userEmail);
		
		UserDTO uDTO = new UserDTO();
		uDTO.setUserEmail(userEmail);
		log.info(uDTO.getUserEmail());*/
		
		List<CONSUMER_BoardDTO> bList = boardService.getNoticeList();
		model.addAttribute("bList", bList);
		
		//현재 날짜를 보냅니다.
		String now = UtilTime.getDateYMDhms().split("/")[0];
		String []today = now.split("\\.");
		System.out.println(today[2]);
		model.addAttribute("today", today);
		
		log.info("noticeList End");
		return "/consumer/board/noticeList";
	}
	
	//게시글 상세보기
	@RequestMapping(value="consumer/board/boardDetail", method=RequestMethod.GET)
	public String boardDetail(HttpServletRequest request, Model model) throws Exception{
		
		log.info("boardDetail Start");
		String boardPSeq = CmmUtil.nvl(request.getParameter("boardPSeq"));
		log.info("boardPSeq : " + boardPSeq);
		String userSeq = CmmUtil.nvl(request.getParameter("userSeq"));
		log.info("userSeq : " + userSeq);
		String content = CmmUtil.nvl(request.getParameter("content"));
		log.info("content : " + content);
		String boardSeq = CmmUtil.nvl(request.getParameter("boardSeq"));
		log.info("boardSeq : " + boardSeq);
	
		CONSUMER_BoardRepleDTO rDTO = new CONSUMER_BoardRepleDTO();
		
		rDTO.setBoardPSeq(boardPSeq);
	    log.info("리뷰 rDTO getboardPSeq : " + rDTO.getBoardPSeq());
		rDTO.setUserSeq(userSeq);
		log.info("리뷰 rDTO getUserSeq : " + rDTO.getUserSeq());
		rDTO.setContent(content);
		log.info("리뷰 rDTO getContent : "+rDTO.getContent());
		
		//공지사항 게시글 자세히 보기
		if(boardSeq.equals("1")) {
			CONSUMER_BoardDTO bDTO = boardService.getNoticeDetail(boardPSeq);
			model.addAttribute("bDTO", bDTO);
			return "/consumer/board/noticeDetail";
		}
		
		List<CONSUMER_BoardRepleDTO> rList = boardService.commentList(boardPSeq);
		model.addAttribute("rList", rList);
		
		CONSUMER_BoardDTO bDTO = boardService.getBoardDetail(boardPSeq);
		
		model.addAttribute("bDTO", bDTO);
		log.info("boardSeq : " + bDTO.getBoardSeq());
		log.info("boardDetail End");
		
		return "/consumer/board/boardDetail";
	}
	
	
	//게시글 삭제
	@RequestMapping(value="consumer/board/boardDelete", method=RequestMethod.GET)
	public String deleteBoard(HttpServletRequest request, Model model) throws Exception{
		log.info("boardDelete Start");
		
		String boardPSeq = request.getParameter("boardPSeq");
		log.info("boardPSeq : " + boardPSeq);
		String userEmail = request.getParameter("userEmail");
		log.info("getUesrEmail : " + userEmail);
		String userSeq = request.getParameter("userSeq");
		log.info("getUserSeq : " + userSeq);
		
		int result = boardService.deleteBoard(boardPSeq);
		
		if(result != 0) {
			msg = "삭제되었습니다.";
			url = "/consumer/board/boardList.do?userEmail=" + userEmail + "&userSeq=" + userSeq;	
		} else {
			msg = "삭제되지 않았습니다.";
			url = "/consumer/board/boardList.do?userEmail=" + userEmail + "&userSeq=" + userSeq;	
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		log.info("이전 페이지 : " + request.getHeader("referer"));		//이전페이지 주소를 불러오는 함수
		
		log.info("boardDelete End");
		return "/cmmn/alert";
	}
	
	//게시글 수정
	@RequestMapping(value="consumer/board/boardUpdateView")
	public String updateBoard(HttpServletRequest request,HttpSession session, Model model) throws Exception{
		log.info("boardUpdateView Start");
		
		String boardPSeq = request.getParameter("boardPSeq");
		log.info("boardPSeq : " + boardPSeq);
		CONSUMER_BoardDTO bDTO = boardService.getBoardDetail(boardPSeq);
		
		model.addAttribute("bDTO", bDTO);
		log.info("이전 페이지 : " + request.getHeader("referer"));		//이전페이지 주소를 불러오는 함수
		
		log.info("boardUpdateView End");
		return "/consumer/board/boardUpdateView";
	}
	
	//게시글 수정하기
	@RequestMapping(value="consumer/board/boardUpdateViewProc")
	public String updateBoardProc(HttpServletRequest request, Model model) throws Exception{
		log.info("boardUpdateViewProc Start");
		
		String boardPSeq = request.getParameter("boardPSeq");
		log.info("boardPSeq : " + boardPSeq);
		String title = request.getParameter("title");
		log.info("title : " + title);
		String boardContent = request.getParameter("boardContent");
		log.info("boardContent : " + boardContent);
		String userEmail = request.getParameter("userEmail");
		log.info("getUesrEmail : " + userEmail);
		String userSeq = request.getParameter("userSeq");
		log.info("getUserSeq : " + userSeq);
		
		CONSUMER_BoardDTO bDTO = new CONSUMER_BoardDTO();
		bDTO.setBoardPSeq(boardPSeq);
		bDTO.setTitle(title);
		bDTO.setContent(boardContent);
		
		int result = boardService.updateBoard(bDTO);
		log.info(result);
		if(result != 0) {
			msg = "수정되었습니다.";
			url = "/consumer/board/boardList.do?userEmail=" + userEmail + "&userSeq=" + userSeq;
		} else {
			msg = "수정되지 않았습니다.";
			url = "/consumer/board/boardUpdateView.do?boardPSeq=" + boardPSeq + "&userEmail=" + userEmail + "&userSeq=" + userSeq;
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		log.info("이전 페이지 : " + request.getHeader("referer"));		//이전페이지 주소를 불러오는 함수
		
		log.info("boardUpdateViewProc End");
		return "/cmmn/alert";
		
	}
	
	//답글
	@RequestMapping(value="consumer/board/reple", method=RequestMethod.POST)
	public @ResponseBody List<CONSUMER_BoardRepleDTO> addComment(HttpServletRequest request, Model model) throws Exception{
		log.info("comment Start");
		
		String boardPSeq = CmmUtil.nvl(request.getParameter("boardPSeq"));
		log.info("boardPSeq : " + boardPSeq);
		String userSeq = CmmUtil.nvl(request.getParameter("userSeq"));
		log.info("userSeq : " + userSeq);
		String content = CmmUtil.nvl(request.getParameter("content"));
		log.info("content : " + content);
	
		
		CONSUMER_BoardRepleDTO rDTO = new CONSUMER_BoardRepleDTO();

		rDTO.setBoardPSeq(boardPSeq);
	    log.info("리뷰 rDTO getboardPSeq : " + rDTO.getBoardPSeq());
		rDTO.setUserSeq(userSeq);
		log.info("리뷰 rDTO getUserSeq : " + rDTO.getUserSeq());
		rDTO.setContent(content);
		log.info("리뷰 rDTO getContent : "+rDTO.getContent());
		
		List<CONSUMER_BoardRepleDTO> rList = boardService.getComment(rDTO);		
		
		model.addAttribute("rList", rList);
		
		log.info("rList 시작:"+rList);
		log.info("이전 페이지 : " + request.getHeader("referer"));		//이전페이지 주소를 불러오는 함수
		
		log.info("comment End");
		return rList;
		
	}
	

	
	//게시글 리스트 더 불러오기 - AJAX
	@RequestMapping(value="consumer/board/getListMore", method=RequestMethod.POST)
	public @ResponseBody List<CONSUMER_BoardDTO> getListMore(HttpServletRequest request, Model model, HttpServletResponse response )throws Exception{
		log.info(this.getClass() + "consumer/board/getListMore start !!!");
		String boardSeq = CmmUtil.nvl(request.getParameter("boardSeq"));
		String count = CmmUtil.nvl(request.getParameter("count"));
		
		log.info("boardSeq ........" + boardSeq);
		log.info("count ........" + count);
		CONSUMER_BoardCounterDTO bcDTO = new CONSUMER_BoardCounterDTO();
		bcDTO.setFirstCounter(5 * Integer.parseInt(count));
		bcDTO.setLastCounter(5); //갯수
		log.info(bcDTO.getFirstCounter());
		log.info(bcDTO.getLastCounter());
		List<CONSUMER_BoardDTO> bDTOmore = boardService.getNoticeListMore(bcDTO);
		log.info("bDTOmore 확인");
		for(int i = 0; i < bDTOmore.size(); i++) {
			log.info(bDTOmore.get(i).getTitle());
		}
		
		
		log.info(this.getClass() + "consumer/board/getListMore end !!!");
		return bDTOmore;
		
	}
	
	/*@RequestMapping(value="board/commentList", method=RequestMethod.POST)
	public @ResponseBody List<BoardRepleDTO> commenList(HttpServletRequest request, Model model) throws Exception {
		
		log.info("commentList Start");
		
		
		List<BoardRepleDTO> rList = boardService.commentList();
		
		log.info("commentList End");
		return rList;
	}*/
	
}