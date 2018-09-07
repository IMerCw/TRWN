package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.consumer.CONSUMER_Ft_ReviewDTO;

@Mapper("CONSUMER_Ft_ReviewMapper")
public interface CONSUMER_Ft_ReviewMapper {
	public List<CONSUMER_Ft_ReviewDTO> getFT_Review_List(int ft_seq) throws Exception;
	public CONSUMER_Ft_ReviewDTO getFT_Review_Info(int review_seq) throws Exception;
	public int ft_Review_Delete(int review_seq) throws Exception;
	public int ft_Review_Exp_Yn(int review_seq) throws Exception;
	public int ft_Review_Edit(CONSUMER_Ft_ReviewDTO revDTO) throws Exception;
	public int ft_Review_Create(CONSUMER_Ft_ReviewDTO revDTO) throws Exception;
	public int ft_Set_Rev_level(int review_seq) throws Exception;
	public int ft_Set_Revp_level(CONSUMER_Ft_ReviewDTO revDTO) throws Exception;
	public List<CONSUMER_Ft_ReviewDTO> getReview_LevP_List(String search_level) throws Exception;
	public int getReview_Reple_Cnt(String search_level) throws Exception;
	public int ft_Review_Reple_Edit(CONSUMER_Ft_ReviewDTO revDTO) throws Exception;
	public List<CONSUMER_Ft_ReviewDTO> getFt_Review_List_ftDetail(int ft_seq) throws Exception;
}
