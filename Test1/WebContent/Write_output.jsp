<%-- 비가동 이력 내용 상세 보기 --%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

<%
String num = request.getParameter("num");

//DB 연결하기
Class.forName("org.mariadb.jdbc.Driver");

Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mf","root","1351qetq");

PreparedStatement pstmt = null;
ResultSet rs = null;

try{
	String strSQL = "SELECT * FROM List_test WHERE num = ?";
	pstmt = conn.prepareStatement(strSQL);
	pstmt.setInt(1, Integer.parseInt(num));
	
	rs = pstmt.executeQuery();
	rs.next();
	
	String Line = rs.getString("Line");
	String Process = rs.getString("Process");
	String Details = rs.getString("Details");
%>

<center><font size='3'><b> 세부 내역 </b></font>

<table border='0' width='800' cellpadding='0' cellspacing='0'>
	<tr>
		<td><hr size='1' noshade>
		</td>
	</tr>
</table>

<table border='0' width='800'>
	<tr>
		<td align='left'>
			<font size='2'> 라인 : <%=Line%>  공정 : <%=Process%></font>
		</td>

	</tr>	
</table>

<table border='0' cellspacing=3 cellpadding=3 width='800'>
	<tr bgcolor='cccccc'>
		<td align='center'>
			<font size='3'><b> 비가동 세부 내역 </b></font>
		</td>
	</tr>
</table>

<table border='0' cellspacing=5 cellpadding=10 width='800'>
	<tr bgcolor='ededed'>
		<td><font size='2' color=''><%=Details %></font>
		</td>
	</tr>
</table>

<table border='0' width='800' cellpadding='0' cellspacing='0'>
	<tr>
		<td><hr size='1' noshade>
		</td>
	</tr>
</table>

<table border='0' width='800'>
	<tr>
		<td align='right'>
			<a href='Write.jsp'>[내역 작성]</a>
			<a href='List.jsp'>[목록 보기]</a>
		</td>
	</tr>
</table>

<%
}catch(SQLException e){
	out.print("SQL에러 " + e.toString());
}catch(Exception ex){
	out.print("JSP에러 " + ex.toString());
}finally{
rs.close();
pstmt.close();
conn.close();
}
%>
</body>
</html>