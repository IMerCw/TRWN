package poly.dto.seller;

public class SELLER_BoardDTO {
	//DTO : Date transfer Object
	//데이터 전송을 위한 객체 
	private String boardPSeq;
	private String boardSeq;
	private String userSeq;
	private String fileId;
	private String title;
	private String content;
	private String boardCount;
	private String regDate;
	private String boardLevel;
	private String expYn;
	private String userNick;
	
	public String getUserNick() {
		return userNick;
	}
	public void setUserNick(String userNick) {
		this.userNick = userNick;
	}
	public String getBoardPSeq() {
		return boardPSeq;
	}
	public void setBoardPSeq(String boardPSeq) {
		this.boardPSeq = boardPSeq;
	}
	public String getBoardSeq() {
		return boardSeq;
	}
	public void setBoardSeq(String boardSeq) {
		this.boardSeq = boardSeq;
	}
	public String getUserSeq() {
		return userSeq;
	}
	public void setUserSeq(String userSeq) {
		this.userSeq = userSeq;
	}
	public String getFileId() {
		return fileId;
	}
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getBoardCount() {
		return boardCount;
	}
	public void setBoardCount(String boardCount) {
		this.boardCount = boardCount;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getBoardLevel() {
		return boardLevel;
	}
	public void setBoardLevel(String boardLevel) {
		this.boardLevel = boardLevel;
	}
	public String getExpYn() {
		return expYn;
	}
	public void setExpYn(String expYn) {
		this.expYn = expYn;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	

}
