//package life.wewu.web.service.user.impl;
//
//import life.wewu.web.domain.user.User;
//import life.wewu.web.service.user.UserDao;
//import org.junit.jupiter.api.BeforeEach;
//import org.junit.jupiter.api.Test;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
//import org.springframework.boot.test.context.SpringBootTest;
//import org.springframework.transaction.annotation.Transactional;
//
//import static org.junit.jupiter.api.Assertions.*;
//
//@SpringBootTest
//@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
//public class UserDaoTest {
//
//    @Autowired
//    private UserDao userDao;
//
//    @BeforeEach
//    @Transactional
//    public void setUp() throws Exception {
//        // 테스트 데이터 삽입
//        User user = new User();
//        user.setUserId("testuser");
//        user.setUserName("권민재");
//        user.setPhoneNum("01099489114");
//        user.setUserPwd("password");
//        user.setEmail("testuser@example.com");
//        user.setNickname("testnick");
//        user.setAddr("Seoul");
//        user.setGetAddr("Seoul");
//        user.setGender("M");
//        user.setResidentNum("123456-1234567");
//        user.setCurrentPoint(0);
//        user.setRole("1");
//
//        // 기존 사용자 삭제 후 삽입
//        userDao.deleteUser("testuser");
//        userDao.addUser(user);
//    }
//
//    @Test
//    @Transactional
//    public void testFindUserId() {
//        String phoneNum = "01099489114";
//        String userName = "권민재";
//        User user = userDao.findUserId(phoneNum, userName);
//
//        assertNotNull(user, "User should not be null");
//        assertEquals("testuser", user.getUserId(), "UserId should be 'testuser'");
//    }
//}
