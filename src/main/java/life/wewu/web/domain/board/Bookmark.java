/*
 *	작성자 : 최지원
 *	작성 날짜 : 2024-06-04
 */
package life.wewu.web.domain.board;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Bookmark {
	
	//필드
	private int bookmarkNo;			
	private int boardNo;
	private String nickName;
	
}
