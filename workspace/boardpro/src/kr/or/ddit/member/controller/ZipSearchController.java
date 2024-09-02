package kr.or.ddit.member.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.ZipVO;

@WebServlet("/ZipSearch.do")
public class ZipSearchController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ZipSearchController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		// 전송데이터 받기
		String dongvalue = request.getParameter("dong");
		
		// service 객체 얻기
		IMemberService service = MemberServiceImpl.getService();
		
		// service 메소드 호출 - 결과값 받기
		List<ZipVO> list = service.selectByDong(dongvalue);
		
		// request에 저장
		request.setAttribute("dong", list);
		
		// view 페이지로 이동
		request.getRequestDispatcher("/비동기6_ajax/dongList.jsp").forward(request, response); // view 는 jsp로 하고있는거야 지금! 확장자가 view가 아니야!
		
	}
}






























































































































