package poly.dto.admin;

public class ADMIN_Menu_InfoDTO {
	private int menu_seq;
	private int ft_seq;
	private int cate_sort_no;
	private String file_id;
	private int menu_sort_no;
	private String menu_name;
	private int menu_price;
	private String menu_intro;
	private int menu_rqtime;
	private String orign;
	private int exp_yn;
	
	//--------------------------------------------------------------
	
	private int edit_menu_sort_no;
	
	public int getEdit_menu_sort_no() {
		return edit_menu_sort_no;
	}
	public void setEdit_menu_sort_no(int edit_menu_sort_no) {
		this.edit_menu_sort_no = edit_menu_sort_no;
	}
	
	//--------------------------------------------------------------
	
	public int getMenu_seq() {
		return menu_seq;
	}
	public void setMenu_seq(int menu_seq) {
		this.menu_seq = menu_seq;
	}
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
	public String getFile_id() {
		return file_id;
	}
	public void setFile_id(String file_id) {
		this.file_id = file_id;
	}
	public int getMenu_sort_no() {
		return menu_sort_no;
	}
	public void setMenu_sort_no(int menu_sort_no) {
		this.menu_sort_no = menu_sort_no;
	}
	public String getMenu_name() {
		return menu_name;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	public int getMenu_price() {
		return menu_price;
	}
	public void setMenu_price(int menu_price) {
		this.menu_price = menu_price;
	}
	public String getMenu_intro() {
		return menu_intro;
	}
	public void setMenu_intro(String menu_intro) {
		this.menu_intro = menu_intro;
	}
	public int getMenu_rqtime() {
		return menu_rqtime;
	}
	public void setMenu_rqtime(int menu_rqtime) {
		this.menu_rqtime = menu_rqtime;
	}
	public String getOrign() {
		return orign;
	}
	public void setOrign(String orign) {
		this.orign = orign;
	}
	public int getExp_yn() {
		return exp_yn;
	}
	public void setExp_yn(int exp_yn) {
		this.exp_yn = exp_yn;
	}
}
