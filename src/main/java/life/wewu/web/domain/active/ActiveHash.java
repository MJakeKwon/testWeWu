package life.wewu.web.domain.active;

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
public class ActiveHash {

	//�ʵ�
	private int hashNo;//�ؽ��±� d
	private int activeNo;//��� Ȱ���� �ؽ��±����� Ȱ�� ��ȣ
	private String hashName;//�ؽ��±� �̸�
	
}
