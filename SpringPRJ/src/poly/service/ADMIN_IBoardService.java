package poly.service;

import java.util.List;
import java.util.Map;

import poly.dto.admin.ADMIN_BoardDTO;
import poly.dto.admin.ADMIN_Board_PostDTO;
import poly.dto.admin.ADMIN_Board_RepleDTO;

public interface ADMIN_IBoardService {
	//게시판 관리-------------------------------------------------------------------------------
	public int board_Create(ADMIN_BoardDTO bDTO) throws Exception;
	public List<ADMIN_BoardDTO> getBoard_List() throws Exception;
	public List<ADMIN_BoardDTO> getBoard_Search(Map<String, String> map) throws Exception;
	public ADMIN_BoardDTO getBoard_Detail(int board_Seq) throws Exception;
	public int board_Edit(ADMIN_BoardDTO bDTO) throws Exception;
	public int board_Delete(int board_Seq) throws Exception;
	public int board_Exp_yn(int board_Seq) throws Exception;
	
	//게시물 관리-------------------------------------------------------------------------------
	public int board_P_Create(ADMIN_Board_PostDTO bpDTO) throws Exception;
	public List<ADMIN_Board_PostDTO> getBoard_P_List() throws Exception;
	public List<ADMIN_Board_PostDTO> getBoard_P_List_S(int board_seq) throws Exception;
	public List<ADMIN_Board_PostDTO> getBoard_P_ALL_Search(ADMIN_Board_PostDTO bpDTO) throws Exception;
	public List<ADMIN_Board_PostDTO> getBoard_P_Search(ADMIN_Board_PostDTO bpDTO) throws Exception;
	public ADMIN_Board_PostDTO getBoard_P_Detail(int board_p_Seq) throws Exception;
	public int board_P_Edit(ADMIN_Board_PostDTO bpDTO) throws Exception;
	public int board_P_Delete(int board_p_Seq) throws Exception;
	public int board_P_Exp_yn(int board_p_Seq) throws Exception;
	public int board_P_CreateUpdate(int board_p_Seq) throws Exception;
	public List<ADMIN_Board_PostDTO> getBoard_LevP_List(String search_level) throws Exception;
	public int board_P_LCreateUpdate(ADMIN_Board_PostDTO bpDTO) throws Exception;
	public int board_P_CountUP(int board_p_Seq) throws Exception;
	public int board_P_Count(int board_p_Seq) throws Exception;
	
	//댓글 관리---------------------------------------------------------------------------------
	public int board_R_Create(ADMIN_Board_RepleDTO brDTO) throws Exception;
	public List<ADMIN_Board_RepleDTO> getBoard_R_List(int board_p_seq) throws Exception;
	public int board_R_Edit(ADMIN_Board_RepleDTO brDTO) throws Exception;
	public int board_R_Delete(int reple_Seq) throws Exception;
	public int board_R_CreateUpdate(int reple_Seq) throws Exception;
	public List<ADMIN_Board_RepleDTO> getBoard_LevR_List(String search_level) throws Exception;
	public int board_R_LCreateUpdate(ADMIN_Board_RepleDTO brDTO) throws Exception;
	public int board_R_Count(int board_p_Seq) throws Exception;
}
