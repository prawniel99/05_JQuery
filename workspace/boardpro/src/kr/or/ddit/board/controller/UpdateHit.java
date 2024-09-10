package kr.or.ddit.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.service.IBoardService;

@WebServlet("/UpdateHit.do")
public class UpdateHit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		// 전송 데이터 num 이랑 vidx 가져오기. board.js에서 $.updateHitServer() 에서 온거임.
		int num = Integer.parseInt(request.getParameter("num"));
		
		// service객체 얻기. 지금 여기가 controller잖아. controller는 당연히 service로 가야지. 
		IBoardService service = BoardServiceImpl.getService();
		
		// service메소드 호출
		int cnt = service.updateHit(num);
		
		// request에 저장하기
		request.setAttribute("result", cnt);
		
		// view 페이지로 이동 // view는 jsp임. 위치가 다름. request에 map 처럼 "result"를 담은거. result를 꺼내면 cnt가 나오는거.
		request.getRequestDispatcher("/boardView/result.jsp").forward(request, response);
	}
}
