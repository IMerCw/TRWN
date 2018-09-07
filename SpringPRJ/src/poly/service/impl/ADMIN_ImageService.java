package poly.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.admin.ADMIN_ImageDTO;
import poly.persistance.mapper.ADMIN_ImageMapper;
import poly.service.ADMIN_IImageService;

@Service("ADMIN_ImageService")
public class ADMIN_ImageService implements ADMIN_IImageService{
	
	@Resource(name="ADMIN_ImageMapper")
	private ADMIN_ImageMapper imageMapper;

	@Override
	public int Image_Add(ADMIN_ImageDTO imgDTO) throws Exception {
		// TODO Auto-generated method stub
		return imageMapper.Image_Add(imgDTO);
	}
	
	@Override
	public String getFile_Seq() throws Exception {
		// TODO Auto-generated method stub
		return imageMapper.getFile_Seq();
	}

	@Override
	public ADMIN_ImageDTO getImageInfo(String file_id) throws Exception {
		// TODO Auto-generated method stub
		return imageMapper.getImageInfo(file_id);
	}

	@Override
	public int Image_Edit(ADMIN_ImageDTO imgDTO) throws Exception {
		// TODO Auto-generated method stub
		return imageMapper.Image_Edit(imgDTO);
	}

	@Override
	public int Image_Delete(String file_id) throws Exception {
		// TODO Auto-generated method stub
		return imageMapper.Image_Delete(file_id);
	}

	@Override
	public List<ADMIN_ImageDTO> getMenuImage(List<String> temporary) throws Exception {
		return imageMapper.getMenuImage(temporary);
	}
}
