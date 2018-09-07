package poly.dto.consumer;

public class CONSUMER_DissInfoDTO {
	private String dt; //질병예측일자
	private String cnt;	//질병 예측 진료 건수
	private String risk; // 질병 위험도
	private String dissRiskXpln; // 질병 위험도 지침
	
	public String getDt() {
		return dt;
	}
	public void setDt(String dt) {
		this.dt = dt;
	}
	public String getCnt() {
		return cnt;
	}
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}
	public String getRisk() {
		return risk;
	}
	public void setRisk(String risk) {
		this.risk = risk;
	}
	public String getDissRiskXpln() {
		return dissRiskXpln;
	}
	public void setDissRiskXpln(String dissRiskXpln) {
		this.dissRiskXpln = dissRiskXpln;
	}
	
}