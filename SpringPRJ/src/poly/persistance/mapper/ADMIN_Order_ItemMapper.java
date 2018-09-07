package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.admin.ADMIN_Order_ItemDTO;

@Mapper("ADMIN_Order_ItemMapper")
public interface ADMIN_Order_ItemMapper {
	public List<ADMIN_Order_ItemDTO> getOrder_Item_List(int item_seq) throws Exception;
}
