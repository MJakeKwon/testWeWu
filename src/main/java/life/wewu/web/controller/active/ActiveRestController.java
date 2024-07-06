package life.wewu.web.controller.active;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import life.wewu.web.common.Search;
import life.wewu.web.domain.active.Active;
import life.wewu.web.domain.active.Local;
import life.wewu.web.domain.group.Group;
import life.wewu.web.domain.group.GroupMember;
import life.wewu.web.domain.user.User;
import life.wewu.web.service.active.ActiveService;
import life.wewu.web.service.group.GroupService;
import life.wewu.web.service.local.LocalService;

@RestController
@RequestMapping(value = "/app/active/*")
public class ActiveRestController {

	//�ʵ�
	@Autowired
	@Qualifier(value = "activeServiceImpl")
	private ActiveService activeService;
	
	@Autowired
	@Qualifier(value = "groupService")
	private GroupService groupService;
	
	@Autowired
	@Qualifier(value = "localServiceImpl")
	private LocalService localService;
	
	//�޼ҵ�
	//rest active �˻�
	@PostMapping(value = "listActive")
	public List<Active> getActiveList(@RequestBody Search search) throws Exception {
		
		System.out.println("getActiveList");
		
		return activeService.getActiveList(search);
		
	}
	
	//������ Ȱ�� ��� ������
	@PostMapping(value = "listGroupActive")
	public Map<String, Object> getGroupActiveList(@RequestBody Search search, @RequestParam int groupNo) throws Exception {
		
		System.out.println("getGroupActiveList");
		
		System.out.println(":::::: "+search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("groupNo", new Integer(groupNo));
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		result.put("list", activeService.getGroupActiveList(map));
		result.put("isLast", activeService.isLastPage(map));
		
		return result;
	}
	
	@PostMapping(value = "listAllGroupActive/{groupNo}")
	public List<Active> getAllGroupActiveList(@PathVariable int groupNo) throws Exception {
		
		System.out.println("listAllGroupActive");
		
		return activeService.getGroupActiveAllList(groupNo);
		
	}
	
	//rest group ������, �˻�
	@PostMapping(value = "listGroup")
	public Map<String, Object> getGroupList(@RequestBody Search search, HttpSession session) throws Exception {
		
		System.out.println("getGroupList");
		
		User user = (User)session.getAttribute("user");
		
		search.setSearchCondition("search");
		search.setCurrentPage((search.getCurrentPage() - 1) * 10);		
		List<Group> groupList = groupService.getGroupList(search);
		List<GroupMember> memberList = new ArrayList<>();
		
		System.out.println("::: "+groupList.size());
		
		Map<String, Object> map = new HashMap<String, Object>();
		if(user != null) {
			map.put("memberNickName", user.getNickname());
		}
		
		System.out.println("::: "+map);
		
		for( Group group : groupList ) {
			
			if(user == null) {
				memberList.add(new GroupMember());
				System.out.println(":::::check");
				continue;
			}
			
			map.put("groupNo", group.getGroupNo());
			
			System.out.println("::: "+map);
			
			System.out.println("::::::"+groupService.getMemberGroupForNick(map));
			
			GroupMember groupMember = groupService.getMemberGroupForNick(map);
			memberList.add(groupMember);
			
		}
		
		boolean isLast = false;
		
		int groupListCnt = groupService.getGroupListCnt(search);
		
		if(groupListCnt == 0) {
			isLast = true;
		}else {
		
			int lastPage = (groupListCnt / 10) + 1;
			
			if(groupListCnt % 10 == 0) {
				lastPage -= 1;
			}
			
			System.out.println("::: "+isLast);
			
			if(search.getCurrentPage() != 0) {
				search.setCurrentPage(search.getCurrentPage() / 10 + 1);
			}else {
				search.setCurrentPage(1);
			}
			
			if(search.getCurrentPage() == lastPage) {
				isLast = true;
			}
		
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("groupList", groupList);
		result.put("memberList", memberList);
		result.put("isLast", isLast);
		
		System.out.println("::: "+result);
		
		return result;
		
	}
	
	//Ȱ���� ����
	@GetMapping(value = "getActive/{activeNo}")
	public Active getActive(@PathVariable int activeNo) throws Exception {
		
		System.out.println("getActive");
		
		return activeService.getActive(activeNo);
		
	}
	
	//���� ����
	@GetMapping(value = "getGroup/{groupNo}")
	public Group getGroup(@PathVariable int groupNo) throws Exception {
		
		System.out.println("getGroup");
		
		return groupService.getGroup(groupNo);
	}
	
	//지역 검색 api
	@GetMapping(value = "searchLocal")
	public Local searchAddress(@RequestParam String query) {
		
		return localService.getSearchLocal(query);
		
	}
	
}
