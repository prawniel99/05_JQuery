<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.or.ddit.prod.vo.ProdVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	// get saved value from controller
	ProdVO vo = (ProdVO)request.getAttribute("detail");
	
	// create json type response data - send to asynchronous process of Client - json serialization
	Gson gson = new GsonBuilder().setPrettyPrinting().create();
	
	String result = gson.toJson(vo);
	out.print(result);
	out.flush();
	
%>