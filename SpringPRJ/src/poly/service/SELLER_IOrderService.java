package poly.service;

import java.util.List;

import poly.dto.admin.ADMIN_Coupon_IssueDTO;
import poly.dto.cmmn.CMMN_UserDTO;
import poly.dto.seller.SELLER_OrderInfoDTO;
import poly.dto.seller.SELLER_WaitDTO;

public interface SELLER_IOrderService {
	public CMMN_UserDTO getOrderUserDTO(CMMN_UserDTO uDTO)throws Exception;
	public List<SELLER_OrderInfoDTO> getOrderList(String userSeq) throws Exception;
	public List<ADMIN_Coupon_IssueDTO> getCpList(ADMIN_Coupon_IssueDTO couponList)throws Exception;
	
	public int updateCouponUse (ADMIN_Coupon_IssueDTO codeDTO)throws Exception;
	public void insertOrderSuccess(SELLER_OrderInfoDTO oDTO, SELLER_WaitDTO oIDTO)throws Exception;

}
