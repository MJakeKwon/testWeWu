/*
 * 작성자 : 추경운
 * 작성일 : 2024-06-03
 */
package life.wewu.web.service.group;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import life.wewu.web.common.Search;
import life.wewu.web.domain.group.Group;

@Mapper
public interface GroupDao {
	
	///필드
	
	///생성자
	
	///메소드
	public void addGroup(Group group) throws Exception;
	
	public Group getGroup(int groupNo) throws Exception;

	public void deleteGroup(int groupNo) throws Exception;
	
	public void updateGroup(Group group) throws Exception;
	
	public String getGroupRanking(int groupNo) throws Exception;
	
	public List<Group> getGroupList(Search search) throws Exception;
	
	public int getGroupListCnt(Search search) throws Exception;
	
	public void updateRole(String nickname) throws Exception;
	
}
