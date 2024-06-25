package life.wewu.web.service.report.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import life.wewu.web.common.Search;
import life.wewu.web.domain.report.Report;
import life.wewu.web.service.report.ReportDao;
import life.wewu.web.service.report.ReportService;

@Service("reportService")
public class ReportServiceImpl implements ReportService{

	///필드
	@Autowired
	@Qualifier("reportDao")
	private ReportDao reportDao;
	
	///생성자
	
	///메소드
	public Report addReport(Report report) throws Exception {
		
		//Report 도메인을 인자로 신고정보를 insert
		reportDao.addReport(report);
		return report;
	}
	
	public Report getReport(int reportNo) throws Exception {
		
		//report pk를 인자로 해당 신고 정보를 select
		return reportDao.getReport(reportNo);
	}
	
	public List<Report> getReportList(Search search) throws Exception {
		
		//Search 도메인을 인자로 등록된 신고 내역을 select
		return reportDao.getReportList(search);
	}
	
	public Report updateReport(Report report) throws Exception {
		
		//Report 도메인을 인자로 해당 신고 정보를 update 후 다시 select
		reportDao.updateReport(report);
		return reportDao.getReport(report.getReportNo());
	}
	
	public Report updateReportRslt(Report report) throws Exception {
		
		//Report 도메인을 인자로 해당 신고 정보의 신고상태를 update 후 다시 select
		reportDao.updateReport(report);
		return reportDao.getReport(report.getReportNo());
	}
	
	public void deleteReport(int reportNo) throws Exception {
		
		//report pk를 인자로 해당 신고 정보를 delete
		reportDao.deleteReport(reportNo);
	}
}
