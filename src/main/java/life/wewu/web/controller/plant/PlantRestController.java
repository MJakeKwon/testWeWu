package life.wewu.web.controller.plant;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import life.wewu.web.common.Search;
import life.wewu.web.domain.plant.Inventory;
import life.wewu.web.domain.plant.MyPlant;
import life.wewu.web.domain.plant.Plant;
import life.wewu.web.domain.plant.Quest;
import life.wewu.web.domain.user.User;
import life.wewu.web.service.plant.PlantDao;
import life.wewu.web.service.plant.PlantService;


@RestController
@RequestMapping("/plant/")
public class PlantRestController {
	
	@Autowired
	@Qualifier("plantServiceImpl")
	private PlantService plantService;
	
	  @Value("${weather.api.key}")
	    private String apiKey;

	    @Autowired
	    private RestTemplate restTemplate;
	
	public PlantRestController() {
		System.out.println(this.getClass());
	}

	
	@RequestMapping(value ="getQuestList" , method = RequestMethod.POST)
	public Map<String, Object> getQuestList(@RequestBody Search search , Model model,HttpSession session) throws Exception{
		System.out.println("/getQuestList");

		Map<String,Object> map = plantService.getQuestList(search);
		model.addAttribute("map", map);
		model.addAttribute("search", search);

		session.setAttribute("questList", map.get("list"));
		System.out.println(map.get("list"));
		
		return map;
	}
	
	
	@RequestMapping(value ="completeQuest" , method = RequestMethod.POST)
	public Quest completeQuest(@RequestBody Quest quest , Model model) throws Exception{
		System.out.println("/completeQuest");
		
		int questNo = quest.getQuestNo();
		quest.setQuestNo(questNo);
		
		plantService.completeQuest(quest);

		return quest;
	}
	
	@RequestMapping(value ="deleteQuest")
	public Quest deleteQuest(@RequestBody Quest quest , Model model ) throws Exception{
		System.out.println(" /plant/deleteQuest : POST ");		
		plantService.addQuest(quest);		
		model.addAttribute("quest", quest);
		
		return quest;
	}
	
	
	
	@RequestMapping(value ="deletePlant" , method = RequestMethod.POST)
	public String deletePlant(@RequestParam("plantNo") int plantNo , Model model) throws Exception{
		System.out.println(" /plant/deletePlant : POST ");		
		plantService.deletePlant(plantNo);
		
		return "redirect:/plant/getPlantList.jsp"; //<< 고민중
	
	}
	
	//REST로
	@RequestMapping(value ="getUseItem" , method = RequestMethod.POST)
	public Map<String,Object> getUseItem(@RequestParam("myPlantNo") int myPlantNo,@RequestParam("itemPurNo") int itemPurNo) throws Exception{
		MyPlant myPlant = plantService.getMyPlant(myPlantNo);
		Inventory inventory = plantService.getInventory(itemPurNo);
		
		Map<String,Object> map = new HashMap<>();
		map.put("myPlant",myPlant);
		map.put("inventory", inventory);
		
		return map;
		
	}
	
	@RequestMapping(value="updateMyPlant", method = RequestMethod.POST)
	public MyPlant updateMyPlant(@RequestBody MyPlant myPlant) throws Exception{
		
		System.out.println("/plant/updateMyPlant");
		plantService.updateMyPlant(myPlant);
		
		return myPlant;
	}
	
	@RequestMapping(value ="/json/selectRandomPlant" , method = RequestMethod.POST)
	public Plant selectRandomPlant(Model model) throws Exception{
		System.out.println(" /plant/selectRandomPlant : POST ");
		Plant plant = plantService.selectRandomPlant();
		model.addAttribute("plant", plant);
		
		return plant;
	}
	
	@RequestMapping(value="getWeather" , method = RequestMethod.POST)
	public ResponseEntity<List<String>> getWeather() throws Exception{
		
		String serviceKey = "zJ7JeCt+LM11LqlWrFNTradlea58rNZ036NPWmX33rg3BEgPgLlLJLIqvRsZrPec0aUIB+t91pjA0iQg1j9E1Q==";
        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst");
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=" + serviceKey);
        urlBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("base_date","UTF-8") + "=" + URLEncoder.encode("20240614", "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("base_time","UTF-8") + "=" + URLEncoder.encode("0500", "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("nx","UTF-8") + "=" + URLEncoder.encode("55", "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("ny","UTF-8") + "=" + URLEncoder.encode("127", "UTF-8"));
	
        String url = urlBuilder.toString();
        String result = restTemplate.getForObject(url, String.class);

        // 응답 출력
        System.out.println(result);

        // JSON 파싱
        JSONObject jsonObj = new JSONObject(result);
        JSONObject response = jsonObj.getJSONObject("response");
        JSONObject body = response.getJSONObject("body");
        JSONObject items = body.getJSONObject("items");
        JSONArray itemArray = items.getJSONArray("item");

        List<String> weatherConditions = new ArrayList<>();
        for (int i = 0; i < itemArray.length(); i++) {
            JSONObject item = itemArray.getJSONObject(i);
            String fcstValue = item.getString("fcstValue");
            String category = item.getString("category");

            String weather = "";
            if (category.equals("SKY")) {
                weather = "현재 날씨는 ";
                switch (fcstValue) {
                    case "1":
                        weather += "맑은 상태로";
                        break;
                    case "2":
                        weather += "비가 오는 상태로 ";
                        break;
                    case "3":
                        weather += "구름이 많은 상태로 ";
                        break;
                    case "4":
                        weather += "흐린 상태로 ";
                        break;
                }
                weatherConditions.add(weather);
            }
        }

        return ResponseEntity.ok(weatherConditions);
    }


}
