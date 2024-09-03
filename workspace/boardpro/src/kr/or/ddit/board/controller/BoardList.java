package kr.or.ddit.board.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.PListVO;
import kr.or.ddit.board.vo.PageVO;

@WebServlet("/BoardList.do")
public class BoardList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		// 전송데이터 가져오기 - 페이지번호, stype, sword
		String reqData = StreamData.dataChange(request);
		// {"page" : "1", "stype" : "" , "sword" : ""} // 이런식으로 데이터가 올 것
		
		// 역직렬화 - PListVO - json 형식을 자바객체 형식으로 변환
		Gson gson = new Gson();
		PListVO vo = gson.fromJson(reqData, PListVO.class);
		// vo.setPage(1) vo.setStype("") vo.setSword("")
		
		// service 객체 얻기
		IBoardService service = BoardServiceImpl.getService();
		
		// list를 가져오기 위한 page 정보 가져오기
		PageVO pvo = service.pageInfo(vo.getPage(), vo.getStype(), vo.getSword());
		// start, end, startPage, endPage, totalPage
		
		// list 가져오기
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", pvo.getStart());
		map.put("end", pvo.getEnd());
		map.put("stype", vo.getStype());
		map.put("sword", vo.getSword());
		
		// list 가져오기 - 메소드 호출
		List<BoardVO> list = service.selectBoardList(map);
		
		// 결과값을 requst에 저장
		request.setAttribute("list", list);
		request.setAttribute("startPage", pvo.getStartPage());
		request.setAttribute("endPage", pvo.getEndPage());
		request.setAttribute("totalPage", pvo.getTotalPage());
		
		// view 페이지로 이동
		request.getRequestDispatcher("/boardView/list.jsp").forward(request, response);
		
	}
}
