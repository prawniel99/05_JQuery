<%@page import="com.google.gson.JsonElement"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.or.ddit.prod.vo.ProdVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	// get the saved vallue from controller
	List<ProdVO> list = (List<ProdVO>)request.getAttribute("prod");

	// case when list value is empty - P401, P808..
	JsonObject obj = new JsonObject();
	
	if(list!=null && list.size()>0){ // if data exists
		
		
		obj.addProperty("flag", "ok");
		
		Gson gson = new Gson();
		JsonElement jele = gson.toJsonTree(list);
		obj.add("datas", jele);
	
		
	}else{ // if data doesn't exist
		obj.addProperty("flag", "no");
	}
	
	out.print(obj);
	out.flush();
	
	

%>