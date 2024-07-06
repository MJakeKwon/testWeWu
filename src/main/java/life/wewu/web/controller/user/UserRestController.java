package life.wewu.web.controller.user;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import life.wewu.web.domain.plant.MyPlant;
import life.wewu.web.domain.plant.PlantLevl;
import life.wewu.web.domain.user.User;
import life.wewu.web.service.plant.PlantService;
import life.wewu.web.service.user.SmsService;
import life.wewu.web.service.user.UserService;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserRestController {

    @Autowired
    @Qualifier("userServiceImpl")
    private UserService userService;

    @Autowired
    @Qualifier("smsService")
    private SmsService smsService;
    
    @Autowired
    @Qualifier("plantServiceImpl")
    private PlantService plantService;
    
    @Value("${naver.client.id}")
    private String clientId;

    @Value("${naver.client.secret}")
    private String clientSecret;
    
    @RequestMapping(value="/login", method=RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> login(@ModelAttribute("user") User user, HttpSession session, HttpServletRequest request) {
        System.out.println("/user/login : POST");
        Map<String, Object> response = new HashMap<>();

        try {
            int loginAttempts = session.getAttribute("loginAttempts") != null ? (int) session.getAttribute("loginAttempts") : 0;
            if (loginAttempts >= 3) {
                String captchaValue = request.getParameter("captcha");
                String captchaKey = request.getParameter("captchaKey");
                boolean isCaptchaValid = verifyCaptcha(captchaKey, captchaValue); // 캡차 검증 메서드

                if (!isCaptchaValid) {
                    System.out.println("캡차 인증 실패");
                    response.put("success", false);
                    response.put("error", "captcha_failed");
                    return response;
                }
            }

            // 로그인 서비스 호출
            User dbUser = userService.login(user);

            if (dbUser != null) {
                session.setAttribute("user", dbUser);
                session.setAttribute("isAdmin", "1".equals(dbUser.getRole()));
                session.setAttribute("userNickname", dbUser.getNickname()); // 사용자 닉네임 세션에 저장
                session.removeAttribute("loginAttempts"); // 로그인 성공 시 로그인 시도 횟수 초기화
                try {
                	MyPlant myPlant = plantService.getMyPlant(dbUser.getNickname());
                	PlantLevl plantLevl = plantService.getPlantLevl(myPlant.getPlantLevl().getPlantLevlNo());
                    myPlant.setPlantLevl(plantLevl);
                    session.setAttribute("myPlant", myPlant);
                } catch (Exception e) {
                    System.out.println("MyPlant 가져오기 중 예외 발생 : " + e.getMessage());
                    e.printStackTrace();
                }
                System.out.println("로그인 성공: " + dbUser.getUserId());
                response.put("success", true);
            } else {
                System.out.println("로그인 실패: 비밀번호 불일치 또는 사용자 없음");
                session.setAttribute("loginAttempts", ++loginAttempts); // 로그인 실패 시 로그인 시도 횟수 증가
                response.put("success", false);
                response.put("error", "\n 아이디 또는 비밀번호가 틀렸습니다.");
            }
        } catch (IllegalArgumentException e) {
            // 유효하지 않은 사용자 정보 예외 처리
            System.out.println("유효하지 않은 사용자 정보: " + e.getMessage());
            response.put("success", false);
            response.put("error", "유효하지 않은 사용자입니다.");
        } catch (Exception e) {
            // 일반 예외 처리
            System.out.println("로그인 중 예외 발생: " + e.getMessage());
            response.put("success", false);
            response.put("error", "로그인이 제한된 계정입니다");
        }
        return response;
    }

    // 캡차 검증 메서드
    private boolean verifyCaptcha(String captchaKey, String captchaValue) {
        // 캡차 검증 로직 추가 (예: 외부 API 호출)
        // 성공 시 true 반환, 실패 시 false 반환
        return true; // 예시로 성공 반환
    }

    
//        @PostMapping("/geocode")
//        @ResponseBody
//    public ResponseEntity<String> getGeocode(@RequestParam String address) {
//        try {
//            RestTemplate restTemplate = new RestTemplate();
//            HttpHeaders headers = new HttpHeaders();
//            headers.set("X-NCP-APIGW-API-KEY-ID", clientId);
//            headers.set("X-NCP-APIGW-API-KEY", clientSecret);
//
//            String encodedAddress = URLEncoder.encode(address, StandardCharsets.UTF_8.toString());
//            String url = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=" + encodedAddress;
//
//            HttpEntity<String> entity = new HttpEntity<>(headers);
//            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
//            return response;
//        } catch (Exception e) {
//            e.printStackTrace();
//            return ResponseEntity.status(500).body("Internal Server Error: " + e.getMessage());
//        }
//    }

    // 인증번호 발송 메소드
    @PostMapping("/send-verification-code")
    public ResponseEntity<String> sendVerificationCode(@RequestParam String phoneNum) {
        userService.sendVerificationCode(phoneNum);
        return ResponseEntity.ok("인증번호가 전송되었습니다.");
    }

    @PostMapping("/verify-code-userId")
    @ResponseBody
    public Map<String, Object> verifyCodeUserId(@RequestParam String phoneNum,
                                                @RequestParam String code,
                                                @RequestParam String userName) throws Exception {
        System.out.println("verifyCodeUserId 호출됨");
        System.out.println("phoneNum:" + phoneNum);
        System.out.println("code:" + code);
        System.out.println("userName:" + userName);

        Map<String, Object> response = new HashMap<>();

        boolean isVerified = userService.verifyCode(phoneNum, code);
        System.out.println("isVerified:" + isVerified);
        response.put("isVerified", isVerified);

        if (isVerified) {
            // 인증 성공: 아이디를 찾아서 반환
            User user = userService.findUserId(phoneNum, userName);
            if (user != null) {
                response.put("userId", user.getUserId());
            } else {
                response.put("error", "사용자를 찾을 수 없습니다. 입력을 확인하세요.");
            }
        } else {
            // 인증 실패
            response.put("error", "인증 실패");
        }

        return response;
    }

    @PostMapping("/verify-code-userPwd")
    @ResponseBody
    public Map<String, Object> verifyCodeUserPwd(@RequestParam String phoneNum,
                                                 @RequestParam String code,
                                                 @RequestParam String userId) throws Exception {
        System.out.println("verifyCodePwd 호출됨");
        System.out.println("phoneNum:" + phoneNum);
        System.out.println("code:" + code);
        System.out.println("userId:" + userId);

        Map<String, Object> response = new HashMap<>();

        boolean isVerified = userService.verifyCode(phoneNum, code);
        System.out.println("isVerified:" + isVerified);
        response.put("isVerified", isVerified);

        if (isVerified) {
            // 인증 성공: 비밀번호 변경 페이지로 리디렉션
            User user = userService.findUserPwd(phoneNum, userId);
            if (user != null) {
                response.put("userId", user.getUserId());
            } else {
                response.put("error", "사용자를 찾을 수 없습니다. 입력을 확인하세요.");
            }
        } else {
            // 인증 실패
            response.put("error", "인증 실패");
        }

        return response;
    }
    
    // 테스트용 인증번호 발송 메소드
//    @PostMapping("/send-test-verification-code")
//    public ResponseEntity<String> sendTestVerificationCode(@RequestParam String phoneNum) {
//        userService.sendTestVerificationCode(phoneNum);
//        return ResponseEntity.ok("테스트용 인증번호가 전송되었습니다.");
//    }
    
    //아이디 닉네임 중복체크 검사
	    @GetMapping("/checkId")
	    public ResponseEntity<Map<String, Boolean>> checkId(@RequestParam String userId) {
	        if (!userId.matches("^[a-zA-Z가-힣0-9]{2,30}$")) {
	            Map<String, Boolean> response = new HashMap<>();
	            response.put("available", false);
	            return ResponseEntity.ok(response);
	        }
	        boolean available;
	        try {
	            available = !userService.checkUserId(userId);
	        } catch (Exception e) {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	        }
	        Map<String, Boolean> response = new HashMap<>();
	        response.put("available", available);
	        return ResponseEntity.ok(response);
	    }
	
	    @GetMapping("/checkNickname")
	    public ResponseEntity<Map<String, Boolean>> checkNickname(@RequestParam String nickname) {
	        Map<String, Boolean> response = new HashMap<>();
	        if (!nickname.matches("^[a-zA-Z가-힣0-9]{2,20}$")) {
	            response.put("available", false);
	            return ResponseEntity.ok(response);
	        }
	        boolean available;
	        try {
	            available = !userService.checkNickName(nickname);
	        } catch (Exception e) {
	            e.printStackTrace(); // 예외 로그를 출력하여 확인합니다.
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
	        }
	        response.put("available", available);
	        return ResponseEntity.ok(response);
	    }

    
       //비밀번호 유효성검사, 같음 검사
        @PostMapping("/pwdCheck")
        public ResponseEntity<String> addUser(@RequestBody User user) {
            if (!user.getUserPwd().matches("^(?=.*[a-zA-Z])(?=.*[!@#$%^&*]).{8,30}$")) {
                return ResponseEntity.badRequest().body("비밀번호는 8자 이상 30자 이하, 영문과 특수기호를 포함해야 합니다.");
            }
            if (!user.getUserPwd().equals(user.getUserPwd())) {
                return ResponseEntity.badRequest().body("비밀번호가 일치하지 않습니다.");
            }
            try {
                userService.addUser(user);
            } catch (Exception e) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("회원가입 중 오류가 발생했습니다.");
            }
            return ResponseEntity.ok("회원가입 성공");
        }
        
        @GetMapping("/validatePassword")
        public ResponseEntity<Map<String, Boolean>> validatePassword(@RequestParam String password) {
            boolean isValid = password.matches("^(?=.*[a-zA-Z])(?=.*[!@#$%^&*]).{8,30}$");
            Map<String, Boolean> response = new HashMap<>();
            response.put("isValid", isValid);
            return ResponseEntity.ok(response);
        }
        
        @PostMapping("/verify-code-user")
        public ResponseEntity<Map<String, Object>> verifyCodeUser(@RequestParam String phoneNum, 
                                                                  @RequestParam String code) {
            Map<String, Object> response = new HashMap<>();
            try {
                boolean isVerified = userService.verifyCode(phoneNum, code);
                response.put("valid", isVerified);
                if (isVerified) {
                    response.put("message", "인증 성공");
                    return ResponseEntity.ok(response);
                } else {
                    response.put("message", "인증 실패");
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
                }
            } catch (Exception e) {
                response.put("message", "인증 과정에서 오류가 발생했습니다.");
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
            }
        }
        
        @PostMapping("/updateAdmin")
        public ResponseEntity<String> updateAdminPwd(@RequestParam("userId") String userId,
                                                     @RequestParam("newPassword") String newPassword,
                                                     @RequestParam("confirmPassword") String confirmPassword) throws Exception {
            if (!newPassword.equals(confirmPassword)) {
                return ResponseEntity.badRequest().body("비밀번호가 일치하지 않습니다.");
            }

            User user = userService.getUser(userId);
            user.setUserPwd(newPassword);
            userService.updatePwd(user);

            return ResponseEntity.ok("비밀번호가 성공적으로 변경되었습니다.");
        }
        
        @RequestMapping(value = "userQuit", method = RequestMethod.POST)
        @ResponseBody
        public Map<String, String> userQuit(@RequestParam("userId") String userId, HttpSession session) throws Exception {
            System.out.println("/user/userQuit : POST");

            // User ID로 사용자 정보 조회
            User dbUser = userService.getUser(userId);
            
            // 역할에 따라 리다이렉트 URL 결정
            String redirectUrl = "/index.jsp"; // 기본 리다이렉트 URL
            
            if ("1".equals(dbUser.getRole())) {
                // 관리자일 경우 사용자 삭제 후 listUser.jsp로 리다이렉트
                userService.deleteUser(userId);
                redirectUrl = "/user/listUser";
            } else if ("2".equals(dbUser.getRole())) {
                // 일반 사용자일 경우 사용자 삭제 후 home.jsp로 리다이렉트
                userService.deleteUser(userId);
                redirectUrl = "/index.jsp";
            }

            // JSON 형태로 리다이렉트 URL 반환
            Map<String, String> response = new HashMap<>();
            response.put("redirect", redirectUrl);

            return response;
        }
        
//     // 예제: Java Spring Controller
//        @PostMapping("/user/login")
//        @ResponseBody
//        public ResponseEntity<Map<String, String>> login(@RequestParam String userId, @RequestParam String userPwd) {
//            Map<String, String> response = new HashMap<>();
//            if (userId == null || userId.isEmpty()) {
//                response.put("error", "ID 를 입력하지 않으셨습니다.");
//                return ResponseEntity.badRequest().body(response);
//            }
//
//            if (userPwd == null || userPwd.isEmpty()) {
//                response.put("error", "패스워드를 입력하지 않으셨습니다.");
//                return ResponseEntity.badRequest().body(response);
//            }
//            
//            User user = userService.login(user);
//            // 로그인 로직
//            boolean loginSuccess = user;
//            if (!loginSuccess) {
//                response.put("error", "아이디 또는 패스워드가 잘못되었습니다.");
//                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
//            }
//
//            response.put("message", "로그인 성공");
//            return ResponseEntity.ok(response);
//        }

        
//        @PostMapping("/verify-code")
//        public ResponseEntity<Map<String, Boolean>> verifyCode(@RequestParam String phoneNum, @RequestParam String code) {
//            boolean isValid = userService.verifyCode(phoneNum, code);
//            
//            System.out.println("verify-code");
//            Map<String, Boolean> response = new HashMap<>();
//            response.put("valid", isValid);
//            return ResponseEntity.ok(response);
//        }
}
