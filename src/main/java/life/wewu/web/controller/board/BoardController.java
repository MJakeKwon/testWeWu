/*
 * 작성자 : 최지원
 * 작성일 : 2024-06-09
 */
package life.wewu.web.controller.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import life.wewu.web.common.Search;
import life.wewu.web.domain.board.Board;
import life.wewu.web.domain.board.BoardFile;
import life.wewu.web.domain.board.Bookmark;
import life.wewu.web.domain.board.Comment;
import life.wewu.web.domain.board.Donation;
import life.wewu.web.domain.board.Question;
import life.wewu.web.repository.S3Repository;
import life.wewu.web.service.board.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	//필드
	@Autowired
	@Qualifier("boardService")
	private BoardService boardService;
	
	@Autowired
	@Qualifier("s3RepositoryImpl")
	private S3Repository s3Repository;
	
	//메소드
	
	/*
	 * Board
	 */
	//게시글 등록 GET
	@GetMapping(value = "addBoard")
	public String addBoard(@RequestParam("boardType") int boardType) throws Exception{
		System.out.println("/board/addBoard : GET");
		
		return "forward:/board/addBoard.jsp?";
	}
	//게시글 등록 POST
	//게시글 등록 및 파일 등록(boardFile)
	//addBoard, addBoardFile
	@PostMapping(value = "addBoard")
	public String addBoard(@RequestParam("boardType") int boardType, @ModelAttribute("board") Board board,
			@ModelAttribute("boardFile") BoardFile boardFile,
			Model model, @RequestPart(required = false) MultipartFile file) throws Exception{
		
		System.out.println("/board/addBoard : POST");
		
		if(!file.isEmpty()) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("file", file);
			map.put("folderName", "board");
			
			String url = s3Repository.uplodaFile(map);
			
			boardFile.setFileName(s3Repository.getShortUrl(url));
		}
		
		board = boardService.addBoard(board);	//board 등록
		System.out.println("::::::::::;;"+board);
		boardFile.setBoardNo(board.getBoardNo());
		boardService.addBoardFile(boardFile);	//boardFile등록
		
		List<BoardFile> fileList = boardService.getBoardFileList(board.getBoardNo());	//boardfileList 출력
		
		board.setThumnail(boardService.getBoardFile(board.getBoardNo()));
		
		int boardNo = board.getBoardNo();
		System.out.println(boardNo);
		System.out.println(":::::::::::::::::::::"+fileList.size());
		
		model.addAttribute("board", boardService.getBoard(boardNo));
		model.addAttribute("boardFile", fileList);
		
		return "redirect:/board/getBoard?boardType="+boardType+"&boardNo="+boardNo;
	}
	
	//게시글 삭제 GET
	//게시글에 포함된 파일, 댓글, 즐겨찾기까지 모두 삭제
	@GetMapping(value = "deleteBoard") //?boardType=""&boardNo=0
	public String deleteBoard(@RequestParam("boardType") int boardType, @RequestParam("boardNo") int boardNo ) throws Exception{
		
		System.out.println("/board/deleteBoard?boardType"+ boardType +" : GET");
		
		
		boardService.deleteBoardFile(boardNo);
		
		boardService.deleteComment(boardNo);
		boardService.deleteBookmark(boardNo);
		
		boardService.deleteBoard(boardNo);
		
		return "forward:/board/listBoard?boardType="+boardType;
	}
	
	//게시글 수정 GET
	//게시글에 포함된 첨부파일 정보도 출력
	@GetMapping(value = "updateBoard") //?boardType=""&boardNo=0
	public String updateBoard(@RequestParam("boardType") int boardType, 
			@RequestParam("boardNo") int boardNo, Model model) throws Exception{
		System.out.println("/board/updateBoard : GET");
		
		Board board = boardService.getBoard(boardNo);
		List<BoardFile> fileList = boardService.getBoardFileList(boardNo);
		
		model.addAttribute("board", board);
		model.addAttribute("boardFile", fileList);
		
		return "forward:/board/updateBoard.jsp";
	}
	
	//게시글 수정 POST
	//게시글에 포함된 첨부파일도 수정
	@PostMapping(value = "updateBoard")
	public String updateBoard(@RequestParam("boardType") int boardType, 
			@RequestParam("boardNo") int boardNo,
			@ModelAttribute("board") Board board,
			@ModelAttribute("boardFile") BoardFile boardFile) throws Exception{
		System.out.println("/board/updateBoard : POST");
		
		boardService.updateBoard(board);
		//boardService.updateBoardFile(boardFile);
		
		return "redirect:/board/getBoard?boardType="+boardType+"&boardNo="+boardNo;
	}
	
	//게시글 상세 조회 GET
	//게시글에 포함된 첨부파일-조회, 댓글 리스트 조회
	@GetMapping(value = "getBoard")
	public String getBoard(@RequestParam("boardType") int boardType, 
			@RequestParam("boardNo") int boardNo, Model model)throws Exception{
		System.out.println("/board/getBoard : GET");
		
		Board board = boardService.getBoard(boardNo);
		
		boardService.updateViews(boardNo);
		
		List<BoardFile> boardFile = boardService.getBoardFileList(boardNo);
		
		List<Comment> commentList = boardService.getCommentListByBoard(boardNo);//
		
		model.addAttribute("board", board);
		model.addAttribute("comment", commentList);
		model.addAttribute("boardFile", boardFile);
		
		return "forward:/board/getBoard.jsp";
	}
	
	//게시글 목록 조회 GET	//////////////////////////////
	//댓글 수, 즐겨찾기 수..?
	@GetMapping(value = "listBoard")
	public String getBoardList(@RequestParam("boardType") int boardType,Model model) throws Exception{
		
		System.out.println("/board/listBoard : GET");
		
		Search search = new Search();
		search.setCurrentPage(1); // 0
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("boardType", boardType);
		
		List<Board> list = boardService.getBoardList(map);
		
		System.out.println("--lll"+list);
			
		model.addAttribute("list",list);
		
		return "forward:/board/listBoard.jsp";
	}

	/*
	 * Donation
	 */
	//후원 등록 GET
	@GetMapping(value = "addDonation")
	public String addDonation() throws Exception{
		System.out.println("/board/addDonation : GET");
		return "forward:/board/addDonation.jsp";
	}
	
	//후원 등록 POST
	@PostMapping(value = "addDonation")
	public String addDonation(@ModelAttribute("donation") Donation donation
			,Model model
			,@RequestParam("payType") String payType) throws Exception{
		System.out.println("/board/addDonation : POST");
		
		boardService.addDonation(donation);
		
		return "redirect:/board/getDonation?payType="+payType+"payNo="+donation.getPayNo();
	}
	
	//후원 내역 삭제 GET
	@GetMapping(value = "deleteDonation")//?payType=""&payNo=""
	public String deleteDonation(@RequestParam("payNo") int payNo
			,@RequestParam("payType")String payType) throws Exception{
		System.out.println("/board/deleteDonation : GET");
		boardService.deleteDonation(payNo);
		return "forward:/board/listDonation?payType="+payType;
	}
	
	//후원 내역 상세보기
	@GetMapping(value = "getDonation")
	public String getDonation(@RequestParam("payNo") int payNo
			,@RequestParam("payType")String payType,
			Model model) throws Exception{
		System.out.println("/board/getDonation : GET");
		
		Donation donation = boardService.getDonationById(payNo);
		
		model.addAttribute("donation", donation);
		
		return "forward:/board/getDonation.jsp";
	}
	
	//후원 내역 목록 보기
	@GetMapping(value = "listDonation")
	public String getDonationList(@RequestParam("payType")String payType,
			Model model) throws Exception{
		System.out.println("/board/getDonationList : GET");
		
		List<Donation> list = boardService.getDonationList(payType);
		System.out.println(":::::::::::::;"+list.size());
		model.addAttribute("list",list);
		return "forward:/board/listDonation.jsp";
	}
	
	/*
	 * Question 
	 */
	
	//문의 등록 GET
	@GetMapping(value = "addQuestion")
	public String addQuestion(@RequestParam("questionType")String questionType) throws Exception{
		
		System.out.println("/board/addQuestion : GET");
		
		return "forward:/board/addQuestion.jsp?questionType="+questionType;
	}
	
	//문의 등록 POST
	@PostMapping(value="addQuestion")
	public String addQuestion(@RequestParam("questionType")String questionType,
			@ModelAttribute("question")Question question) throws Exception{
		System.out.println("/board/addQuestion : POST");
		
		question = boardService.addQuestion(question);
		
		return "redirect:/board/getQuestion?questionType="+questionType+"&questionNo="+question.getQuestionNo();		
	}
	
	//문의 수정 GET
	@GetMapping(value = "updateQuestion")
	public String updateQuestion(@RequestParam("questionType")String questionType,
			@RequestParam("questionNo")int questionNo, Model model) throws Exception {
		System.out.println("/board/updateQuestion : GET");
		
		Question question = boardService.getQuestionById(questionNo);
		
		model.addAttribute("question", question);
		
		return "forward:/board/updateQuestion.jsp";
	}
	
	//문의 수정POST
	@PostMapping(value = "updateQuestion")
	public String updateQuestion(@RequestParam("questionType")String questionType,
			@RequestParam("questionNo")int questionNo,@ModelAttribute("question") Question question) throws Exception{
		
		System.out.println("/board/updateQuestion : POST");
		
		boardService.updateQuestion(question);
		
		return "redirect:/board/getQuestion?questionType="+questionType+"&questionNo="+question.getQuestionNo();
	}
	
	//문의 삭제 GET
	@GetMapping(value = "deleteQuestion")
	public String deleteQuestion(@RequestParam("questionType")String questionType,
			@RequestParam("questionNo")int questionNo) throws Exception{
		System.out.println("/board/deleteQuestion : GET");
		
		boardService.deleteQuestion(questionNo);
		
		return "forward:/board/listQuestion?questionType="+questionType;
	}
	
	//문의 상세 조회 GET
	@GetMapping(value = "getQuestion")
	public String getQeustion(Model model, @RequestParam("questionNo")int questionNo,@RequestParam("questionType")String questionType) throws Exception{
		System.out.println("/board/getQeustion : GET");
		
		Question question = boardService.getQuestionById(questionNo);
		
		model.addAttribute("question",question);
		
		return "forward:/board/getQuestion.jsp";
	}
	
	//문의 목록 조회 GET
	@GetMapping(value = "listQuestion")
	public String getQuestionList(@RequestParam("questionType")String questionType, Model model) throws Exception{
		
		System.out.println("/board/listQeustion : GET");
		
		Search search = new Search();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("questionType",questionType);
		//map.put("questionType", "문의");
		
		List<Question> list = boardService.getQuestionList(map);
		
		System.out.println("::::: "+map.get("questionType"));
		
		model.addAttribute("list", list);
		
		return "forward:/board/listQuestion.jsp";		
	}
	
	
	//답변 등록 및 변경 GET
	@GetMapping(value = "updateReply")
	public String updateReply(@RequestParam("questionType")String questionType,
			@RequestParam("questionNo")int questionNo,
			@ModelAttribute("question")Question question, Model model) throws Exception{
			
		System.out.println("/board/udpateReply : GET");
			
		question= boardService.getQuestionById(questionNo);
			
		model.addAttribute("question", question);
			
		return "forward:/board/updateReply.jsp";
	}
	
	
	//답변 등록 및 변경 POST
	@PostMapping(value = "updateReply")
	public String updateReply(@RequestParam("questionType")String questionType,
			@RequestParam("questionNo")int questionNo,
			@ModelAttribute("question")Question question) throws Exception{
		
		System.out.println("/board/udpateReply : POST");
		
		boardService.updateReply(question);
		
		return "redirect:/board/getQuestion?questionType="+questionType+"&questionNo="+question.getQuestionNo();
	}
	
	
	
	
	
	/*
	 * BoardFile
	 */
	//파일 등록
	 
	
	
	/*	
	public void addDonation(@ModelAttribute Donation donation)throws Exception
	{
		boardService.addDonation(donation);		
		
		this.goMail(donation);

		ModelAndView model = new ModelAndView();
		model.addObject("donation", donation);
		//return "~~~.jsp";
	}
	
	public void goMail(Donation donation)
	{
		//
	}
	*/
	
}
