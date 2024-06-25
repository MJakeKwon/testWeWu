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
public class Comment {
	private int commentNo;
	private int boardNo;
	private String commentNickName;
	private String commentContents;
	private Date commentDate;
	
}
