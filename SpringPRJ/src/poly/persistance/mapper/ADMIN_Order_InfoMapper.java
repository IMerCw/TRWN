package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.admin.ADMIN_Order_InfoDTO;

@Mapper("ADMIN_Order_InfoMapper")
public interface ADMIN_Order_InfoMapper {
	public List<ADMIN_Order_InfoDTO> getOrder_List() throws Exception;
	public List<ADMIN_Order_InfoDTO> getOrder_List_Search(ADMIN_Order_InfoDTO orDTO) throws Exception;
	public int order_Delete(int ord_seq) throws Exception;
}
