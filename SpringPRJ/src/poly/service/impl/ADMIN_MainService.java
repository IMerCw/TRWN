package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.admin.ADMIN_Search_TrendDTO;
import poly.dto.admin.ADMIN_Site_StatDTO;
import poly.persistance.mapper.ADMIN_Search_TrendMapper;
import poly.persistance.mapper.ADMIN_Site_StatMapper;
import poly.persistance.mapper.ADMIN_User_InfoMapper;
import poly.service.ADMIN_IMainService;

@Service("ADMIN_MainService")
public class ADMIN_MainService implements ADMIN_IMainService{
	@Resource(name="ADMIN_User_InfoMapper")
	private ADMIN_User_InfoMapper user_InfoMapper;
	
	@Resource(name="ADMIN_Site_StatMapper")
	private ADMIN_Site_StatMapper site_statMapper;
	
	@Resource(name="ADMIN_Search_TrendMapper")
	private ADMIN_Search_TrendMapper search_TrendMapper;

	@Override
	public int getSite_Stat_Full(String value) throws Exception {
		// TODO Auto-generated method stub
		return site_statMapper.getSite_Stat_Full(value);
	}

	@Override
	public int getSite_Stat_Month(int value) throws Exception {
		// TODO Auto-generated method stub
		return site_statMapper.getSite_Stat_Month(value);
	}

	@Override
	public ADMIN_Site_StatDTO in_Site_Stat() throws Exception {
		// TODO Auto-generated method stub
		return site_statMapper.in_Site_Stat();
	}

	@Override
	public int getUser_Submit_Full(String value) throws Exception {
		// TODO Auto-generated method stub
		return user_InfoMapper.getUser_Submit_Full(value);
	}

	@Override
	public List<ADMIN_Search_TrendDTO> getSearch_Trend_List() throws Exception {
		// TODO Auto-generated method stub
		return search_TrendMapper.getSearch_Trend_List();
	}

	@Override
	public List<ADMIN_Search_TrendDTO> in_Search_Trend() throws Exception {
		// TODO Auto-generated method stub
		return search_TrendMapper.in_Search_Trend();
	}

}
