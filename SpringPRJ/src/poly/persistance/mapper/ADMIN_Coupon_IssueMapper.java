package poly.persistance.mapper;

import java.util.List;
import java.util.Map;

import config.Mapper;
import poly.dto.admin.ADMIN_Coupon_IssueDTO;

@Mapper("ADMIN_Coupon_IssueMapper")
public interface ADMIN_Coupon_IssueMapper {
	public List<ADMIN_Coupon_IssueDTO> getCoupon_Issue_List() throws Exception;
	public int Coupon_Issue(ADMIN_Coupon_IssueDTO cpisDTO) throws Exception;
	public int Coupon_Count(ADMIN_Coupon_IssueDTO cpisDTO) throws Exception;
	public int Coupon_Issue_delete(int issue_code) throws Exception;
	public List<ADMIN_Coupon_IssueDTO> getCoupon_Issue_Search_List(Map<String, String> map) throws Exception;
}
