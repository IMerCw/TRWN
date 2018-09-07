package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.seller.SELLER_FtSellerDTO;
import poly.dto.seller.SELLER_WaitDTO;
import poly.persistance.mapper.SELLER_OrderWaitMapper;
import poly.service.SELLER_IOrderWaitService;

@Service("SELLER_OrderWaitService")//service이름입니다.

public class SELLER_OrderWaitService implements SELLER_IOrderWaitService {
	@Resource(name="SELLER_OrderWaitMapper")
	private SELLER_OrderWaitMapper sELLER_OrderWaitMapper;

	@Override
	public SELLER_FtSellerDTO getftSeqDTO(SELLER_FtSellerDTO ftsDTO) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("service : "+ ftsDTO.getUserSeq());
		return sELLER_OrderWaitMapper.getftSeqDTO(ftsDTO);
	}

	@Override
	public List<SELLER_WaitDTO> getwaitDTO(SELLER_WaitDTO wDTO) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("service ftSEq : " + wDTO.getFtSeq());
		return sELLER_OrderWaitMapper.getwaitDTO(wDTO);
	}

	@Override
	public List<SELLER_WaitDTO> getWaitComplete(SELLER_WaitDTO wDTO) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("service wDTO : " + wDTO.getFtSeq());
		int result = sELLER_OrderWaitMapper.updateWaitSeq(wDTO);
		System.out.println( "result : " + result);
		if(result == 1) {
			System.out.println("get List start");
			List<SELLER_WaitDTO> wList = sELLER_OrderWaitMapper.getwaitDTO(wDTO);
			return wList;
		}
		
		return null;
	}
	
	
}
