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

    @GetMapping("/key")
    public Map<String, Object> getCaptchaKey() {
        Map<String, Object> response = new HashMap<>();
        try {
            String captchaKey = captchaService.getCaptchaKey();
            response.put("success", true);
            response.put("key", captchaKey);
        } catch (Exception e) {
            response.put("success", false);
            response.put("error", e.getMessage());
        }
        return response;
    }

//    @PostMapping("/compare")
//    public Map<String, Object> compareCaptcha(@RequestParam("userId") String userId,
//                                              @RequestParam("userPwd") String userPwd,
//                                              @RequestParam("captcha") String captcha,
//                                              @RequestParam("key") String key) {
//        Map<String, Object> response = new HashMap<>();
//        try {
//            String captchaResult = captchaService.compare(key, captcha);
//            if (captchaResult.contains("\"result\":true")) {
//                response.put("success", true);
//            } else {
//                response.put("success", false);
//            }
//        } catch (Exception e) {
//            response.put("success", false);
//            response.put("error", e.getMessage());
//        }
//        return response;
//    }
    
    
    @PostMapping("/compare")
    public Map<String, Object> compareCaptcha(@RequestParam("captcha") String captcha,
                                              @RequestParam("key") String key) {
        Map<String, Object> response = new HashMap<>();
        try {
            String captchaResult = captchaService.compare(key, captcha);
            if (captchaResult.contains("\"result\":true")) {
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
