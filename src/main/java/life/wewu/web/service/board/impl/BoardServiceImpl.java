package life.wewu.web.service.board.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import life.wewu.web.domain.board.Board;
import life.wewu.web.domain.board.BoardFile;
import life.wewu.web.domain.board.Bookmark;
import life.wewu.web.domain.board.Comment;
import life.wewu.web.domain.board.Donation;
import life.wewu.web.domain.board.Question;
import life.wewu.web.service.board.BoardDao;
import life.wewu.web.service.board.BoardService;
import life.wewu.web.service.board.DonationDao;
import life.wewu.web.service.board.QuestionDao;

@Service("boardService")
public class BoardServiceImpl implements BoardService{
	
	//
	@Autowired
	@Qualifier("boardDao")
	private BoardDao boardDao;
	
	@Autowired
	@Qualifier("questionDao")
	private QuestionDao questionDao;
	
	@Autowired
	@Qualifier("donationDao")
	private DonationDao donationDao;

	
	/*
	 * BoardDao
	 * - bookmark
	 */
	@Override
	public void addBookmark(Bookmark bookmark) throws Exception {
		boardDao.addBookmark(bookmark);
		
	}

	@Override
	public void deleteBookmark(int bookmarkNo) throws Exception {
		boardDao.deleteBookmark(bookmarkNo);		
	}

	@Override
	public List<Board> getBookmarkList(Map map) throws Exception {
		
		return boardDao.getBookmarkList(map);
	}

	@Override
	public int getBookmarkCnt(int boardNo) throws Exception {
		return boardDao.getBookmarkCnt(boardNo);
	}

	/*
	 * BoardDao
	 * - boardFilf
	 */
	@Override//
	public void addBoardFile(BoardFile boardFile) throws Exception {
		boardDao.addBoardFile(boardFile);
		
	}

	@Override//
	public void deleteBoardFile(int fileNo) throws Exception {
		boardDao.deleteBoardFile(fileNo);
		
	}

	@Override//
	public void updateBoardFile(BoardFile boardFile) throws Exception {
		boardDao.updateBoardFile(boardFile);
		
	}

	@Override//
	public List<BoardFile> getBoardFileList(int boardNo) throws Exception {
		return boardDao.getBoardFileList(boardNo);
	}

	@Override
	public int getBoardFile(int boardNo) throws Exception {
		return boardDao.getBoardFile(boardNo);
	}

	/*
	 * BoardDao
	 * - comment
	 */
	@Override
	public void addComment(Comment comment) throws Exception {
		boardDao.addComment(comment);
		
	}

	@Override
	public int getCommentCnt(int boardNo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.getCommentCnt(boardNo);
	}

	@Override//
	public void deleteComment(int commentNo) throws Exception {
		boardDao.deleteComment(commentNo);
		
	}

	@Override
	public void updateComment(Comment comment) throws Exception {
		boardDao.updateComment(comment);
		
	}

	@Override//
	public List<Comment> getCommentListByBoard(int boardNo) throws Exception {
		return boardDao.getCommentListByBoard(boardNo);
	}

	@Override
	public List<Comment> getCommentListByNic(String commentNickName) throws Exception {
		return boardDao.getCommentListByNic(commentNickName);
	}

	/*
	 * BoardDao
	 * - board
	 */
	@Override//
	public Board addBoard(Board board) throws Exception {
		boardDao.addBoard(board);
		board = boardDao.getBoard(board.getBoardNo());
		return board;		
	}

	@Override//
	public void deleteBoard(int boardNo) throws Exception {
		boardDao.deleteBoard(boardNo);
		
	}

	@Override//
	public void updateBoard(Board board) throws Exception {
		boardDao.updateBoard(board);
		
	}

	@Override//
	public int updateViews(int boardNo) throws Exception {
		return boardDao.updateViews(boardNo);
		
	}

	@Override//
	public Board getBoard(int boardNo) throws Exception {
		return boardDao.getBoard(boardNo);
	}

	@Override//
	public List<Board> getBoardList(Map map) throws Exception {
		return boardDao.getBoardList(map);
	}

	/*
	 * DonationDao
	 */
	
	@Override//
	public void addDonation(Donation donation) throws Exception {
		donationDao.addDonation(donation);
		
	}

	@Override//
	public void deleteDonation(int payNo) throws Exception {
		donationDao.deleteDonation(payNo);
		
	}

	@Override//
	public Donation getDonationById(int payNo) throws Exception {
		return donationDao.getDonationById(payNo);
	}

	@Override//
	public List<Donation> getDonationList(String payType) throws Exception {
		return donationDao.getDonationList(payType);
	}

	/*
	 * QuestionDao
	 */
	
	@Override//
	@Transactional
	public Question addQuestion(Question question) throws Exception {
		 questionDao.addQuestion(question);
		 
		 return questionDao.getQuestionById(question.getQuestionNo());
		
	}

	@Override
	@Transactional
	public void updateReply(Question question) throws Exception {
		questionDao.updateReply(question);
		
	}

	@Override
	@Transactional
	public void deleteQuestion(int questoinNo) throws Exception {
		questionDao.deleteQuestion(questoinNo);
		
	}

	@Override
	public void updateQuestion(Question question) throws Exception {
		questionDao.updateQuestion(question);
		
	}

	@Override
	public Question getQuestionById(int questionNo) throws Exception {
		return questionDao.getQuestionById(questionNo);
	}

	@Override
	public List<Question> getQuestionList(Map map) throws Exception {
		return questionDao.getQuestionList(map);
	}

	@Override
	public int getTotalCount(Map<String, Object> map) throws Exception{
		return boardDao.getTotalCount(map);
	}

	@Override
	public void updateCommentCntUp(int boardNo) throws Exception {
		boardDao.updateCommentCntUp(boardNo);
		
	}

	@Override
	public void updateCommentCntDown(int boardNo) throws Exception {
		boardDao.updateCommentCntDown(boardNo);
		
	}

	@Override
	public void updateBookmarkCntUp(int boardNo) throws Exception {
		boardDao.updateBookmarkCntUp(boardNo);
		
	}

	@Override
	public void updateBookmarkCntDown(int boardNo) throws Exception {
		boardDao.updateBookmarkCntDown(boardNo);
	}
	
}
