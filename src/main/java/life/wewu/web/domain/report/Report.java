/*
 * 작성자 : 추경운
 * 작성일 : 2024-06-03
 */
package life.wewu.web.domain.report;

import java.sql.Date;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class Report {

	///필드
	private int reportNo;			//PK 신고번호
	private int targetNo;			//FK 신고글번호
	private String reportNickname;	//신고자 닉네임
	private String targetNickname;	//신고대상닉네임
	private String rsltFlag;		//신고결과
	private Date rsltDate;			//신고결과날짜
	private String rsltRepl;		//신고답변
	private String reportNote;		//신고글내용
	private String reportType;		//신고타입
	private String reportContents;	//신고내용
}
