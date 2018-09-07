package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.admin.ADMIN_Menu_InfoDTO;

@Mapper("ADMIN_Menu_InfoMapper")
public interface ADMIN_Menu_InfoMapper {
	public List<ADMIN_Menu_InfoDTO> getFt_Menu_List(int ft_seq) throws Exception;
	public int ft_Menu_Create(ADMIN_Menu_InfoDTO menuDTO) throws Exception;
	public List<ADMIN_Menu_InfoDTO> getFt_CateToMenu_List(ADMIN_Menu_InfoDTO menuDTO) throws Exception;
	public ADMIN_Menu_InfoDTO getFt_Menu_Info(int menu_seq) throws Exception;
	public int ft_Menu_Edit(ADMIN_Menu_InfoDTO menuDTO) throws Exception;
	public int ft_Menu_Delete(int menu_seq) throws Exception;
	public int ft_Menu_Sort(ADMIN_Menu_InfoDTO menuDTO) throws Exception;
}
