package life.wewu.web.service.pay.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import life.wewu.web.common.Search;
import life.wewu.web.domain.pay.Pay;
import life.wewu.web.service.pay.PayDao;
import life.wewu.web.service.pay.PayService;

@Service("payService")
public class PayServiceImpl implements PayService{

	///필드
	@Autowired
	@Qualifier("payDao")
	private PayDao payDao;

	///생성자

	///메소드
	@Override
	public Pay addPointCharge(Pay pay) throws Exception {

		//Pay 도메인을 인자로 현금 결제 내역을 insert
		payDao.addPointCharge(pay);
		return pay;
	}

	@Override
	public void deletePointCharge(int payNo) throws Exception {

		//Pay pk를 인자로 해당 결제 정보를 delete
		payDao.deletePointCharge(payNo);
	}

	@Override
	public Pay getPointCharge(int payNo) throws Exception {

		//pay pk를 인자로 해당 결제 정보를 select
		return payDao.getPointCharge(payNo);
	}

	@Override
	public List<Pay> getPointChargeList(Search search) throws Exception {

		//Search 도메인을 인자로 검색에 따른 결과를 select
		return payDao.getPointChargeList(search);
	}

	@Override
	public void updatePointCharge(Pay pay) throws Exception{
		payDao.updatePointCharge(pay);
	}
}
