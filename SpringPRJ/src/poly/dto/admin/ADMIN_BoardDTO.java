package poly.dto.admin;

public class ADMIN_BoardDTO {
	private int board_seq;
	private String board_name;
	private int board_read;
	private int board_write;
	private int board_reple;
	private String reg_date;
	private int exp_yn;
	
	//전체 게시글------------------------------
	private int board_p_count;
	
	public int getBoard_p_count() {
		return board_p_count;
	}
	public void setBoard_p_count(int board_p_count) {
		this.board_p_count = board_p_count;
	}
	public int getBoard_seq() {
		return board_seq;
	}
	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}
	public String getBoard_name() {
		return board_name;
	}
	public void setBoard_name(String board_name) {
		this.board_name = board_name;
	}
	public int getBoard_read() {
		return board_read;
	}
	public void setBoard_read(int board_read) {
		this.board_read = board_read;
	}
	public int getBoard_write() {
		return board_write;
	}
	public void setBoard_write(int board_write) {
		this.board_write = board_write;
	}
	public int getBoard_reple() {
		return board_reple;
	}
	public void setBoard_reple(int board_reple) {
		this.board_reple = board_reple;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public int getExp_yn() {
		return exp_yn;
	}
	public void setExp_yn(int exp_yn) {
		this.exp_yn = exp_yn;
	}
	
}
