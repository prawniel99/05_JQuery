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
import kr.or.ddit.board.vo.ReplyVO;

@WebServlet("/UpdateReply.do")
public class UpdateReply extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		// 전송데이터 받기 - reply = cont, renum 들어있음
		String reqData = StreamData.dataChange(request);
		// 이렇게 하면 {'renum' : 5 , 'cont' : '댓글내용적혀있음'} 이런식으로 직렬화 되어있는데 데이터가 들어있음.
		// board.js에서 댓글수정에서 JSON.stringify 해서 직렬화 해서 보냈음.
		// 그래서 이제 역직렬화
		Gson gson = new Gson();
		ReplyVO vo = gson.fromJson(reqData, ReplyVO.class);
		
		// servicer객체 얻기 // 인터페이스인 iboardservice 타입이고 boardserviceimpl 클래스 내 getservice 메소드 실행하기.
		IBoardService service = BoardServiceImpl.getService();
		
		// service 메소드 호출
		int cnt = service.updateReply(vo);
		
		// request에 저장
		request.setAttribute("result", cnt);
		
		// view페이지 이동
		request.getRequestDispatcher("/boardView/result.jsp").forward(request, response);
	}
}
