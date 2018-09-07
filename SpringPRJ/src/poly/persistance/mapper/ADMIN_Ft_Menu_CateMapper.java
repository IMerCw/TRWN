package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.admin.ADMIN_Ft_Menu_CateDTO;

@Mapper("ADMIN_Ft_Menu_CateMapper")
public interface ADMIN_Ft_Menu_CateMapper {
	public List<ADMIN_Ft_Menu_CateDTO> getFT_Cate_List(int ft_seq) throws Exception;
	public ADMIN_Ft_Menu_CateDTO getFt_Cate_Info(ADMIN_Ft_Menu_CateDTO cateDTO) throws Exception;
	public int ft_Cate_Create(ADMIN_Ft_Menu_CateDTO cateDTO) throws Exception;
	public int ft_Cate_Edit(ADMIN_Ft_Menu_CateDTO cateDTO) throws Exception;
	public int ft_Cate_Delete(ADMIN_Ft_Menu_CateDTO cateDTO) throws Exception;
	public int ft_Cate_Sort(ADMIN_Ft_Menu_CateDTO cateDTO) throws Exception;
}
