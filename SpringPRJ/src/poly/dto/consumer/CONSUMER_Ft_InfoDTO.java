package poly.dto.consumer;

public class CONSUMER_Ft_InfoDTO {
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
	private double ft_dist_order;
	private String ft_snty_point;
	
	private String ft_avg_rev_point;
	
	//위치정보 GPS_TABLE로부터 가져옴
	private String gps_sido;
	private String gps_sigungu;
	private String gps_dong;
	private String gps_x;
	private String gps_y;

	
	private String option;
	private String value;
	
	private String file_path;
	
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
	public double getFt_dist_order() {
		return ft_dist_order;
	}
	public void setFt_dist_order(double ft_dist_order) {
		this.ft_dist_order = ft_dist_order;
	}
	public String getGps_sido() {
		return gps_sido;
	}
	public void setGps_sido(String gps_sido) {
		this.gps_sido = gps_sido;
	}
	public String getGps_sigungu() {
		return gps_sigungu;
	}
	public void setGps_sigungu(String gps_sigungu) {
		this.gps_sigungu = gps_sigungu;
	}
	public String getGps_dong() {
		return gps_dong;
	}
	public void setGps_dong(String gps_dong) {
		this.gps_dong = gps_dong;
	}
	public String getGps_x() {
		return gps_x;
	}
	public void setGps_x(String gps_x) {
		this.gps_x = gps_x;
	}
	public String getGps_y() {
		return gps_y;
	}
	public void setGps_y(String gps_y) {
		this.gps_y = gps_y;
	}
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
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
	}
	public String getFt_snty_point() {
		return ft_snty_point;
	}
	public void setFt_snty_point(String ft_snty_point) {
		this.ft_snty_point = ft_snty_point;
	}
	public String getFt_avg_rev_point() {
		return ft_avg_rev_point;
	}
	public void setFt_avg_rev_point(String ft_avg_rev_point) {
		this.ft_avg_rev_point = ft_avg_rev_point;
	}

	
}
