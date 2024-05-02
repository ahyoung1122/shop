<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*" %>
<%
	//입력할값들 가져오기 
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
		System.out.println(ordersNo + "<==myCommentOneAction.connemnt.ordersNo");
	
	String content = request.getParameter("content");
		System.out.println(content + "<==myCommentOneAction.connemnt");
		
	//comment를 comment테이블에 추가하기
	
	String starPoint = request.getParameter("starpoint");
		System.out.println(starPoint + "<==starpoint임");
	
		//starpoint value만큼 들어온거 확인됨.=>insert into로 테이블에 추가하자!
	
	//연결
	int comment = CommentDAO.addComment(ordersNo, starPoint, content);
		//디버깅확인 ->1들어온거랑 sql확인
		System.out.println(comment + "<==myCommentOneACtion.comment");
		
	if(comment == 1)
		{//추가성공
			response.sendRedirect("./myComment.jsp");
		
		}else
		{//추가실패
			response.sendRedirect("./myCommentOne.jsp");
		}
				
%>