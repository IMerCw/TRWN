package poly.dto.admin;

public class ADMIN_Order_WaitDTO {
	private int wait_seq;
	private int ord_seq;
	private int ft_seq;
	private String ord_date;
	private int wait_time;
	private String ord_his;
	private int ord_status;
	
	public int getWait_seq() {
		return wait_seq;
	}
	public void setWait_seq(int wait_seq) {
		this.wait_seq = wait_seq;
	}
	public int getOrd_seq() {
		return ord_seq;
	}
	public void setOrd_seq(int ord_seq) {
		this.ord_seq = ord_seq;
	}
	public int getFt_seq() {
		return ft_seq;
	}
	public void setFt_seq(int ft_seq) {
		this.ft_seq = ft_seq;
	}
	public String getOrd_date() {
		return ord_date;
	}
	public void setOrd_date(String ord_date) {
		this.ord_date = ord_date;
	}
	public int getWait_time() {
		return wait_time;
	}
	public void setWait_time(int wait_time) {
		this.wait_time = wait_time;
	}
	public String getOrd_his() {
		return ord_his;
	}
	public void setOrd_his(String ord_his) {
		this.ord_his = ord_his;
	}
	public int getOrd_status() {
		return ord_status;
	}
	public void setOrd_status(int ord_status) {
		this.ord_status = ord_status;
	}
}
