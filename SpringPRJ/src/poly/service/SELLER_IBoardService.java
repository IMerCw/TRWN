package poly.service;

import java.util.List;

import poly.dto.seller.SELLER_BoardDTO;
import poly.dto.seller.SELLER_ReviewDTO;


public interface SELLER_IBoardService {
	public int insertBoardDTO(SELLER_BoardDTO bDTO) throws Exception;
	
	public List<SELLER_BoardDTO> getBoardList() throws Exception;
	
	public SELLER_BoardDTO getBoardDetail(SELLER_BoardDTO bDTO) throws Exception;
	
	public List<SELLER_BoardDTO> getBoardNotice(SELLER_BoardDTO bDTO) throws Exception;//공지사항
	
	public List<SELLER_BoardDTO> getCustomerCenter(SELLER_BoardDTO bDTO) throws Exception;//고객센터 ajax
	
	public List<SELLER_BoardDTO> getBoardCommunity(SELLER_BoardDTO bDTO) throws Exception;// 커뮤니티 ajax
	
	public int deleteBoardDTO(SELLER_BoardDTO bDTO) throws Exception;
	
	public int updateBoardDTO(SELLER_BoardDTO bDTO) throws Exception;
	
	
	public int insertReReg(SELLER_ReviewDTO rDTO)throws Exception;//댓글 등록
	
	public List<SELLER_ReviewDTO> getReList(SELLER_ReviewDTO rDTO)throws Exception;//댓글 리스트 불러오기
	
	public SELLER_ReviewDTO getUpreple(SELLER_ReviewDTO rDTO)throws Exception; //댓글 업데이트 뷰
	
	public int updateRe(SELLER_ReviewDTO rDTO)throws Exception;//댓글 업데이트
	
	public int deleteRe(SELLER_ReviewDTO rDTO)throws Exception;//댓글 삭제

	public String getBoardLevel() throws Exception;

	public int board_P_CreateUpdate(int boardLevel) throws Exception;
	
	
	
}
