package poly.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.admin.ADMIN_Order_InfoDTO;
import poly.dto.admin.ADMIN_Order_ItemDTO;
import poly.persistance.mapper.ADMIN_CouponMapper;
import poly.persistance.mapper.ADMIN_Coupon_IssueMapper;
import poly.persistance.mapper.ADMIN_Order_InfoMapper;
import poly.persistance.mapper.ADMIN_Order_ItemMapper;
import poly.service.ADMIN_IOrderService;

@Service("ADMIN_OrderService")
public class ADMIN_OrderService implements ADMIN_IOrderService{
	
	@Resource(name="ADMIN_Order_InfoMapper")
	private ADMIN_Order_InfoMapper orderMapper;
	
	@Resource(name="ADMIN_Order_ItemMapper")
	private ADMIN_Order_ItemMapper itemMapper;

	@Override
	public List<ADMIN_Order_InfoDTO> getOrder_List() throws Exception {
		// TODO Auto-generated method stub
		return orderMapper.getOrder_List();
	}

	@Override
	public List<ADMIN_Order_InfoDTO> getOrder_List_Search(ADMIN_Order_InfoDTO orDTO) throws Exception {
		// TODO Auto-generated method stub
		return orderMapper.getOrder_List_Search(orDTO);
	}

	@Override
	public int order_Delete(int ord_seq) throws Exception {
		// TODO Auto-generated method stub
		return orderMapper.order_Delete(ord_seq);
	}

	@Override
	public List<ADMIN_Order_ItemDTO> getOrder_Item_List(int item_seq) throws Exception {
		// TODO Auto-generated method stub
		return itemMapper.getOrder_Item_List(item_seq);
	}
}
