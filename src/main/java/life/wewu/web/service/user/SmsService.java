package life.wewu.web.service.user;

import java.util.Random;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Component
public class SmsService {

    final DefaultMessageService messageService;
    
    @Value("${sms.from-number}") 
    private String FROM;

    public SmsService(@Value("${sms.api-key}") String API_KEY,
		                      @Value("${sms.api-secret-key}") String API_SECRET_KEY,
		                      @Value("${sms.domain}") String DOMAIN) {
        this.messageService = NurigoApp.INSTANCE.initialize(API_KEY, API_SECRET_KEY, DOMAIN);
    }
    
    public String sendVerificationCode(String to) {
        String verificationCode = generateVerificationCode();
        Message message = new Message();
        message.setFrom(FROM);
        message.setTo(to);
        message.setText("인증번호: " + verificationCode);

        SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
        String statusCode = response.getStatusCode();
        if (statusCode.equals("2000")) {
            return verificationCode;
        } else {
            throw new RuntimeException("SMS 전송 실패");
        }
//        return verificationCode;

    }

    private String generateVerificationCode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000);
        return String.valueOf(code);
    }
    
 // 테스트용으로 임의의 값을 반환하는 메소드 추가
//    public String generateTestVerificationCode() {
//        String code = "123456";
//    	return code; // 임의의 고정된 값 반환
//    }
}