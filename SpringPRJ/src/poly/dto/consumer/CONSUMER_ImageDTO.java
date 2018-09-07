package poly.dto.consumer;

public class CONSUMER_ImageDTO {
	private String fileId;
	private String userSeq;
	private String ftSeq; //20180801에 추가한 부분입니다.
	private String fileOrgname;
	private String fileSevname;
	private String filePath;
	
	public String getFileId() {
		return fileId;
	}
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	public String getUserSeq() {
		return userSeq;
	}
	public void setUserSeq(String userSeq) {
		this.userSeq = userSeq;
	}
	public String getFileOrgname() {
		return fileOrgname;
	}
	public void setFileOrgname(String fileOrgname) {
		this.fileOrgname = fileOrgname;
	}
	public String getFileSevname() {
		return fileSevname;
	}
	public void setFileSevname(String fileSevname) {
		this.fileSevname = fileSevname;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getFtSeq() {
		return ftSeq;
	}
	public void setFtSeq(String ftSeq) {
		this.ftSeq = ftSeq;
	}
	

}
