package poly.dto.consumer;

public class CONSUMER_FtMenuCateDTO {
	private int ft_seq;
	private int cate_sort_no;
	private String cate_name;
	private int exp_yn;
	private int edit_cate_sort_no;
	
	//해당 테이블은 키값이 없기때문에 카테고리 소트 넘버(cate_sort_no)로 임시키 지정
	
	public int getEdit_cate_sort_no() {
		return edit_cate_sort_no;
	}
	public void setEdit_cate_sort_no(int edit_cate_sort_no) {
		this.edit_cate_sort_no = edit_cate_sort_no;
	}
	//---------------------------------------------------------------
	
	public int getFt_seq() {
		return ft_seq;
	}
	public void setFt_seq(int ft_seq) {
		this.ft_seq = ft_seq;
	}
	public int getCate_sort_no() {
		return cate_sort_no;
	}
	public void setCate_sort_no(int cate_sort_no) {
		this.cate_sort_no = cate_sort_no;
	}
	public String getCate_name() {
		return cate_name;
	}
	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}
	public int getExp_yn() {
		return exp_yn;
	}
	public void setExp_yn(int exp_yn) {
		this.exp_yn = exp_yn;
	}
}
