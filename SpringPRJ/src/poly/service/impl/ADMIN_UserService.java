package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.admin.ADMIN_User_InfoDTO;
import poly.persistance.mapper.ADMIN_User_InfoMapper;
import poly.service.ADMIN_IUserService;

@Service("ADMIN_UserService")
public class ADMIN_UserService implements ADMIN_IUserService{
	
	@Resource(name="ADMIN_User_InfoMapper")
	private ADMIN_User_InfoMapper user_InfoMapper;
	
	@Override
	public ADMIN_User_InfoDTO getUser(int user_seq) throws Exception {
		// TODO Auto-generated method stub
		return user_InfoMapper.getUser(user_seq);
	}
	
	@Override
	public List<ADMIN_User_InfoDTO> getUser_InfoList() throws Exception {
		// TODO Auto-generated method stub
		return user_InfoMapper.getUser_InfoList();
	}

	@Override
	public List<ADMIN_User_InfoDTO> getUser_Search(ADMIN_User_InfoDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		return user_InfoMapper.getUser_Search(uDTO);
	}

	@Override
	public int user_Active(ADMIN_User_InfoDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		return user_InfoMapper.user_Active(uDTO);
	}

	@Override
	public int user_Drop(ADMIN_User_InfoDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		return user_InfoMapper.user_Drop(uDTO);
	}

	@Override
	public int user_Auth(ADMIN_User_InfoDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		return user_InfoMapper.user_Auth(uDTO);
	}
}
