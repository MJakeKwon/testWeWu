package life.wewu.web.service.item;

import java.util.List;

import life.wewu.web.common.Search;
import life.wewu.web.domain.item.Item;

public interface ItemService {

    public void addItem(Item item) throws Exception;

    public Item getItem(int itemNo) throws Exception;

    public List<Item> getItemList(Search search) throws Exception;

    public void updateItem(Item item) throws Exception;

    public void deleteItem(int itemNo) throws Exception;

    public List<Item> getItemSearch(Search search) throws Exception;

}


