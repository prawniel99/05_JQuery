package kr.or.ddit.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVO;

@WebServlet("/insertMember.do")
public class InsertMember extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public InsertMember() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		
		// 전송데이터 받기
		String reqData = StreamData.dataChange(request);
		
		// 역직렬화 - MemberVO타입으로 
		Gson gson = new Gson();
		MemberVO vo = gson.fromJson(reqData, MemberVO.class);
		// vo.setMem_id("Korea") vo.setMem_name("김은대") 이런식
		
		// service 객체 얻기
		IMemberService service = MemberServiceImpl.getService();
		
		// service 메소드 호출 - 결과값 받기
		int cnt = service.insertMember(vo);
		
		// 비동기라서 요청한거 돌려줘야 해서 redirect 하면 안됨.
		//결과값을 저장
		request.setAttribute("result", cnt);
		
		// view 페이지로 이동 - 응답데이터 생성
		request.getRequestDispatcher("/비동기6_ajax/insert.jsp").forward(request, response);
		

	}

}
