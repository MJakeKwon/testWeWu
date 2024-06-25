/*
 *	작성자: 최지원
 *	작성일: 2024-06-04 
 */
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
public class Board {
	
	//필드
	private int boardNo; 			//PK 게시판 식별번호
	private int boardType; 			//FK 게시판 종류
	private String nickName;		//FK 사용자 닉네임
	private String title; 			//게시판 제목
//	private List<BoardFile> fileNo ;//게시판 첨부 파일명//
	private int userGroupNo;
	private String contents;		//게시판 내용
	private Date regDate;			//등록 날짜
	private int thumnail;		//썸네일 이미지 번호//
	private int bookmarkCnt;		//즐겨찾기 수
	private int views;				//조회수
	private int commentCnt;			//댓글 수
	private List<Comment> commentNo;//댓글 //
	private boolean bookmarkFlag;
	
}
