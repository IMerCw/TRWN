package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.seller.SELLER_FtSellerDTO;
import poly.dto.seller.SELLER_WaitDTO;

@Mapper("SELLER_OrderWaitMapper")
public interface SELLER_OrderWaitMapper {
	public SELLER_FtSellerDTO getftSeqDTO(SELLER_FtSellerDTO ftsDTO)throws Exception;
	
	public List<SELLER_WaitDTO> getwaitDTO(SELLER_WaitDTO wDTO)throws Exception;
	
	public int updateWaitSeq(SELLER_WaitDTO wDTO)throws Exception; 
	
	
	
}
