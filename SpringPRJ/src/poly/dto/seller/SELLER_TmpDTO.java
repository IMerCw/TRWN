package poly.dto.seller;

public class SELLER_TmpDTO {
	private String tmpPrdtNo;
	private String tmpPrdtQty;
	private String tmpPrdtPrice;
	private String tmpPrdtName;
	
	public SELLER_TmpDTO() {}
	
	public SELLER_TmpDTO(String tmpPrdtNo, String tmpPrdtQty, String tmpPrdtPrice, String tmpPrdtName) {
		this.tmpPrdtNo = tmpPrdtNo;
		this.tmpPrdtQty = tmpPrdtQty;
		this.tmpPrdtPrice = tmpPrdtPrice;
		this.tmpPrdtName = tmpPrdtName;
		
	}

	public String getTmpPrdtNo() {
		return tmpPrdtNo;
	}

	public void setTmpPrdtNo(String tmpPrdtNo) {
		this.tmpPrdtNo = tmpPrdtNo;
	}

	public String getTmpPrdtQty() {
		return tmpPrdtQty;
	}

	public void setTmpPrdtQty(String tmpPrdtQty) {
		this.tmpPrdtQty = tmpPrdtQty;
	}

	public String getTmpPrdtPrice() {
		return tmpPrdtPrice;
	}

	public void setTmpPrdtPrice(String tmpPrdtPrice) {
		this.tmpPrdtPrice = tmpPrdtPrice;
	}

	public String getTmpPrdtName() {
		return tmpPrdtName;
	}

	public void setTmpPrdtName(String tmpPrdtName) {
		this.tmpPrdtName = tmpPrdtName;
	}

	
	
	
}
