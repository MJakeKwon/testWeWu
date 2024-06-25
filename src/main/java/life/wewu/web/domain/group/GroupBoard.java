/*
 * 작성자 : 추경운
 * 작성일 : 2024-06-05
 */
package life.wewu.web.domain.group;

import java.sql.Date;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class GroupBoard {
	private int typeNo;		//PK 게시판 번호
	private int groupNo;		//FK 모임번호
	private String boardType;	//게시판 UI 종류
	private String boardName;	//게시판 명
	private String boardIntro;	//게시판 소개
	private Date addDate;		//게시판 개설일
	private String boardRole;	//게시판 입력권한
}
