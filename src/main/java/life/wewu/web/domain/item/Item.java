/* Item의 도메인
*
*
*/

package life.wewu.web.domain.item;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Item {
	private int itemNo; //아이템 번호
    private String itemCategory; //아이템 카테고리
    private String itemName; //아이템 이름
    private String itemEffect; //아이템 효과(아이템 적용시에 나타나는 효과)
    private String itemImg; //아이템 이미지
    private int itemPrice; //아이템 가격
    private Date itemRegdate; //아이템 등록날짜
    private String itemFlag; //판매 아이템 삭제 플래그 (아이템 구매내역, 판매내역 있음 : N, 아이템 구매내역, 판매내역 없음 : Y)
}
