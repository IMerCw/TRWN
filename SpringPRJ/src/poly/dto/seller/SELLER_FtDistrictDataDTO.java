package poly.dto.seller;

public class SELLER_FtDistrictDataDTO {

	private String rowNo; //기본키 번호
	private String blpcNum; //사업장명
	private String siteWhlAddr; //소재지 전체 주소
	private String rdnWhlAddr; //도로명전체주소
	private String trdStateNm; //영업상태명
	private String x; //katec x 좌표
	private String y; //katec y 좌표
	
	
	public String getBlpcNum() {
		return blpcNum;
	}
	public void setBlpcNum(String blpcNum) {
		this.blpcNum = blpcNum;
	}
	public String getSiteWhlAddr() {
		return siteWhlAddr;
	}
	public void setSiteWhlAddr(String siteWhlAddr) {
		this.siteWhlAddr = siteWhlAddr;
	}
	public String getRdnWhlAddr() {
		return rdnWhlAddr;
	}
	public void setRdnWhlAddr(String rdnWhlAddr) {
		this.rdnWhlAddr = rdnWhlAddr;
	}
	public String getTrdStateNm() {
		return trdStateNm;
	}
	public void setTrdStateNm(String trdStateNm) {
		this.trdStateNm = trdStateNm;
	}
	public String getX() {
		return x;
	}
	public void setX(String x) {
		this.x = x;
	}
	public String getY() {
		return y;
	}
	public void setY(String y) {
		this.y = y;
	}
	public String getRowNo() {
		return rowNo;
	}
	public void setRowNo(String rowNo) {
		this.rowNo = rowNo;
	}
}
