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
    var text_L = form.Line.options[form.Line.selectedIndex].text;
	var text_P = form.sel2.options[form.sel2.selectedIndex].text;
	var s_date = document.getElementById("Start_d").value   
	var s_time = document.getElementById("Start_t").value
	var e_date = document.getElementById("end_d").value   
	var e_time = document.getElementById("end_t").value
	window.open("Problem.jsp?text_L="+text_L+"&text_P="+text_P+"&s_date="+s_date+"&s_time="+s_time+"&e_date="+e_date+"&e_time="+e_time);
	}
	
function sub(){

	 var x = form.Line.value;
	 $.ajax({   
	  type: "POST",  
	  url: "1_Process.jsp",   
	  data: "region="+x,   //&a=xxx ������ �ڿ� �� ���̸� ��
	  success: result    //function result �� �ǹ���
	  });
}
function result(msg){
	 //sub()�� ����Ǹ� ��� ���� ������ �ͼ� action �� �����ִ� callback �Լ�
	 var sel  =  document.form.sel2;
	 $("#sp1").html(msg); //innerHTML �� �̷� ������� �����
	 //id �� $("#id")   name �� ��� $("name") ���� ������
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

<table border='0' width='650' cellpadding='1' cellspacing='1'>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>����</b></center></font>
		</td>
<%
					Class.forName("org.mariadb.jdbc.Driver");
					Connection conn = DriverManager.getConnection("jdbc:mariadb://210.125.146.146:3306/DALAB","yura","1234");
					Statement stmt = conn.createStatement();
					ResultSet rs = null;
					String Line, Process, Status, Problem, Solution = null;
					ArrayList<String> Line_array = new ArrayList<String>();           //���θ� ������ ����
					ArrayList<String> Process_array = new ArrayList<String>();        //������ ������ ����
					ArrayList<String> Status_array = new ArrayList<String>();         //������ ������ ����
					ArrayList<String> Problem_array = new ArrayList<String>();        //������ ������ ����
					ArrayList<String> Solution_array = new ArrayList<String>();       //��ġ�� ������ ����
					String SQL_Line = "SELECT DISTINCT Line FROM List_All";          //���ΰ��� �ߺ��� �����Ͽ� �������� ������
					String SQL_Process = "SELECT DISTINCT Process FROM List_All";       //�������� �ߺ��� �����Ͽ� �������� ������
				   
				   rs = stmt.executeQuery(SQL_Line);
				   while(rs.next()){                 //���� �ڵ带 ������ ArrayList�� ����
					   Line = rs.getString("Line");
				       Line_array.add(Line);
				   }
				   
				   rs = stmt.executeQuery(SQL_Process);
				   while(rs.next()){                 //���� �ڵ带 ������ ArrayList�� ����
					   Process = rs.getString("Process");
				       Process_array.add(Process);
				   }			   
%>
		<td>
			<select name = "Line" onchange="sub();">
			    <option value="">�����ϼ���</option>
				<%for(int i=0; i<Line_array.size(); i++){ %>
				<option value="<%=Line_array.get(i)%>"><%=Line_array.get(i)%></option>
				<%}%>
			</select>
		</td>
	</tr>
	<tr>
		<td width='100' bgcolor='7ED2FF' align = "left">
			<font size='2'><center><b>����</b></center></font>
		</td>
		<td>
			<span id="sp1">
				<select name="sel2">
					<option value="">�����ϼ���</option>	
				</select>
			</span>
		</td>
	</tr>
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