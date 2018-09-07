package poly.persistance.mapper;

import java.util.HashMap;
import java.util.List;

import config.Mapper;
import poly.dto.consumer.CONSUMER_FtLikeDTO;
import poly.dto.consumer.CONSUMER_OrderInfoDTO;
import poly.dto.consumer.CONSUMER_UserDTO;

@Mapper("CONSUMER_UserMapper")

public interface CONSUMER_UserMapper {
	public int insertUserDTO(CONSUMER_UserDTO uDTO) throws Exception;
	
	public List<CONSUMER_UserDTO> getUserList() throws Exception;
	
	//getUserDetail선언을 MypageMapper.java에 옮김.
	public int deleteUser(CONSUMER_UserDTO uDTO) throws Exception;
	
	public int updateUser(CONSUMER_UserDTO uDTO) throws Exception;
	
	public CONSUMER_UserDTO getUserLogin(CONSUMER_UserDTO uDTO) throws Exception;
	
	public int emailCheck(CONSUMER_UserDTO uDTO) throws Exception;
	
	public CONSUMER_UserDTO getUserFindEmail(CONSUMER_UserDTO uDTO) throws Exception;
	
	public CONSUMER_UserDTO getUserFindPwd(CONSUMER_UserDTO uDTO) throws Exception;
	
	public int updateUserPwd(CONSUMER_UserDTO uDTO) throws Exception;
	
	HashMap<String, Object> updateTmpPass(HashMap<String, Object> hMap) throws Exception;
	
	int updateUserStatus(CONSUMER_UserDTO uDTO) throws Exception;

	public int ftAddFavortie(CONSUMER_FtLikeDTO ftLikeDTO) throws Exception;

	public CONSUMER_FtLikeDTO ftCheckFavrotie(CONSUMER_FtLikeDTO ftLikeDTO) throws Exception;

	public int ftRemoveFavorite(CONSUMER_FtLikeDTO ftLikeDTO) throws Exception;

	//getOrderList선언을 MypageMapper.java에 옮김.

}
