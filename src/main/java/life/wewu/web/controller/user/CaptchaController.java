package life.wewu.web.controller.user;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import life.wewu.web.service.user.CaptchaService;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/captcha")
@RequiredArgsConstructor
public class CaptchaController {

    private final CaptchaService captchaService;

    @PostMapping("/compare")
    public Map<String, Object> compareCaptcha(@RequestParam("userId") String userId,
                                              @RequestParam("userPwd") String userPwd,
                                              @RequestParam("captcha") String captcha) {
        Map<String, Object> response = new HashMap<>();
        try {
            String captchaKey = "CAPTCHA_KEY"; // 실제로는 클라이언트로부터 받아야 함
            String captchaResult = captchaService.compare(captchaKey, captcha);
            if (captchaResult.contains("\"result\":true")) {
                // 로그인 처리
                response.put("success", true);
            } else {
                response.put("success", false);
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
        }
        return response;
    }
}
