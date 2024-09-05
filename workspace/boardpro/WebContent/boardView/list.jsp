<%@page import="com.google.gson.JsonElement"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="kr.or.ddit.board.vo.BoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	// controller에 저장된 값 꺼내기
	List<BoardVO> list = (List<BoardVO>)request.getAttribute("list");
	int startp = (Integer)request.getAttribute("startPage");
	int endp = (Integer)request.getAttribute("endPage");
	int totalp = (Integer)request.getAttribute("totalPage");
	
	JsonObject obj = new JsonObject();
	obj.addProperty("sp", startp);
	obj.addProperty("ep", endp);
	obj.addProperty("tp", totalp);
	// addproperty잖아, 추가하는거지, 그니까 앞에꺼는 이름 설정하는거고, 뒤는 값 넣는거지
	
	// toJson tree 는 gsonbuilder 안먹힘
	Gson gson = new Gson();
	JsonElement ellist = gson.toJsonTree(list);
	
	obj.add("datas", ellist);
	out.print(obj);
	out.flush();
	
	
	
	
	
	
	
	
	
	
	

%>