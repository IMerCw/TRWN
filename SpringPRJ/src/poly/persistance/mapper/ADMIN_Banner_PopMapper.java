package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.admin.ADMIN_Banner_PopDTO;

@Mapper("ADMIN_Banner_PopMapper")
public interface ADMIN_Banner_PopMapper {
	public List<ADMIN_Banner_PopDTO> getBanner_List() throws Exception;
	public List<ADMIN_Banner_PopDTO> getBanner_List_Search(ADMIN_Banner_PopDTO bnDTO) throws Exception;
	public ADMIN_Banner_PopDTO getBanner_Info(int banner_seq) throws Exception;
	public int banner_Create(ADMIN_Banner_PopDTO bnDTO) throws Exception;
	public int banner_Edit(ADMIN_Banner_PopDTO bnDTO) throws Exception;
	public int banner_Delete(int banner_seq) throws Exception;
}
