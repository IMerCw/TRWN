package poly.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import poly.dto.cmmn.CMMN_Site_StatDTO;
import poly.dto.cmmn.CMMN_UserDTO;
import poly.persistance.mapper.CMMN_UserMapper;
import poly.service.CMMN_IUserService;
import poly.util.SHA256Util;
	
@Service("CMMN_UserService")//UserService 이름입니다.
public class CMMN_UserService implements CMMN_IUserService {
	
	@Resource(name="CMMN_UserMapper")
	private CMMN_UserMapper userMapper;
	
	@Override
	public int insertUserDTO(CMMN_UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.insertUserDTO(uDTO);
	}
	
	@Override
	public List<CMMN_UserDTO> getUserList() throws Exception {
		// TODO Auto-generated method stub
		return  userMapper.getUserList();
	}

	@Override
	public CMMN_UserDTO getUserDetail(CMMN_UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.getUserDetail(uDTO);
	}

	

	@Override
	public int deleteUser(CMMN_UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("uDTOdel_service : " + uDTO.getUserSeq());
		return userMapper.deleteUser(uDTO);
	}

	@Override
	public int updateUser(CMMN_UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.updateUser(uDTO);
	}

	@Override
	public CMMN_UserDTO getUserLogin(CMMN_UserDTO uDTO, Logger log) throws Exception {
		return userMapper.getUserLogin(uDTO);
	}

	@Override
	public int emailCheck(CMMN_UserDTO uDTO) throws Exception {
		System.out.println("service" + uDTO.getUserEmail());
		return userMapper.emailCheck(uDTO);
	}

	@Override
	public CMMN_UserDTO getUserFindEmail(CMMN_UserDTO uDTO) throws Exception {
		System.out.println("uDTOservice : " + uDTO.getUserHp());
		
		return userMapper.getUserFindEmail(uDTO);
	}

	@Override
	public CMMN_UserDTO getUserFindPwd(CMMN_UserDTO uDTO) throws Exception {
		System.out.println("uDTO service : " +uDTO.getUserEmail());
		return userMapper.getUserFindPwd(uDTO);
	}


	
	@Override
	public int updateUserPwd(CMMN_UserDTO uDTO) throws Exception {
		System.out.println("Service : " + uDTO.getUserSeq());
		return userMapper.updateUserPwd(uDTO);
	}
	
	//임시 비밀번호
	@Override
	public HashMap<String, Object> updateTmpPass(HashMap<String, Object> hMap) throws Exception {
		CMMN_UserDTO uDTO = (CMMN_UserDTO)hMap.get("uDTO");
		long temp_Pw = (long)(Math.random()*9000000000l) + 1000000000l;
		String temp_password = Long.toHexString(temp_Pw);
		uDTO.setUserPwd(SHA256Util.sha256(temp_password));
		int result = userMapper.updateTmpPass(uDTO);
		hMap.put("tmpPass", temp_password);
		hMap.put("result", result);
		return hMap;
	}

	@Override
	public int updateUserStatus(CMMN_UserDTO uDTO) throws Exception {
		System.out.println("uDTO service : " + uDTO.getUserStatus());
		System.out.println("uDTO service : " + uDTO.getUserEmail());
		return userMapper.updateUserStatus(uDTO);
	}

	@Override
	public int in_Site_Stat(CMMN_Site_StatDTO ssDTO) throws Exception {
		return userMapper.in_Site_Stat(ssDTO);
	}

	

}
