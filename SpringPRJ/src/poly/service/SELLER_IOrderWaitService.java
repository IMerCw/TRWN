package poly.service;

import java.util.List;

import poly.dto.seller.SELLER_FtSellerDTO;
import poly.dto.seller.SELLER_WaitDTO;

public interface SELLER_IOrderWaitService {
	public SELLER_FtSellerDTO getftSeqDTO(SELLER_FtSellerDTO ftsDTO)throws Exception;
	
	public List<SELLER_WaitDTO> getwaitDTO(SELLER_WaitDTO wDTO)throws Exception;
	
	public List<SELLER_WaitDTO> getWaitComplete(SELLER_WaitDTO wDTO)throws Exception;

}
