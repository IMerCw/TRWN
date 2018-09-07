package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.cmmn.CMMN_UserDTO;

@Mapper("CMMN_UserMapper")

public interface CMMN_UserMapper {
	public int insertUserDTO(CMMN_UserDTO uDTO) throws Exception;
	
	public List<CMMN_UserDTO> getUserList() throws Exception;
	
	public CMMN_UserDTO getUserDetail(CMMN_UserDTO uDTO) throws Exception;
	
	public int deleteUser(CMMN_UserDTO uDTO) throws Exception;
	
	public int updateUser(CMMN_UserDTO uDTO) throws Exception;
	
	public CMMN_UserDTO getUserLogin(CMMN_UserDTO uDTO) throws Exception;
	
	public int emailCheck(CMMN_UserDTO uDTO) throws Exception;
	
	public CMMN_UserDTO getUserFindEmail(CMMN_UserDTO uDTO) throws Exception;
	
	public CMMN_UserDTO getUserFindPwd(CMMN_UserDTO uDTO) throws Exception;
	
	public int updateUserPwd(CMMN_UserDTO uDTO) throws Exception;
	
	int updateTmpPass(CMMN_UserDTO uDTO) throws Exception;
	
	int updateUserStatus(CMMN_UserDTO uDTO) throws Exception;


}
