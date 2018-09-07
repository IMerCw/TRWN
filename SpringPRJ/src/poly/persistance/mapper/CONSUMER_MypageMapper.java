package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.consumer.CONSUMER_CouponIssueDTO;
import poly.dto.consumer.CONSUMER_FtLikeDTO;
import poly.dto.consumer.CONSUMER_OrderInfoDTO;
import poly.dto.consumer.CONSUMER_UserDTO;
import poly.dto.seller.SELLER_OrderInfoDTO;

@Mapper("CONSUMER_MypageMapper")
public interface CONSUMER_MypageMapper {
	public CONSUMER_UserDTO getUserDetail(CONSUMER_UserDTO uDTO) throws Exception;	//회원상세정보 불러오기
	public List<CONSUMER_CouponIssueDTO> couponList(String userSeq) throws Exception;	//내 쿠폰목록 불러오기
	public List<CONSUMER_FtLikeDTO> getFavoriteFt(String userSeq)throws Exception;	//관심매장 불러오기
	public List<CONSUMER_OrderInfoDTO> getOrderList(String userSeq)throws Exception;	//주문내역 불러오기


}
