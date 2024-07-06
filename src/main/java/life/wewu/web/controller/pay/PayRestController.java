package life.wewu.web.controller.pay;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import life.wewu.web.domain.user.User;

@RestController
@RequestMapping("/app/pay/*")
public class PayRestController {
 
	@RequestMapping("kakaoPay")
	public String kakaoPay(@RequestParam Map<String, String> params,HttpSession session) throws Exception 
	{
		System.out.println("/purchase/kakaoPay");
		
		ObjectMapper objectMapper = new ObjectMapper();
        
        String apiUrl = "https://open-api.kakaopay.com/online/v1/payment/ready";	//전달할 api 주소
        String auth = "SECRET_KEY DEV2A934096C80C2209BAF69D180963DA7A10B91";		//전달을 위한 key 값
        
        HttpHeaders headers = new HttpHeaders();	//데이터 전달을 위한 header 생성
        headers.set("Content-type","application/json");
        headers.set("Authorization", auth);
        
        Map<String, Object> requestBodyMap = new LinkedHashMap<>(); //데이터전달할 json data 생성
        
        requestBodyMap.put("cid", "TC0ONETIME"); //테스트 결제는 가맹점 코드로 'TC0ONETIME'를 사용
        requestBodyMap.put("partner_order_id", "wewu"); //일단 아무값이나 hard coding.
        requestBodyMap.put("partner_user_id", ((User)session.getAttribute("user")).getUserName()); //일단 아무값이나 hard coding.
        requestBodyMap.put("item_name", params.get("item_name"));
        requestBodyMap.put("quantity", params.get("quantity"));
        requestBodyMap.put("total_amount", params.get("total_amount"));
        requestBodyMap.put("tax_free_amount", params.get("tax_free_amount"));
        requestBodyMap.put("approval_url", "https://www.wewu.life/pay/kakaoPay/success"); //결제 성공시 넘어갈 url
        requestBodyMap.put("cancel_url", "https://www.wewu.life/pay/kakaoPay/cancel"); //결제 취소시 넘어갈 url
        requestBodyMap.put("fail_url", "https://www.wewu.life/pay/kakaoPay/fail"); //결제 실패시 넘어갈 url


        String requestBody;
        try 
        {
            requestBody = objectMapper.writeValueAsString(requestBodyMap);
        }catch (JsonProcessingException e) 
        {
            e.printStackTrace();
            return "JSON 변환에 실패했습니다.";
        }
        
        HttpEntity<String> requestEntity  = new HttpEntity<>(requestBody, headers);	//전달할 객체 생성(헤더 + 바디)
        RestTemplate restTemplate = new RestTemplate();
        
        ResponseEntity<String> response = restTemplate.postForEntity(apiUrl, requestEntity, String.class);	//객체를 request하여 response 받을 객체
        
        if (response.getStatusCode().is2xxSuccessful()) 
        {
        	//전달된 body(jsonData return)
        	System.out.println(response.getBody());
        	 JSONObject json = new JSONObject(response.getBody());

             // 원하는 값 추출
             String tid = json.getString("tid");
             session.setAttribute("tid", tid);
        	return response.getBody();
        	
        } else 
        {
            return "결제 생성에 실패했습니다.";
        }
	}
	
}
