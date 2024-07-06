package life.wewu.web.controller.pay;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import life.wewu.web.common.Search;
import life.wewu.web.domain.item.ItemPurchase;
import life.wewu.web.domain.pay.Pay;
import life.wewu.web.domain.user.User;
import life.wewu.web.service.item.ItemService;
import life.wewu.web.service.pay.PayService;
import life.wewu.web.service.user.UserService;


@Controller
@RequestMapping("/pay/*")
public class PayController {
	///필드
    @Autowired //처음 spring boot 올라갈 때 autowired 되어있는 애들 올라가면서 생성
    @Qualifier("payService") //자동 생성 시 사용. 구현체인 itemPurchaseServiceImpl을 사용. 
    private PayService payService; //itemService에 itemPurchaseServiceImpl가 담김. 
    
    @Autowired //처음 spring boot 올라갈 때 autowired 되어있는 애들 올라가면서 생성
    @Qualifier("userServiceImpl") //자동 생성 시 사용. 구현체인 itemPurchaseServiceImpl을 사용. 
    private UserService userService; //itemService에 itemPurchaseServiceImpl가 담김. 

	@RequestMapping(value="kakaoPay/success")
	public String kakaoPaySucess(@RequestParam String pg_token,@SessionAttribute("user") User user, HttpSession session,Model model ) throws Exception 
	{
		System.out.println("/pay/kakaoPay/success");
		
		ObjectMapper objectMapper = new ObjectMapper();
        
        String apiUrl = "https://open-api.kakaopay.com/online/v1/payment/approve";	//전달할 api 주소
        String auth = "SECRET_KEY DEV2A934096C80C2209BAF69D180963DA7A10B91";		//전달을 위한 key 값
        
        HttpHeaders headers = new HttpHeaders();	//데이터 전달을 위한 header 생성
        headers.set("Content-type","application/json");
        headers.set("Authorization", auth);
        
        Map<String, Object> requestBodyMap = new LinkedHashMap<>(); //데이터전달할 json data 생성
        
        requestBodyMap.put("cid", "TC0ONETIME"); //테스트 결제는 가맹점 코드로 'TC0ONETIME'를 사용
        requestBodyMap.put("tid", session.getAttribute("tid")); //일단 아무값이나 hard coding.
        requestBodyMap.put("partner_user_id", ((User)session.getAttribute("user")).getUserName()); //일단 아무값이나 hard coding.
        requestBodyMap.put("partner_order_id", "wewu");
        requestBodyMap.put("pg_token", pg_token); //결제 실패시 넘어갈 url
        System.out.println(requestBodyMap);
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
        	System.out.println("성공");
        	JSONObject json = new JSONObject(response.getBody());
             // 원하는 값 추출
            String tid = json.getString("tid");
            String aa = json.getString("amount");
            JSONObject jsonAmount = new JSONObject(aa);
            int amount = jsonAmount.getInt("total");
            model.addAttribute("amount", amount);
            System.out.println(amount);
            session.setAttribute("tid", tid);

            //유저 현재포인트
            int currentPoint = user.getCurrentPoint();
            
            //구매 후 유저 예상 포인트
            int afterPoint = (currentPoint + amount);
            
            //충전내역 저장을 위해 Pay 도메인 injection
            Pay pay = Pay.builder()
            		.buyerNickname(user.getNickname())
            		.currentPoint(user.getCurrentPoint())
            		.payType("A")
            		.payOption("P")
            		.afterChargePoint(afterPoint)
            		.payAmount(amount)
            		.payFlag("T")
            		.build();
            
            //충전내역 저장 
            payService.addPointCharge(pay);
            
            
            //유저의 현재포인트를 구매후 포인트로 set
            user.setCurrentPoint(afterPoint);
            userService.updateUserPoint(user.getUserId(), afterPoint);
            
            //세션에 저장된 유저 정보를 업데이트
            session.setAttribute("user", user);
            
            //완료 페이지로 이동
        	return "forward:/pay/getPointChargeRslt.jsp";
        	
        } else 
        {
            return "forward:/pay/getPointChargeRslt.jsp"; //실패했을 때 jsp로 교체
            //return "/";
        }
	}
	
	@RequestMapping(value="kakaoPay/cancel")
	public String kakaoPayCancel() throws Exception 
	{
		return "/"; //빈 화면 내용물 없음. 대신 alert(구매를 중단하셨습니다. 상품 목록으로 이동합니다) 띄운 뒤 페이지 이동. 이후 구현. 
	}
	
	@RequestMapping(value="kakaoPay/fail")
	public String kakaoPayFail() throws Exception 
	{
		return "/"; //결제 실패했다는 화면 띄우기. 이후 구현. 
	}
	
	@RequestMapping( value="getPointChargeList", method=RequestMethod.GET )
	public String getRefundPointList(@RequestParam String buyerNickname, Model model,Search search) throws Exception{ 
	
		System.out.println(":: /pay/getPointChargeList ::GET");
		search.setSearchKeyword(buyerNickname);
		List<Pay> list = payService.getPointChargeList(search); //이거는..흠.. List<ItemPurchase> list = itemPurchaseService.getRefundPointList(user.getNickname());라고 itemPurchaseServiceTest에 되어있음. 근데 buyer_nickname이라고 써도 되나? ==>ㅇㅇ. 그 전엔 user 도메인의 것을 써서 그런거고, 여기선 itempurchase꺼 쓰니까. 
		System.out.println(list);
		model.addAttribute("list", list);
		
		return "forward:/pay/listPointCharge.jsp"; 
   	}
	
	@RequestMapping( value="getPointCharge", method=RequestMethod.GET )
	public String getPointCharge(@RequestParam int payNo, Model model) throws Exception{ 

		System.out.println(":: /pay/getPointCharge ::GET");
		
		Pay pay = payService.getPointCharge(payNo);
		System.out.println(pay);
		model.addAttribute("pay", pay);
		
		return "forward:/pay/getPointCharge.jsp"; 
   	}
}
