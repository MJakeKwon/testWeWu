package life.wewu.web.domain.plant;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Inventory {
	
	private int itemNo;			//아이템 식별번호
	private int itemPurNo;		//아이템 구매식별번호
	private String itemExp;		//아이템별 경험치
	private String itemType;	//아이템종류(식물인지 장식인지)
	private int itemNum;		//가지고 있는 아이템 수
	private String itemImg;		//아이템이미지
	private String nickname;
	private int useItemNum;
	private MyPlant myPlant;   // MyPlant 객체 추가

}
