package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.consumer.CONSUMER_FtMenuCateDTO;

@Mapper("CONSUMER_Ft_Menu_CateMapper")
public interface CONSUMER_Ft_Menu_CateMapper {
	public List<CONSUMER_FtMenuCateDTO> getFT_Cate_List(int ft_seq) throws Exception;
	public CONSUMER_FtMenuCateDTO getFt_Cate_Info(CONSUMER_FtMenuCateDTO cateDTO) throws Exception;
}
