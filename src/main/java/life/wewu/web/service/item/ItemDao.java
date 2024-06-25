package life.wewu.web.service.item;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import life.wewu.web.common.Search;
import life.wewu.web.domain.item.Item;

@Mapper
public interface ItemDao {

	// INSERT 판매 아이템 등록
    public void addItem(Item item) throws Exception;

    // SELECT 아이템 상세정보조회
    public Item getItem(int itemNo) throws Exception;

    // SELECT 아이템 목록조회
    public List<Item> getItemList(Search search) throws Exception;

    // UPDATE 판매 아이템 수정
    public void updateItem(Item item) throws Exception;

    // DELETE 판매 아이템 삭제
    public void deleteItem(int itemNo) throws Exception;

    // SELECT 아이템 검색 결과
    public List<Item> getItemSearch(Search search) throws Exception;

	//Page 처리를 위한 전체Row(totalCount)  return
	//public int getTotalCount(Search search) throws Exception ;


}
















