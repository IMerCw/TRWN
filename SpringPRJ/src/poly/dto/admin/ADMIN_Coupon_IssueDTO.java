package poly.dto.admin;

public class ADMIN_Coupon_IssueDTO {
	private int issue_code;
	private int user_seq;
	private String coupon_code;
	private int coupon_count;
	private String coupon_issuedate;
	private int coupon_use;
	
	//주문하기를 위해 진수가 추가했습니다.
	private String coupon_name;
	private String coupon_option;
	private String coupon_date;
	
	public String getCoupon_name() {
		return coupon_name;
	}
	public void setCoupon_name(String coupon_name) {
		this.coupon_name = coupon_name;
	}
	public String getCoupon_option() {
		return coupon_option;
	}
	public void setCoupon_option(String coupon_option) {
		this.coupon_option = coupon_option;
	}
	public String getCoupon_date() {
		return coupon_date;
	}
	public void setCoupon_date(String coupon_date) {
		this.coupon_date = coupon_date;
	}
	public int getIssue_code() {
		return issue_code;
	}
	public void setIssue_code(int issue_code) {
		this.issue_code = issue_code;
	}
	public int getUser_seq() {
		return user_seq;
	}
	public void setUser_seq(int user_seq) {
		this.user_seq = user_seq;
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
	public int getCoupon_use() {
		return coupon_use;
	}
	public void setCoupon_use(int coupon_use) {
		this.coupon_use = coupon_use;
	}
}
