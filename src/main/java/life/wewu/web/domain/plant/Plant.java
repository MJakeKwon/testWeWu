package life.wewu.web.domain.plant;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Plant {
	
	//field

	private int plantNo;		 //식물식별번호
	private String plantName;	 //식물이름
	private PlantLevl plantLevl; //PlantLevl
	//private MyPlant myPlant;	 //MyPlant
	public void setFileName(String shortUrl) {
		// TODO Auto-generated method stub
		
	}
	

	
}
