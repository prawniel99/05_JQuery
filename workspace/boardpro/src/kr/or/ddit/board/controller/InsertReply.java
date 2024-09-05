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

@WebServlet("/InsertReply.do")
public class InsertReply extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		// 전송데이터 받기 // streamdata이거는 일반 클래스고 servlet아님. 그래서 request로 받아서 넘겨줘야 함.
		String reqData = StreamData.dataChange(request);
		
		// 역직렬화 - 자바 객체로
		Gson gson = new Gson();
		ReplyVO rvo = gson.fromJson(reqData, ReplyVO.class);
		
		// service 객체 얻기
		IBoardService service = BoardServiceImpl.getService();
		
		// service 메소드 호출 - 결과값
		int cnt = service.insertReply(rvo);
		
		// request에 결과값을 저장
		// list로 받으면 controller에서 꺼내기가 있어서 안됨.
		// 흠.. 무슨 말이지,
		// jsp로 보내는게 아니라, 이미 만들어둔 boardList.do 여기로 보내서 나오도록 한다는 말이다.
		// jsp로 바로 가도록 하는게 흔히 하는 실수라고 한다.
		// 동기 방식으로 뺐으면,.. 동기방식. 동기 비동기.
		// 지금 비동기라서 바로 보내면 안됨
		// response.sendRedirect("list.jsp"); // 이런식으로 하면 안되는거.
		request.setAttribute("result", cnt);
		
		// view 페이지로 이동
		// 지금은 insert.jsp delete.jsp update.jsp 이런거 따로 안주고 하나로 만들어서 할 것
		// 서버 내에서 view한테 보내는거니까 redirect아니고 forward로 해야함
		request.getRequestDispatcher("/boardView/result.jsp").forward(request, response);
		
	}
}
