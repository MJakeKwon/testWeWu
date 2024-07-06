package life.wewu.web.domain.plant;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class PlantLevl {
	
	
	
	private int plantNo;			//식물식별번호
	private int plantLevlNo;		//식물단계식별번호
	private String plantLevl;		//식물단계
	private String levlImg;		//식물단계별이미지
	private int plantMaxExp;		//식물단계별최대경험치
	private int plantMinExp;		//식물단계별최소경험치
	private String plantFinalLevl; //식물마지막단계
	private String value;

	public PlantLevl(String value) {
        this.value = value;
    }
	
}
