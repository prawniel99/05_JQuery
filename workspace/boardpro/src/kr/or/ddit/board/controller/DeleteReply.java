package kr.or.ddit.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.service.IBoardService;

@WebServlet("/DeleteReply.do")
public class DeleteReply extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		// 전송데이터 = renum 받기
		int renum = Integer.parseInt(request.getParameter("renum"));
		
		// service객체 얻기
		IBoardService service = BoardServiceImpl.getService();
		
		// service메소드 호출하기
		int cnt = service.deleteReply(renum);
		
		// request에 저장
		request.setAttribute("result", cnt);
		
		// view페이지 이동
		request.getRequestDispatcher("/boardView/result.jsp").forward(request, response);
	}
}
