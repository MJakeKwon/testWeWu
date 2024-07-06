package life.wewu.web.controller.active;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.amazonaws.SdkClientException;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.AmazonS3Exception;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import life.wewu.web.common.Search;
import life.wewu.web.domain.active.Active;
import life.wewu.web.domain.group.Group;
import life.wewu.web.domain.group.GroupMember;
import life.wewu.web.domain.user.User;
import life.wewu.web.repository.S3Repository;
import life.wewu.web.service.active.ActiveService;
import life.wewu.web.service.group.GroupService;

import org.springframework.web.bind.annotation.RequestBody;


@Controller
@RequestMapping("/active/*")
public class ActiveController {
	
	//필드
	@Autowired
	@Qualifier("activeServiceImpl")
	private ActiveService activeService;
	
	@Autowired
	@Qualifier("groupService")
	private GroupService groupService;
	
	@Value("${map.clientId}")
	private String clientId;
	
	//메소드
	@GetMapping(value = "map")
	public String map(@ModelAttribute Search search, Model model) throws Exception {
		
		System.out.println("give map");
		
		List<Active> activeList = activeService.getActiveList(search);
		model.addAttribute("activeListString", new ObjectMapper().writeValueAsString(activeService.getActiveList(search)));
		
		model.addAttribute("clientId", clientId);
		
		model.addAttribute("activeList", activeList);
		
		return "/active/map";
	}
	
	//Ȱ�� ��� ������ �׺� GET
	@GetMapping(value = "addActive/{groupNo}")
	public String addActive(@PathVariable int groupNo, Model model, HttpSession session) throws Exception {
		
		System.out.println("addActive NAVI");
		
		User user = (User)session.getAttribute("user");	
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("groupNo", groupNo);
		map.put("memberNickName",user.getNickname());
		
		//지도 clientId
		model.addAttribute("clientId", clientId);
		
		model.addAttribute("group", groupService.getGroup(groupNo));
		
		model.addAttribute("groupMember", groupService.getMemberGroupForNick(map));
		
		return "forward:/active/addActive.jsp?groupNo="+groupNo;
		
	}
	
	//Ȱ�� ��� ����Ͻ� ����
	@PostMapping(value = "addActive")
	public String addActive(@ModelAttribute Active active, @RequestParam String hash, @RequestPart(required = false) MultipartFile file) throws Exception {
		
		System.out.println("addActive B/L");
		
		System.out.println("::::: " + active);
		
//		if(file == null || file.isEmpty()) {
//			System.out.println("file null");
//		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("active", active);
		map.put("hash", hash);
		map.put("file", file);
		
		//Ȱ�� ������ ����ϰ� �̹����� �ִٸ� �̹������� ���丮���� ���ε� �� short url���� �޴´�.
		activeService.addActive(map);
		
		return "forward:/active/listActive";
		
	}
	
	//Ȱ�� �� ��ȸ
	@GetMapping(value = "getActive/{activeNo}")
	public String getActive(@PathVariable int activeNo, Model model, HttpSession session) throws Exception {
		
		System.out.println("getActive");
		
		boolean isLeader = false;
		
		User user = (User)session.getAttribute("user");
		
		Active active = activeService.getActive(activeNo);
		
		if(user != null) {
			
			Group group = groupService.getGroup(active.getGroupNo());
			if(group.getLeaderNick().equals(user.getNickname())) {
				isLeader = true;
			}
			
		}
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("groupNo", active.getGroupNo());
		map.put("memberNickName",user.getNickname());
		
		//activeNo�� active�޾Ƽ� model�� ��� foward
		model.addAttribute("active", active);
		
		model.addAttribute("isLeader", isLeader);
		
		//지도 clientId
		model.addAttribute("clientId", clientId);
		
		model.addAttribute("group", groupService.getGroup(active.getGroupNo()));
		model.addAttribute("groupMember", groupService.getMemberGroupForNick(map));
		
		return "forward:/active/getActive.jsp";
	}
	
	//Ȱ�� ������Ʈ Navi
	@GetMapping(value = "updateActive/{activeNo}")
	public String updateActive(Model model, @PathVariable int activeNo, HttpSession session) throws Exception {
		
		System.out.println("updateActive Navi");
		
		Active active = activeService.getActive(activeNo);
		
		model.addAttribute("active", active);
		
		User user = (User)session.getAttribute("user");
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("groupNo", active.getGroupNo());
		map.put("memberNickName",user.getNickname());
		
		//지도 clientId
		model.addAttribute("clientId", clientId);
		
		model.addAttribute("group", groupService.getGroup(active.getGroupNo()));
		model.addAttribute("groupMember", groupService.getMemberGroupForNick(map));
		
		return "forward:/active/updateActive.jsp";
		
	}
	
	//Ȱ�� ������Ʈ B/L
	@PostMapping(value = "updateActive")
	public String updateActive(@ModelAttribute Active active, @RequestParam String hash, @RequestPart(required = false) MultipartFile file) throws Exception {
		
		System.out.println("updateActive B/L");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("active", active);
		map.put("hash", hash);
		map.put("file", file);
		
		//������Ʈ ����
		activeService.updateActive(map);
		
		System.out.println("updateActive B/L End");
		
		return "redirect:/active/getActive/"+active.getActiveNo();
	}
	
	@GetMapping(value = "deleteActive/{activeNo}")
	public String deleteActive(@PathVariable int activeNo, @RequestParam int groupNo) throws Exception {
		
		System.out.println("deleteActive B/L");
		
		activeService.deleteActive(activeNo);
		
		return "forward:/active/listActive?groupNo="+groupNo;
		
	}
	
	//���� Ȱ�� ��ȸ(ù �湮��)
	@GetMapping(value = "listActive")
	public String getActiveList(Model model, @RequestParam int groupNo, HttpSession session) throws Exception {
	
		System.out.println("listActive Get");
		
		Search search = new Search();
		
		search.setCurrentPage(1);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("groupNo", new Integer(groupNo));
		
		Boolean isLast = activeService.isLastPage(map);
		
		model.addAttribute("isLast", isLast);
		model.addAttribute("groupNo", groupNo);
		
		List<Active> list = activeService.getGroupActiveList(map);
		
		boolean isLeader = false;
		
		User user = (User)session.getAttribute("user");
		
		if(user != null) {
			
			Group group = groupService.getGroup(groupNo);
			if(group.getLeaderNick().equals(user.getNickname())) {
				isLeader = true;
			}
			
		}
		
		Map<String,Object> groupSearch = new HashMap<String, Object>();
		map.put("groupNo", groupNo);
		map.put("memberNickName",user.getNickname());
		
		model.addAttribute("group", groupService.getGroup(groupNo));
		model.addAttribute("groupMember", groupService.getMemberGroupForNick(groupSearch));
		
		model.addAttribute("list", list);
		model.addAttribute("search", search);
		model.addAttribute("isLeader", isLeader);
		
		return "forward:/active/listActive.jsp";
		
	}
	
	//���� Ȱ�� ��� ��ȸ(���� ������ �̵�, �˻�)
	@PostMapping(value = "listActive")
	public String getActiveList(Model model, @ModelAttribute Search search, @RequestParam int groupNo, HttpSession session) throws Exception {
		
		System.out.println("listActive Post");
		
		//System.out.println("::::: " + search);
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("groupNo", new Integer(groupNo));
		
		Boolean isLast = activeService.isLastPage(map);
		
		model.addAttribute("isLast", isLast);
		
		model.addAttribute("groupNo", groupNo);
		
		model.addAttribute("search", search);
		
		boolean isLeader = false;
		
		User user = (User)session.getAttribute("user");
		
		if(user != null) {
			
			Group group = groupService.getGroup(groupNo);
			if(group.getLeaderNick().equals(user.getNickname())) {
				isLeader = true;
			}
			
		}
		
		Map<String,Object> groupSearch = new HashMap<String, Object>();
		map.put("groupNo", groupNo);
		map.put("memberNickName",user.getNickname());
		
		model.addAttribute("group", groupService.getGroup(groupNo));
		model.addAttribute("groupMember", groupService.getMemberGroupForNick(groupSearch));
		
		model.addAttribute("list", activeService.getGroupActiveList(map));
		model.addAttribute("isLeader", isLeader);
		
		return "forward:/active/listActive.jsp";
		
	}
	
	//���� Ȱ�� ����
	@GetMapping(value = "activeMap")
	public String activeMap(Model model, HttpSession session) throws Exception {
		
		System.out.println("activeMap");
		
		Search search = new Search();
		search.setSearchCondition("Ranking");
		search.setCurrentPage(0);
		
		User user = (User)session.getAttribute("user");
		
		List<Active> activeList = activeService.getActiveList(search);
		List<Group> list = groupService.getGroupList(search);
		List<GroupMember> memberList = new ArrayList<>();
		
		Map<String, Object> map = new HashMap<String, Object>();
		if(user != null) {
			map.put("memberNickName", user.getNickname());
		}
		
		for( Group group : list ) {
			
			if(user == null) {
				memberList.add(new GroupMember());
				continue;
			}
			
			map.put("groupNo", group.getGroupNo());
			GroupMember groupMember = groupService.getMemberGroupForNick(map);
			memberList.add(groupMember);
			
		}
		
		model.addAttribute("groupListString", new ObjectMapper().writeValueAsString(list));
		
		//Ȱ�� ����Ʈ(��ü)
		model.addAttribute("activeListString", new ObjectMapper().writeValueAsString(activeService.getActiveList(search)));
		model.addAttribute("memberListString", new ObjectMapper().writeValueAsString(memberList));
		
		model.addAttribute("groupList", list);
		model.addAttribute("activeList", activeList);
		model.addAttribute("memberList", memberList);
		
		boolean isLast = false;
		
		int groupListCnt = groupService.getGroupListCnt(search);
		
		search.setCurrentPage(1);
		
		if(groupListCnt == 0) {
			isLast = true;
		}else {
		
			int lastPage = (groupListCnt / 10) + 1;
			
			if(groupListCnt % 10 == 0) {
				lastPage -= 1;
			}
			
			if(search.getCurrentPage() == lastPage) {
				isLast = true;
			}
			
		}
		//System.out.println("::::: "+clientId);
		
		model.addAttribute("clientId", clientId);
		
		model.addAttribute("isLast", isLast);
		
		return "forward:/active/activeMap.jsp";
		
	}

}














