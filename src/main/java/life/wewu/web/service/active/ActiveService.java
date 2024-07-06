package life.wewu.web.service.active;

import java.util.List;
import java.util.Map;

import life.wewu.web.common.Search;
import life.wewu.web.domain.active.Active;
import life.wewu.web.domain.active.ActiveHash;

public interface ActiveService {

	public void addActive(Map<String, Object> map); //Ȱ�� ���
	
	public Active getActive(int activeNo); //Ȱ�� �� ��ȸ
	
	public void updateActive(Map<String, Object> map); //Ȱ�� ����
	
	public void deleteActive(int activeNo); //Ȱ�� ����
	//ssss
	public List<Active> getActiveList(Search search); //Ȱ�� ���
	
	public List<Active> getGroupActiveList(Map<String, Object> map); //���� Ȱ�� ���
	
	public List<Active> getGroupActiveAllList(int groupNo);
	
	public boolean isLastPage(Map<String, Object> map);
	
}
