<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
    p {
        font-size: 2.0rem;
    }
</style>

<%-- 이게 JSP 주석. HTML을 하나도 쓰면 안되기 때문에 이 주석 사용해야함 --%>

<% // 여기는 back단이고, 여기서 처리한거를 아래 p 있고 저 front 쪽만 보이고 저기에 작업이 보여짐.

	request.setCharacterEncoding("UTF-8");

    // name, tel 입력한(전송) 값 받기
    String userName = request.getParameter("name");
    String userTel = request.getParameter("tel");

    // 전송된 값으로 db연결하여 CRUD 처리를 한다.
    // 처리된 결과를 가지고 응답 페이지를 생성한다 - text, html, xml, json 등으로 생성 가능. 가장 많이 쓰는건 json.

%>

<p>이름: <%= userName %></p>
<p>전화번호: <%= userTel %></p>
