package life.wewu.web.service.active;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import life.wewu.web.common.Search;
import life.wewu.web.domain.active.Active;
import life.wewu.web.domain.active.ActiveHash;

@Mapper
public interface ActiveDao {

	//�޼ҵ�
	public void addActive(Active active); //Ȱ�� ���
	
	public Active getActive(int activeNo); //Ȱ�� �� ��ȸ
	
	public void updateActive(Active active); //Ȱ�� ����
	
	public void deleteActive(int activeNo); //Ȱ�� ���� => flag�� 'D'��
	
	public List<Active> getActiveList(Search search); //Ȱ�� ���
	
	public List<Active> getGroupActiveList(Map<String, Object> map); //���� Ȱ�� ���
	
	public List<Active> getGroupActiveAllList(int groupNo);
	
	public void addActiveHash(ActiveHash activeHash); //�ؽ� �±� ���
	
	public int getActiveHashCount(int activeNo); //�ؽ� �±��� ����
	//ssss
	public List<ActiveHash> getActiveHashList(int activeNo); //Ȱ���� �ؽ� �±� ��ȸ

	public void deleteActiveHash(int activeNo); //Ȱ���� �ؽ� �±� ����
	
	public int countAllGroupActiveList(Map<String, Object> map);
	
}
