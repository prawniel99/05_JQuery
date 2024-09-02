<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%

	// controller에서 저장한 값 꺼내기
	int cnt = (int)request.getAttribute("result");

	// cnt로 응답 데이터 생성
	if(cnt > 0) {
%>

		{
			"flag" : "가입성공"
		}
	
<%
	} else {
%>
		{
			"flag" : "가입실패"
		}
<%
	}
%>
