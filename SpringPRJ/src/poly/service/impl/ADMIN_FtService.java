package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.admin.ADMIN_Ft_InfoDTO;
import poly.dto.admin.ADMIN_Ft_Menu_CateDTO;
import poly.dto.admin.ADMIN_Ft_ReviewDTO;
import poly.dto.admin.ADMIN_Menu_InfoDTO;
import poly.persistance.mapper.ADMIN_Ft_InfoMapper;
import poly.persistance.mapper.ADMIN_Ft_Menu_CateMapper;
import poly.persistance.mapper.ADMIN_Ft_ReviewMapper;
import poly.persistance.mapper.ADMIN_Menu_InfoMapper;
import poly.service.ADMIN_IFtService;

@Service("ADMIN_FtService")
public class ADMIN_FtService implements ADMIN_IFtService{
	
	@Resource(name="ADMIN_Ft_InfoMapper")
	private ADMIN_Ft_InfoMapper ft_InfoMapper;
	
	@Resource(name="ADMIN_Ft_ReviewMapper")
	private ADMIN_Ft_ReviewMapper ft_ReviewMapper;
	
	@Resource(name="ADMIN_Ft_Menu_CateMapper")
	private ADMIN_Ft_Menu_CateMapper ft_Menu_CateMapper;
	
	@Resource(name="ADMIN_Menu_InfoMapper")
	private ADMIN_Menu_InfoMapper menu_InfoMapper;

//푸드트럭 리스트-------------------------------------------------------------
	@Override
	public List<ADMIN_Ft_InfoDTO> getFT_InfoList() throws Exception {
		// TODO Auto-generated method stub
		return ft_InfoMapper.getFT_InfoList();
	}

	@Override
	public List<ADMIN_Ft_InfoDTO> getFT_Search(ADMIN_Ft_InfoDTO fDTO) throws Exception {
		// TODO Auto-generated method stub
		return ft_InfoMapper.getFT_Search(fDTO);
	}

	@Override
	public int ft_Active(ADMIN_Ft_InfoDTO fDTO) throws Exception {
		// TODO Auto-generated method stub
		return ft_InfoMapper.ft_Active(fDTO);
	}

	@Override
	public int ft_Drop(ADMIN_Ft_InfoDTO fDTO) throws Exception {
		// TODO Auto-generated method stub
		return ft_InfoMapper.ft_Drop(fDTO);
	}

//푸드트럭 정보-------------------------------------------------------------
	@Override
	public ADMIN_Ft_InfoDTO getFT_Info(int ft_seq) throws Exception {
		// TODO Auto-generated method stub
		return ft_InfoMapper.getFT_Info(ft_seq);
	}
	@Override
	public int ft_Info_Edit(ADMIN_Ft_InfoDTO ftDTO) throws Exception {
		// TODO Auto-generated method stub
		return ft_InfoMapper.ft_Info_Edit(ftDTO);
	}
	
//푸드트럭 리뷰관리-------------------------------------------------------------
	@Override
	public List<ADMIN_Ft_ReviewDTO> getFT_Review_List(int ft_seq) throws Exception {
		// TODO Auto-generated method stub
		return ft_ReviewMapper.getFT_Review_List(ft_seq);
	} 

	@Override
	public ADMIN_Ft_ReviewDTO getFT_Review_Info(int review_seq) throws Exception {
		// TODO Auto-generated method stub
		return ft_ReviewMapper.getFT_Review_Info(review_seq);
	}

	@Override
	public int ft_Review_Delete(int review_seq) throws Exception {
		// TODO Auto-generated method stub
		return ft_ReviewMapper.ft_Review_Delete(review_seq);
	}

	@Override
	public int ft_Review_Exp_Yn(int review_seq) throws Exception {
		// TODO Auto-generated method stub
		return ft_ReviewMapper.ft_Review_Exp_Yn(review_seq);
	}

	@Override
	public int ft_Review_Edit(ADMIN_Ft_ReviewDTO revDTO) throws Exception {
		// TODO Auto-generated method stub
		return ft_ReviewMapper.ft_Review_Edit(revDTO);
	}

	@Override
	public int ft_Review_Create(ADMIN_Ft_ReviewDTO revDTO) throws Exception {
		// TODO Auto-generated method stub
		return ft_ReviewMapper.ft_Review_Create(revDTO);
	}

	@Override
	public int ft_Set_Rev_level(int review_seq) throws Exception {
		// TODO Auto-generated method stub
		return ft_ReviewMapper.ft_Set_Rev_level(review_seq);
	}

	@Override
	public int ft_Set_Revp_level(ADMIN_Ft_ReviewDTO revDTO) throws Exception {
		// TODO Auto-generated method stub
		return ft_ReviewMapper.ft_Set_Revp_level(revDTO);
	}

	@Override
	public List<ADMIN_Ft_ReviewDTO> getReview_LevP_List(String search_level) throws Exception {
		// TODO Auto-generated method stub
		return ft_ReviewMapper.getReview_LevP_List(search_level);
	}

	@Override
	public int getReview_Reple_Cnt(String search_level) throws Exception {
		// TODO Auto-generated method stub
		return ft_ReviewMapper.getReview_Reple_Cnt(search_level);
	}

	@Override
	public int ft_Review_Reple_Edit(ADMIN_Ft_ReviewDTO revDTO) throws Exception {
		// TODO Auto-generated method stub
		return ft_ReviewMapper.ft_Review_Reple_Edit(revDTO);
	}

//푸드트럭 메뉴 카테고리-------------------------------------------------------------
	
	@Override
	public List<ADMIN_Ft_Menu_CateDTO> getFT_Cate_List(int ft_seq) throws Exception {
		// TODO Auto-generated method stub
		return ft_Menu_CateMapper.getFT_Cate_List(ft_seq);
	}
	
	@Override
	public ADMIN_Ft_Menu_CateDTO getFt_Cate_Info(ADMIN_Ft_Menu_CateDTO cateDTO) throws Exception {
		// TODO Auto-generated method stub
		return ft_Menu_CateMapper.getFt_Cate_Info(cateDTO);
	}
	
	@Override
	public int ft_Cate_Create(ADMIN_Ft_Menu_CateDTO cateDTO) throws Exception {
		// TODO Auto-generated method stub
		return ft_Menu_CateMapper.ft_Cate_Create(cateDTO);
	}

	@Override
	public int ft_Cate_Edit(ADMIN_Ft_Menu_CateDTO cateDTO) throws Exception {
		// TODO Auto-generated method stub
		return ft_Menu_CateMapper.ft_Cate_Edit(cateDTO);
	}

	@Override
	public int ft_Cate_Delete(ADMIN_Ft_Menu_CateDTO cateDTO) throws Exception {
		// TODO Auto-generated method stub
		return ft_Menu_CateMapper.ft_Cate_Delete(cateDTO);
	}

	@Override
	public int ft_Cate_Sort(ADMIN_Ft_Menu_CateDTO cateDTO) throws Exception {
		// TODO Auto-generated method stub
		return ft_Menu_CateMapper.ft_Cate_Sort(cateDTO);
	}

	
//푸드트럭 메뉴 -----------------------------------------------------------------------
	@Override
	public List<ADMIN_Menu_InfoDTO> getFt_Menu_List(int ft_seq) throws Exception {
		// TODO Auto-generated method stub
		return menu_InfoMapper.getFt_Menu_List(ft_seq);
	}
	
	@Override
	public int ft_Menu_Create(ADMIN_Menu_InfoDTO menuDTO) throws Exception {
		// TODO Auto-generated method stub
		return menu_InfoMapper.ft_Menu_Create(menuDTO);
	}

	@Override
	public List<ADMIN_Menu_InfoDTO> getFt_CateToMenu_List(ADMIN_Menu_InfoDTO menuDTO) throws Exception {
		// TODO Auto-generated method stub
		return menu_InfoMapper.getFt_CateToMenu_List(menuDTO);
	}

	@Override
	public ADMIN_Menu_InfoDTO getFt_Menu_Info(int menu_seq) throws Exception {
		// TODO Auto-generated method stub
		return menu_InfoMapper.getFt_Menu_Info(menu_seq);
	}

	@Override
	public int ft_Menu_Edit(ADMIN_Menu_InfoDTO menuDTO) throws Exception {
		// TODO Auto-generated method stub
		return menu_InfoMapper.ft_Menu_Edit(menuDTO);
	}

	@Override
	public int ft_Menu_Delete(int menu_seq) throws Exception {
		// TODO Auto-generated method stub
		return menu_InfoMapper.ft_Menu_Delete(menu_seq);
	}

	@Override
	public int ft_Menu_Sort(ADMIN_Menu_InfoDTO menuDTO) throws Exception {
		// TODO Auto-generated method stub
		return menu_InfoMapper.ft_Menu_Sort(menuDTO);
	}
}
