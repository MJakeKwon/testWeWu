package life.wewu.web.service.item;

import java.util.List;
import java.util.Map;

import life.wewu.web.domain.item.ItemPurchase;

public interface ItemPurchaseService {

	public void addPurchase(ItemPurchase itemPurchase) throws Exception;

    public List<ItemPurchase> getRefundPointList(String buyerNickname) throws Exception;

    public ItemPurchase getRefundPoint(int itemPurchaseNo) throws Exception;

    public List<ItemPurchase> getItemSalesHistoryList() throws Exception; //다시확인

    public ItemPurchase getItemSalesHistory(int itemPurchaseNo) throws Exception;

    public List<ItemPurchase> getItemPurchaseHistoryList(Map<String,Object> map) throws Exception;

	public ItemPurchase getItemPurchaseHistory(int itemPurchaseNo) throws Exception;

    public void updatePurchase(ItemPurchase itemPurchase) throws Exception;

}


