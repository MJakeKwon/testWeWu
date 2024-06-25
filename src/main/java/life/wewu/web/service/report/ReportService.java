package life.wewu.web.service.report;

import java.util.List;

import life.wewu.web.common.Search;
import life.wewu.web.domain.report.Report;

public interface ReportService {

	public Report addReport(Report report) throws Exception;
	
	public Report getReport(int reportNo) throws Exception;
	
	public List<Report> getReportList(Search search) throws Exception;
	
	public Report updateReport(Report report) throws Exception;
	
	public Report updateReportRslt(Report report) throws Exception;
	
	public void deleteReport(int reportNo) throws Exception;
}
