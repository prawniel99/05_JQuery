package kr.or.ddit.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;

/**
 * Servlet implementation class IdCheckController
 */
@WebServlet("/IdCheck.do")
public class IdCheckController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IdCheckController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 전송 데이터 받기 - id
		String userId = request.getParameter("id");
		
		// service 객체 얻기
		IMemberService service = MemberServiceImpl.getService();
		
		// service 메소드 호출 - 결과값 얻기
		String resId = service.idCheck(userId);
		
		// request에 결과값 저장
		request.setAttribute("id", resId);
		
		// view 페이지로 이동
		request.getRequestDispatcher("/member/idCheck.jsp").forward(request, response);
		
	}

}

















































































































































