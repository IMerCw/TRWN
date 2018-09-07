package poly.dto.consumer;

public class CONSUMER_OrderItemDTO {
	private int item_seq;
	private String menu_code;
	private int user_seq;
	private int ord_amnt;
	private int ord_status;
	
	public int getItem_seq() {
		return item_seq;
	}
	public void setItem_seq(int item_seq) {
		this.item_seq = item_seq;
	}
	public String getMenu_code() {
		return menu_code;
	}
	public void setMenu_code(String menu_code) {
		this.menu_code = menu_code;
	}
	public int getUser_seq() {
		return user_seq;
	}
	public void setUser_seq(int user_seq) {
		this.user_seq = user_seq;
	}
	public int getOrd_amnt() {
		return ord_amnt;
	}
	public void setOrd_amnt(int ord_amnt) {
		this.ord_amnt = ord_amnt;
	}
	public int getOrd_status() {
		return ord_status;
	}
	public void setOrd_status(int ord_status) {
		this.ord_status = ord_status;
	}
}
