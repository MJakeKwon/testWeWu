/*
 * 작성자 : 추경운
 * 작성일 : 2024-06-05
 */
package life.wewu.web.service.group;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import life.wewu.web.common.Search;
import life.wewu.web.domain.board.Comment;
import life.wewu.web.domain.group.GroupAcle;

@Mapper
public interface GroupAcleDao {
	
	///필드
	
	///생성자
	
	///메소드
	public void addGroupAcle(GroupAcle groupAcle) throws Exception;
	
	public GroupAcle getGroupAcle(int boardNo) throws Exception;
	
	public void updateGroupAcle(GroupAcle groupAcle) throws Exception;
	
	public void deleteGroupAcle(int boardNo) throws Exception;
	
	public List<GroupAcle> getGroupAcleList(Map map) throws Exception;
	
	public int getGroupAcleListCnt(Map map) throws Exception;
	
	public int groupAcleCnt(int groupNo) throws Exception;
	
	public int memberCommentListCnt(Map map) throws Exception;
	
	public int memberAcleListCnt(Map map) throws Exception;
	
	public List<GroupAcle> memberAcleList(Map map) throws Exception;
	
	public List<Comment> memberCommentList(Map map) throws Exception;
}
