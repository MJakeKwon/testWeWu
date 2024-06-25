package life.wewu.web.domain.board;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BoardFile {
	private int fileNo;
	private int boardNo;
	private String fileName;
	private String fileUUID;
	private String fileExt;
}
