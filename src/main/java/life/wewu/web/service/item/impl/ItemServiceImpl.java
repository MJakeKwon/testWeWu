/*
 24.06.06 ItemServiceImpl.java 최윤정 작성
 */

package life.wewu.web.service.item.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import life.wewu.web.common.Search;
import life.wewu.web.domain.item.Item;
import life.wewu.web.service.item.ItemDao;
import life.wewu.web.service.item.ItemService;


//==> 아이템 서비스 구현
@Service("itemServiceImpl")
public class ItemServiceImpl implements ItemService{

	///Field
	@Autowired
	@Qualifier("itemDao")
	private ItemDao itemDao;

	public void setItemDao(ItemDao itemDao) {
		this.itemDao = itemDao;
	}

	///Constructor
	public ItemServiceImpl() {
		System.out.println(this.getClass());
	}

	///Method
	@Override
	public void addItem(Item item) throws Exception {
		itemDao.addItem(item);
	}

	@Override
	public Item getItem(int itemNo) throws Exception{
	return itemDao.getItem(itemNo);
	}

	@Override
	public List<Item> getItemList(Search search) throws Exception{
		return itemDao.getItemList(search);
	}

	@Override
	public void updateItem(Item item) throws Exception{
		itemDao.updateItem(item);
	}

	@Override
	public void deleteItem(int itemNo) throws Exception{
		itemDao.deleteItem(itemNo);
	}

	@Override
	public List<Item> getItemSearch(Search search) throws Exception {
		return itemDao.getItemSearch(search);

	}

}




