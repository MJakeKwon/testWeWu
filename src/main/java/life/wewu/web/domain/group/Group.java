/*
 * 작성자 : 추경운
 * 작성일 : 2024-06-03
 */
package life.wewu.web.domain.group;

import java.sql.Date;

import life.wewu.web.domain.user.User;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class Group {

	///필드
	private int groupNo;		//Pk 모임식별번호
	private String leaderNick;	//FK 모임장 닉네임
	private String groupName;	//모임명
	private String groupIntro;	//모임소개
	private String groupHash;	//모임해시태그
	private String groupAddr;	//모임주소
	private String groupPlan;	//모임활동계획
	private int groupPers;		//모임원수
	private String groupLevel;	//모임활동레벨
	private String groupFile;	//활동계획서파일
	private Date openDate;		//모임개설날짜
	private String groupRslt;	//모임개설신청상태
	private Date rsltDate;		//개설신청결과날짜
	private Date applDate;		//개설신청날짜
	private String groupRepl;	//개설신청코멘트
	private String frstQuest;	//모임가입 1번째 질문
	private String scndQuest;	//모임가입 2번째 질문
	private String thrdQuest;	//모임가입 3번째 질문
}
