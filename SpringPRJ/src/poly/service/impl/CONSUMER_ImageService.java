package poly.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.consumer.CONSUMER_ImageDTO;
import poly.persistance.mapper.CONSUMER_ImageMapper;
import poly.service.CONSUMER_IImageService;

@Service("CONSUMER_ImageService")
public class CONSUMER_ImageService implements CONSUMER_IImageService{
	
	@Resource(name="CONSUMER_ImageMapper")
	private CONSUMER_ImageMapper imageMapper;

	@Override
	public int Image_Add(CONSUMER_ImageDTO imgDTO) throws Exception {
		// TODO Auto-generated method stub
		return imageMapper.Image_Add(imgDTO);
	}
	
	@Override
	public String getFile_Seq() throws Exception {
		// TODO Auto-generated method stub
		return imageMapper.getFile_Seq();
	}

	@Override
	public CONSUMER_ImageDTO getImageInfo(String file_id) throws Exception {
		// TODO Auto-generated method stub
		return imageMapper.getImageInfo(file_id);
	}

	@Override
	public int Image_Edit(CONSUMER_ImageDTO imgDTO) throws Exception {
		// TODO Auto-generated method stub
		return imageMapper.Image_Edit(imgDTO);
	}

	@Override
	public int Image_Delete(String file_id) throws Exception {
		// TODO Auto-generated method stub
		return imageMapper.Image_Delete(file_id);
	}

	@Override
	public List<CONSUMER_ImageDTO> getMenuImage(List<String> temporary) throws Exception {
		return imageMapper.getMenuImage(temporary);
	}
}
