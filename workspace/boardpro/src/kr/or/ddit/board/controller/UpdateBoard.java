package kr.or.ddit.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.board.vo.BoardVO;

@WebServlet("/UpdateBoard.do")
public class UpdateBoard extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		// 전송데이터 받기
		String reqData = StreamData.dataChange(request);
		// content, subject, writer, password, num, mail 
		
		// 자바 객체로 역직렬화
		Gson gson = new Gson();
		
		BoardVO vo = gson.fromJson(reqData, BoardVO.class);
		
		// service객체 얻기
		IBoardService service = BoardServiceImpl.getService();
		
		// service메소드 호출하기 - 결과값 받기
		int cnt = service.updateBoard(vo);
		
		// request에 저장
		request.setAttribute("result", cnt);
		
		// view페이지 이동
		request.getRequestDispatcher("/boardView/result.jsp").forward(request, response);
	}
}
