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
public class Active {
	
	//dd
	private int activeNo;//active�� ��ȣ
	private int groupNo;//��� �׷��� Ȱ������ group ��ȣ
	private String groupName;//모임을 등록한 모임 이름
	private String activeName;//Ȱ�� �̸�
	private Date activeStartDate;//Ȱ�� ������
	private Date activeEndDate;//Ȱ�� ������
	private String activeX;//����
	private String activeY;//�浵
	private String activeStartTime;//Ȱ�� ���� �ð�
	private String activeEndTime;//Ȱ�� ���� �ð�
	private String activeInfo;//Ȱ�� �ڸ�Ʈ
	private String activeLocal;//Ȱ�� ����
	private Date activeRegDate;//Ȱ���� ��ϵ� ��¥
	private String stateFlag;//Ȱ�� ���� -> Y:���� D:������ => Ȱ���߰� Ȱ������� ���糯¥�� Ȱ�� ���� ��¥ ��
	private String activeUrl;//��Ŀ ������ ������ url
	private String activeShortUrl;//url�� short ����
	private String leaderNick;//�׷����� �г���
	private List<ActiveHash> hashList; //�ؽ� �±� ���� ����
	
	
}
