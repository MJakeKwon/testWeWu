package life.wewu.web.service.board;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import life.wewu.web.common.Search;
import life.wewu.web.domain.board.Donation;
import life.wewu.web.domain.board.Question;

@Mapper
public interface DonationDao {
	
	public void addDonation(Donation donation) throws Exception;
	
	public void deleteDonation(int payNo) throws Exception;
	
	public Donation getDonationById(int payNo) throws Exception;
	
	public List<Donation> getDonationList(String payType) throws Exception;

}
