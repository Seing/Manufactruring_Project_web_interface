<%-- 비가동 이력 목록 DB에 저장 --%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<%
// 작성한 데이터 각 열별로 저장
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



Timestamp ts1 = Timestamp.valueOf(s_date+" "+s_time+":00");            //시간값 Timestamp 형식으로 변환      
Timestamp ts2 = Timestamp.valueOf(re_date+" "+re_time+":00");          //시간값 Timestamp 형식으로 변환      

//int Line_int = Integer.parseInt(Line);
//int Type_int = Integer.parseInt(Type);




// DB 연결하기
Class.forName("org.mariadb.jdbc.Driver");

Connection conn = DriverManager.getConnection("jdbc:mariadb://210.125.146.146:3306/DALAB","yura","1234");

PreparedStatement pstmt = null;

// 데이터를 작성한 시간값 구하기 
Calendar dateIn = Calendar.getInstance();
String indate = Integer.toString(dateIn.get(Calendar.YEAR)) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.MONTH)+1) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.DATE)) + " ";
indate = indate + Integer.toString(dateIn.get(Calendar.HOUR_OF_DAY)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.MINUTE)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.SECOND));

// 쿼리문 이용하여 데이터 값 DB에 저장
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
<title>DB에 저장</title>
</head>
<body>

</body>
</html>