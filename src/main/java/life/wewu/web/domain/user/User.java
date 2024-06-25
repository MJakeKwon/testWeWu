//24.06.03 작성
package life.wewu.web.domain.user;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {
    private String userId;				//사용자 아이디
    private String email;				//사용자 이메일
    private String phoneNum;		//사용자 전화번호
    private String residentNum;	//사용자 주민번호
    private String nickname;			//사용자 닉네임 (unique)
    private String userPwd;			//사용자 비밀번호
    private String addr;				//사용자 주소
    private String getAddr;			//사용자 상세주소
    private String gender;			//사용자 성별
    private Integer currentPoint;	//사용자 현제포인트
    private String role;					// 1.admin, 2.user, 3.leader 4.delete
    private String userName;		//사용자 이름
}

