/* Item Purchase의 도메인
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
@NoArgsConstructor
@AllArgsConstructor
@Data
public class ItemPurchase {
	private int itemPurchaseNo; //아이템 구매 번호
    private int itemNo; //아이템 번호
    private String itemName;
    private String itemPrice;
    private String buyerNickname; //아이템 구매자 닉네임
    private int itemCnt; //아이템 개수
    private Date itemPurchaseDate; //아이템 구매 날짜
    private Date refundCompdate; //환불 완료 날짜
    private Date refundAskdate; //환불 신청 날짜
    private int itemStock; //아이템 잔여량
    private String refundFlag; //환불 성공 여부
    private int afterRefundpoint; //환불 후 포인트
    private int beforeRefundpoint; //환불 전 포인트
    private int currentPoint; //현재 포인트
    private int refundPoint; //환불된 포인트
}
