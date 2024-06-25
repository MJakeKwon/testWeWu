package life.wewu.web.service.user.impl;

import life.wewu.web.common.Search;
import life.wewu.web.domain.user.User;
import life.wewu.web.service.user.SmsService;
import life.wewu.web.service.user.UserService;
import lombok.RequiredArgsConstructor;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.when;


@SpringBootTest
@RequiredArgsConstructor
public class UserServiceTest {
	
    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    @Autowired
    @Qualifier("smsService")
    private SmsService smsService;

    //@Test
    public void testAddUser() throws Exception {
        System.out.println("addUser");

        User user = new User();
        user.setUserId("testuser");
        user.setEmail("testuser@example.com");
        user.setPhoneNum("010-1234-5678");
        user.setResidentNum("123456-1234567");
        user.setNickname("testnick");
        user.setUserPwd("password");
        user.setAddr("Seoul");
        user.setGetAddr("Seoul");
        user.setGender("M");
        user.setCurrentPoint(0);
        user.setUserName("Test User");

        userService.addUser(user);

        User fetchedUser = userService.getUser("testuser");
        assertNotNull(fetchedUser);
        assertEquals("testuser", fetchedUser.getUserId());
    }

    //@Test
    public void testGetUser() throws Exception {
        System.out.println("getUser");

        User user = userService.getUser("testuser");

        assertNotNull(user);
        assertEquals("testuser", user.getUserId());
    }

    //@Test
    public void testUpdateUser() throws Exception {
        System.out.println("updateUser");

        User user = userService.getUser("testuser");
        assertNotNull(user);

        user.setNickname("updatenick");
        user.setUserPwd("newpassword");
        user.setEmail("updateUser@example.com");
        user.setPhoneNum("010-0506-1120");
        user.setAddr("Bit");
        user.setGetAddr("GangNam");
        
        
        userService.updateUser(user);

        User updatedUser = userService.getUser("testuser");
        assertNotNull(updatedUser);
        assertEquals("updatenick", updatedUser.getNickname());
        assertEquals("newpassword", updatedUser.getUserPwd());
        assertEquals("updateUser@example.com", updatedUser.getEmail());
        assertEquals("010-0506-1120", updatedUser.getPhoneNum());
        assertEquals("Bit", updatedUser.getAddr());
        assertEquals("GangNam", updatedUser.getGetAddr());

    }

    //@Test
    public void testDeleteUser() throws Exception {
        System.out.println("deleteUser");

        // Assuming a user with userId "testuser" exists
        userService.deleteUser("testuser");

        User user = userService.getUser("testuser");
        assertNotNull(user);
        assertEquals("4", user.getRole());
        System.out.println("testUser Role" + user.getRole());
    }

    //@Test
//    public void testGetUserList() throws Exception {
//        System.out.println("getUserList");
//
//        // Create a Search object with appropriate search criteria
//        Search search = new Search();
//        search.setSearchCondition("1"); // Example search condition ('1' for userName)
//        search.setSearchKeyword("testuser"); // Example search keyword
//        search.setCurrentPage(1);
//        search.setPageSize(10);
//
//        // Get user list using the search criteria
//        List<User> userList = userService.getUserList(search);
//
//        // Assertions
//        assertNotNull(userList);
//        assertTrue(userList.size() > 0);
//
//        // Print out the users
//        for (User user : userList) {
//            System.out.println(user);
//        }
//    }

    //@Test
    public void testLogin() throws Exception {
        System.out.println("login");

        User user = new User();
        user.setUserId("testuser");
        user.setUserPwd("newpassword");

        User loggedInUser = userService.login(user);

        assertNotNull(loggedInUser);
        assertEquals("testuser", loggedInUser.getUserId());
    }


    //@Test
    public void testCheckUserId() throws Exception {
        System.out.println("checkUserId");

        boolean exists = userService.checkUserId("testuser1");

        assertTrue(exists);
    }

    //@Test
    public void testCheckNickName() throws Exception {
        System.out.println("checkNickName");

        boolean exists = userService.checkNickName("testnick1");

        assertTrue(exists);
    }
    
//    //@Test
//    public void testSendVerificationCode() {
//        String phoneNum = "01012345678";
//        String verificationCode = "123456";
//
//        when(smsService.sendVerificationCode(phoneNum)).thenReturn(verificationCode);
//
//        String code = userService.sendVerificationCode(phoneNum);
//        assertEquals(verificationCode, code);
//    }

    //@Test
    public void testFindUserPwd() throws Exception {
        System.out.println("findUserPwd");

        String phoneNum = "01099489114";
        String userId = "mjake";

        User user = userService.findUserPwd(phoneNum, userId);
        assertNotNull(user);
        assertEquals(userId, user.getUserId());
        assertEquals(phoneNum, user.getPhoneNum());
    }

   //@Test
   public void testUpdatePwd() throws Exception {
       System.out.println("updatePwd");

       String userId = "mjake";
       String phoneNum = "01099489114";

       User user = userService.findUserPwd(phoneNum, userId);
       assertNotNull(user);

       String newPassword = "newpassword";
       user.setUserPwd(newPassword);

       userService.updatePwd(user);

       User updatedUser = userService.getUser(userId);
       assertNotNull(updatedUser);
       assertEquals(newPassword, updatedUser.getUserPwd());
   }

}
