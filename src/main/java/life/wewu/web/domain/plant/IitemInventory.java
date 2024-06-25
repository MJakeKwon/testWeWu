package life.wewu.web.domain.plant;

import java.sql.Date;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class IitemInventory {
	
	//field
	
	private int inventoryNo;		//인벤토리식별번호
	private int itemNo;				//아이템식별번호
	private String itemState;		//아이템상태(Y,N)
	private String itemType;		//아이템카테고리
	private int itemNum;			//가지고있는아이템수

}
