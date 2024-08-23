<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 주석 --%>

<%

	request.setCharacterEncoding("UTF-8");
	
	// 전송 데이터 받기
	String userName = request.getParameter("name");
	String userId = request.getParameter("id");
	
	// DB 연결해서 CRUD 처리, 결과값 얻기
	
	// 결과값으로 응답데이터 생성
	
%>

<%-- postTest.html에서 promise 수행시 1번 방식 = text형식 --%>
<p><%= userName %>님 환영합니다</p>
<p><%= userId %>님 으로 부를게요</p>

<%-- postTest.html에서 promise수행시 2번 방식 = JSON.parse() 후 사용하는 형식 --%>
<%--
{
	"name" : "<%= userName %>",
	"id" : "<%= userId %>"
}
--%>

<%-- 1번은 parse하면 오류, 2번은 parse 해야함 --%>