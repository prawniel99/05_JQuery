<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<style>
			h1 {
			  color: red;
			}
			
			p {
			  font-size: 1.2rem;
			}
			
			h1, p {
			  border: 3px solid lightblue;
			  margin: 10px;
			  padding: 50px;
			}
			
			.a {
			  text-align: center;
			}
		</style>
	</head>
	
	<body>
		<h1 class="a">JSP: Java Server Page</h1>
		<p class="a">HTML과 Java 코드를 같이 사용할 수 있다</p>
		<p>자바코드는 &lt;% %&gt; 기호 내부에 기술한다</p>
		<p>자바에서 처리한 결과를 출력하기 위해서는 &lt;%= %&gt; 기호 내부에 기술한다</p> 
		<p>Java 파트</p>
		
		<%
		
		// post 전송시  한글깨짐 방지
		request.setCharacterEncoding("UTF-8");
		
		// 입력한 id, name, pass를 가져온다 - request(요청) 객체 이용
		String userId = request.getParameter("id");
		String userName = request.getParameter("name");
		String userPass = request.getParameter("pass");
		
		// db에 저장되어 있는지 검사
		
		// 결과를 client에 응답한다 - response 객체 이용 - 출력할 내용을 만든다
		
		%>
		
		<!-- 자바에서 처리한 결과를 출력 - table, div -->
		
		<%= userId %> <br>
		<%= userName %> <br>
		<%= userPass %> <br>
		
		<!-- 자바에서 처리한 결과를 출력 -->
	</body>
</html>