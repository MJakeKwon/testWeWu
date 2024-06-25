//24.06.03 작성

package life.wewu.web.service.user;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import life.wewu.web.common.Search;
import life.wewu.web.domain.user.User;

@Mapper
public interface UserDao {
	
	public void addUser(User user) throws Exception;
	
	public void updateUser(User user) throws Exception;
	
	public void deleteUser(String userId) throws Exception;
	
	public List<User> getUserList(Search search) throws Exception ;
	
	public User getUser(String userId) throws Exception;
	
	public void updateAdmin(User user) throws Exception;
	
	public void updateNickName(User user) throws Exception;
	
    public boolean checkUserId(String userId) throws Exception;
    
    public boolean checkNickName(String nickname) throws Exception;
    
    public User findUserId(Map<String, Object> map) throws Exception;
    
    public User findUserPwd(Map<String, Object> map) throws Exception;

	public void updatePwd(User user) throws Exception;
	
	public int getTotalCount(Search search) throws Exception ;

}