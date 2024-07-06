package life.wewu.web.controller.plant;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.configurationprocessor.json.JSONArray;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import life.wewu.web.common.Search;
import life.wewu.web.domain.plant.Inventory;
import life.wewu.web.domain.plant.MyPlant;
import life.wewu.web.domain.plant.Plant;
import life.wewu.web.domain.plant.PlantLevl;
import life.wewu.web.domain.plant.PlantRequest;
import life.wewu.web.domain.plant.Quest;
import life.wewu.web.domain.user.User;
import life.wewu.web.repository.S3Repository;
import life.wewu.web.service.plant.PlantDao;
import life.wewu.web.service.plant.PlantService;

@RestController
@RequestMapping("/app/plant/")
public class PlantRestController {

	@Autowired
	@Qualifier("plantServiceImpl")
	private PlantService plantService;

	@Value("${weather.api.key}")
	private String apiKey;

	@Autowired
	private RestTemplate restTemplate;

	@Autowired
	@Qualifier("s3RepositoryImpl")
	private S3Repository s3Repository;

	public PlantRestController() {
		System.out.println(this.getClass());
	}

	@RequestMapping(value = "addPlantName", method = RequestMethod.POST)
	public Map<String, Object> addPlant(@RequestPart("plant") Plant plant, Model model) throws Exception {
		System.out.println("::plant::REST::addPlantName : POST");
		plantService.addPlantName(plant);
		model.addAttribute("plant", plant);
		System.out.println("plant:" + plant);

		Map<String, Object> map = new HashMap<>();
		map.put("plantNo", plant.getPlantNo());

		return map;
	}

	@RequestMapping(value = "addPlantLevl", method = RequestMethod.POST)
	public PlantLevl addPlantLevel(@RequestPart("plantLevl") PlantLevl plantLevl,
			@RequestPart(required = false) MultipartFile file) throws Exception {

		System.out.println("::plant::REST::addPlantLevl : POST");

		Map<String, Object> map = new HashMap<>();

		System.out.println("PlantLevl: " + plantLevl.toString());

		if (file != null) {
			System.out.println("File: " + file.getOriginalFilename());
		} else {
			System.out.println("File is null");
		}

		if (file != null && !file.isEmpty()) {
			Map<String, Object> fileMap = new HashMap<>();
			fileMap.put("file", file);
			fileMap.put("folderName", "plant");

			try {
				String url = s3Repository.uplodaFile(fileMap);
				plantLevl.setLevlImg(s3Repository.getShortUrl(url));
			} catch (Exception e) {
				e.printStackTrace();
				throw new Exception("File upload failed", e);
			}
		}

		plantService.addPlantLevl(plantLevl);
		map.put("plantLevl", plantLevl);

		return plantLevl;
	}
	
	@RequestMapping(value = "deletePlant")
	public Plant deleteplant(@RequestBody Plant plant, Model model) throws Exception {
		System.out.println("::plant::REST::deleteQuest : POST");
		plantService.deletePlant(plant.getPlantNo());
		model.addAttribute("plant", plant);

		return plant;
	}

	@RequestMapping(value = "updatePlant", method = RequestMethod.POST)
	public Map<String, Object> updatePlant(@RequestPart("plantRequest") PlantRequest plantRequest, Model model,
			@RequestPart(required = false) MultipartFile file) throws Exception {
		System.out.println("::plant::REST::updatePlant : POST");

		Plant plant = plantRequest.getPlant();
		PlantLevl plantLevl = plantRequest.getPlantLevl();

		if (file != null) {
			System.out.println("File: " + file.getOriginalFilename());
		} else {
			System.out.println("File is null");
		}

		if (file != null && !file.isEmpty()) {
			Map<String, Object> fileMap = new HashMap<>();
			fileMap.put("file", file);
			fileMap.put("folderName", "plant");

			try {
				String url = s3Repository.uplodaFile(fileMap);
				plantLevl.setLevlImg(s3Repository.getShortUrl(url));
			} catch (Exception e) {
				e.printStackTrace();
				throw new Exception("File upload failed", e);
			}
		}

		Map<String, Object> map = new HashMap<>();
		plantService.updatePlant(plantRequest);

		System.out.println(plant);
		System.out.println(plantRequest);

		map.put("plant", plant);
		map.put("plantLevl", plantLevl);

		return map;
	}

	@RequestMapping(value = "getQuest", method = RequestMethod.POST)
	public Quest getQuest(@RequestParam("questNo") int questNo, HttpSession session) throws Exception {
		System.out.println("::plant::REST::getQuest : POST");

		// 세션에 퀘스트 정보 추가
		Quest quest = (Quest) session.getAttribute("quest");
		if (quest == null) {
			// 세션에 퀘스트 정보가 없으면 새로운 퀘스트 객체 생성
			quest = new Quest();
			session.setAttribute("quest", quest);
		}

		User user = (User) session.getAttribute("user");

		// 퀘스트 정보를 서비스에서 가져옴
		quest = plantService.getQuestByUser(user.getNickname());

		// 세션에 퀘스트 정보 업데이트
		session.setAttribute("quest", quest);

		return quest;
	}

	@RequestMapping(value = "getQuestList", method = RequestMethod.POST)
	public Map<String, Object> getQuestList(@RequestBody Search search, Model model, HttpSession session)
			throws Exception {
		System.out.println("::plant::REST::getQuestList : POST");

		// 세션에 퀘스트 정보 추가
		Quest quest = (Quest) session.getAttribute("quest");
		if (quest == null) {
			// 세션에 퀘스트 정보가 없으면 새로운 퀘스트 객체 생성
			quest = new Quest();
			session.setAttribute("quest", quest);
		}

		Map<String, Object> map = plantService.getQuestList(search);
		model.addAttribute("map", map);
		model.addAttribute("search", search);
		System.out.println("QeustList : " + map.get("list"));

		session.setAttribute("questList", map.get("list"));

		return map;
	}

	@RequestMapping(value = "completeQuest", method = RequestMethod.POST)
	public Quest completeQuest(@RequestBody Quest quest) throws Exception {
		System.out.println("::plant::REST::completeQuest : POST");

		plantService.completeQuest(quest);

		return quest;
	}

	@RequestMapping(value = "updateQuest", method = RequestMethod.POST)
	public Map<String, Object> updateQuest(@RequestBody Quest quest) throws Exception {
		System.out.println("::plant::REST::updateQuest : POST");

		Map<String, Object> map = new HashMap<>();
		plantService.updateQuest(quest);

		System.out.println(quest);

		map.put("quest", quest);

		return map;
	}

	@RequestMapping(value = "deleteQuest")
	public Quest deleteQuest(@RequestBody Quest quest, Model model) throws Exception {
		System.out.println("::plant::REST::deleteQuest : POST");
		plantService.addQuest(quest);
		model.addAttribute("quest", quest);

		return quest;
	}

	// getMyPlant.jsp
	@RequestMapping(value = "getMyPlant", method = RequestMethod.GET)
	public MyPlant getMyPlant(Model model, HttpSession session) throws Exception {
		System.out.println("::plant::REST::getMyPlant : POST");

		User user = (User) session.getAttribute("user");
		MyPlant myPlant = plantService.getMyPlant(user.getNickname());

		PlantLevl plantLevl = plantService.getPlantLevl(myPlant.getPlantLevl().getPlantLevlNo());
		myPlant.setPlantLevl(plantLevl);

		System.out.println("myPlant : " + myPlant);
		session.setAttribute("myPlant", myPlant);

		model.addAttribute("user", user);
		model.addAttribute("myPlant", myPlant);
		model.addAttribute("plantLevl", plantLevl);

		return myPlant;
	}

	@RequestMapping(value = "getMyPlant", method = RequestMethod.POST)
	public MyPlant getMyPlant(HttpSession session, Model model) throws Exception {

		System.out.println("::plant::REST::getMyPlant : POST");

		User user = (User) session.getAttribute("user");

		MyPlant myPlant = plantService.getMyPlant(user.getNickname());
		PlantLevl plantLevl = plantService.getPlantLevl(myPlant.getPlantLevl().getPlantLevlNo());
		myPlant.setPlantLevl(plantLevl);

		System.out.println(myPlant);
		System.out.println(plantLevl);
		session.setAttribute("myPlant", myPlant);

		model.addAttribute("user", user);
		model.addAttribute("myPlant", myPlant);

		return myPlant;

	}

	@RequestMapping(value = "myPlantListbyLevlNo")
	public List<MyPlant> myPlantListbyLevlNo(HttpSession session, Model model,
			@RequestParam(value = "searchCondition", required = false) String searchCondition,
			@RequestParam(value = "searchKeyword", required = false) String searchKeyword) throws Exception {

		System.out.println("::plant::REST::myPlantListbyLevlNo : POST");
		User user = (User) session.getAttribute("user");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nickname", user.getNickname());

		Search search = new Search();
		search.setSearchCondition(searchCondition);
		search.setSearchKeyword(searchKeyword);
		map.put("search", search);

		System.out.println("map = " + map);

		List<MyPlant> list = plantService.myPlantListbyLevlNo(map);

		System.out.println("List = " + list);

		model.addAttribute("list", list);

		return list;

	}

	// history.jsp
	@RequestMapping(value = "history", method = RequestMethod.GET)
	public List<MyPlant> getMyPlantList(
			@RequestParam(value = "searchCondition", required = false) String searchCondition,
			@RequestParam(value = "searchKeyword", required = false) String searchKeyword, Model model,
			HttpSession session) throws Exception {
		System.out.println("::plant::REST::history : POST");

		User user = (User) session.getAttribute("user");

		Map<String, Object> map = new HashMap<String, Object>();
		Search search = new Search();
		search.setSearchCondition(searchCondition);
		search.setSearchKeyword(searchKeyword);
		map.put("search", search);
		map.put("nickname", user.getNickname());

		System.out.println("map = " + map);

		List<MyPlant> list = plantService.getMyPlantList(map);

		System.out.println("List = " + list);

		model.addAttribute("list", list);
		model.addAttribute("search", search);

		return list;
	}

	@RequestMapping(value = "deleteMyPlant")
	public MyPlant deleteMyPlant(@RequestBody PlantRequest plantRequest, Model model, HttpSession session)
			throws Exception {
		System.out.println("::plant::REST::deleteMyPlant : POST");

		int plantNo = plantRequest.getPlantNo();
		MyPlant myPlant = new MyPlant();
		myPlant.setPlantNo(plantNo);

		User user = (User) session.getAttribute("user");
		System.out.println("User: " + user);
		plantService.getMyPlant(user.getNickname());
		System.out.println(myPlant);
		plantService.deleteMyPlant(user.getNickname());
		
		session.setAttribute("myPlant", myPlant);

		model.addAttribute("myPlant", myPlant);
		model.addAttribute("user", user.getNickname());
		return myPlant;
	}

	@RequestMapping(value = "useItem", method = RequestMethod.POST)
	public Map<String, Object> useItem(@RequestBody Inventory inventory, HttpSession session, Model model)
			throws Exception {

		System.out.println("::plant::REST::useItem : POST");
		System.out.println("::::::: "+inventory);

		plantService.updateInventory(inventory);
		User user = (User) session.getAttribute("user");
		
		inventory.setMyPlant(plantService.getMyPlant(user.getNickname()));
		
		System.out.println("::::: myplant: "+inventory.getMyPlant());
		
		plantService.UseItem(inventory);
		
		model.addAttribute("inventory", inventory);

		Map<String, Object> map = new HashMap<>();
		map.put("inventory", inventory);
		map.put("user", user);

		return map;
	}

	@RequestMapping(value = "saveMyPlant", method = RequestMethod.POST)
	public MyPlant addRandomPlant(HttpSession session, @RequestBody MyPlant myPlant,
								 Model model) throws Exception {
		System.out.println("::plant::REST::saveMyPlant : POST");

	    // 세션에서 사용자 정보를 가져옴
	    User user = (User) session.getAttribute("user");
	    
	    // 랜덤 식물 선택
	    Plant randomPlant = plantService.selectRandomPlant();
	    PlantLevl plantLevl = randomPlant.getPlantLevl();

	    System.out.println("User: " + user);
	    System.out.println("RandomPlant: " + randomPlant);

	    // 사용자 정보와 랜덤으로 선택된 식물 정보를 myPlant 객체에 설정
	    myPlant.setNickname(user.getNickname());
	    myPlant.setPlant(randomPlant);
	    myPlant.setPlantLevl(plantLevl);

	    // myPlant 객체를 데이터베이스에 저장
	    plantService.addMyPlant(myPlant);

	    System.out.println("myPlant : " + myPlant);

	    // myPlant 객체를 모델에 저장
	    session.setAttribute("myPlant", myPlant);
	    model.addAttribute("myPlant", myPlant);
	    model.addAttribute("user", user);

		return myPlant;
	}

	@RequestMapping(value = "updateMyPlant", method = RequestMethod.POST)
	public MyPlant updateMyPlant(@RequestBody MyPlant myPlant) throws Exception {

		System.out.println("::plant::REST::updateMyPlant : POST");
		plantService.updateMyPlant(myPlant);

		return myPlant;
	}

	@RequestMapping(value = "selectRandomPlant", method = RequestMethod.POST)
	public Plant selectRandomPlant(HttpSession session, Model model) throws Exception {
		System.out.println("::plant::REST::selectRandomPlant : POST");
	    Plant plant = plantService.selectRandomPlant();
	    System.out.println("RandomPlant selected: " + plant);
	    return plant;
	}

//	@RequestMapping(value = "getWeather", method = RequestMethod.POST)
//	public ResponseEntity<List<String>> getWeather() throws Exception {
//
//		String serviceKey = "zJ7JeCt+LM11LqlWrFNTradlea58rNZ036NPWmX33rg3BEgPgLlLJLIqvRsZrPec0aUIB+t91pjA0iQg1j9E1Q==";
//		StringBuilder urlBuilder = new StringBuilder(
//				"http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst");
//		urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + serviceKey);
//		urlBuilder.append("&" + URLEncoder.encode("dataType", "UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8"));
//		urlBuilder.append("&" + URLEncoder.encode("base_date", "UTF-8") + "=" + URLEncoder.encode("20240614", "UTF-8"));
//		urlBuilder.append("&" + URLEncoder.encode("base_time", "UTF-8") + "=" + URLEncoder.encode("0500", "UTF-8"));
//		urlBuilder.append("&" + URLEncoder.encode("nx", "UTF-8") + "=" + URLEncoder.encode("55", "UTF-8"));
//		urlBuilder.append("&" + URLEncoder.encode("ny", "UTF-8") + "=" + URLEncoder.encode("127", "UTF-8"));
//
//		String url = urlBuilder.toString();
//		String result = restTemplate.getForObject(url, String.class);
//
//		// 응답 출력
//		System.out.println(result);
//
//		// JSON 파싱
//		JSONObject jsonObj = new JSONObject(result);
//		JSONObject response = jsonObj.getJSONObject("response");
//		JSONObject body = response.getJSONObject("body");
//		JSONObject items = body.getJSONObject("items");
//		JSONArray itemArray = items.getJSONArray("item");
//
//		List<String> weatherConditions = new ArrayList<>();
//		for (int i = 0; i < itemArray.length(); i++) {
//			JSONObject item = itemArray.getJSONObject(i);
//			String fcstValue = item.getString("fcstValue");
//			String category = item.getString("category");
//
//			String weather = "";
//			if (category.equals("SKY")) {
//				weather = "현재 날씨는 ";
//				switch (fcstValue) {
//				case "1":
//					weather += "맑은 상태로";
//					break;
//				case "2":
//					weather += "비가 오는 상태로 ";
//					break;
//				case "3":
//					weather += "구름이 많은 상태로 ";
//					break;
//				case "4":
//					weather += "흐린 상태로 ";
//					break;
//				}
//				weatherConditions.add(weather);
//			}
//		}
//
//		return ResponseEntity.ok(weatherConditions);
//	}

}
