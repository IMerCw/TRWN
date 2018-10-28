package poly.service.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.seller.SELLER_BoardDTO;
import poly.dto.seller.SELLER_ReviewDTO;
import poly.persistance.mapper.SELLER_BoardMapper;
import poly.service.SELLER_IBoardService;

@Service("SELLER_BoardService")//BoardService 이름입니다 .
public class SELLER_BoardService implements SELLER_IBoardService {

	@Resource(name="SELLER_BoardMapper")
	private SELLER_BoardMapper boardMapper;

	@Override
	public int insertBoardDTO(SELLER_BoardDTO bDTO) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.insertBoardDTO(bDTO);
	}

	@Override
	public List<SELLER_BoardDTO> getBoardList() throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.getBoardList();
	}

	@Override
	public SELLER_BoardDTO getBoardDetail(SELLER_BoardDTO bDTO) throws Exception {
		System.out.println("bDTO service1 :" +bDTO.getBoardPSeq());
		boardMapper.updateViewCount(bDTO);
		System.out.println("bDTO service2 :" +bDTO.getBoardPSeq());
		
		
		return boardMapper.getBoardDetail(bDTO);
	}
	@Override
	public List<SELLER_BoardDTO> getBoardNotice(SELLER_BoardDTO bDTO) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("service bDTO : " + bDTO.getBoardSeq());
		return boardMapper.getBoardNotice(bDTO);
	}

	@Override
	public List<SELLER_BoardDTO> getCustomerCenter(SELLER_BoardDTO bDTO) throws Exception {
		return boardMapper.getCustomerCenter(bDTO);
	}

	@Override
	public List<SELLER_BoardDTO> getBoardCommunity(SELLER_BoardDTO bDTO) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.getBoardCommunity(bDTO);
	}

	@Override
	public int deleteBoardDTO(SELLER_BoardDTO bDTO) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.deleteBoardDTO(bDTO);
	}

	@Override
	public int updateBoardDTO(SELLER_BoardDTO bDTO) throws Exception {
		System.out.println("bDTO  service : " +bDTO.getTitle());
		// TODO Auto-generated method stub
		return boardMapper.updateBoardDTO(bDTO);
	}

	@Override
	public int insertReReg(SELLER_ReviewDTO rDTO) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("rDTO service p: " + rDTO.getBoardPSeq());
		System.out.println("rDTO service c: " + rDTO.getContent());
		System.out.println("rDTO service e: " + rDTO.getExpYn());
		System.out.println("rDTO service l: " + rDTO.getReLevel());
		System.out.println("rDTO service r: " + rDTO.getRepleSeq());
		System.out.println("rDTO service u : " + rDTO.getUserSeq());
		return boardMapper.insertReReg(rDTO);
	}

	@Override
	public List<SELLER_ReviewDTO> getReList(SELLER_ReviewDTO rDTO) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.getReList(rDTO);
	}

	@Override
	public SELLER_ReviewDTO getUpreple(SELLER_ReviewDTO rDTO) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.getUpreple(rDTO);
	}

	@Override
	public int updateRe(SELLER_ReviewDTO rDTO) throws Exception {
		// TODO Auto-generated method stub
		
		return boardMapper.updateRe(rDTO);
	}

	@Override
	public int deleteRe(SELLER_ReviewDTO rDTO) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.deleteRe(rDTO);
	}

	@Override
	public String getBoardLevel() throws Exception {
		return boardMapper.getBoardLevel();
	}

	@Override
	public int board_P_CreateUpdate(int boardLevel) throws Exception {
		return boardMapper.board_P_CreateUpdate(boardLevel);
				
	}

	
	
}
