package poly.service;

import java.util.List;

import poly.dto.admin.ADMIN_Search_TrendDTO;
import poly.dto.admin.ADMIN_Site_StatDTO;

public interface ADMIN_IMainService {
	public int getSite_Stat_Full(String value) throws Exception;
	public int getSite_Stat_Month(int value) throws Exception;
	public ADMIN_Site_StatDTO in_Site_Stat()throws Exception;
	public int getUser_Submit_Full(String value) throws Exception;
	public List<ADMIN_Search_TrendDTO> getSearch_Trend_List()throws Exception;
	public List<ADMIN_Search_TrendDTO> in_Search_Trend()throws Exception;
}
