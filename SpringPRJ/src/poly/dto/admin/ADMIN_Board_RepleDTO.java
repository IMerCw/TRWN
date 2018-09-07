package poly.dto.admin;

public class ADMIN_Board_RepleDTO {
	private int reple_seq;
	private int board_p_seq;
	private int user_seq;
	private String board_reple_content;
	private String reg_date;
	private String board_reple_level;
	private int exp_yn;
	
	public int getReple_seq() {
		return reple_seq;
	}
	public void setReple_seq(int reple_seq) {
		this.reple_seq = reple_seq;
	}
	public int getBoard_p_seq() {
		return board_p_seq;
	}
	public void setBoard_p_seq(int board_p_seq) {
		this.board_p_seq = board_p_seq;
	}
	public int getUser_seq() {
		return user_seq;
	}
	public void setUser_seq(int user_seq) {
		this.user_seq = user_seq;
	}
	public String getBoard_reple_content() {
		return board_reple_content;
	}
	public void setBoard_reple_content(String board_reple_content) {
		this.board_reple_content = board_reple_content;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getBoard_reple_level() {
		return board_reple_level;
	}
	public void setBoard_reple_level(String board_reple_level) {
		this.board_reple_level = board_reple_level;
	}
	public int getExp_yn() {
		return exp_yn;
	}
	public void setExp_yn(int exp_yn) {
		this.exp_yn = exp_yn;
	}
}
