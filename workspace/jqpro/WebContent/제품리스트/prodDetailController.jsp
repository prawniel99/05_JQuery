<%@page import="kr.or.ddit.mybatis.config.MybatisUtil"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="kr.or.ddit.prod.vo.ProdVO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	// Receive transfered data {"prod_id" : "P100100003"}
	// two different methods
	// 1. parameter
	// 2. reader
	StringBuffer strbuf = new StringBuffer();
	String line = null;
	
	try{
		BufferedReader reader = request.getReader();
		while(true){
			line = reader.readLine();
			if(line==null) break;
			strbuf.append(line);
		}
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	String reqData = strbuf.toString();
	
	// Deserialize - into java object
	Gson gson = new Gson();
	ProdVO vo = gson.fromJson(reqData, ProdVO.class); // fromJson(스트링타입, 클래스타입) // 이렇게 되기 때문에, 위에서 string버퍼에서 string 으로 변경한것
	// vo.setProd_id("P1010000003");
	
	// get SqlSession value
	SqlSession sql = MybatisUtil.getSqlSession();
	
	// execute sql query - get value
	ProdVO pvo = sql.selectOne("prod.prodDetail", vo.getProd_id());
	
	// save result value into request - to share it to view page
	request.setAttribute("detail", pvo);
	
	// move to view page
	RequestDispatcher disp = request.getRequestDispatcher("/제품리스트/prodDetailView.jsp");
	disp.forward(request, response);
	
	// prodDetail
%>