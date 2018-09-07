package poly.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import poly.dto.seller.SELLER_ImageDTO;

public interface SELLER_IImageService {
	public int Image_Add(SELLER_ImageDTO imgDTO) throws Exception;
	public String getFile_Seq() throws Exception;
	public SELLER_ImageDTO getImageInfo(String file_id) throws Exception;
	public int Image_Edit(SELLER_ImageDTO imgDTO) throws Exception;
	public int Image_Delete(String file_id) throws Exception;
	public List<SELLER_ImageDTO> getMenuImage(List<String> temporary) throws Exception;
}
