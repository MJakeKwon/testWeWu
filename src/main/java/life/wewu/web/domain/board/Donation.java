package life.wewu.web.domain.board;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Donation {
	private int payNo;			//결제 번호
	private String userName;	//결제자 이름
	private String email;		//결제자 이메일
	private String phoneNum;	//결제자 전화번호
	private String userBirth;	//결제자 생년월일
	private Date payDate;		//결제 날짜
	private String payFlag;		//결제 플래그 	( 결제 성공 : T / 결제 실패 : F - default)
	private String payOption;		//결제 수단 	( 카카오페이 / 토스페이 )
	private String payType;		//결제 사용처	( 후원 / 포인트 충전)
	private int payAmount;		//결제 금액

}