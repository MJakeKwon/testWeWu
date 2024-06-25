package life.wewu.web.service.user.impl;

import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.MockitoAnnotations;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;

import life.wewu.web.domain.user.User;
import life.wewu.web.service.user.SmsService;
import life.wewu.web.service.user.UserService;

@SpringBootTest
@AutoConfigureMockMvc
public class UserRestControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private UserService userService;

    @MockBean
    private SmsService smsService;

    @BeforeEach
    public void setUp() {
        MockitoAnnotations.openMocks(this);
    }
    
//    @Test
//    public void testFindUserId() {
//        String phoneNum = "01099489114";
//        String userName = "JohnDoe";
//        User user = new User();
//        user.setUserId("john123");
//
//        when(userDao.findUserId(phoneNum, userName)).thenReturn(user);
//
//        User foundUser = userService.findUserId(phoneNum, userName);
//        assertEquals("john123", foundUser.getUserId());
//    }

    //@Test
    public void testSendVerificationCode() throws Exception {
        String phoneNum = "01099489114";

        when(userService.sendVerificationCode(anyString())).thenReturn("123456");

        mockMvc.perform(post("/user/send-verification-code")
                .param("phoneNum", phoneNum))
                .andExpect(status().isOk());
    }

    //@Test
    public void testVerifyCode() throws Exception {
        String phoneNum = "01012345678";
        String code = "123456";
        String userName = "JohnDoe";

        when(userService.verifyCode(anyString(), anyString())).thenReturn(true);

        mockMvc.perform(post("/user/verify-code")
                .param("phoneNum", phoneNum)
                .param("code", code)
                .param("userName", userName))
                .andExpect(status().isOk());
    }

    //@Test
//    public void testFindUserId() throws Exception {
//        String phoneNum = "01012345678";
//        String code = "123456";
//        String userName = "JohnDoe";
//
//        User user = new User();
//        user.setUserId("john123");
//
//        when(userService.verifyCode(anyString(), anyString())).thenReturn(true);
//        when(userService.findUserId(anyString(), anyString())).thenReturn(user);
//
//        mockMvc.perform(post("/user/find-user-id")
//                .param("phoneNum", phoneNum)
//                .param("code", code)
//                .param("userName", userName))
//                .andExpect(status().isOk());
//    }
    
    
}
