<%@page import="kr.or.ddit.lprod.vo.LprodVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.mybatis.config.MybatisUtil"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%

	// get the transferred data
	
	
	// get SqlSession using MyBatisUtil to execute the sql query from mapper file
	SqlSession sql = MybatisUtil.getSqlSession();

	// execute mapper. it means you execute the sql query. you already constructed sql sentence there, remember? yeah.
	List<LprodVO> list = sql.selectList("lprod.getAllLprod");

	// to create the response data as a json data type
	// store the value and forward(send) to view page
	request.setAttribute("data", list);
	
	RequestDispatcher disp = request.getRequestDispatcher("/제품리스트/lprodView.jsp");
	
	disp.forward(request, response);
	
%>