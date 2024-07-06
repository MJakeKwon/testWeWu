package life.wewu.web.domain.plant;

import java.sql.Date;
import java.util.List;

import life.wewu.web.domain.user.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MyPlant {
	
	//field
	
	private int plantNo;
	private int plantLevlNo;
	private String nickname;		//식물주인
	private int myPlantNo; 			//나의식물식별번호
	private String myPlantState;	//나의식물상태(Y,N)
	private String myPlantName;		//나의식물이름
	private int myPlantExp;			//나의식물경험치
	private Date plantStartDate;	//나의식물키우기시작한날짜
	private Date plantEndDate;		//나의식물종료날짜
	private String myPlantLevl;		//나의식물현재단계
	private int weatherNo;			//날씨식별번호
	private String weatherImg;		//날씨이미지
	private PlantLevl plantLevl;	//PlantLevl
	private Plant plant; 			//Plant
	
	private List<Integer> plantLevlNoList; // 식물 단계 식별번호 목록
	
}
