package life.wewu.web.service.user.impl;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import life.wewu.web.domain.user.User;
import life.wewu.web.service.user.UserDao;

public class UserServiceImplTest {

    @Mock
    private UserDao userDao;

    @InjectMocks
    private UserServiceImpl userService;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    //@Test
    public void testLogin_UserIsNull() {
        Exception exception = assertThrows(IllegalArgumentException.class, () -> {
            userService.login(null);
        });
        assertEquals("유효하지 않은 사용자 정보입니다.", exception.getMessage());
    }

   //@Test
    public void testLogin_UserIdIsNull() {
        User user = new User();
        user.setUserId(null);
        Exception exception = assertThrows(IllegalArgumentException.class, () -> {
            userService.login(user);
        });
        assertEquals("유효하지 않은 사용자 정보입니다.", exception.getMessage());
    }

    //@Test
    public void testLogin_UserNotFound() throws Exception {
        User user = new User();
        user.setUserId("testUser");

        when(userDao.getUser("testUser")).thenReturn(null);

        User result = userService.login(user);
        assertNull(result);
    }

    //@Test
    public void testLogin_UserDeleted() throws Exception {
        User user = new User();
        user.setUserId("testUser");

        User dbUser = new User();
        dbUser.setUserId("testUser");
        dbUser.setRole("4");

        when(userDao.getUser("testUser")).thenReturn(dbUser);

        Exception exception = assertThrows(Exception.class, () -> {
            userService.login(user);
        });
        assertEquals("삭제처리 되었습니다.", exception.getMessage());
    }

    //@Test
    public void testLogin_PasswordMismatch() throws Exception {
        User user = new User();
        user.setUserId("testUser");
        user.setUserPwd("password123");

        User dbUser = new User();
        dbUser.setUserId("testUser");
        dbUser.setUserPwd("wrongPassword");

        when(userDao.getUser("testUser")).thenReturn(dbUser);

        User result = userService.login(user);
        assertNull(result);
    }

    @Test
    public void testLogin_Success() throws Exception {
        User user = new User();
        user.setUserId("testUser");
        user.setUserPwd("password123");

        User dbUser = new User();
        dbUser.setUserId("testUser");
        dbUser.setUserPwd("password123");

        when(userDao.getUser("testUser")).thenReturn(dbUser);

        User result = userService.login(user);
        assertNotNull(result);
        assertEquals("testUser", result.getUserId());
    }
}
