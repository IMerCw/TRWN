package poly.dto.admin;

public class ADMIN_Ft_LikeDTO {
	private int user_seq;
	private int ft_seq;
	private int like_sort_no;
	private String like_regdate;
	
	public int getUser_seq() {
		return user_seq;
	}
	public void setUser_seq(int user_seq) {
		this.user_seq = user_seq;
	}
	public int getFt_seq() {
		return ft_seq;
	}
	public void setFt_seq(int ft_seq) {
		this.ft_seq = ft_seq;
	}
	public int getLike_sort_no() {
		return like_sort_no;
	}
	public void setLike_sort_no(int like_sort_no) {
		this.like_sort_no = like_sort_no;
	}
	public String getLike_regdate() {
		return like_regdate;
	}
	public void setLike_regdate(String like_regdate) {
		this.like_regdate = like_regdate;
	}
}
