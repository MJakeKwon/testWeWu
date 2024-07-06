/*
 * 작성자 : 추경운
 * 작성일 : 2024-06-05
 */
package life.wewu.web.service.group;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import life.wewu.web.common.Search;
import life.wewu.web.domain.group.GroupMember;

@Mapper
public interface GroupMemberDao {
	
	///필드
	
	///생성자
	
	///메소드
	
	public GroupMember getApplJoin(int memberNo) throws Exception;
	
	public GroupMember getMemberGroup(int memberNo) throws Exception;
	
	public GroupMember getMemberGroupForNick(Map<String,Object> map) throws Exception;
	
	public List<GroupMember> getMemberGroupList(Map<String, Object> map) throws Exception;
	
	public void addMemberGroup(GroupMember groupMember) throws Exception;
	
	public void updateMemberGroup(GroupMember groupMember) throws Exception;
	
	public void deleteMemberGroup(int memberNo) throws Exception;
	
	public String getScrab(int memberNo) throws Exception;
	
	public int groupMemberCnt(int groupNo) throws Exception;
	
}
