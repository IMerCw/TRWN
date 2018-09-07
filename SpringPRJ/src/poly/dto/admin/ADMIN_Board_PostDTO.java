package poly.dto.admin;

public class ADMIN_Board_PostDTO {
	private int board_p_seq;
	private int board_seq;
	private int user_seq;
	private String file_id;
	private String title;
	private String content;
	private int board_count;
	private String reg_date;
	private String board_level;
	private int exp_yn;
	
	//검색 옵션, 값------------------------------
	private String option;
	private String value;
	
	private int reple_count;
	
	public int getReple_count() {
		return reple_count;
	}
	public void setReple_count(int reple_count) {
		this.reple_count = reple_count;
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
	//----------------------------------------
	public int getBoard_p_seq() {
		return board_p_seq;
	}
	public void setBoard_p_seq(int board_p_seq) {
		this.board_p_seq = board_p_seq;
	}
	public int getBoard_seq() {
		return board_seq;
	}
	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getBoard_count() {
		return board_count;
	}
	public void setBoard_count(int board_count) {
		this.board_count = board_count;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getBoard_level() {
		return board_level;
	}
	public void setBoard_level(String board_level) {
		this.board_level = board_level;
	}
	public int getExp_yn() {
		return exp_yn;
	}
	public void setExp_yn(int exp_yn) {
		this.exp_yn = exp_yn;
	}
}
