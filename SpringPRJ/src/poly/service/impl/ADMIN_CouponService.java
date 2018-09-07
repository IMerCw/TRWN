package poly.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.admin.ADMIN_CouponDTO;
import poly.dto.admin.ADMIN_Coupon_IssueDTO;
import poly.persistance.mapper.ADMIN_CouponMapper;
import poly.persistance.mapper.ADMIN_Coupon_IssueMapper;
import poly.service.ADMIN_ICouponService;

@Service("ADMIN_CouponService")
public class ADMIN_CouponService implements ADMIN_ICouponService{
	
	@Resource(name="ADMIN_CouponMapper")
	private ADMIN_CouponMapper couponMapper;
	
	@Resource(name="ADMIN_Coupon_IssueMapper")
	private ADMIN_Coupon_IssueMapper coupon_IssueMapper;

	//쿠폰-----------------------------------------------------------------------
	
	@Override
	public List<ADMIN_CouponDTO> getCoupon_List() throws Exception {
		// TODO Auto-generated method stub
		return couponMapper.getCoupon_List();
	}

	@Override
	public ADMIN_CouponDTO getCoupon_Info(String coupon_code) throws Exception {
		// TODO Auto-generated method stub
		return couponMapper.getCoupon_Info(coupon_code);
	}

	@Override
	public int Coupon_Create(ADMIN_CouponDTO cpDTO) throws Exception {
		// TODO Auto-generated method stub
		return couponMapper.Coupon_Create(cpDTO);
	}

	@Override
	public int Coupon_Edit(ADMIN_CouponDTO cpDTO) throws Exception {
		// TODO Auto-generated method stub
		return couponMapper.Coupon_Edit(cpDTO);
	}

	@Override
	public int Coupon_delete(String coupon_code) throws Exception {
		// TODO Auto-generated method stub
		return couponMapper.Coupon_delete(coupon_code);
	}

	@Override
	public List<ADMIN_CouponDTO> getCoupon_Search_List(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return couponMapper.getCoupon_Search_List(map);
	}
	
	//쿠폰발급-----------------------------------------------------------------------
	@Override
	public List<ADMIN_Coupon_IssueDTO> getCoupon_Issue_List() throws Exception {
		// TODO Auto-generated method stub
		return coupon_IssueMapper.getCoupon_Issue_List();
	}

	@Override
	public int Coupon_Issue(ADMIN_Coupon_IssueDTO cpisDTO) throws Exception {
		// TODO Auto-generated method stub
		return coupon_IssueMapper.Coupon_Issue(cpisDTO);
	}

	@Override
	public int Coupon_Count(ADMIN_Coupon_IssueDTO cpisDTO) throws Exception {
		// TODO Auto-generated method stub
		return coupon_IssueMapper.Coupon_Count(cpisDTO);
	}

	@Override
	public int Coupon_Issue_delete(int issue_code) throws Exception {
		// TODO Auto-generated method stub
		return coupon_IssueMapper.Coupon_Issue_delete(issue_code);
	}

	@Override
	public List<ADMIN_Coupon_IssueDTO> getCoupon_Issue_Search_List(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return coupon_IssueMapper.getCoupon_Issue_Search_List(map);
	}
}
