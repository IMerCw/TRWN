package poly.dto.admin;

public class ADMIN_Banner_PopDTO {
	private int banner_seq;
	private String file_id;
	private String banner_name;
	private String banner_loc;
	private String banner_regdate;
	private int exp_yn;
	
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
	
	//---------------------------------------------------
	
	public int getBanner_seq() {
		return banner_seq;
	}
	public void setBanner_seq(int banner_seq) {
		this.banner_seq = banner_seq;
	}
	public String getFile_id() {
		return file_id;
	}
	public void setFile_id(String file_id) {
		this.file_id = file_id;
	}
	public String getBanner_name() {
		return banner_name;
	}
	public void setBanner_name(String banner_name) {
		this.banner_name = banner_name;
	}
	public String getBanner_loc() {
		return banner_loc;
	}
	public void setBanner_loc(String banner_loc) {
		this.banner_loc = banner_loc;
	}
	public String getBanner_regdate() {
		return banner_regdate;
	}
	public void setBanner_regdate(String banner_regdate) {
		this.banner_regdate = banner_regdate;
	}
	public int getExp_yn() {
		return exp_yn;
	}
	public void setExp_yn(int exp_yn) {
		this.exp_yn = exp_yn;
	}
}
