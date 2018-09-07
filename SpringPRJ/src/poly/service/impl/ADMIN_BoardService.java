package poly.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.admin.ADMIN_BoardDTO;
import poly.dto.admin.ADMIN_Board_PostDTO;
import poly.dto.admin.ADMIN_Board_RepleDTO;
import poly.persistance.mapper.ADMIN_BoardMapper;
import poly.persistance.mapper.ADMIN_Board_PostMapper;
import poly.persistance.mapper.ADMIN_Board_RepleMapper;
import poly.service.ADMIN_IBoardService;

@Service("ADMIN_BoardService")
public class ADMIN_BoardService implements ADMIN_IBoardService{
	
	@Resource(name="ADMIN_BoardMapper")
	private ADMIN_BoardMapper boardMapper;
	
	@Resource(name="ADMIN_Board_PostMapper")
	private ADMIN_Board_PostMapper board_PostMapper;
	
	@Resource(name="ADMIN_Board_RepleMapper")
	private ADMIN_Board_RepleMapper board_RepleMapper;

	//게시판 관리-------------------------------------------------------------------------------
	@Override
	public int board_Create(ADMIN_BoardDTO bDTO) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.board_Create(bDTO);
	}

	@Override
	public List<ADMIN_BoardDTO> getBoard_List() throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.getBoard_List();
	}
	
	@Override
	public List<ADMIN_BoardDTO> getBoard_Search(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.getBoard_Search(map);
	}

	@Override
	public ADMIN_BoardDTO getBoard_Detail(int board_Seq) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.getBoard_Detail(board_Seq);
	}

	@Override
	public int board_Edit(ADMIN_BoardDTO bDTO) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.board_Edit(bDTO);
	}

	@Override
	public int board_Delete(int board_Seq) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.board_Delete(board_Seq);
	}

	@Override
	public int board_Exp_yn(int board_Seq) throws Exception {
		// TODO Auto-generated method stub
		return boardMapper.board_Exp_yn(board_Seq);
	}

	
	//게시물 관리-------------------------------------------------------------------------------
	@Override
	public int board_P_Create(ADMIN_Board_PostDTO bpDTO) throws Exception {
		// TODO Auto-generated method stub
		return board_PostMapper.board_P_Create(bpDTO);
	}

	@Override
	public List<ADMIN_Board_PostDTO> getBoard_P_List() throws Exception {
		// TODO Auto-generated method stub
		return board_PostMapper.getBoard_P_List();
	}
	
	@Override
	public List<ADMIN_Board_PostDTO> getBoard_P_ALL_Search(ADMIN_Board_PostDTO bpDTO) throws Exception {
		// TODO Auto-generated method stub
		return board_PostMapper.getBoard_P_ALL_Search(bpDTO);
	}
	
	@Override
	public List<ADMIN_Board_PostDTO> getBoard_P_Search(ADMIN_Board_PostDTO bpDTO) throws Exception {
		// TODO Auto-generated method stub
		return board_PostMapper.getBoard_P_Search(bpDTO);
	}

	@Override
	public ADMIN_Board_PostDTO getBoard_P_Detail(int board_p_Seq) throws Exception {
		// TODO Auto-generated method stub
		return board_PostMapper.getBoard_P_Detail(board_p_Seq);
	}

	@Override
	public int board_P_Edit(ADMIN_Board_PostDTO bpDTO) throws Exception {
		// TODO Auto-generated method stub
		return board_PostMapper.board_P_Edit(bpDTO);
	}

	@Override
	public int board_P_Delete(int board_p_Seq) throws Exception {
		// TODO Auto-generated method stub
		return board_PostMapper.board_P_Delete(board_p_Seq);
	}

	@Override
	public int board_P_Exp_yn(int board_p_Seq) throws Exception {
		// TODO Auto-generated method stub
		return board_PostMapper.board_P_Exp_yn(board_p_Seq);
	}

	@Override
	public int board_P_CreateUpdate(int board_p_Seq) throws Exception {
		// TODO Auto-generated method stub
		return board_PostMapper.board_P_CreateUpdate(board_p_Seq);
	}

	@Override
	public List<ADMIN_Board_PostDTO> getBoard_LevP_List(String search_level) throws Exception {
		// TODO Auto-generated method stub
		return board_PostMapper.getBoard_LevP_List(search_level);
	}

	@Override
	public int board_P_LCreateUpdate(ADMIN_Board_PostDTO bpDTO) throws Exception {
		// TODO Auto-generated method stub
		return board_PostMapper.board_P_LCreateUpdate(bpDTO);
	}

	@Override
	public List<ADMIN_Board_PostDTO> getBoard_P_List_S(int board_seq) throws Exception {
		// TODO Auto-generated method stub
		return board_PostMapper.getBoard_P_List_S(board_seq);
	}

	@Override
	public int board_P_CountUP(int board_p_Seq) throws Exception {
		// TODO Auto-generated method stub
		return board_PostMapper.board_P_CountUP(board_p_Seq);
	}
	
	@Override
	public int board_P_Count(int board_p_Seq) throws Exception {
		// TODO Auto-generated method stub
		return board_PostMapper.board_P_Count(board_p_Seq);
	}
	
	//댓글 관리---------------------------------------------------------------------------------
	
	@Override
	public int board_R_Create(ADMIN_Board_RepleDTO brDTO) throws Exception {
		// TODO Auto-generated method stub
		return board_RepleMapper.board_R_Create(brDTO);
	}

	@Override
	public List<ADMIN_Board_RepleDTO> getBoard_R_List(int board_p_seq) throws Exception {
		// TODO Auto-generated method stub
		return board_RepleMapper.getBoard_R_List(board_p_seq);
	}

	@Override
	public int board_R_Edit(ADMIN_Board_RepleDTO brDTO) throws Exception {
		// TODO Auto-generated method stub
		return board_RepleMapper.board_R_Edit(brDTO);
	}

	@Override
	public int board_R_Delete(int reple_Seq) throws Exception {
		// TODO Auto-generated method stub
		return board_RepleMapper.board_R_Delete(reple_Seq);
	}

	@Override
	public int board_R_CreateUpdate(int reple_Seq) throws Exception {
		// TODO Auto-generated method stub
		return board_RepleMapper.board_R_CreateUpdate(reple_Seq);
	}

	@Override
	public List<ADMIN_Board_RepleDTO> getBoard_LevR_List(String search_level) throws Exception {
		// TODO Auto-generated method stub
		return board_RepleMapper.getBoard_LevR_List(search_level);
	}

	@Override
	public int board_R_LCreateUpdate(ADMIN_Board_RepleDTO brDTO) throws Exception {
		// TODO Auto-generated method stub
		return board_RepleMapper.board_R_LCreateUpdate(brDTO);
	}

	@Override
	public int board_R_Count(int board_p_Seq) throws Exception {
		// TODO Auto-generated method stub
		return board_RepleMapper.board_R_Count(board_p_Seq);
	}
}
