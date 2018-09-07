package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.admin.ADMIN_Coupon_IssueDTO;
import poly.dto.cmmn.CMMN_UserDTO;
import poly.dto.seller.SELLER_OrderInfoDTO;
import poly.persistance.mapper.CONSUMER_MypageMapper;
import poly.persistance.mapper.SELLER_OrderMapper;
import poly.service.SELLER_IOrderService;

@Service("SELLER_OrderService")//service 이름입니다 .
public class SELLER_OrderService implements SELLER_IOrderService {

	@Resource(name="SELLER_OrderMapper")
	private SELLER_OrderMapper orderMapper;

	@Resource(name="CONSUMER_MypageMapper")
	private CONSUMER_MypageMapper mypageMapper;
	
	@Override
	public CMMN_UserDTO getOrderUserDTO(CMMN_UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		return orderMapper.getOrderUserDTO(uDTO);
	}

	@Override
	public List<SELLER_OrderInfoDTO> getOrderList(String userSeq) throws Exception {
		// TODO Auto-generated method stub
		return orderMapper.getOrderList(userSeq);
	}

	@Override
	public List<ADMIN_Coupon_IssueDTO> getCpList(ADMIN_Coupon_IssueDTO couponList) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("service : " + couponList.getUser_seq());
		return orderMapper.getCpList(couponList);
	}

	@Override
	public int updateCouponUse(ADMIN_Coupon_IssueDTO codeDTO) throws Exception {
		// TODO Auto-generated method stub
		return orderMapper.updateCouponUse(codeDTO);
	}
	
	
}
