package life.wewu.web.controller.user;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import life.wewu.web.common.Page;
import life.wewu.web.common.Search;
import life.wewu.web.domain.user.User;
import life.wewu.web.service.user.UserService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kotlinx.serialization.Required;


@Controller
@RequestMapping("/user/*")
public class UserController {

    @Autowired
    private UserService userService;
    
    
	@RequestMapping( value="map", method=RequestMethod.GET )
	public String goMap( ) throws Exception {

		System.out.println("/user/goMap : POST");
		//Business Logic
		
		return "redirect:/user/map.jsp";
	}
    
    @RequestMapping(value="/login", method=RequestMethod.GET)
    public String showLoginPage(HttpSession session) {
        // 세션에서 유저 정보를 가져옴
        User user = (User) session.getAttribute("user");
        
        // 유저가 로그인 되어 있는지 확인
        if (user != null) {
            // 로그인 되어 있다면 메인 페이지로 리다이렉트
            return "redirect:/index.jsp";
        }
        
        // 로그인 되어 있지 않다면 로그인 페이지로 이동
        return "/user/loginView"; // login.jsp 페이지를 반환
    }

    
	@RequestMapping( value="/logout", method=RequestMethod.GET )
	public String logout(HttpSession session ) throws Exception{
		
		System.out.println("/user/logout : POST");
		
		session.invalidate();
		
		return "redirect:/user/loginView.jsp";
	}
	
    @PostMapping("/user/findUserId")
    public String findUserId(@RequestParam String userId, Model model) {
        model.addAttribute("userId", userId);
        return "user/findUserId";
    }
	
	@RequestMapping(value = "/findUserId", method =RequestMethod.GET)
	public String verification() throws Exception {
		
		System.out.println("/user/findUserId : GET");
		
		return "forward:/user/findUserIdView.jsp";
	}
	
	@RequestMapping(value = "/findPwd", method =RequestMethod.GET)
	public String findPwd() throws Exception {
		
		System.out.println("/user/findPwd : GET");
		
		return "forward:/user/findPwdView.jsp";
	}
	
	@PostMapping("/user/updatePwd")
    public String updatePwd(@RequestParam("userId") String userId,
                            @RequestParam(value = "newPassword" , required = false) String newPassword,
                            @RequestParam(value = "confirmPassword" , required = false) String confirmPassword,
                            Model model) {
			
        try {
            User user = userService.getUser(userId);
            if (user != null) {
                user.setUserPwd(newPassword);
                userService.updatePwd(user);
                return "redirect:/user/updatePwd.jsp";  // 성공 페이지로 리다이렉트
            }
            else {
                model.addAttribute("error", "사용자를 찾을 수 없습니다.");
                return "redirect:/user/updatePwdView?userId=" + userId;
            }
        } catch (Exception e) {
            model.addAttribute("error", "비밀번호 변경 중 오류가 발생했습니다.");
            return "redirect:/user/updatePwdView?userId=" + userId;
        }
    }
	
	@RequestMapping( value="/addUser", method=RequestMethod.GET )
	public String addUser() throws Exception{
		
		System.out.println("/user/addUser : GET");
		
		return "redirect:/user/addUserView.jsp";
	}
	
	@RequestMapping( value="addUser", method=RequestMethod.POST )
	public String addUser( @ModelAttribute("user") User user ) throws Exception {

		System.out.println("/user/addUser : POST");
		//Business Logic
		userService.addUser(user);
		
		return "redirect:/user/login";
	}
	 @PostMapping("/user/findPwd")
	    public String findPwd(@RequestParam String userId, Model model) {
	        model.addAttribute("userId", userId);
	        return "user/updatePwdView";
	    }
	
	//user 내정보조회페이지로 이동
	@GetMapping("/myInfo")
	public String myInfo(HttpSession session, Model model) throws Exception {
	 
	    System.out.println("/user/myInfo : GET");

	    User sessionUser = (User) session.getAttribute("user");
	    if (sessionUser == null) {
	        return "redirect:/user/loginView.jsp"; // 세션에 유저 정보가 없으면 로그인 페이지로 리디렉션
	    }
	    
	    String userId = sessionUser.getUserId();
	    User user = userService.getUser(userId);
	    model.addAttribute("viewedUser", user); // 'viewedUser' 속성으로 변경

	    return "forward:/user/myInfo.jsp"; // 뷰 이름 반환
	}

	 
	 //listUser (admin)에서 유저상세정보 보기
	 @RequestMapping(value = "/getUser", method = RequestMethod.GET)
	 public String getUser(@RequestParam("userId") String userId, Model model) throws Exception {
	     
	     System.out.println("/user/myInfo : GET");
	     // Business Logic
	     User user = userService.getUser(userId);
	     // Model 과 View 연결
	     model.addAttribute("viewedUser", user);  // 수정된 변수명
	     
	     return "forward:/user/myInfo.jsp";
	 }

	 @PostMapping("/checkPassword")
	 public String checkPassword(@RequestParam("userId") String userId, 
	                             @RequestParam(value = "password", required = false) String password, 
	                             HttpSession session,
	                             Model model) throws Exception {

	     System.out.println("/user/checkPassword : POST");

	     User user = userService.getUser(userId);
	     User loggedInUser = (User) session.getAttribute("user");

	     if (user != null && loggedInUser != null) {
	         boolean isAdmin = Boolean.TRUE.equals(session.getAttribute("isAdmin"));

	         if (isAdmin || (password != null && user.getUserPwd().equals(password))) {
	             model.addAttribute("viewedUser", user);
	             return "forward:/user/myInfoView.jsp";
	         } else {
	             model.addAttribute("error", "유효하지 않은 비밀번호 입니다. 다시 입력하세요.");
	             return "forward:/user/myInfo.jsp";
	         }
	     } else {
	         model.addAttribute("error", "사용자를 찾을 수 없습니다.");
	         return "forward:/user/myInfo.jsp";
	     }
	 }


	//myInfoView submit => myInfo
	 @RequestMapping(value = "update", method = RequestMethod.POST)
	 public String updateUser(@ModelAttribute("user") User user, Model model, HttpSession session) throws Exception {
	     
	     System.out.println("/user/updateUser : POST");
	     
	     // Business Logic: 유저 정보 수정
	     userService.updateUser(user);

	     // 수정된 유저 정보 조회
	     User updatedUser = userService.getUser(user.getUserId());

	     // 수정된 유저 정보를 모델에 담아 전달
	     model.addAttribute("viewedUser", updatedUser);

	     return "forward:/user/myInfo.jsp";  // 수정된 유저 정보를 보여주는 JSP 페이지로 리다이렉트
	 }


	
	@RequestMapping(value="listUser")
	public String listUser(@ModelAttribute("search") Search search, Model model, HttpServletRequest request) throws Exception {
	    System.out.println("/user/listUser : GET / POST");

	    int pageSize = 8;
	    int pageUnit = 5;
	    if (search.getCurrentPage() == 0) {
	        search.setCurrentPage(1);
	    }
	    search.setPageSize(pageSize);

	    // Start Row Num 계산
	    int startRowNum = (search.getCurrentPage() - 1) * pageSize;

	    // 검색 조건과 키워드 로깅
	    System.out.println("Search Condition: " + search.getSearchCondition());
	    System.out.println("Search Keyword: " + search.getSearchKeyword());
	    System.out.println("Start Row Num: " + startRowNum);

	    // Business logic 수행
	    Map<String, Object> map = userService.getUserList(search, startRowNum, pageSize);

	    // 결과 로깅
	    System.out.println("Total Count: " + map.get("totalCount"));
	    System.out.println("User List: " + map.get("list"));

	    Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
	    System.out.println(resultPage);

	    // Model 과 View 연결
	    model.addAttribute("list", map.get("list"));
	    model.addAttribute("resultPage", resultPage);
	    model.addAttribute("search", search);

	    return "forward:/user/listUser.jsp";
	}




	
    @PostMapping("/delete")
    public String deleteUser(@RequestParam("userId") String userId) throws Exception {
        
		System.out.println("/user/deleteUser : POST");
    	
    	userService.deleteUser(userId);
        
        return "redirect:/user/listUser";
    }
    
	@RequestMapping(value = "updateRole", method = RequestMethod.POST)
	public String updateRole(@ModelAttribute("user") User user, Model model) throws Exception {
		
	    System.out.println("/user/updateRole : POST");
	    
	    // Business Logic: 유저 정보 수정
	    userService.updateRole(user);

	    // 수정된 유저 정보 조회
	    User updateRole = userService.getUser(user.getUserId());

	    // 수정된 유저 정보를 모델에 담아 전달
	    model.addAttribute("user", updateRole);

	    return "redirect:/user/listUser";  // 수정된 유저 정보를 보여주는 JSP 페이지로 리다이렉트
	}

}