package poly.dto.seller;

public class SELLER_WeatherDTO {
	//DTO : Data Transfer Object
		//데이터 전송을 위한 객체 
		private String fcstDate; //예보 일자
		private String fcstTime; //예보 시각
		private String category; //예보 종류
		private String baseDate; //기준 날짜
		private String baseTime; //기준 시각
		private String fcstValue; //예보 값 
		private String nx; //좌표 x값 
		private String ny; //좌표 y값
		
		public String getFcstDate() {
			return fcstDate;
		}
		public void setFcstDate(String fcstDate) {
			this.fcstDate = fcstDate;
		}
		public String getFcstTime() {
			return fcstTime;
		}
		public void setFcstTime(String fcstTime) {
			this.fcstTime = fcstTime;
		}
		public String getCategory() {
			return category;
		}
		public void setCategory(String category) {
			this.category = category;
		}
		public String getBaseDate() {
			return baseDate;
		}
		public void setBaseDate(String baseDate) {
			this.baseDate = baseDate;
		}
		public String getBaseTime() {
			return baseTime;
		}
		public void setBaseTime(String baseTime) {
			this.baseTime = baseTime;
		}
		public String getFcstValue() {
			return fcstValue;
		}
		public void setFcstValue(String fcstValue) {
			this.fcstValue = fcstValue;
		}
		public String getNx() {
			return nx;
		}
		public void setNx(String nx) {
			this.nx = nx;
		}
		public String getNy() {
			return ny;
		}
		public void setNy(String ny) {
			this.ny = ny;
		}
}