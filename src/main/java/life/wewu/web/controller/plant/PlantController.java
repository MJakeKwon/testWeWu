package life.wewu.web.controller.plant;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.http.ResponseEntity;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.configurationprocessor.json.JSONArray;
import org.springframework.boot.configurationprocessor.json.JSONException;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;

import life.wewu.web.common.Search;
import life.wewu.web.domain.plant.Inventory;
import life.wewu.web.domain.plant.MyPlant;
import life.wewu.web.domain.plant.Plant;
import life.wewu.web.domain.plant.PlantLevl;
import life.wewu.web.domain.plant.Quest;
import life.wewu.web.domain.user.User;
import life.wewu.web.repository.S3Repository;
import life.wewu.web.service.plant.PlantService;

@Controller
@RequestMapping("/plant/")
public class PlantController {
	
	@Autowired
	@Qualifier("plantServiceImpl")
	private PlantService plantService;
	
	@Autowired
	@Qualifier("s3RepositoryImpl")
	private S3Repository s3Repository;
	
	
	public PlantController() {
		System.out.println(this.getClass());
	}
	
	//----------------Quest
	@RequestMapping(value ="addQuest" , method = RequestMethod.GET)
	public String addQuest() throws Exception{	
		System.out.println(" /plant/addQuest : GET ");	
		return "forward:/plant/addQuest.jsp";	
	}
	
	@RequestMapping(value ="addQuest" , method = RequestMethod.POST)
	public String addQuest(@ModelAttribute("quest") Quest quest, Model model ,HttpSession session) throws Exception{	
		System.out.println(" /plant/addQuest : POST ");	
		User user = (User) session.getAttribute("user");
		quest.setNickName(user.getNickname());
		plantService.addQuest(quest);		
		model.addAttribute("quest", quest);
		model.addAttribute("user", user);	
		
		return "forward:/plant/addQuest.jsp";	
	}
	
	@RequestMapping(value ="updateQuest" , method = RequestMethod.GET)
	public String updateQuest(@RequestParam("questNo") int questNo, Model model) throws Exception{
		System.out.println(" /plant/updateQuest : GET ");
		Quest quest = plantService.getQuest(questNo);
		model.addAttribute("qeust", quest);
		return "forward:/plant/updateQuest.jsp";
	}
	

	@RequestMapping(value ="updateQuest" , method = RequestMethod.POST)
	public String updateQuest(@ModelAttribute("quest") Quest quest, Model model) throws Exception{
		System.out.println(" /plant/updateQuest : POST ");	
		int questNo = quest.getQuestNo();
		plantService.updateQuest(quest);		
		model.addAttribute("quest", quest);	
		System.out.println(questNo);
		return "forward:/plant/updateQuest.jsp";
	}

	@RequestMapping(value ="listQuest" , method = RequestMethod.GET)
	public String getQuestList(@ModelAttribute("search") Search search, Model model,@RequestParam(required= false)int questNo) throws Exception{
		
		Map<String,Object> map = plantService.getQuestList(search);
		
		model.addAttribute("map", map);
		model.addAttribute("search", search);
		
		System.out.println(map);
		
		return "forward:/plant/listQuest.jsp";
	}
	

	//----------------Plant
	
	@RequestMapping(value ="addPlant" , method = RequestMethod.GET)
	public String addPlant() throws Exception{
		System.out.println(" /plant/addPlant : get ");		
		
		return "forward:/plant/addPlant.jsp";	
	}

	@RequestMapping(value ="addPlant" , method = RequestMethod.POST)
	public String addPlant(@ModelAttribute("plantLevl") PlantLevl plantLevl, 
							@ModelAttribute("plant") Plant plant ,
							Model model,
							@RequestPart(required = false) MultipartFile file) throws Exception{
		
		System.out.println(" /plant/addPlant : POST ");	
		
		if(!file.isEmpty()) {
	         Map<String, Object> map = new HashMap<String, Object>();
	         map.put("file", file);
	         map.put("folderName", "plant");
	         
	         String url = s3Repository.uplodaFile(map);
	         
	
	         plantLevl.setLevlImg(s3Repository.getShortUrl(url));
	         
	      }
		
		plantService.addPlant(plant, plantLevl);
		
		model.addAttribute("file", file);
		model.addAttribute("plantLevl", plantLevl);
		model.addAttribute("plant", plant);
		
		return "forward:/plant/addPlant.jsp";	
	}
	

	@RequestMapping(value ="getPlant" , method = RequestMethod.GET)
	public String getPlant(@RequestParam("plantNo") int plantNo , Model model) throws Exception{
		System.out.println(" /plant/getPlant : POST ");		
		Plant plant = plantService.getPlant(plantNo);
		model.addAttribute("plant", plant);
		
		return "forward:/plant/getPlant.jsp";
	}
	
	@RequestMapping(value ="listPlant" , method = RequestMethod.GET)
	public String getPlantList( Model model,@ModelAttribute("search") Search search ,@RequestParam(required= false) int plantNo) throws Exception{
		
		System.out.println(" /plant/listPlant : GET ");	 
		Map<String,Object> map = plantService.getPlantList(search);
		model.addAttribute("map", map);
		model.addAttribute("search", search);
		
		return "forward:/plant/listPlant.jsp";
	}
	
	@RequestMapping(value ="updatePlant" , method = RequestMethod.GET)
	public String updatePlant() throws Exception{
		System.out.println(" /plant/updatePlant : GET ");	
		return "forward:/plant/updatePlant.jsp";
	}
	
	@RequestMapping(value ="updatePlant" , method = RequestMethod.POST)
	public String updatePlant(@ModelAttribute("plant") Plant plant, Model model) throws Exception{
		System.out.println(" /plant/updatePlant : POST ");	
		int plantNo = plant.getPlantNo();
		plantService.updatePlant(plant);
		model.addAttribute("plant", plant);
		
		return "forward:/plant/updatePlant.jsp";
	}

	//----------------MyPlant
	
	@RequestMapping(value ="selectRandomPlant" , method = RequestMethod.POST)
	public String selectRandomPlant(Model model) throws Exception{
		System.out.println(" /plant/selectRandomPlant : POST ");
		Plant plant = plantService.selectRandomPlant();
		model.addAttribute("plant", plant);
		
		return "forward:/plant/selectRandomPlant.jsp";
	}
	
	@RequestMapping(value ="addRandomPlant" , method = RequestMethod.POST)
	public String addRandomPlant(HttpServletRequest request, HttpSession session) throws Exception{
		System.out.println(" /plant/addRandomPlant : POST ");
		User user = (User) session.getAttribute("user");
		Plant plant = plantService.selectRandomPlant();
		MyPlant myPlant = new MyPlant();
		myPlant.setPlant(plant);
		myPlant.setNickname(request.getParameter("user"));
		myPlant.setMyPlantName(request.getParameter("myPlantName"));
		plantService.addRandomPlant(myPlant);
		
		return "forward:/plant/addRandomPlant.jsp";
	}
	
	//getMyPlant.jsp
	@RequestMapping(value ="getMyPlant" , method = RequestMethod.GET)
	public String getMyPlant(@RequestParam(required= false) int myPlantNo,Model model) throws Exception{
		System.out.println(" /plant/getMyPlant : GET ");
		MyPlant myPlant = plantService.getMyPlant(myPlantNo);
		System.out.println(myPlant);
		model.addAttribute("myPlant", myPlant);
		
		return "forward:/plant/getMyPlant.jsp";
	}
	
	//history.jsp
	@RequestMapping(value ="history" , method = RequestMethod.GET)
	public String getMyPlantList(@ModelAttribute("search") Search search, Model model, HttpSession session) throws Exception{
		System.out.println("/plant/history : GET");
		
		User user = (User) session.getAttribute("user");
		
		Map<String,Object> map = new HashMap<String,Object>();
		search.setSearchKeyword("past");
	
		
		map.put("search",search);
		map.put("user",user);
		
		List<MyPlant> list = plantService.getMyPlantList(map);
		System.out.println("map = " + map);
		System.out.println("List = " +list);
		List<MyPlant> allList= new ArrayList<MyPlant>();
		
		for(MyPlant myPlant : list)
		{
			myPlant.setPlant(plantService.getPlant(myPlant.getPlant().getPlantNo()));
			myPlant.setPlantLevl(plantService.getPlantLevl(myPlant.getPlantLevl().getPlantLevlNo()));
			
			allList.add(myPlant);
		}
		
		 System.out.println("All List Size: " + allList.size());
		
		model.addAttribute("allList", allList);

		return "forward:/plant/history.jsp";
	}
	
	

	//----------------Inventory
	@RequestMapping(value ="inventory" , method = RequestMethod.GET)
	public String getInventory(@RequestParam("itemPurNo") int itemPurNo,Model model) throws Exception{
		System.out.println(" /plant/getInventory : POST ");
		Inventory inventory = plantService.getInventory(itemPurNo);
		model.addAttribute("inventory", inventory);
		
		return "forward:/plant/inventory.jsp";
	}

	
	//----------------etc
	

	@RequestMapping(value ="fileUpload" , method = RequestMethod.POST)
	public void fileUpload() throws Exception{
		
	}
	
	
		
}
	
	
	


