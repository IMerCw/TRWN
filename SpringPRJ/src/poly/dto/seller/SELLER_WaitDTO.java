package poly.dto.seller;

public class SELLER_WaitDTO {
	//data transfer object 데이터 전송 객체 
	
	private String waitSeq;
	private String ordSeq;
	private String ftSeq;
	private String waitTime;
	private String ordStatus;
	private String userSeq;
	private String usrRcvTime;
	private String userHp;
	private String waitRow;
	private String ordHis;
	
	
	public String getOrdHis() {
		return ordHis;
	}
	public void setOrdHis(String ordHis) {
		this.ordHis = ordHis;
	}
	public String getWaitRow() {
		return waitRow;
	}
	public void setWaitRow(String waitRow) {
		this.waitRow = waitRow;
	}
	public String getWaitSeq() {
		return waitSeq;
	}
	public void setWaitSeq(String waitSeq) {
		this.waitSeq = waitSeq;
	}
	public String getOrdSeq() {
		return ordSeq;
	}
	public void setOrdSeq(String ordSeq) {
		this.ordSeq = ordSeq;
	}
	public String getFtSeq() {
		return ftSeq;
	}
	public void setFtSeq(String ftSeq) {
		this.ftSeq = ftSeq;
	}
	public String getWaitTime() {
		return waitTime;
	}
	public void setWaitTime(String waitTime) {
		this.waitTime = waitTime;
	}
	public String getOrdStatus() {
		return ordStatus;
	}
	public void setOrdStatus(String ordStatus) {
		this.ordStatus = ordStatus;
	}
	public String getUserSeq() {
		return userSeq;
	}
	public void setUserSeq(String userSeq) {
		this.userSeq = userSeq;
	}
	public String getUsrRcvTime() {
		return usrRcvTime;
	}
	public void setUsrRcvTime(String usrRcvTime) {
		this.usrRcvTime = usrRcvTime;
	}
	public String getUserHp() {
		return userHp;
	}
	public void setUserHp(String userHp) {
		this.userHp = userHp;
	}
	
	
	
}
