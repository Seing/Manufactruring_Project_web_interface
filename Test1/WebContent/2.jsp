<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("euc-kr"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�񰡵� ������ �м��ϱ�</title>
<script language='javascript' src='http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js'></script>
<script type="text/javascript">

function change_go(form){         //Select Box���� ������ ���ΰ� ���� �����͸� text_L, text_P ������ �ѱ�
	var s_date = document.getElementById("Start_d").value   
	var s_time = document.getElementById("Start_t").value
	var e_date = document.getElementById("end_d").value   
	var e_time = document.getElementById("end_t").value
	window.open("Problem_All_Line.jsp?s_date="+s_date+"&s_time="+s_time+"&e_date="+e_date+"&e_time="+e_time);
	}
</script>
</head>
<body>
<center><font size='3'><b>�񰡵� �̷� ������ �м�</b></font>

<form name="form">
<TABLE border='0' width='650' cellpadding='0' cellspacing='0'>
	<tr>
		<td><hr size='1' noshade>
		</td>
	</tr>
</table>

<table border='0' width='650' cellpadding='1' cellspacing='1'>
	<tr>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>�˻� �Ⱓ ����</b></center></font>
		</td>
		<td>
			<input type='date' id='Start_d'>
			<input type='time' id='Start_t'>
			<font size='3'>~</font>
			<input type='date' id='end_d'>
			<input type='time' id='end_t'>
		</td>
	</tr>
	<tr>
</table>
<TABLE border='0' width='650' cellpadding='0' cellspacing='0'>
	<tr>
		<td><hr size='1' noshade>
		</td>
	</tr>
</table>
<table border='0' width='650'>
	<tr>
		<td align="right">
		</td>
		<td align="right">
			<input type='button' value="�˻�" onclick="change_go(this.form);">
			<input type='button' value="���� �޴�" onclick="location.href='Main.jsp';">
		</td>
	</tr>
</table>
</form>
</body>
</html>