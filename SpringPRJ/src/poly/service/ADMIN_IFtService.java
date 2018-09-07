package poly.service;

import java.util.List;

import poly.dto.admin.ADMIN_Ft_InfoDTO;
import poly.dto.admin.ADMIN_Ft_Menu_CateDTO;
import poly.dto.admin.ADMIN_Ft_ReviewDTO;
import poly.dto.admin.ADMIN_Menu_InfoDTO;

public interface ADMIN_IFtService {
	//푸드트럭 리스트----------------------------------------------------
	public List<ADMIN_Ft_InfoDTO> getFT_InfoList() throws Exception;
	public List<ADMIN_Ft_InfoDTO> getFT_Search(ADMIN_Ft_InfoDTO fDTO) throws Exception;
	public int ft_Active(ADMIN_Ft_InfoDTO fDTO) throws Exception;
	public int ft_Drop(ADMIN_Ft_InfoDTO fDTO) throws Exception;
	
	//푸드트럭 정보--------------------------------------------------
	public ADMIN_Ft_InfoDTO getFT_Info(int ft_seq) throws Exception;
	public int ft_Info_Edit(ADMIN_Ft_InfoDTO ftDTO) throws Exception;
	
	//푸드트럭 리뷰------------------------------------------------------
	public List<ADMIN_Ft_ReviewDTO> getFT_Review_List(int ft_seq) throws Exception;
	public ADMIN_Ft_ReviewDTO getFT_Review_Info(int review_seq) throws Exception;
	public int ft_Review_Delete(int review_seq) throws Exception;
	public int ft_Review_Exp_Yn(int review_seq) throws Exception;
	public int ft_Review_Edit(ADMIN_Ft_ReviewDTO revDTO) throws Exception;
	public int ft_Review_Create(ADMIN_Ft_ReviewDTO revDTO) throws Exception;
	public int ft_Set_Rev_level(int review_seq) throws Exception;
	public int ft_Set_Revp_level(ADMIN_Ft_ReviewDTO revDTO) throws Exception;
	public List<ADMIN_Ft_ReviewDTO> getReview_LevP_List(String search_level) throws Exception;
	public int getReview_Reple_Cnt(String search_level) throws Exception;
	public int ft_Review_Reple_Edit(ADMIN_Ft_ReviewDTO revDTO) throws Exception;
	
	//푸드트럭 메뉴 카테고리 ----------------------------------------------
	public List<ADMIN_Ft_Menu_CateDTO> getFT_Cate_List(int ft_seq) throws Exception;
	public ADMIN_Ft_Menu_CateDTO getFt_Cate_Info(ADMIN_Ft_Menu_CateDTO cateDTO) throws Exception;
	public int ft_Cate_Create(ADMIN_Ft_Menu_CateDTO cateDTO) throws Exception;
	public int ft_Cate_Edit(ADMIN_Ft_Menu_CateDTO cateDTO) throws Exception;
	public int ft_Cate_Delete(ADMIN_Ft_Menu_CateDTO cateDTO) throws Exception;
	public int ft_Cate_Sort(ADMIN_Ft_Menu_CateDTO cateDTO) throws Exception;
	
	//푸드트럭 메뉴 -------------------------------------------------------
	public List<ADMIN_Menu_InfoDTO> getFt_Menu_List(int ft_seq) throws Exception;
	public int ft_Menu_Create(ADMIN_Menu_InfoDTO menuDTO) throws Exception;
	public List<ADMIN_Menu_InfoDTO> getFt_CateToMenu_List(ADMIN_Menu_InfoDTO menuDTO) throws Exception;
	public ADMIN_Menu_InfoDTO getFt_Menu_Info(int menu_seq) throws Exception;
	public int ft_Menu_Edit(ADMIN_Menu_InfoDTO menuDTO) throws Exception;
	public int ft_Menu_Delete(int menu_seq) throws Exception;
	public int ft_Menu_Sort(ADMIN_Menu_InfoDTO menuDTO) throws Exception;
	
}
