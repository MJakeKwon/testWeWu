package life.wewu.web.service.plant.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import life.wewu.web.common.Search;
import life.wewu.web.domain.plant.Inventory;
import life.wewu.web.domain.plant.MyPlant;
import life.wewu.web.domain.plant.Plant;
import life.wewu.web.domain.plant.PlantLevl;
import life.wewu.web.domain.plant.PlantRequest;
import life.wewu.web.domain.plant.Quest;
import life.wewu.web.domain.user.User;
import life.wewu.web.service.plant.InventoryDao;
import life.wewu.web.service.plant.PlantDao;
import life.wewu.web.service.plant.PlantService;
import life.wewu.web.service.plant.QuestDao;
import life.wewu.web.service.plant.MyPlantDao;

@Service("plantServiceImpl")
public class PlantServiceImpl implements PlantService {

	public PlantServiceImpl() {
		System.out.println(this.getClass());
	}

	@Autowired
	private SqlSession sqlSession;

	@Autowired
	@Qualifier("plantDao")
	private PlantDao plantDao;

	@Autowired
	@Qualifier("questDao")
	private QuestDao questDao;

	@Autowired
	@Qualifier("myPlantDao")
	private MyPlantDao myPlantDao;

	@Autowired
	@Qualifier("inventoryDao")
	private InventoryDao inventoryDao;
	
	@Autowired
    private HttpSession session;

	public void setPlantDao(PlantDao plantDao) {
		this.plantDao = plantDao;
	}

	// ---------------------------------------------------------------------------------------//
	@Override
	public void addQuest(Quest quest) throws Exception {
		questDao.addQuest(quest);
	}

	@Override
	public void deleteQuest(int questNo) throws Exception {
		questDao.deleteQuest(questNo);
	}

	@Override
	public void updateQuest(Quest quest) throws Exception {
		questDao.updateQuest(quest);
	}

	@Override
	public Quest getQuest(int questNo) throws Exception {
		return questDao.getQuest(questNo);
	}
	

	@Override
	public Map<String, Object> getQuestList(Search search) throws Exception {

		int questNo = 1;
		Quest quest = questDao.getQuest(questNo);
		search.setSearchKeyword(String.valueOf(quest.getQuestNo()));
		List<Quest> list = questDao.getQuestList(search);
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);

		return map;
	}

	@Override
	public void completeQuest(Quest quest) throws Exception {
		if (quest.getCurrentCnt() >= quest.getQuestTargetCnt()) {
			quest.setQuestState("N");
			
            User user = (User) session.getAttribute("user");
            System.out.println("completeQuest:uset = "+user);

            quest.setNickName(user.getNickname());
            System.out.println("quest : "+quest);
            
            MyPlant myPlant = (MyPlant) session.getAttribute("myPlant");
         
            System.out.println("completeQuest:myPlant = "+myPlant);
            myPlant.setMyPlantExp(myPlant.getMyPlantExp() + quest.getQuestReward());
            
            System.out.println("update된 myPlnat : "+myPlant);
            System.out.println("quest.getQuestReward() : "+quest.getQuestReward());
            myPlantDao.updateMyPlant(myPlant);
            
            

            // 퀘스트 업데이트
            questDao.completeQuest(quest);
        }
	}


	@Override
	public Quest getQuestByUser(String nickname) throws Exception {
		
		return questDao.getQuestByUser(nickname);
	}
	// ---------------------------------------------------------------------------------------//

	@Transactional
	public void addPlant(PlantRequest plantRequest) throws Exception {
		System.out.println("PlantRequest: " + plantRequest);
		System.out.println("Plant: " + plantRequest.getPlant());
		System.out.println("PlantLevl: " + plantRequest.getPlantLevl());

		// Plant 삽입
		plantDao.addPlant(plantRequest.getPlant());

		// 삽입된 Plant의 plantNo를 가져와서 PlantLevl에 설정
		int plantNo = plantRequest.getPlant().getPlantNo();
		plantRequest.getPlantLevl().setPlantNo(plantNo);

		// PlantLevl 삽입
		plantDao.addPlantLevl(plantRequest.getPlantLevl());

	}

	@Override
	public void addPlantName(Plant plant) throws Exception {
		plantDao.addPlantName(plant);
	}

	public void addPlantLevl(PlantLevl plantlevl) throws Exception {
		plantDao.addPlantLevl(plantlevl);
	}

	@Override
	public void updatePlant(PlantRequest plantRequest) throws Exception {
		plantDao.updatePlantName(plantRequest.getPlant());
		plantDao.updatePlantLevl(plantRequest.getPlantLevl());
	}

	public void updatePlantName(Plant plant) throws Exception {
		plantDao.updatePlantName(plant);
	}

	public void updatePlantLevl(PlantLevl plantLevl) throws Exception {
		plantDao.updatePlantLevl(plantLevl);
	}

	@Override
	public Plant getPlant(int PlantNo) throws Exception {
		return plantDao.getPlant(PlantNo);
	}

	public PlantLevl getPlantLevl(int plantLevlNo) throws Exception {
		return plantDao.getPlantLevl(plantLevlNo);
	}

	public List<PlantLevl> getPlantLevls(int plantLevlNo) throws Exception {
		return plantDao.getPlantLevls(plantLevlNo);
	}

	@Override
	public List<Plant> getPlantList(Map<String, Object> map) throws Exception {
		List<Plant> list = plantDao.getPlantList(map);
	    System.out.println("Retrieved Plant List: " + list); // 리스트 출력
	    
	    return list;
	}

	@Override
	public Plant selectRandomPlant() throws Exception {
		return plantDao.selectRandomPlant();
	}
	
	@Override
	public void deletePlant(int plantNo) throws Exception {
		plantDao.deleteMyPlant(plantNo);
		plantDao.deletePlantLevl(plantNo);
        plantDao.deletePlant(plantNo);
		
	}
	@Override
	public void deletePlantLevl(int plantNo) throws Exception {
		plantDao.deletePlantLevl(plantNo);
		
	}
	@Override
	public void deleteMyPlant(int plantNo) throws Exception {
		plantDao.deleteMyPlant(plantNo);
		
	}



	// ---------------------------------------------------------------------------------------//
	@Override
	public void updateMyPlant(MyPlant myPlant) throws Exception {
		myPlantDao.updateMyPlant(myPlant);
	}

	@Override
	public MyPlant getMyPlant(String nickname) throws Exception {
		
		return myPlantDao.getMyPlant(nickname);
	}

	public MyPlant getMyPlantLevl(String nickname) throws Exception {
		return myPlantDao.getMyPlantLevl(nickname);
	}

	@Override
	public List<MyPlant> getMyPlantList(Map<String, Object> map) throws Exception {

		return myPlantDao.getMyPlantList(map);
	}
	
	public List<MyPlant> myPlantListbyLevlNo(Map<String, Object> map) throws Exception{
		return myPlantDao.myPlantListbyLevlNo(map);
	}

	@Override
	public void deleteMyPlant(String nickname) throws Exception {
		myPlantDao.deleteMyPlant(nickname);
	}

	@Override
	public String getWeather(String location) throws Exception {
		return myPlantDao.getWeather(location);
	}

	@Override
	public void addMyPlant(MyPlant myPlant) throws Exception {

		myPlantDao.addMyPlant(myPlant);
		
	}

	// ---------------------------------------------------------------------------------------//

	@Override
	public List<Inventory> getInventoryList(String nickname) throws Exception {
		return inventoryDao.getInventoryList(nickname);
	}

	@Override
	public void updateInventory(Inventory inventory) throws Exception {

		inventoryDao.updateInventory(inventory);
	}

	@Override
	public Inventory UseItem(Inventory inventory) throws Exception {
		
		int currentStock = inventory.getItemNum();
		int useItemNum = inventory.getUseItemNum();
		int itemEffect = Integer.parseInt(inventory.getItemExp());
		User user = (User) session.getAttribute("user");
		
		System.out.println("UserItem currentStock : "+currentStock);
		System.out.println("UserItem useItemNum : "+useItemNum);
		System.out.println("UserItem itemEffect : "+itemEffect);
		
		if(currentStock>0) {
			inventory.setItemNum(currentStock - useItemNum);
			System.out.println("::::inventory Before update : "+inventory);
            inventoryDao.updateInventory(inventory);
		}
		System.out.println("UserItem inventory : "+inventory);
		
		 MyPlant myPlant = myPlantDao.getMyPlant(user.getNickname());
         int newExp = myPlant.getMyPlantExp() + itemEffect;
         System.out.println("UserItem newExp : "+newExp);
         myPlant.setMyPlantExp(newExp);
         myPlantDao.updateMyPlant(myPlant);
         
         Map<String,Object> map = new HashMap<String, Object>();
         map.put("myPlantNo", inventory.getMyPlant().getMyPlantNo());
         map.put("myPlantExp", inventory.getItemExp());
		
		myPlantDao.updateMyPlantExp(map);
		
		
		return inventory;
		

	}








}
