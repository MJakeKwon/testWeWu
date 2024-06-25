package life.wewu.web.domain.active;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Local {
	//필드
	private String title;
	private String address;
	private String roadAddress;
	private String mapX;
	private String mapY;
}
