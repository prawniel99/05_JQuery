<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	// controller에 저장한 값 가져오기
	MemberVO vo = (MemberVO)session.getAttribute("loginok"); // 이거는 session 왜 바로 사용 가능하다고?
	
	String check = (String)session.getAttribute("check"); // 형변환 왜 하지? 원래 뭐지? 위에도
	
	// json 형식으로 만들기 = 그 <% 이거 열고 닫고 하면서 flag 만드는거
	if(vo != null) {
%>

		<input id="id" type="text" placeholder="id">&nbsp;&nbsp;
		<input id="pass" type="password" placeholder="password">&nbsp;&nbsp;
		<button id="login" type="button">로그인</button><br>
		
<%	} else {  %>
		
		<span><%= vo.getMem_id() %>님 환영합니다</span>&nbsp;&nbsp;
		<button id="logout" type="button">로그아웃</button><br>
		
<%  }  %>