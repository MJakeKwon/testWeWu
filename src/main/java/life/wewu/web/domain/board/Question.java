package life.wewu.web.domain.board;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Question {
	private int questionNo;
	private String title;				//제목
	private String contents;			//내용
	private String questionType;		//질문 종류 - 문의(1:1) , 자주(자주 하는 질문)
	private String questionCategory;	//문의 카테고리 - 배송문의, 개인정보 문의...
	private String nickName;			//사용자 닉네임
	private Date regDate;				//등록일
	private String reply;				//답변
	private Date replyDate;				//답변 등록일
	private String email;				//이메일 주소
	private String phoneNum;			//전화 번호
	private int replyState; 	//답변 상태 : 1- 문의 완료, 3-답변완료 

}
