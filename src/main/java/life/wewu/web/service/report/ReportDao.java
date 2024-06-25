package life.wewu.web.service.report;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import life.wewu.web.common.Search;
import life.wewu.web.domain.report.Report;

@Mapper
public interface ReportDao {

	public void addReport(Report report) throws Exception;
	
	public Report getReport(int reportNo) throws Exception;
	
	public List<Report> getReportList(Search search) throws Exception;
	
	public void updateReport(Report report) throws Exception;
	
	public void deleteReport(int reportNo) throws Exception;
}
