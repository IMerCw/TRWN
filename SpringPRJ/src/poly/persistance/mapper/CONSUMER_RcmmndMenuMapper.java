package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.consumer.CONSUMER_RcmmndMenuDTO;

@Mapper("CONSUMER_RcmmndMenuMapper")
public interface CONSUMER_RcmmndMenuMapper {
	public List<CONSUMER_RcmmndMenuDTO> getRcmmndMenuList(String sido) throws Exception;
}
