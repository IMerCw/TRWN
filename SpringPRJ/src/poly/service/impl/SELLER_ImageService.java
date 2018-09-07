package poly.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.seller.SELLER_ImageDTO;
import poly.persistance.mapper.SELLER_ImageMapper;
import poly.service.SELLER_IImageService;

@Service("SELLER_ImageService")
public class SELLER_ImageService implements SELLER_IImageService{
	
	@Resource(name="SELLER_ImageMapper")
	private SELLER_ImageMapper imageMapper;

	@Override
	public int Image_Add(SELLER_ImageDTO imgDTO) throws Exception {
		// TODO Auto-generated method stub
		return imageMapper.Image_Add(imgDTO);
	}
	
	@Override
	public String getFile_Seq() throws Exception {
		// TODO Auto-generated method stub
		return imageMapper.getFile_Seq();
	}

	@Override
	public SELLER_ImageDTO getImageInfo(String file_id) throws Exception {
		// TODO Auto-generated method stub
		return imageMapper.getImageInfo(file_id);
	}

	@Override
	public int Image_Edit(SELLER_ImageDTO imgDTO) throws Exception {
		// TODO Auto-generated method stub
		return imageMapper.Image_Edit(imgDTO);
	}

	@Override
	public int Image_Delete(String file_id) throws Exception {
		// TODO Auto-generated method stub
		return imageMapper.Image_Delete(file_id);
	}

	@Override
	public List<SELLER_ImageDTO> getMenuImage(List<String> temporary) throws Exception {
		return imageMapper.getMenuImage(temporary);
	}



}
