package poly.dto.admin;

public class ADMIN_Order_InfoDTO {
	private int ord_seq;
	private int user_seq;
	private int ord_sumprice;
	private String ord_way;
	private String ord_date;
	private int ord_status;
	private String buy_way;
	private String usr_rcv_time;
	private String rcv_time;
	private String tid;
	private int ft_seq;
	private String tran_no;
	private int gps_seq;
	
	//------------------------------------------------
	
	private String option;
	private String value;
	
	public String getOption() {
		return option;
	}
	public void setOption(String option) {
		this.option = option;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	
	//------------------------------------------------
	
	public int getOrd_seq() {
		return ord_seq;
	}
	public void setOrd_seq(int ord_seq) {
		this.ord_seq = ord_seq;
	}
	public int getUser_seq() {
		return user_seq;
	}
	public void setUser_seq(int user_seq) {
		this.user_seq = user_seq;
	}
	public int getOrd_sumprice() {
		return ord_sumprice;
	}
	public void setOrd_sumprice(int ord_sumprice) {
		this.ord_sumprice = ord_sumprice;
	}
	public String getOrd_way() {
		return ord_way;
	}
	public void setOrd_way(String ord_way) {
		this.ord_way = ord_way;
	}
	public String getOrd_date() {
		return ord_date;
	}
	public void setOrd_date(String ord_date) {
		this.ord_date = ord_date;
	}
	public int getOrd_status() {
		return ord_status;
	}
	public void setOrd_status(int ord_status) {
		this.ord_status = ord_status;
	}
	public String getBuy_way() {
		return buy_way;
	}
	public void setBuy_way(String buy_way) {
		this.buy_way = buy_way;
	}
	public String getUsr_rcv_time() {
		return usr_rcv_time;
	}
	public void setUsr_rcv_time(String usr_rcv_time) {
		this.usr_rcv_time = usr_rcv_time;
	}
	public String getRcv_time() {
		return rcv_time;
	}
	public void setRcv_time(String rcv_time) {
		this.rcv_time = rcv_time;
	}
	public String getTid() {
		return tid;
	}
	public void setTid(String tid) {
		this.tid = tid;
	}
	public int getFt_seq() {
		return ft_seq;
	}
	public void setFt_seq(int ft_seq) {
		this.ft_seq = ft_seq;
	}
	public String getTran_no() {
		return tran_no;
	}
	public void setTran_no(String tran_no) {
		this.tran_no = tran_no;
	}
	public int getGps_seq() {
		return gps_seq;
	}
	public void setGps_seq(int gps_seq) {
		this.gps_seq = gps_seq;
	}
}
