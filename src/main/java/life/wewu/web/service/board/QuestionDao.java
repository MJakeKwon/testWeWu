package life.wewu.web.service.board;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import life.wewu.web.domain.board.Question;

@Mapper
public interface QuestionDao {
	
	public void addQuestion(Question question) throws Exception;
	
	public void updateReply(Question question) throws Exception;
	
	public void deleteQuestion(int questoinNo) throws Exception;
	
	public void updateQuestion(Question question) throws Exception;
	
	public Question getQuestionById(int questionNo) throws Exception;
	
	public List<Question> getQuestionList(Map map) throws Exception;
	
	public int getTotalCountQ(Map map)throws Exception;

}
