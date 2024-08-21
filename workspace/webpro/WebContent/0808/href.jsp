<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>

        <style>
			h1 {
				color: red;
			}
            h3 {
                color: blue;
            }
		</style>

    </head>


    <body>


        <h1>JSP: Java Server Page</h1>

        <%
            String userName = request.getParameter("id");
        %>

        <h3><%= userName %>님 환영합니다</h3>



    </body>
</html>