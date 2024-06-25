/*
 24.06.06 ItemPurchaseServiceImpl.java 최윤정 작성
 */

package life.wewu.web.service.item.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import life.wewu.web.domain.item.ItemPurchase;
import life.wewu.web.service.item.ItemPurchaseDao;
import life.wewu.web.service.item.ItemPurchaseService;

//==> 아이템 서비스 구현
@Service("itemPurchaseServiceImpl")
public class ItemPurchaseServiceImpl implements ItemPurchaseService{

	///Field
	@Autowired
	@Qualifier("itemPurchaseDao")
	private ItemPurchaseDao itemPurchaseDao;

	public void setItemPurchaseDao(ItemPurchaseDao itemPurchaseDao) {
		this.itemPurchaseDao = itemPurchaseDao;
	}

	///Constructor
	public ItemPurchaseServiceImpl() {
		System.out.println(this.getClass());
	}

	///Method
	@Override
	public void addPurchase(ItemPurchase itemPurchase) throws Exception {
		itemPurchaseDao.addPurchase(itemPurchase);
	}

    @Override
	public List<ItemPurchase> getRefundPointList(String buyerNickname) throws Exception{
		return itemPurchaseDao.getRefundPointList(buyerNickname);
	}

    @Override
	public ItemPurchase getRefundPoint(int itemPurchaseNo) throws Exception{
    	return itemPurchaseDao.getRefundPoint(itemPurchaseNo);
    }

    @Override
	public List<ItemPurchase> getItemSalesHistoryList() throws Exception{
    	return itemPurchaseDao.getItemSalesHistoryList();
    }

    @Override
	public ItemPurchase getItemSalesHistory(int itemPurchaseNo) throws Exception{
    	return itemPurchaseDao.getItemSalesHistory(itemPurchaseNo);
    }

    @Override
	public List<ItemPurchase> getItemPurchaseHistoryList(Map<String,Object> map) throws Exception{
    	return itemPurchaseDao.getItemPurchaseHistoryList(map);
    }

	@Override
	public ItemPurchase getItemPurchaseHistory(int itemPurchaseNo) throws Exception{
		return itemPurchaseDao.getItemPurchaseHistory(itemPurchaseNo);
	}

    @Override
	public void updatePurchase(ItemPurchase itemPurchase) throws Exception {
    	itemPurchaseDao.updatePurchase(itemPurchase);
    }



}
