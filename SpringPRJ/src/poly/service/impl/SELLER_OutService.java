package poly.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.seller.SELLER_FtSellerDTO;
import poly.dto.seller.SELLER_MenuJsDTO;
import poly.persistance.mapper.SELLER_OutMapper;
import poly.service.SELLER_IOutService;

@Service("SELLER_OutService")//service이름입니다.

public class SELLER_OutService implements SELLER_IOutService {

	@Resource(name="SELLER_OutMapper")
	private SELLER_OutMapper outMapper;

	@Override
	public SELLER_FtSellerDTO getOutTruckInfo(SELLER_FtSellerDTO ftsDTO) throws Exception {
		System.out.println("service ftsDTO : " + ftsDTO.getUserSeq());
		// TODO Auto-generated method stub
		return outMapper.getOutTruckInfo(ftsDTO);
	}

	@Override
	public SELLER_MenuJsDTO getItemDTO(SELLER_MenuJsDTO mDTO) throws Exception {
		// TODO Auto-generated method stub
		return outMapper.getItemDTO(mDTO);
	}
}
