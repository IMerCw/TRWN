package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.admin.ADMIN_Search_TrendDTO;

@Mapper("ADMIN_Search_TrendMapper")
public interface ADMIN_Search_TrendMapper {
	public List<ADMIN_Search_TrendDTO> getSearch_Trend_List()throws Exception;
	public List<ADMIN_Search_TrendDTO> in_Search_Trend()throws Exception;
}

