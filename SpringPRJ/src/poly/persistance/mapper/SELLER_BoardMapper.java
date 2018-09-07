package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.seller.SELLER_BoardDTO;
import poly.dto.seller.SELLER_ReviewDTO;

@Mapper("SELLER_BoardMapper")

public interface SELLER_BoardMapper {
	public int insertBoardDTO(SELLER_BoardDTO bDTO) throws Exception;
	
	public List<SELLER_BoardDTO> getBoardList() throws Exception;
	
	public SELLER_BoardDTO getBoardDetail(SELLER_BoardDTO bDTO) throws Exception;//상세보기
	
	public void updateViewCount(SELLER_BoardDTO bDTO) throws Exception;//조회수 증가
	
	public List<SELLER_BoardDTO> getBoardNotice(SELLER_BoardDTO bDTO) throws Exception;
	
	public List<SELLER_BoardDTO> getCustomerCenter(SELLER_BoardDTO bDTO) throws Exception;//고객센터
	
	public List<SELLER_BoardDTO> getBoardCommunity(SELLER_BoardDTO bDTO) throws Exception;//커뮤니티
	
	public int deleteBoardDTO(SELLER_BoardDTO bDTO) throws Exception;//게시판 삭제
	
	public int updateBoardDTO(SELLER_BoardDTO bDTO) throws Exception;
	
	public int insertReReg(SELLER_ReviewDTO rDTO)throws Exception;//댓글 등록
	
	public List<SELLER_ReviewDTO> getReList(SELLER_ReviewDTO rDTO)throws Exception;//댓글 가져오기
	
	public SELLER_ReviewDTO getUpreple(SELLER_ReviewDTO rDTO)throws Exception;//댓글 업데이트  뷰
	
	public int updateRe(SELLER_ReviewDTO rDTO)throws Exception;//댓글 업데이트
	
	public int deleteRe(SELLER_ReviewDTO rDTO)throws Exception;//댓글 삭제 
	
}
