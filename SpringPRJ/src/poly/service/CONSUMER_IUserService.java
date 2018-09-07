package poly.service;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;

import poly.dto.consumer.CONSUMER_FtLikeDTO;
import poly.dto.consumer.CONSUMER_Gps_TableDTO;
import poly.dto.consumer.CONSUMER_OrderInfoDTO;
import poly.dto.consumer.CONSUMER_UserDTO;

public interface CONSUMER_IUserService {
	public int insertUserDTO(CONSUMER_UserDTO uDTO) throws Exception;
	
	public List<CONSUMER_UserDTO> getUserList() throws Exception;
	
	public CONSUMER_UserDTO getUserDetail(CONSUMER_UserDTO uDTO) throws Exception;
	
	public int deleteUser(CONSUMER_UserDTO uDTO) throws Exception;
	
	public int updateUser(CONSUMER_UserDTO uDTO) throws Exception;
	
	public CONSUMER_UserDTO getUserLogin(CONSUMER_UserDTO uDTO, Logger log) throws Exception;
	
	public int emailCheck(CONSUMER_UserDTO uDTO) throws Exception;
	
	public CONSUMER_UserDTO getUserFindEmail(CONSUMER_UserDTO uDTO) throws Exception;

	public CONSUMER_UserDTO getUserFindPwd(CONSUMER_UserDTO uDTO) throws Exception;

	public int updateUserPwd(CONSUMER_UserDTO uDTO) throws Exception;
	
	HashMap<String, Object> updateTmpPass(HashMap<String, Object> hMap) throws Exception;
	
	public int updateUserStatus(CONSUMER_UserDTO uDTO) throws Exception;

	public int ftAddFavorite(CONSUMER_FtLikeDTO ftLikeDTO) throws Exception;

	public CONSUMER_FtLikeDTO ftCheckFavrotie(CONSUMER_FtLikeDTO ftLikeDTO) throws Exception;
	
	public int ftRemoveFavorite(CONSUMER_FtLikeDTO ftLikeDTO) throws Exception;
	
	//위치정보 DB저장
	public int setGps(CONSUMER_Gps_TableDTO gpsDTO) throws Exception;

	public int updateGps(int user_seq) throws Exception;

	public List<CONSUMER_OrderInfoDTO> getOrderList(String userSeq)throws Exception;
}
