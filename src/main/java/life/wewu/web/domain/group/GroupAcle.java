/*
 * 작성자 : 추경운
 * 작성일 : 2024-06-05
 */
package life.wewu.web.domain.group;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GroupAcle {
	private int boardNo;		//PK 게시글 번호
	private int typeNo;			//FK 게시판 번호
	private int memberNo; 		//FK 작성자 번호
	private String wrteName;	//FK 작성자 닉네임
	private String acleName;	//게시글 제목
	private String acleContents;//게시글 내용
	private Date wrteDate;		//작성 날짜
	private String imgSrc;		//썸네일사진
}
