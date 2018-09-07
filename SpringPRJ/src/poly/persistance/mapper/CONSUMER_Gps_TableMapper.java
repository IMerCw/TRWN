package poly.persistance.mapper;

import config.Mapper;
import poly.dto.consumer.CONSUMER_Gps_TableDTO;

@Mapper("CONSUMER_Gps_TableMapper")
public interface CONSUMER_Gps_TableMapper {

	public int setGps(CONSUMER_Gps_TableDTO gpsDTO) throws Exception;

	public int updateGps(int user_seq) throws Exception;
	
}
