package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.admin.ADMIN_Ft_InfoDTO;

@Mapper("ADMIN_Ft_InfoMapper")
public interface ADMIN_Ft_InfoMapper {
	//푸드트럭 리스트----------------------------------------------------
	public List<ADMIN_Ft_InfoDTO> getFT_InfoList() throws Exception;
	public List<ADMIN_Ft_InfoDTO> getFT_Search(ADMIN_Ft_InfoDTO fDTO) throws Exception;
	public int ft_Active(ADMIN_Ft_InfoDTO fDTO) throws Exception;
	public int ft_Drop(ADMIN_Ft_InfoDTO fDTO) throws Exception;
	
	//푸드트럭 정보--------------------------------------------------
	public ADMIN_Ft_InfoDTO getFT_Info(int ft_seq) throws Exception;
	public int ft_Info_Edit(ADMIN_Ft_InfoDTO ftDTO) throws Exception;
}
