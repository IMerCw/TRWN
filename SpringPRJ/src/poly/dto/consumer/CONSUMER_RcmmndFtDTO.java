package poly.dto.consumer;

public class CONSUMER_RcmmndFtDTO {
	private String ftSeq;	//푸드트럭 번호
	private String userSeq;	//유저 번호
	private String ftName;	//푸드트럭 이름
	private String ftIntro;	//푸드트럭 이름
	private String fileSevname; //푸드트럭 사진 경로
	private String rcmmndRating; //추천 점수
	
	public String getFtSeq() {
		return ftSeq;
	}
	public void setFtSeq(String ftSeq) {
		this.ftSeq = ftSeq;
	}
	public String getFtName() {
		return ftName;
	}
	public void setFtName(String ftName) {
		this.ftName = ftName;
	}
	public String getFtIntro() {
		return ftIntro;
	}
	public void setFtIntro(String ftIntro) {
		this.ftIntro = ftIntro;
	}
	public String getFileSevname() {
		return fileSevname;
	}
	public void setFileSevname(String fileSevname) {
		this.fileSevname = fileSevname;
	}
	public String getRcmmndRating() {
		return rcmmndRating;
	}
	public void setRcmmndRating(String rcmmndRating) {
		this.rcmmndRating = rcmmndRating;
	}
	public String getUserSeq() {
		return userSeq;
	}
	public void setUserSeq(String userSeq) {
		this.userSeq = userSeq;
	}

}
