package poly.dto.consumer;

public class CONSUMER_CouponIssueDTO {
	private int userSeq;
	private String coupon_code;
	private int coupon_count;
	private String coupon_issuedate;
	private String coupon_option;
	private String coupon_name;
	
	
	public int getUserSeq() {
		return userSeq;
	}
	public void setUserSeq(int userSeq) {
		this.userSeq = userSeq;
	}
	public String getCoupon_code() {
		return coupon_code;
	}
	public void setCoupon_code(String coupon_code) {
		this.coupon_code = coupon_code;
	}
	public int getCoupon_count() {
		return coupon_count;
	}
	public void setCoupon_count(int coupon_count) {
		this.coupon_count = coupon_count;
	}
	public String getCoupon_issuedate() {
		return coupon_issuedate;
	}
	public void setCoupon_issuedate(String coupon_issuedate) {
		this.coupon_issuedate = coupon_issuedate;
	}
	public String getCoupon_option() {
		return coupon_option;
	}
	public void setCoupon_option(String coupon_option) {
		this.coupon_option = coupon_option;
	}
	public String getCoupon_name() {
		return coupon_name;
	}
	public void setCoupon_name(String coupon_name) {
		this.coupon_name = coupon_name;
	}
	
}
