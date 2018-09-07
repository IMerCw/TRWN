package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.consumer.CONSUMER_BoardCounterDTO;
import poly.dto.consumer.CONSUMER_BoardDTO;
import poly.dto.consumer.CONSUMER_BoardRepleDTO;
import poly.persistance.mapper.CONSUMER_BoardMapper;
import poly.service.CONSUMER_IBoardService;

@Service("CONSUMER_BoardService")
public class CONSUMER_BoardService implements CONSUMER_IBoardService{ 
	@Resource(name="CONSUMER_BoardMapper")
	private CONSUMER_BoardMapper boardMapper;
	
	//게시판
	@Override
	public int insertBoardDTO(CONSUMER_BoardDTO bDTO) throws Exception{
		return boardMapper.insertBoardDTO(bDTO);
	}

	@Override
	public List<CONSUMER_BoardDTO> getBoardList(String userSeq) throws Exception {
		return boardMapper.getBoardList(userSeq);
	}

	@Override
	public CONSUMER_BoardDTO getBoardDetail(String boardPSeq) throws Exception {
		return boardMapper.getBoardDetail(boardPSeq);
	}
	
	@Override
	public int deleteBoard(String boardPSeq) throws Exception{
		return boardMapper.deleteBoard(boardPSeq);
	}

	@Override
	public int updateBoard(CONSUMER_BoardDTO bDTO) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.updateBoard(bDTO);
	}

	@Override
	public List<CONSUMER_BoardDTO> getNoticeList() throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.getNoticeList();
	}

	//댓글
	@Override
	public int insertComment(CONSUMER_BoardRepleDTO rDTO) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.insertComment(rDTO);
	}

	@Override
	public List<CONSUMER_BoardRepleDTO> getComment(CONSUMER_BoardRepleDTO rDTO) throws Exception{
		boardMapper.insertComment(rDTO);
		System.out.println("boardPSeq : " + rDTO.getBoardPSeq());
		System.out.println("UserSeq : " + rDTO.getUserSeq());
		System.out.println("Content : " + rDTO.getContent());
		return boardMapper.getComment(rDTO);
	}
	
	
	@Override
	public List<CONSUMER_BoardRepleDTO> commentList(String boardPSeq) throws Exception {
	
		return boardMapper.commentList(boardPSeq);
	}

	@Override
	public CONSUMER_BoardDTO getNoticeDetail(String boardPSeq) throws Exception {
		return boardMapper.getNoticeDetail(boardPSeq);
	}


	@Override
	public List<CONSUMER_BoardDTO> getNoticeListMore(CONSUMER_BoardCounterDTO bcDTO) throws Exception {
		return boardMapper.getNoticeListMore(bcDTO);
	}
}
