package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.admin.ADMIN_Ft_ReviewDTO;

@Mapper("ADMIN_Ft_ReviewMapper")
public interface ADMIN_Ft_ReviewMapper {
	public List<ADMIN_Ft_ReviewDTO> getFT_Review_List(int ft_seq) throws Exception;
	public ADMIN_Ft_ReviewDTO getFT_Review_Info(int review_seq) throws Exception;
	public int ft_Review_Delete(int review_seq) throws Exception;
	public int ft_Review_Exp_Yn(int review_seq) throws Exception;
	public int ft_Review_Edit(ADMIN_Ft_ReviewDTO revDTO) throws Exception;
	public int ft_Review_Create(ADMIN_Ft_ReviewDTO revDTO) throws Exception;
	public int ft_Set_Rev_level(int review_seq) throws Exception;
	public int ft_Set_Revp_level(ADMIN_Ft_ReviewDTO revDTO) throws Exception;
	public List<ADMIN_Ft_ReviewDTO> getReview_LevP_List(String search_level) throws Exception;
	public int getReview_Reple_Cnt(String search_level) throws Exception;
	public int ft_Review_Reple_Edit(ADMIN_Ft_ReviewDTO revDTO) throws Exception;
}
