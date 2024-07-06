//24.06.03 작성

package life.wewu.web.service.user;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;

import life.wewu.web.common.Search;
import life.wewu.web.domain.user.User;


public interface UserService {
	
	//회원가입
	public void addUser(User user) throws Exception;
    
	//내정보수정
	public void updateUser(User user) throws Exception;
    
	//관리자 사용자 삭제
    public void deleteUser(String userId) throws Exception;
    
	//관리자가 유저 목록 확인
	public Map<String , Object> getUserList(Search search, int startRowNum, int pageSize) throws Exception;

	//관리자가 유저 상세보기
	public User getUser(String userId) throws Exception;
    
	//로그인
	public User login(User user) throws Exception;
    
	//관리자가 사용자 상세보기시 수정
	public void updateAdmin(User user) throws Exception;
    
	//회원가입시 사용자 아이디 중복체크
	public boolean checkUserId(String userId) throws Exception;
    
	//회원가입시 사용자 닉네임 중복체크
	public boolean checkNickName(String nickname) throws Exception;
    
	
	/////////////////////////////////////찾기 인증///////////////////////////////////
	
//	ResponseEntity<String> sendSms(String to);
	
	public String sendVerificationCode(String phoneNum);
	
	public boolean verifyCode(String phoneNum, String code);
	
	public User findUserId(String phoneNum, String userName) throws Exception;
	
	public Map<String, String> getVerificationCodes();
	
//    public String sendTestVerificationCode(String phoneNum);
    
    public User findUserPwd(String phoneNum, String userId) throws Exception;

	public void updatePwd(User user) throws Exception;
	
	public void updateRole(User user) throws Exception;
	
	public void updateUserPoint(String userId, int currentPoint) throws Exception;


}