package life.wewu.web.service.user.impl;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

import life.wewu.web.domain.user.User;
import life.wewu.web.service.user.UserDao;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import java.util.HashMap;
import java.util.Map;

public class UserServiceImplTest {

    @InjectMocks
    private UserServiceImpl userService;

    @Mock
    private UserDao userDao;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    public void testUpdateUserPoint_success() throws Exception {
        String userId = "12345";
        int currentPoint = 100;
        int pointToAdd = 50;
        User user = new User();
        user.setUserId(userId);
        user.setCurrentPoint(currentPoint);

        when(userDao.getUser(userId)).thenReturn(user);

        userService.updateUserPoint(userId, pointToAdd);

        verify(userDao).updateUserPoint(argThat(params -> 
            params.get("userId").equals(userId) && params.get("points").equals(pointToAdd)
        ));

        assertEquals(currentPoint + pointToAdd, user.getCurrentPoint());
    }

    @Test
    public void testUpdateUserPoint_userNotFound() throws Exception {
        String userId = "12345";
        int pointToAdd = 50;

        when(userDao.getUser(userId)).thenReturn(null);

        Exception exception = assertThrows(IllegalArgumentException.class, () -> {
            userService.updateUserPoint(userId, pointToAdd);
        });

        assertEquals("User not found", exception.getMessage());
    }

    @Test
    public void testUpdateUserPoint_insufficientPoints() throws Exception {
        String userId = "12345";
        int currentPoint = 30;
        int pointsToDeduct = -50;
        User user = new User();
        user.setUserId(userId);
        user.setCurrentPoint(currentPoint);

        when(userDao.getUser(userId)).thenReturn(user);

        Exception exception = assertThrows(IllegalArgumentException.class, () -> {
            userService.updateUserPoint(userId, pointsToDeduct);
        });

        assertEquals("Insufficient points", exception.getMessage());
    }
}
