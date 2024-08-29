<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.or.ddit.prod.vo.ProdVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	// get the saved vallue from controller
	List<ProdVO> list = (List<ProdVO>)request.getAttribute("prod");
	
	// Client - transfer the asynchronous part - serialize into json String
	Gson gson = new GsonBuilder().setPrettyPrinting().create();
	
	String result = gson.toJson(list);
	out.print(result);
	out.flush();

%>