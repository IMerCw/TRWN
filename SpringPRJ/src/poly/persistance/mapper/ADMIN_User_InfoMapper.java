package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.admin.ADMIN_User_InfoDTO;

@Mapper("ADMIN_User_InfoMapper")
public interface ADMIN_User_InfoMapper {
	public ADMIN_User_InfoDTO getUser(int user_seq) throws Exception;
	public List<ADMIN_User_InfoDTO> getUser_InfoList() throws Exception;
	public List<ADMIN_User_InfoDTO> getUser_Search(ADMIN_User_InfoDTO uDTO) throws Exception;
	public int user_Active(ADMIN_User_InfoDTO uDTO) throws Exception;
	public int user_Drop(ADMIN_User_InfoDTO uDTO) throws Exception;
	public int user_Auth(ADMIN_User_InfoDTO uDTO) throws Exception;
	public int getUser_Submit_Full(String value) throws Exception;
}
