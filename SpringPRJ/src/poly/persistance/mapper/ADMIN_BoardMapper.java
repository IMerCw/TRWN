package poly.persistance.mapper;

import java.util.List;
import java.util.Map;

import config.Mapper;
import poly.dto.admin.ADMIN_BoardDTO;

@Mapper("ADMIN_BoardMapper")
public interface ADMIN_BoardMapper { 
	public int board_Create(ADMIN_BoardDTO bDTO) throws Exception;
	public List<ADMIN_BoardDTO> getBoard_List() throws Exception;
	public List<ADMIN_BoardDTO> getBoard_Search(Map<String, String> map) throws Exception;
	public ADMIN_BoardDTO getBoard_Detail(int board_Seq) throws Exception;
	public int board_Edit(ADMIN_BoardDTO bDTO) throws Exception;
	public int board_Delete(int board_Seq) throws Exception;
	public int board_Exp_yn(int board_Seq) throws Exception;
}
