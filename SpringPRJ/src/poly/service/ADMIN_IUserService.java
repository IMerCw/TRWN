package poly.service;

import java.util.List;

import poly.dto.admin.ADMIN_User_InfoDTO;

public interface ADMIN_IUserService {
	public ADMIN_User_InfoDTO getUser(int user_seq) throws Exception;
	public List<ADMIN_User_InfoDTO> getUser_InfoList() throws Exception;
	public List<ADMIN_User_InfoDTO> getUser_Search(ADMIN_User_InfoDTO uDTO) throws Exception;
	public int user_Active(ADMIN_User_InfoDTO uDTO) throws Exception;
	public int user_Drop(ADMIN_User_InfoDTO uDTO) throws Exception;
	public int user_Auth(ADMIN_User_InfoDTO uDTO) throws Exception;
}
