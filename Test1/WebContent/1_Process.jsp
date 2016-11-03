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
String region  =  request.getParameter("region");

Class.forName("org.mariadb.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mariadb://210.125.146.146:3306/DALAB","yura","1234");
Statement stmt = conn.createStatement();
ResultSet rs = null;

String Process = null;
ArrayList<String> Process_array = new ArrayList<String>();        //공정을 저장할 공간

String SQL = "SELECT DISTINCT Process FROM List_All Where Line  = \"" + region + "\"";          //라인값을 중복값 제거하여 가져오는 쿼리문

rs = stmt.executeQuery(SQL);
while(rs.next()){                 //라인 코드를 가져와 ArrayList에 저장
	   Process = rs.getString("Process");
       Process_array.add(Process);
}


out.println("<select name='sel2'>");
for(int i=0; i<Process_array.size(); i++){
	out.println("<option value='"+i+"'>"+Process_array.get(i)+"</option>");
}
out.println("</select>");
%>
</body>
</html>
