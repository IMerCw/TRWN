package poly.service;

import java.util.List;

import poly.dto.admin.ADMIN_Order_InfoDTO;
import poly.dto.admin.ADMIN_Order_ItemDTO;

public interface ADMIN_IOrderService {
	public List<ADMIN_Order_InfoDTO> getOrder_List() throws Exception;
	public List<ADMIN_Order_InfoDTO> getOrder_List_Search(ADMIN_Order_InfoDTO orDTO) throws Exception;
	public int order_Delete(int ord_seq) throws Exception;
	
	public List<ADMIN_Order_ItemDTO> getOrder_Item_List(int item_seq) throws Exception;
	//test
}
