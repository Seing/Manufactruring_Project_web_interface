<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Main Menu</title>
<!-- 
<frameset cols="300,*" border=0>
<frameset rows="300,*" border=0>
<frame src="1.jsp" name="1">
</frameset>
<frame src="Problem.jsp" name="2">
</frameset>
-->
</head>
<body>
<center><font size='5'><b> 메인 메뉴 화면 </b></font><br><br>
<input type='button' value="비가동 이력 작성" onclick="location.href='Write.jsp';"><br><br>
<input type='button' value="전체 비가동 데이터 분석" onclick="location.href='Problem_All_Line.jsp';"><br><br>
<input type='button' value="라인/공정별 비가동 데이터 분석" onclick="location.href='1.jsp';">
</center>
</body>
</html>