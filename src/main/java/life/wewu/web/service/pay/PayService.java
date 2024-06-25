package life.wewu.web.service.pay;

import java.util.List;

import life.wewu.web.common.Search;
import life.wewu.web.domain.pay.Pay;

public interface PayService {

	///필드

	///생성자

	///메소드
	public Pay addPointCharge(Pay pay) throws Exception;

	public Pay getPointCharge(int payNo) throws Exception;

	public List<Pay> getPointChargeList(Search search) throws Exception;

	public void deletePointCharge(int payNo) throws Exception;

	public void updatePointCharge(Pay pay) throws Exception;
}
