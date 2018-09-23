package poly.persistance.mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import config.Mapper;
import poly.dto.consumer.CONSUMER_FtReviewDTO;
import poly.dto.consumer.CONSUMER_RcmmndMenuDTO;

@Mapper("CONSUMER_RcmmndMenuMapper")
public interface CONSUMER_RcmmndMenuMapper {
	public List<CONSUMER_RcmmndMenuDTO> getRcmmndMenuList(String sido) throws Exception;

	public List<CONSUMER_FtReviewDTO> getReviewList(int userSeq) throws Exception;

	public List<CONSUMER_FtReviewDTO> getUsersReviewList(int userSeq) throws Exception;

	public ArrayList<Map<String, String>> getSearchTrnd() throws Exception;
}
