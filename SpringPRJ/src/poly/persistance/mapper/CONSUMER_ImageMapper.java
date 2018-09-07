package poly.persistance.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import config.Mapper;
import poly.dto.consumer.CONSUMER_ImageDTO;

@Mapper("CONSUMER_ImageMapper")
public interface CONSUMER_ImageMapper {
	public int Image_Add(CONSUMER_ImageDTO imgDTO) throws Exception;
	public String getFile_Seq() throws Exception;
	public CONSUMER_ImageDTO getImageInfo(String file_id) throws Exception;
	public int Image_Edit(CONSUMER_ImageDTO imgDTO) throws Exception;
	public int Image_Delete(String file_id) throws Exception;
	public List<CONSUMER_ImageDTO> getMenuImage(List<String> temporary) throws Exception;
}
