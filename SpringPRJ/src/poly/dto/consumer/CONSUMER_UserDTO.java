package poly.dto.consumer;

public class CONSUMER_UserDTO {
	//DTO : Data Transfer Object
		//데이터 전송을 위한 객체 
		private String userSeq; 
		private String userAuth;
		private String userEmail;
		private String userNick;
		private String userPwd;
		private String userHp;
		private String userGender;
		private String userChan;
		private String userStatus;
		
		public String getUserSeq() {
			return userSeq;
		}
		public void setUserSeq(String userSeq) {
			this.userSeq = userSeq;
		}
		public String getUserAuth() {
			return userAuth;
		}
		public void setUserAuth(String userAuth) {
			this.userAuth = userAuth;
		}
		public String getUserEmail() {
			return userEmail;
		}
		public void setUserEmail(String userEmail) {
			this.userEmail = userEmail;
		}
		public String getUserNick() {
			return userNick;
		}
		public void setUserNick(String userNick) {
			this.userNick = userNick;
		}
		public String getUserPwd() {
			return userPwd;
		}
		public void setUserPwd(String userPwd) {
			this.userPwd = userPwd;
		}
		public String getUserHp() {
			return userHp;
		}
		public void setUserHp(String userHp) {
			this.userHp = userHp;
		}
		public String getUserGender() {
			return userGender;
		}
		public void setUserGender(String userGender) {
			this.userGender = userGender;
		}
		public String getUserChan() {
			return userChan;
		}
		public void setUserChan(String userChan) {
			this.userChan = userChan;
		}
		public String getUserStatus() {
			return userStatus;
		}
		public void setUserStatus(String userStatus) {
			this.userStatus = userStatus;
		}
		
		
}