package poly.dto.consumer;

public class CONSUMER_Ft_ReviewDTO {
	private int review_seq;
	private int ft_seq;
	private int user_seq;
	private String file_id;
	private String rev_title;
	private int rev_point;
	private String rev_text;
	private String rev_regdate;
	private String rev_level;
	private int exp_yn;
	private String user_nick; //추가함
	
	private int reple_cnt; //답글 갯수 세팅
	
	public int getReple_cnt() {
		return reple_cnt;
	}
	public void setReple_cnt(int reple_cnt) {
		this.reple_cnt = reple_cnt;
	}
	
	//---------------------------------------------------------------------
	
	public int getReview_seq() {
		return review_seq;
	}
	public void setReview_seq(int review_seq) {
		this.review_seq = review_seq;
	}
	public int getFt_seq() {
		return ft_seq;
	}
	public void setFt_seq(int ft_seq) {
		this.ft_seq = ft_seq;
	}
	public int getUser_seq() {
		return user_seq;
	}
	public void setUser_seq(int user_seq) {
		this.user_seq = user_seq;
	}
	public String getFile_id() {
		return file_id;
	}
	public void setFile_id(String file_id) {
		this.file_id = file_id;
	}
	public String getRev_title() {
		return rev_title;
	}
	public void setRev_title(String rev_title) {
		this.rev_title = rev_title;
	}
	public int getRev_point() {
		return rev_point;
	}
	public void setRev_point(int rev_point) {
		this.rev_point = rev_point;
	}
	public String getRev_text() {
		return rev_text;
	}
	public void setRev_text(String rev_text) {
		this.rev_text = rev_text;
	}
	public String getRev_regdate() {
		return rev_regdate;
	}
	public void setRev_regdate(String rev_regdate) {
		this.rev_regdate = rev_regdate;
	}
	public String getRev_level() {
		return rev_level;
	}
	public void setRev_level(String rev_level) {
		this.rev_level = rev_level;
	}
	public int getExp_yn() {
		return exp_yn;
	}
	public void setExp_yn(int exp_yn) {
		this.exp_yn = exp_yn;
	}
	public String getUser_nick() {
		return user_nick;
	}
	public void setUser_nick(String user_nick) {
		this.user_nick = user_nick;
	}
}
