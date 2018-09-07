package poly.service;

import java.util.List;
import poly.dto.consumer.CONSUMER_BoardCounterDTO;


import poly.dto.consumer.CONSUMER_BoardDTO;
import poly.dto.consumer.CONSUMER_BoardRepleDTO;

public interface CONSUMER_IBoardService {
	
	public int insertBoardDTO(CONSUMER_BoardDTO bDTO /*반환형이 DTO이라는 뜻*/) throws Exception;
	public List<CONSUMER_BoardDTO> getBoardList(String userSeq) throws Exception;
	public CONSUMER_BoardDTO getBoardDetail(String boardPSeq /*반환형이 String이라는 뜻*/) throws Exception;
	public int deleteBoard(String boardPSeq) throws Exception;
	public int updateBoard(CONSUMER_BoardDTO bDTO) throws Exception;
	public List<CONSUMER_BoardDTO> getNoticeList() throws Exception;
	public int insertComment(CONSUMER_BoardRepleDTO rDTO) throws Exception;
	public List<CONSUMER_BoardRepleDTO> getComment(CONSUMER_BoardRepleDTO rDTO) throws Exception;
	public List<CONSUMER_BoardRepleDTO> commentList(String boardPSeq) throws Exception;
	public CONSUMER_BoardDTO getNoticeDetail(String boardPSeq) throws Exception;
	public List<CONSUMER_BoardDTO> getNoticeListMore(CONSUMER_BoardCounterDTO bcDTO) throws Exception;
}
