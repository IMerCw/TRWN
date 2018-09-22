package poly.dto.consumer;

public class CONSUMER_Search_TrendDTO {
	private int trend_seq;
	private String user_seq;
	private String search_word;
	private String search_date;
	private String value;
	
	public int getTrend_seq() {
		return trend_seq;
	}
	public void setTrend_seq(int trend_seq) {
		this.trend_seq = trend_seq;
	}
	public String getSearch_word() {
		return search_word;
	}
	public void setSearch_word(String search_word) {
		this.search_word = search_word;
	}
	public String getSearch_date() {
		return search_date;
	}
	public void setSearch_date(String search_date) {
		this.search_date = search_date;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getUser_seq() {
		return user_seq;
	}
	public void setUser_seq(String user_seq) {
		this.user_seq = user_seq;
	}
}
