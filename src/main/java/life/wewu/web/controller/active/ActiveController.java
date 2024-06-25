package life.wewu.web.controller.active;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.sql.Date;
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
	
	//�ʵ�
	@Autowired
	@Qualifier("activeServiceImpl")
	private ActiveService activeService;
	
	@Autowired
	@Qualifier("groupService")
	private GroupService groupService;
	
	@Value("${map.clientId}")
	private String clientId;
	
	//�޼ҵ�
	//Ȱ�� ��� ������ �׺� GET
	@GetMapping(value = "addActive/{groupNo}")
	public String addActive(@PathVariable int groupNo, Model model) throws Exception {
		
		System.out.println("addActive NAVI");
		
		//지도 clientId
		model.addAttribute("clientId", clientId);
		
		model.addAttribute("group", groupService.getGroup(groupNo));
		
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
	public String getActive(@PathVariable int activeNo, Model model) throws Exception {
		
		System.out.println("getActive");
		
		//activeNo�� active�޾Ƽ� model�� ��� foward
		model.addAttribute("active", activeService.getActive(activeNo));
		
		//지도 clientId
		model.addAttribute("clientId", clientId);
		
		return "forward:/active/getActive.jsp";
	}
	
	//Ȱ�� ������Ʈ Navi
	@GetMapping(value = "updateActive/{activeNo}")
	public String updateActive(Model model, @PathVariable int activeNo) {
		
		System.out.println("updateActive Navi");
		
		model.addAttribute("active", activeService.getActive(activeNo));
		
		//지도 clientId
		model.addAttribute("clientId", clientId);
		
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
	public String deleteActive(@PathVariable int activeNo) throws Exception {
		
		System.out.println("deleteActive B/L");
		
		activeService.deleteActive(activeNo);
		
		return "forward:/active/listActive";
		
	}
	
	//���� Ȱ�� ��ȸ(ù �湮��)
	@GetMapping(value = "listActive")
	public String getActiveList(Model model, @RequestParam int groupNo) throws Exception {
	
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
		
		model.addAttribute("list", list);
		model.addAttribute("search", search);
		
		return "forward:/active/listActive.jsp";
		
	}
	
	//���� Ȱ�� ��� ��ȸ(���� ������ �̵�, �˻�)
	@PostMapping(value = "listActive")
	public String getActiveList(Model model, @ModelAttribute Search search, @RequestParam int groupNo) throws Exception {
		
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
		
		model.addAttribute("list", activeService.getGroupActiveList(map));
		
		return "forward:/active/listActive.jsp";
		
	}
	
	//���� Ȱ�� ����
	@GetMapping(value = "activeMap")
	public String activeMap(Model model, HttpSession session) throws Exception {
		
		System.out.println("activeMap");
		
		//�׷� ����Ʈ(T) => �����Ϸ�Ǹ�
		Search search = new Search();
		search.setSearchCondition("T");
		search.setCurrentPage(1);
		
		User user = (User)session.getAttribute("user");
		
		List<Group> list = groupService.getGroupList(search);
		
		for( Group group : list ) {
			
			GroupMember groupMember = groupService.getMemberGroupForNick(null);
			
		}
		
		model.addAttribute("groupList", new ObjectMapper().writeValueAsString(list));
		
		//Ȱ�� ����Ʈ(��ü)
		model.addAttribute("activeList", new ObjectMapper().writeValueAsString(activeService.getActiveList(search)));
		
		//System.out.println("::::: "+clientId);
		
		model.addAttribute("clientId", clientId);
		
		return "forward:/active/activeMap.jsp";
		
	}

}














