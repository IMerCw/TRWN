package poly.dto.admin;

public class ADMIN_Site_StatDTO {
	private int stat_seq;
	private String join_date;
	private int user_seq;
	private String value; 
	
	public int getStat_seq() {
		return stat_seq;
	}
	public void setStat_seq(int stat_seq) {
		this.stat_seq = stat_seq;
	}
	public String getJoin_date() {
		return join_date;
	}
	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}
	public int getUser_seq() {
		return user_seq;
	}
	public void setUser_seq(int user_seq) {
		this.user_seq = user_seq;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
}
