package poly.service;

import java.util.List;
import java.util.Map;

import poly.dto.admin.ADMIN_CouponDTO;
import poly.dto.admin.ADMIN_Coupon_IssueDTO;

public interface ADMIN_ICouponService {
	//쿠폰
	public List<ADMIN_CouponDTO> getCoupon_List() throws Exception;
	public ADMIN_CouponDTO getCoupon_Info(String coupon_code) throws Exception;
	public int Coupon_Create(ADMIN_CouponDTO cpDTO) throws Exception;
	public int Coupon_Edit(ADMIN_CouponDTO cpDTO) throws Exception;
	public int Coupon_delete(String coupon_code) throws Exception;
	public List<ADMIN_CouponDTO> getCoupon_Search_List(Map<String, String> map) throws Exception;
	
	//쿠폰발급
	public List<ADMIN_Coupon_IssueDTO> getCoupon_Issue_List() throws Exception;
	public int Coupon_Issue(ADMIN_Coupon_IssueDTO cpisDTO) throws Exception;
	public int Coupon_Count(ADMIN_Coupon_IssueDTO cpisDTO) throws Exception;
	public int Coupon_Issue_delete(int issue_code) throws Exception;
	public List<ADMIN_Coupon_IssueDTO> getCoupon_Issue_Search_List(Map<String, String> map) throws Exception;
}
