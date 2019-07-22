package poly.persistance.mapper;

import config.Mapper;
import poly.dto.admin.ADMIN_Site_StatDTO;

@Mapper("ADMIN_Site_StatMapper")
public interface ADMIN_Site_StatMapper {
	public int getSite_Stat_Full(String value) throws Exception;
	public int getSite_Stat_Month(int value) throws Exception;
	public ADMIN_Site_StatDTO in_Site_Stat()throws Exception;
}