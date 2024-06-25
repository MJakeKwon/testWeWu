package life.wewu.web.service.pay;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import life.wewu.web.common.Search;
import life.wewu.web.domain.pay.Pay;

@Mapper
public interface PayDao {

	public void addPointCharge(Pay pay) throws Exception;

	public void deletePointCharge(int payNo) throws Exception;

	public Pay getPointCharge(int payNo) throws Exception;

	public List<Pay> getPointChargeList(Search search) throws Exception;

	public void updatePointCharge(Pay pay) throws Exception;
}
