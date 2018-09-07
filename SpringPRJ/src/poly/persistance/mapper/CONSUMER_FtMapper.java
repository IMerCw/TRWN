package poly.persistance.mapper;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import config.Mapper;
import poly.dto.consumer.CONSUMER_FtLikeDTO;
import poly.dto.consumer.CONSUMER_Ft_InfoDTO;
import poly.dto.consumer.CONSUMER_Ft_ReviewDTO;
import poly.dto.consumer.CONSUMER_ImageDTO;
import poly.dto.consumer.CONSUMER_Menu_InfoDTO;

@Mapper("CONSUMER_FtMapper") //UserMapper라는 이름의 Mapper라고 선언
public interface CONSUMER_FtMapper {

	public List<CONSUMER_Ft_InfoDTO> getFtList(String sido) throws Exception; //List<UserDTO>를 반환하는 getUserList메소드

	public CONSUMER_Ft_InfoDTO getFtDetail(String ft_seq) throws Exception;

	public List<CONSUMER_Ft_ReviewDTO> getReviewDetail(String ft_seq) throws Exception;

	public List<CONSUMER_Menu_InfoDTO> getMenuList(String keyWord) throws Exception;

	public List<CONSUMER_ImageDTO> getTruckImage(List<CONSUMER_ImageDTO> ImgDTOs) throws Exception;

	public List<CONSUMER_ImageDTO> getReviewImage(List<CONSUMER_ImageDTO> ImgDTOs) throws Exception;

	public List<CONSUMER_ImageDTO> getBannerImages() throws Exception;

	public List<CONSUMER_Menu_InfoDTO> getFtMenuList(String ft_seq) throws Exception;

	public List<CONSUMER_ImageDTO> getMenuImage(List<CONSUMER_ImageDTO> imgDTOs) throws Exception;

	public CONSUMER_ImageDTO getFtImage(String file_id) throws Exception;

	public List<CONSUMER_Ft_InfoDTO> getFtListSigungu(String sigungu) throws Exception;

	public List<CONSUMER_Ft_InfoDTO> getFtListDong(String dong) throws Exception;

	public List<CONSUMER_Menu_InfoDTO> getMenuListWithFtList(List<CONSUMER_Ft_InfoDTO> ftList)throws Exception;

	public List<CONSUMER_Ft_InfoDTO> getFtList_ALL()throws Exception;

	
	//getFavoriteFt선언을 MypageMapper.java에 옮김.


}
