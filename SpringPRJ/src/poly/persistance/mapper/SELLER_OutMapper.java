package poly.persistance.mapper;

import config.Mapper;
import poly.dto.seller.SELLER_FtSellerDTO;
import poly.dto.seller.SELLER_MenuJsDTO;

@Mapper("SELLER_OutMapper")
public interface SELLER_OutMapper {
	public SELLER_FtSellerDTO getOutTruckInfo(SELLER_FtSellerDTO ftsDTO)throws Exception;
	
	public SELLER_MenuJsDTO getItemDTO(SELLER_MenuJsDTO mDTO)throws Exception;
	

}
