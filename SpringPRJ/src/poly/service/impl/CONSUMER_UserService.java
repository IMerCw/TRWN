package poly.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import poly.dto.consumer.CONSUMER_FtLikeDTO;
import poly.dto.consumer.CONSUMER_Gps_TableDTO;
import poly.dto.consumer.CONSUMER_OrderInfoDTO;
import poly.dto.consumer.CONSUMER_UserDTO;
import poly.persistance.mapper.CONSUMER_Gps_TableMapper;
import poly.persistance.mapper.CONSUMER_MypageMapper;
import poly.persistance.mapper.CONSUMER_UserMapper;
import poly.service.CONSUMER_IUserService;
	
@Service("CONSUMER_UserService")//UserService 이름입니다.
public class CONSUMER_UserService implements CONSUMER_IUserService {
	
	
	@Resource(name="CONSUMER_UserMapper")
	private CONSUMER_UserMapper userMapper;
	
	@Resource(name="CONSUMER_Gps_TableMapper")
	private CONSUMER_Gps_TableMapper gpsMapper;
	
	@Resource(name="CONSUMER_MypageMapper")
	private CONSUMER_MypageMapper mypageMapper;
	
	@Override
	public int insertUserDTO(CONSUMER_UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.insertUserDTO(uDTO);
	}
	
	@Override
	public List<CONSUMER_UserDTO> getUserList() throws Exception {
		// TODO Auto-generated method stub
		return  userMapper.getUserList();
	}

	@Override
	public CONSUMER_UserDTO getUserDetail(CONSUMER_UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		return mypageMapper.getUserDetail(uDTO);
	}

	

	@Override
	public int deleteUser(CONSUMER_UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("uDTOdel_service : " + uDTO.getUserSeq());
		return userMapper.deleteUser(uDTO);
	}

	@Override
	public int updateUser(CONSUMER_UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		return userMapper.updateUser(uDTO);
	}

	@Override
	public CONSUMER_UserDTO getUserLogin(CONSUMER_UserDTO uDTO, Logger log) throws Exception {
		log.info("this is service and udto.getuser_email : " + uDTO.getUserEmail());
		// TODO Auto-generated method stub
		return userMapper.getUserLogin(uDTO);
	}

	@Override
	public int emailCheck(CONSUMER_UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("service" + uDTO.getUserEmail());
		return userMapper.emailCheck(uDTO);
	}

	@Override
	public CONSUMER_UserDTO getUserFindEmail(CONSUMER_UserDTO uDTO) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("uDTOservice : " + uDTO.getUserHp());
		
		return userMapper.getUserFindEmail(uDTO);
	}

	@Override
	public CONSUMER_UserDTO getUserFindPwd(CONSUMER_UserDTO uDTO) throws Exception {
		System.out.println("uDTO service : " +uDTO.getUserEmail());
		return userMapper.getUserFindPwd(uDTO);
	}


	
	@Override
	public int updateUserPwd(CONSUMER_UserDTO uDTO) throws Exception {
		System.out.println("Service : " + uDTO.getUserSeq());
		return userMapper.updateUserPwd(uDTO);
	}

	@Override
	public int updateUserStatus(CONSUMER_UserDTO uDTO) throws Exception {
		System.out.println("uDTO service : " + uDTO.getUserStatus());
		System.out.println("uDTO service : " + uDTO.getUserEmail());
		return userMapper.updateUserStatus(uDTO);
	}


	//관심매장 추가하기
	@Override
	public int ftAddFavorite(CONSUMER_FtLikeDTO ftLikeDTO) throws Exception {
		return userMapper.ftAddFavortie(ftLikeDTO);
	}
	
	//관심매장 추가 여부 확인
	@Override
	public CONSUMER_FtLikeDTO ftCheckFavrotie(CONSUMER_FtLikeDTO ftLikeDTO) throws Exception{
		return userMapper.ftCheckFavrotie(ftLikeDTO);
	}
	//관심매장 삭제
	@Override
	public int ftRemoveFavorite(CONSUMER_FtLikeDTO ftLikeDTO) throws Exception {
		return userMapper.ftRemoveFavorite(ftLikeDTO);
	}
	
	@Override
	public HashMap<String, Object> updateTmpPass(HashMap<String, Object> hMap) throws Exception {
		return userMapper.updateTmpPass(hMap);
	}

	@Override
	public int setGps(CONSUMER_Gps_TableDTO gpsDTO) throws Exception {
		return gpsMapper.setGps(gpsDTO);
	}

	@Override
	public int updateGps(CONSUMER_Gps_TableDTO gpsDTO) throws Exception {
		return gpsMapper.updateGps(gpsDTO);
	}

	@Override
	public List<CONSUMER_OrderInfoDTO> getOrderList(String userSeq) throws Exception {
		return mypageMapper.getOrderList(userSeq);
	}
	


}
