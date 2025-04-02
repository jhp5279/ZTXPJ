package com.example.demo.service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.dto.RouteTimeDto;
import com.example.demo.dto.RoutesDto;
import com.example.demo.dto.SeatDto;
import com.example.demo.mapper.RoutesMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service("rs")
public class RoutesServiceImpl implements RoutesService {
	@Autowired
	private RoutesMapper mapper;
	public RoutesServiceImpl(JdbcTemplate jdbcTemplate) {
    }
	
	@Override
	public String routeSearch(@RequestParam String departure, @RequestParam String arrival,
			@RequestParam(required = false) String departureDate, @RequestParam(required = false) Integer resnum,
			@RequestParam(required = false) Integer charge, HttpSession session, Model model) {
		LocalDate today = LocalDate.now();
		String userid=(String)session.getAttribute("userid");
		
		if(userid==null) {
			return "redirect:/login/login";
		}
		else {
			List<RoutesDto> departingRoutes=mapper.findRoutes(departure, arrival, departureDate, resnum);
			
			model.addAttribute("today", today);
			model.addAttribute("routes", departingRoutes);
			model.addAttribute("resnum", resnum);
			model.addAttribute("charge", charge);
			// 검색 결과를 보여줄 JSP 파일로 이동
			return "routes/search";
		}
	}
	
	@Override
	public String resCheck(@RequestParam String routeid, @RequestParam String routeDeparture,
			@RequestParam String routeArrival, @RequestParam String routeTime,
			@RequestParam String routeArrivalTime, @RequestParam Integer resnum, // 선택된 인원
			@RequestParam(required = false, defaultValue = "") String[] goingSelectedSeats,
			@RequestParam Integer charge, HttpServletRequest request, HttpSession session, Model model) {
		
		// 가는편 정보를 모델에 추가
		model.addAttribute("routeid", routeid);
		model.addAttribute("routeDeparture", routeDeparture);
		model.addAttribute("routeArrival", routeArrival);
		model.addAttribute("routeTime", routeTime);
		model.addAttribute("routeArrivalTime", routeArrivalTime);
		model.addAttribute("resnum", resnum);
		model.addAttribute("charge", charge);
		session.setAttribute("routeid", routeid);
		model.addAttribute("goingSelectedSeats", goingSelectedSeats);
		
		return "routes/resCheck";
	}
	
	@Override
	public String showSeatSelection(int routeid, int resnum, int page, int size, Model model) {
		int offset = page * size;
		int totalseat=mapper.getTotalSeat(routeid);
		List<SeatDto> avaiSeats = mapper.getAvaiSeats(routeid, offset, size);
		
		int totalPages = (int) Math.ceil((double) totalseat / size);
		
		// 모델에 필요한 데이터 추가
		model.addAttribute("seats", avaiSeats);
		model.addAttribute("routeid", routeid);
		model.addAttribute("resnum", resnum);
		model.addAttribute("currentPage", page);
		model.addAttribute("pageSize", size);
		model.addAttribute("totalPages", totalPages);
		
		return "routes/seats";
	}
	
	@Override
	public String confirmSeats(@RequestParam int routeid, @RequestParam String selectedSeats,
			@RequestParam int resnum, HttpSession session, Model model) {
		String[] seatArray = selectedSeats.split(",");
		if (seatArray.length != resnum) {
			model.addAttribute("errorMessage", "선택한 좌석 수가 탑승객 수와 일치하지 않습니다.");
			return "routes/seats"; // 에러 메시지를 표시하고 좌석 선택 페이지로 돌아갑니다.
		}
		// 선택한 좌석과 탑승객 수 세션에 저장
		model.addAttribute("goingSelectedSeats", seatArray);  // 가는편 좌석 배열
		System.out.println("가는편 선택한 좌석: " + selectedSeats);
		return "redirect:/routes/resCheck?resnum=" + resnum;
	}
	
	@Override
	public int[] getRouteTime(String departure, String arrival) {
		RouteTimeDto RouteTimeDto = mapper.getRouteTime(departure, arrival);
		if(RouteTimeDto != null && RouteTimeDto.getRoutetime() != null) {
			LocalTime routeTime = RouteTimeDto.getRoutetime();
			int hours = routeTime.getHour();
			int minutes = routeTime.getMinute();
			int unitPrice=RouteTimeDto.getUnitprice();
			
			return new int[]{hours, minutes, unitPrice};
		}
		else {
			// Handle case where flight time is not found
			return new int[]{0, 0, 0};
		}
	}
	
	@Override
	public String routeList(@RequestParam(required=false, defaultValue="1") Integer page, Model model) {
		// 전달된 파라미터를 로그로 출력 (디버깅용)
		//System.out.println("Page Parameter: " + page);
		int itemsPerPage = 10;  // 페이지당 항목 수
		int offset = (page - 1) * itemsPerPage;
		
		List<RoutesDto> routeList = mapper.getRoutes(offset, itemsPerPage);
		int totalRoutes = mapper.countRoutes();
		
		// 전체 페이지 수 계산
		int totalPages = (int) Math.ceil((double) totalRoutes / itemsPerPage);
		
		// 모델에 항공편 데이터 추가
		model.addAttribute("routeList", routeList);
		model.addAttribute("currentPage", page);
		model.addAttribute("totalPages", totalPages);
		
		return "/routes/list";
	}
	

	
	
}
