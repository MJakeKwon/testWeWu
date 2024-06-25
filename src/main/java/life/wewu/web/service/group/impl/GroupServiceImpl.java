/*
 * 작성자 : 추경운
 * 작성일 : 2024-06-03
 */
package life.wewu.web.service.group.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import life.wewu.web.common.Search;
import life.wewu.web.domain.group.Group;
import life.wewu.web.domain.group.GroupAcle;
import life.wewu.web.domain.group.GroupBoard;
import life.wewu.web.domain.group.GroupMember;
import life.wewu.web.service.group.GroupAcleDao;
import life.wewu.web.service.group.GroupBoardDao;
import life.wewu.web.service.group.GroupDao;
import life.wewu.web.service.group.GroupMemberDao;
import life.wewu.web.service.group.GroupService;

@Service("groupService")
public class GroupServiceImpl implements GroupService{

	///필드
	@Autowired
	@Qualifier("groupDao")
	private GroupDao groupDao;
	
	@Autowired
	@Qualifier("groupMemberDao")
	private GroupMemberDao groupMemberDao;
	
	@Autowired
	@Qualifier("groupBoardDao")
	private GroupBoardDao groupBoardDao;
	
	@Autowired
	@Qualifier("groupAcleDao")
	private GroupAcleDao groupAcleDao;
	///생성자
	
	///메소드
	/* GroupDao */
	public void addGroup(Group group) throws Exception{
		
		//group 도메인을 인자로 하나의 모임을 insert하는 메소드
		groupDao.addGroup(group);
	}
	
	public Group getGroup(int groupNo) throws Exception {
		
		//group pk를 인자로 하나의 모임의 모든 정보를 select 하는 메소드
		return groupDao.getGroup(groupNo);
	}
	
	public void deleteGroup(int groupNo) throws Exception{
		
		//group pk를 인자로 하나의 모임 정보를 delete 하는 메소드
		groupDao.deleteGroup(groupNo);
	}
	
	public Group updateGroup(Group group) throws Exception {
		
		//group 도메인을 인자로 하나의 모임의 정보를 update 후 다시 select하는 메소드
		groupDao.updateGroup(group);
		return groupDao.getGroup(group.getGroupNo());
	}
	
	public Group updateGroupRslt(Group group) throws Exception {
		
		//group 도메인을 인자로 하나의 모임의 개설상태를 update 후 다시 select 하는 메소드
		groupDao.updateGroup(group);
		return groupDao.getGroup(group.getGroupNo());
	}
	
	public String getGroupRanking(int GroupNo) throws Exception {
	
		//group pk를 인자로 하나의 모임의 모임활동레벨을 select 하는 메소드
		return groupDao.getGroupRanking(GroupNo);
	}
	
	public List<Group> getGroupList(Search search) throws Exception {
		
		//search 도메인을 인자로 검색 요청에 따른 모든 모임의 정보를 select 하는 메소드
		return groupDao.getGroupList(search);
	}
	
	public List<Group> getGroupRankingList(Search search) throws Exception {
		
		//search 도메인을 인자로 검색 요청에 따른 모든 모임의 정보를 모임활동레벨 순으로 select 하는 메소드
		return groupDao.getGroupList(search);
	}
	
	public Group getAddAppl(int GroupNo) throws Exception {
		//group pk를 인자로 하나의 모임 정보를 select하는 메소드
		return groupDao.getGroup(GroupNo);
	}
	
	public Group updateApplJoinForm(Group group) throws Exception {
		
		//group 도메인을 인자로 모임의 추가 질문을 update 하는 메소드
		groupDao.updateGroup(group);
		return groupDao.getGroup(group.getGroupNo());
	}
	
	/* GroupMemberDao */
	
	public GroupMember addMemberGroup(GroupMember groupMember) throws Exception {
		
		//group_member 도메인을 인자로 해당 모임에 모임원을 insert
		groupMemberDao.addMemberGroup(groupMember);
		return groupMember;
	}
	
	public GroupMember getMemberGroup(int memberNo) throws Exception {

		//group_member pk를 인자로 해당 모임원의 정보를 select
		return groupMemberDao.getMemberGroup(memberNo);
		
	}
	
	public GroupMember getMemberGroupForNick(Map<String,Object> map) throws Exception {
		//user nickname과 group pk를 인자로 해당 유저의 모임원정보 select
		return groupMemberDao.getMemberGroupForNick(map);
	}
	
	public GroupMember getApplJoin(int memberNo) throws Exception {
		
		//group pk를 인자로 하나의 모임의 정보를 select 하는 메소드
		return groupMemberDao.getMemberGroup(memberNo);
	}
	
	public List<GroupMember> getApplJoinList(Map<String,Object> map) throws Exception {
		
		//search 도메인을 인자로 모든 모임의 정보를 select 하는 메소드
		return groupMemberDao.getMemberGroupList(map);
	}

	public List<GroupMember> getMemberGroupList(Map<String, Object> map) throws Exception {

		//group_member pk를 인자로 해당 모임원의 정보를 select
		return groupMemberDao.getMemberGroupList(map);
		
	}
	
	public GroupMember updateMemberGroup(GroupMember groupMember) throws Exception {
		
		//group_member pk를 인자로 해당 모임원의 정보를 update 후 다시 select
		groupMemberDao.updateMemberGroup(groupMember);
		return groupMemberDao.getMemberGroup(groupMember.getMemberNo());
	}
	
	public void deleteMemberGroup(int memberNo) throws Exception {
		
		//group_member pk를 인자로 해당 모임원의 정보를 delete
		groupMemberDao.deleteMemberGroup(memberNo);
	}
	
	public String getScrab(int memberNo) throws Exception {

		//group_member pk를 인자로 해당 모임원의 스크랩 여부를 select 
		return groupMemberDao.getScrab(memberNo);
		
	}
	
	public GroupMember updateScrab(GroupMember groupMember) throws Exception {
		
		//group_member 도메인을 인자로 해당 모임원의 정보 update 후 다시 select
		groupMemberDao.updateMemberGroup(groupMember);
		return groupMemberDao.getMemberGroup(groupMember.getMemberNo());
	}
	
	public GroupMember updateApplJoin(GroupMember groupMember) throws Exception {
		
		//group_member 도메인을 인자로 해당 모임원의 정보 update 후 다시 select
		groupMemberDao.updateMemberGroup(groupMember);
		return groupMemberDao.getMemberGroup(groupMember.getMemberNo());
	}

	/* GroupBoardDao */
	public GroupBoard addGroupBoard(GroupBoard groupBoard) throws Exception {
		
		//group_board 도메인을 인자로 해당 모임에 게시판을 insert
		groupBoardDao.addGroupBoard(groupBoard);
		return groupBoard;
	}
	
	public GroupBoard getGroupBoard(int typeNo) throws Exception {
		
		//board_type pk를 인자로 해당 게시판 정보를 select
		return groupBoardDao.getGroupBoard(typeNo);
	}
	
	public List<GroupBoard> getGroupBoardList(int groupNo) throws Exception {
		
		//group pk를 인자로 해당 모임에 생성된 groupBoard 리스트를 select
		return groupBoardDao.getGroupBoardList(groupNo);
	}
	
	public GroupBoard updateGroupBoard(GroupBoard groupBoard) throws Exception {
		
		//GroupBoard 도메인을 인자로 해당 모임 게시판의 정보를 update 후 다시 select
		groupBoardDao.updateGroupBoard(groupBoard);
		return groupBoardDao.getGroupBoard(groupBoard.getTypeNo());
	}
	
	public void deleteGroupBoard(int typeNo) throws Exception {
		
		//board_type pk를 인자로 해당 게시판의 정보를 delete
		groupBoardDao.deleteGroupBoard(typeNo);
	}
	
	/* GroupAcleDao */
	public GroupAcle addGroupAcle(GroupAcle groupAcle) throws Exception {
		
		//GroupAcle 도메인을 인자로 해당 게시판에 게시글을 insert
		groupAcleDao.addGroupAcle(groupAcle);
		return groupAcle;
	}
	
	public GroupAcle getGroupAcle(int boardNo) throws Exception {
		
		//board pk를 인자로 게시글의 정보를 select
		return groupAcleDao.getGroupAcle(boardNo);
	}
	
	public GroupAcle updateGroupAcle(GroupAcle groupAcle) throws Exception {
		
		//GroupAcle 도메인을 인자로 해당 게시글의 정보를 update 후 다시 select
		groupAcleDao.updateGroupAcle(groupAcle);
		return groupAcleDao.getGroupAcle(groupAcle.getBoardNo());
	}
	
	public void deleteGroupAcle(int boardNo) throws Exception {
		
		//board pk를 인자로 해당 게시글의 정보를 delete
		groupAcleDao.deleteGroupAcle(boardNo);
	}
	
	public List<GroupAcle> getGroupAcleList(Map map) throws Exception {
		
		//board_type pk를 인자로 해당 게시판의 게시글 목록을 select
		return groupAcleDao.getGroupAcleList(map);
	}
	
	public int getGroupAcleCnt(Map map) throws Exception {
		
		//board_type pk를 인자로 해당 게시판의 게시글 총 갯수를 select
		return groupAcleDao.getGroupAcleCnt(map);
	}
}
