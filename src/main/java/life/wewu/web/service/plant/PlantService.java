package life.wewu.web.service.plant;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import life.wewu.web.common.Search;
import life.wewu.web.domain.plant.Inventory;
import life.wewu.web.domain.plant.MyPlant;
import life.wewu.web.domain.plant.Plant;
import life.wewu.web.domain.plant.PlantLevl;
import life.wewu.web.domain.plant.Quest;


public interface PlantService {
	
	public void addQuest(Quest quest) throws Exception;
	
	public void deleteQuest(int questNo) throws Exception;
	
	public void updateQuest(Quest quest) throws Exception;
	
	public Quest getQuest(int questNo) throws Exception;
	
	public Map<String,Object> getQuestList(Search search) throws Exception;
	
	public void completeQuest(Quest quest) throws Exception; 
	
	
	public void addPlant(Plant plant, PlantLevl plantLevl) throws Exception;
	public void addPlantName(Plant plant) throws Exception;
	public void addPlantLevl(PlantLevl plantLevl) throws Exception;
	public PlantLevl getPlantLevl(int plantLevlNo) throws Exception;
	
	public void deletePlant(int plantNo) throws Exception;
	
	public void updatePlant(Plant plant) throws Exception;
	
	public void updatePlantLevl(Plant plant) throws Exception;
	
	public Plant getPlant(int PlantNo) throws Exception;
	
	public Map<String,Object> getPlantList(Search search) throws Exception;
	
	
	public Plant selectRandomPlant() throws Exception;
	
	public void addRandomPlant(MyPlant myPlant)throws Exception;
	
	public void updateMyPlant(MyPlant myPlant) throws Exception;
	
	public MyPlant getMyPlant(int myPlantNo) throws Exception;
	
	public List<MyPlant> getMyPlantList(Map<String,Object> map) throws Exception;
	
	public MyPlant deleteMyPlant(int myPlantNo) throws Exception;

	
	     
	public void fileUpload(String filePath) throws Exception;
	 
	public String getWeather(String location) throws Exception;

	
	public Inventory getInventory(int itemPurno) throws Exception;
	
	public Inventory getUseItem(int itemPurNo) throws Exception;

	

	

}
