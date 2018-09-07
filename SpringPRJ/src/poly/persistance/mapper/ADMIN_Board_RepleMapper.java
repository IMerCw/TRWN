package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.admin.ADMIN_Board_RepleDTO;

@Mapper("ADMIN_Board_RepleMapper")
public interface ADMIN_Board_RepleMapper {
	public int board_R_Create(ADMIN_Board_RepleDTO brDTO) throws Exception;
	public List<ADMIN_Board_RepleDTO> getBoard_R_List(int board_p_seq) throws Exception;
	public int board_R_Edit(ADMIN_Board_RepleDTO brDTO) throws Exception;
	public int board_R_Delete(int reple_Seq) throws Exception;
	public int board_R_CreateUpdate(int reple_Seq) throws Exception;
	public List<ADMIN_Board_RepleDTO> getBoard_LevR_List(String search_level) throws Exception;
	public int board_R_LCreateUpdate(ADMIN_Board_RepleDTO brDTO) throws Exception;
	public int board_R_Count(int board_p_Seq) throws Exception;
}
