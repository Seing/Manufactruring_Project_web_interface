<%-- �񰡵� �̷� �ۼ� --%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("euc-kr"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�񰡵� �̷� �ۼ�</title>

<script type="text/javascript">
function change_go(Write){         //�ۼ��� �� �ѱ��
	var line = form.Line.options[form.Line.selectedIndex].text;              //�Է��� ���ΰ� ������ ����
	var process = form.Process.options[form.Process.selectedIndex].text;
	var type = form.Type.options[form.Type.selectedIndex].value;
	var reporter = document.getElementById("Reporter").value
	var fixitman = document.getElementById("Fixitman").value
	var status = form.Status.options[form.Status.selectedIndex].text;
	var problem = form.Problem.options[form.Problem.selectedIndex].text;
	var solution = form.Solution.options[form.Solution.selectedIndex].text;
	var s_date = document.getElementById("Stop_d").value   
	var s_time = document.getElementById("Stop_t").value
	var re_date = document.getElementById("Restart_d").value   
	var re_time = document.getElementById("Restart_t").value
	var details = document.getElementById("Details").value
	window.open("Write_input.jsp?line="+line+"&process="+process+"&type="+type+"&status="+status+"&problem="+problem+"&solution="+solution+"&s_date="+s_date+"&s_time="+s_time+"&re_date="+re_date+"&re_time="+re_time+"&details="+details+"&reporter="+reporter+"&fixitman="+fixitman);
	}
</script>
</head>
<body>
<center><font size='3'><b> �񰡵� �̷� �ۼ�</b></font>

<TABLE border='0' width='600' cellpadding='0' cellspacing='0'>
	<tr>
		<td><hr size='1' noshade>
		</td>
	</tr>
</table>

<form Name ="form">

<%-- ���ΰ� ������ Select Box�� ����� DB�� �ִ� ���� ������ �ֱ����� �ҽ� --%>

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
				   String SQL_Status = "SELECT DISTINCT Code FROM Status_Code";          //������ �ߺ��� �����Ͽ� �������� ������
				   String SQL_Problem = "SELECT DISTINCT Code FROM Problem_Code";          //���ΰ��� �ߺ��� �����Ͽ� �������� ������
				   String SQL_Solution = "SELECT DISTINCT Code FROM Solution_Code";          //��ġ���� �ߺ��� �����Ͽ� �������� ������
				   
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
				   
				   rs = stmt.executeQuery(SQL_Status);
				   while(rs.next()){                 //���� �ڵ带 ������ ArrayList�� ����
					   Status = rs.getString("Code");
				       Status_array.add(Status);
				   }
				   
				   rs = stmt.executeQuery(SQL_Problem);
				   while(rs.next()){                 //���� �ڵ带 ������ ArrayList�� ����
					   Problem = rs.getString("Code");
					   Problem_array.add(Problem);
				   }
				   
				   rs = stmt.executeQuery(SQL_Solution);
				   while(rs.next()){                 //��ġ �ڵ带 ������ ArrayList�� ����
					   Solution = rs.getString("Code");
					   Solution_array.add(Solution);
				   }
%>
<%-- �񰡵� �̷� �ۼ� ���̺� --%>

<TABLE border='0' width='600' cellpadding='2' cellspacing='2'>

<%-- ���� --%>
	<tr>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>����</b></center></font>
		</td>
		<td>
			<select name = "Line">
				<%for(int i=0; i<Line_array.size(); i++){ %>
				<option value="i"><%=Line_array.get(i)%></option><%}%>
			</select>
		</td>
	</tr>
	
<%-- ���� --%>	
	<tr>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>����</b></center></font>
		</td>
		<td>
			<select name = "Process">
				<%for(int i=0; i<Process_array.size(); i++){ %>
				<option value="i"><%=Process_array.get(i)%></option><%}%>
			</select>
		</td>
	</tr>
	
<%-- �񰡵� ���� --%>	
	<tr>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>�񰡵� ����</b></center></font>
		</td>
		<td>
			<select name = "Type">
				<option value="1">��ü �񰡵�</option>
				<option value="2">���� �񰡵�</option>
				<option value="3">���� �񰡵�</option>
			</select>
		</td>
	</tr>

<%-- �Ű��� ��� --%>	
	<tr>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>�Ű��� ���</b></center></font>
		</td>
		<td>
			<input type='text' size='3' maxlength="6" id='Reporter'>
		</td>
	</tr>
	
<%-- ������ ��� --%>	
	<tr>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>������ ���</b></center></font>
		</td>
		<td>
			<input type='text' size='3' maxlength="6" id='Fixitman'>
		</td>
	</tr>
	
<%-- ���� --%>	
	<tr>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>����</b></center></font>
		</td>
		<td>
			<select name = "Status">
				<%for(int i=0; i<Status_array.size(); i++){ %>
				<option value="i"><%=Status_array.get(i)%></option><%}%>
			</select>
		</td>
	</tr>
	
<%-- ���� --%>	
	<tr>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>����</b></center></font>
		</td>
		<td>
			<select name = "Problem">
				<%for(int i=0; i<Problem_array.size(); i++){ %>
				<option value="i"><%=Problem_array.get(i)%></option><%}%>
			</select>
		</td>
	</tr>
	
<%-- ��ġ --%>	
	<tr>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>��ġ</b></center></font>
		</td>
		<td>
			<select name = "Solution">
				<%for(int i=0; i<Solution_array.size(); i++){ %>
				<option value="i"><%=Solution_array.get(i)%></option><%}%>
			</select>
		</td>
	</tr>
	
<%-- �ߴ� �ð� --%>	
	<tr>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>�ߴ� �ð�</b></center></font>
		</td>
		<td>
			<input type='date' id='Stop_d'>
			<input type='time' id='Stop_t'>
		</td>
	</tr>
	
<%-- �簡�� �ð� --%>	
	<tr>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>�簡�� �ð�</b></center></font>
		</td>
		<td>
			<input type='date' id='Restart_d'>
			<input type='time' id='Restart_t'>
		</td>
	</tr>
	
<%-- ���� ���� --%>	
	<tr>
		<td width='100' bgcolor='7ED2FF'>
			<font size='2'><center><b>���γ���</b></center></font>
		</td>
		<td>
			<input type='text' size='50' id='Details'>
		</td>
	</tr>
		<tr>
		<td colspan='2'><hr size='1' noshade>
		</td>
	</tr>
	
<%-- �̷� ��� --%>
	<tr>
		<td align='center' colspan='2' width='100%'>
		<table>
			<tr>
				<td width='100' align='center'>
					<input type='Reset' value='�ٽ� �ۼ�'>
				</td>
				<td width='100' align='center'>
					<input type='button' value='���' onclick="change_go(this.form);">
				</td>
				<td width='100' align='center'>
					<input type='button' value='�񰡵� �̷� ����Ʈ' onclick="location='List.jsp'">
				</td>
				<td width='100' align='center'>
					<input type='button' value="���� �޴�" onclick="location.href='Main.jsp';">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</TABLE>
</form>
</body>
</html>