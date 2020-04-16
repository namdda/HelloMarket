<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="User.UserDAO"%>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="User.UserDTO" scope="page"/>
<jsp:setProperty name="user" property="userId"/>
<jsp:setProperty name="user" property="userPass"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>세션페이지</title>
</head>
<body>
	<%
	String userID = null;
	if(session.getAttribute("userId") != null){
		userID = (String) session.getAttribute("userId");
	}
	if(userID != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습니다.')");
		script.println("location.href = '../main.jsp'");
		script.println("</script>"); 
	}
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(user.getUserId(), user.getUserPass());
	if(result==1){
		session.setAttribute("userId",user.getUserId());
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = '../Main.jsp'");
		script.println("</script>"); 
	}
	else if(result == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다.')");
		script.println("history.back()");
		script.println("</script>"); 
	}
	else if(result == -1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다.')");
		script.println("history.back()");
		script.println("</script>"); 
	}
	else if(result == -2){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.')");
		script.println("history.back()");
		script.println("</script>"); 
	}
	%>
</body>
</html>