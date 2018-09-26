package poly.dto.consumer;

public class CONSUMER_OrderInfoDTO {
	private int ord_seq;
	private int ord_sumprice;
	private String ord_way;
	private String ord_date;
	private String buy_way;
	private String gps_seq;
	private String ft_seq;
	private String ft_name;
	private String ord_his;
	private String address;
	
	public int getOrd_seq() {
		return ord_seq;
	}
	public void setOrd_seq(int ord_seq) {
		this.ord_seq = ord_seq;
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
	public String getBuy_way() {
		return buy_way;
	}
	public void setBuy_way(String buy_way) {
		this.buy_way = buy_way;
	}
	public String getGps_seq() {
		return gps_seq;
	}
	public void setGps_seq(String gps_seq) {
		this.gps_seq = gps_seq;
	}
	public String getFt_seq() {
		return ft_seq;
	}
	public void setFt_seq(String ft_seq) {
		this.ft_seq = ft_seq;
	}
	public String getFt_name() {
		return ft_name;
	}
	public void setFt_name(String ft_name) {
		this.ft_name = ft_name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getOrd_his() {
		return ord_his;
	}
	public void setOrd_his(String ord_his) {
		this.ord_his = ord_his;
	}
	
}