package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.admin.ADMIN_Banner_PopDTO;
import poly.persistance.mapper.ADMIN_Banner_PopMapper;
import poly.service.ADMIN_IBannerService;

@Service("ADMIN_BannerService")
public class ADMIN_BannerService implements ADMIN_IBannerService{
	
	@Resource(name="ADMIN_Banner_PopMapper")
	private ADMIN_Banner_PopMapper banner_PopMapper;

	@Override
	public List<ADMIN_Banner_PopDTO> getBanner_List() throws Exception {
		// TODO Auto-generated method stub
		return banner_PopMapper.getBanner_List();
	}

	@Override
	public List<ADMIN_Banner_PopDTO> getBanner_List_Search(ADMIN_Banner_PopDTO bnDTO) throws Exception {
		// TODO Auto-generated method stub
		return banner_PopMapper.getBanner_List_Search(bnDTO);
	}

	@Override
	public int banner_Delete(int banner_seq) throws Exception {
		// TODO Auto-generated method stub
		return banner_PopMapper.banner_Delete(banner_seq);
	}

	@Override
	public ADMIN_Banner_PopDTO getBanner_Info(int banner_seq) throws Exception {
		// TODO Auto-generated method stub
		return banner_PopMapper.getBanner_Info(banner_seq);
	}

	@Override
	public int banner_Create(ADMIN_Banner_PopDTO bnDTO) throws Exception {
		// TODO Auto-generated method stub
		return banner_PopMapper.banner_Create(bnDTO);
	}

	@Override
	public int banner_Edit(ADMIN_Banner_PopDTO bnDTO) throws Exception {
		// TODO Auto-generated method stub
		return banner_PopMapper.banner_Edit(bnDTO);
	}
	
}
