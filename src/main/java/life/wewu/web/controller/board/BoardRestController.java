package life.wewu.web.controller.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import life.wewu.web.common.Search;
import life.wewu.web.domain.board.Board;
import life.wewu.web.domain.board.Bookmark;
import life.wewu.web.domain.board.Comment;
import life.wewu.web.domain.board.Question;
import life.wewu.web.domain.user.User;
import life.wewu.web.service.board.BoardService;

@RestController
@RequestMapping(value = "/app/board/*")
public class BoardRestController {
	
	//필드
	@Autowired
	@Qualifier("boardService")
	private BoardService boardService;
	
	@PostMapping(value = "addBookmark")
	public String addBookmark (@RequestBody Bookmark bookmark ,HttpSession session) throws Exception{
		System.out.println("addBookmark");
		
		//session nullcheck
		//String sessioString = ((User)session.getAttribute("nickname")).getNickname();
		
		String flag="";
		
		try {
			System.out.println(":::::::::;;"+bookmark.getBoardNo());
			boardService.addBookmark(bookmark);
			//System.out.println("1");
			boardService.updateBookmarkCntUp(bookmark.getBoardNo());
			//System.out.println("2");
			flag="Y";
		}catch (Exception e) {
			Throwable cause = e.getCause();

		    System.out.println(e);
			flag = "N";
		}
		
		return "{\"flag\": \"" + flag + "\"}";
	}
	
	@PostMapping(value = "deleteBookmark")
	public String deleteBookmark(@RequestBody Map<String, Object> rslt,HttpSession session) throws Exception{
		System.out.println("deleteBookmark");
		//session nullcheck
		//String sessioString = ((User)session.getAttribute("nickname")).getNickname();
				
		String flag="";
				
		try {
			boardService.deleteBookmark((int)rslt.get("boardNo"));
			boardService.updateBookmarkCntDown((int)rslt.get("boardNo"));
			flag="Y";
		}catch (Exception e) {
			Throwable cause = e.getCause();

			System.out.println(e);
			flag = "N";
		}
						
		return "{\"flag\": \"" + flag + "\"}";
	}
	
	@PostMapping(value = "listBookmark")
	public List<Board> listBookmark(@RequestBody Map<String, Object> rslt ,HttpSession session) throws Exception{
		System.out.println("listBookmark");
		
		//String sessionString = ((User)session.getAttribute("nickname")).getNickname();
		int boardType = (int)rslt.get("baordType");
		
		return boardService.getBookmarkList(rslt);
	}
	
	/*
	 * Comment
	 */
	@PostMapping(value = "addComment")
	public Board addComment(@RequestBody Comment comment) throws Exception{
		System.out.println("addComment");
		
		boardService.addComment(comment);
		boardService.updateCommentCntUp(comment.getBoardNo());
		
		return boardService.getBoard(comment.getBoardNo());
	}
	
	@PostMapping(value = "deleteComment")
	public Board deleteComment(@RequestBody Map<String, Object> rslt) throws Exception{
		
		System.out.println("deleteComment");
		int boardNo = (int)rslt.get("boardNo");
		int commentNo = (int)rslt.get("commentNo");
		boardService.deleteComment(commentNo);
		boardService.updateCommentCntDown(boardNo);
		
		return boardService.getBoard(boardNo);
	}
	
	@PostMapping(value = "updateComment")
	public List<Comment> updateComment(@RequestBody Comment comment) throws Exception{
		
		System.out.println("updateComment");
		
		boardService.updateComment(comment);
		
		
		return boardService.getCommentListByBoard(comment.getBoardNo());		
	}
	
	@PostMapping(value = "getCommentListByNic")
	public List<Comment> getCommentListByNic(@RequestParam Board board,@RequestBody Comment comment,
			HttpSession session) throws Exception{
		
		System.out.println("getCommentListByNic");
		
		return boardService.getCommentListByNic(((User)session.getAttribute("nickname")).getNickname());		
	}
	
	@PostMapping(value = "getCommentListByBoard")
	public List<Comment> getCommentListByBoard(@RequestBody Map<String, Object> rslt) throws Exception{
		
		System.out.println("getCommentListByBoard");
		
		int boardNo = Integer.parseInt((String)rslt.get("boardNo"));
		
		// Business logic 수행
		
		return boardService.getCommentListByBoard(boardNo);
	}
}
