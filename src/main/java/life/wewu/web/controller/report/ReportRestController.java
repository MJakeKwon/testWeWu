package life.wewu.web.controller.report;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import life.wewu.web.common.Search;
import life.wewu.web.domain.group.Group;
import life.wewu.web.domain.group.GroupMember;
import life.wewu.web.domain.report.Report;
import life.wewu.web.service.group.GroupService;
import life.wewu.web.service.report.ReportService;

@RestController
@RequestMapping("/app/report/*")
public class ReportRestController {

	///필드
	@Autowired
	@Qualifier("reportService")
	private ReportService reportService;
	
	public ReportRestController()
	{
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="addReport",method = RequestMethod.POST)
	public Report addReport(@RequestBody Report report) throws Exception 
	{
		System.out.println(":: /app/groupreport/addReport ::");
		// Business logic 수행
		reportService.addReport(report);
		return report;
	}
	
	@RequestMapping(value="getReportList",method = RequestMethod.POST)
	public List<Report> getReportList(Search search) throws Exception 
	{
		System.out.println(":: /app/report/getReportList ::");
		// Business logic 수행
		List<Report> list = reportService.getReportList(search);
		
		return list;
	}
	
	@RequestMapping(value="updateReport",method = RequestMethod.POST)
	public Report updateReport(@RequestBody Report report) throws Exception 
	{
		System.out.println(":: /app/report/updateReport ::");
		System.out.println(report);
		
		// Business logic 수행
		report = reportService.updateReport(report);
		
		return report;
	}
	
	@RequestMapping(value="deleteReport",method = RequestMethod.POST)
	public String deleteReport(@RequestBody Map<String, Object> rslt) throws Exception 
	{
		System.out.println(":: /app/report/deleteReport ::");
		// Business logic 수행
		String flag = "";
		int reportNo = Integer.parseInt((String)rslt.get("reportNo"));
		
		try {
			reportService.deleteReport(reportNo);
			flag = "Y";
		}catch(Exception e)
		{
			Throwable cause = e.getCause();

		    System.out.println(cause);
			flag = "N";
		}
		
		// JSON 형식의 응답 반환
        return "{\"flag\": \"" + flag + "\"}";
	}
}
