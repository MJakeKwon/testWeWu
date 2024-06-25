package life.wewu.web.service.item;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import life.wewu.web.domain.item.ItemPurchase;

@Mapper
public interface ItemPurchaseDao {

	public void addPurchase(ItemPurchase itemPurchase) throws Exception;

    public List<ItemPurchase> getRefundPointList(String buyerNickname) throws Exception; //다시확인

    public ItemPurchase getRefundPoint(int itemPurchaseNo) throws Exception;

    public List<ItemPurchase> getItemSalesHistoryList() throws Exception;

    public ItemPurchase getItemSalesHistory(int itemPurchaseNo) throws Exception;

	public List<ItemPurchase> getItemPurchaseHistoryList(Map<String,Object> map) throws Exception;

	public ItemPurchase getItemPurchaseHistory(int itemPurchaseNo) throws Exception;

    public void updatePurchase(ItemPurchase itemPurchase) throws Exception;

    public ItemPurchase getPointChargeList(int payNo) throws Exception;

    public ItemPurchase getPointCharge(int payNo) throws Exception;

    public void updatePointCharge(int payNo) throws Exception;

    public void addPointCharge(ItemPurchase itemPurchase) throws Exception;

}

















