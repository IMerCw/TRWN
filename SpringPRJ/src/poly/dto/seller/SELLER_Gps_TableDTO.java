package poly.dto.seller;

public class SELLER_Gps_TableDTO {
	private int user_seq;
	private int ft_seq;
	/*private String gps_data;*/ //수정중
	private String gps_renew_date;
	private String gps_sido; //2018.08.24 PCW 시도 정보 
	private String gps_sigungu; //2018.08.24 PCW 시군구 정보 
	private String gps_dong; //2018.08.24 PCW 동읍면리 정보 
	private String gps_doro; //2018.08.24 PCW 도로명 정보 
	private String gps_x; //2018.08.24 PCW 위도 정보 
	private String gps_y; //2018.08.24 PCW 경도 정보 
	
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
	public String getGps_renew_date() {
		return gps_renew_date;
	}
	public void setGps_renew_date(String gps_renew_date) {
		this.gps_renew_date = gps_renew_date;
	}
	public String getGps_sido() {
		return gps_sido;
	}
	public void setGps_sido(String gps_sido) {
		this.gps_sido = gps_sido;
	}
	public String getGps_dong() {
		return gps_dong;
	}
	public void setGps_dong(String gps_dong) {
		this.gps_dong = gps_dong;
	}
	public String getGps_doro() {
		return gps_doro;
	}
	public void setGps_doro(String gps_doro) {
		this.gps_doro = gps_doro;
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
	public String getGps_sigungu() {
		return gps_sigungu;
	}
	public void setGps_sigungu(String gps_sigungu) {
		this.gps_sigungu = gps_sigungu;
	}
	
}
