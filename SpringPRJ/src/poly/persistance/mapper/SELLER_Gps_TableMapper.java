package poly.persistance.mapper;

import config.Mapper;
import poly.dto.consumer.CONSUMER_Gps_TableDTO;
import poly.dto.seller.SELLER_Gps_TableDTO;

@Mapper("SELLER_Gps_TableMapper")
public interface SELLER_Gps_TableMapper {

	public int setGps(SELLER_Gps_TableDTO gpsDTO) throws Exception;

	public int updateGps(int user_seq) throws Exception;
	
}
