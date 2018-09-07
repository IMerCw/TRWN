package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.admin.ADMIN_Board_PostDTO;

@Mapper("ADMIN_Board_PostMapper")
public interface ADMIN_Board_PostMapper {
	public int board_P_Create(ADMIN_Board_PostDTO bpDTO) throws Exception;
	public List<ADMIN_Board_PostDTO> getBoard_P_List() throws Exception;
	public List<ADMIN_Board_PostDTO> getBoard_P_ALL_Search(ADMIN_Board_PostDTO bpDTO) throws Exception;
	public List<ADMIN_Board_PostDTO> getBoard_P_Search(ADMIN_Board_PostDTO bpDTO) throws Exception;
	public ADMIN_Board_PostDTO getBoard_P_Detail(int board_p_Seq) throws Exception;
	public int board_P_Edit(ADMIN_Board_PostDTO bpDTO) throws Exception;
	public int board_P_Delete(int board_p_Seq) throws Exception;
	public int board_P_Exp_yn(int board_p_Seq) throws Exception;
	public int board_P_CreateUpdate(int board_p_Seq) throws Exception;
	public List<ADMIN_Board_PostDTO> getBoard_LevP_List(String search_level) throws Exception;
	public int board_P_LCreateUpdate(ADMIN_Board_PostDTO bpDTO) throws Exception;
	public List<ADMIN_Board_PostDTO> getBoard_P_List_S(int board_seq) throws Exception;
	public int board_P_CountUP(int board_p_Seq) throws Exception;
	public int board_P_Count(int board_p_Seq) throws Exception;
}
