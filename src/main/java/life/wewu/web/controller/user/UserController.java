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

    @RequestMapping(value="/login", method=RequestMethod.POST)
    public String login(@ModelAttribute("user") User user, HttpSession session) {
        System.out.println("/user/login : POST");

        try {
            // 로그인 서비스 호출
            User dbUser = userService.login(user);

            if (dbUser != null) {
                session.setAttribute("user", dbUser);
                session.setAttribute("isAdmin", "1".equals(dbUser.getRole()));
                System.out.println("로그인 성공: " + dbUser.getUserId());
                return "redirect:/index.jsp";
            } else {
                System.out.println("로그인 실패: 비밀번호 불일치 또는 사용자 없음");
                return "redirect:/user/loginView.jsp?error=login_failed";
            }
        } catch (IllegalArgumentException e) {
            // 유효하지 않은 사용자 정보 예외 처리
            System.out.println("유효하지 않은 사용자 정보: " + e.getMessage());
            return "redirect:/user/loginView.jsp?error=invalid_user";
        } catch (Exception e) {
            // 일반 예외 처리
            System.out.println("로그인 중 예외 발생: " + e.getMessage());
            return "redirect:/user/loginView.jsp?error=unexpected_error";
        }
    }


    
	@RequestMapping( value="/logout", method=RequestMethod.GET )
	public String logout(HttpSession session ) throws Exception{
		
		System.out.println("/user/logout : POST");
		
		session.invalidate();
		
		return "redirect:/user/loginView.jsp";
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
		
		return "redirect:/user/loginView.jsp";
	}
	
	@RequestMapping( value="map", method=RequestMethod.GET )
	public String goMap( ) throws Exception {

		System.out.println("/user/goMap : POST");
		//Business Logic
		
		return "redirect:/user/map.jsp";
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
	        model.addAttribute("user", user);

	        return "forward:/user/myInfo.jsp"; // 뷰 이름 반환
	    }
	 
	 //listUser (admin)에서 유저상세정보 보기
		@RequestMapping( value="/getUser", method=RequestMethod.GET )
		public String getUser( @RequestParam("userId") String userId , Model model ) throws Exception {
			
			System.out.println("/user/myInfo : GET");
			//Business Logic
			User user = userService.getUser(userId);
			// Model 과 View 연결
			model.addAttribute("user", user);
			
			return "forward:/user/myInfo.jsp";
		}
	//내정보 조회페이지에서 비번입력하면 내정보수정페이지로 이동
//		@PostMapping("/checkPassword")
//		public String checkPassword(@RequestParam("userId") String userId, 
//		                            @RequestParam("password") String password, 
//		                            Model model) throws Exception {
//
//		    System.out.println("/user/checkPassword : POST");
//
//		    User user = userService.getUser(userId);
//		    if (user != null && user.getUserPwd().equals(password)) {
//		        model.addAttribute("user", user);
//		        return "forward:/user/myInfoView.jsp?userId=" + userId;
//		    } else {
//		        model.addAttribute("error", "유효하지 않은 비밀번호 입니다. 다시 입력하세요.");
//		        return "forward:/user/myInfo.jsp";
//		    }
//		}
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
		            model.addAttribute("user", user);
		            return "forward:/user/myInfoView.jsp?userId=" + userId;
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
	    model.addAttribute("user", updatedUser);

	    return "/user/myInfo";  // 수정된 유저 정보를 보여주는 JSP 페이지로 리다이렉트
	}

	


	@RequestMapping( value="listUser" )
	public String listUser( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/user/listUser : GET / POST");
		int pageSize =3;
		int pageUnit=5;
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
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
}