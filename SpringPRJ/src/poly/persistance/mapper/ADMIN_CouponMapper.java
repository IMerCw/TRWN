package poly.persistance.mapper;

import java.util.List;
import java.util.Map;

import config.Mapper;
import poly.dto.admin.ADMIN_CouponDTO;

@Mapper("ADMIN_CouponMapper")
public interface ADMIN_CouponMapper {
	public List<ADMIN_CouponDTO> getCoupon_List() throws Exception;
	public ADMIN_CouponDTO getCoupon_Info(String coupon_code) throws Exception;
	public int Coupon_Create(ADMIN_CouponDTO cpDTO) throws Exception;
	public int Coupon_Edit(ADMIN_CouponDTO cpDTO) throws Exception;
	public int Coupon_delete(String coupon_code) throws Exception;
	public List<ADMIN_CouponDTO> getCoupon_Search_List(Map<String, String> map) throws Exception;
}
