package poly.dto.admin;

public class ADMIN_Ft_InfoDTO {
	private int ft_seq;
	private int user_seq;
	private String file_id;
	private String sel_name;
	private String sel_no;
	private String ft_name;
	private String ft_intro;
	private String ft_join;
	private String ft_optime;
	private String ft_func;
	private String ft_chan;
	private int ft_status;
	
	private String sido; //18.08.24 PCW 시도구 정보 추가 
	private String dong; //18.08.24 PCW 동면읍리 정보 추가
	
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
	public String getSel_name() {
		return sel_name;
	}
	public void setSel_name(String sel_name) {
		this.sel_name = sel_name;
	}
	public String getSel_no() {
		return sel_no;
	}
	public void setSel_no(String sel_no) {
		this.sel_no = sel_no;
	}
	public String getFt_name() {
		return ft_name;
	}
	public void setFt_name(String ft_name) {
		this.ft_name = ft_name;
	}
	public String getFt_intro() {
		return ft_intro;
	}
	public void setFt_intro(String ft_intro) {
		this.ft_intro = ft_intro;
	}
	public String getFt_join() {
		return ft_join;
	}
	public void setFt_join(String ft_join) {
		this.ft_join = ft_join;
	}
	public String getFt_optime() {
		return ft_optime;
	}
	public void setFt_optime(String ft_optime) {
		this.ft_optime = ft_optime;
	}
	public String getFt_func() {
		return ft_func;
	}
	public void setFt_func(String ft_func) {
		this.ft_func = ft_func;
	}
	public String getFt_chan() {
		return ft_chan;
	}
	public void setFt_chan(String ft_chan) {
		this.ft_chan = ft_chan;
	}
	public int getFt_status() {
		return ft_status;
	}
	public void setFt_status(int ft_status) {
		this.ft_status = ft_status;
	}
	public String getSido() {
		return sido;
	}
	public void setSido(String sido) {
		this.sido = sido;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
}
