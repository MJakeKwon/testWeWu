/*
 * 작성자 : 추경운
 * 작성일 : 2024-06-05
 */
package life.wewu.web.service.group;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import life.wewu.web.domain.group.GroupBoard;
import life.wewu.web.domain.group.GroupMember;

@Mapper
public interface GroupBoardDao {
	
	///필드
	
	///생성자
	
	///메소드
	public void addGroupBoard(GroupBoard groupBoard) throws Exception;
	
	public GroupBoard getGroupBoard(int boardNo) throws Exception;
	
	public List<GroupBoard> getGroupBoardList(int groupNo) throws Exception;
	
	public void updateGroupBoard(GroupBoard groupBoard) throws Exception;
	
	public void deleteGroupBoard(int boardNo) throws Exception;
}
