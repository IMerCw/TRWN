package poly.service;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import poly.dto.cmmn.CMMN_UserDTO;

public interface CMMN_IUserService {
	public int insertUserDTO(CMMN_UserDTO uDTO) throws Exception;
	
	public List<CMMN_UserDTO> getUserList() throws Exception;
	
	public CMMN_UserDTO getUserDetail(CMMN_UserDTO uDTO) throws Exception;
	
	public int deleteUser(CMMN_UserDTO uDTO) throws Exception;
	
	public int updateUser(CMMN_UserDTO uDTO) throws Exception;
	
	public CMMN_UserDTO getUserLogin(CMMN_UserDTO uDTO, Logger log) throws Exception;
	
	public int emailCheck(CMMN_UserDTO uDTO) throws Exception;
	
	public CMMN_UserDTO getUserFindEmail(CMMN_UserDTO uDTO) throws Exception;

	public CMMN_UserDTO getUserFindPwd(CMMN_UserDTO uDTO) throws Exception;

	public int updateUserPwd(CMMN_UserDTO uDTO) throws Exception;
	
	HashMap<String, Object> updateTmpPass(HashMap<String, Object> hMap) throws Exception;
	
	public int updateUserStatus(CMMN_UserDTO uDTO) throws Exception;
	
}
