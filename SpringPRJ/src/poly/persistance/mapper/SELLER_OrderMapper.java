package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.admin.ADMIN_Coupon_IssueDTO;
import poly.dto.cmmn.CMMN_UserDTO;
import poly.dto.seller.SELLER_OrderInfoDTO;
import poly.dto.seller.SELLER_WaitDTO;

@Mapper("SELLER_OrderMapper")
public interface SELLER_OrderMapper {
	public CMMN_UserDTO getOrderUserDTO(CMMN_UserDTO uDTO)throws Exception;

	public List<SELLER_OrderInfoDTO> getOrderList(String userSeq)throws Exception;
		
	public List<ADMIN_Coupon_IssueDTO>getCpList(ADMIN_Coupon_IssueDTO couponList)throws Exception;
	
	public int updateCouponUse(ADMIN_Coupon_IssueDTO codeDTO)throws Exception;

	public int insertOrderInfo(SELLER_OrderInfoDTO oDTO)throws Exception;

	public int insertOrderItem(List<SELLER_WaitDTO> oList)throws Exception;



}
