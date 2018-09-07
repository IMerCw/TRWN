package poly.persistance.mapper;

import java.util.HashMap;
import java.util.List;

import config.Mapper;
import poly.dto.seller.SELLER_FtDistrictDataDTO;
import poly.dto.seller.SELLER_FtSellerDTO;
import poly.dto.seller.SELLER_ImageDTO;
import poly.dto.seller.SELLER_OrderInfoDTO;

@Mapper("SELLER_FtSellerMapper")
public interface SELLER_FtSellerMapper {
	
	public int insertFtSInfo(SELLER_FtSellerDTO ftsDTO)throws Exception;
	
	public int insertftsImg(SELLER_ImageDTO imgDTO)throws Exception;
	
	public SELLER_FtSellerDTO getTruckConfig(SELLER_FtSellerDTO ftsDTO)throws Exception;
	
	public SELLER_ImageDTO getTruckImage(SELLER_ImageDTO imgDTO)throws Exception;
	
	public int updateTruckImage(SELLER_ImageDTO imgDTO)throws Exception;

	public List<SELLER_FtDistrictDataDTO> getFtDstctData(String keyWord) throws Exception;
	
	public List<SELLER_FtSellerDTO> getSalesList(SELLER_FtSellerDTO ftsDTO)throws Exception;

	public SELLER_OrderInfoDTO getChartWeek(String userSeq)throws Exception;

	public List<SELLER_OrderInfoDTO> getOrderWeek(String userSeq)throws Exception;
	
	//monthChart
	public List<SELLER_OrderInfoDTO> getMonthChart(SELLER_FtSellerDTO ftsDTO)throws Exception;

	public List<SELLER_OrderInfoDTO> latelyWeek(SELLER_FtSellerDTO ftsDTO)throws Exception;

	public int insertwList(SELLER_FtSellerDTO ftsDTO)throws Exception;
	

	
	
	
	

}
