<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import = "shop.dao.*" %>
<%
//로그인 인증분기 하기
if(session.getAttribute("CustomerLogin") == null) {
    response.sendRedirect("/shop/customer/customerLoginForm.jsp");
    return;
 }
%>
<%

/*
1.id, newPw값 불러오기 //id는 세션에서 newPw는 pwHistory에서
2.pwhistory테이블에 비밀번호를 새로 추가하기
3. 서브쿼리를 사용, 비밀번호 변경 내역을 order by desc,
	첫 번째 행만 선택, 결과로 사용
4.다시 customerPage로 Redirect해주기
*/
	//1
	HashMap<String, Object> login = (HashMap<String, Object>)(session.getAttribute("CustomerLogin")); 
	String id = (String)(login.get("id"));
	//넘어온건지 확인
		System.out.println("여기는 pwHistoryAction에서 확인하는 " + id);
	
	
	//새로운 password넘어오는거 확인=>완료!
	String newPw = request.getParameter("newPw");
		System.out.println("여기는 pwHistoryAction에서 확인하는 " + newPw);

//history테이블에 newPw로 넣어주기~
	int history = CustomerDAO.historyPw(id, newPw); 
		System.out.println(history + "<==pwHistoryAction.jsp.history");
	//1나온거 확인
	
	if(history == 0){
		//추가실패한거임
		System.out.println("새로운 비밀번호 추가에 실패하였습니다.");
	
	}else{
		System.out.println("새로운 비밀번호 추가에 성공하셨습니다.");
	}
//기존 비밀번호를 새로운 비밀번호로 바꿔주기
	int changeNewPw = CustomerDAO.changePw(id);
		System.out.println(changeNewPw + "<==새 비밀번호로 변경끝");
		//디버깅값에 1들어오는거 확인!=>

//changeNewPw가 1이면 customerPage.jsp
//0이면 다시 pwHistory로 이동
	
	if(changeNewPw == 1)
		{//성공
			System.out.println("비밀번호 변경에 성공하였습니다");
			session.setAttribute("msg", "비밀번호 변경이 완료되었습니다!");
			response.sendRedirect("./customerPage.jsp");
		}else{//실패
			System.out.println("비밀번호 변경에 실패하였습니다");
			response.sendRedirect("./pwHistory.jsp");
		}

	

%>
