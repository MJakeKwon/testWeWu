/* Pay의 도메인
*
*
*/

package life.wewu.web.domain.pay;

import java.sql.Date;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class Pay {
	private int payNo; //결제 번호
    private String buyerNickname; //결제자 닉네임&아이템 구매자 사용자 닉네임
    private String payOption; //결제 수단 (결제 수단 종류)
    private String payType; //결제 사용처(결제가 포인트 결제인지, 후원 결제인지에 대한 정보)
    private int payAmount; //결제 금액
    private int currentPoint; //현재 포인트
    private int afterChargePoint; //충전 후 포인트
    private String payFlag; //결제 플래그(결제 성공, 결제 실패, 환불)
    private Date payDate; //결제 날짜
    private Date deletePayDate; //결제 취소 날짜
}
