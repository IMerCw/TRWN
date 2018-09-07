package poly.service;

import poly.dto.seller.SELLER_FtSellerDTO;
import poly.dto.seller.SELLER_MenuJsDTO;

public interface SELLER_IOutService {
	public SELLER_FtSellerDTO getOutTruckInfo(SELLER_FtSellerDTO ftsDTO)throws Exception;//userSeq로 트럭정보 가져오기 
	
	public SELLER_MenuJsDTO getItemDTO(SELLER_MenuJsDTO mDTO)throws Exception;//장바구니 메뉴 이름 가져오기 
	

}
