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

@WebServlet("/InsertBoard.do")
public class InsertBoard extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String reqData = StreamData.dataChange(request);
		// {"writer" : "김은대" , "subject" : "sdf"} // 이런 방식으로 오는거 // board.jsp에다가 써놨지? {키: '벨류', 키: '벨류, ..}
		// 이거 왜 하냐고? 서버! board.jsp는 회원이 보는 화면! 클라이언트인거고
		// 그거랑 이 servlet으로 연결하는건 클라랑 서버를 연결하는거잖아. 거기서 데이터를 전송하기 위해서, json을 사용한거지
		// 그러니 이제 역직렬화 해줘야지
		
		// 자바객체로 역직렬화 - BoardVO
		Gson gson = new Gson();
		BoardVO vo = gson.fromJson(reqData, BoardVO.class);
		// vo.setWriter('김은대'), mail, subject, password, content 이렇게 키와 값들을 담은 전체 데이터가 넘어온거
		
		// 
		vo.setWip(request.getRemoteAddr());
		// 이거 뭐임?
		
		// service객체 얻기
		IBoardService service = BoardServiceImpl.getService();
		
		// service메소드 호출. 지금 하는게 게시글작성이니까 insertBoard // 오옹 insertBoard라는거 service랑 dao에 이미 만들어뒀네? 언제 만들었지! ㅋㅋ
		int cnt = service.insertBoard(vo);
		
		// 결과값 - result
		request.setAttribute("result", cnt);
		
		// view 페이지로 이동
		request.getRequestDispatcher("/boardView/result.jsp").forward(request, response);
	}
}
