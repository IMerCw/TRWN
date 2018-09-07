package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.consumer.CONSUMER_BoardCounterDTO;
import poly.dto.consumer.CONSUMER_BoardDTO;
import poly.dto.consumer.CONSUMER_BoardRepleDTO;

@Mapper("CONSUMER_BoardMapper")
public interface CONSUMER_BoardMapper {
	public int insertBoardDTO(CONSUMER_BoardDTO bDTO) throws Exception;
	public List<CONSUMER_BoardDTO> getBoardList(String userSeq) throws Exception;
	public CONSUMER_BoardDTO getBoardDetail(String boardPSeq) throws Exception;
	public int deleteBoard(String boardPSeq) throws Exception;
	public int updateBoard(CONSUMER_BoardDTO bDTO) throws Exception;
	public List<CONSUMER_BoardDTO> getNoticeList() throws Exception;
	public int insertComment(CONSUMER_BoardRepleDTO rDTO) throws Exception;
	public List<CONSUMER_BoardRepleDTO> getComment(CONSUMER_BoardRepleDTO rDTO) throws Exception;
	public List<CONSUMER_BoardRepleDTO> commentList(String boardPSeq) throws Exception;
	public CONSUMER_BoardDTO getNoticeDetail(String boardPSeq) throws Exception;
	public List<CONSUMER_BoardDTO> getNoticeListMore(CONSUMER_BoardCounterDTO bcDTO) throws Exception;
}