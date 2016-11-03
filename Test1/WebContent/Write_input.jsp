<%-- �񰡵� �̷� ��� DB�� ���� --%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<%
// �ۼ��� ������ �� ������ ����
String Line = request.getParameter("line");
String Process = request.getParameter("process");
String Type = request.getParameter("type");
String Reporter = request.getParameter("reporter");
String Fixitman = request.getParameter("fixitman");
String Status = request.getParameter("status");
String Problem = request.getParameter("problem");
String Solution = request.getParameter("solution");
String s_date = request.getParameter("s_date");
String s_time = request.getParameter("s_time");
String re_date = request.getParameter("re_date");
String re_time = request.getParameter("re_time");
String Details = request.getParameter("details");



Timestamp ts1 = Timestamp.valueOf(s_date+" "+s_time+":00");            //�ð��� Timestamp �������� ��ȯ      
Timestamp ts2 = Timestamp.valueOf(re_date+" "+re_time+":00");          //�ð��� Timestamp �������� ��ȯ      

//int Line_int = Integer.parseInt(Line);
//int Type_int = Integer.parseInt(Type);




// DB �����ϱ�
Class.forName("org.mariadb.jdbc.Driver");

Connection conn = DriverManager.getConnection("jdbc:mariadb://210.125.146.146:3306/DALAB","yura","1234");

PreparedStatement pstmt = null;

// �����͸� �ۼ��� �ð��� ���ϱ� 
Calendar dateIn = Calendar.getInstance();
String indate = Integer.toString(dateIn.get(Calendar.YEAR)) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.MONTH)+1) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.DATE)) + " ";
indate = indate + Integer.toString(dateIn.get(Calendar.HOUR_OF_DAY)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.MINUTE)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.SECOND));

// ������ �̿��Ͽ� ������ �� DB�� ����
String strSQL = "INSERT INTO List_ALL(Line, Process, Type, Reporter, Fixitman, Status, Problem, Solution, Stop, Restart, Details)";
strSQL = strSQL + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
pstmt = conn.prepareStatement(strSQL);
pstmt.setString(1, Line);
pstmt.setString(2, Process);
pstmt.setString(3, Type);
pstmt.setString(4, Reporter);
pstmt.setString(5, Fixitman);
pstmt.setString(6, Status);
pstmt.setString(7, Problem);
pstmt.setString(8, Solution);
pstmt.setTimestamp(9, ts1);
pstmt.setTimestamp(10, ts2);
pstmt.setString(11, Details);
pstmt.executeUpdate();

pstmt.close();
conn.close();

response.sendRedirect("List.jsp");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>DB�� ����</title>
</head>
<body>

</body>
</html>