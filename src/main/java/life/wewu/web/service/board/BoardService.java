package life.wewu.web.service.board;

import java.util.List;
import java.util.Map;

import life.wewu.web.common.Search;
import life.wewu.web.domain.board.Board;
import life.wewu.web.domain.board.BoardFile;
import life.wewu.web.domain.board.Bookmark;
import life.wewu.web.domain.board.Comment;
import life.wewu.web.domain.board.Donation;
import life.wewu.web.domain.board.Question;

public interface BoardService {
	
	/*
	 * BoardDao
	 */
	
	//Bookmark Dao
	public void addBookmark(Bookmark bookmark) throws Exception;
		
	public void deleteBookmark(int bookmarkNo) throws Exception;
		
	public List<Board> getBookmarkList(Map map) throws Exception;
		
	public int getBookmarkCnt(int boardNo) throws Exception;
		
	//BoardFile Dao
	public void addBoardFile(BoardFile boardFile) throws Exception;
		
	public void deleteBoardFile(int fileNo) throws Exception;
		
	public void updateBoardFile(BoardFile boardFile) throws Exception;
		
	public List<BoardFile> getBoardFileList(int boardNo) throws Exception;
		
	public int getBoardFile(int boardNo) throws Exception;
		
	//Comment Dao
	public void addComment(Comment comment) throws Exception;
		
	public void deleteComment(int commentNo) throws Exception;
		
	public void updateComment(Comment comment) throws Exception;
		
	public List<Comment> getCommentListByBoard(int boardNo) throws Exception;
		
	public List<Comment> getCommentListByNic(String commentNickName) throws Exception;
	
	public int getCommentCnt(int boardNo) throws Exception;
	
	//Board Dao
	public Board addBoard(Board board) throws Exception;
	
	public void deleteBoard(int boardNo) throws Exception;
		
	public void updateBoard(Board board) throws Exception;
		
	public int updateViews(int boardNo) throws Exception;
		
	public Board getBoard(int boardNo) throws Exception;
	
	public List<Board> getBoardList(Map map) throws Exception;
	
	public void updateCommentCntUp(int boardNo) throws Exception;
	
	public void updateCommentCntDown(int boardNo) throws Exception;
	
	public void updateBookmarkCntUp(int boardNo) throws Exception;
	
	public void updateBookmarkCntDown(int boardNo) throws Exception;
	
	/*
	 * DonationDao
	 */
	
	public void addDonation(Donation donation) throws Exception;
	
	public void deleteDonation(int payNo) throws Exception;
	
	public Donation getDonationById(int payNo) throws Exception;
	
	public List<Donation> getDonationList(String payType) throws Exception;

	
	/*
	 * QuestionDao
	 */
	
	public Question addQuestion(Question question) throws Exception;
	
	public void updateReply(Question question) throws Exception;
	
	public void deleteQuestion(int questoinNo) throws Exception;
	
	public void updateQuestion(Question question) throws Exception;
	
	public Question getQuestionById(int questionNo) throws Exception;
	
	public List<Question> getQuestionList(Map map) throws Exception;

	public int getTotalCount(Map<String, Object> map) throws Exception;
}
