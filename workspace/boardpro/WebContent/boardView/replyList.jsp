<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.or.ddit.board.vo.ReplyVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	// controller에서 저장한 값 꺼내기 // controller에서 정한 이름 // 컨트롤러가 뭐냐고? 컨트롤러 패키지 아래 ReplyList.java 의 servlet 만들었잖아.
	List<ReplyVO> list = (List<ReplyVO>)request.getAttribute("list");

	// gson 사용할건데 예쁘게 만들기 위해서 사용
	Gson gson = new GsonBuilder().setPrettyPrinting().create();
	// gson 사용해서 list를 json으로 만들어주고, 그거를 스트링 객체에 담기
	String result = gson.toJson(list);
	
	// 보내주기
	out.print(result);
	out.flush();
	
	// board.js의 $.replyListServer의 success : res 의 res로 넘어가는 것
	// board.js의 $.replyListServer에서 path를 ReplyList.java로 보내기로 하고, 보낼 data를 board.jsp 에서 가져온것으로 세팅하고,
	// 타입을 get으로 만들고, 보내기, replyList에서 이 view 파일로 자료를 보내와서, 여기서 만들고, successㄹ 보내준것.

%>