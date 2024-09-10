<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	// controller에서 저장한 값 꺼내기 // cnt가 1이면 쿼리가 실행이 됬다는 뜻! 아니면 0. 그러면 된거니까 ok를 하는거지.
	int cnt = (Integer)request.getAttribute("result");

	if(cnt > 0) {
%>
		{
			"flag" : "ok"
		}

<%  } else {  %>

		{
			"flag" : "no"
		}
		
<%	} %>
