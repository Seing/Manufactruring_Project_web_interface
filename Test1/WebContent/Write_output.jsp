<%-- �񰡵� �̷� ���� �� ���� --%>

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

//DB �����ϱ�
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

<center><font size='3'><b> ���� ���� </b></font>

<table border='0' width='800' cellpadding='0' cellspacing='0'>
	<tr>
		<td><hr size='1' noshade>
		</td>
	</tr>
</table>

<table border='0' width='800'>
	<tr>
		<td align='left'>
			<font size='2'> ���� : <%=Line%>  ���� : <%=Process%></font>
		</td>

	</tr>	
</table>

<table border='0' cellspacing=3 cellpadding=3 width='800'>
	<tr bgcolor='cccccc'>
		<td align='center'>
			<font size='3'><b> �񰡵� ���� ���� </b></font>
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
			<a href='Write.jsp'>[���� �ۼ�]</a>
			<a href='List.jsp'>[��� ����]</a>
		</td>
	</tr>
</table>

<%
}catch(SQLException e){
	out.print("SQL���� " + e.toString());
}catch(Exception ex){
	out.print("JSP���� " + ex.toString());
}finally{
rs.close();
pstmt.close();
conn.close();
}
%>
</body>
</html>