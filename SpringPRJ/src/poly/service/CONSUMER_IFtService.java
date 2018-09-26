package poly.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import poly.dto.consumer.CONSUMER_Ft_ReviewDTO;
import poly.dto.consumer.CONSUMER_ImageDTO;
import poly.dto.consumer.CONSUMER_Menu_InfoDTO;
import poly.dto.consumer.CONSUMER_RcmmndFtDTO;
import poly.dto.consumer.CONSUMER_RcmmndMenuDTO;
import poly.dto.consumer.CONSUMER_Search_TrendDTO;
import poly.dto.consumer.CONSUMER_Search_Trend_WDateDTO;
import poly.dto.consumer.CONSUMER_FtLikeDTO;
import poly.dto.consumer.CONSUMER_FtMenuCateDTO;
import poly.dto.consumer.CONSUMER_FtReviewDTO;
import poly.dto.consumer.CONSUMER_Ft_InfoDTO;

public interface CONSUMER_IFtService {
	public CONSUMER_Ft_InfoDTO getFtDetail(String ft_seq) throws Exception;

	public List<CONSUMER_Ft_ReviewDTO> getReviewDetail(String ft_seq) throws Exception;

	public List<CONSUMER_Menu_InfoDTO> getMenuList(String keyWord) throws Exception;

	public List<CONSUMER_ImageDTO> getTruckImage(List<CONSUMER_ImageDTO> ImgDTOs) throws Exception;

	public List<CONSUMER_ImageDTO> getReviewImage(List<CONSUMER_ImageDTO> ImgDTOs) throws Exception;

	public List<CONSUMER_ImageDTO> getBannerImages() throws Exception;

	public List<CONSUMER_Menu_InfoDTO> getFtMenuList(String ft_seq) throws Exception;

	public List<CONSUMER_ImageDTO> getMenuImage(List<CONSUMER_ImageDTO> imgDTOs) throws Exception;

	public CONSUMER_ImageDTO getFtImage(String file_id) throws Exception;

	//푸드트럭 리뷰------------------------------------------------------
	public List<CONSUMER_Ft_ReviewDTO> getFT_Review_List(int ft_seq) throws Exception;
	public CONSUMER_Ft_ReviewDTO getFT_Review_Info(int review_seq) throws Exception;
	public int ft_Review_Delete(int review_seq) throws Exception;
	public int ft_Review_Exp_Yn(int review_seq) throws Exception;
	public int ft_Review_Edit(CONSUMER_Ft_ReviewDTO revDTO) throws Exception;
	public int ft_Review_Create(CONSUMER_Ft_ReviewDTO revDTO) throws Exception;
	public int ft_Set_Rev_level(int review_seq) throws Exception;
	public int ft_Set_Revp_level(CONSUMER_Ft_ReviewDTO revDTO) throws Exception;
	public List<CONSUMER_Ft_ReviewDTO> getReview_LevP_List(String search_level) throws Exception;
	public int getReview_Reple_Cnt(String search_level) throws Exception;
	public int ft_Review_Reple_Edit(CONSUMER_Ft_ReviewDTO revDTO) throws Exception;
	
	//특정 푸드트럭 상세 정보 리뷰 전용 -- 답글 제외
	public List<CONSUMER_Ft_ReviewDTO> getFt_Review_List_ftDetail(int ft_seq) throws Exception;
	
	//푸드트럭 메뉴 카테고리 가져오기
	public List<CONSUMER_FtMenuCateDTO> getFT_Cate_List(int ft_seq) throws Exception;
	
	
	//푸드트럭 리스트 가져오기 - 검색 기능 -- 시도, 시군구, 동면읍리 
	public List<CONSUMER_Ft_InfoDTO> getFtList(String sido) throws Exception; 
	public List<CONSUMER_Ft_InfoDTO> getFtList_ALL() throws Exception;
	public List<CONSUMER_Ft_InfoDTO> getFtListSigungu(String sigungu) throws Exception; 
	public List<CONSUMER_Ft_InfoDTO> getFtListDong(String dong) throws Exception;
	//음식 메뉴 리스트 가져오기 - ftList파라미터
	public List<CONSUMER_Menu_InfoDTO> getMenuListWithFtList(List<CONSUMER_Ft_InfoDTO> ftList) throws Exception;
	
	//메뉴 추천
	public List<CONSUMER_RcmmndMenuDTO> getRcmmndMenuList(String sido) throws Exception;

	public List<CONSUMER_FtLikeDTO> getFavoriteFt(String userSeq)throws Exception;

	public List<CONSUMER_FtReviewDTO> getReviewList(int userSeq) throws Exception;

	public List<CONSUMER_FtReviewDTO> getUsersReviewList(int userSeq) throws Exception;

	public int in_Search_Trend(CONSUMER_Search_TrendDTO stDTO) throws Exception;

	public ArrayList<Map<String, String>> getSearchTrnd() throws Exception;

	public List<CONSUMER_RcmmndFtDTO> getRcmmndFtList(List<CONSUMER_RcmmndFtDTO> rftDTOArr) throws Exception;

	public List<CONSUMER_Search_Trend_WDateDTO> getSearchTrndWDate() throws Exception;
}
