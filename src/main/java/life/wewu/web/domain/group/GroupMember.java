/*
 * 작성자 : 추경운
 * 작성일 : 2024-06-03
 */
package life.wewu.web.domain.group;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class GroupMember {

	///필드
	
	private int memberNo;			//pk 모임원번호
	private int groupNo;			//FK 모임번호
	private String memberNickName;	//모임원 닉네임
	private String scrabFlag;		//스크랩 여부
	private String joinFlag;		//가입여부
	private Date joinDate;			//가입날짜
	private Date applDate;			//가입신청날짜
	private Date rsltDate;			//가입결과날짜
	private String frstQuest;		//모임 1번째 질문
	private String scndQuest;		//모임 2번째 질문
	private String thrdQuest;		//모임 3번째 질문
	private String frstRepl;		//모임 1번째 답변
	private String scndRepl;		//모임 2번째 답변
	private String thrdRepl;		//모임 3번째 답변

}
