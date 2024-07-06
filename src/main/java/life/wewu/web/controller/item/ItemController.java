/*
 * 작성자 : 최윤정
 * 작성일 : 2024-06-10
 */

package life.wewu.web.controller.item;
	
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import life.wewu.web.common.Search;
import life.wewu.web.domain.item.Item;
import life.wewu.web.domain.item.ItemPurchase;
import life.wewu.web.domain.item.ShoppingCart;
import life.wewu.web.domain.user.User;
import life.wewu.web.repository.S3Repository;
import life.wewu.web.service.item.ItemService;	
import life.wewu.web.service.item.ItemPurchaseService;	
import life.wewu.web.service.item.ShoppingCartService;

//=> 아이템 Controller
@Controller
@RequestMapping("/item/*")
public class ItemController {

   ///필드
   @Autowired //처음 spring boot 올라갈 때 autowired 되어있는 애들 올라가면서 생성
   @Qualifier("itemServiceImpl") //자동 생성 시 사용. 구현체인 itemPurchaseServiceImpl을 사용. 
   private ItemService itemService; //itemService에 itemPurchaseServiceImpl가 담김. 

   @Autowired //처음 spring boot 올라갈 때 autowired 되어있는 애들 올라가면서 생성
   @Qualifier("itemPurchaseServiceImpl") //자동 생성 시 사용. 구현체인 itemPurchaseServiceImpl을 사용. 
   private ItemPurchaseService itemPurchaseService; //itemService에 itemPurchaseServiceImpl가 담김. 

   @Autowired //처음 spring boot 올라갈 때 autowired 되어있는 애들 올라가면서 생성
   @Qualifier("shoppingCartServiceImpl") //자동 생성 시 사용. 구현체인 itemPurchaseServiceImpl을 사용. 
   private ShoppingCartService shoppingCartService; //itemService에 itemPurchaseServiceImpl가 담김. 

   
   @Autowired 
   @Qualifier("s3RepositoryImpl") 
   private S3Repository s3Repository;
   
   public ItemController(){
	   
      System.out.println(this.getClass());
      
   }	
   
   /*
    * ItemService 부분
    */
   @RequestMapping( value="addItem", method=RequestMethod.GET )
 	//public String addItem() throws Exception{ //itemservice에는 pramerter이 Item item임. 이렇게 안 써도 되나?==>ㅇㅇ.addItem 하기 전에 반드시 필요한 값이 없으므로, 비워놓음. 
   	public String addItem() throws Exception{ //string은 return 하는 게 문자열이므로 string임. 
 	
 		System.out.println("item addItem :: GET ");
 		
 		return "forward:/item/addItem.jsp"; 
 	}
   
   /*
   @RequestMapping( value="addItem", method=RequestMethod.POST ) 
	public String addItem(@ModelAttribute Item item, @RequestParam String hash, @RequestPart(required = false) MultipartFile file) throws Exception{
	
		System.out.println("item addItem :: POST ");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("file", file);
		
		itemService.addItem(item);
		return "redirect:/item/getItemList"; 
	}
   */
   
   
   @RequestMapping( value="addItem", method=RequestMethod.POST ) 
	public String addItem(@ModelAttribute Item item, @RequestPart MultipartFile file) throws Exception{
	
		System.out.println("item addItem :: POST ");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("file", file);
		map.put("folderName", "item");
		
		String url = s3Repository.uplodaFile(map);
		
		item.setItemImg(s3Repository.getShortUrl(url));
		
		
		itemService.addItem(item);
		return "redirect:/item/getItemList"; 
	}
  
   
   @RequestMapping( value="getItem", method=RequestMethod.GET ) //완
	public String getItem(int itemNo, Model model) throws Exception{
	
		System.out.println("item GetItem :: ");
		
		Item item = itemService.getItem(itemNo);  //얘는 itemService.getItem(item.getItemNo) 안 해도 되는 이유==> 위에 parameter에 int itemNo 넣어놨으므로, 그거 써야 함. 또한 item 객체가 존재하지 않는 상황에서 item.getItemNo() 호출 불가능함.  
		
		model.addAttribute("item", item);
		
		return "forward:/item/getItem.jsp"; 
   }
   
	
   @RequestMapping(value="getItemList") //완
	public String getItemList(@ModelAttribute Search search , Model model) throws Exception{
	//("search")
		System.out.println("item getItemList :: ");
		
		List<Item> item = itemService.getItemList(search);
		System.out.println(search);
		model.addAttribute("item", item);
		System.out.println(item);
		
		return "forward:/item/itemMain.jsp"; //브라우저에 http://127.0.0.1:8080/item/getItemList 이렇게 뜨는 이유는 controller에서 경로를 getItemList쪽으로 보내기 때문임. item/getItemList에 연결된 mapping으로 보내면 아이템 리스트 정보 다 for문 돈 거 가져옴. 근데 item
		//main.jsp로 바로 가면 아이템 정보를 받아서 저장하지 않기 때문에 등록하기 만 뜸. 
	}
   
   @RequestMapping( value="updateItem", method=RequestMethod.GET )  //item 정보 수정하는 화면. 보통 get 방식이 requestparam이고 post 방식이 modelattribute인가? ==> 꼭 그런 건 아님. 주로 post 쓰는 이유: model attribute 쓰는 이유가 애초에 데이터가 많아서임. 또한 그런 많은 데이터를 다뤄야(?) 하니까 post를 씀. 
  	public String updateItem(@RequestParam("itemNo") int itemNo, Model model) throws Exception{  //itemNo를 무조건 int 타입 itemNo로 받겠다는 말. 아이템 수정에 꼭 필요한 정보가 있나...==> item 수정할 때 itemNo 필요하므로, 들어가는 게 맞음. 
  	
  		System.out.println("item updateItem :: GET");
  		 
  		Item item = itemService.getItem(itemNo);  //updateItem인데 getItem을 먼저 하는 이유가 일단 getItem을 받도록 로직을 짰기 때문이 맞나..?==> ㅇㅇ. 
  		
  		model.addAttribute("item", item);
  		
  		return "forward:/item/updateItem.jsp"; //forward는 새로 리퀘스트 주는 게 아니라서 uri 안 바뀜. forward 하면 view를 같이 보내므로 변경된 데이터를 반영해서 같이 보내줌. forward는 view(jsp의 ui) 랑 데이터 같이 보냄. jsp에선 그 데이터를 받아서 출력해서 쓸 수 있음.jsp는 return updateItem.jsp 이렇게 파일 이름 적어줌. 그러면 itemController의 updateItem에 mapping 그 안에 변경된 데이터를 넣어서 가져옴. 예를 들어, updateItem.jsp의 ${item.itemPrice}에 item을 ItemController의 updateItem에 requestParam으로 인자 준 itemNo, 그리고 그걸 활용해서 item에 저장해놓고, 그걸 model.attribute로 연결함. 그러면 jsp는 ${item.itemPrice}의 item에 그걸 다 반영함. 그래서 return forward:/item/updateItem.jsp로 jsp 파일 이름 적어주면, view와 데이터를 같이 보내고, 변경된 데이터를 반영해서 http://127.0.0.1:8080/item/updateItem?itemNo=2 이렇게 보이는 것임. 그리고 여기서 itemNo는 parameter 캬캬.... 근데 이건 forward라서 가능한 것임. redirect는 안 됨. redirect는 return에 적혀있는 uri로 새로 requst함. 그래서 return redirect 하면 상품 수정 창이 다 공란으로 뜸. 그래서 redirect는 return에 적혀 있는 uri로 새로 리퀘스트 해 줌.  
  	}
   
   
 	@RequestMapping( value="updateItem", method=RequestMethod.POST)
 	 public String updateItem(@ModelAttribute("item") Item item , Model model) throws Exception{ //HttpSession이 로그인 상태를 그대로 유지하기 위해서? ==> HttpSession: session에 있는 정보를 담아올 때. session  없으면 로그인한 유저 정보 계속 들고 다녀야 함. 근데 updateItem에는 필요X. updateItem은 관리자만 들어올 수 있음. 이미 여기 접근했다는 거 자체가, role 검증이 끝난 거임.  
 		
 		System.out.println("item updateItem :: POST"); 
 		
 		itemService.updateItem(item); //지금은 updateItem을 먼저 getItem을 받아서 view 보여주고, 나중에 수정만 하는 걸로 바꿔놓음. 근데 2개 합쳐서 못 만드나?=> 화면정의서 단계에서 계획했어야 함. 
 		
 		model.addAttribute("item", item); 
 		
 		return "redirect:/item/getItem?itemNo="+item.getItemNo(); //여기는 jsp가 아니라 controller로 보내는 것임. 그러니까 update인데 왜 getItem을 일단 가져오고, 거기서 getItemNo를 하는 걸로 하지? 그냥 바로 update로 받으면 안 되나? "redirect:/item/getItem?itemNo="+item.getItemNo();  ==>update는 아이템 목록조회에서 수정하기 버튼 눌러 수정. 그런데 여긴 update 한 후의 화면을 보여주므로, getItemList로 보내주는 게 맞음.  
 	}
   
 	/*
 	@RequestMapping( value="deleteItem", method=RequestMethod.GET)  //이름은 delete지만 사실상 관리자의 메인화면. delete item도 get, post로 화면 2개 나누는 게 맞음?  ==> ㅇㅇ. 맞는 듯. +아이템 삭제가 관리자의 메인화면이기는 하지만, itemMain.jsp 메인화면을 그대로 씀. 일단 메뉴 다 넣어 놓고, 비활성화 시키거나 보여주지 않는 조건 거는 방식으로. 
 	 public String deleteItem(@RequestParam("itemNo") int itemNo, Model model) throws Exception{
 		
  		System.out.println("item deleteItem :: GET");
  		
  		itemService.deleteItem(itemNo);   //delete는 update랑 다르게 기존에 저장된 아이템 정보 보여줄 필요 없음. pk만 있으면 삭제 가능하므로 deleteItem으로 받음. 
  		
  		return "redirect:/item/getItemList";
 		
 	}
 	*/
 	
	/*이건 필요 없어서 삭제함. delete는 update랑 다르게 기존에 저장된 아이템 정보 보여줄 필요 없음. pk만 있으면 삭제 가능하므로 get, post 둘 중 하나만 남겼음. 
 	@RequestMapping( value="deleteItem", method=RequestMethod.POST)  //여기 return 되는 거 다시 한 번 확인 필요
 	 public String deleteItem(@ModelAttribute("item") Item item) throws Exception{
 		
 		System.out.println("item deleteItem :: POST"); 
 		
 		itemService.deleteItem(item.getItemNo()); //item.getItemNo 한 이유는 위에서 modelAttribugte가 "item"이라는 이름으로 Item 도메인에 값을 set 해 줌. 그냥 item이라고만 하면 그 중에서 itemNo를 가져올 수 없으므로 get적어주는 것. updateItem은 itemService.updateItem(item); 이거 가능. 왜냐면 updateItem의 parametertype이 item이고, 도메인 item의 전체 필드? 값?을 끌어다쓰므로 item이라고만 적어도 되는 것임. 
 		
 		return "redirect:/item/getItemList"; //redirect인데 delete니까 redirect:/item/getItemList 이렇게만 넣어야 하나? update처럼 redirect:/item/getItem?itemNo="+item.getItemNo(); 이렇게 가져올 수 없음. 삭제가 되니까....
 	}
 	*/
 	
 	//이거 못 했음
 	/*
 	@RequestMapping( value="getItemSearch")  //한 번 더 확인 필요. model.addAttribute("search", search); 들어가는 게 맞음? searchcondition은 어떻게 하지?... 왜 search는 get인지 post인지 안 쓰지..?
	 public String getItemSearch(@ModelAttribute Search search , Model model) throws Exception{
		
		System.out.println("item getItemSearch :: GET/POST"); 
		
	    List<Item> list = itemService.getItemSearch(search);
	    
	    model.addAttribute("list", list);
	    model.addAttribute("search", search);
		
		return "forward:/item/getItemSearch"; //화면 정의서에는 getitemlist에서 같은 화면 활용하는 걸로 만들어놓음. 어떻게 만들어야 하지....? 
		//return "redirect:/item/getItemList?itemNo="+item.getitemNo();
 	}
	*/
    @RequestMapping( value="addPurchase", method=RequestMethod.GET )
   	public String addPurchase(@RequestParam("itemNo") int itemNo, Model model) throws Exception{ 
	 	
		System.out.println(":: /itemPurchase/addPurchase ::GET");
		
		Item item = itemService.getItem(itemNo);
		
		model.addAttribute("item", item);
		
		return "forward:/item/payItem.jsp"; 
	}
 	
	   
   @RequestMapping( value="addPurchase", method=RequestMethod.POST ) 
    public String addPurchase(@ModelAttribute("itemPurchase") ItemPurchase itemPurchase ) throws Exception{
	
		System.out.println("/itemPurchase/addPurchase ::POST");
		Item item = itemService.getItem(itemPurchase.getItemNo()); //itemService의 itemNo와 같은 걸 itemPurchaseService에서 가져오도록. 
		int currentPoint = 3000 - (item.getItemPrice() * itemPurchase.getItemCnt()); //지금은 session 안 해 놔서 일단 3000으로 설정해 놓은 것. 
		itemPurchase.setCurrentPoint(currentPoint);
		itemPurchaseService.addPurchase(itemPurchase);
		
		return "redirect:/item/getItemList"; 
	}
	
	   
   @RequestMapping( value="getRefundPointList", method=RequestMethod.GET )
	public String getRefundPointList(@RequestParam String buyerNickname, Model model) throws Exception{ 
	
		System.out.println(":: /itemPurchase/getRefundPointList ::GET");
		
		List<ItemPurchase> list = itemPurchaseService.getRefundPointList(buyerNickname); //이거는..흠.. List<ItemPurchase> list = itemPurchaseService.getRefundPointList(user.getNickname());라고 itemPurchaseServiceTest에 되어있음. 근데 buyer_nickname이라고 써도 되나? ==>ㅇㅇ. 그 전엔 user 도메인의 것을 써서 그런거고, 여기선 itempurchase꺼 쓰니까. 
		System.out.println(list);
		model.addAttribute("list", list);
		
		return "forward:/item/listRefundPoint.jsp"; 
   	}
   

   
   @RequestMapping( value="getRefundPoint", method=RequestMethod.GET )
	public String getRefundPoint(@RequestParam int itemPurchaseNo, Model model) throws Exception{ 

		System.out.println(":: /itemPurchase/getRefundPoint ::GET");
		
		ItemPurchase itemPurchase = itemPurchaseService.getRefundPoint(itemPurchaseNo);
		System.out.println(itemPurchase);
		model.addAttribute("itemPurchase", itemPurchase);
		
		return "forward:/item/getRefundPoint.jsp"; 
   	}
   
   @RequestMapping( value="getItemSalesHistoryList", method=RequestMethod.GET )
	public String getItemSalesHistoryList(Model model) throws Exception{ 
	
		System.out.println(":: /itemPurchase/getItemSalesHistoryList ::GET");
		
		List<ItemPurchase> list = itemPurchaseService.getItemSalesHistoryList();
		
		model.addAttribute("list", list);
		
		return "forward:/item/listItemSalesHistory.jsp"; 
   	}
	
   @RequestMapping( value="getItemSalesHistory", method=RequestMethod.GET )
	public String getItemSalesHistory(@RequestParam int itemPurchaseNo, Model model) throws Exception{ 

		System.out.println(":: /itemPurchase/getItemSalesHistory ::GET");
		
		ItemPurchase itemPurchase = itemPurchaseService.getItemSalesHistory(itemPurchaseNo);
		
		model.addAttribute("itemPurchase", itemPurchase);
		
		return "forward:/item/getItemSalesHistory.jsp"; 
   	}

   @RequestMapping( value="getItemPurchaseHistoryList")
	public String getItemPurchaseHistoryList(@ModelAttribute Search search, @RequestParam("buyerNickname") String nickname, Model model) throws Exception{ //map을 어떻게 할지...
	
		System.out.println(":: /itemPurchase/getItemPurchaseHistoryList ::GET");
		
		 Map<String,Object> map = new HashMap<>();
		 map.put("search", search);
	     map.put("buyerNickname", nickname);
		 List<ItemPurchase> list = itemPurchaseService.getItemPurchaseHistoryList(map);
		
		model.addAttribute("list", list);
		
		return "forward:/item/listItemPurchaseHistory.jsp"; 
   	}
   
   @RequestMapping( value="getItemPurchaseHistory", method=RequestMethod.GET )
	public String getItemPurchaseHistory(int itemPurchaseNo, Model model) throws Exception{ 
	
		System.out.println(":: /itemPurchase/getItemPurchaseHistory ::GET");
		 
        ItemPurchase item = itemPurchaseService.getItemPurchaseHistory(itemPurchaseNo);
		model.addAttribute("itemPurchase", item);
		
		return "forward:/item/getItemPurchaseHistory.jsp"; 
   	}
   
   @RequestMapping( value="updatePurchase")  
 	public String updatePurchase(@RequestParam("itemPurchaseNo") int itemPurchaseNo, Model model, @SessionAttribute("user") User user) throws Exception{  
 	
 		System.out.println("itemPurchase updateItemPurchase :: GET");
 		 

 		ItemPurchase itemPurchase = itemPurchaseService.getItemPurchaseHistory(itemPurchaseNo);
        Item item = itemService.getItem(itemPurchase.getItemNo());
        String flag = "";
        if(item.getItemCategory().equals("Y") && itemPurchase.getRefundFlag().equals("N"))
        {
        	//구매정보 리스트 중 선택한 구매정보의 상품이 식물이고 환불을 신청하지 않았다면
        	if(itemPurchase.getItemStock() == itemPurchase.getItemCnt())
        	{
        		//구매한 식물의 구매갯수와 재고량이 같다면
        		System.out.println("환불가능");
        		ItemPurchase afterItemPurchase = ItemPurchase.builder()
	        				.itemPurchaseNo(itemPurchase.getItemPurchaseNo())
	                        .refundFlag("Y")
	                        .refundPoint(item.getItemPrice())
	                        .beforeRefundpoint(90)
	                        .afterRefundpoint(90+item.getItemPrice())
	                        .currentPoint(90 + item.getItemPrice())
	                        .refundAskdate(Date.valueOf("2024-04-02"))
	                        .refundCompdate(Date.valueOf("2024-04-02"))
	                        .build();
        		itemPurchaseService.updatePurchase(afterItemPurchase);
        		flag="Y";
        	}else
        	{
        		//구매한 식물의 구매갯수와 재고량이 다르다면
        		System.out.println("사용한 아이템은 환불 불가능");
        		flag="N";
        	}
        }else
        {
        	//구매정보 리스트 중 선택한 구매정보의 상품이 장식이라면
        	System.out.println("장식 아이템 및 환불된 아이템은 환불 불가능");
        	flag="N";
        }
 		model.addAttribute("flag", flag);
 		return "forward:/item/getItemPurchaseHistoryList?buyerNickname="+user.getNickname(); 	
 	}
  
   	/*
	@RequestMapping( value="updatePurchase", method=RequestMethod.POST)
	 public String updatePurchase( @ModelAttribute("itemPurchase") ItemPurchase itemPurchase , Model model) throws Exception{   
		
		System.out.println("itemPurchase updateItemPurchase :: POST"); 
		
		itemPurchaseService.updatePurchase(itemPurchase);		
		model.addAttribute("itempurchase", itemPurchase); 
		
		return "redirect:/item/getItemPurchaseHistory?itemPurchaseNo="+itemPurchase.getItemPurchaseNo();   //이 부분 맞는지 확인 필요 ==> 여기는 jsp가 아니라 controller로 보내는 것임. 그러니까 getItemPurchaseHistory로 보낸 뒤, itempurchaseno= 이렇게 해서 상세조회 화면으로 이동함. 
	}
  	
	@RequestMapping( value="addShoppingCart", method=RequestMethod.GET ) //화면정의서)장바구니 담기 누르면 알림만 띄우고 목록으로 이동. 장바구니에 담겠습니까?라고 알람 띄우고 목록으로 이동하는 걸로 계획. 그럼 화면을 몇 개 만들어야 하지..? 위에 get(장바구니 추가하는 화면)은 필요 없지 않나?
   	public String addShoppingCart() throws Exception{ 
	 	
		System.out.println(":: /shoppingCart/addShoppingCart ::GET");
		
		return "forward:/shoppingCart/addShoppingCart.jsp"; 
	}
	*/
	   
   @RequestMapping( value="getShoppingCartList", method=RequestMethod.GET ) //완
  	public String getShoppingCartList(String nickname, Model model) throws Exception{
  	
  		System.out.println("shoppingCart getShoppingCartList :: ");
  		
  		List<ShoppingCart> shoppingCart = shoppingCartService.getShoppingCartList(nickname);
  		 
  		model.addAttribute("shoppingCart", shoppingCart); //key, value임
  		
  		return "forward:/item/listShoppingCart.jsp";
  	}
   
   @RequestMapping( value="deleteShoppingCartList", method=RequestMethod.GET)  //이름은 delete지만 사실상 관리자의 메인화면. delete item도 get, post로 화면 2개 나누는 게 맞음?  ==> ㅇㅇ. 맞는 듯. +아이템 삭제가 관리자의 메인화면이기는 하지만, itemMain.jsp 메인화면을 그대로 씀. 일단 메뉴 다 넣어 놓고, 비활성화 시키거나 보여주지 않는 조건 거는 방식으로. 
	 public String deleteShoppingCartList(@SessionAttribute("user") User user, @RequestParam("shoppingCartNo") int shoppingCartNo ,Model model) throws Exception{ //밑에서 nickname 가져오려면 무조건 string nickname 써 줘야 하나? 아님 gpt에선 @RequestParam("nickname") String nickname 이렇게 써주던데 이렇게 해?
		
		System.out.println("shoppingCart deleteShoppingCartList :: GET");
		System.out.println(user);
		shoppingCartService.deleteShoppingCartList(shoppingCartNo);
		
		System.out.println(shoppingCartNo);
		String nickname = URLEncoder.encode(user.getNickname());
		return "redirect:/item/getShoppingCartList?nickname="+nickname; 
		//return "redirect:/shoppingCart/getShoppingCartList?nickname="+nickname;   
	}   //삭제 화면 따로 안 만들었는데...장바구니 목록에서 바로 삭제

	/*
	@RequestMapping( value="deleteShoppingCartList", method=RequestMethod.POST)  //여기 return 되는 거 다시 한 번 확인 필요
	 public String deleteShoppingCartList(@ModelAttribute("shoppingCart") ShoppingCart shoppingCart , Model model) throws Exception{
		
		System.out.println("shoppingCart deleteShoppingCartList :: POST"); 
		
		shoppingCartService.deleteShoppingCartList(shoppingCart.getShoppingCartNo()); //item.getItemNo 한 이유는 위에서 modelAttribugte가 "item"이라는 이름으로 Item 도메인에 값을 set 해 줌. 그냥 item이라고만 하면 그 중에서 itemNo를 가져올 수 없으므로 get적어주는 것. updateItem은 itemService.updateItem(item); 이거 가능. 왜냐면 updateItem의 parametertype이 item이고, 도메인 item의 전체 필드? 값?을 끌어다쓰므로 item이라고만 적어도 되는 것임. 
		
		return "redirect:/shoppingCart/getShoppingCartList?nickname="+shoppingCart.getNickname();    //redirect인데 delete니까 redirect:/item/getItem 이렇게만 넣어야 하나? update처럼 redirect:/item/getItem?itemNo="+item.getItemNo(); 이렇게 가져올 수 없음. 삭제가 되니까....
	}
 	*/
}


/*

 * 작성자 : 추경운
 * 작성일 : 2024-06-03
 *
package life.wewu.web.controller.group;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import life.wewu.web.common.Search;
import life.wewu.web.domain.group.Group;
import life.wewu.web.service.group.GroupService;

@Controller
@RequestMapping("/group/*")
public class GroupController {

   ///필드
   @Autowired
   @Qualifier("groupService")
   private GroupService groupService;

   public GroupController()
   {
      System.out.println(this.getClass());
   }
   
   @RequestMapping(value="getGroup",method = RequestMethod.POST) //requestmapping service 같은 역할 함. 
   public ModelAndView getGroup(@RequestParam("groupNo") int groupNo) throws Exception 
   {
      System.out.println(":: /group/getGroup ::");
      System.out.println("groupNo = " + groupNo);
      // Business logic 수행
      ModelAndView model = new ModelAndView("forward:/group/getGroup.jsp");
      model.addObject("group", groupService.getGroup(groupNo));
      return model;
   }
}
*/
