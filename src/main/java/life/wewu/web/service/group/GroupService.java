/*
 * 작성자 : 추경운
 * 작성일 : 2024-06-03
 */
package life.wewu.web.service.group;

import java.util.List;
import java.util.Map;

import life.wewu.web.common.Search;
import life.wewu.web.domain.board.Comment;
import life.wewu.web.domain.group.Group;
import life.wewu.web.domain.group.GroupAcle;
import life.wewu.web.domain.group.GroupBoard;
import life.wewu.web.domain.group.GroupMember;

public interface GroupService {
	///필드
	
	///생성자
	
	///메소드
	/* Group */
	public void addGroup(Group group) throws Exception;
	
	public Group getGroup(int GroupNo) throws Exception;
	
	public void deleteGroup(int GroupNo) throws Exception;
	
	public Group updateGroup(Group group) throws Exception;
	
	public Group updateGroupRslt(Group group) throws Exception;
	
	public String getGroupRanking(int GroupNo) throws Exception;
	
	public List<Group> getGroupList(Search search) throws Exception;
	
	public int getGroupListCnt(Search search) throws Exception;
	
	public List<Group> getGroupRankingList(Search search) throws Exception;
	
	public GroupMember getApplJoin(int memberNo) throws Exception;
	
	public Group getAddAppl(int GroupNo) throws Exception;
	
	public Group updateApplJoinForm(Group group) throws Exception;
	
	/* GroupMember */
	public GroupMember addMemberGroup(GroupMember groupMember) throws Exception;
	
	public GroupMember getMemberGroup(int memberNo) throws Exception;
	
	public GroupMember getMemberGroupForNick(Map<String,Object> map) throws Exception;
	
	public List<GroupMember> getMemberGroupList(Map<String, Object> map) throws Exception;
	
	public List<GroupMember> getApplJoinList(Map<String, Object> map) throws Exception;
	
	public GroupMember updateApplJoin(GroupMember groupMember) throws Exception;
	
	public GroupMember updateMemberGroup(GroupMember groupMember) throws Exception;
	
	public void deleteMemberGroup(int memberNo) throws Exception;
	
	public String getScrab(int GroupNo) throws Exception;
	
	public GroupMember updateScrab(GroupMember groupMember) throws Exception;
	
	public int groupMemberCnt(int groupNo) throws Exception;
	
	/* GroupBoard */
	public GroupBoard addGroupBoard(GroupBoard groupBoard) throws Exception;
	
	public GroupBoard getGroupBoard(int typeNo) throws Exception;
	
	public List<GroupBoard> getGroupBoardList(int groupNo) throws Exception;
	
	public GroupBoard updateGroupBoard(GroupBoard groupBoard) throws Exception;
	
	public void deleteGroupBoard(int typeNo) throws Exception;
	
	/* GroupAcle */
	public GroupAcle addGroupAcle(GroupAcle groupAcle) throws Exception;
	
	public GroupAcle getGroupAcle(int boardNo) throws Exception;
	
	public GroupAcle updateGroupAcle(GroupAcle groupAcle) throws Exception;
	
	public void deleteGroupAcle(int boardNo) throws Exception;
	
	public List<GroupAcle> getGroupAcleList(Map map) throws Exception;
	
	public int getGroupAcleListCnt(Map map) throws Exception;
	
	public int memberCommentListCnt(Map map) throws Exception;
	
	public int memberAcleListCnt(Map map) throws Exception;
	
	public List<GroupAcle> memberAcleList(Map map) throws Exception;
	
	public List<Comment> memberCommentList(Map map) throws Exception;
	
	public int groupAcleCnt(int groupNo) throws Exception;
	
	public void updateRole(String nickname) throws Exception;
	
}
