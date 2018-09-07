package poly.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;


import poly.dto.seller.SELLER_BoardDTO;
import poly.dto.seller.SELLER_ReviewDTO;
import poly.service.SELLER_IBoardService;
import poly.util.CmmUtil;

@Controller
public class SELLER_BoardController {
	
	private Logger log = Logger.getLogger(this.getClass());
	/*로그를 찍고 파일로 남깁니다 .*/
	
	//어노테이션 선언?? 서비스를 사용하기 위해 
	@Resource(name="SELLER_BoardService")
	private SELLER_IBoardService BoardService;
	
	//게시판 글쓰기 화면
	@RequestMapping(value="/seller/board/boardWrite")
	public String boardWrite(HttpServletRequest request, Model model) {
		log.info(this.getClass() + "boardwrite start !!");
		
		String boardSeq = CmmUtil.nvl( request.getParameter("boardSeq") );
		log.info("boardWriteSeq :" + boardSeq);
		
		model.addAttribute("boardSeq",boardSeq);
		log.info(this.getClass() + "boardwrite end !!");
		return "/seller/board/boardWrite";
	}
	
	
	//공지사항 insert 코드 
	@RequestMapping(value="/seller/board/boardWriteProc",method=RequestMethod.POST)
	public String boardWriteProc(HttpServletRequest request, Model model ) throws Exception{
		String Title = CmmUtil.nvl( request.getParameter("Title") );
		log.info("Title : " + Title);
		String boardContent = CmmUtil.nvl( request.getParameter("boardContent") );
		log.info("boardContent : " + boardContent);
		String regDate = CmmUtil.nvl( request.getParameter("regDate") );
		log.info("regDate : " + regDate);
		String boardSeq = CmmUtil.nvl( request.getParameter("boardSeq") );
		log.info("boardSeq : "+ boardSeq);// 공지사항 value = 1
		String userSeq =CmmUtil.nvl( request.getParameter("userSeq") );
		log.info("userSeq : "+userSeq);
		
		
		SELLER_BoardDTO bDTO = new SELLER_BoardDTO();
		bDTO.setTitle(Title);
		bDTO.setContent(boardContent);
		bDTO.setRegDate(regDate);
		bDTO.setBoardSeq(boardSeq);// 게시판 공지사항 구분 번호 1
		bDTO.setUserSeq(userSeq);
		
		log.info("bDTOuserSeq : "+bDTO.getUserSeq());
		
		int result = BoardService.insertBoardDTO(bDTO);
		
		String msg = "";
		String url = "";
		
		if(result != 0 ) {
			//게시판 글쓰기가 정상적으로 이루어진 상태 
			msg="등록에 성공하셨습니다";
			url="/seller/main.do";
		}else {
			//글쓰기가 이루어지지 않은 상태
			msg="글쓰기 실패";
			url="/seller/main.do";
		}
		model.addAttribute("msg",msg);
		model.addAttribute("url",url);
		
		return "/cmmn/alert";
	}
	//게시판 목록 select 
	@RequestMapping(value="/seller/board/boardList")
	public String boardList(Model model, HttpServletResponse resp) throws Exception{
		
		/*List<BoardDTO> bList = BoardService.getBoardList();
		
		model.addAttribute("bList", bList);	
		
		
		log.info("bList 70줄 : " + bList.get(0).getTitle());
		log.info("bList 70줄 : " + bList.get(0).getUserNick());*/
		
		
		return "/seller/board/boardList";
	}
	//공지사항 ajax
		@RequestMapping(value="/seller/board/boardNotice")
		public @ResponseBody List<SELLER_BoardDTO> getBoardNotice(HttpServletRequest request, HttpServletResponse response) throws Exception{
			log.info(this.getClass() + "=========.boardNotice start!!!");
			
			String boardSeq = CmmUtil.nvl(request.getParameter("boardSeq"));
			log.info("notice controller boardSeq : " + boardSeq);
			
			SELLER_BoardDTO bDTO = new SELLER_BoardDTO();
			bDTO.setBoardSeq(boardSeq);
			
			log.info("getDTO : "+bDTO.getBoardSeq());
			
			List<SELLER_BoardDTO> bList = BoardService.getBoardNotice(bDTO);
			if(bList == null) {
				 bList = (List<SELLER_BoardDTO>) new SELLER_BoardDTO();
			}
			
			
			//ajax시에 통신이 되는지 확인하는 방법임ㄴ
			//resp.getWriter().println("ajax success");
			log.info("getList"+bList.get(0).getBoardSeq());
			
			log.info(this.getClass() + "========.boardNotice end!!!");
			return bList;
		}
	//고객센터 ajax
	@RequestMapping(value="/seller/board/boardCustomerCenter")
	public @ResponseBody List<SELLER_BoardDTO> boardAjax(HttpServletRequest req, HttpServletResponse resp) throws Exception{
		log.info(this.getClass() + ".==========CustomerCenter start!!!");
		
		String boardSeq = CmmUtil.nvl(req.getParameter("boardSeq"));
		log.info("customerCenter controller boardSeq : " + boardSeq);
		
		
		SELLER_BoardDTO bDTO = new SELLER_BoardDTO();
		bDTO.setBoardSeq(boardSeq);
		
		List<SELLER_BoardDTO> bList = BoardService.getCustomerCenter(bDTO);
		
		//ajax시에 통신이 되는지 확인하는 방법임ㄴ
		//resp.getWriter().println("ajax success");
		
		log.info(this.getClass() + "===========.CustomerCenter end!!!");
		return bList;
	}
	//커뮤니티 ajax
	@RequestMapping(value="/seller/board/boardCommunity")
	public @ResponseBody List<SELLER_BoardDTO> boardCommunity(HttpServletRequest request, HttpServletResponse response) throws Exception{
		log.info(this.getClass() + "==============Comuunity start !!!");
		
		String boardSeq = CmmUtil.nvl(request.getParameter("boardSeq"));
		log.info(" boardCommunity :  " + boardSeq);
		
		SELLER_BoardDTO bDTO = new SELLER_BoardDTO();
		bDTO.setBoardSeq(boardSeq);
		
		List<SELLER_BoardDTO> bList = BoardService.getBoardCommunity(bDTO);
		for(int i=0; i< bList.size(); i++) {
			log.info("bList.get" + i + ":" + bList.get(i).getBoardPSeq());
		}
		
		log.info(this.getClass() + "============Comuunity end !!!");
		return bList;
		
	}
	
	//상세보기 코드 
		@RequestMapping(value="/seller/board/boardDetail", method=RequestMethod.GET)
		public String boardDetail(HttpServletRequest request , Model model) throws Exception{
			log.info(this.getClass() + "BoardDetail start!!!");
			
			String boardPSeq = CmmUtil.nvl( request.getParameter("boardPSeq") );
			log.info("boardPSeq :" + boardPSeq);
			
			SELLER_BoardDTO bDTO = new SELLER_BoardDTO();
			bDTO.setBoardPSeq(boardPSeq);
			log.info("bDTOSeq 108줄 :" + boardPSeq);
			
			bDTO = BoardService.getBoardDetail(bDTO);
			System.out.println(bDTO.getBoardPSeq());
			
			SELLER_ReviewDTO rDTO = new SELLER_ReviewDTO();
			rDTO.setBoardPSeq(boardPSeq);
			List<SELLER_ReviewDTO> rList = BoardService.getReList(rDTO);
			
			
			model.addAttribute("bDTO",bDTO);
			log.info("bDTOseq 114줄 :" + bDTO.getBoardPSeq());
			log.info("bDTOuserNick 178줄 :" + bDTO.getUserNick());
			model.addAttribute("rList",rList);
		
			bDTO = null;
			rDTO = null;
			rList = null;
			
			log.info(this.getClass() + "boardDetail end!!");
			return "/seller/board/boardDetail";
			
		}
		
		//게시판 delete 코드
		@RequestMapping(value="/seller/board/boardDelete", method=RequestMethod.GET)
		public String boardDelete(HttpServletRequest request, Model model) throws Exception{
			log.info(this.getClass()+"boardDelete start!!");
			String boardPSeq = CmmUtil.nvl( request.getParameter("boardPSeq"));
			log.info("deleteSeq : "+ boardPSeq );
			
			SELLER_BoardDTO bDTO = new SELLER_BoardDTO();
			bDTO.setBoardPSeq(boardPSeq);
			log.info("bDTOdelSeq :" + bDTO.getBoardPSeq());
			
			int result = BoardService.deleteBoardDTO(bDTO);
	
			String msg ="";
			String url ="";
			
			if(result != 0) {
				//삭제가 정상적으로 이루어진 상태 
				msg="게시물 삭제에 성공하셨습니다.";
				url="/seller/main.do";
			}else {
				//삭제가 이루어지지 않은 상태 
				msg="게시뭉 삭제 실패";
				url="/seller/main.do";
			}
			model.addAttribute("msg",msg);
			model.addAttribute("url",url);
			
			msg= null;
			url= null;
			bDTO =null;
			log.info(this.getClass()+"boardDelete end!!");
			return "/cmmn/alert";
		
		}
		//게시판updateview
		@RequestMapping(value="/seller/board/boardUpdateView", method=RequestMethod.GET)
		public String boardUpdateView(HttpServletRequest request, Model model) throws Exception{
			log.info(this.getClass()+ "boardUpdateView start!!");
			String boardPSeq = CmmUtil.nvl( request.getParameter("boardPSeq"));
			
			SELLER_BoardDTO bDTO = new SELLER_BoardDTO();
			bDTO.setBoardPSeq(boardPSeq);
			log.info("bDTOup : " + bDTO.getBoardPSeq());
			
			SELLER_BoardDTO bDTO1 = BoardService.getBoardDetail(bDTO);
			log.info("bDTO1.Pseq" + bDTO1.getBoardPSeq());

			model.addAttribute("bDTO",bDTO1);
			
			bDTO = null;
			bDTO1 =null;
			
			log.info(this.getClass()+ "boardUpdateView end!!");
			return "/seller/board/boardUpdateView";
		}
		//update 게시판 글
		@RequestMapping(value="/seller/board/boardUpdateProc", method=RequestMethod.POST)
		public String boardUpdateProc(HttpServletRequest request, Model model)throws Exception{
			log.info(this.getClass()+ "updateProc start ~!!!");
			String Title = CmmUtil.nvl( request.getParameter("Title") );
			log.info("Title : " + Title);
			String boardContent = CmmUtil.nvl( request.getParameter("boardContent") );
			log.info("boardContent : " + boardContent);
			String regDate = CmmUtil.nvl( request.getParameter("regDate") );
			log.info("regDate : " + regDate);
			String boardSeq = CmmUtil.nvl(request.getParameter("boardSeq"));
			log.info("boardSeq : " + boardSeq);
			String boardPSeq = CmmUtil.nvl(request.getParameter("boardPSeq"));
			log.info("boardPSeq : " + boardPSeq);
			
			SELLER_BoardDTO bDTO = new SELLER_BoardDTO();
			bDTO.setTitle(Title);
			bDTO.setContent(boardContent);
			bDTO.setRegDate(regDate);
			bDTO.setBoardPSeq(boardPSeq);
			log.info("bDTO : " +bDTO.getTitle());
			
			int result = BoardService.updateBoardDTO(bDTO);
			
			log.info("bDTO 270줄: " + bDTO.getBoardPSeq());
			log.info("bDTO 271줄: " + bDTO.getTitle());
			
			if(result!=0) {
				// 앞에 redirect 방식으로 보내겠다 
				log.info(this.getClass() + "updateProc end ~!!");
				return "redirect:/seller/main.do";
			
			}else {
				
			
				String msg = "수정실패";
				String url = "/seller/board/boardUpdateView.do?boardSeq=" + boardSeq;
				model.addAttribute("msg",msg);
				model.addAttribute("url",url);
				log.info(this.getClass() + "updateProc end ~!!");
				return "/cmmn/alert";
			}
			
		}
		
		//댓글
		@RequestMapping(value="/seller/board/reWriteProc", method=RequestMethod.POST)
		public @ResponseBody List<SELLER_ReviewDTO> insertReReg(HttpServletRequest request)throws Exception{
			log.info(this.getClass() + " reWrite start !!!!!");
			
			String userSeq = CmmUtil.nvl(request.getParameter("userSeq"));
			log.info("userSeq : " + userSeq);
			String reContent = CmmUtil.nvl(request.getParameter("reContent"));
			log.info("reContent : " + reContent);
			String regDate = CmmUtil.nvl(request.getParameter("regDate"));
			log.info("regDate : " + regDate);
			String boardPSeq = CmmUtil.nvl(request.getParameter("boardPSeq"));
			log.info("boardPSeq : " + boardPSeq);
			String relevel = CmmUtil.nvl(request.getParameter("level"));
			log.info("level : " + relevel);
			
			SELLER_ReviewDTO rDTO = new SELLER_ReviewDTO();
			rDTO.setUserSeq(userSeq);
			rDTO.setContent(reContent);
			rDTO.setBoardPSeq(boardPSeq);
			rDTO.setReLevel(relevel);
			
			int result =  BoardService.insertReReg(rDTO);
			log.info("result : " + result);
			if(result == 1) {
				log.info("List start ");
			}else {
				log.info("error");
			}
			List<SELLER_ReviewDTO> rList = BoardService.getReList(rDTO);
			log.info("rLIst : " + rList);
			
			
			log.info(this.getClass() + " reWrite end !!!!");
			return rList;
		}
		
		//댓글 수정 뷰
		@RequestMapping(value="/seller/board/upReple", method=RequestMethod.POST)
		public @ResponseBody SELLER_ReviewDTO updateReple(HttpServletRequest request)throws Exception{
			log.info(this.getClass() + " upReple start ~~~~~~");
			
			String repleSeq = CmmUtil.nvl(request.getParameter("repleSeq"));
			log.info("repleSeq  : " + repleSeq);
			
			SELLER_ReviewDTO rDTO = new SELLER_ReviewDTO();
			rDTO.setRepleSeq(repleSeq);
			
			rDTO =BoardService.getUpreple(rDTO);
			log.info("rDTO get repleSeq: " + rDTO.getRepleSeq());
			log.info("rDTO get userSeq: " + rDTO.getUserSeq());
			log.info("rDTO get content : " + rDTO.getContent());
			log.info("rDTO get regDate : " + rDTO.getRegDate());
			
			
			log.info(this.getClass() + "upReple end !!!");
			return rDTO;
		}
		//댓글 수정 등록
		@RequestMapping(value="/seller/board/updateRe",method=RequestMethod.POST)
		public @ResponseBody List<SELLER_ReviewDTO> updateRe(HttpServletRequest request)throws Exception{
			log.info(this.getClass() + " updateRe start !!!!!");
			
			String repleSeq = CmmUtil.nvl(request.getParameter("repleSeq"));
			log.info("repleSeq : " + repleSeq);
			String userSeq = CmmUtil.nvl(request.getParameter("userSeqUp"));
			log.info("userSeqUp : " + userSeq);
			String reContent = CmmUtil.nvl(request.getParameter("reContentUp"));
			log.info("reContentUp : " + reContent);
			String regDate = CmmUtil.nvl(request.getParameter("regDateUp"));
			log.info("regDateUp : " + regDate);
			String boardPSeq = CmmUtil.nvl(request.getParameter("boardPSeqUp"));
			log.info("boardPSeqUp : " + boardPSeq);
			String relevel = CmmUtil.nvl(request.getParameter("levelUp"));
			log.info("levelUp : " + relevel);
				
			SELLER_ReviewDTO rDTO = new SELLER_ReviewDTO();
			rDTO.setRepleSeq(repleSeq);
			rDTO.setUserSeq(userSeq);
			rDTO.setContent(reContent);
			rDTO.setBoardPSeq(boardPSeq);
			rDTO.setReLevel(relevel);
			
			int result =  BoardService.updateRe(rDTO);
			log.info("result : " + result);
			if(result == 1) {
				log.info("List start ");
			}else {
				log.info("error");
			}
			
			List<SELLER_ReviewDTO> rList = BoardService.getReList(rDTO);
			log.info("rLIst : " + rList);
			
			
			log.info(this.getClass() + " updateRe end !!!!");
			return rList;
		}
		//
		@RequestMapping(value="/seller/board/delReple",method=RequestMethod.POST)
		public @ResponseBody List<SELLER_ReviewDTO> delReple(HttpServletRequest request) throws Exception{
			log.info(this.getClass() + "delReple start !!!!");
			String repleSeq = CmmUtil.nvl(request.getParameter("repleSeq"));
			log.info("repleSeq : " + repleSeq);
			
			SELLER_ReviewDTO rDTO = new SELLER_ReviewDTO();
			rDTO.setRepleSeq(repleSeq);
			
			rDTO = BoardService.getUpreple(rDTO);
			log.info("rDTO.get bpSeq : " + rDTO.getBoardPSeq());
			
			int result =  BoardService.deleteRe(rDTO);
			log.info("result : " + result);
			if(result == 1) {
				log.info("List start ");
			}else {
				log.info("error");
			}
		
			List<SELLER_ReviewDTO> rList = BoardService.getReList(rDTO);
			log.info("rLIst : " + rList);
			
			
			log.info(this.getClass() + "delReple end !!!!");
			return rList;
		}
	//
	

}
