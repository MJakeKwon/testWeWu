package life.wewu.web.controller.report;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import life.wewu.web.common.Search;
import life.wewu.web.domain.group.GroupAcle;
import life.wewu.web.domain.report.Report;
import life.wewu.web.service.group.GroupService;
import life.wewu.web.service.report.ReportService;

@Controller
@RequestMapping("/report/*")
public class ReportController {
	///필드
	@Autowired
	@Qualifier("reportService")
	private ReportService reportService;
	
	@Autowired
	@Qualifier("groupService")
	private GroupService groupService;
	
	public ReportController()
	{
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="addReport",method = RequestMethod.POST)
	public ModelAndView addReport(@RequestParam("targetNo") int targetNo,@RequestParam("reportType") String reportType) throws Exception 
	{
		System.out.println(":: /report/addGroup ::");
		// Business logic 수행
		
		ModelAndView model = new ModelAndView("forward:/report/addReport.jsp");
		
		if(reportType.equals("C")) {
			
			//댓글신고
			return model;
		}else 
		if(reportType.equals("B")) {
			//게시글 신고
			GroupAcle groupAcle = groupService.getGroupAcle(targetNo);
			
			model = new ModelAndView("forward:/report/addReport.jsp");
			model.addObject("groupAcle", groupAcle);
			model.addObject("reportType", reportType);
			model.addObject("targetNo", targetNo);
			return model;
		}else {
			//채팅신고
			return model;
		}
	}
	
	@RequestMapping(value="getReport",method = RequestMethod.POST)
	public ModelAndView getReport(@RequestParam("reportNo") int reportNo) throws Exception 
	{
		System.out.println(":: /report/getReport ::");
		// Business logic 수행
		Report report = reportService.getReport(reportNo);
		
		ModelAndView model = new ModelAndView("forward:/report/getReport.jsp");
		model.addObject("report", report);
		
		return model;
	}
	
	@RequestMapping(value="getReportList",method = RequestMethod.POST)
	public ModelAndView getReportList(Search search) throws Exception 
	{
		System.out.println(":: /report/getReportList ::");
		// Business logic 수행
		List<Report> list = reportService.getReportList(search);
		
		ModelAndView model = new ModelAndView("forward:/report/getReportList.jsp");
		model.addObject("list", list);
		
		return model;
	}
	
	@RequestMapping(value="updateReport",method = RequestMethod.POST)
	public ModelAndView updateReport(@RequestParam("reportNo") int reportNo) throws Exception 
	{
		System.out.println(":: /report/updateReport ::");
		// Business logic 수행
		Report report = reportService.getReport(reportNo);
		
		ModelAndView model = new ModelAndView("forward:/report/updateReport.jsp");
		model.addObject("report", report);
		
		return model;
	}
	
}
