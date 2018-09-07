package poly.service;

import java.util.List;

import poly.dto.consumer.CONSUMER_CouponIssueDTO;

public interface CONSUMER_ICouponService {

	public List<CONSUMER_CouponIssueDTO> couponList(String userSeq) throws Exception;

}
