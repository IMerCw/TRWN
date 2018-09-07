package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.consumer.CONSUMER_CouponIssueDTO;
import poly.persistance.mapper.CONSUMER_CouponMapper;
import poly.persistance.mapper.CONSUMER_MypageMapper;
import poly.service.CONSUMER_ICouponService;

@Service("CONSUMER_CouponService")
public class CONSUMER_CouponService implements CONSUMER_ICouponService{
	
	@Resource(name="CONSUMER_CouponMapper")
	private CONSUMER_CouponMapper couponMapper;
	
	@Resource(name="CONSUMER_MypageMapper")
	private CONSUMER_MypageMapper mypageMapper;
	
	
	@Override
	public List<CONSUMER_CouponIssueDTO> couponList(String userSeq) throws Exception {
		return mypageMapper.couponList(userSeq);
	}

}
